Return-Path: <netdev+bounces-104379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4290E90C568
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF9282027
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C8158859;
	Tue, 18 Jun 2024 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FLm5lPFU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tf387lz9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669AC156F42;
	Tue, 18 Jun 2024 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695541; cv=none; b=G8FDMw8lzFjn4TTnOx3Y1B3sOEyYHUsH1paHP5IxPScOKnTXG35+RjnXM9BrhE/ElNZldxIPjCkkrWoOiCX4G9jC6eXF5YIQcWoDa9+NQ1GCvOwFjZIszgqsVJlO/1o5HRzrrVo+CP36+VJlCIMKIJviZ1e5y6IssvnnLIh53ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695541; c=relaxed/simple;
	bh=X7R5a5q84PVJIRPwRnjIqVBMxLGbsKuD9OquSDsOxKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiMKb6gzHabEezoEIeyZKzcI9HeQ29l3beETe/uN7Z8CvT7FlzfnBoD+aCDT1DalP2gnwnYdQttgZwR1a+JJohJ3Ee77WMiasd6lTyfBnBAaAohsApXQWHP6dfuigrkkM6LDn616oWZ+IKKdIveHSodWqegTUeVEv5reB86Aprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FLm5lPFU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tf387lz9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718695535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4+m+Kh4U5SEuxn55rR3Br3eloKf+1N6uKkudtS94Sc=;
	b=FLm5lPFU3rFNpHkkyVotHGe7jKhlMf30Fi8J1JX4TDDI/eHVrnIhQ9gv7b7dYw2ySlDM0L
	zYuLArV13A6oRBtBpuSDPh/fZOoco+TFO7MBC7SyQTmbmQYBfYGBl478xERSPqY8d4YImp
	NwHhd4dYfqXTPhbwxFGVxf2EDti0CrHuIVUPCja8cg4v5MnFmb8aZdfkSxEn+NPWmqAmFv
	YebdUCfw0SR0u0pP7Y/Q6SVHDd7B7l+N3LtazcPa4kXDDGLMzacfEvB0YHkYW94760i+B8
	o6A5BZEGe8PBsvg+75c63L3LfP9wmmsrD1JXqYeUauaQMXLZ+1CCqAOfnqcA4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718695535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4+m+Kh4U5SEuxn55rR3Br3eloKf+1N6uKkudtS94Sc=;
	b=tf387lz9ZTJTpKWgz/ePSVgzNn6Gw8g8zl+zlgrTHyr604eYngzXFHhM6Rg903AV2DVWEe
	yommig7mxgWfE0Bg==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v7 net-next 10/15] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Tue, 18 Jun 2024 09:13:26 +0200
Message-ID: <20240618072526.379909-11-bigeasy@linutronix.de>
In-Reply-To: <20240618072526.379909-1-bigeasy@linutronix.de>
References: <20240618072526.379909-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

softnet_data::process_queue is a per-CPU variable and relies on disabled
BH for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

softnet_data::input_queue_head can be updated lockless. This is fine
because this value is only update CPU local by the local backlog_napi
thread.

Add a local_lock_t to softnet_data and use local_lock_nested_bh() for locki=
ng
of process_queue. This change adds only lockdep coverage and does not
alter the functional behaviour for !PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 96b233a0bc2b3..f725129c9f6f4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3202,6 +3202,7 @@ static inline bool dev_has_header(const struct net_de=
vice *dev)
 struct softnet_data {
 	struct list_head	poll_list;
 	struct sk_buff_head	process_queue;
+	local_lock_t		process_queue_bh_lock;
=20
 	/* stats */
 	unsigned int		processed;
diff --git a/net/core/dev.c b/net/core/dev.c
index 2745001d09eb4..42ac76524e84e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -449,7 +449,9 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
  *	queue in the local softnet handler.
  */
=20
-DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
+DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data) =3D {
+	.process_queue_bh_lock =3D INIT_LOCAL_LOCK(process_queue_bh_lock),
+};
 EXPORT_PER_CPU_SYMBOL(softnet_data);
=20
 /* Page_pool has a lockless array/stack to alloc/recycle pages.
@@ -5949,6 +5951,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	backlog_unlock_irq_enable(sd);
=20
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5956,6 +5959,7 @@ static void flush_backlog(struct work_struct *work)
 			rps_input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
=20
@@ -6077,7 +6081,9 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 	while (again) {
 		struct sk_buff *skb;
=20
+		local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		while ((skb =3D __skb_dequeue(&sd->process_queue))) {
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 			rcu_read_lock();
 			__netif_receive_skb(skb);
 			rcu_read_unlock();
@@ -6086,7 +6092,9 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 				return work;
 			}
=20
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
+		local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
=20
 		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
@@ -6101,8 +6109,10 @@ static int process_backlog(struct napi_struct *napi,=
 int quota)
 			napi->state &=3D NAPIF_STATE_THREADED;
 			again =3D false;
 		} else {
+			local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
+			local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 		}
 		backlog_unlock_irq_enable(sd);
 	}
--=20
2.45.2


