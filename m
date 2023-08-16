Return-Path: <netdev+bounces-28221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A687777EB21
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EAD281C73
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A91ADDD;
	Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8B41BEF7
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:54:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED02711
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 13:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692219275; x=1723755275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3yZ6u4XsSYYHiTHnsEZjpdinylI/AVVZXKiu3XmoNvU=;
  b=MN9gAhjszsX3sEmRbiPTd7zNAIfSizZbUFbSQpm8EMixSmQML7hTOG9J
   FAlED2NT+6IuixQGEJ6X7wi5F5FNQ/ngJ6tYoL+/q8ZGbaO1YESPvDNgZ
   hqvUPt+MiHRXVgWaZAvy9Q0jV6uNBaQ+kCnhAdfJDj5YNUUyXsHF8VRAe
   jLSf8kQjVU0xzQkz1EBJU7bGZcCdaBDFRqqHbT//KntSbpC/XGMVURLp+
   gliM2DxTRGycef+oGa85o7AdyCSYvz0EXRmFv79xYp1zIIXTTp+ZA3M02
   YYs2Lmj/bFqpyKChJJEYYwCNQ5BuIa1H6g7npSX+EeBjfYIQuKbMyL+HH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357604794"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="357604794"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 13:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848626397"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="848626397"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 16 Aug 2023 13:54:32 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net-next 08/14] ice: move E810T functions to before device agnostic ones
Date: Wed, 16 Aug 2023 13:47:30 -0700
Message-Id: <20230816204736.1325132-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
References: <20230816204736.1325132-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 885fe6932a11 ("ice: Add support for SMA control multiplexer")
accidentally placed all of the E810T SMA control functions in the middle of
the device agnostic functions section of ice_ptp_hw.c

This works fine, but makes it harder for readers to follow. The
ice_ptp_hw.c file is laid out such that each hardware family has the
specific functions in one block, with the access functions placed at the
end of the file.

Move the E810T functions so that they are in a block just after the E810
functions. Also move the ice_get_phy_tx_tstamp_ready_e810 which got added
at the end of the E810T block.

This keeps the functions laid out in a logical order and avoids intermixing
the generic access functions with the device specific implementations.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 358 ++++++++++----------
 1 file changed, 179 insertions(+), 179 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 68e2d5ca01f3..5a6ffa738396 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2869,6 +2869,185 @@ static int ice_ptp_port_cmd_e810(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	return 0;
 }
 
+/**
+ * ice_get_phy_tx_tstamp_ready_e810 - Read Tx memory status register
+ * @hw: pointer to the HW struct
+ * @port: the PHY port to read
+ * @tstamp_ready: contents of the Tx memory status register
+ *
+ * E810 devices do not use a Tx memory status register. Instead simply
+ * indicate that all timestamps are currently ready.
+ */
+static int
+ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
+{
+	*tstamp_ready = 0xFFFFFFFFFFFFFFFF;
+	return 0;
+}
+
+/* E810T SMA functions
+ *
+ * The following functions operate specifically on E810T hardware and are used
+ * to access the extended GPIOs available.
+ */
+
+/**
+ * ice_get_pca9575_handle
+ * @hw: pointer to the hw struct
+ * @pca9575_handle: GPIO controller's handle
+ *
+ * Find and return the GPIO controller's handle in the netlist.
+ * When found - the value will be cached in the hw structure and following calls
+ * will return cached value
+ */
+static int
+ice_get_pca9575_handle(struct ice_hw *hw, u16 *pca9575_handle)
+{
+	struct ice_aqc_get_link_topo *cmd;
+	struct ice_aq_desc desc;
+	int status;
+	u8 idx;
+
+	/* If handle was read previously return cached value */
+	if (hw->io_expander_handle) {
+		*pca9575_handle = hw->io_expander_handle;
+		return 0;
+	}
+
+	/* If handle was not detected read it from the netlist */
+	cmd = &desc.params.get_link_topo;
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_link_topo);
+
+	/* Set node type to GPIO controller */
+	cmd->addr.topo_params.node_type_ctx =
+		(ICE_AQC_LINK_TOPO_NODE_TYPE_M &
+		 ICE_AQC_LINK_TOPO_NODE_TYPE_GPIO_CTRL);
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
+		return -EOPNOTSUPP;
+
+	cmd->addr.topo_params.index = idx;
+
+	status = ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
+	if (status)
+		return -EOPNOTSUPP;
+
+	/* Verify if we found the right IO expander type */
+	if (desc.params.get_link_topo.node_part_num !=
+		ICE_AQC_GET_LINK_TOPO_NODE_NR_PCA9575)
+		return -EOPNOTSUPP;
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
+ * ice_read_sma_ctrl_e810t
+ * @hw: pointer to the hw struct
+ * @data: pointer to data to be read from the GPIO controller
+ *
+ * Read the SMA controller state. It is connected to pins 3-7 of Port 1 of the
+ * PCA9575 expander, so only bits 3-7 in data are valid.
+ */
+int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data)
+{
+	int status;
+	u16 handle;
+	u8 i;
+
+	status = ice_get_pca9575_handle(hw, &handle);
+	if (status)
+		return status;
+
+	*data = 0;
+
+	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T; i++) {
+		bool pin;
+
+		status = ice_aq_get_gpio(hw, handle, i + ICE_PCA9575_P1_OFFSET,
+					 &pin, NULL);
+		if (status)
+			break;
+		*data |= (u8)(!pin) << i;
+	}
+
+	return status;
+}
+
+/**
+ * ice_write_sma_ctrl_e810t
+ * @hw: pointer to the hw struct
+ * @data: data to be written to the GPIO controller
+ *
+ * Write the data to the SMA controller. It is connected to pins 3-7 of Port 1
+ * of the PCA9575 expander, so only bits 3-7 in data are valid.
+ */
+int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data)
+{
+	int status;
+	u16 handle;
+	u8 i;
+
+	status = ice_get_pca9575_handle(hw, &handle);
+	if (status)
+		return status;
+
+	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T; i++) {
+		bool pin;
+
+		pin = !(data & (1 << i));
+		status = ice_aq_set_gpio(hw, handle, i + ICE_PCA9575_P1_OFFSET,
+					 pin, NULL);
+		if (status)
+			break;
+	}
+
+	return status;
+}
+
+/**
+ * ice_read_pca9575_reg_e810t
+ * @hw: pointer to the hw struct
+ * @offset: GPIO controller register offset
+ * @data: pointer to data to be read from the GPIO controller
+ *
+ * Read the register from the GPIO controller
+ */
+int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data)
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
 /* Device agnostic functions
  *
  * The following functions implement shared behavior common to both E822 and
@@ -3129,185 +3308,6 @@ int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 		return ice_clear_phy_tstamp_e822(hw, block, idx);
 }
 
-/**
- * ice_get_phy_tx_tstamp_ready_e810 - Read Tx memory status register
- * @hw: pointer to the HW struct
- * @port: the PHY port to read
- * @tstamp_ready: contents of the Tx memory status register
- *
- * E810 devices do not use a Tx memory status register. Instead simply
- * indicate that all timestamps are currently ready.
- */
-static int
-ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
-{
-	*tstamp_ready = 0xFFFFFFFFFFFFFFFF;
-	return 0;
-}
-
-/* E810T SMA functions
- *
- * The following functions operate specifically on E810T hardware and are used
- * to access the extended GPIOs available.
- */
-
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
-/**
- * ice_read_sma_ctrl_e810t
- * @hw: pointer to the hw struct
- * @data: pointer to data to be read from the GPIO controller
- *
- * Read the SMA controller state. It is connected to pins 3-7 of Port 1 of the
- * PCA9575 expander, so only bits 3-7 in data are valid.
- */
-int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data)
-{
-	int status;
-	u16 handle;
-	u8 i;
-
-	status = ice_get_pca9575_handle(hw, &handle);
-	if (status)
-		return status;
-
-	*data = 0;
-
-	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T; i++) {
-		bool pin;
-
-		status = ice_aq_get_gpio(hw, handle, i + ICE_PCA9575_P1_OFFSET,
-					 &pin, NULL);
-		if (status)
-			break;
-		*data |= (u8)(!pin) << i;
-	}
-
-	return status;
-}
-
-/**
- * ice_write_sma_ctrl_e810t
- * @hw: pointer to the hw struct
- * @data: data to be written to the GPIO controller
- *
- * Write the data to the SMA controller. It is connected to pins 3-7 of Port 1
- * of the PCA9575 expander, so only bits 3-7 in data are valid.
- */
-int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data)
-{
-	int status;
-	u16 handle;
-	u8 i;
-
-	status = ice_get_pca9575_handle(hw, &handle);
-	if (status)
-		return status;
-
-	for (i = ICE_SMA_MIN_BIT_E810T; i <= ICE_SMA_MAX_BIT_E810T; i++) {
-		bool pin;
-
-		pin = !(data & (1 << i));
-		status = ice_aq_set_gpio(hw, handle, i + ICE_PCA9575_P1_OFFSET,
-					 pin, NULL);
-		if (status)
-			break;
-	}
-
-	return status;
-}
-
-/**
- * ice_read_pca9575_reg_e810t
- * @hw: pointer to the hw struct
- * @offset: GPIO controller register offset
- * @data: pointer to data to be read from the GPIO controller
- *
- * Read the register from the GPIO controller
- */
-int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data)
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
  * ice_ptp_reset_ts_memory - Reset timestamp memory for all blocks
  * @hw: pointer to the HW struct
-- 
2.38.1


