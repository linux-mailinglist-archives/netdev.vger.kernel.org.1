Return-Path: <netdev+bounces-238111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A4C5430C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC70734C8C4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8F34E744;
	Wed, 12 Nov 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oy0Ypa53"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB334DCF2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976122; cv=fail; b=seTWlHEeweRw5AMvlK+MNjdDtk7iSw5WLdGd6Z2FTFXSsL0/3NNUVWWfKqqi+8++QYZZPnkgl+/Iy+QhDbfS2W3YieFoeUNxi2Imp/3uXwtUNSS86vbGlCnzFKYEBY+oFHGQRZRpdUC3N/6e8QvrUhuie2wwOSJ8RBHhZeUXy8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976122; c=relaxed/simple;
	bh=9ua23KDSyDIm71SYAP719yZ0ml+D7nkAKFCqamoYKHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7QeUbhlDt+AcwzZo+sHIFaObwl5cVFmNtpsFayy/+I3SyjzXdjR47s+01su2sHcpQLumWS8G48jKcXP3ANcLCmtea5mQGbdrdDegffyQs6MP3z4LKBSvYXPxY+zfW+qywRTx5OSMEGpFjkAJLEthmVQhh1PV1PxB8kiPoKQM6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oy0Ypa53; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpL4Acy1XJ6ucz7TKTjDNJfj9HzrKA5IofRT0DCGR9IgUlknXyHLXvjzBeP4MTXLQxmQr9qdzusDt8wH+9I18Q9SBycEYP9hDarGqyyQuTtJW7k3G6FinPw/S/IM2epXD07hKuW2vtr5SVqlIJ7Qrkyq/ZMlOfaaEh+Q23eCYQE5Q/4JqajymF1GD2qGFRZgxqOJuWPqc/V+QxR9TxaM6wP+L1DmDuiWXVVhdi/w5d+G+rxezeANJxXb06pyo81nZBluYU9xg8coXPFPWz4PCAhX66uQekHrkrx+uqihOjTfD5r9pGjTgOpHZq1ecXHIFUaxihu/G8tmZdD5keTqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw32uge55yYd2R8diJfQedGcAL/9nZZ2Qxvxgoc4r6k=;
 b=p+XKlWRFYzpu7PteaLC4MnT4biA7vskfPBicWj4nqlQOn1v4wK6m5NuYIBv9mybn5D7uf/lxXV01/yM56eD9pG9mqj8UIYS3WSVMpNo5D1zzdP7XoqCg0fkmSLla0ZscRIW30WMXBEVyx8oafTymVavd06gEQACu05iwwmjDoMv6bdYaBh3H2+8eW7kM/cBa2x3wT6Zsg4vdXjEWqyKc35khhVRYXjS7lgf9DiF1/lVHPUSy5y92hOOA3ONt5Tqvs4WFhG64hWsjszvGzHt7Cv43ZsCi6sGblz8DXFVWAPOAtluIxjtLIYVlTVEn/2dtBsQTmniGhBM4kpOpQWSmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw32uge55yYd2R8diJfQedGcAL/9nZZ2Qxvxgoc4r6k=;
 b=oy0Ypa53pm9X+oDj8AoHMQerNYr1iEY63ppMZHS1UU4g+HsM9G6Rl3D2E1COlB7YDjd+iT4kGkFJQLeYP3r4Sf+jHCoizpMLvNS7fFkHx+6FfM0MIT1GWGWBb41b5r0aSjcHwowObsSCoczCQUHXn5qrasNAW6QzdDdMH5IcC5wIYbsh/9muL4BhDuKZtPS4tCf9+6QdJzWD/d2TO8ueY4oaiS1oMC81UMi0P4DqyAhUDf4L+GY0S4n1vCmvSh/MkS+czVPIfv+9sonbkr9/7awfANYnD8nBPge5wHURBE095/3dvlkGyGtgFrveqs+9OHH+krdL41H+181yjs/+pw==
Received: from BLAPR03CA0073.namprd03.prod.outlook.com (2603:10b6:208:329::18)
 by SJ2PR12MB8979.namprd12.prod.outlook.com (2603:10b6:a03:548::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 19:35:13 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::a3) by BLAPR03CA0073.outlook.office365.com
 (2603:10b6:208:329::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 19:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:35:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:34:59 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:34:58 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 12 Nov 2025 13:34:29 -0600
Message-ID: <20251112193435.2096-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SJ2PR12MB8979:EE_
X-MS-Office365-Filtering-Correlation-Id: ee85c0e7-add4-485e-a06d-08de22229995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z/ss4YhT8QQb1qpagdXRe0AiFZoE6osx3/wK7+7Ex69al1YZ9XJUG2wP7Qj2?=
 =?us-ascii?Q?jEOMMpdK3HVxHHKCrcB+03HvuUsr6mu7vTA2uOxc9JEKy7ZGiEVA8/nOuFl3?=
 =?us-ascii?Q?+HYpgSm5+0nR/zq2pwGq8c6wsfGwiHf7wgZzOrP0A1KP+CJmREMeHzCcCn5i?=
 =?us-ascii?Q?YmlGD0lioeHVhR+YmICMIJYtm5nsKTRUyQXfbVlOJ5zTpMJ67lq9ufG1UwdR?=
 =?us-ascii?Q?d+RShoLgwMki9R8KmPBAvltg7UGKGlO/mnEDmKFbawcBXZFe9J1N5pyyDLXn?=
 =?us-ascii?Q?7yyzxR8+mL6tdv8DuLSQRYLDPfVKuC5IZ+ve8AjVZ9PorJGAwsIzgfXQdqnx?=
 =?us-ascii?Q?XpaWxsgz2UJGBVbawcjZxsDtZS8HghHgs6Ul7BzG4sPG2Tb7OKmnEORfYmst?=
 =?us-ascii?Q?f5botisuQMdKcsC+Ys4l0IVudW07HLWVxouIPh9EOUWWPkMzVpyMDJRF/vHJ?=
 =?us-ascii?Q?ReznQMnyRI3L0r0yZ5sf8e/GR0CnzFo0QBJhi6/USh/MYzzWU2vAo1645ArB?=
 =?us-ascii?Q?YuYaiYPONxtAKbwhZxGUfq+pAmYDRnAgs1QlxH3a7qwjk407hSR9k/K0u4Kh?=
 =?us-ascii?Q?TA8iQxs3eSA9VP0oss35+6M4K72wlooybOsOn5OwCO7qESgWoO3CR/7IXn+I?=
 =?us-ascii?Q?fBvQRETbfK6odIjBR29U7GehfyzVNV9u/fwB1M9h95G3ARwVobba75qY1172?=
 =?us-ascii?Q?IGAh1RRDpwwULz7GfFxybYvPiV4zpLc5AgmJ0k+g+z3lEdv688xSIdCXEwtT?=
 =?us-ascii?Q?2Cba1YJ35QG9d6b338tOgZT1lDnKeHFPUZl8Pc/Fnvqjw83LCHCKUmAYvAzY?=
 =?us-ascii?Q?L2LFbuu0NcCEyopxAcqmNPrNtiMsju9TCFB9QSKUO6F8OF5oKXmbX0BrZp5w?=
 =?us-ascii?Q?kvB5xgb/jAzn+EnN2/p1AvQzb944Pk5WE+XTIongPrHaKGFZNALesIJQF5lc?=
 =?us-ascii?Q?cvC9bgf+lzI/O5xKJko3zQ4gSrUKUfieNaIDVbnSASbROv5/Hdvhrue5s9vi?=
 =?us-ascii?Q?8WmaTjHx8j9/ooaGecwC6oLvskSPeDJcYUJBW0AAdK+f286CDcHp9wgnIByG?=
 =?us-ascii?Q?5zDuxOSy9fJ42QCaFsGfyYZXj1mbIOBw+oXgyS1Q41qSm3WxfY78kdab8aKb?=
 =?us-ascii?Q?F0qIPCy6Z3wF5KBDD6ch0s0F6bnNCdGMgX9c9Y4+k4Qc3pF4xH0PAGVJEm3T?=
 =?us-ascii?Q?QxRcEncAfhQbUS/4QF/3fzyTyNFyMrg1RZppOahlls68CDHeLQqwYQLRwbO7?=
 =?us-ascii?Q?dnhhlnunFWFBBDWbvrQbsoiu/GCe2nNhUK9p6VGwvJEOOCU3mNqEYu/wQmDA?=
 =?us-ascii?Q?PJnUhm/Ov7D2J4WpfZ9hOHHpfbh0zYL/uRwkmFNYmKVkT6a+g74avuJj5MXS?=
 =?us-ascii?Q?6Oi/fhs2uVpIZJCbM3ugdxnhnKXFk2lfIbNp1kAwWHVm1lhAJJFYbfwnQzdD?=
 =?us-ascii?Q?SCmZqiYJHc880uvk+IFf16gIWYy4Kf/DdCwWzwPqy1IG5KB3nrTWk44OoMCk?=
 =?us-ascii?Q?xTWBdY0kkbCLyzEZT/p+5anVhcBAkNu1ctMFLaYbjWBR7p5EAhybojZlwPkN?=
 =?us-ascii?Q?MnVEu/H8D3VEtjFUERo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:13.2438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee85c0e7-add4-485e-a06d-08de22229995
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8979

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
index b4d6e475b0d8..f1cfeb28fb16 100644
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
@@ -6806,6 +6809,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -6881,6 +6885,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6919,6 +6929,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6946,6 +6969,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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


