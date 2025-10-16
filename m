Return-Path: <netdev+bounces-229865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E78E3BE1783
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CB424EFCC4
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7922173D;
	Thu, 16 Oct 2025 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnqnGD2Z"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E6748F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590889; cv=fail; b=rBs1IodF9Rifc1VCoqISv6vqCmmRlI7fAiPS80khoEBzh0MgOj3JPWNIEAreDUTEAan1P55T+NWzaV63IbejD3VsoIOpFuMJRdH1Qfat6CurjkDPVj8C7qKO9m8KfHmoN/aFpGwakK7K5JicgNgl6Ia2ZRF8vQqvpyUWiYNEExE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590889; c=relaxed/simple;
	bh=jjg2Mdw2skgFl1jEBpYPc+Ui7CuK2iOX6j9V0TaaAUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrrQ+1nUROzHEicwL09GE06reBcXgx3fEbve+hIYZTJz//VtsQgaIGhFJkTmX4SKWavIK0LZdWO1/HagqUHaHPJW/A3cj4y+nKSCNw7QDW8ZO2Sugxz/odpAFkK/1ug9QVL5Zf65zfoml5tJ3m2RbnTf2hld6LZWshVFNmABjAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnqnGD2Z; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsCi6+AQMr6if+s278kFud7xz/v5jbJDPP+SIqlp84RjEXqP0FOUrn4CZREnXJuPKjbNcY1jEqWhZz45628K7d9LO3x3vZOqQZsq/gTrMMGx6wqDOJs7V9wguXqUwnTQkprMXbolr7UsRpqY7TF44ygAmy5GCIUx3OesqjWJSxX6jPhgdjAsSWTwiskh8oafLpeZpUn0D79MMUj7OKAHZUsnNmjv0MRNZ447ePbS85XVit8RfV4f6eZexTokac58LCW3LV42NXNK/qugCrSzrq0MiLg35Wc96M189p0fRA5FZA2XEXe5iWtsvfced1oeM84YNo4Aizbhnf34Yrq3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=p2rvzbb2PtcIBwVALijCpI3Xl2VCClY9KLHghorMZyZFIUJGN4Bviw3Nn1nisEgf6jZ+cYy6AGOim7DvP8KpoapDHjQkR4gnNpt12/pUZrXXkxmC1+JXgPo8el7OApngdCexXxspIc3Pnzc7EjVsYK2DdcEtHDiwaKvUkE3N7qZ5NTQXp9kfgFh47gKz8GthlfFIlvf1Ci6LiGiyC+C+/FInpJbqLg+A6pqOobnJqfxbqSDzDsF/mLuyKILbjDmiLxZh0Qp1n8cM31GHCKKDqCORPnA6Fyvg8cZ8s5/V0kg/Kd3Rk1kHKHtQcb/re3+0Di7m7jX/+rsr4I/YE5SKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekmPAXqjJBFkORk65YtJ4tcerL9bWhj/spkgWPr1Yjc=;
 b=cnqnGD2ZQj2C1QRmSJwRmVX+w3sBFL06CSHZ8VHeNecaehTxeVnLzzASgLKh830ir+vBtvfFHOrm/oTjseSnAkUMo0fGw2k/mFmj2Eib+muWo8VC44Aogz+QTTqKhZOWanXwJY3GM5WqvgXu9gF8uRjveVZDi4pcJe+Nsm+qcf5qbOxITTToyUQBtCwV7dTNfc9yTnR0BfCi4qXyLJ9dCmmcG/+xAP9JS7mW6FJY6VQgItik1L19iNFyYOtZNGZtwxo6Cc7JJ9fPT6qgcMAgMp6+NQRdX2Z8BGdN2jFdU9w0nwfmQAtbZ7Sapf8n3L45gjNvD3OkK6f1YRd8INfogw==
Received: from BN8PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:d4::28)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:01:24 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::1f) by BN8PR04CA0054.outlook.office365.com
 (2603:10b6:408:d4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 05:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:09 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:09 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:08 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 03/12] virtio: Expose generic device capability operations
Date: Thu, 16 Oct 2025 00:00:46 -0500
Message-ID: <20251016050055.2301-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7053bb62-c89a-4f1f-269e-08de0c710de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lYa2Fewx3X7FIY8/wb4ZKXJIh6GhlIMFOHm4hgi0Y74jts+IIunMaDN+KNKS?=
 =?us-ascii?Q?AUfEG5/ssYjEOll3fQRfPOj/Uj4j8fBDB281PbH9kwQHQjMBNwsRyQcnMvPx?=
 =?us-ascii?Q?TMzsb0yKRBj9X3vxh1k3JumwVDmYnWOf/XmwRBEvhPSuo9r331gvKmbbwAjy?=
 =?us-ascii?Q?SoH0oLdfQepfnjUzWoDTuNbNGSAkDxp/+9NnjqLbpxmp9crsw5fmvFRapzXt?=
 =?us-ascii?Q?jMt2N+7hJ3hAGWqxAVfP9AD+1Me5sRsMRhjH9x//GHUyd+Z0qXn1CH4q+4Db?=
 =?us-ascii?Q?wnge2aFdF09qxbn0NVL5ixakybk0YRe1uskgfGIo7+oJycTY9fww3X3S/KII?=
 =?us-ascii?Q?dhHTARrG7+1sdyMSQoKfg1g/cXdPVOck+ACRyJ4oGD1PhelgsM9ortDMDi+2?=
 =?us-ascii?Q?ltZvNL8b24V55qlFmRr6BSFx5jp3PkpDftLPy4RGW6qRM4/LQggfSHEOstIB?=
 =?us-ascii?Q?QTEQzZW38cIyxuzYrGAJtjuEVMBAF4+SZfHsWjQoFWkh4xceJpb9////FjJx?=
 =?us-ascii?Q?TQQc+LOsJTkPltCng2dbztJnrBadMsjaQhnfrgHX9PD17O1YOW8B152vnK0X?=
 =?us-ascii?Q?ChQSZNedU5CrxZWWZeCrlPxX63EuSvFblgU8bIWQCkdoa6A+xuU2iizPhUfe?=
 =?us-ascii?Q?4vzV9QovfdG8KBFgdnpmhePsSL875zz6/p9QDWf14NisQnNDxPTexpiWp7yU?=
 =?us-ascii?Q?RXG0UgC+RbdifER2NYjY2qOV/Obd2xR5OYBj/1ywgxE1GNDmMeleboe10h/8?=
 =?us-ascii?Q?u/YQ4uDL11r9+rIKB2DmznFYUSMp21jur6Q9s5iMOhDvEc0GCq5eQVWv3knk?=
 =?us-ascii?Q?jwS8grs7+1tvvj341p4g8DqklAWXUoLrf3H64/W0Bqs9/8LnXSUHo1BQp7g+?=
 =?us-ascii?Q?n7/H+6C9ScHx8eIXj5AgSSGq8f1wk+puC/zyA/NCO5+3Kd0YlTZiFo4b8qNS?=
 =?us-ascii?Q?3uVvAO/Ioaq9QQwKk/cyNXjGKufTm4uqm2ghPKVKg4nxl4cpxPyO2t7W+VHt?=
 =?us-ascii?Q?eXHf2JnkiMfR0zylnYp7Ax46WEpWToQA6BWY+PhNv00LiIhvWCJZ8tIt++EC?=
 =?us-ascii?Q?Z5ro4SE6SWZJr1ZV65E/ELK6Ig/6Xi2uDipvw64YeR3PNFUoipWvoNU1w5NM?=
 =?us-ascii?Q?zSqb0d6snPaR/5dA4TtD0cfPubsiqDvDJHRsXblGmjS9VRsCUNnk5orZidb8?=
 =?us-ascii?Q?NFDPcdiLSfENnsfynB1LwrduY7I7bWv7cZ3Q/a/TykwMyAvoGFUP6OOSaeNx?=
 =?us-ascii?Q?lwUAeqIQNASAFjVzmzfOfoqXJYdCYVwExQM8aGk2HG3spfhRpbmwIuKmosVw?=
 =?us-ascii?Q?8K5bs7JIw2VJ7nT0WxrTOSqQRj7HZsO4L106QZoDmncCG1lEPm1vxM3+BpY6?=
 =?us-ascii?Q?uDUsbP6xZe6hpXzOmsvntlxE6nzzuzruFZmLMtz8UI8sr0ad+5CW44UK79wj?=
 =?us-ascii?Q?VMftBZl/HhZTjBGi/ZDsIDWK0y/Xi8umWLkrKfumXyK33v44bfezwBVhIvGH?=
 =?us-ascii?Q?MALaBTkeyv5zTOJlsvDAbcjjUBgaO4w9c9e+ONKOK8snGhaYjuJ/q7KxLQyZ?=
 =?us-ascii?Q?MTu0jy4aODYDMbaVQVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:23.5437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7053bb62-c89a-4f1f-269e-08de0c710de6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365

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


