Return-Path: <netdev+bounces-135125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44A699C639
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57D6B1F237DB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2415D5CE;
	Mon, 14 Oct 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HacQbbag"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588F15A863
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899049; cv=none; b=JIHGkbgc4efWEuFoAt9ABi7zVBITEEv8FrZ/KgMMXl7Sp0uzy0mi26uQnskVnWYGrI32IvQnmqnoXZBqAQW0nWuuxM5oxiyVcxnPPf5CnN25Dne9Omcfv0qKGFhcFfdRTOgxpeOLLT4EkhW5yUsvYfcwwBQRwA4COOCZvyjR5BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899049; c=relaxed/simple;
	bh=UMGM8hAyqnje/zOZl1BWGh0zQP83vVYxkQiK8Mt6n9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGHBjwNNrYcwRd81AX5Gs7b6KDGdEqcYNCRCicp//pLvh5EbK6FjCe0P49ihvYdTyFGQY/EGCpBXGbE49Scd9W97FvL9wP3kDxqkw2jXpQPTQOTNKCG9U3suh2Xvv92q1QJ2E8oA2PVKbM5hlPU+CpzOc1qaA2l9hHpgjU4QAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HacQbbag; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728899047; x=1760435047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UMGM8hAyqnje/zOZl1BWGh0zQP83vVYxkQiK8Mt6n9I=;
  b=HacQbbagBai+YzIT7kgqSwc7pZuKQhInX+0Y9lowGvCMr9pzdvVccbFb
   zkeLixCGVNn3IP5lrUaZLsZwab8SoH8CQA/i3zw3KQuuash1Q6Fh2DgS2
   4GUSB8/zbYnB4QgHHkv5xzl1bQQt21/XtdibKCzW0LJUY9WSXgO9ybnT4
   McSm6AOzK/K2DlPPXiBXGKmyt+cyYE2tTIXo5SPEy1cS3UPOcAe2KOeoE
   lkOScwNwO5OOuwf+o4BVSGYMPkwDOwss8MBmWfdueQh2Ee53RnfctcYFj
   rE/a73R6kRH1OquWhCKj/gJJvqbbfD4g5I0SegModVpOyfWd7v/bSnSxY
   g==;
X-CSE-ConnectionGUID: pNsStR1bQi+Zu2TJTW7DKQ==
X-CSE-MsgGUID: x01WGK0CQ/qlFID9r65Fvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45712163"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45712163"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 02:44:06 -0700
X-CSE-ConnectionGUID: nZ20kV0XTEq3OLtnh1gCQA==
X-CSE-MsgGUID: kAGF6Bt2QfaPfwo3J4XqjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77531813"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2024 02:44:03 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5181127BD5;
	Mon, 14 Oct 2024 10:44:02 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v11 05/14] iavf: negotiate PTP capabilities
Date: Sun, 13 Oct 2024 11:44:06 -0400
Message-Id: <20241013154415.20262-6-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
References: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add a new extended capabilities negotiation to exchange information from
the PF about what PTP capabilities are supported by this VF. This
requires sending a VIRTCHNL_OP_1588_PTP_GET_CAPS message, and waiting
for the response from the PF. Handle this early on during the VF
initialization.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        | 17 +++++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 60 +++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  9 +++
 drivers/net/ethernet/intel/iavf/iavf_types.h  | 34 +++++++++++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 60 +++++++++++++++++++
 5 files changed, 178 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index a520374c5228..b6e52992e270 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -41,6 +41,7 @@
 #include "iavf_txrx.h"
 #include "iavf_fdir.h"
 #include "iavf_adv_rss.h"
+#include "iavf_types.h"
 #include <linux/bitmap.h>
 
 #define DEFAULT_DEBUG_LEVEL_SHIFT 3
@@ -345,13 +346,16 @@ struct iavf_adapter {
 #define IAVF_FLAG_AQ_CFG_QUEUES_QUANTA_SIZE		BIT_ULL(40)
 #define IAVF_FLAG_AQ_GET_QOS_CAPS			BIT_ULL(41)
 #define IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS		BIT_ULL(42)
+#define IAVF_FLAG_AQ_GET_PTP_CAPS			BIT_ULL(43)
+#define IAVF_FLAG_AQ_SEND_PTP_CMD			BIT_ULL(44)
 
 	/* AQ messages that must be sent after IAVF_FLAG_AQ_GET_CONFIG, in
 	 * order to negotiated extended capabilities.
 	 */
 #define IAVF_FLAG_AQ_EXTENDED_CAPS			\
 	(IAVF_FLAG_AQ_GET_OFFLOAD_VLAN_V2_CAPS |	\
-	 IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
+	 IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS |		\
+	 IAVF_FLAG_AQ_GET_PTP_CAPS)
 
 	/* flags for processing extended capability messages during
 	 * __IAVF_INIT_EXTENDED_CAPS. Each capability exchange requires
@@ -365,12 +369,16 @@ struct iavf_adapter {
 #define IAVF_EXTENDED_CAP_RECV_VLAN_V2			BIT_ULL(1)
 #define IAVF_EXTENDED_CAP_SEND_RXDID			BIT_ULL(2)
 #define IAVF_EXTENDED_CAP_RECV_RXDID			BIT_ULL(3)
+#define IAVF_EXTENDED_CAP_SEND_PTP			BIT_ULL(4)
+#define IAVF_EXTENDED_CAP_RECV_PTP			BIT_ULL(5)
 
 #define IAVF_EXTENDED_CAPS				\
 	(IAVF_EXTENDED_CAP_SEND_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_RECV_VLAN_V2 |		\
 	 IAVF_EXTENDED_CAP_SEND_RXDID |			\
-	 IAVF_EXTENDED_CAP_RECV_RXDID)
+	 IAVF_EXTENDED_CAP_RECV_RXDID |			\
+	 IAVF_EXTENDED_CAP_SEND_PTP |			\
+	 IAVF_EXTENDED_CAP_RECV_PTP)
 
 	/* Lock to prevent possible clobbering of
 	 * current_netdev_promisc_flags
@@ -432,6 +440,8 @@ struct iavf_adapter {
 			 VIRTCHNL_VF_OFFLOAD_QOS)
 #define IAVF_RXDID_ALLOWED(a)						\
 	((a)->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC)
+#define IAVF_PTP_ALLOWED(a)						\
+	((a)->vf_res->vf_cap_flags & VIRTCHNL_VF_CAP_PTP)
 	struct virtchnl_vf_resource *vf_res; /* incl. all VSIs */
 	struct virtchnl_vsi_resource *vsi_res; /* our LAN VSI */
 	struct virtchnl_version_info pf_version;
@@ -439,6 +449,7 @@ struct iavf_adapter {
 		       ((_a)->pf_version.minor == 1))
 	struct virtchnl_vlan_caps vlan_v2_caps;
 	u64 supp_rxdids;
+	struct iavf_ptp ptp;
 	u16 msg_enable;
 	struct iavf_eth_stats current_stats;
 	struct virtchnl_qos_cap_list *qos_caps;
@@ -573,6 +584,8 @@ int iavf_get_vf_vlan_v2_caps(struct iavf_adapter *adapter);
 int iavf_send_vf_offload_vlan_v2_msg(struct iavf_adapter *adapter);
 int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter);
 int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter);
+int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter);
+int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter);
 void iavf_set_queue_vlan_tag_loc(struct iavf_adapter *adapter);
 u16 iavf_get_num_vlans_added(struct iavf_adapter *adapter);
 void iavf_irq_enable(struct iavf_adapter *adapter, bool flush);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c595999fa90d..3b149bb7d840 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2102,6 +2102,8 @@ static int iavf_process_aq_command(struct iavf_adapter *adapter)
 		return iavf_send_vf_offload_vlan_v2_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_GET_SUPPORTED_RXDIDS)
 		return iavf_send_vf_supported_rxdids_msg(adapter);
+	if (adapter->aq_required & IAVF_FLAG_AQ_GET_PTP_CAPS)
+		return iavf_send_vf_ptp_caps_msg(adapter);
 	if (adapter->aq_required & IAVF_FLAG_AQ_DISABLE_QUEUES) {
 		iavf_disable_queues(adapter);
 		return 0;
@@ -2687,6 +2689,55 @@ static void iavf_init_recv_supported_rxdids(struct iavf_adapter *adapter)
 	iavf_change_state(adapter, __IAVF_INIT_FAILED);
 }
 
+/**
+ * iavf_init_send_ptp_caps - part of querying for extended PTP capabilities
+ * @adapter: board private structure
+ *
+ * Function processes send of the request for 1588 PTP capabilities to the PF.
+ * Must clear IAVF_EXTENDED_CAP_SEND_PTP if the message is not sent, e.g.
+ * due to the PF not negotiating VIRTCHNL_VF_PTP_CAP
+ */
+static void iavf_init_send_ptp_caps(struct iavf_adapter *adapter)
+{
+	if (iavf_send_vf_ptp_caps_msg(adapter) == -EOPNOTSUPP) {
+		/* PF does not support VIRTCHNL_VF_PTP_CAP. In this case, we
+		 * did not send the capability exchange message and do not
+		 * expect a response.
+		 */
+		adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_PTP;
+	}
+
+	/* We sent the message, so move on to the next step */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_SEND_PTP;
+}
+
+/**
+ * iavf_init_recv_ptp_caps - part of querying for supported PTP capabilities
+ * @adapter: board private structure
+ *
+ * Function processes receipt of the PTP capabilities supported on this VF.
+ **/
+static void iavf_init_recv_ptp_caps(struct iavf_adapter *adapter)
+{
+	memset(&adapter->ptp.hw_caps, 0, sizeof(adapter->ptp.hw_caps));
+
+	if (iavf_get_vf_ptp_caps(adapter))
+		goto err;
+
+	/* We've processed the PF response to the VIRTCHNL_OP_1588_PTP_GET_CAPS
+	 * message we sent previously.
+	 */
+	adapter->extended_caps &= ~IAVF_EXTENDED_CAP_RECV_PTP;
+	return;
+
+err:
+	/* We didn't receive a reply. Make sure we try sending again when
+	 * __IAVF_INIT_FAILED attempts to recover.
+	 */
+	adapter->extended_caps |= IAVF_EXTENDED_CAP_SEND_PTP;
+	iavf_change_state(adapter, __IAVF_INIT_FAILED);
+}
+
 /**
  * iavf_init_process_extended_caps - Part of driver startup
  * @adapter: board private structure
@@ -2720,6 +2771,15 @@ static void iavf_init_process_extended_caps(struct iavf_adapter *adapter)
 		return;
 	}
 
+	/* Process capability exchange for PTP features */
+	if (adapter->extended_caps & IAVF_EXTENDED_CAP_SEND_PTP) {
+		iavf_init_send_ptp_caps(adapter);
+		return;
+	} else if (adapter->extended_caps & IAVF_EXTENDED_CAP_RECV_PTP) {
+		iavf_init_recv_ptp_caps(adapter);
+		return;
+	}
+
 	/* When we reach here, no further extended capabilities exchanges are
 	 * necessary, so we finally transition into __IAVF_INIT_CONFIG_ADAPTER
 	 */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
new file mode 100644
index 000000000000..65678e76c34f
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. */
+
+#ifndef _IAVF_PTP_H_
+#define _IAVF_PTP_H_
+
+#include "iavf_types.h"
+
+#endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_types.h b/drivers/net/ethernet/intel/iavf/iavf_types.h
new file mode 100644
index 000000000000..a095855122bf
--- /dev/null
+++ b/drivers/net/ethernet/intel/iavf/iavf_types.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024 Intel Corporation. */
+
+#ifndef _IAVF_TYPES_H_
+#define _IAVF_TYPES_H_
+
+#include "iavf_types.h"
+
+#include <linux/avf/virtchnl.h>
+#include <linux/ptp_clock_kernel.h>
+
+/* structure used to queue PTP commands for processing */
+struct iavf_ptp_aq_cmd {
+	struct list_head list;
+	enum virtchnl_ops v_opcode:16;
+	u16 msglen;
+	u8 msg[] __counted_by(msglen);
+};
+
+struct iavf_ptp {
+	wait_queue_head_t phc_time_waitqueue;
+	struct virtchnl_ptp_caps hw_caps;
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct list_head aq_cmds;
+	u64 cached_phc_time;
+	unsigned long cached_phc_updated;
+	/* Lock protecting access to the AQ command list */
+	struct mutex aq_cmd_lock;
+	struct kernel_hwtstamp_config hwtstamp_config;
+	bool phc_time_ready:1;
+};
+
+#endif /* _IAVF_TYPES_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 42e906941811..65b0028bb968 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -148,6 +148,7 @@ int iavf_send_vf_config_msg(struct iavf_adapter *adapter)
 	       VIRTCHNL_VF_OFFLOAD_CRC |
 	       VIRTCHNL_VF_OFFLOAD_ENCAP_CSUM |
 	       VIRTCHNL_VF_OFFLOAD_REQ_QUEUES |
+	       VIRTCHNL_VF_CAP_PTP |
 	       VIRTCHNL_VF_OFFLOAD_ADQ |
 	       VIRTCHNL_VF_OFFLOAD_USO |
 	       VIRTCHNL_VF_OFFLOAD_FDIR_PF |
@@ -191,6 +192,41 @@ int iavf_send_vf_supported_rxdids_msg(struct iavf_adapter *adapter)
 				NULL, 0);
 }
 
+/**
+ * iavf_send_vf_ptp_caps_msg - Send request for PTP capabilities
+ * @adapter: private adapter structure
+ *
+ * Send the VIRTCHNL_OP_1588_PTP_GET_CAPS command to the PF to request the PTP
+ * capabilities available to this device. This includes the following
+ * potential access:
+ *
+ * * READ_PHC - access to read the PTP hardware clock time
+ * * RX_TSTAMP - access to request Rx timestamps on all received packets
+ *
+ * The PF will reply with the same opcode a filled out copy of the
+ * virtchnl_ptp_caps structure which defines the specifics of which features
+ * are accessible to this device.
+ *
+ * Return: 0 if success, error code otherwise.
+ */
+int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *adapter)
+{
+	struct virtchnl_ptp_caps hw_caps = {
+		.caps = VIRTCHNL_1588_PTP_CAP_READ_PHC |
+			VIRTCHNL_1588_PTP_CAP_RX_TSTAMP
+	};
+
+	adapter->aq_required &= ~IAVF_FLAG_AQ_GET_PTP_CAPS;
+
+	if (!IAVF_PTP_ALLOWED(adapter))
+		return -EOPNOTSUPP;
+
+	adapter->current_op = VIRTCHNL_OP_1588_PTP_GET_CAPS;
+
+	return iavf_send_pf_msg(adapter, VIRTCHNL_OP_1588_PTP_GET_CAPS,
+				(u8 *)&hw_caps, sizeof(hw_caps));
+}
+
 /**
  * iavf_validate_num_queues
  * @adapter: adapter structure
@@ -294,6 +330,23 @@ int iavf_get_vf_supported_rxdids(struct iavf_adapter *adapter)
 	return err;
 }
 
+int iavf_get_vf_ptp_caps(struct iavf_adapter *adapter)
+{
+	struct virtchnl_ptp_caps caps = {};
+	struct iavf_arq_event_info event;
+	int err;
+
+	event.msg_buf = (u8 *)&caps;
+	event.buf_len = sizeof(caps);
+
+	err = iavf_poll_virtchnl_msg(&adapter->hw, &event,
+				     VIRTCHNL_OP_1588_PTP_GET_CAPS);
+	if (!err)
+		adapter->ptp.hw_caps = caps;
+
+	return err;
+}
+
 /**
  * iavf_configure_queues
  * @adapter: adapter structure
@@ -2548,6 +2601,13 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		adapter->supp_rxdids = *(u64 *)msg;
 
+		break;
+	case VIRTCHNL_OP_1588_PTP_GET_CAPS:
+		if (msglen != sizeof(adapter->ptp.hw_caps))
+			return;
+
+		adapter->ptp.hw_caps = *(struct virtchnl_ptp_caps *)msg;
+
 		break;
 	case VIRTCHNL_OP_ENABLE_QUEUES:
 		/* enable transmits */
-- 
2.38.1


