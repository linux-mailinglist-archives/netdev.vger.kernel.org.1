Return-Path: <netdev+bounces-78929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01349877006
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9457B1F217BD
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547C3374F9;
	Sat,  9 Mar 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hD3zDZVS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CZoxyfhR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA3E37142
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709975351; cv=none; b=dtEmXhJEixcHqsokVGqC9LodnHSimUgPSRNneQj0Tiv6eQbwVRyDEeXimvf767KTZljPWO4jjaXCx7hf9D0VCG5Mm0INk2wUL3o5bVu2rDJ5jLbDHXsv3T/oUOcnkvL0Rzku/0J0VgWoqiThoI3FjVq6i6VYJ0ErVnHVnJXRjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709975351; c=relaxed/simple;
	bh=bSbQxH9ZGQjHd77g1oHQlR3FxqAkKU4vKjoJA6Kjl9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7Z5VRICNM9Ee4EtOiuIuc/2dBeldpU7ho47+QFOBizDXS1VpL9HJr3LCYq/8mNNzrx5UEUtzf+mHRaxT4q2bG9+XZqhAB0IXA3N3sSS+b766FvrqQSNiwsqK/dA9mDgGXZMKZgi33y8jdOWRsO4TsCtcBYL0ohnF9/ItsAA890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hD3zDZVS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CZoxyfhR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709975342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1fujFrYH+IlxTgpy5aGAkq1APEffHtkUXW5hctHyKI=;
	b=hD3zDZVSyGwKNbboQNXMUVbEpwEt4u/8iwKlF/wKriOfdrqnA1fOw0vZWzUOzXSlmz2EY1
	yb94ZRYWg8cuGDb9l23Tb2wtaKUWtXKsFZ+noYGYsuQD0ddTVEQSgA4rJuNtcdZLx6yWdL
	G6LUL8SzDoEDfE/m4eqWU1PujSpidsXaqGs4juraxDckgLn3UaWGi/8SGwQ90iONlD0Vjm
	3k1sk2M/EkUJpmsLGkUAblg1kaQrepSirDcQHWvM/RBNuBswcn1RWFEjNKwxU7w7xu1AT5
	LDdxu+x8IGK4iGJ11KVkNcwqQNvIunf+y72hg6YnL2Oae7NF9t4GqudlHS//3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709975342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e1fujFrYH+IlxTgpy5aGAkq1APEffHtkUXW5hctHyKI=;
	b=CZoxyfhRsb/dPtvZkozcAwd4U3R0Y5GeLrxrEaFnCT8xjTjlUW8GTWPLOdg1Wb5cdjs6l3
	2/VI2Scah6yIPsCw==
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
Subject: [PATCH v5 net-next 1/4] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Sat,  9 Mar 2024 10:05:09 +0100
Message-ID: <20240309090824.2956805-2-bigeasy@linutronix.de>
In-Reply-To: <20240309090824.2956805-1-bigeasy@linutronix.de>
References: <20240309090824.2956805-1-bigeasy@linutronix.de>
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
index 0766a245816bd..db8f2c2d33792 100644
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


