Return-Path: <netdev+bounces-212925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE8BB228CB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA807A629D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CE6286D46;
	Tue, 12 Aug 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="oJSQMTfz"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4127FD78;
	Tue, 12 Aug 2025 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005788; cv=none; b=ofnx7BurbyoaoM+8fOFImLfEtl7ns47d/Ed6yaRKJstK85iXzKgmE3KqAWH8KdWdZxJpvY7CP+fS145AQsjmeqOyPZ8ITPFzMC2y/GX5tlz9NLMSHSKZ4ktZgeXtuVI35L1fiKdfjZKj44z6YxnLWYP1B2VPp9dXg2nPgIsot0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005788; c=relaxed/simple;
	bh=AV8UhEmPfGL5WmmoyqJ6ph9Y5SpBzM6XGhmi3c5l6ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+Iedimr5K92Uo+17thuEtf5E5LCoDPyJFHeKcG+q8P/E3sonDSlnJ8ahA1mF1ZKQHLqaNHAQx6LO3kBmbv+4fgfIBWDahpoapxpX7VtygiUMV33X/9fYqZF5m3CuwLOyYwM4uyrBheDQYUG2HZxQUH/lJkJZb4w35Xj3ZeLEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=oJSQMTfz; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WfkiJNYRwldY0DUamFobsqzytCdo8qnO6SEvpVJHBGY=; b=oJSQMTfzE+tZoEVCIazAy8mEtn
	3C1r1e5ksgY2JZoGs8hYGp2mmUEwFrjAlJaiP+BppXJGwc80Zu1xtC8mk8q2YOe+Wvh7R39jHojOj
	lKAzGwLJbcEvqPeFM69GtENqxUn4I4U362lvkXbbyMRx7m5VDTdEy9pSWN0UeijLKBM10CLZNnvQa
	SbmAt+sJ956Abhq94+5gemH08NOgKpNjq+fGMHl0QtUa+ACpPTgL0IpE22fkTtzlrNBsUQQtkvfa1
	on9uxe4t0peoIpxnHZ01/aDYPykncLHKA1h3OxZh0bQU67yd68iJn3tC2txF4Ak8IFr4S1HxHzsH+
	nwUUy+Ug==;
Received: from [122.175.9.182] (port=41656 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1ulpAp-00000008c64-3qkY;
	Tue, 12 Aug 2025 09:36:21 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ssantosh@kernel.org,
	richardcochran@gmail.com,
	m-malladi@ti.com,
	s.hauer@pengutronix.de,
	afd@ti.com,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	johan@kernel.org,
	m-karicheri2@ti.com,
	s-anna@ti.com,
	glaroque@baylibre.com,
	saikrishnag@marvell.com,
	kory.maincent@bootlin.com,
	diogo.ivo@siemens.com,
	javier.carrasco.cruz@gmail.com,
	basharath@couthit.com,
	parvathi@couthit.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	alok.a.tiwari@oracle.com,
	bastien.curutchet@bootlin.com,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	pmohan@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v13 5/5] net: ti: prueth: Adds IEP support for PRUETH on AM33x, AM43x and AM57x SOCs
Date: Tue, 12 Aug 2025 19:04:20 +0530
Message-ID: <20250812133534.4119053-6-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812110723.4116929-1-parvathi@couthit.com>
References: <20250812110723.4116929-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Added API hooks for IEP module (legacy 32-bit model) to support
timestamping requests from application.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c      | 101 ++++++++++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  74 ++++++++++++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   2 +
 .../net/ethernet/ti/icssm/icssm_prueth_ptp.h  |  85 +++++++++++++++
 4 files changed, 260 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 50bfbc2779e4..6dd801a01d43 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -981,11 +981,112 @@ static const struct icss_iep_plat_data am654_icss_iep_plat_data = {
 	.config = &am654_icss_iep_regmap_config,
 };
 
+static const struct icss_iep_plat_data am57xx_icss_iep_plat_data = {
+	.flags = ICSS_IEP_64BIT_COUNTER_SUPPORT |
+		 ICSS_IEP_SLOW_COMPEN_REG_SUPPORT,
+	.reg_offs = {
+		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
+		[ICSS_IEP_COMPEN_REG] = 0x08,
+		[ICSS_IEP_SLOW_COMPEN_REG] = 0x0c,
+		[ICSS_IEP_COUNT_REG0] = 0x10,
+		[ICSS_IEP_COUNT_REG1] = 0x14,
+		[ICSS_IEP_CAPTURE_CFG_REG] = 0x18,
+		[ICSS_IEP_CAPTURE_STAT_REG] = 0x1c,
+
+		[ICSS_IEP_CAP6_RISE_REG0] = 0x50,
+		[ICSS_IEP_CAP6_RISE_REG1] = 0x54,
+
+		[ICSS_IEP_CAP7_RISE_REG0] = 0x60,
+		[ICSS_IEP_CAP7_RISE_REG1] = 0x64,
+
+		[ICSS_IEP_CMP_CFG_REG] = 0x70,
+		[ICSS_IEP_CMP_STAT_REG] = 0x74,
+		[ICSS_IEP_CMP0_REG0] = 0x78,
+		[ICSS_IEP_CMP0_REG1] = 0x7c,
+		[ICSS_IEP_CMP1_REG0] = 0x80,
+		[ICSS_IEP_CMP1_REG1] = 0x84,
+
+		[ICSS_IEP_CMP8_REG0] = 0xc0,
+		[ICSS_IEP_CMP8_REG1] = 0xc4,
+		[ICSS_IEP_SYNC_CTRL_REG] = 0x180,
+		[ICSS_IEP_SYNC0_STAT_REG] = 0x188,
+		[ICSS_IEP_SYNC1_STAT_REG] = 0x18c,
+		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x190,
+		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x194,
+		[ICSS_IEP_SYNC1_DELAY_REG] = 0x198,
+		[ICSS_IEP_SYNC_START_REG] = 0x19c,
+	},
+	.config = &am654_icss_iep_regmap_config,
+};
+
+static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ICSS_IEP_GLOBAL_CFG_REG ... ICSS_IEP_CAPTURE_STAT_REG:
+	case ICSS_IEP_CAP6_RISE_REG0:
+	case ICSS_IEP_CMP_CFG_REG ... ICSS_IEP_CMP0_REG0:
+	case ICSS_IEP_CMP8_REG0 ... ICSS_IEP_SYNC_START_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config am335x_icss_iep_regmap_config = {
+	.name = "icss iep",
+	.reg_stride = 1,
+	.reg_write = icss_iep_regmap_write,
+	.reg_read = icss_iep_regmap_read,
+	.writeable_reg = am335x_icss_iep_valid_reg,
+	.readable_reg = am335x_icss_iep_valid_reg,
+};
+
+static const struct icss_iep_plat_data am335x_icss_iep_plat_data = {
+	.flags = 0,
+	.reg_offs = {
+		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
+		[ICSS_IEP_COMPEN_REG] = 0x08,
+		[ICSS_IEP_COUNT_REG0] = 0x0c,
+		[ICSS_IEP_CAPTURE_CFG_REG] = 0x10,
+		[ICSS_IEP_CAPTURE_STAT_REG] = 0x14,
+
+		[ICSS_IEP_CAP6_RISE_REG0] = 0x30,
+
+		[ICSS_IEP_CAP7_RISE_REG0] = 0x38,
+
+		[ICSS_IEP_CMP_CFG_REG] = 0x40,
+		[ICSS_IEP_CMP_STAT_REG] = 0x44,
+		[ICSS_IEP_CMP0_REG0] = 0x48,
+
+		[ICSS_IEP_CMP8_REG0] = 0x88,
+		[ICSS_IEP_SYNC_CTRL_REG] = 0x100,
+		[ICSS_IEP_SYNC0_STAT_REG] = 0x108,
+		[ICSS_IEP_SYNC1_STAT_REG] = 0x10c,
+		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x110,
+		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x114,
+		[ICSS_IEP_SYNC1_DELAY_REG] = 0x118,
+		[ICSS_IEP_SYNC_START_REG] = 0x11c,
+	},
+	.config = &am335x_icss_iep_regmap_config,
+};
+
 static const struct of_device_id icss_iep_of_match[] = {
 	{
 		.compatible = "ti,am654-icss-iep",
 		.data = &am654_icss_iep_plat_data,
 	},
+	{
+		.compatible = "ti,am5728-icss-iep",
+		.data = &am57xx_icss_iep_plat_data,
+	},
+	{
+		.compatible = "ti,am4376-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
+	{
+		.compatible = "ti,am3356-icss-iep",
+		.data = &am335x_icss_iep_plat_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, icss_iep_of_match);
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 4bd6697a2bf1..e38789c25260 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -30,6 +30,7 @@
 
 #include "icssm_prueth.h"
 #include "../icssg/icssg_mii_rt.h"
+#include "../icssg/icss_iep.h"
 
 #define OCMC_RAM_SIZE		(SZ_64K)
 
@@ -895,6 +896,48 @@ static int icssm_emac_request_irqs(struct prueth_emac *emac)
 	return ret;
 }
 
+static void icssm_ptp_dram_init(struct prueth_emac *emac)
+{
+	void __iomem *sram = emac->prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	u64 temp64;
+
+	writew(0, sram + MII_RX_CORRECTION_OFFSET);
+	writew(0, sram + MII_TX_CORRECTION_OFFSET);
+
+	/* Initialize RCF to 1 (Linux N/A) */
+	writel(1 * 1024, sram + TIMESYNC_TC_RCF_OFFSET);
+
+	/* This flag will be set and cleared by firmware */
+	/* Write Sync0 period for sync signal generation in PTP
+	 * memory in shared RAM
+	 */
+	writel(200000000 / 50, sram + TIMESYNC_SYNC0_WIDTH_OFFSET);
+
+	/* Write CMP1 period for sync signal generation in PTP
+	 * memory in shared RAM
+	 */
+	temp64 = 1000000;
+	memcpy_toio(sram + TIMESYNC_CMP1_CMP_OFFSET, &temp64, sizeof(temp64));
+
+	/* Write Sync0 period for sync signal generation in PTP
+	 * memory in shared RAM
+	 */
+	writel(1000000, sram + TIMESYNC_CMP1_PERIOD_OFFSET);
+
+	/* Configures domainNumber list. Firmware supports 2 domains */
+	writeb(0, sram + TIMESYNC_DOMAIN_NUMBER_LIST);
+	writeb(0, sram + TIMESYNC_DOMAIN_NUMBER_LIST + 1);
+
+	/* Configure 1-step/2-step */
+	writeb(1, sram + DISABLE_SWITCH_SYNC_RELAY_OFFSET);
+
+	/* Configures the setting to Link local frame without HSR tag */
+	writeb(0, sram + LINK_LOCAL_FRAME_HAS_HSR_TAG);
+
+	/* Enable E2E/UDP PTP message timestamping */
+	writeb(1, sram + PTP_IPV4_UDP_E2E_ENABLE);
+}
+
 /**
  * icssm_emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -917,9 +960,18 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 
 	icssm_prueth_emac_config(emac);
 
+	if (!prueth->emac_configured) {
+		icssm_ptp_dram_init(emac);
+		ret = icss_iep_init(prueth->iep, NULL, NULL, 0);
+		if (ret) {
+			netdev_err(ndev, "Failed to initialize iep: %d\n", ret);
+			goto iep_exit;
+		}
+	}
+
 	ret = icssm_emac_set_boot_pru(emac, ndev);
 	if (ret)
-		return ret;
+		goto iep_exit;
 
 	ret = icssm_emac_request_irqs(emac);
 	if (ret)
@@ -943,6 +995,10 @@ static int icssm_emac_ndo_open(struct net_device *ndev)
 rproc_shutdown:
 	rproc_shutdown(emac->pru);
 
+iep_exit:
+	if (!prueth->emac_configured)
+		icss_iep_exit(prueth->iep);
+
 	return ret;
 }
 
@@ -1436,12 +1492,19 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		}
 	}
 
+	prueth->iep = icss_iep_get(np);
+	if (IS_ERR(prueth->iep)) {
+		ret = PTR_ERR(prueth->iep);
+		dev_err(dev, "unable to get IEP\n");
+		goto netdev_exit;
+	}
+
 	/* register the network devices */
 	if (eth0_node) {
 		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
 		if (ret) {
 			dev_err(dev, "can't register netdev for port MII0");
-			goto netdev_exit;
+			goto iep_put;
 		}
 
 		prueth->registered_netdevs[PRUETH_MAC0] =
@@ -1475,6 +1538,10 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 		unregister_netdev(prueth->registered_netdevs[i]);
 	}
 
+iep_put:
+	icss_iep_put(prueth->iep);
+	prueth->iep = NULL;
+
 netdev_exit:
 	for (i = 0; i < PRUETH_NUM_MACS; i++) {
 		eth_node = prueth->eth_node[i];
@@ -1543,6 +1610,9 @@ static void icssm_prueth_remove(struct platform_device *pdev)
 						 &prueth->mem[i]);
 	}
 
+	icss_iep_put(prueth->iep);
+	prueth->iep = NULL;
+
 	pruss_put(prueth->pruss);
 
 	if (prueth->eth_node[PRUETH_MAC0])
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 6201276986de..c3f9c59ac6ff 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -14,6 +14,7 @@
 #include <linux/remoteproc/pruss.h>
 
 #include "icssm_switch.h"
+#include "icssm_prueth_ptp.h"
 
 /* ICSSM size of redundancy tag */
 #define ICSSM_LRE_TAG_SIZE	6
@@ -231,6 +232,7 @@ struct prueth {
 	struct pruss_mem_region mem[PRUETH_MEM_MAX];
 	struct gen_pool *sram_pool;
 	struct regmap *mii_rt;
+	struct icss_iep *iep;
 
 	const struct prueth_private_data *fw_data;
 	struct prueth_fw_offsets *fw_offsets;
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
new file mode 100644
index 000000000000..e0bf692beda1
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+#ifndef PRUETH_PTP_H
+#define PRUETH_PTP_H
+
+#define RX_SYNC_TIMESTAMP_OFFSET_P1		0x8    /* 8 bytes */
+#define RX_PDELAY_REQ_TIMESTAMP_OFFSET_P1	0x14   /* 12 bytes */
+
+#define DISABLE_PTP_FRAME_FORWARDING_CTRL_OFFSET 0x14	/* 1 byte */
+
+#define RX_PDELAY_RESP_TIMESTAMP_OFFSET_P1	0x20   /* 12 bytes */
+#define RX_SYNC_TIMESTAMP_OFFSET_P2		0x2c   /* 12 bytes */
+#define RX_PDELAY_REQ_TIMESTAMP_OFFSET_P2	0x38   /* 12 bytes */
+#define RX_PDELAY_RESP_TIMESTAMP_OFFSET_P2	0x44   /* 12 bytes */
+#define TIMESYNC_DOMAIN_NUMBER_LIST		0x50   /* 2 bytes */
+#define P1_SMA_LINE_DELAY_OFFSET		0x52   /* 4 bytes */
+#define P2_SMA_LINE_DELAY_OFFSET		0x56   /* 4 bytes */
+#define TIMESYNC_SECONDS_COUNT_OFFSET		0x5a   /* 6 bytes */
+#define TIMESYNC_TC_RCF_OFFSET			0x60   /* 4 bytes */
+#define DUT_IS_MASTER_OFFSET			0x64   /* 1 byte */
+#define MASTER_PORT_NUM_OFFSET			0x65   /* 1 byte */
+#define SYNC_MASTER_MAC_OFFSET			0x66   /* 6 bytes */
+#define TX_TS_NOTIFICATION_OFFSET_SYNC_P1	0x6c   /* 1 byte */
+#define TX_TS_NOTIFICATION_OFFSET_PDEL_REQ_P1	0x6d   /* 1 byte */
+#define TX_TS_NOTIFICATION_OFFSET_PDEL_RES_P1	0x6e   /* 1 byte */
+#define TX_TS_NOTIFICATION_OFFSET_SYNC_P2	0x6f   /* 1 byte */
+#define TX_TS_NOTIFICATION_OFFSET_PDEL_REQ_P2	0x70   /* 1 byte */
+#define TX_TS_NOTIFICATION_OFFSET_PDEL_RES_P2	0x71   /* 1 byte */
+#define TX_SYNC_TIMESTAMP_OFFSET_P1		0x72   /* 12 bytes */
+#define TX_PDELAY_REQ_TIMESTAMP_OFFSET_P1	0x7e   /* 12 bytes */
+#define TX_PDELAY_RESP_TIMESTAMP_OFFSET_P1	0x8a   /* 12 bytes */
+#define TX_SYNC_TIMESTAMP_OFFSET_P2		0x96   /* 12 bytes */
+#define TX_PDELAY_REQ_TIMESTAMP_OFFSET_P2	0xa2   /* 12 bytes */
+#define TX_PDELAY_RESP_TIMESTAMP_OFFSET_P2	0xae   /* 12 bytes */
+#define TIMESYNC_CTRL_VAR_OFFSET		0xba   /* 1 byte */
+#define DISABLE_SWITCH_SYNC_RELAY_OFFSET	0xbb   /* 1 byte */
+#define MII_RX_CORRECTION_OFFSET		0xbc   /* 2 bytes */
+#define MII_TX_CORRECTION_OFFSET		0xbe   /* 2 bytes */
+#define TIMESYNC_CMP1_CMP_OFFSET		0xc0   /* 8 bytes */
+#define TIMESYNC_SYNC0_CMP_OFFSET		0xc8   /* 8 bytes */
+#define TIMESYNC_CMP1_PERIOD_OFFSET		0xd0   /* 4 bytes */
+#define TIMESYNC_SYNC0_WIDTH_OFFSET		0xd4   /* 4 bytes */
+#define SINGLE_STEP_IEP_OFFSET_P1		0xd8   /* 8 bytes */
+#define SINGLE_STEP_SECONDS_OFFSET_P1		0xe0   /* 8 bytes */
+#define SINGLE_STEP_IEP_OFFSET_P2		0xe8   /* 8 bytes */
+#define SINGLE_STEP_SECONDS_OFFSET_P2		0xf0   /* 8 bytes */
+#define LINK_LOCAL_FRAME_HAS_HSR_TAG		0xf8   /* 1 bytes */
+#define PTP_PREV_TX_TIMESTAMP_P1		0xf9  /* 8 bytes */
+#define PTP_PREV_TX_TIMESTAMP_P2		0x101  /* 8 bytes */
+#define PTP_CLK_IDENTITY_OFFSET			0x109  /* 8 bytes */
+#define PTP_SCRATCH_MEM				0x111  /* 16 byte */
+#define PTP_IPV4_UDP_E2E_ENABLE			0x121  /* 1 byte */
+
+enum {
+	PRUETH_PTP_SYNC,
+	PRUETH_PTP_DLY_REQ,
+	PRUETH_PTP_DLY_RESP,
+	PRUETH_PTP_TS_EVENTS,
+};
+
+#define PRUETH_PTP_TS_SIZE		12
+#define PRUETH_PTP_TS_NOTIFY_SIZE	1
+#define PRUETH_PTP_TS_NOTIFY_MASK	0xff
+
+/* Bit definitions for TIMESYNC_CTRL */
+#define TIMESYNC_CTRL_BG_ENABLE    BIT(0)
+#define TIMESYNC_CTRL_FORCED_2STEP BIT(1)
+
+static inline u32 icssm_prueth_tx_ts_offs_get(u8 port, u8 event)
+{
+	return TX_SYNC_TIMESTAMP_OFFSET_P1 + port *
+		PRUETH_PTP_TS_EVENTS * PRUETH_PTP_TS_SIZE +
+		event * PRUETH_PTP_TS_SIZE;
+}
+
+static inline u32 icssm_prueth_tx_ts_notify_offs_get(u8 port, u8 event)
+{
+	return TX_TS_NOTIFICATION_OFFSET_SYNC_P1 +
+		PRUETH_PTP_TS_EVENTS * PRUETH_PTP_TS_NOTIFY_SIZE * port +
+		event * PRUETH_PTP_TS_NOTIFY_SIZE;
+}
+
+#endif /* PRUETH_PTP_H */
-- 
2.43.0


