Return-Path: <netdev+bounces-130669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2614098B0BD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AC61C20E38
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5557E1A2548;
	Mon, 30 Sep 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeGTefV1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54624199259
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738399; cv=none; b=ah7SMXZ0Hz74bgLNwK2po5F5U5LY2/Uu8yLAqFk/KlPsYfdkojIMBWbcqsqEDaBi5RbpYW+AolWcxcYN+hEQSRBAICXBWXzXYBfULlqyqKsB2v+JZOI0/qt+Bkut1dLmbtnfrAzFDY1mYn3LQ93idMVxG8GQoZ2WMyQI/UzOHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738399; c=relaxed/simple;
	bh=hYU4xYFEaBh+o6d1nrrHKFfF3SSPw+Z/DuSMBhflIj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utgELx34cCs39c8qV1JCKIBTD1Z4y0Iv5rDgn+qwxT2u8OzfR6FgXzv8w6wvUuIrCfBSWE9bOSnOV9C0D6bMcu0KQVRUNxoYfKdpmQ5TO07ieNEBTBBmUXcqECyVPyG3SCtjP1wpIUnD8uJoFNctBNCtc/2cVyxaBv7nKJavpB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeGTefV1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738398; x=1759274398;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hYU4xYFEaBh+o6d1nrrHKFfF3SSPw+Z/DuSMBhflIj0=;
  b=SeGTefV1u+y2qdQkaGgfwc68V3ZWbV4o3oT7tZp2DKNN5UeBbgdPwnVz
   AzOuZYtjVy0aCPM+KWANlX7/lyfZDN9sWdWbZW8x2LsTwQ+rAEW+WGTgY
   wgAAor7mhzSwOd01tW+XbdY+KOkQ5hm9+7i+mtSGjpMuB77OhHyLRt5KB
   DfQB6DvewIlIJTapU1rlFVeOt6tfjZ2/xGZEM/fz1q+dLkh6S+odoNmv/
   FBNmJE9w9voOCZjOWDigyreASs3okQDs8nykxYhf1R5CjY5hL+hepADQj
   anDNNVman+aG1ydmsnQJqOJiTVaeuHZ149BVrcG5BTA6NmuJShTyStrq0
   A==;
X-CSE-ConnectionGUID: IaD+ht2gRoKz1yR612Hriw==
X-CSE-MsgGUID: YZh9cITtQTWGxKgpXolwQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660335"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660335"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: tDn1Yy5sSGuLGPdcg/Vuag==
X-CSE-MsgGUID: JP01V3okRuS7tHczNDe9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356445"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:38 -0700
Subject: [PATCH net-next 05/10] lib: packing: duplicate pack() and unpack()
 implementations
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-5-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

packing() is now used in some hot paths, and it would be good to get rid
of some ifs and buts that depend on "op", to speed things up a little bit.

With the main implementations now taking size_t endbit, we no longer
have to check for negative values. Update the local integer variables to
also be size_t to match.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/packing.h |   4 +-
 lib/packing.c           | 243 ++++++++++++++++++++++++++++++------------------
 2 files changed, 154 insertions(+), 93 deletions(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index ea25cb93cc70..5d36dcd06f60 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -20,8 +20,8 @@ enum packing_op {
 int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	    enum packing_op op, u8 quirks);
 
-int pack(void *pbuf, const u64 *uval, size_t startbit, size_t endbit,
-	 size_t pbuflen, u8 quirks);
+int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
+	 u8 quirks);
 
 int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	   size_t pbuflen, u8 quirks);
diff --git a/lib/packing.c b/lib/packing.c
index 2922db8a528c..500184530d07 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -9,11 +9,11 @@
 #include <linux/types.h>
 #include <linux/bitrev.h>
 
-static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
-				       int *box_end_bit, u8 *box_mask)
+static void adjust_for_msb_right_quirk(u64 *to_write, size_t *box_start_bit,
+				       size_t *box_end_bit, u8 *box_mask)
 {
-	int box_bit_width = *box_start_bit - *box_end_bit + 1;
-	int new_box_start_bit, new_box_end_bit;
+	size_t box_bit_width = *box_start_bit - *box_end_bit + 1;
+	size_t new_box_start_bit, new_box_end_bit;
 
 	*to_write >>= *box_end_bit;
 	*to_write = bitrev8(*to_write) >> (8 - box_bit_width);
@@ -48,7 +48,7 @@ static void adjust_for_msb_right_quirk(u64 *to_write, int *box_start_bit,
  *
  * Return: the physical offset into the buffer corresponding to the logical box.
  */
-static int calculate_box_addr(int box, size_t len, u8 quirks)
+static size_t calculate_box_addr(size_t box, size_t len, u8 quirks)
 {
 	size_t offset_of_group, offset_in_group, this_group = box / 4;
 	size_t group_size;
@@ -69,13 +69,10 @@ static int calculate_box_addr(int box, size_t len, u8 quirks)
 }
 
 /**
- * packing - Convert numbers (currently u64) between a packed and an unpacked
- *	     format. Unpacked means laid out in memory in the CPU's native
- *	     understanding of integers, while packed means anything else that
- *	     requires translation.
+ * pack - Pack u64 number into bitfield of buffer.
  *
  * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
+ * @uval: CPU-readable unpacked value to pack.
  * @startbit: The index (in logical notation, compensated for quirks) where
  *	      the packed value starts within pbuf. Must be larger than, or
  *	      equal to, endbit.
@@ -83,58 +80,45 @@ static int calculate_box_addr(int box, size_t len, u8 quirks)
  *	    the packed value ends within pbuf. Must be smaller than, or equal
  *	    to, startbit.
  * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
- * @op: If PACK, then uval will be treated as const pointer and copied (packed)
- *	into pbuf, between startbit and endbit.
- *	If UNPACK, then pbuf will be treated as const pointer and the logical
- *	value between startbit and endbit will be copied (unpacked) to uval.
  * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
  *	    QUIRK_MSB_ON_THE_RIGHT.
  *
- * Note: this is deprecated, prefer to use pack() or unpack() in new code.
- *
  * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded.
- *	   If op is PACK, pbuf is modified.
- *	   If op is UNPACK, uval is modified.
+ *	   correct usage, return code may be discarded. The @pbuf memory will
+ *	   be modified on success.
  */
-int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
-	    enum packing_op op, u8 quirks)
+int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
+	 u8 quirks)
 {
-	/* Number of bits for storing "uval"
-	 * also width of the field to access in the pbuf
-	 */
-	u64 value_width;
 	/* Logical byte indices corresponding to the
 	 * start and end of the field.
 	 */
 	int plogical_first_u8, plogical_last_u8, box;
+	/* width of the field to access in the pbuf */
+	u64 value_width;
 
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
-	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen || endbit < 0))
+	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
 		/* Invalid function call */
 		return -EINVAL;
 
 	value_width = startbit - endbit + 1;
-	if (value_width > 64)
+	if (unlikely(value_width > 64))
 		return -ERANGE;
 
 	/* Check if "uval" fits in "value_width" bits.
 	 * If value_width is 64, the check will fail, but any
 	 * 64-bit uval will surely fit.
 	 */
-	if (op == PACK && value_width < 64 && (*uval >= (1ull << value_width)))
+	if (unlikely(value_width < 64 && uval >= (1ull << value_width)))
 		/* Cannot store "uval" inside "value_width" bits.
 		 * Truncating "uval" is most certainly not desirable,
 		 * so simply erroring out is appropriate.
 		 */
 		return -ERANGE;
 
-	/* Initialize parameter */
-	if (op == UNPACK)
-		*uval = 0;
-
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
@@ -144,11 +128,12 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
-		int box_start_bit, box_end_bit, box_addr;
+		size_t box_start_bit, box_end_bit, box_addr;
 		u8  box_mask;
 		/* Corresponding bits from the unpacked u64 parameter */
-		int proj_start_bit, proj_end_bit;
+		size_t proj_start_bit, proj_end_bit;
 		u64 proj_mask;
+		u64 pval;
 
 		/* This u8 may need to be accessed in its entirety
 		 * (from bit 7 to bit 0), or not, depending on the
@@ -182,66 +167,21 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 		 */
 		box_addr = calculate_box_addr(box, pbuflen, quirks);
 
-		if (op == UNPACK) {
-			u64 pval;
+		/* Write to pbuf, read from uval */
+		pval = uval & proj_mask;
+		pval >>= proj_end_bit;
+		if (quirks & QUIRK_MSB_ON_THE_RIGHT)
+			adjust_for_msb_right_quirk(&pval,
+						   &box_start_bit,
+						   &box_end_bit,
+						   &box_mask);
 
-			/* Read from pbuf, write to uval */
-			pval = ((u8 *)pbuf)[box_addr] & box_mask;
-			if (quirks & QUIRK_MSB_ON_THE_RIGHT)
-				adjust_for_msb_right_quirk(&pval,
-							   &box_start_bit,
-							   &box_end_bit,
-							   &box_mask);
-
-			pval >>= box_end_bit;
-			pval <<= proj_end_bit;
-			*uval &= ~proj_mask;
-			*uval |= pval;
-		} else {
-			u64 pval;
-
-			/* Write to pbuf, read from uval */
-			pval = (*uval) & proj_mask;
-			pval >>= proj_end_bit;
-			if (quirks & QUIRK_MSB_ON_THE_RIGHT)
-				adjust_for_msb_right_quirk(&pval,
-							   &box_start_bit,
-							   &box_end_bit,
-							   &box_mask);
-
-			pval <<= box_end_bit;
-			((u8 *)pbuf)[box_addr] &= ~box_mask;
-			((u8 *)pbuf)[box_addr] |= pval;
-		}
+		pval <<= box_end_bit;
+		((u8 *)pbuf)[box_addr] &= ~box_mask;
+		((u8 *)pbuf)[box_addr] |= pval;
 	}
 	return 0;
 }
-EXPORT_SYMBOL(packing);
-
-/**
- * pack - Pack u64 number into bitfield of buffer.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
- * @startbit: The index (in logical notation, compensated for quirks) where
- *	      the packed value starts within pbuf. Must be larger than, or
- *	      equal to, endbit.
- * @endbit: The index (in logical notation, compensated for quirks) where
- *	    the packed value ends within pbuf. Must be smaller than, or equal
- *	    to, startbit.
- * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
- * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
- *	    QUIRK_MSB_ON_THE_RIGHT.
- *
- * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded. The @pbuf memory will
- *	   be modified on success.
- */
-int pack(void *pbuf, const u64 *uval, size_t startbit, size_t endbit,
-	 size_t pbuflen, u8 quirks)
-{
-	return packing(pbuf, (u64 *)uval, startbit, endbit, pbuflen, PACK, quirks);
-}
 EXPORT_SYMBOL(pack);
 
 /**
@@ -266,8 +206,129 @@ EXPORT_SYMBOL(pack);
 int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	   size_t pbuflen, u8 quirks)
 {
-	return packing((void *)pbuf, uval, startbit, endbit, pbuflen, UNPACK, quirks);
+	/* Logical byte indices corresponding to the
+	 * start and end of the field.
+	 */
+	int plogical_first_u8, plogical_last_u8, box;
+	/* width of the field to access in the pbuf */
+	u64 value_width;
+
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
+		/* Invalid function call */
+		return -EINVAL;
+
+	value_width = startbit - endbit + 1;
+	if (unlikely(value_width > 64))
+		return -ERANGE;
+
+	/* Initialize parameter */
+	*uval = 0;
+
+	/* Iterate through an idealistic view of the pbuf as an u64 with
+	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
+	 * logical bit significance. "box" denotes the current logical u8.
+	 */
+	plogical_first_u8 = startbit / 8;
+	plogical_last_u8  = endbit / 8;
+
+	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
+		/* Bit indices into the currently accessed 8-bit box */
+		size_t box_start_bit, box_end_bit, box_addr;
+		u8  box_mask;
+		/* Corresponding bits from the unpacked u64 parameter */
+		size_t proj_start_bit, proj_end_bit;
+		u64 proj_mask;
+		u64 pval;
+
+		/* This u8 may need to be accessed in its entirety
+		 * (from bit 7 to bit 0), or not, depending on the
+		 * input arguments startbit and endbit.
+		 */
+		if (box == plogical_first_u8)
+			box_start_bit = startbit % 8;
+		else
+			box_start_bit = 7;
+		if (box == plogical_last_u8)
+			box_end_bit = endbit % 8;
+		else
+			box_end_bit = 0;
+
+		/* We have determined the box bit start and end.
+		 * Now we calculate where this (masked) u8 box would fit
+		 * in the unpacked (CPU-readable) u64 - the u8 box's
+		 * projection onto the unpacked u64. Though the
+		 * box is u8, the projection is u64 because it may fall
+		 * anywhere within the unpacked u64.
+		 */
+		proj_start_bit = ((box * 8) + box_start_bit) - endbit;
+		proj_end_bit   = ((box * 8) + box_end_bit) - endbit;
+		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
+		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
+
+		/* Determine the offset of the u8 box inside the pbuf,
+		 * adjusted for quirks. The adjusted box_addr will be used for
+		 * effective addressing inside the pbuf (so it's not
+		 * logical any longer).
+		 */
+		box_addr = calculate_box_addr(box, pbuflen, quirks);
+
+		/* Read from pbuf, write to uval */
+		pval = ((u8 *)pbuf)[box_addr] & box_mask;
+		if (quirks & QUIRK_MSB_ON_THE_RIGHT)
+			adjust_for_msb_right_quirk(&pval,
+						   &box_start_bit,
+						   &box_end_bit,
+						   &box_mask);
+
+		pval >>= box_end_bit;
+		pval <<= proj_end_bit;
+		*uval &= ~proj_mask;
+		*uval |= pval;
+	}
+	return 0;
 }
 EXPORT_SYMBOL(unpack);
 
+/**
+ * packing - Convert numbers (currently u64) between a packed and an unpacked
+ *	     format. Unpacked means laid out in memory in the CPU's native
+ *	     understanding of integers, while packed means anything else that
+ *	     requires translation.
+ *
+ * @pbuf: Pointer to a buffer holding the packed value.
+ * @uval: Pointer to an u64 holding the unpacked value.
+ * @startbit: The index (in logical notation, compensated for quirks) where
+ *	      the packed value starts within pbuf. Must be larger than, or
+ *	      equal to, endbit.
+ * @endbit: The index (in logical notation, compensated for quirks) where
+ *	    the packed value ends within pbuf. Must be smaller than, or equal
+ *	    to, startbit.
+ * @pbuflen: The length in bytes of the packed buffer pointed to by @pbuf.
+ * @op: If PACK, then uval will be treated as const pointer and copied (packed)
+ *	into pbuf, between startbit and endbit.
+ *	If UNPACK, then pbuf will be treated as const pointer and the logical
+ *	value between startbit and endbit will be copied (unpacked) to uval.
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Note: this is deprecated, prefer to use pack() or unpack() in new code.
+ *
+ * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
+ *	   correct usage, return code may be discarded.
+ *	   If op is PACK, pbuf is modified.
+ *	   If op is UNPACK, uval is modified.
+ */
+int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
+	    enum packing_op op, u8 quirks)
+{
+	if (op == PACK)
+		return pack(pbuf, *uval, startbit, endbit, pbuflen, quirks);
+
+	return unpack(pbuf, uval, startbit, endbit, pbuflen, quirks);
+}
+EXPORT_SYMBOL(packing);
+
 MODULE_DESCRIPTION("Generic bitfield packing and unpacking");

-- 
2.46.2.828.g9e56e24342b6


