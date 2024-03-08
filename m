Return-Path: <netdev+bounces-78738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A48764A8
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE52D1C20BF1
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458021D52B;
	Fri,  8 Mar 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f7zB2q4x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EE1CD20
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902992; cv=fail; b=tpYyeOJ5piD8bzKJehZtmQy/DvzQIYQRWvcvgiBurfDMe36WumHvgfDsyx0oMgsreJcCOAgLhR87rDIo1rSDUlisKqnCGaHNwyTAuI3BMlPcZwxTyXdia15pelMYGFrL/2bpO7OL+5S6JWLzHrwMDu9P0Mz4ArYxLErER+ZoET0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902992; c=relaxed/simple;
	bh=ROSIIi7AsmMDXDtWdIe7kQuU+SIVMlu3JA/UeNSeObU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SURzOZJ2zODnD1+/OXXBXgMYhH8vzHbrLvbzQtHCwUJMHzGIYlwi0hRfnG3SU87sCWXbv40Kv+xmEbTAwK47kFRA7v5r/qn7Fot6R7lVTkYkkJBzTazYA+cNUAnf4PNkKW6PE0kUT/une8rni+dhg6zYh3CcL9841OBg7VKVLiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f7zB2q4x; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpGToEARUy0siDSyT+67La5zSVLQlpFlmDJUjccM41TlttbJpOEsBFw+Y9jD1YLiAm8zxxhnT5c0Z6KyXt/zd2yk4vrP8XOh8p0O9zxfDWPbQBOiwUc8E8ZoSB2KQ7fRmLUhfsducKIjDls5pdWl/pTMzatQNKyZResiShig1WhWWgjcr+GkfZngtdEVDVpERjHEZ4PmP1oF/s9fbbnUQs6CHSMCPTHp3p5wNF63qHn8nmUsDFuk06xNbb55K8IO1GRhHDmPkhLKdqI1CnELvj7m0Yl0VsDsLazofDdRQIFyH41HEfOBAnMebrBHgaMSVmbgC9C8OWkirh6xQ8NwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzro2YMAvjFu5gJ5cL15mw+EYu3cMpht/X9Hh6GgoWM=;
 b=MtFeOBf/Aj1kxBQPQw6vJG/wF/DjBWOSk1anN7SYamUgnNQWx1C+bjPZaicIYiC5pdKO2gJtNRAQt5hR779067x5FeeIoCIrCTKDjKoO29IxPpw37Oi5oYWLavECSPJsOq7CyMKMj5ZYrEZD5DtTAldxqAaCWgpVde1YBOj1HtwJE5DlcTDlVkmiY/mzbzQgLOFqYsob7+mtHIbZLrd5sUbea60rIhIZRx7Ivmcs7xRzBx4xUCbNverUzGIoIciyyZj/ARIClEYjgrCU5X1NWuV4T/QbLcFJJbswmEFzPlX26dsM/JoakUsCFY7XTHSgebn1HKG01tcHNVqf29g25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzro2YMAvjFu5gJ5cL15mw+EYu3cMpht/X9Hh6GgoWM=;
 b=f7zB2q4xivNCSy3YQRjRLMoDZtlMT/IzapqlBxuZFzTgXrtegQlHqBE2uaLfdnIBez/0myxUbPZH/Eq37ntITWWmXQJX9rep7P3RLGjhvzfDHhsmdKT/lR2sH7SkfLotzBILgIqkirtnVVwBdOXMocfkOOpziibGdjTcJoIV9sUJDXDJn2F+HkNHlkqFRel+/pfRfCaWjKc0R00gthEUlbwB2X8v5+mHhuzELBPgaONbsPktC4CQf/MZ1hQbcpCjUlZf2/seazIguYQRjcXVadrjYpCcQIxdyVQbDGyrWUbJrAPuXlxLJdt8q+z6Gvg/+9+JW6Q7Et9Z7nrWgLrU2A==
Received: from DM6PR07CA0066.namprd07.prod.outlook.com (2603:10b6:5:74::43) by
 DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.26; Fri, 8 Mar 2024 13:03:07 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::92) by DM6PR07CA0066.outlook.office365.com
 (2603:10b6:5:74::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:50 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/11] mlxsw: spectrum_router: Add helpers for nexthop counters
Date: Fri, 8 Mar 2024 13:59:51 +0100
Message-ID: <61f23fa4f8c5d7879f68dacd793d8ab7425f33c0.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f88611-a3e7-4463-9e8a-08dc3f701926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i/m2lm17FWYkY6ZuF+ZXi90T3l9f3uJmqkikFbh9o3JNJRHkZA3ITHv8Fbiz3w8ApTHgvJBmKrrWf6yMu/H8UILtrL2erxIig6cPgWZIsIdugZ9VA9HngbwS3FjKnn45oGwqHkQVp5C1ZKq5dIUpvGKWvHB+Ay6B1wuiueLD7zMMBe/g8rt0VOjsqEM+u4B8usw2791na6GgpeuysICweo+nsdFY3pQxBvFUfvg2zcAmTqDyBY+FartsYwSx0T4++dBgS6bF2bzQgWWiH/2ckaeBf1sD7SZtg+R47Mcncqb60kxmNM9KIPgBTfEaGVfpctVE99j9popZs3lJj2s9qz/3jvrSY7VG/Erm7dRKClDCe5c6c3GkESNJHQHhQamKFW0pAVUpycsV89rjEWuSSda3+RLLgQK6kqL/gpKKEcQSx1WMeheZuWc9u3JsEL8hcSnjTQOVeE4HXDT+akXFM8GROJSWVgFu8hSAfjT21j2QcWYLfLfSKKRMot1OnpkjtjD822OwFAvhiVsh9yW8nJ6zoLmUyEyHVoag2VZIz3CTxRdyjdqMBtU2t6dyw96m1LAym4w7Y8wKTiTzHsLVdZCe2XtzVdOYq9K2kwxI1/3crVIXExc31de+rw5DTiKFDJEAYX3UpcDVvpxTqrFDbHOHdW8CvmzH4Yxg1CT+bR6ZaVPHQRDUhqeNi2iSAg8K5mymaMtJ8OUm68qhXs8D6nT/77C8zAnnVNjOqaRpy9Z8+gLz+udzBimNdL+1Zm7I
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:06.9053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f88611-a3e7-4463-9e8a-08dc3f701926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

The next patch will add the ability to share nexthop counters among
mlxsw nexthops backed by the same core nexthop. To have a place to store
reference count, the counter should be kept in a dedicated structure. In
this patch, introduce the structure together with the related helpers, sans
the refcount, which comes in the next patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 65 ++++++++++++++-----
 1 file changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index a724484614ab..73a16c328252 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3049,6 +3049,8 @@ struct mlxsw_sp_nexthop_key {
 	struct fib_nh *fib_nh;
 };
 
+struct mlxsw_sp_nexthop_counter;
+
 struct mlxsw_sp_nexthop {
 	struct list_head neigh_list_node; /* member of neigh entry list */
 	struct list_head crif_list_node;
@@ -3080,8 +3082,7 @@ struct mlxsw_sp_nexthop {
 		struct mlxsw_sp_neigh_entry *neigh_entry;
 		struct mlxsw_sp_ipip_entry *ipip_entry;
 	};
-	unsigned int counter_index;
-	bool counter_valid;
+	struct mlxsw_sp_nexthop_counter *counter;
 };
 
 static struct net_device *
@@ -3151,13 +3152,46 @@ struct mlxsw_sp_nexthop_group {
 	bool can_destroy;
 };
 
+struct mlxsw_sp_nexthop_counter {
+	unsigned int counter_index;
+};
+
+static struct mlxsw_sp_nexthop_counter *
+mlxsw_sp_nexthop_counter_alloc(struct mlxsw_sp *mlxsw_sp)
+{
+	struct mlxsw_sp_nexthop_counter *nhct;
+	int err;
+
+	nhct = kzalloc(sizeof(*nhct), GFP_KERNEL);
+	if (!nhct)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlxsw_sp_flow_counter_alloc(mlxsw_sp, &nhct->counter_index);
+	if (err)
+		goto err_counter_alloc;
+
+	return nhct;
+
+err_counter_alloc:
+	kfree(nhct);
+	return ERR_PTR(err);
+}
+
+static void
+mlxsw_sp_nexthop_counter_free(struct mlxsw_sp *mlxsw_sp,
+			      struct mlxsw_sp_nexthop_counter *nhct)
+{
+	mlxsw_sp_flow_counter_free(mlxsw_sp, nhct->counter_index);
+	kfree(nhct);
+}
+
 int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_nexthop *nh)
 {
+	struct mlxsw_sp_nexthop_counter *nhct;
 	struct devlink *devlink;
-	int err;
 
-	if (nh->counter_valid)
+	if (nh->counter)
 		return 0;
 
 	devlink = priv_to_devlink(mlxsw_sp->core);
@@ -3165,30 +3199,30 @@ int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
 						 MLXSW_SP_DPIPE_TABLE_NAME_ADJ))
 		return 0;
 
-	err = mlxsw_sp_flow_counter_alloc(mlxsw_sp, &nh->counter_index);
-	if (err)
-		return err;
+	nhct = mlxsw_sp_nexthop_counter_alloc(mlxsw_sp);
+	if (IS_ERR(nhct))
+		return PTR_ERR(nhct);
 
-	nh->counter_valid = true;
+	nh->counter = nhct;
 	return 0;
 }
 
 void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
 				      struct mlxsw_sp_nexthop *nh)
 {
-	if (!nh->counter_valid)
+	if (!nh->counter)
 		return;
-	mlxsw_sp_flow_counter_free(mlxsw_sp, nh->counter_index);
-	nh->counter_valid = false;
+	mlxsw_sp_nexthop_counter_free(mlxsw_sp, nh->counter);
+	nh->counter = NULL;
 }
 
 int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 				 struct mlxsw_sp_nexthop *nh, u64 *p_counter)
 {
-	if (!nh->counter_valid)
+	if (!nh->counter)
 		return -EINVAL;
 
-	return mlxsw_sp_flow_counter_get(mlxsw_sp, nh->counter_index,
+	return mlxsw_sp_flow_counter_get(mlxsw_sp, nh->counter->counter_index,
 					 false, p_counter, NULL);
 }
 
@@ -3662,8 +3696,9 @@ static int __mlxsw_sp_nexthop_eth_update(struct mlxsw_sp *mlxsw_sp,
 		WARN_ON_ONCE(1);
 		return -EINVAL;
 	}
-	if (nh->counter_valid)
-		mlxsw_reg_ratr_counter_pack(ratr_pl, nh->counter_index, true);
+	if (nh->counter)
+		mlxsw_reg_ratr_counter_pack(ratr_pl, nh->counter->counter_index,
+					    true);
 	else
 		mlxsw_reg_ratr_counter_pack(ratr_pl, 0, false);
 
-- 
2.43.0


