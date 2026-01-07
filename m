Return-Path: <netdev+bounces-247830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB3ECFF1C2
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2232B300B899
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26534846C;
	Wed,  7 Jan 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V6gFqDHR"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1691344045
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805489; cv=fail; b=EujQct0ytW/xRaKmoKVRPJX0RNjhVvgVIx0cSfg5GqPcKpJM/cICZqelbbtshwfbXh37Tv8+gLRe9st0mDjedqUY5E/gDzveZySFAwE+RhBjCDgo4i92fDvKUZUMrjX2i0kxizbxy96RkR2Omg6Il3qVY7hpbVpur0pOwM05yiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805489; c=relaxed/simple;
	bh=wsGUHq5OPVhfOEtt/rMv3q+JFLZAeVhlUX16tLUzxUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utIUJefwtgDkIjiPcTn8WwjHLTv/59ThJj1nTHrdUloIj878Qbj4Jo2FvFhvWnuwfuusyS2ohF60bkUUb9x9MqC7T1B4mnzgXKI1rGBvMcfFlYqNFGFQSIYt7rBn5WLHJEntZ4/dL7/KzlwX/+QifQjJV1IjmDt/iNBR8Van1j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V6gFqDHR; arc=fail smtp.client-ip=52.101.62.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8MatBVzb7gq2YwmG5mMkWkm41KCp1G/s9pJBhI1NJT0ZG21eGIIQR+SYgjSDoORgVZrvXdRQdwWyeVIcnD7BCXF2+F7LYaUscFcXQ3Iz2R2Th0I9jFQq3S9/KKkN/j/DlmPbfliYJMbcSa7m5L/PqDfxmCOxT4E5QRALoELejMIkpT3mplIfcqD++xXSoyBhqYZjckEMCM8L/YSVfUALgf77Eco1MFg47jcSexi97A6vBC/5CK8Pm43mwHJxJPTXzCmdMc+PWTpUJBy33Yo5b4ECl1DFC80RKfp0KicUaUyXF3S4AG8ADtNq2fVNRUF9H/5v4sAikYKMXL3YJ4BCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=m1FEvR8y9dkjRKbLic+ZmSOZdYWOYKi6lsoF0pSQ1gE2JqPEbA2Gj0qMDE1S/28LhOOqP5Xxl/F2YQ+3nxt+Q9uJx2TdFf65YjMBYOE5L/a/KUTg5Vt4PcqIvpla5tpWDZtKLU+3gAcf4q0GPWd0SOMbsFayYzMsJTTWI6flpx6cq/qrZ+ZcvXO73EwT/R8GWZFtqO1vC6pxRSisUJdYtAe3y7eaZtxdCIaq9C5OF3rjYKNV0pzk7P6dLclGGC3IROr/7r6FnR3oAURWq1KKXYkEieaq7SsUhQoGDL645BL5VQspefI/INcHfbPIZ25l7mTtWx7H8QNoAh7PxbXALA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlJi7cDaXABF4XlI/hECzIo+dxPjFTo6en3eJYwHZIE=;
 b=V6gFqDHRtch+wFL9+pVdbXcaLa0QGxnQRF544TqolC2b2sC/vpvpgalkT4ESJ+blF+WOUulgxdZBeNbnrkEuRuIKuOGhIr7EKvGcei2wX19cWmi6d5ufqgCxPvoSg4WR+akaLfTolOui7amG2MwriDzyRBKoftcOhcCxAh8WqqdhHeIvlrIWAs7z7O7GK+GbDapVgpvXuPnZiE2fdC0E+51W09WH+gYXiDwypCBOmGsYRx5IvpSUKCIbTx2QFAfdpvo9PNDSt57QaPpbIFYtV2zuC4DxdEro/oXHwe9mwGDSWoEee02Y+HyGjcOA6fpKdtwQYe+weZ1C10xCNDkaeg==
Received: from BL1PR13CA0376.namprd13.prod.outlook.com (2603:10b6:208:2c0::21)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:04:44 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::ee) by BL1PR13CA0376.outlook.office365.com
 (2603:10b6:208:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 17:04:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 09:04:29 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 7 Jan 2026 09:04:29 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 09:04:27 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v15 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 7 Jan 2026 11:04:11 -0600
Message-ID: <20260107170422.407591-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107170422.407591-1-danielj@nvidia.com>
References: <20260107170422.407591-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DS5PPF6BCF148B6:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9dbe2f-5f5e-4f3f-5c2f-08de4e0edab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zxtRNLzVNRtV/yGe9ZWCoVmdjF/mJ4JxqHX1q9LJp5MqJFisS3S0BCmkcVm+?=
 =?us-ascii?Q?Sjwo2Ou1cHFd0H/U6LD/V2MELOGl8tq6ncAapYMlfEfz0cBaN+rqVJBxdQZ1?=
 =?us-ascii?Q?LDObH3z2kS1AhYQ4LxsePZif7pvoDkbtxOdbWYOcSREmAWYV3le9zLv9sQ9l?=
 =?us-ascii?Q?ULbbwVZy/nSESVKSOKlj8xHYU27/9n0MyCTeAnhbPTYlCD9S0vdVrElS/wIO?=
 =?us-ascii?Q?rHiylycQ7gM02r0Y8mNJCLOvgb09I0QmYkFWLdpRm5LrZAoku3aG1eMyEAjW?=
 =?us-ascii?Q?F0vX3kuyNgHVFzDJLUE8YUnYLh+vjmBIe7FOwyajvNbKVxfHxM3D95mhk7Ag?=
 =?us-ascii?Q?VRUc5sH/x0eURx+5cH93iJ+reth5pNwWnZLmjjanxa/bUd56SBnt68KxKEJE?=
 =?us-ascii?Q?4k0dnXfH/s7H4UmLHXmpG0ISAS1xU2lstoNwwMCsMUNArFvAwOG79MoKwrun?=
 =?us-ascii?Q?yBPxZUTmadD4obWnsf2etl4emPZ94iCelq16B9snQPoAAKtgVPd4G1X0vowi?=
 =?us-ascii?Q?cY2I1A0trveKp1O4luuU0MqbEyWVpyKNy688UYW3cTYGnUVHZg1PD+TQ4iSF?=
 =?us-ascii?Q?68PSkLrpIw7FAryk27rpRKMiwdvi+3PPnH8pBJEUTGWV7EhL4Rfk7k5DLAe6?=
 =?us-ascii?Q?mX0YUgLX9sQkbarq3Y4IRph3cz1aWnU4a7JUqTema3DngqfiHvhFfdiiQJ9L?=
 =?us-ascii?Q?Ddt77tDlqJ7Zfgd5taU7xcQKCzVdVmMqa7IP4bj2BnglFJM4dHNNqYmTDSbI?=
 =?us-ascii?Q?yQ9PcKMXF1cLPQQNTD7hd+ULWKxOaaiO0lR1ASKEtC7l201s+0ihtjDXWEbh?=
 =?us-ascii?Q?tRh646fzkdkn0ADv7arld1ejJ2vAdMSjlOnEBGNJ0yDXiU1GwE/yNy8orZUI?=
 =?us-ascii?Q?+WVfV4qiIuiQh8444S45ltNXe7N0F/vPdOEqPOfpp4J4iTNGgeUh3OOcFwZb?=
 =?us-ascii?Q?+Qpyabd6pdGQh+hK7w8xjID3YMmM1Z8SMLjUeMNoVjYDA6lhb6c/Q666IHeK?=
 =?us-ascii?Q?/Bmk9h0+Oix2M6o7Bay0bAOeWHM1G45S6wSYX/OLdndnrSdHC0WkqqmLvpoZ?=
 =?us-ascii?Q?3YlzUBd8rmwyy5lXz0sCUKoY3/YjVB0U97cDxueCGlma0edwJ4nvpmoWlPGf?=
 =?us-ascii?Q?Ao8YQVogG1yRiJk7rJ725XAb308DtQOPX8w+kiz0S5nH1Tc9RFPtGJ990AHU?=
 =?us-ascii?Q?Yj3ZNChso7CcAVGUAnCR9mfH3ZfqWTWYb1z/IXjulFrkqwK8vTK55MdTzZiZ?=
 =?us-ascii?Q?fFx2/eo3ir5S3AO5OWwEESlAZzCEa+A1x40tmHXRxN7bapyOEMUDriIPQ4xc?=
 =?us-ascii?Q?B9JOUOm2iVzAmxAwPBhaytoal1Xx1RDxS3OVmlyeSaFSQaRMMh5PlKJFMiAB?=
 =?us-ascii?Q?xQcbJCRAohQiML93vnXuvIlXAKhbHdJuGDeRluALs7weXMVexS1H6QnREsMw?=
 =?us-ascii?Q?NaCfpj8/xuGasvo+ZKPqH4rwFBiahh0AySfADdZ95UhtuWdwThrnY4z0zjoV?=
 =?us-ascii?Q?BA9hQOERL0zw6WzJ44xf3+eX12md8RbYBPnU/KZjfF8P1i0eD9W4ArWX3M3u?=
 =?us-ascii?Q?UzK2Kf6j6kl6aHW6tlI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:04:43.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9dbe2f-5f5e-4f3f-5c2f-08de4e0edab5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6

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


