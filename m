Return-Path: <netdev+bounces-149809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9F19E7913
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951851885BCD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450621B8F9;
	Fri,  6 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2CLXwBP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E521B1BC
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513751; cv=none; b=X53GyFueO7uanWyrXLJXag/OUElvEFjHjUS6mWWnzzbJmj4T7V9WeyJ8DbY27lco8+RLAsA+u5YDBl2ML2NlMIVZi6cF38wNGrP/JnbpQ2AHxVv1RNyjBXe2NuweWrmuJCXBq/ZPLk8nzjeobmj+zp7rE/ILO2SUobOb+kfsG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513751; c=relaxed/simple;
	bh=M3q8iCNw/x5vlDCFOFd+zNzDkg4IHujBw3gVEhhSjDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIqxu/O30ln//N+Tp77yrWHZP1hN4AnxLb1TVTpsBJWbCac67WjB05nv6JGADkfCDOZPH1ycuiP0r39fXfburTuSXyVC4H5w3Nl3BvqXTuX09oRRw0tBFD/uLqUjpb9xaGn/188FZJ3pb0w4nAU3Sv1d2yzQxWNXPpGK+3hzzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2CLXwBP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733513749; x=1765049749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M3q8iCNw/x5vlDCFOFd+zNzDkg4IHujBw3gVEhhSjDI=;
  b=Z2CLXwBPESUyCuAb7YmqxEeGJP6sWEphOBGBvQJ/obhULC0OuTIDvVwO
   xWQfCc3CA7Y7HT+ldSXOAc6syVIpLnLJTNEC2iWbM4s4gqkvILVCvXDPp
   D3iTtjjC8uBLNe41y0r2DVHGlknd5VosEpbPkXnrm4ylQ+QSPZ6mH0P+P
   9MXqMwYFACzKbN0Wf9lVt1k/yBYW5IqLb2U9bMiiY67g0UGKMXNjCa3et
   NaadxNE+qq1YOczRP6pBuBO7kEzqN/VpU/4oppjZ3ddsrQjvxK/g9yXMF
   Sk5AlFNF21QX6aIvssOrxF/oY6dLjOWgNILlqDNvucNVwO7phx93Ju/cV
   w==;
X-CSE-ConnectionGUID: vuM1eMNrQJmqzely+Xhh/w==
X-CSE-MsgGUID: klWI/lJCSE68s9F4hHgQmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="33226567"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="33226567"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 11:35:46 -0800
X-CSE-ConnectionGUID: fDNmVhEsQgScW0PcTDbyTw==
X-CSE-MsgGUID: bweR5XYjTrmwEe2kFeRleg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="94301403"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 06 Dec 2024 11:35:46 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/4] ice: Fix quad registers read on E825
Date: Fri,  6 Dec 2024 11:35:39 -0800
Message-ID: <20241206193542.4121545-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
References: <20241206193542.4121545-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Quad registers are read/written incorrectly. E825 devices always use
quad 0 address and differentiate between the PHYs by changing SBQ
destination device (phy_0 or phy_0_peer).

Add helpers for reading/writing PTP registers shared per quad and use
correct quad address and SBQ destination device based on port.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 226 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_type.h   |   1 -
 2 files changed, 137 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a5e4c6d8bfd5..e606f1049742 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -900,31 +900,46 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
  * The following functions operate on devices with the ETH 56G PHY.
  */
 
+/**
+ * ice_ptp_get_dest_dev_e825 - get destination PHY for given port number
+ * @hw: pointer to the HW struct
+ * @port: destination port
+ *
+ * Return: destination sideband queue PHY device.
+ */
+static enum ice_sbq_msg_dev ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
+						      u8 port)
+{
+	/* On a single complex E825, PHY 0 is always destination device phy_0
+	 * and PHY 1 is phy_0_peer.
+	 */
+	if (port >= hw->ptp.ports_per_phy)
+		return eth56g_phy_1;
+	else
+		return eth56g_phy_0;
+}
+
 /**
  * ice_write_phy_eth56g - Write a PHY port register
  * @hw: pointer to the HW struct
- * @phy_idx: PHY index
+ * @port: destination port
  * @addr: PHY register address
  * @val: Value to write
  *
- * Return: 0 on success, other error codes when failed to write to PHY
+ * Return: 0 on success, other error codes when failed to write to PHY.
  */
-static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
-				u32 val)
+static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input phy_msg;
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
+		.opcode = ice_sbq_msg_wr,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val
+	};
 	int err;
 
-	phy_msg.opcode = ice_sbq_msg_wr;
-
-	phy_msg.msg_addr_low = lower_16_bits(addr);
-	phy_msg.msg_addr_high = upper_16_bits(addr);
-
-	phy_msg.data = val;
-	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
-
-	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
-
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err)
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
 			  err);
@@ -935,41 +950,36 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
 /**
  * ice_read_phy_eth56g - Read a PHY port register
  * @hw: pointer to the HW struct
- * @phy_idx: PHY index
+ * @port: destination port
  * @addr: PHY register address
  * @val: Value to write
  *
- * Return: 0 on success, other error codes when failed to read from PHY
+ * Return: 0 on success, other error codes when failed to read from PHY.
  */
-static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
-			       u32 *val)
+static int ice_read_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 *val)
 {
-	struct ice_sbq_msg_input phy_msg;
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
+		.opcode = ice_sbq_msg_rd,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr)
+	};
 	int err;
 
-	phy_msg.opcode = ice_sbq_msg_rd;
-
-	phy_msg.msg_addr_low = lower_16_bits(addr);
-	phy_msg.msg_addr_high = upper_16_bits(addr);
-
-	phy_msg.data = 0;
-	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
-
-	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
-	if (err) {
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
+	if (err)
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
 			  err);
-		return err;
-	}
-
-	*val = phy_msg.data;
+	else
+		*val = msg.data;
 
-	return 0;
+	return err;
 }
 
 /**
  * ice_phy_res_address_eth56g - Calculate a PHY port register address
- * @port: Port number to be written
+ * @hw: pointer to the HW struct
+ * @lane: Lane number to be written
  * @res_type: resource type (register/memory)
  * @offset: Offset from PHY port register base
  * @addr: The result address
@@ -978,17 +988,19 @@ static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
  * * %0      - success
  * * %EINVAL - invalid port number or resource type
  */
-static int ice_phy_res_address_eth56g(u8 port, enum eth56g_res_type res_type,
-				      u32 offset, u32 *addr)
+static int ice_phy_res_address_eth56g(struct ice_hw *hw, u8 lane,
+				      enum eth56g_res_type res_type,
+				      u32 offset,
+				      u32 *addr)
 {
-	u8 lane = port % ICE_PORTS_PER_QUAD;
-	u8 phy = ICE_GET_QUAD_NUM(port);
-
 	if (res_type >= NUM_ETH56G_PHY_RES)
 		return -EINVAL;
 
-	*addr = eth56g_phy_res[res_type].base[phy] +
+	/* Lanes 4..7 are in fact 0..3 on a second PHY */
+	lane %= hw->ptp.ports_per_phy;
+	*addr = eth56g_phy_res[res_type].base[0] +
 		lane * eth56g_phy_res[res_type].step + offset;
+
 	return 0;
 }
 
@@ -1008,19 +1020,17 @@ static int ice_phy_res_address_eth56g(u8 port, enum eth56g_res_type res_type,
 static int ice_write_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 				 u32 val, enum eth56g_res_type res_type)
 {
-	u8 phy_port = port % hw->ptp.ports_per_phy;
-	u8 phy_idx = port / hw->ptp.ports_per_phy;
 	u32 addr;
 	int err;
 
 	if (port >= hw->ptp.num_lports)
 		return -EINVAL;
 
-	err = ice_phy_res_address_eth56g(phy_port, res_type, offset, &addr);
+	err = ice_phy_res_address_eth56g(hw, port, res_type, offset, &addr);
 	if (err)
 		return err;
 
-	return ice_write_phy_eth56g(hw, phy_idx, addr, val);
+	return ice_write_phy_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -1039,19 +1049,17 @@ static int ice_write_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 static int ice_read_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
 				u32 *val, enum eth56g_res_type res_type)
 {
-	u8 phy_port = port % hw->ptp.ports_per_phy;
-	u8 phy_idx = port / hw->ptp.ports_per_phy;
 	u32 addr;
 	int err;
 
 	if (port >= hw->ptp.num_lports)
 		return -EINVAL;
 
-	err = ice_phy_res_address_eth56g(phy_port, res_type, offset, &addr);
+	err = ice_phy_res_address_eth56g(hw, port, res_type, offset, &addr);
 	if (err)
 		return err;
 
-	return ice_read_phy_eth56g(hw, phy_idx, addr, val);
+	return ice_read_phy_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -1200,6 +1208,56 @@ static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
 	return ice_write_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
 }
 
+/**
+ * ice_write_quad_ptp_reg_eth56g - Write a PHY quad register
+ * @hw: pointer to the HW struct
+ * @offset: PHY register offset
+ * @port: Port number
+ * @val: Value to write
+ *
+ * Return:
+ * * %0     - success
+ * * %EIO  - invalid port number or resource type
+ * * %other - failed to write to PHY
+ */
+static int ice_write_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
+					 u32 offset, u32 val)
+{
+	u32 addr;
+
+	if (port >= hw->ptp.num_lports)
+		return -EIO;
+
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+
+	return ice_write_phy_eth56g(hw, port, addr, val);
+}
+
+/**
+ * ice_read_quad_ptp_reg_eth56g - Read a PHY quad register
+ * @hw: pointer to the HW struct
+ * @offset: PHY register offset
+ * @port: Port number
+ * @val: Value to read
+ *
+ * Return:
+ * * %0     - success
+ * * %EIO  - invalid port number or resource type
+ * * %other - failed to read from PHY
+ */
+static int ice_read_quad_ptp_reg_eth56g(struct ice_hw *hw, u8 port,
+					u32 offset, u32 *val)
+{
+	u32 addr;
+
+	if (port >= hw->ptp.num_lports)
+		return -EIO;
+
+	addr = eth56g_phy_res[ETH56G_PHY_REG_PTP].base[0] + offset;
+
+	return ice_read_phy_eth56g(hw, port, addr, val);
+}
+
 /**
  * ice_is_64b_phy_reg_eth56g - Check if this is a 64bit PHY register
  * @low_addr: the low address to check
@@ -1919,7 +1977,6 @@ ice_phy_get_speed_eth56g(struct ice_link_status *li)
  */
 static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 {
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
 	u32 val;
 	int err;
 
@@ -1934,8 +1991,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 	switch (ice_phy_get_speed_eth56g(&hw->port_info->phy.link_info)) {
 	case ICE_ETH56G_LNK_SPD_1G:
 	case ICE_ETH56G_LNK_SPD_2_5G:
-		err = ice_read_ptp_reg_eth56g(hw, port_blk,
-					      PHY_GPCS_CONFIG_REG0, &val);
+		err = ice_read_quad_ptp_reg_eth56g(hw, port,
+						   PHY_GPCS_CONFIG_REG0, &val);
 		if (err) {
 			ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_GPCS_CONFIG_REG0, status: %d",
 				  err);
@@ -1946,8 +2003,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 		val |= FIELD_PREP(PHY_GPCS_CONFIG_REG0_TX_THR_M,
 				  ICE_ETH56G_NOMINAL_TX_THRESH);
 
-		err = ice_write_ptp_reg_eth56g(hw, port_blk,
-					       PHY_GPCS_CONFIG_REG0, val);
+		err = ice_write_quad_ptp_reg_eth56g(hw, port,
+						    PHY_GPCS_CONFIG_REG0, val);
 		if (err) {
 			ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_GPCS_CONFIG_REG0, status: %d",
 				  err);
@@ -1988,50 +2045,48 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
  */
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
 {
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
-	u8 blk_port = port & (ICE_PORTS_PER_QUAD - 1);
+	u8 quad_lane = port % ICE_PORTS_PER_QUAD;
+	u32 addr, val, peer_delay;
 	bool enable, sfd_ena;
-	u32 val, peer_delay;
 	int err;
 
 	enable = hw->ptp.phy.eth56g.onestep_ena;
 	peer_delay = hw->ptp.phy.eth56g.peer_delay;
 	sfd_ena = hw->ptp.phy.eth56g.sfd_ena;
 
-	/* PHY_PTP_1STEP_CONFIG */
-	err = ice_read_ptp_reg_eth56g(hw, port_blk, PHY_PTP_1STEP_CONFIG, &val);
+	addr = PHY_PTP_1STEP_CONFIG;
+	err = ice_read_quad_ptp_reg_eth56g(hw, port, addr, &val);
 	if (err)
 		return err;
 
 	if (enable)
-		val |= blk_port;
+		val |= BIT(quad_lane);
 	else
-		val &= ~blk_port;
+		val &= ~BIT(quad_lane);
 
-	val &= ~(PHY_PTP_1STEP_T1S_UP64_M | PHY_PTP_1STEP_T1S_DELTA_M);
+	val &= ~PHY_PTP_1STEP_T1S_UP64_M;
+	val &= ~PHY_PTP_1STEP_T1S_DELTA_M;
 
-	err = ice_write_ptp_reg_eth56g(hw, port_blk, PHY_PTP_1STEP_CONFIG, val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
-	/* PHY_PTP_1STEP_PEER_DELAY */
+	addr = PHY_PTP_1STEP_PEER_DELAY(quad_lane);
 	val = FIELD_PREP(PHY_PTP_1STEP_PD_DELAY_M, peer_delay);
 	if (peer_delay)
 		val |= PHY_PTP_1STEP_PD_ADD_PD_M;
 	val |= PHY_PTP_1STEP_PD_DLY_V_M;
-	err = ice_write_ptp_reg_eth56g(hw, port_blk,
-				       PHY_PTP_1STEP_PEER_DELAY(blk_port), val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
 	val &= ~PHY_PTP_1STEP_PD_DLY_V_M;
-	err = ice_write_ptp_reg_eth56g(hw, port_blk,
-				       PHY_PTP_1STEP_PEER_DELAY(blk_port), val);
+	err = ice_write_quad_ptp_reg_eth56g(hw, port, addr, val);
 	if (err)
 		return err;
 
-	/* PHY_MAC_XIF_MODE */
-	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	addr = PHY_MAC_XIF_MODE;
+	err = ice_read_mac_reg_eth56g(hw, port, addr, &val);
 	if (err)
 		return err;
 
@@ -2051,7 +2106,7 @@ int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
 	       FIELD_PREP(PHY_MAC_XIF_TS_BIN_MODE_M, enable) |
 	       FIELD_PREP(PHY_MAC_XIF_TS_SFD_ENA_M, sfd_ena);
 
-	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+	return ice_write_mac_reg_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -2093,21 +2148,22 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
 				       bool fc, bool rs,
 				       enum ice_eth56g_link_spd spd)
 {
-	u8 port_offset = port & (ICE_PORTS_PER_QUAD - 1);
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
 	u32 bitslip;
 	int err;
 
 	if (!bs || rs)
 		return 0;
 
-	if (spd == ICE_ETH56G_LNK_SPD_1G || spd == ICE_ETH56G_LNK_SPD_2_5G)
+	if (spd == ICE_ETH56G_LNK_SPD_1G || spd == ICE_ETH56G_LNK_SPD_2_5G) {
 		err = ice_read_gpcs_reg_eth56g(hw, port, PHY_GPCS_BITSLIP,
 					       &bitslip);
-	else
-		err = ice_read_ptp_reg_eth56g(hw, port_blk,
-					      PHY_REG_SD_BIT_SLIP(port_offset),
-					      &bitslip);
+	} else {
+		u8 quad_lane = port % ICE_PORTS_PER_QUAD;
+		u32 addr;
+
+		addr = PHY_REG_SD_BIT_SLIP(quad_lane);
+		err = ice_read_quad_ptp_reg_eth56g(hw, port, addr, &bitslip);
+	}
 	if (err)
 		return 0;
 
@@ -2702,8 +2758,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	params->onestep_ena = false;
 	params->peer_delay = 0;
 	params->sfd_ena = false;
-	params->phy_addr[0] = eth56g_phy_0;
-	params->phy_addr[1] = eth56g_phy_1;
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
@@ -2734,10 +2788,9 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 				  struct ice_sbq_msg_input *msg, u8 port,
 				  u16 offset)
 {
-	int phy_port, phy, quadtype;
+	int phy_port, quadtype;
 
 	phy_port = port % hw->ptp.ports_per_phy;
-	phy = port / hw->ptp.ports_per_phy;
 	quadtype = ICE_GET_QUAD_NUM(port) %
 		   ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy);
 
@@ -2749,12 +2802,7 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 		msg->msg_addr_high = P_Q1_H(P_4_BASE + offset, phy_port);
 	}
 
-	if (phy == 0)
-		msg->dest_dev = rmn_0;
-	else if (phy == 1)
-		msg->dest_dev = rmn_1;
-	else
-		msg->dest_dev = rmn_2;
+	msg->dest_dev = rmn_0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index adb168860711..a61026970be5 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -850,7 +850,6 @@ struct ice_mbx_data {
 
 struct ice_eth56g_params {
 	u8 num_phys;
-	u8 phy_addr[2];
 	bool onestep_ena;
 	bool sfd_ena;
 	u32 peer_delay;
-- 
2.42.0


