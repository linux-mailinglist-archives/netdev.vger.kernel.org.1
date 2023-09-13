Return-Path: <netdev+bounces-33620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66C79EEBC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CC82822A3
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF2C8CF;
	Wed, 13 Sep 2023 16:41:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659B7494
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:41:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA0F4C1D
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efGvdhb42qKSGdXyatqqT6PQEenSkgUhuNrsZG2dCqEqwEp8nFLHzjSyO8qG0DFFLkPNkqHHUQfC0bOxKn5HahwZ+UvslqWnJPpMMFW+vP1z1CYxVLK9qnHwcfyehqbH67IakgQMKMRQkSEntsvIbDfevQnNXYKYf2R9+Exancp+ZR37Hpv+b5Xqn2YwoO24f9woEhqQHKrVaKugGpPpnb7RcTt1Y8r4mZHC1l78n+ExEQbVW+cOC0jM0bFkhDhmHjG81FKJEXLrZlukVixJN5ir/OzMxHQsx3TIRrmF5T0WlMfwRxcouZjTFSquBeexs9QgBbR67VjMwS9bwaJV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3khkxnLvcG9inlC0f3SUwzk4ZDaK6QYGCT3u2iI631o=;
 b=kEX145MUpSCkqpd6w09cOW0dRT4jt2oGMxncNew+TyGnUrZZn1Xea+SVkko5GAjMOV4iZY5iDWiLso036S/iXvl46LkU0iPo2XTbcl5dXGfLH9guXLPn7SoHb1a1g/8ekPSu/nAwC1MYXfiufhR1WQv8qtSRzc0gM1mYEUriLV7/mxefavuyLVJFt6P5zLChRUPnQJnI5EEz5qv2+TGLvlMqBe5q7idND8zuDJ8hwpLCzBexRWDbuu5hZkzAvwslZtkMqbBwXw+wATvJ0ko6quk7zkK66HsjO4rprVvipmMPIKuOsCpXklw9497mW6DnpQ6Fxj612dU2pwdAOiSyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3khkxnLvcG9inlC0f3SUwzk4ZDaK6QYGCT3u2iI631o=;
 b=OShB80UnuuC6QPcGl7DCh7v4KMuLX9orKFo4C7u53iBzHZef2E7tDqz1mwO7asVW7cU7EXCT9NVz9PyBXLgP+e0iffQ5Vv75RA0dH0CdPbf/c4OuFY2QkFc7ZorfRXwDL6vBAKp8bO7u/etnOOYdo/7BjJEo/JCWhHmDSBWLHoncSfL/I+DKsr9quCjx8a30xn/c/UBa+W9fDp/leXpBSpafmTfJmUznnvVyXq5uXO8eOSlObg89uW9Q4Znpcu3XKDASJU6FoFwrzV8ZYa3vYdUGcGWzj/BcwgFMbA5MMnttSnnCCZM0yDVHRV3Rku55ulZ5l2ngq7fv2VerT9tpXw==
Received: from DM6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:5:190::29)
 by BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Wed, 13 Sep
 2023 16:41:19 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::71) by DM6PR11CA0016.outlook.office365.com
 (2603:10b6:5:190::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 16:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 16:41:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 09:41:09 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:41:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/3] mlxsw: Add 'ipv4_5' flex key
Date: Wed, 13 Sep 2023 18:40:45 +0200
Message-ID: <606e6d0d348740670437b12bb540db9b27f1de2e.1694621836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694621836.git.petrm@nvidia.com>
References: <cover.1694621836.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BN9PR12MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: 767b6a2d-18cc-4c26-12c2-08dbb4784118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	feQUFzLnObmU8/DmQdYPFTvxFKUR1tDWUa3S0aEtgMTWwfxN8UhydGtUVD8t/qf+QG/5pEfr8fXtoILhmqUbVVP60fe4RogpPLqhJhuXhAaDT8lcJHFAPtjwdRSGhsYZ41wqi29SynuNi6pYEhI8o/31XFi8f+OE/fFs5V/UrUg6xcJLR7TDjrLJzMre/lR5f8rM1NZJUQFJuqqd5uLs8/nLLFU4yesz2viER5W8wd4T+HrfqYsPaCyaQvHoTaxAXVpGOXeNbhp1R8bPvUiJYvr88LypHqCVY00iBjGKRd9dldBx3hr5dDaP6s857Km8fxz6/yC/ARUmWB9SIJJtoVwMjVsMLcl44S+h25qtLuiCeRCYCcAMSWj3I0/ycBrlrLFJTi4/YMYQ5JRRT/jnNDCCSy03FKG0/ZjB6nUS+4akXnds5qhpcQD4PWiqEXbJ2AcUC/Ii7Hh4pvMJwUt1AHi8tbJUH2VQbPUxXPa8gtzt34k5adcCftdDxyF0cBrm5zX2BTxVXM71UZLY4QjbRMi0SLp0EK/+i/CPFphbORSgf0DkTinRS6P9U1l3oYCFTlQFJLF226w5IoBCJguXExTq9oIyhH5GWMjcJEgciXBYDvaWzwmfwSkNG+bftDl9TtzrJ3An/s7YstVu+y3JceynJviAE2TiBtuWL8zL56Oc2YFKIkQ06XULypryWUD26vc256NiLv+xiWeZYbQoqWtWJ/N2scmYWP1TVbDQSci5nnuH32FTi9Vh5iOjUCVX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(36756003)(36860700001)(86362001)(40480700001)(40460700003)(7636003)(356005)(82740400003)(478600001)(70206006)(316002)(54906003)(70586007)(110136005)(2906002)(7696005)(6666004)(8676002)(4326008)(8936002)(5660300002)(41300700001)(83380400001)(47076005)(66574015)(16526019)(26005)(336012)(426003)(2616005)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:41:18.2822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 767b6a2d-18cc-4c26-12c2-08dbb4784118
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5367

From: Amit Cohen <amcohen@nvidia.com>

Currently virtual router ID element is broken to two sub-elements -
'VIRT_ROUTER_LSB' and 'VIRT_ROUTER_MSB'. It was broken as this field is
broken in 'ipv4_4' flex key which is used for IPv4 in Spectrum < 4.
For Spectrum-4, we use 'ipv4_4b' flex key which contains one field for
virtual router, this key is not supported in older ASICs.

Add 'ipv4_5' flex key which is supported in all ASICs and contains one
field for virtual router. Then there is no reason to use 'VIRT_ROUTER_LSB'
and 'VIRT_ROUTER_MSB', remove them and add one element 'VIRT_ROUTER' for
this field.

The motivation is to get rid of 'ipv4_4' flex key, as it might be chosen
for IPv6 multicast forwarding region. This will not allow the improvement
in a following patch. See more details in the cover letter and in a
following patch.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c    |  3 +--
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.h    |  3 +--
 .../net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c | 13 ++++---------
 .../mellanox/mlxsw/spectrum_acl_flex_keys.c         | 10 ++++------
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 70f9b5e85a26..22e5efb0eb8c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -32,8 +32,7 @@ static const struct mlxsw_afk_element_info mlxsw_afk_element_infos[] = {
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_TTL_, 0x18, 0, 8),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_ECN, 0x18, 9, 2),
 	MLXSW_AFK_ELEMENT_INFO_U32(IP_DSCP, 0x18, 11, 6),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_MSB, 0x18, 17, 4),
-	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER_LSB, 0x18, 21, 8),
+	MLXSW_AFK_ELEMENT_INFO_U32(VIRT_ROUTER, 0x18, 17, 12),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_96_127, 0x20, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_64_95, 0x24, 4),
 	MLXSW_AFK_ELEMENT_INFO_BUF(SRC_IP_32_63, 0x28, 4),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
index 2eac7582c31a..75e9bbc36170 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.h
@@ -33,8 +33,7 @@ enum mlxsw_afk_element {
 	MLXSW_AFK_ELEMENT_IP_TTL_,
 	MLXSW_AFK_ELEMENT_IP_ECN,
 	MLXSW_AFK_ELEMENT_IP_DSCP,
-	MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-	MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+	MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 	MLXSW_AFK_ELEMENT_FDB_MISS,
 	MLXSW_AFK_ELEMENT_L4_PORT_RANGE,
 	MLXSW_AFK_ELEMENT_MAX,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
index b1178b7a7f51..2efcc9372d4e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_mr_tcam.c
@@ -45,8 +45,7 @@ static int mlxsw_sp2_mr_tcam_bind_group(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const enum mlxsw_afk_element mlxsw_sp2_mr_tcam_usage_ipv4[] = {
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 		MLXSW_AFK_ELEMENT_SRC_IP_0_31,
 		MLXSW_AFK_ELEMENT_DST_IP_0_31,
 };
@@ -89,8 +88,7 @@ static void mlxsw_sp2_mr_tcam_ipv4_fini(struct mlxsw_sp2_mr_tcam *mr_tcam)
 }
 
 static const enum mlxsw_afk_element mlxsw_sp2_mr_tcam_usage_ipv6[] = {
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-		MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
+		MLXSW_AFK_ELEMENT_VIRT_ROUTER,
 		MLXSW_AFK_ELEMENT_SRC_IP_96_127,
 		MLXSW_AFK_ELEMENT_SRC_IP_64_95,
 		MLXSW_AFK_ELEMENT_SRC_IP_32_63,
@@ -189,11 +187,8 @@ mlxsw_sp2_mr_tcam_rule_parse(struct mlxsw_sp_acl_rule *rule,
 
 	rulei = mlxsw_sp_acl_rule_rulei(rule);
 	rulei->priority = priority;
-	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER_LSB,
-				       key->vrid, GENMASK(7, 0));
-	mlxsw_sp_acl_rulei_keymask_u32(rulei,
-				       MLXSW_AFK_ELEMENT_VIRT_ROUTER_MSB,
-				       key->vrid >> 8, GENMASK(3, 0));
+	mlxsw_sp_acl_rulei_keymask_u32(rulei, MLXSW_AFK_ELEMENT_VIRT_ROUTER,
+				       key->vrid, GENMASK(11, 0));
 	switch (key->proto) {
 	case MLXSW_SP_L3_PROTO_IPV4:
 		return mlxsw_sp2_mr_tcam_rule_parse4(rulei, key);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index cb746a43b24b..cc00c8d69eb7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -171,9 +171,8 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_2[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(IP_PROTO, 0x04, 16, 8),
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 24, 8),
-	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER_MSB, 0x00, 0, 3, 0, true),
+static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5[] = {
+	MLXSW_AFK_ELEMENT_INST_EXT_U32(VIRT_ROUTER, 0x04, 20, 11, 0, true),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_0[] = {
@@ -220,7 +219,7 @@ static const struct mlxsw_afk_block mlxsw_sp2_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x38, mlxsw_sp_afk_element_info_ipv4_0),
 	MLXSW_AFK_BLOCK(0x39, mlxsw_sp_afk_element_info_ipv4_1),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
-	MLXSW_AFK_BLOCK(0x3C, mlxsw_sp_afk_element_info_ipv4_4),
+	MLXSW_AFK_BLOCK(0x3D, mlxsw_sp_afk_element_info_ipv4_5),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
 	MLXSW_AFK_BLOCK(0x41, mlxsw_sp_afk_element_info_ipv6_1),
 	MLXSW_AFK_BLOCK(0x42, mlxsw_sp_afk_element_info_ipv6_2),
@@ -323,8 +322,7 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_LSB, 0x04, 13, 8),
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER_MSB, 0x04, 21, 4),
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 13, 12),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
-- 
2.41.0


