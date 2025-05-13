Return-Path: <netdev+bounces-190194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A9AB5838
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B917AE187
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2292BFC82;
	Tue, 13 May 2025 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="erpG3n5K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pS1ZUyeC"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F22BEC39;
	Tue, 13 May 2025 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747149199; cv=none; b=YDvVuxW9mpSkp5ETosFHv1vYjcmmulJ/81qZ6a2eEq5PHtuowkJbL5iB51YFa9itTzQ/x4OF4QwSWl4qgZBS90Q+rbKdNNnZhsWWy3uSffzeMxna6aMlENbwn6GUiuWDRudzfLypae6WeCZP7NeH/ILNOEfBKhwpwHvg20ZbHdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747149199; c=relaxed/simple;
	bh=VlpD/aEqQPqlO9v6Lb2z2stYvqmnHu9mvPbwUMFbbhs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lcsLrunBwBipap07H4k7sNvjfScBXFQHD/iAnGg4/fMH803NhIyGUzFAwGdHuSsSb9f37ufj/aU2I5IMfUbMng5Cx9kXPf5kJ3G+aqKKaCYwvOmzd4EU2r2oRv2YiGBpzgQ4m320iKwAdiPdSdJTcLBk7+gYjwAFW9Iz09gs+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=erpG3n5K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pS1ZUyeC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250513145136.968343429@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747149184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XPHajFVCZoXQl/Q8ekCokP2ZDch4oKNZfnysGAyLhao=;
	b=erpG3n5K2Z3RhUIhzFJ8R3wNIpHAxnzp7ooKt3R/NTiey3iPrW6Wf8LMLrAJPglS+JfxEK
	kWuzuLaXHr4OWCnzeyCkq1FFVbIAcUKMUwK2LMrLlCqcAVI2kejmhggQRZoiXGnUFiPpXq
	Pi1BmtO19Q3ZxqxW6wLIZ8RO1c0OPDitRMMbLRmWfl9uYnxwzwt7De5PUCE79Iujis7sAk
	11JznXNGW9muXuM0CNk9CLaXRy3JH21vahSsUwEh49tBHn2t6HqMo1r3X5Qskj3DmrJPPF
	lZqoQZ2BcifdrNgNwK3AaB9n1tGwuMH/17ifsK3XykcQb/pIxsjm/aI2wezwTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747149184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XPHajFVCZoXQl/Q8ekCokP2ZDch4oKNZfnysGAyLhao=;
	b=pS1ZUyeCa0qJwlATcj2MM9izfMFJO5sakqrVo9qZUHjZF4dfrk/KnOOW/5nzv5dIuypny4
	67gmrxXBMN4Io9Bg==
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
Subject: [patch 05/26] time: Introduce PTP clocks
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 May 2025 17:13:04 +0200 (CEST)

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support per PTP clock timekeeping and the related user space interfaces,
it's required to define a clock ID range for them.

Reserve 8 PTP clock IDs after the regular timekeeping clock ID space.

This is the maximum number of PTP clocks the kernel can support. The actual
number of supported clocks depends obviously on the presence of PTP devices
and might be constraint by the available VDSO space.

Add the corresponding timekeeper IDs as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/timekeeper_internal.h |    6 ++++++
 include/uapi/linux/time.h           |   10 ++++++++++
 kernel/time/Kconfig                 |    3 +++
 3 files changed, 19 insertions(+)
---
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -14,10 +14,16 @@
 /**
  * timekeeper_ids - IDs for various time keepers in the kernel
  * @TIMEKEEPER_CORE:	The central core timekeeper managing system time
+ * @TIMEKEEPER_PTP:	The first PTP timekeeper
+ * @TIMEKEEPER_PTP_LAST:The last PTP timekeeper
  * @TIMEKEEPERS_MAX:	The maximum number of timekeepers managed
  */
 enum timekeeper_ids {
 	TIMEKEEPER_CORE,
+#ifdef CONFIG_POSIX_PTP_CLOCKS
+	TIMEKEEPER_PTP,
+	TIMEKEEPER_PTP_LAST = TIMEKEEPER_PTP + MAX_PTP_CLOCKS - 1,
+#endif
 	TIMEKEEPERS_MAX,
 };
 
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -64,6 +64,16 @@ struct timezone {
 #define CLOCK_TAI			11
 
 #define MAX_CLOCKS			16
+
+/*
+ * PTP clock support. PTP clocks are dynamically configured by associating
+ * a clock ID to a PTP device. The kernel can support up to 16 PTP clocks,
+ * but the actual limit depends on architecture constraints vs. VDSO.
+ */
+#define	CLOCK_PTP			MAX_CLOCKS
+#define	MAX_PTP_CLOCKS			8
+#define CLOCK_PTP_LAST			(CLOCK_PTP + MAX_PTP_CLOCKS - 1)
+
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
 #define CLOCKS_MONO			CLOCK_MONOTONIC
 
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -57,6 +57,9 @@ config POSIX_CPU_TIMERS_TASK_WORK
 	bool
 	default y if POSIX_TIMERS && HAVE_POSIX_CPU_TIMERS_TASK_WORK
 
+config POSIX_PTP_CLOCKS
+	def_bool POSIX_TIMERS && PTP_1588_CLOCK
+
 config LEGACY_TIMER_TICK
 	bool
 	help


