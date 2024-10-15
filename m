Return-Path: <netdev+bounces-135517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D668E99E2DD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BBA283C3C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C71E2619;
	Tue, 15 Oct 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HXR0s+/A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC881DD86F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984797; cv=fail; b=swPjCYLC1sV6Kv0qgaHL/u+1jc6sK+qeiwCiUqCyO33yiWzFmJ9X0S1YxEYWwRKqpg9xaQjsZimaeBu+5joNtAuhno7a5UGncSkIXUYrKIzKMkzw0qglcNNuA9iS8qeSOIb4G8MIskw32qVQXzKJaRRWPKFHOHvAW5D4rTwem90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984797; c=relaxed/simple;
	bh=dJhCLw46UoKGig407A7C7L7z4KrzUYKLhcsaJJAUBcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0kmaL4choOCo4n/GkuUEoUo8UEBqbgZ5uO6xoUPBJSkoBMTXu5YSp1r3v15voOzqLDwuYXlNPxuOr71T5rpxPNoQYspdbblbdKq0pb7qnrZs3QRuAZGQvLrhjvc60AS0fkwoPbhXKg2u7vodKbrX9z8pme1lJ/4CPK2qTHYMls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HXR0s+/A; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW7zdHYJMkUDKAym1fP9PFaYiAwQ0IT7z2d5wBY5hKFUD9VftdJtEuaBnwS9yhkzRdCPKih9Wz0bfk97AN83An3yi6jvixVkt5xIKVOcvTyfv3JyrGZ2DG0diBOA2cvbv14gF87qYarMg3qthpPuOoWukSlORBVDhGXAiaNcmovEpwVhQVT3/GmvpRynx+RFnPr6CgvmBL/elZJea1xFiJVnl+g/2/Bs3hD1YOgzuDYQErTvlcVP+oN7m48sQcmMKkjm23oxWIWksfyW/9lRtolBLpi87/MxaVFeEfP86pXLgZrCKx6elmzDnY9rlhO0egcI1yyhDjjMYiTjXyvrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Avu/WbCgMHj8qu3SX2hchGZIBQX4EdgppUAtD3VOby8=;
 b=K1Ff+IkDgnX3trUsfX48HjgoLS5CkWXBrh22m1ybHgSWZUsUlD+Q6m0/AZPLCVLybdyNwXhqQGM9LelHTYuPEWJQfVR47yf6u3Uc2ATlqqavqsH6htVVuCt9cyp6mLY/rD6krv/SWVDVAvRspmEPOZzGNsDktX+ZOQrmpoYAp80KfwocG9nje9wVJV+xP6yFj4tvI4L11qdkaj4RnqSXtp/tkrW6E54zO1hF8ac3EZwxr7xJ1tUqOa5KOar+KPXFMfNiMM/P+xPcI3fZ+7F4VfFjZjQFvpcKKNcbDDh+DSumucumqlsMoUjHxq7hN91thAkVVwAReQvZAeyJNm4KaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Avu/WbCgMHj8qu3SX2hchGZIBQX4EdgppUAtD3VOby8=;
 b=HXR0s+/A9d37Q4LdCJn0CQf2XgIzB6nzNDy8woIyayFkv7s7oY+o47VZcE9V+G6ytEDErh4I/eTVHN2wcEQRmVKM/5PbVqZljncosNDU9wsJvICLO2cOZPeNyr9a5mlQnKMld0H9/TZmm7xe8NqSRar/lWnY8vj0sC13uwiaqn5DIdzDDhu6xFmvw5OxQ8msInlkDM2AZoHA49N1CLIYJ8VauXovSJIyEoAEk+bz6HeDr45edCq1mBSmQiX4Gyf+034vxPNoMi5FDAYcEyw5AihWZ8hcVE/qpGuoTw7XSvVPhW18uUK7pn+xM0cUvVr+4vnoLQ806X1tJNr6zofMjg==
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Tue, 15 Oct
 2024 09:33:10 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::44) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 09:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 09:33:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 02:32:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 15 Oct
 2024 02:32:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/8] net/mlx5: HWS, fixed double free in error flow of definer layout
Date: Tue, 15 Oct 2024 12:32:02 +0300
Message-ID: <20241015093208.197603-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241015093208.197603-1-tariqt@nvidia.com>
References: <20241015093208.197603-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 131c1ced-1db1-4a4e-6c89-08dcecfc61b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/xiOWFbrz9xhgWG6Ebv8kf+Z6Gc29TXekBHPVUuvleTtYK+d6FzrduC0szv?=
 =?us-ascii?Q?2yabVepkF7Q+BJN9grE4EmdcXluJNFccTeuJfC0KzQY7t9t/Vjo7g80oq0AQ?=
 =?us-ascii?Q?pjJRJYtzPSSwzH7vWwoJSecMGwbvQ3GaMP1lT7jiUzLexdCkA8GwSrSAbuWW?=
 =?us-ascii?Q?MsaUElprxqBAU21rfc526hAuLib8WK6OFNdeVBbT+wZvYUY5m0/Z2Mcb6+0H?=
 =?us-ascii?Q?eQFyeuCuJS2iMTkxGNZuHC97dErnJCMDHFUYfYF7gmx2e4a7fq1CH1cHQWtZ?=
 =?us-ascii?Q?Hu8ml1OyhOlKItCh+I2fvEsvnIdUpUVqjgxlm6X56/Mpy6gxFzl00qyrVyth?=
 =?us-ascii?Q?8grHp0TQk25JuMIwsq2PKglNHIaIyalKAe/chXn64rlBMg7bOdE4d5vF4LTc?=
 =?us-ascii?Q?9rZjMMF5SvY5QzC2PVQkc2VQTVwvyhJT5G0FviM184frURd/wYjAIoQSyN4B?=
 =?us-ascii?Q?NeR1X8d+rLuK6sdFYkYflM4PS7Isf6QyESK0V8SxW8Jnr+vcZWJ96glih3CZ?=
 =?us-ascii?Q?fwNeXIe1sP+r+UgQgPUx2o/teQJ0ufwpCAR2wGL9bucvhxbDMWpw1gF6BS8P?=
 =?us-ascii?Q?rGzdazQ3r7X2Mh7NAcooFXnWaiP90Fc3csMEHq+qshSuAHime6e7KT5V8N92?=
 =?us-ascii?Q?jH/YUBVoFAKyUJxd9Tukuk/JeU3xnNHHgbZNAq2+5wR81hbhChpw1SjcaoH5?=
 =?us-ascii?Q?+fWqNgy8roObK6DUgkP6oKwE3XYrRzkl1PTME11LR9by3ZEN3FSTjCByJI+x?=
 =?us-ascii?Q?mYMnF4aOT5yVqH43EFFK/Ss6Hk98IgH/jVG0INAAo9uGH1XXKCGqfXjqJuTk?=
 =?us-ascii?Q?JYRJ30e8wJY8YiD+iZMaJNiWvAXW33jxtlTbFzOpPGQK77XnnUq5IxL/y2o1?=
 =?us-ascii?Q?DuZKHevDdxtyQPP97xt2wAM8HLYX8wTL1iJEF2sHR5xuBpmsb+qkCNmiOAgd?=
 =?us-ascii?Q?us+t7laYwzTlE2NaLDuXGH9rJX/fijIAsTT9onnsK7PbRdtTWuVftL4qMDQe?=
 =?us-ascii?Q?aloOrBuFhbpMUFpwRkCI7AP1S+ZgwXHZAICkL4YkQ8Q80LKqkoPNGTaa03V9?=
 =?us-ascii?Q?ZDJchcVY7o7JxbImTq7WM47hxsR47t3MYf/ab2IgqOYANrUueCbklQ27DNbC?=
 =?us-ascii?Q?duIK60bBWxRfHK6lVW9pM0snuw62mWdywhbzK7PNHBVqZWtXfnUeK91Qp8TR?=
 =?us-ascii?Q?gqb6JbrBD/FN2yopQSJ05J7mFgvItCqXO97yXsuuy1I5mexwR/vK2kNJUMTe?=
 =?us-ascii?Q?fuP5upTkWHQ0CKjtzmmtSueZbeqMGiM+0hoBb4Nady18sorL5uAXsk3H0drI?=
 =?us-ascii?Q?PwXpl0/76QFLKNB1qsxJFi5Q5k/DKbA48Jie2qg8NGpqHbbja9becQvNR3o6?=
 =?us-ascii?Q?VBLGZ0E94sYnD8T7gipSt+dhdOCa?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 09:33:09.3292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131c1ced-1db1-4a4e-6c89-08dcecfc61b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fix error flow bug that could lead to double free of a buffer
during a failure to calculate a suitable definer layout.

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/mlx5hws_definer.c         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
index d566d2ddf424..3f4c58bada37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
@@ -1925,7 +1925,7 @@ mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 	ret = hws_definer_conv_match_params_to_hl(ctx, mt, match_hl);
 	if (ret) {
 		mlx5hws_err(ctx, "Failed to convert items to header layout\n");
-		goto free_fc;
+		goto free_match_hl;
 	}
 
 	/* Find the match definer layout for header layout match union */
@@ -1946,7 +1946,7 @@ mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 
 free_fc:
 	kfree(mt->fc);
-
+free_match_hl:
 	kfree(match_hl);
 	return ret;
 }
-- 
2.44.0


