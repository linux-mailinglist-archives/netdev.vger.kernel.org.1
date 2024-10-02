Return-Path: <netdev+bounces-131376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A8598E58E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26E61C2248F
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AB919ABA9;
	Wed,  2 Oct 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjSSELms"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DF1993B2
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905925; cv=none; b=UPfPSIH3XHnwnNymQlbcZ1VD67zCC37qvJPg+pePnErMu03J2IOt894+Z8Vs7TEqK0IEEXA6XM8l4ZhAM9kPvJOWipFoPS+vghQf/CycdHK4YvmQWdz1MU2RMKPLhXXB6tcdChDQPv5eej3pe3CFDo6HqNQpgE+SPf/9UjJKm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905925; c=relaxed/simple;
	bh=hdBJuiKLIN616C/T5vTwGXgBnD3FMV/7wU5Gq6XVRfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXG/oUXKpUtOHiJfg6H5MP2xvcYficWF4+vlKzvXHy/fp9Jg9CE4HGOm/p5/pbpouPzchcMcIb531/4Il6P1oen65RX2v5R9xQL0N7V3/xVK/9Cy+vC4VhHMRHb/DtBsM8bTc7Srphdcvr+kSlBYxbjdepuXbQyC5kJdCsxjn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GjSSELms; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905924; x=1759441924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hdBJuiKLIN616C/T5vTwGXgBnD3FMV/7wU5Gq6XVRfE=;
  b=GjSSELms/oQlowHa/f6BHMZqbiVxp5qTeJhTjZmK+3IT+4tF0GiD1Puo
   6HXxTP6ub/2c1z087cMYNvk5OWS0LTSSh4z/+g62r/D/sJtSClRoIZLPi
   aRt7D/g8tq0ws9aa2kqB6vQhJmRrydx0CckfohZ8tnXYK1Md5FdlgR81w
   ZcDUGDKWJYWT8ej6BTZCblv5BreFDr2LRl9RzVX32umiRAxLqrhyW2Zvh
   04zLMEpfsFPmOBrPhFyRu79KZc95D74qTOVfaTGFaLgGjzs98nEHak2O9
   SIzmYx3i53pRx3L4EOmT9jdNfPbCwMzbk93FVv+re5l3nX1DVzweuZb7S
   A==;
X-CSE-ConnectionGUID: Zz9f0Ob+RtypKd3wr4Vt8w==
X-CSE-MsgGUID: 3lrmd+4pRbusluj1H9Btzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262044"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262044"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
X-CSE-ConnectionGUID: xOv9ABi5SQ6HTyLyW3BTkg==
X-CSE-MsgGUID: 1sazhW+fR66eDZQy0f3/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673900"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:56 -0700
Subject: [PATCH net-next v2 07/10] lib: packing: add additional KUnit tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-7-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

While reviewing the initial KUnit tests for lib/packing, Przemek pointed
out that the test values have duplicate bytes in the input sequence.

In addition, I noticed that the unit tests pack and unpack on a byte
boundary, instead of crossing bytes. Thus, we lack good coverage of the
corner cases of the API.

Add additional unit tests to cover packing and unpacking byte buffers which
do not have duplicate bytes in the unpacked value, and which pack and
unpack to an unaligned offset.

A careful reviewer may note the lack tests for QUIRK_MSB_ON_THE_RIGHT. This
is because I found issues with that quirk during test implementation. This
quirk will be fixed and the tests will be included in a future change.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing_test.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/lib/packing_test.c b/lib/packing_test.c
index 4d07523dba29..5d533e633e06 100644
--- a/lib/packing_test.c
+++ b/lib/packing_test.c
@@ -210,6 +210,88 @@ static const struct packing_test_case cases[] = {
 		.end_bit = 32,
 		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
 	},
+	/* These tests pack and unpack a magic 64-bit value
+	 * (0x1122334455667788) at an odd starting bit (43) within an
+	 * otherwise zero array of 128 bits (16 bytes). They test all possible
+	 * bit layouts of the 128 bit buffer.
+	 */
+	{
+		.desc = "no quirks, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x89, 0x11, 0x9a, 0x22, 0xab,
+		     0x33, 0xbc, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "lsw32 first, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x33, 0xbc, 0x40, 0x00,
+		     0x11, 0x9a, 0x22, 0xab, 0x00, 0x00, 0x00, 0x89),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "little endian words, 16 bytes, non-aligned",
+		PBUF(0x89, 0x00, 0x00, 0x00, 0xab, 0x22, 0x9a, 0x11,
+		     0x00, 0x40, 0xbc, 0x33, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0xbc, 0x33,
+		     0xab, 0x22, 0x9a, 0x11, 0x89, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	/* These tests pack and unpack a u64 with all bits set
+	 * (0xffffffffffffffff) at an odd starting bit (43) within an
+	 * otherwise zero array of 128 bits (16 bytes). They test all possible
+	 * bit layouts of the 128 bit buffer.
+	 */
+	{
+		.desc = "no quirks, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0x07, 0xff, 0xff, 0xff, 0xff, 0xff,
+		     0xff, 0xff, 0xf8, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "lsw32 first, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xf8, 0x00,
+		     0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0x07, 0xff),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "little endian words, 16 bytes, non-aligned, 0xff",
+		PBUF(0xff, 0x07, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+		     0x00, 0xf8, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0xf8, 0xff, 0xff,
+		     0xff, 0xff, 0xff, 0xff, 0xff, 0x07, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(packing, cases, desc);

-- 
2.46.2.828.g9e56e24342b6


