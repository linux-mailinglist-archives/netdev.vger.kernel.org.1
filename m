Return-Path: <netdev+bounces-174883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B2A61205
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F85D882935
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49531FF1B8;
	Fri, 14 Mar 2025 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlIAwoCZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295A1FF1D2
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957611; cv=none; b=YAobIM3qxoocVT8UFj8rAdGwYi0QUeUByg95raazHRQmJpQz3N4ofTG9e+6pyS1yLilfq99lvsJT5sWfmpqpjpGk4drYmS5hnNM5ouN35gbVk0ZT/leWdv0JRXNfncKyJWvy6O80qMN8xq6MXDEBH2FaPSn8hflKrtr7TKC2v70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957611; c=relaxed/simple;
	bh=jYy2Pg04njPOBHLzT95et+3g5MqV0Dq90svkp19kIjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKcl6MFnlh6ZtQBOAPlAulTSqKmVQfeZ3AsnPYvYdMDERbhg3CflVXVi7NF5tMTVJ68Ra7ZWMjmkzlJP26LVkBCwGT85JtT0Hpr0Z/I/Yb474jeL4TJ+BXTG0IrEIZ/wRba1vv/Hpg3FwbMJwuU1tGQN2R0n/U3UTlSWrrC7IP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AlIAwoCZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741957608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PsttsgPxGewMwQJcusUe4q+az1uIHhnKFzfAqJrdfo=;
	b=AlIAwoCZTuSejWwBAVolE2SL4iruDaDE/eyXcOBgGcr5HG7yVoF9/0E8moA7vPYZ/gnxLY
	CocQ10N/khjRDSbOxBJUdk7wmOE6VtVl83PTzvBaMWXAUWwcnEZj23eU9Z8rxGK3y1LlEt
	HiIdkLERM6Jzc7zqBlLfVrvqpQ8nFAc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-0o_Qv2cQNpqnk1_JlaR48g-1; Fri,
 14 Mar 2025 09:06:45 -0400
X-MC-Unique: 0o_Qv2cQNpqnk1_JlaR48g-1
X-Mimecast-MFC-AGG-ID: 0o_Qv2cQNpqnk1_JlaR48g_1741957604
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD49019560B2;
	Fri, 14 Mar 2025 13:06:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FE631955BCB;
	Fri, 14 Mar 2025 13:06:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 2/2] net: hotdata optimization for netns ptypes
Date: Fri, 14 Mar 2025 14:05:01 +0100
Message-ID: <0f44b47dd83152000e35355e4f9096a72ead7b87.1741957452.git.pabeni@redhat.com>
In-Reply-To: <cover.1741957452.git.pabeni@redhat.com>
References: <cover.1741957452.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Per netns ptype usage is/should be an exception, but the current code
unconditionally touches the related lists for each RX and TX packet.

Add a per device flag in the hot data net_device section to cache the
'netns ptype required' information, and update it accordingly to the
relevant netns status. The new fields are placed in existing holes,
moved slightly to fit the relevant cacheline groups.

Be sure to keep such flag up2date when new devices are created and/or
devices are moved across namespaces initializing it in list_netdevice().

In the fast path we can skip per-netns list processing when such patch
is clear.

This avoid touching in the fastpath the additional cacheline needed by
the previous patch.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
This is a little cumbersome for possibly little gain. An alternative
could be caching even the per-device list status in similar
flags. Both RX and TX could use a single conditional to completely
skip all the per dev/netns list. Potentially even moving the per
device lists out of hotdata.

Side note: despite being unconditionally touched in fastpath on both
RX and TX, currently dev->ptype_all is not placed in any cacheline
group hotdata.
---
 .../networking/net_cachelines/net_device.rst  |  2 +
 include/linux/netdevice.h                     |  9 ++-
 net/core/dev.c                                | 58 ++++++++++++++-----
 3 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index 6327e689e8a84..206f4afded60c 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -22,7 +22,9 @@ struct list_head                    napi_list
 struct list_head                    unreg_list
 struct list_head                    close_list
 struct list_head                    ptype_all                   read_mostly                             dev_nit_active(tx)
+bool                                ptype_all_ns                read_mostly                             dev_nit_active(tx)
 struct list_head                    ptype_specific                                  read_mostly         deliver_ptype_list_skb/__netif_receive_skb_core(rx)
+bool                                ptype_specific_ns                               read_mostly         deliver_ptype_list_skb/__netif_receive_skb_core(rx)
 struct                              adj_list
 unsigned_int                        flags                       read_mostly         read_mostly         __dev_queue_xmit,__dev_xmit_skb,ip6_output,__ip6_finish_output(tx);ip6_rcv_core(rx)
 xdp_features_t                      xdp_features
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0dbfe069a6e38..031e3e42db4a6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1791,6 +1791,9 @@ enum netdev_reg_state {
  *	@close_list:	List entry used when we are closing the device
  *	@ptype_all:     Device-specific packet handlers for all protocols
  *	@ptype_specific: Device-specific, protocol-specific packet handlers
+ *	@ptype_all_ns:	The owning netns has packet handlers for all protocols
+ *	@ptype_specific_ns:	The owning netns has protocol-specific packet
+ *				handlers
  *
  *	@adj_list:	Directly linked devices, like slaves for bonding
  *	@features:	Currently active device features
@@ -2125,14 +2128,16 @@ struct net_device {
 		struct pcpu_dstats __percpu		*dstats;
 	};
 	unsigned long		state;
-	unsigned int		flags;
-	unsigned short		hard_header_len;
 	netdev_features_t	features;
 	struct inet6_dev __rcu	*ip6_ptr;
+	unsigned int		flags;
+	unsigned short		hard_header_len;
+	bool			ptype_all_ns;
 	__cacheline_group_end(net_device_read_txrx);
 
 	/* RX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_rx);
+	bool			ptype_specific_ns;
 	struct bpf_prog __rcu	*xdp_prog;
 	struct list_head	ptype_specific;
 	int			ifindex;
diff --git a/net/core/dev.c b/net/core/dev.c
index 00bdd8316cb5e..878122757c78b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -405,6 +405,12 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
+	/* update ptype flags according to the current netns setting */
+	spin_lock(&ptype_lock);
+	dev->ptype_all_ns = !list_empty(&net->ptype_all);
+	dev->ptype_specific_ns = !list_empty(&net->ptype_specific);
+	spin_unlock(&ptype_lock);
+
 	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
 	netdev_name_node_add(net, dev->name_node);
 	hlist_add_head_rcu(&dev->index_hlist,
@@ -587,6 +593,20 @@ static inline struct list_head *ptype_head(const struct packet_type *pt)
 				   &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
 }
 
+static void net_set_ptype(struct net *net, bool ptype_all, bool val)
+{
+	struct net_device *dev;
+
+	rcu_read_lock();
+	for_each_netdev_rcu(net, dev) {
+		if (ptype_all)
+			WRITE_ONCE(dev->ptype_all_ns, val);
+		else
+			WRITE_ONCE(dev->ptype_specific_ns, val);
+	}
+	rcu_read_unlock();
+}
+
 /**
  *	dev_add_pack - add packet handler
  *	@pt: packet type declaration
@@ -609,6 +629,9 @@ void dev_add_pack(struct packet_type *pt)
 
 	spin_lock(&ptype_lock);
 	list_add_rcu(&pt->list, head);
+	if (pt->af_packet_net && !pt->dev && list_is_singular(head))
+		net_set_ptype(pt->af_packet_net, pt->type == htons(ETH_P_ALL),
+			      true);
 	spin_unlock(&ptype_lock);
 }
 EXPORT_SYMBOL(dev_add_pack);
@@ -637,10 +660,13 @@ void __dev_remove_pack(struct packet_type *pt)
 	spin_lock(&ptype_lock);
 
 	list_for_each_entry(pt1, head, list) {
-		if (pt == pt1) {
-			list_del_rcu(&pt->list);
-			goto out;
-		}
+		if (pt != pt1)
+			continue;
+		list_del_rcu(&pt->list);
+		if (pt->af_packet_net && !pt->dev && list_empty(head))
+			net_set_ptype(pt->af_packet_net,
+				      pt->type == htons(ETH_P_ALL), false);
+		goto out;
 	}
 
 	pr_warn("dev_remove_pack: %p not found\n", pt);
@@ -2483,8 +2509,7 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
  */
 bool dev_nit_active(struct net_device *dev)
 {
-	return !list_empty(&dev_net(dev)->ptype_all) ||
-	       !list_empty(&dev->ptype_all);
+	return READ_ONCE(dev->ptype_all_ns) || !list_empty(&dev->ptype_all);
 }
 EXPORT_SYMBOL_GPL(dev_nit_active);
 
@@ -5732,10 +5757,12 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &dev_net(skb->dev)->ptype_all, list) {
-		if (pt_prev)
-			ret = deliver_skb(skb, pt_prev, orig_dev);
-		pt_prev = ptype;
+	if (READ_ONCE(skb->dev->ptype_all_ns)) {
+		list_for_each_entry_rcu(ptype, &dev_net(skb->dev)->ptype_all, list) {
+			if (pt_prev)
+				ret = deliver_skb(skb, pt_prev, orig_dev);
+			pt_prev = ptype;
+		}
 	}
 
 	list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
@@ -5844,8 +5871,9 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
 				       &ptype_base[ntohs(type) &
 						   PTYPE_HASH_MASK]);
-		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
-				       &dev_net(orig_dev)->ptype_specific);
+		if (READ_ONCE(skb->dev->ptype_specific_ns))
+			deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
+					       &dev_net(skb->dev)->ptype_specific);
 	}
 
 	deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
@@ -12563,10 +12591,12 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 46);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ptype_all_ns);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 47);
 
 	/* RX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific_ns);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ifindex);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, real_num_rx_queues);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, _rx);
@@ -12581,7 +12611,7 @@ static void __init net_dev_struct_check(void)
 #ifdef CONFIG_NET_XGRESS
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, tcx_ingress);
 #endif
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 92);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_rx, 93);
 }
 
 /*
-- 
2.48.1


