Return-Path: <netdev+bounces-47793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944237EB63C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16241C20BE8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50052FC49;
	Tue, 14 Nov 2023 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0b/5oAJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9D26AEA
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57113134
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985725; x=1731521725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GSvvu3XsDa5HmsHicJSPjHyA867AbVbAqH5ncJmTg5g=;
  b=e0b/5oAJDMnNKVSEla6ZFf7SapINyqdlZcYLa57uz3RlGXuHZghQTPis
   9Q+NQgIXdUWv9VOREcz3oSi1MMo7fA/7m0u3o9xdTvkQC56QzF9oFhpV5
   qLIeMgPkSrC8eqh2oVf9tA2UKK+LfWA7xNuSBIDRCavibYqDAi60/ZPK+
   xSzkSJFiyKwciMQhrrKko4D8u2h84luemvDL3iQG7HvLnIX032pV3TsZT
   Is4Qq/z4fXv700fFplx4Ajp226haYp5Y4iuRs04s/xK4xAJSMnC6obmmf
   TJBTKRJAMcTA1U4BhmI78UHcqssuopEzZhV8XTOCcn/7uX3ZHfZ1snM2U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514520"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514520"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160961"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160961"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 11/15] ice: set Tx topology every time new repr is added
Date: Tue, 14 Nov 2023 10:14:31 -0800
Message-ID: <20231114181449.1290117-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

It is needed to track correct Tx topology. Update it every time new
representor is created or remove node in case of removing corresponding
representor.

Still clear all node when removing switchdev mode as part of Tx topology
isn't related only to representors. Also clear ::rate_note value to
prevent skipping this node next time Tx topology is created.

Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 29 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_devlink.h |  1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c |  9 ++++++
 drivers/net/ethernet/intel/ice/ice_repr.c    | 27 +++++++++++++-----
 4 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..f4e24d11ebd0 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -810,6 +810,10 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 	struct ice_vf *vf;
 	int i;
 
+	if (node->rate_node)
+		/* already added, skip to the next */
+		goto traverse_children;
+
 	if (node->parent == tc_node) {
 		/* create root node */
 		rate_node = devl_rate_node_create(devlink, node, node->name, NULL);
@@ -831,6 +835,7 @@ static void ice_traverse_tx_tree(struct devlink *devlink, struct ice_sched_node
 	if (rate_node && !IS_ERR(rate_node))
 		node->rate_node = rate_node;
 
+traverse_children:
 	for (i = 0; i < node->num_children; i++)
 		ice_traverse_tx_tree(devlink, node->children[i], tc_node, pf);
 }
@@ -861,6 +866,30 @@ int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *v
 	return 0;
 }
 
+static void ice_clear_rate_nodes(struct ice_sched_node *node)
+{
+	node->rate_node = NULL;
+
+	for (int i = 0; i < node->num_children; i++)
+		ice_clear_rate_nodes(node->children[i]);
+}
+
+/**
+ * ice_devlink_rate_clear_tx_topology - clear node->rate_node
+ * @vsi: main vsi struct
+ *
+ * Clear rate_node to cleanup creation of Tx topology.
+ *
+ */
+void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi)
+{
+	struct ice_port_info *pi = vsi->port_info;
+
+	mutex_lock(&pi->sched_lock);
+	ice_clear_rate_nodes(pi->root->children[0]);
+	mutex_unlock(&pi->sched_lock);
+}
+
 /**
  * ice_set_object_tx_share - sets node scheduling parameter
  * @pi: devlink struct instance
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/ice_devlink.h
index 6ec96779f52e..d291c0e2e17b 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.h
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.h
@@ -20,5 +20,6 @@ void ice_devlink_destroy_regions(struct ice_pf *pf);
 
 int ice_devlink_rate_init_tx_topology(struct devlink *devlink, struct ice_vsi *vsi);
 void ice_tear_down_devlink_rate_tree(struct ice_pf *pf);
+void ice_devlink_rate_clear_tx_topology(struct ice_vsi *vsi);
 
 #endif /* _ICE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 67231e43ffa6..db70a62429e3 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -519,6 +519,7 @@ static int ice_eswitch_enable_switchdev(struct ice_pf *pf)
 static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 {
 	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
+	struct devlink *devlink = priv_to_devlink(pf);
 
 	ice_eswitch_napi_disable(&pf->eswitch.reprs);
 	ice_eswitch_br_offloads_deinit(pf);
@@ -526,6 +527,14 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_eswitch_release_reprs(pf);
 	ice_vsi_release(ctrl_vsi);
 	ice_repr_rem_from_all_vfs(pf);
+
+	/* since all port representors are destroyed, there is
+	 * no point in keeping the nodes
+	 */
+	ice_devlink_rate_clear_tx_topology(ice_get_main_vsi(pf));
+	devl_lock(devlink);
+	devl_rate_nodes_destroy(devlink);
+	devl_unlock(devlink);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index b29a3d010780..fa36cc932c5f 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -278,6 +278,13 @@ ice_repr_reg_netdev(struct net_device *netdev)
 	return register_netdev(netdev);
 }
 
+static void ice_repr_remove_node(struct devlink_port *devlink_port)
+{
+	devl_lock(devlink_port->devlink);
+	devl_rate_leaf_destroy(devlink_port);
+	devl_unlock(devlink_port->devlink);
+}
+
 /**
  * ice_repr_rem - remove representor from VF
  * @reprs: xarray storing representors
@@ -298,6 +305,7 @@ static void ice_repr_rem_vf(struct ice_vf *vf)
 	if (!repr)
 		return;
 
+	ice_repr_remove_node(&repr->vf->devlink_port);
 	unregister_netdev(repr->netdev);
 	ice_repr_rem(&vf->pf->eswitch.reprs, repr);
 	ice_devlink_destroy_vf_port(vf);
@@ -310,7 +318,6 @@ static void ice_repr_rem_vf(struct ice_vf *vf)
  */
 void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
 {
-	struct devlink *devlink;
 	struct ice_vf *vf;
 	unsigned int bkt;
 
@@ -318,14 +325,19 @@ void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
 
 	ice_for_each_vf(pf, bkt, vf)
 		ice_repr_rem_vf(vf);
+}
+
+static void ice_repr_set_tx_topology(struct ice_pf *pf)
+{
+	struct devlink *devlink;
+
+	/* only export if ADQ and DCB disabled and eswitch enabled*/
+	if (ice_is_adq_active(pf) || ice_is_dcb_active(pf) ||
+	    !ice_is_switchdev_running(pf))
+		return;
 
-	/* since all port representors are destroyed, there is
-	 * no point in keeping the nodes
-	 */
 	devlink = priv_to_devlink(pf);
-	devl_lock(devlink);
-	devl_rate_nodes_destroy(devlink);
-	devl_unlock(devlink);
+	ice_devlink_rate_init_tx_topology(devlink, ice_get_main_vsi(pf));
 }
 
 /**
@@ -415,6 +427,7 @@ static struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 		goto err_netdev;
 
 	ice_virtchnl_set_repr_ops(vf);
+	ice_repr_set_tx_topology(vf->pf);
 
 	return repr;
 
-- 
2.41.0


