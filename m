Return-Path: <netdev+bounces-42368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E557CE7D8
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 21:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D656A1C2092E
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4768436BA;
	Wed, 18 Oct 2023 19:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="fgO4UUDZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517423FE49
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 19:37:17 +0000 (UTC)
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4911D
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:37:15 -0700 (PDT)
Received: from smtp.gmail.com (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 7892F41667;
	Wed, 18 Oct 2023 19:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1697657832;
	bh=x1vuTobz6AdxAjlPU1eH9Ke51tMpmFPrUXI+1Z0eGFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=fgO4UUDZ1wCniPzrgoPdrUTck7b+gmT09MtuQwa1bV2bj8GZpk04sUNsNKqz9W3jf
	 OLoFkCpHAMc7nlk1kgKxO7l5EfZSsVVzBh+ySEbELVAfXm5Hg0hrGLJ/6kN/icNs6W
	 BG73X/Ua/DBqiHgoEsTnRvB6FhCaJcyMPfeqACjS8vOCITIdSOJ1m7aqq/q1TaG3vE
	 J1Dw2DaFfN0DDpLXeGmZ8Zv6+3KNrbaxReOc7gzbma8DhOIZpONpbm1qLB12cD142u
	 6W69HCl0dp8iqw9PX3QSah3ORPbyvK3auR8p3jzXvpvkQ1jbugtMM9Vtl+h56fK41w
	 XUQuaoTNXFBhQ==
From: Joseph Salisbury <joseph.salisbury@canonical.com>
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org
Subject: [PATCH RT 03/12] Revert "softirq: Let ksoftirqd do its job"
Date: Wed, 18 Oct 2023 15:36:58 -0400
Message-Id: <20231018193707.650413-4-joseph.salisbury@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018193707.650413-1-joseph.salisbury@canonical.com>
References: <20231018193707.650413-1-joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

v5.15.133-rt70-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This reverts the following commits:

  4cd13c21b207 ("softirq: Let ksoftirqd do its job")
  3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")
  1342d8080f61 ("softirq: Don't skip softirq execution when softirq thread is parking")

in a single change to avoid known bad intermediate states introduced by a
patch series reverting them individually.

Due to the mentioned commit, when the ksoftirqd threads take charge of
softirq processing, the system can experience high latencies.

In the past a few workarounds have been implemented for specific
side-effects of the initial ksoftirqd enforcement commit:

commit 1ff688209e2e ("watchdog: core: make sure the watchdog_worker is not deferred")
commit 8d5755b3f77b ("watchdog: softdog: fire watchdog even if softirqs do not get to run")
commit 217f69743681 ("net: busy-poll: allow preemption in sk_busy_loop()")
commit 3c53776e29f8 ("Mark HI and TASKLET softirq synchronous")

But the latency problem still exists in real-life workloads, see the link
below.

The reverted commit intended to solve a live-lock scenario that can now be
addressed with the NAPI threaded mode, introduced with commit 29863d41bb6e
("net: implement threaded-able napi poll loop support"), which is nowadays
in a pretty stable status.

While a complete solution to put softirq processing under nice resource
control would be preferable, that has proven to be a very hard task. In
the short term, remove the main pain point, and also simplify a bit the
current softirq implementation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: netdev@vger.kernel.org
Link: https://lore.kernel.org/netdev/305d7742212cbe98621b16be782b0562f1012cb6.camel@redhat.com
Link: https://lore.kernel.org/r/57e66b364f1b6f09c9bc0316742c3b14f4ce83bd.1683526542.git.pabeni@redhat.com
(cherry picked from commit d15121be7485655129101f3960ae6add40204463)
Signed-off-by: Joseph Salisbury <joseph.salisbury@canonical.com>
---
 kernel/softirq.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..398951403331 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -80,21 +80,6 @@ static void wakeup_softirqd(void)
 		wake_up_process(tsk);
 }
 
-/*
- * If ksoftirqd is scheduled, we do not want to process pending softirqs
- * right now. Let ksoftirqd handle this at its own rate, to get fairness,
- * unless we're doing some of the synchronous softirqs.
- */
-#define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
-static bool ksoftirqd_running(unsigned long pending)
-{
-	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
-
-	if (pending & SOFTIRQ_NOW_MASK)
-		return false;
-	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
-}
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 DEFINE_PER_CPU(int, hardirqs_enabled);
 DEFINE_PER_CPU(int, hardirq_context);
@@ -236,7 +221,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 		goto out;
 
 	pending = local_softirq_pending();
-	if (!pending || ksoftirqd_running(pending))
+	if (!pending)
 		goto out;
 
 	/*
@@ -419,9 +404,6 @@ static inline bool should_wake_ksoftirqd(void)
 
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
@@ -455,7 +437,7 @@ asmlinkage __visible void do_softirq(void)
 
 	pending = local_softirq_pending();
 
-	if (pending && !ksoftirqd_running(pending))
+	if (pending)
 		do_softirq_own_stack();
 
 	local_irq_restore(flags);
-- 
2.34.1


