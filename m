Return-Path: <netdev+bounces-86250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF289E317
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B9287CF6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3A157E70;
	Tue,  9 Apr 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qi+vUQJo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F26158A3B
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689774; cv=fail; b=O2JV2xX25kDtjkruROuc8Fe7fR4X96AQsqhmf1E5MVU70G8BbW8GtCgnCTSYaI70/E0zc4WhSj/yeFuvtieGwfmVqlLS8YVi1efavElRx+guHB5eYZ1PYZwCmTC1n5zwl0x5QPnrpIYc2n6K45fGb2ulp08fNn1rt1fIl0KO/QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689774; c=relaxed/simple;
	bh=a+hcMiuzMiSz0tVSVz7teTtviG0x74OeCsBem+wFyhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VxQya2eZZFIF7YUnWtMkibMh9sRZ0UBO2Qur5PyR2A/yzAaHwJLmklY+07mcwlQC+d59XCsjbXKhhcbTXgRC+erL7Nxf0R3oixf+orEW2jD4XauAToBmPlDWN4dHlIELHKk6ETGzd0DB4rYspSiKyt7z4/YCi7aKY3gcC3hszP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qi+vUQJo; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1TPah+tUaBQoxgR+f6wienksrBIMpBqGbPiio8Hq5BLu1MVgW+S3WkCtuWyV1eEM8C3X7iivQik6eCRcw0KBtq27NSgqgXTRApZtqJA/QHY6FOAH683lItUo6QsgkAhW3UBS4yE87lEK0IVzT0mItA4Whxa2u7UAO4BlEMOR7kA5LQ8CjXevfhfZXctzeOKeiGH/PettlME/x6wbjC3H4KruEjMU+vDRkE6t9bHPsNTtO+YOnigbZybr8/cZuXWb/sspQn89T1vKdnSjSU2HOUIY/8WAk0nr9PqCxvVLOBbyLBO3y0+g//KQ88IKC22M0AOIfGDnJjCP6VPgES0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIiMFiEZmWJDusUAHVYej7E3nKB4qXBVdF5SYh2wTb0=;
 b=ASyMC1+I9HM9RjrikaFD/NMlBogAr+uSDK+3DBlZOgZVx0RyFbVt5qqAxOd2NB0nGr7TbcFyRBI0wjrqmr89fIv/xabkQxi+HlivM2U7RCL3QudrE3EBmZ6zA6T0nO9LYd+uljPsKmwjtkCHqQ82ZgYPW3CjeBarqDIDao5+5vdo5MH0KsYybgJVD0tR4D1GN3/g3CxVAXGakpdZU6Flc9jEODWPl6Y1srlRL/7eVb+tkTjR9q33pSvZcKnUNUaASrT1M7vmiK1cPs2lO7vLvSNDsmDMFeqqqST1Hx9fnUAlsKMR9MnW/+SW3S9nEO7yptFbjBQP+wzm0ADcrmxI+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIiMFiEZmWJDusUAHVYej7E3nKB4qXBVdF5SYh2wTb0=;
 b=qi+vUQJo/3rBtLqbRI9vaOisicNN91iVMKbaMk0IbmmDYzP2s11JLHKpkOa47tYTSUjKZKKpOfdhUHyiMOyjtRMwHI3jRkoLC+5/dFpxVw6IqdKp52G9h16/WUqYVYfXxTHinMrKdeqWRT+gqcOyDmWpdrq/E1O99itNBwIgW3V1/2j0M6KmtVoyT24wO/ghH1sndJfXoWRfw5punKNgox02L9uVsiuekl7D+IAYYgzFx2KvOb1UQ5CUeBCl4Nk3OcNSTeDGtlADzEBlOwock9RkMTyFDLK6etqygvj1/NFW02pXj2F1wMKcJfuVhEl76FPHrUB82tu5vrqseJcUTg==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 19:09:25 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::f6) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Michael Liang
	<mliang@purestorage.com>, Mohamed Khalfella <mkhalfella@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>, Shay Drory <shayd@nvidia.com>,
	"Tariq Toukan" <tariqt@nvidia.com>
Subject: [PATCH net V2 03/12] net/mlx5: offset comp irq index in name by one
Date: Tue, 9 Apr 2024 22:08:11 +0300
Message-ID: <20240409190820.227554-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dabc6f-4d4c-43ed-4e22-08dc58c89239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d1tmdRidYinaHO4Pgb015PK1OVOqz8oXf2waPIsWkb4EcncA1xjURroEKIus1b3vuBt27lKVp6KkGSaL+tiMSgvOLvIl8c3lHrPNYCDDZAeXjG9Aq8khFgMZ4D+R+1e/ZPcULG+EY6GG9UTIHpk8SGWP8AWzyQ+UVvKsT+p3U0NoAwHtUE/Mvg2ViJiRfNGYuIpE4tyo6annYkiIOApgXwBm4Wgaiqx/S6hTHtKphur9ETg0KlvmFU5CUQ8DFYyyWCvF1u2DHEQEc4+v5vtEUWe5MSQq8a0gtfhjsu/ScmTJppMJbCwJzq9qCktRlJwhYibk2w2tdlZy7N/vNQ6eei22W+gzuuojTHFLtyew6xcZZ62uvB5WD2vT6r2Sk8TWfGNJ2GE0Nh42hoiQu3BOH0TFhLUXhTuFn/d5rBU0D+N2Hs8qLwlN7V2T+VZk6RDp0ngbGoA2VgNlCQlzrHCSB8SiKH2h2nikTYyMT6rNTrU0jDlnEjRD75USjInxXCq65SRD7TT9vkbzBnuArHGIyXHD5FyThBjTnC0cbElybFbsw27t0Y30gUg6dXnnDta1PesDokSBa3UxP1e0ZkrlAb0dVEbiCxS8R976e+CZDupyNPrG1Tw6HqD9iiShbvPHIVjNjIjdeAjasy0BcrvGUxikK4Pp/GnatrNTmrC1FB894q0zSWcxMOrXT7mDaE7OZOg5LX0ljoiY7HpT6OOHehnHhgJHb2p07o1at5p7B4Olu1NysL718f38XwsNYWNr
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:24.8137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dabc6f-4d4c-43ed-4e22-08dc58c89239
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656

From: Michael Liang <mliang@purestorage.com>

The mlx5 comp irq name scheme is changed a little bit between
commit 3663ad34bc70 ("net/mlx5: Shift control IRQ to the last index")
and commit 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation").
The index in the comp irq name used to start from 0 but now it starts
from 1. There is nothing critical here, but it's harmless to change
back to the old behavior, a.k.a starting from 0.

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index 4dcf995cb1a2..6bac8ad70ba6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -19,6 +19,7 @@
 #define MLX5_IRQ_CTRL_SF_MAX 8
 /* min num of vectors for SFs to be enabled */
 #define MLX5_IRQ_VEC_COMP_BASE_SF 2
+#define MLX5_IRQ_VEC_COMP_BASE 1
 
 #define MLX5_EQ_SHARE_IRQ_MAX_COMP (8)
 #define MLX5_EQ_SHARE_IRQ_MAX_CTRL (UINT_MAX)
@@ -246,6 +247,7 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
 		return;
 	}
 
+	vecidx -= MLX5_IRQ_VEC_COMP_BASE;
 	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
 }
 
@@ -585,7 +587,7 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
 	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
 	struct mlx5_irq_pool *pool = table->pcif_pool;
 	struct irq_affinity_desc af_desc;
-	int offset = 1;
+	int offset = MLX5_IRQ_VEC_COMP_BASE;
 
 	if (!pool->xa_num_irqs.max)
 		offset = 0;
-- 
2.44.0


