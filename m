Return-Path: <netdev+bounces-106163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F16915062
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899B6284B79
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF2E19CCF1;
	Mon, 24 Jun 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ae4yuUP5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC019AD67
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240242; cv=none; b=Nk5eCelfeZFpBK4NsIyDptvFJYfytY3Zc4GxRqdiO8KEg5Ork0j6anAU3ON5cgBAA04Obur75+iieRgi8qWEcywXHg13QJXCJmH9C7F/+tnqwQ24zWBx0WmpGujZjGv5y7SiR4L8m48GmuOz4Hj1fC2CgYNSkJTwj2IYdUDcKro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240242; c=relaxed/simple;
	bh=rZfZ8LRS4yetc2xWtSvNng1weoxkVzK97MXMga9e7+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM0SiVA1XXFg4PMcpo5e1Jml9/JQj4kkxnbkCS/hSJs6gCmdJtaHCIiy/Gfr+LWpF8q0r5nhkADScCo+7VWnJ0pUoEYfYsObqgIM9XP3tF2R8A7nBoDolyWSx8Pug3OnhgBv7FPR+ATmjlXsIP4rONl7L8ziBJfzflcBPljoBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ae4yuUP5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719240241; x=1750776241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZfZ8LRS4yetc2xWtSvNng1weoxkVzK97MXMga9e7+k=;
  b=ae4yuUP57L/fhE5ne7kvUEWnOnoT6bl5fqQJPVOXZx5E8Az1ixqgdPQC
   HNkumkLlsXDsqLllTAYPs+UxIN2vcS2WDeZkBvLoLsbeuRYxoiZuR5B+6
   wRsL+hP/+49Oqr/2ZNO/5WLvTTLVsgrCLrc6kdvt+FHxLC+/fnjkmyNXK
   t70BndImTwjDd77YWVrB+WJBIDDxRrZab10RP5Mrw2EKcPnRJivNGHZzs
   l0r+IPn+hAlCxHMtC0Qu1rUg8+A6kaNk2VX8pyam4DiohG8FdyQwgacA6
   FFr1M6kTg+76j+YgyIDIKTmG2JYlRr3W7YvEtT9t7nWnyGLJ4SPReenjM
   w==;
X-CSE-ConnectionGUID: VUEHzmBeTVagfDF0DLF3Jw==
X-CSE-MsgGUID: HJYtFuj8Sqi6eHRI0PcUYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16040476"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16040476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:44:00 -0700
X-CSE-ConnectionGUID: /YbYC8JoR7yqLUkQxq8slQ==
X-CSE-MsgGUID: OmjXfJyWR8yO8K3+3i6KUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44022051"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2024 07:43:58 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F04EB27BB4;
	Mon, 24 Jun 2024 15:43:46 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v2 2/7] ice: Remove reading all recipes before adding a new one
Date: Mon, 24 Jun 2024 16:45:25 +0200
Message-ID: <20240624144530.690545-3-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
References: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The content of the first read recipe is used as a template when adding a
recipe. It isn't needed - only prune index is directly set from there. Set
it in the code instead. Also, now there's no need to set rid and lookup
indexes to 0, as the whole recipe buffer is initialized to 0.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 29 ++-------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0d58cf185698..da065512889d 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5079,11 +5079,9 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 {
 	DECLARE_BITMAP(result_idx_bm, ICE_MAX_FV_WORDS);
 	struct ice_aqc_recipe_content *content;
-	struct ice_aqc_recipe_data_elem *tmp;
 	struct ice_aqc_recipe_data_elem *buf;
 	struct ice_recp_grp_entry *entry;
 	u16 free_res_idx;
-	u16 recipe_count;
 	u8 chain_idx;
 	u8 recps = 0;
 	int status;
@@ -5110,10 +5108,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 	if (rm->n_grp_count > ICE_MAX_CHAIN_RECIPE)
 		return -ENOSPC;
 
-	tmp = kcalloc(ICE_MAX_NUM_RECIPES, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
-		return -ENOMEM;
-
 	buf = devm_kcalloc(ice_hw_to_dev(hw), rm->n_grp_count, sizeof(*buf),
 			   GFP_KERNEL);
 	if (!buf) {
@@ -5122,11 +5116,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 	}
 
 	bitmap_zero(rm->r_bitmap, ICE_MAX_NUM_RECIPES);
-	recipe_count = ICE_MAX_NUM_RECIPES;
-	status = ice_aq_get_recipe(hw, tmp, &recipe_count, ICE_SW_LKUP_MAC,
-				   NULL);
-	if (status || recipe_count == 0)
-		goto err_unroll;
 
 	/* Allocate the recipe resources, and configure them according to the
 	 * match fields from protocol headers and extracted field vectors.
@@ -5141,19 +5130,9 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 
 		content = &buf[recps].content;
 
-		/* Clear the result index of the located recipe, as this will be
-		 * updated, if needed, later in the recipe creation process.
-		 */
-		tmp[0].content.result_indx = 0;
-
-		buf[recps] = tmp[0];
 		buf[recps].recipe_indx = (u8)entry->rid;
-		/* if the recipe is a non-root recipe RID should be programmed
-		 * as 0 for the rules to be applied correctly.
-		 */
-		content->rid = 0;
-		memset(&content->lkup_indx, 0,
-		       sizeof(content->lkup_indx));
+
+		buf[recps].content.act_ctrl |= ICE_AQ_RECIPE_ACT_PRUNE_INDX_M;
 
 		/* All recipes use look-up index 0 to match switch ID. */
 		content->lkup_indx[0] = ICE_AQ_SW_ID_LKUP_IDX;
@@ -5192,8 +5171,6 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		}
 
 		/* fill recipe dependencies */
-		bitmap_zero((unsigned long *)buf[recps].recipe_bitmap,
-			    ICE_MAX_NUM_RECIPES);
 		set_bit(buf[recps].recipe_indx,
 			(unsigned long *)buf[recps].recipe_bitmap);
 		content->act_ctrl_fwd_priority = rm->priority;
@@ -5357,12 +5334,10 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		recp->recp_created = true;
 	}
 	rm->root_buf = buf;
-	kfree(tmp);
 	return status;
 
 err_unroll:
 err_mem:
-	kfree(tmp);
 	devm_kfree(ice_hw_to_dev(hw), buf);
 	return status;
 }
-- 
2.45.0


