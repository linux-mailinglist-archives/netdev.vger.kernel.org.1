Return-Path: <netdev+bounces-116110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB8949212
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050AF1F261C3
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859901EA0B3;
	Tue,  6 Aug 2024 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cLzuFqOi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2F31E7A5A
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952233; cv=fail; b=FQAl75SHIuOhIZJ18AB9iJ09hCgakrIspu5ggTRSRXsOJGquuMDwrB9VZJcRaqNYAgkXK/7RG+ia0As5pum2tG1HrNBwMecxy9a2aQjHNkVUtPaSp3aXL7ayBE4qSV9X6gBZ/7jCS8kTOzbdxURNsE3EdnaPJ2+11cyPEIvuZLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952233; c=relaxed/simple;
	bh=14Mfjx2KYmGcKHUeF6uAMhKJStDDKIhRsIkub5fbIis=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfN5b5/PGgc/tIy39T6ib9ZaClD4bCXhtWDakYUmHexDFurmOdQplQjLKVw6289VjPP51bNwf8WWuz5rfAN7Wfb4Qr47U9mSrGe9CDSeSr99pe/afjQQuLsJJpjC4K/mlmEpTF3RlMjHxSdEcILTsttxgIDeTrSsqniFYuh6bvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cLzuFqOi; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEbv+816GZjDqCo95pPGZI6aLFKRvcqER7/b1Mmg0ie3sd2a0Hau/jqQI8o1VnzQYFGSDh5PJum7UX+wkX5PUtYHZtUHX57TaNI0nFVPMw9XpWlf2c+54R/GU84Xl/16hqwyTQWkHv9sEcCCQmAv5w1CykezMMGODy3SK0R932aq19MsFVteET+FdQ0xlsQkDEsaJPQopbwrJMO/6fhYv17GbCpq7fzdygA0NG2KPLBwcLylZeKUQNJW8XfDLiG6tyoSsp58OJsPCAl5jP7G2lA9Nq/al6m6FkNcrn7vg0d6PbagsdYDLkcq3KEzSjRI8LuldBKSrRAneWi7SbtFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HgOyTCRBIFb8iH+CNAlb69+yaguk3+v+7d8wvveXdI=;
 b=gcpx7g0oLiESkWV54MAk9s1Vzl51/LOh6OZjt732w7CdSZGAD7400wXoD5Z1N/AqIYgJxaSxdnqqSLs63LKOZi0Jrvb+SeqH2x+PfMeJraCZKQXpFdG1omMV51SMDj2CKBZfVc2uCCE1pPovM5qIs/5G731WZlr5lVoNdv1rUisQm1OefAfIUtcSvu7oHHre0DgBMDu/avFnEZTH2gYMPmODSWQ3lBGR6uzFrqSFOZHReq18StJXSS7+J5c+nSG2BzewSa0MrCwvKsckMAuUGatkvZ6El1ssE+omrKeffJaLLNbbSjaQsNb2wsBQhVJEbXE3Uyo43To0pdtVmty+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HgOyTCRBIFb8iH+CNAlb69+yaguk3+v+7d8wvveXdI=;
 b=cLzuFqOiFNDxSewUlblBfmj/uFH7HyfxgoTghhYen/WGchgPaygmIXGYsLTFhSYZkbDFtVG8PAq+WnjskCyiGEJKdWfcFjW/s4/XJ6lb2dWTPmA3oCI3BTbPvLj/rL3bzltFkJ+J2Am0LVVXEDw3VpbzeAtl2p79nl+Q9fwn1Uxtb/P5WTPhuofjHrSQQGCK0QAs2B5VMWl3g0+8Gfq+XWUmHh39CZgFz2wrRZ55C8bKPX9xkR5Ip5XT0dCNqAemuiF6qMP9Xzzbm+j3/ApQY/pS6Q5rbXHctm4hcjrlQixu1G1EgbHWN31ivszaDoUHYNDENlA3V1Mx0zX5HESUVA==
Received: from CH0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:610:b3::30)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 13:50:28 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::27) by CH0PR03CA0055.outlook.office365.com
 (2603:10b6:610:b3::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Tue, 6 Aug 2024 13:50:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 13:50:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 05:59:43 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 05:59:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/11] net/mlx5e: Enable remove flow for hard packet limit
Date: Tue, 6 Aug 2024 15:57:55 +0300
Message-ID: <20240806125804.2048753-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 7619f6e3-bc1a-4af8-aa50-08dcb61ebac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9/+HnHxEwJE0Kmt6jIAUzVBE9whnno+oorCurndCqpy1yJNPmGq7ZAUW4Aa?=
 =?us-ascii?Q?07CTkiG3NerP2zuBU9O/D2v5gTpmmqntCtgH3j4rHd94sz2dq96WljCCh+UJ?=
 =?us-ascii?Q?6ab46+u9ZREOt4SW7gOSrCsOQ1yRUBHkjyE5ORrYZjwe+HE2cnGhMyRMpYGL?=
 =?us-ascii?Q?3C07R+xuYerk6QrMQIWRNW4ydWNTz/OSMQ2JBFgfP/QYrU6PsWPcHF+tHJts?=
 =?us-ascii?Q?5aNq5nl+j8RbYhH9GP3BWgQPy5knJ/QLDnyzduhFeOwvVbP7aJ/6V9yLZ4iB?=
 =?us-ascii?Q?I0M5M4grzgPwzUHthBZrKeMIMk7zqKS6b9PNqub2qI7ekrTatfxCZi2oSxaC?=
 =?us-ascii?Q?yni/Y7EYfxifUr1dGxylYO0StQJnzkFOH/YZPDORvxhPfpcht8XEZGejMNa7?=
 =?us-ascii?Q?WT5KxQ4FlKNAkCsYmj7/N7NRAMQz4P6fjHJZp2yNw1lhrhDRejbdU+tOf10D?=
 =?us-ascii?Q?6BoQQYXSPS9u/fwPs8IeuJlDC0rBbWKS7GYvYQr6Rk7gCA0k/heEwp+YYngP?=
 =?us-ascii?Q?aRBvcyPXEZkuqk/w0ZywWg0zrrLJFdYcdEgWXSRUi28cyLmLWgwPJtzD8A2U?=
 =?us-ascii?Q?TCqxpFvuLrowFUrplEMQN2RJIPsqml7FF8gqV/qzQyhQu/ltF1NzFKRjETdo?=
 =?us-ascii?Q?eyjkwkVC3134mKh1SlkpBSzwlCgbFt6G1C0RNPCuQOZaBX91EaFtxC8h0zlL?=
 =?us-ascii?Q?lWJD4w+sTWeuHFfU5BbRJPTYRZVi+EI1ZdngHe8+8M5AUTiiXgcBgjxokqvO?=
 =?us-ascii?Q?yHufuCKjBygpwTiS2cewGoBPGErOzMqtnDcWpe8PJxKZnnY/Vd/NjUlR4kJs?=
 =?us-ascii?Q?jFXl9nzCM3PfOSzGuYxI+JhUBU2eHuxDYIN+ogzvEW8tR0M7/1cdhHr7+Dmh?=
 =?us-ascii?Q?GvWoFNqM7Q0nop3X2AtnVUM7Is35Gii8BHBgIbVJWSg4ZF9IIwyvWh40JHdV?=
 =?us-ascii?Q?tNJNlEE3ycNUq/Ycy92k4CSpujoAn1xL0g8xa5xnZzUftAR7v5Y4zSu2NkFS?=
 =?us-ascii?Q?LWjQOIQEbR6d3ksMgIrGkAu9DnXccrPU6o0sYTMN0oVr3To96KgFwUz8SYqu?=
 =?us-ascii?Q?L+LcbR3FPy9IvyCyXZSSBfGELwntmOy/eYTHgd5Uo9WBVzF2yY61jz6vQyEa?=
 =?us-ascii?Q?mAIPdGUe2nTOeuCvzM2GWcH/uUX69BDWS0a8EwdsQP0tZIHS8tfgSupGxlLm?=
 =?us-ascii?Q?RtJf+92glvMkGJIqqETwWkgQEoK3mFS0GPWSFaHsKg4G7pQlxnEHBeap0j4B?=
 =?us-ascii?Q?zJHzujCglZOHaAavT3Z2Mmerl1Y8ZPNJVwC5uaXfV81u9JCmUtTdmCJWfXW7?=
 =?us-ascii?Q?MFepoC1Cx3zbNrEAkmWglxYIlQnCY+dW7KK0rWKa8KipSWjB8zS1AwNJS+6Z?=
 =?us-ascii?Q?oWySLIoYWo+prsd4+2HrniJaDVmzvab4iPscVxW8/0utF1oaJYi9an2nDmeM?=
 =?us-ascii?Q?fLof8YVnBJYQi3uFmh0yCtoFkl+XJuEj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:50:27.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7619f6e3-bc1a-4af8-aa50-08dcb61ebac0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

From: Jianbo Liu <jianbol@nvidia.com>

In the commit a2a73ea14b1a ("net/mlx5e: Don't listen to remove flows
event"), remove_flow_enable event is removed, and the hard limit
usually relies on software mechanism added in commit b2f7b01d36a9
("net/mlx5e: Simulate missing IPsec TX limits hardware
functionality"). But the delayed work is rescheduled every one second,
which is slow for fast traffic. As a result, traffic can't be blocked
even reaches the hard limit, which usually happens when soft and hard
limits are very close.

In reality it won't happen because soft limit is much lower than hard
limit. But, as an optimization for RX to block traffic when reaching
hard limit, need to set remove_flow_enable. When remove flow is
enabled, IPSEC HARD_LIFETIME ASO syndrome will be set in the metadata
defined in the ASO return register if packets reach hard lifetime
threshold. And those packets are dropped immediately by the steering
table.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 797db853de36..53cfa39188cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -127,6 +127,7 @@ static void mlx5e_ipsec_packet_setup(void *obj, u32 pdn,
 		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_pkt_cnt,
 			 attrs->lft.hard_packet_limit);
 		MLX5_SET(ipsec_aso, aso_ctx, hard_lft_arm, 1);
+		MLX5_SET(ipsec_aso, aso_ctx, remove_flow_enable, 1);
 	}
 
 	if (attrs->lft.soft_packet_limit != XFRM_INF) {
-- 
2.44.0


