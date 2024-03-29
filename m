Return-Path: <netdev+bounces-83250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEFA891792
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389E81F22C44
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C8B6A329;
	Fri, 29 Mar 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq7kY8Yk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF105A0FB
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711430; cv=none; b=D+sXJKs8q65gcHcxKYfUFdLa+1hvbVOO+581jmMPkoNNdWXaNcRDeQ/vjWYO6EAM2GBZ4Fulx66iMgImqYt69DMFmLEBGlMCStjBxicpoOtSsyHxYo6aNccEFFSwQV3G3R7fuM0o9bFMsp7X4yHQfiV2+6eAqQK+Zn2b9a9YeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711430; c=relaxed/simple;
	bh=T0DIOAhkXuQ1RPJLIgu3h59cgjxY/8dwb44Sj2IrrYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubFIM/q2wSitBuOiUmKBOPz5UYy9ts5pBWO4ilr0WRurLsOPp89S6hPOPvu4mWm5CxfjsYMUWCTbk2vDUYq7/KonTI4hrGiKZiaKOY6WwDgnXWWkvR5A12mUYfXkz4CqMzsr7Rajo3RcEUkT8mE78IN1pbakzDnDsjGZH3ejXdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq7kY8Yk; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711711427; x=1743247427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0DIOAhkXuQ1RPJLIgu3h59cgjxY/8dwb44Sj2IrrYY=;
  b=jq7kY8YkDi0Sk+/bCyEQ8Ge8n+H8QD88yPLrhymfq+wvZpyQc1ANL0Ak
   QXzuggmAf3rYlP3HxtSXE7gVLnCzXns+lmezQhDrUModbNuDvlYfgGzGk
   Mu26kEQwMlaOqQDyzxjhZKlZdwsqVdPRllQE9Ln3ApyvVDlClAS6tkD5O
   tGNe+4q+iiXJLRlrTHiQiOpVf4QbI3i0J5xsEn3ZFLvJHQnSTrjcnmM1Q
   /6jLvm45XfBPKWaAhnmi+Ku+t4sfN8xQCfSxsHQO70J/t2xTya7JmZAr+
   jeM8j2Oq4pgubJRNUON4PevQvgTm13/uJxf5hP8USOLRAAQrpuGXcYcca
   w==;
X-CSE-ConnectionGUID: 9vzVWovfTVCHh5PlrlPpAQ==
X-CSE-MsgGUID: S64oU/xeS92GBQv5pmEeKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6755176"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="6755176"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 04:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; 
   d="scan'208";a="16836690"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2024 04:23:45 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-next 01/12] ice: Introduce ice_ptp_hw struct
Date: Fri, 29 Mar 2024 12:21:45 +0100
Message-ID: <20240329112339.29642-15-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329112339.29642-14-karol.kolacinski@intel.com>
References: <20240329112339.29642-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create new ice_ptp_hw struct and use it for all HW and PTP-related
fields from struct ice_hw.
Replace definitions with struct fields, which values are set accordingly
to a specific device.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  24 ++++
 drivers/net/ethernet/intel/ice/ice_common.h |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  22 ++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 128 +++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   4 +-
 drivers/net/ethernet/intel/ice/ice_type.h   |  17 +--
 6 files changed, 120 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5c4dec3efe8f..80995a11c596 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -233,6 +233,30 @@ bool ice_is_e810t(struct ice_hw *hw)
 	return false;
 }
 
+/**
+ * ice_is_e822
+ * @hw: pointer to the hardware structure
+ *
+ * returns true if the device is E822 based, false if not.
+ */
+bool ice_is_e822(struct ice_hw *hw)
+{
+	switch (hw->device_id) {
+	case ICE_DEV_ID_E822C_BACKPLANE:
+	case ICE_DEV_ID_E822C_QSFP:
+	case ICE_DEV_ID_E822C_SFP:
+	case ICE_DEV_ID_E822C_10G_BASE_T:
+	case ICE_DEV_ID_E822C_SGMII:
+	case ICE_DEV_ID_E822L_BACKPLANE:
+	case ICE_DEV_ID_E822L_SFP:
+	case ICE_DEV_ID_E822L_10G_BASE_T:
+	case ICE_DEV_ID_E822L_SGMII:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  * ice_is_e823
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index ffb22c7ce28b..70f57340eb0d 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -249,6 +249,7 @@ void
 ice_stat_update32(struct ice_hw *hw, u32 reg, bool prev_stat_loaded,
 		  u64 *prev_stat, u64 *cur_stat);
 bool ice_is_e810t(struct ice_hw *hw);
+bool ice_is_e822(struct ice_hw *hw);
 bool ice_is_e823(struct ice_hw *hw);
 bool ice_is_e825c(struct ice_hw *hw);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1181d2..8150f949dfd3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -813,7 +813,7 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 	}
 	mutex_unlock(&pf->ptp.ports_owner.lock);
 
-	for (i = 0; i < ICE_MAX_QUAD; i++) {
+	for (i = 0; i < ICE_GET_QUAD_NUM(pf->hw.ptp.num_lports); i++) {
 		u64 tstamp_ready;
 		int err;
 
@@ -1027,7 +1027,7 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 static int
 ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 {
-	tx->block = port / ICE_PORTS_PER_QUAD;
+	tx->block = ICE_GET_QUAD_NUM(port);
 	tx->offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT_E82X;
 	tx->len = INDEX_PER_PORT_E82X;
 	tx->has_ready_bitmap = 1;
@@ -1229,7 +1229,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
  */
 static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 {
-	int quad = port->port_num / ICE_PORTS_PER_QUAD;
+	int quad = ICE_GET_QUAD_NUM(port->port_num);
 	int offs = port->port_num % ICE_PORTS_PER_QUAD;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
@@ -1429,7 +1429,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
-	if (WARN_ON_ONCE(port >= ICE_NUM_EXTERNAL_PORTS))
+	if (WARN_ON_ONCE(port >= hw->ptp.num_lports))
 		return;
 
 	ptp_port = &pf->ptp.port;
@@ -1439,7 +1439,7 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 	/* Update cached link status for this port immediately */
 	ptp_port->link_up = linkup;
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		/* Do not reconfigure E810 PHY */
 		return;
@@ -1468,7 +1468,7 @@ static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 
 	ice_ptp_reset_ts_memory(hw);
 
-	for (quad = 0; quad < ICE_MAX_QUAD; quad++) {
+	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++) {
 		err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG,
 					     &val);
 		if (err)
@@ -1953,7 +1953,7 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	ice_ptp_enable_all_clkout(pf);
 
 	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
-	if (hw->phy_model == ICE_PHY_E82X)
+	if (hw->ptp.phy_model == ICE_PHY_E82X)
 		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
@@ -2578,7 +2578,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	if (!ice_pf_src_tmr_owned(pf))
 		return;
 
-	for (i = 0; i < ICE_MAX_QUAD; i++) {
+	for (i = 0; i < ICE_GET_QUAD_NUM(hw->ptp.num_lports); i++) {
 		u64 tstamp_ready;
 		int err;
 
@@ -3076,7 +3076,7 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	mutex_init(&ptp_port->ps_lock);
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
 	case ICE_PHY_E82X:
@@ -3171,7 +3171,7 @@ static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
  */
 static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
 {
-	switch (pf->hw.phy_model) {
+	switch (pf->hw.ptp.phy_model) {
 	case ICE_PHY_E82X:
 		/* E822 based PHY has the clock owner process the interrupt
 		 * for all ports.
@@ -3207,7 +3207,7 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ptp->state = ICE_PTP_INITIALIZING;
 
-	ice_ptp_init_phy_model(hw);
+	ice_ptp_init_hw(hw);
 
 	ice_ptp_init_tx_interrupt_mode(pf);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2b9423a173bb..e86ca6cada79 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -288,18 +288,21 @@ static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 
 /**
  * ice_fill_phy_msg_e82x - Fill message data for a PHY register access
+ * @hw: pointer to the HW struct
  * @msg: the PHY message buffer to fill in
  * @port: the port to access
  * @offset: the register offset
  */
-static void
-ice_fill_phy_msg_e82x(struct ice_sbq_msg_input *msg, u8 port, u16 offset)
+static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
+				  struct ice_sbq_msg_input *msg, u8 port,
+				  u16 offset)
 {
 	int phy_port, phy, quadtype;
 
-	phy_port = port % ICE_PORTS_PER_PHY_E82X;
-	phy = port / ICE_PORTS_PER_PHY_E82X;
-	quadtype = (port / ICE_PORTS_PER_QUAD) % ICE_QUADS_PER_PHY_E82X;
+	phy_port = port % hw->ptp.ports_per_phy;
+	phy = port / hw->ptp.ports_per_phy;
+	quadtype = ICE_GET_QUAD_NUM(port) %
+		   ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy);
 
 	if (quadtype == 0) {
 		msg->msg_addr_low = P_Q0_L(P_0_BASE + offset, phy_port);
@@ -430,7 +433,7 @@ ice_read_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 *val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	ice_fill_phy_msg_e82x(&msg, port, offset);
+	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
 	msg.opcode = ice_sbq_msg_rd;
 
 	err = ice_sbq_rw_reg(hw, &msg);
@@ -507,7 +510,7 @@ ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	ice_fill_phy_msg_e82x(&msg, port, offset);
+	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
@@ -617,6 +620,7 @@ ice_write_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
 
 /**
  * ice_fill_quad_msg_e82x - Fill message data for quad register access
+ * @hw: pointer to the HW struct
  * @msg: the PHY message buffer to fill in
  * @quad: the quad to access
  * @offset: the register offset
@@ -624,17 +628,18 @@ ice_write_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
  * Fill a message buffer for accessing a register in a quad shared between
  * multiple PHYs.
  */
-static int
-ice_fill_quad_msg_e82x(struct ice_sbq_msg_input *msg, u8 quad, u16 offset)
+static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
+				  struct ice_sbq_msg_input *msg, u8 quad,
+				  u16 offset)
 {
 	u32 addr;
 
-	if (quad >= ICE_MAX_QUAD)
+	if (quad >= ICE_GET_QUAD_NUM(hw->ptp.num_lports))
 		return -EINVAL;
 
 	msg->dest_dev = rmn_0;
 
-	if ((quad % ICE_QUADS_PER_PHY_E82X) == 0)
+	if (!(quad % ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy)))
 		addr = Q_0_BASE + offset;
 	else
 		addr = Q_1_BASE + offset;
@@ -661,7 +666,7 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	err = ice_fill_quad_msg_e82x(&msg, quad, offset);
+	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
@@ -695,7 +700,7 @@ ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	err = ice_fill_quad_msg_e82x(&msg, quad, offset);
+	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
@@ -816,7 +821,7 @@ static void ice_ptp_reset_ts_memory_e82x(struct ice_hw *hw)
 {
 	unsigned int quad;
 
-	for (quad = 0; quad < ICE_MAX_QUAD; quad++)
+	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++)
 		ice_ptp_reset_ts_memory_quad_e82x(hw, quad);
 }
 
@@ -1113,7 +1118,7 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_write_phy_reg_e82x(hw, port, P_REG_WL,
@@ -1178,7 +1183,7 @@ ice_ptp_prep_phy_time_e82x(struct ice_hw *hw, u32 time)
 	 */
 	phy_time = (u64)time << 32;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		/* Tx case */
 		err = ice_write_64b_phy_reg_e82x(hw, port,
 						 P_REG_TX_TIMER_INC_PRE_L,
@@ -1281,7 +1286,7 @@ ice_ptp_prep_phy_adj_e82x(struct ice_hw *hw, s32 adj)
 	else
 		cycles = -(((s64)-adj) << 32);
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_ptp_prep_port_adj_e82x(hw, port, cycles);
@@ -1307,7 +1312,7 @@ ice_ptp_prep_phy_incval_e82x(struct ice_hw *hw, u64 incval)
 	int err;
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		err = ice_write_40b_phy_reg_e82x(hw, port, P_REG_TIMETUS_L,
 						 incval);
 		if (err)
@@ -1463,7 +1468,7 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		enum ice_ptp_tmr_cmd cmd;
 		int err;
 
@@ -1493,7 +1498,7 @@ ice_ptp_port_cmd_e82x(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_ptp_write_port_cmd_e82x(hw, port, cmd);
@@ -1606,7 +1611,7 @@ static void ice_phy_cfg_lane_e82x(struct ice_hw *hw, u8 port)
 		return;
 	}
 
-	quad = port / ICE_PORTS_PER_QUAD;
+	quad = ICE_GET_QUAD_NUM(port);
 
 	err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, &val);
 	if (err) {
@@ -2636,6 +2641,17 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
 	return 0;
 }
 
+/**
+ * ice_ptp_init_phy_e82x - initialize PHY parameters
+ * @ptp: pointer to the PTP HW struct
+ */
+static void ice_ptp_init_phy_e82x(struct ice_ptp_hw *ptp)
+{
+	ptp->phy_model = ICE_PHY_E82X;
+	ptp->num_lports = 8;
+	ptp->ports_per_phy = 8;
+}
+
 /* E810 functions
  *
  * The following functions operate on the E810 series devices which use
@@ -2863,17 +2879,19 @@ static int ice_clear_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx)
 }
 
 /**
- * ice_ptp_init_phy_e810 - Enable PTP function on the external PHY
+ * ice_ptp_init_phc_e810 - Perform E810 specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Enable the timesync PTP functionality for the external PHY connected to
- * this function.
+ * Perform E810-specific PTP hardware clock initialization steps.
  */
-int ice_ptp_init_phy_e810(struct ice_hw *hw)
+static int ice_ptp_init_phc_e810(struct ice_hw *hw)
 {
 	u8 tmr_idx;
 	int err;
 
+	/* Ensure synchronization delay is zero */
+	wr32(hw, GLTSYN_SYNC_DLAY, 0);
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	err = ice_write_phy_reg_e810(hw, ETH_GLTSYN_ENA(tmr_idx),
 				     GLTSYN_ENA_TSYN_ENA_M);
@@ -2884,21 +2902,6 @@ int ice_ptp_init_phy_e810(struct ice_hw *hw)
 	return err;
 }
 
-/**
- * ice_ptp_init_phc_e810 - Perform E810 specific PHC initialization
- * @hw: pointer to HW struct
- *
- * Perform E810-specific PTP hardware clock initialization steps.
- */
-static int ice_ptp_init_phc_e810(struct ice_hw *hw)
-{
-	/* Ensure synchronization delay is zero */
-	wr32(hw, GLTSYN_SYNC_DLAY, 0);
-
-	/* Initialize the PHY */
-	return ice_ptp_init_phy_e810(hw);
-}
-
 /**
  * ice_ptp_prep_phy_time_e810 - Prepare PHY port with initial time
  * @hw: Board private structure
@@ -3242,6 +3245,17 @@ int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data)
 	return ice_aq_read_i2c(hw, link_topo, 0, addr, 1, data, NULL);
 }
 
+/**
+ * ice_ptp_init_phy_e810 - initialize PHY parameters
+ * @ptp: pointer to the PTP HW struct
+ */
+static void ice_ptp_init_phy_e810(struct ice_ptp_hw *ptp)
+{
+	ptp->phy_model = ICE_PHY_E810;
+	ptp->num_lports = 8;
+	ptp->ports_per_phy = 4;
+}
+
 /* Device agnostic functions
  *
  * The following functions implement shared behavior common to both E822 and
@@ -3299,18 +3313,22 @@ void ice_ptp_unlock(struct ice_hw *hw)
 }
 
 /**
- * ice_ptp_init_phy_model - Initialize hw->phy_model based on device type
+ * ice_ptp_init_hw - Initialize hw based on device type
  * @hw: pointer to the HW structure
  *
- * Determine the PHY model for the device, and initialize hw->phy_model
+ * Determine the PHY model for the device, and initialize hw
  * for use by other functions.
  */
-void ice_ptp_init_phy_model(struct ice_hw *hw)
+void ice_ptp_init_hw(struct ice_hw *hw)
 {
-	if (ice_is_e810(hw))
-		hw->phy_model = ICE_PHY_E810;
+	struct ice_ptp_hw *ptp = &hw->ptp;
+
+	if (ice_is_e822(hw) || ice_is_e823(hw))
+		ice_ptp_init_phy_e82x(ptp);
+	else if (ice_is_e810(hw))
+		ice_ptp_init_phy_e810(ptp);
 	else
-		hw->phy_model = ICE_PHY_E82X;
+		ptp->phy_model = ICE_PHY_UNSUP;
 }
 
 /**
@@ -3331,7 +3349,7 @@ static int ice_ptp_tmr_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	ice_ptp_src_cmd(hw, cmd);
 
 	/* Next, prepare the ports */
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_port_cmd_e810(hw, cmd);
 		break;
@@ -3383,7 +3401,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
 	/* PHY timers */
 	/* Fill Rx and Tx ports and send msg to PHY */
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_time_e810(hw, time & 0xFFFFFFFF);
 		break;
@@ -3425,7 +3443,7 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_incval_e810(hw, incval);
 		break;
@@ -3491,7 +3509,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
@@ -3521,7 +3539,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
  */
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_read_phy_tstamp_e810(hw, block, idx, tstamp);
 	case ICE_PHY_E82X:
@@ -3549,7 +3567,7 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_clear_phy_tstamp_e810(hw, block, idx);
 	case ICE_PHY_E82X:
@@ -3610,7 +3628,7 @@ static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E82X:
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
@@ -3636,7 +3654,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	/* Clear event err indications for auxiliary pins */
 	(void)rd32(hw, GLTSYN_STAT(src_idx));
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_ptp_init_phc_e810(hw);
 	case ICE_PHY_E82X:
@@ -3659,7 +3677,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
  */
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_get_phy_tx_tstamp_ready_e810(hw, block,
 							tstamp_ready);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1f3e03124430..3dce09af0d78 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -212,6 +212,7 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
 void ice_ptp_reset_ts_memory(struct ice_hw *hw);
 int ice_ptp_init_phc(struct ice_hw *hw);
+void ice_ptp_init_hw(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
 
 /* E822 family functions */
@@ -266,7 +267,6 @@ int ice_phy_cfg_tx_offset_e82x(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_rx_offset_e82x(struct ice_hw *hw, u8 port);
 
 /* E810 family functions */
-int ice_ptp_init_phy_e810(struct ice_hw *hw);
 int ice_read_sma_ctrl_e810t(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl_e810t(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data);
@@ -280,8 +280,6 @@ int ice_get_cgu_state(struct ice_hw *hw, u8 dpll_idx,
 		      u8 *ref_state, u8 *eec_mode, s64 *phase_offset,
 		      enum dpll_lock_status *dpll_state);
 int ice_get_cgu_rclk_pin_info(struct ice_hw *hw, u8 *base_idx, u8 *pin_num);
-
-void ice_ptp_init_phy_model(struct ice_hw *hw);
 int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 				      unsigned long *caps);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 08ec5efdafe6..5802009ed0c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -816,6 +816,9 @@ struct ice_mbx_data {
 	u16 async_watermark_val;
 };
 
+#define ICE_PORTS_PER_QUAD	4
+#define ICE_GET_QUAD_NUM(port) ((port) / ICE_PORTS_PER_QUAD)
+
 /* PHY model */
 enum ice_phy_model {
 	ICE_PHY_UNSUP = -1,
@@ -823,6 +826,12 @@ enum ice_phy_model {
 	ICE_PHY_E82X,
 };
 
+struct ice_ptp_hw {
+	enum ice_phy_model phy_model;
+	u8 num_lports;
+	u8 ports_per_phy;
+};
+
 /* Port hardware description */
 struct ice_hw {
 	u8 __iomem *hw_addr;
@@ -844,7 +853,6 @@ struct ice_hw {
 	u8 revision_id;
 
 	u8 pf_id;		/* device profile info */
-	enum ice_phy_model phy_model;
 
 	u16 max_burst_size;	/* driver sets this value */
 
@@ -907,12 +915,7 @@ struct ice_hw {
 	/* INTRL granularity in 1 us */
 	u8 intrl_gran;
 
-#define ICE_MAX_QUAD			2
-#define ICE_QUADS_PER_PHY_E82X		2
-#define ICE_PORTS_PER_PHY_E82X		8
-#define ICE_PORTS_PER_QUAD		4
-#define ICE_PORTS_PER_PHY_E810		4
-#define ICE_NUM_EXTERNAL_PORTS		(ICE_MAX_QUAD * ICE_PORTS_PER_QUAD)
+	struct ice_ptp_hw ptp;
 
 	/* Active package version (currently active) */
 	struct ice_pkg_ver active_pkg_ver;
-- 
2.43.0


