Return-Path: <netdev+bounces-104677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91090DF3C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC591C229C5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CD185E78;
	Tue, 18 Jun 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fvdmJOQ+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AB185E5A
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750734; cv=fail; b=JLp8mW9lMTdSqUlnR/mF2Enxn673oTYXSCUSbD/WOuBFSOktf7mAbF7BoMHQv8e9aNp+HG0VzsKNYlOd+GKd/7mDcD8k8+jSwnS7BnrnlJLdT0SXej6fkhIq7ZIdVMrTN1dQGhA4Vs8eKxTsPBK9MohAMRhFk0Apq7Sbv8CHHhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750734; c=relaxed/simple;
	bh=NH/i32OBl5qEUbsvhy8xQzaefvZyIFqbjFgLtWNq+F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5uxna3qAQq37SZ9TbQyS7+V4eRVe34uqBxGzsrItJ808ORogX5QSfxhRZNQqreM/TjBP1zPjZ1JAHIlnvWyikhu7FjyutdHjhQjV6LJ9gn5NiVD/JeND174IKKJ2rd8iyflhDLfik/KJAf2tXz8eJTePoOKe5bI7AWUbMzp3eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fvdmJOQ+; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHk6rB9oriyH+NeMQ9d7uYregRea0XL2QGm/VRvSAcXsiaDb8mXzt5ITKffdLi/oT4q13e6qa6qcgbNZRFj51ZEvTcJ/Ly6td/T0mGWFixIU3YY1DUNuUGHzWuuiahCx9Di11ySCQpm+QfYP9uDXutzKM1I4rLS0O3aHf/ImTc+ylIJlN0QMfsLt9KOjI3q9AEQTq3hS1rQdIa4NS4o1mDCa3pb6bAjvlD/KvasqHJtk/AgqeIOOkZmZmzYgGcpsYvvR4s4WO/UnLudq034jE3fe/fxCRL+boz9FKSRLOvHUtB+aTfd2XXLOr/S12+BIRgWuOfLm/NuY9nWNBxw7fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpOAWH6SolhTy6HM0xygNf0nqLgapjwyT3RRowdZjOQ=;
 b=no4Za68tQSR3XEsZ4OYSJN7HtXVwmOxTyKXz5imZcS7RxJMZyFdKpGWLAugez/WVJ3K5lEuSkP2VUdl7RO3a2QSIu8uzJvIMTlDYznygwQHaLbOaHF9jT+l45/M7up0fQPAxgpNXBuidegvnRCdOxefI4kvUEAxymIsPPM0T3YVYFQlUi/L0SMBK6TEF6+3d/tYQRGoyt/grroZTzbfM0oTZVEn8uhBLWOJGVIQnIKLn2zk4rV28W9j6GPe1+lCiKdj9nrV+/Io3Y7K6jnjbeCEETjFJxBfTd7hRvX85Bqb+OxmDGr50qTMq87QOBZsPs84Ix7WovnP2lSMKlxvqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpOAWH6SolhTy6HM0xygNf0nqLgapjwyT3RRowdZjOQ=;
 b=fvdmJOQ+pl9U/+1M4plxBTVcAcHtCpM1OHBzpQynLeASDyMaalglChAJAgDlHV3RnSZRXQTCBWT6XGrMOteAA3s49dE23gXgEBtu0kKTWwhakOGX10+bhL8EFs7yhha3MPE2vtq+H2wk4WWXgHN/FjMD5df9s9Kf8ny0z5HwDZQ=
Received: from BLAPR03CA0067.namprd03.prod.outlook.com (2603:10b6:208:329::12)
 by SJ0PR12MB7081.namprd12.prod.outlook.com (2603:10b6:a03:4ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 22:45:21 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::74) by BLAPR03CA0067.outlook.office365.com
 (2603:10b6:208:329::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:16 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:14 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 1/7] net: move ethtool-related netdev state into its own struct
Date: Tue, 18 Jun 2024 23:44:21 +0100
Message-ID: <03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718750586.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ0PR12MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: b57f146b-b09f-4edd-ab69-08dc8fe8535b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|36860700010|7416011|82310400023|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?37awiuv/4+MtXhXnrgr3U8uctlI+mBFXc8yvfDQkaK5WH7gcAoPcqOYz2qbj?=
 =?us-ascii?Q?5tcuu5IzbeEUxQ3/m30GqMykQpgsaRpr8gDb35nFgFIsevFVh9D1j2kFXyM/?=
 =?us-ascii?Q?y+5ysu+Bgp+WE5zNXLCYt2DCs/LtMR2BeR0YOjpFPfsYKpos9M/cKzRLSIlv?=
 =?us-ascii?Q?cMh4BEApeTbVrnMxDN9CSrSLFO9sDg0Gl/qt1he1XAAeIXAuyWKQ4lfL7rHf?=
 =?us-ascii?Q?sW9y2iucjbhoxc/NPnjHNJ7aUsRaJST8M23LgqcLrpCvKbiCTgWcHJKz8tmV?=
 =?us-ascii?Q?DFO+Vc8yU4qOFfv1U73pVU06CKnCV4j7tuzyc/Wge1Jw2v1EPGSg06kDx9Dv?=
 =?us-ascii?Q?PdF0oqfF7Hs8hdB/flH9iGSbxx1CHaJotm8fRyl7BJLKGitU8gSdSIGjc7Ao?=
 =?us-ascii?Q?UBbsy4/BzKZhMdO6nZtVlOUIUvJfzIiFvTcAlXDdSP4KNqbtBw1c0Qwsd51f?=
 =?us-ascii?Q?ddEqMN5zLXEd8nSTSKjs5QqpvdLYBA8gvMe5P3VrkUs9yvv8uJJL5nlfwqN6?=
 =?us-ascii?Q?NDR7nfvTW8gKaNxFKBz8/JpetMjxC58z90+9sacuRaE26PRtgJMWTZ7BRgSh?=
 =?us-ascii?Q?nl4qyVUaZ77evWgMgxDqS/roujeqIQHLNV0xrfy4rcXV4B/4fAED9vb9sOnB?=
 =?us-ascii?Q?pId1EHPJdRG2Vx4Eh/ZDSNMjLrpFKTpkO12vAUDd40RE/TPkWz00OIbapH55?=
 =?us-ascii?Q?CwmcqZ6+dvpxbsdWNIoJWLMCKtTk/27NRAGJXM6ss+tFzVgPXTkpRriviW0U?=
 =?us-ascii?Q?bNEi8MKDYEaAV7d5sjn4hlvFNcQRfHiFBJuvVmKTGiOzykA41SBJjcgW8K8p?=
 =?us-ascii?Q?+L5qqm476hsMAWrk/G7ZeEgJ+R9JGge4mpkteKU4X8o2d0nf6+gt590AgWBb?=
 =?us-ascii?Q?VxmOXGJLkKNlmNWfrzYzCbNHvp6KO62TecU85r5bcH7dSP04FVE0DB2PWFS8?=
 =?us-ascii?Q?6n4DY+2urMy8caqZMORLnOaKli52cw1i+eefyEC8R1U2CdfdO7AJnhEiKCYV?=
 =?us-ascii?Q?TT/JTFQbC8sy0Nj9fIFJ6KUm/vq2j3nkr09zBGjqY23+/jH8I47GvetSYddE?=
 =?us-ascii?Q?otQZV2mS55+tWDiFiA8zruE4T2cev2QHnFxspKbIN1oO6mhVvfF2qIXtJtRy?=
 =?us-ascii?Q?kb7O44mK4pilaHe8s3BreK/tXYxsHEoyVEHru62VGvgzDEZf0SfGeaKfsPo8?=
 =?us-ascii?Q?HbxcKvxFeoPKhPcz6hGoOcxfPCTqznUpoeKoj62qtiGPg45pHi9AXLzdHrqS?=
 =?us-ascii?Q?D+RStDVmnmshqVOYWssugI3C9WIyasO8GyxtT7Ls5HdwhL/T42av2W0j+MAR?=
 =?us-ascii?Q?CpZQiOuPZ1KpkgDOrb1dhQJ1pb4278FD2LNdmKsbIZtsV5Uf7ln95XADoZOQ?=
 =?us-ascii?Q?uxwj+J15ebgeuxQpR7MYxK7SrG6YO5MasCF+0P48vYQnvEQH+w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(36860700010)(7416011)(82310400023)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:17.2844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57f146b-b09f-4edd-ab69-08dc8fe8535b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7081

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
index 02427378acfd..38e4e7c0f7d5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2275,7 +2275,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
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
index 85111502cf8f..bd88ecb61598 100644
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
index c361a7b69da8..29351bbea803 100644
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
 

