Return-Path: <netdev+bounces-122935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C787B96333F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E921F25593
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C21AD9E9;
	Wed, 28 Aug 2024 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PELwqn40"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C401AD9C5
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878659; cv=none; b=VtOsHTTH7dewpiRR6fpxzDHK1V+yu/XNZeQUWmmWNnCU0jiMfsGsHiOPTpihWfKD5bKvot7oucLPx6/4hMYpm+RMk/mzFMdHpzMKLGsg//D9F5krJOmnT6yiZwpYC0eXEp0UUQNMpcT2eVnSOTYiCuyO2H5TTkAJbLOn92AjB6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878659; c=relaxed/simple;
	bh=p2472d7MxYwQ1WCLHGUjV3OTNs4V0Gtc+ugjwaDre8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=snibAVn0HTVgI4hfJPcoP7PJyTJEoU6Rbkwfnh+MasMlUfgDIPz2XeFiHYIIP+R/MbQrQI3LLfCM+YJUlQeCNIsoskRdRAjhbVRVbEemxYFWhmztUSnO2tYocdzY143Gq817lxI4YUT2UVE7OEJQcX+LhPxO3HKNu2wl/V0h0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PELwqn40; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724878659; x=1756414659;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=p2472d7MxYwQ1WCLHGUjV3OTNs4V0Gtc+ugjwaDre8M=;
  b=PELwqn40FFMf9BUfO+uZ12nIuM6Th0zCzi0NMmKCPaRCGADbVOBHsu4p
   V25HAkH1iRPmns1+A0EcefAh23OVRU8uOgakBGDCmsFX8lXLl7T4kiTs1
   gORBepT+Nk8NaHEETlDCUk64VFiRZtcBL81UF0Dmj0K8i5iYw3BK2TKh5
   kX2zNhc9ufaRULt0gwy5RN4ES5s5SDaGvPaoXPlPboSStRdiC2WNFMjqB
   AnYB/5wIIAF2e0fX/yWEQFXwXQvE8sgNsSru6dGCSEOFlWkTkcC9Aj+dB
   +7/IBzht6y5Z/pCt8bZ2Wws9Ku5c2Jg6s2bB5df337D1/WWKkcycjnggf
   Q==;
X-CSE-ConnectionGUID: vZf08m0SSTGaqH9kM8v/3w==
X-CSE-MsgGUID: vurJ47FvTCOUF8/yraITyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="34592636"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="34592636"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:31 -0700
X-CSE-ConnectionGUID: uzeQiqdSQmWkkJbxTB6SAQ==
X-CSE-MsgGUID: kmS+FPsxTD+dULxhlbZPag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="64049968"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 13:57:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 28 Aug 2024 13:57:20 -0700
Subject: [PATCH iwl-next v2 04/13] lib: packing: add pack() and unpack()
 wrappers over packing()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-4-558ab9e240f5@intel.com>
References: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
In-Reply-To: <20240828-e810-live-migration-jk-prep-ctx-functions-v2-0-558ab9e240f5@intel.com>
To: Vladimir Oltean <olteanv@gmail.com>, netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
X-Mailer: b4 0.14.0

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
2.46.0.124.g2dc1a81c8933


