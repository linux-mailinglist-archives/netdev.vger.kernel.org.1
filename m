Return-Path: <netdev+bounces-130662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B2198B0B7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B061F232FA
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE61898E6;
	Mon, 30 Sep 2024 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgqE4K0Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BED188A3E
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738395; cv=none; b=dbrWatRgu+ZuaIzupV4XslI5nOT+dsvf30K6JXiVnxuNp1VKTc/W6wmftrEfPuLk3AhtPNh1tEYRSedDMcOZ/t+Avsodd0n72FD6dgaJx7S40+NBxeNGoLYlKBa9EidDjp+7wYwwA8KjQJDUWhwE1SrSfWutB4gUt0ZsmF+HV9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738395; c=relaxed/simple;
	bh=zlSorJ/bxU/YmU57zVfM7YPMYpmw53i8JpB+Yfb/b1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBe/UE6yfvICHO3L3t7Xb7LyQpr7RSVXGirdO+5y3eLlEAdtB7KHCSqLSAzSJOXv28Ce56dDCoFNp2CCG4/a7ZFhqGcGDCQdATJX3mnmYC1rerXuK+HGY9oR0QD6pTTaVfM9ibFlywjlMXQbBj0aKtrdUbcH1+ntJ9c5iFOQ/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgqE4K0Z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738394; x=1759274394;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zlSorJ/bxU/YmU57zVfM7YPMYpmw53i8JpB+Yfb/b1c=;
  b=GgqE4K0ZQCL+qEQEI5XqHmEFq6V0nesFq5N7Xn0ewooItaUNeguHsl9j
   1JlwyaYhbY8V9no+wsAgOMQ67sdlnpnwCmA9WMry7t9LJaHwz4GbyjISG
   hCz3vUE1yHcNOFCcH5WEsN/Bsl5xZg93l+cFzuufKdirvaQG3fYFRRUXZ
   t9ngNPfe/bu1NOolmhqhmK5Pko4uARyM1JAiRgnixX1WqmcBeV7hD3L4i
   0MisAWBrxDxQ39d84GsI/5osbJiK2gpkcDzoBWVPJ8oBl/e6MuSCwyd6C
   WN73dgKAjWFMy7FZQJ0XVU9Nt892O7ANDHRm0FRqexdNMjGAEsX0Z6+La
   A==;
X-CSE-ConnectionGUID: NIDf3PSSQISKAChXauyZCA==
X-CSE-MsgGUID: 8hQ8gYxqQsmnJkjf3zOtQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660311"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660311"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: rcVml4LRQtKH1Te9f/o4BQ==
X-CSE-MsgGUID: OvCPiAf0SR+zwoWUE1LoAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356454"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:41 -0700
Subject: [PATCH net-next 08/10] lib: packing: fix QUIRK_MSB_ON_THE_RIGHT
 behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-8-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

The QUIRK_MSB_ON_THE_RIGHT quirk is intended to modify pack() and unpack()
so that the most significant bit of each byte in the packed layout is on
the right.

The way the quirk is currently implemented is broken whenever the packing
code packs or unpacks any value that is not exactly a full byte.

The broken behavior can occur when packing any values smaller than one
byte, when packing any value that is not exactly a whole number of bytes,
or when the packing is not aligned to a byte boundary.

This quirk is documented in the following way:

  1. Normally (no quirks), we would do it like this:

  ::

    63 62 61 60 59 58 57 56 55 54 53 52 51 50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32
    7                       6                       5                        4
    31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
    3                       2                       1                        0

  <snip>

  2. If QUIRK_MSB_ON_THE_RIGHT is set, we do it like this:

  ::

    56 57 58 59 60 61 62 63 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47 32 33 34 35 36 37 38 39
    7                       6                        5                       4
    24 25 26 27 28 29 30 31 16 17 18 19 20 21 22 23  8  9 10 11 12 13 14 15  0  1  2  3  4  5  6  7
    3                       2                        1                       0

  That is, QUIRK_MSB_ON_THE_RIGHT does not affect byte positioning, but
  inverts bit offsets inside a byte.

Essentially, the mapping for physical bit offsets should be reserved for a
given byte within the payload. This reversal should be fixed to the bytes
in the packing layout.

The logic to implement this quirk is handled within the
adjust_for_msb_right_quirk() function. This function does not work properly
when dealing with the bytes that contain only a partial amount of data.

In particular, consider trying to pack or unpack the range 53-44. We should
always be mapping the bits from the logical ordering to their physical
ordering in the same way, regardless of what sequence of bits we are
unpacking.

This, we should grab the following logical bits:

  Logical: 55 54 53 52 51 50 49 48 47 45 44 43 42 41 40 39
                  ^  ^  ^  ^  ^  ^  ^  ^  ^

And pack them into the physical bits:

   Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
    Logical: 48 49 50 51 52 53                   44 45 46 47
              ^  ^  ^  ^  ^  ^                    ^  ^  ^  ^

The current logic in adjust_for_msb_right_quirk is broken. I believe it is
intending to map according to the following:

  Physical: 48 49 50 51 52 53 54 55 40 41 42 43 44 45 46 47
   Logical:       48 49 50 51 52 53 44 45 46 47
                   ^  ^  ^  ^  ^  ^  ^  ^  ^  ^

That is, it tries to keep the bits at the start and end of a packing
together. This is wrong, as it makes the packing change what bit is being
mapped to what based on which bits you're currently packing or unpacking.

Worse, the actual calculations within adjust_for_msb_right_quirk don't make
sense.

Consider the case when packing the last byte of an unaligned packing. It
might have a start bit of 7 and an end bit of 5. This would have a width of
3 bits. The new_start_bit will be calculated as the width - the box_end_bit
- 1. This will underflow and produce a negative value, which will
ultimate result in generating a new box_mask of all 0s.

For any other values, the result of the calculations of the
new_box_end_bit, new_box_start_bit, and the new box_mask will result in the
exact same values for the box_end_bit, box_start_bit, and box_mask. This
makes the calculations completely irrelevant.

If box_end_bit is 0, and box_start_bit is 7, then the entire function of
adjust_for_msb_right_quirk will boil down to just:

    *to_write = bitrev8(*to_write)

The other adjustments are attempting (incorrectly) to keep the bits in the
same place but just reversed. This is not the right behavior even if
implemented correctly, as it leaves the mapping dependent on the bit values
being packed or unpacked.

Remove adjust_for_msb_right_quirk() and just use bitrev8 to reverse the
byte order when interacting with the packed data.

In particular, for packing, we need to reverse both the box_mask and the
physical value being packed. This is done after shifting the value by
box_end_bit so that the reversed mapping is always aligned to the physical
buffer byte boundary. The box_mask is reversed as we're about to use it to
clear any stale bits in the physical buffer at this block.

For unpacking, we need to reverse the contents of the physical buffer
*before* masking with the box_mask. This is critical, as the box_mask is a
logical mask of the bit layout before handling the QUIRK_MSB_ON_THE_RIGHT.

Add several new tests which cover this behavior. These tests will fail
without the fix and pass afterwards. Note that no current drivers make use
of QUIRK_MSB_ON_THE_RIGHT. I suspect this is why there have been no reports
of this inconsistency before.

Fixes: 554aae35007e ("lib: Add support for generic packing operations")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 lib/packing.c      | 39 +++++++++--------------------
 lib/packing_test.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 500184530d07..9efe57d347c7 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -9,23 +9,6 @@
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
-static void adjust_for_msb_right_quirk(u64 *to_write, size_t *box_start_bit,
-				       size_t *box_end_bit, u8 *box_mask)
-{
-	size_t box_bit_width = *box_start_bit - *box_end_bit + 1;
-	size_t new_box_start_bit, new_box_end_bit;
-
-	*to_write >>= *box_end_bit;
-	*to_write = bitrev8(*to_write) >> (8 - box_bit_width);
-	*to_write <<= *box_end_bit;
-
-	new_box_end_bit   = box_bit_width - *box_start_bit - 1;
-	new_box_start_bit = box_bit_width - *box_end_bit - 1;
-	*box_mask = GENMASK_ULL(new_box_start_bit, new_box_end_bit);
-	*box_start_bit = new_box_start_bit;
-	*box_end_bit   = new_box_end_bit;
-}
-
 /**
  * calculate_box_addr - Determine physical location of byte in buffer
  * @box: Index of byte within buffer seen as a logical big-endian big number
@@ -170,13 +153,13 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		/* Write to pbuf, read from uval */
 		pval = uval & proj_mask;
 		pval >>= proj_end_bit;
-		if (quirks & QUIRK_MSB_ON_THE_RIGHT)
-			adjust_for_msb_right_quirk(&pval,
-						   &box_start_bit,
-						   &box_end_bit,
-						   &box_mask);
-
 		pval <<= box_end_bit;
+
+		if (quirks & QUIRK_MSB_ON_THE_RIGHT) {
+			pval = bitrev8(pval);
+			box_mask = bitrev8(box_mask);
+		}
+
 		((u8 *)pbuf)[box_addr] &= ~box_mask;
 		((u8 *)pbuf)[box_addr] |= pval;
 	}
@@ -276,12 +259,12 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		box_addr = calculate_box_addr(box, pbuflen, quirks);
 
 		/* Read from pbuf, write to uval */
-		pval = ((u8 *)pbuf)[box_addr] & box_mask;
+		pval = ((u8 *)pbuf)[box_addr];
+
 		if (quirks & QUIRK_MSB_ON_THE_RIGHT)
-			adjust_for_msb_right_quirk(&pval,
-						   &box_start_bit,
-						   &box_end_bit,
-						   &box_mask);
+			pval = bitrev8(pval);
+
+		pval &= box_mask;
 
 		pval >>= box_end_bit;
 		pval <<= proj_end_bit;
diff --git a/lib/packing_test.c b/lib/packing_test.c
index 5d533e633e06..015ad1180d23 100644
--- a/lib/packing_test.c
+++ b/lib/packing_test.c
@@ -251,6 +251,42 @@ static const struct packing_test_case cases[] = {
 		.end_bit = 43,
 		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
 	},
+	{
+		.desc = "msb right, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x91, 0x88, 0x59, 0x44, 0xd5,
+		     0xcc, 0x3d, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT,
+	},
+	{
+		.desc = "msb right + lsw32 first, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xcc, 0x3d, 0x02, 0x00,
+		     0x88, 0x59, 0x44, 0xd5, 0x00, 0x00, 0x00, 0x91),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "msb right + little endian words, 16 bytes, non-aligned",
+		PBUF(0x91, 0x00, 0x00, 0x00, 0xd5, 0x44, 0x59, 0x88,
+		     0x00, 0x02, 0x3d, 0xcc, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "msb right + lsw32 first + little endian words, 16 bytes, non-aligned",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x3d, 0xcc,
+		     0xd5, 0x44, 0x59, 0x88, 0x91, 0x00, 0x00, 0x00),
+		.uval = 0x1122334455667788,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
 	/* These tests pack and unpack a u64 with all bits set
 	 * (0xffffffffffffffff) at an odd starting bit (43) within an
 	 * otherwise zero array of 128 bits (16 bytes). They test all possible
@@ -292,6 +328,42 @@ static const struct packing_test_case cases[] = {
 		.end_bit = 43,
 		.quirks = QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
 	},
+	{
+		.desc = "msb right, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0xe0, 0xff, 0xff, 0xff, 0xff, 0xff,
+		     0xff, 0xff, 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT,
+	},
+	{
+		.desc = "msb right + lsw32 first, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x1f, 0x00,
+		     0xff, 0xff, 0xff, 0xff, 0x00, 0x00, 0xe0, 0xff),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST,
+	},
+	{
+		.desc = "msb right + little endian words, 16 bytes, non-aligned, 0xff",
+		PBUF(0xff, 0xe0, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+		     0x00, 0x1f, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LITTLE_ENDIAN,
+	},
+	{
+		.desc = "msb right + lsw32 first + little endian words, 16 bytes, non-aligned, 0xff",
+		PBUF(0x00, 0x00, 0x00, 0x00, 0x00, 0x1f, 0xff, 0xff,
+		     0xff, 0xff, 0xff, 0xff, 0xff, 0xe0, 0x00, 0x00),
+		.uval = 0xffffffffffffffff,
+		.start_bit = 106,
+		.end_bit = 43,
+		.quirks = QUIRK_MSB_ON_THE_RIGHT | QUIRK_LSW32_IS_FIRST | QUIRK_LITTLE_ENDIAN,
+	},
 };
 
 KUNIT_ARRAY_PARAM_DESC(packing, cases, desc);

-- 
2.46.2.828.g9e56e24342b6


