Return-Path: <netdev+bounces-236537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DDCC3DB2E
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A42C3B0E77
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B1350291;
	Thu,  6 Nov 2025 22:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUrMDu3+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B5334E765
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469614; cv=none; b=GukBeXzLIJL8UHLqADcK9mXCfeL3oc3lyocQfJ8mz649JV8k54Sl+TULpRcfpylo7Tm0FUUdD+L1J/sQolG3R/Hlg8lumIzWAid2TX0wU/NgTl9cBBmtkcH25MweuRaDLswhXrozXJdO4wlNiTbHnciNKRYy4P0nteHKrDZgiK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469614; c=relaxed/simple;
	bh=eRtF1eoq3aNMN7edOPaMEOmjVG/kLGmebJlsw097HKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3XAPOr8xn5NwN8j++7NorxmHgEx6kJORnXt8rM6//5untHQRVVWLN/eHPgRN9N23MC+zJLyqPItxF5L6PnBc4V65p4lv9A49F0Q3EQ5mOsrKZCpTrsgl+yzJPjsPZCivhM09m0TcJVo1AYhMOENM2BhWM9aVxsZFSpnv0CdPwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUrMDu3+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762469613; x=1794005613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eRtF1eoq3aNMN7edOPaMEOmjVG/kLGmebJlsw097HKU=;
  b=hUrMDu3+J1GPrhqN9KMMjRVrG11rxQ+wrBGWEtDlDV7paAniE1SXjtE6
   McCDz8h6O0CXCEdQdz9OBbQX5zznDuE1VitFTtpIR42HB0FD8q680/RJG
   imyVrofPIdqNs32E0JNVcMIOQ9fxunh1TpHzrncmlX+GNwm9VHDAGz3mO
   W/kD3wsTuLHWm5AVfNooBz+GEv/sdtJQzlsiB1tVNgqjVQXlUyHbtfe3i
   tH3AGRTwqTGHUbnZ79Ng1A1STQVEL9AreeO4QNiQTNn+cQl4Mi08Xox/M
   X/T2s58yQveUePr12ABAlW3NSfGyZHhi0m6LwYFvtKgm+ktPIsuviK2rD
   g==;
X-CSE-ConnectionGUID: wUliz9TvRZKF2z94h2DzEQ==
X-CSE-MsgGUID: 2QBaYjf+Ra6LTQoLLSzbPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64715900"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64715900"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:53:30 -0800
X-CSE-ConnectionGUID: hi8VhdNOT1CYvW4FHff2QA==
X-CSE-MsgGUID: cmfuNb0/QeW1jiK36a6NWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188602833"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 14:53:30 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	Dan Nowlin <dan.nowlin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 6/8] ice: improve TCAM priority handling for RSS profiles
Date: Thu,  6 Nov 2025 14:53:15 -0800
Message-ID: <20251106225321.1609605-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
References: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Enhance TCAM priority logic to avoid conflicts between RSS profiles
with overlapping PTGs and attributes.

Track used PTG and attribute combinations.
Ensure higher-priority profiles override lower ones.
Add helper for setting TCAM flags and masks.

Ensure RSS rule consistency and prevent unintended matches.

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    | 91 ++++++++++++++++---
 .../net/ethernet/intel/ice/ice_flex_type.h    |  1 +
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index c8cb492fddf4..c0dbec369366 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3577,6 +3577,19 @@ ice_move_vsi(struct ice_hw *hw, enum ice_block blk, u16 vsi, u16 vsig,
 	return 0;
 }
 
+/**
+ * ice_set_tcam_flags - set TCAM flag don't care mask
+ * @mask: mask for flags
+ * @dc_mask: pointer to the don't care mask
+ */
+static void ice_set_tcam_flags(u16 mask, u8 dc_mask[ICE_TCAM_KEY_VAL_SZ])
+{
+	u16 inverted_mask = ~mask;
+
+	/* flags are lowest u16 */
+	put_unaligned_le16(inverted_mask, dc_mask);
+}
+
 /**
  * ice_rem_chg_tcam_ent - remove a specific TCAM entry from change list
  * @hw: pointer to the HW struct
@@ -3647,6 +3660,9 @@ ice_prof_tcam_ena_dis(struct ice_hw *hw, enum ice_block blk, bool enable,
 	if (!p)
 		return -ENOMEM;
 
+	/* set don't care masks for TCAM flags */
+	ice_set_tcam_flags(tcam->attr.mask, dc_msk);
+
 	status = ice_tcam_write_entry(hw, blk, tcam->tcam_idx, tcam->prof_id,
 				      tcam->ptg, vsig, 0, tcam->attr.flags,
 				      vl_msk, dc_msk, nm_msk);
@@ -3672,6 +3688,34 @@ ice_prof_tcam_ena_dis(struct ice_hw *hw, enum ice_block blk, bool enable,
 	return status;
 }
 
+/**
+ * ice_ptg_attr_in_use - determine if PTG and attribute pair is in use
+ * @ptg_attr: pointer to the PTG and attribute pair to check
+ * @ptgs_used: bitmap that denotes which PTGs are in use
+ * @attr_used: array of PTG and attributes pairs already used
+ * @attr_cnt: count of entries in the attr_used array
+ *
+ * Return: true if the PTG and attribute pair is in use, false otherwise.
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
@@ -3684,10 +3728,16 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
 			struct list_head *chg)
 {
 	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
+	struct ice_tcam_inf **attr_used;
 	struct ice_vsig_prof *t;
-	int status;
+	u16 attr_used_cnt = 0;
+	int status = 0;
 	u16 idx;
 
+	attr_used = kcalloc(ICE_MAX_PTG_ATTRS, sizeof(*attr_used), GFP_KERNEL);
+	if (!attr_used)
+		return -ENOMEM;
+
 	bitmap_zero(ptgs_used, ICE_XLT1_CNT);
 	idx = vsig & ICE_VSIG_IDX_M;
 
@@ -3705,11 +3755,15 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
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
@@ -3719,9 +3773,8 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
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
@@ -3730,15 +3783,21 @@ ice_adj_prof_priorities(struct ice_hw *hw, enum ice_block blk, u16 vsig,
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
+	kfree(attr_used);
+	return status;
 }
 
 /**
@@ -3821,11 +3880,15 @@ ice_add_prof_id_vsig(struct ice_hw *hw, enum ice_block blk, u16 vsig, u64 hdl,
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
@@ -4139,9 +4202,6 @@ ice_flow_assoc_fdir_prof(struct ice_hw *hw, enum ice_block blk,
 	u16 vsi_num;
 	int status;
 
-	if (blk != ICE_BLK_FD)
-		return -EINVAL;
-
 	vsi_num = ice_get_hw_vsi_num(hw, dest_vsi);
 	status = ice_add_prof_id_flow(hw, blk, vsi_num, hdl);
 	if (status) {
@@ -4150,6 +4210,9 @@ ice_flow_assoc_fdir_prof(struct ice_hw *hw, enum ice_block blk,
 		return status;
 	}
 
+	if (blk != ICE_BLK_FD)
+		return 0;
+
 	vsi_num = ice_get_hw_vsi_num(hw, fdir_vsi);
 	status = ice_add_prof_id_flow(hw, blk, vsi_num, hdl);
 	if (status) {
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_type.h b/drivers/net/ethernet/intel/ice/ice_flex_type.h
index 817beca591e0..80c9e7c749c2 100644
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


