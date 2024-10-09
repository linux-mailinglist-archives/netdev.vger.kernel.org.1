Return-Path: <netdev+bounces-133449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA47995F10
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F0F1C238F5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 05:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3A616EBE9;
	Wed,  9 Oct 2024 05:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zyAnyuWB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926216D9DF;
	Wed,  9 Oct 2024 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728452423; cv=fail; b=JByDH7z4jP1GCdMqn09izLOak4e8DlrCB6bQdwVWS3PPYKnU2MmfB7YuiPEKhZ00Y5j1MnNN/J27BBdPYQzS7qmyg0Lz4YgFi4+GrhSQAvOPlvXCGkM/aucPpY/KjiMcl2uS/n2Stz5uxnNjgbpzl2zPMgsDApBW47byDMoPkKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728452423; c=relaxed/simple;
	bh=h65GPFoHy3K35Hcq1NlV2adpWtqDfOBloob6x1IWmQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbEj8FYGqgdLq5sbRemtV10UdRaeRF3+/fe+tA1wFMCsfyjpf2lJfq11U5Ed7vNBucr12tn0Nhke/svCwX4j+bl4BTT9IFuKL/px3MZ7qr0GA9v6L6jIbrKJNxL3nEpVw2vtStOG/rgU5oJ5GS7CQVJPlkRbXg9mtsdaEwkjuqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zyAnyuWB; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET2PIDKLWeBKUlNmuy0cCUPf2VZn6CEPj32RUFaTvP+4Bg/+ZuT42DGBnEACao5oNLBxG09TbtzQAhGAtXF1or2eL69uQoOWCHro5gcKXnACqQuSGJz7Nlsn6VtY2plEZegPZgdjl0R2d2xPWNykEoJIRhD6ZWYAbHd8drESesvcStfjI0uSoLLto4CiWNFzg7l3hUvJ3bhnWS/G3wCb+xLiJBJyQimAjw5ETIew8Q8d43uNYpuZIBCBGwZlmpDRQb9N3RuF5nDEMZE+IQOQ0cu+mUAPbpmSCta8N/H+PXLQ1FGm8HcscPZCQLEnLC1qkV9NEZaWOSdxe5HuRRRsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af07Pp4nY4LDf+fuaiHzGvP5U2695RdA3KVAArfvLQM=;
 b=Nr7ixRbTmIDzd9L8/+tjJ7HT09u6LDiYOE0pY19xGCXTz+ddX4RH3Jmxiu8yCO0T4TbnyPFXhEKQeOUEz0ooAmu1jrDehq16jI78kN3i6w7Yf6HbgMI0PK6IWVk0/mjfjB8VWpq+x1aQ+DZFrRbujt16FUlJg5QzbNkTHS/qCXoL0lhYzyTWmJVfV2bwbGIy5YywKM6HGUIN4/nP4MARxRw0WmgSAPXq8RHRyUQ1vV5bZsUBCILSyt/XBBp5QV5g7mep6fYNauEIVB+WcMQRfaZunJuFs1vZQtElH6IEONRD9tviVZvzRPeKEChVWtuO0mDNty3CM8wZOdq1kLmwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af07Pp4nY4LDf+fuaiHzGvP5U2695RdA3KVAArfvLQM=;
 b=zyAnyuWBnn6aOHzi4zGWNmwuNiRNEshWSG6n8NDAihyxgGAeyHjj7laemkOIaVi54L+0y8Qm8e2wRaUJ2tAjdhZtrKZ+tUh7y+X6Q+4kCLw1Xq4qBD2cesUjE9kgz584k3k2kRYfZPQaf7cOVTHJUgUO6ZuWS9fUqh5ZdxTl/i8=
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 05:40:14 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::b9) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Wed, 9 Oct 2024 05:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 05:40:13 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 00:40:11 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Oct 2024 00:40:07 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac for given speed.
Date: Wed, 9 Oct 2024 11:09:45 +0530
Message-ID: <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d0c577-ee81-4e66-6dcd-08dce824d91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3ud4zo9WP19Ay8W+Hb7Mi74Kyyl/0iqC44MblYnrAWlFKXAvFVpOuNAxhdD?=
 =?us-ascii?Q?SxD0EGkvK3DM/MWh5LVSzZ09DYnzkzSLUeRNu3gbtFymuMldpEeIAVg2AzUp?=
 =?us-ascii?Q?ElzfyPnpc8EyepzHs/8jfPhNSiCSAoYCpi2+9zufsaCgyJH8DDfw4FodU8g7?=
 =?us-ascii?Q?9oFlG5NgwRlhqYbfp/pI8rC8Yl2iuJSVQDcfOGymoTdnlak/cxGsskHZ1pT8?=
 =?us-ascii?Q?gs/GE/XMoe1eycCqcEsBwx1sxUWu6vVtAzQYcRqz+zDBXI5RNqvgsABt0gDB?=
 =?us-ascii?Q?7Xa155s0KKIvVtKfzDRnYcQXGj/9+v3T9v9deHA+d8SYYjm/JVgRNR+IjtZ0?=
 =?us-ascii?Q?2LsIv2NLxI3TMivJjm+OnAK16Xvdij2FaBzBFBeu39IQWJ/3/FAEfkKZThrN?=
 =?us-ascii?Q?iYKZh4xI37lXipbZv652BAmZLSqugd4+KaHod1u6SXFmz9VHOiN+am5glC/a?=
 =?us-ascii?Q?EKnAEuFxHGVn2r1uNQ9QIcW08TDNYY6xblJp4w2N+pfrZB0BYuo7ZsOHKfKN?=
 =?us-ascii?Q?vncaNZVFLkvgwA03WhyIzxECE2ZIlRFzX1AUMEAoLP8yleqoGlyT/g6lWkV4?=
 =?us-ascii?Q?41ynOT2CaOClNcm39WidzBB1teo30qV6FT4JnYSK6JEoxTfPdFpXpiPPeO5F?=
 =?us-ascii?Q?lr20k8Z/anhp9JFy9BPOl5rQMOR752UL/vvJa+zqpVG3xOY2XAWCmWd75Ytz?=
 =?us-ascii?Q?sOzaBqwmWMaigXEDnt9bvWncp2SnKyQd0lwp+p1YyxG+6NkKYiHYfXAFnffw?=
 =?us-ascii?Q?cCMld5MSCVPw3QLMVP9QB4owvi1GoU7jpzBFoHA76RtSIGXoSmGBEDRDCqlV?=
 =?us-ascii?Q?IVE9ZoWaG3kI7MXEIHIb1amkTKr6XcDuT5UEg5RkW1Q38xUxViEo6MmVdlzZ?=
 =?us-ascii?Q?TT1qlR8GzOJMpaOx/UtWZr9yWWETeqq/lKDQKjVZDJVGgQxsW7cVigUlYD/p?=
 =?us-ascii?Q?rjgMKVV9qU2DsX+80X5BjQBSEDt3I+USTyIHsbQvg15EkjPz1KSKey4/LPdu?=
 =?us-ascii?Q?qSoxmxdd7HZkeAgOQVn030++ZVk3hn9IRG4uRTXVWtvjguozKCu4uayHDR2e?=
 =?us-ascii?Q?t+otzlkArkAyRKL/ZvxvTw6jKgWqZlA3n2wtqfmuhhLbtoopRSeUVfQqRkh8?=
 =?us-ascii?Q?dd0TWwpg8DkVtwC02fztlAUQ1veSX1WX6+jWVmllSBN2Kiw6kwaxkPY93+S2?=
 =?us-ascii?Q?8q03dNwDytpS1QuNTdC2IWBfM44ntJ8gkSy0WpnYBoSQYOJp3WgZbDPJQsPj?=
 =?us-ascii?Q?1sFhIY7C/VjUVfewK6xtnBZWBdxlj8AoT6OH5yy6KpNC3QO/DgHKa28s+rP4?=
 =?us-ascii?Q?m0YNL7Qtm66oxIMHYOmVaYkWP5AZovGz6KIVQaWpmSVaeSrUhKkHyXzxbyoy?=
 =?us-ascii?Q?2Xfoi7jCJup7eDkmmtHKo7JmYyz7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 05:40:13.7543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d0c577-ee81-4e66-6dcd-08dce824d91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739

HS Mac configuration steps:
- Configure speed and serdes rate bits of USX_CONTROL register from
  user specified speed in the device-tree.
- Enable HS Mac for 5G and 10G speeds.
- Reset RX receive path to achieve USX block lock for the
  configured serdes rate.
- Wait for USX block lock synchronization.

Move the initialization instances to macb_usx_pcs_link_up().

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 57 ++++++++++++++++++++----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 47e80fa72865..ed4edeac3a59 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -825,6 +825,7 @@
 	})
 
 #define MACB_READ_NSR(bp)	macb_readl(bp, NSR)
+#define MACB_READ_USX_STATUS(bp)	gem_readl(bp, USX_STATUS)
 
 /* struct macb_dma_desc - Hardware DMA descriptor
  * @addr: DMA address of data buffer
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3f9dc0b037c0..7beb775a0bd7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -94,6 +94,7 @@ struct sifive_fu540_macb_mgmt {
 #define MACB_PM_TIMEOUT  100 /* ms */
 
 #define MACB_MDIO_TIMEOUT	1000000 /* in usecs */
+#define GEM_SYNC_TIMEOUT	2500000 /* in usecs */
 
 /* DMA buffer descriptor might be different size
  * depends on hardware configuration:
@@ -564,14 +565,59 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 				 int duplex)
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
-	u32 config;
+	u32 speed_val, serdes_rate, config;
+	bool hs_mac = false;
+
+	switch (speed) {
+	case SPEED_1000:
+		speed_val = HS_SPEED_1000M;
+		serdes_rate = MACB_SERDES_RATE_1G;
+		break;
+	case SPEED_2500:
+		speed_val = HS_SPEED_2500M;
+		serdes_rate = MACB_SERDES_RATE_2_5G;
+		break;
+	case SPEED_5000:
+		speed_val = HS_SPEED_5000M;
+		serdes_rate = MACB_SERDES_RATE_5G;
+		hs_mac = true;
+		break;
+	case SPEED_10000:
+		speed_val = HS_SPEED_10000M;
+		serdes_rate = MACB_SERDES_RATE_10G;
+		hs_mac = true;
+		break;
+	default:
+		netdev_err(bp->dev, "Specified speed not supported\n");
+		return;
+	}
+
+	/* Enable HS MAC for high speeds */
+	if (hs_mac) {
+		config = macb_or_gem_readl(bp, NCR);
+		config |= GEM_BIT(ENABLE_HS_MAC);
+		macb_or_gem_writel(bp, NCR, config);
+	}
+
+	/* Configure HS MAC for specified speed */
+	config = gem_readl(bp, HS_MAC_CONFIG);
+	config = GEM_BFINS(HS_MAC_SPEED, speed_val, config);
+	gem_writel(bp, HS_MAC_CONFIG, config);
 
 	config = gem_readl(bp, USX_CONTROL);
-	config = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, config);
-	config = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, config);
+	config = GEM_BFINS(SERDES_RATE, serdes_rate, config);
+	config = GEM_BFINS(USX_CTRL_SPEED, speed_val, config);
 	config &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
+	config |= GEM_BIT(RX_SYNC_RESET);
+	gem_writel(bp, USX_CONTROL, config);
+	mdelay(250);
+	config &= ~GEM_BIT(RX_SYNC_RESET);
 	config |= GEM_BIT(TX_EN);
 	gem_writel(bp, USX_CONTROL, config);
+
+	if (readx_poll_timeout(MACB_READ_USX_STATUS, bp, config, config & GEM_BIT(USX_BLOCK_LOCK),
+			       1, GEM_SYNC_TIMEOUT))
+		netdev_err(bp->dev, "USX PCS block lock not achieved\n");
 }
 
 static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
@@ -662,7 +708,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
 		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
 			ctrl |= GEM_BIT(PCSSEL);
-			ncr |= GEM_BIT(ENABLE_HS_MAC);
 		} else if (bp->caps & MACB_CAPS_MIIONRGMII &&
 			   bp->phy_interface == PHY_INTERFACE_MODE_MII) {
 			ncr |= MACB_BIT(MIIONRGMII);
@@ -766,10 +811,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	macb_or_gem_writel(bp, NCFGR, ctrl);
 
-	if (bp->phy_interface == PHY_INTERFACE_MODE_10GBASER)
-		gem_writel(bp, HS_MAC_CONFIG, GEM_BFINS(HS_MAC_SPEED, HS_SPEED_10000M,
-							gem_readl(bp, HS_MAC_CONFIG)));
-
 	spin_unlock_irqrestore(&bp->lock, flags);
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
-- 
2.34.1


