Return-Path: <netdev+bounces-190201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFE3AB5850
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42454C07E8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54F2C1799;
	Tue, 13 May 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="axBWjT/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajPnB9Hv"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FE72C10BE;
	Tue, 13 May 2025 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149209; cv=none; b=ZH6T6jwXleptFZcypgcN3xzI00xQSQbKEePTDiOSY14lJ12Xf2n3YprSRvuKatDVrmxS8sojbpEo3Il57kuu0Ubwqr/BK5vecbJzdvN8v0P29qjxHCzveirJJshr/FQdIj4kaJ+81Y89sMjVFbdhMzZOgTI+ILQmU3CkXMWrtxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149209; c=relaxed/simple;
	bh=5lElRvz1sQzjfrIw2oIEVw2arW/2AmLQNPA1DgZzvlA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QMw9b/Y3vU/3HOYoYbjFqpLZBMDNrQcmuUltPFMlTwva7vpS1zUMzU0lRKwbPda4zLWyzqy/Q8SasCutqAFdLNBs88bd03BLm2VhNKenVA+gaud1bCR5uuCmhMmBMnsWJ1r13UHMqePYgwCqB0Jnv8P/r1Z4j1iFL6h9zx5wH9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=axBWjT/n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajPnB9Hv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145137.681496427@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aWJhQt8zoJ/Z+lvXczMnNhXrfMyJvGibEQIfA9TRM7E=;
	b=axBWjT/n2v0gCIJ9KZQFiZTE9Ixnw0xx0+6wTyBPseD5m10h+Gk95dB8ZbCfM1jA78WJcH
	yZxTLHef2WcgcdiNrJNjfvOtfSN8Bokn8oM5yWFYu/JTOSu1afDoS5rWjq8JDyov9Es916
	dbiDwSkqF74rFlRhWOa7HO2JTwFcFAW8i8PTzhC/uZ0ByFBbfAC+xzeBnUcEvHNX7llsrt
	Vv4a/MWhfZ8FIwUl1WU5yIYoaTYPYQVXkPynsJtvc4zQQQbbazgs0j0o2jnF7lWKz9Lh1n
	0s8JRhmwPXKw8VI2MAbHrnxMNVxYw40p1vh1wIaos5V0hN/8wR4BNKv/Jhbjdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aWJhQt8zoJ/Z+lvXczMnNhXrfMyJvGibEQIfA9TRM7E=;
	b=ajPnB9Hv2Qefn4FAQ+nniQHfyFKGjRwBqHa2YZZfmv8DyUloidbmr2G60uI/ogjRuEph9C
	dEG443pObGL4uyDA==
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
Subject: [patch 17/26] timekeeping: Provide time getters for PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:26 +0200 (CEST)

Provide interfaces similar to the ktime_get*() family which provide access
to the independent PTP clocks.

These interfaces have a boolean return value, which indicates whether the
accessed clock is valid or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeping.h |   17 ++++++++++++
 kernel/time/timekeeping.c   |   62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
---
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -60,6 +60,17 @@ extern time64_t __ktime_get_real_seconds
 extern time64_t ktime_get_real_seconds(void);
 
 /*
+ * PTP clock interfaces
+ */
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+extern bool ktime_get_ptp(clockid_t id, ktime_t *kt);
+extern bool ktime_get_ptp_ts64(clockid_t id, struct timespec64 *kt);
+#else
+static inline bool ktime_get_ptp(clockid_t id, ktime_t *kt) { return false; }
+static inline bool ktime_get_ptp_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+#endif
+
+/*
  * ktime_t based interfaces
  */
 
@@ -263,6 +274,12 @@ extern bool timekeeping_rtc_skipresume(v
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * PTP clocks
+ */
+bool ktime_get_ptp(clockid_t ptp_clock_id, ktime_t *ts);
+bool ktime_get_ptp_ts64(clockid_t ptp_clock_id, struct timespec64 *ts);
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2661,6 +2661,23 @@ EXPORT_SYMBOL(hardpps);
 /* Bitmap for the activated PTP timekeepers */
 static unsigned long ptp_timekeepers;
 
+static inline bool ptp_valid_clockid(clockid_t id)
+{
+	return id >= CLOCK_PTP && id <= CLOCK_PTP_LAST;
+}
+
+static inline unsigned int clockid_to_tkid(unsigned int id)
+{
+	return TIMEKEEPER_PTP + id - CLOCK_PTP;
+}
+
+static inline struct tk_data *ptp_get_tk_data(clockid_t id)
+{
+	if (!ptp_valid_clockid(id))
+		return NULL;
+	return &timekeeper_data[clockid_to_tkid(id)];
+}
+
 /* Invoked from timekeeping after a clocksource change */
 static void tk_ptp_update_clocksource(void)
 {
@@ -2681,6 +2698,51 @@ static void tk_ptp_update_clocksource(vo
 	}
 }
 
+/**
+ * ktime_get_ptp - Get TAI time for a PTP clock
+ * @id:	ID of the clock to read (CLOCK_PTP...)
+ * @kt:	Pointer to ktime_t to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_ptp(clockid_t id, ktime_t *kt)
+{
+	struct tk_data *tkd = ptp_get_tk_data(id);
+	struct timekeeper *tk;
+	unsigned int seq;
+	ktime_t base;
+	u64 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	if (!tkd)
+		return false;
+
+	tk = &tkd->timekeeper;
+	do {
+		seq = read_seqcount_begin(&tkd->seq);
+		if (!tk->clock_valid)
+			return false;
+
+		base = ktime_add(tk->tkr_mono.base, tk->offs_ptp);
+		nsecs = timekeeping_get_ns(&tk->tkr_mono);
+	} while (read_seqcount_retry(&tkd->seq, seq));
+
+	*kt = ktime_add_ns(base, nsecs);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_ptp);
+
+bool ktime_get_ptp_ts64(clockid_t id, struct timespec64 *ts)
+{
+	ktime_t now;
+
+	if (!ktime_get_ptp(id, &now))
+		return false;
+	*ts = ktime_to_timespec64(now);
+	return true;
+}
+
 static __init void tk_ptp_setup(void)
 {
 	for (int i = TIMEKEEPER_PTP; i <= TIMEKEEPER_PTP_LAST; i++)


