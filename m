Return-Path: <netdev+bounces-216277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC33B32E3A
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B2E3B8A01
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3525A32C;
	Sun, 24 Aug 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ww2zUrn4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C781DE885;
	Sun, 24 Aug 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024825; cv=fail; b=eqfa8xGnGexpV/mvefU75QzBG1TZ8Y6aPjreIBouLGXqaZZHEBELoABNVxDzQVgJGg6HKdOVXvmgf5Nefeuo7MzWf1xExw2YhYdpNp/VfhU54aTmByng5Gsvm8GT3DpQIl4V49IHg1xF8pNirdDaLGz17h/Pq755+VoBebMekHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024825; c=relaxed/simple;
	bh=uhSo9pysU3h6WZwatxZZUCyfIUczga4x4lLjnw/quLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+qQTOR/wIOihynSWm/6Qvi/n+EpMmglBMAzN53oPJdESFTLVLozCmM6CqzKBb4yX7KBOUTr+NXEidPrQr1kun+YDVE9VYD4UCe3e6ZY4Mu3+BPA6RduO3P7D8cAwSWOvaOPsQnKphGRfBaTOVQyMD2GCN6YC73v54kf2YmvIuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ww2zUrn4; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVj5NTiIlcxFdfg6fgKOKmPaX1Gdihr3/OTJYj2Sa2IZiDm9TiojXz+r6ML6s96z3fwmuwB4ZcNQlnJ+ORVqK5N/MVDQWFqpFRilochKIXXE/JIeK1J7Bwqb+M5Gh2LeiBkOdM8eBiUdkyOtkhEoxfchMqDERD2C0jBtP1k3L4rCC+O0xGe8dGuZVGOcdNzUiweRrcghfodpMZ4CaD6HChaQIVWFo/8cZE0vFW9s8GD+MaYLxGSr7P2o0LqTIih5AYD2Nq/ejtuuTw3WluJpoCVHc5Vk3gczWGXIyivLeQShWBA9rKZ8b/6alyYrZ6ltVp9/Bm7GBiRgFK36+J3jHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWPyZmPOLtzKUnTVhJFX5KGUPCx9gphAmx1IFnFoML8=;
 b=Qcy84zd8VbsUSOpL9gPA2Fs7Ha5d+dgRSS/NosBUsnqGUyIs46VPwAU47kON5C7QrUZkJw4QvY4EiVlBpxy+4kuCCzEg2/rlk2fEcY3vkAc8diuFXm6k68yq56emntsLt8AoQ2LB05vHQ4AU/inSST2JMXboOqe7hwce1y0YEdz5lYG6x5HPeVLUl7kRAFDmTYR/5hzA6qIF8Z2WeeQt6TV6Ko/X8QgjgFp1YYGnmqN0l4OiHWS5qBHIB3teApBiMRIDiPylAJCufdr+M3/CmKGodVaJqZDdazlrD3NnAeGXtOmW1AIJFLlQQdvIebdFLkRxOgfFxExulHzR34uRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWPyZmPOLtzKUnTVhJFX5KGUPCx9gphAmx1IFnFoML8=;
 b=Ww2zUrn48mNkUrWU5275X+H2hLXU/YXs5jx1LJAIdYbSk+nuYF7zTkSNqSxwQ8071MdwYoqqPkgKfG6rMjnU0pS5mHv3cz4nxQMk78tThbE7nQFtSVfURPDUE60WROUTnGORarNdGydpUOu9dRiYDUYFXkpq0ymcW2R3AD4/UZEfZ5qVReGpJQzuUdGeI7HrZZe7MGSE4QTxPBxLEQc2f6nCJ3BbqyP/V6acYDQEh27GEfswOpxlLbag3Er6zY2TmcX1HinVEqhAzibs2sC0/BhToqmPxF0AtngXIc4mRbB0TYxEbIn7uvtyvz/CNw/GaI/Y+7pCZc7PJr0JO1dlUQ==
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:40:18 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::b5) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 24 Aug 2025 08:40:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:40:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:39:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:39:56 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
Subject: [PATCH net 02/11] net/mlx5: HWS, Fix memory leak in hws_action_get_shared_stc_nic error flow
Date: Sun, 24 Aug 2025 11:39:35 +0300
Message-ID: <20250824083944.523858-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca1dddf-2211-4fd0-b935-08dde2e9daf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGTPh73wfe40+k7fCBSZiCKtT+alPCKIXGClYXqBoQWX8ZQ924rtHH7o6AXJ?=
 =?us-ascii?Q?tbwGhZbW5bsYL9+2qstpcMKMPu6A2O+puJeJyz15pQ9VQ65U88neAU7dFmNk?=
 =?us-ascii?Q?nzweQ6SpRZ3YJEnnmDgIvL5PweZjhS1zytlLiGCsvOh936vB5+bexRIENZ+N?=
 =?us-ascii?Q?SVIMQK9fa0130l8uVLhblexrY8bp5W+hx/sRpqyTo8ZNS1a+K0vNPE5djEe5?=
 =?us-ascii?Q?tgSjeCbi7yil1WRjP2jHa3hA8xADgEctL84USsjnop325pm3DhG3dnpP+JKE?=
 =?us-ascii?Q?5qWoyjYpKUZ97ucE/56iaISczk6HxlNxDRITmHyGoBk0LJ7iyR25bZc9b0A2?=
 =?us-ascii?Q?QbrflB7cfvI39hKoe5tpukQX78k/Ldu2zfNiD+eGTcHKyqROvQzGKHkniwwI?=
 =?us-ascii?Q?0H2N9YGmzD5nNrNsgWP3mdj+6uepGiuVxJPmHIVnOigfCAVTyHOzkhHzXn0y?=
 =?us-ascii?Q?U/nHvS2oYibMqv0kr7IA8IjTkUO3UQUOuCZWi/9VLG5pT6EuuV1OQdQhc9Jy?=
 =?us-ascii?Q?zRhGsYtFc8eWrfc2PoByaGcF0zd7siBZv27xE2gp3RC6AnXs/FhWOtPakcZz?=
 =?us-ascii?Q?5DCR6w5W7XPy7TcMjjol3TogZKkKCe3CzASaYusOMRm4dxLgrW1yD2KRnh86?=
 =?us-ascii?Q?A+E1NdjKCUPTfkld36y6EUpsV8c0Ku5AO+GbFjy7bl10x5JVnqBGcjXn4NFh?=
 =?us-ascii?Q?a1PznvQyNXKpV97b3S76aWKLLTN0Ae0GAr85TNYkqPFuocOOrO3JXcz90/80?=
 =?us-ascii?Q?vmyMcWFX0BLQtabmvF+IVwzK2zJkRsOkkYlHS6s+m87TfhHG/W7vgwLrZfG5?=
 =?us-ascii?Q?subDNE72/NPyKe/EVs6oJTjYZI1Z1RcRkVRdVZwKlOgwPkK3jBpI5qWty64q?=
 =?us-ascii?Q?M/HyQ2SjEp0ZsUmO0RE7hkZfzeZKKVmwyryDOetZPzm1pS/RJfufg+b1jorJ?=
 =?us-ascii?Q?1Jpnlx05QHEU0BLvlCxtlpv4Rdfa1NcsMZS1TE9yek5Y5OdpxI3cvonZpkGY?=
 =?us-ascii?Q?+GvwM2WStAUcqXtqOv5eVTjYCCi5ddJi6MnifzFQJjVCSD/OZ99rMPxvYlC1?=
 =?us-ascii?Q?/jav0ZjbEO0jiJGzAJGuCpiP+Eh2jwpBEGq7brbGm1oe0XzPrPnZ7CFOY0NN?=
 =?us-ascii?Q?QDBKtHM8VqKELd3q8BAH1Fe2rz9v/UHjJYfCU0V5gw0166qs6bFahN9kp4qj?=
 =?us-ascii?Q?HXK/qWQTokc3Q9iMc877HJUd9HhM85iPyMR5GHyWPNk8LyUB5DcvmqBodBRF?=
 =?us-ascii?Q?JC4i6kxaOUCAdsEwipQMz/ghCxbzKR8tfbnN77rvmSs4sAAQvqV+Cp1Mz7qw?=
 =?us-ascii?Q?fsX7rowe40iSdACfcA9E2eZA1JYnLi1khwMnf4FGvMamlSjpHHzMx00fb1Ns?=
 =?us-ascii?Q?u2UzzDhSVE1CPGFj78vT8QR3AYeSyKrNg/FwLJLBC0PbI7/odqxJGZDbdoy8?=
 =?us-ascii?Q?NbVP6UDOtJpjxMSOX1KcAAmb21JiZQzZYjetG6o+WaLGqSHGglVNsa7bOOCK?=
 =?us-ascii?Q?2vGusEnog7HPrzFaIy3/DzjP00gzqB8UcYyH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:18.3528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca1dddf-2211-4fd0-b935-08dde2e9daf1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

From: Lama Kayal <lkayal@nvidia.com>

When an invalid stc_type is provided, the function allocates memory for
shared_stc but jumps to unlock_and_out without freeing it, causing a
memory leak.

Fix by jumping to free_shared_stc label instead to ensure proper cleanup.

Fixes: 504e536d9010 ("net/mlx5: HWS, added actions handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 396804369b00..6b36a4a7d895 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -117,7 +117,7 @@ static int hws_action_get_shared_stc_nic(struct mlx5hws_context *ctx,
 		mlx5hws_err(ctx, "No such stc_type: %d\n", stc_type);
 		pr_warn("HWS: Invalid stc_type: %d\n", stc_type);
 		ret = -EINVAL;
-		goto unlock_and_out;
+		goto free_shared_stc;
 	}
 
 	ret = mlx5hws_action_alloc_single_stc(ctx, &stc_attr, tbl_type,
-- 
2.34.1


