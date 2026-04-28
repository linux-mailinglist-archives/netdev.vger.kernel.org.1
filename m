Return-Path: <netdev+bounces-281610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHt8Egci8GlhOwEAu9opvQ
	(envelope-from <netdev+bounces-281610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:57:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D0D47CF2B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00C2301F9A0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5A399001;
	Tue, 28 Apr 2026 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKaNPXd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26728C854
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777345004; cv=none; b=kU7u0OE9FJnQc9j3GM7mBYH5JqprV+5XN6g/PgxZiMO7Fo/W9uz0WvhteGuOuPKbXy8SVEbfhSsslEHeADDcn7HZoD3Oc2ZcGdcENQMno0bDT69S5K/B8RkMrIjE6YIS9jnudC8lD4i5Rmq8wqfGCeSooaiLczGlpu3Tz/joh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777345004; c=relaxed/simple;
	bh=0yVjPi8YaY+mdpJVoI/uHWZ18ZUeyH46lGKkKocoQR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv06cUA8IJYc+cGkzRErZIu4EG/pw054lFZMsNC+p8ko1rtdWlxxfWeQIxKsvrgYIaTUX7HoUg/YzNVLT8ftIw5dJ2Ty85L9ik+tELggvrD9chqR/ApTxTELpU4oh8JKIvB8uucljeUaExM6bY+BskGqpN12k8U2cgthOStqB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKaNPXd7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb16e56efso7154301a91.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 19:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777345002; x=1777949802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCx/aikP1KtOAnMEhAz4wQcGtstdcljxDpYEEMnoRIA=;
        b=iKaNPXd785Pj8x4uM/PKUNsRY9b0mH6tPVxsgTV9zW+qS9UecRG87E5KI2SCKc9pPi
         lBfFPSfHcxNC3XzLoP7oIOQCjXnRiOIWdHjf1B56WjPRSfeIBy0Q6Ijg4FhSQCbcxLev
         6vpN9ryqeV3A8UVdZvPvkPNVPq5d7MzvWM0FJ0PjZeSTmQS+btajNdSjH8eWkVb5M73+
         Er1fiJ3yMOReQinwIHwMHZN5ic48qz7c60Nby4D+wTu5WLVd2Qr+k28cF4E7WHvYC64J
         aq6ZVJLUFbV0ETxbK3yPYl82fhpyWPSEZbr38/AZXLoBxlxaMhGiyHP50i/8iJ39i9J4
         0beA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777345002; x=1777949802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCx/aikP1KtOAnMEhAz4wQcGtstdcljxDpYEEMnoRIA=;
        b=VuZYcapo1rO/v93qwBiKwW5eRFSDp2ioz/DLsXmQXr3ebO0WyGh1IJswkCdmJYlJE5
         Pt/T/dXXVmB6h3MEoq6Ji9gq1PPU88U16SZHu7spAE6uiKaBmC+ezPBhN1ufjRp5RvIM
         eKhMNk2jrhb+s5JzSDUVsQ52drHSyrOa22kj/4rs9kTzxRrDPnGvQT/WXGF7xMaUzd0f
         ksY1xZUh6CxoO05nF50ase2QwVZ32GrrSABnM1UW9uNQ+jUalB5+TFfQIXk3K/1bgQHJ
         FcvRC5IGuwIO/JleKhZa9pjakBZznbZt/PbzS53BlMV53lRBD1MRCeVdyXIgufdNJesm
         glTA==
X-Forwarded-Encrypted: i=1; AFNElJ/onXgCoowXABT7q/wrO0CA21rfGF9mWpD9nqLfp9VlzXitQr6Blo60DTRBp4DUstKrUUXpjMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoq+Y1I8LD009ELzlQSx+PM0TYA3K+XYy2E9KE7BTyAtQH9mwV
	w3gxZGkDpA+/RPENA7bBUiRSHL60+xmVHGOtiYPGlWpTdlR4Jqi1HDBe
X-Gm-Gg: AeBDieu+167cmZepMf6LGvHlu4Yg6SGlmres7SF2bfdhQ4KtMsXYNjIAlXXdbREizK3
	ovvKm4il148Z6lEQoZx/oWgvq8nZXzTfuBcNPxdHXt5OXsuqRzZu9YzOiLMqhUhfiQd3n1NacCE
	iXr+T/Sm6sFwyJxS/ABBUAKbDE5ZtmkKso90d5rJcdJZik32hvuPZolGKLuqbJljhoVlCGPABFa
	vIyOfr3yneEtmVOCFdP92SXO/ogmvBUR4tFP9mgp8p4XzEOmFPGpc45ckPNEYXY61LHyCjyKHqu
	zxVVMd8Hhzcf+tOmtTLL0hsaf3BraOv9odBV4uu0VNfF3L4rppV/2zztD0tOzKiSkFNZpCwnCeQ
	yUHKD9MyqTx7Xtp7qsjXGFWdYW8LrUqIJ/3eLWX2hQrc+FRWggSdXNwJAzrCIF0bze06rl8a/t0
	ZxtEWluYUG/JeX9yuE+Ha0pLeDiFnye5izvOZDls58EK3nmOImx4cxNeSCgjRiBSB5MSqAwroiU
	V2DkkeY1WDDJtM=
X-Received: by 2002:a17:90b:3909:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-36492000bb8mr1236610a91.14.1777345001962;
        Mon, 27 Apr 2026 19:56:41 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:8f42:c43e:69d6:cc3c:64dd:c957])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490dbca93sm1135132a91.2.2026.04.27.19.56.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Apr 2026 19:56:41 -0700 (PDT)
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
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Tue, 28 Apr 2026 10:54:52 +0800
Message-ID: <20260428025505.768-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9D0D47CF2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-281610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nashuiliang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
v2 -> v3: patch net -> net-next
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


