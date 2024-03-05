Return-Path: <netdev+bounces-77481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC1871E6B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 13:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6C6284FD5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48165915D;
	Tue,  5 Mar 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DZ3h48p+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bADG7Sp"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65256758
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640022; cv=none; b=oCJWkN0VC/YL2pQR/BtvKZLw5aQok2Yw9ODdl2P6LusdCAQpDoCoU7JVcy8ylm5UF38lSWVEg4detsHQD2WEPR5ef8jTnZwIp6OqR0rZB2Wut0PXMGU3iUp9477Qb/eSryU7NqPgf+Kr/NiCKCIF/RoaizaMi5eSq6UGWilrIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640022; c=relaxed/simple;
	bh=Mv3v/NMtd1XS9qne058p3PtUn1yBmAHQg4G4wooe36M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUOGkwp2gAwxgxJU7vPet4zdjYZrM15MqxHIktd+/OHQGEh/s/R0CE6oOcSVefTKj97Yw0dTUj78IZghyW+Ho1Z7cNeUNykGp9Yq5L0h2GLxLf4TQRMJy17WqwDLGNUsinC7lVrvqdYy5Gf1C80qUHnmm+W/MQYr3fjYBAljAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DZ3h48p+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bADG7Sp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709640019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCaddM3xhV5JRs0tRmSplPAY+US5sUgMjs8JDnagyZE=;
	b=DZ3h48p+voZxi1/NwKvdziJRoZkTOFdyX/XTtlILdx/ZYhtz/PNjdbqfWRB+vxYnth8FrV
	T8lH6e1TsW14AgT/qUwPNfvASOMqxHs8D08fYcRwi01Pgi0lLbMcJywhjCKMkXsL06FfM0
	QURZsTjcyGaL1/t/JedHNMbxXu3SUfsDadZfOQEAmOsdnOpcquYU1CFXA9IwUOGUIVzL4S
	nY60yAApNh3hM3TQzmrAlA/TIwZC4KwVA8t+DlAhID8pmpAkyeoJeY3YHETZv/TPSAHkg2
	HsBhceiK5GQYKrexzk1ufxjf+mhXA1wwh3TDXR/vrMDMSHVp5Zk+iqazYI1bVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709640019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCaddM3xhV5JRs0tRmSplPAY+US5sUgMjs8JDnagyZE=;
	b=8bADG7Sp5olzgv8cxDMIbP8V9v83B2HcF+EQMsf4WJesoYB28evW9qAWRlh/QQp3mtnH1l
	U48Fu9eaJJ7DeCAA==
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
Subject: [PATCH v4 net-next 1/4] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Tue,  5 Mar 2024 12:53:19 +0100
Message-ID: <20240305120002.1499223-2-bigeasy@linutronix.de>
In-Reply-To: <20240305120002.1499223-1-bigeasy@linutronix.de>
References: <20240305120002.1499223-1-bigeasy@linutronix.de>
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
index fe054cbd41e92..fe1055fe0b55c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4436,13 +4436,7 @@ static inline void ____napi_schedule(struct softnet_=
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
@@ -6723,8 +6717,6 @@ static int napi_poll(struct napi_struct *n, struct li=
st_head *repoll)
=20
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken =3D false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
=20
 	while (!kthread_should_stop()) {
@@ -6733,15 +6725,13 @@ static int napi_thread_wait(struct napi_struct *nap=
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


