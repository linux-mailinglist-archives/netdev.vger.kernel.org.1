Return-Path: <netdev+bounces-127373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E4975384
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D6CB2267D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9E1A4F2F;
	Wed, 11 Sep 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pQARM0HI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BLacdNDC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAE41A2C21;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060686; cv=none; b=SnSH2J8bidBVJGBkJ/vx8OgM0O+ACIE2ckH5Nrw9pZ2DU3FqT5HynRnlXmiq3KNhe6zE+t4NtTBW+yEMih3+uHfrgzKOyEJqGLA1a/eL82i9QVMcIE6qbZnWybXNRAHWMhSQ7Ge7LSCVWR3l49rSR6moLR1nDkoxQG3ECIZRoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060686; c=relaxed/simple;
	bh=Gc9aUrMgiGw/PU4IgdgohutjQq8cr8HMfVVNTNoSqso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRWJ74xzYlAzFdP8u8gTNqawjmgt92yzz1xwfHw/qlDZq1LB1b0OWWZRtFugtdi4oG2evmYK9rcZ7f5N6SRRcMFob57om5QVLmYErQe23SamDEnF5Cjiof6CLG4YxgTefZY3sokQ917roxDXRay3vstChBrEJ1IHs7Ywm+Z1fJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pQARM0HI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BLacdNDC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcIY7gmIL3iEzEpBJg1/mDIpAsK46bssX6oGGBFRDUs=;
	b=pQARM0HIOtkDgmsJgLPAz+u1vCuFLZ5kkbdZeXDTJqu9njbKOFEBPfzzUybgYtjw5ly8Yn
	IHx7i4/sw9a1t1SkFgbhLu7FRurHiHZ4CBHe+EwfZEs/hL9k5RteLRlVypmnnWyfPkdByD
	v7BUQP0utGdMCzQuTXPoN/up7iOnTY2CQbGMim3V/KRTAxnUx2qoPDU7hAnTNA6y7twBXu
	EAxzFycin5k1PAiKjF6Tm+dacygzEi6eQSdb46k4hUyJ2ixgn0Z+LImGGZtI/wEzCjTITq
	MtLaVlwEmkKwPFX18+ZcaJEtx+hs3EB5bHOEbF9V1sWqW315CQgxPf/OOdKr+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcIY7gmIL3iEzEpBJg1/mDIpAsK46bssX6oGGBFRDUs=;
	b=BLacdNDCGa6o2bxxq7cOI9qRLM3cgqtb9iPtofx7Xse5SL6q5ldjj1QKSXSJMxdCSofDxz
	arHymV5G319x1iCA==
Date: Wed, 11 Sep 2024 15:17:51 +0200
Subject: [PATCH 15/21] ntp: Move pps_valid into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-15-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 33d52b9dbff6..35cca57e017e 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -40,6 +40,8 @@
  * @ntp_tick_adj:	Constant boot-param configurable NTP tick adjustment (upscaled)
  * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
+ * @pps_valid:		PPS signal watchdog counter
+ *
  * Protected by the timekeeping locks.
  */
 struct ntp_data {
@@ -57,6 +59,9 @@ struct ntp_data {
 	long			time_adjust;
 	s64			ntp_tick_adj;
 	time64_t		ntp_next_leap_sec;
+#ifdef CONFIG_NTP_PPS
+	int			pps_valid;
+#endif
 };
 
 static struct ntp_data tk_ntp_data = {
@@ -91,7 +96,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static int pps_valid;		/* signal watchdog counter */
 static long pps_tf[3];		/* phase median filter */
 static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
@@ -147,9 +151,9 @@ static inline void pps_clear(void)
  */
 static inline void pps_dec_valid(struct ntp_data *ntpdata)
 {
-	if (pps_valid > 0)
-		pps_valid--;
-	else {
+	if (ntpdata->pps_valid > 0) {
+		ntpdata->pps_valid--;
+	} else {
 		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
 					  STA_PPSWANDER | STA_PPSERROR);
 		pps_clear();
@@ -1024,7 +1028,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 
 	/* indicate signal presence */
 	ntpdata->time_status |= STA_PPSSIGNAL;
-	pps_valid = PPS_VALID;
+	ntpdata->pps_valid = PPS_VALID;
 
 	/*
 	 * When called for the first time, just start the frequency

-- 
2.39.2


