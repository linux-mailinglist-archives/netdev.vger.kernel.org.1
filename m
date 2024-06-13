Return-Path: <netdev+bounces-103394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0364F907DC4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D011C228E1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1097B13B58A;
	Thu, 13 Jun 2024 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qnDORUeC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DB5E093
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312543; cv=fail; b=WM8vIcAsHluYW1QiNGRGmXHsxq5+v3dce31hl7oHUoLFgq1Aj26Tgm/7/AsXm42VS3zgtsVKv9vDc7WVeW8RAy5Waax6tf3tZdDPVRiczlkh4WHO76LFc5oJ71D+SoH1JZP+aAXSAXQcCyVMf043Wf5nClyF/K209zxMh69fziU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312543; c=relaxed/simple;
	bh=TiF/gjtgKjyBqmLKy4PRlnZ78GNOKrv2FfswD3SqFAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruOps3X/ajxy9vYJ4rDIK/ak3x5y/jWx63HbrfzZwxycuk9+/rh2sgrQoOg8EYq3pQDHqZA94W0/Vmjo6euIsv1zlX6j9GlqIMr6zikP0wKhgLzEGS2UnuO6UozeMn5G7RWpNDt0v92FRjEiNeAWG233qXyvYwJbDdps1Da0VFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qnDORUeC; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJly97bUayn8uC2kw6EpzwV1u/jEm3TUB75Hczoh+l6HNLDNv7q4FhKaRcg+G73YapOqCKRth/qkEqPTvznbxfQ0NBKza2qL8PX0O56h+6NCUTuwjfAYwDD6quxNX2Lp0FcG0uYpwg8+PNeMYK9N3aJ+h66PUXyqgeifCimQEswf6va/FN/exQzBXL/36U0c7MmvXC29FtSxEEZZBdWMm+DDxxpdnDVaoQ6Tl4M+kRB6gYfahlWfKoL9YfaxZjSq/7OcNcMQqJSN3OcXu04YSqTe1xiaJwOXzkIJe8EP1FrEZk5OILbYMGqOsGYeAZhCq5+J0qPkLp19vpvkjn1FLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teWzMc0qWcU2kinjkwqfP3+pnAv569grdtZRuLjHxJE=;
 b=cJR026FHqQbDKcWGiubz1ZE12f7uxcYX2sPUkzbtbDAuzvrnHZUiseK2j8eTQrQsFIiiPVY5IIYxwseBMWkr/+14JDp9vpJigkj/+HybubxR0cocuYIprSZYz5PNwh1yJvjH+UrDRYrjs73w1N6hnE9SEphAd8B46GnvMIRqjFRtFdUnsRtw7md6OiExiYLknWmjroyFcXEYxt5o7celgi0exW2jdHmOIxJmyn+sJE3l0vTkhxahqBShQWIe0UQSEQX4sQdmQD3oSYlYYwBIhgrpZIaStvIJ/YY+ELetOVMxjz30hW+wMgAMUllNEq4SAmRWQUv9mJLBZbJRCFBgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=teWzMc0qWcU2kinjkwqfP3+pnAv569grdtZRuLjHxJE=;
 b=qnDORUeCk0xgypXShVA+6d9hk5ZBkt466lGuiWIkGltMcaL3XBai4IYYGGZq1rw6TKB+WEhVFnaOdD3nQi1prCHmdQCbVZqt2iYQoAhZYxlDapYlWM4RSBITpg+NWv/1vf9xR4U3E50mSsVKwIhkOsTif7Z0xZpLU8p609yBP0AMVJe/TNt6zmvxMbKZa0Ew6W1sGa/35tMMI5WHylWQpTHZu4S6csEFotIBqQiH+5cCV1U+MmiASSchz5i/WaMN+NmCWIkkKBSU1747cZBy1OH56e+1aftkvMdN2PUAX9tjs66Mw45TNYDpT10phvehRQi5/CVUmq+esBJsQXdruw==
Received: from CYXPR03CA0094.namprd03.prod.outlook.com (2603:10b6:930:d3::16)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 21:02:16 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:d3:cafe::99) by CYXPR03CA0094.outlook.office365.com
 (2603:10b6:930:d3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Paul Blakey <paulb@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 2/6] net/mlx5: CT: Separate CT and CT-NAT tuple entries
Date: Fri, 14 Jun 2024 00:00:32 +0300
Message-ID: <20240613210036.1125203-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 325efb5f-6bee-42e5-13e6-08dc8bec1ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?88R4Dn0CMoErKEUAoSjxnp7Uus3hEZ2uyJTo7cXdghaOvD82MtU8x+/A0myk?=
 =?us-ascii?Q?PQm5ENzH1uXGL2cq39Wx2jXKs6j00BOgv0C6qIa5yXxabji1Dfxu5Vwgkhs/?=
 =?us-ascii?Q?KDxCkRHu5PRH1FuOObMjIZMT2y3bJcTdtph8hcfVsuhFX1AqssM6hZ6BxmzG?=
 =?us-ascii?Q?S8lnF7bmx4wZ52Je/LMJYGfe1I5vraa3vCqymqwuc3D/PC5X/cDlaXS0hj1e?=
 =?us-ascii?Q?Jyd53fT7Y9Fd47eB4GlUiJsPQAFJlj4MIsoO0j77ZuZy0gRsdxc6ZVvJEn13?=
 =?us-ascii?Q?oklF/r5866XqxxQPXxb69QRnkH1j6b4AF8QLQv0UDBorYCaGdlh63fBYf43D?=
 =?us-ascii?Q?yFomiKQ/0RRP7DgrgIlfjd5VSbD5V6YORRbn4paqMmA/IyTyaNwH++8zfZVW?=
 =?us-ascii?Q?fLero/zER+LKuQoupWDIY6jXPsbkpFZEgQzEIzF+RJWlx66jZMehh2NWQZoQ?=
 =?us-ascii?Q?4hvr+VZ5QY5lcOYJNEwLDORMeZg9uOHC17GHP2SL9GRV3PEXWECV4m6rz8Q8?=
 =?us-ascii?Q?HmkPdYxF0bBCyxGPEiFEQQIfczvdt4dJeWuCSoSOg4dT++DpZ+oGaNfJKD7E?=
 =?us-ascii?Q?Xj2seGkd7p0UMoQt+wlvCIDjjImWhvkhl3nr+3ypTZ8EkxnOuoyFJ55gGLSN?=
 =?us-ascii?Q?s2kxwmrqjMugP8vC8jh4kfq9MBZJQyrvbfp3bgOLqqKLyQ/9RhISqHOeWFB+?=
 =?us-ascii?Q?zpyEq8dU5rLJMVoObPYsEaMtHJZx/PNJTsn22qjv8/nHwLNizl3w6YM//iC5?=
 =?us-ascii?Q?A5/zSB3ehPER6JbFjlSluWY+teKneq9JwyJ/svO2axKZtItJFe1cr8Q+/ADz?=
 =?us-ascii?Q?sKQi/33MfvRBwMgVjU1sVQeHB+MyUpCmaz3JYLv+nUr0obBFMop605hzm6yX?=
 =?us-ascii?Q?cU7OIVWjpMsjuhct2e+ovu9IOkO+oSdwYPiZ5qvwFVJiiHNPvUP27jA1fXmV?=
 =?us-ascii?Q?5/dAEVrxE1XF17DmCMUhUX73NNgiqFUjq2G2wu9IFplKDwk2BjX7FnQItlCb?=
 =?us-ascii?Q?MMQmrSfC9tuXABBIMxFxvtN+7GtHqkwRBsaEWGgCqNbmFEbZQQD8SGK8IGXq?=
 =?us-ascii?Q?YQtLnQYDMOFnw1DpNrVtZyEOdeQsXfdXnzBS+M6oCJ65qIR07JGMV+Uqib7k?=
 =?us-ascii?Q?A8gl7gt0hqIYHnst9D40plpT1Ftu9Vp2RF3qHOMQn2pjs2c3PQhky4Dwg6qR?=
 =?us-ascii?Q?RZfOaAxFrHfzmErYX42lgGjVNGNWl6y0TWMjyu7iH5+XOLDkrRQbUn0NMlcB?=
 =?us-ascii?Q?bj+RV7WJL5c1nIc4yeaigP2gvRGp1h3+RXEkutQ+yERPp2FYpQVME8JZihtD?=
 =?us-ascii?Q?ybbfBd1kTszy8cqrIaO0pGCF8bMIys4j1Ax59J3yb3fvaj2IhfH7T+dqdrdl?=
 =?us-ascii?Q?zcA0mutphXvg56zKwkb7zoXVJMMGawqcNQJoMSHX/75wZCssCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:15.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 325efb5f-6bee-42e5-13e6-08dc8bec1ae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

From: Chris Mi <cmi@nvidia.com>

Currently a ct entry is stored in both ct and ct-nat tables. ct
action is directed to the ct table, while ct nat action is directed
to the nat table. ct-nat entries perform the nat header rewrites,
if required. The current design assures that a ct action will match
in hardware even if the tuple has nat configured, it will just not
execute it. However, storing each connection in two tables increases
the system's memory consumption while reducing its insertion rate.

Offload a connection to either ct or the ct-nat table. Add a miss
fall-through rule from ct-nat table to the ct table allowing ct(nat)
action on non-natted connections.

ct action on natted connections, by default, will be handled by the
software miss path.

Signed-off-by: Paul Blakey <paulb@nvidia.com>
Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 187 +++++++++++++-----
 1 file changed, 143 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index fadfa8b50beb..b49d87a51f21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -69,6 +69,8 @@ struct mlx5_tc_ct_priv {
 	struct rhashtable ct_tuples_nat_ht;
 	struct mlx5_flow_table *ct;
 	struct mlx5_flow_table *ct_nat;
+	struct mlx5_flow_group *ct_nat_miss_group;
+	struct mlx5_flow_handle *ct_nat_miss_rule;
 	struct mlx5e_post_act *post_act;
 	struct mutex control_lock; /* guards parallel adds/dels */
 	struct mapping_ctx *zone_mapping;
@@ -141,6 +143,8 @@ struct mlx5_ct_counter {
 
 enum {
 	MLX5_CT_ENTRY_FLAG_VALID,
+	MLX5_CT_ENTRY_IN_CT_TABLE,
+	MLX5_CT_ENTRY_IN_CT_NAT_TABLE,
 };
 
 struct mlx5_ct_entry {
@@ -198,9 +202,15 @@ static const struct rhashtable_params tuples_nat_ht_params = {
 };
 
 static bool
-mlx5_tc_ct_entry_has_nat(struct mlx5_ct_entry *entry)
+mlx5_tc_ct_entry_in_ct_table(struct mlx5_ct_entry *entry)
 {
-	return !!(entry->tuple_nat_node.next);
+	return test_bit(MLX5_CT_ENTRY_IN_CT_TABLE, &entry->flags);
+}
+
+static bool
+mlx5_tc_ct_entry_in_ct_nat_table(struct mlx5_ct_entry *entry)
+{
+	return test_bit(MLX5_CT_ENTRY_IN_CT_NAT_TABLE, &entry->flags);
 }
 
 static int
@@ -526,8 +536,10 @@ static void
 mlx5_tc_ct_entry_del_rules(struct mlx5_tc_ct_priv *ct_priv,
 			   struct mlx5_ct_entry *entry)
 {
-	mlx5_tc_ct_entry_del_rule(ct_priv, entry, true);
-	mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
+	if (mlx5_tc_ct_entry_in_ct_nat_table(entry))
+		mlx5_tc_ct_entry_del_rule(ct_priv, entry, true);
+	if (mlx5_tc_ct_entry_in_ct_table(entry))
+		mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
 
 	atomic_dec(&ct_priv->debugfs.stats.offloaded);
 }
@@ -814,7 +826,7 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 					      &zone_rule->mh,
 					      zone_restore_id,
 					      nat,
-					      mlx5_tc_ct_entry_has_nat(entry));
+					      mlx5_tc_ct_entry_in_ct_nat_table(entry));
 	if (err) {
 		ct_dbg("Failed to create ct entry mod hdr");
 		goto err_mod_hdr;
@@ -888,7 +900,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
 	*old_attr = *attr;
 
 	err = mlx5_tc_ct_entry_create_mod_hdr(ct_priv, attr, flow_rule, &mh, zone_restore_id,
-					      nat, mlx5_tc_ct_entry_has_nat(entry));
+					      nat, mlx5_tc_ct_entry_in_ct_nat_table(entry));
 	if (err) {
 		ct_dbg("Failed to create ct entry mod hdr");
 		goto err_mod_hdr;
@@ -957,11 +969,13 @@ static void mlx5_tc_ct_entry_remove_from_tuples(struct mlx5_ct_entry *entry)
 {
 	struct mlx5_tc_ct_priv *ct_priv = entry->ct_priv;
 
-	rhashtable_remove_fast(&ct_priv->ct_tuples_nat_ht,
-			       &entry->tuple_nat_node,
-			       tuples_nat_ht_params);
-	rhashtable_remove_fast(&ct_priv->ct_tuples_ht, &entry->tuple_node,
-			       tuples_ht_params);
+	if (mlx5_tc_ct_entry_in_ct_nat_table(entry))
+		rhashtable_remove_fast(&ct_priv->ct_tuples_nat_ht,
+				       &entry->tuple_nat_node,
+				       tuples_nat_ht_params);
+	if (mlx5_tc_ct_entry_in_ct_table(entry))
+		rhashtable_remove_fast(&ct_priv->ct_tuples_ht, &entry->tuple_node,
+				       tuples_ht_params);
 }
 
 static void mlx5_tc_ct_entry_del(struct mlx5_ct_entry *entry)
@@ -1100,21 +1114,26 @@ mlx5_tc_ct_entry_add_rules(struct mlx5_tc_ct_priv *ct_priv,
 		return err;
 	}
 
-	err = mlx5_tc_ct_entry_add_rule(ct_priv, flow_rule, entry, false,
-					zone_restore_id);
-	if (err)
-		goto err_orig;
+	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
+		err = mlx5_tc_ct_entry_add_rule(ct_priv, flow_rule, entry, false,
+						zone_restore_id);
+		if (err)
+			goto err_orig;
+	}
 
-	err = mlx5_tc_ct_entry_add_rule(ct_priv, flow_rule, entry, true,
-					zone_restore_id);
-	if (err)
-		goto err_nat;
+	if (mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
+		err = mlx5_tc_ct_entry_add_rule(ct_priv, flow_rule, entry, true,
+						zone_restore_id);
+		if (err)
+			goto err_nat;
+	}
 
 	atomic_inc(&ct_priv->debugfs.stats.offloaded);
 	return 0;
 
 err_nat:
-	mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
+	if (mlx5_tc_ct_entry_in_ct_table(entry))
+		mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
 err_orig:
 	mlx5_tc_ct_counter_put(ct_priv, entry);
 	return err;
@@ -1128,15 +1147,19 @@ mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
 {
 	int err;
 
-	err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
-					    zone_restore_id);
-	if (err)
-		return err;
+	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
+		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
+						    zone_restore_id);
+		if (err)
+			return err;
+	}
 
-	err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, true,
-					    zone_restore_id);
-	if (err)
-		mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
+	if (mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
+		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, true,
+						    zone_restore_id);
+		if (err && mlx5_tc_ct_entry_in_ct_table(entry))
+			mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
+	}
 	return err;
 }
 
@@ -1224,18 +1247,24 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 	if (err)
 		goto err_entries;
 
-	err = rhashtable_lookup_insert_fast(&ct_priv->ct_tuples_ht,
-					    &entry->tuple_node,
-					    tuples_ht_params);
-	if (err)
-		goto err_tuple;
-
 	if (memcmp(&entry->tuple, &entry->tuple_nat, sizeof(entry->tuple))) {
 		err = rhashtable_lookup_insert_fast(&ct_priv->ct_tuples_nat_ht,
 						    &entry->tuple_nat_node,
 						    tuples_nat_ht_params);
 		if (err)
 			goto err_tuple_nat;
+
+		set_bit(MLX5_CT_ENTRY_IN_CT_NAT_TABLE, &entry->flags);
+	}
+
+	if (!mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
+		err = rhashtable_lookup_insert_fast(&ct_priv->ct_tuples_ht,
+						    &entry->tuple_node,
+						    tuples_ht_params);
+		if (err)
+			goto err_tuple;
+
+		set_bit(MLX5_CT_ENTRY_IN_CT_TABLE, &entry->flags);
 	}
 	spin_unlock_bh(&ct_priv->ht_lock);
 
@@ -1251,17 +1280,10 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 
 err_rules:
 	spin_lock_bh(&ct_priv->ht_lock);
-	if (mlx5_tc_ct_entry_has_nat(entry))
-		rhashtable_remove_fast(&ct_priv->ct_tuples_nat_ht,
-				       &entry->tuple_nat_node, tuples_nat_ht_params);
-err_tuple_nat:
-	rhashtable_remove_fast(&ct_priv->ct_tuples_ht,
-			       &entry->tuple_node,
-			       tuples_ht_params);
 err_tuple:
-	rhashtable_remove_fast(&ft->ct_entries_ht,
-			       &entry->node,
-			       cts_ht_params);
+	mlx5_tc_ct_entry_remove_from_tuples(entry);
+err_tuple_nat:
+	rhashtable_remove_fast(&ft->ct_entries_ht, &entry->node, cts_ht_params);
 err_entries:
 	spin_unlock_bh(&ct_priv->ht_lock);
 err_set:
@@ -2149,6 +2171,76 @@ mlx5_ct_tc_remove_dbgfs(struct mlx5_tc_ct_priv *ct_priv)
 	debugfs_remove_recursive(ct_priv->debugfs.root);
 }
 
+static struct mlx5_flow_handle *
+tc_ct_add_miss_rule(struct mlx5_flow_table *ft,
+		    struct mlx5_flow_table *next_ft)
+{
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act act = {};
+
+	act.flags  = FLOW_ACT_IGNORE_FLOW_LEVEL | FLOW_ACT_NO_APPEND;
+	act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	dest.type  = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest.ft = next_ft;
+
+	return mlx5_add_flow_rules(ft, NULL, &act, &dest, 1);
+}
+
+static int
+tc_ct_add_ct_table_miss_rule(struct mlx5_flow_table *from,
+			     struct mlx5_flow_table *to,
+			     struct mlx5_flow_group **miss_group,
+			     struct mlx5_flow_handle **miss_rule)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_group *group;
+	struct mlx5_flow_handle *rule;
+	unsigned int max_fte = from->max_fte;
+	u32 *flow_group_in;
+	int err = 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	if (!flow_group_in)
+		return -ENOMEM;
+
+	/* create miss group */
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index,
+		 max_fte - 2);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index,
+		 max_fte - 1);
+	group = mlx5_create_flow_group(from, flow_group_in);
+	if (IS_ERR(group)) {
+		err = PTR_ERR(group);
+		goto err_miss_grp;
+	}
+
+	/* add miss rule to next fdb */
+	rule = tc_ct_add_miss_rule(from, to);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		goto err_miss_rule;
+	}
+
+	*miss_group = group;
+	*miss_rule = rule;
+	kvfree(flow_group_in);
+	return 0;
+
+err_miss_rule:
+	mlx5_destroy_flow_group(group);
+err_miss_grp:
+	kvfree(flow_group_in);
+	return err;
+}
+
+static void
+tc_ct_del_ct_table_miss_rule(struct mlx5_flow_group *miss_group,
+			     struct mlx5_flow_handle *miss_rule)
+{
+	mlx5_del_flow_rules(miss_rule);
+	mlx5_destroy_flow_group(miss_group);
+}
+
 #define INIT_ERR_PREFIX "tc ct offload init failed"
 
 struct mlx5_tc_ct_priv *
@@ -2212,6 +2304,12 @@ mlx5_tc_ct_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 		goto err_ct_nat_tbl;
 	}
 
+	err = tc_ct_add_ct_table_miss_rule(ct_priv->ct_nat, ct_priv->ct,
+					   &ct_priv->ct_nat_miss_group,
+					   &ct_priv->ct_nat_miss_rule);
+	if (err)
+		goto err_ct_zone_ht;
+
 	ct_priv->post_act = post_act;
 	mutex_init(&ct_priv->control_lock);
 	if (rhashtable_init(&ct_priv->zone_ht, &zone_params))
@@ -2273,6 +2371,7 @@ mlx5_tc_ct_clean(struct mlx5_tc_ct_priv *ct_priv)
 	ct_priv->fs_ops->destroy(ct_priv->fs);
 	kfree(ct_priv->fs);
 
+	tc_ct_del_ct_table_miss_rule(ct_priv->ct_nat_miss_group, ct_priv->ct_nat_miss_rule);
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct_nat);
 	mlx5_chains_destroy_global_table(chains, ct_priv->ct);
 	mapping_destroy(ct_priv->zone_mapping);
-- 
2.44.0


