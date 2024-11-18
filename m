Return-Path: <netdev+bounces-145766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B373F9D0AE0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15AD9B219FC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91099194141;
	Mon, 18 Nov 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g7zId37e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D627A193435;
	Mon, 18 Nov 2024 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918419; cv=fail; b=ZsdfEbBCeRtweL5FNxYjjcp1tSmiFsdAAhgsWmAGIdhHifmnLk1pr34OFgQDWUuUBFcVGWSBZBST4xUD/zo6rnyq6SbqdFmCmb97eR4NtKtYDY9U0dGH2N5LIYf+OftxVZTWzW0sPuizYonibhJSr3zDp8OUv8/efwGBxd6eD0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918419; c=relaxed/simple;
	bh=7bEXhNswk+IB46i5hi3yRQH2rOo2Hq3q29F6gaXasaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZI11Z2xMTLxScHtxmY1hDleXnFbygv3jG6TVo4pYHY9J6WvKqPT4EuH/RnkRElOXHITE8GEn7OwvCtRSCY8PcWVrojAHCqQ662Rd1GVlox1dDW+IT2AR9d36nKON/z8j5eccexiwEaWOwSonywW8clTTP0yWLSfg48++bYqtqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g7zId37e; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL4Zm8RcBeHOOl3jLXMcc+csuXbfenKhVwa7bV81kEASnpE7Nqnh1U+zYWZHkj8v3aO0IjdjeCTGmBZ6O7qUJ3xKQxik9uXuoKVGNbE2TUWzZ6aOynJcLsIAwbWA+VOUoXdTiptWDwBVKRxSZmh+NB1I/P18uOr0Rb2HduHilWv2KHw43fXNjwg7AY8J9TI9ujAKfGA4SHD04U0aVauMSl3CApfa2tilcW3SWJSA7G2ljQTHRsTshCbLwZfslpV3RVKu8a5qVZQjKCnR1kLwz19K/+VRPmRPPVyivOqeJkEcC/wPcmU1HSEMaoGQ/J7O7JGTLkDwaS8m963vR/YNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH1QrqeWsaU5gIUBWnFp32Lv/aEywXxRpHsZq4L3Zww=;
 b=wmitad7ipBx283kxfTdMQxIVd9KDzZYLhkwsh58XWyPes/rzovzXGtJetLjx4FR9eTF6ldInN+hqr7T20gQR/YC/jQcX0QG1thqkDOx3bdn+bZJ0pxi3y6qVdupl0++BU4BeiOZ9hbxiFDUuAIOqspZvTACADf2XDojwzxjZARS/L0u6U/Kcw93E+lnhMRZKUuyXfs+4VL2r65H5ekg7iFSd8EauwxdQlgYX6sjinQwganFo8zOW1WIR2jQKB+vw3WWE2cZkvblZWMhWhDreqc1vOjaeBkGG15je8EjwDkt4Po0UP04xJHMoEA6nbJkd1V1l5xqWuy8CdIEmEKdNXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH1QrqeWsaU5gIUBWnFp32Lv/aEywXxRpHsZq4L3Zww=;
 b=g7zId37e+05pwEUteZN2qGKx3xrutEiPojkNREGm4fYDCsJmdcj5NFeQqiqWQFp/bChUD/xotl7g6Qy/YFN1oTu4V5GbF8O9VUSMtyh3nax+Pdree7Z2Rc1daQVGB2BxvvTtXcw9eBJYt52WydEm/vKTkm4+u7itZpQ58W2bars=
Received: from DM6PR10CA0023.namprd10.prod.outlook.com (2603:10b6:5:60::36) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 08:26:52 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:60:cafe::7f) by DM6PR10CA0023.outlook.office365.com
 (2603:10b6:5:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 08:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 08:26:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 02:18:34 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 02:18:31 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next 2/2] net: axienet: Add support for AXI 2.5G MAC
Date: Mon, 18 Nov 2024 13:48:22 +0530
Message-ID: <20241118081822.19383-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118081822.19383-1-suraj.gupta2@amd.com>
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d0a2d1-2591-4f5e-44ab-08dd07aac112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzpNpj7QVl7Jod7hHWis0gcQblOxNixPwnHpaUI3c4BPo+Irpucy4rufCcbc?=
 =?us-ascii?Q?PKdAUoRiyQRgrsNJJ0ko4wLOJ8pPhbGA8UvMNOIxxy9m11O32LKIrkZLqN80?=
 =?us-ascii?Q?+n+GKvrn7wat/axJwulL/J6fXjG7hyQlemsFknetGybAZruuZwqwKx5UstIS?=
 =?us-ascii?Q?9FgpNHnDqbCFzi8j8FTpzCZ7kbTjaJt/1JHGuenRzov0fEN/XPZC0AgP98L8?=
 =?us-ascii?Q?iHf4EKT7TrIT6QqGxoDf8mK1l2iOebdPORUcRDwTPO9Cn+zy+hlnTcKFQJYd?=
 =?us-ascii?Q?qExD3qGN5/R6Spk0QukcrPBakJswymLh6NzymUKzNgUw5nNTPZqP0aTAiZLw?=
 =?us-ascii?Q?MXVrEFbN7NgL4XB7qveqoXuWAvs2pLClgeun6XQ0aHrr8wnAKtei1i+P55OC?=
 =?us-ascii?Q?n/JxGeqR/wILTY3XW8DQhuU2T3X6HK2GO5TPe+CjNTbwJuMe79DEX7QhO0pd?=
 =?us-ascii?Q?m3m0LaxqJqmCmUFTDZbY8oL015YVHAXsImSqcg/siFodIeCduMuVht6BEDmt?=
 =?us-ascii?Q?SMIYK9nuw9QYfVElQxHhBZzfZ04jjwJu3mjp8Nuxqp2YBpzUhNzXoKiMzwKj?=
 =?us-ascii?Q?rU7HOdQkbRIYAI9/VhpAmCB+Xi5NmtIxf1b6vShceSObLxKXEgLzJ7mwEZdp?=
 =?us-ascii?Q?3gIQlUc/Lh/tJhi+ftC5oKImVvOuqmXiaavs88/bd/FUfZ3KgJV0wB8kkH9u?=
 =?us-ascii?Q?qnK2zi3TO6PO0PSnmYpfvAQmzmv+19K5UHAD9MZoAWjrvL5JCkQmMOc7OTsS?=
 =?us-ascii?Q?uAXSbglCqg8FibXPwU2qR22mOScBzUJ87ABa0nTRqo73rFcJvVSbG1g+1sgV?=
 =?us-ascii?Q?VZDqg4X/nFz5EsA6nnKo1zcXMc6wlThze4asKWSTVyhLeYMYBtq5YL0UVmrv?=
 =?us-ascii?Q?zBo1L1Mc3JFm4kG6E86hbdxRusd0fPstU1EZxQMzCeWo9YcV5w5WnS6RnLpI?=
 =?us-ascii?Q?Wu4YF7u7K+Y9uU3r944b0Olz5GKBtwy5nSVUK8T0nJCHy/OC1z0OPxaOOEUr?=
 =?us-ascii?Q?8eS+8SpM2+FjbHqmlVOZkarTQrAh2U/Ey1D/oNBEEwDsBT8J4unH+KDcf2i3?=
 =?us-ascii?Q?E5lhgyHrepFfQxJL+6nNth2QYN7xfrror69to7IBhzhOV1/Ge0HX18kD3pHC?=
 =?us-ascii?Q?yiGJcWU2ZNEKma2Wb3dqgx6dQ+8xPFYmtlPVvO0ibKyBtLBwhqyKUnohYYZ5?=
 =?us-ascii?Q?1tSJ81QS3GeO/RPDvJBFi9lG6luYIHU6ftllWsqPQAn1ekYJQm62lpja8Klr?=
 =?us-ascii?Q?UuTe/0AHOjuz+BR50AwAiJ13GM3YqklubXb1yXNI8N/vET4kQ2kaI3CB7jgw?=
 =?us-ascii?Q?0U8V9BCVlL2CH4XVx9A6lqOjc1ijstlLBR1pkIa3FKQPxpdsotdTbM5+Xhak?=
 =?us-ascii?Q?9IvO/89ODs1fQCG5nB3p4pZMCaIo1qWj9m6UKGSX3cSSYwq9Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 08:26:52.0575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d0a2d1-2591-4f5e-44ab-08dd07aac112
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

Add AXI 2.5G MAC support, which is an incremental speed upgrade
of AXI 1G MAC and supports 2.5G speed only. "max-speed" DT property
is used in driver to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
If max-speed property is missing, 1G is assumed to support backward
compatibility.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 +++-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 +++++++++++++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index d64b8abcf018..ebad1c147aa2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -274,7 +274,7 @@
 #define XAE_EMMC_RX16BIT	0x01000000 /* 16 bit Rx client enable */
 #define XAE_EMMC_LINKSPD_10	0x00000000 /* Link Speed mask for 10 Mbit */
 #define XAE_EMMC_LINKSPD_100	0x40000000 /* Link Speed mask for 100 Mbit */
-#define XAE_EMMC_LINKSPD_1000	0x80000000 /* Link Speed mask for 1000 Mbit */
+#define XAE_EMMC_LINKSPD_1000_2500	0x80000000 /* Link Speed mask for 1000 or 2500 Mbit */
 
 /* Bit masks for Axi Ethernet PHYC register */
 #define XAE_PHYC_SGMIILINKSPEED_MASK	0xC0000000 /* SGMII link speed mask*/
@@ -542,6 +542,7 @@ struct skbuf_dma_descriptor {
  * @tx_ring_tail: TX skb ring buffer tail index.
  * @rx_ring_head: RX skb ring buffer head index.
  * @rx_ring_tail: RX skb ring buffer tail index.
+ * @max_speed: Maximum possible MAC speed.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -620,6 +621,7 @@ struct axienet_local {
 	int tx_ring_tail;
 	int rx_ring_head;
 	int rx_ring_tail;
+	u32 max_speed;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 273ec5f70005..52a3703bd604 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2388,6 +2388,7 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_2500BASEX ||
 	    interface ==  PHY_INTERFACE_MODE_SGMII)
 		return &lp->pcs;
 
@@ -2421,8 +2422,9 @@ static void axienet_mac_link_up(struct phylink_config *config,
 	emmc_reg &= ~XAE_EMMC_LINKSPEED_MASK;
 
 	switch (speed) {
+	case SPEED_2500:
 	case SPEED_1000:
-		emmc_reg |= XAE_EMMC_LINKSPD_1000;
+		emmc_reg |= XAE_EMMC_LINKSPD_1000_2500;
 		break;
 	case SPEED_100:
 		emmc_reg |= XAE_EMMC_LINKSPD_100;
@@ -2432,7 +2434,7 @@ static void axienet_mac_link_up(struct phylink_config *config,
 		break;
 	default:
 		dev_err(&ndev->dev,
-			"Speed other than 10, 100 or 1Gbps is not supported\n");
+			"Speed other than 10, 100, 1Gbps or 2.5Gbps is not supported\n");
 		break;
 	}
 
@@ -2681,6 +2683,12 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->switch_x_sgmii = of_property_read_bool(pdev->dev.of_node,
 						   "xlnx,switch-x-sgmii");
 
+	ret = of_property_read_u32(pdev->dev.of_node, "max-speed", &lp->max_speed);
+	if (ret) {
+		lp->max_speed = SPEED_1000;
+		netdev_warn(ndev, "Please upgrade your device tree to use max-speed\n");
+	}
+
 	/* Start with the proprietary, and broken phy_type */
 	ret = of_property_read_u32(pdev->dev.of_node, "xlnx,phy-type", &value);
 	if (!ret) {
@@ -2854,7 +2862,8 @@ static int axienet_probe(struct platform_device *pdev)
 			 "error registering MDIO bus: %d\n", ret);
 
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
-	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
+	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX ||
+	    lp->phy_mode == PHY_INTERFACE_MODE_2500BASEX) {
 		np = of_parse_phandle(pdev->dev.of_node, "pcs-handle", 0);
 		if (!np) {
 			/* Deprecated: Always use "pcs-handle" for pcs_phy.
@@ -2882,8 +2891,13 @@ static int axienet_probe(struct platform_device *pdev)
 
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
-	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
-		MAC_10FD | MAC_100FD | MAC_1000FD;
+	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	/* Set MAC capabilities based on MAC type */
+	if (lp->max_speed == SPEED_1000)
+		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
+	else
+		lp->phylink_config.mac_capabilities |= MAC_2500FD;
 
 	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
 	if (lp->switch_x_sgmii) {
-- 
2.25.1


