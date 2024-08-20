Return-Path: <netdev+bounces-120248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791A5958AD9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FB42829D9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3806D191F60;
	Tue, 20 Aug 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiUB6SgP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F71922CB
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166825; cv=none; b=EwZhhXRGqU2fUNS9vDgNrh52V/p5Y+/gupKXolQ4+0dQUmDQSWG+mfwCv3u6YtByb83We2bGwnJNaRBaYKShbl0TXvUoZyI07VigQiUbUhxIuaifDELyf+ArMhwpphE6Yi34lXWne+Puz1oRYYlKTPrsb6ufgbTkf/8bKZfBuzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166825; c=relaxed/simple;
	bh=rfdvc9b9bZniyqFUq/GRcl1p6yUqP+sVg+lxFNKQihg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BOG+8D3TX7eNW72eUZ4+U0CoYLCCJVM4y89nQq13N2/zs45zjFibnmVHSYVq323pMpjEhZkkf48ELOaWErzvvNLOzoDMv5myVFaolqBvpNhPs/l++J5dCIXiKIy2g5vR4Nh9YIZU4VKs1eG2RN1sMzVqyokvFBfHYVlD64voI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiUB6SgP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724166822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx0qAntOjDXvUoPhdK6OH+djyDvpAlNINxQF+OH7kGs=;
	b=LiUB6SgPPthGQSONBh/85pPPdRaj45IxgCxibDJM1CSrD55JKhjDUWJG+lAF/EvUclrozc
	Am2bQQTfIiX8c+m6z+N2MCnXkR0kEB13iYln/cvdNR3onkxmZdQVaXSnw9qn7+yF8XuAd8
	2ftTC8q1IKFdeKI6KaeeIRcqiJaOcko=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-tHy-ow8tOoK7mgZpqRYPTw-1; Tue,
 20 Aug 2024 11:13:38 -0400
X-MC-Unique: tHy-ow8tOoK7mgZpqRYPTw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B4021955D54;
	Tue, 20 Aug 2024 15:13:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.213])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 484BD19560AA;
	Tue, 20 Aug 2024 15:13:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH v4 net-next 10/12] virtchnl: support queue rate limit and quanta size configuration
Date: Tue, 20 Aug 2024 17:12:31 +0200
Message-ID: <8d5a363c15d4122c9df37feedcd7da2090e4ba68.1724165948.git.pabeni@redhat.com>
In-Reply-To: <cover.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Wenjun Wu <wenjun1.wu@intel.com>

This patch adds new virtchnl opcodes and structures for rate limit
and quanta size configuration, which include:
1. VIRTCHNL_OP_CONFIG_QUEUE_BW, to configure max bandwidth for each
VF per queue.
2. VIRTCHNL_OP_CONFIG_QUANTA, to configure quanta size per queue.
3. VIRTCHNL_OP_GET_QOS_CAPS, VF queries current QoS configuration, such
as enabled TCs, arbiter type, up2tc and bandwidth of VSI node. The
configuration is previously set by DCB and PF, and now is the potential
QoS capability of VF. VF can take it as reference to configure queue TC
mapping.

Signed-off-by: Wenjun Wu <wenjun1.wu@intel.com>
---
 include/linux/avf/virtchnl.h | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index f41395264dca..223e433c39fe 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -89,6 +89,9 @@ enum virtchnl_rx_hsplit {
 	VIRTCHNL_RX_HSPLIT_SPLIT_SCTP    = 8,
 };
 
+enum virtchnl_bw_limit_type {
+	VIRTCHNL_BW_SHAPER = 0,
+};
 /* END GENERIC DEFINES */
 
 /* Opcodes for VF-PF communication. These are placed in the v_opcode field
@@ -151,6 +154,11 @@ enum virtchnl_ops {
 	VIRTCHNL_OP_DISABLE_VLAN_STRIPPING_V2 = 55,
 	VIRTCHNL_OP_ENABLE_VLAN_INSERTION_V2 = 56,
 	VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2 = 57,
+	/* opcode 57 - 65 are reserved */
+	VIRTCHNL_OP_GET_QOS_CAPS = 66,
+	/* opcode 68 through 111 are reserved */
+	VIRTCHNL_OP_CONFIG_QUEUE_BW = 112,
+	VIRTCHNL_OP_CONFIG_QUANTA = 113,
 	VIRTCHNL_OP_MAX,
 };
 
@@ -261,6 +269,7 @@ VIRTCHNL_CHECK_STRUCT_LEN(16, virtchnl_vsi_resource);
 #define VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC	BIT(26)
 #define VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF		BIT(27)
 #define VIRTCHNL_VF_OFFLOAD_FDIR_PF		BIT(28)
+#define VIRTCHNL_VF_OFFLOAD_QOS			BIT(29)
 
 #define VF_BASE_MODE_OFFLOADS (VIRTCHNL_VF_OFFLOAD_L2 | \
 			       VIRTCHNL_VF_OFFLOAD_VLAN | \
@@ -1416,6 +1425,85 @@ struct virtchnl_fdir_del {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 
+struct virtchnl_shaper_bw {
+	/* Unit is Kbps */
+	u32 committed;
+	u32 peak;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_shaper_bw);
+
+/* VIRTCHNL_OP_GET_QOS_CAPS
+ * VF sends this message to get its QoS Caps, such as
+ * TC number, Arbiter and Bandwidth.
+ */
+struct virtchnl_qos_cap_elem {
+	u8 tc_num;
+	u8 tc_prio;
+#define VIRTCHNL_ABITER_STRICT      0
+#define VIRTCHNL_ABITER_ETS         2
+	u8 arbiter;
+#define VIRTCHNL_STRICT_WEIGHT      1
+	u8 weight;
+	enum virtchnl_bw_limit_type type;
+	union {
+		struct virtchnl_shaper_bw shaper;
+		u8 pad2[32];
+	};
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(40, virtchnl_qos_cap_elem);
+
+struct virtchnl_qos_cap_list {
+	u16 vsi_id;
+	u16 num_elem;
+	struct virtchnl_qos_cap_elem cap[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_qos_cap_list);
+#define virtchnl_qos_cap_list_LEGACY_SIZEOF	44
+
+/* VIRTCHNL_OP_CONFIG_QUEUE_BW */
+struct virtchnl_queue_bw {
+	u16 queue_id;
+	u8 tc;
+	u8 pad;
+	struct virtchnl_shaper_bw shaper;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_queue_bw);
+
+struct virtchnl_queues_bw_cfg {
+	u16 vsi_id;
+	u16 num_queues;
+	struct virtchnl_queue_bw cfg[];
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_queues_bw_cfg);
+#define virtchnl_queues_bw_cfg_LEGACY_SIZEOF	16
+
+enum virtchnl_queue_type {
+	VIRTCHNL_QUEUE_TYPE_TX			= 0,
+	VIRTCHNL_QUEUE_TYPE_RX			= 1,
+};
+
+/* structure to specify a chunk of contiguous queues */
+struct virtchnl_queue_chunk {
+	/* see enum virtchnl_queue_type */
+	s32 type;
+	u16 start_queue_id;
+	u16 num_queues;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(8, virtchnl_queue_chunk);
+
+struct virtchnl_quanta_cfg {
+	u16 quanta_size;
+	struct virtchnl_queue_chunk queue_select;
+};
+
+VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_quanta_cfg);
+
 #define __vss_byone(p, member, count, old)				      \
 	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
 
@@ -1438,6 +1526,8 @@ VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 		 __vss(virtchnl_vlan_filter_list_v2, __vss_byelem, p, m, c),  \
 		 __vss(virtchnl_tc_info, __vss_byelem, p, m, c),	      \
 		 __vss(virtchnl_rdma_qvlist_info, __vss_byelem, p, m, c),     \
+		 __vss(virtchnl_qos_cap_list, __vss_byelem, p, m, c),	      \
+		 __vss(virtchnl_queues_bw_cfg, __vss_byelem, p, m, c),	      \
 		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
 		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
 
@@ -1637,6 +1727,35 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 	case VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2:
 		valid_len = sizeof(struct virtchnl_vlan_setting);
 		break;
+	case VIRTCHNL_OP_GET_QOS_CAPS:
+		break;
+	case VIRTCHNL_OP_CONFIG_QUEUE_BW:
+		valid_len = virtchnl_queues_bw_cfg_LEGACY_SIZEOF;
+		if (msglen >= valid_len) {
+			struct virtchnl_queues_bw_cfg *q_bw =
+				(struct virtchnl_queues_bw_cfg *)msg;
+
+			valid_len = virtchnl_struct_size(q_bw, cfg,
+							 q_bw->num_queues);
+			if (q_bw->num_queues == 0) {
+				err_msg_format = true;
+				break;
+			}
+		}
+		break;
+	case VIRTCHNL_OP_CONFIG_QUANTA:
+		valid_len = sizeof(struct virtchnl_quanta_cfg);
+		if (msglen >= valid_len) {
+			struct virtchnl_quanta_cfg *q_quanta =
+				(struct virtchnl_quanta_cfg *)msg;
+
+			if (q_quanta->quanta_size == 0 ||
+			    q_quanta->queue_select.num_queues == 0) {
+				err_msg_format = true;
+				break;
+			}
+		}
+		break;
 	/* These are always errors coming from the VF. */
 	case VIRTCHNL_OP_EVENT:
 	case VIRTCHNL_OP_UNKNOWN:
-- 
2.45.2


