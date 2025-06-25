Return-Path: <netdev+bounces-201107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C7AE820B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35B37188E05E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7298D2620D6;
	Wed, 25 Jun 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BXywzjha";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wt1cIeuN"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54882609EC;
	Wed, 25 Jun 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852355; cv=none; b=mxedlT7xgdzjk1wEF9XX8umG+MDXEbKlvwoEtSnCt0XvPBDSVniu+tTO9KjlbiIoYuDvn7VoPg4TrRrH7qCean/xdx5k5DLhWK42wvLh5PbGK+0qxu2pxoE3yhp3zGZHVEbeF6iQIXQDKeK4Ir9o00UdUtDBGisQmYOfSjrgUgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852355; c=relaxed/simple;
	bh=jYZGG7mqo1rf8Y1Sc/mioF8/kFsgOyaM+rXTOB6rgws=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rLIDey7VRSY/LbgY2HtdydkxYqM7dPzrtr/69JPMGP4rMDjWMFjMByGNcWmZ7UFILtTkKUt8GkTPoDKXRPZjij9L/HYmlj3BzXdvZIvvZ/ir5cuPxq0eoid76jS8V5jeiN/9AqhkBynwqOv9vVoHsQNFQD/DCG+119EjN7q7G9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BXywzjha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wt1cIeuN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.113841216@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/hOaEijTFNyeTZSw4CEZK0YexuuthEWLb2xxAoWy0AM=;
	b=BXywzjha6ZAu4ey7S1Xw5wvqQqZF41czEON+srTQ6W4Lh8NT949edV3GIYn5Lan0E1GYA6
	aqdpk4VXELM3ubStlAwNsyx7y1gtoQ4GzK4oOgFASfssdPl6U2yno5A17C/vUFwFdnONfp
	gMgJAgqnUz9oXYsj4Vz3jc1NqEKo8Fu/uN1Wrx5X0hpsn835TJ0be6dZKfrwW/sKiTBJRe
	xW9IgLHwJhF8QBXiUd13yuBx0jILa1wTszTW0Got/ZXiWfW7rmREAQXAJk39GiZ2q/12zd
	/sfZpDbHAKRLshCYPfCOfX12u6fP/aD0AjWSCOr6t+H+CBD/5O3MBw8YmKuzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=/hOaEijTFNyeTZSw4CEZK0YexuuthEWLb2xxAoWy0AM=;
	b=wt1cIeuNqBLHGLDO/O92M6qyGQ5Zmt11sLlydscIKwJ1JqR9M1XnqZq8E/L4z2P1BI295A
	zLgLcSRk0TN6yWBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 07/13] ptp: Split out PTP_SYS_OFFSET ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:31 +0200 (CEST)

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
 




