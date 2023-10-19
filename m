Return-Path: <netdev+bounces-42562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A17CF53C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B576E282062
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D8E1DFC7;
	Thu, 19 Oct 2023 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MTpqBD2i"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8494718AFB
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13E12A
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a96LGuMauHx1XGSFPJfEGiJy7Dk5QyENCU01+xl8XDtW4fbzLyvoVHwaHiSNVNGccuWVhIuKaG64a2x3S5MPU+OPqTsioCrYBigdyp1X/IRoVb0FPmaGHaEUL3/9rT7gGzSga+U9xflu6xbLpDyNGiBSMAuVtIxDtMTE3w5HLVFH3I9XdxyrfldUgegjHn2UUw9ywjWqBzkDCehyrNx5nJB65N0dECBsHxrIgb69aC7RLSGMlgDLuuKuRYJZUAqaexrpztPTGh7k9zZKsTDfs1iOs39Lq1B9ctSBVVZxQfDaejKHaQvQcbJOldwmfz/MNr9pOvdoAO9cA56Uu/rU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3Te5DtNGR1ydOeaPMBsy8xdzAAOieRfJJ7hOTm6+LI=;
 b=dV2cMphuBrAcSNY+shT6Scg9/ISB+ACqBtJVs2DySc8rq4VlycAkxYIioNQssdebSSfCT9aRXI+P4lyxpS8CQf4xd/ORkMeREAeAWEzGTd7YaBn0Fph+38PsklY1WknmkHTnCSalDqngp3uI5NvBjSd+GHSTlped3XWmrJwv22Jhg+ONf3auyTvNZBX1YZLWNYch+0H/fO0VklWRE0NmAawoATijAy84wRcOx4JTanqXcSltkOylrFvYkDZF60oJsAkwT6iZ2OhQ/iY4d0sK6OJ3sBdrH1bPw+t0+21ZKnIbvGJzuVehCzq4mhUUN1mg9/5rovH0eHvLt30Q7zVQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3Te5DtNGR1ydOeaPMBsy8xdzAAOieRfJJ7hOTm6+LI=;
 b=MTpqBD2iL48aZ9wY1xiZbi5NtLDfd2NwF10ZAqJ1ymX90uHBAmGxWLTmx1Phu3h/qd7hG7EgnsWZq5Mxc/5GXcco/6j2K0Iy92Ne3CHYB2LuoXgVIMA4DgapCT0OQlUynKS/SQ7BWnAracALdDKNWYfx7kOL/e5XIlk69f1hzvIa1MwblfFpfBRVZNVRzhSl5uRa0G3KH5tqoSbY6nstvmTp++Y5ZVKlAl/4ZIgUtqBqs7kv2/W72J2hpWSOnFOskjw1vSlRa6EhRc2DCNnxBcsj4hRzjPOGE6tVnPhoxKSBCK6u3PoGBtwzmaB6ZoScrAUH7LplGnRBy5HM6yDIAg==
Received: from MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:28:14 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::80) by MN2PR20CA0008.outlook.office365.com
 (2603:10b6:208:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:28:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:57 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:55 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 08/11] mlxsw: spectrum_fid: Allocate PGT for the whole FID family in one go
Date: Thu, 19 Oct 2023 12:27:17 +0200
Message-ID: <3b8a3df3ec6a31bf3d7cf808defd4b50fe4fb824.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4c0f2e-614a-4798-a640-08dbd08e1a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E2+fC6ZITTSl7Upd4qkSAjhBB+/kTKcpJfnnFvj6IsKyyCm16yyLf5djh+LoR9SfD0d7vehhSd358R04gRw89N73OhLjJKpWidTuRi19S/Phl+D5rFZqI9aiAatsC/i+9AlByrpNJ60xh+OI/80phxBoooKwnOv6kl70r2NUNNQvWujLFnaK7drL51SfCMCXtjB/FH3+v8vJBvVonqbIcocOHc+XNZlPf+NIO+H5D8pj01+iaz/6mcg57kcrseP4O9NyWf0DD5HDGFEuohw82xCg/9IDg99ixFc2vahSgdTbDh766vQwC7+jiCBF9CtzoK9LGdpr2Cs/kVMuXwKzMm7RZpNPOld+GNfIsifr3EjYtFcy9+NBHswEBOeyamPRzsSEs2ZUjwwqSLH1l+PviNanjUyMzZg+c8m/CpGFVgrmZhV54E66MsNfXTjZST8j2G47VdvJSsb/NN7ERZ6tSm7Z28V0j+B0dSqq6i7H7yJRO8XFzQDca+9h0uU+vNF58BxVo7Ht38r0I2mDMvOeCrTSfjxWdfWfkl1RoowN4rDVwqxZHWQ7DeV0gXQ08Y1yseGPGpazM8e3bFxurN0DiOPJBvJN4Af1wf+KvIBDjw9VFjxi0SMfMVtadCauX1BFZepG+VPNrMSg1fgiiC2qwagJiWJKgbv/nvwRVA3MDz5WlD2QAewDV8P5vt8xkXh9wfy92OU8qYZcnxgDEAalmlQ/hs81o6sg8LxU4cW1vrpqK4GC5eNdSryLsr0SY5yN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(40470700004)(46966006)(36840700001)(54906003)(316002)(70586007)(70206006)(41300700001)(40480700001)(8936002)(8676002)(4326008)(5660300002)(6666004)(7696005)(110136005)(40460700003)(478600001)(2906002)(36860700001)(47076005)(83380400001)(7636003)(336012)(86362001)(356005)(26005)(16526019)(2616005)(107886003)(426003)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:14.4985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c0f2e-614a-4798-a640-08dbd08e1a3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

PGT blocks are allocated through the function
mlxsw_sp_pgt_mid_alloc_range(). The interface assumes that the caller knows
which piece of PGT exactly they want to get. That was fine while the FID
code was the only client allocating blocks of PGT. However for SW-allocated
LAG table, there will be an additional client: mlxsw_sp_lag_init(). The
interface should therefore be changed to not require particular
coordinates, but to take just the requested size, allocate the block
wherever, and give back the PGT address.

The current FID mode has one place where PGT address can be stored: the FID
family's pgt_base. The allocation scheme should therefore be changed from
allocating a block per FID flood table, to allocating a block per FID
family.

Do just that in this patch.

The per-family allocation is going to be useful for another related feature
as well: the CFF mode.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 63 ++++++++++---------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 9df098474743..4d0b72fbfebe 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -320,6 +320,14 @@ mlxsw_sp_fid_family_num_fids(const struct mlxsw_sp_fid_family *fid_family)
 	return fid_family->end_index - fid_family->start_index + 1;
 }
 
+static u16
+mlxsw_sp_fid_family_pgt_size(const struct mlxsw_sp_fid_family *fid_family)
+{
+	u16 num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
+
+	return num_fids * fid_family->nr_flood_tables;
+}
+
 static u16
 mlxsw_sp_fid_flood_table_mid(const struct mlxsw_sp_fid_family *fid_family,
 			     const struct mlxsw_sp_flood_table *flood_table,
@@ -1654,14 +1662,10 @@ mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
 	enum mlxsw_sp_flood_type packet_type = flood_table->packet_type;
 	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
 	const int *sfgc_packet_types;
-	u16 num_fids, mid_base;
+	u16 mid_base;
 	int err, i;
 
 	mid_base = mlxsw_sp_fid_flood_table_mid(fid_family, flood_table, 0);
-	num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
-	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, mid_base, num_fids);
-	if (err)
-		return err;
 
 	sfgc_packet_types = mlxsw_sp_packet_type_sfgc_types[packet_type];
 	for (i = 0; i < MLXSW_REG_SFGC_TYPE_MAX; i++) {
@@ -1675,57 +1679,56 @@ mlxsw_sp_fid_flood_table_init(struct mlxsw_sp_fid_family *fid_family,
 
 		err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfgc), sfgc_pl);
 		if (err)
-			goto err_reg_write;
+			return err;
 	}
 
 	return 0;
-
-err_reg_write:
-	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mid_base, num_fids);
-	return err;
-}
-
-static void
-mlxsw_sp_fid_flood_table_fini(struct mlxsw_sp_fid_family *fid_family,
-			      const struct mlxsw_sp_flood_table *flood_table)
-{
-	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
-	u16 num_fids, mid_base;
-
-	mid_base = mlxsw_sp_fid_flood_table_mid(fid_family, flood_table, 0);
-	num_fids = mlxsw_sp_fid_family_num_fids(fid_family);
-	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, mid_base, num_fids);
 }
 
 static int
 mlxsw_sp_fid_flood_tables_init(struct mlxsw_sp_fid_family *fid_family)
 {
+	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
+	u16 pgt_size;
+	int err;
 	int i;
 
+	if (!fid_family->nr_flood_tables)
+		return 0;
+
+	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
+	err = mlxsw_sp_pgt_mid_alloc_range(mlxsw_sp, fid_family->pgt_base,
+					   pgt_size);
+	if (err)
+		return err;
+
 	for (i = 0; i < fid_family->nr_flood_tables; i++) {
 		const struct mlxsw_sp_flood_table *flood_table;
-		int err;
 
 		flood_table = &fid_family->flood_tables[i];
 		err = mlxsw_sp_fid_flood_table_init(fid_family, flood_table);
 		if (err)
-			return err;
+			goto err_flood_table_init;
 	}
 
 	return 0;
+
+err_flood_table_init:
+	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, fid_family->pgt_base, pgt_size);
+	return err;
 }
 
 static void
 mlxsw_sp_fid_flood_tables_fini(struct mlxsw_sp_fid_family *fid_family)
 {
-	int i;
+	struct mlxsw_sp *mlxsw_sp = fid_family->mlxsw_sp;
+	u16 pgt_size;
 
-	for (i = 0; i < fid_family->nr_flood_tables; i++) {
-		const struct mlxsw_sp_flood_table *flood_table;
+	if (!fid_family->nr_flood_tables)
+		return;
 
-		flood_table = &fid_family->flood_tables[i];
-		mlxsw_sp_fid_flood_table_fini(fid_family, flood_table);
-	}
+	pgt_size = mlxsw_sp_fid_family_pgt_size(fid_family);
+	mlxsw_sp_pgt_mid_free_range(mlxsw_sp, fid_family->pgt_base, pgt_size);
 }
 
 static int mlxsw_sp_fid_family_register(struct mlxsw_sp *mlxsw_sp,
-- 
2.41.0


