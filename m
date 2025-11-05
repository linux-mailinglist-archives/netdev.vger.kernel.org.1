Return-Path: <netdev+bounces-236076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A24C383AD
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C356D4E525B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D62F3605;
	Wed,  5 Nov 2025 22:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUoAoMlf"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEF2116E9
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382712; cv=fail; b=jyJXwfarkyVntq6/AhiRb2HLA3PGpvq6GpCBCWyPNCnv8xnCgztq3ACunyXKy8MK82QRRF+3C5+dNdDeeksoT24SvyliFLcoYsDvi6LhovmlqBi9AF8++UUQw4I0FfeiekChh3We3We9vk8JiypwxFxacr2iuNi3OsLA/Od0CmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382712; c=relaxed/simple;
	bh=4Hq1oSO4brfYnt2pXy7oaoMFG9SPLuJDpOznNGWjRHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTgsezJ8wAgjFntxrrSB8hOEf1L1n/njhoUPnkIaQZhk3xqMusIUEp8kt20GOlwiENAGYm4tb274JhmEtAHWZltCzsvpkyo8qYur4KQa/qCAQf1weKlCAc4Rj6ms6nQi1nHhYWHQRYwQLk2RFaNnjvwZc9ktYTQPOwRwppdF4oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUoAoMlf; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3PdQUm7fqbhKSvj9NUYSsVKa9j/CpbvHJk8NbH9z8Pun74QQ1E+HPoN0/qk1UnI6AY/AGfjSOoMClwwvHMYWFQelCvVTIA2x7nNJ6FOCXHlRBzbX05FHRJ23TUFvpZ6PqeVavLRxsnY3FAQJ/Mv6CL4jbYcfWsLdSlGFloeMxwSnlpufBzN1wAO2P8wznrvD2sSrqx0ttgsR6ECpvG+Sb/Ld4QIoYYLaWnGes+xv2Cawb6zN15qzoEPGtC/0wEexdzsKl3Khin+rBNP8qvgBR1+orDRZh+7GfH9xOR5r6gs1DoaeIjBa7WJjb+20+DJXpp6cvbAQA7VKkKdXWo6Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=UguojR0cFtT4hTbIci05T2mmnxO55griKUeze4zgI8INXcdzRlP6s3pZwcZ39NLR7HEUuwpSzV85ZOYZ+nRfq3RQim1p7fubIySc8yf+opDzDZ7l3P2XqPzBUMR7jXz2dmqhmlEHmEKDqgi9zd9Udul9BRrENBL2yl1gcD9gOJNxfSGXOiKmfzYIoqztv1+pTHHIiJX6H/wP5i9XOcvhM3M4Ri/3qQDHvM4QVGKVxOF5KmZRkANrCCP/anmDBjLymhBeoJ2HbP81LLveqUDua9H9zsRpmZH2rhj7ZuztL+mIXk10FM9Qd8ZGD1S16zOy9sI7ZMBj1MBZ+5kbP5CpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmdAT+iNHJHITRFfie9YnkpDAXY8UM9Y/wdNu8rGVLU=;
 b=oUoAoMlf9LBjXkQYP/crSbtKVoTjwxg4ChreXNvDVcJew8cxeEb+lwQ2flfMDovrTCivUdhncor/0GpSHIf3HRqBkJniL7phizzMUBEDl/PcozCXAta6dL4VR/r6eyJZ7GQ1LikI2q/qBmtCBkQ4bFiQVw43yiWh6NJZ4iYE4MnNui9087Ejao8rqioAeplHkO2TqbsUwONW3jGW3RBwR8HMop54eMpKwedrTzRVUYdqG+WtN2uJLkNkrlds1LkWq2EqpWZTAUCvd6hbgi7hzTR3Y9Cpc0q+aPW2Rl4bWcib7NZp8FflGjYNfj/Bo1Vncl5P/exutPSskEtGTBAnKw==
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 22:45:03 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::17) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 22:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:43 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:43 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:41 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 04/12] virtio: Expose object create and destroy API
Date: Wed, 5 Nov 2025 16:43:48 -0600
Message-ID: <20251105224356.4234-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a2b7fe-d6e8-4e66-3706-08de1cbcf5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VN+eUdVE9Y1w6s+LeGGxyn5l+PU32MEEJdNoN3maLydZlFqv/uXmrEC7QX4B?=
 =?us-ascii?Q?RtSjpXNgVBVoEi4D3WDfwHXLG4+QeQNXrNnj4BMHF3F4XZIRJ1rFqbQPBvmg?=
 =?us-ascii?Q?CnN4/jvEsx3d268tht/R4JVdPOUlo7NqIRrgE0Isbwxrz0jQEaJMJvsPvk4x?=
 =?us-ascii?Q?KJXlwD7qL/V22OMB17e34mOZBMIKt9VdgbNy6Tny3bAEx1p71yFBXemfg7cE?=
 =?us-ascii?Q?dyYcNdWy1hRB0vTWXfOJKnvuZXm3hQvtWdz9/I4fXCtp/tuBJ1M6ImtLCj4M?=
 =?us-ascii?Q?PzH1gPhUUqGYw5biXpsRcZXaoNo2RsaorUEoTV2bqUUGofDSsXvJsoeFIfcB?=
 =?us-ascii?Q?jsOwCFdKDNtDrU2imLkdVKvBaDmpYmAfi4+80/DvMCzvbj5nUjvQMUtL5aKm?=
 =?us-ascii?Q?A0UY4pXTlboyDkOiWlFUGOR7nAyDl7y/Q4FPKhkKBSP1nAEL3xlCh20++IQm?=
 =?us-ascii?Q?NlWAPKSP3h84pU/EuIqiPKRqB/Iu3oEubKEh5M+mw7SYM0ONoJ8+Hv3Bi4f0?=
 =?us-ascii?Q?Mt3XW2s4FhAQ9kY6HgnWzZ2OVWWAkCwopEkZ20CzUjS/VNVyh+RmnQsteLjB?=
 =?us-ascii?Q?lTwflWTcsDI4F3ExNrZeeiOrPpbI+HCE/7ISrr05nlmBNTBPjLmsb3/00ei0?=
 =?us-ascii?Q?K3OwvZoLbURqFbgUZhi4ajCHRfCGezUmYIqin41J5qBK7SzhAv+aTDVvIJDg?=
 =?us-ascii?Q?r9ot6jWVlrtJlAOAAGceH5ZAjMEUj+uzLZT+KED5RtWi/PvrKGnuWiDeOcl/?=
 =?us-ascii?Q?s+tGHgshgfjWI1SIGjYsAxMB2CUO6CKFwrE+qTrIogbcJfpfYXOAyaU6NKMi?=
 =?us-ascii?Q?NWIRAW1eCjvLmXhziICfSQdHnm/fMTBok30KPnBpdJ7hbL5P01qX5HQKBLFF?=
 =?us-ascii?Q?TOGDL4REA8T/kPAgx2XY+IH8gAKqC/+Wi40sJ24HCRWcTxczBTvOR/zKHf88?=
 =?us-ascii?Q?nZbSnUUk5QwRoO53CE2TJhMJcw3qNEtr5oepjhSvWFMyvQNAFNb6xKHDL8mQ?=
 =?us-ascii?Q?sqV9KEx8fBavCSd2OzzJsoG1NWvhL04N+fi4BEWTIf2K7ZRiFN0380NPGn7b?=
 =?us-ascii?Q?RSXElkM2zJCkTm1fAY9XrX5q4G8D8yos+/Yl6VUxrJeK4k3rRVcYA+vGQI8u?=
 =?us-ascii?Q?vIbCsu58VN4ZSV9J8cpDRyQcV38vVfc1CleRhNJ17PGkMQRnquupD2QvZAC0?=
 =?us-ascii?Q?F2DBwdbs4m93nsLr8fp7T73RwQhYS9341KcSWLHKPFx7exje42RE/zf2TVoN?=
 =?us-ascii?Q?ghMZn2f3V066s5WkYTehALrCM1FDPvs9lGuXdXuJMfd/ugYrL09W6bKVkKpH?=
 =?us-ascii?Q?DQV3TuAryb30ZsL9YTzdGsdDIFuhkQThDIH/fSVcBnr2am+fAoYfCwnU+ZTs?=
 =?us-ascii?Q?yyc9PpcDCVoQhEThiKH9wdrmbzmguKUW+q0G6BXQ9sCWg1NBIDZPZbJUmQVp?=
 =?us-ascii?Q?e8lXp1XgQ8KkG8b1ulDha5lDSkWxRSVDxsLOlDqCoeQ6m2xEELQP0DaywRMZ?=
 =?us-ascii?Q?IF+P31W8O47Uyp5dhAoG4q2GjT+q2ZFFvAFwG+zE9ETh6/Bu2j8F6O2CJ6S6?=
 =?us-ascii?Q?x0l+P2gXU0UvfTkTdIo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:03.1974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a2b7fe-d6e8-4e66-3706-08de1cbcf5a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

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


