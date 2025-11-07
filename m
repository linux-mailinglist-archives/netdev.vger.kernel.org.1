Return-Path: <netdev+bounces-236621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE2C3E6D8
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64993A5AE6
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F129BDA0;
	Fri,  7 Nov 2025 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fAp2oY3Z"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012042.outbound.protection.outlook.com [40.93.195.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EA24DCF9
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489000; cv=fail; b=g+Da28dNgPOsrE4Ke5DPodmk3YeVeA9tRQP6d6jOEKU6GwrV1kRb8nGkeoR6VwG1HPBYL1p37qG3KUvS5LCRMsIb/mtfnldlcSF6sa3ZCmK79Dev5GNjHlMgE9baIcxs/fCasobmfqzqWqfxG+o7jcVH7TU53BDDaZuKaLe/lJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489000; c=relaxed/simple;
	bh=u1oF5IBbMkUghLUFgBi1SmGoO9Z1V7CrCfYAuPSy3Js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ms/4VZGllElwmvxnQw8W6G/+Zup4pbD5y83sbvLnK4sOzPV11ffynEuHRoNqGlZpjHaQ7xT42+VuV6lyT3Zt4UGXs2T4JHHdGrhEF7Atq+Encd/r3KFT6XxYRw1oxqklQjrkhzaIrbjBcEAH2Xp/DVZ+f8kISbuRkhtWNMtsKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fAp2oY3Z; arc=fail smtp.client-ip=40.93.195.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxHTNuyj4Ak35yW1l+IB9MExokPJEWe8pwiFevtD2i5xGVHFbglbGDCsVQK0om9LQ8OfEQt8IuOUsBNz+YNvdaOxyKvTIpnnxwcUGcl1GrCHlcuP/j+KuLmKfGGTbM88hlPnX01lUzbbMchPnzIjZlmTpiWtGfPP5mDqc+YRSk4rcR2cCZiIcNoEY11vamhwkpRh6MVtyqBH+c+6gMkpmvaJzxEQa8kVqxqzZJcBPNHDyCvb/PJP5DlaKS0jEiNq1iiYM7HAAftjyULIpmCaViJWrLs6ouPS4NYgwsIKKWJucYwMtIoRDQLnC6U5+RPbkiFCxPyGh1flpxzozdYQBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2pPEuB/L027CYGXXSd5wjUk7EfBJdYgPvz6K1WRX+PI=;
 b=boF9Q4K7sXD9eYvro8WouO7PycRq1dJEPLKLumrqdn/Rncc2Oj4fz277/z0z/d6dxZMgZbVf+xvGH32WKxPm/Ib05b65HmQuLe1ji98x+lPqge9gZwQHzK3BiYOd1Fllzzsw0GPRiEALLTq5i72e6FZCYKt+c/hcqi2s1Wsq5dmVa3qxfDC6B0j16ykm8ypII05aTWl8pRRURbzO6adJK3UElx4UHmTMm0rNn9LJmConNVoetikCE4bmqIc9hyNZ+Tc2mzTyFLuhBnapWry0wfvwQMqAs87J/RniRKZGn9QU9UYi2plkeGL4ReebKoeSFo87VuCAvwzD/QAqayOMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pPEuB/L027CYGXXSd5wjUk7EfBJdYgPvz6K1WRX+PI=;
 b=fAp2oY3Z1lHIGmLd8lUEr17Du8td+gC3QEv4qKSaW7djXIT09tOWxx0u9R7eXO2OpuHbR6AjpI1Gv3CtISIZY7g6MuZwH4ZUkPhVuQpPmPiisxACp6k7ucjkBUZL7DHKzYdT1cSsEr/P0HPepHHhTrcr9oJQwTK6eCnqQZIZs4+hvyqXQcGmN6trxZF32QKkpkOfD3QTrJAvpkC1QK8HDQYT4mw/WU9hjf+fq4CJLale3vSVC6C/1lST2OMeuWq1IIon4eGpRqXS4JTc1B7BStFgKAxukLGot9PRmnmVx++IaMHR2CdeogwbbI24X7jXvauyKST6LTX2NCQPejB0Yg==
Received: from BY3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:39a::28)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Fri, 7 Nov
 2025 04:16:33 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::6d) by BY3PR03CA0023.outlook.office365.com
 (2603:10b6:a03:39a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 04:16:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:22 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:21 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 06/12] virtio_net: Create a FF group for ethtool steering
Date: Thu, 6 Nov 2025 22:15:16 -0600
Message-ID: <20251107041523.1928-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: c72066c0-f36c-4e5a-6b73-08de1db46f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YljsPzznz4hB5vUL7uBZ7f/zY5kXHn4EYunOCctXzlH6VAUaMatJoRFhEr+8?=
 =?us-ascii?Q?TbHxVg1dn8pq35tN7rK1qXD4SbvaURiaV+YSxV9A4DoxjtjN64IuW/LD1kv1?=
 =?us-ascii?Q?Su0dzHDGxCmlLY46nL8cX3A3+qA+uwMDCaI/6sRwM6wXGupBoWT18rG9jsxj?=
 =?us-ascii?Q?ctKkriZnKTzdzWYMDpxa+hZJE6p+RvMrTgyJiVp5mksmI8KTHhuKCJLZWdZK?=
 =?us-ascii?Q?VyqQd2VLF/UJ0M06jyQgKn+sYxpNWZxIL2cONh8A81wsMFBeoGQDUflSsEBs?=
 =?us-ascii?Q?9VoIX4TvknNhLLuu+QXqVyga7gI9SuEavGqKT6+TDdyNpO8DoVNHJPgg94VT?=
 =?us-ascii?Q?XAvVs5hC7U6ce/DeKo+xPEkmbKT9Vl7+S09beXXla6haDtUu2fliOJ+0o4ZR?=
 =?us-ascii?Q?zyjANAfb5PalVDZPO6lAMHS5Z3yiv+VrVSrWU2AQoyRnfWjDAN1uLUYjD50Q?=
 =?us-ascii?Q?z8ciMQLySxq/z0hOmEzrmxO7JXNWK/jAtsJ/DDTkeWM53GHYIGwHeF6CP8J3?=
 =?us-ascii?Q?IIabEq+GObuDtWfUAQSfu4R5w+un8UWDFxTRJZz2Zvh/RfFOMxqaLNM11CHD?=
 =?us-ascii?Q?c/WYV6W0eLfEdt7NKx9SZJhXN88PhPhRzyJZHOpiaj+ZZwjOquWtkAMBJSGe?=
 =?us-ascii?Q?NtXikvopg+LuCARVDyRkEU4Ou8/mmxC4SRhO/B/mBR4KCC+w6ph+crzrkpsW?=
 =?us-ascii?Q?+jInGdCQ1y+g0P6Veyj4ciez9GFWDyHjGybUYSlqhDPM2a58qjjbLvuqUYNN?=
 =?us-ascii?Q?FBRCTzZdza363vmhJ7FSpLF9ip7bxiBoXP3DOfl9D+7wXe5nrgNrT6Bm6fnh?=
 =?us-ascii?Q?j4/X3xbvO+A0iaiV+f86Caywa6+HDgdIrzsg2nw7jmj3AcKK6jxie13kRUIv?=
 =?us-ascii?Q?CRmU5w1iKk+Fa8W7N3c/3IRKF6KDTs38rGk8SRClqcMg6LrO2NCsH3ZecVr1?=
 =?us-ascii?Q?HIPUExWV1ZvKx7DIVeo3Lfu4fzMMyyEdFX2c/EI5rFpfVM42GR9SKmv9Fd6z?=
 =?us-ascii?Q?8jTuYmvvI8Lv4K8OBsROSIztv3yhYAONisslTTxXASGZAEZmvJCVRBDzIXdD?=
 =?us-ascii?Q?9W1O+ZGb+zeJuQLq40eh+eqa7DenAWRomQ9EYNY07QguTHwcYX5ZiNqJG7ve?=
 =?us-ascii?Q?4CaGT/zBpnQCfPJu5ZB2Ygx9TX8CC+0zqdc7xoVw87KmwUU5gxW97vLrkbt3?=
 =?us-ascii?Q?aDRqLJzBEGS7f//dHHKZ+q3frZbdRanzYJa+xyy2bCkTJS2E3pO7RKvGvNK7?=
 =?us-ascii?Q?n0cagDgU3Qk8K3FLROJkPxoqUtqGNu4/y8bu45BGhjcv+Pc1P7Nkoc54dNkT?=
 =?us-ascii?Q?/PklG1pUIl7Jl1jgeCDRgnyLTnG8YD4BhV2GCbyF+A0HXmio57Ux8C23ZcWj?=
 =?us-ascii?Q?hmVAbecXhs666Ltno64v5srbNZkUAHxhEtWEq9Z9M0Ij1FLRoUd6+o5EH5mG?=
 =?us-ascii?Q?XBISf+JCxGSNxiK5aeXIFtFinvy3JpSEedFocMdCoZVuR734hbLCte49GK0l?=
 =?us-ascii?Q?6yXni/XOrMywJy8Nhf+OKrhMZOpe2c4uYLFzOzhAGOF5d15MToPWud0asnqF?=
 =?us-ascii?Q?qdKs6d1911peF5xtQQ8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:33.2182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72066c0-f36c-4e5a-6b73-08de1db46f60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060

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
index 61f881334e24..30bdb8baad22 100644
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
@@ -6868,6 +6872,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -6906,6 +6916,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -6933,6 +6956,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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


