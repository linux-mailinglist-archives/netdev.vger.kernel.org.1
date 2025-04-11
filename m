Return-Path: <netdev+bounces-181778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A341A86781
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D5D7B251A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A535298CCC;
	Fri, 11 Apr 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KocHXqqI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B928F93B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404254; cv=none; b=n/EwANnsPlsOhEzOvmAE2wj2AAA1aRscXW9HTywjzvmsVBC89fNygpGEzgyHUDA1Z2i3E7b9spZU3jgCGuzBqJHRFnA92jHITDkDVjl1F2mrLphcyPQ9MKjJ0Y2oVeSUETpdJy+KxQIztU2Vzd+S8p9G+RSPMB64N8e2Sd/2XI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404254; c=relaxed/simple;
	bh=cKk3PR/jIpoBksiYzheRtkVCobZJcAwv6AW6YQKXf1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCdD8+sC4UVb1/TvMtd3hQ12PoabnqagKcAYmkZNiSo3vo6yfquS1D9DwHi8WhxDfPEdySEHPds82+csBTgWVU4jNOmMt6h61b2jB8qEZjpIyApPN/tYQ4TwBfhA1JFTyjDKhhxfyJdPwK8PWx4FdBr2XAjz3KGOSij74RsXnGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KocHXqqI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404250; x=1775940250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cKk3PR/jIpoBksiYzheRtkVCobZJcAwv6AW6YQKXf1k=;
  b=KocHXqqIqONz9m0QVhBkN/YDCJLBSN4w+WZcgDA2v7GHWKebjfHMCXF9
   Ce8U1vMtJcTREvND7ikypy1nS76ae9sOAfTuZmlgArIa1X1A+b7ba5NcX
   rdGKTQMLN9U2bsgVEgvy5oq1C4seOS8fhhjo0cao4biZwdEWygv8f384X
   tXbIdBmc61ez86K19gdmZZ7QEgvUFHQxAFTIpOyw3Pt7nE+86/EW6Q1qV
   wXEuKvn0GAF+vl4f4nYWl0cqm69lGjUtMnbz3a9M8TNXQNf6OF6p3PdO6
   zlPsgRDBb+0A47V02Mv2cqujJOqqujckIBgZ/tB+Zw0GXA0twAgNEaCa9
   A==;
X-CSE-ConnectionGUID: xcXoVJvJQPipDrz1JNlisQ==
X-CSE-MsgGUID: Fo2w5OOyTHKY7FB/0IJLZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103869"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:06 -0700
X-CSE-ConnectionGUID: 8Xs9v8aYSNG0HUpC8s29Fw==
X-CSE-MsgGUID: /1Yd03+iQHmbPTyU5PKtaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241808"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 05/15] ice: support egress drop rules on PF
Date: Fri, 11 Apr 2025 13:43:46 -0700
Message-ID: <20250411204401.3271306-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Larysa Zaremba <larysa.zaremba@intel.com>

tc clsact qdisc allows us to add offloaded egress rules with commands such
as the following one:

tc filter add dev <ifname> egress protocol lldp flower skip_sw action drop

Support the egress rule drop action when added to PF, with a few caveats:
* in switchdev mode, all PF traffic has to go uplink with an exception for
  LLDP that can be delegated to a single VSI at a time
* in legacy mode, we cannot delegate LLDP functionality to another VSI, so
  such packets from PF should not be blocked.

Also, simplify the rule direction logic, it was previously derived from
actions, but actually can be inherited from the tc block (and flipped in
case of port representors).

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  4 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 63 ++++++++++++--
 drivers/net/ethernet/intel/ice/ice_repr.c    |  3 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c  | 86 +++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_tc_lib.h  |  9 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c    | 17 ++--
 6 files changed, 138 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index ed21d7f55ac1..206a7d839aef 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -245,6 +245,10 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 	u64 cd_cmd, dst_vsi;
 
 	if (!dst) {
+		struct ethhdr *eth = (struct ethhdr *)skb_mac_header(skb);
+
+		if (unlikely(eth->h_proto == htons(ETH_P_LLDP)))
+			return;
 		cd_cmd = ICE_TX_CTX_DESC_SWTCH_UPLINK << ICE_TXD_CTX_QW1_CMD_S;
 		off->cd_qw1 |= (cd_cmd | ICE_TX_DESC_DTYPE_CTX);
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d390157b59fe..1fbe13ee93a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8330,11 +8330,16 @@ void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
  * @np: net device to configure
  * @filter_dev: device on which filter is added
  * @cls_flower: offload data
+ * @ingress: if the rule is added to an ingress block
+ *
+ * Return: 0 if the flower was successfully added or deleted,
+ *	   negative error code otherwise.
  */
 static int
 ice_setup_tc_cls_flower(struct ice_netdev_priv *np,
 			struct net_device *filter_dev,
-			struct flow_cls_offload *cls_flower)
+			struct flow_cls_offload *cls_flower,
+			bool ingress)
 {
 	struct ice_vsi *vsi = np->vsi;
 
@@ -8343,7 +8348,7 @@ ice_setup_tc_cls_flower(struct ice_netdev_priv *np,
 
 	switch (cls_flower->command) {
 	case FLOW_CLS_REPLACE:
-		return ice_add_cls_flower(filter_dev, vsi, cls_flower);
+		return ice_add_cls_flower(filter_dev, vsi, cls_flower, ingress);
 	case FLOW_CLS_DESTROY:
 		return ice_del_cls_flower(vsi, cls_flower);
 	default:
@@ -8352,20 +8357,46 @@ ice_setup_tc_cls_flower(struct ice_netdev_priv *np,
 }
 
 /**
- * ice_setup_tc_block_cb - callback handler registered for TC block
+ * ice_setup_tc_block_cb_ingress - callback handler for ingress TC block
  * @type: TC SETUP type
  * @type_data: TC flower offload data that contains user input
  * @cb_priv: netdev private data
+ *
+ * Return: 0 if the setup was successful, negative error code otherwise.
  */
 static int
-ice_setup_tc_block_cb(enum tc_setup_type type, void *type_data, void *cb_priv)
+ice_setup_tc_block_cb_ingress(enum tc_setup_type type, void *type_data,
+			      void *cb_priv)
 {
 	struct ice_netdev_priv *np = cb_priv;
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
 		return ice_setup_tc_cls_flower(np, np->vsi->netdev,
-					       type_data);
+					       type_data, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * ice_setup_tc_block_cb_egress - callback handler for egress TC block
+ * @type: TC SETUP type
+ * @type_data: TC flower offload data that contains user input
+ * @cb_priv: netdev private data
+ *
+ * Return: 0 if the setup was successful, negative error code otherwise.
+ */
+static int
+ice_setup_tc_block_cb_egress(enum tc_setup_type type, void *type_data,
+			     void *cb_priv)
+{
+	struct ice_netdev_priv *np = cb_priv;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return ice_setup_tc_cls_flower(np, np->vsi->netdev,
+					       type_data, false);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -9310,16 +9341,32 @@ ice_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 	     void *type_data)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
+	enum flow_block_binder_type binder_type;
 	struct ice_pf *pf = np->vsi->back;
+	flow_setup_cb_t *flower_handler;
 	bool locked = false;
 	int err;
 
 	switch (type) {
 	case TC_SETUP_BLOCK:
+		binder_type =
+			((struct flow_block_offload *)type_data)->binder_type;
+
+		switch (binder_type) {
+		case FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS:
+			flower_handler = ice_setup_tc_block_cb_ingress;
+			break;
+		case FLOW_BLOCK_BINDER_TYPE_CLSACT_EGRESS:
+			flower_handler = ice_setup_tc_block_cb_egress;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
 		return flow_block_cb_setup_simple(type_data,
 						  &ice_block_cb_list,
-						  ice_setup_tc_block_cb,
-						  np, np, true);
+						  flower_handler,
+						  np, np, false);
 	case TC_SETUP_QDISC_MQPRIO:
 		if (ice_is_eswitch_mode_switchdev(pf)) {
 			netdev_err(netdev, "TC MQPRIO offload not supported, switchdev is enabled\n");
@@ -9380,7 +9427,7 @@ ice_indr_setup_block_cb(enum tc_setup_type type, void *type_data,
 	case TC_SETUP_CLSFLOWER:
 		return ice_setup_tc_cls_flower(np, priv->netdev,
 					       (struct flow_cls_offload *)
-					       type_data);
+					       type_data, false);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index fb7a1b9a4313..f81bf60f8365 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -219,7 +219,8 @@ ice_repr_setup_tc_cls_flower(struct ice_repr *repr,
 {
 	switch (flower->command) {
 	case FLOW_CLS_REPLACE:
-		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower);
+		return ice_add_cls_flower(repr->netdev, repr->src_vsi, flower,
+					  true);
 	case FLOW_CLS_DESTROY:
 		return ice_del_cls_flower(repr->src_vsi, flower);
 	default:
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index d8d28d74222a..229cd29ff92a 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -681,26 +681,26 @@ static int ice_tc_setup_action(struct net_device *filter_dev,
 	fltr->action.fltr_act = action;
 
 	if (ice_is_port_repr_netdev(filter_dev) &&
-	    ice_is_port_repr_netdev(target_dev)) {
+	    ice_is_port_repr_netdev(target_dev) &&
+	    fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
 		repr = ice_netdev_to_repr(target_dev);
 
 		fltr->dest_vsi = repr->src_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
 	} else if (ice_is_port_repr_netdev(filter_dev) &&
-		   ice_tc_is_dev_uplink(target_dev)) {
+		   ice_tc_is_dev_uplink(target_dev) &&
+		   fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
 		repr = ice_netdev_to_repr(filter_dev);
 
 		fltr->dest_vsi = repr->src_vsi->back->eswitch.uplink_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
 	} else if (ice_tc_is_dev_uplink(filter_dev) &&
-		   ice_is_port_repr_netdev(target_dev)) {
+		   ice_is_port_repr_netdev(target_dev) &&
+		   fltr->direction == ICE_ESWITCH_FLTR_INGRESS) {
 		repr = ice_netdev_to_repr(target_dev);
 
 		fltr->dest_vsi = repr->src_vsi;
-		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
 	} else {
 		NL_SET_ERR_MSG_MOD(fltr->extack,
-				   "Unsupported netdevice in switchdev mode");
+				   "The action is not supported for this netdevice");
 		return -EINVAL;
 	}
 
@@ -713,13 +713,11 @@ ice_tc_setup_drop_action(struct net_device *filter_dev,
 {
 	fltr->action.fltr_act = ICE_DROP_PACKET;
 
-	if (ice_is_port_repr_netdev(filter_dev)) {
-		fltr->direction = ICE_ESWITCH_FLTR_EGRESS;
-	} else if (ice_tc_is_dev_uplink(filter_dev)) {
-		fltr->direction = ICE_ESWITCH_FLTR_INGRESS;
-	} else {
+	if (!ice_tc_is_dev_uplink(filter_dev) &&
+	    !(ice_is_port_repr_netdev(filter_dev) &&
+	      fltr->direction == ICE_ESWITCH_FLTR_INGRESS)) {
 		NL_SET_ERR_MSG_MOD(fltr->extack,
-				   "Unsupported netdevice in switchdev mode");
+				   "The action is not supported for this netdevice");
 		return -EINVAL;
 	}
 
@@ -809,6 +807,11 @@ ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
 		rule_info.sw_act.flag |= ICE_FLTR_RX;
 		rule_info.sw_act.src = hw->pf_id;
 		rule_info.flags_info.act = ICE_SINGLE_ACT_LB_ENABLE;
+	} else if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
+		   !fltr->dest_vsi && vsi == vsi->back->eswitch.uplink_vsi) {
+		/* PF to Uplink */
+		rule_info.sw_act.flag |= ICE_FLTR_TX;
+		rule_info.sw_act.src = vsi->idx;
 	} else if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS &&
 		   fltr->dest_vsi == vsi->back->eswitch.uplink_vsi) {
 		/* VF to Uplink */
@@ -1051,8 +1054,13 @@ ice_add_tc_flower_adv_fltr(struct ice_vsi *vsi,
 			tc_fltr->action.fwd.q.hw_queue, lkups_cnt);
 		break;
 	case ICE_DROP_PACKET:
-		rule_info.sw_act.flag |= ICE_FLTR_RX;
-		rule_info.sw_act.src = hw->pf_id;
+		if (tc_fltr->direction == ICE_ESWITCH_FLTR_EGRESS) {
+			rule_info.sw_act.flag |= ICE_FLTR_TX;
+			rule_info.sw_act.src = vsi->idx;
+		} else {
+			rule_info.sw_act.flag |= ICE_FLTR_RX;
+			rule_info.sw_act.src = hw->pf_id;
+		}
 		rule_info.priority = ICE_SWITCH_FLTR_PRIO_VSI;
 		break;
 	default:
@@ -1458,11 +1466,16 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
  * @filter_dev: Pointer to device on which filter is being added
  * @f: Pointer to struct flow_cls_offload
  * @fltr: Pointer to filter structure
+ * @ingress: if the rule is added to an ingress block
+ *
+ * Return: 0 if the flower was parsed successfully, -EINVAL if the flower
+ *	   cannot be parsed, -EOPNOTSUPP if such filter cannot be configured
+ *	   for the given VSI.
  */
 static int
 ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		     struct flow_cls_offload *f,
-		     struct ice_tc_flower_fltr *fltr)
+		     struct ice_tc_flower_fltr *fltr, bool ingress)
 {
 	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
 	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
@@ -1546,6 +1559,20 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 			fltr->flags |= ICE_TC_FLWR_FIELD_ETH_TYPE_ID;
 		}
 
+		if (!ingress) {
+			bool switchdev =
+				ice_is_eswitch_mode_switchdev(vsi->back);
+
+			if (switchdev != (n_proto_key == ETH_P_LLDP)) {
+				NL_SET_ERR_MSG_FMT_MOD(fltr->extack,
+						       "%sLLDP filtering is not supported on egress in %s mode",
+						       switchdev ? "Non-" : "",
+						       switchdev ? "switchdev" :
+								   "legacy");
+				return -EOPNOTSUPP;
+			}
+		}
+
 		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
 		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
 		headers->l3_key.ip_proto = match.key->ip_proto;
@@ -1721,6 +1748,14 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 			return -EINVAL;
 		}
 	}
+
+	/* Ingress filter on representor results in an egress filter in HW
+	 * and vice versa
+	 */
+	ingress = ice_is_port_repr_netdev(filter_dev) ? !ingress : ingress;
+	fltr->direction = ingress ? ICE_ESWITCH_FLTR_INGRESS :
+				    ICE_ESWITCH_FLTR_EGRESS;
+
 	return 0;
 }
 
@@ -1970,14 +2005,18 @@ static int ice_del_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
  * @vsi: Pointer to VSI
  * @f: Pointer to flower offload structure
  * @__fltr: Pointer to struct ice_tc_flower_fltr
+ * @ingress: if the rule is added to an ingress block
  *
  * This function parses TC-flower input fields, parses action,
  * and adds a filter.
+ *
+ * Return: 0 if the filter was successfully added,
+ *	   negative error code otherwise.
  */
 static int
 ice_add_tc_fltr(struct net_device *netdev, struct ice_vsi *vsi,
 		struct flow_cls_offload *f,
-		struct ice_tc_flower_fltr **__fltr)
+		struct ice_tc_flower_fltr **__fltr, bool ingress)
 {
 	struct ice_tc_flower_fltr *fltr;
 	int err;
@@ -1994,7 +2033,7 @@ ice_add_tc_fltr(struct net_device *netdev, struct ice_vsi *vsi,
 	fltr->src_vsi = vsi;
 	INIT_HLIST_NODE(&fltr->tc_flower_node);
 
-	err = ice_parse_cls_flower(netdev, vsi, f, fltr);
+	err = ice_parse_cls_flower(netdev, vsi, f, fltr, ingress);
 	if (err < 0)
 		goto err;
 
@@ -2037,10 +2076,13 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
  * @netdev: Pointer to filter device
  * @vsi: Pointer to VSI
  * @cls_flower: Pointer to flower offload structure
+ * @ingress: if the rule is added to an ingress block
+ *
+ * Return: 0 if the flower was successfully added,
+ *	   negative error code otherwise.
  */
-int
-ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
-		   struct flow_cls_offload *cls_flower)
+int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
+		       struct flow_cls_offload *cls_flower, bool ingress)
 {
 	struct netlink_ext_ack *extack = cls_flower->common.extack;
 	struct net_device *vsi_netdev = vsi->netdev;
@@ -2075,7 +2117,7 @@ ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
 	}
 
 	/* prep and add TC-flower filter in HW */
-	err = ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr);
+	err = ice_add_tc_fltr(netdev, vsi, cls_flower, &fltr, ingress);
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
index d84f153517ec..df9f90f793b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
@@ -211,11 +211,10 @@ static inline int ice_chnl_dmac_fltr_cnt(struct ice_pf *pf)
 }
 
 struct ice_vsi *ice_locate_vsi_using_queue(struct ice_vsi *vsi, int queue);
-int
-ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
-		   struct flow_cls_offload *cls_flower);
-int
-ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower);
+int ice_add_cls_flower(struct net_device *netdev, struct ice_vsi *vsi,
+		       struct flow_cls_offload *cls_flower, bool ingress);
+int ice_del_cls_flower(struct ice_vsi *vsi,
+		       struct flow_cls_offload *cls_flower);
 void ice_replay_tc_fltrs(struct ice_pf *pf);
 bool ice_is_tunnel_supported(struct net_device *dev);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 1e4f6f6ee449..0e5107fe62ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2440,19 +2440,20 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 
 	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
 	eth = (struct ethhdr *)skb_mac_header(skb);
-	if (unlikely((skb->priority == TC_PRIO_CONTROL ||
-		      eth->h_proto == htons(ETH_P_LLDP)) &&
-		     vsi->type == ICE_VSI_PF &&
-		     vsi->port_info->qos_cfg.is_sw_lldp))
-		offload.cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
-					ICE_TX_CTX_DESC_SWTCH_UPLINK <<
-					ICE_TXD_CTX_QW1_CMD_S);
 
-	ice_tstamp(tx_ring, skb, first, &offload);
 	if ((ice_is_switchdev_running(vsi->back) ||
 	     ice_lag_is_switchdev_running(vsi->back)) &&
 	    vsi->type != ICE_VSI_SF)
 		ice_eswitch_set_target_vsi(skb, &offload);
+	else if (unlikely((skb->priority == TC_PRIO_CONTROL ||
+			   eth->h_proto == htons(ETH_P_LLDP)) &&
+			   vsi->type == ICE_VSI_PF &&
+			   vsi->port_info->qos_cfg.is_sw_lldp))
+		offload.cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
+					ICE_TX_CTX_DESC_SWTCH_UPLINK <<
+					ICE_TXD_CTX_QW1_CMD_S);
+
+	ice_tstamp(tx_ring, skb, first, &offload);
 
 	if (offload.cd_qw1 & ICE_TX_DESC_DTYPE_CTX) {
 		struct ice_tx_ctx_desc *cdesc;
-- 
2.47.1


