Return-Path: <netdev+bounces-98638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22DE8D1EDC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18761B22D43
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF8516FF54;
	Tue, 28 May 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jt6Bd2Tu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A311317108E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906609; cv=fail; b=Yv+azC8wgY3lw2hxmwH1t8nBann/wlz9KMH3KAOq9WTu1LkUwm/8dnkGmATR2jAswx1iKrEhDrOnG510nWd22+FlpiGilh3s+MKOvVFZPLDPzfLpIC9h7y5mqMBmUl4AEtwLrKfUK3Bc4zQrhN5j0um5rt694KXCaZXkdPz9JCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906609; c=relaxed/simple;
	bh=6TXPp2pC/p3Gws71EyzNlQ1ZP0+tDcG6nCWJd1obYwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYlMxoTEzp4z94kACB0OBWzrH9fF2vnwRS+H7dKRzu5Q4kFpvqZh1qOKuepjwBf83LPKJrWhBkw+/YNLW4pPD/rG8ddBkykCW7Tq08GgnAAgHpfon9vzk5EV+vX5kFo/Txn1VWK0/W32eh0xmcDsXRlsEHKAec5wIvuRAaJN9Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jt6Bd2Tu; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAmGwrm0fBJjbvXXf/JkeAuhb6YMmki4W3FXr7w9RrqUZiay14cLMoIr28yDxASbpELJv/Nxl+QYGXL8ax2TJNFfLon3rtqYuYKHu18kpVP+6WhOyGjRQjKdsXoSY2rAIAZg6gzGazGzJh52XdF1UL8geHGo3Hicp10Qy35blC0PCju22zEgx61MvVhlhm1eia3TqKtoqzVETDoIOe4G1Lf+96gf+Sy06Otai0hmf6pKF2PY/gWGDNDBrHDEGakb19AJKUIPyxFtTLJ8N/7rCM+I7SK6UpXfckqA9QVAB2h6JAlo5fe/n3oVyLctUmHmTvkroiM5AJHgJntivrH09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1xRDVfHlAbRn4xekCY9sE64xBbAPCvFB6BDqsBOGf4=;
 b=Q3jgd+dN6Yy8qz/CqpUFnLh2k2uG0rm0EYOlriOjtrmgQlO8SJOGk9z6r8rDXFSl+RC/NwgDdukwkGGN62HmXs6WcKC3BpkI/zRHPtbdt7BQXUophw7chUxk7eLFoOYtyIXBojJ2LGnUK5Adn+uaqbzIvIjdYKI6fdxwUqz5+/F0nlF+O6+wJO4OmnPM/KqcyFIm0ssTHCR/jn/NH09sehuWfDLtT45LkJ/ChZbzMEV0vCdvToA0Dq9SXDUm9JxpEcjNJf0kS2oaJehOf/G9EPY6bxF3DYN+jpaI5EBGR6+ESgnQWWb00dXQ7CqBeVYdOTsrKtq1eShB1AcZ90fVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1xRDVfHlAbRn4xekCY9sE64xBbAPCvFB6BDqsBOGf4=;
 b=Jt6Bd2TuXu/mrntx1vI2frSkTt7gMMiE6qMvZUPHGqKW42lztHTKjUNGZ2IvIWS2szxVnUQsR6VUHsaFk1RP4+goBebiP7id7HsVU5/cDxX+mCzSRNEk+aQdt2pONMUyWi6OxH68mgJM5D2CXwnl8U+tz3TY9gmPiu/cf0yKIyRC8/m3dsR9Rq5xCH99dYbJXTWYO5a9FS+L4T5PghdE6KbPM/tKBIntqpBgHQ5x9vb9t2TcJpcNEEzu8NA/gNvxW15L/w6hr2f7UAHcsdP+UA0EqHgSC0bagUVcsWtGrqk2wRweys+qdv1BQgr+A+YYfVRwBLT/+PBnYq3U4IDvXw==
Received: from BN9PR03CA0468.namprd03.prod.outlook.com (2603:10b6:408:139::23)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 14:30:02 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::62) by BN9PR03CA0468.outlook.office365.com
 (2603:10b6:408:139::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 14:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 14:30:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 07:29:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 28 May
 2024 07:29:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 14/15] net/mlx5e: SHAMPO, Re-enable HW-GRO
Date: Tue, 28 May 2024 17:28:06 +0300
Message-ID: <20240528142807.903965-15-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aae86e0-be40-4160-7c17-08dc7f22a85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxVATtkbyyiTAMaPiaxZ5OqmqOe3uu7nXbRsYUzV2Jt9xaQF8t5Mwmz4PoOV?=
 =?us-ascii?Q?KW2nlJT5aT3ZdKTtmYW5GmGTqPa6ZLSLZSdu1vBUb3wxRKJtK8PfYINwSxMl?=
 =?us-ascii?Q?IJmDYyLVb9IWolSrbuIZ5MOPCBpwdyNZN44jHhMU9cHgvI6KoyGN3iWLGf3P?=
 =?us-ascii?Q?Cm7qeNY48GMQ+n2juhRL6EGLuYasQYdSgBDVQtXE+EuzDWGbyBVLidBj2fMG?=
 =?us-ascii?Q?+NcKrO+HpwEnF7hTBkTPG2tDlx593dF0OF/8cJd/CqXNGqBIWCphqcnuv909?=
 =?us-ascii?Q?wcBtLPp+e6+GJaHukqv+hrfV9Dzr5cIW6Pv6yf4aaAIHyk/IQYn6TVAtAhus?=
 =?us-ascii?Q?MA7H7IK+8X8lOB5hTmScGWd7rUrqf1xZnqQf0bx/TORkXmM8cx+u213hpcY4?=
 =?us-ascii?Q?c/y24DW5vguf4yJ3aVnO5JxliCg931x76NqzTQh8/I9ONrDPo6REA5VihG4R?=
 =?us-ascii?Q?bt1QgYyBb/pndmilCM6hm/HbECE0OERmZGP7Ku/fPPO21JvKeSVgV4yIL9dJ?=
 =?us-ascii?Q?XtJC1gxeEXXdTEarTt/G1SQ2O0Xyt8loAbEUyzJxDctPdman5LywY0fNbj7h?=
 =?us-ascii?Q?j4nUvOCaBL+Zuyu5XE30Asq9+CDuWwYdoMxLSq9BBlAMXVOy0iICOhbS7nkh?=
 =?us-ascii?Q?CEw9SR/O8TOYT8ki73264sxkH3qp6v62h4B+ob9K9Nc1IPAcnz9iWA4EwFr8?=
 =?us-ascii?Q?4cAu89wjehkJBOVQs7tkgrhMD9yQUoncVRdcP3DENMNeYXSvjTss4gDuLxqT?=
 =?us-ascii?Q?PtlDT56sZWVpMQ3jtWyIEbhP3n9esSYeLpoHXZ91HuZjvzIYl6yfB/wpmCJK?=
 =?us-ascii?Q?Yp9FoiSBH4JExY+7TJ9V2BHXyTEmYV93UrdtQP8j1tzY8nqktmHW+zodz/Ng?=
 =?us-ascii?Q?WH7l7lIxxOocKqP1q7ZaIUEZXtrLjKhh0BqooJMxh1/zEjKcUALTBDfMyDmx?=
 =?us-ascii?Q?N7QmN3wULOIGsnEgXzshDLNb4dUsdq9gKZyjWlEas+vin4wYNS6EYWpAAjyj?=
 =?us-ascii?Q?GoF2Gp8KJgvcXn+DnBrpBMvQUgupzuXP5R7ox9TzBEz/LIK8n4D3ac5qm/du?=
 =?us-ascii?Q?DGGk29W8N/AHg+kqxhm8SeA4r9MvNWRW6UfwBp/A5cX9LXMQBTOTcQEx91OT?=
 =?us-ascii?Q?1PyHbNw74CDDU1sapK2fSUMt2zlZbOrkXg1NMtD27+04CCCT8+GQbNzO7zNP?=
 =?us-ascii?Q?eVMw2QBCU5P12gIjc32gqtYFybbGQltjBH8PU7Yd53y66badPG5Lcz2jspVe?=
 =?us-ascii?Q?LdUHhYpOFIwF0ImPx67WgTjVcDegLAYnXphBSiYAzqK5jbkM/5uLVEstU0DT?=
 =?us-ascii?Q?ez2TUs931Av/eGD9sTE9+aEYp5Xyk9K2JtQ6qfweU+c96dkRvCwCucdlGa0N?=
 =?us-ascii?Q?qT26vM6Stybqq+Mtx3W480OtmIO9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:30:00.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aae86e0-be40-4160-7c17-08dc7f22a85e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

From: Yoray Zack <yorayz@nvidia.com>

Add back HW-GRO to the reported features.

As the current implementation of HW-GRO uses KSMs with a
specific fixed buffer size (256B) to map its headers buffer,
we reported the feature only if the NIC is supporting KSM and
the minimum value for buffer size is below the requested one.

iperf3 bandwidth comparison:
+---------+--------+--------+-----------+
| streams | SW GRO | HW GRO | Unit      |
|---------+--------+--------+-----------|
| 1       | 36     | 42     | Gbits/sec |
| 4       | 34     | 39     | Gbits/sec |
| 8       | 31     | 35     | Gbits/sec |
+---------+--------+--------+-----------+

A downstream patch will add skb fragment coalescing which will improve
performance considerably.

Benchmark details:
VM based setup
CPU: Intel(R) Xeon(R) Platinum 8380 CPU, 24 cores
NIC: ConnectX-7 100GbE
iperf3 and irq running on same CPU over a single receive queue

Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 26 +++++++++++++++++++
 include/linux/mlx5/mlx5_ifc.h                 | 16 ++++++++----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 913cc0275871..0f3d107961a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -74,6 +74,27 @@
 #include "lib/devcom.h"
 #include "lib/sd.h"
 
+static bool mlx5e_hw_gro_supported(struct mlx5_core_dev *mdev)
+{
+	if (!MLX5_CAP_GEN(mdev, shampo))
+		return false;
+
+	/* Our HW-GRO implementation relies on "KSM Mkey" for
+	 * SHAMPO headers buffer mapping
+	 */
+	if (!MLX5_CAP_GEN(mdev, fixed_buffer_size))
+		return false;
+
+	if (!MLX5_CAP_GEN_2(mdev, min_mkey_log_entity_size_fixed_buffer_valid))
+		return false;
+
+	if (MLX5_CAP_GEN_2(mdev, min_mkey_log_entity_size_fixed_buffer) >
+	    MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE)
+		return false;
+
+	return true;
+}
+
 bool mlx5e_check_fragmented_striding_rq_cap(struct mlx5_core_dev *mdev, u8 page_shift,
 					    enum mlx5e_mpwrq_umr_mode umr_mode)
 {
@@ -5331,6 +5352,11 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 	netdev->hw_features      |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	netdev->hw_features      |= NETIF_F_HW_VLAN_STAG_TX;
 
+	if (mlx5e_hw_gro_supported(mdev) &&
+	    mlx5e_check_fragmented_striding_rq_cap(mdev, PAGE_SHIFT,
+						   MLX5E_MPWRQ_UMR_MODE_ALIGNED))
+		netdev->hw_features    |= NETIF_F_GRO_HW;
+
 	if (mlx5e_tunnel_any_tx_proto_supported(mdev)) {
 		netdev->hw_enc_features |= NETIF_F_HW_CSUM;
 		netdev->hw_enc_features |= NETIF_F_TSO;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f468763478ae..488509f84982 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1526,8 +1526,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         ts_cqe_to_dest_cqn[0x1];
 	u8         reserved_at_b3[0x6];
 	u8         go_back_n[0x1];
-	u8         shampo[0x1];
-	u8         reserved_at_bb[0x5];
+	u8         reserved_at_ba[0x6];
 
 	u8         max_sgl_for_optimized_performance[0x8];
 	u8         log_max_cq_sz[0x8];
@@ -1744,7 +1743,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_280[0x10];
 	u8         max_wqe_sz_sq[0x10];
 
-	u8         reserved_at_2a0[0x10];
+	u8         reserved_at_2a0[0xb];
+	u8         shampo[0x1];
+	u8         reserved_at_2ac[0x4];
 	u8         max_wqe_sz_rq[0x10];
 
 	u8         max_flow_counter_31_16[0x10];
@@ -2017,7 +2018,8 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   reserved_at_250[0x10];
 
 	u8	   reserved_at_260[0x120];
-	u8	   reserved_at_380[0x10];
+	u8	   reserved_at_380[0xb];
+	u8	   min_mkey_log_entity_size_fixed_buffer[0x5];
 	u8	   ec_vf_vport_base[0x10];
 
 	u8	   reserved_at_3a0[0x10];
@@ -2029,7 +2031,11 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 	u8	   pcc_ifa2[0x1];
 	u8	   reserved_at_3f1[0xf];
 
-	u8	   reserved_at_400[0x400];
+	u8	   reserved_at_400[0x1];
+	u8	   min_mkey_log_entity_size_fixed_buffer_valid[0x1];
+	u8	   reserved_at_402[0x1e];
+
+	u8	   reserved_at_420[0x3e0];
 };
 
 enum mlx5_ifc_flow_destination_type {
-- 
2.31.1


