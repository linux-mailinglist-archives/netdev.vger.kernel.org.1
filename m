Return-Path: <netdev+bounces-191424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF5ABB777
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4891887EE9
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F4A27464E;
	Mon, 19 May 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1CwmAzO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzFioUAo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6F2741CA;
	Mon, 19 May 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643620; cv=none; b=neWqpnZAeA7vN2IUWW48Tl04Yz8uFlZ2vmtfS071j+AvN7vHdGneJxd/0Wp1PYg8OVq+XzwTRi/EDbgLH5pIEI6q42wDJVQ22Nue7s4HgtvRXH2l2UX/xDnw4BQ3adj2X1LWsTkD0Mb40Ie3kxpOzL6JRMVXenOCghL0P0Ds4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643620; c=relaxed/simple;
	bh=no92kLIwjLeFJ2b8otG0qvCk3qoDGVcDj7yfnjmkOKI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jhdA0Fl5RoX65gRk1+mBAQw4uXt+NxcVqITozAwM771Q4x2tNK2Ov166H8fJCfSwrYfGTPdeeBDGM9To48HF4d6b3FRPE25IKg4eayU8GZjaz5gg6cgXsxN+Ri7jdtEjsk2MviVqctBTE/tzhnzbfOPUjCV9ITNhOWdN3NLXWY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1CwmAzO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzFioUAo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250519083026.655171665@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747643615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XpdXKR0LjhP1+em4VmwJU235Z2KZZt3yqEw6zu3whRs=;
	b=u1CwmAzOg2e3lvf2iCSLEEM8afj26YyCdFVAOaigpKBVFDgXh+BtUndR9+gGliQEtZXKKB
	wunLW5raf8oeaXxGVkkABSETDqCYK9s+DA3MK4+Pg2rgvEuHsapa4fqZjdVmmAQqyM81Tu
	IfE1cGqjwhm9kb3nYysoNg4fB5HLb1RtaUil3fWHV5LEaLPyTllaRF3bFI37LQ6kMDftdI
	3qXTh5TvN5mzHYMHgC0z2dYPoUVGROEQ7B/RdNfYzwCGTJPA0UADAKli/Lxd16mBVjV9p+
	WXgTYOg3dthk8VaSXEzcuBgfnD2bt5j5K6fr564S/NiYLoNCdiftV511B2xCzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747643615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XpdXKR0LjhP1+em4VmwJU235Z2KZZt3yqEw6zu3whRs=;
	b=UzFioUAoqne1+tTxgWGBtCg/5TuWdSq0ZvH2cQ4bEjRq888SocJhR0fHnK4/zSPI4vfjOl
	yUN44YxWfPu3x5Aw==
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
Subject: [patch V2 17/26] timekeeping: Provide time getters for auxiliary
 clocks
References: <20250519082042.742926976@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 May 2025 10:33:35 +0200 (CEST)

Provide interfaces similar to the ktime_get*() family which provide access
to the auxiliary clocks.

These interfaces have a boolean return value, which indicates whether the
accessed clock is valid or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeping.h |   11 +++++++
 kernel/time/timekeeping.c   |   62 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
---
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
@@ -2659,6 +2659,23 @@ EXPORT_SYMBOL(hardpps);
 /* Bitmap for the activated auxiliary timekeepers */
 static unsigned long aux_timekeepers;
 
+static inline bool aux_valid_clockid(clockid_t id)
+{
+	return id >= CLOCK_AUX && id <= CLOCK_AUX_LAST;
+}
+
+static inline unsigned int clockid_to_tkid(unsigned int id)
+{
+	return TIMEKEEPER_AUX + id - CLOCK_AUX;
+}
+
+static inline struct tk_data *aux_get_tk_data(clockid_t id)
+{
+	if (!aux_valid_clockid(id))
+		return NULL;
+	return &timekeeper_data[clockid_to_tkid(id)];
+}
+
 /* Invoked from timekeeping after a clocksource change */
 static void tk_aux_update_clocksource(void)
 {
@@ -2679,6 +2696,51 @@ static void tk_aux_update_clocksource(vo
 	}
 }
 
+/**
+ * ktime_get_aux - Get TAI time for a AUX clock
+ * @id:	ID of the clock to read (CLOCK_AUX...)
+ * @kt:	Pointer to ktime_t to store the time stamp
+ *
+ * Returns: True if the timestamp is valid, false otherwise
+ */
+bool ktime_get_aux(clockid_t id, ktime_t *kt)
+{
+	struct tk_data *tkd = aux_get_tk_data(id);
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
+		base = ktime_add(tk->tkr_mono.base, tk->offs_aux);
+		nsecs = timekeeping_get_ns(&tk->tkr_mono);
+	} while (read_seqcount_retry(&tkd->seq, seq));
+
+	*kt = ktime_add_ns(base, nsecs);
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_get_aux);
+
+bool ktime_get_aux_ts64(clockid_t id, struct timespec64 *ts)
+{
+	ktime_t now;
+
+	if (!ktime_get_aux(id, &now))
+		return false;
+	*ts = ktime_to_timespec64(now);
+	return true;
+}
+
 static __init void tk_aux_setup(void)
 {
 	for (int i = TIMEKEEPER_AUX; i <= TIMEKEEPER_AUX_LAST; i++)


