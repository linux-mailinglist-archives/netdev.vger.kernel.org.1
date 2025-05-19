Return-Path: <netdev+bounces-191423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0963DABB778
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F2D3BC178
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8232741D6;
	Mon, 19 May 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JlkUpmjm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ufBKYnxt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9326A0B7;
	Mon, 19 May 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643619; cv=none; b=VlmqPIPMJ3K1YowA+I5D3N/yB7m7M5SUopOirg3MbExkKur4SBk/sssAVHsnZ+sGXTgcQnDX3PnL/vafMXUgQSOJ2b4H6+KFuFdIKOso/yF1YlfI0Jcom/Fv80N/5umnTR8f3ege5MMa2w/T9W1Ztr3vvKYdisTX0nIm7LrZJf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643619; c=relaxed/simple;
	bh=P+IAhiMIcgpF3Jrm9ck9UV2UsqNIxRlBV8q+5p3M7LM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sMRhcrgx3Gxt4HgdxfJx2DVa/E2qMc0NVY4bn5UoPOSWDL+98eDeVvZR9qJVRUwD8+/1ecWNtXlPvc/pscGVEe6xfd/BEbXRKdsAs7HQISMlkNRboFBRl9ihBTPbKyPyQaCL4sHsBuvIeRjUsDFz9UGl3JI750svWftuKHcYQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JlkUpmjm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ufBKYnxt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.717614086@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uq204vGdukuNtGTu4sXgHo4KBp09iA6KFw5f5y1ADAc=;
	b=JlkUpmjm15g3pRItJu1gVrEBCVdq33V9xgO3wubJjdISUCNqy3YEkda+DHYUbg0eklf/si
	BpFDMLDFLcHI5BQrPtXCG2PIY6RMthY2LhFt6gWarMojQLYsisNy8ktCdnhyzEHQIDVCTK
	nvQy2V7z8XDnfm5ki4uPamgHXCKMD7ueWgivHoyS3sHHJVo6xWRosPvWrOUR6Pwwt2AQBQ
	MikEU/OA6c/R0VyjZkhmbHu7K+UqHgKPkqhMDZu1c2zbYCeaVoQFrvPbj95CS/80d81IS8
	mh/p6aU2JxYLH/tJzAG2AE3wOL0mnghMs6yXEjx4WaGgHBmV7u5W/ktUsWxQMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Uq204vGdukuNtGTu4sXgHo4KBp09iA6KFw5f5y1ADAc=;
	b=ufBKYnxtRZ4RLJxeZ5myBjd7KWfGZ3K/52hf2QTuAsZ/d5fAfnfE5bOtKRSNaEXXHrRH8K
	oMEoaFqtAEvoFNAw==
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
Subject: [patch V2 18/26] timekeeping: Add minimal posix-timers support for
 auxiliary clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:36 +0200 (CEST)

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
@@ -2741,6 +2742,26 @@ bool ktime_get_aux_ts64(clockid_t id, st
 	return true;
 }
 
+static int aux_get_res(clockid_t id, struct timespec64 *tp)
+{
+	if (!aux_valid_clockid(id))
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
 	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)


