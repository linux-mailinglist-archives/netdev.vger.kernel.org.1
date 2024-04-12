Return-Path: <netdev+bounces-87382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FEA8A2F01
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5537A282A93
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E975D91E;
	Fri, 12 Apr 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9PrEpcO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91215FBA1
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927489; cv=none; b=AdYaf51zgUxIS6Yj/TbvvcEhldSflYGjXJkW9qaPKFZ6QF9i02QCr7lpa2ETfh8hwRSZhNWQy0pPu3sasY67IqZ6NRNuAKfq9c0AmKuQXuBEOnD7MxVxvhJRsPaw0A63lCdc6rffQ0+IfYoIBgOmetOkyjqklYofVXr7x4NPwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927489; c=relaxed/simple;
	bh=DPYv1ccyPCdxxFxGcWBOo0jshvs3m1PjZFe95E59i0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flvdyghDdS/XZtcVJ9Zs3QZaunzNck1GFwrXkMsadahcoTY5Vi5qO+tphFK9dKwy+OQpL6suZgJgbB/87VobiDXvsbUtWpXTIzX0qIe4IhVM/pwFp2sPm7CDVLPbCzFu25Y0V1CN28ygZu8u/754jKzEGC8Bf42n5gq8IM2dGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9PrEpcO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927488; x=1744463488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DPYv1ccyPCdxxFxGcWBOo0jshvs3m1PjZFe95E59i0U=;
  b=a9PrEpcOsK/ZzUDEM5qCi3yG3ASeCCLuDB0ZH3JDnV2AtNeleRFtSnxA
   jJp1W7mSJKvwycX0GhXA8quVGo1urthq/yvDfFMdYY3CzP30u7/npP8bB
   4kWa7vQo7AtWH/yJDw/ifqAqHY1ZXXiaI4gSHpTL3ac4jxm5WyM8lHe9U
   zAFpVRhs+buhLkHwnsGnsKliEH5nM/25Gq8NXb5hghRURcGS46Ip7XTed
   e9xMMsSmt6LhnUbr2vS7Asz7S0fPNg0sa5BssWaqWTLKie9HZB7bYAd2T
   xvkDKTU/8RrDx9/RQbfxrobOcT8oYc8Ny0iU/HbbdPLUHAToIrOTju6zh
   g==;
X-CSE-ConnectionGUID: PSlEFaHWQoOYdDO1cT3o2w==
X-CSE-MsgGUID: 4Hf4qM4LTUOoa99qN4M9WQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12230972"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12230972"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:11:22 -0700
X-CSE-ConnectionGUID: Y6pXWTaTSsa8qPFkzSv72Q==
X-CSE-MsgGUID: s6aX/gV6S0Cm7XokmfACCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52384895"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa001.fm.intel.com with ESMTP; 12 Apr 2024 06:11:20 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v8 iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Fri, 12 Apr 2024 15:06:49 +0200
Message-ID: <20240412131104.322851-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240412131104.322851-14-karol.kolacinski@intel.com>
References: <20240412131104.322851-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add a new helper for getting base clock increment value for specific HW.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V4 -> V5: Removed unused UNKNOWN_INCVAL_E82X

 drivers/net/ethernet/intel/ice/ice_ptp.c    |  9 +--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6899b331f322..824d3f17587c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -7,8 +7,6 @@
 
 #define E810_OUT_PROP_DELAY_NS 1
 
-#define UNKNOWN_INCVAL_E82X 0x100000000ULL
-
 static const struct ptp_pin_desc ice_pin_desc_e810t[] = {
 	/* name    idx   func         chan */
 	{ "GNSS",  GNSS, PTP_PF_EXTTS, 0, { 0, } },
@@ -1210,12 +1208,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
 	struct ice_hw *hw = &pf->hw;
 	u64 incval;
 
-	if (ice_is_e810(hw))
-		incval = ICE_PTP_NOMINAL_INCVAL_E810;
-	else if (ice_e82x_time_ref(hw) < NUM_ICE_TIME_REF_FREQ)
-		incval = ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
-	else
-		incval = UNKNOWN_INCVAL_E82X;
+	incval = ice_get_base_incval(hw);
 
 	dev_dbg(ice_pf_to_dev(pf), "PTP: using base increment value of 0x%016llx\n",
 		incval);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 2d8ba9c2251d..cafae345d374 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -285,6 +285,18 @@ int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num);
 int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 				      unsigned long *caps);
 
+static inline u64 ice_get_base_incval(struct ice_hw *hw)
+{
+	switch (hw->ptp.phy_model) {
+	case ICE_PHY_E810:
+		return ICE_PTP_NOMINAL_INCVAL_E810;
+	case ICE_PHY_E82X:
+		return ice_e82x_nominal_incval(ice_e82x_time_ref(hw));
+	default:
+		return 0;
+	}
+}
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
-- 
2.43.0


