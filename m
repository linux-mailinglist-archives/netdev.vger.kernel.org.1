Return-Path: <netdev+bounces-162279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251AA265CD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A68A3A6194
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F562211466;
	Mon,  3 Feb 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6nbJD5B"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A1200BB4
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618647; cv=fail; b=qULkB/DXy8f9uVZ8pOABDunmmPsPaoGqztCPwXTynlpbPfzAn7hsspcY7PWA1yQbHW6esmZjAvJ4abwJ2SgK5wuGtkhrnT+eammkLgB8+D9nnG6bvQmBvNPzhLZjiW3Yg4atS/z6SqZpdRndH4OuiNTUZGywm4sLAk7nVUdiqlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618647; c=relaxed/simple;
	bh=hLAQuwEUf0atSJl5522vq3VGzOlduGvHAjs89O1mXYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXg4CIazD/7GgCv/8MIrpAtwBd1hqlJm9IVcOuXj3LA+9vU+1aT7q/zycmU9l2ziWGR3s8ASLY81JpCrw59Jl/nozxjNO5jum2qh/Es4+MTve13nuXCcNR7s5+vB52kHHXFxLx2gU//qTampnwEkkpUOMYOlP4FmVldcvdic7uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6nbJD5B; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx/3ulnFYW9vZVZJ9EFQ2Rm9Hm3owT11rlNzMRu0X9Ow9vcuG2xV+l2kGFhSYf6SvxYQiSpQTsYmSFEeuO1ugNliQHICi08lgmRDf+Ke4HVi7LQP5PobRLKvxom3VnOPUgFNhkvjZ4ngifKqY+veLdWhaBd17c8EoFsV6W1H/ezes5dx/Ub0hJ3yzI7faU7sbMHNvF2Z0xS0yJw9wlxEw8G2Ny2xyK51ypjnUijAVHNGbBlsSiLHLEk4v91xO0QnNVQcmNSc6DVrqorBm8JH43WV8oVqzQdnryht/2kNsRH2BlnuB/cphiZOuw2Rfdi2ZwR7HM4Qro/FoT53TZfksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTDOoi6/xK/cbnbRZJ0PR49l2CvM2i/wsKiWaQrnRgU=;
 b=WQwuZkSZt48NriXKWlk/S8RphRNA6Mwt8KcR5xS6Oy09XnMadzayc5AUbI5NQ/8p3yXF6On9tHeMGkrTWrrusZ02jRasYNBnLueabHSOjB1XA6NQH96KOZGdZvy0amUSfqNO3A4fc/SuJqtfZhUv6oYrUXKgxgYn45OMYbKbyfRKw9d5cr5K/IdM2vi5Ys4Fdy3A4ulXKuAzNeG3pJY0TdWP3n4t772+6KXhD/epKL3YbluVRpeYSqIrCg+pq+ExfOqYmCbd9zsB+sWm0AIQfy1Hnp1lUIzBWvAQkjBmTcfhz7K0MMIkQW6njhJwd6QIVJYhEAotRLRstLQJTtfqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTDOoi6/xK/cbnbRZJ0PR49l2CvM2i/wsKiWaQrnRgU=;
 b=X6nbJD5BsLO2l7cT6+PqsChJ4f6GZ5ZLPLIK5y2gA847kO4jhL1er9cFaPu2AkXbuUqBNacaX8Ttvp/j6Nad/85Xp2yZx4qnT1WfCScz5cwN4sn7pdRI9guWKQn5i60Et6O5ZLUjGDB6yg2o5bMAVNr7qFr9WZdsuDBV/YFH+21wW/mC3HodlnOrhKqr/ka/yrG9koxWnguyziaJ2U6irvD84QDTTYLv9qi37AAGkLuoH2alf3ONu7orMQO7YadyiK+K8TEzseKachEjon7Vm/pcp3jv1dVxI9IH2Ne5ZgOHWaQnxnpW0qFMTgxzV9o+O12vicaHbUeECevHsi6fmQ==
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 21:37:20 +0000
Received: from SJ1PEPF00002321.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::d6) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.23 via Frontend Transport; Mon,
 3 Feb 2025 21:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002321.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:37:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:37:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:37:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5e: Remove unused mlx5e_tc_flow_action struct
Date: Mon, 3 Feb 2025 23:35:15 +0200
Message-ID: <20250203213516.227902-15-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002321:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: b0ec5422-68b8-4583-ed77-08dd449af073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?js8zgT5+U71t9MtGmEBqZV2up/OIx6E4xiOK3nVdwd14YR4KpIJ8IwQLjzO3?=
 =?us-ascii?Q?piHxCvpXPheE4BiZ23m1ftJTKMsZs+ncwgobFfAhd96mAyXlf+A6sqdn77XZ?=
 =?us-ascii?Q?6oqmRR3IkB9fG6Y6aHzRzCu5aTdnSSjRtQlRJK2a16v/a6QB91tB3J97DlFU?=
 =?us-ascii?Q?evdduedQU3T2HZai+8UOQXciVrbBvh45JQZo3P0gzT4TX7dOoftNaZmdH93h?=
 =?us-ascii?Q?nA4VSNUtIXvlixbg1nIdGxT3CvutHZgzXb6RpxxISmxt7ozY0DX+P7KGOppa?=
 =?us-ascii?Q?SoABBGyHsVzUqnQsTGMsPDDkBnaBcmRv4zzT61YcqRpxCYQYJhGs2PptNX43?=
 =?us-ascii?Q?MGWWvzaCtGRe41uDkNSXXPLR15Dh74F82XD3YivQ216aUDZ1HLYFxRdX/SNB?=
 =?us-ascii?Q?hQBg7JRBaxav0AYeUZw6q493RJwK2Yv5YSxdavhMidF/i7IHNXXI/oWlIMlb?=
 =?us-ascii?Q?sZIhDaq737mte7E7oTjZaxwwJfPt8eVzdJGc5OhAcR3f9KIErfpfbynb4yxm?=
 =?us-ascii?Q?TIg00rHOCR6vaDppd/8uG6F75fwcIwSeDLZuST7ChooXcxBNc9W0i4ESrgG/?=
 =?us-ascii?Q?VOjhmEGgHghvqGGfZ7ZyXoTFjHYLnSqy7tj496ruY4EZ2hbefsT7x5CJxOlT?=
 =?us-ascii?Q?ojHpM7rgvu6bDyZscK2dyArlrEMr/5t1Zz7mYCJoDFngbO/ZZt2Hb2GxhkTG?=
 =?us-ascii?Q?PNzsonuWqEhUlGzMWYTLwtmyTqN9d4i8HrseWvh80dhSKjoYLJeD9kavAQ2T?=
 =?us-ascii?Q?vF9s7Rix9NekJdQ22gNCD2MlIRgE5JhWZWTvdomUneGMuzSRmEY8oGK2hGUw?=
 =?us-ascii?Q?iKQRcHW5QmCDwrZaAjJ4HsIy5tdMhfgIYVUuZBkUBrDqpI+KYwu+MjMAxyYO?=
 =?us-ascii?Q?qwHazl4D9yTr/+z1j76aun6Ct0Dm4UjW4ErVD3PG9py85AP17vr/DJI11BZQ?=
 =?us-ascii?Q?oN8ttGSmaRnd9YCsml1Wa9wMNWjVPO4OiwaYCMGnnpOZZMk38dIg5EfmTrAH?=
 =?us-ascii?Q?ii3OHrWLUU/zPxCq8jbnch2F6IH8/LP22MZhgEZRyI1kbUaG8YarErl6s1N4?=
 =?us-ascii?Q?4N1Sk3KsOvW1OYwdgfqyUkOGHZr1GDkkrR5E5KTkOVXwYbDbzxkX897JwPF5?=
 =?us-ascii?Q?1KMv01G3P3c6MHfxa9u0lEN+9gnScN/Ut092Fp2afaAzvS1P9r2y8oFaYkmD?=
 =?us-ascii?Q?jfvWovdTGHmO/Kh6aTE2tez+B+H68F4Di8bK8mY7HOP9M6E0ONCZQesxiKbZ?=
 =?us-ascii?Q?8kzf7IZBZp5Em3Tm+zFHXS6fWEUcbTR58OG8/PhQj/Zp3O5XAEDtAKCvyplw?=
 =?us-ascii?Q?otEcsl4kneO5h+eY93Ef5JPESxN+Om8H8SQ77pnJao5ntfRC3ywoYPo/RHC0?=
 =?us-ascii?Q?3bSOL1neIKRtc5D00hjS4konO6kClCS9SdqGj8SP5sEkMqlHx2f1SyG/jmuY?=
 =?us-ascii?Q?PgX+GQse1mhkRpOlKFM53RNOwSeL1JWk6boy+h3Nfj52U7XcyChccacGyusx?=
 =?us-ascii?Q?PsnKRlY3rYyI2vk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:20.5791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0ec5422-68b8-4583-ed77-08dd449af073
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002321.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601

From: Gal Pressman <gal@nvidia.com>

Commit 67efaf45930d ("net/mlx5e: TC, Remove CT action reordering")
removed the usage of mlx5e_tc_flow_action struct, remove the struct as
well.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
index d6c12d0ea55b..2e528b2c34d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/act.h
@@ -73,11 +73,6 @@ struct mlx5e_tc_act {
 	bool is_terminating_action;
 };
 
-struct mlx5e_tc_flow_action {
-	unsigned int num_entries;
-	struct flow_action_entry **entries;
-};
-
 extern struct mlx5e_tc_act mlx5e_tc_act_drop;
 extern struct mlx5e_tc_act mlx5e_tc_act_trap;
 extern struct mlx5e_tc_act mlx5e_tc_act_accept;
-- 
2.45.0


