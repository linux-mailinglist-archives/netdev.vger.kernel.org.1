Return-Path: <netdev+bounces-110911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B292EE8F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 20:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD828B21482
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 18:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F116E86F;
	Thu, 11 Jul 2024 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dbvZM4WK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E116DECC
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721610; cv=none; b=YRsERTNkre57OCQ4WjSSh6Uw7g1SGivfXW3EScc0JX3PtsS5CmXrpWm2DZvPYt95OqmxVmfB+3qhR/jzfyLLom913RTSqTTKSy7284760wWEQgV5tWardCEuj0S/8q76DSZhlET7rrFKpyjEe8v1TiKQBkxMOYXHPcToD9Lun8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721610; c=relaxed/simple;
	bh=6r3a/6RR/ZUDfru1raTs8ItYu+QnB0imiEvV1Ux2IE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPFkrml5PNxJrufeJGqjl7cJicfeVt7HhJJ2aM++adpf50++jH0rfdux2TXV3PJeWXyMc5cEmnQvg8Nayyv4Akl4ruoB+mVxfYjllCSLcEfWX0ddSip93sCfGhEtKJEjOQdnegIRnbm17XpCCSSl1WAI0VbZFLU1rzO1X1jUo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dbvZM4WK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720721609; x=1752257609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6r3a/6RR/ZUDfru1raTs8ItYu+QnB0imiEvV1Ux2IE8=;
  b=dbvZM4WK6Tedy7a8abzp0Mau6BysCULdN6axxmBjWQnEAmFxNLlDdK0y
   OOVeHAfi3CU8y2+DLuE77Tljm3GNb2EkK+0XxOaQPCEkTkN22u6ONmeas
   ihckwfg04AHbMCPUfz8iZsQlQDSU11a7a7Qpnmri2LFAEyItidhf8zljn
   ff4ECC4Mea/KgExuuWKPYn0NUfB9Lw1jr+aW5bstBqMTlhMehz6tJmrjK
   ZLU2YRWoGfCsZWjpV9Khj7XcjpfjleM9FZyCFxkkPQzTjiXVr5RXnwdc0
   lx6SwPsLXeOQ5NL4vvTgCkVboJLxCIm0BN4u0zNvqa7DDa+KU8MqVXoLN
   g==;
X-CSE-ConnectionGUID: sC3RP2SsTqu0Ui/030vruQ==
X-CSE-MsgGUID: skniIGYlTzubXV3cFrce5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28720945"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="28720945"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 11:13:27 -0700
X-CSE-ConnectionGUID: WxcyOmTcTHK976zRSLTR5A==
X-CSE-MsgGUID: lSZ/BhhiTfyMQO89lqer+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48390896"
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
Subject: [PATCH net-next 3/7] ice: Simplify bitmap setting in adding recipe
Date: Thu, 11 Jul 2024 11:13:06 -0700
Message-ID: <20240711181312.2019606-4-anthony.l.nguyen@intel.com>
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

Remove unnecessary size checks when copying bitmaps in ice_add_sw_recipe()
and replace them with compile time assert. Check if the bitmaps are equal
size, as they are copied both ways.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 24 ++++++++-------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index da065512889d..3ee4242f9880 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5067,6 +5067,10 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
 }
 
+/* For memcpy in ice_add_sw_recipe. */
+static_assert(sizeof_field(struct ice_aqc_recipe_data_elem, recipe_bitmap) ==
+	      sizeof_field(struct ice_sw_recipe, r_bitmap));
+
 /**
  * ice_add_sw_recipe - function to call AQ calls to create switch recipe
  * @hw: pointer to hardware structure
@@ -5187,13 +5191,9 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 		rm->root_rid = buf[0].recipe_indx;
 		set_bit(buf[0].recipe_indx, rm->r_bitmap);
 		buf[0].content.rid = rm->root_rid | ICE_AQ_RECIPE_ID_IS_ROOT;
-		if (sizeof(buf[0].recipe_bitmap) >= sizeof(rm->r_bitmap)) {
-			memcpy(buf[0].recipe_bitmap, rm->r_bitmap,
-			       sizeof(buf[0].recipe_bitmap));
-		} else {
-			status = -EINVAL;
-			goto err_unroll;
-		}
+		memcpy(buf[0].recipe_bitmap, rm->r_bitmap,
+		       sizeof(buf[0].recipe_bitmap));
+
 		/* Applicable only for ROOT_RECIPE, set the fwd_priority for
 		 * the recipe which is getting created if specified
 		 * by user. Usually any advanced switch filter, which results
@@ -5256,14 +5256,8 @@ ice_add_sw_recipe(struct ice_hw *hw, struct ice_sw_recipe *rm,
 			set_bit(entry->rid, rm->r_bitmap);
 		}
 		list_add(&last_chain_entry->l_entry, &rm->rg_list);
-		if (sizeof(buf[recps].recipe_bitmap) >=
-		    sizeof(rm->r_bitmap)) {
-			memcpy(buf[recps].recipe_bitmap, rm->r_bitmap,
-			       sizeof(buf[recps].recipe_bitmap));
-		} else {
-			status = -EINVAL;
-			goto err_unroll;
-		}
+		memcpy(buf[recps].recipe_bitmap, rm->r_bitmap,
+		       sizeof(buf[recps].recipe_bitmap));
 		content->act_ctrl_fwd_priority = rm->priority;
 
 		recps++;
-- 
2.41.0


