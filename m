Return-Path: <netdev+bounces-122926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B696332D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD32D1C23E99
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100971AC8BC;
	Wed, 28 Aug 2024 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7vlkVqe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5466D1AC448
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878654; cv=none; b=Pj5DdH+e/14b8em8CO0IC0Hr87u1l1f1arLwwgg7a3Fc6sWUtPnhAQZTbfDG2uISFzLz+PwGL4PrLAIR62hDz8iq2WcTtBuhQbI5njRh3tPUHCNXgcY8bOJm4qAUdZhVLL1EMjiBK+CYCM8p8+b2XAYCDDqgedXcxfMDrdIULf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878654; c=relaxed/simple;
	bh=I2Ah6OCzfIAMXv+oJczbNi/gLe6ti7p3coLoZXILxRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPb76kvoXEk1yAnUp20MZ5itmyADviNFENx+KfIUlPVYVXgz7GIL96PZ67lZWsP0xdliPmEEI//qmPlB8RZsrChwluYD/Hs6ggbjFWVa1HoIXYLyRLVRAClsLR9VJ8mXU6SOQUG2rbJO+2l7zB7ZDKz8vS81rlUIlsTz/ArGlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7vlkVqe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878653; x=1756414653;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=I2Ah6OCzfIAMXv+oJczbNi/gLe6ti7p3coLoZXILxRg=;
  b=c7vlkVqeld22yGmCwgho9Mg0V/nKIPq2D8G8PyjzymeMtDQSlj140My6
   qGS3Zx+pC8zaW11Ffr3sVY4I6uzl8FZDiEedxpTKvCQhB/yJCGqPt1SHA
   ZXq2v6rPygmA+7+OUh3Y1P/YCO9IdpSu7BXpfTvACQgxFQ5RHn1dOEcaq
   OJZC80ZQy7LvEcmo2wEEiG1vsQWT/goioUVngeImttPcMKUWTRC3gatME
   dPy9rBxE61PoTP5hHi3tP4QuZ6fhnczBLnporl9MGBZKa8ei5kfoWnJ8l
   QpnD75BdXUe1LQHZy+Ey3pWSaKDPCaEFZ+4jDaSsWyPWwR0yJSn5V9PvB
   Q==;
X-CSE-ConnectionGUID: 22//SZ2WTaqqZqFZd6MEvQ==
X-CSE-MsgGUID: SUMEmwQgT8m4zNW6kX2HYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592603"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:30 -0700
X-CSE-ConnectionGUID: jw4S+9bhRxeGGiLcYCoePA==
X-CSE-MsgGUID: d1fpVscGTD2xxQFBt6fRXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049977"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 28 Aug 2024 13:57:23 -0700
Subject: [PATCH iwl-next v2 07/13] lib: packing: add additional KUnit tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-7-558ab9e240f5@intel.com>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

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
2.46.0.124.g2dc1a81c8933


