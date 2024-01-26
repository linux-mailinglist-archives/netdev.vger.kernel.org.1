Return-Path: <netdev+bounces-66253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAC383E219
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986C3285739
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FE224ED;
	Fri, 26 Jan 2024 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HRenGbTE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B120DD3
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295560; cv=fail; b=CEP6GzBkZqd9s3N4klP7MdhAXMPBhpoKShF6PC0rhC3uz1pw5CymFV4ydoExBUe35VB+AYIT1sWzxZHr4Ke29WwoTrn9To9lcOzZRKv2khnKYLUx43spSZt+kSBtmSNDo+nOGYw3Ll5CUoW4A3MQ6tfICzWKWFaUs7yH/wDZAFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295560; c=relaxed/simple;
	bh=YfDHAyiwybt+FZlKZhXLYYRSm2P97yeazTkzqVXZxJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEp/c0EvvS1dVGBgxqZbmxqdg1b0upbhaUZVEzXUvjxM1fNoB3P00oQ9CyhrIejpLq2A63rYELMsse88bQ3rKYoqvHcGmXxGpErD/1IbUw+1TiRwGlACMTBKZygzT6CoYWH0VCvAMsU6rU3y/+oIGNMZmm/i6sV4TktjHd8ELyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HRenGbTE; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+6i1AUV5X5/GIGT6XOsmN6i2YQ+dZs43dgn9dI1MgqURdJa2KEEBsRjNEkwbqmwEs7oUxMI+QUJds89/vBXeZJ5rhN/B6TdLjfRr9crNDtQPoJr99Cn1pV+rS+SJyljMY4aYV7hz7NN6PwqGmk9xdnW5ZslY1/WmXfkioRzNVZgmBo3aJuzOtiyg9oNhF3IoM2SNOyqKSX5E+7p+EdCqR7Q7v0dfOOi0AMrGsQzD9HDGSdGnV3Y5VUuAPe3w5zDgWKo/FN3MfvNZKaW4FX3ZGF9jjwVdBoU401h27pXSN76D6m6ThE19dc0ndFs/d7dDUYDaE7xC9Ujgvyzcp6rLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2l50NdTWHMNZ9CUOS2Il/v5WpiCDu/3EdVSgy/7wPB0=;
 b=dIpRCgQVOjWvIZ3YNCyk4zSupOEqhySv8jV8vggdD6SdCYnoiH8qXueLyvYuPwofKnJsqJYefBgIYwYv6jTrije6EpxdVhXvf6netPZDIhLzUiEzIV0hEgzzKwny6UA+M4ePV0yrY6fh5xMDqxVmcnNCNUuzm20YlKxKGTPtGdteN/60BXOW7wYmHb4Jj407PNk2TcWgkyqNb0wbyCDWBR0WjBh/cPwmWndB7zAy71pua1iqXfAMEw9nncx15VPAnV7/qoKq9kmjIXPBc8fnkG0/xUQ7q6LQvNjnnHY9QD35QP0vFMGGSfx4Z9g6oj0IcEqd0iXey4OEzLrRfXqt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l50NdTWHMNZ9CUOS2Il/v5WpiCDu/3EdVSgy/7wPB0=;
 b=HRenGbTEXMz7USGFfqaOoIPv3OaqIot+ZneNCXZIrrIbBCsBRi7bHkhOcnkKYsRphI4UUwQePgaxHhs8z7p4XG9lea5doXh+5mrCWGNNFy252wZ2pnV0KiuBZgbYFHic3zfcrpsoRbi3RvJ4bG4au2VxA1uVSdMcCEYW+BpTaDsJdBg0MvuQtKrxM/m6rvHhON3oodkBqndqrvNyBnKfo+gTJGy3VN8ZA4BDjWitZBTM7fqVx+1EsyDJusH2I/Z0LUXq6T5U546aMIeGnLIf2F7Z04lySEdcCipclcQWkERCSx9uAt3ZZBi+N2Qq6Zve6v+fDMdDf152NK1/SLxVZg==
Received: from BL0PR02CA0066.namprd02.prod.outlook.com (2603:10b6:207:3d::43)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 18:59:13 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::ab) by BL0PR02CA0066.outlook.office365.com
 (2603:10b6:207:3d::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:54 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/6] mlxsw: spectrum: Query max_lag once
Date: Fri, 26 Jan 2024 19:58:28 +0100
Message-ID: <5bfdfa5f8df8ef0211649f08d508b631d104d214.1706293430.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706293430.git.petrm@nvidia.com>
References: <cover.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d3fdfb-2e2c-4e80-a302-08dc1ea0e2e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tGNEI/qzlAky5znagRjEQOXsjvetUGhcNHT3bZs6ZqOTm0eGOORPXzRBSV4Yz1mndCx9iTI/0pkNKOE3+3aqvtN2WLN8drPBjaZiKXcBk//JijRF4zQGcjgbDP7+fvDx8QuK7+4i00rvShSmYVeWK+g1g/aA2jvDjhQWmb3wOTHU+xtKK6gDb6G8mgTCsMl1cfM6DYhssKqf0uHmqEM2CAdQSOthBZz/C+Am+P6FDduoNGbX2BNS0ditN8BD1WyeggsgzqKdqvwXV4i6868S/5fzS+KxvFjjLoPu3l4105FYGbN97+bxj9oXO+TzTik88A+mdv99H/HLLIDleYhePwuEkBUlrLIre527HEMH7cKmRUJy5E39o40WPO/wmxYwpwp0aIPIgRKYNI3+rnE5fc3SAgba8yUxy4kPlJtDz6meX6f0k54lGC6KRcKStRRmh7BvC1RkjI+ly1X4y6dNrh0fE+PqDwLDrdRfCM1GKTAYVY9cC5jsNp/+b1x/trPC7LpynWEc9HCSMh1/3hEu/rp1YZNNRR+JtA0ix/aH7ossv53ESVRygQHrP220CcVIWh5JlRaujefyBczW82XmUIVW960dDjRaL8gkuIH34enN5IyvvVcik5lktchGfW1EL8QQfydB2/c3ojyzFNfdC5q0SoJKcmBkU61CLMi+CTjG3OKg4SDq0MM1awifpjOK5vc/RU9dWkK8NMG1LaqHiOTNBWzLzgdqBFGfQWz6RH3Liuoe01Xzf65WF7xakZyf
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(5660300002)(6666004)(2906002)(478600001)(4326008)(8676002)(8936002)(316002)(86362001)(70206006)(54906003)(70586007)(110136005)(356005)(336012)(426003)(40460700003)(40480700001)(26005)(16526019)(107886003)(47076005)(83380400001)(36860700001)(7636003)(36756003)(2616005)(41300700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:12.7906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d3fdfb-2e2c-4e80-a302-08dc1ea0e2e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936

From: Amit Cohen <amcohen@nvidia.com>

The maximum number of LAGs is queried from core several times. It is
used to allocate LAG array, and then to iterate over it. In addition, it
is used for PGT initialization. To simplify the code, instead of
querying it several times, store the value as part of 'mlxsw_sp' and use
it.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 32 ++++---------------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  1 +
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index ff52028a957b..75fea062a984 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2695,23 +2695,18 @@ static void mlxsw_sp_traps_fini(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp_lag_pgt_init(struct mlxsw_sp *mlxsw_sp)
 {
 	char sgcr_pl[MLXSW_REG_SGCR_LEN];
-	u16 max_lag;
 	int err;
 
 	if (mlxsw_core_lag_mode(mlxsw_sp->core) !=
 	    MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW)
 		return 0;
 
-	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
-	if (err)
-		return err;
-
 	/* In DDD mode, which we by default use, each LAG entry is 8 PGT
 	 * entries. The LAG table address needs to be 8-aligned, but that ought
 	 * to be the case, since the LAG table is allocated first.
 	 */
 	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, &mlxsw_sp->lag_pgt_base,
-					   max_lag * 8);
+					   mlxsw_sp->max_lag * 8);
 	if (err)
 		return err;
 	if (WARN_ON_ONCE(mlxsw_sp->lag_pgt_base % 8)) {
@@ -2728,25 +2723,18 @@ static int mlxsw_sp_lag_pgt_init(struct mlxsw_sp *mlxsw_sp)
 
 err_mid_alloc_range:
 	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mlxsw_sp->lag_pgt_base,
-				    max_lag * 8);
+				    mlxsw_sp->max_lag * 8);
 	return err;
 }
 
 static void mlxsw_sp_lag_pgt_fini(struct mlxsw_sp *mlxsw_sp)
 {
-	u16 max_lag;
-	int err;
-
 	if (mlxsw_core_lag_mode(mlxsw_sp->core) !=
 	    MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW)
 		return;
 
-	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
-	if (err)
-		return;
-
 	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mlxsw_sp->lag_pgt_base,
-				    max_lag * 8);
+				    mlxsw_sp->max_lag * 8);
 }
 
 #define MLXSW_SP_LAG_SEED_INIT 0xcafecafe
@@ -2759,7 +2747,6 @@ struct mlxsw_sp_lag {
 static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 {
 	char slcr_pl[MLXSW_REG_SLCR_LEN];
-	u16 max_lag;
 	u32 seed;
 	int err;
 
@@ -2778,7 +2765,7 @@ static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 	if (err)
 		return err;
 
-	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
+	err = mlxsw_core_max_lag(mlxsw_sp->core, &mlxsw_sp->max_lag);
 	if (err)
 		return err;
 
@@ -2789,7 +2776,7 @@ static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 	if (err)
 		return err;
 
-	mlxsw_sp->lags = kcalloc(max_lag, sizeof(struct mlxsw_sp_lag),
+	mlxsw_sp->lags = kcalloc(mlxsw_sp->max_lag, sizeof(struct mlxsw_sp_lag),
 				 GFP_KERNEL);
 	if (!mlxsw_sp->lags) {
 		err = -ENOMEM;
@@ -4340,14 +4327,9 @@ static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_lag *lag;
 	int free_lag_id = -1;
-	u16 max_lag;
-	int err, i;
+	int i;
 
-	err = mlxsw_core_max_lag(mlxsw_sp->core, &max_lag);
-	if (err)
-		return err;
-
-	for (i = 0; i < max_lag; i++) {
+	for (i = 0; i < mlxsw_sp->max_lag; i++) {
 		lag = &mlxsw_sp->lags[i];
 		if (lag->ref_count) {
 			if (lag->dev == lag_dev) {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index dd2f05a6d909..898d24232935 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -161,6 +161,7 @@ struct mlxsw_sp {
 	unsigned char base_mac[ETH_ALEN];
 	const unsigned char *mac_mask;
 	struct mlxsw_sp_lag *lags;
+	u16 max_lag;
 	struct mlxsw_sp_port_mapping *port_mapping;
 	struct mlxsw_sp_port_mapping_events port_mapping_events;
 	struct rhashtable sample_trigger_ht;
-- 
2.43.0


