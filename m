Return-Path: <netdev+bounces-97972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DED8CE664
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954831F23048
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700212C466;
	Fri, 24 May 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFHCCVj1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E2512C48F
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558789; cv=none; b=McDpxzvbOZn3KA+CH+XXQhSOcdFrT95md1N4ulgI7rPowU5T2PyfKkICvCEYc3DZatVTRZ3R3oRRbSE6djnfaQik7mCAwzsrqsVgcDUXnRTzNjQMjk1NKrL6+pnBmWbfiXD8m/Orjo5DoxBLjuDWLU4rnanKmpuqXuJZnluloII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558789; c=relaxed/simple;
	bh=KbNYbeJ4tJH9FRIP1a3Gy2uwPidFI+FOEWtJowZ8/vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p24WGYKTEySi6YqSWIXdOiOGCmK2ee4Tf+xceJZBDEFLjQBSeYKB1YW4cuGrYKIfuBRd5mjA8qC6rDHCh3rXyH1Y3f/h2xY8KpPFlH53NLLhlUBfv6Xfb8YlzN37PufgrUJRUsp3kxiwzQJhy3UocI/CozSuBksAlPkpbjUEwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFHCCVj1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716558787; x=1748094787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KbNYbeJ4tJH9FRIP1a3Gy2uwPidFI+FOEWtJowZ8/vs=;
  b=FFHCCVj16xqZCAdipyh1LEHdu7tIpAIAq/3hoUZzIhObAwPwuB0+PQaT
   GQFLyjImtBW4Rrjkuyh9NZ0UNlhMeqOKYoJSKCwqMpu7R340EMkoLQ0I8
   2fXDSA8vAXvEs3fqaXdngIkq8luam35O2oW5x37mTg3HA29ylQczIHiWH
   t51X03wW4XsZ5+mIljuO+bl5YAvwjMGRLZ81SwqyXsk0gNsIV0DmZQp6f
   y9qgSgZzx+dAHTduA7Se8WGqX0tOYu7fs25i8CbTt5QRgr/YqJ3P5DRF6
   yYwp8ZQgo5aqhX2B1N2xn7bej3P+zLZ+SBBGDtD40wJOCFxKEUnqTvyub
   w==;
X-CSE-ConnectionGUID: 4OlTZghUSNWehPCLdPiloQ==
X-CSE-MsgGUID: R9r9riyZT3ibkp4jOnFTBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13111911"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="13111911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 06:53:05 -0700
X-CSE-ConnectionGUID: ZJqR3O6CRuSVs5yixeT/Tw==
X-CSE-MsgGUID: vibUS1IkSQCRn2u92AewQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="64837191"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 06:53:04 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Anil Samal <anil.samal@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v3 2/3]     ice: Implement driver functionality to dump fec     statistics
Date: Fri, 24 May 2024 06:51:06 -0700
Message-ID: <20240524135255.3607422-3-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240524135255.3607422-1-anil.samal@intel.com>
References: <20240524135255.3607422-1-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    To debug link issues in the field, it is paramount to
    dump fec corrected/uncorrected block counts from firmware.
    Firmware requires PCS quad number and PCS port number to
    read FEC statistics. Current driver implementation does
    not maintain above physical properties of a port.

    Add new driver API to derive physical properties of an input port.
    These properties include PCS quad number, PCS port number, serdes
    lane count, primary serdes lane number.

    Extend ethtool option '--show-fec' to support fec statistics.
    The IEEE standard mandates two sets of counters:
     - 30.5.1.1.17 aFECCorrectedBlocks
     - 30.5.1.1.18 aFECUncorrectableBlocks

    Standard defines above statistics per lane but current
    implementation supports total FEC statistics per port
    i.e. sum of all lane per port. Find sample output below

     # ethtool -I --show-fec ens21f0np0
    FEC parameters for ens21f0np0:
    Supported/Configured FEC encodings: Auto RS BaseR
    Active FEC encoding: RS
    Statistics:
      corrected_blocks: 0
      uncorrectable_blocks: 0

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   |  57 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |  24 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 308 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  10 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   8 +
 6 files changed, 409 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b607b67efa99..6430829ce98b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3299,6 +3299,63 @@ int ice_update_link_info(struct ice_port_info *pi)
 	return status;
 }
 
+#define FEC_REG_PORT(port) {	\
+	FEC_CORR_LOW_REG_PORT##port,		\
+	FEC_CORR_HIGH_REG_PORT##port,	\
+	FEC_UNCORR_LOW_REG_PORT##port,	\
+	FEC_UNCORR_HIGH_REG_PORT##port,	\
+}
+
+static const u32 fec_reg[][ICE_FEC_MAX] = {
+	FEC_REG_PORT(0),
+	FEC_REG_PORT(1),
+	FEC_REG_PORT(2),
+	FEC_REG_PORT(3)
+};
+
+/**
+ * ice_aq_get_fec_stats - reads fec stats from phy
+ * @hw: pointer to the HW struct
+ * @pcs_quad: represents pcsquad of user input serdes
+ * @pcs_port: represents the pcs port number part of above pcs quad
+ * @fec_type: represents FEC stats type
+ * @output: pointer to the caller-supplied buffer to return requested fec stats
+ *
+ * Return: non-zero status on error and 0 on success.
+ */
+int ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+			 enum ice_fec_stats_types fec_type, u32 *output)
+{
+	u16 flag = (ICE_AQ_FLAG_RD | ICE_AQ_FLAG_BUF | ICE_AQ_FLAG_SI);
+	struct ice_sbq_msg_input msg = {};
+	u32 receiver_id, reg_offset;
+	int err;
+
+	if (pcs_port > 3)
+		return -EINVAL;
+
+	reg_offset = fec_reg[pcs_port][fec_type];
+
+	if (pcs_quad == 0)
+		receiver_id = FEC_RECEIVER_ID_PCS0;
+	else if (pcs_quad == 1)
+		receiver_id = FEC_RECEIVER_ID_PCS1;
+	else
+		return -EINVAL;
+
+	msg.msg_addr_low = lower_16_bits(reg_offset);
+	msg.msg_addr_high = receiver_id;
+	msg.opcode = ice_sbq_msg_rd;
+	msg.dest_dev = rmn_0;
+
+	err = ice_sbq_rw_reg(hw, &msg, flag);
+	if (err)
+		return err;
+
+	*output = msg.data;
+	return 0;
+}
+
 /**
  * ice_cache_phy_user_req
  * @pi: port information structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 42cda1bbbaab..6b888efce593 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -17,6 +17,27 @@
 #define ICE_SQ_SEND_DELAY_TIME_MS	10
 #define ICE_SQ_SEND_MAX_EXECUTE		3
 
+#define FEC_REG_SHIFT 2
+#define FEC_RECV_ID_SHIFT 4
+#define FEC_CORR_LOW_REG_PORT0 (0x02 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT0 (0x03 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT0 (0x04 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT0 (0x05 << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT1 (0x42 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT1 (0x43 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT1 (0x44 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT1 (0x45 << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT2 (0x4A << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT2 (0x4B << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT2 (0x4C << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT2 (0x4D << FEC_REG_SHIFT)
+#define FEC_CORR_LOW_REG_PORT3 (0x52 << FEC_REG_SHIFT)
+#define FEC_CORR_HIGH_REG_PORT3 (0x53 << FEC_REG_SHIFT)
+#define FEC_UNCORR_LOW_REG_PORT3 (0x54 << FEC_REG_SHIFT)
+#define FEC_UNCORR_HIGH_REG_PORT3 (0x55 << FEC_REG_SHIFT)
+#define FEC_RECEIVER_ID_PCS0 (0x33 << FEC_RECV_ID_SHIFT)
+#define FEC_RECEIVER_ID_PCS1 (0x34 << FEC_RECV_ID_SHIFT)
+
 int ice_init_hw(struct ice_hw *hw);
 void ice_deinit_hw(struct ice_hw *hw);
 int ice_check_reset(struct ice_hw *hw);
@@ -121,6 +142,9 @@ int
 ice_get_link_default_override(struct ice_link_default_override_tlv *ldo,
 			      struct ice_port_info *pi);
 bool ice_is_phy_caps_an_enabled(struct ice_aqc_get_phy_caps_data *caps);
+int
+ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+		     enum ice_fec_stats_types fec_type, u32 *output);
 
 enum ice_fc_mode ice_caps_to_fc_mode(u8 caps);
 enum ice_fec_mode ice_caps_to_fec_mode(u8 caps, u8 fec_options);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..962a7666827d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -466,6 +466,221 @@ static int ice_get_regs_len(struct net_device __always_unused *netdev)
 	return sizeof(ice_regs_dump_list);
 }
 
+/**
+ * ice_ethtool_get_maxspeed - Get the max speed for given lport
+ * @hw: pointer to the HW struct
+ * @lport: logical port for which max speed is requested
+ * @max_speed: return max speed for input lport
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_ethtool_get_maxspeed(struct ice_hw *hw, u8 lport, u8 *max_speed)
+{
+	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX] = {};
+	bool active_valid = false, pending_valid = true;
+	u8 option_count = ICE_AQC_PORT_OPT_MAX;
+	u8 active_idx = 0, pending_idx = 0;
+	int status;
+
+	status = ice_aq_get_port_options(hw, options, &option_count, lport,
+					 true, &active_idx, &active_valid,
+					 &pending_idx, &pending_valid);
+	if (status)
+		return -EIO;
+	if (!active_valid)
+		return -EINVAL;
+
+	*max_speed = options[active_idx].max_lane_speed & ICE_AQC_PORT_OPT_MAX_LANE_M;
+	return 0;
+}
+
+/**
+ * ice_is_serdes_muxed - returns whether serdes is muxed in hardware
+ * @hw: pointer to the HW struct
+ *
+ * Return: true when serdes is muxed, false when serdes is not muxed.
+ */
+static bool ice_is_serdes_muxed(struct ice_hw *hw)
+{
+	u32 reg_value = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
+
+	return FIELD_GET(GLGEN_25X4_ON_SINGLE_QUAD_M, reg_value);
+}
+
+static int ice_map_port_topology_for_sfp(struct ice_port_topology *port_topology,
+					 u8 lport, bool is_muxed)
+{
+	switch (lport) {
+	case 0:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 0;
+		port_topology->primary_serdes_lane = 0;
+		break;
+	case 1:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 0;
+		if (is_muxed)
+			port_topology->primary_serdes_lane = 2;
+		else
+			port_topology->primary_serdes_lane = 4;
+		break;
+	case 2:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 1;
+		port_topology->primary_serdes_lane = 1;
+		break;
+	case 3:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 1;
+		if (is_muxed)
+			port_topology->primary_serdes_lane = 3;
+		else
+			port_topology->primary_serdes_lane = 5;
+		break;
+	case 4:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 2;
+		port_topology->primary_serdes_lane = 2;
+		break;
+	case 5:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 2;
+		port_topology->primary_serdes_lane = 6;
+		break;
+	case 6:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 3;
+		port_topology->primary_serdes_lane = 3;
+		break;
+	case 7:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 3;
+		port_topology->primary_serdes_lane = 7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ice_map_port_topology_for_qsfp(struct ice_port_topology *port_topology,
+					  u8 lport, bool is_muxed)
+{
+	switch (lport) {
+	case 0:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 0;
+		port_topology->primary_serdes_lane = 0;
+		break;
+	case 1:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 0;
+		if (is_muxed)
+			port_topology->primary_serdes_lane = 2;
+		else
+			port_topology->primary_serdes_lane = 4;
+		break;
+	case 2:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 1;
+		port_topology->primary_serdes_lane = 1;
+		break;
+	case 3:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 1;
+		if (is_muxed)
+			port_topology->primary_serdes_lane = 3;
+		else
+			port_topology->primary_serdes_lane = 5;
+		break;
+	case 4:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 2;
+		port_topology->primary_serdes_lane = 2;
+		break;
+	case 5:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 2;
+		port_topology->primary_serdes_lane = 6;
+		break;
+	case 6:
+		port_topology->pcs_quad_select = 0;
+		port_topology->pcs_port = 3;
+		port_topology->primary_serdes_lane = 3;
+		break;
+	case 7:
+		port_topology->pcs_quad_select = 1;
+		port_topology->pcs_port = 3;
+		port_topology->primary_serdes_lane = 7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_get_port_topology - returns physical topology like pcsquad, pcsport,
+ *                         serdes number
+ * @hw: pointer to the HW struct
+ * @lport: logical port for which physical info requested
+ * @port_topology: buffer to hold port topology
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_get_port_topology(struct ice_hw *hw, u8 lport,
+				 struct ice_port_topology *port_topology)
+{
+	struct ice_aqc_get_link_topo cmd = {};
+	u16 node_handle = 0;
+	u8 cage_type = 0;
+	bool is_muxed;
+	int err;
+	u8 ctx;
+
+	ctx = ICE_AQC_LINK_TOPO_NODE_TYPE_CAGE << ICE_AQC_LINK_TOPO_NODE_TYPE_S;
+	ctx |= ICE_AQC_LINK_TOPO_NODE_CTX_PORT << ICE_AQC_LINK_TOPO_NODE_CTX_S;
+	cmd.addr.topo_params.node_type_ctx = ctx;
+
+	err = ice_aq_get_netlist_node(hw, &cmd, &cage_type, &node_handle);
+	if (err)
+		return -EINVAL;
+
+	is_muxed = ice_is_serdes_muxed(hw);
+
+	if (cage_type == 0x11 ||	/* SFP+ */
+	    cage_type == 0x12) {	/* SFP28 */
+		port_topology->serdes_lane_count = 1;
+		err = ice_map_port_topology_for_sfp(port_topology, lport, is_muxed);
+		if (err)
+			return err;
+	} else if (cage_type == 0x13 ||	/* QSFP */
+		   cage_type == 0x14) {	/* QSFP28 */
+		u8 max_speed = 0;
+
+		err = ice_ethtool_get_maxspeed(hw, lport, &max_speed);
+		if (err)
+			return err;
+
+		if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
+			port_topology->serdes_lane_count = 4;
+		else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
+			port_topology->serdes_lane_count = 2;
+		else
+			port_topology->serdes_lane_count = 1;
+
+		err = ice_map_port_topology_for_qsfp(port_topology, lport, is_muxed);
+		if (err)
+			return err;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 {
@@ -4297,6 +4512,98 @@ ice_get_module_eeprom(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ice_get_port_fec_stats - returns FEC correctable, uncorrectable stats per
+ *                          pcsquad, pcsport
+ * @hw: pointer to the HW struct
+ * @pcs_quad: pcsquad for input port
+ * @pcs_port: pcsport for input port
+ * @fec_stats: buffer to hold FEC statistics for given port
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_get_port_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
+				  struct ethtool_fec_stats *fec_stats)
+{
+	u32 fec_uncorr_low_val = 0, fec_uncorr_high_val = 0;
+	u32 fec_corr_low_val = 0, fec_corr_high_val = 0;
+	int err;
+
+	if (pcs_quad > 1 || pcs_port > 3)
+		return -EINVAL;
+
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port, ICE_FEC_CORR_LOW,
+				   &fec_corr_low_val);
+	if (err)
+		return err;
+
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port, ICE_FEC_CORR_HIGH,
+				   &fec_corr_high_val);
+	if (err)
+		return err;
+
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port,
+				   ICE_FEC_UNCORR_LOW,
+				   &fec_uncorr_low_val);
+	if (err)
+		return err;
+
+	err = ice_aq_get_fec_stats(hw, pcs_quad, pcs_port,
+				   ICE_FEC_UNCORR_HIGH,
+				   &fec_uncorr_high_val);
+	if (err)
+		return err;
+
+	fec_stats->uncorrectable_blocks.total = (fec_corr_high_val << 16) +
+						 fec_corr_low_val;
+	fec_stats->corrected_blocks.total = (fec_uncorr_high_val << 16) +
+					     fec_uncorr_low_val;
+	return 0;
+}
+
+/**
+ * ice_get_fec_stats - returns FEC correctable, uncorrectable stats per netdev
+ * @netdev: network interface device structure
+ * @fec_stats: buffer to hold FEC statistics for given port
+ *
+ */
+static void ice_get_fec_stats(struct net_device *netdev,
+			      struct ethtool_fec_stats *fec_stats)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_port_topology port_topology;
+	struct ice_port_info *pi;
+	struct ice_pf *pf;
+	struct ice_hw *hw;
+	int err;
+
+	pf = np->vsi->back;
+	hw = &pf->hw;
+	pi = np->vsi->port_info;
+
+	if (!hw || !pi)
+		return;
+
+	/* Serdes parameters are not supported if not the PF VSI */
+	if (np->vsi->type != ICE_VSI_PF)
+		return;
+
+	err = ice_get_port_topology(hw, pi->lport, &port_topology);
+	if (err) {
+		netdev_info(netdev, "Extended register dump failed Lport %d\n",
+			    pi->lport);
+		return;
+	}
+
+	/* Get FEC correctable, uncorrectable counter */
+	err = ice_get_port_fec_stats(hw, port_topology.pcs_quad_select,
+				     port_topology.pcs_port, fec_stats);
+	if (err) {
+		netdev_info(netdev, "FEC stats get failed Lport %d Err %d\n",
+			    pi->lport, err);
+	}
+}
+
 static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_ctx_supported  = true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
@@ -4305,6 +4612,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.cap_rss_sym_xor_supported = true,
 	.get_link_ksettings	= ice_get_link_ksettings,
 	.set_link_ksettings	= ice_set_link_ksettings,
+	.get_fec_stats		= ice_get_fec_stats,
 	.get_drvinfo		= ice_get_drvinfo,
 	.get_regs_len		= ice_get_regs_len,
 	.get_regs		= ice_get_regs,
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index b88e3da06f13..ffc8ad180e61 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -9,6 +9,16 @@ struct ice_phy_type_to_ethtool {
 	u8 link_mode;
 };
 
+/* Port topology from lport i.e.
+ * serdes mapping, pcsquad, macport, cage etc...
+ */
+struct ice_port_topology {
+	u16 pcs_port;
+	u16 primary_serdes_lane;
+	u16 serdes_lane_count;
+	u16 pcs_quad_select;
+};
+
 /* Macro to make PHY type to Ethtool link mode table entry.
  * The index is the PHY type.
  */
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index cfac1d432c15..190230fba429 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -157,6 +157,8 @@
 #define GLGEN_RTRIG_CORER_M			BIT(0)
 #define GLGEN_RTRIG_GLOBR_M			BIT(1)
 #define GLGEN_STAT				0x000B612C
+#define GLGEN_SWITCH_MODE_CONFIG		0x000B81E0 /* Reset Source: POR */
+#define GLGEN_25X4_ON_SINGLE_QUAD_M		BIT(2)
 #define GLGEN_VFLRSTAT(_i)			(0x00093A04 + ((_i) * 4))
 #define PFGEN_CTRL				0x00091000
 #define PFGEN_CTRL_PFSWR_M			BIT(0)
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index f0796a93f428..0aa17105dbdf 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -71,6 +71,14 @@ enum ice_aq_res_ids {
 	ICE_GLOBAL_CFG_LOCK_RES_ID
 };
 
+enum ice_fec_stats_types {
+	ICE_FEC_CORR_LOW,
+	ICE_FEC_CORR_HIGH,
+	ICE_FEC_UNCORR_LOW,
+	ICE_FEC_UNCORR_HIGH,
+	ICE_FEC_MAX
+};
+
 /* FW update timeout definitions are in milliseconds */
 #define ICE_NVM_TIMEOUT			180000
 #define ICE_CHANGE_LOCK_TIMEOUT		1000
-- 
2.44.0


