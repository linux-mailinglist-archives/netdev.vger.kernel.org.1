Return-Path: <netdev+bounces-102948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7566905977
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC7E1C20C9B
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0D184122;
	Wed, 12 Jun 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="skoyXNOm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OB3owYzK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658A18307D;
	Wed, 12 Jun 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718211806; cv=none; b=hUxf6Mwa6akOJDuS6N+ok2E+9QEo/NuLzg+GKoEEZc5Ng/MqjRtJJTNhOVXg+eMvLnQRNrNssgZ9Kw7/s8iY5UfcOnQa/cGzx+kzkJ+aOPrJn7rQ+4j680MSoMGDZ+eZX9ymQpLTwrQdjBy5A41YNJWa/JtqFnF99Cutd7O1JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718211806; c=relaxed/simple;
	bh=Dc9K7FbOzvnCnQ7YjwcHMDpDO+2CpuZPjAmDo/rJQPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVumuJOtsEF6nT/DEKe4OYhF7+PQ84FZI61B8ZMnRFXrxtfeM67av3dk0d12fyQTyMsHZXkLvgTLeaKqoONL1jU8JwgKBI4YuK3hjfiaVZGkSMdK5UZXlPmKh5ggBGIUX2Kfnj7IMCRN2Jp6t+irFKa7I1FMSYCXra7dYkDJHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=skoyXNOm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OB3owYzK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718211798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rkxInydfFtfvggdcg//PVGon9qRuIuZC+F3Nel7lMs=;
	b=skoyXNOmo9GofkPsX77G+tnDRJKexu4QkvyvI5QT8jZuNa18/8Uw4QMNj1xW3ahmPF55M7
	V8dWC+UjZXMI4lC/mSUTUhPM1HVbdmzDWakPilj5Poj2WVguuLeyggdNmE7EZ7q+DXIcfc
	aF272LJ54d2awxsQ2a7NO6sH1dhgRL4NTDYTfR0/OFX1DwWKxX0b0b3bKq2aGslQvOZvZz
	NrkP6QJ1ctKxiql9qcsnDUkI4ZVMxJh0+e9AWagTxDoAaNylKZph03wRdF/+y4O8D4aMzf
	UZTmtP1AkXumiZqNcMl+t7xEYJpMBkOkbrX+jaoK2BKUTua75YHJWZyyOgAFSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718211798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4rkxInydfFtfvggdcg//PVGon9qRuIuZC+F3Nel7lMs=;
	b=OB3owYzKtLM152rdh7IJxd2PuPTOgkD6RYRpjtqGuEoyFluCrnZCK/cwW4ek7wm7WxPA0J
	HAPolJva868vqYCw==
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
Subject: [PATCH v6 net-next 10/15] dev: Use nested-BH locking for softnet_data.process_queue.
Date: Wed, 12 Jun 2024 18:44:36 +0200
Message-ID: <20240612170303.3896084-11-bigeasy@linutronix.de>
In-Reply-To: <20240612170303.3896084-1-bigeasy@linutronix.de>
References: <20240612170303.3896084-1-bigeasy@linutronix.de>
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
index db6b6fc997e6d..ba406bc42b133 100644
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
@@ -5935,6 +5937,7 @@ static void flush_backlog(struct work_struct *work)
 	}
 	backlog_unlock_irq_enable(sd);
=20
+	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state =3D=3D NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
@@ -5942,6 +5945,7 @@ static void flush_backlog(struct work_struct *work)
 			rps_input_queue_head_incr(sd);
 		}
 	}
+	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
 }
=20
@@ -6063,7 +6067,9 @@ static int process_backlog(struct napi_struct *napi, =
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
@@ -6072,7 +6078,9 @@ static int process_backlog(struct napi_struct *napi, =
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
@@ -6087,8 +6095,10 @@ static int process_backlog(struct napi_struct *napi,=
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


