Return-Path: <netdev+bounces-96505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922B18C6410
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291AE1F21102
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FE5E091;
	Wed, 15 May 2024 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gm6jBOZ0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A69C5D903;
	Wed, 15 May 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766426; cv=fail; b=cNZ1hW+FZNqUK+8bpIP1oko5W8nxRm3tXkBsXpIg6ZARLDnl+YcKD+NE+O1WeeLkmtBzYsz5yU1OIYLpwKO5JhN/ajn1NzPZMN770drVOCKeZf0qh6347y37Q5lXMEAbUUtKFr01RmIUxIP1CUw3slsbDM7UBUSmFklor429PaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766426; c=relaxed/simple;
	bh=NOYKPS99hIDS2xzscwN/jb2swS+cFbXcOWZmjK8r+bU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJCwHQFL8dY9XQpt7yyCmFiZMIFfrNKqsaLX37WVzscAOIR7GguFjikdi6bvMsat9lSY4isgnIenBenErHpSFgjkbpCXEhnbfP3cQC0GKFh9pwcsfV+6tXwSuz0tIbWFxx90Xjx1RquryuN4R+nePV4bswPibpuVVRkpPEn5Zyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gm6jBOZ0; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3W+uuZaBtFeldbImhHI5j8CY6AgjV9rQ0f7bEta8pIKcJLw+6yqMoGLRwCJOPPOEvIEp0Rq0Vws+VB65uomVTE/g0D9Y9s2WlDkv/hQoJ0EwNcCBf6UAlQNa0z7qZzUoGBoKnx5JexrmZjzIWrJF/GphatujKXUo55qkqD3EpUnZB2ymx4/AKoL9H/poszjkeoqvpd0Aa2vHsOkNHcm0W3VUe3vbA2i4mxgXaxINMyxaXYBBp8gtRC3n21y3ad6qy8i+2r4rnASuLeD/3C7C+E8Wi0DCfQnxSejYNDIt/WPFoDnie0iEug7C1P9x51YNj9/Ky3eI2yVapLwO3FslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeNPFMTbMI4p+5AcSurXzM51jqDO+CkcWRoTn+6dDlg=;
 b=dAbyZ7MnqIKUfSSoi/pVxc8viPvBNvWPdYA0z6rv4tNhmWKpGrf6K+d9I1xGmjqWFsegKHkwCgN27gG81yAEhAgE8p+iAWnWhq2ELccmMw4JQsrQDmEIN4At19YOeR6cOGmvJ6biWNlsfoImNi2hN3rsNy1/qyFx9mEJb40rj0VV+xHeSQDIeQDl/bbXXjUzlL0J65yEbXBFfTLHUpLSVAAeWMPeO7kvdQkS4O38Dd+O8Xar7ydvlnL2w3VIGvxqXTxW+pyeuSObkOSJzl8RralbMwzQ8Fg55vkHhvYdTobhztArJPwm8UcRgD9P6pw7UJSzBYlN35Ogmy2GmZIlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeNPFMTbMI4p+5AcSurXzM51jqDO+CkcWRoTn+6dDlg=;
 b=Gm6jBOZ0Pjy4vty13MMTmBTTwc5Aw9r+HFvEFeFtcbIiaG7feuNpL2WGx/zBjdcIbxIhU3c4qhNiF5EpJYc88w8Ngcf8MNHRmFtMV6waoefB8CYaztoHArrhtwHcRPtNkqH23qz/CTcBRoD7Cw8DQxqIp84Aoo+7ryXzXFOE8Wo=
Received: from SJ0PR13CA0175.namprd13.prod.outlook.com (2603:10b6:a03:2c7::30)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 09:47:02 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::16) by SJ0PR13CA0175.outlook.office365.com
 (2603:10b6:a03:2c7::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 09:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 09:47:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 04:47:00 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 04:46:55 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATH net-next 2/2] net: phy: xilinx-gmii2rgmii: Adopt clock support
Date: Wed, 15 May 2024 15:16:45 +0530
Message-ID: <20240515094645.3691877-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
References: <20240515094645.3691877-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c3d3600-baa3-4da7-9e41-08dc74c3f84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/Zb81u+EpFMKVeNYWEdqiXuNfRhMEYpu+k7ibOhOy5sUXyLwQlagn1eWHDA?=
 =?us-ascii?Q?Hq21m8JtAcpHO3V/S1UQGMNtbI/FEuVSBV08Q6PMZniKHl9N7br5t3TqW+te?=
 =?us-ascii?Q?Z9v2DJH7CuQJJVF7hJZ1UxsEzQoZ90wsDdzd+MMHCOEIAsYGNBRayR+NotVs?=
 =?us-ascii?Q?PSASHug5eAUVwRqhUIcb8R/cf7Tfo6VciehEyrg9+XxwF78G2CbwckLXnMbv?=
 =?us-ascii?Q?IvXGCYuPWzP1hTekSREw5Yzh84YJ47rPvTjYw7MzckQ2Uvy8j2rhOSQDs2V5?=
 =?us-ascii?Q?6yStw/zi+lgXQT9MZ+OvB2RmNigm8IJoyMR+mt40cTGpueCrJd8Gr9KB3/32?=
 =?us-ascii?Q?+4UUDQXxIZJY5Yxfem2zqonAdaEd28C2Z2wjyD2nT0gCpEnkf8L2e6v5ftot?=
 =?us-ascii?Q?sA7KQTx8d3Ykdo5Kk0mQZ9iKPZovwvzgSiUOWVig+22Aa/IG4slb4MD0+S6t?=
 =?us-ascii?Q?JVPyeOSt6w3nNwj1svbbEafpPdqMcEq5uvEVopWvx5pvicxTxCMnmIou/25Z?=
 =?us-ascii?Q?o2WSuUUe3t1a9MjwgzwSb9APOW0epioZeA8L58Jes6KNChlaYl0lbIRVRoFB?=
 =?us-ascii?Q?vEzwiM0zsFvqhO5Vnofpaz+FmB/BS1M1zXEOr40pWqiMckC2lGy178KCCoSD?=
 =?us-ascii?Q?EK5KnVURV+EGbCfjtKX9EJSyhQQzXeauiIif0br0s4x6Zcac3j5KavcerYl8?=
 =?us-ascii?Q?i+tQ8UpbYEqDFWMfLpv3l10yBzL6u5s2I+xS60o56MoAADt53l0FJLcLlHrS?=
 =?us-ascii?Q?ua2CuzrNEoxQNBNnZMPttL0+dix+HbJeJcosijiHjYz90a9mjn/4CeCH+j41?=
 =?us-ascii?Q?bO0sUB3iu2NuDw+7Dx09NSNy6FntFBx3ZBd72Qv/Zhpl3kOYk+hIJy1EeZCP?=
 =?us-ascii?Q?g0iaXfdIjAl2IAgcO29sDJkMTrKGH8YhHIE2DKYCRZmQFc/A/hAQqITLGMvw?=
 =?us-ascii?Q?rXBMiB+lHmDLnJi6SkwH7Zd01gp1J50SAu2umK7L4yPVoEHafp97hxKETKHq?=
 =?us-ascii?Q?dkY2WwRJRAgVPkFlj6UkynFtjva/XHgdfdPMDZ42Ca6gZUTbCGR90A5J6U1g?=
 =?us-ascii?Q?mIvJLlRg/4xw6smih5Eww6jW6/sLDa197x5xykdz14OOgVdHs3pRgClwoeEY?=
 =?us-ascii?Q?nImuxpChcCdoQwM5oEPw/nUIlzR2e7lnlC/zW8oDtTydeH+K2ei7Z1HPbr9R?=
 =?us-ascii?Q?W4v4RXe6qZbXBz/NkP9l6hPOLWUyMzhD9DtzMVRyNMPC2Yj5YcKaGq6yGE/f?=
 =?us-ascii?Q?zGi/AEZShMPlRuMb8xHf8gwkBe3juv9DVZVoOiKE+ItAhBmD9N8FVLK/LwyS?=
 =?us-ascii?Q?KIfR5pHfxaT8I4zSVOGytwlt0EXQQiGL7zF8meFPNG+bVLlPp8aIkCSwop2k?=
 =?us-ascii?Q?SetWU3dHwXzh2nfMRXiOLU2v38Sx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 09:47:01.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3d3600-baa3-4da7-9e41-08dc74c3f84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433

Add clock support to the gmii_to_rgmii IP.
The input clock name "clkin" from device-tree
will be registered.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7b1bc5fcef9b..98a6e5f10bb7 100644
--- a/drivers/net/phy/xilinx_gmii2rgmii.c
+++ b/drivers/net/phy/xilinx_gmii2rgmii.c
@@ -15,6 +15,7 @@
 #include <linux/mii.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/clk.h>
 #include <linux/of_mdio.h>
 
 #define XILINX_GMII2RGMII_REG		0x10
@@ -85,11 +86,17 @@ static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
 	struct device *dev = &mdiodev->dev;
 	struct device_node *np = dev->of_node, *phy_node;
 	struct gmii2rgmii *priv;
+	struct clk *clkin;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	clkin = devm_clk_get_optional_enabled(dev, "clkin");
+	if (IS_ERR(clkin))
+		return dev_err_probe(dev, PTR_ERR(clkin),
+					"Failed to get and enable clock_in from Device Tree\n");
+
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (!phy_node) {
 		dev_err(dev, "Couldn't parse phy-handle\n");
-- 
2.34.1


