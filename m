Return-Path: <netdev+bounces-69675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC3B84C235
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C41F278A0
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90A6D27D;
	Wed,  7 Feb 2024 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJaBcWne"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C81CD1E
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271346; cv=none; b=KvFN1aceByJCUh46tQ9igMtD99WSJW3fonBpe6Tej6Xr99JxADotlzHbRbjPNm+K0tHTPwWf7oKgrlUHcDqh3ujlmXs6IHxDREwUOJo9qcBK7QIvNulI6sUS+tEIrQC9pg+VMvapmskFnAEjBt6F683i+NsdQsE+cUtvODwWCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271346; c=relaxed/simple;
	bh=DLNmxqloaietIfYE4YK4JsqY8uWh/VNRcpHAtKRd7NE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r+TxzNv5W70uiOoP4X8+2gyUOH4PgJVpdzuGKQfguKkld8Yq5ou+QN4REf+sO/oqrlZSnDOKQHoyGV8RO7kbFeqdO2SUIbV6mEJAolsT29y4VLD1qwVQ+FwJHKBmPvj40NLnmYLgUn7H4u9NNr8xwyqNhc7rIS+OiFi0buWsupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJaBcWne; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707271344; x=1738807344;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DLNmxqloaietIfYE4YK4JsqY8uWh/VNRcpHAtKRd7NE=;
  b=BJaBcWnent/fE2ucDKwPs7cR7Axov7gMjYl7Mb8eZMft/5kaWPiLEaWt
   VPSAcaZfUkACM5VCf9W/GTxh7PFdECvjpehkHjmrHWaeZ79KmtiJyKrnK
   ksA7WOqeGnGdfNap6hsmKtoQjbJAVvxGkx6tntIvQ+6dbgLqsAr9wbdQB
   ee6bGjrwDYDRmablxgyCveBaN8BKG3/ClpOk6u5RcrSLkfMjNMmzsZZIS
   KpB8YizlRnsHb0EvyGFAMo/INIDCB1hH/70VvmQwEb6PdiMuUosBo/p8Y
   K8lOWDsRdKJogOqmFjaBh3OwRThc3mfcWicMbHqvicXNZ9Mxy4o93nBDZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1037074"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1037074"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 18:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1416213"
Received: from wp3.sh.intel.com ([10.240.108.102])
  by fmviesa008.fm.intel.com with ESMTP; 06 Feb 2024 18:02:20 -0800
From: Steven Zou <steven.zou@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	maciej.fijalkowski@intel.com,
	mschmidt@redhat.com,
	jiri@resnulli.us,
	daniel.machon@microchip.com,
	jesse.brandeburg@intel.com,
	david.m.ertman@intel.com,
	przemyslaw.kitszel@intel.com,
	andriy.shevchenko@linux.intel.com,
	andrii.staikov@intel.com,
	jan.sokolowski@intel.com,
	horms@kernel.org,
	steven.zou@intel.com
Subject: [PATCH iwl-net] ice: Refactor FW data type and fix bitmap casting issue
Date: Wed,  7 Feb 2024 09:49:59 +0800
Message-Id: <20240207014959.24012-1-steven.zou@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the datasheet, the recipe association data is an 8-byte
little-endian value. It is described as 'Bitmap of the recipe indexes
associated with this profile', it is from 24 to 31 byte area in FW.
Therefore, it is defined to '__le64 recipe_assoc' in struct
ice_aqc_recipe_to_profile. And then fix the bitmap casting issue, as we
must never ever use castings for bitmap type.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steven Zou <steven.zou@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  3 ++-
 drivers/net/ethernet/intel/ice/ice_lag.c      |  4 ++--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 24 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  4 ++--
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 8040317c9561..1f3e7a6903e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -593,8 +593,9 @@ struct ice_aqc_recipe_data_elem {
 struct ice_aqc_recipe_to_profile {
 	__le16 profile_id;
 	u8 rsvd[6];
-	DECLARE_BITMAP(recipe_assoc, ICE_MAX_NUM_RECIPES);
+	__le64 recipe_assoc;
 };
+static_assert(sizeof(struct ice_aqc_recipe_to_profile) == 16);
 
 /* Add/Update/Remove/Get switch rules (indirect 0x02A0, 0x02A1, 0x02A2, 0x02A3)
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 467372d541d2..a7a342809935 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2041,7 +2041,7 @@ int ice_init_lag(struct ice_pf *pf)
 	/* associate recipes to profiles */
 	for (n = 0; n < ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER; n++) {
 		err = ice_aq_get_recipe_to_profile(&pf->hw, n,
-						   (u8 *)&recipe_bits, NULL);
+						   &recipe_bits, NULL);
 		if (err)
 			continue;
 
@@ -2049,7 +2049,7 @@ int ice_init_lag(struct ice_pf *pf)
 			recipe_bits |= BIT(lag->pf_recipe) |
 				       BIT(lag->lport_recipe);
 			ice_aq_map_recipe_to_profile(&pf->hw, n,
-						     (u8 *)&recipe_bits, NULL);
+						     recipe_bits, NULL);
 		}
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index f84bab80ca42..ba0ef91e4c19 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2025,12 +2025,12 @@ ice_update_recipe_lkup_idx(struct ice_hw *hw,
  * ice_aq_map_recipe_to_profile - Map recipe to packet profile
  * @hw: pointer to the HW struct
  * @profile_id: package profile ID to associate the recipe with
- * @r_bitmap: Recipe bitmap filled in and need to be returned as response
+ * @r_assoc: Recipe bitmap filled in and need to be returned as response
  * @cd: pointer to command details structure or NULL
  * Recipe to profile association (0x0291)
  */
 int
-ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
+ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 r_assoc,
 			     struct ice_sq_cd *cd)
 {
 	struct ice_aqc_recipe_to_profile *cmd;
@@ -2042,7 +2042,7 @@ ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
 	/* Set the recipe ID bit in the bitmask to let the device know which
 	 * profile we are associating the recipe to
 	 */
-	memcpy(cmd->recipe_assoc, r_bitmap, sizeof(cmd->recipe_assoc));
+	cmd->recipe_assoc = cpu_to_le64(r_assoc);
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
@@ -2051,12 +2051,12 @@ ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
  * ice_aq_get_recipe_to_profile - Map recipe to packet profile
  * @hw: pointer to the HW struct
  * @profile_id: package profile ID to associate the recipe with
- * @r_bitmap: Recipe bitmap filled in and need to be returned as response
+ * @r_assoc: Recipe bitmap filled in and need to be returned as response
  * @cd: pointer to command details structure or NULL
  * Associate profile ID with given recipe (0x0293)
  */
 int
-ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
+ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
 			     struct ice_sq_cd *cd)
 {
 	struct ice_aqc_recipe_to_profile *cmd;
@@ -2069,7 +2069,7 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
 
 	status = ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 	if (!status)
-		memcpy(r_bitmap, cmd->recipe_assoc, sizeof(cmd->recipe_assoc));
+		*r_assoc = le64_to_cpu(cmd->recipe_assoc);
 
 	return status;
 }
@@ -2108,6 +2108,7 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 static void ice_get_recp_to_prof_map(struct ice_hw *hw)
 {
 	DECLARE_BITMAP(r_bitmap, ICE_MAX_NUM_RECIPES);
+	u64 recp_assoc;
 	u16 i;
 
 	for (i = 0; i < hw->switch_info->max_used_prof_index + 1; i++) {
@@ -2115,8 +2116,9 @@ static void ice_get_recp_to_prof_map(struct ice_hw *hw)
 
 		bitmap_zero(profile_to_recipe[i], ICE_MAX_NUM_RECIPES);
 		bitmap_zero(r_bitmap, ICE_MAX_NUM_RECIPES);
-		if (ice_aq_get_recipe_to_profile(hw, i, (u8 *)r_bitmap, NULL))
+		if (ice_aq_get_recipe_to_profile(hw, i, &recp_assoc, NULL))
 			continue;
+		bitmap_from_arr64(r_bitmap, &recp_assoc, ICE_MAX_NUM_RECIPES);
 		bitmap_copy(profile_to_recipe[i], r_bitmap,
 			    ICE_MAX_NUM_RECIPES);
 		for_each_set_bit(j, r_bitmap, ICE_MAX_NUM_RECIPES)
@@ -5390,22 +5392,24 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	 */
 	list_for_each_entry(fvit, &rm->fv_list, list_entry) {
 		DECLARE_BITMAP(r_bitmap, ICE_MAX_NUM_RECIPES);
+		u64 recp_assoc;
 		u16 j;
 
 		status = ice_aq_get_recipe_to_profile(hw, fvit->profile_id,
-						      (u8 *)r_bitmap, NULL);
+						      &recp_assoc, NULL);
 		if (status)
 			goto err_unroll;
 
+		bitmap_from_arr64(r_bitmap, &recp_assoc, ICE_MAX_NUM_RECIPES);
 		bitmap_or(r_bitmap, r_bitmap, rm->r_bitmap,
 			  ICE_MAX_NUM_RECIPES);
 		status = ice_acquire_change_lock(hw, ICE_RES_WRITE);
 		if (status)
 			goto err_unroll;
 
+		bitmap_to_arr64(&recp_assoc, r_bitmap, ICE_MAX_NUM_RECIPES);
 		status = ice_aq_map_recipe_to_profile(hw, fvit->profile_id,
-						      (u8 *)r_bitmap,
-						      NULL);
+						      recp_assoc, NULL);
 		ice_release_change_lock(hw);
 
 		if (status)
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index db7e501b7e0a..89ffa1b51b5a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -424,10 +424,10 @@ int ice_aq_add_recipe(struct ice_hw *hw,
 		      struct ice_aqc_recipe_data_elem *s_recipe_list,
 		      u16 num_recipes, struct ice_sq_cd *cd);
 int
-ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
+ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
 			     struct ice_sq_cd *cd);
 int
-ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u8 *r_bitmap,
+ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 r_assoc,
 			     struct ice_sq_cd *cd);
 
 #endif /* _ICE_SWITCH_H_ */

base-commit: f6d4e45c3a386dd7deeb1500e51ce8a6140b02f1
-- 
2.31.1


