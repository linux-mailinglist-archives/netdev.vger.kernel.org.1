Return-Path: <netdev+bounces-95977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966A8C3F0C
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0521C22070
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD314A60A;
	Mon, 13 May 2024 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fc1YiLWW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2E9148FE5;
	Mon, 13 May 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596711; cv=none; b=LjDfJ9XnW1KRXkyLrSGHLi0xMDRlDaJ+Kce7kt6kX7sR/y79oF/q7H9fLbkHpKkuJk+3lapbFJR2vYlDq+GFp5t5tSE59yYAOWbPYs3KsMYw0CwYa5Bg8AonRebk68JzDoNXz+sFlbDOpljk72J3LIHZvR1XvKLq/LxfcZNrQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596711; c=relaxed/simple;
	bh=7G4eSCDfpVxftfhKiGN17VIsixny1njY40VIbJ98TVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fLeZni6erPjTU1kfwJvNXc2ay8H21Mcio2tA3BJv/DGYUgQkOo6Q2bcVfIwY1Bfmdk/zRpUCCl+GNPfeHrTQFw2KvtrmXJi1dr0U30HUv2Y9qjXec3o+MJOdmsvBL7DY1KGqf2ND6ve700nS9Jxt+ywUl4x6RXFZCMGkR/QQEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fc1YiLWW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596709; x=1747132709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7G4eSCDfpVxftfhKiGN17VIsixny1njY40VIbJ98TVA=;
  b=fc1YiLWWyExVdn0mtxVgbifntNsLB88tPuNXm5Lw/IxXRZLPdE2hky9s
   0O0SfoSYfvX9bxJN0QJ2DFxfwJpCvm/Zf8wb5/K4AZykStJbld4VlqnpC
   9UwLMPq31hmsAlDxovHBIN6tr0IXq7AvXj0cNVQ9E+80PbwkR1VVmJJGF
   AYCWvD8ZNpAoDcwOQSUkfLjJ4SdcDuTaFtx0LV/oW96YyCVQ2bIXs1C31
   aX6Ovb4aNbic3LsT/qN/tlz7pVAJcTMHjMo2zXC0wi0SuJDAu+NOLYbzx
   /iSkFLZPvD3ZQCbonHF8SdWf0eAnnxK5/BsP1Xgh7bY2jAVj2gG2e7/rk
   g==;
X-CSE-ConnectionGUID: UhgtvWuUQEOhhwfEfOeu9w==
X-CSE-MsgGUID: 7330siw8Rcy/B+AFkqB/bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29038867"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29038867"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:38:27 -0700
X-CSE-ConnectionGUID: 5SXcqXPNRZOJJ/yAAKqLpA==
X-CSE-MsgGUID: v0sYACCoRqKLe2eBPIE8iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481699"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:38:20 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	subramanian.mohan@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v8 01/12] timekeeping: Add base clock properties in clocksource structure
Date: Mon, 13 May 2024 16:08:02 +0530
Message-Id: <20240513103813.5666-2-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

Add base clock hardware abstraction in clocksource structure.

Provide generic functionality in convert_base_to_cs() to convert base
clock timestamps to system clocksource without requiring architecture
specific parameters.

This is intended to replace convert_art_to_tsc() and
convert_art_ns_to_tsc() functions which are specific to convert ART
(Always Running Timer) time to the corresponding TSC value.

Add the infrastructure in get_device_system_crosststamp().

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/clocksource.h | 27 ++++++++++++++++++++++++++
 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 38 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b550bb4b..d35b677b08fe 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+struct clocksource_base;
 struct clocksource;
 struct module;
 
@@ -50,6 +51,7 @@ struct module;
  *			multiplication
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
+ * @freq_khz:		Clocksource frequency in khz.
  * @rating:		Rating value for selection (higher is better)
  *			To avoid rating inflation the following
  *			list should give you a guide as to how
@@ -70,6 +72,8 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base:		Hardware abstraction for clock on which a clocksource
+ *			is based
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -107,10 +111,12 @@ struct clocksource {
 	u64			max_cycles;
 	const char		*name;
 	struct list_head	list;
+	u32			freq_khz;
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base *base;
 
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -306,4 +312,25 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
 
 void clocksource_verify_percpu(struct clocksource *cs);
 
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clocksource
+ *			is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID in certain snapshot
+ *			functions to allow callers to validate the clocksource from
+ *			which the snapshot was taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the clocksource
+ * @denominator:	Denominator of the clock ratio between base clock and the clocksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 0ea7823b7f31..b2ee182d891e 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -310,10 +310,12 @@ struct system_device_crosststamp {
  *		timekeeping code to verify comparability of two cycle values.
  *		The default ID, CSID_GENERIC, does not identify a specific
  *		clocksource.
+ * @use_nsecs:	@cycles is in nanoseconds.
  */
 struct system_counterval_t {
 	u64			cycles;
 	enum clocksource_ids	cs_id;
+	bool			use_nsecs;
 };
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..92994450f268 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1193,6 +1193,42 @@ static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 	return false;
 }
 
+static bool convert_clock(u64 *val, u32 numerator, u32 denominator)
+{
+	u64 rem, res;
+
+	if (!numerator || !denominator)
+		return false;
+
+	res = div64_u64_rem(*val, denominator, &rem) * numerator;
+	*val = res + div_u64(rem * numerator, denominator);
+	return true;
+}
+
+static bool convert_base_to_cs(struct system_counterval_t *scv)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+	u32 num, den;
+
+	/* The timestamp was taken from the time keeper clock source */
+	if (cs->id == scv->cs_id)
+		return true;
+
+	/* Check whether cs_id matches the base clock */
+	if (!base || base->id != scv->cs_id)
+		return false;
+
+	num = scv->use_nsecs ? cs->freq_khz : base->numerator;
+	den = scv->use_nsecs ? USEC_PER_SEC : base->denominator;
+
+	if (!convert_clock(&scv->cycles, num, den))
+		return false;
+
+	scv->cycles += base->offset;
+	return true;
+}
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1239,7 +1275,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 * installed timekeeper clocksource
 		 */
 		if (system_counterval.cs_id == CSID_GENERIC ||
-		    tk->tkr_mono.clock->id != system_counterval.cs_id)
+		    !convert_base_to_cs(&system_counterval))
 			return -ENODEV;
 		cycles = system_counterval.cycles;
 
-- 
2.35.3


