Return-Path: <netdev+bounces-98630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC08D1ED3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4651F22E3D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213016F913;
	Tue, 28 May 2024 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KvIEM1ww"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36216FF44
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906594; cv=fail; b=AWZ5nNX6Wq+TMt9iXCoAegBrX+dGfoc9LxC/y6Df3YWXBzLM2BRrQGdM91qXij9YD1wCPKcs0aMN8pjaUA4fSyfKO74smD+a6pJ1UaIzHgKpw1eTOIrdVrGujX5zVJr+v/EqQf58kYA0pq2BSG0amS30YiN+cymt9npAdeRlCeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906594; c=relaxed/simple;
	bh=eCbjVl5fYJuHGs/Pz9iO7PRDQH7zGOK/i543bCTkxZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsAsoiTl/G9M+BQR5tX0nGTGLUfDB+oNVRblBwgtMJoGp9Vx6JE/z+w1COzDJlTCkI+JEEzURAac4ME4X329f2Cw9/Pt6TQu1F6I8ET5obLN1vPEl6mNOfUSsVLgGprKARngcRoFz6nksp5c/HTHdTuKCFZTqC+rXeUsLThmgzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KvIEM1ww; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuCVS5Rfi1W6ncvZPeeJjmxsKTV+7ey5zAekFMcyfVhvcb4E9JSUjUugn5BpkY9/GSBoUzoAuHo2wET7bwyBsvhwNR1KOj6VZJ2qoA0FjaxK/TFZa/OQ1Xp6Wp27UI3jjl02gfAga3Lgfzrje1R/oEF+2zMu4oVAU9DJkEZPEE+Ci/QE4zZ7ZoQQR86GpnGuHQySoaDotbCdxTP+X0qpO+hskCuuxq6+Iy/4kzQ49dYsyvL/eMh/AbP7EtuhEzMVY0uN9Yy7a4w5LhhLQYcJ1mjgAOjw7Gfgm/kY0acupizsQwtJtGtzcxisN0kWPViYrCCJUvWapy4hHztr9wN7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78HNFGikAJdJ2/MQJMKd1hGexFtdvWKPuARHEsdl4ZA=;
 b=j6f6HiPGqjOISkTX6qbUjnOlQZnd2qZuC73YusU8P1Fqh7IF+2MjSbb+gFflJrJESU2VKIl72GglbxYFBqHxJAtPSqooKpIOMMQDqrkUvlDPVEDlf3tm7JP1eu2dOToL4hSqtw4asUun5M6d8HU1c0wno5S2WtTwfqosfqzDSoEre4JPNSjny+fGaKIop4WoVdh9N8N61S/UP+GspOR/30E3LHy6V7NXfIH2qcB2QcVA+ixGPaG0XlASxe3cIzTCgrqO3zruy0R6bLQCaEhFZ+m7TwdteSueGNKXg9/6U/yRITVLGXQr8U6nXAcj84YXfseTBabrDEx2i6Nu+PHzPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78HNFGikAJdJ2/MQJMKd1hGexFtdvWKPuARHEsdl4ZA=;
 b=KvIEM1ww+MLnuLkyHm09JCPfj7tq7zDqIj3xsyjxcoeaDSN5203vaheiEMrg/8iL+GjQgxHCzIjLOctqpAnfbC5XqTpD5JmMxq8hat4zcN5hEAKAixSxMAmNMfHqMJpCkoMI8KfOvrcQ3d0X5yfHOj3uB83XBkZ2BhPP5mtyAKPAOr+5FJtDT0rQeORwyq77W2ggdXGXiZOHnMx1V7ogn2124zKsLDThyqbY/olZGczQmxoz60xQbCentNr+mj7NCR0AbRrDzShKPD7OFT65ej2YuHNJkznOy5b8BwHFAnAEKmT++aogebKTbL3kyjogOQqTa7w1MhBnQ1M3mJmyhg==
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 28 May
 2024 14:29:49 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::bc) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16 via Frontend
 Transport; Tue, 28 May 2024 14:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:29:49 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 07/15] net/mlx5e: SHAMPO, Specialize mlx5e_fill_skb_data()
Date: Tue, 28 May 2024 17:27:59 +0300
Message-ID: <20240528142807.903965-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 250c3300-dc71-4ea7-89e0-08dc7f22a1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXe3XxGhNZYBelJuKMiDO/rGtpFgBcMJKTghpcxGxI6WrndHrAU+FKxsIWsr?=
 =?us-ascii?Q?xJT4EtcOeMugDB1E28Q/DhpjH/8wDPMRct4xJ6W/PiSBSj7YEu10mPH+3Fau?=
 =?us-ascii?Q?M8rWI1+Keudr+Jzob2bT4jm6GGJctdun7HGA0/vqoRS5KH48qtISVXktjlXE?=
 =?us-ascii?Q?G3Bn6e8BmMDxhGCqGo5a0SwyBLrllI/G1MNiefmb8fRwSyuUcntddyONYnMD?=
 =?us-ascii?Q?t9lLtlR57Y8hu2psWfdS3hRZATVexgBlKG5/WwnDClBSIz3s/jMBe/K1gTGr?=
 =?us-ascii?Q?F+dKiF41UsV8V9alkTq4JDy+EIRcyqEi4uI2mwCdTidrdcBkzqXi2qT/bnF4?=
 =?us-ascii?Q?DFbGBJ7y8tIv8kNlx6MoKnfb5K9TFq0IdAW2RNIBylo6lUX2QEGzQ6NrNP+1?=
 =?us-ascii?Q?c/WMH1Nf+ObpRZl6lKqQynkp32mMZYR3kVUHIxBr4uyrI64Ie3JMiJ4+L5dp?=
 =?us-ascii?Q?ukpIlQ78Cl9iDnhZxIq/ktkDG8PFedgBCHWIlpv/6SvFPjteH89qZZlib5lF?=
 =?us-ascii?Q?piwkupxY/ZKOVVeeyRv4qjolqeDGuubrfbwybWf3hCx8PGrdh53h+SBv67y/?=
 =?us-ascii?Q?lz9UkJOtwJ+sDM1l8UGaW+ZodGqzw79Rdnm/ST39rvGdimKIGXb3qps2KfNb?=
 =?us-ascii?Q?cJXu3LTYotFHURHHFJEXoZTSAy0YClkQUXMj7c138Tgm3uaEPI2IQqwuB273?=
 =?us-ascii?Q?Xka9mIYQZarXwUlkNkkiMcqWFok0gDQuCCtxDLg/36IDSjKsw3mcRBnSLsF9?=
 =?us-ascii?Q?iiF9y9JxWHpVrhgm3WFIF1lrCZ20DshnSpSG8Voz8GpuiWGhYTCwA6Vya2xS?=
 =?us-ascii?Q?1RaP2us8yA3R7cNzMikTVn/meW96ZpiNwXOp7YqYxMhMRd0JhCk0dWClkRiD?=
 =?us-ascii?Q?DlK+zh8SEAuNpURg0K++w1LGINkV46lQnsYqO3QBX9M4+XgimObyUzhxo9Jd?=
 =?us-ascii?Q?7qcbF2YTRiq2UeHZctDThJunPi/HisUC6WRfeAD9h+OL+vC2bGYWHZcCwaDB?=
 =?us-ascii?Q?gNhTQEVZcBINs2H8HMrdoAgT/LTbJUbU3m6jqTWT/SKDc0HTvCIE98aIPUtg?=
 =?us-ascii?Q?UOKPL5IHBRKN5IDP2rd7StAH7eqa9xK0iCcpb9KGEvsMkk8bnWISB+A4omx3?=
 =?us-ascii?Q?eFdbNRTOrtEpQ8RLWgD2chvtrhQ9Fg8mPQrhJAZupwu0W1iiu7L2q7iETH2B?=
 =?us-ascii?Q?in6OU12sZg9uOiSpJQZHaprIU5mUyORDL87DASY/j663HH5FGuiNZzKkmtd/?=
 =?us-ascii?Q?atS2+5AgcASIgcymfER2IGw1qi2i0Uy98evwCiCUN06IHFb0/wDcUOUi2YxP?=
 =?us-ascii?Q?3SSKq32vZyj+71hTWx276363Prc3YvO6tBMAOdQWASvYgR/sKihJam5ddTcB?=
 =?us-ascii?Q?GZAOdUh6XutMjS6H1K2EFoTD03Mz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:29:49.6113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250c3300-dc71-4ea7-89e0-08dc7f22a1a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5e_fill_skb_data() used to have multiple callers. But after the XDP
multibuf refactoring from commit 2cb0e27d43b4 ("net/mlx5e: RX, Prepare
non-linear striding RQ for XDP multi-buffer support") the SHAMPO code
path is the only caller.

Take advantage of this and specialize the function:
- Drop the redundant check.
- Assume that data_bcnt is > 0. This is needed in a downstream patch.

Rename the function as well to make things clear.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Suggested-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index bb59ee0b1567..1e3a5b2afeae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1948,21 +1948,16 @@ const struct mlx5e_rx_handlers mlx5e_rx_handlers_rep = {
 #endif
 
 static void
-mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
-		    struct mlx5e_frag_page *frag_page,
-		    u32 data_bcnt, u32 data_offset)
+mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
+			   struct mlx5e_frag_page *frag_page,
+			   u32 data_bcnt, u32 data_offset)
 {
 	net_prefetchw(skb->data);
 
-	while (data_bcnt) {
+	do {
 		/* Non-linear mode, hence non-XSK, which always uses PAGE_SIZE. */
 		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
-		unsigned int truesize;
-
-		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
-			truesize = pg_consumed_bytes;
-		else
-			truesize = ALIGN(pg_consumed_bytes, BIT(rq->mpwqe.log_stride_sz));
+		unsigned int truesize = pg_consumed_bytes;
 
 		frag_page->frags++;
 		mlx5e_add_skb_frag(rq, skb, frag_page->page, data_offset,
@@ -1971,7 +1966,7 @@ mlx5e_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 		data_bcnt -= pg_consumed_bytes;
 		data_offset = 0;
 		frag_page++;
-	}
+	} while (data_bcnt);
 }
 
 static struct sk_buff *
@@ -2330,10 +2325,12 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	if (likely(head_size)) {
-		struct mlx5e_frag_page *frag_page;
+		if (data_bcnt) {
+			struct mlx5e_frag_page *frag_page;
 
-		frag_page = &wi->alloc_units.frag_pages[page_idx];
-		mlx5e_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+			frag_page = &wi->alloc_units.frag_pages[page_idx];
+			mlx5e_shampo_fill_skb_data(*skb, rq, frag_page, data_bcnt, data_offset);
+		}
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
-- 
2.31.1


