Return-Path: <netdev+bounces-86253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6C89E31A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33511C21252
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E3B157E78;
	Tue,  9 Apr 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N+Aa+/cH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB75157E7F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689787; cv=fail; b=VUAK/6nvRQGtFHHRrfyI+oPVHQ0NUGeqQZs4T4T1WodxiIEYj7jcmEBRaCZn+envdOLtF70pigbgAwYFm9kBzR3Llt4owIIFIwsdV9igWB6cyCCe1mmzxpiMOzhYtlZYS6gPt5tUKo2RAlLwGW9kAlsObwxr4ztsZYfodPBaeFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689787; c=relaxed/simple;
	bh=SoPWldYEMOLy0LFHbHVw7F2k9zWrI9mszqSttOvK5vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjbLDgf44SW0xnbdYaO/3iOtoeyrMcgBl5YhYvYO1uzZvAPdmYKF0hIHTfXXIhChF/kr9/JpfvXe069zNM4N/hmOWztYdy1qs1BELk84wAPxCbWGHDzOT04luoKSFhnBJ+uev7ddlo95RLaCt0oFK4ivTc30Sy+I+s+5vsMGRWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N+Aa+/cH; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS5Ne+VOc6GmSwj2bd6XpMVCN+TgccR113JktiTSyPJFR/oxdr/FYKUw88pkn2G/2+mEP0nviNBZWZPSULYMwh4imsIz8blGplOgO3UO1ujG3l/xTCatBNaBzqLc/GFgaaPCYLPREt9mxbYhdm3qG/+3RLIFNhoMBKQHCow/Yuw0xiSLPXF8Uw/thekEICgluue2pgkriYbbWgvmNJA5qlftk9EEKD3GMAAubY8z4xWrlvQJ1aKVqXMx4ioUxbGA4/riUhuz5Gff+osBHp1FZFKfzXtrMgURPD1rLH8ZDhgtVp72iL4G6Ml6gix6Vd/jbmX266zvAbhXBppQbQPclw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XllesOPOBqKXZhUR0SL3sQptZ0yO+05IjrINj7jYog=;
 b=QEB4HSHE+THMwJnqCBWyqPIBxTriK9UaR2Ue4naidOl9wMWEmwEZHzzALmHmBWvFEExLlyB8Tay7YlquoRnMCmlZOxE3peTDFNk1cUe7b6FYDc+MGA39DwiumWsYW+GqnhBCjbeVRpoKm8vJ3Y84cWsSVdBWhVmNBcWB+1de+fUsfXqhpTFucXIy28Owws/6nwn2Gf97DsySCt5urYrswt2upNpSBNQMgiZa9JJgV604h1ZmaSArymFgxqiIBQH7Q0JuugH5cuPOgxpg+q/1DLCGTpAPWuMCEUJxU5CapfciqvIr7j8tfx9dxVNTrNrQTEXLaTxx7qA7inCJbLppaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XllesOPOBqKXZhUR0SL3sQptZ0yO+05IjrINj7jYog=;
 b=N+Aa+/cHion7L9Nsq9SdEHJ3F2FhALMtvkLf+s6KFhAclyzBozsHz3HDInHgxSScvxFr2VIrQgsJ48evCRwZdrbd21PxsdT5fsWE8w3lTJru3OixBO9cGiQJ/Wwh3tuJ7EsIyTnE1tNsyhDKon1ZYSlFw0B2gsu0VsDzjoPBnGYsQS0BxvVZgAFqp3b8qDP3ml/IwDZrnx4MiaiSvY3tIZZWUnVtqPgieI85fg+GtIn2ML8y/TpMQ/SmUp9es0BP7EXXkDYrzSOG8C5rZYZwUMNkPxcTuI/WWSMjNLHlemY2MU5Za3H3neq+6e7Ydk65LHdRocq1Cp66h/AzMDmycw==
Received: from BYAPR02CA0017.namprd02.prod.outlook.com (2603:10b6:a02:ee::30)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:40 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::f5) by BYAPR02CA0017.outlook.office365.com
 (2603:10b6:a02:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:12 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 09/12] net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit
Date: Tue, 9 Apr 2024 22:08:17 +0300
Message-ID: <20240409190820.227554-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d48952a-d75a-441f-1dac-08dc58c89b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bqZ8oeTtgbMat8D2iQo0Us38ZUvmgMEH+RI6T/UoHe/1WpM0nTtmK/tk50ZIvDHyflcLVNCnPvipImT85J27eREDdIConMynjh3dACZFx19Dw4kFVSzYduDlxNto2eDXj6nLUIDsKHyeg3LW7i6Q9JxErD7/rLLU4MC7d8mF8p00JVstv+l8ZirGA1ZSW2E0ba7qIqrc+Vj9hSKI9TZFnWCMT4i4jeEORxoaWWSHW4x008QFHnMAqqsqe0fQjjUSuezCXQNIl6wdgtYRCF+nqIz/HmonakuBnI6TgxKUbLuNRYm5hcGLdaF8Sllo+DskQOHA/Udpfv/e7Bu0vJXNomqqKmQR9ALs9GsKSzIQ97ht7B/fe92rt/oKh5prT7a7Goz0jD9Qrd8AP8AtM+AfMCw5NjRojXKb6veUeNH0mUEh6fLP9aUlkvReSjp/0OvCOr2JXNSDYCF+8pg7EcUnZJ4K9QNj5zEsI/OaBVk1KzWy6smH8hhlCc8R/r7+VkFAGN0/xXzbz/09qmjoB72FM1zAdZmG397sbNz5CO05WEmzSJCS2d8B5UPjKO+KKwD2bfGMM7+QZp37fEtyGr/tdrN3tBzQxfugqOOUmJYMYEFftMRHXTbjZu9Ug9aeS73SPGYZwoBI4aSlEWMLi9lvujw1dVFZGpGDwntyuAYbZJMXNsmD0zJ1Z/KPlIOl4NdPJovTk/6tM/vfuezad4UKLcaqNEAqgrlBzhMYmiZYHXTr8EPzWgIHW4JHCDqdB3Ul
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:39.6040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d48952a-d75a-441f-1dac-08dc58c89b0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Free Tx port timestamping metadata entries in the NAPI poll context and
consume metadata enties in the WQE xmit path. Do not free a Tx port
timestamping metadata entry in the WQE xmit path even in the error path to
avoid a race between two metadata entry producers.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h | 8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c  | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 86f1854698b4..883c044852f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -95,9 +95,15 @@ static inline void mlx5e_ptp_metadata_fifo_push(struct mlx5e_ptp_metadata_fifo *
 }
 
 static inline u8
+mlx5e_ptp_metadata_fifo_peek(struct mlx5e_ptp_metadata_fifo *fifo)
+{
+	return fifo->data[fifo->mask & fifo->cc];
+}
+
+static inline void
 mlx5e_ptp_metadata_fifo_pop(struct mlx5e_ptp_metadata_fifo *fifo)
 {
-	return fifo->data[fifo->mask & fifo->cc++];
+	fifo->cc++;
 }
 
 static inline void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 2fa076b23fbe..e21a3b4128ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -398,6 +398,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
 		u8 metadata_index = be32_to_cpu(eseg->flow_table_metadata);
 
+		mlx5e_ptp_metadata_fifo_pop(&sq->ptpsq->metadata_freelist);
+
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
@@ -496,9 +498,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 err_drop:
 	stats->dropped++;
-	if (unlikely(sq->ptpsq && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
-		mlx5e_ptp_metadata_fifo_push(&sq->ptpsq->metadata_freelist,
-					     be32_to_cpu(eseg->flow_table_metadata));
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
 }
@@ -657,7 +656,7 @@ static void mlx5e_cqe_ts_id_eseg(struct mlx5e_ptpsq *ptpsq, struct sk_buff *skb,
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		eseg->flow_table_metadata =
-			cpu_to_be32(mlx5e_ptp_metadata_fifo_pop(&ptpsq->metadata_freelist));
+			cpu_to_be32(mlx5e_ptp_metadata_fifo_peek(&ptpsq->metadata_freelist));
 }
 
 static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *sq,
-- 
2.44.0


