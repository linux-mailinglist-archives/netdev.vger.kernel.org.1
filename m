Return-Path: <netdev+bounces-183776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C85A91E58
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E7B19E78B7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569B324E010;
	Thu, 17 Apr 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibuIuwRi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8974A24E005
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897449; cv=fail; b=qE85ZzXXD1HCfTN7BvV8fKDP1KBorBgaQglmro3Ww9ZEuNYTWT5rMcYCDROQ0Rj46hvHgZZzwMjtdjX8SAuzuGIWwZcC4Wge/DjNVjk9PFZzB6udFQkOwSs8GOkUBUaSYHJrB2yK5kJBMj5TI1sSiAklaumafwHfYO9AHy0rwvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897449; c=relaxed/simple;
	bh=qwy4fN4yxFnJSX2v6k3ZdT/l2ot25yzkGuxvB7DQ5Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruQs5fWTKLGOgFHLvBqbs79wTnhMqtzglG//ZyugXVtiFATOx8N+BaDBa1CXWJVOWnkidOJR7F6vGA6odNOEq7+iNQO29IfEUifn9h8QrhAOVOgwqmFGBvWaPDjZ54cQegNGtxtdKwf5KN04vHKJe3+4ae6K1jxrc+53HXxYmhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibuIuwRi; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCca+pa4w5ZG5pecB4w+8hagjpfxE8C1sgAQghyjjyrPAYRmelboxkV9z2DsCUeU+hRVxnMjFqEQAELfFqZf+MDtO200vvQ3WT7QQvz6a+84tIKYpcciMYAbD3FYMiHjGD5uEHTwBplu5yCT6CTsxYhTwKvCLnGngEHmEzi3PvYJ/C9mhVg93aY6MdnGn8Da0Ba7KnZ5JaAcw0cgkCkZuFMp/is5WpjrCfx2N/ttAvtxka6Ke62/1+t7h+LLiiZiSb+vZJGdfwHSQDlzdb3WGVigkd5J905I4FhmFnlNHAM75qVzO6wQXkfL0J2fYlYm6pD28UbeWil/5rl8SBPNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igNcRYnxU/W159Rg6gydbHX8A6A8I3FK7PZIEEd7mCc=;
 b=T9vsQ0y6oUqVPw4glnNUpP0q9rIeQz6MZmBM/fKjmbuleQiQcmmfS2T0Uo5i+8yGClpvJ4VSzSnwslvQe8P/oSK/vrPbpA7VXal0VboPMBiKhd+L9IO1FMfi+6/iMkoHCsFNBuh/OUILWn/lVLF8JFDd4/7LwWDsChWEBkaqIv3QHPQiKIGwjOu4CLHfMmCxsykPWjwgl1VOClwhZW/8j41E7KE8ZfVDrTCIvL43wgR2wwsZXrTXf7Fx+xnGrIbPJNha+Ut2eAN4z7ye8/837mGPv8W9NqS5/Pu+SwhVAJ7VPud3od9W/FVTsmF+N/IISaJP7cAMQIzzteGijtA5Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igNcRYnxU/W159Rg6gydbHX8A6A8I3FK7PZIEEd7mCc=;
 b=ibuIuwRiYr/z9fKVKNy+SSCSgWqMfRq3l/iAKj7ep411JzDZQPGsc0QsSjSQV2IzNij4MZKBaM4hG+M+fjDClgA8I4ZI7wfHFT+HepHQ5/PnnYYqRfdh+oQu7WSPGxpmylQ2hczBIxDH2f8KAmo8SoTJ+tOvR9Hy02EC9Mqi/l5CggW3avVo5WMospwSQGCwTWBfwjtN8f80pFeW6Zt9Rf+wr395MhD4PY0mq1ZmfwNd0uUaPAyGO9LXulS/okM3nEzfN5KfrCckPtnSm8EJXDTzYaLsff+37cuW+19DV3sVKqWf5ff25Ko7YXkBTAUeojY5/O3sEqYLjWSn/O8WUg==
Received: from CH0PR13CA0018.namprd13.prod.outlook.com (2603:10b6:610:b1::23)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Thu, 17 Apr
 2025 13:44:01 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::8) by CH0PR13CA0018.outlook.office365.com
 (2603:10b6:610:b1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 13:43:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 13:43:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Apr
 2025 06:43:46 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Apr
 2025 06:43:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
	<idosch@nvidia.com>, <bridge@lists.linux.dev>, Yong Wang
	<yongwang@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/3] net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions
Date: Thu, 17 Apr 2025 15:43:12 +0200
Message-ID: <36976a87816f7228ca25d7481512ebe2556d892c.1744896433.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 978bdaf2-268d-4a2e-5f25-08dd7db5e7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UJxiFhS6akyN8i7TYz5JEDvG7uQ/EfIpbyLKffVJC+gOFTmycMnXGEgU+evm?=
 =?us-ascii?Q?D1b1bUDVD9nAHgQzyJKYg9HcGbnPsZOVT9Y7SDD7R/qy0oP4IlyfCr+jHESl?=
 =?us-ascii?Q?s3fLr3qK3T/Q43jYtYn7r6rltKGgG/EDK5NDuGtYKi+UYLDvDYPG+NGyP3m9?=
 =?us-ascii?Q?kdciMCkbcQ/e8yYFG31a6y6aqXUceeN/bchqRHzmWUKrh20t1JdSWHn/hfrb?=
 =?us-ascii?Q?JWq1gVkgnVvj+5HjBlKxCN9jxpBNy0eVW9wfNkHF235mgRyVVPW8HUoxElqQ?=
 =?us-ascii?Q?GDU0iCs/ZgQup9CQgao6YhoFQufJCUN1bs5AEkaBYCT6P9B0YmYLD89ncTOp?=
 =?us-ascii?Q?9Q2h6Xk6b/YLQ6i4VwMBSyC3kHMyk7xvbx/P9GQe61qKLkLkf1XHFbPOQYpa?=
 =?us-ascii?Q?ybqnxNxrO7swGc9oIcYOQV8/UfwJlI2iLEeoewdp4JXC+eI5H2iitik9fNhU?=
 =?us-ascii?Q?PCdInYb4JnD6dDDnh7qVjnirLmS74JScneU3bqexHC4ISNXAhDmI6aGGD2Wx?=
 =?us-ascii?Q?vhB/+/uMDiV17Ko0ngC0jL/J+/T7orqXj1JJJBCnqWTuhX0z5kXxA1zQln5a?=
 =?us-ascii?Q?70hCcUJPena9TRt6H5Yjawkj7ciav8lrnNDuCq2/pJE+V2TK0qgKWtlKqK5z?=
 =?us-ascii?Q?zJpYPWJP8/nIwmnYtQRo8zjBGQH/zYpNWfHRRzCESxcuGHeIPeK1NVG+KbZL?=
 =?us-ascii?Q?gWwdv8ZArFhqu+/UrDLyqs4yeiJhRPtq2YOjG87QtwMqfqKO4ZQXrd/mwjjQ?=
 =?us-ascii?Q?Zs5NkfN4dyFUQH6hy8RFhSxEtodBIknDwkVxmHv5wVbv67CZl+MeCwe/fq1A?=
 =?us-ascii?Q?Pul+QLFvnHFBEidLojmD+UafYL81q3zeImZNj9bNLobY6M2Tzz+KeRpH+jds?=
 =?us-ascii?Q?qntnN6cUkjqVl/63s8cp8K1Cs5e6zSvin8Rb0TKPTzjfDeqBYGyOqPJdxfie?=
 =?us-ascii?Q?mYoGC8KNBTbSx1vSp9hHod8obM12z/CLsdk+xQ5QJ+1MVrwcwRTeNvuheVQI?=
 =?us-ascii?Q?XK3ivjLMbsrb6CPZX0fivO4sLEiQbacCoWr2XTZB8s170YLWeb7hADMEJyJq?=
 =?us-ascii?Q?MCugnXl4MoxMBGj6pgQkx/5aRrMWMfiEzuBFz4QJYnMAMXx9gl2JLLuHGyZ6?=
 =?us-ascii?Q?ZKUV9+o3ROMc3GIgD/YrMMFMfUmOhRyTxVX7+uT6w4MI/y+bRvyxJZmZkafG?=
 =?us-ascii?Q?3jQHuYJkLdSYHEHPgYyeoQGu+yfuuNzSKtg65NBKo9sM+3LCHUAg/wVMnRr1?=
 =?us-ascii?Q?60j4EkpEAi4bGY4qFq449GiuvrIZi+n0rEcsDevE4pf6teY5FauEsooAyl8+?=
 =?us-ascii?Q?Ya6LEOrXa+rkiLUd1id6f+8f4RizJkUZHi1UIPEJAc4p1aeOxxAs80LC8omf?=
 =?us-ascii?Q?bGy7ugSfwrAzTdNjefkGcis+3gTrmI5skRwa4VctIEaDKkU4i+KbDUGkQ9s+?=
 =?us-ascii?Q?U8tlprTXhqMAdvGREKSRdpMb44zhO1MVpwqYAM4ehLzeSQlnSXKV1nY7YUDW?=
 =?us-ascii?Q?wOzYwKIRYVJ8RGY71HsrC0s+mlYZU/4rqkgW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:43:58.5750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 978bdaf2-268d-4a2e-5f25-08dd7db5e7c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963

From: Yong Wang <yongwang@nvidia.com>

When a bridge port STP state is changed from BLOCKING/DISABLED to
FORWARDING, the port's igmp query timer will NOT re-arm itself if the
bridge has been configured as per-VLAN multicast snooping.

Solve this by choosing the correct multicast context(s) to enable/disable
port multicast based on whether per-VLAN multicast snooping is enabled or
not, i.e. using per-{port, VLAN} context in case of per-VLAN multicast
snooping by re-implementing br_multicast_enable_port() and
br_multicast_disable_port() functions.

Before the patch, the IGMP query does not happen in the last step of the
following test sequence, i.e. no growth for tx counter:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # bridge link set dev swp1 state 0
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge link set dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1

After the patch, the IGMP query happens in the last step of the test:
 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1 mcast_querier 1 mcast_stats_enabled 1
 # bridge vlan global set vid 1 dev br1 mcast_snooping 1 mcast_querier 1 mcast_query_interval 100 mcast_startup_query_count 0
 # ip link add name swp1 up master br1 type dummy
 # bridge link set dev swp1 state 0
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # sleep 1
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
1
 # bridge link set dev swp1 state 3
 # sleep 2
 # ip -j -p stats show dev swp1 group xstats_slave subgroup bridge suite mcast | jq '.[]["multicast"]["igmp_queries"]["tx_v2"]'
3

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/bridge/br_multicast.c | 77 +++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dcbf058de1e3..ce07fda6a848 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
@@ -2137,11 +2142,67 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
+{
+#if IS_ENABLED(CONFIG_BRIDGE_VLAN_FILTERING)
+	if (br_opt_get(port->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan, toggle vlan multicast context */
+		list_for_each_entry_rcu(vlan, &vg->vlan_list, vlist) {
+			struct net_bridge_mcast_port *pmctx =
+						&vlan->port_mcast_ctx;
+			u8 state = br_vlan_get_state(vlan);
+			/* enable vlan multicast context when state is
+			 * LEARNING or FORWARDING
+			 */
+			if (on && br_vlan_state_allowed(state, true))
+				br_multicast_enable_port_ctx(pmctx);
+			else
+				br_multicast_disable_port_ctx(pmctx);
+		}
+		rcu_read_unlock();
+		return;
+	}
+#endif
+	/* toggle port multicast context when vlan snooping is disabled */
+	if (on)
+		br_multicast_enable_port_ctx(&port->multicast_ctx);
+	else
+		br_multicast_disable_port_ctx(&port->multicast_ctx);
+}
+
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	br_multicast_toggle_port(port, true);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	br_multicast_toggle_port(port, false);
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4304,9 +4365,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-- 
2.49.0


