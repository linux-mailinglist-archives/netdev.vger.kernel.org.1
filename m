Return-Path: <netdev+bounces-71084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E732851F42
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148B61F22FFD
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337064D5A0;
	Mon, 12 Feb 2024 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLwUkwqh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711D4CB4B
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772335; cv=none; b=u4IS7sldoAH+Kc221qvK2SSBlBgB4CE0mskdD8jb+w0OEo8LAVWKKAB2Wiqw0OUe3Cg1zESXprqS6xXyc11QiMvFtHa0WBQexvVLxf4bStT4IhQOTSynx4Cl+OTXPyer5jNr8+ay8kjwBWCeKU6FStftp2ulR2FSXvL9cNrFihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772335; c=relaxed/simple;
	bh=nYGmZUWdYkmPE6OjUSn3lGmyIVmsnDjIo8INXO/Z4q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CILKyV/C7xHgZIhES6cqafYXfD75CNZVBmL6C6tL2xkKAnsqtYTxPu1IQ6Ao0UfkxJQJjTdXCIwDwEI81bYTS/ugIQRVe6q2QdU83acoayh9J9sD+wWuayezU4w2tcBJEQjBINf2vEVnuOwVqoyXvaFe3Q+jplf/rMavtvCeI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLwUkwqh; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772333; x=1739308333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nYGmZUWdYkmPE6OjUSn3lGmyIVmsnDjIo8INXO/Z4q8=;
  b=GLwUkwqhc/C4ORb/MbQcIb8W/synW3D9F+XVG8jwDHXBKp261BkMHf0u
   ZDDtySlJFHPfOyZToalIUf4wxOMVUgPvifVaDj9tOg5pnf5o9hRigK8lY
   8wQ8DoMjbGuRDoPoPgL3sbKFX/UrsapiliJetUFu3QgSauy4ILmwwiQrl
   Xvtm0arKcOs505+n8Q+FmIRMalO/hH0/tufJd8q210JZwtIu9T32qj7OW
   vCK+IkUXavXVaRq7jVAtb0Er/JXszdiDhcl25DWlF8SQCcxHzmD9UTlLM
   UA/CNs1IlPGdw5Mc4XNimCQKsqMkH37s0PsIaQlIFs+aZb46T1qnkESIo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910924"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910924"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335622"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:08 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	Jiri Pirko <jiri@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Brett Creeley <brett.creeley@amd.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/5] ice: Remove and readd netdev during devlink reload
Date: Mon, 12 Feb 2024 13:11:58 -0800
Message-ID: <20240212211202.1051990-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

Recent changes to the devlink reload (commit 9b2348e2d6c9
("devlink: warn about existing entities during reload-reinit"))
force the drivers to destroy devlink ports during reinit.
Adjust ice driver to this requirement, unregister netdvice, destroy
devlink port. ice_init_eth() was removed and all the common code
between probe and reload was moved to ice_load().

During devlink reload we can't take devl_lock (it's already taken)
and in ice_probe() we have to lock it. Use devl_* variant of the API
which does not acquire and release devl_lock. Guard ice_load()
with devl_lock only in case of probe.

Suggested-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |   2 +
 drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 186 ++++++-------------
 3 files changed, 125 insertions(+), 131 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index a4ba60e17d0b..118e84835720 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -983,6 +983,8 @@ void ice_service_task_schedule(struct ice_pf *pf);
 int ice_load(struct ice_pf *pf);
 void ice_unload(struct ice_pf *pf);
 void ice_adv_lnk_speed_maps_init(void);
+int ice_init_dev(struct ice_pf *pf);
+void ice_deinit_dev(struct ice_pf *pf);
 
 /**
  * ice_set_rdma_cap - enable RDMA support
diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 65be56f2af9e..b516e42b41f0 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -444,6 +444,20 @@ ice_devlink_reload_empr_start(struct ice_pf *pf,
 	return 0;
 }
 
+/**
+ * ice_devlink_reinit_down - unload given PF
+ * @pf: pointer to the PF struct
+ */
+static void ice_devlink_reinit_down(struct ice_pf *pf)
+{
+	/* No need to take devl_lock, it's already taken by devlink API */
+	ice_unload(pf);
+	rtnl_lock();
+	ice_vsi_decfg(ice_get_main_vsi(pf));
+	rtnl_unlock();
+	ice_deinit_dev(pf);
+}
+
 /**
  * ice_devlink_reload_down - prepare for reload
  * @devlink: pointer to the devlink instance to reload
@@ -477,7 +491,7 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 					   "Remove all VFs before doing reinit\n");
 			return -EOPNOTSUPP;
 		}
-		ice_unload(pf);
+		ice_devlink_reinit_down(pf);
 		return 0;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		return ice_devlink_reload_empr_start(pf, extack);
@@ -1269,6 +1283,45 @@ static int ice_devlink_set_parent(struct devlink_rate *devlink_rate,
 	return status;
 }
 
+/**
+ * ice_devlink_reinit_up - do reinit of the given PF
+ * @pf: pointer to the PF struct
+ */
+static int ice_devlink_reinit_up(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_vsi_cfg_params params;
+	int err;
+
+	err = ice_init_dev(pf);
+	if (err)
+		return err;
+
+	params = ice_vsi_to_params(vsi);
+	params.flags = ICE_VSI_FLAG_INIT;
+
+	rtnl_lock();
+	err = ice_vsi_cfg(vsi, &params);
+	rtnl_unlock();
+	if (err)
+		goto err_vsi_cfg;
+
+	/* No need to take devl_lock, it's already taken by devlink API */
+	err = ice_load(pf);
+	if (err)
+		goto err_load;
+
+	return 0;
+
+err_load:
+	rtnl_lock();
+	ice_vsi_decfg(vsi);
+	rtnl_unlock();
+err_vsi_cfg:
+	ice_deinit_dev(pf);
+	return err;
+}
+
 /**
  * ice_devlink_reload_up - do reload up after reinit
  * @devlink: pointer to the devlink instance reloading
@@ -1289,7 +1342,7 @@ ice_devlink_reload_up(struct devlink *devlink,
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
 		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
-		return ice_load(pf);
+		return ice_devlink_reinit_up(pf);
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 		return ice_devlink_reload_empr_finish(pf, extack);
@@ -1569,6 +1622,7 @@ static const struct devlink_port_ops ice_devlink_port_ops = {
  * @pf: the PF to create a devlink port for
  *
  * Create and register a devlink_port for this PF.
+ * This function has to be called under devl_lock.
  *
  * Return: zero on success or an error code on failure.
  */
@@ -1581,6 +1635,8 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 	struct device *dev;
 	int err;
 
+	devlink = priv_to_devlink(pf);
+
 	dev = ice_pf_to_dev(pf);
 
 	devlink_port = &pf->devlink_port;
@@ -1601,10 +1657,9 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
 	ice_devlink_set_switch_id(pf, &attrs.switch_id);
 
 	devlink_port_attrs_set(devlink_port, &attrs);
-	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register_with_ops(devlink, devlink_port, vsi->idx,
-					     &ice_devlink_port_ops);
+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
+					  &ice_devlink_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for PF %d, error %d\n",
 			pf->hw.pf_id, err);
@@ -1619,10 +1674,11 @@ int ice_devlink_create_pf_port(struct ice_pf *pf)
  * @pf: the PF to cleanup
  *
  * Unregisters the devlink_port structure associated with this PF.
+ * This function has to be called under devl_lock.
  */
 void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 {
-	devlink_port_unregister(&pf->devlink_port);
+	devl_port_unregister(&pf->devlink_port);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1fa3f40743f5..85a996ad2c1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4574,90 +4574,6 @@ static void ice_decfg_netdev(struct ice_vsi *vsi)
 	vsi->netdev = NULL;
 }
 
-static int ice_start_eth(struct ice_vsi *vsi)
-{
-	int err;
-
-	err = ice_init_mac_fltr(vsi->back);
-	if (err)
-		return err;
-
-	err = ice_vsi_open(vsi);
-	if (err)
-		ice_fltr_remove_all(vsi);
-
-	return err;
-}
-
-static void ice_stop_eth(struct ice_vsi *vsi)
-{
-	ice_fltr_remove_all(vsi);
-	ice_vsi_close(vsi);
-}
-
-static int ice_init_eth(struct ice_pf *pf)
-{
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-	int err;
-
-	if (!vsi)
-		return -EINVAL;
-
-	/* init channel list */
-	INIT_LIST_HEAD(&vsi->ch_list);
-
-	err = ice_cfg_netdev(vsi);
-	if (err)
-		return err;
-	/* Setup DCB netlink interface */
-	ice_dcbnl_setup(vsi);
-
-	err = ice_init_mac_fltr(pf);
-	if (err)
-		goto err_init_mac_fltr;
-
-	err = ice_devlink_create_pf_port(pf);
-	if (err)
-		goto err_devlink_create_pf_port;
-
-	SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
-
-	err = ice_register_netdev(vsi);
-	if (err)
-		goto err_register_netdev;
-
-	err = ice_tc_indir_block_register(vsi);
-	if (err)
-		goto err_tc_indir_block_register;
-
-	ice_napi_add(vsi);
-
-	return 0;
-
-err_tc_indir_block_register:
-	ice_unregister_netdev(vsi);
-err_register_netdev:
-	ice_devlink_destroy_pf_port(pf);
-err_devlink_create_pf_port:
-err_init_mac_fltr:
-	ice_decfg_netdev(vsi);
-	return err;
-}
-
-static void ice_deinit_eth(struct ice_pf *pf)
-{
-	struct ice_vsi *vsi = ice_get_main_vsi(pf);
-
-	if (!vsi)
-		return;
-
-	ice_vsi_close(vsi);
-	ice_unregister_netdev(vsi);
-	ice_devlink_destroy_pf_port(pf);
-	ice_tc_indir_block_unregister(vsi);
-	ice_decfg_netdev(vsi);
-}
-
 /**
  * ice_wait_for_fw - wait for full FW readiness
  * @hw: pointer to the hardware structure
@@ -4683,7 +4599,7 @@ static int ice_wait_for_fw(struct ice_hw *hw, u32 timeout)
 	return -ETIMEDOUT;
 }
 
-static int ice_init_dev(struct ice_pf *pf)
+int ice_init_dev(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
@@ -4776,7 +4692,7 @@ static int ice_init_dev(struct ice_pf *pf)
 	return err;
 }
 
-static void ice_deinit_dev(struct ice_pf *pf)
+void ice_deinit_dev(struct ice_pf *pf)
 {
 	ice_free_irq_msix_misc(pf);
 	ice_deinit_pf(pf);
@@ -5081,31 +4997,47 @@ static void ice_deinit(struct ice_pf *pf)
 /**
  * ice_load - load pf by init hw and starting VSI
  * @pf: pointer to the pf instance
+ *
+ * This function has to be called under devl_lock.
  */
 int ice_load(struct ice_pf *pf)
 {
-	struct ice_vsi_cfg_params params = {};
 	struct ice_vsi *vsi;
 	int err;
 
-	err = ice_init_dev(pf);
+	devl_assert_locked(priv_to_devlink(pf));
+
+	vsi = ice_get_main_vsi(pf);
+
+	/* init channel list */
+	INIT_LIST_HEAD(&vsi->ch_list);
+
+	err = ice_cfg_netdev(vsi);
 	if (err)
 		return err;
 
-	vsi = ice_get_main_vsi(pf);
+	/* Setup DCB netlink interface */
+	ice_dcbnl_setup(vsi);
 
-	params = ice_vsi_to_params(vsi);
-	params.flags = ICE_VSI_FLAG_INIT;
+	err = ice_init_mac_fltr(pf);
+	if (err)
+		goto err_init_mac_fltr;
 
-	rtnl_lock();
-	err = ice_vsi_cfg(vsi, &params);
+	err = ice_devlink_create_pf_port(pf);
 	if (err)
-		goto err_vsi_cfg;
+		goto err_devlink_create_pf_port;
 
-	err = ice_start_eth(ice_get_main_vsi(pf));
+	SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
+
+	err = ice_register_netdev(vsi);
+	if (err)
+		goto err_register_netdev;
+
+	err = ice_tc_indir_block_register(vsi);
 	if (err)
-		goto err_start_eth;
-	rtnl_unlock();
+		goto err_tc_indir_block_register;
+
+	ice_napi_add(vsi);
 
 	err = ice_init_rdma(pf);
 	if (err)
@@ -5119,29 +5051,35 @@ int ice_load(struct ice_pf *pf)
 	return 0;
 
 err_init_rdma:
-	ice_vsi_close(ice_get_main_vsi(pf));
-	rtnl_lock();
-err_start_eth:
-	ice_vsi_decfg(ice_get_main_vsi(pf));
-err_vsi_cfg:
-	rtnl_unlock();
-	ice_deinit_dev(pf);
+	ice_tc_indir_block_unregister(vsi);
+err_tc_indir_block_register:
+	ice_unregister_netdev(vsi);
+err_register_netdev:
+	ice_devlink_destroy_pf_port(pf);
+err_devlink_create_pf_port:
+err_init_mac_fltr:
+	ice_decfg_netdev(vsi);
 	return err;
 }
 
 /**
  * ice_unload - unload pf by stopping VSI and deinit hw
  * @pf: pointer to the pf instance
+ *
+ * This function has to be called under devl_lock.
  */
 void ice_unload(struct ice_pf *pf)
 {
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+
+	devl_assert_locked(priv_to_devlink(pf));
+
 	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
-	rtnl_lock();
-	ice_stop_eth(ice_get_main_vsi(pf));
-	ice_vsi_decfg(ice_get_main_vsi(pf));
-	rtnl_unlock();
-	ice_deinit_dev(pf);
+	ice_tc_indir_block_unregister(vsi);
+	ice_unregister_netdev(vsi);
+	ice_devlink_destroy_pf_port(pf);
+	ice_decfg_netdev(vsi);
 }
 
 /**
@@ -5239,27 +5177,23 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (err)
 		goto err_init;
 
-	err = ice_init_eth(pf);
+	devl_lock(priv_to_devlink(pf));
+	err = ice_load(pf);
+	devl_unlock(priv_to_devlink(pf));
 	if (err)
-		goto err_init_eth;
-
-	err = ice_init_rdma(pf);
-	if (err)
-		goto err_init_rdma;
+		goto err_load;
 
 	err = ice_init_devlink(pf);
 	if (err)
 		goto err_init_devlink;
 
-	ice_init_features(pf);
-
 	return 0;
 
 err_init_devlink:
-	ice_deinit_rdma(pf);
-err_init_rdma:
-	ice_deinit_eth(pf);
-err_init_eth:
+	devl_lock(priv_to_devlink(pf));
+	ice_unload(pf);
+	devl_unlock(priv_to_devlink(pf));
+err_load:
 	ice_deinit(pf);
 err_init:
 	pci_disable_device(pdev);
@@ -5357,12 +5291,14 @@ static void ice_remove(struct pci_dev *pdev)
 
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
-	ice_deinit_features(pf);
+
 	ice_deinit_devlink(pf);
-	ice_deinit_rdma(pf);
-	ice_deinit_eth(pf);
-	ice_deinit(pf);
 
+	devl_lock(priv_to_devlink(pf));
+	ice_unload(pf);
+	devl_unlock(priv_to_devlink(pf));
+
+	ice_deinit(pf);
 	ice_vsi_release_all(pf);
 
 	ice_setup_mc_magic_wake(pf);
-- 
2.41.0


