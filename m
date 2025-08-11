Return-Path: <netdev+bounces-212442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF2B206FB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 13:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E797518C226F
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30672BEC32;
	Mon, 11 Aug 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqDbUgE8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13F2BE640
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910746; cv=none; b=hfbQUSXGFkfDC7VWbo7ngg6YVHTtIFVBGdRsNzkWOYTYoVuEIplv+CbSVNjb3sNVzmg7jNzY2bQZ4pIIak15eJSyIjdsUt4tleP6Y/ikI4umufgJRgZP1ZPXFJ9/I11KLcNfKfKG3KYvaLGuD/52JEKczzLrfpraUaUfgZc1KU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910746; c=relaxed/simple;
	bh=4U7tcKxyFVD9kIHNjQVnRzjZECz80gqZCXTPB4y62x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4YmahkDAiP5aF/faQ+iO6CsWFliosAHYX/xn5En6RBBIWdwRu1G77DkmzDB4qC7R9F9bUVG6AQTGCfYH6ABknWIA4UgXigDsY/GRkwYXJ13Bh5/uKui9El+iTr/JQP5iyFucWDcGyLYoKT26VSFOcT4mK0Lk6Si+1dtumHWMjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqDbUgE8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754910745; x=1786446745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4U7tcKxyFVD9kIHNjQVnRzjZECz80gqZCXTPB4y62x4=;
  b=MqDbUgE8yfA5fwZOYjhhrwMeX5r/4UT9ydqPiV0/wZiF6PHAN/Fj5vSj
   HnCjVIPqBcSkjV0d+irDpHLLkd2jyWP7bxKaSseqOHX6QcHMWeheKYkw3
   BclX7Rd3v5ParqKOaHtEZiv0IT/iJu/MSThNqWHmtQ51OGy9VMKRDVycI
   tY1IBIDn5pk7bfP+WGZ6w1E5X+SDuWinzmSWHik9Im1S1pe4BROAh0Jez
   emI5w/v1aml2ymVnA5INzeCy1aLWsSabTZI/ThkNxwkunZBSYm6HqX1q9
   T6YQRix3wmp3drtG7TiAD/2On6N7H79nkrwTYC011HMKNZiPx6b94dGYT
   g==;
X-CSE-ConnectionGUID: CtoPQNLtQ/ids0+tKw5FWQ==
X-CSE-MsgGUID: JSRRlHybQ4SzrBAlOGTWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="56189517"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="56189517"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 04:12:23 -0700
X-CSE-ConnectionGUID: 2ZxoDJvBRF+Ius7Nj+gt7A==
X-CSE-MsgGUID: FqUHGU4YQ66/tcGViqAHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165532750"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa009.jf.intel.com with ESMTP; 11 Aug 2025 04:12:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dan Nowlin <dan.nowlin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 3/5] ice: improve TCAM priority handling for RSS profiles
Date: Mon, 11 Aug 2025 11:10:53 +0000
Message-ID: <20250811111213.2964512-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811111213.2964512-1-aleksandr.loktionov@intel.com>
References: <20250811111213.2964512-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance TCAM priority logic to avoid conflicts between RSS profiles
with overlapping PTGs and attributes.

Track used PTG and attribute combinations.
Ensure higher-priority profiles override lower ones.
Add helper for setting TCAM flags and masks.

Ensure RSS rule consistency and prevent unintended matches.

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 91 ++++++++++++++++---
 .../net/ethernet/intel/ice/ice_flex_type.h    |  1 +
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c

--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3581,6 +3581,20 @@ ice_move_vsi(struct ice_hw *hw, enum ice_block blk, u16 vsi, u16 vsig,
 	return 0;
 }
 
+/**
+ * ice_set_tcam_flags - set TCAM flag don't care mask
+ * @mask: mask for flags
+ * @dc_mask: pointer to the don't care mask
+ */
+static void ice_set_tcam_flags(u16 mask, u8 dc_mask[ICE_TCAM_KEY_VAL_SZ])
+{
+	u16 *flag_word;
+
+	/* flags are lowest u16 */
+	flag_word = (u16 *)dc_mask;
+	*flag_word = ~mask;
+}
+
 /**
  * ice_rem_chg_tcam_ent - remove a specific TCAM entry from change list
  * @hw: pointer to the HW struct
@@ -3651,6 +3665,9 @@ ice_prof_tcam_ena_dis(struct ice_hw *hw, enum ice_block blk, bool enable,
 	if (!p)
 		return -ENOMEM;
 
+	/* set don't care masks for TCAM flags */
+	ice_set_tcam_flags(tcam->attr.mask, dc_msk);
+
 	status = ice_tcam_write_entry(hw, blk, tcam->tcam_idx, tcam->prof_id,
 				      tcam->ptg, vsig, 0, tcam->attr.flags,
 				      vl_msk, dc_msk, nm_msk);
@@ -3676,6 +3693,32 @@ ice_prof_tcam_ena_dis(struct ice_hw *hw, enum ice_block blk, bool enable,
 	return status;
 }
 
+/**
+ * ice_ptg_attr_in_use - determine if PTG and attribute pair is in use
+ * @ptg_attr: pointer to the PTG and attribute pair to check
+ * @ptgs_used: bitmap that denotes which PTGs are in use
+ * @attr_used: array of PTG and attributes pairs already used
+ * @attr_cnt: count of entries in the attr_used array
+ */
+static bool
+ice_ptg_attr_in_use(struct ice_tcam_inf *ptg_attr, unsigned long *ptgs_used,
+		    struct ice_tcam_inf *attr_used[], u16 attr_cnt)
+{
+	u16 i;
+
+	if (!test_bit(ptg_attr->ptg, ptgs_used))
+		return false;
+
+	/* the PTG is used, so now look for correct attributes */
+	for (i = 0; i < attr_cnt; i++)
+		if (attr_used[i]->ptg == ptg_attr->ptg &&
+		    attr_used[i]->attr.flags == ptg_attr->attr.flags &&
+		    attr_used[i]->attr.mask == ptg_attr->attr.mask)
+			return true;
+
+	return false;
+}
+
 /**
  * ice_adj_prof_priorities - adjust profile based on priorities
  * @hw: pointer to the HW struct
@@ -3688,10 +3731,17 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 			struct list_head *chg)
 {
 	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
+	struct ice_tcam_inf **attr_used;
 	struct ice_vsig_prof *t;
-	int status;
+	u16 attr_used_cnt = 0;
+	int status = 0;
 	u16 idx;
 
+	attr_used = devm_kcalloc(ice_hw_to_dev(hw), ICE_MAX_PTG_ATTRS,
+				 sizeof(*attr_used), GFP_KERNEL);
+	if (!attr_used)
+		return -ENOMEM;
+
 	bitmap_zero(ptgs_used, ICE_XLT1_CNT);
 	idx = vsig & ICE_VSIG_IDX_M;
 
@@ -3709,11 +3759,15 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 		u16 i;
 
 		for (i = 0; i < t->tcam_count; i++) {
+			bool used;
+
 			/* Scan the priorities from newest to oldest.
 			 * Make sure that the newest profiles take priority.
 			 */
-			if (test_bit(t->tcam[i].ptg, ptgs_used) &&
-			    t->tcam[i].in_use) {
+			used = ice_ptg_attr_in_use(&t->tcam[i], ptgs_used,
+						   attr_used, attr_used_cnt);
+
+			if (used && t->tcam[i].in_use) {
 				/* need to mark this PTG as never match, as it
 				 * was already in use and therefore duplicate
 				 * (and lower priority)
@@ -3723,9 +3777,8 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 							       &t->tcam[i],
 							       chg);
 				if (status)
-					return status;
-			} else if (!test_bit(t->tcam[i].ptg, ptgs_used) &&
-				   !t->tcam[i].in_use) {
+					goto free_attr_used;
+			} else if (!used && !t->tcam[i].in_use) {
 				/* need to enable this PTG, as it in not in use
 				 * and not enabled (highest priority)
 				 */
@@ -3734,15 +3787,21 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 							       &t->tcam[i],
 							       chg);
 				if (status)
-					return status;
+					goto free_attr_used;
 			}
 
 			/* keep track of used ptgs */
-			__set_bit(t->tcam[i].ptg, ptgs_used);
+			set_bit(t->tcam[i].ptg, ptgs_used);
+			if (attr_used_cnt < ICE_MAX_PTG_ATTRS)
+				attr_used[attr_used_cnt++] = &t->tcam[i];
+			else
+				ice_debug(hw, ICE_DBG_INIT, "Warn: ICE_MAX_PTG_ATTRS exceeded\n");
 		}
 	}
 
-	return 0;
+free_attr_used:
+	devm_kfree(ice_hw_to_dev(hw), attr_used);
+	return status;
 }
 
 /**
@@ -3825,11 +3884,15 @@ ice_add_prof_id_vsig(struct ice_hw *hw, enum ice_block blk, u16 vsig, u64 hdl,
 		p->vsig = vsig;
 		p->tcam_idx = t->tcam[i].tcam_idx;
 
+		/* set don't care masks for TCAM flags */
+		ice_set_tcam_flags(t->tcam[i].attr.mask, dc_msk);
+
 		/* write the TCAM entry */
 		status = ice_tcam_write_entry(hw, blk, t->tcam[i].tcam_idx,
 					      t->tcam[i].prof_id,
-					      t->tcam[i].ptg, vsig, 0, 0,
-					      vl_msk, dc_msk, nm_msk);
+					      t->tcam[i].ptg, vsig, 0,
+					      t->tcam[i].attr.flags, vl_msk,
+					      dc_msk, nm_msk);
 		if (status) {
 			devm_kfree(ice_hw_to_dev(hw), p);
 			goto err_ice_add_prof_id_vsig;
@@ -4143,9 +4206,6 @@ ice_flow_assoc_fdir_prof(struct ice_hw *hw, enum ice_block blk,
 	u16 vsi_num;
 	int status;
 
-	if (blk != ICE_BLK_FD)
-		return -EINVAL;
-
 	vsi_num = ice_get_hw_vsi_num(hw, dest_vsi);
 	status = ice_add_prof_id_flow(hw, blk, vsi_num, hdl);
 	if (status) {
@@ -4154,6 +4214,9 @@ ice_flow_assoc_fdir_prof(struct ice_hw *hw, enum ice_block blk,
 		return status;
 	}
 
+	if (blk != ICE_BLK_FD)
+		return 0;
+
 	vsi_num = ice_get_hw_vsi_num(hw, fdir_vsi);
 	status = ice_add_prof_id_flow(hw, blk, vsi_num, hdl);
 	if (status) {
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index 817beca..80c9e7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_type.h
@@ -187,6 +187,7 @@ struct ice_prof_map {
 };
 
 #define ICE_INVALID_TCAM	0xFFFF
+#define ICE_MAX_PTG_ATTRS	1024
 
 struct ice_tcam_inf {
 	u16 tcam_idx;
-- 
2.47.1


