Return-Path: <netdev+bounces-228826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F61BD4A65
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA59740367C
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1531987A;
	Mon, 13 Oct 2025 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngb7uhG2"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EB331986F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369302; cv=fail; b=CSsaccSKAFMjjU3u3Z4lK86QPH3Ws34cJHfNbIeVqH+nrCPLOaUDcrBS2Z+TO05iErSR32jEakvm1kG2GQ7bxbaENd843Lf6jxnhCG5acELooneepG4y14q7WPxscGvLwTDX8hUeQoIlMaoNwvtJ/RMxCZLGyrKD5X+L4LCt+w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369302; c=relaxed/simple;
	bh=BsWnEOe6tPuX/c/H8DNYThK++ii3UJy6P/r95qPFziM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE3fKZz4BKwDtXUe0cDCGp7TPuagn2loFCSID/3l6qhZlunGWbSmBaGSW+csloquisZ7PoZmr6/cBo6YV+SfUQ8xAGZHzf+RF+fvPtIc6pzqGr8U4CFmujUUB1wjcN4VYLi4xhSSFXtQoJ/TYXoQErVS1SLjQoaANbba8F6slMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngb7uhG2; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdKZkonAh3ZP7uOEcZmpFtJLEMor05piS2L7ImuxStJIF2TmU0mlWsXR/o680ZbEfuV0HjI7cYShgazAaqOAbIkZ05beCsqOHbmAN1vW4k9g05f4x9k8pZTdnWVqqn8bStmkoOte+YTpnIYgdWwfH92O3wX4Oa6PWIdUAes23FbMCMqLlrXG4LOknD/zPyHA8F8K84IhQhzfYgTZlV9cz0++raJCzKZZjI4EZ4Pe5Zhy706k0IH81vX5AvhuIKPrEHr+TrLBwK/Nx2Moz/U0+bBJxTZsezgkHpKOdH/92FKBP2bwAoJ1JGBdTn9Iha+v6oGS7v0IP/8OcR8VqX2m6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS6UjlO3Td1LKHmhIufFbFFW3v2CYywGiNTWjTUf+bg=;
 b=ZogeJy8a0+2TSHXEshx9I02AS6p2JeCEmZiU5HCez6B6Pdix4cNy5eSN2bazmBzc94tiSXTHmFED8PqvzZVowrSo7TKaEBwlGWIZLBKcjuoF4mmvtdk8xtoMTOAeQj6I/DEjoP10bQcfxYwbXUpngO9wuw/+y1M/CxJHWwAAEkQVtyxYf5aTgKyt0m7GfF4vBEWytb2+1kP7jDy9CCGJmrONLLXiMzjXLtv/DEVz+3mrp17Jo61cuSxjT5+9Cpwnt/wRxeVr3zTU87PsR2rz683UBCyZit2YVEunP24A4Hz53dDctcLrab0IELqfdKW2miPO4l6dSCb+n7uDzfksFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS6UjlO3Td1LKHmhIufFbFFW3v2CYywGiNTWjTUf+bg=;
 b=ngb7uhG2JQ3rP9Xlg0yvYW6GOu1IVImVkxy5V9eQzuaV5BS3TgFlABgHV+rILRBx5o5QW0KX7QVDySAPd0V9nX9NgoE62oxHr4jQmm2+o8Z2OrxMDCZP2EmbCizbOgmhmoIAmDlaVr/CM0jXdBPvy4y+Yj6EgwD8FX7f0Vakr7LnTnC2YVWjwSU+Vf86+hpRaWAxq7zNfDXmSuY72mNve4fUaBfdwEwaH0BaF7pVS1V4PftXcsBgPDpjTGVvMMTrcOb1/AjRyqGq3tBA9/jnOhwclni5q2TEHjviax3aBOeuBmAp1y0WFtNPZ0nD3GVpvTcEcLi2KEv6FH6fpfz30Q==
Received: from MW4PR04CA0278.namprd04.prod.outlook.com (2603:10b6:303:89::13)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 15:28:17 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::f5) by MW4PR04CA0278.outlook.office365.com
 (2603:10b6:303:89::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 15:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:05 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:03 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 04/12] virtio: Expose object create and destroy API
Date: Mon, 13 Oct 2025 10:27:34 -0500
Message-ID: <20251013152742.619423-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: fe58b402-5e49-4b4d-e8fc-08de0a6d21fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uE2C3GW0OuHtuX4SEsJnuxZVybdtA5uUO8PR30hveCP0M2MQ8/W40JPvkDEb?=
 =?us-ascii?Q?KVq4zQex0YfI/kHLCXGYjP+PWYUpd1QzwUFdWHEX6AFTBIacHpeJ9c2sq6tF?=
 =?us-ascii?Q?Bw00OBPUARYpRE4kRTbd4L3VLiNnhekBY05PhHJUf394cw69txp6PcLKRclM?=
 =?us-ascii?Q?IAq+/c7LUtfzSkiySy+fe/zWn2A27m6aj+yPKHnUe9lXc4Iepbl9eYoIsUvz?=
 =?us-ascii?Q?x/XeQEWyY1GXjIEfnccOlCA4MbWKTcpeTerGbktmclGxTckKZwWwQBm0RXLL?=
 =?us-ascii?Q?oL63GRNR2/z/SA2RwvIycCWXqlSimEGSUztrd4ozvvsoC41ZJnrQQRNA8By3?=
 =?us-ascii?Q?acony1FUWAaHkB+AJ1PI/GSmE5KCc1kyateeM0UNI6xagFQLfex8gWvAsjlR?=
 =?us-ascii?Q?DckeJXqCPpCg+J99iCmUMc9EHj/4vrsdaMN2pxPPJ8C2PW4pIzpKwkjf312K?=
 =?us-ascii?Q?oUrVzEr249+LnKv9Cv6siDDk7rmHqhbY49rYIIc8Q1lC4MOkqt5xHe9WhKUO?=
 =?us-ascii?Q?89BPexfTeaikJ7oyeZy1G+dSSS0UxaSvQmEp+JWvWe9c+TNbshnHL/uc4aZt?=
 =?us-ascii?Q?V4grQ0ETmyU8D/zsAyvYPTbv22N8Zse+YU9tsnZkpIPd/Lat/rW0DJKqZNDb?=
 =?us-ascii?Q?e8g9gTp3Yieejf6Mq1Nd/P/h9JYSTcv9QoG9ZWK6M1KDUIHQBFVcTt2yeA5F?=
 =?us-ascii?Q?Qzvt4kRQCrlN+h5jojZaheicvh7pwHrJgOxqyW+awwN7kvS1XQpXL/xPaMRs?=
 =?us-ascii?Q?lgi/qadwYwwLbWfAbq3B5nXCj9dCGmZftFTa1owwXyLo/Vy6NAHtU8QgitgA?=
 =?us-ascii?Q?N3HblkqoC/cDFVtMTQlqW9QTJGeWvTtONegHez3aZy/crkGcSWDUvcE8ubyy?=
 =?us-ascii?Q?q3yYzlDcfFMgALMNkBUcg+rBVuAvzZocE0pNs5By49n4b4a7PFjgurRFbwII?=
 =?us-ascii?Q?YR8Ri3CiRsGbr40NF91xpNilys8ytQgX9CyBSV8h9UIkzOw45Jjyja0iLt9x?=
 =?us-ascii?Q?0hNI+FH3LbIfzbzN4R4mSh1+IW405IlzJpAMmjusobrd4wN0VLAKaL5jp3Cc?=
 =?us-ascii?Q?qWuBijEX5lEuyjvCX566RE1ZlEDdwNdXu8zAdfXRx7hjDBpNuXI5qabxG97P?=
 =?us-ascii?Q?woUi/7PYJqR6iUKPMgwxo9moQX1Wo2QSf0/wDFuKWIhpSq2QRLH63GYNuxfT?=
 =?us-ascii?Q?+yHyyFBDPLuEjw406BZJGxZxIyrR71vdViO2zqR92/KbqDR2OIQcxltM/wtO?=
 =?us-ascii?Q?sZKkES4C8u0CFs1rlCaYCkLi8y0unmWm0ucdZ9Y2T3rAg7fAEuAz2dZUGsPr?=
 =?us-ascii?Q?jbuXRTUB7wXP0mnKPmEZID9rgtbz6R8p0MyxpGm+2PEQrLzOw/pY6CSDldev?=
 =?us-ascii?Q?uiH1ekEh5AVzPfDkphSKfe9QvRSf6LQUOmdNj6fe2ygJ4KJcEmsiLGvEK8V2?=
 =?us-ascii?Q?sTKcLuSK7y7jWSHwyIkGq+vNrhEcITWwVFOulBoyBGN9VqvgITxfRyW6EYQL?=
 =?us-ascii?Q?0c3LvsP2dmHBs48KiRDcWCZn8jQOp8ohgqUUGdsz16ayr2+j1k+uiui4ntVH?=
 =?us-ascii?Q?ca/McZ2E27SrdpvfvF4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:17.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe58b402-5e49-4b4d-e8fc-08de0a6d21fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
---
 drivers/virtio/virtio_admin_commands.c | 76 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 40 ++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index 94751d16b3c4..d3abb73354e8 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -88,3 +88,79 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+	data_size += (obj_specific_data_size);
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
+
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
index 36df97b6487a..99efe9e9dc17 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,44 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
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
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object destruction, or a negative error code on other failures.
+ */
+int virtio_admin_obj_destroy(struct virtio_device *virtio_dev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


