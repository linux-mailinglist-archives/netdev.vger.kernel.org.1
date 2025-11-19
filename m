Return-Path: <netdev+bounces-240117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5BC70BFB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E96414E0688
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1F2F8BC8;
	Wed, 19 Nov 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GKNEVed4"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010018.outbound.protection.outlook.com [52.101.193.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C531CA42
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579758; cv=fail; b=IkgX2m5irJtivxP/vWMOLukCa+uDo2oJnwrtF0BGS0FL0JWSJ5ktjw5q9rUn9X2NGh6gynQr+iHW8D69jtDzGlSbtjnG9ZCFLOoTR3/Y7x8dGATlX1YKzKe3f/PWFgUuFiY2l0FgiFD+w267XvJx8KeWtiPMFt2wA+U6PmYTBfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579758; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHJbcHDJm5Gj512ra+W8ykXL1DZyJGQQcQWvXHD7sxpc+kQWS8ssaTZMVecqy3YvhHjCeluUOQd47x2/wEevMlIIXvmf8+tYA0Rb8Q8OYRAWcdIDY88+6s8cIPLL/mjUbs2Mne2hGhbmWZk5kWbs5Y5DQXDZPMNAGCWiSBy5ve4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GKNEVed4; arc=fail smtp.client-ip=52.101.193.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMEWDtaZVef5VY+nBoKs4uEO/90EjSqoglAIEB9BLWiQk+dE5cb+qK/tvyAQby4CwNbtkRKE75gkF9mtnYQgIocfkJ1rx5n8myhrbmtuPc9gCgFVD2pg6A8MWEtALVv8Fm9Sw15o/NvYp81z3pXIJdDQZ4IhCRCCmK32m8pKsHdEULspgZg2+Sipe7Rl5d9Iy77j4LTlxLXSzDZ5hlPKEfWQcsowZpUe85ywsU9fCUFN3LGYR9Q9Vg0lleoKF/RAj/War+kn9fl0cymrf+9C3slH1byL+rXeRGTKQWdJmOWZ/OdvtxOLavsouh6Wyl5K4eFj5/rnUFYj8Ta24fkHFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=r2jpopZa5njjMyKBjSOcA+vmugVl4fFSfi2UcZIPoPbb2oc1TkZgAoHNN/lcsXfhNlmH92+VK+Wd0krBHarH4EEtlif6+gLcTC8Soby1DlQIOoKD3LxOLZ2okRF+R+0Ysv4ws/FipmgBSWVf6ssIL7itbrhkJcP4T16BM1+6MWsGEHx3RhWx/cNNNWQy0mYLD0nrXGLw46xv6AnauE7vgzlmLZe4xa3pJolE9AaCfopVfhT0rVI/bOWb/n9Fag5l7u6+wh5C3FaNS9vKmV8z1yi/zAsriG6ojlkycwE9GbpFEtYEF4DCi1l7CAVWaHmWyZg3q1ukwrseV/InBQcEYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=GKNEVed4db9Qzat/4X4lHlybQIOt+iXUCL4vs0Uir86ENKhonYUH3SNRjP5GFWOti/u+x/4z+FGt9vAUYT5lq9PBFB3qcYA3TB+U9rkBstVrXyj2FMOrAl7iOAF9Hv3UK2uuuHxVrC5TNTcGxvUujWFwtmHuJEQ2loganhp4H5Ed82iyo9IbVpO489rUwvsLwsWmYao8u7n/aHVR7QkL9WAFG3iI2cFPM8taXz2YMB8tnDQww6peYT5PYxmlbHnic7eM7+GZoqlpuvMCpz6f0gq8R+O1I4gfi/o9kTIJcxt7sPPJn7Kh+0c2x1RCogllW7HhsZBVSOoiTRWlK6wC0g==
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:15:47 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:bc:cafe::8b) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:15:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 11:15:31 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 19 Nov 2025 11:15:30 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 19 Nov 2025 11:15:29 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v12 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 19 Nov 2025 13:15:12 -0600
Message-ID: <20251119191524.4572-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119191524.4572-1-danielj@nvidia.com>
References: <20251119191524.4572-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: a64ef493-9b50-4279-26fd-08de27a00b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHkDTTOj29WZiJiQ0n2fuqi0kV5EKQhdz8ydV10p5130VbbIpoB87p9HbgSJ?=
 =?us-ascii?Q?d3HVgC+i5yXZWkU64uD2pA2hkoH0x5CYlfiWFEmhmIu7A3TA+yKTwqgHjohe?=
 =?us-ascii?Q?KssbFGMP5Zey/1NiJdNcod+u31uLMobNsVgNeksEhHCGvKK6/MSbEnz4LNMf?=
 =?us-ascii?Q?O6eELyjAbzThnR1EO6hk+Ks6lkx6fP8upR9grmlYnjaD1TuCTxj5OywHJTEn?=
 =?us-ascii?Q?ti3Nd2sGJuxOqdWAlBg0PSo3Vu8nXrsFSb1rTL3zWQXtTnjRObX8C/fMnS5L?=
 =?us-ascii?Q?e8VS1tsb96qp0AYPgUm0Lw+y9egBTvrc0XgEI9hkpSTw1xsuEmAjpGPpWl+q?=
 =?us-ascii?Q?pmnW6RuQiK6M719nW/govOCcx4Uc+0XqLtMhF36CTTccOh2ilvNkPPgfcO4a?=
 =?us-ascii?Q?RdSr0Knuvz+A212f2iAJhZMWNPsJp0uGiJfQjnHUvIZpB2Fa5fMvta0gsSTk?=
 =?us-ascii?Q?lZkeI0Uv8rpLsK4ZPR5v14KKS43Da0fmB1FvDAVtzpLkB5LdQoEnVOqcN7Sa?=
 =?us-ascii?Q?pnHtffm+ef1akh7NoyoAVOHWAOI14xozO1Qyvz88ES4m50QvMIuTMroFZzbp?=
 =?us-ascii?Q?wK3mUy4/ukDZh+0ZCxUyYcHWCoJXs8s+Wfyz7nVfruWZRV/UYyoxWpYV+iga?=
 =?us-ascii?Q?ye/04C7r61sLiWuMvQKNcNi0c5uJUzzP+DThcXJzWbB5Ae8bEFz5v+Chw8Bi?=
 =?us-ascii?Q?AXN0nxt3MKGMjlOQwLDHYHwL4xy7lLt58PgOTOCNT2gVAfHSDO778WyPPZk4?=
 =?us-ascii?Q?ppeKBUo/CypenDbvyI8m0JOIUstedDuPys6arffiIvpIFrNPCT+jzLA8VVTo?=
 =?us-ascii?Q?gWqe3p2OcxXfRBS4aOQp21uJguCsaMKv7c3g2lJ0QWJyYPQ37QeTM8oTcOK9?=
 =?us-ascii?Q?LopkKzyZJloVZ5TWsSuv+z+sRLLHD00byO3EI8BTieRUP6z6ToDg/7K6V8j6?=
 =?us-ascii?Q?FuePVCGFaPastmfHmX3TOb+2CjJAHrJPPBPcCcnLzJhRFHkm/PGXrAcLVW9f?=
 =?us-ascii?Q?0Uo32BOO8sKGP8FW55XLz+vdBoCOr8AmiO20YeyFZCqnjF1fKyZWP/A3GTvK?=
 =?us-ascii?Q?JvcSGvhklp46P/AVhWA2UjRnGT0SlLdqaVjRMJbQ3eGRlG2/TKA5D1YSa+o2?=
 =?us-ascii?Q?A1CEoyeY73tGjMVvel138iWsIFGSkSmKepKFVkl5j2SnrUR4cdicQcF5p2h6?=
 =?us-ascii?Q?XFsLZt/4kmDzLIct5Rd0QnXHvGvJThZnOnAFG9u/rvZ0fGFL2CGh9O/2bB6M?=
 =?us-ascii?Q?ISstWXgAXLV0cmlIq41yttqY/cGUmfZmcuI6v/r4I/19v0JwR/D0V/DXSUJa?=
 =?us-ascii?Q?k/RxT8HAvGOssmX7e0dwVsc5dT28MB3xmzVzqWxc/262HjwOPTPaY1MS9Ly7?=
 =?us-ascii?Q?bmro8wO6NzG7dCMJm14qMKPHsNvY8Nxw41GdXJANEbXn8dlKggJWItB4yyfR?=
 =?us-ascii?Q?BwoV9i4SSECHmSr6lq/NYeb3qvt+Thbpw9LQLgwgaYxcVdVOEJc+tEC1r0lr?=
 =?us-ascii?Q?s+28ORhcJ97Wxcc4rR4JR/S4pjOHeEHRUAR1kbmNtxUXu8V16O2ujfNjCUvv?=
 =?us-ascii?Q?6A41YDLX25z4IC8H28w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:15:47.0054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64ef493-9b50-4279-26fd-08de27a00b4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

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


