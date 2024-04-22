Return-Path: <netdev+bounces-90268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017E98AD5F7
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260731C210B8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BED1CAAD;
	Mon, 22 Apr 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HMXFxjZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49AB1BF24
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818371; cv=none; b=p7XNyd3DL2I3oDM2DXoPXBaYYv5KxAgL/WTZmFx6qL1TxZAAX+dv8VSTm47iObmPUib4dKDCsg6XFDljE3yrZNy4AV2YZOh2nUHVpqHuWv/4ti6w+RRjqeQvutc90r91/1NqeWfq1imRFIhpy0mCw5O1+wU63fWxhKhbpWScvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818371; c=relaxed/simple;
	bh=BqhvwF3eVmwMM/lce0t1AFgxdGyLeI2vookLMVsBPb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvwFsXGwUBO+zATX6dYJ61aThBwOo5Uub1Ma9koKnkZ78vGTuGUQGfMIaSPJ7MnmfAgszgQhke6kfJ/fuJm5WR1N04tDWnlqOzXqaVWeqezpDvjbJCM4e3apNjjuLYjtqpLHlG1ZyYMzkQPC7ztLYbIrzDEKKVEAC3TxMzTPTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMXFxjZ3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818370; x=1745354370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqhvwF3eVmwMM/lce0t1AFgxdGyLeI2vookLMVsBPb4=;
  b=HMXFxjZ3eODk8g2/adRvjkN37CjeT4X7mVoEb2MxNxkK5b8voHpkVHwB
   bI0Ypo/Zwi/YCH52ry32G02cAkNKbCxsNANOFNpMnnDae6Ow8QMQ+EGcR
   coC/ut07w/FfuV/nagfY4XPwkgQwDbhcEOJR8w+nfPkki9QGZF41VLJjK
   /rhhUxC5E6M00Pba7SVvnZhCqFHjbyksghRK+WM+qJhFqGGfcX/SddmR9
   Z+ndareoB/N1IoSjBEsBtvkkLkpqbT4nCuACV1cj6n07XIORonyZTITTF
   zqFZSXzeniaUbh4u768zcxDi+AaEmRTXUZAufpmy14hmCJ8fA/v2jf29I
   g==;
X-CSE-ConnectionGUID: 4xakdg+GTqSBAMxSbIys+A==
X-CSE-MsgGUID: R41OZDOUS9yqAN+woxotnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9244820"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9244820"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:39:22 -0700
X-CSE-ConnectionGUID: 5y42vuYwQqKJ7LBiZDALIA==
X-CSE-MsgGUID: RfpInZ0cTGmymo4N6Sm06g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28945618"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2024 13:39:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/6] ice: Add tx_scheduling_layers devlink param
Date: Mon, 22 Apr 2024 13:39:10 -0700
Message-ID: <20240422203913.225151-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

It was observed that Tx performance was inconsistent across all queues
and/or VSIs and that it was directly connected to existing 9-layer
topology of the Tx scheduler.

Introduce new private devlink param - tx_scheduling_layers. This parameter
gives user flexibility to choose the 5-layer transmit scheduler topology
which helps to smooth out the transmit performance.

Allowed parameter values are 5 and 9.

Example usage:

Show:
devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
pci/0000:4b:00.0:
  name tx_scheduling_layers type driver-specific
    values:
      cmode permanent value 9

Set:
devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
cmode permanent

devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 9
cmode permanent

Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/devlink.c  | 172 +++++++++++++++++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   9 +
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 6 files changed, 191 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index acbace240977..d191c5709899 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -523,6 +523,156 @@ ice_devlink_reload_empr_finish(struct ice_pf *pf,
 	return 0;
 }
 
+/**
+ * ice_get_tx_topo_user_sel - Read user's choice from flash
+ * @pf: pointer to pf structure
+ * @layers: value read from flash will be saved here
+ *
+ * Reads user's preference for Tx Scheduler Topology Tree from PFA TLV.
+ *
+ * Return: zero when read was successful, negative values otherwise.
+ */
+static int ice_get_tx_topo_user_sel(struct ice_pf *pf, uint8_t *layers)
+{
+	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
+	struct ice_hw *hw = &pf->hw;
+	int err;
+
+	err = ice_acquire_nvm(hw, ICE_RES_READ);
+	if (err)
+		return err;
+
+	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
+			      sizeof(usr_sel), &usr_sel, true, true, NULL);
+	if (err)
+		goto exit_release_res;
+
+	if (usr_sel.data & ICE_AQC_NVM_TX_TOPO_USER_SEL)
+		*layers = ICE_SCHED_5_LAYERS;
+	else
+		*layers = ICE_SCHED_9_LAYERS;
+
+exit_release_res:
+	ice_release_nvm(hw);
+
+	return err;
+}
+
+/**
+ * ice_update_tx_topo_user_sel - Save user's preference in flash
+ * @pf: pointer to pf structure
+ * @layers: value to be saved in flash
+ *
+ * Variable "layers" defines user's preference about number of layers in Tx
+ * Scheduler Topology Tree. This choice should be stored in PFA TLV field
+ * and be picked up by driver, next time during init.
+ *
+ * Return: zero when save was successful, negative values otherwise.
+ */
+static int ice_update_tx_topo_user_sel(struct ice_pf *pf, int layers)
+{
+	struct ice_aqc_nvm_tx_topo_user_sel usr_sel = {};
+	struct ice_hw *hw = &pf->hw;
+	int err;
+
+	err = ice_acquire_nvm(hw, ICE_RES_WRITE);
+	if (err)
+		return err;
+
+	err = ice_aq_read_nvm(hw, ICE_AQC_NVM_TX_TOPO_MOD_ID, 0,
+			      sizeof(usr_sel), &usr_sel, true, true, NULL);
+	if (err)
+		goto exit_release_res;
+
+	if (layers == ICE_SCHED_5_LAYERS)
+		usr_sel.data |= ICE_AQC_NVM_TX_TOPO_USER_SEL;
+	else
+		usr_sel.data &= ~ICE_AQC_NVM_TX_TOPO_USER_SEL;
+
+	err = ice_write_one_nvm_block(pf, ICE_AQC_NVM_TX_TOPO_MOD_ID, 2,
+				      sizeof(usr_sel.data), &usr_sel.data,
+				      true, NULL, NULL);
+exit_release_res:
+	ice_release_nvm(hw);
+
+	return err;
+}
+
+/**
+ * ice_devlink_tx_sched_layers_get - Get tx_scheduling_layers parameter
+ * @devlink: pointer to the devlink instance
+ * @id: the parameter ID to set
+ * @ctx: context to store the parameter value
+ *
+ * Return: zero on success and negative value on failure.
+ */
+static int ice_devlink_tx_sched_layers_get(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	int err;
+
+	err = ice_get_tx_topo_user_sel(pf, &ctx->val.vu8);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * ice_devlink_tx_sched_layers_set - Set tx_scheduling_layers parameter
+ * @devlink: pointer to the devlink instance
+ * @id: the parameter ID to set
+ * @ctx: context to get the parameter value
+ * @extack: netlink extended ACK structure
+ *
+ * Return: zero on success and negative value on failure.
+ */
+static int ice_devlink_tx_sched_layers_set(struct devlink *devlink, u32 id,
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = devlink_priv(devlink);
+	int err;
+
+	err = ice_update_tx_topo_user_sel(pf, ctx->val.vu8);
+	if (err)
+		return err;
+
+	NL_SET_ERR_MSG_MOD(extack,
+			   "Tx scheduling layers have been changed on this device. You must do the PCI slot powercycle for the change to take effect.");
+
+	return 0;
+}
+
+/**
+ * ice_devlink_tx_sched_layers_validate - Validate passed tx_scheduling_layers
+ *                                        parameter value
+ * @devlink: unused pointer to devlink instance
+ * @id: the parameter ID to validate
+ * @val: value to validate
+ * @extack: netlink extended ACK structure
+ *
+ * Supported values are:
+ * - 5 - five layers Tx Scheduler Topology Tree
+ * - 9 - nine layers Tx Scheduler Topology Tree
+ *
+ * Return: zero when passed parameter value is supported. Negative value on
+ * error.
+ */
+static int ice_devlink_tx_sched_layers_validate(struct devlink *devlink, u32 id,
+						union devlink_param_value val,
+						struct netlink_ext_ack *extack)
+{
+	if (val.vu8 != ICE_SCHED_5_LAYERS && val.vu8 != ICE_SCHED_9_LAYERS) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Wrong number of tx scheduler layers provided.");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * ice_tear_down_devlink_rate_tree - removes devlink-rate exported tree
  * @pf: pf struct
@@ -1235,6 +1385,11 @@ ice_devlink_enable_iw_validate(struct devlink *devlink, u32 id,
 	return 0;
 }
 
+enum ice_param_id {
+	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
+};
+
 static const struct devlink_param ice_devlink_params[] = {
 	DEVLINK_PARAM_GENERIC(ENABLE_ROCE, BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      ice_devlink_enable_roce_get,
@@ -1244,7 +1399,13 @@ static const struct devlink_param ice_devlink_params[] = {
 			      ice_devlink_enable_iw_get,
 			      ice_devlink_enable_iw_set,
 			      ice_devlink_enable_iw_validate),
-
+	DEVLINK_PARAM_DRIVER(ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
+			     "tx_scheduling_layers",
+			     DEVLINK_PARAM_TYPE_U8,
+			     BIT(DEVLINK_PARAM_CMODE_PERMANENT),
+			     ice_devlink_tx_sched_layers_get,
+			     ice_devlink_tx_sched_layers_set,
+			     ice_devlink_tx_sched_layers_validate),
 };
 
 static void ice_devlink_free(void *devlink_ptr)
@@ -1304,9 +1465,16 @@ void ice_devlink_unregister(struct ice_pf *pf)
 int ice_devlink_register_params(struct ice_pf *pf)
 {
 	struct devlink *devlink = priv_to_devlink(pf);
+	struct ice_hw *hw = &pf->hw;
+	size_t params_size;
+
+	params_size =  ARRAY_SIZE(ice_devlink_params);
+
+	if (!hw->func_caps.common_cap.tx_sched_topo_comp_mode_en)
+		params_size--;
 
 	return devl_params_register(devlink, ice_devlink_params,
-				    ARRAY_SIZE(ice_devlink_params));
+				    params_size);
 }
 
 void ice_devlink_unregister_params(struct ice_pf *pf)
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 0487c425ae24..e76c388b9905 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1684,6 +1684,15 @@ struct ice_aqc_nvm {
 
 #define ICE_AQC_NVM_START_POINT			0
 
+#define ICE_AQC_NVM_TX_TOPO_MOD_ID		0x14B
+
+struct ice_aqc_nvm_tx_topo_user_sel {
+	__le16 length;
+	u8 data;
+#define ICE_AQC_NVM_TX_TOPO_USER_SEL	BIT(4)
+	u8 reserved;
+};
+
 /* NVM Checksum Command (direct, 0x0706) */
 struct ice_aqc_nvm_checksum {
 	u8 flags;
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 319a2d6fe26c..f81db6c107c8 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -286,10 +286,9 @@ ice_send_component_table(struct pldmfw *context, struct pldmfw_component *compon
  *
  * Returns: zero on success, or a negative error code on failure.
  */
-static int
-ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
-			u16 block_size, u8 *block, bool last_cmd,
-			u8 *reset_level, struct netlink_ext_ack *extack)
+int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
+			    u16 block_size, u8 *block, bool last_cmd,
+			    u8 *reset_level, struct netlink_ext_ack *extack)
 {
 	u16 completion_module, completion_retval;
 	struct device *dev = ice_pf_to_dev(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.h b/drivers/net/ethernet/intel/ice/ice_fw_update.h
index 750574885716..04b200462757 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.h
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.h
@@ -9,5 +9,8 @@ int ice_devlink_flash_update(struct devlink *devlink,
 			     struct netlink_ext_ack *extack);
 int ice_get_pending_updates(struct ice_pf *pf, u8 *pending,
 			    struct netlink_ext_ack *extack);
+int ice_write_one_nvm_block(struct ice_pf *pf, u16 module, u32 offset,
+			    u16 block_size, u8 *block, bool last_cmd,
+			    u8 *reset_level, struct netlink_ext_ack *extack);
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.c b/drivers/net/ethernet/intel/ice/ice_nvm.c
index d4e05d2cb30c..84eab92dc03c 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.c
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.c
@@ -18,10 +18,9 @@
  *
  * Read the NVM using the admin queue commands (0x0701)
  */
-static int
-ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset, u16 length,
-		void *data, bool last_command, bool read_shadow_ram,
-		struct ice_sq_cd *cd)
+int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
+		    u16 length, void *data, bool last_command,
+		    bool read_shadow_ram, struct ice_sq_cd *cd)
 {
 	struct ice_aq_desc desc;
 	struct ice_aqc_nvm *cmd;
diff --git a/drivers/net/ethernet/intel/ice/ice_nvm.h b/drivers/net/ethernet/intel/ice/ice_nvm.h
index 774c2317967d..63cdc6bdac58 100644
--- a/drivers/net/ethernet/intel/ice/ice_nvm.h
+++ b/drivers/net/ethernet/intel/ice/ice_nvm.h
@@ -14,6 +14,9 @@ struct ice_orom_civd_info {
 
 int ice_acquire_nvm(struct ice_hw *hw, enum ice_aq_res_access_type access);
 void ice_release_nvm(struct ice_hw *hw);
+int ice_aq_read_nvm(struct ice_hw *hw, u16 module_typeid, u32 offset,
+		    u16 length, void *data, bool last_command,
+		    bool read_shadow_ram, struct ice_sq_cd *cd);
 int
 ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
 		  bool read_shadow_ram);
-- 
2.41.0


