Return-Path: <netdev+bounces-84029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C889557B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E68B2B438
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63A85278;
	Tue,  2 Apr 2024 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r3jk689d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7785266
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064745; cv=fail; b=BR6QfesEiam6CZQBOQTGyRnG+WLcIiuVX9XQ4LiVxmOjaw1ywryBXVhGc66zxzN6kBecGqXqB3I2mu5y8g6FOrkl7JOXm5MWeJZFmKw9M8LRF/KfRSvFctcVLmmOLwPG8Wr2CoWI3SNu/9rSR8o91un5suYLu4zGLhP/l2C1K1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064745; c=relaxed/simple;
	bh=GkcU1gKSI35pbi3LegrvJo3c9q0guJZx9gF4tmFQPtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmp1iMvWTH1mtjFZhX7miSc/LwbSN2dg48Sk6I60G35/Zn1l02oipO5WU6N0Rb1Wv+OAh/VTZ1Tf8xEyzDF4jVTIUCtDNL3XVWaGaBfLIx2j0JW+6LVyO9ezSmOLHlyKmVYHsB3K3Tq60CXiBIbjxb8ZzpgDyajfDcywBT2Y+4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r3jk689d; arc=fail smtp.client-ip=40.107.93.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bShWXbxRt8cOD6PFD/Y9XWtqRtD2dLjyuvLO26yaT3G0iRvqFe/5nicAQNYO/WxnCN1MbSUZW+gOPH/IZuK35jz3QbED1jz5z7cEmBL9ZMMGwKUfTiW2C4Ne7RqOQCUUqriMbfbIqQyld0WZeKvcVG9NLAerdsSLuUhZx/baZOONQ0bOiKfOxpS4klLqsY6Bx7+oz7ntWvTZzuB+5yR9qfa1tQ8UvXfyDsp7/+4frjfOouiszPsROX7cCC3GBJJxACV9l2RVcJOYl7ezq1c3IqyLhKAMhLi09wsM7IXPJ1e01zRGnZVfiKC5Pwdznv1+kmAGycvcjxt7f+/UrfGfAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuFYiYalFxaFU8FWggtRG7p8m6P01B+dGW5KpZQgD2w=;
 b=O4JYovo7eOT+2f58P1rP67Fhr9T6F3Y+k2ZaoVANMhIRGlD+qPucxQa7pFKXkmsSHTB2dy70/Q/cR1zZNaM4g35hjH8IViMrSuoBPPR4MLaolEe3d8zt+pfRptcUHJ3AlMknX2miWJ/4Zcm06gTPB2TsKYH56/5srjKbhrg1NHhQiCGGTVeTqvGYgxujRUV9p9AYeJBdY9pA8mKgjWzgDdWVC+ReD3ZXIPRAjOkg3BB0CMuEl0jdGibKWhMF1ilMrZ16zZ8ab3WqYHz0sqjqtn9jtxuxyaxVhAL4SV8raxXCgfV3bdnRGi0Tf230XG0YFQCB5ATCqzgIZyaN7MOWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuFYiYalFxaFU8FWggtRG7p8m6P01B+dGW5KpZQgD2w=;
 b=r3jk689du5YMpFVCSueqYQieix7JW7gn7xjuvLdsoPI7RR+c1hsVYPgm/n/LqqX7Ve8KNDKR0xwaLgaLYM8yaxJS6xtlG/l4aQo6NlULZCdAtHGY7kOwx0LJ0xTUcxmwP7Eshohb0j++oSIt21db6KSPomqTElHDAUj7C5bT1DGpydnMY0Ay/0wDkSkcMH37qXc1cNf8LQX3NlHl9lFVEtyfu2AJAvV/bu4U5VQwPYTN2Tz0VNwdTxnROJNXwvI4TDEEmNHVBJ04GI0V//TlVkabqjI2PctXtw86f9lXODUXBBp5Y9b+PI9um1Gm9R/5hCLGs26iv774dbs63yL70w==
Received: from DM6PR03CA0080.namprd03.prod.outlook.com (2603:10b6:5:333::13)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:20 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::c6) by DM6PR03CA0080.outlook.office365.com
 (2603:10b6:5:333::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:56 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next V2 06/11] net/mlx5e: XDP, Fix an inconsistent comment
Date: Tue, 2 Apr 2024 16:30:38 +0300
Message-ID: <20240402133043.56322-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: d109de31-8f2b-4ccc-6e89-08dc531952b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OLvNiO3+YpXeF7aKmI1FB00K2vXmHO/ao/CLj+SOm/ioWnjCUIBtxt++fkIrAVXlBlAdr3C81Plff2eqTKfwWw5dtprsLOiF8W1yQofKpWbpyFpkyyQ86uiq8xhxtYad+RRn4cE3Qo1yv9WbKV9Z20PvjlZmX9S70PsoG0vRAk8EaZU1BFzVY7Befh5tIITuz79T2pghu2qY3BX3AScGslqDHN4P4DoD0Ho6dQR9iejL65qntfS7x1oOxTllMxuxTmr4k4bCI6CleGSYWSL/3KCHlBfZhENkTWSj8/reysSadgBJ/lQWkjeA04tPBaevszkbwms7miO8eKDUZT/SgJgHyEmTg/Le8Eume2IrtsA7DdRgUr1aJkAyHRlXVR1B5csmB0pD0xqPyDqHDo791gWMPjPexg+Qhj8uwludXo3WuvjRpNwrWMFvY8mAkNwpN0qP+OrPKH9fW/u98KQwlRcKqM0pWr2IYrkhmL6fYL8wZ9/uf6qOtnCChHAq5lL7Lx1v4jqvAZxx2284xJJvE8QjLf7p7kmOUDTWoQ6cQkwHSqOrhxSxSn9PkDumA946dJJRwg+dSmopL9YL3xmdQwUkFaq9gdsEERcaugC64u98s7B3RXLbJh+WtNgIMxUbf4JFNvmg7AuebMbPU3V88cGOfNRXn+SdPHQeqxLVrM9TKx2XYtlScf9hwDHO0+U1msZMy26rLTk3ddZX2TaXb+lI/XZlRUX1DSSJnPyM4rKFtIUpKLFVGH209SbVs3mb
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:20.5049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d109de31-8f2b-4ccc-6e89-08dc531952b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766

From: Carolina Jubran <cjubran@nvidia.com>

Starting from commit
eb9b9fdcafe2 ("net/mlx5e: Introduce extended version for mlx5e_xmit_data")
sinfo is no longer passed as an argument to
mlx5e_xmit_xdp_frame(), the comment is inconsistent.

check_result must be zero when the packet is fragmented.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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


