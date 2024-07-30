Return-Path: <netdev+bounces-114179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF479413D6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893981F2467C
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067101A38C9;
	Tue, 30 Jul 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLU+gmrS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CF1A2C2D
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348013; cv=fail; b=C1Y1lgYFXrKNyPVj1bX/H6cx7f7HC4kGx97y/DCkZeQ87TXJ64Gp6xLU7+WBK+vDHiLX5o06UBXplI9WJPJSsgj5Mj7Vu10A9ocbU07QM4K1oJE/twWJ0xLmFcdZMKwKgA4yTVl1UT3ymhwmkoc0uKoq06I86egPpbEW/FJCjLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348013; c=relaxed/simple;
	bh=vYkSw8KRtDYPGrYi23Dw8YrXSZImnclqFqQeNm2HZVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZnQi7sxVsYI6nTbEHsuURxCWujfF2AlvT9cWLRfljGMzVp/uxODb5SVk/8CLATKy9En0WNj/Qs9zVF+4ea65I/q1zDQIzA7EoQ+pYc4R/ybh4UA88pW+tfGwdPJx97AArl8s8YaPo8Se00Nt6Qju92Z1pYQDxnodvQOBCGcRGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLU+gmrS; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmaVtZLGp+aIiKYqra5JhTwKt+GMj4JxnC5BBr2B16gjUw8LKFkn1BK+DN1TO2wzLLC3WgknikC5LgJAlXHHsyrnDz1xT1+RZRMockm1H6FD7ckZV5+yQsAkY1bQQL8Nz73DIAWlUKHlkCj3HCvajy0HmJOEOxmeuCU/Gs3ldcdKmyEHhNVP/J0rdC0qmE5MgmO32NCto+y2cW31nyfo9MqXDdbuVLjLLSLZoGHRRJ7aR5jYuDlKvF6MbYKeeBF5aDBpcCuVhghjzjJT1Njm0jPX5gsHvZBQaTdJrYDzPMY42osMZYoLiIESu13XCN0RzT6ZtmB8iqmHhI4aTvWagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg9Pc6Jo+v5GamRk1BJnttWzWug8t7q+jl6us43TI6M=;
 b=Mu/gdfZh+8TREZJi49VgCS25EsFd932X68NsFxKr00F61ck8m8Rym0JRR/5DhBLt9kD9N3QJYmPjzdQX9GHXz21H7HUP7UsupjaDOkmhNZi3NZB2ynmRVLprfvmhZ6r56zSkpvTemOPM3Unc6qbTWK+hcosAXgXYeJUn14J7wqT1jNWbNTZqkyJh8y4RSHUgYQw0yI0lxzXKmHZ4c12tt8nRX9EIcQicpYwFtDtICUgcPG6AF33BpCfXiMAFfAkXvGwslyOy4kwssgTBa0pTuTOS9TalzcJndWK+7xN/YhmJ/rq3C+PogCHoGKx052Fk1u6eaxeY/YSpg5yVfqdJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg9Pc6Jo+v5GamRk1BJnttWzWug8t7q+jl6us43TI6M=;
 b=RLU+gmrSdkSOdHrBtaPebYa+pu7cerIEmLPpcdw88/m+jpZk+aX9Zck4NWSEITVmk5wT0mBugjp9RCjAOOigDqyuhSEEy3q2V/i495GxLeEGA6ypHlqNEjrMLUJxcJ1qbrTdT7DvsaqZWYPf3eJ0VS31jqAYw9W2xA8lMITshqL3LrU2ajVf0FvxABEuFW/Lf6ObKhJPPkLNUH9ZSm5U0BWhOMLxj1lo7Hc3lXcujO8VS2EbDPbBE4ftd69mrJY2RsI9zr0FHPJtzmnT7ul+05j15L8BpevQfhpr71FoPhjZRGvBFyYCyijZop/h7uxeLm1JMgtXZDlHRyAlcWECXg==
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by CY5PR12MB6129.namprd12.prod.outlook.com (2603:10b6:930:27::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:00:08 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::7e) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Tue, 30 Jul 2024 14:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 14:00:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:55 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:50 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/10] mlxsw: core_thermal: Remove unnecessary assignments
Date: Tue, 30 Jul 2024 15:58:20 +0200
Message-ID: <ea646f5d7642fffd5393fa23650660ab8f77a511.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CY5PR12MB6129:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfe1d33-45f0-4de9-3cf8-08dcb09fec04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2mtziAHeYNFSK9cgVuEYBDueglapvDku+C5XFoRx8bkSjaJCoXO0rzwZwtw?=
 =?us-ascii?Q?MaHhIuRD2LJa2pIwy2f36VqDZo8Kyo/0DOEr9gwHfgbKasDFaX7t3sjKkBuR?=
 =?us-ascii?Q?Rece/Dk9xyhPjilOV926uVVNKbN+k5ld8SRsBl/Gc4uOg5qIEBG1SwrQOeO4?=
 =?us-ascii?Q?93sZYUIxwzx3m1aEr0cnykCYsgtfh0Yk6go/CPYyvO7CLWSHL4LxF9rsBdeB?=
 =?us-ascii?Q?LK/jTq3rmkaeeOxzLnYiWtjLAgG07GhrWZOoFXw3NeiTGFJTB7zrmLAvSumn?=
 =?us-ascii?Q?p4jeT3WCnApDQZbdzCCMj03Qwvx3Do6kCAs4odft8RTBDoCtxua8DNnKW7Cu?=
 =?us-ascii?Q?Vt5BhLLyL2PkizE5ex3j5BbNO76Y/kxAeTWApRTrDcQnoH7f11lXeljSuQAP?=
 =?us-ascii?Q?xnpQHal0ijhX3LXhFxKkZ2PPdutnCKOsv7Ee43GgRt868jBzhH22tfSt2e0c?=
 =?us-ascii?Q?LwCQE4VNCqzkbaxkP7nIVUw8Q0MeQinrja1kgGuvQRWFRBFtcKFRiget46aj?=
 =?us-ascii?Q?A4delRqkN30fexnN1xHHUf6/gyJrrct2T1OMuO4T9jwwhDNQq645Gw9n57Y7?=
 =?us-ascii?Q?cCKTcpw9SZUvMEuNoByASGGqaZa2ab3eaMyl47XaHI6dF0u9XQP2pQPWz0oF?=
 =?us-ascii?Q?322c0xzVqZag8kX0k4TSlKdK0fmfQaJKGSxxD2mKRS2/IIC9/+KKcyO9T5Ng?=
 =?us-ascii?Q?xUBg0po64v3NrUB9F+VHoPr9hrVD8vav6nPG03rxYEvDG6eC2Oj9lXTZNX8h?=
 =?us-ascii?Q?CKqtjq3TYsgy3qYkRAhBnpVsDERBsIlt679O9GFm36MpG72zl5+0MocS2qw2?=
 =?us-ascii?Q?FhXDgCgtB/mAvJFUE2WHrEB/br/efJDq9fCvxLPEifl5KD2KMHLqaBrfAtRe?=
 =?us-ascii?Q?fP5h/zucHuMDgg5TUIENJxd9vi9Ir7046yYzfIE+ekDqDrCnJ5eWqrQnLmNz?=
 =?us-ascii?Q?XWIgC79BX7upFGMgjOrpmuBBSqNnuP7a5OvmTtRd32u8xhg3HOeDJUzjwufv?=
 =?us-ascii?Q?1wiNL3G75XFsbSK+A/YPBNofXl0P/lbjOw+0ZemU/PxKW2+cXAhDsKWxUh1n?=
 =?us-ascii?Q?e04H7DLNfnd1NZ4wAOAG4CCd7WUrlHwLIprWf4UoEOs+dV8vszHBeqyQGF6u?=
 =?us-ascii?Q?0h58lNKZb6wJRKUqdUAzgfK2OUdBeRZLsR5uBQFPQdeTQfqKo0UrWKtShCxQ?=
 =?us-ascii?Q?AyyGL69K/IyeZUsf8Lzlcb+2LMRzwzBA3ki5NGZqkvOiIiWkjB1d/bhuAj4B?=
 =?us-ascii?Q?LR2K9ApsMIqfX1cAeqpJEA29UtA1QOra23CIaYF9w+HY44I70ZE5wCe+9wNW?=
 =?us-ascii?Q?hKtvhl/xZ6EITNlpwePiJvJLE2y5iMykW9i2SH93AxCxYHUSD3+/cKas7STU?=
 =?us-ascii?Q?kIytV3VSVL94Kce9soI7U1x1hJlr0EQHAq8Bfz9R/F4KpGXZVbeRt2bTvWbz?=
 =?us-ascii?Q?PoyuFdEuF5fxcLRj+AOqsnfaa24XB+1T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:00:08.4507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfe1d33-45f0-4de9-3cf8-08dcb09fec04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6129

From: Ido Schimmel <idosch@nvidia.com>

Setting both pointers to NULL is unnecessary since the code never checks
whether these pointers are NULL or not. Remove the assignments.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index cfbfabec816e..269c4986ea24 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -468,8 +468,6 @@ mlxsw_thermal_module_init(struct mlxsw_thermal *thermal,
 static void mlxsw_thermal_module_fini(struct mlxsw_thermal_module *module_tz)
 {
 	mlxsw_thermal_module_tz_fini(module_tz->tzdev);
-	module_tz->tzdev = NULL;
-	module_tz->parent = NULL;
 }
 
 static int
-- 
2.45.0


