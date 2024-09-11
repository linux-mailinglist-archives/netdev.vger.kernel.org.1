Return-Path: <netdev+bounces-127372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89824975382
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AF4280EE9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718171A4B84;
	Wed, 11 Sep 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aq+b+vgQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNRKCCkB"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459919F124;
	Wed, 11 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060686; cv=none; b=eDrVAmDil0XnVSN5AyMuVvxFdNrMRHSXL8xgv9y/C38qjeJXL5BtGH/i12kDXK7an+b7J/SXHRBNdjpb0FgDH+GrCk8hzB4mpoyick+mC0by5sJ3vYIrCgp7c+egio9U+EMq83OIyzUFZWmxsyk1oxnYS1G02BQXh+gT3V18Xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060686; c=relaxed/simple;
	bh=rrH2HOeGNlvk94ShHjgd4MvbCcMR04y0tGNHaHGvSAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Co9ubJdBzc+NxcwNRF4l8jum6fx3zljykVCxTGrqc1N4HKr8ZLpg1jYKnoUR25qntWTH9ygTmXJYV/O46lKHli+1EJZOMwdKcCwxNbk9TQisbdiYKoTwpSHmAtTeTmi9qTZQn3R7qPr83c7HL2Mx2J+WItU5HrrAy8nZXWNICxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aq+b+vgQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNRKCCkB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J13jbXKjKQTFx7S8usEk2kQMsr0CFAC0l+gr2iTtBHQ=;
	b=aq+b+vgQR9v9vCSD8NLDa6PyxhIVIT6lsJBC2YO1LdqvqTAke/lG8TpwlRAIMiwu3QC3wz
	cQkM9OhY+83LwgO5Bvjo+22QSL2Gxr9DxRFeAiDZSkcpPYMXM+l2O6zdbRc9oWlVUYj7UU
	RlY7XjuS1bKZtTp/gM35LCnJedOEA5efPeu4JxacFpRIpPduPk8VY/BiM/5/puOv2tGHAm
	wiLocnCZDgtObMIM6SemT5cGWZhuSEPynxNjW+nLpKhOC9D14Yqn0BwgcKwZIXgJIaeHf0
	8dVLXDlGA/Yl/viVurRhrOIxlBfHNDbQ686kTwi7XIW70BOc46otg/qVLmyixA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J13jbXKjKQTFx7S8usEk2kQMsr0CFAC0l+gr2iTtBHQ=;
	b=fNRKCCkBkCRMFhlaukbGh1xUQg4vxmKZqhPjwgZvz7jbvTvDG3a3h3P32AJs2pJ+Qyc0S5
	IBlhHzrD/VxjuxDA==
Date: Wed, 11 Sep 2024 15:17:50 +0200
Subject: [PATCH 14/21] ntp: Move ntp_next_leap_sec into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-14-2d52f4e13476@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 3897f1e79d8d..33d52b9dbff6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -38,6 +38,7 @@
  * @time_reftime:	Time at last adjustment in seconds
  * @time_adjust:	Adjustment value
  * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
+ * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
  * Protected by the timekeeping locks.
  */
@@ -55,6 +56,7 @@ struct ntp_data {
 	time64_t		time_reftime;
 	long			time_adjust;
 	s64			ntp_tick_adj;
+	time64_t		ntp_next_leap_sec;
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -64,6 +66,7 @@ static struct ntp_data tk_ntp_data = {
 	.time_constant		= 2,
 	.time_maxerror		= NTP_PHASE_LIMIT,
 	.time_esterror		= NTP_PHASE_LIMIT,
+	.ntp_next_leap_sec	= TIME64_MAX,
 };
 
 #define SECS_PER_DAY		86400
@@ -72,9 +75,6 @@ static struct ntp_data tk_ntp_data = {
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
 #define MAX_TAI_OFFSET		100000
 
-/* second value of the next pending leapsecond, or TIME64_MAX if no leap */
-static time64_t			ntp_next_leap_sec = TIME64_MAX;
-
 #ifdef CONFIG_NTP_PPS
 
 /*
@@ -331,7 +331,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 	ntpdata->tick_length	= ntpdata->tick_length_base;
 	ntpdata->time_offset	= 0;
 
-	ntp_next_leap_sec = TIME64_MAX;
+	ntpdata->ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
 	pps_clear();
 }
@@ -362,7 +362,7 @@ ktime_t ntp_get_next_leap(void)
 	ktime_t ret;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
-		return ktime_set(ntp_next_leap_sec, 0);
+		return ktime_set(ntpdata->ntp_next_leap_sec, 0);
 	ret = KTIME_MAX;
 	return ret;
 }
@@ -394,18 +394,18 @@ int second_overflow(time64_t secs)
 		if (ntpdata->time_status & STA_INS) {
 			ntpdata->time_state = TIME_INS;
 			div_s64_rem(secs, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
+			ntpdata->ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		} else if (ntpdata->time_status & STA_DEL) {
 			ntpdata->time_state = TIME_DEL;
 			div_s64_rem(secs + 1, SECS_PER_DAY, &rem);
-			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
+			ntpdata->ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		}
 		break;
 	case TIME_INS:
 		if (!(ntpdata->time_status & STA_INS)) {
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_OK;
-		} else if (secs == ntp_next_leap_sec) {
+		} else if (secs == ntpdata->ntp_next_leap_sec) {
 			leap = -1;
 			ntpdata->time_state = TIME_OOP;
 			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
@@ -413,17 +413,17 @@ int second_overflow(time64_t secs)
 		break;
 	case TIME_DEL:
 		if (!(ntpdata->time_status & STA_DEL)) {
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_OK;
-		} else if (secs == ntp_next_leap_sec) {
+		} else if (secs == ntpdata->ntp_next_leap_sec) {
 			leap = 1;
-			ntp_next_leap_sec = TIME64_MAX;
+			ntpdata->ntp_next_leap_sec = TIME64_MAX;
 			ntpdata->time_state = TIME_WAIT;
 			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
-		ntp_next_leap_sec = TIME64_MAX;
+		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		ntpdata->time_state = TIME_WAIT;
 		break;
 	case TIME_WAIT:
@@ -675,7 +675,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 	if ((ntpdata->time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		ntpdata->time_state = TIME_OK;
 		ntpdata->time_status = STA_UNSYNC;
-		ntp_next_leap_sec = TIME64_MAX;
+		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
 	}
@@ -807,7 +807,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
 
 	/* Handle leapsec adjustments */
-	if (unlikely(ts->tv_sec >= ntp_next_leap_sec)) {
+	if (unlikely(ts->tv_sec >= ntpdata->ntp_next_leap_sec)) {
 		if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS)) {
 			result = TIME_OOP;
 			txc->tai++;
@@ -818,7 +818,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntp_next_leap_sec))
+		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntpdata->ntp_next_leap_sec))
 			result = TIME_WAIT;
 	}
 

-- 
2.39.2


