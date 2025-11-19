Return-Path: <netdev+bounces-240122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CB3C70C32
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 416794E12BD
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EAE36C0D3;
	Wed, 19 Nov 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWrgcHzv"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387A368294
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579773; cv=fail; b=Bj28giLUHsJ+zLiXl/Xi2rQ8DZPhHVWfKbJpsyfjFuFRj+gCMk+wG1lxul9eiBc4pdSr/qixGpvsMl4yqqN3NzM+GZD5OhfcALj5WzTAunCX7GCF8mPbwR9H51clW5Yw7mb+MOAmm+y6jNH/kY4SQRXCxezYNTiz9MdrBWiTpsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579773; c=relaxed/simple;
	bh=PFjC2oin3BnZvxggm6tH94v/E4fQCGEa5oVe6nMT83g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kC9mHa3fS306V9X5Bpu8V7lgV6jrbyHywWEEeSgWuHVpsCeqYYLe0IMh2OtMJ/B9Twc2HKsYWyk2a5wvSWNs0E0mpFXW+0DOo+FbrSIsVBjmAUAFXyD+AcnT1K+eyWLOjSuq9jFi80oE1oDGOy60RXSvUt2oYzvwPobBiBNN1ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWrgcHzv; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9yKXEU0CyYAMeaf5n3kY3PuhRknt9ZTb4dANxE7Vowsf79HiXrdHpSH+Uut8shsCUPCN5xWOo4hxiLG3msnvoxsajgEn9lmM66g2RoeIUQXiIY8h9133+4GC5JreDuBKQoZZxEkZ8cUxhJ1+Y37Fqv3iwrkLhyPmKpaEaY/fJ0GbfzuZiyPozueNBxvxKfJiDPo8RGaufKLQsB6yK1pZqJkTO1VFXEbENfWk0BEjNyvjaN+tyueItFivv++toFsMAzY7N5KGcnNxCrJkSIe9UeQP5P42LVFzqxdfOMINx8PJUWuTqbJhMxy2d75b7+9gSaRgUJSEVStcqzis6Zxxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpyfU8srrJgpXrtvL2WF2CB648gYIuHJikd5Tf7Rkek=;
 b=huRCGACGfQoI9qCO11LtM8Ttw2M6CWFi9mLFImeCLpmIAoJMQEOgJdhWsFk/kFzZi0XeSrhTiGxMIsMtmI6U+QLIkBItQxG6G/NixohDgWtS9UXrRJG9l1oEwyzBUf/yXBYw+ZzLs0O47wewu+8tZxzQb2untEVwzrSNk6o0rpxZGG0AHtFaTYqiA9qEDaGCGaIV3r861H2+jK0OywnzdTdGyJg3uweCwSvu4YToqqMTnO+FivpYyhCMt7KQ56NTTNfjYihWv+LWX9zrXBoMTMjXk+WZYXANMZG8EB7x1eI1zB+oPmCGgc2wz8GAXKtIhkfH/jI6e0py2DbcWimkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpyfU8srrJgpXrtvL2WF2CB648gYIuHJikd5Tf7Rkek=;
 b=sWrgcHzvqKo7UhdObJAL057F/VN/P3of9N/mPi90U7vQymhhd5FBzxoR5g5hdZjXswMwVrOg6xqdnvsHjwJWlN7EHHTWxwPBM2hpht0Zw1XascV/sgFt8N0skUWzmq5oYcsIY0i7v4Hv2uEVvuTeq7GInIt28q9kzgSfdb5T40Jmh+XDZrzERwLEvjHxRfLukgT4SU6sgB5eSFdXpnzuDouQtzB9YXcXaOE9esn3CkLLH0p1495NwLejrJpVsDvHxmST++Zg6lQ+1Nz4A1845KBeqummiVsw6m9qtUiIMsvxT/eQcwDXqZnelPXIKRaE8T/MaYrBEgR04ZvCkX6M9w==
Received: from PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::22)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 19:15:54 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::73) by PH7P223CA0001.outlook.office365.com
 (2603:10b6:510:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:36 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:35 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:34 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 04/12] virtio: Expose object create and destroy API
Date: Wed, 19 Nov 2025 13:15:15 -0600
Message-ID: <20251119191524.4572-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0828d14a-3013-4f6b-c6ce-08de27a00eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pVAvJBmyTvoXPS3deM8v7vZrWhQUI/OBkaz7gI9yetKbZkUAXQi2iqQzrNnN?=
 =?us-ascii?Q?7m4wQ1blI2gG7bwKJGV4svUhjpYQdKPKyCvepE/VzxeoysFJgqBORE9+2FAU?=
 =?us-ascii?Q?db94GxvOzrkPlGGehhTFovXLLqwTX96pviRpMinSKkMqFwWVtDiEdj9djM1Z?=
 =?us-ascii?Q?JoZCwBUn/TkPVMY8dtoqGKpOpdW+OXFP1NiKe8VqTBBvUhor6JTQIRtsZl0v?=
 =?us-ascii?Q?24zEhsjR4ppWP0ZxfvSl9T/GfcPqdSYYBsFs4DwVTgiNMZzzd5hX0YL2Q9TK?=
 =?us-ascii?Q?/zoIz1WkKvLTEZh6ykqbyfy/Yd4dwodnevK6UadtNYyvcCoQ7YHu+XHUwtU5?=
 =?us-ascii?Q?DmYRCTeYC/za//f7JJkUSEl5s41pFtLTPnUL2vECXiC6LW1PXDo9VatXzXy3?=
 =?us-ascii?Q?yqiiji6GOHYbEgN9V5toB8oLSyG2LNOfUvv312tysS3bBcPQPUZEy+Bk4NXF?=
 =?us-ascii?Q?Ac4Ytk8vge0R9mj276Ygyz+duH+RIbC33bfqH7vhTBazd8phEbm0gXFyScFr?=
 =?us-ascii?Q?y8wL/dge9nbND8qzos1NAGBBrlrXYGZwEgndpUYWeGhchEIy2OIwTOjvf2EQ?=
 =?us-ascii?Q?QroUceuane4ngxgAuIbFEr0xFCbKYcf7YvEPCkP7e0AgQA+c7lBQifUKxHoK?=
 =?us-ascii?Q?+JuQmpb7TsmO7BnkQHE+wONTwIQtLS3XHx5O4pl02wuRLr8F7qqeFLQdUwjt?=
 =?us-ascii?Q?TezgmgrKaLe4jQtGlVPUAp8sqy7ltfyBacH5WVwZfW8Q4Wo0tWFDJf4DI7qr?=
 =?us-ascii?Q?fXLGdhZra8wkkAwPSHw0icfzTcge8Hz6Vye4Z+lbtOpdplnMnU6Ds60Mwtxd?=
 =?us-ascii?Q?CGRVSbabrXa/l/mWyq/T5W/lQmiEwtZmkG6SS901d21UzyqWPJkxQH1j2JZz?=
 =?us-ascii?Q?f9gGDVpXQmARc1czJ3BUJ76T43wCmGvUKMIPNIhkmYqrSaw/2fACoXkiwbG2?=
 =?us-ascii?Q?vZwVk5ly+YA/ZJReav5WXfEhd3M/aZLTEE/dt4e+FsaE78ok4d0fI+TOIKla?=
 =?us-ascii?Q?V9uJpGoWEt1v+21hyjnBS81h6I+PgNiHvCG8ZNA4NieQS66jC0wbdjsbrSZa?=
 =?us-ascii?Q?z9kC83egGFRzb3jnWa+pz4Gra3iVogaXZYypbhiPkJjhYAjfUshTC7QUlqWt?=
 =?us-ascii?Q?KXFjVVhOMHGKx8wHOMLCvjv+p65przcqCUBvO3dGc0MEHYelZCiltuDj8XCb?=
 =?us-ascii?Q?H88oiIJmdsQ/NLYYYweE7s8wDnW+beUa8fM1YiFhr2RZvOZlJCNI6jkiBBg+?=
 =?us-ascii?Q?RodH0vo/W+zGJBu90WPxlYc7ij33GfeV620kXDKaB7AIEzVc1unjQza+Q7oP?=
 =?us-ascii?Q?aVwYTUTlTmUHcmAVP6qi456wZ063c2TnqVgfRo8hnD/g9fup3zHitEgovHJG?=
 =?us-ascii?Q?QkTjUpqP8Nb2ESxTVWPy2hPzbd3+jqZSbmdO9Kpxwd7YfsmzZbU/30vDEGhR?=
 =?us-ascii?Q?R8fhnNPb4xsdi0TQDYQy+k7o/A0OzaF1LvEjwhNQNQzk6RzlHpU/Qdcy2mPp?=
 =?us-ascii?Q?JMbUEOJP50FJ7kgxAO5AQ4gDlWn3U1jcXgF3GfrAjbC3oKrFpeAHXjsJ6I1N?=
 =?us-ascii?Q?s/6e9bpWH0bOZa72keQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:53.2008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0828d14a-3013-4f6b-c6ce-08de27a00eff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

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
index a2254e71e8dc..4738ffe3b5c6 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -89,3 +89,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
index 4ab84d53c924..ea51351c5a0f 100644
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


