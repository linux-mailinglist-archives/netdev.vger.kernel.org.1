Return-Path: <netdev+bounces-109370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8523B928292
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046921F24A52
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B415E144D0C;
	Fri,  5 Jul 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dj0n5q3u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938B144D09
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163758; cv=fail; b=IcYUl/ILW74J2AB8Lld4m7b53QL+tCgxkZgpLWWJOUKuS+zVzTfEJARx9xavUgr34E38x/oQFa8HKMre+/K+x2xxvMvc1pY/KkiYrgBMKGRjNokO4unIAL6iup/2NSxeF1jnZ5UNT76qgJSpM5i8zvWIn8ym0fF6z6Pti5hJRe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163758; c=relaxed/simple;
	bh=E+w8KXjvWeIa2V8vROs1111Qp46vuhWTtD0K6oKo2wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nk/XWff55k8gpKj107iYgeNM0MIGRvazS/Zt1TpklK6C1Qdj7jOVuB7n13ntDoyOt5EGTglKB3AOKFbntGXaQUPpITjqjd1v1dc5EM5nhc0WxnQl07Ug+Kw66zWnvSLIxFR7Bav5z9KCwO0itz/cxBIcV+R+o2r2urcVp64B0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dj0n5q3u; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8iPFgmYBCuKk3iizfMLYdw/XKrRhlVoG8oHztuozKUq+pgBPzXxVzXebXd8MpzEAKFjWC7AsJxGlN53j0xkBAmH1X2RxDbJlTdBw5BW0++Ugeu2LszbpLyB3pSR+wZxlMSqlJ8LXoggvJlT4heY2Gs8eBuxVD7xqIzv2GedYpasq4q0sKJ3vblkS/pVqDYqfJcToedT8fwwq697VGdDp6fscTUjQRT6ulDEuOrwJ7sEgcheb1X/l+t9+7fz2jle57Oiq+MVqZmrquDVoEzRxFoV+iWvEBC5KitlEyNsFZEdqB8KQXE1e5FqutAkMTb55IQrkT2tcQLgFm2BZ1v15w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw8ZiEzx3HHRbMRgB0Qs3f+4Km3q7TmsmWGNBiTcK6M=;
 b=n9X+dTjasJr+YF+f9ppS8+WjiNpnqrdGGIqrUVnLFbnJOe4P5Te9X5xJNItgYRQx0CX9LB9LY3g8o/96NLSihbJ1yujuwIBMeSNlpifHxOR/HN1aoywiCg9VaYwPi2RZJYJLxbvwS7fOLlB52PPjSM17q6mBYWWLUeATfUaXZxrHQH/ptd+GL3k+76RRiKpHkkXG6mwvKR0xHFhHWEYL4SfgoBuY41hzBZyFbmTdwVPZWElz3qOFjXQGQC9lwrcLoyCjvuzCK1UyiVACWYHXAPPRkD1w+frvDFmJXctSnEA8gJvHp1yCjQrz/lkGjtelY5bhgGXFh9eKdNgDkHeJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw8ZiEzx3HHRbMRgB0Qs3f+4Km3q7TmsmWGNBiTcK6M=;
 b=dj0n5q3uRn/IIV+5fM3R17xlxjKYKgJHR5qKRgBhkw+oGJ2cYW2rLNdil/Ac6OTM1uMPUKlUPrr/nVV1RpvUcMEuO4VZwfOqiUMIq4l22ya8Ta3QsNMogN9+BTp1y6QyleTv8ELjEEhJEBXw1SYnyS87HpOZ+4lsqptW2ucD8isY2YWsDynYBXnIZydMdmsoo/5IUs2PaWpWqYn6xEWs1Mz5eShgusQkCGGhMbx7O//duGKbEt+f5edqu9JfLQCOfjYlLNQ/0nHWjzqACKDuo3Hj4rRNqL3SWNxYDX/T2qvVLi9vcvg7lbk5rCW1ukExgu6+EC2kojoYtz0VdzhfEA==
Received: from SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::24)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 5 Jul
 2024 07:15:53 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::cd) by SA9P221CA0019.outlook.office365.com
 (2603:10b6:806:25::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:52 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Alex Vesker <valex@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 08/10] net/mlx5: DR, Remove definer functions from SW Steering API
Date: Fri, 5 Jul 2024 10:13:55 +0300
Message-ID: <20240705071357.1331313-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: d66ee474-0363-4fa8-c3fa-08dc9cc24e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eR1Ze7E5pSMmTd2mcpzLnpEBbF7zt7bhQCGdScnpycW2IcW4PxjSRcnEzX/A?=
 =?us-ascii?Q?2fudoiGSIs+Uc0eS+S3kWJfT2eHyAlcbvPKNH7/g7x/SQwJYqSOjMIkEL8SF?=
 =?us-ascii?Q?yUah51IYdQ5KG3aejwwpuYxeSkhcgYm6g+iMp9nEEVz8zlWoH1COkGS0/OMy?=
 =?us-ascii?Q?Sv87v/XJOK+Ha9LCsVB8pVYDjVMiAsCjBIycQEQtwDx4ARdWpJCcHrn7W+U2?=
 =?us-ascii?Q?LwRGnbdDL11KzCVI8I5f+xRvjnRKKcJvE48jxp0ZC6cA7PUrGEZ4YA19HcaD?=
 =?us-ascii?Q?mkbzJP6GrZrMcw1nMLqMf+hOLXo0Td1KypiEeZHYz7pJwahKcG4uyZrsdPAf?=
 =?us-ascii?Q?HYVm0GYf5g21ZHPRj9U1nNApGRrV0usru+5/6j2NNrQh3u/Hl2umZEMnrLMd?=
 =?us-ascii?Q?zqtm0/QeAbRqBY9PR76i6bMOqQAi9kyIHygswfQt+pTl6JYG6Mi63TucuPuj?=
 =?us-ascii?Q?eVyXXmK4K8Cn8aKb/qm4C+QxvMrlclSZijMBU6fa87F79nGg1aOxyjBWNKqz?=
 =?us-ascii?Q?80bHYmW+cJeGkpb/pF53TKntkeFlV+CL6U2r9Ye6jUp+X3fmbqzr7p/slsys?=
 =?us-ascii?Q?ErBLexR28xrTN09yqKHHCVlc6FKTmiT4cOyPY/7fGzeZYCX6ZobMHXVc/lcr?=
 =?us-ascii?Q?2Fc2G0x5U5JJXYAERiNwj6sQCu0/MZkD6hxnZ70GujM5WRitBjFXiL9B/okE?=
 =?us-ascii?Q?Xrb/tEHU74CKQ0AQJIB/nbY7qjRMHSTVJwQBlaMl/05uNuCrUACxPtHQDA9P?=
 =?us-ascii?Q?GlWkIgHX2KbjpU4/p9dm3ouI3hNzaa3Kg3hkINbWUrluDztEtYRdIMrl38LE?=
 =?us-ascii?Q?UzO6Un45b71v2U4ff9OncBY6oSLPS89D2QeUeX3GjfLYP2RW4Cl3ynmE5HJa?=
 =?us-ascii?Q?PdP4SAbJ5CkLJkpaKi6xHI4QhkT94x00MF2TQE29ZzhudvGl9/oBysuYcAvr?=
 =?us-ascii?Q?5wEGbJhmE1gXHFi8df19VzkmSMFH14IGYEPl6bxAF7NzkiOTAazJ7i24e0BI?=
 =?us-ascii?Q?gN/HFI5uKRkb4fvQVwG2q1axrAHQSerJbe2o2hpZJ0ydq5Uzn/peFkR6c365?=
 =?us-ascii?Q?KzoLLbduywh5qb2s3StLcU5Ok32x8jvq8gzGbuwDdOdd687GRnql7fGaTN3F?=
 =?us-ascii?Q?ZV1QkEOuHteDrcz1QuGuSG25DTVOQ5jFOTwWUYY+eGwWMSMqoMg/Mcu/8zyZ?=
 =?us-ascii?Q?IjWW+G2b2Otj9VBIn5Y0DK8aN4lBXpe8DaKtnx3lGN9OIW056lF9BTG5uoMn?=
 =?us-ascii?Q?h9KPI/QxFRJLfy+6RwscylWuMBIEIT0/IYskgaDlmWQV/WwKQuBS96dkUS+g?=
 =?us-ascii?Q?FlwTDP75eKI5cv4RdKF2iNMfl4vYlv7gbTbg7REJciIYNGZSAOPwDVT8hD27?=
 =?us-ascii?Q?SbHHJAKpIxqDmzzL+lSNOoFbFquWkK7BUeGhzzgHbqWQN0XUT6HxFeiGhRaM?=
 =?us-ascii?Q?fg0V1QIgdTdO/3Jwnr8lT33MwOKBzmHA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:52.9759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ee474-0363-4fa8-c3fa-08dc9cc24e4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to expose definer get/put functions as part of
SW Steering API - they are internal functions.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 81eff6c410ce..7618c6147f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -1379,6 +1379,11 @@ int mlx5dr_cmd_create_modify_header_arg(struct mlx5_core_dev *dev,
 void mlx5dr_cmd_destroy_modify_header_arg(struct mlx5_core_dev *dev,
 					  u32 obj_id);
 
+int mlx5dr_definer_get(struct mlx5dr_domain *dmn, u16 format_id,
+		       u8 *dw_selectors, u8 *byte_selectors,
+		       u8 *match_mask, u32 *definer_id);
+void mlx5dr_definer_put(struct mlx5dr_domain *dmn, u32 definer_id);
+
 struct mlx5dr_icm_pool *mlx5dr_icm_pool_create(struct mlx5dr_domain *dmn,
 					       enum mlx5dr_icm_type icm_type);
 void mlx5dr_icm_pool_destroy(struct mlx5dr_icm_pool *pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
index 89fced86936f..3ac7dc67509f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
@@ -153,11 +153,6 @@ int mlx5dr_action_destroy(struct mlx5dr_action *action);
 
 u32 mlx5dr_action_get_pkt_reformat_id(struct mlx5dr_action *action);
 
-int mlx5dr_definer_get(struct mlx5dr_domain *dmn, u16 format_id,
-		       u8 *dw_selectors, u8 *byte_selectors,
-		       u8 *match_mask, u32 *definer_id);
-void mlx5dr_definer_put(struct mlx5dr_domain *dmn, u32 definer_id);
-
 static inline bool
 mlx5dr_is_supported(struct mlx5_core_dev *dev)
 {
-- 
2.44.0


