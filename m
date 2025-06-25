Return-Path: <netdev+bounces-201300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDB8AE8CB0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE67188ABE6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C02DA742;
	Wed, 25 Jun 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L5RSX64P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tqd4mPhY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76072E0B4C;
	Wed, 25 Jun 2025 18:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876727; cv=none; b=AdwScsItISSHVeO3wqrHqaBWIDL3u3dJ8ny6yBkyaNPwWkKvwuFIdnVu7pcINTFUDspQa7kckGP4SdxvvEk54b2B0pHjuG8OD/iFH7pnBoLySl9xH42TYOE0euzpCIFzoQRcYfikgh5YcQgqWW3MOYEjV9Hed0ftasKoJOfvmsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876727; c=relaxed/simple;
	bh=b5T8Jbp5iX0f1kT4SzSqHy+BudfP0PzjLAc2zVZJTyg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=pGxYSb25zSpVxEtMoga0c5zWOne764B6vyCBSsIYWX6C9FpfQkl89DuplQxk3uYgRfllZ5u90PVhU1i47caBAzdDGTIeAlycyTylkfENTJXBAkZfM7s293+6kCZvqfMI7+XRDcuewcJb+1S/BperTDNQ+Oln7lN6apKCMagJEI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L5RSX64P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tqd4mPhY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183758.187322876@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tqZxEcAjH2Q08zl9VMf10qBSNpG/vqmret2ndMqGbDE=;
	b=L5RSX64Prg4HapU8RlAQ2FxFmVhB65blPKS0sPBVvPuKUAo9MtXP5Jef35GMX+nNU0iwzI
	tvo+upDXGctmyphuMIiBvAE3LMlOXT+0avV4phlNXKXO5akupmADJld579wKTsNMcs2wHB
	UrXqJGU58ApTSjF5Z7yVD8z0GGU7qUWC418MQ02RuA03GkGrTFlHQXwfwc1A34voNrYjSf
	A8cnIkh0ttxtybj1dahWyFGkNtC0rKbgPhfoXkh1XVPK5VCpypdB/cc3e8hJ3DMNF+Yr4a
	tc4EErwZE6wABPwbJk71Rm0L93NIewwB4ZKe5tmBJ+utWejSuPHwhRZixdBM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tqZxEcAjH2Q08zl9VMf10qBSNpG/vqmret2ndMqGbDE=;
	b=Tqd4mPhYKI8K6QQ8jAbrjfXcJB/oTY7HQij6oM5KMRusnbeS9VX61giJ8GwxVlJY4wjM1F
	/ggJCiY3xduuKrAA==
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
Subject: [patch V3 07/11] timekeeping: Make do_adjtimex() reusable
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:43 +0200 (CEST)

Split out the actual functionality of adjtimex() and make do_adjtimex() a
wrapper which feeds the core timekeeper into it and handles the result
including audit at the call site.

This allows to reuse the actual functionality for auxiliary clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |  110 +++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 50 deletions(-)
---

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2580,17 +2580,18 @@ unsigned long random_get_entropy_fallbac
 }
 EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
-/**
- * do_adjtimex() - Accessor function to NTP __do_adjtimex function
- * @txc:	Pointer to kernel_timex structure containing NTP parameters
- */
-int do_adjtimex(struct __kernel_timex *txc)
+struct adjtimex_result {
+	struct audit_ntp_data	ad;
+	struct timespec64	delta;
+	bool			clock_set;
+};
+
+static int __do_adjtimex(struct tk_data *tkd, struct __kernel_timex *txc,
+			 struct adjtimex_result *result)
 {
-	struct tk_data *tkd = &tk_core;
-	struct timespec64 delta, ts;
-	struct audit_ntp_data ad;
-	bool offset_set = false;
-	bool clock_set = false;
+	struct timekeeper *tks = &tkd->shadow_timekeeper;
+	struct timespec64 ts;
+	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2599,56 +2600,65 @@ int do_adjtimex(struct __kernel_timex *t
 		return ret;
 	add_device_randomness(txc, sizeof(*txc));
 
-	audit_ntp_init(&ad);
-
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	scoped_guard (raw_spinlock_irqsave, &tkd->lock) {
-		struct timekeeper *tks = &tkd->shadow_timekeeper;
-		s32 orig_tai, tai;
-
-		if (!tks->clock_valid)
-			return -ENODEV;
-
-		if (txc->modes & ADJ_SETOFFSET) {
-			delta.tv_sec  = txc->time.tv_sec;
-			delta.tv_nsec = txc->time.tv_usec;
-			if (!(txc->modes & ADJ_NANO))
-				delta.tv_nsec *= 1000;
-			ret = __timekeeping_inject_offset(tkd, &delta);
-			if (ret)
-				return ret;
-
-			offset_set = delta.tv_sec != 0;
-			clock_set = true;
-		}
-
-		orig_tai = tai = tks->tai_offset;
-		ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &ad);
-
-		if (tai != orig_tai) {
-			__timekeeping_set_tai_offset(tks, tai);
-			timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
-			clock_set = true;
-		} else {
-			tk_update_leap_state_all(&tk_core);
-		}
-
-		/* Update the multiplier immediately if frequency was set directly */
-		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+	guard(raw_spinlock_irqsave)(&tkd->lock);
+
+	if (!tks->clock_valid)
+		return -ENODEV;
+
+	if (txc->modes & ADJ_SETOFFSET) {
+		result->delta.tv_sec  = txc->time.tv_sec;
+		result->delta.tv_nsec = txc->time.tv_usec;
+		if (!(txc->modes & ADJ_NANO))
+			result->delta.tv_nsec *= 1000;
+		ret = __timekeeping_inject_offset(tkd, &result->delta);
+		if (ret)
+			return ret;
+		result->clock_set = true;
+	}
+
+	orig_tai = tai = tks->tai_offset;
+	ret = ntp_adjtimex(tks->id, txc, &ts, &tai, &result->ad);
+
+	if (tai != orig_tai) {
+		__timekeeping_set_tai_offset(tks, tai);
+		timekeeping_update_from_shadow(tkd, TK_CLOCK_WAS_SET);
+		result->clock_set = true;
+	} else {
+		tk_update_leap_state_all(&tk_core);
 	}
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		result->clock_set |= __timekeeping_advance(tkd, TK_ADV_FREQ);
+
+	return ret;
+}
+
+/**
+ * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc:	Pointer to kernel_timex structure containing NTP parameters
+ */
+int do_adjtimex(struct __kernel_timex *txc)
+{
+	struct adjtimex_result result = { };
+	int ret;
+
+	ret = __do_adjtimex(&tk_core, txc, &result);
+	if (ret < 0)
+		return ret;
+
 	if (txc->modes & ADJ_SETOFFSET)
-		audit_tk_injoffset(delta);
+		audit_tk_injoffset(result.delta);
 
-	audit_ntp_log(&ad);
+	audit_ntp_log(&result.ad);
 
-	if (clock_set)
+	if (result.clock_set)
 		clock_was_set(CLOCK_SET_WALL);
 
-	ntp_notify_cmos_timer(offset_set);
+	ntp_notify_cmos_timer(result.delta.tv_sec != 0);
 
 	return ret;
 }




