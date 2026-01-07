Return-Path: <netdev+bounces-247835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB4CFF189
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3376830146C3
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6629D359F98;
	Wed,  7 Jan 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T8eLBKvq"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465D357A3F
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805504; cv=fail; b=MxZ6XFXV7O6xrW9HFgQR2mGFVOI+2hO3qLi6+IoCd6mTHC97/NatC0MyVi85Ou6BaGKTwojMGy1viTpFiAWfNOvxlne5VQ+A2KNohWRtswKSJ/IUieCPbPNqGS0dBH349J6tEU/l3SJ7BkuFK7VjShfZ95pQJ0SZgJ8/Bp/y6hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805504; c=relaxed/simple;
	bh=Glr560URxqKTZYR1B/4JTyiFscURg11/WjW/lOK0Ll0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vae2YEtXDTwD/9LiQtV9oEG4nRYt8H3k+7s3Wayz0/9PfVuBGCu9jLibNfsW6T8l0gDeKcmRcMDbn9Y+dgSlNWGNBnXvpvnV7W2LqRXXi0cN7UeNp9MoUOKsP736zBJGMZWeBVjHLpHypGIbqLHXzyNBixzIQuVI9OL35DnqwZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T8eLBKvq; arc=fail smtp.client-ip=40.107.208.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp19CVy75G9CcH6XXKy/CgIYECaMtWZtIOmN/3gcRc6Ex9T863Ber4J/KlKbO46RqWA1iw3VxHPRI84Tu9Zgz40VKqsAgs+sKBLgaqnJuxROuyamdhIiQHQKkZjGLuzXaHWwL726ynn+RH4QoIGCI6O5BWrICQmI4Vp04YirADK9PIGKzaO3pbXZOjdSv65AnkcTvTOk3g2MOKa49csUywUJEqOrdCYC8xPf/SUBoZFFekop44N4eZ+2MgDfPZjIv1rSsaEFLkTnHM6xgFq6oMw3LIFA1cErrP3HZ0S28qRYFbDUPd5ig+ZIxUAwckuUHp+6MLQr6x/CTI6gL7Fqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=aDh9LtMLLkC7iUk2Jyt+xfue9cIwK4KQPYOk7Rroi55PJRXQdw6ULDelaVVH4gjf8EhwpPWWdbzPsrmxIa9BfVAZPAr05LKxrvaFYeukiBDTge31OT479q0AXxuXdwP2r7WRBl41cRn+Lq2K+cC2PGlyog91epwOsDkfViToDF7g+HEYDBqlOgRDiK0bbTSEHSANLPuFJ+Hdl6GkkyP1S7eCjx2UH0DlzrZx/OKQhO6B+tIWm00YKH3wuOYFgxWernVGSIplljwk/pkrZ5r3fz2PaN1zwvxClO9db4LUyPSifSeROpRCc/QeWSSrTJ1hziuXqNs9r/RYsbKaVO+xNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=T8eLBKvq7CQBr8JMQhWJAf7h+KZym4DBH++oZtI/LD68prvVc3ZvtLv3TZgAE4ss+w5igGa5WeHT6wOFXCvvQ4k68Hz9YE6EMtyBzc5JsXQQAZqghRcMrkBBmOy/S2ppq9Ymkgz89htrhFRrleV0Ji6udUDYM5hZMJ/3HqoS0TAHq7DXygGhm8LmEbj47iPOnGo3uQrYDWFKFJs/AL6YkA2aidECaiDhgM0fSmneDkNibE+afwF7/7aN8qIiByuc9RDJ9mxCLh8NEgnpMFOzP0fGMR9h6SBsPKk0NJZ3/M+/E47hNpjsRA+dyCa1jz+jlqZ4E222+db3soizK8O97A==
Received: from PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::6)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Wed, 7 Jan 2026 17:04:52 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:510:32a:cafe::c4) by PH7P221CA0020.outlook.office365.com
 (2603:10b6:510:32a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Wed, 7
 Jan 2026 17:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 17:04:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:34 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:32 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 04/12] virtio: Expose object create and destroy API
Date: Wed, 7 Jan 2026 11:04:14 -0600
Message-ID: <20260107170422.407591-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a1cc30-1ded-4503-cf5b-08de4e0edfcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2sgipmNzGSc3xHa5Lw5LMrdsvAOxts8DUdcwUKlUWwEhHjKVjAPsujAADIt7?=
 =?us-ascii?Q?wZ6cJGdvdAhzyXUKTNswm/KHXVKnNs8nAZda3fl67LqupbsqvyD5zv2KtRbm?=
 =?us-ascii?Q?mYJdoa/fM91HfJOualS+4nxJvdT08Fo4P7iHh9RNpjGeWX9c3dAh+2yKVJcx?=
 =?us-ascii?Q?7IIDhL+LXxXL0F1bLLuaRiCZGUO4qhQVrFV2Kn32bf+dop+svqGMzzVRGkfT?=
 =?us-ascii?Q?NrkaqY3dQ92VXyWfxpDpM9EL3svWc+ha2haVwumCDLqoGnYvUj5o43UEi+rN?=
 =?us-ascii?Q?lMWJ/7V/RZ8U/Mv+3EEhdjjysM3ON21vw/0K4CkYslXrnjNyH5YCb1z2UlAx?=
 =?us-ascii?Q?aeCiqsPnHWlrunTYRljqzQI1Hf6n+G0VRGg/Y0xJHweyCkom53UGeQaQnmO6?=
 =?us-ascii?Q?B2MAI/XXl1c26hjQpSTomi4FoM2DFXyyJ44CRdz9Gx1QcYW4cI8mbHqXJ3X3?=
 =?us-ascii?Q?ULPYT2/OEfPLSE4ap3htxQVVqfSmgVnZOG3nYp6Z3E1rUNXPYgj6M01z8m+e?=
 =?us-ascii?Q?IftBJUZP62Fg6afmRhz3+VP8pl8uj8z0w22Z1671iCia1CtBu83/lEBTQpWI?=
 =?us-ascii?Q?Cw/FLtkENu3WUsOtwZdfxa+XwI32D/7sK6ebNcK3nychZwtjNeEeubjfPWbB?=
 =?us-ascii?Q?Tt4ILoz2IDHBYuFnxS5bAFagoX5mUYm692nwlra5Vr57wE+Oe91bFhJ5kyRJ?=
 =?us-ascii?Q?cPx7WthQgIdj28VKj2swryv1aTFsWAAJHbcNjltmRe6oQCWOjN96nUgzcHgE?=
 =?us-ascii?Q?LeAbslI9iL/rd4JWXTiT2RvmKPj4EiTy6odErrJ2DP7OXZenuA5wlFxqse5B?=
 =?us-ascii?Q?ccSWYLcrXjCjGNNN72IkhIsd5X1xhMgnco380T8bXvm404IRe2gIWUJM45Vb?=
 =?us-ascii?Q?9eIu0QEKDnzpnQ+nfAy8UGmF1MLNLpu6FDm5xPvZLtwxCDkBqHdG4un7E5Wu?=
 =?us-ascii?Q?wMtaWh+SbUgUMxHFUltRPU71xiopgEFAMkUFpPV94sbtThcSUDhrUIP29yp5?=
 =?us-ascii?Q?+TyRmrqBoVQQUhieowEWmK7c4R3KeKyM3vqEljwF7z086biGYLF1N9ytyENQ?=
 =?us-ascii?Q?8+Us1yJy0cjB+NdzxtFicmIWp1n1pcdrFxY8GXBduK5eqBZnaD+jnp6vdDdq?=
 =?us-ascii?Q?qPwe8WGVjm4YC75l7CnIiyO05r7XWzpWsWhThkzp2xuPCr64ycOX5wj+NO16?=
 =?us-ascii?Q?ymbNis2C0kMeYD+gTImCsg8tWQDBmZ3tAJWGXvPrgKALQNMR9DEAFu4DeWYG?=
 =?us-ascii?Q?GmgfPaoDk6mZtO1jFPCAZKha/p7k82w4EaeGAsTzdfddyttYgRPdVx+gJY4W?=
 =?us-ascii?Q?CBe7vCZtdnZdILOUWJczOZFXTVb4uQNZ4s0NE3XjrP9GdPxepoe12uGpmvuP?=
 =?us-ascii?Q?Joo4gj+S/lqRhkesGCA/rRSD/RlUBGkYt1FIqLnYw5eV1xL9ps91SzvT/dpE?=
 =?us-ascii?Q?ny+LdktCWfna/Td99iq2y95Z8pgPGTfSoxLePm1lscbC/wFEXTc+8wLjSvp6?=
 =?us-ascii?Q?mqd3MReJEzpwq/81vfj5yc9Qtc47QcKFjgDCbFpRvukP4XLM3xyfo4tlGq1i?=
 =?us-ascii?Q?IqgZH8ud6KmNshPcHqk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:52.3435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a1cc30-1ded-4503-cf5b-08de4e0edfcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

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


