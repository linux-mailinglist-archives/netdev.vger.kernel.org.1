Return-Path: <netdev+bounces-87514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D295A8A3601
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021811C209C3
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958B14F135;
	Fri, 12 Apr 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJaqG0Em"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFC502A9
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947905; cv=none; b=JHmqQbt0xv8EitjdfFW1wogOzeNvdgotj2SllY+fJSuz/8p14CqbK57MXfr814vmLgY45d/kw647xanjBAh2jQjDA+rYqwSLnhD+OeXfxKYzTorfLK1APB0YMtKawujtup35REZTufuPXgS/N+AkaHwzfXbh7kIubnznz4y05rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947905; c=relaxed/simple;
	bh=C1n0JUMJRZEnvSoNyQ+RhO3iZKimcefA3cUodRUoG94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkixkbTJGU4R7gCbGsHZim4Rk7aVwUkQe4UUuRMGJMGrqn2f9OW8+QshbgyLcYOvPkQ0B6o12EE1fRsttRyBXh6nvuR5LLlYma4SpiefTE7y2sho6M+WiJt3bptXqjmWDmASsddDLgJhDa8C7DDecWE0x5tHUpFNeQLSeDqkZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJaqG0Em; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712947903; x=1744483903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C1n0JUMJRZEnvSoNyQ+RhO3iZKimcefA3cUodRUoG94=;
  b=VJaqG0EmjiL7rSiR2Vu53CPNxEQlO+6labwPdEO/tD9IfPAm9cqKovL1
   L5f5uvTV/DccJido60QEBV2dK9KXwK9rjZHSXTP5hiUCPdb3lB9Qz5P6b
   Otozq9EnZHAr6sQvY0UQkuYn2eFV2QWyt08HCI1Ty4eaSaieK1GaKnivE
   khjBeucTWqEMydM64v40faG+P9nxAZ48A5Z4/eZTGAwdRuv9iWIEX1cjR
   FO3oF505702ieSeT+nuWd+q/MVB3xqeA+o3Onzeymf0kLiI0eBSrsM49s
   R0x7B2mYVcTgmQwJd9Xzcv4IgR1zS767Xh1/3xFWa92sWN3jO07CXMYJR
   A==;
X-CSE-ConnectionGUID: 0Bbrj8dsRDCAc6rBeY5gBg==
X-CSE-MsgGUID: fgsn8RNUQhCOlCfpfR8A0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8333633"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8333633"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:41 -0700
X-CSE-ConnectionGUID: PFqzwmmTTVGew0q0ZZVciw==
X-CSE-MsgGUID: MFkEEJucTh+YS0JcxYbSXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="26108558"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 11:51:42 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	leszek.pepiak@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	Anil Samal <anil.samal@intel.com>
Subject: [PATCH iwl-next 1/4] ice: Implement new API to derive physical topology of  input port
Date: Fri, 12 Apr 2024 11:49:17 -0700
Message-ID: <20240412185135.297368-2-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412185135.297368-1-anil.samal@intel.com>
References: <20240412185135.297368-1-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some phy configurations such as serdes equalizer parameters, are applied
per serdes lane. Hence firmware requires serdes lane number to read
serdes equalizer values. Similarly firmware requires PCS quad number
and PCS port number to read FEC statistics. Current driver
implementation does not maintain above physical properties of a port.

Add new driver API to derive physical properties of an input port. These
properties include PCS quad number, PCS port number, serdes lane count,
primary serdes lane number.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 265 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  10 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   2 +
 3 files changed, 277 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..6884b45c3b0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -466,6 +466,271 @@ static int ice_get_regs_len(struct net_device __always_unused *netdev)
 	return sizeof(ice_regs_dump_list);
 }
 
+/**
+ * ice_ethtool_get_maxspeed - Get the max speed for given lport
+ * @hw: pointer to the HW struct
+ * @lport: logical port for which max speed is requested
+ * @max_speed: return max speed for input lport
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int ice_ethtool_get_maxspeed(struct ice_hw *hw, u8 lport, u8 *max_speed)
+{
+	struct ice_aqc_get_port_options_elem options[ICE_AQC_PORT_OPT_MAX] = {};
+	bool active_valid = false, pending_valid = true;
+	u8 option_count = ICE_AQC_PORT_OPT_MAX;
+	u8 active_idx = 0, pending_idx = 0;
+	int status = 0;
+
+	if (!max_speed || !hw)
+		return -EINVAL;
+
+	*max_speed = 0;
+
+	status = ice_aq_get_port_options(hw, options, &option_count, lport,
+					 true, &active_idx, &active_valid,
+					 &pending_idx, &pending_valid);
+
+	if (status) {
+		ice_debug(hw, ICE_DBG_PHY, "Port split read err: %d\n", status);
+		return -EIO;
+	}
+
+	if (active_valid) {
+		ice_debug(hw, ICE_DBG_PHY, "Active idx: %d\n", active_idx);
+	} else {
+		ice_debug(hw, ICE_DBG_PHY, "No valid Active option\n");
+		return -EINVAL;
+	}
+	*max_speed = options[active_idx].max_lane_speed & ICE_AQC_PORT_OPT_MAX_LANE_M;
+	return 0;
+}
+
+/**
+ * ice_is_serdes_muxed - returns whether serdes is muxed in hardware
+ * @hw: pointer to the HW struct
+ *
+ * Returns True : when serdes is muxed, False: when serdes is not muxed
+ */
+static bool ice_is_serdes_muxed(struct ice_hw *hw)
+{
+	u32 reg_value = rd32(hw, GLGEN_SWITCH_MODE_CONFIG);
+
+	return FIELD_GET(GLGEN_SWITCH_MODE_CONFIG_SELECT_25X4_ON_SINGLE_QUAD_M,
+			 reg_value);
+}
+
+/**
+ * ice_map_port_topology_for_sfp - Fills port topology with  pcsquad, pcsport,
+ *                         primary serdes lane number
+ * @port_topology: buffer to hold port topology
+ * @lport: logical port for which physical info requested
+ * @is_muxed: logical port for which physical info requested
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int ice_map_port_topology_for_sfp(struct ice_port_topology *port_topology,
+					 u8 lport, bool is_muxed)
+{
+	if (!port_topology)
+		return -EINVAL;
+
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
+	return 0;
+}
+
+/**
+ * ice_map_port_topology_for_qsfp - Fills port topology with  pcsquad, pcsport,
+ *                         primary serdes lane number
+ * @port_topology: buffer to hold port topology
+ * @lport: logical port for which physical info requested
+ * @is_muxed: logical port for which physical info requested
+ *
+ * Returns 0 on success, negative on failure.
+ */
+static int ice_map_port_topology_for_qsfp(struct ice_port_topology *port_topology,
+					  u8 lport, bool is_muxed)
+{
+	if (!port_topology)
+		return -EINVAL;
+
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
+ * Returns 0 on success, negative on failure.
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
+	if (!hw || !port_topology)
+		return -EINVAL;
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
+	if (hw->device_id >= ICE_DEV_ID_E810_XXV_BACKPLANE) {
+		port_topology->serdes_lane_count = 1;
+		if (lport == 0) {
+			port_topology->pcs_quad_select = 0;
+			port_topology->pcs_port = 0;
+			port_topology->primary_serdes_lane = 0;
+		} else if (lport == 1) {
+			port_topology->pcs_quad_select = 1;
+			port_topology->pcs_port = 0;
+			port_topology->primary_serdes_lane = 1;
+		} else {
+			return -EINVAL;
+		}
+	} else {
+		if (cage_type == 0x11 ||	/* SFP+ */
+		    cage_type == 0x12) {	/* SFP28 */
+			port_topology->serdes_lane_count = 1;
+			err = ice_map_port_topology_for_sfp(port_topology, lport, is_muxed);
+			if (err)
+				return err;
+		} else if (cage_type == 0x13 ||	/* QSFP */
+			   cage_type == 0x14) {	/* QSFP28 */
+			u8 max_speed = 0;
+
+			err = ice_ethtool_get_maxspeed(hw, lport, &max_speed);
+			if (err)
+				return err;
+			if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_100G)
+				port_topology->serdes_lane_count = 4;
+			else if (max_speed == ICE_AQC_PORT_OPT_MAX_LANE_50G)
+				port_topology->serdes_lane_count = 2;
+			else
+				port_topology->serdes_lane_count = 1;
+
+			err = ice_map_port_topology_for_qsfp(port_topology, lport, is_muxed);
+			if (err)
+				return err;
+		} else {
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 static void
 ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 {
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
index cfac1d432c15..6604baa37c4a 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -157,6 +157,8 @@
 #define GLGEN_RTRIG_CORER_M			BIT(0)
 #define GLGEN_RTRIG_GLOBR_M			BIT(1)
 #define GLGEN_STAT				0x000B612C
+#define GLGEN_SWITCH_MODE_CONFIG		0x000B81E0 /* Reset Source: POR */
+#define GLGEN_SWITCH_MODE_CONFIG_SELECT_25X4_ON_SINGLE_QUAD_M BIT(2)
 #define GLGEN_VFLRSTAT(_i)			(0x00093A04 + ((_i) * 4))
 #define PFGEN_CTRL				0x00091000
 #define PFGEN_CTRL_PFSWR_M			BIT(0)
-- 
2.44.0


