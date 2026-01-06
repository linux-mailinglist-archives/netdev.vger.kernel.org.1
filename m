Return-Path: <netdev+bounces-247397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6849ECF975A
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D2BD302DD66
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A74322B68;
	Tue,  6 Jan 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ceVufF1D"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A4225A3B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718316; cv=fail; b=GrXCzI90hCsawqKUBJ85305nTy+dMbpOLe8EubWZ35vnChBq40BcgTfA92D/XObc+1KfRsXr0fWfsj7Yr6DIjyJcJp0H+kRAXZx2Edk4CX558bu7RgvXsW0huJX3OtMWPXjCGwWf80U+iKlPGKiHCgy4t7q3wVLrNJTha2PIHNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718316; c=relaxed/simple;
	bh=fxKgeyK0rqsO4yG0KOJw83dcVB8iV1DBqfaHqdXEs6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJtLrddZ7D3LXl7E/5DSiQJrYJ1xoZhzfizN3tbJZ3WyNtgwTM/9TB/S5ASzWZZ4tNUA3+05dCBT02zabiD7vV/vcDbkeq6waJ4Hjdg/KMVcrBZsmFE4HvJthcIM0PTZG/LcN8AYULR4tCC5K0XJyNf8aCLG6oFi17/YoMwxIVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ceVufF1D; arc=fail smtp.client-ip=40.93.201.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vT2fm0uDldTlHe3p0UPUEOkVHdQQGsA+gxHGjF3Yit1nW4097co5lVbzozE7yXaWhBuZYMwy99A2B3XyRx2SLAToaugAWTCA7PYLB6hmjZdLSgJZo/v6exq6ViGWVErI5VU8cBwXwDHn1mOuj7KxKM/L2jPGSurBftIm3mw697tKZdANHwn8I9dHj+G016IqJSfAQ7xGPp64/3TLk9jY3IP9k6p6eNfO6g00GUHDIZrY+22TBGv/C5MkljUS8byrCDKwMaaIziSy4yW9ik6rAis4+5YhEfQ0SCmXVvvVMbJLYOwf3egT7QMGoiDAYExJC85HNgjpURtCY91+xGwTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH/rLVlyZaeyhMhRHQPN8qvichV3G3eycROJgqbuIwI=;
 b=EamvYrhP40WbilIksDHS7VLS+/d/QPqkqCoFQxp6ZJIsInMG4Kaj85gjbiM6MslxiYIHRFv1b03+8gaMxAQOCLuyUKf3oyqZCNMmf4qykL/fmUh4/LI2pHXYlMS4XPuTstIDBwiqT9GcUhKVVHkuv06aP88wXYAwgnXnrLlUIlARg4VjUTnyYVPFeaUF4OgjjusA2v6NcreFGtum3gXV3MWhdrP7pDXAsj+TsHchs7F0FZUtSUYXdytw5IOx2JepNDAtqCj2BbpE6V5Omb6aGhAMsFcL/ipqo4zDqBVLieLeuvjOx8d12zkQWoXuE3AnFv7nF6Na4YxGn3gLju+Ofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH/rLVlyZaeyhMhRHQPN8qvichV3G3eycROJgqbuIwI=;
 b=ceVufF1DB5ELnPy1wH3cx8jKPNgUHKlieyzStE1RgtQb+xJsmvvFNsZeU4SkAiXaDNifpm/Sk587TGwCWVAnRzzHeSdx2zxLjdUggNiM8bBTFdRIyKQv1paG73ohGCsLdfKE+0OuPbv+S7XMPGFZaTPoo+Y7VNgA6iVRuHyhBDAXIRk+Q3+MGC2oBB4Qj1heN42PJx6xSa5Ralps+qurvyDWBBbhBwsJkrzsFhR5OUdNrOl9rkcsMXRVNVyj6XPhvegJZS9KBf27bmlHVwD4lxi9/mliqR2rO7oPux9rR8tcokE5rFlaHmiIBBimNBd4fcccaYuZjLKt1rPg00GJXA==
Received: from SJ0PR03CA0125.namprd03.prod.outlook.com (2603:10b6:a03:33c::10)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:51:49 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::45) by SJ0PR03CA0125.outlook.office365.com
 (2603:10b6:a03:33c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:51:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:29 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:28 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:27 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 03/12] virtio: Expose generic device capability operations
Date: Tue, 6 Jan 2026 10:50:21 -0600
Message-ID: <20260106165030.45726-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: b479953a-bcda-4f3a-2766-08de4d43e275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mNd1ZHMMg7Ona+gRZNGKeCOPXv6t5HasqypwQLQmZoklczAC5fZ6ZVZTLPnV?=
 =?us-ascii?Q?xL1xoppJrSENKeXzBNz2sEdXTKkOBdiqS6WJqcQrudCXwiCQ0fBHQINiDZY/?=
 =?us-ascii?Q?i9bT5zKMMH8PGQxmycjM5Bm/Xn6qtIjN4xPPDSrrYoCOi7Q87AZUf5WjmVhJ?=
 =?us-ascii?Q?3FrD/y9FtGMPc/dEL7cX0C0iwoCKPlWzmBSe7Se47tzNEWlajB2Ze3eBEYGD?=
 =?us-ascii?Q?BSbewBuBtWqga/8D1+FIwTmpQZpx9ZKQRtRhWdwqRRuUU3K8cSyPpJTZiuN2?=
 =?us-ascii?Q?oy8r+ACk97lzi0Sc2jb8l7MQjsZ9eZ9lCZJCyAQO+3m8yq4ZDssb4L58CPIn?=
 =?us-ascii?Q?xxFG8z0ohJRNEaf1zQQVKGN8VGJAnOtd2kG//AgL7H3fCsR4jxJ7tYGagz4C?=
 =?us-ascii?Q?fZiAwDNTi5N6YQZEIaRTtAct0w1HmQC0YATiAFegv+tKCfgVWqhbjSq+azo9?=
 =?us-ascii?Q?FV6Jph5JRA1Rmk4GvRCRXZ3jIWfyAn1Ue4ZckQA8KEGh1jfzQ0G5Gh7ayYka?=
 =?us-ascii?Q?pvSHKkJIJDOVSMrwIHxPmKy4nhN9HGJmXVqcy017dtuT0rMLMolBerghdAFe?=
 =?us-ascii?Q?o7I+2Zie0PxAJaH6twJjvvyYTdke6lZRCVlzLTkKpPwHmbPxJnqciav2CbDJ?=
 =?us-ascii?Q?sZBedLOMHucIYeMWUTW4qujZHjJAUrh15VtEOoY7I1ls2ne/MVgOf6xOdQE7?=
 =?us-ascii?Q?xEsZfgS81+2w4itNh5WwwqD35z9IkYSTSm7zg06Rm53yHM5brwRoGBzAl9FQ?=
 =?us-ascii?Q?fdZ/IyLG17yjGJf3Hekw0L3icDUipkJASX0v6rDVKcrTzAKDSSfyoocgNc/7?=
 =?us-ascii?Q?7G/nCP7t/qoMXYYr1Ni46RQFYpaNCO5pWFKTLVTQhQyE396eK5/swsCJZ32b?=
 =?us-ascii?Q?j5FzVnK7NITUBkm/6xpX0tTaTTBbFRHpgcYji7itHCOFnHKF5n1IA0gLNQuf?=
 =?us-ascii?Q?5+aNhOUGrZOY1dnM93ozZ5vwVQApVw7BeTZXHBz24FQm3KWzKBRjuWOMHlYo?=
 =?us-ascii?Q?vF80SLfSUhGD4Iqdh5ZfPHMjststOF2FWeDRnmRB7rJoPOSf7snYtuRzROa4?=
 =?us-ascii?Q?tXznr2gMhQBkFb4b4SrfWZTj46/TnikSozlaaHOpz1e8JiA6uJz2hUB8XvXb?=
 =?us-ascii?Q?yL0s8fp6CFhTuDo7GmNFeZwl39pLSy+qAyUdUck+bA0h/5ZoLeyIl5IryMEJ?=
 =?us-ascii?Q?7DyA0TOjIiwUzWXOBK0nXfkeSkpse08FFkqj52M3hPuEr1f0bOMiDLtXIgVv?=
 =?us-ascii?Q?CRPpBcla2gTH2iXe2SYSHIZDa1SzHdfJBZaI8MVG+ftUv0x5h1VPS7Pe6AYc?=
 =?us-ascii?Q?LOIAMy0SByubLles9rRfHIh0uHQKQs7tqOi+lR/FZgHOJeEZIuhuV772PQBh?=
 =?us-ascii?Q?/3+Ol5m3attofv4kT4gzYGfhfgL5msiNZXi9IsksmU09TaYBePhr+EuK7b7L?=
 =?us-ascii?Q?Y9y5H0YymvMkzvAsa//F9UmBkxKx3cB1QbIgJC9FRJoL7l6XD96qK5QY/9h3?=
 =?us-ascii?Q?J5W438wKWBD/ryrGWomyTwKW9dOaAfODBggZ3mBjmgjkeXPwNdvVrJSTTm9/?=
 =?us-ascii?Q?tRcEYNbORT04QnX8VF0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:48.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b479953a-bcda-4f3a-2766-08de4d43e275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

This changes the size of virtio_admin_cmd_query_cap_id_result. It's safe
to do because this data is written by DMA, so a newer controller can't
overrun the size on an older kernel.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.

v12:
  - Removed uapi virtio_pci include in virtio_admin.h. MST
  - Added virtio_pci uapi include to virtio_admin_commands.c
  - Put () around cap in macro. MST
  - Removed nonsense comment above VIRTIO_ADMIN_MAX_CAP. MST
  - +1 VIRTIO_ADMIN_MAX_CAP when calculating array size. MST
  - Updated commit message

v13:
  - Include linux/slab.h MST
  - Check for overflow when adding inputs. MST
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 94 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
 4 files changed, 179 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_admin_commands.c
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index eefcfe90d6b8..2b4a204dde33 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o virtio_admin_commands.o
 obj-$(CONFIG_VIRTIO_ANCHOR) += virtio_anchor.o
 obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_PCI_LIB_LEGACY) += virtio_pci_legacy_dev.o
diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
new file mode 100644
index 000000000000..cd000ecfc189
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/slab.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
+#include <uapi/linux/virtio_pci.h>
+
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	sg_init_one(&result_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.result_sg = &result_sg;
+
+	return vdev->config->admin_cmd_exec(vdev, &cmd);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_id_list_query);
+
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_get_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist result_sg;
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
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
+	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
+	cmd.data_sg = &data_sg;
+	cmd.result_sg = &result_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_get);
+
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	if (check_add_overflow(sizeof(*data), cap_size, &data_size))
+		return -EOVERFLOW;
+
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
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..4ab84d53c924
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Header file for virtio admin operations
+ */
+
+#ifndef _LINUX_VIRTIO_ADMIN_H
+#define _LINUX_VIRTIO_ADMIN_H
+
+struct virtio_device;
+struct virtio_admin_cmd_query_cap_id_result;
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
+	(!!(1 & (le64_to_cpu(cap_list->supported_caps[(cap) / 64]) >> (cap) % 64)))
+
+/**
+ * virtio_admin_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: The virtio device to query
+ * @data: Pointer to result structure (must be heap allocated)
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_admin_cap_get() and virtio_admin_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int virtio_admin_cap_id_list_query(struct virtio_device *vdev,
+				   struct virtio_admin_cmd_query_cap_id_result *data);
+
+/**
+ * virtio_admin_cap_get - Get capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to retrieve
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_admin_cap_get(struct virtio_device *vdev,
+			 u16 id,
+			 void *caps,
+			 size_t cap_size);
+
+/**
+ * virtio_admin_cap_set - Set capability data for a specific capability ID
+ * @vdev: The virtio device
+ * @id: Capability ID to set
+ * @caps: Pointer to capability data structure (must be heap allocated)
+ * @cap_size: Size of the capability data structure
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_admin_cap_set(struct virtio_device *vdev,
+			 u16 id,
+			 const void *caps,
+			 size_t cap_size);
+
+#endif /* _LINUX_VIRTIO_ADMIN_H */
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index c691ac210ce2..2e35fd8d4a95 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -315,15 +315,17 @@ struct virtio_admin_cmd_notify_info_result {
 
 #define VIRTIO_DEV_PARTS_CAP 0x0000
 
+#define VIRTIO_ADMIN_MAX_CAP 0x0fff
+
 struct virtio_dev_parts_cap {
 	__u8 get_parts_resource_objects_limit;
 	__u8 set_parts_resource_objects_limit;
 };
 
-#define MAX_CAP_ID __KERNEL_DIV_ROUND_UP(VIRTIO_DEV_PARTS_CAP + 1, 64)
+#define VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE __KERNEL_DIV_ROUND_UP(VIRTIO_ADMIN_MAX_CAP + 1, 64)
 
 struct virtio_admin_cmd_query_cap_id_result {
-	__le64 supported_caps[MAX_CAP_ID];
+	__le64 supported_caps[VIRTIO_ADMIN_CAP_ID_ARRAY_SIZE];
 };
 
 struct virtio_admin_cmd_cap_get_data {
-- 
2.50.1


