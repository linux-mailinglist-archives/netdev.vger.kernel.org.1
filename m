Return-Path: <netdev+bounces-106146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DBC914FA4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EB8281E8A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3717E142648;
	Mon, 24 Jun 2024 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ecWxK2ur"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE48113D62B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238377; cv=fail; b=HZbz7Dootm2YCbhCihgrXPJWlwpanJ23kB2mockcavbLC6w27Xf6S6w/kmjnOb/V30ltD45bKixBhnrjfA2judc0O25uoMDWlguWspE0Rwpd8gEw4tkXrWttHoFViyecaPeIf6JW0R+qPmHkrmKkOxGE73KKX6RxyKft67HgJQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238377; c=relaxed/simple;
	bh=SzIRm8b0vwz6xy/MhU6OiNKKw/wT5v5ituv/juBXscM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koO7FHIFj0ZCL+Yw57wy0OKGRNXj5peWwexec4yfYndfLODkxtztPpQQ2/dM5H89PyycUVywuvLpb/wgWUwC7n860PMeipJADpQvhsI5jNoP7gvTtzTwU6MP9Q1NBeiHtNzxxf/H2P8YUEP35jYWAS9bT7mrWw0Mjnw/cgwz3JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ecWxK2ur; arc=fail smtp.client-ip=40.107.100.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbDbKJyp4Jm4zjsNL2LWrMHtpgpORm5neqokJ5fRL7QyXpCnVOrqZd1aMMRTFkkW69GMZJPKvpZu08t+jEOchYs+6lpECJ6vwuB6RH6YqbIdeAl5JnewGmYyQhVOxjUPixwvlKnsi78/fI64m3CortuZAqUdIUshD0PKgNweAKxcJ1xYmn4vim6flchDC7OEnOP3JvzVZ6SuXjibI1/z9WzkTcOslUI76Ydiy9GsZvG774LqR6SoQjxuj99E2xBHJ/9aM12ts9Ccb0tAKVfdiYjQ2fA1AP5+XhsSVxbPKiybr9NZPFBGKLBE/p5fCjnP6Y/gJlOc2mQIvXKJtQKvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQIrMEPiGjMf6BCaQRUKI3PYrxW6TaFUgmQhpBpY/nI=;
 b=iUA6ermaS05sQckrt9fGyPYhHwC8v1gaHQfPl18TbX5uNyDNUbD8lgEh7vVsQ62CkjjiCh6PNJwNJ2Z3DG7zviEXXM+yPbNCThu8Fq+WDrncWNJAYBYaOFzsgD7xOFjP/EFT/rBG7sJtHA9JozUaz2mxIQaJRmGsQXwJ2tUDPVfftc6eHlsulXmnQpyct8tEyufherowYJ/Bp/d1z+ex6MB375lTXWfwxihLzaAqNSssk62urFo+vHEaL78aP/9ZTX3rr4AYjqVUNA8pZNstw31VvpCF5zjqeVIsC8WsAELjlZ2IFaSRT3Y48goCupnRfT37hi63LLvY7tqtUBUglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIrMEPiGjMf6BCaQRUKI3PYrxW6TaFUgmQhpBpY/nI=;
 b=ecWxK2urcUNy09gQ0+qiT21w0nZepPGck5ec/x20sNwHJ07IXY3SV06gEeruoUa5ieQ6bPC+k7/GflLsnKx29BNtQnbkIkzvyhY8feiS8BwaUqS/yD2JZFXt1+XRCgPRC08p4p5VSbZL8eIZpystxmFAx505BjQl2srwwsN9MSU=
Received: from BL1PR13CA0216.namprd13.prod.outlook.com (2603:10b6:208:2bf::11)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:12:48 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::ad) by BL1PR13CA0216.outlook.office365.com
 (2603:10b6:208:2bf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:12:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:47 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:44 -0500
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
Subject: [PATCH v7 net-next 1/9] net: move ethtool-related netdev state into its own struct
Date: Mon, 24 Jun 2024 15:11:12 +0100
Message-ID: <293a562278371de7534ed1eb17531838ca090633.1719237939.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719237939.git.ecree.xilinx@gmail.com>
References: <cover.1719237939.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 1945f112-5019-4817-a981-08dc9457ba11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010|7416011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Z1vzE8xMI5e34kjDRirZgRTv/0dqvqiEW6jAR6b3hTzuomm0cJd1lVV7zoQ?=
 =?us-ascii?Q?7amnPX1JNjnJsJnW7koS8Zzo2lUIql2HgJfO9FetphosHIVVMiOQjx4MtQ3h?=
 =?us-ascii?Q?03YGJN2VMKZ+phJFSXvB8Ritoy7Af6fps3gJChjxDBT6cmj6YSQI7ZP8IwQY?=
 =?us-ascii?Q?6TXa/oOXaDsMRJRJW+x3SLApgF7eTynfSx1Pw6XjJ6eWAITSUjV1D1XhPu0R?=
 =?us-ascii?Q?tA5+4s7SsJ9Y7AFmWWF79e+S1mLl434tPB2ed9hs5MJdhKq0GNSdKKnsv6Ue?=
 =?us-ascii?Q?6Z62U3RN2+qLgqENiV9vUCzxD22Rx4IbqGCDdslrNCgUWxLp6Jte7dYHR2tF?=
 =?us-ascii?Q?2EUinSoypNMq/DrLY0Et6KOWiZLQ6vbNMjaRfiu1val3NaeuqZkFkgjXo/rv?=
 =?us-ascii?Q?DSnJHHskv7KlomMye3hwOV51NIRqnWMaAKskDexJfTq4D8uGtAl6ww17ZCkS?=
 =?us-ascii?Q?1LdqtJuFqfMXqi3FE95WeJajWalsG4CAS/nybzvgHquKliR1VQa/sL/OvScv?=
 =?us-ascii?Q?sQ5YUP1ZxHoEbQ23yWvXTP5rwxa9EeipqFsnjHXg9Cw1PO2v05TzBRgzm5ra?=
 =?us-ascii?Q?vefbqaqcroh3UGVP7uzpUsHA3Ap2OcN/hSRLzlXXN1OCilbnCPcigp9A86EP?=
 =?us-ascii?Q?pDEfMuK+/1/LocK2k5kNRU7i8TE7S6x394DzEPZeZ2JSdg4RWQPK01ex3bd4?=
 =?us-ascii?Q?IA0/kEPQmVWxWL5boT3d4KIJ+lUBBwPePel7lRYC/Ak8gM/RpqMQt5Z5MCTv?=
 =?us-ascii?Q?Hq6xzRiIbaU3nSOJQOJfqfjQ2tGns/gm5JokmemrCpIGJ4D75YUPE8eg8ngQ?=
 =?us-ascii?Q?P/dgY4Z0CIbsNZJABvCs2iuazqfPrxrpTb+P0A6y8JSDr16mjKiBYrrXL45v?=
 =?us-ascii?Q?wuu+Bm4+UqWRujVJ6kGeS2C5rLwaqbxlmjnEf9aQzbXY/65P7CWERwlFTIPl?=
 =?us-ascii?Q?jr3nuKcFzZZIEHvkpY7rLHG/pzI/jlvp8t1+/tUp+17TiL3Mn1fRN/HMoeVi?=
 =?us-ascii?Q?MLsSwkXx9EzPAWW3qrxmRZYW4rpA4VIr302a/30CXfxkiSRUO5IJxi1bPiZj?=
 =?us-ascii?Q?dan564O7+2or5fAamHdVRoKjNMvd5//g1XWJ59OEZT1W3Tus65V2+TXoxGdL?=
 =?us-ascii?Q?GR8v1B3FcA7XX47SerlD6I6kuiMi8Hy7bw8lB8tDKKNZX3A1tQg9XG6kRQLJ?=
 =?us-ascii?Q?s7aqTZP7zs6pp3FvEbZWQc99n2Rt/+N5mPwSBFxXA1leYv2uMOIgv5L7/P/L?=
 =?us-ascii?Q?LZ7WGqu4CVYVuH/LZn+kxs/AlLSbnQZiiG/0Xh249uz665kPqfcewcq88gLi?=
 =?us-ascii?Q?l3MXYOg5gC6pERmgFyRZCuYXJXGl31Ti/hCFraHKRU9GgpR+EuN+WvCUF9hV?=
 =?us-ascii?Q?Nd/Y2RJIMI3gOFtMvC2FuRV+EzGA6lne83Mik3fbVwTyS0dkVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010)(7416011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:48.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1945f112-5019-4817-a981-08dc9457ba11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

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
 

