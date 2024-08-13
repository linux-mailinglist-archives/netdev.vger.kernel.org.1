Return-Path: <netdev+bounces-118208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB940950F50
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486F9B23960
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBFF1ABEA8;
	Tue, 13 Aug 2024 21:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+SXhMjN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D61ABEC9
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585825; cv=none; b=vCiy51JAU2ijvQvOsYEz+GlCImvsbLYDtryinBtWRr/GKWdgiMtSFMnHMRoKxcbuBIpsopQc6c9xcVTpJw7FoQ3rzBHPofCd6trgCFYjR8gMdZ5NtqxoFHB7DtSHdXF0cnODw4dZF1a6LznbNDNa3TeLg2gfit5hE4MzkmmrKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585825; c=relaxed/simple;
	bh=QjT4gMecCC7SYeehENQKbQer24Cma6a8Bn0zgG8sNUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtZWkPv6NY3qqDKGAWe19PBQM0+yhlAOPH+OCtok5KG3Wl52BBUS5bLiAZihofEdGCLdHfMzxb4Vj7iL9JAOxnViHjqgzXZb/0EV2w+bvgIYYKJEWwOwO07Mr9u16Fjs4sDi0uW1vr3KYj6aYa2CND1qwl0Oz+xSUVgI3FAfU+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+SXhMjN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585824; x=1755121824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjT4gMecCC7SYeehENQKbQer24Cma6a8Bn0zgG8sNUo=;
  b=k+SXhMjN2t5889x7PjDKJa73oHzZRf9XZYN+s8awEut+lEMZqen2eD6b
   SulmEjZ11fUOc8nJNYPv7JWnFhoO1610raOPqVZhCd8NofVnkNIti/vHR
   YcdWdxlHUF9Sij8Xx8qgBfvySMkwv//LOVJ6cmwintesHzM07DAIposHo
   Gg4p2OsGzHllwDHyis5tFfgd1xveggp+GaO3LKrW+OBS2TevY3hSroX/S
   lAGPhvFbmWMMNRlDCtCPde3uAfGi8Yd0Sy0A79v18ZZWzFkPvxhlfxYLl
   Ay1GT100Y/3LerOIa0dR0a/l8RFcrvBhMVzYm12YCcdX3u46y8aJ2fnaJ
   g==;
X-CSE-ConnectionGUID: iPJsVp3qSiS0esdHHn4R0Q==
X-CSE-MsgGUID: W4H4N9L9RF6LanSKWssA4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748168"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:08 -0700
X-CSE-ConnectionGUID: S3LWyn7uQRqMix3ZZ0cXpw==
X-CSE-MsgGUID: ad6x1n34TTu1v090prtBjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685581"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:08 -0700
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
Subject: [PATCH net-next v4 09/15] ice: create port representor for SF
Date: Tue, 13 Aug 2024 14:49:58 -0700
Message-ID: <20240813215005.3647350-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement attaching and detaching SF port representor. It is done in the
same way as the VF port representor.

SF port representor is always added or removed with devlink
lock taken.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c |  6 +--
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 39 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 ++++
 drivers/net/ethernet/intel/ice/ice_repr.c     | 52 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |  2 +
 6 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 4df72aefa6df..844702a49a92 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -543,7 +543,7 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 	struct ice_pf *pf = dyn_port->pf;
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
-	devl_port_unregister(devlink_port);
+	ice_eswitch_detach_sf(pf, dyn_port);
 	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
 	kfree(dyn_port);
@@ -765,9 +765,9 @@ ice_alloc_dynamic_port(struct ice_pf *pf,
 		goto unroll_vsi_alloc;
 	}
 
-	err = ice_devlink_create_sf_port(dyn_port);
+	err = ice_eswitch_attach_sf(pf, dyn_port);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Port registration failed");
+		NL_SET_ERR_MSG_MOD(extack, "Failed to attach SF to eswitch");
 		goto unroll_xa_insert;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 00d49477bdcb..c0b3e70a7ea3 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -525,6 +525,30 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	return err;
 }
 
+/**
+ * ice_eswitch_attach_sf - attach SF to a eswitch
+ * @pf: pointer to PF structure
+ * @sf: pointer to SF structure to be attached
+ *
+ * During attaching port representor for SF is created.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = ice_repr_create_sf(sf);
+	int err;
+
+	if (IS_ERR(repr))
+		return PTR_ERR(repr);
+
+	err = ice_eswitch_attach(pf, repr, &sf->repr_id);
+	if (err)
+		ice_repr_destroy(repr);
+
+	return err;
+}
+
 static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 {
 	ice_eswitch_stop_reprs(pf);
@@ -568,6 +592,21 @@ void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	devl_unlock(devlink);
 }
 
+/**
+ * ice_eswitch_detach_sf - detach SF from a eswitch
+ * @pf: pointer to PF structure
+ * @sf: pointer to SF structure to be detached
+ */
+void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = xa_load(&pf->eswitch.reprs, sf->repr_id);
+
+	if (!repr)
+		return;
+
+	ice_eswitch_detach(pf, repr);
+}
+
 /**
  * ice_eswitch_get_target - get netdev based on src_vsi from descriptor
  * @rx_ring: ring used to receive the packet
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index d1699954a7ad..20ce32dda69c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -9,7 +9,9 @@
 
 #ifdef CONFIG_ICE_SWITCHDEV
 void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
+void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf);
+int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int
@@ -34,12 +36,21 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 static inline void
 ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf) { }
 
+static inline void
+ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf) { }
+
 static inline int
 ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int
+ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf) { }
 
 static inline void
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5d71f623b1e0..5ea8b512c421 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -302,6 +302,12 @@ static void ice_repr_rem_vf(struct ice_repr *repr)
 	ice_virtchnl_set_dflt_ops(repr->vf);
 }
 
+static void ice_repr_rem_sf(struct ice_repr *repr)
+{
+	unregister_netdev(repr->netdev);
+	ice_devlink_destroy_sf_port(repr->sf);
+}
+
 static void ice_repr_set_tx_topology(struct ice_pf *pf)
 {
 	struct devlink *devlink;
@@ -420,6 +426,52 @@ struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
 	return repr;
 }
 
+static int ice_repr_add_sf(struct ice_repr *repr)
+{
+	struct ice_dynamic_port *sf = repr->sf;
+	int err;
+
+	err = ice_devlink_create_sf_port(sf);
+	if (err)
+		return err;
+
+	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
+	err = ice_repr_reg_netdev(repr->netdev);
+	if (err)
+		goto err_netdev;
+
+	return 0;
+
+err_netdev:
+	ice_devlink_destroy_sf_port(sf);
+	return err;
+}
+
+/**
+ * ice_repr_create_sf - add representor for SF VSI
+ * @sf: SF to create port representor on
+ *
+ * Set correct representor type for SF and functions pointer.
+ *
+ * Return: created port representor on success, error otherwise
+ */
+struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = ice_repr_create(sf->vsi);
+
+	if (!repr)
+		return ERR_PTR(-ENOMEM);
+
+	repr->type = ICE_REPR_TYPE_SF;
+	repr->sf = sf;
+	repr->ops.add = ice_repr_add_sf;
+	repr->ops.rem = ice_repr_rem_sf;
+
+	ether_addr_copy(repr->parent_mac, sf->hw_addr);
+
+	return repr;
+}
+
 struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id)
 {
 	return xa_load(&pf->eswitch.reprs, id);
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index c6e77b9c6a32..ee28632e87b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -17,6 +17,7 @@ struct ice_repr_pcpu_stats {
 
 enum ice_repr_type {
 	ICE_REPR_TYPE_VF,
+	ICE_REPR_TYPE_SF,
 };
 
 struct ice_repr {
@@ -28,7 +29,10 @@ struct ice_repr {
 	u32 id;
 	u8 parent_mac[ETH_ALEN];
 	enum ice_repr_type type;
-	struct ice_vf *vf;
+	union {
+		struct ice_vf *vf;
+		struct ice_dynamic_port *sf;
+	};
 	struct {
 		int (*add)(struct ice_repr *repr);
 		void (*rem)(struct ice_repr *repr);
@@ -36,6 +40,7 @@ struct ice_repr {
 };
 
 struct ice_repr *ice_repr_create_vf(struct ice_vf *vf);
+struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf);
 
 void ice_repr_destroy(struct ice_repr *repr);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 05d9e7384c5e..e90546aea729 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -126,6 +126,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	}
 	vsi->sf = dyn_port;
 
+	ice_eswitch_update_repr(&dyn_port->repr_id, vsi);
+
 	err = ice_devlink_create_sf_dev_port(sf_dev);
 	if (err) {
 		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
-- 
2.42.0


