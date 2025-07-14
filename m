Return-Path: <netdev+bounces-206489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11E3B03472
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 04:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8F31747B2
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062217333F;
	Mon, 14 Jul 2025 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="NjXY3ljS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FE1F94A
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752459841; cv=fail; b=byKNxIlgaTt1kX7N52W22TyX+SGZn/rwQFoL82ikWcqMd4PyFZDYAXypq3YhsOHhZiI/6vh/EkRFWHGSprllJ0ZqZiVNG4XFhqc0/0YYJp8xbNUrnCkCIhzD45vsH4NVqsiksDf8M6YD21UTS9/D5iCVgSndyqaf/f53qlSRy/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752459841; c=relaxed/simple;
	bh=NjY219tDSyoi2Xh5V9PQvURvsUhnPMC4luIv9YeXcYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOBhT/MmK1pcn+74Y2bBKYVvQGWz1NPirCUM+4rRmY1oPSTFkgQX63URnaN1UmUtT98lkS6F5OgoR+h4VanpEr/m+2PrZyiygACzOgVJjQ+6WYlGNn9X+NTNheBRAi+VV5PbCEfL7HZJmhetZ07da8k+Ub3zUOmTfOxNW5I5KlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=NjXY3ljS; arc=fail smtp.client-ip=40.107.93.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB81aRXaw/eAlucsrydkqueUGBFauHg6G6/XiYA+VFzIsdxaGs0oXHHLYQr/r+UnAolxDZEIZGl/zOsaSuRxZLSEAeOXtW/NXc+DLo9HZvJbU60K4LaHo/tqLLKFuilr/Gfh6WCZJr/nT2EJLGNrgBaIpwC0NeiAK6/b0651K85JRaQrVX1I9LZrM4l3vqRXdWawjJh+w0X9vgDneVglqnxGmIuYhVDflhemLATM0EnKD3cgvcKA68rhT4TJpw8HCZ/mujGE3ZPdWkIP28wyC1kRqK9M8BchrcSUKAZ0A4EumXveZQ2D33BHmHWiN0F3Wq/p5tC6gywBEVmzdMMe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT8yrxri4810f7GEuWrpb5sj1LK+2zcnQTq544qn2W4=;
 b=FjdrynT9W+jXBPBbX4DA50NOHM4kTndh2os/y53QqQ3rMwdPjR3LcxH4GPIPWBG0bWNIwHCTwKxmOUPxi4F3PGgnp3+WSRRyrX1pa9UAvTwDvGtqZIu/FquQ4GQAWjvk5eXHww57jqmxLyeNK0yd/rQARqmmJ9YIq3NDm8oWYrRrxA5uL+ycoN7rqs9HSWAAPkMlrbcSTq2He6WDx/HQW/WEP3te98XUMNPQHLHwAD3TZ7SrihZGBBx0mD0UtNFt9D6Qm5xLO6qVzUCu3OkGAjkA2dM8+T1MiGcWC+HebozZYgxZSxJAzknrq+niDAxbPDJqLzWOR0hQW5+3f6+EEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8yrxri4810f7GEuWrpb5sj1LK+2zcnQTq544qn2W4=;
 b=NjXY3ljS6qEdvzmAhEO7fAM7+PiODB9JY0R/pTNzt3blWGAtuWcJOFmWNPu35WLtspsLTm/ik5s5YnqkjeK4ZdfY3TIqvMyz+L3nKsGFDje7+zf6/lmXPm6ZYkHL1zc6u+ot+1ubRJlNJ7MnngajBgA6Ieas5uc+vnTNvVHqTuFJjQckdHeERE3XBo+drmeHEwG+IgjxTJGL8qWf6HgqPwCArOVH8n19Mb3tP0vLnaoJfDz40B61IbbDP8FqQRGWTgf4r8KZo1hVtBEHPKrzwaZ45DI+LCX6RgMajnYVk0zLeocHGA30FdYOQT/9KoWD60JKsSiPeaAd9pzMFHWM2g==
Received: from BN9PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:fb::21)
 by BLAPR19MB4481.namprd19.prod.outlook.com (2603:10b6:208:292::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 02:23:55 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::80) by BN9PR03CA0046.outlook.office365.com
 (2603:10b6:408:fb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.28 via Frontend Transport; Mon,
 14 Jul 2025 02:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 02:23:54 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Sun, 13 Jul 2025
 19:23:52 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <fancer.lancer@gmail.com>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH] net: pcs: xpcs: Use devm_clk_get_optional
Date: Mon, 14 Jul 2025 10:23:48 +0800
Message-ID: <20250714022348.2147396-1-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|BLAPR19MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7d42f8-d8cf-42d8-20a0-08ddc27d7b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlPW1nRjawWZ87LfV5fzj96LPaxZqA04dgNHhrMJXHNuvCxCrHjlkS85/jWA?=
 =?us-ascii?Q?g0F1vhrNeWBEJ5K8Tb3fKSOsctipr83lpxJYkGXBK8mgT+ZSPOINCy6dR61H?=
 =?us-ascii?Q?aGEH7GfM7utVZ3hPXIsCSudXLSTpGpj7suWHWZk4Zuc/gJ2PAfRNdRrD+ihr?=
 =?us-ascii?Q?dLKC9P324/F/6Xd/xYZzVoP5N/ENfzcEWSrOiw+Ej5Yy6q9qY6aOeeDhgpez?=
 =?us-ascii?Q?OUpRvDBS1GISMd/Yn+bDDRGCROb1Mp2p8dhl6cyfLqm3WPS95Th6gGqkMHKy?=
 =?us-ascii?Q?8DWJb9TF2skr1aSRorBjLpJYSd0ywgK6L47TbzHfw5BBHLINww3v3ICtcUY3?=
 =?us-ascii?Q?gxhBXhDX6HGDDLutZjcQtG3M8wYmZNJwMlPGNa+lqElbdJnK3vfgW9Oji1ch?=
 =?us-ascii?Q?d7X73xc72EGJzlWW3QF8NmxKpyLzq2ZO4Pv+2dKwjVNXhfp1tzr9U+6D7/te?=
 =?us-ascii?Q?DGe30SdYeBY/1t2GwWar5gd14T95WZn1KLxKiB+D9RevrcBTGnXlrTmXj++F?=
 =?us-ascii?Q?rjlKBD/c6YmOPdwrkoM/nlwaSINeutVd4QJLdK8lEy89il6ecbL3kZjuMsEe?=
 =?us-ascii?Q?UJ8ZwJIvUQSt6IihgO3z7me2isTgEDwPfDRBnxutLfj/ryq1kQZ17d54ohla?=
 =?us-ascii?Q?8ioFsZkBZWfTiDwodQFL+vxHg7EONkQwi1U6P8zjCmrqVnUz9qHQKCRphhx9?=
 =?us-ascii?Q?qHTRYPXrLL0smhuNKkH0A2VWH839ThIed/wYgSsmpnPSEVfjrDCP2np+Lzpc?=
 =?us-ascii?Q?tDR2RS/1frhjYsR0kBVb5MDLFGSemp+Nj7EpulCQ253c0t2Y7/mKXJC5MsDt?=
 =?us-ascii?Q?4FgCm5xo+1CAM8NIfRvKThaIkvDf/0wR7ius781r4i+48p6dI8KZpx3hrpmq?=
 =?us-ascii?Q?sC+RAxAkBKO8BTr1aOwTtj5vvIPOCaTjVzE3qpVjzwLx5R548DcnJ79unGsG?=
 =?us-ascii?Q?AsSjet7ZSqmy2vHIF9XLinVWwplb6E3+t1nNTqiJ++w+Gqhd5oMsxH2w+ge0?=
 =?us-ascii?Q?Tdm6AHAIzy1HIJIWYY9st5s25JtiC6aLwGW767XMMSe64BJcIbgFSearE2Sq?=
 =?us-ascii?Q?Vr20aL/JsN97+6Pt0EKe48m5eg4Grt/ma6EAjZ5MsQ6yR5UvKkYx9v3RFPQv?=
 =?us-ascii?Q?GLMQO3ogvwozJdIvXPiZa+DhN+qUut82t2u+w6gXF2d8wyOkLGxZi2S+6C4t?=
 =?us-ascii?Q?WbUnZwts/wfjEJ/kwOr3zVzvgQnLL/Yb7XubQyrjACKG1/8sPfa1m7GzTjvX?=
 =?us-ascii?Q?k+ljpH5KJaTsuEO3RAjMnipu7/SITO/J4DKRmeyyIVj5MseFaSPrjXk0QBat?=
 =?us-ascii?Q?Xb4TXSWDaBPMYSBFrZbV1foYbtB7ZUsME3hck9fqFfPqVE8rU7GzA5Dp3irW?=
 =?us-ascii?Q?/IaV6w4P5jK9AKZejbAOshEf70/Pedb7k1jCukppmY9hSU0kDUx8JitLHg4u?=
 =?us-ascii?Q?G0g1QQqP2JLStD3OHDUKIjW/2ge4bCm3+MY/jP7omIvrRJBoAwRUeTKlgT18?=
 =?us-ascii?Q?J0jCSGYwLa2g/OADu4iCj5zUEM8+irJGZ0E/?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 02:23:54.9769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7d42f8-d8cf-42d8-20a0-08ddc27d7b43
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4481

Synopsys DesignWare XPCS CSR clock is optional,
so it is better to use devm_clk_get_optional
instead of devm_clk_get.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 drivers/net/pcs/pcs-xpcs-plat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
index 629315f1e57c..137d91038fb4 100644
--- a/drivers/net/pcs/pcs-xpcs-plat.c
+++ b/drivers/net/pcs/pcs-xpcs-plat.c
@@ -280,7 +280,7 @@ static int xpcs_plat_init_clk(struct dw_xpcs_plat *pxpcs)
 	struct device *dev = &pxpcs->pdev->dev;
 	int ret;
 
-	pxpcs->cclk = devm_clk_get(dev, "csr");
+	pxpcs->cclk = devm_clk_get_optional(dev, "csr");
 	if (IS_ERR(pxpcs->cclk))
 		return dev_err_probe(dev, PTR_ERR(pxpcs->cclk),
 				     "Failed to get CSR clock\n");
-- 
2.43.0


