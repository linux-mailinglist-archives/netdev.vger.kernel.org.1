Return-Path: <netdev+bounces-75692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0E686AED3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C6B281493
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4FB3BBCA;
	Wed, 28 Feb 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DNTn7aW6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWtzUQTW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3E7353F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122207; cv=none; b=IJKCRK5YaKaY0qW/+akUoSm4f7a/jjG1CEAtR7wLMQpVxnpkKY3cJwIMmHOIZGw8RsVHN5ysASmIqYt1hxQcrzPmWJ6OAxc1dNtNaJo6QPY0K6aXOnv5plDNhie1Knuk5kZ/tONum31ZfIfArZRSvuj5sD9LwYwJaLGE/WZro9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122207; c=relaxed/simple;
	bh=CgKiabh5Lt6zyfssdKEFyuIHwHEXUsJjgNB+tEwXYXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mONw/LIXKYhu2Jxooj9jnHPxdjaiZzSI8aVNNImoRFthNpcOEHSY8JtZdZaMYmUsIZLAs0EjWIjT76IvUbQ+6Ov10S9kb/LF6j6VJU5G5GSY1/jXS0eRgAuGPbl3esm8ENzmkVYtQaqN/qkeUkIJflg45OUnNUs5YYEHcysJOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DNTn7aW6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWtzUQTW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oEYqKhwveXGIGItueiCCGQMV594VcZ8EGsFFNqBsag=;
	b=DNTn7aW6cvGrQrlZzCFv3f3mO/qxUaO2mneVdDMaZXGqm8dWbEQE5pf7w8RMvlKSrv8iHc
	hMQ6jowCZVAEGbd08lWT0dC4f1qDBPWqsG8VdH58CDkU8yYbzTYLkNSLa7ymsIIc/EK2EX
	0PLG+7GCpbshJekn2cmZmMh/H+3LpxJmKugqMhEHCUrhOjBLfqqlyAfovQJAF27bcQEpiR
	8kDKVddEwf+kHZoSPkn2WJH7qkGZPBzP36+8EnuSsiKJM8Tnk2SP0RYlLDwOTVcAh1nxbr
	RveXJZsBzXJrlyS/pwBCfJfn4p9WADMu4DfeuZsZW7CN0gNhjXYKgx7YsHX3ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oEYqKhwveXGIGItueiCCGQMV594VcZ8EGsFFNqBsag=;
	b=LWtzUQTW8sC/8pPld3ZAe8xP+IKitEBIf9Er60ayRddyB0w3E4nTgRPFcT4OiN7gCN2LxC
	XE3FG8pu14YXD0DA==
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
Subject: [PATCH v3 net-next 3/4] net: Use backlog-NAPI to clean up the defer_list.
Date: Wed, 28 Feb 2024 13:05:50 +0100
Message-ID: <20240228121000.526645-4-bigeasy@linutronix.de>
In-Reply-To: <20240228121000.526645-1-bigeasy@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
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
index 09023e44db4e2..fe5f4d7d397e2 100644
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
index b449b60546554..aa831d40a1f54 100644
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
@@ -4736,6 +4736,26 @@ static void napi_schedule_rps(struct softnet_data *s=
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
index 1f918e602bc4f..0c9676157a2c1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7042,8 +7042,8 @@ nodefer:	__kfree_skb(skb);
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


