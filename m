Return-Path: <netdev+bounces-98624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F98D1ECA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C258284341
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FF16F902;
	Tue, 28 May 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KIhXifYK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A39816F8E9
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906572; cv=fail; b=AiD69Fat2H5Pogz7UcvwngjpslRnwua1huZFvzx2IwuC+qIzGoFN5dQFhNwjxcrAXpIokud1evTZfkKWhJdlNLJIHd+tBeiT0HemR3/7h/eJCkycmLt0AG0h/J0XfwP22UTk14HTRlNpwg4RKn+fI6ktoIaYwYpBRYeYy5oyyps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906572; c=relaxed/simple;
	bh=K7DKs3MaTC+8JT5Wk/6rvHFuZDGHOxwkfCriWP4dbY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu7qa5uNnwLGiEr59Mtbe8nzBKeT+PI/wAhurd4C37MXhTBfF3LA0FxAscLF5aa8NFTsTJJ9pBZvwNTs8Rm+PAUwTdQRWLYsWKEQn9i0xqEcUaMJHCzNML/EZg4aggbXVwn82NwOExSqWOGDZpMg15843y5Ulf3Ce+6Cw9BMWxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KIhXifYK; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqcelrcDylaDb8Sior0dWo9PKalIDegvFH4uypQfd1/h4nJIT9ntIZvpXuLzIQaWe8uCKTVTuYErlv31ur5Izxr8y1Ji8m3RwqKpBqtdB8WXKijZBrtUZLdRXh669I6xbE0LI8cxA76IGm2D8Ftz7gNgl23QGxtBHdVKKrWvK4YBtPi5YIvvlrdmBwPLWppNgMJhVF5djQpcjOQx12JK/2JcnaA/v7yHX/InOmRq78ZU/+3CIrdY9Lue/v/TKh98H3ZLt0a1eyVFFFFndae+JtTtN6/dM66vufUf0Ow2xg/mTzjJuWcZxuY8N5hV+TKvvDwdP6fBHcUMrrRA7qYZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHqrWofo/hlfnqvgXzfWBB/ZBQq4Q7Rk1rQRut3vsL0=;
 b=nvAx6N020UcOwggnGKJmvqUpRilbjUoz8/ezmoc2VKXOGnuBnC9PPiGS+0/ZVDb281CGa1xFHqy/BbgRqapJWRnGBsIE2VtBK2MvFOWXm2yDFutAjGrQkmeit0oIzcaSwhMvJQ6mqDM7WYAGjRU86QSh7fu6KXxWveUcHM8eRnzN1GbQJIUy1h39qUX4PWZj45QpwMZ0LfxcdtbZPAho6NxsSsYPKmoYLpNfQ1Y2vpUJyuO0/kQtZ87t7gz9PpIG7646Wnn53hsRwIoWm9DO6qTk7Tk/NjEw94+gOrS3nrLIfdepxRA9l8kanz1uAowTNJfFzzRWmxx0KAQOnoQn6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHqrWofo/hlfnqvgXzfWBB/ZBQq4Q7Rk1rQRut3vsL0=;
 b=KIhXifYKOpduHlQKhk0eVSVnI36hKz9pAQX4CxSlStZIdT24WHNF6Wgm8BHHKdSOouWd7NL9W6tPcK90HgVTlebQru73jbBqf7zA6mq2B79kE8CKjqfXybcw0H8G7FpYr52e+TEa9I7Q6k+zoW96HTjS6BNKs+QOyE+UHywoeMSTY7VN26vXj0k2c1hkTT+RpSl7iwa9yh8qeYfgu8EiYvl/9Tc/c5zbg7xxssvNKJyKRm9BdFmrtB9qoBCp1yN4rvtmp9rXNDuZpR1IpvqtGMYZ9VS0uKzj8arH+Pfvp0VDe4EFw+BktT+x0ZiYFTOtZ01/i8lwDsf6i7dub6yB+A==
Received: from BN0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:408:ea::17)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:29:27 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::2f) by BN0PR04CA0072.outlook.office365.com
 (2603:10b6:408:ea::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29 via Frontend
 Transport; Tue, 28 May 2024 14:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/15] net/mlx5e: SHAMPO, Fix incorrect page release
Date: Tue, 28 May 2024 17:27:54 +0300
Message-ID: <20240528142807.903965-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528142807.903965-1-tariqt@nvidia.com>
References: <20240528142807.903965-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: f81acabe-8177-42c9-67b1-08dc7f229330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WKhrJeNWkrOebzuc1fDLeq0PlJuKaOb1YiL4D/C05AcRDlkSruL1EZMWcLPQ?=
 =?us-ascii?Q?6CtYbjdbCjxrcLughIKDGpPsA6xIZWNe3MBkzSyhcIpnjaMLuQgbwHZ8jyxW?=
 =?us-ascii?Q?Wocd0VpTYPRUgt6JrRXdgyUNdulHe37mLGDzi1K9KwfVtjP+rcn6Xr/eLZiv?=
 =?us-ascii?Q?kAKzyqw+AKG8nMd7pVvs8A6fvAVKxPggv2kBj3ARWo6uN+jW3BHxtm9en5z7?=
 =?us-ascii?Q?v4VBLzb37AnsUhhgDMkSQV9VKrw2l2GUQv5yXQ2PKabAcgAkv5vpySDJ1SjQ?=
 =?us-ascii?Q?Z1IYgUsuIOqqt6fFihat07rYBFZbiROqDWmTn0QZI5jwIST9/qr3mI1T5AhP?=
 =?us-ascii?Q?WgQyitwgHUSJPiu+p0VS9py+rBWJy3L4jUsG5es7pslfSwgFb09jJXWEUePS?=
 =?us-ascii?Q?+N89byB2T9Yj1ggkHGcv701aRM5WvoztPpWqBAr5OQqsCWo4wDWHLugZ7nRT?=
 =?us-ascii?Q?l/hDK/v579fIxz5fgCkmd1PBEZx4HPhWtDtVzfIqXVrc5LLf0Il1nSxcBbDe?=
 =?us-ascii?Q?EnFm/M7PFRwdhWwZR3Xa2gzs/gXPi+Oj/RvuTo5YQKf/eJe1cFm33TtH/cOn?=
 =?us-ascii?Q?tewgiuwECC9BolEjD2yZw+g+JEAcYlrxSgl0g7vGc/s54zLOo+C1ot3NOuF8?=
 =?us-ascii?Q?7hCEduqY244cw8w6I7STYxKWGBh7T7a1WnT15NGQXouQAaqrB1P4NkOxLhJL?=
 =?us-ascii?Q?Ya6NCKEliiWgaTTQKfttJhQjIzUwtXaFYNs6hvtsqng4zQOx7036zDm5r7Io?=
 =?us-ascii?Q?KUsDjkjY/KhczemnhNJKC5cwZ9UCRKUR8btidTIv9KlD9uOogQXELtzXsvBP?=
 =?us-ascii?Q?B0s2QEHODNuKMyuSAUapcvknJfs6kqs4vf0Z6uNOJbCCdZYaYbWny5yYLQwO?=
 =?us-ascii?Q?6BMjMsRHnPv7B/pGTowA1abdoYZWZyVmyiAj8ujfk1mUiL2qkM9RRUaaZKXG?=
 =?us-ascii?Q?Jn8SDz+lkVTWed5SNPDg9ksUhjeCeq906uTcQgjCqMH+ahBqw//URGVml2y2?=
 =?us-ascii?Q?5DbyTHO7jkC29IQfaIocAx+0kB1obbR/6AE+zkMeWSic92GlaC32ZWpqujsi?=
 =?us-ascii?Q?M3X3kEOJCSxYSRe96bzDKB3dVLHzlt/Of6n+tFBve+Zcu3z61xAqaeIRgcLD?=
 =?us-ascii?Q?VWp1PQ1IH9EVtnc9K41SESHCzljq9grGEKsiFfrYrTHRiM5u0U4EWyatqMEc?=
 =?us-ascii?Q?1huVzkpUcQtleYJZ1nAKMHUScAyGO2gVza4BsmbZ6UzgCj5KtZqemT/oTbZ+?=
 =?us-ascii?Q?zEZxGWRHORO5HxZ/4kme5sewqSvPlVXRxAA+G2uc59mtTyBinzkB4jaEKlIS?=
 =?us-ascii?Q?xDzaVvi8mu0AxcA2BjZUhzRUEsgM/LDLEoq5+PRuzKTgRqxMQu0nkU4+x0DQ?=
 =?us-ascii?Q?IfNZ5l4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:25.2618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f81acabe-8177-42c9-67b1-08dc7f229330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517

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
2.31.1


