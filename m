Return-Path: <netdev+bounces-163927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B476BA2C0D1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1763A597D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B608E1DE3C7;
	Fri,  7 Feb 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSp2JlEK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1C1DE8B7
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925035; cv=none; b=FG5IFh2yiX/vP+bz3WX1mpHRPyYuZWKg2pbxy6x0fTX4Gz+sVZ/QGYFeyc5oHGtfjHazrzMorI9W2wbOjQTZGEbvHDuDcvzfxuS1qh0S8dbQRB4MARW22xGniJ6pbNYhmHcz5SlvUnaG6MIp3t0a8/S4vOnJDDbMEUvV+TY/mHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925035; c=relaxed/simple;
	bh=53GDNBZRmctwR09tbT+BLdGiyYO1AOk+iep/qi2hefE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIE3GyIhrKwT7vmVPqFOxzi/yNaPqB4z4DJY4Se7j+0dEsnFzqKNXzo8p3DruEugYLedxw7J42uO0jneB3vJ4M468R93JaWIs0tuJNMBk85uODhzaKtq8dVhfDn3SOF84DtFQ1kThmi7fJmOpjHFwW6IL56Yob4+p+gYcmU33fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSp2JlEK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738925033; x=1770461033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53GDNBZRmctwR09tbT+BLdGiyYO1AOk+iep/qi2hefE=;
  b=BSp2JlEKVSjzFlHqKK0aoarrcf+CZpqu2DQFmJIQsdKo7PZsU3AE9Ysl
   oqd3X9An8OHw4OweXrIpSTcz3qC90DbTqTgFsdSeZCFnMu2ysMUaw/iW/
   DbFjc/FTbxa3GWfopN42gC1bW3gmLGAAA3HPQnMqq6fk2yGbw0eqGDwoT
   RlCzDUbx+MFFJFTfwv+6c2svUVkjNERDv5CDIzHHyHutX7GHKYxU8bz2T
   JGYHr3RyiI5scEoexjJlJ+VX+Jd1mdBocL2lqAKelpfnuOhTrbFel+/+A
   IjZOu3GvG8DJzCpGN4xjPfnRZ64VXpmMTtto79tqTjDWtDg/WsbVm0400
   Q==;
X-CSE-ConnectionGUID: 82mwdi0/RwCi2hGWhZx7JQ==
X-CSE-MsgGUID: rbwhYJJwTBiTo1wFPWn1vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="62039835"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="62039835"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 02:43:53 -0800
X-CSE-ConnectionGUID: LOspUvgaTYOOaf9Xy/iumA==
X-CSE-MsgGUID: nrJDvDtzSoiiSs2Wa+7sNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116429794"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 02:43:51 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com
Subject: [iwl-next v1 3/4] ixgbe: add Tx hang detection unhandled MDD
Date: Fri,  7 Feb 2025 11:43:42 +0100
Message-ID: <20250207104343.2791001-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>

Add Tx Hang detection due to an unhandled MDD Event.

Previously, a malicious VF could disable the entire port causing
TX to hang on the E610 card.
Those events that caused PF to freeze were not detected
as an MDD event and usually required a Tx Hang watchdog timer
to catch the suspension, and perform a physical function reset.

Implement flows in the affected PF driver in such a way to check
the cause of the hang, detect it as an MDD event and log an
entry of the malicious VF that caused the Hang.

The PF blocks the malicious VF, if it continues to be the source
of several MDD events.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   5 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 212 ++++++++++++++++--
 4 files changed, 210 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index e6a380d4929b..81ccb4c591ba 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -427,6 +427,10 @@ enum ixgbe_ring_f_enum {
 #define IXGBE_BAD_L2A_QUEUE		3
 #define IXGBE_MAX_MACVLANS		63
 
+#define IXGBE_MAX_TX_QUEUES		128
+#define IXGBE_MAX_TX_DESCRIPTORS	40
+#define IXGBE_MAX_TX_VF_HANGS		4
+
 DECLARE_STATIC_KEY_FALSE(ixgbe_xdp_locking_key);
 
 struct ixgbe_ring_feature {
@@ -798,6 +802,7 @@ struct ixgbe_adapter {
 	u32 timer_event_accumulator;
 	u32 vferr_refcount;
 	struct ixgbe_mac_addr *mac_table;
+	u8 tx_hang_count[IXGBE_MAX_TX_QUEUES];
 	struct kobject *info_kobj;
 	u16 lse_mask;
 #ifdef CONFIG_IXGBE_HWMON
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index aa3b498558bc..e07b56625595 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -1044,6 +1044,7 @@ struct ixgbe_nvm_version {
 #define IXGBE_GCR_EXT_VT_MODE_16        0x00000001
 #define IXGBE_GCR_EXT_VT_MODE_32        0x00000002
 #define IXGBE_GCR_EXT_VT_MODE_64        0x00000003
+#define IXGBE_GCR_EXT_VT_MODE_MASK	0x00000003
 #define IXGBE_GCR_EXT_SRIOV             (IXGBE_GCR_EXT_MSIX_EN | \
 					 IXGBE_GCR_EXT_VT_MODE_64)
 
@@ -2935,6 +2936,13 @@ struct ixgbe_adv_tx_context_desc {
 	__le32 mss_l4len_idx;
 };
 
+enum {
+	IXGBE_VLAN_MACIP_LENS_REG	= 0,
+	IXGBE_FCEOF_SAIDX_REG		= 1,
+	IXGBE_TYPE_TUCMD_MLHL		= 2,
+	IXGBE_MSS_L4LEN_IDX		= 3,
+};
+
 /* Adv Transmit Descriptor Config Masks */
 #define IXGBE_ADVTXD_DTALEN_MASK      0x0000FFFF /* Data buf length(bytes) */
 #define IXGBE_ADVTXD_MAC_LINKSEC      0x00040000 /* Insert LinkSec */
@@ -2942,7 +2950,7 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ADVTXD_IPSEC_SA_INDEX_MASK   0x000003FF /* IPSec SA index */
 #define IXGBE_ADVTXD_IPSEC_ESP_LEN_MASK    0x000001FF /* IPSec ESP length */
 #define IXGBE_ADVTXD_DTYP_MASK  0x00F00000 /* DTYP mask */
-#define IXGBE_ADVTXD_DTYP_CTXT  0x00200000 /* Advanced Context Desc */
+#define IXGBE_ADVTXD_DTYP_CTXT	0x2 /* Advanced Context Desc */
 #define IXGBE_ADVTXD_DTYP_DATA  0x00300000 /* Advanced Data Descriptor */
 #define IXGBE_ADVTXD_DCMD_EOP   IXGBE_TXD_CMD_EOP  /* End of Packet */
 #define IXGBE_ADVTXD_DCMD_IFCS  IXGBE_TXD_CMD_IFCS /* Insert FCS */
@@ -2991,6 +2999,8 @@ struct ixgbe_adv_tx_context_desc {
 #define IXGBE_ADVTXD_FCOEF_EOF_MASK  (3u << 10)  /* FC EOF index */
 #define IXGBE_ADVTXD_L4LEN_SHIFT     8  /* Adv ctxt L4LEN shift */
 #define IXGBE_ADVTXD_MSS_SHIFT       16  /* Adv ctxt MSS shift */
+#define IXGBE_ADVTXD_MSS_MASK		GENMASK(31, IXGBE_ADVTXD_MSS_SHIFT)
+#define IXGBE_ADVTXD_HEADER_LEN_MASK	GENMASK(8, 0)
 
 /* Autonegotiation advertised speeds */
 typedef u32 ixgbe_autoneg_advertised;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
index 336d47ffb95a..54d75cf94cc1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c
@@ -1293,7 +1293,8 @@ void ixgbe_tx_ctxtdesc(struct ixgbe_ring *tx_ring, u32 vlan_macip_lens,
 	tx_ring->next_to_use = (i < tx_ring->count) ? i : 0;
 
 	/* set bits to identify this as an advanced context descriptor */
-	type_tucmd |= IXGBE_TXD_CMD_DEXT | IXGBE_ADVTXD_DTYP_CTXT;
+	type_tucmd |= IXGBE_TXD_CMD_DEXT |
+		FIELD_PREP(IXGBE_ADVTXD_DTYP_MASK, IXGBE_ADVTXD_DTYP_CTXT);
 
 	context_desc->vlan_macip_lens	= cpu_to_le32(vlan_macip_lens);
 	context_desc->fceof_saidx	= cpu_to_le32(fceof_saidx);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 3ff48207165c..5c1c067ffb7c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -9,6 +9,7 @@
 #include <linux/string.h>
 #include <linux/in.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
 #include <linux/sctp.h>
@@ -1039,6 +1040,48 @@ static u64 ixgbe_get_tx_pending(struct ixgbe_ring *ring)
 	return ((head <= tail) ? tail : tail + ring->count) - head;
 }
 
+/**
+ * ixgbe_get_vf_idx - provide VF index number based on queue index
+ * @adapter: pointer to the adapter struct
+ * @queue: Tx queue identifier
+ * @vf: output VF index
+ *
+ * Provide VF index number associated to the input queue.
+ *
+ * Returns: 0 if VF provided or error number.
+ */
+static int ixgbe_get_vf_idx(struct ixgbe_adapter *adapter, u16 queue, u16 *vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u8 queue_count;
+	u32 reg;
+
+	if (queue >= adapter->num_tx_queues)
+		return -EINVAL;
+
+	/* Determine number of queues by checking
+	 * number of virtual functions
+	 */
+	reg = IXGBE_READ_REG(hw, IXGBE_GCR_EXT);
+	switch (reg & IXGBE_GCR_EXT_VT_MODE_MASK) {
+	case IXGBE_GCR_EXT_VT_MODE_64:
+		queue_count = IXGBE_64VFS_QUEUES;
+		break;
+	case IXGBE_GCR_EXT_VT_MODE_32:
+		queue_count = IXGBE_32VFS_QUEUES;
+		break;
+	case IXGBE_GCR_EXT_VT_MODE_16:
+		queue_count = IXGBE_16VFS_QUEUES;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*vf = queue / queue_count;
+
+	return 0;
+}
+
 static bool ixgbe_check_tx_hang(struct ixgbe_ring *tx_ring)
 {
 	u32 tx_done = ixgbe_get_tx_completed(tx_ring);
@@ -1157,6 +1200,151 @@ void ixgbe_update_rx_ring_stats(struct ixgbe_ring *rx_ring,
 	q_vector->rx.total_packets += pkts;
 }
 
+/**
+ * ixgbe_pf_handle_tx_hang - handle Tx hang on PF
+ * @tx_ring: tx ring number
+ * @next: next ring
+ *
+ * Prints a message containing details about the tx hang.
+ */
+static void ixgbe_pf_handle_tx_hang(struct ixgbe_ring *tx_ring,
+				    unsigned int next)
+{
+	struct ixgbe_adapter *adapter = netdev_priv(tx_ring->netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	e_err(drv, "Detected Tx Unit Hang%s\n"
+		   "  Tx Queue             <%d>\n"
+		   "  TDH, TDT             <%x>, <%x>\n"
+		   "  next_to_use          <%x>\n"
+		   "  next_to_clean        <%x>\n"
+		   "tx_buffer_info[next_to_clean]\n"
+		   "  time_stamp           <%lx>\n"
+		   "  jiffies              <%lx>\n",
+	      ring_is_xdp(tx_ring) ? " (XDP)" : "",
+	      tx_ring->queue_index,
+	      IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
+	      IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
+	      tx_ring->next_to_use, next,
+	      tx_ring->tx_buffer_info[next].time_stamp, jiffies);
+
+	if (!ring_is_xdp(tx_ring))
+		netif_stop_subqueue(tx_ring->netdev,
+				    tx_ring->queue_index);
+}
+
+/**
+ * ixgbe_vf_handle_tx_hang - handle Tx hang on VF
+ * @adapter: structure containing ring specific data
+ * @vf: VF index
+ *
+ * Print a message containing details about malicious driver detection.
+ * Set malicious VF link down if the detection happened several times.
+ */
+static void ixgbe_vf_handle_tx_hang(struct ixgbe_adapter *adapter, u16 vf)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	if (adapter->hw.mac.type != ixgbe_mac_e610)
+		return;
+
+	e_warn(drv,
+	       "Malicious Driver Detection tx hang detected on PF %d VF %d MAC: %pM",
+	       hw->bus.func, vf, adapter->vfinfo[vf].vf_mac_addresses);
+
+	adapter->tx_hang_count[vf]++;
+	if (adapter->tx_hang_count[vf] == IXGBE_MAX_TX_VF_HANGS) {
+		ixgbe_set_vf_link_state(adapter, vf,
+					IFLA_VF_LINK_STATE_DISABLE);
+		adapter->tx_hang_count[vf] = 0;
+	}
+}
+
+static u32 ixgbe_poll_tx_icache(struct ixgbe_hw *hw, u16 queue, u16 idx)
+{
+	IXGBE_WRITE_REG(hw, IXGBE_TXDESCIC, queue * idx);
+	return IXGBE_READ_REG(hw, IXGBE_TXDESCIC);
+}
+
+/**
+ * ixgbe_check_illegal_queue - search for queue with illegal packet
+ * @adapter: structure containing ring specific data
+ * @queue: queue index
+ *
+ * Check if tx descriptor connected with input queue
+ * contains illegal packet.
+ *
+ * Returns: true if queue contain illegal packet.
+ */
+static bool ixgbe_check_illegal_queue(struct ixgbe_adapter *adapter,
+				      u16 queue)
+{
+	u32 hdr_len_reg, mss_len_reg, type_reg;
+	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mss_len, header_len, reg;
+
+	for (u16 i = 0; i < IXGBE_MAX_TX_DESCRIPTORS; i++) {
+		/* HW will clear bit IXGBE_TXDESCIC_READY when address
+		 * is written to address field. HW will set this bit
+		 * when iCache read is done, and data is ready at TIC_DWx.
+		 * Set descriptor address.
+		 */
+		read_poll_timeout(ixgbe_poll_tx_icache, reg,
+				  !(reg & IXGBE_TXDESCIC_READY), 0, 0, false,
+				  hw, queue, i);
+
+		/* read tx descriptor access registers */
+		hdr_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_VLAN_MACIP_LENS_REG));
+		type_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_TYPE_TUCMD_MLHL));
+		mss_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_MSS_L4LEN_IDX));
+
+		/* check if Advanced Context Descriptor */
+		if (FIELD_GET(IXGBE_ADVTXD_DTYP_MASK, type_reg) !=
+		    IXGBE_ADVTXD_DTYP_CTXT)
+			continue;
+
+		/* check for illegal MSS and Header length */
+		mss_len = FIELD_GET(IXGBE_ADVTXD_MSS_MASK, mss_len_reg);
+		header_len = FIELD_GET(IXGBE_ADVTXD_HEADER_LEN_MASK,
+				       hdr_len_reg);
+		if ((mss_len + header_len) > SZ_16K) {
+			e_warn(probe,
+			       "mss len + header len too long\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * ixgbe_handle_mdd_event - handle mdd event
+ * @adapter: structure containing ring specific data
+ * @tx_ring: tx descriptor ring to handle
+ *
+ * Reset VF driver if malicious vf detected or
+ * illegal packet in an any queue detected.
+ */
+static void ixgbe_handle_mdd_event(struct ixgbe_adapter *adapter,
+				   struct ixgbe_ring *tx_ring)
+{
+	u16 vf, q;
+
+	if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {
+		/* vf mdd info and malicious vf detected */
+		if (!ixgbe_get_vf_idx(adapter, tx_ring->queue_index, &vf))
+			ixgbe_vf_handle_tx_hang(adapter, vf);
+	} else {
+		/* malicious vf not detected */
+		for (q = 0; q < IXGBE_MAX_TX_QUEUES; q++) {
+			if (ixgbe_check_illegal_queue(adapter, q) &&
+			    !ixgbe_get_vf_idx(adapter, q, &vf))
+				/* illegal queue detected */
+				ixgbe_vf_handle_tx_hang(adapter, vf);
+		}
+	}
+}
+
 /**
  * ixgbe_clean_tx_irq - Reclaim resources after transmit completes
  * @q_vector: structure containing interrupt and ring information
@@ -1264,26 +1452,10 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector *q_vector,
 	adapter->tx_ipsec += total_ipsec;
 
 	if (check_for_tx_hang(tx_ring) && ixgbe_check_tx_hang(tx_ring)) {
-		/* schedule immediate reset if we believe we hung */
-		struct ixgbe_hw *hw = &adapter->hw;
-		e_err(drv, "Detected Tx Unit Hang %s\n"
-			"  Tx Queue             <%d>\n"
-			"  TDH, TDT             <%x>, <%x>\n"
-			"  next_to_use          <%x>\n"
-			"  next_to_clean        <%x>\n"
-			"tx_buffer_info[next_to_clean]\n"
-			"  time_stamp           <%lx>\n"
-			"  jiffies              <%lx>\n",
-			ring_is_xdp(tx_ring) ? "(XDP)" : "",
-			tx_ring->queue_index,
-			IXGBE_READ_REG(hw, IXGBE_TDH(tx_ring->reg_idx)),
-			IXGBE_READ_REG(hw, IXGBE_TDT(tx_ring->reg_idx)),
-			tx_ring->next_to_use, i,
-			tx_ring->tx_buffer_info[i].time_stamp, jiffies);
-
-		if (!ring_is_xdp(tx_ring))
-			netif_stop_subqueue(tx_ring->netdev,
-					    tx_ring->queue_index);
+		if (adapter->hw.mac.type == ixgbe_mac_e610)
+			ixgbe_handle_mdd_event(adapter, tx_ring);
+
+		ixgbe_pf_handle_tx_hang(tx_ring, i);
 
 		e_info(probe,
 		       "tx hang %d detected on queue %d, resetting adapter\n",
-- 
2.42.0


