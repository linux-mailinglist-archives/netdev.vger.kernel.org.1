Return-Path: <netdev+bounces-226715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E68BA45E3
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D524517FBEB
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703D21255E;
	Fri, 26 Sep 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lPRRosg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFDE1F1517
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899602; cv=none; b=SiV3as+nCH3ZOX84XuuhALC6d6z+EEFFYtp2fTK30Y03Mp9TViDGkCjVkHl95zOLsqgLrPH07pTOxlrxkww/aTgLHcBVF1QHGTnPojLrTKsLBVQSLETQ0um0SFjznH55g01SxynriWzITubYhc7Nx0dd6kSe2Sd10ASigD6sP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899602; c=relaxed/simple;
	bh=oJq4yeu+1tHLWW4ljfjj8qRbh2ej7np9UZZQXF0J4Mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PiZ10PY4sOSLh9EtpCnCK6USkRF18q8v0KMfFI1Nn+dmJsId9MMXM7KCwY2hG67AYoCn7tn5Lw3mLkRiLdO1O0ZRd1wNWNXSFcwS08On7kbvHbriDifOGCcCrELkZ+OG1ILKrmJQNJ6Mwk2CC/geTqv/uQwh8H3gMla/ELS5OVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lPRRosg; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-8e47b4f0c3aso2622345241.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758899599; x=1759504399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w2pUucnumxW4NOs5YVn4FqdFixWFltmix3ZPNXJ7Nd8=;
        b=3lPRRosghu4v5YDws7t1i2pnF+k3ogGFEkYSCg3flUM+pDk9Rywke2d04Jb/syEcR8
         Jh0E+aDXDn4p63eXQ2fzfjJMRHruVOaGyDLNqOrC1rDy+oU+Cxk8kKsPOliRB0S0+Nk7
         FQhh8CWJrvgmp4uwE+/b1q22X156XJAwvHIqarrtcR9KJk0KlpOZyXnYAYXqldLrNroC
         g8WpEIkHAYZb5nH2KeaMSfB6dhAre4IKJZCx8bZFoczP2YM3m4a0Y0mLerKp3gEDU6rA
         9CXBU/c9go7JjwzAohJQhSO1vhimSTDyGIEzJStKKzkCmT0d8MAx/RK4SvYXIAOrw62O
         lvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758899599; x=1759504399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2pUucnumxW4NOs5YVn4FqdFixWFltmix3ZPNXJ7Nd8=;
        b=t7khNfrBj3DIkrfj938cHEXjJzhPR7Kax84cz6hUOalUz+BZWRSsHAy/dvh4/nWipF
         JDhvIft5TliQzijy8QyaJOpL+jlt1HHPoTHi26HAGGJAZu2FwmkbOc4hLeB88LJDD/tc
         E9p4GZs3KTsQ7f7o5EIyC2pPe3d3zPrf+RycBbrJIFwLPQVUBZc9KW6uMkhfBuc5ykSw
         tro+lfDFrWEd8UPXAEk95hmeipvwzE/Q0MUgJ8WPLQdb57Zu8w6j93Q3BrUD43sXCvtb
         RAJ4PGO1tACuCbbQG4KkZrWnvPu0pGrzX0iAXso22YPGTrQdDRcKvLNXVfJsxX6EynbU
         Vh5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgiRSqfcgbfJs1zoU/8/j05cZ2xkcwnM2pTbxYGnHVy8ubDrwUpUqjp6ZUs9o9fYxY6zzta9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBCEHwci8hBbEsAQ13dnavkckRjEMIRCYTuXZg5c9m7K8SOQL
	c+xfoQg0YqkgFkdhgwLTNowe+zQ9qatsFNWbR1smAlVwrjVF/DVOXJpUBJ7pxyahnn1NH9BA7ud
	+gpIvF395ZNCdBA==
X-Google-Smtp-Source: AGHT+IEVp+lYcPaQgfa65JL0h8op65b0xJ45giO2GqjX4OIFt096tU6HXDUo1KjqjvB8jPdbxzIrjtzS9WMrLQ==
X-Received: from vsvd34.prod.google.com ([2002:a05:6102:14a2:b0:4f2:f5cb:42ce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2910:b0:5a4:69bc:a9e with SMTP id ada2fe7eead31-5acd4639aa7mr3654587137.22.1758899599597;
 Fri, 26 Sep 2025 08:13:19 -0700 (PDT)
Date: Fri, 26 Sep 2025 15:13:04 +0000
In-Reply-To: <20250926151304.1897276-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926151304.1897276-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: add NUMA awareness to skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of sharing sd->defer_list & sd->defer_count with
many cpus, add one pair for each NUMA node.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  4 ----
 include/net/hotdata.h     |  7 +++++++
 net/core/dev.c            | 37 +++++++++++++++++++++++++------------
 net/core/dev.h            |  2 +-
 net/core/skbuff.c         | 11 ++++++-----
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5c9aa16933d197f70746d64e5f44cae052d9971c..d1a687444b275d45d105e336d2ede264fd310f1b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3536,10 +3536,6 @@ struct softnet_data {
 
 	struct numa_drop_counters drop_counters;
 
-	/* Another possibly contended cache line */
-	struct llist_head	defer_list ____cacheline_aligned_in_smp;
-	atomic_long_t		defer_count;
-
 	int			defer_ipi_scheduled ____cacheline_aligned_in_smp;
 	call_single_data_t	defer_csd;
 };
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index fda94b2647ffa242c256c95ae929d9ef25e54f96..4acec191c54ab367ca12fff590d1f8c8aad64651 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -2,10 +2,16 @@
 #ifndef _NET_HOTDATA_H
 #define _NET_HOTDATA_H
 
+#include <linux/llist.h>
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <net/protocol.h>
 
+struct skb_defer_node {
+	struct llist_head	defer_list;
+	atomic_long_t		defer_count;
+} ____cacheline_aligned_in_smp;
+
 /* Read mostly data used in network fast paths. */
 struct net_hotdata {
 #if IS_ENABLED(CONFIG_INET)
@@ -30,6 +36,7 @@ struct net_hotdata {
 	struct rps_sock_flow_table __rcu *rps_sock_flow_table;
 	u32			rps_cpu_mask;
 #endif
+	struct skb_defer_node __percpu *skb_defer_nodes;
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
diff --git a/net/core/dev.c b/net/core/dev.c
index fb67372774de10b0b112ca71c7c7a13819c2325b..afcf07352eaa3b9a563173106c84167ebe1ab387 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5180,8 +5180,9 @@ static void napi_schedule_rps(struct softnet_data *sd)
 	__napi_schedule_irqoff(&mysd->backlog);
 }
 
-void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
+void kick_defer_list_purge(unsigned int cpu)
 {
+	struct softnet_data *sd = &per_cpu(softnet_data, cpu);
 	unsigned long flags;
 
 	if (use_backlog_threads()) {
@@ -6715,18 +6716,26 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 }
 EXPORT_SYMBOL(napi_complete_done);
 
-static void skb_defer_free_flush(struct softnet_data *sd)
+struct skb_defer_node __percpu *skb_defer_nodes;
+
+static void skb_defer_free_flush(void)
 {
 	struct llist_node *free_list;
 	struct sk_buff *skb, *next;
+	struct skb_defer_node *sdn;
+	int node;
 
-	if (llist_empty(&sd->defer_list))
-		return;
-	atomic_long_set(&sd->defer_count, 0);
-	free_list = llist_del_all(&sd->defer_list);
+	for_each_node(node) {
+		sdn = this_cpu_ptr(net_hotdata.skb_defer_nodes) + node;
 
-	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
-		napi_consume_skb(skb, 1);
+		if (llist_empty(&sdn->defer_list))
+			continue;
+		atomic_long_set(&sdn->defer_count, 0);
+		free_list = llist_del_all(&sdn->defer_list);
+
+		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
+			napi_consume_skb(skb, 1);
+		}
 	}
 }
 
@@ -6854,7 +6863,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
-		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
+		skb_defer_free_flush();
 		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
@@ -7713,7 +7722,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 			local_irq_disable();
 			net_rps_action_and_irq_enable(sd);
 		}
-		skb_defer_free_flush(sd);
+		skb_defer_free_flush();
 		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
@@ -7755,7 +7764,7 @@ static __latent_entropy void net_rx_action(void)
 	for (;;) {
 		struct napi_struct *n;
 
-		skb_defer_free_flush(sd);
+		skb_defer_free_flush();
 
 		if (list_empty(&list)) {
 			if (list_empty(&repoll)) {
@@ -12989,7 +12998,6 @@ static int __init net_dev_init(void)
 		sd->cpu = i;
 #endif
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
-		init_llist_head(&sd->defer_list);
 
 		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
@@ -12999,6 +13007,11 @@ static int __init net_dev_init(void)
 		if (net_page_pool_create(i))
 			goto out;
 	}
+	net_hotdata.skb_defer_nodes =
+		 __alloc_percpu(sizeof(struct skb_defer_node) * nr_node_ids,
+				__alignof__(struct skb_defer_node));
+	if (!net_hotdata.skb_defer_nodes)
+		goto out;
 	if (use_backlog_threads())
 		smpboot_register_percpu_thread(&backlog_threads);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index d6b08d435479b2ba476b1ddeeaae1dce6ac875a2..900880e8b5b4b9492eca23a4d9201045e6bf7f74 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -357,7 +357,7 @@ static inline void napi_assert_will_not_race(const struct napi_struct *napi)
 	WARN_ON(READ_ONCE(napi->list_owner) != -1);
 }
 
-void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
+void kick_defer_list_purge(unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 22d9dba0e433cf67243a5b7dda77e61d146baf50..03ed51050efe81b582c2bad147afecce3a7115e1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7184,9 +7184,9 @@ static void kfree_skb_napi_cache(struct sk_buff *skb)
  */
 void skb_attempt_defer_free(struct sk_buff *skb)
 {
+	struct skb_defer_node *sdn;
 	unsigned long defer_count;
 	int cpu = skb->alloc_cpu;
-	struct softnet_data *sd;
 	unsigned int defer_max;
 	bool kick;
 
@@ -7200,14 +7200,15 @@ nodefer:	kfree_skb_napi_cache(skb);
 	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
 
-	sd = &per_cpu(softnet_data, cpu);
+	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
+
 	defer_max = READ_ONCE(net_hotdata.sysctl_skb_defer_max);
-	defer_count = atomic_long_inc_return(&sd->defer_count);
+	defer_count = atomic_long_inc_return(&sdn->defer_count);
 
 	if (defer_count >= defer_max)
 		goto nodefer;
 
-	llist_add(&skb->ll_node, &sd->defer_list);
+	llist_add(&skb->ll_node, &sdn->defer_list);
 
 	/* Send an IPI every time queue reaches half capacity. */
 	kick = (defer_count - 1) == (defer_max >> 1);
@@ -7216,7 +7217,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
 	if (unlikely(kick))
-		kick_defer_list_purge(sd, cpu);
+		kick_defer_list_purge(cpu);
 }
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
-- 
2.51.0.536.g15c5d4f767-goog


