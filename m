Return-Path: <netdev+bounces-197608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9EDAD94CF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 20:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29E8E7A4FFE
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C320B80D;
	Fri, 13 Jun 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJZ1qP4y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C732AE6D;
	Fri, 13 Jun 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840727; cv=fail; b=ey4P/e6ufNLBMnu9oR982nKG3luNFDiJ3+SgARij0K+OrvDUUTyvKr7u3XRzukUIP1DMGYYrvJ99xYitr69YTwrp3z8NtyRsq38bJWLeytgljSLcFKmR0JME6t25njowtvzLGREKcTvT3G0XQVC4oNMEvrUxCesLVwt2Fchr9DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840727; c=relaxed/simple;
	bh=XiB56qM3I0Z9nN48zoF0QxxExr4Qs/aYpVHQ9X7KfyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkH5YzRB3wEO4UoOhkYmh4Zjfppz18pdTqUdlfHqzE/M/MN2pzdL7x92YHi2IqOzS83f0qi/sWohctgM/EFi5a6yGBRoxTAKyf95+Mgepbu7I4NHs0zJl7jHOvhVDc/bSMp5j7uiy5Sq9isDJ8Ufj3Tsx5jH/H+ch2ztYw7hk5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJZ1qP4y; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNZOXET2WRhcudBw7xyA9x72VljXMiXUJ0qLVf9+E8GKdNZdcXNfzORTYxuDHhMAKePelyNbrw6OwqnD/GQhhLyQPrwuhz+8pNzXfki4roSDFVrOxnv6yxlI2kK/7XAteT0rQ7wGL0Ww5a8/NqFvzwe+vs1ZYsX7ruME3KaZ62Bs6gXDIFtmjUhLKp0mjGeFp3jfEuR/eLqpKbjdCtMO46DIvSsujSWsrjxGewIIFktkqnCc7KZqADgnmFHV8plvcBLMcrYyKujFil/14HoENR062+XYpEfPHMs36KVAx4weOWZsuST1EM4UEbcoFgifHILL7O56YaMqpsBCB7khng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVUypV9a6PWHZQlw8mairoRJndMRMR1TKRuuZBcUSfk=;
 b=AMEnRvFUaQ/LKCyPNwyY9XykTmQHhjYMUTwjOabutXbgh/FRTvHh/oG+ZIuxEyBNGbR00PQDsRmijltk2A5S2CdSSXB6vJpO/Sey6kJrxMmH5B/yUj2eY7GL54t48TCDrPYtb2sesBS/e39Ns4yVtN89p4Xwj4lVL8JSRh/qUnw8SEDORpwZJAJDKgktrluUgosCRyc3fc/LcW9V13UqVK20YLg5oSXViTInCqXWwgeuyw3dgzRsbOqJgtf5L15DEo18mv0UbfeH9wF+8xjjoOb2wkxFIpV607Ud8g6FvO+GdvNogMHkV4DTIGtwVB3O3yMCqzWs7xs8LH59oaJFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVUypV9a6PWHZQlw8mairoRJndMRMR1TKRuuZBcUSfk=;
 b=IJZ1qP4yZn5DPJwvPSdsh12a3DQeV/JM6UeOafO56Hijq9jhjAD5xv8bf8ayHBIaBs8eYo+CFvo5yR1OL5j4F4IuJcdsxFShYPQju/Ziy0F+20uvVfKVZ/B8+yjFg1adUSfwTpgmwdPGbHaX1zevhmEFGAjbdBe7unQV03sSDyBNi9tFdbI84wCnLq1IjF/eeR6DlY+Dllu+E7a7wTHcILTis3/hmnpR+7aMRrwzBz0mLB6veOXkOaPSjSo794Mu8CfkYB/8Rgz8uw+5JJ2r10S+nJPSH2DNFYKaX4vJBnQxozjl4+lktB0zIAgeiT3eCkZ+VTrWk47yrHpBeG3t9g==
Received: from SN6PR05CA0008.namprd05.prod.outlook.com (2603:10b6:805:de::21)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Fri, 13 Jun
 2025 18:51:58 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::c4) by SN6PR05CA0008.outlook.office365.com
 (2603:10b6:805:de::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.26 via Frontend Transport; Fri,
 13 Jun 2025 18:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 18:51:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 11:51:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 11:51:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 13
 Jun 2025 11:51:34 -0700
From: David Thompson <davthompson@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<u.kleine-koenig@baylibre.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>, Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available
Date: Fri, 13 Jun 2025 18:51:29 +0000
Message-ID: <20250613185129.1998882-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: cacdc8ab-1690-4fea-540d-08ddaaab5ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6707V0to7zpNEloFlgR4EoHpl950Aefmk4h/tdKFI+J5j7u8ZaZhgBYOmDhB?=
 =?us-ascii?Q?8K/q1de8VRirZChEUGKBmdUZ7r1GL9zMkkHFJa07Sj9iUgvDIflO85NxB9gM?=
 =?us-ascii?Q?/C0oEIWl/H8Q4Mgdq+fbQrBOoSCPfgZRimLwr4IQr5j4s1XUthm2e9+0Z8o8?=
 =?us-ascii?Q?t3rDMxIDem1NsER6trwiMqFwLMyKBKRQJvYQC3W+xZjAYU6J0k3UrdMhVdk/?=
 =?us-ascii?Q?b+aHNWiZWSM4Yjd7xNYhs9yGUW2zx8gOPO3gahVfmTHtKDxymxTwmOR36KOt?=
 =?us-ascii?Q?SolCQmLS6nNM+1FEwfNPCNmntFgNyIB9D48pyt3QkAITIQCqR7wsutLv/gCb?=
 =?us-ascii?Q?L38cOJYvN0MwJ0OTq80+ZJzq/Y0bbtlnEqUqKDVuJMycBYQRZFb+ne0pxdB9?=
 =?us-ascii?Q?Qks+l4vQaVy/DscF55LOQfLMMB/Si6JJnZDrmNBKDosRBM+eT0GD3WKWcQwy?=
 =?us-ascii?Q?j+Q9WWjTpO8RPzi3KxY3+LaHc0smIV3OKtxcsaQMxuoTnRtV48RJxZHEvBRG?=
 =?us-ascii?Q?3ZNUYGB4lixmpgUuAlgoZdRFtC4y5V2g4U78yfnlqWEdZ30LyylL//+9fBeU?=
 =?us-ascii?Q?7+LL3HunmdjxYVFatpUZh3J1LWWubIpE4MlZBbP8atG9izA51fG4UrE424fi?=
 =?us-ascii?Q?WmCyK5UMjXPnP3vtgTlsLoOlUHdfJZwnulykNQNov2Ax4sBfGita1Ht42LBD?=
 =?us-ascii?Q?Galq6NQ3vtPGFBfofIhk03KU/VfQf4BrjaZMN8T64I2VzD7KNpYfTFZiiU2i?=
 =?us-ascii?Q?N/tTybC1pS7Kp/T6keRJb2ia5CY7DiTYkjLaCTEAlNhDixDukEN6qTV5uvbi?=
 =?us-ascii?Q?qylUo9viSEEY67qU3Qz1NMT4708hMVENI0bmXyTc2+S2Eydad7Dt7ImVppZp?=
 =?us-ascii?Q?4s34QxfgJ0LXqFNNBVfNuomThnSOSY/88z+RTrO8uvwzdY7kuKuUPC/jEa7g?=
 =?us-ascii?Q?RWffzGkrBXlU4uHE8d9VkCOwfQ1rTRQNSCYb562+ZMzMEH47fM170g5Map6U?=
 =?us-ascii?Q?bhFqEukfDt/+vDtF605GwrNINPogq75HTNfTIV4Xo6KsSjHpdAeAlobvnEHL?=
 =?us-ascii?Q?QYanV63Ale2HGtj09apOXht510MU6mnSQbmqCXOyQ5VoO6Om/LZKG2+SZ//u?=
 =?us-ascii?Q?QUdZnw7sj4eN9BkjwEJcoNBjS3eBN6kua7ZY60WpGnTaqibT8rcziwbfF/Vs?=
 =?us-ascii?Q?Cp1KjDwdUo1zPenlx3d+j6DWxJom6zQ1pEyVGR12OH8HwY1Vz2Liz9EbZDrw?=
 =?us-ascii?Q?/wQVkMQ6OZ4MrY9WergND2oRHO0O6Ar3PEWOT8UvQz4RGCIZfx5LL57UmEVr?=
 =?us-ascii?Q?WR7YOfQIJC8VBjcVsbl9pFfxwyKQEIHfyFmFd2r4mMlbWfJuEay3kkv2JKi+?=
 =?us-ascii?Q?fmLlvIVL7Qr9yfsPKaeAHHrif2BzDeZjp13Dq4kcGHruJJ3XuWdMDcyM9SiP?=
 =?us-ascii?Q?2Bdd65z6BsLlnzT2BRtIEK1tkUJ6djfN947JAJyoEYEv0PxZxeadw1tc0kYw?=
 =?us-ascii?Q?AFYJb7RuVkQbh1+CycVY5nwaDP226MH3yyfN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 18:51:58.1290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacdc8ab-1690-4fea-540d-08ddaaab5ff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

The message "Error getting PHY irq. Use polling instead"
is emitted when the mlxbf_gige driver is loaded by the
kernel before the associated gpio-mlxbf driver, and thus
the call to get the PHY IRQ fails since it is not yet
available. The driver probe() must return -EPROBE_DEFER
if acpi_dev_gpio_irq_get_by() returns the same.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index fb2e5b844c15..d76d7a945899 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -447,8 +447,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 	priv->llu_plu_irq = platform_get_irq(pdev, MLXBF_GIGE_LLU_PLU_INTR_IDX);
 
 	phy_irq = acpi_dev_gpio_irq_get_by(ACPI_COMPANION(&pdev->dev), "phy", 0);
-	if (phy_irq < 0) {
-		dev_err(&pdev->dev, "Error getting PHY irq. Use polling instead");
+	if (phy_irq == -EPROBE_DEFER) {
+		err = -EPROBE_DEFER;
+		goto out;
+	} else if (phy_irq < 0) {
 		phy_irq = PHY_POLL;
 	}
 
-- 
2.43.2


