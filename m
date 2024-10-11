Return-Path: <netdev+bounces-134670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296099AB8D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED81283BC6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBC01D0E3E;
	Fri, 11 Oct 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ji3IRCi5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3B1D0B8F;
	Fri, 11 Oct 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672613; cv=none; b=sBShuCg0I3zdjin942+fd0x14iP+ybKDlaT2dtT/J9xziKy0jN2MsH9//1r4YSniwOKEeH7TI/kFrmJofeDORX89jrOrCyDd61emRwTXTXRCtHMAEwZMrSyZQJlEQ5lZblpXGi4xav8AlGTgAPXdCMqAkzhgi0rnfxGuAT0CmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672613; c=relaxed/simple;
	bh=UyQFKKOtVT0ufDtXzxKor5iI+GxMTP3L2mWmGAQsGag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jc4QWOmz2rQK1fUbmKRea86mpXhSgdd44++DxyjY5oBr6f+ZFylQ2Q0uIGWVQ8IWO/DLtCp5FemmE4AhAHTQjhiCOJ350+1QLSHxHs8gPNN+/cOgNFJURri9ER4atr9NkyVG3jpdGwVvlrq3YH7bNgg165fY8cCQLKAYDQsYYOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ji3IRCi5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728672612; x=1760208612;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UyQFKKOtVT0ufDtXzxKor5iI+GxMTP3L2mWmGAQsGag=;
  b=Ji3IRCi57VC4TGybLF2d2fjIbnayexxLpPi9tP9B3HIzhK3nl3dvydnQ
   /O4tFJByoAcuG388/E5gdrJ5D+iEnMkW35y7yxpz2EBf3NaaHm0cxgZ7T
   yXpZRNmlZRToKox/CZ/89FwmlMZZv0RuOlPJ3vqisboyNDv1HyuGNgHyQ
   MxVL2Zv09omlcOTjVx+mKZxO5U4o+gRDs+CdtiS2I3jTIu8ATNvG/oGAt
   LuON5SBvVv5+fIte4d1qN2bG5x+oyenVZg5ussX/N3qAvpI3FMsWtLUsI
   LV1uWMVskkeLEvcDIT1ZTGd9dCWRluYe6YFG5NFS+Wu8vYA+6QZF2tYKt
   g==;
X-CSE-ConnectionGUID: 6735XYjwRJuBrPwNelEeow==
X-CSE-MsgGUID: x8vWlaJdSi+i4OmTPUs7Hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="50626200"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="50626200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:07 -0700
X-CSE-ConnectionGUID: 3I4gIrUWQoOL87ANu0S88g==
X-CSE-MsgGUID: Y7/LzMEKQlO6iCSSs5p/BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77804146"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 11:50:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 11 Oct 2024 11:48:29 -0700
Subject: [PATCH net-next 1/8] lib: packing: create __pack() and __unpack()
 variants without error checking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-packing-pack-fields-and-ice-implementation-v1-1-d9b1f7500740@intel.com>
References: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
In-Reply-To: <20241011-packing-pack-fields-and-ice-implementation-v1-0-d9b1f7500740@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

A future variant of the API, which works on arrays of packed_field
structures, will make most of these checks redundant. The idea will be
that we want to perform sanity checks only once at boot time, not once
for every function call. So we need faster variants of pack() and
unpack(), which assume that the input was pre-sanitized.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 lib/packing.c | 142 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 78 insertions(+), 64 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 793942745e34..c29b079fdd78 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -51,64 +51,20 @@ static size_t calculate_box_addr(size_t box, size_t len, u8 quirks)
 	return offset_of_group + offset_in_group;
 }
 
-/**
- * pack - Pack u64 number into bitfield of buffer.
- *
- * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: CPU-readable unpacked value to pack.
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
-int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
-	 u8 quirks)
+static void __pack(void *pbuf, u64 uval, size_t startbit, size_t endbit,
+		   size_t pbuflen, u8 quirks)
 {
 	/* Logical byte indices corresponding to the
 	 * start and end of the field.
 	 */
-	int plogical_first_u8, plogical_last_u8, box;
-	/* width of the field to access in the pbuf */
-	u64 value_width;
-
-	/* startbit is expected to be larger than endbit, and both are
-	 * expected to be within the logically addressable range of the buffer.
-	 */
-	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
-		/* Invalid function call */
-		return -EINVAL;
-
-	value_width = startbit - endbit + 1;
-	if (unlikely(value_width > 64))
-		return -ERANGE;
-
-	/* Check if "uval" fits in "value_width" bits.
-	 * If value_width is 64, the check will fail, but any
-	 * 64-bit uval will surely fit.
-	 */
-	if (unlikely(value_width < 64 && uval >= (1ull << value_width)))
-		/* Cannot store "uval" inside "value_width" bits.
-		 * Truncating "uval" is most certainly not desirable,
-		 * so simply erroring out is appropriate.
-		 */
-		return -ERANGE;
+	int plogical_first_u8 = startbit / BITS_PER_BYTE;
+	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int box;
 
 	/* Iterate through an idealistic view of the pbuf as an u64 with
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / BITS_PER_BYTE;
-	plogical_last_u8  = endbit / BITS_PER_BYTE;
-
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
 		size_t box_start_bit, box_end_bit, box_addr;
@@ -163,15 +119,13 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		((u8 *)pbuf)[box_addr] &= ~box_mask;
 		((u8 *)pbuf)[box_addr] |= pval;
 	}
-	return 0;
 }
-EXPORT_SYMBOL(pack);
 
 /**
- * unpack - Unpack u64 number from packed buffer.
+ * pack - Pack u64 number into bitfield of buffer.
  *
  * @pbuf: Pointer to a buffer holding the packed value.
- * @uval: Pointer to an u64 holding the unpacked value.
+ * @uval: CPU-readable unpacked value to pack.
  * @startbit: The index (in logical notation, compensated for quirks) where
  *	      the packed value starts within pbuf. Must be larger than, or
  *	      equal to, endbit.
@@ -183,16 +137,12 @@ EXPORT_SYMBOL(pack);
  *	    QUIRK_MSB_ON_THE_RIGHT.
  *
  * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
- *	   correct usage, return code may be discarded. The @uval will be
- *	   modified on success.
+ *	   correct usage, return code may be discarded. The @pbuf memory will
+ *	   be modified on success.
  */
-int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
-	   size_t pbuflen, u8 quirks)
+int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
+	 u8 quirks)
 {
-	/* Logical byte indices corresponding to the
-	 * start and end of the field.
-	 */
-	int plogical_first_u8, plogical_last_u8, box;
 	/* width of the field to access in the pbuf */
 	u64 value_width;
 
@@ -207,6 +157,33 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	if (unlikely(value_width > 64))
 		return -ERANGE;
 
+	/* Check if "uval" fits in "value_width" bits.
+	 * If value_width is 64, the check will fail, but any
+	 * 64-bit uval will surely fit.
+	 */
+	if (value_width < 64 && uval >= (1ull << value_width))
+		/* Cannot store "uval" inside "value_width" bits.
+		 * Truncating "uval" is most certainly not desirable,
+		 * so simply erroring out is appropriate.
+		 */
+		return -ERANGE;
+
+	__pack(pbuf, uval, startbit, endbit, pbuflen, quirks);
+
+	return 0;
+}
+EXPORT_SYMBOL(pack);
+
+static void __unpack(const void *pbuf, u64 *uval, size_t startbit,
+		     size_t endbit, size_t pbuflen, u8 quirks)
+{
+	/* Logical byte indices corresponding to the
+	 * start and end of the field.
+	 */
+	int plogical_first_u8 = startbit / BITS_PER_BYTE;
+	int plogical_last_u8 = endbit / BITS_PER_BYTE;
+	int box;
+
 	/* Initialize parameter */
 	*uval = 0;
 
@@ -214,9 +191,6 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / BITS_PER_BYTE;
-	plogical_last_u8  = endbit / BITS_PER_BYTE;
-
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
 		size_t box_start_bit, box_end_bit, box_addr;
@@ -271,6 +245,46 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		*uval &= ~proj_mask;
 		*uval |= pval;
 	}
+}
+
+/**
+ * unpack - Unpack u64 number from packed buffer.
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
+ * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
+ *	    QUIRK_MSB_ON_THE_RIGHT.
+ *
+ * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
+ *	   correct usage, return code may be discarded. The @uval will be
+ *	   modified on success.
+ */
+int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
+	   size_t pbuflen, u8 quirks)
+{
+	/* width of the field to access in the pbuf */
+	u64 value_width;
+
+	/* startbit is expected to be larger than endbit, and both are
+	 * expected to be within the logically addressable range of the buffer.
+	 */
+	if (startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen)
+		/* Invalid function call */
+		return -EINVAL;
+
+	value_width = startbit - endbit + 1;
+	if (value_width > 64)
+		return -ERANGE;
+
+	__unpack(pbuf, uval, startbit, endbit, pbuflen, quirks);
+
 	return 0;
 }
 EXPORT_SYMBOL(unpack);

-- 
2.47.0.265.g4ca455297942


