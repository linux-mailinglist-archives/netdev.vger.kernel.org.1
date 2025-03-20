Return-Path: <netdev+bounces-176566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ECBA6AD09
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8703AB882
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C01E5203;
	Thu, 20 Mar 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOnfxSmH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B671F5F6
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742494979; cv=none; b=Aq4KJDJmAXwzQaZ0qND0MnfG+rY/aw6t2Bj+CCGVpm49YeTnN5Eu8b3+OjWQOBc6LsYeNyyiyZAhOzjOo3n0LqgDy0ee8XgZJ/Ooe4SYXoivUyprotOquq9BhSmD2Fz/aZnORBeRs1EviLwA8E7PiRx9YhoT48OrFuo45yRnEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742494979; c=relaxed/simple;
	bh=MUcFt1LRDWxhavjcBJyrH8WHn5ra76RYuzwt7ln+ZL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nvx1OwneYJinZQTd6dtBEw/jDJ5nKA0Fnr/yevaHZREZHi/F6asR9Odox0KsCcei4SGzcn/4NUw6yiHEo2zW6iu0vDR4fiYLQi3l7ExtDDZ0585wp86rjsxTsghvXAqnQpsBekHueX7rwXrM2hfUy3crhF+tcX6cjeYlbaXwlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOnfxSmH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742494976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZXCpuhgBj+VOj1YmUnEnfQPdndEVWSMDllWR2t2HZW0=;
	b=QOnfxSmHhsOTkzzxEI1ZtooN6MJs2tFtbvilFHqJvRSFrxiPiipKo5VQQGhZ5FOteYfwKt
	BowHmKzqKoSkx6YKEzPcCmG96fnmzL9SJu8zC5z1MRLSSUoVAA0ZO4GiNJTjRs/gbWXxEp
	cs948//elVWt6haakuvTSrWiUZL9Mcc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-CPdBOaK9OR6C6tHAuf1jxQ-1; Thu,
 20 Mar 2025 14:22:52 -0400
X-MC-Unique: CPdBOaK9OR6C6tHAuf1jxQ-1
X-Mimecast-MFC-AGG-ID: CPdBOaK9OR6C6tHAuf1jxQ_1742494971
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5BCD18EBE8A;
	Thu, 20 Mar 2025 18:22:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 318DC180886C;
	Thu, 20 Mar 2025 18:22:46 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	dsahern@kernel.org,
	kuniyu@amazon.com
Subject: [PATCH net-next v4] net: introduce per netns packet chains
Date: Thu, 20 Mar 2025 19:22:38 +0100
Message-ID: <ae405f98875ee87f8150c460ad162de7e466f8a7.1742494826.git.pabeni@redhat.com>
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

Note that this adds a conditional in the fast path (to check for
per netns ptype_specific list) and increases the dataset size by
a cacheline (owing the per netns lists).

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
 - constify the dev_nit_active* helpers
 - fix comment typo
 v3: https://lore.kernel.org/netdev/2b6ce88cb7da4d74853cc36d7de4b1b11a7362e5.1742401226.git.pabeni@redhat.com/

v2 -> v3:
 - optimized dev_queue_xmit_nit() loop
 - fixed RCU splat false positive
 - clarified (?) a ptype_specific comment
 v2: https://lore.kernel.org/netdev/2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com/

v1 -> v2:
 - fix comment typo
 - drop the doubtful RCU optimization
 v1: https://lore.kernel.org/netdev/b931a4c9b78e282c143ab9455d4c65faa5f6de1c.1742228617.git.pabeni@redhat.com/

rfc -> v1
 - fix procfs dump
 - fix dev->ptype_specific -> dev->ptype_all type in ptype_head()
 - dev_net() -> dev_net_rcu
 - add dev_nit_active_rcu  variant
 - ptype specific netns deliver uses dev_net_rcu(skb->dev)) instead
   of dev_net(orig_dev)
 rfc: https://lore.kernel.org/netdev/cover.1741957452.git.pabeni@redhat.com/
---
 include/linux/netdevice.h   | 12 ++++++++-
 include/net/hotdata.h       |  1 -
 include/net/net_namespace.h |  3 +++
 net/core/dev.c              | 53 ++++++++++++++++++++++++++++---------
 net/core/hotdata.c          |  1 -
 net/core/net-procfs.c       | 28 +++++++++++++++-----
 net/core/net_namespace.c    |  2 ++
 7 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0c5b1f7f8f3af..f22cca7c03add 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4278,7 +4278,17 @@ static __always_inline int ____dev_forward_skb(struct net_device *dev,
 	return 0;
 }
 
-bool dev_nit_active(struct net_device *dev);
+bool dev_nit_active_rcu(const struct net_device *dev);
+static inline bool dev_nit_active(const struct net_device *dev)
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
index 2355603417650..bcf81c3ff6a32 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -572,10 +572,18 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
-	if (pt->type == htons(ETH_P_ALL))
-		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
-	else
-		return pt->dev ? &pt->dev->ptype_specific :
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
 				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
 }
 
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
@@ -2441,16 +2455,21 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
 }
 
 /**
- * dev_nit_active - return true if any network interface taps are in use
+ * dev_nit_active_rcu - return true if any network interface taps are in use
+ *
+ * The caller must hold the RCU lock
  *
  * @dev: network device to check for the presence of taps
  */
-bool dev_nit_active(struct net_device *dev)
+bool dev_nit_active_rcu(const struct net_device *dev)
 {
-	return !list_empty(&net_hotdata.ptype_all) ||
+	/* Callers may hold either RCU or RCU BH lock */
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+
+	return !list_empty(&dev_net(dev)->ptype_all) ||
 	       !list_empty(&dev->ptype_all);
 }
-EXPORT_SYMBOL_GPL(dev_nit_active);
+EXPORT_SYMBOL_GPL(dev_nit_active_rcu);
 
 /*
  *	Support routine. Sends outgoing frames to any network
@@ -2459,11 +2478,12 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct list_head *ptype_list = &net_hotdata.ptype_all;
 	struct packet_type *ptype, *pt_prev = NULL;
+	struct list_head *ptype_list;
 	struct sk_buff *skb2 = NULL;
 
 	rcu_read_lock();
+	ptype_list = &dev_net_rcu(dev)->ptype_all;
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
 		if (READ_ONCE(ptype->ignore_outgoing))
@@ -2507,7 +2527,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		pt_prev = ptype;
 	}
 
-	if (ptype_list == &net_hotdata.ptype_all) {
+	if (ptype_list != &dev->ptype_all) {
 		ptype_list = &dev->ptype_all;
 		goto again;
 	}
@@ -3752,7 +3772,7 @@ static int xmit_one(struct sk_buff *skb, struct net_device *dev,
 	unsigned int len;
 	int rc;
 
-	if (dev_nit_active(dev))
+	if (dev_nit_active_rcu(dev))
 		dev_queue_xmit_nit(skb, dev);
 
 	len = skb->len;
@@ -5696,7 +5716,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
+	list_for_each_entry_rcu(ptype, &dev_net_rcu(skb->dev)->ptype_all,
+				list) {
 		if (pt_prev)
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
@@ -5808,6 +5829,14 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
 				       &ptype_base[ntohs(type) &
 						   PTYPE_HASH_MASK]);
+
+		/* orig_dev and skb->dev could belong to different netns;
+		 * Even in such case we need to traverse only the list
+		 * coming from skb->dev, as the ptype owner (packet socket)
+		 * will use dev_net(skb->dev) to do namespace filtering.
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


