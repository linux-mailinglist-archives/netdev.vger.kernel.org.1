Return-Path: <netdev+bounces-212937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B88B2296D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF711BC4223
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C95288514;
	Tue, 12 Aug 2025 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEv4pst1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949272877C7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005959; cv=none; b=f2YNolXxZLlWefRQ14b7rfYDNhN3Dj8teTbSYG/IQbuRWjXTvhMT3nRGdVxW8RMTA9lx9LnZbS06XmcFczoWamF3CTinC1FMD/R9CIxNW/eoMrL1zpY3iTWUSAKaJBUzKsyCbu/5pel91rfm/OuI7HVpGZUBWerGqaZI4D5/ehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005959; c=relaxed/simple;
	bh=K3ti5UjpDUPSya8M5WpqcS4qmyicNB2GW3DpsRhz4u4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpvc8nzXxeHfdOrwmVpu/AGHlx+v+nd9hD6gVMrYKOjYAH/A7pDUZ8cUcwmm27zPgxRdVZoyrAJ7xdQZFQjmKl+frX+P4NClDsICurkb7E8xW2MqCg7wq1cXsJuiSBlQmapWjrTL/A0EyLV1Qi+5AiqzfXxiIRTWKgwSJuLcHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEv4pst1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755005957; x=1786541957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3ti5UjpDUPSya8M5WpqcS4qmyicNB2GW3DpsRhz4u4=;
  b=eEv4pst1BPD2fjRVLBwR4ZAorv6JJxMyqAPMq8Vaegqw0PQvSeUtOXUG
   PFTGBGAUZHoVf9oQo0u49l8nyoIPN9jhM3sLrDGs+kq1BYz0pRDXLpXba
   UVWsO7YbLDcru7aPQP85IEKIrWyFLG7gdLAGT6MJYW+ee1+Tv6Zyc3f5Y
   GEWJOPJ/FXaO3Itxa9j6hqIe1obw3ajd+YzPsACinvgAWo/7tf6Eo08GQ
   13Xz6ISh3GEqb/r7N8JJjC//C8dYP54OW1wdmj34/wUcdhYRx5LZ5lr7V
   MKUMB3NeYYZvVlFk5/DdLMX32sgvc7eoapk/iXWUozWd/JCHqoGD9cwlS
   Q==;
X-CSE-ConnectionGUID: nkGT4HesRSK/U2PHt8/2Dg==
X-CSE-MsgGUID: l2c+LDFdTI+y4/wkxcurSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56994346"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="56994346"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2025 06:39:12 -0700
X-CSE-ConnectionGUID: aB9QRCegQ+K8JDC8xY9jcw==
X-CSE-MsgGUID: aiCF714RQ3iJJQGDeQ5XlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="170416120"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 12 Aug 2025 06:39:08 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B060B32CBB;
	Tue, 12 Aug 2025 14:39:07 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH 11/12] ice: finish ice_virtchnl.c split into ice_virtchnl_rss.c
Date: Tue, 12 Aug 2025 15:29:09 +0200
Message-Id: <20250812132910.99626-12-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move functions out of ice_virtchnl.c to ice_virtchnl_rss.c.

Same "git tricks" used as for the split into ice_virtchnl_queues.c
that is immediately preceding this split.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/ice_virtchnl_rss.h |  14 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 713 +-----------------
 .../net/ethernet/intel/ice/ice_virtchnl_rss.c |  13 +-
 4 files changed, 23 insertions(+), 718 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 46a21ed67066..ccee078931f3 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -51,6 +51,7 @@ ice-$(CONFIG_PCI_IOV) +=	\
 	ice_virtchnl_allowlist.o \
 	ice_virtchnl_fdir.o	\
 	ice_virtchnl_queues.o	\
+	ice_virtchnl_rss.o	\
 	ice_vf_mbx.o		\
 	ice_vf_vsi_vlan_ops.o	\
 	ice_vf_lib.o
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h b/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h
new file mode 100644
index 000000000000..02bde787e13b
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022, Intel Corporation. */
+
+#ifndef _ICE_VIRTCHNL_RSS_H_
+#define _ICE_VIRTCHNL_RSS_H_
+#include "ice.h"
+
+int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add);
+int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg);
+int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg);
+int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg);
+int ice_vc_get_rss_hashcfg(struct ice_vf *vf);
+int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg);
+#endif /* _ICE_VIRTCHNL_RSS_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index afbc846f3109..0f8930b727e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2022, Intel Corporation. */
 
 #include "ice_virtchnl.h"
+#include "ice_virtchnl_rss.h"
 #include "ice_virtchnl_queues.h"
 #include "ice_vf_lib_private.h"
 #include "ice.h"
@@ -14,158 +15,6 @@
 #include "ice_flex_pipe.h"
 #include "ice_dcb_lib.h"
 
-#define FIELD_SELECTOR(proto_hdr_field) \
-		BIT((proto_hdr_field) & PROTO_HDR_FIELD_MASK)
-
-struct ice_vc_hdr_match_type {
-	u32 vc_hdr;	/* virtchnl headers (VIRTCHNL_PROTO_HDR_XXX) */
-	u32 ice_hdr;	/* ice headers (ICE_FLOW_SEG_HDR_XXX) */
-};
-
-static const struct ice_vc_hdr_match_type ice_vc_hdr_list[] = {
-	{VIRTCHNL_PROTO_HDR_NONE,	ICE_FLOW_SEG_HDR_NONE},
-	{VIRTCHNL_PROTO_HDR_ETH,	ICE_FLOW_SEG_HDR_ETH},
-	{VIRTCHNL_PROTO_HDR_S_VLAN,	ICE_FLOW_SEG_HDR_VLAN},
-	{VIRTCHNL_PROTO_HDR_C_VLAN,	ICE_FLOW_SEG_HDR_VLAN},
-	{VIRTCHNL_PROTO_HDR_IPV4,	ICE_FLOW_SEG_HDR_IPV4 |
-					ICE_FLOW_SEG_HDR_IPV_OTHER},
-	{VIRTCHNL_PROTO_HDR_IPV6,	ICE_FLOW_SEG_HDR_IPV6 |
-					ICE_FLOW_SEG_HDR_IPV_OTHER},
-	{VIRTCHNL_PROTO_HDR_TCP,	ICE_FLOW_SEG_HDR_TCP},
-	{VIRTCHNL_PROTO_HDR_UDP,	ICE_FLOW_SEG_HDR_UDP},
-	{VIRTCHNL_PROTO_HDR_SCTP,	ICE_FLOW_SEG_HDR_SCTP},
-	{VIRTCHNL_PROTO_HDR_PPPOE,	ICE_FLOW_SEG_HDR_PPPOE},
-	{VIRTCHNL_PROTO_HDR_GTPU_IP,	ICE_FLOW_SEG_HDR_GTPU_IP},
-	{VIRTCHNL_PROTO_HDR_GTPU_EH,	ICE_FLOW_SEG_HDR_GTPU_EH},
-	{VIRTCHNL_PROTO_HDR_GTPU_EH_PDU_DWN,
-					ICE_FLOW_SEG_HDR_GTPU_DWN},
-	{VIRTCHNL_PROTO_HDR_GTPU_EH_PDU_UP,
-					ICE_FLOW_SEG_HDR_GTPU_UP},
-	{VIRTCHNL_PROTO_HDR_L2TPV3,	ICE_FLOW_SEG_HDR_L2TPV3},
-	{VIRTCHNL_PROTO_HDR_ESP,	ICE_FLOW_SEG_HDR_ESP},
-	{VIRTCHNL_PROTO_HDR_AH,		ICE_FLOW_SEG_HDR_AH},
-	{VIRTCHNL_PROTO_HDR_PFCP,	ICE_FLOW_SEG_HDR_PFCP_SESSION},
-};
-
-struct ice_vc_hash_field_match_type {
-	u32 vc_hdr;		/* virtchnl headers
-				 * (VIRTCHNL_PROTO_HDR_XXX)
-				 */
-	u32 vc_hash_field;	/* virtchnl hash fields selector
-				 * FIELD_SELECTOR((VIRTCHNL_PROTO_HDR_ETH_XXX))
-				 */
-	u64 ice_hash_field;	/* ice hash fields
-				 * (BIT_ULL(ICE_FLOW_FIELD_IDX_XXX))
-				 */
-};
-
-static const struct
-ice_vc_hash_field_match_type ice_vc_hash_field_list[] = {
-	{VIRTCHNL_PROTO_HDR_ETH, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ETH_SRC),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_ETH_SA)},
-	{VIRTCHNL_PROTO_HDR_ETH, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ETH_DST),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_ETH_DA)},
-	{VIRTCHNL_PROTO_HDR_ETH, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ETH_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ETH_DST),
-		ICE_FLOW_HASH_ETH},
-	{VIRTCHNL_PROTO_HDR_ETH,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ETH_ETHERTYPE),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_ETH_TYPE)},
-	{VIRTCHNL_PROTO_HDR_S_VLAN,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_S_VLAN_ID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_S_VLAN)},
-	{VIRTCHNL_PROTO_HDR_C_VLAN,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_C_VLAN_ID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_C_VLAN)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_SRC),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_SA)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_DST),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_DA)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_DST),
-		ICE_FLOW_HASH_IPV4},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_SA) |
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_DST) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_DA) |
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_DST) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_PROT),
-		ICE_FLOW_HASH_IPV4 | BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV4, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV4_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV4_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_SRC),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_SA)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_DST),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_DA)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_DST),
-		ICE_FLOW_HASH_IPV6},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_SA) |
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_DST) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_DA) |
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_SRC) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_DST) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PROT),
-		ICE_FLOW_HASH_IPV6 | BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PROT)},
-	{VIRTCHNL_PROTO_HDR_IPV6, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_IPV6_PROT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_IPV6_PROT)},
-	{VIRTCHNL_PROTO_HDR_TCP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_TCP_SRC_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_TCP_SRC_PORT)},
-	{VIRTCHNL_PROTO_HDR_TCP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_TCP_DST_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_TCP_DST_PORT)},
-	{VIRTCHNL_PROTO_HDR_TCP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_TCP_SRC_PORT) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_TCP_DST_PORT),
-		ICE_FLOW_HASH_TCP_PORT},
-	{VIRTCHNL_PROTO_HDR_UDP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_UDP_SRC_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_UDP_SRC_PORT)},
-	{VIRTCHNL_PROTO_HDR_UDP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_UDP_DST_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_UDP_DST_PORT)},
-	{VIRTCHNL_PROTO_HDR_UDP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_UDP_SRC_PORT) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_UDP_DST_PORT),
-		ICE_FLOW_HASH_UDP_PORT},
-	{VIRTCHNL_PROTO_HDR_SCTP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_SCTP_SRC_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_SRC_PORT)},
-	{VIRTCHNL_PROTO_HDR_SCTP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_SCTP_DST_PORT),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_SCTP_DST_PORT)},
-	{VIRTCHNL_PROTO_HDR_SCTP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_SCTP_SRC_PORT) |
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_SCTP_DST_PORT),
-		ICE_FLOW_HASH_SCTP_PORT},
-	{VIRTCHNL_PROTO_HDR_PPPOE,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_PPPOE_SESS_ID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_PPPOE_SESS_ID)},
-	{VIRTCHNL_PROTO_HDR_GTPU_IP,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_GTPU_IP_TEID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_GTPU_IP_TEID)},
-	{VIRTCHNL_PROTO_HDR_L2TPV3,
-		FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_L2TPV3_SESS_ID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_L2TPV3_SESS_ID)},
-	{VIRTCHNL_PROTO_HDR_ESP, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_ESP_SPI),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_ESP_SPI)},
-	{VIRTCHNL_PROTO_HDR_AH, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_AH_SPI),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_AH_SPI)},
-	{VIRTCHNL_PROTO_HDR_PFCP, FIELD_SELECTOR(VIRTCHNL_PROTO_HDR_PFCP_SEID),
-		BIT_ULL(ICE_FLOW_FIELD_IDX_PFCP_SEID)},
-};
-
 /**
  * ice_vc_vf_broadcast - Broadcast a message to all VFs on PF
  * @pf: pointer to the PF structure
@@ -537,460 +386,6 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
 	return vsi_id == ICE_VF_VSI_ID;
 }
 
-/**
- * ice_vc_validate_pattern
- * @vf: pointer to the VF info
- * @proto: virtchnl protocol headers
- *
- * validate the pattern is supported or not.
- *
- * Return: true on success, false on error.
- */
-bool
-ice_vc_validate_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto)
-{
-	bool is_ipv4 = false;
-	bool is_ipv6 = false;
-	bool is_udp = false;
-	u16 ptype = -1;
-	int i = 0;
-
-	while (i < proto->count &&
-	       proto->proto_hdr[i].type != VIRTCHNL_PROTO_HDR_NONE) {
-		switch (proto->proto_hdr[i].type) {
-		case VIRTCHNL_PROTO_HDR_ETH:
-			ptype = ICE_PTYPE_MAC_PAY;
-			break;
-		case VIRTCHNL_PROTO_HDR_IPV4:
-			ptype = ICE_PTYPE_IPV4_PAY;
-			is_ipv4 = true;
-			break;
-		case VIRTCHNL_PROTO_HDR_IPV6:
-			ptype = ICE_PTYPE_IPV6_PAY;
-			is_ipv6 = true;
-			break;
-		case VIRTCHNL_PROTO_HDR_UDP:
-			if (is_ipv4)
-				ptype = ICE_PTYPE_IPV4_UDP_PAY;
-			else if (is_ipv6)
-				ptype = ICE_PTYPE_IPV6_UDP_PAY;
-			is_udp = true;
-			break;
-		case VIRTCHNL_PROTO_HDR_TCP:
-			if (is_ipv4)
-				ptype = ICE_PTYPE_IPV4_TCP_PAY;
-			else if (is_ipv6)
-				ptype = ICE_PTYPE_IPV6_TCP_PAY;
-			break;
-		case VIRTCHNL_PROTO_HDR_SCTP:
-			if (is_ipv4)
-				ptype = ICE_PTYPE_IPV4_SCTP_PAY;
-			else if (is_ipv6)
-				ptype = ICE_PTYPE_IPV6_SCTP_PAY;
-			break;
-		case VIRTCHNL_PROTO_HDR_GTPU_IP:
-		case VIRTCHNL_PROTO_HDR_GTPU_EH:
-			if (is_ipv4)
-				ptype = ICE_MAC_IPV4_GTPU;
-			else if (is_ipv6)
-				ptype = ICE_MAC_IPV6_GTPU;
-			goto out;
-		case VIRTCHNL_PROTO_HDR_L2TPV3:
-			if (is_ipv4)
-				ptype = ICE_MAC_IPV4_L2TPV3;
-			else if (is_ipv6)
-				ptype = ICE_MAC_IPV6_L2TPV3;
-			goto out;
-		case VIRTCHNL_PROTO_HDR_ESP:
-			if (is_ipv4)
-				ptype = is_udp ? ICE_MAC_IPV4_NAT_T_ESP :
-						ICE_MAC_IPV4_ESP;
-			else if (is_ipv6)
-				ptype = is_udp ? ICE_MAC_IPV6_NAT_T_ESP :
-						ICE_MAC_IPV6_ESP;
-			goto out;
-		case VIRTCHNL_PROTO_HDR_AH:
-			if (is_ipv4)
-				ptype = ICE_MAC_IPV4_AH;
-			else if (is_ipv6)
-				ptype = ICE_MAC_IPV6_AH;
-			goto out;
-		case VIRTCHNL_PROTO_HDR_PFCP:
-			if (is_ipv4)
-				ptype = ICE_MAC_IPV4_PFCP_SESSION;
-			else if (is_ipv6)
-				ptype = ICE_MAC_IPV6_PFCP_SESSION;
-			goto out;
-		default:
-			break;
-		}
-		i++;
-	}
-
-out:
-	return ice_hw_ptype_ena(&vf->pf->hw, ptype);
-}
-
-/**
- * ice_vc_parse_rss_cfg - parses hash fields and headers from
- * a specific virtchnl RSS cfg
- * @hw: pointer to the hardware
- * @rss_cfg: pointer to the virtchnl RSS cfg
- * @hash_cfg: pointer to the HW hash configuration
- *
- * Return true if all the protocol header and hash fields in the RSS cfg could
- * be parsed, else return false
- *
- * This function parses the virtchnl RSS cfg to be the intended
- * hash fields and the intended header for RSS configuration
- */
-static bool ice_vc_parse_rss_cfg(struct ice_hw *hw,
-				 struct virtchnl_rss_cfg *rss_cfg,
-				 struct ice_rss_hash_cfg *hash_cfg)
-{
-	const struct ice_vc_hash_field_match_type *hf_list;
-	const struct ice_vc_hdr_match_type *hdr_list;
-	int i, hf_list_len, hdr_list_len;
-	u32 *addl_hdrs = &hash_cfg->addl_hdrs;
-	u64 *hash_flds = &hash_cfg->hash_flds;
-
-	/* set outer layer RSS as default */
-	hash_cfg->hdr_type = ICE_RSS_OUTER_HEADERS;
-
-	if (rss_cfg->rss_algorithm == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC)
-		hash_cfg->symm = true;
-	else
-		hash_cfg->symm = false;
-
-	hf_list = ice_vc_hash_field_list;
-	hf_list_len = ARRAY_SIZE(ice_vc_hash_field_list);
-	hdr_list = ice_vc_hdr_list;
-	hdr_list_len = ARRAY_SIZE(ice_vc_hdr_list);
-
-	for (i = 0; i < rss_cfg->proto_hdrs.count; i++) {
-		struct virtchnl_proto_hdr *proto_hdr =
-					&rss_cfg->proto_hdrs.proto_hdr[i];
-		bool hdr_found = false;
-		int j;
-
-		/* Find matched ice headers according to virtchnl headers. */
-		for (j = 0; j < hdr_list_len; j++) {
-			struct ice_vc_hdr_match_type hdr_map = hdr_list[j];
-
-			if (proto_hdr->type == hdr_map.vc_hdr) {
-				*addl_hdrs |= hdr_map.ice_hdr;
-				hdr_found = true;
-			}
-		}
-
-		if (!hdr_found)
-			return false;
-
-		/* Find matched ice hash fields according to
-		 * virtchnl hash fields.
-		 */
-		for (j = 0; j < hf_list_len; j++) {
-			struct ice_vc_hash_field_match_type hf_map = hf_list[j];
-
-			if (proto_hdr->type == hf_map.vc_hdr &&
-			    proto_hdr->field_selector == hf_map.vc_hash_field) {
-				*hash_flds |= hf_map.ice_hash_field;
-				break;
-			}
-		}
-	}
-
-	return true;
-}
-
-/**
- * ice_vf_adv_rss_offload_ena - determine if capabilities support advanced
- * RSS offloads
- * @caps: VF driver negotiated capabilities
- *
- * Return true if VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF capability is set,
- * else return false
- */
-static bool ice_vf_adv_rss_offload_ena(u32 caps)
-{
-	return !!(caps & VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF);
-}
-
-/**
- * ice_vc_handle_rss_cfg
- * @vf: pointer to the VF info
- * @msg: pointer to the message buffer
- * @add: add a RSS config if true, otherwise delete a RSS config
- *
- * This function adds/deletes a RSS config
- */
-static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
-{
-	u32 v_opcode = add ? VIRTCHNL_OP_ADD_RSS_CFG : VIRTCHNL_OP_DEL_RSS_CFG;
-	struct virtchnl_rss_cfg *rss_cfg = (struct virtchnl_rss_cfg *)msg;
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_hw *hw = &vf->pf->hw;
-	struct ice_vsi *vsi;
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
-		dev_dbg(dev, "VF %d attempting to configure RSS, but RSS is not supported by the PF\n",
-			vf->vf_id);
-		v_ret = VIRTCHNL_STATUS_ERR_NOT_SUPPORTED;
-		goto error_param;
-	}
-
-	if (!ice_vf_adv_rss_offload_ena(vf->driver_caps)) {
-		dev_dbg(dev, "VF %d attempting to configure RSS, but Advanced RSS offload is not supported\n",
-			vf->vf_id);
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (rss_cfg->proto_hdrs.count > VIRTCHNL_MAX_NUM_PROTO_HDRS ||
-	    rss_cfg->rss_algorithm < VIRTCHNL_RSS_ALG_TOEPLITZ_ASYMMETRIC ||
-	    rss_cfg->rss_algorithm > VIRTCHNL_RSS_ALG_XOR_SYMMETRIC) {
-		dev_dbg(dev, "VF %d attempting to configure RSS, but RSS configuration is not valid\n",
-			vf->vf_id);
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_validate_pattern(vf, &rss_cfg->proto_hdrs)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (rss_cfg->rss_algorithm == VIRTCHNL_RSS_ALG_R_ASYMMETRIC) {
-		struct ice_vsi_ctx *ctx;
-		u8 lut_type, hash_type;
-		int status;
-
-		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
-		hash_type = add ? ICE_AQ_VSI_Q_OPT_RSS_HASH_XOR :
-				ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
-
-		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
-		if (!ctx) {
-			v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
-			goto error_param;
-		}
-
-		ctx->info.q_opt_rss =
-			FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
-			FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
-
-		/* Preserve existing queueing option setting */
-		ctx->info.q_opt_rss |= (vsi->info.q_opt_rss &
-					  ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M);
-		ctx->info.q_opt_tc = vsi->info.q_opt_tc;
-		ctx->info.q_opt_flags = vsi->info.q_opt_rss;
-
-		ctx->info.valid_sections =
-				cpu_to_le16(ICE_AQ_VSI_PROP_Q_OPT_VALID);
-
-		status = ice_update_vsi(hw, vsi->idx, ctx, NULL);
-		if (status) {
-			dev_err(dev, "update VSI for RSS failed, err %d aq_err %s\n",
-				status, libie_aq_str(hw->adminq.sq_last_status));
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		} else {
-			vsi->info.q_opt_rss = ctx->info.q_opt_rss;
-		}
-
-		kfree(ctx);
-	} else {
-		struct ice_rss_hash_cfg cfg;
-
-		/* Only check for none raw pattern case */
-		if (!ice_vc_validate_pattern(vf, &rss_cfg->proto_hdrs)) {
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-			goto error_param;
-		}
-		cfg.addl_hdrs = ICE_FLOW_SEG_HDR_NONE;
-		cfg.hash_flds = ICE_HASH_INVALID;
-		cfg.hdr_type = ICE_RSS_ANY_HEADERS;
-
-		if (!ice_vc_parse_rss_cfg(hw, rss_cfg, &cfg)) {
-			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-			goto error_param;
-		}
-
-		if (add) {
-			if (ice_add_rss_cfg(hw, vsi, &cfg)) {
-				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-				dev_err(dev, "ice_add_rss_cfg failed for vsi = %d, v_ret = %d\n",
-					vsi->vsi_num, v_ret);
-			}
-		} else {
-			int status;
-
-			status = ice_rem_rss_cfg(hw, vsi->idx, &cfg);
-			/* We just ignore -ENOENT, because if two configurations
-			 * share the same profile remove one of them actually
-			 * removes both, since the profile is deleted.
-			 */
-			if (status && status != -ENOENT) {
-				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-				dev_err(dev, "ice_rem_rss_cfg failed for VF ID:%d, error:%d\n",
-					vf->vf_id, status);
-			}
-		}
-	}
-
-error_param:
-	return ice_vc_send_msg_to_vf(vf, v_opcode, v_ret, NULL, 0);
-}
-
-/**
- * ice_vc_config_rss_key
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- *
- * Configure the VF's RSS key
- */
-static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
-{
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_rss_key *vrk =
-		(struct virtchnl_rss_key *)msg;
-	struct ice_vsi *vsi;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_isvalid_vsi_id(vf, vrk->vsi_id)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (vrk->key_len != ICE_VSIQF_HKEY_ARRAY_SIZE) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (ice_set_rss_key(vsi, vrk->key))
-		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
-error_param:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_KEY, v_ret,
-				     NULL, 0);
-}
-
-/**
- * ice_vc_config_rss_lut
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- *
- * Configure the VF's RSS LUT
- */
-static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
-{
-	struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct ice_vsi *vsi;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_isvalid_vsi_id(vf, vrl->vsi_id)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (vrl->lut_entries != ICE_LUT_VSI_SIZE) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (ice_set_rss_lut(vsi, vrl->lut, ICE_LUT_VSI_SIZE))
-		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
-error_param:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_LUT, v_ret,
-				     NULL, 0);
-}
-
-/**
- * ice_vc_config_rss_hfunc
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- *
- * Configure the VF's RSS Hash function
- */
-static int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg)
-{
-	struct virtchnl_rss_hfunc *vrh = (struct virtchnl_rss_hfunc *)msg;
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
-	struct ice_vsi *vsi;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!ice_vc_isvalid_vsi_id(vf, vrh->vsi_id)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto error_param;
-	}
-
-	if (vrh->rss_algorithm == VIRTCHNL_RSS_ALG_TOEPLITZ_SYMMETRIC)
-		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
-
-	if (ice_set_rss_hfunc(vsi, hfunc))
-		v_ret = VIRTCHNL_STATUS_ERR_ADMIN_QUEUE_ERROR;
-error_param:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_RSS_HFUNC, v_ret,
-				     NULL, 0);
-}
-
 /**
  * ice_vc_get_qos_caps - Get current QoS caps from PF
  * @vf: pointer to the VF info
@@ -2018,112 +1413,6 @@ static int ice_vc_dis_vlan_stripping(struct ice_vf *vf)
 				     v_ret, NULL, 0);
 }
 
-/**
- * ice_vc_get_rss_hashcfg - return the RSS Hash configuration
- * @vf: pointer to the VF info
- */
-static int ice_vc_get_rss_hashcfg(struct ice_vf *vf)
-{
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct virtchnl_rss_hashcfg *vrh = NULL;
-	int len = 0, ret;
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto err;
-	}
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, vf->pf->flags)) {
-		dev_err(ice_pf_to_dev(vf->pf), "RSS not supported by PF\n");
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto err;
-	}
-
-	len = sizeof(struct virtchnl_rss_hashcfg);
-	vrh = kzalloc(len, GFP_KERNEL);
-	if (!vrh) {
-		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
-		len = 0;
-		goto err;
-	}
-
-	vrh->hashcfg = ICE_DEFAULT_RSS_HASHCFG;
-err:
-	/* send the response back to the VF */
-	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_RSS_HASHCFG_CAPS, v_ret,
-				    (u8 *)vrh, len);
-	kfree(vrh);
-	return ret;
-}
-
-/**
- * ice_vc_set_rss_hashcfg - set RSS Hash configuration bits for the VF
- * @vf: pointer to the VF info
- * @msg: pointer to the msg buffer
- */
-static int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
-{
-	struct virtchnl_rss_hashcfg *vrh = (struct virtchnl_rss_hashcfg *)msg;
-	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-	struct ice_pf *pf = vf->pf;
-	struct ice_vsi *vsi;
-	struct device *dev;
-	int status;
-
-	dev = ice_pf_to_dev(pf);
-
-	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto err;
-	}
-
-	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
-		dev_err(dev, "RSS not supported by PF\n");
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto err;
-	}
-
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi) {
-		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
-		goto err;
-	}
-
-	/* clear all previously programmed RSS configuration to allow VF drivers
-	 * the ability to customize the RSS configuration and/or completely
-	 * disable RSS
-	 */
-	status = ice_rem_vsi_rss_cfg(&pf->hw, vsi->idx);
-	if (status && !vrh->hashcfg) {
-		/* only report failure to clear the current RSS configuration if
-		 * that was clearly the VF's intention (i.e. vrh->hashcfg = 0)
-		 */
-		v_ret = ice_err_to_virt_err(status);
-		goto err;
-	} else if (status) {
-		/* allow the VF to update the RSS configuration even on failure
-		 * to clear the current RSS confguration in an attempt to keep
-		 * RSS in a working state
-		 */
-		dev_warn(dev, "Failed to clear the RSS configuration for VF %u\n",
-			 vf->vf_id);
-	}
-
-	if (vrh->hashcfg) {
-		status = ice_add_avf_rss_cfg(&pf->hw, vsi, vrh->hashcfg);
-		v_ret = ice_err_to_virt_err(status);
-	}
-
-	/* save the requested VF configuration */
-	if (!v_ret)
-		vf->rss_hashcfg = vrh->hashcfg;
-
-	/* send the response to the VF */
-err:
-	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_SET_RSS_HASHCFG, v_ret,
-				     NULL, 0);
-}
-
 /**
  * ice_vc_query_rxdid - query RXDID supported by DDP package
  * @vf: pointer to VF info
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
index 04bbb2b097a8..e3f01ffc4b54 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_rss.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2022, Intel Corporation. */
 
+#include "ice_virtchnl_rss.h"
 #include "ice_vf_lib_private.h"
 #include "ice.h"
 
@@ -343,7 +344,7 @@ static bool ice_vf_adv_rss_offload_ena(u32 caps)
  *
  * This function adds/deletes a RSS config
  */
-static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
+int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
 {
 	u32 v_opcode = add ? VIRTCHNL_OP_ADD_RSS_CFG : VIRTCHNL_OP_DEL_RSS_CFG;
 	struct virtchnl_rss_cfg *rss_cfg = (struct virtchnl_rss_cfg *)msg;
@@ -479,7 +480,7 @@ static int ice_vc_handle_rss_cfg(struct ice_vf *vf, u8 *msg, bool add)
  *
  * Configure the VF's RSS key
  */
-static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
+int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_rss_key *vrk =
@@ -526,7 +527,7 @@ static int ice_vc_config_rss_key(struct ice_vf *vf, u8 *msg)
  *
  * Configure the VF's RSS LUT
  */
-static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
+int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
@@ -572,7 +573,7 @@ static int ice_vc_config_rss_lut(struct ice_vf *vf, u8 *msg)
  *
  * Configure the VF's RSS Hash function
  */
-static int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg)
+int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_hfunc *vrh = (struct virtchnl_rss_hfunc *)msg;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
@@ -614,7 +615,7 @@ static int ice_vc_config_rss_hfunc(struct ice_vf *vf, u8 *msg)
  * ice_vc_get_rss_hashcfg - return the RSS Hash configuration
  * @vf: pointer to the VF info
  */
-static int ice_vc_get_rss_hashcfg(struct ice_vf *vf)
+int ice_vc_get_rss_hashcfg(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_rss_hashcfg *vrh = NULL;
@@ -653,7 +654,7 @@ static int ice_vc_get_rss_hashcfg(struct ice_vf *vf)
  * @vf: pointer to the VF info
  * @msg: pointer to the msg buffer
  */
-static int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
+int ice_vc_set_rss_hashcfg(struct ice_vf *vf, u8 *msg)
 {
 	struct virtchnl_rss_hashcfg *vrh = (struct virtchnl_rss_hashcfg *)msg;
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
-- 
2.39.3


