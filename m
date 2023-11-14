Return-Path: <netdev+bounces-47791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C354C7EB63A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04EEBB20CD8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5D42FC3D;
	Tue, 14 Nov 2023 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNK5HHOU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFD26AD8
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A07122
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985724; x=1731521724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sCE2TgpoMiaKVWRY/qmFSYtC2ziv1162XLMTh1G9Sbo=;
  b=PNK5HHOU55+3avWPmyh7hwwNYHxmulFSQJwoyQoAVTy30Oe1H9drKf1r
   LSKZcUZaI52F7JTFSCMJYGT0Lb3jI3lcm4ZsJWoccSZvi8n1+Y13YW+70
   vKFId0yaudn5KT7gBDWVR0wI/f6RmX8cCItb5gSpInkLRkVq1/LtEMBl7
   tskSUrUiQgsuG+M6ZtrtlJf7l6w43tegI1/d+6tDjUuy0TFfx+3mrJiHc
   qM2uU+cL5TINHgiZkn4eTnW3cWhX4hlWHR5bnnX63jUGuSexGd80kRXeN
   eoJiwlezysMI9gIszgrU9GzOXoMXjaK2VXDXBixcOAm5ovW69mgowyPnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514503"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514503"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160951"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160951"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:01 -0800
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
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 08/15] ice: make representor code generic
Date: Tue, 14 Nov 2023 10:14:28 -0800
Message-ID: <20231114181449.1290117-9-anthony.l.nguyen@intel.com>
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

Representor code needs to be independent from specific device type, like
in this case VF. Make generic add / remove representor function and
specific add VF / rem VF function. New device types will follow this
scheme.

In bridge offload code there is a need to get representor pointer based
on VSI. Implement helper function to achieve that.

Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   9 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |   4 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 184 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_repr.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +-
 8 files changed, 131 insertions(+), 92 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 66cbe2c80fea..67231e43ffa6 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -285,17 +285,22 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 
 /**
  * ice_eswitch_update_repr - reconfigure port representor
- * @repr: pointer to repr struct
+ * @repr_id: representor ID
  * @vsi: VSI for which port representor is configured
  */
-void ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi)
+void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
+	struct ice_repr *repr;
 	int ret;
 
 	if (!ice_is_switchdev_running(pf))
 		return;
 
+	repr = xa_load(&pf->eswitch.reprs, repr_id);
+	if (!repr)
+		return;
+
 	repr->src_vsi = vsi;
 	repr->dst->u.port_info.port_id = vsi->vsi_num;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index f43db1cce3ad..ff110bd9fc4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -17,7 +17,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack);
 bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
 
-void ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi);
+void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi);
 
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf);
 
@@ -35,7 +35,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 			   struct ice_tx_offload_params *off) { }
 
 static inline void
-ice_eswitch_update_repr(struct ice_repr *repr, struct ice_vsi *vsi) { }
+ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index 16bbcaca8fda..ac5beecd028b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -893,10 +893,14 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
 			ice_eswitch_br_fdb_entry_delete(bridge, fdb_entry);
 	}
 
-	if (br_port->type == ICE_ESWITCH_BR_UPLINK_PORT && vsi->back)
+	if (br_port->type == ICE_ESWITCH_BR_UPLINK_PORT && vsi->back) {
 		vsi->back->br_port = NULL;
-	else if (vsi->vf && vsi->vf->repr)
-		vsi->vf->repr->br_port = NULL;
+	} else {
+		struct ice_repr *repr = ice_repr_get_by_vsi(vsi);
+
+		if (repr)
+			repr->br_port = NULL;
+	}
 
 	xa_erase(&bridge->ports, br_port->vsi_idx);
 	ice_eswitch_br_port_vlans_flush(br_port);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 4b1e56396293..ae4b4220e1bb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -519,16 +519,14 @@ static irqreturn_t ice_eswitch_msix_clean_rings(int __always_unused irq, void *d
 {
 	struct ice_q_vector *q_vector = (struct ice_q_vector *)data;
 	struct ice_pf *pf = q_vector->vsi->back;
-	struct ice_vf *vf;
-	unsigned int bkt;
+	struct ice_repr *repr;
+	unsigned long id;
 
 	if (!q_vector->tx.tx_ring && !q_vector->rx.rx_ring)
 		return IRQ_HANDLED;
 
-	rcu_read_lock();
-	ice_for_each_vf_rcu(pf, bkt, vf)
-		napi_schedule(&vf->repr->q_vector->napi);
-	rcu_read_unlock();
+	xa_for_each(&pf->eswitch.reprs, id, repr)
+		napi_schedule(&repr->q_vector->napi);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 77cc77ab826a..fce25472d053 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -14,7 +14,7 @@
  */
 static int ice_repr_get_sw_port_id(struct ice_repr *repr)
 {
-	return repr->vf->pf->hw.port_info->lport;
+	return repr->src_vsi->back->hw.port_info->lport;
 }
 
 /**
@@ -35,7 +35,7 @@ ice_repr_get_phys_port_name(struct net_device *netdev, char *buf, size_t len)
 		return -EOPNOTSUPP;
 
 	res = snprintf(buf, len, "pf%dvfr%d", ice_repr_get_sw_port_id(repr),
-		       repr->vf->vf_id);
+		       repr->id);
 	if (res <= 0)
 		return -EOPNOTSUPP;
 	return 0;
@@ -279,24 +279,72 @@ ice_repr_reg_netdev(struct net_device *netdev)
 }
 
 /**
- * ice_repr_add - add representor for VF
- * @vf: pointer to VF structure
+ * ice_repr_rem - remove representor from VF
+ * @reprs: xarray storing representors
+ * @repr: pointer to representor structure
  */
-static int ice_repr_add(struct ice_vf *vf)
+static void ice_repr_rem(struct xarray *reprs, struct ice_repr *repr)
+{
+	xa_erase(reprs, repr->id);
+	kfree(repr->q_vector);
+	free_netdev(repr->netdev);
+	kfree(repr);
+}
+
+static void ice_repr_rem_vf(struct ice_vf *vf)
+{
+	struct ice_repr *repr = xa_load(&vf->pf->eswitch.reprs, vf->repr_id);
+
+	if (!repr)
+		return;
+
+	unregister_netdev(repr->netdev);
+	ice_repr_rem(&vf->pf->eswitch.reprs, repr);
+	ice_devlink_destroy_vf_port(vf);
+	ice_virtchnl_set_dflt_ops(vf);
+}
+
+/**
+ * ice_repr_rem_from_all_vfs - remove port representor for all VFs
+ * @pf: pointer to PF structure
+ */
+void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
+{
+	struct devlink *devlink;
+	struct ice_vf *vf;
+	unsigned int bkt;
+
+	lockdep_assert_held(&pf->vfs.table_lock);
+
+	ice_for_each_vf(pf, bkt, vf)
+		ice_repr_rem_vf(vf);
+
+	/* since all port representors are destroyed, there is
+	 * no point in keeping the nodes
+	 */
+	devlink = priv_to_devlink(pf);
+	devl_lock(devlink);
+	devl_rate_nodes_destroy(devlink);
+	devl_unlock(devlink);
+}
+
+/**
+ * ice_repr_add - add representor for generic VSI
+ * @pf: pointer to PF structure
+ * @src_vsi: pointer to VSI structure of device to represent
+ * @parent_mac: device MAC address
+ */
+static struct ice_repr *
+ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 {
 	struct ice_q_vector *q_vector;
 	struct ice_netdev_priv *np;
 	struct ice_repr *repr;
-	struct ice_vsi *vsi;
 	int err;
 
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
-		return -EINVAL;
-
 	repr = kzalloc(sizeof(*repr), GFP_KERNEL);
 	if (!repr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	repr->netdev = alloc_etherdev(sizeof(struct ice_netdev_priv));
 	if (!repr->netdev) {
@@ -304,10 +352,7 @@ static int ice_repr_add(struct ice_vf *vf)
 		goto err_alloc;
 	}
 
-	repr->src_vsi = vsi;
-	repr->vf = vf;
-	repr->q_id = vf->vf_id;
-	vf->repr = repr;
+	repr->src_vsi = src_vsi;
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
 
@@ -318,14 +363,47 @@ static int ice_repr_add(struct ice_vf *vf)
 	}
 	repr->q_vector = q_vector;
 
-	err = xa_alloc(&vf->pf->eswitch.reprs, &repr->id, repr,
-		       xa_limit_32b, GFP_KERNEL);
+	err = xa_alloc(&pf->eswitch.reprs, &repr->id, repr,
+		       XA_LIMIT(1, INT_MAX), GFP_KERNEL);
 	if (err)
 		goto err_xa_alloc;
+	repr->q_id = repr->id;
+
+	ether_addr_copy(repr->parent_mac, parent_mac);
+
+	return repr;
+
+err_xa_alloc:
+	kfree(repr->q_vector);
+err_alloc_q_vector:
+	free_netdev(repr->netdev);
+err_alloc:
+	kfree(repr);
+	return ERR_PTR(err);
+}
+
+static int ice_repr_add_vf(struct ice_vf *vf)
+{
+	struct ice_repr *repr;
+	struct ice_vsi *vsi;
+	int err;
+
+	vsi = ice_get_vf_vsi(vf);
+	if (!vsi)
+		return -EINVAL;
 
 	err = ice_devlink_create_vf_port(vf);
 	if (err)
-		goto err_devlink;
+		return err;
+
+	repr = ice_repr_add(vf->pf, vsi, vf->hw_lan_addr);
+	if (IS_ERR(repr)) {
+		err = PTR_ERR(repr);
+		goto err_repr_add;
+	}
+
+	vf->repr_id = repr->id;
+	repr->vf = vf;
 
 	repr->netdev->min_mtu = ETH_MIN_MTU;
 	repr->netdev->max_mtu = ICE_MAX_MTU;
@@ -336,73 +414,17 @@ static int ice_repr_add(struct ice_vf *vf)
 	if (err)
 		goto err_netdev;
 
-	ether_addr_copy(repr->parent_mac, vf->hw_lan_addr);
 	ice_virtchnl_set_repr_ops(vf);
 
 	return 0;
 
 err_netdev:
+	ice_repr_rem(&vf->pf->eswitch.reprs, repr);
+err_repr_add:
 	ice_devlink_destroy_vf_port(vf);
-err_devlink:
-	xa_erase(&vf->pf->eswitch.reprs, repr->id);
-err_xa_alloc:
-	kfree(repr->q_vector);
-	vf->repr->q_vector = NULL;
-err_alloc_q_vector:
-	free_netdev(repr->netdev);
-	repr->netdev = NULL;
-err_alloc:
-	kfree(repr);
-	vf->repr = NULL;
 	return err;
 }
 
-/**
- * ice_repr_rem - remove representor from VF
- * @vf: pointer to VF structure
- */
-static void ice_repr_rem(struct ice_vf *vf)
-{
-	struct ice_repr *repr = vf->repr;
-
-	if (!repr)
-		return;
-
-	kfree(repr->q_vector);
-	unregister_netdev(repr->netdev);
-	ice_devlink_destroy_vf_port(vf);
-	xa_erase(&vf->pf->eswitch.reprs, repr->id);
-	free_netdev(repr->netdev);
-	kfree(repr);
-	vf->repr = NULL;
-
-	ice_virtchnl_set_dflt_ops(vf);
-}
-
-/**
- * ice_repr_rem_from_all_vfs - remove port representor for all VFs
- * @pf: pointer to PF structure
- */
-void ice_repr_rem_from_all_vfs(struct ice_pf *pf)
-{
-	struct devlink *devlink;
-	struct ice_vf *vf;
-	unsigned int bkt;
-
-	lockdep_assert_held(&pf->vfs.table_lock);
-
-	ice_for_each_vf(pf, bkt, vf)
-		ice_repr_rem(vf);
-
-	/* since all port representors are destroyed, there is
-	 * no point in keeping the nodes
-	 */
-	devlink = priv_to_devlink(pf);
-	devl_lock(devlink);
-	devl_rate_nodes_destroy(devlink);
-	devl_unlock(devlink);
-}
-
 /**
  * ice_repr_add_for_all_vfs - add port representor for all VFs
  * @pf: pointer to PF structure
@@ -417,7 +439,7 @@ int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 	lockdep_assert_held(&pf->vfs.table_lock);
 
 	ice_for_each_vf(pf, bkt, vf) {
-		err = ice_repr_add(vf);
+		err = ice_repr_add_vf(vf);
 		if (err)
 			goto err;
 	}
@@ -437,6 +459,14 @@ int ice_repr_add_for_all_vfs(struct ice_pf *pf)
 	return err;
 }
 
+struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi)
+{
+	if (!vsi->vf)
+		return NULL;
+
+	return xa_load(&vsi->back->eswitch.reprs, vsi->vf->repr_id);
+}
+
 /**
  * ice_repr_start_tx_queues - start Tx queues of port representor
  * @repr: pointer to repr structure
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index 735cb556c620..a3cd256d82b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -32,4 +32,6 @@ void ice_repr_set_traffic_vsi(struct ice_repr *repr, struct ice_vsi *vsi);
 
 struct ice_repr *ice_netdev_to_repr(struct net_device *netdev);
 bool ice_is_port_repr_netdev(const struct net_device *netdev);
+
+struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi);
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 462ee9fdf815..68f9de0a7a8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -928,7 +928,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		goto out_unlock;
 	}
 
-	ice_eswitch_update_repr(vf->repr, vsi);
+	ice_eswitch_update_repr(vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
 	ice_mbx_clear_malvf(&vf->mbx_info);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 93c774f2f437..35866553f288 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -130,7 +130,7 @@ struct ice_vf {
 	struct ice_mdd_vf_events mdd_tx_events;
 	DECLARE_BITMAP(opcodes_allowlist, VIRTCHNL_OP_MAX);
 
-	struct ice_repr *repr;
+	unsigned long repr_id;
 	const struct ice_virtchnl_ops *virtchnl_ops;
 	const struct ice_vf_ops *vf_ops;
 
-- 
2.41.0


