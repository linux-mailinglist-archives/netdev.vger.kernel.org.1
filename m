Return-Path: <netdev+bounces-235250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A367C2E544
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6987918992D3
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DEF2FB0A1;
	Mon,  3 Nov 2025 22:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+shnN21"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37222E6CD7
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210563; cv=fail; b=ts/IAF6sraYrF5iHIYvbPa0a0N9Kbg8n1ZJwF6it0rf17suG7QSEMktvrlSI7DDLIvMYM4SRQ8vcZFqjHepkmNYsr2FVr6a1poqckIHMj08nC7wyJwJngRboI0eBGnQU7syWNIvQOPYFiP296L8+wgB3Zzn39lxUyIploV61SoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210563; c=relaxed/simple;
	bh=u7RcDNGQndarSdXv5ZwAgwZE/8+JF5/Qd+uM7J3/upo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8QO2tPUSCfWXfSNYNZjdPvFMzXps/LaHD7R8NGCIiVp4uylaNdSQ4H7bjPv5EFVLyZob4HeHLwVATmg/D83DUuZlzKqLtofbF20TqCB8+eDSeGyLEM+03kdpmvQECnQG8APfbDGLUm1L7Y9hHfKPEGegXy/8Qd9nAHu65x8PxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F+shnN21; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCWXSm/bYtoHV84K3J34GofVk4uzXyQCdHPgl1UP0hCRkp5eQcIrOM4rngKRnLbOwNRAEulG6BeXSGRC+Kj/kr1qYjlpq/xsaWHCzAytXvOa2dFbL/hEMxX3DVwjoNetQ0dMQiBnW06CiZ+7MDqPCFPHbbh7nzD5eJNngbDaVwyCzpgMbU4AxqooSmyEaQAC1jznKMPrjOi09HegqeqW2NlWpZi7tf1dq4zuO5E/NiwY9I7c3bKU4sq/b0hfg5yoIOYTk6TBvvwVs9Liied9r84IRmLz+fqS95mrbCyHe4Y9+Mb5TAO5Kz50NwTPzA4Zz4zY5/McsgYipQYpo3asZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=AvJe6ewl5Ft7KZa/F7ABpyMT5uOuU5DgiYK4X1t1bYoZ3RfLaRidJ+jHW6kMSLwjLaUXgd0BIiGhdmlq+V58PeGBimyw64iK7Wlm091C7ynPYgOZm6pMla+vasyttMYuZwKrH60yrgfSAoPL4tq851cj/gItttNb1O3S/xt0j0ohBamynJTpVVLkjCR5lIB80D+psGz903LN2IpeCPW0NbEuCiI5oPySQxoMrgtdRCpqAJM7ToCLrsr+T/WBUq+f/kLQBK0TyrVZ9Cua4USbsYyrqqVuO1ao6LPvGlZ6lSPSamGvAPeePMBsG/em9MnTmWuoQte9oz3XQh7tMdIUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=F+shnN21J1Kli4xrVbE9gyyksQNccXJs0vZuCL5B2Fcxyc1M78AlL+QXL96tidvTGRw/rF+A+71AHBJAwVKCnJ5AM3ptcjmntzwvp2R4s14LbfpsbWsLkixJDIzRmvu2l5Lfk6GPotv4jHEnWvwp8iYIBnz5sx6mkBQbQAZL1yiPTh8WKTAv20cpuGKzZlep4D6AzKeYNFvI3ZhA0BvcJ36GBSMQSsFmmFJaE6dmJR268b/cibM8ZwzTVExS8fCga9NEII5qJZmoq74MXrYkTzig+l071T7r39wndn4o//eWGTDASlfOzgvxdQxNsmMO3dbslAf2e6cPLttGoYneyQ==
Received: from SA1P222CA0121.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::9)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 22:55:56 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::15) by SA1P222CA0121.outlook.office365.com
 (2603:10b6:806:3c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:55:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:36 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:36 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:34 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 02/12] virtio: Add config_op for admin commands
Date: Mon, 3 Nov 2025 16:55:04 -0600
Message-ID: <20251103225514.2185-3-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 7755c021-89c6-41f4-545b-08de1b2c2594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TQIXlUss8fFX+sMr0xxGLCxahfNA1jde+YCK2L70nMo1L354aLXlLnYPwumM?=
 =?us-ascii?Q?nrze+Y2HPu7Mo2FF1NgedOAj2sK4KAkOPAV53ZLTV6yEVjHfUjwKyq4kDw3a?=
 =?us-ascii?Q?t3m9DTn+t117InOCHLhOHKTtbl7H77uDV7/X7voYb5ZW6IjBEd16UiblN7Op?=
 =?us-ascii?Q?SaQItn0AljsnHcsmfuOYQidLaOBifgk3tClP89Vd5c9xiaCZTVXflzTT4duk?=
 =?us-ascii?Q?mKT8xPI6nAi8rXmt4Nxz5Pw0lTA3LsQd9mCrIWzwbcqkCj3yB+xCZNBxw1V8?=
 =?us-ascii?Q?6xG1EIg3whdWfZr7M1Yr7BUg7vB4NyKsKrnQp7nZX5ZRChe2sCbrAo3/WSbF?=
 =?us-ascii?Q?6DgNwNr26Y0XxH/Zv5DzURfst8L943iMOx6cmDDtSeIyBD3mLEbFHjRJlNwP?=
 =?us-ascii?Q?UbLHmJAxfM1XGmEDp7CXDIJSKKUfJmUtijlOa5wRF9TRnB1JuIyQ9X1XNvFx?=
 =?us-ascii?Q?uOm5A+yLHuX0pN2Bw/KXuJx5rN3/xMeBFb6wGexZSfeoENHTdSLL3Z9XPtVT?=
 =?us-ascii?Q?OC5kb4BnQwgKWcVdoLAfw0FxVMTwRlocDIdzHGc0jgB4p09vfaM13rVeSIo3?=
 =?us-ascii?Q?ZChiIxOvMOOHS6SVDxNdpF+HgzNsHrxMagi9UfoNDGAqfcIKsURBnnTWaf7A?=
 =?us-ascii?Q?kjVx7aICsfahOQy0JLTEmOWmlNlvp/QYhuGhUQNvvoHnD0nU6Q+cOZDz4vTu?=
 =?us-ascii?Q?FWRTQ3aLaPx/lyZsGY0OAW1dPwivt7Yl+pavXSzSAS6HmuZqWgQHj5TLnh5s?=
 =?us-ascii?Q?9h+d0iF3FfWaMSqKOVrDWd9Gx79v4GGLV+FZ1yDIxkT4Qs7GblynwOpJLWVV?=
 =?us-ascii?Q?NFOW9U6HPfmBb8P5yQv8Mktj4/xLLwLZWSxb6ixio47321wrvfv+LoaxReC+?=
 =?us-ascii?Q?dcoIkh17FvPaCWut6FQnrhB8OvUC4sy7ce177MCcAig6AYBjZefjZ/+MGl+r?=
 =?us-ascii?Q?JL8wSJQLkjSXJb6X1pozBHlQRMl/c/qVL1yT4/n8l4QAo7IVGXNnyLYdAmwf?=
 =?us-ascii?Q?aeCQT/cfz5ggna4FEm/bMIMjXq37wGelGS5cKiQ9SDS4PMfdXnl8BqND5tmW?=
 =?us-ascii?Q?fCDzdKmCoD4wexgxngO3gJQ0qknK5fSAcKAag8D5O26Oo3Xs+XEgH4Gay/u8?=
 =?us-ascii?Q?jCw5Os+FDwwRDQSD2yTMve3u8O5UZksYOjJlaNoI+qqxw1TLIdkfl/RD47pR?=
 =?us-ascii?Q?nJjYcjPPHytDoyI+NKE1VlYHeXq8ka8RI4A/czrx1kqHJEVfiocxFAOdHynp?=
 =?us-ascii?Q?pUdCw18pAWZMwqpwH6UEJTHhUbFfAUOIjjqeyD781xcl473Ydnp0K8RTWSuc?=
 =?us-ascii?Q?ZXFtZM1joLYfTfuRvBIScZxhfAvMcVxa8etYe3pqBafNAi1+Ig/8+27SncqB?=
 =?us-ascii?Q?73X2u0SgWc2+yV/xJRD0oCq/awZcV4nGuUa8c2KP9rwASdGT4QcnufDVpoMe?=
 =?us-ascii?Q?5sXybDG45/zmvihox60ZihJt53o7hyS+PDblHejbDIqNye0W9Q1FmBy0QbCs?=
 =?us-ascii?Q?s+CvnsjddqJ2+c79IPTccphnS1PCOYVAkyVPi9pddPvw4yQUEWYbFIZSQG20?=
 =?us-ascii?Q?gfgTUctjY4BJB4pWd6o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:55:55.4686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7755c021-89c6-41f4-545b-08de1b2c2594
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242

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


