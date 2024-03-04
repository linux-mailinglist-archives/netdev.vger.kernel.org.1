Return-Path: <netdev+bounces-77253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38954870CF5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46FC28B8A0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735637C0BA;
	Mon,  4 Mar 2024 21:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6knu3sD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C57BB1F
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587786; cv=none; b=mIiznDrKIugSjmV2K31GeYBOaetzsxE+dQWznXEPTegVcniLtyIR1a6ovYWNUm3kGg6yBPTBrBgc3O31wJzooQPlPgFo1vQgF/+dpXJd88Z2duBhmzSbsNK8hu0djFEsZyGzBA5y+J/JNrnYcwQUZGFi7juS0K8GqqDA/FBl9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587786; c=relaxed/simple;
	bh=2hsrK/X/rWh79NAS2OqB00vWbwTPWqWMUQ3vr+tqK4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAwcFNqkoOcOnxOgFQ5Kin0FTYSHFwLy0UgWT/Zeng7dUrb3NxXlRFxKsAWo4/bWTLm9QpJUhMUG0qWjySVeR9nXXA17S1YSFs5cY7/15rFCTvVhp6LBWSPqsXhqKIpwVEBXW0luUPMwhbmRqLnaOBBBs3KNhomSy7Cw5M9j4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6knu3sD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587784; x=1741123784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2hsrK/X/rWh79NAS2OqB00vWbwTPWqWMUQ3vr+tqK4Q=;
  b=d6knu3sDixbvyKitdQDwMNPy8JckA8AiPk8DdeZbtu2qc4T+KMdckiyl
   EodCVT5kcTFWJ1LXcEbN5BNEOZtulUTETo2fZs0hHTb90TFa6iFT/lVzy
   XlRFMvVzEhzXv/ZJl+/ydYb5Bl5JHDjTqbf+by3VHzmjzqdO04ke1sdw9
   sha4hQnsI2g2+CRCxJ6yvP2pjb1ubGG6xMlS1viRWmNloSIuH6ioaM1Dc
   DcoJzV8jsGiABC5PjUUwaWmLVZrhiOxb2lKhhStGaZPEY7iXMDw13Q1oa
   dcsqgtkweiqtwoTfOIqSfUQDWHTyhd4DArBMPoI1Ee7DBPkQ4yPyP4xKi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968086"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968086"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647884"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/9] ice: use GENMASK instead of BIT(n) - 1 in pack functions
Date: Mon,  4 Mar 2024 13:29:27 -0800
Message-ID: <20240304212932.3412641-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The functions used to pack the Tx and Rx context into the hardware format
rely on using BIT() and then subtracting 1 to get a bitmask. These
functions even have a comment about how x86 machines can't use this method
for certain widths because the SHL instructions will not work properly.

The Linux kernel already provides the GENMASK macro for generating a
suitable bitmask. Further, GENMASK is capable of generating the mask
including the shift_width. Since width is the total field width, take care
to subtract one to get the final bit position.

Since we now include the shifted bits as part of the mask, shift the source
value first before applying the mask.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 44 ++++-----------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 3622079cb506..e9e4a8ef7904 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4379,14 +4379,11 @@ static void ice_pack_ctx_byte(u8 *src_ctx, u8 *dest_ctx,
 
 	/* prepare the bits and mask */
 	shift_width = ce_info->lsb % 8;
-	mask = (u8)(BIT(ce_info->width) - 1);
+	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
 
 	src_byte = *from;
-	src_byte &= mask;
-
-	/* shift to correct alignment */
-	mask <<= shift_width;
 	src_byte <<= shift_width;
+	src_byte &= mask;
 
 	/* get the current bits from the target bit string */
 	dest = dest_ctx + (ce_info->lsb / 8);
@@ -4419,17 +4416,14 @@ static void ice_pack_ctx_word(u8 *src_ctx, u8 *dest_ctx,
 
 	/* prepare the bits and mask */
 	shift_width = ce_info->lsb % 8;
-	mask = BIT(ce_info->width) - 1;
+	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
 
 	/* don't swizzle the bits until after the mask because the mask bits
 	 * will be in a different bit position on big endian machines
 	 */
 	src_word = *(u16 *)from;
-	src_word &= mask;
-
-	/* shift to correct alignment */
-	mask <<= shift_width;
 	src_word <<= shift_width;
+	src_word &= mask;
 
 	/* get the current bits from the target bit string */
 	dest = dest_ctx + (ce_info->lsb / 8);
@@ -4462,25 +4456,14 @@ static void ice_pack_ctx_dword(u8 *src_ctx, u8 *dest_ctx,
 
 	/* prepare the bits and mask */
 	shift_width = ce_info->lsb % 8;
-
-	/* if the field width is exactly 32 on an x86 machine, then the shift
-	 * operation will not work because the SHL instructions count is masked
-	 * to 5 bits so the shift will do nothing
-	 */
-	if (ce_info->width < 32)
-		mask = BIT(ce_info->width) - 1;
-	else
-		mask = (u32)~0;
+	mask = GENMASK(ce_info->width - 1 + shift_width, shift_width);
 
 	/* don't swizzle the bits until after the mask because the mask bits
 	 * will be in a different bit position on big endian machines
 	 */
 	src_dword = *(u32 *)from;
-	src_dword &= mask;
-
-	/* shift to correct alignment */
-	mask <<= shift_width;
 	src_dword <<= shift_width;
+	src_dword &= mask;
 
 	/* get the current bits from the target bit string */
 	dest = dest_ctx + (ce_info->lsb / 8);
@@ -4513,25 +4496,14 @@ static void ice_pack_ctx_qword(u8 *src_ctx, u8 *dest_ctx,
 
 	/* prepare the bits and mask */
 	shift_width = ce_info->lsb % 8;
-
-	/* if the field width is exactly 64 on an x86 machine, then the shift
-	 * operation will not work because the SHL instructions count is masked
-	 * to 6 bits so the shift will do nothing
-	 */
-	if (ce_info->width < 64)
-		mask = BIT_ULL(ce_info->width) - 1;
-	else
-		mask = (u64)~0;
+	mask = GENMASK_ULL(ce_info->width - 1 + shift_width, shift_width);
 
 	/* don't swizzle the bits until after the mask because the mask bits
 	 * will be in a different bit position on big endian machines
 	 */
 	src_qword = *(u64 *)from;
-	src_qword &= mask;
-
-	/* shift to correct alignment */
-	mask <<= shift_width;
 	src_qword <<= shift_width;
+	src_qword &= mask;
 
 	/* get the current bits from the target bit string */
 	dest = dest_ctx + (ce_info->lsb / 8);
-- 
2.41.0


