Return-Path: <netdev+bounces-239598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AD5C6A1C6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3CDB44F9E53
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1BA338907;
	Tue, 18 Nov 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rebdbTJT"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201835CB70
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476784; cv=fail; b=M/Ck7ZIm7QySmVmPxkSaDe7gKSSkBI7ZnZVu4j94z5lTx1ZiOZLX+G86Vt13Sg+i0Qu+H5EYl6nb+kySljLuPtrBjcxzxXDk7r8z8Z3mXUSjRqnBPdqVNaxq0xYlQEzQEY93Dze2FhrtCJfvaej2LOFiZmLQGMBEgxnRD9Vm1mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476784; c=relaxed/simple;
	bh=4Hq1oSO4brfYnt2pXy7oaoMFG9SPLuJDpOznNGWjRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/P04S8hnfEXZHlDrlLqJBWvi3iF05mcIPbmdM/VyxXvpTG2nPEhLZ59aEvt43W1nELkCJuNUehIJlzy2Oy3yXTNi6/MDyRvtGi2q99IcqR/Po/3zfAoth6ahwhhwRWV853OvguBz3zwHljVa0c5vu/mDss9iPSnpJPjNJVRDto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rebdbTJT; arc=fail smtp.client-ip=52.101.56.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpT9XdTNLUK1BkutL2TvhLtyrtxekJvLCAHvpuOunHs3QYdCScojIabyAPH3J4f0HZI+NM+srRQdrOJnf4pzYtgYVcIWEvjORHSpuV4RRynYQpAOacWp8LXgB1cq10Llp5Jj/HOdT4uTAaSpqgzrFVyGcJYClnz6CmCPCNWK74MZ8bHv6YbLm7OhlpyCv6e0Q+2cvswkrTztvSkHABHfZMMIwPFvHEz9yiRMNH2bNI+PjyVRM5TcCeBeVsZ5AA6JYnmNZtexny9Bd9xHJAFVQHyzJGPoAlauMQ6VZcEnlU0T3PgHR6RMqlWEWnAw6qWTCis/esg34Ldg9ObL9rC37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=al6vpgeK8O4NpxCWoCL95hdXqAyGMfdNtWoU8xWs11+umXlsHObwbVhEOCU00E4A2jBrnqVfFRvHQbYz+feTl6dmJ4gxB8TSqyWXAzdK7y/iWRA0HudAmZQnAn/DOLH9ucScoioFYegiGHS0ic1o1/s4luLIZ896iiXodtBbYANWbbMySkZ85MFiKUrcpT1czli/gZpr1L6u3s0TvDRMWUCLpdW6mwQ3fNPatR25f9MSEuVAnSd7dde7gRtZ7Uy5UxXuuJlrpADHBPQEXYf/DhRT7vOeh19bCjUIhMlhSv27v6HWkRHr5b+XVn85kRvrrsEcpKaHLXCXpclWKzLeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=rebdbTJTBVLVvWylCj4kyHFmPR9+OV3KHRhLSS696mEtVHyoqpBWIsTHoq7ybPoxSSVeYb1DFFozzjHhMg+phEAY7wZRS4MI78+RQSnNb3AvFyTEklo66mnB514Tu5am1hkrc8EUm3XmDvTPRw8dMFSk+MxDalZJI7n5qKfv5/dMOPL/nMDDwg1+2cGegRxBlFcvwGpXxuaOtaIJNmg70dviRIyoAVVlU13rOsvyLajTq51HEbwzDKDCUn2wnOI2oz58QHS148Du5ptEKDBwLn+F4H4H8W/Rgq71GIPA5/4b88MW9maIS6XqLTHbiy/pP9B3asq0Xkh4D+cdm5i8fA==
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 18 Nov
 2025 14:39:35 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::d7) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.23 via Frontend Transport; Tue,
 18 Nov 2025 14:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:34 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:13 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:13 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:12 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 04/12] virtio: Expose object create and destroy API
Date: Tue, 18 Nov 2025 08:38:54 -0600
Message-ID: <20251118143903.958844-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c67ab4-7423-4c0d-265d-08de26b04afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XEIOmTLkj4bWA0W2idE7/xxkhG+wIJ2DxL715LugXO10axwDXLFDN7DC5ABN?=
 =?us-ascii?Q?D/ARNWHhNxrVElWfZ597qeajP6UIQH98TNBakdi8pzkUU23tRjrpZrkHJFPJ?=
 =?us-ascii?Q?LmG7Mqj/U/ilj6XuBduCqOvwIZkAgpDajV3NZQerM/tv53X5MZmxYvcgdFEV?=
 =?us-ascii?Q?5qaKHEOHnbx3pbTDcrDbDl9EAHk36yMKmLShZuOVe0+zRdntWyMf7nZnfK1i?=
 =?us-ascii?Q?0xyBIxgk/q1KOdzZBiBUdoEEYuuIrMgXZnGGMOcUrZUXk4LUp5tqpnIQyYB5?=
 =?us-ascii?Q?gVFdU5QYFJOGfkRDQAJRucenJjUI9X4jM+FfleY1/0S3kfQ599jxjHbp2UO4?=
 =?us-ascii?Q?5l71e9PHuF1wxlvy5n1TIUPBzLbYXHlwzZ51EFm+62a7BZvLcFbWmt03DePh?=
 =?us-ascii?Q?58W7Dn0FJuoHZFiwjPW/MVTvUlkm9WcpNCgE8CvZlCektIy6AnnSlJRM7L3F?=
 =?us-ascii?Q?IbjBvuQcJMS0JT3SOzOms0ENTjG6VsqXi4ilmWZc28jPbnmnvgi8kWARxVP1?=
 =?us-ascii?Q?s+hV7R/mRoj7fiYHIJWuUTuaKC12Mst8J95Yp8PQ+FO59Wn/7jD9XLLdPYea?=
 =?us-ascii?Q?1Vd5OogaeOj/anNyPt4iAoMVPDsNAOrMVQ6hgbH6/bu8Hhh+oM6JHArFEelO?=
 =?us-ascii?Q?ZgDq8FWN6gmQ+VEcSOVXzeInM/nzgPaQwnX+odFSXPkrZZPbC7/Gl5x3EfJ/?=
 =?us-ascii?Q?Nw0mQhP6m7RqnVOYw24m+AJWUdL2xPGokuytHrN4PMgOSfhPn0UlrkfabzMB?=
 =?us-ascii?Q?X+degoVoqYdgPsEUlnPz96h1BX7s3XwnQ9l6KFmNP0BlDvNZ3wUb/Mgygcdb?=
 =?us-ascii?Q?tG+7LggqP9jOF44D9IlWLW3I8TIDAqaD76NrrjFITEwpx6HlZybo9KYIUdLw?=
 =?us-ascii?Q?r91uDXM1GlRvKfYiOytuL1kzIfUhKwsfnO3bMXV3Sg4KrzojkIWcXkBtsKx0?=
 =?us-ascii?Q?6WIfFpw09R4gtKVvrxBqu4BQoeEF7dQQDccAaQw70KnTpFoOFELjvrJWUzhw?=
 =?us-ascii?Q?hkNydg6Y+/0lR7WhbowjgMwF7ZYNWErvoJp275hQInKGJoAfD1Z7nwy2nT77?=
 =?us-ascii?Q?c2uHn1Mdzu7WgLfGM0G3kkFY4WuUvL2sLpG0gaEV+WxVicygLHkjVhwuYxdH?=
 =?us-ascii?Q?Ukk3pfmL/lw1cOhrdHsvdkuFZ4Xa4JSQ6nD6tW0U/4eUeXhdHE3hyDDTLciV?=
 =?us-ascii?Q?NJXPqZvGMWoJRBoiUBZs7ranGb6Jzi7EVVglz771AYEVgJIeIFSGYwVkHwVN?=
 =?us-ascii?Q?VMTVbLpUeE6sSSDoecYZlwAvhD9h+tv73o/Q/MA+gbDNKR5jyCSq2EVQeJP+?=
 =?us-ascii?Q?JRBKWgM4dmFuAAtjWwryXi9vHqrRl8tvDb5jGZoRF9wBmqvVgUOfwcJ0vYn1?=
 =?us-ascii?Q?6AZnzLoe9MZ5VJxcEVSnBpdJHvPKmaao5A30CT135wI5deJ6Yynwn14LIyMu?=
 =?us-ascii?Q?jj2T213Q10A1Iz/ToQ5dAitgrQNX6WFwhNsGywX9/2nU1TEzena0O9JoDltt?=
 =?us-ascii?Q?+FK4C8UDgC5of838DVcAbAlhJ23oy+rrnFWqdHK1Rn1JuO6yKUaW1/B/3BLT?=
 =?us-ascii?Q?zHTNPy/g0N61NtR3ZtI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:34.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c67ab4-7423-4c0d-265d-08de26b04afa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)
---
 drivers/virtio/virtio_admin_commands.c | 75 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 44 +++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index 94751d16b3c4..2b80548ba3bc 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -88,3 +88,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data_size += obj_specific_data_size;
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 36df97b6487a..039b996f73ec 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object destruction, or a negative error code on other failures.
+ */
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


