Return-Path: <netdev+bounces-104563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693190D52D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9237D286406
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1092185E5E;
	Tue, 18 Jun 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbMeB/Gv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BB15A85A
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719814; cv=none; b=Jks8B8dWYMB5G+mBNsmG4jLLEpQ+9dbfyN5R/qesCHImvpc3wDf+VazskGwwHRQ9BipHQfT+qfZ8uPpxMr54grKDMDNZdcA2ifMwFkm6U2yxm+27lKgNGcv5rskGCtv7B5JseiS359+ZnHkaPDDFjlGZy5M/QTOHGwxsoqQjcQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719814; c=relaxed/simple;
	bh=DcB9Kobx6CtKizGMWbEiPO7ovB1AcC+k/POxvZvZ3PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0Tw/SNIBkSEBIFeRacDEFMdcqhueovypE+k/+hoq/1GiTFduDK/+fWQOKsmv1xZzHNSqC82IHZdHrogxbDuSvM3HLpqYv/GPS2x/IZOhEpZcbUd80i4SeuXcpTmjXhx2uP/dWe/WrJ7QspL0skaHQbWAFF6r3j15EdmGoxWflU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bbMeB/Gv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719812; x=1750255812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DcB9Kobx6CtKizGMWbEiPO7ovB1AcC+k/POxvZvZ3PY=;
  b=bbMeB/GvcIk2lZEKf6OQRNPA7fnJXD/xKRHy6is7CfAO7RhjMDMjZ2rI
   SrTEAWEbNHkO4PtJTzzgTHU9SPqsPLuS1/or5xM2POaTUSflM6fwrW7No
   Ob8jhhu+eGbab587VrFYCs6aYpEPeg+TBT00SrPJBLbAzeoyVfN2sKZs6
   giqf53JsbBYRg/D9RNs+jY21/qQfujUD8lsaTu6ycuRRZvNGJmp6jcz3U
   Tnfuo5xSLcEP7ochAKw0nWnUdnYNw8XmVYrLOUbUrq847mD1yY6U+wyCp
   6uSe8BPgy6nPB+KKVimcdHlvA12/B7F3tdPoXqL6uhTLaevmJQ5LBqGvu
   A==;
X-CSE-ConnectionGUID: KjY7w8qqTY2KSk1HHkTIog==
X-CSE-MsgGUID: kZ4z85tySW+6joOJIsf8BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33137773"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33137773"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:10:09 -0700
X-CSE-ConnectionGUID: Lhhhe9rsRDSPAnvuQitVNg==
X-CSE-MsgGUID: SnlQmFFYSGqtQ/nI18eX8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46109795"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 07:10:07 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 58CCC34306;
	Tue, 18 Jun 2024 15:10:06 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 6/6] ice: Remove unused members from switch API
Date: Tue, 18 Jun 2024 16:11:57 +0200
Message-ID: <20240618141157.1881093-7-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove several members of struct ice_sw_recipe and struct
ice_prot_lkup_ext. Remove struct ice_recp_grp_entry and struct
ice_pref_recipe_group, since they are now unused as well.

All of the deleted members were only written to and never read, so it's
pointless to keep them.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   |  7 ---
 .../ethernet/intel/ice/ice_protocol_type.h    | 17 -------
 drivers/net/ethernet/intel/ice/ice_switch.c   | 51 ++++---------------
 drivers/net/ethernet/intel/ice/ice_switch.h   | 16 ------
 4 files changed, 10 insertions(+), 81 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index df1623ddbaf6..23217580796c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -961,14 +961,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
 	}
 	recps = sw->recp_list;
 	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++) {
-		struct ice_recp_grp_entry *rg_entry, *tmprg_entry;
-
 		recps[i].root_rid = i;
-		list_for_each_entry_safe(rg_entry, tmprg_entry,
-					 &recps[i].rg_list, l_entry) {
-			list_del(&rg_entry->l_entry);
-			devm_kfree(ice_hw_to_dev(hw), rg_entry);
-		}
 
 		if (recps[i].adv_rule) {
 			struct ice_adv_fltr_mgmt_list_entry *tmp_entry;
diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 47e405bf1382..7c09ea0f03ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -455,7 +455,6 @@ struct ice_prot_ext_tbl_entry {
 
 /* Extractions to be looked up for a given recipe */
 struct ice_prot_lkup_ext {
-	u16 prot_type;
 	u8 n_val_words;
 	/* create a buffer to hold max words per recipe */
 	u16 field_mask[ICE_MAX_CHAIN_WORDS];
@@ -463,20 +462,4 @@ struct ice_prot_lkup_ext {
 	struct ice_fv_word fv_words[ICE_MAX_CHAIN_WORDS];
 };
 
-struct ice_pref_recipe_group {
-	u8 n_val_pairs;		/* Number of valid pairs */
-	struct ice_fv_word pairs[ICE_NUM_WORDS_RECIPE];
-	u16 mask[ICE_NUM_WORDS_RECIPE];
-};
-
-struct ice_recp_grp_entry {
-	struct list_head l_entry;
-
-#define ICE_INVAL_CHAIN_IND 0xFF
-	u16 rid;
-	u8 chain_idx;
-	u16 fv_idx[ICE_NUM_WORDS_RECIPE];
-	u16 fv_mask[ICE_NUM_WORDS_RECIPE];
-	struct ice_pref_recipe_group r_group;
-};
 #endif /* _ICE_PROTOCOL_TYPE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 3fa747fca7c6..80796834194d 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1471,7 +1471,6 @@ int ice_init_def_sw_recp(struct ice_hw *hw)
 		recps[i].root_rid = i;
 		INIT_LIST_HEAD(&recps[i].filt_rules);
 		INIT_LIST_HEAD(&recps[i].filt_replay_rules);
-		INIT_LIST_HEAD(&recps[i].rg_list);
 		mutex_init(&recps[i].filt_rule_lock);
 	}
 
@@ -2339,18 +2338,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 	for (sub_recps = 0; sub_recps < num_recps; sub_recps++) {
 		struct ice_aqc_recipe_data_elem root_bufs = tmp[sub_recps];
-		struct ice_recp_grp_entry *rg_entry;
 		u8 i, prof, idx, prot = 0;
 		bool is_root;
 		u16 off = 0;
 
-		rg_entry = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*rg_entry),
-					GFP_KERNEL);
-		if (!rg_entry) {
-			status = -ENOMEM;
-			goto err_unroll;
-		}
-
 		idx = root_bufs.recipe_indx;
 		is_root = root_bufs.content.rid & ICE_AQ_RECIPE_ID_IS_ROOT;
 
@@ -2364,10 +2355,7 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 				      ICE_MAX_NUM_PROFILES);
 		for (i = 0; i < ICE_NUM_WORDS_RECIPE; i++) {
 			u8 lkup_indx = root_bufs.content.lkup_indx[i];
-
-			rg_entry->fv_idx[i] = lkup_indx;
-			rg_entry->fv_mask[i] =
-				le16_to_cpu(root_bufs.content.mask[i]);
+			u16 lkup_mask = le16_to_cpu(root_bufs.content.mask[i]);
 
 			/* If the recipe is a chained recipe then all its
 			 * child recipe's result will have a result index.
@@ -2378,26 +2366,21 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 			 * has ICE_AQ_RECIPE_LKUP_IGNORE or 0 since it isn't a
 			 * valid offset value.
 			 */
-			if (test_bit(rg_entry->fv_idx[i], hw->switch_info->prof_res_bm[prof]) ||
-			    rg_entry->fv_idx[i] & ICE_AQ_RECIPE_LKUP_IGNORE ||
-			    rg_entry->fv_idx[i] == 0)
+			if (!lkup_indx ||
+			    (lkup_indx & ICE_AQ_RECIPE_LKUP_IGNORE) ||
+			    test_bit(lkup_indx,
+				     hw->switch_info->prof_res_bm[prof]))
 				continue;
 
-			ice_find_prot_off(hw, ICE_BLK_SW, prof,
-					  rg_entry->fv_idx[i], &prot, &off);
+			ice_find_prot_off(hw, ICE_BLK_SW, prof, lkup_indx,
+					  &prot, &off);
 			lkup_exts->fv_words[fv_word_idx].prot_id = prot;
 			lkup_exts->fv_words[fv_word_idx].off = off;
-			lkup_exts->field_mask[fv_word_idx] =
-				rg_entry->fv_mask[i];
+			lkup_exts->field_mask[fv_word_idx] = lkup_mask;
 			fv_word_idx++;
 		}
-		/* populate rg_list with the data from the child entry of this
-		 * recipe
-		 */
-		list_add(&rg_entry->l_entry, &recps[rid].rg_list);
 
 		/* Propagate some data to the recipe database */
-		recps[idx].is_root = !!is_root;
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
 		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
 					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
@@ -2405,11 +2388,8 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
-			recps[idx].chain_idx = root_bufs.content.result_indx &
-				~ICE_AQ_RECIPE_RESULT_EN;
-			set_bit(recps[idx].chain_idx, recps[idx].res_idxs);
-		} else {
-			recps[idx].chain_idx = ICE_INVAL_CHAIN_IND;
+			set_bit(root_bufs.content.result_indx &
+				~ICE_AQ_RECIPE_RESULT_EN, recps[idx].res_idxs);
 		}
 
 		if (!is_root) {
@@ -2429,8 +2409,6 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 
 	/* Complete initialization of the root recipe entry */
 	lkup_exts->n_val_words = fv_word_idx;
-	recps[rid].big_recp = (num_recps > 1);
-	recps[rid].n_grp_count = (u8)num_recps;
 
 	/* Copy result indexes */
 	bitmap_copy(recps[rid].res_idxs, result_bm, ICE_MAX_FV_WORDS);
@@ -5157,7 +5135,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		return status;
 
 	recipe = &hw->switch_info->recp_list[rid];
-	recipe->is_root = true;
 	root = &buf[recp_cnt - 1];
 	fill_recipe_template(root, rid, rm);
 
@@ -5317,9 +5294,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	DECLARE_BITMAP(fv_bitmap, ICE_MAX_NUM_PROFILES);
 	DECLARE_BITMAP(profiles, ICE_MAX_NUM_PROFILES);
 	struct ice_prot_lkup_ext *lkup_exts;
-	struct ice_recp_grp_entry *r_entry;
 	struct ice_sw_fv_list_entry *fvit;
-	struct ice_recp_grp_entry *r_tmp;
 	struct ice_sw_fv_list_entry *tmp;
 	struct ice_sw_recipe *rm;
 	int status = 0;
@@ -5361,7 +5336,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	 * headers being programmed.
 	 */
 	INIT_LIST_HEAD(&rm->fv_list);
-	INIT_LIST_HEAD(&rm->rg_list);
 
 	/* Get bitmap of field vectors (profiles) that are compatible with the
 	 * rule request; only these will be searched in the subsequent call to
@@ -5465,11 +5439,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	}
 
 err_unroll:
-	list_for_each_entry_safe(r_entry, r_tmp, &rm->rg_list, l_entry) {
-		list_del(&r_entry->l_entry);
-		devm_kfree(ice_hw_to_dev(hw), r_entry);
-	}
-
 	list_for_each_entry_safe(fvit, tmp, &rm->fv_list, list_entry) {
 		list_del(&fvit->list_entry);
 		devm_kfree(ice_hw_to_dev(hw), fvit);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 84530f57e84a..3e4af531b875 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -216,7 +216,6 @@ struct ice_sw_recipe {
 	/* For a chained recipe the root recipe is what should be used for
 	 * programming rules
 	 */
-	u8 is_root;
 	u8 root_rid;
 	u8 recp_created;
 
@@ -230,19 +229,6 @@ struct ice_sw_recipe {
 	u16 fv_idx[ICE_MAX_CHAIN_WORDS];
 	u16 fv_mask[ICE_MAX_CHAIN_WORDS];
 
-	/* if this recipe is a collection of other recipe */
-	u8 big_recp;
-
-	/* if this recipe is part of another bigger recipe then chain index
-	 * corresponding to this recipe
-	 */
-	u8 chain_idx;
-
-	/* if this recipe is a collection of other recipe then count of other
-	 * recipes and recipe IDs of those recipes
-	 */
-	u8 n_grp_count;
-
 	/* Bit map specifying the IDs associated with this group of recipe */
 	DECLARE_BITMAP(r_bitmap, ICE_MAX_NUM_RECIPES);
 
@@ -274,8 +260,6 @@ struct ice_sw_recipe {
 	u8 need_pass_l2:1;
 	u8 allow_pass_l2:1;
 
-	struct list_head rg_list;
-
 	/* This struct saves the fv_words for a given lookup */
 	struct ice_prot_lkup_ext lkup_exts;
 };
-- 
2.45.0


