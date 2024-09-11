Return-Path: <netdev+bounces-127377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E7975389
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A681C22828
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF76192B78;
	Wed, 11 Sep 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzokRvqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CP9l3ZB5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E511A3051;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060687; cv=none; b=pKe04Y8MOu66j57bKkMbMfNNeVgEndOJfWMHoRQXPHFQ2mS3W8YK6E2vVFGlMhv2Hnfq9FWcIfcaFDyLS+iw+Pu8HYPA/FZ9DUw4IDhm8o+vwJSbrpvl6Sx8Yp47WK6d6FcPB/Xy8DtKwtGqse5R10ZXja/EMEbNB9R3ro+fLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060687; c=relaxed/simple;
	bh=eSg2kys+qhJ4H0MpPX7XpiRTKHXw4HN6JdOB83qasiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdPa+ZcLLCHyUlCdcql0UeS31QUlbuB7j6Am0HMV1GLFh4lOSI7GuBi6AEReJA43+EZ510dtyqAcjqlBYE0yZBPtbyXcrtk9T/J7PJZOZFFHLAYUpHFg3QILy+uo3giBrsTJacZD6NCzzvmizaG3gYZ+/GGVjfgQPIhWn0p/qvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzokRvqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CP9l3ZB5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+kzeJnB8RrwCnaPcVHIZ7Wr6xgho4DYO3+HePvWiis=;
	b=XzokRvqJXtt+1DZidm+hk8t9LNS7g5KKbqjzhyREYO8tV2DWKIC3vK1+HCxcNUZNLiWBub
	oEEZ7W/1MpwAUgw9rc7WDNxo6dXDL+IfEVZHiO80T+qLM7HZgsJvdmwr/PM46wEVjEaw3Y
	ZAcdKipThEYhTEOxMAgYxrAxzrttfvaDDBGVDh1WeE5sBIrwjkd/K5mQgoFXPHDlk4F9YJ
	czF7f+jI4vnrcgsOfQfpi52T6iUpZKzn1+5CrV2OlZOhtwoaULwPMu5Pll0J88J4Xv0Gks
	OA+hy0I3q9gmAcA0I3MWczkBANBJ1CsTEKSbG0b3zkm2Bq/0YF7kN+OdtloONw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+kzeJnB8RrwCnaPcVHIZ7Wr6xgho4DYO3+HePvWiis=;
	b=CP9l3ZB5tyFj6xK0I+iPTTOLui+9Ld8TUsPeTR6MhnLq6iS8x0DTmMp/P3m0oBkkgcvDlb
	BRfeGKXIFEDu56Bw==
Date: Wed, 11 Sep 2024 15:17:55 +0200
Subject: [PATCH 19/21] ntp: Move pps_shift/intcnt into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-19-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 54 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 4098c38fbc3f..a9103b08d1ec 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -44,6 +44,8 @@
  * @pps_tf:		PPS phase median filter
  * @pps_jitter:		PPS current jitter in nanoseconds
  * @pps_fbase:		PPS beginning of the last freq interval
+ * @pps_shift:		PPS current interval duration in seconds (shift value)
+ * @pps_intcnt:		PPS interval counter
  *
  * Protected by the timekeeping locks.
  */
@@ -67,6 +69,8 @@ struct ntp_data {
 	long			pps_tf[3];
 	long			pps_jitter;
 	struct timespec64	pps_fbase;
+	int			pps_shift;
+	int			pps_intcnt;
 #endif
 };
 
@@ -102,8 +106,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static int pps_shift;		/* current interval duration (s) (shift) */
-static int pps_intcnt;		/* interval counter */
 static s64 pps_freq;		/* frequency offset (scaled ns/s) */
 static long pps_stabil;		/* current stability (scaled ns/s) */
 
@@ -128,11 +130,11 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 		return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
-static inline void pps_reset_freq_interval(void)
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata)
 {
 	/* The PPS calibration interval may end surprisingly early */
-	pps_shift = PPS_INTMIN;
-	pps_intcnt = 0;
+	ntpdata->pps_shift = PPS_INTMIN;
+	ntpdata->pps_intcnt = 0;
 }
 
 /**
@@ -141,7 +143,7 @@ static inline void pps_reset_freq_interval(void)
  */
 static inline void pps_clear(struct ntp_data *ntpdata)
 {
-	pps_reset_freq_interval();
+	pps_reset_freq_interval(ntpdata);
 	ntpdata->pps_tf[0] = 0;
 	ntpdata->pps_tf[1] = 0;
 	ntpdata->pps_tf[2] = 0;
@@ -199,7 +201,7 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
-	txc->shift	   = pps_shift;
+	txc->shift	   = ntpdata->pps_shift;
 	txc->stabil	   = pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
 	txc->calcnt	   = pps_calcnt;
@@ -214,7 +216,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 	return shift_right(offset, SHIFT_PLL + ntpdata->time_constant);
 }
 
-static inline void pps_reset_freq_interval(void) {}
+static inline void pps_reset_freq_interval(struct ntp_data *ntpdata) {}
 static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
@@ -685,7 +687,7 @@ static inline void process_adj_status(struct ntp_data *ntpdata, const struct __k
 		ntpdata->time_status = STA_UNSYNC;
 		ntpdata->ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
-		pps_reset_freq_interval();
+		pps_reset_freq_interval(ntpdata);
 	}
 
 	/*
@@ -888,13 +890,13 @@ static inline void pps_phase_filter_add(struct ntp_data *ntpdata, long err)
  * Decrease frequency calibration interval length. It is halved after four
  * consecutive unstable intervals.
  */
-static inline void pps_dec_freq_interval(void)
+static inline void pps_dec_freq_interval(struct ntp_data *ntpdata)
 {
-	if (--pps_intcnt <= -PPS_INTCOUNT) {
-		pps_intcnt = -PPS_INTCOUNT;
-		if (pps_shift > PPS_INTMIN) {
-			pps_shift--;
-			pps_intcnt = 0;
+	if (--ntpdata->pps_intcnt <= -PPS_INTCOUNT) {
+		ntpdata->pps_intcnt = -PPS_INTCOUNT;
+		if (ntpdata->pps_shift > PPS_INTMIN) {
+			ntpdata->pps_shift--;
+			ntpdata->pps_intcnt = 0;
 		}
 	}
 }
@@ -903,13 +905,13 @@ static inline void pps_dec_freq_interval(void)
  * Increase frequency calibration interval length. It is doubled after
  * four consecutive stable intervals.
  */
-static inline void pps_inc_freq_interval(void)
+static inline void pps_inc_freq_interval(struct ntp_data *ntpdata)
 {
-	if (++pps_intcnt >= PPS_INTCOUNT) {
-		pps_intcnt = PPS_INTCOUNT;
-		if (pps_shift < PPS_INTMAX) {
-			pps_shift++;
-			pps_intcnt = 0;
+	if (++ntpdata->pps_intcnt >= PPS_INTCOUNT) {
+		ntpdata->pps_intcnt = PPS_INTCOUNT;
+		if (ntpdata->pps_shift < PPS_INTMAX) {
+			ntpdata->pps_shift++;
+			ntpdata->pps_intcnt = 0;
 		}
 	}
 }
@@ -930,10 +932,10 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	s64 ftemp;
 
 	/* Check if the frequency interval was too long */
-	if (freq_norm.sec > (2 << pps_shift)) {
+	if (freq_norm.sec > (2 << ntpdata->pps_shift)) {
 		ntpdata->time_status |= STA_PPSERROR;
 		pps_errcnt++;
-		pps_dec_freq_interval();
+		pps_dec_freq_interval(ntpdata);
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
 				freq_norm.sec);
 		return 0;
@@ -952,10 +954,10 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		ntpdata->time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
-		pps_dec_freq_interval();
+		pps_dec_freq_interval(ntpdata);
 	} else {
 		/* Good sample */
-		pps_inc_freq_interval();
+		pps_inc_freq_interval(ntpdata);
 	}
 
 	/*
@@ -1060,7 +1062,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	}
 
 	/* Signal is ok. Check if the current frequency interval is finished */
-	if (freq_norm.sec >= (1 << pps_shift)) {
+	if (freq_norm.sec >= (1 << ntpdata->pps_shift)) {
 		pps_calcnt++;
 		/* Restart the frequency calibration interval */
 		ntpdata->pps_fbase = *raw_ts;

-- 
2.39.2


