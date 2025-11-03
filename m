Return-Path: <netdev+bounces-235251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33340C2E568
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3CF04E9EA0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4C2FD7D8;
	Mon,  3 Nov 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gsh46cqM"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9C2FC861
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210565; cv=fail; b=oIye/aY1muSiz1Qo/9Mak/05Phme4uF9XNXrWFUGhT9mNPH+qfQ8WsonVaXQG6P9+yE2gh54zyCVtNxWw2B565So80okR+vWLT+vfDLMw9F/Eebqq2vyG0Te1kgTeyjIMVE/U84FDkpl2YlznAVcy0lnEkhU01j3bB9JFXFzjGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210565; c=relaxed/simple;
	bh=my5y7671+wa017oQQk0PKNYiFe3i47pGPwm0th9mm6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvvydxCpwE+5JGorpzmeNfZT8A4VynSnnYidaJ8e/Z+/WNNRj9VyB4+/cFc+2PsFV/yom+TlCOWcy4Y7vR3EB7EraUlH98zrFAm3+jUn2NJX8MZ2yi5QWJWPqpEMalB34ndwTUUesxSYv4CxzbOGrcq3Uf5avikT/8a/AG75dC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gsh46cqM; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN+wv5vKcK4sSoBK0VnZDZBWmWpPUcVrM+FhbWXJr0ADA6ZoBFDIOk6kT/A64bSNlEWJN93Hfq6mPc9+NuaTpmHiZHu9uvVqv5gwVILeNnitnp+vkC0lHu1yhI3JLxA5y0YV2kfiqS0v/xUFwYEulnj2UifL1eSVsvvEPsI9qKEVAJjlwsCG7gnd4cJPmAbTG+CINteRpU6btHzd1VnWO40XkCvjwVbpK3P+9LjrLIiFXKpvle4v4TqnmQ14bq4e24Lg5RUHC9zGjbEeweJrGO2aIss1jDK5f9kmq8nMUcKu4pEJmzdu3yMIxtspiQum/fMCS70QKgbAe6XZn3XMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=yQzPlhQb+XSIozxMw8bApIWC7/EFHNuHTPr6AJ/v6Xwx1jKdx8m5QUJ6vWeLMPtu1CYOLsOkonAKNq9cPcIikcOG+B2xrONYQN5nnP8q4DHjea9FxWGM1sljW7k6U+Q4Z40oMrWFMteymcZzcGK5M7grjfk1ZeHDTV08GUyJX6VBKmEyh4HovFDY9J4wvpe6aUcrm40c2o4f2/WyqkXB3fOFtUp8ozVqrKGmuUAiDJClAiDbqH6xBNfskIpnvbgMPyaxW4LQRJLkjONgEkbIB4GJGM2NN4qdbS2o4J9ltB9kNVybrRoVpyNxfpbxOVHeXch2DX85puZqfARFboOonQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERVWg+w43aFnl0MVQfVF+90w10EkUa1p9WkzSmEsfmk=;
 b=Gsh46cqMCR0IqkV31sS37VpeXVZ4r+IdBgdAHwgqN2jVz7Kl8drwvkcI8cGhBPWLiROkNvZIfQ2wkpiePQ++yrMqEpUPFwrbrNxN/4K+nyDrKqfD3rKIZ1uE5IQpcteYEiZbo6qq1EHuWMZaOG3aQ3tApV/Zy4lN5U4dryxokb1fgrOUQm3SFMzvhKN4dbmuI+J2dhnPi4syzCyJlN9YxdjuYa4cmUxOkTjb3rFAX8OCY2uB2wEbN3WOAoHyOUgpv21mqYvkPNUgAQpp7xV8cnHpkSSftPigGurJx++vEdyikXtUjg2AYfpHVCg9V4ZZbeCllG5lRESdVMC2GQebEQ==
Received: from SN1PR12CA0046.namprd12.prod.outlook.com (2603:10b6:802:20::17)
 by PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:55:58 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::ce) by SN1PR12CA0046.outlook.office365.com
 (2603:10b6:802:20::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:55:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:38 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:38 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:36 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 03/12] virtio: Expose generic device capability operations
Date: Mon, 3 Nov 2025 16:55:05 -0600
Message-ID: <20251103225514.2185-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|PH7PR12MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: 720986dc-b1c0-4f6d-4935-08de1b2c26d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RNk+KA3psT/0EKXWPmttfZVQT0h7QC8NgmRj817TAeeJJ8wgy+ATgHv8N34w?=
 =?us-ascii?Q?R18S/+OT8JX+WCVKVKGRjwWpILRUvY6KmYXX1ZNYGPA7M83UpfxutVTv/JcS?=
 =?us-ascii?Q?pkitFdXx7fzSQFuWY7Bz7OtdNwMfMRxPfSVC8iA4wGPv/Tpjcn7JtI8wI1kv?=
 =?us-ascii?Q?viEcuHazkeBYM+6oTSFs8+z6ZEK4Vy2+AvtjrRy1HFTwJ6qsqJ5+473Dn6Pz?=
 =?us-ascii?Q?BR5vQfmjGBewf6MZrf52WVXJKxcnh7R1njO+soPtA1ZcYdRd2II6NamosxGU?=
 =?us-ascii?Q?MyYRg3AqJOEvTQQ6Jcs8zmkXPUX5BBEZ1tH6ipl0HeDws4PeCC7lYmtqRoh+?=
 =?us-ascii?Q?HHajkO8TqCg4DtZ7Zi0BbshHByiin+bzQEUYrAr6MZF+KY47cuR2zxde5/5j?=
 =?us-ascii?Q?BQKddWId/NXiwvOz9ORGzjDHbPTJ5JcPBT5AyiGn89pzRGOlDS/qm3duamgT?=
 =?us-ascii?Q?tIaSiE5gpAIIL7lkKhuXwfXmzcEjp1vzgoKuLUJdScbCKExttTXq4/SPyzv+?=
 =?us-ascii?Q?37biuGcsWGr6bRTcCSC4j+LnsB36yNrbyrP2h2+kWT+qhDunCtX6AXw8UjOi?=
 =?us-ascii?Q?p6pu3oNePmOkhr7v4+KnIlNDRRCpVdUJ5tWYEMqWyn6jDY5DqbyljTEpTej3?=
 =?us-ascii?Q?ImzowRXijmCDCqF60Ba8iAbkv+FMZu98vA4qwAegP+vbLT2TK68MfaGW5WvD?=
 =?us-ascii?Q?1ZmqoyvP31AsSBeLsa+QAzNnApa59SY5F+b1SywXfHgJ+s/j9DwQpve803Hw?=
 =?us-ascii?Q?Hzq4YQpiivX/Gc8NMshM6/GhnZSmVNtCPV7+hdZRMkLhTMUv/k+0ou+b+fh3?=
 =?us-ascii?Q?HDNmeRWB1WHJpeCR3Bd2Z2L1L54umDfWi/KVJui+i8ZVRMOZKdT1BxTVGsKB?=
 =?us-ascii?Q?+oImJUwKGDvVkfSZbjDaT5sQTukbu4d7xda2iwmUwQD6j0+Xwq0Vax3BF/pW?=
 =?us-ascii?Q?4H0cRJJZKUbCComnCaRuofI7okD6/14SMaR+8q8vOabm8urERCRmC/Jy3b7E?=
 =?us-ascii?Q?Bmu2L4y1RjDITddaEz7ENeuuIO27MFK6aEUmyjNjy/z9TqSCtmmCWG7B40US?=
 =?us-ascii?Q?TGzXaEjMMe2+CdASkwj3rOtZZV5tlh8Drtbl6BgSDehQMYq3rrBAnJZkNrdj?=
 =?us-ascii?Q?XRZFXTlmRNax2AXNW3IOKlenrNVIwsp4+FLueyBp4KoG03+szZzin+vMtFG7?=
 =?us-ascii?Q?qt3P5XAvyvjTXgcTD/DRE8kFLte/V124B0l0P95hMoCDAlRDtBraY5zLTfoV?=
 =?us-ascii?Q?8ZGvlEq/WFIE+u78uhmb0HgXs+4j5knQbGevQdHojt3L0pkHquutHwcGWPKt?=
 =?us-ascii?Q?lUyRmY9pxX7ChE3F73D7uLOKrI1MDAOtraAGBUy91KyjP2v45Uyv0yYd/aNA?=
 =?us-ascii?Q?9ZzenUXFsWXpZe+uTGTKgfirZLjNOkGtgowfE3lzsdjOg42JqeZLT28HSmor?=
 =?us-ascii?Q?U+8ZyBTpYFmCaul4FH549vTM0Kh1nUURfSmDkf97fnJu3RgtHTaCn/REc7x8?=
 =?us-ascii?Q?MXyEdW2fP92eWb/PJsVu4HHhxkr48KUguPxlqwxuN34K0N2mhIdRXc3Pt1p8?=
 =?us-ascii?Q?eDvGg5ZQbK73of3XMgc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:55:57.5892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 720986dc-b1c0-4f6d-4935-08de1b2c26d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9173

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


