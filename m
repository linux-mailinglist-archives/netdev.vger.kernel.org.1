Return-Path: <netdev+bounces-107415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211391AEBC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8186F28A2BC
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5BC19AD55;
	Thu, 27 Jun 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQvjfa+8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1019AD51
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511482; cv=fail; b=sHfgIjZ/SHF6BXuSSCnvSsro68+W25sb57YvQ9n5LTkPMJcoNhGxsQC7041l+cIA8/yoBM6E7FG+anaFU2USxNO7ljPJbi0lNnWr1ocjsNpLBMBX7oCBR4qohkwL6aVydObQv8gBrqmIYAjbCMAreMJnz7h72/Xg9onS6mTrVKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511482; c=relaxed/simple;
	bh=ktNUg8sBL1IQRMOYkdZYmH7PptDXUxImEn2vACZ+Xp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+whBbWNsoEi0SgMVDOnxdcosWAhCBi1iMryejpJjFvZi79xAQGXBlymQcrBDzmAl7QrYFgC7fqeyAUssh+c11mHdF3lmMI+gjyHBqUEo8xCr7RIJ33ZgK68wCiuNGPta+oOWFYCagwo1i91KB/LDbj28ethLYAfIVM37A99BcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQvjfa+8; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDTVYfANxQ0CrFjvqi5bbDCKAWIQPR0uo3ABAaVzWK1ljr4tGOnuwQap87wHlGXSOi0mwm9LZYM8ynQBA5WUZSPdZh8t/P20oh9771wz88Xf0Zf4nk8stuLYMYuoDYfn+0eXScjY8hu4TEUdCIA1LOqPXTJF//tTjgOd1Tsf3SN/ogHLCdkBzujUpRZ9z4+eK/oP6JYHT5xeIv3vjsVpeunyvvg/neEu8hX1wdRTWQr6DkgyU1Qf6wLmDhZpphMtl9h2kWHacHBMWC5rwLMW5bH8orbp5RZ14gGPOs+Ubewn8cEyTJyYkCiZ0M59MD+VC50inHwJHE/1O+axCAs3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi91PzOyihEku1JhtFU+H65pLIgENBcLD0FuZZr99QA=;
 b=jYn55dxGhKgy7Muo0BZGyt/co3V/Rio7VZOce5S+ib9xI3mI7gPAOPYyitqdPS/lpaLVT5wKE4OggV9++vWGbMXp9LxGfSxyN2dqVVLJ761j4JxCh+C40lB9Fyb8vPxbiODqYx/pViDvgooHIawmraPiUiHVsT1y6nEnDcHlvr9T4thqpHmf2tdtT3keEzioDwBhP4IIjFH7CTyBdBeuarIjZLf6ScbrAkERdOnhObwcR8j9v6NlljHhOhy3JniQtcEusFYketFYXpmlEg51KaLE7vBa+zSj/Uxqz8irQ+/A9eE+SFB9w7K4YBycWW7dfLPA6XEg7UsO7xflv7ZB0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pi91PzOyihEku1JhtFU+H65pLIgENBcLD0FuZZr99QA=;
 b=mQvjfa+8w5q4oGmic0rc1fUjFGArUMaLp4DqsYH5KCpHddWV/j/aJEiWpg6sd/qveIL7BvRssvEwbVC5NRzqvSndDxs5bEAsfaYROXLihReoTMG1ZIGYCCVEePBpzxVVSZsYWvYgXRr2o2NrSZHYp4WyEJsdCrYthtayzeLZILwgi4ITVHzLdjIvjMgxFTWRcZ9HJHXAXmv54wT05xD+Cl7TT4Y1EGKpkBMMIGV9t0CeuQOcKLSirtVfR82/5dF1woyM5EzJmkkJlxuEm33tHd0rS1UNYvGZmDisT6H4ip5QFP8zEnT5Li9J9SyxzStKQai+ofhTIwAV5kCCBPiYSg==
Received: from BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12)
 by MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 18:04:35 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::bc) by BL1PR13CA0127.outlook.office365.com
 (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:04:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:04:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:04:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 5/7] net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()
Date: Thu, 27 Jun 2024 21:02:38 +0300
Message-ID: <20240627180240.1224975-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbf0e28-aee6-4621-006e-08dc96d39a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XdIpamsl3bS5cdsdYK75pc+0PnnH4pGVi2HbmzPA/vYRp+RDABXRfqvcvbxs?=
 =?us-ascii?Q?D2Y1rITHE1YdzFFZPn3/aDHvSVmxNuOg/FZExOILc62+PG+UVFhDC1o9fU2O?=
 =?us-ascii?Q?5SPmSbGOHkCk09PH23ed7Q8n9iAW5J4BZT4ITHHjVekGTWZrQIc4Ebr15HxX?=
 =?us-ascii?Q?CBDUAYhe91PqAOrtmU/KRaBJlTXWpqYkgGKoU7b65P4wgSvjVlLgIc5i1TdJ?=
 =?us-ascii?Q?yh1PKj5RfLzNDxjeAn8NJn0bBLTr+LhIJzs21owxO7ck98YUOO+8IPCsZqSz?=
 =?us-ascii?Q?GAW2IRF4/y2zq3izV37TTdGuq83Q6q992dQwLdflqftJsXbZ/CEhZ6Iga7EB?=
 =?us-ascii?Q?5hEfyPjDYv4UxDGOX6mST3Mbs8fQUFC/UZKfMUZNjx8EK7SbIJdRvAIIncdT?=
 =?us-ascii?Q?KWLENixu/nFpqMCNmcRGP6NBFgXSBz6y3JBm00pD87bcmuI4MTO7iOJqXvuM?=
 =?us-ascii?Q?SI91KK9PpRgTaTyInz6hRt6N6v0R71WnHLv0AdbHD0vtSHT/3clXuhMrdL+T?=
 =?us-ascii?Q?x3yD5ooe9MbvZJXWPpwvuj/8S7QClb4xSUrRKDbnAZL7GZpc4hXS1ambJPHR?=
 =?us-ascii?Q?cR8Fd5lk4d1SBWYyx6tzO8IeE/Gzlz42uRcubYdpdlPbJEHk2DJYFyV3N29K?=
 =?us-ascii?Q?7MjthHjxS7nuuzca52lAZAAOveDSUCI8xrtzEdE4aY/bvcVp9t7SXEVn3izZ?=
 =?us-ascii?Q?Gtq1/5rbbpDW0Y+CsiRR5AJ/5faiNkB0CvSTM425WdrJAlAYPE8aPvGiEu8W?=
 =?us-ascii?Q?naAF54Sp4OOVz/Z932hyPgE6ROHxiXCQ4mC9gRh+uXo5fhKQuabbRJZBzoJs?=
 =?us-ascii?Q?xEC43MEGzPfI6OAuwZnXsNDI+uTypvCTVez2+Em6E3ZnbrOvnBi1YxR9YJdQ?=
 =?us-ascii?Q?0yTwrSEtqegX+8NFOWIXpoxOZidXMTSPHge8QuHL1BqGJWqLUtSwuvDD2rtG?=
 =?us-ascii?Q?sxHSYeeT5fgPIBxugGCm8OkQgz0hWFxE44xwtuKXGvCxmqcDWQWzCR36xWAu?=
 =?us-ascii?Q?4x0TPT7jsEs+YTxf9hcuR5etngEn2J058Y1EEWaSPsh4ofQTu4GeMcJ6ob7C?=
 =?us-ascii?Q?KuqJX5xlvu6TG6G91EDA/kCtXKQmBXbgrKO4l9G8iXf2CS7ZERXqhCNDn1l0?=
 =?us-ascii?Q?aPE5xU3COpQwdK4V+jgmKtXBhRZ6Z5TMONst+OSPW2ifItk0923IY6RSyE1p?=
 =?us-ascii?Q?Kwut662onrWbkKNzV/bFq5IjAltdBXUYuScYILgMBlmplKg/yuX7410573BE?=
 =?us-ascii?Q?l23c3pVbHGSiezuofkF8Z6nOrG2Zu70RjNYykRpTfVnBkdk7so7ms+eO0wwJ?=
 =?us-ascii?Q?qqUzQQyfdwNPLutGfz7ttD/C1D7rOU+XhvEup8BsauBL3NnLr/SLW915w9ow?=
 =?us-ascii?Q?3MxtRmNlNa1RrZqKKx6CAmB9wgvIFK8HK09+ET4WOq/fGVaJf8DtlgCB4GjE?=
 =?us-ascii?Q?fzO4LbyPslTXf9BDGjbtAbEor4Uuh8f/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:34.6340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf0e28-aee6-4621-006e-08dc96d39a26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, mqprio_rl cleanup and free are mistakenly removed
in mlx5e_priv_cleanup(), and it causes the leakage of host memory and
firmware SCHEDULING_ELEMENT objects while changing eswitch mode. So,
add them back.

Fixes: 0bb7228f7096 ("net/mlx5e: Fix mqprio_rl handling on devlink reload")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a605eae56685..eedbcba22689 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5868,6 +5868,11 @@ void mlx5e_priv_cleanup(struct mlx5e_priv *priv)
 		kfree(priv->htb_qos_sq_stats[i]);
 	kvfree(priv->htb_qos_sq_stats);
 
+	if (priv->mqprio_rl) {
+		mlx5e_mqprio_rl_cleanup(priv->mqprio_rl);
+		mlx5e_mqprio_rl_free(priv->mqprio_rl);
+	}
+
 	memset(priv, 0, sizeof(*priv));
 }
 
-- 
2.31.1


