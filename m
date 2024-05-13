Return-Path: <netdev+bounces-95985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D88C3F2D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD871F21EB9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBA614D282;
	Mon, 13 May 2024 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKiPYeWt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303314C5AA;
	Mon, 13 May 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596754; cv=none; b=bl28RFKNIQ5KO5q3I/8s1INoFsAW00rk7DMaA+HJGSI9TpNPcsVNlXCgIRy6OwL+fLph1aXbh1ZIASjy53ixxs86MmBAFop5GPLGMDJFD4r3PBBds+rIM90vAndT90AJd42ueJRl0x6yYc2ah5imv/2ndi9NqjzWMq5j+5+gIjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596754; c=relaxed/simple;
	bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NOtqt6WBcLa9w5S83W/5Nv+/ZP37nLOrm0JqtEiMSXMYVCZ54FRcS9prCQygv4lU/He5uGoorf7MLSwIWy8SB58oIEYDhIPYF1+lQcueEQT2EC35I6wQrx0do358PyFTvemytJuty5IBdHJ/XwJqg1oJwIEqIGfstBtybP2sAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKiPYeWt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596753; x=1747132753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
  b=ZKiPYeWtoF2fztsI1CQ6MGGyvGp0y68DZfvUTfODJT6Eu7voMmFHfg34
   vQE6GpjRPB+VJfnhdnrhfNTivSDwzFug+uAtOK6OC+ABMlz2++bo11L7Q
   uwhnBoQrEu8h1R7i6/SJDSXgBzCvDGfBsf7+JNrW89uthEOmUpR87bQIQ
   Z2WnjSA561yBhrmf9ffXvjCH8rX0sPaLm0KLtAjKDtID4GO5G6V75fVIN
   58XT6NiVlolKTIZoBFQupMTyTKychoORoenfrweP8p32dYwFvFTKJfGDJ
   y/kWQXt5C+KY9NC7XzKoMNnOh8N8jihEq2G7VdVK8pk1k1qK8bxyrL7jS
   g==;
X-CSE-ConnectionGUID: wCDH4Tp+RK+zV7QQAzH0Eg==
X-CSE-MsgGUID: Y7MxhbbIScuf73UZLCgVXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="29039100"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="29039100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:39:12 -0700
X-CSE-ConnectionGUID: XIztl16ERtW6+ey3kxr0XA==
X-CSE-MsgGUID: M6NhZ+exShu/uXbKAZzTdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="61481772"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 13 May 2024 03:39:06 -0700
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
Subject: [PATCH v8 08/12] x86/tsc: Remove art to tsc conversion functions which are obsolete
Date: Mon, 13 May 2024 16:08:09 +0530
Message-Id: <20240513103813.5666-9-lakshmi.sowjanya.d@intel.com>
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

The convert_art_to_tsc() and convert_art_ns_to_tsc() interfaces are no
longer required. This conversion is internally done in
get_device_system_crosststamp() using convert_base_to_cs().

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 arch/x86/include/asm/tsc.h |  3 --
 arch/x86/kernel/tsc.c      | 60 --------------------------------------
 2 files changed, 63 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 405efb3e4996..94408a784c8e 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,9 +28,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 45bf2f6d0ffa..5f0bd441ed4d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1297,66 +1297,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art, art_base_clk.denominator);
-
-	res = art * art_base_clk.numerator;
-	tmp = rem * art_base_clk.numerator;
-
-	do_div(tmp, art_base_clk.denominator);
-	res += tmp + art_base_clk.offset;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timestamp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the ID of the
- *	corresponding clocksource:
- *	cycles:		System counter value
- *	cs_id:		The clocksource ID for validating comparability
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art_ns, USEC_PER_SEC);
-
-	res = art_ns * tsc_khz;
-	tmp = rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res += tmp;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
-- 
2.35.3


