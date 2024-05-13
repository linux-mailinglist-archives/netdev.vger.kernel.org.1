Return-Path: <netdev+bounces-95986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69428C3F34
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E4289EC8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A142F152E0B;
	Mon, 13 May 2024 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GpbjqcSA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA6F1527A6;
	Mon, 13 May 2024 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596761; cv=none; b=oEC/Az8/FUVubbUr9Et+obdX9J4g4DodazJvVcL4F72wc/ZrejnugbD2PeCxWu8L2Rl7LJx/9gmSI3qeF3fpWYOifYpmGgT77+yqN7YgPIA7Qg0yrNxTT4WIzDPNoJHTxN8Q8GrINuOxpuOXVoMV5zCzMNWoFOQVw4+QtgNVTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596761; c=relaxed/simple;
	bh=IseBVxj7TxLQvtRm4JaluePpwuEWyzQwD7jXVspSW8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N4e9as4IJbCR+ER+B2UDHdecnaPNzWDK7OLCERgDr98c5xES073VokUrqLKUV1m/5gn8eHwP87DFAkP2fnQlB0vaOilFo/B7TizApLaW/DSq3hVMr7WLHovMzqsUtiJw+KNw3NWI9a1cIScp5J3Jt/KsqFoKn9fiFj37itoknGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GpbjqcSA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596760; x=1747132760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IseBVxj7TxLQvtRm4JaluePpwuEWyzQwD7jXVspSW8Q=;
  b=GpbjqcSA1oTJUsYB8iT4CzSgZY2sDfnmf1+KOKIOvT3REZNcN6j1IzNs
   aW+jZN5tGAYIDILdH7k+EG1bdcKKWuExv9vMEAMqwOZWg8AfCBG9XOMCA
   qSav92A0Ngnp8O3jclGbml4J4HHR0ClM7whKUv1I3ZpXCCpsJxU8Z/UMz
   qfzeHv7j051nHM02FuwY2HvAZeysPdyfY1zmjM6Q5EQJkTqSV5Drx/yNf
   5F6oxa1B7B/RyZ7b18d6+dSZVXdIZMHI/O0zggAPFtjdms5NWm/rxbzGl
   u4VFNs8jjO3XZ4drd5yeNcSbtGyAtA8+kLVB8Xay1S9NniHb+Tw+KvMgE
   g==;
X-CSE-ConnectionGUID: 1qTNattaSJiIwAyJLVdvAg==
X-CSE-MsgGUID: KQYXtd9aRB6zObTqkp571A==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29039125"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29039125"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:39:18 -0700
X-CSE-ConnectionGUID: La7vmDcuRxWg3TWG8mvhdg==
X-CSE-MsgGUID: BjdCcZmkTfCuZkBZJA3emA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481793"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:39:12 -0700
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
Subject: [PATCH v8 09/12] timekeeping: Add function to convert realtime to base clock
Date: Mon, 13 May 2024 16:08:10 +0530
Message-Id: <20240513103813.5666-10-lakshmi.sowjanya.d@intel.com>
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

PPS (Pulse Per Second) generates a hardware pulse every second based on
CLOCK_REALTIME. This works fine when the pulse is generated in software
from a hrtimer callback function.

For hardware which generates the pulse by programming a timer it's
required to convert CLOCK_REALTIME to the underlying hardware clock.

The X86 Timed IO device is based on the Always Running Timer (ART),
which is the base clock of the TSC, which is usually the system
clocksource on X86.

The core code already has functionality to convert base clock timestamps
to system clocksource timestamps, but there is no support for converting
the other way around.

Provide the required functionality to support such devices in a generic
way to avoid code duplication in drivers:

	1) ktime_real_to_base_clock() to convert a CLOCK_REALTIME
	   timestamp to a base clock timestamp
	2) timekeeping_clocksource_has_base() to allow drivers to
	   validate that the system clocksource is based on a particular
	   clocksource ID.

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 include/linux/timekeeping.h |  4 ++
 kernel/time/timekeeping.c   | 86 +++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b2ee182d891e..fc12a9ba2c88 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -318,6 +318,10 @@ struct system_counterval_t {
 	bool			use_nsecs;
 };
 
+extern bool ktime_real_to_base_clock(ktime_t treal,
+				     enum clocksource_ids base_id, u64 *cycles);
+extern bool timekeeping_clocksource_has_base(enum clocksource_ids id);
+
 /*
  * Get cross timestamp between system clock and device clock
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 92994450f268..326db459a2ea 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1229,6 +1229,64 @@ static bool convert_base_to_cs(struct system_counterval_t *scv)
 	return true;
 }
 
+static bool convert_cs_to_base(u64 *cycles, enum clocksource_ids base_id)
+{
+	struct clocksource *cs = tk_core.timekeeper.tkr_mono.clock;
+	struct clocksource_base *base = cs->base;
+
+	/* Check whether base_id matches the base clock */
+	if (!base || base->id != base_id)
+		return false;
+
+	*cycles -= base->offset;
+	if (!convert_clock(cycles, base->denominator, base->numerator))
+		return false;
+	return true;
+}
+
+static bool convert_ns_to_cs(u64 *delta)
+{
+	struct tk_read_base *tkr = &tk_core.timekeeper.tkr_mono;
+
+	if (BITS_TO_BYTES(fls64(*delta) + tkr->shift) >= sizeof(*delta))
+		return false;
+
+	*delta = div_u64((*delta << tkr->shift) - tkr->xtime_nsec, tkr->mult);
+	return true;
+}
+
+/**
+ * ktime_real_to_base_clock() - Convert CLOCK_REALTIME timestamp to a base clock timestamp
+ * @treal:	CLOCK_REALTIME timestamp to convert
+ * @base_id:	base clocksource id
+ * @cycles:	pointer to store the converted base clock timestamp
+ *
+ * Converts a supplied, future realtime clock value to the corresponding base clock value.
+ *
+ * Return:  true if the conversion is successful, false otherwise.
+ */
+bool ktime_real_to_base_clock(ktime_t treal, enum clocksource_ids base_id, u64 *cycles)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	u64 delta;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		if ((u64)treal < tk->tkr_mono.base_real)
+			return false;
+		delta = (u64)treal - tk->tkr_mono.base_real;
+		if (!convert_ns_to_cs(&delta))
+			return false;
+		*cycles = tk->tkr_mono.cycle_last + delta;
+		if (!convert_cs_to_base(cycles, base_id))
+			return false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(ktime_real_to_base_clock);
+
 /**
  * get_device_system_crosststamp - Synchronously capture system/device timestamp
  * @get_time_fn:	Callback to get simultaneous device time and
@@ -1340,6 +1398,34 @@ int get_device_system_crosststamp(int (*get_time_fn)
 }
 EXPORT_SYMBOL_GPL(get_device_system_crosststamp);
 
+/**
+ * timekeeping_clocksource_has_base - Check whether the current clocksource
+ *     is based on given a base clock
+ * @id:		base clocksource ID
+ *
+ * Note:	The return value is a snapshot which can become invalid right
+ *		after the function returns.
+ *
+ * Return:	true if the timekeeper clocksource has a base clock with @id,
+ *		false otherwise
+ */
+bool timekeeping_clocksource_has_base(enum clocksource_ids id)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		if (tk_core.timekeeper.tkr_mono.clock->base)
+			ret = (tk_core.timekeeper.tkr_mono.clock->base->id == id);
+		else
+			ret = false;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(timekeeping_clocksource_has_base);
+
 /**
  * do_settimeofday64 - Sets the time of day.
  * @ts:     pointer to the timespec64 variable containing the new time
-- 
2.35.3


