Return-Path: <netdev+bounces-126100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C096196FDFC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24AF1F222BE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A491315B977;
	Fri,  6 Sep 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pc5Dk5Uu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F2A15B137
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661819; cv=none; b=D1MDTom6fOwbjpUtyuZSftJ1usHlpfQSpsKxYLE1sU3lzQ2nuETlLyQbPohWsFIUQkZwRxcu+P5sj45ak2MkAH56xgU6+4v+svnQLu8DTMLSFcAq0IYdoKBC0EdJEMUfTyS3B2iHzwsD0+uo+zo2J6BMUu3y+WNzug+XXS53yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661819; c=relaxed/simple;
	bh=izUmmX4pSvlQN6mlyhcn/HqGKAb6N9FyoYbFM8cl+Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nq7VeA/tIrLl4fB+uPqmaSwJj9dSoAsPJ8mInTCvODj+KnHNk4VFT80Y6xhyrxXXejqkESLUDPXSGvrUiGZ/GT8v4nWgsGSXgAFgXOFv8g/CD9dDLbz+5Gy0u26OGlE7zen2MJ0ROtf7Yg7CgLlsv51vp70ZQbQH6AVjB6JCvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pc5Dk5Uu; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661818; x=1757197818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=izUmmX4pSvlQN6mlyhcn/HqGKAb6N9FyoYbFM8cl+Ro=;
  b=Pc5Dk5Uu2FmWTbDGnWSL8gUQMv1O9yd0WdTaooHOZmRRAX398tjez4DF
   rWH7CPvmxEDyihS1tlZp4dOBSQ3vhD7goDleB49mVUN6C/y80eW7eN2UT
   ljlCJ0/foIGr3S7MOLUyd4PdlLkBa/MwYD1dwv+ktpMF5DySHF0Jt1Ovh
   hDE2LoFw6etT/xSq8kLIyHD2EmjC4agCXnUahpKKDTGg++MdEUSsL7EIv
   MZTHXtvjQMANmKyOTBpodDot8Edff0/v7kTqKATniH/ubLIjCyRUkA8Qg
   u2AJ5cCrpoI0ldza/Ve+fyLXxRjVBRNDfWeJFUSv88W4PNprhiWD0WwRf
   A==;
X-CSE-ConnectionGUID: VT2RtfKiTSit8fMuhCtbtA==
X-CSE-MsgGUID: 3tnq0OR1R5WZmEl9Ojn6FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030730"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030730"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:17 -0700
X-CSE-ConnectionGUID: DHJh3h5cQeqD9pyvalrPcw==
X-CSE-MsgGUID: sBLGKyMtQp6fSWlt9I+1PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490443"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v5 08/15] ice: make representor code generic
Date: Fri,  6 Sep 2024 15:29:59 -0700
Message-ID: <20240906223010.2194591-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Keep the same flow of port representor creation, but instead of general
attach function create helpers for specific representor type.

Store function pointer for add and remove representor.

Type of port representor can be also known based on VSI type, but it
is more clean to have it directly saved in port representor structure.

Add devlink lock for whole port representor creation and destruction.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.h |  2 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 72 ++++++++++-----
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 +--
 drivers/net/ethernet/intel/ice/ice_repr.c     | 88 +++++++++----------
 drivers/net/ethernet/intel/ice/ice_repr.h     | 16 +++-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  4 +-
 7 files changed, 121 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 97b21b58c300..479d2b976745 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -14,6 +14,7 @@
  * @devlink_port: the associated devlink port structure
  * @pf: pointer to the PF private structure
  * @vsi: the VSI associated with this port
+ * @repr_id: the representor ID
  * @sfnum: the subfunction ID
  *
  * An instance of a dynamically added devlink port. Each port flavour
@@ -24,6 +25,7 @@ struct ice_dynamic_port {
 	struct devlink_port devlink_port;
 	struct ice_pf *pf;
 	struct ice_vsi *vsi;
+	unsigned long repr_id;
 	u32 sfnum;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 3cfa071e3718..00d49477bdcb 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -452,11 +452,9 @@ static void ice_eswitch_start_reprs(struct ice_pf *pf)
 	ice_eswitch_start_all_tx_queues(pf);
 }
 
-int
-ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
+static int
+ice_eswitch_attach(struct ice_pf *pf, struct ice_repr *repr, unsigned long *id)
 {
-	struct devlink *devlink = priv_to_devlink(pf);
-	struct ice_repr *repr;
 	int err;
 
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_LEGACY)
@@ -470,13 +468,9 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 
 	ice_eswitch_stop_reprs(pf);
 
-	devl_lock(devlink);
-	repr = ice_repr_add_vf(vf);
-	devl_unlock(devlink);
-	if (IS_ERR(repr)) {
-		err = PTR_ERR(repr);
+	err = repr->ops.add(repr);
+	if (err)
 		goto err_create_repr;
-	}
 
 	err = ice_eswitch_setup_repr(pf, repr);
 	if (err)
@@ -486,7 +480,7 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 	if (err)
 		goto err_xa_alloc;
 
-	vf->repr_id = repr->id;
+	*id = repr->id;
 
 	ice_eswitch_start_reprs(pf);
 
@@ -495,9 +489,7 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 err_xa_alloc:
 	ice_eswitch_release_repr(pf, repr);
 err_setup_repr:
-	devl_lock(devlink);
-	ice_repr_rem_vf(repr);
-	devl_unlock(devlink);
+	repr->ops.rem(repr);
 err_create_repr:
 	if (xa_empty(&pf->eswitch.reprs))
 		ice_eswitch_disable_switchdev(pf);
@@ -506,14 +498,35 @@ ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
 	return err;
 }
 
-void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
+/**
+ * ice_eswitch_attach_vf - attach VF to a eswitch
+ * @pf: pointer to PF structure
+ * @vf: pointer to VF structure to be attached
+ *
+ * During attaching port representor for VF is created.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
-	struct ice_repr *repr = xa_load(&pf->eswitch.reprs, vf->repr_id);
+	struct ice_repr *repr = ice_repr_create_vf(vf);
 	struct devlink *devlink = priv_to_devlink(pf);
+	int err;
 
-	if (!repr)
-		return;
+	if (IS_ERR(repr))
+		return PTR_ERR(repr);
 
+	devl_lock(devlink);
+	err = ice_eswitch_attach(pf, repr, &vf->repr_id);
+	if (err)
+		ice_repr_destroy(repr);
+	devl_unlock(devlink);
+
+	return err;
+}
+
+static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
+{
 	ice_eswitch_stop_reprs(pf);
 	xa_erase(&pf->eswitch.reprs, repr->id);
 
@@ -521,10 +534,12 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 		ice_eswitch_disable_switchdev(pf);
 
 	ice_eswitch_release_repr(pf, repr);
-	devl_lock(devlink);
-	ice_repr_rem_vf(repr);
+	repr->ops.rem(repr);
+	ice_repr_destroy(repr);
 
 	if (xa_empty(&pf->eswitch.reprs)) {
+		struct devlink *devlink = priv_to_devlink(pf);
+
 		/* since all port representors are destroyed, there is
 		 * no point in keeping the nodes
 		 */
@@ -533,6 +548,23 @@ void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf)
 	} else {
 		ice_eswitch_start_reprs(pf);
 	}
+}
+
+/**
+ * ice_eswitch_detach_vf - detach VF from a eswitch
+ * @pf: pointer to PF structure
+ * @vf: pointer to VF structure to be detached
+ */
+void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf)
+{
+	struct ice_repr *repr = xa_load(&pf->eswitch.reprs, vf->repr_id);
+	struct devlink *devlink = priv_to_devlink(pf);
+
+	if (!repr)
+		return;
+
+	devl_lock(devlink);
+	ice_eswitch_detach(pf, repr);
 	devl_unlock(devlink);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 78fd39a6935d..d1699954a7ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -5,11 +5,11 @@
 #define _ICE_ESWITCH_H_
 
 #include <net/devlink.h>
+#include "devlink/devlink_port.h"
 
 #ifdef CONFIG_ICE_SWITCHDEV
-void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf);
-int
-ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf);
+void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
+int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int
@@ -31,10 +31,11 @@ struct net_device *ice_eswitch_get_target(struct ice_rx_ring *rx_ring,
 int ice_eswitch_cfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 #else /* CONFIG_ICE_SWITCHDEV */
-static inline void ice_eswitch_detach(struct ice_pf *pf, struct ice_vf *vf) { }
+static inline void
+ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf) { }
 
 static inline int
-ice_eswitch_attach(struct ice_pf *pf, struct ice_vf *vf)
+ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index bdda3401e343..5d71f623b1e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -283,34 +283,23 @@ ice_repr_reg_netdev(struct net_device *netdev)
 	return register_netdev(netdev);
 }
 
-static void ice_repr_remove_node(struct devlink_port *devlink_port)
-{
-	devl_rate_leaf_destroy(devlink_port);
-}
-
 /**
- * ice_repr_rem - remove representor from VF
+ * ice_repr_destroy - remove representor from VF
  * @repr: pointer to representor structure
  */
-static void ice_repr_rem(struct ice_repr *repr)
+void ice_repr_destroy(struct ice_repr *repr)
 {
 	free_percpu(repr->stats);
 	free_netdev(repr->netdev);
 	kfree(repr);
 }
 
-/**
- * ice_repr_rem_vf - remove representor from VF
- * @repr: pointer to representor structure
- */
-void ice_repr_rem_vf(struct ice_repr *repr)
+static void ice_repr_rem_vf(struct ice_repr *repr)
 {
-	ice_repr_remove_node(&repr->vf->devlink_port);
 	ice_eswitch_decfg_vsi(repr->src_vsi, repr->parent_mac);
 	unregister_netdev(repr->netdev);
 	ice_devlink_destroy_vf_port(repr->vf);
 	ice_virtchnl_set_dflt_ops(repr->vf);
-	ice_repr_rem(repr);
 }
 
 static void ice_repr_set_tx_topology(struct ice_pf *pf)
@@ -327,13 +316,10 @@ static void ice_repr_set_tx_topology(struct ice_pf *pf)
 }
 
 /**
- * ice_repr_add - add representor for generic VSI
- * @pf: pointer to PF structure
+ * ice_repr_create - add representor for generic VSI
  * @src_vsi: pointer to VSI structure of device to represent
- * @parent_mac: device MAC address
  */
-static struct ice_repr *
-ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
+static struct ice_repr *ice_repr_create(struct ice_vsi *src_vsi)
 {
 	struct ice_netdev_priv *np;
 	struct ice_repr *repr;
@@ -360,7 +346,10 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	np = netdev_priv(repr->netdev);
 	np->repr = repr;
 
-	ether_addr_copy(repr->parent_mac, parent_mac);
+	repr->netdev->min_mtu = ETH_MIN_MTU;
+	repr->netdev->max_mtu = ICE_MAX_MTU;
+
+	SET_NETDEV_DEV(repr->netdev, ice_pf_to_dev(src_vsi->back));
 
 	return repr;
 
@@ -371,32 +360,15 @@ ice_repr_add(struct ice_pf *pf, struct ice_vsi *src_vsi, const u8 *parent_mac)
 	return ERR_PTR(err);
 }
 
-struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
+static int ice_repr_add_vf(struct ice_repr *repr)
 {
-	struct ice_repr *repr;
-	struct ice_vsi *vsi;
+	struct ice_vf *vf = repr->vf;
 	int err;
 
-	vsi = ice_get_vf_vsi(vf);
-	if (!vsi)
-		return ERR_PTR(-ENOENT);
-
 	err = ice_devlink_create_vf_port(vf);
 	if (err)
-		return ERR_PTR(err);
-
-	repr = ice_repr_add(vf->pf, vsi, vf->hw_lan_addr);
-	if (IS_ERR(repr)) {
-		err = PTR_ERR(repr);
-		goto err_repr_add;
-	}
-
-	repr->vf = vf;
+		return err;
 
-	repr->netdev->min_mtu = ETH_MIN_MTU;
-	repr->netdev->max_mtu = ICE_MAX_MTU;
-
-	SET_NETDEV_DEV(repr->netdev, ice_pf_to_dev(vf->pf));
 	SET_NETDEV_DEVLINK_PORT(repr->netdev, &vf->devlink_port);
 	err = ice_repr_reg_netdev(repr->netdev);
 	if (err)
@@ -409,15 +381,43 @@ struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 	ice_virtchnl_set_repr_ops(vf);
 	ice_repr_set_tx_topology(vf->pf);
 
-	return repr;
+	return 0;
 
 err_cfg_vsi:
 	unregister_netdev(repr->netdev);
 err_netdev:
-	ice_repr_rem(repr);
-err_repr_add:
 	ice_devlink_destroy_vf_port(vf);
-	return ERR_PTR(err);
+	return err;
+}
+
+/**
+ * ice_repr_create_vf - add representor for VF VSI
+ * @vf: VF to create port representor on
+ *
+ * Set correct representor type for VF and functions pointer.
+ *
+ * Return: created port representor on success, error otherwise
+ */
+struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
+{
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+	struct ice_repr *repr;
+
+	if (!vsi)
+		return ERR_PTR(-EINVAL);
+
+	repr = ice_repr_create(vsi);
+	if (!repr)
+		return ERR_PTR(-ENOMEM);
+
+	repr->type = ICE_REPR_TYPE_VF;
+	repr->vf = vf;
+	repr->ops.add = ice_repr_add_vf;
+	repr->ops.rem = ice_repr_rem_vf;
+
+	ether_addr_copy(repr->parent_mac, vf->hw_lan_addr);
+
+	return repr;
 }
 
 struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id)
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index 488661b2900b..c6e77b9c6a32 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -15,19 +15,29 @@ struct ice_repr_pcpu_stats {
 	u64 tx_drops;
 };
 
+enum ice_repr_type {
+	ICE_REPR_TYPE_VF,
+};
+
 struct ice_repr {
 	struct ice_vsi *src_vsi;
-	struct ice_vf *vf;
 	struct net_device *netdev;
 	struct metadata_dst *dst;
 	struct ice_esw_br_port *br_port;
 	struct ice_repr_pcpu_stats __percpu *stats;
 	u32 id;
 	u8 parent_mac[ETH_ALEN];
+	enum ice_repr_type type;
+	struct ice_vf *vf;
+	struct {
+		int (*add)(struct ice_repr *repr);
+		void (*rem)(struct ice_repr *repr);
+	} ops;
 };
 
-struct ice_repr *ice_repr_add_vf(struct ice_vf *vf);
-void ice_repr_rem_vf(struct ice_repr *repr);
+struct ice_repr *ice_repr_create_vf(struct ice_vf *vf);
+
+void ice_repr_destroy(struct ice_repr *repr);
 
 void ice_repr_start_tx_queues(struct ice_repr *repr);
 void ice_repr_stop_tx_queues(struct ice_repr *repr);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 55ef33208456..e34fe2516ccc 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -175,7 +175,7 @@ void ice_free_vfs(struct ice_pf *pf)
 	ice_for_each_vf(pf, bkt, vf) {
 		mutex_lock(&vf->cfg_lock);
 
-		ice_eswitch_detach(pf, vf);
+		ice_eswitch_detach_vf(pf, vf);
 		ice_dis_vf_qs(vf);
 
 		if (test_bit(ICE_VF_STATE_INIT, vf->vf_states)) {
@@ -598,7 +598,7 @@ static int ice_start_vfs(struct ice_pf *pf)
 			goto teardown;
 		}
 
-		retval = ice_eswitch_attach(pf, vf);
+		retval = ice_eswitch_attach_vf(pf, vf);
 		if (retval) {
 			dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
 				vf->vf_id, retval);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 5635e9da2212..a69e91f88d81 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -766,7 +766,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 	ice_for_each_vf(pf, bkt, vf) {
 		mutex_lock(&vf->cfg_lock);
 
-		ice_eswitch_detach(pf, vf);
+		ice_eswitch_detach_vf(pf, vf);
 		vf->driver_caps = 0;
 		ice_vc_set_default_allowlist(vf);
 
@@ -782,7 +782,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 		ice_vf_rebuild_vsi(vf);
 		ice_vf_post_vsi_rebuild(vf);
 
-		ice_eswitch_attach(pf, vf);
+		ice_eswitch_attach_vf(pf, vf);
 
 		mutex_unlock(&vf->cfg_lock);
 	}
-- 
2.42.0


