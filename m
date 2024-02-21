Return-Path: <netdev+bounces-73767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAE85E474
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6942282327
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2303983CD6;
	Wed, 21 Feb 2024 17:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R54gFdSc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FbK8b4pu"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504283CD0
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536049; cv=none; b=WYRiwfJ46Q0HdV9fw4fEEGfm9FUNgjVRIYwZm0mUPgoABAOd/LnpuCgDihORWoQYzCkjTlTau8O1mPfdf7Tfl0kAbqTN4eaP0EpcSqjMkBtxP/EwlOXJwwiUXXcK2LfREujEkktE4wU4YzUVOznpxqmWaa+ijUuRrRjcQQnE7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536049; c=relaxed/simple;
	bh=hbF9NLnUGiMyvkTf7RyeayWKeybqMOoqMq/JU0smNnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8pmL20gDg1g8C6Oka7gQaMLsClOEQz4vzHhNGwprFut5znYfo7MKY1iW36Vu+QtJX24iMIpvO9kC4NzFGUeIly17sdSTYWA744E1vCGRuSi/oY5B3msKQzT9TRBBbfQI/eShbu2NX5pRZk+GQhWuAhHC+5g62Lh2EJlhfOqZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R54gFdSc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FbK8b4pu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708536045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtHCWYWiO1+gx8hJybn3zlyAYoZDaiv1FK7PQPfluPI=;
	b=R54gFdScWggM6uFgCCp5JNhFa5/Co0nkc67rBNAmfyADGl8yHPgr0qNb71JNaX7TW6hS33
	1PBtBoXoMjc70Qt8svM+uHWvAyLB2d54Vi8rXHeNUI9EC5seDieRlq0hTXowRAdcIVnBcw
	ifwyYnvqBtCBCsRnI4JOFM7PvHm5HLrQFXh5ewqWM7GZ5mC3QTQ02YioDx5AH6WCP8ANkp
	lxdQGOgJHlZqP5egjmVsIxz7rfhDzwMQcTSYlVOAiNE3jmuXMjhWaR0qbbnGsJEXZbc/3Q
	pymmv5SS07skhDYSsHQJk6uqFB7Kgy/10/Jc+nnOPja/me86+HsN3ecUINyM6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708536045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtHCWYWiO1+gx8hJybn3zlyAYoZDaiv1FK7PQPfluPI=;
	b=FbK8b4pu9Gha83RwYytoJUHGMuJxpb2V3Hsq7H4piNqhhWYhhJknvp3NuOFO98+FTsOBB9
	7/a3fwt8qm4GhnCA==
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
Subject: [PATCH v2 net-next 1/3] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Wed, 21 Feb 2024 18:00:11 +0100
Message-ID: <20240221172032.78737-2-bigeasy@linutronix.de>
In-Reply-To: <20240221172032.78737-1-bigeasy@linutronix.de>
References: <20240221172032.78737-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A NAPI thread is scheduled by first setting NAPI_STATE_SCHED bit. If
successful (the bit was not yet set) then the NAPI_STATE_SCHED_THREADED
is set but only if thread's state is not TASK_INTERRUPTIBLE (is
TASK_RUNNING) followed by task wakeup.

If the task is idle (TASK_INTERRUPTIBLE) then the
NAPI_STATE_SCHED_THREADED bit is not set. The thread is no relying on
the bit but always leaving the wait-loop after returning from schedule()
because there must have been a wakeup.

The smpboot-threads implementation for per-CPU threads requires an
explicit condition and does not support "if we get out of schedule()
then there must be something to do".

Removing this optimisation simplifies the following integration.

Set NAPI_STATE_SCHED_THREADED unconditionally on wakeup and rely on it
in the wait path by removing the `woken' condition.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f5..aa6bb985dea9b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4435,13 +4435,7 @@ static inline void ____napi_schedule(struct softnet_=
data *sd,
 		 */
 		thread =3D READ_ONCE(napi->thread);
 		if (thread) {
-			/* Avoid doing set_bit() if the thread is in
-			 * INTERRUPTIBLE state, cause napi_thread_wait()
-			 * makes sure to proceed with napi polling
-			 * if the thread is explicitly woken from here.
-			 */
-			if (READ_ONCE(thread->__state) !=3D TASK_INTERRUPTIBLE)
-				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
@@ -6700,8 +6694,6 @@ static int napi_poll(struct napi_struct *n, struct li=
st_head *repoll)
=20
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken =3D false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
=20
 	while (!kthread_should_stop()) {
@@ -6710,15 +6702,13 @@ static int napi_thread_wait(struct napi_struct *nap=
i)
 		 * Testing SCHED bit is not enough because SCHED bit might be
 		 * set by some other busy poll thread or by napi_disable().
 		 */
-		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken) {
+		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
 			return 0;
 		}
=20
 		schedule();
-		/* woken being true indicates this thread owns this napi. */
-		woken =3D true;
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
--=20
2.43.0


