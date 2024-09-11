Return-Path: <netdev+bounces-127364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2233975373
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517B7288E07
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE71A0732;
	Wed, 11 Sep 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCmXi7J5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MElUGtg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208F19E987;
	Wed, 11 Sep 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060683; cv=none; b=QHq0m2FdhCDAIrbWeibDm5Cb0MJ7WDTgbeSxVYjHe9nsxhWfJXCEwkJEBzkip4DKc/5/hVbTS87cPrQ9qZcOVvVdjw7OvJJLUZbOn8U+FlZs9LzzYGGqWrBCOxWhzmp79jl08OikjtmHmN6dSsI92C5gfQfwR36pwq4dUFPeW0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060683; c=relaxed/simple;
	bh=mCkP05nPR2dyDok4kENhzn3NK6WJPqM9b98DanQBSbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rC1ZzRdXXPpC2hrwVXSm4zkRpPBGS+sI6vBeMNdneE1rB0ABiNKyXej1w2tA9nFLO08fOqP6PEozhuoAGs+FawkXbf3olHr1MItSyG0uPM6r7EZQVncS6L+fnFdWRG4oS2Cg6zThW01getuzsRXyH1sMy6X8ECt2sSwfDxCFaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCmXi7J5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MElUGtg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXNbwrHSXrnt15cm/AG2lq5xxPwSA6Sw6Z+iK16YEl4=;
	b=bCmXi7J5XCTZybj6XotgijL59RRzQElfNnzlBGwypOlxhKBSMZyExG73PVhky0qVx2Bv2v
	rNRwaKYlm7cnPSo8ut/fSa7b4aezJ+7gkuklhqjmW68/oEyu7jomW5+jbdLFRkZAOr8VAQ
	KQKjHAW9T6CIOEZH6hubHU06pCL5np3AAbv9/h1Lc+Ns/VgdKrZqtHDU+Qpxykim4KRuRB
	Q/28IqoCKTF6jOchJcPFEbGWl5j+EtNAKBWKtbS2XKEofQG2ze46FxK6wIkx+hJDkJQMd5
	Odpgvd86nkq2mKeWLOsXbjDRceiSsCAqWfJV4YaLcIvjULKsN+p5VB2M0u58cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FXNbwrHSXrnt15cm/AG2lq5xxPwSA6Sw6Z+iK16YEl4=;
	b=6MElUGtgL40/wWZRCCuL+LvhI12CBqe3qcpsRdFuNLZULjlqC21ws+/1dDp8JcXLB6PJx6
	z49rOkUyxmHxssDQ==
Date: Wed, 11 Sep 2024 15:17:44 +0200
Subject: [PATCH 08/21] ntp: Move tick_length* into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-8-2d52f4e13476@linutronix.de>
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

Continue the conversion from static variables to struct based data.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/ntp.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 0222f8e46081..6c5f684328c8 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -25,20 +25,21 @@
 /**
  * struct ntp_data - Structure holding all NTP related state
  * @tick_usec:		USER_HZ period in microseconds
+ * @tick_length:	Adjusted tick length
+ * @tick_length_base:	Base value for @tick_length
  *
  * Protected by the timekeeping locks.
  */
 struct ntp_data {
 	unsigned long		tick_usec;
+	u64			tick_length;
+	u64			tick_length_base;
 };
 
 static struct ntp_data tk_ntp_data = {
 	.tick_usec		= USER_TICK_USEC,
 };
 
-static u64			tick_length;
-static u64			tick_length_base;
-
 #define SECS_PER_DAY		86400
 #define MAX_TICKADJ		500LL		/* usecs */
 #define MAX_TICKADJ_SCALED \
@@ -263,8 +264,8 @@ static void ntp_update_frequency(struct ntp_data *ntpdata)
 	 * Don't wait for the next second_overflow, apply the change to the
 	 * tick length immediately:
 	 */
-	tick_length		+= new_base - tick_length_base;
-	tick_length_base	 = new_base;
+	ntpdata->tick_length		+= new_base - ntpdata->tick_length_base;
+	ntpdata->tick_length_base	 = new_base;
 }
 
 static inline s64 ntp_update_offset_fll(s64 offset64, long secs)
@@ -341,8 +342,8 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 
 	ntp_update_frequency(ntpdata);
 
-	tick_length	= tick_length_base;
-	time_offset	= 0;
+	ntpdata->tick_length	= ntpdata->tick_length_base;
+	time_offset		= 0;
 
 	ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
@@ -360,7 +361,7 @@ void ntp_clear(void)
 
 u64 ntp_tick_length(void)
 {
-	return tick_length;
+	return tk_ntp_data.tick_length;
 }
 
 /**
@@ -391,6 +392,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data;
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -451,11 +453,11 @@ int second_overflow(time64_t secs)
 	}
 
 	/* Compute the phase adjustment for the next second */
-	tick_length	 = tick_length_base;
+	ntpdata->tick_length	 = ntpdata->tick_length_base;
 
-	delta		 = ntp_offset_chunk(time_offset);
-	time_offset	-= delta;
-	tick_length	+= delta;
+	delta			 = ntp_offset_chunk(time_offset);
+	time_offset		-= delta;
+	ntpdata->tick_length	+= delta;
 
 	/* Check PPS signal */
 	pps_dec_valid();
@@ -465,18 +467,18 @@ int second_overflow(time64_t secs)
 
 	if (time_adjust > MAX_TICKADJ) {
 		time_adjust -= MAX_TICKADJ;
-		tick_length += MAX_TICKADJ_SCALED;
+		ntpdata->tick_length += MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
 	if (time_adjust < -MAX_TICKADJ) {
 		time_adjust += MAX_TICKADJ;
-		tick_length -= MAX_TICKADJ_SCALED;
+		ntpdata->tick_length -= MAX_TICKADJ_SCALED;
 		goto out;
 	}
 
-	tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
-							 << NTP_SCALE_SHIFT;
+	ntpdata->tick_length += (s64)(time_adjust * NSEC_PER_USEC / NTP_INTERVAL_FREQ)
+				<< NTP_SCALE_SHIFT;
 	time_adjust = 0;
 
 out:

-- 
2.39.2


