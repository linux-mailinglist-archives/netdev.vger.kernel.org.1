Return-Path: <netdev+bounces-114051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F09940D76
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEADE28567C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05F194C96;
	Tue, 30 Jul 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjAcDKSe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F251E194C74
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331674; cv=none; b=NDI2UJO6Sygc3XlD50EpkWlODVOMPOQHJldqnXkI5K6wO+zLdvQtpR/UQPqyY+liNlQy03A1VfN2fMfXI6lfP9aKbs8zziTrpMrQckq9SAHFAZ4X7EtYCzolDyL3aThnIuPQB0VlUt9h5diQuml3J91Qc7tCITC5/j2b8ezeBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331674; c=relaxed/simple;
	bh=9jvNZoUxVWOhan80V8NC78FuZjCVw72X/JMQNZEh+/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O3t3fiPEtzmna5woXMJVVil0TTRaokXppw11t0vs53T5xm44wikNsCvSZJh1w93GWhrX6RtRxsVohYbH7ZOhUaCskMB7QQYX/JNJVau7iNxFlsF7EWVvJBUW0dxuP0Cal/AfaiDZ4m9G89642Ee3rIYUPRg3aGdwUWwinqFPHV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjAcDKSe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331670; x=1753867670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jvNZoUxVWOhan80V8NC78FuZjCVw72X/JMQNZEh+/8=;
  b=kjAcDKSeHMODArKlnbgYOonUiTj7pF3Lo1eq+wt8sLPsZETNdwiD41Mx
   VVv/PxfT7vV3Ds227Ffkr3ZSwP87TOi4pOkJq+6Wqu2BfQ/L0RQIuxiBp
   u2UFDlsm/OXLDDo7soEjWP7HtM/+jT9ZNZTxdcGPUFum2eJYnpEflHezA
   wHKB6d34aFBezMa+ZqXjqpML4S8OPjbd9QecV+Jhg7nxguKo6wSZsMUak
   3rrnolKTi7RuBHvg8QRv80v9qtiUKl6a44hv8mMZrjeZm128ySp8orXnx
   90zj/S6Og7r15h4wsxxrDymISQ6RnTL3Zc4odxCVtfodE9XRg+0WwlNCU
   Q==;
X-CSE-ConnectionGUID: /DqeRY5rTcmfCME/4cHTXg==
X-CSE-MsgGUID: f+uHIPz5TkSuMq+VV6K8Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="45551286"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="45551286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:27:49 -0700
X-CSE-ConnectionGUID: X/UmntkwShe8at9NLqOBtA==
X-CSE-MsgGUID: N9iq7PJ+RamVHVDIB5Ir/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84923137"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 02:27:46 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7EB3F2816F;
	Tue, 30 Jul 2024 10:27:45 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v8 01/14] virtchnl: add support for enabling PTP on iAVF
Date: Tue, 30 Jul 2024 05:14:56 -0400
Message-Id: <20240730091509.18846-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
References: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add support for allowing a VF to enable PTP feature - Rx timestamps

The new capability is gated by VIRTCHNL_VF_CAP_PTP, which must be
set by the VF to request access to the new operations. In addition, the
VIRTCHNL_OP_1588_PTP_CAPS command is used to determine the specific
capabilities available to the VF.

This support includes the following additional capabilities:

* Rx timestamps enabled in the Rx queues (when using flexible advanced
  descriptors)
* Read access to PHC time over virtchnl using
  VIRTCHNL_OP_1588_PTP_GET_TIME

Extra space is reserved in most structures to allow for future
extension (like set clock, Tx timestamps).  Additional opcode numbers
are reserved and space in the virtchnl_ptp_caps structure is
specifically set aside for this.
Additionally, each structure has some space reserved for future
extensions to allow some flexibility.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 include/linux/avf/virtchnl.h | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index f41395264dca..5edfb01fa064 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -151,6 +151,9 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2 = 55,
 	VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 = 56,
 	VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2 = 57,
+	/* opcode 58 and 59 are reserved */
+	VIRTCHNL_OP_1588_PTP_GET_CAPS = 60,
+	VIRTCHNL_OP_1588_PTP_GET_TIME = 61,
 	VIRTCHNL_OP_MAX,
 };
 
@@ -261,6 +264,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC	BIT(26)
 #define VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF		BIT(27)
 #define VIRTCHNL_VF_OFFLOAD_FDIR_PF		BIT(28)
+#define VIRTCHNL_VF_CAP_PTP			BIT(31)
 
 #define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
 			       VIRTCHNL_VF_OFFLOAD_VLAN | \
@@ -1416,6 +1420,59 @@ struct virtchnl_fdir_del {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 
+#define VIRTCHNL_1588_PTP_CAP_RX_TSTAMP		BIT(1)
+#define VIRTCHNL_1588_PTP_CAP_READ_PHC		BIT(2)
+
+/**
+ * struct virtchnl_ptp_caps - Defines the PTP caps available to the VF.
+ * @caps: On send, VF sets what capabilities it requests. On reply, PF
+ *        indicates what has been enabled for this VF. The PF shall not set
+ *        bits which were not requested by the VF.
+ * @rsvd: Reserved bits for future extension.
+ *
+ * Structure that defines the PTP capabilities available to the VF. The VF
+ * sends VIRTCHNL_OP_1588_PTP_GET_CAPS, and must fill in the ptp_caps field
+ * indicating what capabilities it is requesting. The PF will respond with the
+ * same message with the virtchnl_ptp_caps structure indicating what is
+ * enabled for the VF.
+ *
+ * VIRTCHNL_1588_PTP_CAP_RX_TSTAMP indicates that the VF receive queues have
+ * receive timestamps enabled in the flexible descriptors. Note that this
+ * requires a VF to also negotiate to enable advanced flexible descriptors in
+ * the receive path instead of the default legacy descriptor format.
+ *
+ * VIRTCHNL_1588_PTP_CAP_READ_PHC indicates that the VF may read the PHC time
+ * via the VIRTCHNL_OP_1588_PTP_GET_TIME command.
+ *
+ * Note that in the future, additional capability flags may be added which
+ * indicate additional extended support. All fields marked as reserved by this
+ * header will be set to zero. VF implementations should verify this to ensure
+ * that future extensions do not break compatibility.
+ */
+struct virtchnl_ptp_caps {
+	u32 caps;
+	u8 rsvd[44];
+};
+VIRTCHNL_CHECK_STRUCT_LEN(48, virtchnl_ptp_caps);
+
+/**
+ * struct virtchnl_phc_time - Contains the 64bits of PHC clock time in ns.
+ * @time: PHC time in nanoseconds
+ * @rsvd: Reserved for future extension
+ *
+ * Structure received with VIRTCHNL_OP_1588_PTP_GET_TIME. Contains the 64bits
+ * of PHC clock time in nanoseconds.
+ *
+ * VIRTCHNL_OP_1588_PTP_GET_TIME may be sent to request the current time of
+ * the PHC. This op is available in case direct access via the PHC registers
+ * is not available.
+ */
+struct virtchnl_phc_time {
+	u64 time;
+	u8 rsvd[8];
+};
+VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_phc_time);
+
 #define __vss_byone(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
 
@@ -1637,6 +1694,12 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2:
 		valid_len = sizeof(struct virtchnl_vlan_setting);
 		break;
+	case VIRTCHNL_OP_1588_PTP_GET_CAPS:
+		valid_len = sizeof(struct virtchnl_ptp_caps);
+		break;
+	case VIRTCHNL_OP_1588_PTP_GET_TIME:
+		valid_len = sizeof(struct virtchnl_phc_time);
+		break;
 	/* These are always errors coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
-- 
2.38.1


