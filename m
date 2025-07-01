Return-Path: <netdev+bounces-202914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008A8AEFA9F
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD894A0D95
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B05277C94;
	Tue,  1 Jul 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODQNWt64";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLTz2k2l"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961162777FC;
	Tue,  1 Jul 2025 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376423; cv=none; b=T8CY6HQF8O4RQuoG1EDKqTgypWdxgt+NuZN7/ubr+jss/tunzpuPsUe7LeE5djIWBr5rZ/wwhF+fjjrM3utnGV/vsDZQlb+LTBaOiZuRVR5ASJNsHOS5333Ob9wA22Y4V69CFW80GkED2Dt8iTA4Egna7jm0fLbbe/GvqOAe01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376423; c=relaxed/simple;
	bh=5RNhCpR6Q1GmYvcPKgXDCb94dG9rjVKCJEAKUi69+Es=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BcrQmxkdiCgtQv/TnR6sv0l0pEHlFCLbzCJjnW/VLTwOmNwTHqmT6i+RhJ9NLxNgtJ9+vR44U2hKY1beYmFqe4a8R/BhIRfp3OwOt7jWG29TiW0YM5CwRUzJy+vyGsGDAut22g33bhz8ySwxcjXwlYMJjFLjrydLz4mE7MhVaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODQNWt64; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLTz2k2l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250701132628.357686408@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751376419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hoiEUCmAftSwBNyHB6MQ2qZehcsPidfdPcIR06aCg/g=;
	b=ODQNWt64TaeT1qQUWjm/yruEkouA/hrp0m/pUfFzl45HyT+yMlr0EkojW2khfGZcG+M25W
	g9dR+eYLdALIYk8CqoJ9lGxdBQZ8ilDe47RgHBgGcMIC3z6NDhPc8oaGXam00x5N6vquku
	WVO7ld/NDdYjtq1gYHzM/yqsZXan5u8ZhOff7m6NUUUYD0cTmeek6IY2eF1L1ys1/N6i2H
	xZIhkKJkw6LXl827oE94AjpoCCzdXP5S1cFTFACyEg+yzSooK0RKEAAyNYo7KEv+z1Zo4X
	+c+cIPc59h3pWGWihayN5LcNdbqfuYVnVBeGxYP5N3fg+w3XFovntbiu0S3OuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751376419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=hoiEUCmAftSwBNyHB6MQ2qZehcsPidfdPcIR06aCg/g=;
	b=xLTz2k2lD6y6T+/uwlo5izxwUMW3eTObL4lrQ1dM+t2BVgzUKjvpd/jBcQpMOC++gkr4MO
	uSVhQ1D1SSUTSyDA==
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
 Antoine Tenart <atenart@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [patch V2 1/3] timekeeping: Provide ktime_get_clock_ts64()
References: <20250701130923.579834908@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  1 Jul 2025 15:26:58 +0200 (CEST)

PTP implements an inline switch case for taking timestamps from various
POSIX clock IDs, which already consumes quite some text space. Expanding it
for auxiliary clocks really becomes too big for inlining.

Provide a out of line version. 

The function invalidates the timestamp in case the clock is invalid. The
invalidation allows to implement a validation check without the need to
propagate a return value through deep existing call chains.

Due to merge logistics this temporarily defines CLOCK_AUX[_LAST] if
undefined, so that the plain branch, which does not contain any of the core
timekeeper changes, can be pulled into the networking tree as prerequisite
for the PTP side changes. These temporary defines are removed after that
branch is merged into the tip::timers/ptp branch. That way the result in
-next or upstream in the next merge window has zero dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Acked-by: John Stultz <jstultz@google.com>
---
V2: Provide a workaround for networking folks to handle merge logistics.
---
 include/linux/timekeeping.h |   10 ++++++++++
 kernel/time/timekeeping.c   |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timesp
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
 
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
@@ -345,4 +346,13 @@ void read_persistent_wall_and_boot_offse
 extern int update_persistent_clock64(struct timespec64 now);
 #endif
 
+/* Temporary workaround to avoid merge dependencies and cross tree messes */
+#ifndef CLOCK_AUX
+#define CLOCK_AUX			MAX_CLOCKS
+#define MAX_AUX_CLOCKS			8
+#define CLOCK_AUX_LAST			(CLOCK_AUX + MAX_AUX_CLOCKS - 1)
+
+static inline bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *kt) { return false; }
+#endif
+
 #endif
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1573,6 +1573,39 @@ void ktime_get_raw_ts64(struct timespec6
 }
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
+/**
+ * ktime_get_clock_ts64 - Returns time of a clock in a timespec
+ * @id:		POSIX clock ID of the clock to read
+ * @ts:		Pointer to the timespec64 to be set
+ *
+ * The timestamp is invalidated (@ts->sec is set to -1) if the
+ * clock @id is not available.
+ */
+void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts)
+{
+	/* Invalidate time stamp */
+	ts->tv_sec = -1;
+	ts->tv_nsec = 0;
+
+	switch (id) {
+	case CLOCK_REALTIME:
+		ktime_get_real_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC:
+		ktime_get_ts64(ts);
+		return;
+	case CLOCK_MONOTONIC_RAW:
+		ktime_get_raw_ts64(ts);
+		return;
+	case CLOCK_AUX ... CLOCK_AUX_LAST:
+		if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
+			ktime_get_aux_ts64(id, ts);
+		return;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+EXPORT_SYMBOL_GPL(ktime_get_clock_ts64);
 
 /**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres


