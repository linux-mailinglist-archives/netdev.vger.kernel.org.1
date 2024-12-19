Return-Path: <netdev+bounces-153482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C435D9F82CD
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1A1167F23
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AE01A9B55;
	Thu, 19 Dec 2024 18:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZrYz8rv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983901A9B25
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631218; cv=fail; b=s7PsOJ2sEYPwVb1AlAf73tlUunaqaxDndOR70OZ3c9zQQGWucATjJADhewZr1/FpdkX1WVKXSTEW0e2srtap6t28XLnX26eWGJwOyRegKSn6L2W3I5JmkRzwpN1G+d/Eecj/EODZHj/AXl5yTGlwIATZYhixKZQSnGcurNZF/0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631218; c=relaxed/simple;
	bh=6WQCYKvOWuBayD9weVhw3QcE+4/Gj+mhpLh7b5bhoNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pf2AwWHCFYo3gFmirO44xo3X4qruc1H4Kix0XNPmBTvfl0Ktputeo/u9RmMwWCTcE+3+WlLRahqojcNtiMHkQ706kz9TG8bBT9pHf4tAFYjQeS84OVb7JPxivt3K1jVKFbiBz/dhcOJSoT2vmvGxt2iB3Gd6z+RVXxVxTrkTk+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZrYz8rv; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8HdsJ8xsYSIpjSXKFIzq0iAtWr90qnMISgBVvVvL60Zdcvamm2CK9abo7ZVpnnDRTYx1Tf1m2Bhg8NZmxSwnu72Xft0YQ9zm1W835E3kjuWtuHVYzqQEbefSbxkUuR+CP7rXH44PF3eU9v6l7LrNUpyonsZMGxe9PGJeAuzVO0a4YPCnetOQ8Jfi34Z6STvt6SSr7VetLNbLDsHWWhLsKz47vcySP3AdCCotcSm2aDXdlys1ntU4CnvVCUfsFSauGtR2kpkN3VUUkUcDJGphPCOOngjH8iRet679pH77/ejmXqmdSvJL6zEfOXybOHBhV3NW9a96MOxEhrUQauGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeT/tOrq/tz8OH+WQo68ck6Tvaxe1t7taN9hwxfDhZc=;
 b=GRVgEVCGJSoHU2TTNnrBo/JABnmBUtrEZJkGTrJcwGoMD1uBtJ1Zy9XA19ocdHpmKIZf3na4OIvi3uX36Ula+AQW+MFMzCiqvv3Vi/cXdegS2bSKCZZUEi2QuqBj8NE46LV2EQ7ICLHFPlKE0wgb+v7dM8RBfHlsGzFjUxl0GnagRiSdJf5vX2TRf5EJLASWmUVCyIBeESSTUBphsaI3m/fYSsf9Uo+Ti23yuoeXh/A49mqIANGAshOnwQsQXLhBPD95LWn6RtzQhRRUgHQ6XUA1JV4InsQnjdoqeOFkBKrpQRhhbgqh4Pi6yl09JHo1PyzuvtOkAoasfwNx/z0NOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeT/tOrq/tz8OH+WQo68ck6Tvaxe1t7taN9hwxfDhZc=;
 b=OZrYz8rvx3m5EdL2QvUsjiNSa2ICrR+LCFtSfZRLek1QqAb4KwCUrB/VBZ/vbll0IGZPbtlUuE+5C7NSXIbIw2XV885mS1kr4R6Kbx/DsvRObYZRLXWkoKaRP6Hifi9tXCHT0+Qcky4Lfp3irYqLZSSedWKUYiXikZVuiQh+YKR25f4mHTkcuqAn83lLT+I92eNccrIFeG70YoTp2QPMbZ+iONOVEr3As5b5vYL8slRk1vD6jpro05s6/57eFpWxB9QhNfMwGWlVvsEFIZ+5SOFRlVQxSRzWgHTX4mvydqblIzklHnrY2zG9KMDptvFzDyI/bPSjRGEtiMR+g6zJFg==
Received: from PH8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:510:2cd::24)
 by IA1PR12MB8079.namprd12.prod.outlook.com (2603:10b6:208:3fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 18:00:10 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::9c) by PH8PR07CA0016.outlook.office365.com
 (2603:10b6:510:2cd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 18:00:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 18:00:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:56 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:52 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Carolina Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 10/11] net/mlx5: Remove PTM support log message
Date: Thu, 19 Dec 2024 19:58:40 +0200
Message-ID: <20241219175841.1094544-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|IA1PR12MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f77de71-8015-41ac-6aed-08dd2056fa68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fyzulYc0/btCAFV6DBBzYV4mEC3oqH620jCGvqzNpnifMuPm1gVh8wR5NBHd?=
 =?us-ascii?Q?ZIlECI2z4WSp2jmZcMfB32guLicOQGoPGha/NzdOX1FF1jPsk6WuQLUXZOWN?=
 =?us-ascii?Q?cqRq/5/2ABCJwEpXeaxRwyCaw/8v9meza1LbFpf3N8fWsHaLOEliYFCH5Xzj?=
 =?us-ascii?Q?doOk9kOtsLLMKN5fMyqXmnHVgzEYrEflF8SZgeNW65Qb0cj2AQTp1qiDc7/x?=
 =?us-ascii?Q?/R/+BMLz0mD05aKKQzXIbf1YM8JQU4LFxMu3wAl+LR/M8L9NSie4ua97wMKm?=
 =?us-ascii?Q?UWz9n0FmKuzhSqqaDKQFblF8Sk3Ox7A/YhN2vFcBgGoUriadYjSmgBA9NEVN?=
 =?us-ascii?Q?BhAdaU/v/ayJnISibSvKxmvVqCVoZOx43hUZs4lDDq086EVgq92ncrg8Ylku?=
 =?us-ascii?Q?hgMvm5DvAUpQg6ar/TSrjKD1yIuHIC3ufq7LgL9m4GiXDD6AzEVAGcp4GAf1?=
 =?us-ascii?Q?enuTjlM4VuyY/xJ0cVsSFHNpJFkMzdqvDS4rf9LNvONvTeObASa9Dp6+EnhM?=
 =?us-ascii?Q?k/zGEW3Tn3uqgwcy1al63BD11xe357IWFNgp8289YggEH2LNxcouMyF9PW/6?=
 =?us-ascii?Q?i2aHltuMJcqERBSyDKyS9dhDtbAAL4Qmp6vQILL+LwsdXpi7/ySYEguL2Kc1?=
 =?us-ascii?Q?dDt9cD5bDnRIJu0fXsXmqOttiu5q98i8dQ2G305o34ym3dFNZWnyT6LVNewS?=
 =?us-ascii?Q?6mduv5cYvKmC615PK8DSYbWi4E+fdfo4o6hVkKiZCI0r6wUSlKoPejlrfER/?=
 =?us-ascii?Q?G2OP9VOsV73xWoSMxrl2MjBw6DIXHvsp5IzG/9S5tY31eliUf28VUwPKSanJ?=
 =?us-ascii?Q?0Qj9ydO6Y8/a9OzBKG0CRbgJt94NnKPDPCW//AiU9zMYezu25onHs4Ki0LxL?=
 =?us-ascii?Q?bQxlRUZ5zTltVGiKa9YBvvYdRMJ1Zw7gLmcKMvrPMFJCBncwZPsRhRzlWuWf?=
 =?us-ascii?Q?IQomimrTWn3Xr4mj1+VRREwnsghqkDOUsN/h14FI2CTvinSVU2NlTc9/SfvQ?=
 =?us-ascii?Q?kMNRXM8y/Rf7CyGt+hZoHPwpAoTfuJh3myMcdkMwcpLrFWjVTz4gvImrTVxb?=
 =?us-ascii?Q?pgGU30+0aOEZ/GmbzLXmlesqs2OziFrl1NL9iN+nQAlfq7Q8YvIRDqJtyNUQ?=
 =?us-ascii?Q?jIjSfBydhtKJW1xnT5RHFSYEoZHCcQ40uIWOPDt9PLY7G6n2jwm5nNwLlUIR?=
 =?us-ascii?Q?Fwl/uigbY7ZdQoD7ZrtwKDpJxBEdplY9qTrJcto2XKDykydL2YpryTL4seXO?=
 =?us-ascii?Q?wravOv7adWw3DYkW7w16HY7w0/krtpAbNJSu7WcpejYs5YG70yE1fQfbmHtp?=
 =?us-ascii?Q?qKEYEuJGeDwJmkboeziEEyNvVKrkwU3w3v4eNhtqHEEzSKjoO7WGcDtkIHeP?=
 =?us-ascii?Q?Zfj2Z7zYrnShYoRmb3BKfE05XmI2TiY7EpQYgSxRpXJ+hEWUGx6ghieWf9Zw?=
 =?us-ascii?Q?EfRMLbtCrcWTn1Kg3Lvb/69jrWqGKj/dwjOcUSA7jZE06zgl92AL+x8eTR5k?=
 =?us-ascii?Q?aT47f3KOvFTBbTg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 18:00:09.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f77de71-8015-41ac-6aed-08dd2056fa68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8079

From: Carolina Jubran <cjubran@nvidia.com>

The absence of Precision Time Measurement support should not emit a
message, as it can be misleading in contexts where PTM is not required.

Remove the log message indicating the lack of PCIe PTM support.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 869bfecdd8ff..a108d8c726f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -945,9 +945,7 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 
 	mlx5_pci_vsc_init(dev);
 
-	err = pci_enable_ptm(pdev, NULL);
-	if (err)
-		mlx5_core_info(dev, "PTM is not supported by PCIe\n");
+	pci_enable_ptm(pdev, NULL);
 
 	return 0;
 
-- 
2.45.0


