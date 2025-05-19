Return-Path: <netdev+bounces-191415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F82BABB75F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEC5189A793
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8A26E17B;
	Mon, 19 May 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MCgMmD64";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jYUjOODm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4626D4E0;
	Mon, 19 May 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643608; cv=none; b=FyvSsKEs9xR9SXC7+m1q2r71pZAYngoiV1NaKrBezvD4mPvMkCQ6PEglgtPMw8yvDrjDAtr/u6UnSLnxkOE2JjlYOmv+9IzSRpnqOyzwij3gcFWbqfIoZVyARai6eVweQszruhNcAdfN6SPOKFktMbzYhLsEX+BdtwdQU3iNtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643608; c=relaxed/simple;
	bh=GioWYcEPVBLBlgv0bwyNh9fZ/8oRyz0T+6HGCQdNxag=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kP8SyH2gG6GmTLxIHYoamNzt2UtZPSot75AljNmqenMtIj8uThQL2DmkjCkZGShcAV2htbCekm+CSot5q3NCNJf1B2IgHGY6HZ96iUzbq9b2YwTFwvIIrt6Z8HehXoCr5hDzCgJuEbPyeZV6WH4ZCKKUMldK4MyHFCUPSj7brew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MCgMmD64; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jYUjOODm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.160967312@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L59LdIitUfKjSYztV2EKhNf1AwVq0IEXHtjU+QOwZVk=;
	b=MCgMmD64q2Q/1G3bOPJRGxXbjJyX/YCoAxxHayGxJBXhgOXmEO7VvbgvtV3ZfdsgjZEy0A
	NKZiAd00rVJh7xs5Sh+1E9gi2HSbyTa0FY1gMwpnSWIiXxpB0xeMP2M+nHQ3gaKho5QCkN
	kr+13FUpbvM4LkPCRDMFp8TaKRdR+3zJk5+FdStHbcxTzWrdJE5QKqdZqvyl+4yx9DqzCM
	cG8/eh90tBXe1r/4RWtX8lzaoFuSRs2j8XJnkjo08XQIgY/swaswgo4Q+S6ovXRQSBmFv2
	N4riTyspDl9wQhokgmP3Qi7TgHCOPlEhRTxw0Krp12DYdqRSqk9HafNYdFB3qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=L59LdIitUfKjSYztV2EKhNf1AwVq0IEXHtjU+QOwZVk=;
	b=jYUjOODm3rTJVmZ1tRUpDt7jzlJHhQzdN87AsLbAvAKJ7WW45hERx/FfXRCE5Hg13kU6nD
	mNXu7brEbp5wJjDQ==
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
Subject: [patch V2 09/26] timekeeping: Make __timekeeping_advance() reusable
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:25 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

In __timekeeping_advance() the pointer to struct tk_data is hardcoded by the
use of &tk_core. As long as there is only a single timekeeper (tk_core),
this is not a problem. But when __timekeeping_advance() will be reused for
per auxiliary timekeepers, __timekeeping_advance() needs to be generalized.

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
@@ -2196,10 +2196,10 @@ static u64 logarithmic_accumulation(stru
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
@@ -2252,7 +2252,7 @@ static bool __timekeeping_advance(enum t
 	if (orig_offset != offset)
 		tk_update_coarse_nsecs(tk);
 
-	timekeeping_update_from_shadow(&tk_core, clock_set);
+	timekeeping_update_from_shadow(tkd, clock_set);
 
 	return !!clock_set;
 }
@@ -2260,7 +2260,7 @@ static bool __timekeeping_advance(enum t
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	return __timekeeping_advance(mode);
+	return __timekeeping_advance(&tk_core, mode);
 }
 
 /**
@@ -2598,7 +2598,7 @@ int do_adjtimex(struct __kernel_timex *t
 
 		/* Update the multiplier immediately if frequency was set directly */
 		if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
-			clock_set |= __timekeeping_advance(TK_ADV_FREQ);
+			clock_set |= __timekeeping_advance(&tk_core, TK_ADV_FREQ);
 	}
 
 	if (txc->modes & ADJ_SETOFFSET)


