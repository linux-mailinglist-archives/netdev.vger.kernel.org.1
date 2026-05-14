Return-Path: <netdev+bounces-288101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDrCL5VVBmqnigIAu9opvQ
	(envelope-from <netdev+bounces-288101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:07:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C948547AF0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D5DF300F195
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30309392803;
	Thu, 14 May 2026 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iu+wGGUJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1638E8BF;
	Thu, 14 May 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799889; cv=none; b=RKap4rDOfVrdwK1HjIvvLfh57MEL1ArfImIe4hzEzGY6FKQQTNsr/z9KKpVLAKHOUoEMUw0pC5T3gkO6CpK0ZMDNFGiRi9Q6kzhuSnj1f409KJdur6sDJl7ojDIUyLZ6fngEZ5m1xJYyfZlUmIqanQr4vRX/GMpusugdNLvd/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799889; c=relaxed/simple;
	bh=7Kovl15ZQfUInwN9cnuRCQV4xe92Yy65NLRpXe+HLDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+o9BzoWidhIWqtVejoZBKyxX+4q/+CW5GuVP2ckkGuqQN2CjGDAxbwiDu3PMd5r3kFtITvEXnBv+12y4Q9bJYrhG8cW1WqkjSGy26EQOBx1LJYlTTPRhBzZT8hOGZ0L+EXNFQfnbiY889Y53+OaSmc4qSmKqqj9oWYl85RUKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iu+wGGUJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778799887; x=1810335887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Kovl15ZQfUInwN9cnuRCQV4xe92Yy65NLRpXe+HLDI=;
  b=iu+wGGUJs1HGObzL7Bn3dEHmZU14FY0+AOfU9x/VZur1tCOoFzdrIXmX
   tIcLlod9I1W45tgSj3kH/fO14ZsP38Jr/tkOEpWPRBHw2dDiULVZz6er4
   ZMD+CTYl8GPvPCqI1sJYTn17+i5s36fXD+73xQzZCNJvXsalAbfGH5yyp
   KF8W1ZTk6ERzIb08ucMA82ARcMrh7JBNQwWDqh0h8OHURWRQ1JnwfBT0h
   O/Xlk1pwHVsCifBSEpRHZjsptvSVENxtqoO1+njt155g5rwAgtb4ICZ4I
   tmjkpfW32vR+6BQqfrZvt3IOoYmm41a0bVCresd7wBehy0O/51l9rbXS5
   g==;
X-CSE-ConnectionGUID: hrMFYqylT2CIUAK7eN3B0g==
X-CSE-MsgGUID: xJdxtJzBT6iulH72fhQR+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79924604"
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="79924604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 16:04:47 -0700
X-CSE-ConnectionGUID: rc7h6t3NTYa+o2K7Pdaq8w==
X-CSE-MsgGUID: pePVHpD+TJOMAry2B4M+DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,235,1770624000"; 
   d="scan'208";a="262275904"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa001.fm.intel.com with ESMTP; 14 May 2026 16:04:42 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v9 net-next 6/8] ice: implement CPI support for E825C
Date: Fri, 15 May 2026 00:59:44 +0200
Message-Id: <20260514225946.2885623-7-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
References: <20260514225946.2885623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C948547AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288101-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,phy.data:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Add full CPI (Converged PHY Interface) command handling required for
E825C devices. The CPI interface allows the driver to interact with
PHY-side control logic through the LM/PHY command registers, including
enabling/disabling/selection of PHY reference clock.

This patch introduces:
 - a new CPI subsystem (ice_cpi.c / ice_cpi.h) implementing the CPI
   request/acknowledge state machine, including REQ/ACK protocol,
   command execution, and response handling
 - helper functions for reading/writing PHY registers over Sideband
   Queue
 - CPI command execution API (ice_cpi_exec) and a helper for enabling or
   disabling Tx reference clocks (CPI 0xF1 opcode 'Config PHY clocking')
 - assurance of CPI transaction serialization into the CPI core.
   CPI REQ/ACK is a multi-step handshake    and must be executed
   atomically per PHY. Centralize the lock in ice_cpi_exec() and
   use adapter-scoped per-PHY mutexes, which match the hardware sharing
   model across PFs.
 - addition of the non-posted write opcode (wr_np) to SBQ
 - Makefile integration to build CPI support together with the PTP stack

This provides the infrastructure necessary to support PHY-side
configuration flows on E825C and is required for advanced link control
and Tx reference clock management.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile      |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |   4 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |   7 +
 drivers/net/ethernet/intel/ice/ice_cpi.c     | 362 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_cpi.h     |  58 +++
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h |   5 +-
 drivers/net/ethernet/intel/ice/ice_type.h    |   2 +
 7 files changed, 437 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_cpi.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 5b2c666496e7..38db476ab2ec 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -54,7 +54,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
-ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o ice_dpll.o ice_tspll.o
+ice-$(CONFIG_PTP_1588_CLOCK) += ice_ptp.o ice_ptp_hw.o ice_dpll.o ice_tspll.o ice_cpi.o
 ice-$(CONFIG_DCB) += ice_dcb.o ice_dcb_nl.o ice_dcb_lib.o
 ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
 ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index cbb57060bd56..2dc3629d6d0f 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -62,6 +62,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 	adapter->index = ice_adapter_index(pdev);
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	spin_lock_init(&adapter->txq_ctx_lock);
+	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
+		mutex_init(&adapter->cpi_phy_lock[i]);
 	refcount_set(&adapter->refcount, 1);
 
 	mutex_init(&adapter->ports.lock);
@@ -73,6 +75,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
 	WARN_ON(!list_empty(&adapter->ports.ports));
+	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
+		mutex_destroy(&adapter->cpi_phy_lock[i]);
 	mutex_destroy(&adapter->ports.lock);
 
 	kfree(adapter);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index e95266c7f20b..4f695f32da3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -5,9 +5,12 @@
 #define _ICE_ADAPTER_H_
 
 #include <linux/types.h>
+#include <linux/mutex.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
+#include "ice_type.h"
+
 struct pci_dev;
 struct ice_pf;
 
@@ -31,6 +34,8 @@ struct ice_port_list {
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
+ * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
+ *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
  * @index: 64-bit index cached for collision detection on 32bit systems
@@ -41,6 +46,8 @@ struct ice_adapter {
 	spinlock_t ptp_gltsyn_time_lock;
 	/* For access to GLCOMM_QTX_CNTX_CTL register */
 	spinlock_t txq_ctx_lock;
+	/* Serialize CPI REQ/ACK transactions per PHY (E825C only) */
+	struct mutex cpi_phy_lock[ICE_E825_MAX_PHYS];
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_cpi.c b/drivers/net/ethernet/intel/ice/ice_cpi.c
new file mode 100644
index 000000000000..dfa6c74e2b87
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_cpi.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2026 Intel Corporation */
+
+#include "ice_type.h"
+#include "ice_common.h"
+#include "ice_ptp_hw.h"
+#include "ice.h"
+#include "ice_cpi.h"
+
+/**
+ * ice_cpi_get_dest_dev - get destination PHY for given phy index
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ *
+ * Return: sideband queue destination PHY device.
+ */
+static enum ice_sbq_dev_id ice_cpi_get_dest_dev(struct ice_hw *hw, u8 phy)
+{
+	u8 curr_phy = hw->lane_num / hw->ptp.ports_per_phy;
+
+	/* In the driver, lanes 4..7 are in fact 0..3 on a second PHY.
+	 * On a single complex E825C, PHY 0 is always destination device phy_0
+	 * and PHY 1 is phy_0_peer.
+	 * On dual complex E825C, device phy_0 points to PHY on a current
+	 * complex and phy_0_peer to PHY on a different complex.
+	 */
+	if ((!ice_is_dual(hw) && phy) ||
+	    (ice_is_dual(hw) && phy != curr_phy))
+		return ice_sbq_dev_phy_0_peer;
+	else
+		return ice_sbq_dev_phy_0;
+}
+
+/**
+ * ice_cpi_write_phy - Write a CPI port register
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @addr: PHY register address
+ * @val: Value to write
+ *
+ * Return:
+ * * 0 on success
+ * * other error codes when failed to write to PHY
+ */
+static int ice_cpi_write_phy(struct ice_hw *hw, u8 phy, u32 addr, u32 val)
+{
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_cpi_get_dest_dev(hw, phy),
+		.opcode = ice_sbq_msg_wr_np,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr),
+		.data = val
+	};
+	int err;
+
+	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
+	if (err)
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to write CPI msg to phy %d, err: %d\n",
+			  phy, err);
+
+	return err;
+}
+
+/**
+ * ice_cpi_read_phy - Read a CPI port register
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @addr: PHY register address
+ * @val: storage for register value
+ *
+ * Return:
+ * * 0 on success
+ * * other error codes when failed to read from PHY
+ */
+static int ice_cpi_read_phy(struct ice_hw *hw, u8 phy, u32 addr, u32 *val)
+{
+	struct ice_sbq_msg_input msg = {
+		.dest_dev = ice_cpi_get_dest_dev(hw, phy),
+		.opcode = ice_sbq_msg_rd,
+		.msg_addr_low = lower_16_bits(addr),
+		.msg_addr_high = upper_16_bits(addr)
+	};
+	int err;
+
+	err = ice_sbq_rw_reg(hw, &msg, LIBIE_AQ_FLAG_RD);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP,
+			  "Failed to read CPI msg from phy %d, err: %d\n",
+			  phy, err);
+		return err;
+	}
+
+	*val = msg.data;
+
+	return 0;
+}
+
+/**
+ * ice_cpi_wait_req0_ack0 - waits for CPI interface to be available
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ *
+ * This function checks if CPI interface is ready to use by CPI client.
+ * It's done by assuring LM.CMD.REQ and PHY.CMD.ACK bit in CPI
+ * interface registers to be 0.
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_cpi_wait_req0_ack0(struct ice_hw *hw, int phy)
+{
+	u32 phy_val;
+	u32 lm_val;
+
+	for (int i = 0; i < CPI_RETRIES_COUNT; i++) {
+		int err;
+
+		/* check if another CPI Client is also accessing CPI */
+		err = ice_cpi_read_phy(hw, phy, CPI0_LM1_CMD_DATA, &lm_val);
+		if (err)
+			return err;
+		if (FIELD_GET(CPI_LM_CMD_REQ_M, lm_val))
+			goto retry;
+
+		/* check if PHY.ACK is deasserted */
+		err = ice_cpi_read_phy(hw, phy, CPI0_PHY1_CMD_DATA, &phy_val);
+		if (err)
+			return err;
+		if (!FIELD_GET(CPI_PHY_CMD_ACK_M, phy_val))
+			/* req0 and ack0 at this point - ready to go */
+			return 0;
+
+retry:
+		msleep(CPI_RETRIES_CADENCE_MS);
+	}
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * ice_cpi_wait_ack - Waits for the PHY.ACK bit to be asserted/deasserted
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @asserted: desired state of PHY.ACK bit
+ * @data: pointer to the user data where PHY.data is stored
+ *
+ * This function checks if PHY.ACK bit is asserted or deasserted, depending
+ * on the phase of CPI handshake. If 'asserted' state is required, PHY command
+ * data is stored in the 'data' storage.
+ *
+ * Return: 0 on success, negative on error
+ */
+static int ice_cpi_wait_ack(struct ice_hw *hw, u8 phy, bool asserted,
+			    u32 *data)
+{
+	u32 phy_val;
+
+	for (int i = 0; i < CPI_RETRIES_COUNT; i++) {
+		int err;
+
+		err = ice_cpi_read_phy(hw, phy, CPI0_PHY1_CMD_DATA, &phy_val);
+		if (err)
+			return err;
+		if (asserted && FIELD_GET(CPI_PHY_CMD_ERROR_M, phy_val))
+			return -EFAULT;
+		if (asserted && FIELD_GET(CPI_PHY_CMD_ACK_M, phy_val)) {
+			if (data)
+				*data = phy_val;
+			return 0;
+		}
+		if (!asserted && !FIELD_GET(CPI_PHY_CMD_ACK_M, phy_val))
+			return 0;
+
+		msleep(CPI_RETRIES_CADENCE_MS);
+	}
+
+	return -ETIMEDOUT;
+}
+
+#define ice_cpi_wait_ack0(hw, port) \
+	ice_cpi_wait_ack(hw, port, false, NULL)
+
+#define ice_cpi_wait_ack1(hw, port, data) \
+	ice_cpi_wait_ack(hw, port, true, data)
+
+/**
+ * ice_cpi_req0 - deasserts LM.REQ bit
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @data: the command data
+ *
+ * Return: 0 on success, negative on CPI write error
+ */
+static int ice_cpi_req0(struct ice_hw *hw, u8 phy, u32 data)
+{
+	data &= ~CPI_LM_CMD_REQ_M;
+
+	return ice_cpi_write_phy(hw, phy, CPI0_LM1_CMD_DATA, data);
+}
+
+/**
+ * ice_cpi_exec_cmd - writes command data to CPI interface
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @data: the command data
+ *
+ * Return: 0 on success, otherwise negative on error
+ */
+static int ice_cpi_exec_cmd(struct ice_hw *hw, int phy, u32 data)
+{
+	return ice_cpi_write_phy(hw, phy, CPI0_LM1_CMD_DATA, data);
+}
+
+/**
+ * ice_cpi_phy_lock - get per-PHY lock for CPI transaction serialization
+ * @hw: pointer to the HW struct
+ * @phy: PHY index
+ *
+ * Return: pointer to PHY mutex, or %NULL when context is unavailable.
+ */
+static struct mutex *ice_cpi_phy_lock(struct ice_hw *hw, u8 phy)
+{
+	struct ice_pf *pf = hw->back;
+
+	if (!pf || !pf->adapter || phy >= ICE_E825_MAX_PHYS)
+		return NULL;
+
+	return &pf->adapter->cpi_phy_lock[phy];
+}
+
+/**
+ * ice_cpi_exec - executes CPI command
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port the CPI action is taken on
+ * @cmd: pointer to the command struct to execute
+ * @resp: pointer to user allocated CPI response struct
+ *
+ * This function executes CPI request with respect to CPI handshake
+ * mechanism.
+ *
+ * Return: 0 on success, otherwise negative on error
+ */
+int ice_cpi_exec(struct ice_hw *hw, u8 phy,
+		 const struct ice_cpi_cmd *cmd,
+		 struct ice_cpi_resp *resp)
+{
+	struct mutex *cpi_lock; /* serializes CPI transactions per PHY */
+	u32 phy_cmd, lm_cmd = 0;
+	int err, err1 = 0;
+
+	if (!cmd || !resp)
+		return -EINVAL;
+
+	cpi_lock = ice_cpi_phy_lock(hw, phy);
+	if (!cpi_lock)
+		return -EINVAL;
+
+	mutex_lock(cpi_lock);
+
+	lm_cmd =
+		FIELD_PREP(CPI_LM_CMD_REQ_M, CPI_LM_CMD_REQ) |
+		FIELD_PREP(CPI_LM_CMD_GET_SET_M, cmd->set) |
+		FIELD_PREP(CPI_LM_CMD_OPCODE_M, cmd->opcode) |
+		FIELD_PREP(CPI_LM_CMD_PORTLANE_M, cmd->port) |
+		FIELD_PREP(CPI_LM_CMD_DATA_M, cmd->data);
+
+	/* 1. Try to acquire the bus, PHY ACK should be low before we begin */
+	err = ice_cpi_wait_req0_ack0(hw, phy);
+	if (err)
+		goto cpi_exec_exit;
+
+	/* 2. We start the CPI request */
+	err = ice_cpi_exec_cmd(hw, phy, lm_cmd);
+	if (err)
+		goto cpi_deassert;
+
+	/*
+	 * 3. Wait for CPI confirmation, PHY ACK should be asserted and opcode
+	 *    echoed in the response
+	 */
+	err = ice_cpi_wait_ack1(hw, phy, &phy_cmd);
+	if (err)
+		goto cpi_deassert;
+
+	if (FIELD_GET(CPI_LM_CMD_OPCODE_M, lm_cmd) !=
+	    FIELD_GET(CPI_PHY_CMD_OPCODE_M, phy_cmd)) {
+		err = -EFAULT;
+		goto cpi_deassert;
+	}
+
+	resp->opcode = FIELD_GET(CPI_PHY_CMD_OPCODE_M, phy_cmd);
+	resp->data = FIELD_GET(CPI_PHY_CMD_DATA_M, phy_cmd);
+	resp->port = FIELD_GET(CPI_PHY_CMD_PORTLANE_M, phy_cmd);
+
+cpi_deassert:
+	/* 4. We deassert REQ */
+	err1 = ice_cpi_req0(hw, phy, lm_cmd);
+	if (err1)
+		goto cpi_exec_exit;
+
+	/* 5. PHY ACK should be deasserted in response */
+	err1 = ice_cpi_wait_ack0(hw, phy);
+
+cpi_exec_exit:
+	if (!err)
+		err = err1;
+
+	mutex_unlock(cpi_lock);
+
+	return err;
+}
+
+/**
+ * ice_cpi_set_cmd - execute CPI SET command
+ * @hw: pointer to the HW struct
+ * @opcode: CPI command opcode
+ * @phy: phy index CPI command is applied for
+ * @port_lane: ephy index CPI command is applied for
+ * @data: CPI opcode context specific data
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int ice_cpi_set_cmd(struct ice_hw *hw, u16 opcode, u8 phy, u8 port_lane,
+			   u16 data)
+{
+	struct ice_cpi_resp cpi_resp = {0};
+	struct ice_cpi_cmd cpi_cmd = {
+		.opcode = opcode,
+		.set = true,
+		.port = port_lane,
+		.data = data,
+	};
+
+	return ice_cpi_exec(hw, phy, &cpi_cmd, &cpi_resp);
+}
+
+/**
+ * ice_cpi_ena_dis_clk_ref - enables/disables Tx reference clock on port
+ * @hw: pointer to the HW struct
+ * @phy: phy index of port for which Tx reference clock is enabled/disabled
+ * @clk: Tx reference clock to enable or disable
+ * @enable: bool value to enable or disable Tx reference clock
+ *
+ * This function executes CPI request to enable or disable specific
+ * Tx reference clock on given PHY.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int ice_cpi_ena_dis_clk_ref(struct ice_hw *hw, u8 phy,
+			    enum ice_e825c_ref_clk clk, bool enable)
+{
+	u16 val;
+
+	val = FIELD_PREP(CPI_OPCODE_PHY_CLK_PHY_SEL_M, phy) |
+	      FIELD_PREP(CPI_OPCODE_PHY_CLK_REF_CTRL_M,
+			 enable ? CPI_OPCODE_PHY_CLK_ENABLE :
+			 CPI_OPCODE_PHY_CLK_DISABLE) |
+	      FIELD_PREP(CPI_OPCODE_PHY_CLK_REF_SEL_M, clk);
+
+	return ice_cpi_set_cmd(hw, CPI_OPCODE_PHY_CLK, phy, 0, val);
+}
+
diff --git a/drivers/net/ethernet/intel/ice/ice_cpi.h b/drivers/net/ethernet/intel/ice/ice_cpi.h
new file mode 100644
index 000000000000..24e7e1143516
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_cpi.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2026 Intel Corporation */
+
+#ifndef _ICE_CPI_H_
+#define _ICE_CPI_H_
+
+#include "ice_type.h"
+#include "ice_ptp_hw.h"
+
+#define CPI0_PHY1_CMD_DATA	0x7FD028
+#define CPI0_LM1_CMD_DATA	0x7FD024
+#define CPI_RETRIES_COUNT	10
+#define CPI_RETRIES_CADENCE_MS	100
+
+/* CPI PHY CMD DATA register (CPI0_PHY1_CMD_DATA) */
+#define CPI_PHY_CMD_DATA_M	GENMASK(15, 0)
+#define CPI_PHY_CMD_OPCODE_M	GENMASK(23, 16)
+#define CPI_PHY_CMD_PORTLANE_M	GENMASK(26, 24)
+#define CPI_PHY_CMD_RSVD_M	GENMASK(29, 27)
+#define CPI_PHY_CMD_ERROR_M	BIT(30)
+#define CPI_PHY_CMD_ACK_M	BIT(31)
+
+/* CPI LM CMD DATA register (CPI0_LM1_CMD_DATA) */
+#define CPI_LM_CMD_DATA_M	GENMASK(15, 0)
+#define CPI_LM_CMD_OPCODE_M	GENMASK(23, 16)
+#define CPI_LM_CMD_PORTLANE_M	GENMASK(26, 24)
+#define CPI_LM_CMD_RSVD_M	GENMASK(28, 27)
+#define CPI_LM_CMD_GET_SET_M	BIT(29)
+#define CPI_LM_CMD_REQ_M        BIT(31)
+
+#define CPI_OPCODE_PHY_CLK			0xF1
+#define CPI_OPCODE_PHY_CLK_PHY_SEL_M		GENMASK(9, 6)
+#define CPI_OPCODE_PHY_CLK_REF_CTRL_M		GENMASK(5, 4)
+#define CPI_OPCODE_PHY_CLK_DISABLE		1
+#define CPI_OPCODE_PHY_CLK_ENABLE		2
+#define CPI_OPCODE_PHY_CLK_REF_SEL_M		GENMASK(3, 0)
+
+#define CPI_LM_CMD_REQ		1
+
+struct ice_cpi_cmd {
+	u8 port;
+	u8 opcode;
+	u16 data;
+	bool set;
+};
+
+struct ice_cpi_resp {
+	u8 port;
+	u8 opcode;
+	u16 data;
+};
+
+int ice_cpi_exec(struct ice_hw *hw, u8 phy,
+		 const struct ice_cpi_cmd *cmd,
+		 struct ice_cpi_resp *resp);
+int ice_cpi_ena_dis_clk_ref(struct ice_hw *hw, u8 port,
+			    enum ice_e825c_ref_clk clk, bool enable);
+#endif /* _ICE_CPI_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 21bb861febbf..226243d32968 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -54,8 +54,9 @@ enum ice_sbq_dev_id {
 };
 
 enum ice_sbq_msg_opcode {
-	ice_sbq_msg_rd	= 0x00,
-	ice_sbq_msg_wr	= 0x01
+	ice_sbq_msg_rd		= 0x00,
+	ice_sbq_msg_wr		= 0x01,
+	ice_sbq_msg_wr_np	= 0x02
 };
 
 #define ICE_SBQ_MSG_FLAGS	0x40
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 1e82f4c40b32..d9a5c1aae7c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -893,6 +893,8 @@ struct ice_ptp_hw {
 	u8 ports_per_phy;
 };
 
+#define ICE_E825_MAX_PHYS	2
+
 /* Port hardware description */
 struct ice_hw {
 	u8 __iomem *hw_addr;
-- 
2.39.3


