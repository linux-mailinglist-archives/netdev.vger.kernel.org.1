Return-Path: <netdev+bounces-229866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 393D8BE1789
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5934FCBA
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561021FF48;
	Thu, 16 Oct 2025 05:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mkPYCcOX"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCB20A5C4
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590892; cv=fail; b=g19W69VPpauiUBrgYbhiizW3JxP+r5tsRznwulpL6KZXtLxWV7PyEsGyBOXthMzYWH5swkybS0pWBmEYhKfvqhKlb3litT927CuC5pstwpA4XTJrQN2fZd3H8t35+rInBm0+pgXsuOPedaVxCkLGFKY8yh2pag0AHtyy5L1dVyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590892; c=relaxed/simple;
	bh=wfnB8j7gZfnXUg54cpZQ0mCIVkDPACpJ2aDKdUqX1yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMMz4NXMzEiLrtzN4X8NKDiU+q3Q6u6vbYUQyiA944Y7u0K1QQyPK8m/HQQnKcaDdTk2u78RE7t14KeThxMCrE7H+NsN7crzZywLxszJNWfUBWKwJ2WJzOyErJv4GS0IISzc999ENpuGJVeuS9/gHcu6pgOXYz3ElrX7vYMVnRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mkPYCcOX; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEcyxZUJpZxm6UEQ1qq2f5sF+iSIy8ybB0GtOSUEhiv7Xi5mnPSGUOp08nBsbuc6H/WHWNGhQMIZJiOguvi/qBTOxs7c7csn+LA7wEUYTxSGwRSmFHnBPMS4opjrMxqNzgzHDsMwsO7nweGOqxahRuXglvCuy+pGFkvx0mmSvgdvel1mM2PQGUcPb+JjBvKokt3h9L9QUtzZNhXwJER5ABcA7LCctk7o6nFoTIN2BrjlEz2wZHEes7IijMesLz18kGiKAVSmk7Lq+6IRziHqlzR89RxPW4ocRenJXiMXZU512Zmvpvj9m1Xvu+8wpY9zI7B5Pk1/nxEM6g+my0wAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XQr7cr3ejVCj2QIotWBrSOlGSo4AhgShMN7J4kqAaY=;
 b=lWfLATbXv9krO+U4nuSRiyVUDB5Gzq9oVbGqzZY966d6MoWP/9uBrFoVSb7tuKdYXefcbvQFKtqEK59ePud7Q2N6ilLKTDUmWM9sboqQdmfTA3WDCbDxkHqDkB4YG/nnS/W/6xEZGQH2pve8pqqV9Ky9hav8PBednSMwmUWyLmHX2bxodpc5wo5YRU0Xa28SAizN0gWrj3+bLrxo+hdc+DsxkmT7pXfCiu/zD5qr7gQLVtJMA8L5pTXzEIj9eO7WVflhePdAUkfxWVUB+4EaSxBCESe3IRl4qzBvVWsWs8jQxd8n7k/kDtPz+4yiTQnQ7JpYxr6sY3dlU80Uj50+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XQr7cr3ejVCj2QIotWBrSOlGSo4AhgShMN7J4kqAaY=;
 b=mkPYCcOXHciPC/3eFsHULaZAp3JELqLeqFYge5kGJkc5Kq2I1h02NvOizxZMmsxvFPPZwHfVM75akladKTWQwRiBio/w0akciWibye0ZNdWSkjB4R+vuXkpugAjxIEEFB76siJi1Kmcif+4X6n4gvPGejfCLODmJ4Jl7GTSb66DenGDgSi00wNXzqfij6RdGRnm7fWQFVuXmSCBKfzCUXa+so3S6wx3qdClmc5dk/Zz0NJX8Y3Z7yaXSNeoA8se4dI0NVJVWMAYvrk88sy4t4j8Hv9Bb3T04C9L8IBXUiweuYdESF/lsb1m7AxEjeybVshbkSo1/JYiJzuCzQgFLHQ==
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:01:27 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::be) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 05:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:11 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:09 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 04/12] virtio: Expose object create and destroy API
Date: Thu, 16 Oct 2025 00:00:47 -0500
Message-ID: <20251016050055.2301-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 96d00e7e-a59f-4d71-cead-08de0c710fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VQ2pofwAwtrp4hfsp1AKllBYjy9MUYSOOUfzr6kpArXc1isfJmaOly8cek3s?=
 =?us-ascii?Q?kbhW/nLReoUVGitZUv9+16xDv2LzMsD7fA4lNJv783xD5ZiOHBMKK5fUzK8m?=
 =?us-ascii?Q?5t4h1OI/g3zaZkkLMwYmlOEcQ2G78C/OqKsyEqY8ad+ODync0lE0e/4Twtv2?=
 =?us-ascii?Q?p90zPWxcjkbD+5WbOyWw2ZHNNvGuQMYmuImJwtU0exkfZu96nC5bEEoJcpoE?=
 =?us-ascii?Q?RG/97u1YV2ByjjCeHGxqJsIu+4RhNnMbyu64H0vzDtHLYB6RWh0kBbokE8j+?=
 =?us-ascii?Q?hGm/QGpyTXupcYfr+KSvyaKGBPK4Lm6/xIttu8nBt/ZFQUrxJSRoC7Ju24uA?=
 =?us-ascii?Q?+VVYej7Fkoma3ttE2r4EKyJHHOjvoTYn05meHh3qv0hrJgWdMNTFVTRaoxdD?=
 =?us-ascii?Q?nVWQVngh//r/clk5puCShjsaK0i1U1sSmqUVzPMOVq/YSbDT6f11Q9VHtdnQ?=
 =?us-ascii?Q?NBMd0b81yrk8jru2Cqj93RRzxIE5o/OkJMxx6VT7uBPbwK9Ik3RPgKSwv2WZ?=
 =?us-ascii?Q?ZDHX9fxD2QsjWQc9mIeW13cRVIYc3nQZ9cAveyOc7kk1F5NapsHYEg/Efqsw?=
 =?us-ascii?Q?XS2IyNh82bcz3ppSl9lRJb+tULXuzMtxp8aXvqtTdQ+p7mBpnaHwr3PO+kXX?=
 =?us-ascii?Q?Cpgv2at1VZujh3unhW8q/22L800bUGoiCS9+J/D11m/GcQaBJ7y5nKY1RdYM?=
 =?us-ascii?Q?8A2Qfyw5XhTVWJ4dTHxVybW0n2X7fUEJLmFhvnYP122Pv1+UFIG6yAjp5Ozm?=
 =?us-ascii?Q?71b0Ew8NIeChSM1uEiw6MeWqxr04NKjKiymxMaYg+RDoqAOXN6RLfoEmnNYQ?=
 =?us-ascii?Q?CEVRBApHoYbQWN2TNsdSQf+v1T6YYJs4zyAq5ea7KIe+CdN/vk+BijPsz/7c?=
 =?us-ascii?Q?7Xu3MrBUzI6GiMVuC1qJzE4kv2ihCHK69AuIrAd6Abz7Q4Kkd8kfxmQBq30K?=
 =?us-ascii?Q?HvxX0TSwJoGh4VKyiFQ4cr6UG4jpSOgCknVyjHDfhHjDrhPVG7yroER3JuW/?=
 =?us-ascii?Q?1R2Xcomh3B/Pv0hoAZvN56kEs8HjXUJRCN8GyXgayeZOMBozahk3vtHKwflX?=
 =?us-ascii?Q?zMxnCgBSuIaW55GsQ0Nag22w+qDyNnVbLbZDtu5F4ZrGaMkhah3+l2OA6j/F?=
 =?us-ascii?Q?Vpq2ZZU2PQZi2sjN8lFHp39kb/W9LUc0B1eSnYEBkP0VmRcwBm5pcNCjpm5J?=
 =?us-ascii?Q?S9znfc+kL6zjrp6B+mZa43H+PXcDppRy2YI2vlxvTS9Z/preVPWcZgybu4vN?=
 =?us-ascii?Q?s5JGbQiKIs/YivZ+gkRMCbVpn5XlchwjX4LKZI1MCk2lWn0Vuo2CP65Yizz9?=
 =?us-ascii?Q?BRVEf8OY++Hnmqi+H1u9YL9JA97UshALZGJxfjbO5aBpHNL9UsUZEwbJEgQb?=
 =?us-ascii?Q?PSPTiwaO0ihj669vKOydpgRT2WtVtgkQ30PjUt/9PyrbvwieM7/zxSqLR+wj?=
 =?us-ascii?Q?vHClatEwWgf4WjO6HW0MFBZOIAxdlkDrmlwIEdLAE9WqqxI591sqTXYG+SAm?=
 =?us-ascii?Q?qICU7/bFh6de2qaWG1fWmB2MnX1UwfgQiizL3afGo4aZZATBDbQTKft4D+Rq?=
 =?us-ascii?Q?57T1ePNK4dUXMpAA4Yk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:26.7946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96d00e7e-a59f-4d71-cead-08de0c710fd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

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


