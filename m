Return-Path: <netdev+bounces-127386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC99753FA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A232AB28BBF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A533E1A4B68;
	Wed, 11 Sep 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IQwDzQom";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjHI0JEH"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66551A3043;
	Wed, 11 Sep 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061407; cv=none; b=Fun8U0+WYiL0rU3MWMbvBcOGCH4bz89mG44uIykIrZsxmwCXQrIIvLWiZNJq5OALhT5OJQwwy3SuCa/TW1PFroO9cI96coEKOLfH0MK9oBJs9zDcEQEd3rOsNeSXrFqeGtvlFnhvzwmua8rjbwasZXjPUJgkrhACuRd+8PSpvz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061407; c=relaxed/simple;
	bh=PnO7iY0qb9wKBk+lNK9zKYpcCsnADcO7+We9SGiechU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNROmnob7kCxdZSKSntnmssVBnU7zegrlL6t+SMehsdCrLlJYQ29y+A8WxyYP4UR7iqhH7XZ90/M24eDjci47YK3RyMv1n5rBlrlVLE4CjK3Kdn3GysIwmZ/y8cOMWlDB2N8kouHuTJKHCKsWm1uvFemXfjVg2exqqOQm8ZhKOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IQwDzQom; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjHI0JEH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0N/XaroQFICqgnhK3vGduw+f5at/sQsia+TyAf5Ymk=;
	b=IQwDzQom4mFyGgJS1W8v3bIBRxaR9WzXvmjao+NVfnKtY28JzDXBfewFhvvxNZ0zC91hac
	8Scxeyuse+eYguoHe7Dr7wgA6VbyUPPZ6xMcDtBWjcrAc0N0rs0HECMVGi/Rke67zSIB80
	qtRPJoK/Uu/0AsM4nfw7YypZJRki5gCzOV2c3SmxbIZ84vjsMnxEnpROoWSvW4JiGYn4ak
	J+/UtnPwqR3uEf9y2SzlsQ+WHgdTTHisq1K3runPd5L5EYZJ7TJZOglYJx1a7Kpzo7Nlut
	/kC/lhUltlfrKvHJsClVzowU1c1SnO0/ByA2QsTti1cYxws1tKTuOghFrKDf1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0N/XaroQFICqgnhK3vGduw+f5at/sQsia+TyAf5Ymk=;
	b=gjHI0JEHd359mnwhQO4wzoawo2qZtvNK/coT0tZUsg/Mp/nTE1iVkXkhdhvEYHdQ+Vd/O1
	lnHEHjMx+2/elaDw==
Date: Wed, 11 Sep 2024 15:29:49 +0200
Subject: [PATCH 05/24] timekeeping: Simplify code in timekeeping_advance()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-5-f7cae09e25d6@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

timekeeping_advance() takes the timekeeper_lock and releases it before
returning. When an early return is required, goto statements are used to
make sure the lock is realeased properly. When the code was written the
locking guard() was not yet available.

Use the guard() to simplify the code and while at it cleanup ordering of
function variables. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7b80dd70062c..e528e283523b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2276,23 +2276,22 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
-	u64 offset;
-	int shift = 0, maxshift;
 	unsigned int clock_set = 0;
-	unsigned long flags;
+	int shift = 0, maxshift;
+	u64 offset;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&timekeeper_lock);
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
-		goto out;
+		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
-		goto out;
+		return false;
 
 	/* Do some additional sanity checking */
 	timekeeping_check_update(tk, offset);
@@ -2311,8 +2310,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
 	shift = min(shift, maxshift);
 	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift,
-							&clock_set);
+		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
 		if (offset < tk->cycle_interval<<shift)
 			shift--;
 	}
@@ -2341,8 +2339,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	memcpy(real_tk, tk, sizeof(*tk));
 	/* The memcpy must come last. Do not put anything here! */
 	write_seqcount_end(&tk_core.seq);
-out:
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	return !!clock_set;
 }

-- 
2.39.2


