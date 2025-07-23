Return-Path: <netdev+bounces-209252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F853B0ECB9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A3B1AA1E46
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADCB283130;
	Wed, 23 Jul 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zFch3yMt"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7A28136E;
	Wed, 23 Jul 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257862; cv=none; b=BEQ11vvxbX7ej0Zzy9FfkxDtQ7ASkGQO/Fny7jVpjEQQK8nC8T8xDZusRWmx8fHI5dO/18WdWBh5Hv+qhXiKNm0XTSv8uhky2WyCgxkzDLd362TnNJoKksOp7uu4OY+67AskpGLQx4sr74N9F6vjy7FUIK4EU3QwhZqbu0D0Wl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257862; c=relaxed/simple;
	bh=xGTQ2WxSwNbRChqdoLcpbr1XSoWncCwPF77/rQ5wj+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=txhA7urblbD5qm9wqc+v10Pf5PtZAUvPp/Y+mt8fpXCHHsIRPhuEvWtpArNrRIHppPRK4Thv/ofEnM5H26/GyY3O8JvzopYDmCJdbgt57dVvybaPSSRwY3BDrXLHaMLoqToCjhmI1GUrOro3XHKOFsYge+ERNxNdoXZkr0Xy63Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zFch3yMt; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56N83Xpw1231534;
	Wed, 23 Jul 2025 03:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753257813;
	bh=HKrrFVQiYMI4gsrlFoRJ16NAJ6J7Bacvcx8aV6fKN6I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zFch3yMtIBW2qOCqN/reQ+EXjwibCOyMFU7eYuoVfcGpyX4PBugmQiSw5nQaPmF3B
	 7Il96yp/zZ+v2nu2cd51Y79jIFqU7IumvQc2Ej1/8yGUpvR+AIjaLgMOKSFbX17FAP
	 qBZGzHZFtyPv8MJPY+lKGXFGxKXqcBOU6KuSWgr0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56N83Wvg1619119
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 23 Jul 2025 03:03:32 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 23
 Jul 2025 03:03:32 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 23 Jul 2025 03:03:32 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56N83WDN072253;
	Wed, 23 Jul 2025 03:03:32 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 56N83VQZ015951;
	Wed, 23 Jul 2025 03:03:31 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Mengyuan Lou
	<mengyuanlou@net-swift.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/5] net: rpmsg-eth: Add basic rpmsg skeleton
Date: Wed, 23 Jul 2025 13:33:19 +0530
Message-ID: <20250723080322.3047826-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723080322.3047826-1-danishanwar@ti.com>
References: <20250723080322.3047826-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This patch introduces a basic RPMSG Ethernet driver skeleton. It adds
support for creating virtual Ethernet devices over RPMSG channels,
allowing user-space programs to send and receive messages using a
standard Ethernet protocol. The driver includes message handling,
probe, and remove functions, along with necessary data structures.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/Kconfig     |  10 +++
 drivers/net/ethernet/Makefile    |   1 +
 drivers/net/ethernet/rpmsg_eth.c | 128 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/rpmsg_eth.h |  75 ++++++++++++++++++
 4 files changed, 214 insertions(+)
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
index 000000000000..9a51619f9313
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+/* RPMsg Based Virtual Ethernet Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/of.h>
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
+ * rpmsg_eth_get_shm_info - Get shared memory info from device tree
+ * @common: Pointer to rpmsg_eth_common structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int rpmsg_eth_get_shm_info(struct rpmsg_eth_common *common)
+{
+	struct device_node *peer;
+	const __be32 *reg;
+	u64 start_address;
+	int prop_size;
+	int reg_len;
+	u64 size;
+
+	peer = of_find_node_by_name(NULL, "virtual-eth-shm");
+	if (!peer) {
+		dev_err(common->dev, "Couldn't get shared mem node");
+		return -ENODEV;
+	}
+
+	reg = of_get_property(peer, "reg", &prop_size);
+	if (!reg) {
+		dev_err(common->dev, "Couldn't get reg property");
+		return -ENODEV;
+	}
+
+	reg_len = prop_size / sizeof(u32);
+
+	if (reg_len == 2) {
+		/* 32-bit address space */
+		start_address = be32_to_cpu(reg[0]);
+		size = be32_to_cpu(reg[1]);
+	} else if (reg_len == 4) {
+		/* 64-bit address space */
+		start_address = ((u64)be32_to_cpu(reg[0]) << 32) |
+				 be32_to_cpu(reg[1]);
+		size = ((u64)be32_to_cpu(reg[2]) << 32) |
+			be32_to_cpu(reg[3]);
+	} else {
+		dev_err(common->dev, "Invalid reg_len: %d\n", reg_len);
+		return -EINVAL;
+	}
+
+	common->port->buf_start_addr = start_address;
+	common->port->buf_size = size;
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
+static void rpmsg_eth_rpmsg_remove(struct rpmsg_device *rpdev)
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
+	.remove = rpmsg_eth_rpmsg_remove,
+};
+module_rpmsg_driver(rpmsg_eth_rpmsg_client);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("MD Danish Anwar <danishanwar@ti.com>");
+MODULE_DESCRIPTION("RPMsg Based Virtual Ethernet driver");
diff --git a/drivers/net/ethernet/rpmsg_eth.h b/drivers/net/ethernet/rpmsg_eth.h
new file mode 100644
index 000000000000..56dabd139643
--- /dev/null
+++ b/drivers/net/ethernet/rpmsg_eth.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Texas Instruments K3 Inter Core Virtual Ethernet Driver common header
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
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
+ * @buf_start_addr: Start address of the shared memory buffer for this port
+ * @buf_size: Size (in bytes) of the shared memory buffer for this port
+ */
+struct rpmsg_eth_port {
+	struct rpmsg_eth_common *common;
+	u32 buf_start_addr;
+	u32 buf_size;
+};
+
+#endif /* __RPMSG_ETH_H__ */
-- 
2.34.1


