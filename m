Return-Path: <netdev+bounces-130663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6A98B0B8
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481FC282C32
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F118C904;
	Mon, 30 Sep 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWTHMxXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908B188A0F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738395; cv=none; b=HB2t1qCJIv6yNEng7miKzkXJbxGD2JzkshVg0tLHDI5ZEG+UD1gjdJZMI2C/3XJASZv799At8rZZUJYl2dlbUN8FpiBaLESKsT1v85pkDU4o2asgXqJhDQLiWoFK5X9MO9A4Foh28v39gyrQ7ivaK0cU11XFw15Ug98/I3thqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738395; c=relaxed/simple;
	bh=hdBJuiKLIN616C/T5vTwGXgBnD3FMV/7wU5Gq6XVRfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iC1snLd5Vk837PdnCmbRFuruY0pNk7oXlNaMobEt59rIC0Birp0OFbxVWBiyG9TjJR2jDuTKp/RlegbU9iqwHSIu+Q2cB5BFxlmTl8aU+X/RQjbcDEMhFb3NdMsCANhAB3tcEXBUYn1PhkamVFW3nEC4LlQZ5XJFvcw1Fu3tJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWTHMxXJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738393; x=1759274393;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hdBJuiKLIN616C/T5vTwGXgBnD3FMV/7wU5Gq6XVRfE=;
  b=GWTHMxXJe7U51Vp5G+toj5JvO6AIOtOI9LnizpqzrDhY1SPZEa/+fm5x
   UhwZ8hYWC8Oiud/9ahgDZ+TrqV3LoSI6ZnWsIYb3O4ohsFMLKcqkcEHoy
   MeOM/RLY00N1W8Ti8grBjaGZ8/lnNNXSO6Y+lAKZDwZErRNI4BhgfNEUv
   gHtNSplg4+FKca9Vm29loenkz9ccoYs19SCP4FZeBsM4a05te1K3HLljz
   IDJyrhw9M+DBfuuMtckClVjod52WFOjZ+OD5FsVgw0oAjlIamp/r7zT37
   bQPbTv68SLp8II/GKew1FrS8VFffPbg/Q44g+apkd4MeRhWnu4btn6rKw
   g==;
X-CSE-ConnectionGUID: C/gtOF23Sq2zURXCMXlVfA==
X-CSE-MsgGUID: Lm9yrlEKRzS1arPizEX5VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660306"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: uYpRnzf7SgO0wyqzD/47bQ==
X-CSE-MsgGUID: l2NPIiAiTVSzBXWikdB7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356451"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:40 -0700
Subject: [PATCH net-next 07/10] lib: packing: add additional KUnit tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-7-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
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


