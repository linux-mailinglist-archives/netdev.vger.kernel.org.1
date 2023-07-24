Return-Path: <netdev+bounces-20494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297D75FBCF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 18:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDA52814AB
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554AE100A7;
	Mon, 24 Jul 2023 16:18:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43847FC1F
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 16:18:54 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52C10CB
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215532; x=1721751532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYK1y7Nnb+LdmiQ/ir2R97vgrsui5+la9TFna0JVdTs=;
  b=WiEezsfA4yOkHyTtc0tVaKnP0YKFcrJkgFjwyMgPyG09GznntE96SHu1
   s6bHLvnw8UNBGiiZ+EZa4ht49cEvB8GPHgjGn8rjHL41N0bJ4u7x2Zvs6
   v66CLiNSVzN4E2eD4zrYrKcbG/iaCyPksjl7VYpeD3v1VdrNGAMkkxpQ0
   fuStfGPCvj2XKPX33ZC2YFyIqFzZArYT7RGBMoq1RuxvhzmM+1Fe0lh/Q
   MFc2t2KCLYXCvPe0RxjvvNwHBthz6a/ChD8dzbvENhaG08AUmUA35ne7d
   /pB2RuZ+AnEn+qabTjkk50eXD3L9d1cly2fCUx9IrJ34Yk4AFsxGF1Z9R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398394153"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398394153"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="899546017"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="899546017"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga005.jf.intel.com with ESMTP; 24 Jul 2023 09:18:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	ivecera@redhat.com,
	simon.horman@corigine.com,
	vladbu@nvidia.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next v2 09/12] ice: Add VLAN FDB support in switchdev mode
Date: Mon, 24 Jul 2023 09:11:49 -0700
Message-Id: <20230724161152.2177196-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Marcin Szycik <marcin.szycik@intel.com>

Add support for matching on VLAN tag in bridge offloads.
Currently only trunk mode is supported.

To enable VLAN filtering (existing FDB entries will be deleted):
ip link set $BR type bridge vlan_filtering 1

To add VLANs to bridge in trunk mode:
bridge vlan add dev $PF1 vid 110-111
bridge vlan add dev $VF1_PR vid 110-111

Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   | 304 +++++++++++++++++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  21 ++
 2 files changed, 317 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 297d0eb45dde..151b40857515 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -70,16 +70,34 @@ ice_eswitch_br_rule_delete(struct ice_hw *hw, struct ice_rule_query_data *rule)
 	return err;
 }
 
+static u16
+ice_eswitch_br_get_lkups_cnt(u16 vid)
+{
+	return ice_eswitch_br_is_vid_valid(vid) ? 2 : 1;
+}
+
+static void
+ice_eswitch_br_add_vlan_lkup(struct ice_adv_lkup_elem *list, u16 vid)
+{
+	if (ice_eswitch_br_is_vid_valid(vid)) {
+		list[1].type = ICE_VLAN_OFOS;
+		list[1].h_u.vlan_hdr.vlan = cpu_to_be16(vid & VLAN_VID_MASK);
+		list[1].m_u.vlan_hdr.vlan = cpu_to_be16(0xFFFF);
+	}
+}
+
 static struct ice_rule_query_data *
 ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
-			       const unsigned char *mac)
+			       const unsigned char *mac, u16 vid)
 {
 	struct ice_adv_rule_info rule_info = { 0 };
 	struct ice_rule_query_data *rule;
 	struct ice_adv_lkup_elem *list;
-	u16 lkups_cnt = 1;
+	u16 lkups_cnt;
 	int err;
 
+	lkups_cnt = ice_eswitch_br_get_lkups_cnt(vid);
+
 	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
 	if (!rule)
 		return ERR_PTR(-ENOMEM);
@@ -107,6 +125,8 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
 	ether_addr_copy(list[0].h_u.eth_hdr.dst_addr, mac);
 	eth_broadcast_addr(list[0].m_u.eth_hdr.dst_addr);
 
+	ice_eswitch_br_add_vlan_lkup(list, vid);
+
 	rule_info.need_pass_l2 = true;
 
 	rule_info.sw_act.fltr_act = ICE_FWD_TO_VSI;
@@ -129,13 +149,15 @@ ice_eswitch_br_fwd_rule_create(struct ice_hw *hw, int vsi_idx, int port_type,
 
 static struct ice_rule_query_data *
 ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
-				 const unsigned char *mac)
+				 const unsigned char *mac, u16 vid)
 {
 	struct ice_adv_rule_info rule_info = { 0 };
 	struct ice_rule_query_data *rule;
 	struct ice_adv_lkup_elem *list;
-	const u16 lkups_cnt = 1;
 	int err = -ENOMEM;
+	u16 lkups_cnt;
+
+	lkups_cnt = ice_eswitch_br_get_lkups_cnt(vid);
 
 	rule = kzalloc(sizeof(*rule), GFP_KERNEL);
 	if (!rule)
@@ -149,6 +171,8 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
 	ether_addr_copy(list[0].h_u.eth_hdr.src_addr, mac);
 	eth_broadcast_addr(list[0].m_u.eth_hdr.src_addr);
 
+	ice_eswitch_br_add_vlan_lkup(list, vid);
+
 	rule_info.allow_pass_l2 = true;
 	rule_info.sw_act.vsi_handle = vsi_idx;
 	rule_info.sw_act.fltr_act = ICE_NOP;
@@ -172,7 +196,7 @@ ice_eswitch_br_guard_rule_create(struct ice_hw *hw, u16 vsi_idx,
 
 static struct ice_esw_br_flow *
 ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
-			   int port_type, const unsigned char *mac)
+			   int port_type, const unsigned char *mac, u16 vid)
 {
 	struct ice_rule_query_data *fwd_rule, *guard_rule;
 	struct ice_esw_br_flow *flow;
@@ -182,7 +206,8 @@ ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
 	if (!flow)
 		return ERR_PTR(-ENOMEM);
 
-	fwd_rule = ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, mac);
+	fwd_rule = ice_eswitch_br_fwd_rule_create(hw, vsi_idx, port_type, mac,
+						  vid);
 	err = PTR_ERR_OR_ZERO(fwd_rule);
 	if (err) {
 		dev_err(dev, "Failed to create eswitch bridge %sgress forward rule, err: %d\n",
@@ -191,7 +216,7 @@ ice_eswitch_br_flow_create(struct device *dev, struct ice_hw *hw, int vsi_idx,
 		goto err_fwd_rule;
 	}
 
-	guard_rule = ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac);
+	guard_rule = ice_eswitch_br_guard_rule_create(hw, vsi_idx, mac, vid);
 	err = PTR_ERR_OR_ZERO(guard_rule);
 	if (err) {
 		dev_err(dev, "Failed to create eswitch bridge %sgress guard rule, err: %d\n",
@@ -245,6 +270,30 @@ ice_eswitch_br_flow_delete(struct ice_pf *pf, struct ice_esw_br_flow *flow)
 	kfree(flow);
 }
 
+static struct ice_esw_br_vlan *
+ice_esw_br_port_vlan_lookup(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid)
+{
+	struct ice_pf *pf = bridge->br_offloads->pf;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_esw_br_port *port;
+	struct ice_esw_br_vlan *vlan;
+
+	port = xa_load(&bridge->ports, vsi_idx);
+	if (!port) {
+		dev_info(dev, "Bridge port lookup failed (vsi=%u)\n", vsi_idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	vlan = xa_load(&port->vlans, vid);
+	if (!vlan) {
+		dev_info(dev, "Bridge port vlan metadata lookup failed (vsi=%u)\n",
+			 vsi_idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return vlan;
+}
+
 static void
 ice_eswitch_br_fdb_entry_delete(struct ice_esw_br *bridge,
 				struct ice_esw_br_fdb_entry *fdb_entry)
@@ -314,10 +363,25 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_esw_br_fdb_entry *fdb_entry;
 	struct ice_esw_br_flow *flow;
+	struct ice_esw_br_vlan *vlan;
 	struct ice_hw *hw = &pf->hw;
 	unsigned long event;
 	int err;
 
+	/* untagged filtering is not yet supported */
+	if (!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING) && vid)
+		return;
+
+	if ((bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING)) {
+		vlan = ice_esw_br_port_vlan_lookup(bridge, br_port->vsi_idx,
+						   vid);
+		if (IS_ERR(vlan)) {
+			dev_err(dev, "Failed to find vlan lookup, err: %ld\n",
+				PTR_ERR(vlan));
+			return;
+		}
+	}
+
 	fdb_entry = ice_eswitch_br_fdb_find(bridge, mac, vid);
 	if (fdb_entry)
 		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, fdb_entry);
@@ -329,7 +393,7 @@ ice_eswitch_br_fdb_entry_create(struct net_device *netdev,
 	}
 
 	flow = ice_eswitch_br_flow_create(dev, hw, br_port->vsi_idx,
-					  br_port->type, mac);
+					  br_port->type, mac, vid);
 	if (IS_ERR(flow)) {
 		err = PTR_ERR(flow);
 		goto err_add_flow;
@@ -484,6 +548,215 @@ ice_eswitch_br_switchdev_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
+{
+	struct ice_esw_br_fdb_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list)
+		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
+}
+
+static void
+ice_eswitch_br_vlan_filtering_set(struct ice_esw_br *bridge, bool enable)
+{
+	if (enable == !!(bridge->flags & ICE_ESWITCH_BR_VLAN_FILTERING))
+		return;
+
+	ice_eswitch_br_fdb_flush(bridge);
+	if (enable)
+		bridge->flags |= ICE_ESWITCH_BR_VLAN_FILTERING;
+	else
+		bridge->flags &= ~ICE_ESWITCH_BR_VLAN_FILTERING;
+}
+
+static void
+ice_eswitch_br_vlan_cleanup(struct ice_esw_br_port *port,
+			    struct ice_esw_br_vlan *vlan)
+{
+	struct ice_esw_br_fdb_entry *fdb_entry, *tmp;
+	struct ice_esw_br *bridge = port->bridge;
+
+	list_for_each_entry_safe(fdb_entry, tmp, &bridge->fdb_list, list) {
+		if (vlan->vid == fdb_entry->data.vid)
+			ice_eswitch_br_fdb_entry_delete(bridge, fdb_entry);
+	}
+
+	xa_erase(&port->vlans, vlan->vid);
+	kfree(vlan);
+}
+
+static void ice_eswitch_br_port_vlans_flush(struct ice_esw_br_port *port)
+{
+	struct ice_esw_br_vlan *vlan;
+	unsigned long index;
+
+	xa_for_each(&port->vlans, index, vlan)
+		ice_eswitch_br_vlan_cleanup(port, vlan);
+}
+
+static struct ice_esw_br_vlan *
+ice_eswitch_br_vlan_create(u16 vid, u16 flags, struct ice_esw_br_port *port)
+{
+	struct ice_esw_br_vlan *vlan;
+	int err;
+
+	vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
+	if (!vlan)
+		return ERR_PTR(-ENOMEM);
+
+	vlan->vid = vid;
+	vlan->flags = flags;
+
+	err = xa_insert(&port->vlans, vlan->vid, vlan, GFP_KERNEL);
+	if (err) {
+		kfree(vlan);
+		return ERR_PTR(err);
+	}
+
+	return vlan;
+}
+
+static int
+ice_eswitch_br_port_vlan_add(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid,
+			     u16 flags, struct netlink_ext_ack *extack)
+{
+	struct ice_esw_br_port *port;
+	struct ice_esw_br_vlan *vlan;
+
+	port = xa_load(&bridge->ports, vsi_idx);
+	if (!port)
+		return -EINVAL;
+
+	vlan = xa_load(&port->vlans, vid);
+	if (vlan) {
+		if (vlan->flags == flags)
+			return 0;
+
+		ice_eswitch_br_vlan_cleanup(port, vlan);
+	}
+
+	vlan = ice_eswitch_br_vlan_create(vid, flags, port);
+	if (IS_ERR(vlan)) {
+		NL_SET_ERR_MSG_FMT_MOD(extack, "Failed to create VLAN entry, vid: %u, vsi: %u",
+				       vid, vsi_idx);
+		return PTR_ERR(vlan);
+	}
+
+	return 0;
+}
+
+static void
+ice_eswitch_br_port_vlan_del(struct ice_esw_br *bridge, u16 vsi_idx, u16 vid)
+{
+	struct ice_esw_br_port *port;
+	struct ice_esw_br_vlan *vlan;
+
+	port = xa_load(&bridge->ports, vsi_idx);
+	if (!port)
+		return;
+
+	vlan = xa_load(&port->vlans, vid);
+	if (!vlan)
+		return;
+
+	ice_eswitch_br_vlan_cleanup(port, vlan);
+}
+
+static int
+ice_eswitch_br_port_obj_add(struct net_device *netdev, const void *ctx,
+			    const struct switchdev_obj *obj,
+			    struct netlink_ext_ack *extack)
+{
+	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
+	struct switchdev_obj_port_vlan *vlan;
+	int err;
+
+	if (!br_port)
+		return -EINVAL;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+		err = ice_eswitch_br_port_vlan_add(br_port->bridge,
+						   br_port->vsi_idx, vlan->vid,
+						   vlan->flags, extack);
+		return err;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ice_eswitch_br_port_obj_del(struct net_device *netdev, const void *ctx,
+			    const struct switchdev_obj *obj)
+{
+	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
+	struct switchdev_obj_port_vlan *vlan;
+
+	if (!br_port)
+		return -EINVAL;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		vlan = SWITCHDEV_OBJ_PORT_VLAN(obj);
+		ice_eswitch_br_port_vlan_del(br_port->bridge, br_port->vsi_idx,
+					     vlan->vid);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ice_eswitch_br_port_obj_attr_set(struct net_device *netdev, const void *ctx,
+				 const struct switchdev_attr *attr,
+				 struct netlink_ext_ack *extack)
+{
+	struct ice_esw_br_port *br_port = ice_eswitch_br_netdev_to_port(netdev);
+
+	if (!br_port)
+		return -EINVAL;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		ice_eswitch_br_vlan_filtering_set(br_port->bridge,
+						  attr->u.vlan_filtering);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int
+ice_eswitch_br_event_blocking(struct notifier_block *nb, unsigned long event,
+			      void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add(dev, ptr,
+						    ice_eswitch_br_is_dev_valid,
+						    ice_eswitch_br_port_obj_add);
+		break;
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del(dev, ptr,
+						    ice_eswitch_br_is_dev_valid,
+						    ice_eswitch_br_port_obj_del);
+		break;
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set(dev, ptr,
+						     ice_eswitch_br_is_dev_valid,
+						     ice_eswitch_br_port_obj_attr_set);
+		break;
+	default:
+		err = 0;
+	}
+
+	return notifier_from_errno(err);
+}
+
 static void
 ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
 			   struct ice_esw_br_port *br_port)
@@ -502,6 +775,7 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
 		vsi->vf->repr->br_port = NULL;
 
 	xa_erase(&bridge->ports, br_port->vsi_idx);
+	ice_eswitch_br_port_vlans_flush(br_port);
 	kfree(br_port);
 }
 
@@ -514,6 +788,8 @@ ice_eswitch_br_port_init(struct ice_esw_br *bridge)
 	if (!br_port)
 		return ERR_PTR(-ENOMEM);
 
+	xa_init(&br_port->vlans);
+
 	br_port->bridge = bridge;
 
 	return br_port;
@@ -813,6 +1089,7 @@ ice_eswitch_br_offloads_deinit(struct ice_pf *pf)
 		return;
 
 	unregister_netdevice_notifier(&br_offloads->netdev_nb);
+	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
 	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
 	destroy_workqueue(br_offloads->wq);
 	/* Although notifier block is unregistered just before,
@@ -856,6 +1133,15 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
 		goto err_reg_switchdev_nb;
 	}
 
+	br_offloads->switchdev_blk.notifier_call =
+		ice_eswitch_br_event_blocking;
+	err = register_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
+	if (err) {
+		dev_err(dev,
+			"Failed to register bridge blocking switchdev notifier\n");
+		goto err_reg_switchdev_blk;
+	}
+
 	br_offloads->netdev_nb.notifier_call = ice_eswitch_br_port_event;
 	err = register_netdevice_notifier(&br_offloads->netdev_nb);
 	if (err) {
@@ -867,6 +1153,8 @@ ice_eswitch_br_offloads_init(struct ice_pf *pf)
 	return 0;
 
 err_reg_netdev_nb:
+	unregister_switchdev_blocking_notifier(&br_offloads->switchdev_blk);
+err_reg_switchdev_blk:
 	unregister_switchdev_notifier(&br_offloads->switchdev_nb);
 err_reg_switchdev_nb:
 	destroy_workqueue(br_offloads->wq);
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index d0dcf66ff08b..fa1f77f76292 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -42,6 +42,11 @@ struct ice_esw_br_port {
 	struct ice_vsi *vsi;
 	enum ice_esw_br_port_type type;
 	u16 vsi_idx;
+	struct xarray vlans;
+};
+
+enum {
+	ICE_ESWITCH_BR_VLAN_FILTERING = BIT(0),
 };
 
 struct ice_esw_br {
@@ -52,12 +57,14 @@ struct ice_esw_br {
 	struct list_head fdb_list;
 
 	int ifindex;
+	u32 flags;
 };
 
 struct ice_esw_br_offloads {
 	struct ice_pf *pf;
 	struct ice_esw_br *bridge;
 	struct notifier_block netdev_nb;
+	struct notifier_block switchdev_blk;
 	struct notifier_block switchdev_nb;
 
 	struct workqueue_struct *wq;
@@ -70,6 +77,11 @@ struct ice_esw_br_fdb_work {
 	unsigned long event;
 };
 
+struct ice_esw_br_vlan {
+	u16 vid;
+	u16 flags;
+};
+
 #define ice_nb_to_br_offloads(nb, nb_name) \
 	container_of(nb, \
 		     struct ice_esw_br_offloads, \
@@ -80,6 +92,15 @@ struct ice_esw_br_fdb_work {
 		     struct ice_esw_br_fdb_work, \
 		     work)
 
+static inline bool ice_eswitch_br_is_vid_valid(u16 vid)
+{
+	/* In trunk VLAN mode, for untagged traffic the bridge sends requests
+	 * to offload VLAN 1 with pvid and untagged flags set. Since these
+	 * flags are not supported, add a MAC filter instead.
+	 */
+	return vid > 1;
+}
+
 void
 ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
 int
-- 
2.38.1


