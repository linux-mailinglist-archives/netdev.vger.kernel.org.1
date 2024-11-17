Return-Path: <netdev+bounces-145679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572ED9D05F0
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC369B216E0
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007171DD9A6;
	Sun, 17 Nov 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aEMizgC2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E011DD86E
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876730; cv=fail; b=Vnuj9/5O1dg70NcMO0DBixXNNexgnB5/tucdtHgFC902Uq/n13VfEnA6rmtF3vFGzsoXg4pxPuTwwd5lZ0xgoych5ARt1lHQIs+oBh73LoSxtu/nMiXjRoN2YHj4nD5LiYaVn1EebGghICS/vacUgPBRyuFY07vE+e/4TSJQczI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876730; c=relaxed/simple;
	bh=E+mp45uSNr4LpU+Su+zJQThKKCJyrkVTqp3GrJF9MDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFnIiMhDol2C4kTd/j+LLDa4cJ/oJbC94M/fOBHc8UTuzmyVMkNBOspOTCvqHBBX+O+X34hnUKsmKJqpFvxPFULh4vxVOA9vyDF7gFYiMhIQ5Z9gP3OocMihJqTA+LE1j6Y86/hWgH9dDCsliBsYdMpS/RMIwpM98Z6vkqgT/oA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aEMizgC2; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtVGtk7LZAxuFxEs76vFOL4sAjX5qx8u+/sZEOjsIRFEX2NaETRyjTwbnKaBRGwX6qs9Z32iUwpv0gcRUlufIA8BwUU3lQiy8/JPpdr2+/4r/3liHNmFdTK0f0GrZk/pr7HJPtAnk8jEA8fyZTzJhmXf+3GeZniAQsSfIB8fFbVWTYpSdy9cksUN+OcHI9QibDGevMJitCbMR0peBp9CVFRydEtWUP4jAE+gMJQB3pHHcRt9dZwuDOzUeoOM3bEgosJkrqk3hdgYWnlfKroLNVqCXnB8etBQtsUbxO9fPZz3GxOhL2vT8Zj7jvr+8HGX0HZwcs4rHWavrtUeLDkZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=KGRbBJ6pDGTLxUMHh4ZzkwqbGioWB9mXoNYvbFsoNBeNDHvUCvTj3nSltOapbyQPr+dfHVKxXQvD4gEvUEjR1uXd48MNuLu6uxmmHAzUHTBC/vXfW08Ztu01f4GeFIRsvQgQ2/15pVRo7JxJ5mRt8nVRrflAQk++GvOx5shU4+R7E3suHS6g/0YPVcZaGFsPBw6LWoAlh7NqimPD5EVxMO6Bd9utATfKdw+nYKtKXAS08grqlAoJR1uoLzfDXArd+GLWrClTJdNknvsjUfmYB+Z/qx/+UIyahphYnbk98i5zBJJ7v/6poN0Vt8h3gr0W4B+89hcuJqf52CiH9FeXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ6l+PUE0OaX84SHJaS/Hfir79LRbrgd/tE/9/3l3NE=;
 b=aEMizgC2x0TymyVc7uEJnKEokZcBxd+0mhnqluBGLxPXy7zlFWNbsS4YLgUn8Iayu5m0ljFgJCZhjCofXG+AJ0/CIBuxMdc3cwdc4KRvfDebes+x8grk6Ue6jBvOX4vZzen4j+7vFBpk1eMFooD7jWaBk8EazY4SCV7hJGIdqmUe2N04v2/vK5y4AAqwuuF3ImM9vdbxs1twCfMFEX6P+JIAM4ClDuu1x3GXQ6wBy/DZVrcYrwCvB0RN1rE7DWod9QBOtjgnDWmy4YepxN76EYsGEyT18l5qEjVZMfFudjob0KX4AUy0OTzLNhlTDRpEuxTgevjNtBjATrn2YqL4hg==
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sun, 17 Nov
 2024 20:52:05 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b5) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Sun, 17 Nov 2024 20:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 20:52:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 17 Nov
 2024 12:52:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 17 Nov 2024 12:52:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 17 Nov 2024 12:52:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 5/8] net/mlx5: Add support for new scheduling elements
Date: Sun, 17 Nov 2024 22:50:42 +0200
Message-ID: <20241117205046.736499-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241117205046.736499-1-tariqt@nvidia.com>
References: <20241117205046.736499-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: eab02155-f510-4a3a-6b65-08dd0749b16d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Za0amxjyc4GXNpe8t9mRykVagV1Ezt+XKbBjgfwrAPlsu1ozfTpjFaqoFUoE?=
 =?us-ascii?Q?KTp9d4H0aUpfTzDtOQqVFqOCaXFyxZZRhpfSQmetsDw18l0kO8mVGbBzTub+?=
 =?us-ascii?Q?y7z4gZpBJRF278Co/jLVCNwRtlKOmRx+nANVhnv735WmJUoF9mKPkzPjbKwV?=
 =?us-ascii?Q?jSlQ0XLKS6rgGm3gBNFwW4TA+Dt2nWUjqi2Y921ao4h+GhwDJyH82MC5KPYD?=
 =?us-ascii?Q?Z2chT1uMreWRYsGcRcQ51TGAVMVrEkZrAXJ+QRXoFNANuhIE1L3GJQbperAJ?=
 =?us-ascii?Q?HFdpxLJxBEI5du1tJwU3o/tH8MtJeoHcuZiWd5J54WHnH+Tz5VXIft2xSz6G?=
 =?us-ascii?Q?CjsVIepdHAc2tppPcChseowx+uYdQ4B7Fiz8vngP66Wziy76IeHDZuVeCdk3?=
 =?us-ascii?Q?Mm8KKyHDyW1HaypyIcMZ/YkX2+y/jWEqqiKFQPYYqP9jmkQHRh6+0qU8HKxi?=
 =?us-ascii?Q?46tlYNLQ/sqh+VjWzV0D4LSGFkq7iaR9DAl1xikCfATWbY7EUSRzG0pcFTN8?=
 =?us-ascii?Q?AA13zDyvU+c0mpZ67emkUZUwXN1nhl7v7Ndo3IiI5ITsTS52xrRIPu8p7/fh?=
 =?us-ascii?Q?lxbPDPuNZZvRhd8Af/9W/1iOHmPg2ff9mD6/vad3EhyHeBygwtslx7KSJbhz?=
 =?us-ascii?Q?ACcO09no/wEhDZopP385IOKvVpS/wQ+4mazb2Kq+UHGyL3KFEhPPhwECKbXd?=
 =?us-ascii?Q?10kwtrOPz9i0MUh8VF+P9j/gpp7YJV1EEbiD7+qUmRSsuXWVkygIKJeQvuMd?=
 =?us-ascii?Q?VrXWprE7ZvvHFMYbjAkdDz/+7TBFUxk4IQkVzGesHSnP0UE1U8QYK8eoSW3p?=
 =?us-ascii?Q?ydk7CV9IRE2OGh0ELVys4JVzocgMY9da/K87ilqarXZWQi2Un8+acsfKSxlE?=
 =?us-ascii?Q?dbR/XOzLAAQkxlHhTiBtsDhIVeFB+uuHO5jb8ae9ip7mdigiuHm4xdUn+G0l?=
 =?us-ascii?Q?EbPWvOm9lWOZeMeX1gJdjCPffxe6If2QXdY6Z8FZCOZYI8xkVfj8GYDtguW6?=
 =?us-ascii?Q?7LuLOuDJ1ZZIP6QVKaSIBjBYG5dP7JYmJxejBvA0aL05Idv61ZuEHMW9V87N?=
 =?us-ascii?Q?xTAQwFe8REN1rNtkqzypo6OlnGlV0BO6RT5W9FioPft0RDAvQ4timy9eMR86?=
 =?us-ascii?Q?GXA7Un6bxWDyauoofhNFK7n+xiH97ujmGt0H7hrHnL6Rx6AuGEiFoAmc2rp3?=
 =?us-ascii?Q?lTkpaZP/a9S6uvwtCjtzPwJKydzg0VQDM9yvmAeCZPzh/T31UljRfnrI1dj3?=
 =?us-ascii?Q?H9dIkJnaBfwKMOrsEt9GkHRgTyKvILmxmOhTQRnuXdAe+cr7rrfhlrS7qkba?=
 =?us-ascii?Q?8Eukrv9FKe6xocO5c65sXu87RpJTb7yLzq7kRDou2r4j/Tt0DG27vvp1ODGX?=
 =?us-ascii?Q?PtPzEx6fX/7Wz5XBxkj3G+88PnteYDikHCHgHS+2gQdd7DSFqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 20:52:04.5661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab02155-f510-4a3a-6b65-08dd0749b16d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

From: Carolina Jubran <cjubran@nvidia.com>

Introduce new scheduling elements in the E-Switch QoS hierarchy to
enhance traffic management capabilities. This patch adds support for:

- Rate Limit scheduling elements: Enables bandwidth limitation across
  multiple nodes without a shared ancestor, providing a mechanism for
  more granular control of bandwidth allocation.

- Traffic Class Transmit Scheduling Arbiter (TSAR): Introduces the
  infrastructure for creating Traffic Class TSARs, allowing
  hierarchical arbitration based on traffic classes.

- Traffic Class Arbiter TSAR: Adds support for a TSAR capable of
  managing arbitration between multiple traffic classes, enabling
  improved bandwidth prioritization and traffic management.

No functional changes are introduced in this patch.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/rl.c |  4 ++++
 include/linux/mlx5/mlx5_ifc.h                | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index e393391966e0..39a209b9b684 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -56,6 +56,8 @@ bool mlx5_qos_tsar_type_supported(struct mlx5_core_dev *dev, int type, u8 hierar
 		return cap & TSAR_TYPE_CAP_MASK_ROUND_ROBIN;
 	case TSAR_ELEMENT_TSAR_TYPE_ETS:
 		return cap & TSAR_TYPE_CAP_MASK_ETS;
+	case TSAR_ELEMENT_TSAR_TYPE_TC_ARB:
+		return cap & TSAR_TYPE_CAP_MASK_TC_ARB;
 	}
 
 	return false;
@@ -87,6 +89,8 @@ bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hie
 		return cap & ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
 	case SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP:
 		return cap & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT:
+		return cap & ELEMENT_TYPE_CAP_MASK_RATE_LIMIT;
 	}
 
 	return false;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index cf354d34b30a..87ec079ec83f 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1103,7 +1103,8 @@ struct mlx5_ifc_qos_cap_bits {
 
 	u8         packet_pacing_min_rate[0x20];
 
-	u8         reserved_at_80[0x10];
+	u8         reserved_at_80[0xb];
+	u8         log_esw_max_rate_limit[0x5];
 	u8         packet_pacing_rate_table_size[0x10];
 
 	u8         esw_element_type[0x10];
@@ -4096,6 +4097,7 @@ enum {
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC = 0x2,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC = 0x3,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP = 0x4,
+	SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT = 0x5,
 };
 
 enum {
@@ -4104,22 +4106,26 @@ enum {
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
 	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
+	ELEMENT_TYPE_CAP_MASK_RATE_LIMIT	= 1 << 5,
 };
 
 enum {
 	TSAR_ELEMENT_TSAR_TYPE_DWRR = 0x0,
 	TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN = 0x1,
 	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
+	TSAR_ELEMENT_TSAR_TYPE_TC_ARB = 0x3,
 };
 
 enum {
 	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
 	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
 	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+	TSAR_TYPE_CAP_MASK_TC_ARB       = 1 << 3,
 };
 
 struct mlx5_ifc_tsar_element_bits {
-	u8         reserved_at_0[0x8];
+	u8         traffic_class[0x4];
+	u8         reserved_at_4[0x4];
 	u8         tsar_type[0x8];
 	u8         reserved_at_10[0x10];
 };
@@ -4156,7 +4162,9 @@ struct mlx5_ifc_scheduling_context_bits {
 
 	u8         max_average_bw[0x20];
 
-	u8         reserved_at_e0[0x120];
+	u8         max_bw_obj_id[0x20];
+
+	u8         reserved_at_100[0x100];
 };
 
 struct mlx5_ifc_rqtc_bits {
-- 
2.44.0


