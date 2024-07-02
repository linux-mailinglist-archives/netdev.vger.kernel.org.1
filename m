Return-Path: <netdev+bounces-108580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA5924706
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469CE1C24D1C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1E1C68BB;
	Tue,  2 Jul 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zl9m4/tk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC1A1BD005
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943640; cv=none; b=Bwx2KwGJpoqUFbMrm00POVS2uLw3d79Ky1/+BpIXJ1Da7CMbsGWWarOgzasNQFKAerwPF6HlevHd0y4oG7hroYLE/rfroiRamgEz5q6aPxm7cKmShoCX3W5BcX55UqJbsQc74ExFmbwMgJPzq98n5prqiab8H1NjyjIH9J97Pqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943640; c=relaxed/simple;
	bh=Yi8ZZ5pxTipJ86XTGyTGrtbL82/4vcyZpLMwt+6B4KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5xeY8RLrII871zJ4JX/q36UQJjirwDToi8xyHmXPbZTfY6k3kcNkdRgaFkb4xkO9t7ehqK1GK9CvYYmtVVHIcGUPXQDn86mrOvzDx1ZApxcjNMWom8CH9yBVywq/OwZpf4Dz85xsP5+WH3P3GumWKdxo1uoAM+fByZrVxy7+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zl9m4/tk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719943640; x=1751479640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yi8ZZ5pxTipJ86XTGyTGrtbL82/4vcyZpLMwt+6B4KU=;
  b=Zl9m4/tkxByaIIflVOGlYxQ5gUfLpv5Mj1S+XyK03aab2rjDaM45aAmI
   B4G/djsxSUdprivObECVjPepQ9zX0uK67Pph+mY0/zOM02ExbT4K2XrIE
   Y7sP1/9DVOSSH1sN5Vf7VF5esS0u5Nsm7AH6g85j7vonfOWcXd7Zo9tBm
   pvpUj84kePAMbDg7rABKBr0Dbu7ehZaE0jvDLValkm2bwsqv/JaFQYPIf
   w7k9RlCBBIzEFmS7ycfVTF3//N/pCkpKmlw02LDI+RWV3huN8I8LoerRW
   hxn2Fk9qzPmTLzk0httD0Qdh1unY2Q91TWRxOHrOxDFIAY17GikpOJqXX
   g==;
X-CSE-ConnectionGUID: bb5iCpsTRxOU5WaaPQrgFg==
X-CSE-MsgGUID: yenkgqZNRuKJLf9xhxFR3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16964040"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16964040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:07:18 -0700
X-CSE-ConnectionGUID: tgJ74ovoTMCPj4kgoFM6Ow==
X-CSE-MsgGUID: PKeFII76SUqRSH3FhbMa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50321225"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 11:07:17 -0700
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
Subject: [PATCH net-next 1/3] ice: Extend Sideband Queue command to support flags
Date: Tue,  2 Jul 2024 11:07:05 -0700
Message-ID: <20240702180710.2606969-2-anthony.l.nguyen@intel.com>
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

Current driver implementation for Sideband Queue supports a
fixed flag (ICE_AQ_FLAG_RD). To retrieve FEC statistics from
firmware, Sideband Queue command is used with a different flag.

Extend API for Sideband Queue command to use 'flags' as input
argument.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Anil Samal <anil.samal@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_common.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9ae61cd8923e..9fa9d914ae46 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1497,8 +1497,9 @@ ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
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
@@ -1522,7 +1523,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
 		 */
 		msg_len -= sizeof(msg.data);
 
-	desc.flags = cpu_to_le16(ICE_AQ_FLAG_RD);
+	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
 	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 40dc735dc25c..ef9e8c23580d 100644
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
2.41.0


