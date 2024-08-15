Return-Path: <netdev+bounces-118732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A634E952953
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2031C22321
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF48176AD7;
	Thu, 15 Aug 2024 06:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NzwuVNSS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F25177992
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703097; cv=fail; b=TJkGQpufxC2oy0WWUiVD0t5xe53FY24Bbou64nnIR7XpmwVAHvo+SCfC7Ay2+keRZJjj2fH2xIRQQ07NJZUEkNhEpyD/pyKvIUq0hEer9BWEVJH4GXZNNSk9gP9ELQJSB47wStTbKmfaFSpvnD8Zhq9ikIe3MROoFNoHcvRmJHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703097; c=relaxed/simple;
	bh=2L2yvoNcrtB2UH/lbpc4I5BOOpAXzT4/sWacMmDUXIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbJjUx6lp0wzEc9O1bBZ7hLqyMCmEBM3x/T//rgEuyegkoFNQUspV0mRjqNDORJpt4MUySVvhh3VTaFoshJdIJdlFHYdsOL305Y9z1uTeo8Z+57czx+S8HPa+xMnj/L9KmDnknH8dSLREe01Fxcor35EOsB8RufUN0wWhPk/BvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NzwuVNSS; arc=fail smtp.client-ip=40.107.93.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiZMc103Y2NgeK+zlbFnxA3xDfFJglwUeOxvr4JDz8xpypvSYunPKyT7699rndkPOpHx0NFloC5+27iv9GchqSUWetpGVGjQGHLgv7tOFd+fAz3xTWsQCQbmoZauFr0Wbe3X+lCPRvBlN9c/F9GblpEGhos7tcOov4HWwoJrHy667pr9RtWS36vMMr9W2OF9RCu01/sXyr7haGlLRO4RFJ6fACaCzPD1QYJURKqu49pE3hIShgPuxneDlu9MoG9M8AqhztFUccXHB+pTy3Smeq/E+uCGnlmQiBlXC/JM5REgTktk9KhDKyoOZtya51GdnA+G2Ig61BnsIv7x7s3wPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DvvZJ+8cNipjUCHumR2S3iCbwH6JDI9zKHQf3fzn1w=;
 b=TooYBCStonnxlxN5A0jnKZ4NnTxbhfK51/7XJg/+VXZu9v4WXHOSYauwh2DNZpv1jFRwpqspGIMb9CtE2U6qWFS4JJHj5r3O2hyfTXgApleH3J5vB2gRKCgirYvuaxV9qGdnWGPcCuhrrvNYV1YmSmi30nTlaMbHa/F99o4Sv5fibAMffrQGUh6JNLR9poq7E5T0jn9d+A6teIt5WHeWK8YsmSIeCUn7jCjyNSUtswfPaZDmiz4SGdzy8JfrB4bcV6zZCCdsYy7WMxVxkqcy0pRmSSV/kEn8CJF2jzQlYIdRkmpO0qDTiFNkSNhbtt9RGESBSLDyv5Wtuhaoe/l8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DvvZJ+8cNipjUCHumR2S3iCbwH6JDI9zKHQf3fzn1w=;
 b=NzwuVNSS2ez+aoKNB8fVuXIML70CFCcj+6gRIXmAUZTLeD0W1eisuSCWbeVqQXBH/LGUl+QORXmK3NUbY1EA4nAapy5+Erw4DS4d80tLbn7omeYS6mW6GJ3rUy9BCGXcoE31PLTKaAiGSMjTjk8vLzWRcME/JDrS9yaLmJBD2ZTcKJLZmDh4lm633vIrpgWm2MnKXlnP08reJegdPaV/y5dnd8v0F+P8Q8vAre04LkY3vrLmGP8P1fO85KXiCAUhzoOQ0TGmGm2aAVNYOacRuXKm33jC2lHAxWJRZTsubzczQrZuYqGI+crEe1WhCrfXStLeXzNiTH0MvsgSIwYVPg==
Received: from BN1PR14CA0019.namprd14.prod.outlook.com (2603:10b6:408:e3::24)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:24:52 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::a2) by BN1PR14CA0019.outlook.office365.com
 (2603:10b6:408:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:24:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:34 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/10] net/mlx5: hw counters: Remove mlx5_fc_create_ex
Date: Thu, 15 Aug 2024 08:46:52 +0300
Message-ID: <20240815054656.2210494-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c244203-0b5f-4b33-477b-08dcbcf2f8ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/pD5+SkW3nrAdmI0NZj7UuhCoi26o4e+nEHf70rqYRdH1L52W8y9jw6+fsd?=
 =?us-ascii?Q?7t3hnfOVtQtPuGZQ/V4hiI1mqf1DrsjdUTEkolBADJYpLnhLxxCKaaiV+t4j?=
 =?us-ascii?Q?31digbtzUfLL+EGaR31UIJv+guLlwMWjluf+9jjeJzsO2b6DswKiVuUjZ7s1?=
 =?us-ascii?Q?zcqMiLoeOThL9siiXNaxG1DoIwaPuPo7569qfvDp72KgdtukAfSFnDVbIcie?=
 =?us-ascii?Q?gI9xv7bGeGFHG9HKZ+ddtcQnzOCVgRKk0EfV7TpWr0k2YVOh3tvvS7oeZYMl?=
 =?us-ascii?Q?IS4/iwMMYgsbz4yARVEddAkjRckJKJ4RH5GhCp5JSH1QHxD6LXHNbShe6PVw?=
 =?us-ascii?Q?b2SRbfEwEcNMZSiZZv0jtYBGJnDHsaZ2olXp3lnKzvcq3KqvokVGwD+vZ7np?=
 =?us-ascii?Q?oZ9uhacXsxokT3wbeYo4x1btFl8AFgihsuvzP3i1MdDJMDOy62SQvlCQ1XMW?=
 =?us-ascii?Q?vUfNLxfnHAI6lhHtKRgpFff/cGoGeq506uJ2YSH/rZDXt/yyaTO0BfP1mNBJ?=
 =?us-ascii?Q?nA3qA3wl02BttVFuX5n9TxtsXLM42DFNrTnKW+1pg1eNlS0fp7OIPoef0tqk?=
 =?us-ascii?Q?qWSX/OKjOR2PmIzMuJUby10zZajAOCJXOiyMdRyGdyiHWUUnYIWHWJ50vXbP?=
 =?us-ascii?Q?3Zm6IMcBSZe+F/KeGGvLfhM63VmZPoE10jnbFc/sNuNgtgIqKwBUYAbtIpVK?=
 =?us-ascii?Q?eOc4WiAxvYmaFyzCthJU06aYOE7BiEpP07GkOqPAsYD2hk6ErtlfuqWJ9blV?=
 =?us-ascii?Q?9jXnMHw/zYCsIo0/VkeZBoVqEI/J272ibizzRjikWzyV8epdT/1vTQo8vdVj?=
 =?us-ascii?Q?saZxauhmYKNJtZEFUdgp/GDbTrK5EHOMbxip+cw8awh+DckW3eRZHIX7hQ1r?=
 =?us-ascii?Q?CMI93YSn4NFcbQi7yllDbcCJHky4tm6FJMejFfQQHemovkaTWCqlf72h+6ME?=
 =?us-ascii?Q?vMF2T9e2q3ynvkIIwb1ieq2mco9KpXj3beQhTrRWGu94eBXH9lLeaaGlP88R?=
 =?us-ascii?Q?WaZ97JEZgA4J7C0uNfJIbbJtqMAQz8uZKfeCPOh2Bvhz2ECmakOhjZNxvV/O?=
 =?us-ascii?Q?9pITRbGsAXud2dga5CiNiDopTbnKnIIX3g3Cqetk8xhmbem8xwklgj0YZq3o?=
 =?us-ascii?Q?2K6tsRb11TU9uL1D3fAhnvO9+ynr8ut78Kv79RNRzEvW/dSvPd87xkxDontc?=
 =?us-ascii?Q?yemLszu4GGssHCWO7MQHMsvTUr1oqk3AVs76G0M+SoFrupvuEyXMyMyYYtw0?=
 =?us-ascii?Q?krdvqLjnId9rb9SthT+mQkMAx+jeMLexkrEdDoVEyJg51/o1c9r7bwpbDyZr?=
 =?us-ascii?Q?6ywaRBAa4iCnZntmW4oauCoIDvc3PNlMdZrsufIiszuLXtUDpSDsphH2PbU9?=
 =?us-ascii?Q?RC8n4XR97wLirM6ucv9rf+9BkYl/bnWwQIa4blzQrs6142n6BkUP8+Fn/EKo?=
 =?us-ascii?Q?5FiqWNZlwloAOi90TY9CcPN7bTuMH5pq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:51.8489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c244203-0b5f-4b33-477b-08dcbcf2f8ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269

From: Cosmin Ratiu <cratiu@nvidia.com>

It no longer serves any purpose and is identical to mlx5_fc_create upon
which it was originally based of.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c    | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 7 +------
 include/linux/mlx5/fs.h                               | 3 ---
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index dcfccaaa8d91..4877a9d86807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1026,7 +1026,7 @@ mlx5_tc_ct_counter_create(struct mlx5_tc_ct_priv *ct_priv)
 		return ERR_PTR(-ENOMEM);
 
 	counter->is_shared = false;
-	counter->counter = mlx5_fc_create_ex(ct_priv->dev, true);
+	counter->counter = mlx5_fc_create(ct_priv->dev, true);
 	if (IS_ERR(counter->counter)) {
 		ct_dbg("Failed to create counter for ct entry");
 		ret = PTR_ERR(counter->counter);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 0b80c33cba5f..62d0c689796b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -275,7 +275,7 @@ static struct mlx5_fc *mlx5_fc_acquire(struct mlx5_core_dev *dev, bool aging)
 	return mlx5_fc_single_alloc(dev);
 }
 
-struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
+struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
 {
 	struct mlx5_fc *counter = mlx5_fc_acquire(dev, aging);
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
@@ -304,11 +304,6 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 	mlx5_fc_release(dev, counter);
 	return ERR_PTR(err);
 }
-
-struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
-{
-	return mlx5_fc_create_ex(dev, aging);
-}
 EXPORT_SYMBOL(mlx5_fc_create);
 
 u32 mlx5_fc_id(struct mlx5_fc *counter)
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 3fb428ce7d1c..e73a852f51f4 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -298,9 +298,6 @@ int mlx5_modify_rule_destination(struct mlx5_flow_handle *handler,
 
 struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging);
 
-/* As mlx5_fc_create() but doesn't queue stats refresh thread. */
-struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging);
-
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter);
 u64 mlx5_fc_query_lastuse(struct mlx5_fc *counter);
 void mlx5_fc_query_cached(struct mlx5_fc *counter,
-- 
2.44.0


