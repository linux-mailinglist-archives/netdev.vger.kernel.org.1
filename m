Return-Path: <netdev+bounces-193323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F0CAC389C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467FC7A45C1
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A921AA7A6;
	Mon, 26 May 2025 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="XJTni8ji"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840391B4233
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233741; cv=none; b=LJnHtGOHzpeD5p2waMrCcZgXJqhv0H5IKoV69ItmP/1dUSxAHQxYA/04xyiBcSid5efOjr+KjuqjUgQURnGbdR7fv9sttF40ZYD1XkJb0pdZMosfGCW92XnkOL+DFLzcKOADFrd9wrQs701WIBENL8fs0vqLTAVHEttQUBNNf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233741; c=relaxed/simple;
	bh=Vs6VjSXEfnyLNJfDjh1tZGfuKShPc2b2CAYQyoGxlLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9c43a9+VBjxB5T+IpY9YM+VKuO3goW8DNAmlg/ksNM+ntV7TjtRQFj1csaFQUYkvuFA3y108p/Nqx9wQCIkOTiIeM0Tr9zoF5fAhHaeysW6foLMsayoZUphfHdqpXIwwSqIz5/ZwqRni1i4pLtU9NDlOd00ZdsO42Cg7jlvr68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=XJTni8ji; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ytInXjo60ilFTA1kP5PURgStH0Fjysc37wuM2/tl6vI=; t=1748233739; x=1749097739; 
	b=XJTni8jiX3Wf6IEVJBrfABR3SbVRUQejvg91oO2IAlWBSu9owaugycBf4QZd2yMo5aFrEV9g0EU
	E3LZ/3T7UA9BY8BlN7aowva6Ld//qBoWua6i3FVrgnz3EVP2pVOYuZmS/43T/yruuC1fmGmrPsWzs
	pFC568H6UiGlT0IQIbTidKMJmlAF2swiQlUDjrK90SXKAOIt/P4QExWtemnTYsoS6LVYTQfnRiRAP
	5NX6rikI0k8CyCMY1hopyNVTuhqSHMG38xMpDLLf/Nduv/kh9f5Z7tZUmIGQSJofTiOM4oaZG9A5B
	f74Yhdpum/w7RmH4K4qlpuNfUsQ056b8jUlg==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPSL-0006Qy-Rr; Sun, 25 May 2025 21:28:59 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 08/15] net: homa: create homa_pacer.h and homa_pacer.c
Date: Sun, 25 May 2025 21:28:10 -0700
Message-ID: <20250526042819.2526-9-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 9f85f44fe068545445b17181e0d50667

These files provide facilities to pace packet output in order to prevent
queue buildup in the NIC. This functionality is needed to implement SRPT
on output, so short messages don't get stuck in long NIC queues. Note: the
pacer eventually needs to be replaced with a Homa-specific qdisc, which can
better manage simultaneous transmissions by Homa and TCP. The current
implementation can coexist with TCP and doesn't harm TCP, but
Homa's latency suffers when TCP runs concurrently.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v8:
* This file is new in v8 (functionality extracted from other files)
---
 net/homa/homa_impl.h  |   1 +
 net/homa/homa_pacer.c | 316 ++++++++++++++++++++++++++++++++++++++++++
 net/homa/homa_pacer.h | 190 +++++++++++++++++++++++++
 3 files changed, 507 insertions(+)
 create mode 100644 net/homa/homa_pacer.c
 create mode 100644 net/homa/homa_pacer.h

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index a7912f03d47a..23e6129d7b8e 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -387,6 +387,7 @@ extern unsigned int homa_net_id;

 int      homa_xmit_control(enum homa_packet_type type, void *contents,
 			   size_t length, struct homa_rpc *rpc);
+void     homa_xmit_data(struct homa_rpc *rpc, bool force);

 /**
  * homa_net_from_net() - Return the struct homa_net associated with a particular
diff --git a/net/homa/homa_pacer.c b/net/homa/homa_pacer.c
new file mode 100644
index 000000000000..515bee18c333
--- /dev/null
+++ b/net/homa/homa_pacer.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file implements the Homa pacer, which implements SRPT for packet
+ * output. In order to do that, it throttles packet transmission to prevent
+ * the buildup of large queues in the NIC.
+ */
+
+#include "homa_pacer.h"
+#include "homa_rpc.h"
+
+/**
+ * homa_pacer_alloc() - Allocate and initialize a new pacer object, which
+ * will hold pacer-related information for @homa.
+ * @homa:   Homa transport that the pacer will be associated with.
+ * Return:  A pointer to the new struct pacer, or a negative errno.
+ */
+struct homa_pacer *homa_pacer_alloc(struct homa *homa)
+{
+	struct homa_pacer *pacer;
+	int err;
+
+	pacer = kmalloc(sizeof(*pacer), GFP_KERNEL | __GFP_ZERO);
+	if (!pacer) {
+		pr_err("%s couldn't allocate homa_pacer struct\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+	pacer->homa = homa;
+	spin_lock_init(&pacer->mutex);
+	pacer->fifo_count = 1000;
+	spin_lock_init(&pacer->throttle_lock);
+	INIT_LIST_HEAD_RCU(&pacer->throttled_rpcs);
+	pacer->fifo_fraction = 50;
+	pacer->max_nic_queue_ns = 5000;
+	pacer->link_mbps = 25000;
+	pacer->throttle_min_bytes = 1000;
+	pacer->exit = false;
+	init_waitqueue_head(&pacer->wait_queue);
+	pacer->kthread = kthread_run(homa_pacer_main, pacer, "homa_pacer");
+	if (IS_ERR(pacer->kthread)) {
+		err = PTR_ERR(pacer->kthread);
+		pr_err("Homa couldn't create pacer thread: error %d\n", err);
+		goto error;
+	}
+	init_completion(&pacer->kthread_done);
+	atomic64_set(&pacer->link_idle_time, homa_clock());
+
+	homa_pacer_update_sysctl_deps(pacer);
+	return pacer;
+
+error:
+	homa_pacer_free(pacer);
+	return ERR_PTR(err);
+}
+
+/**
+ * homa_pacer_free() - Cleanup and free the pacer object for a Homa
+ * transport.
+ * @pacer:    Object to destroy; caller must not reference the object
+ *            again once this function returns.
+ */
+void homa_pacer_free(struct homa_pacer *pacer)
+{
+	pacer->exit = true;
+	if (pacer->kthread) {
+		wake_up(&pacer->wait_queue);
+		kthread_stop(pacer->kthread);
+		wait_for_completion(&pacer->kthread_done);
+		pacer->kthread = NULL;
+	}
+	kfree(pacer);
+}
+
+/**
+ * homa_pacer_check_nic_q() - This function is invoked before passing a
+ * packet to the NIC for transmission. It serves two purposes. First, it
+ * maintains an estimate of the NIC queue length. Second, it indicates to
+ * the caller whether the NIC queue is so full that no new packets should be
+ * queued (Homa's SRPT depends on keeping the NIC queue short).
+ * @pacer:    Pacer information for a Homa transport.
+ * @skb:      Packet that is about to be transmitted.
+ * @force:    True means this packet is going to be transmitted
+ *            regardless of the queue length.
+ * Return:    Nonzero is returned if either the NIC queue length is
+ *            acceptably short or @force was specified. 0 means that the
+ *            NIC queue is at capacity or beyond, so the caller should delay
+ *            the transmission of @skb. If nonzero is returned, then the
+ *            queue estimate is updated to reflect the transmission of @skb.
+ */
+int homa_pacer_check_nic_q(struct homa_pacer *pacer, struct sk_buff *skb,
+			   bool force)
+{
+	u64 idle, new_idle, clock, cycles_for_packet;
+	int bytes;
+
+	bytes = homa_get_skb_info(skb)->wire_bytes;
+	cycles_for_packet = pacer->cycles_per_mbyte;
+	cycles_for_packet *= bytes;
+	do_div(cycles_for_packet, 1000000);
+	while (1) {
+		clock = homa_clock();
+		idle = atomic64_read(&pacer->link_idle_time);
+		if ((clock + pacer->max_nic_queue_cycles) < idle && !force &&
+		    !(pacer->homa->flags & HOMA_FLAG_DONT_THROTTLE))
+			return 0;
+		if (idle < clock)
+			new_idle = clock + cycles_for_packet;
+		else
+			new_idle = idle + cycles_for_packet;
+
+		/* This method must be thread-safe. */
+		if (atomic64_cmpxchg_relaxed(&pacer->link_idle_time, idle,
+					     new_idle) == idle)
+			break;
+	}
+	return 1;
+}
+
+/**
+ * homa_pacer_main() - Top-level function for the pacer thread.
+ * @arg:  Pointer to pacer struct.
+ *
+ * Return:         Always 0.
+ */
+int homa_pacer_main(void *arg)
+{
+	struct homa_pacer *pacer = arg;
+	int status;
+
+	while (1) {
+		if (pacer->exit)
+			break;
+		pacer->wake_time = homa_clock();
+		homa_pacer_xmit(pacer);
+		pacer->wake_time = 0;
+		if (!list_empty(&pacer->throttled_rpcs)) {
+			/* NIC queue is full; before calling pacer again,
+			 * give other threads a chance to run (otherwise
+			 * low-level packet processing such as softirq could
+			 * get locked out).
+			 */
+			schedule();
+			continue;
+		}
+
+		status = wait_event_interruptible(pacer->wait_queue,
+			pacer->exit || !list_empty(&pacer->throttled_rpcs));
+		if (status != 0 && status != -ERESTARTSYS)
+			break;
+	}
+	kthread_complete_and_exit(&pacer->kthread_done, 0);
+	return 0;
+}
+
+/**
+ * homa_pacer_xmit() - Transmit packets from  the throttled list until
+ * either (a) the throttled list is empty or (b) the NIC queue has
+ * reached maximum allowable length. Note: this function may be invoked
+ * from either process context or softirq (BH) level. This function is
+ * invoked from multiple places, not just in the pacer thread. The reason
+ * for this is that (as of 10/2019) Linux's scheduling of the pacer thread
+ * is unpredictable: the thread may block for long periods of time (e.g.,
+ * because it is assigned to the same CPU as a busy interrupt handler).
+ * This can result in poor utilization of the network link. So, this method
+ * gets invoked from other places as well, to increase the likelihood that we
+ * keep the link busy. Those other invocations are not guaranteed to happen,
+ * so the pacer thread provides a backstop.
+ * @pacer:    Pacer information for a Homa transport.
+ */
+void homa_pacer_xmit(struct homa_pacer *pacer)
+{
+	struct homa_rpc *rpc;
+	s64 queue_cycles;
+
+	/* Make sure only one instance of this function executes at a time. */
+	if (!spin_trylock_bh(&pacer->mutex))
+		return;
+
+	while (1) {
+		queue_cycles = atomic64_read(&pacer->link_idle_time) - homa_clock();
+		if (queue_cycles >= pacer->max_nic_queue_cycles)
+			break;
+		if (list_empty(&pacer->throttled_rpcs))
+			break;
+
+		/* Lock the first throttled RPC. This may not be possible
+		 * because we have to hold throttle_lock while locking
+		 * the RPC; that means we can't wait for the RPC lock because
+		 * of lock ordering constraints (see "Homa Locking Strategy" in
+		 * homa_impl.h). Thus, if the RPC lock isn't available, do
+		 * nothing. Holding the throttle lock while locking the RPC
+		 * is important because it keeps the RPC from being deleted
+		 * before it can be locked.
+		 */
+		homa_pacer_throttle_lock(pacer);
+		pacer->fifo_count -= pacer->fifo_fraction;
+		if (pacer->fifo_count <= 0) {
+			struct homa_rpc *cur;
+			u64 oldest = ~0;
+
+			pacer->fifo_count += 1000;
+			rpc = NULL;
+			list_for_each_entry(cur, &pacer->throttled_rpcs,
+					    throttled_links) {
+				if (cur->msgout.init_time < oldest) {
+					rpc = cur;
+					oldest = cur->msgout.init_time;
+				}
+			}
+		} else {
+			rpc = list_first_entry_or_null(&pacer->throttled_rpcs,
+						       struct homa_rpc,
+						       throttled_links);
+		}
+		if (!rpc) {
+			homa_pacer_throttle_unlock(pacer);
+			break;
+		}
+		if (!homa_rpc_try_lock(rpc)) {
+			homa_pacer_throttle_unlock(pacer);
+			break;
+		}
+		homa_pacer_throttle_unlock(pacer);
+
+		homa_xmit_data(rpc, true);
+
+		/* Note: rpc->state could be RPC_DEAD here, but the code
+		 * below should work anyway.
+		 */
+		if (!*rpc->msgout.next_xmit)
+			/* No more data can be transmitted from this message
+			 * (right now), so remove it from the throttled list.
+			 */
+			homa_pacer_unmanage_rpc(rpc);
+		homa_rpc_unlock(rpc);
+	}
+	spin_unlock_bh(&pacer->mutex);
+}
+
+/**
+ * homa_pacer_manage_rpc() - Arrange for the pacer to transmit packets
+ * from this RPC (make sure that an RPC is on the throttled list and wake up
+ * the pacer thread if necessary).
+ * @rpc:     RPC with outbound packets that have been granted but can't be
+ *           sent because of NIC queue restrictions. Must be locked by caller.
+ */
+void homa_pacer_manage_rpc(struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_pacer *pacer = rpc->hsk->homa->pacer;
+	struct homa_rpc *candidate;
+	int bytes_left;
+	int checks = 0;
+
+	if (!list_empty(&rpc->throttled_links))
+		return;
+	bytes_left = rpc->msgout.length - rpc->msgout.next_xmit_offset;
+	homa_pacer_throttle_lock(pacer);
+	list_for_each_entry(candidate, &pacer->throttled_rpcs,
+			    throttled_links) {
+		int bytes_left_cand;
+
+		checks++;
+
+		/* Watch out: the pacer might have just transmitted the last
+		 * packet from candidate.
+		 */
+		bytes_left_cand = candidate->msgout.length -
+				candidate->msgout.next_xmit_offset;
+		if (bytes_left_cand > bytes_left) {
+			list_add_tail(&rpc->throttled_links,
+				      &candidate->throttled_links);
+			goto done;
+		}
+	}
+	list_add_tail(&rpc->throttled_links, &pacer->throttled_rpcs);
+done:
+	homa_pacer_throttle_unlock(pacer);
+	wake_up(&pacer->wait_queue);
+}
+
+/**
+ * homa_pacer_unmanage_rpc() - Make sure that an RPC is no longer managed
+ * by the pacer.
+ * @rpc:     RPC of interest.
+ */
+void homa_pacer_unmanage_rpc(struct homa_rpc *rpc)
+	__must_hold(rpc_bucket_lock)
+{
+	struct homa_pacer *pacer = rpc->hsk->homa->pacer;
+
+	if (unlikely(!list_empty(&rpc->throttled_links))) {
+		homa_pacer_throttle_lock(pacer);
+		list_del_init(&rpc->throttled_links);
+		homa_pacer_throttle_unlock(pacer);
+	}
+}
+
+/**
+ * homa_pacer_update_sysctl_deps() - Update any pacer fields that depend
+ * on values set by sysctl. This function is invoked anytime a pacer sysctl
+ * value is updated.
+ * @pacer:   Pacer to update.
+ */
+void homa_pacer_update_sysctl_deps(struct homa_pacer *pacer)
+{
+	u64 tmp;
+
+	pacer->max_nic_queue_cycles =
+			homa_ns_to_cycles(pacer->max_nic_queue_ns);
+
+	/* Underestimate link bandwidth (overestimate time) by 1%. */
+	tmp = 101 * 8000 * (__u64)homa_clock_khz();
+	do_div(tmp, pacer->link_mbps * 100);
+	pacer->cycles_per_mbyte = tmp;
+}
+
diff --git a/net/homa/homa_pacer.h b/net/homa/homa_pacer.h
new file mode 100644
index 000000000000..9300080a12d4
--- /dev/null
+++ b/net/homa/homa_pacer.h
@@ -0,0 +1,190 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+
+/* This file defines structs and functions related to the Homa pacer,
+ * which implements SRPT for packet output. In order to do that, it
+ * throttles packet transmission to prevent the buildup of
+ * large queues in the NIC.
+ */
+
+#ifndef _HOMA_PACER_H
+#define _HOMA_PACER_H
+
+#include "homa_impl.h"
+
+/**
+ * struct homa_pacer - Contains information that the pacer users to
+ * manage packet output. There is one instance of this object stored
+ * in each struct homa.
+ */
+struct homa_pacer {
+	/** @homa: Transport that this pacer is associated with. */
+	struct homa *homa;
+
+	/**
+	 * @mutex: Ensures that only one instance of homa_pacer_xmit
+	 * runs at a time. Only used in "try" mode: never block on this.
+	 */
+	spinlock_t mutex;
+
+	/**
+	 * @fifo_count: When this becomes <= zero, it's time for the
+	 * pacer to allow the oldest RPC to transmit.
+	 */
+	int fifo_count;
+
+	/**
+	 * @wake_time: homa_clock() time when the pacer woke up (if the pacer
+	 * is running) or 0 if the pacer is sleeping.
+	 */
+	u64 wake_time;
+
+	/**
+	 * @throttle_lock: Used to synchronize access to @throttled_rpcs. Must
+	 * hold when inserting or removing an RPC from throttled_rpcs.
+	 */
+	spinlock_t throttle_lock;
+
+	/**
+	 * @throttled_rpcs: Contains all homa_rpcs that have bytes ready
+	 * for transmission, but which couldn't be sent without exceeding
+	 * the NIC queue limit.
+	 */
+	struct list_head throttled_rpcs;
+
+	/**
+	 * @fifo_fraction: Out of every 1000 packets transmitted by the
+	 * pacer, this number will be transmitted from the oldest message
+	 * rather than the highest-priority message. Set externally via
+	 * sysctl.
+	 */
+	int fifo_fraction;
+
+	/**
+	 * @max_nic_queue_ns: Limits the NIC queue length: we won't queue
+	 * up a packet for transmission if link_idle_time is this many
+	 * nanoseconds in the future (or more). Set externally via sysctl.
+	 */
+	int max_nic_queue_ns;
+
+	/**
+	 * @max_nic_queue_cycles: Same as max_nic_queue_ns except in
+	 * homa_clock() units.
+	 */
+	int max_nic_queue_cycles;
+
+	/**
+	 * @link_mbps: The raw bandwidth of the network uplink, in
+	 * units of 1e06 bits per second.  Set externally via sysctl.
+	 */
+	int link_mbps;
+
+	/**
+	 * @cycles_per_mbyte: the number of homa_clock() cycles that it takes to
+	 * transmit 10**6 bytes on our uplink. This is actually a slight
+	 * overestimate of the value, to ensure that we don't underestimate
+	 * NIC queue length and queue too many packets.
+	 */
+	u32 cycles_per_mbyte;
+
+	/**
+	 * @throttle_min_bytes: If a packet has fewer bytes than this, then it
+	 * bypasses the throttle mechanism and is transmitted immediately.
+	 * We have this limit because for very small packets CPU overheads
+	 * make it impossible to keep up with the NIC so (a) the NIC queue
+	 * can't grow and (b) using the pacer would serialize all of these
+	 * packets through a single core, which makes things even worse.
+	 * Set externally via sysctl.
+	 */
+	int throttle_min_bytes;
+
+	/**
+	 * @exit: true means that the pacer thread should exit as
+	 * soon as possible.
+	 */
+	bool exit;
+
+	/**
+	 * @wait_queue: Used to block the pacer thread when there
+	 * are no throttled RPCs.
+	 */
+	struct wait_queue_head wait_queue;
+
+	/**
+	 * @kthread: Kernel thread that transmits packets from
+	 * throttled_rpcs in a way that limits queue buildup in the
+	 * NIC.
+	 */
+	struct task_struct *kthread;
+
+	/**
+	 * @kthread_done: Used to wait for @kthread to exit.
+	 */
+	struct completion kthread_done;
+
+	/**
+	 * @link_idle_time: The homa_clock() time at which we estimate
+	 * that all of the packets we have passed to the NIC for transmission
+	 * will have been transmitted. May be in the past. This estimate
+	 * assumes that only Homa is transmitting data, so it could be a
+	 * severe underestimate if there is competing traffic from, say, TCP.
+	 */
+	atomic64_t link_idle_time ____cacheline_aligned_in_smp;
+};
+
+struct homa_pacer *homa_pacer_alloc(struct homa *homa);
+int      homa_pacer_check_nic_q(struct homa_pacer *pacer,
+				struct sk_buff *skb, bool force);
+int      homa_pacer_dointvec(const struct ctl_table *table, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
+void     homa_pacer_free(struct homa_pacer *pacer);
+void     homa_pacer_unmanage_rpc(struct homa_rpc *rpc);
+void     homa_pacer_log_throttled(struct homa_pacer *pacer);
+int      homa_pacer_main(void *transport);
+void     homa_pacer_manage_rpc(struct homa_rpc *rpc);
+void     homa_pacer_throttle_lock_slow(struct homa_pacer *pacer);
+void     homa_pacer_update_sysctl_deps(struct homa_pacer *pacer);
+void     homa_pacer_xmit(struct homa_pacer *pacer);
+
+/**
+ * homa_pacer_check() - This method is invoked at various places in Homa to
+ * see if the pacer needs to transmit more packets and, if so, transmit
+ * them. It's needed because the pacer thread may get descheduled by
+ * Linux, result in output stalls.
+ * @pacer:    Pacer information for a Homa transport.
+ */
+static inline void homa_pacer_check(struct homa_pacer *pacer)
+{
+	if (list_empty(&pacer->throttled_rpcs))
+		return;
+
+	/* The ">> 1" in the line below gives homa_pacer_main the first chance
+	 * to queue new packets; if the NIC queue becomes more than half
+	 * empty, then we will help out here.
+	 */
+	if ((homa_clock() + (pacer->max_nic_queue_cycles >> 1)) <
+			atomic64_read(&pacer->link_idle_time))
+		return;
+	homa_pacer_xmit(pacer);
+}
+
+/**
+ * homa_pacer_throttle_lock() - Acquire the throttle lock.
+ * @pacer:    Pacer information for a Homa transport.
+ */
+static inline void homa_pacer_throttle_lock(struct homa_pacer *pacer)
+	__acquires(&pacer->throttle_lock)
+{
+	spin_lock_bh(&pacer->throttle_lock);
+}
+
+/**
+ * homa_pacer_throttle_unlock() - Release the throttle lock.
+ * @pacer:    Pacer information for a Homa transport.
+ */
+static inline void homa_pacer_throttle_unlock(struct homa_pacer *pacer)
+	__releases(&pacer->throttle_lock)
+{
+	spin_unlock_bh(&pacer->throttle_lock);
+}
+
+#endif /* _HOMA_PACER_H */
--
2.43.0


