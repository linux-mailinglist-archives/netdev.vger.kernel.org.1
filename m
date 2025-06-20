Return-Path: <netdev+bounces-199767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BBAAE1C1D
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0BED7B2AFB
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E229B77E;
	Fri, 20 Jun 2025 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzac/RqN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAkhMb17"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6EF29ACD7;
	Fri, 20 Jun 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425884; cv=none; b=dwFO+r3E5RMl/fcEPayHxQSEpHxf53bTriDLdzJGJXRg1NK5nwWwjK+/NcsJiJQtw5cHjrA6b14RBJaLJ3K+XVm4/WMqbDhpJ9n0FT47pBForM66GXJZhsSKHwH3TFVGdy/1bJ7QWUICMsuiSEvshIukUsi5mQEMzTG4sQ0NVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425884; c=relaxed/simple;
	bh=pwHkcg0BdO/LmL5gPnGWlPVjKgswFctmj4N0zMzEQ10=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pir33ekE/63EorVdSdcZ3rmE15OUG3Z/fAe93knHqNr32xedDjZEn8/H+jYIMiUPOySE+NYqfLhcmXiVHcvBpF/6ez8BfXKp7845xyJNDxIIAzNpv/tbeSQlvyL4Wze4bEZ9nHd+6lBdFJLtDTGYE8mOvZfOOqMSknNkGgntFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzac/RqN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAkhMb17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.218487429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S7Rzox5+/xP/z1rX7Tz/4GkdNBghtSktOAWf0UIesXo=;
	b=hzac/RqNUxREhaCMsFzNBneuK0Cnh6/BeWRNFEkO5rLpPpnfOmNVt4iFO5t/VTHIAiTG5m
	yARpsCijYjktvagmB/ZG3OD33ZEnlEg8G2MYoKBrzoHsWNp1MphEAH1MJAA0EDSHkOUzE0
	IPIKz5IpKZ4VgNkq51ka5KH5ygGqQzYMWnjxzaf7ZXymlcJBeDy4+kKc3qby//U4xCOqJB
	rmQb52PjTE+gsDkrA/9PSV9JkKqWouifYTzZe09Xsjcboj9S9fnznzW+zX3IyqqKn2a8zf
	fEuB2tqH97hZr633LAY2rsLdESjl4Z59R0G9aAu2LPTmA2djoqsYF+XEf69Uzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=S7Rzox5+/xP/z1rX7Tz/4GkdNBghtSktOAWf0UIesXo=;
	b=hAkhMb17uKgJanPkN/jorDyOauVAFGvczg5ZFGHRTJIXeD5xpPLHaRU7hNSzyuh8CT19sC
	8ACqK4YyhB0T2MCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:40 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_GETFUNC ioctl
code into a helper function. Convert to lock guard while at it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   52 ++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -396,6 +396,28 @@ static long ptp_sys_offset(struct ptp_cl
 	return copy_to_user(arg, sysoff, sizeof(*sysoff)) ? -EFAULT : 0;
 }
 
+static long ptp_pin_getfunc(struct ptp_clock *ptp, unsigned int cmd, void __user *arg)
+{
+	struct ptp_clock_info *ops = ptp->info;
+	struct ptp_pin_desc pd;
+
+	if (copy_from_user(&pd, arg, sizeof(pd)))
+		return -EFAULT;
+
+	if (cmd == PTP_PIN_GETFUNC2 && !mem_is_zero(pd.rsv, sizeof(pd.rsv)))
+		return -EINVAL;
+	else
+		memset(pd.rsv, 0, sizeof(pd.rsv));
+
+	if (pd.index >= ops->n_pins)
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &ptp->pincfg_mux)
+		pd = ops->pin_config[array_index_nospec(pd.index, ops->n_pins)];
+
+	return copy_to_user(arg, &pd, sizeof(pd)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
@@ -451,35 +473,7 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_PIN_GETFUNC:
 	case PTP_PIN_GETFUNC2:
-		if (copy_from_user(&pd, (void __user *)arg, sizeof(pd))) {
-			err = -EFAULT;
-			break;
-		}
-		if ((pd.rsv[0] || pd.rsv[1] || pd.rsv[2]
-				|| pd.rsv[3] || pd.rsv[4])
-			&& cmd == PTP_PIN_GETFUNC2) {
-			err = -EINVAL;
-			break;
-		} else if (cmd == PTP_PIN_GETFUNC) {
-			pd.rsv[0] = 0;
-			pd.rsv[1] = 0;
-			pd.rsv[2] = 0;
-			pd.rsv[3] = 0;
-			pd.rsv[4] = 0;
-		}
-		pin_index = pd.index;
-		if (pin_index >= ops->n_pins) {
-			err = -EINVAL;
-			break;
-		}
-		pin_index = array_index_nospec(pin_index, ops->n_pins);
-		if (mutex_lock_interruptible(&ptp->pincfg_mux))
-			return -ERESTARTSYS;
-		pd = ops->pin_config[pin_index];
-		mutex_unlock(&ptp->pincfg_mux);
-		if (!err && copy_to_user((void __user *)arg, &pd, sizeof(pd)))
-			err = -EFAULT;
-		break;
+		return ptp_pin_getfunc(ptp, cmd, argptr);
 
 	case PTP_PIN_SETFUNC:
 	case PTP_PIN_SETFUNC2:


