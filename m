Return-Path: <netdev+bounces-97076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75298C90DC
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA981C213DD
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76172376E5;
	Sat, 18 May 2024 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NVN7ZSZy"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534312E63;
	Sat, 18 May 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036187; cv=none; b=UX+fGi7MbgH8QKwAirgFRHEXdBIWhokUdiRH8JgwqisxKPWV3UAJ29baaVN32U3Q9eTajhntWM6VL5Gp7jUdzpCuv1J1pVfXEWGE9ElFClaRsWdPjNM3RgruqYjbGuOiZZs4ERNAYY4i9tzbSk8CygsLdICNdP0hRM5UD55gwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036187; c=relaxed/simple;
	bh=a1RrRoPKgUMeAZVvSxfDJQCbTiG+xNKv0jTAwceXp/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpL61eGgVsJtq0Yn+eWgdAFVJ3sWJClLQCXCMlEM1XUmAdG6PFZFBb1aYymvxMRPeo5U/c5IvV5dYiz8c+ffN1+dB/VWNb1Gj/xhMHkFPOPzWIWim9RQq5cNI9IDr48+09498NNb8oRQBvUkIrBP6y14p7oWSNuPaL/tmx2RNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NVN7ZSZy; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgr45017243;
	Sat, 18 May 2024 07:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716036173;
	bh=4YVnM9yhpbr1F1sysYDYzoQYJXO4G2Ig3wn60U5nDX0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NVN7ZSZy1L/XG9ILEj3nf/hfI74IbVwXDPwM9ik5J8/gNopf1fGo4RRf0w3Gq+k0B
	 Gk3Olp3Mc6E8gBtHkwb4z328znEIERSWLHnp5SCdRBMvf14+ftSOUO1ukcblivK3Oj
	 hDFOowVdsvv2RU+yBnMsBlOm/1PPr9t3pwHok9w0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44ICgrow003903
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 18 May 2024 07:42:53 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 18
 May 2024 07:42:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 18 May 2024 07:42:53 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44ICgY9J041511;
	Sat, 18 May 2024 07:42:49 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <rogerq@kernel.org>,
        <danishanwar@ti.com>, <vladimir.oltean@nxp.com>
CC: <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <misael.lopez@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH net-next 03/28] net: ethernet: ti: introduce the CPSW Proxy Client
Date: Sat, 18 May 2024 18:12:09 +0530
Message-ID: <20240518124234.2671651-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240518124234.2671651-1-s-vadapalli@ti.com>
References: <20240518124234.2671651-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CPSW Proxy Client driver in Linux communicates with Ethernet
Switch Firmware (EthFw) running on a remote core via RPMsg.
EthFw announces its RPMsg Endpoint over the RPMsg-Bus notifying
its presence to all Clients.

Register the CPSW Proxy Client driver with the RPMsg framework.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/net/ethernet/ti/Kconfig             | 14 +++++
 drivers/net/ethernet/ti/Makefile            |  3 +
 drivers/net/ethernet/ti/cpsw-proxy-client.c | 70 +++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/cpsw-proxy-client.c

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 1729eb0e0b41..ffbfd625625d 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -79,6 +79,20 @@ config TI_CPSW_SWITCHDEV
 	  To compile this driver as a module, choose M here: the module
 	  will be called cpsw_new.
 
+config TI_CPSW_PROXY_CLIENT
+	tristate "TI CPSW Proxy Client"
+	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
+	help
+		This driver supports Ethernet functionality for CPSWnG
+		Ethernet Subsystem which is configured by Ethernet Switch
+		Firmware (EthFw).
+
+		The Ethernet Switch Firmware acts as a proxy to the Linux
+		Client driver by performing all the necessary configuration
+		of the CPSW Peripheral while enabling network data transfer
+		to/from the Linux Client to CPSW over the allocated TX DMA
+		Channels and RX DMA Flows.
+
 config TI_CPTS
 	tristate "TI Common Platform Time Sync (CPTS) Support"
 	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6e086b4c0384..229b828f099e 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -7,6 +7,9 @@ obj-$(CONFIG_TI_CPSW) += cpsw-common.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
 obj-$(CONFIG_TI_CPSW_SWITCHDEV) += cpsw-common.o
 
+obj-$(CONFIG_TI_CPSW_PROXY_CLIENT) += ti-cpsw-proxy-client.o
+ti-cpsw-proxy-client-y := cpsw-proxy-client.o
+
 obj-$(CONFIG_TLAN) += tlan.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
diff --git a/drivers/net/ethernet/ti/cpsw-proxy-client.c b/drivers/net/ethernet/ti/cpsw-proxy-client.c
new file mode 100644
index 000000000000..91d3338b3788
--- /dev/null
+++ b/drivers/net/ethernet/ti/cpsw-proxy-client.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only or MIT
+/* Texas Instruments CPSW Proxy Client Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rpmsg.h>
+
+#include "ethfw_abi.h"
+
+struct cpsw_proxy_priv {
+	struct rpmsg_device		*rpdev;
+	struct device			*dev;
+};
+
+static int cpsw_proxy_client_cb(struct rpmsg_device *rpdev, void *data,
+				int len, void *priv, u32 src)
+{
+	struct device *dev = &rpdev->dev;
+
+	dev_dbg(dev, "callback invoked\n");
+
+	return 0;
+}
+
+static int cpsw_proxy_client_probe(struct rpmsg_device *rpdev)
+{
+	struct cpsw_proxy_priv *proxy_priv;
+
+	proxy_priv = devm_kzalloc(&rpdev->dev, sizeof(struct cpsw_proxy_priv), GFP_KERNEL);
+	if (!proxy_priv)
+		return -ENOMEM;
+
+	proxy_priv->rpdev = rpdev;
+	proxy_priv->dev = &rpdev->dev;
+	dev_dbg(proxy_priv->dev, "driver probed\n");
+
+	return 0;
+}
+
+static void cpsw_proxy_client_remove(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+
+	dev_dbg(dev, "driver removed\n");
+}
+
+static struct rpmsg_device_id cpsw_proxy_client_id_table[] = {
+	{
+		.name = ETHFW_SERVICE_EP_NAME,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, cpsw_proxy_client_id_table);
+
+static struct rpmsg_driver cpsw_proxy_client_driver = {
+	.drv.name	= KBUILD_MODNAME,
+	.id_table	= cpsw_proxy_client_id_table,
+	.probe		= cpsw_proxy_client_probe,
+	.callback	= cpsw_proxy_client_cb,
+	.remove		= cpsw_proxy_client_remove,
+};
+module_rpmsg_driver(cpsw_proxy_client_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CPSW Proxy Client Driver");
+MODULE_AUTHOR("Siddharth Vadapalli <s-vadapalli@ti.com>");
-- 
2.40.1


