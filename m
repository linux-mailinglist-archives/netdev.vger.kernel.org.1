Return-Path: <netdev+bounces-285341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHJ/NlOY/Gn4RgAAu9opvQ
	(envelope-from <netdev+bounces-285341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:49:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791294E9963
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4D70300824E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819F83BED23;
	Thu,  7 May 2026 13:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXJLzg1M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B3E34A799
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161743; cv=none; b=bwiEHhma1K3J3hd5TZwoBofj8AZUC7bqSwvMyMk5pVFY+jX87RiNluNtmKZc0hKYWJBcAfraj/kgNVL4uLGDiCHhM4gd0/iy0f5oQtSLBZQ23YZiUgt6O87b5EvEPhTLzXab3ufrOQq5Qy0pIwt+VRzsHVJoKd0idczUAVuAhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161743; c=relaxed/simple;
	bh=A+KTmDpDglZQSmgszpYIjyFhjpb7dETZn1WZ60KJeRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpEgR6feXveO+t8CDpCCQ6ZbO2Wfw0qPlnZDFkT5SONRvV4Z1x+3K3K36vXSlDmhlPnpwFDWAV7ySrUZWDzXPx5B1P8Uux5Cq64dzNCGxlc9ghjwMohXyNIKTBK3Nwol36sgkirhK2v70H/PzHPN3eO0P+N+Ha34TDCX7DKLcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXJLzg1M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778161741; x=1809697741;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A+KTmDpDglZQSmgszpYIjyFhjpb7dETZn1WZ60KJeRI=;
  b=OXJLzg1M/UXJk/Acih1gQBEKMx112+FiL4bTAVamqLqmDmXhzDaliPoD
   zRrJ8x52PsMmtt9gd1a152axtJcKvIj3SxkIMDMmEOJ1DdbK4VN7ST9tp
   h1I2ch7DbMENthUw8Kuz7215Vd91ADIU990unrhHz/0F8Yl3xrd0UfgsS
   MiPBo8Wyfe1SApo3uEf1mGodcRaLHS3KHC7m1l1zGLd2TDDpNw2R9KjIB
   nzS/JopLW9wULQonkL5FsHnnmjYr5eisKY2wJjBdM8f7nVGpEEchCC/xI
   DwKF0LFA6jsc9X/Vq2MBXGuGELKKI1y2ynIYYLzfTPmP0SAMcutR3YAmL
   A==;
X-CSE-ConnectionGUID: vLl5xe5ETF2L9m4lQBxMWA==
X-CSE-MsgGUID: RbUFXi6IQoqrirwmEESXsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="89806415"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="89806415"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 06:49:01 -0700
X-CSE-ConnectionGUID: s0c4p73sTeqtXUBXj4X7LQ==
X-CSE-MsgGUID: LH2xEWJaQ6e8lFx9m0BbbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="238267633"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa004.fm.intel.com with ESMTP; 07 May 2026 06:48:59 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-net] ice: support SBQ posted writes with non-posted support for CGU
Date: Thu,  7 May 2026 15:51:08 +0200
Message-ID: <20260507135110.809367-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 791294E9963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285341-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msg.data:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Karol Kolacinski <karol.kolacinski@intel.com>

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

To analyze if delays are gone, look for and compare time spent in
ice_sq_send_cmd — posted writes should return immediately after the wr32.
That can be done for example by adjusting phc time with phc_ctl on E830
device, for less than 2 seconds to use this new mechanism. Without it,
command below will fail.

Reproduction steps:
phc_ctl eth13 adj 1
phc_ctl[4478170.994]: adjusted clock by 1.000000 seconds

Check trace for timing for comparisions:
echo ice_sbq_send_cmd > /sys/kernel/debug/tracing/set_ftrace_filter
echo function_graph > /sys/kernel/debug/tracing/current_tracer
cat /sys/kernel/debug/tracing/trace

Tested on:
  - Intel E830 NIC (FW version 1.00)
  - Kernel 6.19.0+

Fixes: 8f5ee3c477a8 ("ice: add support for sideband messages")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c   | 21 ++++--
 drivers/net/ethernet/intel/ice/ice_controlq.c |  4 ++
 drivers/net/ethernet/intel/ice/ice_controlq.h |  1 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 64 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  5 +-
 5 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0ec65007d672..d5007f6c9d6e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1762,6 +1762,7 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 {
 	struct ice_sbq_cmd_desc desc = {0};
 	struct ice_sbq_msg_req msg = {0};
+	struct ice_sq_cd cd = {};
 	u16 msg_len;
 	int status;
 
@@ -1774,19 +1775,29 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
 	msg.msg_addr_low = cpu_to_le16(in->msg_addr_low);
 	msg.msg_addr_high = cpu_to_le32(in->msg_addr_high);
 
-	if (in->opcode)
+	switch (in->opcode) {
+	case ice_sbq_msg_wr_p:
+	case ice_sbq_msg_wr_np:
 		msg.data = cpu_to_le32(in->data);
-	else
+		break;
+	case ice_sbq_msg_rd:
 		/* data read comes back in completion, so shorten the struct by
 		 * sizeof(msg.data)
 		 */
 		msg_len -= sizeof(msg.data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cd.posted = in->opcode == ice_sbq_msg_wr_p;
 
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
-	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, NULL);
-	if (!status && !in->opcode)
+	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
+
+	if (!status && in->opcode == ice_sbq_msg_rd)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
 	return status;
@@ -6557,7 +6568,7 @@ int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.dest_dev = ice_get_dest_cgu(hw),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_np,
 		.msg_addr_low = addr,
 		.data = val
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index dcb837cadd18..a6008dc77fa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -1086,6 +1086,10 @@ ice_sq_send_cmd(struct ice_hw *hw, struct ice_ctl_q_info *cq,
 	wr32(hw, cq->sq.tail, cq->sq.next_to_use);
 	ice_flush(hw);
 
+	/* If the message is posted, don't wait for completion. */
+	if (cd && cd->posted)
+		goto sq_send_command_error;
+
 	/* Wait for the command to complete. If it finishes within the
 	 * timeout, copy the descriptor back to temp.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 788040dd662e..c50d6fcbacba 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -77,6 +77,7 @@ struct ice_ctl_q_ring {
 /* sq transaction details */
 struct ice_sq_cd {
 	struct libie_aq_desc *wb_desc;
+	u8 posted : 1;
 };
 
 /* rq event information */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 2c18e16fe053..5a1a1f5ea9bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -352,6 +352,16 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
 static void ice_ptp_exec_tmr_cmd(struct ice_hw *hw)
 {
 	struct ice_pf *pf = container_of(hw, struct ice_pf, hw);
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_rd,
+	};
+	int err;
+
+	/* Flush SBQ by reading address 0 on PHY 0 */
+	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
+	if (err)
+		dev_warn(ice_hw_to_dev(hw), "Failed to flush SBQ: %d\n", err);
 
 	if (!ice_is_primary(hw))
 		hw = ice_get_primary_hw(pf);
@@ -442,7 +452,7 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input msg = {
 		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_p,
 		.msg_addr_low = lower_16_bits(addr),
 		.msg_addr_high = upper_16_bits(addr),
 		.data = val
@@ -2504,11 +2514,12 @@ static bool ice_is_40b_phy_reg_e82x(u16 low_addr, u16 *high_addr)
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
@@ -2581,12 +2592,13 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
 static int
 ice_write_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val
+	};
 	int err;
 
 	ice_fill_phy_msg_e82x(hw, &msg, port, offset);
-	msg.opcode = ice_sbq_msg_wr;
-	msg.data = val;
 
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
@@ -2740,15 +2752,15 @@ static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
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
@@ -2774,16 +2786,16 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
 int
 ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.opcode = ice_sbq_msg_wr_p,
+		.data = val
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
@@ -4450,14 +4462,14 @@ static void ice_ptp_init_phy_e82x(struct ice_ptp_hw *ptp)
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
-
 	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to send message to PHY, err %d\n",
@@ -4480,15 +4492,15 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
  */
 static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_sbq_dev_phy_0,
+		.opcode = ice_sbq_msg_wr_p,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val
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
index 21bb861febbf..86a143ebf089 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -54,8 +54,9 @@ enum ice_sbq_dev_id {
 };
 
 enum ice_sbq_msg_opcode {
-	ice_sbq_msg_rd	= 0x00,
-	ice_sbq_msg_wr	= 0x01
+	ice_sbq_msg_rd		= 0x00,
+	ice_sbq_msg_wr_p	= 0x01,
+	ice_sbq_msg_wr_np	= 0x02,
 };
 
 #define ICE_SBQ_MSG_FLAGS	0x40

base-commit: 0e1f1fc37cbc0d7c4d977d9570ad9eefaccf83fc
-- 
2.43.0


