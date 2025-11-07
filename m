Return-Path: <netdev+bounces-236616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F70EC3E6B0
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E230D18833FB
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A01AB6F1;
	Fri,  7 Nov 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lN1qaPmJ"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461503B2A0
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488989; cv=fail; b=CG5OWZ4yBsPncZ2YRBqfuK5QzgzHWwrfj1D6DfaF6wIuUr7imdnWq6h7IFjY3JfXAbQKP/MCLiPsNtl4PfMZThanbs1FCOZ8M8Sg65gn5vxxng3kp8GOG0bxXTL2dFifAOkJIWxKHm5JGy1zPat2PcPbMCusDmpJJ7Np1jbmD6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488989; c=relaxed/simple;
	bh=Dc8533Aff9TqwV9HN1L7Ofat7h1bz9pH7F7w87LDzMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhKoXaLEyyBsY7x+wZd+ggZXb/cmxft9P7aAwa0MWGRA07AXOITq9QN+uXtjtPRlhCcRLwGdHLyLgZA/3pQJhia53N6c0QudtctnTpTzYZv0nspcpsc7VzDH17nV5KvkDkiwGx92udkS0/RNCYKtJbHOHDVzyR+wKqx8hj14Mgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lN1qaPmJ; arc=fail smtp.client-ip=52.101.43.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2MlTQEo7OzUFTj7DmfilnwQY3oQg8hbhIHL2uxSpwzeKYrNC4Z+VTN53UU4h2t+AHOY5OX39ATt9Z8VyPNzVYLgn9rws63a70IJm8ih/ksJY+kISO6d0HVwer4eRFVGHQScm88MxlcGlcA/OiPwFztd7LMjrLPcA0H5AH/yQ8H1iB4OgH2ZZJlp2EX84AaJJNtEkJYNjTInjpgtOdNOeO1tualRxfNuso5kj/YmYJ/W6IjBgLFcO0HwCvRSjsWaqk/LGnnrKsrBfUmvUTLD9aZns9bXNMxmdcrXu+DrlIJ3IXGDR0UW9yKwSUR8Q97n+DP/3yXWKxU9TD4kA/nYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=xi+eHZKxVmBSutEe6QIvMh1mVnk6X9+FL6cPv3OTFxrGbype9VkmGarifyQFdNTmQiC5Cqh9YVXSGr/XOhKY5Owhwiq6fStUfM22Pac5O3p0S8rRJT5+5ZRLoUUCilQIIDIGOQcbZr8+8hN0mbDnIQh7DTsj9aoVO2A2jP0IStJG0KLPmNZxrTqp2WwGCVv7bm0SF12HmcIkAFtSxYVFRNiA4B7NlCdb4iFHJCpasHy6yJIcjKUNKz3lZuuK9PPeYHWjEzNq+V2I1NJo6vdDzIrRwqUPBBSYuB69RILnH8ssUD5TYWMCEwzGAT4kyV7b5GNw1VcvgJ5IVpPNJgWYhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=lN1qaPmJ4r/ClZSk7H1izCrlPiYRpzZsv3PLj81OOQIj3InuDeGCu0SgiuFpecCHziEWpxRnVrrrsRMl5AcssvAjWVsP/c3ogoMx1hALHnBwHsJd8q6RHyqeqOgRJbfxmhbTZVcuIqhjPOuQ/e2Ahk36YP9to8Eqj6XUS62T+9TgcDsHaJ85zzdRPAR2hKndMLm7mHA/fs9SVlYOeFLNmY7e5F+KaJ/htw9OS2dsassiyTfIKm9cLaU4Lzp4hPWTf/U+26hw513/YfA2Z02eDz+9TT1suGN7g3R7Q7e+pMHJiEIMXb7fTTZTN7PF8OAh+lMrJPB6wsHsxzh0pKOfXQ==
Received: from DS7P220CA0036.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::24) by
 SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:24 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::94) by DS7P220CA0036.outlook.office365.com
 (2603:10b6:8:223::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 04:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:12 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:10 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 01/12] virtio_pci: Remove supported_cap size build assert
Date: Thu, 6 Nov 2025 22:15:11 -0600
Message-ID: <20251107041523.1928-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1043fc-2dbe-4b86-7045-08de1db46a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLBNlejtZ3+R9ptoAIfWjsIvCT/fBLKwkqWsTPzqeCdV4SMRYlE+308VfD0J?=
 =?us-ascii?Q?QNCEZw0evNVbsH9or/6kNI0onYJ/GSs5S9EEdZxpT6dZRC/vitnvQMjFesa0?=
 =?us-ascii?Q?JJ+7GS9wdXE1cHgmeE6GGcmfSxo4VtAeRrBpDfsrdjJSdri1rDxMR/VWxMlh?=
 =?us-ascii?Q?8aD6oAgQiM29/EPfDrz4qmGM5+qFzw+InY8OdhljJ/twZibJylxGxjxVDTig?=
 =?us-ascii?Q?Xq9sgYVM9X8ocRn8JHKeGVpMIvbp7+oyk9DCytS4wLNMKI9KrgIwbDbLZudh?=
 =?us-ascii?Q?sdEmPc3GMZ/XQfZm0+aX/70wtwohPJJ0yhuCmDdgL4inG2lryjfrQf53SW6w?=
 =?us-ascii?Q?JwFs43yWJGhjGPWMeuphofdPvZHlTfPn1pTb2aJOur1Agkza/PpOhagTT+9A?=
 =?us-ascii?Q?oThyZqdCyzljxSyPW+buIn8s5j8Wo+93DLuxN4dpWt6IZKXL3MoYWuKSyRU/?=
 =?us-ascii?Q?rrPbveoVMlEpQZj1BA9BiHJqTBXspKtpEJTQDRXxhtSvUthpbydWCWRC4bCc?=
 =?us-ascii?Q?MfzM/ierDFnBI0lJWrVOyrAAhKDfJ+2+a1owap32wBhh0KS/vu4st5sGXc08?=
 =?us-ascii?Q?ZUiTPogsKsHtreveNM2+esKmwxpIcBamtE/57OI6UZLilEx/7i+3i5cNe+2o?=
 =?us-ascii?Q?Evvg8RrD62P+b9X2JwxSVAvJz3SK/Po7tMndiPGtnUAUAmYsYUsW2ip1Km7N?=
 =?us-ascii?Q?ega7Dtbobhg2CL0yTXiEOvYq8Jtp2+CcNg8BzPD2MtKJAx3DQSI9UTbLE3aQ?=
 =?us-ascii?Q?SL6XWmYmwLCYcGw3MqxsICcji1QnM/8lU+xTy5Dh0d00q4+PCr3d4I7EDXqu?=
 =?us-ascii?Q?HUXEwU9jZODgPjojmryY7en83htRRoqoiGMZMmBTwR1ijdBy6o2dW3o2tw1Z?=
 =?us-ascii?Q?54+9J/VXGcNf/AvekpkKvCwYb0HroN3VAljCqCTiYHiyNQTr1LcBz8im2sYW?=
 =?us-ascii?Q?BXkCwCns9kLXWZziqU9jqLIb+g43E102kCGkEwmYyLtJmDYfuIs0XkePK5sO?=
 =?us-ascii?Q?mixsigaNI4LCIAQbKLyurZWhJ+sr0nDFrl1oJ9Y+dYuVFbVG5ThUTerznRbP?=
 =?us-ascii?Q?8B4dgS1xD8h7NoBNJtQ/76JXtXFMZVnJpvXNiPAuu/GDyyGesaAEUmvx4Y4p?=
 =?us-ascii?Q?mqfkg2r6u4a5/f5D3d93AFG0xm+G6JRlgClYF53G/cg4AIo7RP1rKNhd0SoQ?=
 =?us-ascii?Q?1gVsJE9GCzvKDf+1JNM7hrj4B4qMEr9TKoOE5fmEAsQmxbZPbLLyiroS2IIw?=
 =?us-ascii?Q?0NDYzmQfhM/6cj1n5dlgF4XLbxKBy2gLf7hSu1A/14i5V0Lr+qSKNWluXCDf?=
 =?us-ascii?Q?DYsKmArM5PGdb7TGJRgpp6aE9bGyyf/Rg4uDLRvZN1JTVWL9/YiCE0icLAAR?=
 =?us-ascii?Q?22OsEi8qK0ejaLeSvzEdJ3Q76g8QCW5jFxxT/yMOWFvdlqeNRLialk3NEaYq?=
 =?us-ascii?Q?xSfz2FXVlNRBM7ZRh0mv9QUpR0UupDclqCt/he89y8G0YS3EgGsXGRQl7a8y?=
 =?us-ascii?Q?kgeytF/RmI2mh/BWzRenjj4QM3Ls+XZW09aCZVGUXzteCfOTmdTdwjO9Z0zx?=
 =?us-ascii?Q?wY1oOizl+yfLPo11YhM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:24.1406
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1043fc-2dbe-4b86-7045-08de1db46a03
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

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


