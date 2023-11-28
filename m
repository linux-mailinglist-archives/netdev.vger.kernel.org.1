Return-Path: <netdev+bounces-51746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FE27FBE8E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F40D6B21489
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F03529F;
	Tue, 28 Nov 2023 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOjRK2gy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEA1BC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDiYos6BAREUhgMlXd2XJCRXeYCJwQ5Tv9EHRTV+9R57XcKb3vmBTYwoiNwYjHh4oeDgGU1X/vzmLI4yKl+UqvVEu0MmujC0lg92q72wtes+Bl/zRKA3ZLXXEAE92YORs1DxNqhWcEMMeQOggF+GkfJl5okIL4LYmAwLPeLlwyyaILae5UNCifgIB/KvIau86xPJSkrYUDQZdmhf2HciIebH+GzQDiAr0ShPipCi4HdV7Temzwt/cuxG9cHZFuNc0wt9gfCDGhCmHW6LnNbG6LPGdnfq739HhETbpTt1o2Ekiq62wN/atjvPJoLAjO0MZplx6tQ0zkUaizoMjVTRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ntwomwM7msHSukeINui0NcAxmmuAwX78orhNLuJcb0=;
 b=B3xr9qaohQWuSZSU8LZash9CrQmRvrGH3Q/jgJ43WEU839cXq3dhWB6kOGHkui3pmKjom1lwmNepPdtlJGmb8c42P5tIM4TS8ehNPKlxnOVG+ShzSfyR6WunhMQ0I0me894P4XTuhE+zznilMztJv3BTgQXZvs7e1Ow0WW2+aODf0Zm35STQQEmeQU0oWumJtEj2VsJXqgVaQcfld40iAyRC7/+hHGs2VstqRAE9NuGWSlLzKOJhExmVc3CPfrLXZf8JvO1ixgxhv/9EUl3XCTTeoAGhbNGm2alt0sZ2KbAl39Dl1CQ+uW7MjNxa3kxpcl/5Kump0npKOyBaeqaAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ntwomwM7msHSukeINui0NcAxmmuAwX78orhNLuJcb0=;
 b=FOjRK2gyVW/1CueXFD1TA7NknURg1hhfqxztRs5R2DGr7ql1orxw8cy2j4EgMueR3ph+htbGtOl4grl9bOCSH0bxIDHgBHcYTJVc7j0ZdgfUrdb46CgzkuHAyRxdq3lRNyVD77csijeJlj4IqlQRMmjBqpy514v7QESxrmpZk3W8OqB8uXobXOApfka4b2BFv6vHu5rQ8oDDwHyO3TAFc1KIjzHqOaEI2bmleTwDQb4Mkfi9FxQOtmnQirarDGauNsOuWO6/hEdhoZxrkaQTHnLQsuHmF2D7DNZuWahZkjcbUwm2prembBuKrBILpQjygrE0E/hqA601AA0YoM1Krw==
Received: from DM6PR03CA0046.namprd03.prod.outlook.com (2603:10b6:5:100::23)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:54 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::d9) by DM6PR03CA0046.outlook.office365.com
 (2603:10b6:5:100::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:44 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:41 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 14/17] mlxsw: spectrum_fid: Initialize flood profiles in CFF mode
Date: Tue, 28 Nov 2023 16:50:47 +0100
Message-ID: <2c4733ed72d439444218969c032acad22cd4ed88.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c652b6-cdc6-46fb-4fb5-08dbf029f1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gyF4DHuehU2s5QmjpIbWwGaeXoMScuZ1uFMYhe4J4PIUf1W7yz3hj59ardJFHVzy+sQPukdLMBfi+MF5eYtwL7wBz5IXCB977Es3QKeDXRTmtTsWoWK5k54d1KX+gVX8PqmjKE+jkWd+8tzW9lvrQJuT+XZ0ctyGpvgDSwifNt8yqFAu3vfDAKg7lrK37Jl+UzgbxBFafF0VAEc/KIfFcYjKeYTwuwjhQwGvd6YRZ0MRzQZ87RF6y+Bs1nDe46iJQypDUmPkFbSVRxtkC8AsbdcSnAoWye/hjup5VqIQzfX6k63zofDlTgoxoPoyiiMks05igxYgzRadb1nksD0ofLl2BsoHnxqBj5zwPoYmAikmeYoUessDKFjT4sBzgJrztdEAjcGCjJ6uBYoFb7ycxgRxHrVFk9dBhi/xlF6dz7/AX2SJZqV8To6AqTl8LhrG3JVkwq9yaxch1R3GjLyo9wm+xU74zkTEC49yqXvmbMgPnQiaaKQHOY9HEOxV/5FDUbrOgIWTEC3SQW22GtP5LHGLE1VRhGkFsQlMTrXk2MXdA8JFPIHXgZm56/RkrPuq1esZdtBvPhVB5BA/eZ3SkAS5fUBofwGZnvSPUfVaSl/zitKK9VCOffGuA+9lpFOY9L7HC1CTWtZVTs/E6SoMt7M6Rrcxor6EkHhw/54CKIAwxwtojbYMBIFiDkwf4U1FXnNi3fIznLJVYCSYDXTQagT+qf9OPwUSZHR8E01HwUqOlQQVRgDgYO3XVBn6s1mN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(7636003)(47076005)(356005)(82740400003)(336012)(8936002)(426003)(5660300002)(4326008)(316002)(110136005)(70586007)(70206006)(54906003)(8676002)(36860700001)(478600001)(86362001)(41300700001)(2906002)(36756003)(16526019)(26005)(107886003)(2616005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:54.2070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c652b6-cdc6-46fb-4fb5-08dbf029f1be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924

In CFF flood mode, the way flood vectors are looked up changes: there's a
per-FID PGT base, to which a small offset is added depending on type of
traffic. Thus each FID occupies a small contiguous block of PGT memory,
whereas in the controlled flood mode, flood vectors for a given FID were
spread across the PGT.

Each FID is associated with one of a handful of profiles. The profile and
the traffic type are then used as keys to look up the PGT offset. This
offset is then added to the per-FID PGT base. The profile / type / offset
mapping needs to be configured by the driver, and is only relevant in CFF
flood mode.

In this patch, add the SFFP initialization code. Only initialize the one
profile currently explicitly used. As follow-up patch add more profiles,
this code will pick them up and initialize as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 123 +++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 2d61fb8bff57..8c4377081872 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1633,6 +1633,9 @@ static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_ctl[] = {
 	[MLXSW_SP_FID_TYPE_RFID]	= &mlxsw_sp_fid_rfid_family_ctl,
 };
 
+static const struct mlxsw_sp_fid_family *mlxsw_sp2_fid_family_arr_cff[] = {
+};
+
 static struct mlxsw_sp_fid *mlxsw_sp_fid_lookup(struct mlxsw_sp *mlxsw_sp,
 						enum mlxsw_sp_fid_type type,
 						const void *arg)
@@ -2008,12 +2011,130 @@ const struct mlxsw_sp_fid_core_ops mlxsw_sp1_fid_core_ops = {
 	.fini = mlxsw_sp_fids_fini,
 };
 
+static int mlxsw_sp_fid_check_flood_profile_id(struct mlxsw_sp *mlxsw_sp,
+					       int profile_id)
+{
+	u32 max_profiles;
+
+	if (!MLXSW_CORE_RES_VALID(mlxsw_sp->core, MAX_NVE_FLOOD_PRF))
+		return -EIO;
+
+	max_profiles = MLXSW_CORE_RES_GET(mlxsw_sp->core, MAX_NVE_FLOOD_PRF);
+	if (WARN_ON_ONCE(!profile_id) ||
+	    WARN_ON_ONCE(profile_id >= max_profiles))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+mlxsw_sp2_fids_init_flood_table(struct mlxsw_sp *mlxsw_sp,
+				enum mlxsw_sp_fid_flood_profile_id profile_id,
+				const struct mlxsw_sp_flood_table *flood_table)
+{
+	enum mlxsw_sp_flood_type packet_type = flood_table->packet_type;
+	const int *sfgc_packet_types;
+	int err;
+	int i;
+
+	sfgc_packet_types = mlxsw_sp_packet_type_sfgc_types[packet_type];
+	for (i = 0; i < MLXSW_REG_SFGC_TYPE_MAX; i++) {
+		char sffp_pl[MLXSW_REG_SFFP_LEN];
+
+		if (!sfgc_packet_types[i])
+			continue;
+
+		mlxsw_reg_sffp_pack(sffp_pl, profile_id, i,
+				    flood_table->table_index);
+		err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sffp), sffp_pl);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+mlxsw_sp2_fids_init_flood_profile(struct mlxsw_sp *mlxsw_sp,
+				  const struct mlxsw_sp_fid_flood_profile *
+					flood_profile)
+{
+	int err;
+	int i;
+
+	err = mlxsw_sp_fid_check_flood_profile_id(mlxsw_sp,
+						  flood_profile->profile_id);
+	if (err)
+		return err;
+
+	for (i = 0; i < flood_profile->nr_flood_tables; i++) {
+		const struct mlxsw_sp_flood_table *flood_table;
+
+		flood_table = &flood_profile->flood_tables[i];
+		err = mlxsw_sp2_fids_init_flood_table(mlxsw_sp,
+						      flood_profile->profile_id,
+						      flood_table);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static const
+struct mlxsw_sp_fid_flood_profile *mlxsw_sp_fid_flood_profiles[] = {
+	&mlxsw_sp_fid_8021d_flood_profile,
+};
+
+static int
+mlxsw_sp2_fids_init_flood_profiles(struct mlxsw_sp *mlxsw_sp)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mlxsw_sp_fid_flood_profiles); i++) {
+		const struct mlxsw_sp_fid_flood_profile *flood_profile;
+
+		flood_profile = mlxsw_sp_fid_flood_profiles[i];
+		err = mlxsw_sp2_fids_init_flood_profile(mlxsw_sp,
+							flood_profile);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mlxsw_sp2_fids_init_ctl(struct mlxsw_sp *mlxsw_sp)
 {
 	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp2_fid_family_arr_ctl);
 }
 
+static int mlxsw_sp2_fids_init_cff(struct mlxsw_sp *mlxsw_sp)
+{
+	int err;
+
+	err = mlxsw_sp2_fids_init_flood_profiles(mlxsw_sp);
+	if (err)
+		return err;
+
+	return mlxsw_sp_fids_init(mlxsw_sp, mlxsw_sp2_fid_family_arr_cff);
+}
+
+static int mlxsw_sp2_fids_init(struct mlxsw_sp *mlxsw_sp)
+{
+	switch (mlxsw_core_flood_mode(mlxsw_sp->core)) {
+	case MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CONTROLLED:
+		return mlxsw_sp2_fids_init_ctl(mlxsw_sp);
+	case MLXSW_CMD_MBOX_CONFIG_PROFILE_FLOOD_MODE_CFF:
+		return mlxsw_sp2_fids_init_cff(mlxsw_sp);
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+}
+
 const struct mlxsw_sp_fid_core_ops mlxsw_sp2_fid_core_ops = {
-	.init = mlxsw_sp2_fids_init_ctl,
+	.init = mlxsw_sp2_fids_init,
 	.fini = mlxsw_sp_fids_fini,
 };
-- 
2.41.0


