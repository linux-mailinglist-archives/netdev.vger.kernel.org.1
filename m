Return-Path: <netdev+bounces-142341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65D19BE5AA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BF21F249A5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2EA1DEFE3;
	Wed,  6 Nov 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JAw22UEP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034951DE886
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893073; cv=none; b=rjodA80e7AbIjnx+cYjzDXYVrtP9Gbke3/+kB51QqQNOVLxm9gEVPKUFg22dbKtMLAGYW8jTfFq+xO3KEfRC3R2PfYlVzX7PT27K4ObvzRGLx5o4z+Wb7cHEtvxJ6IBKxA7FhkQsnqx4ut5sCPPEgqeyZh6bXKL1R8d7jKy9nJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893073; c=relaxed/simple;
	bh=CW7k67SojY93tt0tu9frOUW0putdp0RxpTmB3qfyerM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niVB9wYA4orEWUBlzMgpmPzOidSoXXOX3mecyrpFQwHqx/GPE52gttzUxpJVPOsMwqB3zie/idETV6TAy66SzJu561RXRDw14Q4lEMoXN4aCgME2k8am/iyXZQkvFGX5sH8pbEKZBdFg82JzAXBdbI9LkTlloG+AII9TiXvOX0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JAw22UEP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730893071; x=1762429071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CW7k67SojY93tt0tu9frOUW0putdp0RxpTmB3qfyerM=;
  b=JAw22UEPe6rsEaWjHrx+niK7JRa1V/LF24elqZrLqj7Vw0v4VrZMTUnN
   CI2znwZOOkEE07zprf/GrqFZFWn88Z+e8aEQO8CQAoqTziCa1AL86rOHd
   yY1XqJf3aVOEbhGHOIacW6j4atqXfokbzpcDQjAwPYpV+g9B3fskitAfy
   0H06OX8q/GpOtsH6vpI6Jmdmv7fjLMjzFRYOoCDFxnIxz/k1EfYdepjfJ
   bbN/G0caZnHIFpLHDwcSyvW5dJm04CCpDQ6wqU4QsXOVffiZ2ojaCGZ6T
   +v7GoNvivaQkJTZEp3gtuGVoGtZtlsaWaKpbFtcS5eTHgsP0GoBfAZNdk
   Q==;
X-CSE-ConnectionGUID: 4BYnCmGDSaKY3jpThrR3XA==
X-CSE-MsgGUID: 74To5kv0Q+m+YpFlH/n5Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30455493"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30455493"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:37:50 -0800
X-CSE-ConnectionGUID: TtVQhuVUQJupY5LjnpNoCg==
X-CSE-MsgGUID: ldQTe6DWQLOLGfYPS2bFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="122020116"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2024 03:37:47 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EBCE9284ED;
	Wed,  6 Nov 2024 11:37:45 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v13 01/14] virtchnl: add support for enabling PTP on iAVF
Date: Wed,  6 Nov 2024 12:37:18 -0500
Message-Id: <20241106173731.4272-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
References: <20241106173731.4272-1-mateusz.polchlopek@intel.com>
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
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 include/linux/avf/virtchnl.h | 67 +++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 13a11f3c09b8..92866e449b21 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -154,7 +154,10 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2 = 55,
 	VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 = 56,
 	VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2 = 57,
-	/* opcode 57 - 65 are reserved */
+	/* opcode 58 and 59 are reserved */
+	VIRTCHNL_OP_1588_PTP_GET_CAPS = 60,
+	VIRTCHNL_OP_1588_PTP_GET_TIME = 61,
+	/* opcode 62 - 65 are reserved */
 	VIRTCHNL_OP_GET_QOS_CAPS = 66,
 	/* opcode 68 through 111 are reserved */
 	VIRTCHNL_OP_CONFIG_QUEUE_BW = 112,
@@ -270,6 +273,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF		BIT(27)
 #define VIRTCHNL_VF_OFFLOAD_FDIR_PF		BIT(28)
 #define VIRTCHNL_VF_OFFLOAD_QOS			BIT(29)
+#define VIRTCHNL_VF_CAP_PTP			BIT(31)
 
 #define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
 			       VIRTCHNL_VF_OFFLOAD_VLAN | \
@@ -1425,6 +1429,61 @@ struct virtchnl_fdir_del {
 
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
+
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
+
+VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_phc_time);
+
 struct virtchnl_shaper_bw {
 	/* Unit is Kbps */
 	u32 committed;
@@ -1757,6 +1816,12 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 			}
 		}
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


