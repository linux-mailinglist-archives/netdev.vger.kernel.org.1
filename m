Return-Path: <netdev+bounces-85701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B889BDF7
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CFB2819E4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF68669D36;
	Mon,  8 Apr 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h7w/hhkU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F8651B3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575113; cv=none; b=YjHs1tvdvSPK+BfNiek74RRKm0BjvACIVkd5PpAx+8Y7qcDw+3cGnxMiMeXt1iQmfEfpXe3n92yeq9Dwt3r0WZ8Z2uzll1SuaKwS/0CDw2w66/t1K7ZB2K9DVQSxp4sLY5NcE3Egsn4+P12cbuTnSoDw+qc002m97LwnOfnhLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575113; c=relaxed/simple;
	bh=EDP/v5xXtSkV1N6Kc62noURJd38e2/GkI2l5z25K0HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLquyw4zlkril0wMGMFfQ+dfklKbx/lXbqduWsM85yjEQev7BCcGISCLQnPOwBgLaLHjuEMmOtDeJeeI6gnDbvMB5kfCo/2u/OKexM8THcPIb8/Usc+RmHLYomImdYEfl88v9QemkGXxKlW1yM/2i3sgj0zEFFnucUe9S/vTC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7w/hhkU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712575112; x=1744111112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EDP/v5xXtSkV1N6Kc62noURJd38e2/GkI2l5z25K0HY=;
  b=h7w/hhkUsttOMni+VdsZjc1Gj33irzjuLZcAp5Td8yz6YOUrQfahnrQv
   vuZk6CyadW/kjAGAr+48+irO417dwnrNzIqSyq79VcbfmSHx7FU02Ffui
   6EZ8jEaLc9QBmU+uJBAJHA3SmKaNARS1shviMA8RlvRK3hhcUDZDR3aPa
   2Se2ZJfH73SSQyUyHrA8elJqxAS+794iB/JfWhMtpzTqLqJSbTiVRr9bl
   9ahnvi+KEZwQf7k3xFQZLnyj+xyhSBOweoC6o75CNaJ+UtkYzvd4AWAPP
   o82V2jzPTm4dVHtbf2PNABZSluVl2DS2cSak/YGTE46pTeqjZ7sxcXLw4
   A==;
X-CSE-ConnectionGUID: e9YJi22CQ/SIJh6csLhDbA==
X-CSE-MsgGUID: 84DI/rn6R3Kya1upaQFXVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18988566"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18988566"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:18:32 -0700
X-CSE-ConnectionGUID: X2dks8SvQFSwZjM0HbN6Vw==
X-CSE-MsgGUID: /wf85y9DSpKTAnoRp/M1Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19904907"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2024 04:18:29 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Mon,  8 Apr 2024 13:07:27 +0200
Message-ID: <20240408111814.404583-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240408111814.404583-14-karol.kolacinski@intel.com>
References: <20240408111814.404583-14-karol.kolacinski@intel.com>
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
index 48c0bc179110..f10ddf598f58 100644
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


