Return-Path: <netdev+bounces-127363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA17975372
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D1C1F243D4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8846D1A00F4;
	Wed, 11 Sep 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jOhRNoy5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oPcsAEUM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201319E986;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060683; cv=none; b=OHWCtdtgWtTnKvcYfS9dqcR62KqnlhhYvsUi74437xapuZ3l7YHOsrVSiLc2HcM/jVnKRvz1fyzsZ55jdnqR8eyHjPqc7lwKbEeZybYx1a5Zc+6ReiZjEBu3sw94lRaCaWsWIEvK8gp9+XiVw6usWYeKt9n9889xyaJyDiDmALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060683; c=relaxed/simple;
	bh=bolCJSlXPwuNlLvo9JrEUkdBWj4DuVyS3W2/UOuZbPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VK0kETbAyR1rpzFScQl4eg/o0ZcmRf3yzgKzYWZ5rd7tkwtrQy+ypm6xtf9ds0SGjIIe8RgRr38D0DZl9Tq96BGusfToWt0FCRXUbvEMmQk+wG6GY92yt14sFd8aW1UGtlacfeoW08QrdOpBjPCgARZTXjo+mNzPw3+7ccgxwt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jOhRNoy5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oPcsAEUM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofWg+DYj+lK66Y5L8QFevXKM3R5+RFLSO92Pm6cRBfI=;
	b=jOhRNoy5M744JOe7ROY/REPakveJNnE3MAcrVVBzIczx7tAwebt1iOmbwEaweAU5D403vS
	jKwM3MAllBcSE4K4uORr3Nv1DxvaBAdyLQRPftG/KbvvrPjPdv/73o1+QS9pWjuBZ+5uXi
	E4OhQQ7Gx/yXxwhBU07t3ij7T5e7H6taOAQf53mMhtfOf1M0oh0WXZNfNa6aJzzJRohrMJ
	9VprXkJtczoUnQCvamievIDw1IrFnC1knlHm2qcFpGUpOiiigb5THv86W+LgJINvl3J8TU
	2+zBsr3cfOrgybmzLRyMcdphH/8+7xbgxmaMwCAGe89XKLE3yYP4yDyX+ByZmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofWg+DYj+lK66Y5L8QFevXKM3R5+RFLSO92Pm6cRBfI=;
	b=oPcsAEUMf5auH04uRtUMNgxgfo0FH2xGJFErDmvZpY0O32jOY3TL093S3NTchUvMbH/0MM
	NoRx5NhPRxtI02DA==
Date: Wed, 11 Sep 2024 15:17:41 +0200
Subject: [PATCH 05/21] ntp: Convert functions with only two states to bool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-5-2d52f4e13476@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

is_error_status() and ntp_synced() return whether a state is set or
not. Both functions use unsigned int for it even if it would be a perfect
job for a bool.

Use bool instead of unsigned int. And while at it, move ntp_synced()
function to the place where it is used.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index eca9de85b0a7..ef758aafdfd5 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -171,7 +171,7 @@ static inline void pps_set_freq(s64 freq)
 	pps_freq = freq;
 }
 
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return (status & (STA_UNSYNC|STA_CLOCKERR))
 		/*
@@ -221,7 +221,7 @@ static inline void pps_clear(void) {}
 static inline void pps_dec_valid(void) {}
 static inline void pps_set_freq(s64 freq) {}
 
-static inline int is_error_status(int status)
+static inline bool is_error_status(int status)
 {
 	return status & (STA_UNSYNC|STA_CLOCKERR);
 }
@@ -241,21 +241,6 @@ static inline void pps_fill_timex(struct __kernel_timex *txc)
 
 #endif /* CONFIG_NTP_PPS */
 
-
-/**
- * ntp_synced - Returns 1 if the NTP status is not UNSYNC
- *
- */
-static inline int ntp_synced(void)
-{
-	return !(time_status & STA_UNSYNC);
-}
-
-
-/*
- * NTP methods:
- */
-
 /*
  * Update tick_length and tick_length_base, based on tick_usec, ntp_tick_adj and
  * time_freq:
@@ -609,6 +594,15 @@ static inline int update_rtc(struct timespec64 *to_set, unsigned long *offset_ns
 }
 #endif
 
+/**
+ * ntp_synced - Tells whether the NTP status is not UNSYNC
+ * Returns:	true if not UNSYNC, false otherwise
+ */
+static inline bool ntp_synced(void)
+{
+	return !(time_status & STA_UNSYNC);
+}
+
 /*
  * If we have an externally synchronized Linux clock, then update RTC clock
  * accordingly every ~11 minutes. Generally RTCs can only store second

-- 
2.39.2


