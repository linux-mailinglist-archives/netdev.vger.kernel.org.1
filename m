Return-Path: <netdev+bounces-109769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1B929DE9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4B828323C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9BC3A1DC;
	Mon,  8 Jul 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BnJ+meDw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD9F34CD8
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425753; cv=fail; b=NyF0fNl0mxJeNq7lqD3SBrtVz2Ite78p2YoiE377kuQ2Cs7SelVpo0vf+AwDgZSAfut0S4U9pZaFAM20t1etZP694EY/qmkh+9BRVVdvCXNbGktXTYJDQpji7Uyl4w2Z3Wm654SzxkP7iayxaxpHD5My8dd/JdWXHPcmHOKS2E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425753; c=relaxed/simple;
	bh=NKU+ozA/j3V2qsOhMj13F1QAPvRE3Mpw29u1+5IAfp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl8KvVR05bj55016stRpGc29g4NTaWxfU8osbyaUKIi9lQY0qI5bFyreFSU+AiHlKIasl25sGfNZ7wT/RzW8mZw1OKbuN5KB3FTuWftMRexjHDZPNfJaeom0P7EdnX6CMLIXZmfB82QuKk7cToNj67Ohfl4EHengWXvzJ2DOxUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BnJ+meDw; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2cPMYNbPlFF0lkDFEkmAwBqvZRHpRAITclRQhewLj25IxivOg6QQSb9jFf2Dd+jCZh6Hg8kHlUUGb2Gyv/eLW9ZwO2C2cuk+Gr1EyOPkKLC+n82qqQGiSI/OfPmItrVEkG9VHSotnfHbGvQp9dYci7T01U2FSBS54zjfyw603MFPupn0Svu45JdMHW0p44/cZ+vClpAw+ZLYLqkNvu1A2XwWhmdUmadPuzGOsj9QdMKQzDDiODl7AM1j3I8c9LX/zEgQx++RZ/tBQ1At15Sa0vbTLM5C5NxCmzq8ogGqHRmFoZsh54YwHqVZ+1P/LL2SBwHt3QNBSBIXl1vo3aaIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDKjQgsgGUgtLC5rq26bxue9O9tIgvgEIScJ+yDV7T4=;
 b=htt3nxCfEMLBnX1//Uy1xV7nKrCvQ8VHIn4pv1dBlCEAdIPLuDaJwMnIUHuWastBrX3eE8sJ4rlLVGDt/kv+qpviSgKAtMEOIMUQo/zBColngdT/5UYryn7GQ5Vp4TM7gdyVq6TUlGZ74eEM1qRl1h2Lg7LF0UZWGwkybEjpqlXR6EA1Sbfix1/CduRkkUB0zgJUifOouiLoZaEXsGDV+cz3cltoAU3wVNA7Hayi7Z5JtAaK55q2KHgQCX+UzQKqgnbWOoUKElIve0wim0k4ucyMG/dkXPOZU2NDC+6XtP/B1Cn2f3zqmAR8RE6k74a2tGaTcmUUFdM3x8fmO0A7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDKjQgsgGUgtLC5rq26bxue9O9tIgvgEIScJ+yDV7T4=;
 b=BnJ+meDwxoNBoh90xWlkp1UU/GSMnSSZWP9QVV5fvz85O8Bcb1eRuzUjEv7SZOvvK8Ypytajc//6uwgvDO16oiDJb1lpXcvQzIvwQQIHfm1zfsklAax0SGIpz5NPqurQgf5h6ZJxKCo/Qvu1w/aagOPf97wJBfhvjIVtZ2GsMdgnVi9XJYp2/cAjSrDXnGHNgAwRJtBMdYiM0tk+NV2aCRqOQKzNIivkV10FawWqh3OOCXTqjbU3sdw+Zl2+usU3Pzt7manbb7cXhZkd04A6HFv5dSFxMCCjVHveY2pifIB4eOVkOqdsfItqgoMl4aVVIjh79T+q5V+JPTRSYK1u1A==
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by MW4PR12MB6952.namprd12.prod.outlook.com (2603:10b6:303:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:02:28 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::37) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:02:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:02:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:02:02 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/10] net/mlx5e: CT: Initialize err to 0 to avoid warning
Date: Mon, 8 Jul 2024 11:00:25 +0300
Message-ID: <20240708080025.1593555-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MW4PR12MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b7434d-7503-41ff-9dae-08dc9f244c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXqxCKVcEpZhN3WaPLa3nk9K0f04QYh0aKjZMnBzP9EMQtljhXY9lP4ET34f?=
 =?us-ascii?Q?1hkDrMwApyudf34C2z0FsXiT8i/lo5dJdx/4OD/6N/mswCKEoSVIzJNj1QL/?=
 =?us-ascii?Q?QDaOXZ5XTjl4DyrvuHNbc/jEofjo05ldxoMVR6WgnAdbtebgFhPAgGCsAIK4?=
 =?us-ascii?Q?a5zXXiltTq4+gocNIzFTaBXmn0w3wSro9R6AOLITqP23cdTFQBGjCYwmtHGI?=
 =?us-ascii?Q?1iH47ShQ0BOjxWMSyTWQ0YFk6cU+3X6Ns/6VlEF3MKkabWOSAC6mbH6nI80b?=
 =?us-ascii?Q?IQhnbBYkENcbVc4/D7wka/CvXblfzmKDXv26azGGYbH56gzsCiD03Y1Aa0T5?=
 =?us-ascii?Q?LIg2S+RVI6pgRncp6iQUfgucr2i1lXL88onc52By3Tb+uLJHKcuW9k1URUZC?=
 =?us-ascii?Q?2RUeDYc1Zy5SxJawD79r84zjq2SuUNM/9Q3h3jccG7ou1qYAP/w1Wnbb35rC?=
 =?us-ascii?Q?PBeoJx7+Db6ljqCOQAsQV6jtM40pyBRmvOB8/aqX8Y8fl1SV2Wkz2UOq/jyo?=
 =?us-ascii?Q?MRFWas5TUS2dVcJs1QbWA1VQx6Q1G3VMqfvyF+UJCQSsqV3r0+lSkmrA5lQs?=
 =?us-ascii?Q?ji6fUSaXjdlQT21I28RN6nvf0Unt84uR0F4POPzteTphI5+lygs6vFJPzZJg?=
 =?us-ascii?Q?0InuJNwTsooai2iqhP9Q+4F36NA/V/OIaIh+su5mowMYZALDuZvwEiUL3Oi6?=
 =?us-ascii?Q?4BPXxwX9AbjGbVNnOXaZjcSBAohyN98cTGcrXra6DhXZK2PlQqVwBj6juoaF?=
 =?us-ascii?Q?R6YtistK9c6MxC9kki9NtbE/FeP2QYgQ5ot5ij0jto+zQ0jDf/8aARDvm1o3?=
 =?us-ascii?Q?MQMzoD8DdoDfPCOSDgN5mZ7Su5cjJ2upAdNIYRU3kR873uAEkjo5lnZetJkX?=
 =?us-ascii?Q?xGyY162EJ6RntzCYvAnRKdLiJLEW7fea4iVePzBXIgkvrBqMO66wz3FGW5eI?=
 =?us-ascii?Q?zz+g9aCfK7NK5XxJ31Pikc+BZizvNVFMbKmqMqDVfZ5Muzzk9QFSfNBQd7uA?=
 =?us-ascii?Q?8zofCJKQW2S1z2BmoeH1WdUQXR8dzsZnYVBcPGhQJeyWJ25yzuh/0nNDIceN?=
 =?us-ascii?Q?OjwlMuI5sdo4CQG8rLN5EZhppHe/J+t4dHbBuEfgYp44G0yrdcFaoag0GdiE?=
 =?us-ascii?Q?9qTonHMwOGdKsFP3HZqrjE0KPWMdG+Q92TNbxuKDkDq9DvtKJe6BGpguoA2s?=
 =?us-ascii?Q?9fIuJUQLeFGaKIdQ7WB4ft3JfXfvIp6e1tQXVSOWHL8zMJFQwagRaklR+npY?=
 =?us-ascii?Q?ifazDG0QTyIqMYeFyLgJX5jxA2hQYfRy301G5Fqlyv56WDZ00Y+WfEcwu9+F?=
 =?us-ascii?Q?wGFYiZddXtl6B+B/w6Y6g1AYl0bjM28umLD88/V8aLTlOBr2dsTySxp1/PU+?=
 =?us-ascii?Q?ROEHOCqrPReLAhmbsoFLToAMIWX9Njnr07Itj7K6RMBOH/y5cuUIPoMAdbJk?=
 =?us-ascii?Q?Xe0UMXfkd9svYfctnMslDGd3LprMIXYU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:22.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b7434d-7503-41ff-9dae-08dc9f244c36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6952

From: Cosmin Ratiu <cratiu@nvidia.com>

It is theoretically possible to return bogus uninitialized values from
mlx5_tc_ct_entry_replace_rules, even though in practice this will never
be the case as the flow rule will be part of at least the regular ct
table or the ct nat table, if not both.

But to reduce noise, initialize err to 0.

Fixes: 49d37d05f216 ("net/mlx5: CT: Separate CT and CT-NAT tuple entries")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index b49d87a51f21..8cf8ba2622f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1145,7 +1145,7 @@ mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
 			       struct mlx5_ct_entry *entry,
 			       u8 zone_restore_id)
 {
-	int err;
+	int err = 0;
 
 	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
 		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
-- 
2.44.0


