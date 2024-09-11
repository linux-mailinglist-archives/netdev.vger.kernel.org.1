Return-Path: <netdev+bounces-127360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785A97536A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F2F1F271BC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5C9193092;
	Wed, 11 Sep 2024 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaiWKAbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ha/E7eV9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9221885B0;
	Wed, 11 Sep 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060680; cv=none; b=j4+3e1agNylATtOfMOKAdnXHIpZlMxE/Ounu3y7dD1capX5Yav0WF1FW/f995FT2uP06WbHQHo1aDc644w0EynryyHLRuDjTYOEfVEZrC4Kc1yrze+5KXgoqTCbLfOmeJS92FjfbS1j10+mg+7ntt3j1ViFJzytWDsowhlvcRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060680; c=relaxed/simple;
	bh=g9zzwz4V5Qs8RbYfmTH/7d0rG1Do/CrzNfnYcKbCxXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agRpsT5PLgPrUSG9qQHd6UV/hV8gxZGLxNjHLp6p7trxnBpdR36ZM+YTIr2pspl8mmw2Da9lwXf0GPBQwFhCcO9apu65C4cQe5ndHhebTqzsqigZgfOTXkTWCZlPkSIVHtKVaYRaMiOqSKyQxxtNBPeCIFfa6649KLhn6Z1udkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaiWKAbz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ha/E7eV9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfZBbYk+dRlXllU+uOF1Xktt71qqtzKN1W0IDd61nkM=;
	b=JaiWKAbzkmlwIHtyMxu1F2IQh1bIm1Zs3YJt887qUbLh6oQP7fiQ+p4jvVGdwvJWB1F4R8
	/cf1beDZoMaXUwnxAIcnPIKMVl2hwZeXB+LM1hREcBuJZ7Zs00HUK9Wsqzm7/OMmhKXnQl
	ix6TOOoeIQZ9CYizZb1QszrPZbhNDumkZzslAQ1saCNlmQAAfUSVn4JL1sum3FGNjXfHSE
	+PBFGMCtY7glUOPhZQiDAKEWx//Ei6M0UlQr1rT0s14H+KKekIUGqoUjKMYQl05/YNk0EG
	Vb66PGUsq6CgpqI5MeeinRzuizEi2yxlwMvNjs6ksttfamNhGPAU/vRGDINKpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DfZBbYk+dRlXllU+uOF1Xktt71qqtzKN1W0IDd61nkM=;
	b=Ha/E7eV99Wb0WjT4w99EPCwz+ad1nWBL/mfwQJbqiVD0ew52N+pRjCsXZzfxAjLgDc/ix9
	61XkacB8LMvwRwAw==
Date: Wed, 11 Sep 2024 15:17:40 +0200
Subject: [PATCH 04/21] ntp: Cleanup formatting of code
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-4-2d52f4e13476@linutronix.de>
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

Code is partially formatted in a creative way which makes reading
harder. Examples are function calls over several lines where the
indentation does not start at the same height then the open bracket after
the function name.

Improve formatting but do not make a functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 99213d931f63..eca9de85b0a7 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -428,8 +428,7 @@ int second_overflow(time64_t secs)
 		} else if (secs == ntp_next_leap_sec) {
 			leap = -1;
 			time_state = TIME_OOP;
-			printk(KERN_NOTICE
-				"Clock: inserting leap second 23:59:60 UTC\n");
+			pr_notice("Clock: inserting leap second 23:59:60 UTC\n");
 		}
 		break;
 	case TIME_DEL:
@@ -440,8 +439,7 @@ int second_overflow(time64_t secs)
 			leap = 1;
 			ntp_next_leap_sec = TIME64_MAX;
 			time_state = TIME_WAIT;
-			printk(KERN_NOTICE
-				"Clock: deleting leap second 23:59:59 UTC\n");
+			pr_notice("Clock: deleting leap second 23:59:59 UTC\n");
 		}
 		break;
 	case TIME_OOP:
@@ -834,10 +832,8 @@ int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 			txc->tai--;
 			txc->time.tv_sec++;
 		}
-		if ((time_state == TIME_OOP) &&
-					(ts->tv_sec == ntp_next_leap_sec)) {
+		if ((time_state == TIME_OOP) &&	(ts->tv_sec == ntp_next_leap_sec))
 			result = TIME_WAIT;
-		}
 	}
 
 	return result;
@@ -944,9 +940,8 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		time_status |= STA_PPSERROR;
 		pps_errcnt++;
 		pps_dec_freq_interval();
-		printk_deferred(KERN_ERR
-			"hardpps: PPSERROR: interval too long - %lld s\n",
-			freq_norm.sec);
+		printk_deferred(KERN_ERR "hardpps: PPSERROR: interval too long - %lld s\n",
+				freq_norm.sec);
 		return 0;
 	}
 
@@ -960,8 +955,7 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	delta = shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
 	pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSWANDER: change=%ld\n", delta);
+		printk_deferred(KERN_WARNING "hardpps: PPSWANDER: change=%ld\n", delta);
 		time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
@@ -977,13 +971,11 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	delta_mod = delta;
 	if (delta_mod < 0)
 		delta_mod = -delta_mod;
-	pps_stabil += (div_s64(((s64)delta_mod) <<
-				(NTP_SCALE_SHIFT - SHIFT_USEC),
-				NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
+	pps_stabil += (div_s64(((s64)delta_mod) << (NTP_SCALE_SHIFT - SHIFT_USEC),
+			       NSEC_PER_USEC) - pps_stabil) >> PPS_INTMIN;
 
 	/* If enabled, the system clock frequency is updated */
-	if ((time_status & STA_PPSFREQ) != 0 &&
-	    (time_status & STA_FREQHOLD) == 0) {
+	if ((time_status & STA_PPSFREQ) && !(time_status & STA_FREQHOLD)) {
 		time_freq = pps_freq;
 		ntp_update_frequency();
 	}
@@ -1007,15 +999,13 @@ static void hardpps_update_phase(long error)
 	 * the time offset is updated.
 	 */
 	if (jitter > (pps_jitter << PPS_POPCORN)) {
-		printk_deferred(KERN_WARNING
-				"hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
+		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
 				jitter, (pps_jitter << PPS_POPCORN));
 		time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (time_status & STA_PPSTIME) {
 		/* Correct the time using the phase offset */
-		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT,
-				NTP_INTERVAL_FREQ);
+		time_offset = div_s64(((s64)correction) << NTP_SCALE_SHIFT, NTP_INTERVAL_FREQ);
 		/* Cancel running adjtime() */
 		time_adjust = 0;
 	}
@@ -1064,9 +1054,8 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 	 * Check that the signal is in the range
 	 * [1s - MAXFREQ us, 1s + MAXFREQ us], otherwise reject it
 	 */
-	if ((freq_norm.sec == 0) ||
-			(freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
-			(freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
+	if ((freq_norm.sec == 0) || (freq_norm.nsec > MAXFREQ * freq_norm.sec) ||
+	    (freq_norm.nsec < -MAXFREQ * freq_norm.sec)) {
 		time_status |= STA_PPSJITTER;
 		/* Restart the frequency calibration interval */
 		pps_fbase = *raw_ts;

-- 
2.39.2


