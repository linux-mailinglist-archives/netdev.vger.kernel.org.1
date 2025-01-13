Return-Path: <netdev+bounces-157791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC3A0BC40
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115E818855F7
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CA21FBBD3;
	Mon, 13 Jan 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCWR05Jo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E11C5D4C
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782927; cv=fail; b=q0xTpOjeX91gpMXK66WqaPKVa+XJYNVYwwL//j4avO8OsYkDHfNCh4r5DYgE6IhmqB3RI2u1C44B1hRvNGxtr0GL2lOqFb7/kQqSWOqRu3Jac6eUEGPNmTdy+8YSm7tATVuWkJhDimhU4Wmnt6Qwx1Q35rXnpU7hXlYpsrh02hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782927; c=relaxed/simple;
	bh=wXT3VfjaoT2JKxTGa2fM5e3fo+OQNgzFTnMxUKNvvI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+OAx3Z31Q1AS4V+G5OppAY9qjE/mYI1ezEKwDnyNuva7moT0hc1VaZw87tP6/5b4IVQ57rGnjsmLeTeB20L17hTeYDw+acPsud7z/y0tJOxA4GgUOOrSuyrKLoyqcpWtMyWNBbMFwzWskrI+ueqqUcmpxdsWI6XySc9dL/dFvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCWR05Jo; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmMKJ3ZS46jI6zfGRiVm7R3/0Zvn9SCPWF76O18i7geb0QNu2zxV6G38GkV/VO2Bqv6rcOZre9SO+DUuuK51838NPi8kvspuw7X6dBWFfOW1cQZIwXniQM+Ieuh1jZsCwxMa8ogMkHruJgV59p/J6tRwFxQky+Zmc8LEmjCL7xZhCkTu+DlmJ6XE6WmJBo/rGM7A9uYR/Vf1cKNhYB79PULbST6WRjQ8uHoEU/xXUzgpdiuj8u611j3BqSi9VEXPt73lzviN/vGlKsbOJbMMxrVnr0UI2VnOaVp/d2BukHpEfJ80AQzp53KWOOnfj6t9i6foFRihSpXmq37g6K+CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnKqcPZPUG4ZpD1+qTki+sfpIk8oVsiRIIIxCU1+6YY=;
 b=i2XguDRMLk5am+m1JhNLxcqtaCosWfFsyKlGXNPMD1EB6ZN2v9tqL5qPXt+u/sm8hKq3jgGBftC48SLIr1rz6DZMMCB757B+rY6mu5C+D18zttd6W2rT16BT0W+elQN5CAC8IPSqLfwFPBGptct22PMsIEGkD0YYxJBMgZjqiRegn28zR5QOf1Y8oQYG4onVABykR/9YmvfowGz5oyu51MM30kkq/h/Ymi1IOR/63FF8l1Fjrv8F0+LmPLcLlrd5TlAsNc8JX3kJ4s15PlR0/9ZWNpt5cLuleCX64k0IjLOL6/AZrF2yZHsZgR6JxTpjLXeW0hAEQZBDuVuWD2RTcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnKqcPZPUG4ZpD1+qTki+sfpIk8oVsiRIIIxCU1+6YY=;
 b=sCWR05JoyJUil+0nb6PMNgsI5KM22UMKLVX5eXVhLPdT1AMTkcCMYdCg0MRzdkqn3FOF3EsAAVwESgKo9y/FyvCRxTWoH6MvPWNII7i9myuwTJpRRjDOWWE9TrwlRK4dVP3imWvi8o6r/Mznl26ABO3F8aRH0JYA1cOTADNLSAqeF1Qd9/9rWR1SJZ3SsRvXcaqpMk5HFpY80J3+nQ74JuiOMnu2NSRArLFtTI13p/KlbLY4FFl1EO7CvYLAOWBfJ6nN9e30DjAmpgzcdtLgeaf+9WnjyaN10uQI9IYTQu5Lq0UevowCmquSXbdPRVMxJrWdtMEZIgUyIgQhxJiqnQ==
Received: from SA9PR13CA0011.namprd13.prod.outlook.com (2603:10b6:806:21::16)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:02 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::95) by SA9PR13CA0011.outlook.office365.com
 (2603:10b6:806:21::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Mon,
 13 Jan 2025 15:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:46 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:41:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 1/8] net/mlx5: Fix RDMA TX steering prio
Date: Mon, 13 Jan 2025 17:40:47 +0200
Message-ID: <20250113154055.1927008-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250113154055.1927008-1-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: d734404d-1508-4717-e1a5-08dd33e8d34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gKkyQnlg7vzpeCoJIvtQ7MwZv918FL6ArirmjJZrEox2iwpBeIophDnCUIjm?=
 =?us-ascii?Q?0hT599LU8sdo37Qcr3I3J5312djuWIo+hgoPjbQunTAoCTpLhA7bwnm/tSEv?=
 =?us-ascii?Q?Piyt/gqWn9LrmxUxIjrvD6i7I8H4Ux5i6lnI8fQSX1y08C1tXK3cHTi6b//F?=
 =?us-ascii?Q?Ek1Q2ySf9umYPBiE+zJWG7CUND9urgx6Zluaht1fZGdEkjrcoUN9PucriWEF?=
 =?us-ascii?Q?GRxU6mPxx2gMOq43Ik45Z765ZHmTFlgF+0kX7789GywNmgyh9XsejRY8jD+l?=
 =?us-ascii?Q?th7bxm8Ih9YphZ+ChjWblcu6nONJ4YuoC4SADo+ANc4DGIoTh3swazlkWrs1?=
 =?us-ascii?Q?1YP+h9B5vArQ99v5971bl1DnZl956nvNozAnu8NIyqUEwbrjd/1CkuhoLbMC?=
 =?us-ascii?Q?4QJmtYWbBr+/HWSWLf8DfGN7sORU+1/rVik/mCZpe/9Umegl+yQ/R3NZQtnN?=
 =?us-ascii?Q?z2wTAAZ0U4Nl0ar1I/Jl8nQfMVlq3KWNb6np/z3VlXjKtvg3wOOoN4LHw9kj?=
 =?us-ascii?Q?D4zMKmBkWS6sPo0RoMVInvxRA+cxkO4aljGoCiTaVVtVnkrIR0K0p6LPa+//?=
 =?us-ascii?Q?xmSyMC5EFgwX/ujJt/bUv+v7bTzulizFa2Ix5WTWQ/3lAdq78sl6aqdCQdXT?=
 =?us-ascii?Q?KIiyFlPBWjq6GOJYQT1xN5l58EA8qSCz2WVJjovf5b+BqAUsf4aNvmlusXOM?=
 =?us-ascii?Q?UfDuniyH0MJe/QLa2sBYbDKyefqg69cN3jRd3TJ8hz1/P0VoemGlBlgGwLzE?=
 =?us-ascii?Q?EBaLiKsflwzcjkQSlvZKb1fex8r6/aoSLVuezubZUeQ4J6RTkrZ1OgOqNhHp?=
 =?us-ascii?Q?EjD1ErWXACfscAS9yDJxLgyNAyFIlZ9wJuJnlGqLvVc9wOY3vZhRKDABOyPZ?=
 =?us-ascii?Q?bsmf1kF/pTQ1LTvBZAvtDE3tvs1gXeo879iwVoXxECAASj/fJXrL83mMEQVt?=
 =?us-ascii?Q?b7lSrhOl9ITJ/yZJh49rD/HyRVLOCtv0ws5K8BMwaHeWtocxEMJ2QimMThyb?=
 =?us-ascii?Q?bJIoaUW3pP6aHpEe+a+1YaGMNdno1rdwtgar8+qx8lP5DPo/RmJAbqhQAXu8?=
 =?us-ascii?Q?LVztX6gsciWjZg94lv6dLeWe1sQmkxRZ8+4uVHVXVaVi5MPOoMdzkZ90dwAs?=
 =?us-ascii?Q?5m+6ewyTcH18u1/4YMIhm96n5Zq8Wjhu6MhDP4kclMjtKR4QPmYLKehccbCy?=
 =?us-ascii?Q?J+svYkhvBMwRo2FIxvDjNpYKglp00fu+VPzq8LcYXS6FrGsXrvHg6lmIFFCn?=
 =?us-ascii?Q?2QmkvWJssADQsaQTzY9fgNUMnsCKvaIdOJr9yviZzNliyejvHR8OiVtW3/eg?=
 =?us-ascii?Q?KEpGk6KWDn4924HXPbeE/m4LjLQt19/0Xm6dQkSntwozOabF2Umx8ZH6q2Ek?=
 =?us-ascii?Q?Zuxdero/ePOBLxG4K8GUZEv5/3CRYfurjW12O/n/Old93FV/bm8/OoyjYbdR?=
 =?us-ascii?Q?ZN160zC52/KNtg+/YoQAW6ARKybOrtUQRvJieHa6VBFbyEtTYSuI9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:02.5663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d734404d-1508-4717-e1a5-08dd33e8d34e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

From: Patrisious Haddad <phaddad@nvidia.com>

User added steering rules at RDMA_TX were being added to the first prio,
which is the counters prio.
Fix that so that they are correctly added to the BYPASS_PRIO instead.

Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6..0ce999706d41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2709,6 +2709,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_BYPASS_PRIO;
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
 		root_ns = steering->rdma_rx_root_ns;
-- 
2.45.0


