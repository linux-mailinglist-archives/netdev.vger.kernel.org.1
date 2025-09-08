Return-Path: <netdev+bounces-220885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE0FB495D5
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F5D2045E7
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677423126CA;
	Mon,  8 Sep 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r2ZxVPVT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3707F311C31
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349796; cv=fail; b=dpMmC/WKq/TkGwBFq8wbwaZRdoShWh5KhY4AenwA7VAHt6B3s9jpEZ3dlqWpWYE05csqUzUgarg5fjnXEzvvGV4hfmNxdz48M/cEYuKDlFoO+F2mHt1RAx9pqVBpF5ieVexIRlyEDDYBu8bUdo7QKgxiXWChQRXRfbOIC15kTpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349796; c=relaxed/simple;
	bh=dto++ddzlMctcxW9Ts/nnOsEyNuxrFMAyUJ5cMJbJzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcvxFZ7vqoe2urcxs4uFXkiIihZwf4DySxeMLf/n6ehXHmuTyoG8w1evEJ3hN9z1qyVKEdjttVYWogQzaJoHj/GazW/P27vAtw7P8zgj9PZNPoH/zgLgfF+9oY9BTi0I2Fn5+ITgF7Lc3gRMI8OKTMbD3mP0wLAdhW/G5tJNdHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r2ZxVPVT; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuhN0M/sGD/s0banzUOaNHUJfaDiZAEM9jzhwFm8DmXSnAAEkszBivSXNQKcmJZfz0RRnLUNEarUkq+s1aTcVsGS7/ZtBG9PNe6lcW/l7Jx+HSrwFukAN9/cC23s2zU93YYOvIO/vv2NraewqjkAc8NrfT54K0j/iVCAS2D3RWjR36E4tjsoVnvGij00b7VnPXvsMtIvpzR/cij+xG5hz0nnt7mB9wkn93BmZexroGg9Fl+ZHtWhd55BC1tufsrPiKX6s+UeS+zcU+azV8Peo99936bgUTCaaGG/1ZmSIgWYj70+sin1HuU7yN6fW1m7dvMxUq90zL+6cqIKTw5Baw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Cv1CSFlLBP6J9cN7qG9+sQ0b6BsLOr8b1MWkWeVXnY=;
 b=KjgeWpX9kR3Ci50ALFKR4uk78tuBOuTASNJqV73ACZan4Cd1k7p/6nln4DaeT+IH5cZbGJ9yx8sMvr3zxjfXx/MVgeVvLk0hPboS5XrBbXksP7oGbVE34luVqus/yvKxUUWXFBt7kCi03p3BIfOAvKXlhOm/f042TIY53Nrk4Q0cYNzGTq0o+MENoKkazl2jT8eDqMNwyOVwH9snlbIkVyZCbbXxUi0hislyWCm8+/RbOiPNSj0HUaGdpNVYo0YQxIB4wDxveWa5uieC95Q38iYrOOaW+El0KGFz+UCrzpJMZ0pi9s//h8Zbd0i+JrraxDoMULeEJsF2zzYcZ47Qvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Cv1CSFlLBP6J9cN7qG9+sQ0b6BsLOr8b1MWkWeVXnY=;
 b=r2ZxVPVTuKZL5CDn33K1Ue96k6qOZCmRDCoT5uZC6rygkJX0g94Rtnn4nxyIZ+fuPgC2DUeJGNz8nvUXfeSOxJW0WOrcCKK8JdlV+kpjwpTpiHoHp437/jrDqkNOV/1SB6Yz4z7lxQ0k5l904Qb+L+N9l0BH7lhmymaLe4rWJPTrvKTm4KPfSkKxxH6Aj0KXbKPpX5JLOuIhFshLnxdPIjCeeKaWXSxDb4VmmY6YqEqDQMYCqRATrcPuN7OZ0vYHXrwEjMoctOce9jYezj/C8997GyiUUdOzD18w6oT8dlIlroupRVksOiRF092SfDysKBkDzTz8TmsOyRNBskVqPQ==
Received: from BYAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:a02:a8::25)
 by CH1PPF73CDB1C12.namprd12.prod.outlook.com (2603:10b6:61f:fc00::615) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:02 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::61) by BYAPR03CA0012.outlook.office365.com
 (2603:10b6:a02:a8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:34 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:33 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH net-next v2 01/11] virtio-pci: Expose generic device capability operations
Date: Mon, 8 Sep 2025 11:40:36 -0500
Message-ID: <20250908164046.25051-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f5abb0-a038-4a45-bbc7-08ddeef6c6cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jiBrQ1aUG+dSCRLiAKsqLszON7qwSjq8dji19UWIxvuO6pKAXdwO1KNYgn2D?=
 =?us-ascii?Q?s/mljIbscRwl4wv9gP114tn9JV+dtcX56baXSNCMmt1fLeGDIKbGbAEZTrtY?=
 =?us-ascii?Q?Hk1aQ+khFLzbqy233FFDEuHRLAVu1zqX3S2bAwDWAm/HIfrZ8Ldsi42HNOh7?=
 =?us-ascii?Q?5Ye65Om8cm6vgqdsREGDSBLSpSoGn9eYPUOMTu559FxF9czq+0nYQ2outkl7?=
 =?us-ascii?Q?dFED4HrxUiuA3vDxHtwfPaLpKpPVQOY9xph4o7YjMzx1g4aVzrNKnVS9RxPl?=
 =?us-ascii?Q?NbLbyZus0lMbOOj5EIs7TnivZjR2dzOuPHmw2neDLC+q1CCELTA/HGUXfzx2?=
 =?us-ascii?Q?4NUdpep0qZV8jcgL4dsgwFCyOLhtBCFB4oQ8wMZi507yUS8eUmRUD1K+dkh2?=
 =?us-ascii?Q?7rMmS6exZF2tO3a8E/225j4xQVb1dGVhbP02qi58kmqmo+1nQ18VpcTV8Tg8?=
 =?us-ascii?Q?/vFNIVpAL5NDmGEYu0OwXQ2SF5v8n06TtEMYEiRbeElRImtCV7ftI0hPcEJD?=
 =?us-ascii?Q?L954VgfXopyiGXAGwsUcKmvulaFqsRxZPZXRTFgVMdIxJ4CYN35KaS06mxDe?=
 =?us-ascii?Q?Yv0nwcBEubk5jDwnPMooBWUyC+amPflP/HHM42W/SKANkap4walp4lvGSpTV?=
 =?us-ascii?Q?JspNChsQLah2tgDscqqUyI4mNbqOwHilVQIlJPGigt7hh0LBEut0GEqBAa+r?=
 =?us-ascii?Q?WBZv+J1zsMMSYmlH/XFUJSdzKs+8GIwcq6G81ccM42vqDxpJuW5l4QFd9Wlr?=
 =?us-ascii?Q?K7NqSFrT8tDhvbm5OzFpwFLP9DC1ML9ATGJiOseCfmrmNUrkWzJ1/bDn+TXW?=
 =?us-ascii?Q?+RGRTmoX/qkpSXjWGSz5NLs8q08aN0XIO4S2AHJTtLUDg5PFWKI4C4yjb7JI?=
 =?us-ascii?Q?HhHAhTJe17mHEElYG7ffx9PzG1OD7NfgWkcF8hCaBq8DXLZ8MTpioVsuKbKH?=
 =?us-ascii?Q?JPWX7Su/Nd+6ELlosSif7H0bxOqGu1Iu0/yPWazFCrinpe+/pMV5+GO4Pw3b?=
 =?us-ascii?Q?KRRdM5sGQijEQp2dqJ/G79GeArX0YD/XmczloQ9PSg/FuEnMgyYoaJjXCQ21?=
 =?us-ascii?Q?ACjYUO9STdyWp1DctS45pB4LxGJCGUZaI8uunGieuq/kcvl6/HJX/Bxv5alh?=
 =?us-ascii?Q?JvP8CS9zVNVDGYf+Vwot4ApK8t3cMyXZHOvuuBu+mn1v37gdtAFrtd9pAbbV?=
 =?us-ascii?Q?073NDpqO8dWGbnC+rtrm3wU2VoVwEASaTnjqaOhVVfOaaamivaCm09qDEuFu?=
 =?us-ascii?Q?RxGH6kBQiRORRjw1oNhXJ+KV0haMeqCLwbTCzC15OmXARNfIVuyMHDaHusvs?=
 =?us-ascii?Q?BYH3YArIYNiwGBdZJuf8vbVkT//0t7rVn0voOYk4l/l99WhS0v5Wjn66xbss?=
 =?us-ascii?Q?07Pf91sI8+B4VVMpFXGbY48zEl5SIDBL5IHggskFKA+ZZ4hHZPQW7mWxO74C?=
 =?us-ascii?Q?llUAK4+z+xqyw2Go9RrLxMM/ORebHxw6VP1an0Q01SkXF/AijHbuFMqzjuyv?=
 =?us-ascii?Q?cHICWcGUZ05fTx7RUdfSGXwHEb5ufb9ltHt2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:02.0359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f5abb0-a038-4a45-bbc7-08ddeef6c6cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

Move the admin related definitions to a new header file. It needs to be
abstracted away from the PCI specifics to be used by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/virtio/virtio.c            |  82 ++++++++++++++++
 drivers/virtio/virtio_pci_common.h |   1 -
 drivers/virtio/virtio_pci_modern.c | 145 +++++++++++++++++------------
 include/linux/virtio.h             |  13 +++
 include/linux/virtio_admin.h       |  68 ++++++++++++++
 include/uapi/linux/virtio_pci.h    |   7 +-
 6 files changed, 254 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..6bc268c11100 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -706,6 +706,88 @@ int virtio_device_reset_done(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_device_reset_done);
 
+/**
+ * virtio_device_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: the virtio device
+ * @data: pointer to store the capability ID list result
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_device_cap_get() and virtio_device_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int
+virtio_device_cap_id_list_query(struct virtio_device *vdev,
+				struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_id_list_query)
+		return -EOPNOTSUPP;
+
+	return admin->cap_id_list_query(vdev, data);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_id_list_query);
+
+/**
+ * virtio_device_cap_get - Get a capability from a virtio device
+ * @vdev: the virtio device
+ * @id: capability ID to retrieve
+ * @caps: buffer to store the capability data
+ * @cap_size: size of the capability buffer in bytes
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_device_cap_get(struct virtio_device *vdev,
+			  u16 id,
+			  void *caps,
+			  size_t cap_size)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_get)
+		return -EOPNOTSUPP;
+
+	return admin->cap_get(vdev, id, caps, cap_size);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_get);
+
+/**
+ * virtio_device_cap_set - Set a capability on a virtio device
+ * @vdev: the virtio device
+ * @id: capability ID to set
+ * @caps: buffer containing the capability data to set
+ * @cap_size: size of the capability data in bytes
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_device_cap_set(struct virtio_device *vdev,
+			  u16 id,
+			  const void *caps,
+			  size_t cap_size)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_set)
+		return -EOPNOTSUPP;
+
+	return admin->cap_set(vdev, id, caps, cap_size);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_set);
+
 static int virtio_init(void)
 {
 	BUILD_BUG_ON(offsetof(struct virtio_device, features) !=
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..c8bbd807371d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -19,6 +19,7 @@
 #define VIRTIO_PCI_NO_LEGACY
 #define VIRTIO_RING_NO_LEGACY
 #include "virtio_pci_common.h"
+#include <linux/virtio_admin.h>
 
 #define VIRTIO_AVQ_SGS_MAX	4
 
@@ -232,103 +233,123 @@ static void virtio_pci_admin_cmd_list_init(struct virtio_device *virtio_dev)
 	kfree(data);
 }
 
-static void
-virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
+static int vp_modern_admin_cmd_cap_get(struct virtio_device *virtio_dev,
+				       u16 id,
+				       void *caps,
+				       size_t cap_size)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
-	struct virtio_admin_cmd_cap_get_data *get_data;
-	struct virtio_admin_cmd_cap_set_data *set_data;
-	struct virtio_dev_parts_cap *result;
+	struct virtio_admin_cmd_cap_get_data *data __free(kfree) = NULL;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
 	struct scatterlist data_sg;
-	u8 resource_objects_limit;
-	u16 set_data_size;
-	int ret;
 
-	get_data = kzalloc(sizeof(*get_data), GFP_KERNEL);
-	if (!get_data)
-		return;
-
-	result = kzalloc(sizeof(*result), GFP_KERNEL);
-	if (!result)
-		goto end;
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	get_data->id = cpu_to_le16(VIRTIO_DEV_PARTS_CAP);
-	sg_init_one(&data_sg, get_data, sizeof(*get_data));
-	sg_init_one(&result_sg, result, sizeof(*result));
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
 	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.data_sg = &data_sg;
 	cmd.result_sg = &result_sg;
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
-	if (ret)
-		goto err_get;
 
-	set_data_size = sizeof(*set_data) + sizeof(*result);
-	set_data = kzalloc(set_data_size, GFP_KERNEL);
-	if (!set_data)
-		goto err_get;
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
 
-	set_data->id = cpu_to_le16(VIRTIO_DEV_PARTS_CAP);
+static int vp_modern_admin_cmd_cap_set(struct virtio_device *virtio_dev,
+				       u16 id,
+				       const void *caps,
+				       size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data  __free(kfree) = NULL;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+
+	data_size = sizeof(*data) + cap_size;
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->id = cpu_to_le16(id);
+	memcpy(data->cap_specific_data, caps, cap_size);
+	sg_init_one(&data_sg, data, data_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = NULL;
+
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
+
+static void
+virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
+	struct virtio_dev_parts_cap *dev_parts;
+	u8 resource_objects_limit;
+	int ret;
+
+	dev_parts = kzalloc(sizeof(*dev_parts), GFP_KERNEL);
+	if (!dev_parts)
+		return;
+
+	ret = vp_modern_admin_cmd_cap_get(virtio_dev, VIRTIO_DEV_PARTS_CAP,
+					  dev_parts, sizeof(*dev_parts));
+	if (ret)
+		goto err;
 
 	/* Set the limit to the minimum value between the GET and SET values
 	 * supported by the device. Since the obj_id for VIRTIO_DEV_PARTS_CAP
 	 * is a globally unique value per PF, there is no possibility of
 	 * overlap between GET and SET operations.
 	 */
-	resource_objects_limit = min(result->get_parts_resource_objects_limit,
-				     result->set_parts_resource_objects_limit);
-	result->get_parts_resource_objects_limit = resource_objects_limit;
-	result->set_parts_resource_objects_limit = resource_objects_limit;
-	memcpy(set_data->cap_specific_data, result, sizeof(*result));
-	sg_init_one(&data_sg, set_data, set_data_size);
-	cmd.data_sg = &data_sg;
-	cmd.result_sg = NULL;
-	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+	resource_objects_limit = min(dev_parts->get_parts_resource_objects_limit,
+				     dev_parts->set_parts_resource_objects_limit);
+	dev_parts->get_parts_resource_objects_limit = resource_objects_limit;
+	dev_parts->set_parts_resource_objects_limit = resource_objects_limit;
+
+	ret = vp_modern_admin_cmd_cap_set(virtio_dev, VIRTIO_DEV_PARTS_CAP,
+					  dev_parts, sizeof(*dev_parts));
 	if (ret)
-		goto err_set;
+		goto err;
 
 	/* Allocate IDR to manage the dev caps objects */
 	ida_init(&vp_dev->admin_vq.dev_parts_ida);
 	vp_dev->admin_vq.max_dev_parts_objects = resource_objects_limit;
 
-err_set:
-	kfree(set_data);
-err_get:
-	kfree(result);
-end:
-	kfree(get_data);
+err:
+	kfree(dev_parts);
 }
 
-static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
+static int vp_modern_admin_cap_id_list_query(struct virtio_device *virtio_dev,
+					     struct virtio_admin_cmd_query_cap_id_result *data)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
-	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
-	int ret;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return;
 
 	sg_init_one(&result_sg, data, sizeof(*data));
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
 	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.result_sg = &result_sg;
 
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
-	if (ret)
-		goto end;
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
+static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
+{
+	struct virtio_admin_cmd_query_cap_id_result *data;
 
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	if (vp_modern_admin_cap_id_list_query(virtio_dev, data))
+		goto end;
 
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(VIRTIO_CAP_IN_LIST(data, VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
@@ -1264,6 +1285,11 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
 };
 
+static const struct virtio_admin_ops virtio_pci_admin_ops = {
+	.cap_id_list_query = vp_modern_admin_cap_id_list_query,
+	.cap_get = vp_modern_admin_cmd_cap_get,
+	.cap_set = vp_modern_admin_cmd_cap_set,
+};
 /* the PCI probing function */
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 {
@@ -1282,6 +1308,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	else
 		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
 
+	vp_dev->vdev.admin_ops = &virtio_pci_admin_ops;
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index db31fc6f4f1f..a6e121b6f1f1 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/virtio_features.h>
+#include <linux/virtio_admin.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -161,6 +162,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
+	const struct virtio_admin_ops *admin_ops;
 	struct list_head vqs;
 	VIRTIO_DECLARE_FEATURES(features);
 	void *priv;
@@ -195,6 +197,17 @@ int virtio_device_restore(struct virtio_device *dev);
 void virtio_reset_device(struct virtio_device *dev);
 int virtio_device_reset_prepare(struct virtio_device *dev);
 int virtio_device_reset_done(struct virtio_device *dev);
+int
+virtio_device_cap_id_list_query(struct virtio_device *vdev,
+				struct virtio_admin_cmd_query_cap_id_result *data);
+int virtio_device_cap_get(struct virtio_device *vdev,
+			  u16 id,
+			  void *caps,
+			  size_t cap_size);
+int virtio_device_cap_set(struct virtio_device *vdev,
+			  u16 id,
+			  const void *caps,
+			  size_t cap_size);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..bbf543d20be4
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+#include <uapi/linux/virtio_pci.h>
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+struct virtio_device;
+
+/**
+ * VIRTIO_CAP_IN_LIST - Check if a capability is supported in the capability list
+ * @cap_list: Pointer to capability list structure containing supported_caps array
+ * @cap: Capability ID to check
+ *
+ * The cap_list contains a supported_caps array of little-endian 64-bit integers
+ * where each bit represents a capability. Bit 0 of the first element represents
+ * capability ID 0, bit 1 represents capability ID 1, and so on.
+ *
+ * Return: 1 if capability is supported, 0 otherwise
+ */
+#define VIRTIO_CAP_IN_LIST(cap_list, cap) \
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[cap / 64]) >> cap % 64)))
+
+/**
+ * struct virtio_admin_ops - Operations for virtio admin functionality
+ *
+ * This structure contains function pointers for performing administrative
+ * operations on virtio devices. All data and caps pointers must be allocated
+ * on the heap by the caller.
+ */
+struct virtio_admin_ops {
+	/**
+	 * @cap_id_list_query: Query the list of supported capability IDs
+	 * @vdev: The virtio device to query
+	 * @data: Pointer to result structure (must be heap allocated)
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_id_list_query)(struct virtio_device *vdev,
+				 struct virtio_admin_cmd_query_cap_id_result *data);
+	/**
+	 * @cap_get: Get capability data for a specific capability ID
+	 * @vdev: The virtio device
+	 * @id: Capability ID to retrieve
+	 * @caps: Pointer to capability data structure (must be heap allocated)
+	 * @cap_size: Size of the capability data structure
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_get)(struct virtio_device *vdev,
+		       u16 id,
+		       void *caps,
+		       size_t cap_size);
+	/**
+	 * @cap_set: Set capability data for a specific capability ID
+	 * @vdev: The virtio device
+	 * @id: Capability ID to set
+	 * @caps: Pointer to capability data structure (must be heap allocated)
+	 * @cap_size: Size of the capability data structure
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_set)(struct virtio_device *vdev,
+		       u16 id,
+		       const void *caps,
+		       size_t cap_size);
+};
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index c691ac210ce2..0d5ca0cff629 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,18 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+/* Update this value to largest implemented cap number. */
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.50.1


