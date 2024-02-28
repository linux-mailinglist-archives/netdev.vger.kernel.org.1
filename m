Return-Path: <netdev+bounces-75693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050C686AED5
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ACA1F24EBA
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69FB3BBDF;
	Wed, 28 Feb 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6F77Anq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yM5b0WSb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABC1F608
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122207; cv=none; b=s6XvernhdW1T5yHCDcwAdxRSip3hDXQI12SUBiQFvQhXgWa42XQ+zjMRxDkDKxfZissdc+3F0uq+OypYuECKY2Z8xwfSwsq8hhdM8eCJrUbrk8RrbnntUr6m1mQfMUqwJPQV5/KNPA/OIA5gPTD3cDfqg7JAidvRWK3Lq+ftkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122207; c=relaxed/simple;
	bh=RAx/rSugBr3FyIsaKAEaz2zQddIN2D2tvsipZ45oJgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsqhbTk0dWZW5i+OhUPa36S238z7l3Y7azw3x7uPbAW4unPbq4vlt1Z9zVN0WMSRMD/ZTWA2po9jUE/apYQVPtr3EQhJ7HdHiXoBVWxTAw5c9c3W23kclbk4MciA5MQM0MEXNaUOKho1vRhO+jPqNZDbRhuiQ2T+kIhvgmibkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x6F77Anq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yM5b0WSb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tuhi7EF/VKrzMUN1WRvLgd9pf+l+ddOY554nuYzU+OE=;
	b=x6F77AnqayxZcnD+v9k86B/ePAEBkpZRt+QMgw2j+7iOf2F4auoVYzNOvhxJcFa03twtlh
	QF9LVkD0GUJaKxkSZDaQcKQ/bLICTmJwSyA49yvLDLlFul+soSy6ddYgprJPyYaQg+i/wA
	mThAxAiEYKZb6ArgtyHwbRajq0duEQ/Yu1wQ7SfSTO9c+mYZL3oPbuZdLhhMn8FyNJKHfy
	Iw28W3/LI/vn8gitykf7SK9dZXNyKuK9yU4ajtn/tubbuksEuE1cMCJyC6xwIdLjJ+KstG
	8dXoYRRmuC1K5qPy/cl4dOkHzl+zjq6taqse+k5c0opVNGdOKwUy+VTcBL3Tuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tuhi7EF/VKrzMUN1WRvLgd9pf+l+ddOY554nuYzU+OE=;
	b=yM5b0WSb+KVfSFhQkA5LnpO4d47oHRA5WD61Kg4RRNGAF3RyQjz26lTALZSs2XmPOGQH7t
	ljxBI2+36uHBWZBQ==
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
Subject: [PATCH v3 net-next 4/4] net: Rename rps_lock to backlog_lock.
Date: Wed, 28 Feb 2024 13:05:51 +0100
Message-ID: <20240228121000.526645-5-bigeasy@linutronix.de>
In-Reply-To: <20240228121000.526645-1-bigeasy@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index aa831d40a1f54..6ee4231f00400 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -222,8 +222,8 @@ static bool use_backlog_threads(void)
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
@@ -231,7 +231,7 @@ static inline void rps_lock_irqsave(struct softnet_data=
 *sd,
 		local_irq_save(*flags);
 }
=20
-static inline void rps_lock_irq_disable(struct softnet_data *sd)
+static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
@@ -239,8 +239,8 @@ static inline void rps_lock_irq_disable(struct softnet_=
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
@@ -248,7 +248,7 @@ static inline void rps_unlock_irq_restore(struct softne=
t_data *sd,
 		local_irq_restore(*flags);
 }
=20
-static inline void rps_unlock_irq_enable(struct softnet_data *sd)
+static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
@@ -4744,12 +4744,12 @@ void kick_defer_list_purge(unsigned int cpu)
 	sd =3D &per_cpu(softnet_data, cpu);
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
@@ -4811,7 +4811,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
 	reason =3D SKB_DROP_REASON_NOT_SPECIFIED;
 	sd =3D &per_cpu(softnet_data, cpu);
=20
-	rps_lock_irqsave(sd, &flags);
+	backlog_lock_irq_save(sd, &flags);
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen =3D skb_queue_len(&sd->input_pkt_queue);
@@ -4820,7 +4820,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
 			input_queue_tail_incr_save(sd, qtail);
-			rps_unlock_irq_restore(sd, &flags);
+			backlog_unlock_irq_restore(sd, &flags);
 			return NET_RX_SUCCESS;
 		}
=20
@@ -4835,7 +4835,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
=20
 drop:
 	sd->dropped++;
-	rps_unlock_irq_restore(sd, &flags);
+	backlog_unlock_irq_restore(sd, &flags);
=20
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
@@ -5900,7 +5900,7 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd =3D this_cpu_ptr(&softnet_data);
=20
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
@@ -5908,7 +5908,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
=20
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
@@ -5926,14 +5926,14 @@ static bool flush_required(int cpu)
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
@@ -6048,7 +6048,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
=20
 		}
=20
-		rps_lock_irq_disable(sd);
+		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
 			 * Inline a custom version of __napi_complete().
@@ -6064,7 +6064,7 @@ static int process_backlog(struct napi_struct *napi, =
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


