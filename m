Return-Path: <netdev+bounces-49346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3327F1C62
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F831282744
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072203218C;
	Mon, 20 Nov 2023 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H9yqJ6vt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D72C9
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVIcKydsFEwrDHj46UWuSxoHI6lvIRyPhisWQQmXLWAwUqVpnbkv7Z25r6dk6JALIY4cw04XdnMo8mYjTrO2vxpVipYkQDMHOi332HbfLPsvygqmQ0+Vc1wFlnqelVyqIcotb7Jepci3Fu23tjNfVUmsESXRvYTJAgQ/ptoC5nTA5Mn0P8MyCZXMwewA4Jy8U3hSIaUlKEi2a/ZiEmhcymVow0k/leFDB3BOF3se2kJIzdPQcLQaTrmNPZ47SMFOrXLASuAC7pHcOS+o/HvDOSZrad3qc+vb3F7qdMROxpElZpIDmvIeIsyj/TUjU7jT+XLvlNww8dAnmPurYS1PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gkQXBdyhXkCNtibjUG2Ksq/B4pCIHZgZFyenwsgK5M=;
 b=Rs7VKJkdR46KoAV6lSjZSrI99oYcJfnI2Q7nCx8rKQdW4hX97Wh18E93P+n5YdrNtMiaPynI8AIsvxNOtid3SQ2Fk1jFZQ+o2PXabbhj1D20GrbCbGX5jxXRr1XCC9jtoY+fcJg6/nbuMu7p4YARByfKCmquDmCEcsU5Ywk5jsCDxds3ZHuY9lyEE0es6NflU/adInQ1h7LINIr0n2s2OSpWgi+XuhWQ6YFigT6UnSAuvfcLOlmFlFbJHNrH/nmgZAGaKXEfv4kXY/d1/NXSkGwfJ6rpV+qs+7MB8br1upDWObNu/DZ1Cb1FZO4oYCnzyaTPxuo7Qu/t6mJa+GBd6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gkQXBdyhXkCNtibjUG2Ksq/B4pCIHZgZFyenwsgK5M=;
 b=H9yqJ6vtE0o1xxD3lXxiK5U/7IAMeB0jVOjfQy3S/Xn8CkpyFk5bPe5RzFPZRhN+gCUCebq5LtSOp5gu80SObWbhooobS+mFPPc853e7EvEvsr8IBq0vv9vuRVP2sJGehdxJkd3T9ZO4QEK0N4tNvcK6p26PNehIHxO/fz/3oHFXGhKwYkDTzeZjCSM6QvIGERHfYIAE02Y2rzqEKnGwPnjU4+tnyD3jFDg1l9wMMbaOzqaFVulgEmv0osFW3pywCTfrPjNz0Y7B1c6OB9vOQxIv4xy5Re/Ze+3aMTjDq0X7COQs25YfmNgOLc1EsTxrabgFFmQfGOFQcvo115tYUQ==
Received: from CH0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:610:b0::13)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 18:28:22 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:610:b0:cafe::c0) by CH0PR03CA0008.outlook.office365.com
 (2603:10b6:610:b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 18:28:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:07 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:28:04 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 12/14] mlxsw: spectrum_fid: Extract SFMR packing into a helper
Date: Mon, 20 Nov 2023 19:25:29 +0100
Message-ID: <31f32b4d767183f6cb197148d0792feab2efadba.1700503644.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700503643.git.petrm@nvidia.com>
References: <cover.1700503643.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 678d219d-c4d7-4460-be29-08dbe9f67a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JYoev8ug9mCrAhl0PCQTwYqSqT7ztlT40HBY7RWbQ5NAaUg/bH1/SEsrsy8YfXnUEqRgBj68MpLBF18bJX6Rie3Zedl3ZRN8Lh87GNs4Lc8ZuPy6yC6s9fUEgABiyIWw2UqD9NNgzOkiR2go3pt/PRZoujWhdEXnXYMPJ9J8Lx25QcDT/thcBvk66957P6S3LvoIy/CLFMBidpAbb/vounwEf7d/cuDWjl8VjvTRVLJiO1pLh7pQwuMFWqhmY4sPl1FzU3e7GZRtWJDIXYebWMTMlXxxKv2rfzcCxh5Mbnfhqd3CJYJdVUYqxOghxP3ICMMukz50esQhpXeG6DlXMTly+vs6tQmlZgfT91BAijF/9K/rdJ8w89l92FiG7Ihq99Ols4sLN6MEnz/MszOO+dHVH+VesKLEUvoRK+WFUpieuyayfaLJlae0tmB5Yv81cb1zamQBFYV6x+y6HGA3DJ1qR3afQ5kJ/6XDv7ihBMhlq20NsJ6jnOIdj3772yEIPBfc3eO7BynSaU7sXb3NPk0sGwpFH2/UqaiWXaIHSbdItlptP/9OrdsoXj/GGSew3pQ8xHynJYShg8BAPSK1czJ37zLa1oTTTG6/BtNZVOEEc76tFJJJ0lUrxFrT7HOlo5O54R7iIkdLGaApfISZuD8M6dLmVdvuE74fnuVeWoYBepfUmRDH5iyr+GX9mSlf1trhVdzAVJJBKCaOt0LeaVb6Uvbog1N1jPW42VlqeaE=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(82740400003)(26005)(16526019)(6666004)(83380400001)(426003)(336012)(2616005)(107886003)(54906003)(40480700001)(110136005)(70586007)(478600001)(70206006)(47076005)(36860700001)(7636003)(356005)(316002)(8936002)(4326008)(8676002)(40460700003)(5660300002)(41300700001)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:22.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 678d219d-c4d7-4460-be29-08dbe9f67a16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160

Both mlxsw_sp_fid_op() and mlxsw_sp_fid_edit_op() pack the core of SFMR the
same way. Extract the common code into a helper and call that. Extract out
of that a wrapper that just calls mlxsw_reg_sfmr_pack(), because it will
be useful for the dummy family later on.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_fid.c    | 45 ++++++++++---------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index d7fc579f3b29..aad4bb17dfb1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -424,21 +424,35 @@ static enum mlxsw_reg_sfmr_op mlxsw_sp_sfmr_op(bool valid)
 		       MLXSW_REG_SFMR_OP_DESTROY_FID;
 }
 
+static void mlxsw_sp_fid_pack(char *sfmr_pl,
+			      const struct mlxsw_sp_fid *fid,
+			      enum mlxsw_reg_sfmr_op op)
+{
+	u16 smpe;
+
+	smpe = fid->fid_family->smpe_index_valid ? fid->fid_index : 0;
+
+	mlxsw_reg_sfmr_pack(sfmr_pl, op, fid->fid_index,
+			    fid->fid_family->smpe_index_valid, smpe);
+}
+
+static void mlxsw_sp_fid_pack_ctl(char *sfmr_pl,
+				  const struct mlxsw_sp_fid *fid,
+				  enum mlxsw_reg_sfmr_op op)
+{
+	mlxsw_sp_fid_pack(sfmr_pl, fid, op);
+	mlxsw_reg_sfmr_fid_offset_set(sfmr_pl, fid->fid_offset);
+	mlxsw_reg_sfmr_flood_rsp_set(sfmr_pl, fid->fid_family->flood_rsp);
+	mlxsw_reg_sfmr_flood_bridge_type_set(sfmr_pl,
+					     fid->fid_family->bridge_type);
+}
+
 static int mlxsw_sp_fid_op(const struct mlxsw_sp_fid *fid, bool valid)
 {
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
 	char sfmr_pl[MLXSW_REG_SFMR_LEN];
-	u16 smpe;
-
-	smpe = fid->fid_family->smpe_index_valid ? fid->fid_index : 0;
-
-	mlxsw_reg_sfmr_pack(sfmr_pl, mlxsw_sp_sfmr_op(valid), fid->fid_index,
-			    fid->fid_family->smpe_index_valid, smpe);
-	mlxsw_reg_sfmr_fid_offset_set(sfmr_pl, fid->fid_offset);
-	mlxsw_reg_sfmr_flood_rsp_set(sfmr_pl, fid->fid_family->flood_rsp);
-	mlxsw_reg_sfmr_flood_bridge_type_set(sfmr_pl,
-					     fid->fid_family->bridge_type);
 
+	mlxsw_sp_fid_pack_ctl(sfmr_pl, fid, mlxsw_sp_sfmr_op(valid));
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfmr), sfmr_pl);
 }
 
@@ -447,17 +461,8 @@ static int mlxsw_sp_fid_edit_op(const struct mlxsw_sp_fid *fid,
 {
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
 	char sfmr_pl[MLXSW_REG_SFMR_LEN];
-	u16 smpe;
 
-	smpe = fid->fid_family->smpe_index_valid ? fid->fid_index : 0;
-
-	mlxsw_reg_sfmr_pack(sfmr_pl, MLXSW_REG_SFMR_OP_CREATE_FID,
-			    fid->fid_index,
-			    fid->fid_family->smpe_index_valid, smpe);
-	mlxsw_reg_sfmr_fid_offset_set(sfmr_pl, fid->fid_offset);
-	mlxsw_reg_sfmr_flood_rsp_set(sfmr_pl, fid->fid_family->flood_rsp);
-	mlxsw_reg_sfmr_flood_bridge_type_set(sfmr_pl,
-					     fid->fid_family->bridge_type);
+	mlxsw_sp_fid_pack_ctl(sfmr_pl, fid, MLXSW_REG_SFMR_OP_CREATE_FID);
 	mlxsw_reg_sfmr_vv_set(sfmr_pl, fid->vni_valid);
 	mlxsw_reg_sfmr_vni_set(sfmr_pl, be32_to_cpu(fid->vni));
 	mlxsw_reg_sfmr_vtfp_set(sfmr_pl, fid->nve_flood_index_valid);
-- 
2.41.0


