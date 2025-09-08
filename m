Return-Path: <netdev+bounces-220886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE9B4960C
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9CB7B0153
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F9312801;
	Mon,  8 Sep 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lNjDcUmG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C50310771
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349796; cv=fail; b=HeJLXCCyoikYmDA6yyJfwoBWaih1I6HooywkCir2SyE/7wXHTFTSbZz+RW18gIrcTDgD1CKCYjLZNsSIcF5yzLLV3URVoe12G+F9Jy2wtHWXpvWzsuJwttkC3fJkTmClxnO4J2UhQjA4yrzsgly9FGL/i0Eki/ok+DwpehUbgIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349796; c=relaxed/simple;
	bh=29fscds7xBMppwDyeB+aI6Q3QscQBm6Agt95KWZ/N4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhyLwmA5x74vGqf/ttcRD/fpYmuj7rRF1X0R20FLfV9e8jWbRfJ7WZ6DAjd2gKk+FFjJ3CVlkc4cEn1QYH77ZGPw3tmdAAzMqvtBG+l6KSGbcWZiKCaWeKT/yut//vJwyigWDhn3NmpvGJLLNxqa1KkZ2Nbhzj+cX6NnoPKlr70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lNjDcUmG; arc=fail smtp.client-ip=40.107.220.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9tIu2u65DEpToG6hcLNsqeiMXsD6jJSdgoOWozN+beC9xKUNBVu2v2dWTahQ5poa2hM/J1MLRZs3UVyFkdvxeYwZWMqKGDStGF1Bw/tWrMY3L11lfMa/XY+v5YWNCVh++1qEn6MEL0JoyYajPeEaugtFfPMSD2MvyWBzUkJD1GNqn+2962mIoFW4QP04XOfyr9Aah12IXkYP7es1z1Ce1SdrWMOXEAGHPf2UN6c9H+OCsouucDgjDYAa3RyOU84Z700x7430GQ3e+cVjNRqmPIhkQXye2y3W2y6gJ3GycyJD9wkJJsiiF2rKjRaHnVqn+SE21e2RWrogMvRku1WEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64GY4G6M7D6Te8AVUcTBuRvjSKww7S0DD0tc1VxHLNw=;
 b=I4eqml9J1sgaPC6LRWzEv4q51bRxWqyL0MLUSmj+0AZgVsh6Hl8vPWSSML/pQG5/sCm1BGScbNhpN6M4rdk63AXLIWJqNgFatHtc90qJ8Hj67UfNVH1q57OGwXiM3/pcoIwR0N3wiq3O4J4GwxesZ1ZNt4omdpGWak3mu/w0C6rNiJ8bGvPUyV0KY2DiAwqrwPnCHy6WTtKCAivErs216F2/vMqqF4FZvzIPe6hm9tL085DArwD/UubY16OvPaFrLMXcL+vajSwpvwpMzcoDwBvH0uLtsRL0c/piT4EzYNnUsrecTwKwA1/HW2z/Qe5sXSB9kCRvGXVrpf2maFTDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64GY4G6M7D6Te8AVUcTBuRvjSKww7S0DD0tc1VxHLNw=;
 b=lNjDcUmGXh/He/SZfnyF4tMHNn4j9DESZKJOPO9I5xM2gnPPsuREp3T7YeNaojK6E9UInKHsIXyVxvYuDe90DZkEyVcC9nsHLKezH/xDGrq4NirriDnstsAQNvh2heouSjs620F3SRTuh2fAd1rXCaKxfIWoNghaozp7E/bMzesW3TN3iPSoQL7w7pSjaWVIeL/UAZYuEsnLiG4mFPwzBE0FhBIQbAatQfoUdS4LYfJUCcw+Vrvk8Q/IYuRkedeUf+KOdu9UC4iIoV6KqMVAZxG3jrj8WGkMmKDpWsFzm3txfdkT9TNeBj8PDk1PVGP4n7QPB5r0v5K9UOhhS24Z1Q==
Received: from BYAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:a02:a8::43)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:11 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::a8) by BYAPR03CA0030.outlook.office365.com
 (2603:10b6:a02:a8::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:39 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:38 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 05/11] virtio_net: Create a FF group for ethtool steering
Date: Mon, 8 Sep 2025 11:40:40 -0500
Message-ID: <20250908164046.25051-6-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 2410e27f-4d0c-477b-5b4c-08ddeef6cb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fN1W7VZJUjz2V/rmVdcZTTg+8kWraAwmGvFjQClZ8rnCLvxrAAzU/M/CPQ4p?=
 =?us-ascii?Q?eqiPgRsBHGcFCdXY5QElLc8R/7B9MxoswG3zVK7wN+mU7AWVhSFKgvsUsrX2?=
 =?us-ascii?Q?vOMgCOXxXk5CPl+mCaDatyqTeO2IwlMGGniWRM3mXjf+/uYEZHcYYhsomKFN?=
 =?us-ascii?Q?11Y237vENlK66iSVs/Sl5LIdG3gc0rcllC+WweSSoS5+RVgkQV49nZlKlM4b?=
 =?us-ascii?Q?syLF+BrfU9vY2bHvaS3kF0wRDBRGTieyMksf9evW/5CAalldjhpGCT4bglLy?=
 =?us-ascii?Q?ZKRNExIufxxmnlFsnIa5ZpxqEeUw4RLrLI/XuEJ56288QsnczS1TW56b6rzX?=
 =?us-ascii?Q?f/HYf0VbhWPVzyCIZPINEhCIMIf/RoXBuDJBjNwMXICRX2IwUVHMR9I5utWB?=
 =?us-ascii?Q?I8LWF26d9cUpOnwEa3ZoHrS4dAayRTpulnY7hLJgonK2vpFcoyvvk76qtgI2?=
 =?us-ascii?Q?/ryAAlLQQJKzbfb8XUCXmem23fuhm3RKG33i1xmgWBsA7FPZu/s+qzlxmyF7?=
 =?us-ascii?Q?lgvyBDaIw1bZ87NIX5F/PiLFIwA5xtdP+1FwaYiCEIwq0F0QAuYO+edBa5tB?=
 =?us-ascii?Q?/FS14Ht12IWVdaFJ3VUoxGpS3mJj+sUEhtLN7T3qBOHvke3dfSOzTSPNmIei?=
 =?us-ascii?Q?SU3itDdbar6uMghU6K0Vb+8MDzh95PiZ6mT8v+3RK5pr2x96OV4qCiPcWRJa?=
 =?us-ascii?Q?hYfx2Y50J2z3OtLy5+mlsiAgoOm8UCukLD4iY61qu9Eq0TPr3jrj9RkMavi7?=
 =?us-ascii?Q?eDZuB7fPcgm91BrfjTPbRAbn6eMgB5cD8e0/IPyTy1yMHrXcAmiHHTEr6ogj?=
 =?us-ascii?Q?ZLrGl3KHUpFRObozejqx14jVxa3dJnKzmyiNI4oe0IYJA57CL9qRtjvE6zQc?=
 =?us-ascii?Q?g+etiYWj7kP3WVdeS7hBxDoYshOnd4Or9fhvG/3y5WZeEJYcK9kYB/igG6cR?=
 =?us-ascii?Q?oRXGUKm51f6Fse73l3Ejzk4VureRjumQcOWJOxuLakzi20WJuTX5JUpON3lu?=
 =?us-ascii?Q?PMlukhOiw5zYLgIXaU0nmpE90dLaa7ovDUmXDx4SV81o+j0/agxJmc7edGPs?=
 =?us-ascii?Q?ahNG+e46fkpbOhbt17WcAHgjGAPcvzGay73DZL4FsqOFD0tDBjxbAiju5okm?=
 =?us-ascii?Q?TJkTbKz+3VXzqGgH1B6H9bEHMLGD98HyEf6EC3WU2d0wQR6ISJ+ucIHh3bvh?=
 =?us-ascii?Q?yHiIx88otViQEapPIgmnOk6RKJ0hmoYIXGojNBBpCbtF5n55uMAbnYnBQJei?=
 =?us-ascii?Q?FMrcOTsqbaobBAPKdUQDlzxXuZzrqLX24JY2EEsnvwxDRk/1ElCe4QkmwnMF?=
 =?us-ascii?Q?r3V3Wwa8zMvY67YvzfLB7mcoyeVftM0/ZQeCeSe4YBZAm4wDPdMaolT4UHbT?=
 =?us-ascii?Q?1ds+bnkIkONwpLhaEMaTjjl0A9S2fg+1U4xGSzEjTdMEFcfChftdv7Qc3R5a?=
 =?us-ascii?Q?vSQiqW9Oc2glVxczsNaewfCGEo5mIJDLZIqabnd2u8Zpv56vOUOxaYk/GttJ?=
 =?us-ascii?Q?dz3YL86/PjR7GHDO94DC2+EJPMXTlCm7ZVQP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:09.9889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2410e27f-4d0c-477b-5b4c-08ddeef6cb8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

All ethtool steering rules will go in one group, create it during
initialization.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

---
v2: fix sparse warnings
---
 drivers/net/virtio_net/virtio_net_ff.c | 25 +++++++++++++++++++++++++
 include/uapi/linux/virtio_net_ff.h     |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index 61cb45331c97..0036c2db9f77 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -6,6 +6,9 @@
 #include <net/ip.h>
 #include "virtio_net_ff.h"
 
+#define VIRTNET_FF_ETHTOOL_GROUP_PRIORITY 1
+#define VIRTNET_FF_MAX_GROUPS 1
+
 static size_t get_mask_size(u16 type)
 {
 	switch (type) {
@@ -30,6 +33,7 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	size_t ff_mask_size = sizeof(struct virtio_net_ff_cap_mask_data) +
 			      sizeof(struct virtio_net_ff_selector) *
 			      VIRTIO_NET_FF_MASK_TYPE_MAX;
+	struct virtio_net_resource_obj_ff_group ethtool_group = {};
 	struct virtio_net_ff_selector *sel;
 	int err;
 	int i;
@@ -92,6 +96,12 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	if (le32_to_cpu(ff->ff_caps->groups_limit) < VIRTNET_FF_MAX_GROUPS) {
+		err = -ENOSPC;
+		goto err_ff_action;
+	}
+	ff->ff_caps->groups_limit = cpu_to_le32(VIRTNET_FF_MAX_GROUPS);
+
 	err = virtio_device_cap_set(vdev,
 				    VIRTIO_NET_FF_RESOURCE_CAP,
 				    ff->ff_caps,
@@ -121,6 +131,17 @@ void virtnet_ff_init(struct virtnet_ff *ff, struct virtio_device *vdev)
 	if (err)
 		goto err_ff_action;
 
+	ethtool_group.group_priority = cpu_to_le16(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
+	/* Use priority for the object ID. */
+	err = virtio_device_object_create(vdev,
+					  VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+					  VIRTNET_FF_ETHTOOL_GROUP_PRIORITY,
+					  &ethtool_group,
+					  sizeof(ethtool_group));
+	if (err)
+		goto err_ff_action;
+
 	ff->vdev = vdev;
 	ff->ff_supported = true;
 
@@ -139,6 +160,10 @@ void virtnet_ff_cleanup(struct virtnet_ff *ff)
 	if (!ff->ff_supported)
 		return;
 
+	virtio_device_object_destroy(ff->vdev,
+				     VIRTIO_NET_RESOURCE_OBJ_FF_GROUP,
+				     VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
+
 	kfree(ff->ff_actions);
 	kfree(ff->ff_mask);
 	kfree(ff->ff_caps);
diff --git a/include/uapi/linux/virtio_net_ff.h b/include/uapi/linux/virtio_net_ff.h
index a35533bf8377..662693e1fefd 100644
--- a/include/uapi/linux/virtio_net_ff.h
+++ b/include/uapi/linux/virtio_net_ff.h
@@ -12,6 +12,8 @@
 #define VIRTIO_NET_FF_SELECTOR_CAP 0x801
 #define VIRTIO_NET_FF_ACTION_CAP 0x802
 
+#define VIRTIO_NET_RESOURCE_OBJ_FF_GROUP 0x0200
+
 struct virtio_net_ff_cap_data {
 	__le32 groups_limit;
 	__le32 classifiers_limit;
@@ -52,4 +54,9 @@ struct virtio_net_ff_actions {
 	__u8 reserved[7];
 	__u8 actions[];
 };
+
+struct virtio_net_resource_obj_ff_group {
+	__le16 group_priority;
+};
+
 #endif
-- 
2.50.1


