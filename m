Return-Path: <netdev+bounces-217415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11AB389C4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC51E5E2583
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE009301005;
	Wed, 27 Aug 2025 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oSzix/Xm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1422FE054
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756319975; cv=fail; b=InFHrrYjPw3SyLOt8T60FKKK6tV+eYJtbbGnG91tQ7miRrFwBtSIOiZ75yUbQUFrPbUiMfnDckO97bFj8Q+YjK5tz4vEQgERC73O5ypPBf55DE0LDqR1yr6V9YAdwRRd+uM8QXWhbAijk41vZJaKOMVUdwOEDhG/WEIWeYPdW0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756319975; c=relaxed/simple;
	bh=S3XcKTL5WKI1OWjbzwJanid8sNIyESVeK3i0cdzsvio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX7p1ZxyypOqMwkxgUzs00w7ViQ8I7vTd6Rwb+rfa7AlTYHdhyaX1Orn8c/Gnw+aESR4VPqDkZfTcT++3ZDrRYjFC5uYjK1D/Qgn3x8ieT+ipWymQW3XqQHLeePUOrjXgxi5XccMwDg0KTxUIqd/Hi8COMqEyZtEaLWBsNkYDFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oSzix/Xm; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J44zpPoJO9fAgR+WHFzlNVCS+wEIxLjEDLyfxiZClRbGVo3DLcWerpflJTkc0rsDXiGpy/ab+mBl3ocifnwwEZlDgBLOk0TrrAggOl+FBoBwE/5CDJW38UeR50CDZXxDCamND5syVZnKHjt2WWvNmtNsCzB1gwveUv9Xqhcw4lBqU73yf7Rcz+FtmsNMpQkueoFfgKMn++sqzKe6ziM9jr0rcO9Ta7jsqSFEyfUvOtkFz0qmE8epoxbjPhcNtVEMnHTN7urqB2Q+a3bUEMkVRqTEsZrDSeYL0Z0uTWf13tXU341XUX06ljWHVlQuzQrVU5m5tgjaqS5xFmBytVewLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54LRcd6CqZ7KgDz6zbUhJn7Ue2yJSz/z7cC/fzl2ido=;
 b=OjaAM26yzklmS3geGeftyIlaE93wO5hJeRYyC45zbqfHuzGISwPWol3gpNVxLbVDXDW5HJyMicVPFHMmWsaddqQbTMbCoXzEabGrOx105hlFhHMgHCgMPjzviEIucLehzOPnTFgSOXnJfQrbnm8xp49Wu9gUMBMph7pJcXAIpwtSunJoLdYjQ7iYpkVxj+ht5gwH55PGRqifuPeVeeuuj9v8yQMhVDVGA+cpL+DICEgdJiuKX8JCzIu3PPfns2e1XxywONwURSeQSefIOjOrdtXJGmcElKTvSBA8tkPMk9aaUMeR2dMaKXOOYHxbvoH6gwU9sZwOdTkUIaNLlZXytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54LRcd6CqZ7KgDz6zbUhJn7Ue2yJSz/z7cC/fzl2ido=;
 b=oSzix/Xm6daa+lxdLcDzPTFxWWkzVF64UdV49aLQDAKsEa+k+Z5uddssCsTrDloecjjAUFw/RQew+ws+MabDdGoygbzbbr/1UJLMD9nW04DTCJHM+haeYEOnnSzY6Z4vMPamMyU0Byoxhq+IIi6BjHXmzTGVAYebXvWvpD/pBtBTNnnCqnBQf/KSrwjdj3X3NstnptDppZmZN9Vews4Bl8MrhLQf6t8YGIfvNWmlB+TbVQ23es0zLXsAD+XnrV5f7QGBU0i6WwjubmJmpuewOfBk3vZTBUk1nSdYYqUKM/7AP8WGgXL5QnR5KpeqWdD21TgzzRx3F++IC3OtWnzGCg==
Received: from BN0PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:141::14)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 18:39:23 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::59) by BN0PR07CA0022.outlook.office365.com
 (2603:10b6:408:141::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Wed,
 27 Aug 2025 18:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 18:39:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 11:39:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 27 Aug 2025 11:39:03 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 11:39:02 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH net-next 02/11] virtio-pci: Expose object create and destroy API
Date: Wed, 27 Aug 2025 13:38:43 -0500
Message-ID: <20250827183852.2471-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827183852.2471-1-danielj@nvidia.com>
References: <20250827183852.2471-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9c9372-6b0f-4273-9130-08dde5990ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDAwDsgqLCFnQDtA9FFAq5WUx9SsM46blqOcxoJilQAnwGdd0FLwxiryORmM?=
 =?us-ascii?Q?ZrCIpDAJRdAHP6AIax862J5Hfwh09GiHVOUj1TvBMtk3evfMcLFuM9lfFxvP?=
 =?us-ascii?Q?HNussYbydfQGKOEE+7sm+vrqJ5ibRrN+Hsg/2S7j6DkDJUsfLqo+7E7TqOKc?=
 =?us-ascii?Q?s6yWIB5pcqiItqc+fNMeKWIq7aqCvxQoQkvornnZQ5Cse6XGF4I4LCJqrT/J?=
 =?us-ascii?Q?HmXA6F9cviLZZlbqPkjLm5kYEjkItkxlcHJc6kS7fdVoVbkZnxG5MmgwWglQ?=
 =?us-ascii?Q?gDG2igoKLevFfrCxdM9tXT2ZXyF2T/y/wCFb5uAJV3ytcDwN5luLZ85/ntiN?=
 =?us-ascii?Q?eHC69KveWe+8BzmUJ0DZEQY2NVYFRM5MHU46SvvcbkdFZDK/F6J6mbbDGT6N?=
 =?us-ascii?Q?zOxKp7ml2hn414MmqsPRlJLQzZ/J3MHJN4+TGRNg2WKWRmQEX75tQGVhInfH?=
 =?us-ascii?Q?EZKjUgzt+HV7t9o1anrQsHN/EaulFroF6HTTE+VnOyJxG0rKqtixcIAC+iKF?=
 =?us-ascii?Q?EEW/d8WsnoQJ5v22L8UWWq4n61NeJ+BVLYmd1yBmBD7l9hWDbguqiWs/4U+M?=
 =?us-ascii?Q?GMHiv3k1828SWssjjEDudhoeBb3LlrtYP999nKjlWARCC4Dx38w9QvY32F3R?=
 =?us-ascii?Q?tk+jsfQDefpQivblsW1qIelkxgq+VGS/IGDsDSdlV5UXlCPrlgIqXzbtXT+h?=
 =?us-ascii?Q?F4IJlQIU+rgDqDBZc6Y8qZGrWVZzoWR8qeK5bOTMrQbIs6zqXA/GQnsdxzH9?=
 =?us-ascii?Q?UhB3bRtYfLs1OlZRh2Nj7PF+YNixWKKu1ZXApW+7ouoYb7lLYU6bH1wpyz8z?=
 =?us-ascii?Q?P4z3ZsvXJA4+vBOmN6tgjVZLrMP4VpFMWPFZP23Q6nPmpyvwuuX9/LMBj24N?=
 =?us-ascii?Q?0jei2jMpP1GxEx6rpQ+/LmyPiIJMIwqM9dltpuBqL1pEzZ2TcnqeoEn3+797?=
 =?us-ascii?Q?2aNqBVPsMMg3+bYPHBPB43HDkmO6u6fq606dVIVL6E2L31q4kHceuSOH1dYr?=
 =?us-ascii?Q?P28JjZacMruRn4NXnJOUbTAJQmtN4g6R3V4f85BrzWKIZXNVAq5NOayI/I8w?=
 =?us-ascii?Q?LCoeoG9i3a2QD0u2JouDo2wLeqdelfMUPWNzOOQfx1CXJXgjAU+fJr4YdYj5?=
 =?us-ascii?Q?g9icrTkisGiLf3AhSscfnIZbKyJjwkvh8QHpQ5My9U/jcp872kMqQcg/x1zx?=
 =?us-ascii?Q?YGWwybyu/mZUkdgbMrv+FWs4Y2kfQlmcMNCy0cpH32G5/J56CbZbxsX1QZTC?=
 =?us-ascii?Q?9Bs/aEm3yzGpOq5gx6gWq4NCmQDHI63aSZ2waNVE7FuZ2ERlCrnwcuVOGRm7?=
 =?us-ascii?Q?juqjubz+0MGQRXR4M4lndlzNWljR9p8slgzMBWSi2RC9NEPVyiokVK0UUQeY?=
 =?us-ascii?Q?+ONXJj2KNFIrclkyA6mLdaG18o7QPBnGyjHgMLUjiXLnfTmmVTg/FhtEHWa4?=
 =?us-ascii?Q?BD4HOdFri+azl2tRmYOFAIKmfwwO6D9b5XyckYe8Tejh/Yiz6jRKv0wio721?=
 =?us-ascii?Q?EQbbGxlvROV2rZAzOjHN9BmyWHYCkTZFzkJ5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:39:22.8431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9c9372-6b0f-4273-9130-08dde5990ac9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/vfio/pci/virtio/migrate.c  |   8 +-
 drivers/virtio/virtio.c            |  59 ++++++++++
 drivers/virtio/virtio_pci_modern.c | 175 +++++++++++++++++------------
 include/linux/virtio.h             |   8 ++
 include/linux/virtio_admin.h       |  32 ++++++
 include/linux/virtio_pci_admin.h   |   7 +-
 6 files changed, 212 insertions(+), 77 deletions(-)

diff --git a/drivers/vfio/pci/virtio/migrate.c b/drivers/vfio/pci/virtio/migrate.c
index ba92bb4e9af9..a2aa0e32f593 100644
--- a/drivers/vfio/pci/virtio/migrate.c
+++ b/drivers/vfio/pci/virtio/migrate.c
@@ -152,15 +152,15 @@ static int
 virtiovf_pci_alloc_obj_id(struct virtiovf_pci_core_device *virtvdev, u8 type,
 			  u32 *obj_id)
 {
-	return virtio_pci_admin_obj_create(virtvdev->core_device.pdev,
-					   VIRTIO_RESOURCE_OBJ_DEV_PARTS, type, obj_id);
+	return virtio_pci_admin_dev_parts_obj_create(virtvdev->core_device.pdev,
+						     type, obj_id);
 }
 
 static void
 virtiovf_pci_free_obj_id(struct virtiovf_pci_core_device *virtvdev, u32 obj_id)
 {
-	virtio_pci_admin_obj_destroy(virtvdev->core_device.pdev,
-			VIRTIO_RESOURCE_OBJ_DEV_PARTS, obj_id);
+	virtio_pci_admin_dev_parts_obj_destroy(virtvdev->core_device.pdev,
+					       obj_id);
 }
 
 static struct virtiovf_data_buffer *
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6bc268c11100..62233ab4501b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -788,6 +788,65 @@ int virtio_device_cap_set(struct virtio_device *vdev,
 }
 EXPORT_SYMBOL_GPL(virtio_device_cap_set);
 
+/**
+ * virtio_device_object_create - Create an object on a virtio device
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
+int virtio_device_object_create(struct virtio_device *vdev,
+				u16 obj_type,
+				u32 obj_id,
+				const void *obj_specific_data,
+				size_t obj_specific_data_size)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->object_create)
+		return -EOPNOTSUPP;
+
+	/* All users of this interface use the self group with member id 0 */
+	return admin->object_create(vdev, obj_type, obj_id,
+				    VIRTIO_ADMIN_GROUP_TYPE_SELF, 0,
+				    obj_specific_data, obj_specific_data_size);
+}
+EXPORT_SYMBOL_GPL(virtio_device_object_create);
+
+/**
+ * virtio_device_object_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ *
+ * Destroys a existing object on the virtio device with the specified type
+ * and ID.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object destruction, or a negative error code on other failures.
+ */
+int virtio_device_object_destroy(struct virtio_device *vdev,
+				 u16 obj_type,
+				 u32 obj_id)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->object_destroy)
+		return -EOPNOTSUPP;
+
+	/* All users of this interface use the self group with member id 0 */
+	return admin->object_destroy(vdev, obj_type, obj_id,
+				     VIRTIO_ADMIN_GROUP_TYPE_SELF, 0);
+}
+EXPORT_SYMBOL_GPL(virtio_device_object_destroy);
+
 static int virtio_init(void)
 {
 	BUILD_BUG_ON(offsetof(struct virtio_device, features) !=
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index c8bbd807371d..ef787a6334c8 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -967,28 +967,61 @@ int virtio_pci_admin_mode_set(struct pci_dev *pdev, u8 flags)
 }
 EXPORT_SYMBOL_GPL(virtio_pci_admin_mode_set);
 
-/*
- * virtio_pci_admin_obj_create - Creates an object for a given type and operation,
- * following the max objects that can be created for that request.
- * @pdev: VF pci_dev
- * @obj_type: Object type
- * @operation_type: Operation type
- * @obj_id: Output unique object id
+static int vp_modern_admin_cmd_obj_create(struct virtio_device *virtio_dev,
+					  u16 obj_type,
+					  u32 obj_id,
+					  u16 group_type,
+					  u64 group_member_id,
+					  const void *obj_specific_data,
+					  size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	void *data __free(kfree) = NULL;
+	struct scatterlist data_sg;
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
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
+
+/**
+ * virtio_pci_admin_dev_parts_obj_create - Create a device parts object
+ * @pdev: VF PCI device
+ * @operation_type: operation type (GET or SET)
+ * @obj_id: pointer to store the output unique object ID
  *
- * Note: caller must serialize access for the given device.
- * Returns 0 on success, or negative on failure.
+ * This function creates a device parts object for the specified VF PCI device.
+ * The object is associated with the SRIOV group and can be used for GET or SET
+ * operations. The caller must serialize access for the given device.
+ *
+ * Return: 0 on success, -ENODEV if the virtio device is not found,
+ * -EINVAL if the operation type is invalid, -EOPNOTSUPP if device parts
+ * objects are not supported, or a negative error code on other failures.
  */
-int virtio_pci_admin_obj_create(struct pci_dev *pdev, u16 obj_type, u8 operation_type,
-				u32 *obj_id)
+int virtio_pci_admin_dev_parts_obj_create(struct pci_dev *pdev,
+					  u8 operation_type,
+					  u32 *obj_id)
 {
 	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
-	u16 data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
-	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
 	struct virtio_resource_obj_dev_parts obj_dev_parts = {};
 	struct virtio_pci_admin_vq *avq;
-	struct virtio_admin_cmd cmd = {};
-	struct scatterlist data_sg;
-	void *data;
 	int id = -1;
 	int vf_id;
 	int ret;
@@ -1000,9 +1033,6 @@ int virtio_pci_admin_obj_create(struct pci_dev *pdev, u16 obj_type, u8 operation
 	if (vf_id < 0)
 		return vf_id;
 
-	if (obj_type != VIRTIO_RESOURCE_OBJ_DEV_PARTS)
-		return -EOPNOTSUPP;
-
 	if (operation_type != VIRTIO_RESOURCE_OBJ_DEV_PARTS_TYPE_GET &&
 	    operation_type != VIRTIO_RESOURCE_OBJ_DEV_PARTS_TYPE_SET)
 		return -EINVAL;
@@ -1016,52 +1046,66 @@ int virtio_pci_admin_obj_create(struct pci_dev *pdev, u16 obj_type, u8 operation
 	if (id < 0)
 		return id;
 
-	*obj_id = id;
-	data_size += sizeof(obj_dev_parts);
-	data = kzalloc(data_size, GFP_KERNEL);
-	if (!data) {
-		ret = -ENOMEM;
-		goto end;
-	}
-
-	obj_create_data = data;
-	obj_create_data->hdr.type = cpu_to_le16(obj_type);
-	obj_create_data->hdr.id = cpu_to_le32(*obj_id);
 	obj_dev_parts.type = operation_type;
-	memcpy(obj_create_data->resource_obj_specific_data, &obj_dev_parts,
-	       sizeof(obj_dev_parts));
-	sg_init_one(&data_sg, data, data_size);
-	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
-	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
-	cmd.group_member_id = cpu_to_le64(vf_id + 1);
-	cmd.data_sg = &data_sg;
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+	ret = vp_modern_admin_cmd_obj_create(virtio_dev,
+					     VIRTIO_RESOURCE_OBJ_DEV_PARTS,
+					     id,
+					     VIRTIO_ADMIN_GROUP_TYPE_SRIOV,
+					     vf_id + 1,
+					     &obj_dev_parts,
+					     sizeof(obj_dev_parts));
 
-	kfree(data);
-end:
 	if (ret)
 		ida_free(&avq->dev_parts_ida, id);
+	else
+		*obj_id = id;
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(virtio_pci_admin_obj_create);
+EXPORT_SYMBOL_GPL(virtio_pci_admin_dev_parts_obj_create);
 
-/*
- * virtio_pci_admin_obj_destroy - Destroys an object of a given type and id
- * @pdev: VF pci_dev
- * @obj_type: Object type
- * @id: Object id
+static int vp_modern_admin_cmd_obj_destroy(struct virtio_device *virtio_dev,
+					   u16 obj_type,
+					   u32 obj_id,
+					   u16 group_type,
+					   u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data __free(kfree) = NULL;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
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
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
+
+/**
+ * virtio_pci_admin_dev_parts_obj_destroy - Destroy a device parts object
+ * @pdev: VF PCI device
+ * @obj_id: ID of the object to destroy
  *
- * Note: caller must serialize access for the given device.
- * Returns 0 on success, or negative on failure.
+ * This function destroys a device parts object with the specified ID for the
+ * given VF PCI device. The object must have been previously created using
+ * virtio_pci_admin_dev_parts_obj_create(). The caller must serialize access
+ * for the given device.
+ *
+ * Return: 0 on success, -ENODEV if the virtio device is not found,
+ * or a negative error code on other failures.
  */
-int virtio_pci_admin_obj_destroy(struct pci_dev *pdev, u16 obj_type, u32 id)
+int virtio_pci_admin_dev_parts_obj_destroy(struct pci_dev *pdev, u32 obj_id)
 {
 	struct virtio_device *virtio_dev = virtio_pci_vf_get_pf_dev(pdev);
-	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
 	struct virtio_pci_device *vp_dev;
-	struct virtio_admin_cmd cmd = {};
-	struct scatterlist data_sg;
 	int vf_id;
 	int ret;
 
@@ -1072,30 +1116,19 @@ int virtio_pci_admin_obj_destroy(struct pci_dev *pdev, u16 obj_type, u32 id)
 	if (vf_id < 0)
 		return vf_id;
 
-	if (obj_type != VIRTIO_RESOURCE_OBJ_DEV_PARTS)
-		return -EINVAL;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->type = cpu_to_le16(obj_type);
-	data->id = cpu_to_le32(id);
-	sg_init_one(&data_sg, data, sizeof(*data));
-	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
-	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SRIOV);
-	cmd.group_member_id = cpu_to_le64(vf_id + 1);
-	cmd.data_sg = &data_sg;
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+	ret = vp_modern_admin_cmd_obj_destroy(virtio_dev,
+					      VIRTIO_RESOURCE_OBJ_DEV_PARTS,
+					      obj_id,
+					      VIRTIO_ADMIN_GROUP_TYPE_SRIOV,
+					      vf_id + 1);
 	if (!ret) {
 		vp_dev = to_vp_device(virtio_dev);
-		ida_free(&vp_dev->admin_vq.dev_parts_ida, id);
+		ida_free(&vp_dev->admin_vq.dev_parts_ida, obj_id);
 	}
 
-	kfree(data);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(virtio_pci_admin_obj_destroy);
+EXPORT_SYMBOL_GPL(virtio_pci_admin_dev_parts_obj_destroy);
 
 /*
  * virtio_pci_admin_dev_parts_metadata_get - Gets the metadata of the device parts
@@ -1289,6 +1322,8 @@ static const struct virtio_admin_ops virtio_pci_admin_ops = {
 	.cap_id_list_query = vp_modern_admin_cap_id_list_query,
 	.cap_get = vp_modern_admin_cmd_cap_get,
 	.cap_set = vp_modern_admin_cmd_cap_set,
+	.object_create = vp_modern_admin_cmd_obj_create,
+	.object_destroy = vp_modern_admin_cmd_obj_destroy,
 };
 /* the PCI probing function */
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a6e121b6f1f1..651884e3c8c4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -208,6 +208,14 @@ int virtio_device_cap_set(struct virtio_device *vdev,
 			  u16 id,
 			  const void *caps,
 			  size_t cap_size);
+int virtio_device_object_create(struct virtio_device *virtio_dev,
+				u16 obj_type,
+				u32 obj_id,
+				const void *obj_specific_data,
+				size_t obj_specific_data_size);
+int virtio_device_object_destroy(struct virtio_device *virtio_dev,
+				 u16 obj_type,
+				 u32 obj_id);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index bbf543d20be4..cc6b82461c9f 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -63,6 +63,38 @@ struct virtio_admin_ops {
 		       u16 id,
 		       const void *caps,
 		       size_t cap_size);
+	/**
+	 * @object_create: Create a new object of specified type
+	 * @virtio_dev: The virtio device
+	 * @obj_type: Type of object to create
+	 * @obj_id: ID to assign to the created object
+	 * @group_type: Type of group the object belongs to
+	 * @group_member_id: Member ID within the group
+	 * @obj_specific_data: Object-specific data (must be heap allocated)
+	 * @obj_specific_data_size: Size of the object-specific data
+	 * Returns: 0 on success, negative error code on failure
+	 */
+	int (*object_create)(struct virtio_device *virtio_dev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id,
+			     const void *obj_specific_data,
+			     size_t obj_specific_data_size);
+	/**
+	 * @object_destroy: Destroy an existing object
+	 * @virtio_dev: The virtio device
+	 * @obj_type: Type of object to destroy
+	 * @obj_id: ID of the object to destroy
+	 * @group_type: Type of group the object belongs to
+	 * @group_member_id: Member ID within the group
+	 * Returns: 0 on success, negative error code on failure
+	 */
+	int (*object_destroy)(struct virtio_device *virtio_dev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
 };
 
 #endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/linux/virtio_pci_admin.h b/include/linux/virtio_pci_admin.h
index dffc92c17ad2..da9b8495bce4 100644
--- a/include/linux/virtio_pci_admin.h
+++ b/include/linux/virtio_pci_admin.h
@@ -22,9 +22,10 @@ int virtio_pci_admin_legacy_io_notify_info(struct pci_dev *pdev,
 
 bool virtio_pci_admin_has_dev_parts(struct pci_dev *pdev);
 int virtio_pci_admin_mode_set(struct pci_dev *pdev, u8 mode);
-int virtio_pci_admin_obj_create(struct pci_dev *pdev, u16 obj_type, u8 operation_type,
-				u32 *obj_id);
-int virtio_pci_admin_obj_destroy(struct pci_dev *pdev, u16 obj_type, u32 id);
+int virtio_pci_admin_dev_parts_obj_create(struct pci_dev *pdev,
+					  u8 operation_type,
+					  u32 *obj_id);
+int virtio_pci_admin_dev_parts_obj_destroy(struct pci_dev *pdev, u32 obj_id);
 int virtio_pci_admin_dev_parts_metadata_get(struct pci_dev *pdev, u16 obj_type,
 					    u32 id, u8 metadata_type, u32 *out);
 int virtio_pci_admin_dev_parts_get(struct pci_dev *pdev, u16 obj_type, u32 id,
-- 
2.50.1


