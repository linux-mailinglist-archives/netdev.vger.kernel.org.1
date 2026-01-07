Return-Path: <netdev+bounces-247836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0A4CFF1A1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCB2A300EDA6
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF6135A953;
	Wed,  7 Jan 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="COaXsmDs"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012056.outbound.protection.outlook.com [40.107.200.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E83570A5
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805505; cv=fail; b=fzqvTuTOvqvoSYjuNPCvNQanhlRwMdohujnthhm8eFgxXedA5TfLMRFwd86DN15FRO+9MpX3M1jv8jHk4nYAUR7hygtlVEszpod9KrtsVH7JurxR/n/eSyzTUnC1yaU5fh5lBvyR5Mlg+M1kPCvDzJ/xVWgYubFAf/uex6SMX7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805505; c=relaxed/simple;
	bh=MP1c4uZ63KjOzUS5OfQchkoo3R5/tXYGsQq41YoQR3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJywb0TAKhyRnTaW32brkbQPnVJfCPQRlvCR5UBM8rJZ2hTqBgTfZ3ENK6RkfLoHHyTSji576BwjEcxZNG4xl3x5PjDJfTXTRwq5OU7Rk1LxxWZsGRpfyIYMV4dM4VEpnUyiQleWFz0/SIOcY6UFTezydkxhkD5NXMV5k2ZnT1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=COaXsmDs; arc=fail smtp.client-ip=40.107.200.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIVMgN9/CSWtCOLnKFaYZ30gsBPm9b9WPe38K5Gc3aXOyOsh/WtQ7+LErQU1pxA7kzQlwb3NgJj8W0cnYWND0m6OILfXo1ig9rn0kcBViR4EaZQUydEW18K8BBxo4abrnmrwON2fjRmXU6K084YKY5dRjL+wTOgN6b4ZtJeyISHGvQfQH7AN+wX9+pyFtXXIrMlq7ZbEcNXnaTdboLkyec96EllSHckcTfFdakxwkNdoyY+ZQ5Kxi+CkszqJOtJOvqQZIZlBXw+wdf9Mz+DPUZGjwV/E4slmTM8l5L9OWSTWE5X6bzSihUWWSOkjyv5SJLBZzfWEf9WIGK7x4z1bMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO8d+feBgYHtJyJQJ65hwMlqZwuB3lHulIFGCFUR9RU=;
 b=gpaicikbiYancjreH7oLbeOLKG2KGxAMlawaLEIit0G1tdcHGnOZMUBuIqNhCwXNLdRBgpXQIyBaalRyRzMy/AF5b4ZgDUutv1qrlcB74UktBfgPIWc6EXh+eQbyiiHLjDrZP3Xojz318zS7R7yD14ag7j5/WXCHHSobEXC29Jr4EKiqKT5SSn9kP/VmOkq4Dy51btHaZ52HE1oc5EMS7mdptRXFusrxpzKF3yBJdw02y2kRwXcORg0lsUnEyInNtxoqb2UXC1cAVxIDpj4FlLWwOOsSiFUEWgRoB3qunuQXGNBoRhm2BT1TuP0W3iGrgvc3ybEGIwk7rB0R7YE0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO8d+feBgYHtJyJQJ65hwMlqZwuB3lHulIFGCFUR9RU=;
 b=COaXsmDskW2UKMwnxbzjMmpFH3DQy+XLcy96GuRA6bXhGq6+mGe3ekKH/T1U/HraUI8ZcsUU/cRJfdmYTnqPFJvIAVOmtGdMDV6vCIG9zijpuEglLVSIUKYr/kz8nrTLXBzmvLAQgNC99jLWs97UMCwh3xKNgv8no5bibwfG/6e/K4ifTXevjL6ml6BIyre7dXCH7CQuyvzqqXcCEqJbfVmC5+EMpRAtJQUt6xy33D3BU0E1u+CLLHGAK2tzIaKrnkMpTn5YdTdCnngofEFR51g01b/2hPq2olZLjSAdmunDCzTot6uHWtkJGZ+8TENaZbhHc8wKw4qYGmvDfbROJw==
Received: from PH7P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::30)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:59 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::ec) by PH7P221CA0022.outlook.office365.com
 (2603:10b6:510:32a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 17:04:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:37 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:35 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 06/12] virtio_net: Create a FF group for ethtool steering
Date: Wed, 7 Jan 2026 11:04:16 -0600
Message-ID: <20260107170422.407591-7-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 95257108-4deb-4b68-f7f8-08de4e0ee3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXBnVYXjitJI+vRP7boQsm0oR9TWHiMjebWxt5erm6SBcbihl43SIFVbb1c3?=
 =?us-ascii?Q?cHW3mfAOlu2nTuCrtviWdSJhrJnV9EGC5Uh/xyhTIA1HqVuH6pAh6URvkBKw?=
 =?us-ascii?Q?SNSI3Kox+6XH1+C8HlKpuma9MnvOJ3FuSQTfzwZoeYXmJA/M4jZ6Yz7bpTm2?=
 =?us-ascii?Q?59dGc+uPP75ncwkOHzkgo/10bQDgd4s9gnOuZYxz8mj+8Mulr9azLdzYBui5?=
 =?us-ascii?Q?0Uv5Asdxh9NeA8u/gpNDqq5LvlOnrGL+zG82n1CALqVkKFgSPE7O+7KYgabZ?=
 =?us-ascii?Q?ptWTmYAkNJv92FwqrrQuzMlYkHMLO0yirbks5hz6O2+967it5rzZzSrtuJE8?=
 =?us-ascii?Q?QKu4mpQMwDxcrYNR94rRPxx28rpT/MjTy3MVBzIH1sY9vZXTymHvlG8IxZ9x?=
 =?us-ascii?Q?oyRvTMSjRoitd1T9WGZec8iImrVeCVpQNDZ7kQ2Fi85QQh/nBn96KlZ0Ceur?=
 =?us-ascii?Q?4KLyvCGouh6qHyqs/Ll1R3knKf1fUYuBeAEiK993jASqak9mR0KGkDoXtJgo?=
 =?us-ascii?Q?5qXU07kaVr1JfVO1ubD9O4lw64LE2T8otn0MU/Z9nNC5E/KFY+sCH4Z6nJWs?=
 =?us-ascii?Q?bMD7+McZblV90gJyK3KfXG/73+AttonyefeGMklMzATGd+Dc5SYM4fuRxbeP?=
 =?us-ascii?Q?lvPipyw/XzZ+g6I347LZ0E557hCB3dXvo6i2Mqs6mLP8X18Pt84sHWT60UMH?=
 =?us-ascii?Q?LQwprDQtYni88CkGDyM5u5fuHLbfnxtekS+0dNLrwzjxrJg0uLfkR2iPggj8?=
 =?us-ascii?Q?9HIFbzJ6oxh7iO3gj9Rz25gmkPmn0FlJKiKwVBhgkFL0kzyayYZ0HPKXv6Fk?=
 =?us-ascii?Q?ei55fQC2nTQiqSeNlHgwCT06izbHF2BfaC1KyZPgP3QhXVBSMBbSYRqdslxD?=
 =?us-ascii?Q?TeYWWKhsvUXrEdd+5EmDtRSCRHHh6cusClF+7UNk7vqgz/U49dN5E6c0tBPV?=
 =?us-ascii?Q?lEo3h+vq1dsfOSZbhWoAl6GQTCsIIp0IEpfvIy6hgTYWBSUwAzbAriDTB/K6?=
 =?us-ascii?Q?AUjiHlE31fqFrvlsPJ0xojW72RUkXii56Vlj1aK1F5zgpR56SmlAIiB8iVUT?=
 =?us-ascii?Q?3p2gW4cykDLRK1buknjrEjYb6B+DEeV1M4asY9fNOBZ+yzp0ts9qcKl/bRg6?=
 =?us-ascii?Q?swmQ8UVeWGaNm9J4tU1Tnjat1Z8ILM6882WyShPqVWF4gN18JMb5jrtfVZ50?=
 =?us-ascii?Q?XZ2m3IOVZxj6EFvBbpPs7lDz+I3BywjCe2GiNxT4REECsnqdRdoU2AA8FkOS?=
 =?us-ascii?Q?avHza22Ls28OWCtl9984WCzu4Ia77iT8Wejzu2vogbTlXumfXm4qK2kftvmc?=
 =?us-ascii?Q?w76rcVd+k9ZXVN8I0AlIhFARN5gDjwVypVLX225MZSM6pUMV6wkh8gxj40BX?=
 =?us-ascii?Q?+UuvRt6lk8ymnXxNwusfcPOiyXzbTo/YtgMelO/YMLLpkj6DMzXQZU1Lf/Eg?=
 =?us-ascii?Q?Xa22BiIORlwmh3rvnjv+XuqYJ8y/EJJ4YRVfy7ZZP89Tp/ij0HtvI93O9kCV?=
 =?us-ascii?Q?5zqi+eSxm+8s9ijWImtCAkSp1RbG8Ly+i3fqIRvFWpaHdAfhjNflSpoiPPjU?=
 =?us-ascii?Q?okR6M02Q1no5fr/IILk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:58.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95257108-4deb-4b68-f7f8-08de4e0ee3b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

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
index 7c4ddfe4ffbb..4a876934ea8f 100644
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
@@ -5810,6 +5813,7 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_admin_cmd_query_cap_id_result *cap_id_list;
 	struct virtio_net_ff_selector *sel;
 	unsigned long sel_types = 0;
@@ -5894,6 +5898,12 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
@@ -5940,6 +5950,19 @@ static int virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
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
 
@@ -5967,6 +5990,12 @@ static void virtnet_ff_cleanup(struct virtnet_ff *ff)
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
index d025e252ee26..66af9ecdb674 100644
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
@@ -87,4 +89,17 @@ struct virtio_net_ff_actions {
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


