Return-Path: <netdev+bounces-185723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B98A9B8BA
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABB57A8587
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 20:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E11FA85A;
	Thu, 24 Apr 2025 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QW/Na6zV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8921F4631
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524950; cv=none; b=dJG43r82p8EGk3ex/4LDZmi/3lQAR+hbATDg18vW5LmIe5heYxAaPYk5NyudjaDxXoN1ZD3kfY3HJGZJSIhp8pUBSx+vqyiysVDyg6SYsf7+AwCKQvorHUU/Nq/seotasxWg8L0rjIlzYxc2hc+nTZ5rsVWz0Or2zje7N6QkbpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524950; c=relaxed/simple;
	bh=2dqHzAISzAeUoopRX9xxyTQyYBYeV8nLGyRayrdBJyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+3cvQ1fU3Q+R7/7zdFEDuaQFqkX9rVzjtlu51OEf8N44gtibZrwfuJx+tWpFi0CFM7CQUg0/Qp1r65nyHhm6ti4WAr6fkk+4SfQPxfAFka0j+IpjuO2ptXwfHtElyBdMnKtBQE1JIoVEBzg0e0NMIk1WyO25NKeyqcAJ/782sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QW/Na6zV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2240a7aceeaso15433775ad.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745524948; x=1746129748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz0d4owpvrZHWl3j+l0tvORZU+JWF/A6prSODGUEZiM=;
        b=QW/Na6zV7A9mciJESlzSg38l+gKCnmzuGeMXAb4rw4Fzsn9X2IDUZLtVJlRxVeHLMW
         QDcZ+PFRoMOnJYf/d0kcbcBO4PQNpHRyLRmkcr+txVCai7Klv2R5B/0Hf42ZTqwXfyVd
         yb5Vzk249+Xpnby0zWhTZl2ECUVSJwJatNSFDHRV/D5TQTX7E95dHLOwlIthRe6LPMQW
         Qa3veVJX3fJwid7m8t9tIYZw1sHCzyKElQ7hb9bG4XkwMT97Z4zqU8QhM0LN5L92LwCe
         iYoZLII5dw99HgK7/9phKMYcuMmTcDjS4SAai41Eh4lwRBoaPPPyErBiTzSgybYqXI8p
         bzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524948; x=1746129748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz0d4owpvrZHWl3j+l0tvORZU+JWF/A6prSODGUEZiM=;
        b=kGHJtLMQcCs2ImX8kSjLn+9lRkCdmE3Kj4N2TvMEExss0gqoasXxGG+Z3GK48cucKD
         Jkk5wXnZc4sA8tazp6zQzxdHI/VQbel9A3kF4WUA2tSb3NHvS6WIZsMlchRypR/i38iM
         EeysQJdudig+e5PzRmOn6y60i+IL1/m0Hub10yA3zVtA8bpOt82SZSSwRUpp0rIdec5v
         hbC6fBvUFfQNUmapzbEPddgpuI5fSih7o84Pqk2iRhoOHjg/izwYhPh/dXqQ+thpcQ/a
         wU5xSkG6DhzOkpNmQPxaGNeXYSGFkT3nl4hXDUJSoWCna8rQ9TANzPsZ/MkmceT7XJBE
         aSIg==
X-Gm-Message-State: AOJu0YwBZiFbKsFuDECWB6ldtVsIXCq+stu7Q3cb3CIdoDvPZqwXQC8b
	we4PFPYMkKPvGx0kHhhN+vqbhw0IkpsNVKVi1czG1laCG7/zNqMK17cUuCPx58ltLQ8Kqvq9BSw
	lN513EWajgg==
X-Google-Smtp-Source: AGHT+IEUjRJMOsWow+2pVtZ7nMyUveJ5lPEl+ym6+iOHoaYdyoAcAeroNdMTgAvByxAzVMDtg6ZAZHzdA2dI0w==
X-Received: from plot17.prod.google.com ([2002:a17:902:8c91:b0:223:8233:a96c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1744:b0:215:b473:1dc9 with SMTP id d9443c01a7336-22dbd46f994mr9758775ad.46.1745524947874;
 Thu, 24 Apr 2025 13:02:27 -0700 (PDT)
Date: Thu, 24 Apr 2025 20:02:21 +0000
In-Reply-To: <20250424200222.2602990-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250424200222.2602990-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250424200222.2602990-4-skhawaja@google.com>
Subject: [PATCH net-next v5 3/4] Extend napi threaded polling to allow kthread
 based busy polling
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Add a new state to napi state enum:

- STATE_THREADED_BUSY_POLL
  Threaded busy poll is enabled/running for this napi.

Following changes are introduced in the napi scheduling and state logic:

- When threaded busy poll is enabled through sysfs it also enables
  NAPI_STATE_THREADED so a kthread is created per napi. It also sets
  NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
  supposed to busy poll for each napi.

- When napi is scheduled with STATE_SCHED_THREADED and associated
  kthread is woken up, the kthread owns the context. If
  NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
  then it means that we can busy poll.

- To keep busy polling and to avoid scheduling of the interrupts, the
  napi_complete_done returns false when both SCHED_THREADED and
  THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
  early to avoid the STATE_SCHED_THREADED being unset.

- If at any point STATE_THREADED_BUSY_POLL is unset, the
  napi_complete_done will run and unset the SCHED_THREADED bit also.
  This will make the associated kthread go to sleep as per existing
  logic.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/ABI/testing/sysfs-class-net |  3 +-
 Documentation/netlink/specs/netdev.yaml   |  5 +-
 Documentation/networking/napi.rst         | 67 ++++++++++++++++++++-
 include/linux/netdevice.h                 |  8 +++
 include/uapi/linux/netdev.h               |  1 +
 net/core/dev.c                            | 71 +++++++++++++++++++----
 net/core/dev.h                            |  3 +
 net/core/net-sysfs.c                      |  2 +-
 net/core/netdev-genl-gen.c                |  2 +-
 tools/include/uapi/linux/netdev.h         |  1 +
 10 files changed, 145 insertions(+), 18 deletions(-)

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
index c8834161e8ec..650179559558 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -85,7 +85,7 @@ definitions:
   -
     name: napi-threaded
     type: enum
-    entries: [ disable, enable ]
+    entries: [ disable, enable, busy-poll-enable ]
 
 attribute-sets:
   -
@@ -288,7 +288,8 @@ attribute-sets:
         name: threaded
         doc: Whether the napi is configured to operate in threaded polling
              mode. If this is set to `enable` then the NAPI context operates
-             in threaded polling mode.
+             in threaded polling mode. If this is set to `busy-poll-enable`
+             then the NAPI kthread also does busypolling.
         type: u32
         enum: napi-threaded
   -
diff --git a/Documentation/networking/napi.rst b/Documentation/networking/napi.rst
index 63f98c05860f..0f83142c624d 100644
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
@@ -426,6 +428,69 @@ Therefore, setting ``gro_flush_timeout`` and ``napi_defer_hard_irqs`` is
 the recommended usage, because otherwise setting ``irq-suspend-timeout``
 might not have any discernible effect.
 
+.. _threaded_busy_poll:
+
+Threaded NAPI busy polling
+--------------------------
+
+Threaded napi allows processing of packets from each NAPI in a kthread in
+kernel. Threaded napi busy polling extends this and adds support to do
+continuous busy polling of this napi. This can be used to enable busy polling
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
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-set \
+            --json='{"id": 66,
+                     "threaded": "busy-poll-enable"}'
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
+as soon as they appear. For more relaxed low-latency requirement, user might
+want to share the core with other threads.
+
+Once threaded busy polling is enabled for a NAPI, PID of the kthread can be
+fetched using netlink interface so the affinity, priority and scheduler
+configuration can be done.
+
+For example, following script can be used to fetch the pid:
+
+.. code-block:: bash
+
+  $ kernel-source/tools/net/ynl/pyynl/cli.py \
+            --spec Documentation/netlink/specs/netdev.yaml \
+            --do napi-get \
+            --json='{"id": 66}'
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
index 2eda563307f9..c67a7424605e 100644
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
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index a5737572ce92..b9b59d60957f 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLE,
 	NETDEV_NAPI_THREADED_ENABLE,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE,
 };
 
 enum {
diff --git a/net/core/dev.c b/net/core/dev.c
index 41d809f2a7f7..7270e0a13c9f 100644
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
@@ -6525,7 +6526,8 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 	 *    the guarantee we will be called later.
 	 */
 	if (unlikely(n->state & (NAPIF_STATE_NPSVC |
-				 NAPIF_STATE_IN_BUSY_POLL)))
+				 NAPIF_STATE_IN_BUSY_POLL |
+				 NAPIF_STATE_SCHED_THREADED_BUSY_POLL)))
 		return false;
 
 	if (work_done) {
@@ -6899,9 +6901,11 @@ static void napi_set_threaded_state(struct napi_struct *napi,
 	unsigned long val;
 
 	val = 0;
+	if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
+		val |= NAPIF_STATE_THREADED_BUSY_POLL;
 	if (threaded)
 		val |= NAPIF_STATE_THREADED;
-	set_mask_bits(&napi->state, NAPIF_STATE_THREADED, val);
+	set_mask_bits(&napi->state, NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 }
 
 int napi_set_threaded(struct napi_struct *napi,
@@ -6941,6 +6945,8 @@ int dev_set_threaded(struct net_device *dev,
 	val = 0;
 	if (threaded) {
 		val |= NAPIF_STATE_THREADED;
+		if (threaded == NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
+			val |= NAPIF_STATE_THREADED_BUSY_POLL;
 
 		list_for_each_entry(napi, &dev->napi_list, dev_list) {
 			if (!napi->thread) {
@@ -6965,9 +6971,13 @@ int dev_set_threaded(struct net_device *dev,
 	 * polled. In this case, the switch between threaded mode and
 	 * softirq mode will happen in the next round of napi_schedule().
 	 * This should not cause hiccups/stalls to the live traffic.
+	 *
+	 * Switch to busy_poll threaded napi will occur after the threaded
+	 * napi is scheduled.
 	 */
 	list_for_each_entry(napi, &dev->napi_list, dev_list)
-		assign_bit(NAPI_STATE_THREADED, &napi->state, threaded);
+		set_mask_bits(&napi->state,
+			      NAPIF_STATE_THREADED_BUSY_POLL_MASK, val);
 
 	return err;
 }
@@ -7285,8 +7295,12 @@ void netif_napi_add_weight_locked(struct net_device *dev,
 	 * Clear dev->threaded if kthread creation failed so that
 	 * threaded mode will not be enabled in napi_enable().
 	 */
-	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = false;
+	if (dev->threaded) {
+		if (napi_kthread_create(napi))
+			dev->threaded = false;
+		else
+			napi_set_threaded_state(napi, dev->threaded);
+	}
 	netif_napi_set_irq_locked(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight_locked);
@@ -7308,7 +7322,9 @@ void napi_disable_locked(struct napi_struct *n)
 		}
 
 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
-		new &= ~(NAPIF_STATE_THREADED | NAPIF_STATE_PREFER_BUSY_POLL);
+		new &= ~(NAPIF_STATE_THREADED
+			 | NAPIF_STATE_THREADED_BUSY_POLL
+			 | NAPIF_STATE_PREFER_BUSY_POLL);
 	} while (!try_cmpxchg(&n->state, &val, new));
 
 	hrtimer_cancel(&n->timer);
@@ -7352,7 +7368,7 @@ void napi_enable_locked(struct napi_struct *n)
 
 		new = val & ~(NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC);
 		if (n->dev->threaded && n->thread)
-			new |= NAPIF_STATE_THREADED;
+			napi_set_threaded_state(n, n->dev->threaded);
 	} while (!try_cmpxchg(&n->state, &val, new));
 }
 EXPORT_SYMBOL(napi_enable_locked);
@@ -7515,7 +7531,7 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi)
+static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
@@ -7544,22 +7560,53 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
 		}
 		skb_defer_free_flush(sd);
 		bpf_net_ctx_clear(bpf_net_ctx);
+
+		/* Flush too old packets. If HZ < 1000, flush all packets */
+		if (busy_poll)
+			__napi_gro_flush_helper(napi, HZ >= 1000);
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
+		 * state is set then we busy poll this napi.
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
@@ -12744,7 +12791,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog);
+	napi_threaded_poll_loop(&sd->backlog, false);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
diff --git a/net/core/dev.h b/net/core/dev.h
index 3924996ae85c..bd9d26b4a6ba 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -323,6 +323,9 @@ static inline void napi_set_irq_suspend_timeout(struct napi_struct *n,
  */
 static inline enum netdev_napi_threaded napi_get_threaded(struct napi_struct *n)
 {
+	if (test_bit(NAPI_STATE_THREADED_BUSY_POLL, &n->state))
+		return NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE;
+
 	if (test_bit(NAPI_STATE_THREADED, &n->state))
 		return NETDEV_NAPI_THREADED_ENABLE;
 
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1ace0cd01adc..0b7624236896 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -741,7 +741,7 @@ static int modify_napi_threaded(struct net_device *dev, unsigned long val)
 	if (list_empty(&dev->napi_list))
 		return -EOPNOTSUPP;
 
-	if (val != 0 && val != 1)
+	if (val > NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE)
 		return -EOPNOTSUPP;
 
 	ret = dev_set_threaded(dev, val);
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index c2e5cee857d2..1dbe5f19a192 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -97,7 +97,7 @@ static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_THREADED
 	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = NLA_POLICY_FULL_RANGE(NLA_U32, &netdev_a_napi_defer_hard_irqs_range),
 	[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] = { .type = NLA_UINT, },
 	[NETDEV_A_NAPI_IRQ_SUSPEND_TIMEOUT] = { .type = NLA_UINT, },
-	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_NAPI_THREADED] = NLA_POLICY_MAX(NLA_U32, 2),
 };
 
 /* Ops table for netdev */
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index a5737572ce92..b9b59d60957f 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -80,6 +80,7 @@ enum netdev_qstats_scope {
 enum netdev_napi_threaded {
 	NETDEV_NAPI_THREADED_DISABLE,
 	NETDEV_NAPI_THREADED_ENABLE,
+	NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE,
 };
 
 enum {
-- 
2.49.0.850.g28803427d3-goog


