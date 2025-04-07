Return-Path: <netdev+bounces-179888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B958A7ED2A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CCDA17C464
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923A255E37;
	Mon,  7 Apr 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeBJaNnF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591B1B042E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744053062; cv=none; b=httT37CQ4S7VSN1s13ohXoyVQstnN89cuFyL/jgKHnQTzjO1iGRZhQPGOpfLvMbtbLgZbovHLXA4Wy7qt+WFetRzMtZjQKuRFZKokF1H7Pis4GLFHZyIJZLkDokBx1YjBbEXH6F7rMZFmGUw/c63oNoFks6OmUTVDuYBain/aDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744053062; c=relaxed/simple;
	bh=SJT0HqZPWzqcOdXbSjcNCOxOpj+6RNi6sTSv3lIdUPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeXfCJNJrXWaHrP0seY+7hwG6A4K1zMYE8kgY7aJGgigBeoeCG5AMvom1cMwBugmvn7rvFCr55c/E/IO8Hz6SgnGSMmdWcfUgGvuKBJ3D8/UFdjb6z7LgHGm60HfeJEbmoVqj8GqYB+ezVwMn41PymycSSxtaezFrZ6QV5pPKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NeBJaNnF; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744053061; x=1775589061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJT0HqZPWzqcOdXbSjcNCOxOpj+6RNi6sTSv3lIdUPg=;
  b=NeBJaNnFKJtc/YtPNCyKv/q3I3z+oFGVteZOGTsJ2ZYahrREQX1TX33o
   1NE2gZg3YSAWmC4ex2aLpvE0XiSoxIxMWQddQNy90eIgUy741TMNFewZQ
   42y4T76mDzpfrDTQ6tYIh1xuPu+CtXOR/vyAwWX21tDgOeq9QjhEzumqU
   SD8D+DXue1NO9+7XZTxBZbOUQUkSCIRQQPB1E6w0Pv2HRAgcVKWgIozi7
   V8eX5R13/QJoHXMyf8+ep80evtOXF8IKMGQHmZrPXbkbiP+IQf2KLrAmf
   vbXXYkbS4Clb12OkDmAEggvWShIGiWZmFBd3aT7whBCp6z6CjRiGENh49
   Q==;
X-CSE-ConnectionGUID: TlBNRa/tQI6VPXEcT3nUUw==
X-CSE-MsgGUID: zZ+XlhAjSjqmkVMUZTNUuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45550407"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="45550407"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:49 -0700
X-CSE-ConnectionGUID: r55iKjkMS9+Ra1x025ov6Q==
X-CSE-MsgGUID: AZh/kdcQSWaqtAjR6ZiXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="132177648"
Received: from puneetse-mobl.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.111.57])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:10:41 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	ahmed.zaki@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	almasrymina@google.com,
	willemb@google.com
Subject: [PATCH iwl-next v2 2/3] virtchnl2: add flow steering support
Date: Mon,  7 Apr 2025 13:10:16 -0600
Message-ID: <20250407191017.944214-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407191017.944214-1-ahmed.zaki@intel.com>
References: <20250407191017.944214-1-ahmed.zaki@intel.com>
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
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 215 +++++++++++++++++++-
 1 file changed, 209 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 2e692fff0e3a..1499713c7a45 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -68,6 +68,10 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_ADD_MAC_ADDR		= 535,
 	VIRTCHNL2_OP_DEL_MAC_ADDR		= 536,
 	VIRTCHNL2_OP_CONFIG_PROMISCUOUS_MODE	= 537,
+	/* Opcodes 538 - 550 are reserved */
+	VIRTCHNL2_OP_ADD_FLOW_RULE		= 551,
+	VIRTCHNL2_OP_GET_FLOW_RULE		= 552,
+	VIRTCHNL2_OP_DEL_FLOW_RULE		= 553,
 };
 
 /**
@@ -182,8 +186,9 @@ enum virtchnl2_cap_other {
 	VIRTCHNL2_CAP_RDMA			= BIT_ULL(0),
 	VIRTCHNL2_CAP_SRIOV			= BIT_ULL(1),
 	VIRTCHNL2_CAP_MACFILTER			= BIT_ULL(2),
-	VIRTCHNL2_CAP_FLOW_DIRECTOR		= BIT_ULL(3),
-	/* Queue based scheduling using split queue model */
+	/* BIT 3 is free and can be used for future caps.
+	 * Queue based scheduling using split queue model
+	 */
 	VIRTCHNL2_CAP_SPLITQ_QSCHED		= BIT_ULL(4),
 	VIRTCHNL2_CAP_CRC			= BIT_ULL(5),
 	VIRTCHNL2_CAP_ADQ			= BIT_ULL(6),
@@ -197,16 +202,36 @@ enum virtchnl2_cap_other {
 	/* EDT: Earliest Departure Time capability used for Timing Wheel */
 	VIRTCHNL2_CAP_EDT			= BIT_ULL(14),
 	VIRTCHNL2_CAP_ADV_RSS			= BIT_ULL(15),
-	VIRTCHNL2_CAP_FDIR			= BIT_ULL(16),
+	/* BIT 16 is free and can be used for future caps */
 	VIRTCHNL2_CAP_RX_FLEX_DESC		= BIT_ULL(17),
 	VIRTCHNL2_CAP_PTYPE			= BIT_ULL(18),
 	VIRTCHNL2_CAP_LOOPBACK			= BIT_ULL(19),
 	/* Other capability 20 is reserved */
+	VIRTCHNL2_CAP_FLOW_STEER		= BIT_ULL(21),
 
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
@@ -559,6 +584,20 @@ struct virtchnl2_queue_reg_chunks {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
 
+/**
+ * enum virtchnl2_vport_flags - Vport flags that indicate vport capabilities.
+ * @VIRTCHNL2_VPORT_INLINE_FLOW_STEER: Inline flow steering enabled
+ * @VIRTCHNL2_VPORT_INLINE_FLOW_STEER_RXQ: Inline flow steering enabled
+ * with explicit Rx queue action
+ * @VIRTCHNL2_VPORT_SIDEBAND_FLOW_STEER: Sideband flow steering enabled
+ */
+enum virtchnl2_vport_flags {
+	/* BIT(0) reserved */
+	VIRTCHNL2_VPORT_INLINE_FLOW_STEER	= BIT(1),
+	VIRTCHNL2_VPORT_INLINE_FLOW_STEER_RXQ	= BIT(2),
+	VIRTCHNL2_VPORT_SIDEBAND_FLOW_STEER	= BIT(3),
+};
+
 /**
  * struct virtchnl2_create_vport - Create vport config info.
  * @vport_type: See enum virtchnl2_vport_type.
@@ -577,10 +616,18 @@ VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_queue_reg_chunks);
  * @max_mtu: Max MTU. CP populates this field on response.
  * @vport_id: Vport id. CP populates this field on response.
  * @default_mac_addr: Default MAC address.
- * @pad: Padding.
+ * @vport_flags: See enum virtchnl2_vport_flags.
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
@@ -610,10 +657,14 @@ struct virtchnl2_create_vport {
 	__le16 max_mtu;
 	__le32 vport_id;
 	u8 default_mac_addr[ETH_ALEN];
-	__le16 pad;
+	__le16 vport_flags;
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
@@ -1270,4 +1321,156 @@ struct virtchnl2_promisc_info {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_promisc_info);
 
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
2.43.0


