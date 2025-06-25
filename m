Return-Path: <netdev+bounces-201105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F46AAE820A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BEE17B490
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C61260591;
	Wed, 25 Jun 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nv9nEMcJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ydel79pa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EE25F99B;
	Wed, 25 Jun 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852353; cv=none; b=C43BlyxdeXfNAid4aHrlUW2PqoHS5SEllfcKsqY0G1cSMBMJzqYWYRvbl4mCPrNm+3ys3GeVuUJmARZePXpS9XpwQnNjEg/p2nDAZ4qAKcsl2lN9VvRx1vt/6esvntgp+xaGAZMYBvtXUSXjWIzM8X9pn7zJVvtaPJZrCil7mDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852353; c=relaxed/simple;
	bh=OlcBURmnOZ7Wm6QgeJHHqC0dvYkyADt5D3/ByWIfAzU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fZXA72hvVIks0MsBtJMj3AxqMiWX+dx+u0sLrkTjgRbOrUB287UMFRCwZDLDcnAo1SbfAyNxnsh+tDsRyvg1/ZujQUUb/CexeRXXd+iBUC3745N0jT5K+smnw+DomwL/h6I30WsBC72TRIyRHwcCsMEeLatfq5LXPWuprpRsXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nv9nEMcJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ydel79pa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625115132.986897454@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750852349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nhKOrGfB73BiNutvGLZueBH6XZjw/8/Cqht1KLT2faI=;
	b=Nv9nEMcJpFrtpzIojo2/M+tkNYGxyfkqyGknAeVHqR/1gZ+dMZXB3rPSsoqCVoKeYYEhab
	IpV+qX8LmJe2CTrT49aTRu40TTHU2X3D8DI7wQBKZhw0MnQEimsjw6t7TF20KNICtakqzr
	9nOQ9CuiOvN0XIlfpyBJbX0gHz3ZTMKj5otCh0ChTQtU6PEynAjptv7oGWxhrUb8oCoODH
	4+oxbqQzCxJDADJQJWA7xC0Xy0EbHzsGUeP7gHunb3CogoRJSbbkcPpzenGqv3JgeRyE1K
	KLbIS+SBME59Zz7ezf/c93E6bQn3FbQx+rk09l9/S0P5wVAh3SfVzuvxDMnZ7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750852349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=nhKOrGfB73BiNutvGLZueBH6XZjw/8/Cqht1KLT2faI=;
	b=Ydel79pazJ0L6V1TLpd8Sz55RRC8T/3hck+q5y07duXEZKBcnlijivB/niCSYufp1dzDhj
	D8lSMR8jE56ylzBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [patch V2 05/13] ptp: Split out PTP_SYS_OFFSET_PRECISE ioctl code
References: <20250625114404.102196103@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 13:52:29 +0200 (CEST)

Continue the ptp_ioctl() cleanup by splitting out the PTP_SYS_OFFSET_PRECISE
ioctl code into a helper function.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

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




