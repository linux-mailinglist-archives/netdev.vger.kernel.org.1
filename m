Return-Path: <netdev+bounces-104483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC690CA7F
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB9A1F23CEF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59C715AAD5;
	Tue, 18 Jun 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLpOsoe0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE915AD96
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710565; cv=fail; b=nGECEDj0w0xYWs71P5HFWgiELzxrNel8XOKElMFwyuBvIJHt2ya77zrDI7Fh5xl29jJklO7jIxyMPVZMRFVNaoQPucCWvTqkIvz3VblYSAYYlh1Yhe0m7rZ7IBAW7jjp8ZaoAi/dDmN+RDqOoq+i/CbDfCH+sdBil2/bEAcZFWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710565; c=relaxed/simple;
	bh=SkT9zpBQu98YuyPtE5Fwc374+EQ31wv7cfGboInogOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngEWrlBPvR554Czw4gLOSqHzJXobISP+tHtDY+SMk4/T8+7cU2a9Z6GfNTRTChN8Iu931teH/xxdaaOoasgQA4YLE6GEae5zrwj9TzjpH9Gj2yDPxYkO99Ov07cCXfdSXM7sp0+uyS/JjRAqNBYJCM5Z0Ga1I8wefvASSX4Agm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLpOsoe0; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCnUzhjnJwFgcE8nzz6IG2FYwGqDAL54gAqwTwy+khgYhCLj6FIa0+SK4I+6e0BaBNYQ6uF76BDFpG6rGn1roQ+tghMdu2rIZLpsu2EuE7YMb3hUj9fjD7ef7XZUSw1Vz1pYcPII5Xl9LQWNSOl8K+EHmeGw9NrZ3AFybLSUJXXKyyKhQR3AXOBXPJeoju29qg8c/yIZzfC3Tw2tcCNUJ+QTjrx4IxaTM1HclHIpwFbehP7y5LcNqaQ5u32dz24vWvSCXFrEsTugIDS4t5Z+cSM6ykWtg42KcEw8u4rG/qCzjZnb5osANkdR1Hvp9u2w8ZLaRYrLb7bs0ZlcS3sktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QyCjv7iYXsAmdDnQHcRqIMeLXl8GlMmenDbIiLqAYA=;
 b=n3ZYHZnN5NNu4mAKG0SzUlhi+WbKmOIwAjHdVg43TIc4FC6RZiHaWLCDUDL1uYQNllAPvhtlCgHEp7dGy4ztaZBTTfi2hm514g/uOqKYWOwZGNMbeuDDr0I7f2hqhXnNhoFiAPQVsCSc0anhUU7c/KIq60Zh0HRr7JFIj1VBB24tU4PnTgt65fD5LCjFOdQYpI8J5uejiHiJpw9DL60d60YMi1ykzjMRfuscLrLEtTbB26E6lsfNdigY8diEXjh7MIIk3qPbAd2hbUN04R5aAMlvh7Yk7j4GnMI0kUVoUWcKJtFS0jNG4VpO5CEjuXqwdxA9eVrkRFe3eKOKjPMBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QyCjv7iYXsAmdDnQHcRqIMeLXl8GlMmenDbIiLqAYA=;
 b=hLpOsoe0wwKPI/7f7PGKnU/FbVw6aN9ZJ46cURUII8TomZG75pdA6Q/gw0h8IPxGVx7JkPN9hz197YxwNCnNXAAgc7nW5BlkDp7bMbcNghzhljOxZV2T2dAJIqtero5T5QA/JtvSLdakb436Y5pDJGvoM0bDAs4EbyO24oejwSZRWe237F6Fbv3Knzo9sjYBv2CkCeH2FVqhyTUADEhSbuwxJCn6zZOnxhrSQcbAzWWe72AIw5q8nEv/eA8oU49jEVwrGesO5saaNEsRIwZ5Xr6rPKYcE69HkGCnqw0Y1Kgm9hH5z8qWNAj/E2fibcXIHkLan6VOdBSc3wFH5HBDpw==
Received: from BN8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:408:c0::31)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 11:36:01 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::ad) by BN8PR15CA0018.outlook.office365.com
 (2603:10b6:408:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 11:36:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:36:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:47 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:41 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 7/7] mlxsw: pci: Use napi_consume_skb() to free SKB as part of Tx completion
Date: Tue, 18 Jun 2024 13:34:46 +0200
Message-ID: <a9f9f3dc884c0d1be4bd4c9d72030c88c7ac004f.1718709196.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 80485b49-5549-4f53-ae2c-08dc8f8ad43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|376011|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?27AdbKv7U0oaQgQS+AUliqZC8vGzHGfE5Slqt5VnFDMnDsdZw6Tpr9fbrHkf?=
 =?us-ascii?Q?V4icBGsimhBZb2J4ZUkB9g5zbGoymHBczqYqWiiv08S6kUg5w+wmy3tk6vB6?=
 =?us-ascii?Q?4JAEpdAwMgYmEoc/hz3FGrzgEzkNLGMSvYkoC4KKHvigD9/jRzSPTypOglae?=
 =?us-ascii?Q?LlmUrz9+A2SWvb37RCskdglTB/sgMxGwSj8/8XVcIkUO/bAVqkFAJX4a67SN?=
 =?us-ascii?Q?S+O8FHYNRe6MEE+qNjItQz9WD6Ynwzqin/AXwcTBfo8JPNIj1QPole42tUqm?=
 =?us-ascii?Q?oE/b642XhPKTMEmHdhjFwd6uzAPir/mNE4ESroGDrt1x2J+PNoyKyNiZQTo/?=
 =?us-ascii?Q?xmflo+YQzhONKcsZamvbtkyLS5MXAiQ0q0IxV+75Juwqea1xOS+UsK9nNpt4?=
 =?us-ascii?Q?vfswpcV0l/IHZMAO9EoP4aqxzC1fS1HWG9UB/bHsSYI4tFzsUot3bJ5tSZC8?=
 =?us-ascii?Q?vHrUeLuzTWUz3bK8l5BCoaabuUSWM29EBsx4yKfdanySsaJpsIgIM0Id0Tlu?=
 =?us-ascii?Q?IxKHnr+PUnfozDRXI9jy3TT6CY2M/Lyk3JqKfu9+L51v4bPsGzT9HaAoiRbD?=
 =?us-ascii?Q?VEH6DQUMvX/R3nbI5hPBkscItj1vZ+fn+IZx6CZp+HL5i2+4xn4IoD+XZceA?=
 =?us-ascii?Q?nYjRLQanRQXjtoOWpfuOBYR6OTIrEnt9OY1R9subxfh+98az/m/6Oksq7qgG?=
 =?us-ascii?Q?mTgf1/cd4NwYvtHi0Z/k/GbmeN4nLIxSBIY+RnBIRaUKutcrtPJyeA7qbEAg?=
 =?us-ascii?Q?Ef4+IrpI0hGbN/Nd939pRzWi3nKbriIPeiZfqTJoNTh6yPNh2VdKIRBjG4BS?=
 =?us-ascii?Q?FcDeXHGyQ0RVH3YIek2aj6r2GNNDhNguZR4NLhMytO84Uo9R2PgXyhvFQlwm?=
 =?us-ascii?Q?tcGdJdovo139X3NY+ZKbHKWqYk2sGE6VbieqFVeBL3+FJBx/U172r6T3LKcT?=
 =?us-ascii?Q?eq4YmmpHxwhOCcHpvKRAAKDSUjG5boinZ8FY0uLnSiR1rHfBRO685m3jHnsc?=
 =?us-ascii?Q?/F196BgmHtTPSLzsfJjo4DAuYjaX8cOgUoBChriqJkbJdno3KbFNDRqKXYBe?=
 =?us-ascii?Q?P3EtEIGzNIePfFGugLu0AhO8BaDN21kM+i4CE7wuW8Kkxjb3sRrwY6Uky/xO?=
 =?us-ascii?Q?fvhvLF+PWtTdAqAMtfn31N8c60Y6AIB46oNIXc0LYcR9p8ByyyWvix5w3KBO?=
 =?us-ascii?Q?4sB32mnwcbOxDEA3bOMj8FjvIuq3OMeR2/3C0bAmcCVcKdAE9KqFOL9V10XX?=
 =?us-ascii?Q?dMIGSr5T9wl79HVkWaIz6pd4ycn9iLOINFTWJkolYfcRFt0/Vfr7964J18LW?=
 =?us-ascii?Q?tNEwtoInb8MLA9MQIg/k36EX+lFgK+CnRfG5YVkIEUvY0ovMCNzxnA4qCgvo?=
 =?us-ascii?Q?BNmplc6jAnMmoyzyP1A8O5rdpk8x58+SFXE4Q3VZ4n+Jk45cNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(376011)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:36:00.6832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80485b49-5549-4f53-ae2c-08dc8f8ad43b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

From: Amit Cohen <amcohen@nvidia.com>

Currently, as part of Tx completion, the driver calls dev_kfree_skb_any()
to free the SKB. For this flow, the correct function is napi_consume_skb().
This function and dev_consume_skb_any() were added to be used for consumed
SKBs, which were not dropped, so the skb:kfree_skb tracepoint is not
triggered, and we can get better diagnostics about dropped packets.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 498b0867f9aa..2fe29dba8751 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -541,7 +541,7 @@ static void mlxsw_pci_cqe_sdq_handle(struct mlxsw_pci *mlxsw_pci,
 				     struct mlxsw_pci_queue *q,
 				     u16 consumer_counter_limit,
 				     enum mlxsw_pci_cqe_v cqe_v,
-				     char *cqe)
+				     char *cqe, int budget)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	struct mlxsw_pci_queue_elem_info *elem_info;
@@ -567,7 +567,7 @@ static void mlxsw_pci_cqe_sdq_handle(struct mlxsw_pci *mlxsw_pci,
 	}
 
 	if (skb)
-		dev_kfree_skb_any(skb);
+		napi_consume_skb(skb, budget);
 	elem_info->sdq.skb = NULL;
 
 	if (q->consumer_counter++ != consumer_counter_limit)
@@ -819,7 +819,7 @@ static int mlxsw_pci_napi_poll_cq_tx(struct napi_struct *napi, int budget)
 		mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 
 		mlxsw_pci_cqe_sdq_handle(mlxsw_pci, sdq,
-					 wqe_counter, q->u.cq.v, ncqe);
+					 wqe_counter, q->u.cq.v, ncqe, budget);
 
 		work_done++;
 	}
-- 
2.45.0


