Return-Path: <netdev+bounces-229108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0FBBD844A
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D02424D79
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183428C864;
	Tue, 14 Oct 2025 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6NTbBs/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4E2E0B5F
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431695; cv=none; b=BubeiBXS4JMCZCAG9VwnkN/jGa34h/EocNY2vUCLUhQG9of6UlrHKGQmC7N3hVZO4aTP7sJtnOow2rjyHhFddB9ZK5YIpueEuBvZw8hPIGvCHzbklLM8O4awXH4fbJ1nZhzn5mslwZP4mJkBGmXp4Iu63PFDLM/rmVxZEJh1L8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431695; c=relaxed/simple;
	bh=OcJ2y8QL8cVOhDe3Y9UlXJ+LflkYfHbKKdnGQSd4CDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUYR8+a9IZVrRLHwZd0FpO1kRYXUzdkqYpUZ4+P0+cUXHDYhk3d+9yFXHGhLWZ/vBFyuRdszRZtCgWtTDzw4kZYd8aD429es91VVRxmBrvTBw7mIeqOO55FmJJx+FSWBZwOiGFWxBBx0WqndcTG4YK2P5uQGczH8nU0pApeGaHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6NTbBs/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760431694; x=1791967694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OcJ2y8QL8cVOhDe3Y9UlXJ+LflkYfHbKKdnGQSd4CDM=;
  b=k6NTbBs/Ws9FUe6q5zD36wxeYL0TIvdaYCQGmmPnGyKpo3m0YXPiTQad
   0vowF4Ibq8K9c9yK9crrTCKnzn+ZiSZfrfzWtXy0tz49t82NWLtJcup9h
   Gj7y+Xv9+jQicvha2hATw0f33L2+kEUy44fkJFjj9u+v4E2R9ooAopHFP
   3gLg06DjZyMBZHoM/irZPKAlXJBAdiQU2fTxrUTVw+zJpPbWnEp4eMjcH
   1Q4dMfK/+skn/0iGI+5k5C1a1w74rYZD4CkqnlviHPjmB3/aDymNk8QFh
   yYpZIEav2fcq3jeA2Rcr0lfoG+a28mNbStqkfJ+YJVbYf7w1cG0B+v39Z
   g==;
X-CSE-ConnectionGUID: 27/FofXmSBCzOoA+8ErGCQ==
X-CSE-MsgGUID: zEfp2t4TTqm9pjkqmcTEXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62682565"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62682565"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:48:13 -0700
X-CSE-ConnectionGUID: h3SI6kNBR3qBEhemCW+23Q==
X-CSE-MsgGUID: l9dD1XpRTaCfKlJNa9aVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182278908"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa008.fm.intel.com with ESMTP; 14 Oct 2025 01:48:12 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next] ice: unify PHY FW loading status handler for E800 devices
Date: Tue, 14 Oct 2025 10:46:18 +0200
Message-Id: <20251014084618.2746755-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify handling of PHY firmware load delays across all E800 family
devices. There is an existing mechanism to poll GL_MNG_FWSM_FW_LOADING_M
bit of GL_MNG_FWSM register in order to verify whether PHY FW loading
completed or not. Previously, this logic was limited to E827 variants
only.

Also, inform a user of possible delay in initialization process, by
dumping informational message in dmesg log.

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 81 ++++++---------------
 1 file changed, 24 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 8e56354332ad..d05d371a9944 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -203,42 +203,6 @@ bool ice_is_generic_mac(struct ice_hw *hw)
 		hw->mac_type == ICE_MAC_GENERIC_3K_E825);
 }
 
-/**
- * ice_is_pf_c827 - check if pf contains c827 phy
- * @hw: pointer to the hw struct
- *
- * Return: true if the device has c827 phy.
- */
-static bool ice_is_pf_c827(struct ice_hw *hw)
-{
-	struct ice_aqc_get_link_topo cmd = {};
-	u8 node_part_number;
-	u16 node_handle;
-	int status;
-
-	if (hw->mac_type != ICE_MAC_E810)
-		return false;
-
-	if (hw->device_id != ICE_DEV_ID_E810C_QSFP)
-		return true;
-
-	cmd.addr.topo_params.node_type_ctx =
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY) |
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ICE_AQC_LINK_TOPO_NODE_CTX_PORT);
-	cmd.addr.topo_params.index = 0;
-
-	status = ice_aq_get_netlist_node(hw, &cmd, &node_part_number,
-					 &node_handle);
-
-	if (status || node_part_number != ICE_AQC_GET_LINK_TOPO_NODE_NR_C827)
-		return false;
-
-	if (node_handle == E810C_QSFP_C827_0_HANDLE || node_handle == E810C_QSFP_C827_1_HANDLE)
-		return true;
-
-	return false;
-}
-
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
@@ -958,30 +922,35 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
 }
 
 /**
- * ice_wait_for_fw - wait for full FW readiness
+ * ice_wait_fw_load - wait for PHY firmware loading to complete
  * @hw: pointer to the hardware structure
  * @timeout: milliseconds that can elapse before timing out
  *
- * Return: 0 on success, -ETIMEDOUT on timeout.
+ * On some cards, FW can load longer than usual,
+ * and could still not be ready before link is turned on.
+ * In these cases, we should wait until all's loaded.
+ *
+ * Return:
+ * * 0 on success (FW load is completed)
+ * * negative - on timeout
  */
-static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
+static int ice_wait_fw_load(struct ice_hw *hw, u32 timeout)
 {
-	int fw_loading;
-	u32 elapsed = 0;
+	int fw_loading_reg;
 
-	while (elapsed <= timeout) {
-		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+	if (!timeout)
+		return 0;
 
-		/* firmware was not yet loaded, we have to wait more */
-		if (fw_loading) {
-			elapsed += 100;
-			msleep(100);
-			continue;
-		}
+	fw_loading_reg = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+	/* notify the user only once if PHY FW is still loading */
+	if (fw_loading_reg)
+		dev_info(ice_hw_to_dev(hw), "Link initialization is blocked by PHY FW initialization. Link initialization will continue after PHY FW initialization completes.\n");
+	else
 		return 0;
-	}
 
-	return -ETIMEDOUT;
+	return rd32_poll_timeout(hw, GL_MNG_FWSM, fw_loading_reg,
+				 !(fw_loading_reg & GL_MNG_FWSM_FW_LOADING_M),
+				 10000, timeout * 1000);
 }
 
 static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
@@ -1171,12 +1140,10 @@ int ice_init_hw(struct ice_hw *hw)
 	 * due to necessity of loading FW from an external source.
 	 * This can take even half a minute.
 	 */
-	if (ice_is_pf_c827(hw)) {
-		status = ice_wait_for_fw(hw, 30000);
-		if (status) {
-			dev_err(ice_hw_to_dev(hw), "ice_wait_for_fw timed out");
-			goto err_unroll_fltr_mgmt_struct;
-		}
+	status = ice_wait_fw_load(hw, 30000);
+	if (status) {
+		dev_err(ice_hw_to_dev(hw), "ice_wait_fw_load timed out");
+		goto err_unroll_fltr_mgmt_struct;
 	}
 
 	hw->lane_num = ice_get_phy_lane_number(hw);

base-commit: cbbc9ad6caed63e32e8a4b10001b041f7294ffa6
-- 
2.39.3


