Return-Path: <netdev+bounces-222099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5104FB530F0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1612F1B23E00
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9629322748;
	Thu, 11 Sep 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cbk1IJ1c"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7031CA59;
	Thu, 11 Sep 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590631; cv=none; b=k2cH49G4jV2KIaY1ulw0EWX6/QDfGyIGT0bC/RAjyGkTE4LeFgZcioc1kjAfATdX4PGbmLdAF5fXCxoqX4kQajjV2M+vZjj6j/xRQ/3gxnAYEanIKjQEuHd8sSgNSZ1pWEslA5wSV9m73fil5p/SBXGiFoyHrsGjiGKVyFhDHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590631; c=relaxed/simple;
	bh=TrXBybeR0aNAqOiIxm/hrdvqvYTzcoh2b2KKxtgdUW8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrlZtJOD0JvvBAiZOb7f34g2gU0KxK0F+krFmTWrWhrkVosWB1myQ31m6zTVghAKJ4QrAVV6IDdGEKnVtYUNbdzJOR2sZZkGBjA5P2CosTgoo1H00CIOL5DRhPs4VD6k8ggHlsw7W7vQf3rAgf+aqtgYFzeNPJa4oXJVFefyADg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cbk1IJ1c; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BBaMZm793642;
	Thu, 11 Sep 2025 06:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757590582;
	bh=UcKnqqQ3hc0qlaEnqWP7Zltl+WKjelR3FGrd2YAXgOA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Cbk1IJ1co2d8Q4NLcfNYir5p1PxSKISLAJFGi4rBwGwUX2fRs82OEUBvssG3XeVA5
	 vfcJism3z2SvDy5otimGLFEYGqbHT8KUr1oBYBDzevFVXGpBEKj2NAdb+QVpc6B56r
	 7X1/1vF62ixta12VCN0zGNovs7b3bq9ScKQsPotw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BBaMVI1908800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 11 Sep 2025 06:36:22 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 06:36:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 06:36:21 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BBaLa42061818;
	Thu, 11 Sep 2025 06:36:21 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58BBaKEM007150;
	Thu, 11 Sep 2025 06:36:20 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        MD Danish Anwar
	<danishanwar@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Xin Guo <guoxin09@huawei.com>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Lukas Bulwahn
	<lukas.bulwahn@redhat.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH net-next v4 2/7] net: rpmsg-eth: Add basic rpmsg skeleton
Date: Thu, 11 Sep 2025 17:06:07 +0530
Message-ID: <20250911113612.2598643-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911113612.2598643-1-danishanwar@ti.com>
References: <20250911113612.2598643-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Introduces a basic RPMSG Ethernet driver and add it's basic skeleton.
Add support for creating virtual Ethernet devices over RPMSG channels,
allowing user-space programs to send and receive messages using a
standard Ethernet protocol. The driver includes message handling,
probe, and remove functions, along with necessary data structures.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/Kconfig     |  11 +++
 drivers/net/ethernet/Makefile    |   1 +
 drivers/net/ethernet/rpmsg_eth.c | 144 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h |  85 ++++++++++++++++++
 4 files changed, 241 insertions(+)
 create mode 100644 drivers/net/ethernet/rpmsg_eth.c
 create mode 100644 drivers/net/ethernet/rpmsg_eth.h

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..7d00e02a2c8f 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -170,6 +170,17 @@ config OA_TC6
 	  To know the implementation details, refer documentation in
 	  <file:Documentation/networking/oa-tc6-framework.rst>.
 
+config RPMSG_ETH
+	tristate "RPMsg Based Virtual Ethernet driver"
+	depends on RPMSG
+	depends on REMOTEPROC
+	help
+	  This makes it possible for user-space programs to send and receive
+	  rpmsg messages as a standard eth protocol.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called rpmsg_eth.
+
 source "drivers/net/ethernet/packetengines/Kconfig"
 source "drivers/net/ethernet/pasemi/Kconfig"
 source "drivers/net/ethernet/pensando/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a..aebd15993e3c 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
 obj-$(CONFIG_OA_TC6) += oa_tc6.o
+obj-$(CONFIG_RPMSG_ETH) += rpmsg_eth.o
diff --git a/drivers/net/ethernet/rpmsg_eth.c b/drivers/net/ethernet/rpmsg_eth.c
new file mode 100644
index 000000000000..7224fbc89646
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/* RPMsg Based Virtual Ethernet Driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/remoteproc.h>
+
+#include "rpmsg_eth.h"
+
+static int rpmsg_eth_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			      void *priv, u32 src)
+{
+	struct rpmsg_eth_common *common = dev_get_drvdata(&rpdev->dev);
+	struct message *msg = (struct message *)data;
+	u32 msg_type = msg->msg_hdr.msg_type;
+	int ret = 0;
+
+	switch (msg_type) {
+	case RPMSG_ETH_REQUEST_MSG:
+	case RPMSG_ETH_RESPONSE_MSG:
+	case RPMSG_ETH_NOTIFY_MSG:
+		dev_dbg(common->dev, "Msg type = %d, Src Id = %d\n",
+			msg_type, msg->msg_hdr.src_id);
+		break;
+	default:
+		dev_err(common->dev, "Invalid msg type\n");
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+/**
+ * rpmsg_eth_get_shm_info - Retrieve shared memory region for RPMsg Ethernet
+ * @common: Pointer to rpmsg_eth_common structure
+ *
+ * This function locates and maps the reserved memory region for the RPMsg
+ * Ethernet device by traversing the device tree hierarchy. It first identifies
+ * the associated remote processor (rproc), then locates the "rpmsg-eth" child
+ * node within the rproc's device tree node, and finally retrieves the
+ * "memory-region" phandle that points to the reserved memory region.
+ * Once found, the shared memory region is mapped into the
+ * kernel's virtual address space using devm_ioremap()
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
+{
+	struct device_node *np, *rmem_np;
+	struct reserved_mem *rmem;
+	struct rproc *rproc;
+
+	/* Get the remote processor associated with this device */
+	rproc = rproc_get_by_child(&common->rpdev->dev);
+	if (!rproc) {
+		dev_err(common->dev, "rpmsg eth device not child of rproc\n");
+		return -EINVAL;
+	}
+
+	/* Get the device node from rproc or its parent */
+	np = rproc->dev.of_node ?: (rproc->dev.parent ? rproc->dev.parent->of_node : NULL);
+	if (!np) {
+		dev_err(common->dev, "Cannot find rproc device node\n");
+		return -ENODEV;
+	}
+
+	/* Parse the memory-region phandle */
+	rmem_np = of_parse_phandle(np, "memory-region", common->data.shm_region_index);
+	of_node_put(np);
+	if (!rmem_np) {
+		dev_err(common->dev, "Cannot find shared memory region\n");
+		return -EINVAL;
+	}
+
+	/* Lookup the reserved memory region */
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem)
+		return -EINVAL;
+
+	common->port->shm = devm_ioremap(common->dev, rmem->base, rmem->size);
+	if (IS_ERR(common->port->shm))
+		return PTR_ERR(common->port->shm);
+
+	common->port->buf_size = rmem->size;
+
+	return 0;
+}
+
+static int rpmsg_eth_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct rpmsg_eth_common *common;
+	int ret = 0;
+
+	common = devm_kzalloc(&rpdev->dev, sizeof(*common), GFP_KERNEL);
+	if (!common)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, common);
+
+	common->port = devm_kzalloc(dev, sizeof(*common->port), GFP_KERNEL);
+	common->dev = dev;
+	common->rpdev = rpdev;
+	common->data = *(const struct rpmsg_eth_data *)rpdev->id.driver_data;
+
+	ret = rpmsg_eth_get_shm_info(common);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void rpmsg_eth_remove(struct rpmsg_device *rpdev)
+{
+	dev_dbg(&rpdev->dev, "rpmsg-eth client driver is removed\n");
+}
+
+static const struct rpmsg_eth_data ti_rpmsg_eth_data = {
+	.shm_region_index = 2,
+};
+
+static struct rpmsg_device_id rpmsg_eth_id_table[] = {
+	{ .name = "ti.shm-eth", .driver_data = (kernel_ulong_t)&ti_rpmsg_eth_data },
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_eth_id_table);
+
+static struct rpmsg_driver rpmsg_eth_rpmsg_client = {
+	.drv.name = KBUILD_MODNAME,
+	.id_table = rpmsg_eth_id_table,
+	.probe = rpmsg_eth_probe,
+	.callback = rpmsg_eth_rpmsg_cb,
+	.remove = rpmsg_eth_remove,
+};
+module_rpmsg_driver(rpmsg_eth_rpmsg_client);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("MD Danish Anwar <danishanwar@ti.com>");
+MODULE_DESCRIPTION("RPMsg Based Virtual Ethernet driver");
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
new file mode 100644
index 000000000000..0d6f96f755eb
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * RPMsg Based Virtual Ethernet Driver common header
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __RPMSG_ETH_H__
+#define __RPMSG_ETH_H__
+
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rpmsg.h>
+
+#define RPMSG_ETH_SHM_MAGIC_NUM 0xABCDABCD
+
+enum rpmsg_eth_msg_type {
+	RPMSG_ETH_REQUEST_MSG = 0,
+	RPMSG_ETH_RESPONSE_MSG,
+	RPMSG_ETH_NOTIFY_MSG,
+};
+
+/**
+ * struct message_header - message header structure for RPMSG Ethernet
+ * @src_id: Source endpoint ID
+ * @msg_type: Message type
+ */
+struct message_header {
+	u32 src_id;
+	u32 msg_type;
+} __packed;
+
+/**
+ * struct message - RPMSG Ethernet message structure
+ *
+ * @msg_hdr: Message header contains source and destination endpoint and
+ *          the type of message
+ *
+ * This structure is used to send and receive messages between the RPMSG
+ * Ethernet ports.
+ */
+struct message {
+	struct message_header msg_hdr;
+} __packed;
+
+/**
+ * struct rpmsg_eth_data - RPMSG ETH device data
+ * @shm_region_index: Shared memory region index
+ */
+struct rpmsg_eth_data {
+	u8 shm_region_index;
+};
+
+/**
+ * struct rpmsg_eth_common - common structure for RPMSG Ethernet
+ * @rpdev: RPMSG device
+ * @port: Ethernet port
+ * @dev: Device
+ * @data: Vendor specific data
+ */
+struct rpmsg_eth_common {
+	struct rpmsg_device *rpdev;
+	struct rpmsg_eth_port *port;
+	struct device *dev;
+	struct rpmsg_eth_data data;
+};
+
+/**
+ * struct rpmsg_eth_port - Ethernet port structure for RPMSG Ethernet
+ * @common: Pointer to the common RPMSG Ethernet structure
+ * @shm: Shared memory region mapping
+ * @buf_size: Size (in bytes) of the shared memory buffer for this port
+ */
+struct rpmsg_eth_port {
+	struct rpmsg_eth_common *common;
+	void __iomem *shm;
+	phys_addr_t buf_size;
+};
+
+#endif /* __RPMSG_ETH_H__ */
-- 
2.34.1


