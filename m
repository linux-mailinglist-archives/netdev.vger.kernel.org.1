Return-Path: <netdev+bounces-127402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F365F97541A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631A4B220A2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6401B3B27;
	Wed, 11 Sep 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KPp133cg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RRR5RiMc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005861ACDE8;
	Wed, 11 Sep 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061414; cv=none; b=thYqwcwzszjpsryzXGjKseXoFGJCrkJYNDMxV+Xe67HALuR3rzsR5KmAwMjx3G9b04HxKo8Lo8Rt68sietrC7bzl1dcBdIlVw+dUNjnMqabnONIscY/f2UMtew2r3GSUxFJ9twnOuHPbZN8tc0SOkPT8/Cr+KwyYuty6xH4OV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061414; c=relaxed/simple;
	bh=ApDD4AjMoMOt1p1Qt0d2pl1wAFijoYUfYcuv+MwlkYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvsJO1WBTNUKgNmNm7JA5bqEo8xe/kLDgQ/w6636RL/sbOxMmIqo9dNbRFEdMcBmqKn8ITCSzOFudGvwE2POkPH21KW6wjj8DOJHsr6AHTwYNXWHJLnwRuhc3bmo/BLdFyDL5VdCfbWmWlWtkGO5Z1kuPgBU4yCadDKcKWSyBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KPp133cg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RRR5RiMc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXsIvVksy9ByUpQe81COBM2K1EqS1mTK0otA0frz9Zw=;
	b=KPp133cgyiMMQk64Brp3JIoh0OBJpPrlGz86kx6BNkCFWYLogfDjyxpPVezor3vtaXgSfD
	zRIxznRjQ/okDQBXRE8bFNE+QAsHQGik5SXN33YPjxsCvp/HjODKKfZpDkORJQGSTsEOWF
	8Dp5OpXf1QdYVTh5m4d3puGgtZAbrFOY6EerI++TIGR53xwT5La1DRrvlwUFXU79EjfZE/
	O3EQ6gKHfpzkt1AJhJdc4OpmDXSSKyy90//s/9G0y4nrL324UdkB0cTo/Nn8dajkKh0yMs
	jKhn75KdNpmDnyzULDmMIDmJV36uMBGRjgbp9vpmC2bg8CqrhfdJXf53ge3hbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXsIvVksy9ByUpQe81COBM2K1EqS1mTK0otA0frz9Zw=;
	b=RRR5RiMcFLoXrRe52rd+i3ovGWQ4Cp1vWIeUA1m7Qfu3G86TQkrch2seXIFhkIG/FfNpMy
	NvUHraO+/mgTyqBg==
Date: Wed, 11 Sep 2024 15:30:06 +0200
Subject: [PATCH 22/24] timekeeping: Rework do_adjtimex() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-22-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

Convert do_adjtimex() to use this scheme and take the opportunity to use a
scoped_guard() for locking.

That requires to have a separate function for updating the leap state so
that the update is protected by the sequence count. This also brings the
timekeeper and the shadow timekeeper in sync for this state, which was not
the case so far. That's not a correctness problem as the state is only used
at the read sides which use the real timekeeper, but it's inconsistent
nevertheless.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e3eb11ccdf5b..cbca0351ceca 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -722,6 +722,18 @@ static inline void tk_update_leap_state(struct timekeeper *tk)
 		tk->next_leap_ktime = ktime_sub(tk->next_leap_ktime, tk->offs_real);
 }
 
+/*
+ * Leap state update for both shadow and the real timekeeper
+ * Separate to spare a full memcpy() of the timekeeper.
+ */
+static void tk_update_leap_state_all(struct tk_data *tkd)
+{
+	write_seqcount_begin(&tkd->seq);
+	tk_update_leap_state(&tkd->shadow_timekeeper);
+	tkd->timekeeper.next_leap_ktime = tkd->shadow_timekeeper.next_leap_ktime;
+	write_seqcount_end(&tkd->seq);
+}
+
 /*
  * Update the ktime_t based scalar nsec members of the timekeeper
  */
@@ -2537,12 +2549,10 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct audit_ntp_data ad;
 	bool clock_set = false;
 	struct timespec64 ts;
-	unsigned long flags;
-	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2569,23 +2579,21 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		s32 orig_tai, tai;
 
-	orig_tai = tai = tk->tai_offset;
-	ret = __do_adjtimex(txc, &ts, &tai, &ad);
+		orig_tai = tai = tk->tai_offset;
+		ret = __do_adjtimex(txc, &ts, &tai, &ad);
 
-	if (tai != orig_tai) {
-		__timekeeping_set_tai_offset(tk, tai);
-		timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-		clock_set = true;
-	} else {
-		tk_update_leap_state(tk);
+		if (tai != orig_tai) {
+			__timekeeping_set_tai_offset(tk, tai);
+			timekeeping_update_staged(&tk_core, TK_CLOCK_WAS_SET);
+			clock_set = true;
+		} else {
+			tk_update_leap_state_all(&tk_core);
+		}
 	}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
-
 	audit_ntp_log(&ad);
 
 	/* Update the multiplier immediately if frequency was set directly */

-- 
2.39.2


