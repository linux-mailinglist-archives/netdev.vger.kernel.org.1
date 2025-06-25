Return-Path: <netdev+bounces-201106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78160AE8209
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B261BC4E3D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9F26156B;
	Wed, 25 Jun 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JD6Tgimq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P4WlgmBK"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B026057D;
	Wed, 25 Jun 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852354; cv=none; b=tg+rGlDV63hzqebhFOXMLxOm9ouoYainmRm/YD5VT7PivOlbn4xjTVu+MK2yCC6YhoBGh2hFlQ8K6m7SYWKgBhERCMjk+NR1HoKR//tsamBrLis0+V8mUxOfWAA5/DXkV8ko8rJuy78rvVxHMArkseQOvuT623bVk9MA1FYhF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852354; c=relaxed/simple;
	bh=xWqROYVU4TynHuYh4aGkvMPabj/Oa5v3QXwWpIcyvdA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FOazcsVWjpfL8tr3EW5qQkg+CMZgucm8vxtz2SKSDKRQkEjXB3o0ibB2mgg4QhBvZT15STcLXgfEaxKWRyCp/nZwsDCRH5a0bcf3SxBnuY4HmfZGuDaE1j4xGCgA9sLfDgrxt44WdOu8k+NihWfaI9Sr4PcBflnEpgVXkY4BhhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JD6Tgimq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P4WlgmBK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115133.050445505@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=27YxVW+aF7eR9SHjcEuEjGJaTFvGFs8Gy18WXbaN/7Y=;
	b=JD6TgimqmI/bAx/eSPDvV4cwv8+61oRmd1MDyowg/sNVBAMeo2pSByM5nbcSvliasa3hTM
	xPmUE9YDHZRCwh1+Z72TM247StRyIlveyNyx213P3mWrdwqN41+czvw7T9eyWrj6mZhgwN
	oQY6tI6WERND+iw/bCqkXPDFOsa0CSnTmrrEu9Mvqzuoy7Rv9j/kynQWL+Cm3yG7m5yxoc
	NvsdzXwpS2kOsgA+L6mF1JsYAu5D4MKyC/AQ+gHZR9Isjn3V1LQ5117Z7M748J9paJ8+oD
	6SJfsZRZ4RS/2H2AfcTKpjOvPblex1+sfTUvKJtMMCArVNzZbzb3XUKk8Pb5VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=27YxVW+aF7eR9SHjcEuEjGJaTFvGFs8Gy18WXbaN/7Y=;
	b=P4WlgmBKGR6EEE4z5oHJyMrP43SSjtt7ns3vPsLwyKxbU9mgLV8VWFkZdr51EogZUDgkxz
	HDpTV5iomT0HUGCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 06/13] ptp: Split out PTP_SYS_OFFSET_EXTENDED ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:30 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the
PTP_SYS_OFFSET_EXTENDED ioctl code into a helper function.

Convert it to __free() to avoid gotos.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

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




