Return-Path: <netdev+bounces-235255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F393C2E55F
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC693BB5CC
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F390C3090DD;
	Mon,  3 Nov 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C4idwZvW"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00B2FCBEB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210573; cv=fail; b=m5A2hBaC91nYbD/dHjgJ2Z6LPY0SnU5cz8kooD8rOlymdyubyPsqGn8OpcF11tgeO6e/OGa48Rb3uqEQheRr+qASDXvgs7iRXh6rVXfkZ7W7vPREuKUZ6SuDPM67yf6Xx2p37kPAgXZi3RlJ92SxNWmnc1muCBZrKXFKh1i4w/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210573; c=relaxed/simple;
	bh=kuDOuIlSZkyCH9RPnqZG2XUyNnvWQHbVrFGd3inqreg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUNVhA9ZrzJnlrQkPlgyCA/MDfXmXFyTtXz0ygIhoHD7BDRlV1/R+MtqgynVDP5MbK+xfH/xQGpPRdZTCP3ghlcyyR735KQAFyff4qo5VLXBe869CiYPKdlDIqLqRsyTeEFZXI/XCOo/Vn6Jupx+He6Vvdga7LaPYbLNXn4RIh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C4idwZvW; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMp+kPyVpCFieY8hEEax4NgPCPPJ6iSFF+AXDRnqRc0Ra7BElBqYvW3p5leIkuB3CbQ8foKtAFk1000iC8Ncg3N/MsXMvJxJiRt0qrf7vjbziVM06KKeh4EgG3hXcN+UPnOVQpFNIyGf80zD0s+2QkXzOVk2xywiQIqazN41k5IOTdJw/obXGSl/qtWcd2jafcr3KPy435+bESNJUJdl5Zsem7fkm4D2448+nK5sfd6mi8++zvpX3Ull6n78Ozl5xj9rxll7Ra+PfM/R+HoFLsBBWlYYr6aBybRyCMdTjzjs4cBGfdjPBxs8RYfFBxJbSU8YwDCv6V1eDGGNdS68Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBXIwb68b0k8nSyNlR9x+16ZNObZY5cRlaTDiLcKEAI=;
 b=jB8MJJNvHMW8J2P1bY7yaIGTQaiKrcnai9aNQ6TuS6TSpZMJT9NLk9UttDtDDTV7NHFj1/aCJSOh5MhmZEPvFoP55HNlCYn9oxcGwCIaj9K1GSWaOGIpzoi19yj0wtqSdpDDYpxts9bW1aoQQ7toINJmAlRoYvYwwPGLyjKvSrHLiOPterV8zF4qkJKuzhIfDdPERA5EEGmq1+5Gj0ZKqmh+NkzFxjWYUA41BsHAdKsnXZvJODkWguq2wTuxtDNBoJbZztK9i8Q3bKQQ0OIICbryu2Q7EBIIq6WXKoA+vl/+NgikvcP6Zf2CX58aPJZLvuqSSf0YmtYB0q6stVuzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBXIwb68b0k8nSyNlR9x+16ZNObZY5cRlaTDiLcKEAI=;
 b=C4idwZvWwLRoLs5xZyXkJdSWPSacbNForWYN1gMw02k8Ob7CJEVVMzRePtIe6TM5OAh5jtYTTNoqNsetklJC56q/0krFsKslQu6e2wK0CcgcHGMkAZpsYit2tuFLdKT/9zXLfh2UnZOprE6xi4DIL9YH9cF0APvEj/+8wRQcvu8uBNBt4S/PdxAUr02CzOj2ksxmdg0H/8LJKdH04MylwqZmUOv2Fw1hbHohhcb1xtLIRBlqnZlLrIODxBPvWXFjsZiu/7Lfc/0jDvNY20AYArS98sc7JGo2qvcV2JqNQqg2fdD7qSoKstqBwrbfl8bdMEpf8xKHFHaV3I9FHpVpuw==
Received: from BL0PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:207:17::38) by PH7PR12MB9073.namprd12.prod.outlook.com
 (2603:10b6:510:2eb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:08 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::86) by BL0PR1501CA0025.outlook.office365.com
 (2603:10b6:207:17::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:46 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:45 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:43 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 06/12] virtio_net: Create a FF group for ethtool steering
Date: Mon, 3 Nov 2025 16:55:08 -0600
Message-ID: <20251103225514.2185-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: db065776-220e-428a-5ca2-08de1b2c2ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wDY2r02wQJFdv8viK5XO6LAmVE4Akga1Y+RqR2fQ5u4iigxz6XoaSDgyXoi?=
 =?us-ascii?Q?2K68V1YFhVm1kRdBwxaSwffi8XwAHgwELtUtJcQj8hUvE3YQ3ftnN++L5nkD?=
 =?us-ascii?Q?2UOnbYwkMwVlsOnIxFLhzB4W8bT7SX5xBki+PJ0O3uyGJcfncXaLU8ltIKiq?=
 =?us-ascii?Q?euwEHGntSPnjcxNGucCr+G5y6DULYxhz2HaPrM3MAyRFyR4c666716lDzVmM?=
 =?us-ascii?Q?WqrlYRw3Oo1Is4KirSipWbevflSHwwsTt9y+zw8ULPFbIIg1qSqROmqZtY7U?=
 =?us-ascii?Q?DRORnmdibXIztIhWbu/UXoZBr+0OI4ZvMxtd72ZVa9w/4xijPZyqFqqKJy5N?=
 =?us-ascii?Q?SW8BUpHgmDQeZ+nn2Q7cxgskvf28RVTF6//PAYDQ0iu8fwkudGU5v4lhaJ4o?=
 =?us-ascii?Q?mwzP1DGc6+caB+x03XgG0iC0dzm8x2J59rXn8rTqAqV+LBx92Zjtd+kGf60o?=
 =?us-ascii?Q?5sPJDKJ4ULYDvjT+0KDd1QhGPakThWfRsKH3YpBQxSIgxYiW/37JHU+R/hOX?=
 =?us-ascii?Q?9fj9p8GmwwFYidV6/2bJRFu8I7PZhIzjIntXFpve8D3xcyzN5RgUGrgmN6J/?=
 =?us-ascii?Q?H05x9S20qKJVg35r9gTssnS4epJ/nt5MmmJHXyUYMDho8Gh99Lmq0xw32cfx?=
 =?us-ascii?Q?pDwe12mXovraBT0K3j1Tnx2j+SH4vNI7GzBfpDEoPn8PJADdFwF55Tbiwr/U?=
 =?us-ascii?Q?GA88bIBFVlygx+Ihb0fqP33DIGq4gh3C+xvZXF4OqpEOuYazWv16vNl6NZgc?=
 =?us-ascii?Q?lTNkeEuNf6iSpCAGIf1A5jyoHzylmUQs21XTBX5t5P7vOlthnW/JpeIp32tF?=
 =?us-ascii?Q?y1NB71S3jHzQ/N3Dr4GucLr6ZrQmOJcgVWIK9KyuG0V+DJA62Y27yXonjQdd?=
 =?us-ascii?Q?q7jlJU0g2j2EfpSdjKvxL/MthMMYPob6sCppZdCOdcsibopBg4zgtJmMPIwL?=
 =?us-ascii?Q?c6DHJXiiaVYc1JEP2qrj0gE3m8eqab8nBCmnhxNFPNOrmoPGVr4UOVsVqCk5?=
 =?us-ascii?Q?w5C3hCGrf3xcifQuaO1RpGWtLM9YZjGvuK5JVITSecxTqI006u0zVDZ0wwuo?=
 =?us-ascii?Q?Zwz6x9g97OLBQpvS25//LzmJpMn1+w2IJtFOgHHDrXhaZiYsFyagLaScvaO/?=
 =?us-ascii?Q?FlpgSBSYiMKKipGzKgpJFaDZOBs5v5CGno6vIr627zH+NZnHapvwY0j69tkF?=
 =?us-ascii?Q?7rH9uUMLXCC7h8Q8mOiPsOwFcETbe0IoxuM6LMsfzx/FLYooGM4e1OoGTqW6?=
 =?us-ascii?Q?8n1en+cK5FnbF4JQO7xWvBPLxMxa3PBWeNInOMp5NQWSYMSqNUCc/sQfGea1?=
 =?us-ascii?Q?zyB/fv7ZQilN69L2oXvw3CrOTZ7x7oQiWI75knnisZ62XrMiA//e02EQw3YA?=
 =?us-ascii?Q?ry2/XC8Bpup0BV4HKQ7y9FsaEhA8jaeCCBuNLsN20tdeuYkOrXi4e4Hvq14B?=
 =?us-ascii?Q?7ukh6KU4u4YsWxOUc/58dLEkwOlccthazKacHJ528vJujl2ybFma+3IZkVVz?=
 =?us-ascii?Q?t/2cq6GCcFjzZyAooJMO3Z3PS5XMwEu+as+03eiu3yjE6E+ROimo1K5ywZoE?=
 =?us-ascii?Q?FY5EtLIq0Zjtwkreip0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:07.3153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db065776-220e-428a-5ca2-08de1b2c2ca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: Documented UAPI
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d7390103b71..998f2b3080b5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -284,6 +284,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -6796,6 +6799,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -6862,6 +6866,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_admin_cap_set(vdev,
 				   VIRTIO_NET_FF_RESOURCE_CAP,
 				   ff->ff_caps,
@@ -6900,6 +6910,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_admin_obj_create(vdev,
+				      VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				      VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				      0,
+				      &ethtool_group,
+				      sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -6927,6 +6950,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_admin_obj_destroy(ff->vdev,
+				 VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				 VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+				 VIRTIO_ADMIN_GROUP_TYPE_SELF,
+				 0);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index bd7a194a9959..6d1f953c2b46 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -88,4 +90,17 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[];
 };
+
+/**
+ * struct virtio_net_resource_obj_ff_group - Flow filter group object
+ * @group_priority: priority of the group used to order evaluation
+ *
+ * This structure is the payload for the VIRTIO_NET_RESOURCE_OBJ_FF_GROUP
+ * administrative object. Devices use @group_priority to order flow filter
+ * groups. Multi-byte fields are little-endian.
+ */
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


