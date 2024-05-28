Return-Path: <netdev+bounces-98656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF88D1F96
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E8B24295
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC3C177980;
	Tue, 28 May 2024 15:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0fmeDxe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFDD17167A
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908565; cv=none; b=tjolWC79fO6GkvkGYf5wMptVaUpxkaIPCiXHUeNGSTJke/phabWgiNInt23rvj5sG0hYYtSrFgUgIaZvA4tpn2OJCyK3OIWbztH8ujbc64NjX3Yr+b02ruJ6CEBTiTAnZtHTL4snGOCtV4rrSIpfM/BRQUxTrujGe82VnEv9Y2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908565; c=relaxed/simple;
	bh=RE9bI6ZUEcvSqXhSN4cyLhZopUW7FnBxeJgo6kcpEXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2tT+cnjCq6yPzQGtUi6QYYn4gcnBrqxSHtcPnIthQut6lNWaHHvPJ6zeRDULf+dsGuLjNEuGFkQEihC+zdu29b1Cga7wOm0ZEYrg0/Nf6+a+6GRdBPwZ+PNSgFiYt6pKi/rPmnK7iK6bsj82kb7F8AVQlNqcSLKamkhSfGTzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0fmeDxe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716908562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSjEvbqNmIrlRH+lx8idqnWZR1BGIt78ZUEpsZ7x8DA=;
	b=J0fmeDxe2r9C0NiUU2t1F8GM0fq3UnqjI9jKtkEa/hLFySim0TdgvOScIkLJp2wYOokjHw
	XR5nmI6Gc9InSt77Msshv3wrzGi6QCJsr219+k6eYJ+NP0n+CPpUI8gh0YiGgyIvMTKfV6
	EzMnGk3WbvHHuSR3TtR5j4DRaSx61K0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-7K0OU6OjOIudfo685XBM9A-1; Tue,
 28 May 2024 11:02:36 -0400
X-MC-Unique: 7K0OU6OjOIudfo685XBM9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADB5A1C0512D;
	Tue, 28 May 2024 15:02:35 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.97])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C2DAC286E;
	Tue, 28 May 2024 15:02:28 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	wojciech.drewek@intel.com,
	sumang@marvell.com,
	jacob.e.keller@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	bcreeley@amd.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH iwl-next v12] ice: Add get/set hw address for VFs using devlink commands
Date: Tue, 28 May 2024 20:32:13 +0530
Message-Id: <20240528150213.16771-2-ksundara@redhat.com>
In-Reply-To: <20240528150213.16771-1-ksundara@redhat.com>
References: <20240528150213.16771-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Changing the MAC address of the VFs is currently unsupported via devlink.
Add the function handlers to set and get the HW address for the VFs.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
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
2.39.3 (Apple Git-146)


