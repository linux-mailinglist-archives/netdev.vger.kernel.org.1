Return-Path: <netdev+bounces-115535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25B5946EBF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 14:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971C5281A36
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FD93BB59;
	Sun,  4 Aug 2024 12:49:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4D1E493
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722775761; cv=none; b=jfZI9gu2RwrRgRVRgHZi1elFfgmg7MpZT+rB0N86euCFTUTGgQhKTQ2vBkQX4EL8QQjpXqrCwG+OTutPgpNoW+j0A92ekTryM+RANzrL7lGnHfHntWAyz4/FeDHzcaY0S4vj7LtHakYWoeyWreZ3mk4PeVY2u4VhCW8XP5t+ePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722775761; c=relaxed/simple;
	bh=/TsNvhxNv346hl0xDSc13AILENERxzEXT2N38OJ2LiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gir6Yx8uuoWjHlNd726czSzZ/DuKefMH725xWT4+6VlFAjOVAJuumWS6RfOKitu7sWvPIP0kyNteHHitRs3j2WEL+8FsSaH/Sbr9VtQvobqdiUkIDceJCU2I/XDn3eN9k4KC/fXfkL+6H8TKYo6MwZWTZyfkEg/IKZN9AHjAATA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1722775752tbd8qzl5
X-QQ-Originating-IP: 7OBAIHzcWMeZ2KmJedos7nIjb8ZkW8+EtiP6aDgl59I=
Received: from localhost.localdomain ( [101.71.135.53])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Aug 2024 20:49:10 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12669121717975065620
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v5 07/10] net: libwx: allocate devlink for devlink port
Date: Sun,  4 Aug 2024 20:48:38 +0800
Message-ID: <5CCBD90FF2823C29+20240804124841.71177-8-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240804124841.71177-1-mengyuanlou@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Make devlink allocation function generic to use it for PF and for VF.

Add function for PF/VF devlink port creation. It will be used in
wangxun NICs.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 .../net/ethernet/wangxun/libwx/wx_devlink.c   | 208 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_devlink.h   |  13 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c |  13 +-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  14 ++
 6 files changed, 249 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_devlink.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_devlink.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 5b996d973d29..643a5e947ba9 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o wx_devlink.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_devlink.c b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
new file mode 100644
index 000000000000..b39da37c0842
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_devlink.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/vmalloc.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_sriov.h"
+#include "wx_devlink.h"
+
+static const struct devlink_ops wx_pf_devlink_ops = {
+};
+
+static void wx_devlink_free(void *devlink_ptr)
+{
+	devlink_unregister((struct devlink *)devlink_ptr);
+	devlink_free((struct devlink *)devlink_ptr);
+}
+
+struct wx_dl_priv *wx_create_devlink(struct device *dev)
+{
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&wx_pf_devlink_ops, sizeof(devlink), dev);
+	if (!devlink)
+		return NULL;
+
+	/* Add an action to teardown the devlink when unwinding the driver */
+	if (devm_add_action_or_reset(dev, wx_devlink_free, devlink))
+		return NULL;
+
+	devlink_register(devlink);
+
+	return devlink_priv(devlink);
+}
+EXPORT_SYMBOL(wx_create_devlink);
+
+/**
+ * wx_devlink_set_switch_id - Set unique switch id based on pci dsn
+ * @wx: the PF to create a devlink port for
+ * @ppid: struct with switch id information
+ */
+static void wx_devlink_set_switch_id(struct wx *wx,
+				     struct netdev_phys_item_id *ppid)
+{
+	struct pci_dev *pdev = wx->pdev;
+	u64 id;
+
+	id = pci_get_dsn(pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
+/**
+ * wx_devlink_create_pf_port - Create a devlink port for this PF
+ * @wx: the PF to create a devlink port for
+ *
+ * Create and register a devlink_port for this PF.
+ * This function has to be called under devl_lock.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int wx_devlink_create_pf_port(struct wx *wx)
+{
+	struct devlink *devlink = priv_to_devlink(wx->dl_priv);
+	struct devlink_port_attrs attrs = {};
+	int err;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	attrs.phys.port_number = wx->bus.func;
+	wx_devlink_set_switch_id(wx, &attrs.switch_id);
+	devlink_port_attrs_set(&wx->devlink_port, &attrs);
+	err = devlink_port_register(devlink, &wx->devlink_port, 0);
+	if (err) {
+		wx_err(wx, "Failed to create devlink port for PF%d, error %d\n",
+		       wx->bus.func, err);
+		return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_devlink_create_pf_port);
+
+/**
+ * wx_devlink_destroy_pf_port - Destroy the devlink_port for this PF
+ * @wx: the PF to cleanup
+ *
+ * Unregisters the devlink_port structure associated with this PF.
+ * This function has to be called under devl_lock.
+ */
+void wx_devlink_destroy_pf_port(struct wx *wx)
+{
+	devl_port_unregister(&wx->devlink_port);
+}
+EXPORT_SYMBOL(wx_devlink_destroy_pf_port);
+
+/**
+ * wx_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_get operation
+ * Return: zero on success or an error code on failure.
+ */
+static int wx_devlink_port_get_vf_fn_mac(struct devlink_port *port,
+					 u8 *hw_addr, int *hw_addr_len,
+					 struct netlink_ext_ack *extack)
+{
+	struct vf_data_storage *vfinfo = container_of(port,
+						      struct vf_data_storage,
+						      devlink_port);
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct wx *wx = vfinfo->vf_priv_wx;
+	u16 vf_id;
+
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	ether_addr_copy(hw_addr, wx->vfinfo[vf_id].vf_mac_addr);
+	*hw_addr_len = ETH_ALEN;
+
+	return 0;
+}
+
+/**
+ * wx_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
+ * @port: devlink port structure
+ * @hw_addr: MAC address of the port
+ * @hw_addr_len: length of MAC address
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .port_fn_hw_addr_set operation
+ * Return: zero on success or an error code on failure.
+ */
+static int wx_devlink_port_set_vf_fn_mac(struct devlink_port *port,
+					 const u8 *hw_addr,
+					 int hw_addr_len,
+					 struct netlink_ext_ack *extack)
+
+{
+	struct vf_data_storage *vfinfo = container_of(port,
+						      struct vf_data_storage,
+						      devlink_port);
+	struct devlink_port_attrs *attrs = &port->attrs;
+	struct devlink_port_pci_vf_attrs *pci_vf;
+	struct wx *wx = vfinfo->vf_priv_wx;
+	int ret = 0;
+	u16 vf_id;
+
+	pci_vf = &attrs->pci_vf;
+	vf_id = pci_vf->vf;
+
+	if (!is_valid_ether_addr(hw_addr) || vf_id >= wx->num_vfs)
+		return -EINVAL;
+
+	ret = wx_set_vf_mac(wx, vf_id, hw_addr);
+	if (ret >= 0) {
+		wx->vfinfo[vf_id].pf_set_mac = true;
+		if (!netif_running(wx->netdev))
+			wx_err(wx, "Bring the PF device up before use vfs\n");
+	} else {
+		wx_err(wx, "The VF MAC address was NOT set due to invalid\n");
+	}
+
+	return 0;
+}
+
+static const struct devlink_port_ops wx_devlink_vf_port_ops = {
+	.port_fn_hw_addr_get = wx_devlink_port_get_vf_fn_mac,
+	.port_fn_hw_addr_set = wx_devlink_port_set_vf_fn_mac,
+};
+
+int wx_devlink_create_vf_port(struct wx *wx, int vf_id)
+{
+	struct devlink *devlink = priv_to_devlink(wx->dl_priv);
+	struct devlink_port_attrs attrs = {};
+	struct devlink_port *devlink_port;
+	int err;
+
+	devlink_port = &wx->vfinfo[vf_id].devlink_port;
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PCI_VF;
+	attrs.pci_vf.pf = wx->bus.func;
+	attrs.pci_vf.vf = vf_id;
+
+	wx_devlink_set_switch_id(wx, &attrs.switch_id);
+	devlink_port_attrs_set(devlink_port, &attrs);
+	err = devl_port_register_with_ops(devlink, devlink_port, vf_id + 1,
+					  &wx_devlink_vf_port_ops);
+	if (err) {
+		wx_err(wx, "Failed to create devlink port for VF %d, error %d\n",
+		       vf_id, err);
+		return err;
+	}
+
+	return 0;
+}
+
+void wx_devlink_destroy_vf_port(struct wx *wx)
+{
+	int i;
+
+	for (i = 0; i < wx->num_vfs; i++)
+		devl_port_unregister(&wx->vfinfo[i].devlink_port);
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_devlink.h b/drivers/net/ethernet/wangxun/libwx/wx_devlink.h
new file mode 100644
index 000000000000..0754579ed304
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_devlink.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_DEVLINK_H_
+#define _WX_DEVLINK_H_
+
+struct wx_dl_priv *wx_create_devlink(struct device *dev);
+int wx_devlink_create_pf_port(struct wx *wx);
+void wx_devlink_destroy_pf_port(struct wx *wx);
+int wx_devlink_create_vf_port(struct wx *wx, int vf_id);
+void wx_devlink_destroy_vf_port(struct wx *wx);
+
+#endif /* _WX_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 08738738d02e..88ef82f1a1a3 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -7,6 +7,7 @@
 #include "wx_type.h"
 #include "wx_hw.h"
 #include "wx_mbx.h"
+#include "wx_devlink.h"
 #include "wx_sriov.h"
 
 static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
@@ -92,6 +93,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
 	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
 
 	for (i = 0; i < num_vfs; i++) {
+		wx->vfinfo[i].vf_priv_wx = wx;
 		/* enable spoof checking for all VFs */
 		wx->vfinfo[i].spoofchk_enabled = true;
 		wx->vfinfo[i].link_enable = true;
@@ -130,6 +132,7 @@ void wx_disable_sriov(struct wx *wx)
 	else
 		wx_err(wx, "Unloading driver while VFs are assigned.\n");
 
+	wx_devlink_destroy_vf_port(wx);
 	/* clear flags and free allloced data */
 	wx_sriov_clear_data(wx);
 }
@@ -158,7 +161,15 @@ static int wx_pci_sriov_enable(struct pci_dev *dev,
 		goto err_out;
 	}
 
+	for (i = 0; i < wx->num_vfs; i++) {
+		err = wx_devlink_create_vf_port(wx, i);
+		if (err)
+			goto err_dis_sriov;
+	}
+
 	return num_vfs;
+err_dis_sriov:
+	pci_disable_sriov(dev);
 err_out:
 	wx_sriov_clear_data(wx);
 	return err;
@@ -210,7 +221,7 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 }
 EXPORT_SYMBOL(wx_pci_sriov_configure);
 
-static int wx_set_vf_mac(struct wx *wx, u16 vf, const u8 *mac_addr)
+int wx_set_vf_mac(struct wx *wx, u16 vf, const u8 *mac_addr)
 {
 	u8 hw_addr[ETH_ALEN];
 	int ret = 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 2aa68947c0d3..e876cb03c2c9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -6,6 +6,7 @@
 
 void wx_disable_sriov(struct wx *wx);
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int wx_set_vf_mac(struct wx *wx, u16 vf, const u8 *mac_addr);
 void wx_msg_task(struct wx *wx);
 void wx_disable_vf_rx_tx(struct wx *wx);
 void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index e50a75e7c58b..a8722f69cebb 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -8,6 +8,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <net/devlink.h>
 #include <net/ip.h>
 
 #define WX_NCSI_SUP                             0x8000
@@ -1084,6 +1085,10 @@ enum wx_state {
 
 struct vf_data_storage {
 	struct pci_dev *vfdev;
+	struct wx *vf_priv_wx;
+	/* vf devlink port data */
+	struct devlink_port devlink_port;
+
 	unsigned char vf_mac_addr[ETH_ALEN];
 	bool spoofchk_enabled;
 	bool link_enable;
@@ -1119,6 +1124,10 @@ enum wx_pf_flags {
 	WX_PF_FLAGS_NBITS               /* must be last */
 };
 
+struct wx_dl_priv {
+	struct wx *priv_wx;
+};
+
 struct wx {
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
 	DECLARE_BITMAP(state, WX_STATE_NBITS);
@@ -1128,6 +1137,11 @@ struct wx {
 	u8 __iomem *hw_addr;
 	struct pci_dev *pdev;
 	struct net_device *netdev;
+
+	/* devlink port data */
+	struct devlink_port devlink_port;
+	struct wx_dl_priv *dl_priv;
+
 	struct wx_bus_info bus;
 	struct wx_mbx_info mbx;
 	struct wx_mac_info mac;
-- 
2.45.2


