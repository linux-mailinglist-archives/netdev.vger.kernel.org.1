Return-Path: <netdev+bounces-131374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A598E58C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44D21C21B69
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71BC199E94;
	Wed,  2 Oct 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK1xF7U5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9774519922A
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905924; cv=none; b=HYjSUTVtr0R8CbLzeQ5RrsKR7/fTWEPmDBPWT6DSwrY0+wn5LZ0H+t6nqiIlyRA0Vs0bN3htrmSQydk2OFqpariGXxkTXzoucbdY2Dw5ikB0KJL0Ej7Cp0cb4bHLFQz1BM8Ue+CkVsQ9I+kb1Y2G0bwf9UFSzonuZ1Kw8igoNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905924; c=relaxed/simple;
	bh=nNldZ3PBSsw1n3N2mzkWLCdo8piTb7qpRe1BvCvdtxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8nSN5BvPq9LPK7Zr56mWXKB7fJpZspx30Z7U5fxBvupPMHd/62inRRHemFHPygmLTy/5DMNP+sMjyGMQT7l7CZjP94dmY3IJwXzY4Ng4j15MLY+WBDLBWdr8Ob25Jog8QPsuV9tYQKNMRVxj7cScP8J2rf1qld9JI7hF2rRzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK1xF7U5; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905923; x=1759441923;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nNldZ3PBSsw1n3N2mzkWLCdo8piTb7qpRe1BvCvdtxU=;
  b=kK1xF7U5+oIwZQ+ww7TBcku+6zGHZymMG7lvi2UPd5Gm43GldAhQT/Du
   jdKe9hoDtyvJbE8jxpZbWmqySeoRbX12CzmuMov37bVEZ68Kf+HXY2z7p
   a5QY6GafB37bNJ9IESTNWR4yFYsg26mGCbstMeQsc9zc4FAWA1alG+TFn
   CpWeom7qX2NSKEXE4x0UafIaKmSZct9h1ahQJbqHoDAO5igHVLYBQpjS1
   STmth34KeTJQ7C+xwb2PMLR3u59q69DYoGYVuz1UZsCpKwULXusXaHBVZ
   O22DHhO+rKsFAU/5KOL9ibI/8RjHEr/T9/hFnGad7CmtFq1K50H47ZANz
   g==;
X-CSE-ConnectionGUID: 1m9PQz3HSiSzJ0JbxhpH2A==
X-CSE-MsgGUID: SjVkv27FS+igB8a2zQuCPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262035"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262035"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
X-CSE-ConnectionGUID: 5cmr+6XrTHWyjlTDHjl2ZA==
X-CSE-MsgGUID: RZ2ik9dpRzqwr2EZ4aqhXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673897"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:55 -0700
Subject: [PATCH net-next v2 06/10] lib: packing: add KUnit tests adapted
 from selftests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-6-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

Add 24 simple KUnit tests for the lib/packing.c pack() and unpack() APIs.

The first 16 tests exercise all combinations of quirks with a simple magic
number value on a 16-byte buffer. The remaining 8 tests cover
non-multiple-of-4 buffer sizes.

These tests were originally written by Vladimir as simple selftest
functions. I adapted them to KUnit, refactoring them into a table driven
approach. This will aid in adding additional tests in the future.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing_test.c | 258 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS        |   1 +
 lib/Kconfig        |  12 +++
 lib/Makefile       |   1 +
 4 files changed, 272 insertions(+)

diff --git a/lib/packing_test.c b/lib/packing_test.c
new file mode 100644
index 000000000000..4d07523dba29
--- /dev/null
+++ b/lib/packing_test.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Vladimir Oltean <olteanv@gmail.com>
+ * Copyright (c) 2024, Intel Corporation.
+ */
+#include <kunit/test.h>
+#include <linux/packing.h>
+
+struct packing_test_case {
+	const char *desc;
+	const u8 *pbuf;
+	size_t pbuf_size;
+	u64 uval;
+	size_t start_bit;
+	size_t end_bit;
+	u8 quirks;
+};
+
+#define NO_QUIRKS	0
+
+/**
+ * PBUF - Initialize .pbuf and .pbuf_size
+ * @array: elements of constant physical buffer
+ *
+ * Initializes the .pbuf and .pbuf_size fields of a struct packing_test_case
+ * with a constant array of the specified elements.
+ */
+#define PBUF(array...)					\
+	.pbuf = (const u8[]){ array },			\
+	.pbuf_size = sizeof((const u8 []){ array })
+
+static const struct packing_test_case cases[] = {
+	/* These tests pack and unpack a magic 64-bit value
+	 * (0xcafedeadbeefcafe) at a fixed logical offset (32) within an
+	 * otherwise zero array of 128 bits (16 bytes). They test all possible
+	 * bit layouts of the 128 bit buffer.
+	 */
+	{
+		.desc = "no quirks, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xca, 0xfe, 0xde, 0xad,
+		     0xbe, 0xef, 0xca, 0xfe, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "lsw32 first, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xbe, 0xef, 0xca, 0xfe,
+		     0xca, 0xfe, 0xde, 0xad, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "little endian words, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xad, 0xde, 0xfe, 0xca,
+		     0xfe, 0xca, 0xef, 0xbe, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "msb right, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x53, 0x7f, 0x7b, 0xb5,
+		     0x7d, 0xf7, 0x53, 0x7f, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT,
+	},
+	{
+		.desc = "msb right + lsw32 first, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x7d, 0xf7, 0x53, 0x7f,
+		     0x53, 0x7f, 0x7b, 0xb5, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "msb right + little endian words, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xb5, 0x7b, 0x7f, 0x53,
+		     0x7f, 0x53, 0xf7, 0x7d, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "msb right + lsw32 first + little endian words, 16 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x7f, 0x53, 0xf7, 0x7d,
+		     0xb5, 0x7b, 0x7f, 0x53, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	/* These tests pack and unpack a magic 64-bit value
+	 * (0xcafedeadbeefcafe) at a fixed logical offset (32) within an
+	 * otherwise zero array of varying size from 18 bytes to 24 bytes.
+	 */
+	{
+		.desc = "no quirks, 18 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xca, 0xfe,
+		     0xde, 0xad, 0xbe, 0xef, 0xca, 0xfe, 0x00, 0x00,
+		     0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "no quirks, 19 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xca,
+		     0xfe, 0xde, 0xad, 0xbe, 0xef, 0xca, 0xfe, 0x00,
+		     0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "no quirks, 20 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		     0xca, 0xfe, 0xde, 0xad, 0xbe, 0xef, 0xca, 0xfe,
+		     0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "no quirks, 22 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0xca, 0xfe, 0xde, 0xad, 0xbe, 0xef,
+		     0xca, 0xfe, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "no quirks, 24 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0x00, 0x00, 0xca, 0xfe, 0xde, 0xad,
+		     0xbe, 0xef, 0xca, 0xfe, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = NO_QUIRKS,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 18 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 19 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 20 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 22 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "lsw32 first + little endian words, 24 bytes",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xfe, 0xca, 0xef, 0xbe,
+		     0xad, 0xde, 0xfe, 0xca, 0x00, 0x00, 0x00, 0x00,
+		     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xcafedeadbeefcafe,
+		.start_bit = 95,
+		.end_bit = 32,
+		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
+};
+
+KUNIT_ARRAY_PARAM_DESC(packing, cases, desc);
+
+static void packing_test_pack(struct kunit *test)
+{
+	const struct packing_test_case *params = test->param_value;
+	u8 *pbuf;
+	int err;
+
+	pbuf = kunit_kzalloc(test, params->pbuf_size, GFP_KERNEL);
+
+	err = pack(pbuf, params->uval, params->start_bit, params->end_bit,
+		   params->pbuf_size, params->quirks);
+
+	KUNIT_EXPECT_EQ_MSG(test, err, 0, "pack() returned %pe\n", ERR_PTR(err));
+	KUNIT_EXPECT_MEMEQ(test, pbuf, params->pbuf, params->pbuf_size);
+}
+
+static void packing_test_unpack(struct kunit *test)
+{
+	const struct packing_test_case *params = test->param_value;
+	u64 uval;
+	int err;
+
+	err = unpack(params->pbuf, &uval, params->start_bit, params->end_bit,
+		     params->pbuf_size, params->quirks);
+	KUNIT_EXPECT_EQ_MSG(test, err, 0, "unpack() returned %pe\n", ERR_PTR(err));
+	KUNIT_EXPECT_EQ(test, uval, params->uval);
+}
+
+static struct kunit_case packing_test_cases[] = {
+	KUNIT_CASE_PARAM(packing_test_pack, packing_gen_params),
+	KUNIT_CASE_PARAM(packing_test_unpack, packing_gen_params),
+	{},
+};
+
+static struct kunit_suite packing_test_suite = {
+	.name = "packing",
+	.test_cases = packing_test_cases,
+};
+
+kunit_test_suite(packing_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for packing library");
diff --git a/MAINTAINERS b/MAINTAINERS
index e71d066dc919..fc26816d8b7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17468,6 +17468,7 @@ S:	Supported
 F:	Documentation/core-api/packing.rst
 F:	include/linux/packing.h
 F:	lib/packing.c
+F:	lib/packing_test.c
 
 PADATA PARALLEL EXECUTION MECHANISM
 M:	Steffen Klassert <steffen.klassert@secunet.com>
diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..50d85f38b569 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -40,6 +40,18 @@ config PACKING
 
 	  When in doubt, say N.
 
+config PACKING_KUNIT_TEST
+	tristate "KUnit tests for packing library" if !KUNIT_ALL_TESTS
+	depends on PACKING && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This builds KUnit tests for the packing library.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  When in doubt, say N.
+
 config BITREVERSE
 	tristate
 
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..811ba12c8cd0 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_LINEAR_RANGES) += linear_ranges.o
 obj-$(CONFIG_PACKING)	+= packing.o
+obj-$(CONFIG_PACKING_KUNIT_TEST) += packing_test.o
 obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC_T10DIF)+= crc-t10dif.o

-- 
2.46.2.828.g9e56e24342b6


