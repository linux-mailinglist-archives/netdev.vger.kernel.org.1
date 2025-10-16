Return-Path: <netdev+bounces-229864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0D8BE1780
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECB1834FB07
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FC2219A67;
	Thu, 16 Oct 2025 05:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBgnE6mI"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E838205AB6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590889; cv=fail; b=JlzpV/sS5pKpY3seppo6LvIoO29mYDK9J+pDJHOeY0xlPsp60D8++vlermV11kGeO7BsEId1iA5FOHgPqPzlr3YNjnFAgLogmZ0qqrIklK3DSZEoTOqzIc6sjEGsBCe0xbHSy5o+TIbSNk8187HDViq2ox3VyNi1lA3vd37kUH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590889; c=relaxed/simple;
	bh=RLF8OE4X6nY598EI4Hqm14JlqpB8DRKg6kV2yvQJ/DQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFKQY2UxpRtlbdMPsBH5KOw0gmyounIZhg2h7bRuiextZyXXgQqOXIQGKvrcrPkeXRTFl/beAFjz9kZ8A8VkQU/i7ySpdc31SWfNVL6mrWSHzzvLuS1VeLH8Gns41sxBpMJ+BiK3cFCFqrafGV4tFdMplwtQPJPrRSogyXuqNBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBgnE6mI; arc=fail smtp.client-ip=52.101.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzFWZ/R6Ft5O+g2b6Z75kvHVPSjDt+f/fcCETZdjA+C29NCS/MvCgCPj3f8n0UYtssLpxMvUGz5+gvxmYo5Au94oJhyDAPtbXTKLNBFaVE2nDQGGlWEXu98M0dka9GOwOBifxuYJbiCu0stcFkz/iumbBiejDkchXIqLJb52L0cXBHRxZDEEFzdPH6VV81u11Sas2C/n5yDOxPJwMe/qDzh/pX8cNbCrDp29uJJ5kwjQ9dB2Q8wN60hixXEP+fGt9igqsxbVDFnEBMVX7ZYJ9AHr6lyz2eio3ggZdhkA2C4si/ZApOmamzsi0hydx3bWvbHiBXdGtgR5RJz91cBCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWrmXrH6+j1q8eKlxn0+TCznDGFH8Xg/Sn1vR2wcvBg=;
 b=GEl9Kwp2Dnwn1EEbP6KXngaVgPON35Fl1FXhjI4HvZhXyrDr0u58iVpjyMgX4bJyVHWoT5G5grZrW66ILkSri3u+FKKiMbiQZREPVvnEM9s1sdue3s3k2NV55Z5K+bVPFfQTUD6WI1bQwtg9FOyy7Y5qkm8+GGNe2yGKV9xHzCbf5aJwCL4GRYOcK5mTolIXf4HDv9Xp2brtTRPmlVKEU1S+ozo8LSeMt3NfHGWoSQ7J4fMop0jPlXigV7r8BIeN09UfMN8uvBBge1pDj+MhLfPdMFcMNvvccLamZjWSM9fjtlKQ0MHgSv8ymtKbXIaYxjqB34cwHIiHNkpLm9iQgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWrmXrH6+j1q8eKlxn0+TCznDGFH8Xg/Sn1vR2wcvBg=;
 b=IBgnE6mItNn0mjtwXrdag9UWzz75EISrvG7qZd2byGSrT3S1mDgHeja6oiIPWryZddF7URKuTjA8ikMvT/N7+jqTsxCNbQ8hKWBSOuj+3wVY+N0aYzagE4pQMBnnj4CM/zRpci+ibTVVa2R+oZTiqMDhkXq+r6FMTqSW4Jaq86AgbNfBCNaE5KwIArxea/gS+TWhedgLGcybxUM1Gm2ihaBzzny9ovyyvQo679BZrnb5urbaTbeZOSNiNqFZaval0l0OmEk4LDAcieoqngemEUhU6ulHb4+On+oVK/WRL81t+ho9hGMwtUAgMXT02eXq2G1dgGOnUSRNvalPvcZotA==
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 05:01:21 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ac) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 05:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:08 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:07 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:06 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 02/12] virtio: Add config_op for admin commands
Date: Thu, 16 Oct 2025 00:00:45 -0500
Message-ID: <20251016050055.2301-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1c9d4a-3ba0-4484-9231-08de0c710cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UOmmUCz7KHfu5rDiAk4HmB5jBFe0D1u982ApIH1i1KlOd1TiEe4dtiNFyreZ?=
 =?us-ascii?Q?YfBN90kxNxn6SPmbfO1G/QKXqrp7WJW5qisS5vZE63N5GftMo9D9OU9Ag5mF?=
 =?us-ascii?Q?hGFKKUj+pwItf+hKhSbR/DK/neiATfae+NSjZNADK1RyHfCaEMF6YJsdRGDA?=
 =?us-ascii?Q?F01jZiU4Im2usJy5l1Mc5aoX0eOBUZvBnIGTMuPgEC54Kkd8MTHR7WOArWNB?=
 =?us-ascii?Q?xFTElG+A05Bah3Ta0JTNNgMO8XXkZHUc7ih4YB1ssioVKjBTlHcehX4QT6R1?=
 =?us-ascii?Q?5ndYMbpFTzg04guG97UqHJdobjuzF5tWuQK7H2GHxLEwL2AL4GZX0/ckgAR0?=
 =?us-ascii?Q?2ikTbX653oLpp0ENNTXTYl3UqWnfnUoIRfBzMmGr6JtnGFUbHbHJaky9B51Z?=
 =?us-ascii?Q?EfFXtaZeGKYaU/GBQ4ZZ6erUFNlb4BriRxs5kYeYIVb6LxVGjJeBGcw4qdZf?=
 =?us-ascii?Q?frrn3zFSKr9UwkOzySJEXB8wp2kxoWIHwemsRDnfWcTuoer+lLKU/PvUtI/p?=
 =?us-ascii?Q?eEhByKqwaSj3ZFEHLW8eUeyo+NSYklc9cDC+P2vAY6I2p6/6Qth3Bv0NxMLG?=
 =?us-ascii?Q?abolhyqFeXCBB11F3enpx1gJLbJ2+etcbsd2nS9AfcYsP604jhYJjn4EG1Ro?=
 =?us-ascii?Q?7zIC6Fx3uNKZTtTIrH9EjHllrpM8MLzM7ETrq8wodwMWSwDaiLm8YYrtu0Mv?=
 =?us-ascii?Q?FSr8rsxpupGR3eAjta8EPYz7a8e1NgaicPeAD28jMJlRqVncypNnN5nj4rvN?=
 =?us-ascii?Q?zVnmKQJQREtQdDgJxtF0gfqXZF5xAsUZo94uqr+8rrF7qBxkl0vACHpnsAcr?=
 =?us-ascii?Q?+r+4sOXPof72eUOSlTCxSPQj2YxuZismy4gva1AVIkVKSX8CpFE36h4OHcUA?=
 =?us-ascii?Q?DWE+sfcgUfCFjfwfDcVMQHsTVkGulmNI9PWPUUWWhn4IysMiIZ/7NOUtT0Ri?=
 =?us-ascii?Q?jn0RXyRY6d8qMO7RG2NnuaqY4BlZz9ga1NAHBW95uwgbm///EAIvwY+HOsmw?=
 =?us-ascii?Q?A4cMMCJaOiuRruuJMC2s0MlY011mZ1QbuIbinFD6nD1M0DHW9R/Yu+sVNsRS?=
 =?us-ascii?Q?KY/ES6OLeDX8+Du54c0fDP/it4FWDkH4YAvsv3ggwUYkJP46M9pbPGV0cx2G?=
 =?us-ascii?Q?sdhdLPGeOu7YsEihURNbX4VrfiurAF+IV6VNnC/pjUwda5q4mwAzkPxznpGx?=
 =?us-ascii?Q?pqLjcZxVaciqAGZ1pwSepoNTD/uNehE2ErZvCCqyplcv4rNsIBPairctkkVa?=
 =?us-ascii?Q?aSgwk+6ANeleiANVVjHDZwytKyi0XoP31yssbq2QWw35RgroZPTpXgXBAJlK?=
 =?us-ascii?Q?N+vu2D2jSGXfwHr/X6b7nIIWoySkYV2wppyzHZrjloNQI7OM9ZRPvrQXcqxS?=
 =?us-ascii?Q?ppMd4KigaukonNk+rboeDZWu5yoEKLSmptGR0eHSHpLZjLuVdtvuoeeGUzLd?=
 =?us-ascii?Q?N+0AKJ30niyZmswNLJ2GJwry+UhMX9lPmrQw/Upe9ruXUDHAKbN9oGafp7Re?=
 =?us-ascii?Q?83KU+85GNK0RtNNT/WmvWgVqgRqf6x8mHnv+m/aC0aPfW5CJALqIMgj8XIR9?=
 =?us-ascii?Q?RrCLDOlQr30OsLkFYHY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:21.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1c9d4a-3ba0-4484-9231-08de0c710cab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

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


