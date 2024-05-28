Return-Path: <netdev+bounces-98806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21B08D287F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 01:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E9F287504
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 23:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5013F432;
	Tue, 28 May 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ilK1VXXS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42513E3F7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937454; cv=none; b=POm50DaokWwxGWwuORkFYf8JBb/dff8lADz9RqJdlzlZDHxsYazTy1+VzWqIjK2zgRTsexgJmGe79eOAjgecF3AP/tfQlRQ7E24208mjLUFthj1AgFbJkMSJCMhpe7sqiv53EW1MIs7VgBk157cle3dADhzWeBfeCJZKxGoDDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937454; c=relaxed/simple;
	bh=cMV/tyqpkuHrIgPE87+F5ChGk6wT2AzR/Rg6n+dcpJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMp2X8abEmEdoDmrANiqycZJXAwbyoJsImI6kOreW0Uxef15SkNbnkqbyfnc7nj878Ps8C1eQegzkWX9vGq80CmqQuwqRaXdHuhXltrOWKHYh8fkSygtc0BwcLk60V5SOAnPFzmMsSDTLkaZfEjjnXb0K7ND0hJN9d29YW1tEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ilK1VXXS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716937453; x=1748473453;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cMV/tyqpkuHrIgPE87+F5ChGk6wT2AzR/Rg6n+dcpJE=;
  b=ilK1VXXSzHdJmlam6t0gSL29gIoD7arT3ivSHdiMWA7ulocAmCn2AzeJ
   HHdgSMaz5lOVRNuO2pN16VhmUe9YxAi6ePDljuuFdJ/m4d/tJgFHonQA8
   eV25aoGgbk2XGb+qf0Xux5BvNdByLE3qChpetjBo72UzvSIAneu+4o8Rq
   lGhcgKYC8zi5HMvJjLJHT7dxpVtRQeMe3z1cOJKhvr7TV6Fj+x7jApCAR
   8a9HltcEDxwxITaMEJrnXPLTIAHkpkY2CSA6nj3s26wlhQCV9v9ycY/39
   qZS69FrBgeXp+2bXMEBcD/b1D6oMT5edb6MMyHrBcmatBGWBxbbkeM+c3
   g==;
X-CSE-ConnectionGUID: qrSYjnv7ThaO03VtIb7Wvw==
X-CSE-MsgGUID: mRNRa8xvRhGu3+2DTQjBCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13444861"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13444861"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:11 -0700
X-CSE-ConnectionGUID: viljKjRGQ+2GuSdvqBjQVQ==
X-CSE-MsgGUID: d668469VSXyNXFT999PMSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="39672276"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 16:04:10 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 16:03:51 -0700
Subject: [PATCH next 01/11] ice: Introduce ice_ptp_hw struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-next-2024-05-28-ptp-refactors-v1-1-c082739bb6f6@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
In-Reply-To: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Karol Kolacinski <karol.kolacinski@intel.com>

Create new ice_ptp_hw struct and use it for all HW and PTP-related
fields from struct ice_hw.
Replace definitions with struct fields, which values are set accordingly
to a specific device.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  24 +++++
 drivers/net/ethernet/intel/ice/ice_common.h |   1 +
 drivers/net/ethernet/intel/ice/ice_ptp.c    |  22 ++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 134 ++++++++++++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   4 +-
 drivers/net/ethernet/intel/ice/ice_type.h   |  17 ++--
 6 files changed, 126 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5649b257e631..1c894965dc7b 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -239,6 +239,30 @@ bool ice_is_e810t(struct ice_hw *hw)
 	return false;
 }
 
+/**
+ * ice_is_e822 - Check if a device is E822 family device
+ * @hw: pointer to the hardware structure
+ *
+ * Return: true if the device is E822 based, false if not.
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
index 0f17fc1181d2..cca9d09b2d61 100644
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
@@ -1229,8 +1229,8 @@ static u64 ice_base_incval(struct ice_pf *pf)
  */
 static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 {
-	int quad = port->port_num / ICE_PORTS_PER_QUAD;
 	int offs = port->port_num % ICE_PORTS_PER_QUAD;
+	int quad = ICE_GET_QUAD_NUM(port->port_num);
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u32 val, phy_sts;
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
index 2b9423a173bb..22fca17a5a3c 100644
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
 
@@ -617,24 +620,30 @@ ice_write_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
 
 /**
  * ice_fill_quad_msg_e82x - Fill message data for quad register access
+ * @hw: pointer to the HW struct
  * @msg: the PHY message buffer to fill in
  * @quad: the quad to access
  * @offset: the register offset
  *
  * Fill a message buffer for accessing a register in a quad shared between
  * multiple PHYs.
+ *
+ * Return:
+ * * %0       - OK
+ * * %-EINVAL - invalid quad number
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
@@ -661,7 +670,7 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	err = ice_fill_quad_msg_e82x(&msg, quad, offset);
+	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
@@ -695,7 +704,7 @@ ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 	struct ice_sbq_msg_input msg = {0};
 	int err;
 
-	err = ice_fill_quad_msg_e82x(&msg, quad, offset);
+	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
@@ -816,7 +825,7 @@ static void ice_ptp_reset_ts_memory_e82x(struct ice_hw *hw)
 {
 	unsigned int quad;
 
-	for (quad = 0; quad < ICE_MAX_QUAD; quad++)
+	for (quad = 0; quad < ICE_GET_QUAD_NUM(hw->ptp.num_lports); quad++)
 		ice_ptp_reset_ts_memory_quad_e82x(hw, quad);
 }
 
@@ -1113,7 +1122,7 @@ static int ice_ptp_set_vernier_wl(struct ice_hw *hw)
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_write_phy_reg_e82x(hw, port, P_REG_WL,
@@ -1178,7 +1187,7 @@ ice_ptp_prep_phy_time_e82x(struct ice_hw *hw, u32 time)
 	 */
 	phy_time = (u64)time << 32;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		/* Tx case */
 		err = ice_write_64b_phy_reg_e82x(hw, port,
 						 P_REG_TX_TIMER_INC_PRE_L,
@@ -1281,7 +1290,7 @@ ice_ptp_prep_phy_adj_e82x(struct ice_hw *hw, s32 adj)
 	else
 		cycles = -(((s64)-adj) << 32);
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_ptp_prep_port_adj_e82x(hw, port, cycles);
@@ -1307,7 +1316,7 @@ ice_ptp_prep_phy_incval_e82x(struct ice_hw *hw, u64 incval)
 	int err;
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		err = ice_write_40b_phy_reg_e82x(hw, port, P_REG_TIMETUS_L,
 						 incval);
 		if (err)
@@ -1463,7 +1472,7 @@ ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		enum ice_ptp_tmr_cmd cmd;
 		int err;
 
@@ -1493,7 +1502,7 @@ ice_ptp_port_cmd_e82x(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 {
 	u8 port;
 
-	for (port = 0; port < ICE_NUM_EXTERNAL_PORTS; port++) {
+	for (port = 0; port < hw->ptp.num_lports; port++) {
 		int err;
 
 		err = ice_ptp_write_port_cmd_e82x(hw, port, cmd);
@@ -1606,7 +1615,7 @@ static void ice_phy_cfg_lane_e82x(struct ice_hw *hw, u8 port)
 		return;
 	}
 
-	quad = port / ICE_PORTS_PER_QUAD;
+	quad = ICE_GET_QUAD_NUM(port);
 
 	err = ice_read_quad_reg_e82x(hw, quad, Q_REG_TX_MEM_GBL_CFG, &val);
 	if (err) {
@@ -2636,6 +2645,17 @@ ice_get_phy_tx_tstamp_ready_e82x(struct ice_hw *hw, u8 quad, u64 *tstamp_ready)
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
@@ -2863,17 +2883,21 @@ static int ice_clear_phy_tstamp_e810(struct ice_hw *hw, u8 lport, u8 idx)
 }
 
 /**
- * ice_ptp_init_phy_e810 - Enable PTP function on the external PHY
+ * ice_ptp_init_phc_e810 - Perform E810 specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Enable the timesync PTP functionality for the external PHY connected to
- * this function.
+ * Perform E810-specific PTP hardware clock initialization steps.
+ *
+ * Return: 0 on success, other error codes when failed to initialize TimeSync
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
@@ -2884,21 +2908,6 @@ int ice_ptp_init_phy_e810(struct ice_hw *hw)
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
@@ -3242,6 +3251,17 @@ int ice_read_pca9575_reg_e810t(struct ice_hw *hw, u8 offset, u8 *data)
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
@@ -3299,18 +3319,22 @@ void ice_ptp_unlock(struct ice_hw *hw)
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
@@ -3331,7 +3355,7 @@ static int ice_ptp_tmr_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 	ice_ptp_src_cmd(hw, cmd);
 
 	/* Next, prepare the ports */
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_port_cmd_e810(hw, cmd);
 		break;
@@ -3383,7 +3407,7 @@ int ice_ptp_init_time(struct ice_hw *hw, u64 time)
 
 	/* PHY timers */
 	/* Fill Rx and Tx ports and send msg to PHY */
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_time_e810(hw, time & 0xFFFFFFFF);
 		break;
@@ -3425,7 +3449,7 @@ int ice_ptp_write_incval(struct ice_hw *hw, u64 incval)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), lower_32_bits(incval));
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), upper_32_bits(incval));
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_incval_e810(hw, incval);
 		break;
@@ -3491,7 +3515,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 	wr32(hw, GLTSYN_SHADJ_L(tmr_idx), 0);
 	wr32(hw, GLTSYN_SHADJ_H(tmr_idx), adj);
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
@@ -3521,7 +3545,7 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
  */
 int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_read_phy_tstamp_e810(hw, block, idx, tstamp);
 	case ICE_PHY_E82X:
@@ -3549,7 +3573,7 @@ int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp)
  */
 int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_clear_phy_tstamp_e810(hw, block, idx);
 	case ICE_PHY_E82X:
@@ -3610,7 +3634,7 @@ static int ice_get_pf_c827_idx(struct ice_hw *hw, u8 *idx)
  */
 void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 {
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E82X:
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
@@ -3636,7 +3660,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	/* Clear event err indications for auxiliary pins */
 	(void)rd32(hw, GLTSYN_STAT(src_idx));
 
-	switch (hw->phy_model) {
+	switch (hw->ptp.phy_model) {
 	case ICE_PHY_E810:
 		return ice_ptp_init_phc_e810(hw);
 	case ICE_PHY_E82X:
@@ -3659,7 +3683,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
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
index f0796a93f428..2d2af80a65a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -818,6 +818,9 @@ struct ice_mbx_data {
 	u16 async_watermark_val;
 };
 
+#define ICE_PORTS_PER_QUAD	4
+#define ICE_GET_QUAD_NUM(port) ((port) / ICE_PORTS_PER_QUAD)
+
 /* PHY model */
 enum ice_phy_model {
 	ICE_PHY_UNSUP = -1,
@@ -825,6 +828,12 @@ enum ice_phy_model {
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
@@ -846,7 +855,6 @@ struct ice_hw {
 	u8 revision_id;
 
 	u8 pf_id;		/* device profile info */
-	enum ice_phy_model phy_model;
 
 	u16 max_burst_size;	/* driver sets this value */
 
@@ -909,12 +917,7 @@ struct ice_hw {
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
2.44.0.53.g0f9d4d28b7e6


