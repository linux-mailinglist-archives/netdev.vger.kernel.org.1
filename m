Return-Path: <netdev+bounces-183777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42885A91E5A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D292B8A09CB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99024E018;
	Thu, 17 Apr 2025 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMgpXdlz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1924E00A
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897455; cv=fail; b=bmZkYv6YbOaHMaEImaI7GLmmF+1lmC3cXt7v38uIMD589fGT5TTjPBKjUNx9FT7Ns09HUZlmuf4+QEllQZ4I4A5UNlMydzFMeDzczXDX7eGnWw0N4BhntHi7LKSfTc6guGKGz678D80+S5442eg5EHJtrOGhlCjDQDvilZLXxKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897455; c=relaxed/simple;
	bh=9ULVBoDLV3qpFQNXb3VlHgNIyZJ69NO+goeTqEHio8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iW9/oEopvF6i3WyTmxw4DNJxOl134x31bFcKvjCnt6/ZyWu1WzHhBVN27lzTKu/WeXRl8gaA9lV6/NKE4BtftgeBzRATGU65fhRqyghgeSF56j2rhWcQpmGuq+UzEFV4CcVOXo/lGBm40Pf4eJiCoxtfa8Bzo0L0J8DjmAZD04U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMgpXdlz; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikhT/7/BPL4aLVNXGzkjsEAhU+DiNqhn7t80Zbx/0GoMTWi1ZNmFZDRdPVhLfYwUUAEPHyapvpCQpXVWh6vkyZLQEjeZ/6GiudUC2E5bzRakwbPPz+249W8sCAhs8muFceww2+6QHL6QcTtGQuGhTuKmhIOrp4vEYJ++yXQx0SuQ4fzRAgvW5GsBiEMd/BEPF5vH3CRKgwWa2/n17l/MP/5VyLFSab60Rq7fOBSLfPddndAf9IXf7mYLA3jagGjeldjoqGIKa99p22ioRwdaMLLfA+3w8MAKN+MdlHlT3Vx6FMsNUNtIIeQqYCtbaonfvN7zS+uKsxCOHV9HMxK4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKEe9VIAc0wpm1mHlB1JflNcKAeZUQspuxsv+HsekEo=;
 b=rVxM8qowX+UDcibnoZXAoOp+SQoRfVSEzBTu8xAEwRpESoCqh/vU2u/g9MD2MsYcruyL3WYKtBazHV6UOs0NapHRCN1Fw4z2p/BEJ0fiyUFXGPEFXDrey+oyO7fqgl4vb/fyiVXTTMrXp/WRoTpVrVKZ7TdnOmTMoPnKGRNe/r682t3AO9glQn0RZnYmR6QPbNNKVsH0pvTNMPXkmSSonXx0/uSnxgZxXtWKQOivhERVT7chvMnvZYRFddSCsnt2J+iHyBJm6qC9p3L1hEHFwfhePcUPYDd6Q79Urfd7F5zpdp508iQAF3uh5oKCmXc2WuMlejwYmR2C6SAaAwIwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKEe9VIAc0wpm1mHlB1JflNcKAeZUQspuxsv+HsekEo=;
 b=AMgpXdlznw47HTFOHWuGRtWP1iO3Ey9y7IwHFgCdCTZ+nvausSCrmX3swS9i0IS+mrXxtk3smprbrXT/836ycs7lv45sF7iumrrlC0IIwcbkw0LmccT3/4J89JK1vNnkZE0ll1mz//qwPvYQqB5SIUW94Smw71vL8/HZVtPrOwjOLOFLmqLYzibVlmDtDkwx27AaZR/SvEZQpzWIDRrZPG0JnpLe0VkZRIcS3uIgbGltFJx4XROvzIsJk+/TsiGj0qfjK0N7XQ85M49rCfEPusAfurR70jqXbOHK3x6nDq/wpaLkfAB67Fq6vwT9B53UMDW3+wzu8MFmTUH5GPSn4Q==
Received: from CH5P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::28)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 13:44:07 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::69) by CH5P223CA0023.outlook.office365.com
 (2603:10b6:610:1f3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Thu,
 17 Apr 2025 13:44:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:44:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Apr
 2025 06:43:52 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Apr
 2025 06:43:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Yong Wang
	<yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/3] net: bridge: mcast: update multicast contex when vlan state is changed
Date: Thu, 17 Apr 2025 15:43:13 +0200
Message-ID: <0b13864a33090fd1bd6bdee203256d775db0c35e.1744896433.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744896433.git.petrm@nvidia.com>
References: <cover.1744896433.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5e6b25-7700-41f5-35dd-08dd7db5ecac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+dbc7YEph148tmfipyx9a0hRgSD0/P1mVs94TMVpBclD02WL7QCdHzbDxJ4?=
 =?us-ascii?Q?SXPptuUiFIVFbRwSk25PkTt+HjJESP6Zbu0nCfmWIfMElb/l7fXW+lw/LZSt?=
 =?us-ascii?Q?HUVnjaKEpygR6lACrOFJ1Yzm3q3IK5rhe3TwhEHnL8F9THX6P1qqL9bcnNtr?=
 =?us-ascii?Q?6ATYbUDrp0VwOy+hVd37hpbkeGjkR0lm7TYlFRMcyLM1koSmvGcKo0NUi56P?=
 =?us-ascii?Q?exMPBKHAH6A/Pi3yZhwrHHNKjkqOQQM9U+gf687etgZmSk7fP1PVwTo5boUk?=
 =?us-ascii?Q?g4ZZksuVSWqOmtbOdsWy8r6eZphDQDByLk3jfx6pFI1EdLJ4Sz1e5vV/LAhT?=
 =?us-ascii?Q?+y8YgpWC8cILndq0fUEQokHgNTju9/8iUHrYraiUrCQ3ArJy+NvSKPnjwJ9o?=
 =?us-ascii?Q?PkkQBuya3xgXmZsnDKd4W3EZi6AlaF6PnHkOUMfFoGP9GJg49A3m0QAHg9EQ?=
 =?us-ascii?Q?lM2bkVlxZsWw2SO1gfPn2kiPM3O+Bmks7Cuk7LqLd8ILXbfOrXZRgnsyWS/t?=
 =?us-ascii?Q?VIU7CzDtZCVVPk0iUUauTnZKBRmz860KgHh5wiVojVa7hizgQm+cmCR20UNJ?=
 =?us-ascii?Q?CirWlh1CkRZebSlo6Wb/tS2NievcHXRG1eqBfiybnwxuR99S3Ztrg6CajCRJ?=
 =?us-ascii?Q?MTMC6IneJvxQmRoCc+XN8Q9OoVTC/ICFcsLFBaPzClqdjvwbzLKtMJ3qF2yZ?=
 =?us-ascii?Q?BV+4O5rJ6q3WISm89GUN7U/pdoY79CATESpF1ZQs33mG9UgR44/B+MWCzI74?=
 =?us-ascii?Q?sfjRYD1DW1cVPZFtCYSN8WiZFIB9fybuOAH2/cVRvhVam0KRQehxasbLWfNA?=
 =?us-ascii?Q?mppXA/rzro0gslkXu5Jonp4A6erhys6llq647iVJmjqvGF2miMKuj3Yzf1jI?=
 =?us-ascii?Q?Xl7gvTJqonNLh3AHf6RTokl4WRrobjWDNVkS2/Or7wGsg45ePMZl7XX4e8J6?=
 =?us-ascii?Q?El6XU0qImpxrJqXP1XrmHd03FCX5YvwWyuPFIJnjE726ziKUsrxJRmFU37h4?=
 =?us-ascii?Q?QDK/2IloFk+Qn7lEJQGq/PJfRFZsh5J8IBSEGHSOT1xheZbDQ2KFW2lS+jkW?=
 =?us-ascii?Q?hAmE1NhjmIKX0gYcJMbR9sSa/x4HVffyibsU4YiI4FRAykRQ3TpMAYlBzQHK?=
 =?us-ascii?Q?JU/19LaHenwDJpOUhyGl8NS8mnDsum21gNBNqfOeAnT7ph6LN4kT557/FPuN?=
 =?us-ascii?Q?PznRabTlmg+KRMMbqHaJy0PSau5+zYqjLZ+bzdtopPci78fOWZIdGifsuz0y?=
 =?us-ascii?Q?pr99zCY0dqdR48b4G8JpYIO/ZmerECBGVCivKXOhu86uvgvBgnEeEIeQPznc?=
 =?us-ascii?Q?+Fwj/EZv/0VGhdhEzGwMyUj6IfWHh1N3SKuym/1JEFFngn7sRGRbXVqW/jC/?=
 =?us-ascii?Q?FAiUmFvwnWWPHrtlxGy/k+Rjg43REPhvg6PjfyGBRZW/O4yfdbGHTcNnWw+Z?=
 =?us-ascii?Q?YLUcM/6gtJEJSvjyyYdoffOAcyKZITzG9C/Dk5JDlCqQHeWXdAaJi6tOY44y?=
 =?us-ascii?Q?0e34SF58m3HAnMQglVc/efJ0qVuOFI3IoII+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:44:06.8210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e6b25-7700-41f5-35dd-08dd7db5ecac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

From: Yong Wang <yongwang@nvidia.com>

When the vlan STP state is changed, which could be manipulated by
"bridge vlan" commands, similar to port STP state, this also impacts
multicast behaviors such as igmp query. In the scenario of per-VLAN
snooping, there's a need to update the corresponding multicast context
to re-arm the port query timer when vlan state becomes "forwarding" etc.

Update br_vlan_set_state() function to enable vlan multicast context
in such scenario.

Before the patch, the IGMP query does not happen in the last step of the
following test sequence, i.e. no growth for tx counter:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # sleep 1
 # bridge vlan set vid 1 dev swp1 state 4
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge vlan set vid 1 dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1

After the patch, the IGMP query happens in the last step of the test:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # sleep 1
 # bridge vlan set vid 1 dev swp1 state 4
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge vlan set vid 1 dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
3

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_mst.c       |  4 ++--
 net/bridge/br_multicast.c | 26 ++++++++++++++++++++++++++
 net/bridge/br_private.h   | 11 ++++++++++-
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index 1820f09ff59c..3f24b4ee49c2 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -80,10 +80,10 @@ static void br_mst_vlan_set_state(struct net_bridge_vlan_group *vg,
 	if (br_vlan_get_state(v) == state)
 		return;
 
-	br_vlan_set_state(v, state);
-
 	if (v->vid == vg->pvid)
 		br_vlan_set_pvid_state(vg, state);
+
+	br_vlan_set_state(v, state);
 }
 
 int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ce07fda6a848..7e0b2362b9ee 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4272,6 +4272,32 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 #endif
 }
 
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	struct net_bridge *br;
+
+	if (!br_vlan_should_use(v))
+		return;
+
+	if (br_vlan_is_master(v))
+		return;
+
+	br = v->port->br;
+
+	if (!br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED))
+		return;
+
+	if (br_vlan_state_allowed(state, true))
+		br_multicast_enable_port_ctx(&v->port_mcast_ctx);
+
+	/* Multicast is not disabled for the vlan when it goes in
+	 * blocking state because the timers will expire and stop by
+	 * themselves without sending more queries.
+	 */
+#endif
+}
+
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 {
 	struct net_bridge *br;
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 71f351a6ce1b..db1bddb330ff 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1055,6 +1055,7 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 				struct net_bridge_vlan *vlan,
 				struct net_bridge_mcast_port *pmctx);
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx);
+void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state);
 void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on);
 int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 				      struct netlink_ext_ack *extack);
@@ -1521,6 +1522,11 @@ static inline void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pm
 {
 }
 
+static inline void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v,
+						      u8 state)
+{
+}
+
 static inline void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan,
 						bool on)
 {
@@ -1881,7 +1887,9 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 			      const struct net_bridge_vlan *v_opts);
 
-/* vlan state manipulation helpers using *_ONCE to annotate lock-free access */
+/* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
+ * while br_vlan_set_state() may access data protected by multicast_lock.
+ */
 static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 {
 	return READ_ONCE(v->state);
@@ -1890,6 +1898,7 @@ static inline u8 br_vlan_get_state(const struct net_bridge_vlan *v)
 static inline void br_vlan_set_state(struct net_bridge_vlan *v, u8 state)
 {
 	WRITE_ONCE(v->state, state);
+	br_multicast_update_vlan_mcast_ctx(v, state);
 }
 
 static inline u8 br_vlan_get_pvid_state(const struct net_bridge_vlan_group *vg)
-- 
2.49.0


