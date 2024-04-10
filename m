Return-Path: <netdev+bounces-86397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70C289E964
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630EE281E56
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 05:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7C811713;
	Wed, 10 Apr 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMB/RZe7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AE19BA6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712725441; cv=none; b=anR0K+62znZDsS6woz2GiuMh/QtH7ABBXYv1fEv15oW+/7xa1zBz9JDki61WCiRWfc61eEtfMCKqdS8NHO5EcH14iOtTFaIhXjGWgCRTkdgu+/+U1VPMhO5nTMQTBOYzVA6TF1LIyOkbG8jQbqMB9x3PNb6l5ShX8fZhfTnKJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712725441; c=relaxed/simple;
	bh=CkcW/YjfhCPgg04syOFhR5zDaiTzoiJcr7bqXK/RTZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQpCjfaT46JjPk4jEOKEPFhPwy21BOFJ+Z17eMU1PJOmen28JgxJ9ab/lJFQjh0QJIeOyux1cHHpCWiFn4SpIG0NOC4j8Na1nXmuOXLcCkHSzKwbrl2YRM2LZcfhmM/Ac5i4lidkspPGGLRLdG+tW8uhtf1LRcDnHFr+AQVUzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMB/RZe7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712725440; x=1744261440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CkcW/YjfhCPgg04syOFhR5zDaiTzoiJcr7bqXK/RTZw=;
  b=VMB/RZe7DpRlGBqgis3UK67qtnhy86VGXp9UEdNIuiOC2PdUfCN2a1OL
   FkNtoNAm3N2kXAboDS0HW4PDrb2KJPGk8vCR10zLtjzjBjht0nVWyZYlU
   QgreVkrWmo1VGmkOp9flYCW9B7rx2jYk1+JclrGcEn8HITAtrAqCGlfgj
   Vtd5OxGWAEqtdI/fXJEEt/qQJ5kcN23C4DX055Tk+ydO+d+62z2RgzgoS
   akw7s4rTdRhoM8Zd9P7s1bMk6HSN+hrsNwcKlADiMUHGMQAxO04FAymjO
   oJvxtCunXIRGMVr2fymK9HJVVWq5rG7x3DseXLAjn04iUG3WVG8PnjWan
   Q==;
X-CSE-ConnectionGUID: QntEDDZDQ72bOlWdVaiGUg==
X-CSE-MsgGUID: 5o2Qx3iSQiiJ5dZU8IDzyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19456235"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19456235"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:03:59 -0700
X-CSE-ConnectionGUID: VRVqe5FZTjO+yleYT2KPxA==
X-CSE-MsgGUID: ktkEolvRTlSIpRPfmclMjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="57876042"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2024 22:03:57 -0700
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
Subject: [iwl-next v2 7/7] ice: allow to activate and deactivate subfunction
Date: Wed, 10 Apr 2024 07:08:09 +0200
Message-ID: <20240410050809.125043-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240410050809.125043-1-michal.swiatkowski@linux.intel.com>
References: <20240410050809.125043-1-michal.swiatkowski@linux.intel.com>
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
 .../ethernet/intel/ice/devlink/devlink_port.h |   4 +
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 104 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |   3 +
 4 files changed, 118 insertions(+)

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
index 1f66705e0261..409bf291a781 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
@@ -23,6 +23,10 @@ struct ice_dynamic_port {
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
index 8f0e3c5f3ea4..1583a7e7e3b3 100644
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


