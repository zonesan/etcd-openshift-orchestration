# $1 $2 $3 
# endpoints newnode initial-advertise-peer-urls 

echo "----->join" $2 "into" $1 "with" $3

export ETCDCTL_ENDPOINT=$1

echo "----->remove $2"
`etcdctl member remove $2 2>&1 |grep  "etcdctl member remove"`
sleep 5
echo "----->add $2 $3"
`etcdctl member add $2 $3|grep ETCD |awk '{print "export " $0}'`
sleep 5
echo "----->start etcd"
etcd -name $2 -initial-advertise-peer-urls $3 -listen-peer-urls http://0.0.0.0:2380 -listen-client-urls http://0.0.0.0:2379 -advertise-client-urls $1 


