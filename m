Return-Path: <netdev+bounces-191409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7CABB751
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8395D163B90
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C2626B087;
	Mon, 19 May 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RQpUXCb0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nMCINpJd"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660926A1AA;
	Mon, 19 May 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643602; cv=none; b=CO7ExytcyqEHONifCWvkD17tEXRBymQ/KD7FPc++Nt28vHlXUpeRi6ATI3+UTJl31LX7zLkDzN23I76j8pxU1KXnLaKZ5/Z1Kq9nz9AzQ6xBqezym7x9+hnpcvoe0Yebd/SxNG6g2foV7ysL9L6EWIPDBn5G8NujFZ2h004iDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643602; c=relaxed/simple;
	bh=gyOJgOUoQbY5FBMQmvSUz4XJj9IBjeHrsRkyBykdNIs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=n+4D7VkU3ZIAdWqYFgwgUrBUg4tZQStk6PCmzdRmlW9fRCf/P4OsQ1/9qIgVJI9s6ZhESZ4vxpAg8CJH4GMOaagMTtUcIDS25zAYQ6xIfC+FFuJTqTVp+6R/1bJoQvsUcawnvbDyp8CH928TQa+2rFHBpsJwmK8VNzh7ueRTX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RQpUXCb0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nMCINpJd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.779267274@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kvTMA6AVgoKok8yWA4AdNkJvlsrtitDM+TfHbVeiIw4=;
	b=RQpUXCb0L9j/pQgVUYYZZHVs6oG9YpLbgzjkQ2XhBFieVdttBZS+P+gqqYrNJmxbq9lt3X
	bBmN0cYUeF+kMgyRF2fGh7aWf5v5s7ZzSaJRN+Yniq+SSmpmih8tp3gOSv0qwEDHFjI3Pb
	wDqWfa0285w8TPt+cpx6dzGleZBG/uvmpD5ySEhYT22WouAOK/1xXX16gra02ira/079eX
	dVpG8kvD2SpjxwQvZeo/uE7THNnz6dX3Pr5pUuHeZwS7+rzT6c782qcUN6DcGFkgMlsrqL
	wWzSPLI+KZOJfhqitFIUc05baXbw57tixVxEeD6X0dLTp+uKL4sejrnN6lNi/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kvTMA6AVgoKok8yWA4AdNkJvlsrtitDM+TfHbVeiIw4=;
	b=nMCINpJdScnIdJ3o3eF8J24Xq2VZ8+E/+cFV8oHIm7Vh0TcPylztzvt6vi/6vUGXfYnpuF
	1fsB1p3FOVbVwTCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
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
 Antoine Tenart <atenart@kernel.org>
Subject: [patch V2 03/26] timekeeping: Avoid double notification in
 do_adjtimex()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:17 +0200 (CEST)

Consolidate do_adjtimex() so that it does not notify about clock changes
twice.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   98 ++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 42 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1418,40 +1418,49 @@ int do_settimeofday64(const struct times
 EXPORT_SYMBOL(do_settimeofday64);
 
 /**
- * timekeeping_inject_offset - Adds or subtracts from the current time.
+ * __timekeeping_inject_offset - Adds or subtracts from the current time.
  * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int timekeeping_inject_offset(const struct timespec64 *ts)
+static int __timekeeping_inject_offset(const struct timespec64 *ts)
 {
+	struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	struct timespec64 tmp;
+
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks = &tk_core.shadow_timekeeper;
-		struct timespec64 tmp;
-
-		timekeeping_forward_now(tks);
 
-		/* Make sure the proposed value is valid */
-		tmp = timespec64_add(tk_xtime(tks), *ts);
-		if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
-		    !timespec64_valid_settod(&tmp)) {
-			timekeeping_restore_shadow(&tk_core);
-			return -EINVAL;
-		}
+	timekeeping_forward_now(tks);
 
-		tk_xtime_add(tks, ts);
-		tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-		timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	/* Make sure the proposed value is valid */
+	tmp = timespec64_add(tk_xtime(tks), *ts);
+	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
+	    !timespec64_valid_settod(&tmp)) {
+		timekeeping_restore_shadow(&tk_core);
+		return -EINVAL;
 	}
 
-	/* Signal hrtimers about time change */
-	clock_was_set(CLOCK_SET_WALL);
+	tk_xtime_add(tks, ts);
+	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
+	timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
 	return 0;
 }
 
+static int timekeeping_inject_offset(const struct timespec64 *ts)
+{
+	int ret;
+
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock)
+		ret = __timekeeping_inject_offset(ts);
+
+	/* Signal hrtimers about time change */
+	if (!ret)
+		clock_was_set(CLOCK_SET_WALL);
+	return ret;
+}
+
 /*
  * Indicates if there is an offset between the system clock and the hardware
  * clock/persistent clock/rtc.
@@ -2186,7 +2195,7 @@ static u64 logarithmic_accumulation(stru
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
@@ -2194,8 +2203,6 @@ static bool timekeeping_advance(enum tim
 	int shift = 0, maxshift;
 	u64 offset, orig_offset;
 
-	guard(raw_spinlock_irqsave)(&tk_core.lock);
-
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
 		return false;
@@ -2249,6 +2256,12 @@ static bool timekeeping_advance(enum tim
 	return !!clock_set;
 }
 
+static bool timekeeping_advance(enum timekeeping_adv_mode mode)
+{
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return __timekeeping_advance(mode);
+}
+
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
@@ -2537,10 +2550,10 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fal
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
+	struct timespec64 delta, ts;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
 	bool clock_set = false;
-	struct timespec64 ts;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2549,21 +2562,6 @@ int do_adjtimex(struct __kernel_timex *t
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	if (txc->modes & ADJ_SETOFFSET) {
-		struct timespec64 delta;
-
-		delta.tv_sec  = txc->time.tv_sec;
-		delta.tv_nsec = txc->time.tv_usec;
-		if (!(txc->modes & ADJ_NANO))
-			delta.tv_nsec *= 1000;
-		ret = timekeeping_inject_offset(&delta);
-		if (ret)
-			return ret;
-
-		offset_set = delta.tv_sec != 0;
-		audit_tk_injoffset(delta);
-	}
-
 	audit_ntp_init(&ad);
 
 	ktime_get_real_ts64(&ts);
@@ -2573,6 +2571,19 @@ int do_adjtimex(struct __kernel_timex *t
 		struct timekeeper *tks = &tk_core.shadow_timekeeper;
 		s32 orig_tai, tai;
 
+		if (txc->modes & ADJ_SETOFFSET) {
+			delta.tv_sec  = txc->time.tv_sec;
+			delta.tv_nsec = txc->time.tv_usec;
+			if (!(txc->modes & ADJ_NANO))
+				delta.tv_nsec *= 1000;
+			ret = __timekeeping_inject_offset(&delta);
+			if (ret)
+				return ret;
+
+			offset_set = delta.tv_sec != 0;
+			clock_set = true;
+		}
+
 		orig_tai = tai = tks->tai_offset;
 		ret = __do_adjtimex(txc, &ts, &tai, &ad);
 
@@ -2583,13 +2594,16 @@ int do_adjtimex(struct __kernel_timex *t
 		} else {
 			tk_update_leap_state_all(&tk_core);
 		}
+
+		/* Update the multiplier immediately if frequency was set directly */
+		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+			clock_set |= __timekeeping_advance(TK_ADV_FREQ);
 	}
 
-	audit_ntp_log(&ad);
+	if (txc->modes & ADJ_SETOFFSET)
+		audit_tk_injoffset(delta);
 
-	/* Update the multiplier immediately if frequency was set directly */
-	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-		clock_set |= timekeeping_advance(TK_ADV_FREQ);
+	audit_ntp_log(&ad);
 
 	if (clock_set)
 		clock_was_set(CLOCK_SET_WALL);


