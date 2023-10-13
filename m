Return-Path: <netdev+bounces-40828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B3F7C8BFB
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 19:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFE8B20AC2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2D21A0B;
	Fri, 13 Oct 2023 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6oXGMik"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3C219FC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 17:08:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6FBB
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697216885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5HPRLiZ6quHlzEGy6WTaNXEgpU/KungfD7Pl9VH4HkU=;
	b=J6oXGMikIwrcXkgsF4XPIYx+ZluVkKBUnSr08ZTIxSlhmEeffXt2hzzMeYFzsJJHRb6qMb
	F1cFbKv1BUiy9r6i5xMqvGh+sJM4DtFCf26rQXRo2pOGbYapuahj6pun2Gp/tm1Dad0QzI
	e819uNifJxb3yyJChJ95lZXttrnVT54=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-4mX55QlZNQ-kmobt6IHXeA-1; Fri, 13 Oct 2023 13:08:00 -0400
X-MC-Unique: 4mX55QlZNQ-kmobt6IHXeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE02438210B1;
	Fri, 13 Oct 2023 17:07:59 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE9F1C06536;
	Fri, 13 Oct 2023 17:07:58 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 1/5] i40e: Add initial devlink support
Date: Fri, 13 Oct 2023 19:07:51 +0200
Message-ID: <20231013170755.2367410-2-ivecera@redhat.com>
In-Reply-To: <20231013170755.2367410-1-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add an initial support for devlink interface to i40e driver.

Similarly to ice driver the implementation doe not enable devlink
to manage device-wide configuration and devlink instance is created
for each physical function of PCIe device.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/i40e/Makefile      |   3 +-
 drivers/net/ethernet/intel/i40e/i40e.h        |   3 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 118 ++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.h    |  18 +++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  27 +++-
 6 files changed, 164 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.c
 create mode 100644 drivers/net/ethernet/intel/i40e/i40e_devlink.h

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index e6684f3cc0ce..06ddd7147c7f 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -225,6 +225,7 @@ config I40E
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI
 	select AUXILIARY_BUS
+	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Ethernet Controller XL710 Family of
 	  devices.  For more information on how to identify your adapter, go
diff --git a/drivers/net/ethernet/intel/i40e/Makefile b/drivers/net/ethernet/intel/i40e/Makefile
index 2f21b3e89fd0..cad93f323bd5 100644
--- a/drivers/net/ethernet/intel/i40e/Makefile
+++ b/drivers/net/ethernet/intel/i40e/Makefile
@@ -24,6 +24,7 @@ i40e-objs := i40e_main.o \
 	i40e_ddp.o \
 	i40e_client.o   \
 	i40e_virtchnl_pf.o \
-	i40e_xsk.o
+	i40e_xsk.o	\
+	i40e_devlink.o
 
 i40e-$(CONFIG_I40E_DCB) += i40e_dcb.o i40e_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 214744de120d..b7e20cea19c2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -9,10 +9,12 @@
 #include <linux/types.h>
 #include <linux/avf/virtchnl.h>
 #include <linux/net/intel/i40e_client.h>
+#include <net/devlink.h>
 #include <net/pkt_cls.h>
 #include <net/udp_tunnel.h>
 #include "i40e_dcb.h"
 #include "i40e_debug.h"
+#include "i40e_devlink.h"
 #include "i40e_io.h"
 #include "i40e_prototype.h"
 #include "i40e_register.h"
@@ -411,6 +413,7 @@ static inline const u8 *i40e_channel_mac(struct i40e_channel *ch)
 /* struct that defines the Ethernet device */
 struct i40e_pf {
 	struct pci_dev *pdev;
+	struct devlink_port devlink_port;
 	struct i40e_hw hw;
 	DECLARE_BITMAP(state, __I40E_STATE_SIZE__);
 	struct msix_entry *msix_entries;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
new file mode 100644
index 000000000000..66b7f5be45ae
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation. */
+
+#include <net/devlink.h>
+#include "i40e.h"
+#include "i40e_devlink.h"
+
+static const struct devlink_ops i40e_devlink_ops = {
+};
+
+/**
+ * i40e_alloc_pf - Allocate devlink and return i40e_pf structure pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for this device and return the private
+ * area as the i40e_pf structure.
+ **/
+struct i40e_pf *i40e_alloc_pf(struct device *dev)
+{
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&i40e_devlink_ops, sizeof(struct i40e_pf), dev);
+	if (!devlink)
+		return NULL;
+
+	return devlink_priv(devlink);
+}
+
+/**
+ * i40e_free_pf - Free i40e_pf structure and associated devlink
+ * @pf: the PF structure
+ *
+ * Free i40e_pf structure and devlink allocated by devlink_alloc.
+ **/
+void i40e_free_pf(struct i40e_pf *pf)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+
+	devlink_free(devlink);
+}
+
+/**
+ * i40e_devlink_register - Register devlink interface for this PF
+ * @pf: the PF to register the devlink for.
+ *
+ * Register the devlink instance associated with this physical function.
+ **/
+void i40e_devlink_register(struct i40e_pf *pf)
+{
+	devlink_register(priv_to_devlink(pf));
+}
+
+/**
+ * i40e_devlink_unregister - Unregister devlink resources for this PF.
+ * @pf: the PF structure to cleanup
+ *
+ * Releases resources used by devlink and cleans up associated memory.
+ **/
+void i40e_devlink_unregister(struct i40e_pf *pf)
+{
+	devlink_unregister(priv_to_devlink(pf));
+}
+
+/**
+ * i40e_devlink_set_switch_id - Set unique switch id based on pci dsn
+ * @pf: the PF to create a devlink port for
+ * @ppid: struct with switch id information
+ */
+static void i40e_devlink_set_switch_id(struct i40e_pf *pf,
+				       struct netdev_phys_item_id *ppid)
+{
+	u64 id = pci_get_dsn(pf->pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
+/**
+ * i40e_devlink_create_port - Create a devlink port for this PF
+ * @pf: the PF to create a port for
+ *
+ * Create and register a devlink_port for this PF. Note that although each
+ * physical function is connected to a separate devlink instance, the port
+ * will still be numbered according to the physical function id.
+ *
+ * Return: zero on success or an error code on failure.
+ **/
+int i40e_devlink_create_port(struct i40e_pf *pf)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+	struct devlink_port_attrs attrs = {};
+	struct device *dev = &pf->pdev->dev;
+	int err;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	attrs.phys.port_number = pf->hw.pf_id;
+	i40e_devlink_set_switch_id(pf, &attrs.switch_id);
+	devlink_port_attrs_set(&pf->devlink_port, &attrs);
+	err = devlink_port_register(devlink, &pf->devlink_port, pf->hw.pf_id);
+	if (err) {
+		dev_err(dev, "devlink_port_register failed: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * i40e_devlink_destroy_port - Destroy the devlink_port for this PF
+ * @pf: the PF to cleanup
+ *
+ * Unregisters the devlink_port structure associated with this PF.
+ **/
+void i40e_devlink_destroy_port(struct i40e_pf *pf)
+{
+	devlink_port_type_clear(&pf->devlink_port);
+	devlink_port_unregister(&pf->devlink_port);
+}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.h b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
new file mode 100644
index 000000000000..469fb3d2ee25
--- /dev/null
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2023, Intel Corporation. */
+
+#ifndef _I40E_DEVLINK_H_
+#define _I40E_DEVLINK_H_
+
+#include <linux/device.h>
+
+struct i40e_pf;
+
+struct i40e_pf *i40e_alloc_pf(struct device *dev);
+void i40e_free_pf(struct i40e_pf *pf);
+void i40e_devlink_register(struct i40e_pf *pf);
+void i40e_devlink_unregister(struct i40e_pf *pf);
+int i40e_devlink_create_port(struct i40e_pf *pf);
+void i40e_devlink_destroy_port(struct i40e_pf *pf);
+
+#endif /* _I40E_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1e52e1debf7c..f0e563a7f7b3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14211,6 +14211,8 @@ int i40e_vsi_release(struct i40e_vsi *vsi)
 	}
 	set_bit(__I40E_VSI_RELEASING, vsi->state);
 	uplink_seid = vsi->uplink_seid;
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
 	if (vsi->type != I40E_VSI_SRIOV) {
 		if (vsi->netdev_registered) {
 			vsi->netdev_registered = false;
@@ -14398,6 +14400,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 err_rings:
 	i40e_vsi_free_q_vectors(vsi);
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14544,9 +14548,15 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		ret = i40e_netif_set_realnum_tx_rx_queues(vsi);
 		if (ret)
 			goto err_netdev;
+		if (vsi->type == I40E_VSI_MAIN) {
+			ret = i40e_devlink_create_port(pf);
+			if (ret)
+				goto err_netdev;
+			SET_NETDEV_DEVLINK_PORT(vsi->netdev, &pf->devlink_port);
+		}
 		ret = register_netdev(vsi->netdev);
 		if (ret)
-			goto err_netdev;
+			goto err_dl_port;
 		vsi->netdev_registered = true;
 		netif_carrier_off(vsi->netdev);
 #ifdef CONFIG_I40E_DCB
@@ -14589,6 +14599,9 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 		free_netdev(vsi->netdev);
 		vsi->netdev = NULL;
 	}
+err_dl_port:
+	if (vsi->type == I40E_VSI_MAIN)
+		i40e_devlink_destroy_port(pf);
 err_netdev:
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
 err_vsi:
@@ -15619,7 +15632,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	iounmap(hw->hw_addr);
 	pci_release_mem_regions(pf->pdev);
 	pci_disable_device(pf->pdev);
-	kfree(pf);
+	i40e_free_pf(pf);
 
 	return err;
 }
@@ -15696,7 +15709,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * the Admin Queue structures and then querying for the
 	 * device's current profile information.
 	 */
-	pf = kzalloc(sizeof(*pf), GFP_KERNEL);
+	pf = i40e_alloc_pf(&pdev->dev);
 	if (!pf) {
 		err = -ENOMEM;
 		goto err_pf_alloc;
@@ -16223,6 +16236,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* print a string summarizing features */
 	i40e_print_features(pf);
 
+	i40e_devlink_register(pf);
+
 	return 0;
 
 	/* Unwind what we've done if something failed in the setup */
@@ -16243,7 +16258,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 err_pf_reset:
 	iounmap(hw->hw_addr);
 err_ioremap:
-	kfree(pf);
+	i40e_free_pf(pf);
 err_pf_alloc:
 	pci_release_mem_regions(pdev);
 err_pci_reg:
@@ -16268,6 +16283,8 @@ static void i40e_remove(struct pci_dev *pdev)
 	int ret_code;
 	int i;
 
+	i40e_devlink_unregister(pf);
+
 	i40e_dbg_pf_exit(pf);
 
 	i40e_ptp_stop(pf);
@@ -16393,7 +16410,7 @@ static void i40e_remove(struct pci_dev *pdev)
 	kfree(pf->vsi);
 
 	iounmap(hw->hw_addr);
-	kfree(pf);
+	i40e_free_pf(pf);
 	pci_release_mem_regions(pdev);
 
 	pci_disable_device(pdev);
-- 
2.41.0


