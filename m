Return-Path: <netdev+bounces-278750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPuGO4p332kATgAAu9opvQ
	(envelope-from <netdev+bounces-278750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 460A0403D84
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 13:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 536A73085D94
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D260C342524;
	Wed, 15 Apr 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A9Lm+Rml"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBC30DECB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776252378; cv=none; b=EbUhZc1GRC+TjDrLgB4AZEt6BOCPMmJSmmJMqjXMJfdvfQ2dAS1Iz9yfV0rCjieSz4Zugk0zbRy7g59hl82eYgEURgaHh6ZoKRFWlYhOUUriem56FWaMeBVhksLa1g63DQvQzCl7r2LKMEhYeA38/Wkm2IZ1j1snL3EOA1rJdVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776252378; c=relaxed/simple;
	bh=eIZb6zCxsJfPaW4k4tZ8a8BEq2ntgaMYL7LfKkdt5ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUBP93cKnNcm3vkd/CZNqQ+E4k/XAlNAa3uDWv/kSUkjdQQJ9WR24Dw71JAW6wBjXmiAs2gxVRnbmHqcMBhE7pSCa73Lce+NWZKirAkiT+PNS2ZfQs85pcumzXiTAHR+UoJdlSLv5IryhtiQ/S7xmyMST8st/xEkikcRUWE6T+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A9Lm+Rml; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776252377; x=1807788377;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eIZb6zCxsJfPaW4k4tZ8a8BEq2ntgaMYL7LfKkdt5ho=;
  b=A9Lm+RmlzcVppj/xnWAiyYWLasOhAn0s5TOl8DwGuVh6PPspzns3dbTu
   oLmxTcSvDNcz04XQLxTAEtimaMA3+C1O59UXB5+Q8ZFPN1mjJmxFRl9Hv
   J6ZFDsqcOwZtoC9hF0c4XDrQl0V4TJPNHnrVegcFyY3cYqaUvy8K+5rW2
   H0etcE7PIOx0RHGaNls9Oy5FyDHIBHeQvfChd+VGwXkYDMiZZAKMYVXQu
   TCHB+tg7GcGdnWUMuIq0L5F9VxMXPM6O1xlCPddm5iNEIFPKXPMenFSNh
   w3guVcbcUoucJwWOEjbPP8w7jedAy6n9fYTwjZ6F77djm4f4uTo7MXm+M
   w==;
X-CSE-ConnectionGUID: 6NU9KQujScSatVB2jMsGWA==
X-CSE-MsgGUID: V9hWTIWkRCyNOq6Xv32yOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94626761"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94626761"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 04:26:17 -0700
X-CSE-ConnectionGUID: cFiMoeY0QKWnbnpjPLr5Fg==
X-CSE-MsgGUID: 5o0dAeXFQk+/x73ulD9N8Q==
X-ExtLoop1: 1
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2026 04:26:14 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-next] ice: add SBQ posted writes with non-posted support for CGU
Date: Wed, 15 Apr 2026 13:27:05 +0200
Message-ID: <20260415112706.1562382-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278750-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msg.data:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 460A0403D84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 18 ++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 64 ++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |  5 +-
 3 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f84990996530..2cd3d6d450a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1777,23 +1777,29 @@ int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in, u16 flags)
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
 
-	if (in->opcode == ice_sbq_msg_wr)
-		cd.posted = 1;
+	cd.posted = in->opcode == ice_sbq_msg_wr_p;
 
 	desc.flags = cpu_to_le16(flags);
 	desc.opcode = cpu_to_le16(ice_sbq_opc_neigh_dev_req);
 	desc.param0.cmd_len = cpu_to_le16(msg_len);
 	status = ice_sbq_send_cmd(hw, &desc, &msg, msg_len, &cd);
 
-	if (!status && !in->opcode)
+	if (!status && in->opcode == ice_sbq_msg_rd)
 		in->data = le32_to_cpu
 			(((struct ice_sbq_msg_cmpl *)&msg)->data);
 	return status;
@@ -6701,7 +6707,7 @@ int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.dest_dev = ice_get_dest_cgu(hw),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_np,
 		.msg_addr_low = addr,
 		.data = val
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 690f9d874443..0f202d4dae7c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -368,6 +368,16 @@ void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd)
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
@@ -433,7 +443,7 @@ static int ice_write_phy_eth56g(struct ice_hw *hw, u8 port, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input msg = {
 		.dest_dev = ice_ptp_get_dest_dev_e825(hw, port),
-		.opcode = ice_sbq_msg_wr,
+		.opcode = ice_sbq_msg_wr_p,
 		.msg_addr_low = lower_16_bits(addr),
 		.msg_addr_high = upper_16_bits(addr),
 		.data = val
@@ -2358,11 +2368,12 @@ static bool ice_is_40b_phy_reg_e82x(u16 low_addr, u16 *high_addr)
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
@@ -2435,12 +2446,13 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
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
@@ -2594,15 +2606,15 @@ static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
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
@@ -2628,16 +2640,16 @@ ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val)
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
@@ -4275,14 +4287,14 @@ static void ice_ptp_init_phy_e82x(struct ice_ptp_hw *ptp)
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
@@ -4305,15 +4317,15 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
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

base-commit: 0851f49814a8899a9769619b50baaeef59f9ece4
-- 
2.43.0


