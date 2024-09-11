Return-Path: <netdev+bounces-127404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D902197541F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E9B1C20C9D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310541B6557;
	Wed, 11 Sep 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tEGMMMOF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TLAbylad"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFE1A2C2B;
	Wed, 11 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061415; cv=none; b=f1Q8sYmTfJ9u0fx1jX92vwki3EMxFoWHRV6+MadetotqtOcRZzX/B4vQ7uPinqC/lX8mLvoP6/agrKJT5Csq6hLHJ57vxXy+XwymFlYtcpY0hKM7fTwTSy+DWAFeoM8lnTXE6UYEVERpEOxO2Tjnj4KO1+skj++Mau8ya4o+J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061415; c=relaxed/simple;
	bh=Q1MxAK7evr1s/GvckwB/2NTo91/XE4dRZeng2bYX8rU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LBsEhc+4BZ1Ell48kyh+8eKzAixOipgKz8nIiksFIZG5e8+3u/7bcEI2I81UGd9yXW7EUD4gUk/CbEP5cyEqLT3sDz2Zdou5ZRMJKEwBfShLCybPGbyGgSR5OQV+g5jDu/UCx87LczYqnmZxLH2B6Qhpt2TzwDslcJlULpXW2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tEGMMMOF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TLAbylad; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De5uORD/ZvJcTb/IBEuf6TAy+rJsZKOPp0VJdFPG1JM=;
	b=tEGMMMOFlJEk4IYebonlF5av9dqhRTIq7qypCQf2Ta/rddcqgF8mTThYUa/GCJpEcrHKuw
	Y1anFbZFyZ0q8KItP2d+8h7ujyn3+raUExgPeL8lc+8r8NfgXRPppATCn5O2Odz+efCuM/
	4uKTEER1zvPPjrqnes3GP8IxLFzJi71bx6h+T1oG7SZOwvj2GADc1wiY+tnMeZVRn62RFm
	if6JOlRuXl/ReqshPAiOkalXK81KzjEXsYgbCPV/DErAuXezwUG2nrPOz7FZDOmRYsXmTV
	e+MqX1YgwN9+LXgewxUuDPi7rd12pfcym4syNhi94QzXdVL4RF3GBHf6KMF79Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De5uORD/ZvJcTb/IBEuf6TAy+rJsZKOPp0VJdFPG1JM=;
	b=TLAbyladSg86uhL0wSOaCZe9JvfwuCaj65LOs5yRrJj/UNQCDDzErzhcTGBNc0ElO8xDg6
	3ae77f+TN2/CnRBg==
Date: Wed, 11 Sep 2024 15:29:56 +0200
Subject: [PATCH 12/24] timekeeping: Split out timekeeper update of
 timekeeping_advanced()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-12-f7cae09e25d6@linutronix.de>
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

timekeeping_advance() is the only optimized function which uses
shadow_timekeeper for updating the real timekeeper to keep the sequence
counter protected region as small as possible.

To be able to transform timekeeper updates in other functions to use the
same logic, split out functionality into a separate function
timekeeper_update_staged().

While at it, document the reason why the sequence counter must be write
held over the call to timekeeping_update() and the copying to the real
timekeeper and why using a pointer based update is suboptimal.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d92b1f41ba1b..bf8814508cdf 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -780,7 +780,32 @@ static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsig
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
+		memcpy(&tkd->shadow_timekeeper, tk, sizeof(*tk));
+}
+
+static void timekeeping_update_staged(struct tk_data *tkd, unsigned int action)
+{
+	/*
+	 * Block out readers before invoking timekeeping_update() because
+	 * that updates VDSO and other time related infrastructure. Not
+	 * blocking the readers might let a reader see time going backwards
+	 * when reading from the VDSO after the VDSO update and then
+	 * reading in the kernel from the timekeeper before that got updated.
+	 */
+	write_seqcount_begin(&tkd->seq);
+
+	timekeeping_update(tkd, &tkd->shadow_timekeeper, action);
+
+	/*
+	 * Update the real timekeeper.
+	 *
+	 * We could avoid this memcpy() by switching pointers, but that has
+	 * the downside that the reader side does not longer benefit from
+	 * the cacheline optimized data layout of the timekeeper and requires
+	 * another indirection.
+	 */
+	memcpy(&tkd->timekeeper, &tkd->shadow_timekeeper, sizeof(tkd->shadow_timekeeper));
+	write_seqcount_end(&tkd->seq);
 }
 
 /**
@@ -2333,21 +2358,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
-	write_seqcount_begin(&tk_core.seq);
-	/*
-	 * Update the real timekeeper.
-	 *
-	 * We could avoid this memcpy by switching pointers, but that
-	 * requires changes to all other timekeeper usage sites as
-	 * well, i.e. move the timekeeper pointer getter into the
-	 * spinlocked/seqcount protected sections. And we trade this
-	 * memcpy under the tk_core.seq against one before we start
-	 * updating.
-	 */
-	timekeeping_update(&tk_core, tk, clock_set);
-	memcpy(real_tk, tk, sizeof(*tk));
-	/* The memcpy must come last. Do not put anything here! */
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, clock_set);
 
 	return !!clock_set;
 }

-- 
2.39.2


