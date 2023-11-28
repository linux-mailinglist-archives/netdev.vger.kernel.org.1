Return-Path: <netdev+bounces-51740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DDE7FBE87
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21B51B2151D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9CE5CD2D;
	Tue, 28 Nov 2023 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQp/Qbag"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE0B1BC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur2TvDAtTnDf2/pexv2CrMiRsUp/EJ3WAxfOYQQT01neKjl+sSgwDt/0kdARpeFuDUqVqOlroct2gzGay8LD63WRurpikcESa0FzVW7bx2eVVvdrn1gy3fqXokVLuyPgD9YMKwK8TRM6eK4MSz5LYWo3DQmw5nX9nbFvvHwjV3E8lr7pRInTZ2yltwJgEZ2V8ZpqMSGQolmnbtHTq8bQ8OoURyZvVmSGtqkv6IVaiK00Tw5WRHeWjkUkw9fY2uVXHDXYUyxGbfLDaDd1l4TvJzDVZe46IKrww67f+BuPkr2q47UluDtBGL7wpIHNyH4tUOnnDOHiGdDzZ5/SJEyL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axinc0MnEOIoDJ9rxU4rX35yfF3arjdyon+gFhSt0Lc=;
 b=Y4dkONRDbXXyFuvbg2RVl36ham53bhWuKycE7OXwx3Bx8GMbwNee2WoAtOkiLjh9Dsx3JyQObMeu0E+wt6bcPcjflcX4iVs8SxJTGol5X1SOsJX7yPwL42oYhZvk69c1xlN2+TzoEy8FkP37dhdpqhO/NySh1LCSHIY1C2o71hVj/cxOEAB5876Soyxk6Q1sfLcTAA1OrPr+zH80ygpu+avMG3sjKQ8cuyAX2frGqStVGY7+PW5pTGC7vpJSNxgF8bm52+MJPwkXLM9ay4gmR6hwssOZ6kO3wdc1h7Txc2Rs2/WBJtiBCzUEL23d80iG6j4PJ8hY/7SPaxu0q7dx1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axinc0MnEOIoDJ9rxU4rX35yfF3arjdyon+gFhSt0Lc=;
 b=AQp/QbagdSPeqRXcUyG1EQ7yGl0C/Yznl+sn4qpiHnl0ZyJZ/8KCLq+ds2JRSmOjOkHd9EfgUNkqZsycU3zVIb0qO/VApPCbrTUMfs29iBuvIA2xNQMARs8isDITMEEk3kg5TQlp697gUv0HwZudxGThg3IlMvENdFoiWqMK0CCAiiFePmceFeT51pAGEJEKDMv9CPl+njhEPyJiFFM6OukkNnvgpq39TF9YasXwcuczrOVkCKWBrETpFoPr+u09hAGLRs1hNXNvBZx+yzymFbG8JdLCoj6zaWTWgnBisZ3j2XUKstnAtLvY8HkpPeOggvwkfDYD4puGgOSVfUGujA==
Received: from CYXPR02CA0094.namprd02.prod.outlook.com (2603:10b6:930:ce::22)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:51:34 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::84) by CYXPR02CA0094.outlook.office365.com
 (2603:10b6:930:ce::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:25 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:23 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/17] mlxsw: spectrum_fid: Add an op to get PGT allocation size
Date: Tue, 28 Nov 2023 16:50:40 +0100
Message-ID: <1174651b7160fcedbef50010ae4b68201112fe6f.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: e97536be-e4c1-41a2-25a9-08dbf029e5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwUESeghPe6S/dBPIDnTBiJEyVZOEwp9kZZu6ZHFZ+/PNdeIy1rmcKkbbi8KfsN3LOaIjMsYjeslW9W7ZyXRQ/mn9pdmMTVXgtQdEHAB8dTl/krlSMpHU0CqbqZYZ0OcGie1DTwMayah8TejUir4ze+bjQm9ayVtR3hYRbCNg1QEVc51YJchI90B3vxT53VkrWkylos2ukSAq1NvBHVpv1IYFBW4KUWcEWFH41DJKELLV2QO4VsMEjRN7o7ts16tG+shda9BohCbxF0rfrH3TzoQz+pvUxKmpG6XeI91s7ngeAle82Y/jAPWqJQa/nKcFH3rirM6H7W5WxSsCDo7YCKezuN62iXzg+DFbOtMDlbesYlTPQ96WZG107UmIwSJfsk1PCAtGEOl4JWEAuBpwipL4k2CHUEt8KwJ9e2O1sQDRS1S9HSFAvdBKBuZyfMnD3WHKhIxaeIRe2+emgFsYf9Xj/GlICGGgxNSpbu0LjfUPU2FCPAxNfXFwlFNHqb/lx3QEP7yU4kLN2WfvaPAopToLBi++vD2tBwzPmih3oXNRU68tWzsgSx6PM5rYwgOE43NpMx98pf+2H24RAeongIe9Atvmo8KGDK8KFZ8zTX6fSnXDubKzGPCU20c+SsmGNtX2KX3BRQ5e+pl3vngpPPzbHzTtQSjKwPO8BayuwKAmkIU4GQE5Xj4s+vLxFzkpbRIUHlqwLTJLg3eoof0jWRV49Vmug9nzKBsK6BQ0MMc5/OVsZqc8kE2T5iStELB
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(356005)(7636003)(47076005)(82740400003)(336012)(5660300002)(8936002)(4326008)(8676002)(6666004)(426003)(86362001)(70206006)(316002)(110136005)(70586007)(36860700001)(54906003)(478600001)(36756003)(40480700001)(41300700001)(2906002)(107886003)(16526019)(26005)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:34.1715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97536be-e4c1-41a2-25a9-08dbf029e5cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

In the CFF flood mode, the PGT allocation size of RFID family will not
depend on number of FIDs, but rather number of ports and LAGs. Therefore
introduce a FID family operation to calculate the PGT allocation size.

The way that size is calculated in the CFF mode depends on calling fallible
functions. Thus express the op as returning an int, with the size returned
via a pointer argument.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 9ba4748e8d23..e8327c5b0b82 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -97,6 +97,8 @@ struct mlxsw_sp_fid_ops {
 				     const struct mlxsw_sp_rif *rif);
 	int (*flood_table_init)(struct mlxsw_sp_fid_family *fid_family,
 				const struct mlxsw_sp_flood_table *flood_table);
+	int (*pgt_size)(const struct mlxsw_sp_fid_family *fid_family,
+			u16 *p_pgt_size);
 };
 
 struct mlxsw_sp_fid_family {
@@ -322,12 +324,14 @@ mlxsw_sp_fid_family_num_fids(const struct mlxsw_sp_fid_family *fid_family)
 	return fid_family->end_index - fid_family->start_index + 1;
 }
 
-static u16
-mlxsw_sp_fid_family_pgt_size(const struct mlxsw_sp_fid_family *fid_family)
+static int
+mlxsw_sp_fid_8021d_pgt_size(const struct mlxsw_sp_fid_family *fid_family,
+			    u16 *p_pgt_size)
 {
 	u16 num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
 
-	return num_fids * fid_family->nr_flood_tables;
+	*p_pgt_size = num_fids * fid_family->nr_flood_tables;
+	return 0;
 }
 
 static u16
@@ -1124,6 +1128,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.fdb_clear_offload	= mlxsw_sp_fid_8021d_fdb_clear_offload,
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021d_vid_to_fid_rif_update,
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
+	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
 };
 
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
@@ -1466,6 +1471,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.fdb_clear_offload	= mlxsw_sp_fid_8021q_fdb_clear_offload,
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_8021q_vid_to_fid_rif_update,
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
+	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
 };
 
 /* There are 4K-2 802.1Q FIDs */
@@ -1717,7 +1723,10 @@ mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 	int err;
 	int i;
 
-	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
+	err = fid_family->ops->pgt_size(fid_family, &pgt_size);
+	if (err)
+		return err;
+
 	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, &fid_family->pgt_base,
 					   pgt_size);
 	if (err)
@@ -1747,8 +1756,12 @@ mlxsw_sp_fid_flood_tables_fini(struct mlxsw_sp_fid_family *fid_family)
 {
 	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
 	u16 pgt_size;
+	int err;
+
+	err = fid_family->ops->pgt_size(fid_family, &pgt_size);
+	if (WARN_ON_ONCE(err))
+		return;
 
-	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
 	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, fid_family->pgt_base, pgt_size);
 }
 
-- 
2.41.0


