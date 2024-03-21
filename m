Return-Path: <netdev+bounces-80959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045288558D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E9D1F21029
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D34D6996D;
	Thu, 21 Mar 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Muu03dT8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943297827C
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 08:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009020; cv=none; b=JxHq29yYCh5jeK7u0wUSqvQ2bkKG99fiztyysqDq8hnLukc7rrWW1MGIYGUnIi6CwasmXICE63sxTLNSP4Fzt1bkZlFfnpK19LLpHhiDykAyc7SbyUk5ZXXZ4gHoZdgO6mL52dVo5032ivu2IRVTeSYQrTYFnO2k7bpbOeGGjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009020; c=relaxed/simple;
	bh=Bucf8OgZhJEaGbIkzsG+pFmkLSYevgyIJdVov7mbGGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAZbbAkzZD8tpmacRYz8A9WQJved78OAJVgNehZYmC2AmCBYRoZ8X6k4eQ4p1rINqcKo1gp4IByMmb4XmnocDkMMiRyyVdme1+Qs1Tz0fEKYaM4N0MdMAftsU4sg1W1x3iiZMkeaNPm7K+H3ffmg2d3/C53Hs5gPxC5/LuJZVP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Muu03dT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711009017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3fIgOSAULMyJ+CQEgwXUV13LX87A4bADR0ZYM/j/F8=;
	b=Muu03dT8lYKP8vGVBO6Vw7/G58eCLOcfroLvUMWhpmwzKxxfl02VnDd963LUiA3oR+VKZk
	YEYBqqcfEYixpuiKiyb5ksMesIsxdGww2f3Gl7kg/J/t5fGNND2AnVemX7yWQeYvJDgKZC
	ysxmlabuYJjvAIZKASFXeET82apE8wc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-xavK4NOFPwWYtDpzkKB7mQ-1; Thu, 21 Mar 2024 04:16:54 -0400
X-MC-Unique: xavK4NOFPwWYtDpzkKB7mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 836BB8007A2;
	Thu, 21 Mar 2024 08:16:53 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.16.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 897471C060A4;
	Thu, 21 Mar 2024 08:16:47 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v6] ice: Add get/set hw address for VFs using devlink commands
Date: Thu, 21 Mar 2024 13:46:25 +0530
Message-Id: <20240321081625.28671-2-ksundara@redhat.com>
In-Reply-To: <20240321081625.28671-1-ksundara@redhat.com>
References: <20240321081625.28671-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Changing the MAC address of the VFs is currently unsupported via devlink.
Add the function handlers to set and get the HW address for the VFs.

Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 66 +++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 +++
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index 80dc5445b50d..35c7cfc8ce9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -1576,6 +1576,69 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
 	devlink_port_unregister(&pf->devlink_port);
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
+
+static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
+					  u8 *hw_addr, int *hw_addr_len,
+					  struct netlink_ext_ack *extack)
+{
+	struct ice_vf *vf = container_of(port, struct ice_vf, devlink_port);
+	if (!vf) {
+		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
+		return -EINVAL;
+	}
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
+	u8 mac[ETH_ALEN];
+	u16 vf_id;
+
+	pf = devlink_priv(devlink);
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	ether_addr_copy(mac, hw_addr);
+
+	return ice_set_vf_fn_mac(pf, vf_id, mac);
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
@@ -1611,7 +1674,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
 	devlink_port_attrs_set(devlink_port, &attrs);
 	devlink = priv_to_devlink(pf);
 
-	err = devlink_port_register(devlink, devlink_port, vsi->idx);
+	err = devlink_port_register_with_ops(devlink, devlink_port,
+					     vsi->idx, &ice_devlink_vf_port_ops);
 	if (err) {
 		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
 			vf->vf_id, err);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 31314e7540f8..b1e5cd188fd7 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
 	return ret;
 }
 
+/**
+ * ice_set_vf_fn_mac
+ * @pf: PF to be configure
+ * @vf_id: VF identifier
+ * @mac: MAC address
+ *
+ * program VF MAC address
+ */
+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac)
+{
+	struct device *dev;
+	struct ice_vf *vf;
+	int ret;
+
+	dev = ice_pf_to_dev(pf);
+	if (is_multicast_ether_addr(mac)) {
+		dev_err(dev, "%pM not a valid unicast address\n", mac);
+		return -EINVAL;
+	}
+
+	vf = ice_get_vf_by_id(pf, vf_id);
+	if (!vf)
+		return -EINVAL;
+
+	/* nothing left to do, unicast MAC already set */
+	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
+	    ether_addr_equal(vf->hw_lan_addr, mac)) {
+		ret = 0;
+		goto out_put_vf;
+	}
+
+	ret = ice_check_vf_ready_for_cfg(vf);
+	if (ret)
+		goto out_put_vf;
+
+	mutex_lock(&vf->cfg_lock);
+
+	/* VF is notified of its new MAC via the PF's response to the
+	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
+	 */
+	ether_addr_copy(vf->dev_lan_addr, mac);
+	ether_addr_copy(vf->hw_lan_addr, mac);
+	if (is_zero_ether_addr(mac)) {
+		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
+		vf->pf_set_mac = false;
+		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
+			 vf->vf_id);
+	} else {
+		/* PF will add MAC rule for the VF */
+		vf->pf_set_mac = true;
+		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
+			 mac, vf_id);
+	}
+
+	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
+	mutex_unlock(&vf->cfg_lock);
+
+out_put_vf:
+	ice_put_vf(vf);
+	return ret;
+}
+
 /**
  * ice_set_vf_mac
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 346cb2666f3a..11cc522b1d9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -28,6 +28,7 @@
 #ifdef CONFIG_PCI_IOV
 void ice_process_vflr_event(struct ice_pf *pf);
 int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int ice_set_vf_fn_mac(struct ice_pf *pf, u16 vf_id, u8 *mac);
 int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
 int
 ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
@@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
 	return -EOPNOTSUPP;
 }
 
+static inline int
+ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
+		  u16 __always_unused vf_id, u8 __always_unused *mac)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int
 ice_set_vf_mac(struct net_device __always_unused *netdev,
 	       int __always_unused vf_id, u8 __always_unused *mac)
-- 
2.39.3 (Apple Git-146)


