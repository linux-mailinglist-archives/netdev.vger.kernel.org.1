Return-Path: <netdev+bounces-242002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44086C8BA25
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F613B88AB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961A346765;
	Wed, 26 Nov 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="usE0oZTL"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641A340A4A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185787; cv=fail; b=oF7fnM5Sa5u7j8Cf2ykNEB3x9dhkD28P5eSURch9V6c8PlVVYwo0ztJqlaZVClA6D1pp0HCf4KS4oFtsFAHq7uxcVp89lckl6mUTkHiCAzBsjei7D+FdmFrz+tj0GqIQpY00XdjEwMhviX7Dno7UZ5ZHjbBO/s5AS2WbOeKgvew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185787; c=relaxed/simple;
	bh=fxKgeyK0rqsO4yG0KOJw83dcVB8iV1DBqfaHqdXEs6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLmPzOrsVJxJvw013bg04Ev6fP177wxOKcDQwlEVj3vjHsoMAd1qiC0AmyRF1LKplIWPrNYe2X6SMRGiyfzjb2+2OC9LOLYxdFFboPBi6y7lTQikiWFYCCB8Yrs48+TbWkKwNpx8g+8yWqfg8hJiZRJDeJkug8aM05llMyE+4OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=usE0oZTL; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgE/tXh30QJGpT/dwPtH+ZGo7i310AsWLf4F5UEHbwiPFkNaLmz/dK/fpo0Q5Zdg80GSAlFdirlh0dUEdfJHG5lc68t+zwLKpSF5Mwy5TspvydUTuVxfFm8Mj3RfzxO1x9TpSeuKKz9e+2BxEN8FLjVK2cvELZ7oo6TIDOuSPbpruQz2ui2+0UIvck0gJfKf0shNbXpkB9fskObOuNFd4IS8TLPaAgbbdVCDjIcAnGbTArlplqe6xUJfMn03kaGg4FHA2rqAAzAZpt8+h2h+3OY1SbtZ90nrqG6N6eX4KkHUgz7o5QKtRdJreai1LHHzE3h8nAghq6vFhiguMmd3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dH/rLVlyZaeyhMhRHQPN8qvichV3G3eycROJgqbuIwI=;
 b=vcOPrOsgC0yeDLHcMXA04bXh80AqZ/44YUzVKC9/kBSldo8Z82nHmbeOAjqdeOGyJ1cLW1cRFnVscIJNbZcqdt2Rx2DntJXadcQ4x988szARW785P8KnXdKA/1n/z2HceBX5Muf9b65v7BukwiJ59ggnZiJ/hzYk+eVp39/RRvKBdZKHGC+WzS4HNHSaCumt5aDLMvS6Y51czx9gr7YUNUn2qIuoNqpwXPoUTsnXSXf7CqcuoxeenTxFqWx/SVYRUaApo0/v8Blj1qoiDLvBZPuYRnu/SS66LQX3CyzetR2lYGRWkCoqX91NPwzg7wQ0ViI9LkjQcGZZdA9EFj+Vlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dH/rLVlyZaeyhMhRHQPN8qvichV3G3eycROJgqbuIwI=;
 b=usE0oZTLje7dLKN23123mGaCbBngnLIinmBDCteTdIkeE/KZclShC1ADcqEPRhRoQpdydEzSPswtdEPBbp4oYliLds48tQrSmKBE39yMAgADlcUhXZV/9vpfOsd2NgZZGvYgQ+aV7YMqRl/kZ+crJnqHhGNuuf2abX9jeiT+ppFsuWzdiyIOt5Z5Z3cSI6k4M9CRkL60L3JWfjNlh8taTkKlziAXnxHYiV0zP7WdxpxOC247c+akKzCUswrg+/w1HOLm2VzFMDJHHxF2E1GN1nI/EMQQyMRsWHKUOE+pDSoc+iGBEE4Gmotzp2H+fdSZajRDVcwA5aOZ3CKW1OZ/ow==
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 26 Nov
 2025 19:36:16 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::88) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 26 Nov 2025 19:36:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:00 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:35:59 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:35:58 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 03/12] virtio: Expose generic device capability operations
Date: Wed, 26 Nov 2025 13:35:30 -0600
Message-ID: <20251126193539.7791-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SN7PR12MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: c8bc796c-753a-4521-dbc9-08de2d2310eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hjjeN5O4yVGFefoV0j9vEoI6HN8se0Hi12efAMlcXOhuYfrOYDsvEbTb2jj?=
 =?us-ascii?Q?04kgLg50w+i35fr3/7OfOAyqaBCiA3VjdrmUhrkGv1RTB77Q9cR8d78IM7fB?=
 =?us-ascii?Q?tc/XNTc8iy/XSxRRaFaePp8JFCpLueIE2peg/mjh8+9DGWCZMwdJ5E0PEeSy?=
 =?us-ascii?Q?pNpHCzwuROE+2/oMpwNAyr7TArCdd6ThGvZN2RD4WRo6WcNLzW0Mtu7PeHNA?=
 =?us-ascii?Q?10m0PVgRbA8wIvSlAfYOXaAjF0DwTVU74osIr8XUNx6M7YT4qWFjGtQAD8r2?=
 =?us-ascii?Q?Kyv+CxArBzb2jnIy1qFh79/I4jRB0aA+74LeX6ZeLSuhD/a702Fch7zmo1Yo?=
 =?us-ascii?Q?X/ujutCH8s8LMz7h0qvVEAMCjCn+QKVKvp8DwSd77nHNjVztRsZrRwZlJyPR?=
 =?us-ascii?Q?oRJWu9KGZa6slvVRg2JYlalfHzpkdA5PHj5FvqoN4CRseu6Zmz7BgkYoc0mq?=
 =?us-ascii?Q?Ba84h1tTWXHOvtNi+gm8zffloSoUgcBuLEtDWt+cJRVIdSKAX2wOuFBye2Yo?=
 =?us-ascii?Q?0RMlwJMP8IZei+FjtA49O1nKJuxNhK3hMe5bnTD74+Dyxyo07/sfsbxA5kfv?=
 =?us-ascii?Q?ved/YC3NwBM4NkTgdQ+9u28cXAVgGJ5/1CFOUyLDozRpUfyOabOwDGvPuvfX?=
 =?us-ascii?Q?ThdZsybXLB5Umx+4v4k5abUErymt0TMFTnGwdBda8AnkccoZN/ayiKAL3XRC?=
 =?us-ascii?Q?ggjBQ7cBI21M2/6bqaq3P/iafN55iwFGybWJCc7dPAKhhmKR4gsGTBvxyart?=
 =?us-ascii?Q?XQZjVMZ0MG2qhG5uXFptItvP/+rAJfZA8eAjVgvP1lMAAqKeOfvyeJHpd7gJ?=
 =?us-ascii?Q?nSX7UnCx/pm1uWspQfSQP+H+Ic2CgCZ0VIW8WH5QtmLBT+SXdbvwJq3oa8hr?=
 =?us-ascii?Q?kDG7+ffInfTrrBuAvAGHtdsYXSaDuUlE+KLpTY5USAVAWKDMLXHHn7sCNTej?=
 =?us-ascii?Q?1CQjcTLMbde+fMkA8T7Vor/B/onQNGykRaKcJpoJWgn/hjh+U9FeulBdVbZ9?=
 =?us-ascii?Q?RV9zCF0cBw56UC60RdgX5kLmKqPueG04As5uimBDiVOTUjkvIxdRtJGth67V?=
 =?us-ascii?Q?XI0BYrWI9+UV7BKPwUtmUnOCo2GCVUb3JYN+TfmnlglF99Jyb++V4g5SMUpB?=
 =?us-ascii?Q?ETQAqVQ7Acx1H5QQ+KECy97SUmZI+5/FasBxGYSnL5IbDFLgS977U+8zD833?=
 =?us-ascii?Q?irlzkwd2Sn9JVxeFD7fyASHU2ecyhRTzkSTqWl+ZeXtQFbYcDKH37wxwTOm4?=
 =?us-ascii?Q?48m004B7xH8kyJ+b8/L4hCWWeFrUbcYwSoDudjVRurUF5b8t1aHQgUWY/9NW?=
 =?us-ascii?Q?UhFZgNCmJ71akPRJ9k0Aw+ZISgaD55nYoS7xP7W/IWavD9yHHbdw0AjqGLL9?=
 =?us-ascii?Q?Kq2wxmhijeCLm9rokaVl+0NBeKM6Bo+oQZYyGxWl83ZjHXU4v4ahmDuHiY2H?=
 =?us-ascii?Q?MBOHvZFZ9B9MSBz+4Tu/x/R5mNACV7qEZVhaYTSBgG1lJQkPW/sNmtN8dd6N?=
 =?us-ascii?Q?lxPIcL2D+bFGvZgcJdsPYFvIjZeEIby+dGQsaN67Fzu88rfkjJ28d5SG1Gq8?=
 =?us-ascii?Q?lAMcBM1X+5QCcRqKnFA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:16.2694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bc796c-753a-4521-dbc9-08de2d2310eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813

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


