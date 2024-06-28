Return-Path: <netdev+bounces-107820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3491C72B
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C601C25204
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213E139D12;
	Fri, 28 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CeeB14nc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4DB7711F
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605625; cv=none; b=H6C8C90dtW7Gzw7DBvQ6ZiNpQsLspDxKIA41mrAbjhN7rwqHmfzJ9zgj9W8PcQZLdRzTgFU8cg4rkTjZyVZZjL0gEk22AZig22ubgeYzf44okMuFhzw73dCWWQKYoHHABNuA5mXzD89ZE/WXdIwrHoBz2Zrq3NLOb9jMrpyF1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605625; c=relaxed/simple;
	bh=6q4WAI/EFcYabyuZ6vtbkn+VA24fDec0Y/Ojo4+QM5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLIwPtF6ehxVOma0JdkKwnVBQPk87MDGVNoly5FnOKiX25ufspc7yHUBlJ7FIcTtChuQM5NgN/yTrQS0VZOSMtv3RBEd2WoE9DqaEgwZIq8eTIgXX3exDOqECOnEGMHRZ3hcvT/mdot/bJhmxVJbBey6wx8l8sbtjBsFab5fgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CeeB14nc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605624; x=1751141624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6q4WAI/EFcYabyuZ6vtbkn+VA24fDec0Y/Ojo4+QM5A=;
  b=CeeB14ncUybNOGtdvu0Zn89t9h90mA7Hx1kWBqB/D01V5tlOVhB1RRjE
   A9rr4i96reorigcdjvEovCFyvoRUO2bH/4cIjCFGyeQuyhTV9tA/nq4gP
   G5LRQlQvnGLA0qpEZw8oIQXh8Ft7NO3qhlF/ZfZb7IYNCEwdfCF9hXXlg
   Lb6W4s5X+gZaMVpA76B2Me0OAt/p5YdGS/wrCtstGvRHRTyw9HItfOxkm
   YQPAaIgp+JBuorzACxh1FN19UqnoRhhZ8pIFOg81sVLXPbXO+wXB8fB90
   rj8r4Pc5Fzc5Lrek57ri4TMaaCRKJPyXN5cFfEByOCYFLNVoR5+Z+Bwsd
   w==;
X-CSE-ConnectionGUID: tz72MyDTQH6lMuGYG7Ovcw==
X-CSE-MsgGUID: iN2FMYm0TL2rb3sHcMrY5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674911"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674911"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: O3lRJS96T9iOSnyhmT4dSA==
X-CSE-MsgGUID: TBBpPuFeRgSrl0KAdlIPbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735525"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Karthik Sundaravel <ksundara@redhat.com>,
	anthony.l.nguyen@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 2/6] ice: Add get/set hw address for VFs using devlink commands
Date: Fri, 28 Jun 2024 13:13:20 -0700
Message-ID: <20240628201328.2738672-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Sundaravel <ksundara@redhat.com>

Changing the MAC address of the VFs is currently unsupported via devlink.
Add the function handlers to set and get the HW address for the VFs.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c | 59 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 34 ++++++++---
 drivers/net/ethernet/intel/ice/ice_sriov.h    |  8 +++
 3 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index c9fbeebf7fb9..00fed5a61d62 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -372,6 +372,62 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 	devl_port_unregister(&pf->devlink_port);
 }
 
+/**
+ * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_get operation
+ * Return: zero on success or an error code on failure.
+ */
+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
+					  u8 *hw_addr, int *hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
+
+	ether_addr_copy(hw_addr, vf->dev_lan_addr);
+	*hw_addr_len = ETH_ALEN;
+
+	return 0;
+}
+
+/**
+ * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_set operation
+ * Return: zero on success or an error code on failure.
+ */
+static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
+					  const u8 *hw_addr,
+					  int hw_addr_len,
+					  struct netlink_ext_ack *extack)
+
+{
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct devlink *devlink = port->devlink;
+	struct ice_pf *pf;
+	u16 vf_id;
+
+	pf = devlink_priv(devlink);
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	return __ice_set_vf_mac(pf, vf_id, hw_addr);
+}
+
+static const struct devlink_port_ops ice_devlink_vf_port_ops = {
+	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
+	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
+};
+
 /**
  * ice_devlink_create_vf_port - Create a devlink port for this VF
  * @vf: the VF to create a port for
@@ -407,7 +463,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devl_port_register(devlink, devlink_port, vsi->idx);
+	err = devl_port_register_with_ops(devlink, devlink_port, vsi->idx,
+					  &ice_devlink_vf_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 067712f4923f..55ef33208456 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1416,21 +1416,23 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 }
 
 /**
- * ice_set_vf_mac
- * @netdev: network interface device structure
+ * __ice_set_vf_mac - program VF MAC address
+ * @pf: PF to be configure
  * @vf_id: VF identifier
  * @mac: MAC address
  *
  * program VF MAC address
+ * Return: zero on success or an error code on failure
  */
-int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
+int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac)
 {
-	struct ice_pf *pf = ice_netdev_to_pf(netdev);
+	struct device *dev;
 	struct ice_vf *vf;
 	int ret;
 
+	dev = ice_pf_to_dev(pf);
 	if (is_multicast_ether_addr(mac)) {
-		netdev_err(netdev, "%pM not a valid unicast address\n", mac);
+		dev_err(dev, "%pM not a valid unicast address\n", mac);
 		return -EINVAL;
 	}
 
@@ -1459,13 +1461,13 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	if (is_zero_ether_addr(mac)) {
 		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
 		vf->pf_set_mac = false;
-		netdev_info(netdev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
-			    vf->vf_id);
+		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
+			 vf->vf_id);
 	} else {
 		/* PF will add MAC rule for the VF */
 		vf->pf_set_mac = true;
-		netdev_info(netdev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
-			    mac, vf_id);
+		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
+			 mac, vf_id);
 	}
 
 	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
@@ -1476,6 +1478,20 @@ int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	return ret;
 }
 
+/**
+ * ice_set_vf_mac - .ndo_set_vf_mac handler
+ * @netdev: network interface device structure
+ * @vf_id: VF identifier
+ * @mac: MAC address
+ *
+ * program VF MAC address
+ * Return: zero on success or an error code on failure
+ */
+int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
+{
+	return __ice_set_vf_mac(ice_netdev_to_pf(netdev), vf_id, mac);
+}
+
 /**
  * ice_set_vf_trust
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 8f22313474d6..96549ca5c52c 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -28,6 +28,7 @@
 #ifdef CONFIG_PCI_IOV
 void ice_process_vflr_event(struct ice_pf *pf);
 int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int __ice_set_vf_mac(struct ice_pf *pf, u16 vf_id, const u8 *mac);
 int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
 int
 ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
@@ -80,6 +81,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+__ice_set_vf_mac(struct ice_pf __always_unused *pf,
+		 u16 __always_unused vf_id, const u8 __always_unused *mac)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int
 ice_set_vf_mac(struct net_device __always_unused *netdev,
 	       int __always_unused vf_id, u8 __always_unused *mac)
-- 
2.41.0


