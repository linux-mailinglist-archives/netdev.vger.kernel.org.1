Return-Path: <netdev+bounces-208226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B463CB0AA65
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EAA35C11D9
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13C2E8E0E;
	Fri, 18 Jul 2025 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBQ7DI4C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9D2E92B7
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864692; cv=none; b=j8N1OW9H3fY4a/ihnSELBskCfYHCAl0MLeDLBBn8lPN6Czagb71y10AmaL0BFVni+uQqJ03aoy3b+zcu5RfZktoeNoC6rV/ZyyfhOeOF/Uxd2HPAvaDbLadhakZT0Hgp0MaW0zQ2ecYJbXZZFunWr4210FSX+5Re0SU9+n2Jz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864692; c=relaxed/simple;
	bh=tq8002epkrGoFB5qbixc2N92ov3xim81YvkW2dNjLG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKZf6lPKoLmAH84P9WnMUkynQPFJhnsF/utAVo9oLSAu82o/T4WFzUxRtzvxZSdOReDkoGcEEwvT0ir52vFh+zjGuj9RLwepi4JDcaen7FFZArmDwLhfRyF0NS5oA5YnM3BtpADwGIBgjlff9lxveP56gwzo4q7ZtflNNIgUl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBQ7DI4C; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864690; x=1784400690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tq8002epkrGoFB5qbixc2N92ov3xim81YvkW2dNjLG0=;
  b=aBQ7DI4CtcGUG+dc8blWCRO8w3WNyt5ueZFOwQwyltzrhGo9iuBPMtPy
   F3yuTaExZOqTCbprmaQU8E/95zJlWWSuVVOu8qF0aWJAmkDBkmOi8R8/z
   WtHTjvW2z12K+SRuMoyfW+RcKE2vfzSJ+cwAlP43U0tmu0NaBm4FrlV0Q
   uY0mo9c3J3PZyCgu/xQlDlyUxHSQXnVPdy29FTiHHLwVL+X63c9pMRkav
   wz458GiA3i9YKTQw3qLTCJlQYBU1IvqfpVEwmIaAu49A6gOQ0nKL9B2lT
   OEsz/wQc4BCrrNX9FwYlRUJgb7VBPtqtpn5BNI9VsptCAKQG5mEd+jEuw
   w==;
X-CSE-ConnectionGUID: 0rzCJCPrRSmsAOZj8y/LZg==
X-CSE-MsgGUID: +h+uTfkPRJuAA8hHwX1YFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320600"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320600"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:25 -0700
X-CSE-ConnectionGUID: ZMXg6PcxT1e7Rny6+IODlg==
X-CSE-MsgGUID: u4IaRFFyQFGGa1jUtTreUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506900"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 08/13] ice: convert ice_add_prof() to bitmap
Date: Fri, 18 Jul 2025 11:51:09 -0700
Message-ID: <20250718185118.2042772-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 78 +++++++------------
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  7 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |  4 +-
 3 files changed, 34 insertions(+), 55 deletions(-)

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
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 278e57686274..6d5c939dc8a5 100644
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
2.47.1


