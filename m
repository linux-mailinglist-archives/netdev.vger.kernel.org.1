Return-Path: <netdev+bounces-191416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203CABB762
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5680C189AF4A
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E291926FA5B;
	Mon, 19 May 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWRTwa77";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JjeeJbY9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CEA26C398;
	Mon, 19 May 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643609; cv=none; b=gRBo1PvDVxhvas5OppnBCOZDNnhT28aJ2q6x95ZeE2gpqKthWWrzypGR6gbKqTCZF6f+4sD8RMRGWlzO82hzlw2XJIXGE0X3W5QlHnag4maPomuXzBdZhgh0pzNDIC1TFCuT3+9VCcMIZM4EY9wByFwBj/bhd4M1K+TLDplJRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643609; c=relaxed/simple;
	bh=sxnsxo8NePjVpwqKQXtJgvbXVeOovTkoNLs8rQJcnsE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BjVGTsVOUdyJrncHqJQXSrlsm+PwHq9R11tErlnDqF4T0TLPCNBOYhTincY3fjrTLC8QF2/pPFYcyWPxiptG3wclUjBzJVHZ/K7M3HaUzw4REFtLL26VmvwNSOLzWiTPqvUnh8vF1LKe59SS3jsY7WuA/c1aNHbxL6YPQitlWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TWRTwa77; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JjeeJbY9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.223876435@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HuVmpPi2kJmcidRqbYSEzF2Cc0Jdkoji3gG8ZP/9JpY=;
	b=TWRTwa77HcGPi/OVVF/nDaWEUaHWVqQYGsccHIEKo7QsMFXGHUHUtTv44fSd4+ycBNtLWj
	JacNpeU8LON6eTvv3JiLUQhTsF9mmBgzTkKeWdBz59GSavAxA55s7MjikyXefD+1Y+jhca
	kgu6QS2a+sZDk6ip/z2KalS8VrqDeNWbEaPLX8M2aCZZIFZ3T7CZvToh0SEDw58I7XJ7KS
	wW2FYnObnAAqfnRzNzo+A6jqC+TnIYtDGKuowll7TnjffEOle5y/bziBHl7cinfDyn/h9+
	WRItoFfjcidmpaejQSHjdaOHDg+H3RCe/cYyfyQdsN/96qyFhGhFiuys7s+5KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HuVmpPi2kJmcidRqbYSEzF2Cc0Jdkoji3gG8ZP/9JpY=;
	b=JjeeJbY9U12r1troW7dSdwJRNiPbutfeVHqW1M0xITz+lu4HjTdtA93sIMA4xr5G6PQkxQ
	AESsBxENUtRZOKCg==
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
Subject: [patch V2 10/26] timekeeping: Prepare
 timekeeping_update_from_shadow()
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:26 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Don't invoke the VDSO and paravirt updates when utilized for auxiliary
clocks. This is a temporary workaround until the VDSO and paravirt
interfaces have been worked out.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -683,13 +683,15 @@ static void timekeeping_update_from_shad
 
 	tk_update_leap_state(tk);
 	tk_update_ktime_data(tk);
+	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
 
-	update_vsyscall(tk);
-	update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
+	if (tk->id == TIMEKEEPER_CORE) {
+		update_vsyscall(tk);
+		update_pvclock_gtod(tk, action & TK_CLOCK_WAS_SET);
 
-	tk->tkr_mono.base_real = tk->tkr_mono.base + tk->offs_real;
-	update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
-	update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+		update_fast_timekeeper(&tk->tkr_mono, &tk_fast_mono);
+		update_fast_timekeeper(&tk->tkr_raw,  &tk_fast_raw);
+	}
 
 	if (action & TK_CLOCK_WAS_SET)
 		tk->clock_was_set_seq++;


