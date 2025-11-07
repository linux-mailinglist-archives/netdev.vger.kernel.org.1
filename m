Return-Path: <netdev+bounces-236619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBE2C3E6C6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F87A188B5B8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3A1AB6F1;
	Fri,  7 Nov 2025 04:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FvhzvYGX"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02523283C9E
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488998; cv=fail; b=e4JogrrmwFjFGtiflKdcY0CUHEuOJ5eH/tO1XeDAb4Den5XGX8n3/HaAfVCBjF3uZLwwWZI8uUqqkj/iJD9d+QEJOlXWWogeym+TKEmM0+8oM6VRNCSeC+Y49MoFxvEJyqbkQpXgMM037DQzy44L/sOGssj2wsD+nUUUY5WTj9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488998; c=relaxed/simple;
	bh=4Hq1oSO4brfYnt2pXy7oaoMFG9SPLuJDpOznNGWjRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqRd4f5awoCL9v+iDYLy7B884uzyiE85avAtmuu85vyq0hc/n4bp9hgfFeTXuVgkF9Xs07E+6rRoTEFHhQKcTSGV5ZxR0OC8eX8dU2pW87u9PjwvsGNEzhl7p83DNvIFPuLmcc3KVAEnoxuH1VZyN2OEQWkK5M/APQLttWdk2uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FvhzvYGX; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRJlOzICVuQEcT+KfdMTrASLUJ5c8CfGEn/54Fg/SxTElCS7h0wYLjCXSeXv4L7isKMX/UPJkOmMVutCbuggOCddJV1CCLJF/vNYzS+tnCaQE+bNP+CbhDM2xJojFJOUQHsg6ldKe5IFNIU56RvmQMCf0jNHI+FWJqqEHvue8P1QdVJkiF2qyIR38/Dy7BSCs9E0aPdP3LFV4U9ZqzD5WMrkuaVWbuFunNWzpP/IIAdnAKbeYtkOTHJZVp0Pdr0eqe53dSOyfhsHq9tRP8OU+vuv4qSmPkbyF0ieDz15tiaRYZM+dOg4eiAv5OnEgC6fYbm/LujxvcWhVVAWZ31Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=iolt0av8AQ4L68HbwdIqeYdjs76rlQcm76C43ti1U8pI3fp05pb0Y7L8xgGh5j7A6F5/l5RZ1NUgwCD43AESfpx1KJB7qY8WRuyGQIu5NYhIeeOBNiSCEz8YVGxp4BTbIoPcDE+CrSc7ZZxIBNdr0xNvUYEM57Km8t99WzyrGomaSyevhGtZJAzCzPQlfiZiZgZHHwJ8KI/L7131zCU6L2tJp6ARWmTkCmhTJWmdvRHqFOaK6u2hVPcjiglz7LuOPjuqlo6R+XI/JVbydEdM0chb63P27Slxwm8cR8w8Ydt7qUYn057AojxkONCSMFe5sL31uvcgoyTzkIkZ3qKCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=FvhzvYGX5wJBKOFKpT4hNBD9tXrAxpvUxvZt2lylyI6Fb/4hVxKv5sLXjdGpwDVXi0rjrPCV+eKJnjOF/WCYiBcHMtwcDhkWIpHL+zSt6e7/exvhU89GHiri6TDSSH+MFJmAd6MlVB6GOxqPYJeIxD3IBIQF8GgMbPiYtY+fm9kT6l/HsE2TMnT80jx5jFGngdzAAv6fRPL8/LQ1MIxQ/6ZXuJ/2rgeFwV2A39PmSOuwx2boMzw5J6dhi7HyUP1/r2TC0J8utX1myRQ48E3LtMkciggv5tQoJJuJgMNgOfqsYAJCZ+xNscr3pVDxuZyXOv+XF+bDGOYius2Ro1wqPQ==
Received: from SJ0PR13CA0228.namprd13.prod.outlook.com (2603:10b6:a03:2c1::23)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:31 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::dc) by SJ0PR13CA0228.outlook.office365.com
 (2603:10b6:a03:2c1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.6 via Frontend Transport; Fri, 7
 Nov 2025 04:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:18 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:16 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 04/12] virtio: Expose object create and destroy API
Date: Thu, 6 Nov 2025 22:15:14 -0600
Message-ID: <20251107041523.1928-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad5d9e5-2665-4f70-d194-08de1db46e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJVpShijh1OsMRir2ZAPwideK5VsFgsRIYqburo4HF9iaxiFJr7hjvz+tNFQ?=
 =?us-ascii?Q?svQ7RElaOZZ/GvSdtsimr+BkMNmuHUpF7ZXBQ5GoYfg8r27UYh1ju38gqA52?=
 =?us-ascii?Q?SzSkCrboye2Jx4IsZmDCO3/A0DsoiboyulS1/YoejqaIX8Zmg/zLP1Xr3b0O?=
 =?us-ascii?Q?gD9erDUOawGKuGYCFfMu2TrLEYFF8XRvn+bqD9qJ1ituzVSQeoUeaTpABLLm?=
 =?us-ascii?Q?sI6JbLIDvCant8nCkVJHz8JBisFKfnLyANKiB71SOb1zp7+bhfqpKYm4vSrz?=
 =?us-ascii?Q?3e3hvwADXvK6P1FUNNTHuFa2BmoQFr7LB8TYkTbDK3Lp5PlZDLdYUVC67d6Y?=
 =?us-ascii?Q?r5x/4D6TxIPSuivxyY7taWKZjXUy2YU/7AazgMH04TgoprpnPQSoriFwhIBN?=
 =?us-ascii?Q?PfXPBK9sWKrQATJshkr6GM8rfTS4nN40GXiIWwSiG57HfpMyu8XowpiPSog6?=
 =?us-ascii?Q?3JVJWXVtjXAiE60Mowiwu7TM940aDyPcc3sUfm1u6IxAMFir1M3KVGYT4Fa4?=
 =?us-ascii?Q?pKutUKmMbp8nuBnrSIn6Ze9Ru3XrA/jlnXhGymD2Pi7/uF5So8fxoTJDM0+H?=
 =?us-ascii?Q?ALKcCDnn/MzZr3osDGuqrWxNo7O8e6aQk1PfR2WAGjbppFA3p2Yi9Kn6FZlC?=
 =?us-ascii?Q?j3ckE9JRh3ra6gVLcnGtwAxN/1qdJ21Cth3PGcE9qTMw5N0eMbQH215rUq0S?=
 =?us-ascii?Q?eEbruu70SzaK2oppVyEkYzmQ/tlmJzhLjtPNHUNxUVXJDIJoQtgGhzqsSJz+?=
 =?us-ascii?Q?y5/GEF1+gVLxZyEnSvJYSgWjZ07aq2KdqvQl9Ih9hN9RGshHyFWEpwmqLTCA?=
 =?us-ascii?Q?vllKN4sVT//Xv2H+1etQkzd6vbokqElGgPqJLTlcNVfdTUtM4j0ryhqlLzBG?=
 =?us-ascii?Q?eELejXvM+Q/fIlRUAsaSE5eNPtR9paiIc0qzItuwlQbfC0FzuBTKmSikRvH9?=
 =?us-ascii?Q?xfG+gHKyoTUllDDng8GT90RgjleQ4FDFmi9Cqkq3+RcBxH1+c64ZGgiFRWTa?=
 =?us-ascii?Q?9RzQEontH+/zyclNMRSspbF2IHRM9ip6QwKdjr37HJ9gP4MB1GPc37s3BEvq?=
 =?us-ascii?Q?h/PXGgBybnElpVcqyokV+HooELEjirGnAwv0a/A+jHftqbJHGnQJtAchNxl+?=
 =?us-ascii?Q?06aFu4sf9KAyZbJcgHjY5xfisAHtI/d+luyd1tjHrOVw+/3RNiliZeCMeBRg?=
 =?us-ascii?Q?StHrcl/jj4/WgotFixCG9t75isfa/WMJIfDyP2jr3CZUkfk6vJE7gZMlFBpL?=
 =?us-ascii?Q?n/b/n0ioK8YNvpRJT09mNDaEN4zv4aAPunNvVUQMJG3zUzwV4nUsCbipLlFY?=
 =?us-ascii?Q?Q0FqCbtUt9KU5hWtVAY3B/KPdL+6wOdjHwrEw/4dTTMMEOq1tazQ4ofsg58V?=
 =?us-ascii?Q?jSdndjk3V7GhzyQXx7NvagDgrYNKQnGAGE3vNH9p34vjs5QzCJiPmt5ai7Ag?=
 =?us-ascii?Q?Vhamb3Xkri7J1IhYCkv8tTL9uwE1NXgbJy6qG64KpJNByPtp8Pk8N76gP6vi?=
 =?us-ascii?Q?esM+37uqSfgdpR/skgZFGoEJNjFS2RI5ogAajOgmOvay4TnXGFZV9rMSfRms?=
 =?us-ascii?Q?ON/Ysa70d9ryw/eRxdE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:30.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad5d9e5-2665-4f70-d194-08de1db46e06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

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


