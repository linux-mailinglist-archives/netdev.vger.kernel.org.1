Return-Path: <netdev+bounces-75690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB22D86AED2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9136B1F245E7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313F36129;
	Wed, 28 Feb 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sm1CWNs5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bth0fIfn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA37353D
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122206; cv=none; b=PmDmopFKZeqwFOHX8NG/RIISLiu9fBaxVxsdUQMGJ0+azIuOIF2ut5D3U2K2hSgTj9FiGUlpnvkmWXupRhv99bePBcXJRguz8m7/Kp//DS9kgy5HGogWBzi1Wgvgt3HFYAhRwagqf9jMXSGRMxrpi1s1R1eeAZjJ5XuyeR4xJ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122206; c=relaxed/simple;
	bh=d5cZxgHOSxYl2L5vyXHl0TuAk0hcCh84UFLszr2LNgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn3lhUWN5NupSEJzepygjS/T7ncaqMFMl78RsSQ8k+M2wSlRznrmJI1Rm8xyTIpSkRXhQMcLWxNPmX2+miXGcro/74TzhSMiYJtspJWmTPMk45nQ2XMu2w6ESSQD95dVzEf+E0LL4DatTneN/RldnVXkfUcbxiZmDix45n2kb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sm1CWNs5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bth0fIfn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yosrrn4m374EGK/14DqRIz1O1n9eFp/cpKcHUCkz69g=;
	b=sm1CWNs5xijf56G5hGtNkkZXm+2aqYQ9FvSI6moGHkRiZHK5kYxKEdh3Y1aAIm2SvqoHDq
	hM31KBZUpmV5+LwmW5SP2WsFLHFLOr3xXynrZhbZnTyBnIPgKmH6yAoAoqV9ol57vpoQoL
	nibkUSwqu02Yen3sUOGAjwNGnvE8tERS5aJ5qqtzXxpYTCnMFk+DZ8R3dpoHtqzYFmcfPW
	lPsTxuCbrwDwyqwVa5o81IlNiPANsAEA28yqAsCCEnIiFfvp/BVoDKwJdCh/z1nc2eAOXU
	9rDvfIt8nIvimQ39B2tYnQ57W+17zG/artHOJAuYXkA8XTC3ndrISfVRaJTwPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709122203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yosrrn4m374EGK/14DqRIz1O1n9eFp/cpKcHUCkz69g=;
	b=Bth0fIfnY4ZtqU1xWR+cta+csMrKMfovQGP6rXWj7zbEPBxFuDJ17lMkB+MsBcdZCi2wZF
	UYLpEcGLmcKHqWDA==
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
Subject: [PATCH v3 net-next 1/4] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Wed, 28 Feb 2024 13:05:48 +0100
Message-ID: <20240228121000.526645-2-bigeasy@linutronix.de>
In-Reply-To: <20240228121000.526645-1-bigeasy@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
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
index 275fd5259a4a9..dbc2f96ac37eb 100644
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


