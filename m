Return-Path: <netdev+bounces-190192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9879AB583D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3C43BC76A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFE2BF97C;
	Tue, 13 May 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8024oJo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uB9K1t+d"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB432BF3D6;
	Tue, 13 May 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149195; cv=none; b=CiUNcCXwRym1KfNvUfo0tcbRiwNND0jHbO8kOuzDb5s9jJJ4XFW1uwVPUq9MwTHl9A8clVIVWAE/GyP53fJO74PmXiymxLVJ4EZzJKB/WW463gEP3IBPmLD24Q9hl8N2ANqh2pFkYLgNPeHOL5hgOdFEXQbB17b/1wQFz6VrP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149195; c=relaxed/simple;
	bh=Ts5UXLeF9rqqvuYScy5iGUW+EHVIPfROcD6J6t48R4U=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=s/9s1DRPP4TeYSG27cPcCKcIN0xrU/p21oKKPoT9wbi2f2M6HibJOWjX1ZdFKyi0hGBKd7acP8ecTQAK0YQvdu17uYXP/ZecFbIrk3MJctuIzsN1nmQG5OuF1ac845g6L1h0kPhc1lFyiAsWgHhQoQQ1lsTAb/ilZWmo9wRrBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8024oJo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uB9K1t+d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.208548292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NEZ2sVMSeHxflpomI/Cs7zL+700sJ3oBWUqbPABYo8E=;
	b=y8024oJoOPyyQ1Rbi6hgNebHGpdy51GAdFikk7D2tkxY6ABldAy7ZrRmCAV69THfz+u3o0
	P8LxW84enndY3Z3hw0JqHbMMVYGQNamRThbp8LHqmjLDLbJ5Vqns+kAFos9eAUUwINalr/
	suOLAj+WC4Zpyl+l7X6DRyMKdK0nMFI5nbbqJYOHIZeoSa1skbO5AqVx2RZ/tTtf6nh4aF
	6SOdh4mRR/AucgitAxEkes+CTONNUPuAe8ruxYHJZuuE0HZrlA6rrdK5N8iCxiOdRXxX9X
	zAIV0Ph9dKII0y3Kr/OGkjuWQ86hJynJicm+6iSX0zrbU2LPqjR84GM2CoybuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NEZ2sVMSeHxflpomI/Cs7zL+700sJ3oBWUqbPABYo8E=;
	b=uB9K1t+dZ3V0MMTFz3HvFlas69Lch5C2TpanHy3CYA7sgUEnAA8d0zTw+SG+lYOYu2Wxyg
	tna/OhNR/+O7d1Dg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 David Zage <david.zage@intel.com>,
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
 Alex Gieringer <gieri@linutronix.de>
Subject: [patch 09/26] timekeeping: Make __timekeeping_advance() reusable
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:11 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

In __timekeeping_advance() the pointer to struct tk_data is hardcoded by the
use of &tk_core. As long as there is only a single timekeeper (tk_core),
this is not a problem. But when __timekeeping_advance() will be reused for
per ptp clock timekeepers, __timekeeping_advance() needs to be generalized.

Add a pointer to struct tk_data as function argument of
__timekeeping_advance() and adapt all call sites.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/timekeeping.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2191,10 +2191,10 @@ static u64 logarithmic_accumulation(stru
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
  */
-static bool __timekeeping_advance(enum timekeeping_adv_mode mode)
+static bool __timekeeping_advance(struct tk_data *tkd, enum timekeeping_adv_mode mode)
 {
-	struct timekeeper *tk = &tk_core.shadow_timekeeper;
-	struct timekeeper *real_tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tkd->shadow_timekeeper;
+	struct timekeeper *real_tk = &tkd->timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset, orig_offset;
@@ -2247,7 +2247,7 @@ static bool __timekeeping_advance(enum t
 	if (orig_offset != offset)
 		tk_update_coarse_nsecs(tk);
 
-	timekeeping_update_from_shadow(&tk_core, clock_set);
+	timekeeping_update_from_shadow(tkd, clock_set);
 
 	return !!clock_set;
 }
@@ -2255,7 +2255,7 @@ static bool __timekeeping_advance(enum t
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	return __timekeeping_advance(mode);
+	return __timekeeping_advance(&tk_core, mode);
 }
 
 /**
@@ -2593,7 +2593,7 @@ int do_adjtimex(struct __kernel_timex *t
 
 		/* Update the multiplier immediately if frequency was set directly */
 		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(TK_ADV_FREQ);
+			clock_set |= __timekeeping_advance(&tk_core, TK_ADV_FREQ);
 	}
 
 	if (txc->modes & ADJ_SETOFFSET)


