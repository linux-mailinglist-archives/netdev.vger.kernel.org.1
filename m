Return-Path: <netdev+bounces-101557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529168FF5FC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 22:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4571C22D2C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 20:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA919939C;
	Thu,  6 Jun 2024 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ecgeNsbR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732419938A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706058; cv=fail; b=R9nTa7C1Gjs6ysFL+t5UTdTTgfA2jFiwooF4IbyTDoXjhjQ+W9WUc3Y06NPLuc3I9XW+aHZJqvKM88cBylfqnQbVHegSJftz+4R/xGAjxq9qiy6dMLdpoBFfOeOV57kRkLH9YmOU8CsV7IDdn3n/ysBbk6jBHlJ1zxEHPsk9cCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706058; c=relaxed/simple;
	bh=my02okGW6gWOo2ceGMrOYEtoGzJ/bOm/+sIp56TJHlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNpDYXCeOBHebfdG7UA89lGFUAYxdCiiWCuEhA13nHjnjQqpHtced4Zl23aljzs+tyOno6HXge1N+1BycQ7l5et+X0QJLR48gSEPD1vRs691RdIluOlM5RyFfqV8/4iJum++1x9qeCUk6SpLV3tdzj6q5TXrja+iFj8aPjYxotI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ecgeNsbR; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEDNJPwj2MrSTwEQalTuQ3ySgnjUGgh19awQiYx3iJsRZMRtKYNyS+q3Nve91aEVTWswZbCkoOXAwBIJBXKYCmZtwAwsPXQaWbAMHiF6FD7sgTTtYUmn1adN6s2tY119mAFU4d8fotU/3vHih4qmLiYPX/PMvyp5vuPa80RtNlQQ9pBAFavsWSxzUcqHl0GVwfRzhLFrYM4oF1nsWTDy5FUPwYJwbjPQAh+LCWT6aeSvm2VPcFW187RmqsmLOtcqN/iuJTPsM7U7TMpGdms6sk1DRj69bvjlHePyJHu4rXryw7l7snNC9ZmYwgEw3LatgRcZwDp+K8xt+wYssS6Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H07zAfvm684l61m4V6/LhaCgyEM68KDo6QrljTwj81s=;
 b=mrUdWJFHJkAjzO2NdU/Y12j+9CYXkOYH9BbBzzmVa7ycNVWdCbnD640HnKPUbr4ysCV+WBlj3zlHAQj9BCbKZozfeojgb/MxkboPNZRZ6hViyP2IdaG7NPbqUmfOAYCoghWop6JpzuaXG6x78v3enMWgfCIfGsaoSLOFeJmrZkUPQprinytnQcjNhnmWrNBhkExjlCAC0xS08klgvM+mED5xexNnvtkwpOSb1ofgPsMYbcwIQm9UkJvIclwICrpVO5DXn1FtQiYkc7JliEqnGnZb20d9cDRstBqHFz2ohkMP3ortwKm6s184Oy9ITY8HijgBwOR+E3c8xcmD35hwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H07zAfvm684l61m4V6/LhaCgyEM68KDo6QrljTwj81s=;
 b=ecgeNsbRgAoxI4RDpqtGPk76NSnVDSrR8ln1o8oppOEyYJf9YKnPEiJFkcn14/Bpq5iWGegZZiygQOdlMsEqVTrcK5y/fV55x5ET/6+iKVAyEIBT1Pv/5hqyPHQmyMHhVb1B5OHyVcGKjM2phwR8Mk1UWeqyraYRI+i2F9ZIm+IsHAHDGkzwf7PjtPZHyaWSdngRgsjU/KkELoPYjmRSdbmHL1/zr0LLnYHARZcvc7EZ3eq0fyaS91rtBLu1srfvmmQvJDG8Bod6fRXCrZVMbVc04zCfkNhHyivYm6NBOx3IYcNJaRELVmANkdxcXK6DI466M1ZHmUL7vSNyDSHrHw==
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 20:34:11 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:235:cafe::5e) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 20:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:34:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:53 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 13:33:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 6 Jun
 2024 13:33:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/2] geneve fixes
Date: Thu, 6 Jun 2024 23:32:47 +0300
Message-ID: <20240606203249.1054066-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: 7971c8a1-4bed-4532-9876-08dc866805e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|82310400017|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MLqeN4NJYAyReuBFzgjSp9xvnvN67A2UOePWmseryf75Kfc2u2MOqab2uKld?=
 =?us-ascii?Q?HeDbGdUTFEuqoBGdXI2yP/DmFJf8rXhdLv51gKnzCTzDpZOU6txZipmMVDTY?=
 =?us-ascii?Q?l5eLdWFNSxYUyHxjOC950+6ygniY+ZMdBFNKRf0QzoYs2sOfUQyF59W8d/hb?=
 =?us-ascii?Q?cntmXPRr4/2lL2tU0lUEdlFy3UUH4GFtb0xeLIiqt/I5xUuBCP5TQYRorDpM?=
 =?us-ascii?Q?AfaAKgVo/fS6+fiIo+9+JzCqHYcsHVp+MJcHrmkLxkcUNI2yD/NixbcCNz8U?=
 =?us-ascii?Q?rSXumVnPnfQhwWU2T4zX3BVefANNugb9t+p8/hD7WXklgd7ZdgWE1Ei8/yUk?=
 =?us-ascii?Q?Ec7fHMQeZM3UCU+i3dyuXDqd0xS0lWziPKKRU5jZ7yuXvqiIgyhclpvZHXrK?=
 =?us-ascii?Q?TKpJT1RnCFZQ2YpgcdBwEsZPkp0gUPc8mBL0Zw3rt9ylPkPlHhOEc/gpS/L/?=
 =?us-ascii?Q?NdXARTtlnQ7egfwf+MfmOkad9DoWGtxb7plO+3Ktkql18XW9H2RR2jW4q3J+?=
 =?us-ascii?Q?Q/vCvN5R6K2SXYY3t485NrLBJcGyCKeU5IsZXA8TRCu6M/fuePInOiuYT1rh?=
 =?us-ascii?Q?6F1tGjM7qee5TK4s0WvvOBpb+vskaXo9RHyR7CCmDdGy6spOiVH9Q6/f0C6v?=
 =?us-ascii?Q?U9l/zoxwnzQN82xD/89tR++Boe2VEcuVb1RUqHFQ5657uqtqjoyEE+mLAHec?=
 =?us-ascii?Q?eO7S1maX2AE8M4V5lgLWXKyPgY7EC/WrJzm/xzCQ4n36VHjsNe7zhE1773U1?=
 =?us-ascii?Q?VYbj2c64rN7LJbSz626EopJ5mcYfjqT0WlPP+va5EumZeYXpmWXloRVuNAU9?=
 =?us-ascii?Q?/eCLOq/NPpoz9H8Jhd9nPhvZ+MS7ExLePX0BrfYlrdpthijtwC0tx0cuhWGs?=
 =?us-ascii?Q?bp3m8LwijVo61hQjMXvYJhX/zGok8UVjI4d4HCjhsqs7sXKFckQEXZbzaV0C?=
 =?us-ascii?Q?Bs2jLpRujm/62MmgMWCefc6JFEDYSirwNa49cv/CjhbrrEfgcn/DmQUp/795?=
 =?us-ascii?Q?vTWhomoihXmupUUdz8sHgua7MtFm3MeVkoOocUL6Y2a16YQu3eLr4Dx357TO?=
 =?us-ascii?Q?q5ICZVNiwpUUQQDM/a99T+PbcwC78zx7CbIxYSmoClo/lQjPaYpFgsold+Gw?=
 =?us-ascii?Q?JsJgJPtNQylCkangMdHsCfS4nu4P7v8lfp2W6s1jInJNjSezGgRwM9kIAomu?=
 =?us-ascii?Q?kAbaKGJa31Rh6Wm1Vc2luWA3mOFMcMMSVa7wUpiYUxP0lD9NFYsS8+lP8Bn7?=
 =?us-ascii?Q?sorVwnH4Id1QAP9UJISbUUG3SZWChq9dm6boqthBYDPrdtVwy4TRI+PI07Ee?=
 =?us-ascii?Q?1kvrop7ztAtPtHMGHg1PubhwV15RJVRvWMG2/nQooh6v/Nfk4XdL4EL/+QgZ?=
 =?us-ascii?Q?EUcu8Z/uCP0PCVRn8bzlGnPg3oinUhX0NsOPtvQLy/1KJu/bAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:34:11.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7971c8a1-4bed-4532-9876-08dc866805e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

Hi,

This small patchset by Gal provides bug fixes to the geneve tunnels flows.

Patch 1 fixes an incorrect value returned by the inner network header
offset helper.
Patch 2 fixes an issue inside the mlx5e tunneling flow. It 'happened' to
be harmless so far, before applying patch 1.

Series generated against:
commit d30d0e49da71 ("Merge tag 'net-6.10-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Regards,
Tariq

Gal Pressman (2):
  geneve: Fix incorrect inner network header offset when
    innerprotoinherit is set
  net/mlx5e: Fix features validation check for tunneled UDP (non-VXLAN)
    packets

 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  3 +--
 drivers/net/geneve.c                              | 10 ++++++----
 include/net/ip_tunnels.h                          |  5 +++--
 3 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.31.1


