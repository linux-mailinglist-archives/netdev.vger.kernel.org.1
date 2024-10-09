Return-Path: <netdev+bounces-133514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AFE99629D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82C3282E0D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFC7189F3C;
	Wed,  9 Oct 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nrKYwAtP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lk2cDjxI"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17813188737;
	Wed,  9 Oct 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462558; cv=none; b=Z4Ruw1lutDiCXFMriUck2WIqdUyBdi525WqRLIHGToeWhSaQVr858WEX7eGORdujO2IZJQTwumO2xUXqgR9zJMHaYxkixJvuVo7bjdyEg/Ae9H4ylMyaAhqeITFKdPfV9+N3ooOBWXz9FJ3f7whuh9Htld//1RShCgq3s8jOydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462558; c=relaxed/simple;
	bh=/uNkAm7s/oMcGkPl0Y/czgMjwjkuogvFlaage6etO5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JH8vZL+lfrDuaW9N6HAyqXcLQzPQoMCQ9FXQQDKjVlAqO7bgrtirS4gmk3rwUUCiaVQt+t0vyf6ujh2hZyvHZ4BhKZL81exlc4CR+sS7SA6kVyZYs1KKVBbwBVjlVloBauvSM0sg23be71PYvOX/D2MMTEMuSd6+OJVpJTVqDDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nrKYwAtP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lk2cDjxI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTWEOkMgCycRVxphDRFrN3uHtpIO2IbyhOjzG4V0kAg=;
	b=nrKYwAtPcGQvrzCBhXB5niUCUFZZVpON6wwhLnqLjnBPO2yiup4dEeuHWZGZUoshdbmX+F
	ylhfk4EM/5zhEIN92/gh9F4DLIdY/ccDkL7uIBQlqgXLMSzhYhX3Jh0WzzkPYseDZYc8wL
	+6B1Nc7AC0TRYkWrcNmqzVh/bHMJmWYbXn5tGMrwuCd4MJscta9t4RZ54DInp0B5HzZTpL
	W5Kgtq6TKhRifovadeTuyMnj+KhhrHW0AeXNk0LkS3066tDKAZtNmQqqR62Vo8kXQ+hB8W
	rr82WkC27s4oIiqMCUdvt9/aWBvCy391r+h44RXhzRWeFGWJLz4lDiHhecIMOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTWEOkMgCycRVxphDRFrN3uHtpIO2IbyhOjzG4V0kAg=;
	b=lk2cDjxIFuUKsWR6IPIL7ObiQsMRSQSVEjnxsuUpX+vVxYSCdZBbDEefO10UYhSU3Znymk
	djIvhdqGczqugsBA==
Date: Wed, 09 Oct 2024 10:28:56 +0200
Subject: [PATCH v2 03/25] timekeeping: Avoid duplicate leap state update
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-3-554456a44a15@linutronix.de>
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

do_adjtimex() invokes tk_update_leap_state() unconditionally even when a
previous invocation of timekeeping_update() already did that update.

Put it into the else path which is invoked when timekeeping_update() is not
called.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4e3afe22d28c..c4dd460b6f2b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2596,8 +2596,9 @@ int do_adjtimex(struct __kernel_timex *txc)
 		__timekeeping_set_tai_offset(tk, tai);
 		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
+	} else {
+		tk_update_leap_state(tk);
 	}
-	tk_update_leap_state(tk);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);

-- 
2.39.5


