Return-Path: <netdev+bounces-83788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E289444B
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6881F21D7E
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AC4F88B;
	Mon,  1 Apr 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uoju4Gsl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5584D59F
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992272; cv=none; b=RnyIyydNGqTtk212hFv2OBFN5m8qdb3MZIpvB46rUlPAdXvimkMvINSsAUgUWO+F2C5fWdUCM4tSu3vTjbYhr1JJs41cqsEYPbex4o4q5ZyR5zWc/keNYy47Lj7CzY+bnbo/vJf4I4l1ihLjEIXtE5LTuR5NFzOYRxp+iHdKRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992272; c=relaxed/simple;
	bh=4MMhjgskjP15c3rBIu5z8JWj9kp2lgw5F58werktWtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTSTZ5Esgqd4U2pmDMFBW0E026h9aMC6XtlnBWzYJ/602hqh9k+VZxKb8kQJlTPQL5JDe5snA+4rzL2sLjBQdYLaFp01LJCaKmhKIdaHQhU9ON+8m9Ml2IM9w35eZx7SyKprdyw/szjzjiQnQOIhIcX4/7Du7xOAIyQf7eqhMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uoju4Gsl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992271; x=1743528271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MMhjgskjP15c3rBIu5z8JWj9kp2lgw5F58werktWtA=;
  b=Uoju4Gsl8F0ap79WbyhdUXGVzsYd1qfHOUu4D+AKkQqjupW1gxjBaWcV
   Mho/pyeJZxD/AFqmzOXuBg1jhJEkz6rjW+EqpabhU1hsRZQa9aF4cyyOU
   uXtAOQAp/eyzw44zc0p6EhQxzRXxAHNHsn8J5WaR7xx7dB5xuyNUReg7v
   eEEGKlDDccyYHY56IMX7NjZ+n1v/OFWH/e0VJFm8nLpwpuqYHYn/yikN3
   QwDv13gSF3KMHL5B1WIIN1JPYsWtfW/ltXskZpNYun6tnGrVlj5WtgYi3
   J11sML1OhRl9mYqAhqS9Nxj6PhPWyG43vd60gMEqye2q16UKSJiveA+dU
   w==;
X-CSE-ConnectionGUID: B9kgngA9RwOGI7558ZU7mw==
X-CSE-MsgGUID: MF+aNC77TR2In/s2jbXLGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606166"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606166"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235088"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Steven Zou <steven.zou@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrii Staikov <andrii.staikov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mayank Sharma <mayank.sharma@intel.com>
Subject: [PATCH net-next 4/8] ice: Add switch recipe reusing feature
Date: Mon,  1 Apr 2024 10:24:14 -0700
Message-ID: <20240401172421.1401696-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Zou <steven.zou@intel.com>

New E810 firmware supports the corresponding functionality, so the driver
allows PFs to subscribe the same switch recipes. Then when the PF is done
with a switch recipes, the PF can ask firmware to free that switch recipe.

When users configure a rule to PFn into E810 switch component, if there is
no existing recipe matching this rule's pattern, the driver will request
firmware to allocate and return a new recipe resource for the rule by
calling ice_add_sw_recipe() and ice_alloc_recipe(). If there is an existing
recipe matching this rule's pattern with different key value, or this is a
same second rule to PFm into switch component, the driver checks out this
recipe by calling ice_find_recp(), the driver will tell firmware to share
using this same recipe resource by calling ice_subscribable_recp_shared()
and ice_subscribe_recipe().

When firmware detects that all subscribing PFs have freed the switch
recipe, firmware will free the switch recipe so that it can be reused.

This feature also fixes a problem where all switch recipes would eventually
be exhausted because switch recipes could not be freed, as freeing a shared
recipe could potentially break other PFs that were using it.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steven Zou <steven.zou@intel.com>
Tested-by: Mayank Sharma <mayank.sharma@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_switch.c   | 187 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_switch.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 5 files changed, 177 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1f3e7a6903e5..540c0bdca936 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -264,6 +264,8 @@ struct ice_aqc_set_port_params {
 #define ICE_AQC_RES_TYPE_FLAG_SHARED			BIT(7)
 #define ICE_AQC_RES_TYPE_FLAG_SCAN_BOTTOM		BIT(12)
 #define ICE_AQC_RES_TYPE_FLAG_IGNORE_INDEX		BIT(13)
+#define ICE_AQC_RES_TYPE_FLAG_SUBSCRIBE_SHARED		BIT(14)
+#define ICE_AQC_RES_TYPE_FLAG_SUBSCRIBE_CTL		BIT(15)
 
 #define ICE_AQC_RES_TYPE_FLAG_DEDICATED			0x00
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index db4b2844e1f7..dc5a1ef3364d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1142,6 +1142,8 @@ int ice_init_hw(struct ice_hw *hw)
 	if (status)
 		goto err_unroll_fltr_mgmt_struct;
 	mutex_init(&hw->tnl_lock);
+	ice_init_chk_recipe_reuse_support(hw);
+
 	return 0;
 
 err_unroll_fltr_mgmt_struct:
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 606c2419182a..94d6670d0901 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2148,6 +2148,18 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
 	return status;
 }
 
+/**
+ * ice_init_chk_recipe_reuse_support - check if recipe reuse is supported
+ * @hw: pointer to the hardware structure
+ */
+void ice_init_chk_recipe_reuse_support(struct ice_hw *hw)
+{
+	struct ice_nvm_info *nvm = &hw->flash.nvm;
+
+	hw->recp_reuse = (nvm->major == 0x4 && nvm->minor >= 0x30) ||
+			 nvm->major > 0x4;
+}
+
 /**
  * ice_alloc_recipe - add recipe resource
  * @hw: pointer to the hardware structure
@@ -2157,12 +2169,16 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 {
 	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
 	u16 buf_len = __struct_size(sw_buf);
+	u16 res_type;
 	int status;
 
 	sw_buf->num_elems = cpu_to_le16(1);
-	sw_buf->res_type = cpu_to_le16((ICE_AQC_RES_TYPE_RECIPE <<
-					ICE_AQC_RES_TYPE_S) |
-					ICE_AQC_RES_TYPE_FLAG_SHARED);
+	res_type = FIELD_PREP(ICE_AQC_RES_TYPE_M, ICE_AQC_RES_TYPE_RECIPE);
+	if (hw->recp_reuse)
+		res_type |= ICE_AQC_RES_TYPE_FLAG_SUBSCRIBE_SHARED;
+	else
+		res_type |= ICE_AQC_RES_TYPE_FLAG_SHARED;
+	sw_buf->res_type = cpu_to_le16(res_type);
 	status = ice_aq_alloc_free_res(hw, sw_buf, buf_len,
 				       ice_aqc_opc_alloc_res);
 	if (!status)
@@ -2171,6 +2187,70 @@ int ice_alloc_recipe(struct ice_hw *hw, u16 *rid)
 	return status;
 }
 
+/**
+ * ice_free_recipe_res - free recipe resource
+ * @hw: pointer to the hardware structure
+ * @rid: recipe ID to free
+ *
+ * Return: 0 on success, and others on error
+ */
+static int ice_free_recipe_res(struct ice_hw *hw, u16 rid)
+{
+	return ice_free_hw_res(hw, ICE_AQC_RES_TYPE_RECIPE, 1, &rid);
+}
+
+/**
+ * ice_release_recipe_res - disassociate and free recipe resource
+ * @hw: pointer to the hardware structure
+ * @recp: the recipe struct resource to unassociate and free
+ *
+ * Return: 0 on success, and others on error
+ */
+static int ice_release_recipe_res(struct ice_hw *hw,
+				  struct ice_sw_recipe *recp)
+{
+	DECLARE_BITMAP(r_bitmap, ICE_MAX_NUM_RECIPES);
+	struct ice_switch_info *sw = hw->switch_info;
+	u64 recp_assoc;
+	u32 rid, prof;
+	int status;
+
+	for_each_set_bit(rid, recp->r_bitmap, ICE_MAX_NUM_RECIPES) {
+		for_each_set_bit(prof, recipe_to_profile[rid],
+				 ICE_MAX_NUM_PROFILES) {
+			status = ice_aq_get_recipe_to_profile(hw, prof,
+							      &recp_assoc,
+							      NULL);
+			if (status)
+				return status;
+
+			bitmap_from_arr64(r_bitmap, &recp_assoc,
+					  ICE_MAX_NUM_RECIPES);
+			bitmap_andnot(r_bitmap, r_bitmap, recp->r_bitmap,
+				      ICE_MAX_NUM_RECIPES);
+			bitmap_to_arr64(&recp_assoc, r_bitmap,
+					ICE_MAX_NUM_RECIPES);
+			ice_aq_map_recipe_to_profile(hw, prof,
+						     recp_assoc, NULL);
+
+			clear_bit(rid, profile_to_recipe[prof]);
+			clear_bit(prof, recipe_to_profile[rid]);
+		}
+
+		status = ice_free_recipe_res(hw, rid);
+		if (status)
+			return status;
+
+		sw->recp_list[rid].recp_created = false;
+		sw->recp_list[rid].adv_rule = false;
+		memset(&sw->recp_list[rid].lkup_exts, 0,
+		       sizeof(sw->recp_list[rid].lkup_exts));
+		clear_bit(rid, recp->r_bitmap);
+	}
+
+	return 0;
+}
+
 /**
  * ice_get_recp_to_prof_map - updates recipe to profile mapping
  * @hw: pointer to hardware structure
@@ -2220,6 +2300,7 @@ ice_collect_result_idx(struct ice_aqc_recipe_data_elem *buf,
  * @recps: struct that we need to populate
  * @rid: recipe ID that we are populating
  * @refresh_required: true if we should get recipe to profile mapping from FW
+ * @is_add: flag of adding recipe
  *
  * This function is used to populate all the necessary entries into our
  * bookkeeping so that we have a current list of all the recipes that are
@@ -2227,7 +2308,7 @@ ice_collect_result_idx(struct ice_aqc_recipe_data_elem *buf,
  */
 static int
 ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
-		    bool *refresh_required)
+		    bool *refresh_required, bool is_add)
 {
 	DECLARE_BITMAP(result_bm, ICE_MAX_FV_WORDS);
 	struct ice_aqc_recipe_data_elem *tmp;
@@ -2344,8 +2425,12 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 			recps[idx].chain_idx = ICE_INVAL_CHAIN_IND;
 		}
 
-		if (!is_root)
+		if (!is_root) {
+			if (hw->recp_reuse && is_add)
+				recps[idx].recp_created = true;
+
 			continue;
+		}
 
 		/* Only do the following for root recipes entries */
 		memcpy(recps[idx].r_bitmap, root_bufs.recipe_bitmap,
@@ -2369,7 +2454,8 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 	/* Copy result indexes */
 	bitmap_copy(recps[rid].res_idxs, result_bm, ICE_MAX_FV_WORDS);
-	recps[rid].recp_created = true;
+	if (is_add)
+		recps[rid].recp_created = true;
 
 err_unroll:
 	kfree(tmp);
@@ -4653,12 +4739,13 @@ static struct ice_protocol_entry ice_prot_id_tbl[ICE_PROTOCOL_LAST] = {
  * @hw: pointer to the hardware structure
  * @lkup_exts: extension sequence to match
  * @rinfo: information regarding the rule e.g. priority and action info
+ * @is_add: flag of adding recipe
  *
  * Returns index of matching recipe, or ICE_MAX_NUM_RECIPES if not found.
  */
 static u16
 ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
-	      const struct ice_adv_rule_info *rinfo)
+	      const struct ice_adv_rule_info *rinfo, bool is_add)
 {
 	bool refresh_required = true;
 	struct ice_sw_recipe *recp;
@@ -4672,11 +4759,12 @@ ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
 		 * entry update it in our SW bookkeeping and continue with the
 		 * matching.
 		 */
-		if (!recp[i].recp_created)
+		if (hw->recp_reuse) {
 			if (ice_get_recp_frm_fw(hw,
 						hw->switch_info->recp_list, i,
-						&refresh_required))
+						&refresh_required, is_add))
 				continue;
+		}
 
 		/* Skip inverse action recipes */
 		if (recp[i].root_buf && recp[i].root_buf->content.act_ctrl &
@@ -5360,6 +5448,49 @@ ice_get_compat_fv_bitmap(struct ice_hw *hw, struct ice_adv_rule_info *rinfo,
 	ice_get_sw_fv_bitmap(hw, prof_type, bm);
 }
 
+/**
+ * ice_subscribe_recipe - subscribe to an existing recipe
+ * @hw: pointer to the hardware structure
+ * @rid: recipe ID to subscribe to
+ *
+ * Return: 0 on success, and others on error
+ */
+static int ice_subscribe_recipe(struct ice_hw *hw, u16 rid)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, sw_buf, elem, 1);
+	u16 buf_len = __struct_size(sw_buf);
+	u16 res_type;
+	int status;
+
+	/* Prepare buffer to allocate resource */
+	sw_buf->num_elems = cpu_to_le16(1);
+	res_type = FIELD_PREP(ICE_AQC_RES_TYPE_M, ICE_AQC_RES_TYPE_RECIPE) |
+		   ICE_AQC_RES_TYPE_FLAG_SUBSCRIBE_SHARED |
+		   ICE_AQC_RES_TYPE_FLAG_SUBSCRIBE_CTL;
+	sw_buf->res_type = cpu_to_le16(res_type);
+
+	sw_buf->elem[0].e.sw_resp = cpu_to_le16(rid);
+
+	status = ice_aq_alloc_free_res(hw, sw_buf, buf_len,
+				       ice_aqc_opc_alloc_res);
+
+	return status;
+}
+
+/**
+ * ice_subscribable_recp_shared - share an existing subscribable recipe
+ * @hw: pointer to the hardware structure
+ * @rid: recipe ID to subscribe to
+ */
+static void ice_subscribable_recp_shared(struct ice_hw *hw, u16 rid)
+{
+	struct ice_sw_recipe *recps = hw->switch_info->recp_list;
+	u16 sub_rid;
+
+	for_each_set_bit(sub_rid, recps[rid].r_bitmap, ICE_MAX_NUM_RECIPES)
+		ice_subscribe_recipe(hw, sub_rid);
+}
+
 /**
  * ice_add_adv_recipe - Add an advanced recipe that is not part of the default
  * @hw: pointer to hardware structure
@@ -5382,6 +5513,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	struct ice_sw_fv_list_entry *tmp;
 	struct ice_sw_recipe *rm;
 	int status = 0;
+	u16 rid_tmp;
 	u8 i;
 
 	if (!lkups_cnt)
@@ -5459,10 +5591,14 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	}
 
 	/* Look for a recipe which matches our requested fv / mask list */
-	*rid = ice_find_recp(hw, lkup_exts, rinfo);
-	if (*rid < ICE_MAX_NUM_RECIPES)
+	*rid = ice_find_recp(hw, lkup_exts, rinfo, true);
+	if (*rid < ICE_MAX_NUM_RECIPES) {
 		/* Success if found a recipe that match the existing criteria */
+		if (hw->recp_reuse)
+			ice_subscribable_recp_shared(hw, *rid);
+
 		goto err_unroll;
+	}
 
 	rm->tun_type = rinfo->tun_type;
 	/* Recipe we need does not exist, add a recipe */
@@ -5481,14 +5617,14 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		status = ice_aq_get_recipe_to_profile(hw, fvit->profile_id,
 						      &recp_assoc, NULL);
 		if (status)
-			goto err_unroll;
+			goto err_free_recipe;
 
 		bitmap_from_arr64(r_bitmap, &recp_assoc, ICE_MAX_NUM_RECIPES);
 		bitmap_or(r_bitmap, r_bitmap, rm->r_bitmap,
 			  ICE_MAX_NUM_RECIPES);
 		status = ice_acquire_change_lock(hw, ICE_RES_WRITE);
 		if (status)
-			goto err_unroll;
+			goto err_free_recipe;
 
 		bitmap_to_arr64(&recp_assoc, r_bitmap, ICE_MAX_NUM_RECIPES);
 		status = ice_aq_map_recipe_to_profile(hw, fvit->profile_id,
@@ -5496,7 +5632,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		ice_release_change_lock(hw);
 
 		if (status)
-			goto err_unroll;
+			goto err_free_recipe;
 
 		/* Update profile to recipe bitmap array */
 		bitmap_copy(profile_to_recipe[fvit->profile_id], r_bitmap,
@@ -5510,6 +5646,16 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	*rid = rm->root_rid;
 	memcpy(&hw->switch_info->recp_list[*rid].lkup_exts, lkup_exts,
 	       sizeof(*lkup_exts));
+	goto err_unroll;
+
+err_free_recipe:
+	if (hw->recp_reuse) {
+		for_each_set_bit(rid_tmp, rm->r_bitmap, ICE_MAX_NUM_RECIPES) {
+			if (!ice_free_recipe_res(hw, rid_tmp))
+				clear_bit(rid_tmp, rm->r_bitmap);
+		}
+	}
+
 err_unroll:
 	list_for_each_entry_safe(r_entry, r_tmp, &rm->rg_list, l_entry) {
 		list_del(&r_entry->l_entry);
@@ -6529,7 +6675,7 @@ ice_rem_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 			return -EIO;
 	}
 
-	rid = ice_find_recp(hw, &lkup_exts, rinfo);
+	rid = ice_find_recp(hw, &lkup_exts, rinfo, false);
 	/* If did not find a recipe that match the existing criteria */
 	if (rid == ICE_MAX_NUM_RECIPES)
 		return -EINVAL;
@@ -6573,14 +6719,21 @@ ice_rem_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 					 ice_aqc_opc_remove_sw_rules, NULL);
 		if (!status || status == -ENOENT) {
 			struct ice_switch_info *sw = hw->switch_info;
+			struct ice_sw_recipe *r_list = sw->recp_list;
 
 			mutex_lock(rule_lock);
 			list_del(&list_elem->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), list_elem->lkups);
 			devm_kfree(ice_hw_to_dev(hw), list_elem);
 			mutex_unlock(rule_lock);
-			if (list_empty(&sw->recp_list[rid].filt_rules))
-				sw->recp_list[rid].adv_rule = false;
+			if (list_empty(&r_list[rid].filt_rules)) {
+				r_list[rid].adv_rule = false;
+
+				/* All rules for this recipe are now removed */
+				if (hw->recp_reuse)
+					ice_release_recipe_res(hw,
+							       &r_list[rid]);
+			}
 		}
 		kfree(s_rule);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 322ef81d3913..ad98e98c812d 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -432,5 +432,6 @@ ice_aq_get_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 *r_assoc,
 int
 ice_aq_map_recipe_to_profile(struct ice_hw *hw, u32 profile_id, u64 r_assoc,
 			     struct ice_sq_cd *cd);
+void ice_init_chk_recipe_reuse_support(struct ice_hw *hw);
 
 #endif /* _ICE_SWITCH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 64b8e7ec0b63..08ec5efdafe6 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -848,6 +848,8 @@ struct ice_hw {
 
 	u16 max_burst_size;	/* driver sets this value */
 
+	u8 recp_reuse:1;	/* indicates whether FW supports recipe reuse */
+
 	/* Tx Scheduler values */
 	u8 num_tx_sched_layers;
 	u8 num_tx_sched_phys_layers;
-- 
2.41.0


