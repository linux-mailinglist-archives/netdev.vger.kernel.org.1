Return-Path: <netdev+bounces-201295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62DAE8CA6
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631913AB2C3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA22DAFC9;
	Wed, 25 Jun 2025 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xi6jQYE/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6qeYh+G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D42D8DBD;
	Wed, 25 Jun 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876715; cv=none; b=aNBmSECL5NBMPlvZl94fjTgjmAEJOP/AtGrmmUEinGKOV3VbwftkdkwKbiHEw2QQEkqMjT9dl5ikhjgQLJi27H5ByxKOi2aj2fdMrKj7a4ID/YcxILO+E56VYxykUK/QR+AlhD0ggeEC05E0o4yVOeZ63tpaw/G/MiNpW3WpLF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876715; c=relaxed/simple;
	bh=D1P6//gGLnJK/BUkGyyzg8j12UrrtDCjbavWR9nLcig=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=F/ccX0EHyTB+RDu0gjKYrKIEXfeGnHpFblB4UCN5GfW3S/ZgLFWmmHA64gCt9Q8xhVPM0Ks1YL8szouHGki6e1AibxECUv1dQqDNYpR4bKt2G9ec3YIWlU+zlsVToG7qhfN2UcMM/add/GlO7vdUdYtT2tcqyMVZhNi5mJYx8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xi6jQYE/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e6qeYh+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250625183757.868342628@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750876711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gYeMVqE9QiE6MqwPDRadjXqz6IU75/CthgeCFNFFOMA=;
	b=Xi6jQYE/dZAcbkNiP5oRzWup9TqPo9WT/C488F77EnlXjQIuf1Uw9OjCJle/7TDnIQwIeA
	02Ehzzji2TRrmqpYDE6DkjMp2Jap2rwvGevzDhkb83HpEGCJpo3Nd+wQgPAdqUSiILfFjX
	cvYaQdCMbuhnyc0zybonb7o/ZHqgnzPWKJZ1vr1TJie5qDaL2FxEa8Mee0ITGOMsmDBRjg
	gXYxhRf6W/SswZ0VhcNlTBK5BatXmKzt8MW7bsPeljVyxIKkD7zaf7NbVE0l19Uxcis/9f
	2BdcwBTOdVfOmPPn7tiXz8vIIYlVktnnIxzZAK0blIexT5UJ6bowLZXCdSqsAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750876711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gYeMVqE9QiE6MqwPDRadjXqz6IU75/CthgeCFNFFOMA=;
	b=e6qeYh+GTsUclrushjwH6Kcu1pNUfzBbqY1df4VEozvyPhSfbDz35WQqz7kep6ZEPF7syp
	v3jDw0nygG1Bm6Cw==
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
Subject: [patch V3 02/11] timekeeping: Provide time getters for auxiliary
 clocks
References: <20250625182951.587377878@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Jun 2025 20:38:31 +0200 (CEST)

Provide interfaces similar to the ktime_get*() family which provide access
to the auxiliary clocks.

These interfaces have a boolean return value, which indicates whether the
accessed clock is valid or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Remove misleading TAI comment and use aux_tkd* for clarity - John
---
 include/linux/posix-timers.h |    5 +++
 include/linux/timekeeping.h  |   11 +++++++
 kernel/time/timekeeping.c    |   65 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
---

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -37,6 +37,11 @@ static inline int clockid_to_fd(const cl
 	return ~(clk >> 3);
 }
 
+static inline bool clockid_aux_valid(clockid_t id)
+{
+	return IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS) && id >= CLOCK_AUX && id <= CLOCK_AUX_LAST;
+}
+
 #ifdef CONFIG_POSIX_TIMERS
 
 #include <linux/signal_types.h>
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -263,6 +263,17 @@ extern bool timekeeping_rtc_skipresume(v
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
+/*
+ * Auxiliary clock interfaces
+ */
+#ifdef CONFIG_POSIX_AUX_CLOCKS
+extern bool ktime_get_aux(clockid_t id, ktime_t *kt);
+extern bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt);
+#else
+static inline bool ktime_get_aux(clockid_t id, ktime_t *kt) { return false; }
+static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+#endif
+
 /**
  * struct system_time_snapshot - simultaneous raw/real time capture with
  *				 counter value
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2659,6 +2659,18 @@ EXPORT_SYMBOL(hardpps);
 /* Bitmap for the activated auxiliary timekeepers */
 static unsigned long aux_timekeepers;
 
+static inline unsigned int clockid_to_tkid(unsigned int id)
+{
+	return TIMEKEEPER_AUX_FIRST + id - CLOCK_AUX;
+}
+
+static inline struct tk_data *aux_get_tk_data(clockid_t id)
+{
+	if (!clockid_aux_valid(id))
+		return NULL;
+	return &timekeeper_data[clockid_to_tkid(id)];
+}
+
 /* Invoked from timekeeping after a clocksource change */
 static void tk_aux_update_clocksource(void)
 {
@@ -2679,6 +2691,59 @@ static void tk_aux_update_clocksource(vo
 	}
 }
 
+/**
+ * ktime_get_aux - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @kt:	Pointer to ktime_t to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux(clockid_t id, ktime_t *kt)
+{
+	struct tk_data *aux_tkd = aux_get_tk_data(id);
+	struct timekeeper *aux_tk;
+	unsigned int seq;
+	ktime_t base;
+	u64 nsecs;
+
+	WARN_ON(timekeeping_suspended);
+
+	if (!aux_tkd)
+		return false;
+
+	aux_tk = &aux_tkd->timekeeper;
+	do {
+		seq = read_seqcount_begin(&aux_tkd->seq);
+		if (!aux_tk->clock_valid)
+			return false;
+
+		base = ktime_add(aux_tk->tkr_mono.base, aux_tk->offs_aux);
+		nsecs = timekeeping_get_ns(&aux_tk->tkr_mono);
+	} while (read_seqcount_retry(&aux_tkd->seq, seq));
+
+	*kt = ktime_add_ns(base, nsecs);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux);
+
+/**
+ * ktime_get_aux_ts64 - Get time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @ts:	Pointer to timespec64 to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *ts)
+{
+	ktime_t now;
+
+	if (!ktime_get_aux(id, &now))
+		return false;
+	*ts = ktime_to_timespec64(now);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux_ts64);
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX_FIRST; i <= TIMEKEEPER_AUX_LAST; i++)


