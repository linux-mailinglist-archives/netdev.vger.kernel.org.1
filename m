Return-Path: <netdev+bounces-133537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32A49962DD
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B17A1F24235
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86191193067;
	Wed,  9 Oct 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yI9twtJf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNXTF5ia"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEC18FC89;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462567; cv=none; b=rOZ7UmczqhDibwlN52LOstUGziCFUeNVfu/SivfZ3Tqiodpi67IUzHRMZNfDVdG+xoW4q1SccqXNxOeN/R4mXWOoJKLJDVyziDyxETts2bmQqmBFqBf/1Op//EobS+MxFIxInpBzeIJ0lY5G6CoWO7xjC+pf4V37kJA3Pw6lAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462567; c=relaxed/simple;
	bh=zYy7jptOBH6pwHU/1OD0oFfh3Z3m29vNja2soSof/NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7ci2bqeo4N9ew1BvYRkrNO/uFVAXJWiOWKjhqiEDRmgl/xDtfmKSW/iO3AnAZEXAogcKPTwL2nc32nZ29vfORrC2GyZAHnE08mqwSE/alVHtS8Nkba11RvU5aAB0PVABiZH/t7H8NNagVSQX9XjgAa35aa6VQQqGgWXG8n+6Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yI9twtJf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNXTF5ia; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvIhrKxr/EBu+615Dq6VhsxlBFePOPxcYzgUF7RjckE=;
	b=yI9twtJfjevAR9uwqAxgaY2P1wm+7Qqx2lfs8yZy4aq/YqhY4CjEongoQEZV4etCV5rWSz
	vjf+XJCLXzTZaIVoQUvpmyiZ9+gHCysUOkVgtvXC/42RTcnwSCI0KI7YfwqjbHnWRRJa5t
	kdCPIk/klqK3qA9v4GZKYFQr9xPBLJDKDMtEfqt3DCDOlKpImP2oRPcTcjx2RV6ofyHGQC
	OPlB70UechcBt7869bcjYvuTms08dVNJDNpBbBVLpbY+RAnfRTrohMmoIg+yLdkPta7imW
	o7kwghbK9MmRXVy8P9TsVuH20vNHGbo6b6vIeeIAmJnaalmav99MunkJxMj1sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvIhrKxr/EBu+615Dq6VhsxlBFePOPxcYzgUF7RjckE=;
	b=GNXTF5iaHL+6h7QUImKiW8UsaqAtt2UtULu0GR4hZcNXdI/9Z3ooNRa1umSq3kcBc9mFTm
	6DDtG5oGBMiAkwBA==
Date: Wed, 09 Oct 2024 10:29:16 +0200
Subject: [PATCH v2 23/25] timekeeping: Rework do_adjtimex() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-23-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

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
index e15e843ba2b8..b2683a589470 100644
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
@@ -2537,13 +2549,11 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct audit_ntp_data ad;
 	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
-	unsigned long flags;
-	s32 orig_tai, tai;
 	int ret;
 
 	/* Validate the data before disabling interrupts */
@@ -2571,23 +2581,21 @@ int do_adjtimex(struct __kernel_timex *txc)
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
2.39.5


