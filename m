Return-Path: <netdev+bounces-228825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D09BD5254
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5342561492
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481331985C;
	Mon, 13 Oct 2025 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XhmhJ62V"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6931961E
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369299; cv=fail; b=Q68yC3O/P3BsaGGmLLxoCPFDtjW7tZ+AKsCrvOkED39V3L7gh348Nh5s+GfCqV1UXqaF4ymC0hHInsmz5bFii40wwySDhG7IV+9FoSjrlAn4lv5A6vi/+7yVRgT5YlNiBmQDYbuAf70XlFpNwettpUYDeZNUqvFHhGPBuZEKU3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369299; c=relaxed/simple;
	bh=jjg2Mdw2skgFl1jEBpYPc+Ui7CuK2iOX6j9V0TaaAUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aU9FnR+ucTp46BqvE3fRgEKKgiFwxpCpyMmj/CzEFTfc4Z7JXaJGZ2fwM41dOISIeOPu4YttmauTsmaniSLxH9B6fEt/nInglAhEdh3hIjBMBOQZL96xrhVO/7cvhZdeoHRB8AbhkVlmZ24WlYLrNTPHUwTq6/wDBe8XylJlwyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XhmhJ62V; arc=fail smtp.client-ip=52.101.193.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLdAwpo3ITIA/UErQdo60yk0nVbry+juuD/tME9WDRRuOII9PoSMm7nZAjOg2SwJ9cSNEMPwKh1EkR1cpx05a7YlsKs1DciCe/lo5GjyzNECFXEqgBj2Conuy28PoHNBH+ZU6iwVD3KMKJ5jHZvH7A56yPpVolewUVoT4WVs8VGj9Rs1xtQ1v3U6Uizn29lXgPWED0j+QnEpKcVk+ae6V5h21Jr6CZclJYUYc07oOlx9EmgZDsUDwG8i9siYkYJMv/qdoN+M3MEoe9mCg0wBvgmPh36P96EtihdpA6n9T2Ri01A7wB32plDCJrXXs0KxDBo//DUGIJqGybvierSmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=lIg2ql5no1by8jTvzZKsSfykDuFLGgCuYXq+hqHzYNs395L/yhPgkJivDaoqb5WgsQT2GB+NzgR0/sowzZ1QF5tLNofuq9gmhQTcOHlFdljfMnO7vm0mh9wDz7nIy+fcA6Cxgzr6aAhEHsidvFKQi/lXiSv9yih1IBFnGZFjuVNJd+GYdXklIvA5/DSXy/5ogIMf2xQEEyKJPQqxJFroPR1l3gXYhslih2rVyIl9XfwZVRSEHiaqUukSQ17rF3VmMGJPkyiPYBU5i13f55h3fZdqz/2e+OL8H3u4fEneNAg2zj8vs/xFKE+ELIdsAd+BJlTSalfs9urNFghcMEkMyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=XhmhJ62VYvFnxG/j+o/UsVk2uPUR/yRutj7ebA0NP4moKg826qnLK7xang1KgXkPzxuAL8OSJ+DgD0LFOeCR0Bl3cGopzIucCnzpR7idqpu1W/yC4Ikyi0OtzXwRePJfzOZQ9qZHq7hcBxa3NCb1N9q3cp+ho5jE/11r/nsSJzSxjOSkFNCwagdNgtAQVvZ6lmjEXPX7vq43nQI8NdXxYrV3+P+k5h9taOD+LQIvT3curk82parUn4VHb8jwL+V5FLEvwLCXBn+8xtXa4uT3oM/3+3uTLBVHfktJIwU/6vNJ5zWuKbsyyAhhPIUOoN1LsTWB9ujzIh1zATTJhjsqVQ==
Received: from DS7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::6) by
 PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:28:10 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::32) by DS7P222CA0010.outlook.office365.com
 (2603:10b6:8:2e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:28:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:28:02 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:28:00 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 03/12] virtio: Expose generic device capability operations
Date: Mon, 13 Oct 2025 10:27:33 -0500
Message-ID: <20251013152742.619423-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: fedc6b2c-7807-4218-a113-08de0a6d1ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hZKL5jOvElGjGRnH/I8g9bKPW8O11IIgiHZX3YuqRK4GUCaO43sCfMObwPdj?=
 =?us-ascii?Q?5TKrsFLblNKFa/28uILiqzvWKMVMmW6wQ7t/iepbu+G3sdmZ/ibUEopGKm79?=
 =?us-ascii?Q?MUSWyNRvIDVQaBvwtr+n6za60PM3sQrX1DWTILuOV8/od31Aq3LKB7lgLR3b?=
 =?us-ascii?Q?0ns/ICsQp5ynRB9fLdDu4gtmNT0yAHPB8+93ClvrhQU3CIZUNHpAg0AkW9Ie?=
 =?us-ascii?Q?zXxfRSGuNHIXfPZHKoX3K2apbG6j+T4hpiXekxGSJ+SP6DUPZop3ToYHyMkq?=
 =?us-ascii?Q?iqG7YsZVIX3r+JIsLjFcLox3CsqOcjVt8kotCU/L7z4EOBAveEXC5L3TAyfP?=
 =?us-ascii?Q?aij4j+LfszW69k7oHROXnHhpPqNt5LTaGPY3tF8IBOUMF+J9eiNzOS5sHJvW?=
 =?us-ascii?Q?qgNJe8+sA4xc79wTin0OxjEPnDN9vaGQFAAmTW77tTvlkgH4WbzRKJhs7tec?=
 =?us-ascii?Q?51dWqEc8NHH6pSDuLMWSbPt/mPFVzvXZ4TLGF9GVEfrwLfW3WlYA79ePHoo3?=
 =?us-ascii?Q?vzT6NRy5s6o57zBVwW67VdGOs8xn9Jl9dv3NOtIUxcOTlKb2S9TW0fFFzzm/?=
 =?us-ascii?Q?WIJ7b4vzHiwfUMfPZwJ5QiXFjcxwDSpT4QrCfZGqPeb+QXoFgBVa5er/uyLW?=
 =?us-ascii?Q?z6udIZjhRafuGIAwxefuO3rWL9muNTwOEyt0dNBcBIA4xwLq4rGTFf+4oQU5?=
 =?us-ascii?Q?xohrQYFikhKuf9GyZVcWb9YNysR4+l0fmdl62ArC/mwYlQrdeTLSCdgQ1KPE?=
 =?us-ascii?Q?4APXAu/Ob3/vDqZekYiyfeh7hLKgPVsxrd+mlPYY1bZ4mgqxMcmnSEsDfv5/?=
 =?us-ascii?Q?/6ARQhsWmW+Qdgj414jHZKtN6unzvicgax4dTO1Hayy4gFt0s/W6+WUb1OZZ?=
 =?us-ascii?Q?diANkNeESiiprrAsOXdoBHI+hn3t83ePSKNOCiFDQqAWP4mDBm+I+yH3BA1g?=
 =?us-ascii?Q?P3pxXPUjSJv5dWTbxvZGbIkJJW0J4s14dXVoMe1RsPeMYEk3pnKafSw/kR6h?=
 =?us-ascii?Q?4k2cfaPYyoZ0n4g8VTL1qBSPmk22IR73f/aVLvk90rvU5KKZwhkW2uQrMICz?=
 =?us-ascii?Q?v995vPZcjoPyJM3+yeP3vjo+XZ/mhE21xkjbVUuwB+3cHCXKdLw9BSN6gzn8?=
 =?us-ascii?Q?2747C7uMjVpcr8nTynL8YOudlm+7i8GV4yaAvjOvb5oAwc03bj0VNyRElDL2?=
 =?us-ascii?Q?RcWMcb89qCgI6OtEzoIZ/qUDZDWQ7FF4nLzcNwF38bDFY1oNNH8WHSQp/2Al?=
 =?us-ascii?Q?E80f6KKsQP/xjWkXKd4LGrTSgRYK/4emM3oXSWVU4qONmwjAe8csrFn9S+D3?=
 =?us-ascii?Q?2p+4g6p7KIAT7vNQAFmPqnf6qSihB83bAY4uI78qNqxOijnGfbienKFjNM9+?=
 =?us-ascii?Q?b7cWz6T/BCkfhkCtzd32ZEgQ7rUb7qWwrNlZh9GiOH855DkyOOY+8gpBLe/8?=
 =?us-ascii?Q?bBLu1PdPoaXp50B42NXsrmCTpY81YiNgw8spm4Rss/jlGM71fSBse36STHQg?=
 =?us-ascii?Q?2ZFv6AJfqOuDV+l9kzGrz1BfkIoInWhSW/Gsk82TBDD6ED8+NQDjwzgk2MCL?=
 =?us-ascii?Q?p/xhKyPJNb9V9QVpjLY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:10.0407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fedc6b2c-7807-4218-a113-08de0a6d1ddc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 90 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 +++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  7 +-
 4 files changed, 176 insertions(+), 3 deletions(-)
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
index 000000000000..94751d16b3c4
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_admin.h>
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
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..36df97b6487a
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,80 @@
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


