Return-Path: <netdev+bounces-174157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47AFA5D9F6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212B8172654
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A922223E337;
	Wed, 12 Mar 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aklJtmhK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC21A23C376;
	Wed, 12 Mar 2025 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773271; cv=fail; b=BdPXRugBwBbpWrydsJQZEfwKYCQDzSOfLKYadkRP8WCpmXswxJNsuF3xxjMhcQafTQJ0a4kl96Zyxz76yb6bb9wmrz5pmRS1ZuU/qoqWjEX3Pubn8KmCkcyOnfTRWj4CQnzEUHjTHREmsqSD4USfVgYGxEnLxil2sd7wEGjYfHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773271; c=relaxed/simple;
	bh=Ix1Gr03qVFMj4nEkFPOhnzcifPNqoVN9v3qXzmk7rXU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m4vMLlLaz1oNAjOt0Tfhe3VgQPZhQ/nvjm2kRXtBGZIfdkNTdK6cSgswF/tHbQFQ/x4iPIuXpHMpUO5s4YSOyTCm0Z7YvBo89kjASKy7pUlObeIx2CuByp01TfMtlkp72o/rqTZ7WtzOQnqOsiadaSNkFFGOsW2hL5B17Wom08k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aklJtmhK; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J35rd2FTXOxtaTMsa7U7d+VzxjFE0JZkljKfq6kXfUJG93IDl4hdakxOjzCGBNDCi1lkW+SjzLSv03fohWyOI951zklIC1FgjhSSORakZdea24QMA9mUL3tDlpLMAvgTCs4KThqDVY7iIHwYAZ0+Yzdh9OjoQcu0YumZ+LlA5KaH2nIEnDimYmKyc3wONJWRsd5p9HQ3XE9UeEdgzN7Ky6MWDa8i1FcBFvuJxx/7toAQh/pJGtiZdNJZVLJyuKRGK0SdOxa3GhuPqRMujezzLzkGTXIhJhIFX7tEJ5oxmrX1y5FcFMUJLvvL8J1tsPa/VK98Rs9kXeRhyx5PVkwtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjlfXpuVTk699j/mSf1lWyI+T5lVEqAAlzV3tMAFGpM=;
 b=fhNAoR7EOAs7Nn8Pq23YiJMDbL5Mxuonkupnpo3gh/Qm3j8hfqEdepTm/TRmPQ8UsBuBjdQAEdCiGDikDSpPB0uDsLc2dp3YOU0EVl8imuO05ywjqz+KF7hqgzAB0eFfVXxF+LQeNNXgatOB6JwvDmFGbUuBb4cDFhM5q7Qmn5e3PtXyNbpcGgz4pumfQQ/oRVfTRw2aepXwHYISXia5NK1scxeAJmef87IwdmbsvPhEN4AqCzs3hdbTO4E6dNQoRXfPlcfCR2wVampy2VzYiNWzylMOOLj+rzQUHS7s/k5gsYcLKidfwayPyDv+tMJ+ItjdGCKbFpDKsyrUm/S5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjlfXpuVTk699j/mSf1lWyI+T5lVEqAAlzV3tMAFGpM=;
 b=aklJtmhKMnzCYNCgIVzKKrp1A2nQaxbaHJLeoJXI5JAG4fA0qzaxS4CDG0zIs41fhN4r2aS2gH4POYYeTvG0EMtaa1DdBicCkovr1FyuATxPS8stVA5eKtHUjfdhpua9i3RGbjWhBE+a5M38JlC3Noy8siatv3lPg+M0x5YM0NQ=
Received: from CH0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:610:119::16)
 by SA3PR12MB8440.namprd12.prod.outlook.com (2603:10b6:806:2f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:54:26 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:119:cafe::85) by CH0PR03CA0381.outlook.office365.com
 (2603:10b6:610:119::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 09:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8558.0 via Frontend Transport; Wed, 12 Mar 2025 09:54:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 04:54:24 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Mar 2025 04:54:21 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X only configuration.
Date: Wed, 12 Mar 2025 15:24:11 +0530
Message-ID: <20250312095411.1392379-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312095411.1392379-1-suraj.gupta2@amd.com>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SA3PR12MB8440:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bb9890-0202-45f9-8983-08dd614be012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PxFAfzCSvrmwLJOAcse0GU1a/YTmP/X7iE8ub/oWNouMMxOvmkFsNXsyCxxT?=
 =?us-ascii?Q?pYpyLVh1riJ7AhMfKqXbbz7grw9dXKJNizPwi9MSV/5xc3mUVYeTKD6DPuoJ?=
 =?us-ascii?Q?tIN0sBGijwMC3XZitWXgZg1TdyKwggzUf/dgYaEcfxEyIBCyqLIrzqsqYzJn?=
 =?us-ascii?Q?fsTlAxVx4/W2jX+NbJA/nJWMnPc1xQ9t67NnNyJNsnGJu7VNVEAKeBY43ngd?=
 =?us-ascii?Q?vc93KWawYcpRXjCM3AtpfQFfHsh/n82SJPFarWb7SB0ENrNWcKS4w0wjhU22?=
 =?us-ascii?Q?4G/qFZ0t3LDGrk9IvPBtkoKF/tiZ0DuEcRS9UTsF0F0VpHiyKDxYt7DNtunO?=
 =?us-ascii?Q?5XMoc9YjauwG/STkaObMRpltEPRKOcJLtgcPr8lkK/cBn8g2F/3SntJgGEHb?=
 =?us-ascii?Q?TXo0cmr5W4nyyb+hNBWZ1F7CXoSIfVPIO2hEf8NDHxOHUStyjnMYAdPYx7ez?=
 =?us-ascii?Q?4MMNDR7Z9jiw10b0llfRtyOOZ0H7J/lvg9n0e2T590RxT1IRkpNOimFVyEsG?=
 =?us-ascii?Q?HaHTzYpjCwE4u+gr+MA+idH9d6l/uNlW/+Zw8RnYS2xR3jldaqM3+PetP+EP?=
 =?us-ascii?Q?EZdwKB0mb5ilFxY3nFJ2G+9uhqOgeqRlRAED46JGAiTzOb/mEWtso+dIAUUM?=
 =?us-ascii?Q?GyxfczKsYWMIZ4FXgb9+GhyDl6nt0I5FfekHcVFr0rS0NP4ynbT3fwutqIcD?=
 =?us-ascii?Q?BbYLIYcpA5/W3PG44/SV2JYfQT2p62UiQiZ81EJHmDdjVL7nyiE/u1CLQ5LO?=
 =?us-ascii?Q?v2zOYOzVdQsp3dB7fS+r+yHU1RZM+9eGi7/65phgSRRoXnlGi+aZnFQhLr9z?=
 =?us-ascii?Q?+1BSh6gBDxqbthjUYDwWWpwEmM1GF9PbHvhMoZXYuZPseFvTiYAGlZmPSvXZ?=
 =?us-ascii?Q?iTXh8qJWsjFjW03SFonQSOZQ2cDmqCkIIu9n3p/6EJuAVY3vuti6jvfiL9O1?=
 =?us-ascii?Q?zSuIjb2mlzIPpx3UxN6ehYOWgROu257kuOeQjOe4OphoCd4fYfuVPouAgF3i?=
 =?us-ascii?Q?SwtLD0WwLa4vaBzYn55lT34ytKIVqQ6On9UE9yu43vBgiircMmEfkf7rZjWF?=
 =?us-ascii?Q?nTQMyMSvCex90BaKE8QBjtg3mSF3EfQ/Saq7Bo+heLPBZg9mvkuIoNKW7j0R?=
 =?us-ascii?Q?fOU0ru6a5UrLKpYRzXU2BalrgeFUQpaUXWroAAGYTc8rBrlajDsQrfPIJ52y?=
 =?us-ascii?Q?kncqjRSAKk9JHRgpuBCOf/z2bHbNb8RhiGAX/PZlG6bo83sSe6hqg/Z2i5Yf?=
 =?us-ascii?Q?1qQJKcUWSekrI3myT7J+37Lb7kfStH8cKZQv5NsGpHVg0eyvOF1V5q9DK0pA?=
 =?us-ascii?Q?KPe0pHM/pDYhDd038R7PsmUBhbSoC0wFDN087xYkvro5eNx8U5HirIQ+MV6N?=
 =?us-ascii?Q?8vVgkFNh1k6ZfKI3eBdk3e7eISq57YMyptOjzpYpwzo7kTHksmnd8sujy6uG?=
 =?us-ascii?Q?ty99ODDGzCSWh70BuCs0NPBFt9v7dDwM/9pMLtfV1jrbnE1Log2gW6+a1siK?=
 =?us-ascii?Q?M+WVkkh4AqYjzF0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:54:26.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb9890-0202-45f9-8983-08dd614be012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8440

AXI 1G/2.5G ethernet IP has following synthesis options:
1) SGMII/1000base-X only.
2) 2500base-X only.
3) dynamically switching between (1) and (2).
Add support for 2500base-X only configuration.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  2 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 24 +++++++++++++++----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..ded3e32999d5 100644
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
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 054abf283ab3..0885ce201b0a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2583,6 +2583,7 @@ static struct phylink_pcs *axienet_mac_select_pcs(struct phylink_config *config,
 	struct axienet_local *lp = netdev_priv(ndev);
 
 	if (interface == PHY_INTERFACE_MODE_1000BASEX ||
+	    interface == PHY_INTERFACE_MODE_2500BASEX ||
 	    interface ==  PHY_INTERFACE_MODE_SGMII)
 		return &lp->pcs;
 
@@ -2616,8 +2617,9 @@ static void axienet_mac_link_up(struct phylink_config *config,
 	emmc_reg &= ~XAE_EMMC_LINKSPEED_MASK;
 
 	switch (speed) {
+	case SPEED_2500:
 	case SPEED_1000:
-		emmc_reg |= XAE_EMMC_LINKSPD_1000;
+		emmc_reg |= XAE_EMMC_LINKSPD_1000_2500;
 		break;
 	case SPEED_100:
 		emmc_reg |= XAE_EMMC_LINKSPD_100;
@@ -2627,7 +2629,7 @@ static void axienet_mac_link_up(struct phylink_config *config,
 		break;
 	default:
 		dev_err(&ndev->dev,
-			"Speed other than 10, 100 or 1Gbps is not supported\n");
+			"Speed other than 10, 100, 1Gbps or 2.5Gbps is not supported\n");
 		break;
 	}
 
@@ -3055,7 +3057,8 @@ static int axienet_probe(struct platform_device *pdev)
 			 "error registering MDIO bus: %d\n", ret);
 
 	if (lp->phy_mode == PHY_INTERFACE_MODE_SGMII ||
-	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX) {
+	    lp->phy_mode == PHY_INTERFACE_MODE_1000BASEX ||
+	    lp->phy_mode == PHY_INTERFACE_MODE_2500BASEX) {
 		np = of_parse_phandle(pdev->dev.of_node, "pcs-handle", 0);
 		if (!np) {
 			/* Deprecated: Always use "pcs-handle" for pcs_phy.
@@ -3083,8 +3086,19 @@ static int axienet_probe(struct platform_device *pdev)
 	lp->phylink_config.dev = &ndev->dev;
 	lp->phylink_config.type = PHYLINK_NETDEV;
 	lp->phylink_config.mac_managed_pm = true;
-	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
-		MAC_10FD | MAC_100FD | MAC_1000FD;
+	lp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	/* AXI 1G/2.5G ethernet IP has following synthesis options:
+	 * 1) SGMII/1000base-X only.
+	 * 2) 2500base-X only.
+	 * 3) Dynamically switching between (1) and (2), and is not
+	 * implemented in driver.
+	 */
+
+	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_2_5G)
+		lp->phylink_config.mac_capabilities |= MAC_2500FD;
+	else
+		lp->phylink_config.mac_capabilities |= MAC_10FD | MAC_100FD | MAC_1000FD;
 
 	__set_bit(lp->phy_mode, lp->phylink_config.supported_interfaces);
 	if (lp->switch_x_sgmii) {
-- 
2.25.1


