Return-Path: <netdev+bounces-201113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42476AE8215
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBA27AA7C5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD2267AEB;
	Wed, 25 Jun 2025 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ij1geo9+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yI77TiUa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17E25E44B;
	Wed, 25 Jun 2025 11:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852364; cv=none; b=hUCjLWTAvfVi+gB8BFFXJwN4ZobUeXfdtNwyneNy3bUd8MHyKORyQGXBMSa46CxZEpXh46NaGzSqER4uFgTY5tKmks9oziBsXlGnPDm7vMdrIVXnnc9Z3j5zzOKKWwDCGtr2XVA7yIXBBJH0WFp0/g3b/8VIi7hpa/8YvAzFmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852364; c=relaxed/simple;
	bh=TWIqKKbfG6uuI5HtJ3eC8YlrZRXG3e3FNtS1Y27gBWY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=G8cem57f2PKYvdARL9aNc/1Y5yTt9oeT1l9MRQaNWaQYzJx9uBSvzk7jKwe4zDdZm+Jwh7bOf1+HlS04VWV0bus8u5wQ9Ok2YHY/UvDNEkNEcO0z9OQNntxH8OuCStw459iW8UDanP+Vs9acKXdUk8QD9mHYTWz5tS/sMWlFrPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ij1geo9+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yI77TiUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.486953538@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GCssfyGvJulb+kWMiAtrGha00DmPusbjNgsxf3WrhOI=;
	b=ij1geo9+GrIYRBF5s3mgwgO/FAfNNTqkmPB8Xy5nTJi1av60V6YnQdQ6PoSpdiVKpX0cQN
	UFE4AYhgYiPogILMxtFY2aWsEYwB70GsbFeyro8Yxx04hLV5yb5IwKErr7lInhabF5YyEr
	zryubZbPNYe1nROE2hXmeenMBmS7VcZrNnLg3PI2HjydFj5UAlfj28qCgKb31fMK01QX+I
	TIjlom64jjT3Wt5I4aJPsq50gfyUYNo4SqzxMiScG0Y1c15uG3u/szXD3l6P6A+0X7DGy2
	uYN5tJJ6dSJvDOKShekQCbt4dLMoTx8+VHCJHnpzVqTpoVLMuD1DdWOa2qRnSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=GCssfyGvJulb+kWMiAtrGha00DmPusbjNgsxf3WrhOI=;
	b=yI77TiUaBFd0b2giLZAR3Rs2r4RQHtySXnAtTI/QfaEbAzV+CzTK+nPIsGtM/eejba2I45
	v6UtiPDj/3WmR2AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 13/13] ptp: Simplify ptp_read()
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:39 +0200 (CEST)

The mixture of gotos and direct return codes is inconsistent and just makes
the code harder to read. Let it consistently return error codes directly and
tidy the code flow up accordingly.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the return value - Paolo
    Drop the __free() part - Jakub
---
 drivers/ptp/ptp_chardev.c |   54 +++++++++++++---------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -106,8 +106,7 @@ int ptp_set_pinfunc(struct ptp_clock *pt
 
 int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
+	struct ptp_clock *ptp = container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	char debugfsname[32];
 
@@ -536,67 +535,46 @@ long ptp_ioctl(struct posix_clock_contex
 ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 		 char __user *buf, size_t cnt)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
+	struct ptp_clock *ptp =	container_of(pccontext->clk, struct ptp_clock, clock);
 	struct timestamp_event_queue *queue;
 	struct ptp_extts_event *event;
-	int result;
+	ssize_t result;
 
 	queue = pccontext->private_clkdata;
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
+	if (cnt % sizeof(*event) != 0)
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
+		cnt = qcnt * sizeof(*event);
 	}
 
-	cnt = cnt * sizeof(struct ptp_extts_event);
-
 	result = cnt;
-	if (copy_to_user(buf, event, cnt)) {
+	if (copy_to_user(buf, event, cnt))
 		result = -EFAULT;
-		goto free_event;
-	}
 
-free_event:
 	kfree(event);
-exit:
 	return result;
 }


