Return-Path: <netdev+bounces-107351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E091A9F4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF871F25D9A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F36198825;
	Thu, 27 Jun 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jt1Rvgxv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDBE197A6B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500078; cv=none; b=Cd6mmvLqC3MgzaQujJfaOr9cksOZOESUoGcXxoZ6FX16irVZ5+psw2iZqqZn0MDppU4DasqZ/j13UucRJx2ZmbG3oOnaVZ1Igl8N4xWnrvXvtlG5mRXYN54PY6aoGdZaWE9GZE4VssTQMkldEVa2NzGmf0pMxO/x5I1fQ5DHEuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500078; c=relaxed/simple;
	bh=pG8UmjsYZLN4ZQVPG+bp+tSLjDCQFVAiV9I5OHo2iAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9S2L4YK5Mg3zjO507J70nkn2O9k7Fmjs9lvVXI8De2sEuBLTiXJL0o6ww+HXHBDs4PgzLbcHvRsFMXWlvx0nmjTIynpdtuEP0gTd3AprKJ8ltkcXut8dMqW2bQ0a6suzkSQjtnC/Zu8wmd20Fm7iJJ9fMrWaXkb1+SbHHsgh/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jt1Rvgxv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500076; x=1751036076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pG8UmjsYZLN4ZQVPG+bp+tSLjDCQFVAiV9I5OHo2iAM=;
  b=Jt1RvgxvCpO2t8eXCadK1EMXB77X36lbTk0LkM2N3jpuG+8Prj0aIT+o
   Lb3OuVWfRaMpXB8FTwmE5gPHglik2Itt2tpTwqim2dvFU2ExuBrj4asRj
   9SftgRRXXvSAhmpArASYVmYNZrzwWvVvl4yEIBG2CqIaIjQTpbGzv125T
   wbEgvAFajv4GnV9lADBc5gy9DZKXidv0Od7fmpT5RbfOXZ6UkAHnHU3YC
   c8V7uhP+GtpXoVNHYH7IMLOmLXcZa4QhanGVnAYM4xodIPXyhrRU8YM28
   sFjmrendCUBsgxN3vcIgupNf5sfZ+C2GkS96sw1yW8RUZfSrmrv517yzE
   w==;
X-CSE-ConnectionGUID: nKRlGi/ER/+wT1Gg8TcsSA==
X-CSE-MsgGUID: /FKK34neTcWa+6Qja6CfBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20514979"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20514979"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:54:32 -0700
X-CSE-ConnectionGUID: kpRHsWydSC26UxDApCtNIg==
X-CSE-MsgGUID: IGee/bRASwyrxo8Tx7rEQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67616404"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2024 07:54:30 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0251A27BC6;
	Thu, 27 Jun 2024 15:54:15 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v3 6/7] ice: Remove unused members from switch API
Date: Thu, 27 Jun 2024 16:55:46 +0200
Message-ID: <20240627145547.32621-7-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
References: <20240627145547.32621-1-marcin.szycik@linux.intel.com>
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
index 39fb81b56df7..6abd1b3796ab 100644
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
index 5a092dcea172..27828cdfe085 100644
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


