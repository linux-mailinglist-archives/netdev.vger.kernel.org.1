Return-Path: <netdev+bounces-127400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B8975417
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C31F264FF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D91B29CA;
	Wed, 11 Sep 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfw1ByL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RrpXnyUy"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185F190052;
	Wed, 11 Sep 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061413; cv=none; b=iv6DuxjhN4KqUncfB8pt/i5C/xjI4X65rcb/cA0n9tl11txbEXFiigExVZMSF3doq4D2k0EJFCz+7ELQm/Ckxh5L1tN8CGG4aRiPcOsv0pBxjq9w8FfypbKDxnJmtovSPf05s9NYNkNYPREZVF3uVzC2fCga5g+w5jfONHH/gmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061413; c=relaxed/simple;
	bh=cF6oOAMfCeoTCaLpR/GZtD9S8qUF3cOcM6UGbdVx5+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2PK0FYtgRSgoEdnUd46hB4VWYaB2UgRMKpBvyme+drRrY6kTJt0tNRdOhe91niVeTVR31JfFb45WehWnIieuWYy7sCPcOxY9D/0c7AL3ncvoDKRRR9BPXDyrEXj6dIjV5CM44XV4NW3XOIwo7HsnRqPZujocEDnsZI8Fdey4KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfw1ByL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RrpXnyUy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDMkmxjITMPgOf2byw/Xt3H3B0E1TY+ptDWM2cYP80U=;
	b=sfw1ByL7bBp7d0WPlIuC0bO3X8BckkffXruGH3fOqv49Pctr0clIy4Vz669FXT+yd2S+QT
	U1cexsFbtmfRtYKNbNYo+kXOywPNP26TJauQR63Cl1CS/R2ZTHj0AWdAePF4BD9fDSHcaf
	0qfkseWRQDReI48g5M7zVQtkRsJnn7+ko/Wx/0cwKBMgxRjT8MCoLB8kCEaQtWK78u0ZZG
	SiK/LMe9NuHYLJDr+dQYeDdUZCtHBlYmKBAuIZStho3fbPhw3k/xwlFYVcG94wfULKBnvC
	sUagte0O0+rsFVJVThSvNZ5nFeACQckp7vGIo5YQyUlEu0/SWqoX55AKmiUWzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDMkmxjITMPgOf2byw/Xt3H3B0E1TY+ptDWM2cYP80U=;
	b=RrpXnyUyhbcguowfOb2LjHWLvYxDsdqwm7bx5GdxQeYWcUQ1nf8ptDqhp0qdmXo7K/RsLV
	3W1CjpokraucYGAw==
Date: Wed, 11 Sep 2024 15:30:04 +0200
Subject: [PATCH 20/24] timekeeping: Rework timekeeping_resume() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-20-f7cae09e25d6@linutronix.de>
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

While the sequence count held time is not relevant for the resume path as
there is no concurrency, there is no reason to have this function
different than all the other update sites.

Convert timekeeping_inject_offset() to use this scheme and cleanup the
variable declaration while at it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 244bb58dcda9..d4a0d37f88f5 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1912,12 +1912,12 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
  */
 void timekeeping_resume(void)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct clocksource *clock = tk->tkr_mono.clock;
-	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
-	u64 cycle_now, nsec;
 	bool inject_sleeptime = false;
+	u64 cycle_now, nsec;
+	unsigned long flags;
 
 	read_persistent_clock64(&ts_new);
 
@@ -1925,7 +1925,6 @@ void timekeeping_resume(void)
 	clocksource_resume();
 
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
 
 	/*
 	 * After system resumes, we need to calculate the suspended time and
@@ -1960,8 +1959,7 @@ void timekeeping_resume(void)
 
 	tk->ntp_error = 0;
 	timekeeping_suspended = 0;
-	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, TK_CLOCK_WAS_SET);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	touch_softlockup_watchdog();

-- 
2.39.2


