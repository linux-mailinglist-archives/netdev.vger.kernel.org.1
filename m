Return-Path: <netdev+bounces-153476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 346269F82DF
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DBA1883180
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77391A23BE;
	Thu, 19 Dec 2024 17:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c72fXnxw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA381A238E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631194; cv=fail; b=g5vJ34dIX4zVCKNcbm8gPWZ/seqFHmGOSlWZFHHxnT6d2MNSn1sy/KbA71k+FEYz1l2Kg/tVoemL25dgECMSy5qGkI34fgQYoDieIyeB4nLL9aybrrEDOVHJfEWTjaZX8NUQrPcFZkxeHXWf9HoHd5aXFSlQqwAKnppu5o/+5nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631194; c=relaxed/simple;
	bh=rmLGsOBbMrZNrb06AygUwxPLKbJlXxNKWjmZoxE8rX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8JFJauscIhJ8PzL+Ra5lnJWLH3vu9HQM6vYrT+k7laRkLqO7947lOMVix0cpRVv1hCA4GzvfRdJa7ZScMsn6BBRJ9jKYPTNYzm95+J6G87DYsDiHMecpIyA1qyxGRNBJMDAf0mSfDyiTqZUDqHdQI2ry22V3ReM4/nILBXmPVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c72fXnxw; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAsxOx7T0cmh5FxkPTRxsliTQqgTB5/5OyOvgn2aycCAVLHe8l9Yt8qnk3nby3I2TyP5tkOAnwTcCyf7lgXFFtLD81jl8HWfTx0hrHJBoO75EFQaXNID6UzJlXyFZPW/SR6sjtbiNmOT6oGT+nCsVc1aynDOFlYt/ew2VE/3FQZ1tNqf+Z4GFppg08nwuPSjUkogNG761Jc9Vwo+2sUGzQcKcSum3GHP0LbVkuX8yx9fvBn5g+1IBY6h3VARvy1mSdqzNq0Vam/tJe5WAgofxx/tHXz/1y/HkJ8iOEQp/Qr3qwZkSHiSYjam/l7madnGAwPDmIGfF38r6NpXpmPxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbCEY1ym1S6Mj+DXEvz5Ra4EgpzgV8wuOAT9riIV1ck=;
 b=F9z9ybdNcuuU8BgsisKpLlAtU48oE7AOd19jzsoPQR2fX8SJjxS/o50gLQ2GpTW8+LGz322HdnAa4pNV2Ek/xWtkSZWRY+UMlsIzzlMsoaLyHKd3rM2XZMLKFACn82BCYn7H4XrgTjA31w9/yKJFlCJCnOou+rtBu5UaXH+NEokXrcac8i85NBWMlc7jXeTpqMNxkyhK3jNq4Yk6dRTon6jCxUuAq5r2iQug6nvPM29lSKMWZky7eZ7gcmju5fcLha0FJK247nJwuqxgi9BPxV2fZZYAJwgxAl1O3t0MmIkYJULdkvDuecr3Wi9z+oUL2om9nOHNjz86IBmwzDGrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbCEY1ym1S6Mj+DXEvz5Ra4EgpzgV8wuOAT9riIV1ck=;
 b=c72fXnxwh8c2JhNX4vBjzfiMIKCDZriF4LRWLY78dNy0SBRf1eT+DpAt58KYLiBrRoTGs2Lfuws4YkazR1WiStRYWsi2eZULStEzxdeMtxsnax8m3dfgwwjXrDNmTaQWjIXJvF+U9F0GP/C4HaQMMjjc1GLs30Ta7vNw9ZaYjnT4CGWlU4tNZa41cU1y2lFfb8J1H9dSXj82zyZWKvq6yRVWzufNYkfe7oAth+YnbVwRlySQSHsZ9f1gXwq+ulFE7bYyLmu6OG1NoAIVXLVMKrj8/SlRU0KSDbK3AVS8ZYWC6WtL5PuYBrr8WCq3UGQQd5uvj+9udpHtaGN4mV1qsA==
Received: from CH0PR13CA0033.namprd13.prod.outlook.com (2603:10b6:610:b2::8)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.13; Thu, 19 Dec 2024 17:59:49 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::fd) by CH0PR13CA0033.outlook.office365.com
 (2603:10b6:610:b2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.9 via Frontend Transport; Thu,
 19 Dec 2024 17:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:59:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:36 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:33 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 05/11] net/mlx5: fs, retry insertion to hash table on EBUSY
Date: Thu, 19 Dec 2024 19:58:35 +0200
Message-ID: <20241219175841.1094544-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 92196287-d0d3-419b-b93c-08dd2056ee33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uoIKMzDT3/Uywl5ldLctaQDndqgzhLYjGa+OqcOMbxejSfAju9KnFISlZKFC?=
 =?us-ascii?Q?MPGQ7KMjZfAvsIR7N69g+Jb1/eYspk47/21e6wOOpts+AX7UuJu057hvH5PZ?=
 =?us-ascii?Q?0HPU9bkgFlb/cfxLvd82BsLHfgbTx4GVy1nBHZ1NhVUz0LdRV9cL9W9qBMwq?=
 =?us-ascii?Q?PBligaCVO5X+XAGUUjVwei3nimxI5ZIXlzuTGGoAYgbUHb1bfXQIZk3EmeoE?=
 =?us-ascii?Q?Wq3/hKBxpvoOdOGtUG8OFTb5PPhIrvRix2MrKpZ8S6GjvyJoLMntkDLzf1hK?=
 =?us-ascii?Q?J0WYF/D3Cvjs3RV+qnKmkg9AFSVC9MTFXyQvy4NdCYaICkFUYTdMRe+lnR3K?=
 =?us-ascii?Q?w/pf8kkxXbHSO8Nakhztk6Unmy1nXxc9O43quv5bKKjOhx6MUAsYrdRp5Iz1?=
 =?us-ascii?Q?HgqHmL0Q/dzrfQbd8VWXh1JpJpD1+7JvccBVb4g/Tv2fecAvXzYlgyUsZKoJ?=
 =?us-ascii?Q?IW/g/ImnnSxSD8Nlpqu0NTajmrU/lIqNlw21rS/KGWIO4r1cBGt6jlTMPCYO?=
 =?us-ascii?Q?eAi/05u7EBvo2pKkeTawmM/esC+rEPlcG3+ZxiBbj/gxkvNzYdlG5Mh0Zpl9?=
 =?us-ascii?Q?ohH2vmuCVff+6gmj6NDlN7lM3PvNu6oRlvq47VZLVVMTEsBJVnY02wN/af9w?=
 =?us-ascii?Q?ldld9MQ3NGVn3QW5IjBzOduxneX2HdtqKGGvmIhX1mQrqqOgY2pcgUOGmmY0?=
 =?us-ascii?Q?N0AqZCK+rJSrstkBfhHov9GYAoJxtOKKH3TvN1aemcwwtjZdeBokv85xnf8S?=
 =?us-ascii?Q?YN9siZnEh5j9m9J1ahNcRbLalkutaA8jNIAC8KuHEckMvir5cTSUslCItpiS?=
 =?us-ascii?Q?adwsfGL/CQ1VCkg0+WUYuC+titNoPGm6Nfn/MsxjMR1B8SWundxQk4fl2LEc?=
 =?us-ascii?Q?2HlGabfhqr+V/HbkGqkh8q04CLJ+bPa8PCYI0xA+gyBcxdexDB2pyK7mjJuZ?=
 =?us-ascii?Q?WZ1iKuFWKCptdxgqZKoqhCiv5PlguCDLbVotZNol+9aWSm6NC8thNIzCKpQt?=
 =?us-ascii?Q?cFYMQKkHaFWpWd34l95W5n6NgiMkE9DtumMsU6XlNC9px9XuHIBREm5hsgSu?=
 =?us-ascii?Q?uX5uTQHw5ceiPg3hF4i5wqP61lZhyCGwBpWKyDcGsTjWqvCPZtCbTyB2GZ10?=
 =?us-ascii?Q?cKaShJASwqQiyxcsuRdE/HBqZGeY6CweiLzfgXn32GxcPq8O2j/G1DdWxhZi?=
 =?us-ascii?Q?TPHnRtcJ/RhCzHiz6eUOxH8zr0SnfLcwgYjw7oiIemk+bYyeNIZUIyB0qOhn?=
 =?us-ascii?Q?ZIzEjB5Qxq31KMcf+fnRIlE682BfAca+rasZc9pWjLPmPH73jCmh7LpEa0Sw?=
 =?us-ascii?Q?3BxiPmK3r6BUCdIJ88ZzoDKaB/hO4ZkOKcyqlE9+y/P5zARio2wZduRiN032?=
 =?us-ascii?Q?01waUEeKIReerJ1BTKZCLy0cBOMxGGh3hBvGfAjS9wlF+OflHwZX3ahA9umw?=
 =?us-ascii?Q?E78ZvykJzZb/auByR6Ot+8lrWzkUMdg4xI1YLjIiDE0QZe9z8I/FW1ZuYwZJ?=
 =?us-ascii?Q?WYU36Wsaj3Y+xNM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:59:49.0871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92196287-d0d3-419b-b93c-08dd2056ee33
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

From: Mark Bloch <mbloch@nvidia.com>

When inserting into an rhashtable faster than it can grow, an -EBUSY error
may be encountered. Modify the insertion logic to retry on -EBUSY until
either a successful insertion or a genuine error is returned.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index f781f8f169b9..ae1a5705b26d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -821,11 +821,17 @@ static int insert_fte(struct mlx5_flow_group *fg, struct fs_fte *fte)
 		return index;
 
 	fte->index = index + fg->start_index;
+retry_insert:
 	ret = rhashtable_insert_fast(&fg->ftes_hash,
 				     &fte->hash,
 				     rhash_fte);
-	if (ret)
+	if (ret) {
+		if (ret == -EBUSY) {
+			cond_resched();
+			goto retry_insert;
+		}
 		goto err_ida_remove;
+	}
 
 	tree_add_node(&fte->node, &fg->node);
 	list_add_tail(&fte->node.list, &fg->node.children);
-- 
2.45.0


