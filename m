Return-Path: <netdev+bounces-139665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BDC9B3C35
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F49281085
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6001DEFC6;
	Mon, 28 Oct 2024 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQkCpjVf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B02185B54
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148562; cv=none; b=rKpvGal0ZHVH7XDWQugelzFP0dNnivHBLjgOsPnUAqVDmEWRo37O9ltG5SIG6N/0BxAmmQggPNHYaBWA4Da1mH6B1zyolMKqsu5XxrbcJ4f2Ka6PI3sjA4IqSIOx+PH/8fdnwkYw0FMp3+ch9lm4j78J/PfJByHTj6QeQCBWlAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148562; c=relaxed/simple;
	bh=7ghW+xE+c9QLCqFh2ZVaOVAhXdPDBirVKjPLZGFGUE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d7uvqlsb+3q0KPMoBlwV64NzyNRzyNNrom/SASIJ+2pO0blP6nmUUIQO9Z5meqXVNcPUeucl1rOQVE4kHUUpqsHQlvDelSzd/zCuz9vAiXPYQd1a+wyvwlR+5n3d556ITh1a7hxerKCU3uUxtmZyTX8PKjoEX44FNVYMzH2uiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQkCpjVf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148561; x=1761684561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ghW+xE+c9QLCqFh2ZVaOVAhXdPDBirVKjPLZGFGUE0=;
  b=TQkCpjVfrU713Da6u9nVJHVDpaJcxayEd41kGnuo9J/fQCbFu5fBtfuS
   a2BP0x6vVtsT0UHAthNqCL/i6JOyXXW5hEOjUpixDw3YlMqV/Er3JYZmx
   X1QFNkAmtNKV3f1JxY6UWlXGfUK7Zd2anJK7XOKSJp/Tyy1PRahBA79X+
   391E+n9NsmhEpNGjeaGSbBUwJkXTBfi4qEY+X59jc7qT+ZNZVOLL9PLpy
   iR0Yo6iqqox1KHxGQN5xXPomt8bYo6PYIBkB/3gq5fi+0TCwQaAiVrKSL
   ny7LX7slmhtxVkxGVqvA0UlaO1NWd5FiPi57PA13cXInKZNihm1qQ/mah
   Q==;
X-CSE-ConnectionGUID: S6zxBth3TTG2Vv3x/G418Q==
X-CSE-MsgGUID: HPO4QksCQYeO+6s47CclFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="33685551"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="33685551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:49:20 -0700
X-CSE-ConnectionGUID: b3UvyK7mQHWPi5/6i+/kfA==
X-CSE-MsgGUID: ddxUVmhqT6aroPde34E2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="86529899"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 28 Oct 2024 13:49:18 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-net 1/4] ice: Fix E825 initialization
Date: Mon, 28 Oct 2024 21:45:40 +0100
Message-Id: <20241028204543.606371-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028204543.606371-1-grzegorz.nitka@intel.com>
References: <20241028204543.606371-1-grzegorz.nitka@intel.com>
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
---
V1 -> V2: Removed net-next hunks,
	  add 'return' on PHY revision read failure
V1 -> V2: Removed net-next hunks

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 +++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index ec8db830ac73..d27b2f52b5ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2663,14 +2663,15 @@ static bool ice_is_muxed_topo(struct ice_hw *hw)
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
@@ -2684,15 +2685,10 @@ static void ice_ptp_init_phy_e825c(struct ice_hw *hw)
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
@@ -5394,7 +5390,7 @@ void ice_ptp_init_hw(struct ice_hw *hw)
 	else if (ice_is_e810(hw))
 		ice_ptp_init_phy_e810(ptp);
 	else if (ice_is_e825c(hw))
-		ice_ptp_init_phy_e825c(hw);
+		ice_ptp_init_phy_e825(hw);
 	else
 		ptp->phy_model = ICE_PHY_UNSUP;
 }
-- 
2.39.3


