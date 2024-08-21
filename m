Return-Path: <netdev+bounces-120532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B28959B88
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0620BB2105C
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7650166F35;
	Wed, 21 Aug 2024 12:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLVg5MPh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D86166F05
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242713; cv=none; b=DXw82ysSCQ6ScFglqmlqCRmGC5kPuNtRrOsqDP4JF+1wftoexHCGSG+iTXwbefPGuShWIMidWw67wNjm7qjq6zB6r5Z7h17T/B9vyzQxlDVxUiLXs7hxDnJVHf2IeJfcJ3WiGhIDh74IBWcpNNT7jdk/J9PJc7f3ZDyuvgN58H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242713; c=relaxed/simple;
	bh=eeWpNUEtHwl1UW83kq0zMpxHlsNCR4GJm/L6p6M5ojQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaDWBCOtn4y+Zqvqu0Q/v7MU4nEn15PHBtxt0BS646eZIuOQ6YpXzcBm6+HwqXH02zyKP9Gu1nvlgIMjY2k+SqhVWUyQTOJn8Yjdub2Xki3LtAGX5yQh0GnqZgAH8uj7b4Gi5K5tTL94AQSGseFdmtXWP7ZfxqG3ImZ1sXIZThs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLVg5MPh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242712; x=1755778712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeWpNUEtHwl1UW83kq0zMpxHlsNCR4GJm/L6p6M5ojQ=;
  b=kLVg5MPhIVer4IuP9XF28jpHeqmz5hUOBuPa7qvE9qqXTwA6VOPh791O
   Pzb6CXm/TMIO1UpH6FlaqQRNKWBI7iskfvRJTDO5XqWqbibmc+1GzyEP8
   2yCH1AXlykvqC68+alQgg5XF5kFUeTuIvr2mxLgr+yOpCs3fCsyeVMg3P
   D78CjxqJUm88UdZpv8gjm42FT1n0ediRYF68S5IeomFHUm3vgROyHUizj
   U15TsYT285X4Fixj5pfyeZOc8cIxgn5uRe05MfsFuhnDLGBnFqA8Bh6Yw
   R5G1mCY39MAlHfX+kS+buV848z/IH8cAmrv+IEgY8L/yhfA14SzuQZxIv
   Q==;
X-CSE-ConnectionGUID: MG22y+mYQ5a1ARE/HtDbfw==
X-CSE-MsgGUID: 4o5Ru3ZAQ1+KUcDoq2qqcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="34017079"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="34017079"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:18:18 -0700
X-CSE-ConnectionGUID: Q0jtz/h3ShawTlhSI7UOdw==
X-CSE-MsgGUID: QuyQWHd1Qn28+G5h/chG3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60732478"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 21 Aug 2024 05:18:15 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6E5E72878D;
	Wed, 21 Aug 2024 13:18:14 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	alexandr.lobakin@intel.com
Subject: [PATCH iwl-next v10 03/14] virtchnl: add enumeration for the rxdid format
Date: Wed, 21 Aug 2024 14:15:28 +0200
Message-Id: <20240821121539.374343-4-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240821121539.374343-1-wojciech.drewek@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
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
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 include/linux/avf/virtchnl.h | 50 +++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 012ed2f5f9d0..2b8f915df012 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -304,6 +304,48 @@ struct virtchnl_txq_info {
 
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
@@ -338,7 +380,12 @@ struct virtchnl_rxq_info {
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
@@ -1041,6 +1088,7 @@ struct virtchnl_filter {
 VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
 
 struct virtchnl_supported_rxdids {
+	/* see enum virtchnl_rx_desc_id_bitmasks */
 	u64 supported_rxdids;
 };
 
-- 
2.40.1


