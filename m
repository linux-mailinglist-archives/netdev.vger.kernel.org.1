Return-Path: <netdev+bounces-220661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E848DB47980
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 10:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B357D1B24E76
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 08:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A038214A64;
	Sun,  7 Sep 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ejt9y7y2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A723CB;
	Sun,  7 Sep 2025 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232561; cv=fail; b=gV+WzwomLZ73TjxWuWinHGLRv78bzpwCgYw7OCAaXyqlzNLS3G+AVn3uOvomXfzLufPkqgVBKBRPBZVeBnOSA66iHDYtGbKdSb+Y/HXRjdKLSyGfuGMhzNZKa46GxmAUF9iFDPVy5cV4tqIg/PdQb0xuHQbwv513VIbICMLvh6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232561; c=relaxed/simple;
	bh=zJHIxu+rNfnEq8u+7N5BfxPz/k9IuAkIo/0RgYjuiDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RneGOZGVR6YuAjCEwzniK3aylGHimEsldzDBC0ASykvwgt3L6Bf471xB46F8ZaGplLrFgowWwhcTr98YhlJEXG4ByubUdDb35e2FPaYZV3Mblj3lx8vXk5CTTIxQr4ICglyTHGzzGKfkIJjEUWkk/NOVGkY+9rrtzsJqcS5VkLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ejt9y7y2; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvJCUx+qMtWITD1ugPbLWj6ETF82DonfVCOrmtEhdhHQfP6h6C130oWMgUE+hd9bXnfF+gmy166EgWg7eTxXwdGB2G9rfSdVG4y3d5Y59WmNZ1nsiJ6rbCOPL0UiXvbiaU+JWwHYygjrOC6O1dRzHhCgeS/X6JG45TTqouJuFnZRz6ymlThvQvOBvAle39UrdCnmgFrAa97Lzix0ickEQ92MfcEmjeZEuqRO681+euVqcXU5NnvgonI0resveiJGkIlfgEKvzFREqt1lMxuAgjAAe0VpyWOmCxKVwJiOT9REETXcGT2cXtHvDiwPui3OH8/2HXkhISUPLWXDqTthEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwYGEksrr+pb46ipM7s/UH/kfEFN1EVGQ1cLQVRbRtc=;
 b=P+VVWgTlx2WjU1KeMDUNXIvJmQDKgo2zsDskfxmtz2KSXV0ev8AFp5fj0fF7J2yjPS+jE51DXxkJi3LWgLD1iZLZZw0rpjv0qNzaNpgsOGlTDVlcN7y2JLhgZ4/lBzzBbowBtzLd/ejgHHu+1yZCOfmKLHw9apRH++xpcUoci/RoPAK0/zOhBR/kknzzHAsCxLwkx9IgFsM5brd9fUgciWL94CTpx3gL2NlCVEnC+PBHsFeqTKiMbKV55rzoRfqr/Nf/pVldJGSikrq2A7OtVmdaWF/AXi7fzYj4h9AYMmTvWN1H3TiCeRoOUcbLulWQsUgWnzdJIGudI4bTAGly0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwYGEksrr+pb46ipM7s/UH/kfEFN1EVGQ1cLQVRbRtc=;
 b=ejt9y7y2KQ3RCqURxKV3DPn8ZvGOuTiDgmaKhBMkNQw4qYXK1+1Hk4fLr1VnESypRo0GQCRkfFt/UbSetkzQF/uwnNhGEZtUH5VX9TYGS7Zo0YJ38akTh3G3m6qLspiYurptObuvMtyOVZrXf6xZumfzrSsdyB2GcoTPODvVOgKArWERu2UXzA1EAoGzzA8kk8XN2TxKIY2+/8TDrKcw6ymWCRt7kLhw0bwIWlDve7HG6SH6f1FH24GyG6tdQ/CiG/4xCUgdx1vkF+Nxb820g5xD1hs9W5BTQgGuPi/cEpu3nfkMsqe2aB1vbR3AeNMtFq4kYv1k5Gvpc/TwZpuF+w==
Received: from SA0PR11CA0158.namprd11.prod.outlook.com (2603:10b6:806:1bb::13)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Sun, 7 Sep
 2025 08:09:13 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::97) by SA0PR11CA0158.outlook.office365.com
 (2603:10b6:806:1bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Sun,
 7 Sep 2025 08:09:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Sun, 7 Sep 2025 08:09:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 01:09:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 7 Sep
 2025 01:09:02 -0700
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 7 Sep 2025 01:08:58 -0700
From: Carolina Jubran <cjubran@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, Kory Maincent
	<kory.maincent@bootlin.com>, Kees Cook <kees@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH v2 net] net: dev_ioctl: take ops lock in hwtstamp lower paths
Date: Sun, 7 Sep 2025 11:08:21 +0300
Message-ID: <20250907080821.2353388-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: b6dda8e9-5c86-4098-6dd3-08ddede5d467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8bos/ueSVykLYinAuRjN/HpKX/XF/JXV0zgsvwSQsXaWtIa+V0epUCed+6q1?=
 =?us-ascii?Q?XRy9o3Bl9/pFZSRmULwkgJjs2xnB89OptzQSSKelDaUYPSwKxEepUeSboqxC?=
 =?us-ascii?Q?j1cDIhsCFI38bomnAWTDgvQAOg92X2q1lc73JrPOqUeup9vrDDBPNSTEk5ei?=
 =?us-ascii?Q?SPQRK5dITdo6twTxzMVCG1tkwuiDWZuQ8DpLkkMftuTT/6IMPse9uvjeOhsn?=
 =?us-ascii?Q?LTfn+Ry3yip17ppUH0eyljN0DyEfoxvGOZ2xKBtdxiGSYAGG6lsQvUctPRaP?=
 =?us-ascii?Q?k8GY1HEsNLmP6jFvrnDweG6oFEZPY+enIwOH4bKRaH6/Y5L2TvBKIG4oEuwe?=
 =?us-ascii?Q?XFP53MeWe+INNCNx1DA5dJs/ZZap6gAj2ArO9d5oEHJ+ZFJbz8v9Yu4LYAnZ?=
 =?us-ascii?Q?hohV92f7fV3k40AszMzaeTOgiGJUBfQrA5SQNau6KYkjkt7EZ0tSaBKzzFLi?=
 =?us-ascii?Q?1KQ0EyVHwuKEbcHkKN9Asy/o5bXfIUALOpa/iitlQZwEvuZi7ecztgX63pdQ?=
 =?us-ascii?Q?DsGYcuuTf0EvdLJZRNDvu5b40nuwyEa/Yd7GmpqQhaXDugNh+KKa87JDr/zR?=
 =?us-ascii?Q?yMT+b1UZTxyh+99oBkXgd9M3aQCsy7B02hPgWF7P4X8QDel/g6iqRXY6cwxt?=
 =?us-ascii?Q?YlWubHtNgxzsFMI8sIpGDMXlj2E2Bca/Qo3xcHMqIUsTaqYAtHzg8h5p8VVz?=
 =?us-ascii?Q?rEcc8gaJJAOVv/K/80zNJs4zV35jys2BhnyvWOV8Jg8lUV5Z1hSQRAYBOFTk?=
 =?us-ascii?Q?KGecJtKcFphPl4dHyLRzmD8bPWmxuR099zF/Twv4W2GK4TL8jWK9nzYEGCK0?=
 =?us-ascii?Q?8rciVR4aS/k3xJHV4aZBw1IirtXsvcRbw9WMHay9vJ2F9ZBWJMSuRKU1KGJK?=
 =?us-ascii?Q?VpSu+7a2+bhOegvXklrBebdVK7aWmD+mLKjMsLh6b2b4oFqjCsnhieWi9Ffs?=
 =?us-ascii?Q?K/6uOU1P1Z/+zpow0j4mbnkMjUGPQOIxjubSHeQC3/r5krL1fyK0IMRC2kNK?=
 =?us-ascii?Q?+iCakLoqxgSuTf2MQCAZxWwLPLLEW3+e1j5x+jXdOz2qjFnhzJsILplU0Pnw?=
 =?us-ascii?Q?9vrujVUNqr61lq9EGfgzf3wjOKWkN1VXrMPVLettPNv1NXygSbLrGGkR8G7J?=
 =?us-ascii?Q?T7aWqu4Ax82SbVGXvfpuwu3sRo6Ara1/noT0o/BvGPzt9BbH+odyUs4votIf?=
 =?us-ascii?Q?IQIUe812zX2z2nnrueT0WCe9jDE2XE25CKDTZqnd1uC7pvAgdGQEw/I0Piyy?=
 =?us-ascii?Q?46sxuThTPTJUycPV36Lic5IdPuJ+SY8fdympkZfeYE7iOnb8GNC5KeFjid2A?=
 =?us-ascii?Q?/g7ALtGkKBZ6CBq3VqH6kZzix+gR2/CJycE3Tw7Zw5zhefBKR3Y/LPEqpj7Z?=
 =?us-ascii?Q?8zpYedVM2Wah9PumFZSJ1f4A08zdChiMGnDlkdw0pKrj4+COAsS9yqBLkBn2?=
 =?us-ascii?Q?hnafhd4JyUr5/qC6aBnG5s3b0pYVF7Mb2QBAAj1G0LULCBSo0h2jDgVNVW7x?=
 =?us-ascii?Q?3E/lq16ZW2aEDmJIhS/gFTF4w0DZfyM3tw5HsXf2yuytiABdp+dXBAb7xQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2025 08:09:12.1907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dda8e9-5c86-4098-6dd3-08ddede5d467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041

ndo hwtstamp callbacks are expected to run under the per-device ops
lock. Make the lower get/set paths consistent with the rest of ndo
invocations.

Kernel log:
WARNING: CPU: 13 PID: 51364 at ./include/net/netdev_lock.h:70 __netdev_update_features+0x4bd/0xe60
...
RIP: 0010:__netdev_update_features+0x4bd/0xe60
...
Call Trace:
<TASK>
netdev_update_features+0x1f/0x60
mlx5_hwtstamp_set+0x181/0x290 [mlx5_core]
mlx5e_hwtstamp_set+0x19/0x30 [mlx5_core]
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp_phylib+0x9f/0x220
dev_set_hwtstamp+0x13d/0x240
dev_ioctl+0x12f/0x4b0
sock_ioctl+0x171/0x370
__x64_sys_ioctl+0x3f7/0x900
? __sys_setsockopt+0x69/0xb0
do_syscall_64+0x6f/0x2e0
entry_SYSCALL_64_after_hwframe+0x4b/0x53
...
</TASK>
....
---[ end trace 0000000000000000 ]---

Note that the mlx5_hwtstamp_set and mlx5e_hwtstamp_set functions shown
in the trace come from an in progress patch converting the legacy ioctl
to ndo_hwtstamp_get/set and are not present in mainline.

Fixes: ffb7ed19ac0a ("net: hold netdev instance lock during ioctl operations")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

---
 V2:
  - Clarify in the commit message that mlx5 functions from the trace
    are not present in mainline.
  - Link to V1: https://lore.kernel.org/netdev/20250904182806.2329996-1-cjubran@nvidia.com/
---
 net/core/dev_ioctl.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 9c0ad7f4b5d8..ad54b12d4b4c 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -464,8 +464,15 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_get)
-		return dev_get_hwtstamp_phylib(dev, kernel_cfg);
+	if (ops->ndo_hwtstamp_get) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_get_hwtstamp_phylib(dev, kernel_cfg);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
@@ -481,8 +488,15 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 	if (!netif_device_present(dev))
 		return -ENODEV;
 
-	if (ops->ndo_hwtstamp_set)
-		return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+	if (ops->ndo_hwtstamp_set) {
+		int err;
+
+		netdev_lock_ops(dev);
+		err = dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
+		netdev_unlock_ops(dev);
+
+		return err;
+	}
 
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
-- 
2.38.1


