Return-Path: <netdev+bounces-127374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A435B975385
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2681F21770
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBC190667;
	Wed, 11 Sep 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k5NfIYDF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rOIk4Pm7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4A1A302C;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060687; cv=none; b=R7NQZF9UaURjyzBVYij6Qzqp6keUSUvSPxViXbDiqD3NtvT9EjBXtGWiVt3uHHKcYwCQzcNC/QcgopmOa/qyv7yoaX26knn410d8JdHuYZniZ8bVbS8qufe2GeI1T4u+SvK6TiY7lzuon0889XsjLLHiwUrfS6deKCiHZUtr8KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060687; c=relaxed/simple;
	bh=cO0WwuBORNRr4DJ+2v55yt8Uz/VW8LcRxoPZ1XMRmI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgugQZzFiXbYWW45WKMgbj4cue3Vw6Yzz/KRm+pjop8EdOZoq8zLuWtou2i8SwBp7ZtlAUXgnMgLxJNLzEMEyFktgxMtf7p75QEAnIRgRF6KkaQRgX2ZpJZ3xXtUZG/6kYJjnvVwO8kB6kyuORgKVkj1uEfbrwNilcYHE6wgjTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k5NfIYDF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rOIk4Pm7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nRltMZR0dP0dLpb0fek0WqDhnqEMxFw2mHWlD6JFf4=;
	b=k5NfIYDFWEuE7v2OUawmbqrcy9Ui/yVyoMumpHYAwpJlrJe4s3VaD/jdFWHPMV2wWfVa56
	u/672/hdQlRBHmhpkn9/3zpBmyd6wqdfI3A7mrG6HHX9G1LmCpm2DIwKQwIqlrUEmGuloC
	LlVNZ5hN+f1E6/99PA7+K1YriRvkU5uu8RrhVgjxX+AXtNHBYdxlFKdk7yrETTjrX3zDIo
	WHiteiwTRayxjOI78e7OKR/s9MeEHMzZZTxdBgAc5sum5D9uhF/4Qakz8hKqU5QxO1lCzw
	UvTqkbDCahLHjRQCR9dxsD0OMdftpNZ55/uaWYMGF6p3ynuQJ0+0XNfi8r6eiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nRltMZR0dP0dLpb0fek0WqDhnqEMxFw2mHWlD6JFf4=;
	b=rOIk4Pm7Sr5M5QHl4BH1Z6B8Z+UQRuI9sMP8OFdSAW7lNza5b6XYtpG3OvLSxsjgetwu4g
	zaasA9M4X/NIU6Dg==
Date: Wed, 11 Sep 2024 15:17:54 +0200
Subject: [PATCH 18/21] ntp: Move pps_fbase into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-18-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index dc1e1d5dbd9c..4098c38fbc3f 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -43,6 +43,7 @@
  * @pps_valid:		PPS signal watchdog counter
  * @pps_tf:		PPS phase median filter
  * @pps_jitter:		PPS current jitter in nanoseconds
+ * @pps_fbase:		PPS beginning of the last freq interval
  *
  * Protected by the timekeeping locks.
  */
@@ -65,6 +66,7 @@ struct ntp_data {
 	int			pps_valid;
 	long			pps_tf[3];
 	long			pps_jitter;
+	struct timespec64	pps_fbase;
 #endif
 };
 
@@ -100,7 +102,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
 static int pps_intcnt;		/* interval counter */
 static s64 pps_freq;		/* frequency offset (scaled ns/s) */
@@ -144,7 +145,7 @@ static inline void pps_clear(struct ntp_data *ntpdata)
 	ntpdata->pps_tf[0] = 0;
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
-	pps_fbase.tv_sec = pps_fbase.tv_nsec = 0;
+	ntpdata->pps_fbase.tv_sec = ntpdata->pps_fbase.tv_nsec = 0;
 	pps_freq = 0;
 }
 
@@ -1037,13 +1038,13 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 * When called for the first time, just start the frequency
 	 * interval
 	 */
-	if (unlikely(pps_fbase.tv_sec == 0)) {
-		pps_fbase = *raw_ts;
+	if (unlikely(ntpdata->pps_fbase.tv_sec == 0)) {
+		ntpdata->pps_fbase = *raw_ts;
 		return;
 	}
 
 	/* Ok, now we have a base for frequency calculation */
-	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, pps_fbase));
+	freq_norm = pps_normalize_ts(timespec64_sub(*raw_ts, ntpdata->pps_fbase));
 
 	/*
 	 * Check that the signal is in the range
@@ -1053,7 +1054,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		ntpdata->time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
-		pps_fbase = *raw_ts;
+		ntpdata->pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
@@ -1062,7 +1063,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	if (freq_norm.sec >= (1 << pps_shift)) {
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
-		pps_fbase = *raw_ts;
+		ntpdata->pps_fbase = *raw_ts;
 		hardpps_update_freq(ntpdata, freq_norm);
 	}
 

-- 
2.39.2


