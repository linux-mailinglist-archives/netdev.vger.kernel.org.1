Return-Path: <netdev+bounces-219067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBEB3F9BE
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84621884FE8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2141F2EA49D;
	Tue,  2 Sep 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BBGTNxID"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD042E8E03;
	Tue,  2 Sep 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804125; cv=none; b=IvU6H/rsi0nASdXeuLya72vUnrcRKAJcMATA4bWMHvm+BIRSihRA/hO9pREBvOEIIgbB9EPNisqqcO3DDWO/szto4PGGoOfiKsfSsw0nHJzkZM02gHp7JOo5047XSRvToIRhZktlukT2rDpGuPJN+LjUcKhkujlbn+G8z0b3GTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804125; c=relaxed/simple;
	bh=L32ueh0XADckKjFdnziQRCVDbzdbHyEd1Bg3gmIq2Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFO9TIDAkXpKrulrTkgwL2c58fRVZvk5dztRYVe8U5ff9dAphXAuZdX5/xy218xiRhXv5SyrJ0hwsIZwY0hHiR9ErMtHQM1Sr/aV5Cg4a6UdFQbAxGm1P51Hm1vdP42q8Vnzwrpj+scJte/Dy5gogmQ+T+XYG2bPxYKLlVYWZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BBGTNxID; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 582980L82552643;
	Tue, 2 Sep 2025 04:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756804080;
	bh=4ryukQeXWfZ0mSaQUezXsdNS7XrtPu+psta+XTg34wI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BBGTNxIDd7Zm/tf6tV3x+Ed7utNrmhz0NvqaPOKsC+MzCmxcCNlrSOnsO3r98Wuy0
	 xRKighHa9UEcSTSr8cPkhIS4RVxMNdshyk0WJ8oxH/WFnSmEvvDTYBAmOCXZdQvx69
	 2b3lnDZ/VUR/bn6vPgfcllje487MNqzn1Auh3Byo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 582980472729565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 04:08:00 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:07:59 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:07:59 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58297xGr3546586;
	Tue, 2 Sep 2025 04:07:59 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 58297wtc020837;
	Tue, 2 Sep 2025 04:07:58 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        MD
 Danish Anwar <danishanwar@ti.com>, Xin Guo <guoxin09@huawei.com>,
        Lei Wei
	<quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>,
        Michael Ellerman
	<mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        Suman Anna <s-anna@ti.com>
CC: Tero Kristo <kristo@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next v2 4/8] net: rpmsg-eth: Add basic rpmsg skeleton
Date: Tue, 2 Sep 2025 14:37:42 +0530
Message-ID: <20250902090746.3221225-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902090746.3221225-1-danishanwar@ti.com>
References: <20250902090746.3221225-1-danishanwar@ti.com>
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
 drivers/net/ethernet/Kconfig     |  10 +++
 drivers/net/ethernet/Makefile    |   1 +
 drivers/net/ethernet/rpmsg_eth.c | 142 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h |  75 ++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 drivers/net/ethernet/rpmsg_eth.c
 create mode 100644 drivers/net/ethernet/rpmsg_eth.h

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..a73a45a9ef3d 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -170,6 +170,16 @@ config OA_TC6
 	  To know the implementation details, refer documentation in
 	  <file:Documentation/networking/oa-tc6-framework.rst>.
 
+config RPMSG_ETH
+	tristate "RPMsg Based Virtual Ethernet driver"
+	depends on RPMSG
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
index 000000000000..4cfd9ff2f142
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/* RPMsg Based Virtual Ethernet Driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/remoteproc.h>
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
+	struct device_node *np, *rpmsg_eth_node, *rmem_np;
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
+	/* Get the rpmsg-eth child node */
+	rpmsg_eth_node = of_get_child_by_name(np, "rpmsg-eth");
+	if (!rpmsg_eth_node) {
+		dev_err(common->dev, "Couldn't get rpmsg-eth node from np\n");
+		return -ENODEV;
+	}
+
+	/* Parse the memory-region phandle */
+	rmem_np = of_parse_phandle(rpmsg_eth_node, "memory-region", 0);
+	of_node_put(rpmsg_eth_node);
+	if (!rmem_np)
+		return -EINVAL;
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
+static struct rpmsg_device_id rpmsg_eth_rpmsg_id_table[] = {
+	{ .name = "shm-eth" },
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, rpmsg_eth_rpmsg_id_table);
+
+static struct rpmsg_driver rpmsg_eth_rpmsg_client = {
+	.drv.name = KBUILD_MODNAME,
+	.id_table = rpmsg_eth_rpmsg_id_table,
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
index 000000000000..12be1c35eff8
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -0,0 +1,75 @@
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
+ * struct rpmsg_eth_common - common structure for RPMSG Ethernet
+ * @rpdev: RPMSG device
+ * @port: Ethernet port
+ * @dev: Device
+ */
+struct rpmsg_eth_common {
+	struct rpmsg_device *rpdev;
+	struct rpmsg_eth_port *port;
+	struct device *dev;
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


