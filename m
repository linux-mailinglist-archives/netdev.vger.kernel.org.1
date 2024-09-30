Return-Path: <netdev+bounces-130668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0298B0BE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 01:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3325DB20C8B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9F81A2545;
	Mon, 30 Sep 2024 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ph/hGfR2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA07199E9E
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738399; cv=none; b=Qck8+jjpU3m3MkrUbMxNBhIA4k4PrxV7qECpIFxta6ZdeA/ah5IlpO2c+ATVr3v8OkWZat6aJdNJwKnLXjl+w++dLXrrkbbk6WKLfYzDfLBz1hdSno3A/BVwrCBZTSq4XsPHGIxo/XlvNjftmHh5rbjOX8DrHql9SRbz6dYVUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738399; c=relaxed/simple;
	bh=xxfE0zIJdsxCAM61V+h/iAbbvPnxOfTiWpWlW4/yhlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LClZRjQxmu82YqTa1/EWnyw5s921obaDOQ2PvDm12VHiPmtF3ppQV2covoD8115YNwJadmZITcHOSoHCmX/bmh9VjmGnKdtNB2KY4Qxa49uZmrInLaRavAiKvlA9tPqHCtj3OIiibMDdPWAbKx79ldyUElQgm1Y4sxRVaLpU1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ph/hGfR2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727738398; x=1759274398;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xxfE0zIJdsxCAM61V+h/iAbbvPnxOfTiWpWlW4/yhlU=;
  b=Ph/hGfR2vJicDE3y8CUax+VYzV3NXl0MYg0QVvDsnRQnSG8h4G+4W0As
   MaZAOuov+UQAlgcFPPA5h7QgSR6hwL5tbPWlGGAk55h7woFycbfE7w20w
   rzzLWi/uZVp2lRUZG1IbGtG57JV6xWRY545g92Q32g3DFt86B/pGsz0Ov
   Y3cpyqD/fy1C6DIOSms59xwKGOgaGHsUF3817sE4CKSZ0035al3XpFYBZ
   jlJreYNEp4ySZJ9y7uz58UJ2Wx90d/LZFBLFT7Ki8RkubEeTt/GgpQltG
   Mqw1OMHhogpOvuvrRC6cEbLzhk5gIez66t5j6G/mBJvSKN40hig+SygTj
   Q==;
X-CSE-ConnectionGUID: PSaahFFeR4e6u7BRB2xBIQ==
X-CSE-MsgGUID: yPhddKgUTKuSTjDf/9+NAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26660340"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26660340"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:51 -0700
X-CSE-ConnectionGUID: aiEI5owcTVCZSjUr9lcBUg==
X-CSE-MsgGUID: 3D7WZekAR/uIYSRlUdBNEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73356457"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:19:50 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 30 Sep 2024 16:19:42 -0700
Subject: [PATCH net-next 09/10] lib: packing: use BITS_PER_BYTE instead of
 8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-9-94b1f04aca85@intel.com>
References: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
In-Reply-To: <20240930-packing-kunit-tests-and-split-pack-unpack-v1-0-94b1f04aca85@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.1

From: Vladimir Oltean <vladimir.oltean@nxp.com>

This helps clarify what the 8 is for.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 lib/packing.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/packing.c b/lib/packing.c
index 9efe57d347c7..ac1f36c56a77 100644
--- a/lib/packing.c
+++ b/lib/packing.c
@@ -83,7 +83,7 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
-	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
+	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
 		/* Invalid function call */
 		return -EINVAL;
 
@@ -106,8 +106,8 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / 8;
-	plogical_last_u8  = endbit / 8;
+	plogical_first_u8 = startbit / BITS_PER_BYTE;
+	plogical_last_u8  = endbit / BITS_PER_BYTE;
 
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
@@ -123,11 +123,11 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		 * input arguments startbit and endbit.
 		 */
 		if (box == plogical_first_u8)
-			box_start_bit = startbit % 8;
+			box_start_bit = startbit % BITS_PER_BYTE;
 		else
 			box_start_bit = 7;
 		if (box == plogical_last_u8)
-			box_end_bit = endbit % 8;
+			box_end_bit = endbit % BITS_PER_BYTE;
 		else
 			box_end_bit = 0;
 
@@ -138,8 +138,8 @@ int pack(void *pbuf, u64 uval, size_t startbit, size_t endbit, size_t pbuflen,
 		 * box is u8, the projection is u64 because it may fall
 		 * anywhere within the unpacked u64.
 		 */
-		proj_start_bit = ((box * 8) + box_start_bit) - endbit;
-		proj_end_bit   = ((box * 8) + box_end_bit) - endbit;
+		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
+		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
 		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
 
@@ -199,7 +199,7 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	/* startbit is expected to be larger than endbit, and both are
 	 * expected to be within the logically addressable range of the buffer.
 	 */
-	if (unlikely(startbit < endbit || startbit >= 8 * pbuflen))
+	if (unlikely(startbit < endbit || startbit >= BITS_PER_BYTE * pbuflen))
 		/* Invalid function call */
 		return -EINVAL;
 
@@ -214,8 +214,8 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 	 * no quirks, u8 by u8 (aligned at u8 boundaries), from high to low
 	 * logical bit significance. "box" denotes the current logical u8.
 	 */
-	plogical_first_u8 = startbit / 8;
-	plogical_last_u8  = endbit / 8;
+	plogical_first_u8 = startbit / BITS_PER_BYTE;
+	plogical_last_u8  = endbit / BITS_PER_BYTE;
 
 	for (box = plogical_first_u8; box >= plogical_last_u8; box--) {
 		/* Bit indices into the currently accessed 8-bit box */
@@ -231,11 +231,11 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		 * input arguments startbit and endbit.
 		 */
 		if (box == plogical_first_u8)
-			box_start_bit = startbit % 8;
+			box_start_bit = startbit % BITS_PER_BYTE;
 		else
 			box_start_bit = 7;
 		if (box == plogical_last_u8)
-			box_end_bit = endbit % 8;
+			box_end_bit = endbit % BITS_PER_BYTE;
 		else
 			box_end_bit = 0;
 
@@ -246,8 +246,8 @@ int unpack(const void *pbuf, u64 *uval, size_t startbit, size_t endbit,
 		 * box is u8, the projection is u64 because it may fall
 		 * anywhere within the unpacked u64.
 		 */
-		proj_start_bit = ((box * 8) + box_start_bit) - endbit;
-		proj_end_bit   = ((box * 8) + box_end_bit) - endbit;
+		proj_start_bit = ((box * BITS_PER_BYTE) + box_start_bit) - endbit;
+		proj_end_bit = ((box * BITS_PER_BYTE) + box_end_bit) - endbit;
 		proj_mask = GENMASK_ULL(proj_start_bit, proj_end_bit);
 		box_mask  = GENMASK_ULL(box_start_bit, box_end_bit);
 

-- 
2.46.2.828.g9e56e24342b6


