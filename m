Return-Path: <netdev+bounces-220041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD66B44413
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BB251892E76
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB3319866;
	Thu,  4 Sep 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pS848dhd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D730DD1A
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005790; cv=fail; b=f6ix5ZCfa/FOX5Z5wopBVe2+4IhGIjjYEpssKCjof7TgGwm/PcIBBe5cMJwBvLjmNm/TtEZBcCh6Mq26xYCW4a7z2OAdBbzSzwmC4M4xPBBiPlZKOXyitxWp6gaabNxH7KM0ApJ4KIdmpNn0Cr7FOzZdLNQoGjapULwMCQiaaEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005790; c=relaxed/simple;
	bh=coOeCGjIbHM8v8+fnnemKftNRzWIgnU5J/jHuzvlYxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBXQRHYapiWbIT9D9UKCeDNWUInWyUIQGlk5Av6s7d8N5Pa0FXegF5ahhsUYHSuc1yzC4qzluZDvKNq0nvOXwr7gF6wpzQ2ncw/mMV+Qp42CPyFxyDu82n/FhhHwxUfKikJuSwjAfR6UrCv7W+8yb3rpjfOTSB0Ywk1oQP2buxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pS848dhd; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDvV4SEgzE9rJQrGUtwSniW+LMh8BX9jewc2N7PwNWzAl9BsT9ajBqZhmqWr/Dq3UBY3N19pCA4JyziEO4hqO65FeEEkeAbsVXb1MAYNQrwPNpSZVtXZ6byzz16xmxuUUSM8K2yaToXIoLTBZbgNfvOuqAtggP1ktkePnp+okQgEWN2Z67v72M4gzrdJ9P6DJ/2O5wcVUgj8ALoQsMq0PA4J8NnhljfO1F+bC+3pvCREeIkW8eXI4uo0Un/6Rv9OPnufh/sT+pkwzpKmrZabLeovD+8yyjylOPPTM3z2n03QZNFj1s5Fcu1wLdANuJK53hT7wgbjOibi/ylILgfu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNuPL7AIkOB4s4NSgoa+bOMfqB8iV3HAEG49Tpyzz3s=;
 b=o6s1Ja7F18507JB5s5BtmYTx/QE0p0eR3dlbWrAr9+J3D1eP9rEOvnwHJ7snT39Ub5EYoxUFF93JQjMpTjBaEjdKGfu7yqhOTlP6ZNXpJjr3UDd7DoeB0Yk5Qqq6c7yMbWgr9wUEnaqQZVcUnZAYXu27q+Ih4gi7JF2VIv696sJcwy9jx01Bl2LC0emphFhZLpTJd7RG8pzP5cBEkdtbGLypBdnwJxgkxxI9JpmBSPJcQeA2ZJensKZsOX0rMNERDr2R8bYUF6EToLIYLu16zkxKRuSIMumEmW9gREXMmUGVBF01o/NMjXpsFwbI21JjQfiiFWPcrXwt8DnkDXpX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNuPL7AIkOB4s4NSgoa+bOMfqB8iV3HAEG49Tpyzz3s=;
 b=pS848dhdNge3T3+G3lTY0QB8FhJNNBJZamqdvevSukIozNMdgyFEHIS0WoXtF5Pc5pM6SyC1loN3/tAXl5WngEdGUcL9CgRgyq/34sfiws/nsVxidVeJmpIzTBY1xyl21b8VZTfUSomAGRyB0gD482CHmA1mJTn+qWs+wmgbxzUPM/OwKgo3pYzdWvxSvSCJnQ4thIvinoNYhWL8u4jkhOca2kPXKsZOyZWaQAoUolpif6LnJk9VgzkkfrnkdhrfuHAsTKAMck3agn4YpqrmTqFsQWS70aiuUAGXEWsvjve9jVTLm+S08loeznhaq0Rq/P1/LMNl90qujCgrZSoPSA==
Received: from BN6PR17CA0059.namprd17.prod.outlook.com (2603:10b6:405:75::48)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.29; Thu, 4 Sep
 2025 17:09:42 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::f5) by BN6PR17CA0059.outlook.office365.com
 (2603:10b6:405:75::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 17:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:17 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:12 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 06/10] net: bridge: Introduce UAPI for BR_BOOLOPT_FDB_LOCAL_VLAN_0
Date: Thu, 4 Sep 2025 19:07:23 +0200
Message-ID: <ea99bfb10f687fa58091e6e1c2f8acc33f47ca45.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c13b84-c16b-482e-1d3a-08ddebd5d6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N6kkh9ddduKcEpJo48eKHT9NddKgfX9l9d4sEwjTw2hSD5MmCnnulbTtzoAD?=
 =?us-ascii?Q?ES5W2YIVSwOHdNQGogLAMw5kiL2xZSutaqA1E4B9tnmExeM3P8yy+6V/9rgr?=
 =?us-ascii?Q?VDqanpoJTJjzDG91VKdi/fX/RutBlMpaltgLltCo+rIc83MvoNoDIt8BVMUC?=
 =?us-ascii?Q?59yHunEhmpJhvj9mLBficFMrVE26wK/ra9mj1zlL05xVStGqujFQ8DzC+yRo?=
 =?us-ascii?Q?pjH71mLQ+PcBuEqhLEPaV1mJzd9KJ23hBR5u4Srky4/JShxjnX/Uda3wN6Jr?=
 =?us-ascii?Q?yQCJrJjo2r7PzkDGjR45YJOTbGfENazsqKMYQm2JUSIQtUi2Yy2+5MGk4RjN?=
 =?us-ascii?Q?g3RCYJaYG9FxfMt/PJMpuLLZ6nx8lHu08AuoyJ9424PLdzKc6LMc+Du6DXwZ?=
 =?us-ascii?Q?BtcrYnKdWQdKH1ayc9wKy0nw/Bv38QOQ0JDpvLODdTFeCg9uexlX8q3TJt0k?=
 =?us-ascii?Q?sKaHrs9ESmDSJnZ0+FdbTIaqRQK0x2rgGNshiLQ9ZNyJ1I1dWkhtYpFjH8lW?=
 =?us-ascii?Q?7SHDuXVd6evA1SzPX5KEzkGBJrA9/NXNjVH6zB4Pu1nqMA1C+fD9cjz3N5+J?=
 =?us-ascii?Q?mHecNpY5OF9inww3QUGWWfFDOWyHVY45w5G16TXqy7RnUygStW2wstW52UZm?=
 =?us-ascii?Q?EbL9smUNgizq8ZUUzp3VV6iCMjr/8N230Mdo1ffOO9VGX4qxJLz08Bc4pGXX?=
 =?us-ascii?Q?s8O2TXpivrO2NBE5aRkhTnCSnWQNM1KT6EpnG2DGGBw3y9rIKJNjOri4MN3/?=
 =?us-ascii?Q?64XI9APP0QKVUtkrH45BnCWryUJYQtTi0rm6U73eAtSjXjkxEqQbZpTPdDfW?=
 =?us-ascii?Q?2lsoTI3ScEi6pcvc8VWxCO/ArnLXUoKvao3x9tGy5oObRy5TmE90imYZ+fKQ?=
 =?us-ascii?Q?WCqOkQzb94dNlnXBGNQqonhPNg4p2XomR4wmv3Nm6n9Xhn8Km0dUHmbulnfr?=
 =?us-ascii?Q?WuPBFJMr9kawoEclNUE1yoTQY3asssDpXhL7/6F7wcHLcTMk/3wdObKHx/XV?=
 =?us-ascii?Q?UHJknCaUnwhGxIdTiVHPpIIdG3nQir1P8ZshproZvfjDa+DV1uqiV87/kO8f?=
 =?us-ascii?Q?zl9U16De3rlOUNbzDn2Oi+BC938jjWk8BGI8aavDflv29CJP/8AYLaAVybMb?=
 =?us-ascii?Q?upiaQcuPwjj396sRyU8MblBlAsfTCeLkpfZKwMJLl7mUAAatUEmc7qWe9t8i?=
 =?us-ascii?Q?Ui5+HVNEgSrAMMyw6etgmPmZdzJC8Ipo/2OWzeks92m3hw51WS/HIY8LziUa?=
 =?us-ascii?Q?D3rGho6I5lr7d7OW+dXmssBWlrhJJL+j+zOzmrbV8UOzyO145REroh0bvWcB?=
 =?us-ascii?Q?uH4m3XPvRpqmbFgysR4ITF233zNgO+DwTBF4aruKFMwT9e3gWe6e8Ne3V/dk?=
 =?us-ascii?Q?oBUSRV544wNCKBCMoUHGCFRZnf2gJ6cWP1+PMlhNhV9DIO2iWzJKwacoPQ8K?=
 =?us-ascii?Q?Qsf+bgBvMR2YwldAViHzhUFZmjXnXefoPzW3WPUMTQP81ugdzXbqNJFREAh0?=
 =?us-ascii?Q?85DY290WVl3MPM/GQ/5l7UR797rIfxYi7zGD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:42.1665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c13b84-c16b-482e-1d3a-08ddebd5d6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

The previous patches introduced a new option, BR_BOOLOPT_FDB_LOCAL_VLAN_0.
When enabled, it has local FDB entries installed only on VLAN 0, instead of
duplicating them across all VLANs.

In this patch, add the corresponding UAPI toggle, and the code for turning
the feature on and off.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>

 include/uapi/linux/if_bridge.h |  3 ++
 net/bridge/br.c                | 22 ++++++++
 net/bridge/br_fdb.c            | 96 ++++++++++++++++++++++++++++++++++
 net/bridge/br_private.h        |  2 +
 4 files changed, 123 insertions(+)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 73876c0e2bba..e52f8207ab27 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -823,6 +823,8 @@ struct br_mcast_stats {
 /* bridge boolean options
  * BR_BOOLOPT_NO_LL_LEARN - disable learning from link-local packets
  * BR_BOOLOPT_MCAST_VLAN_SNOOPING - control vlan multicast snooping
+ * BR_BOOLOPT_FDB_LOCAL_VLAN_0 - local FDB entries installed by the bridge
+ *                               driver itself should only be added on VLAN 0
  *
  * IMPORTANT: if adding a new option do not forget to handle
  *            it in br_boolopt_toggle/get and bridge sysfs
@@ -832,6 +834,7 @@ enum br_boolopt_id {
 	BR_BOOLOPT_MCAST_VLAN_SNOOPING,
 	BR_BOOLOPT_MST_ENABLE,
 	BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION,
+	BR_BOOLOPT_FDB_LOCAL_VLAN_0,
 	BR_BOOLOPT_MAX
 };
 
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 1885d0c315f0..4bfaf543835a 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -259,6 +259,23 @@ static struct notifier_block br_switchdev_blocking_notifier = {
 	.notifier_call = br_switchdev_blocking_event,
 };
 
+static int
+br_toggle_fdb_local_vlan_0(struct net_bridge *br, bool on,
+			   struct netlink_ext_ack *extack)
+{
+	int err;
+
+	if (br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0) == on)
+		return 0;
+
+	err = br_fdb_toggle_local_vlan_0(br, on, extack);
+	if (err)
+		return err;
+
+	br_opt_toggle(br, BROPT_FDB_LOCAL_VLAN_0, on);
+	return 0;
+}
+
 /* br_boolopt_toggle - change user-controlled boolean option
  *
  * @br: bridge device
@@ -287,6 +304,9 @@ int br_boolopt_toggle(struct net_bridge *br, enum br_boolopt_id opt, bool on,
 	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
 		br_opt_toggle(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION, on);
 		break;
+	case BR_BOOLOPT_FDB_LOCAL_VLAN_0:
+		err = br_toggle_fdb_local_vlan_0(br, on, extack);
+		break;
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
@@ -307,6 +327,8 @@ int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
 		return br_opt_get(br, BROPT_MST_ENABLED);
 	case BR_BOOLOPT_MDB_OFFLOAD_FAIL_NOTIFICATION:
 		return br_opt_get(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION);
+	case BR_BOOLOPT_FDB_LOCAL_VLAN_0:
+		return br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0);
 	default:
 		/* shouldn't be called with unsupported options */
 		WARN_ON(1);
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 4a20578517a5..58d22e2b85fc 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -582,6 +582,102 @@ void br_fdb_cleanup(struct work_struct *work)
 	mod_delayed_work(system_long_wq, &br->gc_work, work_delay);
 }
 
+static void br_fdb_delete_locals_per_vlan_port(struct net_bridge *br,
+					       struct net_bridge_port *p)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_device *dev;
+
+	if (p) {
+		vg = nbp_vlan_group(p);
+		dev = p->dev;
+	} else {
+		vg = br_vlan_group(br);
+		dev = br->dev;
+	}
+
+	list_for_each_entry(v, &vg->vlan_list, vlist)
+		br_fdb_find_delete_local(br, p, dev->dev_addr, v->vid);
+}
+
+static void br_fdb_delete_locals_per_vlan(struct net_bridge *br)
+{
+	struct net_bridge_port *p;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(p, &br->port_list, list)
+		br_fdb_delete_locals_per_vlan_port(br, p);
+
+	br_fdb_delete_locals_per_vlan_port(br, NULL);
+}
+
+static int br_fdb_insert_locals_per_vlan_port(struct net_bridge *br,
+					      struct net_bridge_port *p,
+					      struct netlink_ext_ack *extack)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_device *dev;
+	int err;
+
+	if (p) {
+		vg = nbp_vlan_group(p);
+		dev = p->dev;
+	} else {
+		vg = br_vlan_group(br);
+		dev = br->dev;
+	}
+
+	list_for_each_entry(v, &vg->vlan_list, vlist) {
+		if (!br_vlan_should_use(v))
+			continue;
+
+		err = br_fdb_add_local(br, p, dev->dev_addr, v->vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int br_fdb_insert_locals_per_vlan(struct net_bridge *br,
+					 struct netlink_ext_ack *extack)
+{
+	struct net_bridge_port *p;
+	int err;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(p, &br->port_list, list) {
+		err = br_fdb_insert_locals_per_vlan_port(br, p, extack);
+		if (err)
+			goto rollback;
+	}
+
+	err = br_fdb_insert_locals_per_vlan_port(br, NULL, extack);
+	if (err)
+		goto rollback;
+
+	return 0;
+
+rollback:
+	NL_SET_ERR_MSG_MOD(extack, "fdb_local_vlan_0 toggle: FDB entry insertion failed");
+	br_fdb_delete_locals_per_vlan(br);
+	return err;
+}
+
+int br_fdb_toggle_local_vlan_0(struct net_bridge *br, bool on,
+			       struct netlink_ext_ack *extack)
+{
+	if (!on)
+		return br_fdb_insert_locals_per_vlan(br, extack);
+
+	br_fdb_delete_locals_per_vlan(br);
+	return 0;
+}
+
 static bool __fdb_flush_matches(const struct net_bridge *br,
 				const struct net_bridge_fdb_entry *f,
 				const struct net_bridge_fdb_flush_desc *desc)
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 87da287f19fe..16be5d250402 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -844,6 +844,8 @@ void br_fdb_find_delete_local(struct net_bridge *br,
 void br_fdb_changeaddr(struct net_bridge_port *p, const unsigned char *newaddr);
 void br_fdb_change_mac_address(struct net_bridge *br, const u8 *newaddr);
 void br_fdb_cleanup(struct work_struct *work);
+int br_fdb_toggle_local_vlan_0(struct net_bridge *br, bool on,
+			       struct netlink_ext_ack *extack);
 void br_fdb_delete_by_port(struct net_bridge *br,
 			   const struct net_bridge_port *p, u16 vid, int do_all);
 struct net_bridge_fdb_entry *br_fdb_find_rcu(struct net_bridge *br,
-- 
2.49.0


