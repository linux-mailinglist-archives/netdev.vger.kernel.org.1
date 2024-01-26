Return-Path: <netdev+bounces-66250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A283E216
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99401F2163B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C992022339;
	Fri, 26 Jan 2024 18:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cmfqLOyM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8021A19
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295550; cv=fail; b=LAbPkL4ZiCKoiA+V95Ih2n5DgOn56dK8PGq3+CZCJM7H0CPrZlfPJ94Vwa6VYwo2nrCiHTYKmxgfVhJeJDZiyr4M5CITY6UglU9M6GUNpwPkE7URTYVyUlTqzcJjVc4o9Tkds/fb2QvOCLXyfKkYsp/KXkEg+SYFN6Ho6QXGmaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295550; c=relaxed/simple;
	bh=XbIVoY/rHpOJG/Lw0J8ZvoaB+vieBV25Ax//Xg4n6TY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJQ5Q9PQ3otDmKY01TjGMjN/0ePs3T01CHd7/hL//03n3qWYfT1Nr7PQ06h3aN76VS58r9XbYhZ16hScOdw6p9aLfQaYI3YQOJ1IS3LsM1+ZLVjUERMpHOYYh/urjxoUMm6lbkO8BM6cPH5F/fc3OGGB8ZWw2zRDEFbIAFyfkAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cmfqLOyM; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHLg6yq5duq8lvtoVzu1b83Zh0gZ8tBg+G9cZ0kqb0q/Z6y+Le0ICC2Rt127COjqYC9btlCrybR843kOziV7BSRzaCLmi4NPgYTgGom06fTB8v8du2gswptzeztTKss0Y3PriHOlEhcRRM4My7igIJ3IVmiaQ1sUOfeeqlXUYOnYMHtY8TMPFrAuEGkmUAKGTMw2ow9zBYe6weI8An3WtvUq271yIkRSGmNTc/FgwLKNCaqVgATiO/oT2G4V3yzaB1V316WfQMaZnOy3to9S1/JwMSSwjLMH1o48OTdGHch9ztfe9q/AVTvYkkpjH4KHSdGv26sft9zEs01XZrHjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZK6NDZa4+J1B5WnOvd1PlMyGouAzdBsw/IQCPQ8DvQ0=;
 b=l0/1555x4p2KTgxkLViH2CiQPgyjt5J+qrUpRp2aErSDyOZ8MBdOXukUu2bJavC77f8ZStL+Q4tt1pXvioqZjbA8e67et5AuxxMPh/oo2n6aj9uIbbC7i5+BQiNA0QiWYOXBAAz9pFE5l/DL7/G2UAIycLbnZlWsJsqs8BX11TPeczTdZyO011dXeb7vEyIb5OdYfVywv/SqypnNF/CPq6JP0pm8/zqCDbfSnmGtn4flK88ZZJ8Qg9X49chlr0rX0w4YNwnroy34uoUw44wUz6uf+sRZOujE+NcDYn/eB2INohPTd+pGGT/cJLViujW4T5cxHzEoSkKXo1ySHM12Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK6NDZa4+J1B5WnOvd1PlMyGouAzdBsw/IQCPQ8DvQ0=;
 b=cmfqLOyMxkLZxsu1U/Q3c4I/+2QW6ZNe6XEm15+Dqo5Nb3ptxvPIULUr0mZHMgsw58c6JgH8vSzzPlnkxy9Z1Cslxp4AkqeEROYYoWP5EeHZIMuPDySDtYjsbSRRXaewMLgB4xyppMBklLYCDekySqxWd5dcOYNffn26SCqz5UiH8TwnnfeQ6chtoATTYdviryedvkq297ubA+A0digxiGoh3rbtwWku+px+8nUejtvrjSa+2MDX3D9YI90EP5ICsOn39sEyEMz9wVWQEH8vmm+wPSlZ+L5FHZmcbBFC8XmQb+TNac7a+GlHeQxxvfsb2wt/bBm/dK9TRRSEenSAvQ==
Received: from BL0PR02CA0042.namprd02.prod.outlook.com (2603:10b6:207:3d::19)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 18:59:06 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::3e) by BL0PR02CA0042.outlook.office365.com
 (2603:10b6:207:3d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:50 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:47 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/6] mlxsw: spectrum: Change mlxsw_sp_upper to LAG structure
Date: Fri, 26 Jan 2024 19:58:26 +0100
Message-ID: <fe86c956bb9e2e798ab943267dfa2b7642d91afa.1706293430.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa3ca7a-af0b-47aa-3663-08dc1ea0de8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qcp6RfMLzZdzM5npoE+XD/Nkg6MLT7WNh8hdP9Qtzl/rO0mAx5So7wQfTCU2PXptYOXYWTpsAIRlfwIk/Q1g2h/M2BtjRhzsje1MLstK2HaB5gdkJif6pAz2Ye1/3zuGrSVBiZT+q027Oq8Nrc9h87/Xj85w4QKzgX3aVHTU2yzJ/H6zA1ELP2wExO/wTOHSdURPHsPOV28OGnoDXF0aHh2/A4vV7/034N7h+9KJeFR+LrtqFY6yJYKc4MG8smEX9r82RcMTqnhuvcXF6MjyWBJretf5nyUlOnkFCslnwRdXry34iJ4WVYSp0fh6LWrckjhfGVxMJKfPA9SBwdeuUK8jxCE+sjZqdPghthFEIPBEPooN+Cxzh4VmKuzmG3ivWI+5kTuqaMNIgmp8GdQSF5kcJ/cXW+sRFIIC39PNer5CAXx82gEWut2rAzbyCm8wVrs+x6+3Tu6qZ0rsQHKyeQ6mCx7Nb7Ylxuiu6TJwukcev9TH6nQE7769D3rt9jht8O8SkhkQmblnsj3CO2/91bWmJT7AJWAAF6yaKUR9xY3dLokbHUCza9ZoLCrGHlh13aS/RCVyeuGw5tZ3eoblczD8yPok4fW5SNVGESp5iwmpV9zWaNlJCmzhR2N7tc2jUDW4juaMbl9F45BjQYaDOjJ61KIBKJZ0AsVwSrkrLupws3kM7b0iFVfXQr9l2D0M0KW/RsBkvLprV65CwzCmfjRB53u+3OwzCKFXelkPol7es/KrX4xXTTFMwlPFObDp
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(40470700004)(46966006)(36840700001)(82740400003)(7636003)(36860700001)(5660300002)(2906002)(36756003)(41300700001)(356005)(26005)(16526019)(86362001)(426003)(478600001)(107886003)(2616005)(6666004)(336012)(83380400001)(8936002)(4326008)(8676002)(47076005)(54906003)(70206006)(70586007)(110136005)(316002)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:05.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa3ca7a-af0b-47aa-3663-08dc1ea0de8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

From: Amit Cohen <amcohen@nvidia.com>

The structure mlxsw_sp_upper is used only as LAG. Rename it to
mlxsw_sp_lag and move it to spectrum.c file, as it is used only there.
Move the function mlxsw_sp_lag_get() with the structure.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 19 +++++++++++++++----
 .../net/ethernet/mellanox/mlxsw/spectrum.h    | 14 ++------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 5d3413636a62..38428d2ef0e2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2751,6 +2751,11 @@ static void mlxsw_sp_lag_pgt_fini(struct mlxsw_sp *mlxsw_sp)
 
 #define MLXSW_SP_LAG_SEED_INIT 0xcafecafe
 
+struct mlxsw_sp_lag {
+	struct net_device *dev;
+	unsigned int ref_count;
+};
+
 static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 {
 	char slcr_pl[MLXSW_REG_SLCR_LEN];
@@ -2784,7 +2789,7 @@ static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
 	if (err)
 		return err;
 
-	mlxsw_sp->lags = kcalloc(max_lag, sizeof(struct mlxsw_sp_upper),
+	mlxsw_sp->lags = kcalloc(max_lag, sizeof(struct mlxsw_sp_lag),
 				 GFP_KERNEL);
 	if (!mlxsw_sp->lags) {
 		err = -ENOMEM;
@@ -4329,11 +4334,17 @@ static int mlxsw_sp_lag_col_port_disable(struct mlxsw_sp_port *mlxsw_sp_port,
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(slcor), slcor_pl);
 }
 
+static struct mlxsw_sp_lag *
+mlxsw_sp_lag_get(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
+{
+	return &mlxsw_sp->lags[lag_id];
+}
+
 static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 				  struct net_device *lag_dev,
 				  u16 *p_lag_id)
 {
-	struct mlxsw_sp_upper *lag;
+	struct mlxsw_sp_lag *lag;
 	int free_lag_id = -1;
 	u16 max_lag;
 	int err, i;
@@ -4482,7 +4493,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-	struct mlxsw_sp_upper *lag;
+	struct mlxsw_sp_lag *lag;
 	u16 lag_id;
 	u8 port_index;
 	int err;
@@ -4560,7 +4571,7 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 	u16 lag_id = mlxsw_sp_port->lag_id;
-	struct mlxsw_sp_upper *lag;
+	struct mlxsw_sp_lag *lag;
 
 	if (!mlxsw_sp_port->lagged)
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index a0c9775fa955..dd2f05a6d909 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -78,11 +78,6 @@ struct mlxsw_sp_span_entry;
 enum mlxsw_sp_l3proto;
 union mlxsw_sp_l3addr;
 
-struct mlxsw_sp_upper {
-	struct net_device *dev;
-	unsigned int ref_count;
-};
-
 enum mlxsw_sp_rif_type {
 	MLXSW_SP_RIF_TYPE_SUBPORT,
 	MLXSW_SP_RIF_TYPE_VLAN,
@@ -136,6 +131,7 @@ struct mlxsw_sp_span_ops;
 struct mlxsw_sp_qdisc_state;
 struct mlxsw_sp_mall_entry;
 struct mlxsw_sp_pgt;
+struct mlxsw_sp_lag;
 
 struct mlxsw_sp_port_mapping {
 	u8 module;
@@ -164,7 +160,7 @@ struct mlxsw_sp {
 	const struct mlxsw_bus_info *bus_info;
 	unsigned char base_mac[ETH_ALEN];
 	const unsigned char *mac_mask;
-	struct mlxsw_sp_upper *lags;
+	struct mlxsw_sp_lag *lags;
 	struct mlxsw_sp_port_mapping *port_mapping;
 	struct mlxsw_sp_port_mapping_events port_mapping_events;
 	struct rhashtable sample_trigger_ht;
@@ -257,12 +253,6 @@ struct mlxsw_sp_fid_core_ops {
 	void (*fini)(struct mlxsw_sp *mlxsw_sp);
 };
 
-static inline struct mlxsw_sp_upper *
-mlxsw_sp_lag_get(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
-{
-	return &mlxsw_sp->lags[lag_id];
-}
-
 struct mlxsw_sp_port_pcpu_stats {
 	u64			rx_packets;
 	u64			rx_bytes;
-- 
2.43.0


