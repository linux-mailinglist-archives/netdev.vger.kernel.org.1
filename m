Return-Path: <netdev+bounces-198999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9253ADE9F2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E10189D7E8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872DC2BEC28;
	Wed, 18 Jun 2025 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KSz5yVpK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1822BD5AF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246184; cv=none; b=LjO3ik/Mj4og7uJL/574h/m+qHP7C9Y3+5xm/gjEIDbftEu74XvkZiDePZdl+aI+ANHc9WkCSRvHsYZEEeErAVArZXhgrajiM8yZeJew1EdSnfOnJYQcAycI51DAGXlExzGehRsNYmRDhE5Y6ECQrOW1+3zMMmsEXewCbjOak5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246184; c=relaxed/simple;
	bh=cu8YFtFt+dOWghLgG5rgIaL2vYFfOICJPAScMWEk3m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erL6BwLM0R7gB3q8IKvhz7M2atSVf9tbUheygzN88DVQhVX89gIq3bn+6EBZPBE1f00f7dSjaHGCGU7S0bHqTvoB4czYZNoKo1QJAcbhmcT1bIp39MO5ULclFApozJWvuBsdeDXrum8wnOzJqxF32McLm+u2qSikl9eC9kYc8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KSz5yVpK; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750246183; x=1781782183;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cu8YFtFt+dOWghLgG5rgIaL2vYFfOICJPAScMWEk3m4=;
  b=KSz5yVpKon6ZMiHza6A/OR1YVV8aZO9EQEL4/gng1FrhjFJxeKktjcMv
   Zwj+wA1tfphG7CvK/omQ231VkeSl4N3MPJmkf7cgRpcG3kVUMlo00VATk
   DMXLRcDQ7EEbUqi6SeiMf+d7ccATN1fo1RanNligFg/hOCKkqBjdsEDZQ
   YcE8QNGgGClTTijGr/EEJ4rHl/Q2U2zeidmbu+t9iE+bZr/RrVtuEt5wK
   H8tEbGyaU+kFBiG/PDPUhrOSeVf20CuYmcWPr/jPhht6QXpslqwkPdwvE
   7xwOMx9tKcsm7f8ZGJX7LiOqC+e5ha0nmpGR4x1A7md0jey0daQVTYpOw
   g==;
X-CSE-ConnectionGUID: 3cFU76+GS7eVYZ7E1Wty3w==
X-CSE-MsgGUID: vgtMopVNSN6R1xzChGNrsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="56134032"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="56134032"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 04:29:43 -0700
X-CSE-ConnectionGUID: I+0MIGRPSmu4IijiO6ZeJQ==
X-CSE-MsgGUID: uJcIeRu0SIC/ikCeaxdK5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="150180274"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 18 Jun 2025 04:29:38 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.24])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 18CAF33BF4;
	Wed, 18 Jun 2025 12:29:36 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>
Subject: [PATCH iwl-next] ice: convert ice_add_prof() to bitmap
Date: Wed, 18 Jun 2025 13:28:53 +0200
Message-ID: <20250618112925.12193-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Previously the ice_add_prof() took an array of u8 and looped over it with
for_each_set_bit(), examining each 8 bit value as a bitmap.
This was just hard to understand and unnecessary, and was triggering
undefined behavior sanitizers with unaligned accesses within bitmap
fields (on our internal tools/builds). Since the @ptype being passed in
was already declared as a bitmap, refactor this to use native types with
the advantage of simplifying the code to use a single loop.

Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
CC: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  7 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 78 +++++++------------
 drivers/net/ethernet/intel/ice/ice_flow.c     |  4 +-
 3 files changed, 34 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
index 28b0897adf32..ee5d9f9c9d53 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
@@ -39,9 +39,10 @@ bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype);
 
 /* XLT2/VSI group functions */
 int
-ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
-	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
-	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap);
+ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
+	     unsigned long *ptypes, const struct ice_ptype_attributes *attr,
+	     u16 attr_cnt, struct ice_fv_word *es, u16 *masks, bool symm,
+	     bool fd_swap);
 struct ice_prof_map *
 ice_search_prof_id(struct ice_hw *hw, enum ice_block blk, u64 id);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index ed95072ca6e3..363ae79a3620 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3043,16 +3043,16 @@ ice_disable_fd_swap(struct ice_hw *hw, u8 prof_id)
  * the ID value used here.
  */
 int
-ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
-	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
-	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap)
+ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id,
+	     unsigned long *ptypes, const struct ice_ptype_attributes *attr,
+	     u16 attr_cnt, struct ice_fv_word *es, u16 *masks, bool symm,
+	     bool fd_swap)
 {
-	u32 bytes = DIV_ROUND_UP(ICE_FLOW_PTYPE_MAX, BITS_PER_BYTE);
 	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
 	struct ice_prof_map *prof;
-	u8 byte = 0;
-	u8 prof_id;
 	int status;
+	u8 prof_id;
+	u16 ptype;
 
 	bitmap_zero(ptgs_used, ICE_XLT1_CNT);
 
@@ -3102,57 +3102,35 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
 	prof->context = 0;
 
 	/* build list of ptgs */
-	while (bytes && prof->ptg_cnt < ICE_MAX_PTG_PER_PROFILE) {
-		u8 bit;
+	for_each_set_bit(ptype, ptypes, ICE_FLOW_PTYPE_MAX) {
+		u8 ptg;
 
-		if (!ptypes[byte]) {
-			bytes--;
-			byte++;
+		/* The package should place all ptypes in a non-zero
+		 * PTG, so the following call should never fail.
+		 */
+		if (ice_ptg_find_ptype(hw, blk, ptype, &ptg))
 			continue;
-		}
 
-		/* Examine 8 bits per byte */
-		for_each_set_bit(bit, (unsigned long *)&ptypes[byte],
-				 BITS_PER_BYTE) {
-			u16 ptype;
-			u8 ptg;
-
-			ptype = byte * BITS_PER_BYTE + bit;
-
-			/* The package should place all ptypes in a non-zero
-			 * PTG, so the following call should never fail.
-			 */
-			if (ice_ptg_find_ptype(hw, blk, ptype, &ptg))
-				continue;
+		/* If PTG is already added, skip and continue */
+		if (test_bit(ptg, ptgs_used))
+			continue;
 
-			/* If PTG is already added, skip and continue */
-			if (test_bit(ptg, ptgs_used))
-				continue;
+		set_bit(ptg, ptgs_used);
+		/* Check to see there are any attributes for this ptype, and
+		 * add them if found.
+		 */
+		status = ice_add_prof_attrib(prof, ptg, ptype, attr, attr_cnt);
+		if (status == -ENOSPC)
+			break;
+		if (status) {
+			/* This is simple a ptype/PTG with no attribute */
+			prof->ptg[prof->ptg_cnt] = ptg;
+			prof->attr[prof->ptg_cnt].flags = 0;
+			prof->attr[prof->ptg_cnt].mask = 0;
 
-			__set_bit(ptg, ptgs_used);
-			/* Check to see there are any attributes for
-			 * this PTYPE, and add them if found.
-			 */
-			status = ice_add_prof_attrib(prof, ptg, ptype,
-						     attr, attr_cnt);
-			if (status == -ENOSPC)
+			if (++prof->ptg_cnt >= ICE_MAX_PTG_PER_PROFILE)
 				break;
-			if (status) {
-				/* This is simple a PTYPE/PTG with no
-				 * attribute
-				 */
-				prof->ptg[prof->ptg_cnt] = ptg;
-				prof->attr[prof->ptg_cnt].flags = 0;
-				prof->attr[prof->ptg_cnt].mask = 0;
-
-				if (++prof->ptg_cnt >=
-				    ICE_MAX_PTG_PER_PROFILE)
-					break;
-			}
 		}
-
-		bytes--;
-		byte++;
 	}
 
 	list_add(&prof->list, &hw->blk[blk].es.prof_map);
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index d97b751052f2..c63e43b8b110 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1421,7 +1421,7 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	/* Add a HW profile for this flow profile */
-	status = ice_add_prof(hw, blk, prof_id, (u8 *)params->ptypes,
+	status = ice_add_prof(hw, blk, prof_id, params->ptypes,
 			      params->attr, params->attr_cnt, params->es,
 			      params->mask, symm, true);
 	if (status) {
@@ -1617,7 +1617,7 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
 		break;
 	}
 
-	status = ice_add_prof(hw, blk, id, (u8 *)prof->ptypes,
+	status = ice_add_prof(hw, blk, id, prof->ptypes,
 			      params->attr, params->attr_cnt,
 			      params->es, params->mask, false, false);
 	if (status)
-- 
2.46.0


