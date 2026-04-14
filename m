Return-Path: <netdev+bounces-278287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL/+KVK83WmCiQkAu9opvQ
	(envelope-from <netdev+bounces-278287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:02:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD943F56BA
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A2FA3031F2D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 04:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08401366056;
	Tue, 14 Apr 2026 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENgEJqUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EF6F2F2
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139203; cv=none; b=e6U3/JNXgrYTPojL8T3nNs4ly36sbSObdojgde4Jhy7oXNTiFWcb6VZc6PFPRuvvvdYFqWhmBD7lLvACoHR2YZByLmdtABcNL5/sT/YJpI7XIwYWvqRyfQJBdekbXJEzVeJV9K9GdSH9gB7O2X9XSQQCiOb1wmKbQAsaPOiKvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139203; c=relaxed/simple;
	bh=3x31s0xphA1KzJ7zU0vHbpVL9GF3jKZyINontzZJTKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jn+UAAUekMaVyWkEv+IaXD67Yp7tMtFLoo0QWGrdYTDg/iU0kR0EDwLlsmBfXgpzwxV5eUUWe3Wli5r+gMCVky5mAQmdwuCz/ai8y3VB++9fwsqhxj66m6559CiI1wZA3EWPjm9fQQksetX+5H1DA3kxFUBWaVI+0abQ+fDqg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENgEJqUQ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b45cb89f7eso12075375ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776139193; x=1776743993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GaQwC6PXCoTitxa7wZplAr6LrVi+IQ8jXIX0gDbXPI4=;
        b=ENgEJqUQHvUhp/RoLUwGBTDsiy+9/wTceuQKL5yvWpXvSRauWgGBVjf+Y9snVjPEZR
         FPsxw5rvfV7+0I2rfCBEPoR+beWhv8DXf09lQsoQmf9COWtq333EszztZkEHb67EdMNW
         X5i+O61QAeFWnkf/VW4aKyh9YppEgKE58lloNANfR0AxOZbPEXJsJFKvTIyf8GZsW0Nd
         /XNwV+Co4FQrHoPxmtJ5ZgYeasAQYVi/iP2/P3l9kWWTSfdggbrZ1Caj9NuYazk8ims6
         c7MsNp/7/fGueQ5wYWU6lV6XSfbdVIIDn8YBZD1Ryxw8uYKr7NPX405rPGMRCZ17JYiz
         oSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139193; x=1776743993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaQwC6PXCoTitxa7wZplAr6LrVi+IQ8jXIX0gDbXPI4=;
        b=C201okUTi9ZH2Y9xyerTh+eeyWl+L7xLKzWaq61vSeRnVPJrNyIzVz6Ux/86EvpCLU
         qbfvHRh0xVvnaQsELZ1IvgrIM2coDP5qtGIic3MQ/G/W5w16LXWcYLeaVapJiF+EkWae
         qjQ62gEbmL4Rr0EyrImAlRBUAC+bUNDSv1/d7vC9k5COKiwvkp11HEXmpkiVYpR3bsF1
         1JSaFxv3LaI7vLs/CYQFB+59Kt3fA0x9sxTdJRsYtEjGaktwPmV61PTQOfwx5KEoILdF
         ERY68zRivgoGNe+egwVcQ5bLEof/Grt59t1ct1XTSMnc9qTeTKUeMSo4cvg2eHUDs5z2
         C9qA==
X-Forwarded-Encrypted: i=1; AFNElJ8Vx4OfwDMIFMzrtft5VTivXiyR0tSsL9irOXul0DEKX6hBvKuEUjgbzgb0o1kwYipZmj+LnJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AnK7jjr358f/YoKJ+nNf7DNkArk6GN3nBA2k+ByhOh/Ws0qt
	pM83+2M3nd6cke6HGj+zE3D1n9+dS6/p3M+nY731VcNXQU6Xx4sZZkGn
X-Gm-Gg: AeBDiesLPBPuPbGr2J3nTIeqNxLOdhqHo0HBW3cIo2xp/OtLDGZfvvFzyD3unJll4LL
	HKbV57kyFrFrfrdfSWcEODH992lB+pK+NXiIqSwTFsCokkkX7cOSHy7HEIgfNXX4UczFza+l0Li
	e5xqwIIaCBdTEj4+b+zr4rCBEuHMyqKRk1WTQBOJ1dROYDRWqGv06DAkRt2xmBBa2rZwzJoS1ed
	WN5ZxQANi5tMFsHWqEhWiyavOTVhVP5M9q7uN748fLwWgk8NQOtWxwC2rdMn8ZQQcxMACJpfDzx
	qnIYJ//NYQspKIr7VmlUOZ8JNfTPVB6k7zlLyEO3LWPzKm4ZqrHtLQtMLmV2C5Ga84xBSmAv7TH
	6+u2H6I19GchNmfI37g14oteIzTn/FtH4e6zToBPNEmw5u1ca/8Np4SD5vOz6MTS/YJW4GbbXdQ
	BOnCaGZfurap/mqr5O+trxh06s1jtBh4emcfrUstCqzJTW89IaFf+M8MLDQ1NIUf8=
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr68981475ad.38.1776139192689;
        Mon, 13 Apr 2026 20:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1b61:a738:ec5f:4173:769:6994])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd7faasm131741895ad.26.2026.04.13.20.59.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 20:59:52 -0700 (PDT)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Tue, 14 Apr 2026 11:59:20 +0800
Message-ID: <20260414035931.45692-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278287-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFD943F56BA
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
v1 -> v2: add rps_feat_llc_affinity; add brpc tests

 include/net/rps.h          | 18 ++--------
 net/core/dev.c             | 72 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c | 34 ++++++++++++++++++
 3 files changed, 108 insertions(+), 16 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..37bbb7009c36 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -12,6 +12,7 @@
 
 extern struct static_key_false rps_needed;
 extern struct static_key_false rfs_needed;
+extern struct static_key_false rps_feat_llc_affinity;
 
 /*
  * This structure holds an RPS map which can be of variable length.  The
@@ -55,22 +56,7 @@ struct rps_sock_flow_table {
 
 #define RPS_NO_CPU 0xffff
 
-static inline void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
-{
-	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
-	u32 val = hash & ~net_hotdata.rps_cpu_mask;
-	struct rps_sock_flow_table *table;
-
-	/* We only give a hint, preemption can change CPU under us */
-	val |= raw_smp_processor_id();
-
-	table = rps_tag_to_table(tag_ptr);
-	/* The following WRITE_ONCE() is paired with the READ_ONCE()
-	 * here, and another one in get_rps_cpu().
-	 */
-	if (READ_ONCE(table[index].ent) != val)
-		WRITE_ONCE(table[index].ent, val);
-}
+void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash);
 
 static inline void _sock_rps_record_flow_hash(__u32 hash)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 203dc36aaed5..630a7f21d8de 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4964,6 +4964,8 @@ struct static_key_false rps_needed __read_mostly;
 EXPORT_SYMBOL(rps_needed);
 struct static_key_false rfs_needed __read_mostly;
 EXPORT_SYMBOL(rfs_needed);
+struct static_key_false rps_feat_llc_affinity __read_mostly;
+EXPORT_SYMBOL(rps_feat_llc_affinity);
 
 static u32 rfs_slot(u32 hash, rps_tag_ptr tag_ptr)
 {
@@ -5175,6 +5177,76 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	return cpu;
 }
 
+/**
+ * rps_record_cond - Determine if RPS flow table should be updated
+ * @old_val: Previous flow record value
+ * @new_val: Target flow record value
+ *
+ * Returns true if the record needs an update.
+ */
+static inline bool rps_record_cond(u32 old_val, u32 new_val)
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
+void rps_record_sock_flow(rps_tag_ptr tag_ptr, u32 hash)
+{
+	unsigned int index = hash & rps_tag_to_mask(tag_ptr);
+	u32 val = hash & ~net_hotdata.rps_cpu_mask;
+	struct rps_sock_flow_table *table;
+
+	/* We only give a hint, preemption can change CPU under us */
+	val |= raw_smp_processor_id();
+
+	table = rps_tag_to_table(tag_ptr);
+	/* The following WRITE_ONCE() is paired with the READ_ONCE()
+	 * here, and another one in get_rps_cpu().
+	 */
+	if (rps_record_cond(READ_ONCE(table[index].ent), val))
+		WRITE_ONCE(table[index].ent, val);
+}
+EXPORT_SYMBOL(rps_record_sock_flow);
+
 #ifdef CONFIG_RFS_ACCEL
 
 /**
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 502705e04649..dbc99aea7bb0 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -210,6 +210,32 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
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
 #endif /* CONFIG_RPS */
 
 #ifdef CONFIG_NET_FLOW_LIMIT
@@ -531,6 +557,14 @@ static struct ctl_table net_core_table[] = {
 		.mode		= 0644,
 		.proc_handler	= rps_sock_flow_sysctl
 	},
+	{
+		.procname	= "rps_feat_llc_affinity",
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler   = rps_feat_llc_affinity_sysctl,
+		.extra1     = SYSCTL_ZERO,
+		.extra2     = SYSCTL_ONE
+	},
 #endif
 #ifdef CONFIG_NET_FLOW_LIMIT
 	{
-- 
2.47.3


