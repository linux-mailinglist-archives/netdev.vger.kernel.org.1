Return-Path: <netdev+bounces-221406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCDB50723
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBB1543A1C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95C35E4E8;
	Tue,  9 Sep 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kghs9GRh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9743570DD
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449966; cv=none; b=r+qjatTPw0l5jcDUCT3PGwZRXpI4oeVgLQtR3PR/1KLbo8Ot5O0ct0vSzMY3cmsIXsTW71h97MvjDzyG3zTz3Cd66/SAHDCTOVxGwQ8BUFPxPllL7LT28gq5c/dHuxB28e/WJysaw4eovdbqfXhA4w6ZD8YOKSocPLm+v1CuXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449966; c=relaxed/simple;
	bh=KC/PG6sNqGXoDLp/VWvOaaiur+hAsPtzX8TQQ3P2Qns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPZaQyOszjjr6h8geBpqHYvzB6k0u8OBuzaKN+uZ66nrhc3dmBq9mSX69RmVk9ZhqKNOge8I0wmOp5N+7PxwikwuM0yklgg53s7mzAPse6r09h95+XMiENb/X3pKxXtT5M1IlXPpFnOCPYbRV1F0z6yKPoTsoMbt5v/I4YZNa+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kghs9GRh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757449965; x=1788985965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KC/PG6sNqGXoDLp/VWvOaaiur+hAsPtzX8TQQ3P2Qns=;
  b=kghs9GRht7bCP0MPFVYpGbYl9K21iIBQJlvnOyuaeztGIAluD/crT825
   9cvDqacwH5H0s6YB1Q6sx02DLbw9UTb4PnUZ4gv1zCSVl3dGa6GtOYg0h
   wvQSRuM9cAbhjxznEMQzzwDcDs50tDzYLQi8XgySJnawjSjFG7LznbbPn
   rt+nq7lWBVHP38O/LQmxx6Y7NLirPBrmvs0fcD8IzY0bk0tDUtIDtTgxB
   MXhu5N+bOqKQEOSV4GXclrsurjZ6G/eePT7WB6j0J1dGGbPuc7ysaKWjJ
   A7KaLPDQcOUpnsA77MUAb1JvcE6YJSkJxXTwe5KzFj8lQtA0j7j8nr81Z
   Q==;
X-CSE-ConnectionGUID: Z96dsJT2TMKTdEof+oh7pQ==
X-CSE-MsgGUID: 4KjbcE0hS0Kb21IePq+5mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="59606788"
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="59606788"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 13:32:42 -0700
X-CSE-ConnectionGUID: cqAgr93+SAGUi6ILHF1oew==
X-CSE-MsgGUID: Q64B+affSZC/7KVvDg6x3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,252,1751266800"; 
   d="scan'208";a="173287038"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Sep 2025 13:32:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/4] i40e: fix Jumbo Frame support after iPXE boot
Date: Tue,  9 Sep 2025 13:32:34 -0700
Message-ID: <20250909203236.3603960-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
References: <20250909203236.3603960-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The i40e hardware has multiple hardware settings which define the Maximum
Frame Size (MFS) of the physical port. The firmware has an AdminQ command
(0x0603) to configure the MFS, but the i40e Linux driver never issues this
command.

In most cases this is no problem, as the NVM default value has the device
configured for its maximum value of 9728. Unfortunately, recent versions of
the iPXE intelxl driver now issue the 0x0603 Set Mac Config command,
modifying the MFS and reducing it from its default value of 9728.

This occurred as part of iPXE commit 6871a7de705b ("[intelxl] Use admin
queue to set port MAC address and maximum frame size"), a prerequisite
change for supporting the E800 series hardware in iPXE. Both the E700 and
E800 firmware support the AdminQ command, and the iPXE code shares much of
the logic between the two device drivers.

The ice E800 Linux driver already issues the 0x0603 Set Mac Config command
early during probe, and is thus unaffected by the iPXE change.

Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
i40e driver does check the I40E_PRTGL_SAH register, but it only logs a
warning message if its value is below the 9728 default. This register also
only covers received packets and not transmitted packets. A warning can
inform system administrators, but does not correct the issue. No
interactions from userspace cause the driver to write to PRTGL_SAH or issue
the 0x0603 AdminQ command. Only a GLOBR reset will restore the value to its
default value. There is no obvious method to trigger a GLOBR reset from
user space.

To fix this, introduce the i40e_aq_set_mac_config() function, similar to
the one from the ice driver. Call this during early probe to ensure that
the device configuration matches driver expectation. Unlike E800, the E700
firmware also has a bit to control whether the MAC should append CRC data.
It is on by default, but setting a 0 to this bit would disable CRC. The
i40e implementation must set this bit to ensure CRC will be appended by the
MAC.

In addition to the AQ command, instead of just checking the I40E_PRTGL_SAH
register, update its value to the 9728 default and write it back. This
ensures that the hardware is in the expected state, regardless of whether
the iPXE (or any other early boot driver) has modified this state.

This is a better user experience, as we now fix the issues with larger MTU
instead of merely warning. It also aligns with the way the ice E800 series
driver works.

A final note: The Fixes tag provided here is not strictly accurate. The
issue occurs as a result of an external entity (the iPXE intelxl driver),
and this is not a regression specifically caused by the mentioned change.
However, I believe the original change to just warn about PRTGL_SAH being
too low was an insufficient fix.

Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
Link: https://github.com/ipxe/ipxe/commit/6871a7de705b6f6a4046f0d19da9bcd689c3bc8e
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_common.c | 34 +++++++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 16 +++++----
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  2 ++
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 76d872b91a38..cc02a85ad42b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1561,6 +1561,7 @@ I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
 struct i40e_aq_set_mac_config {
 	__le16	max_frame_size;
 	u8	params;
+#define I40E_AQ_SET_MAC_CONFIG_CRC_EN	BIT(2)
 	u8	tx_timer_priority; /* bitmap */
 	__le16	tx_timer_value;
 	__le16	fc_refresh_threshold;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 270e7e8cf9cf..59f5c1e810eb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1189,6 +1189,40 @@ int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
 	return status;
 }
 
+/**
+ * i40e_aq_set_mac_config - Configure MAC settings
+ * @hw: pointer to the hw struct
+ * @max_frame_size: Maximum Frame Size to be supported by the port
+ * @cmd_details: pointer to command details structure or NULL
+ *
+ * Set MAC configuration (0x0603). Note that max_frame_size must be greater
+ * than zero.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details)
+{
+	struct i40e_aq_set_mac_config *cmd;
+	struct libie_aq_desc desc;
+
+	cmd = libie_aq_raw(&desc);
+
+	if (max_frame_size == 0)
+		return -EINVAL;
+
+	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_set_mac_config);
+
+	cmd->max_frame_size = cpu_to_le16(max_frame_size);
+	cmd->params = I40E_AQ_SET_MAC_CONFIG_CRC_EN;
+
+#define I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD	0x7FFF
+	cmd->fc_refresh_threshold =
+		cpu_to_le16(I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD);
+
+	return i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
+}
+
 /**
  * i40e_aq_clear_pxe_mode
  * @hw: pointer to the hw struct
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dd21d93d39dd..b14019d44b58 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16045,13 +16045,17 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %pe last_status =  %s\n",
 			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
 
-	/* make sure the MFS hasn't been set lower than the default */
 #define MAX_FRAME_SIZE_DEFAULT 0x2600
-	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
-			rd32(&pf->hw, I40E_PRTGL_SAH));
-	if (val < MAX_FRAME_SIZE_DEFAULT)
-		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
-			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
+
+	err = i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT, NULL);
+	if (err)
+		dev_warn(&pdev->dev, "set mac config ret = %pe last_status = %s\n",
+			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
+
+	/* Make sure the MFS is set to the expected value */
+	val = rd32(hw, I40E_PRTGL_SAH);
+	FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val, MAX_FRAME_SIZE_DEFAULT);
+	wr32(hw, I40E_PRTGL_SAH, val);
 
 	/* Add a filter to drop all Flow control frames from any VSI from being
 	 * transmitted. By doing so we stop a malicious VF from sending out
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index aef5de53ce3b..26bb7bffe361 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -98,6 +98,8 @@ int i40e_aq_set_mac_loopback(struct i40e_hw *hw,
 			     struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
 			     struct i40e_asq_cmd_details *cmd_details);
+int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
+			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
 			   struct i40e_asq_cmd_details *cmd_details);
 int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
-- 
2.47.1


