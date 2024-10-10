Return-Path: <netdev+bounces-134295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FE79989D5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C43028A460
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758061CF280;
	Thu, 10 Oct 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M/V1XoRT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DEA1CB322;
	Thu, 10 Oct 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570589; cv=fail; b=KVPkG0BfNT/9BFUxg4qUVqRUBqPU/V1TNrAihuTtm/vC91xfT12uyDePxc+TQf7n/0dkWvAOAXewpFUVqUykrkrzQ5pHjuK0hHCWBV6KzKSsO8JILcuAn8jmvJK9iQX7XDvJ8AwNJY0xFxYCJWIz6qMwLozMmVTFRLpUSgbEjtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570589; c=relaxed/simple;
	bh=Hs7V2Qotsdk0HCFnmNxjv/AyvziuuvBpFGpWiD0dXI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QRg5SUVNdx9WOai9FKo0uldxcQyERt7lgUQbXhc1nQsvZNb6Y/0OZwiK0arAM3rjzzhV7NQoVYVVw1T2eHtXiJte/zxKDRhNnOgYK6hx0OvzXPCd6KjRH6gNjGgKGlVhMUr5fLZubA79FuF9Z3DQtKCpoFtcZCl5Lo8ZW5zxMXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M/V1XoRT; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4yauMDQJw2TrPLyWO32Jic5zSTdDPm1Mspv9eQmAMOuhQFIOqqWIto8pW9lEBkuenGZmPxxoSk3znbLRklSTQTVs1Miq+eI5eL3hwIAE+rmR/yEGwl1gAOvx3W1igrRy6sPdqW1qvYm0uQYUhhW/ZotxwFt54Sbf5AAK9wJDFz3GNDaWxWx91LfdnZTsx5tnnXRY8QOIT9f16Q1tmNLOxmQ+GDW53pFyy5Oh++p9vJw17KtQnbI26dRCUsQYIHQJJ+Sqet8vpCYadixWXZ9+xSN7GGBduVyspdYB5eQ6t85NIhtlxSwGIUQEmLkr7IOCIqaXGO5p43xWBUesPQZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDbt0tqFtyQlCF3px7rQYIpMnFaVzDVs0EmqBpi8NpE=;
 b=ALgkH1GpenAb59q5KfsFKDZaa3kGtcppvlk1jbeQGIBZqK8W3CVtD7IMAa4ExV4qn/qGoCuPCcafw9O3pP5b6g14s5MgD69cN4GShAcXGCnyoiWJKBrvPu6sk+0qmkHt5ZApFETumzkQmnSD7cL4DYOTgt4g1cPRwUAT6yyxe3R3hd3D86r5lluzgVjH1PYxbxO1qIQSvuwefx8co7i66Nrmadoczgv7z14ujOcrxIEgT4m13ebC2f3IGCnMEk4OL1Cvf9eRIPKpY0MxrUQh4TOzFWxdBGEGph0Ztr0gxoZnIQ/Tjzd1awFG2OphP9L12V25M5Il9pSNBOmOs1X9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=foss.st.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDbt0tqFtyQlCF3px7rQYIpMnFaVzDVs0EmqBpi8NpE=;
 b=M/V1XoRTivR5FgbWW3ArRUUfJRQt1qakQVU/KwXTNm7C24R3kQQy3Vrm1OVCB36f0QnhmEaJm7sR09kAnKeVFR+VjtTrAudiGpS7Xh8KQUEOL3cfMDP0s1s3laX1grnOi8WYBS6sjmDV31PicU4dY5utRt2gOb7L5UF1qV6Ht8kcMHzgrCwx93LNAPr4AcVnvnWQUIOd/rb8oS+cqMshwXJkwFo/tVNm+HWLWecRqrR+Y7AiJtxaM0wY/ZrCTaWxAmlW8x+b225MXtua408ULNFIHCaqhdTitFBZWjlWGajoQErTYlhydso84+GTUYmsWbD3c9UtEszhvhAXAMjgNQ==
Received: from SA0PR12CA0012.namprd12.prod.outlook.com (2603:10b6:806:6f::17)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 14:29:42 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:6f:cafe::77) by SA0PR12CA0012.outlook.office365.com
 (2603:10b6:806:6f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 14:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 14:29:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Oct
 2024 07:29:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 10 Oct 2024 07:29:22 -0700
Received: from 8306d05-lcedt.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 10 Oct 2024 07:29:21 -0700
From: Paritosh Dixit <paritoshd@nvidia.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Thierry
 Reding" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
CC: Bhadram Varka <vbhadram@nvidia.com>, Revanth Kumar Uppala
	<ruppala@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Paritosh Dixit <paritoshd@nvidia.com>
Subject: [PATCH V2] net: stmmac: dwmac-tegra: Fix link bring-up sequence
Date: Thu, 10 Oct 2024 10:29:08 -0400
Message-ID: <20241010142908.602712-1-paritoshd@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8342448e-3aa8-49b1-ee6e-08dce937f9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ka/bhOjtcg9T+YdDSmwNNm942TOBzBvMpAa0JbRbR4k1Z9wonU8Zyz7mjxwU?=
 =?us-ascii?Q?0Hiuosaj3MIPTozKgi/U7tm9LH2Q1AbSEaR1uiOYYUxpY0L+DkM2Je8HKDHN?=
 =?us-ascii?Q?lqWGkZfBcT17dqxTAgWj19+TknMZjDZQUWr/Qz6m4ZFiQ5Q5O5ij6bae3AbA?=
 =?us-ascii?Q?zwV6QW2Shmbi8m0ExlSiww9LZeQtNCpz7rXsep9M6kcADEf1jg8Nebcf34l4?=
 =?us-ascii?Q?9+NUbpk9PrivFI6fs0SoV0sBvjRPg6+XNMnI0453JojLotCS1q6eG/VxmsGC?=
 =?us-ascii?Q?RyMHhwB0zEiVN+CGNcsuxjVwAV28/biFHIGkmgGOPOqYxrF7I7mcy14ekL20?=
 =?us-ascii?Q?oYeG9Oy8gOCnWsBnZnHWrJlverSFUvtoSuPQjSOZM+VXH/rmRAWGvml8GOfe?=
 =?us-ascii?Q?WvcBoNlIBultCm7DfSi/nhqGJMgFhFrTz4qeHbnUaItprVkU1gwkRv2wCO4M?=
 =?us-ascii?Q?q7g52QkI0D+vsbi2C9sWBMamZSMrriASCTRUC5q1JaYovKvwvizohvFhqOBt?=
 =?us-ascii?Q?vIfk20inLO4zW/R/9Lnl5BBouOAYNPJZFniT0awYAhMZ5kPMMsDDcqktUWko?=
 =?us-ascii?Q?6oHdjPi3KEQQwwYpe86fGmp158oNzJwu/xRlK5qL/WdvwKA9uiRpCfg5/p74?=
 =?us-ascii?Q?FzCIiBP4XcjeuU1BdLq5cj7K6Ydw9bFFx4rR8EJyGRYYuWZA3v85JADnl1KX?=
 =?us-ascii?Q?fnVkyBw3dwpaBtkkSiEOU4GsSJ+v49N1OzBo7TPmYcU55V0vqSFrBxfIlbZF?=
 =?us-ascii?Q?9WqW0nHVCEOuDdfSZqaMOllVZKzCV+0GsRwzSkTcU5B0Fc/9aBKG1YTVUyYq?=
 =?us-ascii?Q?elOGCgP20bQmSBU3IfB3h1bH6qpcw/o7kKBHAlIDZwcpKxgxdvbLdQLqs07e?=
 =?us-ascii?Q?PRepPG0lEL8yXJTRwCkMU/ZsswdsbO0nvh1jvX71/PRSNbRRF9yyDl4S2/Mr?=
 =?us-ascii?Q?KI7+m8lpBMRS6wX7GHqlf/bUz1/ki2TkrRWl5ccyF/mOj7AsY1VJSMKoiEZc?=
 =?us-ascii?Q?J7TOMOxbKeejwJJzbMqvEU9/r2Qnp+xs5o+55HpYmMziYjubV9kCmc1Hps9n?=
 =?us-ascii?Q?XidSTqUpjIza2KmSBuS6Z9d2laBpDvOL8TkoOFFkQZgp5TJhBL7XVJC7wXlp?=
 =?us-ascii?Q?teFk6TxZLnS1ddIc0rh1Y7Vmcnp1eyMWs/nfJ0vgUCVFSk252nd6feKNPJMq?=
 =?us-ascii?Q?KDC7NoAnDk6A2dIb57rYwCY/m2ufCDYsv3EEtUAoOx19XQCynPjyhCJYFbPs?=
 =?us-ascii?Q?MSPN1uYL+YISggkrQ8cxkfmsLr0bQyKM/W4LuxCPD2OKCRQ9+TAPpSk6nSQY?=
 =?us-ascii?Q?KZzXC/O2N79ZFZ8PyjCv0+VtQ2lj2oIUHxWe1bQrv6MJhorkXBtDoB+uudRa?=
 =?us-ascii?Q?6EDsdgSbg+HdGRI9Ox74XfR8CXJD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:29:40.5224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8342448e-3aa8-49b1-ee6e-08dce937f9fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137

The Tegra MGBE driver sometimes fails to initialize, reporting the
following error, and as a result, it is unable to acquire an IP
address with DHCP:

 tegra-mgbe 6800000.ethernet: timeout waiting for link to become ready

As per the recommendation from the Tegra hardware design team, fix this
issue by:
- clearing the PHY_RDY bit before setting the CDR_RESET bit and then
setting PHY_RDY bit before clearing CDR_RESET bit. This ensures valid
data is present at UPHY RX inputs before starting the CDR lock.
- adding the required delays when bringing up the UPHY lane. Note we
need to use delays here because there is no alternative, such as
polling, for these cases. Using the usleep_range() instead of ndelay()
as sleeping is preferred over busy wait loop.

Without this change we would see link failures on boot sometimes as
often as 1 in 5 boots. With this fix we have not observed any failures
in over 1000 boots.

Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
Signed-off-by: Paritosh Dixit <paritoshd@nvidia.com>
---
Changes since V1:
- Replaced ndelay() with usleep_range() as sleeping is preferred over
busy wait loop.
- Replaced c99 comments '// ...' with ansi comments '/* ... */'.

 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 362f85136c3e..6fdd94c8919e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -127,10 +127,12 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
 	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_AUX_RX_IDDQ;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_SLEEP;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	usleep_range(10, 20);  /* 500ns min delay needed as per HW design */
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CAL_EN;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
@@ -143,22 +145,30 @@ static int mgbe_uphy_lane_bringup_serdes_up(struct net_device *ndev, void *mgbe_
 		return err;
 	}
 
+	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_DATA_EN;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
-	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
-	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	usleep_range(10, 20);  /* 50ns min delay needed as per HW design */
 	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 	value |= XPCS_WRAP_UPHY_RX_CONTROL_RX_PCS_PHY_RDY;
 	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
 
+	msleep(30);  /* 30ms delay needed as per HW design */
+	value = readl(mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
+	value &= ~XPCS_WRAP_UPHY_RX_CONTROL_RX_CDR_RESET;
+	writel(value, mgbe->xpcs + XPCS_WRAP_UPHY_RX_CONTROL);
+
 	err = readl_poll_timeout(mgbe->xpcs + XPCS_WRAP_IRQ_STATUS, value,
 				 value & XPCS_WRAP_IRQ_STATUS_PCS_LINK_STS,
 				 500, 500 * 2000);
-- 
2.25.1


