Return-Path: <netdev+bounces-126106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815E96FE05
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7581F21951
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1C15E5B7;
	Fri,  6 Sep 2024 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIPrcRnj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFE15CD60
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661823; cv=none; b=eMiHHVmX3LTBHCnXT4ZfJmwvjPcgGvp86zvF+Heb7cRDED5+7H6nbHAHriy5XnRsNK3uj6j9lh5I3Iwbb50MQ7l38EksM+0wYXww3QR9kmt8GY+jeDrpbVy9LCVzZHTdJAl9ZlRFQNbV8I0cbJF/kgV+zYuyftF1c1YmF4lBm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661823; c=relaxed/simple;
	bh=vhKZQwsxMbsn0potCkvaOGK0m5OJV9oSm79A9p7HQbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh0au3nBrUU9QaTODQeAHmd39KL+IP8AllEXYXIKLXNQqZ4Hyd7Lrjq9RAHcmHryUxQPyNfiy3GEMoGlpTMKPoMC1w8H1tE7W9GoSbN6fAl2TnVA80h+BxIMMjuWEBxWFbGxHPAyr7Ge/AuH0AwcLNaaeWC1OfSmdhcl2OA+evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIPrcRnj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661822; x=1757197822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vhKZQwsxMbsn0potCkvaOGK0m5OJV9oSm79A9p7HQbQ=;
  b=TIPrcRnjfmqYQbA61InfXakPn8qgBs1u6by3F40gInJOaYNKJjadcHyl
   7bV9C6bWsOHCGq/e9uAc1geoiOebJeHuOAOhjlVgQSBSPIlQC/cxIsCvQ
   cRezwmWxPIJ4lDCyVoRbJXDxwtz7PZAlU2jq8AjUDcR/vd97Ux+mh8d5M
   a/nxZy1rw1XPfLRaQi1vUqJ6RRL1FR/BHQIszzNPiGqsjGYR0DtJIhCkT
   WAPlBhpFryH1xtOo9Lmidj8tEH7n7DkESkorOhxU7Wuv11oQ1LEaLLs92
   QFJRLgjZ4QIOtsCurGe+RNRiqIyuAuTG6j104AOSm8fFE1G3bdcStoDqT
   A==;
X-CSE-ConnectionGUID: SWJ+9BmFTPK4/oAtbLHsgQ==
X-CSE-MsgGUID: LbCPqo1ZQQ+8QDOLYAUA/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030789"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030789"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:21 -0700
X-CSE-ConnectionGUID: /UMxiZRTRDO/wakf/Prn9w==
X-CSE-MsgGUID: +gu3Pk5kQI2fKRdNahpDEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490478"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:21 -0700
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
Subject: [PATCH net-next v5 15/15] ice: subfunction activation and base devlink ops
Date: Fri,  6 Sep 2024 15:30:06 -0700
Message-ID: <20240906223010.2194591-16-anthony.l.nguyen@intel.com>
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
index c653a1f44bda..928c8bdb6649 100644
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


