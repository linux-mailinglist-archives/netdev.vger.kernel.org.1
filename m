Return-Path: <netdev+bounces-220891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1355BB495D2
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C8B1C21297
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41CC313265;
	Mon,  8 Sep 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLocgXu1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E8311599
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349806; cv=fail; b=hFpPDa+Nom6YI1Wz8c58+lBYVV4ZpXWE5BOt3kRXrnCvpPNcnQP90mlm7/j7eshbwwYryg2KwIMZIm/T/0ar9+Y4kIluqwCIuiLDteSz6xbmbZbX8l52RC+HRD4PZyPDJHx75Ezj6sgoOKIvCXkCodTOW4zmyxTOLwhkSFZDrXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349806; c=relaxed/simple;
	bh=S3XcKTL5WKI1OWjbzwJanid8sNIyESVeK3i0cdzsvio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neXy4ZJj0v0TpoH8s0temqLm14sURHX6S+6IPnV1uR5wsgV3zLuptUJB6KNXWP+fDb+yNzGX55Lvg+FB3VR59M0XSUbt8GOsHsXiEQksbmAM84AkTmQEgZX5vfpK0tS+4KfrBQJSYuu0EpwuBpnRqlPhpdj6dxGtFZZKBbM6VrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLocgXu1; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8hvJb/gBVayccanlDd6Fvi6VUi8UVpKt8gSd9ONVfcbqoK+jH9aK4+IbypyctcVuaa2n4pwaReYX57grDVyrNb31j1e1+a2O7ieIwE5E1kuX4h70F/b+ELgzhIlD8crFIwjuhGQWUUbKN1Vs42CChl+/rMMh5Z0CxZChTx8O9APXJDqjkKP9kopvqZnNbfO4PqRJL0Sm6FyfseZuaBxkWA2YeYCrT4khfb8zmg7IoIz+u7OHOiXxbOMfOkKKv29MBKdyzgdXIedZqGXEk3sJtT3paNydZ7vulX/uENoZsUDdaAsDKqnvYHRGTvhaVrPam0wtr4NZ7XLqIeDyxKrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54LRcd6CqZ7KgDz6zbUhJn7Ue2yJSz/z7cC/fzl2ido=;
 b=QlM35/PdlT9QWmb0cQgr7iAVL0pJ7JNlDVn12kI9lL3ak9pHKB0MpnfOgM1wbiL9uXq8sbLZ8vo00LCJI+ZmXPj7JEgECmpUNDQLdaO9Rx8R8MKJ6CXJTHSrcmdy9huXBcY/H1mrqnu+V7rAXpPAohSa3BGY7mrOhdY5VxBQXt/kNLdUUJ94nv7QGPbtBupwtb3Wfbz+OHaW9kJ51bkWevl1hzS3CeK1Wo+OTvS3enshH+whuGtf8tKjQeAA1v5WiS2v4mRvBGQQwB5uC3NlcSJRNloHtILg2DYsW8oarbT3Orpj2aqXW0H+UVQ9p1JEQRTcUrkHC4OXgJI6g4U5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54LRcd6CqZ7KgDz6zbUhJn7Ue2yJSz/z7cC/fzl2ido=;
 b=DLocgXu1MYQVX07CHmuenv3a8OYzRE7kXU8SsuiPZFw+TbnYfNZOmWobVeH2GtExv1/f/O03hhHjQiDJLjOmWlCVgljjrQABQ4/2YvkKg8RmgwfNQJaS3F36PTrdCZ0mEXuQhiTBIZzWXuvR9MUhX0nIfkupHBnYnCfVNEJ95IY/sdy4pWEGuY2BsNoyHyJ95Ugm31wHgsRC/pGE1XgQ9Y4f8rX4/nedcSPuixRPStRpaEEoj0ZvgGKnnhf1u66AZDZS9Wzshz5YY2gc9LwaVRCDN/8WCXXbWiXAt4SKcgPBXzHGq2x25Z++ll3AKB05dgI6T4TlSMMWW+kdJANTFQ==
Received: from BYAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:a02:a8::29)
 by IA0PPF80FB91A80.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:05 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::4b) by BYAPR03CA0016.outlook.office365.com
 (2603:10b6:a02:a8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:35 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:35 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH net-next v2 02/11] virtio-pci: Expose object create and destroy API
Date: Mon, 8 Sep 2025 11:40:37 -0500
Message-ID: <20250908164046.25051-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA0PPF80FB91A80:EE_
X-MS-Office365-Filtering-Correlation-Id: 998f8f0f-0acf-48ff-2842-08ddeef6c898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?onjdHstoAbBch0zcXX82x1aL+rpCyiWgpLPkRf4QZjA328XbsfTTlj4Ke2Xf?=
 =?us-ascii?Q?8l2q7w/yk8ZhMKEKnx9eU3cjzxf7a+BDqNDw9UNhHzGpnYSs0DP1QLTdoUsZ?=
 =?us-ascii?Q?CveRLme2Oljeac18ri6j8Y45vD9uIwODj51ilG+P2zT+o05Ih5ZUJriRgc3e?=
 =?us-ascii?Q?zDqP58tSD24BwRoWxQsFmYHCWDLYCghgHBAZDzpvY0QGkaf/lc5QaSgIr6yw?=
 =?us-ascii?Q?f35MGve/8rYoW1asg/wITST8Xv08dEDZHykK5MpH9CHpusxdYk6jXvZFF/8e?=
 =?us-ascii?Q?iBR40RsR2YUDYekJ+FkQuOa95Xm29YNGZ1rXhMl0I5K4DcWinuAhjzrCTKuc?=
 =?us-ascii?Q?fHkSOP4S5722q3pSurEBLu8wG6Krdd8a9VqVPU/JXokYMQ0h6ewHJ0wdch6M?=
 =?us-ascii?Q?0jx6zJowfCQ0WHZiAwqGgnv/6WqcIhg9cvJjnACCm2cyWPhd8dEMVU2LfYTR?=
 =?us-ascii?Q?oDmu+gW9YhCnTIR/9mEV7HOtUcupya3UJK1NdZgVxI9PQ1HeHEqGjX/9LkNw?=
 =?us-ascii?Q?KfgSm9nKZHaOUTSYUbrkNcXzvVlUZCmr10Z8Sen3lcH+q0kDgv1GftQUpK0J?=
 =?us-ascii?Q?kiG0pSJsMlpXN7a9tBdy0YBFf5dBynIrD8xQRX2lPc0aFxT0PueUWvVDa5Zp?=
 =?us-ascii?Q?5YDaOdAkz7Ps+51MQmQSwkQH1P4fx67W6rtHrdYoE+SmLRFrWCGXzw0C4K4P?=
 =?us-ascii?Q?+wc6AplrJJodD4XLv0gaOyr1cW4cjdkKT02NWinnym+dkAmoqsJNYYaR/yRv?=
 =?us-ascii?Q?Heo3el756s+U/6huZKTD7Au+MNK++/Ayq7Lq5vceU0IGU+hm92tPTikryejr?=
 =?us-ascii?Q?dzAb6h1i6E6LqeXn5GPHqyfhPUcWYWWNHEzOlYrXNx+fVgXTQtoibvofsLXQ?=
 =?us-ascii?Q?XasiZMw9Qw73SuII8HjbSSPh1iLB4Xh1xHh5mjgsncZ/DQkO+2LeebbAlfpU?=
 =?us-ascii?Q?mmNIQnO7/co16ldspqauCgdQQGBNWgQ0PZ3WnizzLbsutV2U0W3Q1EbWyir+?=
 =?us-ascii?Q?oa3hoj3OSA5Ud6t/RTvAU2sSqZ82t2Oy8eqqHKQOk0tfjLQt16tjywPktk4j?=
 =?us-ascii?Q?XUBeQct7cAmIa5EFoeKDyxEaAQkyIlPUR4WRtlKwFAQkQstbD1Oc9rBPzoFT?=
 =?us-ascii?Q?i1bopyFb7OQa4oTdNoj5XXw6rkFQOD5N7sPfJN48ueKGONV4Aidl97YFupL7?=
 =?us-ascii?Q?fVgbnrrI1t+oHGN5h7OBy8lqAAdTXZX0X0hF5Akxm7ojCFFwzudmnamnADGL?=
 =?us-ascii?Q?6VIZllS0Z3ZH04Hu++DwUHeoZsgho0GC0yyf6ZgG6aPGmeaOHUNZzjoDYZMy?=
 =?us-ascii?Q?Nehr0MihaAK1RST2gunIm+e4G8JaQaTCAfShq9ZZ2f+3e3XdWu9f1cVMrl/M?=
 =?us-ascii?Q?e95JLFYi8HXRlutRYV99Htg4Yr7Cbrk9n37Qf4s0nkZ6srZ/E7/qPaYHW7WK?=
 =?us-ascii?Q?dT+Dw9stG2UzIuZzc434tqqOQ36VDvs4UeXsIJhIQ/yoJOJAzbcCaUjX9NJN?=
 =?us-ascii?Q?MCyrsvz8bb0/bxNe+7NZ6uKeOSApifd8noVC?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:05.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 998f8f0f-0acf-48ff-2842-08ddeef6c898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF80FB91A80

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


