Return-Path: <netdev+bounces-158305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE43A115DC
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B651E3A67A0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89382111;
	Wed, 15 Jan 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imc5WCBz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AF17E0
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899734; cv=none; b=j1DhI19GyyvzmF84fEwhNLzAhUYwQVVlyp5bWM18e5yjZHDhqX8bYh5HZPWizxNS0jw01SBXND1ZG0DNofJDFzZKS8R+BRyzLLO4ym7auyISsNf5sxMbzK4ru4V+vN+cPaeotD/UrMy0MKfrFRM/5/G7B5/ACVAxTILFF/GXj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899734; c=relaxed/simple;
	bh=bXniPzm/gtPar/ae3lHJz9Rx8+uJEpfOfBqw4iXTgr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYUVAGbxNlJ5JGab6wpC9vSKhVs0xYt8KazYbaFpkGzIYDNoKLFLn2TCOUlY16OnY7Y2TGZKtxc527KpRYlSwwbc2RtSxArrXXIFTQg+82iMqXHLvuXFhnSv+ZQhvxJbf8Undc/5061yBz7v7iChKGZuoMmwD3JMPYwWT3oKMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imc5WCBz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899733; x=1768435733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXniPzm/gtPar/ae3lHJz9Rx8+uJEpfOfBqw4iXTgr8=;
  b=imc5WCBzYaxKq+U5N6CktUyY9WVe5fZlYEcfpHqCtc7BwBrZ41ZPm7t1
   oEPbFHVqWs/UDuut3zG13lDkp2isdd9UzJWSBC2YJpTG/ca7WQDS25GsV
   RLpQQJySenf9nn1HTJvAF+8P5XzIWkHjD7v0d51awE49/TQ2zwM1AjVGS
   WeFdyQkBIaa5cgQUoXQ9zt43bXVNeseehJvWq5A4xYrEq+agIi7oOJlsO
   6N8FAecCNxEkojtZrpYttQjGNZMZ2Yd5Bzb1ZLXW62aOT5JNJ2XVSdaIs
   iodfCEKUfBjfEaFE4SjUMjST/WSBfxTvIZdRLnD+5zrxM5Nqy9TAIv34P
   w==;
X-CSE-ConnectionGUID: AUzzj4FuQROXYb/WRpaUSw==
X-CSE-MsgGUID: NrnakTJZR7CE99fG6rZ5GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897447"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897447"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:51 -0800
X-CSE-ConnectionGUID: ri5/EuagSFyGFFIuMJymjw==
X-CSE-MsgGUID: uvbTXrY5QICtt2vmtD70Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211391"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:51 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next v2 01/13] ice: c827: move wait for FW to ice_init_hw()
Date: Tue, 14 Jan 2025 16:08:27 -0800
Message-ID: <20250115000844.714530-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move call to ice_wait_for_fw() from ice_init_dev() into ice_init_hw(),
where it fits better. This requires also to move ice_wait_for_fw()
to ice_common.c.

ice_is_pf_c827() is now used only in ice_common.c, so it could be static.

CC: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 110 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_common.h |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c   |  37 -------
 3 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f89bc6ede315..64871ecfe8ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -308,6 +308,42 @@ bool ice_is_e825c(struct ice_hw *hw)
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
@@ -1025,6 +1061,33 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
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
@@ -1174,8 +1237,19 @@ int ice_init_hw(struct ice_hw *hw)
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
@@ -2728,40 +2802,6 @@ ice_parse_dev_caps(struct ice_hw *hw, struct ice_hw_dev_caps *dev_p,
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
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index a68bea3934e3..d12424735686 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -112,7 +112,6 @@ int
 ice_aq_get_phy_caps(struct ice_port_info *pi, bool qual_mods, u8 report_mode,
 		    struct ice_aqc_get_phy_caps_data *caps,
 		    struct ice_sq_cd *cd);
-bool ice_is_pf_c827(struct ice_hw *hw);
 bool ice_is_phy_rclk_in_netlist(struct ice_hw *hw);
 bool ice_is_clock_mux_in_netlist(struct ice_hw *hw);
 bool ice_is_cgu_in_netlist(struct ice_hw *hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1701f7143f24..f0a637cf3d87 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4749,31 +4749,6 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
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
@@ -4786,18 +4761,6 @@ int ice_init_dev(struct ice_pf *pf)
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
2.47.1


