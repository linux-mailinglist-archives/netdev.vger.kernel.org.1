Return-Path: <netdev+bounces-142343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060AF9BE5B3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABA3284FD6
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0EE1DF25B;
	Wed,  6 Nov 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2r9YZHq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA11DEFE0
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893075; cv=none; b=QEx9HveMaLp/JjHTlIO1Q9hTqVgrvYPOwj1Agdqm0IAX5aSggOBoNwAiIA0lCWp73aWHGLhE+O403eccGVR+tfxC7mPhttF8SLG9P0o50Nbo12/Ttlz0drAfXH87flT7ZFRXhWlFPQrqrVw6L8BvX6l3vaKuZMfdL91R78ncfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893075; c=relaxed/simple;
	bh=qSWjsbjqicz0FQcH11ozrCOdbtTMfnlkPpVeudoT/T8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rt2YXn0L2Q/YSvaX16SrF0MjxKJRAUAEhWNv59ILM0iIXRVPzwS9+4uVVxhmV8c4Z+zgrmDQuDtaAanqmonCT9ELoF7pC3gEbaG9TT+AEcr9mDXnPiYWa3T3fo1SSq4gFUCrPvflmNAqtz1B8840Myi/moJuaVOQsaZMG5apCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2r9YZHq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730893073; x=1762429073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qSWjsbjqicz0FQcH11ozrCOdbtTMfnlkPpVeudoT/T8=;
  b=X2r9YZHqHQLwxNAA9Et/VLgBg8V0Yg7o74SUL74XAV39BxY90xyrvCyQ
   joJ7UgxoOgnliwK0Cbx1aT8U5c/AUYiDA0Nfb+6wGmLySV4X50lUlYlMd
   DVGHqor642HNTWF0/ozTwEDjfRdzNCXo/oQIoQlDzk40w1u27r8TtX7mB
   Vu5EQNan5q6wYZ/ICtxP0kso+2jSOO+xN33lELZDfa93AvaUn8BJtYeeB
   s5BD2RH2RfTFBTwLbkZqqCt+pCmGngYeSCLJTn/+msnAS7J70YnfAdoIg
   yb90WMA2jfpphnx1W2hCcahieNd4Jy+U5d38xUKqqi8phgBzSdiu994v2
   w==;
X-CSE-ConnectionGUID: lRIH+vIpQJiMRsOuzfYQ1A==
X-CSE-MsgGUID: 4LcqQRBxSZOOvUUPsVgC3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30455501"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30455501"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:37:51 -0800
X-CSE-ConnectionGUID: uESQA7CAR+yp7l/T/bqMSA==
X-CSE-MsgGUID: U6OXioeORNSfEac5Kp9IOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="122020122"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2024 03:37:49 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 899C328778;
	Wed,  6 Nov 2024 11:37:47 +0000 (GMT)
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
Subject: [Intel-wired-lan] [PATCH iwl-next v13 03/14] virtchnl: add enumeration for the rxdid format
Date: Wed,  6 Nov 2024 12:37:20 -0500
Message-Id: <20241106173731.4272-4-mateusz.polchlopek@intel.com>
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

Support for allowing VF to negotiate the descriptor format requires that
the VF specify which descriptor format to use when requesting Rx queues.
The VF is supposed to request the set of supported formats via the new
VIRTCHNL_OP_GET_SUPPORTED_RXDIDS, and then set one of the supported
formats in the rxdid field of the virtchnl_rxq_info structure.

The virtchnl.h header does not provide an enumeration of the format
values. The existing implementations in the PF directly use the values
from the DDP package.

Make the formats explicit by defining an enumeration of the RXDIDs.
Provide an enumeration for the values as well as the bit positions as
returned by the supported_rxdids data from the
VIRTCHNL_OP_GET_SUPPORTED_RXDIDS.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 include/linux/avf/virtchnl.h | 50 +++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 56baf97c44d0..bc10e6ffa50b 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -313,6 +313,48 @@ struct virtchnl_txq_info {
 
 VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
 
+/* RX descriptor IDs (range from 0 to 63) */
+enum virtchnl_rx_desc_ids {
+	VIRTCHNL_RXDID_0_16B_BASE		= 0,
+	VIRTCHNL_RXDID_1_32B_BASE		= 1,
+	VIRTCHNL_RXDID_2_FLEX_SQ_NIC		= 2,
+	VIRTCHNL_RXDID_3_FLEX_SQ_SW		= 3,
+	VIRTCHNL_RXDID_4_FLEX_SQ_NIC_VEB	= 4,
+	VIRTCHNL_RXDID_5_FLEX_SQ_NIC_ACL	= 5,
+	VIRTCHNL_RXDID_6_FLEX_SQ_NIC_2		= 6,
+	VIRTCHNL_RXDID_7_HW_RSVD		= 7,
+	/* 8 through 15 are reserved */
+	VIRTCHNL_RXDID_16_COMMS_GENERIC		= 16,
+	VIRTCHNL_RXDID_17_COMMS_AUX_VLAN	= 17,
+	VIRTCHNL_RXDID_18_COMMS_AUX_IPV4	= 18,
+	VIRTCHNL_RXDID_19_COMMS_AUX_IPV6	= 19,
+	VIRTCHNL_RXDID_20_COMMS_AUX_FLOW	= 20,
+	VIRTCHNL_RXDID_21_COMMS_AUX_TCP		= 21,
+	/* 22 through 63 are reserved */
+};
+
+#define VIRTCHNL_RXDID_BIT(x)			BIT_ULL(VIRTCHNL_RXDID_##x)
+
+/* RX descriptor ID bitmasks */
+enum virtchnl_rx_desc_id_bitmasks {
+	VIRTCHNL_RXDID_0_16B_BASE_M		= VIRTCHNL_RXDID_BIT(0_16B_BASE),
+	VIRTCHNL_RXDID_1_32B_BASE_M		= VIRTCHNL_RXDID_BIT(1_32B_BASE),
+	VIRTCHNL_RXDID_2_FLEX_SQ_NIC_M		= VIRTCHNL_RXDID_BIT(2_FLEX_SQ_NIC),
+	VIRTCHNL_RXDID_3_FLEX_SQ_SW_M		= VIRTCHNL_RXDID_BIT(3_FLEX_SQ_SW),
+	VIRTCHNL_RXDID_4_FLEX_SQ_NIC_VEB_M	= VIRTCHNL_RXDID_BIT(4_FLEX_SQ_NIC_VEB),
+	VIRTCHNL_RXDID_5_FLEX_SQ_NIC_ACL_M	= VIRTCHNL_RXDID_BIT(5_FLEX_SQ_NIC_ACL),
+	VIRTCHNL_RXDID_6_FLEX_SQ_NIC_2_M	= VIRTCHNL_RXDID_BIT(6_FLEX_SQ_NIC_2),
+	VIRTCHNL_RXDID_7_HW_RSVD_M		= VIRTCHNL_RXDID_BIT(7_HW_RSVD),
+	/* 8 through 15 are reserved */
+	VIRTCHNL_RXDID_16_COMMS_GENERIC_M	= VIRTCHNL_RXDID_BIT(16_COMMS_GENERIC),
+	VIRTCHNL_RXDID_17_COMMS_AUX_VLAN_M	= VIRTCHNL_RXDID_BIT(17_COMMS_AUX_VLAN),
+	VIRTCHNL_RXDID_18_COMMS_AUX_IPV4_M	= VIRTCHNL_RXDID_BIT(18_COMMS_AUX_IPV4),
+	VIRTCHNL_RXDID_19_COMMS_AUX_IPV6_M	= VIRTCHNL_RXDID_BIT(19_COMMS_AUX_IPV6),
+	VIRTCHNL_RXDID_20_COMMS_AUX_FLOW_M	= VIRTCHNL_RXDID_BIT(20_COMMS_AUX_FLOW),
+	VIRTCHNL_RXDID_21_COMMS_AUX_TCP_M	= VIRTCHNL_RXDID_BIT(21_COMMS_AUX_TCP),
+	/* 22 through 63 are reserved */
+};
+
 /* virtchnl_rxq_info_flags - definition of bits in the flags field of the
  *			     virtchnl_rxq_info structure.
  *
@@ -347,7 +389,12 @@ struct virtchnl_rxq_info {
 	u32 databuffer_size;
 	u32 max_pkt_size;
 	u8 crc_disable;
-	u8 rxdid;
+	/* see enum virtchnl_rx_desc_ids;
+	 * only used when VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is supported. Note
+	 * that when the offload is not supported, the descriptor format aligns
+	 * with VIRTCHNL_RXDID_1_32B_BASE.
+	 */
+	enum virtchnl_rx_desc_ids rxdid:8;
 	enum virtchnl_rxq_info_flags flags:8; /* see virtchnl_rxq_info_flags */
 	u8 pad1;
 	u64 dma_ring_addr;
@@ -1050,6 +1097,7 @@ struct virtchnl_filter {
 VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
 
 struct virtchnl_supported_rxdids {
+	/* see enum virtchnl_rx_desc_id_bitmasks */
 	u64 supported_rxdids;
 };
 
-- 
2.38.1


