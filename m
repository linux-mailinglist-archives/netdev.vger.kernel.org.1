Return-Path: <netdev+bounces-49341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEAF7F1C5D
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A45A1C214A1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 18:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4330CF1;
	Mon, 20 Nov 2023 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q7e3mmFX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ACF92
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:28:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XshxZJgalg1V9F6FPbIuXqMWTb+/Ey6wt/IK9jn/OO5svHaPtF+RonVt/9CP2skgl8M0LAsfbnrJK8mwVdJjgSEPep2WONMip+x/pGYCZO41qmjFkndqJCXlyV0H2ymmjeoLm7wGANNW63GTmSNP3vyd4G6tI4S2M2Nne0WfBWlbXyb7A8DflGuVI1TDiM2YGh6vnRG8AZY5UPN6L3XewITkv3IZfw5sz7BvrNr2azpwfFPLfwgH2IJkIWsCNwuFtI/7OZ0xx1OQZzL4FM0bCIamyO/u6bfzR/DNYwLZBH1VZqYPxt9VeZxx7vn9TYnB4wkLHXh0WTqZVndJ0p4pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX7flRyN+RulzUOBZFDd9VGbIIKA+ltkiBM6BHloBs0=;
 b=Xgmin/V82AI9rX08UvSrkmu84yuRgIy2473/M+7PtzIbfxyk6ZqPzUeyyVXnAV+prIUuaiZkyIusgLJhl9JLR4O+SiiQQMkF502lOp/3EfsnDc2iVdRCC3reUQMUtdBKmSrEzILHM33MJp+AN2u2Q4BOmQLiNHhg0HHzInWj1vq5PdZvJ/68pPsYQSLH6ZSNIlBkIFJAdJzZoPLmzVJezAgL848K2489j0r0nlVgmFiqGnNin2ecbbJlXs3ROan60aP7H+OIX98hdwKwlwvEocnlzOfC2IeHhsx+pUNKfxekT+blx58+5R3kA/NHmI4LPWXHx57tY+tGV+tBzVZxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX7flRyN+RulzUOBZFDd9VGbIIKA+ltkiBM6BHloBs0=;
 b=Q7e3mmFXCQd8GDAiLpn19XA15+hP3St16/JkzvXb2lN88JP6PBkYxTucA055i6cAurAuE61Vhoqn+e+rcDv9RGonzHdkX0+rCbG9LY7yQGvpxvJp0ODCncMmnm8nB3qOZEqob7w1EP6qV3KEiW9zXctMv++8xmW5VyQBvrjAJXJPvJukZuxsVgE4AxWnn6OTPN1lF9gGcpXiHqwNRPBiZVQa7AqKDiOobb62+F2wNkmHMhQOwmapt7vpxY/1a4ei3qIyUy9nW8epjxz5tSqxt1IVXYaPpHEBp0bwu5huha99CKAD5I+a+pxal1aSsuiC14ljAhx+P8+qoL8v6er+4Q==
Received: from DM6PR13CA0021.namprd13.prod.outlook.com (2603:10b6:5:bc::34) by
 SA0PR12MB4589.namprd12.prod.outlook.com (2603:10b6:806:92::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.27; Mon, 20 Nov 2023 18:28:06 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:bc:cafe::22) by DM6PR13CA0021.outlook.office365.com
 (2603:10b6:5:bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 18:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.13 via Frontend Transport; Mon, 20 Nov 2023 18:28:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:50 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 10:27:47 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/14] mlxsw: reg: Extract flood-mode specific part of mlxsw_reg_sfmr_pack()
Date: Mon, 20 Nov 2023 19:25:24 +0100
Message-ID: <6f29639ebc3ca0722272e6c644ca910096469413.1700503644.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SA0PR12MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c75fdc6-e883-41ef-7d32-08dbe9f67069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XOEOYc85K2xEEe/t3SAM4YqDslBFEUqjI0sjj3ow3hE+Iq53bKER7LEwJcDN7lm/hP6IbensKTBRWg+p+nnrZ5gBw83eIIrfjTyCXgRG0Kn8sMRvGoBxToDGyeLMl+AkFu+PKjEbFVPvlI3eIpmnITvw4kieovqljtgN0ymcdkw5XeGOCIVS3YfNMSni4+sMjbmM7FHlbi5VPdjkSYN7d1VTX1Eem4ItVbIiJoPVZY09EF+0R4HrcmPxy/k6uSFGwuBB1yMLizhHF1zBffvoFr5xX4QxP53ZeuJ+Ko9+zDqYxg3s6q2cPjCIHsyRgmEcR3yOLIh+QBDGT9SKRvhGzhahju7mKPANlpt1pibrasysLWkVvIZ4JP3c5Ve1KtMaWiJfvIl09ZMUYd8QmFboYf58SkKQ4wk08uL1L/sqANP+5QE02EfCvEQDK0zCQB8G/TRL1WevSqQ2Yt6xSWlI28VFgy4RwR15laihnirt0yFaS+hIrqGplV08ChMaoQNBvorXa1sG4oOBGshWiazcTwcdQs2+ODFtptXxEKidMH8XtAQZJp+WYCTOqbVg6hI2mle6xrgLyDz3Xd65YgUznuKW/fNSwWUhswz2hEhyiI7ElLhxc8VbNG7woKeqh73AzsUO6m/IaO+gdzwL2IO2KkynyfWZfZAn+ybDExOI4d2YVXa4aWQOnHY6X/VvN6v1vFeedBRbVQ65SzzU+AlEhqLsK8Uzu2m1EUq0fnBpSwQ=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(26005)(40460700003)(16526019)(70586007)(107886003)(83380400001)(54906003)(316002)(70206006)(110136005)(336012)(426003)(86362001)(5660300002)(2906002)(36860700001)(47076005)(478600001)(36756003)(82740400003)(356005)(7636003)(41300700001)(6666004)(2616005)(40480700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 18:28:05.8682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c75fdc6-e883-41ef-7d32-08dbe9f67069
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4589

In CFF mode, it is necessary to set a different set of SFMR fields. Leave
in mlxsw_reg_sfmr_pack() only the common bits, and move the parts relevant
to controlled flood mode directly to the call site.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h         |  5 -----
 .../net/ethernet/mellanox/mlxsw/spectrum_fid.c    | 15 ++++++++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index e8f7a4741bd3..bd709f7fcae1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1965,16 +1965,11 @@ MLXSW_ITEM32(reg, sfmr, smpe, 0x28, 0, 16);
 
 static inline void mlxsw_reg_sfmr_pack(char *payload,
 				       enum mlxsw_reg_sfmr_op op, u16 fid,
-				       u16 fid_offset, bool flood_rsp,
-				       enum mlxsw_reg_bridge_type bridge_type,
 				       bool smpe_valid, u16 smpe)
 {
 	MLXSW_REG_ZERO(sfmr, payload);
 	mlxsw_reg_sfmr_op_set(payload, op);
 	mlxsw_reg_sfmr_fid_set(payload, fid);
-	mlxsw_reg_sfmr_fid_offset_set(payload, fid_offset);
-	mlxsw_reg_sfmr_flood_rsp_set(payload, flood_rsp);
-	mlxsw_reg_sfmr_flood_bridge_type_set(payload, bridge_type);
 	mlxsw_reg_sfmr_smpe_valid_set(payload, smpe_valid);
 	mlxsw_reg_sfmr_smpe_set(payload, smpe);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index e954b8cd2ee8..6a509913bdc7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -433,9 +433,12 @@ static int mlxsw_sp_fid_op(const struct mlxsw_sp_fid *fid, bool valid)
 	smpe = fid->fid_family->smpe_index_valid ? fid->fid_index : 0;
 
 	mlxsw_reg_sfmr_pack(sfmr_pl, mlxsw_sp_sfmr_op(valid), fid->fid_index,
-			    fid->fid_offset, fid->fid_family->flood_rsp,
-			    fid->fid_family->bridge_type,
 			    fid->fid_family->smpe_index_valid, smpe);
+	mlxsw_reg_sfmr_fid_offset_set(sfmr_pl, fid->fid_offset);
+	mlxsw_reg_sfmr_flood_rsp_set(sfmr_pl, fid->fid_family->flood_rsp);
+	mlxsw_reg_sfmr_flood_bridge_type_set(sfmr_pl,
+					     fid->fid_family->bridge_type);
+
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sfmr), sfmr_pl);
 }
 
@@ -449,10 +452,12 @@ static int mlxsw_sp_fid_edit_op(const struct mlxsw_sp_fid *fid,
 	smpe = fid->fid_family->smpe_index_valid ? fid->fid_index : 0;
 
 	mlxsw_reg_sfmr_pack(sfmr_pl, MLXSW_REG_SFMR_OP_CREATE_FID,
-			    fid->fid_index, fid->fid_offset,
-			    fid->fid_family->flood_rsp,
-			    fid->fid_family->bridge_type,
+			    fid->fid_index,
 			    fid->fid_family->smpe_index_valid, smpe);
+	mlxsw_reg_sfmr_fid_offset_set(sfmr_pl, fid->fid_offset);
+	mlxsw_reg_sfmr_flood_rsp_set(sfmr_pl, fid->fid_family->flood_rsp);
+	mlxsw_reg_sfmr_flood_bridge_type_set(sfmr_pl,
+					     fid->fid_family->bridge_type);
 	mlxsw_reg_sfmr_vv_set(sfmr_pl, fid->vni_valid);
 	mlxsw_reg_sfmr_vni_set(sfmr_pl, be32_to_cpu(fid->vni));
 	mlxsw_reg_sfmr_vtfp_set(sfmr_pl, fid->nve_flood_index_valid);
-- 
2.41.0


