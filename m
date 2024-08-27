Return-Path: <netdev+bounces-122318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6E960B6F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB36D286889
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61721C824B;
	Tue, 27 Aug 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+L/F6RZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C941C68BB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764118; cv=none; b=UdFIvxqaFLmpQsrRb7jaT8w2fpBmiU1x3txkKWxbNL4rX5s0FmN7CU9M/KCcFwnxmJqRBdVInFRV2BKqZ8p3cQyn3xPNNNHAujQhBj8Cv9qlIRYDO0DoV36v//t8Y9uSFuXpQOX0rtyUOmxqtqM2Wr3QZZE0WO/vplkb2p00bCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764118; c=relaxed/simple;
	bh=3yQgUa/T8Rye6DiLVnSHbB+GQaw8RJEgrhIZ/ngH6kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kA9lQYzVOAFz3mTc76X4ZXmAmQD1o55ZvUR1+/6kmGKc/yMGucwTQxoFmYRG1kd8cqckkjNO/S8WTOH/baCrorUtTMPwfettrJF8nz3XIY4QToM0Fr2F5PH34bLDm2cXEniD4RNJcG49Xcp9AvUcDf25qn+AtThdcVTlhn7IIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+L/F6RZ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764116; x=1756300116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yQgUa/T8Rye6DiLVnSHbB+GQaw8RJEgrhIZ/ngH6kA=;
  b=e+L/F6RZJAO3kazp5kdUuAuSCTwRE0gvjiaGuRALtIqlpMwGSNaPrfTO
   T1yoJO/dOnzY0Vh21ZG4w+n6FWGSyyKq+tK1qPdxiId+o1uiGFvszgnkP
   batud0Gwhw8+hjsqwk3aB4iU2Hyr9urGKUIvop2/JA+K+lsorPH6fFUTu
   1w4kZa+dAXXgBn0pI1hpaa5koIBYx+Xg+OSI+lCRtKEIMsKe15sYuX3bi
   cGqu7/yH/KldFohatsTbMo5jI7TpdV04UD0IFHQWf0wrHIoyLlHTEQ2IX
   VZ/b5y/trfi2qL/6sdSxPnd8039e+80SvTddgnnfnBvy5NSZa+MaT+3pz
   w==;
X-CSE-ConnectionGUID: ifPQy/68Qr2/W7ertLWlwA==
X-CSE-MsgGUID: xrrUFkpWR+6VExvY+tLW3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40710289"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40710289"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:36 -0700
X-CSE-ConnectionGUID: mFteSHDOTtGZL4JGIlyLxQ==
X-CSE-MsgGUID: mITpsaZwS8yRVJny9zoVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93650092"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa001.fm.intel.com with ESMTP; 27 Aug 2024 06:08:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v8 iwl-next 1/7] ice: Don't check device type when checking GNSS presence
Date: Tue, 27 Aug 2024 14:50:43 +0200
Message-ID: <20240827130814.732181-10-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827130814.732181-9-karol.kolacinski@intel.com>
References: <20240827130814.732181-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't check if the device type is E810T as non-E810T devices can support
GNSS too and PCA9575 check is enough to determine if GNSS is present or
not.

Rename ice_gnss_is_gps_present() to ice_gnss_is_module_present()
because GNSS module supports multiple GNSS providers, not only GPS.

Move functions related to PCA9575 from ice_ptp_hw.c to ice_common.c
to be able to access them when PTP is disabled in the kernel, but GNSS
is enabled.

Remove logical AND with ICE_AQC_LINK_TOPO_NODE_TYPE_M in
ice_get_pca9575_handle(), which has no effect, and reorder device type
checks to check the device_id first, then set other variables.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 90 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_common.h |  2 +
 drivers/net/ethernet/intel/ice/ice_gnss.c   | 29 +++----
 drivers/net/ethernet/intel/ice/ice_gnss.h   |  4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c    |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 93 ---------------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 -
 7 files changed, 105 insertions(+), 117 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 009716a12a26..71a75d27affd 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -5819,6 +5819,96 @@ ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, cd);
 }
 
+/**
+ * ice_get_pca9575_handle - find and return the PCA9575 controller
+ * @hw: pointer to the hw struct
+ * @pca9575_handle: GPIO controller's handle
+ *
+ * Find and return the GPIO controller's handle in the netlist.
+ * When found - the value will be cached in the hw structure and following calls
+ * will return cached value.
+ *
+ * Return: 0 on success, -ENXIO when there's no PCA9575 present.
+ */
+int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle)
+{
+	struct ice_aqc_get_link_topo *cmd;
+	struct ice_aq_desc desc;
+	int err;
+	u8 idx;
+
+	/* If handle was read previously return cached value */
+	if (hw->io_expander_handle) {
+		*pca9575_handle = hw->io_expander_handle;
+		return 0;
+	}
+
+#define SW_PCA9575_SFP_TOPO_IDX		2
+#define SW_PCA9575_QSFP_TOPO_IDX	1
+
+	/* Check if the SW IO expander controlling SMA exists in the netlist. */
+	if (hw->device_id == ICE_DEV_ID_E810C_SFP)
+		idx = SW_PCA9575_SFP_TOPO_IDX;
+	else if (hw->device_id == ICE_DEV_ID_E810C_QSFP)
+		idx = SW_PCA9575_QSFP_TOPO_IDX;
+	else
+		return -ENXIO;
+
+	/* If handle was not detected read it from the netlist */
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
+	cmd = &desc.params.get_link_topo;
+	cmd->addr.topo_params.node_type_ctx =
+		ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL;
+	cmd->addr.topo_params.index = idx;
+
+	err = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (err)
+		return -ENXIO;
+
+	/* Verify if we found the right IO expander type */
+	if (desc.params.get_link_topo.node_part_num !=
+	    ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
+		return -ENXIO;
+
+	/* If present save the handle and return it */
+	hw->io_expander_handle =
+		le16_to_cpu(desc.params.get_link_topo.addr.handle);
+	*pca9575_handle = hw->io_expander_handle;
+
+	return 0;
+}
+
+/**
+ * ice_read_pca9575_reg - read the register from the PCA9575 controller
+ * @hw: pointer to the hw struct
+ * @offset: GPIO controller register offset
+ * @data: pointer to data to be read from the GPIO controller
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data)
+{
+	struct ice_aqc_link_topo_addr link_topo;
+	__le16 addr;
+	u16 handle;
+	int err;
+
+	memset(&link_topo, 0, sizeof(link_topo));
+
+	err = ice_get_pca9575_handle(hw, &handle);
+	if (err)
+		return err;
+
+	link_topo.handle = cpu_to_le16(handle);
+	link_topo.topo_params.node_type_ctx =
+		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M,
+			   ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED);
+
+	addr = cpu_to_le16((u16)offset);
+
+	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
+}
+
 /**
  * ice_aq_set_gpio
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 27208a60cece..b8ec795854ec 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -305,5 +305,7 @@ int
 ice_aq_write_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
 		 u16 bus_addr, __le16 addr, u8 params, const u8 *data,
 		 struct ice_sq_cd *cd);
+int ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle);
+int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
 bool ice_fw_supports_report_dflt_cfg(struct ice_hw *hw);
 #endif /* _ICE_COMMON_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index f02e8ca55375..66390eeb2343 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -381,32 +381,23 @@ void ice_gnss_exit(struct ice_pf *pf)
 }
 
 /**
- * ice_gnss_is_gps_present - Check if GPS HW is present
+ * ice_gnss_is_module_present - Check if GPS HW is present
  * @hw: pointer to HW struct
+ *
+ * Return: true when GNSS is present, false otherwise.
  */
-bool ice_gnss_is_gps_present(struct ice_hw *hw)
+bool ice_gnss_is_module_present(struct ice_hw *hw)
 {
-	if (!hw->func_caps.ts_func_info.src_tmr_owned)
-		return false;
+	int err;
+	u8 data;
 
-	if (!ice_is_gps_in_netlist(hw))
+	if (!hw->func_caps.ts_func_info.src_tmr_owned ||
+	    !ice_is_gps_in_netlist(hw))
 		return false;
 
-#if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
-	if (ice_is_e810t(hw)) {
-		int err;
-		u8 data;
-
-		err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
-		if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
-			return false;
-	} else {
-		return false;
-	}
-#else
-	if (!ice_is_e810t(hw))
+	err = ice_read_pca9575_reg(hw, ICE_PCA9575_P0_IN, &data);
+	if (err || !!(data & ICE_P0_GNSS_PRSNT_N))
 		return false;
-#endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 
 	return true;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index 75e567ad7059..15daf603ed7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -37,11 +37,11 @@ struct gnss_serial {
 #if IS_ENABLED(CONFIG_GNSS)
 void ice_gnss_init(struct ice_pf *pf);
 void ice_gnss_exit(struct ice_pf *pf);
-bool ice_gnss_is_gps_present(struct ice_hw *hw);
+bool ice_gnss_is_module_present(struct ice_hw *hw);
 #else
 static inline void ice_gnss_init(struct ice_pf *pf) { }
 static inline void ice_gnss_exit(struct ice_pf *pf) { }
-static inline bool ice_gnss_is_gps_present(struct ice_hw *hw)
+static inline bool ice_gnss_is_module_present(struct ice_hw *hw)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d9a4744c56fb..d157cf1e3d15 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3935,7 +3935,7 @@ void ice_init_feature_support(struct ice_pf *pf)
 			ice_set_feature_support(pf, ICE_F_CGU);
 		if (ice_is_clock_mux_in_netlist(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_SMA_CTRL);
-		if (ice_gnss_is_gps_present(&pf->hw))
+		if (ice_gnss_is_module_present(&pf->hw))
 			ice_set_feature_support(pf, ICE_F_GNSS);
 		break;
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index da88c6ccfaeb..04286e872b24 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5179,68 +5179,6 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
  * to access the extended GPIOs available.
  */
 
-/**
- * ice_get_pca9575_handle
- * @hw: pointer to the hw struct
- * @pca9575_handle: GPIO controller's handle
- *
- * Find and return the GPIO controller's handle in the netlist.
- * When found - the value will be cached in the hw structure and following calls
- * will return cached value
- */
-static int
-ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle)
-{
-	struct ice_aqc_get_link_topo *cmd;
-	struct ice_aq_desc desc;
-	int status;
-	u8 idx;
-
-	/* If handle was read previously return cached value */
-	if (hw->io_expander_handle) {
-		*pca9575_handle = hw->io_expander_handle;
-		return 0;
-	}
-
-	/* If handle was not detected read it from the netlist */
-	cmd = &desc.params.get_link_topo;
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
-
-	/* Set node type to GPIO controller */
-	cmd->addr.topo_params.node_type_ctx =
-		(ICE_AQC_LINK_TOPO_NODE_TYPE_M &
-		 ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL);
-
-#define SW_PCA9575_SFP_TOPO_IDX		2
-#define SW_PCA9575_QSFP_TOPO_IDX	1
-
-	/* Check if the SW IO expander controlling SMA exists in the netlist. */
-	if (hw->device_id == ICE_DEV_ID_E810C_SFP)
-		idx = SW_PCA9575_SFP_TOPO_IDX;
-	else if (hw->device_id == ICE_DEV_ID_E810C_QSFP)
-		idx = SW_PCA9575_QSFP_TOPO_IDX;
-	else
-		return -EOPNOTSUPP;
-
-	cmd->addr.topo_params.index = idx;
-
-	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
-	if (status)
-		return -EOPNOTSUPP;
-
-	/* Verify if we found the right IO expander type */
-	if (desc.params.get_link_topo.node_part_num !=
-		ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
-		return -EOPNOTSUPP;
-
-	/* If present save the handle and return it */
-	hw->io_expander_handle =
-		le16_to_cpu(desc.params.get_link_topo.addr.handle);
-	*pca9575_handle = hw->io_expander_handle;
-
-	return 0;
-}
-
 /**
  * ice_read_sma_ctrl
  * @hw: pointer to the hw struct
@@ -5305,37 +5243,6 @@ int ice_write_sma_ctrl(struct ice_hw *hw, u8 data)
 	return status;
 }
 
-/**
- * ice_read_pca9575_reg
- * @hw: pointer to the hw struct
- * @offset: GPIO controller register offset
- * @data: pointer to data to be read from the GPIO controller
- *
- * Read the register from the GPIO controller
- */
-int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data)
-{
-	struct ice_aqc_link_topo_addr link_topo;
-	__le16 addr;
-	u16 handle;
-	int err;
-
-	memset(&link_topo, 0, sizeof(link_topo));
-
-	err = ice_get_pca9575_handle(hw, &handle);
-	if (err)
-		return err;
-
-	link_topo.handle = cpu_to_le16(handle);
-	link_topo.topo_params.node_type_ctx =
-		FIELD_PREP(ICE_AQC_LINK_TOPO_NODE_CTX_M,
-			   ICE_AQC_LINK_TOPO_NODE_CTX_PROVIDED);
-
-	addr = cpu_to_le16((u16)offset);
-
-	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
-}
-
 /**
  * ice_ptp_read_sdp_ac - read SDP available connections section from NVM
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1a61d4826271..74e7b0682c76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -404,8 +404,6 @@ int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
 /* E810 family functions */
 int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
-int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
-bool ice_is_pca9575_present(struct ice_hw *hw);
 int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
-- 
2.46.0


