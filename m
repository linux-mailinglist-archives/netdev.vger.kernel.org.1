Return-Path: <netdev+bounces-78737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5488A8764A6
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05053282E38
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872481EF0D;
	Fri,  8 Mar 2024 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="inoY7kkN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C9F1CD20
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902983; cv=fail; b=jph3DKDXntPSObYZVzGoLHZRi3tzwSHsCvIUSNxyZzjB12E9S4tfpb8XSbTQ7vZt1jlcFD2ZDIxuKBaduabtZ3iQzQSKROYpUxrWAeRGOprOHJKV3Q6XdF5VmATVtMdPwEC73iwmmFWcNZe00P9NeK+DBf82a/KzjfYalkYVd9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902983; c=relaxed/simple;
	bh=b1Z502eE1pOmziyhkKqwwYV7Js69TIreh7QKy27rc9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu/3q9kb1gwfVFVCStN+exNj0fFqhUFC9vC0keAzQ8/F65nz8sWfNSf3jKsyl8AQjlS5wTIs8/lxFN3to7XO+hkTzLGrKLJmvLZbWdlICrPpa8izn7FmR4tMLLBE6fQBvlZ8Bde15mmZyrvVD5wQiGVWUqOfKsfU5NTG4K2oICY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=inoY7kkN; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zoia7bUdy9WZvqntZsb7+m063PRYpGjbdUjVn3wCt++ImbaxemAyJToye7VwL8LM74G6+GOD27eorbWnT14Cq3gpHorDt7l6Bj/QWEfJtbbMeV6qQ1c6e7YiNsuLdTpvHmbsm2u6JxurdFq1VKsVQ4lbMDZN6dteDSsKzLcaCWm89ncKdHLH1fpNRgbXsjNr+d3VFKu5TUBleEeAuRKxDiIwPWuhZBrZ3UmXO2M5Y59AYzeHbrnCBmcdzgp5k6kVe9hgZ91M4di1uN1/ewvSrSLgNfIO2HXy8E1Xx7DyBzDmBl3RmX0CdTlztD9I+iiwCX3Fc3t5nDw7MQPc4CS76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3khXWJaPaZwPLElsg/C5y9LC0+vM+nse3PRz9eZuiU=;
 b=c+NnOswOZJSOPZuIJtJM+1jYa9BKKkRpi5EbBV6i1Fk7EHN7/APIdO1isbnmjJbMTe21jiW9NdHMGoP38UY+cgwKD08BelOIoVoXnl6xY9jnw1IGbQIPP6GdFNgmkEDuHYPfU0735nD9QUohWLZ4PJks/NnDkS2KB+c6uA01WWzS7RGtj/N9Zw37fk0/QOpQUIMvkwx/x7UvKiDXzytHFv8Kx0vyWuh5nH+7pUqiY5qV0yZOoTAyxRjRSaDW9/cu9UlFjGs+fJr2Bv4hwcEUeeVV15cq5cRmWTsQoLWqwYcEi39jc2R0R5svHWZ8uELzzsgFwtqXwGc2iIjzcPyoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3khXWJaPaZwPLElsg/C5y9LC0+vM+nse3PRz9eZuiU=;
 b=inoY7kkNNzTeadMVGiRb3x/d8AfZC6K1wc5WI8mE9t0qikKssvD7sGzK7r22Ljj+6/4IQrdeVQ4VZaZHKHA6mEFnlGA71Z85LwcCBCwrCcFMuWcho2sk9u13nK20Qccpo+LKD7GaSeijikNIumPONEwTXaN9RXHNoLBBukksUxs56BtutwY/XMhDASAQeVJv365Yqz9qJZF+9BzK8qFR2PT+r7tvsc4uBRGs6pkc+EnXL8k6aL45mWIxVlYNBBz11LM64WNqiTc3BtMucFmWQ1Eshw3LpAuLVrfw8r3zEqzUeEEDmUdirYXDy12HBq7Og0jHCXDrEWvU+wdetJkETA==
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Fri, 8 Mar
 2024 13:02:58 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::47) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 13:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:02:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:36 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:32 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 04/11] mlxsw: spectrum_router: Have mlxsw_sp_nexthop_counter_enable() return int
Date: Fri, 8 Mar 2024 13:59:48 +0100
Message-ID: <e0bb5c0cc6234ade2ade1e92abac991359c3f446.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 986131dd-0af2-4788-5d97-08dc3f7013da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kxTl6y8pmvQ4R1gv9BeTOoe21m8RNbaKhU/b4ZdQS/9PUCzLtVZDQEQeZNWGyU2xleO1jL1cM6QePqSGbs5+KA6FXV1O44Bpl2W0yXtcU6G5BvXYS+N6nX6BoNeiufzt4ehLRsTXOyfSFGE014Lj07W67oPGmiHRxWO/sNq1ZP8hlv3EsjNURC7s2ezOobREAfezpfPkjjh0YdtUfbiZGE6vo435owozU+IvTmMdxNkqvjBXI5SjKwuM8p2fBFSHn+W5X4K3hw0/fHapRgY/WB4R7DftOP7/1O0B8M88FjyY8qs39Nql3YRB2egRJJdJwuJSmVlXKGEAjzjQw5Q4sN9HZUiDGElwiJeid+qZm1ul6eeHsUInsiwQef3akfhNgWL2f7+8P4dpS1nHeO6r0Bfvc7OFUj7cqPdVuJTJGPRBKANoa7gYzTJgXrD8DoppLyODo+mLjH5j9Ff4FNUNM/cdDNaZChKxOycFmUifhz1t0tZ8bphVV03GeR1O/NcD5L4zhnfLZRfBho5pyM8dZo8zrTLcLIw9uDjSLV1G6VijCkHrb/qqFDt8pdCuhKXzquYlZPPh8SFzj+Yu3u5Wstror56QGoDKe7BHcArBPY5Nga/9DWhYgzSiUH2eGid9jiUGZRdGDaY8yKkhbGBWDC0pATeMsZ2zXMbGz8Sar7jPy8+9eYJb4RMTLsPqP2f+kqwSgITZkQfoTeQoDW41H2M27rVM6snbK2aJGnswz1x95gwbP4LeB1mOjsamPZIK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:02:57.9701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986131dd-0af2-4788-5d97-08dc3f7013da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547

In order to be able to diagnose failures in counter allocation, have the
function mlxsw_sp_nexthop_counter_enable() return an error code.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_dpipe.c  | 20 +++++++++++++---
 .../ethernet/mellanox/mlxsw/spectrum_router.c | 24 +++++++++++++------
 .../ethernet/mellanox/mlxsw/spectrum_router.h |  4 ++--
 3 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
index 22e3dcb1d67a..ca80af06465f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -1181,9 +1181,11 @@ static int mlxsw_sp_dpipe_table_adj_counters_update(void *priv, bool enable)
 	char ratr_pl[MLXSW_REG_RATR_LEN];
 	struct mlxsw_sp *mlxsw_sp = priv;
 	struct mlxsw_sp_nexthop *nh;
+	unsigned int n_done = 0;
 	u32 adj_hash_index = 0;
 	u32 adj_index = 0;
 	u32 adj_size = 0;
+	int err;
 
 	mlxsw_sp_nexthop_for_each(nh, mlxsw_sp->router) {
 		if (!mlxsw_sp_nexthop_is_forward(nh) ||
@@ -1192,15 +1194,27 @@ static int mlxsw_sp_dpipe_table_adj_counters_update(void *priv, bool enable)
 
 		mlxsw_sp_nexthop_indexes(nh, &adj_index, &adj_size,
 					 &adj_hash_index);
-		if (enable)
-			mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
-		else
+		if (enable) {
+			err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+			if (err)
+				goto err_counter_enable;
+		} else {
 			mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
+		}
 		mlxsw_sp_nexthop_eth_update(mlxsw_sp,
 					    adj_index + adj_hash_index, nh,
 					    true, ratr_pl);
+		n_done++;
 	}
 	return 0;
+
+err_counter_enable:
+	mlxsw_sp_nexthop_for_each(nh, mlxsw_sp->router) {
+		if (!n_done--)
+			break;
+		mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
+	}
+	return err;
 }
 
 static u64
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 9bb58fb0d1da..23b54a4040af 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3151,20 +3151,23 @@ struct mlxsw_sp_nexthop_group {
 	bool can_destroy;
 };
 
-void mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
-				     struct mlxsw_sp_nexthop *nh)
+int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
+				    struct mlxsw_sp_nexthop *nh)
 {
 	struct devlink *devlink;
+	int err;
 
 	devlink = priv_to_devlink(mlxsw_sp->core);
 	if (!devlink_dpipe_table_counter_enabled(devlink,
 						 MLXSW_SP_DPIPE_TABLE_NAME_ADJ))
-		return;
+		return 0;
 
-	if (mlxsw_sp_flow_counter_alloc(mlxsw_sp, &nh->counter_index))
-		return;
+	err = mlxsw_sp_flow_counter_alloc(mlxsw_sp, &nh->counter_index);
+	if (err)
+		return err;
 
 	nh->counter_valid = true;
+	return 0;
 }
 
 void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
@@ -4507,7 +4510,10 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		return err;
 
-	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+	err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+	if (err)
+		goto err_counter_enable;
+
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 
 	if (!dev)
@@ -4532,6 +4538,7 @@ static int mlxsw_sp_nexthop4_init(struct mlxsw_sp *mlxsw_sp,
 err_nexthop_neigh_init:
 	list_del(&nh->router_list_node);
 	mlxsw_sp_nexthop_counter_disable(mlxsw_sp, nh);
+err_counter_enable:
 	mlxsw_sp_nexthop_remove(mlxsw_sp, nh);
 	return err;
 }
@@ -6734,7 +6741,10 @@ static int mlxsw_sp_nexthop6_init(struct mlxsw_sp *mlxsw_sp,
 #if IS_ENABLED(CONFIG_IPV6)
 	nh->neigh_tbl = &nd_tbl;
 #endif
-	mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+
+	err = mlxsw_sp_nexthop_counter_enable(mlxsw_sp, nh);
+	if (err)
+		return err;
 
 	list_add_tail(&nh->router_list_node, &mlxsw_sp->router->nexthop_list);
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
index bc5894c405a6..0432c7cc6b07 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.h
@@ -156,8 +156,8 @@ int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 int mlxsw_sp_nexthop_eth_update(struct mlxsw_sp *mlxsw_sp, u32 adj_index,
 				struct mlxsw_sp_nexthop *nh, bool force,
 				char *ratr_pl);
-void mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
-				     struct mlxsw_sp_nexthop *nh);
+int mlxsw_sp_nexthop_counter_enable(struct mlxsw_sp *mlxsw_sp,
+				    struct mlxsw_sp_nexthop *nh);
 void mlxsw_sp_nexthop_counter_disable(struct mlxsw_sp *mlxsw_sp,
 				      struct mlxsw_sp_nexthop *nh);
 
-- 
2.43.0


