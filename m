Return-Path: <netdev+bounces-21565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC752763E8A
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 20:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A5A51C21322
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 18:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474F13D3B9;
	Wed, 26 Jul 2023 18:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960A3D3A2
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 18:28:03 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897571FC2
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690396081; x=1721932081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=twenDNZ7geqqIauNAdmWZQPh8IYlnbTnON4s5r82C8o=;
  b=kSdPG7e60cMUDFFYPdAZcYlSqrbXBiSj4QFNJvVC4g06L4l2SbeO0lVh
   6ClPkQg+x46ZsvUQhMZZQ6tIP7Cq040JHV8WMILxlkwxSYFi2xFgBSxpz
   2aE/DZj5cFxQBUevzuzhPxpsKbM7UL6lfcMTrkW/RyqNu/jTke1d8YvjQ
   BHqlv3Z55ojtXo50V37szGRM9RP6Mo65r+mjiCd97TzdeErNAorHiu6N8
   vaDb0rFNHwXcaW4CE5D/VDXL65ZX5I6qNrAegwxwWq2TpM952EKxrA2Yc
   7X4CRHmGRKNHwwfNyJoMVADni6kVXPQYb3Znn16H3C4Sx9bUp1zsgVLFB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="368119110"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="368119110"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 11:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756340059"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="756340059"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2023 11:27:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	daniel.machon@microchip.com,
	simon.horman@corigine.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 10/10] ice: update reset path for SRIOV LAG support
Date: Wed, 26 Jul 2023 11:21:41 -0700
Message-Id: <20230726182141.3797928-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
References: <20230726182141.3797928-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Dave Ertman <david.m.ertman@intel.com>

Add code to rebuild the LAG resources when rebuilding the state of the
interface after a reset.

Also added in a function for building per-queue information into the buffer
used to configure VF queues for LAG fail-over.  This improves code reuse.

Due to differences in timing per interface for recovering from a reset, add
in the ability to retry on non-local dependencies where needed.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c  | 231 +++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_lag.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c |  14 +-
 3 files changed, 244 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 44dae075aeb8..cf8435ab601a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -957,6 +957,7 @@ static void ice_lag_link_unlink(struct ice_lag *lag, void *ptr)
  * @link: Is this a linking activity
  *
  * If link is false, then primary_swid should be expected to not be valid
+ * This function should never be called in interrupt context.
  */
 static void
 ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
@@ -966,7 +967,7 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
 	struct ice_aqc_set_port_params *cmd;
 	struct ice_aq_desc desc;
 	u16 buf_len, swid;
-	int status;
+	int status, i;
 
 	buf_len = struct_size(buf, elem, 1);
 	buf = kzalloc(buf_len, GFP_KERNEL);
@@ -1017,7 +1018,20 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_set_port_params);
 
 	cmd->swid = cpu_to_le16(ICE_AQC_PORT_SWID_VALID | swid);
-	status = ice_aq_send_cmd(&local_lag->pf->hw, &desc, NULL, 0, NULL);
+	/* If this is happening in reset context, it is possible that the
+	 * primary interface has not finished setting its SWID to SHARED
+	 * yet.  Allow retries to account for this timing issue between
+	 * interfaces.
+	 */
+	for (i = 0; i < ICE_LAG_RESET_RETRIES; i++) {
+		status = ice_aq_send_cmd(&local_lag->pf->hw, &desc, NULL, 0,
+					 NULL);
+		if (!status)
+			break;
+
+		usleep_range(1000, 2000);
+	}
+
 	if (status)
 		dev_err(ice_pf_to_dev(local_lag->pf), "Error setting SWID in port params %d\n",
 			status);
@@ -1025,7 +1039,7 @@ ice_lag_set_swid(u16 primary_swid, struct ice_lag *local_lag,
 
 /**
  * ice_lag_primary_swid - set/clear the SHARED attrib of primary's SWID
- * @lag: primary interfaces lag struct
+ * @lag: primary interface's lag struct
  * @link: is this a linking activity
  *
  * Implement setting primary SWID as shared using 0x020B
@@ -1768,6 +1782,135 @@ static int ice_create_lag_recipe(struct ice_hw *hw, u16 *rid,
 	return err;
 }
 
+/**
+ * ice_lag_move_vf_nodes_tc_sync - move a VF's nodes for a tc during reset
+ * @lag: primary interfaces lag struct
+ * @dest_hw: HW struct for destination's interface
+ * @vsi_num: VSI index in PF space
+ * @tc: traffic class to move
+ */
+static void
+ice_lag_move_vf_nodes_tc_sync(struct ice_lag *lag, struct ice_hw *dest_hw,
+			      u16 vsi_num, u8 tc)
+{
+	u16 numq, valq, buf_size, num_moved, qbuf_size;
+	struct device *dev = ice_pf_to_dev(lag->pf);
+	struct ice_aqc_cfg_txqs_buf *qbuf;
+	struct ice_aqc_move_elem *buf;
+	struct ice_sched_node *n_prt;
+	__le32 teid, parent_teid;
+	struct ice_vsi_ctx *ctx;
+	struct ice_hw *hw;
+	u32 tmp_teid;
+
+	hw = &lag->pf->hw;
+	ctx = ice_get_vsi_ctx(hw, vsi_num);
+	if (!ctx) {
+		dev_warn(dev, "LAG rebuild failed after reset due to VSI Context failure\n");
+		return;
+	}
+
+	if (!ctx->sched.vsi_node[tc])
+		return;
+
+	numq = ctx->num_lan_q_entries[tc];
+	teid = ctx->sched.vsi_node[tc]->info.node_teid;
+	tmp_teid = le32_to_cpu(teid);
+	parent_teid = ctx->sched.vsi_node[tc]->info.parent_teid;
+
+	if (!tmp_teid || !numq)
+		return;
+
+	if (ice_sched_suspend_resume_elems(hw, 1, &tmp_teid, true))
+		dev_dbg(dev, "Problem suspending traffic during reset rebuild\n");
+
+	/* reconfig queues for new port */
+	qbuf_size = struct_size(qbuf, queue_info, numq);
+	qbuf = kzalloc(qbuf_size, GFP_KERNEL);
+	if (!qbuf) {
+		dev_warn(dev, "Failure allocating VF queue recfg buffer for reset rebuild\n");
+		goto resume_sync;
+	}
+
+	/* add the per queue info for the reconfigure command buffer */
+	valq = ice_lag_qbuf_recfg(hw, qbuf, vsi_num, numq, tc);
+	if (!valq) {
+		dev_warn(dev, "Failure to reconfig queues for LAG reset rebuild\n");
+		goto sync_none;
+	}
+
+	if (ice_aq_cfg_lan_txq(hw, qbuf, qbuf_size, numq, hw->port_info->lport,
+			       dest_hw->port_info->lport, NULL)) {
+		dev_warn(dev, "Failure to configure queues for LAG reset rebuild\n");
+		goto sync_qerr;
+	}
+
+sync_none:
+	kfree(qbuf);
+
+	/* find parent in destination tree */
+	n_prt = ice_lag_get_sched_parent(dest_hw, tc);
+	if (!n_prt)
+		goto resume_sync;
+
+	/* Move node to new parent */
+	buf_size = struct_size(buf, teid, 1);
+	buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(dev, "Failure to alloc for VF node move in reset rebuild\n");
+		goto resume_sync;
+	}
+
+	buf->hdr.src_parent_teid = parent_teid;
+	buf->hdr.dest_parent_teid = n_prt->info.node_teid;
+	buf->hdr.num_elems = cpu_to_le16(1);
+	buf->hdr.mode = ICE_AQC_MOVE_ELEM_MODE_KEEP_OWN;
+	buf->teid[0] = teid;
+
+	if (ice_aq_move_sched_elems(&lag->pf->hw, 1, buf, buf_size, &num_moved,
+				    NULL))
+		dev_warn(dev, "Failure to move VF nodes for LAG reset rebuild\n");
+	else
+		ice_sched_update_parent(n_prt, ctx->sched.vsi_node[tc]);
+
+	kfree(buf);
+	goto resume_sync;
+
+sync_qerr:
+	kfree(qbuf);
+
+resume_sync:
+	if (ice_sched_suspend_resume_elems(hw, 1, &tmp_teid, false))
+		dev_warn(dev, "Problem restarting traffic for LAG node reset rebuild\n");
+}
+
+/**
+ * ice_lag_move_vf_nodes_sync - move vf nodes to active interface
+ * @lag: primary interfaces lag struct
+ * @dest_hw: lport value for currently active port
+ *
+ * This function is used in a reset context, outside of event handling,
+ * to move the VF nodes to the secondary interface when that interface
+ * is the active interface during a reset rebuild
+ */
+static void
+ice_lag_move_vf_nodes_sync(struct ice_lag *lag, struct ice_hw *dest_hw)
+{
+	struct ice_pf *pf;
+	int i, tc;
+
+	if (!lag->primary || !dest_hw)
+		return;
+
+	pf = lag->pf;
+	ice_for_each_vsi(pf, i)
+		if (pf->vsi[i] && (pf->vsi[i]->type == ICE_VSI_VF ||
+				   pf->vsi[i]->type == ICE_VSI_SWITCHDEV_CTRL))
+			ice_for_each_traffic_class(tc)
+				ice_lag_move_vf_nodes_tc_sync(lag, dest_hw, i,
+							      tc);
+}
+
 /**
  * ice_init_lag - initialize support for LAG
  * @pf: PF struct
@@ -1869,3 +2012,85 @@ void ice_deinit_lag(struct ice_pf *pf)
 
 	pf->lag = NULL;
 }
+
+/**
+ * ice_lag_rebuild - rebuild lag resources after reset
+ * @pf: pointer to local pf struct
+ *
+ * PF resets are promoted to CORER resets when interface in an aggregate.  This
+ * means that we need to rebuild the PF resources for the interface.  Since
+ * this will happen outside the normal event processing, need to acquire the lag
+ * lock.
+ *
+ * This function will also evaluate the VF resources if this is the primary
+ * interface.
+ */
+void ice_lag_rebuild(struct ice_pf *pf)
+{
+	struct ice_lag_netdev_list ndlist;
+	struct ice_lag *lag, *prim_lag;
+	struct list_head *tmp, *n;
+	u8 act_port, loc_port;
+
+	if (!pf->lag || !pf->lag->bonded)
+		return;
+
+	mutex_lock(&pf->lag_mutex);
+
+	lag = pf->lag;
+	if (lag->primary) {
+		prim_lag = lag;
+	} else {
+		struct ice_lag_netdev_list *nl;
+		struct net_device *tmp_nd;
+
+		INIT_LIST_HEAD(&ndlist.node);
+		rcu_read_lock();
+		for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
+			nl = kzalloc(sizeof(*nl), GFP_KERNEL);
+			if (!nl)
+				break;
+
+			nl->netdev = tmp_nd;
+			list_add(&nl->node, &ndlist.node);
+		}
+		rcu_read_unlock();
+		lag->netdev_head = &ndlist.node;
+		prim_lag = ice_lag_find_primary(lag);
+	}
+
+	if (!prim_lag) {
+		dev_dbg(ice_pf_to_dev(pf), "No primary interface in aggregate, can't rebuild\n");
+		goto lag_rebuild_out;
+	}
+
+	act_port = prim_lag->active_port;
+	loc_port = lag->pf->hw.port_info->lport;
+
+	/* configure SWID for this port */
+	if (lag->primary) {
+		ice_lag_primary_swid(lag, true);
+	} else {
+		ice_lag_set_swid(prim_lag->pf->hw.port_info->sw_id, lag, true);
+		ice_lag_add_prune_list(prim_lag, pf);
+		if (act_port == loc_port)
+			ice_lag_move_vf_nodes_sync(prim_lag, &pf->hw);
+	}
+
+	ice_lag_cfg_cp_fltr(lag, true);
+
+	if (lag->pf_rule_id)
+		if (ice_lag_cfg_dflt_fltr(lag, true))
+			dev_err(ice_pf_to_dev(pf), "Error adding default VSI rule in rebuild\n");
+
+	ice_clear_rdma_cap(pf);
+lag_rebuild_out:
+	list_for_each_safe(tmp, n, &ndlist.node) {
+		struct ice_lag_netdev_list *entry;
+
+		entry = list_entry(tmp, struct ice_lag_netdev_list, node);
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	mutex_unlock(&pf->lag_mutex);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index df4af5184a75..18075b82485a 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -16,6 +16,8 @@ enum ice_lag_role {
 
 #define ICE_LAG_INVALID_PORT 0xFF
 
+#define ICE_LAG_RESET_RETRIES		5
+
 struct ice_pf;
 struct ice_vf;
 
@@ -59,4 +61,5 @@ struct ice_lag_work {
 void ice_lag_move_new_vf_nodes(struct ice_vf *vf);
 int ice_init_lag(struct ice_pf *pf);
 void ice_deinit_lag(struct ice_pf *pf);
+void ice_lag_rebuild(struct ice_pf *pf);
 #endif /* _ICE_LAG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7f7728dadcbb..20d5ed572a8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -636,6 +636,11 @@ static void ice_do_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	dev_dbg(dev, "reset_type 0x%x requested\n", reset_type);
 
+	if (pf->lag && pf->lag->bonded && reset_type == ICE_RESET_PFR) {
+		dev_dbg(dev, "PFR on a bonded interface, promoting to CORER\n");
+		reset_type = ICE_RESET_CORER;
+	}
+
 	ice_prepare_for_reset(pf, reset_type);
 
 	/* trigger the reset */
@@ -719,8 +724,13 @@ static void ice_reset_subtask(struct ice_pf *pf)
 	}
 
 	/* No pending resets to finish processing. Check for new resets */
-	if (test_bit(ICE_PFR_REQ, pf->state))
+	if (test_bit(ICE_PFR_REQ, pf->state)) {
 		reset_type = ICE_RESET_PFR;
+		if (pf->lag && pf->lag->bonded) {
+			dev_dbg(ice_pf_to_dev(pf), "PFR on a bonded interface, promoting to CORER\n");
+			reset_type = ICE_RESET_CORER;
+		}
+	}
 	if (test_bit(ICE_CORER_REQ, pf->state))
 		reset_type = ICE_RESET_CORER;
 	if (test_bit(ICE_GLOBR_REQ, pf->state))
@@ -7373,6 +7383,8 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	clear_bit(ICE_RESET_FAILED, pf->state);
 
 	ice_plug_aux_dev(pf);
+	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
+		ice_lag_rebuild(pf);
 	return;
 
 err_vsi_rebuild:
-- 
2.38.1


