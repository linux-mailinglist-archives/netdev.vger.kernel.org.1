Return-Path: <netdev+bounces-236535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7EC3DB2B
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 23:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D433B3851
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE034E763;
	Thu,  6 Nov 2025 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxkPPXnH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506834A785
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469613; cv=none; b=HGk7XUbXdE3PFDJgjbHhi7xIDMbCajHa97AhfRYAdCnIUmhturbuE0VCTV+JRxCQzM2iRXP6gX9XL2qKvLuOxEg5w8rzTSm810w+c4SX6cu2765xqk2l3u9scftOmvQiW003fO8RV7JP6LTR3loW/5iVDevQEXNpqWzRwdWcfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469613; c=relaxed/simple;
	bh=za12kBrGmLpjbXxiBygwXYdfFRUumgbtnNk0+kFARHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VValze7ZwzJ+/9S0TTuEcApTxFqxfSkHQHSL/s5ZbWcJ0eNS/eO/gz7NswQ8D3JFPk/XRNwiTtp0U+YA0aoJpiJ+uzBJEX4NxpXeKgP6dUZmGM/Bz/MmjYc/htTXFfGUhNcjRkHIrA4fjZZsnVO/EKyavcUAyULIzLBm6xGa9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxkPPXnH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762469611; x=1794005611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=za12kBrGmLpjbXxiBygwXYdfFRUumgbtnNk0+kFARHo=;
  b=CxkPPXnH6jKSaRVUiPyARH7voXRq0JrsHaj7kepMUnNek7dnCSWwuKEL
   mO1zWaANLAGOP+FPzMzVzqlP9k0Vnt6Ml7Dou4O4dKuJgjjP8OSHqsYdG
   qNeo+sKDK+FGl8VqMQVLcjif5shlkS6q8n7vhCwgTxdLDQtL4w10Ukdcm
   0LbPkJUvZ59qusex+571D1x5DoE47vksfegstsAesztQwnraWSjSKoalJ
   yxKpks+R33ZPRLXmSFpUNQNHQBeQctC4iEEkN6LnNwHSUqJD+5HjTuOTe
   gkUo0CyGkod1bxxepKa61eo6CSzDG1KoeD7Ct6PprcfhmYc+sKkYlcXBS
   g==;
X-CSE-ConnectionGUID: QIyST6tJSFCLcHvZ1qRq/w==
X-CSE-MsgGUID: jw2FTty+RUyxzTD6wz+h+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="64715897"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="64715897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 14:53:29 -0800
X-CSE-ConnectionGUID: BQCs+4UVSnGKmIL6ZQ72Lg==
X-CSE-MsgGUID: UBUjfbl9SxeUaCgkBA9j+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; 
   d="scan'208";a="188602823"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 06 Nov 2025 14:53:28 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Junfeng Guo <junfeng.guo@intel.com>,
	Ting Xu <ting.xu@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 3/8] ice: add flow parsing for GTP and new protocol field support
Date: Thu,  6 Nov 2025 14:53:12 -0800
Message-ID: <20251106225321.1609605-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
References: <20251106225321.1609605-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Introduce new protocol header types and field sizes to support GTPU, GTPC
tunneling protocols.

 - Add field size macros for GTP TEID, QFI, and other headers
 - Extend ice_flow_field_info and enum definitions
 - Update hash macros for new protocols
 - Add support for IPv6 prefix matching and fragment headers

This patch lays the groundwork for enhanced RSS and flow classification
capabilities.

Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
Co-developed-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Ting Xu <ting.xu@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flow.c     | 217 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_flow.h     |  94 +++++++-
 .../ethernet/intel/ice/ice_protocol_type.h    |  20 ++
 3 files changed, 322 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 6d5c939dc8a5..a2f2a612428d 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -5,6 +5,38 @@
 #include "ice_flow.h"
 #include <net/gre.h>
 
+/* Size of known protocol header fields */
+#define ICE_FLOW_FLD_SZ_ETH_TYPE	2
+#define ICE_FLOW_FLD_SZ_VLAN		2
+#define ICE_FLOW_FLD_SZ_IPV4_ADDR	4
+#define ICE_FLOW_FLD_SZ_IPV6_ADDR	16
+#define ICE_FLOW_FLD_SZ_IPV6_PRE32_ADDR	4
+#define ICE_FLOW_FLD_SZ_IPV6_PRE48_ADDR	6
+#define ICE_FLOW_FLD_SZ_IPV6_PRE64_ADDR	8
+#define ICE_FLOW_FLD_SZ_IPV4_ID		2
+#define ICE_FLOW_FLD_SZ_IPV6_ID		4
+#define ICE_FLOW_FLD_SZ_IP_CHKSUM	2
+#define ICE_FLOW_FLD_SZ_TCP_CHKSUM	2
+#define ICE_FLOW_FLD_SZ_UDP_CHKSUM	2
+#define ICE_FLOW_FLD_SZ_SCTP_CHKSUM	4
+#define ICE_FLOW_FLD_SZ_IP_DSCP		1
+#define ICE_FLOW_FLD_SZ_IP_TTL		1
+#define ICE_FLOW_FLD_SZ_IP_PROT		1
+#define ICE_FLOW_FLD_SZ_PORT		2
+#define ICE_FLOW_FLD_SZ_TCP_FLAGS	1
+#define ICE_FLOW_FLD_SZ_ICMP_TYPE	1
+#define ICE_FLOW_FLD_SZ_ICMP_CODE	1
+#define ICE_FLOW_FLD_SZ_ARP_OPER	2
+#define ICE_FLOW_FLD_SZ_GRE_KEYID	4
+#define ICE_FLOW_FLD_SZ_GTP_TEID	4
+#define ICE_FLOW_FLD_SZ_GTP_QFI		2
+#define ICE_FLOW_FLD_SZ_PFCP_SEID 8
+#define ICE_FLOW_FLD_SZ_ESP_SPI	4
+#define ICE_FLOW_FLD_SZ_AH_SPI	4
+#define ICE_FLOW_FLD_SZ_NAT_T_ESP_SPI	4
+#define ICE_FLOW_FLD_SZ_L2TPV2_SESS_ID	2
+#define ICE_FLOW_FLD_SZ_L2TPV2_LEN_SESS_ID	2
+
 /* Describe properties of a protocol header field */
 struct ice_flow_field_info {
 	enum ice_flow_seg_hdr hdr;
@@ -20,6 +52,7 @@ struct ice_flow_field_info {
 	.mask = 0, \
 }
 
+/* QFI: 6-bit field in GTP-U PDU Session Container (3GPP TS 38.415) */
 #define ICE_FLOW_FLD_INFO_MSK(_hdr, _offset_bytes, _size_bytes, _mask) { \
 	.hdr = _hdr, \
 	.off = (_offset_bytes) * BITS_PER_BYTE, \
@@ -61,7 +94,33 @@ struct ice_flow_field_info ice_flds_info[ICE_FLOW_FIELD_IDX_MAX] = {
 	/* ICE_FLOW_FIELD_IDX_IPV6_SA */
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 8, sizeof(struct in6_addr)),
 	/* ICE_FLOW_FIELD_IDX_IPV6_DA */
-	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 24, sizeof(struct in6_addr)),
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 24, ICE_FLOW_FLD_SZ_IPV6_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV4_CHKSUM */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV4, 10, ICE_FLOW_FLD_SZ_IP_CHKSUM),
+	/* ICE_FLOW_FIELD_IDX_IPV4_FRAG */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV_FRAG, 4,
+			  ICE_FLOW_FLD_SZ_IPV4_ID),
+	/* ICE_FLOW_FIELD_IDX_IPV6_FRAG */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV_FRAG, 4,
+			  ICE_FLOW_FLD_SZ_IPV6_ID),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE32_SA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 8,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE32_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE32_DA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 24,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE32_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE48_SA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 8,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE48_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE48_DA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 24,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE48_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE64_SA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 8,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE64_ADDR),
+	/* ICE_FLOW_FIELD_IDX_IPV6_PRE64_DA */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_IPV6, 24,
+			  ICE_FLOW_FLD_SZ_IPV6_PRE64_ADDR),
 	/* Transport */
 	/* ICE_FLOW_FIELD_IDX_TCP_SRC_PORT */
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_TCP, 0, sizeof(__be16)),
@@ -76,7 +135,14 @@ struct ice_flow_field_info ice_flds_info[ICE_FLOW_FIELD_IDX_MAX] = {
 	/* ICE_FLOW_FIELD_IDX_SCTP_DST_PORT */
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_SCTP, 2, sizeof(__be16)),
 	/* ICE_FLOW_FIELD_IDX_TCP_FLAGS */
-	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_TCP, 13, 1),
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_TCP, 13, ICE_FLOW_FLD_SZ_TCP_FLAGS),
+	/* ICE_FLOW_FIELD_IDX_TCP_CHKSUM */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_TCP, 16, ICE_FLOW_FLD_SZ_TCP_CHKSUM),
+	/* ICE_FLOW_FIELD_IDX_UDP_CHKSUM */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_UDP, 6, ICE_FLOW_FLD_SZ_UDP_CHKSUM),
+	/* ICE_FLOW_FIELD_IDX_SCTP_CHKSUM */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_SCTP, 8,
+			  ICE_FLOW_FLD_SZ_SCTP_CHKSUM),
 	/* ARP */
 	/* ICE_FLOW_FIELD_IDX_ARP_SIP */
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_ARP, 14, sizeof(struct in_addr)),
@@ -108,9 +174,17 @@ struct ice_flow_field_info ice_flds_info[ICE_FLOW_FIELD_IDX_MAX] = {
 	ICE_FLOW_FLD_INFO_MSK(ICE_FLOW_SEG_HDR_GTPU_EH, 22, sizeof(__be16),
 			      0x3f00),
 	/* ICE_FLOW_FIELD_IDX_GTPU_UP_TEID */
-	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_GTPU_UP, 12, sizeof(__be32)),
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_GTPU_UP, 12,
+			  ICE_FLOW_FLD_SZ_GTP_TEID),
+	/* ICE_FLOW_FIELD_IDX_GTPU_UP_QFI */
+	ICE_FLOW_FLD_INFO_MSK(ICE_FLOW_SEG_HDR_GTPU_UP, 22,
+			      ICE_FLOW_FLD_SZ_GTP_QFI, 0x3f00),
 	/* ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID */
-	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_GTPU_DWN, 12, sizeof(__be32)),
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_GTPU_DWN, 12,
+			  ICE_FLOW_FLD_SZ_GTP_TEID),
+	/* ICE_FLOW_FIELD_IDX_GTPU_DWN_QFI */
+	ICE_FLOW_FLD_INFO_MSK(ICE_FLOW_SEG_HDR_GTPU_DWN, 22,
+			      ICE_FLOW_FLD_SZ_GTP_QFI, 0x3f00),
 	/* PPPoE */
 	/* ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID */
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_PPPOE, 2, sizeof(__be16)),
@@ -128,7 +202,16 @@ struct ice_flow_field_info ice_flds_info[ICE_FLOW_FIELD_IDX_MAX] = {
 	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_AH, 4, sizeof(__be32)),
 	/* NAT_T_ESP */
 	/* ICE_FLOW_FIELD_IDX_NAT_T_ESP_SPI */
-	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_NAT_T_ESP, 8, sizeof(__be32)),
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_NAT_T_ESP, 8,
+			  ICE_FLOW_FLD_SZ_NAT_T_ESP_SPI),
+	/* L2TPV2 */
+	/* ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_L2TPV2, 12,
+			  ICE_FLOW_FLD_SZ_L2TPV2_SESS_ID),
+	/* L2TPV2_LEN */
+	/* ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID */
+	ICE_FLOW_FLD_INFO(ICE_FLOW_SEG_HDR_L2TPV2, 14,
+			  ICE_FLOW_FLD_SZ_L2TPV2_LEN_SESS_ID),
 };
 
 /* Bitmaps indicating relevant packet types for a particular protocol header
@@ -2324,6 +2407,130 @@ static void ice_rss_set_symm(struct ice_hw *hw, struct ice_flow_prof *prof)
 	}
 }
 
+/**
+ * ice_rss_cfg_raw_symm - Configure symmetric RSS for a raw parser profile
+ * @hw:      device HW
+ * @prof:    parser profile describing extracted FV (field vector) entries
+ * @prof_id: RSS profile identifier used to program symmetry registers
+ *
+ * The routine scans the parser profile's FV entries and looks for
+ * direction-sensitive pairs (L3 src/dst, L4 src/dst). When a pair is found,
+ * it programs XOR-based symmetry so that flows hash identically regardless
+ * of packet direction. This preserves CPU affinity for the same 5-tuple.
+ *
+ * Notes:
+ * - The size of each logical field (IPv4/IPv6 address, L4 port) is expressed
+ *   in units of ICE_FLOW_FV_EXTRACT_SZ so we can step across fv[] correctly.
+ * - We guard against out-of-bounds access before looking at fv[i + len].
+ */
+static void ice_rss_cfg_raw_symm(struct ice_hw *hw,
+				 const struct ice_parser_profile *prof,
+				 u64 prof_id)
+{
+	for (size_t i = 0; i < prof->fv_num; i++) {
+		u8 proto_id = prof->fv[i].proto_id;
+		u16 src_off = 0, dst_off = 0;
+		size_t src_idx, dst_idx;
+		bool is_matched = false;
+		unsigned int len = 0;
+
+		switch (proto_id) {
+		/* IPv4 address pairs (outer/inner variants) */
+		case ICE_PROT_IPV4_OF_OR_S:
+		case ICE_PROT_IPV4_IL:
+		case ICE_PROT_IPV4_IL_IL:
+			len = ICE_FLOW_FLD_SZ_IPV4_ADDR /
+			      ICE_FLOW_FV_EXTRACT_SZ;
+			src_off = ICE_FLOW_FIELD_IPV4_SRC_OFFSET;
+			dst_off = ICE_FLOW_FIELD_IPV4_DST_OFFSET;
+			break;
+
+		/* IPv6 address pairs (outer/inner variants) */
+		case ICE_PROT_IPV6_OF_OR_S:
+		case ICE_PROT_IPV6_IL:
+		case ICE_PROT_IPV6_IL_IL:
+			len = ICE_FLOW_FLD_SZ_IPV6_ADDR /
+			      ICE_FLOW_FV_EXTRACT_SZ;
+			src_off = ICE_FLOW_FIELD_IPV6_SRC_OFFSET;
+			dst_off = ICE_FLOW_FIELD_IPV6_DST_OFFSET;
+			break;
+
+		/* L4 port pairs (TCP/UDP/SCTP) */
+		case ICE_PROT_TCP_IL:
+		case ICE_PROT_UDP_IL_OR_S:
+		case ICE_PROT_SCTP_IL:
+			len = ICE_FLOW_FLD_SZ_PORT / ICE_FLOW_FV_EXTRACT_SZ;
+			src_off = ICE_FLOW_FIELD_SRC_PORT_OFFSET;
+			dst_off = ICE_FLOW_FIELD_DST_PORT_OFFSET;
+			break;
+
+		default:
+			continue;
+		}
+
+		/* Bounds check before accessing fv[i + len]. */
+		if (i + len >= prof->fv_num)
+			continue;
+
+		/* Verify src/dst pairing for this protocol id. */
+		is_matched = prof->fv[i].offset == src_off &&
+			     prof->fv[i + len].proto_id == proto_id &&
+			     prof->fv[i + len].offset == dst_off;
+		if (!is_matched)
+			continue;
+
+		/* Program XOR symmetry for this field pair. */
+		src_idx = i;
+		dst_idx = i + len;
+
+		ice_rss_config_xor(hw, prof_id, src_idx, dst_idx, len);
+
+		/* Skip over the pair we just handled; the loop's ++i advances
+		 * one more element, hence the --i after the jump.
+		 */
+		i += (2 * len);
+		/* not strictly needed; keeps static analyzers happy */
+		if (i == 0)
+			break;
+		--i;
+	}
+}
+
+/* Max registers index per packet profile */
+#define ICE_SYMM_REG_INDEX_MAX 6
+
+/**
+ * ice_rss_update_raw_symm - update symmetric hash configuration
+ * for raw pattern
+ * @hw: pointer to the hardware structure
+ * @cfg: configure parameters for raw pattern
+ * @id: profile tracking ID
+ *
+ * Update symmetric hash configuration for raw pattern if required.
+ * Otherwise only clear to default.
+ */
+void
+ice_rss_update_raw_symm(struct ice_hw *hw,
+			struct ice_rss_raw_cfg *cfg, u64 id)
+{
+	struct ice_prof_map *map;
+	u8 prof_id, m;
+
+	mutex_lock(&hw->blk[ICE_BLK_RSS].es.prof_map_lock);
+	map = ice_search_prof_id(hw, ICE_BLK_RSS, id);
+	if (map)
+		prof_id = map->prof_id;
+	mutex_unlock(&hw->blk[ICE_BLK_RSS].es.prof_map_lock);
+	if (!map)
+		return;
+	/* clear to default */
+	for (m = 0; m < ICE_SYMM_REG_INDEX_MAX; m++)
+		wr32(hw, GLQF_HSYMM(prof_id, m), 0);
+
+	if (cfg->symm)
+		ice_rss_cfg_raw_symm(hw, &cfg->prof, prof_id);
+}
+
 /**
  * ice_add_rss_cfg_sync - add an RSS configuration
  * @hw: pointer to the hardware structure
diff --git a/drivers/net/ethernet/intel/ice/ice_flow.h b/drivers/net/ethernet/intel/ice/ice_flow.h
index 52f906d89eca..6c6cdc8addb1 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.h
+++ b/drivers/net/ethernet/intel/ice/ice_flow.h
@@ -22,6 +22,15 @@
 #define ICE_FLOW_HASH_IPV6	\
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_SA) | \
 	 BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_DA))
+#define ICE_FLOW_HASH_IPV6_PRE32	\
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE32_SA) | \
+	 BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE32_DA))
+#define ICE_FLOW_HASH_IPV6_PRE48	\
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE48_SA) | \
+	 BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE48_DA))
+#define ICE_FLOW_HASH_IPV6_PRE64	\
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE64_SA) | \
+	 BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PRE64_DA))
 #define ICE_FLOW_HASH_TCP_PORT	\
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_TCP_SRC_PORT) | \
 	 BIT_ULL(ICE_FLOW_FIELD_IDX_TCP_DST_PORT))
@@ -40,6 +49,33 @@
 #define ICE_HASH_SCTP_IPV4	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_SCTP_PORT)
 #define ICE_HASH_SCTP_IPV6	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_SCTP_PORT)
 
+#define ICE_HASH_TCP_IPV6_PRE32	 \
+	(ICE_FLOW_HASH_IPV6_PRE32 | ICE_FLOW_HASH_TCP_PORT)
+#define ICE_HASH_UDP_IPV6_PRE32	 \
+	(ICE_FLOW_HASH_IPV6_PRE32 | ICE_FLOW_HASH_UDP_PORT)
+#define ICE_HASH_SCTP_IPV6_PRE32 \
+	(ICE_FLOW_HASH_IPV6_PRE32 | ICE_FLOW_HASH_SCTP_PORT)
+#define ICE_HASH_TCP_IPV6_PRE48	 \
+	(ICE_FLOW_HASH_IPV6_PRE48 | ICE_FLOW_HASH_TCP_PORT)
+#define ICE_HASH_UDP_IPV6_PRE48	 \
+	(ICE_FLOW_HASH_IPV6_PRE48 | ICE_FLOW_HASH_UDP_PORT)
+#define ICE_HASH_SCTP_IPV6_PRE48 \
+	(ICE_FLOW_HASH_IPV6_PRE48 | ICE_FLOW_HASH_SCTP_PORT)
+#define ICE_HASH_TCP_IPV6_PRE64	 \
+	(ICE_FLOW_HASH_IPV6_PRE64 | ICE_FLOW_HASH_TCP_PORT)
+#define ICE_HASH_UDP_IPV6_PRE64	 \
+	(ICE_FLOW_HASH_IPV6_PRE64 | ICE_FLOW_HASH_UDP_PORT)
+#define ICE_HASH_SCTP_IPV6_PRE64 \
+	(ICE_FLOW_HASH_IPV6_PRE64 | ICE_FLOW_HASH_SCTP_PORT)
+
+#define ICE_FLOW_HASH_GTP_TEID \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID))
+
+#define ICE_FLOW_HASH_GTP_IPV4_TEID \
+	(ICE_FLOW_HASH_IPV4 | ICE_FLOW_HASH_GTP_TEID)
+#define ICE_FLOW_HASH_GTP_IPV6_TEID \
+	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_GTP_TEID)
+
 #define ICE_FLOW_HASH_GTP_C_TEID \
 	(BIT_ULL(ICE_FLOW_FIELD_IDX_GTPC_TEID))
 
@@ -128,6 +164,23 @@
 #define ICE_FLOW_HASH_NAT_T_ESP_IPV6_SPI \
 	(ICE_FLOW_HASH_IPV6 | ICE_FLOW_HASH_NAT_T_ESP_SPI)
 
+#define ICE_FLOW_HASH_L2TPV2_SESS_ID \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID))
+#define ICE_FLOW_HASH_L2TPV2_SESS_ID_ETH \
+	(ICE_FLOW_HASH_ETH | ICE_FLOW_HASH_L2TPV2_SESS_ID)
+
+#define ICE_FLOW_HASH_L2TPV2_LEN_SESS_ID \
+	(BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID))
+#define ICE_FLOW_HASH_L2TPV2_LEN_SESS_ID_ETH \
+	(ICE_FLOW_HASH_ETH | ICE_FLOW_HASH_L2TPV2_LEN_SESS_ID)
+
+#define ICE_FLOW_FIELD_IPV4_SRC_OFFSET 12
+#define ICE_FLOW_FIELD_IPV4_DST_OFFSET 16
+#define ICE_FLOW_FIELD_IPV6_SRC_OFFSET 8
+#define ICE_FLOW_FIELD_IPV6_DST_OFFSET 24
+#define ICE_FLOW_FIELD_SRC_PORT_OFFSET 0
+#define ICE_FLOW_FIELD_DST_PORT_OFFSET 2
+
 /* Protocol header fields within a packet segment. A segment consists of one or
  * more protocol headers that make up a logical group of protocol headers. Each
  * logical group of protocol headers encapsulates or is encapsulated using/by
@@ -160,10 +213,13 @@ enum ice_flow_seg_hdr {
 	ICE_FLOW_SEG_HDR_AH		= 0x00200000,
 	ICE_FLOW_SEG_HDR_NAT_T_ESP	= 0x00400000,
 	ICE_FLOW_SEG_HDR_ETH_NON_IP	= 0x00800000,
+	ICE_FLOW_SEG_HDR_GTPU_NON_IP	= 0x01000000,
+	ICE_FLOW_SEG_HDR_L2TPV2		= 0x10000000,
 	/* The following is an additive bit for ICE_FLOW_SEG_HDR_IPV4 and
-	 * ICE_FLOW_SEG_HDR_IPV6 which include the IPV4 other PTYPEs
+	 * ICE_FLOW_SEG_HDR_IPV6.
 	 */
-	ICE_FLOW_SEG_HDR_IPV_OTHER      = 0x20000000,
+	ICE_FLOW_SEG_HDR_IPV_FRAG	= 0x40000000,
+	ICE_FLOW_SEG_HDR_IPV_OTHER	= 0x80000000,
 };
 
 /* These segments all have the same PTYPES, but are otherwise distinguished by
@@ -200,6 +256,15 @@ enum ice_flow_field {
 	ICE_FLOW_FIELD_IDX_IPV4_DA,
 	ICE_FLOW_FIELD_IDX_IPV6_SA,
 	ICE_FLOW_FIELD_IDX_IPV6_DA,
+	ICE_FLOW_FIELD_IDX_IPV4_CHKSUM,
+	ICE_FLOW_FIELD_IDX_IPV4_ID,
+	ICE_FLOW_FIELD_IDX_IPV6_ID,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE32_SA,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE32_DA,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE48_SA,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE48_DA,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE64_SA,
+	ICE_FLOW_FIELD_IDX_IPV6_PRE64_DA,
 	/* L4 */
 	ICE_FLOW_FIELD_IDX_TCP_SRC_PORT,
 	ICE_FLOW_FIELD_IDX_TCP_DST_PORT,
@@ -208,6 +273,9 @@ enum ice_flow_field {
 	ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT,
 	ICE_FLOW_FIELD_IDX_SCTP_DST_PORT,
 	ICE_FLOW_FIELD_IDX_TCP_FLAGS,
+	ICE_FLOW_FIELD_IDX_TCP_CHKSUM,
+	ICE_FLOW_FIELD_IDX_UDP_CHKSUM,
+	ICE_FLOW_FIELD_IDX_SCTP_CHKSUM,
 	/* ARP */
 	ICE_FLOW_FIELD_IDX_ARP_SIP,
 	ICE_FLOW_FIELD_IDX_ARP_DIP,
@@ -228,13 +296,13 @@ enum ice_flow_field {
 	ICE_FLOW_FIELD_IDX_GTPU_EH_QFI,
 	/* GTPU_UP */
 	ICE_FLOW_FIELD_IDX_GTPU_UP_TEID,
+	ICE_FLOW_FIELD_IDX_GTPU_UP_QFI,
 	/* GTPU_DWN */
 	ICE_FLOW_FIELD_IDX_GTPU_DWN_TEID,
-	/* PPPoE */
+	ICE_FLOW_FIELD_IDX_GTPU_DWN_QFI,
 	ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID,
 	/* PFCP */
 	ICE_FLOW_FIELD_IDX_PFCP_SEID,
-	/* L2TPv3 */
 	ICE_FLOW_FIELD_IDX_L2TPV3_SESS_ID,
 	/* ESP */
 	ICE_FLOW_FIELD_IDX_ESP_SPI,
@@ -242,10 +310,16 @@ enum ice_flow_field {
 	ICE_FLOW_FIELD_IDX_AH_SPI,
 	/* NAT_T ESP */
 	ICE_FLOW_FIELD_IDX_NAT_T_ESP_SPI,
+	/* L2TPV2 SESSION ID*/
+	ICE_FLOW_FIELD_IDX_L2TPV2_SESS_ID,
+	/* L2TPV2_LEN SESSION ID */
+	ICE_FLOW_FIELD_IDX_L2TPV2_LEN_SESS_ID,
 	 /* The total number of enums must not exceed 64 */
 	ICE_FLOW_FIELD_IDX_MAX
 };
 
+static_assert(ICE_FLOW_FIELD_IDX_MAX <= 64, "The total number of enums must not exceed 64");
+
 #define ICE_FLOW_HASH_FLD_IPV4_SA	BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_SA)
 #define ICE_FLOW_HASH_FLD_IPV6_SA	BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_SA)
 #define ICE_FLOW_HASH_FLD_IPV4_DA	BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_DA)
@@ -296,6 +370,10 @@ enum ice_rss_cfg_hdr_type {
 	/* take inner headers as inputset for packet with outer ipv6. */
 	ICE_RSS_INNER_HEADERS_W_OUTER_IPV6,
 	/* take outer headers first then inner headers as inputset */
+	/* take inner as inputset for GTPoGRE with outer IPv4 + GRE. */
+	ICE_RSS_INNER_HEADERS_W_OUTER_IPV4_GRE,
+	/* take inner as inputset for GTPoGRE with outer IPv6 + GRE. */
+	ICE_RSS_INNER_HEADERS_W_OUTER_IPV6_GRE,
 	ICE_RSS_ANY_HEADERS
 };
 
@@ -406,6 +484,12 @@ struct ice_flow_prof {
 	bool symm; /* Symmetric Hash for RSS */
 };
 
+struct ice_rss_raw_cfg {
+	struct ice_parser_profile prof;
+	bool raw_ena;
+	bool symm;
+};
+
 struct ice_rss_cfg {
 	struct list_head l_entry;
 	/* bitmap of VSIs added to the RSS entry */
@@ -444,4 +528,6 @@ int ice_add_rss_cfg(struct ice_hw *hw, struct ice_vsi *vsi,
 int ice_rem_rss_cfg(struct ice_hw *hw, u16 vsi_handle,
 		    const struct ice_rss_hash_cfg *cfg);
 u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs, bool *symm);
+void ice_rss_update_raw_symm(struct ice_hw *hw,
+			     struct ice_rss_raw_cfg *cfg, u64 id);
 #endif /* _ICE_FLOW_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_protocol_type.h b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
index 7c09ea0f03ba..725167d557a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_protocol_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_protocol_type.h
@@ -82,26 +82,46 @@ enum ice_sw_tunnel_type {
 enum ice_prot_id {
 	ICE_PROT_ID_INVAL	= 0,
 	ICE_PROT_MAC_OF_OR_S	= 1,
+	ICE_PROT_MAC_O2		= 2,
 	ICE_PROT_MAC_IL		= 4,
+	ICE_PROT_MAC_IN_MAC	= 7,
 	ICE_PROT_ETYPE_OL	= 9,
 	ICE_PROT_ETYPE_IL	= 10,
+	ICE_PROT_PAY		= 15,
+	ICE_PROT_EVLAN_O	= 16,
+	ICE_PROT_VLAN_O		= 17,
+	ICE_PROT_VLAN_IF	= 18,
+	ICE_PROT_MPLS_OL_MINUS_1 = 27,
+	ICE_PROT_MPLS_OL_OR_OS	= 28,
+	ICE_PROT_MPLS_IL	= 29,
 	ICE_PROT_IPV4_OF_OR_S	= 32,
 	ICE_PROT_IPV4_IL	= 33,
+	ICE_PROT_IPV4_IL_IL	= 34,
 	ICE_PROT_IPV6_OF_OR_S	= 40,
 	ICE_PROT_IPV6_IL	= 41,
+	ICE_PROT_IPV6_IL_IL	= 42,
+	ICE_PROT_IPV6_NEXT_PROTO = 43,
+	ICE_PROT_IPV6_FRAG	= 47,
 	ICE_PROT_TCP_IL		= 49,
 	ICE_PROT_UDP_OF		= 52,
 	ICE_PROT_UDP_IL_OR_S	= 53,
 	ICE_PROT_GRE_OF		= 64,
+	ICE_PROT_NSH_F		= 84,
 	ICE_PROT_ESP_F		= 88,
 	ICE_PROT_ESP_2		= 89,
 	ICE_PROT_SCTP_IL	= 96,
 	ICE_PROT_ICMP_IL	= 98,
 	ICE_PROT_ICMPV6_IL	= 100,
+	ICE_PROT_VRRP_F		= 101,
+	ICE_PROT_OSPF		= 102,
 	ICE_PROT_PPPOE		= 103,
 	ICE_PROT_L2TPV3		= 104,
+	ICE_PROT_ATAOE_OF	= 114,
+	ICE_PROT_CTRL_OF	= 116,
+	ICE_PROT_LLDP_OF	= 117,
 	ICE_PROT_ARP_OF		= 118,
 	ICE_PROT_META_ID	= 255, /* when offset == metadata */
+	ICE_PROT_EAPOL_OF	= 120,
 	ICE_PROT_INVALID	= 255  /* when offset == ICE_FV_OFFSET_INVAL */
 };
 
-- 
2.47.1


