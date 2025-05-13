Return-Path: <netdev+bounces-190209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53920AB5856
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0600E7B3422
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942ED2C377B;
	Tue, 13 May 2025 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCVmWtpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mRHBgcED"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D62C376A;
	Tue, 13 May 2025 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149226; cv=none; b=ZFzrvoXDKIOQApHuXnRR140nDe8rZ2M8Pw1z7eLsICT5QjlMZrvSFdDexYGtk25l0RJjTI/nTIsXN6U+k4M2uJz9PiFW8sbsOyLC1VPud+ATfisCEdsVNOaYQqU/Uj8yYyeOK435lYDlZOhjSF/snvQ1T9x1341g0MVBDRxjciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149226; c=relaxed/simple;
	bh=T3gvaVQqrA1P0XTGSWSYE7BuwD8qt8nxw+8IRtG2EtE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=fSH9tq9ZNm6j0JY0F8Oq2xyeLI6X/6KOwlfAVesF+BH82SjMl7MnuZnaetdkuomovwXYuTHkj0vPA1JL4IkWNZIKkJFryFB6nM5w+Pbvk1WOVNZ4uQUHu1x03qFoXRm2c+7/1ahhellKUI8ZI2CVKPeZfYFjWOB3+fOQ/rJECFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCVmWtpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mRHBgcED; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145138.154416598@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OSY0dlYZbI+6pUHvq6kewlJZ9+OAPtR4t6sW7tnac1k=;
	b=dCVmWtpzEVlegCuwfT9QIZIQOuBE/eGJDxuLDZpcRE3C9QUmektiyy1F9MoeIdlBzT6WkR
	+R9b+J/zxAwwGL7UWjlnvgqxS8b2FsIM4D3HPkBfHKWOuSLLygEREhfz95WgNzkqdnbha/
	BSL7Y6nkxREPu1m8S0+bwsTTblfGABsVykk4LpWYPuahcYVmzijIce37NKi2twn7nN40/P
	yPdUCu0T4E7myiNtQC+uTAQ3mKTMpQlpI9AX0gjooTYtmFM3JbDfoBNUl6DHsydBgwKoXc
	/3qN/YVsuFuoSLN8bAT7FO1VXpGeQLrxxCsbWgw/PWSVIe6KKxK8mY4CxEG5ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=OSY0dlYZbI+6pUHvq6kewlJZ9+OAPtR4t6sW7tnac1k=;
	b=mRHBgcEDInI54BeIHUIJKO5jkoKVAy5ZKBfiqe7PshmSzU6/NzpJY1yuVAW/ZjA9yaQJ8l
	3q60YyVJtKHrMbAQ==
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
Subject: [patch 25/26] timekeeping: Provide update for PTP timekeepers
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:42 +0200 (CEST)

Update the PTP timekeepers periodically. For now this is tied to the system
timekeeper update from the tick. This might be revisited.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/timekeeping.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -130,9 +130,11 @@ static struct tk_fast tk_fast_raw  ____c
 
 #ifdef CONFIG_POSIX_PTP_CLOCKS
 static __init void tk_ptp_setup(void);
+static void tk_ptp_advance(void);
 static void tk_ptp_update_clocksource(void);
 #else
 static inline void tk_ptp_setup(void) { }
+static inline void tk_ptp_advance(void) { }
 static inline void tk_ptp_update_clocksource(void) { }
 #endif
 
@@ -2312,11 +2314,13 @@ static bool timekeeping_advance(enum tim
 /**
  * update_wall_time - Uses the current clocksource to increment the wall time
  *
+ * It also updates eventually installed PTP clock timekeepers
  */
 void update_wall_time(void)
 {
 	if (timekeeping_advance(TK_ADV_TICK))
 		clock_was_set_delayed();
+	tk_ptp_advance();
 }
 
 /**
@@ -2762,6 +2766,20 @@ static void tk_ptp_update_clocksource(vo
 	}
 }
 
+static void tk_ptp_advance(void)
+{
+	unsigned long active = READ_ONCE(ptp_timekeepers);
+	unsigned int id;
+
+	for_each_set_bit(id, &active, BITS_PER_LONG) {
+		struct tk_data *tkd = &timekeeper_data[id + TIMEKEEPER_PTP];
+
+		guard(raw_spinlock)(&tkd->lock);
+		if (tkd->shadow_timekeeper.clock_valid)
+			__timekeeping_advance(tkd, TK_ADV_TICK);
+	}
+}
+
 /**
  * ktime_get_ptp - Get TAI time for a PTP clock
  * @id:	ID of the clock to read (CLOCK_PTP...)


