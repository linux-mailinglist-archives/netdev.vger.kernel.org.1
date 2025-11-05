Return-Path: <netdev+bounces-236072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6DDC3839F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 23:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0A6E4E8161
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 22:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411DF224B05;
	Wed,  5 Nov 2025 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RMmAXY2H"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DE2F363F
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382708; cv=fail; b=gFfD+GlY6rNzZhJwQKK7Dk96Gluilkz6h1AnAJaLF3pwS2qx6cLTvF1YGTSta64PZ5K5cxjsYiCaJ81R+LauG/PBJfFT8uCp7lcTwQXYdY1ihxX4omjMmQM2AK+A9D74rikvNmv4ygzHHpOyLfSgXdOg8Md0Bm8t6JPPlHfZv1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382708; c=relaxed/simple;
	bh=Dc8533Aff9TqwV9HN1L7Ofat7h1bz9pH7F7w87LDzMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+phyfXoOV+XIsXcYEzSbzYYSfz39j66tUl4c3mMoKH4WRod4W5BhLtbS5vhGsC+tDPXeTPPdfRMWAs7Q8D+QBmEh/1olAd50W1Z62GZja7uYB9d60TdMMbVZQTicxfnWcYrOfy9pr7aiqw/DEE1Q85KxD54UnEwSy0nc2BPu+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RMmAXY2H; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE/Wf//HdXhPd8tNP9ajpPDFSYZhjO83jPIXd+AIDAeqJH2ScgvHisuwtuC6La5u2L5cs9UdeEQiQx4E89iSjQcW5Ia0urOWuFg05QxLxf2XdctBHMC/k+ECYA4i3b9/ySdATofRVpvJTOTG2M00EE4rB4Zf9DmsVIopx618BsYcEUsim6ltoX13218F2A4UHuvBOw4257g/lhhJLyKdDBcKsZgLawcqVuvso6mHcycBjYszgYKcZ36EDHG1vHgzcgaidLFsQyHQkF6/N/0lQgcWDaaY+xhPyPFVs4n9VBrQgFYLp2sH8DI7n4UKZJl5d6kOifPAEH4ScUIbmoLGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=RkDlSk5XGkN4+7tOEilMBkAusdev32DUS8YPpfPbPxE2TU/23bMPa8IAvbT4iN/7H4YDN9UpSeGugCEkzE+Pfb7rRrLH/hEAccH9x+bEKuInDB9PyUPxTFLAk1RpRTvc03Hv8lmyyLggiHaX3M7zyFUMvsnDJPoCF0OfTUq2WOqC0k6rpMsPHQA6Ddauk5YM854pxF9nUV/eGVVg/zBmf0Xi+4FamGueDC/3BvRRQv+upf9TCvmqRVSNQp5IHNYaNtjp7Jy/tokn/fHLhqov6G0gv6iowEzz17UaVrGRs7Ri1msk+Rrr4MaYXn3IPMDXhA/5yIp5QZMiEN7L02/EEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=RMmAXY2Hkq9auToPBy9yT2LTuXmAvsIr6jZt8UA0Ma9KzaLNOPmbUAP7T7V9dki5DRQSErqDmguF4+zv5prvBhgN7C3tCYI7gBksCt01B8CivkF2pnzEPHMKrYuM5YaLZDDfT3l3myUi3oPI/qbrJYaRfv/IBWxAyP/sXC4MLIx0ibvfm4BaEuxgUeOkIYuZnqEjb0uoSPcMu3JzJj4EvsE2j8y2J+kWDrKUpI1T9puvoDyIbr9EL6HIE6XrsXsH+2pNt5ORNZcA1g6JDT6U38OzwACRPnbnPiwTnPTW5Jm/fTb9t3US/Y9v55QlwZS6RMJzsedAPWq452rBJKLrvg==
Received: from BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::33)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.18; Wed, 5 Nov
 2025 22:44:58 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::90) by BL1P221CA0007.outlook.office365.com
 (2603:10b6:208:2c5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 22:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 22:44:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:38 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 14:44:37 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 5 Nov
 2025 14:44:36 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v8 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 5 Nov 2025 16:43:45 -0600
Message-ID: <20251105224356.4234-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251105224356.4234-1-danielj@nvidia.com>
References: <20251105224356.4234-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e328294-c495-499d-d1ee-08de1cbcf2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNi6qVNDDOGZgW59GQ+7eDFGGdHsjsVuQs5mz2ZfbnkQpzK8N2hc1uhWCeRy?=
 =?us-ascii?Q?uNsfT0VJ2LfR5A486TCwv3bZUX09YWwL8lKJ+SEJLiZ4STf/DrRekro2MeIr?=
 =?us-ascii?Q?/A1K2IYskOauu/AaSfC7U9b+vy2nVLcE67g3XvQ7+i5UelB/Q61N9+Q+s32c?=
 =?us-ascii?Q?82/LHNLIkrYBqOoDC+5zLICgXWmUU9zM02xfUeK1pMDt2TbwZGi0PkC75Nfg?=
 =?us-ascii?Q?Fi4fUf4PcBuobfPq5VbBV8a5ni+thxIVucA4ZFpYLmKkCNeUrjtf3LnTqXrP?=
 =?us-ascii?Q?3EP+3XS5lT93SKPI8L3OQr3/OEkyJguf4BIyIrBtmKPmv9M+Kj3pKyKBo4aJ?=
 =?us-ascii?Q?B1YEawvnDX940CTYwnH39nkoH4u00l1bxfRCLfrpiC+fTVwPPVSbErTh5pcG?=
 =?us-ascii?Q?ZcjY0r3URC/zAis5zx7z/Sg7h7McwCh4TGTtxYM8az0TzkIuioaxeoYJngHJ?=
 =?us-ascii?Q?eQUz2rYujnPpQmFuHU/vaaT7F9bbp6GGzw06KqUxBfESUlTvylQe241O5s7o?=
 =?us-ascii?Q?LZ0L2BByccui/Od9akqkdf5z5vxRreCJshIeEphAP/ReRZDtYRwv04RJ5t+R?=
 =?us-ascii?Q?dMTfjGNB93w0Qgj9kblD1pOD2E0199Hm8cBhmC8I8SwxFHrDJ0hF9h2Wyxxm?=
 =?us-ascii?Q?2pO5zZg4SzlLKzexHO1twYcJ2GNinwy4iIOPpeYU9PRygNOlAzWNt2PPPXwc?=
 =?us-ascii?Q?uXw1L7TUSnoEvWr+T8jjiJ+h1zlLRNag6ch5DXi6++xevORHI6CcQjAX6wbr?=
 =?us-ascii?Q?MZruO1aMw1i7jMgniNzku6DjAbxdKWkuR1f8y9Ss/oAzHvctUCx58383zpfC?=
 =?us-ascii?Q?D9Gy2geGKzOFtJpMpJZ8/et7bY7vq6WZZyLCrqr/LGS66Nrd+k08R+2pqtAF?=
 =?us-ascii?Q?oWTvddqlqlGfP90pYTVJApB7rInanar4Oz1X48c9iQHj96gxBJjgGdSXPshm?=
 =?us-ascii?Q?bN1Svvt50VubstcS/ojMD0Tk78bScJbLXPtvrlD0DQ4LL0JNVgb+oMTJrl0q?=
 =?us-ascii?Q?PkPjiDsRebRkcoY8OHZ4LslSOt13Hr/l7cAIFqrJ+vJ+WGhkXvGFIGUJQCIh?=
 =?us-ascii?Q?4D9WCG6SPfE8qLgBmQxbJOZE+Cp3MPlOuk0BaQfLuW8FKcSBc5J66P9rLM9P?=
 =?us-ascii?Q?/XQqYu/LltkUJaLHbKL4HMMmZoTiXViXsLaFnuWNJANcLIKyZ2WDXRf1Jgoo?=
 =?us-ascii?Q?wxUlXPIVGIySFunjbp7iJ4DUC0EwQQHL6AHvYXuNXsrDQ0ie0I0ij6ARZ+BG?=
 =?us-ascii?Q?l6PYEPlQWQc54/s6vLs+oFjmg5lCg2etFQVkJQRI64kAAC6Y71sqxV1BLATi?=
 =?us-ascii?Q?oipZrxf9kgbxm22qYwrCMLqYF7GolJPb4zqYt1wCuoVtyh9tSV5dKfX1dC8P?=
 =?us-ascii?Q?kyM7lM139fwwWkfWive19kv+Na7OlqfP+9+vHo5b3AHg7et7mgCZCO4XyB5a?=
 =?us-ascii?Q?XONkQWlfnpb7pQQmZpsPGd8Ba5hlEGZdae6wuvsTnxZMB27yKthdfO3/QV3s?=
 =?us-ascii?Q?IiWhxHbR/LuHdJoDBfpXsL98pogHBEYNFsvBUZ7od8dzwWHFSL6DyMgvcVHy?=
 =?us-ascii?Q?OpO1ckxhV2Y2KZHLBQI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:44:58.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e328294-c495-499d-d1ee-08de1cbcf2a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for V4
v5:
   - support_caps -> supported_caps (Alok Tiwari)
   - removed unused variable (test robot)
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_modern.c | 8 +-------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 8cd01de27baf..fc26e035e7a6 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -48,7 +48,6 @@ struct virtio_pci_admin_vq {
 	/* Protects virtqueue access. */
 	spinlock_t lock;
 	u64 supported_cmds;
-	u64 supported_caps;
 	u8 max_dev_parts_objects;
 	struct ida dev_parts_ida;
 	/* Name of the admin queue: avq.$vq_index. */
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index dd0e65f71d41..ff11de5b3d69 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -304,7 +304,6 @@ virtio_pci_admin_cmd_dev_parts_objects_enable(struct virtio_device *virtio_dev)
 
 static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(virtio_dev);
 	struct virtio_admin_cmd_query_cap_id_result *data;
 	struct virtio_admin_cmd cmd = {};
 	struct scatterlist result_sg;
@@ -323,12 +322,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(le64_to_cpu(data->supported_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


