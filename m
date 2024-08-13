Return-Path: <netdev+bounces-118214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFAB950F57
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29656B23D24
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABB31AD408;
	Tue, 13 Aug 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLZDiekb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97A1AD3E0
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585829; cv=none; b=ABvawcF871xT9uU4ypXjYZPdGlIRABpwt3Ppz7S1R6HJmxi0wTWE/nEO5D7m2inf3yBIfaMvebx/YSjWKTDck1MhQcViSoh5CjXNYRmH8KT/n9DRxIXBk9CHx/cTBEfkxuZN+IDW6Uv0PuzoSo5cKjc1bYQr6ay7B8yuM0uBYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585829; c=relaxed/simple;
	bh=XcfYyP8OK6HtkoNNPJXjGGNkFqc9bMW9rqj6vXqwrbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtrC34GV7exB8yyPxKaro/HSTXQvkgktiaU6/Hfk1W/pUC37mqYj1olYq5P7C9WsdaZfN5pAsk0zZuCW4HtcVWKxjlQJHt6iXrKdcWX71oqca0Ex4eC8bnGN8/cawngeaozPaeZuWBtwKVMwj7+KMTn3vxOeQe715asBLMXJKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLZDiekb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585827; x=1755121827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XcfYyP8OK6HtkoNNPJXjGGNkFqc9bMW9rqj6vXqwrbo=;
  b=bLZDiekbk8lsgNnLkaFD2rprVEnkBmKfirAMba6/yVs2LhKCZ2RhP7xN
   ORBw+IpPq9zx5G9N7RQasMdMECBT6GoFLxfUO3pNH9JmDbo3RRLKJB3bp
   F0OBVD6wGvWpQxXkI9iEfkfuKip1wwfYLjPNKSpVOw3YiY6TXfi1Agr/o
   7FLOVBIOF677FmUkXIobWwhud5IBKwLAwDMpTIBYEX+gWfMp9yXAFBoZA
   z7nqYb1B0QzBIS7n6g7V4U+FmgEGPcSlvnk5CBvb64a1mX/3c+B2EPMsu
   HfYomn+UqSmtAaYUPvCnk/U4DXAfBn6QwdpqGCOLokbl4F3ToS3wwxHDf
   g==;
X-CSE-ConnectionGUID: bQb/Xt/DSMC4kmagGWpHug==
X-CSE-MsgGUID: 9v9NJpJ3QquI1YQU2vz66g==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748218"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748218"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:09 -0700
X-CSE-ConnectionGUID: 08pg/Fa+Qu2EednVZJrBQA==
X-CSE-MsgGUID: A9kWzYYcR02NeB12Ig+7yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685600"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:09 -0700
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
Subject: [PATCH net-next v4 15/15] ice: subfunction activation and base devlink ops
Date: Tue, 13 Aug 2024 14:50:04 -0700
Message-ID: <20240813215005.3647350-16-anthony.l.nguyen@intel.com>
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

From: Piotr Raczynski <piotr.raczynski@intel.com>

Use previously implemented SF aux driver. It is probe during SF
activation and remove after deactivation.

Implement set/get hw_address and set/get state as basic devlink ops for
subfunction.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c | 176 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |   7 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 104 +++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
 4 files changed, 290 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index d6a74b623773..ce57909dda59 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -530,6 +530,48 @@ void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
 	devl_port_unregister(&sf_dev->priv->devlink_port);
 }
 
+/**
+ * ice_activate_dynamic_port - Activate a dynamic port
+ * @dyn_port: dynamic port instance to activate
+ * @extack: extack for reporting error messages
+ *
+ * Activate the dynamic port based on its flavour.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
+			  struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (dyn_port->active)
+		return 0;
+
+	err = ice_sf_eth_activate(dyn_port, extack);
+	if (err)
+		return err;
+
+	dyn_port->active = true;
+
+	return 0;
+}
+
+/**
+ * ice_deactivate_dynamic_port - Deactivate a dynamic port
+ * @dyn_port: dynamic port instance to deactivate
+ *
+ * Undo activation of a dynamic port.
+ */
+static void ice_deactivate_dynamic_port(struct ice_dynamic_port *dyn_port)
+{
+	if (!dyn_port->active)
+		return;
+
+	ice_sf_eth_deactivate(dyn_port);
+	dyn_port->active = false;
+}
+
 /**
  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
  * @dyn_port: dynamic port instance to deallocate
@@ -542,6 +584,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 	struct devlink_port *devlink_port = &dyn_port->devlink_port;
 	struct ice_pf *pf = dyn_port->pf;
 
+	ice_deactivate_dynamic_port(dyn_port);
+
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
 	ice_vsi_free(dyn_port->vsi);
@@ -629,8 +673,140 @@ ice_devlink_port_del(struct devlink *devlink, struct devlink_port *port,
 	return 0;
 }
 
+/**
+ * ice_devlink_port_fn_hw_addr_set - devlink handler for mac address set
+ * @port: pointer to devlink port
+ * @hw_addr: hw address to set
+ * @hw_addr_len: hw address length
+ * @extack: extack for reporting error messages
+ *
+ * Sets mac address for the port, verifies arguments and copies address
+ * to the subfunction structure.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_fn_hw_addr_set(struct devlink_port *port, const u8 *hw_addr,
+				int hw_addr_len,
+				struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port;
+
+	dyn_port = ice_devlink_port_to_dyn(port);
+
+	if (dyn_port->attached) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Ethernet address can be change only in detached state");
+		return -EBUSY;
+	}
+
+	if (hw_addr_len != ETH_ALEN || !is_valid_ether_addr(hw_addr)) {
+		NL_SET_ERR_MSG_MOD(extack, "Invalid ethernet address");
+		return -EADDRNOTAVAIL;
+	}
+
+	ether_addr_copy(dyn_port->hw_addr, hw_addr);
+
+	return 0;
+}
+
+/**
+ * ice_devlink_port_fn_hw_addr_get - devlink handler for mac address get
+ * @port: pointer to devlink port
+ * @hw_addr: hw address to set
+ * @hw_addr_len: hw address length
+ * @extack: extack for reporting error messages
+ *
+ * Returns mac address for the port.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_fn_hw_addr_get(struct devlink_port *port, u8 *hw_addr,
+				int *hw_addr_len,
+				struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port;
+
+	dyn_port = ice_devlink_port_to_dyn(port);
+
+	ether_addr_copy(hw_addr, dyn_port->hw_addr);
+	*hw_addr_len = ETH_ALEN;
+
+	return 0;
+}
+
+/**
+ * ice_devlink_port_fn_state_set - devlink handler for port state set
+ * @port: pointer to devlink port
+ * @state: state to set
+ * @extack: extack for reporting error messages
+ *
+ * Activates or deactivates the port.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_fn_state_set(struct devlink_port *port,
+			      enum devlink_port_fn_state state,
+			      struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port;
+
+	dyn_port = ice_devlink_port_to_dyn(port);
+
+	switch (state) {
+	case DEVLINK_PORT_FN_STATE_ACTIVE:
+		return ice_activate_dynamic_port(dyn_port, extack);
+
+	case DEVLINK_PORT_FN_STATE_INACTIVE:
+		ice_deactivate_dynamic_port(dyn_port);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * ice_devlink_port_fn_state_get - devlink handler for port state get
+ * @port: pointer to devlink port
+ * @state: admin configured state of the port
+ * @opstate: current port operational state
+ * @extack: extack for reporting error messages
+ *
+ * Gets port state.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int
+ice_devlink_port_fn_state_get(struct devlink_port *port,
+			      enum devlink_port_fn_state *state,
+			      enum devlink_port_fn_opstate *opstate,
+			      struct netlink_ext_ack *extack)
+{
+	struct ice_dynamic_port *dyn_port;
+
+	dyn_port = ice_devlink_port_to_dyn(port);
+
+	if (dyn_port->active)
+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
+	else
+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
+
+	if (dyn_port->attached)
+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
+	else
+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
+
+	return 0;
+}
+
 static const struct devlink_port_ops ice_devlink_port_sf_ops = {
 	.port_del = ice_devlink_port_del,
+	.port_fn_hw_addr_get = ice_devlink_port_fn_hw_addr_get,
+	.port_fn_hw_addr_set = ice_devlink_port_fn_hw_addr_set,
+	.port_fn_state_get = ice_devlink_port_fn_state_get,
+	.port_fn_state_set = ice_devlink_port_fn_state_set,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 479d2b976745..d60efc340945 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -11,22 +11,29 @@
  * struct ice_dynamic_port - Track dynamically added devlink port instance
  * @hw_addr: the HW address for this port
  * @active: true if the port has been activated
+ * @attached: true it the prot is attached
  * @devlink_port: the associated devlink port structure
  * @pf: pointer to the PF private structure
  * @vsi: the VSI associated with this port
  * @repr_id: the representor ID
  * @sfnum: the subfunction ID
+ * @sf_dev: pointer to the subfunction device
  *
  * An instance of a dynamically added devlink port. Each port flavour
  */
 struct ice_dynamic_port {
 	u8 hw_addr[ETH_ALEN];
 	u8 active: 1;
+	u8 attached: 1;
 	struct devlink_port devlink_port;
 	struct ice_pf *pf;
 	struct ice_vsi *vsi;
 	unsigned long repr_id;
 	u32 sfnum;
+	/* Flavour-specific implementation data */
+	union {
+		struct ice_sf_dev *sf_dev;
+	};
 };
 
 void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index e90546aea729..d00389c405c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -151,6 +151,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	devl_register(devlink);
 	devl_unlock(devlink);
 
+	dyn_port->attached = true;
+
 	return 0;
 
 err_netdev_decfg:
@@ -189,6 +191,8 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
 	devl_unlock(devlink);
 	devlink_free(devlink);
 	ice_vsi_decfg(vsi);
+
+	dyn_port->attached = false;
 }
 
 static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
@@ -205,6 +209,8 @@ static struct auxiliary_driver ice_sf_driver = {
 	.id_table = ice_sf_dev_id_table
 };
 
+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
+
 /**
  * ice_sf_driver_register - Register new auxiliary subfunction driver
  *
@@ -223,3 +229,101 @@ void ice_sf_driver_unregister(void)
 {
 	auxiliary_driver_unregister(&ice_sf_driver);
 }
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
+	err = xa_alloc(&ice_sf_aux_id, &id, NULL, xa_limit_32b,
+		       GFP_KERNEL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF ID");
+		return err;
+	}
+
+	sf_dev = kzalloc(sizeof(*sf_dev), GFP_KERNEL);
+	if (!sf_dev) {
+		err = -ENOMEM;
+		NL_SET_ERR_MSG_MOD(extack, "Could not allocate SF memory");
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
+		NL_SET_ERR_MSG_MOD(extack, "Failed to initialize SF device");
+		goto sf_dev_free;
+	}
+
+	err = auxiliary_device_add(&sf_dev->adev);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to add SF device");
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
+	auxiliary_device_delete(&sf_dev->adev);
+	auxiliary_device_uninit(&sf_dev->adev);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.h b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
index e972c50f96c9..c558cad0a183 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.h
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.h
@@ -27,4 +27,7 @@ ice_sf_dev *ice_adev_to_sf_dev(struct auxiliary_device *adev)
 int ice_sf_driver_register(void);
 void ice_sf_driver_unregister(void);
 
+int ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
+			struct netlink_ext_ack *extack);
+void ice_sf_eth_deactivate(struct ice_dynamic_port *dyn_port);
 #endif /* _ICE_SF_ETH_H_ */
-- 
2.42.0


