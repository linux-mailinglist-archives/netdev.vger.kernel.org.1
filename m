Return-Path: <netdev+bounces-228824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BC6BD47F6
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DF18B34FD60
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7D30E82E;
	Mon, 13 Oct 2025 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e2UzOK6U"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59930E0F3
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369297; cv=fail; b=bOtmSFe8ruQAMVHXRQfsc6tINvog2Cpevto7EFpWE5zn1UIL4K/J2RRKCQ9B8x1tm1NzTaTFPk3z+uk/6QDhMatY+P4EYpxfa6aS7aDv+ZD3N7Al65J3h9IvRB2QbkK+ykfZMhcoUQgl7p9JKLbaq4qVeh+58fmDc2zQEybMVpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369297; c=relaxed/simple;
	bh=0TmdolvzaQFU1pQaBmar//kf/wTPAp/TZiPbrJahScM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IJKUBWlLko2YsSf8MNfAzjQZFLFrH2kXWb11UAX6amaIEQtYNZM70Vmiw7WQPOP7/7zqfbwZbYknQQFmkxdE6CKBF33voArXs6wyL5J/rWkMFUWWy47ApQMBIm0Ga/ZCQ6CzO1SjrfZUm6SGr+ZGxqG6JSBPBum+w7rdO+KLAKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e2UzOK6U; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZmi12taQEK3f6sUEH5j1kMjW5IdlpsASn3qnHOZQp3jJqJDTMl98v7PRCfkXm/hLWGk01A8ttQ8vRMNxu36x3t9JaYs+eh6O8OKjjbqUYvnnkFNt5IMF13fUB0IND4Xf6bMMsKLjwZ7eexGsUM3GJNuyGbFRPSurdxKWG0V/MpPezlCwLjGxjPW+cuSaluPxm1MxrH8i2p2hjSJEb/Sbxr417e4gcWtP9/NOH6Uuh765hEA6+a+/JAGnVVe1Xlz/ANX6Fv3ib9bBrjj5+FRm+NvctMI3TY1ot2Yx8J5YJOjpP4mlENgnLvc1tgKcFhXJIQNxOiynyRppMCJbZs+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asBgiLpUcM0M73w3lOM9tq0Z+UFSMdSLwHYHhyqsX6I=;
 b=n30Got9bHyVjpuKLK/gnlbFwtq6GbK5AaPLlOimIglQB7ae1Jwrf5tAz7JbuvZVR0kOeZodQT5nj4K/NYXmfiMFlo3WUu52Oy8MLnBtCqQrv1IolQuq6zDxQrBiuYOK1HHpQvnaWmyDWLbCgEr8ep6MAXE3v5jB7/R1puffD1ei2oHG3E9NWiIWKiGPikARENWEgOP3EYOtA1sP3JSY4xltk1PRqWs7g3j87TyJBOWk0SnmeHR8L61j9/Y4tnGii76fbf7Sv3wngLROr3Xt0BrqyC1qaUarPnQmwIjD7Ds8VcDViVlbLJTsyqb4ZOKrDgfVPqsuII5BoNPfJ8C5dVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asBgiLpUcM0M73w3lOM9tq0Z+UFSMdSLwHYHhyqsX6I=;
 b=e2UzOK6UhXSezv27gi+60nmD/XoTkXosaJ6VE70oR/N8Dbb0qP5Jc7YXcunX0QPer/zc1y4EvP6IqOe9P1D1Y9LwHGzap4kDF9V/NBJ+sXSLbT/98uniO+ewzJeowGEwANTtEgJlSdYboh4JdUD1Rg3VASQ84OblyhN/VQAfZlKyVNRMAJWlo8zvGCm7HdrVx22yzp5CyoCh+UDnmfI2RKC1WSMMF/y8NfcGTbAUaO92qM+mwhOER46qs2gqD+3rKeeeKuNuG8gx/WZeLrED2Fxm+pk3rvGbRi4gIAnLyLDtEmYrHwLRQgNGvnqL7Uw5psJIjogqm2ESzNcFKrdc9g==
Received: from BYAPR07CA0096.namprd07.prod.outlook.com (2603:10b6:a03:12b::37)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 15:28:13 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:12b:cafe::75) by BYAPR07CA0096.outlook.office365.com
 (2603:10b6:a03:12b::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 15:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Mon, 13 Oct 2025 15:28:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:28:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:27:59 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:27:58 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 02/12] virtio: Add config_op for admin commands
Date: Mon, 13 Oct 2025 10:27:32 -0500
Message-ID: <20251013152742.619423-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013152742.619423-1-danielj@nvidia.com>
References: <20251013152742.619423-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 7682dda8-6f19-421f-f98a-08de0a6d1f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ou8yjX7aHNSMGGigkmdHPIKqCa9fNbzhXUOyMfVSPfDppM8H63m4+aqd+j85?=
 =?us-ascii?Q?dXbnsjDIcx/l029HrobCq87nYDJyS8lmfgwnBGzVdwLnbUXTmu1peH3aF1Ev?=
 =?us-ascii?Q?iU5SMeuHpC5INAy7fVBbdTys2KM4EMsVkndyxCPBOy/9QVREDUisnO1NVD0X?=
 =?us-ascii?Q?vWNSEIhCKlifzAoHm/n25jAtJ9SSorRG93pLGX3aO8aFbaXXMvFCtqRhYSsu?=
 =?us-ascii?Q?nXQHAX3Q2VKvmPv3UqvP0gFsJCEkR6ZmzHKQZAUmdN6Wji8CA3F2uE9oRKBZ?=
 =?us-ascii?Q?yEGAIf2fy5lji0YgJfoStnPRNf2JGpPoO8/t5NI/9bneo48D4l24UtBajrEO?=
 =?us-ascii?Q?lDZ9M3l5/ZwXCCSRDcXzsam715YL4yAnCbbCws1UTzJJ+UeBzxv5p8vEee/B?=
 =?us-ascii?Q?p9rX1gY+9fN+BxA7mEHIYHcgqpyW1kzJkF6GxwkFhqKjvmHMX/i4K8m1Hnv9?=
 =?us-ascii?Q?VGPpzKkGrwaF3ocU6fUESVDSMRBIJ3vIDYFIoZX4XrSy5dLPBC6nNG5NmwmG?=
 =?us-ascii?Q?ZUFOUMRs6M7AeK+lSx67GKq+1/n95zbPj597rvKyXNJlXD8LiRGZj0d3d7Yx?=
 =?us-ascii?Q?4d8p75loR8lLTfJXWq8dmQHSGwmG28QnyqC2GEpos12rPisSLDfToFEnL9Uj?=
 =?us-ascii?Q?R/lPMX3BhL1+0nIl4uTzv+PuqOgjbWF+CdQ0QKBZ4bhBILNZgbwHzVcJK4u3?=
 =?us-ascii?Q?tqvDcgavJUHP0akC3Je/C7mZB/sFwBMxt4IyAxZG0YMwS2G0r5GySRvyn35Y?=
 =?us-ascii?Q?VRedmMy30O/7Gj2Nww+v8dC83F4nPhs8eb53M0pFi4mCEIDCgJKJ8XbqEJQL?=
 =?us-ascii?Q?uLLkHtUmKns6uuJYipbCP99wPPLVbcKG4ZrT+aofa17xHQx148+7kKPRiB4C?=
 =?us-ascii?Q?Ddb+82N+OOUhtOrIM5ZuiwpgQnYkqgFXtEu3DBgUWfOgPK5Ff+/QHF/vZFa8?=
 =?us-ascii?Q?fsLGWjbuPxP4eqRod/lv7t+2wAkoYrKZFQzRJ/e7DtrvapjvPxgn1H0V1WJQ?=
 =?us-ascii?Q?ODrG5mCXk6zzWlsKNw4kOUMT+ap8/lrlb8Amy1GN+5FVhnJf1DLTpFnX1S7q?=
 =?us-ascii?Q?2WYYXz3koscmSE/uWrjNxD3DjSxvIWBWazjunBJipBNvesuYs/1FYG1hNxP6?=
 =?us-ascii?Q?5u9GkHNyZcPuncKIfdVYkH92vMmRchw5QrKT0937XFWwVaYiVgPm0OQcBuSV?=
 =?us-ascii?Q?iJ3zxd0o+xjDlwHkgHh+fHzUoanhgAfRP6ZrUVNv98GPAxK8UFwENoSYeI1w?=
 =?us-ascii?Q?mRMBk53iimP7eqzDXjDPe+C4TECSC9Dio/VUWMelp/pMHmEnEWWsd6xY9Xil?=
 =?us-ascii?Q?WdszGMDJSpAsM6eFT15sLunfusRT1o1m18MWqm8SLvzVxE2fCGd0LF9a+MXb?=
 =?us-ascii?Q?kt3zJ9xB+UNPeF2dXxLJVHl5ZMPdmO6o5pJU5rC283rxBHK1ixezFfGFKb0D?=
 =?us-ascii?Q?xnbZOkDitGNmL9d+xH34apT6Hh5qVcLu8hol5wUdSJv6k1WyNJhswlfvGx0u?=
 =?us-ascii?Q?9sj6ukAHPvWTn3pX+vP5z1xaM+LVWCiBXrLo+6KBwpmPTVpqbL0kcNLUWx87?=
 =?us-ascii?Q?6lZPy7TT/imW5RGvS8M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:12.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7682dda8-6f19-421f-f98a-08de0a6d1f58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254

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
index 810f9f636b5e..6d557f9b0187 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1237,6 +1237,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1257,6 +1258,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
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


