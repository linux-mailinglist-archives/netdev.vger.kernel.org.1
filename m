Return-Path: <netdev+bounces-135516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325499E2DC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 042F61F22AE1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF2A1E1A35;
	Tue, 15 Oct 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyvQgkGt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7241BF2B
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984796; cv=fail; b=Lvdhx/OBq6E3WRfD6wrx/Tuo1WfRz+tgisozrFLMYnYirnkOvYz4bYOrtZu90zDHgBHZAQqz0OpMvcRugJFNae7675L91N/GUOqjuWUEisu8M43j5kpWiknc4g19YupOk/ZgUOwQMl0xgEY4Ryb3ElqxJvrEpFUB301BgQL8ZKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984796; c=relaxed/simple;
	bh=RIgNXzUDW1tmaBaaaSw6YFgAL7dCEPn9cmWmfLKxyf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxPVFfzla76QtLOd+OwchglQrqHl34L5XCsqTbVAbZjJcttO/TvikRGIITTqp0PpdBpGqP7YV52MOL3Wr8Umt1IEMWs0Qfw0a2FTnA5L+oc07svGA4R1y18Ac9JMhed7iKqcO87t+4F96zatHPmiiajT+xcb1ouLaAbDAStd3VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MyvQgkGt; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6lGUNUCNpQ7lSIC7ZGic1b0dHC49P0wr6G1XtTOZuX+tL5Y46OGK2VeuBIe9xNR3a6s4bl88eSAhANywQNHZLWIz8EXpELiwWCpS6UIpcjlPHryxvJ+GkmFz8NPhHml5GWpU4xGrbRmva13DRBcWDdhGZ485iGTbGMkF96dA7icObk9Ytv4ow3tIERMVEZRbbNAwhCdBDMcdsw6Qd+YdbbLVGiS2JSlXga/2tq4K/E84Q/krcryVlNrJrTq7wTI99GXbruoXylsWejAilinqDvFvwUwi56wyAtdtzuh+VY8dTUkCUIv3pY7zuXoscWvZwE1mQN7KX08xHPQbRx9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWhvuN1/izxpBald5CzQXQE8pPPOlTsUYXCfDfRxB3Q=;
 b=xwJl4y7YI1t+ymxeT0blPl26W6rJ8Ez9VeCpssF92tdOGDyhhT9Vir502/Mf2meh3ickxlfPiFNR9Sbq+FEQ3JeOHryDC88j9CY4OL1Ff2gUwihw/QmPRSsKvZ2SXQ+tnhQDm98jc4y6GURyl/SVshCfGmjOdkdHJVZ+ShmRPofnq/D610PLv5EpcQrD8AZvADii82jHxUcQa1UvICiHbBx2vcTtZXf9/ZpOoYzks+WSN4K0jCNOGj8HWEpgb6c7VrUHY8KHMiIuyazHtBHH1FTwjxHuoCAK5+sVrB8PIUk6C86S7SVunXUajzYhJ7xag4KM6ZC57idNdpZQYkbDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWhvuN1/izxpBald5CzQXQE8pPPOlTsUYXCfDfRxB3Q=;
 b=MyvQgkGtQJEMsM7UyCzK9cKo9UWdMiO3zaSwGIXhjb9YZ698XoL/QG4O//qj1GmnOtlQ/z2PImfFNHRvvkmfcuru20Hcj2hMwRba380RGPgcNJbAbtuiBWWpkSeGwVrIiQEj49ArX6MrSc/EJq5qrvLBG/4u92gxiWKZdaG5jUUUvkWEeSS5smI9N3ppdkDjGuJXFYMZJAkImI73qrv/TapjYCN8es+g7ncYBMWLoiHP6tsbBJeuIKIYrco4r0y9TJGgCgCB4HDPdqYsvNJCD8olXlzIMmD8mMLjLNKYSrlAF7RKFc/Xqucy5L1NBhZdLIvamVeeisL1hLI5+pSzPw==
Received: from SJ0PR13CA0210.namprd13.prod.outlook.com (2603:10b6:a03:2c3::35)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 09:33:11 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::d8) by SJ0PR13CA0210.outlook.office365.com
 (2603:10b6:a03:2c3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:32:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/8] net/mlx5: HWS, don't destroy more bwc queue locks than allocated
Date: Tue, 15 Oct 2024 12:32:03 +0300
Message-ID: <20241015093208.197603-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: 943269eb-1488-4a98-cd45-08dcecfc62fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vob+QhkIoBfrTYlakF1aiZ3ESkatb3+ABb+bZZa5o1ZTUCkkGdcG3vXBz4qQ?=
 =?us-ascii?Q?Y124pdvNw3J6iessfiD8Q7nuumujxnWmeZaerartA9/p5tXII7gqasBJczpH?=
 =?us-ascii?Q?Eu08McwDfbUJmjhfRE+ucdwBO+pM8G7rM9bCToC/nMlx8WcDfFI5jElKOF7r?=
 =?us-ascii?Q?DAfE0Q+UCLdftUrOgUnRR5fSw7rFNMgRTLOsRfGA8wTnZfKx5eHjq17EaEff?=
 =?us-ascii?Q?GzoIKs7JCtR95Zsmc7wgkBGZJEziXgoC3NdDcCcFI1B8bsUggMmChrd/0dbm?=
 =?us-ascii?Q?aq9inubzDB9HOxF2ksDmZEAP+G6LJ9pBaPHLFNF2QiKCQmHe4LX/v1yGV5Yk?=
 =?us-ascii?Q?tNR3T1CSP+dvWGPBB+W4QpDPx92SKQK4doEM+gpGNXPxa7mK3RpikgHMJNTS?=
 =?us-ascii?Q?6Xp/mMqU9oK4FctwSoC6J177UtqenkgfyKf0ZoVR46r24B9K1dtjllY/Rczy?=
 =?us-ascii?Q?D+O+pPYhWaSOVVS9wY0DrMGXQk21xXtPYi7xcypzZBHk1bntmPASK8bbALnk?=
 =?us-ascii?Q?sMnrw9aNvDQcf5pxclNtJ0KiCCU1EZtDYd97Kyq4Y8mhBO9yoZGznsFkd8Sa?=
 =?us-ascii?Q?7sSigLDez12yp5+F4YhQm5DrW9oPFPAX3XE73PEgqYOTaBGxVvKqC+XHCluM?=
 =?us-ascii?Q?LJHeKaCLgPlWPhb+mpBRG/CgMuxhXBvfDGV4N9Avwr//IwHRgKasNgdSQW4X?=
 =?us-ascii?Q?pX12xZb1CoVNQeI6PnT5KfhC2JqU7l4cp2vmcbToa99b80MkcLduuRAfkND0?=
 =?us-ascii?Q?Q24r4nbCqrzXowleoCJWzgDxBOoc+rUb2BLeuidIAXKDUlgqFurHkTdg5M71?=
 =?us-ascii?Q?YN3Phqz66rToTByhnSt7UTmzmLGTqM3WlRUmMx5fiRn7BMj5g11+tbmn9XAD?=
 =?us-ascii?Q?e7dzHPXOgD0iOnOWjFIfyg9jjANVBjYfxocf5Ol27qBL2f6ZjffVmhdGYgr1?=
 =?us-ascii?Q?9hQhsdlJl7KRNgV3E94NHg+8Y+fRLl4qN0iLRufwRrU2GCcxiDisBwmpqqfb?=
 =?us-ascii?Q?O/qZZDRuGNFQx0ho8lwLWA+llcNaHZ5AGU9qh4qCLklAX4JX5xrwqc2g+v1w?=
 =?us-ascii?Q?zMSNqI+RMHnZ/U1dUgcIafJz+zZdZMeq0tIL5DTZKaeRvKG7cChic7TeTG3Y?=
 =?us-ascii?Q?isV1ixaa0qt2iDuBgwjeBWr8WaRlylD2ywgc1Iq8jeb6juRPxKnACP53mXNe?=
 =?us-ascii?Q?it4x/0DnhCFhl9s8KqOwy57Eur/lcOiWMDLOAK+FWUbgOat3h1LLwakzCs6p?=
 =?us-ascii?Q?OY57qwA7PmwljUK8EseqXOkMaOb9qQPHBvzeKEsNSyt7XSg9iGqOYI69W+h1?=
 =?us-ascii?Q?ti81jpZtj3X24w/Xuol50D6AKSR2FfxTb8Fijleozf9Dnz2pCieN50OXtnty?=
 =?us-ascii?Q?jpH8nky9J7Bd/dy3mRpTUSBhaAEO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:11.4944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943269eb-1488-4a98-cd45-08dcecfc62fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308

From: Cosmin Ratiu <cratiu@nvidia.com>

hws_send_queues_bwc_locks_destroy destroyed more queue locks than
allocated, leading to memory corruption (occasionally) and warnings such
as DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock)) in __mutex_destroy because
sometimes, the 'mutex' being destroyed was random memory.
The severity of this problem is proportional to the number of queues
configured because the code overreaches beyond the end of the
bwc_send_queue_locks array by 2x its length.

Fix that by using the correct number of bwc queues.

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index 0c7989184c30..e101dc46d99e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -941,7 +941,7 @@ static void __hws_send_queues_close(struct mlx5hws_context *ctx, u16 queues)
 
 static void hws_send_queues_bwc_locks_destroy(struct mlx5hws_context *ctx)
 {
-	int bwc_queues = ctx->queues - 1;
+	int bwc_queues = mlx5hws_bwc_queues(ctx);
 	int i;
 
 	if (!mlx5hws_context_bwc_supported(ctx))
-- 
2.44.0


