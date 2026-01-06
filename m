Return-Path: <netdev+bounces-247399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2505CF97CE
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1A5C30EE8BE
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B42580FB;
	Tue,  6 Jan 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RjyTAmhx"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85891327C18
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718322; cv=fail; b=F2renskTGGxdsWlJCl4ZxsI4oQuiGMiey7liPOigFLUZcph+VkWX8ZJMNealEzZYILQHWy7a0ajJ9gXpY1UTbddycoykNyJqc9OvsrnXSeE6w+6kG3cZU9UDrRfsMA04RpMymPUAmJmJNNAQylAPjP7z/Fez3CoEKBl3ciCCP4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718322; c=relaxed/simple;
	bh=qhiGcN/EeRjiHcTjWELOGGthyJlOSjTMgceX7jHx3yI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZRUIefmL8WbVfs1F8xDeM3IA+RFmEmiSOBhqccJ0EVpb2BAc7qxpy71TSsN/RW7VvFevbSkFZJb7eq8bCLr6LopVhsbuZotxa+ijhFzP7TtRvvUEUorFD0pfnW2SuX8P0AFKCh3P+emWW+VYI3Of10jPFlr77V2whI4B6EYG5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RjyTAmhx; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMhs7dD02W5BrWf+FGr0RGiPd1tPe7G81DErqnJdzXAiU2CP3wrfk5Hk6C7V7OTJva080ULPwZEU+/biLEmJZzrfVdGjXcknGnMYWaXxf9je/Hq67r31wFmagbp8nBzELFDr08Th0oHbi0933u5TXfZh/lWVnagAPt8zqaOncTxh+ejGP7sT1DB37RLTcYzrh73vvvGbeDA/GcqZkDz0LOw1YHuTfhsjA3sgdtqjKgCxmMXxzpB71/+RQYHmUu5cqvTAS0FgARhwSn+UbMFrPyErjOheEIOROWEr8h9d05+9U7qHqOzf6SaDz5VJebB8r4dC83TDL2OLOa5vxQW7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1Wmd+R1g+jicBBoMQ2HRQod1/sWrZYPgwvQQoCXw4I=;
 b=OSrUl2Wj0J+XNZKKE/qWzibGxh+ecynvBrnzTDctP/anaf7lfX/ohkr3G+ESLbQYs1Rr6BXfGG8Av55GKFocLyyLENgdCnXq7UbneUTRa65YoJaP7UuFnGdnKNfJx/k6vGdMtjXGllrXVpfvWj4/ROz6xlf2MIOLc4Ekypli8MgStunqNC+iF7fc1RjfRlBazA7evv+JnSJqJplGPqkeGEQy1v0TmLAua1hfsc0JqueMTblm/V84ta5+qk3VOOXppVeZRD8htaK4zI0s6mX84INlvO0axQBVXqQYJe0ejp0NTg8rofB7LxyBG9X6yOj4hsvbSEAX5md+nJvqb4kq/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1Wmd+R1g+jicBBoMQ2HRQod1/sWrZYPgwvQQoCXw4I=;
 b=RjyTAmhx4R58Gx0hvFH7PyGnsbCOJAyt2eJOzZs0K5en0QE7QOiWsKErquk/7y5euXqLisu3isgvj8tw/CIdXBYtIW0hMi8A6J0gFp4Yym2vwEY623uR9I+eb/8qO6Xla93fmf9b9TPMXZAZAuR9yOg3hWuDyiudFrnKOwRlboYNkfDaTtwpDF0hJWeuJyUWN2QC2/T1RIbValg9g4Y75W3FAvneIWhDmSpwVW+UMCPZCWl9B731B7BQpY/MfRMo2YTWglV4TS5UxsyhZDPNmjd/8PBc7j1NXm6aSTF2w64Gxc7HF+RlL3H/QEj6cgQPBFgPdXpjhLkV4kNjOo+JUw==
Received: from SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::13)
 by LV8PR12MB9690.namprd12.prod.outlook.com (2603:10b6:408:296::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:53 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::41) by SJ0P220CA0029.outlook.office365.com
 (2603:10b6:a03:41b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:51:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:35 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:34 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 06/12] virtio_net: Create a FF group for ethtool steering
Date: Tue, 6 Jan 2026 10:50:24 -0600
Message-ID: <20260106165030.45726-7-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|LV8PR12MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: f0478e94-0fc1-48d2-f628-08de4d43e53d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yRRK2iScXMw7SDkpZdYta98Kduyk3K+jUdjnS8ioIAgWrtZ6MPSNmRiZo6aY?=
 =?us-ascii?Q?OlnP7bHqehtHV6quSrXxC+LKqnMf0Z/LXG+Gm5n+Rlmr588AVsl8lTlwJHey?=
 =?us-ascii?Q?K1c5mph4HP7UMzfkbc6bNPYWWOHz4EB83qutPXfZZeUbHZLXMcBmx7/FWd3v?=
 =?us-ascii?Q?m8l5GBKD/lWHDilWW2rP7POzXkuugbDQ8KwmnvRBwo/ApSD90nzRLm8Lea4g?=
 =?us-ascii?Q?O9wWniXzRzHcEabP84JB48I6pG8Xk5jgjGkeb1jy4kI2GPLa594IcnrmGzXb?=
 =?us-ascii?Q?1B7cHmcrdsg95rM5S9cuVeBy+ZDPRqjUXA6CBY9R/39evgsJzfUBQGXfEJ9t?=
 =?us-ascii?Q?7gcMj0ljxXnXeWc1J2p4650SMabjWF2zFQ2/Ent0meLwI5HqHxqDmtXAgKNX?=
 =?us-ascii?Q?mMUJQPKOzBoL5kRZ/PZie3j9JJ/Teep42VKmZMaIwdFGiA0C2TznNAWZ9XRC?=
 =?us-ascii?Q?tRAiDRoybpcI046k9zihL6FvN/qg+VOoozi0yhEZDLSAC5AYOrrtvC9xJYj1?=
 =?us-ascii?Q?VDuIlJww8vYnh6wsmE02kTsdwyPpSnD05pJIEGCvclM+bsxhCw1EA8HfuLWk?=
 =?us-ascii?Q?YjXbBFTpIR1GRY+hvpaJL0xjXcHtEVwwYsVJCsTkAUIy//MpobjwTUWVPRjG?=
 =?us-ascii?Q?kKNEfNhV0OisTu5khNeKkMOuJG5XBzTv30dgBMtjiA8tBZjUhEHdKHsSazbN?=
 =?us-ascii?Q?8Hsw6AKJOQHJgshBO3gY/VPgfWIAgqqjMXOsKqr2NngcTVTwhgRJ/n/UwQ7N?=
 =?us-ascii?Q?qA9pzwod7QG/GVsiUMUzli65fItSemj1IXWHkIKvS4i3KRkQwqqhB5YpAgcW?=
 =?us-ascii?Q?Uby7l8VCwIOIYX7eDapZao1jDkJrdDuxGeDwyqcfdAvgBrAa9Mfs0/khsQzg?=
 =?us-ascii?Q?oUKMnX89sd8L+TtJ9cdSpTJkhUtNhLf0BfXmPqNM9Pgeh9mcuNUkNs8m4a7I?=
 =?us-ascii?Q?3IVWCBYTIHtuJeFrc1ZYLNq2R0Sr11LwqpH0cBAiflV6iuazwZU5AV+izB/y?=
 =?us-ascii?Q?kTG+YlG1zeIfG7xU4BeCYXUOPTc5GknEJeMC9stcPlOzLVtFeWRUr6jDPgHp?=
 =?us-ascii?Q?FD6nV9Vy7sGHiKn2w2aN9QkLRowA4ogbY80/iP4OHdFBQiCOXV3MtyMgaldj?=
 =?us-ascii?Q?4p8TQwKUhhp8jwpeeBxx7AWgdvBRuyVxR0v2znyTtHYYZfT8AINUzHhGtvFr?=
 =?us-ascii?Q?ov/0paYKpceX9ieS4lDY64FrCoT6kP/w3uzIZTFqYJIhCG7QJ352gkU74c3r?=
 =?us-ascii?Q?FoYiSdaGG9UlNIISvTTh32O7GKyhAcrRijM08CdGnvTg6WHUfiPeznh/dmYf?=
 =?us-ascii?Q?nsV/5E1wpMh5ByYSm0Zyjmz6Nju11Q3G12OXhnv5yQif4UP2+2pIcNImr+uW?=
 =?us-ascii?Q?N3Yoe142r//CUSo/fNJv0qDPgA+iENV/CGCz29adjurPjRYefSe01jaYis3+?=
 =?us-ascii?Q?5B8vPszdYQVFQ9F8ilYrGmiRN1HwyqqrqGk+qXeSCdLgY676xMtuN/4iCRLl?=
 =?us-ascii?Q?TgbJBN5MYHgl2GusKbZBZkaTdQfBoBjbYbqD6KsO7t1psynTfa2XGkNFTfvm?=
 =?us-ascii?Q?JYzCLAPCDk0a4J8oryg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:53.6125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0478e94-0fc1-48d2-f628-08de4d43e53d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9690

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Documented UAPI
---
---
 drivers/net/virtio_net.c           | 29 +++++++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2f94ef728047..bf6acfaeb7f0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -286,6 +286,9 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 	VIRTNET_STATS_DESC_TX_QSTAT(speed, ratelimit_packets, hw_drop_ratelimits),
 };
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 struct virtnet_ff {
 	struct virtio_device *vdev;
 	bool ff_supported;
@@ -5809,6 +5812,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5893,6 +5897,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5939,6 +5949,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5966,6 +5989,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index 1fab96a41393..0401e8fdc7a8 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -11,6 +11,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 /**
  * struct virtio_net_ff_cap_data - Flow filter resource capability limits
  * @groups_limit: maximum number of flow filter groups supported by the device
@@ -86,4 +88,17 @@ struct virtio_net_ff_actions {
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


