Return-Path: <netdev+bounces-109921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49E92A46C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57871C2152F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7901F13D639;
	Mon,  8 Jul 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co4Y5/XT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5D84E11
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448169; cv=none; b=gd8fNJ5OS4dPnTwmaSWUtkn1WPOyJjC//Rw/qZ68zz5rvoXxPz0Cmx6I7sfpX1YszAOGmnQpEtdD8FNMF2TV4n67+x+kFe5DCVO8YjK+fKxiRlv0f+kNzunC2Zte+FRmsL3LIiSRZnf5Z622MdrSz85DVZlOiZ6kdCiUJ8zHQv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448169; c=relaxed/simple;
	bh=8LNdUKciQQ+60cdkA03RWLpW3Iz2Yt9nOIqtcJHjYdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEPx7GkNDdlw2pBSRFXBWKd2TyX/EwXugWlj4ZgKrmIJLYKRlZtsMhR7fSE3lkzfUsY6Jef8tEf/tuBsLbA+4uoxIFZZakKZSxU5szt80MQB4BXoPur/QyO5LJj6hjqS1b+vvQvJk+CB5mC4R2BVwMf99Quqp+DlK4btDfcOUbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co4Y5/XT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720448168; x=1751984168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8LNdUKciQQ+60cdkA03RWLpW3Iz2Yt9nOIqtcJHjYdQ=;
  b=co4Y5/XTg2TTfpAvUPNJgjfwAaotq9bs1Z1nmUhgRYWUb9PcUXtPP1d7
   TeijiTinc8QlB96yZreIhGHoQPlu+kQTR4UFxrIytgZLkBbTp8WzoKl55
   VaRo3xzIbi5ebtP9yZUQG3nzBkwINmux9Nh6eLtaMPq8s4kKK2UpxNmiZ
   /6UfaSOxsHpLpZLMDii4v1shiv5BmKHZ/Z8irGJ9gIzkUtb5+FzW48Alk
   bZUfSgfA9yG7ky26HS8Sq3ofZglGMvmQLu7pcaBEMzuRUXICj8+oYXvaf
   BU62nykOoaWjny8EtNpi1NkkujgBWezcf4JQeP6hiUBc3+mweoq+wjcLp
   Q==;
X-CSE-ConnectionGUID: dc/3/xGTQk2uDeGzW6YB+w==
X-CSE-MsgGUID: +QEznhP3RvezQyMv6LLQZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29051637"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="29051637"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:16:05 -0700
X-CSE-ConnectionGUID: XlXOhCofSm2ab3cnjd7j2Q==
X-CSE-MsgGUID: dndZEPTVQFqtz2Lo++c1wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47946985"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:16:04 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	kuba@kernel.org,
	Anil Samal <anil.samal@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v4 3/3] ice: Implement driver functionality to dump serdes equalizer values
Date: Mon,  8 Jul 2024 07:09:20 -0700
Message-ID: <20240708141555.1327670-4-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708141555.1327670-1-anil.samal@intel.com>
References: <20240708141555.1327670-1-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To debug link issues in the field, serdes Tx/Rx equalizer values help to
determine the health of serdes lane.

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
---
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  51 +++++++
 drivers/net/ethernet/intel/ice/ice_common.c   |  37 +++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 138 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  19 +++
 5 files changed, 245 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 9683842f8880..66f02988d549 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1470,6 +1470,55 @@ struct ice_aqc_get_sensor_reading_resp {
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
@@ -2573,6 +2622,7 @@ struct ice_aq_desc {
 		struct ice_aqc_get_link_status get_link_status;
 		struct ice_aqc_event_lan_overflow lan_overflow;
 		struct ice_aqc_get_link_topo get_link_topo;
+		struct ice_aqc_dnl_call_command dnl_call;
 		struct ice_aqc_i2c read_write_i2c;
 		struct ice_aqc_read_i2c_resp read_i2c_resp;
 		struct ice_aqc_get_set_tx_topo get_set_tx_topo;
@@ -2697,6 +2747,7 @@ enum ice_adminq_opc {
 	ice_aqc_opc_set_phy_rec_clk_out			= 0x0630,
 	ice_aqc_opc_get_phy_rec_clk_out			= 0x0631,
 	ice_aqc_opc_get_sensor_reading			= 0x0632,
+	ice_aqc_opc_dnl_call                            = 0x0682,
 	ice_aqc_opc_get_link_topo			= 0x06E0,
 	ice_aqc_opc_read_i2c				= 0x06E2,
 	ice_aqc_opc_write_i2c				= 0x06E3,
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 891fabfa4bb3..9cd649053ef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3375,6 +3375,43 @@ int ice_update_link_info(struct ice_port_info *pi)
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
index 5672e48ffa2a..27208a60cece 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -143,6 +143,8 @@ int
 ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
+int ice_aq_get_phy_equalization(struct ice_hw *hw, u16 data_in, u16 op_code,
+				u8 serdes_num, int *output);
 int
 ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 		     enum ice_fec_stats_types fec_type, u32 *output);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 1d88dbac7287..39d2652c3ee1 100644
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
@@ -681,6 +682,137 @@ static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
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
+	/* Serdes parameters are not supported if not the PF VSI */
+	if (np->vsi->type != ICE_VSI_PF || !pi)
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
@@ -689,10 +821,12 @@ ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
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
2.44.0


