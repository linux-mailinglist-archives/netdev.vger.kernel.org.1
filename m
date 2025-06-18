Return-Path: <netdev+bounces-199184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079FADF4F6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF233A6C0A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA563085C0;
	Wed, 18 Jun 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtTwf4dF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77082FCFDC
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268578; cv=none; b=ApD1JfgvLHYbgrf0IVMGPwHMfbvre5vxBKDUDqfcokacMAFTlaQNaAXc+T8l9fIiuaZMvdvVc+3xJNNLPpdACghC3e+EX1E7PeHFXBYROrtRUwNDiKMHlHXaXr0mc+opjN4DFjT7Qt1dsjEcQ60/LHPvVJPNjwvJT+tcT7Hf3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268578; c=relaxed/simple;
	bh=swlQhBZDk66eMFsi4fM7Mp0swjNYIIzdhSAKvJ3xsuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4rXImf0LqzUHjlvUjZ2Hc5ln70w+14vP6ta54w31v+9e/AEM0Mndj8+1bh57cQXgcX+YmM22WI13Lb0Fm4ycDfeYBqTt4iioyGM0pxYJu5DvbO+9InKmL5OvRQODh0EVdK9xYAFPD0tCD47NgJrb0QOj6RycDLd9oWgwBS16WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtTwf4dF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268576; x=1781804576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swlQhBZDk66eMFsi4fM7Mp0swjNYIIzdhSAKvJ3xsuA=;
  b=QtTwf4dFQm+dCTpBWDFXSVQqL2OyBNhFLCzLwL8JLROd5bwhg0PszBel
   qo2o+JyGGXY2OMk9d1b880YhTnPJOrZaPedNlCNZw0sSLUCka572OsWYG
   Cv5dPrftB2Tmxre7/Lqn8AIrNdtOAthhVaQ8B8n/+++83q138BZcZDpVn
   6XZGZQG7hq5bOgIgtY6Pcb8Ujt8RFNPECXjPOBOsD9M+JE7hEcKPTrpCy
   50NMxnMY5O1M8mg9kMzzICKFXiMteYpGgohREJjmvFEpr+9Z9ksC7+EdN
   MDejcAOfxA1fjtAiuLxUkNoGdgVSnxvrqhhee0xEDAlnjFL46DN4atG73
   g==;
X-CSE-ConnectionGUID: vvW+KNpCQMabt00Pz1UifA==
X-CSE-MsgGUID: zec46i3NTKu4HLWp4AojvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183770"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183770"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:54 -0700
X-CSE-ConnectionGUID: en01iuPNQaeZv9cvFlgMJQ==
X-CSE-MsgGUID: 0FUbtE4TTdyWgy1zGd+0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149696026"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 14/15] ice: move TSPLL init calls to ice_ptp.c
Date: Wed, 18 Jun 2025 10:42:26 -0700
Message-ID: <20250618174231.3100231-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Initialize TSPLL after initializing PHC in ice_ptp.c instead of calling
for each product in PHC init in ice_ptp_hw.c.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 +++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 22 +--------------------
 drivers/net/ethernet/intel/ice/ice_tspll.c  |  5 +++++
 3 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b8cf8d64aaaa..e7005d757477 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2892,6 +2892,10 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	if (err)
 		return err;
 
+	err = ice_tspll_init(hw);
+	if (err)
+		return err;
+
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
@@ -3059,6 +3063,13 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 		return err;
 	}
 
+	err = ice_tspll_init(hw);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "Failed to initialize CGU, status %d\n",
+			err);
+		return err;
+	}
+
 	/* Acquire the global hardware lock */
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 278231443546..e8e439fd64a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2115,20 +2115,6 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
-/**
- * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
- * @hw: pointer to HW struct
- *
- * Perform E825-specific PTP hardware clock initialization steps.
- *
- * Return: 0 on success, negative error code otherwise.
- */
-static int ice_ptp_init_phc_e825(struct ice_hw *hw)
-{
-	/* Initialize the Clock Generation Unit */
-	return ice_tspll_init(hw);
-}
-
 /**
  * ice_ptp_read_tx_hwtstamp_status_eth56g - Get TX timestamp status
  * @hw: pointer to the HW struct
@@ -2788,7 +2774,6 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
  */
 static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 {
-	int err;
 	u32 val;
 
 	/* Enable reading switch and PHY registers over the sideband queue */
@@ -2798,11 +2783,6 @@ static int ice_ptp_init_phc_e82x(struct ice_hw *hw)
 	val |= (PF_SB_REM_DEV_CTL_SWITCH_READ | PF_SB_REM_DEV_CTL_PHY0);
 	wr32(hw, PF_SB_REM_DEV_CTL, val);
 
-	/* Initialize the Clock Generation Unit */
-	err = ice_tspll_init(hw);
-	if (err)
-		return err;
-
 	/* Set window length for all the ports */
 	return ice_ptp_set_vernier_wl(hw);
 }
@@ -5584,7 +5564,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_phc_e825(hw);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 7b61e1afe8b4..8f125ea5a80f 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -484,6 +484,11 @@ int ice_tspll_init(struct ice_hw *hw)
 	enum ice_clk_src clk_src;
 	int err;
 
+	/* Only E822, E823 and E825 products support TSPLL */
+	if (hw->mac_type != ICE_MAC_GENERIC &&
+	    hw->mac_type != ICE_MAC_GENERIC_3K_E825)
+		return 0;
+
 	tspll_freq = (enum ice_tspll_freq)ts_info->time_ref;
 	clk_src = (enum ice_clk_src)ts_info->clk_src;
 	if (!ice_tspll_check_params(hw, tspll_freq, clk_src))
-- 
2.47.1


