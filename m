Return-Path: <netdev+bounces-81529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB79188A267
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807DB295E81
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8630B1B251F;
	Mon, 25 Mar 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d41V8cZJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WYu/1jcW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B4139590
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353016; cv=none; b=B5/ez+TV3y3TIG7ERilAczmrC9iCrOQm8tx64Oqdi5LjtMju9zsJ+7aPvoVgfoqkMf6vnI+oP3RIrBPEBkRg1DvSfw+Qu/5Pe4WIJgcgf7/kCPoiOIiJsqzJLXH4pK/zCUKZ+dO7aYlRZTjJbQbv8oWjJWYz2M8kr4vwr6DW+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353016; c=relaxed/simple;
	bh=zvE/IEVRcAKd3Fh6EcXrC5yztREXOnbLvmwGOF2dfY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4f9UYygReFhGxWcdRMrkIcfC8hiYInPliWuRSTVHNdWvZfPHaC5gb+DrGIBjpnZ+umyxEsW+TjN/y9S7xAz5pH7Yr8qicn1f6bMiQQFKwu0N5Qyam6X/LfITmv3OhOa191Q2DQq9D+40nagJnKWP5be/KKlpCyPoYVwHIiWh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d41V8cZJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WYu/1jcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711353013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCxfTUbaolHMyzfAQBM0RE8yEYCe69N6PolmoLrGuWE=;
	b=d41V8cZJHhZNiyun5oLI0EsbaltyyZysZRUQ2Wosc2fMQL+FsE9PMPUclGOjdNeHgW97n/
	Klj0nEqaEQVHJPr3TUPpaiv8RUyhptcT7VLpAxJwHnLOUvjcyx/Vm4QAdTK8X9lHggOIrj
	hXki7CgLrLLPAOuRLqSNoyMwIGzF0mcbJ9v/HyUJHQsmXYKlBTAk4pj7GvXcVSLPUY05FK
	SJCKrjd+Fm872319oLScV5c3jnIA/NiqWBrc394AvR8J2FZwmRfNEkJRAQc1mLGVpHrhmD
	wGbPHu+FPW7KN8OxiAfkktIEK/DfH3AD437UekogaQDs+lYqZ9uBL60gidQBGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711353013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCxfTUbaolHMyzfAQBM0RE8yEYCe69N6PolmoLrGuWE=;
	b=WYu/1jcWr9TE2LqXPbPN5P8PbolLeZPk98vNsBDoiRWvVkwZgX1F4DXTp7SMJCCWcnswzw
	B0LUCrHTXwxQeyAQ==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6 net-next 3/4] net: Use backlog-NAPI to clean up the defer_list.
Date: Mon, 25 Mar 2024 08:40:30 +0100
Message-ID: <20240325074943.289909-4-bigeasy@linutronix.de>
In-Reply-To: <20240325074943.289909-1-bigeasy@linutronix.de>
References: <20240325074943.289909-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The defer_list is a per-CPU list which is used to free skbs outside of
the socket lock and on the CPU on which they have been allocated.
The list is processed during NAPI callbacks so ideally the list is
cleaned up.
Should the amount of skbs on the list exceed a certain water mark then
the softirq is triggered remotely on the target CPU by invoking a remote
function call. The raise of the softirqs via a remote function call
leads to waking the ksoftirqd on PREEMPT_RT which is undesired.
The backlog-NAPI threads already provide the infrastructure which can be
utilized to perform the cleanup of the defer_list.

The NAPI state is updated with the input_pkt_queue.lock acquired. It
order not to break the state, it is needed to also wake the backlog-NAPI
thread with the lock held. This requires to acquire the use the lock in
rps_lock_irq*() if the backlog-NAPI threads are used even with RPS
disabled.

Move the logic of remotely starting softirqs to clean up the defer_list
into kick_defer_list_purge(). Make sure a lock is held in
rps_lock_irq*() if backlog-NAPI threads are used. Schedule backlog-NAPI
for defer_list cleanup if backlog-NAPI is available.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 25 +++++++++++++++++++++----
 net/core/skbuff.c         |  4 ++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382c..e41d30ebaca61 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3287,6 +3287,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
=20
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index ea574df496407..85e11dabab48c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -226,7 +226,7 @@ static bool use_backlog_threads(void)
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_save(*flags);
@@ -234,7 +234,7 @@ static inline void rps_lock_irqsave(struct softnet_data=
 *sd,
=20
 static inline void rps_lock_irq_disable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
@@ -243,7 +243,7 @@ static inline void rps_lock_irq_disable(struct softnet_=
data *sd)
 static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 					  unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(*flags);
@@ -251,7 +251,7 @@ static inline void rps_unlock_irq_restore(struct softne=
t_data *sd,
=20
 static inline void rps_unlock_irq_enable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
@@ -4722,6 +4722,23 @@ static void napi_schedule_rps(struct softnet_data *s=
d)
 	__napi_schedule_irqoff(&mysd->backlog);
 }
=20
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
+{
+	unsigned long flags;
+
+	if (use_backlog_threads()) {
+		rps_lock_irqsave(sd, &flags);
+
+		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
+			__napi_schedule_irqoff(&sd->backlog);
+
+		rps_unlock_irq_restore(sd, &flags);
+
+	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
+		smp_call_function_single_async(cpu, &sd->defer_csd);
+	}
+}
+
 #ifdef CONFIG_NET_FLOW_LIMIT
 int netdev_flow_limit_table_len __read_mostly =3D (1 << 12);
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b99127712e670..17617c29be2df 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7039,8 +7039,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+	if (unlikely(kick))
+		kick_defer_list_purge(sd, cpu);
 }
=20
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
--=20
2.43.0


