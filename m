Return-Path: <netdev+bounces-98496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C762F8D19A0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2334AB24FCC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD2A13CABD;
	Tue, 28 May 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDwAxbZG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA016C84A
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896039; cv=none; b=hlFfXr7xjda+YkBcRRVprMDLbb7PxpidGm/MQozL0A9w6+hgCJpNKSk4l59An2tDd7dTHJ2wMf5BDI0yUDxRBj5xEXXmVf0rDCYdWGjZIKT9dZwLYftj9IX4VlmumhGheCeoh6SV6y7JXmm5uJL8QeJwOhl7REsX7S+wO6UTLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896039; c=relaxed/simple;
	bh=sbu/yxxDXAQLbhANHU/FiHy4l8HCDTG80W7T6dFByvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKhY4NuC73YUctj/zEuTKXsYp3XgUD33NzedIBDtjHeho0x77Lzmj9800l26kKqqAkaOGrKwICUZ17NhqQmQyH5oYn7U8uO10KTd2Is3pp39DfJV9YNa1wIVRjiVr6jwQiwokIvVZedfmaWr2DJYBdGreU2PXM0ppRAcJzkBi8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDwAxbZG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716896037; x=1748432037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbu/yxxDXAQLbhANHU/FiHy4l8HCDTG80W7T6dFByvg=;
  b=oDwAxbZGk6bZ8mqFlH1WaaKDVO3OM46vMKmAkXZwKwg4zDFiG3s6RRT/
   9lQc66x8lYchub7VI+1J/YUWEL9wjRiclGEoKkHPwFhCBXHRC9GYy/XOk
   ZcQ9YSVviV+zlN4YtveHsbqAZVg+Ss50ftBukfEpjhdsKicvglZEqjz7s
   7xziwDz+4NaXE86eAXpdfecmRWDDyO3v7RMRLFxTNZo/Zt+It5wLG+yG/
   DIvke7kgDUDibRw0c2jvZzLqAeAep9JyAZ//WmZaIFYnkR0XoU82LQYOT
   HZPpCOBd9hYw56nh9OIk+7Vk0u8sBZ86dgliAUF4f7V26nrxjfLdRQVm9
   w==;
X-CSE-ConnectionGUID: nBFjwav5S4qnFLbF3AJyOA==
X-CSE-MsgGUID: Vy4oc9UiR6uiMmzYZeydhg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30757336"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="30757336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 04:33:57 -0700
X-CSE-ConnectionGUID: JWS4z3L8Tx6vdk3cqzp7bQ==
X-CSE-MsgGUID: xaboOtiKTCWm4nlquIaxhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35126659"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 04:33:54 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A61E027BBA;
	Tue, 28 May 2024 12:33:49 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v6 04/12] iavf: add support for negotiating flexible RXDID format
Date: Tue, 28 May 2024 07:22:53 -0400
Message-Id: <20240528112301.5374-5-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
References: <20240528112301.5374-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Enable support for VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, to enable the VF
driver the ability to determine what Rx descriptor formats are
available. This requires sending an additional message during
initialization and reset, the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS. This
operation requests the supported Rx descriptor IDs available from the
PF.

This is treated the same way that VLAN V2 capabilities are handled. Add
a new set of extended capability flags, used to process send and receipt
of the VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message.

This ensures we finish negotiating for the supported descriptor formats
prior to beginning configuration of receive queues.

This change stores the supported format bitmap into the iavf_adapter
structure. Additionally, if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is enabled
by the PF, we need to make sure that the Rx queue configuration
specifies the format.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        |  20 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 127 ++++++++++++++++--
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |   2 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  59 ++++++++
 4 files changed, 199 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 23a6557fc3db..1e04c7cf3ed8 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -266,6 +266,7 @@ struct iavf_adapter {
 	/* Lock to protect accesses to MAC and VLAN lists */
 	spinlock_t mac_vlan_list_lock;
 	char misc_vector_name[IFNAMSIZ + 9];
+	u8 rxdid;
 	int num_active_queues;
 	int num_req_queues;
 
@@ -335,6 +336,14 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_DISABLE_CTAG_VLAN_INSERTION	BIT_ULL(36)
 #define IAVF_FLAG_AQ_ENABLE_STAG_VLAN_INSERTION		BIT_ULL(37)
 #define IAVF_FLAG_AQ_DISABLE_STAG_VLAN_INSERTION	BIT_ULL(38)
+#define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(39)
+
+	/* AQ messages that must be sent after IAVF_FLAG_AQ_GET_CONFIG, in
+	 * order to negotiated extended capabilities.
+	 */
+#define IAVF_FLAG_AQ_EXTENDED_CAPS			\
+	(IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS |	\
+	 IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
 
 	/* flags for processing extended capability messages during
 	 * __IAVF_INIT_EXTENDED_CAPS. Each capability exchange requires
@@ -346,10 +355,14 @@ struct iavf_adapter {
 	u64 extended_caps;
 #define IAVF_EXTENDED_CAP_SEND_VLAN_V2			BIT_ULL(0)
 #define IAVF_EXTENDED_CAP_RECV_VLAN_V2			BIT_ULL(1)
+#define IAVF_EXTENDED_CAP_SEND_RXDID			BIT_ULL(2)
+#define IAVF_EXTENDED_CAP_RECV_RXDID			BIT_ULL(3)
 
 #define IAVF_EXTENDED_CAPS				\
 	(IAVF_EXTENDED_CAP_SEND_VLAN_V2 |		\
-	 IAVF_EXTENDED_CAP_RECV_VLAN_V2)
+	 IAVF_EXTENDED_CAP_RECV_VLAN_V2 |		\
+	 IAVF_EXTENDED_CAP_SEND_RXDID |			\
+	 IAVF_EXTENDED_CAP_RECV_RXDID)
 
 	/* Lock to prevent possible clobbering of
 	 * current_netdev_promisc_flags
@@ -405,12 +418,15 @@ struct iavf_adapter {
 			       VIRTCHNL_VF_OFFLOAD_FDIR_PF)
 #define ADV_RSS_SUPPORT(_a) ((_a)->vf_res->vf_cap_flags & \
 			     VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF)
+#define RXDID_ALLOWED(_a) ((_a)->vf_res->vf_cap_flags & \
+			   VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
 	struct virtchnl_vf_resource *vf_res; /* incl. all VSIs */
 	struct virtchnl_vsi_resource *vsi_res; /* our LAN VSI */
 	struct virtchnl_version_info pf_version;
 #define PF_IS_V11(_a) (((_a)->pf_version.major == 1) && \
 		       ((_a)->pf_version.minor == 1))
 	struct virtchnl_vlan_caps vlan_v2_caps;
+	struct virtchnl_supported_rxdids supported_rxdids;
 	u16 msg_enable;
 	struct iavf_eth_stats current_stats;
 	struct iavf_vsi vsi;
@@ -521,6 +537,8 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_config(struct iavf_adapter *adapter);
 int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter);
 int iavf_send_vf_offload_vlan_v2_msg(struct iavf_adapter *adapter);
+int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter);
+int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter);
 void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c6dff0963053..dd7369057959 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -710,6 +710,38 @@ static void iavf_configure_tx(struct iavf_adapter *adapter)
 		adapter->tx_rings[i].tail = hw->hw_addr + IAVF_QTX_TAIL1(i);
 }
 
+/**
+ * iavf_select_rx_desc_format - Select Rx descriptor format
+ * @adapter: adapter private structure
+ *
+ * Select what Rx descriptor format based on availability and enabled
+ * features.
+ *
+ * Return: the desired RXDID to select for a given Rx queue, as defined by
+ *         enum virtchnl_rxdid_format.
+ */
+static u8 iavf_select_rx_desc_format(struct iavf_adapter *adapter)
+{
+	u64 supported_rxdids = adapter->supported_rxdids.supported_rxdids;
+
+	/* If we did not negotiate VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC, we must
+	 * stick with the default value of the legacy 32 byte format.
+	 */
+	if (!RXDID_ALLOWED(adapter))
+		return VIRTCHNL_RXDID_1_32B_BASE;
+
+	/* Warn if the PF does not list support for the default legacy
+	 * descriptor format. This shouldn't happen, as this is the format
+	 * used if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is not supported. It is
+	 * likely caused by a bug in the PF implementation failing to indicate
+	 * support for the format.
+	 */
+	if (supported_rxdids & BIT(VIRTCHNL_RXDID_1_32B_BASE))
+		dev_warn(&adapter->pdev->dev, "PF does not list support for default Rx descriptor format\n");
+
+	return VIRTCHNL_RXDID_1_32B_BASE;
+}
+
 /**
  * iavf_configure_rx - Configure Receive Unit after Reset
  * @adapter: board private structure
@@ -720,8 +752,12 @@ static void iavf_configure_rx(struct iavf_adapter *adapter)
 {
 	struct iavf_hw *hw = &adapter->hw;
 
-	for (u32 i = 0; i < adapter->num_active_queues; i++)
+	adapter->rxdid = iavf_select_rx_desc_format(adapter);
+
+	for (u32 i = 0; i < adapter->num_active_queues; i++) {
 		adapter->rx_rings[i].tail = hw->hw_addr + IAVF_QRX_TAIL1(i);
+		adapter->rx_rings[i].rxdid = adapter->rxdid;
+	}
 }
 
 /**
@@ -2046,6 +2082,8 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		return iavf_send_vf_config_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS)
 		return iavf_send_vf_offload_vlan_v2_msg(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
+		return iavf_send_vf_supported_rxdids_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_QUEUES) {
 		iavf_disable_queues(adapter);
 		return 0;
@@ -2559,6 +2597,67 @@ static void iavf_init_recv_offload_vlan_v2_caps(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+/**
+ * iavf_init_send_supported_rxdids - part of querying for supported RXDID
+ * formats
+ * @adapter: board private structure
+ *
+ * Function processes send of the request for supported RXDIDs to the PF.
+ * Must clear IAVF_EXTENDED_CAP_RECV_RXDID if the message is not sent, e.g.
+ * due to the PF not negotiating VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC.
+ */
+static void iavf_init_send_supported_rxdids(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RXDID));
+
+	ret = iavf_send_vf_supported_rxdids_msg(adapter);
+	if (ret == -EOPNOTSUPP) {
+		/* PF does not support VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC. In this
+		 * case, we did not send the capability exchange message and
+		 * do not expect a response.
+		 */
+		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RXDID;
+	}
+
+	/* We sent the message, so move on to the next step */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_RXDID;
+}
+
+/**
+ * iavf_init_recv_supported_rxdids - part of querying for supported RXDID
+ * formats
+ * @adapter: board private structure
+ *
+ * Function processes receipt of the supported RXDIDs message from the PF.
+ **/
+static void iavf_init_recv_supported_rxdids(struct iavf_adapter *adapter)
+{
+	int ret;
+
+	WARN_ON(!(adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RXDID));
+
+	memset(&adapter->supported_rxdids, 0,
+	       sizeof(adapter->supported_rxdids));
+
+	ret = iavf_get_vf_supported_rxdids(adapter);
+	if (ret)
+		goto err;
+
+	/* We've processed the PF response to the
+	 * VIRTCHNL_OP_GET_SUPPORTED_RXDIDS message we sent previously.
+	 */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_RXDID;
+	return;
+err:
+	/* We didn't receive a reply. Make sure we try sending again when
+	 * __IAVF_INIT_FAILED attempts to recover.
+	 */
+	adapter->extended_caps |= IAVF_EXTENDED_CAP_SEND_RXDID;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
+}
+
 /**
  * iavf_init_process_extended_caps - Part of driver startup
  * @adapter: board private structure
@@ -2583,6 +2682,15 @@ static void iavf_init_process_extended_caps(struct iavf_adapter *adapter)
 		return;
 	}
 
+	/* Process capability exchange for RXDID formats */
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_RXDID) {
+		iavf_init_send_supported_rxdids(adapter);
+		return;
+	} else if (adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_RXDID) {
+		iavf_init_recv_supported_rxdids(adapter);
+		return;
+	}
+
 	/* When we reach here, no further extended capabilities exchanges are
 	 * necessary, so we finally transition into __IAVF_INIT_CONFIG_ADAPTER
 	 */
@@ -3051,15 +3159,18 @@ static void iavf_reset_task(struct work_struct *work)
 	}
 
 	adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
-	/* always set since VIRTCHNL_OP_GET_VF_RESOURCES has not been
-	 * sent/received yet, so VLAN_V2_ALLOWED() cannot is not reliable here,
-	 * however the VIRTCHNL_OP_GET_OFFLOAD_VLAN_V2_CAPS won't be sent until
-	 * VIRTCHNL_OP_GET_VF_RESOURCES and VIRTCHNL_VF_OFFLOAD_VLAN_V2 have
-	 * been successfully sent and negotiated
-	 */
-	adapter->aq_required |= IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS;
 	adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
 
+	/* Certain capabilities require an extended negotiation process using
+	 * extra messages that must be processed after getting the VF
+	 * configuration. The related checks such as VLAN_V2_ALLOWED() are not
+	 * reliable here, since the configuration has not yet been negotiated.
+	 *
+	 * Always set these flags, since them related VIRTCHNL messages won't
+	 * be sent until after VIRTCHNL_OP_GET_VF_RESOURCES.
+	 */
+	adapter->aq_required |= IAVF_FLAG_AQ_EXTENDED_CAPS;
+
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	/* Delete filter for the current MAC address, it could have
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index d7b5587aeb8e..17309d8625ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -262,6 +262,8 @@ struct iavf_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 
+	u8 rxdid;		/* Rx descriptor format */
+
 	u16 flags;
 #define IAVF_TXR_FLAGS_WB_ON_ITR		BIT(0)
 #define IAVF_TXR_FLAGS_ARM_WB			BIT(1)
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 1e543f6a7c30..f8286e3f0d9e 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -143,6 +143,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_RSS_PCTYPE_V2 |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP |
 	       VIRTCHNL_VF_OFFLOAD_VLAN_V2 |
+	       VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC |
 	       VIRTCHNL_VF_OFFLOAD_CRC |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
 	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
@@ -175,6 +176,19 @@ int iavf_send_vf_offload_vlan_v2_msg(struct iavf_adapter *adapter)
 				NULL, 0);
 }
 
+int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter)
+{
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS;
+
+	if (!RXDID_ALLOWED(adapter))
+		return -EOPNOTSUPP;
+
+	adapter->current_op = VIRTCHNL_OP_GET_SUPPORTED_RXDIDS;
+
+	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
+				NULL, 0);
+}
+
 /**
  * iavf_validate_num_queues
  * @adapter: adapter structure
@@ -261,6 +275,45 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter)
 	return err;
 }
 
+int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
+{
+	struct iavf_hw *hw = &adapter->hw;
+	struct iavf_arq_event_info event;
+	enum virtchnl_ops op;
+	enum iavf_status err;
+	u16 len;
+
+	len =  sizeof(struct virtchnl_supported_rxdids);
+	event.buf_len = len;
+	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
+	if (!event.msg_buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	while (1) {
+		/* When the AQ is empty, iavf_clean_arq_element will return
+		 * nonzero and this loop will terminate.
+		 */
+		err = iavf_clean_arq_element(hw, &event, NULL);
+		if (err != IAVF_SUCCESS)
+			goto out_alloc;
+		op = (enum virtchnl_ops)le32_to_cpu(event.desc.cookie_high);
+		if (op == VIRTCHNL_OP_GET_SUPPORTED_RXDIDS)
+			break;
+	}
+
+	err = (enum iavf_status)le32_to_cpu(event.desc.cookie_low);
+	if (err)
+		goto out_alloc;
+
+	memcpy(&adapter->supported_rxdids, event.msg_buf, min(event.msg_len, len));
+out_alloc:
+	kfree(event.msg_buf);
+out:
+	return err;
+}
+
 /**
  * iavf_configure_queues
  * @adapter: adapter structure
@@ -307,6 +360,8 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 		vqpi->rxq.dma_ring_addr = adapter->rx_rings[i].dma;
 		vqpi->rxq.max_pkt_size = max_frame;
 		vqpi->rxq.databuffer_size = adapter->rx_rings[i].rx_buf_len;
+		if (RXDID_ALLOWED(adapter))
+			vqpi->rxq.rxdid = adapter->rxdid;
 		if (CRC_OFFLOAD_ALLOWED(adapter))
 			vqpi->rxq.crc_disable = !!(adapter->netdev->features &
 						   NETIF_F_RXFCS);
@@ -2371,6 +2426,10 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 			aq_required;
 		}
 		break;
+	case VIRTCHNL_OP_GET_SUPPORTED_RXDIDS:
+		memcpy(&adapter->supported_rxdids, msg,
+		       min_t(u16, msglen, sizeof(adapter->supported_rxdids)));
+		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
 		iavf_irq_enable(adapter, true);
-- 
2.38.1


