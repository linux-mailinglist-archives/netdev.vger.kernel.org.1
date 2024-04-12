Return-Path: <netdev+bounces-87383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B18A2F05
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA742834C5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE5633FE;
	Fri, 12 Apr 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VySv9DIt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADC95914B
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927490; cv=none; b=hgr7C5vzScv1X/rQULyblJgCwtUinwDjm+ir5pSGrIePOtuEPMSSW0QtytFt/yBPfAJz3y6C9JhKhpzlIemjkmwglrlOAyAs5ZHxhXbp16qR9vb3szWVbMZgFnZ1B4JhIzIYDjsrCmrOa/762k6vhKdbyOquafB7rjZVJLsYPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927490; c=relaxed/simple;
	bh=pjdW3rHfTH/ULFHjNp9yphnnD4pBVED7Ka/okI7hORI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q03jG+A28o4cxtUbhUP4hss0PxcXHXWSvxxVTxSB1MBtrIgVCFCcYyo94cnLU2o4IfKha6i9RW/e1ubdSSvOcUQ4nrGySxBdmp1TN6sVlFI4Gyo1cy1b3aaShxJ7Y/MYAJnw6zbYYp9YVUPAZs+E7P4sEOYs43yW4aHRTfb06eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VySv9DIt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927488; x=1744463488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pjdW3rHfTH/ULFHjNp9yphnnD4pBVED7Ka/okI7hORI=;
  b=VySv9DIt5Y0HORyjXAINWBb+dy3PJ1dxjMmQtF7BkefqPB10mASoe3NZ
   4byoK5FXFnX3Y/JelFfJD2BBZdgJGgO5MHmBwPjdHLlj5/8jCYVQPbsUN
   dv7lu6bkTFnN/Cpz87cAAWRfPuffdiJgK10zLp0I/7tcVbHxM/LdrwYBG
   akejp622LAyVA1gdFcOK07E1K7kdRbEkNp5vau8KQkcGHo5Z33YXB8bv2
   f811+xRUpFBe189Rzp8lfi4XPYj+okjoHOP6xuT0mx7AFumhqFT8Blbh2
   APBk9eV292jTDPOYW16kW9sHYbt/SSPg48MuJnsiJpJrg6Mlkzopfdg5s
   w==;
X-CSE-ConnectionGUID: 2ssa0Ku0Q4quqcOnFKyS+g==
X-CSE-MsgGUID: owv8hW4AQsapixGgbnQYIg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12230966"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12230966"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:11:18 -0700
X-CSE-ConnectionGUID: P9aeT+WgRl24NCMmHLTjew==
X-CSE-MsgGUID: bqqP+BDbRD+5/X2hCa5uHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52384887"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa001.fm.intel.com with ESMTP; 12 Apr 2024 06:11:16 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v8 iwl-next 04/12] ice: Add PHY OFFSET_READY register clearing
Date: Fri, 12 Apr 2024 15:06:47 +0200
Message-ID: <20240412131104.322851-18-karol.kolacinski@intel.com>
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

Add a possibility to mark all transmitted/received timestamps as invalid
by clearing PHY OFFSET_READY registers.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 11 ++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 32 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 18d5dff6b872..6899b331f322 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1930,11 +1930,14 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	struct ice_hw *hw = &pf->hw;
 	int err;
 
-	/* For Vernier mode, we need to recalibrate after new settime
-	 * Start with disabling timestamp block
+	/* For Vernier mode on E82X, we need to recalibrate after new settime.
+	 * Start with marking timestamps as invalid.
 	 */
-	if (pf->ptp.port.link_up)
-		ice_ptp_port_phy_stop(&pf->ptp.port);
+	if (hw->ptp.phy_model == ICE_PHY_E82X) {
+		err = ice_ptp_clear_phy_offset_ready_e82x(hw);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "Failed to mark timestamps as invalid before settime\n");
+	}
 
 	if (!ice_ptp_lock(hw)) {
 		err = -EBUSY;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index bd25ebd976bc..3c0efdd3cb8a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2405,6 +2405,38 @@ int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port)
 	return 0;
 }
 
+/**
+ * ice_ptp_clear_phy_offset_ready_e82x - Clear PHY TX_/RX_OFFSET_READY registers
+ * @hw: pointer to the HW struct
+ *
+ * Clear PHY TX_/RX_OFFSET_READY registers, effectively marking all transmitted
+ * and received timestamps as invalid.
+ */
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw)
+{
+	u8 port;
+
+	for (port = 0; port < hw->ptp.num_lports; port++) {
+		int err;
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_TX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY TX_OFFSET_READY register\n");
+			return err;
+		}
+
+		err = ice_write_phy_reg_e82x(hw, port, P_REG_RX_OR, 0);
+		if (err) {
+			dev_warn(ice_hw_to_dev(hw),
+				 "Failed to clear PHY RX_OFFSET_READY register\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * ice_read_phy_and_phc_time_e82x - Simultaneously capture PHC and PHY time
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 5645b20a9f87..5223e17d2806 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -208,6 +208,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time);
 int ice_ptp_write_incval(struct ice_hw *hw, u64 incval);
 int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj);
+int ice_ptp_clear_phy_offset_ready_e82x(struct ice_hw *hw);
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
 void ice_ptp_reset_ts_memory(struct ice_hw *hw);
-- 
2.43.0


