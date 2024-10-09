Return-Path: <netdev+bounces-133529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 775729962C7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E880A1F2424F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC931917E8;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBtJJSX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4A3Pqvl"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47567188CCA;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=TglUmN25J3TsIpiBSrDmt5UQGbFFu6DkiSKYkBf72kJ54CiLM55GrIhhiF9VVckH56NP08nCjFStbFTJ1IMY9DnQE3w9ci3ycnNOzrg6OGMYFTQ13cRja/oOez0HgTp0tyOONJ0km8S77JphTkHJad9ZAl4oXHfRR2+4o7xoF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=0pwo+UQw7f3hUgtvEqKtPPSPkIVOdx13yLlbdyuf5fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GAs1DleukshDnWHQVAryOcYQ4RMEGfBJk6v5uxRCFgfqnUnbzA7ETt+Cq3DrziX85kVSiIp6Okx0zJPWnlQK0YJtr//720QRNdv0VnBQ0abH44KD2edFgr8gA4or/ANdT6AvU2jIdqBlkfTqxa8vyuoPcxooBCbH/5gftTswMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LBtJJSX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4A3Pqvl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCa3cuYkyhSihHTRaUKx3sdAbT7LIH+0SPU7UmLweK0=;
	b=LBtJJSX7qBWFutAbGz5ng81Ro8g25UiHGAPwPYKGwPOXE0CeICoaLSzOIgAvGWhGHBGqQX
	iHE9P4iGD51Y8tsnHbca9VDPBPKKAiP17v9a/3LaXlbqy9EQLVotwSOriI+8h91cfsOr3Z
	dHzABIHQ/RYJ8Bj/YmtkH0YCi0SE0LJM/DuwYSURujjZrhqXWL2VNCujkJgw4MUN1AvXDb
	VvK/g/q67TTf3HQtdrlPJpMipt3kOg/bjnU17Xmi9CpYLz9JtEzLkx/TIZrAo2pcQ0L/Ve
	c8U+8FrIRe+3FAaEMEJ2/FzkVu1xfsgHw85+1hed6KrecgB/dgaIwOvePGNkIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCa3cuYkyhSihHTRaUKx3sdAbT7LIH+0SPU7UmLweK0=;
	b=n4A3PqvlXcP9xvO/vFupQ1a7ql9I4dH3o16K4xHnK+KPchkafF8UYulkovuHCgjeeauOAq
	toeza730WucZwyBw==
Date: Wed, 09 Oct 2024 10:29:10 +0200
Subject: [PATCH v2 17/25] timekeeping: Rework timekeeping_inject_offset()
 to use shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-17-554456a44a15@linutronix.de>
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

Convert timekeeping_inject_offset() to use this scheme.

That allows to use a scoped_guard() for locking the timekeeper lock as the
usage of the shadow timekeeper allows a rollback in the error case instead
of the full timekeeper update of the original code.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cc01ad53d96d..051041e92e54 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1519,40 +1519,31 @@ EXPORT_SYMBOL(do_settimeofday64);
  */
 static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64 tmp;
-	int ret = 0;
-
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	timekeeping_forward_now(tk);
-
-	/* Make sure the proposed value is valid */
-	tmp = timespec64_add(tk_xtime(tk), *ts);
-	if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
-	    !timespec64_valid_settod(&tmp)) {
-		ret = -EINVAL;
-		goto error;
-	}
+	scoped_guard (raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
+		struct timespec64 tmp;
 
-	tk_xtime_add(tk, ts);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_forward_now(tk);
 
-error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+		/* Make sure the proposed value is valid */
+		tmp = timespec64_add(tk_xtime(tk), *ts);
+		if (timespec64_compare(&tk->wall_to_monotonic, ts) > 0 ||
+		    !timespec64_valid_settod(&tmp)) {
+			timekeeping_restore_shadow(&tk_core);
+			return -EINVAL;
+		}
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		tk_xtime_add(tk, ts);
+		tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
-
-	return ret;
+	return 0;
 }
 
 /*

-- 
2.39.5


