Return-Path: <netdev+bounces-77994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BFC873B73
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E17BB22EE5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD961369B6;
	Wed,  6 Mar 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OIrcfnR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF80137936
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740848; cv=none; b=ugGhunLUDbpRsacOcbPl79mkyg0Fm7detqFSSF457iwWyzDponp75Ptd0NIrpnZrdGpFOoVbtpWOlo1tJpQkl7hpM0DK/Fn+M+q6KV2rcXD5NG+ZEcKcmPbEWPjJXifOau62bDFzTW3I/+jg4I9oYk7LlPEBgQyPGBVfZX9f5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740848; c=relaxed/simple;
	bh=CCrywqwkFo9FhkcQxA38b6+rPZ9hdCuIDojQ7g2AubM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=azkwIg5xZlAiFNZo0McBYgQ0WizThipVpfqckBNuq+As+4uTa4G62NPUpxXpWBDTHlh18oDQnYQlR4GRLAgly3R513pX/vAAF0T2gbpRo34wJJK405iHKdHdNCko9ouUhRa+yKSBFMtbqt6BnQlJ/O4+gu/zB/nNpyfJQ5vkmJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OIrcfnR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso10823012276.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740845; x=1710345645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NcKOs0+vx6Ph3LwiTlyCoVW8OOGNMT4JjMZZ2TR+HNY=;
        b=4OIrcfnRyIbHTgWXcuzvJ56p7Fa8tr5YgSccmA8ARoONf6rUAkDxfObG2qE5JxE0P0
         0bxl+4r8nr67BZBdQCN/gU1yZZb9zSHws7ip7VYs4BSJOjoR2UhtJ3O/PhZl0PirhfqP
         NsKU2k8Lms0Ug3uTvIr4ChC4DfedvugLC9z9cw03dXyTwcdHq+0nXet7n96AFmmbBtyZ
         DmDs8C1oPfNxohsvcLyMK7rmRUwM2n9YeSkajK+WxfBBXUyomaBwECM/hTxewaySl/fD
         6MvZhrINfpMoiWpj0UJx0coPQjQzsafhoHrXPa1zqWLHrue7gP+yHk3JtrBwd2ma+jm9
         fkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740845; x=1710345645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcKOs0+vx6Ph3LwiTlyCoVW8OOGNMT4JjMZZ2TR+HNY=;
        b=JgFEwDIY8q+K6ipkDxNTkT/7WczR09TjYz0RAYCCWOZ+RJqApp4iEMS5VjaF5w35eU
         7PMwTjhdREoh20+vZHhI7zVFWIvZnHj5wnsKxph8kNOvFnGraRxQP9iy+5Rl34a3RRsK
         WMapPK3ftU386clvssQuVxLjdt8sGpk8WVAmBwGzPaLgI/+jAP/xsdQzOPQFaDdqpbxN
         cMgN7VzCCyOovk3LnFip6TKBVcVDEDz2iB0o64Z0TXSqvYGx3cPN9Dt/pNBI4+L/P/jR
         4b8LTteFDXMXNfbJlI6uptGrpUbr/pUJeLDEFTOCkE0tmmxWlgjhXgPBB6mbWjUZ8yiw
         lRKA==
X-Forwarded-Encrypted: i=1; AJvYcCUS1uPHCTUZ/KeQZm1+UROK5wiGU9HO2odhYIcRt+aPmPxkSI64Blq/oLlSr9mw8EaqHpqZkgln1qNCf0fAlMrGOW9G4RX4
X-Gm-Message-State: AOJu0YymWo2CouMXgA4Nf9GR/dnmqCNgKzyh7Co8yqDWCnt6iB24iIt7
	HfJ/VCzH0kfiMcd2KrzqmCE2bic4tWdAkEwqNYhR5hI0wBfaIe3GLBIlRGgoEXAWhUjgfFROdc2
	qWom1ncHqIw==
X-Google-Smtp-Source: AGHT+IEIEvyk2Awqp0vgH+nC4Ko4ssDtG34y3yN8hwAV5n/BPNtW5IJRHVXALdOqB5uSeARECOH+tS3drJcYoQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:120a:b0:dc2:398d:a671 with SMTP
 id s10-20020a056902120a00b00dc2398da671mr3922272ybu.10.1709740845772; Wed, 06
 Mar 2024 08:00:45 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:17 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-5-edumazet@google.com>
Subject: [PATCH v2 net-next 04/18] net: move ptype_all into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ptype_all is used in rx/tx fast paths.

Move it to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/netdevice.h |  1 -
 include/net/hotdata.h     |  1 +
 net/core/dev.c            | 16 +++++++---------
 net/core/hotdata.c        |  1 +
 net/core/net-procfs.c     |  7 ++++---
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 15ce809e0541078bff7a48b8d7cb2cf2c1ac8a93..e2e7d5a7ef34de165cd293eb71800e1e6b450432 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -5300,7 +5300,6 @@ static inline const char *netdev_reg_state(const struct net_device *dev)
 #define PTYPE_HASH_SIZE	(16)
 #define PTYPE_HASH_MASK	(PTYPE_HASH_SIZE - 1)
 
-extern struct list_head ptype_all __read_mostly;
 extern struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
 
 extern struct net_device *blackhole_netdev;
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 149e56528537d8ed3365e46d6dc96e39c73a733a..d462cb8f16bad459b439c566274c01a0f18a95d0 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -7,6 +7,7 @@
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
 	struct list_head	offload_base;
+	struct list_head	ptype_all;
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
diff --git a/net/core/dev.c b/net/core/dev.c
index 53ebdb55e8b7c0a6522eb3fdbb7bdd00948eb9a5..119b7004a8e51ea6785c60e558988d369eec8935 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -161,7 +161,6 @@
 
 static DEFINE_SPINLOCK(ptype_lock);
 struct list_head ptype_base[PTYPE_HASH_SIZE] __read_mostly;
-struct list_head ptype_all __read_mostly;	/* Taps */
 
 static int netif_rx_internal(struct sk_buff *skb);
 static int call_netdevice_notifiers_extack(unsigned long val,
@@ -540,7 +539,7 @@ static inline void netdev_set_addr_lockdep_class(struct net_device *dev)
 static inline struct list_head *ptype_head(const struct packet_type *pt)
 {
 	if (pt->type == htons(ETH_P_ALL))
-		return pt->dev ? &pt->dev->ptype_all : &ptype_all;
+		return pt->dev ? &pt->dev->ptype_all : &net_hotdata.ptype_all;
 	else
 		return pt->dev ? &pt->dev->ptype_specific :
 				 &ptype_base[ntohs(pt->type) & PTYPE_HASH_MASK];
@@ -2226,7 +2225,8 @@ static inline bool skb_loop_sk(struct packet_type *ptype, struct sk_buff *skb)
  */
 bool dev_nit_active(struct net_device *dev)
 {
-	return !list_empty(&ptype_all) || !list_empty(&dev->ptype_all);
+	return !list_empty(&net_hotdata.ptype_all) ||
+	       !list_empty(&dev->ptype_all);
 }
 EXPORT_SYMBOL_GPL(dev_nit_active);
 
@@ -2237,10 +2237,9 @@ EXPORT_SYMBOL_GPL(dev_nit_active);
 
 void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct packet_type *ptype;
+	struct list_head *ptype_list = &net_hotdata.ptype_all;
+	struct packet_type *ptype, *pt_prev = NULL;
 	struct sk_buff *skb2 = NULL;
-	struct packet_type *pt_prev = NULL;
-	struct list_head *ptype_list = &ptype_all;
 
 	rcu_read_lock();
 again:
@@ -2286,7 +2285,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		pt_prev = ptype;
 	}
 
-	if (ptype_list == &ptype_all) {
+	if (ptype_list == &net_hotdata.ptype_all) {
 		ptype_list = &dev->ptype_all;
 		goto again;
 	}
@@ -5387,7 +5386,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	if (pfmemalloc)
 		goto skip_taps;
 
-	list_for_each_entry_rcu(ptype, &ptype_all, list) {
+	list_for_each_entry_rcu(ptype, &net_hotdata.ptype_all, list) {
 		if (pt_prev)
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
@@ -11771,7 +11770,6 @@ static int __init net_dev_init(void)
 	if (netdev_kobject_init())
 		goto out;
 
-	INIT_LIST_HEAD(&ptype_all);
 	for (i = 0; i < PTYPE_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&ptype_base[i]);
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index 087c4c84987df07f11a87112a778a5cac608a654..29fcfe89fd9a697120f826dbe2fd36a1617581a1 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -7,6 +7,7 @@
 
 struct net_hotdata net_hotdata __cacheline_aligned = {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
+	.ptype_all = LIST_HEAD_INIT(net_hotdata.ptype_all),
 	.gro_normal_batch = 8,
 
 	.netdev_budget = 300,
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 2e4e96d30ee1a7a51e49587378aab47aed1290da..a97eceb84e61ec347ad132ff0f22c8ce82f12e90 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -3,6 +3,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <net/wext.h>
+#include <net/hotdata.h>
 
 #include "dev.h"
 
@@ -183,7 +184,7 @@ static void *ptype_get_idx(struct seq_file *seq, loff_t pos)
 		}
 	}
 
-	list_for_each_entry_rcu(pt, &ptype_all, list) {
+	list_for_each_entry_rcu(pt, &net_hotdata.ptype_all, list) {
 		if (i == pos)
 			return pt;
 		++i;
@@ -231,13 +232,13 @@ static void *ptype_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 			}
 		}
 
-		nxt = ptype_all.next;
+		nxt = net_hotdata.ptype_all.next;
 		goto ptype_all;
 	}
 
 	if (pt->type == htons(ETH_P_ALL)) {
 ptype_all:
-		if (nxt != &ptype_all)
+		if (nxt != &net_hotdata.ptype_all)
 			goto found;
 		hash = 0;
 		nxt = ptype_base[0].next;
-- 
2.44.0.278.ge034bb2e1d-goog


