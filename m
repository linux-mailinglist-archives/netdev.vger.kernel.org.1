Return-Path: <netdev+bounces-95330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC008C1E7E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793291F22B60
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22F15ECEC;
	Fri, 10 May 2024 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0eqYnUv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401F15E811
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323978; cv=none; b=uOJss8aCgplVKhM0xiCKHIipj+d2TaQ8DEPuhj+cs47rIQGlGmMn8r9jVY72qY0/K3NuJcd08lju95hkgaOkqmcTyziCDYLSj6hlAJ6Zns5J4LkhCHbIM0+3RDqcf5+b7jyjZ5m5lVlUjINFLASDTpHbamAbiol8VdhNnCVIHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323978; c=relaxed/simple;
	bh=XmtiBOlFChF0ay3Cyi8VtV0AufD3HI0EkTZQj2hHCYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDzUSVMk/hGgQZhchG6kbqYsU/0kFamb8aQ3YSTp3fs+CPfja71dIOOqBXljOr9VXe0hxjBkls+UzgHoV0sFNWAve/eGS3t7ARSoXX5v8IGwAAwOcmpRuWnUw4HIxRmNWIr8wYS76BP3PetoF3u8prrHiyndhc9zWIV4WUaJOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0eqYnUv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715323977; x=1746859977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XmtiBOlFChF0ay3Cyi8VtV0AufD3HI0EkTZQj2hHCYk=;
  b=J0eqYnUvDGW9enwfj+Jp9qgmNKBKYod2rftLAwWNE2mSknxq6+/asjw/
   +XJBH7eE3aQJxAoqv4RzyV9+AIQV0lz5DfqBhkL7NlCYJdVsCeaWpJh0i
   0ebexJzrJuWGc51VsZ7fHhwMDuuTbMeUIOqqGSNF2qS7h7A/esJF1lQKO
   b8RCP1szFZv7IvhbaEwrS/OLHstWMRrMyY7JfIGDVwyk91+juXRYQ4W5N
   UZxfGGa3OGZATAHQ73h17CksY4TzIMOT0snlSVWkUoXbC+EycgfNDaL/E
   WHaEpXL3WKXDoDGysXow7udpLPnvnIgTGQ/2PgWYmxHMNixEuLiQ0rGPX
   Q==;
X-CSE-ConnectionGUID: MKIPMDHPSKqWkaYnaQ16hQ==
X-CSE-MsgGUID: lmneS8RRQqmxCXJgjDkImA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11138278"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="11138278"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 23:52:52 -0700
X-CSE-ConnectionGUID: fHbpBoTiRqaTNtJinkdhAg==
X-CSE-MsgGUID: jdT+2zdcR9KUj7kK/VL4CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="33950259"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 23:52:50 -0700
From: Anil Samal <anil.samal@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	--cc=jesse.brandeburg@intel.com,
	--cc=leszek.pepiak@intel.com,
	--cc=przemyslaw.kitszel@intel.com,
	--cc=lukasz.czapnik@intel.com,
	--cc=anthony.l.nguyen@intel.com,
	Anil Samal <anil.samal@intel.com>,
	Anthony L Nguyen <anthony.l.nguyen@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v2 1/3] ice: Extend Sideband Queue command to support dynamic flag
Date: Thu,  9 May 2024 23:50:40 -0700
Message-ID: <20240510065243.906877-2-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510065243.906877-1-anil.samal@intel.com>
References: <20240510065243.906877-1-anil.samal@intel.com>
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

Extend API for Sideband Queue command to use 'flag' as input
argument.

Reviewed-by: Anthony L Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_common.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 16 ++++++++--------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5649b257e631..9a0a533613ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1473,8 +1473,9 @@ ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
  * ice_sbq_rw_reg - Fill Sideband Queue command
  * @hw: pointer to the HW struct
  * @in: message info to be filled in descriptor
+ * @flag: flag to fill desc structure
  */
-int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
+int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flag)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
@@ -1498,7 +1499,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
 		 */
 		msg_len -= sizeof(msg.data);
 
-	desc.flags = cpu_to_le16(ICE_AQ_FLAG_RD);
+	desc.flags = cpu_to_le16(flag);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
 	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index ffb22c7ce28b..42cda1bbbaab 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -201,7 +201,7 @@ int ice_replay_vsi(struct ice_hw *hw, u16 vsi_handle);
 void ice_replay_post(struct ice_hw *hw);
 struct ice_q_ctx *
 ice_get_lan_q_ctx(struct ice_hw *hw, u16 vsi_handle, u8 tc, u16 q_handle);
-int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in);
+int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flag);
 int
 ice_aq_get_cgu_abilities(struct ice_hw *hw,
 			 struct ice_aqc_get_cgu_abilities *abilities);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2b9423a173bb..e97b73d1b0f4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -433,7 +433,7 @@ ice_read_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 *val)
 	ice_fill_phy_msg_e82x(&msg, port, offset);
 	msg.opcode = ice_sbq_msg_rd;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -511,7 +511,7 @@ ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -667,7 +667,7 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 
 	msg.opcode = ice_sbq_msg_rd;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -702,7 +702,7 @@ ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 	msg.opcode = ice_sbq_msg_wr;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -840,7 +840,7 @@ ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
 	cgu_msg.msg_addr_low = addr;
 	cgu_msg.msg_addr_high = 0x0;
 
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read CGU register 0x%04x, err %d\n",
 			  addr, err);
@@ -873,7 +873,7 @@ ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
 	cgu_msg.msg_addr_high = 0x0;
 	cgu_msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &cgu_msg);
+	err = ice_sbq_rw_reg(hw, &cgu_msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to write CGU register 0x%04x, err %d\n",
 			  addr, err);
@@ -2660,7 +2660,7 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 	msg.opcode = ice_sbq_msg_rd;
 	msg.dest_dev = rmn_0;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
@@ -2691,7 +2691,7 @@ static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 	msg.dest_dev = rmn_0;
 	msg.data = val;
 
-	err = ice_sbq_rw_reg(hw, &msg);
+	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
 			  err);
-- 
2.44.0


