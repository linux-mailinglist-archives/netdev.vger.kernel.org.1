Return-Path: <netdev+bounces-127376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0F975387
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E56284D34
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8284D1A7AF9;
	Wed, 11 Sep 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvtg4F0i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxpmAFUn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430671A3046;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060687; cv=none; b=VE7BeZM6jUgnWW+sDz4pcWPlNhsyYexBZTIwhqAFjG+rDAS2JuVqRq2Cf98zvJi/7KvJ9aWKpaRqH1pQDUZ4SqEt5W/9GMcnJ2R76xeZ0tKHOrXX2Yvs2shVsy29kwypvHE15s2HJKoX9CNSvmjpOGjxfUkGJmXmhfCONJvAMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060687; c=relaxed/simple;
	bh=0wr+8h/5XCURJQUuDf8LL1W0iId7el4UT8pZeG/QkQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLv+Z+vaY5rbYE7eLjauEQhZ85GGXAUiElKgR4SlQcgq8xfDO48OGZo5o1M/VK43ZF9129NGvStM27yNPLyYA7reh7kWzEWmTZJLP2/qYXMkGe3F4Hx1FYJ56/82lnVHhAL2sOPO8nuOy+V9VcgckvHsOnz7SCwcow0oGDVCvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvtg4F0i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxpmAFUn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJuu8I0S4GSTOuMTha6kS7r2SciKCa+eSe56eLnPxgA=;
	b=yvtg4F0irMVprRIgYq11XoRbwVzDPj0dQL02z1jriknAHWMj5CpR0Q9HIHDcuIPrUBPl7B
	5wBRhS0WYQgO7XHNvb38W9JYP0X+zXAcSeJfKappRncE+4ksxvtELgqwVSjk6DMlxMoNM3
	mk1OUDGXbi09JV4qoihGu9Awz5tg3Agh5M9ZuqFpGsGdKvyH5sSu5GK9J7TOLL1TxgQT7m
	HR0G28gLVaaeiTN24QI6zRWyJ1uvA8zn639IJVoQ347o+dK/GQ5CJEWFp7jcx19q88JTm5
	xK9nuVHxKezgEzDDMtV2a4/B2KrlFtZDRPJ03H1yGpF88BBJTdWfOHEHhyrdqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJuu8I0S4GSTOuMTha6kS7r2SciKCa+eSe56eLnPxgA=;
	b=CxpmAFUnwWgkseGPkWHhKXhSbfcVDMGHvKDQOY+JDslpLGUAXfsWOps0v5FTwtGt3zTzuy
	N1nEkEB9g37WgzAg==
Date: Wed, 11 Sep 2024 15:17:53 +0200
Subject: [PATCH 17/21] ntp: Move pps_jitter into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-17-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 22fece642c61..dc1e1d5dbd9c 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -42,6 +42,7 @@
  *
  * @pps_valid:		PPS signal watchdog counter
  * @pps_tf:		PPS phase median filter
+ * @pps_jitter:		PPS current jitter in nanoseconds
  *
  * Protected by the timekeeping locks.
  */
@@ -63,6 +64,7 @@ struct ntp_data {
 #ifdef CONFIG_NTP_PPS
 	int			pps_valid;
 	long			pps_tf[3];
+	long			pps_jitter;
 #endif
 };
 
@@ -98,7 +100,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
 static int pps_intcnt;		/* interval counter */
@@ -194,9 +195,9 @@ static inline void pps_fill_timex(struct ntp_data *ntpdata, struct __kernel_time
 {
 	txc->ppsfreq	   = shift_right((pps_freq >> PPM_SCALE_INV_SHIFT) *
 					 PPM_SCALE_INV, NTP_SCALE_SHIFT);
-	txc->jitter	   = pps_jitter;
+	txc->jitter	   = ntpdata->pps_jitter;
 	if (!(ntpdata->time_status & STA_NANO))
-		txc->jitter = pps_jitter / NSEC_PER_USEC;
+		txc->jitter = ntpdata->pps_jitter / NSEC_PER_USEC;
 	txc->shift	   = pps_shift;
 	txc->stabil	   = pps_stabil;
 	txc->jitcnt	   = pps_jitcnt;
@@ -990,9 +991,9 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 	 * threshold, the sample is discarded; otherwise, if so enabled,
 	 * the time offset is updated.
 	 */
-	if (jitter > (pps_jitter << PPS_POPCORN)) {
+	if (jitter > (ntpdata->pps_jitter << PPS_POPCORN)) {
 		printk_deferred(KERN_WARNING "hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
-				jitter, (pps_jitter << PPS_POPCORN));
+				jitter, (ntpdata->pps_jitter << PPS_POPCORN));
 		ntpdata->time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (ntpdata->time_status & STA_PPSTIME) {
@@ -1003,7 +1004,7 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 		ntpdata->time_adjust = 0;
 	}
 	/* Update jitter */
-	pps_jitter += (jitter - pps_jitter) >> PPS_INTMIN;
+	ntpdata->pps_jitter += (jitter - ntpdata->pps_jitter) >> PPS_INTMIN;
 }
 
 /*

-- 
2.39.2


