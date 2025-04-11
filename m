Return-Path: <netdev+bounces-181777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02928A86779
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52E69A7E4E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E106293B72;
	Fri, 11 Apr 2025 20:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/T71H0o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C6290091
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404253; cv=none; b=c1zhw1SS84sr7SmLSHhtkQQTg6YgsB5p62wVmXyuyxCG6tNyIw/dj20pAa0BLUVO/h/leeq4mTxduMp8oY4q0KIA76xUNYaBsJinodSyhxP3a2H+pD5Q+tIZLg0z8wDvD3TcY+4q5/e7pJEb7e9A+npUHi09uYGo3siWkrkorus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404253; c=relaxed/simple;
	bh=MzXhv1BgX5pMdDvA0EsUy5FtRhOGQxsAjaVw61tomyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks2ns4dt7ATf82+4NyXAGB7OiFMQGMPhN67ctqtvQF9wMhAzmIOg9V6/xBF5M54o/cvxOJRUnxWM4/fEZh6OasQxvfoM99HYdlvJUhbRxF+91R21ee6k6YykKvvvFn0FsWFWKnlnFKpghMwLHK7VhgqTuKlmyTrCFEQBON8DBK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/T71H0o; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404251; x=1775940251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzXhv1BgX5pMdDvA0EsUy5FtRhOGQxsAjaVw61tomyo=;
  b=M/T71H0oMf9CPXwt5NSrOZA/ZpJ9aqlJtx5M9CIg7PE0a1pMr7sA/SiZ
   qo875nnQjdIObWZ7aa9rc4xQI7htXD5A2+6XI1qEz2OuH5ugjm9LN/ajF
   kWV4rSiSZW8u2sxDXE+wdGGfdJ9S0eWcHt6/Ft8BwaHS+u0ek/4PQkuXr
   /zc8ubZCzJFq3fea8fIpDMfSFR46Cd/IAdhDlscGnir+EiUCdgVpsFvXK
   9zOTSb5ms93/RyLnVCUCOBqsz8JIafogN5heYMTnBP5swzwQF7OLfWn0J
   EuSJuowexKadaPhQyD/iijlA7kQQA5WM8UjOzUyi7yPMwG5xWST+wyAn9
   Q==;
X-CSE-ConnectionGUID: BOyAzwL6QgiTRGaMMI7oqw==
X-CSE-MsgGUID: cIx7xJlFRguF4zmc/WU7Jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103881"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103881"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:07 -0700
X-CSE-ConnectionGUID: b1n1xKV3SwyyyNscm3up8A==
X-CSE-MsgGUID: hQlGNHHMQuK0s8Yz3hb5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241814"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:06 -0700
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 07/15] ice: remove SW side band access workaround for E825
Date: Fri, 11 Apr 2025 13:43:48 -0700
Message-ID: <20250411204401.3271306-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Due to the bug in FW/NVM autoload mechanism (wrong default
SB_REM_DEV_CTL register settings), the access to peer PHY and CGU
clients was disabled by default.

As the workaround solution, the register value was overwritten by the
driver at the probe or reset handling.
Remove workaround as it's not needed anymore. The fix in autoload
procedure has been provided with NVM 3.80 version.

NOTE: at the time the fix was provided in NVM, the E825C product was
not officially available on the market, so it's not expected this change
will cause regression when running with older driver/kernel versions.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 ---------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 89bb8461284a..a5df081ffc19 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2630,25 +2630,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_sb_access_ena_eth56g - Enable SB devices (PHY and others) access
- * @hw: pointer to HW struct
- * @enable: Enable or disable access
- *
- * Enable sideband devices (PHY and others) access.
- */
-static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
-{
-	u32 val = rd32(hw, PF_SB_REM_DEV_CTL);
-
-	if (enable)
-		val |= BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1);
-	else
-		val &= ~(BIT(eth56g_phy_0) | BIT(cgu) | BIT(eth56g_phy_1));
-
-	wr32(hw, PF_SB_REM_DEV_CTL, val);
-}
-
 /**
  * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
@@ -2659,8 +2640,6 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
  */
 static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
-	ice_sb_access_ena_eth56g(hw, true);
-
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -2747,8 +2726,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
-
-	ice_sb_access_ena_eth56g(hw, true);
 }
 
 /* E822 family functions
-- 
2.47.1


