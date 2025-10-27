Return-Path: <netdev+bounces-233276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766DCC0FB80
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2544B18820FE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E431A55F;
	Mon, 27 Oct 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nVomlD/L"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC63191A8
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586855; cv=fail; b=agqZ94X8DKWsJm7q4OkjL8C9cgtYsuz7Lm2PFGEOPra/0Dac3GS+uO9ja2EsssPDQKOjHwkMDZ1SRYMte0wkpz/xt4lyfY7Uz1xqaJwIRulfwESQaP3uGJREzj11vg9S9W4rYDTix2lL2Q9irX50BBDSzl1N3Ptx31YYKgELlC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586855; c=relaxed/simple;
	bh=GT8e3QlbvPfz3XXn84mC4w366D+LwrYH4oD3mUznSuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxkYtdfcwb80eazdeMo12zDJtJpmOCWW/owIeasIx6SmDidjcJutI0Q18ZxBkV04zjKZM35nYKNAPGNOAQbpa8kWy8/b8oLotvS6no0UPiQovl+015dpJ+GNoFUf0q7uiEHfnE+91/2I0LaVq6x7Y109Zf03YNqjeiCRodTZsI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nVomlD/L; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wI/Ki4RnDQROcAkR+K5O78RUvgpiAUWhG4QihJQoOTFsIupta4P1vsL9jqkYvlJQyolc3IXvGtNjqpo0TfasQarIwW4XNo+qTjaNA271dZ1nArOlxUyGF26gj+rieCwf7C5C5yLr9TF7/B0AHjIKQxetEEr8aSeJJOC3jHM3nLiE2HEAtxdsDnKzXs1Do1GgrPrexm8n405sYMcDbn/hIQigHBj7/Op/2wmsKZgnBXQ/zheP79pfRdMftJrBzM0SuiIN8h3BkP1Lgd/ocKivAZ1o4prvdgaWoQ/eS4SutiqX7dxLxj2AxAQSr5cN86mQyQkPqM1TtNnJ7lIl3ywUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKYhiiXDmKFue2NzcI5BaXqXj0N+hRbhNhtv0c5wcHw=;
 b=EgHrORjwbeyyY6jCm9VgqNJb3PTQ5RnuXmRbpJEVS1kD99JLqu9FOB/JG8rmArT2HcPDb4NrFgmKbv3bb8uDD3e4SpFVbdJ2V8TWi5x274rZiES+IuNAj7rRprw4U3TgBJPtychHLw+WArIbNyEoP9DLGl0yWKA1DZgpO18Dq4wXr6AnIjc7pgKnKpoR+5ZC405DumeeUn8QhORm1yG6VyJ/VSbqfeDR7V2qatuGnuxhbFG76B+ipj9ooJWzDXqPmcq6A5RFv9smYNogaxDbjRImooRhTj+dZxgHO1YqvhWLOKyziu+1YPKpb7cOgwSYtYvecacN7PDjGdnR8WWrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKYhiiXDmKFue2NzcI5BaXqXj0N+hRbhNhtv0c5wcHw=;
 b=nVomlD/LVi3wGX9GdX6S8I9n+OFb3y/rzKLbfTKEojeOV7w/I/X3w2TcAR6FWsAjZcO7jmOvNL57Y75MP7pRlS3z0DetdrZiYaxd5RjGg42iNSAlPwKAh+fHwdwbaU/JjONxOxHZDdaJ0z5wl2q/0+cJ9W7C04BB/OkjgM58Z+mjkzDP3iMmABCvW8dfq++sFYg0drfFhSN+V8MajVsiwtRGCLPTxt3iE8rXURePfreLvxf/KpJgDH/oBxTvQuwRNZvAnflbooeZ8FkzUQdPjjZ0EAmvh9lykpHvhDAdiTZ86r5LaG1ZiZL823Tku+avDElIhHJ1r7GWlFBPn+UkHA==
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.16; Mon, 27 Oct 2025 17:40:41 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::88) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 10:40:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:16 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:15 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 05/12] virtio_net: Query and set flow filter caps
Date: Mon, 27 Oct 2025 12:39:50 -0500
Message-ID: <20251027173957.2334-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8f1a21-b1d6-4a5a-cca1-08de157ff2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mfF/qQdrq/WVXFpffdTFK5AoWzooVa/x/+vMqL/YHd6TXlc9jlqQ49LoAByI?=
 =?us-ascii?Q?eQXcrwnk2qid5DNo5sMO6T/YGu+5vgZNJUpMktYX4dXStGB6VqCqHWZJj9bT?=
 =?us-ascii?Q?OJXjDUt3wSO5iLmBpC2RTQx671do3f4/V6FrK/Q7WA+w6yRZqMJDaCt+wihW?=
 =?us-ascii?Q?bcsX5u+1CJTd+Q1WpgOul71J0fX8DrrDwyFooJZY66ubMTEZLhY5l4voIEoJ?=
 =?us-ascii?Q?727OgJTNmXqCydLuA7lEJ2b9oKgJpCcFK5G6ppcFN0PZ8K8iqO8wTdJI8YAz?=
 =?us-ascii?Q?kFXRu+EvzvAVJliCmjw6dv4vNR4QPfXMXCg0ziB+zx3PDiNeyLetrhSeMBft?=
 =?us-ascii?Q?Q9hDrxE4XOhRN6fNvWrkfh5/MaG3cP9/1W9q75lCEwTOU6q+WXBLDvs38l0F?=
 =?us-ascii?Q?T067F9YdQuW2nRhpD2gGnAfvAAn2SPcnw6XrjTjsGS4RcxP2oxUHhq5ts7eH?=
 =?us-ascii?Q?akOIDtQRvmRme0mzzSPWt55tNlfwCid3u2VQtYD/wh6iZWUaqGga/F/8/B/n?=
 =?us-ascii?Q?U1+I4Au+eqWCzk0OGZhcukEZ6vV6F3RP4xYb1jBazRy4saiVsHPqLANvDiI7?=
 =?us-ascii?Q?+e7ciFxk/Yrfb/vmWd2QK23DrrssoWkO2JSHZrUZOUxe+Hm7JXrSo3HQfuOC?=
 =?us-ascii?Q?SBMc4AbRdL4WwnNVBW8uQym6OqW3SFun90Uv6jaasRlcfqNsw1q96Q9sZ7ke?=
 =?us-ascii?Q?7t/YIBKIFAO2cvXjJm21Ul0IerGx2mLWByc4juTKRn+Qntl3EzOam0VTPW11?=
 =?us-ascii?Q?ESaxJ2il1epp1r76nbDv5A30dpRydc16ysoZTMx/c6B+34kZjQkYPBwP4NrX?=
 =?us-ascii?Q?uXAknYBr5OS7/Pr5zZ0m0ZpmukzmiebQAirb4seXIi4S54t+d7egoowC7F/L?=
 =?us-ascii?Q?NopmosivvkDk0bsf56OJpluYUAknSwjbu6JZW0L35nVanTOxXqU5OvDTBulI?=
 =?us-ascii?Q?d5hrLrKV1/NZwvgOmDT2s9LlE381HRAOFnp94swjaKETkfhKRLZ+8yEVgiee?=
 =?us-ascii?Q?E9Kw1beMCrsT2F56yroQQj9OGoMnol+P9AnhQxpAsCfbUzoPjZC4rC046P55?=
 =?us-ascii?Q?5/3ofdsys28Griy/o769YytZQJG8VJ/jpGx0UyeAZwrhGRzo8jRR+xptekVd?=
 =?us-ascii?Q?Uj0C+K8lVCf0r3tBmVPZCJHaM5yMW0sSdwaO+9f3Im0/FnKTfA9N3qquMPuh?=
 =?us-ascii?Q?JY73GUmG5k5WBKgl4EC1zcjovBoakLe6JauLPnHtDbWS3IwNREn2Uu+/1R6v?=
 =?us-ascii?Q?J6Zh7IvDNU7NefT6PYrQ1FnHE5cnI8vySlgnOx46mjjkl0j6lhsKstHqI38B?=
 =?us-ascii?Q?Jd7QY2Scde3zonaZQHkKYX2J7FwAE37Bjyijhdg6SvZSWGx7WmGn81zpWKZl?=
 =?us-ascii?Q?4K6hgRWismIVDd8GjNkSVW2izmzu0HLdX10Z+V73iJr40pKh86PE6aLVWvsR?=
 =?us-ascii?Q?FY0/mYx0WrvhUdt5WJPz+/L5q4NKJmYwP4b//eX1ChU5k/HdooBEn79meww1?=
 =?us-ascii?Q?K6U8lVuObEN+op/odbdzQ9nTqdYl7K6w9tXaQo/WrfCtKCI2IpTw0zbbT+MK?=
 =?us-ascii?Q?rRxoREmrAJBkJjfezrY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:41.0208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f1a21-b1d6-4a5a-cca1-08de157ff2ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4:
    - Validate the length in the selector caps
    - Removed __free usage.
    - Removed for(int.
v5:
    - Remove unneed () after MAX_SEL_LEN macro (test bot)
v6:
    - Fix sparse warning "array of flexible structures" Jakub K/Simon H
    - Use new variable and validate ff_mask_size before set_cap. MST
---
 drivers/net/virtio_net.c           | 171 +++++++++++++++++++++++++++++
 include/linux/virtio_admin.h       |   1 +
 include/uapi/linux/virtio_net_ff.h |  91 +++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a757cbcab87f..a9fde879fdbf 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,9 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -281,6 +284,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+struct virtnet_ff {
+	struct virtio_device *vdev;
+	bool ff_supported;
+	struct virtio_net_ff_cap_data *ff_caps;
+	struct virtio_net_ff_cap_mask_data *ff_mask;
+	struct virtio_net_ff_actions *ff_actions;
+};
+
 #define VIRTNET_Q_TYPE_RX 0
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
@@ -493,6 +504,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtnet_ff ff;
 };
 
 struct padded_vnet_hdr {
@@ -6753,6 +6766,160 @@ static const struct xdp_metadata_ops virtnet_xdp_metadata_ops = {
 	.xmo_rx_hash			= virtnet_xdp_rx_hash,
 };
 
+static size_t get_mask_size(u16 type)
+{
+	switch (type) {
+	case VIRTIO_NET_FF_MASK_TYPE_ETH:
+		return sizeof(struct ethhdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
+		return sizeof(struct iphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return sizeof(struct ipv6hdr);
+	case VIRTIO_NET_FF_MASK_TYPE_TCP:
+		return sizeof(struct tcphdr);
+	case VIRTIO_NET_FF_MASK_TYPE_UDP:
+		return sizeof(struct udphdr);
+	}
+
+	return 0;
+}
+
+#define MAX_SEL_LEN (sizeof(struct ipv6hdr))
+
+static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return;
+
+	err = virtio_admin_cap_id_list_query(vdev, cap_id_list);
+	if (err)
+		goto err_cap_list;
+
+	if (!(VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_RESOURCE_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_SELECTOR_CAP) &&
+	      VIRTIO_CAP_IN_LIST(cap_id_list,
+				 VIRTIO_NET_FF_ACTION_CAP)))
+		goto err_cap_list;
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps)
+		goto err_cap_list;
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask)
+		goto err_ff;
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
+
+	if (err)
+		goto err_ff_mask;
+
+	ff->ff_actions = kzalloc(sizeof(*ff->ff_actions) +
+					VIRTIO_NET_FF_ACTION_MAX,
+					GFP_KERNEL);
+	if (!ff->ff_actions)
+		goto err_ff_mask;
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+	if (err)
+		goto err_ff_action;
+
+	real_ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data);
+	sel = (void *)&ff->ff_mask->selectors[0];
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->length > MAX_SEL_LEN) {
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	if (real_ff_mask_size > ff_mask_size) {
+		err = -EINVAL;
+		goto err_ff_action;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   ff_mask_size);
+	if (err)
+		goto err_ff_action;
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_ACTION_CAP,
+				   ff->ff_actions,
+				   sizeof(*ff->ff_actions) + VIRTIO_NET_FF_ACTION_MAX);
+	if (err)
+		goto err_ff_action;
+
+	ff->vdev = vdev;
+	ff->ff_supported = true;
+
+	kfree(cap_id_list);
+
+	return;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+err_ff_mask:
+	kfree(ff->ff_mask);
+err_ff:
+	kfree(ff->ff_caps);
+err_cap_list:
+	kfree(cap_id_list);
+}
+
+static void virtnet_ff_cleanup(struct virtnet_ff *ff)
+{
+	if (!ff->ff_supported)
+		return;
+
+	kfree(ff->ff_actions);
+	kfree(ff->ff_mask);
+	kfree(ff->ff_caps);
+}
+
 static int virtnet_probe(struct virtio_device *vdev)
 {
 	int i, err = -ENOMEM;
@@ -7116,6 +7283,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	virtnet_ff_init(&vi->ff, vi->vdev);
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7131,6 +7300,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7180,6 +7350,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 039b996f73ec..db0f42346ca9 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -3,6 +3,7 @@
  * Header file for virtio admin operations
  */
 #include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 #ifndef _LINUX_VIRTIO_ADMIN_H
 #define _LINUX_VIRTIO_ADMIN_H
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..bd7a194a9959
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#define VIRTIO_NET_FF_RESOURCE_CAP 0x800
+#define VIRTIO_NET_FF_SELECTOR_CAP 0x801
+#define VIRTIO_NET_FF_ACTION_CAP 0x802
+
+/**
+ * struct virtio_net_ff_cap_data - Flow filter resource capability limits
+ * @groups_limit: maximum number of flow filter groups supported by the device
+ * @classifiers_limit: maximum number of classifiers supported by the device
+ * @rules_limit: maximum number of rules supported device-wide across all groups
+ * @rules_per_group_limit: maximum number of rules allowed in a single group
+ * @last_rule_priority: priority value associated with the lowest-priority rule
+ * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
+ *
+ * The limits are reported by the device and describe resource capacities for
+ * flow filters. Multi-byte fields are little-endian.
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+};
+
+/**
+ * struct virtio_net_ff_selector - Selector mask descriptor
+ * @type: selector type, one of VIRTIO_NET_FF_MASK_TYPE_* constants
+ * @flags: selector flags, see VIRTIO_NET_FF_MASK_F_* constants
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @length: size in bytes of @mask
+ * @reserved1: must be set to 0 by the driver and ignored by the device
+ * @mask: variable-length mask payload for @type, length given by @length
+ *
+ * A selector describes a header mask that a classifier can apply. The format
+ * of @mask depends on @type.
+ */
+struct virtio_net_ff_selector {
+	__u8 type;
+	__u8 flags;
+	__u8 reserved[2];
+	__u8 length;
+	__u8 reserved1[3];
+	__u8 mask[];
+};
+
+#define VIRTIO_NET_FF_MASK_TYPE_ETH  1
+#define VIRTIO_NET_FF_MASK_TYPE_IPV4 2
+#define VIRTIO_NET_FF_MASK_TYPE_IPV6 3
+#define VIRTIO_NET_FF_MASK_TYPE_TCP  4
+#define VIRTIO_NET_FF_MASK_TYPE_UDP  5
+#define VIRTIO_NET_FF_MASK_TYPE_MAX  VIRTIO_NET_FF_MASK_TYPE_UDP
+
+/**
+ * struct virtio_net_ff_cap_mask_data - Supported selector mask formats
+ * @count: number of entries in @selectors
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @selectors: array of supported selector descriptors
+ */
+struct virtio_net_ff_cap_mask_data {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 selectors[];
+};
+#define VIRTIO_NET_FF_MASK_F_PARTIAL_MASK (1 << 0)
+
+#define VIRTIO_NET_FF_ACTION_DROP 1
+#define VIRTIO_NET_FF_ACTION_RX_VQ 2
+#define VIRTIO_NET_FF_ACTION_MAX  VIRTIO_NET_FF_ACTION_RX_VQ
+/**
+ * struct virtio_net_ff_actions - Supported flow actions
+ * @count: number of supported actions in @actions
+ * @reserved: must be set to 0 by the driver and ignored by the device
+ * @actions: array of action identifiers (VIRTIO_NET_FF_ACTION_*)
+ */
+struct virtio_net_ff_actions {
+	__u8 count;
+	__u8 reserved[7];
+	__u8 actions[];
+};
+#endif
-- 
2.50.1


