Return-Path: <netdev+bounces-134277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B5599897A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5241A2820E7
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F4E1C6F45;
	Thu, 10 Oct 2024 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1J50lLp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F81BC9EE
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570196; cv=none; b=lNPoh6ze2J+bRZZDY2xQKLr7/0Cucz0nRG0IIYt7tl1k5SNd4BS9xX9ZH99pdCmEz9fn3vuqs1/t5LOLRQ1TDAEYtpOckElJbzy/4mom3hOpJSmRB0uOR5Svu76kxrUhPjwhvI8y4M2NJTDIPEGhBxtdm2PJHsqpbDX6kj9dckE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570196; c=relaxed/simple;
	bh=NzG7OmrTfLym3bLrrOLj9xE4SCbxC59P1KycO8/ZuSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VewFxo1/hs42OJgyr2YUOluZTw37/uQyve5ZbKT6DGrSHh4BBfI7dfYsc2LWN86/Qt9fF8ORww1AyPc8gqn3cc3GOxEjzrBHtKwky/ewiwQqMHItMrvwMjmrCkScbdgo+oXYK+cIWCOxf7sS76sC43oxgt6W4Ht1htbP4TPCENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1J50lLp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728570193; x=1760106193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzG7OmrTfLym3bLrrOLj9xE4SCbxC59P1KycO8/ZuSo=;
  b=i1J50lLpgM/Hw0nkgpVTrpQypwQgXY8uYyIwFlmskn767QdAid15rIzm
   +L7pwNGm2du1PkWACdBFNWQGIHleV/7JAEX5xgfwq1bf48zhNbicEEb+y
   Phcp0DrQ+RWFcooH5z7+x3FsF09Aii/5/NuomkKjllM9pKre0Mg0zbqXd
   8SvBZaMyyWRayMguOsuZxaCp/HA0qdmWyIud/9MVhXuqPwj4e0u21kRMp
   in0ehaoMOyfUpGhcUySGgSUV5BrKfb5aSpqLVOcz8wY4O1OEeerE3cWgp
   yrJrfAHxClmDd0PNnJpx4B9EY0vhEQ9WV/UNALDMJCx7/BC5N+4JeArM0
   A==;
X-CSE-ConnectionGUID: go024LmNQduPu0itsU2/9w==
X-CSE-MsgGUID: oZar8v+yTYeNTv7I756gXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39321097"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="39321097"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 07:23:13 -0700
X-CSE-ConnectionGUID: uNe607ZxTYWTdQc15UjXSA==
X-CSE-MsgGUID: DSf6JacQQj6j3XZXEGALyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="99937494"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa002.fm.intel.com with ESMTP; 10 Oct 2024 07:23:10 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-net 1/4] ice: Fix E825 initialization
Date: Thu, 10 Oct 2024 16:21:14 +0200
Message-ID: <20241010142254.2047150-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010142254.2047150-1-karol.kolacinski@intel.com>
References: <20241010142254.2047150-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation checks revision of all PHYs on all PFs, which is
incorrect and may result in initialization failure. Check only the
revision of the current PHY.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Removed net-next hunks

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 ++++++++-------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 ++-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a33e6b9b313..d9a3c7de0342 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2665,14 +2665,15 @@ static bool ice_is_muxed_topo(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_init_phy_e825c - initialize PHY parameters
+ * ice_ptp_init_phy_e825 - initialize PHY parameters
  * @hw: pointer to the HW struct
  */
-static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
+static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 {
 	struct ice_ptp_hw *ptp = &hw->ptp;
 	struct ice_eth56g_params *params;
-	u8 phy;
+	u32 phy_rev;
+	int err;
 
 	ptp->phy_model = ICE_PHY_ETH56G;
 	params = &ptp->phy.eth56g;
@@ -2686,16 +2687,9 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
 
 	ice_sb_access_ena_eth56g(hw, true);
-	for (phy = 0; phy < params->num_phys; phy++) {
-		u32 phy_rev;
-		int err;
-
-		err = ice_read_phy_eth56g(hw, phy, PHY_REG_REVISION, &phy_rev);
-		if (err || phy_rev != PHY_REVISION_ETH56G) {
-			ptp->phy_model = ICE_PHY_UNSUP;
-			return;
-		}
-	}
+	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
+	if (err || phy_rev != PHY_REVISION_ETH56G)
+		ptp->phy_model = ICE_PHY_UNSUP;
 
 	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
 }
@@ -5396,7 +5390,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	else if (ice_is_e810(hw))
 		ice_ptp_init_phy_e810(ptp);
 	else if (ice_is_e825c(hw))
-		ice_ptp_init_phy_e825c(hw);
+		ice_ptp_init_phy_e825(hw);
 	else
 		ptp->phy_model = ICE_PHY_UNSUP;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..35141198f261 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -326,7 +326,8 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
  */
 #define ICE_E810_PLL_FREQ		812500000
 #define ICE_PTP_NOMINAL_INCVAL_E810	0x13b13b13bULL
-#define E810_OUT_PROP_DELAY_NS 1
+#define ICE_E810_OUT_PROP_DELAY_NS	1
+#define ICE_E825_SYNC_DELAY		6
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
-- 
2.46.2


