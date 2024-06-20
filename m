Return-Path: <netdev+bounces-105120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845790FC49
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9111F2442D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E5383A3;
	Thu, 20 Jun 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dloCXOSH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77E33981
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862490; cv=fail; b=kWHu9rO+PKWs7ebdTJ0AAZZXi+oPql5u4zOVeDaH4A2XDT9PNpcNK1hOhk9kiXfvt3h6sOzUqumyvHlzCu4gmdKxKI/SrVFUzIaBmRthosncNGXH9S31YbMQa8Xx0baJmB8bMpAKqBxfYOcDvQLno8UWPJ02DMIFo2jDHShLsz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862490; c=relaxed/simple;
	bh=NH/i32OBl5qEUbsvhy8xQzaefvZyIFqbjFgLtWNq+F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJGigfvVQZsWizplrQmkRHfiUPlUWH29ERmAX0hgjktaEss4Izy+P9G0IIheujPZVrIt8qIf/FGS9SXFddlqOMZJELfSMqfbzBimFaX6SIzdlqq8f9yTg2q2HfzB+iJ57bBZEL8nY+mlMwQmRPbtKtenlzjFzKl73gMsL2ssqnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dloCXOSH; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+1troOFbpHDAvmx7/4u0CwFaEDZH3ScHrYzUfBOmE7301cxCVcazElYiwbEQK/P9RRiFQ/MVZlSU+sot7kl0vr57ps4e59n+4u1cAGFjGVXDZytdnjO9cerVtuRvOpGjAwuc7w5i+pIakU//j0abMOYaFadzDi4liKX/zoiohJu6igr0sxPX01riUP8cADWTZTr+3mItuADnaksYcpxr1+fSBbb2nsLujAeXueZJgk5HuzEjsqh6PlxqHPU4aDNf6veQ6PJp+cOtgj1xbLy89KN8lnKZPBU8gZQZtOwf9lqqrFdbhRRbsPh53R4BrSKUh8RkK5+ZsjwKbd/on24OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpOAWH6SolhTy6HM0xygNf0nqLgapjwyT3RRowdZjOQ=;
 b=FXxshVl0ltMn3feyMoYK4nNcY1PD/Aua6qc9y/pEm/XMmjz+Y+YboFKLPS6D6RmIuR5o3Vso5EHtwbrjTpjWZqoKvAGRrPAPBSjJyLjkmL8Ehf9QaDlU90txo7IrF5hf/awkEDJUSk6YcV8AOqLHqsT/rJlfArFZqDkM7MIGgoWgED3vfncVVvQ+lIvldPyuuoyKJOEJEPL5ahlkkChxuVVaw45l+mMcmxN0YTqu+JSp9iBTiMEJ4uTsiEDuAxMslEK9yR0/ePtv90xQHsykFz8ruysv2/RaBfzNJB8ElWiY0+vYyRWfpUo8i6nR23qYwQK/6/OurzBmbI1ZtvooNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpOAWH6SolhTy6HM0xygNf0nqLgapjwyT3RRowdZjOQ=;
 b=dloCXOSHXfUWaaw27H5kI8l+mK5O9pHlbVXPlSH0DX87qeHG/vMFEKub0S440HnHCW/JG0QW0dKFEilAJ91m7figOwTwMHmWZCEKQRRN1VBpnjLW+R9SNoRevoC5IkV4/F7ICs0fMuWBn9ZcUy2eskuF9HeXzGvg04DNX7i5LT0=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:48:06 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::57) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:01 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:47:59 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 1/9] net: move ethtool-related netdev state into its own struct
Date: Thu, 20 Jun 2024 06:47:04 +0100
Message-ID: <03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718862050.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718862049.git.ecree.xilinx@gmail.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db9695e-8e34-4b14-3899-08dc90ec8e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GHQwlPfs5dcvbLsXAPYI1h1TzJrljwc+H0o5q0xX0NXFICjOKtG0UqPi9pmn?=
 =?us-ascii?Q?50+DW/q5MqVA4y25EbaMQWlbG/wH0+9gFSLn7mdg8Yw90/F2ThmCTDFSiSym?=
 =?us-ascii?Q?HgRls8IYIJs9RTA1iqLvs4oWkx2ujm2sMh4b+Q4g+BYN2wl8vDbDrWxABQbE?=
 =?us-ascii?Q?nnuQRUNrmFn0tzRvb4qhJxhvLNwGx3O5IMpQEhyPZcselKB8DYpWyt2AZD3s?=
 =?us-ascii?Q?/+KzCtPgwR9S49mPrCzGTdxqUrUQmlslO+HU0NyvwKJcFc2bxLSx36g20ODX?=
 =?us-ascii?Q?j5iGVBdhAs3yVeoTQAE91N3vDmPORS0MsuL8DEcthX3tQRwdDyXYuU9Ak8ge?=
 =?us-ascii?Q?8ZFyQGwyEUWTdcHHJ5HaDaSf4MkMy3QPDrNM2n7hEHY5zkzemCPg0Xe3wB2G?=
 =?us-ascii?Q?7t66azWPr//u8y2DINNexCKnOMYulePwjnYUEIFcmDFGqvyuZ7j2Ta/LDGeu?=
 =?us-ascii?Q?6MfW60ILG1AUza5Nl7j6VrpcgWKA0WWrsmFaIibZAgWlje2w/zw7DtuLXLuR?=
 =?us-ascii?Q?+dUwJHDcBQoypzu6xDMjjTNho8ADt+TmdyYpG5FBofIGsntJwjN561dRZvoF?=
 =?us-ascii?Q?9GM0RJff4iMbwDi9Ks9FXsGoJhTt83/bfBPAJcJQH6A3bntN7R9+FXXPIQlw?=
 =?us-ascii?Q?O6lSR2S8EIQRxDCpXDCPbL7wzEIDbFSruVHQqLNMfJOH2LhamU3yfEq+/Bn1?=
 =?us-ascii?Q?ANyhcNn/GnZial0FGowfDtTe9ICr93OW63k9FKWjze1Huh/06lXFqcx3NOPE?=
 =?us-ascii?Q?0j2wBQfHapkhhvDv9xyuX606dTr0M+oz9MHNPMzwLXCWKJJIw/aDasCqsSe7?=
 =?us-ascii?Q?oPY0hcMO7ppVVPVyVBvXjsPQgOnvGddpkG+FvVKA9AmtAnzmCERDv4UetwF+?=
 =?us-ascii?Q?fI4Dg+yRlEJLu11Fc03PuKugoxTU6QKK7P/+fjahM4FV/M4in1qBoRzJvQwE?=
 =?us-ascii?Q?GGKQ8wAp/bRPsrM4KXBnMdkMP4hMObLwyg3VoSsTFNlgai0NqRdhsZaxeyJc?=
 =?us-ascii?Q?8M5USmh7mTqbAmvmGYCrR/53OnqPdN/CdfzkrWijmSIUmMsDnp2MyNSVXoEN?=
 =?us-ascii?Q?5bjsq4iNfqhDIqvUBZDmQCsrtFQSS2EAIsveQya1DCdxXuFdq2IepAOwqgAu?=
 =?us-ascii?Q?dgIeo7cmTed0V8TEwEaAxF5FM8lvDAnwPIAOqFPN5JHhVPkUNhdRfIJEWWm9?=
 =?us-ascii?Q?58f/PlANbx0ntXogvopioojJDfOTBNINPmEb7F+mRK4GCCI32kwzqEFxVaOh?=
 =?us-ascii?Q?zriTop+nTUxufkpW3taBidQQiF/1cWOaYRKQMDa5rsZ27deQvrCwSxCIBh8T?=
 =?us-ascii?Q?B2LZVbEnqt1NYZWuqlDYw1KYZxMbXueVFCCQOAubYdnxIwclc7lMc121SSKa?=
 =?us-ascii?Q?91Ji0VDw7Ti+2JDpSD4Y1UfBhJKC2ztgGu4/Ul6f8ISccWOJjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:05.2468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db9695e-8e34-4b14-3899-08dc90ec8e4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760

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
 

