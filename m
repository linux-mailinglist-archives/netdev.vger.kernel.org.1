Return-Path: <netdev+bounces-109765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CAE929DE3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D86B1C21E5B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A03A1B0;
	Mon,  8 Jul 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgSnc/bg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9403FB1B
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425737; cv=fail; b=gS8pTjhgUVam0Dn6J8Ee2ZUOmCBPXW+pA4+A2dtb9atcHWwN/K02VeSeLg3GDXk/NcnZn5HCqn9DlP5sQN+BtbGGAKdVBXwZZM13Tfvpgv+uGaSXBpx1NpqZ2PYSZ8ttN7pra5l4hPmf+HAgHNhWdC3rM1R/IThl8mtvsfljgws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425737; c=relaxed/simple;
	bh=AvCqdlCiJXHWyT9b5mhi9d3ljkSK3B9qSsSGUF/1QRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtWxGyGwxCFkKDvgRxeUx5jyuInhVaA8SUZfngiGQVDh8p0uPw0raGNBLzAAL5cCTHfYVb7vGryI9ylftXynFAjHTfnjoWT2/uyiPbH2R0f6mh8csUDL2YYMB9zF4lhLbDXRLxyG+oEEpohmEVX7dXGbacZJt3Fv8gA874NMqQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgSnc/bg; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATS/Figvje9VNF88Igl97+uJ51kAHfNVjJdljY8tNU0uOH83ANiooKjlcoeG13FfSdXMxQLhZ+dMm1mERx/r0SU7rXbG/7Il5DzFg2fvdJ0i8VH16gJvyYA51pxGLO5h2SlFrzpzBLITMp9flQ2PMjIsQXJiPKengmlrO8kF9Bi3TUObhlfxh/Fj7lO4LIQRtqFw0R6OR3Ra/B5Msu6SIo2VVV3mWCAMcGFldnYCiv82Sz4LnnP6uqS7xh0LzNUCQ+5thPl7Q1anGtVWaMpjko9BNY2Uy/m7+D8opcG6p8Xt+ek1CjDUg1Dcl0YxKTCGnHREaHjGoV/Ilx9QxQme8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoIPinypRkgaCuUF6f31Slu3AfSCGOy1lXRq3AJaOA0=;
 b=DMgraqyrphnBCRQvQs4X00LM1j4IW10EL3zTVPsg3JzzJ1SvAyo1k9dzS8nwnJDRF//XLiSouAQHjOh8D05m4Z6HbyjqjVum4pvvSRrCcyjpfcDJCJS+0kvwxbc8nE4qmrnPoRbtyw9xOLFD8DmPdRIu/3HtlJbSl+Fhc1iKiwWKxfWjFYd2tFZBL0qRGafMnLxoclPZg37RxvoohsBooNRpPLK2Rr4fKnqOzW2yi2L//HniJqguaAPfR3kSxeSuPPbdTHqOGWZDaTgSXXvp7JgYpDgsvWejxOk2s920tmKdovts32NY4c/mja2guViNh6hAgeCGTI3utIjTYHc3nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoIPinypRkgaCuUF6f31Slu3AfSCGOy1lXRq3AJaOA0=;
 b=hgSnc/bgQ66X9gyEYqOphJ+zCVnFRwNO22PMG2TSF3gbrnf2BFe1yWRMgOz4G0sKhAjGctVcefISQrrhFhDJRLGjJ6DUQdjk9psnfnWuurAPCwW/Q+tVs5iSaToeDTKpzQxQJxnezJRDirFqgEwTxLN5Rh2S1qsaM/sogL+EZY889X9XcTazd/kns0g1SqMxLjPwRCHR+qTHexcLisp5wcFOF+rIO7o/RtzATAFfYQQiQ1W+32FuTslio2ZLP0Avubk6DmErWQCLMIY+MYFTtItC0gCmle9n12ntqbSO6XL34BYp6QYwJV27oxM2PlfqyfrHJh0spQw26ia/5zdtgA==
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:11 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::65) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:11 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 06/10] net/mlx5: Add support for enabling PTM PCI capability
Date: Mon, 8 Jul 2024 11:00:21 +0300
Message-ID: <20240708080025.1593555-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: d77c0e9d-4817-4330-3b1f-08dc9f2445b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?019VykUV+o+ZxP9ClgcoFCZLjESM1u3F1Cb96KFcMKtqzXYilaF2FrXGrRkL?=
 =?us-ascii?Q?B3nK5T/KcLmQNJdFNuqAOf8vD3DVTuNklZgnGzJmvZL+F0X34kiQpP+MwkHz?=
 =?us-ascii?Q?QC81acMta60Ep119oYx6E/WrhNpf9vLu0jw6ekoQ2uVDP8X+E6blWxD0nLLK?=
 =?us-ascii?Q?52ni+ulEFIGZV26Sd1svYSUFrtyhGAcpz7ZUeYOcT8RnBX2SEDxntiECQ/nT?=
 =?us-ascii?Q?G1iyNaGPVPtsNZ7+7D6BDjeqKQBfzowpDx9ZkRhL9wG7ICKWBVc1ffQyFesN?=
 =?us-ascii?Q?c4l5yE+lHBw/PDruN8dEaViQMROPrVPYlDBx96Nt9zczmCVzjsTh3EIg5DAz?=
 =?us-ascii?Q?7sEYypl41YyF9sXuRbfgIZhghysCzCODo0ZFECt5qJovMjEzIBT4llntIcqB?=
 =?us-ascii?Q?7aj2tmeMBhfeet13TR0JIADKTmSjTvC2g/TaSWLecmydLLfNbBJLBqleIGQ5?=
 =?us-ascii?Q?6hWYmZ/XqCMUUBt92LkGJzkGJJ+QOiFyrmEdB9HTvpfSad+OiPKk3971+bod?=
 =?us-ascii?Q?zNESWBy6jFZPPSDOv/m9L52S6pd+elAtKowEHuwd4dmfrhGkk9ULu69so/tR?=
 =?us-ascii?Q?zYYLRJfhD3iwdMmIWEQnGs0/8TW6xg7ZFNob07k38j6sbbfY2yyy2PXsBkEY?=
 =?us-ascii?Q?AUCuDR84hqRiPm264/TacZuH1zAA5T+/G6gqBMeHBvPtYQaGYdTXWvgICMCi?=
 =?us-ascii?Q?rVpbq1t098CK7c9zRs5CGUSAfRqU27Xr9fsCxmOvG/PhySaAvurSldEZa051?=
 =?us-ascii?Q?Pi21dcco9U8MZivw6WjSecabAiMjrDsZgUAdaB0a7BFpBkXnzYopnHfnuRlS?=
 =?us-ascii?Q?QbuQK9/KitcLyaZHChDBlykcAKMiW++BgOU3YhkZsHKn2k7RzBob8A5rhW9p?=
 =?us-ascii?Q?GGRWIJXn8jUWgu4cOEdvawW+4+/5EJ4fik41xGjNQCxivYSJUZI7AaJ5rc6e?=
 =?us-ascii?Q?EgrtwjQnXH6pQCdZ6DVD6IDYEKHtNMLN7qY4EdBetbyenxKvhxFBeOVZIUuk?=
 =?us-ascii?Q?n6CCWAjY/KtwmbjByyprYv4v+WIlYrYJiyC3pW8C5L7vRxp281rkiNeoB1Hk?=
 =?us-ascii?Q?YNqZ+1ZRfXESzCgMv+Y/MAXxTcQqzIHsO0/vin9+M4AvqsHhGB5FmJESIz92?=
 =?us-ascii?Q?RFlhMVlWIoJz0nk4a28bCqWfsZTVMtdoCbjcEqHe1rZRKbHfhlm7FCmPADMV?=
 =?us-ascii?Q?2HNTNG4OvOtRbdD3VAD0P8qqxr0eOCCFFN2Dvnyam2fOmp260R0u2BcVZ6G9?=
 =?us-ascii?Q?W/NF3YsLEz/769c2qKgj3ZZ0Ot/ZISWDcpb5K7e1KRVoXEfGZQgW2OnlrscQ?=
 =?us-ascii?Q?YAwttsGY3/SiiiE2iYpl3+lT1XGDFD/dKlMPnOxUWxcMTedKYSJhq46V+6GX?=
 =?us-ascii?Q?0K6LSZXdjWXHVzgrlutCWMkIJTMZje3HD34kA3YLvqxqDtjWBqVUDhOySKub?=
 =?us-ascii?Q?yyMoNhHyz2OqP3vDnxI80vxR3Z3GIs3X?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:11.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77c0e9d-4817-4330-3b1f-08dc9f2445b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074

From: Carolina Jubran <cjubran@nvidia.com>

Since the kernel doesn't support enabling Precision Time Measurement
for an endpoint device, enable the PTM PCI capability in the driver.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 459a836a5d9c..31a43e0ee57f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -923,6 +923,11 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 	}
 
 	mlx5_pci_vsc_init(dev);
+
+	err = pci_enable_ptm(pdev, NULL);
+	if (err)
+		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+
 	return 0;
 
 err_clr_master:
@@ -939,6 +944,7 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 	 * before removing the pci bars
 	 */
 	mlx5_drain_health_wq(dev);
+	pci_disable_ptm(dev->pdev);
 	iounmap(dev->iseg);
 	release_bar(dev->pdev);
 	mlx5_pci_disable_device(dev);
-- 
2.44.0


