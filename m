Return-Path: <netdev+bounces-107348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB3F91A9ED
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18776286BA5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8CD197A69;
	Thu, 27 Jun 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cr3TX748"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD5196DB1
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500076; cv=none; b=I01xvInWoyD/BULQAY6accdwkw+z27eciAGUlqWwkW3zGqDyPk/tDkTNGkyoyOWYJK2fxFsKHGka05oR2dj4n0HhoRSJIXmy8TE902c+qfbFMSmVW5ldtA6mAexChy99g6B06shIlxOkrQVntcVWE01kPyqTgHiJxrnG3iognuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500076; c=relaxed/simple;
	bh=toJnrKJIa3hFQBBM+1PHE5/G87dc1JlRWeQC+9LZfo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7XeT/fHdGMPmnbVACBuwmFfZZef2h6oS0cGBsgyikP+1Ph6INUTZhXTTY1oWL3NfZRbNgSQf6SZ7jB+C2U9Rx4RimSJuVP0uGLzJLFANTL3sALdS5PJk2Bvbvl+XHqvQan0q8fh5mjAI3B7k1mb5nzkVOFZXWw99fAliGIEDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cr3TX748; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500074; x=1751036074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toJnrKJIa3hFQBBM+1PHE5/G87dc1JlRWeQC+9LZfo0=;
  b=cr3TX748PJkEtcdTTe+jVc7dFORkvgAj0kUmPYFeLE5GuNIqU3MWuNVl
   SVk3P2vV2uGKu8GzUEN78UzOWfA8UaOHM1KAejUfXEpnKUgwfk/E4Fvyd
   96KyeMSwo0u3WhpqLI7ki8lyyrCQqBUi43u2grUOPbN4b/HZT7JzQQT/O
   FMmhyPfxByiEA0ATA2wdUcOg1O4dNf/VzLuob3wDLqh567Zm6jFQ3yBaY
   iu+S425mCkW4xCux1bUbRqFuuSCfDyTPz/mzt8GKupQM5p69DTAyc1eJO
   JXy/Vy5gsj0OvRaLpML2WSgNNIKDutxZkviP4EXrFFxBzi14KaOItaTtJ
   w==;
X-CSE-ConnectionGUID: L80QHg9NQyWIyc2kJCXcXg==
X-CSE-MsgGUID: yb/5mpMgTqeoJeyx6AElsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20514967"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20514967"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:54:28 -0700
X-CSE-ConnectionGUID: G6F2t94USSmtg6TYo9TXjQ==
X-CSE-MsgGUID: 1XGHoShCTVqb6ZuEOlHyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="67616394"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jun 2024 07:54:27 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6F6E627BC1;
	Thu, 27 Jun 2024 15:54:13 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v3 3/7] ice: Simplify bitmap setting in adding recipe
Date: Thu, 27 Jun 2024 16:55:43 +0200
Message-ID: <20240627145547.32621-4-marcin.szycik@linux.intel.com>
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

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Remove unnecessary size checks when copying bitmaps in ice_add_sw_recipe()
and replace them with compile time assert. Check if the bitmaps are equal
size, as they are copied both ways.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2: Replace sizeof(((struct s*)0)->f with sizeof_field() (thanks Alex!)
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
2.45.0


