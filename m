Return-Path: <netdev+bounces-174882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D68D0A61204
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB80F88051D
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB051FE44A;
	Fri, 14 Mar 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+qOrg7z"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569D1FDE24
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957608; cv=none; b=etFi7jttPuPD1nO8YEJbMPRixer90F9noNULRyjm59gnxzle3nD0wiWxgjG/lVpplZYooIQRsr4pyHTL/hrNH3VYRvCrtMPOwxVsxWEwgFvMieXCWOepmGbPEC9RmQK5woHfWVR4AXV/7L/0ivbu2mrxayrUoWB5qqh6GJ/IQ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957608; c=relaxed/simple;
	bh=C5pAonchQwXhmXoSGWUj3BVGV6hNKQmJuG2FrdnkwyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCBs1sEXIyZpOvPIXSYNukH9ArkbCUYgyBkoupxyILupOEzUNXMu1abcRVGEwwqucVjWJy0/BdwEP/UHngrz88wbmFMwFA+Fe9gxysgt9AgwZZzRVHAqzPZgvBEHsmrTAUignAPhns75VdO6QqcgAW3t+0WgFtt+o2lWDENCMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+qOrg7z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741957605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Mc/UyY2X/B3UA0llyiCdQo6IXngW6BEoEC5j5wA7I4=;
	b=D+qOrg7zVWrOvf4U3sOG7ENroft7NndVv/qSYK0RYcjIEctwAC/SKqGPSnmrW9IzaoPl8K
	5mJeg0U9Buk73wgnsDsOBiZLPnflfmJPu9jTosZptltQ1pjcmpEd4tOf4f773SHL9VwC3T
	2cofj4/grhpKt8s3lljlIgkXHulAHg8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-5H9Q5z8nOSifiFItEOJQmA-1; Fri,
 14 Mar 2025 09:06:42 -0400
X-MC-Unique: 5H9Q5z8nOSifiFItEOJQmA-1
X-Mimecast-MFC-AGG-ID: 5H9Q5z8nOSifiFItEOJQmA_1741957601
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1C141800262;
	Fri, 14 Mar 2025 13:06:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F41351955BCB;
	Fri, 14 Mar 2025 13:06:36 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH 1/2] net: introduce per netns packet chains
Date: Fri, 14 Mar 2025 14:05:00 +0100
Message-ID: <19ab1d1a4e222833c407002ba5e6c64018d92b3e.1741957452.git.pabeni@redhat.com>
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

The next patch will try to address the above.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/hotdata.h       |  1 -
 include/net/net_namespace.h |  3 +++
 net/core/dev.c              | 32 ++++++++++++++++++++++++--------
 net/core/hotdata.c          |  1 -
 net/core/net-procfs.c       | 16 ++++++++--------
 net/core/net_namespace.c    |  2 ++
 6 files changed, 37 insertions(+), 18 deletions(-)

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
index 6fa6ed5b57987..00bdd8316cb5e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -572,11 +572,19 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
-	if (pt->type == htons(ETH_P_ALL))
-		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
-	else
+	if (pt->type == htons(ETH_P_ALL)) {
+		if (!pt->af_packet_net && !pt->dev)
+			return NULL;
+
 		return pt->dev ? &pt->dev->ptype_specific :
-				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
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
@@ -2469,7 +2483,7 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
  */
 bool dev_nit_active(struct net_device *dev)
 {
-	return !list_empty(&net_hotdata.ptype_all) ||
+	return !list_empty(&dev_net(dev)->ptype_all) ||
 	       !list_empty(&dev->ptype_all);
 }
 EXPORT_SYMBOL_GPL(dev_nit_active);
@@ -2481,7 +2495,7 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct list_head *ptype_list = &net_hotdata.ptype_all;
+	struct list_head *ptype_list = &dev_net(dev)->ptype_all;
 	struct packet_type *ptype, *pt_prev = NULL;
 	struct sk_buff *skb2 = NULL;
 
@@ -2529,7 +2543,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		pt_prev = ptype;
 	}
 
-	if (ptype_list == &net_hotdata.ptype_all) {
+	if (ptype_list == &dev_net(dev)->ptype_all) {
 		ptype_list = &dev->ptype_all;
 		goto again;
 	}
@@ -5718,7 +5732,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
+	list_for_each_entry_rcu(ptype, &dev_net(skb->dev)->ptype_all, list) {
 		if (pt_prev)
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
@@ -5830,6 +5844,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
 				       &ptype_base[ntohs(type) &
 						   PTYPE_HASH_MASK]);
+		deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
+				       &dev_net(orig_dev)->ptype_specific);
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
index fa6d3969734a6..8a5d93eb9d77a 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -185,7 +185,7 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 		}
 	}
 
-	list_for_each_entry_rcu(pt, &net_hotdata.ptype_all, list) {
+	list_for_each_entry_rcu(pt, &seq_file_net(seq)->ptype_all, list) {
 		if (i == pos)
 			return pt;
 		++i;
@@ -210,6 +210,7 @@ static void *ptype_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
+	struct net *net = seq_file_net(seq);
 	struct net_device *dev;
 	struct packet_type *pt;
 	struct list_head *nxt;
@@ -232,16 +233,15 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
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
+		if (nxt != &net->ptype_all)
 			goto found;
-		hash = 0;
+
 		nxt = ptype_base[0].next;
 	} else
 		hash = ntohs(pt->type) & PTYPE_HASH_MASK;
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


