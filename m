Return-Path: <netdev+bounces-98392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420008D1370
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD2228386D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15620330;
	Tue, 28 May 2024 04:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daXzif83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21227224D5
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870835; cv=none; b=uALH2zMNV2SG0+3GWQwqzjKFtjsWbbYxPzvB4LYdEQ9exBNaPHa4pQQV4dovuOTyHOb4h/sUaFTkKqoeqT9cW+ZMxIWxN0Ml03n6P04kSSsiECAOGLODDeJHV2C9kGfWcDAPgBDgMnhIdfvI8EX3o8yb39YbPpFAV5UJbSJYaV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870835; c=relaxed/simple;
	bh=innUpET5INou4iiO2CErK6f1a6tyIPRx0ZikrJD2CV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOs2s/5zBm/24FukOYC5FAWp/e1Mykj+8d2E90txL14VQPzYS2s6gZT/m4qU4U9sgp1krp09YT7X5K6Gg3OYAWxlGo6c1nRemGasWmgHaTtQVsf2i5xjd2vdHSEUH5rW8BfZY/iRzKx4yloDfDA5kCsHVqDHf8trnrb77SVH4jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daXzif83; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870834; x=1748406834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=innUpET5INou4iiO2CErK6f1a6tyIPRx0ZikrJD2CV4=;
  b=daXzif83+WKcz0jfMK0DGIl0pHRmPfuHoCmVhtYfIBdgAkBU1ljIzf6i
   85EJI0aPAe10PwzzxsARiuRwOKu2UMjTnx+HGoIO1ZxYQzhrIaDMWbBEM
   cvoZ7LbIiTQmMMWEzsUtfM6DHg9M+V+erJNnewXH7R7h/3kBrRIt4wiKD
   2K+dnNIerJLCH5yqBs0sK1Q9B45Nt+rWkvqn5GKYXO3fUSrRXW0ZkQY7X
   RFGluZNiqhlp8WDAx4vyKCSyckbZ0ImYn0W+rEepLNFbGE/enDaSOtCRy
   U+ybOznhxuc1hplUQmgxo8gTmDAV/evS9dU2AkvPxd0DhXP3r7nDq8WQ2
   w==;
X-CSE-ConnectionGUID: PbcATTCLQ1yNiIoMvHOxGA==
X-CSE-MsgGUID: avziR30tRpyx7gk3K+jckA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020166"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020166"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:54 -0700
X-CSE-ConnectionGUID: JbszNQMrTGOiGAcZiyeqLw==
X-CSE-MsgGUID: 9S9Faa0FTLauKQBDckmyoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152448"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:51 -0700
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
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [iwl-next v3 15/15] ice: allow to activate and deactivate subfunction
Date: Tue, 28 May 2024 06:38:13 +0200
Message-ID: <20240528043813.1342483-16-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
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

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c | 173 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |   7 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 107 +++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
 4 files changed, 290 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 4cfd90581d92..4abdc40d345e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -530,6 +530,42 @@ void ice_devlink_destroy_sf_dev_port(struct ice_sf_dev *sf_dev)
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
+	ice_sf_eth_deactivate(dyn_port);
+	dyn_port->active = false;
+}
+
 /**
  * ice_dealloc_dynamic_port - Deallocate and remove a dynamic port
  * @dyn_port: dynamic port instance to deallocate
@@ -542,6 +578,9 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 	struct devlink_port *devlink_port = &dyn_port->devlink_port;
 	struct ice_pf *pf = dyn_port->pf;
 
+	if (dyn_port->active)
+		ice_deactivate_dynamic_port(dyn_port);
+
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
 	ice_vsi_free(dyn_port->vsi);
@@ -629,8 +668,142 @@ ice_devlink_port_del(struct devlink *devlink, struct devlink_port *port,
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
+		if (!dyn_port->active)
+			return ice_activate_dynamic_port(dyn_port, extack);
+		break;
+	case DEVLINK_PORT_FN_STATE_INACTIVE:
+		if (dyn_port->active)
+			ice_deactivate_dynamic_port(dyn_port);
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
index 3a540a2638d1..73bb9c5d273d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -147,6 +147,7 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	devl_unlock(devlink);
 
 	devlink_register(devlink);
+	dyn_port->attached = true;
 
 	return 0;
 
@@ -186,6 +187,8 @@ static void ice_sf_dev_remove(struct auxiliary_device *adev)
 	devl_unlock(devlink);
 	devlink_free(devlink);
 	ice_vsi_decfg(vsi);
+
+	dyn_port->attached = false;
 }
 
 static const struct auxiliary_device_id ice_sf_dev_id_table[] = {
@@ -202,6 +205,8 @@ static struct auxiliary_driver ice_sf_driver = {
 	.id_table = ice_sf_dev_id_table
 };
 
+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
+
 /**
  * ice_sf_driver_register - Register new auxiliary subfunction driver
  *
@@ -220,3 +225,105 @@ void ice_sf_driver_unregister(void)
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
+		NL_SET_ERR_MSG_MOD(extack, "Failed to add SF aux device");
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


