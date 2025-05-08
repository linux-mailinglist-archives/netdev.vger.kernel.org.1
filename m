Return-Path: <netdev+bounces-189017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DDAAFDF4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF825016AF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FE2797A3;
	Thu,  8 May 2025 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cYVgZiG3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D602777E8
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716149; cv=fail; b=b3s1wB2Q0J8MPZhweIY1+IT9pEVQCKbv1qFvSRWpIGEOS/x0znvSEy/rmYIfMRm5+fkixcj/pqjCu7EA0ivVi5HDYsk6PPprAnF5WbqY8hq6wU+229C+j7fsB8h51q4p0Rj/O1+BwHHssAV5TlnpQ9V4nRB98PUchY2R4g5QuCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716149; c=relaxed/simple;
	bh=4jv2QP2jcjxxAj7U+zOR3DwgDw32a3lF16tGs7qOsXU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KvTQspqP0LW7V0ITZoTsR1GImdgSa/YQL/P8Pn2bR2Nz78lxuERDdl3CBh08VymzH6uwL7l0kjVxhKh3hw996zzDlnzX80TNhou+cEDDSL+XKNcfXY1TGxi3P84C/+LOCuU5FyCowYxPORr1gNsx0aSoTGmPnhNfWvBsnB7d9LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cYVgZiG3; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rx1VSpxvsfjRemc1XfIzhDrpNOZpJXA+yen7CnKz//z/MoLmtsciJxvi1p6QZlZGZ0NCW1wrUqHBIzOnm4a+zVWa4uTTyi3FK03K8ITID1+oVHOSysRa1c8myCu96QptCMzf7rU3NHjM0hghlD6OGs7XpK7zuiioQMgoKMrME5tahCF5fptIRvEcL3v4aiBdmVzlacHdIESWSNZctyIGB7oc0d0AMLgdfEtx7A8X7aYnDBSZpWEwWRpsvlChEPB0xQ2jcQWXl8wEQuVhj2Jr7k5XEHKiaOseg05gkGq7+BhEzHMgXhR5VEcoCh7im9o8iffm/wfKua6R4n1voDk6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9mgguuRFT0w6IzmRD5U88lA9xbstf02xzwJlLsxhXw=;
 b=Ivj/B9lCXKHKyjIvK1+1+ETkaRoK1cAgGxvr5hHuMZhAxHkxnNHBmWXwY3X2SSXhSYIl+4Epq1ZyEII7lx9zVrC1KGHGaPI465Wgw//6t3qaCWaGxg5jB8zATG0rNChtK0FGjFZWvG8hrIMMSFvfVVi1XAxiOitfwY1Mwc/Bdb0ltd8SdMHPUbmklh4L4g+7jOhUBrHS0ZuSLCKMQxuRYb4WKXBXaF4nuz1k7N1UYojtiKIXWI98KGgElrKE9ecdLYLsdiNgKd4nWCCQ4CMBexU9gP5Zl+KJZxmHL+JNykTTytezV+KzYjbkUfmcyD6zbZjBItImtE5HwysEkiDuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9mgguuRFT0w6IzmRD5U88lA9xbstf02xzwJlLsxhXw=;
 b=cYVgZiG347/mMJm7DWm/ejWicU0jm9lIRcVvspVNiQ+7JVPjISUBw6RFPVJF7/8eiRnsg9AZsxyI8vOWQgG7LL7TWKzeJku+78LRdNF8CU9Sit2XPgJjU8NvCiR3kZTmLho8Ww+qdijiD950tW2FZNBbx+ND/6Tvf8sBSwnJsrpBTqZTccRbG6+EqZ6S1ShK78o+jR95g/T2pj9jB0jem/eFD0/EmhtfWA/yx6E9wfPnGxpU24BdxINaXkIJ4JMNnYXnSL1q2go7MK8c2LLni0VpNx9vG7pQOvWCO5KsMm1oBfRHgRSMYOhh5LF+nzzFDfFfnJ+p4/x1dQFSJT3v3w==
Received: from SN7PR04CA0061.namprd04.prod.outlook.com (2603:10b6:806:121::6)
 by DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.32; Thu, 8 May
 2025 14:55:38 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:121:cafe::1f) by SN7PR04CA0061.outlook.office365.com
 (2603:10b6:806:121::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Thu,
 8 May 2025 14:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 14:55:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 07:55:27 -0700
Received: from c-237-113-240-247.mtl.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 07:55:24 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>, <cratiu@nvidia.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net v2] net: Lock lower level devices when updating features
Date: Thu, 8 May 2025 17:54:59 +0300
Message-ID: <20250508145459.1998067-1-cratiu@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: c20e6ead-9757-4f40-9da5-08dd8e406542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1sodKewZyOWc3nb9ml1QYgmvYAIJxPuC6ZW+cXwC4O6qvv6NOg6KK6OZ8fsC?=
 =?us-ascii?Q?jFRz5N/TVyAEXVPIYt5DWYNxhZvj1WZ8/maPC72FWvk576PbROjZtiD9tt3I?=
 =?us-ascii?Q?Fc2+u05lwJAh/OM1Au2hu9n7Us/690xRKvO937ZBr8mOfK/MNbmtnNH6kVAX?=
 =?us-ascii?Q?kl1gqtu6S4uJuVuIXS/96JFL1SSmVhmFY9niuG6k3su5IVy8W8T37HQYDQyA?=
 =?us-ascii?Q?Uref41Oz5CXYFyZzatKsUCPb7Fmj1pkdEuFg3IZKRvaPWkAkwTHgEBgtZ6SH?=
 =?us-ascii?Q?DoIIp/ymH4AdNn+c03S8FEpkiDlpbePnT8N+TzlqBI20IOD0k/XG4ujikkLv?=
 =?us-ascii?Q?zRtoatuOwUOOjcWqcAhgBY3jecj7zgx5H7jRlTOvRMkEb5TQNrPBoUZv9RYX?=
 =?us-ascii?Q?3318XhcVfWMG5dmKp3tyX8tsl3bj4p87zl8qQo9gHqubZzmFRDzRqahgpeZ1?=
 =?us-ascii?Q?4TwbIvh1lBvpTmDotpbUsQYdIy+QJHLeLSmA2o9qEJ4XqO2fFZg6xS/TtwcB?=
 =?us-ascii?Q?DLB1S/mxIIN270JcwMpBETdg+NYxNlI3VV7OJJrRQq422lUaqqW0K9BeLk9K?=
 =?us-ascii?Q?f75WNa/ThngF/Yzycl02Fl+4a2vvsxP20O5o3EJ4f4EJ3eIiKXobUfVo/r4S?=
 =?us-ascii?Q?OYFt4JD9wgItPSojaJti/QBA48dyPi3O0kvo6P5nZpXTsQNlF1RGAi7qJdkA?=
 =?us-ascii?Q?x8ruqFzUEsqrAEP2DBsEPEqlL8Q6jJzDlSnIHR+6mXa5ghJudKrcy82Ifr3t?=
 =?us-ascii?Q?lmBtJysOGWVw15flxcGmtFjE0tFCN8ifob7JaJWMSpfAPCT9dAMLljoL5nV5?=
 =?us-ascii?Q?VYhVZUf7elerOIC+KNWlL0Oya3nCXqgDYQsRY/mnY4GQ7h/ljZ607/xH2Yoq?=
 =?us-ascii?Q?b24DncyNk2Gk5nF2r3yT9EXvUwkp9i49nLXtS7KQghqJ9pM8vXYbm6FqWmLM?=
 =?us-ascii?Q?MHOtxdideUyNjEG6Arnm/MYcmi+LGuNikurpuU0qme+BNncUO8mqqQ86M7XS?=
 =?us-ascii?Q?E/vQpThk6Pl+blnBiAIz0QeZc/H5Wcaw4IrHnan2sp8Fpx79/siqE8GW4E8i?=
 =?us-ascii?Q?zoiqWcT23O/hgppewTMD9hO6SNTCHQq8nwhKjLEbhyigeKJcm/KlN6uwTuRU?=
 =?us-ascii?Q?HwYdkDJKvv1YrmVK+CWw7SoVxCUsj4Ju3JyMFL5rjj68zJYnKI38UoudMUUu?=
 =?us-ascii?Q?gkh875+aLfaRmbFVE9yAvHoInjKOBHsTwza9p2AUN8zxY6OrZEGP1YSgMydJ?=
 =?us-ascii?Q?q80gN5v7Ss/3FuXWwTejIpYu9a7H/94iPR8icuOdqN3pbfFI5LHDerpiRTzB?=
 =?us-ascii?Q?FwObLE74wR9W+4XQe24cWHqw7HIM8PxY8jMspI5nE8vFB+VlqQ3gAspLGLX/?=
 =?us-ascii?Q?HyPd8psFdVWcJfNj+/3aJa9mtypaInv9l33tysPqhIGS6yiuVBMza0D61eAH?=
 =?us-ascii?Q?kT2FVjHvVpCF7w+IUu3fzAWnOkq8wPWUg2Cp9oQSEyBfsVnZ8pRsSLEsG6wG?=
 =?us-ascii?Q?RsZh4v0pfQhd2RgvgCFxjBexifM12/Ur4V2J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:55:38.2871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c20e6ead-9757-4f40-9da5-08dd8e406542
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935

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
index 1be7cb73a602..4b5df59d6246 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10454,7 +10454,9 @@ static void netdev_sync_lower_features(struct net_device *upper,
 			netdev_dbg(upper, "Disabling feature %pNF on lower dev %s.\n",
 				   &feature, lower->name);
 			lower->wanted_features &= ~feature;
+			netdev_lock_ops(lower);
 			__netdev_update_features(lower);
+			netdev_unlock_ops(lower);
 
 			if (unlikely(lower->features & feature))
 				netdev_WARN(upper, "failed to disable %pNF on %s!\n",
-- 
2.45.0


