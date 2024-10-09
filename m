Return-Path: <netdev+bounces-133536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF8D9962D7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A5528316A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69A619259D;
	Wed,  9 Oct 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcOqk1Wp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQX6gGdz"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DF18FDD5;
	Wed,  9 Oct 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462566; cv=none; b=WaLlBkuqM0EwZ9nJs5T5kA6sltcVwiFn3htNdndh0xRGc/29zUgYO2uxaO1bAz5hxcuIg27coN9sVe4x6cgU9YH88tbEqOLZiaaU8GGTMtcDv7sTbICUfG+E82x0p09fFW7Yc8HzE2qjcTWOfChFI6Z5U4jBFtYegUi72SpnKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462566; c=relaxed/simple;
	bh=L3svMwNfFnD1IGZWVUvu4iABd7NGGztlzGb8Neh4W3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cOAt95t+dT1oyIGkBGTOLtABIM73UNvroZT/omOmgliiUSW2lIK4G7AD9Pr4qpOybskQKvl47qwvvcKM88jMRM8CXYQyEYC94r5MP2m3Zz3ygc0JKUAPoGCqcUlGfpWQ3kocPqFAKRsuzr5mBC9lQ4Vj8Aqs76BOhaXg4d0x+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcOqk1Wp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQX6gGdz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoPilZctoG6Xm/IewLUEVe8c/+zKsk2WG02YLl9fzmk=;
	b=FcOqk1WpSdSk/Hm5ralNVoLRh3OjL8kItRcUbfOFdpaRG/8FPctXGqfXXYeznkDezYvmMs
	8YRzxini+77nLDyrZU0/ejuDJ+zgTqVDYJN0DINc6oLUlFhSg+1P/Zi6JQi2O2+lr12QMJ
	HFruOVXNqdfUUvllESfZexTUQAepa8sT/LsBU3aHxX4RM41LKGPEuYN9tuYbDUUtOQKX7A
	B0iFaWmEtEgvUTMkSlUJSzJYJu0yBloRLWFmEJ/5s+yk5rM7e1OhsDWRA/MjR9WTZKBIJd
	dwqIUhGxQw/EJ4Qn/Qgj+rO6apxQ5HXdrL2It/v2RCpwWUUXR/PpptLqYbPpeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoPilZctoG6Xm/IewLUEVe8c/+zKsk2WG02YLl9fzmk=;
	b=PQX6gGdzlYhcFJz/OcTuPbG7p1ZKn6wCk+8eHaElrh5qPC513Ba0thrTGbwFvIdLHQ+TuS
	Eqc/f+Qn3NU7mKCw==
Date: Wed, 09 Oct 2024 10:29:18 +0200
Subject: [PATCH v2 25/25] timekeeping: Merge timekeeping_update_staged()
 and timekeeping_update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-25-554456a44a15@linutronix.de>
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

timekeeping_update_staged() is the only call site of timekeeping_update().

Merge those functions. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 67d7be2e02fb..d07eb1946ff1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -529,7 +529,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
+ *    timekeeping_update_staged(tkd, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -775,10 +775,21 @@ static void timekeeping_restore_shadow(struct tk_data *tkd)
 	memcpy(&tkd->shadow_timekeeper, &tkd->timekeeper, sizeof(tkd->timekeeper));
 }
 
-static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
+static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+
 	lockdep_assert_held(&tkd->lock);
 
+	/*
+	 * Block out readers before running the updates below because that
+	 * updates VDSO and other time related infrastructure. Not blocking
+	 * the readers might let a reader see time going backwards when
+	 * reading from the VDSO after the VDSO update and then reading in
+	 * the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
 		ntp_clear();
@@ -796,20 +807,6 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;
-}
-
-static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
-{
-	/*
-	 * Block out readers before invoking timekeeping_update() because
-	 * that updates VDSO and other time related infrastructure. Not
-	 * blocking the readers might let a reader see time going backwards
-	 * when reading from the VDSO after the VDSO update and then
-	 * reading in the kernel from the timekeeper before that got updated.
-	 */
-	write_seqcount_begin(&tkd->seq);
-
-	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
 
 	/*
 	 * Update the real timekeeper.
@@ -819,7 +816,7 @@ static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
 	 * the cacheline optimized data layout of the timekeeper and requires
 	 * another indirection.
 	 */
-	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	memcpy(&tkd->timekeeper, tk, sizeof(*tk));
 	write_seqcount_end(&tkd->seq);
 }
 

-- 
2.39.5


