Return-Path: <netdev+bounces-247401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F3CF97D5
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6502930F6EDA
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16831337B8E;
	Tue,  6 Jan 2026 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jB54V/NN"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7023EA8A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718325; cv=fail; b=cDZuAAfTa00xltTBwmFTioj5tEd8vAu8Oztw2KlsIbrUARyQmBMrv9XK4mLTLyBbvQNIP5ja/p4DGsggLWoE1SSiZaQvLUOlJzlU+k9VQwu29PLPecZt2wJxkFNTPI/YAXspp5FYyrr414HBdAqNjNllIaDLwTiDLVJv/A+t4es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718325; c=relaxed/simple;
	bh=akWnnBocRy9Ouq/spiazXEf73U9vlfv3Bzx/9KEQchI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4uCqLWsYWr7WPDkc8fSO2yswKqwL2+F4MB5BkTZOR7T0Nx/hL3jenXuWk4kuSzxQHMVt9gKZ6FChYT+x+ul8lpdKIYQYJwZvTTMvX5dCXNXqlfgQI1PRCewCLcUw6ZSDvfUVFdqzZ1cg/QubjtEcrYzDnso4xYi4xGor4uK87Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jB54V/NN; arc=fail smtp.client-ip=40.93.196.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvJxmPkkmaRjuoZ6pR/oOAXdZAiqOMvsGB9+CESlLlK76HCrFRdKtqnwvqa1k70zaDcjzonUbLfPtLphQLuCFo9w7VP5lBKNc/xVpWW1lTxrYSkrZJBZl0cHH/gWDzo0wTtEpZTxzPKH3Lu/3oLTDfSbQol2Jf3K4HwGhroXXb2IB9KcU45Jjq9AIbwnUhV5NI6fXdwlucmBgpRpR5yA37m4QqqeeZ0MowEgVmlQQz/+8ipHXsN1Smt0tvaXZtkCWqMiMU9XteqkjmHOfRwDxjKYXMRCTe3UxsTRuTVafFdsCJ74O5RTDuDRI2VbNRsl5HLKx82l2+2o8ddBq6i+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4p/shVCCrdPGgkRXj5wYqg7F3Dc3bhLMkZdaVS0+QoU=;
 b=Lg+b8uTpL4BQ2aKimPiEww78V0ssWImhTzwDO5YLuyPFX2GgKQYxQ4Cunn7SjbD0GltYj3iQFHMZjO1ggsIN5WIBB9Mm1e09Sby7o6vnRtsG4r53/93nC+uZD/mRr7KSCf6kz41LRyVDKKM4XL0GESdDF6YPFKm2YCVYyWTOeShwXzbHJgHNo+UiH9+j+F142lflGEaofNMgRrehmRE6u1HfIvFeEoS3PU+uq0hq8b9CY2Shs2LFtqjjDBLO/iPMgcSO+iRKq6uohl4T8cGpxjNv8ZRHllpV9500iCO0uoFUc9zIUWFluhLx2JriTqhS+4w1mNnN2PVe/b9nc+Cobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p/shVCCrdPGgkRXj5wYqg7F3Dc3bhLMkZdaVS0+QoU=;
 b=jB54V/NNpLtwiMfObe1YRqSHBSUfuJEVdzTIS6nh9JmdmIt3gg77A2wfema4mnpBbOSwPrK5VdfyuXwO75Pm3fc5IH3bJr1JZF1OigEGE86QJm9dBjuP2qDVn5BGxg8oH08yPl3zXRgzoYl/eLsEgUNRehvJ2DvIxG9JUV0aDFaBtJekeq1SZZYNvofeurpxVpcKh9ztyMQpdq1wF39eRMLyulcuxAw7MxljxfAbL4wXGeNKoDcc32tuTcnzx0XTHSP09F/JYfBp3VyEsw/n1UKsDQVsqN+tY+9QB9x06+j6vwEWd0r3eVgjiN1aACZqHR7hygfBa3tf3myQ3oUIgQ==
Received: from CH2PR18CA0029.namprd18.prod.outlook.com (2603:10b6:610:4f::39)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:54 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:4f:cafe::f3) by CH2PR18CA0029.outlook.office365.com
 (2603:10b6:610:4f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 16:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:51:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:32 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:32 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:30 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 05/12] virtio_net: Query and set flow filter caps
Date: Tue, 6 Jan 2026 10:50:23 -0600
Message-ID: <20260106165030.45726-6-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 1153ffab-cfd8-4da8-fc5c-08de4d43e589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N2rPnL9a0Iw6+GXQ+CJphZ7TEbpAwxK3Xv2Cx0iuc5qnhEAsqLkqUc2H2Z/f?=
 =?us-ascii?Q?yGQ0+WOOYTUGviLw8jPYfH1k8d6diXtgs3aHSM2Mp5AUVnddidFcIgpVwJdb?=
 =?us-ascii?Q?q7MY0SRv864rGGusAowB4KenRCoEnLQF7aCuomLsPga5FZAQHFjkfNCOk+Zk?=
 =?us-ascii?Q?yf8gnzr36Y6yQgaOFRaq8IV/tUglRb9hcWfvCT34kMWF9RUo2DyC6DY01/Xm?=
 =?us-ascii?Q?cZYzX9CUYJxhJmOyPXqNScanSuofB0dO3RacT4PSjgGqAeSWXiEtjzUQwwdM?=
 =?us-ascii?Q?otqQncLTdq+8+Iv3/V3U4JFxAm8cf0nLmkpvv8NId/Gnvcq3QPn3VG+oppNg?=
 =?us-ascii?Q?Dg7DVH2K98E1bu7Y24qLty+OgbzJ9QKlDGl+rUl7dFsvXT1Uv0RGylMGw4cy?=
 =?us-ascii?Q?uuClinCtn4wR7AkoQnq1w4uxeeF/hTlTw/aTNW4w90iy9xQG6SoqTuqf13Fu?=
 =?us-ascii?Q?uTEDFtjcHjzFhyEH7bw4o1RTWNGt/fXr7hnGBA0/uXHOrql/mA7NPSSI5wqM?=
 =?us-ascii?Q?sC+g8dy9i91uQS9dmiEJfaF2AGgokv8lIQFj/AYIJ8YuYfNOOU2k2pzRBNZd?=
 =?us-ascii?Q?ySyQjwJrygOJpN6VgcCboWKyVSHWbLEJOD6HoztxQ3+5uyB9l1YwPQUE0hGF?=
 =?us-ascii?Q?nKm0Gt88vz3eY8+tw1NIw8szPr4AEOz1EcKCWrO3EqTVEhGPtGLaO0klSqWU?=
 =?us-ascii?Q?18IY/WPYv7So5ZQGlLco/Es3xOnvl5+UPUz1S1LfitluVmRgKvotNwO6DWgr?=
 =?us-ascii?Q?q8LVluh1JxkaANmFlIRh8EahtEyuXCBbfwl3LJ5XrbnzaLwS2FMyF8QfQSF2?=
 =?us-ascii?Q?pOE8nZBbrsyMnabzHHGabVM+MYbAr0zFxV7xhdGxh5HOt2qVK8ZTYRjCXrO7?=
 =?us-ascii?Q?XNqrfo8yrVuwqO9hjaVBVXqUeUPevkWlmdMSj2aYjEnQ0bVscUlgDyATsxUV?=
 =?us-ascii?Q?42Harl+4Um32VX6vR21ZGmD6YrLCnk/0QcCVbG6V83wbMw2tgUTm7Y2RdGgq?=
 =?us-ascii?Q?c1Y34ACLBayp8wKZp0LbECYcXzw44I8KVyu4GK0ZScuwqwEQxjwbCr+tLlLS?=
 =?us-ascii?Q?Gx2rChBvfBQDrDr5qN+0NpbJ1DPwAafqEw8gizmqxvoSSMzO0X0z8T3/5UOZ?=
 =?us-ascii?Q?KqCE2L2nk1R7RBZE51BJ6ANseF4jKV9rM5HdFooTdwAY6oIkhUnRMovPkRyn?=
 =?us-ascii?Q?1Gg+feJnFKSxp6k4sZWjN7chcUg+S0lj8ZiHBlx4Li7aHGUnBkcFe/3CH2ey?=
 =?us-ascii?Q?Rg12b+UrmBC89IswmKvHAYe7wEJfoMXM0PJJbFc8G4s9ZFSOx7bDPkJsssvF?=
 =?us-ascii?Q?7GTtdu9VRss8/VLKJGbG3DC8AFI3sqV5qYTSkbs/W+GSXQ1RKPcs6wtrVXus?=
 =?us-ascii?Q?l/rZu6a1iYd1thcwOfnXBO2d3SV+hy/1O1uNrzu8Kzo5WbsT2g89XVGM9VHc?=
 =?us-ascii?Q?7kophkCb3lB1wfVU2MeP8yAjmRz+ljf6luoAh+LNPBH8ywsH1HYjkeAnOg3F?=
 =?us-ascii?Q?crAadYZq0hlI45TeO2hEtfgi8ucqH61oCvWvJDOWV+9PAEISNkQ53pePorR0?=
 =?us-ascii?Q?ySXC8aNUJzw0HTS8w/M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:54.0927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1153ffab-cfd8-4da8-fc5c-08de4d43e589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788

When probing a virtnet device, attempt to read the flow filter
capabilities. In order to use the feature the caps must also
be set. For now setting what was read is sufficient.

This patch adds uapi definitions virtio_net flow filters define in
version 1.4 of the VirtIO spec.

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
v7:
    - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abeni
    - Return errors from virtnet_ff_init, -ENOTSUPP is not fatal. Xuan

v8:
    - Use real_ff_mask_size when setting the selector caps. Jason Wang

v9:
    - Set err after failed memory allocations. Simon Horman

v10:
    - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
      Jason/Paolo.

v11:
    - Return -EINVAL if any resource limit is 0. Simon Horman
    - Ensure we don't overrun alloced space of ff->ff_mask by moving the
      real_ff_mask_size > ff_mask_size check into the loop. Simon Horman

v12:
    - Move uapi includes to virtio_net.c vs header file. MST
    - Remove kernel.h header in virtio_net_ff uapi. MST
    - WARN_ON_ONCE in error paths validating selectors. MST
    - Move includes from .h to .c files. MST
    - Add WARN_ON_ONCE if obj_destroy fails. MST
    - Comment cleanup in virito_net_ff.h uapi. MST
    - Add 2 byte pad to the end of virtio_net_ff_cap_data.
      https://lore.kernel.org/virtio-comment/20251119044029-mutt-send-email-mst@kernel.org/T/#m930988a5d3db316c68546d8b61f4b94f6ebda030
    - Cleanup and reinit in the freeze/restore path. MST

v13:
    - Added /* private: */ comment before reserved field. Jakub
    - Change ff_mask validation to break at unkonwn selector type. This
      will allow compatability with newer controllers if the types of
      selectors is expanded. MST

v14:
    - Handle err from virtnet_ff_init in virtnet_restore_up. MST
---
 drivers/net/virtio_net.c           | 240 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h |  89 +++++++++++
 2 files changed, 329 insertions(+)
 create mode 100644 include/uapi/linux/virtio_net_ff.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b0947e15895f..2f94ef728047 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -26,6 +26,11 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 #include <net/xdp_sock_drv.h>
+#include <linux/virtio_admin.h>
+#include <net/ipv6.h>
+#include <net/ip.h>
+#include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/virtio_net_ff.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -281,6 +286,14 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
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
@@ -493,6 +506,8 @@ struct virtnet_info {
 	struct failover *failover;
 
 	u64 device_stats_cap;
+
+	struct virtnet_ff ff;
 };
 
 struct padded_vnet_hdr {
@@ -529,6 +544,7 @@ static struct sk_buff *virtnet_skb_append_frag(struct sk_buff *head_skb,
 					       struct page *page, void *buf,
 					       int len, int truesize);
 static void virtnet_xsk_completed(struct send_queue *sq, int num);
+static void remove_vq_common(struct virtnet_info *vi);
 
 enum virtnet_xmit_type {
 	VIRTNET_XMIT_TYPE_SKB,
@@ -5768,6 +5784,194 @@ static const struct netdev_stat_ops virtnet_stat_ops = {
 	.get_base_stats		= virtnet_get_base_stats,
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
+static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
+{
+	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
+			      sizeof(struct virtio_net_ff_selector) *
+			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
+	struct virtio_net_ff_selector *sel;
+	unsigned long sel_types = 0;
+	size_t real_ff_mask_size;
+	int err;
+	int i;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	cap_id_list = kzalloc(sizeof(*cap_id_list), GFP_KERNEL);
+	if (!cap_id_list)
+		return -ENOMEM;
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
+				 VIRTIO_NET_FF_ACTION_CAP))) {
+		err = -EOPNOTSUPP;
+		goto err_cap_list;
+	}
+
+	ff->ff_caps = kzalloc(sizeof(*ff->ff_caps), GFP_KERNEL);
+	if (!ff->ff_caps) {
+		err = -ENOMEM;
+		goto err_cap_list;
+	}
+
+	err = virtio_admin_cap_get(vdev,
+				   VIRTIO_NET_FF_RESOURCE_CAP,
+				   ff->ff_caps,
+				   sizeof(*ff->ff_caps));
+
+	if (err)
+		goto err_ff;
+
+	if (!ff->ff_caps->groups_limit ||
+	    !ff->ff_caps->classifiers_limit ||
+	    !ff->ff_caps->rules_limit ||
+	    !ff->ff_caps->rules_per_group_limit) {
+		err = -EINVAL;
+		goto err_ff;
+	}
+
+	/* VIRTIO_NET_FF_MASK_TYPE start at 1 */
+	for (i = 1; i <= VIRTIO_NET_FF_MASK_TYPE_MAX; i++)
+		ff_mask_size += get_mask_size(i);
+
+	ff->ff_mask = kzalloc(ff_mask_size, GFP_KERNEL);
+	if (!ff->ff_mask) {
+		err = -ENOMEM;
+		goto err_ff;
+	}
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
+	if (!ff->ff_actions) {
+		err = -ENOMEM;
+		goto err_ff_mask;
+	}
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
+	sel = (void *)&ff->ff_mask->selectors;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		/* If the selector type is unknown it may indicate the spec
+		 * has been revised to include new types of selectors
+		 */
+		if (sel->type > VIRTIO_NET_FF_MASK_TYPE_MAX)
+			break;
+
+		if (sel->length > MAX_SEL_LEN ||
+		    test_and_set_bit(sel->type, &sel_types)) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		real_ff_mask_size += sizeof(struct virtio_net_ff_selector) + sel->length;
+		if (real_ff_mask_size > ff_mask_size) {
+			WARN_ON_ONCE(true);
+			err = -EINVAL;
+			goto err_ff_action;
+		}
+		sel = (void *)sel + sizeof(*sel) + sel->length;
+	}
+
+	err = virtio_admin_cap_set(vdev,
+				   VIRTIO_NET_FF_SELECTOR_CAP,
+				   ff->ff_mask,
+				   real_ff_mask_size);
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
+	return 0;
+
+err_ff_action:
+	kfree(ff->ff_actions);
+	ff->ff_actions = NULL;
+err_ff_mask:
+	kfree(ff->ff_mask);
+	ff->ff_mask = NULL;
+err_ff:
+	kfree(ff->ff_caps);
+	ff->ff_caps = NULL;
+err_cap_list:
+	kfree(cap_id_list);
+
+	return err;
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
+	ff->ff_supported = false;
+}
+
 static void virtnet_freeze_down(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
@@ -5786,6 +5990,10 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
 	netif_tx_lock_bh(vi->dev);
 	netif_device_detach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
+
+	rtnl_lock();
+	virtnet_ff_cleanup(&vi->ff);
+	rtnl_unlock();
 }
 
 static int init_vqs(struct virtnet_info *vi);
@@ -5812,6 +6020,27 @@ static int virtnet_restore_up(struct virtio_device *vdev)
 			return err;
 	}
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	rtnl_lock();
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		virtnet_close(vi->dev);
+		/* disable_rx_mmode_work takes the rtnl_lock, so just set the
+		 * flag here while holding the lock.
+		 *
+		 * disable_delayed_refill is already called by virtnet_close.
+		 *
+		 * remove_vq_common resets the device and frees the vqs.
+		 */
+		vi->rx_mode_work_enabled = false;
+		rtnl_unlock();
+		remove_vq_common(vi);
+		return err;
+	}
+	rtnl_unlock();
+
 	netif_tx_lock_bh(vi->dev);
 	netif_device_attach(vi->dev);
 	netif_tx_unlock_bh(vi->dev);
@@ -7145,6 +7374,15 @@ static int virtnet_probe(struct virtio_device *vdev)
 	}
 	vi->guest_offloads_capable = vi->guest_offloads;
 
+	/* Initialize flow filters. Not supported is an acceptable and common
+	 * return code
+	 */
+	err = virtnet_ff_init(&vi->ff, vi->vdev);
+	if (err && err != -EOPNOTSUPP) {
+		rtnl_unlock();
+		goto free_unregister_netdev;
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
@@ -7160,6 +7398,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 free_unregister_netdev:
 	unregister_netdev(dev);
+	virtnet_ff_cleanup(&vi->ff);
 free_failover:
 	net_failover_destroy(vi->failover);
 free_vqs:
@@ -7209,6 +7448,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 	virtnet_free_irq_moder(vi);
 
 	unregister_netdev(vi->dev);
+	virtnet_ff_cleanup(&vi->ff);
 
 	net_failover_destroy(vi->failover);
 
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
new file mode 100644
index 000000000000..1fab96a41393
--- /dev/null
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Header file for virtio_net flow filters
+ */
+#ifndef _LINUX_VIRTIO_NET_FF_H
+#define _LINUX_VIRTIO_NET_FF_H
+
+#include <linux/types.h>
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
+ */
+struct virtio_net_ff_cap_data {
+	__le32 groups_limit;
+	__le32 classifiers_limit;
+	__le32 rules_limit;
+	__le32 rules_per_group_limit;
+	__u8 last_rule_priority;
+	__u8 selectors_per_classifier_limit;
+	/* private: */
+	__u8 reserved[2];
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
+ * @selectors: packed array of struct virtio_net_ff_selectors.
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


