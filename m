Return-Path: <netdev+bounces-238110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43AC54390
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 591464ED5D0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F27734888E;
	Wed, 12 Nov 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvo0RBFe"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67534C808
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976119; cv=fail; b=a8GoGFzkOhqxrTueg+cCqCOW3nFlEZ9wlRAcF25Tx/RPRkqUOMX6TKEktirnBkXgatMhhvD5dYesOs47zpWPsPlZgG7y/pc1Df/5znerKEbhD2OX1SfBAcmwKiz/sbp516qvjJ5L/ivN52sdswGc9fn8tYCc3HjehdDEjC/Qew8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976119; c=relaxed/simple;
	bh=4Hq1oSO4brfYnt2pXy7oaoMFG9SPLuJDpOznNGWjRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBu+bqJ482K9JDr3xMOgFUB/WaZGNiiiQHJ2+RQKr0/1OCHZOxyXO1ICVEJR+ls8Pf0QzWWzfoklXl/5pxLqpLxgQsMbB+TIXfDsdmrsuC/bVbakXxYR8UAxMgN9kbWSuO8snqFadMeAbZ++hjxG87x/KfXNjtomeglf+jLZepw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvo0RBFe; arc=fail smtp.client-ip=52.101.53.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5DqrQQbrLn49JZpCEsdaDN/YobP/Xdy0sCE4T+rvWsFIcBEAtu9Uz5dB/qLHDfugFYtte51ihDVku+VCrGbcmmR8pYNmgeh8J2Z2ghS40T8uBgb2Lj1avzJ4zpVTDAy2k1w6CfisMFsFVhZvijOhx9Krj52BTnBbcMwyzapgw29S/uG5ddhD/rWRfSd55HofmuSgAdMS1medruO8KGTH8Nn68mYIrUgq6RygqKLAeQ6pmFNyq21uzRqcAkp6VTrnf0FPS6HgshNFm9c+s2ptU3sluuk1wM881PKZp0c3R0g4oNvPiy9Sq45wlxUN+NAYd3tPVoKIc0TaF0d9YesPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=q65gyHzT36O7LyNvHCyabKJZVJS/bOyYkwdEXS553sGd6VxLJuji9Yf6MFYhhMXe3I4wgdCQAkoxg/Ynq5TiU8/QqwO/hVh17x236u4R7T1AgEpeUaKKo1WVkfFgm8+C7xKBKOyclhM5MGTK9+T2LKMxPnmFHFr5epZPFRIg4NV58UU79rui5q5T/bqnX6h9KsusWAjkcktX/cOmLUMFFvS5nbbnLd0lB+gB54gnYPGHMG3k6Zxzt23b87Mz2ArEmLzI+3SJ0jMPfR6ph1sqpnTJe+Z7DKJrGJaZMYfQsB9FqWAISv443ITorhEueR7f2Y2eg0g0mfQqQGcB6+v+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=tvo0RBFek9Q+F2aqr93vKxSPqacWb0tePFt27DsxlOdt55Yv6EPsfDMgfYld38luk33jhvFIaS67vyaa6dl1nNlZeA0r75k1K09oTDaDArNq8loobBtxDsB9eNLjGmVXmCEhv05V7y4HqrE9tGLt4FKE5+lseds2ppQuuUTjohjM2IxM3QpvFSnAvbwve4z5FO1DwTHpnpzeq1vcqtOyX8ivxQxU8FVb3AwZBDMWdwo90t5YMTX3M9Fge6TrF85Yyo444B8mUTA00jKQTQfOuyH2IQ1fZqIopSC6DLf+bjR2pqDfDYpNCMR2MmkMYgUlsxvkPC99erUxsC7QR1rYFg==
Received: from BLAPR03CA0072.namprd03.prod.outlook.com (2603:10b6:208:329::17)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 19:35:10 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::b2) by BLAPR03CA0072.outlook.office365.com
 (2603:10b6:208:329::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 19:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:34:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:34:55 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:34:54 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 04/12] virtio: Expose object create and destroy API
Date: Wed, 12 Nov 2025 13:34:27 -0600
Message-ID: <20251112193435.2096-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4418ff-d111-4fad-c642-08de222297ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ovOft9e94H2tLCyuPKlL2OrSJrgSu/WPfHxKQQ7EzI/ZoCQBHqueh6mGRkOr?=
 =?us-ascii?Q?5WRhHj2p3Wwk29YWzPluPpLLTVULRAdUaoBPgcdXyq6AKrNMkLbqWGDbOrQh?=
 =?us-ascii?Q?AIuQ1XFtDAQQevkgx0tgRSwPquF6P8jyJZCy2bHa95QzUCqOPCOPXTfLnL/o?=
 =?us-ascii?Q?XIIWf0x7/eOGZcjIIKxAD6EDNMSvPJ9jLU3hZqE0s1k5ck8hxTt+Slym+KVx?=
 =?us-ascii?Q?fOedvPMWfRiBJ6h1E3hcOT4VWmRyYSG2dSZjuN0U+eEJMX1L3crZ3VTmdVE0?=
 =?us-ascii?Q?t0m6n3oJnojBeKLIb5fFiJJoLV3l915CUOvqQ21eohuTLjlAzVHxXBd7SK3m?=
 =?us-ascii?Q?K4yLD8FxAnfeU1xWEBXoV9FTg9foBjZWgWbDSnbMY9Xdx+tohlj0wbWdAyZy?=
 =?us-ascii?Q?ekpgWdHnoxnat8ndu8u5dvu6vgJRNqTBsMzo6nHQiY6WJxf/N+Dyn2Ib4jf2?=
 =?us-ascii?Q?PzlD9URaMgirIEbwT4K3/cKCwDmxZX/ikh44GHxA6k2tzUq59s+X9nEA0zWN?=
 =?us-ascii?Q?UqNpgTm+q8sAc5TPaKRWXSCQsbEezAWI9pOSI1INEp3nrYHtZ0E+4j7qnzfm?=
 =?us-ascii?Q?eOOe7p9K92ocNd/QiZief+mWCsrlmn0mlVQ4KPPiHqJPhU2Afsl0pWvxu2np?=
 =?us-ascii?Q?PLt8HKszi2nPPslZz/x9M+FoKTSriX5sJLkqPs9ayv8gimiIK7Z0JTGWDWwM?=
 =?us-ascii?Q?gTwPyOuYdkChAwqmJXfC5/LldgiTOlvKOATRS38/cfpglrV6+rFZzl/mK6No?=
 =?us-ascii?Q?6H30zEqto01emQxzssri8qrmjRubw+Fgu9EH9JgEE9STJeoDcYRSDCawBzYp?=
 =?us-ascii?Q?tQwDR5hRN4gOp8Vn6xz4JLJTsu6fZeAdITaC9zTZyOV60rg6BqItp4TsaWWM?=
 =?us-ascii?Q?c1i5EQkLXMUn4HKXORzPkPU3rq2zd2fSkR5yE0uB8LcmvAORSDCXH4DHExyQ?=
 =?us-ascii?Q?gTX5BxSy3aIn4PZvJdfPUNQuFlaoM2DiC7bsROcKKmPwQwytZhhCiVTcWmkP?=
 =?us-ascii?Q?bLCLQuCbF5bZncAgNSh/VOPrPac+LIu2HET7vcwu7bnO6Xve+2NllM8IkQ0l?=
 =?us-ascii?Q?tsz4RLjorSBH0Eoqn31SoW4osavg78L1OTl7sYaG36wjdd49Gm7mbDJR5Il5?=
 =?us-ascii?Q?uKL8QLBvtgfpMOjZfOw3jTm3e5sV/3+Cs7z/Wb4WWBFO7pU06FfMGzvDVp3d?=
 =?us-ascii?Q?Vf3tKPbDQerWWGXyO+nX1e5tFGNvLsaMJddFkkjKHB3bkG/YFuzwR70zEnwd?=
 =?us-ascii?Q?YsHM8eE9rvxY/WjEgkVSTUmEkmAjcOBnBPLskN0dGR23ft+4kvimru2zFotP?=
 =?us-ascii?Q?Gc3oWgvRAvWab93q4Bbcog17trC45glHmgIRCum9iK+/go5uCDRZ4uPy5i8j?=
 =?us-ascii?Q?an8KhY1iFfXd+pkRuz0T+h5G9hkDLcjZvB05UjnNMOL5yaKPar3rit7uQ3QX?=
 =?us-ascii?Q?CFXXIMleh6M2ykLfYw+eKLlmTsvGkb1bJQc/Mv3cGpnKQvp4g/TIJAogkD5h?=
 =?us-ascii?Q?fvqGPeSoVW3BRmfBGuKXUeTNoAsHgL+Vx7fxAB7ukkJS3s45AxlK0lrp5tIa?=
 =?us-ascii?Q?QZ3aJd5YHCUcCdE/cCg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:10.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4418ff-d111-4fad-c642-08de222297ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617

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


