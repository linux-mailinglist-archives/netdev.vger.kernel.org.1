Return-Path: <netdev+bounces-290458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC/rG8kUD2otFAYAu9opvQ
	(envelope-from <netdev+bounces-290458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:20:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B565A7211
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD1CC3174B54
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF23EA94F;
	Thu, 21 May 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV5P6n/d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2813EA942
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370648; cv=none; b=r6oohuLtZZpE6W/GJ3bVgMASJxcuNFxZJTCrBXvzke7e+0BpuCdJO/szlrczlvYNuJtF4y8Fx7w4XwwcU5ZqukIoOv67xhqJ1HqVIPzBtXovO8z7RJ4eBpQmYvrtltg/pH7nWhlKHtqVFFO6fE8oMlBjLXmWpcY7a61ZUQWkQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370648; c=relaxed/simple;
	bh=P51n2b/oFOVHnt949lfmT4I5HHmggRmwYe9UnF0MG5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVaOYlMZPh2G7QoCGdIO2PuTqtO9H1CdQwT3Y2NQCzQZay8DOiSz9JJNCh8Dp7bHTwmzMQJnOGzEnv00+R3luPDAFZlv9Tkj3wDcS8Z6KOSJmutHJA6rd4LHhzESUyLLX1CSIFUhBBJeq7s2a/gtcAARvKbbkEX5OvWnXKXkeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NV5P6n/d; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3e3c4f87so62145805ad.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779370646; x=1779975446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7ug8LaXoNWnHgEv+PMJRrHpbPnUV9xOZWAilo2/lYQ=;
        b=NV5P6n/dQztEwkLd3dZXRGD0cdBUbj+wQQUBaWXBe5il/ouWgiEDpRA3cUwuSDoRf8
         otKROzlkWUT8tMHRddZVBkY0zFwX0ErTMwDV9DEbSi4nbDQub4IqOeMdEHrQTnlMr/ZE
         pvrBH4PfjJiUc40GF1rHrsG5z7I5aJJMc5f+riFpMLJ43fEOjKN9ttpO1g9VRzrfwHoB
         wx8JG5DanA7NMu+CcW2rtsFSW/db/5hNKNZzoAhoiDyJB1rDICQgRK2TTcmOukJxu/vc
         W7gcS8LxVlVWEBd3fL/t87WTGivCzzzfsN+Tbl+BoX1mUl9A/vtr2LsSCml/7dbOddI0
         QfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370646; x=1779975446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7ug8LaXoNWnHgEv+PMJRrHpbPnUV9xOZWAilo2/lYQ=;
        b=atR/Bq3b+xQ7MYk2RiB9ZqAw8pEyznVbJ44+hs+RSSTGs+LK+kq80VuE/++bpUC+DL
         Odg5gTlBtJ52K8inc31m0jD3CAOkfvl7HBIdKW0VNEe58Tk9xiVwZSrmB7dSvcjdEvWT
         0Ko5Li9/iPqIfScucodqtS9kb25B+rbfzdTv7AzZsvuEUNbEDwH7/quPwjK5gRYnSY6u
         0B93dRVRgXqnwtHAeLeCdZdKlgWl4i9BrtQjCcIUr4OLBwzZpnLZf8JJpA72FOHnxSdY
         OfVPV8JEoS/6v0QQolwcawByEmz1ror9+T2jmfYUJXphE8ySkZ/XFZxeUWILUA+n2NCF
         Ea3w==
X-Forwarded-Encrypted: i=1; AFNElJ9M+VVU2OZ8sQ8qSdVbAAjb1BO9PGu9LU1IamQ9Tp/y4C059p82KUu/WnDzZoHznjs3kMnnv9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxASh+jMiOnalwQr85ITATnHmZRrZdda1HXRIhoxLdY72sUEQ9+
	lLBft98eNBrkH90ukxm85l/7QWKDMbAYxBI1WSNJuy69j+34Cj1FzZWI
X-Gm-Gg: Acq92OGwT3Q9ifChSCN1xSs+JEfSffk0RemOt1mEWM6lyOWon6RKrFUPlLJHq+bCH7I
	p5ek38ofZgjBFiHwlIBrahOOQiKUi+njvVg5q60nMgMonVag3JW8AH1IYxRbYdKi3QrVRXfiGO6
	vk8oId34QncTMtoDUJPr2jrpbVuXiaVk/wd14OcXM53EUc6BIHfN0Q4HAYAz5HUrksyWzuIvs/p
	9Nr1P6HqB0iazoQRsbZT7G3FsJoKArdhWB3nQOn1DSBUqGcysKz0SyCPX0W91tfD2Ypd38B5jaF
	wK0ERn7JvEnHbzdsyy8D09V6lI6oMH2nWMgPQd5nw7TZzt4GhcokqRce8vxI674Y0/J0O4JatRs
	8hoZwtjhzWkGj6gU9COdNyXvC5Z+frGs0Cqf/AufeDGEfbgNKOchKOUkfTLuCcryZIj5Xi/10/y
	AGFl8oih1xkSVMg4SySpT41i0wJtZLkQiJgOVMP0V7G8e0V5mwsNCzVAEE5cwFZdk=
X-Received: by 2002:a17:903:1aeb:b0:2bc:8beb:525b with SMTP id d9443c01a7336-2bea3344109mr34103615ad.18.1779370645828;
        Thu, 21 May 2026 06:37:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1d81:e6e8:5473:a79:5c76:810d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea9a2ab27sm10781445ad.72.2026.05.21.06.37.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 May 2026 06:37:25 -0700 (PDT)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] net: reduce RFS/ARFS flow updates by checking LLC affinity
Date: Thu, 21 May 2026 21:37:01 +0800
Message-ID: <20260521133711.20725-1-nashuiliang@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-290458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7B565A7211
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

Additionally, export sock_rps_record_flow_hash(). This resolves a symbol
visibility compilation error triggered by 'tun' using
sock_rps_record_flow_hash() in tun_flow_update() when CONFIG_TUN is
built as a module.

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
v3 -> v4: add rps_llc_check by Eric Dumazet
v2 -> v3: patch net -> net-next by Jakub Kicinski
v1 -> v2: add rps_feat_llc_affinity; add brpc tests

 include/net/rps.h          | 17 ++++------
 net/core/dev.c             | 65 ++++++++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c | 35 ++++++++++++++++++++
 3 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index e33c6a2fa8bb..65543354f6e6 100644
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
 
@@ -136,15 +141,7 @@ static inline bool rfs_is_needed(void)
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
+void sock_rps_record_flow_hash(__u32 hash);
 
 static inline void sock_rps_record_flow(const struct sock *sk)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 26ac8eb9b259..df8d328447bd 100644
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
@@ -5249,6 +5303,17 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
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


