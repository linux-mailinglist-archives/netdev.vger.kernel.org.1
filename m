Return-Path: <netdev+bounces-189155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F8FAB0BB2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49F21C05796
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFE126FA53;
	Fri,  9 May 2025 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SUjpZ0Go"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082B26C39F
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775769; cv=fail; b=QgxMwGbUe6b0R9Mk3YmtG7XuW5nbbKFxAlFkM4FGWkbbFnHxAJLb0Uw1ncjkRn06B2/BTcIlhTQj4B/uecTuUypCfGsm0N2H1TanuwKnW0Z6i39YTqQB7plC12norfP4PxdW99B3S7OykEn3bnOECLGCzTo4dFxZyX1h3zltcGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775769; c=relaxed/simple;
	bh=cIaCP5ouRi/BPA3l7hLq08VodnGbX0Aa55Cq0aY97Xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mIB+DIM55T9DPVLoEUuCKkhqOlUHt4Csic+j+a810VwtTTp94OknoSOBd88/fuCC9lLc5GP0alz9o+vh9gOOkZsUimgLtfO8xs3yGDgE5xwb2tpt31GJf9KNcNYg4HIkI1fCQ32cxaMKRvNm3g+1t8xefS+OocN+LkyD1S0Wc7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SUjpZ0Go; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYD9hbmDM+VhM1pEC+Jy4gEP/MKV1SKjUQleeGrJIPvmFrwVHk6+PeYPRtz1savrSaglYjDM/UWZtS2VTgDt2Et2lkFzOpNF5BAaddaachrBHr3Dof2ylqC4adgLq4/GwjC7CCDclNxLRSEpU1QKzSlWZBt/1u54+00JgLYFze8sPWp95CzDuV5JWY0FNoPfVX6H63/AsRmWyPpi7tma54D7mvhoMrJlmuWQ7kBxlXNWWR8UZDCRSAS9LXNVYfp3mWBnXIKv0NcmmKEQ2pj+BKtuatkvEltOTozfPtvaAPIrcQKOfHH2ICD7Rg6ScPkPg61VKxYp5pLSYMNrSDIo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAdh9LzlaXIumN82feniatToyBjxhK9uwCKkzIreiv4=;
 b=iiJ2MGlTziuAeE97Ue3nl3cxJ8yJfTeHfYZSXS9XbnbrDnW0M8R6fn6FIoIZ+WeKm5ZBT5iPRQJm8+9aGxI+q36NrVPFlqMRqlc+Rk9BCGER8HdN9eG9A7P06xYdwoquRgQjm+eQ4djMEuEsW7daIwte8jlDE5dit9dfb1L0p0h/LDUHjdQWnxFmfdYTtWSyJpjL6/jA4RuLEgVivS1QgG3imFawHP8aczWs7BrYiEjng9QjRS+XsaoFrkoOHp7o4ahkv78RelVwWN2Gd0ijybOW7FtMX52kSQbpfS0s/aUQImudB5Y8PqSY7rk8NT0RlPkmL8K7yHnRmhv7ZLK25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAdh9LzlaXIumN82feniatToyBjxhK9uwCKkzIreiv4=;
 b=SUjpZ0Go+I1EmBaFc4InSQ4jgGfk+O//hGJjjUgIY3IIw2Mv574Wqd3qz9xZJrmn6hF/vpqV5WO+o7HiedkEEGR/F1+PSRGIGPcodgpjAJohm6DYjMiiaMpEpa8WfKtfA4tASnH4+mfEv9VWVHVIEmo0MIM6OCT54ro3blSXcbNX7VDFfXu5mY319b4RpCt+nWpnBiGcLbvYst3kkC8sE2cPB2DykYYFtogBU4ra8RjpDbCX9OVz8Ajv/QQlzzdIqwXl4SICANJR1fZJybHiuHuISSUCVlX+2SQN/1SIu/GJ2PBF9h7DmeW04sd2OvQrn/6kQfu4vWjGEIM7cmqlng==
Received: from MW4PR04CA0042.namprd04.prod.outlook.com (2603:10b6:303:6a::17)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 07:29:18 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::4e) by MW4PR04CA0042.outlook.office365.com
 (2603:10b6:303:6a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Fri,
 9 May 2025 07:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 07:29:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 May 2025
 00:29:05 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 00:29:01 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net v3] net: Lock lower level devices when updating features
Date: Fri, 9 May 2025 10:28:50 +0300
Message-ID: <20250509072850.2002821-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e7ca4b-b56f-47cc-376e-08dd8ecb355d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+I2ZsLhGEUZEDuZin4gLc+ihB1aG9uN0L6iQeVZB0C71QWBp7lgiz1NyZiv5?=
 =?us-ascii?Q?GX+CW16lHC+1CdO9pe+wUb+NJTDNTVQ9m0OiK582Q2rxdqth+X5XLP3N7Kyh?=
 =?us-ascii?Q?cnN+QTurBd2ACU6q/sl/uQK7Mw51VdqSwtu2Ld3L2F0bIWwNxTvUW3Mbl3EJ?=
 =?us-ascii?Q?3BN6S9kIaoaooFXvMICr9e7/Q4t4taVEHnWj7OUyQBopdWE728Wi+EQVYE1F?=
 =?us-ascii?Q?UR0CIXFItdt1xN2l2ESwwd6QqThAX8DNt2COCFC1wDwCoCMgQ15B4lvn8MhX?=
 =?us-ascii?Q?6Jm8T74tUH/qop/jt9VhI6a9o05IbtJsi0bW5L1xoj/g9QCKS2/FadM5lCCi?=
 =?us-ascii?Q?EFLDQggUY0sYL+h0to+PjQxXrKravCLau2F3iNqQCzLprMHdA1eHTypUS8M/?=
 =?us-ascii?Q?hEBL9RRLAnA0W6v3KUa61tjPTWiJ4oTdcxbpo9YKb+6itqoQdco4gDscQ/Zu?=
 =?us-ascii?Q?QOj/z6fGdcJvH/iMBH9lPLdOoKBYWL37k5aJNluUEkV+AYuV0v7ksYTeJZaK?=
 =?us-ascii?Q?zMy4YKJLFgN/hmZ8Ge0szJ2jjv8BZDZjyCXsj9aaTlBtluJdTAaUIwvRDLDj?=
 =?us-ascii?Q?xsqo+gzYyBe+cMVzRs5iWkk6fJE7HluSIAkEvB3ckQzI0+w4vFcaEcbUdDXg?=
 =?us-ascii?Q?BD9qu7C9MJT1hx1SaDpTwUuMRv2lf0PVn+lGf9xfFC+SGQjWo7ZG92qkkmdk?=
 =?us-ascii?Q?GzK8q9Kdatgte/oJOnZonp6J4X44SaqeZst8qK2vKvV80RhC1SgkzVKuACt7?=
 =?us-ascii?Q?OZrqaVVd4hUbPXDM34DYqnzGLGp/5AQZY2mvjPnKBywkn/B7h1RUdi5sGgsI?=
 =?us-ascii?Q?GalmeA41u56zbAjEHxprqPwwknlENYNqUzOXmw0d3BnYGy2qZzt2h4Ye8iLc?=
 =?us-ascii?Q?4cOUiwayW8TYPCt23VgobJuzUS2V82k7kEmMzfS3OO0ozl0KJOaHpB4yxkC0?=
 =?us-ascii?Q?TJUhbA3dV/GH054EVCBIDcmmehTwxDGAPw0CV6eNDCIeihKE/zSFV25QpE4+?=
 =?us-ascii?Q?jR1HOeR9SBVwn115oyNbc/V6yCrLBmdJjh2RldKOiTohmshedbuekbiHMeqs?=
 =?us-ascii?Q?dlN3xnhHx9M2nVVgf8j1F5+B1A7T8K9Ry9FYuGvCZuPoiNwgm5Z+UDyB21dO?=
 =?us-ascii?Q?EWVf7qTQfGzFNKH/yrN3eQJCasV4yTr1ZtLg0mRPmnMHECU2LlSEesExs70K?=
 =?us-ascii?Q?uRxV7rG3FWpxifxBF+1JOSAE5Kn5xApUoEmU9E4YIneImf1CuF6nh0omswNA?=
 =?us-ascii?Q?78jKcOS1inssK9hQyTNoUi4wY+uPkVq8e/hLSamt+n0kDFO/WX7pn9/4ghtE?=
 =?us-ascii?Q?B2RVge0JFc1YC3B/Rf/OaKaml3x4RAGoEb3lwQ2ScAulX0LOrlCK2VZJDiKS?=
 =?us-ascii?Q?IyO0dNf2M17iWfhkhk5akXkDKcJRl97tmGUsYepoo6HhtznNkgMwTQJ1Hbpg?=
 =?us-ascii?Q?gqi4i/aTnJ+O9aXnhQSEWhGZ32NVKNIrV8GE3fHywDZ876rFRfuhayjEEGaH?=
 =?us-ascii?Q?1jq21zZaM1INWA84YQ9Kestu45PYI2HDER/+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 07:29:18.0873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e7ca4b-b56f-47cc-376e-08dd8ecb355d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485

__netdev_update_features() expects the netdevice to be ops-locked, but
it gets called recursively on the lower level netdevices to sync their
features, and nothing locks those.

This commit fixes that, with the assumption that it shouldn't be possible
for both higher-level and lover-level netdevices to require the instance
lock, because that would lead to lock dependency warnings.

Without this, playing with higher level (e.g. vxlan) netdevices on top
of netdevices with instance locking enabled can run into issues:

WARNING: CPU: 59 PID: 206496 at ./include/net/netdev_lock.h:17 netif_napi_add_weight_locked+0x753/0xa60
[...]
Call Trace:
 <TASK>
 mlx5e_open_channel+0xc09/0x3740 [mlx5_core]
 mlx5e_open_channels+0x1f0/0x770 [mlx5_core]
 mlx5e_safe_switch_params+0x1b5/0x2e0 [mlx5_core]
 set_feature_lro+0x1c2/0x330 [mlx5_core]
 mlx5e_handle_feature+0xc8/0x140 [mlx5_core]
 mlx5e_set_features+0x233/0x2e0 [mlx5_core]
 __netdev_update_features+0x5be/0x1670
 __netdev_update_features+0x71f/0x1670
 dev_ethtool+0x21c5/0x4aa0
 dev_ioctl+0x438/0xae0
 sock_ioctl+0x2ba/0x690
 __x64_sys_ioctl+0xa78/0x1700
 do_syscall_64+0x6d/0x140
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a602..521ce3936801 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10453,6 +10453,7 @@ static void netdev_sync_lower_features(struct net_device *upper,
 		if (!(features & feature) && (lower->features & feature)) {
 			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
 				   &feature, lower->name);
+			netdev_lock_ops(lower);
 			lower->wanted_features &= ~feature;
 			__netdev_update_features(lower);
 
@@ -10461,6 +10462,7 @@ static void netdev_sync_lower_features(struct net_device *upper,
 					    &feature, lower->name);
 			else
 				netdev_features_change(lower);
+			netdev_unlock_ops(lower);
 		}
 	}
 }
-- 
2.45.0


