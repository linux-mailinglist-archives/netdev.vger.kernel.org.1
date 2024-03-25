Return-Path: <netdev+bounces-81527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8DC88A266
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBE61C37854
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A11B2500;
	Mon, 25 Mar 2024 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQ3mVi7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/anK7OI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8412F5B9
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353016; cv=none; b=r7xgpb1yDAvomcD6zgBOInjMP/TneUDQEOreMYqF5J5RQvG/6jmkUZdPYooHuB/+tZyfuQny1gCZhiaKaNyNz77EzRY3DfwuDdjEad3i2qSmIkSjvdMmsUzOCysAPftYMWDWX3Trw9BX7pdfzU68w2z6PiFz6Sn99+kgYcYQRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353016; c=relaxed/simple;
	bh=uJAAHL+T6qwxMdjRLJusP2pLAegjX5uuWi6/GooXOkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpBmfTEX/fdZjfNei4+k1WEKYPaibBQWNFSuFxIxKFxJGt/kl8ZqqaV8+AcRgrMecD3q1whCNaMGKNJdiKDJOZPJKWf2mpsUz8faUuyjGmc2Z3EFqzmNJC6T3S/wUYKx/N5DbbDM3YJMaPWJyfF/4nllQXXeNbuzzLlE4/NVy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQ3mVi7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/anK7OI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YovFphdmx7EzHzgesAYEor0S2xnIOLp6q/HGdUlO0uc=;
	b=jQ3mVi7aQ6ll7ZdQyFajuRBhd0a2gnOPUy5Y1Dr1QyF6ESDwi3g461fOQqFowuyENmi/gA
	ztx2ETeQNHJi/sPPgTgjJRnUzPUEEz4Kv213T9mMPP9XDx8OQ0oBW12SkbxBikMJypPnQE
	rt9OZIEQd3A4+L1VLTNVTKVF7b/vxPxhCOtlFv2c/nvKbUFaruZv02W0dsFZd7+mIJvEfl
	gpJxHsUktA1NCdwsdStCg2Rur3HW+KdxGFlYHTFbubJJLMDY1/9MbxaXNa6WEJ27xEtMOV
	5NBTogcc3V2x/rOORdbTn11e7bjrmRy3B8ooHFUUNsMy8DilCosbgDnDWLjNeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YovFphdmx7EzHzgesAYEor0S2xnIOLp6q/HGdUlO0uc=;
	b=C/anK7OIfzCCBMMCSZa637XzA8H4OywbH2A9HavvLW0J3hZpDZ+AdvBnyy5qMgJSax+f9s
	d2G++Fd2Pd8bfNDg==
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
Subject: [PATCH v6 net-next 1/4] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Mon, 25 Mar 2024 08:40:28 +0100
Message-ID: <20240325074943.289909-2-bigeasy@linutronix.de>
In-Reply-To: <20240325074943.289909-1-bigeasy@linutronix.de>
References: <20240325074943.289909-1-bigeasy@linutronix.de>
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

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db8..98d7d339a8c1f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4427,13 +4427,7 @@ static inline void ____napi_schedule(struct softnet_=
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
@@ -6710,8 +6704,6 @@ static int napi_poll(struct napi_struct *n, struct li=
st_head *repoll)
=20
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken =3D false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
=20
 	while (!kthread_should_stop()) {
@@ -6720,15 +6712,13 @@ static int napi_thread_wait(struct napi_struct *nap=
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


