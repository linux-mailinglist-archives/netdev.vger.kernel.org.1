Return-Path: <netdev+bounces-154820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16C9FFDA4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B327A0588
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657CE183CCA;
	Thu,  2 Jan 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="slpvHD2J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D41AD3F6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841772; cv=fail; b=OeIltaDi2Nbkb+ALADTWq1X7qovnHrP8mbYwI7XQCJwowoH0Rgor+/Vhusvn/ViLMbTveoBhcVHuyomdRarvYDBbLYtZt1b2qujr8HRtMIJILiqzR1XnOGrHOnF7Gan2ZMIMvk4G6CEMy9GWo34DGoeUFZ0dwScb94w7PradFNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841772; c=relaxed/simple;
	bh=pEg4DSlXw2y0KruFTv/3weSr4or1asWRT8RNvD4ewqc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUdu8W3veGW+akcPIpLVVeIjtKinGeuVbcSodQopprTPtnhG1ilLCTZYhWoP9PjoKHwgxdMH7Ob+8PGzORkXb2KWEenJMyzR1BBM4SMtKNXC51rqGDZeywT7soG6WGjKy6wg0P0VSj6vtE7Y1ub/EqDp2vlwHCMUzjZacxNVPHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=slpvHD2J; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=decKg88IKDEe7KjPrXAueE8pUm+1eh1AfnvWZL7ozCoErSnPPIRCuBVMYJoENO8rFr/95qL2oTP5IH1kON8xVYGy8b8UgHCBb0dCxp8fFszFgRF1o04/mezFDCMdaiv+t1JF7H2vPyyl4aHJOP/jKIpG0nq2ap8sBxjngpI/bx4T8zuxf2vMuDbFy+GF4tP4MLmg0WmzIM7B+ROZY43lSQcIF6z4ib0IyJ4tdYsXV49R60ewiNXFXSxA3Ok5sFWG21cq+uiBJ2bkZLCivIA9p0IqHDQ8KYMJoigxM+B9Illwyuzo1FJUQ8SA5qs0wfqZ3J3ipVEiNpAI6RWxv/PP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrXlNr9oojwdCFkk9UCTe3FaTk3H6XMU+JIfcAtsn8U=;
 b=kT8ThtlLvBLCDbOBJVZlT88Wdo5/HUDIoJGjMqAsLLvehOYTjjLyUwyAi8ocQ3qzKDpEjjO5ZYUIGJCxK2yiOHA4FcYYG42YdV9E0oND7odicjfVT83mWK78ZIbBTeJaGR4eo9oHaFBeuKq2PI3uqGYkQIXrMBG80meqwQrS8UV81AvZIellRRjVzYfRo1PYlh5nVblbe7XoEIhv2mmZH/YOSPkZtcu8p+CFyaKtRW6GxDUBNwORfMcOd15B3mfwZbcAX1rPazB1nq7Lj/N09Q1FRzKJGnBwyeVN1pqBdtFUJ9cAGFXAfBCxnsunLT0PgLXPg5+ZknCWNUXUxqdI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrXlNr9oojwdCFkk9UCTe3FaTk3H6XMU+JIfcAtsn8U=;
 b=slpvHD2JnMdjeKHvWPi52ijlAqxlVXP/H6TzH2ugBqvc+hXEM47jGZAgJkpv6nRDfQEUdgA4S8BPBvOEEYK6epBf4RKd3FxEzJufDxTla+xpfBYyQRnTtPHEHh1YXmYOiShDK/m5s48RIVYky06SZezRvq0w4ilgIGCx5OlEephBjM8FC13bDVKt3sTFd8yDs4WpmhWLcW8XZ7me52q0ttLMCmsa7O5McUObMvBBGC2RPFyroAWrcP7XmpJh84ny6otjyT+UUm+XLXTp45uP8R5VlNGVlvJTrxCooRCM/RnoczLthKvIyPeewDbqDrqRzr4mjFMNM+E7Iejb3hXvXg==
Received: from MN2PR22CA0002.namprd22.prod.outlook.com (2603:10b6:208:238::7)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:58 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::1f) by MN2PR22CA0002.outlook.office365.com
 (2603:10b6:208:238::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 18:15:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/15] net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset
Date: Thu, 2 Jan 2025 20:14:10 +0200
Message-ID: <20250102181415.1477316-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: 280d17dc-8bae-448e-57dc-08dd2b598186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wZ/E9k9lWCQl8s379survqPQfS0ZBKWEi+HWHudQ6Hb+KztNUqyP1YafxjBD?=
 =?us-ascii?Q?ztQltUPUq45sRLFgJUD+c/2/A3x1jwocytCRO93cbokKR4xty+KVENGIJMdB?=
 =?us-ascii?Q?N07LT5y/ARSaAsO4ke9CBnY0Al3hIAvJbGJLm7BSR+EdPIHXMI89JJKvHPFy?=
 =?us-ascii?Q?l/wJdul3DxaJkfYJZyJzMnyp85D9868c2RysjC/repTrOIZ6LK4nqYLobDy+?=
 =?us-ascii?Q?X3iRurn4rI5FtaU5YEsYCRtJT9Be8tj0YZWy6ybkNh21ilBdoZXiW8gA+J3R?=
 =?us-ascii?Q?CrgzjnE0AMOpfvdYvpKqJ4ofyIUs3Pu92BNqp4TOI4b6pXhWjEcGO40NyHuG?=
 =?us-ascii?Q?YTBLrjSdnfU00gvKy/GPuoj9zyVAcU50NO+nxxJKBmreR9gszEcFDtS+NE28?=
 =?us-ascii?Q?VMBAmRBF7P4wbs1y0eYaQZWu5QlAkCtBqpD294UljxWV4YSjf2dCUPUaeRe2?=
 =?us-ascii?Q?hJdfwqkTH33G1A6cyLEXoErItStE6ktxWn6G/RP1J9gJiY0lM2IqKhZwCof6?=
 =?us-ascii?Q?bFl3MExZJAnEPyHOz6XFYnPYxR/yGcDHZcG91thJVYBGkQ1b714pt3CUcG7g?=
 =?us-ascii?Q?iZJNFYIcJrwA1hcbqc/4pEqL5p53rflYUR9uJc2beEsxALrvmz+r+AArqyg4?=
 =?us-ascii?Q?rZwl6wh2/s2grqAbQbwnYrEKokKO24BsB1DxJpwdomgOiCeH+VNvD6FwliT9?=
 =?us-ascii?Q?q7WDO/yIu660H40FBtWLyXpDAJN3c70mupGlzz7M3nS6eBPPKo+GFE41+jqg?=
 =?us-ascii?Q?sbiOb9zz2FNrB+BITX5FbQ0nYf6rR0p/fPeIGfST0td+IsBzt15dWrJu18Nb?=
 =?us-ascii?Q?XMd7nnv5ww/fSfwXb6RnebIj2p6OEifYC0s3dHcraAULwIAXKLen8jUBQIRR?=
 =?us-ascii?Q?yFB70GNZ7+G0bT4ip/VKcODT6XE64QnfypUlNxg+RJyoGqXYD1om1HbMzh1T?=
 =?us-ascii?Q?sGTa4bXmq2zLtByEfuBzmYLcmS6oHDIcviN6t4Yei6g/xVBOucMvDvmdWP9l?=
 =?us-ascii?Q?XGrSWBqzjiRX3DtaLK322K2DgFCGztsyZWzOG3iYmSlV2SGvi62DgqDZvw9G?=
 =?us-ascii?Q?JxacvTaBKlEks5aTXPiBFwXMr8ECh6X+8n2eZIDvtxth8H9GL2mqJlUsBA45?=
 =?us-ascii?Q?Qrxf1nfDyc/jOLxRFOopeKccCDr82xOTSruSNcjk7Nvv8b71+yxXs+8oI10H?=
 =?us-ascii?Q?9WT6Tg2AujMNqSBNWlLTgdgg3neFYPxvjqsFqIXNDJf5svhndsq3LwUFREZk?=
 =?us-ascii?Q?jB7YP5m5OiTXyLdnSGy+jKX5uF3+nkx6XPV9z4DDCASm29v/aAXlTUT2rPAr?=
 =?us-ascii?Q?M0UYsNos4Z7TB3yzgiKi+8j+3/5HSHTo+PeAkecOpeQ5y66jU5qxOiZL7G1c?=
 =?us-ascii?Q?A2p/Wp44Fx2SALoRunGm+BqpBagXHFnN2lYLrFDH+E0YT6JHZZpGHB7OzJZg?=
 =?us-ascii?Q?DHNT0WmSSkWQH8uhtrXTbqlpWi7kNloUhNOaAWjibbgcv/3w/llV1o5IQkI3?=
 =?us-ascii?Q?JWZTczOfDngzhmU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:57.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280d17dc-8bae-448e-57dc-08dd2b598186
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When bit offset for HWS_SET32 macro is negative,
UBSAN complains about the shift-out-of-bounds:

  UBSAN: shift-out-of-bounds in
  drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c:177:2
  shift exponent -8 is negative

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index 8fe96eb76baf..10ece7df1cfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -70,7 +70,7 @@
 			u32 second_dw_mask = (mask) & ((1 << _bit_off) - 1); \
 			_HWS_SET32(p, (v) >> _bit_off, byte_off, 0, (mask) >> _bit_off); \
 			_HWS_SET32(p, (v) & second_dw_mask, (byte_off) + DW_SIZE, \
-				    (bit_off) % BITS_IN_DW, second_dw_mask); \
+				    (bit_off + BITS_IN_DW) % BITS_IN_DW, second_dw_mask); \
 		} else { \
 			_HWS_SET32(p, v, byte_off, (bit_off), (mask)); \
 		} \
-- 
2.45.0


