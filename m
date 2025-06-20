Return-Path: <netdev+bounces-199759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B4FAE1C0A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1115D7AF36E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F028D839;
	Fri, 20 Jun 2025 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5/LTCYH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQ4m2N5c"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFD528B414;
	Fri, 20 Jun 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425871; cv=none; b=vC5grL+7JpjG4/35ufm4QHfSmskZJN6GkQNjy71aDU3XHTQJsSyk+o04QWEay8T1PAj3y6auMozuq/IXFxBXku/ZUVffFjuZzJ+Fgxxo9nv9ddKhhml4sJUmaqTY2RLFGtddpnnWQ3ZtWKoAK3NXacRW5eJhpkstOqv0X2M1Y4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425871; c=relaxed/simple;
	bh=D0hNaC1los/+J8Ec10aBDfo3+sIyv8yVvL4pcYj2rwU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=r2x5Om6joO/AVrJvZQY4Y08VrpEHlYpZTUemIvKMZLibDq+ooaoTsHPEDgkj49GSKjmkCOK6Gxn7PfH0q4UQVg3tEvsLPt5fIiEXiOhnFXSFXyqI5dzelwiMtFLAtF2qOhtoOVVQ+UfsdWAX4lnvHdbRXK3VJt3g6LfX0acZYOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5/LTCYH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQ4m2N5c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131943.779603403@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/B4z0/jfyKkYbKfvt/J+B+BcvknysPOJc978SNnbXk=;
	b=S5/LTCYHMUx9td4gltSAXIReafhuJAe1hSApdvlwHfCLGWOOrOTS2jeDtYxHYt2cNp7X6d
	oyWvZDs9Tn3N5GGRsovKsI0ugwoTQ/7WRGfWtI1C91fZPV9P821leQhVCCBQX93atOmPgE
	iFOXDHs9/ECRDOj/W0Qa/quJND/Uix6B9ajLuNPpBw3lXjOSsTEEWGDM43rGpyGe+MH4Y3
	wnhf7+kt81F5EAXslNNpvOOGDJIDVcRpr+7J/ax9EV5ZU7y6fwXvoZRZJBUondg+dDUXpt
	P900l5GflrIBH4JXmKcAvCHWlarIiM0HymG9uZCIKeAoFufmGS102Q0dxYhC7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+/B4z0/jfyKkYbKfvt/J+B+BcvknysPOJc978SNnbXk=;
	b=hQ4m2N5cpNUswwzDNB3NFlUUqmd2vompIPmOdI+SkpRf6GQbKzAW4ILkA1M85njJkqBs4N
	GdxlBw/h0imjmgDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 01/13] ptp: Split out PTP_CLOCK_GETCAPS ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:27 +0200 (CEST)

ptp_ioctl() is an inpenetrable letter soup with a gazillion of case (scope)
specific variables defined at the top of the function and pointless breaks
and gotos.

Start cleaning it up by splitting out the PTP_CLOCK_GETCAPS ioctl code into
a helper function. Use a argument pointer with a single sparse compliant
type cast instead of proliferating the type cast all over the place.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -157,6 +157,26 @@ int ptp_release(struct posix_clock_conte
 	return 0;
 }
 
+static long ptp_clock_getcaps(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_clock_caps caps = {
+		.max_adj		= ptp->info->max_adj,
+		.n_alarm		= ptp->info->n_alarm,
+		.n_ext_ts		= ptp->info->n_ext_ts,
+		.n_per_out		= ptp->info->n_per_out,
+		.pps			= ptp->info->pps,
+		.n_pins			= ptp->info->n_pins,
+		.cross_timestamping	= ptp->info->getcrosststamp != NULL,
+		.adjust_phase		= ptp->info->adjphase != NULL &&
+					  ptp->info->getmaxphase != NULL,
+	};
+
+	if (caps.adjust_phase)
+		caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
+
+	return copy_to_user(arg, &caps, sizeof(caps)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -171,37 +191,22 @@ long ptp_ioctl(struct posix_clock_contex
 	struct timestamp_event_queue *tsevq;
 	struct ptp_system_timestamp sts;
 	struct ptp_clock_request req;
-	struct ptp_clock_caps caps;
 	struct ptp_clock_time *pct;
 	struct ptp_pin_desc pd;
 	struct timespec64 ts;
 	int enable, err = 0;
+	void __user *argptr;
 
 	if (in_compat_syscall() && cmd != PTP_ENABLE_PPS && cmd != PTP_ENABLE_PPS2)
 		arg = (unsigned long)compat_ptr(arg);
+	argptr = (void __force __user *)arg;
 
 	tsevq = pccontext->private_clkdata;
 
 	switch (cmd) {
-
 	case PTP_CLOCK_GETCAPS:
 	case PTP_CLOCK_GETCAPS2:
-		memset(&caps, 0, sizeof(caps));
-
-		caps.max_adj = ptp->info->max_adj;
-		caps.n_alarm = ptp->info->n_alarm;
-		caps.n_ext_ts = ptp->info->n_ext_ts;
-		caps.n_per_out = ptp->info->n_per_out;
-		caps.pps = ptp->info->pps;
-		caps.n_pins = ptp->info->n_pins;
-		caps.cross_timestamping = ptp->info->getcrosststamp != NULL;
-		caps.adjust_phase = ptp->info->adjphase != NULL &&
-				    ptp->info->getmaxphase != NULL;
-		if (caps.adjust_phase)
-			caps.max_phase_adj = ptp->info->getmaxphase(ptp->info);
-		if (copy_to_user((void __user *)arg, &caps, sizeof(caps)))
-			err = -EFAULT;
-		break;
+		return ptp_clock_getcaps(ptp, argptr);
 
 	case PTP_EXTTS_REQUEST:
 	case PTP_EXTTS_REQUEST2:


