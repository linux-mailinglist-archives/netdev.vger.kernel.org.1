Return-Path: <netdev+bounces-157835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57413A0BFCA
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 19:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA3E162CB8
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CF1C3C17;
	Mon, 13 Jan 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxzp4ze4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A63D1C1F15
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736792939; cv=none; b=oPw1dVL97jUinxriPUw27tNWOzSo7qZCdnek+zA/rDFtl+SQ5ixxl15SOeJmDHJ5wbkGytYPa3XTNHPaeFn9gZLbz1MQJUiDaTfmrvy80RBi6yHo8vytGSdOUAxLoFOak8OgTAADPk2RrGRSWd5VryboPtwtp/kXcL7/vElIW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736792939; c=relaxed/simple;
	bh=gy8DNfvrP3H9TfRLfc/Kf+IX+YMa0Fs3L1UxJosU9bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okzkKlQVlSVeWdoTi7p+TJt2sJP1qGxb73kYHzeDAfRf7aTT3HBCkN4MKl84HdcufXHxbxdGHauUCeywskN8gVjPOECySTIvywMsW02oLy8Lo9K5jqVw3I0k4Pe9NUe7VEFvYmSN3RJe9QMQUdH6bbxJ+Lurs1X6RtLmkhAviC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxzp4ze4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736792938; x=1768328938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gy8DNfvrP3H9TfRLfc/Kf+IX+YMa0Fs3L1UxJosU9bY=;
  b=kxzp4ze4hBtHKoz6vaC9/CsFni3CtMfZTGvVEgP7KRieeTV93CB969m3
   szRC1yyUK2dFw7+sPOTUekt6ykE+DNKCdDFmKu+g2EsG5JdFcMgOo64Np
   HKOUEUNda3Cik29RVaRuxJRI8DrNW3hWZMqABloKgA4OfhhFJ14hJV9o9
   tl1F6oSbzqXYMKPze9YEqwZEHxa9dkMtLywEyPQ0BOju0kJ+Ca67tVlEG
   4dkrpyib97pMHJOhjNSuGkyNeACrzJVaKvf9l+o1eRjQ1/XDUk2DcZBVg
   6uHMBumfxTRc7VbiDVuPcXVqhZR+2fEmItW5BkILjOI8TDSdCR0wzy9nK
   w==;
X-CSE-ConnectionGUID: DIA3lVcXReCeRM3Uajry8w==
X-CSE-MsgGUID: +KEn1QpIR36RLSSveeY1Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48483079"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48483079"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 10:28:56 -0800
X-CSE-ConnectionGUID: WR0hS95wSou7p7rcFxg86Q==
X-CSE-MsgGUID: qJKYo3cDTgCxv2eu5Ql93Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104333253"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 13 Jan 2025 10:28:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net v2 1/4] ice: Fix E825 initialization
Date: Mon, 13 Jan 2025 10:28:33 -0800
Message-ID: <20250113182840.3564250-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
References: <20250113182840.3564250-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Current implementation checks revision of all PHYs on all PFs, which is
incorrect and may result in initialization failure. Check only the
revision of the current PHY.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 518893f23372..a5e4c6d8bfd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2687,14 +2687,15 @@ static bool ice_is_muxed_topo(struct ice_hw *hw)
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
@@ -2708,15 +2709,10 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
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
+	err = ice_read_phy_eth56g(hw, hw->pf_id, PHY_REG_REVISION, &phy_rev);
+	if (err || phy_rev != PHY_REVISION_ETH56G) {
+		ptp->phy_model = ICE_PHY_UNSUP;
+		return;
 	}
 
 	ptp->is_2x50g_muxed_topo = ice_is_muxed_topo(hw);
@@ -5478,7 +5474,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	else if (ice_is_e810(hw))
 		ice_ptp_init_phy_e810(ptp);
 	else if (ice_is_e825c(hw))
-		ice_ptp_init_phy_e825c(hw);
+		ice_ptp_init_phy_e825(hw);
 	else
 		ptp->phy_model = ICE_PHY_UNSUP;
 }
-- 
2.47.1


