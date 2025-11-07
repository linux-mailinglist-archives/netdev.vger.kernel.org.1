Return-Path: <netdev+bounces-236617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01F7C3E6B6
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A17C3AC5A1
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3EB25D208;
	Fri,  7 Nov 2025 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WnoVFA9+"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013010.outbound.protection.outlook.com [40.93.196.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F75224220
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488991; cv=fail; b=jwMFb6LMc+cnMp27wZg7bDUyhvp6fNPLK2ycTFq9P4wZoU/OSVpR3gECnRW7KrMV6SgalmHxrg8JH6wwSpr3J2/IMaG2x8fK+92yVMq8/DInXCDlMNu4mN/pi8hAaheTVfieRNJbKTvUP27PucAhHnz8UH+LtC7hY0uNT2EwU9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488991; c=relaxed/simple;
	bh=u7RcDNGQndarSdXv5ZwAgwZE/8+JF5/Qd+uM7J3/upo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb/eVLBLSTInEN7J8FK1FFtS8sAErNkQ6ZMv0Zyrfl+YpaJaQI/Doy3OaHMEKHorDGynZe4i4KnRv8NwbvLPdFsSzUaDzH0qJ2BVdZ40ieJnF+2/YrnW8u4rUvD4Bj+WVQRYT/Az/s41DVi5r7w4/ebfXN8cPwPbwbcxE4Rjl0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WnoVFA9+; arc=fail smtp.client-ip=40.93.196.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umXcfm4Z7jTebzbmutqTx3NzHLlFPN/xIWiWDZ57xO8WSas+qsP2WtBo9J6ZRMXQdQVE/Vny8hst3L9jFduk203n+6ZXPEZ6adIEkusO10Y+oTxI9lST1J0K3hXiOV12klX79cXzwDml+vF9Chkb7DS/0ws5dD3NEi921Vsl9i/5C+J1BIQD3Rf8e34M3MmW0zrBWV8yxVVtiZfkJGC3z2qu4JB17HqDm23j+D3WYAX8PimBTeg0bvWTFWuOQBnq2W8avnpY2WeqzvwQO3iioM+P743ssF3uw1m4qrpuuXe72SNtOw8GOG0KHLNDDp2jrRI7WldExd8qM42NmWml+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=kI2xWMjC39QEsl3LYbQnsCMODhbnjC3OSNg97Hqjl836STXdCZc9QYO9nfCCw02DcIcsy+pDURYOgDcNg17UIiaCVXQapunCwoHWYeRmYVNAM60S1gny1E/5e9JMKHUh4nxRXV/tuFh8Z0na3BcafNQiaPYf8upNUZWTkSJZBWBp5rU3wxwARVheNOW3ydyrit29XkeA61hDg6OePXJn9Uqm6uwVmjGzxk9PRKdwT06bjiJ7xQ2WW4VZFqUG4+C11xqHgE/p64fiVZGJSgxwr4s42qS9lGw0B4U2wUvCHCjpDxQjHP9Q22MjP60NIUD9yoTauzw9cx62h76MFNqADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBW0bhGy5J4q3PBKs8cUEIqs7umGPNOZT9ZLimUPd+8=;
 b=WnoVFA9+uPl66IBD2e7/jDCq/azQ0/1+yqY/RSGGg2VoJBH/jRJUtPm6VB/+bb42XX8CfSYemQziLMNCcDBZQIT5WHi/+KXVLBh0IHY/VR20WHzPlkkTlg9UanxYQQR3jzVkZms/v9iZs6PphZSlW6Kc1kwXjqDEcFuYzTTQk9Xfee/B0GNSXNhYCos0Vew3pCQdYUi0/siY3r6DXVWirQAwXKi32+js+KFQZj9ctN2i0TpOCOJebuhlmPHXUpxkEwHv1vlkPE4IrEjKFMyZ1G5IH7FIHTGT9ig2xHibGQq28E+G+WEnbFXZDtQRbW+OBeOTofn+pbcJXk7/qsrhYQ==
Received: from CH0PR04CA0038.namprd04.prod.outlook.com (2603:10b6:610:77::13)
 by LV3PR12MB9332.namprd12.prod.outlook.com (2603:10b6:408:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:26 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::c3) by CH0PR04CA0038.outlook.office365.com
 (2603:10b6:610:77::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 04:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:14 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:12 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 02/12] virtio: Add config_op for admin commands
Date: Thu, 6 Nov 2025 22:15:12 -0600
Message-ID: <20251107041523.1928-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV3PR12MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 58053855-0083-4ca5-b701-08de1db46b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WAjPnIdv+N7QaXUZROIt82rSm6tTZLWmoAri9FO6nqkJ/CdL7jAH3xQqf1ZL?=
 =?us-ascii?Q?qEImQ3WlXlhhu6bnKfiCWeUcm6lo41FN/u8dRXrfhoRMyc+1httIsUPhv+Sd?=
 =?us-ascii?Q?j67fnbHdpI2AM/PCELdfR5h/fFteZL9DtwD2YxQgyGCyJZi2tu+2jd/eFALB?=
 =?us-ascii?Q?BR0cHTnypERqT0wrdd4gioXHVTfiKku/DhnkY2ee+lcPVd1+raV7Zwb+40SB?=
 =?us-ascii?Q?AnLVpuyTMwvqknoMpCvAhXI+1dhOReMlX1WQWJY2NTpHJQkibn35eLdQ/7JU?=
 =?us-ascii?Q?VWHGdLbEIhr1m2MH5Thl2d4MDIdM0d9kVZ8loqB0oCrZDM8Liorn2IRqu/Qm?=
 =?us-ascii?Q?KQH+1zL9CLHE/wGe3afEv6zQ81MAh8VV8dWoW/msqWk3bNnZpZa/CyCJ5yYR?=
 =?us-ascii?Q?+MERNcGsNJIdO24V72zdQ16EUfuNG2ZS2XUOuG4ugR/W7neg80B+eDa0tx8C?=
 =?us-ascii?Q?m/FW0YhATpbStioPOS3uOEorKNWZq93wscHIpWGE+Ume/vTu2BxdTktM7u4h?=
 =?us-ascii?Q?eUuqYVPWHVffmoaeWxfSD0ZGVhCsJdvPbVtrM1/ZrfbgsE3SkYHwhcmpl6k0?=
 =?us-ascii?Q?j+hxc2bFhweehwqEi1UlFTYxFlVPUEfN3BqprKeQocnrZ7O33irfxg6R592W?=
 =?us-ascii?Q?D+ADpdqnMA29ppXpFC63oMGAsVxxdDeqzZfeNKzZCmkFGiE4aytOgeLPyVEq?=
 =?us-ascii?Q?FSq5KM1qYocuSLLqWkdkA85fOrxhTbu4p2auac8cyETdv0AmRgsUf58IKc5q?=
 =?us-ascii?Q?Q217LZHovqaWRjGq+SUiNHJAQWKANOemvpgjpLHHKECfcmUeKsTExJ87zGoU?=
 =?us-ascii?Q?jvMO0tqeTGeVYBAJlAn/HVTCFPdHNL+C+3hTP6aE8LVhObssUBkYzN8Uv7au?=
 =?us-ascii?Q?bgakR0BI7bFdacr4pdLPkSda6KNo6VuVRO8bpTdH8aDzVdxd3322Qcu04RRO?=
 =?us-ascii?Q?ZxAT9Wr3Kd81ce/BIEW35lNkldrN7QXq5N+d1MXmnn7k5vAbw/ENcrfp/+ub?=
 =?us-ascii?Q?XhF3lfQ/iyU7qPAcuRX8/kOKEIG/I3il/XRsgW0MpAZLuF/1RdtXzbFDac66?=
 =?us-ascii?Q?nnBu9jDmz/2LhOzlsK/GvaeDdHanhRYDNjsX8vS+kofOc45Q+hgmOVoefYDk?=
 =?us-ascii?Q?ixhWB+IFuYA1+aRJlV+CTMcIuGr2uaypfPfeuJO7jlgTrzeltKlviWfmm7lx?=
 =?us-ascii?Q?b7ZSPswUgPa4uqb3T3m5HTzXcODk3XeSkic0D7c6SsGWxpE7kOrqpNCYqDBn?=
 =?us-ascii?Q?QlfLtNwrQzswIGyYcS5YazLLmGOfH1kCXxHH5AviQ3MA4ZTz+8pRd3cXxsGC?=
 =?us-ascii?Q?/hVw0RcqhCZdP92IcPQrEpFO1PfWJXQ4jCBuz6+NpXiA19NOLpnCbSPqffvd?=
 =?us-ascii?Q?Oej4yHrd9KpZ73R7cZMOltLg5jGu3aCvjkoslVcJQjiPUqhjlseUA9FLAVdL?=
 =?us-ascii?Q?UxYtO3FI5fVkfHpfyhx+Ym5wJZENdoetMbdOQa2FZaKqh+ZUkAT42ju4cUML?=
 =?us-ascii?Q?YuXkGeDUt0VadBBjLNYLw62nQPfA7hXWr+9sKIQTNDum+zUWVJcf6FjhgODl?=
 =?us-ascii?Q?qYYkF2RaNJEY0GENhJI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:25.9820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58053855-0083-4ca5-b701-08de1db46b0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9332

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


