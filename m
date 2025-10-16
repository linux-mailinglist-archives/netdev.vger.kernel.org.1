Return-Path: <netdev+bounces-229862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 824E0BE1774
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF75119A6116
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5312045B5;
	Thu, 16 Oct 2025 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJODPViR"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC68524F
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760590881; cv=fail; b=PKD7IMNfJv9H7Ef42Sh7paqH/mtAr+IqMjxjXpc4W7+UiUnwxlXbQTW9cvY/fAmOgSLtfJLHUFYfUq8hPZJ8E82LFWEBmpEM7LQ+p0aA3h9lLQvhC1yPqtOe/QrMq1LGHyaEaMdSdAHgs7IiNcb391JIt5ZyAHNU5gekogcjLyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760590881; c=relaxed/simple;
	bh=1mIcvDPVO9nCDb+6T2VRbZXLCptICuyljMqPLfQ4pV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpzfZL2LcZGfkjd5sr67j0mCcOzP6tVGOVwM2piseB5iYTstHzpdOH2qnRuTyVdBtMUYpIfzW860fNWBNEMU58SMysgloZDFLuXv0arPIHkVJ5t6eWasyiGmT3aoTje8olzdy2+HTBel1rYFWLFpsw7wJiaPjGzWW+6s4DsxjWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJODPViR; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW0iBXOCbsUhq0DuQ60isf87MaERlaxmOXX7y7ZNXTdJiH7Mz4fyH9NoIWGUvXEksS61omphAbjMMCV7G7Rx3+iztBGwDj4sdJwYDO4Zwss3fyCLL/3OB9pwsgadvp4oowB8MElUATN/1z/Icp1U385MrvXkKpcZOGVe6mWihyB8a6tKhw8o7RfxschwbwBEQhHvsASZ8cvPh9QPHUbjZe+JymVID46YIJsrtkxbklVtvWuSW7MPkMVQb6dQsReQAXQKcf8Clcb1m2bQ+wQFF105hejovGXM3jX+vJ3UGceVSAvksrSugRDFZLnPmz0eTPkM0/FSSlFhLH77i2RjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReFK+T1og78D/4ekxSobvz0vZ9cr+0l4HOS7+uN0zeM=;
 b=U5E2u67aF9Ba4i8ERG0TBMqOvBvREqDGtmsD2b3Tv7btyBqkHOLUeS7VSRrj0jP/miT4UYaJH/SaWTa7AWnZGk+0yx/gmVDFkrGotPRFCDWWw8TsvjsL4TxWuU7y2czKBeyg5ZPLEes8f9g/ctArOhdNwdpNjS5YokucWVifJCxASLfVjg11ZQff2xbOA8h0KnCp/jstS1ykhjZGGAOLIIgFwxEjEGB3BXBWN0Cjw2fZnNucruKz1ILS11KSYaEkll+TM8SBU/LfpqvYElYOXP/eoYTmz3lJot+qo73Lx5WyTSswvdCcazrOaTIiil5G77wB9KroPvE6SZPfw25iTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReFK+T1og78D/4ekxSobvz0vZ9cr+0l4HOS7+uN0zeM=;
 b=FJODPViR87i0B20xjvOt8qUB/HalqTLozzDRTaYG7OLyF1mNClmKfhTv9+elM/p0jFsHKUoWpfWGLsYgDKPhDb8hZa5JpEWa9vD2h2FzUdqzd7qotW4eY8bfokTm6III7bU+sbEViM8xxnOAnFFG098js9sfS4DkEwrCdDxXXV466V1iwTL/SbdvO/bARNJPUTHX1nuOPzIsO9qLum3AOZ/h1j2gD3ym0yhi8oOEn2Y8YA02qE/CGAU4CDPY8H708iKi2VCM9ZgIpRufp96a+6CmdKvhRTpsJdSP/62C+F5xs+ys6GUe4i32laU+zbwjGpULM++Rh6uUOK5rDcnaDg==
Received: from CH2PR20CA0013.namprd20.prod.outlook.com (2603:10b6:610:58::23)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 05:01:16 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::9) by CH2PR20CA0013.outlook.office365.com
 (2603:10b6:610:58::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 05:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 05:01:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 22:01:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 15 Oct 2025 22:01:05 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 22:01:04 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v5 01/12] virtio_pci: Remove supported_cap size build assert
Date: Thu, 16 Oct 2025 00:00:44 -0500
Message-ID: <20251016050055.2301-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016050055.2301-1-danielj@nvidia.com>
References: <20251016050055.2301-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: a033a6fb-cf9f-434a-0a6c-08de0c71094e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d9Gh0XnmAT/ZRKWLNFKzJ3LRZBO/e+SCmZskduG8MMFExzW3VOImK2Ihtvux?=
 =?us-ascii?Q?YjrlJB+SdBGMNlzyDWd9iRDXWOPF+CqV+8CbDZ7uukmOUmnqem/lmu1vcN+x?=
 =?us-ascii?Q?7/CgvOHmnAYPuGLUthrpzGJqGZkA5qVseDC7vY6lz0d8q1eZ6r5lsvgZq/EI?=
 =?us-ascii?Q?qVWU+UzWB/va22jRHsqw+yWsjsfsNZirX2Lt9ivsFXMpl1dC1BjzDI26pmPz?=
 =?us-ascii?Q?NgMWE9i4WJFNdrN01e7HvPqLXj2X1LqlVHcy/B8aAdlNzBZvYU0pJfs3gynY?=
 =?us-ascii?Q?1EddSuIT8Hhbip8k8ISBCVGx4ytZdqZOnbcLXjXcDqA2G72d/RKJ16Dzvee6?=
 =?us-ascii?Q?xBl5hsqjZrbj04gyNMf/hWbZcS7GEcVtkUtMNer0j7xkOG4UOC5dBb0o0sUu?=
 =?us-ascii?Q?1SOyyBLIOuXcxAJSA2r7o+S5wwnJQtCkimKUXVA+eMHIVBRv4GYAlgj+ITIr?=
 =?us-ascii?Q?qhpxv2XQ4CmhjNKtQXIZ8K3Fp0PGG3rmkvRG83xey4c0NaPcSi55YdKljkgY?=
 =?us-ascii?Q?+qRNU1oRAXtzeZdfqgyp9+giNBZaHWTfhD69a+HWbcGyvkdRcn3RtGPUQRXy?=
 =?us-ascii?Q?EsRxwqgSFVJjhDEVJBnaKCTK12NmPVo4Dij/7cBi9ZBsXlmU2te9oRt1PB1f?=
 =?us-ascii?Q?Vc0plnulB22/xVKu10UdNMRXD5MtdjUUnvVo6rtNkWPgRHPe7cA0oy8zrOIx?=
 =?us-ascii?Q?WUzVn5f9tYLcQDLFB3BpGGTF6BKMu0bQq9hsNJlATGTX7qjZFmGfbLCtYUaF?=
 =?us-ascii?Q?84pxcYTk7lejoMwKa7oCV0YoZEU1jeXxlAisSs8ZbyINbwQI2CEcCWmfSAUT?=
 =?us-ascii?Q?ishaFcBeYflrqQc1aU75/s2XbP3nJ7wzUBJNUTaSTpl1rDbxL7qo0BzVGm8X?=
 =?us-ascii?Q?1XkFUxX3aMoB+qAQspFuzE/+Duv3z6mJupfBk7NJ/YAVmAfm0K6+gP+ne7Kk?=
 =?us-ascii?Q?mC7qqDr9U4xV8t1YRRHEihMXccLTx1J9McF3Qlqza4OZoOGa4jzvpyzgO5gr?=
 =?us-ascii?Q?QG+10iQHjpMZL+iJH7RSbE21sC6OufOPMYXOC7l58+qjovchOXnEBaQLB6eo?=
 =?us-ascii?Q?H4+n9jTOdWrhVQojAacOrBs4NhRQWDenvCiMGXA1ZWZTJd6jpNTSPCCQDmPb?=
 =?us-ascii?Q?gnsW9m+BT6DEdkmYUK2RIRwjwLoQEpVQZheKq1mHDQS8wRmhtxLNncmUaIdv?=
 =?us-ascii?Q?1ur8W5XyJVd01P1uL8jxvIR4J1SgV3LQZL6DpBt9OkZ7rKWbqHs78pKOToKA?=
 =?us-ascii?Q?WT0wwJNhi+4RDRvAHuemcoC502q2DSk7sgvpLumMBfaSfUzzql6tu1EkW8R6?=
 =?us-ascii?Q?zrcgCxTMXs06CuaFsiGbTQxRX2i3QD2BkSFJt0zFcJRTxftY0trJp1i3KjkN?=
 =?us-ascii?Q?XcfRy8FzoztaUut2nBM+WGbvzFUYMjP6cyaoz+rAVSiw85xAUL4BuW+hY6HK?=
 =?us-ascii?Q?9RcMlbHcwfB0xf7hskvyzGOLmABBPr2lU4oUcvDndsOeQikEd2gdSwJYURJn?=
 =?us-ascii?Q?tE+Rv5JA4bt+rY+1TgHt2gbIIhNJEvlrpdA3gz1rjVzLbmtAwmYfL3/qYbi2?=
 =?us-ascii?Q?HIvwgN1iPqW3P9S/U7k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 05:01:15.8855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a033a6fb-cf9f-434a-0a6c-08de0c71094e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

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


