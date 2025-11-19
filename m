Return-Path: <netdev+bounces-240121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED8C70C35
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id BE30C2B0B6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6B36C0AB;
	Wed, 19 Nov 2025 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H2a4M9gF"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010016.outbound.protection.outlook.com [52.101.193.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F68B3148B2
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579772; cv=fail; b=HfXec+n6AAP4igzovBPQcknkhhQ+3fjW7jlEaXfSbxiMbSitmHu6CcNbUaOumvJ9IDIkN/JkMX31+59RLQ3autfonOGG15A92FVpn/Szz9ywysI4+1s69hAGzHiTjK8UavU2J0FAu/8d51O62jsX3A5ms+2e1c67PLuXuU6wIME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579772; c=relaxed/simple;
	bh=2wyQA1bYTdbR3PWFgbyMyOREslkP63IN9bW92HfcW68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oG0NHIExeFjI5Z4bIjcihrjFoqRgrEXBYyCaM4pooyp2FLS/PBhsIcCGry1CA00861KnRWselYtohGLwnQJDP+9Zmz7rGLyOMBY9Ul9U/bDOEJkUgIT0/8DYSq66T0+J/3YK17q9ldtfjGUywwc4JuIt4Az/u0pvPtmALGyiH48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H2a4M9gF; arc=fail smtp.client-ip=52.101.193.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prF1vqtblMSbW7coTvhEoQVdtx5SIlVgle9pLPUFQW4kNx+X04MpmUjFA3kHa7ToqbIG4dOaIlCbeewq6LbjS8j1IwOIL2otMK88/cYcgAHuvdUse7jum2zwGk0RDJppUx/vWtGxC/iiWd4sT8izRSjC6reRA/P1JbtQ2GhB5EU1K+H5C0K9cS3XE2H3MMHga6e8xZfdHCaJZ4UJZM+QPdxl03kTAX7nLwLmwh+EvL/zm/SAB/KvOoCFUaYx0D0R3hvAobLDgSnbLi9qtqCxuTxIiE40YPfklvJUmVS23qmMIN+HBSbeWAEr87eJxM41kVnlS2cwUalB19X/l+5iNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uId+OxFdN/LyW4KjJJc3tyhJbWWbaxyMTv9Uoe54hKc=;
 b=AVYq1U2VIKIR+UAB1EO3hZzTCwZzCdszOOfnIYv8i409vwl5cATDt1UjiQjCDJnAZXdehITNP4WeDQYp+fszyLCf5JP8E4MKeJMjvRiiDvasprKcNUiQpiWISz2JEH+gz4I8wy8fqx+P0lEONnXts8fmH1EWMDH+U2nNZppPcZdoTjMhpdvOXpGg4IzaSfPSkTc9lsHyCiQhwZuG50xYUWoYmVoyKItFsD+G/j6Tr9Pa0iIo50oJO3lijdsiWS9Yu8cxlOHlTrsSKri9n0wLHye2AFe6ftf3wNdSSlnzZNnRKUzliHg+XDVX8cNhUNb1QeBELCLtOy2nVWjCtpstHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uId+OxFdN/LyW4KjJJc3tyhJbWWbaxyMTv9Uoe54hKc=;
 b=H2a4M9gFt8Zq+AZngXRv9A80vUOE3H+gOjArY2VnmERtXBjFQwevNSU7USzQk6mKubfGCkRWWDMjhr7f7XuMrw/NtLyJQZRgimj+ppBKuslM3KSZpJha1zRghDiWHwCvR7wL+UvJYCO9165SNZqQbU5Q0zVHm4UH4wJChe2LwqznxBGeyFgs+Kg0rzV+/CBH3gleC/lGZ8xEPROv5NnOazUHqHYz5NAGZD3Q3ZCSeJrXnvQ54LJ/XvBY7EIfbAYlBMBYGpKXMbi50XkNYfZUuKirZMgx3xt5AcCiQYQPcpsbOHm6iC2ZeIduXDqEVIVsJXUtpD6wgVsnCScQqZUbrQ==
Received: from DM6PR13CA0008.namprd13.prod.outlook.com (2603:10b6:5:bc::21) by
 LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:15:52 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::74) by DM6PR13CA0008.outlook.office365.com
 (2603:10b6:5:bc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:34 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:34 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:33 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 03/12] virtio: Expose generic device capability operations
Date: Wed, 19 Nov 2025 13:15:14 -0600
Message-ID: <20251119191524.4572-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 644699c5-0d15-44f9-cd63-08de27a00d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSoNj9rbEK/DeViQ7LP6KhVDgWnu/avVYm/ghblFFKjbRE2J6uLbIuirxAWg?=
 =?us-ascii?Q?bY9/ZED+ls3OovAo4HGs0anS0tRRzA4VZFoRu3VCkq9QI8Le1U1apbFQj7rc?=
 =?us-ascii?Q?3CA01kH5bqHBcNjbPgdEvwkfsFX0wzVLl76XZlnYwWsatG18xf382Q1UPFcy?=
 =?us-ascii?Q?SEzbLkcSa5I+tfxWyuydsihn1+WjBVvQrr0Bi9yhYeXyAwZH+efggXF6fTDI?=
 =?us-ascii?Q?iyYtddeVzK2yL1A0kJeJLnSPS6dCSwZtulrWAEyUjbc5YLRppncM3RE8Is6v?=
 =?us-ascii?Q?OkaWkaxQr8+oRx74EDRf/Ioj9CMgruBMjXM+ThTdPJT96G8l5MQ6+M1Ek2eF?=
 =?us-ascii?Q?wqvXIN/5DmQoa3v+kx2xVDOW91ocCvxdLiiKpA0OIg7fKCo52zkXzBmxkp43?=
 =?us-ascii?Q?9/zW91RG1oH8P/OfDZUJ0gbuiILskvWvlS3rhvH3L+0GWQqIgSDy/jbgfX73?=
 =?us-ascii?Q?X48eoigqWsZjx+POWU8wvUF2/jHnbC6aUuD74md4UCHRQkI0ASppc2dOHuDV?=
 =?us-ascii?Q?epD/f30jvyuqVFDMC6RiH8us5DU8xJDdOwEiqlQV8S5PndNNjLeECzb2mtRW?=
 =?us-ascii?Q?OFGVC+hufHQU+ChOdmzNH2jVLoBA+tdmglhpkb9e+NgI6uz+m6hCiil9azk7?=
 =?us-ascii?Q?H/ypQmH3lZLKA3iEsPhbnAHMPgt42NbaAhewgoAA622KXPzGHMe6D7pJRNc4?=
 =?us-ascii?Q?Bq1QUZZgbEd01EWzn8QQFX+GeDUheNA9JAdOi8O3a8BNOBEJsosJbnbt+CRn?=
 =?us-ascii?Q?NHkLeFahfu3fRokrf3q40U9Taxt4E6ObO0GmtZWR0yoISu6dpAbV0WiKQKH8?=
 =?us-ascii?Q?XhM4mueaeqwI9WkNWMYwUPhozlHzxCasgqd19TYoLK79fJ1AOe8dtw9ljzrM?=
 =?us-ascii?Q?KMpsZPExkSfCxLI9FoWCqWyU8jGDFione21mfWO0fTvHyBCxCzGc/pKPp+b6?=
 =?us-ascii?Q?z+LuWGSXGH+zX0Tk8RE4Urt8GwakNQKdkqZB4t/V9k8AHRn5n90cyjaoTKQV?=
 =?us-ascii?Q?QE4yUlS/rXqNFa9n2Pno5YljHX/nS3hE1Ovy9w8xgwBEG7t17IsyZ8CKTycU?=
 =?us-ascii?Q?jX2T5TDdiI0AyWTUlNfAA9S6W+HseqIh3oCHCqk3X+F6v8HCEnRNyzsvvITE?=
 =?us-ascii?Q?UKKf7dFz0uc6Q16upLEo+jYa5wg31it5p3dd40vd/x/dzmVtP+Jrhbalr7e9?=
 =?us-ascii?Q?+9XiaREsOuupz2HcOKBBzn8bmca5uwTEQJcOfO4pHSIzJEOANBcypTNhrdAm?=
 =?us-ascii?Q?A4CzsKAK5ONcA5YFQx/ABUDB9ql46/cBhKBEjhcfnD6pLR1S2V0toycILIiq?=
 =?us-ascii?Q?uu2Bsi2zIwj3QcPzP+tpUZE+0E8obyglVBmErYvyaDM918zKrvznVDOGdvGE?=
 =?us-ascii?Q?S8FMJZLnZMs9OSpTyJyY8O+7hKN2SCaCF/eOKOBZcP5e99IbMkt7XAXfThIy?=
 =?us-ascii?Q?VYOQKXxkJuEmsBMLLFXaxcWKkHNIMZEeUNp+hdIye39e19skOzlLNDc/XhcZ?=
 =?us-ascii?Q?aUqe5O94zRpbtNhPW1r2rUUWhqM0XpFAHoL5TgbWcdaFTnibnEX1RGYlml98?=
 =?us-ascii?Q?E9fSIW0DsD5JrKymvGk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:50.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 644699c5-0d15-44f9-cd63-08de27a00d4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

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
---
 drivers/virtio/Makefile                |  2 +-
 drivers/virtio/virtio_admin_commands.c | 91 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 80 ++++++++++++++++++++++
 include/uapi/linux/virtio_pci.h        |  6 +-
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
index 000000000000..a2254e71e8dc
--- /dev/null
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
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


