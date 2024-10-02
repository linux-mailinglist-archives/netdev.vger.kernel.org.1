Return-Path: <netdev+bounces-131193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3C98D28E
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C431D1F2330C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950831EC012;
	Wed,  2 Oct 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx7xjT0E"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C720010D
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870003; cv=none; b=N4KwCrdE7L+r0T94gwe0crTUwHCldlojp8w8V0ogmgtRgilKeWC6c3HP8r4On0fd7dcd6MVLrMG06z3ygRhjHaDq+WBLEq4uO7mMmov6EVMk6lERyFPGVpRrxBwiP10x6JNniJO8U7rPhnYum8E0z10bpaEo2Bg+Jg/pkbbreis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870003; c=relaxed/simple;
	bh=SvXTULnSI2SizGjm07lIlC/a83Bu+y0MMMCyXo7mogM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS51jrDA0kdwECYj2XixXpmmF7+guR4W2S4Or1HMYjxUpXKZmHxPMakfe2ClFykyZX6Tj0rLpfrxCvouvVqgxvvHDh7IQfMtzseIpfmlUQhcPe5EJDoNbS8r96PpNpSY5NuZ5/TLViZmJvGZtQF1Z1q6O8cCQG4pUXQ175d9cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx7xjT0E; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727870002; x=1759406002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SvXTULnSI2SizGjm07lIlC/a83Bu+y0MMMCyXo7mogM=;
  b=Sx7xjT0ElSea4w2H4+QeevuktwwZRY8kApJXeYLZJmGvPFNEnZjpaWI2
   H5ViyOzpVfulO3GJTI1R05o/tctfihYwTzwDLY1xO9uN7edmhHmrMLv2N
   mmsvAbrgkR5fG/G2bKNNQZxE1wVg4HvlPgi3ccaSOvDohX8HTZXRvwHng
   IoOwdvpNWoBiV0cNvELswnBIgn5j5lQ+sCSqlmOHFIMKGciJBcF7wLz6Q
   BN6e0zRX6ELhG1IN1DjxYZJEgAtc8VTEq09LkyLKbVuCPTzQjNoRR/xHD
   dmfoepOMRLbOuUIWkCsLl4IAJGQOvjYkMkLg3cGA7mOb139SgSavYl3uI
   A==;
X-CSE-ConnectionGUID: 3n8UithPSxSNtriYFJLIow==
X-CSE-MsgGUID: gsclcPZjTX2iDAybfyQ0qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27183850"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="27183850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 04:53:20 -0700
X-CSE-ConnectionGUID: ZCKoxdE6RLuLh2zwd/wlIQ==
X-CSE-MsgGUID: 7re44d5KTUutxli8V8QBPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78396380"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 02 Oct 2024 04:53:17 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.21])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 02FF027BDE;
	Wed,  2 Oct 2024 12:53:15 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next 1/4] ice: c827: move wait for FW to ice_init_hw()
Date: Wed,  2 Oct 2024 13:50:21 +0200
Message-ID: <20241002115304.15127-7-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
References: <20241002115304.15127-6-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move call to ice_wait_for_fw() from ice_init_dev() into ice_init_hw(),
where it fits better. This requires also to move ice_wait_for_fw()
to ice_common.c.

ice_is_pf_c827() is now used only in ice_common.c, so it could be static.

CC: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.h |   1 -
 drivers/net/ethernet/intel/ice/ice_common.c | 110 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_main.c   |  37 -------
 3 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..3b739a7fe498 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -113,7 +113,6 @@ int
 ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 		    struct ice_aqc_get_phy_caps_data *caps,
 		    struct ice_sq_cd *cd);
-bool ice_is_pf_c827(struct ice_hw *hw);
 bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw);
 bool ice_is_clock_mux_in_netlist(struct ice_hw *hw);
 bool ice_is_cgu_in_netlist(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 009716a12a26..85057eb42545 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -307,6 +307,42 @@ bool ice_is_e825c(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_is_pf_c827 - check if pf contains c827 phy
+ * @hw: pointer to the hw struct
+ *
+ * Return: true if the device has c827 phy.
+ */
+static bool ice_is_pf_c827(struct ice_hw *hw)
+{
+	struct ice_aqc_get_link_topo cmd = {};
+	u8 node_part_number;
+	u16 node_handle;
+	int status;
+
+	if (hw->mac_type != ICE_MAC_E810)
+		return false;
+
+	if (hw->device_id != ICE_DEV_ID_E810C_QSFP)
+		return true;
+
+	cmd.addr.topo_params.node_type_ctx =
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_TYPE_M, ICE_AQC_LINK_TOPO_NODE_TYPE_PHY) |
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M, ICE_AQC_LINK_TOPO_NODE_CTX_PORT);
+	cmd.addr.topo_params.index = 0;
+
+	status = ice_aq_get_netlist_node(hw, &cmd, &node_part_number,
+					 &node_handle);
+
+	if (status || node_part_number != ICE_AQC_GET_LINK_TOPO_NODE_NR_C827)
+		return false;
+
+	if (node_handle == E810C_QSFP_C827_0_HANDLE || node_handle == E810C_QSFP_C827_1_HANDLE)
+		return true;
+
+	return false;
+}
+
 /**
  * ice_clear_pf_cfg - Clear PF configuration
  * @hw: pointer to the hardware structure
@@ -1021,6 +1057,33 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
 	}
 }
 
+/**
+ * ice_wait_for_fw - wait for full FW readiness
+ * @hw: pointer to the hardware structure
+ * @timeout: milliseconds that can elapse before timing out
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout.
+ */
+static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
+{
+	int fw_loading;
+	u32 elapsed = 0;
+
+	while (elapsed <= timeout) {
+		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
+
+		/* firmware was not yet loaded, we have to wait more */
+		if (fw_loading) {
+			elapsed += 100;
+			msleep(100);
+			continue;
+		}
+		return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
 /**
  * ice_init_hw - main hardware initialization routine
  * @hw: pointer to the hardware structure
@@ -1170,8 +1233,19 @@ int ice_init_hw(struct ice_hw *hw)
 	mutex_init(&hw->tnl_lock);
 	ice_init_chk_recipe_reuse_support(hw);
 
-	return 0;
+	/* Some cards require longer initialization times
+	 * due to necessity of loading FW from an external source.
+	 * This can take even half a minute.
+	 */
+	if (ice_is_pf_c827(hw)) {
+		status = ice_wait_for_fw(hw, 30000);
+		if (status) {
+			dev_err(ice_hw_to_dev(hw), "ice_wait_for_fw timed out");
+			goto err_unroll_fltr_mgmt_struct;
+		}
+	}
 
+	return 0;
 err_unroll_fltr_mgmt_struct:
 	ice_cleanup_fltr_mgmt_struct(hw);
 err_unroll_sched:
@@ -2684,40 +2758,6 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
 	ice_recalc_port_limited_caps(hw, &dev_p->common_cap);
 }
 
-/**
- * ice_is_pf_c827 - check if pf contains c827 phy
- * @hw: pointer to the hw struct
- */
-bool ice_is_pf_c827(struct ice_hw *hw)
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
  * ice_is_phy_rclk_in_netlist
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 2fafb56728b2..53479b729492 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4747,31 +4747,6 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
 	vsi->netdev = NULL;
 }
 
-/**
- * ice_wait_for_fw - wait for full FW readiness
- * @hw: pointer to the hardware structure
- * @timeout: milliseconds that can elapse before timing out
- */
-static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
-{
-	int fw_loading;
-	u32 elapsed = 0;
-
-	while (elapsed <= timeout) {
-		fw_loading = rd32(hw, GL_MNG_FWSM) & GL_MNG_FWSM_FW_LOADING_M;
-
-		/* firmware was not yet loaded, we have to wait more */
-		if (fw_loading) {
-			elapsed += 100;
-			msleep(100);
-			continue;
-		}
-		return 0;
-	}
-
-	return -ETIMEDOUT;
-}
-
 int ice_init_dev(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
@@ -4784,18 +4759,6 @@ int ice_init_dev(struct ice_pf *pf)
 		return err;
 	}
 
-	/* Some cards require longer initialization times
-	 * due to necessity of loading FW from an external source.
-	 * This can take even half a minute.
-	 */
-	if (ice_is_pf_c827(hw)) {
-		err = ice_wait_for_fw(hw, 30000);
-		if (err) {
-			dev_err(dev, "ice_wait_for_fw timed out");
-			return err;
-		}
-	}
-
 	ice_init_feature_support(pf);
 
 	err = ice_init_ddp_config(hw, pf);
-- 
2.46.0


