Return-Path: <netdev+bounces-238108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F3C542F1
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 914B034C291
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9734D911;
	Wed, 12 Nov 2025 19:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V5BJOfei"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1F34888E
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976114; cv=fail; b=AgPw3+nTzflO4D5bLwb3r6XadS9VGEhLPLBCi960LeJg9/OIoNL+N8pMqYU3EBPQfqwUWinKLK6qTUoU4bKV8sJ0UIZXiN70Z/oSIQVbJrQYOEypEzao8HTsbmFDzzOE2d5Ur9HhXDIq1ZCCKj3sHBBf+5h8EOfIdLZgSDVDiSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976114; c=relaxed/simple;
	bh=Dc8533Aff9TqwV9HN1L7Ofat7h1bz9pH7F7w87LDzMY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWIi2hvvFUVkMb42PIisgfW8tOQKBYx9FA1Q6UdB0kYBW2nsniL+xVSVIHB8hSZTvL+Nr19tipqubtJAR9kVHfC1FA4xkFtCCDlnoQdDuXFCTJ8WHJmoU7saCr7euGgxMivHYhu9A8tHbAlNL5Bz77c2IKAabf2eLIHC1/M1isM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V5BJOfei; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5e751ZcDdsTa3F3lYU3Ci4vIHo4YS9S8CfbhKf1WnMGlkH2SiflMYpbMNMbMZ3ENoAoVDYDlBc2Yyr3CJZOsAxl0LdnJbjJ+T4NE5e6BIz4crpSFoEaJ1iFXqy9HWh7PuCTMit2ki2g+3gb0vqiVqRaHAOLYOblYvzYTRw4kBB3/KOhi/vNMs4ycJNHo+J91+0NmMart0THjpKh+teODuXsfhP0hDH66Z0PbZIH8bVFlBvcAaVuVfPR/NvDdU/HNNV1wGibpI90PWQOq3IIFtybStdXijNnvFHMTue0u1XA1UxLjIZ96/iyVUEhijVFLjqF7Xz78LqqobSFZar6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=UdbXYA19vtDdmrmKWBKaD5CIgvMRozCRCFb3pnqz9cD5WZ5HPAMdjZbwBRyE2abXG+ZeLJdvv7zAw6h2Z8zgUJIBMCz9EUnK5QfjbdNCFDH9QD5ZG2YIdCetbaMgR3y5v6Vij3AcmPHK88UQoq/kI9VREmersXhLSZNEUHREoasJXESxFRJm3xRs0I1EDS4OTZM3Su+M9+StrssbAz6GJybZzfC/qcwC82sD5F4/Toc5ux4p1/s8PlpEuNrdE0WjTCB6hac/kpKjcJwhTQRvvFsmVK2w69vSBXT+evwntGYVhZxHK7GwRCdsdGDF7pyvFoovTMzJS7vBlfvqg3fkCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=V5BJOfeiJW9u9Y9AuUbi7UZcqtXYHQ5fuDB4AVPgo7Wr79JUNrb2uyqto8q0fSFWsGoSciAUonRus1w2nxDegahaVQLGlg7CjO24KPpppmU7Jb94K1qmtOIvN6pVPWXjIxrfv1oopg+H8FHmEmKnHlWxCuRvmB+1KH32fNgir6qbLxBWloIcIXKYHpIKrN2Zlt5Qvdt3pRbIFLnnAEBKGblF59yLdfizdU+uUoKzwkX5WHrDYLldeVSr+UMB4+uPUJh053CdwPg4A+a33AksNXt2qq+xyA5L8No2vZjsxW5ha2YLfUu9BAIeDoSEhCb4lh3aRWo30SxLAdOBho3AWw==
Received: from BN9PR03CA0501.namprd03.prod.outlook.com (2603:10b6:408:130::26)
 by PH8PR12MB6698.namprd12.prod.outlook.com (2603:10b6:510:1cd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 19:35:05 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::44) by BN9PR03CA0501.outlook.office365.com
 (2603:10b6:408:130::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 19:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:35:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 11:34:51 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 12 Nov 2025 11:34:50 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 11:34:49 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v10 01/12] virtio_pci: Remove supported_cap size build assert
Date: Wed, 12 Nov 2025 13:34:24 -0600
Message-ID: <20251112193435.2096-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: fd87088a-9d26-444b-0939-08de22229485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N+KUfdfrBN/81gCZF1rgslgAbxIN8HrVaJmjGSCdyApSeOO7UJV3rItOT2pp?=
 =?us-ascii?Q?ZdOTmrBS1OPlxocvpP2zQd7wS2QW0v7pMlInV4/iHBSb/n5GMN7OSqRdKuZR?=
 =?us-ascii?Q?MxU4A+5DfQE9WzRyTZTCTMI/xeH2Dfxf5ADtlcCnH6YP1kUccAf1oxxVCmjJ?=
 =?us-ascii?Q?C9RzNvp+YjIOjh00FXrrlOYeLmSVJehpPnFk9qV7b8hP/iBaZXIc2JhWvng1?=
 =?us-ascii?Q?oqzwMK0GBlwvYZcHBacWX9Zuql7t8qHPPkcVdi9dAOmVmiVG9CrIhz4CIwlR?=
 =?us-ascii?Q?7JV7lEd8teg1hxZ+gvhiDln8VWvCQLChjmnJ3Te/YUcu+eyTtz573dYVmGWU?=
 =?us-ascii?Q?oT8Z2/eute6z4NF8WWsfjlMik6aK6X7Lo9lHR6XbVbIuFJ+9E/bXSYhZKHnL?=
 =?us-ascii?Q?Y72tQ1ZNqwc26b3BQXz2UWlKgMHUPfR88O2SykrQYN0qXfhPrG+DHtjuh2m0?=
 =?us-ascii?Q?mMVufAxsY/mWPhJCX66x+NCqdXhL21ho/3JwH8Tshfkof8mKRolBLZDLARWP?=
 =?us-ascii?Q?IUBFE7fRjcCl1G7UUwqJ/JQxUQcVo3DO54xhY6bnsve833My+hCGdImvQOeO?=
 =?us-ascii?Q?CYn3Qpyt7v0j4ZsPg3jLayIfTnSm0BV1XzQPjt397qE6aT6cPrtWaYmgYKNU?=
 =?us-ascii?Q?or7g6xK7FdhgrnB23d4oVBTwgMMQsMDSmxfjXf92lNmVtEoJzvwUCYZX2k12?=
 =?us-ascii?Q?w0yUwfvh0m7CN9xpiRRmXbiYEWvETlQLFDTlP2gZZP8eSjWm8Om6cd4uNrAL?=
 =?us-ascii?Q?f0m9Y6x+EJpbVCKKoHxPutC1rqr5Ko6c0LiAa+tpu3rmnLvUaYaJ7MFMBO+N?=
 =?us-ascii?Q?qRD47yKFBKIRx8iHXsrReFJWjBKylwGqQpHyk6iHA/yyNZ4LMuuaJp/9QYdz?=
 =?us-ascii?Q?wt+0LHSEwzs7gDjYCPX9Sy0HueypkRHY3ikAZTonATdbgN01ONCHqNeVrrL7?=
 =?us-ascii?Q?5QekhvQ+PMWW2fklF13zhBjcRwOISAmbC77Dnqfnk8WAqGfXG4omnnaXhJ+d?=
 =?us-ascii?Q?woYMP/+HWShjAtV/bmSADqwx2n1ImOznCd733mm8UVZ5bexPxUHY3fu447JI?=
 =?us-ascii?Q?Fnq+LcQgeolFbnoJc5oLaCD/GVuti0rgez9s6r2QD23g1pY00/AL/soEP5hn?=
 =?us-ascii?Q?VNycIYUd/jq3CIvvtb+907PhLWPsYwXPgDhOpFbYwAmVa684jsFN0Wt642rt?=
 =?us-ascii?Q?SN6bqSKGbICnksZuNZ3nrabqP49qarVu9L/nfjhHKEXGHZ8O/mmID0rmTK9k?=
 =?us-ascii?Q?Hbja5DBVZUIy+fI8f7LuGGfkDHwjRe48G1AbRA5Zwq3Z9jqLe8hVbn7Asa5Q?=
 =?us-ascii?Q?KnQjEebf+tu1GOJYk2NHEAHYCKnyXVsdIUw1VDW+ZsMdyjcV+ypnDYPD1DEN?=
 =?us-ascii?Q?Lkz1IWVHqmTzPCIEvaW0DYou5cCpBOV6Z79mgyQe9Pmw2X8GXw+R4gJ4Ut90?=
 =?us-ascii?Q?SQsSR4BrCncm11614WIbvUorl2Bnhaeh91Atnup7lz1WgeADRqzkSyWs2FUO?=
 =?us-ascii?Q?GErejl3KSKuTW7FS1TPHD6ew1J4Yv9oAupoyjEGgej4x6A06NZIl4swImL9J?=
 =?us-ascii?Q?nZKl+fmRCPn2nTgmLrk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:35:04.7264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd87088a-9d26-444b-0939-08de22229485
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698

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


