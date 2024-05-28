Return-Path: <netdev+bounces-98405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2684F8D144D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD341F22DC3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DE6F06F;
	Tue, 28 May 2024 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gtwuBS4w"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270E36E61B;
	Tue, 28 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877228; cv=fail; b=sQRHesfzx9XbzpFenON4F4+fPHKXud/K161x5e4vjGDvdB7lxLKGR8y2xlwnnKOfW4uIYdX+RgvxkYPWwRw1thhXBybt3diI7xuUjVbufnW2cIhWZvuBrOXFmw+vaKkZxbrHDwkGpPn9Ap9p8ulNHMDj7HkU0Amx9Wd46Skuw/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877228; c=relaxed/simple;
	bh=5VlVJv5yV6i3Nky/kH+43QM0jpBYuSuOELKYXv6VHTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjesqcOQrS803x3wuY887csK4akG0X50kH5vLOXtX5VT2EeeAsV7/srAVCoFlzgf4Ezf+9ACbA18b9AQBVdXskdasKS3EUuFN6+BEaJzckIpXrXjBiU6i5lzIgqdmSX5c6rjz2rBL/WneXY6QyS2UVwAOo92lrp9CrNJmHPPdR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gtwuBS4w; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaIucjB+//c6Ga90drhMEjXzTP/DT8RV0VOeROiQ34rdmjpKdvFuvsZbgZRm0hzviGF/m1bFJ7i9m+nHzuYYiYKxLx7Syr/0U+TVN1J8+AwQRP1biEC1pQkJ4RpTQ/EsivSgZCT+881orB1gF8VkEOGWHgPMBU0s8fIi8Dt5AUUMREjt4D2QYoVqRJdBi9f1YLxMWW55AfrO8pHoCL5XOhLrzgSRTHOdlSbt3Dm/TfjXhUvpAB5V1QW7QB0sfFxc6TWz+lgAPbDIOTdSfWvviK15FWBMCzvru1q6fAla3qMmWdMoOTKnigr1HEmPFp7oRDTIPXHvT2AY0llH8IWgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKz2fyvnyIieCzaxrW453Xa2ySv/BXkmtHsBH8UfvLc=;
 b=D+G6o6hby7twvtS3MyG/kxxnVD9BC9cWurYmK+unkRSK6YDevXZaKA6PF0eoDAlKDWmRxXQ5ke0pUlHUxStbWPFdOQNdGpGwYnuhKZTL9mwXJaFkbSt2yXpHNANo7qKn1htANPyYJCFzL6uk3naK4jzsqB7dwqjB2Xaa4EwlIyuA54/8auYtWdX8do6rRi641OLNENwTCs1FBeRsSE//fj25OKHP4NKzb6ariznWcNGe5LfvPwGWa4/Z0NI6ZzdWxQeIRe+pywYtjyJvb94KvVqfFqYF5M8Yu+hJoZcGIt7HYmnm/VjQ5zO1eMx/aZRks8Q1SLkHCVdZBLM2vhKE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKz2fyvnyIieCzaxrW453Xa2ySv/BXkmtHsBH8UfvLc=;
 b=gtwuBS4wh5hb0UDSaVBybKc4OUfflnVyH8ryQ2bsrZapywF5aVK47Yk+WnfSmPGCiE+wm8b/w26WBugB8VH9xWQ0kn3akelIsnY1Zt3nkrfqrtpFlHZqQnOFcXpMsZ1md8kjcvyzoW5JhKXcfwkQYXiRi8v/LMN96uq8TethuLw=
Received: from BN9PR03CA0158.namprd03.prod.outlook.com (2603:10b6:408:f4::13)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 06:20:24 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::8a) by BN9PR03CA0158.outlook.office365.com
 (2603:10b6:408:f4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 06:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 06:20:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 01:20:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 01:20:23 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 01:20:18 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <git@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <harini.katakam@amd.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<michal.simek@amd.com>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v3 2/2] net: phy: xilinx-gmii2rgmii: Adopt clock support
Date: Tue, 28 May 2024 11:50:08 +0530
Message-ID: <20240528062008.1594657-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
References: <20240528062008.1594657-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 355016f4-a5f1-4cc0-0e2e-08dc7ede4240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015|82310400017|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrDMoAaEWm8rshQvMg7LG4ZAtrvlUJr1sN4yoTzHrZDbISNWKCh0vgmLbR4k?=
 =?us-ascii?Q?aFrRROAKzHOfvuL7hr4mH9gtexmhaKmCUDNfsE6qlTgLIDh9P6TcCA5bUGMK?=
 =?us-ascii?Q?qmXZ78mJBGIRlnQOL2hFFNSzrerCmn+OhVbOCrB2fTpWvcU645B3XIdP0emH?=
 =?us-ascii?Q?vMfJJZXKBbDnIaqybcXBpYb/maZ1B3W15uVPRBH5RrroULcG8iCL8oMpu7O8?=
 =?us-ascii?Q?q9i+2+ZR3rE715fIKGvXJ0RhUgvtM+5Wnj1TVpe1XmoKkAdDm5TDDV86xqxy?=
 =?us-ascii?Q?3y0Anq59HgplpNEmetYR3jGP757kREWmstPvvpSUsKuYzcP8GWJ92pev+wiJ?=
 =?us-ascii?Q?X+2XkdALFZ8Mju9hyMcxUpgcuch1/lDosRYdKdPtRI/eSrDgp/Und9hwVvBu?=
 =?us-ascii?Q?C73xATXQ0MyIl28cwJrdZaLrkUF59l6X9cYlzo2ljmLiDvCyFKoigVz/+CPe?=
 =?us-ascii?Q?DOUmLktmk6vohvuzeUC1vWNSuS5b7V9cyoDE+vBk6EA3pHVWm93+pPvGeWgR?=
 =?us-ascii?Q?4UphXogiR52xEquxNCDU2nytD1q3NjE3OrDpXDMTIG6JMLD51FfEUbNb3VaJ?=
 =?us-ascii?Q?OrdMm/wl+/2gaO3lxNd3l4pGVM+4N/MJIYYCM64m6jRNq/eNVnpnIhnhZltT?=
 =?us-ascii?Q?6XZC1LQQ7ShxaI/toPxgKwCwXRkqbNNt/DVl5xyIzzjwaKqf1St3ZKQReHTx?=
 =?us-ascii?Q?V2bakLgA6/SybUnRyTeuhfibpvZ0mKJX3/K3NogNFV83AnPOcGjxWcV7VyA6?=
 =?us-ascii?Q?dHe8CvGmSeJAmlW3j6qZ3/CBHXJBmutt78hw7T4Gy7C/ed9QnGB6ETUOLhwy?=
 =?us-ascii?Q?87Woin2Uao1msjMb4oLF8KZHlVEWkTqudOysjyI5BNMYBxS6V9YY2yDDWjqr?=
 =?us-ascii?Q?o0Xk+RneKPd0ssfwGjiY563IWH9bvnrng2ETWC2QbWAA2S0Dnjc51eQPIohh?=
 =?us-ascii?Q?30DfcXBGtLa2lgGU9jz04hK6s7Jy3Nv1lkA/z8Cek8yClnR7FsDJmS4LUbaW?=
 =?us-ascii?Q?MF3T8yqKgNGKMsNz2onp/xmOS2uoEbZweS8GTYlfsN842PGr1/Lq5KxLct5/?=
 =?us-ascii?Q?WGZh78TngR49COpqp4F5ts1xTR//MtmwTVW7X37/rb+mhx6qoLHPWNhR4zVG?=
 =?us-ascii?Q?CRTuhG0LKkuar5VfokYJWt2LjKL/ikj1EnVqRoBKGlHnmiFp9bv8GSRGZM/p?=
 =?us-ascii?Q?Q03+gU5Po2/9I5EEwNMlr737haH4RWUaoudnNVp7fvC6Z2DaMBuDfUn4MJ+d?=
 =?us-ascii?Q?zGduOt9A2lPVNjChQLZUik9M6fDN4bFXPW6gf/ZedHTKMQi1f7V3hP8Zv3QV?=
 =?us-ascii?Q?5C4vrnygCMHv+JreH21hnTiUpFl+d9WbCBdwoxMfP97KX3hoDgQXBl24tsUF?=
 =?us-ascii?Q?Xuboi6pYQEbk/9d8JblzViEAHwS6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015)(82310400017)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:20:23.8632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355016f4-a5f1-4cc0-0e2e-08dc7ede4240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

Add clock support to the gmii_to_rgmii IP.
Make clk optional to keep DTB backward compatibility.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/phy/xilinx_gmii2rgmii.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
index 7b1bc5fcef9b..7c51daecf18e 100644
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
 
+	clkin = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clkin))
+		return dev_err_probe(dev, PTR_ERR(clkin),
+					"Failed to get and enable clock from Device Tree\n");
+
 	phy_node = of_parse_phandle(np, "phy-handle", 0);
 	if (!phy_node) {
 		dev_err(dev, "Couldn't parse phy-handle\n");
-- 
2.34.1


