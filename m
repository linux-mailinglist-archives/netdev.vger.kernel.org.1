Return-Path: <netdev+bounces-199766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95218AE1C17
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077471C20DA4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B5B29ACF1;
	Fri, 20 Jun 2025 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rglsplcu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zD5xR9+G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A29AB12;
	Fri, 20 Jun 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425883; cv=none; b=JrzbetWkLhOZinEXy0uAOtTm0G3JA8zpXs5ruVvTeJDnkT8wQz+3d2ecgOjbgEsJKmv/qta49xso/vntxuwD46dXlavtAOYtgXrebHA9CE+l0I4p99l/SI9zgxtv9oloTGxSIhV/Gr1ohhaY3rZPTDgy9lRlDZrtnYlpZisuGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425883; c=relaxed/simple;
	bh=Me9eENgU3jcYNbw/PY4B+DVhSWzqX+uaPlTRAhxu/AA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=t1k+TyiY+qX8O/ec7icUGrV1NbM5dJ+9viCZklpTa4ikPEQUrOtrD4may0IJDzjXF3yETQWGqk2kW201UYAoRkdNo++J0C3Heo922aZ2cy4/sr9gLKDlFrPpXwy/WxK66bBpcvEmHc+SPl3YqeB5OGL6uL5eQ3ar9SdSMUW1MRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rglsplcu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zD5xR9+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.156514985@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=cSbxmWR8L1/Rl4GA/fXKJwWZqfPiyvAnjSZcYEHQJHs=;
	b=RglsplcuUMdO1xUyWmErmw25JiH0C03syk2dtCuLmhPd4sBeo7a6QlnI073BV0DJ3ntjPD
	a+TN71ZyTHkA5qf8maH6DgPZfOPpH9medhIzmuAOVBN9EAFP7/vqiV8YdOcAWvvL5rCEty
	jUaqVhIu2IWH5n5oeMpSM8L2hzTmen61kQZEKuFDNLpvHamKtYnCMTLpAgBRtpVUZ1ZvaO
	SqDLgEJuwOZ6rW7tabQsrSR6SjCA1EWJBycRHa9IHpahe9bxizE3WQAgpTW/i3tD9RUQDW
	Nt0bV6ebC7D7vr1CEPZUsDxroc0XsrfLuKtVLVMJ1f+AXlHe651Ji00g17yb7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=cSbxmWR8L1/Rl4GA/fXKJwWZqfPiyvAnjSZcYEHQJHs=;
	b=zD5xR9+Gadp8ju7K+9EwCpzRJSrNDtxXyoTwc88gFKgk/tqhs5yxjAG7rqRpjnXthsUCqK
	11vu8KQp1V+lf9Aw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 07/13] ptp: Split out PTP_SYS_OFFSET ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:38 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_SYS_OFFSET ioctl
code into a helper function.

Convert it to __free() to avoid gotos.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   78 +++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -357,18 +357,54 @@ static long ptp_sys_offset_extended(stru
 	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset *sysoff __free(kfree) = NULL;
+	struct ptp_clock_time *pct;
+	struct timespec64 ts;
+
+	sysoff = memdup_user(arg, sizeof(*sysoff));
+	if (IS_ERR(sysoff))
+		return PTR_ERR(sysoff);
+
+	if (sysoff->n_samples > PTP_MAX_SAMPLES)
+		return -EINVAL;
+
+	pct = &sysoff->ts[0];
+	for (unsigned int i = 0; i < sysoff->n_samples; i++) {
+		struct ptp_clock_info *ops = ptp->info;
+		int err;
+
+		ktime_get_real_ts64(&ts);
+		pct->sec = ts.tv_sec;
+		pct->nsec = ts.tv_nsec;
+		pct++;
+		if (ops->gettimex64)
+			err = ops->gettimex64(ops, &ts, NULL);
+		else
+			err = ops->gettime64(ops, &ts);
+		if (err)
+			return err;
+		pct->sec = ts.tv_sec;
+		pct->nsec = ts.tv_nsec;
+		pct++;
+	}
+	ktime_get_real_ts64(&ts);
+	pct->sec = ts.tv_sec;
+	pct->nsec = ts.tv_nsec;
+
+	return copy_to_user(arg, sysoff, sizeof(*sysoff)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct ptp_clock_info *ops = ptp->info;
-	struct ptp_sys_offset *sysoff = NULL;
 	struct timestamp_event_queue *tsevq;
-	struct ptp_clock_time *pct;
 	unsigned int i, pin_index;
 	struct ptp_pin_desc pd;
-	struct timespec64 ts;
 	void __user *argptr;
 	int err = 0;
 
@@ -411,38 +447,7 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
-		sysoff = memdup_user((void __user *)arg, sizeof(*sysoff));
-		if (IS_ERR(sysoff)) {
-			err = PTR_ERR(sysoff);
-			sysoff = NULL;
-			break;
-		}
-		if (sysoff->n_samples > PTP_MAX_SAMPLES) {
-			err = -EINVAL;
-			break;
-		}
-		pct = &sysoff->ts[0];
-		for (i = 0; i < sysoff->n_samples; i++) {
-			ktime_get_real_ts64(&ts);
-			pct->sec = ts.tv_sec;
-			pct->nsec = ts.tv_nsec;
-			pct++;
-			if (ops->gettimex64)
-				err = ops->gettimex64(ops, &ts, NULL);
-			else
-				err = ops->gettime64(ops, &ts);
-			if (err)
-				goto out;
-			pct->sec = ts.tv_sec;
-			pct->nsec = ts.tv_nsec;
-			pct++;
-		}
-		ktime_get_real_ts64(&ts);
-		pct->sec = ts.tv_sec;
-		pct->nsec = ts.tv_nsec;
-		if (copy_to_user((void __user *)arg, sysoff, sizeof(*sysoff)))
-			err = -EFAULT;
-		break;
+		return ptp_sys_offset(ptp, argptr);
 
 	case PTP_PIN_GETFUNC:
 	case PTP_PIN_GETFUNC2:
@@ -530,9 +535,6 @@ long ptp_ioctl(struct posix_clock_contex
 		err = -ENOTTY;
 		break;
 	}
-
-out:
-	kfree(sysoff);
 	return err;
 }
 


