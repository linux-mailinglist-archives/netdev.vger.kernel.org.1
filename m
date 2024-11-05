Return-Path: <netdev+bounces-141973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF479BCCCD
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB41285CFF
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065321D54F7;
	Tue,  5 Nov 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZxnHqqy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FD41E485
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809968; cv=none; b=qspCWa50nT2pwoRsr9GnB2quLcsq9DtU+5ejFWlngtS5KPiFLqBNeSgwVaHmZjE0BqbGmmNZvjOjGPuaPBfxwKo+7ctA2XP/sx84f+H6am9QrImEiz6ee3C/90FOgR0r6F+Q8jhBju9cINLSYr/L/kEzAY4WTrHeqIM8V/Ov0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809968; c=relaxed/simple;
	bh=p47dtbo9zX5IbhUsp+V9inEjvcXiJRCgmhy9FtXqfz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRyhdq03kGBBCbgNjSOlF6RbBgHDVvrRZsOWnHjMO6eACuZreD2KbTjG/Y3rbw+oEa1TWqejr8k5ogcM2xTmnGg7eJ8rE6Lwjfvqc7eyNnCN2ueMPMDZm35fRFw1KqDo4+pBZZaiOfVlvzquvBDK7xxqimRJWJfk+47hbABmOFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZxnHqqy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730809966; x=1762345966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p47dtbo9zX5IbhUsp+V9inEjvcXiJRCgmhy9FtXqfz4=;
  b=IZxnHqqyIaAMSLg0CzK2buxlVsgS7YV1RpXPRt/yyFuf3TI8MUMEYZWG
   R9iYRDim4QjomY0AUmyDFm7C1YGfq1GdQZcvki2R308P+yxdQrBcms5qx
   Wm6voDrUDZgV2uYyPw9lTIXZChrW9MjOLu7FaqX+v0W8DIb1eu0tl2cBi
   PLJR2nrtidWLfvBc4KB35i9GPALiyYSriOGTApL27xMJXeP0IBonvVMd+
   MVD3iaAOqTt7qwTZJ4UErRc/YVJ9I77XG3IhWBG70aTuUmfD4W55PpoO4
   cIpLUhxirEtacAzCFGCZVKSy02cQS9JnbDCa7rDlwXCjqRpxvWOoojruF
   g==;
X-CSE-ConnectionGUID: 7cLaI3xaRc6jRp1P2WaJMQ==
X-CSE-MsgGUID: 0HffVMAVRliEWmJeZ6fFmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29976249"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="29976249"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 04:32:46 -0800
X-CSE-ConnectionGUID: Tle1+wRnRqyJerrOOq6aHg==
X-CSE-MsgGUID: UMgAAMEQSI+IZl1kjju/8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="121481341"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2024 04:32:44 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v4 iwl-net 2/4] ice: Fix quad registers read on E825
Date: Tue,  5 Nov 2024 13:29:14 +0100
Message-Id: <20241105122916.1824568-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
References: <20241105122916.1824568-1-grzegorz.nitka@intel.com>
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
---
V3 -> V4: Removed unrelated refactor/cleanup code
V2 -> V3: Replaced lower/upper_32_bits calls with lower/upper_16_bits
V1 -> V2: Fixed kdoc issues

 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 226 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_type.h   |   1 -
 2 files changed, 137 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index d27b2f52b5ce..836e7718dda3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -877,31 +877,46 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
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
@@ -912,41 +927,36 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
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
@@ -955,17 +965,19 @@ static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
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
 
@@ -985,19 +997,17 @@ static int ice_phy_res_address_eth56g(u8 port, enum eth56g_res_type res_type,
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
@@ -1016,19 +1026,17 @@ static int ice_write_port_eth56g(struct ice_hw *hw, u8 port, u32 offset,
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
@@ -1177,6 +1185,56 @@ static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
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
@@ -1895,7 +1953,6 @@ ice_phy_get_speed_eth56g(struct ice_link_status *li)
  */
 static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 {
-	u8 port_blk = port & ~(ICE_PORTS_PER_QUAD - 1);
 	u32 val;
 	int err;
 
@@ -1910,8 +1967,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
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
@@ -1922,8 +1979,8 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 		val |= FIELD_PREP(PHY_GPCS_CONFIG_REG0_TX_THR_M,
 				  ICE_ETH56G_NOMINAL_TX_THRESH);
 
-		err = ice_write_ptp_reg_eth56g(hw, port_blk,
-					       PHY_GPCS_CONFIG_REG0, val);
+		err = ice_write_quad_ptp_reg_eth56g(hw, port,
+						    PHY_GPCS_CONFIG_REG0, val);
 		if (err) {
 			ice_debug(hw, ICE_DBG_PTP, "Failed to write PHY_GPCS_CONFIG_REG0, status: %d",
 				  err);
@@ -1964,50 +2021,48 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
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
 
@@ -2027,7 +2082,7 @@ int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port)
 	       FIELD_PREP(PHY_MAC_XIF_TS_BIN_MODE_M, enable) |
 	       FIELD_PREP(PHY_MAC_XIF_TS_SFD_ENA_M, sfd_ena);
 
-	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+	return ice_write_mac_reg_eth56g(hw, port, addr, val);
 }
 
 /**
@@ -2069,21 +2124,22 @@ static u32 ice_ptp_calc_bitslip_eth56g(struct ice_hw *hw, u8 port, u32 bs,
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
 
@@ -2678,8 +2734,6 @@ static void ice_ptp_init_phy_e825(struct ice_hw *hw)
 	params->onestep_ena = false;
 	params->peer_delay = 0;
 	params->sfd_ena = false;
-	params->phy_addr[0] = eth56g_phy_0;
-	params->phy_addr[1] = eth56g_phy_1;
 	params->num_phys = 2;
 	ptp->ports_per_phy = 4;
 	ptp->num_lports = params->num_phys * ptp->ports_per_phy;
@@ -2710,10 +2764,9 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 				  struct ice_sbq_msg_input *msg, u8 port,
 				  u16 offset)
 {
-	int phy_port, phy, quadtype;
+	int phy_port, quadtype;
 
 	phy_port = port % hw->ptp.ports_per_phy;
-	phy = port / hw->ptp.ports_per_phy;
 	quadtype = ICE_GET_QUAD_NUM(port) %
 		   ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy);
 
@@ -2725,12 +2778,7 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
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
index 45768796691f..479227bdff75 100644
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
2.39.3


