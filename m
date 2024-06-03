Return-Path: <netdev+bounces-100367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6BD8DAF69
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A014CB25D6C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836413BC0D;
	Mon,  3 Jun 2024 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oklTa8Mm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E713B59C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449854; cv=fail; b=ZzW+a4sLG7WrsfbfwKNsC5X2InUcVWvz6wuDwnf1ESGnvp3UMcuThdPzf7p5ow5JGH48/L8qWSKH9mf6C04pD8Q678hC4GtPyKvp+6AFT+4kWOmHC2/6voFp4bL+OTqBbGCkpTLcfCfBIgxeox0h3QHyZu0R6glJOMv17o1akfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449854; c=relaxed/simple;
	bh=HIF1jQaku1rSw5o94bi2CSu+pNrSWlgzXJpJIyXYdt0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Izr2QGLpU0Xi3FLC27OxX/TrrgTWEqd8sKfaK/t7xg9GQSx/xSgex9tJZleBgbtdJrqIdN6BmhzwK5HFzo27ACPDR/iBYB61WkpHk2KqBM7w/rM4aONZ+nqRYSMdsTcy1ivVbwStrUMTwfh/JHBJ32NyI6VcozUa2HNjMVntdOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oklTa8Mm; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gD75dMVOnLCUZ0s623F1BJhv76au5GGgZ3lKhdUEBOARlvUBMQNhtqA+msR6ZJd/v4H/FgDjANSkfXgpfiqSudo2fYsauCdBaKTlJ/WUYGTJoa9qxWKrZ8RYzKfICjA8JOigS/rjCSWVzEHRWN6siVaZQ9ifzWB3Aowg/OICPl5mp3ayK6BI73mJ2I2COqME4iboCGD6cLRbmZNR34lx3TYsx+TGjRdzKv5FDuvcrYWzsgnUjh1F8NUOuxDP6dOrjr3kmTPgdYbEvI90KaO9hLJOglAslGI732Bnic5GrFvIofAasv2VSV2GWTzpD5cqvVOSS9z/SxTZuy4mzYvNlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PVbQkDPH/nrgpHNbnZ5WBZyAozbKOhlMWKkcfqcpUc=;
 b=DX9yZiaGGyqnGCykjacbWeq41XHOXJeSPyTSopgFNlBanueFP2zvIh6LnQu4c5u+RkUfeWvHvq6gnMc3PwXyQ/Rjkxq1VXzLOQo+B6NSikjA7eb2OeAWo3FLKJ2/X8SZEI7xkYr4swyQNospH15oIUJIhDWc6/Etz6KZ4xq9JLQakfbhn43AKvo2pJLk69WtU6SpuQDSbuB4YNpc7VtFbO7+9oDBN8TKEFearbQjQ8gzWOerzpQDV8GwtlgAX4/8S9/EIO5osKEo5ba/+lGpM/EzEmkYxo6ke1HZkuxSLv/wu+9u6tExl+2QsNsdRfm83XK698WGSkNPDHpCZE3mgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PVbQkDPH/nrgpHNbnZ5WBZyAozbKOhlMWKkcfqcpUc=;
 b=oklTa8MmKcRu+RQNF9M+pN7tVMwxZh7qlEvGEIYqRv8M5vmnQKt3BkLB4GYoqFQyM1yiFZfYmcWmCSZuWnEwbxJ4ER6+tvEeQddT21j1TwnJtxWi0YbQ/PZHEqTmxrjTTM/q3Gr4071Gdjy5AJ/DN37f13m/q5wDKj/hJtCULK3nfT7QKOMb97mK//2aXxvcvIEkmLEqz77ATmv5neUP9N8y1E+sB3uzvDRZzqY65bEPsM5iGC7hFlThepQAdA0VD2jYnvUX0w1EGAGgPfKNVSvwQDTFvF/YvXz95fOjiRS9sqdiYFnh1MHlC+8XG6RLxU4dnAjhOcjlmD46poGO/Q==
Received: from PH8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:510:2cf::11)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 21:24:09 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::4d) by PH8PR07CA0031.outlook.office365.com
 (2603:10b6:510:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:24:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:23:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:23:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:23:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 14/14] net/mlx5e: SHAMPO, Coalesce skb fragments to page size
Date: Tue, 4 Jun 2024 00:22:19 +0300
Message-ID: <20240603212219.1037656-15-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0c020d-cb83-4972-0db5-08dc841381ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400017|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T24Imu9cNnnsphfyoCeDRQifqoRSj7cft0/zn4pcvTaEVXxKkCjsux6VqMSP?=
 =?us-ascii?Q?WW3nM/rmnPL+LHiC8INjkk6zeIWhTAx6pTBU38V3QCWVRAsFQSl+pC9yQs7G?=
 =?us-ascii?Q?JaFbcvExCUqPScC9+Hw+x2z3sCItLxN5DwbLObefnaPjTGDrmeAuL5fAx8ii?=
 =?us-ascii?Q?Rdx+0bpmReDQLrbAzxYHIxuwWpP9Xytwk8ghmxllhb9IRPwHIDa5wgpA10Lk?=
 =?us-ascii?Q?23kKOctRFh2eGZGmN851wn2mb1NSKwuK3lp1fIkyBFVh2Z7ORn38+y/4B6Gt?=
 =?us-ascii?Q?5Xd676Mf+Zkk73XkOJLA1HGFKunPazQmlYXxINtkwuCDJHRNSXJjvZeDFEPA?=
 =?us-ascii?Q?CApVityQYrj57TOM48tkJ1IU7/rHDXAyF2m1SbKica9BIUYDVy434QGs+yV/?=
 =?us-ascii?Q?MHUS5SzwAOaUwk90HXzABwrl5rAF0dtPBy5jAcMdNurxq6Lqyq9c7FK9ITV6?=
 =?us-ascii?Q?2oSC6X/i2rpkvpkULRCU3AKR19YWIvxox9TU/j1dAMq/+u550dQkBP04He4q?=
 =?us-ascii?Q?vyBocbmIT+DDmqD11pzo/apktlIr5gr3wGH/rF+YPXXaL/ANNp9yaNZBWuhV?=
 =?us-ascii?Q?1CIDWSS5E+O4E7leZ+/NIEF8Oi9yqQRPNZWGsn06iMqliX0TZgyTtVo6awyR?=
 =?us-ascii?Q?fu2sUxNlVxqpuymgt3DubJ20mCrkpyFSwKZOGej8xHTJfwR/9L5pJox93OW2?=
 =?us-ascii?Q?60libzfu8DhLfy3mUWYf1XlS+pMfY9AnyTfJV/5NokFs5Fv5+XrhQmyOnx80?=
 =?us-ascii?Q?2YKJitP/3Kcn86fn42VW8VljvhQJHIng5C40GN4GJQ21s7f9Q4jUf/MG2iBH?=
 =?us-ascii?Q?tZtwT0DFjua0lXVSYbwcJs8AQPo+QgJam7gFBTQQcuu+B6+IxZG03aQfKfcW?=
 =?us-ascii?Q?6lkYTGKjRU5uZuZstOB9fagMR0tkmeOT7IEWqoe9DcOi9uJcl3vNdAg0ySg/?=
 =?us-ascii?Q?+InJSQ9pplz99d9quMyhSvhQfisyTJ2XTuLDJBDpizd0MU7Nz6GVD5FzpKk2?=
 =?us-ascii?Q?GaFXhOPrK4AdRmHCrtYkF6oB+d4bfBEVszECORIwEeYnRuQGcfXCbgeew/ed?=
 =?us-ascii?Q?choGKq7CT1s+AFXmccmKIuGSJ5tsMq48L1VdqNTxz89Pxfk9s3DH6813OShn?=
 =?us-ascii?Q?rX3ny8S+dcW93meB2xD94CMXcBHCVbfEhrLMwD3tQCr38fIutHpcsr7hDc2F?=
 =?us-ascii?Q?ZKj2pR/R1GlLXSxizS2cNagUs0gf5TS6iv7YbCuv5TmRNNwxwSoRlT0ea47v?=
 =?us-ascii?Q?KvkiD9+C7TIx5YUe+zRAcSyiDfOngUSA1xOGTFUNtuWs13VgtsfytdDNkMrI?=
 =?us-ascii?Q?f13TjZAsk4cDgM9jlCvhmg62ZoADwp7AF7WU2M5QPidEOWZhzd5bl5nioim/?=
 =?us-ascii?Q?d0pAze18jxXg+wFgdr9/v9+ac27l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:24:09.3233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0c020d-cb83-4972-0db5-08dc841381ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

From: Dragos Tatulea <dtatulea@nvidia.com>

When doing hardware GRO (SHAMPO), the driver puts each data payload of a
packet from the wire into one skb fragment. TCP Zero-Copy expects page
sized skb fragments to be able to do it's page-flipping magic. With the
current way of arranging fragments by the driver, only specific MTUs
(page sized multiple + header size) will yield such page sized fragments
in a high percentage.

This change improves payload arrangement in the skb for hardware GRO by
coalescing payloads into a single skb fragment when possible.

To demonstrate the fix, running tcp_mmap with a MTU of 1500 yields:
- Before:  0 % bytes mmap'ed
- After : 81 % bytes mmap'ed

More importantly, coalescing considerably improves the HW GRO performance.
Here are the results for a iperf3 bandwidth benchmark:
+---------+--------+--------+------------------------+-----------+
| streams | SW GRO | HW GRO | HW GRO with coalescing | Unit      |
|---------+--------+--------+------------------------+-----------|
| 1       | 36     | 42     | 57                     | Gbits/sec |
| 4       | 34     | 39     | 50                     | Gbits/sec |
| 8       | 31     | 35     | 43                     | Gbits/sec |
+---------+--------+--------+------------------------+-----------+

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f1fbf60d0356..43f018567faf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -523,15 +523,23 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 
 static inline void
 mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
-		   struct page *page, u32 frag_offset, u32 len,
+		   struct mlx5e_frag_page *frag_page,
+		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(page);
+	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	u8 next_frag = skb_shinfo(skb)->nr_frags;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
-	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-			page, frag_offset, len, truesize);
+
+	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
+	} else {
+		frag_page->frags++;
+		skb_add_rx_frag(skb, next_frag, frag_page->page,
+				frag_offset, len, truesize);
+	}
 }
 
 static inline void
@@ -1956,8 +1964,7 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, struct mlx5e_rq *rq,
 		u32 pg_consumed_bytes = min_t(u32, PAGE_SIZE - data_offset, data_bcnt);
 		unsigned int truesize = pg_consumed_bytes;
 
-		frag_page->frags++;
-		mlx5e_add_skb_frag(rq, skb, frag_page->page, data_offset,
+		mlx5e_add_skb_frag(rq, skb, frag_page, data_offset,
 				   pg_consumed_bytes, truesize);
 
 		data_bcnt -= pg_consumed_bytes;
-- 
2.44.0


