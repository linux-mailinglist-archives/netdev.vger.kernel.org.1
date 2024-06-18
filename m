Return-Path: <netdev+bounces-104482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324890CB60
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE584B2A5D5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5920D15AACA;
	Tue, 18 Jun 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MMqDBAKd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28F515278F
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710563; cv=fail; b=m/rCx56tEclZTfxArW4Q/UhRPMSp1uOAtsly2aL+mZsJi07TUB6NV3yWLl1temMz0c9105UsRNUg+5XaIeWfejdWsLydDD3VrNMqXAHHNPho9J/cH4tubix9QuIKb9bqwIxEWloVp0OFhDngU6rETOO3OVpDIa4snMylVJxbSVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710563; c=relaxed/simple;
	bh=k5xKpp1wxxcu9GsmNJ/L2DS7tk/1e7wbYeA1ncaJdgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8s1i6lRpD3FN8p4Qx6CSMEh7uT1MSNArTuTS811Gu1E02yJHd6K7r+5imP9rvXrD0ofrUp5P9M8FfBKRDXkrs1R7yn0Wl8JfM03Zhpds2miDrJned72WTCerI67YAs813JwTD4kPDheoFlIk+ake9CPz9vzSeo0HMmumWq/h4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MMqDBAKd; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agUXV8toEnTge7tIaAWtwYIkCFixmOV0QEDTiyWO7O5WpDxuPuL20dQdK1zBLZE4R6SpDH+z6Ypk+JKZQKKs1F6xenhwDR7NHZ4GBFmwEdecxJWFy895zDrgwdUxfBOQM53UgpQsJwaOOrsOze/uqHLBs0pxF3UqdUA8Afc6+yLpg1JEDGtPKqlK+JV4IHdTzT/nKDHobrRERURD9RYm8it9TjZwMMDzrPT2jNrIsk+ugixp+JtuILGQd4KkPNDfYtGt8iGEjgpCx1zJWPWt4EHT8cdU4wmgYziR+T3bWVmqUcxR457pxeQnYZy+rf8xNTzPswR6uLU7dSNA54jlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4uAugEK45IWKG8lgI3R7pThFsIoScN5nuckFLI0fQ0=;
 b=XGORlQ7QbCOUyYdX0S/NuUxyJasdpFAtCdrS3ZYXwkv6TZhkFgrK3Sc2ne3lcXlddSzpqNWFLx0pYG0UgTMbVTwhXLryt/3MdIRwgzSGYlQBtdVc/ncMOYslceXdl3EybPvtHR94J4LJImXhcT6v+yAD3ltcbXw2aZXI84+JONwLWm0PJ+OSx/yXAV4j5XHNbTZv+GsxYoj5bvccSuvgyb6yyAuVT/JkNNHU4Ui/XwT1uukIpdyIWjTgUAGcwQZMSH2pX3jxa1tv01hSM4MihwB6MaAYf1/k9Dp8fishb33urq0yRsAilklLRX/UmUzWJO07iQ8eYF0G6hEBPG97HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4uAugEK45IWKG8lgI3R7pThFsIoScN5nuckFLI0fQ0=;
 b=MMqDBAKdMCAjC3cGeYE0M9QrybilMkCsKqOTp+x1183RSv9dv3rEcLyiaVCWI4MODWY5ODXfh1mDJJ4ditGvOfLOsVb1rx7Wr5miqWdTeikoXCg/SCU23Mn/iiR8NmLiLYJ37D3SbhVpzwGBBnHJqBTpEkIuBATpvsD4uVMemUZfQFwjtmt9zDwB39tnFyf0LSsyl1I95GznzsyAgVWYtC5K4ywu+n4qDcdVO6soPuhI4IElvKngErynFFSjpi1G4k5Rst3LxCojVuotrKW63ChP8dZsHL1MkbJGERg8EYtKFsblcJetaAuzOerxhalLKYf/A3xczp691eJwuvAsfQ==
Received: from CH2PR20CA0011.namprd20.prod.outlook.com (2603:10b6:610:58::21)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:35:57 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::58) by CH2PR20CA0011.outlook.office365.com
 (2603:10b6:610:58::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:41 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:36 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/7] mlxsw: pci: Do not store SKB for RDQ elements
Date: Tue, 18 Jun 2024 13:34:45 +0200
Message-ID: <23a531008936dc9a1a298643fb1e4f9a7b8e6eb3.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
References: <cover.1718709196.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2a559a-c721-41cf-13a7-08dc8f8ad201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FG+M5Oh6pTjz9qrted1zCbBsaZejXdr22zHs0VajA98RLXHchobzcSQSq43B?=
 =?us-ascii?Q?sTqdBbC8o0BMzeK0OVfIEB57Nf7gipCAptE4GCslg8UqRjjxEXzzAoWp447Y?=
 =?us-ascii?Q?Csrg8AuLr3wBpXz1zzU8D48pSCk8/c8NvGOvQjrU6tYyFgV8XDrExf8pDUcL?=
 =?us-ascii?Q?G+6FkIfP6BLicyWI2ai9PW+jPG7DLIaTM4WOJOV4aPM7OBS4UB8edco3+uww?=
 =?us-ascii?Q?EZPcxWDgpSjMo0xUNyTRsezBx+mU9NdS2bFMFn4vzOyWxymkDxorw4II9qk+?=
 =?us-ascii?Q?3qczEsF61pKqSzaLCW6KitR4w7qjHH5YYNXKUYZIcvD8g6DCM6DYSvy+MLzT?=
 =?us-ascii?Q?s1DE8uacbxksg8fvWPzR2wZJA4gxsWm6h7ktBegiI/Mi87XlBWHMS3l78DrM?=
 =?us-ascii?Q?s7soPfrkFlOiC22X7Zx1hQZKJXc4WI6+tQfOdTVO3lm7xj273/eBGVPA6gGl?=
 =?us-ascii?Q?f4VmLZtuuENruXkw3DeFkGktNivKWoptj7+jVStYLqeWGLZGcI0oXZLX4Hea?=
 =?us-ascii?Q?nBx9vhTndeHplPX/4X4N4oaSDhucofqCNP172smopYqqb+pOOPeZP+TC0tz7?=
 =?us-ascii?Q?KxcXXCpRVfB2Hf2FgDef5BR6qcnjsxHl5uEUgeuBJhYsG2TSVU29AsB9nNAZ?=
 =?us-ascii?Q?Z2VYPtg1qy8FRrOyLrdCXH2yZGNVCtnlTrd3trS3LbhJ4a0UG6tZvW3J0HWU?=
 =?us-ascii?Q?qD9iQWHvidLZz9ly9G2g8CxOih8PGpjry43X5NcrungeCWRdV0kfQoUtyD07?=
 =?us-ascii?Q?LJXfwfav3AmKo8QZPkz0h6TqdLn46g87b/YV9g5H1uymK0/ZofkM1EEOG3uF?=
 =?us-ascii?Q?mQsEOAJjWhAvdMpLT4zUFrLCFsvUgaMcKuLZVHA7XtR7PtPRSZXTdDmc4rBk?=
 =?us-ascii?Q?f2dJeFZvlchSTYFwUYegux4lpnjKeMhOt1zS4z3y0rSEeZbGX6WDk0akNL00?=
 =?us-ascii?Q?YZThlZzQ5WYvW8UQZ9bQ3UXYS2jdZJAoIwryf7jGVHu+FGWVVstFx8lgtRw/?=
 =?us-ascii?Q?tZyxcpAXUUhFUHx66+GIGLmnxGKwB3pwiFLu0Lvt9tlJihRc2a0fR31+bPgy?=
 =?us-ascii?Q?1hlBHrtcIXSjpkQ/6vXWqvZfrkKCLOu8Oxg+2kSE2r1QL9Knu9HAqXAEmY0V?=
 =?us-ascii?Q?On73MPRwuJQfeTcq/I8mmrSs8ciy7O2G7G9xTIy4oSGsSkdYlqD8814GSjod?=
 =?us-ascii?Q?GfNbCeWpqEyPFdioHsFnI3PNnAYO7HarpzRan5Ie7X0y2cxLYc0I7IY/r+7s?=
 =?us-ascii?Q?gtW9tm60SN+6bHGi2k+Dh4kkV8mKFNW8RQEuo70KsRsqkjtahqwj3ef3DDD0?=
 =?us-ascii?Q?zmj1Sl9utRbER9y8Of9E1yMlv1JmrJcszQ8e68yE0QvTWxQD1qiQ24U/0zc9?=
 =?us-ascii?Q?0al+pbss9xCQPT2g0JnT1R38WDSVdJWKDi5EDgmkmbD4MqRsdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:56.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2a559a-c721-41cf-13a7-08dc8f8ad201
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411

From: Amit Cohen <amcohen@nvidia.com>

The previous patch used page pool to allocate buffers for RDQ. With this
change, 'elem_info->u.rdq.skb' is not used anymore, as we do not allocate
SKB before getting the packet, we hold page pointer and build the SKB
around it once packet is received.

Remove the union and store SKB pointer for SDQ only.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c380b355b249..498b0867f9aa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -64,14 +64,9 @@ struct mlxsw_pci_mem_item {
 struct mlxsw_pci_queue_elem_info {
 	struct page *page;
 	char *elem; /* pointer to actual dma mapped element mem chunk */
-	union {
-		struct {
-			struct sk_buff *skb;
-		} sdq;
-		struct {
-			struct sk_buff *skb;
-		} rdq;
-	} u;
+	struct {
+		struct sk_buff *skb;
+	} sdq;
 };
 
 struct mlxsw_pci_queue {
@@ -557,8 +552,8 @@ static void mlxsw_pci_cqe_sdq_handle(struct mlxsw_pci *mlxsw_pci,
 
 	spin_lock(&q->lock);
 	elem_info = mlxsw_pci_queue_elem_info_consumer_get(q);
-	tx_info = mlxsw_skb_cb(elem_info->u.sdq.skb)->tx_info;
-	skb = elem_info->u.sdq.skb;
+	tx_info = mlxsw_skb_cb(elem_info->sdq.skb)->tx_info;
+	skb = elem_info->sdq.skb;
 	wqe = elem_info->elem;
 	for (i = 0; i < MLXSW_PCI_WQE_SG_ENTRIES; i++)
 		mlxsw_pci_wqe_frag_unmap(mlxsw_pci, wqe, i, DMA_TO_DEVICE);
@@ -573,7 +568,7 @@ static void mlxsw_pci_cqe_sdq_handle(struct mlxsw_pci *mlxsw_pci,
 
 	if (skb)
 		dev_kfree_skb_any(skb);
-	elem_info->u.sdq.skb = NULL;
+	elem_info->sdq.skb = NULL;
 
 	if (q->consumer_counter++ != consumer_counter_limit)
 		dev_dbg_ratelimited(&pdev->dev, "Consumer counter does not match limit in SDQ\n");
@@ -2019,7 +2014,7 @@ static int mlxsw_pci_skb_transmit(void *bus_priv, struct sk_buff *skb,
 		goto unlock;
 	}
 	mlxsw_skb_cb(skb)->tx_info = *tx_info;
-	elem_info->u.sdq.skb = skb;
+	elem_info->sdq.skb = skb;
 
 	wqe = elem_info->elem;
 	mlxsw_pci_wqe_c_set(wqe, 1); /* always report completion */
-- 
2.45.0


