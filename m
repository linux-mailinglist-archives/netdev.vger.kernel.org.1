Return-Path: <netdev+bounces-127371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2707697537F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60FB284A6F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3B1A3AAF;
	Wed, 11 Sep 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YvfEe/zG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="702zThgt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45119EEB7;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060685; cv=none; b=ddf/lQ2lJYF1faaKPioELvDyrb4uPlqeFUsRLBFtPp5CHftFXa629IpjJnRfUSmODzihJMrzSdfp6j8+tuBYml/1FYL2VHFHLa2S08fbh6/MdposSt2C1hEve8qpGa362piyG8CMZqZ5iAc3GknZBFoJyzIZ6sK0uqyYyGCDfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060685; c=relaxed/simple;
	bh=ZoDFUf51l3H/WcLUcto7GVyoIeSg8tr4rsTPyE8PgEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i6IPLMoOWA+bwZ/ScB+1druQOVDmVZtfUEEt6BetsiCdnt16cPkrTy8hB52FTYbh1yLS3hL8f+YBI+zrL/OJPxThMHffpFul9uvZBelhrSikEq/2v9UNS8TwY4CphuW6hsudVnBGVbL0Vv1SQK3fMvGNzeKwNyv/AonQNNFYgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YvfEe/zG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=702zThgt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlMdE3TYxqwLQSPlWb5h5InAD5kxN3qEYqa3UzZv1H4=;
	b=YvfEe/zGyYVbCBvGYLsDPbElSggfoeheuMRR89HFnIc4zinbMBuGHTJcvjEUUk7b/XUrKJ
	3tpuYCAAaB4XDxFQ0FV+F0E9RPs8C+pNvSoCi0vPlEsT9LoscQe4ZjkRZcirIMOqkLoflL
	+CwQdtGjM/3iCvLHWxAiNU1HBgoKzQkPbK6VC7Db2TwXYnw5+jwuCpJWgb84yTRYSn9yX4
	wCFHxXaw3H/UT9+5+6Ke+y82o+19g0vyY+yJai6bvwB7apqtNo5Off4QLEIJwd3bY+lENE
	FVBNLmGvZ0kBXLPlvw2KmzRBTYwXVjtNXje6hZW4YT35C8jGxFm5lqZzjtFe9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlMdE3TYxqwLQSPlWb5h5InAD5kxN3qEYqa3UzZv1H4=;
	b=702zThgtCf5z/yjodhZKpcCXV5FOjH0Uvr6FuG3TPmUg/ivBDs9J007iGs3X6wG7aUYnRm
	4lIOXN6jHFOSWGDg==
Date: Wed, 11 Sep 2024 15:17:45 +0200
Subject: [PATCH 09/21] ntp: Move tick_stat* into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-9-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 175 ++++++++++++++++++++++++++----------------------------
 1 file changed, 85 insertions(+), 90 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 6c5f684328c8..6d87f9889b03 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -27,6 +27,8 @@
  * @tick_usec:		USER_HZ period in microseconds
  * @tick_length:	Adjusted tick length
  * @tick_length_base:	Base value for @tick_length
+ * @time_state:		State of the clock synchronization
+ * @time_status:	Clock status bits
  *
  * Protected by the timekeeping locks.
  */
@@ -34,10 +36,14 @@ struct ntp_data {
 	unsigned long		tick_usec;
 	u64			tick_length;
 	u64			tick_length_base;
+	int			time_state;
+	int			time_status;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
+	.time_state		= TIME_OK,
+	.time_status		= STA_UNSYNC,
 };
 
 #define SECS_PER_DAY		86400
@@ -53,16 +59,6 @@ static struct ntp_data tk_ntp_data = {
  * estimated error = NTP dispersion.
  */
 
-/*
- * clock synchronization status
- *
- * (TIME_ERROR prevents overwriting the CMOS clock)
- */
-static int			time_state = TIME_OK;
-
-/* clock status bits:							*/
-static int			time_status = STA_UNSYNC;
-
 /* time adjustment (nsecs):						*/
 static s64			time_offset;
 
@@ -127,9 +123,9 @@ static long pps_errcnt;		/* calibration errors */
  * PPS kernel consumer compensates the whole phase error immediately.
  * Otherwise, reduce the offset by a fixed factor times the time constant.
  */
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 {
-	if (time_status & STA_PPSTIME && time_status & STA_PPSSIGNAL)
+	if (ntpdata->time_status & STA_PPSTIME && ntpdata->time_status & STA_PPSSIGNAL)
 		return offset;
 	else
 		return shift_right(offset, SHIFT_PLL + time_constant);
@@ -159,13 +155,13 @@ static inline void pps_clear(void)
  * Decrease pps_valid to indicate that another second has passed since the
  * last PPS signal. When it reaches 0, indicate that PPS signal is missing.
  */
-static inline void pps_dec_valid(void)
+static inline void pps_dec_valid(struct ntp_data *ntpdata)
 {
 	if (pps_valid > 0)
 		pps_valid--;
 	else {
-		time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
-				 STA_PPSWANDER | STA_PPSERROR);
+		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
+					  STA_PPSWANDER | STA_PPSERROR);
 		pps_clear();
 	}
 }
@@ -198,12 +194,12 @@ static inline bool is_error_status(int status)
 			&& (status & (STA_PPSWANDER|STA_PPSERROR)));
 }
 
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
 	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->jitter	   = pps_jitter;
-	if (!(time_status & STA_NANO))
+	if (!(ntpdata->time_status & STA_NANO))
 		txc->jitter = pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = pps_shift;
 	txc->stabil	   = pps_stabil;
@@ -215,14 +211,14 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
 
 #else /* !CONFIG_NTP_PPS */
 
-static inline s64 ntp_offset_chunk(s64 offset)
+static inline s64 ntp_offset_chunk(struct ntp_data *ntp, s64 offset)
 {
 	return shift_right(offset, SHIFT_PLL + time_constant);
 }
 
 static inline void pps_reset_freq_interval(void) {}
 static inline void pps_clear(void) {}
-static inline void pps_dec_valid(void) {}
+static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
 
 static inline bool is_error_status(int status)
@@ -230,7 +226,7 @@ static inline bool is_error_status(int status)
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
 
-static inline void pps_fill_timex(struct __kernel_timex *txc)
+static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_timex *txc)
 {
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq	   = 0;
@@ -268,30 +264,30 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	ntpdata->tick_length_base	 = new_base;
 }
 
-static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
+static inline s64 ntp_update_offset_fll(struct ntp_data *ntpdata, s64 offset64, long secs)
 {
-	time_status &= ~STA_MODE;
+	ntpdata->time_status &= ~STA_MODE;
 
 	if (secs < MINSEC)
 		return 0;
 
-	if (!(time_status & STA_FLL) && (secs <= MAXSEC))
+	if (!(ntpdata->time_status & STA_FLL) && (secs <= MAXSEC))
 		return 0;
 
-	time_status |= STA_MODE;
+	ntpdata->time_status |= STA_MODE;
 
 	return div64_long(offset64 << (NTP_SCALE_SHIFT - SHIFT_FLL), secs);
 }
 
-static void ntp_update_offset(long offset)
+static void ntp_update_offset(struct ntp_data *ntpdata, long offset)
 {
 	s64 freq_adj, offset64;
 	long secs, real_secs;
 
-	if (!(time_status & STA_PLL))
+	if (!(ntpdata->time_status & STA_PLL))
 		return;
 
-	if (!(time_status & STA_NANO)) {
+	if (!(ntpdata->time_status & STA_NANO)) {
 		/* Make sure the multiplication below won't overflow */
 		offset = clamp(offset, -USEC_PER_SEC, USEC_PER_SEC);
 		offset *= NSEC_PER_USEC;
@@ -306,13 +302,13 @@ static void ntp_update_offset(long offset)
 	 */
 	real_secs = __ktime_get_real_seconds();
 	secs = (long)(real_secs - time_reftime);
-	if (unlikely(time_status & STA_FREQHOLD))
+	if (unlikely(ntpdata->time_status & STA_FREQHOLD))
 		secs = 0;
 
 	time_reftime = real_secs;
 
 	offset64    = offset;
-	freq_adj    = ntp_update_offset_fll(offset64, secs);
+	freq_adj    = ntp_update_offset_fll(ntpdata, offset64, secs);
 
 	/*
 	 * Clamp update interval to reduce PLL gain with low
@@ -335,10 +331,10 @@ static void ntp_update_offset(long offset)
 static void __ntp_clear(struct ntp_data *ntpdata)
 {
 	/* Stop active adjtime() */
-	time_adjust	= 0;
-	time_status	|= STA_UNSYNC;
-	time_maxerror	= NTP_PHASE_LIMIT;
-	time_esterror	= NTP_PHASE_LIMIT;
+	time_adjust		= 0;
+	ntpdata->time_status	|= STA_UNSYNC;
+	time_maxerror		= NTP_PHASE_LIMIT;
+	time_esterror		= NTP_PHASE_LIMIT;
 
 	ntp_update_frequency(ntpdata);
 
@@ -372,9 +368,10 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	ktime_t ret;
 
-	if ((time_state == TIME_INS) && (time_status & STA_INS))
+	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
 		return ktime_set(ntp_next_leap_sec, 0);
 	ret = KTIME_MAX;
 	return ret;
@@ -402,46 +399,46 @@ int second_overflow(time64_t secs)
 	 * day, the system clock is set back one second; if in leap-delete
 	 * state, the system clock is set ahead one second.
 	 */
-	switch (time_state) {
+	switch (ntpdata->time_state) {
 	case TIME_OK:
-		if (time_status & STA_INS) {
-			time_state = TIME_INS;
+		if (ntpdata->time_status & STA_INS) {
+			ntpdata->time_state = TIME_INS;
 			div_s64_rem(secs, SECS_PER_DAY, &rem);
 			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
-		} else if (time_status & STA_DEL) {
-			time_state = TIME_DEL;
+		} else if (ntpdata->time_status & STA_DEL) {
+			ntpdata->time_state = TIME_DEL;
 			div_s64_rem(secs + 1, SECS_PER_DAY, &rem);
 			ntp_next_leap_sec = secs + SECS_PER_DAY - rem;
 		}
 		break;
 	case TIME_INS:
-		if (!(time_status & STA_INS)) {
+		if (!(ntpdata->time_status & STA_INS)) {
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_OK;
+			ntpdata->time_state = TIME_OK;
 		} else if (secs == ntp_next_leap_sec) {
 			leap = -1;
-			time_state = TIME_OOP;
+			ntpdata->time_state = TIME_OOP;
 			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
 		}
 		break;
 	case TIME_DEL:
-		if (!(time_status & STA_DEL)) {
+		if (!(ntpdata->time_status & STA_DEL)) {
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_OK;
+			ntpdata->time_state = TIME_OK;
 		} else if (secs == ntp_next_leap_sec) {
 			leap = 1;
 			ntp_next_leap_sec = TIME64_MAX;
-			time_state = TIME_WAIT;
+			ntpdata->time_state = TIME_WAIT;
 			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
 		ntp_next_leap_sec = TIME64_MAX;
-		time_state = TIME_WAIT;
+		ntpdata->time_state = TIME_WAIT;
 		break;
 	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-			time_state = TIME_OK;
+		if (!(ntpdata->time_status & (STA_INS | STA_DEL)))
+			ntpdata->time_state = TIME_OK;
 		break;
 	}
 
@@ -449,18 +446,18 @@ int second_overflow(time64_t secs)
 	time_maxerror += MAXFREQ / NSEC_PER_USEC;
 	if (time_maxerror > NTP_PHASE_LIMIT) {
 		time_maxerror = NTP_PHASE_LIMIT;
-		time_status |= STA_UNSYNC;
+		ntpdata->time_status |= STA_UNSYNC;
 	}
 
 	/* Compute the phase adjustment for the next second */
 	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta			 = ntp_offset_chunk(time_offset);
+	delta			 = ntp_offset_chunk(ntpdata, time_offset);
 	time_offset		-= delta;
 	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
-	pps_dec_valid();
+	pps_dec_valid(ntpdata);
 
 	if (!time_adjust)
 		goto out;
@@ -608,7 +605,7 @@ static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_ns
  */
 static inline bool ntp_synced(void)
 {
-	return !(time_status & STA_UNSYNC);
+	return !(tk_ntp_data.time_status & STA_UNSYNC);
 }
 
 /*
@@ -683,11 +680,11 @@ static inline void __init ntp_init_cmos_sync(void) { }
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(const struct __kernel_timex *txc)
+static inline void process_adj_status(struct ntp_data *ntpdata, const struct __kernel_timex *txc)
 {
-	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
-		time_state = TIME_OK;
-		time_status = STA_UNSYNC;
+	if ((ntpdata->time_status & STA_PLL) && !(txc->status & STA_PLL)) {
+		ntpdata->time_state = TIME_OK;
+		ntpdata->time_status = STA_UNSYNC;
 		ntp_next_leap_sec = TIME64_MAX;
 		/* Restart PPS frequency calibration */
 		pps_reset_freq_interval();
@@ -697,26 +694,25 @@ static inline void process_adj_status(const struct __kernel_timex *txc)
 	 * If we turn on PLL adjustments then reset the
 	 * reference time to current time.
 	 */
-	if (!(time_status & STA_PLL) && (txc->status & STA_PLL))
+	if (!(ntpdata->time_status & STA_PLL) && (txc->status & STA_PLL))
 		time_reftime = __ktime_get_real_seconds();
 
-	/* Only set allowed bits */
-	time_status &= STA_RONLY;
-	time_status |= txc->status & ~STA_RONLY;
+	/* only set allowed bits */
+	ntpdata->time_status &= STA_RONLY;
+	ntpdata->time_status |= txc->status & ~STA_RONLY;
 }
 
-
 static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct __kernel_timex *txc,
 					  s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
-		process_adj_status(txc);
+		process_adj_status(ntpdata, txc);
 
 	if (txc->modes & ADJ_NANO)
-		time_status |= STA_NANO;
+		ntpdata->time_status |= STA_NANO;
 
 	if (txc->modes & ADJ_MICRO)
-		time_status &= ~STA_NANO;
+		ntpdata->time_status &= ~STA_NANO;
 
 	if (txc->modes & ADJ_FREQUENCY) {
 		time_freq = txc->freq * PPM_SCALE;
@@ -734,17 +730,16 @@ static inline void process_adjtimex_modes(struct ntp_data *ntpdata, const struct
 
 	if (txc->modes & ADJ_TIMECONST) {
 		time_constant = clamp(txc->constant, 0, MAXTC);
-		if (!(time_status & STA_NANO))
+		if (!(ntpdata->time_status & STA_NANO))
 			time_constant += 4;
 		time_constant = clamp(time_constant, 0, MAXTC);
 	}
 
-	if (txc->modes & ADJ_TAI &&
-			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
+	if (txc->modes & ADJ_TAI && txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
-		ntp_update_offset(txc->offset);
+		ntp_update_offset(ntpdata, txc->offset);
 
 	if (txc->modes & ADJ_TICK)
 		ntpdata->tick_usec = txc->tick;
@@ -780,7 +775,7 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		if (txc->modes) {
 			audit_ntp_set_old(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_old(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_old(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_old(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_old(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 
@@ -788,26 +783,26 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 
 			audit_ntp_set_new(ad, AUDIT_NTP_OFFSET,	time_offset);
 			audit_ntp_set_new(ad, AUDIT_NTP_FREQ,	time_freq);
-			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	time_status);
+			audit_ntp_set_new(ad, AUDIT_NTP_STATUS,	ntpdata->time_status);
 			audit_ntp_set_new(ad, AUDIT_NTP_TAI,	*time_tai);
 			audit_ntp_set_new(ad, AUDIT_NTP_TICK,	ntpdata->tick_usec);
 		}
 
 		txc->offset = shift_right(time_offset * NTP_INTERVAL_FREQ,
 				  NTP_SCALE_SHIFT);
-		if (!(time_status & STA_NANO))
+		if (!(ntpdata->time_status & STA_NANO))
 			txc->offset = (u32)txc->offset / NSEC_PER_USEC;
 	}
 
-	result = time_state;
-	if (is_error_status(time_status))
+	result = ntpdata->time_state;
+	if (is_error_status(ntpdata->time_status))
 		result = TIME_ERROR;
 
 	txc->freq	   = shift_right((time_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
 	txc->maxerror	   = time_maxerror;
 	txc->esterror	   = time_esterror;
-	txc->status	   = time_status;
+	txc->status	   = ntpdata->time_status;
 	txc->constant	   = time_constant;
 	txc->precision	   = 1;
 	txc->tolerance	   = MAXFREQ_SCALED / PPM_SCALE;
@@ -815,26 +810,26 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 	txc->tai	   = *time_tai;
 
 	/* Fill PPS status fields */
-	pps_fill_timex(txc);
+	pps_fill_timex(ntpdata, txc);
 
 	txc->time.tv_sec = ts->tv_sec;
 	txc->time.tv_usec = ts->tv_nsec;
-	if (!(time_status & STA_NANO))
+	if (!(ntpdata->time_status & STA_NANO))
 		txc->time.tv_usec = ts->tv_nsec / NSEC_PER_USEC;
 
 	/* Handle leapsec adjustments */
 	if (unlikely(ts->tv_sec >= ntp_next_leap_sec)) {
-		if ((time_state == TIME_INS) && (time_status & STA_INS)) {
+		if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS)) {
 			result = TIME_OOP;
 			txc->tai++;
 			txc->time.tv_sec--;
 		}
-		if ((time_state == TIME_DEL) && (time_status & STA_DEL)) {
+		if ((ntpdata->time_state == TIME_DEL) && (ntpdata->time_status & STA_DEL)) {
 			result = TIME_WAIT;
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((time_state == TIME_OOP) &&	(ts->tv_sec == ntp_next_leap_sec))
+		if ((ntpdata->time_state == TIME_OOP) && (ts->tv_sec == ntp_next_leap_sec))
 			result = TIME_WAIT;
 	}
 
@@ -939,7 +934,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 
 	/* Check if the frequency interval was too long */
 	if (freq_norm.sec > (2 << pps_shift)) {
-		time_status |= STA_PPSERROR;
+		ntpdata->time_status |= STA_PPSERROR;
 		pps_errcnt++;
 		pps_dec_freq_interval();
 		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
@@ -958,7 +953,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 	pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
 		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
-		time_status |= STA_PPSWANDER;
+		ntpdata->time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
 	} else {
@@ -977,7 +972,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
-	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
+	if ((ntpdata->time_status & STA_PPSFREQ) && !(ntpdata->time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
 		ntp_update_frequency(ntpdata);
 	}
@@ -986,7 +981,7 @@ static long hardpps_update_freq(struct ntp_data *ntpdata, struct pps_normtime fr
 }
 
 /* Correct REALTIME clock phase error against PPS signal */
-static void hardpps_update_phase(long error)
+static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 {
 	long correction = -error;
 	long jitter;
@@ -1003,9 +998,9 @@ static void hardpps_update_phase(long error)
 	if (jitter > (pps_jitter << PPS_POPCORN)) {
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (pps_jitter << PPS_POPCORN));
-		time_status |= STA_PPSJITTER;
+		ntpdata->time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
-	} else if (time_status & STA_PPSTIME) {
+	} else if (ntpdata->time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
 		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
@@ -1035,10 +1030,10 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	pts_norm = pps_normalize_ts(*phase_ts);
 
 	/* Clear the error bits, they will be set again if needed */
-	time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
+	ntpdata->time_status &= ~(STA_PPSJITTER | STA_PPSWANDER | STA_PPSERROR);
 
-	/* Indicate signal presence */
-	time_status |= STA_PPSSIGNAL;
+	/* indicate signal presence */
+	ntpdata->time_status |= STA_PPSSIGNAL;
 	pps_valid = PPS_VALID;
 
 	/*
@@ -1059,7 +1054,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 */
 	if ((freq_norm.sec == 0) || (freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
 	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
-		time_status |= STA_PPSJITTER;
+		ntpdata->time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
 		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
@@ -1074,7 +1069,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 		hardpps_update_freq(ntpdata, freq_norm);
 	}
 
-	hardpps_update_phase(pts_norm.nsec);
+	hardpps_update_phase(ntpdata, pts_norm.nsec);
 
 }
 #endif	/* CONFIG_NTP_PPS */

-- 
2.39.2


