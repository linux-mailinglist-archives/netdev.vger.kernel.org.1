Return-Path: <netdev+bounces-82282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8388D0B1
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC21B1F6497E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B1213DB92;
	Tue, 26 Mar 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVFCpcyn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F02113DBBB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491698; cv=fail; b=UO6hIArFF0a/MK3e3ZfairtH4d2QcF6f6qjCmAb2WDcKWcwi92HvNubdBwZ/tSCypB3fezEAQprufjS64jfeDg6ts9TMD65QT9En6wo27mU9iz+vt8dd52J7qyaQ6tSirKV85p01M/9EeEc52S8Bpwk9/5upMq0S/SYAk4wDmt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491698; c=relaxed/simple;
	bh=IJWm/KQSHX3mFxFVrPl4V3JYFVyCvcTSVPNk3mylu5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrI2K6jBSoLYe9WMuogh6nzTHA7fVxxTqZ3DlhodlzJRT3WG2BX6anyjYA0ErR4auLlhpnRCFahzTXlYg0DsUfE5bGZo/qMQXbu0nwLSmhu2c4N5Owi1nL8hjhZ1O9Y6wwP+UsKFwa0rYDe8IFRebuvi8pWZKtbnT4RiNfkksDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVFCpcyn; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrOz2rFLvBn60CqE9WZEi4bqNmNzfgt88x0l1BVajt0hhrqp/Vu5yTifycfn2Tz/7BW4HWVuyROUopp9aAaSVdJJKVJFPQ4MIBgBaxofflCFYkWefjuqaQpWvPshroOl6naBK9h38jvPsZHg0mRsNBkiUSnqbBSiqAYy8k8q/jc7hv6oQWUSNtqtZ/fhpSB8ipYADmt1b8fGCPrKOzjKSsMz3UBExwoHEUPBC60P3pKHTsj0LD/rm7fzR9o7qZUUWwj0Adm4cK8Lgb18HJNF3qAECHTqzgv5zqSKMd8m/DdUpaqhUZJAfOv26qJX00Oy3QZ9AePG/fpyVZGXLwGoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4OqeawVXBIPHkH395PCikTnC2qcajgbzqulxARxH4s=;
 b=PE8u+k0TJq5+X31vW8Y5uJ6eBT5AVFffUvy7nv1e4tsY8jxklfKz8HJMQeNVvErk6uR04ZfdXVcA6CpnNacC/aCA2FRxrWASnDkpjXjmyKw3cHug4wBgdn6TcEMBQATqzgqDRO0VlpsTAh9zGHYcbNFL2FgzidI/uZiK41/sDYWBvYjzVUIoTuhxKOjcw5WmLoQUvCU4b5eTmG5WnzzV2fSyvXWnb2U6W8BFl10MR3UTqMnqEZ70W6AcOvJsApbhkt4OAjoQhWgopiOFaWCoeePOBz0CbR6UcLo/cvmDwkfG7kixZ6Wdi+b4BG+NhoV2t6NG1rmQIifuLZ6HNpE1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4OqeawVXBIPHkH395PCikTnC2qcajgbzqulxARxH4s=;
 b=SVFCpcyn0NYNYHOC/+lr0fHhEQ+h128CjEigLl4SA83aKf3aLuueUyUA3FtmiJgkwoDG0DzjFluQ87sosibl1+n4Dyiz4ADEyNBvHKyhr0ROK9ZGj6GgxRjqA/rqtevcjlD2dkw1idocDMFkvwULZYxpae409JpEsML66Mhnohulbdr7p1a8N4Qe4psdttdhDb4t8ictJ/gyu7LWdjLm9gqvUkaspm1m+QWRPS/sq5Sr6JhR9Pzs/xUgSscsi+wnk53V0HIljSW8a1qV8yFGQsWeo9ZvpeLvrJwcaT5E/g80nfdOYxnkn9ClU+k87dyyhTOwsN7Jbzkwlds9T2vAJQ==
Received: from CH0PR07CA0025.namprd07.prod.outlook.com (2603:10b6:610:32::30)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 22:21:33 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::7a) by CH0PR07CA0025.outlook.office365.com
 (2603:10b6:610:32::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 22:21:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:21:19 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:21:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:21:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 7/8] net/mlx5e: XDP, Fix an inconsistent comment
Date: Wed, 27 Mar 2024 00:20:21 +0200
Message-ID: <20240326222022.27926-8-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326222022.27926-1-tariqt@nvidia.com>
References: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: d3155a9c-00f4-4e1b-72aa-08dc4de317a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SXy+w5CMPDFWjszlPtSbGghZwugIQbZHyuP3M0qVQhfmDUCAxBouYdgmT62MtNw5xHTYSU5tekwbr2PQZ8XDGhxXNzGGG4HLDSCdYJhmSyHzlQs5P+J+FzhijwoMrKv7BHJcvboJejx7f36wjXENPDzTex0y6HHtRiFlgdT9ZGTmxNlUfm4pTndfZABNrgCpkSWvfAWswbEYf19cPaYSfjLSNd5dwysSRe7qmXB+YDhYhssFGcoRFLq0y/XMlsLdPhketlssNq2CgR0IrPLWiapvroW4A9M9ax+0Ae9iCY24XVvyV/JuSw7Hx4h7l+bTaFfKvD4AnqmG9arYFVlmA47mi94e83Ch+eypYk1Eg+FOPLwJu72kiCTRJZFU1v8yUOe+q4WQgYrMRLd+hDPdApQKuAd0yXKbTaFyHka/oBxh1gUDDUvDr8tbVe8pHwUir8hyThsLRLYd1THLNYdjfi+G2s9C2r/EkZhQkBvqwE8TjFlFozvmKFHRrHCykTC8IQJwy1H8eK2EFsTolxbYrrwXzMKd4uzphIvagXI8KdsIBDmhRPUNmSKLBnDtkfv3tRoD5SMGHO+u/HJYPPlDxdQuvbZhsocLkRK40yL0MzSctuTnku9Cgby6buVeztbyXx4CwevCcyfGCF6yvdEGPvFIhKi7qd9xjaPbiKyDWibjW7Fy/MBPkHnQyLNfOiHWQtCN94CR1QZ41Dohoed1S198xnyWi/+AsWpmr6qI16cL1qj1cGEPFc+1PkTe/1MZ
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:32.7864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3155a9c-00f4-4e1b-72aa-08dc4de317a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

From: Carolina Jubran <cjubran@nvidia.com>

Since sinfo is no longer passed as an argument to
mlx5e_xmit_xdp_frame(), the comment is inconsistent.

check_result must be zero when the packet is fragmented.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 82b5ca1be4f3..4610621a340e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -565,7 +565,7 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	linear = !!(dma_len - inline_hdr_sz);
 	ds_cnt = MLX5E_TX_WQE_EMPTY_DS_COUNT + linear + !!inline_hdr_sz;
 
-	/* check_result must be 0 if sinfo is passed. */
+	/* check_result must be 0 if xdptxd->has_frags is true. */
 	if (!check_result) {
 		int stop_room = 1;
 
-- 
2.31.1


