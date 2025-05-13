Return-Path: <netdev+bounces-190190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165BFAB5834
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FD37AC720
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B972BF3CF;
	Tue, 13 May 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmA+sGlc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xb/nKw17"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F42BEC24;
	Tue, 13 May 2025 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149192; cv=none; b=cUqRGPOHcjbY7fh0MuuHvFOECsP0YrHiTTKc+7xK0E4kE1Ct06t5w18ykeyPgw4xNcMBh7OXygegehBF/GLDDVC1GwoJwhyzrsmMnMQjHj4lKG/6QeHKcnXOkJ9Q0Bqk5MjtFUfa5luv+AzNwk0/7H44myfeiaGWIpyOyMTky/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149192; c=relaxed/simple;
	bh=nbID1QPp+mJm1zriYwER3a76w48ZJBK56tf88xhinGY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BuBQ1yOYSSr0nLGtrQP5Zx+xZbD+i2XuwqCE+rLpd2rSZ77HUl3aPiVoSuhmnp8c2HlKGFPG+bmJMk5tcv19CeZY5z/JY1bKb2EDp74ufIf7qZEODfZoPAGLIFcgmfSVJ4UX+OPKeuw7zfIc6ya/i21TVfzGWsVaZ2vqCMTA96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmA+sGlc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xb/nKw17; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.088657076@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A5j3o52zdWGqvEZkfz36bRjQ7CKt2Dcq+E6I8Zmxcqc=;
	b=NmA+sGlcpad4cm4nbTh1FZj7xkxB+fqIEa5G3kvP/T2fzzcwWmo592XYoU70Tt6ZjyEzq5
	dRbCJ8et07LMHZmq+cpIQl7b6PbGfT/Na8K14oHxMJeIbiBjUObZ4Ym5/n7VLL9jAjomto
	7WZf0FPDKicaYtZw9KIe9HogvKqFwJeIrwbf7qzIssYT4whUYzMX5u/G+DCQXCxZ4Uq+R+
	nYA21nDW0IhagTQxiQNZeSkxB/vH9IbnRaCgcFD6wIBHwuVbpBCpVueEYATY3qy7V0iMPR
	tbtpSaj0tsTV86YkYXHkawA5q0Rt880o9ckDbPQxkUBASndeRW++NBKobDSvcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A5j3o52zdWGqvEZkfz36bRjQ7CKt2Dcq+E6I8Zmxcqc=;
	b=Xb/nKw17PUSV668JRiYAHZWvuPjcUsEh9GwXd+5qo/DPTPgaTAQ7HHxz7kolKzBrCd5A9d
	3DJ3T9GDcfqn92Cw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 07/26] ntp: Add timekeeper ID arguments to public functions
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:07 +0200 (CEST)

In preparation for supporting independent PTP clocks, add a time keeper ID
to the relevant functions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/ntp.c          |   33 +++++++++++++++++++--------------
 kernel/time/ntp_internal.h |   11 +++++------
 kernel/time/timekeeping.c  |   12 ++++++------
 3 files changed, 30 insertions(+), 26 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -351,33 +351,38 @@ static void __ntp_clear(struct ntp_data
 
 /**
  * ntp_clear - Clears the NTP state variables
+ * @tkid:	Timekeeper ID to be able to select proper ntp data array member
  */
-void ntp_clear(void)
+void ntp_clear(unsigned int tkid)
 {
-	__ntp_clear(&tk_ntp_data[TIMEKEEPER_CORE]);
+	__ntp_clear(&tk_ntp_data[tkid]);
 }
 
 
-u64 ntp_tick_length(void)
+u64 ntp_tick_length(unsigned int tkid)
 {
-	return tk_ntp_data[TIMEKEEPER_CORE].tick_length;
+	return tk_ntp_data[tkid].tick_length;
 }
 
 /**
  * ntp_get_next_leap - Returns the next leapsecond in CLOCK_REALTIME ktime_t
+ * @tkid:	Timekeeper ID
  *
- * Provides the time of the next leapsecond against CLOCK_REALTIME in
- * a ktime_t format. Returns KTIME_MAX if no leapsecond is pending.
+ * Returns: For @tkid == TIMEKEEPER_CORE this provides the time of the next
+ *	    leap second against CLOCK_REALTIME in a ktime_t format if a
+ *	    leap second is pending. KTIME_MAX otherwise.
  */
-ktime_t ntp_get_next_leap(void)
+ktime_t ntp_get_next_leap(unsigned int tkid)
 {
 	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
-	ktime_t ret;
+
+	if (tkid != TIMEKEEPER_CORE)
+		return KTIME_MAX;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
 		return ktime_set(ntpdata->ntp_next_leap_sec, 0);
-	ret = KTIME_MAX;
-	return ret;
+
+	return KTIME_MAX;
 }
 
 /*
@@ -390,9 +395,9 @@ ktime_t ntp_get_next_leap(void)
  *
  * Also handles leap second processing, and returns leap offset
  */
-int second_overflow(time64_t secs)
+int second_overflow(unsigned int tkid, time64_t secs)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
+	struct ntp_data *ntpdata = &tk_ntp_data[tkid];
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -762,10 +767,10 @@ static inline void process_adjtimex_mode
  * adjtimex() mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
+int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
+	struct ntp_data *ntpdata = &tk_ntp_data[tkid];
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -3,13 +3,12 @@
 #define _LINUX_NTP_INTERNAL_H
 
 extern void ntp_init(void);
-extern void ntp_clear(void);
+extern void ntp_clear(unsigned int tkid);
 /* Returns how long ticks are at present, in ns / 2^NTP_SCALE_SHIFT. */
-extern u64 ntp_tick_length(void);
-extern ktime_t ntp_get_next_leap(void);
-extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct __kernel_timex *txc,
-			 const struct timespec64 *ts,
+extern u64 ntp_tick_length(unsigned int tkid);
+extern ktime_t ntp_get_next_leap(unsigned int tkid);
+extern int second_overflow(unsigned int tkid, time64_t secs);
+extern int __do_adjtimex(unsigned int tkid, struct __kernel_timex *txc, const struct timespec64 *ts,
 			 s32 *time_tai, struct audit_ntp_data *ad);
 extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_unregiste
  */
 static inline void tk_update_leap_state(struct timekeeper *tk)
 {
-	tk->next_leap_ktime = ntp_get_next_leap();
+	tk->next_leap_ktime = ntp_get_next_leap(tk->id);
 	if (tk->next_leap_ktime != KTIME_MAX)
 		/* Convert to monotonic time */
 		tk->next_leap_ktime = ktime_sub(tk->next_leap_ktime, tk->offs_real);
@@ -678,7 +678,7 @@ static void timekeeping_update_from_shad
 
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
-		ntp_clear();
+		ntp_clear(tk->id);
 	}
 
 	tk_update_leap_state(tk);
@@ -2044,7 +2044,7 @@ static __always_inline void timekeeping_
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
-	u64 ntp_tl = ntp_tick_length();
+	u64 ntp_tl = ntp_tick_length(tk->id);
 	u32 mult;
 
 	/*
@@ -2125,7 +2125,7 @@ static inline unsigned int accumulate_ns
 		}
 
 		/* Figure out if its a leap sec and apply if needed */
-		leap = second_overflow(tk->xtime_sec);
+		leap = second_overflow(tk->id, tk->xtime_sec);
 		if (unlikely(leap)) {
 			struct timespec64 ts;
 
@@ -2222,7 +2222,7 @@ static bool __timekeeping_advance(enum t
 	shift = ilog2(offset) - ilog2(tk->cycle_interval);
 	shift = max(0, shift);
 	/* Bound shift to one less than what overflows tick_length */
-	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
+	maxshift = (64 - (ilog2(ntp_tick_length(tk->id)) + 1)) - 1;
 	shift = min(shift, maxshift);
 	while (offset >= tk->cycle_interval) {
 		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
@@ -2581,7 +2581,7 @@ int do_adjtimex(struct __kernel_timex *t
 		}
 
 		orig_tai = tai = tks->tai_offset;
-		ret = __do_adjtimex(txc, &ts, &tai, &ad);
+		ret = __do_adjtimex(tks->id, txc, &ts, &tai, &ad);
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);


