Return-Path: <netdev+bounces-51734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5D7FBE80
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9128B218AA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E791E4AE;
	Tue, 28 Nov 2023 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dhJiRGSr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5D312A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GtNDAw62ZuuOz9iv+7X4E7vb49TeaZIGKhk7DaflOk5LExeOUlB7jpaU1wZZXU07Y96gN3mWlaUrIbbbeCL7F6Br2BvBGyVW+5KHf0v6/0/ovvzJZJ8GzALYHJs0HQQKxvm5W2jOgnVvi60hmupsgP+BwOhjkPODwy3Dnva3kiIYRqpgYwq7TacXJL+4VtqSFjQxVINqC9fbpEDNnAehxIE9tFBl3eTerzdeDvvDsh//YTx0kqGgMp0Uzp6wyOrY3oDh+Vc1d9eIZO89xUn37Ao6iJyKGTExIolkqflVvAZKKBmzML/O3aQxVbLliTabHUNrBih/r4t/7VO8QHEabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxXWLy4L+EXY3TYNab8g5LYN0Gh01RRzFyxMvos1RvU=;
 b=gcOGwJ3wU9mjwnLR4S44yLwX8tm/67J+lHTYAlshushdSCEpC1EeLNonc+LDTs7i1fLapdyR02EoL9O4foKhNimEkKS8HOmGcbcW1bbM1GNE8Jd4B//WETXdKoMEzAF1pGwpSSOyMgkJUll6AsJbrQBIvzc8k8ge1D8SoqgItDnfeBewxIq7yYiXVZIWR76O7t+TZb0AY7kXyEay6OTIQA9mvYobYtyKQ/N7XHmIDdex+xV/U1aAqN/nGkD3Ie5q3UPdxk9miURi8kpSJ13ftubTUc7//G+4Os3dzgAB/RYkH7BmTgQY9Sfvup5gsGJuhVLO7frZyg/pRpmeEdDnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxXWLy4L+EXY3TYNab8g5LYN0Gh01RRzFyxMvos1RvU=;
 b=dhJiRGSrWZ5K922jDz5zfcGue0wM+14XnxFuA9WcrTN4z3bv6o+CLSkM+jfCMTd+jDEFpl3HiMhb8OxKuPC7W8RcjFVa0NMKnxAFUG5chMA0+NmFb6s6amfiJtDT4t4IkHlkbcOR/ULthQmoE7RjruBpSpI7AYY0hnK8oPYYGTdDSKaGxehzBU4IxVYdQJ0To7M6RsQSchyDkUUNDDbIOF3uOosEZ6ewdeOaBRhAtv6pwx6ngHv7JZUD46aUNRKAukItFn17jwsKYOaa0PDZtuSGM8noNHyDn6MYyIINVld4wehVS0cbvMnW2CTxrwk+DPENRSogU/Gsz16zBnvpRg==
Received: from CYXPR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:cf::24)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:51:17 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::23) by CYXPR02CA0013.outlook.office365.com
 (2603:10b6:930:cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:10 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:07 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/17] mlxsw: spectrum_fid: Privatize FID families
Date: Tue, 28 Nov 2023 16:50:34 +0100
Message-ID: <d3fa390d97cf3dbd2f7a28741be69b311e2059e4.1701183891.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e8e55d-de52-4c93-dd21-08dbf029dbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MWZn8qDxuDV1mvnXThsfsMcJpfntADlzie1v+QVsWS4SrT10q1WlOnjFOA/+0FtibvXVczd2HtbHqOlLLwDAnkwSZkgCNru/6BMNZx7ax1wPqUfTk7Hcaggfmh16LItKD00+J52go3Kz+6qDR6CcSRKGSO/ciyRuorDT76tUeBpEKEIgI+U5VWteSMKq6JAmnMmX8Hcmy7vuTcnPaErEZM56/9XFMGOpvJCWweGot+E33a/ZKAZ2jMEUcSgfaHh33yULWT1LXzzsp8mb7Xyo62BDbES2KRW6U69mNq4W44LSc0gD2vTTbU9crUTcnL9LV8a23On2yCfyfP8qthfWiOByKfTuppC0SKNda0TWAmTNIOe2jgziNq4uPZ/2pYTPOfUCZCCYQahl4ILsss0jWZYWrQfBroaNxlLWascLNtUFTHzjZAUX8upDG1LKHWuDaepQIfY9nxyPGJE3ySdWGcmjc/iny3sVqGDT+hdwBSUEJEwS1u5KsYYMCz8Ktp3QP/68XKeZrGcG+BVlT5aNIcqND2tBH5EemSPLCOynEfkA0ZO5hwHc/mh+x9WVPPekIz//3fIr5zfLN/Zj2x2txyNsegEx6X4P1ov0LWGYPIKMLpbqJtuRLxY2q6HQaY026u9si80Yl80oA9YObNe4TB8dTzvNiDXplfDjJWofT90Cv3wbDtEQBuDR5astFpyhNKk1ObhWF2ta/jPf+v+cMk0VljPhf4PeGaXivt2Y0U2L831r7Jg0daw12/uHb4UU
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(107886003)(2906002)(356005)(47076005)(7636003)(40480700001)(83380400001)(82740400003)(5660300002)(426003)(336012)(66574015)(26005)(86362001)(16526019)(2616005)(36860700001)(8936002)(8676002)(4326008)(6666004)(40460700003)(478600001)(110136005)(70586007)(54906003)(70206006)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:17.2573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e8e55d-de52-4c93-dd21-08dbf029dbb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808

Currently, mlxsw always uses a "controlled" flood mode on all Nvidia
Spectrum generations. The following patches will however introduce a
possibility to run a "CFF" (for Compressed FID Flooding) mode on newer
machines, if the FW supports it.

Several operations will differ between how they need to be done in
controlled mode vs. CFF mode. Thus the per-FID-family ops will differ
between controlled and CFF, thus the FID family array as such will
differ depending on whether the mode negotiated with FW is controlled
or CFF.

The simple approach of having several globally visible arrays for
spectrum.c to statically choose from no longer works. Instead privatize all
FID initialization and finalization logic, and expose it as ops instead.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 18 +++++-----
 .../net/ethernet/mellanox/mlxsw/spectrum.h    | 13 +++++---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 33 +++++++++++++++----
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index cec72d99d9c9..6726447ce100 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3190,10 +3190,10 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_lag_init;
 	}
 
-	err = mlxsw_sp_fids_init(mlxsw_sp);
+	err = mlxsw_sp->fid_core_ops->init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize FIDs\n");
-		goto err_fids_init;
+		goto err_fid_core_init;
 	}
 
 	err = mlxsw_sp_policers_init(mlxsw_sp);
@@ -3379,8 +3379,8 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_traps_init:
 	mlxsw_sp_policers_fini(mlxsw_sp);
 err_policers_init:
-	mlxsw_sp_fids_fini(mlxsw_sp);
-err_fids_init:
+	mlxsw_sp->fid_core_ops->fini(mlxsw_sp);
+err_fid_core_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
 err_lag_init:
 	mlxsw_sp_pgt_fini(mlxsw_sp);
@@ -3416,7 +3416,7 @@ static int mlxsw_sp1_init(struct mlxsw_core *mlxsw_core,
 	mlxsw_sp->router_ops = &mlxsw_sp1_router_ops;
 	mlxsw_sp->listeners = mlxsw_sp1_listener;
 	mlxsw_sp->listeners_count = ARRAY_SIZE(mlxsw_sp1_listener);
-	mlxsw_sp->fid_family_arr = mlxsw_sp1_fid_family_arr;
+	mlxsw_sp->fid_core_ops = &mlxsw_sp1_fid_core_ops;
 	mlxsw_sp->lowest_shaper_bs = MLXSW_REG_QEEC_LOWEST_SHAPER_BS_SP1;
 	mlxsw_sp->pgt_smpe_index_valid = true;
 
@@ -3450,7 +3450,7 @@ static int mlxsw_sp2_init(struct mlxsw_core *mlxsw_core,
 	mlxsw_sp->router_ops = &mlxsw_sp2_router_ops;
 	mlxsw_sp->listeners = mlxsw_sp2_listener;
 	mlxsw_sp->listeners_count = ARRAY_SIZE(mlxsw_sp2_listener);
-	mlxsw_sp->fid_family_arr = mlxsw_sp2_fid_family_arr;
+	mlxsw_sp->fid_core_ops = &mlxsw_sp2_fid_core_ops;
 	mlxsw_sp->lowest_shaper_bs = MLXSW_REG_QEEC_LOWEST_SHAPER_BS_SP2;
 	mlxsw_sp->pgt_smpe_index_valid = false;
 
@@ -3484,7 +3484,7 @@ static int mlxsw_sp3_init(struct mlxsw_core *mlxsw_core,
 	mlxsw_sp->router_ops = &mlxsw_sp2_router_ops;
 	mlxsw_sp->listeners = mlxsw_sp2_listener;
 	mlxsw_sp->listeners_count = ARRAY_SIZE(mlxsw_sp2_listener);
-	mlxsw_sp->fid_family_arr = mlxsw_sp2_fid_family_arr;
+	mlxsw_sp->fid_core_ops = &mlxsw_sp2_fid_core_ops;
 	mlxsw_sp->lowest_shaper_bs = MLXSW_REG_QEEC_LOWEST_SHAPER_BS_SP3;
 	mlxsw_sp->pgt_smpe_index_valid = false;
 
@@ -3518,7 +3518,7 @@ static int mlxsw_sp4_init(struct mlxsw_core *mlxsw_core,
 	mlxsw_sp->router_ops = &mlxsw_sp2_router_ops;
 	mlxsw_sp->listeners = mlxsw_sp2_listener;
 	mlxsw_sp->listeners_count = ARRAY_SIZE(mlxsw_sp2_listener);
-	mlxsw_sp->fid_family_arr = mlxsw_sp2_fid_family_arr;
+	mlxsw_sp->fid_core_ops = &mlxsw_sp2_fid_core_ops;
 	mlxsw_sp->lowest_shaper_bs = MLXSW_REG_QEEC_LOWEST_SHAPER_BS_SP4;
 	mlxsw_sp->pgt_smpe_index_valid = false;
 
@@ -3552,7 +3552,7 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_devlink_traps_fini(mlxsw_sp);
 	mlxsw_sp_traps_fini(mlxsw_sp);
 	mlxsw_sp_policers_fini(mlxsw_sp);
-	mlxsw_sp_fids_fini(mlxsw_sp);
+	mlxsw_sp->fid_core_ops->fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_pgt_fini(mlxsw_sp);
 	mlxsw_sp_kvdl_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 800c461deefa..e50f22870602 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -205,7 +205,7 @@ struct mlxsw_sp {
 	const struct mlxsw_sp_mall_ops *mall_ops;
 	const struct mlxsw_sp_router_ops *router_ops;
 	const struct mlxsw_listener *listeners;
-	const struct mlxsw_sp_fid_family **fid_family_arr;
+	const struct mlxsw_sp_fid_core_ops *fid_core_ops;
 	size_t listeners_count;
 	u32 lowest_shaper_bs;
 	struct rhashtable ipv6_addr_ht;
@@ -252,6 +252,11 @@ struct mlxsw_sp_ptp_ops {
 			       const struct mlxsw_tx_info *tx_info);
 };
 
+struct mlxsw_sp_fid_core_ops {
+	int (*init)(struct mlxsw_sp *mlxsw_sp);
+	void (*fini)(struct mlxsw_sp *mlxsw_sp);
+};
+
 static inline struct mlxsw_sp_upper *
 mlxsw_sp_lag_get(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
 {
@@ -1321,11 +1326,9 @@ struct mlxsw_sp_fid *mlxsw_sp_fid_dummy_get(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_fid_put(struct mlxsw_sp_fid *fid);
 int mlxsw_sp_port_fids_init(struct mlxsw_sp_port *mlxsw_sp_port);
 void mlxsw_sp_port_fids_fini(struct mlxsw_sp_port *mlxsw_sp_port);
-int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp);
 
-extern const struct mlxsw_sp_fid_family *mlxsw_sp1_fid_family_arr[];
-extern const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr[];
+extern const struct mlxsw_sp_fid_core_ops mlxsw_sp1_fid_core_ops;
+extern const struct mlxsw_sp_fid_core_ops mlxsw_sp2_fid_core_ops;
 
 /* spectrum_mr.c */
 enum mlxsw_sp_mr_route_prio {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index aad4bb17dfb1..fc55ba781bca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1486,7 +1486,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp_fid_rfid_family = {
 	.smpe_index_valid       = false,
 };
 
-const struct mlxsw_sp_fid_family *mlxsw_sp1_fid_family_arr[] = {
+static const struct mlxsw_sp_fid_family *mlxsw_sp1_fid_family_arr[] = {
 	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp1_fid_8021q_family,
 	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp1_fid_8021d_family,
 	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp1_fid_dummy_family,
@@ -1529,7 +1529,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_dummy_family = {
 	.smpe_index_valid       = false,
 };
 
-const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr[] = {
+static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr[] = {
 	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp2_fid_8021q_family,
 	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp2_fid_8021d_family,
 	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp2_fid_dummy_family,
@@ -1799,7 +1799,9 @@ void mlxsw_sp_port_fids_fini(struct mlxsw_sp_port *mlxsw_sp_port)
 	mlxsw_sp->fid_core->port_fid_mappings[mlxsw_sp_port->local_port] = 0;
 }
 
-int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
+static int
+mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp,
+		   const struct mlxsw_sp_fid_family *fid_family_arr[])
 {
 	unsigned int max_ports = mlxsw_core_max_ports(mlxsw_sp->core);
 	struct mlxsw_sp_fid_core *fid_core;
@@ -1826,8 +1828,7 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 	}
 
 	for (i = 0; i < MLXSW_SP_FID_TYPE_MAX; i++) {
-		err = mlxsw_sp_fid_family_register(mlxsw_sp,
-						   mlxsw_sp->fid_family_arr[i]);
+		err = mlxsw_sp_fid_family_register(mlxsw_sp, fid_family_arr[i]);
 
 		if (err)
 			goto err_fid_ops_register;
@@ -1852,7 +1853,7 @@ int mlxsw_sp_fids_init(struct mlxsw_sp *mlxsw_sp)
 	return err;
 }
 
-void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp)
+static void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp)
 {
 	struct mlxsw_sp_fid_core *fid_core = mlxsw_sp->fid_core;
 	int i;
@@ -1865,3 +1866,23 @@ void mlxsw_sp_fids_fini(struct mlxsw_sp *mlxsw_sp)
 	rhashtable_destroy(&fid_core->fid_ht);
 	kfree(fid_core);
 }
+
+static int mlxsw_sp1_fids_init(struct mlxsw_sp *mlxsw_sp)
+{
+	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp1_fid_family_arr);
+}
+
+const struct mlxsw_sp_fid_core_ops mlxsw_sp1_fid_core_ops = {
+	.init = mlxsw_sp1_fids_init,
+	.fini = mlxsw_sp_fids_fini,
+};
+
+static int mlxsw_sp2_fids_init(struct mlxsw_sp *mlxsw_sp)
+{
+	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp2_fid_family_arr);
+}
+
+const struct mlxsw_sp_fid_core_ops mlxsw_sp2_fid_core_ops = {
+	.init = mlxsw_sp2_fids_init,
+	.fini = mlxsw_sp_fids_fini,
+};
-- 
2.41.0


