Return-Path: <netdev+bounces-114706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6019438A6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8303C1C21BB4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B916DC35;
	Wed, 31 Jul 2024 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nr4Y4KiK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989D16DC1A
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463854; cv=none; b=g6ruK5NJYG7psOfvc98mmmMOo9V7OYSA4KsqDpTAs0KpTf7wdKxU/p6IeAUFTC3R4DLcRZk4Up6a4BIC7Yzq5GzNhKOvHkV4rNZo1NQdECR0lZYfAkTO/ngq3fhoOkD5oyLQh8mcogbEgz2lA0wWuJa8huA1iCQheyYIU8lXRWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463854; c=relaxed/simple;
	bh=Ml7k7pl1KLsibY6sLHS7kFirkZmteGqQNP/xW9TlVbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVmeNJSwCgGeJVg9cIxKO0XbNcD0fXBhyGHNXWBQaXnNt0bR7JUSOvnO9/32ZDhsOYa0znU8i38g6i1y/6SPFuSc6zIyjaDf0mVGvepezQPwAZaSQdg9Tkca/mnBHOLl0wGFRtHD/ypb821UjJnTcgFEKQyta+2w7Pr6uC0s+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nr4Y4KiK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463853; x=1753999853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ml7k7pl1KLsibY6sLHS7kFirkZmteGqQNP/xW9TlVbg=;
  b=nr4Y4KiK7urvHvrMA1RM2z6+0M5cwAyGXB3tMrqLZUxNdEOozuRKZF9b
   UsCKyWOzsW7kmpBCSvc69pGfCBXiiYTIVdGnH3AD5W3QKDAWY50Z3C6NU
   Ev76WC3M2P/fXdItQtYFdghkmp9C6tX441ZOk2mrsPDKsXNE0LW1JGIzQ
   7A3S0BlcR+lvOOWkYbNGvmoNzoImm4q4iA+8YZEqu52OmYatLFr5TYPCI
   RvEoyM8vceF8qdQNhCaoyC0Z/HGtnJPdiPNdYlYefzJd04GlV6StCkGpq
   Qs24AY1co/pC9gp4ll2XYE7mEEmmL/tDwXDnXJxRmyV49iNgMvG1+tQQJ
   Q==;
X-CSE-ConnectionGUID: Wib8QrJbQN21Ii2yx9V6cQ==
X-CSE-MsgGUID: 6+71rf9BTauE6WO6kvh4xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765539"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765539"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:46 -0700
X-CSE-ConnectionGUID: IxP6s9KPQrStcb05rwRKtQ==
X-CSE-MsgGUID: 3u/zle0TRV+QBCKDuDCbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734155"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
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
Subject: [PATCH net-next v2 09/15] ice: create port representor for SF
Date: Wed, 31 Jul 2024 15:10:20 -0700
Message-ID: <20240731221028.965449-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
References: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
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
index f06baabd0112..fb3ff68e0666 100644
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
index 3a540a2638d1..c901c07da1d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -125,6 +125,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	}
 	vsi->sf = dyn_port;
 
+	ice_eswitch_update_repr(&dyn_port->repr_id, vsi);
+
 	err = ice_devlink_create_sf_dev_port(sf_dev);
 	if (err) {
 		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
-- 
2.42.0


