Return-Path: <netdev+bounces-82783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C788FBB1
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 10:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EEC1C2E62A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22937BB0D;
	Thu, 28 Mar 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxsdBhiz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37595FBB5
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618467; cv=none; b=P5Cqkir2XcThtTDbZM0xavc6YiTvnoyZ1/gNpqW0aEYcteRVz2aYf2O2djSKSjIzAniP6arjfnmG/HqghFVMO+v/wHBv22khDQfwO4DPixyXnYi8h0sF0bh9Tx0tcmPZbejKjev7yp1kS1imkxA8t07OcOPgwh1n0BscgcPrxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618467; c=relaxed/simple;
	bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwiU/k8MXACb8r7VV9PbltpAykh4hfCsS5Sp2rWOPqnfEHlGni3NYEBTup/oSVPAhPOXbQDxBzL40NUkJgtGQ24jQFiqZOVz+dWpUph+kdv7ftmRrDDNfvnGVc9hlDUoBH/h/oewo5kHPMGhGWBE6Mtd363qY+CDweY7zRbNw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxsdBhiz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711618466; x=1743154466;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERHAALLSA2vzNMYtvNj4cUg4n40CUGxACTCDlBu/TEw=;
  b=MxsdBhiznfz7oVrcBiNPkGRFkXeQ4A+mjFx399Zz68d2fh1yUJak/Ple
   wxTnshwB6g7QRJMK30DunO8oeAD31bibnqwAciVEseURnlq53FYtBivf4
   tKqDtUIH/wiuM8ezjBDDvbSXNFxHosmue/xFsf/rqE9hUe/BGd2njDZmB
   lH/yAMtQHS8U+HeRT0zhw9ccpjR7+E/6BLXbdRQ7on//zkVGXE0EPd1Bx
   Wxwi48LV+ETIgp5fjG1K0duEthSpUmRCjLYxvHzF+P9VUhVdOXCKrCb68
   kndSNo/SBfkYeo82AhD5d1rCYD+1/VReVQU9OqtY2ocSHvBqVpnNOEF1n
   A==;
X-CSE-ConnectionGUID: 6gWs9ca5TwmATlSfKIIbPw==
X-CSE-MsgGUID: dK5+F2sxSpGTq4tjE43OBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6952658"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6952658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 02:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="21276577"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 28 Mar 2024 02:34:23 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 06/12] ice: Introduce ice_get_base_incval() helper
Date: Thu, 28 Mar 2024 10:25:24 +0100
Message-ID: <20240328093405.336378-20-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240328093405.336378-14-karol.kolacinski@intel.com>
References: <20240328093405.336378-14-karol.kolacinski@intel.com>
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


