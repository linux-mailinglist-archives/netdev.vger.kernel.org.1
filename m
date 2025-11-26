Return-Path: <netdev+bounces-241999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9854C8B995
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6214E10FB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF2340A69;
	Wed, 26 Nov 2025 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+GXClyU"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FF433F8CF
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764185775; cv=fail; b=cRClAHb7vNDNIa8rztzvZYQ5tpD9UwlLnQsR77n5DM8TaxbPSwJ5dkLSfKkrL5eDSecKpuH+5ZPogRe/y9waD8MKXUq/YWmA2w2CCEyCoaLPYFvRaYazVJlIhN0QsKGNgET+8aww7+rT5RFL47Zvw6J2G/g3MwRHB7q6+g+CAD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764185775; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4OHU5GDOTyne6xCv1wAHzAh7ExEtFn4S3hxTEZhoLWyi7QMUboKF51b+fcqnYca6cIs5gm3K3r6vsTee6z3bQzH2JABxORNnO2y7ZARLTX+hIHW5GDFlgILlnma+o0Pby3dkShpQuN4U1KLsaebdr1W01OmFqMyBRo27LZ+/9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+GXClyU; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIRP0Y0A8NeiDuGfkrdiv8iUMINm2m3qs4BFuPZcaJXkiPP3lFgRVn0qSRrCBJDX8t/sc0uE+G8T1xUwY9rbd6l/VPJNYlcWtCO01sdX8mPwAkSbyMmwDn/uIpXrt/AkPj7Onl+FzIOxs9MLJ+SV2V7YH+6TRZv37g5RLX+sK11HSz7SBuYhlg6ylnE2IALnfCGupnuelErfT/+9k8j/Gromn1MoEz3N/JPRNgfRrnSGbEmDrGbLIcR4QDRBcQ+/JlojGL5sOjO2aNvu3ZUTkdE3SUtZTC+71V/OCXzJDq7kPaUba/g1fmKXV7ouMdCT2A234U0PN5mDXlBUa474JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=Owh+bIy1REZ3GI0ytzD6joIOpQCOhWEcJXt5Nd2uHs6ZoE7pg3UN3d+gICLHQsufRtM9CpjYe48OlB+UkB8QBEBfP5AfmBkq2uLdr+YKZ9K9eLRBRWHH2TIfNwvY7q71HwAS0BHljOgYITruh9nsnOSK16R6yvkPxu9aqpmStRXnkKgX4BwbQSHAs7NfAU37q4XAOrDKOvpx/qkL82fPP8nOV9s3PTvIyCZMxcwsptD2M/iUZCsfbxsOiEv/IyC8NO/fs12Z1fS3j4fyvGkUPfXV+YU3bXrLSE07ajSKNbAs4DrXZtvnv425oVPK7iP5MPrtQE6HXrxME+1GorURfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=W+GXClyUWluMEKwFKa+CSq1vHFw0fUe3VcZvHdZKQwFx34c9MvMo8tVkjQQRfQ//88xFZ7pjIZlTB292BMacy4skHgQJWrt/6p5+wpnJyl2wqbTv7iJQrAj7/41Vid4gg10OAPFBTJmNtpAukL4NVP/dMo3FPZnPtla5dwmZYLXU1anDNltzrQ6cKt8b61VRmx/+rA+3Dm/JLXyjYtz4+5b6KXIL/7+AowtI0mEtiKCRmK4cOmKJra+UKhbEoxALOVJBL5xuUDUfhv249xPpO3kWRuw+/tkCm402okZsL4lofydxbNMpX6Dj/IJZn0wKSf3hYUdPDFnCw5xBt7SkWw==
Received: from CH2PR05CA0040.namprd05.prod.outlook.com (2603:10b6:610:38::17)
 by SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 19:36:08 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::71) by CH2PR05CA0040.outlook.office365.com
 (2603:10b6:610:38::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 19:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 19:36:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 26 Nov
 2025 11:35:56 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 26 Nov 2025 11:35:56 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 26 Nov 2025 11:35:54 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v13 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 26 Nov 2025 13:35:28 -0600
Message-ID: <20251126193539.7791-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126193539.7791-1-danielj@nvidia.com>
References: <20251126193539.7791-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA3PR12MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cdf2e2-39a6-40a8-47ae-08de2d230c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CIywr2ynZcGjH9mf0Gm3tbArMxJfywJvPDhpiimZohSHGvpJvozkLEWo7ZPj?=
 =?us-ascii?Q?5SqphMKjuyr5lFZ6Sm8WB3W6myhR3TQuegfxQLndpHh/beF+zSk8/J9tfS/k?=
 =?us-ascii?Q?GZXca7znpeegj7hGCylirhYyR/Mo0FOt8hRyPn/fFnOcJdSXzB1tOZLxWAJu?=
 =?us-ascii?Q?D6WEjYH1iqwqwkGVlQGmTUv0l47ENgjMk0wO8xs7qw7t6PTp3Aqu6dAEYEF5?=
 =?us-ascii?Q?xcdXu+DR/Du+kNNTO6lpOrggX57ckrDKJkfj/J0OKrpw5u1WXK1hgDDcZErR?=
 =?us-ascii?Q?ScqsQaLLwbEU/XTOPrMzZNqP2FhxGVduhHOLMaMkLYcCsJEfGbPggZY2JhZg?=
 =?us-ascii?Q?+w3S8EL1BKCSOnJRjvr2iZZ+cenqsQqrQp/MtpOwbC5jLUYZdEj/TbA3x4sZ?=
 =?us-ascii?Q?hBiJ6NaRTAzazoDObSQr6SePuTRxXeZcHKWaHe5YBBKLBSk3oz7Ia9Hm7N6L?=
 =?us-ascii?Q?bIC1jmpK53kBVIhK7UuHNRDn3kALJ59oHYInNMK5W0jqMieP9WC/aEyJgKPY?=
 =?us-ascii?Q?HJOP78QgMvlWG/b9hgez0DYG6tS/gmA4FVNR8NF/LXnnL95JHrzxMZNw1lQF?=
 =?us-ascii?Q?+OKB+PDAh5ZjZOAoJ+o/N2TooDeU75nokvy8xgXM8cO2BQ9p8Bui9px4Hdu4?=
 =?us-ascii?Q?kP5oRqTyutXLylKsIWz9qNyKApQ8s7IdGp4wdYXwPyEjDjFttlA9KyGMzswq?=
 =?us-ascii?Q?wf1zWHQR4fhhnBAbei8eZxDHMJ2tF+GGELRPE2HszRsGMzwcZqZLNSuj3eTo?=
 =?us-ascii?Q?uR3mw18qLAp5lfMxgOk6y505JPnWLCuhQrzEFISZpw+2Ic0ylPna7EzZwmfi?=
 =?us-ascii?Q?g9P89c9GzR1lS3fKRuGt9NGQnbt9FNy2HOLh0TrGsK2O940d3x5Wg8MeeQ1h?=
 =?us-ascii?Q?PlVqH69iK11Z2hY/ler8YtBgkQRqy0ul6oI1mVJGM84wB6mWTaCeV4QnuROe?=
 =?us-ascii?Q?85UDM3IpiR8j8oyoTURkbR/EcM8gAUxoXuw7SxB+MGmjQfPbLiRkt3qY4A2S?=
 =?us-ascii?Q?3xemj9FM5gJDrQGDj29raUHNxVQUOlKyDNK/7bUBGY5C0xYkbp48R/OvagZL?=
 =?us-ascii?Q?0ieCHXnw6JfVcqThM9YrvtSdZA9Gf/dwBl4hb1Lz3XPLLj/5n5nsEVuFFxXH?=
 =?us-ascii?Q?vfhCe0VGHzfWl+hEsFxzKWvgQhRr5nMotRkjb99CHZD2zKpGEGrGVs3kyLxE?=
 =?us-ascii?Q?TsaItEV8PuQaL8VcuZs+wPWXQ35BA9wxz7vVRaUU0jwtpkp54wdwlz92lR+Y?=
 =?us-ascii?Q?IiI4rVoALmLNWD7Tw1zbVP1Zor7sWWaV9Xjbo6er9M4WJp+/g6phUUcH0OAB?=
 =?us-ascii?Q?mmT66+bRl296+5agSQnBGT4iELnNDvD1cMw8CrZnI01rMOwrCYCY4zALClIL?=
 =?us-ascii?Q?gG32jEZc7fIl7wMH2XmtVZXIfVn+wOR6qWlgsH7fR5p/uBNOzfkvu9a0xxB3?=
 =?us-ascii?Q?6moF+U1Uzg4DRl2YTNvXnVSKuhRqD0AY27dl689q0g39Yy/D+7ciojrvt0vR?=
 =?us-ascii?Q?Xg3+FOO1LwebYnjGryJs3z5MWhQo993g9aOcB0wMtL07qaMFuI9/dOdXELwR?=
 =?us-ascii?Q?4OlbCadPPqlA6ngyvyc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 19:36:08.2464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cdf2e2-39a6-40a8-47ae-08de2d230c23
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8761

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

v12
   - Change supported_caps check to byte swap the constant. MST
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
index dd0e65f71d41..1675d6cda416 100644
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
+	if (!(data->supported_caps[0] & cpu_to_le64(1 << VIRTIO_DEV_PARTS_CAP)))
 		goto end;
 
 	virtio_pci_admin_cmd_dev_parts_objects_enable(virtio_dev);
-- 
2.50.1


