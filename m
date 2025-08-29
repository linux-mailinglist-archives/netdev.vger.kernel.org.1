Return-Path: <netdev+bounces-218069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F07B3B050
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 03:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C447C4354
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 01:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63351DED77;
	Fri, 29 Aug 2025 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rRJB3Dql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490613EFF3
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756430172; cv=none; b=dDNEAFXh0tCnwQoC0nQYXy5NJ19QfyTuvtfdkhOl2z8tWwQMs1mIdys0CMYxR7ycul+Pp8fAmpaXXfXPNTqhGtukeN2ppQs9q9YASlTL6M2vA8bD4T8ZvfHATaXGRvGB/d6PL8RjLylZfViYXcV2E1ecPEInHjrmhe87njAR3jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756430172; c=relaxed/simple;
	bh=ZBuiThPov7tpGRs9EsN2a/tjJiCF3skRKCUjuHD5Diw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2AjddcfqWpKdX3nJgq80wD53XhG9FJRmq2R0OQBjQ17gugB0C+QBd2pTGtry5UGDXnDI0JERCwr31is23LxpA0eBr/Cl8wWEc/LmVMT7yljFvidE9XXdFk6lOcgsQjbpE+MCBe4R/eSyrodLrzSds82+qOJnbsScT0Ho/Chkug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rRJB3Dql; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-771ff6f1020so2936609b3a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756430170; x=1757034970; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LhX8zTKpfIyWjy9VbI0192ydyYGCRSBK2h+czCGGSiM=;
        b=rRJB3DqlvsE07U7LG6uz0SkJfzT3szNTDytSY92TRtw/Mceys+e/Sc/WsgSvjyzBEv
         L9Q1Yq9lerV2PEyY8sU37S3JbxkpdsyvjP/qoE8XDnwwNsyCZfO+ImxYUOO4ERQ0aFA+
         q0+UrVewjLNVl/4AOlUqGcTBRY30aRf/yR+/8pMRkHNHB3SE78fV0M7hCadqoyluB4VY
         UcfV+EdfWEqAjCKApGLzp6+xM2P4u4FU2GtDefby8jIDIjSj/hCryFoc5aHaQeHMrlNm
         tv0NvJLXSnUfEcAs/HBN2v4RY0KOiPWVjpBFmCr7HxJPndjmqJLhHvYiEx5IXlThxYw6
         SwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756430170; x=1757034970;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LhX8zTKpfIyWjy9VbI0192ydyYGCRSBK2h+czCGGSiM=;
        b=XglNhhn0ip5QbWxZcmcktDOnTMMoBYDHp0VIv3Q+I3ZHoP2mCCnLqPHNZv9QI2FgUT
         5qbeulwd9imX0BTvYmzMf7IOm9nPFq07pNT4zSRQ78OlyNnR7yI0Ro6Y64s33bjeiHOR
         9m13elpe2Y0Sp/2+4ayo2/8Aila1a6SKn6Y2FT3Ff+IFgsDVTA6zDgJj5aQzoJ6ABoiF
         L9IHrjnvXe7Gjph0iS/xmDrP/JtlzotqSlZT9BM5itQ0hJLJStLQjG3aFolH82DgXPYJ
         /uKPl4O7hNyo2jtSOAE7D/xdTSkEQR/w7O2iLcjJic+AeyrYDKUUaT8xVb7LwAqhqM7P
         Aauw==
X-Forwarded-Encrypted: i=1; AJvYcCXqNsobXyLyblbBCwwk7dLGvtX77BRMKeuzRUL7Q4C2iGBC+pWEnrAXA4Bq3mklAvzMz9NK3AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyXWXxxBJ/c3Rk1+v+njgqqx8tIRDaDuAWY+3m/Wki+QtoGZr
	kezpR4zar2N0hDS7c4DePPg7ozdp33/sytcqWf1mAPSfeRcHkb2ubky2zLQuQdhKhxiXpVEUX/O
	9F99s44eS5v4DkA==
X-Google-Smtp-Source: AGHT+IGscoBoUZCNwliXCa3kahwf35lk6r7dTy1vRqlT+ss0RV5TnF4D/+c4bVoNBt7cFJCMZwM9RNr9LFFJFA==
X-Received: from pfug9.prod.google.com ([2002:a05:6a00:789:b0:770:5736:1b9c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:9161:b0:772:270f:58ab with SMTP id d2e1a72fcca58-772270f6052mr3149948b3a.15.1756430170235;
 Thu, 28 Aug 2025 18:16:10 -0700 (PDT)
Date: Fri, 29 Aug 2025 01:16:05 +0000
In-Reply-To: <20250829011607.396650-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829011607.396650-1-skhawaja@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250829011607.396650-2-skhawaja@google.com>
Subject: [PATCH net-next v8 1/2] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, mkarsten@uwaterloo.ca
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state to napi state enum:

- NAPI_STATE_THREADED_BUSY_POLL
  Threaded busy poll is enabled/running for this napi.

Following changes are introduced in the napi scheduling and state logic:

- When threaded busy poll is enabled through netlink it also enables
  NAPI_STATE_THREADED so a kthread is created per napi. It also sets
  NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that it is
  going to busy poll the napi.

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

---
 Documentation/netlink/specs/netdev.yaml |  5 +-
 Documentation/networking/napi.rst       | 62 ++++++++++++++++++++++-
 include/linux/netdevice.h               | 11 ++++-
 include/uapi/linux/netdev.h             |  1 +
 net/core/dev.c                          | 66 +++++++++++++++++++++----
 net/core/dev.h                          |  3 ++
 net/core/netdev-genl-gen.c              |  2 +-
 tools/include/uapi/linux/netdev.h       |  1 +
 8 files changed, 138 insertions(+), 13 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c035dc0f64fd..ee2cfb121dbb 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -88,7 +88,7 @@ definitions:
   -
     name: napi-threaded
     type: enum
-    entries: [disabled, enabled]
+    entries: [disabled, enabled, busy-poll-enabled]
 
 attribute-sets:
   -
@@ -292,6 +292,9 @@ attribute-sets:
         doc: Whether the NAPI is configured to operate in threaded polling
              mode. If this is set to enabled then the NAPI context operates
              in threaded polling mode.
+             mode. If this is set to enabled then the NAPI context operates
+             in threaded polling mode. If this is set to busy-poll-enabled
+             then the NAPI kthread also does busypolling.
         type: u32
         enum: napi-threaded
   -
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index a15754adb041..b252b6e16262 100644
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
@@ -426,6 +428,64 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
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
+It can be enabled for each NAPI using netlink interface.
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
+     'threaded': 'busy-poll-enabled'}
+
 .. _threaded:
 
 Threaded NAPI
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index f3a3b761abfb..a88f6596aef7 100644
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
@@ -1873,7 +1881,8 @@ enum netdev_reg_state {
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
index 5a3c0f40a93f..07ef77fed447 100644
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
@@ -6558,7 +6559,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6963,6 +6965,19 @@ static void napi_stop_kthread(struct napi_struct *napi)
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
@@ -6989,7 +7004,7 @@ int napi_set_threaded(struct napi_struct *napi,
 	} else {
 		/* Make sure kthread is created before THREADED bit is set. */
 		smp_mb__before_atomic();
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		napi_set_threaded_state(napi, threaded);
 	}
 
 	return 0;
@@ -7381,7 +7396,9 @@ void napi_disable_locked(struct napi_struct *n)
 		}
 
 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
-		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
+		new &= ~(NAPIF_STATE_THREADED
+			 | NAPIF_STATE_THREADED_BUSY_POLL
+			 | NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
 	hrtimer_cancel(&n->timer);
@@ -7425,7 +7442,7 @@ void napi_enable_locked(struct napi_struct *n)
 
 		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
 		if (n->dev->threaded && n->thread)
-			new |= NAPIF_STATE_THREADED;
+			napi_set_threaded_state(n, n->dev->threaded);
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
 EXPORT_SYMBOL(napi_enable_locked);
@@ -7593,7 +7610,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7622,22 +7639,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
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
@@ -12829,7 +12877,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/dev.h b/net/core/dev.h
index d6b08d435479..d6cfe7105903 100644
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
2.51.0.338.gd7d06c2dae-goog


