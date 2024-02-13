Return-Path: <netdev+bounces-71201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B7C8529C5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A36028313F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617B817564;
	Tue, 13 Feb 2024 07:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKG/E6AY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C0179A6
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809008; cv=none; b=AvZsmyc5cphXkdbC81wWbw5l52zFrBieb0ftie+XTiNDtXL6qkgsgTW3dwdJ2k0mj659WD8PpZ9dinbVYfo9yiaWQCRk3E4EyqemB7yuj+bFYJwKWdnEhUYiDjW0NN3vAeKKjV+ZrACjUR9BpPLM0yA+10Nlolgb6b3aTWdRSTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809008; c=relaxed/simple;
	bh=FNky3ZWtWQItq8HFffPdJXMQ/RUIGkQEqldTmVoFgvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbc97ynUimJJ2y4L4u+yjt31FuA84IiKBEULR4GJGOBblO18yAsENy4Ffd+z4j+TU6q3iZ1XFpcEdTn/ABA8/6tyH1rIELImDe4Z2IvaX7L2H9ejTusP30AU5LqAGOwIg5u6MnLJPi27sS4Xa7IyQ9Trtxu1pa76qdpq/vG5obo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKG/E6AY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809006; x=1739345006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FNky3ZWtWQItq8HFffPdJXMQ/RUIGkQEqldTmVoFgvM=;
  b=aKG/E6AYhgM1YduCRhPf8wkJjT7jfL2HvH+ib9YdG6wPdsGUVow//RTN
   ilVybrHNYNfUH7OcuBjVu0WqwKBMiedSA5ZB/XbSvCkXQYPmn+ypFgyPy
   M9vhgLtJ9E5ELdqtV9tSlb8z9d5FHuAS0LvxwVBoJ/DatuniIvKA9W3p2
   5jDOxV1E2NxiYAkbzNdUx/N96zCJVg8VxNjnTGqcrCm//VzbbFT15xwR/
   udcrg1ZO8doCI7CXNV5gD2mGJR0tCnSnoz4gL04TQDE05F2d4nRvL3Lpu
   nCIu97uyWkHtAVExPsAaX45IR9qutqCL87W4ciUMwgJ9Mf5hxSOczvD5y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247958"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247958"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385277"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:22 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 06/15] ice: add subfunction aux driver support
Date: Tue, 13 Feb 2024 08:27:15 +0100
Message-ID: <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Raczynski <piotr.raczynski@intel.com>

Instead of only registering devlink port by the ice driver itself,
let PF driver only register port representor for a given subfunction.
Then, aux driver is supposed to register its own devlink instance and
register virtual devlink port.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
 .../intel/ice/devlink/ice_devlink_port.h      |   6 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
 drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
 7 files changed, 302 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.c
index 90efceaddb02..33f290fed3d8 100644
--- a/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.c
@@ -434,6 +434,48 @@ void ice_devlink_destroy_vf_port(struct ice_vf *vf)
 	devlink_port_unregister(&vf->devlink_port);
 }
 
+/**
+ * ice_devlink_create_sf_dev_port - Register virtual port for a subfunction
+ * @sf_dev: the subfunction device to create a devlink port for
+ *
+ * Register virtual flavour devlink port for the subfunction auxiliary device
+ * created after activating a dynamically added devlink port.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev)
+{
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	struct ice_dynamic_port *dyn_port;
+	struct devlink *devlink;
+	struct ice_vsi *vsi;
+	struct device *dev;
+	struct ice_pf *pf;
+	int err;
+
+	dyn_port = sf_dev->dyn_port;
+	vsi = dyn_port->vsi;
+	pf = dyn_port->pf;
+	dev = ice_pf_to_dev(pf);
+
+	devlink_port = &sf_dev->priv->devlink_port;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+	devlink = priv_to_devlink(sf_dev->priv);
+
+	devl_lock(devlink);
+	err = devl_port_register(devlink, devlink_port, vsi->idx);
+	if (err)
+		dev_err(dev, "Failed to create virtual devlink port for auxiliary subfunction device %d",
+			vsi->idx);
+	devl_unlock(devlink);
+
+	return err;
+}
+
 /**
  * ice_activate_dynamic_port - Activate a dynamic port
  * @dyn_port: dynamic port instance to activate
@@ -731,13 +773,15 @@ ice_devlink_port_fn_state_get(struct devlink_port *port,
 
 	dyn_port = ice_devlink_port_to_dyn(port);
 
-	if (dyn_port->active) {
+	if (dyn_port->active)
 		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
-		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
-	} else {
+	else
 		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
+
+	if (dyn_port->sf_dev && dyn_port->sf_dev->adev.dev.driver)
+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+	else
 		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
-	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.h
index 2bb203c1713f..96d57ed54d7f 100644
--- a/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/ice_devlink_port.h
@@ -13,6 +13,7 @@
  * @devlink_port: the associated devlink port structure
  * @pf: pointer to the PF private structure
  * @vsi: the VSI associated with this port
+ * @sf_dev: dynamic port device private data
  *
  * An instance of a dynamically added devlink port. Each port flavour
  */
@@ -22,6 +23,10 @@ struct ice_dynamic_port {
 	struct devlink_port devlink_port;
 	struct ice_pf *pf;
 	struct ice_vsi *vsi;
+	/* Flavour-specific implementation data */
+	union {
+		struct ice_sf_dev *sf_dev;
+	};
 };
 
 void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
@@ -30,6 +35,7 @@ int ice_devlink_create_pf_port(struct ice_pf *pf);
 void ice_devlink_destroy_pf_port(struct ice_pf *pf);
 int ice_devlink_create_vf_port(struct ice_vf *vf);
 void ice_devlink_destroy_vf_port(struct ice_vf *vf);
+int ice_devlink_create_sf_dev_port(struct ice_sf_dev *sf_dev);
 
 #define ice_devlink_port_to_dyn(p) \
 	container_of(port, struct ice_dynamic_port, devlink_port)
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index c186e793153d..6278ff3eb7c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1382,18 +1382,21 @@ static void ice_devlink_free(void *devlink_ptr)
 }
 
 /**
- * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * ice_devlink_alloc - Allocate devlink and return devlink priv pointer
  * @dev: the device to allocate for
+ * @priv_size: size of the priv memory
+ * @ops: pointer to devlink ops for this device
  *
- * Allocate a devlink instance for this device and return the private area as
- * the PF structure. The devlink memory is kept track of through devres by
- * adding an action to remove it when unwinding.
+ * Allocate a devlink instance for this device and return the private pointer
+ * The devlink memory is kept track of through devres by adding an action to
+ * remove it when unwinding.
  */
-struct ice_pf *ice_allocate_pf(struct device *dev)
+void *ice_devlink_alloc(struct device *dev, size_t priv_size,
+			const struct devlink_ops *ops)
 {
 	struct devlink *devlink;
 
-	devlink = devlink_alloc(&ice_devlink_ops, sizeof(struct ice_pf), dev);
+	devlink = devlink_alloc(ops, priv_size, dev);
 	if (!devlink)
 		return NULL;
 
@@ -1404,6 +1407,19 @@ struct ice_pf *ice_allocate_pf(struct device *dev)
 	return devlink_priv(devlink);
 }
 
+/**
+ * ice_allocate_pf - Allocate devlink and return PF structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for this device and return the private area as
+ * the PF structure. The devlink memory is kept track of through devres by
+ * adding an action to remove it when unwinding.
+ */
+struct ice_pf *ice_allocate_pf(struct device *dev)
+{
+	return ice_devlink_alloc(dev, sizeof(struct ice_pf), &ice_devlink_ops);
+}
+
 /**
  * ice_devlink_register - Register devlink interface for this PF
  * @pf: the PF to register the devlink for.
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.h b/drivers/net/ethernet/intel/ice/ice_devlink.h
index d291c0e2e17b..4f4a7254bcc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.h
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.h
@@ -5,6 +5,9 @@
 #define _ICE_DEVLINK_H_
 
 struct ice_pf *ice_allocate_pf(struct device *dev);
+void *
+ice_devlink_alloc(struct device *dev, size_t priv_size,
+		  const struct devlink_ops *ops);
 
 void ice_devlink_register(struct ice_pf *pf);
 void ice_devlink_unregister(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e4269a7df7d6..7ff96da33e8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5750,8 +5750,16 @@ static int __init ice_module_init(void)
 		goto err_dest_lag_wq;
 	}
 
+	status = ice_sf_driver_register();
+	if (status) {
+		pr_err("failed to register SF driver, err %d\n", status);
+		goto err_sf_driver;
+	}
+
 	return 0;
 
+err_sf_driver:
+	pci_unregister_driver(&ice_driver);
 err_dest_lag_wq:
 	destroy_workqueue(ice_lag_wq);
 	ice_debugfs_exit();
@@ -5769,6 +5777,7 @@ module_init(ice_module_init);
  */
 static void __exit ice_module_exit(void)
 {
+	ice_sf_driver_unregister();
 	pci_unregister_driver(&ice_driver);
 	ice_debugfs_exit();
 	destroy_workqueue(ice_wq);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index f45ac76f0f43..ab90db52a8fc 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -6,6 +6,7 @@
 #include "ice_txrx.h"
 #include "ice_fltr.h"
 #include "ice_sf_eth.h"
+#include "ice_devlink.h"
 #include "devlink/ice_devlink_port.h"
 
 static const struct net_device_ops ice_sf_netdev_ops = {
@@ -24,15 +25,16 @@ static const struct net_device_ops ice_sf_netdev_ops = {
 
 /**
  * ice_sf_cfg_netdev - Allocate, configure and register a netdev
- * @dyn_port: subfunction associated with configured netdev
+ * @sf_dev: subfunction associated with configured netdev
  *
  * Returns 0 on success, negative value on failure
  */
-static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
+static int ice_sf_cfg_netdev(struct ice_sf_dev *sf_dev)
 {
-	struct net_device *netdev;
+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
 	struct ice_vsi *vsi = dyn_port->vsi;
 	struct ice_netdev_priv *np;
+	struct net_device *netdev;
 	int err;
 
 	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
@@ -40,7 +42,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
 	if (!netdev)
 		return -ENOMEM;
 
-	SET_NETDEV_DEV(netdev, &vsi->back->pdev->dev);
+	SET_NETDEV_DEV(netdev, &sf_dev->adev.dev);
 	set_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
 	vsi->netdev = netdev;
 	np = netdev_priv(netdev);
@@ -56,7 +58,7 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
 	ether_addr_copy(netdev->perm_addr, dyn_port->hw_addr);
 	netdev->netdev_ops = &ice_sf_netdev_ops;
 	ice_set_ethtool_sf_ops(netdev);
-	SET_NETDEV_DEVLINK_PORT(netdev, &dyn_port->devlink_port);
+	SET_NETDEV_DEVLINK_PORT(netdev, &sf_dev->priv->devlink_port);
 
 	err = register_netdev(netdev);
 	if (err) {
@@ -71,45 +73,70 @@ static int ice_sf_cfg_netdev(struct ice_dynamic_port *dyn_port)
 	return 0;
 }
 
+static const struct devlink_ops ice_sf_devlink_ops;
+
 /**
- * ice_sf_eth_activate - Activate Ethernet subfunction port
- * @dyn_port: the dynamic port instance for this subfunction
- * @extack: extack for reporting error messages
+ * ice_sf_dev_probe - subfunction driver probe function
+ * @adev: pointer to the auxiliary device
+ * @id: pointer to the auxiliary_device id
  *
- * Setups netdev resources and filters for a subfunction.
+ * Configure VSI and netdev resources for the subfunction device.
  *
  * Return: zero on success or an error code on failure.
  */
-int
-ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
-		    struct netlink_ext_ack *extack)
+static int ice_sf_dev_probe(struct auxiliary_device *adev,
+			    const struct auxiliary_device_id *id)
 {
+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
 	struct ice_vsi_cfg_params params = {};
 	struct ice_vsi *vsi = dyn_port->vsi;
 	struct ice_pf *pf = dyn_port->pf;
+	struct device *dev = &adev->dev;
+	struct ice_sf_priv *priv;
 	int err;
 
 	params.type = ICE_VSI_SF;
 	params.pi = pf->hw.port_info;
 	params.flags = ICE_VSI_FLAG_INIT;
 
+	priv = ice_devlink_alloc(&adev->dev, sizeof(struct ice_sf_priv),
+				 &ice_sf_devlink_ops);
+	if (!priv) {
+		dev_err(dev, "Subfunction devlink alloc failed");
+		return -ENOMEM;
+	}
+
+	priv->dev = sf_dev;
+	sf_dev->priv = priv;
+
+	devlink_register(priv_to_devlink(priv));
+
 	err = ice_vsi_cfg(vsi, &params);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Subfunction vsi config failed");
+		dev_err(dev, "Subfunction vsi config failed");
 		return err;
 	}
 
-	err = ice_sf_cfg_netdev(dyn_port);
+	err = ice_devlink_create_sf_dev_port(sf_dev);
+	if (err)
+		dev_dbg(dev, "Cannot add ice virtual devlink port for subfunction");
+
+	err = ice_sf_cfg_netdev(sf_dev);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Subfunction netdev config failed");
+		dev_err(dev, "subfunction netdev config failed");
 		goto err_vsi_decfg;
 	}
 
 	err = ice_fltr_add_mac_and_broadcast(vsi, vsi->netdev->dev_addr,
 					     ICE_FWD_TO_VSI);
+
 	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "can't add MAC filters for subfunction VSI");
+		dev_dbg(dev, "can't add MAC filters %pM for VSI %d\n",
+			vsi->netdev->dev_addr, vsi->idx);
 
+	dev_dbg(dev, "MAC %pM filter added for vsi %d\n", vsi->netdev->dev_addr,
+		vsi->idx);
 	ice_napi_add(vsi);
 
 	return err;
@@ -120,20 +147,165 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 }
 
 /**
- * ice_sf_eth_deactivate - Deactivate subfunction
- * @dyn_port: the dynamic port instance for this subfunction
+ * ice_sf_dev_remove - subfunction driver remove function
+ * @adev: pointer to the auxiliary device
  *
- * Free netdev resources and filters for a subfunction.
+ * Deinitalize VSI and netdev resources for the subfunction device.
  */
-void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port)
+static void ice_sf_dev_remove(struct auxiliary_device *adev)
 {
+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
+	struct devlink *devlink = priv_to_devlink(sf_dev->priv);
+	struct ice_dynamic_port *dyn_port = sf_dev->dyn_port;
 	struct ice_vsi *vsi = dyn_port->vsi;
 
 	ice_vsi_close(vsi);
+
 	unregister_netdev(vsi->netdev);
 	clear_bit(ICE_VSI_NETDEV_REGISTERED, vsi->state);
+	devlink_port_unregister(&sf_dev->priv->devlink_port);
 	free_netdev(vsi->netdev);
-	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
 	vsi->netdev = NULL;
+	clear_bit(ICE_VSI_NETDEV_ALLOCD, vsi->state);
+	devlink_unregister(devlink);
+	devlink_free(devlink);
 	ice_vsi_decfg(vsi);
 }
+
+static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
+	{ .name = "ice.sf", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(auxiliary, ice_sf_dev_id_table);
+
+static struct auxiliary_driver ice_sf_driver = {
+	.name = "sf",
+	.probe = ice_sf_dev_probe,
+	.remove = ice_sf_dev_remove,
+	.id_table = ice_sf_dev_id_table
+};
+
+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
+
+/**
+ * ice_sf_driver_register - Register new auxiliary subfunction driver
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_sf_driver_register(void)
+{
+	return auxiliary_driver_register(&ice_sf_driver);
+}
+
+/**
+ * ice_sf_driver_unregister - Unregister new auxiliary subfunction driver
+ *
+ * Return: zero on success or an error code on failure.
+ */
+void ice_sf_driver_unregister(void)
+{
+	auxiliary_driver_unregister(&ice_sf_driver);
+}
+
+/**
+ * ice_sf_dev_release - Release device associated with auxiliary device
+ * @device: pointer to the device
+ *
+ * Since most of the code for subfunction deactivation is handled in
+ * the remove handler, here just free tracking resources.
+ */
+static void ice_sf_dev_release(struct device *device)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(device);
+	struct ice_sf_dev *sf_dev = ice_adev_to_sf_dev(adev);
+
+	xa_erase(&ice_sf_aux_id, adev->id);
+	kfree(sf_dev);
+}
+
+/**
+ * ice_sf_eth_activate - Activate Ethernet subfunction port
+ * @dyn_port: the dynamic port instance for this subfunction
+ * @extack: extack for reporting error messages
+ *
+ * Activate the dynamic port as an Ethernet subfunction. Setup the netdev
+ * resources associated and initialize the auxiliary device.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int
+ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
+		    struct netlink_ext_ack *extack)
+{
+	struct ice_pf *pf = dyn_port->pf;
+	struct ice_sf_dev *sf_dev;
+	struct pci_dev *pdev;
+	int err;
+	u32 id;
+
+	err  = xa_alloc(&ice_sf_aux_id, &id, NULL, xa_limit_32b,
+			GFP_KERNEL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate subfunction ID");
+		return err;
+	}
+
+	sf_dev = kzalloc(sizeof(*sf_dev), GFP_KERNEL);
+	if (!sf_dev) {
+		err = -ENOMEM;
+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate sf_dev memory");
+		goto xa_erase;
+	}
+	pdev = pf->pdev;
+
+	sf_dev->dyn_port = dyn_port;
+	sf_dev->adev.id = id;
+	sf_dev->adev.name = "sf";
+	sf_dev->adev.dev.release = ice_sf_dev_release;
+	sf_dev->adev.dev.parent = &pdev->dev;
+
+	err = auxiliary_device_init(&sf_dev->adev);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to initialize auxiliary device");
+		goto sf_dev_free;
+	}
+
+	err = auxiliary_device_add(&sf_dev->adev);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Auxiliary device failed to probe");
+		goto aux_dev_uninit;
+	}
+
+	dyn_port->sf_dev = sf_dev;
+
+	return 0;
+
+aux_dev_uninit:
+	auxiliary_device_uninit(&sf_dev->adev);
+sf_dev_free:
+	kfree(sf_dev);
+xa_erase:
+	xa_erase(&ice_sf_aux_id, id);
+
+	return err;
+}
+
+/**
+ * ice_sf_eth_deactivate - Deactivate Ethernet subfunction port
+ * @dyn_port: the dynamic port instance for this subfunction
+ *
+ * Deactivate the Ethernet subfunction, removing its auxiliary device and the
+ * associated resources.
+ */
+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port)
+{
+	struct ice_sf_dev *sf_dev = dyn_port->sf_dev;
+
+	if (sf_dev) {
+		auxiliary_device_delete(&sf_dev->adev);
+		auxiliary_device_uninit(&sf_dev->adev);
+	}
+
+	dyn_port->sf_dev = NULL;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
index f4b8b36b1a67..366344c3ff90 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
@@ -4,12 +4,33 @@
 #ifndef _ICE_SF_ETH_H_
 #define _ICE_SF_ETH_H_
 
+#include <linux/auxiliary_bus.h>
 #include "ice.h"
 #include "devlink/ice_devlink_port.h"
 
+struct ice_sf_dev {
+	struct auxiliary_device adev;
+	struct ice_dynamic_port *dyn_port;
+	struct ice_sf_priv *priv;
+};
+
+struct ice_sf_priv {
+	struct ice_sf_dev *dev;
+	struct devlink_port devlink_port;
+};
+
+static inline struct
+ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
+{
+	return container_of(adev, struct ice_sf_dev, adev);
+}
+
 int
 ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 		    struct netlink_ext_ack *extack);
 void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port);
 
+int ice_sf_driver_register(void);
+void ice_sf_driver_unregister(void);
+
 #endif /* _ICE_SF_ETH_H_ */
-- 
2.42.0


