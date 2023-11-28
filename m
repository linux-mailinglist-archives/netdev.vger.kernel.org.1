Return-Path: <netdev+bounces-51743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249367FBE89
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164EF1C20C45
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9C3528C;
	Tue, 28 Nov 2023 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rRt6E/xw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08B1BE
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itnCHEGNMZKmePAh24gQ+Svi997GSLw5dGAvHJODKFrbsFHduhaN+efSBxrzOgKhgYn0cnyGs2kIxVCbjdxxgrJ06EFo5H0kJ7Nc4KJPetZXgIE1sGTfwltvLMEIpBZFrZHVyxefa2ralTfx43qpbcUbsocGuKnRKAYV2r7aE1XIp1juhCTZG+aogqY/wK8if28mGF0FanHaKjuJfVBhUVTuU+g1P7a0eTLlvLJ/hIAv+6h79iOtYx463JJe2cvHY/exNbe+UXcBcypGIjTA6u7Ox6PHvIsj75nImmvOK9uYRsEuuZF30xX9LBIoFHpROlj5PdQA0Af5KzqKYx9ipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7qR8yDiynU+MVtchJr8pi12L5CtXlr/nfE3crMCyMk=;
 b=dbg+s95aFOLcQSMSfR6vuuTURJUhc63K7vCA7dLWznLfi4vKTx1hzIQo6wpZftkqjyiILgRSUQF1Z8HJ6QWPJk51D8WbZP05W0LBT7oSF8Hc0CH6YhihmU4TNaWEnAKSKsQ4HHg048s/l+0620mgrbw2gAG/DWT/ZdK7z5h7kZXUcNwAWdzh0HSW+X7kRU23rPv2aN1n3f+z0cTL9G+eqPJqXJbKkmcLW8F2jlGclrghBznYJx+3hQJ8g2lKpvNQekZBK8JwXeHuNGuo0PyPCs01wXnYQBJwLIEr8MFOTQPeJ6j6gVppw2SYAYpOmv+GAa1xZOMTiAZov2HACIOLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7qR8yDiynU+MVtchJr8pi12L5CtXlr/nfE3crMCyMk=;
 b=rRt6E/xw5rDKd/JA8Ees3Uz6BtKfPnQzxWDdv3BTP3iqLsJoIgZmzGLhrUH0OC9q1GYTJE3ohzyuCW8C8hVW/N+uZurVh7x/gCVnHYgk1z5X61nWtvweTvRgraDDI8hMtqAuI0xK9FiTQ+Z4ZZREXdAVWTbgcg6hOndVuNXk7vClSOmlJYO++iisuodYCrc11xP4Mv//fIFAfWizSsxIA+SZ290zHnvN9tSfObvefjLwaCjH/9PmDVnsaEwHwnhPnoPsZytD3kQBQE3zwXXrDxSmhV/zd40x+sntnEZXJWzZAKFyJi2EAV6Ze28n6bAao3IoVFg+yzwxY3VNgDywkQ==
Received: from MW4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:303:b7::15)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 15:51:48 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::14) by MW4PR03CA0100.outlook.office365.com
 (2603:10b6:303:b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:31 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:28 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/17] mlxsw: spectrum_fid: Add an op for packing SFMR
Date: Tue, 28 Nov 2023 16:50:42 +0100
Message-ID: <f12fe7879a7086ee86343ee4db02c859f78f0534.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 552e08bf-c9e0-49f4-9297-08dbf029ee16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tl47TF+3FL1x5lMBrhjQR91YlLfBSZtcVJ7hxdqID0IgNEgzQny6ailRfcvkeRfZMniWPgX3hwd8g0OC63QplLGD6MQsFdtlHc73smpDyATZYw79EFEygq2rTWK4K8spk6BMYtP8miCl6foyD1tTNytomC+QP0i3Z7aT/vB8TXyf5UEQOTrJgqS8lICYLUWrYPDTfmXPgfC41iqEYxy5/n+thklsJ1eXpBxujaHsnJaCAjRL5tvB9mKwEF7zOL7R6QWgR4FXAjrq8qBYJodt0DtYRyG1ygBEjNd59AXQOQORmk5H+h67CCkYXOyEBDC5BSbn7vGUPxXwlxEULditHGEQzClUqGbXgk9hQj999ZoX52M3JBakqBX9oW/F1HAaM8f2QXSzqFzW9VLisUsVq13ZR3JSMjygY5sb+qBqcIei6iWjAGktbYxmIBxq4KA6CXOIGnxxHdTxQBCA5DywDkGiHcWJJTfPaGxWKn5gaxVTz3alug79SA0qb88AviIwYdIXa4AKMbG3+JSwPWDXz7QpPkYXpB5XSBuGmVse47NhHjWDb4Qoz54+6rKd+mdmA6dKGXgg5ahzzLpdaraxsId1bFljnrEM1EErou9eSpmRTCQJ7UDHYLcvM9z/b6ieHpc0xiEvpKnfs1JptEH4V3lU5rcfzw+jEbyF5x4lK1JxlCkC/dWzpinRL0f8RofwWeeHTSl2NmLhyjfAHJZGFMY3JK6Q8dPIx8zrb831m90mpTBxFzn6E0RiZpmXr5JH
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(107886003)(2616005)(26005)(16526019)(6666004)(336012)(426003)(8676002)(8936002)(4326008)(82740400003)(5660300002)(86362001)(478600001)(316002)(70586007)(70206006)(110136005)(54906003)(36860700001)(83380400001)(7636003)(356005)(47076005)(36756003)(40480700001)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:48.0901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552e08bf-c9e0-49f4-9297-08dbf029ee16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

The way SFMR is packed differs between the controlled and CFF flood modes.
Add an op to dispatch it dynamically.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index c3f4ce3cf4e7..223716c51401 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -101,6 +101,8 @@ struct mlxsw_sp_fid_ops {
 			u16 *p_pgt_size);
 	u16 (*fid_mid)(const struct mlxsw_sp_fid *fid,
 		       const struct mlxsw_sp_flood_table *flood_table);
+	void (*fid_pack)(char *sfmr_pl, const struct mlxsw_sp_fid *fid,
+			 enum mlxsw_reg_sfmr_op op);
 };
 
 struct mlxsw_sp_fid_family {
@@ -466,7 +468,8 @@ static int mlxsw_sp_fid_op(const struct mlxsw_sp_fid *fid, bool valid)
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
 	char sfmr_pl[MLXSW_REG_SFMR_LEN];
 
-	mlxsw_sp_fid_pack_ctl(sfmr_pl, fid, mlxsw_sp_sfmr_op(valid));
+	fid->fid_family->ops->fid_pack(sfmr_pl, fid,
+				       mlxsw_sp_sfmr_op(valid));
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfmr), sfmr_pl);
 }
 
@@ -476,7 +479,9 @@ static int mlxsw_sp_fid_edit_op(const struct mlxsw_sp_fid *fid,
 	struct mlxsw_sp *mlxsw_sp = fid->fid_family->mlxsw_sp;
 	char sfmr_pl[MLXSW_REG_SFMR_LEN];
 
-	mlxsw_sp_fid_pack_ctl(sfmr_pl, fid, MLXSW_REG_SFMR_OP_CREATE_FID);
+	fid->fid_family->ops->fid_pack(sfmr_pl, fid,
+				       MLXSW_REG_SFMR_OP_CREATE_FID);
+
 	mlxsw_reg_sfmr_vv_set(sfmr_pl, fid->vni_valid);
 	mlxsw_reg_sfmr_vni_set(sfmr_pl, be32_to_cpu(fid->vni));
 	mlxsw_reg_sfmr_vtfp_set(sfmr_pl, fid->nve_flood_index_valid);
@@ -1130,6 +1135,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021d_ops_ctl = {
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
 	.fid_mid		= mlxsw_sp_fid_fid_mid_ctl,
+	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
 #define MLXSW_SP_FID_8021Q_MAX (VLAN_N_VID - 2)
@@ -1312,6 +1318,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_rfid_ops_ctl = {
 	.nve_flood_index_set	= mlxsw_sp_fid_rfid_nve_flood_index_set,
 	.nve_flood_index_clear	= mlxsw_sp_fid_rfid_nve_flood_index_clear,
 	.vid_to_fid_rif_update  = mlxsw_sp_fid_rfid_vid_to_fid_rif_update,
+	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
 static int mlxsw_sp_fid_dummy_setup(struct mlxsw_sp_fid *fid, const void *arg)
@@ -1374,6 +1381,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_dummy_ops = {
 	.vni_clear		= mlxsw_sp_fid_dummy_vni_clear,
 	.nve_flood_index_set	= mlxsw_sp_fid_dummy_nve_flood_index_set,
 	.nve_flood_index_clear	= mlxsw_sp_fid_dummy_nve_flood_index_clear,
+	.fid_pack		= mlxsw_sp_fid_pack,
 };
 
 static int mlxsw_sp_fid_8021q_configure(struct mlxsw_sp_fid *fid)
@@ -1474,6 +1482,7 @@ static const struct mlxsw_sp_fid_ops mlxsw_sp_fid_8021q_ops_ctl = {
 	.flood_table_init	= mlxsw_sp_fid_flood_table_init_ctl,
 	.pgt_size		= mlxsw_sp_fid_8021d_pgt_size,
 	.fid_mid		= mlxsw_sp_fid_fid_mid_ctl,
+	.fid_pack		= mlxsw_sp_fid_pack_ctl,
 };
 
 /* There are 4K-2 802.1Q FIDs */
-- 
2.41.0


