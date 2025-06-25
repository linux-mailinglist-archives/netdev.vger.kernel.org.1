Return-Path: <netdev+bounces-201108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35776AE820E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE803B8A15
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944BE262FDD;
	Wed, 25 Jun 2025 11:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VUiqsFy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBjUHRoo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AA26159D;
	Wed, 25 Jun 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852356; cv=none; b=FJT04OqAL61yBRa3emcsnN/vTAgOytwUK9jzbGzeOp4fDNczuZ2H27sGQZgGNrsTK8rRRp4F36drivR9LTNDCY+uTrK1yNCBvTFuxglwgt+jKVVL9P/5ahqYwqiX27v6kv7Xe7KEYHfJ317vOHNWUjkWFwOFK2JOSSSi3hYUT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852356; c=relaxed/simple;
	bh=aBO0yiwqqDrK1Gr7ZVbyG/YcR1JfuokI1519l7iiV4g=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q3xnAJxK6B9oX6DhY3g38sAhW845sVER5GzFDFHLQ7gH1RDxpPci9/FCGFOcjSVMGbZzXvFV2Tjsa4/OP1q4/L1jKjtcFP601CsDldY9oOILX7RkknBUzfMUc/N9hhIonoI0kKgVGVFuxbgOh4RCUWwlbz0hr4q05L5TrB/P9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3VUiqsFy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBjUHRoo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.177265865@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vyYL15Pqf1jOxKAOIO67JsDvb3ZysXZmUrK/s07exX8=;
	b=3VUiqsFyheIGMtxEuA3LAN5ZfJ9is8Fp87WRdFZRvPtv8ZArmtIuMcnbV/kcN7xgD69/Vc
	TMns+3sDo7NJ2l+JW7YP4RPdoQ63C/Z2QCYZ7bqy951MNjFTkOKQp+esu9IUHKF1SS4a90
	DpdRlJSzvEOOH8hEdmF3w0dZw195xk0nPsM/QFCoUUBxEOq/Rthm57i2TB1LpnnyjkMKAO
	VAii3OYOrHsis18ChPtyrJaj2vyK3DnqzrcMkQTZMe7boiYHl00waR61N+r+Wm0DFywWRG
	mWGkBSqmLZf3Juw3EBknIH9mWvLLk95lXWqbX1VhK948vpcNHLZeKAkCW7Pvqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vyYL15Pqf1jOxKAOIO67JsDvb3ZysXZmUrK/s07exX8=;
	b=eBjUHRooJylTWyYzxARhV8N1YXpow6h36ywJnbiBF/5ku6I4U7tPSx5znL839kkggHLTeb
	GcXomi1CJ6SZoAAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 08/13] ptp: Split out PTP_PIN_GETFUNC ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:33 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_PIN_GETFUNC ioctl
code into a helper function. Convert to lock guard while at it and remove
the pointless memset of the pd::rsv because nothing uses it.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
V2: Remove the pointless memset() - Paolo
---
 drivers/ptp/ptp_chardev.c |   50 +++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -395,6 +395,26 @@ static long ptp_sys_offset(struct ptp_cl
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
@@ -450,35 +470,7 @@ long ptp_ioctl(struct posix_clock_contex
 
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


