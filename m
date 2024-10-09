Return-Path: <netdev+bounces-133736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF50996D24
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F008428561A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715381A0BCA;
	Wed,  9 Oct 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LaSkzlmt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23D1A01C6
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482553; cv=none; b=StaEi2hHdg4gD7V9/VBOBFAG3nWMCS/R5TpWIHCsxALNwspfE9N8iCsF/IDs3QRXx34OsKkIiQRg4Y0qYhXxia/0cLwg5X6SrR3vbAuSlWmuCEHyQjFQ2EcWD+645zJG6BMaD7kY1nif7zWYr7iY20/QjfwMdJepTuja509Xk1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482553; c=relaxed/simple;
	bh=NzG7OmrTfLym3bLrrOLj9xE4SCbxC59P1KycO8/ZuSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah1ugwCygFWD9LINQ5FOBSqrrLa+/75fhCglOlLUbm833RPTIGw3Ytn7Vz040/07earL8xKjAWYscfdCSlX2oLRaJ0X0FJzis2sIkePhq/GneyN0phIKVjQyk9xgMTkHxVOgKLHfQOr3kc4im5X2aKfP4qyyfzm+485e06i3ugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LaSkzlmt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482551; x=1760018551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzG7OmrTfLym3bLrrOLj9xE4SCbxC59P1KycO8/ZuSo=;
  b=LaSkzlmtiKeAtkhdfPLM+Ud0Hc+5PjX9zvZwcN9lVE2dXPaLlqI/dwt4
   rRmrvZZBo5g7Cj4yu3MCj5dCfGhSq75olq7yS5wa6WJ12jT+ygqo9bQH3
   lNkzRgFMdklvRsxYwIYupCpIP1aPAbDU8OW6tIwhJ4PXvdTqHL8mPotuQ
   /fIAms3Q2rsP1BhFkXPQioWUBP84K1XKSHaaNV0Ueo6QyYSbgjULwJ7ql
   ufP9om2jFHv0fX7tIhZNZwf3cGQEZ4X3a9BCuL36sUT1TXkj7dIGOIdE+
   sclQuOqA3eMqKFX/1Ds9LvmEckhddCYBK+0eqFvimtCoJyUDxkCqebS7S
   g==;
X-CSE-ConnectionGUID: QMKRAPZJSNOCEP1EDY9jWw==
X-CSE-MsgGUID: 7g+QU7loQJaZ9kmMB0EduQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31483932"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31483932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:02:31 -0700
X-CSE-ConnectionGUID: sF4ot5/aTym5EY2h3tIkYA==
X-CSE-MsgGUID: DrwpK6FzTqmU5GjUxheC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76210750"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 07:02:30 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v2 iwl-next 1/4] ice: Fix E825 initialization
Date: Wed,  9 Oct 2024 15:59:26 +0200
Message-ID: <20241009140223.1918687-2-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009140223.1918687-1-karol.kolacinski@intel.com>
References: <20241009140223.1918687-1-karol.kolacinski@intel.com>
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


