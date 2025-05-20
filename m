Return-Path: <netdev+bounces-191815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA094ABD65A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D297188BAAA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0D27F16F;
	Tue, 20 May 2025 11:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfac3bBH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0527EC98
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739319; cv=none; b=UsbQhouGIu1+xSo2Ndhow4Tytuf41y5yIR9jXSkPOqaX/RZyz2C3SZJh2+mtHRVuayvGIWJIKiG4Rspqbr+2KWtYbSc7yQV7JuaPCexeyy1b68hMOKBhOTUcUzeA5wHzGOVkjwqHdP17pvZ8X5e40KI75GYiT+NXHq2BGV4mlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739319; c=relaxed/simple;
	bh=SrsLS2LUnwUArdPMor6FhYvQ5NlT6KixTpedgiAYH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mhp9CSnPpXaN6Gnu2XrndoQ29YqcfPUlg4RhzzneoFfFfjKOt8x79Vxkrja1PIMDoWMq0b4ANbvXc7Q2wtoHaBptbQHXbXyR45A3/kDpXibyFUfdlxOSPDUbAr5PLNTFf56SnqNrkFqNkBrrPPQj1y2CYmbJOSUAQ/qLZdZa/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfac3bBH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747739317; x=1779275317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SrsLS2LUnwUArdPMor6FhYvQ5NlT6KixTpedgiAYH+A=;
  b=jfac3bBHLGkgTY6wckoqDSuVcuZq9iJwitxvdbgznaEc7gIHJCUnobEO
   hod7yFPzTeCjR/sHsrJZAl+GoVXfcg+SWAaC7AZFh1VP9e5JutVbQllfA
   JM+Xgr9fGpW0FWZEoFwfpy18T45jH76lB8XEcXr/QtlrPRWgBaCS4Vso1
   iY5vw6E2SGWzzXGGrORslB31e3/S8Co2//kW5I9ZGh1PwQzGSJl5DCXug
   uPW4KqnX9EFh5n++UQmfT9exyozWKj7/1RVNsrLLza3HxWBRlOqRFD8h6
   lxa2u3J/+5S6NNmX9O8YSKt0uXzAnJvTYdHq56y4wfqBrUXdoQDLieuxM
   g==;
X-CSE-ConnectionGUID: WdGBiqHnTJqD5zvKJkGrSQ==
X-CSE-MsgGUID: a28miIbqTq6fYkkUDmo4LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75069261"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75069261"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:08:36 -0700
X-CSE-ConnectionGUID: sfgvh+3lS2aOjYjwnUow5Q==
X-CSE-MsgGUID: a/CZZmw2SkevRYXAul+iaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140172958"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2025 04:08:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-next 1/4] ice: skip completion for sideband queue writes
Date: Tue, 20 May 2025 13:06:26 +0200
Message-ID: <20250520110823.1937981-7-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110823.1937981-6-karol.kolacinski@intel.com>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sideband queue (SBQ) is a HW queue with very short completion time. All
SBQ writes were posted by default, which means that the driver did not
have to wait for completion from the neighbor device, because there was
none. This introduced unnecessary delays, where only those delays were
"ensuring" that the command is "completed" and this was a potential race
condition.

Add the possibility to perform non-posted writes where it's necessary to
wait for completion, instead of relying on fake completion from the FW,
where only the delays are guarding the writes.

Flush the SBQ by reading address 0 from the PHY 0 before issuing SYNC
command to ensure that writes to all PHYs were completed and skip SBQ
message completion if it's posted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 13 ++--
 drivers/net/ethernet/intel/ice/ice_controlq.c |  4 ++
 drivers/net/ethernet/intel/ice/ice_controlq.h |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 62 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  5 +-
 5 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 11a954e8dc62..53b9b5b54187 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1523,6 +1523,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
+	struct ice_sq_cd cd = {};
 	u16 msg_len;
 	int status;
 
@@ -1535,7 +1536,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 	msg.msg_addr_low = cpu_to_le16(in->msg_addr_low);
 	msg.msg_addr_high = cpu_to_le32(in->msg_addr_high);
 
-	if (in->opcode)
+	if (in->opcode == ice_sbq_msg_wr_p || in->opcode == ice_sbq_msg_wr_np)
 		msg.data = cpu_to_le32(in->data);
 	else
 		/* data read comes back in completion, so shorten the struct by
@@ -1543,10 +1544,12 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 		 */
 		msg_len -= sizeof(msg.data);
 
+	cd.postpone = in->opcode == ice_sbq_msg_wr_p;
+
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
-	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
+	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
 	if (!status && !in->opcode)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
@@ -6260,7 +6263,7 @@ int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
 	struct ice_sbq_msg_input cgu_msg = {
 		.opcode = ice_sbq_msg_rd,
 		.dest_dev = ice_sbq_dev_cgu,
-		.msg_addr_low = addr
+		.msg_addr_low = addr,
 	};
 	int err;
 
@@ -6290,10 +6293,10 @@ int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
 int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_np,
 		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr,
-		.data = val
+		.data = val,
 	};
 	int err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index dcb837cadd18..5fb3a8441beb 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
+	/* If the message is posted, don't wait for completion. */
+	if (cd && cd->postpone)
+		goto sq_send_command_error;
+
 	/* Wait for the command to complete. If it finishes within the
 	 * timeout, copy the descriptor back to temp.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 788040dd662e..7c98d3a0314e 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
 /* sq transaction details */
 struct ice_sq_cd {
 	struct libie_aq_desc *wb_desc;
+	u8 postpone : 1;
 };
 
 /* rq event information */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 523f95271f35..9a4ecf1249ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -352,6 +352,13 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_rd,
+	};
+
+	/* Flush SBQ by reading address 0 on PHY 0 */
+	ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
@@ -417,10 +424,10 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input msg = {
 		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_p,
 		.msg_addr_low = lower_16_bits(addr),
 		.msg_addr_high = upper_16_bits(addr),
-		.data = val
+		.data = val,
 	};
 	int err;
 
@@ -2342,11 +2349,12 @@ static bool ice_is_40b_phy_reg_e82x(u16 low_addr, u16 *high_addr)
 static int
 ice_read_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 *val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_rd,
+	};
 	int err;
 
 	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
-	msg.opcode = ice_sbq_msg_rd;
 
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
@@ -2419,12 +2427,13 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
 static int
 ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val,
+	};
 	int err;
 
 	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
-	msg.opcode = ice_sbq_msg_wr;
-	msg.data = val;
 
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
@@ -2578,15 +2587,15 @@ static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
 int
 ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_rd,
+	};
 	int err;
 
 	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
-	msg.opcode = ice_sbq_msg_rd;
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
@@ -2612,16 +2621,16 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 int
 ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val,
+	};
 	int err;
 
 	err = ice_fill_quad_msg_e82x(hw, &msg, quad, offset);
 	if (err)
 		return err;
 
-	msg.opcode = ice_sbq_msg_wr;
-	msg.data = val;
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
@@ -4259,13 +4268,14 @@ static void ice_ptp_init_phy_e82x(struct ice_ptp_hw *ptp)
  */
 static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_rd,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+	};
 	int err;
 
-	msg.msg_addr_low = lower_16_bits(addr);
-	msg.msg_addr_high = upper_16_bits(addr);
-	msg.opcode = ice_sbq_msg_rd;
-	msg.dest_dev = ice_sbq_dev_phy_0;
 
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
@@ -4289,15 +4299,15 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
  */
 static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_wr_p,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val,
+	};
 	int err;
 
-	msg.msg_addr_low = lower_16_bits(addr);
-	msg.msg_addr_high = upper_16_bits(addr);
-	msg.opcode = ice_sbq_msg_wr;
-	msg.dest_dev = ice_sbq_dev_phy_0;
-	msg.data = val;
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 183dd5457d6a..7960f888a655 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -53,8 +53,9 @@ enum ice_sbq_dev_id {
 };
 
 enum ice_sbq_msg_opcode {
-	ice_sbq_msg_rd	= 0x00,
-	ice_sbq_msg_wr	= 0x01
+	ice_sbq_msg_rd		= 0x00,
+	ice_sbq_msg_wr_p	= 0x01,
+	ice_sbq_msg_wr_np	= 0x02,
 };
 
 #define ICE_SBQ_MSG_FLAGS	0x40
-- 
2.49.0


