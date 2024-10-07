Return-Path: <netdev+bounces-132760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1579930AC
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153BB2898B9
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C2D1DA61B;
	Mon,  7 Oct 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nryH+0X+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2A1D8A06;
	Mon,  7 Oct 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313598; cv=fail; b=IqeW3TWQXxYibvTpaAb9I/+dSNM2Fzn+7xi127F+W/HT8S6aGgm4TEA5PThMZuN4VZ8YzgmQRTG1k000DsgKXcqODanLAAPC6cHor3ByPnG14isfItUUr1U96JbzJecccf6KZ1W1iF0hoWAN35dISp+DjGoOj3W0bZk6rdWKTec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313598; c=relaxed/simple;
	bh=ubiIQlRCQQN7C5osDPhJfPt6IeIcDKHQCXXrtyOdYfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0bH6mWr3HEMyj1XReY2XScyBtODnEHyPBAhWjq6Rhquoof+EpWZ+doVjJmseGt6LNnI1Q8dmqsBWLSHPd8jl/SF9E2SGYgO7l/gIN7JQ6BL5ouIlx4oc4gsSEiNJKvVVolsIsW3rrNq+BmXZ8X6RFJyJJVYOokL0Dd7DgCUmkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nryH+0X+; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ10TH89QnD2vT9X4pObjxRrG9aQenGcX5+j7esCSe0Xe7rcpkAME0CrHPNFQhyWCkVgEeELVnuqyE99JaJYAmpy0qm8APdnUUpCvnazBu3Vq0RiRSS9Alezt26fOK4iwVYPpgncefX1Ki/qqtyBIhqUhW+gtUrTWOEAKs8xlXNRMG1kWFPNmd+/gx4QSRyksACkdpAIo6rKEaIaBGiEXaqmEUmqy2nS7ZUTKpAQISVc2+B4uGSvmWNCNw0CNW5RS4V9gx7Ud/T0cSURndSF4Mul68y9nY2dR1H9M021FaQ/LdSak/nuU5v0JcDcQMJJuUkBbWtwdsHh+zI2po6aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLyN30bJzNuhmIRRGdJUrSTAkk8c7HWdgEAlsDDTxX0=;
 b=D7LNK1phztLaVdgWlmz0eVZHPWfYuRGdS/VgFjNRhRpT59W6FKiS70jbLNOwUE2Dx5euJ9SgjlDZM0JWh1NVgRujVAE48ZtaNmLyHDeuUmsRT7zSckwRPh2aL3d9fdoK+iswz8/KawZLtrXdI/ZQQUB5IG7WAOoO4PPorY6xC20rq4ksF8wElZvlwmM2ANRjeBp8FElrV0iE7gtPnx6hoy0rua34/XAh/RMo3z/wKc1qwT5owu6RGjBI+EcG8NKzbdiX7L6m/LG20oPx+jpNW5SWxYz+0STFsti2viK2+m8WULUGKD5+q+Pzh+noPi7TcUN56mMat72TPcrvrbB3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLyN30bJzNuhmIRRGdJUrSTAkk8c7HWdgEAlsDDTxX0=;
 b=nryH+0X+3g2oLw+EHYcYMjqmJZyzTn0bAjG2FdvcrHLfdEJCevP8HA00cMd/XdOlgEr8m0VYgKGYFpU5uHdlHSxAQPUBp6o3m4t3HFI9lpfiJN4/NfSSoNKQIBi/UXObcL2siE4HZcJPz7xIie2ehz9kDOYZVkjdczWkMUEGAY4=
Received: from PH8PR05CA0011.namprd05.prod.outlook.com (2603:10b6:510:2cc::28)
 by CH3PR12MB9027.namprd12.prod.outlook.com (2603:10b6:610:120::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 15:06:31 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::80) by PH8PR05CA0011.outlook.office365.com
 (2603:10b6:510:2cc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16 via Frontend
 Transport; Mon, 7 Oct 2024 15:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 15:06:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 10:06:29 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 10:06:25 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Abin Joseph <abin.joseph@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 2/3] net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
Date: Mon, 7 Oct 2024 20:36:02 +0530
Message-ID: <1728313563-722267-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1728313563-722267-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|CH3PR12MB9027:EE_
X-MS-Office365-Filtering-Correlation-Id: da40e6d3-0e97-4238-fa13-08dce6e1a034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZUGFBb4nWUY1Zmf+AUxCx3+rPxZ3Qw3MMpwaGg5RPv4CnwBAp80rrU8hF2R?=
 =?us-ascii?Q?6AHqoum13BGHvJX1hyxqL+iQrVmr+G06TPHtpUPD9E+lUP17MUHIdMHNoTHO?=
 =?us-ascii?Q?/mkzZ8xTPscPk9r70sWEySoyeKOj5hQOsiGUUzoVIJj73LgydKckmmPTl8RF?=
 =?us-ascii?Q?SSbhytL4rl5OvIWsczwyS3eFFsfvSy2Ru1KGphQvjjYFq0DhckxFG80/pimx?=
 =?us-ascii?Q?8PLxcrwfUns6kgATH7DP7riH5KANrrM2A4FrX6Yagew+n9xD4H/ibehtiV/S?=
 =?us-ascii?Q?9Yj4oldLjgpX4oDERFQVLADuZ9jJgQvpcjkhbolul3wOhbtMIGybTzO5u7LV?=
 =?us-ascii?Q?0T8zftoeS18GGU6zzjcmyeLodCHvFP147Pj0YNdz94H/oMCGAy0T5b+Au3j4?=
 =?us-ascii?Q?u3Xg2qH/h5sB9CQfYQbn0jUhQ5Jz3tCBuLitJxwXZSLCBWpfvQ7PV+vedWiE?=
 =?us-ascii?Q?gto+BAHCfcxCCp+0skF1CY2jX0S+VVNBsHm/0DSI/j85wRcfwd/7lPhrE1Eg?=
 =?us-ascii?Q?ShH85DEzCyrcnzKhya6ULDKw05YwGitw8eECca/kYLW2EXyTBboDdS8RVbcI?=
 =?us-ascii?Q?NPlYF6rHcTgfj1pe76z0+yO5QGm9JswSwqjII+MC3qtcQfMLvY2Hr6qyryOe?=
 =?us-ascii?Q?4nZ0NyY7Yrr2miMZDPJJ3QZ5rHPiCbIVkbHgfoWpvrITe/BftqatyoHlPhUZ?=
 =?us-ascii?Q?bBIWKkYT3QTMrIX2RPI2TNn1iVo+N9mevmBP4wdW0+rEI9E9R985D49/u9b4?=
 =?us-ascii?Q?XCr8wCZMG7fc2kVyh2kerLzhD0rdEUVppjwrJ8BX1ORHvQQ6JpNqerwt7QM2?=
 =?us-ascii?Q?vfUAJz0Z5ZwLT1DARdLAT3Z0KVswZicZJZcLgZPrm7y05/6RX+8GqdcQI8U6?=
 =?us-ascii?Q?bFffhaNWAzMXpPK8Q5CsvrTlxATdZZ5+o0JjpfLcPcMCkacl1/x+L1jUSd0g?=
 =?us-ascii?Q?pnVehO2oF1CZsLgAKaIcpdKxFvIVBKnmimTGgQluWRqaAcjny6PHBlemUa1U?=
 =?us-ascii?Q?/TkoanTOUTT/2dF4NgpgakaXELS2Q94UjZqZkNi+B1JBzSIfnRSkDtVHvd5n?=
 =?us-ascii?Q?M+pMI7rwNcxgcJeBuqTkeCMkiV9aw4NhE0/bYJLowlLBp1eLUKt/sxBCWfLJ?=
 =?us-ascii?Q?l4xqVW9IgKLKf/F1OFTmk4XskRDlLxAaiMNo+aamYMYzg7gSAJ2Dy6FD25RZ?=
 =?us-ascii?Q?Onl8GjANJrgwBcKr19S8+OB/HXwqR7RauNANDlsrBlSwbNJu2wu/NjZHosVb?=
 =?us-ascii?Q?ZSHFHm3/2J4qffdq+v5o5qkWR1TSZBeFpdcF32WE6eQBQUhyl3k9Ci7NPBvR?=
 =?us-ascii?Q?6TShBxCuLLLd40qArkfSpAFtiQOXPJX+Hyitmexn7wZIgft250riBqKk7c+6?=
 =?us-ascii?Q?pDH7/aJN8egSRolTUwsnp0BpIY2k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:06:30.8061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da40e6d3-0e97-4238-fa13-08dce6e1a034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9027

From: Abin Joseph <abin.joseph@amd.com>

Use device managed ethernet device allocation to simplify the error
handling logic. No functional change.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
changes for v2:
- None.
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2eb7f23538a6..418587942527 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1097,7 +1097,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	dev_info(dev, "Device Tree Probing\n");
 
 	/* Create an ethernet device instance */
-	ndev = alloc_etherdev(sizeof(struct net_local));
+	ndev = devm_alloc_etherdev(dev, sizeof(struct net_local));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1110,15 +1110,13 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	/* Get IRQ for the device */
 	rc = platform_get_irq(ofdev, 0);
 	if (rc < 0)
-		goto error;
+		return rc;
 
 	ndev->irq = rc;
 
 	lp->base_addr = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
-	if (IS_ERR(lp->base_addr)) {
-		rc = PTR_ERR(lp->base_addr);
-		goto error;
-	}
+	if (IS_ERR(lp->base_addr))
+		return PTR_ERR(lp->base_addr);
 
 	ndev->mem_start = res->start;
 	ndev->mem_end = res->end;
@@ -1167,8 +1165,6 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 
 put_node:
 	of_node_put(lp->phy_node);
-error:
-	free_netdev(ndev);
 	return rc;
 }
 
@@ -1197,8 +1193,6 @@ static void xemaclite_of_remove(struct platform_device *of_dev)
 
 	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
-
-	free_netdev(ndev);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.34.1


