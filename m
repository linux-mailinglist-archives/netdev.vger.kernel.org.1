Return-Path: <netdev+bounces-104562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326190D52A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E65C1F21B6D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D3185E67;
	Tue, 18 Jun 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fz/g7AgQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9E15A853
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719813; cv=none; b=nBxtmJPvr/9EBTqYnCjqdQKShacwEoA8MIPw6891BCiFfFqcwlakcTmqvbyx/iN3fO4J1HFXkhVtAYClgxEA8kc44ggqIHrDU3Wo/lRFgHU1EW0a+OE7zbZDfbC9y68JCqBdB1vG4kZVVNyvV998nktBcEOPvHtgdLznfll/v/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719813; c=relaxed/simple;
	bh=HeNcr3qhM00+2Tl33Cp4VWWv/wI6Ox5D3E+1ZmflEk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xo7HyEJhi+ESrmPcMKWuX7oI4OOsmW9bFMhqqnP2ls6z7kEylyBaJqkF2M7ZvYX3Cc+r7WjAJ5+9GCe4ZX+f1/mfdxkW92gmZfHAkLFpqUhee+zPBjrHuzPTN3eE8vTL8x/YgQQ6MyPqs6D4FRb/C5zoMy8zeNw32IsbBfZ8ISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fz/g7AgQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719812; x=1750255812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HeNcr3qhM00+2Tl33Cp4VWWv/wI6Ox5D3E+1ZmflEk8=;
  b=Fz/g7AgQhZ72HMD2drd7EsjbeJgOxHWdUpkVQUXGPZdcVLYnOsbZHGjV
   K0AZ0K+zBH+yXQBNJ20Za876vfdfiX9d+hzZz5r/9to6FZlXfPZLZLL+2
   SLqNuO+LC1RZdfN5zi8taj3u9ArKE7pnTV6nBw1kMGV0lnwyO9B/NgYJn
   rcTfgzXWI20i1Av8W3yPyucmk1PLyJbcMwUcI/iNFYzCSOR0YgNVUb7bq
   8ceBNa9kVmXz8jY4jJlc91rwf0Ki+CsPdActy/Yl0izqNH7ZolOv3f/su
   hM/XqzR84v6fIuFBo0tJ4qvCkcWBJqc4E41/pyv0SMXPXCdNQgpIlarSF
   g==;
X-CSE-ConnectionGUID: aHBqCj8RTb2loJqogtLNmw==
X-CSE-MsgGUID: vQkaE+7iRnyiUbS6YYroug==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33137776"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33137776"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:10:10 -0700
X-CSE-ConnectionGUID: yzkcUamsRVy97/bVG0dAbw==
X-CSE-MsgGUID: zkGjTdXlQL2/9Ak3fPpd4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46109798"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 07:10:07 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AC76634304;
	Tue, 18 Jun 2024 15:10:04 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 4/6] ice: remove unused recipe bookkeeping data
Date: Tue, 18 Jun 2024 16:11:55 +0200
Message-ID: <20240618141157.1881093-5-marcin.szycik@linux.intel.com>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Remove root_buf from recipe struct. Its only usage was in ice_find_recp(),
where if recipe had an inverse action, it was skipped, but actually the
driver never adds inverse actions, so effectively it was pointless.

Without root_buf, the recipe data element in ice_add_sw_recipe() does
not need to be persistent and can also be automatically deallocated with
__free, which nicely simplifies unroll.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  1 -
 drivers/net/ethernet/intel/ice/ice_switch.c | 55 ++++++---------------
 drivers/net/ethernet/intel/ice/ice_switch.h |  2 -
 3 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 60ad7774812c..df1623ddbaf6 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -993,7 +993,6 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
 				devm_kfree(ice_hw_to_dev(hw), lst_itr);
 			}
 		}
-		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
 	}
 	ice_rm_all_sw_replay_rule_info(hw);
 	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2f67fbb73fd1..f8f9d192d345 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2445,13 +2445,6 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 	lkup_exts->n_val_words = fv_word_idx;
 	recps[rid].big_recp = (num_recps > 1);
 	recps[rid].n_grp_count = (u8)num_recps;
-	recps[rid].root_buf = devm_kmemdup(ice_hw_to_dev(hw), tmp,
-					   recps[rid].n_grp_count * sizeof(*recps[rid].root_buf),
-					   GFP_KERNEL);
-	if (!recps[rid].root_buf) {
-		status = -ENOMEM;
-		goto err_unroll;
-	}
 
 	/* Copy result indexes */
 	bitmap_copy(recps[rid].res_idxs, result_bm, ICE_MAX_FV_WORDS);
@@ -4768,11 +4761,6 @@ ice_find_recp(struct ice_hw *hw, struct ice_prot_lkup_ext *lkup_exts,
 				continue;
 		}
 
-		/* Skip inverse action recipes */
-		if (recp[i].root_buf && recp[i].root_buf->content.act_ctrl &
-		    ICE_AQ_RECIPE_ACT_INV_ACT)
-			continue;
-
 		/* if number of words we are looking for match */
 		if (lkup_exts->n_val_words == recp[i].lkup_exts.n_val_words) {
 			struct ice_fv_word *ar = recp[i].lkup_exts.fv_words;
@@ -5081,9 +5069,9 @@ static int
 ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		  unsigned long *profiles)
 {
+	struct ice_aqc_recipe_data_elem *buf __free(kfree) = NULL;
 	DECLARE_BITMAP(result_idx_bm, ICE_MAX_FV_WORDS);
 	struct ice_aqc_recipe_content *content;
-	struct ice_aqc_recipe_data_elem *buf;
 	struct ice_recp_grp_entry *entry;
 	u16 free_res_idx;
 	u8 chain_idx;
@@ -5112,12 +5100,9 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 	if (rm->n_grp_count > ICE_MAX_CHAIN_RECIPE)
 		return -ENOSPC;
 
-	buf = devm_kcalloc(ice_hw_to_dev(hw), rm->n_grp_count, sizeof(*buf),
-			   GFP_KERNEL);
-	if (!buf) {
-		status = -ENOMEM;
-		goto err_mem;
-	}
+	buf = kcalloc(rm->n_grp_count, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
 	bitmap_zero(rm->r_bitmap, ICE_MAX_NUM_RECIPES);
 
@@ -5130,7 +5115,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 
 		status = ice_alloc_recipe(hw, &entry->rid);
 		if (status)
-			goto err_unroll;
+			return status;
 
 		content = &buf[recps].content;
 
@@ -5160,8 +5145,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			 */
 			if (chain_idx >= ICE_MAX_FV_WORDS) {
 				ice_debug(hw, ICE_DBG_SW, "No chain index available\n");
-				status = -ENOSPC;
-				goto err_unroll;
+				return -ENOSPC;
 			}
 
 			entry->chain_idx = chain_idx;
@@ -5215,7 +5199,7 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		 */
 		status = ice_alloc_recipe(hw, &rid);
 		if (status)
-			goto err_unroll;
+			return status;
 
 		content = &buf[recps].content;
 
@@ -5228,10 +5212,9 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		last_chain_entry = devm_kzalloc(ice_hw_to_dev(hw),
 						sizeof(*last_chain_entry),
 						GFP_KERNEL);
-		if (!last_chain_entry) {
-			status = -ENOMEM;
-			goto err_unroll;
-		}
+		if (!last_chain_entry)
+			return -ENOMEM;
+
 		last_chain_entry->rid = rid;
 		memset(&content->lkup_indx, 0, sizeof(content->lkup_indx));
 		/* All recipes use look-up index 0 to match switch ID. */
@@ -5265,12 +5248,12 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 	}
 	status = ice_acquire_change_lock(hw, ICE_RES_WRITE);
 	if (status)
-		goto err_unroll;
+		return status;
 
 	status = ice_aq_add_recipe(hw, buf, rm->n_grp_count, NULL);
 	ice_release_change_lock(hw);
 	if (status)
-		goto err_unroll;
+		return status;
 
 	/* Every recipe that just got created add it to the recipe
 	 * book keeping list
@@ -5288,10 +5271,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 				idx_found = true;
 			}
 
-		if (!idx_found) {
-			status = -EIO;
-			goto err_unroll;
-		}
+		if (!idx_found)
+			return -EIO;
 
 		recp = &sw->recp_list[entry->rid];
 		is_root = (rm->root_rid == entry->rid);
@@ -5327,13 +5308,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		recp->allow_pass_l2 = rm->allow_pass_l2;
 		recp->recp_created = true;
 	}
-	rm->root_buf = buf;
-	return status;
 
-err_unroll:
-err_mem:
-	devm_kfree(ice_hw_to_dev(hw), buf);
-	return status;
+	return 0;
 }
 
 /**
@@ -5632,7 +5608,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		devm_kfree(ice_hw_to_dev(hw), fvit);
 	}
 
-	devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
 	kfree(rm);
 
 err_free_lkup_exts:
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index ad98e98c812d..0c410ce29700 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -274,8 +274,6 @@ struct ice_sw_recipe {
 
 	struct list_head rg_list;
 
-	/* AQ buffer associated with this recipe */
-	struct ice_aqc_recipe_data_elem *root_buf;
 	/* This struct saves the fv_words for a given lookup */
 	struct ice_prot_lkup_ext lkup_exts;
 };
-- 
2.45.0


