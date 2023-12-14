Return-Path: <netdev+bounces-57427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E323F813138
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF671F22299
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA535644F;
	Thu, 14 Dec 2023 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eCRBgo4b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D2B9
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:19:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN/mkgVaCm0lwIivWPlqDVi0exb/ZlpH1u4UwcL2FMih+dTNhhBa8gqbqfPVaeRWWMeZ4N36sshL1l4r7f3477WfAF32qENHTsMITGEYlrnamFjOzgzqJ17cMO6c4bURtAUMM35z10xC4m68T7UUSIRRPT94FcfnBatQwxw3Ec6QIcYmhJ6TrQU1ug7FpaUEGQkW5W7QdBidcecfkkz9GEfmnfY+tA0kPpM9kHJAfbqg77eQODR0eWM9vCRlqREpPQyg5cuj4I5UVypD6uTUx/snaDumlt9amr3p9YtP0FYkxz5acHMH3jNEWifCiTPV1l9axtSkSzXvGKdJsALx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYg1bLUv6tqcZq81htXP/JliRQaiURrSmJl79t5YYWE=;
 b=Bq40XDXPnnCdfrDD1Y5VjbaMJ3tuw2xFm9ZKWkq//N9OIGSIaDeAZ1rUkqwhVxAlJn8RofnZ76NQUfTPcSTnqY8gp3q3GkhQ+veu7jUJE0BUCUfQchp9J7Frsn9l5aH6GZnzAvIX5ZSUpVIfZfd5Pc65aZnMyzrjYs/U1Zs8unWaFwQvFYWRJqBqrLrjZ9DmoRvE5LjRaU3Pmsm/i9H69v+nRzr1XpeteTYkCT95B7yT4hJkcA2D5xvnvGlipCd3NdYHITUnERmVXBUqKPWIyME/7DvVjkmzd3adC1OQ1Y7lZoSmlG1ymEe35DPHsZqpzmPDvUS+29OLFWwi0izLxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYg1bLUv6tqcZq81htXP/JliRQaiURrSmJl79t5YYWE=;
 b=eCRBgo4bpYCpK0klvk68j3sf9/bgoKtQCDlRmjdpVQlbyFy+wxb/ohzCRHli7z+rkrWchCq1A4kxSTYAoVYveNPyMoKOTp1Nqy9ecLHmcBtOizpwMpkXjHfP8tVXVAKwxnSrsEvHaDTP2/Oqf3tHAqsfkSOcuS88SBdLXOHcUDQUR5F5aAcicNCa/009XEnxl09dpuFSZltYVFw2l0KMQhVeCYGb0B7PAtLAdlvcgfmo4NhvPOW2w1VmV7Ax24Gq4X52RPtHOzz7No3pWcf4EyjiMT7qAlpvYfj9iNFh1uu2o/01Xd/2KSDnflcpgcch9QmJSkGroupM7p/evaB0oQ==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by CY5PR12MB6082.namprd12.prod.outlook.com (2603:10b6:930:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:19:52 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::61) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Thu, 14 Dec 2023 13:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 13:19:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:36 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 14 Dec
 2023 05:19:33 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/3] mlxsw: spectrum_fid: Set NVE flood profile as part of FID configuration
Date: Thu, 14 Dec 2023 14:19:07 +0100
Message-ID: <35da729781525163c9009c662d61757cef338283.1702557104.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1702557104.git.petrm@nvidia.com>
References: <cover.1702557104.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CY5PR12MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bda9f05-3c32-4841-64ac-08dbfca75b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fTdijEJzRi8eFQceayeyqGdtmEnhJ2xlOoIw6mI1J98y8TLrN/LYWhTntroEBZ+9PSKhNLD7OII6DgAAyNnaB6b5eTwx9MFvTxGL3EVWBSSn+qpwN7bjbJ4tdIgsxmDy/K4soQcKi1jYuFKfX3DqFo1Nryt+DR2neIzQ8AnAEBBWhjSIB7Bt+quLh3Pw8PNWbftpPAzAvgN9E7W+n0FA6hI9Hr1o4MjuQ8x0Mv1PkW6GryWYK8jFtVBnYYvatmQ1rKytcZjD48XpCrS3qAInfZ/j5HssyPVXzQpmE9u2+Cz+z9p3G78Rdbs0z/f0KlBE8HvEbeu0+aitYlQqMv+uIeZVIp3Au6ydtC0Gh/+g7xvulPfMuqcr/w2cYHlp19CQUjF0orsugxQ7QqIWbM11WM29Ex2FSpKo2ytOlfZxXGv+BsC+0KYeH93XqTQYO3bu6YtlsmvbLf5mU+9gYk+tdsZdrsrP08Dgs57tNwRo+oOuhOPg1h8WrTliDMDmVQQ1blmPUhk+cjyXGDoxpSU4A3xPXkEiv3BxL6ui85KvE5JkMNtgwtoMrDX8QyOMSlA+qGoG28aDFpcD+hgN6/pwSuG9L2QykUL8WDopt8EDi5QqHqhzjU13MnSozgTcDYFSMy/9bs7EfFCG7oaLcX7Oi6wa4pIOJfk/pmOLSbsLc2+nJ+P/on3QeeeTt7FAgDi1GF0kYcG8urgLDy2EKRFVFae5fAi3KLzEJ2f+E6SovusJQQjsA16LSLjQtM6wz6t/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(26005)(426003)(336012)(107886003)(2616005)(40460700003)(82740400003)(356005)(86362001)(36756003)(7636003)(47076005)(5660300002)(4326008)(36860700001)(6666004)(70206006)(110136005)(316002)(8676002)(8936002)(54906003)(41300700001)(2906002)(478600001)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:19:52.5123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bda9f05-3c32-4841-64ac-08dbfca75b61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6082

The NVE flood profile is used for determining of offset applied to KVD
address for NVE flood. We currently do not set it, leaving it at the
default value of 0. That is not an issue: all the traffic-type-to-offset
mappings (as configured by SFFP) default to offset of 0. This is what we
need anyway, as mlxsw only allocates a single KVD entry for NVE underlay.

The field is only relevant on Spectrum-2 and above. So to be fully
consistent, we should split the existing controlled ops to Spectrum-1 and
Spectrum>1 variants, with only the latter setting the field. But that seems
like a lot of overhead for a single field whose meaning is "everything is
the default". So instead pretend that the NVE flood profile does not exist
in the controlled flood mode, like we have so far, and only set it when
flood mode is CFF.

Setting this at all serves dual purpose. First, it is now clear which
profile belongs to NVE, because in the CFF mode, we have multiple users.
This should prevent bugs in flood profile management. Second, using
specifically non-zero value means there will be no valid uses of the
profile 0, which we can therefore use as a sentinel.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 379a911f463f..65562ab208b3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -117,6 +117,7 @@ struct mlxsw_sp_fid_ops {
 enum mlxsw_sp_fid_flood_profile_id {
 	MLXSW_SP_FID_FLOOD_PROFILE_ID_BRIDGE = 1,
 	MLXSW_SP_FID_FLOOD_PROFILE_ID_RSP,
+	MLXSW_SP_FID_FLOOD_PROFILE_ID_NVE,
 };
 
 struct mlxsw_sp_fid_flood_profile {
@@ -560,6 +561,8 @@ static void mlxsw_sp_fid_fid_pack_cff(char *sfmr_pl,
 	mlxsw_reg_sfmr_cff_mid_base_set(sfmr_pl, pgt_base);
 	mlxsw_reg_sfmr_cff_prf_id_set(sfmr_pl,
 				      fid_family->flood_profile->profile_id);
+	mlxsw_reg_sfmr_nve_flood_prf_id_set(sfmr_pl,
+					    MLXSW_SP_FID_FLOOD_PROFILE_ID_NVE);
 }
 
 static u16 mlxsw_sp_fid_rfid_fid_offset_cff(struct mlxsw_sp *mlxsw_sp,
@@ -1321,6 +1324,20 @@ struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_rsp_flood_profile_cff = {
 	.profile_id		= MLXSW_SP_FID_FLOOD_PROFILE_ID_RSP,
 };
 
+static const struct mlxsw_sp_flood_table mlxsw_sp_fid_nve_flood_tables_cff[] = {
+	{
+		.packet_type	= MLXSW_SP_FLOOD_TYPE_ANY,
+		.table_index	= 0,
+	},
+};
+
+static const
+struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_nve_flood_profile_cff = {
+	.flood_tables		= mlxsw_sp_fid_nve_flood_tables_cff,
+	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_nve_flood_tables_cff),
+	.profile_id		= MLXSW_SP_FID_FLOOD_PROFILE_ID_NVE,
+};
+
 static bool
 mlxsw_sp_fid_8021q_compare(const struct mlxsw_sp_fid *fid, const void *arg)
 {
@@ -2422,6 +2439,7 @@ static const
 struct mlxsw_sp_fid_flood_profile *mlxsw_sp_fid_flood_profiles[] = {
 	&mlxsw_sp_fid_8021d_flood_profile,
 	&mlxsw_sp_fid_rsp_flood_profile_cff,
+	&mlxsw_sp_fid_nve_flood_profile_cff,
 };
 
 static int
-- 
2.41.0


