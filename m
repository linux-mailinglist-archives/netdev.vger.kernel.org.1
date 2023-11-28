Return-Path: <netdev+bounces-51736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222E7FBE82
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEFC2825AB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856A1E4B2;
	Tue, 28 Nov 2023 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aXHsChTJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D641BE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK8Q2+OghuBjYqvobwTRjYkwPtq45sEIwt0kGXa0bjVEecVSydTMaSHRCTvs2dUy1TduCjCIGz7c4kstA4bwl11kCQfYd9LAL47wbqZo2uR7wNzK7Om3UA7pupqeFNgzl4n+f36dokE7fNxxmEHpSoAYlNIICBta3heMzdMRWdTGa2a8/0aQxYBOv8z9OVMNx3IxP70shKaZxXHJZz78AnZkYdJmoBxcIMjXUhoqkLrBa22qf51eFnbQi2tYZ9z0oK3GJibQIarQM1s+fvIIwVJYjWpi/B/xJQZM2dtdXkZL081WzV6NnaLtL15aTSADoDabWfB9u5AP3GKbgeuSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3EuImfDo5ARo9t58j/tHIcEM690dx2aON3cnI/jiio=;
 b=lzG/YapFfvywRz7VzZM6h0xZvbdMn9WX5CXhxA551Sns9UpMzzDK0xknw+l7R/Luu89GE0+YS4T05byGpWxUUAlbJyHxgtBQzey8Bwfz54qGKF6HfZZfBZYLpHzVX7yxBM7c8He3+LmSWBmdMb7R6DrCFow7/9bPyiSNDGxVAtGF1q4A4Gxklg45Y0s21xLlWbJMibjrCOmXkyPyfgzw37w7nUNfelK7zAdvmmTWx9sk4ELWHHWMMBU5I9RGnzE9eZoSqNZRW0GqpC+nTUDVt2Y8xcYVv5tmEEROalR+aXEjwIpO4elqXfY7hZ68cw5ZWvKaEkg0HJhVg70tdfekyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3EuImfDo5ARo9t58j/tHIcEM690dx2aON3cnI/jiio=;
 b=aXHsChTJwqBPd82BMMgaNDxaoZWtbUWvzHb8uj21pG3x5CtOLuqe3+/hRy54nm81h06IFZ8mw+xzv7kaNLs6UejOn1qC7Svx5fC6fT76WfjHpIykT7JrsmvtT7oFhEhPNIVak8vDqJmiB2M/BVIB3BCV80RI494+rd6iIGeoXx7szHthHTT65d3KZlE5AvhLbvEH7DylyneJfTyTENVctvb9Ex5CtqRWetUrcx/MBJnd8ekMjvkUZeA1oZ6zKO+ULW2LqCTJCtZKFZ612EGkKjXNPcoZ4XS3+vcAhNdrQK0yOT/FL05637yRD4xVxwH1Al/RQWDO38qsDO8YupMzVQ==
Received: from MW2PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:302:1::33)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:51:27 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::e5) by MW2PR2101CA0020.outlook.office365.com
 (2603:10b6:302:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.3 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:12 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:10 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/17] mlxsw: spectrum_fid: Rename FID ops, families, arrays
Date: Tue, 28 Nov 2023 16:50:35 +0100
Message-ID: <96b6da5439bb662fa86e795bbcec9dc3ccfa59fd.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc78973-b007-4144-13b4-08dbf029e0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cuMEymy5OTj6JdHuN6HKFQpslYCnXKykAosVfPvNsqBdBouLN7dZaTucth5laPCaw/4K31T2kE64uWVNgIkQkqIRbbon5uTV/mRjxj8eP5FO2F9L1sCdY189VkJ6rvgjckFEgcj5KCOcaZckwlpQqOG4ToUDFK8ds4wzWxbITdLzusmoOoF1Yepc2MMUXPWwREx7gsfBt4Z+pviEyVwPxaS81dHgsPZZtYbD+ED80IM27Gze5m/ZZrm20tiUxiT1ECLXBxrZ0FwqEA0/ddiMeF0AzbZodjYw+BuUiTznmqKZ9J6hrL1wh7JxQgcxjRuiUKl24pYFNlKhzELYRTFbFbyVQi1zLJt3w6zO0asCa4rynDQq4QfCZ6Nz2sV3wUKcwMXUFX1IfnDy1fUyhDdlG2ql5tEd/auvi7dHqJ8e3UYOW5lffe7/RjVFAX5uQUxWGlntVgi/FwtdLPCNuUZPox29LyGRAl7Rfl6eYHLNW4poSGYe0bZhb5VXqSyZfxDZ+wZnivLFdhmkhrKNSmBY8okqbPcAkZXyEfQZzsBAnesK+NF/Mp2ZygTADds2X4kydwZkG2f/Pbukr9F2uZzGP2j7eRRnao8ztbZc3Or//SQi8GEwcRMuW7G8h4mWUmosHnBsK/HOumFMIm319SA3/Lmxh2IZ5y6gYb+gdeFRPKptvJe5sYTLIPWX7RG4tfIP8pq4hbAZDBPStvRt36AZQKfXFVF4Rc25NeevecZj63gxaYcyWGZIFb1do+Q8gPZH
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(8676002)(4326008)(8936002)(478600001)(54906003)(110136005)(316002)(40460700003)(47076005)(356005)(7636003)(36756003)(40480700001)(41300700001)(86362001)(107886003)(70586007)(26005)(2906002)(36860700001)(2616005)(426003)(83380400001)(16526019)(70206006)(82740400003)(5660300002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:26.0759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc78973-b007-4144-13b4-08dbf029e0f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062

Currently, mlxsw always uses a "controlled" flood mode on all Nvidia
Spectrum generations. The following patches will however introduce a
possibility to run a "CFF" (for Compressed FID Flooding) mode on newer
machines, if the FW supports it.

To reflect that, label all FID ops, FID families and FID family arrays with
a _ctl suffix. This will make it clearer what is what when the CFF families
are introduced in later patches.

Keep the dummy family intact. Since the dummy family has no flood tables
in either CTL or CFF mode, there are no flood-mode-specific callbacks.

Additionally, add a remark at two fields that they are only relevant when
flood mode is not CFF.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 48 ++++++++++---------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index fc55ba781bca..d92c44c6ffbf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -71,7 +71,7 @@ static const struct rhashtable_params mlxsw_sp_fid_vni_ht_params = {
 
 struct mlxsw_sp_flood_table {
 	enum mlxsw_sp_flood_type packet_type;
-	enum mlxsw_flood_table_type table_type;
+	enum mlxsw_flood_table_type table_type;	/* For flood_mode!=CFF. */
 	int table_index;
 };
 
@@ -109,7 +109,7 @@ struct mlxsw_sp_fid_family {
 	enum mlxsw_sp_rif_type rif_type;
 	const struct mlxsw_sp_fid_ops *ops;
 	struct mlxsw_sp *mlxsw_sp;
-	bool flood_rsp;
+	bool flood_rsp;	/* For flood_mode!=CFF. */
 	enum mlxsw_reg_bridge_type bridge_type;
 	u16 pgt_base;
 	bool smpe_index_valid;
@@ -1068,7 +1068,7 @@ mlxsw_sp_fid_8021d_vid_to_fid_rif_update(const struct mlxsw_sp_fid *fid,
 	return 0;
 }
 
-static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops = {
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.setup			= mlxsw_sp_fid_8021d_setup,
 	.configure		= mlxsw_sp_fid_8021d_configure,
 	.deconfigure		= mlxsw_sp_fid_8021d_deconfigure,
@@ -1120,8 +1120,10 @@ mlxsw_sp_fid_8021q_fdb_clear_offload(const struct mlxsw_sp_fid *fid,
 	br_fdb_clear_offload(nve_dev, mlxsw_sp_fid_8021q_vid(fid));
 }
 
-static void mlxsw_sp_fid_rfid_setup(struct mlxsw_sp_fid *fid, const void *arg)
+static void mlxsw_sp_fid_rfid_setup_ctl(struct mlxsw_sp_fid *fid,
+					const void *arg)
 {
+	/* In controlled mode, the FW takes care of FID placement. */
 	fid->fid_offset = 0;
 }
 
@@ -1248,8 +1250,8 @@ mlxsw_sp_fid_rfid_vid_to_fid_rif_update(const struct mlxsw_sp_fid *fid,
 	return 0;
 }
 
-static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops = {
-	.setup			= mlxsw_sp_fid_rfid_setup,
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops_ctl = {
+	.setup			= mlxsw_sp_fid_rfid_setup_ctl,
 	.configure		= mlxsw_sp_fid_rfid_configure,
 	.deconfigure		= mlxsw_sp_fid_rfid_deconfigure,
 	.index_alloc		= mlxsw_sp_fid_rfid_index_alloc,
@@ -1405,7 +1407,7 @@ mlxsw_sp_fid_8021q_port_vid_unmap(struct mlxsw_sp_fid *fid,
 		__mlxsw_sp_fid_port_vid_map(fid, local_port, vid, false);
 }
 
-static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops = {
+static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.setup			= mlxsw_sp_fid_8021q_setup,
 	.configure		= mlxsw_sp_fid_8021q_configure,
 	.deconfigure		= mlxsw_sp_fid_8021q_deconfigure,
@@ -1447,7 +1449,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021q_family = {
 	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
 	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
 	.rif_type		= MLXSW_SP_RIF_TYPE_VLAN,
-	.ops			= &mlxsw_sp_fid_8021q_ops,
+	.ops			= &mlxsw_sp_fid_8021q_ops_ctl,
 	.flood_rsp              = false,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_0,
 	.smpe_index_valid	= false,
@@ -1461,7 +1463,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_8021d_family = {
 	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
 	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
-	.ops			= &mlxsw_sp_fid_8021d_ops,
+	.ops			= &mlxsw_sp_fid_8021d_ops_ctl,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
 	.smpe_index_valid       = false,
 };
@@ -1475,13 +1477,13 @@ static const struct mlxsw_sp_fid_family mlxsw_sp1_fid_dummy_family = {
 	.smpe_index_valid       = false,
 };
 
-static const struct mlxsw_sp_fid_family mlxsw_sp_fid_rfid_family = {
+static const struct mlxsw_sp_fid_family mlxsw_sp_fid_rfid_family_ctl = {
 	.type			= MLXSW_SP_FID_TYPE_RFID,
 	.fid_size		= sizeof(struct mlxsw_sp_fid),
 	.start_index		= MLXSW_SP_RFID_START,
 	.end_index		= MLXSW_SP_RFID_END,
 	.rif_type		= MLXSW_SP_RIF_TYPE_SUBPORT,
-	.ops			= &mlxsw_sp_fid_rfid_ops,
+	.ops			= &mlxsw_sp_fid_rfid_ops_ctl,
 	.flood_rsp              = true,
 	.smpe_index_valid       = false,
 };
@@ -1490,10 +1492,10 @@ static const struct mlxsw_sp_fid_family *mlxsw_sp1_fid_family_arr[] = {
 	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp1_fid_8021q_family,
 	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp1_fid_8021d_family,
 	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp1_fid_dummy_family,
-	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family,
+	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family_ctl,
 };
 
-static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family = {
+static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family_ctl = {
 	.type			= MLXSW_SP_FID_TYPE_8021Q,
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021q),
 	.start_index		= MLXSW_SP_FID_8021Q_START,
@@ -1501,13 +1503,13 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021q_family = {
 	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
 	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
 	.rif_type		= MLXSW_SP_RIF_TYPE_VLAN,
-	.ops			= &mlxsw_sp_fid_8021q_ops,
+	.ops			= &mlxsw_sp_fid_8021q_ops_ctl,
 	.flood_rsp              = false,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_0,
 	.smpe_index_valid	= true,
 };
 
-static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family = {
+static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family_ctl = {
 	.type			= MLXSW_SP_FID_TYPE_8021D,
 	.fid_size		= sizeof(struct mlxsw_sp_fid_8021d),
 	.start_index		= MLXSW_SP_FID_8021D_START,
@@ -1515,7 +1517,7 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_8021d_family = {
 	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
 	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
 	.rif_type		= MLXSW_SP_RIF_TYPE_FID,
-	.ops			= &mlxsw_sp_fid_8021d_ops,
+	.ops			= &mlxsw_sp_fid_8021d_ops_ctl,
 	.bridge_type            = MLXSW_REG_BRIDGE_TYPE_1,
 	.smpe_index_valid       = true,
 };
@@ -1529,11 +1531,11 @@ static const struct mlxsw_sp_fid_family mlxsw_sp2_fid_dummy_family = {
 	.smpe_index_valid       = false,
 };
 
-static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr[] = {
-	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp2_fid_8021q_family,
-	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp2_fid_8021d_family,
+static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_ctl[] = {
+	[MLXSW_SP_FID_TYPE_8021Q]	= &mlxsw_sp2_fid_8021q_family_ctl,
+	[MLXSW_SP_FID_TYPE_8021D]	= &mlxsw_sp2_fid_8021d_family_ctl,
 	[MLXSW_SP_FID_TYPE_DUMMY]	= &mlxsw_sp2_fid_dummy_family,
-	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family,
+	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family_ctl,
 };
 
 static struct mlxsw_sp_fid *mlxsw_sp_fid_lookup(struct mlxsw_sp *mlxsw_sp,
@@ -1877,12 +1879,12 @@ const struct mlxsw_sp_fid_core_ops mlxsw_sp1_fid_core_ops = {
 	.fini = mlxsw_sp_fids_fini,
 };
 
-static int mlxsw_sp2_fids_init(struct mlxsw_sp *mlxsw_sp)
+static int mlxsw_sp2_fids_init_ctl(struct mlxsw_sp *mlxsw_sp)
 {
-	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp2_fid_family_arr);
+	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp2_fid_family_arr_ctl);
 }
 
 const struct mlxsw_sp_fid_core_ops mlxsw_sp2_fid_core_ops = {
-	.init = mlxsw_sp2_fids_init,
+	.init = mlxsw_sp2_fids_init_ctl,
 	.fini = mlxsw_sp_fids_fini,
 };
-- 
2.41.0


