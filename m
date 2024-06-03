Return-Path: <netdev+bounces-100355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603698DAF1B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DEA1C23B53
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E878913BAFA;
	Mon,  3 Jun 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rqwfwom+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491925028C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449817; cv=fail; b=ozhMaPfnGD8M+wZbMP2uYkKpzLUQe1gWJZQXmwk5UOlCpB47qYPja+k0nyG4LlbI8voNEK58axEu7srAUQbX7QlAbjJHT6RY7J7OKBynzxGbZK77LCyMlK2e0OAtWC5ev72L7B+4kSPNtUVn2l1epEFI9iNOPdUbVI1f0a8GsWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449817; c=relaxed/simple;
	bh=dBcJ5HZJ3dF+jU21Vp9+/aDLLvaZmpTAJhoLSal4hVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWmygQZR5ZKcviVmn3XzsLRaWWnGhIJkdnbHMQShLpYfE8hwQ69FLqkZB8CDeFVulzd+5Sc9OwGXnaPPiTH/eaIHG+0hAmHhqvwcbgNrU4h6w1qpYGnWAfOu4PNdZXmDwB5K93WbZjhNoJ9maivIptSmFPiMwxN/ZYH8GUedGEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rqwfwom+; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu0dSvIO/wZznOVrs6qLlkAuWnw0yQyG+anDoghZd3+5ecoJAhJUB+LbXL2LaEmJtZscVq/IUYsxshYZ7Iz4flkww4vW/fErp+/PKj2122nHUhHgmqd3RaOb2Ad6Qk9Wo9S0w6MzmPxVzMRfXuSdcJVcy+pccF9gQxQn9QGfTfAmhUM2RjcT3HQUtCd0xSnvtP5NMMkwiXO2utMqEK/mOda7dCJXLqmL8IyqP6zD/D35S39hsvqQjTIq9yNZ0u8j2emmxiAeAmobZQD63kWrJoMxKgqfJTpLuqFDEa6dNaWdV9dX3Y4s5IZgbs/IcMdKD+yqt8c9aVvBCzUWrUvMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gx9W8O6ul/nmUvebn1ZsRYwUCjIViIT9f730nvBjrz8=;
 b=Y2qCJ/LbPVp1fe0/4HiNy9t7lujonHDHc4NY9VUfb5uNGgHQqjc8tbEvAnB2IKuFJgHEKvoJKJS1alGk4Fi80/lvKAbOBWIMSy3JINY19a37YKPpwwFRm0ZpoeuXTE8Mw2O95mE8NthdsFB0wto3O05D7lE6+nHjZ4ntXvf6wxq45R2uCAI0mP2p0FjjkAvlexMsh9fboTWIdRUDdTtMsY5KGPs5J2y5CQkN4OrcsASwT7ClRNE8LJFb14VUue4wFmpmL+sLaOO0WXC9glbb9pKmYm2KGzj57diChC/94rLQEtpgbMeW0exiK+kGKej2REutOtokDZoAvXTlEhTKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx9W8O6ul/nmUvebn1ZsRYwUCjIViIT9f730nvBjrz8=;
 b=Rqwfwom+ydL+kGwI/fMjL7kJz8VuVBwrsfwjz0weDWVXVxnDn0Exsfaoldh6GPG9dbgHfHvAK6eGZ4dyMXr+QGyOKonStwcSuqzxr6gJdJB85N8nGhvx/IyrDZWjo+uQmObYOdxsHQhK6xBT8yn2KIwFkVM72sxMaZSxPBHuN8EGprEkeVUmEx+kTxz4/ZvUwSZjD3dTo+qjNNDb37YmGFUfVysXp5EBeYQwjGTj9puBpqlhk86NPl5royCgjlxKlLTLV+KmK3YwMd0MTlcQu1hMCCMB+RaQkFCYYBBqTmGmXVXSoyNRXXt99K2K5f4BW6InV4lzoVTa4XVQQeNn1Q==
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 21:23:33 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::b4) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:21 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 01/14] net/mlx5e: SHAMPO, Use net_prefetch API
Date: Tue, 4 Jun 2024 00:22:06 +0300
Message-ID: <20240603212219.1037656-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240603212219.1037656-1-tariqt@nvidia.com>
References: <20240603212219.1037656-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f7b39ee-2d2c-4e00-89be-08dc84136bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wGd/uVFumclQj5tidV3vstX8MqxcVg1IxT3at/Do6wSKAw0GPBH0hCk3DFA7?=
 =?us-ascii?Q?q+QKDyEabjQe8yXRvNrhsEJBCBa5Bheql/nii9CqcF78g2Ucm57+d+jeWvQM?=
 =?us-ascii?Q?fWcIi75kDfo8C85p3BlgvJFvFnT3KrgsIn+vWxAGL82o5PkRkDfdUnnw+/Eu?=
 =?us-ascii?Q?szPQ2G3sIrp6W+EXYhkaN88jXim5sQ44w0gNmSSQdVwkP9CIlyscQZcpTT7Q?=
 =?us-ascii?Q?BRgDW3pwsBxOe4GuZsihhlMpk819OUVxEurZltoayMu7WnPIhTL+7JXAxNpP?=
 =?us-ascii?Q?8eXj5tF3sgmCIweQBw6z6pDv1dR6MIdqTOihyhVqxed8vI25O4tX9q3GP4kF?=
 =?us-ascii?Q?BxEqbIZr8DpnD/bTELmj1XHcrJC2N5zY2eJ0fkEd+RfQESBv09vPRKz0yx/U?=
 =?us-ascii?Q?dvra9i+bcXI+a8LGET1SDf2nyeBOAK0RG4aEFMvYcyiZv0zjUE/34qQlGEv2?=
 =?us-ascii?Q?Wrk7lDaaUvxiSP7t7ThqKHhn98zpEKSpqBAywvamLHrmVHO3NZ4pk6Fr6Gum?=
 =?us-ascii?Q?oG9ZNyUGwJNhvvlcpsHeUMk9HchEClVvsq2g8AX4WJ3O1aqcCUQaYQ+1y6zV?=
 =?us-ascii?Q?zURub3doy7rOZ7CRVcozToq8Fsy06LE5VqK8qBTnGfPwz2/L5SuU4XUUlXYy?=
 =?us-ascii?Q?F4QJMf0FDAvJOFsUqLQkLWQHE6x9G+vlvqt1L81XFKkOrwdzJFJusubnSHg8?=
 =?us-ascii?Q?ur7c6Y5h1FHhbdlXvTdh3jixwOgAfDkNfTnxaBNfhx9Df+SKAZpbaq7MfWSl?=
 =?us-ascii?Q?/QVjqf9b0ASwoEku+WfQ7dA86CeOOkMPOFPLkz2dYUmpNooLjRvpFqER2NsK?=
 =?us-ascii?Q?qEuDvIW8gv7qODUji1BoaTEKrh5GSagYBc+p9H9sIryNzPLjMXxPp6JNvLMm?=
 =?us-ascii?Q?S4Yzqs6mFEa912ZrUVNYHARyWtn/FGRqAj1tAct/auZnh4rdRAe1nbg6ejG9?=
 =?us-ascii?Q?NJtRaJGMl+10+wJZUmu80zDUaoea/uf1t+E/jub4AQJiQL1V9eZ8GOU7dImh?=
 =?us-ascii?Q?fvNGx0eDlNF3xgPSaH7BNic8d9av0xZL0XPMJII5Kkm4G4hhIKqCsulXr8T3?=
 =?us-ascii?Q?jKKpT2fdNSvdgw6NcyJgTplw2EK5SKxKjleFkLramXuLUnzZLrpKPrcOTnun?=
 =?us-ascii?Q?NDuPNuflgmJKF6LlI6nHCqqeFA3/TcyOa9xHjQA2YweNIB1ghm2X0a+LIlhn?=
 =?us-ascii?Q?c+kdPv4RuNMUx/WOsQx822/2I9aIN02gnBIsntBJHftdNfMdW5uD/w0ZTxvV?=
 =?us-ascii?Q?+9qXvVmQEMyAbSaCQ4E2dotTgZfhTJixnlfDne2mu8FvnT64fgigOIsr5THY?=
 =?us-ascii?Q?/QAfs5zwQbhkaoMHdLONe8elKkyhpU/AdoFBeb1ZPAmWpe5Iwn1kY70kPE+T?=
 =?us-ascii?Q?JQvOq5c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:32.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7b39ee-2d2c-4e00-89be-08dc84136bbe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

Let the SHAMPO functions use the net-specific prefetch API,
similar to all other usages.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b5333da20e8a..369d101bf03c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2212,8 +2212,8 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	if (likely(frag_size <= BIT(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE))) {
 		/* build SKB around header */
 		dma_sync_single_range_for_cpu(rq->pdev, head->addr, 0, frag_size, rq->buff.map_dir);
-		prefetchw(hdr);
-		prefetch(data);
+		net_prefetchw(hdr);
+		net_prefetch(data);
 		skb = mlx5e_build_linear_skb(rq, hdr, frag_size, rx_headroom, head_size, 0);
 
 		if (unlikely(!skb))
@@ -2230,7 +2230,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			return NULL;
 		}
 
-		prefetchw(skb->data);
+		net_prefetchw(skb->data);
 		mlx5e_copy_skb_header(rq, skb, head->frag_page->page, head->addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
-- 
2.44.0


