Return-Path: <netdev+bounces-104560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C804490D526
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E11F21102
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F015A84D;
	Tue, 18 Jun 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FvG2cA4S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59EC157483
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719811; cv=none; b=ksPIFp08bmzkR58JfLxBfnaDo6IjQQx7NJHjgpii3gXjUqQvLHFUrNUev1FbA+4LHRP0GAUxcx1eEBr5Dr0JCjLxzXxuWdTmc0isxEsyLMMk7EECP/3wjr7KojXj8SeFink5Egav/fXNGhwukJ1yBfiqZq60TYddwqTO1XPmPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719811; c=relaxed/simple;
	bh=PIqB4rFiMrFAlkCeJHL/ify4wZ0oHDRov88sGKpKzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZttFwbTl1oS5qqTZGpz7sINnN+1Oa5jefS0BICxHW/6j/7AMIdalhcDQShX70wqvfCoTxrExwbvxJ2y5x+xJPjoCtmQmsdojjGI0+LfE73ID3gMIPzAFqFQLPopxFqzOGuR9qGdb06ouxLK3hOnMoVzzinOJu7YNn+2TLhMU+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FvG2cA4S; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718719810; x=1750255810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PIqB4rFiMrFAlkCeJHL/ify4wZ0oHDRov88sGKpKzkA=;
  b=FvG2cA4SnvjtmLjleYM9B3ipO4OKO2ULyiiJfdLZhAlkiK4ZN/ps4Qvf
   I3Db1dXuXxp0sh7gvZJRjCH/2dnv3h/tydyjQOdcO/HDFQy/sZgMmLAcj
   PEohG3umRdsG68aciYFeFBY9fT/EZUmWJNI7aViEL24IcONmUuiJKfSxP
   opeAbFbK2y12swuKO/Oy3bUGWrUCPhqTlNBdeckw3MLZ6EfGtHY0U8GWf
   zelR/JVlMk8Q9AgnsPIBmjC95Amak+JVJtXIzhfxeb3Zb3gKgIqlVCgM6
   I+/xacyVco2OW5NK116QuYC5xc7Mbpd25nbN/+3azAw7WcrMpCWzredsW
   Q==;
X-CSE-ConnectionGUID: THN4iufGTd+/waKJ9DlmMg==
X-CSE-MsgGUID: v+pK5iUJR9SSdzWWhmp9rA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="33137762"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="33137762"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 07:10:07 -0700
X-CSE-ConnectionGUID: fLHfjfHSR8mKrvn9MkPapw==
X-CSE-MsgGUID: hPbZKoTgQKSiBgs38Gw0Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46109784"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 18 Jun 2024 07:10:06 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1AC1434303;
	Tue, 18 Jun 2024 15:10:04 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 3/6] ice: Simplify bitmap setting in adding recipe
Date: Tue, 18 Jun 2024 16:11:54 +0200
Message-ID: <20240618141157.1881093-4-marcin.szycik@linux.intel.com>
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

Remove unnecessary size checks when copying bitmaps in ice_add_sw_recipe()
and replace them with compile time assert. Check if the bitmaps are equal
size, as they are copied both ways.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 24 ++++++++-------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index da065512889d..2f67fbb73fd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5067,6 +5067,10 @@ ice_find_free_recp_res_idx(struct ice_hw *hw, const unsigned long *profiles,
 	return (u16)bitmap_weight(free_idx, ICE_MAX_FV_WORDS);
 }
 
+/* For memcpy in ice_add_sw_recipe. */
+static_assert(sizeof(((struct ice_aqc_recipe_data_elem *)0)->recipe_bitmap) ==
+	      sizeof(((struct ice_sw_recipe *)0)->r_bitmap));
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


