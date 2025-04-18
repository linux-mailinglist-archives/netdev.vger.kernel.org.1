Return-Path: <netdev+bounces-184234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE6A93F21
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83888E0306
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F924888E;
	Fri, 18 Apr 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qsj93z2u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4863245012
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009385; cv=none; b=SYrSVinrIVg2m/ZhSGQIWoT1SdEa7V28heV66MbKs4V4VhlbVcT5ln/SvoSkcCQu3vEuca1LX00BE6V1RwyxUgVbRDKkKpvCS4nqDC3Wcz2JHarNjs/RKnflhAqCcqPaKtO/uR3hJ5Lnykuhl6yEJWn2kpvNodvbQyrfuhAy9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009385; c=relaxed/simple;
	bh=tD7PW8J0mCkY0kJ89Gyo00hPRycS/YgTNimUuM0bxP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIJaUM2F2xqpdfgMPd/CYShk8lMpXm3Lom6388bMGOZuOBGpaXUAxgnw8InXdKf78spINMgDwlppHuGq5an2WwJq2AkbfRPy/Fv+8NnPqkuVsqdGGByY8aR3HYYDbwtHniOL8yCZflnBsdOjljYhqxOmhXh2m+pasKOkGhozpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qsj93z2u; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745009383; x=1776545383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tD7PW8J0mCkY0kJ89Gyo00hPRycS/YgTNimUuM0bxP4=;
  b=Qsj93z2uy9LL9e3f8zsm6iQzMk8YSlQ1JNSFQd5TjGEWPpYq3SkGyI4b
   EazBlR+0DHtoJkuXy0WOV7iC263mNFk6VHBCS04XSuDYhTWCpQbEGomMz
   gHUE0KLe9ln2cGuM/mIB/2k+aLphvoyrkOeKulGA6OFoMkt3zG54rNVWA
   ocrbS/5jPgrkkNf2qillMj4YzaNv9zYi/bZRrLwSwpyNRIbDU2gkZKKhC
   TJJmWpEY65yXb3zFEYqRt7CbwLmKbsZQBxy6BUWo79SPBlAbHZwxEa17T
   C8qWiPHpN3vUHXhDcpWaUziyG+qqJioTVbDbyt5uitJ7zWm1TyxlNrIbm
   g==;
X-CSE-ConnectionGUID: zwcC+7MPSIm5uebaVReMMw==
X-CSE-MsgGUID: oq61MGBSS5uZ+8r6aKgIlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11407"; a="46814324"
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="46814324"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 13:49:37 -0700
X-CSE-ConnectionGUID: 3h+avi/hQi+Zoqa2PDMj2w==
X-CSE-MsgGUID: QMQv1QnpQK+zxNitfQoNYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,222,1739865600"; 
   d="scan'208";a="168406325"
Received: from unknown (HELO localhost.jf.intel.com) ([10.166.80.55])
  by orviesa001.jf.intel.com with ESMTP; 18 Apr 2025 13:49:37 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	milena.olech@intel.com,
	anton.nadezhdin@intel.com,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [PATCH iwl-next v2 8/9] idpf: avoid calling get_rx_ptypes for each vport
Date: Fri, 18 Apr 2025 13:49:18 -0700
Message-ID: <20250418204919.5875-9-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418204919.5875-1-pavan.kumar.linga@intel.com>
References: <20250418204919.5875-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX ptypes received from device control plane doesn't
depend on vport info, but might vary based on the queue model.
When the driver requests for ptypes, control plane fills both
ptype_id_10 (used for splitq) and ptype_id_8 (used for singleq)
fields of the virtchnl2_ptype response structure. This allows
to call get_rx_ptypes once at the adapter level instead of
each vport.

Parse and store the received ptypes of both splitq and singleq
in a separate lookup table. Respective lookup table is used based
on the queue model info. As part of the changes, pull the ptype
protocol parsing code into a separate function.

Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |   7 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   9 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   4 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 310 ++++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   1 -
 5 files changed, 174 insertions(+), 157 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 5eb2f8eb6964..a115c28defab 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -334,7 +334,6 @@ struct idpf_q_vec_rsrc {
  * @default_mac_addr: device will give a default MAC to use
  * @rx_itr_profile: RX profiles for Dynamic Interrupt Moderation
  * @tx_itr_profile: TX profiles for Dynamic Interrupt Moderation
- * @rx_ptype_lkup: Lookup table for ptypes on RX
  * @port_stats: per port csum, header split, and other offload stats
  * @default_vport: Use this vport if one isn't specified
  * @crc_enable: Enable CRC insertion offload
@@ -363,7 +362,6 @@ struct idpf_vport {
 	u16 rx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
 	u16 tx_itr_profile[IDPF_DIM_PROFILE_SLOTS];
 
-	struct libeth_rx_pt *rx_ptype_lkup;
 	struct idpf_port_stats port_stats;
 	bool default_vport;
 	bool crc_enable;
@@ -579,6 +577,8 @@ struct idpf_vc_xn_manager;
  * @vport_params_reqd: Vport params requested
  * @vport_params_recvd: Vport params received
  * @vport_ids: Array of device given vport identifiers
+ * @singleq_pt_lkup: Lookup table for singleq RX ptypes
+ * @splitq_pt_lkup: Lookup table for splitq RX ptypes
  * @vport_config: Vport config parameters
  * @max_vports: Maximum vports that can be allocated
  * @num_alloc_vports: Current number of vports allocated
@@ -635,6 +635,9 @@ struct idpf_adapter {
 	struct virtchnl2_create_vport **vport_params_recvd;
 	u32 *vport_ids;
 
+	struct libeth_rx_pt *singleq_pt_lkup;
+	struct libeth_rx_pt *splitq_pt_lkup;
+
 	struct idpf_vport_config **vport_config;
 	u16 max_vports;
 	u16 num_alloc_vports;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 95795abc8244..16119bfcbb20 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -901,9 +901,6 @@ static void idpf_decfg_netdev(struct idpf_vport *vport)
 	struct idpf_adapter *adapter = vport->adapter;
 	u16 idx = vport->idx;
 
-	kfree(vport->rx_ptype_lkup);
-	vport->rx_ptype_lkup = NULL;
-
 	if (test_and_clear_bit(IDPF_VPORT_REG_NETDEV,
 			       adapter->vport_config[idx]->flags)) {
 		unregister_netdev(vport->netdev);
@@ -1513,10 +1510,6 @@ void idpf_init_task(struct work_struct *work)
 	if (idpf_cfg_netdev(vport))
 		goto cfg_netdev_err;
 
-	err = idpf_send_get_rx_ptype_msg(vport);
-	if (err)
-		goto handle_err;
-
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
 	np->state = __IDPF_VPORT_DOWN;
@@ -1562,8 +1555,6 @@ void idpf_init_task(struct work_struct *work)
 
 	return;
 
-handle_err:
-	idpf_decfg_netdev(vport);
 cfg_netdev_err:
 	idpf_vport_rel(vport);
 	adapter->vports[index] = NULL;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 5aaaa391b6d1..c268a9114e74 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1458,6 +1458,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				struct idpf_q_vec_rsrc *rsrc,
 				u16 num_rxq)
 {
+	struct idpf_adapter *adapter = vport->adapter;
 	int k, err = 0;
 	bool hs;
 
@@ -1548,6 +1549,7 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 
 			if (!idpf_is_queue_model_split(rsrc->rxq_model)) {
 				q = rx_qgrp->singleq.rxqs[j];
+				q->rx_ptype_lkup = adapter->singleq_pt_lkup;
 				goto setup_rxq;
 			}
 			q = &rx_qgrp->splitq.rxq_sets[j]->rxq;
@@ -1558,10 +1560,10 @@ static int idpf_rxq_group_alloc(struct idpf_vport *vport,
 				      &rx_qgrp->splitq.bufq_sets[1].refillqs[j];
 
 			idpf_queue_assign(HSPLIT_EN, q, hs);
+			q->rx_ptype_lkup = adapter->splitq_pt_lkup;
 
 setup_rxq:
 			q->desc_count = rsrc->rxq_desc_count;
-			q->rx_ptype_lkup = vport->rx_ptype_lkup;
 			q->netdev = vport->netdev;
 			q->bufq_sets = rx_qgrp->splitq.bufq_sets;
 			q->idx = (i * num_rxq) + j;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d82a9d40c9bc..02fbdacf7e98 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2458,36 +2458,143 @@ static void idpf_finalize_ptype_lookup(struct libeth_rx_pt *ptype)
 	libeth_rx_pt_gen_hash_type(ptype);
 }
 
+/**
+ * idpf_parse_protocol_ids - parse protocol IDs for a given packet type
+ * @ptype: packet type to parse
+ * @rx_pt: store the parsed packet type info into
+ */
+static void idpf_parse_protocol_ids(struct virtchnl2_ptype *ptype,
+				    struct libeth_rx_pt *rx_pt)
+{
+	struct idpf_ptype_state pstate = {};
+
+	for (u32 j = 0; j < ptype->proto_id_count; j++) {
+		u16 id = le16_to_cpu(ptype->proto_id[j]);
+
+		switch (id) {
+		case VIRTCHNL2_PROTO_HDR_GRE:
+			if (pstate.tunnel_state == IDPF_PTYPE_TUNNEL_IP) {
+				rx_pt->tunnel_type =
+					LIBETH_RX_PT_TUNNEL_IP_GRENAT;
+				pstate.tunnel_state |=
+					IDPF_PTYPE_TUNNEL_IP_GRENAT;
+			}
+			break;
+		case VIRTCHNL2_PROTO_HDR_MAC:
+			rx_pt->outer_ip = LIBETH_RX_PT_OUTER_L2;
+			if (pstate.tunnel_state == IDPF_TUN_IP_GRE) {
+				rx_pt->tunnel_type =
+					LIBETH_RX_PT_TUNNEL_IP_GRENAT_MAC;
+				pstate.tunnel_state |=
+					IDPF_PTYPE_TUNNEL_IP_GRENAT_MAC;
+			}
+			break;
+		case VIRTCHNL2_PROTO_HDR_IPV4:
+			idpf_fill_ptype_lookup(rx_pt, &pstate, true, false);
+			break;
+		case VIRTCHNL2_PROTO_HDR_IPV6:
+			idpf_fill_ptype_lookup(rx_pt, &pstate, false, false);
+			break;
+		case VIRTCHNL2_PROTO_HDR_IPV4_FRAG:
+			idpf_fill_ptype_lookup(rx_pt, &pstate, true, true);
+			break;
+		case VIRTCHNL2_PROTO_HDR_IPV6_FRAG:
+			idpf_fill_ptype_lookup(rx_pt, &pstate, false, true);
+			break;
+		case VIRTCHNL2_PROTO_HDR_UDP:
+			rx_pt->inner_prot = LIBETH_RX_PT_INNER_UDP;
+			break;
+		case VIRTCHNL2_PROTO_HDR_TCP:
+			rx_pt->inner_prot = LIBETH_RX_PT_INNER_TCP;
+			break;
+		case VIRTCHNL2_PROTO_HDR_SCTP:
+			rx_pt->inner_prot = LIBETH_RX_PT_INNER_SCTP;
+			break;
+		case VIRTCHNL2_PROTO_HDR_ICMP:
+			rx_pt->inner_prot = LIBETH_RX_PT_INNER_ICMP;
+			break;
+		case VIRTCHNL2_PROTO_HDR_PAY:
+			rx_pt->payload_layer = LIBETH_RX_PT_PAYLOAD_L2;
+			break;
+		case VIRTCHNL2_PROTO_HDR_ICMPV6:
+		case VIRTCHNL2_PROTO_HDR_IPV6_EH:
+		case VIRTCHNL2_PROTO_HDR_PRE_MAC:
+		case VIRTCHNL2_PROTO_HDR_POST_MAC:
+		case VIRTCHNL2_PROTO_HDR_ETHERTYPE:
+		case VIRTCHNL2_PROTO_HDR_SVLAN:
+		case VIRTCHNL2_PROTO_HDR_CVLAN:
+		case VIRTCHNL2_PROTO_HDR_MPLS:
+		case VIRTCHNL2_PROTO_HDR_MMPLS:
+		case VIRTCHNL2_PROTO_HDR_PTP:
+		case VIRTCHNL2_PROTO_HDR_CTRL:
+		case VIRTCHNL2_PROTO_HDR_LLDP:
+		case VIRTCHNL2_PROTO_HDR_ARP:
+		case VIRTCHNL2_PROTO_HDR_ECP:
+		case VIRTCHNL2_PROTO_HDR_EAPOL:
+		case VIRTCHNL2_PROTO_HDR_PPPOD:
+		case VIRTCHNL2_PROTO_HDR_PPPOE:
+		case VIRTCHNL2_PROTO_HDR_IGMP:
+		case VIRTCHNL2_PROTO_HDR_AH:
+		case VIRTCHNL2_PROTO_HDR_ESP:
+		case VIRTCHNL2_PROTO_HDR_IKE:
+		case VIRTCHNL2_PROTO_HDR_NATT_KEEP:
+		case VIRTCHNL2_PROTO_HDR_L2TPV2:
+		case VIRTCHNL2_PROTO_HDR_L2TPV2_CONTROL:
+		case VIRTCHNL2_PROTO_HDR_L2TPV3:
+		case VIRTCHNL2_PROTO_HDR_GTP:
+		case VIRTCHNL2_PROTO_HDR_GTP_EH:
+		case VIRTCHNL2_PROTO_HDR_GTPCV2:
+		case VIRTCHNL2_PROTO_HDR_GTPC_TEID:
+		case VIRTCHNL2_PROTO_HDR_GTPU:
+		case VIRTCHNL2_PROTO_HDR_GTPU_UL:
+		case VIRTCHNL2_PROTO_HDR_GTPU_DL:
+		case VIRTCHNL2_PROTO_HDR_ECPRI:
+		case VIRTCHNL2_PROTO_HDR_VRRP:
+		case VIRTCHNL2_PROTO_HDR_OSPF:
+		case VIRTCHNL2_PROTO_HDR_TUN:
+		case VIRTCHNL2_PROTO_HDR_NVGRE:
+		case VIRTCHNL2_PROTO_HDR_VXLAN:
+		case VIRTCHNL2_PROTO_HDR_VXLAN_GPE:
+		case VIRTCHNL2_PROTO_HDR_GENEVE:
+		case VIRTCHNL2_PROTO_HDR_NSH:
+		case VIRTCHNL2_PROTO_HDR_QUIC:
+		case VIRTCHNL2_PROTO_HDR_PFCP:
+		case VIRTCHNL2_PROTO_HDR_PFCP_NODE:
+		case VIRTCHNL2_PROTO_HDR_PFCP_SESSION:
+		case VIRTCHNL2_PROTO_HDR_RTP:
+		case VIRTCHNL2_PROTO_HDR_NO_PROTO:
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 /**
  * idpf_send_get_rx_ptype_msg - Send virtchnl for ptype info
- * @vport: virtual port data structure
+ * @adapter: driver specific private structure
  *
  * Returns 0 on success, negative on failure.
  */
-int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
+static int idpf_send_get_rx_ptype_msg(struct idpf_adapter *adapter)
 {
 	struct virtchnl2_get_ptype_info *get_ptype_info __free(kfree) = NULL;
 	struct virtchnl2_get_ptype_info *ptype_info __free(kfree) = NULL;
-	struct libeth_rx_pt *ptype_lkup __free(kfree) = NULL;
-	int max_ptype, ptypes_recvd = 0, ptype_offset;
-	struct idpf_adapter *adapter = vport->adapter;
+	struct libeth_rx_pt *singleq_pt_lkup __free(kfree) = NULL;
+	struct libeth_rx_pt *splitq_pt_lkup __free(kfree) = NULL;
 	struct idpf_vc_xn_params xn_params = {};
+	int ptypes_recvd = 0, ptype_offset;
+	u32 max_ptype = IDPF_RX_MAX_PTYPE;
 	u16 next_ptype_id = 0;
 	ssize_t reply_sz;
-	bool is_splitq;
-	int i, j, k;
-
-	if (vport->rx_ptype_lkup)
-		return 0;
 
-	is_splitq = idpf_is_queue_model_split(vport->dflt_qv_rsrc.rxq_model);
-	if (is_splitq)
-		max_ptype = IDPF_RX_MAX_PTYPE;
-	else
-		max_ptype = IDPF_RX_MAX_BASE_PTYPE;
+	singleq_pt_lkup = kcalloc(IDPF_RX_MAX_BASE_PTYPE,
+				  sizeof(*singleq_pt_lkup), GFP_KERNEL);
+	if (!singleq_pt_lkup)
+		return -ENOMEM;
 
-	ptype_lkup = kcalloc(max_ptype, sizeof(*ptype_lkup), GFP_KERNEL);
-	if (!ptype_lkup)
+	splitq_pt_lkup = kcalloc(max_ptype, sizeof(*splitq_pt_lkup), GFP_KERNEL);
+	if (!splitq_pt_lkup)
 		return -ENOMEM;
 
 	get_ptype_info = kzalloc(sizeof(*get_ptype_info), GFP_KERNEL);
@@ -2528,154 +2635,59 @@ int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport)
 
 		ptype_offset = IDPF_RX_PTYPE_HDR_SZ;
 
-		for (i = 0; i < le16_to_cpu(ptype_info->num_ptypes); i++) {
-			struct idpf_ptype_state pstate = { };
+		for (u16 i = 0; i < le16_to_cpu(ptype_info->num_ptypes); i++) {
+			struct libeth_rx_pt rx_pt = {};
 			struct virtchnl2_ptype *ptype;
-			u16 id;
+			u16 pt_10, pt_8;
 
 			ptype = (struct virtchnl2_ptype *)
 					((u8 *)ptype_info + ptype_offset);
 
+			pt_10 = le16_to_cpu(ptype->ptype_id_10);
+			pt_8 = ptype->ptype_id_8;
+
 			ptype_offset += IDPF_GET_PTYPE_SIZE(ptype);
 			if (ptype_offset > IDPF_CTLQ_MAX_BUF_LEN)
 				return -EINVAL;
 
 			/* 0xFFFF indicates end of ptypes */
-			if (le16_to_cpu(ptype->ptype_id_10) ==
-							IDPF_INVALID_PTYPE_ID)
+			if (pt_10 == IDPF_INVALID_PTYPE_ID)
 				goto out;
 
-			if (is_splitq)
-				k = le16_to_cpu(ptype->ptype_id_10);
-			else
-				k = ptype->ptype_id_8;
-
-			for (j = 0; j < ptype->proto_id_count; j++) {
-				id = le16_to_cpu(ptype->proto_id[j]);
-				switch (id) {
-				case VIRTCHNL2_PROTO_HDR_GRE:
-					if (pstate.tunnel_state ==
-							IDPF_PTYPE_TUNNEL_IP) {
-						ptype_lkup[k].tunnel_type =
-						LIBETH_RX_PT_TUNNEL_IP_GRENAT;
-						pstate.tunnel_state |=
-						IDPF_PTYPE_TUNNEL_IP_GRENAT;
-					}
-					break;
-				case VIRTCHNL2_PROTO_HDR_MAC:
-					ptype_lkup[k].outer_ip =
-						LIBETH_RX_PT_OUTER_L2;
-					if (pstate.tunnel_state ==
-							IDPF_TUN_IP_GRE) {
-						ptype_lkup[k].tunnel_type =
-						LIBETH_RX_PT_TUNNEL_IP_GRENAT_MAC;
-						pstate.tunnel_state |=
-						IDPF_PTYPE_TUNNEL_IP_GRENAT_MAC;
-					}
-					break;
-				case VIRTCHNL2_PROTO_HDR_IPV4:
-					idpf_fill_ptype_lookup(&ptype_lkup[k],
-							       &pstate, true,
-							       false);
-					break;
-				case VIRTCHNL2_PROTO_HDR_IPV6:
-					idpf_fill_ptype_lookup(&ptype_lkup[k],
-							       &pstate, false,
-							       false);
-					break;
-				case VIRTCHNL2_PROTO_HDR_IPV4_FRAG:
-					idpf_fill_ptype_lookup(&ptype_lkup[k],
-							       &pstate, true,
-							       true);
-					break;
-				case VIRTCHNL2_PROTO_HDR_IPV6_FRAG:
-					idpf_fill_ptype_lookup(&ptype_lkup[k],
-							       &pstate, false,
-							       true);
-					break;
-				case VIRTCHNL2_PROTO_HDR_UDP:
-					ptype_lkup[k].inner_prot =
-					LIBETH_RX_PT_INNER_UDP;
-					break;
-				case VIRTCHNL2_PROTO_HDR_TCP:
-					ptype_lkup[k].inner_prot =
-					LIBETH_RX_PT_INNER_TCP;
-					break;
-				case VIRTCHNL2_PROTO_HDR_SCTP:
-					ptype_lkup[k].inner_prot =
-					LIBETH_RX_PT_INNER_SCTP;
-					break;
-				case VIRTCHNL2_PROTO_HDR_ICMP:
-					ptype_lkup[k].inner_prot =
-					LIBETH_RX_PT_INNER_ICMP;
-					break;
-				case VIRTCHNL2_PROTO_HDR_PAY:
-					ptype_lkup[k].payload_layer =
-						LIBETH_RX_PT_PAYLOAD_L2;
-					break;
-				case VIRTCHNL2_PROTO_HDR_ICMPV6:
-				case VIRTCHNL2_PROTO_HDR_IPV6_EH:
-				case VIRTCHNL2_PROTO_HDR_PRE_MAC:
-				case VIRTCHNL2_PROTO_HDR_POST_MAC:
-				case VIRTCHNL2_PROTO_HDR_ETHERTYPE:
-				case VIRTCHNL2_PROTO_HDR_SVLAN:
-				case VIRTCHNL2_PROTO_HDR_CVLAN:
-				case VIRTCHNL2_PROTO_HDR_MPLS:
-				case VIRTCHNL2_PROTO_HDR_MMPLS:
-				case VIRTCHNL2_PROTO_HDR_PTP:
-				case VIRTCHNL2_PROTO_HDR_CTRL:
-				case VIRTCHNL2_PROTO_HDR_LLDP:
-				case VIRTCHNL2_PROTO_HDR_ARP:
-				case VIRTCHNL2_PROTO_HDR_ECP:
-				case VIRTCHNL2_PROTO_HDR_EAPOL:
-				case VIRTCHNL2_PROTO_HDR_PPPOD:
-				case VIRTCHNL2_PROTO_HDR_PPPOE:
-				case VIRTCHNL2_PROTO_HDR_IGMP:
-				case VIRTCHNL2_PROTO_HDR_AH:
-				case VIRTCHNL2_PROTO_HDR_ESP:
-				case VIRTCHNL2_PROTO_HDR_IKE:
-				case VIRTCHNL2_PROTO_HDR_NATT_KEEP:
-				case VIRTCHNL2_PROTO_HDR_L2TPV2:
-				case VIRTCHNL2_PROTO_HDR_L2TPV2_CONTROL:
-				case VIRTCHNL2_PROTO_HDR_L2TPV3:
-				case VIRTCHNL2_PROTO_HDR_GTP:
-				case VIRTCHNL2_PROTO_HDR_GTP_EH:
-				case VIRTCHNL2_PROTO_HDR_GTPCV2:
-				case VIRTCHNL2_PROTO_HDR_GTPC_TEID:
-				case VIRTCHNL2_PROTO_HDR_GTPU:
-				case VIRTCHNL2_PROTO_HDR_GTPU_UL:
-				case VIRTCHNL2_PROTO_HDR_GTPU_DL:
-				case VIRTCHNL2_PROTO_HDR_ECPRI:
-				case VIRTCHNL2_PROTO_HDR_VRRP:
-				case VIRTCHNL2_PROTO_HDR_OSPF:
-				case VIRTCHNL2_PROTO_HDR_TUN:
-				case VIRTCHNL2_PROTO_HDR_NVGRE:
-				case VIRTCHNL2_PROTO_HDR_VXLAN:
-				case VIRTCHNL2_PROTO_HDR_VXLAN_GPE:
-				case VIRTCHNL2_PROTO_HDR_GENEVE:
-				case VIRTCHNL2_PROTO_HDR_NSH:
-				case VIRTCHNL2_PROTO_HDR_QUIC:
-				case VIRTCHNL2_PROTO_HDR_PFCP:
-				case VIRTCHNL2_PROTO_HDR_PFCP_NODE:
-				case VIRTCHNL2_PROTO_HDR_PFCP_SESSION:
-				case VIRTCHNL2_PROTO_HDR_RTP:
-				case VIRTCHNL2_PROTO_HDR_NO_PROTO:
-					break;
-				default:
-					break;
-				}
-			}
+			idpf_parse_protocol_ids(ptype, &rx_pt);
+			idpf_finalize_ptype_lookup(&rx_pt);
 
-			idpf_finalize_ptype_lookup(&ptype_lkup[k]);
+			/* For a given protocol ID stack, the ptype value might
+			 * vary between ptype_id_10 and ptype_id_8. So store
+			 * them separately for splitq and singleq. Also skip
+			 * the repeated ptypes in case of singleq.
+			 */
+			splitq_pt_lkup[pt_10] = rx_pt;
+			if (!singleq_pt_lkup[pt_8].outer_ip)
+				singleq_pt_lkup[pt_8] = rx_pt;
 		}
 	}
 
 out:
-	vport->rx_ptype_lkup = no_free_ptr(ptype_lkup);
+	adapter->splitq_pt_lkup = no_free_ptr(splitq_pt_lkup);
+	adapter->singleq_pt_lkup = no_free_ptr(singleq_pt_lkup);
 
 	return 0;
 }
 
+/**
+ * idpf_rel_rx_pt_lkup - release RX ptype lookup table
+ * @adapter: adapter pointer to get the lookup table
+ */
+static void idpf_rel_rx_pt_lkup(struct idpf_adapter *adapter)
+{
+	kfree(adapter->splitq_pt_lkup);
+	adapter->splitq_pt_lkup = NULL;
+
+	kfree(adapter->singleq_pt_lkup);
+	adapter->singleq_pt_lkup = NULL;
+}
+
 /**
  * idpf_send_ena_dis_loopback_msg - Send virtchnl enable/disable loopback
  *				    message
@@ -2949,6 +2961,13 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		goto err_intr_req;
 	}
 
+	err = idpf_send_get_rx_ptype_msg(adapter);
+	if (err) {
+		dev_err(&adapter->pdev->dev, "failed to get RX ptypes: %d\n",
+			err);
+		goto intr_rel;
+	}
+
 	err = idpf_ptp_init(adapter);
 	if (err)
 		pci_err(adapter->pdev, "PTP init failed, err=%pe\n", ERR_PTR(err));
@@ -2965,6 +2984,8 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 
 	return 0;
 
+intr_rel:
+	idpf_intr_rel(adapter);
 err_intr_req:
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->mbx_task);
@@ -3017,6 +3038,7 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
+	idpf_rel_rx_pt_lkup(adapter);
 	idpf_intr_rel(adapter);
 
 	if (remove_in_prog)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 57cb05372ce6..05b59a14dcbc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -162,7 +162,6 @@ int idpf_set_promiscuous(struct idpf_adapter *adapter,
 			 struct idpf_vport_user_config_data *config_data,
 			 u32 vport_id);
 int idpf_check_supported_desc_ids(struct idpf_vport *vport);
-int idpf_send_get_rx_ptype_msg(struct idpf_vport *vport);
 int idpf_send_ena_dis_loopback_msg(struct idpf_adapter *adapter, u32 vport_id,
 				   bool loopback_ena);
 int idpf_send_get_stats_msg(struct idpf_netdev_priv *np,
-- 
2.43.0


