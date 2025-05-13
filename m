Return-Path: <netdev+bounces-190202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FEFAB5852
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7545119E03DF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEAF2C1E05;
	Tue, 13 May 2025 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OFS1kXCX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWjUTurJ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC102C17BA;
	Tue, 13 May 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149213; cv=none; b=G6JAHb+kiURbDiCrLYnMppQ0FkjlWCDBaO8ah2yHeTWfx99TeZK8Tb+u6StUPeWLkqMu9axBRUinayEJg8utf8JSVaurPJsvbxR5CWEyOOLpgQgie1iIrkKC5Rpv2fNixuYIiL6lKL+Gl7CrzwE4Xgp1aHXZijXWGcyLzYG73ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149213; c=relaxed/simple;
	bh=hAz5q0VQ9Y6FyczM+6q/3+WlPu4wpj1SSncb9OxeL3o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nrNVugBh2Yx0G5lGUJ6JCi4gHftgujkkY/k65XcG7cVRAw1W/yZVVl0vK5b2oxEbrv6wY92YQARnc95NvU/yLnaWCFKka+ndBu3h8ZsYrc3AkrU5wFgmjLtptDYTHhfyXWDK1OS4KM+dJPd50P1ZE8PK0DYoRGTJn6xJti9u9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OFS1kXCX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWjUTurJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.740202418@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xQLmb6LJzfcom1fG3G9nnmc6HzchRgiWvlWeZwisPhI=;
	b=OFS1kXCX//2vT6SrwQ7tErP3tug+zIFeInlbWFy/uK6odA2F1oGwSMRPfVMjYqnQmrkfQu
	03/LOQ/77HRyTrH+wYWyo/hT/bJfHuK7bq+p0NqW6MQpHbbTq55NVi316rcx+WtVLUrPmF
	3oTmPP6jhCjiAT2mAbwf3dD2TvFsqCAPJEdiOHqqtSUF/mQf9acXRRI1d16M9eRztV/aU4
	I4h/BBq6epr9ssrfaliIc7BaEmgnpVXE2gFaDq1w/dY/vjsdBpRCzzJwZg1BGuj5VATB6v
	0HyQlSMtZX6+cvOalYfQ7ETM9YDrKSCUyPyTH1W769zKYwmmNZqey7rDrRHjFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xQLmb6LJzfcom1fG3G9nnmc6HzchRgiWvlWeZwisPhI=;
	b=qWjUTurJtnv51mFjeAIvBJ9v/Lsa7yWrMPjLG5dhJxYbZVtMCNKGCheAslz9fBFWMtlLYW
	E4K2Je4pgbusuICw==
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
Subject: [patch 18/26] timekeeping: Add minimal posix-timers support for PTP
 clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:28 +0200 (CEST)

Provide clock_getres(2) and clock_gettime(2) for PTP clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/posix-timers.c |    3 +++
 kernel/time/posix-timers.h |    1 +
 kernel/time/timekeeping.c  |   21 +++++++++++++++++++++
 3 files changed, 25 insertions(+)
---
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1526,6 +1526,9 @@ static const struct k_clock * const posi
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+	[CLOCK_PTP ... CLOCK_PTP_LAST]	= &clock_ptp,
+#endif
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -41,6 +41,7 @@ extern const struct k_clock clock_posix_
 extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
+extern const struct k_clock clock_ptp;
 
 void posix_timer_queue_signal(struct k_itimer *timr);
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2655,6 +2655,7 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_PTP_CLOCKS
+#include "posix-timers.h"
 
 /* Bitmap for the activated PTP timekeepers */
 static unsigned long ptp_timekeepers;
@@ -2741,6 +2742,26 @@ bool ktime_get_ptp_ts64(clockid_t id, st
 	return true;
 }
 
+static int ptp_get_res(clockid_t id, struct timespec64 *tp)
+{
+	if (!ptp_valid_clockid(id))
+		return -ENODEV;
+
+	tp->tv_sec = 0;
+	tp->tv_nsec = 1;
+	return 0;
+}
+
+static int ptp_get_timespec(clockid_t id, struct timespec64 *tp)
+{
+	return ktime_get_ptp_ts64(id, tp) ? 0 : -ENODEV;
+}
+
+const struct k_clock clock_ptp = {
+	.clock_getres		= ptp_get_res,
+	.clock_get_timespec	= ptp_get_timespec,
+};
+
 static __init void tk_ptp_setup(void)
 {
 	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)


