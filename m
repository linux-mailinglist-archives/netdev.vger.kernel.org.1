Return-Path: <netdev+bounces-201296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE6AE8CA7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398B95A02A9
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598CC2DCC06;
	Wed, 25 Jun 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nbmGjiy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LTbbmOmu"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10162DAFA0;
	Wed, 25 Jun 2025 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876716; cv=none; b=sNRRUOlMgavBUFJlh1Jf7JDFNNAfcp4dI4yEqv8ozleu94vxixF6g4cnDLGk0ubHW7uywnqDHOTgfMoSqOQvSQFUl3Msb6kwUzIg6TyJ2C5+pXAy5pqbVFFVxy5rH9rWa3/jdWspZi0jbMu7tN3Bt+nD3j0VEDAuZNWFbGksJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876716; c=relaxed/simple;
	bh=ifhBYbyQoLoOEP0V/rScP3Lnd/vAGmiFG9RmYtS/9s0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JcJmNtRSiPALakepL0fcI80vuXCCQU5d4mCgxnO4no1ZCWdvcY/RlKAlG/fg9JtWmrhu0RxkBWNvvQXGngVfCOUpJVxosTGdhScZTYdaAyrci2Rp442ygoS7WN1FfSnC6npRschEE0f/3OL/B8LERdJLLVimDIlr0ai/Yzl4k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nbmGjiy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LTbbmOmu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183757.932220594@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2OZ/Wg7Ni70vaDwsYrtM9Y4qPN2qsvNLh+LjPX9FZhA=;
	b=4nbmGjiyWke1kyFWf0M8WDAf5Q8793rAXmt5X3p4MIRIhW5DQe+cFqfc/jScGS+anTUPfX
	vEr7ydwAu7OtWjewkiEbLA7sQXOt2eXuLavaDsE8Hm12usIMNlcrHLIWIQ+QqXHlnSaQkf
	jOdxbB/j4LnxNpvStNoCeNZ2oBhgtL8mtTJekbVBSW6+xkH+PYUiV61UfXpmpfNeixhgK1
	4J6/+M4o8VrXZSP+CGb+faKnesSmGXlfbJ1VJPmxt4GkQ77cZ1PqQlHxW2sRFHLPqV7wFK
	10TIqPYtr2uBup7k3cXeCSZJAdLjjh/2rzk7W7SrfHjniNrmSAE9Wj1d9SzNZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2OZ/Wg7Ni70vaDwsYrtM9Y4qPN2qsvNLh+LjPX9FZhA=;
	b=LTbbmOmuklm+pYexptYMrG+IDi+Bm58cMOUGXBmniz9SDTLUatQWOntLtUjm50W1NrGGRU
	2kCXz3Iz0EkGjfCg==
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
Subject: [patch V3 03/11] timekeeping: Add minimal posix-timers support for
 auxiliary clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:32 +0200 (CEST)

Provide clock_getres(2) and clock_gettime(2) for auxiliary clocks.

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
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+	[CLOCK_AUX ... CLOCK_AUX_LAST]	= &clock_aux,
+#endif
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -41,6 +41,7 @@ extern const struct k_clock clock_posix_
 extern const struct k_clock clock_process;
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
+extern const struct k_clock clock_aux;
 
 void posix_timer_queue_signal(struct k_itimer *timr);
 
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2655,6 +2655,7 @@ EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */
 
 #ifdef CONFIG_POSIX_AUX_CLOCKS
+#include "posix-timers.h"
 
 /* Bitmap for the activated auxiliary timekeepers */
 static unsigned long aux_timekeepers;
@@ -2744,6 +2745,26 @@ bool ktime_get_aux_ts64(clockid_t id, st
 }
 EXPORT_SYMBOL_GPL(ktime_get_aux_ts64);
 
+static int aux_get_res(clockid_t id, struct timespec64 *tp)
+{
+	if (!clockid_aux_valid(id))
+		return -ENODEV;
+
+	tp->tv_sec = 0;
+	tp->tv_nsec = 1;
+	return 0;
+}
+
+static int aux_get_timespec(clockid_t id, struct timespec64 *tp)
+{
+	return ktime_get_aux_ts64(id, tp) ? 0 : -ENODEV;
+}
+
+const struct k_clock clock_aux = {
+	.clock_getres		= aux_get_res,
+	.clock_get_timespec	= aux_get_timespec,
+};
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)


