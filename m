Return-Path: <netdev+bounces-233270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F32C0FB77
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFA534641CD
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFE3191C4;
	Mon, 27 Oct 2025 17:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cItNOF01"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012041.outbound.protection.outlook.com [40.93.195.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E50131691B
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586844; cv=fail; b=mBrpDuiYffsoMR80pFtJnkGLaxSigXfAwpaQEKXVF9XVIhqSeQ8f6bVU8Me4eQkQFwb2k0cEDJYa1SL7efrppePd9COTTR7mVkChTeEw5ZLMG1bPBWFTVQId1FusqzdZpmJdsIaoqUji3cDK3HSezbUGVnox6YGCZs9FI+JaroQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586844; c=relaxed/simple;
	bh=wfnB8j7gZfnXUg54cpZQ0mCIVkDPACpJ2aDKdUqX1yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EU76KbsRwKnNISGfX6ZbRstZq8Iswvfd/7RFPjZzdv1TAwRBczV7gfeKofZSEZPdm5hB9FdOGk7zwz0KwlRuZpXjDnETaAIWh2dQ6JqfAWYJqIQRMUc5LHsnXLFJuvo8q+RQtJ1skQLx6Oe6D+i00o19zWakl6qsmfNYoPY9zXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cItNOF01; arc=fail smtp.client-ip=40.93.195.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDb0Hh8Yvstf8QLfmc/opM4zRuc8KiyPic8oY+ipx2S3eFRQ0c5Fk5EM5zXIh+cCaDCwpMhUp0CoYXigPqIDXEPgRjJ6jfKdy+1mE/Z3B5xV5IYfhDv4m8769vava/o6NDb0L0If0l0qUI/E8RxNG5YHiK8WxvvgR5uEZ2G5g5mrwYlEoMIvUXhgHS5XVw6zrFipqqQWBWFre6lMeZIe3v03heizz5pYmw6KMazZdzxXPmNqTeGe1gdRzQZ3AmSglXrmcQ8UR3IZfmE8J0wIXj/jiELJ9DNu3NGsmz6Z972GrLro11ikg2ARoKrwJk7bDub1Zu24F431q+1Ei0S4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XQr7cr3ejVCj2QIotWBrSOlGSo4AhgShMN7J4kqAaY=;
 b=kZwtEy4GLm+85a2KGkV59aIIusdRawghQTAPT5AhnWiULxO5IjHpkVuWEqNa8s8l8PV6WJ03nr1NSN8WPA8mKxjIpoostd9TuRjBNf6DRvNUjTwLLSm32R83O2OpiAv5NXap2TqhAETtn764xYixXxq46oXV5bQe96RQTcUapiz3LrNhsq63RlHzB/l+h9Vj3aQB0KQ3wcJVFQYnuPEtI+IH38+da4qRW8cxPhmDpSpuEgI+RcWVNmNcJGH2/TqaOlxU7DeHIs/J4j7sCBiVy4tlebDKwJCn7tbT09Wg+ddBHjPPU4y91Gkl4OLcMAjf2OdLDb8AD4h5J6ZIuVATog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XQr7cr3ejVCj2QIotWBrSOlGSo4AhgShMN7J4kqAaY=;
 b=cItNOF01mVcgj6tfMJCp92c3M+fRiqGfzeSzmlotdRaxaEwfxo7/o7OPFuMpwhTVJIDLkdVLS4qqqZFLITF8qs74FA3IyAPp2rsLLM1SZETyiSxbn09AFMIpdym4W9BvMuUrSJG0t7XOViaeF+onB8+1CmzaHBb6lhcFZS2Aua/enEXq4/b4JR29Ks828b0G/La5WyA+A2m2kr0gzgXf7MTqFHD6OENudebK2ilLC7yKBlHLSSJ0Zlvu6YiKtcTt7sXrw0Sxo/gi20iHm2DI+vCW5cR+SgPoIU96khBzOyrQSNLD2yF4fjemN9IbRJnta79+1VAkJJ29tiSK6NZouQ==
Received: from CH0P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::26)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:37 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::76) by CH0P220CA0019.outlook.office365.com
 (2603:10b6:610:ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:14 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:14 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:11 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 04/12] virtio: Expose object create and destroy API
Date: Mon, 27 Oct 2025 12:39:49 -0500
Message-ID: <20251027173957.2334-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 560e764a-8c64-43a6-1b98-08de157ff092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TUbBRTaDNczgu/6hZUga0U7F8CHZesE0Z7wNMCJ0AhmVF23AsobIODc6OxEz?=
 =?us-ascii?Q?HjTNnIJcZkicGutcb94fg6dpdvidDlXyP587RLlcmp8T/uFLVcWH/iqPSWO6?=
 =?us-ascii?Q?VgHE/NRmLku3DihOHgPumHTCMRfM3/4i7qcbqK/fKCExHRBfpDI+QRE76z3K?=
 =?us-ascii?Q?KowTRzuOo4Go8SDB0MWNYELHk3Kt+KRJSXUjAJi0u9UTkQA1zZ4WbL2T0W3r?=
 =?us-ascii?Q?cU7dp6biiQNZbc88Ud5rlyXHWcTmaaNnaCxV0kcotYhianR1pR49ApetOXs5?=
 =?us-ascii?Q?GyZ4UdyGddoj9+oFchfTA4fABrSI1+/+bhQIC4YZWdE/2USWw8wwWgmcjhYz?=
 =?us-ascii?Q?HT3kHCoMeDv5SzcT0pozqfBQosJZ25ARubMPRSCgEQr29U+l2tF0pmO2U8+A?=
 =?us-ascii?Q?RGVLrnJiZlUwUJQvi9+QHizbqhtqDpexjdVbcQl1k6WiRf2WfvtoDqPBnVUp?=
 =?us-ascii?Q?HypABFlLTPzpLV3isUlBOimIl+3wr9OYYg9T1HgjcSURFGBpguKl/4PNj0Oa?=
 =?us-ascii?Q?Q2Gzi2VSdn9dSR8NWKe6jaI4rTeCJ4nUKP/BKE13LHJ5nBJU32jAgOQm+Pe1?=
 =?us-ascii?Q?rzL6xS9KlZ1wuwhzpiE4zetN/PMS7KAo1Q5pNVy7Fr9bab4Rtk+VMZrGkuMm?=
 =?us-ascii?Q?aV5ltYYUgVdun+rocrzNEnXjN3tFAqSklts2IxDgFUWKrNQUYdjkrFVr2/sn?=
 =?us-ascii?Q?vln9FBeszlpitsR3RMhq3jxsLxy6VtDOXoY6jitSPvlaN+kQ9sia/wtovqtr?=
 =?us-ascii?Q?NaapOI5gMJ/WIhicqGYEwP/MZmKAaJkgnrDtuXlazXMjHZUTzQnNTMXV0SxO?=
 =?us-ascii?Q?nOP66KKkxo4TybEAfTqgmw1Swj0X8up1ziTtWvHRLITZ+vVc5XcYSehhzCab?=
 =?us-ascii?Q?uaN+KDA9mOxHJ8xFR8aAF+baq/23zWYYETvH/5R3JGfJFcjXJucdtz1D6O8h?=
 =?us-ascii?Q?FiHxY/5DHNqykIk0mKpcMWcHF9GRO8HJ7TdqNK0HA4G0+VmZBz84dbdPN9Mk?=
 =?us-ascii?Q?L0mXJ46V1T2hcxnDbTTaAdEdXp7m5yn54pTmb6tcShoeS7LzK7w/+Ml9T1Uv?=
 =?us-ascii?Q?nRYyWbaLzv9ZrL+eXFy8K4G0Nu5sI/qFYcRPAjwbSpMGP3IMpfSnxxUJDAuQ?=
 =?us-ascii?Q?1Zsi98csgltxJw6++QFVizvQrcuLcfFgYMh6U/k1ZgTj+oKAKY1KeRlkOBjx?=
 =?us-ascii?Q?IDfDqJY79ATdljy2Qg7kKTrNu0Ix8B17ExBx1R3/yCfYumhCIfJJNRJZgnKU?=
 =?us-ascii?Q?jh3WTKwBta36eS+wdP5Xm+6g5wJpvahpPH9RFp0chddpt90PR4C4KUW724UP?=
 =?us-ascii?Q?ADONuDF0AGD3nkabk9W13ZiwfTMf3J3C1tUVFUCmVrInqPGbwn2kNNcYpMzS?=
 =?us-ascii?Q?fQDuY5ATnC1DIZmyFZ6nmrvPkgD8rN8Cc+kfu5MxpnmAPML7rMyimuxvCGQe?=
 =?us-ascii?Q?mH7j1DtzI8JixfRdzJi2rwtF9CxOQcCaMtXU+oqUPmZxGaZwCbjpGeRs45fB?=
 =?us-ascii?Q?3JMfbbF9A2+cQOFs7hNRHMiUSeKsf5YIcm6DPKOINHmHKOiyL23hWOfJYSpQ?=
 =?us-ascii?Q?+yynhzWPlbugE3I4cbY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:37.2811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560e764a-8c64-43a6-1b98-08de157ff092
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)
---
 drivers/virtio/virtio_admin_commands.c | 75 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 44 +++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index 94751d16b3c4..2b80548ba3bc 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -88,3 +88,78 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 	return err;
 }
 EXPORT_SYMBOL_GPL(virtio_admin_cap_set);
+
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size)
+{
+	size_t data_size = sizeof(struct virtio_admin_cmd_resource_obj_create_data);
+	struct virtio_admin_cmd_resource_obj_create_data *obj_create_data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	void *data;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return -EOPNOTSUPP;
+
+	data_size += obj_specific_data_size;
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	obj_create_data = data;
+	obj_create_data->hdr.type = cpu_to_le16(obj_type);
+	obj_create_data->hdr.id = cpu_to_le32(obj_id);
+	memcpy(obj_create_data->resource_obj_specific_data, obj_specific_data,
+	       obj_specific_data_size);
+	sg_init_one(&data_sg, data, data_size);
+
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_CREATE);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_create);
+
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
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
+	data->type = cpu_to_le16(obj_type);
+	data->id = cpu_to_le32(obj_id);
+	sg_init_one(&data_sg, data, sizeof(*data));
+	cmd.opcode = cpu_to_le16(VIRTIO_ADMIN_CMD_RESOURCE_OBJ_DESTROY);
+	cmd.group_type = cpu_to_le16(group_type);
+	cmd.group_member_id = cpu_to_le64(group_member_id);
+	cmd.data_sg = &data_sg;
+
+	err = vdev->config->admin_cmd_exec(vdev, &cmd);
+	kfree(data);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 36df97b6487a..039b996f73ec 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,48 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
 			 const void *caps,
 			 size_t cap_size);
 
+/**
+ * virtio_admin_obj_create - Create an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to create
+ * @obj_id: ID for the new object
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ * @obj_specific_data: object-specific data for creation
+ * @obj_specific_data_size: size of the object-specific data in bytes
+ *
+ * Creates a new object on the virtio device with the specified type and ID.
+ * The object may require object-specific data for proper initialization.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object creation, or a negative error code on other failures.
+ */
+int virtio_admin_obj_create(struct virtio_device *vdev,
+			    u16 obj_type,
+			    u32 obj_id,
+			    u16 group_type,
+			    u64 group_member_id,
+			    const void *obj_specific_data,
+			    size_t obj_specific_data_size);
+
+/**
+ * virtio_admin_obj_destroy - Destroy an object on a virtio device
+ * @vdev: the virtio device
+ * @obj_type: type of object to destroy
+ * @obj_id: ID of the object to destroy
+ * @group_type: administrative group type for the operation
+ * @group_member_id: member identifier within the administrative group
+ *
+ * Destroys an existing object on the virtio device with the specified type
+ * and ID.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the device doesn't support admin
+ * operations or object destruction, or a negative error code on other failures.
+ */
+int virtio_admin_obj_destroy(struct virtio_device *vdev,
+			     u16 obj_type,
+			     u32 obj_id,
+			     u16 group_type,
+			     u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


