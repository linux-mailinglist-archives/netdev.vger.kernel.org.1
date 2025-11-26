Return-Path: <netdev+bounces-242001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A4C8BA0A
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799683B503F
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0B34572F;
	Wed, 26 Nov 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k35XNTEZ"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AD1341050
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185785; cv=fail; b=T9BGsbkOQ+laKUT4ELWYEJwzmRyYZEQEPop6mgb+9RtkhCN/xZvnLJ8u37Eda81h2Haii05lmE9zR2n6AtC5lV7NP1FTea3m0uYfkUK+bckk2w9eyx/2LnQf/xAtQ80qeZaHkmhlb/zECuqjjRNAT33L/C22VTU+uTEvjpV/mQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185785; c=relaxed/simple;
	bh=Glr560URxqKTZYR1B/4JTyiFscURg11/WjW/lOK0Ll0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNeLaklVZEgWivm2NEif0z42N/MeYoC+fl/JZV+uhjiXg2B6OkWs2fx3f4ac/zyqCEppQKOfHN6lSARqQUz65HofI2CUwbLcKOW4mVl0fAt/lYi37imdShEz+5EpnGEEcuRSnR7kofsskoYcYaxKWmkZzssvf1XTGr2cy+iYjWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k35XNTEZ; arc=fail smtp.client-ip=52.101.85.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2mWWiYfIG7QR0wBomGlW4ULl57r6e40rncZ92EvHZ1x8nGCWdfU6TCif6xLGDgsGCbp1MRD7Wfy4n7D+YT/lb4VyAjvPFYzAmTGsJ/VxONCOePSu7NT0j5spPkDNWEKtbAdwf880JMvEo3eeyUxQbVoctkV4+8p/RtgzUqis8ZPT27+ZsFOV94cyAtsPELRRqIhR/nQZO+B0wYzpUEnUefkUpqGb3LoogIqBoAco+N6p1YBuM6Rj30Aj6WCVlkNG07YfxIAcGU/MseDY5rOkYaaRybsikPwhv/CutaltMOQ7SZ21R8kQx313RLsgEf7FWtbit9/CvtDDnUW3LLw+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=x7LYsCgIlKW9pNFFeIokybNHTOpQi3JYDLRMN0jF1c5NIL6xHwyybAjOq527pE9y6s846S8AUkMaSL8ZY8+w1dd8X3VTM7n5HExrt5iNo7FrqAhx/NImCMPT4MZ3zH0Z/+tWrzPCwMOkQ355Xk8oYPtViRmLJRsxmIckBPCPcV2716vYEa/geJzF+BwPc4OHyIRZza33XMT5e8Hg2tjfNoiTr7eWPzsCTqZjui40j/qH/zR4RolLfiYM5jA/EWAq2KynszLcRokI90FP7/2uMcBDDP/AsDP9/j1xbvHQSSykr0aFB/0ikVRD247DoSiYos7tJE+MnUDjN4/d9LpzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkdJZe4YoXVIsdYekbaHgQj5v1GpqyUFw1t0/Ivj2O8=;
 b=k35XNTEZCKEFnRqQt0SWPVHibqbcszhuAPTaLMvgfNTRq7+jfGaBnJvpMEe2oLDpjhZGAQFbnuvpIWCBpHCKJdH7/OtpNgzA346WG3qmMCOSMPtVZUWJh0Xw7jxjBUn7F0fTS62f8Hi6vBAnNz5ht+p1CZVFdKRNN2X7AzrXMT0DmM5cRnvFXYIYGD1XMEOcHYeXBjNsOaw0bWAs6wMDy23SPrWn3dP1e/mdoQePRL2Esxo5NptBaGqWK48MjILCWX5S2rjCqAvjzCRbtvErAUraf7fy18RVkFQOJOvCbVvjbKXo6hQSd8sjqNReeNOm+5QDiliFpIczXDEy2Z558g==
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 19:36:14 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::3) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Wed,
 26 Nov 2025 19:36:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:36:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:36:01 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:36:00 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 04/12] virtio: Expose object create and destroy API
Date: Wed, 26 Nov 2025 13:35:31 -0600
Message-ID: <20251126193539.7791-5-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: ff12e3a5-f006-4893-930b-08de2d230f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5LPv3Zksk9OgP+B4eFFUqbjXN7tYAyZ0JC+PcG7DqxF/byBJHE8CYbCGHMZA?=
 =?us-ascii?Q?mq7WYbRiQRLWe6MGUSf238cx+1arV/vqZC50j9QMOduDm2kQx8BuuVM788oN?=
 =?us-ascii?Q?gLaHCXyUSTknQgIp+IGgAopny0kq/Bm990jHqDKXPCIE3gbsuOyyb8SFcCXQ?=
 =?us-ascii?Q?YJAUJR8IQjmBFxld7bU/xqkNfRCSrqvVxYVh1I1PsRFFghEzaBbs19Tsl70a?=
 =?us-ascii?Q?CGgxYjgK6rKh1KHF3kmNez4H0Cl0pRRn9KHPgjYw8fXgT/zDtigydhk0YYpr?=
 =?us-ascii?Q?3GWrFrywYK86oGDenU6OoSwybhyFMLkao91Jw3HtSiffY8FfoIHTSnddS15a?=
 =?us-ascii?Q?eTj/ps4E+JbcSFUWVZx7ChwbsbpQFOh9QHFy499Nh5194oZvmH/jxgNHvCD1?=
 =?us-ascii?Q?pGo5wwqTERGBkfy8S/NFBfY+1YkJgVirJhyTVF/dpS8uaLzKGh9iC9u7V7Sy?=
 =?us-ascii?Q?znlD+4BgiAo9shZT+GLOjffDn3SsV+knb2JBRhSYyRK2WVCiHK+EE/1lrLXM?=
 =?us-ascii?Q?dBDF0PYqodYh6lrauBWV0qTDRtVTyuMSDMtoMkYywlNGarQZSOXIDdwXhTcZ?=
 =?us-ascii?Q?gIWyqfJ9uTcCr2a78Jrqz/65h6yLPgOsYkEwjBWNMv/QHEBV5OmA9hZb2/Z4?=
 =?us-ascii?Q?ExVjwlYXvTvTE9Kz6A0jbzu6SZ199jz6/XDpvP2fWriEezpv8nlgmkHeSmwU?=
 =?us-ascii?Q?rS/LNDpCezc1TgDHtVxGFmBd168lmrBSbSnEaYeni7VL+3rTVZ0VS7mPDvWF?=
 =?us-ascii?Q?XTCpShsLAWLHpaaV9VKbMqpB+e2dSXu4/TUoefDC3QdE0WFBu+NzG+mqDudr?=
 =?us-ascii?Q?6lySukN+aqzjtEd9D3fIw8NPaY3VWI/c/uJNWwtf6cqmtYLSHA6z8DVAi1xe?=
 =?us-ascii?Q?KjDlqy95kTp9FVFJb2TlbUF+XOAYFQZ1cTUE8Di0sDIdd7SBe5pOWz72MKKU?=
 =?us-ascii?Q?8XCGQErg8TRBzrsDIBJpjWTBd6BZsxJD90jek7yvSQBnHc+eb2ycmmJEi94S?=
 =?us-ascii?Q?XSrZ8hsD3qDjVFIo6hdTeD0y/hdSV12ThqmwfqUMOaBO7DKOwM75mEUHk5iL?=
 =?us-ascii?Q?QiU2C72B17b1Klz/yTAnyeLy+hEaM05DxhlkW0A6eN8D2n4rFnqMC0t0AQUj?=
 =?us-ascii?Q?SWXEi9n+7ju3Uplj7z5bzRt63KFR4+6s7u/rNGyFyfws4s128tpcOVgjfbD4?=
 =?us-ascii?Q?9puS3l0FXIpHwbITPKdw2cOaYxg9XHRX2MfR7V5ttrTEYQBD/lrF0r4oeXoe?=
 =?us-ascii?Q?v7faYEPDohUllVZtrhyZU0HBlvRJ3o7bXm/DVAcsVmZUHaPbnRHfgOnqGCKM?=
 =?us-ascii?Q?j0GfSEcHDzRU7BWEunVyoJM8zx+ePlHwaVgj6hQX+N9WWFH4ltbasYDn0LD7?=
 =?us-ascii?Q?qxFihVqZRBRKYGyhbuHfzYbnxr9LKA6FUaTSX49qtW2YXtsinEWc8Bkw8pS6?=
 =?us-ascii?Q?n+aGY6tVNTbQp5YJ4vsmC/hQ5rSeyWDBbvz4Tj8m0BCAZ/9HS5RYaDMzoGHW?=
 =?us-ascii?Q?Z+iZZDk5NIhpH+jOiJQK0f14SGReUhTVj0Gu0SILEZuuRW1LSEq96cC40pa8?=
 =?us-ascii?Q?ObETgCicEGlWxMjPr3M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:13.9547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff12e3a5-f006-4893-930b-08de2d230f89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124

Object create and destroy were implemented specifically for dev parts
device objects. Create general purpose APIs for use by upper layer
drivers.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: Moved this logic from virtio_pci_modern to new file
    virtio_admin_commands.
v5: Added missing params, and synced names in comments (Alok Tiwari)

v13
  - Makek obj_destroy return void. MST
  - Move WARN_ON_ONCE in obj_destroy here, from next patch.
  - check_add_overflow in obj_create MST
---
 drivers/virtio/virtio_admin_commands.c | 77 ++++++++++++++++++++++++++
 include/linux/virtio_admin.h           | 41 ++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/virtio/virtio_admin_commands.c b/drivers/virtio/virtio_admin_commands.c
index cd000ecfc189..557df1caa85c 100644
--- a/drivers/virtio/virtio_admin_commands.c
+++ b/drivers/virtio/virtio_admin_commands.c
@@ -92,3 +92,80 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+	if (check_add_overflow(data_size, obj_specific_data_size, &data_size))
+		return -EOVERFLOW;
+
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
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id)
+{
+	struct virtio_admin_cmd_resource_obj_cmd_hdr *data;
+	struct virtio_admin_cmd cmd = {};
+	struct scatterlist data_sg;
+	int err;
+
+	if (!vdev->config->admin_cmd_exec)
+		return;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return;
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
+	WARN_ON_ONCE(err);
+}
+EXPORT_SYMBOL_GPL(virtio_admin_obj_destroy);
diff --git a/include/linux/virtio_admin.h b/include/linux/virtio_admin.h
index 4ab84d53c924..1ccdd36299d0 100644
--- a/include/linux/virtio_admin.h
+++ b/include/linux/virtio_admin.h
@@ -77,4 +77,45 @@ int virtio_admin_cap_set(struct virtio_device *vdev,
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
+ */
+void virtio_admin_obj_destroy(struct virtio_device *vdev,
+			      u16 obj_type,
+			      u32 obj_id,
+			      u16 group_type,
+			      u64 group_member_id);
+
 #endif /* _LINUX_VIRTIO_ADMIN_H */
-- 
2.50.1


