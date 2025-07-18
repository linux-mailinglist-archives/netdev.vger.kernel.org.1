Return-Path: <netdev+bounces-208224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECFB0AA63
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7552B1C44C55
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF522E92B0;
	Fri, 18 Jul 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5pBUoIG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA32E8895;
	Fri, 18 Jul 2025 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864690; cv=none; b=cKXRxlUqzXXKjZSQezHQojNuZMEVCCGHWHnWLMrjTqI05kd2XYanFadAB8T/AKt7ZTqn7qHAD5/nPpGJDx0HSu66N7Mrt5D1QJQ2Asqbyx0CN/nmX5PkOjJc2CMUTe8yIuRU+FsZdWLIRR5wjb0m1fRCS3tLOBM7BhOC4YRwGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864690; c=relaxed/simple;
	bh=QJf25gQklWQ4lx8IETGrpDakfAz22R9rNaM7XKEom3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH8OE5hvyXLDF6dZuz7QdH2iyVgmwmowjFl2FhhZVCn0NkkpeXFZyIdWk5stGo/UkhArpsgI9f7o/Q+6B3CCk/y87UK7NGuB3u4dOT9LV3yGZPh4m/HN8vtIZfVuSaKnmwHSA9H1BGVPYSyOlbBM+KdRNyI9qM99r2TZVnR/sgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5pBUoIG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864686; x=1784400686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJf25gQklWQ4lx8IETGrpDakfAz22R9rNaM7XKEom3M=;
  b=d5pBUoIGkv8ZK6mACdrr5tVZtzpf98LNl2ujt3gZUbdCLGKjRYFbqBlV
   iCDECtfNdbTrZhTsjE94+zJ1HvWzjBRKtJF4sivkMcqUIvQzOyXVvSmCx
   6sO6rW7ejErTdvHLyevTmhd6+fLI+pxY1IhrESwH63EfTuTYiPeRhcioG
   VT8QCZqSUd0K3O05WpUMlCJR8dE5Rj2Q9so1L5R7HjBoFYEHP3PLdaoCc
   M43lxl4FR7XdxDliFQrxvio1U7gtNQ9r3akcaB0ggZ7N3WTOdIuQP6ikG
   odOzWs7cx9avtn4TNI+1TNCFYyZyr0ex/pjKmIFE2jM1vWRY2eSdVqkTj
   A==;
X-CSE-ConnectionGUID: vFasM61TTmSrXpZBhN+JkA==
X-CSE-MsgGUID: UoHtg8gGQiufuW1osYfBmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320560"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320560"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:24 -0700
X-CSE-ConnectionGUID: wEJ8v0ZwSZ+v/660h1HLkA==
X-CSE-MsgGUID: Lb03VfF7S4GpM+XujZ0mXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506880"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	almasrymina@google.com,
	willemb@google.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 02/13] virtchnl2: add flow steering support
Date: Fri, 18 Jul 2025 11:51:03 -0700
Message-ID: <20250718185118.2042772-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Add opcodes and corresponding message structure to add and delete
flow steering rules. Flow steering enables configuration
of rules to take an action or subset of actions based on a match
criteria. Actions could be redirect to queue, redirect to queue
group, drop packet or mark.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Co-developed-by: Dinesh Kumar <dinesh.kumar@intel.com>
Signed-off-by: Dinesh Kumar <dinesh.kumar@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 209 +++++++++++++++++++-
 1 file changed, 202 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 8d316aa701ad..02ae447cc24a 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -80,6 +80,10 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_PTP_ADJ_DEV_CLK_TIME		= 547,
 	VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP_CAPS	= 548,
 	VIRTCHNL2_OP_GET_LAN_MEMORY_REGIONS		= 549,
+	/* Opcode 550 is reserved */
+	VIRTCHNL2_OP_ADD_FLOW_RULE			= 551,
+	VIRTCHNL2_OP_GET_FLOW_RULE			= 552,
+	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 };
 
 /**
@@ -194,8 +198,9 @@ enum virtchnl2_cap_other {
 	VIRTCHNL2_CAP_RDMA			= BIT_ULL(0),
 	VIRTCHNL2_CAP_SRIOV			= BIT_ULL(1),
 	VIRTCHNL2_CAP_MACFILTER			= BIT_ULL(2),
-	VIRTCHNL2_CAP_FLOW_DIRECTOR		= BIT_ULL(3),
-	/* Queue based scheduling using split queue model */
+	/* Other capability 3 is available
+	 * Queue based scheduling using split queue model
+	 */
 	VIRTCHNL2_CAP_SPLITQ_QSCHED		= BIT_ULL(4),
 	VIRTCHNL2_CAP_CRC			= BIT_ULL(5),
 	VIRTCHNL2_CAP_ADQ			= BIT_ULL(6),
@@ -209,17 +214,37 @@ enum virtchnl2_cap_other {
 	/* EDT: Earliest Departure Time capability used for Timing Wheel */
 	VIRTCHNL2_CAP_EDT			= BIT_ULL(14),
 	VIRTCHNL2_CAP_ADV_RSS			= BIT_ULL(15),
-	VIRTCHNL2_CAP_FDIR			= BIT_ULL(16),
+	/* Other capability 16 is available */
 	VIRTCHNL2_CAP_RX_FLEX_DESC		= BIT_ULL(17),
 	VIRTCHNL2_CAP_PTYPE			= BIT_ULL(18),
 	VIRTCHNL2_CAP_LOOPBACK			= BIT_ULL(19),
-	/* Other capability 20-21 is reserved */
+	/* Other capability 20 is reserved */
+	VIRTCHNL2_CAP_FLOW_STEER		= BIT_ULL(21),
 	VIRTCHNL2_CAP_LAN_MEMORY_REGIONS	= BIT_ULL(22),
 
 	/* this must be the last capability */
 	VIRTCHNL2_CAP_OEM			= BIT_ULL(63),
 };
 
+/**
+ * enum virtchnl2_action_types - Available actions for sideband flow steering
+ * @VIRTCHNL2_ACTION_DROP: Drop the packet
+ * @VIRTCHNL2_ACTION_PASSTHRU: Forward the packet to the next classifier/stage
+ * @VIRTCHNL2_ACTION_QUEUE: Forward the packet to a receive queue
+ * @VIRTCHNL2_ACTION_Q_GROUP: Forward the packet to a receive queue group
+ * @VIRTCHNL2_ACTION_MARK: Mark the packet with specific marker value
+ * @VIRTCHNL2_ACTION_COUNT: Increment the corresponding counter
+ */
+
+enum virtchnl2_action_types {
+	VIRTCHNL2_ACTION_DROP		= BIT(0),
+	VIRTCHNL2_ACTION_PASSTHRU	= BIT(1),
+	VIRTCHNL2_ACTION_QUEUE		= BIT(2),
+	VIRTCHNL2_ACTION_Q_GROUP	= BIT(3),
+	VIRTCHNL2_ACTION_MARK		= BIT(4),
+	VIRTCHNL2_ACTION_COUNT		= BIT(5),
+};
+
 /* underlying device type */
 enum virtchl2_device_type {
 	VIRTCHNL2_MEV_DEVICE			= 0,
@@ -578,11 +603,17 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 /**
  * enum virtchnl2_vport_flags - Vport flags that indicate vport capabilities.
  * @VIRTCHNL2_VPORT_UPLINK_PORT: Representatives of underlying physical ports
+ * @VIRTCHNL2_VPORT_INLINE_FLOW_STEER: Inline flow steering enabled
+ * @VIRTCHNL2_VPORT_INLINE_FLOW_STEER_RXQ: Inline flow steering enabled
+ *  with explicit Rx queue action
+ * @VIRTCHNL2_VPORT_SIDEBAND_FLOW_STEER: Sideband flow steering enabled
  * @VIRTCHNL2_VPORT_ENABLE_RDMA: RDMA is enabled for this vport
  */
 enum virtchnl2_vport_flags {
-	VIRTCHNL2_VPORT_UPLINK_PORT	= BIT(0),
-	/* VIRTCHNL2_VPORT_* bits [1:3] rsvd */
+	VIRTCHNL2_VPORT_UPLINK_PORT		= BIT(0),
+	VIRTCHNL2_VPORT_INLINE_FLOW_STEER	= BIT(1),
+	VIRTCHNL2_VPORT_INLINE_FLOW_STEER_RXQ	= BIT(2),
+	VIRTCHNL2_VPORT_SIDEBAND_FLOW_STEER	= BIT(3),
 	VIRTCHNL2_VPORT_ENABLE_RDMA             = BIT(4),
 };
 
@@ -608,6 +639,14 @@ enum virtchnl2_vport_flags {
  * @rx_desc_ids: See VIRTCHNL2_RX_DESC_IDS definitions.
  * @tx_desc_ids: See VIRTCHNL2_TX_DESC_IDS definitions.
  * @pad1: Padding.
+ * @inline_flow_caps: Bit mask of supported inline-flow-steering
+ *  flow types (See enum virtchnl2_flow_types)
+ * @sideband_flow_caps: Bit mask of supported sideband-flow-steering
+ *  flow types (See enum virtchnl2_flow_types)
+ * @sideband_flow_actions: Bit mask of supported action types
+ *  for sideband flow steering (See enum virtchnl2_action_types)
+ * @flow_steer_max_rules: Max rules allowed for inline and sideband
+ *  flow steering combined
  * @rss_algorithm: RSS algorithm.
  * @rss_key_size: RSS key size.
  * @rss_lut_size: RSS LUT size.
@@ -640,7 +679,11 @@ struct virtchnl2_create_vport {
 	__le16 vport_flags;
 	__le64 rx_desc_ids;
 	__le64 tx_desc_ids;
-	u8 pad1[72];
+	u8 pad1[48];
+	__le64 inline_flow_caps;
+	__le64 sideband_flow_caps;
+	__le32 sideband_flow_actions;
+	__le32 flow_steer_max_rules;
 	__le32 rss_algorithm;
 	__le16 rss_key_size;
 	__le16 rss_lut_size;
@@ -1615,4 +1658,156 @@ struct virtchnl2_get_lan_memory_regions {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_get_lan_memory_regions);
 
+#define VIRTCHNL2_MAX_NUM_PROTO_HDRS	4
+#define VIRTCHNL2_MAX_SIZE_RAW_PACKET	256
+#define VIRTCHNL2_MAX_NUM_ACTIONS	8
+
+/**
+ * struct virtchnl2_proto_hdr - represent one protocol header
+ * @hdr_type: See enum virtchnl2_proto_hdr_type
+ * @pad: padding
+ * @buffer_spec: binary buffer based on header type.
+ * @buffer_mask: mask applied on buffer_spec.
+ *
+ * Structure to hold protocol headers based on hdr_type
+ */
+struct virtchnl2_proto_hdr {
+	__le32 hdr_type;
+	u8 pad[4];
+	u8 buffer_spec[64];
+	u8 buffer_mask[64];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(136, virtchnl2_proto_hdr);
+
+/**
+ * struct virtchnl2_proto_hdrs - struct to represent match criteria
+ * @tunnel_level: specify where protocol header(s) start from.
+ *                 must be 0 when sending a raw packet request.
+ *                 0 - from the outer layer
+ *                 1 - from the first inner layer
+ *                 2 - from the second inner layer
+ * @pad: Padding bytes
+ * @count: total number of protocol headers in proto_hdr. 0 for raw packet.
+ * @proto_hdr: Array of protocol headers
+ * @raw: struct holding raw packet buffer when count is 0
+ */
+struct virtchnl2_proto_hdrs {
+	u8 tunnel_level;
+	u8 pad[3];
+	__le32 count;
+	union {
+		struct virtchnl2_proto_hdr
+			proto_hdr[VIRTCHNL2_MAX_NUM_PROTO_HDRS];
+		struct {
+			__le16 pkt_len;
+			u8 spec[VIRTCHNL2_MAX_SIZE_RAW_PACKET];
+			u8 mask[VIRTCHNL2_MAX_SIZE_RAW_PACKET];
+		} raw;
+	};
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(552, virtchnl2_proto_hdrs);
+
+/**
+ * struct virtchnl2_rule_action - struct representing single action for a flow
+ * @action_type: see enum virtchnl2_action_types
+ * @act_conf: union representing action depending on action_type.
+ * @act_conf.q_id: queue id to redirect the packets to.
+ * @act_conf.q_grp_id: queue group id to redirect the packets to.
+ * @act_conf.ctr_id: used for count action. If input value 0xFFFFFFFF control
+ *                    plane assigns a new counter and returns the counter ID to
+ *                    the driver. If input value is not 0xFFFFFFFF then it must
+ *                    be an existing counter given to the driver for an earlier
+ *                    flow. Then this flow will share the counter.
+ * @act_conf.mark_id: Value used to mark the packets. Used for mark action.
+ * @act_conf.reserved: Reserved for future use.
+ */
+struct virtchnl2_rule_action {
+	__le32 action_type;
+	union {
+		__le32 q_id;
+		__le32 q_grp_id;
+		__le32 ctr_id;
+		__le32 mark_id;
+		u8 reserved[8];
+	} act_conf;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(12, virtchnl2_rule_action);
+
+/**
+ * struct virtchnl2_rule_action_set - struct representing multiple actions
+ * @count: number of valid actions in the action set of a rule
+ * @actions: array of struct virtchnl2_rule_action
+ */
+struct virtchnl2_rule_action_set {
+	/* action count must be less than VIRTCHNL2_MAX_NUM_ACTIONS */
+	__le32 count;
+	struct virtchnl2_rule_action actions[VIRTCHNL2_MAX_NUM_ACTIONS];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(100, virtchnl2_rule_action_set);
+
+/**
+ * struct virtchnl2_flow_rule - represent one flow steering rule
+ * @proto_hdrs: array of protocol header buffers representing match criteria
+ * @action_set: series of actions to be applied for given rule
+ * @priority: rule priority.
+ * @pad: padding for future extensions.
+ */
+struct virtchnl2_flow_rule {
+	struct virtchnl2_proto_hdrs proto_hdrs;
+	struct virtchnl2_rule_action_set action_set;
+	__le32 priority;
+	u8 pad[8];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(664, virtchnl2_flow_rule);
+
+enum virtchnl2_flow_rule_status {
+	VIRTCHNL2_FLOW_RULE_SUCCESS			= 1,
+	VIRTCHNL2_FLOW_RULE_NORESOURCE			= 2,
+	VIRTCHNL2_FLOW_RULE_EXIST			= 3,
+	VIRTCHNL2_FLOW_RULE_TIMEOUT			= 4,
+	VIRTCHNL2_FLOW_RULE_FLOW_TYPE_NOT_SUPPORTED	= 5,
+	VIRTCHNL2_FLOW_RULE_MATCH_KEY_NOT_SUPPORTED	= 6,
+	VIRTCHNL2_FLOW_RULE_ACTION_NOT_SUPPORTED	= 7,
+	VIRTCHNL2_FLOW_RULE_ACTION_COMBINATION_INVALID	= 8,
+	VIRTCHNL2_FLOW_RULE_ACTION_DATA_INVALID		= 9,
+	VIRTCHNL2_FLOW_RULE_NOT_ADDED			= 10,
+};
+
+/**
+ * struct virtchnl2_flow_rule_info: structure representing single flow rule
+ * @rule_id: rule_id associated with the flow_rule.
+ * @rule_cfg: structure representing rule.
+ * @status: status of rule programming. See enum virtchnl2_flow_rule_status.
+ */
+struct virtchnl2_flow_rule_info {
+	__le32 rule_id;
+	struct virtchnl2_flow_rule rule_cfg;
+	__le32 status;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(672, virtchnl2_flow_rule_info);
+
+/**
+ * struct virtchnl2_flow_rule_add_del - add/delete a flow steering rule
+ * @vport_id: vport id for which the rule is to be added or deleted.
+ * @count: Indicates number of rules to be added or deleted.
+ * @rule_info: Array of flow rules to be added or deleted.
+ *
+ * For VIRTCHNL2_OP_FLOW_RULE_ADD, rule_info contains list of rules to be
+ * added. If rule_id is 0xFFFFFFFF, then the rule is programmed and not cached.
+ *
+ * For VIRTCHNL2_OP_FLOW_RULE_DEL, there are two possibilities. The structure
+ * can contain either array of rule_ids or array of match keys to be deleted.
+ * When match keys are used the corresponding rule_ids must be 0xFFFFFFFF.
+ *
+ * status member of each rule indicates the result. Maximum of 6 rules can be
+ * added or deleted using this method. Driver has to retry in case of any
+ * failure of ADD or DEL opcode. CP doesn't retry in case of failure.
+ */
+struct virtchnl2_flow_rule_add_del {
+	__le32 vport_id;
+	__le32 count;
+	struct virtchnl2_flow_rule_info rule_info[] __counted_by_le(count);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_flow_rule_add_del);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
2.47.1


