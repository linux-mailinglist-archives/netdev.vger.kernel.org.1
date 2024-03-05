Return-Path: <netdev+bounces-77595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4928723AB
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3240B24359
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F512A156;
	Tue,  5 Mar 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMlpgen9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A312AAC0
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654700; cv=none; b=ol/hU7f/jTj98/uJHGf4KGq+GWET+3/lORXL6oOJImUq7qolyfe9hG5XF7IrzwtAcl1+H4JuUENnLxTHg5mUXX6uhrYZk2r7LlBI4K+Uc17T+KxqDGcUJtdMNlPlc+61axd9J7l+7Tcvzyt7KcUYdAzf+f7QqZopBnLyueT3OLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654700; c=relaxed/simple;
	bh=4afPVHI5thGgU7g6ZCN0kgXLob+BBsFTw9blvYx9pHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kzHcMSrZXyu6vVnD4k/UHfv/yAkO1iRUGHgmcZPh69eYIg40nsLh26sE7ZSerRmIyTDE6Ggpm9XtdyEV53b6et/sSZK/0FUNedZNJjrrYTiSokzzcWV+6Rb6+R8xoDlLBlzrM54ZC+2WPb7oUNWIBNgTiTer7ZRHLXfHwxCodTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMlpgen9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so10204708276.2
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654684; x=1710259484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFQRLyiXLEhWnxUI5NjDOfXwmcvwbMhEFic/5d2k5A8=;
        b=bMlpgen9mnNxZ2cEewmKY2Qq5vU+zh/A2lppgnvW18bF6kGN0MvmFm8ntUd98Ohmat
         BVG9EJ5lhTzHdmUCXYeOrU0PxyOT09pStH8bha8W2CuyBZlF5vm/CfQkWZA3DB3vxbpI
         R5nH8FJ4vsLQpvdDCOC3aHj9nabMsNr1Ycm1UZaTnVyZ2+WbvBdY0WFvG/KoVXA8L4fc
         4yNSeI4RP4TDTvHWjheh6Ux4aR8dcTg0HY+7C91/l4VOHGs1xVdDZDAozOKk+RjoMdlV
         KURNtHr7Oz+C57XoKD+Wn/+z39q6TS89ZSroMQKnpByFJVl3i4DXDzIY6Lds6Ma8DbhU
         +lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654684; x=1710259484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFQRLyiXLEhWnxUI5NjDOfXwmcvwbMhEFic/5d2k5A8=;
        b=s+fv05tAMrIN7JECihxUVvrk5GUWTA2tqrOLBMBAQbrw8wDvgVDCFNC+PgVRAehhoA
         iwDuE0+qi1a4tkYdFDlJElSlsB1I4uhwySfpp0nChJqBfizdlzbLvhU1VNoq3hJtg8Mt
         NYgp4iEu9uHcLGjrzTwrWHQHISRWxw8wV8TrlK551ZPh1bLFjK/4mH6dJoZ5GX5cRth2
         ZyKHFizIU5ywvibm8uATAhJkNuHCMRsMYRQ7DefC3LUWMjTD9ob+AgPpV2dsIfDobc1A
         6YlDAdhaiXQC6jRAqWBLwkfQ596elIVfi4JiDtBvtq18rPj7Su4iM6xyUIkQkTFzkNhk
         Cydw==
X-Gm-Message-State: AOJu0YxJKEznPhE1NGlMkIBuEgN6PxdYR8ws0SKDwMZS9GJRsu6DaU2y
	n7Ec+MJ4GEKkTgwfex5xhRwJCtk6cap0HQTWIiK3bTyZVci0X0xmSGTE4jc5HBiG+sZqyJ+MQvV
	Jyhw9PWY7rw==
X-Google-Smtp-Source: AGHT+IHce2ux2BZZB57E5FwCGXXKXy93aS+WYrt2VCfgS1Vh8DQI3PM6KmFsu5Lla102GXz7lu8Ct/Yjco6X1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1081:b0:dc7:8e30:e2e3 with SMTP
 id v1-20020a056902108100b00dc78e30e2e3mr3178799ybu.2.1709654684142; Tue, 05
 Mar 2024 08:04:44 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:13 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-19-edumazet@google.com>
Subject: [PATCH net-next 18/18] net: move rps_sock_flow_table to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rps_sock_flow_table and rps_cpu_mask are used in fast path.

Move them to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      |  4 ++++
 include/net/rps.h          |  8 +++-----
 net/core/dev.c             | 12 +++---------
 net/core/sysctl_net_core.c |  9 ++++++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 0a0a9106b40030f56b04c1e48083c13498ce0939..7bb6e46aec8f19deff42112041feb47724cdd538 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -27,6 +27,10 @@ struct net_hotdata {
 	struct kmem_cache	*skbuff_cache;
 	struct kmem_cache	*skbuff_fclone_cache;
 	struct kmem_cache	*skb_small_head_cache;
+#ifdef CONFIG_RPS
+	struct rps_sock_flow_table __rcu *rps_sock_flow_table;
+	u32			rps_cpu_mask;
+#endif
 	int			gro_normal_batch;
 	int			netdev_budget;
 	int			netdev_budget_usecs;
diff --git a/include/net/rps.h b/include/net/rps.h
index 6081d817d2458b7b34036d87fbdef3fa6dc914ea..7660243e905b92651a41292e04caf72c5f12f26e 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/static_key.h>
 #include <net/sock.h>
+#include <net/hotdata.h>
 
 #ifdef CONFIG_RPS
 
@@ -64,14 +65,11 @@ struct rps_sock_flow_table {
 
 #define RPS_NO_CPU 0xffff
 
-extern u32 rps_cpu_mask;
-extern struct rps_sock_flow_table __rcu *rps_sock_flow_table;
-
 static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 					u32 hash)
 {
 	unsigned int index = hash & table->mask;
-	u32 val = hash & ~rps_cpu_mask;
+	u32 val = hash & ~net_hotdata.rps_cpu_mask;
 
 	/* We only give a hint, preemption can change CPU under us */
 	val |= raw_smp_processor_id();
@@ -93,7 +91,7 @@ static inline void sock_rps_record_flow_hash(__u32 hash)
 	if (!hash)
 		return;
 	rcu_read_lock();
-	sock_flow_table = rcu_dereference(rps_sock_flow_table);
+	sock_flow_table = rcu_dereference(net_hotdata.rps_sock_flow_table);
 	if (sock_flow_table)
 		rps_record_sock_flow(sock_flow_table, hash);
 	rcu_read_unlock();
diff --git a/net/core/dev.c b/net/core/dev.c
index e9f24a31ae121f713e6ef5a530a65218bbb457e8..9f54d8e61ec0f4a4ad1824e333f89ad08c5ec431 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4450,12 +4450,6 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 
 #ifdef CONFIG_RPS
 
-/* One global table that all flow-based protocols share. */
-struct rps_sock_flow_table __rcu *rps_sock_flow_table __read_mostly;
-EXPORT_SYMBOL(rps_sock_flow_table);
-u32 rps_cpu_mask __read_mostly;
-EXPORT_SYMBOL(rps_cpu_mask);
-
 struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
@@ -4547,7 +4541,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	if (!hash)
 		goto done;
 
-	sock_flow_table = rcu_dereference(rps_sock_flow_table);
+	sock_flow_table = rcu_dereference(net_hotdata.rps_sock_flow_table);
 	if (flow_table && sock_flow_table) {
 		struct rps_dev_flow *rflow;
 		u32 next_cpu;
@@ -4557,10 +4551,10 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
 		 */
 		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
-		if ((ident ^ hash) & ~rps_cpu_mask)
+		if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
 			goto try_rps;
 
-		next_cpu = ident & rps_cpu_mask;
+		next_cpu = ident & net_hotdata.rps_cpu_mask;
 
 		/* OK, now we know there is a match,
 		 * we can look at the local (per receive queue) flow table
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 4b93e27404e83a5b3afaa23ebd18cf55b1fdc6e8..6973dda3abda63e0924efa4b6b7026786e8bfb4f 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -140,7 +140,8 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 
 	mutex_lock(&sock_flow_mutex);
 
-	orig_sock_table = rcu_dereference_protected(rps_sock_flow_table,
+	orig_sock_table = rcu_dereference_protected(
+					net_hotdata.rps_sock_flow_table,
 					lockdep_is_held(&sock_flow_mutex));
 	size = orig_size = orig_sock_table ? orig_sock_table->mask + 1 : 0;
 
@@ -161,7 +162,8 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 					mutex_unlock(&sock_flow_mutex);
 					return -ENOMEM;
 				}
-				rps_cpu_mask = roundup_pow_of_two(nr_cpu_ids) - 1;
+				net_hotdata.rps_cpu_mask =
+					roundup_pow_of_two(nr_cpu_ids) - 1;
 				sock_table->mask = size - 1;
 			} else
 				sock_table = orig_sock_table;
@@ -172,7 +174,8 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 			sock_table = NULL;
 
 		if (sock_table != orig_sock_table) {
-			rcu_assign_pointer(rps_sock_flow_table, sock_table);
+			rcu_assign_pointer(net_hotdata.rps_sock_flow_table,
+					   sock_table);
 			if (sock_table) {
 				static_branch_inc(&rps_needed);
 				static_branch_inc(&rfs_needed);
-- 
2.44.0.278.ge034bb2e1d-goog


