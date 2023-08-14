Return-Path: <netdev+bounces-27285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A0677B594
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2603281121
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1778AD4B;
	Mon, 14 Aug 2023 09:35:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4EAD47
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 09:35:41 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288EBE71;
	Mon, 14 Aug 2023 02:35:39 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1692005737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNjgejAz/yJ5TpCvyso2wcCPwKOAf1wNRQTPDKcGTfA=;
	b=DAGBEmRYsVr53rxZUrr9kH7AFigcg2gOp1zzKrV3ze71DuSTWxRx9Edidiw+mB8x6MfiRj
	ypeXlw8sI6TCh6pzQSFs7N8k1MX14Bs7CTa+RdlYBNC+7k83G1KL0k3jrDnH/C03WG3p/7
	lkfB2MgyB6E/+WhByghfLnMKDAzsans5FqnghJemuCCrsJEN9qulipvZ3coTLxjPyhF2iG
	bG1LXeAv4GEuXIarePi9tbMUpc9b2QawhDDi16KjXyoRDplutupiyr4g+SDT9Gz3CgRbxy
	C2GLvpX+tG6kwcoULZFHWCMFloLdELJGKcEOLgBKiXNk0sxEBX/Sr3MZJuq+fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1692005737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNjgejAz/yJ5TpCvyso2wcCPwKOAf1wNRQTPDKcGTfA=;
	b=iJRYxRenhBP9/aTigZHWor0jgNnR7DX5DO9P42v/YTsZgWP0YT03Sv9qhpognsKrRV5IQt
	f89Dnk+P4h/17WDw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/2] softirq: Drop the warning from do_softirq_post_smp_call_flush().
Date: Mon, 14 Aug 2023 11:35:28 +0200
Message-Id: <20230814093528.117342-3-bigeasy@linutronix.de>
In-Reply-To: <20230814093528.117342-1-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Once ksoftirqd become active, all softirqs which were raised, would not
be processed immediately but delayed to ksoftirqd. On PREEMPT_RT this
means softirqs, which were raised in a threaded interrupt (at elevated
process priority), would not be served after the interrupt handler
completed its work but will wait until ksoftirqd (normal priority)
becomes running on the CPU. On a busy system with plenty of RT tasks
this could be delayed for quite some time and leads to problems in
general.

This is an undesired situation and it has been attempted to avoid the
situation in which ksoftirqd becomes scheduled. This changed since
commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its job"")
and now a threaded interrupt handler will handle soft interrupts at its
end even if ksoftirqd is pending. That means that they will be processed
in the context in which they were raised.

Unfortunately also all other soft interrupts which were raised (or
enqueued) earlier and are not yet handled. This happens if a thread with
higher priority is raised and has to catch up. This isn't a new problem
and the new high priority thread will PI-boost the current sofitrq owner
or start from scratch if ksoftirqd wasn't running yet.

Since pending ksoftirqd no longer blocks other interrupt threads from
handling soft interrupts I belive the warning can be disabled. The
pending softirq work has to be solved differently.

Remove the warning and update the comment.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/interrupt.h |  4 ++--
 kernel/smp.c              |  4 +---
 kernel/softirq.c          | 12 +++++-------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a92bce40b04b3..5143ae0ea9356 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -590,9 +590,9 @@ asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
=20
 #ifdef CONFIG_PREEMPT_RT
-extern void do_softirq_post_smp_call_flush(unsigned int was_pending);
+extern void do_softirq_post_smp_call_flush(void);
 #else
-static inline void do_softirq_post_smp_call_flush(unsigned int unused)
+static inline void do_softirq_post_smp_call_flush(void)
 {
 	do_softirq();
 }
diff --git a/kernel/smp.c b/kernel/smp.c
index 385179dae360e..cd7db5ffe95ab 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -554,7 +554,6 @@ static void __flush_smp_call_function_queue(bool warn_c=
pu_offline)
  */
 void flush_smp_call_function_queue(void)
 {
-	unsigned int was_pending;
 	unsigned long flags;
=20
 	if (llist_empty(this_cpu_ptr(&call_single_queue)))
@@ -562,10 +561,9 @@ void flush_smp_call_function_queue(void)
=20
 	local_irq_save(flags);
 	/* Get the already pending soft interrupts for RT enabled kernels */
-	was_pending =3D local_softirq_pending();
 	__flush_smp_call_function_queue(true);
 	if (local_softirq_pending())
-		do_softirq_post_smp_call_flush(was_pending);
+		do_softirq_post_smp_call_flush();
=20
 	local_irq_restore(flags);
 }
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 807b34ccd7973..aa299cb3ff47b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -281,15 +281,13 @@ static inline void invoke_softirq(void)
=20
 /*
  * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
- * investigated.
+ * call. On RT kernels this is undesired because the work is no longer pro=
cessed
+ * in the context where it originated. It is not especially harmfull but b=
est to
+ * be avoided.
  */
-void do_softirq_post_smp_call_flush(unsigned int was_pending)
+void do_softirq_post_smp_call_flush(void)
 {
-	if (WARN_ON_ONCE(was_pending !=3D local_softirq_pending()))
-		invoke_softirq();
+	invoke_softirq();
 }
=20
 #else /* CONFIG_PREEMPT_RT */
--=20
2.40.1


