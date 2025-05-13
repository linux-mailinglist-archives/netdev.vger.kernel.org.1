Return-Path: <netdev+bounces-190208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6727DAB5863
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23C8867906
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF152C374D;
	Tue, 13 May 2025 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pMeIoYv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CkKs/Bhj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F92C2FD3;
	Tue, 13 May 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149223; cv=none; b=K8rBwKccfoFEQ9dEmizUYwmhkHlkwAReOFpRuZIAKaC7klEwb4gAx40c8m3mGHfQMZHeAtu5mwk3/3c8T6B7K0roDI1AlR54ddJs+m9kHElJKqDZfNY5FPWb4oLEL7wswvht35aRTcciPLZcPaMqJuAcsstMPDD8B4W+y8+QFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149223; c=relaxed/simple;
	bh=BpeheMH6uIvVAFP8rYXlm1Dx+yNSML3xMiYiUukl6ZM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QPOrlRNsViduaT6QpVAuVkfArUEiGxN5k9upadi4uWF59k7sPxnMoe8q8UUkpSXj0j4ZKC1AA0XTKyNXxX8nTV4IU6tnLiffebkDtw5kWzeAT/evGZ0WuF5Qxuywvt3g9BLQQnkgvI42OUeodPM9PiS+O84NzYjBNAr5Xh6TM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pMeIoYv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CkKs/Bhj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145138.095772163@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JI4r1HUrTTSZl/aLlR5MvJoMLiHIykI2Fsz1lp+InB4=;
	b=pMeIoYv/PLQqAsIvYQR2pDin+lzW2HPz0z5SYGDY+VKWHu4rBSy8mXr8X5o/Zzr34FeA6H
	tTgAXii1TzYfaudK5GOMoGrEd0nYAouCx9sADCWt+XHMuz2r8AsFxKnldxpnJr5Q0wVu/q
	1WETfzDywkALi8B6aeKz3DHkzRT5pNiyPHfJqGqbq+D5YLLEkE9hUzgXGPDbsGuxz45Zds
	wEYFS6rCzMwEdyeu5zkHUTdEZ6tO6/Lbiwpw6GYDkD1pm7ejGnG4h93ygryJAIwV6DYQ03
	VayvT0jOvZOWAVUq58Z0F4YEVvrUD5NENfn8nNdGQ86QG58DWgjj/3Qz37JPGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JI4r1HUrTTSZl/aLlR5MvJoMLiHIykI2Fsz1lp+InB4=;
	b=CkKs/BhjsufBRs5g7yp0U/YqLp78MoOQBDwt4EoIWRrPgnPf+G4RgVLwwccU64t9GYoY9G
	FUg62wtZASActKAA==
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
Subject: [patch 24/26] timekeeping: Provide adjtimex() for PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:39 +0200 (CEST)

The behaviour is close to clock_adtime(CLOCK_REALTIME) with the
following differences:

  1) ADJ_SETOFFSET adjusts the PTP clock offset
  
  2) ADJ_TAI is not supported

  3) Leap seconds are not supported

  4) PPS is not supported

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2862,10 +2862,26 @@ static int ptp_clock_set(const clockid_t
 	return 0;
 }
 
+static int ptp_clock_adj(const clockid_t id, struct __kernel_timex *txc)
+{
+	struct tk_data *tkd = ptp_get_tk_data(id);
+	struct adjtimex_result result = { };
+
+	if (!tkd)
+		return -ENODEV;
+
+	/*
+	 * @result is ignored for now as there are neither hrtimers nor a
+	 * RTC related to these PTP clocks.
+	 */
+	return __do_adjtimex(tkd, txc, &result);
+}
+
 const struct k_clock clock_ptp = {
 	.clock_getres		= ptp_get_res,
 	.clock_get_timespec	= ptp_get_timespec,
 	.clock_set		= ptp_clock_set,
+	.clock_adj		= ptp_clock_adj,
 };
 
 static __init void tk_ptp_setup(void)


