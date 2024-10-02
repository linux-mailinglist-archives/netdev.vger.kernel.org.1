Return-Path: <netdev+bounces-131375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3398E58D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8851F1F21AB8
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42B199FB2;
	Wed,  2 Oct 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lLW0pvGB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D719939D
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905925; cv=none; b=khZzuKmnKu/9INg9EJwRE0iODKacbl/7Bj7tOaFY59ifceMoasIRu2abAfoW1AKl1OQinSSAGLgwB6m0O+EIBaCAftywN5a7fr0/7opf8ul6gDnXpmj69wnAvk8qn6HRhXheH1POVDlTSOY6SZ+lcI/tdQ1YHO6VAzSTUquOuv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905925; c=relaxed/simple;
	bh=1Qpf0qgaxO9Yv+iQZ9nD95veF96ldy8mXi9KnLT1ff0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eol/+D1p7H/kRrB3McOhK0dNBc6q2hEroVHxpqbHCgYFBXo71FEJB4aJMBsen4UcSPDVeqK2c8RZTRe0Yu27AdKBezAryNsjeQbc1J0+eYGHaI0qrqMhMPClmwC2o8RDGk4AZ1fdYDgZWKoBQCRpkvYA2G79ObqA2dXzSpSRixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lLW0pvGB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727905923; x=1759441923;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1Qpf0qgaxO9Yv+iQZ9nD95veF96ldy8mXi9KnLT1ff0=;
  b=lLW0pvGB166Lpb4BhnMnwqqpxlXwg74IhM6kYf7rZysP7L9T8+AiT1PX
   7ID4kPhB9uk457c4/WmaRNcj/jLGOpxMd+6eIqeY+4EAVJiDzLXeeDwAF
   T2BXocC4dHV2ugkBxo97ARa3og1OWLqp7l9YDB3SX8nbIHj7AgAziIqcQ
   WuNkE14BTtTsBF430j/f3+88sSPrJDKzAApTcMMyq+dg4biDQlYoCyd8r
   r03/AWINNGPGxg2o+dOjjGvD3EN+Yogk2/ZSm4N7DLoWueZz0XNMoXpD/
   f+GUjlBcVonOUc3VNAZ0vN93UPFzhDEqfi2OKapVGRYuMyeyj3DwcJtGH
   Q==;
X-CSE-ConnectionGUID: j1JS7YbpQjGE6s/jSmmxxw==
X-CSE-MsgGUID: 92mQC+3RSPKnq4Qiqe6t7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="27262030"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="27262030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:52:00 -0700
X-CSE-ConnectionGUID: 0GYu5L5IRzaRh5KPs7crRw==
X-CSE-MsgGUID: A2N6GWYhSPSKBs8sEGfJbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78673891"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 14:51:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 02 Oct 2024 14:51:53 -0700
Subject: [PATCH net-next v2 04/10] lib: packing: add pack() and unpack()
 wrappers over packing()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-4-8373e551eae3@intel.com>
References: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
In-Reply-To: <20241002-packing-kunit-tests-and-split-pack-unpack-v2-0-8373e551eae3@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Geert Uytterhoeven described packing() as "really bad API" because of
not being able to enforce const correctness. The same function is used
both when "pbuf" is input and "uval" is output, as in the other way
around.

Create 2 wrapper functions where const correctness can be ensured.
Do ugly type casts inside, to be able to reuse packing() as currently
implemented - which will _not_ modify the input argument.

Also, take the opportunity to change the type of startbit and endbit to
size_t - an unsigned type - in these new function prototypes. When int,
an extra check for negative values is necessary. Hopefully, when
packing() goes away completely, that check can be dropped.

My concern is that code which does rely on the conditional directionality
of packing() is harder to refactor without blowing up in size. So it may
take a while to completely eliminate packing(). But let's make alternatives
available for those who do not need that.

Link: https://lore.kernel.org/netdev/20210223112003.2223332-1-geert+renesas@glider.be/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/packing.h |  6 ++++++
 lib/packing.c           | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 69baefebcd02..ea25cb93cc70 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -20,4 +20,10 @@ enum packing_op {
 int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 	    enum packing_op op, u8 quirks);
 
+int pack(void *pbuf, const u64 *uval, size_t startbit, size_t endbit,
+	 size_t pbuflen, u8 quirks);
+
+int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
+	   size_t pbuflen, u8 quirks);
+
 #endif
diff --git a/lib/packing.c b/lib/packing.c
index 435236a914fe..2922db8a528c 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -90,6 +90,8 @@ static int calculate_box_addr(int box, size_t len, u8 quirks)
  * @quirks: A bit mask of QUIRK_LITTLE_ENDIAN, QUIRK_LSW32_IS_FIRST and
  *	    QUIRK_MSB_ON_THE_RIGHT.
  *
+ * Note: this is deprecated, prefer to use pack() or unpack() in new code.
+ *
  * Return: 0 on success, EINVAL or ERANGE if called incorrectly. Assuming
  *	   correct usage, return code may be discarded.
  *	   If op is PACK, pbuf is modified.
@@ -216,4 +218,56 @@ int packing(void *pbuf, u64 *uval, int startbit, int endbit, size_t pbuflen,
 }
 EXPORT_SYMBOL(packing);
 
+/**
+ * pack - Pack u64 number into bitfield of buffer.
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
+ *	   correct usage, return code may be discarded. The @pbuf memory will
+ *	   be modified on success.
+ */
+int pack(void *pbuf, const u64 *uval, size_t startbit, size_t endbit,
+	 size_t pbuflen, u8 quirks)
+{
+	return packing(pbuf, (u64 *)uval, startbit, endbit, pbuflen, PACK, quirks);
+}
+EXPORT_SYMBOL(pack);
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
+	return packing((void *)pbuf, uval, startbit, endbit, pbuflen, UNPACK, quirks);
+}
+EXPORT_SYMBOL(unpack);
+
 MODULE_DESCRIPTION("Generic bitfield packing and unpacking");

-- 
2.46.2.828.g9e56e24342b6


