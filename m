Return-Path: <netdev+bounces-236073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E781C383AA
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCE3A34F846
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25FB1EDA03;
	Wed,  5 Nov 2025 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="opsRrQ8K"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011059.outbound.protection.outlook.com [52.101.62.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782823B605
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382710; cv=fail; b=NOO1y7M+A1QqbJaTS66FKpkzO3+QKCSbu/3xgx0B5cj1VSWcagrAa6JJEng9iuX/WjYzQ32RJZdsuyPEdo7llJaPsmOEbeU5dRIxO9pkUdH35pLXRd8Y+4F3YLmjgBPb3pUI+A+Rn9bFW9z66+CymfaUmntp/Nh8KHpWgsOVzJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382710; c=relaxed/simple;
	bh=my5y7671+wa017oQQk0PKNYiFe3i47pGPwm0th9mm6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdQb4kFQRF92DpM292cOMKiMiuFO7ynMAITOEVxCztZb8/rEV1L8YE3UTzvwGDCiJNQzvde5ZL/vXXB7LnJr1jgSenZmbGavZk9meC8HOzWgFIUYTIN1JaMahyBdQAe3YLg1PdX+dPTj6mvohGaGAxaV3JbrX/xyjxIzE7X3qic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=opsRrQ8K; arc=fail smtp.client-ip=52.101.62.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrdIakdCSVR+STJD2AA6Ebqwz6vXG0nH7+oG7375KLjErTaW3TWsHDseTm3tfyIEw7SWVErXQs5Uw9/FYc0d9L69zeIADiLXrgKckyysK1AzFcUo3l3AOakO2LmSLLXnZX3umHUdIqkE7Fg0Wg1vi+IBlUbxjyYCrnDbp0NZmM6+DY/cvwDjZnJxLiqR0A14RxvEsiVUfuNmK+LCLlgWPlozDKMBMCKvy5RZl0auq/7czkP8TY2PkdG25iyxU384p3DtuRscusJokDwivcvkZknaIVfzP/wNT1ip6fP0NwvTo0uBjxALdxFW8wQ3aaInyy0GCZh2FjsYbg3d3HF49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=t27mMEbXmk/kAsEESEJfrp51ZipKSU59ZgONV9Sja5ePxQGqmmreo/vxwnyQKdcVR0ezP4uEtUpZwGvletbQguyar8LtrNHcGatu+ioGXK8Hyh0jc4S2lLwgUI3rAHEDxcL7UOWZd435pNYvGuAeu7rYnYafjkbDHkBaDxTLgy8cDRTLADsBC9jPpKsJCRKUEhJXx81uRjV4kDw2a085L+atPajpTyCdXqlRS7MkC7Gv030YkxfEMlnk7Rlx47IHL/1QEauz/c/Og1JApg1dH21vZMr/IWySzUh82OLPddRcpJjunHXhm+3krxzX2Uh1cYlwQU18Rzheq/5XqKYZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=opsRrQ8KNlUHOvzEMJ8Yx3v6f/BhsQ7QvYiB33ad/lF7NpUB/eYBcpcrRIQaigtebrJNOHESBUW73EbjmAXbmkAbvHqeVxQK3IsMMuC0v9AMIIkPKZP4mwU6bS/RArmZ6PbHFNmLTYHXAL6zypr97xYW66oVesPq5k0sWPXq6YRbsNnqRUym+bJEIbc2Z4gBLPIMzA5QIrN67+Grbex6/3Ujnl1V1JioAN/c76047SVbA9jyj1kLwjvwS1z681gvAvmT0iDOfZ7pT+pCsD21Zp1xWlJIDd3yaVaELJB6oqb7KgvG4/6oFppDrcw7EkfOZbdzpEBx54ITygXEkrcUsw==
Received: from MN2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:208:234::34)
 by DS5PPFEAC589ED8.namprd12.prod.outlook.com (2603:10b6:f:fc00::667) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 22:45:01 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::37) by MN2PR16CA0065.outlook.office365.com
 (2603:10b6:208:234::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 22:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:45:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:41 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:39 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 03/12] virtio: Expose generic device capability operations
Date: Wed, 5 Nov 2025 16:43:47 -0600
Message-ID: <20251105224356.4234-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS5PPFEAC589ED8:EE_
X-MS-Office365-Filtering-Correlation-Id: 829cd86a-0975-43e1-cd1a-08de1cbcf493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANh183fE5XfOq2S6yXJRues3K6frC+TQo52PJP66SvX5w/Gbf0G7iNx5MKXb?=
 =?us-ascii?Q?NIrak9L6YWFqJwxDqxP0y4HOEzlYKBaJ48cqk0caVLA3KG1rF5Clio86Vuty?=
 =?us-ascii?Q?cU2Rks5SPUMElNuADlHVZDML3+GP4W325XV0d5qP15wGavMQ0KVQkjn/gtiJ?=
 =?us-ascii?Q?9Pc4iTGsK2ECx56eBHt3XQBPBBqQ7iZND/F0y5phRB74XWZdr++07Om3ZS8R?=
 =?us-ascii?Q?gEnS/9UmMWKnLFZNHiJ/BPfbwRaiM6jQJBzZKN5CFstBZ9iNQBhEC9rQDH0c?=
 =?us-ascii?Q?iY/BQNwYHDL964Iw5o3HMPIR7SavpkV8ole1d8Cv4cdE2yG9DVKkP2dMfMro?=
 =?us-ascii?Q?H13ZMaF6cepNauge8pEdJ87YxZ3hjeVUrXBHaSEwSk/BpC6jul8BTKKIWpLj?=
 =?us-ascii?Q?WzXWVHfEZZpx2FeC9EJQCDxWMhsCXoJlo0pdoKiL33celXk5Hz724Z26aazc?=
 =?us-ascii?Q?2ouuJn1JfSUmEA2TeoWbwp+iwJ6cyhrIqV5V+fClYJWYuVRriPcJ2BG2jedV?=
 =?us-ascii?Q?7iAGkaLu32+MShUMlJ3VT4mSGLXiKqNpoGzPayjqXI/00nPqhg5yOB7bMabI?=
 =?us-ascii?Q?sWezf90WCU1xjuXrmKUAdjSXr0K59pZBwD49YmVLOlEX6fTuDO0B5qNCIeEf?=
 =?us-ascii?Q?Vny8BFBrIvUTQTFxXu4koyPdgNWqLrQ7st2/LhhxphobRRk4a332x+kWhzo8?=
 =?us-ascii?Q?yTmpARIpsViWKHfxvHR6L/f0E2Xt0zFok6iqG3yWeC5qChdqMGd+PLnfxh9o?=
 =?us-ascii?Q?sc3+ONs9kKJto4JcxP9QPuU7jv/dSW+08H9H4AY3jZ10QBdk9pXt+BzZ9Kdq?=
 =?us-ascii?Q?9BckDnDCu9ykGS9aF266OIkim8YU/ncFaIXInBDxIsj1a7L/jpGo2Vfg+1LK?=
 =?us-ascii?Q?WSAANaeNB40eqvvoWbEMXLT+bY6bpZalTCwJs48C1ERqLUDCuoJA4w9pasLs?=
 =?us-ascii?Q?rpGYdeIsyiKPYzszFt579GQdrxCosnsKV893VRAto+z7AFc1pTvJNILPHh44?=
 =?us-ascii?Q?voHd7ZXr7POzjYDaYYvwT6yJmGu6DkmcjRivffhMxMrnQqVmh3Zm/D+42Dul?=
 =?us-ascii?Q?5yfx+gKNFNWzGbChLEqfaVjjGqSNNoRKw/0mtOKuaWIsVNu11vcB7SUHtkUc?=
 =?us-ascii?Q?RT0YSUwf7UtUbPHEJdOvAL3iMTMj03U6FBbwe9E6AVD9fYKAB/AbwFQvpQkK?=
 =?us-ascii?Q?fZnimsOwR212VOHB728qyTop0sXSq1JNtHwDmfejZvrv1jMaftUP1NYr147k?=
 =?us-ascii?Q?iC9onDREbmb4W+D5XAnqPgQ/gBIoI8YGUwPDZRjF5CQtKn9yRPh2FhUlLNlm?=
 =?us-ascii?Q?CBzS/MgaGVoQ9Vz8YCHshTObmfouo8Xsf2RpMYaXy9h2DYREBp1YHn8qu70F?=
 =?us-ascii?Q?//G1QuzKmdZ8VhF6acP7mVkja4VRGyn8FfA4CvcbQGZwuhhNZQJZiCFl2ifK?=
 =?us-ascii?Q?tQYqOXFxUy+11yBfxCNPDHsFWIYpoTHcFiLrMo4fdj9XjsLChZwBM5vX3HxB?=
 =?us-ascii?Q?mnLA+U0o4GgrwuT271C7yI5Oism1LuwOhee3+I5bvb2X0vgOtVsFQhMOm5q/?=
 =?us-ascii?Q?c/t4Wr/Ph5amU8o8Gqw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:45:01.4196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829cd86a-0975-43e1-cd1a-08de1cbcf493
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEAC589ED8

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


