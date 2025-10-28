Return-Path: <netdev+bounces-233638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C1C16C21
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09309355D1A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709C72C11FA;
	Tue, 28 Oct 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1FgNfQK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14FF2BDC03
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683126; cv=none; b=D/mrA/ZMVwuooyET2sr6XGIUox/T4w+HSGg9RPXXMTBVRTT0Uq4I0UgrUDta3U/HuQlcoXN/BM/xwcy7wP7p5lIFtH+K/afne9RwNQ4KFztP7mp//8qQQb9DxfZzZDMQDqBl0AWypigUFDI8YM2Uh6CEc+XakmBEq8vuWRh4tQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683126; c=relaxed/simple;
	bh=q4PUWCHB06QI4YWqrWfJLPPefTuhFg6T7UiExLwCao4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvsHAjsqiW/faWL01+UzWc6bDbneUoWzpg1zX2dbuZGS2hWJLZZwoHT/ZYYQOXgo3Vf1w/dnQcN/AIjJHMjuEcscvAXgkbWtU7uIDPyLHbX/VBRYEAdv1yWDfT+x+Sazwhtxifz7JlOWKehYpgf7xFrnDupCqVpz7C7Mqz90rQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1FgNfQK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683125; x=1793219125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q4PUWCHB06QI4YWqrWfJLPPefTuhFg6T7UiExLwCao4=;
  b=U1FgNfQKjpX6GuT91hwfleA2keY/NpjdQJJGQUmAwFow+fqOFIquCboc
   A8VMfFnaNZxyDGbBStvGuH51zK/0WgvcHn19yOVs+COnojhKzJeVo+nq/
   hlf5yV676t6IEvZsBPz3+NulsCLzgVnuBNzJHL9yfPbt43AxN74JL+zJ8
   B+e1kKRgvHQ7BC6XZ2tz04Vf27Hs48q9BxgskVhndZu5mHSpbyG8pxGBK
   2/8saB6tg33uqbKZtyQDodNhzbfo8erhMsg+pryTbPguzhnMP+IZwSfYl
   pcw12Xp0CypQf5/382qJoR2mM9b8b7Op7fwZ5zag4sFucSN/QH0liR/Kq
   A==;
X-CSE-ConnectionGUID: Zv4ZPk3pTGGN1s4yFYKQlw==
X-CSE-MsgGUID: +l7ZjJkfQjuHHPodz5sALg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825147"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825147"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:23 -0700
X-CSE-ConnectionGUID: dDHzOE16RRCIqqlpoHAnmQ==
X-CSE-MsgGUID: x9eN8pWjTwK450Vh2ClTBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790153"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/8] ice: fix destination CGU for dual complex E825
Date: Tue, 28 Oct 2025 13:25:07 -0700
Message-ID: <20251028202515.675129-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

On dual complex E825, only complex 0 has functional CGU (Clock
Generation Unit), powering all the PHYs.
SBQ (Side Band Queue) destination device 'cgu' in current implementation
points to CGU on current complex and, in order to access primary CGU
from the secondary complex, the driver should use 'cgu_peer' as
a destination device in read/write CGU registers operations.

Define new 'cgu_peer' (15) as RDA (Remote Device Access) client over
SB-IOSF interface and use it as device target when accessing CGU from
secondary complex.

This problem has been identified when working on recovery clock
enablement [1]. In existing implementation for E825 devices, only PF0,
which is clock owner, is involved in CGU configuration, thus the
problem was not exposed to the user.

[1] https://lore.kernel.org/intel-wired-lan/20250905150947.871566-1-grzegorz.nitka@intel.com/

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 26 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 28d74bf56ffc..2532b6f82e97 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6505,6 +6505,28 @@ u32 ice_get_link_speed(u16 index)
 	return ice_aq_to_link_speed[index];
 }
 
+/**
+ * ice_get_dest_cgu - get destination CGU dev for given HW
+ * @hw: pointer to the HW struct
+ *
+ * Get CGU client id for CGU register read/write operations.
+ *
+ * Return: CGU device id to use in SBQ transactions.
+ */
+static enum ice_sbq_dev_id ice_get_dest_cgu(struct ice_hw *hw)
+{
+	/* On dual complex E825 only complex 0 has functional CGU powering all
+	 * the PHYs.
+	 * SBQ destination device cgu points to CGU on a current complex and to
+	 * access primary CGU from the secondary complex, the driver should use
+	 * cgu_peer as a destination device.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC_3K_E825 && ice_is_dual(hw) &&
+	    !ice_is_primary(hw))
+		return ice_sbq_dev_cgu_peer;
+	return ice_sbq_dev_cgu;
+}
+
 /**
  * ice_read_cgu_reg - Read a CGU register
  * @hw: Pointer to the HW struct
@@ -6519,8 +6541,8 @@ u32 ice_get_link_speed(u16 index)
 int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
+		.dest_dev = ice_get_dest_cgu(hw),
 		.opcode = ice_sbq_msg_rd,
-		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr
 	};
 	int err;
@@ -6551,8 +6573,8 @@ int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
 int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
+		.dest_dev = ice_get_dest_cgu(hw),
 		.opcode = ice_sbq_msg_wr,
-		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr,
 		.data = val
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 183dd5457d6a..21bb861febbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -50,6 +50,7 @@ enum ice_sbq_dev_id {
 	ice_sbq_dev_phy_0	= 0x02,
 	ice_sbq_dev_cgu		= 0x06,
 	ice_sbq_dev_phy_0_peer	= 0x0D,
+	ice_sbq_dev_cgu_peer	= 0x0F,
 };
 
 enum ice_sbq_msg_opcode {
-- 
2.47.1


