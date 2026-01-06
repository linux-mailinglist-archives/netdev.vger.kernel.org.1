Return-Path: <netdev+bounces-247402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C119CF997C
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 18:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E85E73004E30
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FF338586;
	Tue,  6 Jan 2026 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LaXpTFZ5"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010066.outbound.protection.outlook.com [52.101.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61253370F4
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718325; cv=fail; b=sM+qhCVH/Q/5mvxeNFO2rA95KuSHNbsJpRD5tOS1KQ6JUk16BzOveQ0w2TrhL+SSRGr9tWTPdDuEJAgBlXrsTzVjIRqsmyuMnUjcrno7uqfR+yP1nAhwCYkEE0k7gll62AGor5Ty0KeLBPzvMuZt0dONuVlddtMogk4nd5JWs1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718325; c=relaxed/simple;
	bh=Glr560URxqKTZYR1B/4JTyiFscURg11/WjW/lOK0Ll0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrUu/ysiVPw5ytD4mUHgfBUxGvwX3FJcavLHGLEKDO1bUK1fTWvy9lRO+EWyAClWQmP1O41fRJgwXMVSr5+2F8ZmTSXZC393iK4W6bXqpBWs23DEdZOabiBCNGnKor/WdNX2gOMTCWzTuFQibjI5qLme/UI5V5cPRnLSJrLz5rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LaXpTFZ5; arc=fail smtp.client-ip=52.101.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLDOtLa/Ugighbnm/ppI2AIlUVU7xUpnu+2oIrOx203urkFvONuaadncSenv8MTBuazQ+LH74pHIcYgHG6D24v2oWDMZhQTeYTHWEcaP/wGmuIGuRqXz+yIPB0smfqutwLuho+N4kGbOrmSrnrJCx+rbBYOXoJhyEfG/VA8ydwu0OEwcU0XY0xJagm+4cWjNDA7Oc9mU6GIHctg1ivmdLeVxmJiahN22aoQkcUz0+3No0X3UV2vloAdcoAEV5EWXNKLGRuD11EnWPhA7kmdkNv3WiKoEigvunj6cq8V5Svwgg33xJlN6VD/UFJVqv62/dmSDzcfxSf1tqz8npC0BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=CD0x+HP1AsLxsagzJTD6LR9Cu93aMOzoZUNwylD0jDiBiaYr0ZX1byANuHED6woj5YgvOvWzuAwjZhwlLgJiUiJ2YA4UfAyq6OHVZ8L/OCw9hoQehFKKlnQZFkqtTDKr9Lz6DsCeQn/9z5ri5ZEl10XGOhdxjpk0QKqqVPy6z7M8oLSzmi5wMq3/ui2zGgOWcQiYRBHi/Z2iIdcNczWNGg0fVx1reT2Zax5a5EIzsecOsiePdjemJdknRoWVsAVbQUB/R0e4BZhbr5XVs2SwhRU+HKDees7NJZuNHaAE5qZhWYa/C1a3iNgDAdRpl5vuZ408CBBn7IxvKMkGMC3giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=LaXpTFZ5t6x/eEReNaiV3COtTIi7Xeef7UISYl6K60y65Uj3GjY/Y1eVdxzSvXcTzUkJkCAP73b+x+l8TX7CPiUbQWQgOLm4ZSxZrMoppow9d0DZunHBFB/7a7XagA+azyMlCkcNsIVpdvP7nyQc9c/x9nVXzsJKXvdNCIzlPJFPkWbjdBDsFPnJ6p8uCE6T6vBKCGSOfceG/mBUvVxziHMYjxpzsMEXHVjYA6GHierIOtYXSE2BadmEacd32Ufvop0GwkPWR8yQqpQTGxvPUDn76GWWp41u390AgwJoLwdXK3tfmAY7Gdz3+A1oe3ND0iAg+op7rVOhC1qNEXXd9g==
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:53 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:5:1c0:cafe::c5) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 16:51:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:30 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:29 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 04/12] virtio: Expose object create and destroy API
Date: Tue, 6 Jan 2026 10:50:22 -0600
Message-ID: <20260106165030.45726-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9cd59d-ddf2-4caf-1bdb-08de4d43e4cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NubS4Xu8vvukTbYuKuTt6H186mSFvXqOovE7ouGpu5nBz94mFsZMq1fERfrm?=
 =?us-ascii?Q?fIoDoIXFj4bObdIK1SE8Pkez4GOfq3bxlfA2Sg2S/MkYrORRBXOaBMwwnR73?=
 =?us-ascii?Q?IVpeyLS7vB6Za3AvUFXeC/frE5aUL/sYVDaL1UmAPMmT0mk5lYHgAzZy9GLk?=
 =?us-ascii?Q?50OmQXBvhi99K8zw6T0/IYyuXIyLo+lJ9muOaU6xed9HEuVKoMP5TbXqPm8n?=
 =?us-ascii?Q?2C/uh6xq4fpm6rKrcYUBmId0bC/3lm6PTTs/FUWEYTvBjhfQrMCRqHOEejN8?=
 =?us-ascii?Q?URwrMWoS9wdDtEjwCj2GA1h1rKyX+2DDzs1FOxB1cbUldPj6gy1quiz2eJNi?=
 =?us-ascii?Q?KT6xh2siRq6R5fhiFWua3hJww4CMNmo85It+bB8h8MyfeqBHzvgiagRRJODt?=
 =?us-ascii?Q?oGJNM5cL20/liDrt1HyDXdfp7j1h7rHL4RNnw/JsQQXadzxxe9QhI/ZC0uK5?=
 =?us-ascii?Q?k7gq3Gi0/muQj3nmAEkeBuCIRGlVdzrsjTU87tmBecW1zF5qmUQPgm+N8zbF?=
 =?us-ascii?Q?8QD2yOzRq9IlYgvWFLE/p59EtPb8a8h5GbJC0A6XJZfEgwNoOyOS+ek3KlkL?=
 =?us-ascii?Q?kxlnbIQwn7ujF/qBUrBnmMTmB8Qdew5ssKP0OHWKNE3ACf0/1V9Q9SZlrcca?=
 =?us-ascii?Q?YlHZP3d9aIBHUiZRB2z4JY25fek1OEnTBjUK+0DwS12Zl9fqa80wDo8/Q2Ka?=
 =?us-ascii?Q?r9Ht7A3kj5/QHMaVFXUfk2lqQr8xoXxEaaLkZgAOXfBgDIE/gYxUVHjERiKQ?=
 =?us-ascii?Q?SLiyRFETcRr/DYTH0R8DntyDJe2i7hUbudqhWFHpb3IReCoFUyAY7bcu/K3/?=
 =?us-ascii?Q?OdzQOWk5mgHE/Nons5gJ8/mwMN+KQ8Kx9WmlMfFrv+/gk7+xukCYN9uRG6Ah?=
 =?us-ascii?Q?pC/FtCDvdY/VpCDZDn/sNcBTWiar9VN9TDmbNtbEMO7x+asfHU1273qgI+7U?=
 =?us-ascii?Q?2+uPTL4YYg+RQMhfIXtH94BieelO/TEUZqDcceecY8YrTmNmH3PE2JlsEv+f?=
 =?us-ascii?Q?pqKImXe9cXrLvjatm6h0l/SfpkGG/qHwqScR6tkkJN5Ki4/+VgxPD/6Q/Q7o?=
 =?us-ascii?Q?vKp+Oy5YlmXDAdmrJoLomu9wgECCfst3MBTrso8LZ414meA9n8IdUy3kfzsK?=
 =?us-ascii?Q?0tMytQzMndRFQ2b49k+2eHq8t9C4olrLt8Xf9qhxWVVzAHuFoCgE7WLPbk0K?=
 =?us-ascii?Q?gIZ3vi5pSDwZGy4oL9U17BSFKuxGlPcG+ZtwyFR+2rGZuvPh0Lpmn2lnHBMF?=
 =?us-ascii?Q?bphhZCB0dPW+csZwkfud4ykSUa1FKC4bGlfqXbMVoKEY+KcNcVWlo0YAOBbI?=
 =?us-ascii?Q?qkEJq5KkawM78Q8wVLrALibO98P9BAqeqiLPddTC4ZUOqDmVVtLqdaJrDCmL?=
 =?us-ascii?Q?+T8mjIlWuNZOxc0aPrRX/QPTwshqMdj4PMQ/HUOYN6+7pjd/99x3/ZKB0wh2?=
 =?us-ascii?Q?9eiLL5mHB7XNjnTm5Sk4rhqwjuYrjxcp7NTH3R8Ij6UQmfPDb4UalV5C2vUT?=
 =?us-ascii?Q?VyH3iGC4lM9I4LR/a6ITJXsa9sDdM1XbXmG1oa7Sz+zFgrZETIBJBa+EZCRU?=
 =?us-ascii?Q?fyff8JIo3BwVYGONP38=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:52.8419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9cd59d-ddf2-4caf-1bdb-08de4d43e4cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444

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

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index cd000ecfc189..557df1caa85c 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -92,3 +92,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
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
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
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
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


