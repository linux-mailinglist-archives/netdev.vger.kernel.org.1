Return-Path: <netdev+bounces-168545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751E1A3F483
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629CA3AF34C
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DA2063C1;
	Fri, 21 Feb 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTKdWWnp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCDE20B810
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141308; cv=none; b=ea1X6xVqMSln55Tpym1bp5WixRAfO/AfJ+mPXIb78P95v3ffazvud1cGZXjqtCfYZa72P+VaTwDnrl33V9hlNf4Wx+llw8cEIeY3bhF4KsY6qhnNEnAIW73qCc4oqp8pTZyQxHhAOtAaLZPRHlWT0KHsg4z8Me3qlCm+Ey0Gb80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141308; c=relaxed/simple;
	bh=ELuAb55NpJKeWHt/CBpTkgFOlCEJOHWF7w2RrzW+Q44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=unFaQce0QpL/rTumzTXVlK0fFPbixMwIMh2NgKHCpYYvNBI20BxL4Mky1lH3uU1u/uFtgzMv9Fxk5vwLH0mGDs3bR4k16j3oYFEx60UG4tGzoHtIzZFdPkQYMATlA3bvVGYpJGEqqcGYxvpt+FBYvLYcnhQU3SRaclr3aovCnog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTKdWWnp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740141307; x=1771677307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ELuAb55NpJKeWHt/CBpTkgFOlCEJOHWF7w2RrzW+Q44=;
  b=JTKdWWnpvTJoKovpimbbRLElBsVnJHlp86x1AOIv5bbihy+b+1sjJ4Ny
   wXV2Lu4Nf/MsyZVh2LN3eOkaCp8SZnTiOKaSqLxWquwtoFyr+5O2avHiJ
   SAlNNEuqiiuzlIr6Xo+vsCG3xWmvOkpRIrsVL7AeRQqE8Ox20NlJBxPMO
   3r/LhKE2xHt3n1SQX44VYVPuaesBv2EzSu1IYbhrl+ypSlOBFxCp6Uiv9
   qZCwdg1Hrd/PIqod4XFQ5U4N2XU8i6PL4sDomlWedmiT1dc3arKPcpSoj
   8aCChbUTq1tQ+6WbOYcMcY7idvLkxnzEjGlx/CXHcBl3X5bapkgN/NCXs
   A==;
X-CSE-ConnectionGUID: QRCM3LtbQWSsH9wsFDyNeA==
X-CSE-MsgGUID: k5cvGMKLSj2/UjAnX3/S2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66321397"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="66321397"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:35:06 -0800
X-CSE-ConnectionGUID: MfmvXKbMSbmtXmi9gDRXUw==
X-CSE-MsgGUID: 1aRALnZ+TiymJGG3Fuejsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115862577"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 04:35:05 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 2/3] ice: refactor ice_sbq_msg_dev enum
Date: Fri, 21 Feb 2025 13:31:22 +0100
Message-Id: <20250221123123.2833395-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
References: <20250221123123.2833395-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Rename ice_sbq_msg_dev to ice_sbq_dev_id to reflect the meaning of this
type more precisely. This enum type describes RDA (Remote Device Access)
client ids, accessible over SB (Side Band) interface.
Rename enum elements to make a driver namespace more cleaner and
consistent with other definitions within SB
Remove unused 'rmn_x' entries, specific to unsupported E824 device.
Adjust clients '2' and '13' names (phy_0 and phy_0_peer respectively) to
be compliant with EAS doc. According to the specification, regardless of
the complex entity (single or dual), when accessing its own ports,
they're accessed always as 'phy_0' client. And referred as 'phy_0_peer'
when handling ports conneced to the other complex.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 20 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 ++++-------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index f2e51bacecf8..ed7ef8608cbb 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3433,7 +3433,7 @@ int ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 	msg.msg_addr_low = lower_16_bits(reg_offset);
 	msg.msg_addr_high = receiver_id;
 	msg.opcode = ice_sbq_msg_rd;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 
 	err = ice_sbq_rw_reg(hw, &msg, flag);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a5df081ffc19..eb1893dd8979 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -240,7 +240,7 @@ static int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.opcode = ice_sbq_msg_rd,
-		.dest_dev = cgu,
+		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr
 	};
 	int err;
@@ -272,7 +272,7 @@ static int ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.opcode = ice_sbq_msg_wr,
-		.dest_dev = cgu,
+		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr,
 		.data = val
 	};
@@ -919,16 +919,16 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
  *
  * Return: destination sideband queue PHY device.
  */
-static enum ice_sbq_msg_dev ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
-						      u8 port)
+static enum ice_sbq_dev_id ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
+						     u8 port)
 {
 	/* On a single complex E825, PHY 0 is always destination device phy_0
 	 * and PHY 1 is phy_0_peer.
 	 */
 	if (port >= hw->ptp.ports_per_phy)
-		return eth56g_phy_1;
+		return ice_sbq_dev_phy_0_peer;
 	else
-		return eth56g_phy_0;
+		return ice_sbq_dev_phy_0;
 }
 
 /**
@@ -2758,7 +2758,7 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 		msg->msg_addr_high = P_Q1_H(P_4_BASE + offset, phy_port);
 	}
 
-	msg->dest_dev = rmn_0;
+	msg->dest_dev = ice_sbq_dev_phy_0;
 }
 
 /**
@@ -3081,7 +3081,7 @@ static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
 	if (quad >= ICE_GET_QUAD_NUM(hw->ptp.num_lports))
 		return -EINVAL;
 
-	msg->dest_dev = rmn_0;
+	msg->dest_dev = ice_sbq_dev_phy_0;
 
 	if (!(quad % ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy)))
 		addr = Q_0_BASE + offset;
@@ -4800,7 +4800,7 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 	msg.msg_addr_low = lower_16_bits(addr);
 	msg.msg_addr_high = upper_16_bits(addr);
 	msg.opcode = ice_sbq_msg_rd;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 
 	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
@@ -4830,7 +4830,7 @@ static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 	msg.msg_addr_low = lower_16_bits(addr);
 	msg.msg_addr_high = upper_16_bits(addr);
 	msg.opcode = ice_sbq_msg_wr;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 	msg.data = val;
 
 	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 3b0054faf70c..183dd5457d6a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -46,13 +46,10 @@ struct ice_sbq_evt_desc {
 	u8 data[24];
 };
 
-enum ice_sbq_msg_dev {
-	eth56g_phy_0	= 0x02,
-	rmn_0		= 0x02,
-	rmn_1		= 0x03,
-	rmn_2		= 0x04,
-	cgu		= 0x06,
-	eth56g_phy_1	= 0x0D,
+enum ice_sbq_dev_id {
+	ice_sbq_dev_phy_0	= 0x02,
+	ice_sbq_dev_cgu		= 0x06,
+	ice_sbq_dev_phy_0_peer	= 0x0D,
 };
 
 enum ice_sbq_msg_opcode {
-- 
2.39.3


