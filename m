Return-Path: <netdev+bounces-99653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD828D5A99
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 08:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAEF1C2156E
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC998060D;
	Fri, 31 May 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nx4x3fFg"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F87FBCF;
	Fri, 31 May 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717137637; cv=none; b=Q7z3EspruO3EKN9N2QPFnkT4i0MtUE18qqp+wKcNKdr/wkDP9262Gbe5mUMsZJzAdiJQ1wGXCNZ6pTlZH/PBNBm7bTeMjWDMeX73YNZoorK5UAN3Wl8C6wvGIzkJbBf6JyUFtPPAW56I32CuGd2GqvVYPvkXvczXdyNlyFX6NZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717137637; c=relaxed/simple;
	bh=DXzjNM5rd7AToLRZQUV105ZOZYuh0YhBAkgkhkvc5XE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfX7p2xPqxNomgmdwQBoKJuClsxBkYdSLkHpjsBv/1GPgI7PXrUVf+9Me1q/E0l+OMP5UnCAChDeH5h/cGwNrZgp/7zLUCLarkT8VsC69U+/V4RYdMsz0ty35wbn+fDoTy+mFrxvZAur1Bb/A7oCq1iCOf67+7M/sSmgA2sor58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nx4x3fFg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eBtk014178;
	Fri, 31 May 2024 01:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717137611;
	bh=hGu2VXsFQDrK+BQT5GD5iaSQUyDm83ze2KDc3Oe6xCA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nx4x3fFgDHo01TIjbp4EK10yeXXpHe8ZKihzIOqaHCccFns99GXnnJAiUb5humDr1
	 f1bt4c1E22bglSew9XMjaZ8LsYYGMU32R0UdHP8fpvGWd6VtufR+pSgjgg/ABBppkU
	 2aOAWi/YfC8kFRzB1a6CG0nBG2RIyhAmms9/w9Dc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V6eBTX007622
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 01:40:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 31
 May 2024 01:40:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 31 May 2024 01:40:10 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V6eAF5086051;
	Fri, 31 May 2024 01:40:10 -0500
Received: from localhost (linux-team-01.dhcp.ti.com [172.24.227.57])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V6e901010385;
	Fri, 31 May 2024 01:40:10 -0500
From: Yojana Mallik <y-mallik@ti.com>
To: <y-mallik@ti.com>, <schnelle@linux.ibm.com>,
        <wsa+renesas@sang-engineering.com>, <diogo.ivo@siemens.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>, <vigneshr@ti.com>,
        <rogerq@ti.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <rogerq@kernel.org>
Subject: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared memory ethernet driver
Date: Fri, 31 May 2024 12:10:04 +0530
Message-ID: <20240531064006.1223417-2-y-mallik@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240531064006.1223417-1-y-mallik@ti.com>
References: <20240531064006.1223417-1-y-mallik@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

TI's K3 SoCs comprises heterogeneous processors (Cortex A, Cortex R).
When the ethernet controller is completely managed by a core (Cortex R)
running a flavor of RTOS, in a non virtualized environment, network traffic
tunnelling between heterogeneous processors can be realized by means of
RPMsg based shared memory ethernet driver. With the shared memory used
for the data plane and the RPMsg end point channel used for control plane.

inter-core-virt-eth driver is modelled as a RPMsg based shared
memory ethernet driver for such an use case.

As a first step, register the inter-core-virt-eth as a RPMsg driver.
And introduce basic control messages for querying and responding.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Yojana Mallik <y-mallik@ti.com>
---
 drivers/net/ethernet/ti/Kconfig               |  9 +++
 drivers/net/ethernet/ti/Makefile              |  1 +
 drivers/net/ethernet/ti/icve_rpmsg_common.h   | 47 +++++++++++
 drivers/net/ethernet/ti/inter_core_virt_eth.c | 81 +++++++++++++++++++
 drivers/net/ethernet/ti/inter_core_virt_eth.h | 27 +++++++
 5 files changed, 165 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icve_rpmsg_common.h
 create mode 100644 drivers/net/ethernet/ti/inter_core_virt_eth.c
 create mode 100644 drivers/net/ethernet/ti/inter_core_virt_eth.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 1729eb0e0b41..4f00cb8fe9f1 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -145,6 +145,15 @@ config TI_AM65_CPSW_QOS
 	  The EST scheduler runs on CPTS and the TAS/EST schedule is
 	  updated in the Fetch RAM memory of the CPSW.
 
+config TI_K3_INTERCORE_VIRT_ETH
+	tristate "TI K3 Intercore Virtual Ethernet driver"
+	help
+	  This driver provides intercore virtual ethernet driver
+	  capability.Intercore Virtual Ethernet driver is modelled as
+	  a RPMsg based shared memory ethernet driver for network traffic
+	  tunnelling between heterogeneous processors Cortex A and Cortex R
+	  used in TI's K3 SoCs.
+
 config TI_KEYSTONE_NETCP
 	tristate "TI Keystone NETCP Core Support"
 	select TI_DAVINCI_MDIO
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 6e086b4c0384..24b14ca73407 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -49,3 +49,4 @@ icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o \
 		      icssg/icssg_stats.o \
 		      icssg/icssg_ethtool.o
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
+obj-$(CONFIG_TI_K3_INTERCORE_VIRT_ETH) += inter_core_virt_eth.o
diff --git a/drivers/net/ethernet/ti/icve_rpmsg_common.h b/drivers/net/ethernet/ti/icve_rpmsg_common.h
new file mode 100644
index 000000000000..7cd157479d4d
--- /dev/null
+++ b/drivers/net/ethernet/ti/icve_rpmsg_common.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Texas Instruments K3 Inter Core Virtual Ethernet Driver common header
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ICVE_RPMSG_COMMON_H__
+#define __ICVE_RPMSG_COMMON_H__
+
+#include <linux/if_ether.h>
+
+enum icve_msg_type {
+	ICVE_REQUEST_MSG = 0,
+	ICVE_RESPONSE_MSG,
+	ICVE_NOTIFY_MSG,
+};
+
+struct request_message {
+	u32 type; /* Request Type */
+	u32 id;	  /* Request ID */
+} __packed;
+
+struct response_message {
+	u32 type;	/* Response Type */
+	u32 id;		/* Response ID */
+} __packed;
+
+struct notify_message {
+	u32 type;	/* Notify Type */
+	u32 id;		/* Notify ID */
+} __packed;
+
+struct message_header {
+	u32 src_id;
+	u32 msg_type; /* Do not use enum type, as enum size is compiler dependent */
+} __packed;
+
+struct message {
+	struct message_header msg_hdr;
+	union {
+		struct request_message req_msg;
+		struct response_message resp_msg;
+		struct notify_message notify_msg;
+	};
+} __packed;
+
+#endif /* __ICVE_RPMSG_COMMON_H__ */
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.c b/drivers/net/ethernet/ti/inter_core_virt_eth.c
new file mode 100644
index 000000000000..bea822d2373a
--- /dev/null
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments K3 Inter Core Virtual Ethernet Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "inter_core_virt_eth.h"
+
+static int icve_rpmsg_cb(struct rpmsg_device *rpdev, void *data, int len,
+			 void *priv, u32 src)
+{
+	struct icve_common *common = dev_get_drvdata(&rpdev->dev);
+	struct message *msg = (struct message *)data;
+	u32 msg_type = msg->msg_hdr.msg_type;
+	u32 rpmsg_type;
+
+	switch (msg_type) {
+	case ICVE_REQUEST_MSG:
+		rpmsg_type = msg->req_msg.type;
+		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
+			msg_type, rpmsg_type);
+		break;
+	case ICVE_RESPONSE_MSG:
+		rpmsg_type = msg->resp_msg.type;
+		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
+			msg_type, rpmsg_type);
+		break;
+	case ICVE_NOTIFY_MSG:
+		rpmsg_type = msg->notify_msg.type;
+		dev_dbg(common->dev, "Msg type = %d; RPMsg type = %d\n",
+			msg_type, rpmsg_type);
+		break;
+	default:
+		dev_err(common->dev, "Invalid msg type\n");
+		break;
+	}
+	return 0;
+}
+
+static int icve_rpmsg_probe(struct rpmsg_device *rpdev)
+{
+	struct device *dev = &rpdev->dev;
+	struct icve_common *common;
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
+	return 0;
+}
+
+static void icve_rpmsg_remove(struct rpmsg_device *rpdev)
+{
+	dev_info(&rpdev->dev, "icve rpmsg client driver is removed\n");
+}
+
+static struct rpmsg_device_id icve_rpmsg_id_table[] = {
+	{ .name = "ti.icve" },
+	{},
+};
+MODULE_DEVICE_TABLE(rpmsg, icve_rpmsg_id_table);
+
+static struct rpmsg_driver icve_rpmsg_client = {
+	.drv.name = KBUILD_MODNAME,
+	.id_table = icve_rpmsg_id_table,
+	.probe = icve_rpmsg_probe,
+	.callback = icve_rpmsg_cb,
+	.remove = icve_rpmsg_remove,
+};
+module_rpmsg_driver(icve_rpmsg_client);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Siddharth Vadapalli <s-vadapalli@ti.com>");
+MODULE_AUTHOR("Ravi Gunasekaran <r-gunasekaran@ti.com");
+MODULE_DESCRIPTION("TI Inter Core Virtual Ethernet driver");
diff --git a/drivers/net/ethernet/ti/inter_core_virt_eth.h b/drivers/net/ethernet/ti/inter_core_virt_eth.h
new file mode 100644
index 000000000000..91a3aba96996
--- /dev/null
+++ b/drivers/net/ethernet/ti/inter_core_virt_eth.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Texas Instruments K3 Inter Core Virtual Ethernet Driver
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __INTER_CORE_VIRT_ETH_H__
+#define __INTER_CORE_VIRT_ETH_H__
+
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rpmsg.h>
+#include "icve_rpmsg_common.h"
+
+struct icve_port {
+	struct icve_common *common;
+} __packed;
+
+struct icve_common {
+	struct rpmsg_device *rpdev;
+	struct icve_port *port;
+	struct device *dev;
+} __packed;
+
+#endif /* __INTER_CORE_VIRT_ETH_H__ */
-- 
2.40.1


