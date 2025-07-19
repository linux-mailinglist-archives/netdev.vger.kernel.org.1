Return-Path: <netdev+bounces-208272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3CCB0AC88
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 01:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A221C45E4D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7C122F76C;
	Fri, 18 Jul 2025 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h66qh7hG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B122A4F6
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880862; cv=none; b=D7u/lN2QJ6A+SwRo5u/fyZX3JVYzToxp9XaBCz7WH/ox2qLQ4P1I/ZVa/BlOodoUjiYdCsxGsEqrqsiNN3hm8zbjVMbYui1pg9ta05QY4HEl8Mmlm9bFJK8pwrtt5h/ME70mrlm5ins7p2NjMTL+gyUZa9ODxqlrdW5aRxZn7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880862; c=relaxed/simple;
	bh=qu9H+ZPCFaI5OpZZSS+Be4QnIpbn+U/0YfACuEgoVtA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XCzAXoz0OnSbdyOYQK21QGJDL8o3ylDkLfs6Pr+NjqYimYwiaP11UfNzslBeQoiL3mF6vBrsy7BCvNiaffrfdR+F0YANAm1xtwe+hGTlkzOAFkUmv8PiV/5cnTJzq2srva0ndWyceTUhqh0sye+hjI8I1cVGplMk5FnQfj/Rjn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h66qh7hG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74b537e8d05so2423646b3a.3
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752880859; x=1753485659; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb6M3Y4YAELTHGRb8ThoQ695ahfGuzV8R5ri8MOnZCY=;
        b=h66qh7hGwcZ+Yped6mxNAACG9UTK70ekzLKcf0V55xF+TAYzC7Z+pir2R5V7eVoHUT
         O4S2O8RZG6Bv7SeuKD9UQhdRphtHwj1GMGU2uFqzyozrscvwLkx17mnSkgI8Lx17ulfV
         ErDSgNneBsUGFvHFdc8uMxYjRYO/Uj8mB7Efub6Nbe7ZwCmG1bpXcUoevhwzWBpjQ52F
         t4ehJ/ZwFdnIfG/PCln94rVy+THcCWv5yUBc6iYWX+2LwlwdBKAb8J1j/Q/yHfqg3Ppc
         wz3hp15U0HqIUins10yNw65L12SYXlyfC+R2GCu1G4EbDBZwZNmaRb5Stl8AypvlfBoD
         dzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752880859; x=1753485659;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb6M3Y4YAELTHGRb8ThoQ695ahfGuzV8R5ri8MOnZCY=;
        b=SNWK8OqHJRdY2Ul6kUqJZDiRNedfF/dIAnapnwrb6hGnhJ6qA/ws2nOLU7u2HTwCQj
         R4uQtp0W3OWxNbdIphUtdPtHmjHk4FjT8JBAXB2QT5/ILgcjivgEsLsOXQJ6wr3IDUvy
         rXbV5SAvaLt7QIHTE1absHAKx2PJTdMvQnkjgjWDfsxtauCMca0/WzbqHc6N7qvzLKHx
         /tBvaAtPpstwduRC65d8V+jT9l6rYNYCDN0D73Oj0lAlYzU6zsCkBlm+i0rhQkfODlix
         iBaE84+23QTjP75M70Z+OaFvjDN8NlXnAjZ+KjFiU4wrnyPURpx7L8MesPoYmewfoC5M
         pyCw==
X-Gm-Message-State: AOJu0YxN6KfbZ+KXeFGzrMYfoeAmtDRzpO/HOl84KK3I3StGmoMmCAaL
	f1rXXWlvmFAMglfIfVG5r3nrEOMBUvGonJThVkP55Qfj+Q6eKbWOUxzoayUEf7VFR28p3Jyb0tJ
	jgvZllGGrDPH8GA==
X-Google-Smtp-Source: AGHT+IGG6I3AyqAK2munMhqaVI5vC6RUfpr43T9LNulwTErsTM7/nL9rf+q6VjPZ+ygdPESR51LKUxM6GdKkfg==
X-Received: from pfblo8.prod.google.com ([2002:a05:6a00:3d08:b0:746:21fd:3f7a])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:22d0:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-756ea1dd768mr18206002b3a.12.1752880859326;
 Fri, 18 Jul 2025 16:20:59 -0700 (PDT)
Date: Fri, 18 Jul 2025 23:20:50 +0000
In-Reply-To: <20250718232052.1266188-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718232052.1266188-1-skhawaja@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250718232052.1266188-5-skhawaja@google.com>
Subject: [PATCH net-next v6 4/5] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state to napi state enum:

- NAPI_STATE_THREADED_BUSY_POLL
  Threaded busy poll is enabled/running for this napi.

Following changes are introduced in the napi scheduling and state logic:

- When threaded busy poll is enabled through sysfs or netlink it also
  enables NAPI_STATE_THREADED so a kthread is created per napi. It also
  sets NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that
  it is going to busy poll the napi.

- When napi is scheduled with NAPI_STATE_SCHED_THREADED and associated
  kthread is woken up, the kthread owns the context. If
  NAPI_STATE_THREADED_BUSY_POLL and NAPI_STATE_SCHED_THREADED both are
  set then it means that kthread can busy poll.

- To keep busy polling and to avoid scheduling of the interrupts, the
  napi_complete_done returns false when both NAPI_STATE_SCHED_THREADED
  and NAPI_STATE_THREADED_BUSY_POLL flags are set. Also
  napi_complete_done returns early to avoid the
  NAPI_STATE_SCHED_THREADED being unset.

- If at any point NAPI_STATE_THREADED_BUSY_POLL is unset, the
  napi_complete_done will run and unset the NAPI_STATE_SCHED_THREADED
  bit also. This will make the associated kthread go to sleep as per
  existing logic.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>

---
 Documentation/ABI/testing/sysfs-class-net |  3 +-
 Documentation/netlink/specs/netdev.yaml   |  5 +-
 Documentation/networking/napi.rst         | 63 +++++++++++++++++++-
 include/linux/netdevice.h                 | 11 +++-
 include/uapi/linux/netdev.h               |  1 +
 net/core/dev.c                            | 71 +++++++++++++++++++----
 net/core/dev.h                            |  3 +
 net/core/net-sysfs.c                      |  2 +-
 net/core/netdev-genl-gen.c                |  2 +-
 tools/include/uapi/linux/netdev.h         |  1 +
 10 files changed, 145 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..15d7d36a8294 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -343,7 +343,7 @@ Date:		Jan 2021
 KernelVersion:	5.12
 Contact:	netdev@vger.kernel.org
 Description:
-		Boolean value to control the threaded mode per device. User could
+		Integer value to control the threaded mode per device. User could
 		set this value to enable/disable threaded mode for all napi
 		belonging to this device, without the need to do device up/down.
 
@@ -351,4 +351,5 @@ Description:
 		== ==================================
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
+		2  threaded mode enabled, and busy polling enabled.
 		== ==================================
diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 11edbf9c5727..70a4a9c8afef 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -88,7 +88,7 @@ definitions:
   -
     name: napi-threaded
     type: enum
-    entries: [ disabled, enabled ]
+    entries: [ disabled, enabled, busy-poll-enabled ]
 
 attribute-sets:
   -
@@ -291,7 +291,8 @@ attribute-sets:
         name: threaded
         doc: Whether the NAPI is configured to operate in threaded polling
              mode. If this is set to `enabled` then the NAPI context operates
-             in threaded polling mode.
+             in threaded polling mode. If this is set to `busy-poll-enabled`
+             then the NAPI kthread also does busypolling.
         type: u32
         enum: napi-threaded
   -
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index a15754adb041..a1e76341a99a 100644
--- a/Documentation/networking/napi.rst
+++ b/Documentation/networking/napi.rst
@@ -263,7 +263,9 @@ are not well known).
 Busy polling is enabled by either setting ``SO_BUSY_POLL`` on
 selected sockets or using the global ``net.core.busy_poll`` and
 ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
-also exists.
+also exists. Threaded polling of NAPI also has a mode to busy poll for
+packets (:ref:`threaded busy polling<threaded_busy_poll>`) using the same
+thread that is used for NAPI processing.
 
 epoll-based busy polling
 ------------------------
@@ -426,6 +428,65 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
 the recommended usage, because otherwise setting ``irq-suspend-timeout``
 might not have any discernible effect.
 
+.. _threaded_busy_poll:
+
+Threaded NAPI busy polling
+--------------------------
+
+Threaded NAPI allows processing of packets from each NAPI in a kthread in
+kernel. Threaded NAPI busy polling extends this and adds support to do
+continuous busy polling of this NAPI. This can be used to enable busy polling
+independent of userspace application or the API (epoll, io_uring, raw sockets)
+being used in userspace to process the packets.
+
+It can be enabled for each NAPI using netlink interface or at device level using
+the threaded NAPI sysctl.
+
+For example, using following script:
+
+.. code-block:: bash
+
+  $ ynl --family netdev --do napi-set \
+            --json='{"id": 66, "threaded": "busy-poll-enabled"}'
+
+
+Enabling it for each NAPI allows finer control to enable busy pollling for
+only a set of NIC queues which will get traffic with low latency requirements.
+
+Depending on application requirement, user might want to set affinity of the
+kthread that is busy polling each NAPI. User might also want to set priority
+and the scheduler of the thread depending on the latency requirements.
+
+For a hard low-latency application, user might want to dedicate the full core
+for the NAPI polling so the NIC queue descriptors are picked up from the queue
+as soon as they appear. Once enabled, the NAPI thread will poll the NIC queues
+continuously without sleeping. This will keep the CPU core busy with 100%
+usage.  For more relaxed low-latency requirement, user might want to share the
+core with other threads by setting thread affinity and priority.
+
+Once threaded busy polling is enabled for a NAPI, PID of the kthread can be
+fetched using netlink interface so the affinity, priority and scheduler
+configuration can be done.
+
+For example, following script can be used to fetch the pid:
+
+.. code-block:: bash
+
+  $ ynl --family netdev --do napi-get --json='{"id": 66}'
+
+This will output something like following, the pid `258` is the PID of the
+kthread that is polling this NAPI.
+
+.. code-block:: bash
+
+  $ {'defer-hard-irqs': 0,
+     'gro-flush-timeout': 0,
+     'id': 66,
+     'ifindex': 2,
+     'irq-suspend-timeout': 0,
+     'pid': 258,
+     'threaded': 'enable'}
+
 .. _threaded:
 
 Threaded NAPI
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 97cf14a9b469..6682b975febd 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -427,6 +427,8 @@ enum {
 	NAPI_STATE_THREADED,		/* The poll is performed inside its own thread*/
 	NAPI_STATE_SCHED_THREADED,	/* Napi is currently scheduled in threaded mode */
 	NAPI_STATE_HAS_NOTIFIER,	/* Napi has an IRQ notifier */
+	NAPI_STATE_THREADED_BUSY_POLL,	/* The threaded napi poller will busy poll */
+	NAPI_STATE_SCHED_THREADED_BUSY_POLL,  /* The threaded napi poller is busy polling */
 };
 
 enum {
@@ -441,8 +443,14 @@ enum {
 	NAPIF_STATE_THREADED		= BIT(NAPI_STATE_THREADED),
 	NAPIF_STATE_SCHED_THREADED	= BIT(NAPI_STATE_SCHED_THREADED),
 	NAPIF_STATE_HAS_NOTIFIER	= BIT(NAPI_STATE_HAS_NOTIFIER),
+	NAPIF_STATE_THREADED_BUSY_POLL	= BIT(NAPI_STATE_THREADED_BUSY_POLL),
+	NAPIF_STATE_SCHED_THREADED_BUSY_POLL  =
+			BIT(NAPI_STATE_SCHED_THREADED_BUSY_POLL),
 };
 
+#define NAPIF_STATE_THREADED_BUSY_POLL_MASK \
+	(NAPIF_STATE_THREADED | NAPIF_STATE_THREADED_BUSY_POLL)
+
 enum gro_result {
 	GRO_MERGED,
 	GRO_MERGED_FREE,
@@ -1871,7 +1879,8 @@ enum netdev_reg_state {
  * 	@addr_len:		Hardware address length
  *	@upper_level:		Maximum depth level of upper devices.
  *	@lower_level:		Maximum depth level of lower devices.
- *	@threaded:		napi threaded state.
+ *	@threaded:		napi threaded mode is disabled, enabled or
+ *				enabled with busy polling.
  *	@neigh_priv_len:	Used in neigh_alloc()
  * 	@dev_id:		Used to differentiate devices that share
  * 				the same link layer address
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 48eb49aa03d4..8163afb15377 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLED,
 	NETDEV_NAPI_THREADED_ENABLED,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED,
 };
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index ec65b03492b1..9511c69dc8e8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/types.h>
 #include <linux/sched/mm.h>
 #include <linux/smpboot.h>
 #include <linux/mutex.h>
@@ -6554,7 +6555,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6959,6 +6961,19 @@ static void napi_stop_kthread(struct napi_struct *napi)
 	napi->thread = NULL;
 }
 
+static void napi_set_threaded_state(struct napi_struct *napi,
+				    enum netdev_napi_threaded threaded)
+{
+	unsigned long val;
+
+	val = 0;
+	if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED)
+		val |= NAPIF_STATE_THREADED_BUSY_POLL;
+	if (threaded)
+		val |= NAPIF_STATE_THREADED;
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
+}
+
 int napi_set_threaded(struct napi_struct *napi,
 		      enum netdev_napi_threaded threaded)
 {
@@ -6979,7 +6994,7 @@ int napi_set_threaded(struct napi_struct *napi,
 	} else {
 		/* Make sure kthread is created before THREADED bit is set. */
 		smp_mb__before_atomic();
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		napi_set_threaded_state(napi, threaded);
 	}
 
 	return 0;
@@ -7017,12 +7032,15 @@ int dev_set_threaded(struct net_device *dev,
 	 * polled. In this case, the switch between threaded mode and
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
+	 *
+	 * Switch to busy_poll threaded napi will occur after the threaded
+	 * napi is scheduled.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list) {
 		if (!threaded && napi->thread)
 			napi_stop_kthread(napi);
 		else
-			assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+			napi_set_threaded_state(napi, threaded);
 	}
 
 	return err;
@@ -7369,7 +7387,9 @@ void napi_disable_locked(struct napi_struct *n)
 		}
 
 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
-		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
+		new &= ~(NAPIF_STATE_THREADED
+			 | NAPIF_STATE_THREADED_BUSY_POLL
+			 | NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
 	hrtimer_cancel(&n->timer);
@@ -7413,7 +7433,7 @@ void napi_enable_locked(struct napi_struct *n)
 
 		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
 		if (n->dev->threaded && n->thread)
-			new |= NAPIF_STATE_THREADED;
+			napi_set_threaded_state(n, n->dev->threaded);
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
 EXPORT_SYMBOL(napi_enable_locked);
@@ -7581,7 +7601,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7610,22 +7630,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		}
 		skb_defer_free_flush(sd);
 		bpf_net_ctx_clear(bpf_net_ctx);
+
+		/* Flush too old packets. If HZ < 1000, flush all packets */
+		if (busy_poll)
+			gro_flush_normal(&napi->gro, HZ >= 1000);
 		local_bh_enable();
 
-		if (!repoll)
+		/* If busy polling then do not break here because we need to
+		 * call cond_resched and rcu_softirq_qs_periodic to prevent
+		 * watchdog warnings.
+		 */
+		if (!repoll && !busy_poll)
 			break;
 
 		rcu_softirq_qs_periodic(last_qs);
 		cond_resched();
+
+		if (!repoll)
+			break;
 	}
 }
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	bool busy_poll_sched;
+	unsigned long val;
+	bool busy_poll;
+
+	while (!napi_thread_wait(napi)) {
+		/* Once woken up, this means that we are scheduled as threaded
+		 * napi and this thread owns the napi context, if busy poll
+		 * state is set then busy poll this napi.
+		 */
+		val = READ_ONCE(napi->state);
+		busy_poll = val & NAPIF_STATE_THREADED_BUSY_POLL;
+		busy_poll_sched = val & NAPIF_STATE_SCHED_THREADED_BUSY_POLL;
 
-	while (!napi_thread_wait(napi))
-		napi_threaded_poll_loop(napi);
+		/* Do not busy poll if napi is disabled. */
+		if (unlikely(val & NAPIF_STATE_DISABLE))
+			busy_poll = false;
+
+		if (busy_poll != busy_poll_sched)
+			assign_bit(NAPI_STATE_SCHED_THREADED_BUSY_POLL,
+				   &napi->state, busy_poll);
+
+		napi_threaded_poll_loop(napi, busy_poll);
+	}
 
 	return 0;
 }
@@ -12808,7 +12859,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/dev.h b/net/core/dev.h
index ab6fac65ec24..082270ed5b92 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -317,6 +317,9 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
 
 static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 {
+	if (test_bit(NAPI_STATE_THREADED_BUSY_POLL, &n->state))
+		return NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED;
+
 	if (test_bit(NAPI_STATE_THREADED, &n->state))
 		return NETDEV_NAPI_THREADED_ENABLED;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8f897e2c8b4f..3ebf8153666b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -754,7 +754,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (list_empty(&dev->napi_list))
 		return -EOPNOTSUPP;
 
-	if (val != 0 && val != 1)
+	if (val > NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED)
 		return -EOPNOTSUPP;
 
 	ret = dev_set_threaded(dev, val);
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index e9a2a6f26cb7..ff20435c45d2 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
 };
 
 /* NETDEV_CMD_BIND_TX - do */
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 48eb49aa03d4..8163afb15377 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLED,
 	NETDEV_NAPI_THREADED_ENABLED,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLED,
 };
 
 enum {
-- 
2.50.0.727.gbf7dc18ff4-goog


