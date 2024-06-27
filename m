Return-Path: <netdev+bounces-107416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3473791AEBD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C6EB253F4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026DE19AD51;
	Thu, 27 Jun 2024 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GxgOo8qO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AB19AD85
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719511485; cv=fail; b=om0Kow6GXZ2MQUZTiE4VNW0yJoWC6mFuuqhadxOmrUucGYwRz1GYiUbbjwnEbk+PSBbhHe4vlqB0FcHFk5lm0pvCYY70uI+gZ6i0XmDU9Rp7/szARqwV+u0mwl1KaTtIurxffhlrfAEIVsOlZLIza/zdtG14ncapb9mwUqTV8VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719511485; c=relaxed/simple;
	bh=bbUCNyhKq1US3nBNaav+KH2oGEng3LGKP7axh2rI8dU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=En9YuXP1gcJA+y8IHssfrjDqn5DojGv/wPXd7sfZqhjdinVUddXRSjODnhNbT743Pv5mw7zRig1foUWC9gL+j7RSCRHq27BYbY2xNAlofk122CdN0YNQc2ko6oyNde+AYXrSRMVP/iSJHtEC2trtz50TDQFAptfYJjKGQduLwuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GxgOo8qO; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpobdIIAnAWZPc1fvKyf3TbVTZEu7sULIG5KdwzO9x8DKvbrQ4qV1mdR01Vpr7psceefFkZV/wHZmQ9kfzmXFkEIclDozLzBxR5gxjI0q+svkRZVvJ/VypX4yA96Rtr4rhO2ECDUroaIYTxbu/JAGY0h+acjcDfutpQfMH5r+pFm8SHpjYXGf/ftuMKnUOq+kgAb+aNqzTmzQYRbfUmeylqztaws5f2UxcJ5F616GxsJ+DI/La7ImRcfLCayYHsM1/wBAcsP5YEjF9h97OWd6o/W5tzUEhNnE716AWjVH36fCmq96PVIFGUkOrMeC6TOjxXkTfVgXvDcdOYSlRgn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFDSqEMIPZuVmW1lYWdYlECURavG8XQ62yyZiPqaOMU=;
 b=A17oBGwcPMrDqQnYPL87YEdZMvBSwgfl2+XoA2z+5tjhx0Sce5viWpuMEdVrKwMusyGATHvTOb42x9Nf6bORtrNd++Wso0XviVgFY3CZjLXk3a7jw372i9XTVJeE8gP844rTsPfHywUqy3Q0qd6lztIl07cdg5g2KRThFBa8gzbAW7tl9TWFUlHIiHUyEjjcWV5QP12bIHb5BWlSaTkH/Pwp6B/QxrGA6kZ4p/+1jB8YjpQtTIc8T7Qf2B9kBbKDRJ+PnDKlOY6bViFPBlkKMh11Tk6JbaykFrviOyj8weIXmvNqi/fB65FHIL2QKh+oJRDK/LOSjExgrWFiwtzT5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFDSqEMIPZuVmW1lYWdYlECURavG8XQ62yyZiPqaOMU=;
 b=GxgOo8qOac6DiVaOgBXzNwhtbvolr0IwmsRdilkmmTi7YWBlNqQMpN6mzkXhvWctPnicC2hNAXyRZQZ9BcxpCV7+VlBOeiQmN5C6XSpi3flVwOgpVjcesvwwOPvpGY5EVgvqA6sytHLFQSRgG7/YOCJ0as+0bLPKEn+e5lbrKqTS5ITmKMuu8TX0iYyQZWTZy7WnqMdanQjwd/n/woY0raD1U5qbh3a/J6EOrtmsWcCCF/sPhQUMIiuvQ35v5K7tnMkxfvhGx88yG02A5N7gJSFq8bhrAGD4Qw1pxR/clDim80ZDeCh2J6+6ihuo5hq4hD9o0v3UmboRpUSi4+yn5Q==
Received: from PH7P220CA0109.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::11)
 by PH0PR12MB8799.namprd12.prod.outlook.com (2603:10b6:510:28e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:04:36 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:32d:cafe::68) by PH7P220CA0109.outlook.office365.com
 (2603:10b6:510:32d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 18:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 18:04:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 11:04:03 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 11:04:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Jun 2024 11:04:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 4/7] net/mlx5: E-switch, Create ingress ACL when needed
Date: Thu, 27 Jun 2024 21:02:37 +0300
Message-ID: <20240627180240.1224975-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240627180240.1224975-1-tariqt@nvidia.com>
References: <20240627180240.1224975-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH0PR12MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7438be-1a6a-4961-5fe5-08dc96d39aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1AbVOMFPaQ7ZG8qCFTkpjbpqZAPuI//b8tlydgGQPXs1BWZXa1WQCdVqsiBG?=
 =?us-ascii?Q?fqsM4YueirHWhbnsuc5okcu2v9Wvhs7Cq5uRoKRFYqXZ3GBeu1iLfLUJckbX?=
 =?us-ascii?Q?aAIPCV/F4l4ZGgc1+anrGYETryb8WYqZmNjksNnH3qEpqptgPoJOT0sFhljJ?=
 =?us-ascii?Q?ZNpTyvKLjSTuM7D+WMaenOZWYAMU9ZBChReLqCUwHloTHoi9cuYtg5XtTgri?=
 =?us-ascii?Q?qq2wI0cwmC7ZBQHmj5GMTX6x2XR09vQc1X8J2VxQsEJl2fyrNvcc4HUET75/?=
 =?us-ascii?Q?tVezSSRrGYpaJ/3gAxgWJLG2gzD4tghCkCUhzGbF1GlPgufHrX7Vqu3JOzHQ?=
 =?us-ascii?Q?GJNr6zrS1+3NwVsABEmaeMB397gyWT1PyU4ZPfUoaU5ni/h6cfVlAEkCRKFw?=
 =?us-ascii?Q?gzmM6r+nt8mYKQ8Z+2nVJFOD+8DXDRACmFzm1EYAgr+2X9yP312yK0vGIJne?=
 =?us-ascii?Q?dlj0CjYhv9r4MFaGr+7qOU/FVA7F1VpbnP20H5W+yTUSul4MkDOe+j3ltOwl?=
 =?us-ascii?Q?zyDAtzus1yxEP26eXHGCJ5rOcxTfxjvmFTGroROFazWN8HnXhKrL7/tg9+35?=
 =?us-ascii?Q?BKUBR/FgDqtHpdAwSDfs5E3A808PrgrrSrow0ILB4JKn3hRzaLnuF578fd3R?=
 =?us-ascii?Q?vsQD8TP6tcn4i4C9GZ5wa1wWgk8lpNFhSgiyg3QOTMS4UxSK53gpCdGQe1jv?=
 =?us-ascii?Q?9upjB+SErjIEYInbYbktICvAB3p4JrkjW4JKfFDMVZJJ0c5G2T+1P8OKUC2A?=
 =?us-ascii?Q?mzApYT0G1Ss4ndm2NAslF46CzO33xqFVDfJA/Rt79MuZdlS2Qec6/kpdaQv2?=
 =?us-ascii?Q?u6ieKq2FLGohTAnDT7/BBPdbqEqmbI09UsqaQGi+ZcXghGNSj5OcwLtUw88a?=
 =?us-ascii?Q?G0uGBvolbCX5guSegbRybv6XTm4p/QIDEc3jmYGDGfIuhQ5vLn9dj6eLFcGo?=
 =?us-ascii?Q?kckm/Sy5uvVz9Wwi/m6WYWJ906fOLMc2N8hZcEpE5QJPGEq3J4WpSiHG+BqK?=
 =?us-ascii?Q?ll2evIYygCFLBoqaAqklq8zYPMqTrdlNyxfdzsiVfTI6LiwnmQGnCPHEAxXV?=
 =?us-ascii?Q?f8yvZlCBdodqQAji7K7S8Tn0OybtdZ1QwrJM9QQYbr5QSfXHHCh7qQiPd/Zd?=
 =?us-ascii?Q?Nvg20fsJNu6Fe8WMJnjL1sUjW3hF0PIYkgYerVs3JcZWpnoX97OcabLm/EJT?=
 =?us-ascii?Q?ZAbPTUaYu9oMPmneZxCZN2qwPerN8Mf4gj6SmHWy1/51+zjp7V9IGZXbMmIw?=
 =?us-ascii?Q?nRNL62Iyn8KSW7uVXpuG4CRvgBCd1bCEuzNjQKqDdKtWUZyMcuNTuuNy0H9i?=
 =?us-ascii?Q?0Y4KeoOuJVLKEdbtk5d7TFem26hWFPnFvWd8f9Uaiuwd0YMcluFX0k6GatXg?=
 =?us-ascii?Q?2j9PIspQMdvkM2/7xH+WWA/ZGDnGghKX+RvbNVYXC3cTimI2jJW/Wr3+OEpg?=
 =?us-ascii?Q?uW2rk5FoSLw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:04:35.6220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7438be-1a6a-4961-5fe5-08dc96d39aba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8799

From: Chris Mi <cmi@nvidia.com>

Currently, ingress acl is used for three features. It is created only
when vport metadata match and prio tag are enabled. But active-backup
lag mode also uses it. It is independent of vport metadata match and
prio tag. And vport metadata match can be disabled using the
following devlink command:

 # devlink dev param set pci/0000:08:00.0 name esw_port_metadata \
	value false cmode runtime

If ingress acl is not created, will hit panic when creating drop rule
for active-backup lag mode. If always create it, there will be about
5% performance degradation.

Fix it by creating ingress acl when needed. If esw_port_metadata is
true, ingress acl exists, then create drop rule using existing
ingress acl. If esw_port_metadata is false, create ingress acl and
then create drop rule.

Fixes: 1749c4c51c16 ("net/mlx5: E-switch, add drop rule support to ingress ACL")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/esw/acl/ingress_ofld.c | 37 +++++++++++++++----
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
index 50d2ea323979..a436ce895e45 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/ingress_ofld.c
@@ -6,6 +6,9 @@
 #include "helper.h"
 #include "ofld.h"
 
+static int
+acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport);
+
 static bool
 esw_acl_ingress_prio_tag_enabled(struct mlx5_eswitch *esw,
 				 const struct mlx5_vport *vport)
@@ -123,18 +126,31 @@ static int esw_acl_ingress_src_port_drop_create(struct mlx5_eswitch *esw,
 {
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *flow_rule;
+	bool created = false;
 	int err = 0;
 
+	if (!vport->ingress.acl) {
+		err = acl_ingress_ofld_setup(esw, vport);
+		if (err)
+			return err;
+		created = true;
+	}
+
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP;
 	flow_act.fg = vport->ingress.offloads.drop_grp;
 	flow_rule = mlx5_add_flow_rules(vport->ingress.acl, NULL, &flow_act, NULL, 0);
 	if (IS_ERR(flow_rule)) {
 		err = PTR_ERR(flow_rule);
-		goto out;
+		goto err_out;
 	}
 
 	vport->ingress.offloads.drop_rule = flow_rule;
-out:
+
+	return 0;
+err_out:
+	/* Only destroy ingress acl created in this function. */
+	if (created)
+		esw_acl_ingress_ofld_cleanup(esw, vport);
 	return err;
 }
 
@@ -299,16 +315,12 @@ static void esw_acl_ingress_ofld_groups_destroy(struct mlx5_vport *vport)
 	}
 }
 
-int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw,
-			       struct mlx5_vport *vport)
+static int
+acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	int num_ftes = 0;
 	int err;
 
-	if (!mlx5_eswitch_vport_match_metadata_enabled(esw) &&
-	    !esw_acl_ingress_prio_tag_enabled(esw, vport))
-		return 0;
-
 	esw_acl_ingress_allow_rule_destroy(vport);
 
 	if (mlx5_eswitch_vport_match_metadata_enabled(esw))
@@ -347,6 +359,15 @@ int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw,
 	return err;
 }
 
+int esw_acl_ingress_ofld_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
+{
+	if (!mlx5_eswitch_vport_match_metadata_enabled(esw) &&
+	    !esw_acl_ingress_prio_tag_enabled(esw, vport))
+		return 0;
+
+	return acl_ingress_ofld_setup(esw, vport);
+}
+
 void esw_acl_ingress_ofld_cleanup(struct mlx5_eswitch *esw,
 				  struct mlx5_vport *vport)
 {
-- 
2.31.1


