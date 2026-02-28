Return-Path: <netdev+bounces-262080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8FI19uomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F191C0422
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E8CB308831F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B2EFD9B;
	Sat, 28 Feb 2026 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oc5bhWX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FEF3A1B5
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252714; cv=none; b=hVTLUdcDxmR5Latcs3fqGnfO8R1ZxxQqu6TldwwbDmm44ItSAMtzBvC98Ce1OlAughQIUrs18qaJ3HJ2zIZO2T0mTYUxVxueAGkV98V8ERQaDpFiUzilE0PiX99hUiU6z3yMxPpvust2d3kEH7+vmU1iOhW0XT1jYelsZ9tBshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252714; c=relaxed/simple;
	bh=E8KEwQ7Z4ABqxWLdKx7tzXKWeIFUD6ARKRORRBnuz+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4tw70CHDd0v7ELVKSu0/nIxyyJl91Hn9g2Z0yKd/YlL7FarZ4Hnw4NbYMIxXPQOwUl6/9eWN+2d84ATqONx13JlTxJW7HOCp09QNcSUVZv7de+inXkdJCoY10ZWjyakObq0vJr9wtyLRIlZxQphKd0xqwV4BEIeoZpiUpL3UTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oc5bhWX4; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb4b8e9112so226913585a.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252711; x=1772857511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11T0pl60MmxdGgaZQO5VGzKw7hv2NPy3DoOjXdXt2GQ=;
        b=Oc5bhWX4XE15NDu3An0Dw1+1tNcvgGuavpezdVi352hjTcL6Kq8i9kF28tVjQK+kC/
         tUx7zAhDqZl5LePILOuNK1e8N+nMZ4lngfFP2ejBUPt00NrVLGFnPPe/UTIZ3HYEsyKc
         FxK0RIL+IXKPKxnTKR8LTCYfByJBQXwqI9yEsIrgX15EMz8BVkpn2BVNMUx6M2THOxL1
         unK5nhfr/nQ5ckklwgtXRp6OokrbeiAr6noFNXXT/NqA8guZA1Q7gxS/DEG4JHwujewN
         gUk+Lp8I/sTw481RiRAUj9ZDO0IWFyTG56FEQ+EiTebkD/4SLH+mZBbCnP4UNq3OXdNm
         gdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252711; x=1772857511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11T0pl60MmxdGgaZQO5VGzKw7hv2NPy3DoOjXdXt2GQ=;
        b=pnymzhhe7EY03azBLcFYKCrgIqZ256DSyMGzIcec40Udfta+0V3sOW7rf5FIhywYhZ
         42ZffKbwPuF1F3HC0fLUioL1D3v+VhzwzvRQ2joDw6QmH7003A0zwVjtYEuoTqKP1+fl
         1dXl4fnje675YE/8PC79SiWKw/0duV761JbYTBmT4cLEDkndu2l6V8gNpqXQd20oibd2
         GyRYjAK83Tvb9dW8RcH2pBABF+hhqPgeQZF6eGFaAKOsevQTReSdg+S7rWRwVtpK/FW0
         EFV85AxDykBE5C8gI9l8GwnhopMeCl0A6nrrCpi3kUnr97weoRJSqVQ6QVvdBT4sn1XZ
         JGgg==
X-Forwarded-Encrypted: i=1; AJvYcCUnU2aizo7XR4JlUsB3i5nwvJ7rA7d84euYikWKHeI4OEWgiLMDN4BIVCYohiceHTM6Mfd1efc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQv3LtSTgMELqpULcDCOfSASnfCEDvgusBUiQw7SIZT3VvCUX
	8G5tkro+20d6+fowXEcT5KWEtZmkYdMmasDW+CBmpLKghtrZrgPwGSsyDBDdISzqaV/WqAjIWD1
	BxDt54yynMknJzg==
X-Received: from qknvj4.prod.google.com ([2002:a05:620a:7084:b0:8b1:603e:cece])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a0e:b0:8c9:e989:9d97 with SMTP id af79cd13be357-8cbc8f4d142mr668046085a.68.1772252711387;
 Fri, 27 Feb 2026 20:25:11 -0800 (PST)
Date: Sat, 28 Feb 2026 04:25:00 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-5-edumazet@google.com>
Subject: [PATCH net-next 4/7] net-sysfs: use rps_tag_ptr and remove metadata
 from rps_sock_flow_table
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262080-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9F191C0422
X-Rspamd-Action: no action

Instead of storing the @mask at the beginning of rps_sock_flow_table,
use 5 low order bits of the rps_tag_ptr to store the log of the size.

This removes a potential cache line miss to fetch @mask.

More importantly, we can switch to vmalloc_huge() without wasting memory.

Tested with:

numactl --interleave=all bash -c "echo 4194304 >/proc/sys/net/core/rps_sock_flow_entries"

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/scaling.rst | 13 ++--
 include/net/hotdata.h                |  5 +-
 include/net/rps.h                    | 33 +++++-----
 net/core/dev.c                       | 10 ++--
 net/core/sysctl_net_core.c           | 90 +++++++++++++++-------------
 5 files changed, 82 insertions(+), 69 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 0023afa530ec166bb13558318053ff5ed0906b71..6c261eb48845a40516f201233df13694863ee8cd 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -403,16 +403,21 @@ Both of these need to be set before RFS is enabled for a receive queue.
 Values for both are rounded up to the nearest power of two. The
 suggested flow count depends on the expected number of active connections
 at any given time, which may be significantly less than the number of open
-connections. We have found that a value of 32768 for rps_sock_flow_entries
-works fairly well on a moderately loaded server.
+connections. We have found that a value of 65536 for rps_sock_flow_entries
+works fairly well on a moderately loaded server. Big servers might
+need 1048576 or even higher values.
+
+On a NUMA host it is advisable to spread rps_sock_flow_entries on all nodes.
+
+numactl --interleave=all bash -c "echo 1048576 >/proc/sys/net/core/rps_sock_flow_entries"
 
 For a single queue device, the rps_flow_cnt value for the single queue
 would normally be configured to the same value as rps_sock_flow_entries.
 For a multi-queue device, the rps_flow_cnt for each queue might be
 configured as rps_sock_flow_entries / N, where N is the number of
-queues. So for instance, if rps_sock_flow_entries is set to 32768 and there
+queues. So for instance, if rps_sock_flow_entries is set to 131072 and there
 are 16 configured receive queues, rps_flow_cnt for each queue might be
-configured as 2048.
+configured as 8192.
 
 
 Accelerated RFS
diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 6632b1aa7584821fd4ab42163b77dfff6732a45e..62534d1f3c707038cd6b805ccc1889e7709d999d 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -6,6 +6,9 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <net/protocol.h>
+#ifdef CONFIG_RPS
+#include <net/rps-types.h>
+#endif
 
 struct skb_defer_node {
 	struct llist_head	defer_list;
@@ -33,7 +36,7 @@ struct net_hotdata {
 	struct kmem_cache	*skbuff_fclone_cache;
 	struct kmem_cache	*skb_small_head_cache;
 #ifdef CONFIG_RPS
-	struct rps_sock_flow_table __rcu *rps_sock_flow_table;
+	rps_tag_ptr		rps_sock_flow_table;
 	u32			rps_cpu_mask;
 #endif
 	struct skb_defer_node __percpu *skb_defer_nodes;
diff --git a/include/net/rps.h b/include/net/rps.h
index 82cdffdf3e6b0035e7ceeb130b5b4ac19772e46c..0d9ee2a055e9423f23c677fb3b28b5cfe05eb49f 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -8,6 +8,7 @@
 #include <net/hotdata.h>
 
 #ifdef CONFIG_RPS
+#include <net/rps-types.h>
 
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
@@ -60,28 +61,22 @@ struct rps_dev_flow_table {
  * meaning we use 32-6=26 bits for the hash.
  */
 struct rps_sock_flow_table {
-	u32		_mask;
-
-	u32		ents[] ____cacheline_aligned_in_smp;
+	u32		ents[];
 };
 #define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
 
-static inline u32 rps_sock_flow_table_mask(const struct rps_sock_flow_table *table)
-{
-	return table->_mask;
-}
-
 #define RPS_NO_CPU 0xffff
 
-static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
-					u32 hash)
+static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 {
-	unsigned int index = hash & rps_sock_flow_table_mask(table);
+	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
 	u32 val = hash & ~net_hotdata.rps_cpu_mask;
+	struct rps_sock_flow_table *table;
 
 	/* We only give a hint, preemption can change CPU under us */
 	val |= raw_smp_processor_id();
 
+	table = rps_tag_to_table(tag_ptr);
 	/* The following WRITE_ONCE() is paired with the READ_ONCE()
 	 * here, and another one in get_rps_cpu().
 	 */
@@ -91,14 +86,14 @@ static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 
 static inline void _sock_rps_record_flow_hash(__u32 hash)
 {
-	struct rps_sock_flow_table *sock_flow_table;
+	rps_tag_ptr tag_ptr;
 
 	if (!hash)
 		return;
 	rcu_read_lock();
-	sock_flow_table = rcu_dereference(net_hotdata.rps_sock_flow_table);
-	if (sock_flow_table)
-		rps_record_sock_flow(sock_flow_table, hash);
+	tag_ptr = READ_ONCE(net_hotdata.rps_sock_flow_table);
+	if (tag_ptr)
+		rps_record_sock_flow(tag_ptr, hash);
 	rcu_read_unlock();
 }
 
@@ -125,6 +120,7 @@ static inline void _sock_rps_record_flow(const struct sock *sk)
 static inline void _sock_rps_delete_flow(const struct sock *sk)
 {
 	struct rps_sock_flow_table *table;
+	rps_tag_ptr tag_ptr;
 	u32 hash, index;
 
 	hash = READ_ONCE(sk->sk_rxhash);
@@ -132,9 +128,10 @@ static inline void _sock_rps_delete_flow(const struct sock *sk)
 		return;
 
 	rcu_read_lock();
-	table = rcu_dereference(net_hotdata.rps_sock_flow_table);
-	if (table) {
-		index = hash & rps_sock_flow_table_mask(table);
+	tag_ptr = READ_ONCE(net_hotdata.rps_sock_flow_table);
+	if (tag_ptr) {
+		index = hash & rps_tag_to_mask(tag_ptr);
+		table = rps_tag_to_table(tag_ptr);
 		if (READ_ONCE(table->ents[index]) != RPS_NO_CPU)
 			WRITE_ONCE(table->ents[index], RPS_NO_CPU);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index be0a4769aebdbf1d25ff54a640f3c9e77b5eb2a7..23cc1fc5e608310d12956286c7b0199a481f19ab 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5075,9 +5075,9 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		       struct rps_dev_flow **rflowp)
 {
-	const struct rps_sock_flow_table *sock_flow_table;
 	struct netdev_rx_queue *rxqueue = dev->_rx;
 	struct rps_dev_flow_table *flow_table;
+	rps_tag_ptr global_tag_ptr;
 	struct rps_map *map;
 	int cpu = -1;
 	u32 tcpu;
@@ -5108,8 +5108,9 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	if (!hash)
 		goto done;
 
-	sock_flow_table = rcu_dereference(net_hotdata.rps_sock_flow_table);
-	if (flow_table && sock_flow_table) {
+	global_tag_ptr = READ_ONCE(net_hotdata.rps_sock_flow_table);
+	if (flow_table && global_tag_ptr) {
+		struct rps_sock_flow_table *sock_flow_table;
 		struct rps_dev_flow *rflow;
 		u32 next_cpu;
 		u32 flow_id;
@@ -5118,7 +5119,8 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		/* First check into global flow table if there is a match.
 		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
 		 */
-		flow_id = hash & rps_sock_flow_table_mask(sock_flow_table);
+		flow_id = hash & rps_tag_to_mask(global_tag_ptr);
+		sock_flow_table = rps_tag_to_table(global_tag_ptr);
 		ident = READ_ONCE(sock_flow_table->ents[flow_id]);
 		if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
 			goto try_rps;
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index cfbe798493b5789dc8baedf9dcbe9c20918e2ba6..98e90a0705df84e2f4cf77f92d988c2b9da6aa81 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -138,68 +138,74 @@ static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
+	struct rps_sock_flow_table *o_sock_table, *sock_table;
+	static DEFINE_MUTEX(sock_flow_mutex);
+	rps_tag_ptr o_tag_ptr, tag_ptr;
 	unsigned int orig_size, size;
-	int ret, i;
 	struct ctl_table tmp = {
 		.data = &size,
 		.maxlen = sizeof(size),
 		.mode = table->mode
 	};
-	struct rps_sock_flow_table *o_sock_table, *sock_table;
-	static DEFINE_MUTEX(sock_flow_mutex);
 	void *tofree = NULL;
+	int ret, i;
+	u8 log;
 
 	mutex_lock(&sock_flow_mutex);
 
-	o_sock_table = rcu_dereference_protected(
-					net_hotdata.rps_sock_flow_table,
-					lockdep_is_held(&sock_flow_mutex));
-	size = o_sock_table ? rps_sock_flow_table_mask(o_sock_table) + 1 : 0;
+	o_tag_ptr = tag_ptr = net_hotdata.rps_sock_flow_table;
+
+	size = o_tag_ptr ? rps_tag_to_mask(o_tag_ptr) + 1 : 0;
+	o_sock_table = rps_tag_to_table(o_tag_ptr);
 	orig_size = size;
 
 	ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 
-	if (write) {
-		if (size) {
-			if (size > 1<<29) {
-				/* Enforce limit to prevent overflow */
+	if (!write)
+		goto unlock;
+
+	if (size) {
+		if (size > 1<<29) {
+			/* Enforce limit to prevent overflow */
+			mutex_unlock(&sock_flow_mutex);
+			return -EINVAL;
+		}
+		sock_table = o_sock_table;
+		size = roundup_pow_of_two(size);
+		if (size != orig_size) {
+			sock_table =
+				vmalloc_huge(RPS_SOCK_FLOW_TABLE_SIZE(size),
+					     GFP_KERNEL);
+			if (!sock_table) {
 				mutex_unlock(&sock_flow_mutex);
-				return -EINVAL;
-			}
-			sock_table = o_sock_table;
-			size = roundup_pow_of_two(size);
-			if (size != orig_size) {
-				sock_table =
-				    vmalloc(RPS_SOCK_FLOW_TABLE_SIZE(size));
-				if (!sock_table) {
-					mutex_unlock(&sock_flow_mutex);
-					return -ENOMEM;
-				}
-				net_hotdata.rps_cpu_mask =
-					roundup_pow_of_two(nr_cpu_ids) - 1;
-				sock_table->_mask = size - 1;
+				return -ENOMEM;
 			}
+			net_hotdata.rps_cpu_mask =
+				roundup_pow_of_two(nr_cpu_ids) - 1;
+			log = ilog2(size);
+			tag_ptr = (rps_tag_ptr)sock_table | log;
+		}
 
-			for (i = 0; i < size; i++)
-				sock_table->ents[i] = RPS_NO_CPU;
-		} else
-			sock_table = NULL;
-
-		if (sock_table != o_sock_table) {
-			rcu_assign_pointer(net_hotdata.rps_sock_flow_table,
-					   sock_table);
-			if (sock_table) {
-				static_branch_inc(&rps_needed);
-				static_branch_inc(&rfs_needed);
-			}
-			if (o_sock_table) {
-				static_branch_dec(&rps_needed);
-				static_branch_dec(&rfs_needed);
-				tofree = o_sock_table;
-			}
+		for (i = 0; i < size; i++)
+			sock_table->ents[i] = RPS_NO_CPU;
+	} else {
+		sock_table = NULL;
+		tag_ptr = 0UL;
+	}
+	if (tag_ptr != o_tag_ptr) {
+		smp_store_release(&net_hotdata.rps_sock_flow_table, tag_ptr);
+		if (sock_table) {
+			static_branch_inc(&rps_needed);
+			static_branch_inc(&rfs_needed);
+		}
+		if (o_sock_table) {
+			static_branch_dec(&rps_needed);
+			static_branch_dec(&rfs_needed);
+			tofree = o_sock_table;
 		}
 	}
 
+unlock:
 	mutex_unlock(&sock_flow_mutex);
 
 	kvfree_rcu_mightsleep(tofree);
-- 
2.53.0.473.g4a7958ca14-goog


