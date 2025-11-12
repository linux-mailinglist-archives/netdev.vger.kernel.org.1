Return-Path: <netdev+bounces-238109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D24C542FA
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71B7534C619
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FF834DB53;
	Wed, 12 Nov 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNEO493f"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013049.outbound.protection.outlook.com [40.107.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C734C808
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976115; cv=fail; b=N+1UWUMpWUjAXaHU/l3UDJyC2D+zmK8YIY/XQMvhz6YwfOFM62yKlkdZART7wElh5zJJUY5mVOmkh1o136JfCTlKDn4Y8NiVKFqAMkWa2vUhJS1+7GjPG5E44pY4dR8uHldZaNwELNy1HsEsGqAxQc9i92yc9AUGBXbp5Y8Z7Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976115; c=relaxed/simple;
	bh=my5y7671+wa017oQQk0PKNYiFe3i47pGPwm0th9mm6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkX9rOjNYNFBIzpIqmpeJt384nv9Ws9t2dLYldukm8Kvqa78YgCPaXG65koGLKJkf+9JO117X4nzvxSeNKkBTjrbEMPFPlN3vcaiuD4pfyBuXEUgrg8WHhsHTF4W/Hs0e/XN8F+NgY6nO629NAGe8u2QXSFCtic8XrSWgmY5KW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNEO493f; arc=fail smtp.client-ip=40.107.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxJVMh02wANCnKq/rPDJbig0qwIaawxNfKYGYT7B9wIYL6KkLsrT+/z7F8U+vsifB68QbH5WX0cB1y4uNg72MxeKUprWsQT4nZdpsxzj0mseKjxtahKijaVvYlUoDsdS1sdT41wE+EpGBM00wIwD4s0xs+yDut9cEr3WgRjKG6zf4EJNHK9SUStvMBXulouDE3bi9cVp0pB1tyKNkRs9MBK59iRYQ8AL3QKsW334bIaRY0UfjAozA6N/Dp+QN+egih284ZRJ1dxEBqIivjupduVh90SgzucRGhp+k+KQbFKwhCJjJoJiLHH2MfgLVMp7IzhM8hz9xVIELB2+Hj4MLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=ZJE+L20L0YDY71DVqBjOJWdbJGg9swKbJx2ZZaI8rrEVsj48L22aUC2iOucIkgi0pvBNa8+qtZLxYIQBanabTIzsxV963wtLi/3rC2cboNQcWRji+kZ9J5UGDQ2cXIHOeO67RYVFSo5pLI0nKJpThk0J9w+wAgcwI+rt/R8TSTIJogWBI6z4oblT9Ykn4sxyQpOaP76ibvkWpIx/v1wu0jPAgiSwsgTiM8KlzCkPRAc4J+Gcpb7SIkc3p9YsXZtYDBHmvBm67hYzx2mZPBl3PfCOmOHj90vMQrm5xf9jOQrF4ZNEzTPNkGcya91YbdBpWHzA/wcmfigsHcL4up2TbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=KNEO493fkdyZyvhg8XA+Ng4P6t7DqXj3AqR97Ga5Zru9xP0E+FcMief/Mv7k627SpbqIFd7KXsuEYsM/Y+SVp+hglexJ0yq3WNcq8pnD5C8SJMCl6mIacIrvJZS9lQfzLkXi31fm3M5Hg5srNhte6RhSWNCCbWVqZjB7Ra2Fm+GziE4gcrMZfYMA5xkrzx9lfJYmO4Ypg4Wjj9kJtcavlTudN3m7ZiNxck6YgXeR4Tl3tx7aV7cea3s8D2gT9AhQEyUcmgPXU6YxvTSL850SCEYsjkMNBaH+Ymyu+YNKfN5Y1juZRzPwsjusWWyU+MQHOtksLBpgYjKhVA1Oe6VkHQ==
Received: from BN9PR03CA0225.namprd03.prod.outlook.com (2603:10b6:408:f8::20)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 19:35:08 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::f5) by BN9PR03CA0225.outlook.office365.com
 (2603:10b6:408:f8::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 19:35:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:34:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:34:54 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:34:52 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 03/12] virtio: Expose generic device capability operations
Date: Wed, 12 Nov 2025 13:34:26 -0600
Message-ID: <20251112193435.2096-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c1668b-cc24-4b24-8d5b-08de22229697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rLuui4stZ9jm1jwG1NbJ3cDNzB9ipeYpmH1Cn6rOiOMqJn/U5a59oMzn2tOJ?=
 =?us-ascii?Q?kpBhP4SfsvNo//Porv9NCu0waKYkrFcuZnxJrNN1vGl9Xsoc1lzzTdPCO/Xt?=
 =?us-ascii?Q?abvVO0WLbFaeGIcKnERPtnqmm+H+CXrjA3tqmSV4YfxJgxbxgSOqt9QDMzsW?=
 =?us-ascii?Q?w/DRl9s04FMlgjzwvlF90429bRnvPGkRawLc0WKVin2reev+nN3b1pAQVTfQ?=
 =?us-ascii?Q?97vos4WuqaE1g3SYILeBWjxj126vFzVi7ghURhKKtx/xqbgjAa0hZ/Z3CBEr?=
 =?us-ascii?Q?BwRB/Jm1l0Mb2sAyEcqYPBQxDLUDLUOGVWHdJIvNIYoc9OJ5lbEGxKDmOL7B?=
 =?us-ascii?Q?O29r+pYncQDlazaimBXlTPClPe1IKoil9hsYelY4ZKiq2xZBvB6/EdHfXf/e?=
 =?us-ascii?Q?i6r/iAPzFAo82T1w3P33ZpAzkcRcvXI+fZtdbIPOWyB7QU9pGGJhROprqNmg?=
 =?us-ascii?Q?grhXJrn6HT2DNhYgOZ48WjgTqRPreuHOPXuKexa8U5zAHRnAKFYyfbQPko1S?=
 =?us-ascii?Q?donFT5eIvfp134+jKtkze+Wrom1NQ6xlOuLUCC9sGFdg32kG/cC70kdSpMG0?=
 =?us-ascii?Q?TpqjV10hq2qGattkkmhRIPSz6cjKj6IAx36otE1IeIvdRKqkTwtxY/eP3RrC?=
 =?us-ascii?Q?d4NPCryCF6OTewnzWHO5JVBzc+hYSIZJqTQM+BBkABlYNVk9RSV4qyaCxTTu?=
 =?us-ascii?Q?LiKJDNXalnMdbLtNNpvggA0H/fWM4dpwagCNDmXRM4tUn2/5hWvyfD06FaS0?=
 =?us-ascii?Q?2fq4n8CRXBY7Vu6TJojVuK2oEgLxRB0eUI6Udm3OARQPd18E0d8JtVocd6MM?=
 =?us-ascii?Q?z5h6P4SHMLmE47JxBtIA0SotkIhb6GqHArhFtpDTtqxTWPfOU+k/5jmx+s9G?=
 =?us-ascii?Q?2gyfqRzzDCGAbYZvGB6puNyVN8drlku/QdEf+yYg8x0lhP/2yNyOU+D3CWPe?=
 =?us-ascii?Q?X7NloroH0ZSMg2EoRkWUk2WgHzh5+viOuhK5klpTRSDjNVpwqyDdpoHCyLCf?=
 =?us-ascii?Q?qY9fRtSPW5yhcyS8aAZ/dQlalZKJjfO3XyHVbaP1VVhL8y8BVFHLlo1ythqT?=
 =?us-ascii?Q?K4n21C7DubBAOkQ/cHqGbwJ6CqgnD0DMiCn7TRh3Mv/9FiiiPybxgNDDFgIn?=
 =?us-ascii?Q?IBvF7ycIth+396FLGVvmbzx0nyhi9cuuczn1TvKRsWwNpCcIhEAq3TelvbLB?=
 =?us-ascii?Q?Ka6HcYRHXqx5mjK+xntoDph37DfdgCxdQ6sKDtzwMFGOpjl3r1vxkdORJYie?=
 =?us-ascii?Q?2n+D80SLMYpipFXsmQdCpkzBNffFsaaMiPmBY7JoYxbxWggIxQx0xldwYwy/?=
 =?us-ascii?Q?HG4ZDDBzM4yi0Imyi2iDAP9SoakIJWDL+13oWZEQSatqtaXFOMJkrmgJJS+D?=
 =?us-ascii?Q?p7u1xyE9U5y2w45Z+nSiVWcSISmQ1u/4M59HTCheirHZ2UQDGOm2PT5EWveo?=
 =?us-ascii?Q?ymLqAuYVgkWL6RLfqFlizFtJw15M6LaEskXCUMADvvwjbisdQdCOONn4vpZG?=
 =?us-ascii?Q?XM1WnDV8QmP+SCORWhTWKkMBBPm/nKBAtI/eguniaw729Bcgqivw0amERWeV?=
 =?us-ascii?Q?6KFUVFkaqwF3p1PEgE0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:08.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c1668b-cc24-4b24-8d5b-08de22229697
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

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


