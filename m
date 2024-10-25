Return-Path: <netdev+bounces-139134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 084C39B05C6
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F51C22CCC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651971FB8B8;
	Fri, 25 Oct 2024 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MqFMmsOU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE95206506
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866439; cv=fail; b=YQlts1t9khg0JowheX/MlGW5C1GjrkIpISUjsqHUqui1GzpzdTABSQWn78I8m1Tjs74E2YTqaMvaix+ZTXaK94VcDPuvS1vKe+pINB47T2KYJUmQJixS37XlPI8t75gt46k0xs6TyCpaCR1uDxnF7wKqJsfawXqSw8odMvWJM7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866439; c=relaxed/simple;
	bh=c5cPqQNeHDniNtlfYOPGjPsuYBs3ohu7ix1Sqkbwgfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSyv2/FW8tUypS7TuRomnxYCglEhYAuywS1pExZT+ACIutu4ASVGm8OK5KNY1+bSHtR/4c0AIswgEmpflkMn7SLzEJHrcM8rT5dgZKSSmhtXHypSJdZgChx1oCCQmJQBoUHudE6ayu65dcTNF8peDwBITlOjLVcxR43Q9rd+8ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MqFMmsOU; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOP8CymdHKYheINeEu275bSFZCL3BHXMpidXEnAU4Tq5Iz5UaDQKklS8REgEhhvM3IcR+2djRFgYpZnpK7gallnqh3Hh51qAV6q/CTwFGFJD8CoaqR11uerdSUNSWKdXg1yucqKcuVhphkCafDBL0dbOPsH5kfHDcpPTpJJw4S5970iLWrfhxkGHx5Uwk+qfunYO+h3lovdElDVnfCsPqgoVsfv62tzoz923QReA23lS/jI8WbEqpRHvrEJ/C2MXg0laReIFqXMgYHA50fta/usBT9ypZIAvPvzYur+SjWKV9/m2lwHeBbSjibKA1raCVMvi79FVchqZAf85aT1u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZybqdDZZdrEvWUZrU0gVe+HH7cHXdwRNNzJsjjlm7c=;
 b=XBBSAyp6W1Q4aJr6NWOZXdrS1Aw8IV0Pr5FQkF902hcB0B/2s0rBJ5W9ZI1PAWuLgJkLud8Rq4q8hilzYYxOSq/897VRNLrPeRXCPjtKFbUBMd73i23sinXWk7v0UPL7rGYzk1762J2wANHb+XS50UV4UTt3g2lSqrLrvVeHlSKmIS76Hdyt6aiRzCb3i/Hw1pvLwOj9KE7ntUnj4QB5ROyDSnAK9qkAWjNMd+HHYYF+cg7DD9kxOx1/LoHq9PUyDw/TSl3k6dB2D19QLf/0mnics20oIX7RIzKYzrq83MB5bqd6qVt+qowQ4ssAH5fbZpAwmlxfr5D7h9q7iMmdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZybqdDZZdrEvWUZrU0gVe+HH7cHXdwRNNzJsjjlm7c=;
 b=MqFMmsOUhR2SwBfNYKgeJB1FZwd4MYqCjtsgEq0ldcUyqARalDnfVxf2oFANsAy2fhm374qoHX8cQR8Uy90/93TQGcsbmPyBbByoA6Miq9tTZbYGA2rNGZlwzq9rRZntHsZOO2Lz5Eh+czxLWFcfV4ax2/+cpTN5nJSs8JCHU8/9HAuJfxjkM160bXzrRJbXP4HLuYMVKid9POCvAI1xma4UVlUFpp5VV5kqpgo2JbAbJ0N6IfTYluFky66KjfQyBRHetGhmh/azwrrpD3+N4IrrXhriBEX8Ob8ksxEf7jMgykN/qq10O2rCTuP5MA9wA3s8AT0sOlCfaa+PXY4h7Q==
Received: from BN8PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:94::21)
 by CH3PR12MB8582.namprd12.prod.outlook.com (2603:10b6:610:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:27:12 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::81) by BN8PR03CA0008.outlook.office365.com
 (2603:10b6:408:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:26:58 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:26:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>, Richard Cochran
	<richardcochran@gmail.com>
Subject: [PATCH net 1/5] mlxsw: spectrum_ptp: Add missing verification before pushing Tx header
Date: Fri, 25 Oct 2024 16:26:25 +0200
Message-ID: <5145780b07ebbb5d3b3570f311254a3a2d554a44.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
References: <cover.1729866134.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|CH3PR12MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 356115b7-59e3-40f2-1515-08dcf5011de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VfrkbCaixnDOdbsGKNcpnBb/EywGqvBmDWK/PYZTtggUUyHZPNUhdMi7IfK1?=
 =?us-ascii?Q?Kle0YFSLLIyLwu74cNCuhvtU5zuUjf+sQrMzxsd0JxNt3o3eyeqXFG8A/HSL?=
 =?us-ascii?Q?abfg1mh7hkc7Q9RMbda2S0HcwVuGlzkXihi9CblbwoLbmeVc3jbb9SMMAq1H?=
 =?us-ascii?Q?GLF5zzZWD1Pxete5nts5gcPr+dx/SMNFb1reuALS04DgcWk9BmUFYJ6gMawn?=
 =?us-ascii?Q?aFYPvSkrflqfErnFu8wcOnLIqhp/85c0w64VKjmCuocZJPJ/y+xQMH2mfK14?=
 =?us-ascii?Q?apuWmd+SBYIbMV2bGx/ktfSY3WIyBxIRzU3J/1Kw2G2N/s195ccHI1bu/hqY?=
 =?us-ascii?Q?3AXs7Q1c+T2iSQnqfkEll5kDB4AX7vPpdkmI1QkCY+GfGmpRvNyC4NQnA2Jd?=
 =?us-ascii?Q?a+fNin7rjyJU56P4V1T7X7Wc1FvUtvZg9T0si0iJP0bZfePbz9UgOkHmG63g?=
 =?us-ascii?Q?RgvDKQlp7G6yGjKjwkyV7EfAuZJorfcgnepSe0MLKKHQG5vKgvKLcwFNl4tD?=
 =?us-ascii?Q?jb1o+hP2ITSNT91MPeHjDFH5GE9R+CIseRcxm46zth4pAyYXAxNVSpEM5YZW?=
 =?us-ascii?Q?fcve030nkqjLvOQSQSEdf8v1NZQufHVNt/EGRz24rOaYJIywr2L8wi9DyVAV?=
 =?us-ascii?Q?MW5zk7lGC9Kj+I8U4b+aOidmSFxhWZ7zZbvHifAG+ly5ngAfJmF2KYMA5Px5?=
 =?us-ascii?Q?NuGh2+cLj/sQwfe6FlfcATt2lvscIJZmDuPZ3lwB0nnldt6KV6gnLqouS5az?=
 =?us-ascii?Q?U8urw3l9ubdMEAwj7DC9cm0K+nBw2SjHpSyqw36dwpoXCG3FEfNhYqsrcg54?=
 =?us-ascii?Q?IMSPyqmPDRVIELUP17YCr0deo7xIYMZ492GOkUkUMLpeaS0fZ1ZH6iuQuxlr?=
 =?us-ascii?Q?sbHhMT3qUV8bvyIl3G9hEYTLoqM9KrgyeiFNBgfkW4wlNf0sP0QWB6DRpEdb?=
 =?us-ascii?Q?KjMKLoXcBwjyx5oRPcswes0S6RcyIci+2fBEphc/hB7RlTWnJgQkB/od5tIH?=
 =?us-ascii?Q?s5BnmJbYyvvOEsT+mzQPZ1ZaoJhuanHYRuSX1GTiiTHlNFaX6OpJ8Kk1XxbD?=
 =?us-ascii?Q?rPHcU/IA40UGpxtfXcV2HA5dZ5imV6sMRE9DMxOoB3zkrT8VBjxTlYEbt9/K?=
 =?us-ascii?Q?sUMIgalD9q3t8kqiVfvJ4m9WX+gofF8GyO8bzPpYoFDN8L9t7FQz9tqpn3pf?=
 =?us-ascii?Q?r2ZXjb6JZ9cPLi9xCvbquscVDXxbzIinU+8skFZhzOZiDiKIxMt9weLa2yWj?=
 =?us-ascii?Q?LFkWfG8mzx6d5BlCHP3IAARLCr5UDOImhwprreAjS9CVx8lSHbm+4Ru3NvSW?=
 =?us-ascii?Q?vp6+64oYIjmM5pnhYxz2A2ZHM7om2B80MsEC5RYoS/B4nKPQm7ytRk4ohPpS?=
 =?us-ascii?Q?NtqpgNJgCohIOs2/zHk3gTjUD3b3lGfYv7RTri/YLXeXEx8ykg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:12.2864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 356115b7-59e3-40f2-1515-08dcf5011de2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582

From: Amit Cohen <amcohen@nvidia.com>

Tx header should be pushed for each packet which is transmitted via
Spectrum ASICs. The cited commit moved the call to skb_cow_head() from
mlxsw_sp_port_xmit() to functions which handle Tx header.

In case that mlxsw_sp->ptp_ops->txhdr_construct() is used to handle Tx
header, and txhdr_construct() is mlxsw_sp_ptp_txhdr_construct(), there is
no call for skb_cow_head() before pushing Tx header size to SKB. This flow
is relevant for Spectrum-1 and Spectrum-4, for PTP packets.

Add the missing call to skb_cow_head() to make sure that there is both
enough room to push the Tx header and that the SKB header is not cloned and
can be modified.

An additional set will be sent to net-next to centralize the handling of
the Tx header by pushing it to every packet just before transmission.

Cc: Richard Cochran <richardcochran@gmail.com>
Fixes: 24157bc69f45 ("mlxsw: Send PTP packets as data packets to overcome a limitation")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 5b174cb95eb8..d94081c7658e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -16,6 +16,7 @@
 #include "spectrum.h"
 #include "spectrum_ptp.h"
 #include "core.h"
+#include "txheader.h"
 
 #define MLXSW_SP1_PTP_CLOCK_CYCLES_SHIFT	29
 #define MLXSW_SP1_PTP_CLOCK_FREQ_KHZ		156257 /* 6.4nSec */
@@ -1684,6 +1685,12 @@ int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 				 struct sk_buff *skb,
 				 const struct mlxsw_tx_info *tx_info)
 {
+	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
+		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
+		dev_kfree_skb_any(skb);
+		return -ENOMEM;
+	}
+
 	mlxsw_sp_txhdr_construct(skb, tx_info);
 	return 0;
 }
-- 
2.45.0


