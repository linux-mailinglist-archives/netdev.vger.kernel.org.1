Return-Path: <netdev+bounces-218234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40AB3B8A3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0867BEFDE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F830ACF9;
	Fri, 29 Aug 2025 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXbCSEId"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459530ACE4
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 10:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462707; cv=none; b=R6JpolaSAWKMTFqYP+NLSe6wxvZTS4nzFCJllCAmjxO1M5GML1JHtjTRfJIkZU3G8I23T8Nfpizfu03GyePFtF5I0Vew25+E5s4K5fcIDbERNWDFA/hMrth4L9R/c1kzhqoQPxkAHy1i381iNMt4fgIl8CqTt5dq4E87rnkEiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462707; c=relaxed/simple;
	bh=a+JIPtQeCj8xIBhlQAvvNuljo21v/zYAWQ1acXvxhAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiI35DKObvAcuD6fEEAe1szMBSx18RF/Gtq2Htdbb3hXNK2AoTX9nLIt2cehsTgowmiKjI687jkdh+51o6NJYivbQZwiFF4yvdEQHc9r2mcegdo1M4Lre/sg0Q2OUNCOQi3VmKX4O47FRSqKJeZDon5XODFmYwOPk9HMHJ0ePVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXbCSEId; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756462705; x=1787998705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+JIPtQeCj8xIBhlQAvvNuljo21v/zYAWQ1acXvxhAg=;
  b=PXbCSEIdvHsshBtluw30Dpjq9fDzJVmtjZwhFkLOUDnSNmutIaV31uqd
   ND+E3gZJuXq8RN6nAfT8uumY9G8vs1D2eCkvtt6MfPbPKlIVh0RTiENMM
   V2uhlfbVrMWfbnrOX8jOodd0eCsyLF2aguwrue8KN/y0oAOA+IxKZBWod
   n1cfj4S0gdsS3up/IhFTg7y8va53YbMTNGZLizbL+tdEREa87sFKFVQ72
   METLaGrKCeqKKSfdMHhXq0vjaDB9/FaskAB8NitEkwUUqdY7FwD6sLgPK
   xmYfQ8XTxQg5BcERHskkQGJ3XBCIdqFh9h8BjqwPsgUM7X1xlfVy9C6+m
   w==;
X-CSE-ConnectionGUID: pIyjlw4fTbSdHfm8w9xGpA==
X-CSE-MsgGUID: QwdZ0MjtQsGlHGy77iVdgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="76199495"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="76199495"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 03:18:25 -0700
X-CSE-ConnectionGUID: qJFhipHAR1GojVdNzoFVVg==
X-CSE-MsgGUID: cpeTa/kjTIi+3i8pd8q6nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="207489292"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa001.jf.intel.com with ESMTP; 29 Aug 2025 03:18:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	mschmidt@redhat.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v4 5/5] iavf: add RSS support for GTP protocol via ethtool
Date: Fri, 29 Aug 2025 10:18:08 +0000
Message-ID: <20250829101809.1022945-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the iavf driver to support Receive Side Scaling (RSS)
configuration for GTP (GPRS Tunneling Protocol) flows using ethtool.

The implementation introduces new RSS flow segment headers and hash field
definitions for various GTP encapsulations, including:

  - GTPC
  - GTPU (IP, Extension Header, Uplink, Downlink)
  - TEID-based hashing

The ethtool interface is updated to parse and apply these new flow types
and hash fields, enabling fine-grained traffic distribution for GTP-based
mobile workloads.

This enhancement improves performance and scalability for virtualized
network functions (VNFs) and user plane functions (UPFs) in 5G and LTE
deployments.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 119 ++++++++++++++----
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |  31 +++++
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  89 +++++++++++++
 3 files changed, 216 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
index a9e1da3..cd61abd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c
@@ -90,6 +90,55 @@ iavf_fill_adv_rss_sctp_hdr(struct virtchnl_proto_hdr *hdr, u64 hash_flds)
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, SCTP, DST_PORT);
 }
 
+/**
+ * iavf_fill_adv_rss_gtp_hdr - Fill GTP-related RSS protocol headers
+ * @proto_hdrs: pointer to the virtchnl protocol headers structure to populate
+ * @packet_hdrs: bitmask of packet header types to configure
+ * @hash_flds: RSS hash field configuration
+ *
+ * This function populates the virtchnl protocol header structure with
+ * appropriate GTP-related header types based on the specified packet_hdrs.
+ * It supports GTPC, GTPU with extension headers, and uplink/downlink PDU
+ * types. For certain GTPU types, it also appends an IPv4 header to enable
+ * hashing on the destination IP address.
+ *
+ * Return: 0 on success or -EOPNOTSUPP if the packet_hdrs value is unsupported.
+ */
+static int
+iavf_fill_adv_rss_gtp_hdr(struct virtchnl_proto_hdrs *proto_hdrs,
+			  u32 packet_hdrs, u64 hash_flds)
+{
+	struct virtchnl_proto_hdr *hdr;
+
+	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count - 1];
+
+	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP) {
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID:
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPC);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH_PDU_UP);
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		iavf_fill_adv_rss_ip4_hdr(hdr, IAVF_ADV_RSS_HASH_FLD_IPV4_DA);
+		break;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN:
+		VIRTCHNL_SET_PROTO_HDR_TYPE(hdr, GTPU_EH_PDU_DWN);
+		fallthrough;
+	case IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP:
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		iavf_fill_adv_rss_ip4_hdr(hdr, IAVF_ADV_RSS_HASH_FLD_IPV4_DA);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 /**
  * iavf_fill_adv_rss_cfg_msg - fill the RSS configuration into virtchnl message
  * @rss_cfg: the virtchnl message to be filled with RSS configuration setting
@@ -103,6 +152,8 @@ int
 iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
 			  u32 packet_hdrs, u64 hash_flds, bool symm)
 {
+	const u32 packet_l3_hdrs = packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L3;
+	const u32 packet_l4_hdrs = packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L4;
 	struct virtchnl_proto_hdrs *proto_hdrs = &rss_cfg->proto_hdrs;
 	struct virtchnl_proto_hdr *hdr;
 
@@ -113,31 +164,41 @@ iavf_fill_adv_rss_cfg_msg(struct virtchnl_rss_cfg *rss_cfg,
 
 	proto_hdrs->tunnel_level = 0;	/* always outer layer */
 
-	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
-	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L3) {
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4:
-		iavf_fill_adv_rss_ip4_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6:
-		iavf_fill_adv_rss_ip6_hdr(hdr, hash_flds);
-		break;
-	default:
-		return -EINVAL;
+	if (packet_l3_hdrs) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		switch (packet_l3_hdrs) {
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4:
+			iavf_fill_adv_rss_ip4_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6:
+			iavf_fill_adv_rss_ip6_hdr(hdr, hash_flds);
+			break;
+		default:
+			return -EINVAL;
+		}
 	}
 
-	hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
-	switch (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_L4) {
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_TCP:
-		iavf_fill_adv_rss_tcp_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_UDP:
-		iavf_fill_adv_rss_udp_hdr(hdr, hash_flds);
-		break;
-	case IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP:
-		iavf_fill_adv_rss_sctp_hdr(hdr, hash_flds);
-		break;
-	default:
-		return -EINVAL;
+	if (packet_l4_hdrs) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		switch (packet_l4_hdrs) {
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_TCP:
+			iavf_fill_adv_rss_tcp_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_UDP:
+			iavf_fill_adv_rss_udp_hdr(hdr, hash_flds);
+			break;
+		case IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP:
+			iavf_fill_adv_rss_sctp_hdr(hdr, hash_flds);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP) {
+		hdr = &proto_hdrs->proto_hdr[proto_hdrs->count++];
+		if (iavf_fill_adv_rss_gtp_hdr(proto_hdrs, packet_hdrs, hash_flds))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -186,6 +247,8 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 		proto = "UDP";
 	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
 		proto = "SCTP";
+	else if (packet_hdrs & IAVF_ADV_RSS_FLOW_SEG_HDR_GTP)
+		proto = "GTP";
 	else
 		return;
 
@@ -211,6 +274,16 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
 			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
 			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
 		strcat(hash_opt, "dst port,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPC_TEID)
+		strcat(hash_opt, "gtp-c,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID)
+		strcat(hash_opt, "gtp-u ip,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID)
+		strcat(hash_opt, "gtp-u ext,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID)
+		strcat(hash_opt, "gtp-u ul,");
+	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID)
+		strcat(hash_opt, "gtp-u dl,");
 
 	if (!action)
 		action = "";
diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
index e31eb2a..74cc9e0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.h
@@ -22,6 +22,12 @@ enum iavf_adv_rss_flow_seg_hdr {
 	IAVF_ADV_RSS_FLOW_SEG_HDR_TCP	= 0x00000004,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_UDP	= 0x00000008,
 	IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP	= 0x00000010,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC		= 0x00000400,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID	= 0x00000800,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP	= 0x00001000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH	= 0x00002000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN	= 0x00004000,
+	IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP	= 0x00008000,
 };
 
 #define IAVF_ADV_RSS_FLOW_SEG_HDR_L3		\
@@ -33,6 +39,14 @@ enum iavf_adv_rss_flow_seg_hdr {
 	 IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |	\
 	 IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP)
 
+#define IAVF_ADV_RSS_FLOW_SEG_HDR_GTP		\
+	(IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |	\
+	 IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP)
+
 enum iavf_adv_rss_flow_field {
 	/* L3 */
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_IPV4_SA,
@@ -46,6 +60,17 @@ enum iavf_adv_rss_flow_field {
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_UDP_DST_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT,
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT,
+	/* GTPC_TEID */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPC_TEID,
+	/* GTPU_IP */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_IP_TEID,
+	/* GTPU_EH */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_TEID,
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_QFI,
+	/* GTPU_UP */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_UP_TEID,
+	/* GTPU_DWN */
+	IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_DWN_TEID,
 
 	/* The total number of enums must not exceed 64 */
 	IAVF_ADV_RSS_FLOW_FIELD_IDX_MAX
@@ -72,6 +97,12 @@ enum iavf_adv_rss_flow_field {
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_SRC_PORT)
 #define IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT	\
 	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_SCTP_DST_PORT)
+#define IAVF_ADV_RSS_HASH_FLD_GTPC_TEID	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPC_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_IP_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_EH_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_UP_TEID)
+#define IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID \
+	BIT_ULL(IAVF_ADV_RSS_FLOW_FIELD_IDX_GTPU_DWN_TEID)
 
 /* bookkeeping of advanced RSS configuration */
 struct iavf_adv_rss {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 05d72be..a3f8ced 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1336,6 +1336,56 @@ static u32 iavf_adv_rss_parse_hdrs(const struct ethtool_rxfh_fields *cmd)
 		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_SCTP |
 			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
 		break;
+	case GTPU_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPC_TEID_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_UDP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_EH_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_UL_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_DL_V4_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV4;
+		break;
+	case GTPU_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_IP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPC_TEID_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPC_TEID |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_EH_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_EH |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_UL_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_UP |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
+	case GTPU_DL_V6_FLOW:
+		hdrs |= IAVF_ADV_RSS_FLOW_SEG_HDR_GTPU_DWN |
+			IAVF_ADV_RSS_FLOW_SEG_HDR_IPV6;
+		break;
 	default:
 		break;
 	}
@@ -1353,6 +1403,12 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 		case TCP_V4_FLOW:
 		case UDP_V4_FLOW:
 		case SCTP_V4_FLOW:
+		case GTPU_V4_FLOW:
+		case GTPC_V4_FLOW:
+		case GTPC_TEID_V4_FLOW:
+		case GTPU_EH_V4_FLOW:
+		case GTPU_UL_V4_FLOW:
+		case GTPU_DL_V4_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV4_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1361,6 +1417,12 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 		case TCP_V6_FLOW:
 		case UDP_V6_FLOW:
 		case SCTP_V6_FLOW:
+		case GTPU_V6_FLOW:
+		case GTPC_V6_FLOW:
+		case GTPC_TEID_V6_FLOW:
+		case GTPU_EH_V6_FLOW:
+		case GTPU_UL_V6_FLOW:
+		case GTPU_DL_V6_FLOW:
 			if (cmd->data & RXH_IP_SRC)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_IPV6_SA;
 			if (cmd->data & RXH_IP_DST)
@@ -1382,6 +1444,7 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 			break;
 		case UDP_V4_FLOW:
 		case UDP_V6_FLOW:
+		case GTPC_V4_FLOW:
 			if (cmd->data & RXH_L4_B_0_1)
 				hfld |= IAVF_ADV_RSS_HASH_FLD_UDP_SRC_PORT;
 			if (cmd->data & RXH_L4_B_2_3)
@@ -1398,6 +1461,32 @@ iavf_adv_rss_parse_hash_flds(const struct ethtool_rxfh_fields *cmd, bool symm)
 			break;
 		}
 	}
+	if (cmd->data & RXH_GTP_TEID) {
+		switch (cmd->flow_type) {
+		case GTPC_TEID_V4_FLOW:
+		case GTPC_TEID_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPC_TEID;
+			break;
+		case GTPU_V4_FLOW:
+		case GTPU_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID;
+			break;
+		case GTPU_EH_V4_FLOW:
+		case GTPU_EH_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID;
+			break;
+		case GTPU_UL_V4_FLOW:
+		case GTPU_UL_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID;
+			break;
+		case GTPU_DL_V4_FLOW:
+		case GTPU_DL_V6_FLOW:
+			hfld |= IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID;
+			break;
+		default:
+			break;
+		}
+	}
 
 	return hfld;
 }
-- 
2.47.1


