Return-Path: <netdev+bounces-107369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1A891ABA3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0AAB2CE1E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738F1991BE;
	Thu, 27 Jun 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JOnZu1sa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BA81990C4
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502463; cv=fail; b=cpWK+K2wYMEhJR90bmW1SjSZA+xHPxUYm4wccEAXi3W9CqgSxItT6nvetFhMzjQKVm/SgeqBP2hAa3oKSthWu5dqSPIP9OVYfKk3TMLgKZXATOs8nimKfZ76+4fywwg7im7RoaEpM4duNkI9diPcYtGIttehhrR6+AtNiy3IJnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502463; c=relaxed/simple;
	bh=SzIRm8b0vwz6xy/MhU6OiNKKw/wT5v5ituv/juBXscM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u04CoYiZwNYaHwx0b/mkre0Weis+bixrGwBqJUJYkzRL0k6dGCQ2gtF0LKfRIPbrEzmiV4/NEVT3OKH9HqZZpt14Ac+AJRPD8yVwIf4FUoOloKw3dQnJrpH7D+op4Ju+FRP1IyBSuvJewGDbJVmDK2Et6/2KwgWMVuUwqLdfwjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JOnZu1sa; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Joe/L2EczL0G++ql5CwAX80XYq8Hdkh+uLDauqbAQBzDleM3JCvb/fHpfO/gCguNPpc3/hOKHoqIdP19zpoQhU6JP3y5dL1dWRJX6Z5yGUfyECbHriINlmS21slKuTspExsOqmmFTHaoa7DG0bW6coeetGOOUgi8DvCYDaNcn8kiwdPpbWf5hhMRMJYY3dYcbAsHlhxa1uhc//ZrSp7D71MJDs89EDYEtHW/VHxxJU5mlTPxwD3h9fk579dPxBO2dDR8iWNLs++1Xlm+7F7j7UVgcnBWWtB+5S8sPMdpNlEdBp7F6j6eWYuuR3RnMHh1C/9xzk8BCk0x4o6bphFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQIrMEPiGjMf6BCaQRUKI3PYrxW6TaFUgmQhpBpY/nI=;
 b=ErO3r2Lfrr7j7jzRH5X6lQlJmJJr5C01QmjiZ3qF1XUz+C+ZLnHogooo0qs3q+wCTPd1n/MMKOz9ZPZ9kfWiC2MSx+b58xGVEoR2/Cxlfee1EbyakqUWHeqFoA1BTTHlIivaVMfVRpIYfODrkZBiZno+jQOYHZN0MRKZ/z6QkLUWzzmQY2OskNtGH67Zg821dG2y756hC1Bq2ZjeIFUdwn6k6/4hJgSPq7oGtmJlhUbXMeXLXzE7elI5XvmVlSRVMggRPH1er07y4odD0ER6/Ut7GIqI9DcO7yF/YixNqZibo9MdOlrQNSLaLz/4O7m4wv/U3DriuWuo45/YzftejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIrMEPiGjMf6BCaQRUKI3PYrxW6TaFUgmQhpBpY/nI=;
 b=JOnZu1sa/yn71q9zo3s0GmCqxpvdx8lRq9zsNwdGSjd+cfdc8I8hpKoRopso7wzIZewlCDmZWda4v7KPJX268mrvKjVQfNUr/SlrB3kpxYlxbc5tYRK0GYMMUI2Q2/7Y84gkrux98uM9TeJ+H2kmpZFHB8PA9qXtzWaJtK7FQgw=
Received: from SJ0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:a03:2c2::14)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 27 Jun
 2024 15:34:17 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::a2) by SJ0PR13CA0039.outlook.office365.com
 (2603:10b6:a03:2c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 15:34:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:15 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:13 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v8 net-next 1/9] net: move ethtool-related netdev state into its own struct
Date: Thu, 27 Jun 2024 16:33:46 +0100
Message-ID: <293a562278371de7534ed1eb17531838ca090633.1719502239.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719502239.git.ecree.xilinx@gmail.com>
References: <cover.1719502239.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DM6PR12MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: 22aa4f1a-95ec-48bd-28a2-08dc96be9b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4TT30PsQLfKNmkBu0jl+1peVOKKajiNdV8NuAJHfSVKVnZFQLqFFwzxaZ/Oi?=
 =?us-ascii?Q?tPfNf+htLnaRA/U21Y6/Z6g/D7vVHiBh9Grf6lrWHCPOe7T5ABxtIpbCwA8j?=
 =?us-ascii?Q?wGKWZG+rxluaRtHuH2EmRB9g2zHBqpe2ZpgJ1Hn4vfy588XmJH8Vu2W3QL27?=
 =?us-ascii?Q?EvCLkSZopk5wOstDmEclPMz/a9PAw+/jLIKWfvvNZ6gjAaAQdPgvmVaGjaTV?=
 =?us-ascii?Q?omhmJA9NtkV4fWvZNKg5FpsFwXpnLzPMUdND3W6dbDeNf+DuAAuwAC6iaVAX?=
 =?us-ascii?Q?F4Imm8+1/wGkG7uvqeTkze5zgKE2ai7ROamF+wS9plJU6rs5zjMVyhDuK2c2?=
 =?us-ascii?Q?GrrM9DSfPiLtYoL5XrbAb6JzDk7cVeJY6g3FhIehcnm6Y3RnR2wEbtEmZZiF?=
 =?us-ascii?Q?Xs1dyhiwz8jki9MINdlfgQPruBrSQhyrE0yvocESd161L8qzGt47xmfSNDzq?=
 =?us-ascii?Q?/kR6a4SM64TBhy818/8qViNnawfLnZYjnWvMhxYZbLpEmi71KSa8mIFcNvLK?=
 =?us-ascii?Q?8IBbX3W0AJqNb4jlNSKbFvDFpsuzx+vlFKEYXgLbgjlgffnCU96ez06qHmJC?=
 =?us-ascii?Q?gUbJfxqpphU2ztttonGeotKkeAa44U5k80ovg/Z0A0hC5sdBftWB6zG2/9Aa?=
 =?us-ascii?Q?iEQ052oZOYHVKg8x0JkHFy2i+4Bjwbr//Hggw2RMFnpWFyJB7/pZqWxyU88N?=
 =?us-ascii?Q?anLR+YkpD0MGcWpbN1Q8bx2O/j6+O0nNbYtFOjkMwjYG/mwKoczNx9WNmk6L?=
 =?us-ascii?Q?vUGBTyn7Uw3quQU81jvpD029H6cvClmG2DUY9Vv3P2mIE9Cqyzd6ZsDQGiGl?=
 =?us-ascii?Q?qYnW14Bgz3vzW60+4U7aaOi3r4j69po6oHSoiChANVfM1Cw/UukAuvqVETlv?=
 =?us-ascii?Q?IQmpVzXlbZDvyTF+sPXoqlH8tuJqaOWM/GimGYDAZ+d00jsvAhgqwwERc7ty?=
 =?us-ascii?Q?T60Q9XOtGo2xW9HFZ9fivDp1xw9f4a4cguZaRRtCz58DegF0E55GE/J2WVYp?=
 =?us-ascii?Q?AJCN3aAbriFUg1QVvMxkAnkKBFHOT73Kuap4VSyBFPVwYC/S9AjUv15oXRlP?=
 =?us-ascii?Q?Dr24QVCpIlbsvvixAnK8DBN3GG/nbh5CoX464UPJyfsG7eRkiWn45gBQV+9V?=
 =?us-ascii?Q?HIvc3eZ+J2SoEvNPTco3oEi5xKxPKdu5bEet1Ggd7EP4Nzc/SA/5fXFENGC3?=
 =?us-ascii?Q?yEG4Khh3WXjbRhuiblNlth57fX1BLVI3ZQX0No3B9KMu1Qwl7CLpVpkVJMeO?=
 =?us-ascii?Q?ROvYxzR7WLpQcp1T+sWvxiIr12BRb+BX1i2xNA1CflyWOjxl8McDerY76UKy?=
 =?us-ascii?Q?mPzMUgbZSc/M2IbbMVsLC9/dVHuv+oZRqz0+xQnTwbA3p2fXP0aciZsw8djD?=
 =?us-ascii?Q?fU1hvU/0IZafp3i7SYqu69DMw20JE5ZWO/GR9i6Imk4jmxwxhgaapnLCQOoh?=
 =?us-ascii?Q?MGmCgyE5wXHSPtgDghQr8aHJchYIPDpK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:16.6480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22aa4f1a-95ec-48bd-28a2-08dc96be9b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

From: Edward Cree <ecree.xilinx@gmail.com>

net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
 currently contains only the wol_enabled field.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c        | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 +-
 drivers/net/phy/phy.c                            | 2 +-
 drivers/net/phy/phy_device.c                     | 5 +++--
 drivers/net/phy/phylink.c                        | 2 +-
 include/linux/ethtool.h                          | 8 ++++++++
 include/linux/netdevice.h                        | 7 ++++---
 net/core/dev.c                                   | 4 ++++
 net/ethtool/ioctl.c                              | 2 +-
 net/ethtool/wol.c                                | 2 +-
 11 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9246ea2118ff..714d2e804694 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1608,7 +1608,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	if (!tp->dash_enabled) {
 		rtl_set_d3_pll_down(tp, !wolopts);
-		tp->dev->wol_enabled = wolopts ? 1 : 0;
+		tp->dev->ethtool->wol_enabled = wolopts ? 1 : 0;
 	}
 }
 
@@ -5478,7 +5478,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
-		dev->wol_enabled = 1;
+		dev->ethtool->wol_enabled = 1;
 	}
 
 	jumbo_max = rtl_jumbo_max(tp);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index 46a5a3e95202..e868f7ef4920 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -37,9 +37,9 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index e894e01d030d..a8119de60deb 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -650,7 +650,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	if (wx->wol_hw_supported)
 		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
 
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c4236564c1cd..785182fa5fe0 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1309,7 +1309,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 		if (netdev) {
 			struct device *parent = netdev->dev.parent;
 
-			if (netdev->wol_enabled)
+			if (netdev->ethtool->wol_enabled)
 				pm_system_wakeup();
 			else if (device_may_wakeup(&netdev->dev))
 				pm_wakeup_dev_event(&netdev->dev, 0, true);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..473cbc1d497b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -296,7 +296,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!netdev)
 		goto out;
 
-	if (netdev->wol_enabled)
+	if (netdev->ethtool->wol_enabled)
 		return false;
 
 	/* As long as not all affected network drivers support the
@@ -1984,7 +1984,8 @@ int phy_suspend(struct phy_device *phydev)
 		return 0;
 
 	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = wol.wolopts ||
+			      (netdev && netdev->ethtool->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6c24c48dcf0f..51c526d227fa 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2282,7 +2282,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 {
 	ASSERT_RTNL();
 
-	if (mac_wol && (!pl->netdev || pl->netdev->wol_enabled)) {
+	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 6fd9107d3cc0..8cd6b3c993f1 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -998,6 +998,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 				       const struct ethtool_link_ksettings *cmd,
 				       u32 *dev_speed, u8 *dev_duplex);
 
+/**
+ * struct ethtool_netdev_state - per-netdevice state for ethtool features
+ * @wol_enabled:	Wake-on-LAN is enabled
+ */
+struct ethtool_netdev_state {
+	unsigned		wol_enabled:1;
+};
+
 struct phy_device;
 struct phy_tdr_config;
 struct phy_plca_cfg;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c83b390191d4..ec64d11036ab 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,7 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct ethtool_netdev_state;
 
 typedef u32 xdp_features_t;
 
@@ -1985,8 +1986,6 @@ enum netdev_reg_state {
  *			switch driver and used to set the phys state of the
  *			switch port.
  *
- *	@wol_enabled:	Wake-on-LAN is enabled
- *
  *	@threaded:	napi threaded mode is enabled
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -1998,6 +1997,7 @@ enum netdev_reg_state {
  *	@udp_tunnel_nic_info:	static structure describing the UDP tunnel
  *				offload capabilities of the device
  *	@udp_tunnel_nic:	UDP tunnel offload state
+ *	@ethtool:	ethtool related state
  *	@xdp_state:		stores info on attached XDP BPF programs
  *
  *	@nested_level:	Used as a parameter of spin_lock_nested() of
@@ -2372,7 +2372,6 @@ struct net_device {
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
 	bool			threaded;
-	unsigned		wol_enabled:1;
 
 	struct list_head	net_notifier_list;
 
@@ -2383,6 +2382,8 @@ struct net_device {
 	const struct udp_tunnel_nic_info	*udp_tunnel_nic_info;
 	struct udp_tunnel_nic	*udp_tunnel_nic;
 
+	struct ethtool_netdev_state *ethtool;
+
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 093d82bf0e28..a7f71a9c3aba 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11065,6 +11065,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
+	if (!dev->ethtool)
+		goto free_all;
 
 	strcpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
@@ -11115,6 +11118,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e645d751a5e8..998571f05deb 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1503,7 +1503,7 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	if (ret)
 		return ret;
 
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF, NULL);
 
 	return 0;
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index 0ed56c9ac1bc..a39d8000d808 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -137,7 +137,7 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 	ret = dev->ethtool_ops->set_wol(dev, &wol);
 	if (ret)
 		return ret;
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	return 1;
 }
 

