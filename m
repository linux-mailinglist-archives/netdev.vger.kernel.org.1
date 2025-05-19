Return-Path: <netdev+bounces-191412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED0BABB752
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9476A3BA344
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B026C389;
	Mon, 19 May 2025 08:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KexKH+k5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxtwz27F"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D5726B0A7;
	Mon, 19 May 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643604; cv=none; b=VRpbg7DdIVe2XcngczrnGwwh2rfssnKniwqnwSV6TvjO2H0GhSCVCicNZLgbuugh1eAzn0RqzCGxJaI3nPAHJF8uMt/fNHw+Kzbu/4ZZvh2rhBQd2pxyiYcudeClPafLMFknTMk/DVVkaBV73RXXqdApo5d+JaGwN5zh3VtxTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643604; c=relaxed/simple;
	bh=oAwwXd29RmLztsc7SAntcL4APp16zBohgk7uM9zwQWA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RskvYAQxIVaOVWEsDMng5yKAXEEZrLiBLw6xNknu/9tx61mrqiCIEHzS7hnpnI/Qrxi3TMGyEI5w19gv5nqWaxYF6OqFqznXse0qhmrO5UXnboJqViMG45UwqKSmyYOHRExS3kQSP8H/DMFKO6KWA9kcG6NPeqAyW2MzIsAmlxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KexKH+k5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxtwz27F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083025.969000914@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fuJ7o+F9Ll8i3WU2Ep3XtBcWSbqbcijosAFfflFA/wk=;
	b=KexKH+k56yF/n2IUNWbzusciqEdMhv2G0ZAuklgI7H8NtmSj0qFc1ELpkUaTBvLorbUhhh
	OyeQHfJQ6xW5z99KtdKeAI3Cln18zhO9tDv/+pRYcxcc3KDJDVVosjZNwCMX1K7hq4pzhb
	hLkg+yQtm/3Rwh6BGS2+AtYhEz7eGIlRT+PM2TK7S7GphgYfc9CnW2sAwNvp/yN/ytfuxf
	GJ+olk2G+iyXekAPVe0ghxx6EQATliRB/NcvsxQ0DPGTSdNYRHXLoJMmS7hwFJwZZf8vLA
	Jkm/Z9CIGLMwamPDsJxX9vLGV7zi30VytCxNwUzPhYKLLrinEsFfKm53Zk8fRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fuJ7o+F9Ll8i3WU2Ep3XtBcWSbqbcijosAFfflFA/wk=;
	b=wxtwz27FUXF9wkNYkA5oJMBrrDLQ+yN2BDkW5oBRhE63vRPNaA0fCdfFy7crLkPpZTvpdM
	dGhRFZfbu4cXLkBg==
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
Subject: [patch V2 06/26] ntp: Add support for auxiliary timekeepers
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:21 +0200 (CEST)

If auxiliary clocks are enabled, provide an array of NTP data so that the
auxiliary timekeepers can be steered independently of the core timekeeper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/ntp.c |   41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)
---
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/rtc.h>
 #include <linux/audit.h>
+#include <linux/timekeeper_internal.h>
 
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -86,14 +87,16 @@ struct ntp_data {
 #endif
 };
 
-static struct ntp_data tk_ntp_data = {
-	.tick_usec		= USER_TICK_USEC,
-	.time_state		= TIME_OK,
-	.time_status		= STA_UNSYNC,
-	.time_constant		= 2,
-	.time_maxerror		= NTP_PHASE_LIMIT,
-	.time_esterror		= NTP_PHASE_LIMIT,
-	.ntp_next_leap_sec	= TIME64_MAX,
+static struct ntp_data tk_ntp_data[TIMEKEEPERS_MAX] = {
+	[ 0 ... TIMEKEEPERS_MAX - 1 ] = {
+		.tick_usec		= USER_TICK_USEC,
+		.time_state		= TIME_OK,
+		.time_status		= STA_UNSYNC,
+		.time_constant		= 2,
+		.time_maxerror		= NTP_PHASE_LIMIT,
+		.time_esterror		= NTP_PHASE_LIMIT,
+		.ntp_next_leap_sec	= TIME64_MAX,
+	},
 };
 
 #define SECS_PER_DAY		86400
@@ -351,13 +354,13 @@ static void __ntp_clear(struct ntp_data
  */
 void ntp_clear(void)
 {
-	__ntp_clear(&tk_ntp_data);
+	__ntp_clear(&tk_ntp_data[TIMEKEEPER_CORE]);
 }
 
 
 u64 ntp_tick_length(void)
 {
-	return tk_ntp_data.tick_length;
+	return tk_ntp_data[TIMEKEEPER_CORE].tick_length;
 }
 
 /**
@@ -368,7 +371,7 @@ u64 ntp_tick_length(void)
  */
 ktime_t ntp_get_next_leap(void)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	ktime_t ret;
 
 	if ((ntpdata->time_state == TIME_INS) && (ntpdata->time_status & STA_INS))
@@ -389,7 +392,7 @@ ktime_t ntp_get_next_leap(void)
  */
 int second_overflow(time64_t secs)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	s64 delta;
 	int leap = 0;
 	s32 rem;
@@ -605,7 +608,7 @@ static inline int update_rtc(struct time
  */
 static inline bool ntp_synced(void)
 {
-	return !(tk_ntp_data.time_status & STA_UNSYNC);
+	return !(tk_ntp_data[TIMEKEEPER_CORE].time_status & STA_UNSYNC);
 }
 
 /*
@@ -762,7 +765,7 @@ static inline void process_adjtimex_mode
 int __do_adjtimex(struct __kernel_timex *txc, const struct timespec64 *ts,
 		  s32 *time_tai, struct audit_ntp_data *ad)
 {
-	struct ntp_data *ntpdata = &tk_ntp_data;
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	int result;
 
 	if (txc->modes & ADJ_ADJTIME) {
@@ -1031,8 +1034,8 @@ static void hardpps_update_phase(struct
  */
 void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
+	struct ntp_data *ntpdata = &tk_ntp_data[TIMEKEEPER_CORE];
 	struct pps_normtime pts_norm, freq_norm;
-	struct ntp_data *ntpdata = &tk_ntp_data;
 
 	pts_norm = pps_normalize_ts(*phase_ts);
 
@@ -1083,18 +1086,18 @@ void __hardpps(const struct timespec64 *
 
 static int __init ntp_tick_adj_setup(char *str)
 {
-	int rc = kstrtos64(str, 0, &tk_ntp_data.ntp_tick_adj);
+	int rc = kstrtos64(str, 0, &tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj);
 	if (rc)
 		return rc;
 
-	tk_ntp_data.ntp_tick_adj <<= NTP_SCALE_SHIFT;
+	tk_ntp_data[TIMEKEEPER_CORE].ntp_tick_adj <<= NTP_SCALE_SHIFT;
 	return 1;
 }
-
 __setup("ntp_tick_adj=", ntp_tick_adj_setup);
 
 void __init ntp_init(void)
 {
-	ntp_clear();
+	for (int id = 0; id < TIMEKEEPERS_MAX; id++)
+		__ntp_clear(tk_ntp_data + id);
 	ntp_init_cmos_sync();
 }


