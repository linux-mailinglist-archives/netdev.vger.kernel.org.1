Return-Path: <netdev+bounces-228823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E696BD496D
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA72483A07
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5530E821;
	Mon, 13 Oct 2025 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X+JRmSAo"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CB3191DB
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369291; cv=fail; b=asja0ED3xnKe3Qsst18EeFutiwl9P7Ixf4ZkSlMs83ba2STK5rWO8InBfY+kYgZb1K8R6DKTtY/DZKqdTsIrMgzJ5fb+ynDkcPkiO5JFGVH+NJxn0SX2j/pLN91Ky6ezLmbeEzmIwkovnZ9kvOrY25GEroDQYp8UqOhcvmZIMV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369291; c=relaxed/simple;
	bh=J+/VwmnrWPY9XSSQ+ttEMZ5czyyU0vDHxdXbDhNGOUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CelRMyrqZ0o1hdonWDQwTIlFTIN/3Kxcn78lVIQH9LXIXrmePwJetzEocZJr2/FF7AE9felbgYXcZe+riFR6fTBT/eFNFovcwO6/TsHpx8B78GiqwMJvkWgwJJZFXmP0ojscn2sgLXNmx4GRwnwbNZu0fPmbT10ds9kTvyG8oVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X+JRmSAo; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW+L38655YUiYmrZ9S1mR09UlSak2mzwSfuEqyo6qKAj6mfoH/8Os4nMXoXlYDDWiGakgOS0AY+v5qibHMAtb/ePmHm+uP8JcOkPhe9S2DDOGEs1Qp8F6qEw0GEMfFF68rlCIgYAJ72VF93iGiGk7mdpvbO42TKAgMzulOBAJEn37wtZ9KnPYJhRR2x5HKAGRrADkH1lXFJqcCGR6P1Y8tJnTfts+pNydhaveG6A5GmwZMYFhEIpHNPZSYV6ySNX/n8yyWoBHf9W5izFQoTmis4Y24h0yq/bljXBuHTSdyvqU5tIJRtFdXyG2g6aLJGswFOZOAwEhA8sIt2WNMwUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXBKxpfG5JH9pnxaA1e8DadKCPvTn0jRCdyMoEc/azs=;
 b=i2KmGnhDi1JqG/URCQet4YlqRR2NBxK/U4+xJxWwmPZYJps1PNq6XAsziU9TeMY8DApXw6MySwiU7OAGTEQHUrMUF9PPsrAMmgSsFHjPwCZVUpLquhnWF7+NCVh/klTFOVioNa6qglDLYtVWubKO2qEwWwMbi2KCR7GXhvA5IADCU1ccKzfaWtE9rxtLKDR/tVE0Pw9IbPnvmNGieKQQNNKEnnWak+eGLSko3+0HldX5/kUMKUMq+BUudxt3KkTc/nJo2u+Y0SmBhYuvz9sLJfv9Q1+YERE8P6JOgREMBKKoPo164lEzJIZoehcpePRT+3sdGc3Z+BXnmN3Igc/vtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXBKxpfG5JH9pnxaA1e8DadKCPvTn0jRCdyMoEc/azs=;
 b=X+JRmSAok5aLiiXDp/ziQ9M7B8OSGmrq1+Eh2y90DLJmIZjnNKDeSSWmV+p68oDl2N9g04idQBO/RAbOqiheD4aMCL4aTdzX0R9E43KY78E6feS/ypaURxg+U3BuW3WHV8Hu4tKWA5f3LOEIlcNADNKy3JrqAAul4WtBNSVlHCA9+RSLcYjtQZ+42dzYzrWcxj/poypPgrGvwEZw8YSbutom/W9deMQ/ooU4kARKkBtKb3cjYQvoE0ATPhFnoqCeWwIO1IdC5yIYMbJ7Nqz7cGq62iKnKleV7fcl/XetEHR0r6imLhuuIjGfKjPBK+ibof+/3mxp/pKFSptRfTABVQ==
Received: from DS7P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::20) by
 MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 15:28:06 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::29) by DS7P222CA0021.outlook.office365.com
 (2603:10b6:8:2e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 15:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 15:28:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 13 Oct
 2025 08:27:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 13 Oct 2025 08:27:56 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Oct 2025 08:27:55 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v4 01/12] virtio_pci: Remove supported_cap size build assert
Date: Mon, 13 Oct 2025 10:27:31 -0500
Message-ID: <20251013152742.619423-2-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 777ccfe4-d0c9-44e0-c692-08de0a6d1b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9LjzkgZlzFefZ2X/xiWKmwUGOePaHBBqjbtath9wnYG4ZScnU/GoOo5iDWQO?=
 =?us-ascii?Q?w+/TnHj6Gx2oqLiQ0Z3Zt/qsJZGTTwrILDgH1b4utJPQdhzl9X36SS+SWYMY?=
 =?us-ascii?Q?HK1Oiv5QF2rmhDaEz+2U/sd9Hjlrm6a+IdPBps1ehBwyjioPvZbxz9kmlDm4?=
 =?us-ascii?Q?fCH5nbkG1YqgRhvLuEdL+7UXer6yYk8cAJX66tHMV/mdHwdKe5wp6FOBKIvB?=
 =?us-ascii?Q?a+22VlOFRzQCZ+/UIok780sjveApuK3CSp62lmEAGOYgmP8VjSDkJecuylsi?=
 =?us-ascii?Q?1tKoOrbdzvtoxB6Ys33pDS50nU9UhmPKdAYw9Kpr5hWnBv51SxAHOWb9lpw+?=
 =?us-ascii?Q?6Fxoxss2mHG9HmRTaPqkHyDBu1ZOz84qvFe6/4kF5/ycVcPKp3wCI3lfcKDf?=
 =?us-ascii?Q?KZIXNK9ByeZ3wCayv3D9GRhLS3uygQw/RTC2Sr6iqmqOskdJSPb6HSHyw7Hs?=
 =?us-ascii?Q?C1dHvpSL5XQvfDL4gJN01tfXRH0mC6ykGqnLWM04NZtBrHGwHsJrtjLV5mkp?=
 =?us-ascii?Q?TccnYVLGSFU4CacQptZOQ/zuHYuDUlc61dEK87wpaMuzemFhfaNNRT11M49V?=
 =?us-ascii?Q?oUyfFhhz/4AkLiIWOa37oJ0xV2K7QMRExAFItEwZbGrZztp9JZy+QM+fIa2g?=
 =?us-ascii?Q?g9BRhGQSuQVk9MC8JD+qXm+kbZGClgTnk3xsMBbxszWIrai/C8X7vNuwTYPT?=
 =?us-ascii?Q?Wj294dxRcLnHMTrmWeOf673KjyjSCHGitpejYP3RICT50414P89YxTnMresA?=
 =?us-ascii?Q?vCPFGBPErW3RBhDoq5cRF4SY4OqyhTC4ghRMoWAEW4McZPgfS39a8/MwVKSJ?=
 =?us-ascii?Q?OcKKIidV6bOqzRN20hpdi/Ngp414D8JAtyROduWQDMGa5A45PR408P8B4iIc?=
 =?us-ascii?Q?leDiC9nQCHHuu8QUWmRJL6tphwZ4Qme7HwbcWGAKx+ZbBwResFWS3JymbfJ4?=
 =?us-ascii?Q?MLtxlXQGTZNx82caEEIHSdTA8imUSsej8tz0kSDrm64VS29nROW0DarEFyph?=
 =?us-ascii?Q?ZQgi8m6W83ilUH4y/lx9kyDzlU06mHLa46WOJNJTad6+7klSg+9uRRPiaXIj?=
 =?us-ascii?Q?V//iStXoN+HZREYCYE0wOkUk3mWqbTgK3f3QBy0QjXfyl50GWNIAtS+jdX/h?=
 =?us-ascii?Q?rkWohbffd7nN0qYbsFMes2PKjoWCWuD7CKkR7bYaWjtEokQwtC+ML4P4FQnB?=
 =?us-ascii?Q?8po+BqvI484tZuUCOSJAzVj3YBraZKJfIFTr6U5tp9btyYVAkqfT4vNGhePp?=
 =?us-ascii?Q?qquUS7RKxVt25iVFhMxyrGlaTcOTqHmaXoFtXElC6z+RYhTsUbnIJcdWY5Mh?=
 =?us-ascii?Q?W/ed22KCOotAAmbLSKRmfgnGUIOd98Nu8nFLLn9k7nSgnC1SLEPald6UBVW7?=
 =?us-ascii?Q?8mRMjPws4FgyMa2YbYQPHYIP9lDrTVjHRIrKAKRw8y2K16QGmRLttiMMQiGg?=
 =?us-ascii?Q?GWCGaKJhMJKvosqtaSa9VYxF/FNe7fjgetYlBuXF0IDnO6RXyWu0n/a/F53I?=
 =?us-ascii?Q?o4oJi1K1brQZscFaVSS18tx/uNNuq1ZTjaecGf7QQR6G2AZQgUxYcAVlhvAH?=
 =?us-ascii?Q?mE/JihFBUWAVuOvhbKM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 15:28:05.9612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 777ccfe4-d0c9-44e0-c692-08de0a6d1b6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222

The cap ID list can be more than 64 bits. Remove the build assert. Also
remove caching of the supported caps, it wasn't used.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>

---
v4: New patch for V4
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_modern.c | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

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
index dd0e65f71d41..810f9f636b5e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -323,12 +323,7 @@ static void virtio_pci_admin_cmd_cap_init(struct virtio_device *virtio_dev)
 	if (ret)
 		goto end;
 
-	/* Max number of caps fits into a single u64 */
-	BUILD_BUG_ON(sizeof(data->supported_caps) > sizeof(u64));
-
-	vp_dev->admin_vq.supported_caps = le64_to_cpu(data->supported_caps[0]);
-
-	if (!(vp_dev->admin_vq.supported_caps & (1 << VIRTIO_DEV_PARTS_CAP)))
+	if (!(le64_to_cpu(data->support_caps[0]) & (1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


