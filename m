Return-Path: <netdev+bounces-127379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 699DB97538D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396E51F21293
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE031AB6F6;
	Wed, 11 Sep 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bui4WZRS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5E38U+n8"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E911A3AB3;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060688; cv=none; b=MRslGkBw6C9VpZuG9Uac7preJa2WzRzeW+Ic6UDgzHjpGI8LZcLhX9Dn/HvEhdbd8TkOZZdWSGDLJ6qCyrJr/qB//lvvNyeu7ZqUqYqbyyiZJUKwNeHIiMEWDIvlrHoQRWFBJV0kpukQONIoGURGlL64azINypRDdi9kRXMLSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060688; c=relaxed/simple;
	bh=cg2PM211DmAM8vwNyyfctOBpXOxyEn3IDg9VxjRMYA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mwi2OL3LZ6nuTtECuduQkeupUPnYQ+Zp1J7xZtX+w9ewj2+wbtMcEOVmDld64hPndaLTH3hQyqRXqK6xmgv4ADF6F0drGq+u3H0TGqFffnOZFAyXdeYj+K78hSnFwmtsC9CQ+Vj6iPpxhRKc+L/1nI9KP+daDFACNjToT9NqlZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bui4WZRS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5E38U+n8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI2cVBehM4PSxc5rOEnLQmGjNkeoiI7dtjBCguJbkM0=;
	b=bui4WZRSjaen6LSXlR60ad3uGIxj3a9CJ/f4590OmMxSmHvGAKXYwBWMBRM+zX5NIlw8LB
	+Z14pHB2ipmWz8Dx9lvIRZrbskwPFkxCkiv/hOCG9yRYO3ACJwSRXf01nOHxsSk4z/LRWb
	ijxOz+TzmknjWZCM2KvhaC0g/Y77uiBMxlD8hkdV352M/a9gK+mHvx4MvdfnImHuQICeUC
	vy04SsZgMnScdhXWy96qkUkKCHmU/wZSJxhfgQpU3DD9YdTdzN3sGZiXR24y7nxiD0YKH7
	JxiWhdlo4WwW8g5FvG8fmGiu7O5+gPYJ7bhjDUuGbyUV8o2xGA8fdRT+Ls6uQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WI2cVBehM4PSxc5rOEnLQmGjNkeoiI7dtjBCguJbkM0=;
	b=5E38U+n8OGQsnDRDhQ/VQZJedSZYkMquasple8yZL5aP1SOiXlmzlA0gMRsSSdtHcoLbX2
	n+DE3KOwPx0V4xCg==
Date: Wed, 11 Sep 2024 15:17:57 +0200
Subject: [PATCH 21/21] ntp: Move pps monitors into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-21-2d52f4e13476@linutronix.de>
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

Finalize the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index c3089d8be0f7..a2f57599a815 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -48,6 +48,10 @@
  * @pps_intcnt:		PPS interval counter
  * @pps_freq:		PPS frequency offset in scaled ns/s
  * @pps_stabil:		PPS current stability in scaled ns/s
+ * @pps_calcnt:		PPS monitor: calibration intervals
+ * @pps_jitcnt:		PPS monitor: jitter limit exceeded
+ * @pps_stbcnt:		PPS monitor: stability limit exceeded
+ * @pps_errcnt:		PPS monitor: calibration errors
  *
  * Protected by the timekeeping locks.
  */
@@ -75,6 +79,10 @@ struct ntp_data {
 	int			pps_intcnt;
 	s64			pps_freq;
 	long			pps_stabil;
+	long			pps_calcnt;
+	long			pps_jitcnt;
+	long			pps_stbcnt;
+	long			pps_errcnt;
 #endif
 };
 
@@ -110,15 +118,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-/*
- * PPS signal quality monitors
- */
-static long pps_calcnt;		/* calibration intervals */
-static long pps_jitcnt;		/* jitter limit exceeded */
-static long pps_stbcnt;		/* stability limit exceeded */
-static long pps_errcnt;		/* calibration errors */
-
-
 /*
  * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
@@ -204,10 +203,10 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = ntpdata->pps_shift;
 	txc->stabil	   = ntpdata->pps_stabil;
-	txc->jitcnt	   = pps_jitcnt;
-	txc->calcnt	   = pps_calcnt;
-	txc->errcnt	   = pps_errcnt;
-	txc->stbcnt	   = pps_stbcnt;
+	txc->jitcnt	   = ntpdata->pps_jitcnt;
+	txc->calcnt	   = ntpdata->pps_calcnt;
+	txc->errcnt	   = ntpdata->pps_errcnt;
+	txc->stbcnt	   = ntpdata->pps_stbcnt;
 }
 
 #else /* !CONFIG_NTP_PPS */
@@ -935,7 +934,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << ntpdata->pps_shift)) {
 		ntpdata->time_status |= STA_PPSERROR;
-		pps_errcnt++;
+		ntpdata->pps_errcnt++;
 		pps_dec_freq_interval(ntpdata);
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
 				freq_norm.sec);
@@ -954,7 +953,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
-		pps_stbcnt++;
+		ntpdata->pps_stbcnt++;
 		pps_dec_freq_interval(ntpdata);
 	} else {
 		/* Good sample */
@@ -999,7 +998,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (ntpdata->pps_jitter << PPS_POPCORN));
 		ntpdata->time_status |= STA_PPSJITTER;
-		pps_jitcnt++;
+		ntpdata->pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
 		ntpdata->time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
@@ -1064,7 +1063,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	/* Signal is ok. Check if the current frequency interval is finished */
 	if (freq_norm.sec >= (1 << ntpdata->pps_shift)) {
-		pps_calcnt++;
+		ntpdata->pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		ntpdata->pps_fbase = *raw_ts;
 		hardpps_update_freq(ntpdata, freq_norm);

-- 
2.39.2


