Return-Path: <netdev+bounces-291232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AARQOAa7E2r/FAcAu9opvQ
	(envelope-from <netdev+bounces-291232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 04:59:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC055C57E5
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 04:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0117D300B3D0
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ACD2BE051;
	Mon, 25 May 2026 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gujYcriI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44A3438B5
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779677950; cv=none; b=r4S8egYPRnB/Z2hF3elaEt+zKpCnfW1xLTNNZUz3xijuWxYc0f+X9wuUwlTBNMDQ7T+v7mLLt5Ym/OvhPr1cz3yHuG59HqyL03FjYBQuTWGrEDMa//AMlvfMiTZMxAQ6TDUh7R7br1jrKSmXa4LqnfMnIF9/q5NwEd0Wr5Z+n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779677950; c=relaxed/simple;
	bh=5ZFQ3ioeI1AY7JkHhLJipr22pTr8CzAU/pick9VFC1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSIBkkW7gqNOr/cf1/ho3QIXOTrRbkIfN6xFYxlV9ggFhKfzhusYTfSBwbhol9fIq4mVT8Yn9fTkH5KAhNZtax56rqz8JLu6IiMwf6x225XoZ3Dm4XEAAzx4C2rA2Ks9GJpfEvkjXWBKUrAamRIA2HwGheSTVorqfC8xPr/MELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gujYcriI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36a7bbb9698so1384586a91.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 19:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779677947; x=1780282747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xI1NKIYyb75g5GjRIKULuvy86/0Bdgcx6L8+8GI99ps=;
        b=gujYcriITDZBMa6p7PvVHMsEFvZpFovG7ITBswaxzIY7oJiHvyA29a49265MoxeEVN
         DEfKJTqhxKjFE8WcoFZav8VcSbX92UkAikhnIQVvYXmn8NmbsabDNaGUVe1IQSBWPyP1
         IHr1je5SsYpx+xX2EI0raim4QW0qioUeWTRR22W+TB7Haf7vdU/cM5wHCfC+JiQw1sR7
         do5lH5ibTioD6tFFNqvbIdQDlU0pUKj6OHRuIUXaeOnTgfwTunIFewdsXO4uPZm/A1GT
         o0ZaxFNZRTNkAbSSef2pXSMRZsb3dgn8l9qsqXkK1l9NCaDMjJ080LUowajWl2zhjC9r
         qwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779677947; x=1780282747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI1NKIYyb75g5GjRIKULuvy86/0Bdgcx6L8+8GI99ps=;
        b=HEzanjmsf7ahbo+FV5EuESf21kYxaPHpWidx/K1ZPgzwoV6M2bOw8sSYJyaI3pCYot
         alFM3NNKRn9F8lCfWtYNb0NFQViRn3DKQE53sZm0MEYeSPiJTrs/qJUtwnfsYbELidDL
         sMB8lqV+cOTte7MEAJApNEMPNyHhgHtJ0Bn1RoKGg9FCt0EUMdpONkKD1BfhTbZpQI7U
         kAPWxuYln1vXr3O4G58aCCqoc8Kj+wLGWXSUVx48l76wlnxZ1f6rJym/VSKgvGYBtiHQ
         ycE3gLVWm25JPZAC8HHvD2aFPZDXsRTdiU7w+tw4RX2X3eeusSXLFfXEM8LNYOJh6cq0
         hgPg==
X-Forwarded-Encrypted: i=1; AFNElJ92YYIj7WX4ddaUx/ltQAgwLvVbTaIRfhyFp/8EyQpfWg2mPRHV8nsgGcE8AiZCcoiDdBEd24U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUqbNHEFGmD7NaZo17KUpLW+SyTDMkZ39khIvgqqahwn5zr6a
	+9XiTPxU+5/CDa2I99f3bfJn/xDesEvhUEfrS9yjIQqJvOwrQnz3XtEa
X-Gm-Gg: Acq92OGLMnIcV/8vtz8YJHTeqmNbOqHuRHVQY9U4RhxMQQ791ma7q08aJV803M+aX4A
	1rdjSgaiMd12l25I+61M05lVnk77eLnUELHeyZx8PZFf61SdSy6+Xb/I+BLAazQS0AmkwnlZHqN
	tgAIe4pfEIFcI3xNQZZ+mUDF8UQlbX931S64badeEGkPlI5Z8S4HgQ9RsLOjIoDxqKgs91wzwFV
	cHtvauquo3u3Me876ha85sUMX0Dyxf8II3GxpGph83Ftob3cWmbLCUcB7NuQLajR2PxlHSLrJe5
	Tao9KK2WvGr8+teDlE112riLyc/F0FpEbxN1TLy1ymYPj7+9RfRxhcJ/Vo3cpM9QS60bA7j4G2O
	gW6G2sog6//9iuUTbN2Y9vJcgAVAK+08KqW+4JVf8Cy1cYNlJEAf4sVQOkag3h/JLfT3ru2sPS1
	0/S4mlBbzw4CT5s22dYp1qrJcfdBg3wU/+Tnq21SNj1OjatC8igcKfBaEEsbR4Ydk=
X-Received: by 2002:a17:90b:3149:b0:36a:ee1:fc1c with SMTP id 98e67ed59e1d1-36a674c5677mr12829799a91.8.1779677947243;
        Sun, 24 May 2026 19:59:07 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b84:8280:c87f:5f1:b071:95f8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723dfa2dsm8029365a91.16.2026.05.24.19.59.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 19:59:06 -0700 (PDT)
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
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Mon, 25 May 2026 10:58:42 +0800
Message-ID: <20260525025854.13982-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291232-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CC055C57E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
v4 -> v5: fix 'modpost: "rps_llc_check" [net/sctp/sctp.ko] undefined!' by kernel test robot
v3 -> v4: add rps_llc_check by Eric Dumazet
v2 -> v3: patch net -> net-next by Jakub Kicinski
v1 -> v2: add rps_feat_llc_affinity; add brpc tests

 include/net/rps.h          | 28 ++++----------
 net/core/dev.c             | 76 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c | 35 ++++++++++++++++++
 3 files changed, 119 insertions(+), 20 deletions(-)

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
index 26ac8eb9b259..f98216ddaec1 100644
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
@@ -5208,6 +5210,58 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return cpu;
 }
 
+/**
+ * rps_llc_check - Determine if RPS flow table should be updated
+ * @old_val: Previous flow record value
+ * @new_val: Target flow record value
+ *
+ * Returns true if the record needs an update.
+ */
+bool rps_llc_check(u32 old_val, u32 new_val)
+{
+	u32 old_cpu = old_val & ~net_hotdata.rps_cpu_mask;
+	u32 new_cpu = new_val & ~net_hotdata.rps_cpu_mask;
+
+	if (old_val == new_val)
+		return false;
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
@@ -5249,6 +5303,28 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 }
 EXPORT_SYMBOL(rps_may_expire_flow);
 
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
 #endif /* CONFIG_RFS_ACCEL */
 
 /* Called from hardirq (IPI) context */
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


