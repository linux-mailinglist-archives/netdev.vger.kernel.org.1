Return-Path: <netdev+bounces-113984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB594082B
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38FB2841C3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DC18EFD5;
	Tue, 30 Jul 2024 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="upNQllqj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92816B39F
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320313; cv=fail; b=qXCiCK2434/zJ7e4t3x4yolvlUFE/zk6xSD49yfEwF2p6qtTAh4kwOdR3Gp5HWcPWrjHylYMCyMlqdvJ1Bf+aN4zP7tP+SRQGwnLJBo8MnJf3JAekh/ygZ7UKogDeSSE/MEkVqIs4467JKel53fQSymRplveY5e7BHf8+gV5jWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320313; c=relaxed/simple;
	bh=NbmaWv0YMoom56JhFvrKAePfMR+xffX9Xiyis6TJUaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpBu4N+SjBtsQ8YTUIsi2PjDvIGq2dGmJI8iYEcUcZO8Pz5LHkqld4Hodpq6Q3EbB/VomtcoXFlffoLm9Wd73Lsfq1RJhp+9teUe1VQIIamZPpDYA4B0oha7o0J6GVJcueB1+byI5gAFXyL6Jv7/7hyof7M16v/R+Uc7tAJ9f+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=upNQllqj; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncRVNudMFigAcBuid6UFyY5jFHtfsCg49ubNN1ADyN4T6Prr1qp88Lbw9QDsmKDrvf/TtlTIBUyHJpBF3wnpx2ihZXEa0VCM2DxI6s5XLrAiHHStlfVHzHKFkziPWKzIMEOaky6QTB2Roq/PotwTnc7bzidZQXnngAdjj5TAAjdgL0CF70Ht7xEidYpjWPLyXBYXa45BGrbsi2c0UTq7qwGr1LDo631ngdwJExFI/xGts4ZKyOXvabTXgMlBZNLi2uQiierZBMskj4POLRTUVIUYcHrBkdS8hj7PMp4dSSoR/cj1DupQ7dtHg7wjcxWwXO299HMWCjel7MqRGGKl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+4BIMWbJR6WS3qzD2XYx9Y15yDW4tk24V8ZXgE9V2A=;
 b=DS5tXRjenz2kyAyT8lzQy7cEC6XETzYIuBre3HjBxeb5/is0fiWYlCaqq5/RdwTRDqERLNTgNtBHZAtpmsAMZ+rZ8tIuSFwiFbyne8qrM+WfMdtirPZTfKBhh5foqm4EqpeA1HS9vQqZVFajlUzf3dDg+rn9aEj2tDtwkOGI7H5pOnF9+5Tu77EdbywMwS8z3WEdikReX0PKjO7WZzDgIPtpUYwxvAOwlVY2Vauz6QGlr9CzlcLqZ2XWLekt5yiLbBttDYhJ2LqmrFVqymiY9mA4IgRxkymQXQko3FFImwibgTpCiOGGGERAVXGwKN9W74OIptGdUtcO545sBn4Uyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+4BIMWbJR6WS3qzD2XYx9Y15yDW4tk24V8ZXgE9V2A=;
 b=upNQllqjXCR9vtUPB+9CUPyOVsq53rs9jEvW9OExEXt52mp6JPGchjhpGHid/IOZIrzX602xsDQ1xm2s/q/aolbhYI7gbNE6dXP3DSGyF3Exp2Z9ow2/zSibun0830Z2Lqsl3fLmS3TRISzeS9gF/pwcjheV/6QHKdUbChw4EJGjeL+2/jAOXnEH8WThleLVFLduvbcqDigtgbzqT/e2hnRRPK9OvNvMVXflk/SFvqvjKJW1d3OvvzawgOvFAP9MKGV86tkz95FKd9XymV93BZ/cI2OP8OrwbizP/ApFrZsFum+KGiqRqscnHBbM0mmFVYKKh7Ey+dHTxSXKS0uu9Q==
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 06:18:28 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::ec) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 06:18:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/8] net/mlx5: Fix error handling in irq_pool_request_irq
Date: Tue, 30 Jul 2024 09:16:31 +0300
Message-ID: <20240730061638.1831002-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: ac43f48d-5482-42ff-7f5b-08dcb05f6d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVra8myJ5i1Gukoogc+eIGC1PsTJwhDlA/m4FhKs2EDB6Hx04MkeiwXzUrBS?=
 =?us-ascii?Q?zmYmpdgk0gaoDVoRyfBBOfO+JJqN5rP912Ht1mJk4JTsF0ReCnsYHtv33lIt?=
 =?us-ascii?Q?/4T8wRSbXuDizooFSuGYDoBlANRMttrCQFEVPsklrtzpXbRug/h1dZbEw68I?=
 =?us-ascii?Q?yPFCYwKwrE0s3fehJd1yXAg/lMi3Uikr+irMvbX81Sy4IrJqLye3vHC5g6kf?=
 =?us-ascii?Q?lDRf4zVESl+7ugYYyQ0jajsCZMGWsCnSUpEy5Dbcz7AOOy01PCISEmUwFSaq?=
 =?us-ascii?Q?OpR3stk/LbLfsqUEkPMhEqmVTRiuJwFZrxhG0Ah2ha7Sw1gk3dbK7tEW083v?=
 =?us-ascii?Q?rs0l0AeYC0jSLDiWXwsdly3tnUuvM3saogtI3ZBxrmN/452aI7b/b8zdmjxO?=
 =?us-ascii?Q?6M9KWTWrj1zHaceFnFismpxVV5mnwNjB0pxP1EHPICvEcg5iz42SVI62VsEY?=
 =?us-ascii?Q?4WG6e9cnfKfXee9Ru2W8DhGKd0AwZapOqMKO2abMWW/iSIjSJHH0c/rYbI6E?=
 =?us-ascii?Q?4FN3vVHBkv65yRjcG8eXE5nuIhLPUY3Ixxa6Ghe9y/2VG/1+SY7SDspUAfQn?=
 =?us-ascii?Q?Vh/7cUoa278AVUSbrNKhj0jsrd+itNwy0wbpDgzzTI6/qlbpSQx8/JZ6F6EN?=
 =?us-ascii?Q?0dTTWGpygUq6Sl4FN/0A6V79hcSfswvNwt2c30VsXYx3dwkq6BlDlWNLq/Bk?=
 =?us-ascii?Q?VS9QYnY+0wflimiFwv99/7ynVDTiV7yHZxBVKaMAbhZlBKkzBSpkM71E67Zj?=
 =?us-ascii?Q?0fowCsXFt60O51hsvPEK1scIO54bOZs4jclGNFfP7vhOlj8QGVw1bzzW1Dma?=
 =?us-ascii?Q?ObmeVLi2odJr9s/0qpjw2h96bNNqX+1q9eRM/jaFG4N8K0/6CpgJo95U1aZR?=
 =?us-ascii?Q?+doj/0gl8nbUz1/5Gn5D1epglai5OKy60eLSHrwfn9EWm+XuZxrM0wxDCZ7l?=
 =?us-ascii?Q?eeBaw9hr8b+VD+kDr0kBg9JD4BALTP0ALcTUgWY/aN8ewwu8bbEEDcYpXrFV?=
 =?us-ascii?Q?zFODBT84lMBeUwEyR6jY8F6Qqpi52Jsj3ErSJcHT53lnADW/jt1wlicZZP8Y?=
 =?us-ascii?Q?lJj4hR2NXuG2+/3fKsrveovy2aMlfq2nUDClLyGHxAsouZ8D5SSuAYFooxrS?=
 =?us-ascii?Q?+CY0xYeQX9aFFrT8TOQ/W52fRR7oG5/b3g9KOFSrh1gGSqVEjazT2fVNMaHp?=
 =?us-ascii?Q?ttoV+a9dhia2FXJsabfJsckHsvM6mtke2M1Oi1oSgOXfzdtZUrLaIVPY31cy?=
 =?us-ascii?Q?6XezfJlht0uN5DaOjHZyt9ugFIVadDepW4STacXxL90ihiP+EcOzAUcNZkX5?=
 =?us-ascii?Q?+hPb9rbzC7ywsH03XTGosWwlnI/bezbVSz1WzDiNoDqdfz0i5N1Pea7OixLA?=
 =?us-ascii?Q?lJOcOThgEvVJyDV10Ci/lN7uSY4+6mmOo+uJNO5cBV9ldxirR2dUY4fXJayx?=
 =?us-ascii?Q?dhQJ+8X3YiKZnVAXEHVdtKZytvpyuTzL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:28.1103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43f48d-5482-42ff-7f5b-08dcb05f6d58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

From: Shay Drory <shayd@nvidia.com>

In case mlx5_irq_alloc fails, the previously allocated index remains
in the XArray, which could lead to inconsistencies.

Fix it by adding error handling that erases the allocated index
from the XArray if mlx5_irq_alloc returns an error.

Fixes: c36326d38d93 ("net/mlx5: Round-Robin EQs over IRQs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index f7b01b3f0cba..1477db7f5307 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -48,6 +48,7 @@ static struct mlx5_irq *
 irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_desc)
 {
 	struct irq_affinity_desc auto_desc = {};
+	struct mlx5_irq *irq;
 	u32 irq_index;
 	int err;
 
@@ -64,9 +65,12 @@ irq_pool_request_irq(struct mlx5_irq_pool *pool, struct irq_affinity_desc *af_de
 		else
 			cpu_get(pool, cpumask_first(&af_desc->mask));
 	}
-	return mlx5_irq_alloc(pool, irq_index,
-			      cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
-			      NULL);
+	irq = mlx5_irq_alloc(pool, irq_index,
+			     cpumask_empty(&auto_desc.mask) ? af_desc : &auto_desc,
+			     NULL);
+	if (IS_ERR(irq))
+		xa_erase(&pool->irqs, irq_index);
+	return irq;
 }
 
 /* Looking for the IRQ with the smallest refcount that fits req_mask.
-- 
2.44.0


