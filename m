Return-Path: <netdev+bounces-155729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F291DA037B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BB818819F1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3BE1DFDA2;
	Tue,  7 Jan 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gZcdnys4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4D2AEE3
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230164; cv=fail; b=SfxZZfxpG+TPaLWfy/yQEUIUZFRxQU5BINU5sMFC/MGX4Dki2zce7cyQkHESfqD7Kl52fGULA8P4Tom9bghfyT3MQUx4d9OPeRleH0dh7mccmzn7E5w5i8gsfCYDfZyf8IJ+Hd3xu61im8d/rHX3k2e0O9xo3lEcS1GtS7cpzw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230164; c=relaxed/simple;
	bh=N7KUtXev/x6/J7sqHc4e12PwfgXAoMsWryjgVBfoLTA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkZlb+MKWi3mXyYJN0fggV8+AI2S1B9QGzh9OuB53eJdOhb1kHIh5/5UyZL8gmhaAC2MroO9KLtqaZSrRpmFIjij/aT4pQoFLEjcdPleEbrIjk9RLFedCukLkOEbMoP1S6k2UhlFChhZCYEXXag8FyO3+7lixRBjnNL7XENfZXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gZcdnys4; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWlvlmFa0DmjyM87kbN481AUzUiD94SvDTY0Yz0TZQ9j+oyKsr+rPFUEU3wP4Zd/0o0bUoOe6rPzq80IbbCt1E8yDPnbrWPKm0iheNezaU971/6fxq9vx9/yG33HF1VnzxAtMYleFCw+r+jH9SuANnP2G9wfJ7LM+zwxaINOWCIHYxGM4+FTxD0F0de2MIO4lHcUd7FQE6wjmx7VqnYmzQorQGCDp73x6MtoYiL7DK7zsjBmhJYl9ewMs95EPWUIfSnb+wEwqYrW3ggJeFdYGl1RX3EqAXZYNKRuUFzMvBEIUKOKu9WrK0VzsgDmMZWOKXuzLnAhVToQMjrIigPjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cZPRFet7guXqZe//JwwS0Dyx+SJZSzAnT7VnBWeh/M=;
 b=lX/VYLF8uJoN8gOWTn7gAHhGEKLRLUcW7E33+AwDbGaMSx+9rLOpBsfSb3LOv/N6+vYUiQr7m9vBVmbL9PPFKiWMbiRk9bJwQo09kc5Gm00D0azqWfsKCy4gDayc1brasVRYShiTByPvpz2dza2JNxpLXi4LIrui8XflsSJI3x+ebtB8TODiFy0Xf2G0axKUi+7AbolRzJ6CxGy9KAiveH5+9B0B8/e72ULmjBh6iViudwYeRtNfUbYJJAiJtkkruu0lxf4A8KVItCIbS6klMKa4kycc4G6M5O3bhpb0DXHeLhrUP39qvJJlDggPwx2JTnyExbeFE5AWcBmY9s55wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cZPRFet7guXqZe//JwwS0Dyx+SJZSzAnT7VnBWeh/M=;
 b=gZcdnys4FL5ZKAozSFNalohkT14xb+qpYfmT5OnvW4JNfVq8jOhHIVrleZYiqJd6dOOtwK2Tf8q0gdY7IxqSBfMOLAGD3UtJYXYeJeAbjWC008K8OzT52Qv9O+RsK0HrlY7ZKvvWQ0RB1SQ/QP0RHaAYpUNZ3EPE05EjOxJ3qS+wF/di735w82a2NjnFMcIhCJV4VWKppCROj384J5/nIDex7bxYeEICG8hQHSUyy+fXSlbjO60FZ8M5/fFoeDQ4lwep0jMbqOkhmEn13/TahXNmFBdEIzbWVG+iBRyDQRjjAAlJUlmiFuauk51rvZJrjT+VtnDmVVKZoUFlsBwP4Q==
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:09:15 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::cf) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:09:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:09:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/13] net/mlx5: fs, set create match definer to not supported by HWS
Date: Tue, 7 Jan 2025 08:07:06 +0200
Message-ID: <20250107060708.1610882-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: aa8f6a1a-2285-4dd6-e423-08dd2ee1d012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Amb/QZ63jak/twaFW9s0a7ohKd3ZpWSpJEt99UsuUH20N5zJiR0XuoIaiUMu?=
 =?us-ascii?Q?AV5+ZDP4lSIFuxmJvIBGeU7PxewyRIXmHLw2E0ux+Feoog1DfKVdFUVkB20+?=
 =?us-ascii?Q?SyQD1rjQjTZGgQ834F8DgxSRkZUiCya4u3o1FHRpDzYFpPhRXCyr9aN7Tw9p?=
 =?us-ascii?Q?+ivzPEQ0wuwj/94iPIdS4Mt8+V1bpWsdRycVoFLxCHTdpPLQZt5J0a7vflwd?=
 =?us-ascii?Q?fLg0OyB+pd/k4xMlwAJwO0ZutD3WV7A7MoIQGnll+FFbFmDUlehAbc9qGWgR?=
 =?us-ascii?Q?v5FMrKKbDktqWHc6XP9jHDQzpnTUpuwV47uxMXmkYXnX3LgL5+IqNYgtmtg6?=
 =?us-ascii?Q?qLngNMblY7XLBWokKJhp6uKV+rTuRf9Irm5IlX3phBmvP5xLScNu2MWKmwMS?=
 =?us-ascii?Q?VS4a0SCNTHSFYMrmHmztfJo5sHFD8WV/81mz35GpJHbD6ZyweXBzl+eFX8zI?=
 =?us-ascii?Q?ZEFoMG5StCrz6oGaTyXRh9ysmMEP3z2fmWZiwn5O+lK3wIb/t9Blu+wym4No?=
 =?us-ascii?Q?EXdHhJf8eKMXBnc8e6ht4aFgmXbiTT+EhY4ilNtppDwHrUC0aBN+EWa8mE73?=
 =?us-ascii?Q?ZBudcQjPxLn/9MqNvI4PRj8SjJJZ4b2DMEUdgtlMN1C/u7wYgmsXdYi8qUO5?=
 =?us-ascii?Q?A2IBaLM0I9Qw/rlqjwm2aGsaiimERkU/aiOZmim7v9t4uhTHWWRfCgqv4fGV?=
 =?us-ascii?Q?/y1mYbJLb+I2w8meFGYfx1ULwstjfL163XodFFrGpLnSXBrI00aEYz0e7uOu?=
 =?us-ascii?Q?32jO+kEI34qY1GDPDWzEtW1mzhuL6TKbUQXFxGmHYC/Lb7YO+wl2N8zIM/rO?=
 =?us-ascii?Q?1AaBzvMSjax7rD23RVZsSaNedHbMWIWg1Jn6loJ+ovCeZeE/cj1QALDBCNvQ?=
 =?us-ascii?Q?5K1er2anzZpl1I7NSOd1HgmbxNNAG1jt3woXWnz7k5MZ68r4151uGwYhz1su?=
 =?us-ascii?Q?9FINxT7V2rXPRCh3+GK6pE8j7zVi5ozdd4uPvTb43ov2jXGxW4Any3CA/KES?=
 =?us-ascii?Q?mq7m/SdENIw9hVEPml4ag9zaG7CphM3PuA6R5UfOsI1Btsz2O4kwL+qOIVxI?=
 =?us-ascii?Q?Bh2bDNjfahIOimuqMr0UmMc7KUrG1sFfEcqNSrds+F2B6GCL1z8Ii+BAlBoA?=
 =?us-ascii?Q?DI0AsqdKYUUlwJ/urHAmuswFosuWm0JICPnx8foEXRD8iKm3jZ7egNyc/j9M?=
 =?us-ascii?Q?WICHwcb/KtGEMtQ5a8vCYcv2EKgbB8uo7Wjrb0b42Jj92P/nWhaDYZZjefyv?=
 =?us-ascii?Q?Q+W/0PZTbQB9v2Q2YuZmTpoUa+FkWEOxEauOjP8ygquybF1NtWfOJNr+/LBD?=
 =?us-ascii?Q?FJKnmj4ApCDYu5qdCulDTgq0bC6kV4zU7TI22dIN6ecpMMWgBZ82qT3WlWh/?=
 =?us-ascii?Q?tiw/wtUGFKZYGWk7Mes+PxJnnJdW9R6gmGBIPHPXQBa4AbxhchllGFBFJVuM?=
 =?us-ascii?Q?mIKDlusDWnRP8RTzr0bRnwj1d2CxnPeuefD07uBVugTMrq6GVYWlADXqgskq?=
 =?us-ascii?Q?GHzQxQcZVcPgU9g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:14.8177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8f6a1a-2285-4dd6-e423-08dd2ee1d012
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630

From: Moshe Shemesh <moshe@nvidia.com>

Currently HW Steering does not support the API functions of create and
destroy match definer. Return not supported error in case requested.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 337cc3cc6ff6..d5924e22952d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1307,6 +1307,18 @@ static void mlx5_cmd_hws_modify_header_dealloc(struct mlx5_flow_root_namespace *
 	modify_hdr->fs_hws_action.mh_data = NULL;
 }
 
+static int mlx5_cmd_hws_create_match_definer(struct mlx5_flow_root_namespace *ns,
+					     u16 format_id, u32 *match_mask)
+{
+	return -EOPNOTSUPP;
+}
+
+static int mlx5_cmd_hws_destroy_match_definer(struct mlx5_flow_root_namespace *ns,
+					      int definer_id)
+{
+	return -EOPNOTSUPP;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -1321,6 +1333,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_hws_modify_header_alloc,
 	.modify_header_dealloc = mlx5_cmd_hws_modify_header_dealloc,
+	.create_match_definer = mlx5_cmd_hws_create_match_definer,
+	.destroy_match_definer = mlx5_cmd_hws_destroy_match_definer,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
-- 
2.45.0


