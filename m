Return-Path: <netdev+bounces-78009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F587873B85
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F9B2367F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB7113E7DE;
	Wed,  6 Mar 2024 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvNqna4a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A5E13E7CD
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740875; cv=none; b=EFve8HZUPUUNS++XNGPFqGHHI0hiFB3eX0MYLekQfE+TzBh0AMeoIveBWPeIa8fDcXjUkpjMvH6RQ8u6gm2hUWmzb45BCCbTCqauiBwzWh5CmdPrfKza1Fp1B9CYL2YfztXfPOUyMlj03SGVST1isfe8fk1SH5rAPVZa+Xa/xZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740875; c=relaxed/simple;
	bh=mixqPoC7wBm3Hfn9Y8bfZrYiNcXavH1UGM4b4KcTeN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ldD0h5f7GOAElt1l5fVZeJKjArz6cM5eW3XHp/AhVQz063gUUgWv/5KQbqq3qIlMxT9YpheJuprRfn32M2bY4DKowpHYb6CkE6CemgcWZPkXfkmHf1TLbXihp7XQg0R3oo+O6vi0lcWBZSEeFdzU97C1fmUtQee1ZS8msEliwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvNqna4a; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso1384724276.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740872; x=1710345672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yZqZtL36XlZ0L93IPccEZyr0UkHGWH0yynvNuk+9H1s=;
        b=yvNqna4aW5Qo+QP9mNqvUfbVLZyzH9RPDUcu6CH3LirtZdMBhDGSXZ06Zk7IO86nzL
         x+XgeNKar54U3eeCKDMCr5AFFtEZ+XHGnOmMUozT0pbJuYlpI3FQdRiRvY1K+cvwViX9
         2fq60Hvh9V7qfMI49oT70udAtLhL3/aan5ngfrFIOwMHp8TrRpt8sKLKNcdNvkhzq4dL
         1fiyZNpXiHWkaQk2E746jsWOhP9k6A0w2nonBSKLgimog1FEjwpMjZyJ+LSjUhNqcIp+
         GPWjPg3cQ6nAGT5oT5LxPvipUPy+vxH87qnq6MEeM9L425iZCjGU2k7uYPesA5gHSarA
         7Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740872; x=1710345672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZqZtL36XlZ0L93IPccEZyr0UkHGWH0yynvNuk+9H1s=;
        b=jwrfOfnceuUDIyJklxiqEMrfJP92nfkKT/RYBrB/0a//SYmHNtwD9394CcVr1Tfsdz
         LeRJQXr5mbgQQ11wiGio69Ixo0+sDo6hvA7nBbJeYz5u6BRIS+7yyxrt4Xj5ntkv0cY7
         IsYgD8p4MV0djl9YwfjoH817NIJ3qn75VJgaxw8EgGjQNd2gcJFIEvkyKt+8TbDAc+OD
         FDzCnTWxqUt+DrvUi7SyGn4F8XsWoQwwHih5OjElkzfEfpui00hb6hsBZ7KVcv7FlUuZ
         /uFTtvM3zuyvfle7cX7wK8NPMkYEVh7Yuw47OIKSFKq35ZtHDS6ZMBOIEB/hd2GQlkkO
         iBWw==
X-Forwarded-Encrypted: i=1; AJvYcCVAQwh8YMRcVSq2xerL6hr+gmXmK7CpyM8/JEvBQGxU0rxC+jF8Qp3OiEn+39OdkDw4jOgX69LiobIS8cTGsyEmWWY+/wtt
X-Gm-Message-State: AOJu0Yz+NnJz7VsFluLqXaYtLLIfBowBbmOLdaeWlVJWrJ95KBDS4eR3
	iABImlXpe+BYuOlF1gHMc8otaNjCApFm4laDTvI89xZms/K4SqSzf+oQzQLmekeeWKVMwR/6G/K
	ndywYNSMK+Q==
X-Google-Smtp-Source: AGHT+IF0Q/aIuW1PYjs+Eu4RDg3Qvm/kVHGsiW5z21Ud90L5/sSOHv1QGWf/8uqbqtWhcYsdZu+uCya3eoyI/g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:54c:0:b0:dc7:5925:92d2 with SMTP id
 r12-20020a5b054c000000b00dc7592592d2mr1157339ybp.1.1709740872542; Wed, 06 Mar
 2024 08:01:12 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:31 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-19-edumazet@google.com>
Subject: [PATCH v2 net-next 18/18] net: move rps_sock_flow_table to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

rps_sock_flow_table and rps_cpu_mask are used in fast path.

Move them to net_hotdata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h      |  4 ++++
 include/net/rps.h          |  8 +++-----
 net/core/dev.c             | 12 +++---------
 net/core/sysctl_net_core.c |  9 ++++++---
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index b0b847585f7e62245cee81a56b5a252051e07834..003667a1efd6b63fc0f0d7cadd2c8472281331b0 100644
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


