Return-Path: <netdev+bounces-103595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAE6908C29
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 14:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7B1C22116
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104C19AA41;
	Fri, 14 Jun 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxqZWvKp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B69199EBB
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369987; cv=none; b=ns3xgAYiw0EuQFCevuWjVkc7wkpwqob9nzdjChbfRmA1gekA0BZt4HiQzS4eeBvs+YE9p9vdFXY8yQHv+tsfHDpMf/vXCAzdJ04b29qPm+2XzK84Hen7+z5VZ/Ttfl002ZSV+Ze0gcI7DtzjLiLcVoLDZtn403RouqZ7L210fGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369987; c=relaxed/simple;
	bh=ssJh0jFw2OZv/K2ra0IlI8NId+Agl0dxpDhNp5sIibk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlcCthmIVQrfb5wkRzVQQiXpXul0RVMcC64lnFtdM0Alf5vyE73gqIkFqbCfDbIwisHTcdZYp6briVA1ZCEOyrm2PXjZGMNntfBfgh3Eid8sq/AryqLxqerSn+YDNl3ZvZQxFBFPegni5/DmwkqSVhjFLUe144/pEqTdPIXION4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxqZWvKp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718369985; x=1749905985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ssJh0jFw2OZv/K2ra0IlI8NId+Agl0dxpDhNp5sIibk=;
  b=nxqZWvKpqR53ZpplJmpAl3UJTbztOZn4g82IYcXfKAhDd7y8SnV/Ca2e
   zvXkrJWkvSDgRVwwEVL030rQoUKvxXD5elINk0IZN42N3hJDG/KZyuXIe
   ARQcVDPeWqw92cnSusfurEeDzb4oJ8ibQbGcHwVjQBPf27AWfvSdaKckv
   vTqadjYZwRHXSFmwDQim/ZgLXvthU1kc8MvSmUDDFzqSEwhO8shlmbZPJ
   DsE6HyzVyKxxROLZsngBwNvIniM7OYke98ZZTbCoCyuLwv2ecXvU8kuWS
   LkmhieNqhzrDwU49EwY9Rs1Ibz933hTFAONQ+TEIXhVb66gxl3mCBoVII
   A==;
X-CSE-ConnectionGUID: /sf94+uNSM2S/Rm5Qut3hw==
X-CSE-MsgGUID: Y5X0WtMrTW+oW38cLju4Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="40669473"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40669473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:59:43 -0700
X-CSE-ConnectionGUID: J1jOVKBMQIGiCU55574LYg==
X-CSE-MsgGUID: mGwV3yBsRxe04tk1ehLzyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40593806"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:59:43 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leszek.pepiak@intel.com,
	przemyslaw.kitszel@intel.com,
	lukasz.czapnik@intel.com,
	anthony.l.nguyen@intel.com,
	Anil Samal <anil.samal@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v3 1/3] ice: Extend Sideband Queue command to support flags
Date: Fri, 14 Jun 2024 05:58:15 -0700
Message-ID: <20240614125935.900102-2-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614125935.900102-1-anil.samal@intel.com>
References: <20240614125935.900102-1-anil.samal@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current driver implementation for Sideband Queue supports a
fixed flag (ICE_AQ_FLAG_RD). To retrieve FEC statistics from
firmware, Sideband Queue command is used with a different flag.

Extend API for Sideband Queue command to use 'flags' as input
argument.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_common.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 60ad7774812c..03e908405874 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1498,8 +1498,9 @@ ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
  * ice_sbq_rw_reg - Fill Sideband Queue command
  * @hw: pointer to the HW struct
  * @in: message info to be filled in descriptor
+ * @flags: control queue descriptor flags
  */
-int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
+int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
@@ -1523,7 +1524,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
 		 */
 		msg_len -= sizeof(msg.data);
 
-	desc.flags = cpu_to_le16(ICE_AQ_FLAG_RD);
+	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
 	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9a91f71ab727..230ec034dc44 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -202,7 +202,7 @@ int ice_replay_vsi(struct ice_hw *hw, u16 vsi_handle);
 void ice_replay_post(struct ice_hw *hw);
 struct ice_q_ctx *
 ice_get_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 q_handle);
-int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in);
+int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flag);
 int
 ice_aq_get_cgu_abilities(struct ice_hw *hw,
 			 struct ice_aqc_get_cgu_abilities *abilities);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 1e9a4ccd0ea2..3a33e6b9b313 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -247,7 +247,7 @@ static int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
 	};
 	int err;
 
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read CGU register 0x%04x, err %d\n",
 			  addr, err);
@@ -280,7 +280,7 @@ static int ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
 	};
 	int err;
 
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to write CGU register 0x%04x, err %d\n",
 			  addr, err);
@@ -902,7 +902,7 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
 	phy_msg.data = val;
 	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
 
-	err = ice_sbq_rw_reg(hw, &phy_msg);
+	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
 
 	if (err)
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
@@ -934,7 +934,7 @@ static int ice_read_phy_eth56g(struct ice_hw *hw, u8 phy_idx, u32 addr,
 	phy_msg.data = 0;
 	phy_msg.dest_dev = hw->ptp.phy.eth56g.phy_addr[phy_idx];
 
-	err = ice_sbq_rw_reg(hw, &phy_msg);
+	err = ice_sbq_rw_reg(hw, &phy_msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "PTP failed to send msg to phy %d\n",
 			  err);
@@ -2855,7 +2855,7 @@ ice_read_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 *val)
 	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
 	msg.opcode = ice_sbq_msg_rd;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -2933,7 +2933,7 @@ ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -3094,7 +3094,7 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 
 	msg.opcode = ice_sbq_msg_rd;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -3129,7 +3129,7 @@ ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -4780,7 +4780,7 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 	msg.opcode = ice_sbq_msg_rd;
 	msg.dest_dev = rmn_0;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -4811,7 +4811,7 @@ static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 	msg.dest_dev = rmn_0;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
-- 
2.44.0


