Return-Path: <netdev+bounces-77484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F85871E6E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1600E1C23281
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7692C5A10C;
	Tue,  5 Mar 2024 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kojPfjm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESDqap8f"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946E59146
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640023; cv=none; b=Fp6Cm3kIn2qojWswFNk2N4jGyQ2Js1Xn+8G6R0CMw1apZC97CEbsfkasKwEje/Y/bTsTJJ5k2LwLP4QWLyd9ta81xKH7OGjOjdzecnYeu06APUoNAByQwzlzvTiXmTW8gQxChPUQulS7+srDLeyibtOYkDsh/BGYK9xb6Pv3zK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640023; c=relaxed/simple;
	bh=D832GVr57Y01exTBhDLEDuJTReMKp3tLqILH3QvphRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiZnZlQmiuLbKUL6cgxiOvrF0izW3bs/sN5t+F3jqo7Yh2GE/CM8hm6vUzpZlPfKApniAeefAYUWwBezIxLIvHWh9aiLXUISEj868znw5QDNnc1KjY9nOKSHl1Lb43Gb+XYNrykt59NXTvpthBKzbXUh+NvwKYo+trMek8CQYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kojPfjm+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESDqap8f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709640020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cClXO3t0I+B0wxp57Ht8eUggfp8rir4eXAkt7eY7veM=;
	b=kojPfjm+wwjptPvnHUhzaKKam0Mh6ZIIVfDgueISnBzwP+8Ou+bDqmfsPvv5+LmBE5pZCs
	Gj+MwyxRAHquFJ4Qi3ED9tqdxnMWf25oCwgRyTJa4Tr3O2Lh50/B0PGAKqLlaGd7i5VOJx
	YRtGym9dYJKeA3cNjBoI5AikNlqT1IiXmtwDT0RXrhIBA99V4B7104VTphTUH3GaFoN3wK
	u/s3U5lrpXKN8RGDu/xwMAL9BKeSCR+ykk+rc5vjSOffUgK8E56X7xM0XyjPrRRCfXrzOp
	Z2VB9BSEuknQS8agWpFzloOEmuQq61eOnFYeIbec+RrCcs1bVDbOZQxEsaMpaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709640020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cClXO3t0I+B0wxp57Ht8eUggfp8rir4eXAkt7eY7veM=;
	b=ESDqap8fsB3hSqRTol8fQjrezaZ5yI4r5j7lw7QgUe7CVw5EFfiMqBbW/MgGyhP0NujERA
	oQQS1RzSubp7Q5CQ==
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
Subject: [PATCH v4 net-next 4/4] net: Rename rps_lock to backlog_lock.
Date: Tue,  5 Mar 2024 12:53:22 +0100
Message-ID: <20240305120002.1499223-5-bigeasy@linutronix.de>
In-Reply-To: <20240305120002.1499223-1-bigeasy@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rps_lock.*() functions use the inner lock of a sk_buff_head for
locking. This lock is used if RPS is enabled, otherwise the list is
accessed lockless and disabling interrupts is enough for the
synchronisation because it is only accessed CPU local. Not only the list
is protected but also the NAPI state protected.
With the addition of backlog threads, the lock is also needed because of
the cross CPU access even without RPS. The clean up of the defer_list
list is also done via backlog threads (if enabled).

It has been suggested to rename the locking function since it is no
longer just RPS.

Rename the rps_lock*() functions to backlog_lock*().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 5ce16b62e1982..024d55e7af7d5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -223,8 +223,8 @@ static bool use_backlog_threads(void)
=20
 #endif
=20
-static inline void rps_lock_irqsave(struct softnet_data *sd,
-				    unsigned long *flags)
+static inline void backlog_lock_irq_save(struct softnet_data *sd,
+					 unsigned long *flags)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
@@ -232,7 +232,7 @@ static inline void rps_lock_irqsave(struct softnet_data=
 *sd,
 		local_irq_save(*flags);
 }
=20
-static inline void rps_lock_irq_disable(struct softnet_data *sd)
+static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
@@ -240,8 +240,8 @@ static inline void rps_lock_irq_disable(struct softnet_=
data *sd)
 		local_irq_disable();
 }
=20
-static inline void rps_unlock_irq_restore(struct softnet_data *sd,
-					  unsigned long *flags)
+static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
+					      unsigned long *flags)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
@@ -249,7 +249,7 @@ static inline void rps_unlock_irq_restore(struct softne=
t_data *sd,
 		local_irq_restore(*flags);
 }
=20
-static inline void rps_unlock_irq_enable(struct softnet_data *sd)
+static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
@@ -4742,12 +4742,12 @@ void kick_defer_list_purge(struct softnet_data *sd,=
 unsigned int cpu)
 	unsigned long flags;
=20
 	if (use_backlog_threads()) {
-		rps_lock_irqsave(sd, &flags);
+		backlog_lock_irq_save(sd, &flags);
=20
 		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
 			__napi_schedule_irqoff(&sd->backlog);
=20
-		rps_unlock_irq_restore(sd, &flags);
+		backlog_unlock_irq_restore(sd, &flags);
=20
 	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
 		smp_call_function_single_async(cpu, &sd->defer_csd);
@@ -4809,7 +4809,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
 	reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
 	sd =3D &per_cpu(softnet_data, cpu);
=20
-	rps_lock_irqsave(sd, &flags);
+	backlog_lock_irq_save(sd, &flags);
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen =3D skb_queue_len(&sd->input_pkt_queue);
@@ -4818,7 +4818,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
 			input_queue_tail_incr_save(sd, qtail);
-			rps_unlock_irq_restore(sd, &flags);
+			backlog_unlock_irq_restore(sd, &flags);
 			return NET_RX_SUCCESS;
 		}
=20
@@ -4833,7 +4833,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
=20
 drop:
 	sd->dropped++;
-	rps_unlock_irq_restore(sd, &flags);
+	backlog_unlock_irq_restore(sd, &flags);
=20
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
@@ -5898,7 +5898,7 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd =3D this_cpu_ptr(&softnet_data);
=20
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
@@ -5906,7 +5906,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
=20
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
@@ -5924,14 +5924,14 @@ static bool flush_required(int cpu)
 	struct softnet_data *sd =3D &per_cpu(softnet_data, cpu);
 	bool do_flush;
=20
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
=20
 	/* as insertion into process_queue happens with the rps lock held,
 	 * process_queue access may race only with dequeue
 	 */
 	do_flush =3D !skb_queue_empty(&sd->input_pkt_queue) ||
 		   !skb_queue_empty_lockless(&sd->process_queue);
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
=20
 	return do_flush;
 #endif
@@ -6046,7 +6046,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
=20
 		}
=20
-		rps_lock_irq_disable(sd);
+		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
 			 * Inline a custom version of __napi_complete().
@@ -6062,7 +6062,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
 		}
-		rps_unlock_irq_enable(sd);
+		backlog_unlock_irq_enable(sd);
 	}
=20
 	return work;
--=20
2.43.0


