Return-Path: <netdev+bounces-118933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A49538D8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0032282B81
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633EC1AED40;
	Thu, 15 Aug 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dsNzd8Zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C704433D2
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742191; cv=none; b=Jc0La1MQzHxNNHbGDcYliijHPCsRtcNEC0uCDynbBGvRZgfgZA5YLhIytMrofgObAQt1r9RtNocHhJhsxw4MgajuE4OzocW7Fuo64gqrF1gU2Ma6JdG2BQB9Xv7vQy/3VMU5dVpk8AHkHGP7W00qT+3Xjb+Q8HkwCAf0Fva2FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742191; c=relaxed/simple;
	bh=k5dMxvBsJqPG4G9LYK9Rqnn1dqj8P9AslLFtm8/Gjas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mhka+OAJs2zgthhdc6eG109QxiQqTHh+LGkS0+/Mc0wHrMZTueE5c4kudtaOr1lmMYZCtQ2yJF/wbvxjCzMkn8lMTFLCw6Kg6j4K0az/j0LXbo7EsZVP72U1RbxZFfmYfht3exE88uRuDSRy7tcDxxi0JylW0myq5vQQvsQCITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dsNzd8Zh; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-5d5b1e33fa8so685099eaf.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723742188; x=1724346988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67yMj8RlaENtZP7Fw8m6M/QUtckiPgfoHu45IPFjaBY=;
        b=dsNzd8Zhuy9DjFmlPq5uEVkngYdC56jNHzWZFKH+iLEckgoEUkc9P5+fRelHycvayR
         kCmhHPWsOcy0u8kFY2k8VrU/QTw2+lajUBZAzjUojN4hqrDNoL1UdLi20aP03P9+GRkr
         146XravpbcDrZHujzPlWvDlPCJS6gpoYFmKMud7lQ5jdU4y/ymILPtzSwg78cNX/3Flv
         k2DFFQolVx5QZoRgT8eqttKjN8OQUkuWp0TO0LCZIJ0X26FdWGQP2TvIJHbQ/XIy9Wyq
         MBj3U5uJy/e1GRnH6cc9j0zVUWGC69ql3/NtzmhEokmusImjnm07jBn94YmvTAZ+PxwG
         kPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742188; x=1724346988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67yMj8RlaENtZP7Fw8m6M/QUtckiPgfoHu45IPFjaBY=;
        b=F3gfQiNxl7LPfho6MzKPjrDXo3Vit5cRLnaELgDBV97pxB9jAhGKmAeFs7dOIRMEQs
         yLxbyp/1kO4wVIfnhkFmp9xSNZmbvCs+uw16hzpPgYtSZpl0JY2arruIqH4t6EtZpyye
         7TKUjuHfSMJnzLcqZwoVY8y6QKnUSU/RN1GNopNatMN8kV5bRV6gvnfCTCZALNP5VQyf
         YdLAf+GldTuDho/3eeFlebNtym+IjHNtFLdf2Bn8HMbhFDSEXVeVxPnUfANrywxCOYV/
         VJxeC1YTCZX/272tOMtW+42klHjpOSHsjmrp1q023KYtl1qJH5w4PX3Gb65r1egOS7Bk
         FHyA==
X-Forwarded-Encrypted: i=1; AJvYcCWPelL7FhH7WDKsaMp3Aa8jm6UtaK1jYZgtzFozSoFLpgucGEViM+EOjJKdnbxIAdEkahh+mJpPTWua3sn/Y8CV2pf6gdrw
X-Gm-Message-State: AOJu0YzzIAVaaDhUFMYJBNi36KCSS1u6OEGrDPTaYOOaPF+WWYyjiDAP
	PAVlorRymFoivvZyc6Kl1faPU7xxtBMAblwdJr2qE/6QPfoFjlz3LhtAEWncBrXv4yplgo1NVgW
	+3QfsygEEtPkQxocl0C0Rzf/zFWfwP9VewY1OnwdGxREJQoW2
X-Google-Smtp-Source: AGHT+IG4/ArjPRbFUZ+IaIIp8lxbnAVXoGor4lZ3Q8IYFRp0TgKb/c7eabDoVNZ3+kKxqhq/lUSQ5hfY1B6x
X-Received: by 2002:a05:6820:1b91:b0:5c6:5f2d:8430 with SMTP id 006d021491bc7-5da97f21105mr628958eaf.2.1723742188275;
        Thu, 15 Aug 2024 10:16:28 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-5da8cd95678sm137163eaf.11.2024.08.15.10.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:16:28 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 54AA434028F;
	Thu, 15 Aug 2024 11:16:27 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4F3D6E42CC1; Thu, 15 Aug 2024 11:16:27 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] softirq: remove parameter from action callback
Date: Thu, 15 Aug 2024 11:15:40 -0600
Message-ID: <20240815171549.3260003-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
References: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When softirq actions are called, they are passed a pointer to the entry
in the softirq_vec table containing the action's function pointer. This
pointer isn't very useful, as the action callback already knows what
function it is. And since each callback handles a specific softirq, the
callback also knows which softirq number is running.

No softirq action callbacks actually use this parameter, so remove it
from the function pointer signature. This clarifies that softirq actions
are global routines and makes it slightly cheaper to call them.

v2: use full 72 characters in commit description lines, add Reviewed-by

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c            |  2 +-
 include/linux/interrupt.h |  4 ++--
 kernel/rcu/tiny.c         |  2 +-
 kernel/rcu/tree.c         |  2 +-
 kernel/sched/fair.c       |  2 +-
 kernel/softirq.c          | 15 +++++++--------
 kernel/time/hrtimer.c     |  2 +-
 kernel/time/timer.c       |  2 +-
 lib/irq_poll.c            |  2 +-
 net/core/dev.c            |  4 ++--
 10 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..aa28157b1aaf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1126,11 +1126,11 @@ static void blk_complete_reqs(struct llist_head *list)
 
 	llist_for_each_entry_safe(rq, next, entry, ipi_list)
 		rq->q->mq_ops->complete(rq);
 }
 
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static __latent_entropy void blk_done_softirq(void)
 {
 	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
 
 static int blk_softirq_cpu_dead(unsigned int cpu)
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3f30c88e0b4c..694de61e0b38 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -592,11 +592,11 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
  * asm/hardirq.h to get better cache usage.  KAO
  */
 
 struct softirq_action
 {
-	void	(*action)(struct softirq_action *);
+	void	(*action)(void);
 };
 
 asmlinkage void do_softirq(void);
 asmlinkage void __do_softirq(void);
 
@@ -607,11 +607,11 @@ static inline void do_softirq_post_smp_call_flush(unsigned int unused)
 {
 	do_softirq();
 }
 #endif
 
-extern void open_softirq(int nr, void (*action)(struct softirq_action *));
+extern void open_softirq(int nr, void (*action)(void));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4402d6f5f857..b3b3ce34df63 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -103,11 +103,11 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_release(&rcu_callback_map);
 	return false;
 }
 
 /* Invoke the RCU callbacks whose grace period has elapsed.  */
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
+static __latent_entropy void rcu_process_callbacks(void)
 {
 	struct rcu_head *next, *list;
 	unsigned long flags;
 
 	/* Move the ready-to-invoke callbacks to a local list. */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..93bd665637c0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2853,11 +2853,11 @@ static __latent_entropy void rcu_core(void)
 	// If strict GPs, schedule an RCU reader in a clean environment.
 	if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD))
 		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
 
-static void rcu_core_si(struct softirq_action *h)
+static void rcu_core_si(void)
 {
 	rcu_core();
 }
 
 static void rcu_wake_cond(struct task_struct *t, int status)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..8dc9385f6da4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12481,11 +12481,11 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
  * - directly from the local scheduler_tick() for periodic load balancing
  *
  * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
-static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(void)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
 	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 02582017759a..d082e7840f88 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -549,11 +549,11 @@ static void handle_softirqs(bool ksirqd)
 		prev_count = preempt_count();
 
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
 		trace_softirq_entry(vec_nr);
-		h->action(h);
+		h->action();
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count != preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
 			       vec_nr, softirq_to_name[vec_nr], h->action,
 			       prev_count, preempt_count());
@@ -698,11 +698,11 @@ void __raise_softirq_irqoff(unsigned int nr)
 	lockdep_assert_irqs_disabled();
 	trace_softirq_raise(nr);
 	or_softirq_pending(1UL << nr);
 }
 
-void open_softirq(int nr, void (*action)(struct softirq_action *))
+void open_softirq(int nr, void (*action)(void))
 {
 	softirq_vec[nr].action = action;
 }
 
 /*
@@ -758,12 +758,11 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 		  t->use_callback ? (void *)t->callback : (void *)t->func);
 
 	return false;
 }
 
-static void tasklet_action_common(struct softirq_action *a,
-				  struct tasklet_head *tl_head,
+static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
 
 	local_irq_disable();
@@ -803,20 +802,20 @@ static void tasklet_action_common(struct softirq_action *a,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
 }
 
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static __latent_entropy void tasklet_action(void)
 {
 	workqueue_softirq_action(false);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
 }
 
-static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+static __latent_entropy void tasklet_hi_action(void)
 {
 	workqueue_softirq_action(true);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
 void tasklet_setup(struct tasklet_struct *t,
 		   void (*callback)(struct tasklet_struct *))
 {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320208d4..836157e09e25 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1755,11 +1755,11 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 				hrtimer_sync_wait_running(cpu_base, flags);
 		}
 	}
 }
 
-static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
+static __latent_entropy void hrtimer_run_softirq(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	unsigned long flags;
 	ktime_t now;
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a0aa0f..760bbeb1f331 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2438,11 +2438,11 @@ static void run_timer_base(int index)
 }
 
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
-static __latent_entropy void run_timer_softirq(struct softirq_action *h)
+static __latent_entropy void run_timer_softirq(void)
 {
 	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
 		run_timer_base(BASE_GLOBAL);
 		run_timer_base(BASE_DEF);
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2d5329a42105..08b242bbdbdf 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -73,11 +73,11 @@ void irq_poll_complete(struct irq_poll *iop)
 	__irq_poll_complete(iop);
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL(irq_poll_complete);
 
-static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
+static void __latent_entropy irq_poll_softirq(void)
 {
 	struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
 	int rearm = 0, budget = irq_poll_budget;
 	unsigned long start_time = jiffies;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 751d9b70e6ad..3ac02b0ca29e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5246,11 +5246,11 @@ int netif_rx(struct sk_buff *skb)
 		local_bh_enable();
 	return ret;
 }
 EXPORT_SYMBOL(netif_rx);
 
-static __latent_entropy void net_tx_action(struct softirq_action *h)
+static __latent_entropy void net_tx_action(void)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 
 	if (sd->completion_queue) {
 		struct sk_buff *clist;
@@ -6919,11 +6919,11 @@ static int napi_threaded_poll(void *data)
 		napi_threaded_poll_loop(napi);
 
 	return 0;
 }
 
-static __latent_entropy void net_rx_action(struct softirq_action *h)
+static __latent_entropy void net_rx_action(void)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-- 
2.45.2


