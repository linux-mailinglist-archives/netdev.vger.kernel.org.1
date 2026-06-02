Return-Path: <netdev+bounces-294173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gqNHEk/EHmqLUwAAu9opvQ
	(envelope-from <netdev+bounces-294173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D919862DBCB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 13:53:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MANidmZK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294173-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294173-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C676B30039AE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 11:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5033D669D;
	Tue,  2 Jun 2026 11:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F13D3D06
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:53:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401225; cv=none; b=izsse7S3s1Wo4b3bOPJ3tD80EZoSxIhPjf3oLRgwGVxzHGhg44ANMWLKXtpaf681rozVDkbDlxrrHyohV5B6ygpKbwc7GdqEvQ3ClNoEMb614rXQijfFehVrl1inRG65QjG66lfN8IxCZItW89d1MuqWPCCrAqbTJXFM94DQadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401225; c=relaxed/simple;
	bh=6hoxYQ6ECyiEypWAOot1taMyVCa+DupI9Pw4V+YtaPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI4qeh9Ej98Lulmtle+6CzMjUXGdBAuqpX6ambbbDRU5ivD01y3NaxmB1zGvYQx0AvvFuKslqNKSAFKGF54R4kEfrrUMsGqwzJrQExwkE1OUESKne2YIB4qFe0imPkr4cuo2ymcLRjJ3vPrdETwORMNVputxq8ak9NYfms3e2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MANidmZK; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36ab8816a35so5460859a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 04:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780401219; x=1781006019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O08IdHXkcmFeKKbDayNq83iJPwpzLQQOHMfqAhn+3Ac=;
        b=MANidmZKe9U1WoR46UPI3gCTIf8ZYumOBygiKiMtv2AqLwMyp+7RHAIpJwLOY97dCS
         6RxliTzjdRPql/KfyEhe99vc6CO1Pci3yI9IRR3BlvHclQxWROFsP11nOZe2NpaPwGxH
         sSqu1yX+DVhGx6ELp0061J7k9BBgj11zlZsgOAvVzFacY1Wi8zIlQ4gB44eiu16ShjAQ
         6f0nGXjvKva+44J3Cw24u1UjRBVyhG5LprxuWe1fcd4VFHcEl6O/s0v0ucembO1z83rG
         NyeWs1QBBJIoUAy6kMmi0m85EiXHCrjBUBbURUt4WnfyxVCMrZBd6q/pY2gp6TeV4Wal
         FE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780401219; x=1781006019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O08IdHXkcmFeKKbDayNq83iJPwpzLQQOHMfqAhn+3Ac=;
        b=VnyiLQ1Z3lcc5qUDC3RgwyLzBCsJq5qy70+ZpWe8aawBYLxrxKV3fbN2XqP/rfABV9
         GPsYybLIC+eiXmiMvUTmE7D8auI8mVL51WIY5TTIuRnL69AyoPF1eBhzC0/uJcwR1rtj
         Ew4rmihIFW50X+CdGEwCJi6cuPVzntXKxFwOoATAVx1PHoFfV/U5tXb5AE3XLjQZQXip
         3N9mJywpYOZuZfWTyuZlGUm1UeE/6kyPlklbC+rC7vvx6n9B2hMKmk1RqRuLzxiaMs68
         gHabrPKaWzg8ruLU9cIvEYLOZsALCPshi1SbKtdYfDx2up10f/9B66gbdtjhib2GSfwB
         Sxxg==
X-Forwarded-Encrypted: i=1; AFNElJ/AIaulJeaIuHC0aRkAZvHog6WXVxctC6X9w4aHMycvsvLj28Upew2FMzQ66egmJXE2escR2Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJroMYq1tt2aaxbP4bjUlCOPl+fLp8wDW4kuqcqAQlFrRhFWqa
	i5rBMOQa3uumyK/4kTZvVoE66qUtnR9s6JNTGfY+KHVbR0L3BZRZwTYg
X-Gm-Gg: Acq92OHgU2d0Je5KSguYu4Ih7IKireaErQ7uCKJqCGVi6i+ZaItfY0nC7+Br/7S92kX
	cThcIeJKoreaB2B8l0aoT/k5qZH1TY0R3t7GKz9+nxfW9Vl5jJPFkKOEOEjDFeMpp551r/kGRrK
	ipxnVknbcN/1+t5iAjcJwIdPgw8zxexAn+ccvgYj5Y3H5JYcd2kxtote+1UmT3mcekzd0MMammH
	k/hqhQ+C6EHu3eNtsH2gsLktyRyDjLn8kYqWPWMzIXrSeqlxw6P/W1MBXdfXaxyAVTX9VRw1bod
	ah7oyRSKEs+F8fjlpj8x2kyQt3fFN+KNpotWB9Gj0+H8BAwqL0rFPxc1Nnpn2Fwsi3mPM4rsuE3
	7w+McvXf5SrZhWE0W21n+liaf7xU8Lf7DOcwMm1Uoz5OfDpA04PrapAwTSXYETNnukuo3nDZDFs
	5J/xRYJI0Z3/I7Qt1WsZRGe5KGfjoea9L45dIqRl6ORickqb4o/qjYc4rV7VqCstQtmv/htmJKU
	A==
X-Received: by 2002:a17:903:28d:b0:2c0:a555:80d6 with SMTP id d9443c01a7336-2c0a5559517mr152672505ad.2.1780401219060;
        Tue, 02 Jun 2026 04:53:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1a42:147:98fb:6fce:8020:cb09])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011d3sm135472555ad.52.2026.06.02.04.53.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jun 2026 04:53:38 -0700 (PDT)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Tue,  2 Jun 2026 19:53:10 +0800
Message-ID: <20260602115323.3502-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294173-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nashuiliang@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:sdf.kernel@gmail.com,m:kuniyu@google.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:ncardwell@google.com,m:shakeel.butt@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D919862DBCB

The current implementation of rps_record_sock_flow() updates the flow
table every time a socket is processed on a different CPU. In high-load
scenarios, especially with Accelerated RFS (ARFS), this triggers
frequent flow steering updates via ndo_rx_flow_steer.

For drivers like mlx5 that implement hardware flow steering, these
constant updates lead to significant contention on internal driver locks
(e.g., arfs_lock). This contention often becomes a performance
bottleneck that outweighs the steering benefits.

This patch introduces a cache-aware update strategy: the flow record is
only updated if the flow migrates across Last Level Cache (LLC)
boundaries. This minimizes expensive hardware reconfigurations while
preserving cache locality for the application. A new sysctl,
net.core.rps_feat_llc_affinity, is added to toggle this feature.

Additionally, export sock_rps_record_flow_hash() and
sock_rps_record_flow(). This resolves a symbol visibility compilation
error triggered by 'tun' using sock_rps_record_flow_hash() in
tun_flow_update() when CONFIG_TUN is built as a module. The same logic
is applied to SCTP, allowing it to use sock_rps_record_flow() safely
when built as a module.

Performance Test Results:
The patch was tested in a K8s environment (AMD CPU 128*2, 16-core Pod
with CPU pinning, mlx5 NIC) using brpc[1] echo_server and rpc_press.

rpc_press Commands:

  for i in {1..8}; do
    ./rpc_press -proto=./echo.proto -method=example.EchoService.Echo
    -server=<IP>:8000 -input='{"message":"hello"}'
    -qps=0 -thread_num=512 -connection_type=pooled &
  done

Monitor mlx5e_rx_flow_steer frequency:

  /usr/share/bcc/tools/funccount -i 1 mlx5e_rx_flow_steer

Frequency of mlx5e_rx_flow_steer (via funccount[2]):

  Before: ~335,000 counts/sec
  After:   ~23,000 counts/sec (reduced by ~93%)

System Metrics (after enabling rps_feat_llc_affinity):

  CPU Utilization: 38% -> 32%
  CPU PSI (Pressure Stall Information): 20% -> 10%

These results demonstrate that filtering updates by LLC affinity
significantly reduces driver lock contention and improves overall
CPU efficiency under heavy network load.

[1] https://github.com/apache/brpc/
[2] https://github.com/iovisor/bcc/blob/master/tools/funccount.py

Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v5 -> v6:
- remove the multi-check 'old_val == new_val' by Xuan Zhuo
- fix 'modpost: "sock_rps_record_flow_hash" [drivers/net/tun.ko] undefined!' by kernel
  test robot
- fix 'tcp.c:(.text+0x3e90): undefined reference to `sock_rps_record_flow'' by kernel test
  robot
v4 -> v5: fix 'modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!' by kernel test robot
v3 -> v4: add rps_llc_check by Eric Dumazet
v2 -> v3: patch net -> net-next by Jakub Kicinski
v1 -> v2: add rps_feat_llc_affinity; add brpc tests

 include/net/rps.h          | 28 +++++----------
 net/core/dev.c             | 73 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c | 35 ++++++++++++++++++
 3 files changed, 116 insertions(+), 20 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..6dacf0888a6c 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -12,6 +12,7 @@
 
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
+extern struct static_key_false rps_feat_llc_affinity;
 
 /*
  * This structure holds an RPS map which can be of variable length.  The
@@ -55,11 +56,14 @@ struct rps_sock_flow_table {
 
 #define RPS_NO_CPU 0xffff
 
+bool rps_llc_check(u32 old_val, u32 new_val);
+
 static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 {
 	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
 	u32 val = hash & ~net_hotdata.rps_cpu_mask;
 	struct rps_sock_flow_table *table;
+	u32 old_val;
 
 	/* We only give a hint, preemption can change CPU under us */
 	val |= raw_smp_processor_id();
@@ -68,7 +72,8 @@ static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
 	/* The following WRITE_ONCE() is paired with the READ_ONCE()
 	 * here, and another one in get_rps_cpu().
 	 */
-	if (READ_ONCE(table[index].ent) != val)
+	old_val = READ_ONCE(table[index].ent);
+	if (old_val != val && rps_llc_check(old_val, val))
 		WRITE_ONCE(table[index].ent, val);
 }
 
@@ -136,25 +141,8 @@ static inline bool rfs_is_needed(void)
 #endif
 }
 
-static inline void sock_rps_record_flow_hash(__u32 hash)
-{
-#ifdef CONFIG_RPS
-	if (!rfs_is_needed())
-		return;
-
-	_sock_rps_record_flow_hash(hash);
-#endif
-}
-
-static inline void sock_rps_record_flow(const struct sock *sk)
-{
-#ifdef CONFIG_RPS
-	if (!rfs_is_needed())
-		return;
-
-	_sock_rps_record_flow(sk);
-#endif
-}
+void sock_rps_record_flow_hash(__u32 hash);
+void sock_rps_record_flow(const struct sock *sk);
 
 static inline void sock_rps_delete_flow(const struct sock *sk)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259..53bad3c801dc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4997,6 +4997,8 @@ struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
+struct static_key_false rps_feat_llc_affinity __read_mostly;
+EXPORT_SYMBOL(rps_feat_llc_affinity);
 
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
@@ -5208,6 +5210,55 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return cpu;
 }
 
+/**
+ * rps_llc_check - determine if RPS flow table should be updated.
+ * @old_val: previous flow record value.
+ * @new_val: target flow record value.
+ *
+ * Return: true if the record needs an update, false otherwise.
+ */
+bool rps_llc_check(u32 old_val, u32 new_val)
+{
+	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
+	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;
+
+	/*
+	 * RPS LLC Affinity Feature:
+	 * Reduce RFS/ARFS flow updates by checking LLC affinity.
+	 *
+	 * Frequent flow table updates can trigger constant hardware steering
+	 * reconfigurations (e.g., ndo_rx_flow_steer), leading to significant
+	 * contention on driver internal locks (like mlx5's arfs_lock).
+	 *
+	 * This strategy only updates the flow record if it migrates across LLC
+	 * boundaries. This minimizes expensive hardware updates while preserving
+	 * cache locality for the application.
+	 */
+	if (static_branch_unlikely(&rps_feat_llc_affinity)) {
+		/* Force update if the recorded CPU is invalid or has gone offline */
+		if (old_cpu >= nr_cpu_ids || !cpu_active(old_cpu))
+			return true;
+
+		/*
+		 * Force an update if the current task is no longer permitted
+		 * to run on the old_cpu.
+		 */
+		if (!cpumask_test_cpu(old_cpu, current->cpus_ptr))
+			return true;
+
+		/*
+		 * If CPUs do not share a cache, allow the update to prevent
+		 * expensive remote memory accesses and cache misses.
+		 */
+		if (!cpus_share_cache(old_cpu, new_cpu))
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
+
 #ifdef CONFIG_RFS_ACCEL
 
 /**
@@ -5263,6 +5314,28 @@ static void rps_trigger_softirq(void *data)
 
 #endif /* CONFIG_RPS */
 
+void sock_rps_record_flow_hash(__u32 hash)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow_hash(hash);
+#endif
+}
+EXPORT_SYMBOL(sock_rps_record_flow_hash);
+
+void sock_rps_record_flow(const struct sock *sk)
+{
+#ifdef CONFIG_RPS
+	if (!rfs_is_needed())
+		return;
+
+	_sock_rps_record_flow(sk);
+#endif
+}
+EXPORT_SYMBOL(sock_rps_record_flow);
+
 /* Called from hardirq (IPI) context */
 static void trigger_rx_softirq(void *data)
 {
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index b508618bfc12..b6d4ebcbb6a6 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -210,6 +210,33 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 	kvfree_rcu_mightsleep(tofree);
 	return ret;
 }
+
+static int rps_feat_llc_affinity_sysctl(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
+{
+	u8 curr_state;
+	int ret;
+	const struct ctl_table tmp = {
+		.data = &curr_state,
+		.maxlen = sizeof(curr_state),
+		.mode = table->mode,
+		.extra1 = table->extra1,
+		.extra2 = table->extra2
+	};
+
+	curr_state = static_branch_unlikely(&rps_feat_llc_affinity) ? 1 : 0;
+
+	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
+	if (write && ret == 0) {
+		if (curr_state && !static_branch_unlikely(&rps_feat_llc_affinity))
+			static_branch_enable(&rps_feat_llc_affinity);
+		else if (!curr_state && static_branch_unlikely(&rps_feat_llc_affinity))
+			static_branch_disable(&rps_feat_llc_affinity);
+	}
+
+	return ret;
+}
+
 #endif /* CONFIG_RPS */
 
 #ifdef CONFIG_NET_FLOW_LIMIT
@@ -554,6 +581,14 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+	{
+		.procname   = "rps_feat_llc_affinity",
+		.maxlen     = sizeof(u8),
+		.mode       = 0644,
+		.proc_handler   = rps_feat_llc_affinity_sysctl,
+		.extra1     = SYSCTL_ZERO,
+		.extra2     = SYSCTL_ONE
+	},
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.47.3


