Return-Path: <netdev+bounces-236618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6CAC3E6BC
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06173ACAD4
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE8225A39;
	Fri,  7 Nov 2025 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jauPoGT1"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F041AB6F1
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488996; cv=fail; b=TegBN/NfxNxFofafHD9iECzInHM2vlQw4v71YxJF/tYEfwG6y52LjHKfdBk6W+bMTe/xcCvzAjYlqdExNppUJKWfTqCAgVDSIgDKKxzZvrKJLqNQOeuTy34YQNZAZq5P20lw5YJ0WxcmBfEDHFXD8DkqKk24D5uens1oXD7aVF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488996; c=relaxed/simple;
	bh=my5y7671+wa017oQQk0PKNYiFe3i47pGPwm0th9mm6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdwehnSKhUd5p6NzkP9UJTijLfSG5ssATLOOeOBP1JLMtsqoaqpRo4vK0UnSFM007f2jAqBD+spkCk9nFrJpUJ1P0uJWl9zky2scdDz3D4OQHzTEUhthhTU5m4Z6T/QzAv6aZOd2Q4Ci5tdOxv5NGFUHTukrGV5LAlBHWK0XCtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jauPoGT1; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG4i1eL/FMEP4qhPwvYkmngp0a9IE12h/xwILpZc/zDUZhnBGpbW+JgX+zdj1GMF8nVF1317Gv9LbVdUabpG2hmQjdILqIWCkGRkVwYvpvbF0FhnzgEQXQU2PNjRPXz2RLoiKSJpzXneDZqukjFRu7yr+PnX4eHPHhOzzH6nRJlRKNVR7LOwuZXzGJwF9HE4CrlZEe9CmNiHeU7xvzGPNv85IQ5q6NfrIYSwLgw62Neco4457UaIZRhAe1sJkdcNlIakjEUhFa3sM5hpaaSAXBLlcznYfQ+uJetH21yU227k/9Iuy9FfNAuzkcFDdawBNzaCMZI4ECbCnbIhfvPYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=v1bc88s4agoNpPIx3Uzt4qb//B2HvM5HsiDw2gXZKkrfxPKpjk0gJsJE3kAhiGVYwOsEkyaWj+hW9E4l2XdrTPgCpcOhAu1qGjeMGvXcLZ6vXnJnDRqF+0hL+tQ96j+SJPKODc2xxO1zf21vYI+9X1mUwr//0eAm46MPLUDa9bLnh+G3A/OodWdCd7WSEbPttIvl8KofoieYBH9PqjO2BQEP6oB7iEdcGhur168UPudt6mi3tfMDK9wZq4PsFbv942RiRQcvXMIuqc+o9JBP1WjryK/qcACSy29wwSYZlPjjJE0YovR8LOIALvJIgFNY0rZO+Nr4NHBfWb6CDb0D6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=jauPoGT1JkFYYlt64E8YKvClGom7EW8jVld2G2RbwTFCnN7RiIZ6UNuoesgOA9Bgn1q37/d05MXRfSjM85RyuAnJuhDXMPoMVZfMALRP0w4xCaaX16vwCrkqOwEfgSgjv9/jMPYPzblU4lOZb3Ffa2QgV7dICXmDzrjk4X+a9kb8frJutWjvnPNTmaXp688lAgzGjuag2QVsDDaDiHD0A12WAFW+2Iut6/bCf8FPW9WxPK+rGq7IbjTLUgg+kdhlynVsVPKROzCCiB5TIJUNgDcQy+93dz0Oa8LFmIZiRlZrgFzCqgIsRd6E13O8/6LpV77NXWwprpRpcR6JugtvwQ==
Received: from DS7P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::7) by
 DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Fri, 7 Nov 2025 04:16:29 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::19) by DS7P220CA0013.outlook.office365.com
 (2603:10b6:8:223::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 04:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:16 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:16 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:14 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 03/12] virtio: Expose generic device capability operations
Date: Thu, 6 Nov 2025 22:15:13 -0600
Message-ID: <20251107041523.1928-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 41933103-a883-40a3-3e89-08de1db46ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IgboizIYy/OPbI5YXHHnjlT+OOo5u/8YcH+jW+oYSD13RKDcJMcfFSPviObU?=
 =?us-ascii?Q?Z+SgU3Oqa/PbC+j3wHzyGNufwgyebSWrjk1jRfk3VL1MMuwgsVrFwdmcqy6O?=
 =?us-ascii?Q?/bAl4BYZRkixF5I+VB8laKZCH1epQs5vH49pBQQ1llNSrleuk5DETGFHQhCM?=
 =?us-ascii?Q?PM7LbZZlzScZp4OK+g53RTGa8jLgxp2fd6a4bCeV9ECBA9uH0u7sSRz2gEGy?=
 =?us-ascii?Q?FsRqMaj8eDvdHGzR0wkGGhDRBMHHWUPmwZrq12YIqLmxzUNTVAA6SH6IRgow?=
 =?us-ascii?Q?Lf/0dwV85ESLVOUINRP2/4ZpZgp9VZKqJ64WWC/3gcGXKq2KU3CkBd5kzU1x?=
 =?us-ascii?Q?yiwqTvdY561WMkO+gf4LriNsQwv1ZyfUwvy8kktaHeKas0ivPM2K3zFULvxN?=
 =?us-ascii?Q?sUyotgLjyHqLHUnEdlHeQXQALzoDowPd4bsocJUqvda2E2NoJbW6Ke46gwkK?=
 =?us-ascii?Q?LSWRxu6jmETu7G4oT7TKyuS029VmG7NoWni33l15BnzBraMGg6XGqV+DMXRM?=
 =?us-ascii?Q?jwxRjQ+T0uuoaurVmZKWAL26W2HR3ipcl+N9ftmB1ZZgWCFjcYC43EWH/rAk?=
 =?us-ascii?Q?E4d748J13fBtjMWY0RvNpJ7HHhgyBgFcNgDDzSw+avFzNi5C47YVaQozZKOv?=
 =?us-ascii?Q?A2b24nC1gKfO6IgoYz+hKI+45l1yIzeNyYm11vnzSKoRY84FhVCloxxWbMLG?=
 =?us-ascii?Q?tvgDoXqPN34QOHjtC6IvxmU529yAt6hJsghz96138GStWA83SmHs1AXZrWw3?=
 =?us-ascii?Q?TCHnEkTtA0o4zZgFWuFSFWLdypdOkc6vxZt2hhk9oz/U9rkB26tH3kB8od98?=
 =?us-ascii?Q?a1zGikcbjGT76iwkQt1DC0aXaWxSPosH5WbYVOoV3IEthZybMORkAAhKJlJD?=
 =?us-ascii?Q?aAbGffXq7A0Vym1wuEUxVdK8ee5XigiYrnpIpz37hokzp2j4+z+66vbFoXci?=
 =?us-ascii?Q?ks35KrRZ7TWIVuTf1CktkvMaPAI9uFYCydB+rbCZO33/gD6Hg0NNXq8HnvOl?=
 =?us-ascii?Q?u0JrXZ9Hkk/5NLIWjvSYFv6l0uVSsKVEdi1WrI7v2bt6eE4T3C2qHFEXwaVU?=
 =?us-ascii?Q?xSIeKBnR92eWAxqtcI/2A8WXej7R0l3toj9mhQwHWViiSIM6qNjZdOWhi7ZX?=
 =?us-ascii?Q?2ZjRRXa6zEIQlFuj04kbJgm8SYnjwgLshS+2d3sncyI6fSyXvWHd3A0aPy7m?=
 =?us-ascii?Q?iU8DQv18/jjx8qH5//EH7XQ5GkYKWfWIgTWJG9eVbxGQEd91IzliurKhD5Cs?=
 =?us-ascii?Q?mIVOfqDMzdi7IhlUKDsBfBRkItSJIUSlDbaw8dUxPql4GQpoeWfZAGpODbPe?=
 =?us-ascii?Q?ZsisGY0ecLddq1MzDC4LN+i6yU3uwjmcH/MzI8mJBjZmWWMdEDw2AobRRGD6?=
 =?us-ascii?Q?ux0D7ii8mbER7C7Lr16oPt0DlFZFjFXL7HiNvebw+M74kx6VatJJlQXfRNOd?=
 =?us-ascii?Q?yigv7Hg+SLWL5jsWEkXec9+YFlDTuEqVjxuBwBH9GUpLld5B1RySXOutIgww?=
 =?us-ascii?Q?XShGeY+wiGQ1dXjxbSyg2Q5Sxw5NhtzAdvi+lYJ65hlPl1MA6FtP8iYn5JGc?=
 =?us-ascii?Q?J4zqdwX6bZAUhJ4FW0E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:28.8462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41933103-a883-40a3-3e89-08de1db46ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

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


