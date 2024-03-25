Return-Path: <netdev+bounces-81526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15E88A7BD
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BCABC0177
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B313C9CF;
	Mon, 25 Mar 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3F5+xnfc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hS3X5PN0"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4212EBEF
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353016; cv=none; b=eOo84p4YdTqbSPK6NMz9WqW3nKUGGE5KP941it70hnKMcifMYARHUZgVcb4MyRx4gLFhVDOQ4nEO10POsyemrcFJxJA84dBgo/LcV9leafDnGwHH3LRoN4j+460+hnUps82c8N6NtFg3IEr81qy2fHUoRu/Cr7RWF10LGHByp1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353016; c=relaxed/simple;
	bh=H+OMb0XA08H/YSbwvkys2JoIvy8KEvYu/qnQklsVopI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMtTnMfl9kGhjg2kU8Fz/KRsyI9B8oIBGOYML0DSZoA6woDNxIvbKF+pf0DN2KkbPzk7kmYMAyLWR5eQjfIxoEckcG9d5GPyrLWVDnHwDhlZDblnqqcT8guim8EYp5vm15cFGZ9M4J7PgeFjsFThZzTb+0XhOAzFQWkca5SZVOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3F5+xnfc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hS3X5PN0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaRkIaNjAhUywQvxG327uReSY/y6ngEgThesEAu4FmE=;
	b=3F5+xnfc3hISmIE1X6KEorWJxdV6r5OnjklpH9HPTiqB/cNdq3QxHEca1tNevgfwdRTJIa
	rc8htwHuohHfaIIMyv1t0YBPWUc9ohC2K2HiwxSPlsLXt7zRbLLTkaQtJltgwI0FwxDkao
	RGt+C6JjfaKagBucP1bFPZYR/hkTNElBOfMxeh3+uJdkXB0+quSFYi67pX4f0VNyeBuk0G
	nhJmPAvX9bDzY1rXAt+0gwIAQ91ThYyvGCtI/YOvPWif9fSdyvWL+PAtg0Zq4lLMYUbjjv
	ReF4bXcELtd+5mjIo1Bht4zz/T8drI+s25o+n+r31DSl2ofXhCWjFBFZ/QkMYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaRkIaNjAhUywQvxG327uReSY/y6ngEgThesEAu4FmE=;
	b=hS3X5PN06wUVfz6ZTDZrp4Vnx+ases3+4nXfPQHYp0WYiMQWcBnzpKUeLGSM9ewvGL4u4R
	h5mzI48aIjaFgMCA==
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
Subject: [PATCH v6 net-next 2/4] net: Allow to use SMP threads for backlog NAPI.
Date: Mon, 25 Mar 2024 08:40:29 +0100
Message-ID: <20240325074943.289909-3-bigeasy@linutronix.de>
In-Reply-To: <20240325074943.289909-1-bigeasy@linutronix.de>
References: <20240325074943.289909-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
used by drivers which don't do NAPI them self, RPS and parts of the
stack which need to avoid recursive deadlocks while processing a packet.

The non-NAPI driver use the CPU local backlog NAPI. If RPS is enabled
then a flow for the skb is computed and based on the flow the skb can be
enqueued on a remote CPU. Scheduling/ raising the softirq (for backlog's
NAPI) on the remote CPU isn't trivial because the softirq is only
scheduled on the local CPU and performed after the hardirq is done.
In order to schedule a softirq on the remote CPU, an IPI is sent to the
remote CPU which schedules the backlog-NAPI on the then local CPU.

On PREEMPT_RT interrupts are force-threaded. The soft interrupts are
raised within the interrupt thread and processed after the interrupt
handler completed still within the context of the interrupt thread. The
softirq is handled in the context where it originated.

With force-threaded interrupts enabled, ksoftirqd is woken up if a
softirq is raised from hardirq context. This is the case if it is raised
from an IPI. Additionally there is a warning on PREEMPT_RT if the
softirq is raised from the idle thread.
This was done for two reasons:
- With threaded interrupts the processing should happen in thread
  context (where it originated) and ksoftirqd is the only thread for
  this context if raised from hardirq. Using the currently running task
  instead would "punish" a random task.
- Once ksoftirqd is active it consumes all further softirqs until it
  stops running. This changed recently and is no longer the case.

Instead of keeping the backlog NAPI in ksoftirqd (in force-threaded/
PREEMPT_RT setups) I am proposing NAPI-threads for backlog.
The "proper" setup with threaded-NAPI is not doable because the threads
are not pinned to an individual CPU and can be modified by the user.
Additionally a dummy network device would have to be assigned. Also
CPU-hotplug has to be considered if additional CPUs show up.
All this can be probably done/ solved but the smpboot-threads already
provide this infrastructure.

Sending UDP packets over loopback expects that the packet is processed
within the call. Delaying it by handing it over to the thread hurts
performance. It is not beneficial to the outcome if the context switch
happens immediately after enqueue or after a while to process a few
packets in a batch.
There is no need to always use the thread if the backlog NAPI is
requested on the local CPU. This restores the loopback throuput. The
performance drops mostly to the same value after enabling RPS on the
loopback comparing the IPI and the tread result.

Create NAPI-threads for backlog if request during boot. The thread runs
the inner loop from napi_threaded_poll(), the wait part is different. It
checks for NAPI_STATE_SCHED (the backlog NAPI can not be disabled).

The NAPI threads for backlog are optional, it has to be enabled via the boot
argument "thread_backlog_napi". It is mandatory for PREEMPT_RT to avoid the
wakeup of ksoftirqd from the IPI.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/core/dev.c | 158 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 118 insertions(+), 40 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 98d7d339a8c1f..ea574df496407 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/smpboot.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/string.h>
@@ -197,6 +198,31 @@ static inline struct hlist_head *dev_index_hash(struct=
 net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
=20
+#ifndef CONFIG_PREEMPT_RT
+
+static DEFINE_STATIC_KEY_FALSE(use_backlog_threads_key);
+
+static int __init setup_backlog_napi_threads(char *arg)
+{
+	static_branch_enable(&use_backlog_threads_key);
+	return 0;
+}
+early_param("thread_backlog_napi", setup_backlog_napi_threads);
+
+static bool use_backlog_threads(void)
+{
+	return static_branch_unlikely(&use_backlog_threads_key);
+}
+
+#else
+
+static bool use_backlog_threads(void)
+{
+	return true;
+}
+
+#endif
+
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
@@ -4404,6 +4430,7 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
=20
 unsigned int sysctl_skb_defer_max __read_mostly =3D 64;
 int weight_p __read_mostly =3D 64;           /* old backlog weight */
@@ -4427,12 +4454,16 @@ static inline void ____napi_schedule(struct softnet=
_data *sd,
 		 */
 		thread =3D READ_ONCE(napi->thread);
 		if (thread) {
+			if (use_backlog_threads() && thread =3D=3D raw_cpu_read(backlog_napi))
+				goto use_local_napi;
+
 			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
 	}
=20
+use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
 	/* If not called from net_rx_action()
@@ -4672,6 +4703,11 @@ static void napi_schedule_rps(struct softnet_data *s=
d)
=20
 #ifdef CONFIG_RPS
 	if (sd !=3D mysd) {
+		if (use_backlog_threads()) {
+			__napi_schedule_irqoff(&sd->backlog);
+			return;
+		}
+
 		sd->rps_ipi_next =3D mysd->rps_ipi_list;
 		mysd->rps_ipi_list =3D sd;
=20
@@ -5931,7 +5967,7 @@ static void net_rps_action_and_irq_enable(struct soft=
net_data *sd)
 #ifdef CONFIG_RPS
 	struct softnet_data *remsd =3D sd->rps_ipi_list;
=20
-	if (remsd) {
+	if (!use_backlog_threads() && remsd) {
 		sd->rps_ipi_list =3D NULL;
=20
 		local_irq_enable();
@@ -5946,7 +5982,7 @@ static void net_rps_action_and_irq_enable(struct soft=
net_data *sd)
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-	return sd->rps_ipi_list !=3D NULL;
+	return !use_backlog_threads() && sd->rps_ipi_list;
 #else
 	return false;
 #endif
@@ -5990,7 +6026,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state =3D 0;
+			napi->state &=3D NAPIF_STATE_THREADED;
 			again =3D false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
@@ -6726,43 +6762,48 @@ static int napi_thread_wait(struct napi_struct *nap=
i)
 	return -1;
 }
=20
+static void napi_threaded_poll_loop(struct napi_struct *napi)
+{
+	struct softnet_data *sd;
+	unsigned long last_qs =3D jiffies;
+
+	for (;;) {
+		bool repoll =3D false;
+		void *have;
+
+		local_bh_disable();
+		sd =3D this_cpu_ptr(&softnet_data);
+		sd->in_napi_threaded_poll =3D true;
+
+		have =3D netpoll_poll_lock(napi);
+		__napi_poll(napi, &repoll);
+		netpoll_poll_unlock(have);
+
+		sd->in_napi_threaded_poll =3D false;
+		barrier();
+
+		if (sd_has_rps_ipi_waiting(sd)) {
+			local_irq_disable();
+			net_rps_action_and_irq_enable(sd);
+		}
+		skb_defer_free_flush(sd);
+		local_bh_enable();
+
+		if (!repoll)
+			break;
+
+		rcu_softirq_qs_periodic(last_qs);
+		cond_resched();
+	}
+}
+
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi =3D data;
-	struct softnet_data *sd;
-	void *have;
=20
-	while (!napi_thread_wait(napi)) {
-		unsigned long last_qs =3D jiffies;
+	while (!napi_thread_wait(napi))
+		napi_threaded_poll_loop(napi);
=20
-		for (;;) {
-			bool repoll =3D false;
-
-			local_bh_disable();
-			sd =3D this_cpu_ptr(&softnet_data);
-			sd->in_napi_threaded_poll =3D true;
-
-			have =3D netpoll_poll_lock(napi);
-			__napi_poll(napi, &repoll);
-			netpoll_poll_unlock(have);
-
-			sd->in_napi_threaded_poll =3D false;
-			barrier();
-
-			if (sd_has_rps_ipi_waiting(sd)) {
-				local_irq_disable();
-				net_rps_action_and_irq_enable(sd);
-			}
-			skb_defer_free_flush(sd);
-			local_bh_enable();
-
-			if (!repoll)
-				break;
-
-			rcu_softirq_qs_periodic(last_qs);
-			cond_resched();
-		}
-	}
 	return 0;
 }
=20
@@ -11363,7 +11404,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
=20
 		list_del_init(&napi->poll_list);
 		if (napi->poll =3D=3D process_backlog)
-			napi->state =3D 0;
+			napi->state &=3D NAPIF_STATE_THREADED;
 		else
 			____napi_schedule(sd, napi);
 	}
@@ -11371,12 +11412,14 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
=20
+	if (!use_backlog_threads()) {
 #ifdef CONFIG_RPS
-	remsd =3D oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list =3D NULL;
+		remsd =3D oldsd->rps_ipi_list;
+		oldsd->rps_ipi_list =3D NULL;
 #endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
+		/* send out pending IPI's on offline CPU */
+		net_rps_send_ipi(remsd);
+	}
=20
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb =3D __skb_dequeue(&oldsd->process_queue))) {
@@ -11715,6 +11758,38 @@ static int net_page_pool_create(int cpuid)
 	return 0;
 }
=20
+static int backlog_napi_should_run(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi =3D &sd->backlog;
+
+	return test_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+}
+
+static void run_backlog_napi(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+
+	napi_threaded_poll_loop(&sd->backlog);
+}
+
+static void backlog_napi_setup(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi =3D &sd->backlog;
+
+	napi->thread =3D this_cpu_read(backlog_napi);
+	set_bit(NAPI_STATE_THREADED, &napi->state);
+}
+
+static struct smp_hotplug_thread backlog_threads =3D {
+	.store			=3D &backlog_napi,
+	.thread_should_run	=3D backlog_napi_should_run,
+	.thread_fn		=3D run_backlog_napi,
+	.thread_comm		=3D "backlog_napi/%u",
+	.setup			=3D backlog_napi_setup,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11766,10 +11841,13 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll =3D process_backlog;
 		sd->backlog.weight =3D weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
=20
 		if (net_page_pool_create(i))
 			goto out;
 	}
+	if (use_backlog_threads())
+		smpboot_register_percpu_thread(&backlog_threads);
=20
 	dev_boot_phase =3D 0;
=20
--=20
2.43.0


