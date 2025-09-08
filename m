Return-Path: <netdev+bounces-220881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD97B495D6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CF54C1F17
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD9A3112D8;
	Mon,  8 Sep 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VGDsN83H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0531076C
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349792; cv=fail; b=Vc31DhHI4U/nu1h1J8oLkVDf6kqAwCxbdMiJ4TAroNH3xHmqw+8gVRoux1tCUxM2anG7Z5nPm+HY9sWdRHuiyAOykafd922Jo2FDWXPaAQ0I9H/MlfA5SnDZmrS1UacsxhAx4aK50+7/B7YyaQ/NByPl1NjDiA81x9pfPUvYUms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349792; c=relaxed/simple;
	bh=CnEPyBzxDHqEivIpXJLpOMQxVYdQYdKHw4591R24Xi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/aTqWz5r6troa7tlVrXOPS3c2Ghel2oi/ujiNyT9lA/Ho23JJNoGS6iDzmubXTlBhZlOFblJEF+mrvTiljNhOG68KnytHMm0/ke+8TEtnN1YlgqAYFiCG6QURp0furj2scwcOhudXNOHKChst7f2h+wJHBoxjU63P4t9kE/HBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VGDsN83H; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKL/AD1oC+Tbcy8gKRbvBsHon/pWOSw5Hm/UVjddS0oDK4Bgo0ZFlxTLb8soBVDRIln9sCaLu/Ed6iokABYChjVXzn6m4Am79JECqpWb9Y7P+++TJInPOqTr763vJ9A90RwPsXPwvJkDBiND7PEV2aYPljH8rfW+fxtA0EjD8FPmyQRHRMPKq8Io1vHJ01qtoNH9Rd9c7WIlAmEPCjYIJ6j9LoG2xwgoFoujl0bH6JyXxbzsR7Z55seT73Xw5dr20kfvD/NtdH2X5VcZx63tBp/I23Wvt+n+s2CMzLUHTgqCV+oCuNyEmCgAzNX5VOIVkYH2jHEDqlgXplWTQs6mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUdYBscQiyh+wmVVbkzDXjQ3YxQ+l8xTJNCe1R+BpTo=;
 b=Mg9iE+AXIqRPRiBy2eL0M9hnLQyduu292YJXDEbZG19bU32zThUi5zn9uFHKgNNnyNNIsxtbQ2aSzu4qDBelsXkleu154P+0v4dK6TaPeJ5cdx5CokKMWQT8+ZO2L6zOsGm7OM6KL7vBrYmsUXSaYjvp7Ikjm+FaTIBqge4V046zvw4/rXTGgee9C6Ky5keJtDNQ6g5kzkqOPZRtNeWArfeFveFCdfBKM4aPqGUyBoPbhotdv6hk7MPmCd8PU+GkAK4XsO7W5jZ0q05W+l2PbpfZzDZakXwUjaLrFmXfyC+hocRoG9W3kOhXJ5TRncnKYnk1EueugbwTO3XSHJzZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUdYBscQiyh+wmVVbkzDXjQ3YxQ+l8xTJNCe1R+BpTo=;
 b=VGDsN83HzABryI7JFXKDgcukB0168TOeEiT97K8VmW1YKtt7qgkl1IJjIw4Z/ogp+nFQAWAqdm/3q81edwWQqosCdp6mf1ip+B/Q8R0bzz/yYe07HTX9uN6hY8YLS2uvhDrOQapzNB0+X+RAl0GKzqBDEh4Rq2d34rh2gNMhWyl/SScU6VYpZ2DoUOzRaIILjAw/q2Q647b35H9vwzQIAHrfN0Bo+IgZ5oRDx/AcLVUsFVJ1I6lQ/yz2rcWzlW/XxGYkFyTqDuWbxGGO1s6t1AW8oNoym3fQ37HKg2SFwPfcUiKplA8N7Sk9I7Q/ZjBomRcVka88PJUSEStRu9wh3A==
Received: from MN0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:208:530::6)
 by IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 16:42:58 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::16) by MN0PR02CA0003.outlook.office365.com
 (2603:10b6:208:530::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:42:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:41 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:40 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:39 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 06/11] virtio_net: Implement layer 2 ethtool flow rules
Date: Mon, 8 Sep 2025 11:40:41 -0500
Message-ID: <20250908164046.25051-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA1PR12MB6018:EE_
X-MS-Office365-Filtering-Correlation-Id: c9547690-0a2e-4c72-ce85-08ddeef6c4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXnve9ylKkqzep5zhYE3coyMHQO4tS/8tEI7duAMt0cPFm019w67vtatGiC+?=
 =?us-ascii?Q?hucYsIq2IhYOHB4v7kC8KdvnGpf6OqGrKnW3bVPQL3fST3CVOkriWayj930s?=
 =?us-ascii?Q?GfknKScFKVzwHZeU2xS1khak3H9KKftar5B9NKMufJSyurD5P/O6MA+iGBuz?=
 =?us-ascii?Q?p7AU4XVgVDfKpQhHO6ZbSydYeFBtRuMDzNABtV1b+z7KWW1QEBW6Fi6eOrf7?=
 =?us-ascii?Q?MY8Cmx7Jfr3JrjAMDea+iKvY7QK+0UPIBuD2VF6c0S34CBhJAQj3Fsg9/Mxq?=
 =?us-ascii?Q?zOl7NvLwRTykZhpllHWqiXyVVBokqwkOapfwEvWVFHyLIDMukmqgEcrSrDeT?=
 =?us-ascii?Q?BoaFkaVzs+N4cBub3s7Vfd5XplzQSn8UaKJjQ8HjbEJPUvbC+omq4KolqsDf?=
 =?us-ascii?Q?ouBD7hKbAVUb/P/NSw2yRt0ZBroh7grp9/U6p1vUVDArI8WumZkgSBufbxQr?=
 =?us-ascii?Q?fjV4wfXRNSvU1ltv4p1Dfn2/S9W4KlZo7sCqMzeyY0K7lZxA2aysxY+7zzdv?=
 =?us-ascii?Q?EUt1E4/gXVPH+Fraf2B3mK62PhRP9AP99b3kQglSvvcGCLALlu0Rsi+gatQU?=
 =?us-ascii?Q?CwB90VZKSTKgHk9/1+D+6w8eic2qf7vSJh1tGd+6d1EmQBfmzEAg43k8G5s0?=
 =?us-ascii?Q?QAHZVLxZmDX76LsMR79jlhmArbjh1wrh0hXUZOWvrhQ5PSKpJ+hxz57aCWqq?=
 =?us-ascii?Q?FOrL5uSSCFc+vzQMHtfu4NLZvo9kt0Eb6i6L42UafIwrpDEFxhjTfpGk6Ed7?=
 =?us-ascii?Q?kVOS+O0tNhlJ4YG6hDfLaZKGu7F41RVkNZxeygxqbGDqsH/VBgEwL8VYBnVb?=
 =?us-ascii?Q?OSTc62QtUjGWCEXszB57qYdJXVPpIUhcM3Vb5e65pcOqU5b2eNw72k5Hhw93?=
 =?us-ascii?Q?2aNJ4BbwPNnd/3juG6XMEulf2w62r2aGvuYrFkkMUwbgiHEABPFi6AR7mOgU?=
 =?us-ascii?Q?VX1tivS/XcSJm1gCgRabBc1qHb8vofNIt3PJZkDYjyWBHkZkJpugURMh6H3x?=
 =?us-ascii?Q?jFTko1kyYHzulSpBWnqHrCH5tBG17OIWnap/+ORh3BZWZ/gurA2NnLXc0cBF?=
 =?us-ascii?Q?uc8H/JmBnIGD/u1qh2kpBcADeyg5EEqViIYjoc6VxMOdkYfKhhVCU9Mx3oKE?=
 =?us-ascii?Q?KBVy4EKGklMMTpMAfbJkEqTt19QhnS90BYzsDvPtoSOBL/ZX16lTly+cWwvP?=
 =?us-ascii?Q?dk2xkU6Oc3hcNNSnzixUveDAkVao7mE+sEJqA7El8RMCIhWKghzn9fJn8v4Y?=
 =?us-ascii?Q?Z7lKyNkcU7FK4vl82u+zYVIr7wqVFVA0x2LRXYYjlbpKsf3+PqAwRqLFuYtK?=
 =?us-ascii?Q?+jtBog4okiW81bPAOx+4TTZ9Zmtnq38QOHzXDMznbAnWnu+yH9jMTfqsyi4b?=
 =?us-ascii?Q?RUvBJnzETgxYfnJp8ZcEzTR9CSITyItHiFJIJtvUwe+yWHm0khpOjEmOwm0H?=
 =?us-ascii?Q?SYx8pso+/7UP2X4grhKxo3ADqk+kMa5v6QdU6Q76IflqoO5l+Ozh/WLV5LbF?=
 =?us-ascii?Q?3hVA/UmIef4hNPXt6DSoUZ15uyCKH3cPEC5h?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:42:58.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9547690-0a2e-4c72-ce85-08ddeef6c4a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6018

Filtering a flow requires a classifier to match the packets, and a rule
to filter on the matches.

A classifier consists of one or more selectors. There is one selector
per header type. A selector must only use fields set in the selector
capabality. If partial matching is supported, the classifier mask for a
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

---
v2:
  - Fix sparse warnings.
  - Fix memory leak if c fails to allocate in build_and_insert.
  - Fix typos
---
 drivers/net/virtio_net/virtio_net_ff.c   | 423 +++++++++++++++++++++++
 drivers/net/virtio_net/virtio_net_ff.h   |  14 +
 drivers/net/virtio_net/virtio_net_main.c |  16 +
 include/uapi/linux/virtio_net_ff.h       |  20 ++
 4 files changed, 473 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 0036c2db9f77..e3c34bfd1d55 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -9,6 +9,418 @@
 #define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
 #define VIRTNET_FF_MAX_GROUPS 1
 
+struct virtnet_ethtool_rule {
+	struct ethtool_rx_flow_spec flow_spec;
+	u32 classifier_id;
+};
+
+/* New fields must be added before the classifier struct */
+struct virtnet_classifier {
+	size_t size;
+	u32 id;
+	struct virtio_net_resource_obj_ff_classifier classifier;
+};
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
+	u8 *buf;
+	int i;
+
+	buf = (u8 *)&ff->ff_mask->selectors;
+	sel = (struct virtio_net_ff_selector *)buf;
+
+	for (i = 0; i < ff->ff_mask->count; i++) {
+		if (sel->type == selector_type)
+			return sel;
+
+		buf += sizeof(struct virtio_net_ff_selector) + sel->length;
+		sel = (struct virtio_net_ff_selector *)buf;
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
+	struct ethhdr zeros = {0};
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
+	err = virtio_device_object_create(ff->vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					  c->id,
+					  &c->classifier,
+					  c->size);
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
+		virtio_device_object_destroy(ff->vdev,
+					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
+					     c->id);
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
+	virtio_device_object_destroy(ff->vdev,
+				     VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+				     eth_rule->flow_spec.location);
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
+		       size_t key_size)
+{
+	struct ethtool_rx_flow_spec *fs = &eth_rule->flow_spec;
+	struct virtio_net_resource_obj_ff_rule *ff_rule;
+	int err;
+
+	ff_rule = kzalloc(sizeof(*ff_rule) + key_size, GFP_KERNEL);
+	if (!ff_rule) {
+		err = -ENOMEM;
+		goto err_eth_rule;
+	}
+	/*
+	 * Intentionally leave the priority as 0. All rules have the same
+	 * priority.
+	 */
+	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+	ff_rule->classifier_id = cpu_to_le32(classifier_id);
+	ff_rule->key_length = (u8)key_size;
+	ff_rule->action = fs->ring_cookie == RX_CLS_FLOW_DISC ?
+					     VIRTIO_NET_FF_ACTION_DROP :
+					     VIRTIO_NET_FF_ACTION_RX_VQ;
+	ff_rule->vq_index = fs->ring_cookie != RX_CLS_FLOW_DISC ?
+					       cpu_to_le16(fs->ring_cookie) : 0;
+	memcpy(&ff_rule->keys, key, key_size);
+
+	err = virtio_device_object_create(ff->vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_RULE,
+					  fs->location,
+					  ff_rule,
+					  sizeof(*ff_rule) + key_size);
+	if (err)
+		goto err_ff_rule;
+
+	eth_rule->classifier_id = classifier_id;
+	ff->ethtool.num_rules++;
+	kfree(ff_rule);
+
+	return 0;
+
+err_ff_rule:
+	kfree(ff_rule);
+err_eth_rule:
+	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
+	kfree(eth_rule);
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
+				 size_t *key_size, size_t *classifier_size,
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
+	struct virtio_net_ff_selector *selector = classifier->selectors;
+
+	for (int i = 0; i < num_hdrs; i++) {
+		if (!validate_mask(ff, selector))
+			return -EINVAL;
+
+		selector = (struct virtio_net_ff_selector *)(((u8 *)selector) +
+			    sizeof(*selector) + selector->length);
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
+	size_t key_size;
+	int num_hdrs;
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
+	selector = &classifier->selectors[0];
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
+int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				struct ethtool_rx_flow_spec *fs,
+				u16 curr_queue_pairs)
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
+int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location)
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
@@ -142,6 +554,8 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	xa_init_flags(&ff->classifiers, XA_FLAGS_ALLOC);
+	xa_init_flags(&ff->ethtool.rules, XA_FLAGS_ALLOC);
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -157,9 +571,18 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
 	virtio_device_object_destroy(ff->vdev,
 				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
 				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
diff --git a/drivers/net/virtio_net/virtio_net_ff.h b/drivers/net/virtio_net/virtio_net_ff.h
index 4aac0bd08b63..94b575fbd9ed 100644
--- a/drivers/net/virtio_net/virtio_net_ff.h
+++ b/drivers/net/virtio_net/virtio_net_ff.h
@@ -3,20 +3,34 @@
  * Header file for virtio_net flow filters
  */
 #include <linux/virtio_admin.h>
+#include <uapi/linux/ethtool.h>
 
 #ifndef _VIRTIO_NET_FF_H
 #define _VIRTIO_NET_FF_H
 
+struct virtnet_ethtool_ff {
+	struct xarray rules;
+	int    num_rules;
+};
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
 	struct virtio_net_ff_cap_data *ff_caps;
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
+	struct xarray classifiers;
+	int num_classifiers;
+	struct virtnet_ethtool_ff ethtool;
 };
 
 void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev);
 
 void virtnet_ff_cleanup(struct virtnet_ff *ff);
 
+int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
+				struct ethtool_rx_flow_spec *fs,
+				u16 curr_queue_pairs);
+int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
+
 #endif /* _VIRTIO_NET_FF_H */
diff --git a/drivers/net/virtio_net/virtio_net_main.c b/drivers/net/virtio_net/virtio_net_main.c
index 1ede55da6190..14ee26fc9ef3 100644
--- a/drivers/net/virtio_net/virtio_net_main.c
+++ b/drivers/net/virtio_net/virtio_net_main.c
@@ -5629,6 +5629,21 @@ static int virtnet_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
 	return rc;
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
@@ -5655,6 +5670,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
 	.get_rxfh_fields = virtnet_get_hashflow,
 	.set_rxfh_fields = virtnet_set_hashflow,
 	.get_rxnfc = virtnet_get_rxnfc,
+	.set_rxnfc = virtnet_set_rxnfc,
 };
 
 static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index 662693e1fefd..f258964322f4 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -13,6 +13,8 @@
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
 #define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+#define VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER 0x0201
+#define VIRTIO_NET_RESOURCE_OBJ_FF_RULE 0x0202
 
 struct virtio_net_ff_cap_data {
 	__le32 groups_limit;
@@ -59,4 +61,22 @@ struct virtio_net_resource_obj_ff_group {
 	__le16 group_priority;
 };
 
+struct virtio_net_resource_obj_ff_classifier {
+	__u8 count;
+	__u8 reserved[7];
+	struct virtio_net_ff_selector selectors[];
+};
+
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


