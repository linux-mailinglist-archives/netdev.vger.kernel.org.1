Return-Path: <netdev+bounces-225634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E7DB962F8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0CE2E3C62
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8872417D9;
	Tue, 23 Sep 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RG0e9fml"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DE155A4E
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637196; cv=fail; b=BGAVKjdLvqf2ED3NNbbIpPo0XAu1SRXfGwmBJtRDOZBMnpEgG7xhp9b3rQCx6vfzdW3G88wUES+OSu8wkG0eP2PQjvHvlWtde3uM4WuJ/1+4HJ7URU46cUdt0DwL9lGkllqWsTgM+RBYFMl8MRR4xTXyGcIHrNiPABPcIDR3sBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637196; c=relaxed/simple;
	bh=t+S0HHRrphmfbzgpSOTKSUiMMY/WN1QUhAK6ghqgOf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPSRv7VLqcyUq18TU9LFIvk7zLdsW3bne5/LPm0kHP83dVTkH/gzLeRFpyQD4EQTkPu/3x4dWGPeLmrgo4opWwCAAnLr7TCQ9QACVuu75T2YEbjJXnYpMhp12/Bu5LQS8almPFg5FMgfTRFPyUI4YoUvAJUZcfbErJ1cIkeOU2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RG0e9fml; arc=fail smtp.client-ip=52.101.85.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdbL8B3zOZERhbjpeS4P+u49EU9Cb1/Am2QK5rc7wEUhUVQZeeAvBoSonKLKTS1ZsTgJSvnw7Q1nXQWY17+G2WH8pCmnpwRXmh0603t4n17J7jt/4TLwYDuoN6qSrcmFKN4fy7wRICQEbwWPXcRN/SckSrDs3kn7ibW64qgHRw6dnU4J755stCVNa37mHcRE3ruUrMDUm6yi+lVryPT+O1TIY1a5JdnrVQWRwcOgFONEtfveYO9rqNwB8+c4sZ2IrTbgbDxu901uyP4HAUpd0yIMEQlg7Oagc1iQk8Pb2j0S90okoItr3K83JcUAkVYbrxYHMan6N70XZ2dhkvRk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtNJCfWKLglmiAB+CIy13EqyBhhKOVRnBt4QVctHVr0=;
 b=Xtal3YXiY9jDuoBTZz//B2JLrWHF5+xETP1h/Rq8X3GQ7DnEMkvAXpX9DdYAsQnAuWPyRbjsbAtPQi8gqN2ldKNI0U8lYus05JLGFk2aDixPclT9qpiBDTPPEmqIeGp39aUMzrvLhfHDI2m2xOCfmsPWeC8XCMt6BFHq0eK5C60zjC+Of4yYhexCEENMB0czRgRpl9TMMVKJR8hXVOMExu2vVvzwIaBPpfGa2uRq4zyXXytHn4ySVb18ZqZCZQVuOGUHOPw9UpZyLNmsp2j94WyWg1HO4ZliZXkKIznjcTTmq8s+YbL0mRocKtSTSfBUhQCHZ3w6QtHNl9ZwQbxeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtNJCfWKLglmiAB+CIy13EqyBhhKOVRnBt4QVctHVr0=;
 b=RG0e9fmlVmyj4daPDxen2w3f/oGem/fbxkMxeK3t+w0cHfuaSrjV0xmS1BBDo6MSHL5mBk2CxYQQ1aWq3qLoNO2PC7CbHMToOPzNTTpIU1axJew1eySAnXAUZTUOe1vEF5jM1MNC3mNF5/sXQbUlnjb6skTJZuJFhi+5B2YeEtPT9ZjZMHJeRlk9ad1Ur9h/Fz2R+mO/vHemH/0qbDoetFnhB7HSM5lBo+em8Gqt+d/GtMRYM0GwN5GVpIt1sLfexjbdkZ6Yy70Ti/XZwrz3ih8Fo6IRljXknFISXgkAHd3RSfMmElL7UqwldRd4T48aeXw5iKwXvU765/Ju4RIvkg==
Received: from SJ0PR05CA0147.namprd05.prod.outlook.com (2603:10b6:a03:33d::32)
 by SA1PR12MB8842.namprd12.prod.outlook.com (2603:10b6:806:378::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:19:47 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::57) by SJ0PR05CA0147.outlook.office365.com
 (2603:10b6:a03:33d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Tue,
 23 Sep 2025 14:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:19:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:32 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:30 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH net-next v3 01/11] virtio-pci: Expose generic device capability operations
Date: Tue, 23 Sep 2025 09:19:10 -0500
Message-ID: <20250923141920.283862-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB8842:EE_
X-MS-Office365-Filtering-Correlation-Id: a77a3c3a-c9e2-4f5e-421c-08ddfaac402d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?10nN1N7nqBI9OCbpg862RQl87abc5fRK1uqZmd0nutYm9wuSnsls+ZDHP9s8?=
 =?us-ascii?Q?JcuZaQKXb/zEYzA6DigG5H4XUUF80U5AovI6Cggpyo5xAKT4tLvB29IKa2Gt?=
 =?us-ascii?Q?mXuhwVaG9p697rxB+oONrWSfEj3O516RtoZHzOSmIlx4ghxzmRmQlNc42aQy?=
 =?us-ascii?Q?JDUQLcVgYseEl4lTXdKqkBGaboYT0p4F+MfNOQJpEIicFHpWW2ZvAjcvYR31?=
 =?us-ascii?Q?iCsWvaKIUQlJx7ctNvyJ5yrYlsSIWuWrg7nxYwMPLeQQs1Dn/r7BveUaDJGA?=
 =?us-ascii?Q?Ts9vyyVxkzuTxX/XmKftzfpBvuXN8W1tNYLYpjlcwvHyX5+TdEurhDct35jE?=
 =?us-ascii?Q?MRUpRr5pveKkaXhNgAbGYO+wCRsP+4ScE1IZDyZnQQl2YsS1hkQDGnQBmPQo?=
 =?us-ascii?Q?dxW8iuOzUe+ijRd9Ff2DkA13mvcZhpdtU+BLpiiaiYkFz9WI227i5AReoFll?=
 =?us-ascii?Q?vJOvsYAHPUZOl16Fjcu0ksuGvjNU2rMITOh616EDgGqHIvKL8s142ompmUS+?=
 =?us-ascii?Q?hYgGyIOiGFyMakyI66Zu49rDGmI2arej5e2XI/B0TsXlTLJC6/P6iJpe7w/t?=
 =?us-ascii?Q?1qt4ecl/YwX3I9DZAryoOFPgtqqFDNSy+ZYAwSRvWP5i+MezMyZZpY2cqoAF?=
 =?us-ascii?Q?5LfeiuRhy5+7N2l++kitcQVoSfW3h58wVRxbN0scrvH9lgvffrOffh9X2aup?=
 =?us-ascii?Q?rkVHYx50QEZAYmtXEMl7x0Mdl3fij9URx8X4k0gUN/YV86omdU5Oo/HxcD2X?=
 =?us-ascii?Q?9ZxYtCfj23LKBOkwNXlbYxnKOqslK2szsdx05eCf6UjFpQdei+wvj8h71VY0?=
 =?us-ascii?Q?68979lZcz/0YZjUKDLD64GNhItJHI3FshwX5fx+S9cF3oLLqgI10LDUgAyqm?=
 =?us-ascii?Q?3tR8y2uEZz64eBjpXEtLKnbaWdC+QPgnZtEQsN7pPDpFXuRkIIWFJGOaTjtc?=
 =?us-ascii?Q?W+0Otp6SHpQpnU3J5Sn0F/z97hn90jd7KKX0n7OmCLfyX8EVVzWq1vfOJkmu?=
 =?us-ascii?Q?GW7Tjc/dxcGP1THhL2PDodFA/kikNanwIkwx6JyteFSMzV1pnDzhwNdf1f1M?=
 =?us-ascii?Q?mck7mjAzwzymu4YkP1lJvTXzz5h6xBuntnXZTgcu16mNo/YfFdqqrDFSej8w?=
 =?us-ascii?Q?fk/BQf3iom0k/OQ7I70frENK+xFzprN2jVUYySm+WKq6F8lCYAoFY1G74O5e?=
 =?us-ascii?Q?DrSozhGOGBSC4yAySSurgpUiBb54RuAgjQp+XjHBNu23dUBttTtdCU9lQNij?=
 =?us-ascii?Q?S9b7i2V3ctkNR7thZoWSQR5jPLxRya27zY93n8E81tzUW6QUTbV04perevGl?=
 =?us-ascii?Q?CB9Gf6azEsAFs3QP4ANlqn79WZAT0gCKWlmbCg596TA8G2YUe2vTfT7rXgt8?=
 =?us-ascii?Q?R58F9GVl5X42879LwpxucTdEBBNGn7N+ECxnNwFAORQj7ekcLPjny9B+byFK?=
 =?us-ascii?Q?avC4g0OdSIYFTVrAJTLZgmY7QU8uweKlxOycymkIzlF4JKa0Yrra3q+LW079?=
 =?us-ascii?Q?VnUKpzMxUY/8qrK3k/4Pzr1AtED59aYzwIsV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:19:47.4208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77a3c3a-c9e2-4f5e-421c-08ddfaac402d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8842

Currently querying and setting capabilities is restricted to a single
capability and contained within the virtio PCI driver. However, each
device type has generic and device specific capabilities, that may be
queried and set. In subsequent patches virtio_net will query and set
flow filter capabilities.

Move the admin related definitions to a new header file. It needs to be
abstracted away from the PCI specifics to be used by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
---
 drivers/virtio/virtio.c            |  82 ++++++++++++++++
 drivers/virtio/virtio_pci_common.h |   1 -
 drivers/virtio/virtio_pci_modern.c | 145 +++++++++++++++++------------
 include/linux/virtio.h             |  14 +++
 include/linux/virtio_admin.h       |  68 ++++++++++++++
 include/uapi/linux/virtio_pci.h    |   7 +-
 6 files changed, 255 insertions(+), 62 deletions(-)
 create mode 100644 include/linux/virtio_admin.h

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a09eb4d62f82..6bc268c11100 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -706,6 +706,88 @@ int virtio_device_reset_done(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_device_reset_done);
 
+/**
+ * virtio_device_cap_id_list_query - Query the list of available capability IDs
+ * @vdev: the virtio device
+ * @data: pointer to store the capability ID list result
+ *
+ * This function queries the virtio device for the list of available capability
+ * IDs that can be used with virtio_device_cap_get() and virtio_device_cap_set().
+ * The result is stored in the provided data structure.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability queries, or a negative error code on other failures.
+ */
+int
+virtio_device_cap_id_list_query(struct virtio_device *vdev,
+				struct virtio_admin_cmd_query_cap_id_result *data)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_id_list_query)
+		return -EOPNOTSUPP;
+
+	return admin->cap_id_list_query(vdev, data);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_id_list_query);
+
+/**
+ * virtio_device_cap_get - Get a capability from a virtio device
+ * @vdev: the virtio device
+ * @id: capability ID to retrieve
+ * @caps: buffer to store the capability data
+ * @cap_size: size of the capability buffer in bytes
+ *
+ * This function retrieves a specific capability from the virtio device.
+ * The capability data is stored in the provided buffer. The caller must
+ * ensure the buffer is large enough to hold the capability data.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability retrieval, or a negative error code on other failures.
+ */
+int virtio_device_cap_get(struct virtio_device *vdev,
+			  u16 id,
+			  void *caps,
+			  size_t cap_size)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_get)
+		return -EOPNOTSUPP;
+
+	return admin->cap_get(vdev, id, caps, cap_size);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_get);
+
+/**
+ * virtio_device_cap_set - Set a capability on a virtio device
+ * @vdev: the virtio device
+ * @id: capability ID to set
+ * @caps: buffer containing the capability data to set
+ * @cap_size: size of the capability data in bytes
+ *
+ * This function sets a specific capability on the virtio device.
+ * The capability data is read from the provided buffer and applied
+ * to the device. The device may validate the capability data before
+ * applying it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or capability setting, or a negative error code on other failures.
+ */
+int virtio_device_cap_set(struct virtio_device *vdev,
+			  u16 id,
+			  const void *caps,
+			  size_t cap_size)
+{
+	const struct virtio_admin_ops *admin = vdev->admin_ops;
+
+	if (!admin || !admin->cap_set)
+		return -EOPNOTSUPP;
+
+	return admin->cap_set(vdev, id, caps, cap_size);
+}
+EXPORT_SYMBOL_GPL(virtio_device_cap_set);
+
 static int virtio_init(void)
 {
 	BUILD_BUG_ON(offsetof(struct virtio_device, features) !=
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..c8bbd807371d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -19,6 +19,7 @@
 #define VIRTIO_PCI_NO_LEGACY
 #define VIRTIO_RING_NO_LEGACY
 #include "virtio_pci_common.h"
+#include <linux/virtio_admin.h>
 
 #define VIRTIO_AVQ_SGS_MAX	4
 
@@ -232,103 +233,123 @@ static void virtio_pci_admin_cmd_list_init(struct virtio_device *virtio_dev)
 	kfree(data);
 }
 
-static void
-virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
+static int vp_modern_admin_cmd_cap_get(struct virtio_device *virtio_dev,
+				       u16 id,
+				       void *caps,
+				       size_t cap_size)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
-	struct virtio_admin_cmd_cap_get_data *get_data;
-	struct virtio_admin_cmd_cap_set_data *set_data;
-	struct virtio_dev_parts_cap *result;
+	struct virtio_admin_cmd_cap_get_data *data __free(kfree) = NULL;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
 	struct scatterlist data_sg;
-	u8 resource_objects_limit;
-	u16 set_data_size;
-	int ret;
 
-	get_data = kzalloc(sizeof(*get_data), GFP_KERNEL);
-	if (!get_data)
-		return;
-
-	result = kzalloc(sizeof(*result), GFP_KERNEL);
-	if (!result)
-		goto end;
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
-	get_data->id = cpu_to_le16(VIRTIO_DEV_PARTS_CAP);
-	sg_init_one(&data_sg, get_data, sizeof(*get_data));
-	sg_init_one(&result_sg, result, sizeof(*result));
+	data->id = cpu_to_le16(id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	sg_init_one(&result_sg, caps, cap_size);
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DEVICE_CAP_GET);
 	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.data_sg = &data_sg;
 	cmd.result_sg = &result_sg;
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
-	if (ret)
-		goto err_get;
 
-	set_data_size = sizeof(*set_data) + sizeof(*result);
-	set_data = kzalloc(set_data_size, GFP_KERNEL);
-	if (!set_data)
-		goto err_get;
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
 
-	set_data->id = cpu_to_le16(VIRTIO_DEV_PARTS_CAP);
+static int vp_modern_admin_cmd_cap_set(struct virtio_device *virtio_dev,
+				       u16 id,
+				       const void *caps,
+				       size_t cap_size)
+{
+	struct virtio_admin_cmd_cap_set_data *data  __free(kfree) = NULL;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	size_t data_size;
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
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
+
+static void
+virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
+	struct virtio_dev_parts_cap *dev_parts;
+	u8 resource_objects_limit;
+	int ret;
+
+	dev_parts = kzalloc(sizeof(*dev_parts), GFP_KERNEL);
+	if (!dev_parts)
+		return;
+
+	ret = vp_modern_admin_cmd_cap_get(virtio_dev, VIRTIO_DEV_PARTS_CAP,
+					  dev_parts, sizeof(*dev_parts));
+	if (ret)
+		goto err;
 
 	/* Set the limit to the minimum value between the GET and SET values
 	 * supported by the device. Since the obj_id for VIRTIO_DEV_PARTS_CAP
 	 * is a globally unique value per PF, there is no possibility of
 	 * overlap between GET and SET operations.
 	 */
-	resource_objects_limit = min(result->get_parts_resource_objects_limit,
-				     result->set_parts_resource_objects_limit);
-	result->get_parts_resource_objects_limit = resource_objects_limit;
-	result->set_parts_resource_objects_limit = resource_objects_limit;
-	memcpy(set_data->cap_specific_data, result, sizeof(*result));
-	sg_init_one(&data_sg, set_data, set_data_size);
-	cmd.data_sg = &data_sg;
-	cmd.result_sg = NULL;
-	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_DRIVER_CAP_SET);
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+	resource_objects_limit = min(dev_parts->get_parts_resource_objects_limit,
+				     dev_parts->set_parts_resource_objects_limit);
+	dev_parts->get_parts_resource_objects_limit = resource_objects_limit;
+	dev_parts->set_parts_resource_objects_limit = resource_objects_limit;
+
+	ret = vp_modern_admin_cmd_cap_set(virtio_dev, VIRTIO_DEV_PARTS_CAP,
+					  dev_parts, sizeof(*dev_parts));
 	if (ret)
-		goto err_set;
+		goto err;
 
 	/* Allocate IDR to manage the dev caps objects */
 	ida_init(&vp_dev->admin_vq.dev_parts_ida);
 	vp_dev->admin_vq.max_dev_parts_objects = resource_objects_limit;
 
-err_set:
-	kfree(set_data);
-err_get:
-	kfree(result);
-end:
-	kfree(get_data);
+err:
+	kfree(dev_parts);
 }
 
-static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
+static int vp_modern_admin_cap_id_list_query(struct virtio_device *virtio_dev,
+					     struct virtio_admin_cmd_query_cap_id_result *data)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
-	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
-	int ret;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return;
 
 	sg_init_one(&result_sg, data, sizeof(*data));
 	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_CAP_ID_LIST_QUERY);
 	cmd.group_type = cpu_to_le16(VIRTIO_ADMIN_GROUP_TYPE_SELF);
 	cmd.result_sg = &result_sg;
 
-	ret = vp_modern_admin_cmd_exec(virtio_dev, &cmd);
-	if (ret)
-		goto end;
+	return vp_modern_admin_cmd_exec(virtio_dev, &cmd);
+}
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
+static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
+{
+	struct virtio_admin_cmd_query_cap_id_result *data;
 
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
+
+	if (vp_modern_admin_cap_id_list_query(virtio_dev, data))
+		goto end;
 
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(VIRTIO_CAP_IN_LIST(data, VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
@@ -1264,6 +1285,11 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
 };
 
+static const struct virtio_admin_ops virtio_pci_admin_ops = {
+	.cap_id_list_query = vp_modern_admin_cap_id_list_query,
+	.cap_get = vp_modern_admin_cmd_cap_get,
+	.cap_set = vp_modern_admin_cmd_cap_set,
+};
 /* the PCI probing function */
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 {
@@ -1282,6 +1308,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	else
 		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
 
+	vp_dev->vdev.admin_ops = &virtio_pci_admin_ops;
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index db31fc6f4f1f..7ab4ea75ad44 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/completion.h>
 #include <linux/virtio_features.h>
+#include <linux/virtio_admin.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -141,6 +142,7 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @admin_ops: administration operations for this device.
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
@@ -161,6 +163,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
+	const struct virtio_admin_ops *admin_ops;
 	struct list_head vqs;
 	VIRTIO_DECLARE_FEATURES(features);
 	void *priv;
@@ -195,6 +198,17 @@ int virtio_device_restore(struct virtio_device *dev);
 void virtio_reset_device(struct virtio_device *dev);
 int virtio_device_reset_prepare(struct virtio_device *dev);
 int virtio_device_reset_done(struct virtio_device *dev);
+int
+virtio_device_cap_id_list_query(struct virtio_device *vdev,
+				struct virtio_admin_cmd_query_cap_id_result *data);
+int virtio_device_cap_get(struct virtio_device *vdev,
+			  u16 id,
+			  void *caps,
+			  size_t cap_size);
+int virtio_device_cap_set(struct virtio_device *vdev,
+			  u16 id,
+			  const void *caps,
+			  size_t cap_size);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
new file mode 100644
index 000000000000..bbf543d20be4
--- /dev/null
+++ b/include/linux/virtio_admin.h
@@ -0,0 +1,68 @@
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
+ * struct virtio_admin_ops - Operations for virtio admin functionality
+ *
+ * This structure contains function pointers for performing administrative
+ * operations on virtio devices. All data and caps pointers must be allocated
+ * on the heap by the caller.
+ */
+struct virtio_admin_ops {
+	/**
+	 * @cap_id_list_query: Query the list of supported capability IDs
+	 * @vdev: The virtio device to query
+	 * @data: Pointer to result structure (must be heap allocated)
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_id_list_query)(struct virtio_device *vdev,
+				 struct virtio_admin_cmd_query_cap_id_result *data);
+	/**
+	 * @cap_get: Get capability data for a specific capability ID
+	 * @vdev: The virtio device
+	 * @id: Capability ID to retrieve
+	 * @caps: Pointer to capability data structure (must be heap allocated)
+	 * @cap_size: Size of the capability data structure
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_get)(struct virtio_device *vdev,
+		       u16 id,
+		       void *caps,
+		       size_t cap_size);
+	/**
+	 * @cap_set: Set capability data for a specific capability ID
+	 * @vdev: The virtio device
+	 * @id: Capability ID to set
+	 * @caps: Pointer to capability data structure (must be heap allocated)
+	 * @cap_size: Size of the capability data structure
+	 * Return: 0 on success, negative error code on failure
+	 */
+	int (*cap_set)(struct virtio_device *vdev,
+		       u16 id,
+		       const void *caps,
+		       size_t cap_size);
+};
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
2.45.0


