Return-Path: <netdev+bounces-104561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6590D529
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2C41F226A5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282E215A873;
	Tue, 18 Jun 2024 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMkxbs6q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4315A846
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719813; cv=none; b=RTJxxH7uGCkz3xKZ5FX9g5+JScWyDVGU5QBGXYMshUMEwk9/mxu856bqlK1Bi1LEp/+7QMlc+vxcC3LdST8Yp3nlhP/aasHv5OalY889Brl8FXQUJIgftL6gUsqvjePxley2XoGW5StV5MFc+b/SinRJZCOehT8KEz7HIkQqXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719813; c=relaxed/simple;
	bh=rZfZ8LRS4yetc2xWtSvNng1weoxkVzK97MXMga9e7+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SckF6Newfjf7jQAyWidUKMeF0YTZppFj7cYJ3/m6q8dq3iDNwmt1CaYzUHkZ5UIKSFLTD/Zqkeyt2PN08WCQ4bl4o2btoGIxuraGItPUJOuqqmq85aqZRWRkonBlP4IDxp5zyhqTLsdfgotJVjcIjVgcEw5OwhUXGKcvsnnvhGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMkxbs6q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719811; x=1750255811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZfZ8LRS4yetc2xWtSvNng1weoxkVzK97MXMga9e7+k=;
  b=IMkxbs6qDsfFxB1hFhQhwPMwZtfIQlakIx8pJp7Uo9J7EU3DNrz5NxnG
   DhZFjFLJIG8gvb9KF354sptf9L1cffXVI1SSGFIMTGjdc+E7cDZUG8aY/
   nQoP7JYRSskfiGu1HgMgETS175K9LNNtY1WyQlwnCCcRWXw2eMOEXXinm
   wfPDWM/WwLBmp4pS7usdI1AGEh39CrDGN6CaVzO41oUXd2mnr7tF1mduX
   Ugt72pssmfY4jbhJzlUM/qBmlo7zX+FUV0BfNdk9zqlLI8ZPtRO4TQCgl
   RjfgDpKUJtZEE9am6ieouSoLxIXr/7mTxOfp0jtpPJToP4Mv7PxK0xWpm
   g==;
X-CSE-ConnectionGUID: FPy1Zpd2S7yrkGuADF2cGA==
X-CSE-MsgGUID: F2kgMVQpSNOoBHhBABsu9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33137766"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33137766"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:10:07 -0700
X-CSE-ConnectionGUID: qQeLlSM8QHCO4UtPMpi4Ag==
X-CSE-MsgGUID: M1HNCxgWTqWx1PUhFWH4ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46109786"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 07:10:06 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 58EA934302;
	Tue, 18 Jun 2024 15:10:03 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 2/6] ice: Remove reading all recipes before adding a new one
Date: Tue, 18 Jun 2024 16:11:53 +0200
Message-ID: <20240618141157.1881093-3-marcin.szycik@linux.intel.com>
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


