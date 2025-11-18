Return-Path: <netdev+bounces-239593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3FC6A1CB
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C111E4F5FA8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C8358D37;
	Tue, 18 Nov 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rt3eFW5W"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779C352927
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476768; cv=fail; b=tRDUI1bclXixjtVY31t5WiqEIhSL79SUJaD0QShfycOU9V1ryt6U8ed9CAPvEbe3CTGfGOAcDpYWanxEV8OqVy266W5292qVutHnIuBeQ//ybY7cM9xtkoRNpFUU7cciC9qL89B2VCmX4cp5cvvaNWXLZAoZy7yhUl3Vtp61e7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476768; c=relaxed/simple;
	bh=u7RcDNGQndarSdXv5ZwAgwZE/8+JF5/Qd+uM7J3/upo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0o2ZgM915+8s/9uemEnYObiLbCObQwBseReqsRAyhuw+vODJaCfm85MaBARkNqz1wYeu/K3boF0xLyXDt4wM/qkRox56SnXZwZRIp5+OY3DDOU3q8tQeQqBwSbMbeVRHfBlV89tdY8KeBfSezjaicJy7q+Fh7r79On0TQAp2lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rt3eFW5W; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc1i8uEMUzhdR8/+LhuoG4TVd163fyoBd4d8wwQUuB+B4EgPmvfaxRiw6VxtmtBsC5m0covQxuBby9P2POlgTv15tEU++/WuxamBP8p5c6Xl3OiX9F1ZwALZkzCLbco3M/8g/tWXbWSas9Vc8yC9rAhKtF7t6TS3iCJwRUjZWpCTAEXcPnEPouiYQgLGJAbMC5CITLyqNg1tjJ19aoZtKWQbW8chJnda7m7t55xXgs/wuoHtHN/BjW8CFey/GFbzhK3y7qXXpfP5B6csO4cOO3fuY9hU88BtMOF8Di5Kau23+Ol6tvmufCLwlFdkYjnEwP3Og/Ec767ah8xSgazN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=qs/ewV4+HvmdqO/+oo7dNRKszg1JCaWyl0Rz9mvr5cEdfoD05RuRqqgHbx7BesIK5iEcNUoHaeFEd5/VXxfqRn/gp7BXAq8yWPZl9XwJzx+vn1S8Z6v9ZnFLK60EVlbmFkOjNUIO0fQ6yGRzB+aOcdBVy82BpRlZEDXWR5GQLTIwUKkUZKan18PO3MfZJ5spujtY0bbXP9FFiP8nFo9lMpYOKyK4GeEmWT31xesJ8iQS5CsuDuwZbBi+XeryqbPKMX7BGbqo5n/Sn2PVHzMzY+bXFtXB0Cey0+Rvc8I1c2+ICWhFLsLXN86+IxHF9L5/J2IlnggQd4qi+xRMfbsG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=rt3eFW5WMoFu6q8ieKiHgi1jAg4Ae5oHhANQcGBtpbORYdxqKs1NW90qyYnzIC3gzQnSqULfEn69HwuN++Xnp6OVX8bFLlFlF4Pleol9wUgYl0pzoH2WL6vQDoJ+0dBSJfZuFKoKk2WIvniLjCKnRzGrH4Hwd8QMeXKCN1E8esFwcKQzrBfd5fucuc3W2ytBWrmFBNJfXTjpZE9bsuQWWio8NMAyDcuzm8zqvS/whLRhspCKi8IZDFyobAxq+W1Kk9E0D7fjgu5+mdsnjvxBEtxBwciT2yM1jx75gFKP1g4iMQqB9GHlVB+Clx7RRv/D8t3co8pY//uO1WWeD40izA==
Received: from PH8P221CA0054.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::24)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:39:23 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::dc) by PH8P221CA0054.outlook.office365.com
 (2603:10b6:510:346::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:23 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:10 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:09 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:08 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 02/12] virtio: Add config_op for admin commands
Date: Tue, 18 Nov 2025 08:38:52 -0600
Message-ID: <20251118143903.958844-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caf9e80-61c3-4ef7-873d-08de26b04461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgW6E6/1XY6SGNu0uWQu3ZE3OpMj58I0aAHMvwdIy1NSq6i2kofkey3sy1mc?=
 =?us-ascii?Q?XpGfSt1giZ1tHz4rV7NHvkvIJyI7xrIF1CVDKYrt243m8Qy6TTI49yTgJ+/w?=
 =?us-ascii?Q?M7TDyQk8Cdmeb0MGG2iJXCoqe24EE+WgoreFRO3hjj5kTj6CP390in/2CP87?=
 =?us-ascii?Q?GE99+Ul2vIa9xvO2zfF4V0MFoix6XFt3Sj64Sf8l8BNamKyDDU47E1NBCgFo?=
 =?us-ascii?Q?fJkHmN3tGCiLzEjw0cqls9OX4QHHT1cRjUOzHw4XRV5pzjpcEyaFdnW8hNL6?=
 =?us-ascii?Q?n4r9LeccdfcmPPJ43EI8aBX0vlVz1I8oGVUwIALIpbQsLexPzmuxCjgeeXup?=
 =?us-ascii?Q?pnZdIWVWySAV6PDZxO+mzmHDvRlxkojuOkLDyX4QXa9ldZ7MPXsRp9917dHz?=
 =?us-ascii?Q?iTLEswgQndIocqZnMsOoInBBO40heSGC1IN0PzQOepdeX4POhB1emg1EipEi?=
 =?us-ascii?Q?1760UNIFn14NA73JEMl6OdXdu2ni9O0buRmfpaZj2lmqTxZZI+E4Juj+zfjy?=
 =?us-ascii?Q?WEUFo1+OPOI1sfTFC4gIOTzoxXmK36ZwrmwsDBGh4oFl5fbv1IpSnK5dwk0/?=
 =?us-ascii?Q?+2T/cJxwOvMEWOYDXLRQiO/VvdxZ0lKQOF2QbQgaPRmQtfOEasRKj3LzzhFV?=
 =?us-ascii?Q?ccamJhQ0mN8F/hP6tE9PHtq3M1u61Ux4AY/kGcQONShjFL1CFZ6m+MAUUfcs?=
 =?us-ascii?Q?hsxDTGDC1GVUPHIPxkj84gaosu1+75MzGfUlc4/j9/84O1FuuQMK3RctsYHi?=
 =?us-ascii?Q?Ho6XPK6aprxgDxVQU7V3xdqYsPQrIpZ3I0P7xui+2JUEtBfmRXux6kckSvqY?=
 =?us-ascii?Q?5GxYjKJ/vkqWk2/OPblZ5Z7wEbNyyxCwtIm8W8hJtTg5udN50uHQ0RlVWziX?=
 =?us-ascii?Q?HywusoDLq2amJBG/9/e5+9q5iGhxicePZpCvxRCeMSdo6lpr6cDXEADUR5bk?=
 =?us-ascii?Q?jy0a0HyN9K5cpmoZA55pFs1UrRqMXg9gS8hN0SRK66EY2N1bQxo/EdTk4EG6?=
 =?us-ascii?Q?dB/lhUxFoosB6PWECiW9I7maqd+rjxYO29QJexo/TS4oVSUOUuJFT53DG1p4?=
 =?us-ascii?Q?ciiCKSt0CN7NbYZ5CT6evGlXPqej/AMoKolfK6pA/A0yESRyeGLxyY6KvL5K?=
 =?us-ascii?Q?CHw2sF7KDtrljAwls4hAC+U296SzF6GM3a1vIdyD5jdZJqH5jfTHTDhNssiJ?=
 =?us-ascii?Q?uRjIrqaPVHfe+65UyMAyewoMFU55ASrcxuUv8s/WQDoXlfeNrpMdZ6BOabAm?=
 =?us-ascii?Q?5D0EKjACM52RRrLbIB2V697c0FrPoLMJjcbu50qT8dplTMaMUNqhWwtHRmT4?=
 =?us-ascii?Q?xJgvAYQ0cppBKUNAOu/VBxN11EqVIrSMJsHYCJW+ERbDe1VBY3+m4j6pl/QY?=
 =?us-ascii?Q?LpUcMJXktFH/NYWrcTowM/0JOMCA5g07VPyG7dgUAnUhRJaxKMikre/e+FzQ?=
 =?us-ascii?Q?MEvVwksTUTTl2G4oHzwforVBYhydt/tfEjW2ukniuXpZNnUAf7OMlV5sNWie?=
 =?us-ascii?Q?3ibffIhGA8HYDTJOsA2a/7xAqJ3GC6hDQx7+JeGibHWxrNY1umHcU+e4WegU?=
 =?us-ascii?Q?S0VXL4aNhPVt7WQXJpI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:23.5284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf9e80-61c3-4ef7-873d-08de26b04461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ff11de5b3d69..acc3f958f96a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 16001e9f9b39..19606609254e 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command.
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


