Return-Path: <netdev+bounces-100654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8678FB7EE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA66EB22724
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC89149C40;
	Tue,  4 Jun 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpCKXM+9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4YtD6Khv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F60B148836;
	Tue,  4 Jun 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717515894; cv=none; b=M7T0h40YiPueMuUkf0TpjGvDql+wsN87g9Y2zq+2rLqDek3+vApPGTHoy4IjURQ0GnQktgCdLfYg1wNsDmvk79bSv8FXJNOIBwyPADrsL89I/+YcVZTDwsbXaJUFQVgdEd1IAvmRMPyLUoEYI0ygAlxxIRsbS4/WX4jLEXHy9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717515894; c=relaxed/simple;
	bh=VK/VABrYhjmW0ToZR4LYavotlwxdlAnOZi5bz3ErL1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkQe3QgfFRMUHX0bIROWi66nYJPIEYcwJ8gem7MCzwQohsP2oJyJ5Cm9efAvzWs8cMvRvjT+CGZQQJGYbxcla3jML3gnkjJoT+hUuymxp5KMNQ5F1d8tPokwQ4Jz/Wc0WCHc26y2EJYVRQFFNe7cdkcM9zWp3HhOqwcLDljLR1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpCKXM+9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4YtD6Khv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717515890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyotpPfu1hPZWK9CfxpEh2uU+7qkWGCiXkZRaOdpNQ=;
	b=ZpCKXM+9WrCGWEG0UAt+9PONHJdcg0GsmcvnLaWnq2D6VxYCCTOqd/48ZC1vVKFeuQeHKg
	np0idBDlPHgxs73T/iwhSbS56A592kBQAe7Hnsm/25OCjc50OwvVlIfhjyLizH+arB1m1Q
	R25nSY1OAFlUlvcIElfE8VJdCjVuITtEuSf0aNYyO3InLWwxOJryaz4cQbKia6SVfKzxZH
	zvhJaOg4GU08Jn2ndOBTJKBvWap2TMr7OWpBUU/zadJpJRnuS3le4NfLdXukI76PH6EmoY
	h3q6qym/4iQkJBfmnjZPCe7zNFzgb07pGYTjLBxcvRmsmB0XpIUsEdOo3DxOwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717515890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SyotpPfu1hPZWK9CfxpEh2uU+7qkWGCiXkZRaOdpNQ=;
	b=4YtD6KhvS4c5YIzvfkVmxYjmKqyiuzExJKddr4fjyjjxdn0gNRYRwjxifcMY8zOmiNcRc+
	3RJBfgWMHdoV0/Bg==
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
Subject: [PATCH v4 net-next 09/14] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Tue,  4 Jun 2024 17:24:16 +0200
Message-ID: <20240604154425.878636-10-bigeasy@linutronix.de>
In-Reply-To: <20240604154425.878636-1-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
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


