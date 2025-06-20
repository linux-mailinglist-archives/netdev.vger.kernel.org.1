Return-Path: <netdev+bounces-199765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6D1AE1C15
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021971C20C23
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A129A9D3;
	Fri, 20 Jun 2025 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qs+Wxhtj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ml1BaYsV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F928C857;
	Fri, 20 Jun 2025 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425881; cv=none; b=mdW5o/SsTDS1vxcWz/6DbitDFNZ85RQGGW4mjnvhcZXSbUQkE0wJQfEu/FpBZ9apuKQiwWVnzKnEfHUoarWKEp3zfAZcJMS2kjXMjDTCOJp8aLk67CpmqewTJ7s72y7vZAU34E6Sb0mCSjmq6sqEmQKN9T7gh0ZTRsw/5RlC0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425881; c=relaxed/simple;
	bh=Do/szley7fS/q5nwVmGhJRdXAL6MgHPbPBiQzYJOmOM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GDjIfYZq6qoenp8/9YAjVmNHejcgHDnqsA4SvxeEHqDqcwzYL8n3J+sfJ6tmW+lyxUdn0ou3FAr4O1tHWr3cHygx71FFE+nPb+Xt9YOvfG4j9eNOlXiOJtppfINnvuHhzp4jfVHDxIj0jLlGet0CFNcxpRnPaam3+8Yc4+j/ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qs+Wxhtj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ml1BaYsV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.092766931@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ps+B3mXPi6bAdX/VWvyVREKmEuPvI5a2EtOj9giLmZs=;
	b=qs+WxhtjTToGMC1yaudWfiA+CoHvAf5VEp/bYOboRuLAVmpVYNfozXOWj3pK3AtXvaMjlm
	u4hdUymgAxFbfPPiqnFRjJir+9nT3RZdCjoSG1r3tCAaL81EvIec/sodkzwBiqZMrCz07M
	E3Pa8Vpa+RLmcC07Yp7GS5EsisfN/WvMnuJ8cEdhP49nA/jlrUtaT/T/jB7j1m055uyAxy
	Y+53lyWrC3VDVWvQ6/puYCDfqaNzHoW3w3iKKBk032F514AqPPa9fAB2ObtAZNvLPKsMkO
	oNioq4SapZZJEZcBb78nTzmtg3RzxITl7/ExJuq+tqEIul57g/cxs5h6YMOnBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Ps+B3mXPi6bAdX/VWvyVREKmEuPvI5a2EtOj9giLmZs=;
	b=Ml1BaYsV8lnN1iphMdag2XASenaQEN4FOpvJWn1C9YZalkpZ1vSoShYUgFnEdmWnjaGKhC
	2JlpOdDv/EXgOPCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 06/13] ptp: Split out PTP_SYS_OFFSET_EXTENDED ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:36 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the
PTP_SYS_OFFSET_EXTENDED ioctl code into a helper function.

Convert it to __free() to avoid gotos.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   75 +++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -319,16 +319,52 @@ static long ptp_sys_offset_precise(struc
 	return copy_to_user(arg, &precise_offset, sizeof(precise_offset)) ? -EFAULT : 0;
 }
 
+static long ptp_sys_offset_extended(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_extended *extoff __free(kfree) = NULL;
+	struct ptp_system_timestamp sts;
+
+	if (!ptp->info->gettimex64)
+		return -EOPNOTSUPP;
+
+	extoff = memdup_user(arg, sizeof(*extoff));
+	if (IS_ERR(extoff))
+		return PTR_ERR(extoff);
+
+	if (extoff->n_samples > PTP_MAX_SAMPLES ||
+	    extoff->rsv[0] || extoff->rsv[1] ||
+	    (extoff->clockid != CLOCK_REALTIME &&
+	     extoff->clockid != CLOCK_MONOTONIC &&
+	     extoff->clockid != CLOCK_MONOTONIC_RAW))
+		return -EINVAL;
+
+	sts.clockid = extoff->clockid;
+	for (unsigned int i = 0; i < extoff->n_samples; i++) {
+		struct timespec64 ts;
+		int err;
+
+		err = ptp->info->gettimex64(ptp->info, &ts, &sts);
+		if (err)
+			return err;
+		extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
+		extoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
+		extoff->ts[i][1].sec = ts.tv_sec;
+		extoff->ts[i][1].nsec = ts.tv_nsec;
+		extoff->ts[i][2].sec = sts.post_ts.tv_sec;
+		extoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
+	}
+
+	return copy_to_user(arg, extoff, sizeof(*extoff)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
-	struct ptp_sys_offset_extended *extoff = NULL;
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_sys_offset *sysoff = NULL;
 	struct timestamp_event_queue *tsevq;
-	struct ptp_system_timestamp sts;
 	struct ptp_clock_time *pct;
 	unsigned int i, pin_index;
 	struct ptp_pin_desc pd;
@@ -371,39 +407,7 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:
-		if (!ptp->info->gettimex64) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-		extoff = memdup_user((void __user *)arg, sizeof(*extoff));
-		if (IS_ERR(extoff)) {
-			err = PTR_ERR(extoff);
-			extoff = NULL;
-			break;
-		}
-		if (extoff->n_samples > PTP_MAX_SAMPLES ||
-		    extoff->rsv[0] || extoff->rsv[1] ||
-		    (extoff->clockid != CLOCK_REALTIME &&
-		     extoff->clockid != CLOCK_MONOTONIC &&
-		     extoff->clockid != CLOCK_MONOTONIC_RAW)) {
-			err = -EINVAL;
-			break;
-		}
-		sts.clockid = extoff->clockid;
-		for (i = 0; i < extoff->n_samples; i++) {
-			err = ptp->info->gettimex64(ptp->info, &ts, &sts);
-			if (err)
-				goto out;
-			extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
-			extoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
-			extoff->ts[i][1].sec = ts.tv_sec;
-			extoff->ts[i][1].nsec = ts.tv_nsec;
-			extoff->ts[i][2].sec = sts.post_ts.tv_sec;
-			extoff->ts[i][2].nsec = sts.post_ts.tv_nsec;
-		}
-		if (copy_to_user((void __user *)arg, extoff, sizeof(*extoff)))
-			err = -EFAULT;
-		break;
+		return ptp_sys_offset_extended(ptp, argptr);
 
 	case PTP_SYS_OFFSET:
 	case PTP_SYS_OFFSET2:
@@ -528,7 +532,6 @@ long ptp_ioctl(struct posix_clock_contex
 	}
 
 out:
-	kfree(extoff);
 	kfree(sysoff);
 	return err;
 }


