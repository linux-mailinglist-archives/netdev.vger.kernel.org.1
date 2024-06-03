Return-Path: <netdev+bounces-100354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB408DAF1A
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BD285DA5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58613BAF1;
	Mon,  3 Jun 2024 21:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GDmltgZj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3895713BAE9
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449817; cv=fail; b=GZ7LGqUcyMjq+2klgB21AEeu6Igq5RMizLOwv76azVDEnwHAqaSe8sTplgOqUWyw2qBdA/3/35OFoEoEVgLbvjaQg6d/L+b8ifwWpR4v0GZvtoTE2BPtHdGdYcUb+Hsa4fTCc674mYnAG/csfA5SkEF+ND0bHgK33u6JNy4JYvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449817; c=relaxed/simple;
	bh=1FthCNNOGz9oK8pgeflZwE+yh0oZjLKXa6rzu6wp3zU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hy3Buy4E66MlH/L2+sys7Y8tw9OIJbsILhHF+DhUOXcvWQRPE77/YjKb8x8pK66nLiLIQkWpAvMkzUnMWlH4d4v8AxltcgaXiu+zxjXAedj9c67XJl/Nfl5mfRF8jNzeF96ncWOp7bzP9tLDcWbT3/iDGOC0MOtW9ji4U+MhEus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GDmltgZj; arc=fail smtp.client-ip=40.107.101.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pcs3Reh5b6Wh8OInKtzamwzt8n2WzzkP4Jy2AMei4Y7O8bWUqBddTrleC/z/HavTwpB8hk3uYNVv6r4aCcJtIxnYXI4BOUhC281xk9Fk8WWSvOMrKF2iHMh1V8RB0cYjjzu4Tu4rSvtnoTR0GeTdSp7+MJ4WlEKsZwwr1H15u6Wf7O4vlLjkZ2KhsH7R9ab43URzGL5J9rhqJ5NgBMp2LkF82mC3qRGceUg5Fdi7h8MukU6oeirm+X//RmOx5UFblXAUoTyF4ToLwfMrXpHZm4FcAkMZyfxKgL9Kg/u9yZYh1qForbZ53r5RdzZ+eoXC/kuxjbLrjgaAIqvrPFTn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEpv5Oe5uQGIYCqrKy677HqrURlXvR5fDfWejtUkfCA=;
 b=LS9+rL1sAy8k/trpTRXIYnKWi/bMsZC000cdf9LWsMnNdNGzQOD8EMJhc30J2CDGpu0W1tsDeN881i3vLIaYTiR+Q2Q60zhLAgv11HcmwFjpfZMv0ycQM7FbBFhFnt0kiPEFM1IQnAUb0inr7riWpjnZCiY5SLK3T31dC3QtOXz100EeDDKVM9q1qUy81uQtjxwibxCs5oIeq7Bt3nA0c6hwjUFQlxxT22/AT2rBZ6UprocNrHnLcK2gTXLUKl05VByWzgxDimHxwCusvnQF5kEA10wRiU9+GwbJargBcpMiWdcOHbsDeR956OvcIGR9RqyLWTl7231PNcuS1gVggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEpv5Oe5uQGIYCqrKy677HqrURlXvR5fDfWejtUkfCA=;
 b=GDmltgZjGJ4T7JHyNDkmOLvO9n7Up0frHA1IY93RrSetJ6docYHqknF8IIOpGK2IMfucNGYUYUMnnWv/vUOohcbZdl667ZWvg8l33RbuZIGxzkXHI4lfDXbv8Y5My5u8ww7JEqSDja284JxnvDa1hd2jpmY3QzFF79gDfdzTPTRbDzRJAZQFptJZ+QQwdBhJKkw7YpDgnku39GZLiiZPWumIj/TD169xi8dlivUntzM7Iko2YV+1BpiftDiSESquNdkuxlQWfhWRR7OP/Wj9y9WooZ8J87bLlAIV3jBRCsNotwMm4N0UpnjFn5dsRhTjpZvPBim3BZKazktUAIeKIQ==
Received: from BYAPR03CA0035.namprd03.prod.outlook.com (2603:10b6:a02:a8::48)
 by SJ0PR12MB7457.namprd12.prod.outlook.com (2603:10b6:a03:48d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 21:23:33 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::49) by BYAPR03CA0035.outlook.office365.com
 (2603:10b6:a02:a8::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:23:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/14] net/mlx5e: SHAMPO, Fix incorrect page release
Date: Tue, 4 Jun 2024 00:22:07 +0300
Message-ID: <20240603212219.1037656-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SJ0PR12MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea1638e-4867-4347-f3c9-08dc84136bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+yMa8KhDj6AVtO+X57FXp9Z0gBxN40NZD3Fsu1AQWxeQWdL3Eaw5sWXWaJh?=
 =?us-ascii?Q?nKqq1XknPLsIPxRGl2pThGUeFxeNHFOgwacKBJMKZ9Dt2ebvQyRd1Sjw6of/?=
 =?us-ascii?Q?cKfCi/09QYb6RY13UYVcirJ1/pGFINcOzKGupaaiAXS0p+UX7VWlUNyefdce?=
 =?us-ascii?Q?zjFPvfAAwqBiJbEnyDnTlLh27MUe0czG960QJhYYAS+ii10M4lC+bgo8vqXT?=
 =?us-ascii?Q?HAbtsWh4R+L6jaO1yRCc4NuWuzk2NoXmV5cnb2xYR5p5WHMMKyCI1D9WtJOH?=
 =?us-ascii?Q?LtwlGp7Wh+VMyv382CoTCiOoD9inoTJQ+BbPTRMwRG1jv+AGNpL8JgRBnkSz?=
 =?us-ascii?Q?rRiP7g0O2iy6mLkA/rFP0nXD+3NlU3ingteqH3ETBTkrbabinWU8A3HZrAw0?=
 =?us-ascii?Q?0SWD1eXeP5DMVjPxWCeXUYuiBSBy+ffkyHl1rFX1x9QAmoAJanTqE2f46AMZ?=
 =?us-ascii?Q?iDEVCIP1stQBk1g/+gFRLpQaeW+8pWhOIUivyWP8WwczhQ65aBJA4AY8IKbe?=
 =?us-ascii?Q?AhDbdqImbfdpNo1D0EckYSHBRkhC4mq6nsgoGsS7UI0eUH1JS2GmPLeYPq70?=
 =?us-ascii?Q?I/+/14CCXZDuxI03Amd3eRUoqTwgcOSEmC7wAp7YxJuJQ5zEebwM4ovd9XyA?=
 =?us-ascii?Q?IphHUUQWoavnsZlYfgQPdVQQ9A6feB59/rTKvB27Sq4QxLDDU7mdwvsGmGmo?=
 =?us-ascii?Q?Vt9j6hLha268FSNsgZESM3uEAf72YZ6sKDhxccyv+djX9tTqjN/Pp7FsmDdA?=
 =?us-ascii?Q?11qIEBBUc09/1U57JXFBeA/Q2R/C+Ft9BYqQk24hlY20FOB9Vx6JTJkIe6Z6?=
 =?us-ascii?Q?GzlyHzuFfyPCrfzTLYLY7UWVtlS9X/X1ZpHAaiq/pHDFQmo2mITxFRDrOwze?=
 =?us-ascii?Q?BKfcRW2TRKUTA2lhKPlCezAlNwiHtj4SKrq7oEXC2PSfPUhnkG6YqqaIT8/B?=
 =?us-ascii?Q?TZwIuyFAmsy2p5ZUyN/72ytBE5mzsIsOCW3cTkYA4dYYkp7LaHoEnm3ABxeM?=
 =?us-ascii?Q?neVxBY1xAe1+/tIEbmGaMYcPWoWLMv06MJDf2UntwCTp040jAlN7YUH6PNul?=
 =?us-ascii?Q?gzPkW0Rqt+o35PU7R8xS9asJJIMuOLXf4rTSSmfyrJkfFM1sngQ5q+0qZte8?=
 =?us-ascii?Q?HW+1Gt66PrtMBhzYFgX6n4FX8BKgmXKQBg77qn3lDYRs2cbdIgoN35ao2uJE?=
 =?us-ascii?Q?MyYDI0qre1jYX/usa1E2r+/3DBRtjPuzaPcOvhttxecvyDCs+7AWrVUTi/FS?=
 =?us-ascii?Q?4E3leC1qaBHdxMknoRSD7FYhzVj5v4631LAr/GfMkxpTNNfuz2/yo5OvMXqz?=
 =?us-ascii?Q?1NM1AMCgMctOWG5o8oaTdNQzNdVAkmCjbWlEzk/nTkLUIzDkCDAVcuGzVe6r?=
 =?us-ascii?Q?10okQXY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:23:32.9456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea1638e-4867-4347-f3c9-08dc84136bed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7457

From: Dragos Tatulea <dtatulea@nvidia.com>

Under the following conditions:
1) No skb created yet
2) header_size == 0 (no SHAMPO header)
3) header_index + 1 % MLX5E_SHAMPO_WQ_HEADER_PER_PAGE == 0 (this is the
   last page fragment of a SHAMPO header page)

a new skb is formed with a page that is NOT a SHAMPO header page (it
is a regular data page). Further down in the same function
(mlx5e_handle_rx_cqe_mpwrq_shampo()), a SHAMPO header page from
header_index is released. This is wrong and it leads to SHAMPO header
pages being released more than once.

Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 369d101bf03c..1ddfa00f923f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2369,7 +2369,8 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	if (flush)
 		mlx5e_shampo_flush_skb(rq, cqe, match);
 free_hd_entry:
-	mlx5e_free_rx_shampo_hd_entry(rq, header_index);
+	if (likely(head_size))
+		mlx5e_free_rx_shampo_hd_entry(rq, header_index);
 mpwrq_cqe_out:
 	if (likely(wi->consumed_strides < rq->mpwqe.num_strides))
 		return;
-- 
2.44.0


