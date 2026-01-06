Return-Path: <netdev+bounces-247407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFE9CF9772
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3ED63011ED4
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4520E33ADAC;
	Tue,  6 Jan 2026 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="poaovlSR"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED91339861
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718335; cv=fail; b=LxBa6WI47FObvXSpdTI4g9cMUaszgMkB3J/ojnGfMGY5+3RmmDrR0hSe7wY/wBYQPgCPEwF46Nw7T2HpRSROJKHpOG7euyEwPGl3KoRvDqyLofJT8h3Yxy1LLSZzVXvK9wy9SOi+smgr9HeVRpUJUuL0YxObtvK7xtPFWfxdi3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718335; c=relaxed/simple;
	bh=lVEW9XIxRBQsCczTEPoFdzr56ZsZZnSrVRm6OiOiN6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUtrqN7szKv7S/euGZ7WKIzuyNuYrb+tZBSDAD31wUfXcnreLhHlTZC1t63iYkq5iF0f9Q3se9WYcunsEMyjXL4YLRcZAmNi6dMX4/ZX8YtVeU+cWXsuuLPDy+2+7k59I8CfNfOihTbyxkrRIL+bA3rctSUpddnwpDLG+gHnpG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=poaovlSR; arc=fail smtp.client-ip=52.101.48.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fElvZTQR4K6htjXcY2DSUgr48GELM9t6r4PvkFdVqkSp6l8dtEG6JbZiZrvEjEronGsoaCwZsglAYYKtI76S4dR5pbjsT5OCXgUIblrC+sgIkjtKiBdBZ+l06xc7HhfQpUu/Yb6F16N2RyXrunDYy53jLcy5kRHnZu2Rq0iiTZEd28BaXbZYXywqbkofk5mt65jlWmc84jQCs503sOCg6mqdfykp0kmzKjWBK+8Mnfa2k0Q8YZ0De+A1wohy5R7zW4ZqnRegHiuMfhXYIIcIlPEjp9zNIppaZeywI5riQtMBjaumYMNH681RnbX+2bvxYodaRmeGBlnS6+5NQNSLXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP6n6PMtouMW5lFLRkS7PvbrHiy2HM6lFBm0TC4j/iQ=;
 b=jqSpqq0j41xOmQzO2FAV3CloydGtsL6SxkiWUHva1NhYbH0g8mholubApG+taNn9+IZ4ZF4qEdwVGwhPa2BXQS7OydrsRc357HzVyq0saoP3//hUoP9DF8Hgk9k/Gt2n9LQfUXFfVwhoaKhdMsc+OLJ/bb0nlQhxlCaDsuQP6G8VlU2ZJYwzvVcnFL85gmBGJL5TwnxZliTV8sLiMOmoBIqlu5MB9o7lpV4xOLUXTvW/zb2YPnBi/vErOmdFfOTVaNLwtTeiGMwlsjfM2XCLkdTkuPLaK+ER3EuCHWHtsiIAhnfkte3C0h1GfXnPlo5OKOWoiFuvJzOCYvRkFamNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP6n6PMtouMW5lFLRkS7PvbrHiy2HM6lFBm0TC4j/iQ=;
 b=poaovlSRrK7WvIo/EOmIKPEWcYJMTo3xUfP2bA6LAE3OVzNjV0RN0AGswaLDZKNEfhUex08JAOQo+adokVckVMvJ9TxrdrUyJfH3KV94xRWg1m7BeDzQlo4DAZABhZF65hK19DdjdzpvhELVLsIr2RAoiNl3+Q5OAQX7yNvhy/dH9p0cu9PYGnRPwJkpYLUqNEXQXYe54Qn8psdS4inO8JYdYZGgxP9QH8+1ujlp3nlhJrc60krf1xEHgqhTEcMTHKpsGZtIp6ZFuPinkj8kcZr383zRXHflqgQ4TFzhaXZvIH6W8WGFYXTRd0XhUOraUb4yC7tNlXpyFVMgOzfi1g==
Received: from CH2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:610:4f::25)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 16:51:57 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::ce) by CH2PR18CA0015.outlook.office365.com
 (2603:10b6:610:4f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 16:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:51:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:37 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:36 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:35 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 07/12] virtio_net: Implement layer 2 ethtool flow rules
Date: Tue, 6 Jan 2026 10:50:25 -0600
Message-ID: <20260106165030.45726-8-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: b955505c-f5dd-453e-f0fa-08de4d43e729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1/LuWgQiyEcibSiaK6AB6fD35IlSdS/6xYje6cdY8SbnFpGp9PXnCXBpO8Gb?=
 =?us-ascii?Q?Hns8McKQvNIQ8OJrJ3b6WrxkJgLozAFcOmGMKlZDgD53z7zX/hMt2YCu+F7n?=
 =?us-ascii?Q?+dD99ZaR2wVIDSp4o/TTubz4U9g0xyONgfkSYp+pR20xL24e53aKxh9H0TNh?=
 =?us-ascii?Q?ngHOSYzll6DsnXQtCEaATA7Vun0Misb6nyo2w/j4qXFOixr/jgFYVpTEzerB?=
 =?us-ascii?Q?fGF6FWmCv1CNiFo6S0qhCIUYfiwjt1J2dLUdwLEyeGmZ2jn4EJNXrBMbaQ4B?=
 =?us-ascii?Q?MfexWH4lFfqYntwsElaEr7wx8P4oA9O7NZHu5srfWJaTPw2KtXGhM9FJyJRp?=
 =?us-ascii?Q?/qTV06clP3THyj/okVIMOvyGKSK632LnDdy8WflNG9HAclwCZX0GkNhetLHi?=
 =?us-ascii?Q?aM+aCYU5Rxw9zcjD9JL0TUNLyUC7nFYA7Bn9mIrp6vKzVUYcHL/sxz9/lV6i?=
 =?us-ascii?Q?cMWe7xNYYQ4wwyzmhzF3YZlFLW4KehT8B4eaI2vhphWzWdODYxzrMpwDpsRE?=
 =?us-ascii?Q?/sbTwHzYOrFNel/KdSrVbcHWUWCHCMF/piz5xaAdlMu/x/ebc8SBQ1xw8n2Y?=
 =?us-ascii?Q?uLoUw6K+9LF3xyD03PXNbdcCWYyWGUb2jSd1+oiIigJvjmlTOjDMDiQjldFf?=
 =?us-ascii?Q?dNw5Z6V0oZLjSpEGa36MAxoEBitlU/AXLoOQtWeiQvaGQT57Ia8pbzf7B2Ys?=
 =?us-ascii?Q?ExOAqyVVJL1YEUOaVXQoEkNGDdv0tCHDfPHsvoFaYRy+8zQH2+EwnVFgYYzA?=
 =?us-ascii?Q?xutAk+/yDo93h3559H6syf39Ye+t6UWaJlSiRzIm/VlMqsiIcpQSCwrIYx3Q?=
 =?us-ascii?Q?YL9RfeQsotdmGGknyoombT8dvHHyh88rPNmjzY0/nM3UscT9WJNhWTwzLjaz?=
 =?us-ascii?Q?+CGkSjSaCUr51W4SPndSLdElmvqDs5O/Ae0j0IbUcKUtLlYP92mA/yeOsJcp?=
 =?us-ascii?Q?Sbj90XOPGuaNEU7ZbGZFLeHBwcxGon+yzLJKx6iAEmUO/jgEv91f68DBXlFG?=
 =?us-ascii?Q?MYOGVhrVLND+9LbsX2q5t2wsR08Uon49wxDR9H9kjZIDC5/78jKf60N2PoGO?=
 =?us-ascii?Q?tsmIeqySmsLbC6bdzkHETITV8KUabviEwGPPgEqls7Fjm/kYhNkN4B/VDxD1?=
 =?us-ascii?Q?Y1tCVgn2kzALAP00MXANV1xRFcWg8bCyaJGe9h4BYBY3FN0c9wzKBW7/fhWC?=
 =?us-ascii?Q?AlBvAGx14Ao3mJxb+2kPuglubH8v8IlGNKEVuy/GRmSe9HO8NNK1CfJT9kJ7?=
 =?us-ascii?Q?e1XL6F2tWKnXGCJhB2jVHuT9psPuAGbxfzyRNHT6jYC09kaaLZXrDXgvptZe?=
 =?us-ascii?Q?jXeXv4GynIayXvDVNi4fBv92zIk01cWnnap7XFCe0lSDN5EWnO2OMtYW5uAV?=
 =?us-ascii?Q?V7uNmMSkPiCPQGVRHBlP2XrcmdlgsX52u9zASOYrJZTz/NDKcOzHc4/iLS7b?=
 =?us-ascii?Q?8aonggkd4Bza5ewtgphM8x1RGG+LJENvZyA7VEXfSKyN1G2ISJnbwKHe/VQo?=
 =?us-ascii?Q?UPLNWIhbHdW6IF4IcvPU7m7hQGlR7is0LYA4dW61u/27qwbwemP9N3c381yx?=
 =?us-ascii?Q?a5uGsF8q942JwiMSZJs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:56.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b955505c-f5dd-453e-f0fa-08de4d43e729
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capability. If partial matching is supported, the classifier mask for a
particular field can be a subset of the mask for that field in the
capability.

The rule consists of a priority, an action and a key. The key is a byte
array containing headers corresponding to the selectors in the
classifier.

This patch implements ethtool rules for ethernet headers.

Example:
$ ethtool -U ens9 flow-type ether dst 08:11:22:33:44:54 action 30
Added rule with ID 1

The rule in the example directs received packets with the specified
destination MAC address to rq 30.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed double free bug in error flows
    - Build bug on for classifier struct ordering.
    - (u8 *) to (void *) casting.
    - Documentation in UAPI
    - Answered questions about overflow with no changes.
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
v7:
    - Move for (int i -> for (i hunk from next patch. Paolo Abeni

v12:
    - Make key_size u8. MST
    - Free key in insert_rule when it's successful. MST
---
---
 drivers/net/virtio_net.c           | 464 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  50 ++++
 2 files changed, 514 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index bf6acfaeb7f0..5194596915ce 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -31,6 +31,7 @@
 #include <net/ip.h>
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
+#include <linux/xarray.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -286,6 +287,11 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
@@ -295,8 +301,16 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs);
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -5664,6 +5678,21 @@ static u32 virtnet_get_rx_ring_count(struct net_device *dev)
 	return vi->curr_queue_pairs;
 }
 
+static int virtnet_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	switch (info->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		return virtnet_ethtool_flow_insert(&vi->ff, &info->fs,
+						   vi->curr_queue_pairs);
+	case ETHTOOL_SRXCLSRLDEL:
+		return virtnet_ethtool_flow_remove(&vi->ff, info->fs.location);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const struct ethtool_ops virtnet_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_MAX_FRAMES |
 		ETHTOOL_COALESCE_USECS | ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
@@ -5690,6 +5719,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rx_ring_count = virtnet_get_rx_ring_count,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
@@ -5787,6 +5817,429 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
 };
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* The classifier struct must be the last field in this struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
+
+static_assert(sizeof(struct virtnet_classifier) ==
+	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+		    __alignof__(struct virtnet_classifier)),
+	      "virtnet_classifier: classifier must be the last member");
+
+static bool check_mask_vs_cap(const void *m, const void *c,
+			      u16 len, bool partial)
+{
+	const u8 *mask = m;
+	const u8 *cap = c;
+	int i;
+
+	for (i = 0; i < len; i++) {
+		if (partial && ((mask[i] & cap[i]) != mask[i]))
+			return false;
+		if (!partial && mask[i] != cap[i])
+			return false;
+	}
+
+	return true;
+}
+
+static
+struct virtio_net_ff_selector *get_selector_cap(const struct virtnet_ff *ff,
+						u8 selector_type)
+{
+	struct virtio_net_ff_selector *sel;
+	void *buf;
+	int i;
+
+	buf = &ff->ff_mask->selectors;
+	sel = buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = buf;
+	}
+
+	return NULL;
+}
+
+static bool validate_eth_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ethhdr *cap, *mask;
+	struct ethhdr zeros = {};
+
+	cap = (struct ethhdr *)&sel_cap->mask;
+	mask = (struct ethhdr *)&sel->mask;
+
+	if (memcmp(&zeros.h_dest, mask->h_dest, sizeof(zeros.h_dest)) &&
+	    !check_mask_vs_cap(mask->h_dest, cap->h_dest,
+			       sizeof(mask->h_dest), partial_mask))
+		return false;
+
+	if (memcmp(&zeros.h_source, mask->h_source, sizeof(zeros.h_source)) &&
+	    !check_mask_vs_cap(mask->h_source, cap->h_source,
+			       sizeof(mask->h_source), partial_mask))
+		return false;
+
+	if (mask->h_proto &&
+	    !check_mask_vs_cap(&mask->h_proto, &cap->h_proto,
+			       sizeof(__be16), partial_mask))
+		return false;
+
+	return true;
+}
+
+static bool validate_mask(const struct virtnet_ff *ff,
+			  const struct virtio_net_ff_selector *sel)
+{
+	struct virtio_net_ff_selector *sel_cap = get_selector_cap(ff, sel->type);
+
+	if (!sel_cap)
+		return false;
+
+	switch (sel->type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return validate_eth_mask(ff, sel, sel_cap);
+	}
+
+	return false;
+}
+
+static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+{
+	int err;
+
+	err = xa_alloc(&ff->classifiers, &c->id, c,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		return err;
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+				      c->id,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &c->classifier,
+				      c->size);
+	if (err)
+		goto err_xarray;
+
+	return 0;
+
+err_xarray:
+	xa_erase(&ff->classifiers, c->id);
+
+	return err;
+}
+
+static void destroy_classifier(struct virtnet_ff *ff,
+			       u32 classifier_id)
+{
+	struct virtnet_classifier *c;
+
+	c = xa_load(&ff->classifiers, classifier_id);
+	if (c) {
+		virtio_admin_obj_destroy(ff->vdev,
+					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					 c->id,
+					 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+					 0);
+
+		xa_erase(&ff->classifiers, c->id);
+		kfree(c);
+	}
+}
+
+static void destroy_ethtool_rule(struct virtnet_ff *ff,
+				 struct virtnet_ethtool_rule *eth_rule)
+{
+	ff->ethtool.num_rules--;
+
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				 eth_rule->flow_spec.location,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	destroy_classifier(ff, eth_rule->classifier_id);
+	kfree(eth_rule);
+}
+
+static int insert_rule(struct virtnet_ff *ff,
+		       struct virtnet_ethtool_rule *eth_rule,
+		       u32 classifier_id,
+		       const u8 *key,
+		       u8 key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule)
+		return -ENOMEM;
+
+	/* Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       cpu_to_le16(fs->ring_cookie) : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_admin_obj_create(ff->vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				      fs->location,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      ff_rule,
+				      sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+	kfree(key);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+
+	return err;
+}
+
+static u32 flow_type_mask(u32 flow_type)
+{
+	return flow_type & ~(FLOW_EXT | FLOW_MAC_EXT | FLOW_RSS);
+}
+
+static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
+{
+	switch (fs->flow_type) {
+	case ETHER_FLOW:
+		return true;
+	}
+
+	return false;
+}
+
+static int validate_flow_input(struct virtnet_ff *ff,
+			       const struct ethtool_rx_flow_spec *fs,
+			       u16 curr_queue_pairs)
+{
+	/* Force users to use RX_CLS_LOC_ANY - don't allow specific locations */
+	if (fs->location != RX_CLS_LOC_ANY)
+		return -EOPNOTSUPP;
+
+	if (fs->ring_cookie != RX_CLS_FLOW_DISC &&
+	    fs->ring_cookie >= curr_queue_pairs)
+		return -EINVAL;
+
+	if (fs->flow_type != flow_type_mask(fs->flow_type))
+		return -EOPNOTSUPP;
+
+	if (!supported_flow_type(fs))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
+				 u8 *key_size, size_t *classifier_size,
+				 int *num_hdrs)
+{
+	*num_hdrs = 1;
+	*key_size = sizeof(struct ethhdr);
+	/*
+	 * The classifier size is the size of the classifier header, a selector
+	 * header for each type of header in the match criteria, and each header
+	 * providing the mask for matching against.
+	 */
+	*classifier_size = *key_size +
+			   sizeof(struct virtio_net_resource_obj_ff_classifier) +
+			   sizeof(struct virtio_net_ff_selector) * (*num_hdrs);
+}
+
+static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
+				   u8 *key,
+				   const struct ethtool_rx_flow_spec *fs)
+{
+	struct ethhdr *eth_m = (struct ethhdr *)&selector->mask;
+	struct ethhdr *eth_k = (struct ethhdr *)key;
+
+	selector->type = VIRTIO_NET_FF_MASK_TYPE_ETH;
+	selector->length = sizeof(struct ethhdr);
+
+	memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
+	memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
+}
+
+static int
+validate_classifier_selectors(struct virtnet_ff *ff,
+			      struct virtio_net_resource_obj_ff_classifier *classifier,
+			      int num_hdrs)
+{
+	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
+	int i;
+
+	for (i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (((void *)selector) + sizeof(*selector) +
+					selector->length);
+	}
+
+	return 0;
+}
+
+static int build_and_insert(struct virtnet_ff *ff,
+			    struct virtnet_ethtool_rule *eth_rule)
+{
+	struct virtio_net_resource_obj_ff_classifier *classifier;
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_ff_selector *selector;
+	struct virtnet_classifier *c;
+	size_t classifier_size;
+	int num_hdrs;
+	u8 key_size;
+	u8 *key;
+	int err;
+
+	calculate_flow_sizes(fs, &key_size, &classifier_size, &num_hdrs);
+
+	key = kzalloc(key_size, GFP_KERNEL);
+	if (!key)
+		return -ENOMEM;
+
+	/*
+	 * virtio_net_ff_obj_ff_classifier is already included in the
+	 * classifier_size.
+	 */
+	c = kzalloc(classifier_size +
+		    sizeof(struct virtnet_classifier) -
+		    sizeof(struct virtio_net_resource_obj_ff_classifier),
+		    GFP_KERNEL);
+	if (!c) {
+		kfree(key);
+		return -ENOMEM;
+	}
+
+	c->size = classifier_size;
+	classifier = &c->classifier;
+	classifier->count = num_hdrs;
+	selector = (void *)&classifier->selectors[0];
+
+	setup_eth_hdr_key_mask(selector, key, fs);
+
+	err = validate_classifier_selectors(ff, classifier, num_hdrs);
+	if (err)
+		goto err_key;
+
+	err = setup_classifier(ff, c);
+	if (err)
+		goto err_classifier;
+
+	err = insert_rule(ff, eth_rule, c->id, key, key_size);
+	if (err) {
+		/* destroy_classifier will free the classifier */
+		destroy_classifier(ff, c->id);
+		goto err_key;
+	}
+
+	return 0;
+
+err_classifier:
+	kfree(c);
+err_key:
+	kfree(key);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				       struct ethtool_rx_flow_spec *fs,
+				       u16 curr_queue_pairs)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	err = validate_flow_input(ff, fs, curr_queue_pairs);
+	if (err)
+		return err;
+
+	eth_rule = kzalloc(sizeof(*eth_rule), GFP_KERNEL);
+	if (!eth_rule)
+		return -ENOMEM;
+
+	err = xa_alloc(&ff->ethtool.rules, &fs->location, eth_rule,
+		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->rules_limit) - 1),
+		       GFP_KERNEL);
+	if (err)
+		goto err_rule;
+
+	eth_rule->flow_spec = *fs;
+
+	err = build_and_insert(ff, eth_rule);
+	if (err)
+		goto err_xa;
+
+	return err;
+
+err_xa:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+
+err_rule:
+	fs->location = RX_CLS_LOC_ANY;
+	kfree(eth_rule);
+
+	return err;
+}
+
+static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
+{
+	struct virtnet_ethtool_rule *eth_rule;
+	int err = 0;
+
+	if (!ff->ff_supported)
+		return -EOPNOTSUPP;
+
+	eth_rule = xa_load(&ff->ethtool.rules, location);
+	if (!eth_rule) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	destroy_ethtool_rule(ff, eth_rule);
+out:
+	return err;
+}
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -5962,6 +6415,8 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -5986,9 +6441,18 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 {
+	struct virtnet_ethtool_rule *eth_rule;
+	unsigned long i;
+
 	if (!ff->ff_supported)
 		return;
 
+	xa_for_each(&ff->ethtool.rules, i, eth_rule)
+		destroy_ethtool_rule(ff, eth_rule);
+
+	xa_destroy(&ff->ethtool.rules);
+	xa_destroy(&ff->classifiers);
+
 	virtio_admin_obj_destroy(ff->vdev,
 				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 0401e8fdc7a8..db47553773bd 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
@@ -101,4 +103,52 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+/**
+ * struct virtio_net_resource_obj_ff_classifier - Flow filter classifier object
+ * @count: number of selector entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of selector descriptors that define match masks
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER administrative object.
+ * Each selector describes a header mask used to match packets
+ * (see struct virtio_net_ff_selector). Selectors appear in the order they are
+ * to be applied.
+ */
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+
+/**
+ * struct virtio_net_resource_obj_ff_rule - Flow filter rule object
+ * @group_id: identifier of the target flow filter group
+ * @classifier_id: identifier of the classifier referenced by this rule
+ * @rule_priority: relative priority of this rule within the group
+ * @key_length: number of bytes in @keys
+ * @action: action to perform, one of VIRTIO_NET_FF_ACTION_*
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @vq_index: RX virtqueue index for VIRTIO_NET_FF_ACTION_RX_VQ, 0 otherwise
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @keys: concatenated key bytes matching the classifier's selectors order
+ *
+ * Payload for the VIRTIO_NET_RESOURCE_OBJ_FF_RULE administrative object.
+ * @group_id and @classifier_id refer to previously created objects of types
+ * VIRTIO_NET_RESOURCE_OBJ_FF_GROUP and VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER
+ * respectively. The key bytes are compared against packet headers using the
+ * masks provided by the classifier's selectors. Multi-byte fields are
+ * little-endian.
+ */
+struct virtio_net_resource_obj_ff_rule {
+	__le32 group_id;
+	__le32 classifier_id;
+	__u8 rule_priority;
+	__u8 key_length; /* length of key in bytes */
+	__u8 action;
+	__u8 reserved;
+	__le16 vq_index;
+	__u8 reserved1[2];
+	__u8 keys[];
+};
+
 #endif
-- 
2.50.1


