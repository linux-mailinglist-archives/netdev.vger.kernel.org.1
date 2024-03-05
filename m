Return-Path: <netdev+bounces-77483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C7871E6D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376E91F247D0
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC959B76;
	Tue,  5 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LC9kY66L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y2HXqiBq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC0958ADC
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640023; cv=none; b=oPhUZ+5OPtLxVWAoH/mvwuGgm4zyvOuOrA3KPFip7dY+fEOhVnOcG+NAj3k2QIqxVSgFU5f00uouD2YPeQa82uWsSbwfwHlVY7FbQklphKE+rRqriLoxh24VALgt54WbblSWMXL0RUI5gpGvFtq3yzPFonbnZV+32RJ2fIPwHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640023; c=relaxed/simple;
	bh=gM5toVECSE3cIGFlcffZr0BFQNFmaYzT4eEj608jguE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKrDjC3V3bhPdHr/zJzpQAJ2GS0X1sF77pVrqPpSxtYsMDtGUBneB7vNmoPued+SNy8iSmn3pTiAcyes+e3StTVbPcuVCcxo7c+G6Y52PPu4aE8xV1p2HR77zB6b2ddnwxAnvy9UeN56wIxvCIb1o7RI7fGzqdv4io8CiDWwFmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LC9kY66L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y2HXqiBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709640019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih8aKLBireRVLuD7+/Gdopuv0CFlgCNozRaBaJFmVdg=;
	b=LC9kY66L1t2aYzjmTi76SiwhPM9kA0l3rkUUReWJLUxnctMqAm8kVb5Apav2VjC3Aaq7sR
	EcWkaVmeHeGuiwRR6nHVGvmIDJyNIYLCKVVqQqlI7QOkbIf5eLZNUyYVgxL6XMBz8Z4iqD
	CRxPV/xQT+83EszwwDbur5t6lNzflN9l/AfuccEA6m9eNWeH5cj7e3AAyjsT0E3XZaDrJu
	HkfL1IdZiI1TNpaOwKsE6oABzwAxTHUpWsl2i1RSjjQpePK82M0UHrT7WjtSiVpBnXCTbg
	HaelaX6k2JFy5/2i6W9DEyZdAgxb85MmgZQoyfpXs62pbI+9tSROi1n0oEcvug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709640019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ih8aKLBireRVLuD7+/Gdopuv0CFlgCNozRaBaJFmVdg=;
	b=Y2HXqiBqLqRxHGdAEqIjOagFAv29LsRG2HT3ZC/mx8yksUjm8Jlzv9tFD903VdEqXDDJtB
	CGgtJyPaMXaxxUAQ==
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
Subject: [PATCH v4 net-next 3/4] net: Use backlog-NAPI to clean up the defer_list.
Date: Tue,  5 Mar 2024 12:53:21 +0100
Message-ID: <20240305120002.1499223-4-bigeasy@linutronix.de>
In-Reply-To: <20240305120002.1499223-1-bigeasy@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
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
index c41019f341794..38ceb64e522f7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3368,6 +3368,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
=20
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 24601c8db2d70..5ce16b62e1982 100644
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
@@ -4737,6 +4737,23 @@ static void napi_schedule_rps(struct softnet_data *s=
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
index 1f918e602bc4f..3b2d74ca8517a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7042,8 +7042,8 @@ nodefer:	__kfree_skb(skb);
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


