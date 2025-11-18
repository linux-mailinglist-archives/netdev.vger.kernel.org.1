Return-Path: <netdev+bounces-239594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E3C6A141
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B90E44F79FA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2BD359F8B;
	Tue, 18 Nov 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t/0P9xHC"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599DB35A156
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476771; cv=fail; b=JSAwrqcz7rvlnx583yxY6EnWsGBSoffjggXpazux4mLZV1BRwABmDpTIdK+bWWzRhIA/jyf/jpZNeseVn/JEtnOsJ6f+JnqWBcS89Mm8Yyg4MV8VMnTTjd2X82bkhriShWwH9Em7OxDnszR8i2EKWFiLAJm8+hQfMn9KfIcWG1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476771; c=relaxed/simple;
	bh=my5y7671+wa017oQQk0PKNYiFe3i47pGPwm0th9mm6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCIcH3ArF3a0icPzv60u1Q9kMizChCVk9s1loC7fiH+tnY8cwRq0JAj8fuHpL2xoc9cPA8cSOtZo6+j6Kpy3G/iEL2TpPsEiawBt3H15hcr8zfE/KhNtVualcMdvIFcYTOvTdhSG0fw57P4p913l6/6rUK9wO6qp1UVYfW9PBYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/0P9xHC; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5O1YhsU9p/u32DnYN6cWRTTBBduXFKiuxFup8juFWC82jXzkc6HXrTvmb4iG/xsdIFXQdOeowKYrlKqpLsg9/LC7JpaUhgWAQB4vj8ktDb3HviCLvAMvasJt2wJKDWbRbZODWaLiUt/ai3UouOuxBYiruirTaupJ0E/+F0Vj16no7+ZUlBQwvoOb082Bhqgptzku23nzmylnmyEvZ73wOvN3RG3a3PgwQuf2nzuDWHb4URG2IKkCZhZe6VsXn1T5veLx63Em+LjyeltrdYF/IOCkgbzzOIGnOwm/ukcry39W+aYcSucgEkWXPuHhJ/dLYmPBu7dRPUuwamyOPwdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=pv08N7gLgkRBTGePyjleVTwpPS1yggzA9zYMFmPBRnrggI+WP6DeEPnMqAGTxlE3l3i4RODjJDU+Tjvo+buuzIzmUnJmF8QjaWqr5UO6c/bu8CKBiOe4e6qGEydukPMBNlDlXdrdsklIbEJ169CQfwT7dZlRLUT5JjlLM46psAOMNPvQ5fmZP/NT/5rY0Ezfh1eaLJK8Us4FghSvHlV+HyUxbCwEU9s8X0Xmj+hrFxv5dgi8DRedobnAcQ6rXlPNytxv5gG/FNrXfWmR/Ti2QKFeXAhReDGYLID7VGQm5JP3QpippOP1WK2Ks6eSR5QI/2bU74dAMcgI40kqcONUnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=t/0P9xHCq9HGYr+bfNt7MuBl26KEjcSIMUKzDw9rtfXsi0J/DG40bEE2vaSA2rpeyAtRtl8hW50piCaRfJuDhy3RX7SNr0TiyRAgELSVdO7GD+w+msXPjHCAATB5RB72NWUhHfnhxov6LxpyP7Ja8EOJEgrRGIlqg0e0ZEVdAJnF/2zzOFobe56o/BvhPNLX2rzKdDG1es4xxHzx3Kq9tCvYCFi87kwzs8Ah898OuTXxxb9wg55JTWq1DqUReZYLMP9rFJy3sqeFGuXS5f0y9e5f4q2s64QQLPc+naRnfYF5f4Ct2hf7M2KDJ2dK+uHU0A4j1VjqUp9neMM0HAPQhA==
Received: from PH8P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::24)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:39:25 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::ce) by PH8P221CA0054.outlook.office365.com
 (2603:10b6:510:346::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:11 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:10 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 03/12] virtio: Expose generic device capability operations
Date: Tue, 18 Nov 2025 08:38:53 -0600
Message-ID: <20251118143903.958844-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: 504ad711-d4da-493a-d7c1-08de26b04522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cd6PBv3Lb7chFLKChWWGQhbCxbDXd8omXwYFfT5GIEl2sFTmLLkTausfqINL?=
 =?us-ascii?Q?PqiSa5mcVq95Us/bRlGYkkYCP97OF+w1AZmqEjxd5gjzsEjsBNCz/NuPtyxc?=
 =?us-ascii?Q?oFrYzaJz05yzcvb+391E/j5lsSpx7nCMs8kZq503Nr0xpIs/EMvKR8czJkTs?=
 =?us-ascii?Q?xpJFxUlCGLQgjq26hophuyNGv/zZ8vP4SoCNKH7WCdxd83ST/JMhBelZbze6?=
 =?us-ascii?Q?x2GRGOizUsu8McaixnTv60mCFiG0YNMkjKeOJ1BRxDZ/DpjC9VRUz1m+IvKH?=
 =?us-ascii?Q?lWp0n7Tgz64zw1Llq9PbBRCD40Y2cm/bRITMiWCiREK0WXS3u0pzhQmMf0Z8?=
 =?us-ascii?Q?4y6RRHXZW0m1qg4QFOD33dmRsOvusyuAzjVllCjtCy6FjF5mI+EPpbf6F5iE?=
 =?us-ascii?Q?3ZOoBpGftR7dZkU8qqxHFxGTpuwu4vDGKUqv2etkhcLpQL/pbFMRpVcCGXL2?=
 =?us-ascii?Q?4wgc4h7zAHudPMDUY4MqEJu5gSk1CiVcJWUG3YbiqwQ7XrZa9BTBch+H6+d3?=
 =?us-ascii?Q?kUG2GlRivC5if9LFihGyQdOakrngDTTfYTV13xTJHLR4C57muvDykrhWC1IS?=
 =?us-ascii?Q?oTVVOilAZOJ6sRV6oML8MEiVKiiqT696HJUdzXaFt/dHNmJNuMd1TRuw0Mtk?=
 =?us-ascii?Q?G07aUwOTRKHxbfeXVgw8GcRg8vmb/4g6M7bzwKNnzQm1FPPTnt/9x7g2f4O9?=
 =?us-ascii?Q?E3ATFgc68M5QyQsWvzXMcxS/6DA5X43U2RcDzyvzgimmF3erGszkAS9CkVxf?=
 =?us-ascii?Q?Y32jvxaE5kis1+6C9LItXrVJ02SHX7DWYjDzHJGAyrQ7gEG+eWvCWCvZLSUx?=
 =?us-ascii?Q?p0ouO9QAY+m0yx1OWZV9ltFw8PVkvnsjxwl4JLg+zNf5lMYAIagkt+nDR995?=
 =?us-ascii?Q?+sqsPDCiFxf2ousPxc197dASmaXK1V6ZPqpTz6BS72+URuWaCSj/Zel3VXXR?=
 =?us-ascii?Q?RT6qfwuxmrHStgJLsxbe0NgxTnJMT8vJnmbt/Qk791EsqfWUhuaIDJjJ61Sd?=
 =?us-ascii?Q?tUDKBLvLjm7G5A/npZRK+yPWpfZbsja3Jxzjxq2iTRm2/0sIqd771dXRHdh2?=
 =?us-ascii?Q?CZQbiW39kl1ggXBcUU4XuMGSFODvm11o8LuIDiBC+coPacDsR73e+Ue5ih+Q?=
 =?us-ascii?Q?vx1Z93Dz7MGzNdRdK1vlundst6NVpOX9EF33AQfp0vL3ZnHw0N9WnVYmmff7?=
 =?us-ascii?Q?NtnfM+pbjbq9K7STl5tRTM2E6VOvD3OPHeXme3DL4UoioTzJkks1pXdI9bne?=
 =?us-ascii?Q?8Nb9PjX0nG0irrCx7Gpisk9NOCeOBuEGFutjF2OiRkBx7FV90g+TOkr7Bv7w?=
 =?us-ascii?Q?tYMriF+sQIclGH6xV2e4FpLkKrFmBzR5gaPhUtqpskJD4f1/JIRRBFb/1Eb9?=
 =?us-ascii?Q?totLgxbE6gPE0mR+bfT2/fP9iGl2m90LS3BKjr0CKrT22BswGgDzWBVOV/FF?=
 =?us-ascii?Q?bvZnIJBJjd9R5JFO4dXUSOWgtIzXnxvLEy1gn0xnz9T+KlNt5sEtI+NZ9Ihl?=
 =?us-ascii?Q?t7OuSRl7taIJKMaP0BPjG8znAoT70QBnJbLlUGn5uhH9PvgyvG7yUOkJbDSu?=
 =?us-ascii?Q?nwb2Mr35UmXAUXPwTJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:24.7954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ad711-d4da-493a-d7c1-08de26b04522
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764

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


