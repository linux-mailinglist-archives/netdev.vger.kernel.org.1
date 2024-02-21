Return-Path: <netdev+bounces-73769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A6E85E476
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD5B1F25BF6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFF84052;
	Wed, 21 Feb 2024 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cc5UHLb2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUz2KXhL"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD583CDA
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536051; cv=none; b=q7mz7TIPw4NG4OzJn7ri4sJG2yD4ohoiM50iHBk7LfvMDLAz63NLMyiPhF3izxaXGStozUQHksxEPKgVN/EDO9Eg4xLwDkEyM+pDmSCcI9vPpcT8ISLCzOLPx2kRcZVnUws5AF1fJCt2a05arucCwq49waGzZpCi4G6fGLaP2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536051; c=relaxed/simple;
	bh=qAOeTSjxeSQCA1oBQM8EN8bFxkJINALiZnOqHj50VlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9LlDclxHylED7p+KixZDxBJiRidkP58a1MvF29Duhg1gdqQl5PAlvwGUQw9V/wfC4vj6znW+SLzLlxPW1u4/xw/v0JaScdw0nRsb5aU8VI++AmMAMk6XS+k2OkwNUy+WLtZeyqNQnY6QH1D6JyCI9FwQxN3xAmrrwZQBVtgu14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cc5UHLb2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUz2KXhL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708536048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDB1CiIXO9rUHoMEEsXqI3Z0Cu5hb1cEq0hsvZbp0Ck=;
	b=cc5UHLb2kw34+2893gdgvFLHNRcpe5Dpjnz0ikOQ3z/L5W2ItdG1dI4nCj/kjRisD38vqT
	pH5GUg2V7ARQXm19EO8Azv4du1tDm/qdRLfh5BH8Z93oiOKHI/D5zYFTGvJgvdy4hH41FF
	VZPaK0VziFZqZzUXoz5usiaY99T/W2icCCo7DIatBXRWhhaZ949pMVaUsYx1d/l8hh8FPQ
	GFYKzy6pFd26Sdf+KkD0gLxsda/Ob/gDtoSEBbveAzxayHtXuHNqzInlLdHxdJjftqjB57
	v5baeziKvOlSVaXkn9khu7p7VFkJyKTCOuw8Z5HsuMoh45imfZtaov9TT/8tfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708536048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDB1CiIXO9rUHoMEEsXqI3Z0Cu5hb1cEq0hsvZbp0Ck=;
	b=aUz2KXhL15HoC0h126aDbeNzq0fKhkANI6V86UCmc8BF0sg/60XUS20sI9P4Q2HxTxCD3Z
	J0AFbLA+6IJe0+DA==
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
Subject: [PATCH v2 net-next 3/3] net: Use backlog-NAPI to clean up the defer_list.
Date: Wed, 21 Feb 2024 18:00:13 +0100
Message-ID: <20240221172032.78737-4-bigeasy@linutronix.de>
In-Reply-To: <20240221172032.78737-1-bigeasy@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 28 ++++++++++++++++++++++++----
 net/core/skbuff.c         |  4 ++--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f07c8374f29cb..0a7390f011be0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3368,6 +3368,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
=20
+void kick_defer_list_purge(unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 6aa3547c03a4f..8b228861f29af 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -225,7 +225,7 @@ static bool use_backlog_threads(void)
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_save(*flags);
@@ -233,7 +233,7 @@ static inline void rps_lock_irqsave(struct softnet_data=
 *sd,
=20
 static inline void rps_lock_irq_disable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
@@ -242,7 +242,7 @@ static inline void rps_lock_irq_disable(struct softnet_=
data *sd)
 static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 					  unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(*flags);
@@ -250,7 +250,7 @@ static inline void rps_unlock_irq_restore(struct softne=
t_data *sd,
=20
 static inline void rps_unlock_irq_enable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
@@ -4735,6 +4735,26 @@ static void napi_schedule_rps(struct softnet_data *s=
d)
 	__napi_schedule_irqoff(&mysd->backlog);
 }
=20
+void kick_defer_list_purge(unsigned int cpu)
+{
+	struct softnet_data *sd;
+	unsigned long flags;
+
+	sd =3D &per_cpu(softnet_data, cpu);
+
+	if (use_backlog_threads()) {
+		rps_lock_irqsave(sd, &flags);
+
+		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
+			napi_schedule_rps(sd);
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
index b9de3ee65ae64..427387ffd3c8a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7034,8 +7034,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+	if (unlikely(kick))
+		kick_defer_list_purge(cpu);
 }
=20
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
--=20
2.43.0


