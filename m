Return-Path: <netdev+bounces-270094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NnkDs/IvWkrBgMAu9opvQ
	(envelope-from <netdev+bounces-270094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:23:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA52E1BAC
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 23:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3BE63090208
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5EB3B9604;
	Fri, 20 Mar 2026 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="RnN6SoE6"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA816326D55;
	Fri, 20 Mar 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045130; cv=none; b=GpAfuu0TKWNSZNyMSe6e7cH6qv7CklV8AxUu20LnsqfQ3hyv5cuJgMV8Tuz/Sc0nE5/qiz561QK84zXsW2jzsiPYJAwojAQOIAOUGD03/gG/I5TJo0ZCZ2CmqCb620gbKIxqujXYMuSUwUkp59UJu2kJ/aVyRnvm2AlkH93PidI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045130; c=relaxed/simple;
	bh=5DscfbIutIjtx7crXF5BjeF/wS3xYQOMrXttMfzEJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6dbzM695ym42UPj4H+txJ83QWkwfueidseFBCyM2nzbkbQtMZnToRa6QJv/gk6flmkzkHLeCPon/iEfU7gqiG+d6dcPvmg2Zi+JB1aRjT2l2j7Hs4TmKlxRNosm0/sUzsGnx7vkpnBWYzczv9bGHJ0s4Y/rlBFaU5n2MC9iFN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=RnN6SoE6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kVzXYiQrwrj4PhOsX5uDlZduKVNzHZ0nrNQwRljZG5g=; b=RnN6SoE6gSRXOd2RXlTn0Ok+sL
	0sANcSdtAojlf4TMbmqcCOJQZVR/BwrgrHAdfXtHf3QYatR7seBdENbaleH54/+tKyNpdMLj60Jqk
	8YKsOtWLK7nwfk3JAJOYWemoK+cPVmyVeYD5kPg7aflid89C4FJvNlZgX5jWoi386IsK+CZCQ8sch
	GxXIaRHe7JrAJyjc1DPC/NAj2jGHwQ4rDRYNmlDzijidlQOfhTpThnQGb2JHkx7wigcsSp3Fks7cX
	huSunmxGDigFdGulxIglvUjzHx9yZcF+VhpHKo6X511WvOgwZVojejRYpOnm1/NZ33F/IZjKpKI2k
	ezyyzcGA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1w3iAe-000Gyz-02;
	Fri, 20 Mar 2026 23:18:20 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	razor@blackwall.org,
	pabeni@redhat.com,
	willemb@google.com,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	martin.lau@kernel.org,
	jordan@jrife.io,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	dw@davidwei.uk,
	toke@redhat.com,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: [PATCH net-next v9 03/14] net: Add lease info to queue-get response
Date: Fri, 20 Mar 2026 23:18:03 +0100
Message-ID: <20260320221814.236775-4-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320221814.236775-1-daniel@iogearbox.net>
References: <20260320221814.236775-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27946/Fri Mar 20 07:24:31 2026)
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270094-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,davidwei.uk:email,none:email]
X-Rspamd-Queue-Id: ABDA52E1BAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Populate nested lease info to the queue-get response that returns the
ifindex, queue id with type and optionally netns id if the device
resides in a different netns.

Example with ynl client when using AF_XDP via queue leasing:

  # ip a
  [...]
  4: enp10s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 xdp/id:24 qdisc mq state UP group default qlen 1000
    link/ether e8:eb:d3:a3:43:f6 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.2/24 scope global enp10s0f0np0
       valid_lft forever preferred_lft forever
    inet6 fe80::eaeb:d3ff:fea3:43f6/64 scope link proto kernel_ll
       valid_lft forever preferred_lft forever
  [...]

  # ethtool -i enp10s0f0np0
  driver: mlx5_core
  [...]

  # ynl --family netdev --output-json --do queue-get \
        --json '{"ifindex": 4, "id": 15, "type": "rx"}'
  {'id': 15,
   'ifindex': 4,
   'lease': {'ifindex': 8, 'netns-id': 0, 'queue': {'id': 1, 'type': 'rx'}},
   'napi-id': 8227,
   'type': 'rx',
   'xsk': {}}

  # ip netns list
  foo (id: 0)

  # ip netns exec foo ip a
  [...]
  8: nk@NONE: <BROADCAST,MULTICAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
      link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff
      inet6 fe80::200:ff:fe00:0/64 scope link proto kernel_ll
         valid_lft forever preferred_lft forever
  [...]

  # ip netns exec foo ethtool -i nk
  driver: netkit
  [...]

  # ip netns exec foo ls /sys/class/net/nk/queues/
  rx-0  rx-1  tx-0

  # ip netns exec foo ynl --family netdev --output-json --do queue-get \
        --json '{"ifindex": 8, "id": 1, "type": "rx"}'
  {"id": 1, "type": "rx", "ifindex": 8, "xsk": {}}

Note that the caller of netdev_nl_queue_fill_one() holds the netdevice
lock. For the queue-get we do not lock both devices. When queues get
{un,}leased, both devices are locked, thus if __netif_get_rx_queue_lease()
returns a lease pointer, it points to a valid device. The netns-id is
fetched via peernet2id_alloc() similarly as done in OVS.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Co-developed-by: David Wei <dw@davidwei.uk>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 include/net/netdev_rx_queue.h | 14 ++++++++
 net/core/netdev-genl.c        | 66 ++++++++++++++++++++++++++++++++---
 net/core/netdev_rx_queue.c    | 54 ++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index 1d41c253f0a3..7e98c679ea84 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -67,6 +67,20 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	return index;
 }
 
+enum netif_lease_dir {
+	NETIF_VIRT_TO_PHYS,
+	NETIF_PHYS_TO_VIRT,
+};
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
+			   enum netif_lease_dir dir);
+
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq);
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev);
+
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 void netdev_rx_queue_lease(struct netdev_rx_queue *rxq_dst,
 			   struct netdev_rx_queue *rxq_src);
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 7cfa479689f1..6ec48e212a24 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -386,12 +386,63 @@ static int nla_put_napi_id(struct sk_buff *skb, const struct napi_struct *napi)
 	return 0;
 }
 
+static int
+netdev_nl_queue_fill_lease(struct sk_buff *rsp, struct net_device *netdev,
+			   u32 q_idx, u32 q_type)
+{
+	struct net_device *orig_netdev = netdev;
+	struct nlattr *nest_lease, *nest_queue;
+	struct netdev_rx_queue *rxq;
+	struct net *net, *peer_net;
+
+	rxq = __netif_get_rx_queue_lease(&netdev, &q_idx,
+					 NETIF_PHYS_TO_VIRT);
+	if (!rxq || orig_netdev == netdev)
+		return 0;
+
+	nest_lease = nla_nest_start(rsp, NETDEV_A_QUEUE_LEASE);
+	if (!nest_lease)
+		goto nla_put_failure;
+
+	nest_queue = nla_nest_start(rsp, NETDEV_A_LEASE_QUEUE);
+	if (!nest_queue)
+		goto nla_put_failure;
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx))
+		goto nla_put_failure;
+	if (nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type))
+		goto nla_put_failure;
+	nla_nest_end(rsp, nest_queue);
+
+	if (nla_put_u32(rsp, NETDEV_A_LEASE_IFINDEX,
+			READ_ONCE(netdev->ifindex)))
+		goto nla_put_failure;
+
+	rcu_read_lock();
+	peer_net = dev_net_rcu(netdev);
+	net = dev_net_rcu(orig_netdev);
+	if (!net_eq(net, peer_net)) {
+		s32 id = peernet2id_alloc(net, peer_net, GFP_ATOMIC);
+
+		if (nla_put_s32(rsp, NETDEV_A_LEASE_NETNS_ID, id))
+			goto nla_put_failure_unlock;
+	}
+	rcu_read_unlock();
+	nla_nest_end(rsp, nest_lease);
+	return 0;
+
+nla_put_failure_unlock:
+	rcu_read_unlock();
+nla_put_failure:
+	return -ENOMEM;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
 {
 	struct pp_memory_provider_params *params;
-	struct netdev_rx_queue *rxq;
+	struct net_device *orig_netdev = netdev;
+	struct netdev_rx_queue *rxq, *rxq_lease;
 	struct netdev_queue *txq;
 	void *hdr;
 
@@ -409,17 +460,22 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 		rxq = __netif_get_rx_queue(netdev, q_idx);
 		if (nla_put_napi_id(rsp, rxq->napi))
 			goto nla_put_failure;
+		if (netdev_nl_queue_fill_lease(rsp, netdev, q_idx, q_type))
+			goto nla_put_failure;
 
+		rxq_lease = netif_get_rx_queue_lease_locked(&netdev, &q_idx);
+		if (rxq_lease)
+			rxq = rxq_lease;
 		params = &rxq->mp_params;
 		if (params->mp_ops &&
 		    params->mp_ops->nl_fill(params->mp_priv, rsp, rxq))
-			goto nla_put_failure;
+			goto nla_put_failure_lease;
 #ifdef CONFIG_XDP_SOCKETS
 		if (rxq->pool)
 			if (nla_put_empty_nest(rsp, NETDEV_A_QUEUE_XSK))
-				goto nla_put_failure;
+				goto nla_put_failure_lease;
 #endif
-
+		netif_put_rx_queue_lease_locked(orig_netdev, netdev);
 		break;
 	case NETDEV_QUEUE_TYPE_TX:
 		txq = netdev_get_tx_queue(netdev, q_idx);
@@ -437,6 +493,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 
 	return 0;
 
+nla_put_failure_lease:
+	netif_put_rx_queue_lease_locked(orig_netdev, netdev);
 nla_put_failure:
 	genlmsg_cancel(rsp, hdr);
 	return -EMSGSIZE;
diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index a1f23c2c96d4..a4d8cad6db74 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -41,6 +41,60 @@ bool netif_rxq_is_leased(struct net_device *dev, unsigned int rxq_idx)
 	return false;
 }
 
+/* Virtual devices eligible for leasing have no dev->dev.parent, while
+ * physical devices always have one. Use this to enforce the correct
+ * lease traversal direction.
+ */
+static bool netif_lease_dir_ok(const struct net_device *dev,
+			       enum netif_lease_dir dir)
+{
+	if (dir == NETIF_VIRT_TO_PHYS && !dev->dev.parent)
+		return true;
+	if (dir == NETIF_PHYS_TO_VIRT && dev->dev.parent)
+		return true;
+	return false;
+}
+
+struct netdev_rx_queue *
+__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq_idx,
+			   enum netif_lease_dir dir)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(orig_dev, *rxq_idx);
+
+	if (rxq->lease) {
+		if (!netif_lease_dir_ok(orig_dev, dir))
+			return NULL;
+		rxq = rxq->lease;
+		*rxq_idx = get_netdev_rx_queue_index(rxq);
+		*dev = rxq->dev;
+	}
+	return rxq;
+}
+
+struct netdev_rx_queue *
+netif_get_rx_queue_lease_locked(struct net_device **dev, unsigned int *rxq_idx)
+{
+	struct net_device *orig_dev = *dev;
+	struct netdev_rx_queue *rxq;
+
+	/* Locking order is always from the virtual to the physical device
+	 * see netdev_nl_queue_create_doit().
+	 */
+	netdev_ops_assert_locked(orig_dev);
+	rxq = __netif_get_rx_queue_lease(dev, rxq_idx, NETIF_VIRT_TO_PHYS);
+	if (rxq && orig_dev != *dev)
+		netdev_lock(*dev);
+	return rxq;
+}
+
+void netif_put_rx_queue_lease_locked(struct net_device *orig_dev,
+				     struct net_device *dev)
+{
+	if (orig_dev != dev)
+		netdev_unlock(dev);
+}
+
 /* See also page_pool_is_unreadable() */
 bool netif_rxq_has_unreadable_mp(struct net_device *dev, unsigned int rxq_idx)
 {
-- 
2.43.0


