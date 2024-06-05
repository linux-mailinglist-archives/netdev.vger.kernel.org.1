Return-Path: <netdev+bounces-101151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08E8FD7AF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C874A1C23128
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CE315F3FF;
	Wed,  5 Jun 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDZSVBgB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FF15F324
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620049; cv=none; b=jCcXeO14eq9pf78TkETnyVM9mcC57E/kTruPtAXTJAV/6LFHJ58z3C1iMuMO3vioVpiOcCuPsIoMbbTq1udo8D3alyf6umnKUzfHnDevxhETNhCWFCXzMBaGbudMVKLJZiVGWYhvYaDKrd2EY6wq4lCDWr1hWTO+6Ux/SN3nsLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620049; c=relaxed/simple;
	bh=nxV7DfHtVDVRR6GAnUgGY7qp4mmKPq9ffl0JokpKRTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=od/MUrqDTJK2+jp+Yai7T5rDD6JYQmT7WJg35kOUHaFeFJf4M3k9YdzFu7Rvi9lddrJ6C9t/hv4HMD1YYMBkUgXjpa5LaJhqfOKsJ3YF0keeRJPdilIs44fd/Myzms58LFV4sIZiGsKluCjN2KQmfG6nyeNxJNHNkKus9D2Lrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDZSVBgB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620049; x=1749156049;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nxV7DfHtVDVRR6GAnUgGY7qp4mmKPq9ffl0JokpKRTM=;
  b=eDZSVBgBTMNifhup4jKcyDcoOSLmFvgpwrqxP48WaApY4o+moIpYKgZQ
   l4ISrdgidFR9knmC2ZhV7ryg+h08ARUHIG8yJkaWp0L1NKCkhT40uFWSP
   HzpBymknILagdsG/NOQ+Rhwb91woYJ0ZVMLlc6zSH6bedZQ+0DGYyuSND
   0ilPbwA6A1TYQ0faL8XfGc2MPxq5Zx/xS/dnNSgFd+I9RGujVS94pwVGp
   rP7BGGbZztUzIuXCzeVcQ5gQDf87KzMhsqwmnvQyOfbs77BU41MzWKq/R
   5JF7cRcPLqSkmBvWCjsObAQmYTkq3ggQHDwuoN7LDm2XSJl1nL8dErGYW
   g==;
X-CSE-ConnectionGUID: XVN9C1K8QxS3bb0J/0dyqw==
X-CSE-MsgGUID: nfxurZXTRImaQoEZAcV17Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18103064"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18103064"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:46 -0700
X-CSE-ConnectionGUID: O18hcyJbSBe9v/uRWbZAKQ==
X-CSE-MsgGUID: fvBk0J6LQxingnhO6ax08Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37824323"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 05 Jun 2024 13:40:46 -0700
Subject: [PATCH v2 6/7] ice: add and use roundup_u64 instead of open coding
 equivalent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-next-2024-06-03-intel-next-batch-v2-6-39c23963fa78@intel.com>
References: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
In-Reply-To: <20240605-next-2024-06-03-intel-next-batch-v2-0-39c23963fa78@intel.com>
To: netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

In ice_ptp_cfg_clkout(), the ice driver needs to calculate the nearest next
second of a current time value specified in nanoseconds. It implements this
using div64_u64, because the time value is a u64. It could use div_u64
since NSEC_PER_SEC is smaller than 32-bits.

Ideally this would be implemented directly with roundup(), but that can't
work on all platforms due to a division which requires using the specific
macros and functions due to platform restrictions, and to ensure that the
most appropriate and fast instructions are used.

The kernel doesn't currently provide any 64-bit equivalents for doing
roundup. Attempting to use roundup() on a 32-bit platform will result in a
link failure due to not having a direct 64-bit division.

The closest equivalent for this is DIV64_U64_ROUND_UP, which does a
division always rounding up. However, this only computes the division, and
forces use of the div64_u64 in cases where the divisor is a 32bit value and
could make use of div_u64.

Introduce DIV_U64_ROUND_UP based on div_u64, and then use it to implement
roundup_u64 which takes a u64 input value and a u32 rounding value.

The name roundup_u64 matches the naming scheme of div_u64, and future
patches could implement roundup64_u64 if they need to round by a multiple
that is greater than 32-bits.

Replace the logic in ice_ptp.c which does this equivalent with the newly
added roundup_u64.

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c |  3 +--
 include/linux/math64.h                   | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index adbb9cffe20c..b7ab6fdf710d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1773,8 +1773,7 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
 	 * maintaining phase
 	 */
 	if (start_time < current_time)
-		start_time = div64_u64(current_time + NSEC_PER_SEC - 1,
-				       NSEC_PER_SEC) * NSEC_PER_SEC + phase;
+		start_time = roundup_u64(current_time, NSEC_PER_SEC) + phase;
 
 	if (ice_is_e810(hw))
 		start_time -= E810_OUT_PROP_DELAY_NS;
diff --git a/include/linux/math64.h b/include/linux/math64.h
index d34def7f9a8c..6aaccc1626ab 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -297,6 +297,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 #define DIV64_U64_ROUND_UP(ll, d)	\
 	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
 
+/**
+ * DIV_U64_ROUND_UP - unsigned 64bit divide with 32bit divisor rounded up
+ * @ll: unsigned 64bit dividend
+ * @d: unsigned 32bit divisor
+ *
+ * Divide unsigned 64bit dividend by unsigned 32bit divisor
+ * and round up.
+ *
+ * Return: dividend / divisor rounded up
+ */
+#define DIV_U64_ROUND_UP(ll, d)		\
+	({ u32 _tmp = (d); div_u64((ll) + _tmp - 1, _tmp); })
+
 /**
  * DIV64_U64_ROUND_CLOSEST - unsigned 64bit divide with 64bit divisor rounded to nearest integer
  * @dividend: unsigned 64bit dividend
@@ -342,4 +355,19 @@ u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div);
 		div_s64((__x - (__d / 2)), __d);	\
 }							\
 )
+
+/**
+ * roundup_u64 - Round up a 64bit value to the next specified 32bit multiple
+ * @x: the value to up
+ * @y: 32bit multiple to round up to
+ *
+ * Rounds @x to the next multiple of @y. For 32bit @x values, see roundup and
+ * the faster round_up() for powers of 2.
+ *
+ * Return: rounded up value.
+ */
+static inline u64 roundup_u64(u64 x, u32 y)
+{
+	return DIV_U64_ROUND_UP(x, y) * y;
+}
 #endif /* _LINUX_MATH64_H */

-- 
2.44.0.53.g0f9d4d28b7e6


