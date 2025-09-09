Return-Path: <netdev+bounces-221197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6282B4FA89
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87611886F28
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3AC1E0DE3;
	Tue,  9 Sep 2025 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ijIqDYyq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E9178372
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757420390; cv=none; b=Tr50vqUFfl6D5n9tTd6u9b4s3iYNr56zx3KDAI0tiu0eVJGXk8u8E33WmG49a/uPShlEFSEkhBhY/9xcE2+HLtMhbQuM2pNEJTSTbZskCntlWyglqZxYRuXhJ+qknMXlmovV3w23dvxigFWE+X/Mep940PiAma5/GHTbItZlyDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757420390; c=relaxed/simple;
	bh=A6PFxe7JxmFPu8qZGsuN5Kn15ua4vF/EEArxSxmBA14=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bwN8onZMH/YtfFxtaQB6xoiYYOWPomV5bT6shUfHJTEnKz1xVeGDL7+ZCG4A43Ij073pK/P9GVGbHOoqqdKV/zdVXfE1NK9uZmcHxePGF+/YqoEEhQ4kB93wxPevHoY8bkDKnOZSXVEm23O5fxMOoRkyt4jSkuYAHpVb7e3xUJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ijIqDYyq; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e870315c98so2174846485a.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757420388; x=1758025188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=giwHdK3Mfv46Z87kT5NA1CnepIrtZb4LT3nCyX16Kyo=;
        b=ijIqDYyqd9JkMUrRWCYKVZcsxxxOkKZ0Sz6E4w5PZBpBKV46jDH7KLsh+u+uOpyS6X
         n9nPzkVmadl5pza4RNpvsqtMbFoAsUMZvIadwKaU+mrh5LDisV9Ikxbn4V/e2r/H4j2+
         +ATqBM6OW8/paoMfgPDawmuKiATVtHdE4na4jOpDteDyXUR+RG9js2JlEZEbjckD8d3j
         uLfQfvQzHuyMFhgzEELnKPfYFII1TBCsp7RBCK7Rcex4vZN0Vz9ishQhFMCmJqC4zq2E
         rVZ7VnjF4g9XLfhPDOBKMa8EXym+R00HS3JGHwEpMh+mET2v2C+2yafEx+bcL7BdQ58f
         VV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757420388; x=1758025188;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giwHdK3Mfv46Z87kT5NA1CnepIrtZb4LT3nCyX16Kyo=;
        b=UzEkdVHCS9XoQ6NpHy8luYcReN0qUyw2gU1qdbflxIGDtP+LDmqAYjlD64yL0YnKUH
         nWgzZX1j7h9lNO6p99tSE2MWMFqVuVM0MXnE5zZot2Z6OP3FM1HUsNLnHgf/4qDvqWqD
         +wvI/InE2bk/A7wOrhR791cU/89jmm3sYn34XwShYb1WzyS67sRrQoZeyACxTnMlgzhp
         Sd2VLqOfnMsPOfc4mpP0/Cd/7oXWSujNInpC/JLUhBUjIOreWYbCrqwZnUykYJIpPV8u
         red6NQuUbi6k+RvtDEzXQ7XHdeHRQHen1jjrnbCHpBS8ILWwW9Hn/tj+t6gHmKuM7YtW
         86xg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KzBEHDgaWl2E8iKU4A5VFaKXNbNbIhoqN5mtM/t3Sm53ZeUUbtO1TV7A1BOWKHGgFbc+8wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1q0LWoTJPjOxT4p6SpQKzL9gQJPSr3vamCGOCv95Rb0gGCJpL
	EY9GoGSLoJ3zIM4hiS0WE/YYaiRnQzInFywwiS0CX+kWALajWqGksPO47a5ti1UfpwsECQ3BU/m
	VjkcfBq4hvcqUwA==
X-Google-Smtp-Source: AGHT+IFZByZMnMQpHKrwIqhVwrgaEWZaXvv6tKNO0ZfrtvQCLK1LFizzTlVr10YMr5KDchBPypCzIiqRzd0h6w==
X-Received: from qkbdl8.prod.google.com ([2002:a05:620a:1d08:b0:807:3657:89cc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3186:b0:811:936a:d0b5 with SMTP id af79cd13be357-813c2efcd37mr1113543685a.65.1757420384869;
 Tue, 09 Sep 2025 05:19:44 -0700 (PDT)
Date: Tue,  9 Sep 2025 12:19:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909121942.1202585-1-edumazet@google.com>
Subject: [PATCH net-next] net: use NUMA drop counters for softnet_data.dropped
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Hosts under DOS attack can suffer from false sharing
in enqueue_to_backlog() : atomic_inc(&sd->dropped).

This is because sd->dropped can be touched from many cpus,
possibly residing on different NUMA nodes.

Generalize the sk_drop_counters infrastucture
added in commit c51613fa276f ("net: add sk->sk_drop_counters")
and use it to replace softnet_data.dropped
with NUMA friendly softnet_data.drop_counters.

This adds 64 bytes per cpu, maybe more in the future
if we increase the number of counters (currently 2)
per 'struct numa_drop_counters'.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h      |  2 +-
 include/linux/netdevice.h | 28 +++++++++++++++++++++++++++-
 include/linux/udp.h       |  2 +-
 include/net/raw.h         |  2 +-
 include/net/sock.h        | 37 ++++++++++++-------------------------
 net/core/dev.c            |  2 +-
 net/core/net-procfs.c     |  3 ++-
 7 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 261d02efb615cfb7fa5717a88c1b2612ef0cbd82..f43314517396777105cc20ba30cac9c651b7dbf9 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -295,7 +295,7 @@ struct raw6_sock {
 	__u32			offset;		/* checksum offset  */
 	struct icmp6_filter	filter;
 	__u32			ip6mr_table;
-	struct socket_drop_counters drop_counters;
+	struct numa_drop_counters drop_counters;
 	struct ipv6_pinfo	inet6;
 };
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb1b883a970b04634c1ef3e7ee5407..f5a840c07cf10eac05f5317baf46c771a043bd2c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3459,6 +3459,32 @@ static inline bool dev_has_header(const struct net_device *dev)
 	return dev->header_ops && dev->header_ops->create;
 }
 
+struct numa_drop_counters {
+	atomic_t	drops0 ____cacheline_aligned_in_smp;
+	atomic_t	drops1 ____cacheline_aligned_in_smp;
+};
+
+static inline int numa_drop_read(const struct numa_drop_counters *ndc)
+{
+	return atomic_read(&ndc->drops0) + atomic_read(&ndc->drops1);
+}
+
+static inline void numa_drop_add(struct numa_drop_counters *ndc, int val)
+{
+	int n = numa_node_id() % 2;
+
+	if (n)
+		atomic_add(val, &ndc->drops1);
+	else
+		atomic_add(val, &ndc->drops0);
+}
+
+static inline void numa_drop_reset(struct numa_drop_counters *ndc)
+{
+	atomic_set(&ndc->drops0, 0);
+	atomic_set(&ndc->drops1, 0);
+}
+
 /*
  * Incoming packets are placed on per-CPU queues
  */
@@ -3504,7 +3530,7 @@ struct softnet_data {
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
 
-	atomic_t		dropped ____cacheline_aligned_in_smp;
+	struct numa_drop_counters drop_counters;
 
 	/* Another possibly contended cache line */
 	spinlock_t		defer_lock ____cacheline_aligned_in_smp;
diff --git a/include/linux/udp.h b/include/linux/udp.h
index 981506be1e15ad3aa831c1d4884372b2a477f988..6ed008ab166557e868c1918daaaa5d551b7989a7 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -108,7 +108,7 @@ struct udp_sock {
 	 * the last UDP socket cacheline.
 	 */
 	struct hlist_node	tunnel_list;
-	struct socket_drop_counters drop_counters;
+	struct numa_drop_counters drop_counters;
 };
 
 #define udp_test_bit(nr, sk)			\
diff --git a/include/net/raw.h b/include/net/raw.h
index d5270913906077f88cbd843ed1edde345b4d42d7..66c0ffeada2eb10711e7ca7a7f05e6e36817e070 100644
--- a/include/net/raw.h
+++ b/include/net/raw.h
@@ -81,7 +81,7 @@ struct raw_sock {
 	struct inet_sock   inet;
 	struct icmp_filter filter;
 	u32		   ipmr_table;
-	struct socket_drop_counters drop_counters;
+	struct numa_drop_counters drop_counters;
 };
 
 #define raw_sk(ptr) container_of_const(ptr, struct raw_sock, inet.sk)
diff --git a/include/net/sock.h b/include/net/sock.h
index 896bec2d2176638460345c6fac5614f63df215d7..0fd465935334160eeda7c1ea608f5d6161f02cb1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -102,11 +102,6 @@ struct net;
 typedef __u32 __bitwise __portpair;
 typedef __u64 __bitwise __addrpair;
 
-struct socket_drop_counters {
-	atomic_t	drops0 ____cacheline_aligned_in_smp;
-	atomic_t	drops1 ____cacheline_aligned_in_smp;
-};
-
 /**
  *	struct sock_common - minimal network layer representation of sockets
  *	@skc_daddr: Foreign IPv4 addr
@@ -287,7 +282,7 @@ struct sk_filter;
   *	@sk_err_soft: errors that don't cause failure but are the cause of a
   *		      persistent failure not just 'timed out'
   *	@sk_drops: raw/udp drops counter
-  *	@sk_drop_counters: optional pointer to socket_drop_counters
+  *	@sk_drop_counters: optional pointer to numa_drop_counters
   *	@sk_ack_backlog: current listen backlog
   *	@sk_max_ack_backlog: listen backlog set in listen()
   *	@sk_uid: user id of owner
@@ -456,7 +451,7 @@ struct sock {
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
-	struct socket_drop_counters *sk_drop_counters;
+	struct numa_drop_counters *sk_drop_counters;
 	__cacheline_group_end(sock_read_rxtx);
 
 	__cacheline_group_begin(sock_write_rxtx);
@@ -2698,18 +2693,12 @@ struct sock_skb_cb {
 
 static inline void sk_drops_add(struct sock *sk, int segs)
 {
-	struct socket_drop_counters *sdc = sk->sk_drop_counters;
+	struct numa_drop_counters *ndc = sk->sk_drop_counters;
 
-	if (sdc) {
-		int n = numa_node_id() % 2;
-
-		if (n)
-			atomic_add(segs, &sdc->drops1);
-		else
-			atomic_add(segs, &sdc->drops0);
-	} else {
+	if (ndc)
+		numa_drop_add(ndc, segs);
+	else
 		atomic_add(segs, &sk->sk_drops);
-	}
 }
 
 static inline void sk_drops_inc(struct sock *sk)
@@ -2719,23 +2708,21 @@ static inline void sk_drops_inc(struct sock *sk)
 
 static inline int sk_drops_read(const struct sock *sk)
 {
-	const struct socket_drop_counters *sdc = sk->sk_drop_counters;
+	const struct numa_drop_counters *ndc = sk->sk_drop_counters;
 
-	if (sdc) {
+	if (ndc) {
 		DEBUG_NET_WARN_ON_ONCE(atomic_read(&sk->sk_drops));
-		return atomic_read(&sdc->drops0) + atomic_read(&sdc->drops1);
+		return numa_drop_read(ndc);
 	}
 	return atomic_read(&sk->sk_drops);
 }
 
 static inline void sk_drops_reset(struct sock *sk)
 {
-	struct socket_drop_counters *sdc = sk->sk_drop_counters;
+	struct numa_drop_counters *ndc = sk->sk_drop_counters;
 
-	if (sdc) {
-		atomic_set(&sdc->drops0, 0);
-		atomic_set(&sdc->drops1, 0);
-	}
+	if (ndc)
+		numa_drop_reset(ndc);
 	atomic_set(&sk->sk_drops, 0);
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 1d1650d9ecff4a863b3449bf88d7201d72ec8e33..2522d9d8f0e4d0da3488afe98f46501eeecd5b51 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5248,7 +5248,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	backlog_unlock_irq_restore(sd, &flags);
 
 cpu_backlog_drop:
-	atomic_inc(&sd->dropped);
+	numa_drop_add(&sd->drop_counters, 1);
 bad_dev:
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 4f0f0709a1cbc702dc44debc6325d20008b08d86..70e0e9a3b650c0753f0b865642aa372a956a4bf5 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -145,7 +145,8 @@ static int softnet_seq_show(struct seq_file *seq, void *v)
 	seq_printf(seq,
 		   "%08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x %08x "
 		   "%08x %08x\n",
-		   READ_ONCE(sd->processed), atomic_read(&sd->dropped),
+		   READ_ONCE(sd->processed),
+		   numa_drop_read(&sd->drop_counters),
 		   READ_ONCE(sd->time_squeeze), 0,
 		   0, 0, 0, 0, /* was fastroute */
 		   0,	/* was cpu_collision */
-- 
2.51.0.384.g4c02a37b29-goog


