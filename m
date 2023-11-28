Return-Path: <netdev+bounces-51747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830D57FBE8F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 362F128233F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C1235286;
	Tue, 28 Nov 2023 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Qun4BGv1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF510E6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:52:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btjHfT3BKxSKJSpinJgsaFHw4bQUsCJ+XiwO6I9Dh2yYQX+Sa4jmsv9LxDYc5hRuDGwmTBnzXTjOv6ORRvEP97aduV1I4ZG0rUg55QLsoSLipgyXCy0XrJOUuxwEMYV8hWS5M5Y116VEy5kNnqGHgC2Hf01KKM1cUHTVlpMYlxvwgOiJYvWlLCkP8jUSSxtnhvOljAP1B7TL71cUt0iNLI4uNYsF7+rZKBV1G6sBHu+H3cpMj1Y/zlx6uh0x/Nkw2kiTNEvwVup2tO3MprzSWUErVtxHtn13i6QTevgLYxYlcU9UrlVeZVDbdfcgwnWhw0cC1W0N1tEp9YFwblHNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbvQRkQpSxIZkuu9qLPyFBg7kRY4ichvHz6OQ9ajcDo=;
 b=Cp4ZUaN+fu8GIKJWaeoABIbTc2bpBPjqS8pOb/scGqymxZgEcaNirusr1GcmsA73vK1NbEtDbuICF+YH22EKlkogZrcFOteNNpGRP9MNBKii0oPvdqaGWEWI9cCXZv3MO6wvYMW6NpPVp9q5bCmvGaw+1T1UKOGpS3eulcbbBRB81uqwVoG7SfzN0Ldw5EiRBeK1zgZzfOA798MMcLZUtFpikQKEDqm3FiSDvAJwIGJ3XmwwUbOmtBfqoW3gVG4VY0rks58SmgcrLGvzIa0ZgU12AbQl1nCHMJ7dbgAFqZBWyyrUEoA71NEKreP5kObuhxXTp8bSI+xNdYtzYEFivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbvQRkQpSxIZkuu9qLPyFBg7kRY4ichvHz6OQ9ajcDo=;
 b=Qun4BGv1WJsRu7FqEbjTe8IkYz5XXCAUPWuOXZyIcY6VW0GvTqBXtIy45LC1F2jE83QxQh0J7KVa9PeKiatDTTPrTW0k5iDEcOqPHtulbeizI0GeB36ZSZjXQP4LS7lqWQvqnA8+j0zGwDVCkoR9oqT/OD8oEnLFgKHmuKxO9SYHwcRhJddGHWZk4GHZzk3ti6GkUGwtI+Kz71f7faR0a0Bd/wY5bCwSn7u36vR9kQcOSmbcDrmlMn2RzCEp2q5Mhr4wxq9EXYRXTXLAaKGzYFKV+vHJIbCGmMIW05GE47WKk05RCm5oWDFcaS9oxb83JojIO6iNxCeaMO4Ymf1nqQ==
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 15:51:59 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::63) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:41 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:38 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 13/17] mlxsw: spectrum_fid: Add profile_id to flood profile
Date: Tue, 28 Nov 2023 16:50:46 +0100
Message-ID: <19ea9c35ba8b522fa5f7eb6fd7bc1b68f0f66b41.1701183892.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: c540e512-0540-4439-6bc6-08dbf029f4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9ip8n4dK/InLOv1B2hh0imFPAat5BJ3gtnjjubrigIj8d4PIOWLqvDxYGV2ZXJKkd/wjz6f1HHj9FJfXvQBPv/XJm1Se3g0TAJyY+NBpnIfDAqGYCe/tbdUftVrsd3D27bZNcFnstxwMiZXF1kVcqY75+rwfwEcE2OxasTOcgAKsATk9rYP7paw6wE5KXmyuIVzIgTIhGCyWcF+q6vZVwAm3NVvGSIYqWU4K424nHrM+iM8nHqxfvy+ikU6FX4jhR99bvNnWUmWtRspZGRC0GddjoYZMCi81FrzwEbIsHhqZnjdRDquQzkzNAJJTo/tI66H+9ZKWQiEF2jeYheVgMJSARXOhBQW2YKFbboOI0xbPwWqa02u1fAVYWogEsNdy2JilthNg0Ux006+gki1hKqjZBceVV6sU/rmXhV0GZQWJpmUeItXtr73gmZOnYqhekvpdeVlpj6ojf0CkN9S5/ozKzM7CCK12GnPpJCXQgD6VeKnQweA9uGfq2izxfiv4wrSXL4CXA7sDhPWAH7Toz6dAPIQK44m34ruQAFMIeEKhJSJilD9as0rnua1scudm9oo0V+QL5mF2brQm7iy0uhUzSdFsf7pw/1C4YSuXxtVsA7Ov0HjXvxRTa3nFD4X78t/Cwp/y4B6p+BRpsDdxTQjJq77GPG5HQIG4cAofbC8tw2cWIUagnM+9I2+Xpk7nKfy1NYAtxOb3znORgpLFhtE5ZjXT148FWzDRjRJfbahkAcEvFsz6s71GNPLmk2Q5
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(8936002)(8676002)(4326008)(54906003)(110136005)(70586007)(70206006)(316002)(478600001)(40460700003)(47076005)(36860700001)(7636003)(356005)(36756003)(41300700001)(86362001)(107886003)(16526019)(26005)(40480700001)(2906002)(2616005)(426003)(336012)(5660300002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:59.1057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c540e512-0540-4439-6bc6-08dbf029f4a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211

In the CFF mode, flood profiles are identified by a unique numerical
identifier. This is used for configuration of FIDs and for configuration of
traffic-type to PGT offset rules. In both cases, the numerical identifier
serves as a handle for the flood profile. Add the identifier to the flood
profile structure.

There is currently only one flood profile in use explicitly, the one used
for all bridging. Eventually three will be necessary in total: one for
bridges, one for rFIDs, one for NVE underlay. A total of four profiles
are supported by the HW. Start allocating at 1, because 0 is currently
used for underlay NVE flood.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index af460a0d030b..2d61fb8bff57 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -113,9 +113,14 @@ struct mlxsw_sp_fid_ops {
 			      const struct mlxsw_sp_port *mlxsw_sp_port);
 };
 
+enum mlxsw_sp_fid_flood_profile_id {
+	MLXSW_SP_FID_FLOOD_PROFILE_ID_BRIDGE = 1,
+};
+
 struct mlxsw_sp_fid_flood_profile {
 	const struct mlxsw_sp_flood_table *flood_tables;
 	int nr_flood_tables;
+	const enum mlxsw_sp_fid_flood_profile_id profile_id; /* For CFF mode. */
 };
 
 struct mlxsw_sp_fid_family {
@@ -1188,6 +1193,7 @@ static const
 struct mlxsw_sp_fid_flood_profile mlxsw_sp_fid_8021d_flood_profile = {
 	.flood_tables		= mlxsw_sp_fid_8021d_flood_tables,
 	.nr_flood_tables	= ARRAY_SIZE(mlxsw_sp_fid_8021d_flood_tables),
+	.profile_id		= MLXSW_SP_FID_FLOOD_PROFILE_ID_BRIDGE,
 };
 
 static bool
-- 
2.41.0


