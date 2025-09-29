Return-Path: <netdev+bounces-227189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5010BA9CEB
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 17:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860A03BA209
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7A30ACF1;
	Mon, 29 Sep 2025 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MweA0EAR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4850C3090C9
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159862; cv=none; b=rCU17fEEglA5fI2lz1/OU+kk73WLD69cKKIYPrx1uRDDI2uSPIzTbnEacg6e9RCEkdWMva/HBSrnZjNQfVe6Z44ChyRsxUj5r5jpmWZwaDE/Od8/jvrKzcv9Q32TsrC0hYeoCWBCRi00pDkGqNDcuo8DdX8z0TtjxqpHk/zcGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159862; c=relaxed/simple;
	bh=ABwM0eGVQ7WQM24CLNELoH9xGXewKt4+TlK7a0k4I7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4VtJ4+6oW9o8m456qmVzUtU8Hr6b5TKNkPE9maKkbMo+a+e6FznoNU2tOR+Bw9Ge5D7oFOmcMyXxbSngE45/1EmtS3BWLxKkvWvb0QK5PJExwW2K7A/Tp/pj6iBtv+yVfSzWSqpqwRz0jE1kOxe5AVmlg+k4bHxvpaC/rwP8Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MweA0EAR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759159862; x=1790695862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABwM0eGVQ7WQM24CLNELoH9xGXewKt4+TlK7a0k4I7E=;
  b=MweA0EARt4OiIcx4OIVbNquFT7qqB1xaDVyZJls+0sxUhFMM2F6sJZmu
   hQMgRlqBz8fsG5WNYiPs5s3HNrjM9kChZmlOiLzaiuu0SjDn00MfQlW0K
   7jUYAbhdARTfWQhIN5CtWwy+zrEnkuNE2lNlZvX+idKJIg3wltFqvmr6z
   6YPsfUxrluxvnFOLEnxXnKrrIleWYEqgd3TIh6vd2+bc6cs/i4OaGkUkt
   q2AkuoCK8z4p/VUqF3BL6UtlJDpgPoMy4BnqmZsJH8Oj4FvPfeQ3Duf0N
   N03gjW5OjYbJhRWVZp6uOh+39Tc+UXGEZrRchZ1djx2Le92USrQQR+bLg
   w==;
X-CSE-ConnectionGUID: KYlh5LSBRE6auyQ1MOL2lQ==
X-CSE-MsgGUID: +OOJrRa5S/aQxiaw5OI2dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="71650111"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="71650111"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 08:30:59 -0700
X-CSE-ConnectionGUID: bYpCuTx4SXmxry8ZwD7tLA==
X-CSE-MsgGUID: ohGdYomQRiGnqPnwTNjFOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178072611"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 29 Sep 2025 08:30:57 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v2 iwl-net] ice: fix destination CGU for dual complex E825
Date: Mon, 29 Sep 2025 17:29:05 +0200
Message-Id: <20250929152905.2947520-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

[1] https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250905150947.871566-1-grzegorz.nitka@intel.com/

Fixes: e2193f9f9ec9 ("ice: enable timesync operation on 2xNAC E825 devices")
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Arkadiusz Kubalewski <Arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2:
- rebased
- fixed code style coomments (skipped redundant 'else', improved
  'Return'
  description in function doc-string)
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 26 ++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index eb6abf452b05..a2a8e4cfa01f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6382,6 +6382,28 @@ u32 ice_get_link_speed(u16 index)
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
@@ -6396,8 +6418,8 @@ u32 ice_get_link_speed(u16 index)
 int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
+		.dest_dev = ice_get_dest_cgu(hw),
 		.opcode = ice_sbq_msg_rd,
-		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr
 	};
 	int err;
@@ -6428,8 +6450,8 @@ int ice_read_cgu_reg(struct ice_hw *hw, u32 addr, u32 *val)
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

base-commit: 32228c42b96884ecb91bd420d8a8fddaece24df5
-- 
2.39.3


