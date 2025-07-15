Return-Path: <netdev+bounces-206957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41353B04DC9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 04:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2901AA3A27
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8321E1A3BD7;
	Tue, 15 Jul 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="RgRrruNJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618DD2C374E
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546007; cv=fail; b=dfsuCkbHZvOtNqhsgzsSqqDyjPNhYEuUR5IN74594PgqLzaqyqCjJKa8OhtG/seW10DGSIafIBZ6xiM3duA6SyUBzKqFlOsYhGtZpg4BlHgA/Hgasn7tFqQ7RMRTRhHGBGF7oWeSd1ekeuvCEoREpMtnDQY5eQekHgpcly87oHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546007; c=relaxed/simple;
	bh=iZ1KxJxjWNn7U1sRfrqijrz9e2mCSYi3ioMZ8oUp0o4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BFTYjfrI4ZIBY9yQVaxULivwhtDQ2+y5aQog7neja54H+WQbPoUmqmh5ssHVNSsJJ2KmSUE6xi72gR5X4d6TZ5Uy3Fqc4F7GJ0Ld9jreJlG2yTq1sIP7kGtjhVtLNvROcTU4NBNftCmHPsH2Q0kPrQxBCDtG8gia/SJiojD5jm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=RgRrruNJ; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O53Q3e2a1FrPG8OXefGJbmoywQODn0BIhjR3FcbqHVJbncn4VKN+VKp1w9+mA7IrMhJq9xD02qeK89/RNzV7lvYjb7TSMfYFQfTJz2gBR2QmmCHEXpluLWPkOBrhavKPEbWwXUQ9YbLNxU+SqS2OXwBOHjHqz2vL++Y6cjTg8/raoBn3S66x/fGqFu5lNloRr0Jo4pKp2OQAuV6S9FBkUOGA+Kkj0wtLIbfPm0V4zjMkZXcmRp34T4MAk4SWpt5hEFiNvaAhxHSLvkHCNitYY/mXcIBMghVh5qoztL1H3oK0vCrW0+FWkcPwDHyTnWJRIJY04Q5Ti8+W5ZYwoV8Q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lfGezpH1ahmuQuVR6oRHMoSbBiFKjr3oM9Ml390r0g=;
 b=zHD/O9S5X9inmyEO6GWYADBImw70bwm4i+2Oixx0iiuUSvqA4gcwlpYmtMeb24naG7kEY2AFQjEgtTjw2DWO8/MMYoY/fjjrnkzLAhn29sJmxE8hK2jHLVRFlqusGzXVqg+MyKaEylaMwJMnQzhxNzwamv2yfjLCD8Pu/eNoN6fP8f/dheZo9f60xgP0tOtfTp7rMcvuRiUfhnYwrcV14UKvc6XofSxmgaBmQgp/OVM2Ks1cus0qYTKwZ1KsI0uPnewqB+q4dYLD6XB2hMtn45NzIPfLBEfaQvRckzXkQiF9Ax2uwVnNvBWFikHtIDimVh73ghBe2LSFDTia64oa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lfGezpH1ahmuQuVR6oRHMoSbBiFKjr3oM9Ml390r0g=;
 b=RgRrruNJ50MuIgob1uD8jwE5FYjQd7QeGhrhhj1Gli6Rf8Gd47QQOBmilkSZ6SnS7n9ge0Oz/2yS4khNWCs0B4Ea1Wms9AXFQmXPiSPriCqS8cci07qkdSHk/IaW/VQCpwEv69mYEWYfH4oEhX1pCNjiHBIKfKBeRnC5ATzSWlKdGb/y45ncLNV1/rmEyXaU7gDGOKjDgsO2X/Hr1/VCrkBajGcBIbUIRNGd8UwBDuC7YlXWJubPlJrTaxDAcYoVwZldxs3nRad24igK+Q1o+8VdtLrhM6t8QR9E4ZYQ4mFvunThrrFZ3qPFWzb5uErc3ZlckjTszB7YGhaq0brQ4w==
Received: from SN4PR0501CA0035.namprd05.prod.outlook.com
 (2603:10b6:803:40::48) by PH0PR19MB5018.namprd19.prod.outlook.com
 (2603:10b6:510:96::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:20:01 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:803:40:cafe::e8) by SN4PR0501CA0035.outlook.office365.com
 (2603:10b6:803:40::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Tue,
 15 Jul 2025 02:20:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 02:20:01 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.39; Mon, 14 Jul 2025
 19:19:58 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <fancer.lancer@gmail.com>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v2] net: pcs: xpcs: Use devm_clk_get_optional
Date: Tue, 15 Jul 2025 10:19:56 +0800
Message-ID: <20250715021956.3335631-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|PH0PR19MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b3f7e3-67c0-420f-60cd-08ddc3461a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ypDCDysLyk3qabuve0DrdppXfvcT+Ja0nM1O9UH/1Tkp4vWgbLHPL8w1XF04?=
 =?us-ascii?Q?3G+kOpPP5aLjuiVO8FT53N1Bg1iHb46CNeQym95VjbMIYbaUzcZbiZ7ooQzd?=
 =?us-ascii?Q?EGa63IkRWAlG3R4O6cRtldl0Fn7vgcUJ9/tbjY0/yClv+jJiWLmX5POHtu19?=
 =?us-ascii?Q?rORgnZQHPrcEolz5X5CCgknf/KO6vrVCN/4ItLeB7C8Lw40rK0CtO/y+7KMI?=
 =?us-ascii?Q?7WNfGW1XkeKMnYc02333iL3OXjEZFesKdSJiJfncGy3ew81a8JKgZqTgkOWJ?=
 =?us-ascii?Q?hDUozqjsIEKkh37Srr2fflQ4CBOtq3hNZpezwRIeVOfQFCtcatp+26+nDx+H?=
 =?us-ascii?Q?Q7SVVyWFgPDBxouY2lsksibduX8A0YfBYH9SYHP3moFZlvmGhlDMS/0i/Q0t?=
 =?us-ascii?Q?nlqxkUWyo+hki8fokJZJfTvi6x4DFM8iC31a14wMuuHgoc2XIIyjvsWjc8qR?=
 =?us-ascii?Q?9to/yXf+3GEfwBsV8WyeUeWQcZvK3WZKgVLBTiaYINkGoJ53RzBRs5Fg3odh?=
 =?us-ascii?Q?afTU2N1YakIQ6Zf61YC4IW1vfxczG1B400EilhON4vKH3s0DNKoLBKjEi0Hz?=
 =?us-ascii?Q?o/NXB4zNbia5Ad0aj9DYLVBi5S3/UiE9/qnLF8mlFngL17Z45wQ9DS+1weep?=
 =?us-ascii?Q?R4ArhoJtO/M4NzDqtLUMGw+JcSH9JdV4G4a9KB0Yk5NHMXXrN/nRWct+YeNF?=
 =?us-ascii?Q?sKC+mCWPVHEm+8DHEplk6Z3pus9hsPqkU+/K5HUL5gkH7VWDy7pizj5AA/bh?=
 =?us-ascii?Q?y0hFh6ktI7IVxeNlLUqdE+cAmcUfWR+CGzJyGeiVKcBXeBn6q9g6mUouu/P3?=
 =?us-ascii?Q?Yti3canVdPweIEYTd7QwjkhokZQGgNan+uRLWKXtEFbWpzrjjr++BvR+wZfA?=
 =?us-ascii?Q?E5+OuJQxo/T1xg6J168eNE6Af06MhpyjCV6nTLhvaNwMMpd5/8c35EIk6Zw3?=
 =?us-ascii?Q?0LgxJp5NTPSpX5mVr9/iniXUd75//kI/9D2Usts2XiuX28kpNGN5AyzElEfH?=
 =?us-ascii?Q?RVS1gEKexQjL2+n5qBQNpidgNJ8iCcnpsoTZNjYwrE8aqC3KPgLxPcc7d2C2?=
 =?us-ascii?Q?qzBpXJa8ek+xwwxbe3hcrEGvE48nQAlkH+qlcRiFFrMiu41Dt6RBqIps4kX6?=
 =?us-ascii?Q?iAtZhDK8prFQYPQCp94qVZYPswJ2PHqF9omZh62hu+bU+KdWBm6/BWLRghX/?=
 =?us-ascii?Q?Pl9joaAe0hpxBNhocaQ2kitau6I29y8jLKCFhj7FrkXJrX/BlCLl93L+Pr4w?=
 =?us-ascii?Q?yLJDfEfqtoRPQrk6rLzZtsCrw+C/cnuSoVN+zVXmboYesI9UWajIOlGvulVL?=
 =?us-ascii?Q?BMsHlJB9Ihty/kMsXypHaEveFrVKYfp3l3+MhINZF9TUT2sKHs+h5TEPN+Sx?=
 =?us-ascii?Q?kWTlyGP1BfvepGRS+mIHDzxLqLl4yAVyYuF6muZP2vWfX7NxV1CvheH/rYVO?=
 =?us-ascii?Q?BXJNj49E+oXQ3r/Ffs2P3/6Eo1H/PFCLIQLiZRUg07926/b6XCtuoZy0Xiw1?=
 =?us-ascii?Q?p/t2aKszO1l+LPrlHwJyTdu8fE/LHAESIUzEEnO6xjL6a3T4K1mDPkMFrQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 02:20:01.1287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b3f7e3-67c0-420f-60cd-08ddc3461a43
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB5018

Synopsys DesignWare XPCS CSR clock is optional,
so it is better to use devm_clk_get_optional
instead of devm_clk_get.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
v2:
  - indicate net-next in the subject line
v1: https://lore.kernel.org/netdev/20250714022348.2147396-1-jchng@maxlinear.com/
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


