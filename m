Return-Path: <netdev+bounces-199772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CEAE1C2B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4273316C5CB
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E92BE7B8;
	Fri, 20 Jun 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3+6T9Em";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1+bRPVS"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25492BDC26;
	Fri, 20 Jun 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425894; cv=none; b=uAe58dymYwiNsEV9ruQOzeCzZ5JZfxPMsVwTNDStotwvl02OqHL6vzsuHAov+RKkjh4CgQ6xcvDTCWJGIodpbCXIJz6NilgifRUSRuv6unhERq7pnS2MOK8zHa7vqdN5c1/XeptF548Hc+D8Y2LOiEGWjly7uTEuciZreb7drYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425894; c=relaxed/simple;
	bh=+yQNQVtDUDnZEDOwjEyTfF300+/7hA3mOBRzxQBCcdg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jihvObGZvhPnZ9qNRETGn4uI23/EIhVHPhUjHuE/Yd2ciYdyIFVOgH2YKYRXnr6Q1AXgc1wB+RoisEwTRTuQuXj6gXWTkMQqamqZ5rBXNQw8CnhgahKL+6syhypvW2BuOKKZ2Te4x6R/wHqyUYS/KZNSv4wzdqFsHIXSjkgG7ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3+6T9Em; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1+bRPVS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.533741574@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t5AUZu+5N4DYRhjssasKvybcKzjmriU2anO1KoUYxkA=;
	b=r3+6T9EmTdlMc7zHSKMT4YJNIkDrBT/QGeXroAsFqe9mzsUuvfGsibYbtGKmC+P0B6NxmW
	GCucNVS+DkIVUBpmdzMDLgl+U0igiis5qIw/Qh6jaLMrle80+tXHrRArwLR0czMvpzgXu/
	2G4ZUk/+EJWsIRxdDtsfmxGwtJ/L5LPp1NQHaaZrTsCcRnV9npi0MhKOwNGyVtg+iiIdWM
	Qg9Eo/R69W2FYzDDF6ja9J3kSZT9RJkaZRt3KpkBVK17MoTZTTMDZ8+uW/WkiQDbaFmg8v
	oumC10BtXaSINmBMHr8+q1D6+FUd99UP9h/x8zD9Uh6/raFxSuhxKm3tSAqYsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=t5AUZu+5N4DYRhjssasKvybcKzjmriU2anO1KoUYxkA=;
	b=N1+bRPVSrrVLcFrgOp8lStb1p3QF+9b7T+aBMDPYr8aDTI+2smDURGfm8L0qCIFdxIiwWv
	mqM09XOrzBo+X5Bg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 13/13] ptp: Convert ptp_open/read() to __free()
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:50 +0200 (CEST)

Get rid of the kfree() and goto maze and just return error codes directly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   70 ++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -106,19 +106,17 @@ int ptp_set_pinfunc(struct ptp_clock *pt
 
 int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue;
+	struct ptp_clock *ptp =	container_of(pccontext->clk, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue __free(kfree) = NULL;
 	char debugfsname[32];
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
 		return -EINVAL;
 	queue->mask = bitmap_alloc(PTP_MAX_CHANNELS, GFP_KERNEL);
-	if (!queue->mask) {
-		kfree(queue);
+	if (!queue->mask)
 		return -EINVAL;
-	}
+
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
 	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
@@ -134,7 +132,6 @@ int ptp_open(struct posix_clock_context
 		DIV_ROUND_UP(PTP_MAX_CHANNELS, BITS_PER_BYTE * sizeof(u32));
 	debugfs_create_u32_array("mask", 0444, queue->debugfs_instance,
 				 &queue->dfs_bitmap);
-
 	return 0;
 }
 
@@ -540,67 +537,38 @@ long ptp_ioctl(struct posix_clock_contex
 ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 		 char __user *buf, size_t cnt)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct timestamp_event_queue *queue;
-	struct ptp_extts_event *event;
-	int result;
+	struct ptp_clock *ptp =	container_of(pccontext->clk, struct ptp_clock, clock);
+	struct timestamp_event_queue *queue = pccontext->private_clkdata;
+	struct ptp_extts_event *event __free(kfree) = NULL;
 
-	queue = pccontext->private_clkdata;
-	if (!queue) {
-		result = -EINVAL;
-		goto exit;
-	}
+	if (!queue)
+		return -EINVAL;
 
-	if (cnt % sizeof(struct ptp_extts_event) != 0) {
-		result = -EINVAL;
-		goto exit;
-	}
+	if (cnt % sizeof(struct ptp_extts_event) != 0)
+		return -EINVAL;
 
 	if (cnt > EXTTS_BUFSIZE)
 		cnt = EXTTS_BUFSIZE;
 
-	cnt = cnt / sizeof(struct ptp_extts_event);
-
-	if (wait_event_interruptible(ptp->tsev_wq,
-				     ptp->defunct || queue_cnt(queue))) {
+	if (wait_event_interruptible(ptp->tsev_wq, ptp->defunct || queue_cnt(queue)))
 		return -ERESTARTSYS;
-	}
 
-	if (ptp->defunct) {
-		result = -ENODEV;
-		goto exit;
-	}
+	if (ptp->defunct)
+		return -ENODEV;
 
 	event = kmalloc(EXTTS_BUFSIZE, GFP_KERNEL);
-	if (!event) {
-		result = -ENOMEM;
-		goto exit;
-	}
+	if (!event)
+		return -ENOMEM;
 
 	scoped_guard(spinlock_irq, &queue->lock) {
-		size_t qcnt = queue_cnt(queue);
-
-		if (cnt > qcnt)
-			cnt = qcnt;
+		size_t qcnt = min((size_t)queue_cnt(queue), cnt / sizeof(*event));
 
-		for (size_t i = 0; i < cnt; i++) {
+		for (size_t i = 0; i < qcnt; i++) {
 			event[i] = queue->buf[queue->head];
 			/* Paired with READ_ONCE() in queue_cnt() */
 			WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
 		}
 	}
 
-	cnt = cnt * sizeof(struct ptp_extts_event);
-
-	result = cnt;
-	if (copy_to_user(buf, event, cnt)) {
-		result = -EFAULT;
-		goto free_event;
-	}
-
-free_event:
-	kfree(event);
-exit:
-	return result;
+	return copy_to_user(buf, event, cnt) ? -EFAULT : cnt;
 }


