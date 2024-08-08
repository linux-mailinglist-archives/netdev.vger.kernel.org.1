Return-Path: <netdev+bounces-116703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BE794B66D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36777B22115
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561BF185E50;
	Thu,  8 Aug 2024 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mpTctUMN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64B184535
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096888; cv=fail; b=iq1ull1pGsAhnqRK0aJjyw0PwWTnDmqLXi8XDEDgvPuUuci7RJDnTImNE27woBA9bEws+UF/MtNQ3gYpnvv/XIr/O/rvrQwpnnvrUxaNaCtrQ0RM4YSw/YkNaq9FiWU7lYA2Xv29za3Gge5ED2czA8I/Sz4hKmrnySBpuZe+gyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096888; c=relaxed/simple;
	bh=XZPzHc79aEcc8hIOXjBmUvuRL52CB58rCIXLN+I8mCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXV1p013JWagLVE1xOc+IZ3Y5do5OJSlkGGtAR3ylUE3JSy3ndU9VbkWOO1nB4k9RLTr36mFfUskkTdmhiz/FNzg79biQYZoaCLjRSJKh8b8Ue0U1QeKfcXuV/Xz4pheCcIqDjbjX4kirUH0Rkw4UJn9ydlA2fJqHpLZfIw4Y5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mpTctUMN; arc=fail smtp.client-ip=40.107.101.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGUhchT5JnzrdwfQaZ6HYPqybAgwA2LlVxqJetM5nao47lzn/n64VFLWISe3CNxFwCHjSyRkK9C+FFj138f7KiWswDzUJEz+bMa1Actrkq8XR7NeMzS1M+Dr4xG/9HgYiA2dU8dJkyeYde0hxJNvLh/c+8ivx6pu7QGmLSWxzldjLQCuMMPSubkfHtjnvmSi95ylWJuolm+wiuI7RLz1vsPjRH0G54Jn53339hzLdoYzMIbNZtOcZPoY6OaEGAEJ2jxSeOurVGeYGchyjYIEa+mjhuhjHa/+JbNoaLFNDY28dT0EKnTz5kCFMq20MmuQxvLIiefYvt7OPEILhT5ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DifpBBpLegKOciyEyO0MkTLjDbgdi31gvoClxiT5XS8=;
 b=ERnwyq+nzbq9kXni04VzKovYxAqfMFpMkw3JVJ2CiG4qLKjziM3bVPoEBrGr/liGgBvCk9w9a81mIhnc4IFb+PPo/D3l9zaIT6Q1k4wHxagQge6el9Tkh5ae9PcAilcGKCVGYpMQ2/apS3BwHWxprwfwsKVupc8s9VxAB1kbHm6XnrtR1pe7/itM7COqd9RD6fGKXsIzgyjkP2vKQ1N2m2WBn7GZr+JqBL7PNYdiStgmZcl9yMHSVS/uwtzurXyXvU7CjVsS0pgm6jxl4URiDpE1mfz4a7xU23cJQhw1c9dw1gJtVdA6sYq8pBTEHSr0QysxRbMTPKfbp4ceyABUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DifpBBpLegKOciyEyO0MkTLjDbgdi31gvoClxiT5XS8=;
 b=mpTctUMNKmbpyCdi8E4+aFYdyjd0QvZI+7P8X6PMMGxLX/Bu/n6eygeCFEJNMk5XJYuTsNAeSgZzk4DIv1WCzasmwZJZ0BtrtPtLiZXQmVHQMXMNKKNegPAh10TLb5KNOCmCisHHranl+OTJMHVdUZGPQ1xzJxrjLeosxSXI72COFCdyyDTOe0diG2bX57lWZprHQN6B+fgS0U8r9xgBCJdO7DiGcdSPbdC2cQDKVsNccj8Bf9kgmQDFCBbI/WJC+OQEWc1fgtvD0iDOhd4E/Gp4oGgDQJ6l6O1u2YKY/Uvb6/kD0fQ4uFjkJqfEu6rRqskV6oUPK6HJFjV+PGVTBQ==
Received: from BYAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:a02:a8::29)
 by CY8PR12MB7265.namprd12.prod.outlook.com (2603:10b6:930:57::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.30; Thu, 8 Aug
 2024 06:01:23 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::ba) by BYAPR03CA0016.outlook.office365.com
 (2603:10b6:a02:a8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:07 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Roi Dayan <roid@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 01/11] net/mlx5: E-Switch, Increase max int port number for offload
Date: Thu, 8 Aug 2024 08:59:17 +0300
Message-ID: <20240808055927.2059700-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|CY8PR12MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae91e9f-6c67-431f-ea2e-08dcb76f87b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8ozAWkhvOUnrr+gXB91sGh2GJLbV+oOzNdWSVsBjd0X+ZXfkFd8VxhBTwX3Y?=
 =?us-ascii?Q?aQzhp7NNtNWDlJ060e1kOVx7ZKTf/hjD2/w5W281UtiAK768Fn12sVJG+GOz?=
 =?us-ascii?Q?0Ti6fAt8I39pWcIrrFejNaim+G6+vrvxN8wBMaXulNmBeyYh+mIKT1YK/N6R?=
 =?us-ascii?Q?TV5fFbwubGdBnDs6S9UfHBhAPmf7fj8UmZ91f0U5ji0mlaZf8pQmi+vDkKJu?=
 =?us-ascii?Q?jRaO6VXubvSUa6NhJxywXV9Y8QNwq6UmT5VDUe27RFudQXRIfrbKZkxcmRDD?=
 =?us-ascii?Q?31kJGpkR142fJgW+Sy87N0J8kuv0yaCcIl35alZ7FEOuDUa7GWuGpsw9Ohv2?=
 =?us-ascii?Q?ADzNFD7603++laT6BEGRXibSVu5MtelEj6Uzk0ckQ3Abr4nmmhJA/MPXLrS9?=
 =?us-ascii?Q?X0T6nsTsHRFmF5g1ID5A3FtYS3T20e5/JMR7XRXqT7cymQxiiYhttXhwyGQ1?=
 =?us-ascii?Q?1wwLNOzNrukBJTu5ZdWdkI6QP9DCypbSbkeTHx7JbCsCJ2a9WhH2KjC/Pybx?=
 =?us-ascii?Q?fc5Oo+pT8SvfK04F2uvzIxERPK1laQr5aO0UMY14CjRm0NHaKlVcvLge9me7?=
 =?us-ascii?Q?xyyGvgGo6twh0cNFMsgsuUQVXPS5Ictde4jkQVgN9J5qtAkIXVtsRpB4leHQ?=
 =?us-ascii?Q?N4JAJ0vBUQ1IiMm79vZRrVtW/ZoaRN9tM+x27DQnLObOfk4MCTBeoIhJxJhY?=
 =?us-ascii?Q?04lRh8tKb25qlq97L2Lt9FVpVnZA/hZHIeC+Mr3VAB5FPlCv0QhfZZejckfz?=
 =?us-ascii?Q?IrqG7upi+Jgu5e5iDXYcqZ82wNsjgVqVqv82CAiMUTEV5SNRLZ1W5wBaCNJi?=
 =?us-ascii?Q?F/XJ7gOrjr3vM2nRO40R3fdkHvTj7FcMUNOHfAXorRZlF+ksLu7xV5wl/iEB?=
 =?us-ascii?Q?l9ZqTlff4QvXsM6N/Y+Nowpb9tXR+fziEhhK0UsPT8CfYaXaa2rg93RvXZuw?=
 =?us-ascii?Q?fCHp7xelVAWE9tNAG54/mgWc48hmN+0pYKCRe46nQGsen7COO9hCNCjyR0Sr?=
 =?us-ascii?Q?NM7pNOFHc6eGwM04/vYhsnUeSNP+Fvo22+TaBuNvaqhv9k+rYUMLGmCCIiQe?=
 =?us-ascii?Q?aAc/VSqeJ2VgH7OLyDpmRGLAGKvZld8tQ+IZSQaN8WjxV3NrGjFRMcix4+Fi?=
 =?us-ascii?Q?4IPkrq+bn29NGephu8iNLp19J2XlvTZ3QQK4T5HbiW/cpufwG7Uurm1juSHy?=
 =?us-ascii?Q?w5eFBkKzCKOB2txkmT4MSODfenGQKN8Pno/Qa88LhuXpyT9EL4FLJdYL+WZb?=
 =?us-ascii?Q?aYejrcyVZjFjyxYw1eJ9ojf7j55/pE6Rt7VwdDGXWLIoOCt0vJUFsqVZdmBi?=
 =?us-ascii?Q?8okxpMK6Xk0HSygzCCf4xLFvSBk70YbheI3UWLYyqnPBinWsN9d9XSnJ9tDG?=
 =?us-ascii?Q?Lq4bPKnDVHtDq7KdzvDkXSjVwYxZkY/B0t7oM/OHIAB8YGk+be/QLzNKbuYi?=
 =?us-ascii?Q?6ddWhO+rgqY+nzvjr1h6rlxO1skd6KY3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:22.5126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae91e9f-6c67-431f-ea2e-08dcb76f87b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7265

From: Chris Mi <cmi@nvidia.com>

Currently MLX5E_TC_MAX_INT_PORT_NUM is 8. Usually int port has one
ingress and one egress rules. But sometimes, a temporary rule can be
offloaded as well, eg:

recirc_id(0),in_port(br-phy),eth(src=10:70:fd:87:57:c0,dst=33:33:00:00:00:16),
	eth_type(0x86dd),ipv6(frag=no), packets:2, bytes:180, used:0.060s,
	actions:enp8s0f0

If one int port device offloads 3 rules, only 2 devices can offload.
Other devices will hit the limit and fail to offload. Actually it is
insufficient for customers. So increase the number to 32.

Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index c24bda56b2b5..b982e648ea48 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -139,7 +139,7 @@ struct mlx5_rx_tun_attr {
 #define MLX5E_TC_TABLE_CHAIN_TAG_BITS 16
 #define MLX5E_TC_TABLE_CHAIN_TAG_MASK GENMASK(MLX5E_TC_TABLE_CHAIN_TAG_BITS - 1, 0)
 
-#define MLX5E_TC_MAX_INT_PORT_NUM (8)
+#define MLX5E_TC_MAX_INT_PORT_NUM (32)
 
 #if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
 
-- 
2.44.0


