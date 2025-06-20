Return-Path: <netdev+bounces-199771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AAAAE1C22
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507383B0CA5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B02BDC2E;
	Fri, 20 Jun 2025 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DX/FYDh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBLHJVHf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283BD29B23F;
	Fri, 20 Jun 2025 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425892; cv=none; b=NFf4mrzxJb37JXonr2w3F+BAWagzxMc/KNEN57OZJx930vZbOeDN5axElkjYdHO2ujTwi7KBLTqXluWbZzeuPinyBujPOnGS4Il+YV/BaieC4zPUdjELYJ7QWGyik8A5DCmPpMEUgQZ8q+w/Ilkqiv3t9nwz9hEFQP24hfZNWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425892; c=relaxed/simple;
	bh=+yB62XNLPUTlaPeJXS/0wIXtUzrxaYOCvpDNFe2810k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tm6JXilpgWS1Kzw/YSHJZBIpknoypnvXBePnMXr2nW/aVbAAeD/j46ufCGGGRyfB6eSCwhpZ6Q2Gvt1I0h2xL8uht3r6L9kiaiOiObcuo6Wa/sAZXoxWRHu8Hc2D6lq0kVjiXSOzpKrI7w3Ot+36BcsI2Khn3wFVTJi1ETppxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DX/FYDh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBLHJVHf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.471011376@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/7Rhk90+L+EEwpYNNWS9ADvx0DoiKvCcJBgpAPppGcY=;
	b=DX/FYDh5fRiTRrXqCxacw595bJNcW3Z5+UQwAoBU/w7fUwbbIxl+TAWUKMtUU3Nidwg+IR
	vfGPrKJpD2P/Nu6KqxHc3YJhSQDq9uaJT4Zhueockjuk6ls0eVSz9iS9jxvm0G9DXT9rUB
	4aI5SQtTxBR+s3O6tcqVU1X2JMHz03Ccye5eBimwoAkv2SvHjiZXZo6e+D8uBf1E69Qcqv
	bERWjvM1UUsVECuyfJfU7YrKaSdia8jcnvH9nHOYZ6I5GVnRbqtDkqHM9NFp0BGNzH/oLF
	6/i/9AjFgCBOnLxGBS1andoiYUkzylVPhNVoP5ESngmqHTZYriTUkaQpjuMbxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/7Rhk90+L+EEwpYNNWS9ADvx0DoiKvCcJBgpAPppGcY=;
	b=hBLHJVHfeQvRFn1UYglwq7Z8h2aJv+itlg0l1BWi1slp9j94941ainVNi88OPqzQCLJNQC
	ZsX9YhaUIWbD4oDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 12/13] ptp: Convert chardev code to lock guards
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:48 +0200 (CEST)

Convert the various spin_lock_irqsave() protected critical regions to
scoped guards. Use spinlock_irq instead of spinlock_irqsave as all the
functions are invoked in thread context with interrupts enabled.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -110,7 +110,6 @@ int ptp_open(struct posix_clock_context
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
-	unsigned long flags;
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
@@ -122,9 +121,8 @@ int ptp_open(struct posix_clock_context
 	}
 	bitmap_set(queue->mask, 0, PTP_MAX_CHANNELS);
 	spin_lock_init(&queue->lock);
-	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
-	list_add_tail(&queue->qlist, &ptp->tsevqs);
-	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
+		list_add_tail(&queue->qlist, &ptp->tsevqs);
 	pccontext->private_clkdata = queue;
 
 	/* Debugfs contents */
@@ -143,15 +141,13 @@ int ptp_open(struct posix_clock_context
 int ptp_release(struct posix_clock_context *pccontext)
 {
 	struct timestamp_event_queue *queue = pccontext->private_clkdata;
-	unsigned long flags;
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 
 	debugfs_remove(queue->debugfs_instance);
 	pccontext->private_clkdata = NULL;
-	spin_lock_irqsave(&ptp->tsevqs_lock, flags);
-	list_del(&queue->qlist);
-	spin_unlock_irqrestore(&ptp->tsevqs_lock, flags);
+	scoped_guard(spinlock_irq, &ptp->tsevqs_lock)
+		list_del(&queue->qlist);
 	bitmap_free(queue->mask);
 	kfree(queue);
 	return 0;
@@ -548,8 +544,6 @@ ssize_t ptp_read(struct posix_clock_cont
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
-	unsigned long flags;
-	size_t qcnt, i;
 	int result;
 
 	queue = pccontext->private_clkdata;
@@ -584,21 +578,19 @@ ssize_t ptp_read(struct posix_clock_cont
 		goto exit;
 	}
 
-	spin_lock_irqsave(&queue->lock, flags);
+	scoped_guard(spinlock_irq, &queue->lock) {
+		size_t qcnt = queue_cnt(queue);
 
-	qcnt = queue_cnt(queue);
+		if (cnt > qcnt)
+			cnt = qcnt;
 
-	if (cnt > qcnt)
-		cnt = qcnt;
-
-	for (i = 0; i < cnt; i++) {
-		event[i] = queue->buf[queue->head];
-		/* Paired with READ_ONCE() in queue_cnt() */
-		WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
+		for (size_t i = 0; i < cnt; i++) {
+			event[i] = queue->buf[queue->head];
+			/* Paired with READ_ONCE() in queue_cnt() */
+			WRITE_ONCE(queue->head, (queue->head + 1) % PTP_MAX_TIMESTAMPS);
+		}
 	}
 
-	spin_unlock_irqrestore(&queue->lock, flags);
-
 	cnt = cnt * sizeof(struct ptp_extts_event);
 
 	result = cnt;


