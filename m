Return-Path: <netdev+bounces-175382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83CA65885
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7575A19A0669
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A31A9B49;
	Mon, 17 Mar 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTZ1i8qq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A41E1E16
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229486; cv=none; b=u6cKKaKatXxCQzb2ciXndJNZmuQmeEcYTJhXQrS1dMuqmNor9cdFuqq1Wxz7lPODTpWJVTwW7qH63BYy+7cazLngAb6SE/uRokuD85SbfrE4OlZ7Rotbatq83zhUYV+2Fv6mfbu2rOvz1Si4912lyh5g+XbHogS3RhyaWMMA0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229486; c=relaxed/simple;
	bh=Gc0+NRieiYbFXY9DP8WDhqxXVJY5umemeb5orBab25U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0wRHecMDAVvahYGTuTGS69djt2kNGr5BAZAsS2J+7Bhg06EFCeau3JlOUnN5WbkqJl+2szFo1RwLarhSYECaj4gLpZ+gYi92ceT6mMGyKNUIrNuY/P6+PdIOhVG3pw0j1ISpjiavQqZ1dUe1D7trt+dFtH57aXVvvZaydynCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTZ1i8qq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742229483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fuAK01wf1KdYZvmV5kbquws0TZGj8B1iOW+QWQvimSE=;
	b=LTZ1i8qqQmU7bpppmbOH0CJDgse8Q8E5gJmQNLia8j09J2yHna+iGw+oETF+w+VCuOnalk
	nbe6upOyA7Wbv8tAZ82MrY8S/qtrstDURXMeC+MF25wF7R3WcLk5g1cwAy2Q2CV0jIbux7
	262Beh9MD362godZxXf5j0zg73IG3C0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-wqWgloLpOmWnQv-Rc0038A-1; Mon,
 17 Mar 2025 12:37:59 -0400
X-MC-Unique: wqWgloLpOmWnQv-Rc0038A-1
X-Mimecast-MFC-AGG-ID: wqWgloLpOmWnQv-Rc0038A_1742229477
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5295D195605A;
	Mon, 17 Mar 2025 16:37:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59F67180094A;
	Mon, 17 Mar 2025 16:37:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next] net: introduce per netns packet chains
Date: Mon, 17 Mar 2025 17:37:42 +0100
Message-ID: <b931a4c9b78e282c143ab9455d4c65faa5f6de1c.1742228617.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently network taps unbound to any interface are linked in the
global ptype_all list, affecting the performance in all the network
namespaces.

Add per netns ptypes chains, so that in the mentioned case only
the netns owning the packet socket(s) is affected.

While at that drop the global ptype_all list: no in kernel user
registers a tap on "any" type without specifying either the target
device or the target namespace (and IMHO doing that would not make
any sense).

In dev_queue_xmit_nit() we can remove a redundant RCU read lock: such
function is called only by dev_hard_start_xmit(), which is ensured
to run under RCU protection.

Note that this adds a conditional in the fast path (to check for
per netns ptype_specific list) and increases the dataset size by
a cacheline (owing the per netns lists).

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
rfc -> v1
 - fix procfs dump
 - fix dev->ptype_specific -> dev->ptype_all type in ptype_head()
 - dev_net() -> dev_net_rcu
 - add dev_nit_active_rcu  variant
 - ptype specific netns deliver uses dev_net_rcu(skb->dev)) instead
   of dev_net(orig_dev)
---
 include/linux/netdevice.h   | 12 ++++++++-
 include/net/hotdata.h       |  1 -
 include/net/net_namespace.h |  3 +++
 net/core/dev.c              | 53 ++++++++++++++++++++++++++-----------
 net/core/hotdata.c          |  1 -
 net/core/net-procfs.c       | 28 +++++++++++++++-----
 net/core/net_namespace.c    |  2 ++
 7 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0dbfe069a6e38..067bf137db6ab 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4276,7 +4276,17 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
 	return 0;
 }
 
-bool dev_nit_active(struct net_device *dev);
+bool dev_nit_active_rcu(struct net_device *dev);
+static inline bool dev_nit_active(struct net_device *dev)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = dev_nit_active_rcu(dev);
+	rcu_read_unlock();
+	return ret;
+}
+
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev);
 
 static inline void __dev_put(struct net_device *dev)
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 30e9570beb2af..fda94b2647ffa 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -23,7 +23,6 @@ struct net_hotdata {
 	struct net_offload	udpv6_offload;
 #endif
 	struct list_head	offload_base;
-	struct list_head	ptype_all;
 	struct kmem_cache	*skbuff_cache;
 	struct kmem_cache	*skbuff_fclone_cache;
 	struct kmem_cache	*skb_small_head_cache;
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f467a66abc6b1..bd57d8fb54f14 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -83,6 +83,9 @@ struct net {
 	struct llist_node	defer_free_list;
 	struct llist_node	cleanup_list;	/* namespaces on death row */
 
+	struct list_head ptype_all;
+	struct list_head ptype_specific;
+
 #ifdef CONFIG_KEYS
 	struct key_tag		*key_domain;	/* Key domain of operation tag */
 #endif
diff --git a/net/core/dev.c b/net/core/dev.c
index 6fa6ed5b57987..640c5758f8851 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -572,11 +572,19 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
-	if (pt->type == htons(ETH_P_ALL))
-		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
-	else
-		return pt->dev ? &pt->dev->ptype_specific :
-				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
+	if (pt->type == htons(ETH_P_ALL)) {
+		if (!pt->af_packet_net && !pt->dev)
+			return NULL;
+
+		return pt->dev ? &pt->dev->ptype_all :
+				 &pt->af_packet_net->ptype_all;
+	}
+
+	if (pt->dev)
+		return &pt->dev->ptype_specific;
+
+	return pt->af_packet_net ? &pt->af_packet_net->ptype_specific :
+				   &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
 }
 
 /**
@@ -596,6 +604,9 @@ void dev_add_pack(struct packet_type *pt)
 {
 	struct list_head *head = ptype_head(pt);
 
+	if (WARN_ON_ONCE(!head))
+		return;
+
 	spin_lock(&ptype_lock);
 	list_add_rcu(&pt->list, head);
 	spin_unlock(&ptype_lock);
@@ -620,6 +631,9 @@ void __dev_remove_pack(struct packet_type *pt)
 	struct list_head *head = ptype_head(pt);
 	struct packet_type *pt1;
 
+	if (!head)
+		return;
+
 	spin_lock(&ptype_lock);
 
 	list_for_each_entry(pt1, head, list) {
@@ -2463,16 +2477,18 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
 }
 
 /**
- * dev_nit_active - return true if any network interface taps are in use
+ * dev_nit_active_rcu - return true if any network interface taps are in use
+ *
+ * The caller must held the RCU lock
  *
  * @dev: network device to check for the presence of taps
  */
-bool dev_nit_active(struct net_device *dev)
+bool dev_nit_active_rcu(struct net_device *dev)
 {
-	return !list_empty(&net_hotdata.ptype_all) ||
+	return !list_empty(&dev_net_rcu(dev)->ptype_all) ||
 	       !list_empty(&dev->ptype_all);
 }
-EXPORT_SYMBOL_GPL(dev_nit_active);
+EXPORT_SYMBOL_GPL(dev_nit_active_rcu);
 
 /*
  *	Support routine. Sends outgoing frames to any network
@@ -2481,11 +2497,10 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct list_head *ptype_list = &net_hotdata.ptype_all;
+	struct list_head *ptype_list = &dev_net_rcu(dev)->ptype_all;
 	struct packet_type *ptype, *pt_prev = NULL;
 	struct sk_buff *skb2 = NULL;
 
-	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
 		if (READ_ONCE(ptype->ignore_outgoing))
@@ -2529,7 +2544,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		pt_prev = ptype;
 	}
 
-	if (ptype_list == &net_hotdata.ptype_all) {
+	if (ptype_list == &dev_net_rcu(dev)->ptype_all) {
 		ptype_list = &dev->ptype_all;
 		goto again;
 	}
@@ -2540,7 +2555,6 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		else
 			kfree_skb(skb2);
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(dev_queue_xmit_nit);
 
@@ -3774,7 +3788,7 @@ static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 	unsigned int len;
 	int rc;
 
-	if (dev_nit_active(dev))
+	if (dev_nit_active_rcu(dev))
 		dev_queue_xmit_nit(skb, dev);
 
 	len = skb->len;
@@ -5718,7 +5732,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
+	list_for_each_entry_rcu(ptype, &dev_net_rcu(skb->dev)->ptype_all,
+				list) {
 		if (pt_prev)
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
@@ -5830,6 +5845,14 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
 				       &ptype_base[ntohs(type) &
 						   PTYPE_HASH_MASK]);
+
+		/* The only per net ptype user - packet socket - matches
+		 * the target netns vs dev_net(skb->dev); we need to
+		 * process only such netns even when orig_dev lays in a
+		 * different one.
+		 */
+		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
+				       &dev_net_rcu(skb->dev)->ptype_specific);
 	}
 
 	deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index d0aaaaa556f22..0bc893d5f07b0 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -7,7 +7,6 @@
 
 struct net_hotdata net_hotdata __cacheline_aligned = {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
-	.ptype_all = LIST_HEAD_INIT(net_hotdata.ptype_all),
 	.gro_normal_batch = 8,
 
 	.netdev_budget = 300,
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index fa6d3969734a6..3e92bf0f9060b 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -185,7 +185,13 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 		}
 	}
 
-	list_for_each_entry_rcu(pt, &net_hotdata.ptype_all, list) {
+	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
+		if (i == pos)
+			return pt;
+		++i;
+	}
+
+	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_specific, list) {
 		if (i == pos)
 			return pt;
 		++i;
@@ -210,6 +216,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct net *net = seq_file_net(seq);
 	struct net_device *dev;
 	struct packet_type *pt;
 	struct list_head *nxt;
@@ -232,15 +239,22 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 				goto found;
 			}
 		}
-
-		nxt = net_hotdata.ptype_all.next;
-		goto ptype_all;
+		nxt = net->ptype_all.next;
+		goto net_ptype_all;
 	}
 
-	if (pt->type == htons(ETH_P_ALL)) {
-ptype_all:
-		if (nxt != &net_hotdata.ptype_all)
+	if (pt->af_packet_net) {
+net_ptype_all:
+		if (nxt != &net->ptype_all && nxt != &net->ptype_specific)
 			goto found;
+
+		if (nxt == &net->ptype_all) {
+			/* continue with ->ptype_specific if it's not empty */
+			nxt = net->ptype_specific.next;
+			if (nxt != &net->ptype_specific)
+				goto found;
+		}
+
 		hash = 0;
 		nxt = ptype_base[0].next;
 	} else
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a492624..b0dfdf791ece5 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -340,6 +340,8 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
 #endif
 
+	INIT_LIST_HEAD(&net->ptype_all);
+	INIT_LIST_HEAD(&net->ptype_specific);
 	preinit_net_sysctl(net);
 }
 
-- 
2.48.1


