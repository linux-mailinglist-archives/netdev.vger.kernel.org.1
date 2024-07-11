Return-Path: <netdev+bounces-110910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 646EB92EE8E
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9B9284A3B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5816DC27;
	Thu, 11 Jul 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bu5TXgU6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D816DEA9
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721609; cv=none; b=UcYgmcu9uC2EF1fe4bNPRduzDiiRhHhFYYp829206GuVtXJd265kfXoPWsllUSSEMhgrbJTvWTSE0kbJJp++NvWfX2IuiqN5NndRUPCcm+3WxaZWybJlvgF7i2UrDUzzaD+TiiGaSatVYmLnp+51ma098ZWI7vzwQNE93jG/zsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721609; c=relaxed/simple;
	bh=Vov+SNAo6Zwvb9XQlMxo2PeUxcvV0tfVYA5bB0RggSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH6VGF0bGodKCmVEs6jn+raVeDJDtQJlND81OyIgQ3EbSoOXQwyDNf9Ql5WZLVUtJtgLkgcoO1/waw7O/hpw/WmXyFPuLSjhGcwb6ROJDeEtYHxxEGBqzFl7H7LtHICpHG+awa+uM1qJo5ePmIdRWGhxK1sN6JXZxOTb8g+XaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bu5TXgU6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721608; x=1752257608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vov+SNAo6Zwvb9XQlMxo2PeUxcvV0tfVYA5bB0RggSE=;
  b=Bu5TXgU6vOzg/RfJvJ6/2mf0kZvx+mjg6UUYlxEzAi0so1kQPSBw2Gyt
   zPFLEOI1iegiaXDFUznfvRySh+Syuy+ZiWDK7MMHWKAomFORcTWCXvHNk
   wySqwWCH0P5r8BaOo37aOzjhgkEnavks7kSo97QuK7XHurP32h+kDRfyp
   y2/HGv7ZgAFyoyhQFWR+ZZn9QWMKv0v2xZth3B7uKiwiDXHGzN6jX95OS
   So2gOyuWlAAoFwhr1SUkqbGIEJxDDLK5g1xR2ITk4GZfy5eEQlRyctvNN
   +TTBsYooooyPZY9q4KbYuxKfxsifNAmES4qXjxqJIS1BWIJy79dzK9/lA
   Q==;
X-CSE-ConnectionGUID: rav2sbeOS9O748RXiKCJHw==
X-CSE-MsgGUID: 6liIKL3rTcGvjKS/4NcOiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720936"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:13:26 -0700
X-CSE-ConnectionGUID: U+MM6I6ZQtui/0L9yhm15Q==
X-CSE-MsgGUID: dkbQuVueQWO76WqmFmp/wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48390891"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jul 2024 11:13:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 2/7] ice: Remove reading all recipes before adding a new one
Date: Thu, 11 Jul 2024 11:13:05 -0700
Message-ID: <20240711181312.2019606-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
References: <20240711181312.2019606-1-anthony.l.nguyen@intel.com>
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
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


