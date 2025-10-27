Return-Path: <netdev+bounces-233269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE1BC0FB74
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC98461749
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E21318157;
	Mon, 27 Oct 2025 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+d1HfGM"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011001.outbound.protection.outlook.com [40.93.194.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8B31814A
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586843; cv=fail; b=nYYuKfvjop702BmGn/59jo/AF71PYmNn1DD99eAmJMIPiRPz6hegWpSuqmbAUMimz0Oghcw1ShYG5qkkW85wksReHNyoc9a0raje5jYG/qqwZ379arz4GWB8naPc0NxkIEgbs0lo3gh3Dd0DsmsSJ8cAj0QtfxRPwA1ycucfNQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586843; c=relaxed/simple;
	bh=jjg2Mdw2skgFl1jEBpYPc+Ui7CuK2iOX6j9V0TaaAUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhZKqtTqqwHQpU/hAkq1a7T+3vp8raxNvCmZmYNAqXd8eIeITaxP7rLrLSpBLbGMT5mEZcscaSlc5sYNUqFzPXXWZ90zJv6bY3a8TLxPkVkhGLkgMgm8/2xtGbc2Blc6p2H8LJi2kssIDieq3O8cOecR5OVFM4+D8BwINCGu6gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+d1HfGM; arc=fail smtp.client-ip=40.93.194.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n49Pv9LOLLYyMQJzyYjJTVAyvl4DdkAr/4g2ToCrLODE8jUEE4dEEZs/9wwjPMeeHMGTWrh4Ib9G6YS9owdp1tG445S88pSQsApRAXQxm5lOReS5K9+fX5oXakpqE1e/E+YdZR/8B7G3n8CERv3cKvJTFpcZbE0mubEqWSxsMZgw2nAFe/sz9nDZ45P6yGZoxBFLDk38YJ58JjgnD2RF3WdzmgGYQU3UPfYdYPhrgCMTq6JeP4AGWevJEvS1RfVCPpP2/fcC/Lm6H31QeBCuiXXcvc6FbkbcgTEi8lOfD9/dIX/J3MqhXH0+cWIZRmrm5jq37LPnZjIDz+5Zrsm9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=KQZsjmMat6GeSLExLR1DLOcBk/BrF8mDJr81LDb39wf4x03YXG6KY2gIWzSfVQD1i2lAHWvKley4EGt9COJ3QobJJ6jl/7H3KgHMj81Fm0BF7Qp7mySyew8IDX7Z1ToJRPz0IPy5O0T4rkIFHAIvlyZiWu+xEjnOu9LoYQGLWTFhW34K+CUTH/Nvjr9H/WP79NUGU6kQ7072nxNS+sdx0XE9ojSVgqqVjFjtKImaUQQvW9IAq/i93BOaCDTFehQ/EAwMrSsKsbw16yysE4Bzkeq7eXxi45aqA0KXOdEGHz5gxsuP8lLYvnRFroJSIKOsMrYo53AoBi3pjjeZsJF3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=r+d1HfGMLw8gbun1M0vxAtu35Juf31z3BCTq1Jk8wwL6/knY/BkuX7KT2Z/ZGHeRjiYt5pIp+bp9J71vlIDX38+rblQrnbFVA3Nqd3HhMlMF229A86x25C4/vr0VqzkhpWeJQGNgTWROuHBI/KjTS+1RwvDxvvD5gAihrTyUqN841Y/MJzg+c2vj5KIzQLtsEm7piPt9Kn2f7QzMDMg3/BHlGPWv8fPFZa5x0srXfTDlgy0a8p1aVnvXZRzL6IMA3W/yrTY0FvPXytKNYYPLL8uV0hCvpftxE0vnunFpAAi+atZHILt35yQek63YGbKPO58jre78UCA3G+cf/nnOyg==
Received: from CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:33 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::f9) by CH2PR08CA0024.outlook.office365.com
 (2603:10b6:610:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:10 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:09 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 03/12] virtio: Expose generic device capability operations
Date: Mon, 27 Oct 2025 12:39:48 -0500
Message-ID: <20251027173957.2334-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SN7PR12MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 139f18e0-3c15-4e82-bf1f-08de157fede3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JYsdwOo8GdbaHLF8juSjGGNJXTtfhdwRqxWPqGza19go9by1QjqwYZAbvtuB?=
 =?us-ascii?Q?WmP95jMr0gq41DhDTUV5p6+lCxwk9OPHNA3JG1v9DhbzIX5NsZrGqNAKOLr8?=
 =?us-ascii?Q?ZV/dg7ncRw1xx5mip+p0ydCu/bsJ40Z1mDidJv3bKT/2/gGzibcrVuVKsd4Z?=
 =?us-ascii?Q?WoC2e/jkfzYDkr+8J4UnC6hRohCvjbuIhWhRUq+p38sVx7d77FfEymP7Rum/?=
 =?us-ascii?Q?mtkCwqrmkag/vQkSQ86fONbKTSs14SAvp9ZWtE/hyfbrcBGi35d5Y/1DQHQz?=
 =?us-ascii?Q?7VmQrFTVOJ62XIKBYEvObKJEdZZu9ZieXdwK17+49ht7RI22kPgs8RF5GrYE?=
 =?us-ascii?Q?k8rbkpus56OeC7rQ/8sc+sv93x8YFQjwVm+zGbX3v5Bcz70Bykg/ll0abeN/?=
 =?us-ascii?Q?xq09zBeoHV9HF/0s6Y0cLUzK/kX9M+7HdmKrgiQAOsBes59bD8p5sicixxoF?=
 =?us-ascii?Q?85S1o3EzV+bS/iZqz53SWTYgz9PTdQq7zSTk50F9P0KyZbDDUpOr7MzZoN68?=
 =?us-ascii?Q?t0GIOf4ptxSGZ+KsgnsyT9VER215TSuqc5S5y6EsRHG/cbZ3jVrFJjWdL+M4?=
 =?us-ascii?Q?WW+OF6A2WQQLLMkWR9tncVLTR0Uh0ODBpC1LvDdU7YoCFNrgmPrC3VMsQ2hH?=
 =?us-ascii?Q?RsRyqXkbaEWP3G9Ov+OPZBKC656F73iKZ6OAsvJqYwyI1YQe6y/UCJzMMBzM?=
 =?us-ascii?Q?rmVtops6KtKoWnOq/NGI0siN2Y9nR7Z6PBhuwCm/6+lz8SwGqu+OpUDoObzh?=
 =?us-ascii?Q?aMVM51SFUasqOqML47nJaz7XOiUP7tsRb3SkR4zxMES4hr7CUPQfpTNBnKZb?=
 =?us-ascii?Q?JkDknDfiboxTHRnanY0ZJQ4hEtQhxYC8EZp9Mk5NUCEsGkuZ+YmQqzasPgZO?=
 =?us-ascii?Q?5BQNZIcptp+nIzX1oGNMxl6NwZ3wLcE6bUrPNdtAzGNh0cHxZyOR5/a89VBO?=
 =?us-ascii?Q?CQEuvYyV0fH/oFsN4D0Be+owq6NjdNNdbap7FdV/tDytTE6/u0DN66Ja1CNI?=
 =?us-ascii?Q?lHVfrQciE1uufKykKonwvnEctYWytfTWjp8sRlLRiXGS4MiNIOWGkBpkGN4Q?=
 =?us-ascii?Q?MUZk+g1xK/0TPhRB2pOc5UXx2OGxpPOFtOp3QK8ysvty9TQ3QxjIH6WZscOs?=
 =?us-ascii?Q?zbqJNqtV/AZILCI/r7r1U+i9/Vd5AjjNcD9Gt29HJLVJuc0Q6wBj1B8eylo8?=
 =?us-ascii?Q?td0+K32ALwVP83S6D0tEjeFHWF7Yy6N4DBOur23Ptu1DfqW9maOHj39pe40e?=
 =?us-ascii?Q?L9mtsW6+O984YRUBOWTlHjbpxMKBvQGv2GbIpHz/QlnHAgJMsy9ZzA0vMiLJ?=
 =?us-ascii?Q?QSFHF7YTplxtQHFyTDjDmZTIBmCX5RypZmeGzHg0iJ05Kmb3AHwMgWhYftZl?=
 =?us-ascii?Q?BG9ApBqtDbNCpUdHO5KuUbUA4Q81fK0l9f1wsazjRI61whryvAMCCWWaizkk?=
 =?us-ascii?Q?4T6bQMZ3/AC5LIwpkj/nWNhSw0QIjtZDSAWS3g5e4HeeA7BWfwTdKnDDvk8F?=
 =?us-ascii?Q?8yWD5ntAOqLKbsrUO/fPkD+MSDqoyrj1lJQg+0leQ42+kwQvUzDNwNQ5c3gA?=
 =?us-ascii?Q?cz3pzesQmlibVXWAyGk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:32.7699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f18e0-3c15-4e82-bf1f-08de157fede3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715

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


