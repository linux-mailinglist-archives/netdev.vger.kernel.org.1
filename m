Return-Path: <netdev+bounces-238107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DAC544B0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C194E3D6E
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578FC34B663;
	Wed, 12 Nov 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QlZtEXJj"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A19A3C465
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976113; cv=fail; b=Nr1in+nU7Inthx4Yh+TbJFslubmUd1wHrG95D8qGvmym92QDJXb9aH7N75VkUDqmqSJjh9Ulj641TUyosvXYOMfE6iDPxzTtQyd6SbUOEpgtuLfYbBdyRWwMIjl4XJnF7OEaSdNb5ctklYKNd6m/PtdfojFH+d/vp72ov+Mg7rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976113; c=relaxed/simple;
	bh=u7RcDNGQndarSdXv5ZwAgwZE/8+JF5/Qd+uM7J3/upo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0LjG75GWct5rlAL1roVMFKuA3yAiwlLMYLSQkjURpxfJKQYCBhjnjIiRfZ6nv1EuSEwJPXzKNDMnCub1H2vin1G1P1bVzp9L0qZ5QoUoNu6LFzsI5zCbJwcBXhb+YNkx1h8W43tz7GBkh0fb4yZlIc2BymHr0lKWE3S6Ld64jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QlZtEXJj; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOtSjBUXtvx4mR6E2nA1MEN6mzelMhNadEP121AR0eNEqoimxN1KtVmMGcYrhz/HNqjYTS6SeTGzqxpl5cw3W5KB4QH8Ilp3hJ+7GiCU5k0cWPPlyH/tmBl3vtoKRRhwzMSL8fWmH2aATxmN812WlXNigi9qMZPUERd9SKPDaaqygqoG07z4An3aNyYxEu6G7UtlH6xUkfPYwSo/dVOtkxXfnwi8hTw7HspDWKDgfz+1Mb+WKR9LGnLBlPLMfhLWXXx+wfRd8LB5/7WDXuxZevjgGB6QlU7cpKcK7Yr6z+kLtthFLTcxijv5B7+OnckUozg11b7WNfJvufeRKr5ErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=foRRmHF0bnJ1w8tVsMgvaSJv6LcXmB7BgC6C7PO9NFjtWkpFkY8AWsNbWa0VdvP8BPCK9li0MBS8xcl52+uF44ulvEIME2Cu4jTDzI2h9zEIyScqdiisoWcRVCa9k9XbesNwV6Sj8XV/IvcuR26aq5kEDA78zLXi8mDDHqH7/YSLv4nn7ug0JU0qS+FBchJKXcSpXEn7bh0XrIOVxy7jDO4w5vP7KTOf5l7OtvIKP3tqKm4+VrbD3c+uvW39SBZT6FtPSbveICS8ehepAzgbo2KPcv+ENPTVz0N7tAK5Te6FnjKvLx/dXXddQPvs9gEFdlfGAsfaZP2XThIilKd79Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=QlZtEXJjmyDPJFFv+UrLz60ifmXZ9JZfJ9LetffYM0xv99ZnLjlzoEtGWPC+y2gYSZNgSv3rH8K29GKghxdyyOi42DB+QuncJpwDbZmd3VW+Es2EurgnPGHF/1J4q/518feGoJAzKz6nRlmqvVFHaWSGNmCnJFEZu+bDOyvj9HjrNfh1D2gxsl5SMNH3a2deY0RzTZrJpt2huLNoYl71nHYBM8mowJwYTwdFQPjY2kX1b01nWoLYA1oPhkoadGek23GbRwRIsg8KZHjcce7EXl3MXoXePk05s8+J0AWuli/S6jmD3O/AIcdaxxwt/V0HnMo2Ron3VtqP6Whq/xeakw==
Received: from BL1PR13CA0206.namprd13.prod.outlook.com (2603:10b6:208:2be::31)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.16; Wed, 12 Nov 2025 19:35:06 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::29) by BL1PR13CA0206.outlook.office365.com
 (2603:10b6:208:2be::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 19:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:34:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:34:52 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:34:51 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 02/12] virtio: Add config_op for admin commands
Date: Wed, 12 Nov 2025 13:34:25 -0600
Message-ID: <20251112193435.2096-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251112193435.2096-2-danielj@nvidia.com>
References: <20251112193435.2096-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c02df7-0a5e-44fb-3c00-08de222294e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sv6aZbRwGrd2uUZhbmWXB2KqsVVsdmmDryh7/23yDN/MvxH1i9pr6PIMs52A?=
 =?us-ascii?Q?XCC9sXvy69wzQx8vNELDYR34vf/IoN+d0AiYSn5//pjD10v9Bw9yaMMdRHiL?=
 =?us-ascii?Q?Of3NIlJ9n9t+fzr9mcjRUYBvFaZTMrSejNcZ1dRS9rUhIVgV+34oXZyaKzKK?=
 =?us-ascii?Q?wuAJTYH7Gb2TxwBSGPWA9tNXBXVLr9LL1GZDaWamZlR9O6Pwaif3Xe5/r64R?=
 =?us-ascii?Q?x9g2XWJof0cWWUHTRNHDhTCyZxVU2fvsL0D+CTfDnKHvzz3+vzdqCIqBkUTo?=
 =?us-ascii?Q?3LLylZMtMkFJ67m8hZeKeveCc3lFU1eKas2OEMA1L9U9a5s/xZa+wovZvkvo?=
 =?us-ascii?Q?zOxgS6Unea2jNYkTpJT+Q8bu+Wk0/AOMAiEEfT8KFhcgz7cSk/BWcIo07Adv?=
 =?us-ascii?Q?KUDvLS/BgwbziG+ji0Wh24pPdfViP+mVJyLcg100H/MWXyhwbmXWssQYXyrD?=
 =?us-ascii?Q?74PdbZpFPnR2lJIFYKY1Xbvic58ahUUOSblGb3MnpfQtG/xa8ElRIK3UC0+6?=
 =?us-ascii?Q?J5cxEvozgC7munxVnfDaE4uw5ZBSaLPKVzwHsqxt3wYPH0lDxdsNhzvrXhhy?=
 =?us-ascii?Q?1HU5p++RbOOCV5j6rA11N6ArYgrmOOIgC8Y7ZzIfewBHNtTD2QRgvnPFa5sq?=
 =?us-ascii?Q?rGPX1k//NuPV438va4VunYNwmMahMgl4ZHSUJV9v1/rO9ESmpOVf9Wvy7WPB?=
 =?us-ascii?Q?mIyy+RkxTrSHSg51XzNOjU1bWROC2lUKxitnyXA84k4Dzi+KrLLBLi707YyK?=
 =?us-ascii?Q?OJ1hTkOUo7y5lCMht8h1mWfsq/uEIteoUcUE2w9Db7Bbd2xi4JUFhyLZ9XBn?=
 =?us-ascii?Q?qjhdXwRqM3PZ0fdnbBWpv72lc7SaNqYTt76Oqb2H2YRsHZfQKvEB9Ml3qkfx?=
 =?us-ascii?Q?QHRw/JmuTgvVRHcs6K4pswk+iZazRRswRMpGYZtuEOO/ZRIJsnM8jyB2EcRZ?=
 =?us-ascii?Q?uuHELbdlhwhmaT3QnsCbqAbJKmuYbQxWX1amq3ZCmBTwC2gQAtsFiulpzd6h?=
 =?us-ascii?Q?9IsmYcz8OY/k7/8idzxDdjY5NkhAEzY1sBvMoFtJ7I5Xgy8wvl/dHG3dubK6?=
 =?us-ascii?Q?XiYUaZKu2S8p44BJglWGOuonyBlOticj7cTt9NPASBuuW1qMJLeg1hmXMgin?=
 =?us-ascii?Q?H6XhM7XsXaX2xo8L0cx/xuaFfcOUaH/l20aCFGD7SG1IskB7oJ7EtIJgYx5R?=
 =?us-ascii?Q?461oba6QoNhLoNfaiWuc3qraKOyhCgbbZY10zXWlk9pQOA3elJObvorZ59Qt?=
 =?us-ascii?Q?5CVD/GmBUi36VLasAkFacdSSjYHlKFX8bGwYmItlidfYp0pfdHRjx4ohM+/3?=
 =?us-ascii?Q?pJScvDE6QHaWPJ44zLwlpsVpiVzOwVTlGcOWcEHPlnnPw6W/cQaZCY0htW4i?=
 =?us-ascii?Q?f+AiwwaUMQWYmUPgemRg9DSc4WTyqbf+8mY+PhyRn5j430cKRXBOy07TUMuT?=
 =?us-ascii?Q?FQBecKFY/CQsHwoB97vYanI/VuphRw+g8DARHsoCaZk2A3FTvDQhw65V2NyK?=
 =?us-ascii?Q?GpY0OMBgE2nnvo7fkTVduXcG8SXGwnS7wKYqFe8LPvgDYr9uyuHCU2XHlC1n?=
 =?us-ascii?Q?quVzi/sK/szyNAdQDKM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:05.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c02df7-0a5e-44fb-3c00-08de222294e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

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


