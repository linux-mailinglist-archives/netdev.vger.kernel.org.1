Return-Path: <netdev+bounces-233271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CFC0FB86
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 357FD4F98B7
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC8319604;
	Mon, 27 Oct 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ktyb5NVs"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BA3195E6
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586846; cv=fail; b=qfAcu4XtIlRdu/29JS1/oof0RC3Ky7jyfMxFQqQIv83Tc/PDXGmJzWD/WVOMSAomjGUWTyOvgH7a1tyLDnK84U4tbLaaI2/xMhiWmwoFO3qA/IepOk7uaXLipcCV7uDvjar0Tui1iQs5D+gG/DxKkjRWyH2PE5hKNDsoLjgC1pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586846; c=relaxed/simple;
	bh=8VxfiY4wKsrMSrBkB4vUaxYqSb+vz04Zr4dMPnX+D7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNmKr11u78mKCnmuY9CFIbCfy/vGqIFcee3pgjlI3PNf6jv9nNqAqIMr870AB0NVAQFp0eSwa4a/W+hWeiPSdtklLeVS7eMS5D/cymdHtU6rsngUl42R6iahgg4YIFPs9QCIqrZbHnaXHLYZSMg07PgvobTPhATci+Av7lXF8HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ktyb5NVs; arc=fail smtp.client-ip=40.93.196.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1iDWqrBHku/0h6cHoCD0lnVP4qHeJRzoo0IeM6fWvWYdJ+jzR4e38lO0xjBOJZYl4L4xpCgaoCk4x7Gjc2fh0a3+J+lM3kpJELw557yuHV3EYxuaLflGLY+mvnJH3xC1tdppIlpR9wHIcIWQUduN6mPGsNogZBdH+Bag+E4uKHyd54kygC1BeJB7DSpB3SKLjdP9lOt1Sm3WOYlCnNYNXXgx7pKLBj74yrpxfCTQaiPhJKnGTGQqVSQ+eHkUshnWyQpL3G+9m+qyeD1ljmGmSyU4ce2SzbWzY8Myi0b6eZapQGnZnR26tLxnvJG2AdfvsZbbJZI/e/AAZEJ8Nfb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJKNuPCFKRMX6GGVZRtjPil06yPltXg0sPCjURvFWAI=;
 b=jj9Clzl6Xzh9EXd58LktFwkJiMZdPTK523NJlB+h373igKfHc740MJqu//9iEflJ2K58eo8+V+ZU5acCRIAcFtjJqmeeeODNHLbBtVOmajsv/8qksrUmL6TEeqrQN16AaGBZekX7ebbUfh3jgZywV2QR2XSsQfhsqC8kX7ng6Ge4PE1XuRPCRllocpqoDPM3IZLFc1udpowS8rg+wzxil1m5zwN8TsdABYnLUwveky87Se4ZRs+BP66qlkkU5RRiTNNYY760cxPP8aSUsdqnzOOExDIkyCbeEbIKV+knNjLZ98ZteXrJmPM0JZuUDzOgTFKmHbmKJB+jjjr5y4lhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJKNuPCFKRMX6GGVZRtjPil06yPltXg0sPCjURvFWAI=;
 b=Ktyb5NVsfEFiJfGi63ew/1pnPc740r6C8G4jFVKPO5Zdqhu2g8rmt5B8kfscj6KpY63Gu9AYlo2s+nbXVKhgaJdH0NEqcnrgjN6UQpwW3amijTxWmZt3YzdZZTndK+Rj778n3onHRyt/wdCszip9V/ZpOiDlfbhIhza0N7kjIZyVCTjge4NacZe2g5Bviln42/y1+pwkyXiIDmI7m7AhEdO9Ku+IMqd7CplTxQC4U7Z+ozONw+5r461Gt3l81AEjM0TtqozWokIT9QQB9M2xooLJVQnPcAjoyDPvW5qYunHddQGqsp/axftTvEBiAH3C9COq8QtVXY1E+d0DqTrcmg==
Received: from DM6PR03CA0086.namprd03.prod.outlook.com (2603:10b6:5:333::19)
 by SJ0PR12MB7008.namprd12.prod.outlook.com (2603:10b6:a03:486::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:40 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::1b) by DM6PR03CA0086.outlook.office365.com
 (2603:10b6:5:333::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Mon,
 27 Oct 2025 17:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 27 Oct
 2025 10:40:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:19 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:17 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 06/12] virtio_net: Create a FF group for ethtool steering
Date: Mon, 27 Oct 2025 12:39:51 -0500
Message-ID: <20251027173957.2334-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|SJ0PR12MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b5d8b7-1dae-4796-efae-08de157ff248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RDZIrUxI7aaWCW9RhMVJfn2AOe9g9EKPY4WnCsAqVR0lLAf97k1TnXzbjewp?=
 =?us-ascii?Q?EPfUkaqjwt1nI3HHaMo2R8nRyRXlMO407gEO/FG/oM3wOnyi5wZyh4kGLk9u?=
 =?us-ascii?Q?wXIzg6U9+sapG3f1Q/XHpHqqFkVOxP/RMCyWaSFJF5facF2/noIAb2zWMWqA?=
 =?us-ascii?Q?0vJ8XsBuZ6Bmh5x9zJXShZ0SrdU1GVweu5T5wyMdK/0IlnL7lj6KCE/CwQbA?=
 =?us-ascii?Q?MqqO0JkmbLYlCLpQWiRwA9rCH6gMgbmfjyUr3EJ1QMdVwOa+pmanx5tYh445?=
 =?us-ascii?Q?kEG8AaC1upkE9kp4Drc/OAJul3l8oCZ7wgvhuNvZiLrDeCR/YciQOxKV3uvP?=
 =?us-ascii?Q?QzCuK4M+hITTXKahcBM8YLiPuh3ciFhBGI6v07ar+2FT2+pRc6CC6l+ry6xo?=
 =?us-ascii?Q?5RlS4f0epWkJwjZP8oMhsqazYCeULy0B7bP4Nb1ubz+m7zRWu7FyHUQVb3qx?=
 =?us-ascii?Q?4Yv5GLZOzuD7OaJFSZKTZCykGjVO5j9cb6huOvIceK+wUo/w/E2GydU1BN5N?=
 =?us-ascii?Q?7nbJQMvsVEXOrbESC4kXdFByqH5XEAfVN500BuTX6fz8qG68yOhpDitB1IvO?=
 =?us-ascii?Q?2V93M0ZrfZ/iR00+hNXMKACj36ruW/W8DbCm00YOHcHiL6pF5erOCoSB843v?=
 =?us-ascii?Q?JwZ2mkQW3V29bPpNpLeHCisFLBrRlIZz3665SRTBqbMa1S/RaHFHmYWwvE55?=
 =?us-ascii?Q?u95dy3CPLoaGptCrpXy8LbFlTXRjZhHzXwVV6Bs1CEMR2q4IgSQOWCcCoGoT?=
 =?us-ascii?Q?w4fQB/mGtACAqX61Iss85rP0NHmulkR7qdbRQQvK5CRc8ocq6Vk0hKMOJ+tU?=
 =?us-ascii?Q?EPxPwTYeUr5NqDv2ti4LRBS2XQaEGJp73w9IEE+EmFE029J9T6juKvjxbvOQ?=
 =?us-ascii?Q?PeD0GLD5b19rgm089ahcwT65gonjDDO9Mj+dS4FSsd+j1sVHvJHykUL193k4?=
 =?us-ascii?Q?gRXv8Bw68FA4xKCs9xA7tfuiafzYnjM3JWjRC72/7SG6wUOooQMOeP8GWUVi?=
 =?us-ascii?Q?IIFmqcwUWfl/OMNwnNitiBTli/aUiqRhFv1VVlnLY7Efgvlz/u8tR0xsZ0I2?=
 =?us-ascii?Q?F6oxhfL+edwU+UDDksnnsR7jGZAFGzJOEJVz4KuVa3Z4nd8ECJjFci+7zkTo?=
 =?us-ascii?Q?Hx39hjJTN8CQlFpJdm/iu/qpXvEH/+aZmzEuzNZySJsy1SvW2mv8sOMHNlFc?=
 =?us-ascii?Q?aowABRpQR40v0fQNg1OuZBhE5qgEYHRzhuK5eg7a0YON1qxScdNEkQbsvwmI?=
 =?us-ascii?Q?rPOzu1ajCOB9Z6GYPKsF5XmBKUrL+POdqsNzLbKrBJDDjgza5ElNQLnjr6I/?=
 =?us-ascii?Q?VidptAtTqqg4WKejeQrgxky8RgaQrYZ3gWBklSmbMB/GSKXlPREuXTaCeaNg?=
 =?us-ascii?Q?BfhObZYhK3SsXyDmjXM44sPYEPXcV3yaG6IVoRVEtytvW6buNr5qyMPh9rB8?=
 =?us-ascii?Q?1P0gcG7OryBMeGh5V9KCx0JesADlu9QfH+vrOiMc3HdBG5PqW9AixT26PNOP?=
 =?us-ascii?Q?/TAIbWS5jkL+GMbrom7js4wU/7a3VMu3cytQkbUT655WXS2ZeCNZ/ql3KKV2?=
 =?us-ascii?Q?DyW3fqviYXa/S0xsG+w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:40.2043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b5d8b7-1dae-4796-efae-08de157ff248
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7008

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
v4: Documented UAPI
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index a9fde879fdbf..10700e447959 100644
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
@@ -6791,6 +6794,7 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	size_t real_ff_mask_size;
@@ -6855,6 +6859,12 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6893,6 +6903,19 @@ static void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6915,6 +6938,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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


