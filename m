Return-Path: <netdev+bounces-152201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21E9F3160
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE9C163A77
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A7A202F64;
	Mon, 16 Dec 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H7+qyC7f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501DF29CA
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355170; cv=fail; b=h0bgppbGkbzx6kVcGY2z+SXCLugK6jblLKeJe3dGmWLvDsRxa1m64A0ZuiFYritg5Mh82PQGevUET9ImC4cjW6J2ziJevgY+A4VPg8G859wumrKISOkPn0TXBw41CVMkiNSH5Wi3DKMXRjJOgCoXbq2z5xLVeUAeU1A8FQya4z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355170; c=relaxed/simple;
	bh=okzWzc+gP2m9RpfnPFqBtAmHTfr6yd02yajB3gcK4Cc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=knrNtrB1dESsDp4jhNIv6pbISA7z8U9BqUIfQXNJ6qUkfjXm3EmLtQ8P0YKoqrwiQ0GUD1qDUfPmZsdDiYuV9R20FFJ1WG5CZxb3l2Zf9Pvu/wIGNcc+PcB54M2nJL09bdOVK4D3qH8kcxMQpjMzJ1BD7dmrMnRpVEZBNWyeYT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H7+qyC7f; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq+tw3FOOWxYfswUpnG0ldUe2xgPSlpSRIFxbRDN5a6MKcbGgDYBv+PzH0xY0i9rYOQwJQoZyAGtrj2K5sZuBgsbhp6RVRyjf7TWf/24/zHiHU+0t6ykIm76Zi9ZCUIhnleYwZC/dAJuxI+1dj1UrOtbGYdAGcuqW9U2+rE9it1qSZ9g99OsqVwg+07CmoehoWkA0sEdnbq0XC5BudkaqWgZs0JP5BmC8L0Jr+7trbNyeoeKvyAF7aynBaeJZGPCFONm90Y+sa+ZE2i+DtrYkxrEGzuQTrs85bMS9Zs1KfUQDfWfalkV3PU53IN+Zvr4dXKvJjkmfmJsK5d4Dd6+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8xxRuRfGuNQy0E9OeWA5olA/Vo50UEDYI6btKCP3i0=;
 b=CKr33IrNUVOVTlGpxHWVrgADpVIPNv1m8MY+iBu3LWXYmatEgCCaaDuCp0cB1dhemkgts1ujSci5nec51KmOr1zCkIQatFeAXk46zLpuLqf6Ny1uV1zstWRiYfTUsp5fkbr2GXTHHZXX4oUMmeHOlNc0SlEZVwsQFU7jo6A+2lFk4WRAdq6m9L1x/bVvN4npt32+jgyFMNYrKSWXfDFJoD5G9bZGZKG1vCScHbpjI5NmkkHm76IQy5W+yV/Erd/40g8INaee+XD+abac2DQQPmxxAJE99Z0RPmJuCRwRSH9ZxfN5MzsaibTaNAvUkilv4XLA+7whbxZwBezv+ufkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8xxRuRfGuNQy0E9OeWA5olA/Vo50UEDYI6btKCP3i0=;
 b=H7+qyC7f+tNsnVId2CzjOi20GWtZtjUbfHu7ChifQJS/TFeTc9YUpBSJtp+yBSFFoaJ8cVqZfTuSsHDmKnBZtekBlWYBZLKVsQN5+6RlogpAxAvnfebtzbHbDfrFQKDdf5YgftsrU4UdB7NwEtSDjJxX3Qq6rgyLVRk4zrrc8CHDdiBVSN4AoX2GlimAFZYaSPYQCkJRgAdl+6IGh8wuswlDPuevnrsGpeD4D2soOrWutT1ChvQk+ZK6aM8v2DaKKBZa5HqogqOtnl4swqmGSgJ6yW2nRvPHMa1RKuSDCBcyOO+hFYa7feSpnjD+SXcUXFvHmSz9WEQIkEXg3AE9Pg==
Received: from MN2PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:23a::32)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 13:19:23 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::af) by MN2PR03CA0027.outlook.office365.com
 (2603:10b6:208:23a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 13:19:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 13:19:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 05:19:10 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 05:19:03 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net-next] mlxsw: Switch to napi_gro_receive()
Date: Mon, 16 Dec 2024 14:18:44 +0100
Message-ID: <21258fe55f608ccf1ee2783a5a4534220af28903.1734354812.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 645bb086-4c3e-4534-82f1-08dd1dd4419e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/BMjdocHGbgu6HrB6Ah+8qVl3Fiw6qRL5TZGn+qvd079VwahCxdY0jzdmNbr?=
 =?us-ascii?Q?PUocJe4rBVPrJoxFUt4ZgAHyPlsAlTDMNp/xOBMu9Dzr8IJS3pOjf5u8wsGn?=
 =?us-ascii?Q?XRrlcHA3+rV9eeTlmvpIL4dnYH4p5Y+NIzkbBOrS7Le3hje+zK4z3n0uXyMw?=
 =?us-ascii?Q?HrOEA0Gz2WQopS9f3DySQHhV6kurmDwndoLNOkak5gygHPrufU24R+v3WwNE?=
 =?us-ascii?Q?o3cU+PlIXiE+XUzWEZyb2MBzqP+neqTNoQuIfuzZIBVc5luFiM4EumK0q2kP?=
 =?us-ascii?Q?3qfYMhimn6oIvT4D31aFDhQZwKlVsLuq/aqJ5VGu1iBEaL9J+Bga8Q8YBNgK?=
 =?us-ascii?Q?kGBOOy/nX06vfvluNutU3XcRkBnSwhJtVHh+1X7YWv1B/5exiF9g2dajU5IM?=
 =?us-ascii?Q?4+yk5Pvq7yjldquMW5UGi7GAj3I9kUmTRIANArhgcd7CYpkvYtOUjWSTiiw2?=
 =?us-ascii?Q?RdJ23mtayKnwtPnsPO2d2Uf82X+ZA1BlLqArqXZoajhLV3xLXM7slu643Lcm?=
 =?us-ascii?Q?c4Qq9qT/oAJjkocxyg2i0Wk+gJKO6ML/kxlnHEPrgJlOyoUJuCnxqStsv8HQ?=
 =?us-ascii?Q?VVBTmClhxMCH92cH6bPB7tXqIrvtDgahwd8kAgsF/Cas8x88/Na80sdBCGMw?=
 =?us-ascii?Q?HoGjP9Uq6+hhP4HvoiWYzErMHsThFuvPMKpaJCYJhcikT9BSljKaSZVrGe9r?=
 =?us-ascii?Q?xxCmXTN/Udc8hsscsPdY53fT3HUeE5xYefN1Xj+yPyUxZzR9u5bFeSiN8r8Z?=
 =?us-ascii?Q?4jQNR4OqyttKi0zRYpHMIxZP2eivRN63emPQmR62ybqzL8Bo5pbNjWlbnU+f?=
 =?us-ascii?Q?UokN6RM0uvNTVDKkZEF3mFl6v6JcwuZDSxAxLKPdie686ciO5RYv8jOV+sfq?=
 =?us-ascii?Q?in3LXcBZjcIjP+jJcp2lH8Gb/ifY1EuKAcaBhSzGWKDKrfM4AD0WVBDcPhdN?=
 =?us-ascii?Q?rd7wyMbA8ZfsrdFFSMS6C0zc2YlwFvQAAsPQ93jxT3WPHuUSgNLBm9FY05ay?=
 =?us-ascii?Q?DOf218TILs4bRW0Gd4BUifTWFZjQ05+pGvwuPKBC1wb4wHxws29Uv/E4d7OX?=
 =?us-ascii?Q?o8bjtelhkDBCBfi5DZT96vkvj7obHCmjviMwlYAjd1mJlZyp62xT1fv+vnG4?=
 =?us-ascii?Q?btS+GOHYAQHVIDtQRAc3PQgeCVIkiTE48BRuNIDPlT+SaXK8RGAeCEP+2qMO?=
 =?us-ascii?Q?utTcXwR49q+A6BhyqYxNUCY55u9ogFRlSmlWdEPOI8NnDaUnRkPzK69luK22?=
 =?us-ascii?Q?rnN6Z7A1286yNIiBVT/BFT/LdKwObQO1KKBixeYpC9dFSf2gptH25D530u1C?=
 =?us-ascii?Q?5Sp/3+KqtBOoK5DopTtyyiEKdvuxLlvIUTmeZXvHWCOBBc2aVtSSPp0fn98m?=
 =?us-ascii?Q?aOIrnCrEpyr01NHK4It9CzHISTWSNZPzAlDQcDoQVujV05ac5z72jBhfiDOH?=
 =?us-ascii?Q?nSM2wwJrABuYU018s1lqJKeiQZ0hD2TPcsTpDtoZAgjAZHLKywI/xGvN2L/F?=
 =?us-ascii?Q?mtaOmXoR7IG2xQI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:19:22.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 645bb086-4c3e-4534-82f1-08dd1dd4419e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

From: Ido Schimmel <idosch@nvidia.com>

Benefit from the recent conversion of the driver to NAPI and enable GRO
support through the use of napi_gro_receive(). Pass the NAPI pointer
from the bus driver (mlxsw_pci) to the switch driver (mlxsw_spectrum)
through the skb control block where various packet metadata is already
encoded.

The main motivation is to improve forwarding performance through the use
of GRO fraglist [1]. In my testing, when the forwarding data path is
simple (routing between two ports) there is not much difference in
forwarding performance between GRO disabled and GRO enabled with
fraglist.

The improvement becomes more noticeable as the data path becomes more
complex since it is traversed less times with GRO enabled. For example,
with 10 ingress and 10 egress flower filters with different priorities
on the two ports between which routing is performed, there is an
improvement of about 140% in forwarded bandwidth.

[1] https://lore.kernel.org/netdev/20200125102645.4782-1-steffen.klassert@secunet.com/

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.h          | 1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c           | 4 +++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c      | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 8150d20cc5dc..59b4d26b4931 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -84,6 +84,7 @@ struct mlxsw_txhdr_info {
 };
 
 struct mlxsw_rx_md_info {
+	struct napi_struct *napi;
 	u32 cookie_index;
 	u32 latency;
 	u32 tx_congestion;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0e4711804198..38e7bd3d365b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -945,6 +945,7 @@ mlxsw_pci_xdp_handle(struct mlxsw_pci *mlxsw_pci, struct mlxsw_pci_queue *q,
 }
 
 static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
+				     struct napi_struct *napi,
 				     struct mlxsw_pci_queue *q,
 				     u16 consumer_counter_limit,
 				     enum mlxsw_pci_cqe_v cqe_v, char *cqe)
@@ -1032,6 +1033,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	}
 
 	mlxsw_pci_skb_cb_ts_set(mlxsw_pci, skb, cqe_v, cqe);
+	mlxsw_skb_cb(skb)->rx_md_info.napi = napi;
 
 	mlxsw_core_skb_receive(mlxsw_pci->core, skb, &rx_info);
 
@@ -1120,7 +1122,7 @@ static int mlxsw_pci_napi_poll_cq_rx(struct napi_struct *napi, int budget)
 			continue;
 		}
 
-		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
+		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, napi, rdq,
 					 wqe_counter, q->u.cq.v, cqe);
 
 		if (++work_done == budget)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 146acb5f0092..78a519149fa4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2412,7 +2412,7 @@ void mlxsw_sp_rx_listener_no_mark_func(struct sk_buff *skb,
 	u64_stats_update_end(&pcpu_stats->syncp);
 
 	skb->protocol = eth_type_trans(skb, skb->dev);
-	netif_receive_skb(skb);
+	napi_gro_receive(mlxsw_skb_cb(skb)->rx_md_info.napi, skb);
 }
 
 static void mlxsw_sp_rx_listener_mark_func(struct sk_buff *skb, u16 local_port,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
index 899c954e0e5f..1f9c1c86839f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_trap.c
@@ -173,7 +173,7 @@ static void mlxsw_sp_rx_no_mark_listener(struct sk_buff *skb, u16 local_port,
 	if (err)
 		return;
 
-	netif_receive_skb(skb);
+	napi_gro_receive(mlxsw_skb_cb(skb)->rx_md_info.napi, skb);
 }
 
 static void mlxsw_sp_rx_mark_listener(struct sk_buff *skb, u16 local_port,
-- 
2.47.0


