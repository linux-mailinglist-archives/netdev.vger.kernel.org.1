Return-Path: <netdev+bounces-109936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA71292A513
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689E0282F74
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05291419A1;
	Mon,  8 Jul 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaM8RBMx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A09140363
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450123; cv=none; b=qaBjdMDqLQBLq/3IAJIZndwCZ1KOAmVU0EZ8gLf3brW9vw5KUJwlHwHPwPeVM++55sUoDeICdaf+HyUBKNOTRhmgf21j9sI/b+uSQnRt892WwuWC+SXesW7lzx2ITIaorqikdL3UGay/+WDNjWG6h1MpUj8NeE55OR2Ugs2S4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450123; c=relaxed/simple;
	bh=xmytmRUjSBHTwa6soHME8Gov4JXwxg0x5R5JBUMqiMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFZ+vzBpWfYwIw/Wgm/OEN30w6Ohqnvx/wwb5PZ/mO+7Q6rS82IWKQ8EkGB2nE6Es9GGHnch7aUNcejRaEfBROqXBOqFT0LOornobyFWax5l7Dl2LOKlCjPlZiszt6jMHAIF8SWCYXGzhy5NkwEtvSGMgUEz+asFTztPXgVIwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaM8RBMx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720450122; x=1751986122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xmytmRUjSBHTwa6soHME8Gov4JXwxg0x5R5JBUMqiMc=;
  b=EaM8RBMxIYl7YpPi2Kuo8SYP7LBZPbIEu2Sq9zNH1VS9zaTBWhR9qDMJ
   +afd1I6UHX1q1kDlji3a9OEt6pcEBr1NSgCxnZdCZ9BEd/WRP5XiIr5MS
   psHeaW8PbZR/ttTIj1s23IPmrKubMTE9fckfwlmvAKXbMVw4sUZUUq1YC
   1kb5R8YzPmQC/S7hz0FavmlBEMGj8rAsJ3QGud7sjbZLQXSaXjauRHah4
   PJ+9YRGwju/aVBwnW75zfBjp8HwZJPmDRZFUoROHrbbtVjfyqKQt53in5
   6+KQU/5DCpRGgnO97WW7WrEyuYVPOsUb3yxTlSpcrlLjq5+RCohBbeJ80
   w==;
X-CSE-ConnectionGUID: n/rDSPY5SY6SFBEMfQkX+A==
X-CSE-MsgGUID: pKXsFpBYT7abV7A0MQ+Fmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="43076728"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="43076728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:48:41 -0700
X-CSE-ConnectionGUID: NcfMHYXmQzWHuyDD5hVxfA==
X-CSE-MsgGUID: 6gDcQcBZRPGBB/0eSoYDaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52473635"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 07:48:41 -0700
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
Subject: [PATCH iwl-next v4 1/3] ice: Extend Sideband Queue command to support flags
Date: Mon,  8 Jul 2024 07:46:26 -0700
Message-ID: <20240708144833.1337075-2-anil.samal@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708144833.1337075-1-anil.samal@intel.com>
References: <20240708144833.1337075-1-anil.samal@intel.com>
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
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
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
index e03475408a02..a6bdde294888 100644
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


