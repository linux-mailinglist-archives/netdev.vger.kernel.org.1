Return-Path: <netdev+bounces-191426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20C2ABB77D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10823AE510
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A3274FED;
	Mon, 19 May 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xrA6rCCf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kcc2hrow"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F22749EB;
	Mon, 19 May 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643623; cv=none; b=aLgmwN+jjB51uPmXW5jWPc56aFp6Mgo1rv3hGpyIBydmJaTLHK2c6tKbVaoNb+BfYExWYkDWCi1Y4fNLCCtQ9kieIw92q8yG+zeCe2h0ndRMd4B880mGQPwq6zd+ibMWOZUlSozVxvBijpPGv26V6YvjezOzrf7A6yV9LPh0IWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643623; c=relaxed/simple;
	bh=bmswsEHRCiYtGAKJWD1cabCPAbE600f4P99guyPMzww=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gpqNzboiF+kxXK+8z+lWKLWNZp6Lok0Ku1DbUGCnXTSr4vkpxEDFapfp4Vw282OO9VieQV2RE7sJDH3I32wxlQBsz1ajw/DUeXZRJyEaeWQMlu7l4OBInY6Q9jPxfEROiSTv1H6D8l/6CEdK0twR/fVvtj8Yde5jBRz7uin2Doo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xrA6rCCf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kcc2hrow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.841511545@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=88U+TlNxDjc05fy5ggh1gh3HtGRG6wxT0jHWuxpiG24=;
	b=xrA6rCCfS6XDu/KgxgJr+pIQFTwzwYoJE3kj2er5PBPkOPtS3ThfC5Lxwk4gDkdq6j5y/G
	ZAuO/5Fww/kCvOE1EM3RvbyPtJiVmsGFmJ87NPYVd1nhy6KRMBO9z3Ka6HgR40W1iR/UnB
	7mLnUh5Ux+o+lPCS+nufm7ZIiTZhNgCbaNADur6zv4QPLX++9njqDlJwOrCuKsIpXzAzoI
	Q1Y3qzKJUoWlCxLJ9c4ty3C7qIRe4LyiWB2LgqM8ArqqmoNYBqEw11mMnW07Iqidu2csz3
	Fg58nYYeqnXgojQvIsYMfS2leFzcO4VfNij58n35dj7y/m7ABDEdzUv/hKLlRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=88U+TlNxDjc05fy5ggh1gh3HtGRG6wxT0jHWuxpiG24=;
	b=Kcc2hrow6Tph3ks+v0nkkrYueGdRgeFOtaBJzPGPYrw3/v7Ur/IucMW2d4LXfviD8Kg28z
	wfwItWuvFKaUq8AA==
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
Subject: [patch V2 20/26] timekeeping: Make timekeeping_inject_offset()
 reusable
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:38 +0200 (CEST)

Split out the inner workings for auxiliary clock support and feed the core time
keeper into it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1433,32 +1433,32 @@ EXPORT_SYMBOL(do_settimeofday64);
 
 /**
  * __timekeeping_inject_offset - Adds or subtracts from the current time.
+ * @tkd:	Pointer to the timekeeper to modify
  * @ts:		Pointer to the timespec variable containing the offset
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int __timekeeping_inject_offset(const struct timespec64 *ts)
+static int __timekeeping_inject_offset(struct tk_data *tkd, const struct timespec64 *ts)
 {
-	struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
 	struct timespec64 tmp;
 
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-
 	timekeeping_forward_now(tks);
 
 	/* Make sure the proposed value is valid */
 	tmp = timespec64_add(tk_xtime(tks), *ts);
 	if (timespec64_compare(&tks->wall_to_monotonic, ts) > 0 ||
 	    !timespec64_valid_settod(&tmp)) {
-		timekeeping_restore_shadow(&tk_core);
+		timekeeping_restore_shadow(tkd);
 		return -EINVAL;
 	}
 
 	tk_xtime_add(tks, ts);
 	tk_set_wall_to_mono(tks, timespec64_sub(tks->wall_to_monotonic, *ts));
-	timekeeping_update_from_shadow(&tk_core, TK_UPDATE_ALL);
+	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
 	return 0;
 }
 
@@ -1467,7 +1467,7 @@ static int timekeeping_inject_offset(con
 	int ret;
 
 	scoped_guard (raw_spinlock_irqsave, &tk_core.lock)
-		ret = __timekeeping_inject_offset(ts);
+		ret = __timekeeping_inject_offset(&tk_core, ts);
 
 	/* Signal hrtimers about time change */
 	if (!ret)
@@ -2568,6 +2568,7 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fal
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
+	struct tk_data *tkd = &tk_core;
 	struct timespec64 delta, ts;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
@@ -2585,16 +2586,19 @@ int do_adjtimex(struct __kernel_timex *t
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
-		struct timekeeper *tks = &tk_core.shadow_timekeeper;
+	scoped_guard (raw_spinlock_irqsave, &tkd->lock) {
+		struct timekeeper *tks = &tkd->shadow_timekeeper;
 		s32 orig_tai, tai;
 
+		if (!tks->clock_valid)
+			return -ENODEV;
+
 		if (txc->modes & ADJ_SETOFFSET) {
 			delta.tv_sec  = txc->time.tv_sec;
 			delta.tv_nsec = txc->time.tv_usec;
 			if (!(txc->modes & ADJ_NANO))
 				delta.tv_nsec *= 1000;
-			ret = __timekeeping_inject_offset(&delta);
+			ret = __timekeeping_inject_offset(tkd, &delta);
 			if (ret)
 				return ret;
 
@@ -2607,7 +2611,7 @@ int do_adjtimex(struct __kernel_timex *t
 
 		if (tai != orig_tai) {
 			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(&tk_core, TK_CLOCK_WAS_SET);
+			timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
 			clock_set = true;
 		} else {
 			tk_update_leap_state_all(&tk_core);
@@ -2615,7 +2619,7 @@ int do_adjtimex(struct __kernel_timex *t
 
 		/* Update the multiplier immediately if frequency was set directly */
 		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(&tk_core, TK_ADV_FREQ);
+			clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
 	}
 
 	if (txc->modes & ADJ_SETOFFSET)


