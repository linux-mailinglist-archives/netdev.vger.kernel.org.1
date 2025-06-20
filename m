Return-Path: <netdev+bounces-199764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EEAE1C13
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DFC17388C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66D2980BF;
	Fri, 20 Jun 2025 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hq78WkkP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WcxgTl0N"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083B2949F1;
	Fri, 20 Jun 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425878; cv=none; b=OgKatmTiuuWPErPRDOHclLUeJwCBKxbyJxXNCSbAjPjU46cNHtGSpKdly7kIMXhNVd2mG9QZsd/h3yAHRsfkyh2mN+LVL9dud1XHgRhi3fJwS97F3PFyy0I62nCZsvF5Wz+ORIRJ+TiM9BZXyhkor2h3QCbkNW7FwWrxNZdjXmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425878; c=relaxed/simple;
	bh=NC51TTMY8nxd0DctA58uSZUFQbFQHQ5MFBFjo4Eq+5M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=XkX4nidQK6WelOeTqP0119ZY0kgxpUNL+gHg3bUio6KxPgm5k63azwVmTjpmjJavIe9o+xOJEi3PpjmVAIcZfhLpnF9Ptmf5E7RP5sT7NGkk3gf0ajU946KZp99hRr5nInOhkmMyQ1aqZXGcVw5anSsv3kM1yfADnOJ1pHG0DJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hq78WkkP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WcxgTl0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250620131944.029142425@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750425875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QH7kIDL5N6aeykFRlvUbUloVqPiTRJHBYLpkOQpllVo=;
	b=hq78WkkPMIBpFsZ9kcNZmJv4aklR9uzP+BYDoNQfFOVm11ffwqdCc4uNz7QOb5hM0GzX1l
	MDwWhTidHnb2NTVnud0qrXJm1BSg/6mkRnyjwi3g/lRtiZRzsFWdpfSCfPbnDkJyW9iLNt
	zW21zmuJgJ7dQ+dFdy+4aK/vcfZQJuyWybrWxYIUEy02n7MHKBw/IwZ+N317iwYl5D6ThH
	RWH0tnilRec0b3cdFpc9cjaFIVZ5/eX67XNngVHyj0luUYac4Bwxv+INfbf79WcmXQO4bg
	IA3UUjoInsOk3iddmaZNQFqLtv7HainAxhFNY2hJN3gOz+jEBF5pwTQw421R2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750425875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=QH7kIDL5N6aeykFRlvUbUloVqPiTRJHBYLpkOQpllVo=;
	b=WcxgTl0NOIkQYI4PAT9NrSvE/BZ+yWiNkkSunEE/sM1wn2W/+Lq1R9Z7htla0wgaPNE92k
	jVDO97mwfINM8rDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org
Subject: [patch 05/13] ptp: Split out PTP_SYS_OFFSET_PRECISE ioctl code
References: <20250620130144.351492917@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Jun 2025 15:24:34 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_SYS_OFFSET_PRECISE
ioctl code into a helper function.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/ptp/ptp_chardev.c |   53 +++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -291,14 +291,40 @@ static long ptp_enable_pps(struct ptp_cl
 		return ops->enable(ops, &req, enable);
 }
 
+static long ptp_sys_offset_precise(struct ptp_clock *ptp, void __user *arg)
+{
+	struct ptp_sys_offset_precise precise_offset;
+	struct system_device_crosststamp xtstamp;
+	struct timespec64 ts;
+	int err;
+
+	if (!ptp->info->getcrosststamp)
+		return -EOPNOTSUPP;
+
+	err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
+	if (err)
+		return err;
+
+	memset(&precise_offset, 0, sizeof(precise_offset));
+	ts = ktime_to_timespec64(xtstamp.device);
+	precise_offset.device.sec = ts.tv_sec;
+	precise_offset.device.nsec = ts.tv_nsec;
+	ts = ktime_to_timespec64(xtstamp.sys_realtime);
+	precise_offset.sys_realtime.sec = ts.tv_sec;
+	precise_offset.sys_realtime.nsec = ts.tv_nsec;
+	ts = ktime_to_timespec64(xtstamp.sys_monoraw);
+	precise_offset.sys_monoraw.sec = ts.tv_sec;
+	precise_offset.sys_monoraw.nsec = ts.tv_nsec;
+
+	return copy_to_user(arg, &precise_offset, sizeof(precise_offset)) ? -EFAULT : 0;
+}
+
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg)
 {
 	struct ptp_clock *ptp =
 		container_of(pccontext->clk, struct ptp_clock, clock);
 	struct ptp_sys_offset_extended *extoff = NULL;
-	struct ptp_sys_offset_precise precise_offset;
-	struct system_device_crosststamp xtstamp;
 	struct ptp_clock_info *ops = ptp->info;
 	struct ptp_sys_offset *sysoff = NULL;
 	struct timestamp_event_queue *tsevq;
@@ -341,28 +367,7 @@ long ptp_ioctl(struct posix_clock_contex
 
 	case PTP_SYS_OFFSET_PRECISE:
 	case PTP_SYS_OFFSET_PRECISE2:
-		if (!ptp->info->getcrosststamp) {
-			err = -EOPNOTSUPP;
-			break;
-		}
-		err = ptp->info->getcrosststamp(ptp->info, &xtstamp);
-		if (err)
-			break;
-
-		memset(&precise_offset, 0, sizeof(precise_offset));
-		ts = ktime_to_timespec64(xtstamp.device);
-		precise_offset.device.sec = ts.tv_sec;
-		precise_offset.device.nsec = ts.tv_nsec;
-		ts = ktime_to_timespec64(xtstamp.sys_realtime);
-		precise_offset.sys_realtime.sec = ts.tv_sec;
-		precise_offset.sys_realtime.nsec = ts.tv_nsec;
-		ts = ktime_to_timespec64(xtstamp.sys_monoraw);
-		precise_offset.sys_monoraw.sec = ts.tv_sec;
-		precise_offset.sys_monoraw.nsec = ts.tv_nsec;
-		if (copy_to_user((void __user *)arg, &precise_offset,
-				 sizeof(precise_offset)))
-			err = -EFAULT;
-		break;
+		return ptp_sys_offset_precise(ptp, argptr);
 
 	case PTP_SYS_OFFSET_EXTENDED:
 	case PTP_SYS_OFFSET_EXTENDED2:


