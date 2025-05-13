Return-Path: <netdev+bounces-190204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B73AB5857
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C6816492E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37562C2AA0;
	Tue, 13 May 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iI1B4T7x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tIe/ebI4"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD892C1E15;
	Tue, 13 May 2025 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149215; cv=none; b=p1sorM56woU0nh7DJ3/x2zMNPoVXxZ35fx70HZOuBJIQXH5V8Oekj2ohgfpzpR/cYqPntkRnMziw3MZGG7uDABg4PIP2wjiF066g8fKrFeCAtoZiAhkit+AmMvBuyI6ajHjWxL7U7V/+srhUQPM9YWNxHrn9gFnnOC8TRSTK0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149215; c=relaxed/simple;
	bh=XNPSQ1Hy854FzcyRYag43LIzOLmKfi3VSE/hwFsgdag=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Dwq+qSUU6pUPoC/REfHXaR3V0DtQ+XkWr1eST/F1fVrXrWPDRUUs7FHXAWNiW/aigEoDY14ZK0D+1P9SsgbyzGSQETc8Ui8z2Sw5aXPHI+oyY36w8L7xuV39TB/buYUexVm6FPHIc6ZJIPVmJ4FoPTW+cbcWcD1b1WyLEr76zPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iI1B4T7x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tIe/ebI4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.861047599@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IKbUr1poQ8Wwcs8+3rNGvdlPp/sUv73Qu/xVzEO/Kaw=;
	b=iI1B4T7x0ukNkaVf0hVbUFuJEKVnjzeAfWBoouwsaOPEwWgXA9S2X6YeVbgGs5Xh1TTO/y
	ql0sg9p1ClgiyA2pSdGsrwdXkGl5kIRMKuqkC1MInJFp51IFY6nWsojnSwFkGJUylvJzTK
	MBIOCmgKTYmB4/vEzzHNPpI3CL+j0aVpYEEShsbF4nhoOPfwDTIbM1PoMMaGgt0HlkcNFW
	v6oNX04/7zdsnmwsShN+0vXumsXYFzSh3jxsuaaTDKjGWeEgev3KCJboedYbLkSYHtgQiA
	AQeH0YneyHOah/ctGIvC3RPIwXQpmltsOSIxRfJWPS0Oqna8FNyCnOfwkjb4DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IKbUr1poQ8Wwcs8+3rNGvdlPp/sUv73Qu/xVzEO/Kaw=;
	b=tIe/ebI4+XkvpNyXJDM6JsfP67IRTFcJmZWOxE7346ur12wDlggss87j8CLOTqyG09c6EO
	hhJgmr4D4o7/gPCw==
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
Subject: [patch 20/26] timekeeping: Make timekeeping_inject_offset() reusable
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:32 +0200 (CEST)

Split out the inner workings for PTP clock support and feed the core time
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


