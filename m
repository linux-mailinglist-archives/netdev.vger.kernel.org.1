Return-Path: <netdev+bounces-201302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DADAE8CB5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979CB5A1981
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695492E174E;
	Wed, 25 Jun 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tH+Tl64z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uLir9uiA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4F62E11D2;
	Wed, 25 Jun 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876730; cv=none; b=fOwiwOWGtXsvatXM2pmfZNsvi8HuMSqutMIVts4J/QZi/++OPKAtXjTrsiadLR6WQQhC+OamgdRzyXmls8yLW22gRf8epUBwWqUpOjGjX5W2KtbOdOIOTjpZi0H8ZXSFXDehNd6so+iyPsDjg2pmuYIKGiudpKIgB0lJ/2zMtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876730; c=relaxed/simple;
	bh=XToOVm2FXAXySjWBpSyRSFYblYGvxnRlaBYG/+Er27k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MQUg0OdmRFNNRRVvzADpltuGYXn42/c3ZN3ZeAPFVE19OOhlpcLzZbiandYw4iFgXgh1JzIhj020x/0IIgqGf447SmlqIbYE/KNY7nj1r/i1haHL7VzuQxswzsEogamxA7eqhIJhVNn+LaILeSJ77mbs00KULVwtIKBs8oNOu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tH+Tl64z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uLir9uiA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.253203783@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HmYulIT89IwzdBVQfLuVPcreFHp/8ZApSW/Ds8aJxgk=;
	b=tH+Tl64z3P9o/hzlt+NAUVQUoqKDQ37iPUwn4N5x8FCErETNpOENoCMQSVoNpfqO9kKqM5
	uDiKJFfW6YSVssH4XKg+0nzYiXL36aVkLGqX9tR/n8gFQiv2uWPCDBzbTzc98i9Vyg8cvC
	z3zBT03sWbwhAHKbAj+AOLcRh0K76zu4z7UrF05CExCUsgTdOR3F9VcvbfZjazebG53SbI
	Zv9vbeFk1UW3GL9q1Cgw6aIZHZfEBEPvbb21RFXOzSJGcwPJWXo2PPUAolKG8Hb5PvtFZr
	qXO9hO1eR3+jCXRT9gXR/VXoDnJDqKborpf5ZKJj7Ah7pgS76MoMC+lhxZlpHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HmYulIT89IwzdBVQfLuVPcreFHp/8ZApSW/Ds8aJxgk=;
	b=uLir9uiA1lV2SY9GBp9jeLETysd3hyuf/mQ9uUPg1DsE/7wubc0T2+ShE+RyzbNugUT1HI
	V5ROBtoPR//CAZBQ==
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
Subject: [patch V3 08/11] timekeeping: Prepare do_adtimex() for auxiliary
 clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:45 +0200 (CEST)

Exclude ADJ_TAI, leap seconds and PPS functionality as they make no sense
in the context of auxiliary clocks and provide a time stamp based on the
actual clock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -58,6 +58,17 @@ static struct tk_data timekeeper_data[TI
 /* The core timekeeper */
 #define tk_core		(timekeeper_data[TIMEKEEPER_CORE])
 
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return ktime_get_aux_ts64(CLOCK_AUX + tkid - TIMEKEEPER_AUX_FIRST, ts);
+}
+#else
+static inline bool tk_get_aux_ts64(unsigned int tkid, struct timespec64 *ts)
+{
+	return false;
+}
+#endif
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -2503,7 +2514,7 @@ ktime_t ktime_get_update_offsets_now(uns
 /*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(const struct __kernel_timex *txc)
+static int timekeeping_validate_timex(const struct __kernel_timex *txc, bool aux_clock)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
@@ -2562,6 +2573,21 @@ static int timekeeping_validate_timex(co
 			return -EINVAL;
 	}
 
+	if (!aux_clock)
+		return 0;
+
+	/* Auxiliary clocks are similar to TAI and do not have leap seconds */
+	if (txc->status & (STA_INS | STA_DEL))
+		return -EINVAL;
+
+	/* No TAI offset setting */
+	if (txc->modes & ADJ_TAI)
+		return -EINVAL;
+
+	/* No PPS support either */
+	if (txc->status & (STA_PPSFREQ | STA_PPSTIME))
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -2592,15 +2618,22 @@ static int __do_adjtimex(struct tk_data
 	struct timekeeper *tks = &tkd->shadow_timekeeper;
 	struct timespec64 ts;
 	s32 orig_tai, tai;
+	bool aux_clock;
 	int ret;
 
+	aux_clock = IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) && tkd->timekeeper.id != TIMEKEEPER_CORE;
+
 	/* Validate the data before disabling interrupts */
-	ret = timekeeping_validate_timex(txc);
+	ret = timekeeping_validate_timex(txc, aux_clock);
 	if (ret)
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	ktime_get_real_ts64(&ts);
+	if (!aux_clock)
+		ktime_get_real_ts64(&ts);
+	else
+		tk_get_aux_ts64(tkd->timekeeper.id, &ts);
+
 	add_device_randomness(&ts, sizeof(ts));
 
 	guard(raw_spinlock_irqsave)(&tkd->lock);


