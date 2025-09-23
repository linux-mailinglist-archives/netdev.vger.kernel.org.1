Return-Path: <netdev+bounces-225632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755EB962EF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8EF448278
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11B22DFA4;
	Tue, 23 Sep 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p37oWiFm"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D4155A4E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637192; cv=fail; b=pVDKrG2ENACQheF74Bf5ZbQ0o70UNY/8Jcbc7kVnWJl7SWxbfoAZTBpO7dQ45jJKowouIqNbuRnxQk8snBwauj33F4pNJpLRDiOdSFShAvIvLnRtwXU9sAcqIGQ6fhn28GZT2B6IOd02nWoEFeREwktCBJ1u0vbXtnanedRgOTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637192; c=relaxed/simple;
	bh=9+mUt5mjQXH6P05PIaPkk+yBjTheY4EqZmOM7+lA0OY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6gReKsI9D1iSqJTZxVBn4iJl/si9/gKxUB6IYpJjb33o3KJpORCMarR+9k8aaCTQSq9Whqi4+W0iQOSa5irwfvEKc1ynBQDvG/eL1tePqEY9alo8oZrgywSX3DskdN+RIxgFU04ewbOFU8dcG8N8dbobjqNXseW2JYYuOQ7X2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p37oWiFm; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1jwmsuw+8cqQh91OkNV48tj1L+W8LG09LS3QtCqjEVX3AYxaPb3OtTzIOy8Rj5610+sTF9siT7lmprwf/VFNB/J0AXkDwC543zYqjVAC3SmG9LgNUEpkGWodn4UahkF+877JRpPVSd8c1nDsy0teK3x+Ngfl+TmoBJIDhBGFu5D7RlISR/nxhEvI5JHukxjS72jskks3fOc3VjidF5UuDXaR6jqYQwVBhopDjrnEpuNRDM0Ndc6bQih3HbKE/+uY9Wc3l5ERiWekv4DIfktzoX31+NhmCeY1qJmPvlXSKRQARZpgAM1WPkmgk+l5zSzWNefgr8XjX5t6yoT1040cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMuT27j/Prf6KSHxO5cC+fH50sEQByRO+AQPGaUVDK0=;
 b=yInXS8aItUiuhcE8Bi6qEC1kliBFVAF+VSUTP2RhGSX1uqRc2khgWQ/oKVkNxzaMHhQL0ZT8HiJinY87/lnbFsyW47xZK3C0DhFNKJPkSFBDGdzDXm+grV4ikqZgYjrQ6eYumcD44AM+NSCsr+TB79QDfXUlmR9tvSmCEkSG5Lrznl/SFRp2JZwNo81ieAtnpS54YrFXlvdvETG31Ets1AE9JFr+mhWXYFQ50zpp7lJvOF6gzqhv6dEFtqxL9/mNuSqldOtTK8jr1vl0GVydLSKqIkvaSCrpV0EOTZh3asjlgrV9EHcUQ5/UUD1wBJ9PyCPrk2AuGmO+td3VuZ+9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMuT27j/Prf6KSHxO5cC+fH50sEQByRO+AQPGaUVDK0=;
 b=p37oWiFm1kH7N5QKQyQRpkVhPyBWrZ5DOOxpCj5+wWRAgOklAnr6QPX7i3Y5np9HfNxkGwF0/L3kOmW8cMRg/uNHH3gKFBvzM89BS0oDnOFv/eJGBDCkbMkrk2GhKDCCHQPnqWf6eyAZ+AGL1LLKuJbKS6ErMBSaS0zc17BTt71G4Nr/LKL5IuDKp5yntPE+osDVzGeM8FCWrRwfWuXclAxBtrj/mSweu4X/goatYAxkVWW8lrUVIr9Xm9N094Jz6vgVRQTKwav5SDAvBKkxMCF4ly01fVq9qsj7NMVvyRD9I1PBsrkNC6UzuVR2ijtu5pKD7+4Xs5I/IPDD71lO/w==
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 14:19:43 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:85:cafe::7e) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Tue,
 23 Sep 2025 14:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:34 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:34 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:32 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH net-next v3 02/11] virtio-pci: Expose object create and destroy API
Date: Tue, 23 Sep 2025 09:19:11 -0500
Message-ID: <20250923141920.283862-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe75502-4661-4fc3-80b0-08ddfaac3d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dP1GWm3kAOmV/Z+ANivSD7yw35DA/heoQlzP8BKNlH35mrHvkHVcB24UTgEv?=
 =?us-ascii?Q?ldQiMaq6yy0cJ1tL3pP6YhIeN6CnTAQ8W742tTSellu3sTdP5epN2l4Fq3tI?=
 =?us-ascii?Q?VsC55W1uqb03IT9ggtp/nklain0nY9xqiQ5Pl6VFxmYzsioGy6Kki/7EUv4F?=
 =?us-ascii?Q?GgXeI6u2+Xmt7LTnJBGccp7RY9UntYYTffTq/onRPce9stFZjd4CEfooa10e?=
 =?us-ascii?Q?RsXEDMLijjO4B03o60qVcOq9PpjupFFSuRI/D9+w7RdtnyrQlkOg/Vfw3LJH?=
 =?us-ascii?Q?Bh8Fae9/a/qVZa69VfAkALQwTH/G7ij1+mzKmvKVMfeMtBkLcn1RgXggpPp9?=
 =?us-ascii?Q?84v4yCi5OV/RkP7lIyEmYDjKlogCV+PCZcmHDMiu/sKXg66PQbyysPyR/3eJ?=
 =?us-ascii?Q?+myEYQw2PJ9qrHvFfMa6+/wyfDoV7QGkqRKRPDHW7uuTSfIQvLDkEondZ3/7?=
 =?us-ascii?Q?XQLXNAIHFvLAZTD8TT/lcbiPRUR/L713meuQ0c/1e9SsLjYMMCN3+NlFADGB?=
 =?us-ascii?Q?+7p7K18DK0IXAgYo5mwCXu/KGS6iYviO/J5TfyTGz1aYS5vOt21piWKVmrhU?=
 =?us-ascii?Q?HH64xDhIV+6VQqdWtIhkjMnFhvvpEcjH74B/NGQqsQ/RrmFwKV9srImVj7y9?=
 =?us-ascii?Q?oADYv+IhrQdAT9lAPmuqXpkVUz6xYM+Z8opCuwgocA5ufqpQG6h6W83If+vd?=
 =?us-ascii?Q?YPFFWZkdZGcBHGdFN4FWapDiHeb9gL15RSCRvt+5R6lR8W3/ExtWWMOhLZhZ?=
 =?us-ascii?Q?gosEjaZYY04iDiJddwdwOxA74adE0dDGezRJyh1z7QsFtPELTOL/JusV/N7t?=
 =?us-ascii?Q?kzKl14emEkWjA11zJZKdtR7JPP2EOKy4YCT/puSDEiLCS/IHfoAV0t9fRCpA?=
 =?us-ascii?Q?wS9CrvcekF3dASaWd73fAtZKX6W/vu/K3NrNBICO6Ue9UU+U3W5B9C6wRwkX?=
 =?us-ascii?Q?Grsjkaf/Qa5P4S4jUqVG/ZadnP9Zit4fp+Q/LvvnEwLMmmfsrRUtYAMXTMZc?=
 =?us-ascii?Q?AmNfqp9vDud1Jd8e96b0cH/oWCtjRDhyqOz980tLwhglv/59FP2QENDkxWjO?=
 =?us-ascii?Q?9JkPdn4iGQ5ky2LnzE4gmIhH9PEv54xnBUJAyBzoR5ZuO3CH6al+qDX8oHM+?=
 =?us-ascii?Q?3l+5uXYMZG0YmcECbE1cuVPZ78wo8vI1uC6hcROMGTGtVqgfRW4aCxbsBVia?=
 =?us-ascii?Q?cDArT2nEpaZaD/7jYHrfRdUbWoSd+RdFp2D4a3GApjgv4QlpVLJzVJvq8/wb?=
 =?us-ascii?Q?cI/18Gq5tU4PuTDUyXkQdfNyOaNtHyYyHXrfon+MtQuZ1MdwlPicBcCMSesI?=
 =?us-ascii?Q?c8GrE7KeLt4UPGADH/kbIR6RzTSVegB6KxITog5lLfEgY/zp1iT8vbHnK2F0?=
 =?us-ascii?Q?z3U0xkSM4QDi/Jjn4ZDZDDChde8dtCsVsgzLFYE4OD6LnzpDpptuMWsAslZI?=
 =?us-ascii?Q?BHPjbBwbwPVUVneeKB1eaDfNzXX6slQVL0a6Feh84xIHbFEYk8hO1fLRedu9?=
 =?us-ascii?Q?T59DrX7y0DwEb24JEIUWaQ+QAANaKUwTWH5k?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:42.8226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe75502-4661-4fc3-80b0-08ddfaac3d78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444

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
index 7ab4ea75ad44..543ba266d24c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -209,6 +209,14 @@ int virtio_device_cap_set(struct virtio_device *vdev,
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
2.45.0


