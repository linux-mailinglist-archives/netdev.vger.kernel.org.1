Return-Path: <netdev+bounces-143008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6909C0DEB
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1EE1C22A2B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC12170C9;
	Thu,  7 Nov 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PmZ/6Zlx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378E216E10
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004618; cv=fail; b=WlnYj6hRR16OJlffjNCMTjUwJV4dDYkFSRye3D5fa5CAjVkuGQHpZzTR+NWoM4BGF+UuLnL8HiJVazLNEfwD+6N8vCjxDFeOrZZt4R6xavC6hpOYTwZcgFzVRd3y4O+cnsL2q8SVipFbrmkThB/lR2EL71iRCf8DlFISwCMnlyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004618; c=relaxed/simple;
	bh=2ljCapT0wevFtLD7AN17TOwH5A08sqTw7tujeJ1JiYs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E9LrsNmvtKi5PfNVxGv5Qc+XJx9e3hyFxR7f7nNek891H3QShh3nRgYGP//8s5ETPfyVMh8AuJjkHtFXq4gbTQX4gnjOaOYDId0hBQALvRS2J8Lsxa9Uty6tiNdvFuu3jn2jEvYplE/m5rMNH99luRas4XoyVeb6qsvOIquOGWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PmZ/6Zlx; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmqXzgRVSDJf6tBC0mpNxRudNyDQfDRwhFvDRh4yguqWu6vH9kmeF/GTMyMZVtZ9VR7YUBUGL7rouxCFajahU9yKjFVnIeXyTBOtoTTTZCST/CCMW/sph0CgLtzCpTbw/J03E8N8i9WIuYHzKKJyzXcuWlKjNUoF9y7dwRm5b9m4ixrHMuVNPmZNbNXO/fIG1TyMXwIuv6Qk9JJ871s3qmLj/HhxCe17cXQrleicfbFRklhwzCvo8gejXmmt8TIyiydGV/QyfAfahviECnsnsCG5B/HhL0QA/I2MFla6dcHDthNhQ31cvFPtjuRW6hwaKABaGxlk0aNkU5Du0LVPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha311tu2p6G8jatH66+b8Z4tfsFTgMsDgy5HdkTlIfU=;
 b=KvzW9bSIHqXZsCya113lXlMg5yZLkmxNuielgC46B/NXjwmW7ImIGWf5/Qoeaq2saMPS3N9n32oyFZ6CUB0YwfurnGuWgBcRdZsp40BRj4MHQCgf8c5ANCqbP0T8l0MhFBpl9K/u5OYIuToml4KNMGOM8VGLl4RPQ6++y4hQ5X1VaDKgLA8I5WzqBuSg8qmYwQJ2YE8rIeuu+ngQWcLtP2MryZ5E6mQNS2KmsBtNflJepSLGkjCuKKWXNwlCa4pLWd0Ep51IIapKhiF78WlTmYhaF01wk49LCAfqBx1rtBiVTXU5SgGRMuBoPDhTAc8EbKgM/fd2vrT8uLwOXjulCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha311tu2p6G8jatH66+b8Z4tfsFTgMsDgy5HdkTlIfU=;
 b=PmZ/6Zlx255FX9KjAqkEqnbd6mcSwtlSS+t8p4zYVTm+WAu9al1hX4RqE7WScgg8/xPujhYda3U6Q3vm6IN/ciEaEwkEA3FZ3lwGGuMGjD4MUsr5a3eocZfjSe/H2G5NFu4G63eCDNPX5FMxz6RznUEMrKHzCwZzf5pJtMA3JXLVkMVhb8WIsD+gebgk6rUc1Kn9MrxpfRdSwIWD298NVVex9dG6xfDR/xwzrCQFt379tbpp9MPH+fbEF1EwTfW/w00GlZy8WUUUUFiSey2+DB5wk+79Rm6AjNBqNh7Rd1PGtZItEFvtpG1j0efVtHh6KJgL3PfBZ56kZ+tnVYacwQ==
Received: from CY5PR15CA0140.namprd15.prod.outlook.com (2603:10b6:930:67::10)
 by BL3PR12MB6593.namprd12.prod.outlook.com (2603:10b6:208:38c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 18:36:52 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::e8) by CY5PR15CA0140.outlook.office365.com
 (2603:10b6:930:67::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:51 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 7/7] net/mlx5e: Disable loopback self-test on multi-PF netdev
Date: Thu, 7 Nov 2024 20:35:27 +0200
Message-ID: <20241107183527.676877-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL3PR12MB6593:EE_
X-MS-Office365-Filtering-Correlation-Id: ecaaa9df-e2e8-4fe1-2f26-08dcff5b258b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0lsYioVimdzP3OeI6pPJYp6oOpfGuR6cRMrEY7gB+Jsg8/TdVUxHWMdxRCg/?=
 =?us-ascii?Q?Zi59c7fHa507Bzxr45Py82p/9ukqo6dB4NjHN0A6mqd2Bfk2HZMS0VHpJDKX?=
 =?us-ascii?Q?oUBYZOxJDK2qqOCX5yk2hdmQTZ2otnWUDb72YW3pqJKYebUNykLzxKUSYsUp?=
 =?us-ascii?Q?w6DqNvkvyStFymHy5dWu9G8tWhiFLd0jlepjISe+gk9daNgKCj3drp9a3gU6?=
 =?us-ascii?Q?5cUOqaVi9bz0LFASSL0hVc4B1Kk2asKtJn+LpRVgDAE7uCsWOUdZTO6doTwv?=
 =?us-ascii?Q?QbMWn36JZ1DpSKpOMeTXGBqvg0yPoDbzElsygqb++Y38gajzk5qHvrbkKdHG?=
 =?us-ascii?Q?0qAkn9N/KHcW8bysD18mPOdAe5RVYETw7ln4k0a6/7lxF9hoN0Nv9GvVMQUI?=
 =?us-ascii?Q?T+qwDH6PBfiSCgJULB3B4S/gBw87ENeAt3/vjOD2eBAptYdMjGjAAey3YKQC?=
 =?us-ascii?Q?NcbRwCCSfIU+9dQWH4SbngfhXCwDbm/QasPTZj8QCDQiub+TWg0n/ROhIlVM?=
 =?us-ascii?Q?r4jz4e2FYaOZZX2C6iQYo5Df5tXxSnuX1f05le33GoDb5zHAWUKNj9lc/cim?=
 =?us-ascii?Q?xUJpUNh89X6uVKc0sfop0qv1a6L4PZRqGkI7RyWX/XGBXGUMgRGcmfR3YQ7L?=
 =?us-ascii?Q?XAhogzeZxVGGbORSP0uBxqtZWjg9Li5DdjQXlH67mZQUx9fa1AUX8MoPWdy4?=
 =?us-ascii?Q?AfDuhkZCxzDjXnzuyHWJ4MlctylTQkz8rIMbKZXAJ64TtMxxdv8B1atp6sCx?=
 =?us-ascii?Q?zwtbPFILTXRwsgUU3arUeGyFER2VFkIT7awCXFtRR63G4denD+7AB+T00S0F?=
 =?us-ascii?Q?cDzVKOog/Tv8WhyScN6IgWfbPfeWhPPQabrouRqDXR6kehFYt1yH5RSaQJAD?=
 =?us-ascii?Q?lKdIwxzc9gFZ4Jx+CrXafiid+/HrXCR2GKcE2aEPUWXtOA7drcej6jgnkP7T?=
 =?us-ascii?Q?L4RWj2D1IuUYLMC8ypE0T91RWcYgXk79PabZsH+qxy/WjKfmGrFY5y9/bWEi?=
 =?us-ascii?Q?6axdMqJ3jpPXplcDi98yiwOkjPr41Lw/zPk8UoewX8CEO1t0xYUDAFBzuKVj?=
 =?us-ascii?Q?54BUxyB+uuHHujmAbtcK/ElE3gTOuGt5b2KSYWtP37+IaUT9VISr6jObZAou?=
 =?us-ascii?Q?SRvSZxxzCyZNIcx4h7AEhWUCZAvcUOQGSCOo4L7Q81RDMP9EWt1e7D+6JdWn?=
 =?us-ascii?Q?gKSkaMcl/UZojm/NWDsj3rsqNUaVX/fX2HtEuMbQG+UwWQXYRIWEzNlHekzm?=
 =?us-ascii?Q?RCULJghXFnZxNC9nId5OoMlwc6KVxNW5zrslc+06etuuX+DgiRd5bLnTLToz?=
 =?us-ascii?Q?+nd3O0SOPzxIpBz0B5AfW5GezUGlcpMo8blFHH6QJ/rqcuFb2h0mAcVK2Y44?=
 =?us-ascii?Q?9061u89b4x8JWo9ELqlnGA9Lre/N87s4Z6qpQJP/032utdYDGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:51.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaaa9df-e2e8-4fe1-2f26-08dcff5b258b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6593

From: Carolina Jubran <cjubran@nvidia.com>

In Multi-PF (Socket Direct) configurations, when a loopback packet is
sent through one of the secondary devices, it will always be received
on the primary device. This causes the loopback layer to fail in
identifying the loopback packet as the devices are different.

To avoid false test failures, disable the loopback self-test in
Multi-PF configurations.

Fixes: ed29705e4ed1 ("net/mlx5: Enable SD feature")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
index 5bf8318cc48b..1d60465cc2ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -36,6 +36,7 @@
 #include "en.h"
 #include "en/port.h"
 #include "eswitch.h"
+#include "lib/mlx5.h"
 
 static int mlx5e_test_health_info(struct mlx5e_priv *priv)
 {
@@ -247,6 +248,9 @@ static int mlx5e_cond_loopback(struct mlx5e_priv *priv)
 	if (is_mdev_switchdev_mode(priv->mdev))
 		return -EOPNOTSUPP;
 
+	if (mlx5_get_sd(priv->mdev))
+		return -EOPNOTSUPP;
+
 	return 0;
 }
 
-- 
2.44.0


