Return-Path: <netdev+bounces-199770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3BAE1C20
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33DC1C20E7B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C92BD5BD;
	Fri, 20 Jun 2025 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6d1Suar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="58DIbyOu"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA72BD59A;
	Fri, 20 Jun 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425890; cv=none; b=NbpzdPagKAdWryX99ghgnjYFhwGylK+CN6GHbe0EpUUoTdgXghYPVTTJRxAFJZSBwZYKG5Pw2cU1miw2aCuiLBaemwc1eMUDlYl6N5xRwYbrTx2z0RaQmoq5MihHaQ7vPe2tEXknHhY7QfSKV+eurX36nrljXhPZip8/24BH8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425890; c=relaxed/simple;
	bh=uNfHKM57G76FFv6JzyBP4WrvZku4fleSoyUjJtqw/7Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=TBFdB6b0nUfJX0+HfVCZtU7LoVdi4H0ZBUkHdyguk4Z2LY9GQJeOympb8FlQ55GMLnKXZjQdUkWlYOxgIwuLHRnPsoblfF4ltnXpTKEqto/Mw1L9CPYF49BtwtD011V1OdJrt3lQJIxryLR3RcBDeInW1Of+yxY2pjGU9ZXb5Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H6d1Suar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=58DIbyOu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.408020331@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CZbllYMTwyg8r+RWTW/1nbw7yqcKYAx79dp9Mm+YOqw=;
	b=H6d1Suar3CdWK0it2f8eomzC+wzAJQP58AN7bCHkEWsD+AhpHGoTlEwFPy/bKFkuMriubi
	MIybbOKI+OLq+HW5ghw0GwKAb2rP1qzkiA8Kt9AtblmPpNqQEu0Q9mVqSQavI8YpVOF1zO
	W6/w8yd5kvuccv5NWDV7ZhH1GONIJkCtQRsDWnWMhsDobXRVSomi2gbOpwfRhQ4+GJX9qU
	eOxvnwJMVDrUNUtn1LfWr9uWaCeF5wk9pvTTyOkc/ZGzPc4Q0orA8EBluwG+fKOR96JwWz
	mIfVdS7CtPk75Oloz6/cDPtpF2uuj+fikykPP+TlWa30HDqXQZRnDXTMSd28lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CZbllYMTwyg8r+RWTW/1nbw7yqcKYAx79dp9Mm+YOqw=;
	b=58DIbyOuT2JBhCBrHOiEUsRtMfbIrO/XS03RAC2/XMf5IG1RkpwjU5mSWyrVZB2aBQ7j1k
	K9AgFs3zI0WBICDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 11/13] ptp: Split out PTP_MASK_EN_SINGLE ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:46 +0200 (CEST)

Finish the ptp_ioctl() cleanup by splitting out the PTP_MASK_EN_SINGLE
ioctl code and removing the remaining local variables and return
statements.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -448,22 +448,28 @@ static long ptp_mask_clear_all(struct ti
 	return 0;
 }
 
+static long ptp_mask_en_single(struct timestamp_event_queue *tsevq, void __user *arg)
+{
+	unsigned int channel;
+
+	if (copy_from_user(&channel, arg, sizeof(channel)))
+		return -EFAULT;
+	if (channel >= PTP_MAX_CHANNELS)
+		return -EFAULT;
+	set_bit(channel, tsevq->mask);
+	return 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
-	struct ptp_clock *ptp =
-		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct timestamp_event_queue *tsevq;
+	struct ptp_clock *ptp = container_of(pccontext->clk, struct ptp_clock, clock);
 	void __user *argptr;
-	unsigned int i;
-	int err = 0;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
 	argptr = (void __force __user *)arg;
 
-	tsevq = pccontext->private_clkdata;
-
 	switch (cmd) {
 	case PTP_CLOCK_GETCAPS:
 	case PTP_CLOCK_GETCAPS2:
@@ -513,22 +519,11 @@ long ptp_ioctl(struct posix_clock_contex
 		return ptp_mask_clear_all(pccontext->private_clkdata);
 
 	case PTP_MASK_EN_SINGLE:
-		if (copy_from_user(&i, (void __user *)arg, sizeof(i))) {
-			err = -EFAULT;
-			break;
-		}
-		if (i >= PTP_MAX_CHANNELS) {
-			err = -EFAULT;
-			break;
-		}
-		set_bit(i, tsevq->mask);
-		break;
+		return ptp_mask_en_single(pccontext->private_clkdata, argptr);
 
 	default:
-		err = -ENOTTY;
-		break;
+		return -ENOTTY;
 	}
-	return err;
 }
 
 __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,


