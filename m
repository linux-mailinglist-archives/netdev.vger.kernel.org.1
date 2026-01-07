Return-Path: <netdev+bounces-247831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B9FCFF351
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A432130022F2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4466634FF73;
	Wed,  7 Jan 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pcSOkfBA"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0FC34E75C
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805492; cv=fail; b=R1l6J6Sw0qMpKkG0KTXCkDTM8HRpXsvfh24XS066XCHp4pT3ZsrTBkbLHBMHO2bNTSLyAt7foMly7CWghLmXOnzfBrnG9bTOAEP/LEMPpJZOCjJ9RJTvY52jhrIiKVg2Eny2ywvdaNsWammrNHDdiqX509CQR0kETg+Qy573UFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805492; c=relaxed/simple;
	bh=0bWuarCUiNnoQxPleCdoxJ9YcFfWjBBEhRGev4p3GAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=em1SHfYQCd1CBGQYlV1d6Cc9OB7+iYZBXPHKp8EDCO/OiVZ+dG+p0TPgx3E74qA9yvbtoWFFZ5AIr0H/ABfAdtzzfLF+igrRWkD/H9I3LxydkCUWqoI9o6bSCDoeEA00vCt5mQd5gGt9cngQBzLtPTvjdy+ptxDzT7yflIJJc14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pcSOkfBA; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idl8VNdY+n+M4j59VkpoxGus233aevNtJqxbrHs09r34Ik4JtQRtynpRruuu5knWUm4TOfClfko0sJe6aCcRfbTZla5FT1AFLBbFptEKjAfc27AmYbah2shVSR7RMaafgi6WtSiAF24bzDHBDOYs2XxDRyBwBRk+iTnGtliE+Fcxq8FWSFqUAr1lPXaNqTaOj3KJWuAFQaR7TS9oLOBM/KK26Dqr51XWRefFTUM6NsqgWUcipzBtcXn9dCq4Wms4ZmpYSrA96em9SF2aQHHcddPXdaXy9+M7ccbrXspiFJ0kzgxtW1pgcPwEmuFC184UlpGi6RkH3zWFjGu6mG7ysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKOVoiZlKR13Tn3fy65jnxa8LUb8kjFUg4/pvU9csUk=;
 b=GpWIMmZZZEwAhsZrwxtmKgaqndvOSjJNrw4MwFGe0WYWWn2xb5KGIryNNrMVVeas7e4Wx+xnnvlbJ+s4TcMb6xFRZ093y04VDjUmz/cvagWMl1Qze8LlyQ4dkaGLpZ5sAeN2GTq2GZZ57itV5TIeuBtVyWfXx6K7zpD10mzRIGgDG0L3NWdi8SQ3Hujv42gp2z1kEL3x2w9zhGuIWDslDMwLZSN9TC72TFxHUN6SYaKbmRRx67QDTSFjE+bG2iOJrgRNHmRbTLnUf+uPCrV5eSs1HojBgpqCDo8BE6/KMnqbKrgouHXvqvXjhZ2oBkqULPupmBrAoy5E/DE6WZtxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKOVoiZlKR13Tn3fy65jnxa8LUb8kjFUg4/pvU9csUk=;
 b=pcSOkfBAyvYGT9Zm08UhdB3vU0e+cNvA2A9nUovbiBU2dOpMzQ51l8difHP35RfmhZ8jqjy6txMHVkYOLUvfqb7LCDjcs4QkcCmG0iIY0YQ9nuG9ZBo9uFLoCrzebtjDyr2PdQO6ybZWKMx45IfsYZhDz9dujik5eWPdyFVkjREpaCC3oubWFZdVDms9Uso/B7pVVNMK0SOk/i8ILUMDYc1J9aZoRk1xOpEvGzBUgIqBZTkX1BY6DXCO5+tAwKJvmF1KX2hZPBDDdAmctVdk5ADdNTZBQVai85IYgF3ZfAIL+hZDT4/T8A+Q1+3It8nXOyhB0M/vL6Watyus6D+VjQ==
Received: from BL1PR13CA0363.namprd13.prod.outlook.com (2603:10b6:208:2c0::8)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:45 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::15) by BL1PR13CA0363.outlook.office365.com
 (2603:10b6:208:2c0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 17:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 17:04:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:32 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:32 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:31 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 03/12] virtio: Expose generic device capability operations
Date: Wed, 7 Jan 2026 11:04:13 -0600
Message-ID: <20260107170422.407591-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 8740a85d-e262-4d28-1bff-08de4e0edbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njzlZG3aANbaEwtPUs+pE+NPFjYETQoWMVhl4MCpDCnLyCwH05ggzEKfncvh?=
 =?us-ascii?Q?d+nsg53gPP04rXh3OMDPb/YNJKSnf4fulApFRqev4f9yUF/h/2zsqXm3IW51?=
 =?us-ascii?Q?hJ7DWXB7OgzbqFRnC0Micv1SJaR3Qb6UVaO3bhfYrVBGStvkbwM1s6bcFPyI?=
 =?us-ascii?Q?UzMymePCGA3ZzsitHYcdJd68TQWwz8ToY2DNwcTRncg8t+T6vTfZuYkh4GDE?=
 =?us-ascii?Q?esWz0+GioW4R52DALQycZrKtYyT4Hil894xDIDkdMS1BhheNtLVI10ok25rz?=
 =?us-ascii?Q?xij/8eEeVDC7Eg9KXascnYwMZftRo2zCoKXLT3ikzDQAw1XeMWn/tWVkilep?=
 =?us-ascii?Q?7veWMnh5TtzOGokBs7aa57khGApfhuxVuYSPpIJ0phfJzgj4pnjRi6t4kcB0?=
 =?us-ascii?Q?flphOFq1txbJCLc2f77gPQK7kS8HIW4iRKl2wfEPr2nY5ngeTrJkBMZsVwHh?=
 =?us-ascii?Q?Je13EvploLqc1snTZfYpNREBagdIgw3AOJ6m4QQCYW+MrSYAfz1svHh+CbDW?=
 =?us-ascii?Q?7GzGs7aXy/7nUcDgijLvCVmeUnf+q4cIW6kC/3U5tLXVtNUEqXAVOm1GPMfo?=
 =?us-ascii?Q?htANtK2GbRU0Su342bEWlLyQy48Qy4vLctIHLUW6y5kA1ux6dflo51eTr0IU?=
 =?us-ascii?Q?auPB/7a6MuIyB7lRlw4liNEDxd9RS9te1WFZ5mI+8Hjy5hf1JHVeWEAaX8Rh?=
 =?us-ascii?Q?Z0S6j2E0dUSbOZElSeU3D0pGzq1jHrZ0pstPtN1m/eYoEz94VZ4F6QFarmRn?=
 =?us-ascii?Q?oWzzwN4yM9tNC4EKg2dgzyYla5i2/yno9XPBMMGR+VKvKmTVgo+jiDKUFeIh?=
 =?us-ascii?Q?5jpyWt5XrqjAqhy/glrzlZyPRY663rrLSF5flijTqpR+uAeKr4HMVI3eqKXd?=
 =?us-ascii?Q?kIM2aTKxMfQce9l3HEnwsaNpwlhvGWYC6cqNnrf8E3hM1qCsQdWe2tCK2wV6?=
 =?us-ascii?Q?rg/+zyBIaf/5IzMUoSE5hcTx4JYvsWOmj8Wa+tGH7iM/9jiRNB4Zhn+AAVnX?=
 =?us-ascii?Q?Adklbok0EODjq8cOrttlu3uK7QqGtmJXq57r0yqnt8EsHOVVZf5eNAWLOUYQ?=
 =?us-ascii?Q?lVCguOdLPDaNsWfwCCZEI4gG7zOl7caMqID1gU+4pEg8H1ggTJ5YXxloBnO2?=
 =?us-ascii?Q?2ZVNdkqbjXW+CxhaSOg9gTtZLxmdiOJK9DNy0Rr/gG0RrhlILIJspRW9qXXq?=
 =?us-ascii?Q?5EUbWDAtEBF8hDd0KG8aU5K8MOHpigHYLz30284e2Gplc1v8gWLbMgd3S3ox?=
 =?us-ascii?Q?hMY/7Ez05Dz22/l3lJNsQkBEyd6iG/PkOpGKeONwz+601LjzIEv4lgVzLOy1?=
 =?us-ascii?Q?oVbhDHeHR2/47D9/NnrcwA2nnEsLlasL6hAyV4x9UDZPkESas/62jKVFC/m6?=
 =?us-ascii?Q?sGJCvygqxzFQ4DjfDwBUaydleohhpoxkfsJV/WhmtT2yIns39dWmuEvfenQm?=
 =?us-ascii?Q?pfucl0HA1QdiaQJZhhWeH0sM+xmmP9PhLhw2RuCjTYBqwrumGx6FqZETsiSU?=
 =?us-ascii?Q?FWMn7MvvICrWUuKgC7LUe5PM/CP0L1cn4TEnnoK0z3a21TbkCilxwfobk9lb?=
 =?us-ascii?Q?GImOzgGbczS3JISDh5I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:45.2624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8740a85d-e262-4d28-1bff-08de4e0edbaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812

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
index e732e3456e27..96d097d3757e 100644
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


