Return-Path: <netdev+bounces-83255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E124689179D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96EB61F22BD5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287BE6A8D1;
	Fri, 29 Mar 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wes5IGse"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8CC6A33A
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711440; cv=none; b=VJ6g5dOyCkjCCwtxVk+fO5xB3fQoFoodmlfTvXtBdskyhlmGK+uFXFCUjCf+k13UIC/TFQzRghCVBvChXIjOeZYLgHElCGCGYTyFOIKoW6db3bDfGfRooqEWJSx1AEAleIpHRyfU3h8lwD06Zhbq92VVPQQClbpYi7F0Ue+aZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711440; c=relaxed/simple;
	bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFlEfeAcnwoQdS5WtcbVmqEP7TJZIVsDqdobSFVXZYX44xjvsvqUK3G74DA799mQjh31VNOlqIJ9WtQlFaMnEPtMzbWsUL88Amo+fMnEIB9Tsu5BKCDkwd07nFtQxEnk6+osE8XGxujsA0++FtNetYAgnEvelG2WRX6W0NwPvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wes5IGse; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711438; x=1743247438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
  b=Wes5IGse5cyPycx5HRkaPDsMJTtJZfL4frtnUMY03n5Aj2zyTbTfw6rt
   o+nE6AhcQk8q9DS9R3pD65D5amOP1a7pX5Og/xEgVMY78ODt4wZ+yPRho
   uFD0uW0PF76XDhUntqWNSZ8ofBm8X13vTOgM291WbEYGY0ebVxlLTAnSi
   1zNSvkyj44dLFuXzCcOAauly65zFL1D2CO6SyKieqBTAfQmMV0dImdN9A
   kVCs0gHmO/bVkHE+xiMqJwwSGxjEeaJDXxJ5OEBeVj45bNWwNOWD6zpMv
   bW+XpO5NchAFBYFwzVo7doGIGjs5t4NvysMp376Oeao0f6qKURAFat/pI
   w==;
X-CSE-ConnectionGUID: tWXhw6mfS32V4VJmaZP4qw==
X-CSE-MsgGUID: E0vYu99/QQWcNhjf5xX0rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755188"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6755188"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16836719"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2024 04:23:56 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Fri, 29 Mar 2024 12:21:50 +0100
Message-ID: <20240329112339.29642-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329112339.29642-14-karol.kolacinski@intel.com>
References: <20240329112339.29642-14-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  7 +------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7980482bbf56..cd2dab7b4c44 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1210,12 +1210,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
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
index 5223e17d2806..d477d334b1d8 100644
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


