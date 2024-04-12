Return-Path: <netdev+bounces-87276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBA8A2687
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 08:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2921EB2152C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 06:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2858133997;
	Fri, 12 Apr 2024 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gkj2WVvw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8326224FB
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903195; cv=none; b=irT72dc/7FUq5kzBakizBijRAY0y/KewxH6/iP03nr6eJHRbPurbGR9ZKhBGgegDMFTewE4JtvOma+HjHgl993kiaCfizulspm4xkYdtqGw9KUV8G14rhiUgTlgNBHPgfRI7TSwKUsFbUYhYblxRbh38cuk0VIQHdPutLMccJFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903195; c=relaxed/simple;
	bh=TKj2Ou2ERROaLFEcrAJSaUo0s5nPeDHY8uq4dUy4D+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbWINCZ9UGoMWKy4MSofT5JlCpbntr5EVD2OhoQUQQwZR28E297mzmOTxK6S/ZOJzGg6vLg2DdhNYCjHwf/6QqIRU7Zj0ZXtA2AM/08CStsTChMNoIXoIFsgkWt7AlMO6O1jnkCkxkR6jlH4mk0RJ8PatP7fVmfy8pOySSntsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gkj2WVvw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712903193; x=1744439193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKj2Ou2ERROaLFEcrAJSaUo0s5nPeDHY8uq4dUy4D+U=;
  b=Gkj2WVvwy3zlXb0vNPa9PAYtNCJRPIxNDzqWcEzLdVpKrqdefDHE+k4T
   Ze020ogKid+vsqWjVrfh2t8bp9JSX76IIay6Po35vxiqj1x7+qrxdEs0r
   azBcZQQlBo5jzJ943IqC5os1KJLyPiIMat5Zy5tpEystI2b/h88v5ZE80
   RPu8D4oRtv0qY3CXTmXdV8s/errtUxjGTAzRHZONNtVdX5qJy1+KGBOMg
   OEjW8MwErJfvs6JZRJYbkkshCT0IxuQQi7pvtcyvKaYTg2yvD8taMaI6C
   QF/oCjH0VuCPDBN0mBzPKmxxYjx05y0PGVngqcGCnnlrrnN3D5FxEMYyE
   Q==;
X-CSE-ConnectionGUID: 6tz1RsxKSeqfkmhsZ53Fog==
X-CSE-MsgGUID: vJ5bqF8vTfScpk6ab1uYzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18952975"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18952975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 23:26:32 -0700
X-CSE-ConnectionGUID: VDki5NyXT7SsKrbOuBteuA==
X-CSE-MsgGUID: RF2nBiB4Sf6nQ1sXJe+UgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21105132"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 11 Apr 2024 23:26:30 -0700
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
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v3 7/7] ice: allow to activate and deactivate subfunction
Date: Fri, 12 Apr 2024 08:30:53 +0200
Message-ID: <20240412063053.339795-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
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
 .../ethernet/intel/ice/devlink/devlink_port.c |   7 ++
 .../ethernet/intel/ice/devlink/devlink_port.h |   5 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 104 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
 4 files changed, 119 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 1b933083f551..ea5148c4b7e1 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -496,6 +496,12 @@ static int
 ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
 			  struct netlink_ext_ack *extack)
 {
+	int err;
+
+	err = ice_sf_eth_activate(dyn_port, extack);
+	if (err)
+		return err;
+
 	dyn_port->active = true;
 
 	return 0;
@@ -509,6 +515,7 @@ ice_activate_dynamic_port(struct ice_dynamic_port *dyn_port,
  */
 static void ice_deactivate_dynamic_port(struct ice_dynamic_port *dyn_port)
 {
+	ice_sf_eth_deactivate(dyn_port);
 	dyn_port->active = false;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
index 1f66705e0261..91d0dcb9c8cf 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -14,6 +14,7 @@
  * @devlink_port: the associated devlink port structure
  * @pf: pointer to the PF private structure
  * @vsi: the VSI associated with this port
+ * @sf_dev: pointer to the subfunction device
  *
  * An instance of a dynamically added devlink port. Each port flavour
  */
@@ -23,6 +24,10 @@ struct ice_dynamic_port {
 	struct devlink_port devlink_port;
 	struct ice_pf *pf;
 	struct ice_vsi *vsi;
+	/* Flavour-specific implementation data */
+	union {
+		struct ice_sf_dev *sf_dev;
+	};
 };
 
 void ice_dealloc_all_dynamic_ports(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 2b69dd5facf9..3f088ce38fe5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -192,6 +192,8 @@ static struct auxiliary_driver ice_sf_driver = {
 	.id_table = ice_sf_dev_id_table
 };
 
+static DEFINE_XARRAY_ALLOC1(ice_sf_aux_id);
+
 /**
  * ice_sf_driver_register - Register new auxiliary subfunction driver
  *
@@ -211,3 +213,105 @@ void ice_sf_driver_unregister(void)
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


