Return-Path: <netdev+bounces-113985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC9294082D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8F51C22408
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848018F2C1;
	Tue, 30 Jul 2024 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e15h0LcJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5418E75C
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320314; cv=fail; b=ef8Q2z5xGZnOldWwD6t8tZHnB4IiGvmnvum/ybx33e4+E3l7IwBVIDOrzOGyNS/kcrCnhqWzfPL+SHhUmfZi9KiFLOaWQaDEMJixZNoMSF7XQ8jFxowpYu/KGai0UvOuUcufE4oVRT8C90DRbzJKmRpFQ5XcndC+wPO6vOybewQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320314; c=relaxed/simple;
	bh=yBWxaVPhpdr+AmJRcqcWFELhSWRyA8q3ut944kTLm4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iA4uGjMaNFEpi/lXxeopC+fEE7tsNNZi6coF07jZ8Cw0MTIIMuexq2KsRCFOEAgFE6vnLvZYCa8fujeDbPJTO6i9FeYR0bP01MuzvotSqyzvuxGNOYPUguF29ifRl8dNkM9eRJw5cwNvNPxb5HBlI18ipvkVHeikfbbxwzXdctA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e15h0LcJ; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ng6tgO2HhKM5HmGsLYusdDcl/VVKk6XcGd9eNgz3veViv3xYsS4HWy4Y4nZWxgeDZecK5uVzoezk0PKZtofu9YDZ99dpHDLBcJ+4/AAT2bjbO+AfD/yi/umIpP+BlDr9tNyUMzM/KdJEMUPfGVGaxwqw6nDCYtA/y14vF6kcxvUT8yBpQQ3WYh1I9ULtWzJlAHEBvNDc8KAn80JB+tK1AA7w8LMTpl+BB9jIrhat0GAV5oohjgSIcBABGMnjZs5XCr/w2f/9DMaSthbQ2Ng8SF4z0b9yDwzKZd7Nrn4TCHJfErsgRpkWyaulCquy/269zG2uUdVTdT6QL2N2Gde9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ttB8HvkrhWYPCt9YPI28oPwJfdEXI3QQ908migxDiU=;
 b=HQw5+tYYXgr7MXT3/Oh45+7CHaZCXFnDq7AVyrWt9GgIaGbsmZZ958B3i4U/7s6GQq/nLWEIMVmomFRE8H+U8Y5ZmJbg1RwJJzMciXj9SB92SkrBhrtaedlZVgRtqpxMfk2GIt+rYLzvVBSAwHXzml8d9gG6UxshgIpCqbjQFfNLiX96D85MmSWBv2QOjbgkVWllvARDVyhgxdQM6jSeYVI3oCF6bEAl8Y76fFbFzD31cz3u0dnIN1Yg3rA3xxcKB5ntUMHTcTVhCFLZ7SMTsVJ8t2Ba0War392BS8ppsUC0OYqaau6cftjDboH7X4+rMxFqqFz1IR4dOxBlusukzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ttB8HvkrhWYPCt9YPI28oPwJfdEXI3QQ908migxDiU=;
 b=e15h0LcJp8cjKQaLKEKQvhLWJcFuJ6E3STXzNBwNFRw+tcGol/5KSH1asu1oslb8A3CrO0tOqP6NbkZF12rD64DgU5vVt+qd26xw5drTM/NKp3D8m87N87D9euSD9kdrzsgQOwZlhpcO057Tsa36OP9AxgfNCAvijbAXFQl31wPWjSaGYdagcyj+jak+DwPYtjFpqBq/jhbeInL9noVXYnwMOJEA9QoBeK4INJwYh5ZmzKMssWwza99z6/cOaZJjBbRyhlW1MVRnm96AajNnWxadw8Fdvm7y7T0VV3JOnNR1OJhxxfCbqyiKghj+RHbkh4VNC4hMlWJ4vLpc1YCeag==
Received: from CH0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:610:b1::23)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 06:18:27 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:b1:cafe::ff) by CH0PR13CA0018.outlook.office365.com
 (2603:10b6:610:b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.18 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Tue, 30 Jul 2024 06:18:26 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:12 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 1/8] net/mlx5: Always drain health in shutdown callback
Date: Tue, 30 Jul 2024 09:16:30 +0300
Message-ID: <20240730061638.1831002-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c34be0-8fec-4604-1f73-08dcb05f6c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsPTmerTb1NCIefHaVKYn8MpXcVa/imjx9t1nZsFPxOlXr84/3vJC7WJQtQz?=
 =?us-ascii?Q?lgzvhozuW2YPeB1ugBteVFIObb1k1xZkwIpJ2A9KgIXQDucPN2HMDMYwVKRy?=
 =?us-ascii?Q?rzxWpRUHOcHSXWCbf2NueyIBuQJiF/xy4EY5QQMbgpttCxW4Xn/laaqDoojh?=
 =?us-ascii?Q?hvpmVVfnChJCJV4J5Rw+C2dLGH/phYM8fq+G8iDIEuud17+kS3tAVr9G8gif?=
 =?us-ascii?Q?hHb/Qbs08zjhUu4R2pozUmRyxRvGjh7c7Kli+JLoBnBBOTW3zz8Dz+uLOuSo?=
 =?us-ascii?Q?26WISeCmxOXG26G1rlTvHZnRtW86p+9GoLcdAWn2TU3Wg7ubaNBd8ag0I3Qj?=
 =?us-ascii?Q?5h9ZyyIqsJDuqKdA/B5nHm6wja8VKxTRDMw9MuavPD+xL+JXv7mTFQQ9bmvg?=
 =?us-ascii?Q?JA9gnO8MAp/zqTWYByCdku/nXLKo17OMdEOEG/BTGOMoQVjmDJynNVcmzcMg?=
 =?us-ascii?Q?ToN7bjuhQshePVU3xYG8qk89Eu38TsZAxctJKcjqK+GdbQXX5YlJ88YpHET4?=
 =?us-ascii?Q?71/xVayKyj2bWFjYeCCZXbAEqmh/BVh1WttUmmk/984EVphcvJKPtIAAp5a6?=
 =?us-ascii?Q?XzhKtEJpc0//zIrLU2mljxOrscn9cLUWRwkG2z8ROSF3EwamjbHOV2uqptwH?=
 =?us-ascii?Q?vB/vJrQX5VVo0bZGgZl4629MVJaJ84SLQ8qQg6S8f0vHlFIREQiXLilZjs0N?=
 =?us-ascii?Q?/ZiSDO0/itXpR4LojCU+5eH89ATvcSsVkZD/IgRjkf934bkmoAN8PION/LXg?=
 =?us-ascii?Q?hBgWXBHi4JTqzMa0/L3je7Y112EJb8Tuc1oWAWyy3W+L12LzI2jzveSi6gL8?=
 =?us-ascii?Q?45ujWVs8FPFvdwgjhlFfyisxxn7jcLjdwkkRtfRp0jUZtlgiGbfu9Y+KGPxa?=
 =?us-ascii?Q?KBAj1e1Bmaf1xdfh+KDuXAcO5DDJi3U5R2okImgSVyA9evGioNkekqT6ITo/?=
 =?us-ascii?Q?3ePaO1Grjff6k+mSU1iH4prmtXrny0TLRyqN6nB87uQqcg1hhsCPENT5o7NP?=
 =?us-ascii?Q?bRbK4HHYTRShCD0Yj3W8hViBTOgrEqf50yYbxkZGr+TphPkhD9P0XVBZlKHH?=
 =?us-ascii?Q?WkdLdXNC6CthYeu57u2ym5JmrXIjbMLQwAxdxdDe1FBzH3q4EnrVn6FFfHka?=
 =?us-ascii?Q?9Ghcbbp30yQykpUkqzeMao9NKYiPJCQtc9hFbSwUidaphPi2IPUGyOh7ZiZc?=
 =?us-ascii?Q?bojba/uETBXzshvjnkk16wqfbQlh2w7a/xJNHyKpB7UvOcno8ilUY6jlUiMM?=
 =?us-ascii?Q?Rx3YTwMwDydcrqYGmg7Nn9ZdzXfY3PYMw8Oj0F31q7cV295XV1TMw8KfQ8/Y?=
 =?us-ascii?Q?edpv/439S/j/Cx8BsPv7wzwOBo0YCIu/C2eGwQScXcCQJOYtoIT7XCsFyK+5?=
 =?us-ascii?Q?j5IZz3L7WSLQbVbsEJTruQueM49kGD1H1t8hDl/TsWaZ8FQ29AgthQr101J6?=
 =?us-ascii?Q?lCcSPD6AxFFDe9cZkA2koEGS2x0X6cjS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:26.5481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c34be0-8fec-4604-1f73-08dcb05f6c6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

From: Shay Drory <shayd@nvidia.com>

There is no point in recovery during device shutdown. if health
work started need to wait for it to avoid races and NULL pointer
access.

Hence, drain health WQ on shutdown callback.

Fixes: 1958fc2f0712 ("net/mlx5: SF, Add auxiliary device driver")
Fixes: d2aa060d40fa ("net/mlx5: Cancel health poll before sending panic teardown command")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 527da58c7953..5b7e6f4b5c7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -2142,7 +2142,6 @@ static int mlx5_try_fast_unload(struct mlx5_core_dev *dev)
 	/* Panic tear down fw command will stop the PCI bus communication
 	 * with the HCA, so the health poll is no longer needed.
 	 */
-	mlx5_drain_health_wq(dev);
 	mlx5_stop_health_poll(dev, false);
 
 	ret = mlx5_cmd_fast_teardown_hca(dev);
@@ -2177,6 +2176,7 @@ static void shutdown(struct pci_dev *pdev)
 
 	mlx5_core_info(dev, "Shutdown was called\n");
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
+	mlx5_drain_health_wq(dev);
 	err = mlx5_try_fast_unload(dev);
 	if (err)
 		mlx5_unload_one(dev, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index b2986175d9af..b706f1486504 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -112,6 +112,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 	struct mlx5_core_dev *mdev = sf_dev->mdev;
 
 	set_bit(MLX5_BREAK_FW_WAIT, &mdev->intf_state);
+	mlx5_drain_health_wq(mdev);
 	mlx5_unload_one(mdev, false);
 }
 
-- 
2.44.0


