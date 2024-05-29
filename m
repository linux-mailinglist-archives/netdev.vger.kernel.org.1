Return-Path: <netdev+bounces-99133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0AB8D3C7E
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CE71F21E58
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310219DF40;
	Wed, 29 May 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLp0t1Q7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMW11j9a"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAA194C73;
	Wed, 29 May 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000180; cv=none; b=BjCmomGnrJ6xhFm1+/BZzf2dxWpNDpzG6p+t0axRxM9rObhgmg1Wwtj5SoFcaJVRI2kQinWTJ0aHnoGIuaevrQsKkcE31trB4kbYsFEfZ/aPJnJvsVtbQoiwN4Cv0cQmEq2Qq0SzpDe8V7oXA/INsoMjWADWYPtzHw/hNTNK01Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000180; c=relaxed/simple;
	bh=VK/VABrYhjmW0ToZR4LYavotlwxdlAnOZi5bz3ErL1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9tC05Y/o3t0OVTI1A2QFiJbIcV+QrhYT7/9H/EcrWnXDD9PC1E2HZrhMDRx7xUCi+7Jhv0b3S+ai9L/doUY184qCmNWPX2k1j/R12LFVub9UNSRCSTV7/DSFJFAud+3TT6sQeQaVEzYymigiZJuMH8hvDdiL8QkXmCk0GKLK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yLp0t1Q7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMW11j9a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717000177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyotpPfu1hPZWK9CfxpEh2uU+7qkWGCiXkZRaOdpNQ=;
	b=yLp0t1Q7VBTP0s/YpEv4N5vQgwlEh1M+YIlCfGy5VCs6fGPIJTPUGDVQpSwe01URKKBvo3
	SzV6P786jC35LZqvsXZHr343Zfr1vI2TyroF/11tOtMF9ioe5UJS5gVt+TB2kv9o4mtKjl
	bZxz0nHv38p/v+1u5OhzXrx1v8hrogyaS1Uk37Zabm4ePRJQJilRWcLxRzAtLmPVvsot3P
	t9G2SvMr2LzsxO8w7k9YwQ4A5AQrE1oLBSqDnSC/70fhigVHalEivera0s9OozTis0yC2d
	YHB61+iGC12KJ/bUi1d4fgmhDjz1fzjcZazICMQ4XzDK3+g4WrE5LIrDgbvWyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717000177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyotpPfu1hPZWK9CfxpEh2uU+7qkWGCiXkZRaOdpNQ=;
	b=nMW11j9a+n6jyx1LjvE7r1f7gp9PwrxOlg/sIC3DGuo0qGMbyXByh15xzyu6/Q1rhREA5E
	ukFtp3rY+9d/J6Ag==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
Subject: [PATCH v3 net-next 10/15] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Wed, 29 May 2024 18:02:33 +0200
Message-ID: <20240529162927.403425-11-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-1-bigeasy@linutronix.de>
References: <20240529162927.403425-1-bigeasy@linutronix.de>
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
index b5ec072ec2430..f0ab89caf3cc2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3200,6 +3200,7 @@ static inline bool dev_has_header(const struct net_de=
vice *dev)
 struct softnet_data {
 	struct list_head	poll_list;
 	struct sk_buff_head	process_queue;
+	local_lock_t		process_queue_bh_lock;
=20
 	/* stats */
 	unsigned int		processed;
diff --git a/net/core/dev.c b/net/core/dev.c
index a66e4e744bbb4..2c3f86c8cd176 100644
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
@@ -5934,6 +5936,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	backlog_unlock_irq_enable(sd);
=20
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5941,6 +5944,7 @@ static void flush_backlog(struct work_struct *work)
 			rps_input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
=20
@@ -6062,7 +6066,9 @@ static int process_backlog(struct napi_struct *napi, =
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
@@ -6071,7 +6077,9 @@ static int process_backlog(struct napi_struct *napi, =
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
@@ -6086,8 +6094,10 @@ static int process_backlog(struct napi_struct *napi,=
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
2.45.1


