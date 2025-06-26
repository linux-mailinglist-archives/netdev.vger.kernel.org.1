Return-Path: <netdev+bounces-201566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00918AE9EBB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C41A7B5B50
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13CD2E54B5;
	Thu, 26 Jun 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45OeGOvb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6GZZrhE"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FE21CC62;
	Thu, 26 Jun 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750944454; cv=none; b=A48wmNYSe0siT/kNr7LZt6/OVkz9DFC529TeB/i653fxvnFur+SlzYRIAeIKp7rQWbHLOPYoEOT6BY/JOh9hYDGjyVaK+Fc+j1TsBG2wt7m7Y6YdXlOmbNmUYpEVKSYlWHgTD3eLTBQO69yZsqZ1z74DOmrUSzaPbHVKFywepZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750944454; c=relaxed/simple;
	bh=iPQitKJaOAw1dcX7ZOo2cTMoyJ5pc70J9AQA/1gmZz8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=GKYGfddl1zh/Ittcaz9OzKCt98UoVLY9Tzb5pMxVcp9ld3rQuozF0qkdGoMo7DLAZSxocpxOr3yieVp1Td46lkXqVPP+ftji+3A36IF9eTgIa/v6WxN0kstP9XePelWBTdHK0N0+liycbA5ywGCjeYBS5Gls/oPGR2wvCQy4BdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45OeGOvb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E6GZZrhE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250626131708.419101339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750944451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3g83WUkcahA98tSAvTQ+7u+GY59xMVQMWbvReg+4HxI=;
	b=45OeGOvbc1FQu84tfTVe0f2noUtdJYd9OuBPXbg6cB8GmCirEgGwogjyC+D9dYYo0qlTlj
	FBSdahHr8QXontgg1UjT/tV6dgwkbqbtIRFjHs8AbUxqywoKG/DZNWmWlwQmYbHUX0IMZR
	/hIfxxipeXHmkhiyj5D/2/p7VJk3sx7TCq0mwqNVSJL1WMKQyxAQQblzw3bJySGFYqcwyk
	NHfTyX5j7/MrAtI1IqjYJ9K/kL3GmnoL8foFJgkxM27C7CMfUykryIgzJ3nA1uayXw6kIP
	/cKsMCEwg/XCsX2gLDKci8qi453Nv/BqYZXXciFtBKNyAfkLlFXOZYECKyYtgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750944451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=3g83WUkcahA98tSAvTQ+7u+GY59xMVQMWbvReg+4HxI=;
	b=E6GZZrhErWzckN9MDzfoFmzVq1fkYY5lUJ56uKMVLqh8VpHKQQ6YLFPym0ZOSff2+iNP2D
	dTZ1yNIN+8+FeoDw==
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
Subject: [patch 1/3] timekeeping: Provide ktime_get_clock_ts64()
References: <20250626124327.667087805@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 15:27:30 +0200 (CEST)

PTP implements an inline switch case for taking timestamps from various
POSIX clock IDs, which already consumes quite some text space. Expanding it
for auxiliary clocks really becomes too big for inlining.

Provide a out of line version. 

The function invalidates the timestamp in case the clock is invalid. The
invalidation allows to implement a validation check without the need to
propagate a return value through deep existing call chains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeping.h |    1 +
 kernel/time/timekeeping.c   |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -44,6 +44,7 @@ extern void ktime_get_ts64(struct timesp
 extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
+extern void ktime_get_clock_ts64(clockid_t id, struct timespec64 *ts);
 
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1636,6 +1636,40 @@ void ktime_get_raw_ts64(struct timespec6
 EXPORT_SYMBOL(ktime_get_raw_ts64);
 
 /**
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
+
+/**
  * timekeeping_valid_for_hres - Check if timekeeping is suitable for hres
  */
 int timekeeping_valid_for_hres(void)


