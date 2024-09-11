Return-Path: <netdev+bounces-127375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B957975386
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700671C220D1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568251A76CE;
	Wed, 11 Sep 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tGcsSz0/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H/ALmm0o"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE3C1A2C22;
	Wed, 11 Sep 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060687; cv=none; b=QwdBbSk2yYp6GZaiXb6miQOkQaqc1rGdfvt/H/PzASb3vO82oveeYz2st9hCD8DRjxJMedJT/z9z9oOylvbO9wnEi9jZx6MvKfdsGu8EjKOGknkcqiGZZ+VOwf8rpnUSwgBP9TbKwntCytNyKOGDLCFPg5GQWgGn0nIE0HnHjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060687; c=relaxed/simple;
	bh=C8saRYIZL/cdOQgteWmZjtYfUl7VFXa2cWqwRJ2E79c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLmiFqJMJ4skUKNC5RNg5KcKqiMNTBEu4Epv9VUdpuv6Ns5UE7dw4v6B+UJMtvWfw16QxjMSRwA3Rkd9iVENzyIlZo88IS1KL6vRasLFLitsH8aje+OYYV0btcU8dsWiwBAWo98EqvQxtAz29xkFegqB4e1iB2YLEMZPPtvBmrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tGcsSz0/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H/ALmm0o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/ZdMb3Rii3xovOcXYYtYucy702sAeLJbbsZ53Bdr6I=;
	b=tGcsSz0/jIuXLiwQCt4a9vt4xDdZ60icLjW4hkfglM2hb+0dCyrbfyX1LET7G9qbj6DN9v
	lRyRlGnimD9qxR+m2GhLziE5XJR3wsM52A0iZuWoxBS+1YBRIvOT55SFOznQmE5UzYW/67
	QzmSBuQNMRacmOwddGg0v4BPuyIxp2u0ZlFSS8cib1Nyb8JDCvhUg3+tan1MN9Xe3kfrYl
	KmLvavgE6krfye9meZuHZ70MG9r6e8B/p8VmGr05VWiz2IC/2Z2oKhr/8N3LnQEMeTYLTh
	mCBzKoHLwgJEAIz4waoIcsch2NUju8ioFVBaqWmQCKNDP+tDW/gW6ZODT6gWmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726060678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/ZdMb3Rii3xovOcXYYtYucy702sAeLJbbsZ53Bdr6I=;
	b=H/ALmm0onkwNYxRZLrxkvKg74RRiB4gYtsj1cTxppCoYjz7gl9gIscaNrZSZHvqf+P5Fie
	6uYaDh0QZyZr+XCQ==
Date: Wed, 11 Sep 2024 15:17:52 +0200
Subject: [PATCH 16/21] ntp: Move pps_ft into ntp_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-16-2d52f4e13476@linutronix.de>
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
 kernel/time/ntp.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 35cca57e017e..22fece642c61 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -41,6 +41,7 @@
  * @ntp_next_leap_sec:	Second value of the next pending leapsecond, or TIME64_MAX if no leap
  *
  * @pps_valid:		PPS signal watchdog counter
+ * @pps_tf:		PPS phase median filter
  *
  * Protected by the timekeeping locks.
  */
@@ -61,6 +62,7 @@ struct ntp_data {
 	time64_t		ntp_next_leap_sec;
 #ifdef CONFIG_NTP_PPS
 	int			pps_valid;
+	long			pps_tf[3];
 #endif
 };
 
@@ -96,7 +98,6 @@ static struct ntp_data tk_ntp_data = {
 				   intervals to decrease it */
 #define PPS_MAXWANDER	100000	/* max PPS freq wander (ns/s) */
 
-static long pps_tf[3];		/* phase median filter */
 static long pps_jitter;		/* current jitter (ns) */
 static struct timespec64 pps_fbase; /* beginning of the last freq interval */
 static int pps_shift;		/* current interval duration (s) (shift) */
@@ -134,13 +135,14 @@ static inline void pps_reset_freq_interval(void)
 
 /**
  * pps_clear - Clears the PPS state variables
+ * @ntpdata:	Pointer to ntp data
  */
-static inline void pps_clear(void)
+static inline void pps_clear(struct ntp_data *ntpdata)
 {
 	pps_reset_freq_interval();
-	pps_tf[0] = 0;
-	pps_tf[1] = 0;
-	pps_tf[2] = 0;
+	ntpdata->pps_tf[0] = 0;
+	ntpdata->pps_tf[1] = 0;
+	ntpdata->pps_tf[2] = 0;
 	pps_fbase.tv_sec = pps_fbase.tv_nsec = 0;
 	pps_freq = 0;
 }
@@ -156,7 +158,7 @@ static inline void pps_dec_valid(struct ntp_data *ntpdata)
 	} else {
 		ntpdata->time_status &= ~(STA_PPSSIGNAL | STA_PPSJITTER |
 					  STA_PPSWANDER | STA_PPSERROR);
-		pps_clear();
+		pps_clear(ntpdata);
 	}
 }
 
@@ -211,7 +213,7 @@ static inline s64 ntp_offset_chunk(struct ntp_data *ntpdata, s64 offset)
 }
 
 static inline void pps_reset_freq_interval(void) {}
-static inline void pps_clear(void) {}
+static inline void pps_clear(struct ntp_data *ntpdata) {}
 static inline void pps_dec_valid(struct ntp_data *ntpdata) {}
 static inline void pps_set_freq(s64 freq) {}
 
@@ -337,7 +339,7 @@ static void __ntp_clear(struct ntp_data *ntpdata)
 
 	ntpdata->ntp_next_leap_sec = TIME64_MAX;
 	/* Clear PPS state variables */
-	pps_clear();
+	pps_clear(ntpdata);
 }
 
 /**
@@ -862,22 +864,22 @@ static inline struct pps_normtime pps_normalize_ts(struct timespec64 ts)
 }
 
 /* Get current phase correction and jitter */
-static inline long pps_phase_filter_get(long *jitter)
+static inline long pps_phase_filter_get(struct ntp_data *ntpdata, long *jitter)
 {
-	*jitter = pps_tf[0] - pps_tf[1];
+	*jitter = ntpdata->pps_tf[0] - ntpdata->pps_tf[1];
 	if (*jitter < 0)
 		*jitter = -*jitter;
 
 	/* TODO: test various filters */
-	return pps_tf[0];
+	return ntpdata->pps_tf[0];
 }
 
 /* Add the sample to the phase filter */
-static inline void pps_phase_filter_add(long err)
+static inline void pps_phase_filter_add(struct ntp_data *ntpdata, long err)
 {
-	pps_tf[2] = pps_tf[1];
-	pps_tf[1] = pps_tf[0];
-	pps_tf[0] = err;
+	ntpdata->pps_tf[2] = ntpdata->pps_tf[1];
+	ntpdata->pps_tf[1] = ntpdata->pps_tf[0];
+	ntpdata->pps_tf[0] = err;
 }
 
 /*
@@ -980,8 +982,8 @@ static void hardpps_update_phase(struct ntp_data *ntpdata, long error)
 	long jitter;
 
 	/* Add the sample to the median filter */
-	pps_phase_filter_add(correction);
-	correction = pps_phase_filter_get(&jitter);
+	pps_phase_filter_add(ntpdata, correction);
+	correction = pps_phase_filter_get(ntpdata, &jitter);
 
 	/*
 	 * Nominal jitter is due to PPS signal noise. If it exceeds the

-- 
2.39.2


