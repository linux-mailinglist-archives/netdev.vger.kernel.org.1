Return-Path: <netdev+bounces-108582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFB924708
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E101F267FC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAA51C9EA3;
	Tue,  2 Jul 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hvKm657c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A91C688B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943642; cv=none; b=R0XR/P/v5GqgFxqMPGVx8+na5eIz7j18sJeP74ckWq1nNaK/ibz3HTrv/ATy3x9tqFUpJzbcx+uueG881a+ji9kAHZL0mlZ1THjEWidmBO7ktnNvr9qnbvOQ52u/a5NLnSpRQUbbWKUqemYf2TyPgEW9UVKbnaKLPiGcU+9xrr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943642; c=relaxed/simple;
	bh=u8q6Zg1/kOJfxNM/YrQu/ZYNY7ZV9dNmgcJ7TSHaezs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llGkUxunCgxKsoYOy4luCEpPKNoekIvERdNJi8QEThPUe4UQxuYog86pYtEtl+qA886jEL/A6RizKST/WWWqX83MlCIPtlq3JVnPVgpdlHvuwkUPE7UqiwvOfeovtMEAh8ReLGPh+wbjqoS5k6mojFp5h7GqbN0O0caUpiOtHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hvKm657c; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719943641; x=1751479641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u8q6Zg1/kOJfxNM/YrQu/ZYNY7ZV9dNmgcJ7TSHaezs=;
  b=hvKm657cP9l4oCYsE4PoQRk+tZSUxrujaItcPKVkjUQRCE3fLi8K22un
   8J/7HWgDLizvX81GMkP6dn7FTKFaitFre7ssiKe/U5MB04V7Qfhl04QVZ
   My/n4uCyxcQ/y69OaqBRjmLjdO4sX1F++FcJ6EV4GuYHsDIVDLG5+9NtC
   jh+FRnHPaT5k9hlHO9g6XUzPI3LFaKclJCDMWIfxlQIYVsugwSh29KLnP
   N780xZZzXD0S3Z/8O3Hu0SYiGCa+2OqaPL1Cbinqpb0viCTbbyfL7QG7s
   kug9PMvg7xYq7TPQrti/VDSo+h+OhjyxSgjWqO9Sk3SdyOGPMAnnZ9U4I
   g==;
X-CSE-ConnectionGUID: VeSrx1AXTuSOwyLYoTyw2Q==
X-CSE-MsgGUID: ZyLV8uHNQIOi7OGePQlKAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16964050"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16964050"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:07:19 -0700
X-CSE-ConnectionGUID: hAnZPYklQiCccAgZjGJX2w==
X-CSE-MsgGUID: TMFtooYqQCOkcVuo50Iz/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50321236"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 11:07:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Anil Samal <anil.samal@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/3] ice: Implement driver functionality to dump serdes equalizer values
Date: Tue,  2 Jul 2024 11:07:07 -0700
Message-ID: <20240702180710.2606969-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702180710.2606969-1-anthony.l.nguyen@intel.com>
References: <20240702180710.2606969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anil Samal <anil.samal@intel.com>

To debug link issues in the field, serdes Tx/Rx equalizer values
help to determine the health of serdes lane.

Extend 'ethtool -d' option to dump serdes Tx/Rx equalizer.
The following list of equalizer param is supported
    a. rx_equalization_pre2
    b. rx_equalization_pre1
    c. rx_equalization_post1
    d. rx_equalization_bflf
    e. rx_equalization_bfhf
    f. rx_equalization_drate
    g. tx_equalization_pre1
    h. tx_equalization_pre3
    i. tx_equalization_atten
    j. tx_equalization_post1
    k. tx_equalization_pre2

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 +++++++
 drivers/net/ethernet/intel/ice/ice_common.c   |  37 +++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 141 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  19 +++
 5 files changed, 248 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 621a2ca7093e..b70d4ca43443 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1461,6 +1461,55 @@ struct ice_aqc_get_sensor_reading_resp {
 	} data;
 };
 
+/* DNL call command (indirect 0x0682)
+ * Struct is used for both command and response
+ */
+struct ice_aqc_dnl_call_command {
+	u8 ctx; /* Used in command, reserved in response */
+	u8 reserved;
+	__le16 activity_id;
+#define ICE_AQC_ACT_ID_DNL 0x1129
+	__le32 reserved1;
+	__le32 addr_high;
+	__le32 addr_low;
+};
+
+struct ice_aqc_dnl_equa_param {
+	__le16 data_in;
+#define ICE_AQC_RX_EQU_SHIFT 8
+#define ICE_AQC_RX_EQU_PRE2 (0x10 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_PRE1 (0x11 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_POST1 (0x12 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_TX_EQU_PRE1 0x0
+#define ICE_AQC_TX_EQU_PRE3 0x3
+#define ICE_AQC_TX_EQU_ATTEN 0x4
+#define ICE_AQC_TX_EQU_POST1 0x8
+#define ICE_AQC_TX_EQU_PRE2 0xC
+	__le16 op_code_serdes_sel;
+#define ICE_AQC_OP_CODE_SHIFT 4
+#define ICE_AQC_OP_CODE_RX_EQU (0x9 << ICE_AQC_OP_CODE_SHIFT)
+#define ICE_AQC_OP_CODE_TX_EQU (0x10 << ICE_AQC_OP_CODE_SHIFT)
+	__le32 reserved[3];
+};
+
+struct ice_aqc_dnl_equa_respon {
+	/* Equalization value can be negative */
+	int val;
+	__le32 reserved[3];
+};
+
+/* DNL call command/response buffer (indirect 0x0682) */
+struct ice_aqc_dnl_call {
+	union {
+		struct ice_aqc_dnl_equa_param txrx_equa_reqs;
+		__le32 stores[4];
+		struct ice_aqc_dnl_equa_respon txrx_equa_resp;
+	} sto;
+};
+
 struct ice_aqc_link_topo_params {
 	u8 lport_num;
 	u8 lport_num_valid;
@@ -2564,6 +2613,7 @@ struct ice_aq_desc {
 		struct ice_aqc_get_link_status get_link_status;
 		struct ice_aqc_event_lan_overflow lan_overflow;
 		struct ice_aqc_get_link_topo get_link_topo;
+		struct ice_aqc_dnl_call_command dnl_call;
 		struct ice_aqc_i2c read_write_i2c;
 		struct ice_aqc_read_i2c_resp read_i2c_resp;
 		struct ice_aqc_get_set_tx_topo get_set_tx_topo;
@@ -2688,6 +2738,7 @@ enum ice_adminq_opc {
 	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
 	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
 	ice_aqc_opc_get_sensor_reading			= 0x0632,
+	ice_aqc_opc_dnl_call                            = 0x0682,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
 	ice_aqc_opc_read_i2c				= 0x06E2,
 	ice_aqc_opc_write_i2c				= 0x06E3,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a4f175cf5c61..e311a41a74fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3371,6 +3371,43 @@ int ice_update_link_info(struct ice_port_info *pi)
 	return status;
 }
 
+/**
+ * ice_aq_get_phy_equalization - function to read serdes equaliser
+ * value from firmware using admin queue command.
+ * @hw: pointer to the HW struct
+ * @data_in: represents the serdes equalization parameter requested
+ * @op_code: represents the serdes number and flag to represent tx or rx
+ * @serdes_num: represents the serdes number
+ * @output: pointer to the caller-supplied buffer to return serdes equaliser
+ *
+ * Return: non-zero status on error and 0 on success.
+ */
+int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
+				u8 serdes_num, int *output)
+{
+	struct ice_aqc_dnl_call_command *cmd;
+	struct ice_aqc_dnl_call buf = {};
+	struct ice_aq_desc desc;
+	int err;
+
+	buf.sto.txrx_equa_reqs.data_in = cpu_to_le16(data_in);
+	buf.sto.txrx_equa_reqs.op_code_serdes_sel =
+		cpu_to_le16(op_code | (serdes_num & 0xF));
+	cmd = &desc.params.dnl_call;
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_dnl_call);
+	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_BUF |
+				  ICE_AQ_FLAG_RD |
+				  ICE_AQ_FLAG_SI);
+	desc.datalen = cpu_to_le16(sizeof(struct ice_aqc_dnl_call));
+	cmd->activity_id = cpu_to_le16(ICE_AQC_ACT_ID_DNL);
+
+	err = ice_aq_send_cmd(hw, &desc, &buf, sizeof(struct ice_aqc_dnl_call),
+			      NULL);
+	*output = err ? 0 : buf.sto.txrx_equa_resp.val;
+
+	return err;
+}
+
 #define FEC_REG_PORT(port) {	\
 	FEC_CORR_LOW_REG_PORT##port,		\
 	FEC_CORR_HIGH_REG_PORT##port,	\
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index bd814e751cbf..66f29bac783a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -142,6 +142,8 @@ int
 ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
+int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
+				u8 serdes_num, int *output);
 int
 ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 		     enum ice_fec_stats_types fec_type, u32 *output);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 886977d53b1a..5c52c693c548 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -463,7 +463,8 @@ ice_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
 
 static int ice_get_regs_len(struct net_device __always_unused *netdev)
 {
-	return sizeof(ice_regs_dump_list);
+	return (sizeof(ice_regs_dump_list) +
+		sizeof(struct ice_regdump_to_ethtool));
 }
 
 /**
@@ -681,6 +682,140 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
 	return 0;
 }
 
+/**
+ * ice_get_tx_rx_equa - read serdes tx rx equaliser param
+ * @hw: pointer to the HW struct
+ * @serdes_num: represents the serdes number
+ * @ptr: structure to read all serdes parameter for given serdes
+ *
+ * Return: all serdes equalization parameter supported per serdes number
+ */
+static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
+			      struct ice_serdes_equalization_to_ethtool *ptr)
+{
+	int err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE1,
+					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
+					  &ptr->tx_equalization_pre1);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE3,
+					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
+					  &ptr->tx_equalization_pre3);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_ATTEN,
+					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
+					  &ptr->tx_equalization_atten);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_POST1,
+					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
+					  &ptr->tx_equalization_post1);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_TX_EQU_PRE2,
+					  ICE_AQC_OP_CODE_TX_EQU, serdes_num,
+					  &ptr->tx_equalization_pre2);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE2,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_pre2);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_PRE1,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_pre1);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_POST1,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_post1);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFLF,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_bflf);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_BFHF,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_bfhf);
+	if (err)
+		return err;
+
+	err = ice_aq_get_phy_equalization(hw, ICE_AQC_RX_EQU_DRATE,
+					  ICE_AQC_OP_CODE_RX_EQU, serdes_num,
+					  &ptr->rx_equalization_drate);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/**
+ * ice_get_extended_regs - returns FEC correctable, uncorrectable stats per
+ *                         pcsquad, pcsport
+ * @netdev: pointer to net device structure
+ * @p: output buffer to fill requested register dump
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_get_extended_regs(struct net_device *netdev, void *p)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_regdump_to_ethtool *ice_prv_regs_buf;
+	struct ice_port_topology port_topology = {};
+	struct ice_port_info *pi;
+	struct ice_pf *pf;
+	struct ice_hw *hw;
+	unsigned int i;
+	int err;
+
+	pf = np->vsi->back;
+	hw = &pf->hw;
+	pi = np->vsi->port_info;
+
+	if (!hw || !pi)
+		return -EINVAL;
+
+	/* Serdes parameters are not supported if not the PF VSI */
+	if (np->vsi->type != ICE_VSI_PF)
+		return -EINVAL;
+
+	err = ice_get_port_topology(hw, pi->lport, &port_topology);
+	if (err)
+		return -EINVAL;
+	if (port_topology.serdes_lane_count > 4)
+		return -EINVAL;
+
+	ice_prv_regs_buf = p;
+
+	/* Get serdes equalization parameter for available serdes */
+	for (i = 0; i < port_topology.serdes_lane_count; i++) {
+		u8 serdes_num = 0;
+
+		serdes_num = port_topology.primary_serdes_lane + i;
+		err = ice_get_tx_rx_equa(hw, serdes_num,
+					 &ice_prv_regs_buf->equalization[i]);
+		if (err)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 {
@@ -690,10 +825,12 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 	u32 *regs_buf = (u32 *)p;
 	unsigned int i;
 
-	regs->version = 1;
+	regs->version = 2;
 
 	for (i = 0; i < ARRAY_SIZE(ice_regs_dump_list); ++i)
 		regs_buf[i] = rd32(hw, ice_regs_dump_list[i]);
+
+	ice_get_extended_regs(netdev, (void *)&regs_buf[i]);
 }
 
 static u32 ice_get_msglevel(struct net_device *netdev)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index ffc8ad180e61..9acccae38625 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -9,6 +9,25 @@ struct ice_phy_type_to_ethtool {
 	u8 link_mode;
 };
 
+struct ice_serdes_equalization_to_ethtool {
+	int rx_equalization_pre2;
+	int rx_equalization_pre1;
+	int rx_equalization_post1;
+	int rx_equalization_bflf;
+	int rx_equalization_bfhf;
+	int rx_equalization_drate;
+	int tx_equalization_pre1;
+	int tx_equalization_pre3;
+	int tx_equalization_atten;
+	int tx_equalization_post1;
+	int tx_equalization_pre2;
+};
+
+struct ice_regdump_to_ethtool {
+	/* A multilane port can have max 4 serdes */
+	struct ice_serdes_equalization_to_ethtool equalization[4];
+};
+
 /* Port topology from lport i.e.
  * serdes mapping, pcsquad, macport, cage etc...
  */
-- 
2.41.0


