Return-Path: <netdev+bounces-235252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A205DC2E553
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CA3BADEF
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774E2FDC4B;
	Mon,  3 Nov 2025 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VjlieIGd"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F42FD683
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210567; cv=fail; b=MT4C6lrehZGCOw69/ab8TydeZuk8pxX9OAxLWYCyvX4T70LvsXiDrPkYVBdSIkgM71HmZi+NKWmOjmnR0vZJke2S6YROZHw+Il/K9pMt0u1PCO9Q5w+6j0t0z59E49H+S+KeLlTp/xAr64X3FJYJ5lNwEufPnC58dK51rn+ZEts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210567; c=relaxed/simple;
	bh=4Hq1oSO4brfYnt2pXy7oaoMFG9SPLuJDpOznNGWjRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cb5FfGa8Du0gK+sXXu8j7c74hoBUAU7E5UMe3PAfysvhWFewmBUrOf/k/uyHwSEu317aAGIapefzUiWk1SO3feERQaT0+o+gUOmVh1NEZ+FVagnn4KgXCkw2HmwIez2mYKo1fZLnT7HynM+s94e8bNLUo0qkzMrmQVPZEaRzr7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VjlieIGd; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTx211hwt+jPBmK0cn878sMuttL4//GvFwjogREgQJuLOlL8z0JWqetwGFoJlziYXxiGLkoLnlSffG+UG+JyQyYYsiS0i/o/9vDvVInTgNR//4RgKz2ue50WN4/E7Mgf+Jz1qVNcePt/gZcG4pFOVwPmJe73BLuPn0fVF9/LIF5G6kYiMrI1tzWLspGA3z/2zt2rHjdzMtgxJhECTnflsXfZGqQoPqFjjNqteh0U5BTEEXlzbIIoald4euRsE5R/n8QJ3UKsZNTS5tjassoIXFD32FhtK4EqOpYJEF1YScv+aJZoOqvMqcnGrVfnb2hGG7Y8SWsaHr3IMy/IRx1qTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=qvYnxg2bOf4DCwZdVBANkcrntFlzpTV9wzgSivDUAnHjZFVbXG9dPumvCM5oJ93SoVTM5Se0xo42rVSJCCGtxgSZYomFMPpCcamTh9VZ4j0lsbLxG7RWFfz0MP3RJ6XRd0AIJBM3O9N4Q1QvouV7y3N5zqNaQMlmU/FSmoxjITH8eHr6Uw50+2mRAamTUaPEI59ZZ1z3dd3ZU523shg3qfu623dxe8Ct4YuAhyU+LfZT23fkbnQ/9F+Vb7Nj17utWqQ5K9RbsA4CHmeSosGCxX+FjU02ppk4UBj91VTSovDtakU3qmR9iFFyYNbgX/VtRSQB4rB7+scYgKioe8Q8qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=VjlieIGdAl7kogJPvi852j3yYMVfR05hHOAJSdYcH3rzAa7qHQbwmVZtVMhA3NchD1WNrrSSYc4LguH5zvKZvi0x3czwPDblkGdisTs6iOBQmHYJmcbvcMVQ8DHRIpGduwXvw6MHOC3xhIJYrDIRgCfSYHt9/lZ96irm/sBx3Wrvdx1FJoA7qgsx6IYCX5OVLcpI1p9mNmTXJ3jCtZ+WDK6sAILbGmtFY2FXHcpMYOA7p4LX8GHeLXECFrEh/Zo9VEHChQfCnb8J6jQj7JVbuvZVzdwlBYS096v9821rS4XYS8xDWjdCj6tbze71BDTJImTaHECQh9U3PxmgHF+IUg==
Received: from SA0PR11CA0116.namprd11.prod.outlook.com (2603:10b6:806:d1::31)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:56:00 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::e8) by SA0PR11CA0116.outlook.office365.com
 (2603:10b6:806:d1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:56:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:41 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:40 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:38 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 04/12] virtio: Expose object create and destroy API
Date: Mon, 3 Nov 2025 16:55:06 -0600
Message-ID: <20251103225514.2185-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: d9980482-3155-4dd4-c445-08de1b2c2891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/PvM5wQdMLWIpnfwn3FRSpXPh+TVvjP7XseatpeoBMJ3hZywt1I1v9XILA02?=
 =?us-ascii?Q?3yOto+a+sCHyJAeKJyIT5ojbp5ppbT92/+XIRLZmPA5Er/5nJptvWgP2+5vX?=
 =?us-ascii?Q?n6XyeUTepixJir5bLbwdqLh5zsztrbogmS9RB57L8CkE3olAMVWA7p91ACal?=
 =?us-ascii?Q?XuRkPz47X44RfcIxS5PQ7xFL9ByxtJcS2QIejQSiXGS/9zqLrXSUqPdNf8/N?=
 =?us-ascii?Q?jCXuJr1S3tbkb4+yaacf3hZVka71PaJP1V+xzofytbRzlDb5mwkZTfY3FmcB?=
 =?us-ascii?Q?ieD2BYZTGWMxrpPMnoi5Ym2aLP+8gNidhou9ir+7pdoaExH3xfOKRnffhJ9+?=
 =?us-ascii?Q?TV+gUeCheqXprJC0ySbkHW5NinD3dzxy+a6QOmTHzidJ4Tx2DJz/cwOK+eQa?=
 =?us-ascii?Q?eDk+7k43g2N/moG6ch9zyDmwDtdeVvInvtHGqoQ9zk32fLF4zlVjEyVA3ytn?=
 =?us-ascii?Q?cRSHFwTXnYWH8wJrzrefkZA5dvo8yych9sZE+EgEDQNZfJNWom6zO5gny+/2?=
 =?us-ascii?Q?jUbJyy8CPsKQuq/mwIRqoITwr5xUDgyVYlptEMuIEWHHDqmSuaiiJ0rfdVku?=
 =?us-ascii?Q?YDSbFkXOcjJ03HiHBIDGDmSM4entBZ1SjiVjmzCZyC1vBxCtv5QdWzXFqjXq?=
 =?us-ascii?Q?v7xi1wWHm4O4Yz5E8p+oEMFd/A9jlAFMclNNxWffh/XBr1iVZ1Wr2K8b8m4D?=
 =?us-ascii?Q?hDkpQcf5mSB8uKJECoYp3PJoXDYZKY+Dq+d0SqLahO7GzWzsn5nJOzHtqdB3?=
 =?us-ascii?Q?fhHimsCl7Vm56HcUrTlZkID0Oq9ZTwHYB2G7MJa9t1gGS7Jqdt0z+FYQSg5B?=
 =?us-ascii?Q?PFpvCUf3UZg7BA8c5yDZczubcUWvi+n8rjM6C4jMivZpmbWXCiv9tvU1sJbV?=
 =?us-ascii?Q?fzTtTRA/HM1aUbRHlguKX3zFMfrwcNCagQXsyTqNXsvXtp1wEFPI2WGsR3Le?=
 =?us-ascii?Q?cQXKOwCB2PX4ARSmURG0elpTNC6poRbgxEEbHYYlP4Y5mTSgG3QKo6fNbZvn?=
 =?us-ascii?Q?iqZHJssNSQaE+lJ+HVXf0pop+lRPA5kIBqtbK2c4mYBS5fc62fXvlFt7ML5j?=
 =?us-ascii?Q?G0t7H8LxJClCUElL54pChWv3ymzsy7eRhfnU3WGADbc6ss31qrrsYl1DJtQ2?=
 =?us-ascii?Q?GHDaBf0zyAXyCGAZya56+PRtdSjjo9zOEdiIoSas9ji1aGFwOSgdQkka2r9C?=
 =?us-ascii?Q?nkLYEoy2nmS9OxDdgRWmuznldOH2hAqo7qEoqp9HRckiDZR4aFV9bEGI9lHZ?=
 =?us-ascii?Q?JWR5Ke77wW3bkeKelyycZ06zp9HpTJpELK9lsxaqDNTMruoy+5f7bN8UmmG3?=
 =?us-ascii?Q?cYp/r5mWJ0J2/ROTSRhmwuDdJf/W26iX4Xb1/Gc+l1re3jHi/GvT8zbKaSOP?=
 =?us-ascii?Q?mCE9ymG90O+6QRedSUQJ+mfbVmDEzKGg9TnJJR2dJ9i86CkfUlnfZQo3bYZO?=
 =?us-ascii?Q?OCYDFjPEmuvEoDyIjul9+T8FOurg6qPnAGvYUbQ0NUwnjsLcxOUB1YnyCH+U?=
 =?us-ascii?Q?rTgNxr0LlzfPQIchO9DJGMocZ4uE+o+pGqhdTT3JA3vRunIy0s34uEh1SCPm?=
 =?us-ascii?Q?AVa3Lx2nCUfSR52HCiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:56:00.4900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9980482-3155-4dd4-c445-08de1b2c2891
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520

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


