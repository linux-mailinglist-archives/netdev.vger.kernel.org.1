Return-Path: <netdev+bounces-233268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD57CC0FB68
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5113B461191
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB921317715;
	Mon, 27 Oct 2025 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZyrVn9id"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011042.outbound.protection.outlook.com [52.101.52.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454930BBA2
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586837; cv=fail; b=PBRZ9vDGo8zh5Eo3Ohn1pf1ZCzl/ukwozY66bWu6PSeMD8Qf/UXlhahKMV6CepjAOxjgWXTbOV4X3eDCgvk0GXNMiR9OfYFifUHna9wY6WpRs2cJEr+4tE6B17/gu/v2NDwmKZbkWOk0ydpYUvtpJvikP+qD6Pj4iFctvG0/Erg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586837; c=relaxed/simple;
	bh=1mIcvDPVO9nCDb+6T2VRbZXLCptICuyljMqPLfQ4pV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXi6necSJ7jNxOTBtMSeVhYopYEQQ07aR6F6koTV5SOeZ2Jc5LwvF3/PzHJL7pPj91rd/CF+tZXjQyy/KBKi3i10ofARqBhVdCYAaq+kLLi2eMsN8VMUHGZ5W0fuKxbAk9gUM9p7gIWRPGZ+TEMHZ7C6AUD6AExt1SH+CL5o9hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZyrVn9id; arc=fail smtp.client-ip=52.101.52.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaaPifKcgqMshj/fYkmJRdQxWo9YbOAUhaEsP/I19YYMvsP3LFRYc1aNJ2aZOh8laJ5fXaNXWsWoUvM1mjCmkBa+pm7eJNlK3jzbY+ugNx3XG5yDvA5woICtgITsGylJJcaEZGhNkYuVUE3REKdWaeUOvah+gcb7UeDhlxV+BWwnDJErj6Jfqlf9/i0JNq2mDUeXhsaPDS+Q+k0oKNRpiSupdebv3KhiH2sHiihxXeIrcxZZ8wyHB38KTf5gWKrNYDRM5tEXDFG5uyg2REw97TYyispxJonWT2aqdwQ12aLV5rug/tlzX3CcfrcxXdFrza8AsLMTE09li+HsO4j18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReFK+T1og78D/4ekxSobvz0vZ9cr+0l4HOS7+uN0zeM=;
 b=pcWPe9LlA0yWtBhjZdKWw4N6EqH53Y8jk3rSjWoXy9zukrdXnflHnlAgrkHkTe4fZSDrcgU2Lv1JDJZAkQB1sNFhFDzcvXVeilxvOuqB0FA/KJQNIPkL+qKINRcXlzRCgL16JaiAzc41UWLYHr9fyBJZr7lUbyPVyqT3NmMIrscv/1R2y11FRa1LRXI8phxBwgZ38jzJZaETs/2LZ3cKgTVU4luCWmgwN/u4C8jboapDBf2SVaANZK8Azunr8OgjIFb6dN4L+keND+2yeUzc2Bta10Hdi9djMHaifCLpM47MA2eUekzaC49O5qePLGmw6zsOiIwR7CsyDaaAH2iAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReFK+T1og78D/4ekxSobvz0vZ9cr+0l4HOS7+uN0zeM=;
 b=ZyrVn9idSostJ0MysSF/ywSMxyCEt4/UDX6c3oUIBUeqPW46e9ME1AHC11hakjlFnqCrw54oBaR+DNjsf3uUMhc3elx0965NExUNjEXyI7SAw0EKNTL8gWQ6kedWSUNyrBynkLA160PXQ2zzWcggRFuO9LDFPIOsg3EaP4idGmhdiwslAW1VswlML4+pzJJCHSa0VbSrm8QMpf+lMLs6c5vIXURGtQGb9Qr0/dvhXFcS1ZLs0IX4C0gR0OgTud831YJabUAMF+iRCvDcty2lCNe9pDaaSZR8S+PxIjmkP6sIHyYolwFRqdwM0NLT01NUKnUzVi0GBcLRs/jKqn3RaA==
Received: from CH2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:610:5a::18)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:40:33 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::67) by CH2PR08CA0008.outlook.office365.com
 (2603:10b6:610:5a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 17:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 17:40:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 10:40:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Oct
 2025 10:40:04 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Oct 2025 10:40:03 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v6 01/12] virtio_pci: Remove supported_cap size build assert
Date: Mon, 27 Oct 2025 12:39:46 -0500
Message-ID: <20251027173957.2334-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251027173957.2334-1-danielj@nvidia.com>
References: <20251027173957.2334-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9118f59a-9fa3-4c9f-7d0d-08de157fee47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wRDcZX/pzndPTfpHN81OKnVbRj8dLQeDBhZvnWVBBiG87sPqvvBsFSv62olR?=
 =?us-ascii?Q?MNBIUaQLBiC+/ueeaSezFD8SJqu1YKrT/ewwBoo7kGPvvRg3qnp/TvIu4JD0?=
 =?us-ascii?Q?EWlUFM6GlsOM2SCv6+XUX4wRhuLZM5wJPSPxeTz7n5Hvsx3TAAyaTm+y1FzP?=
 =?us-ascii?Q?dlP+iXLPxI3UZBxYt01w2jnwZCHUvi2Mza558YFG7WwSK38Aw3sMdcjuh7/6?=
 =?us-ascii?Q?ENu8UvSpWCbIiEVCczBhebX28WMADAjvFfbiJ0Uy8pT6j4l0kQBoXzpV0SRr?=
 =?us-ascii?Q?b1YM+lyAJoTII80Pt0tevlDDaxL7tbg8SltEIbwz1QKNSW7Z7bktjSxUKpzA?=
 =?us-ascii?Q?QvRWRTEgG76uoLO//9pywIh99hw1PZJYf6vqGbGKCaH37kN5+06nftcx9fFp?=
 =?us-ascii?Q?3WcUj99XRz5ATiiDOAPzCqQjgW+0wlqFKJC8rYyOfBPmFwBU5F1nHiZT2NNy?=
 =?us-ascii?Q?Q5gsc1HvLmYLH0R1dZvXCVA4nzZnqKRj5qEl5MYCy2k+BqPCQJKoWtv04vIN?=
 =?us-ascii?Q?ZAYYXWDw2fRxo2vfL3Nv8oXstW/M1wm04kIJNdGdAAyT/1srSZ9qM9ENfG4i?=
 =?us-ascii?Q?JNwdWsM831tzbdiEXSDMSaqoYiipr8TG4lIaClmoKXFFXLLjGAzrikNP1RBr?=
 =?us-ascii?Q?4wn29qNPKnzhLWHfG84CC1lvlPLfxksK48VEyDRQSruop3z/WMt/+EydnRxb?=
 =?us-ascii?Q?w99zWU3qiqtmhn6X8qHH/tCBBbH6bUkvPhwWozWHfWZiW/3UWlfuRh5ZXrU9?=
 =?us-ascii?Q?NCtNpH6XcH/ui+2X3E9P/8WC/weu6CslAK8UQSxneCAOiqqlaErC+TYw7LqN?=
 =?us-ascii?Q?nvH3WFZoI/4+bE3/7V+2vkXkwmax6LNemx/Ds8wDFvEIPLCRfiLzl1LNUAJ/?=
 =?us-ascii?Q?R7giFIF8b1DYeZB/X2FaKJSup7F+UygkNOrU0BioisrGjKgkK7j6UYgv/kAf?=
 =?us-ascii?Q?TU/LNjqfRW6GKMuBej9IP0eerImCAs6APo5bmhsyTT242ktzP3IFD7t1h11+?=
 =?us-ascii?Q?cFA9F7r7JZ3x2OmgJLZQwbSx030ymh0OZ5ea2R0FAivlhZQryN464yLfhR8i?=
 =?us-ascii?Q?7Wynf4fj+Qur+QhfSAzCJ6maCfpuvxOhXpqntqfKcIZDZKOfMNvWil/l9HcM?=
 =?us-ascii?Q?xYdF7BpHEB2xD7QNTUrTIJxQFA17stasir2iHxkWjT9ZeRplXRdF3X5Ex7hV?=
 =?us-ascii?Q?GhoMO0pYzXdLG6WFge6RWRDiyPMt06WMMi1q9FKjwWdV2kbmhIjbG7Drqoju?=
 =?us-ascii?Q?LjdQ4oTC77krqWxebtarvFrkRD2fMeL5b+q9FSMcTeurlH5lwKeLT7lw/jO+?=
 =?us-ascii?Q?+G1laA51quqqHd356E3etzlFI6/vMoChjrrDivE93jffW3nOe1RU9t/zN3Rt?=
 =?us-ascii?Q?XjUwLYqoli/Rg5/aWv27yAnP1cLfcPAsMBj+SkU1iyHNvTajzEVqvpnluIWd?=
 =?us-ascii?Q?/CrpOFp0/E9cb6UzlIK8iacCqZxGkIWiFQjuXOD85H1XH3xQx2ygmQ+kCATW?=
 =?us-ascii?Q?Q3XV2G7iE3OhaI1ViIqPt+lhhAVFZ9gz4hvFFKK7rPv6jHOBFwy5eYD2J9cA?=
 =?us-ascii?Q?uvy+s3Y/RiTjhudU9Os=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:40:33.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9118f59a-9fa3-4c9f-7d0d-08de157fee47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

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


