Return-Path: <netdev+bounces-116104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D6C9491BE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1846F28353F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36531D2F68;
	Tue,  6 Aug 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rxOwNv7c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2491C4622
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951595; cv=fail; b=T0cu6cIW6BFLJ+mV7qF81lbYlC7zkuf9fcVI0A8JyBUvOzbqwbIsqusnheBFdJ9L4DPZWoZsIIQRuMF4aSX92LHaRWwgm/out9BJ/Cp9IZjQT+lsZlN/1oZ8bmlfuhxvHl54FBLXZ37q4bILiMr48QisW8gJ7973CpNZSBE2v7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951595; c=relaxed/simple;
	bh=wGr5qERaHR0SQ8Hz6FrTgZTQ63kINg9A5rPW0EFDprE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDGxAxOFRWy4G58zdiXLGa6nRtwsL7+5Ll02yENXhi3yFC1NwqBrBRTdKJKgKFxY7CKmRMsGn1PPc8MaYTZ1dl/zO0RJp1B9kG8m4YzCmJjerdyLwcy6jRDyZ3f19iYzH2nUcFQWpBTuXSFREhSw62F/B8XseLVdEl7iWe/U5IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rxOwNv7c; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2X5scwwWL5Zgvk1Br54F2iMvuo72vZQlBG7oCtw/phS/NPLt69c9iqtHrj90wPc7cBD/f0Km95X9CcklQfN+D63nIVcAmV+YbqhBW2AtIBbX4v2rGwJG1Ogs+5U+QxNTEBtVY/wIrJ+VEO6cvRZHyrjwU5a7HXjII5MmLV03FJ5n8mch3RsMxz31XtIUY/nyuOWjSF1QhAot94fbOT1qsembMqj7UT7xJfcBWFIpxAdA5XzyARofbXqwwbzHHatacVn6f5ew5R6/WKeVA7yh5qd5pHmM9vaQ/GhaGwfHaWryD7JfrylqgZWMcbBPfdBLc1J1QOdi9nsQg0Vlk2d5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHiiWWl99fZI0fSm8Jbh8oTKzIM48DKXCCIkvG/gFUY=;
 b=f8HvnM4AwcpQZa9QO+9gKEnugmQLOgmCQgbR6gGQTWtbqxXjSejRrh/r47FqxQzbQk+nX+nXPv4u7/TDQatHEwNp03uUFmPS8G9Y1rXp6RrDqfKeRB2ci9vOYwuxQO29TNZCFtFbiiCp71Q307IWowGHBq9VQCH/hRfQHBty6CJbW486CwDIn1RWpJ0lr3k3VPdH/MRN4oxPWhEPrbx99/m/t6ssObqEDeHhkXMv9CHdQ6TqYeeiEbAUimwXnN7uxblwlann20HaCHeW1xkVd/uTjviomH2jHPbw+CBFwy6xTvWnzDK8z6PBlMC3foJcc3JG6fobVf73sJEzcFAgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHiiWWl99fZI0fSm8Jbh8oTKzIM48DKXCCIkvG/gFUY=;
 b=rxOwNv7cUXx8OXOt7AqtL8bqvx8dxzVoUbBA8dRjeAMR/82e4XXHHjPFx0ERpLxi0KimtcLebwtu0LbddL6zqrvnYGyX4RFo0bJjKyhIoCKcQZU+jru4j0bVEAheF9UK9MbFM7svFlWc3sM8xr4lbIgCvOIG3zo7ppOgE6JTQITqd3nLBRZFC3YPEfHSP4h4Wigy0c0FjAiKOPlig12Dkjzpuey9qBDnC/GKU2Lmf9sv3bmMtKV9JCoRhwwnFfxS/+jsUF342i5DatxPu+M4M0SEkgvGC/dreqDQ4N7yUU/N2GSNCKP7C4rZ81uoqH/0jRRCZjK4WHqO8WoqeO2E6Q==
Received: from CY5PR17CA0007.namprd17.prod.outlook.com (2603:10b6:930:17::20)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Tue, 6 Aug
 2024 13:39:47 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::1d) by CY5PR17CA0007.outlook.office365.com
 (2603:10b6:930:17::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12 via Frontend
 Transport; Tue, 6 Aug 2024 13:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 13:39:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 06:00:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 06:00:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 06:00:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/11] net/mlx5e: CT: 'update' rules instead of 'replace'
Date: Tue, 6 Aug 2024 15:58:03 +0300
Message-ID: <20240806125804.2048753-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DM6PR12MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: 61188a5a-12af-4fe8-9f70-08dcb61d3cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLRknfFbmpSI5dCd8AnlXDhqojoWxaqIvhsL9VMMF7OGOKCmtzBC6pbxdF2n?=
 =?us-ascii?Q?UWL5YeC6WqpD5dCV5zUaqpjvp/1XddGR4mlN+j+Q2wfChHKYBI/d2alEY+/c?=
 =?us-ascii?Q?3m8MlsJ5MKcYDy7vG/00lAFYB4+2jZI0kxF0toNmCzbzXACQfz4x4V5YaKQX?=
 =?us-ascii?Q?+xyzlsNFiogApPO8Ue0eQhSw/1ujTCwioCDBwTQxojLyoaBWljBuKImcQZhz?=
 =?us-ascii?Q?JXaDjt4bj+nOhHHkIu74GHCgglIUwZ3bH/4VgineeqrRaljWV8gMuiXsRdQm?=
 =?us-ascii?Q?ohUP7ysuGzBNyrmg3LYo+iYK8NxmF1QNnCo6RQ+Pub9YA+yJwhqg1sKJt0wq?=
 =?us-ascii?Q?aTXNUs4o4wYv2FHAxAX/9y+u9t6dFZsE2nnMj/Y+AiJ9oIZaSLsS+A3W/Csy?=
 =?us-ascii?Q?EcsuKormcP8Zp924G/D4PMnP3v/7+Tja2x4znMByiwkXlXIUIb7zgLhfmeKY?=
 =?us-ascii?Q?PJcQrWqbVoAyHwJUlRroHjq5dGKNkggmtpgLQBIzYnt4EIcBdZxADmRe+buw?=
 =?us-ascii?Q?YRfe7imtCIwSGnRCdX2jQGE8Fdygx3Nact1PmY9bx5i7ZPTrCncofhhxIUH6?=
 =?us-ascii?Q?yN32oph+2r8wCrSKHwR57hD6FVIK8XST1o0BsSlFq3lUKa310mUaae8v+sSk?=
 =?us-ascii?Q?/McipIChE/nVcK8bC1JtzNvQ7OfYzQqFznG0kxrx8bIAS6UpDwHY8G8jskHs?=
 =?us-ascii?Q?WcGcPBW+OwzX4V/dLgYyaSjWbsWTk75KrXqwHgNN4UDzGBUf7FHXicZp8A2G?=
 =?us-ascii?Q?R1du5WB9/8PEw7skHA8HungZDlX+l1MGPjBzWNkxprWKNi9RmVhtIeUq/MrQ?=
 =?us-ascii?Q?PjX50PSRpyra9SaSa1UHUdXRuK3wMarxyedtTzSJVXrvUlP8rpYIRlh3/E5z?=
 =?us-ascii?Q?YdFW3fBR9o86MVQv31P/AUnT4LZngG1mMAJMRvF9s95uJiuR43Gl8PIDiHsM?=
 =?us-ascii?Q?J2XSfW/mwzuGtYAN1w+rUikDxDjgKkTR8AKC70juCQAl+lsw175Rhn5T/w/e?=
 =?us-ascii?Q?oSon3fHixipV/WcNDFuOu2K/fgAemOGpQBpUT6tUTkVjcx4rbnKAxHHadueU?=
 =?us-ascii?Q?l4fcMXQoHQw3FrBLpiP8B6I5t97oeCoQ3ZHbBs53GhYrnOXWngg34Uqq/VBs?=
 =?us-ascii?Q?vP4OIk77KsRTTfBbvak1Ql50CrYErwhZFSa7WdcKdVAw+TpBvbkI1anGEBYb?=
 =?us-ascii?Q?ueJspa31D6mhaxE6BJAMmsWSy7iF8k2Io7mEbQl1AtKdowy/GWnUWygnJk32?=
 =?us-ascii?Q?/I0SE4KnCa0I+yjjt3johhMbSdwDAJba+/4oIC/WivMVHQnzIAwxK/D3cUEd?=
 =?us-ascii?Q?+vRulpxUueZ/unRca3nPWWTpVna082AJobl0QLj47A0fgYFiVFf3kL6Rq5vD?=
 =?us-ascii?Q?ejH+5pwdiD574e8MC07VGaIlwglPcWwZRGZ9BJgi1fQuMJb+L9xQaoL1WD1S?=
 =?us-ascii?Q?F88zMICx0aOExq0H4TCJZsb4faEg3iJt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:39:46.9876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61188a5a-12af-4fe8-9f70-08dcb61d3cd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

From: Cosmin Ratiu <cratiu@nvidia.com>

Offloaded rules can be updated with a new modify header action
containing a changed restore cookie. This was done using the verb
'replace', while in some configurations 'update' is a better fit.

This commit renames the functions used to reflect that.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 71a168746ebe..ccee07d6ba1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -876,10 +876,10 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
-			      struct flow_rule *flow_rule,
-			      struct mlx5_ct_entry *entry,
-			      bool nat, u8 zone_restore_id)
+mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
+			     struct flow_rule *flow_rule,
+			     struct mlx5_ct_entry *entry,
+			     bool nat, u8 zone_restore_id)
 {
 	struct mlx5_ct_zone_rule *zone_rule = &entry->zone_rules[nat];
 	struct mlx5_flow_attr *attr = zone_rule->attr, *old_attr;
@@ -924,7 +924,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
 
 	kfree(old_attr);
 	kvfree(spec);
-	ct_dbg("Replaced ct entry rule in zone %d", entry->tuple.zone);
+	ct_dbg("Updated ct entry rule in zone %d", entry->tuple.zone);
 
 	return 0;
 
@@ -1141,23 +1141,23 @@ mlx5_tc_ct_entry_add_rules(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
-			       struct flow_rule *flow_rule,
-			       struct mlx5_ct_entry *entry,
-			       u8 zone_restore_id)
+mlx5_tc_ct_entry_update_rules(struct mlx5_tc_ct_priv *ct_priv,
+			      struct flow_rule *flow_rule,
+			      struct mlx5_ct_entry *entry,
+			      u8 zone_restore_id)
 {
 	int err = 0;
 
 	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
-		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
-						    zone_restore_id);
+		err = mlx5_tc_ct_entry_update_rule(ct_priv, flow_rule, entry, false,
+						   zone_restore_id);
 		if (err)
 			return err;
 	}
 
 	if (mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
-		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, true,
-						    zone_restore_id);
+		err = mlx5_tc_ct_entry_update_rule(ct_priv, flow_rule, entry, true,
+						   zone_restore_id);
 		if (err && mlx5_tc_ct_entry_in_ct_table(entry))
 			mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
 	}
@@ -1165,13 +1165,13 @@ mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_block_flow_offload_replace(struct mlx5_ct_ft *ft, struct flow_rule *flow_rule,
-				      struct mlx5_ct_entry *entry, unsigned long cookie)
+mlx5_tc_ct_block_flow_offload_update(struct mlx5_ct_ft *ft, struct flow_rule *flow_rule,
+				     struct mlx5_ct_entry *entry, unsigned long cookie)
 {
 	struct mlx5_tc_ct_priv *ct_priv = ft->ct_priv;
 	int err;
 
-	err = mlx5_tc_ct_entry_replace_rules(ct_priv, flow_rule, entry, ft->zone_restore_id);
+	err = mlx5_tc_ct_entry_update_rules(ct_priv, flow_rule, entry, ft->zone_restore_id);
 	if (!err)
 		return 0;
 
@@ -1216,7 +1216,7 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 		entry->restore_cookie = meta_action->ct_metadata.cookie;
 		spin_unlock_bh(&ct_priv->ht_lock);
 
-		err = mlx5_tc_ct_block_flow_offload_replace(ft, flow_rule, entry, cookie);
+		err = mlx5_tc_ct_block_flow_offload_update(ft, flow_rule, entry, cookie);
 		mlx5_tc_ct_entry_put(entry);
 		return err;
 	}
-- 
2.44.0


