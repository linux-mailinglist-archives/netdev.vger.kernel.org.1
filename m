Return-Path: <netdev+bounces-127383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 187619753F2
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4AED1F25B3A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141B01A2C01;
	Wed, 11 Sep 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRxx1voS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j+iZwqD7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9141719CC2D;
	Wed, 11 Sep 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061405; cv=none; b=bXiVW77jZdY0Xgr1sfpaD522tmXbf9X2pGqC+VykIyTYJkGaBAbKNHOKxKeIIrj8/z7g0FDPf7misiCKPYMpW1Nibp/AbyyfRl3AG5Ue7wCr3UzNRx71mtxJLXftWbK1GleVdDxYmrQckHaCUD6bOlc4WKtOpkqA8OgtyCNEEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061405; c=relaxed/simple;
	bh=8lkN6FU0ipTqqsDOVgVdI2Ku2G1wbeNB6dIpDrLcO2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3UdFtMTBfdvqs0FV3yiusFObd410np/r7OsnCzP89aISLSo7KuPxtTxNOjfxND8K84lJW9LMAfVq6fZXp5bMsM3QwHuMEqmLTr4TsAHDsjMWjyNIBvThDRV9xwpJnFAiHxSVHoY9Cr4tf51+gpKpD+IbmJEPUZnbtEuME6SCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRxx1voS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j+iZwqD7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQuAsuMoVvyWJ2WjfEu5LT2yoBEdFYjUQ3IOgFGdbMU=;
	b=dRxx1voS1wXy+stIMSRhWowCDCQec/A8hKux6aVZyOVWUzDt36xLZ4PHT07bBJ9OHyQPpW
	+20/FnW24xWkfN0xQg6XhC5SyRQyKWS6qv63naDVx/a9Jxh+iAIZp/uFK977OxnTSaexuM
	wilyEOZ9jR8pjBqtWsJWI5b+v0/cIQz5syqzlewd0p/GcxXAOcfCvzjYPnpm463i/4v6Vx
	gnsR3gGC7aBOEuPZriDPjH2gy2mwOOYbcpQRIAOdL3CME6U7yLeBb0grASdRoFzuWZRlPP
	ot1aQeGPUXnz443GMUcEwZ52vOXBs+AfcaPQ+2IVEOUQiOTPzOfSpv88HzR8vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQuAsuMoVvyWJ2WjfEu5LT2yoBEdFYjUQ3IOgFGdbMU=;
	b=j+iZwqD7sZa1063J9nv+4IlmjtQ2pOG5rs/LOIwakSBFBq3NoJX/MGBylD2coxUODCdyZX
	oZal+QHBbVfl5mBw==
Date: Wed, 11 Sep 2024 15:29:46 +0200
Subject: [PATCH 02/24] timekeeping: Don't stop time readers across
 hard_pps() update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-2-f7cae09e25d6@linutronix.de>
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

hard_pps() update does not modify anything which might be required by time
readers so forcing readers out of the way during the update is a pointless
exercise.

The interaction with adjtimex() and timekeeper updates which call into the
NTP code is properly serialized by timekeeper_lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b877173f88bb..f09752bae05d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2625,11 +2625,7 @@ void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
 	__hardpps(phase_ts, raw_ts);
-
-	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);

-- 
2.39.2


