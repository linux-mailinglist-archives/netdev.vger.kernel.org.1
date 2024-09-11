Return-Path: <netdev+bounces-127392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D9975405
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933012893DF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537201AB6F0;
	Wed, 11 Sep 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERnRXz9t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zf5BhUST"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76E1A3055;
	Wed, 11 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061410; cv=none; b=UziTl1uFJstbjKV6crLzasBlIGfxKMhdNUK1LU4rLuZYNStLVXy4XRTzfRTu8jttO0J3+g5puwIq0upMbQ1BGy20HWkkCNsKHqfkyKn6yEVudnlXI7aT1I8V/IDVM09iy2kvKbkr9GsGe5SHkfKyFYceiAFIlsx7jhQO12wmGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061410; c=relaxed/simple;
	bh=vA7knna/LPwJfgUOP3ICSdr+zzkqbT3SeaB70fpeZYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwKy7a4462I5F5tiqmFblrWKDj+UizrsWkpTL4uDeJt9rKIvpw+rrnLHw4F0WkWPJVb4aWYoa2Ut6Q+h6Qx4MevwsmCBm7zmXu2YHiRSXHa01uHvUlouoOW7fYC+S1TffZcuTxZ/nxyBi2JlJD9sUcSXrFgRDt5lyw1QOWq8xUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERnRXz9t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zf5BhUST; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA5NleTI3O9VX4sRx0U/XV0SMMtee51xgFSGfg7aJ7k=;
	b=ERnRXz9t6uXqimsAbceRTuGLpccpxh8saHvNsVM+/ZX59KDjwI8rTr6hVElM8ZiKzqc00f
	kQ1Qm6gmvFiX5g6vU0Pe6YkLX35VpBGyOQVTMMkTzj1HTTlXWr5djbFEKnc7hJMGbhW5hO
	n6SZHuHshYXYuh8skPHKFYQtbjr+lJ4Wq2TFVyi2YZF8qg6LSs7HxNA0ttEFO1g6o3CAgN
	Tt1cuPsZXH7lYkI/3NuCExVhN3wREoeho4bO32sBqOkcNKTXtqTgzcKr2mxXR1V2DKUkTd
	8zA59sslR4rLZJTTTdPSgXOseX7boo1hMH9vhnPCz3+THAsHcngAjGjTP7H21g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA5NleTI3O9VX4sRx0U/XV0SMMtee51xgFSGfg7aJ7k=;
	b=Zf5BhUSTJDSV0Do7rSkYhzvp/cA0MeEBykr3ustNj0XHvaanM0t77Wh3eJu04r9e+2scSK
	FsMdOi32w/MamACw==
Date: Wed, 11 Sep 2024 15:29:45 +0200
Subject: [PATCH 01/24] timekeeping: Read NTP tick length only once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-1-f7cae09e25d6@linutronix.de>
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

No point in reading it a second time when the comparison fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..b877173f88bb 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2130,16 +2130,17 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
  */
 static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
+	u64 ntp_tl = ntp_tick_length();
 	u32 mult;
 
 	/*
 	 * Determine the multiplier from the current NTP tick length.
 	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	if (likely(tk->ntp_tick == ntp_tick_length())) {
+	if (likely(tk->ntp_tick == ntp_tl)) {
 		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
 	} else {
-		tk->ntp_tick = ntp_tick_length();
+		tk->ntp_tick = ntp_tl;
 		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
 				 tk->xtime_remainder, tk->cycle_interval);
 	}

-- 
2.39.2


