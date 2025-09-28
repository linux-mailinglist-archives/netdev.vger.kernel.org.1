Return-Path: <netdev+bounces-226981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368CBA6BD8
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FFC17D515
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78122BE035;
	Sun, 28 Sep 2025 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9CM0cWJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D932BF007
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049383; cv=none; b=p1HJ096by8EOYuwoZOU2un0qFDjSFPGPvVrGNLpXKwBN+nAaihbj1bBGtZaBNqM7L32sLsLnAVA/t3Iw5IW2kKtNL4uqfKHLw6bIzjlXLu/WPsYUu4qfqwN93vKDUD6ovdLouvTYd5t23BkyAQm0wxm3+MPc+gbCCN5gFL7w7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049383; c=relaxed/simple;
	bh=DFli9u4ZbMbWp1sRqJUF1ftdgohd99Hcmv0FcEv56cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nAO8ZCRCLnDlFISQWmaeoXkl0Dbfq+AhjTfvREwLHXgYL5Q97WJPMp70f2oVwvk9xihCyVHO3drfYSpfBua9EZ0OiASUWXvKty6Z0cw6oEKsyM3kj0fsaD1RVpX3mRnBJ9n5pX1QIRfe2A7XCKCwKJapX8Qn0wVqEjihDW+dG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d9CM0cWJ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-78e30eaca8eso110263836d6.2
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759049381; x=1759654181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PP3ipZbNRR+jPBDyd3OAXIDoqJFW7O5Mf85yGxDNXrQ=;
        b=d9CM0cWJC7DA3xMVG4Q1VZH8HxY/dtdRwVfjTVLHqoVaehQEe8FxtCd8qHYgZDwcIr
         zZcjsE4T+uyQO8jG+rCy/s90atP3tM7Ad0MwGj8kBQODZBAhAO1EjuGJZ/7imHyLR9q8
         hQO15tUb4IBSL5iPg3dv5QQ6c9bpaHd2OlbdXlu9DXrnn/AnVQEl/DpQ04E6RYqFAQ9z
         UtMGongxGw5wDJ2FVWo0dMcNa7Jg8s1MWwzhVW5YLc0URd6f5BHosc/zB9YTtrYCxYNn
         9TeGxOGsv9WAoTEtSZ0IR+ra1cS3Q4lgYNO9+ruff2AVUu96lk5MaIgdln/4TvlBJvkq
         7YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759049381; x=1759654181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PP3ipZbNRR+jPBDyd3OAXIDoqJFW7O5Mf85yGxDNXrQ=;
        b=cXCTl4YECqf8lI32AIG6+pdWX4BQ1Dz9rRX9TNcbPNGs0DQtKhi0QOHkj5Cla8l1ef
         lHgrhlYlX4VD0mmiPQ+uEpu2cfLyhKlHTwoeN/ZpjWhkdHP9rwcVxD8V4L3i8HlBJFNd
         qhGG9j1heO/ikitkcIcouPkEZhCHSJ8s/1l3W6VEFhnqnOMXdrmZhmtIVK61Ke/ANljm
         mzXwde4HwmjgC5R1xBQ/voZxAnEX+/0OjRosHegyl6YYZFzmmTWaeXvece2S68+vnjv9
         MZmPV+Ooq6ttgewFgQwJ+s0kFCrCF+6vbGdkC2eNFOZ7JdYCsG+AJyE8IBKhTanhil/E
         yNLg==
X-Forwarded-Encrypted: i=1; AJvYcCXSmvgWa5xCsqJ01tVC8n930tVTWMD+TKh12RsQmWMUls2w8fiWtE6/tpfkiUN4Wa6nAsSOUUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiQzd8bgvHTGmUOJl+unuIH1W46QH08WrFAivkWTP4JSx/UX/
	Q0ZvWMbPR3/rFIc1pGt2b3vsoBLaqAPWpxn0qoUXD0Wis9Q4QQ9ITq6NR3xlzwaXl6tPpx7c2jg
	XFD1NnjP1O9g8Hg==
X-Google-Smtp-Source: AGHT+IGgFF/uS0L+nAhSz4wlMRqmCeVD9w86nyFuYWKAK3OssFEYTYJb8ntnazOUEVpIYwTgmZXW1vEDYMOo8Q==
X-Received: from qvad18.prod.google.com ([2002:a0c:f112:0:b0:7fb:ddb1:1bce])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:e44:b0:787:982:2953 with SMTP id 6a1803df08f44-7fc2fd7a8damr173345056d6.29.1759049380952;
 Sun, 28 Sep 2025 01:49:40 -0700 (PDT)
Date: Sun, 28 Sep 2025 08:49:34 +0000
In-Reply-To: <20250928084934.3266948-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250928084934.3266948-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928084934.3266948-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] net: add NUMA awareness to skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Instead of sharing sd->defer_list & sd->defer_count with
many cpus, add one pair for each NUMA node.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: remove skb_defer_nodes leftover in net/core/dev.c,
    its final location is in net_hotdata (Kuniyuki feedback)

 include/linux/netdevice.h |  4 ----
 include/net/hotdata.h     |  7 +++++++
 net/core/dev.c            | 35 +++++++++++++++++++++++------------
 net/core/dev.h            |  2 +-
 net/core/skbuff.c         | 11 ++++++-----
 5 files changed, 37 insertions(+), 22 deletions(-)

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
index fb67372774de10b0b112ca71c7c7a13819c2325b..a64cef2c537e98ee87776e6f8d3ca3d98f0711b3 100644
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
@@ -6715,18 +6716,24 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 }
 EXPORT_SYMBOL(napi_complete_done);
 
-static void skb_defer_free_flush(struct softnet_data *sd)
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
+
+		if (llist_empty(&sdn->defer_list))
+			continue;
+		atomic_long_set(&sdn->defer_count, 0);
+		free_list = llist_del_all(&sdn->defer_list);
 
-	llist_for_each_entry_safe(skb, next, free_list, ll_node) {
-		napi_consume_skb(skb, 1);
+		llist_for_each_entry_safe(skb, next, free_list, ll_node) {
+			napi_consume_skb(skb, 1);
+		}
 	}
 }
 
@@ -6854,7 +6861,7 @@ static void __napi_busy_loop(unsigned int napi_id,
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
-		skb_defer_free_flush(this_cpu_ptr(&softnet_data));
+		skb_defer_free_flush();
 		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
@@ -7713,7 +7720,7 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 			local_irq_disable();
 			net_rps_action_and_irq_enable(sd);
 		}
-		skb_defer_free_flush(sd);
+		skb_defer_free_flush();
 		bpf_net_ctx_clear(bpf_net_ctx);
 		local_bh_enable();
 
@@ -7755,7 +7762,7 @@ static __latent_entropy void net_rx_action(void)
 	for (;;) {
 		struct napi_struct *n;
 
-		skb_defer_free_flush(sd);
+		skb_defer_free_flush();
 
 		if (list_empty(&list)) {
 			if (list_empty(&repoll)) {
@@ -12989,7 +12996,6 @@ static int __init net_dev_init(void)
 		sd->cpu = i;
 #endif
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
-		init_llist_head(&sd->defer_list);
 
 		gro_init(&sd->backlog.gro);
 		sd->backlog.poll = process_backlog;
@@ -12999,6 +13005,11 @@ static int __init net_dev_init(void)
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


