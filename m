Return-Path: <netdev+bounces-100579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43308FB3A8
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD30288771
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38183146D76;
	Tue,  4 Jun 2024 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLXobIln"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F22146A72
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507499; cv=none; b=SC7D1uQGE+XZdJEQGM+LDWONX7zJH1YY3RB405a710EcqNnufCzVXROHSH6JG8fVWO1M21xUpmCFK4kkrDDlhil2UmJyk7Ecwrno5BxQedh/yc4/XTfbBYxXDAOhfOn5swg+C3N7avdI2qL0qH4coc5bVUx9555P4ynQs15B1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507499; c=relaxed/simple;
	bh=81I2iHtDz9t1goDTruHb5svHXzSGIly4lYqp39cNc+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IGre4z6s8sJZd6NJEBMtLG4aljF29W1xSlWgADquCw6CHcHLnRhn1uRIVyYeEzn8qx4zTM6poG+F0MijsABD8+L+1WsT1h9arWjvu95fFfHKwz3cD2YRYDoBJlabZu5THK/94SpV+Vsk1lvo9jl5F5ZFqjsIoZKr39l8SQfUyGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLXobIln; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507497; x=1749043497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=81I2iHtDz9t1goDTruHb5svHXzSGIly4lYqp39cNc+E=;
  b=gLXobIlnNqJuXUJo0wuckWMmjPTIMHVyVE4awp3IoU8z19SjzDqRLWNT
   Y2Q3YVc6OMUyYngerB6iqRs0muFX/gMoQlcTPgwf6wSXGumGKSEvhTuPh
   I3XcrzgqB/QkK1Cq8IaaPTJI9PJQT/dGdINp4UDm7EYa5dKS4IvwanPCe
   1GrtPtQtPxVecSI3sIUgVNZs9CexZ2OwP2I8x+kQe133fxCqabFcFXX/z
   BG8++1Cy+uyFDGb3gZ1zkb0Zn1t7SWT500zpTUio2o7LxTpGLFOAxMQoX
   ICxn6zS1lHGeWu1ijbaBhnVN92DzXyQtAkWoaDKB4ZfIgmF+1lOpc8NWp
   A==;
X-CSE-ConnectionGUID: kCJmwbIXRgiHHTE2ACuIVw==
X-CSE-MsgGUID: ezu4Ex1RRhGL6gpBkfvH5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14245379"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14245379"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:24:57 -0700
X-CSE-ConnectionGUID: yJV9fy8gRfe09oFTW8bgpg==
X-CSE-MsgGUID: xwB5Zf87Sc+1K6eZT7nY4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37109748"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 06:24:55 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 944D0125BA;
	Tue,  4 Jun 2024 14:24:46 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v7 03/12] virtchnl: add enumeration for the rxdid format
Date: Tue,  4 Jun 2024 09:13:51 -0400
Message-Id: <20240604131400.13655-4-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
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
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 include/linux/avf/virtchnl.h | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 48bdfa1dc893..13c5596233a4 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -304,6 +304,46 @@ struct virtchnl_txq_info {
 
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
+/* RX descriptor ID bitmasks */
+enum virtchnl_rx_desc_id_bitmasks {
+	VIRTCHNL_RXDID_0_16B_BASE_M		= BIT(VIRTCHNL_RXDID_0_16B_BASE),
+	VIRTCHNL_RXDID_1_32B_BASE_M		= BIT(VIRTCHNL_RXDID_1_32B_BASE),
+	VIRTCHNL_RXDID_2_FLEX_SQ_NIC_M		= BIT(VIRTCHNL_RXDID_2_FLEX_SQ_NIC),
+	VIRTCHNL_RXDID_3_FLEX_SQ_SW_M		= BIT(VIRTCHNL_RXDID_3_FLEX_SQ_SW),
+	VIRTCHNL_RXDID_4_FLEX_SQ_NIC_VEB_M	= BIT(VIRTCHNL_RXDID_4_FLEX_SQ_NIC_VEB),
+	VIRTCHNL_RXDID_5_FLEX_SQ_NIC_ACL_M	= BIT(VIRTCHNL_RXDID_5_FLEX_SQ_NIC_ACL),
+	VIRTCHNL_RXDID_6_FLEX_SQ_NIC_2_M	= BIT(VIRTCHNL_RXDID_6_FLEX_SQ_NIC_2),
+	VIRTCHNL_RXDID_7_HW_RSVD_M		= BIT(VIRTCHNL_RXDID_7_HW_RSVD),
+	/* 8 through 15 are reserved */
+	VIRTCHNL_RXDID_16_COMMS_GENERIC_M	= BIT(VIRTCHNL_RXDID_16_COMMS_GENERIC),
+	VIRTCHNL_RXDID_17_COMMS_AUX_VLAN_M	= BIT(VIRTCHNL_RXDID_17_COMMS_AUX_VLAN),
+	VIRTCHNL_RXDID_18_COMMS_AUX_IPV4_M	= BIT(VIRTCHNL_RXDID_18_COMMS_AUX_IPV4),
+	VIRTCHNL_RXDID_19_COMMS_AUX_IPV6_M	= BIT(VIRTCHNL_RXDID_19_COMMS_AUX_IPV6),
+	VIRTCHNL_RXDID_20_COMMS_AUX_FLOW_M	= BIT(VIRTCHNL_RXDID_20_COMMS_AUX_FLOW),
+	VIRTCHNL_RXDID_21_COMMS_AUX_TCP_M	= BIT(VIRTCHNL_RXDID_21_COMMS_AUX_TCP),
+	/* 22 through 63 are reserved */
+};
+
 /* virtchnl_rxq_info_flags
  *
  * Definition of bits in the flags field of the virtchnl_rxq_info structure.
@@ -338,6 +378,11 @@ struct virtchnl_rxq_info {
 	u32 databuffer_size;
 	u32 max_pkt_size;
 	u8 crc_disable;
+	/* see enum virtchnl_rx_desc_ids;
+	 * only used when VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is supported. Note
+	 * that when the offload is not supported, the descriptor format aligns
+	 * with VIRTCHNL_RXDID_1_32B_BASE.
+	 */
 	u8 rxdid;
 	u8 flags; /* see virtchnl_rxq_info_flags */
 	u8 pad1;
@@ -1041,6 +1086,7 @@ struct virtchnl_filter {
 VIRTCHNL_CHECK_STRUCT_LEN(272, virtchnl_filter);
 
 struct virtchnl_supported_rxdids {
+	/* see enum virtchnl_rx_desc_id_bitmasks */
 	u64 supported_rxdids;
 };
 
-- 
2.38.1


