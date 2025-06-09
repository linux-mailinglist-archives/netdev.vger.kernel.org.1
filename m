Return-Path: <netdev+bounces-195784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B6AD2363
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE41916B73D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C2218EBE;
	Mon,  9 Jun 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a1LhGT3y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD220A5F1
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749485284; cv=fail; b=E2/uv/STgAcC2bRNS+89q5ZYrmYh3gG3Nd2Zvav2QEaID9q2ZXS+SzgRYEXoR0sPFZwTE8AMT6lsMtfJznNMAB1jJewgj67HfUBgL4BKBgkfXf7dZGKYpn4nceGOnuOdXAR+3x79Dz6C3MB92vbU3nlbM720Rsj1ghwhesF51WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749485284; c=relaxed/simple;
	bh=2VyBc+4ziGYsHQMBtTAsSzkSp25zh6ML4gfcYt8Bnes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9cveMJCDzzHrgfmiyHmi3gwJHlNgwtDx0yFtiHSeZw6RNRI7/ax2Pyo1RsPrJpt0sPJLnebW5YNNtgcvwAvuN0M3LsCDjAdVlKKZcSS9LOrOEvzdhyTFXidPbINJvquQ9RYoWJAEDYgIgNeanM083iSGKUM8OmhQWKyWkz5oP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a1LhGT3y; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bl5awb7WrpZ1GIIe4QmU/muoLtSybz5UDeFNuXbJ5jx8DG3cm5+oZPmzWczwJAl3eWJuIuJgtECn9ywi0imNJMxie2Ft9U1NYRJh9nRT+yjeojORNJqUTWeqOFcYfmBas1gYxdLFX1x3rivJTyzpdk3fqi+Z2N4hdqR6S4dJunT/kiGQPr7CI4/NwVW/RgQob6K/JbpKQflcLu/v0WIE0RARuWvWyG4biK367gV8KW368X5RCl8yxoUww23MLXq23pDL6KLPQ1/aAyIMcCVb4znyeNU1nBowUT32M9JfmS7ajmy4aJ2dMNPT0+o7LJ+go3BWpZXKb2hc3Es3+moUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es81yXUAbuHVl8HGHiQ9KBMWPmMye5DUAhMddhUFHbM=;
 b=tq8CF/CvskGEGctAbxu4aMAGNvS/soBFjNzyBAePsSPcDoy4UOyFDthI1D6ijK/MN3Y8xiQ9F1BSdB1wk6GDUjT3ncyj6hLp4k6r7OARU06r+3tIXfV8Gq7OlYirDPyDSJLkb4S2W8Lfvm4mY82WaxlTUNbwSYpjPBrlVyIPYrlmrZCrVpdKrbLefZVAGGTeXU9dGikaXelBpYpcwmi1Njwf8yS62iXVgiKJ/7vvkxLNYToRxahWa7eoOsqwawZv3Fxonoq6PuXgr8IAmWhz81vGcmNVFE08gKAq6vab2mxPXzSmT/8tBaihPuBXApHHZh7OGCFjaU2YtwW5PUJLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es81yXUAbuHVl8HGHiQ9KBMWPmMye5DUAhMddhUFHbM=;
 b=a1LhGT3y3eDJotJxksvmIpLLbGC4t1mwR4CABdkMxa9eOJi6JT/UuJ6BVD1N8Jg9Ksnb4O6jw/2/D6ofFRFhAAOPYTv4QltXO0vGMzDFDE0KCM9zIihjjuToIzOZm3PwOEO5ysjvglFo21mWDkJrEyNmBng1C58HK8OQoto7ki5KAW2+7QQsSRiapcV/wFrnjac/1m9wftsTP9CZIGgw0n376PhdBG6iw+EBpoP2qqO4ToBLWPdkrQ4CLUWqJ6mHm3SX5IJyzrW6ZYIbsjYwY1lKQerKXs9ysKFuW6oL9Tce+rN08wtYuj56+rXwkOOxy04DYukaFrdg2fJa7K+Lxg==
Received: from SN7PR04CA0197.namprd04.prod.outlook.com (2603:10b6:806:126::22)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 9 Jun
 2025 16:07:58 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::b7) by SN7PR04CA0197.outlook.office365.com
 (2603:10b6:806:126::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 16:07:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 16:07:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 09:07:45 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 09:07:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: David Ahern <dsahern@gmail.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov
	<razor@blackwall.org>, <bridge@lists.linux-foundation.org>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next v2 2/4] ip: ip_common: Drop ipstats_stat_desc_xstats::inner_max
Date: Mon, 9 Jun 2025 18:05:10 +0200
Message-ID: <b1514e637ec85b85fb76360c29573a4d9dc15dbf.1749484902.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749484902.git.petrm@nvidia.com>
References: <cover.1749484902.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 14087d6a-dc08-40a1-0dd6-08dda76fcd5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pyHyGzNCYUXRSTLaLPHNUi5GYMHolckYLhwXYzY+rFeAa8lSemt9w2zu3JcO?=
 =?us-ascii?Q?1ZsmLAcQVacLojp060o5JOYy3YWf3YZ5h3ekCJCc9rZb+KnNQqWHU0vO0CiP?=
 =?us-ascii?Q?SbLTRfvqUO7kNmEbwohRHflR+VqMqcCXeAS6lsoJ4S+hecWW+T5kfoourcQx?=
 =?us-ascii?Q?hnJPyuh64CMe6+OX7NY3GKCM57yjnF/spsdHHv3VyhVDFGpDix2Ait9wL3Di?=
 =?us-ascii?Q?UWf907lwt8NCtWD2MmCP4hYM4fsyJPoGzJq1sWcBAQUwLYrIuj8Y5EcJ2McH?=
 =?us-ascii?Q?9bf4+SkGksXB1co8HzlnQt3Co1WhS/gQfv/S16oaTcV/L/Hw6cr1Iqoobd7h?=
 =?us-ascii?Q?SYOTnosjqo/BgaJmfL6mBZ006esYUCXs92mt0ESAT+grUTsV+yKM5PX0kZ9h?=
 =?us-ascii?Q?067AnD09Aphh6Rk33JqLxl9FJxBmoJz/3eujD4KU6O0k9/r2wyuBWdx9BTSd?=
 =?us-ascii?Q?6OKUpXiM2UzVJhCPZnysKI4SH04plN0JeZsahxXfcINmETHN+NCzDi0qTQup?=
 =?us-ascii?Q?5Ktb5Q4zLAfD+18vEw3XUA2OiiOngfuC8+cMxlnpAW3/6NknllMR7BkjIQaB?=
 =?us-ascii?Q?PNrCp+jHLKosWFdsVJ7FKFItN2yb28xdS65MNpPM/gXFQg6SDymumpruUl+T?=
 =?us-ascii?Q?Oq6RMLFs8gjzdiUI6VWMWfEte5ywoaIvbubKK77oPtwPNwAMNYMHa/CaK+lV?=
 =?us-ascii?Q?OOscoAHUbKPc0yujCUlvGd8wJeXcWK//tUhhVc6RCBnoalYHMPkJB5jgnuTq?=
 =?us-ascii?Q?uX1ZEYDOSmeVd14/Ljj5QoZ00Xg3FNE6rDMJ/NxCMiWRQJ7migloBm5wSvmc?=
 =?us-ascii?Q?RnYYU380o5n3vlCKM3nrquPMOwJz+SSldQAsfRlruDiFjS05IAvcMfCfkWNl?=
 =?us-ascii?Q?i4vn3WLgMiLmSq+fzPVkjOzrYP3QECdSBYQ7qCGCdEx5i3vKoGa9n1KHaOAH?=
 =?us-ascii?Q?EpXFNY7MpmH8uKCwz+CCBc5V8aEZTzp1Y6VsDrK7i7PvOe2w+bJLncHS/YqU?=
 =?us-ascii?Q?ZRRz8Cc4J0D9NeFDB/kUsdJExcAIrcAmgRpxYRr+c+uF1Faw4EZervrg0vi/?=
 =?us-ascii?Q?pSCNwhjaK0t/Y4gBmowYb1N+003InQn7MKcpFogrHeUvJ5fCoAcDcZ0o7Her?=
 =?us-ascii?Q?BzcTrsDGcHiI7AWlOS83A7ulCGJPnozVNOPxEjXRgHxJmjU2nEx8+fhOPeR4?=
 =?us-ascii?Q?9SKocqPMhzi7JswElAvKZAO/AcugTC08XAf3v4TRv1qRAe/SnAPONNmDFryC?=
 =?us-ascii?Q?DY2VxxYLm0Ud1d8T7c83EG742tzbCKLuAGUKwiVCwFub36Srxir5YG0GAWG+?=
 =?us-ascii?Q?evdvFx4RvJVJ6EoGT5F7oE5h9lmNVzT317CarHU/vMRH90wUMStrzEkXXwPT?=
 =?us-ascii?Q?VeVpSEnao6jhlI9Er5sBzGrbEvWyvLu4o7+VqQb4IH/LoOXq5KVvzUfu+A+X?=
 =?us-ascii?Q?R7P9htoOF2QTpeFqIO+oHnk5EUuX2EMGJEfBDcHOmF91WL9/KPAfZMmdDe0U?=
 =?us-ascii?Q?H0S8mKFUwJvqaD9Fa9aujfRgksOh/RNrTDnZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:07:58.3594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14087d6a-dc08-40a1-0dd6-08dda76fcd5c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

After the previous patch, this field is not read anymore. Drop it.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 ip/ip_common.h     | 1 -
 ip/iplink_bond.c   | 2 --
 ip/iplink_bridge.c | 4 ----
 3 files changed, 7 deletions(-)

diff --git a/ip/ip_common.h b/ip/ip_common.h
index 37de09d4..3f55ea33 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -195,7 +195,6 @@ struct ipstats_stat_desc_xstats {
 	const struct ipstats_stat_desc desc;
 	int xstats_at;
 	int link_type_at;
-	int inner_max;
 	int inner_at;
 	void (*show_cb)(const struct rtattr *at);
 };
diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..a964f547 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -940,7 +940,6 @@ ipstats_stat_desc_xstats_bond_lacp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("802.3ad"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BOND,
-	.inner_max = BOND_XSTATS_MAX,
 	.inner_at = BOND_XSTATS_3AD,
 	.show_cb = &bond_print_3ad_stats,
 };
@@ -962,7 +961,6 @@ ipstats_stat_desc_xstats_slave_bond_lacp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("802.3ad"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BOND,
-	.inner_max = BOND_XSTATS_MAX,
 	.inner_at = BOND_XSTATS_3AD,
 	.show_cb = &bond_print_3ad_stats,
 };
diff --git a/ip/iplink_bridge.c b/ip/iplink_bridge.c
index d98bfa5a..3d54e203 100644
--- a/ip/iplink_bridge.c
+++ b/ip/iplink_bridge.c
@@ -1075,7 +1075,6 @@ ipstats_stat_desc_xstats_bridge_stp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("stp"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_STP,
 	.show_cb = &bridge_print_stats_stp,
 };
@@ -1085,7 +1084,6 @@ ipstats_stat_desc_xstats_bridge_mcast = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("mcast"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_MCAST,
 	.show_cb = &bridge_print_stats_mcast,
 };
@@ -1108,7 +1106,6 @@ ipstats_stat_desc_xstats_slave_bridge_stp = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("stp"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_STP,
 	.show_cb = &bridge_print_stats_stp,
 };
@@ -1118,7 +1115,6 @@ ipstats_stat_desc_xstats_slave_bridge_mcast = {
 	.desc = IPSTATS_STAT_DESC_XSTATS_LEAF("mcast"),
 	.xstats_at = IFLA_STATS_LINK_XSTATS_SLAVE,
 	.link_type_at = LINK_XSTATS_TYPE_BRIDGE,
-	.inner_max = BRIDGE_XSTATS_MAX,
 	.inner_at = BRIDGE_XSTATS_MCAST,
 	.show_cb = &bridge_print_stats_mcast,
 };
-- 
2.49.0


