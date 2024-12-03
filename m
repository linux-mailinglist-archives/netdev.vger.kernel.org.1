Return-Path: <netdev+bounces-148681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6499E2D90
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70751282133
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1846209F44;
	Tue,  3 Dec 2024 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rdxYfTxg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175E207A0A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259024; cv=fail; b=XhzQFX1B25bPmN2ZYcfU2liOYKp3EQ0ZUoUO6fUImEXpi6sYg8y8RNgC/QTD2rr8B00P2giiYiIk5CdBbeOJf/p+Kdje62VM0FzPNqw2oGBlSR+faHLOf//9Kgx78Y87xW5z/pgO3d96YBSVN4p4qKppyRgXY/ErDJststx37hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259024; c=relaxed/simple;
	bh=iytt+XPlSsqRu3Pq4Y/35UxkbBnhogG1DviI/K7KoLk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JizhDGX6arUQl2/p6+taD/zPHKpf8TEwUauMseQDhB0qrqtzFTVga1ij/TjhViilzcx4MJI6y5wi6andJ5+/fFpZUyNwBXZU31V4RzRohgSK0BuCH2d3VpiAeV8gD5JKPGpuWb6kaZ0To/S5YJDKqs6SwvnQvIEHDvi2EzZ8BH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rdxYfTxg; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt8xDKuBYLrrm/beso6PM2Jb4OdmdIZ6U9VIOBBvxMLEukT7oW+YzajlCAKwjPVmY3f+K0T3fm+4F+NNihn97/zdPYYxiBblbgC/CYulaXTit1Co106/RgbCkc1IOwIQ+gg6jidMOe/bnbpgWvE8FIBz3h83yrHmhRiUUr12lp8bN1SpdrsgJ83bZUXDLFbJARqQbKU60ThlEhL9/iUN7Tzk9Re5gTyxVMBzDHTRDiCAzv7PDhzkP6EUo02NP7g1b2QV7Kfno9YkT5ugUS70L5lUu+2aFZe9DXEw8UgisxIV8eyo4ZaQJetJOcFjcpX4ZP0pjOeL7b8bSc/9BGEw/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEVvuyTa4KCxlT0KkoRTlNX4GRpy5vKKszSkT1YdPgI=;
 b=fic9B4koW9lLLRzb5n+YirxWnZ9ui6Ry9PwYSWG1VcnvTrza/cKjBVyJEwDRTYJCtih0s+num9pqQRsojqfR/8JI9SmDX5awyRy+vqTCsbOhj3zAdha/Ke+fz0WZsTXP5vNKjMtFZ/UeVJkHMKKN/x0xraWPkJTLbpwsl0EyRG+h/5seyIAo+Kq0RNriospfhx6HF+IgCcHlkuaYj8UPZAxFVHVzll88DqiZCxydOSq4Jam5goFZF/qRKv0LE21vt7dj4f3U3QcRo7SjtmXTH5/3c5CKXiMzuCos7NXVSlnPs+x21KwK5A66/lrmeLmuUSx7b09zliI9GJPqOWa44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEVvuyTa4KCxlT0KkoRTlNX4GRpy5vKKszSkT1YdPgI=;
 b=rdxYfTxgNoS5DwKz+dskeQutQsIHcr4NOggt+jV2Wi6hPclXNF6+eIkRfqI0n8vALiaLS73bR6LhOSLNU+u7qqsD9fJJbtZd08STzNRJbjX/sYDPhZobDC1GrcttvMph0zXrEjongumKV//ETZ6s43g5BlNTzSc1ou4KUmvv+dysGvI4dNsT+8aDexaEhazpy+IwDSCJRQSPEwfeaCR2YOQyrjW8G1om3OR7/7hX4C9rGH8PddFPwPX0tSPxEPd05RXfByKH0r0b+hD0YvDc9aUjfnI2wJXMbdGzHWK4cHbxJjLdLFUozq/rvzVEBsjNaeMda5EqOhZFlOmujMtImw==
Received: from MN2PR22CA0022.namprd22.prod.outlook.com (2603:10b6:208:238::27)
 by MN0PR12MB6054.namprd12.prod.outlook.com (2603:10b6:208:3ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:50:17 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:238:cafe::c0) by MN2PR22CA0022.outlook.office365.com
 (2603:10b6:208:238::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:59 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:49:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:49:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/6] net/mlx5: HWS: Properly set bwc queue locks lock classes
Date: Tue, 3 Dec 2024 22:49:16 +0200
Message-ID: <20241203204920.232744-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|MN0PR12MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f27a15-8359-4749-4c1d-08dd13dc17ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XROWr0ubFwmhmP6f6Nq53jXzwwrAZoBtzXbpZ8/cpyx28oa/7wCVbWJAzSbR?=
 =?us-ascii?Q?4KDgb4Z7At8T6EYgsOND1djum3lcAjhKDcfNkPJGG3tpIgHo3FkdLbitjlyI?=
 =?us-ascii?Q?7dIH1ghBIiJyZ0Nwvf/+ILyH26vdNhHjFOJzU/MmFro6/p1E500PcOLyB0Yr?=
 =?us-ascii?Q?q+8fGg1VKUXh2jDr+ToyX2gGbYzOtwcYDEqRQEvRTWQZQfNGvbOBHs3B/CVB?=
 =?us-ascii?Q?sYBgAX/XR5Vk3WJjjUbdsv5nkzmIAPs6663oMIQqJkeNjkV1fhGzMtqp+CNy?=
 =?us-ascii?Q?PRaLISfTKq5d3g1YDnrtjGF3LN/0cG69Xcq6sk/QSTXQOn1N/zmhVH4SWQeB?=
 =?us-ascii?Q?4RB5cBPP+ifkLqCNP34Aj+m5DcP53yf9dC39A3sF1dWt9E6vMXk00h3HvCmF?=
 =?us-ascii?Q?Q/Sgv7MUHM2e0QFr5mkLDmNemfk77WGAGxuHjx5AuLxdL2cMdDb3UgPUgvP3?=
 =?us-ascii?Q?9lh8hs8jcpgU42UzjCO0OaI821J7M3qMGXU/74+0nEUua2v7DPqa5oDCKSx3?=
 =?us-ascii?Q?FA6gLSOX545Q0Rw3FhzYwWPdB7UyzEv+XcMdUL1dBtvD4xmkjwu1KC/Kofrk?=
 =?us-ascii?Q?sW2qmOI8j7rUiX+Eb/Tk+v04Tq7XfbEN2Suo70hF0A28RJyCR0aToPH8C5uQ?=
 =?us-ascii?Q?VBHOtF2IypRFd/MjebgjHRxopBWMOlmEb/chZgq3U9TygT4mneAuhoFp/EhM?=
 =?us-ascii?Q?vqgrdQUP05RAF+XyfTfE/rePDbbTa+HtBWUkSA2EA7D1EyznJPgP9jzTmXWc?=
 =?us-ascii?Q?ZQnfp4z3XHw33XlJMgFCDXUHBBJFjtXc6ffj8ArEuZa3NUHGYth8cjl8vxae?=
 =?us-ascii?Q?Kh41xe+MKyhlYc2XRQXC6KTPXAdqCP+g7MFo3/jtXFacShf6dIFbmMSiE8sH?=
 =?us-ascii?Q?wj2THs1/AkMctEzrOWm6nhP4ZZU1pd0pIkvBh+UMSLzMX8l4LGqvPP8P9G5r?=
 =?us-ascii?Q?NyGBLfhYHl9R3gGyyV0WwOXutoSK8E9ARg6kwFD4YnpCQdw4zSqf6N4Ci9Nx?=
 =?us-ascii?Q?tSo5Yyg5mKKViP5vzIXUzxLZ7JMcUQWyilj9w2w4R/WZKb/wbkW2/pLI4Wyq?=
 =?us-ascii?Q?xZnxGYDZh5+Io2nX58fO/RYXqGlWphU8JiJNCJwo1ymgqbg+56eB7rwPTDkD?=
 =?us-ascii?Q?Pj18FJPJn5130OXGEfIAuXpzthfuA87ITNoQ24EoxTVLgfVY6FXc0iVJLgeN?=
 =?us-ascii?Q?iYFXKaD3ZN+F9T4DXWDtOL/wkyRWvTFMM+P5l0Eg6BP8z9DTzTkl1D2qw8WG?=
 =?us-ascii?Q?+f/fMziK1zfuUL6kRHv2OaUQC0IenQJYMgS5vbqKPrLvC5mcUiZVAxwf6nv4?=
 =?us-ascii?Q?FWKbKNnA4lHg47YkEj1D7n7J0jReAjLunlAEzQDe3p2FbijvvGDTmg+DebyR?=
 =?us-ascii?Q?9QRB95KqLCME23L+/9zggrjD3V0UjkK10K+yu7q7aRZT/khQa1prF6wsR35E?=
 =?us-ascii?Q?KX9Ub++wCasN72X1cVXupulxENirhO88?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:16.9269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f27a15-8359-4749-4c1d-08dd13dc17ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6054

From: Cosmin Ratiu <cratiu@nvidia.com>

The mentioned "Fixes" patch forgot to do that.

Fixes: 9addffa34359 ("net/mlx5: HWS, use lock classes for bwc locks")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
index 424797b6d802..883b4ed30892 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/send.c
@@ -990,6 +990,7 @@ static int hws_bwc_send_queues_init(struct mlx5hws_context *ctx)
 	for (i = 0; i < bwc_queues; i++) {
 		mutex_init(&ctx->bwc_send_queue_locks[i]);
 		lockdep_register_key(ctx->bwc_lock_class_keys + i);
+		lockdep_set_class(ctx->bwc_send_queue_locks + i, ctx->bwc_lock_class_keys + i);
 	}
 
 	return 0;
-- 
2.44.0


