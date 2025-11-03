Return-Path: <netdev+bounces-235249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C6C2E547
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 23:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEA454E3C43
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 22:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F442FABFF;
	Mon,  3 Nov 2025 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rhj4jXLn"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333582FABFB
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 22:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762210556; cv=fail; b=UrPt7KwRqM7pxAGy8/9TCIddZAPMnQKzf9McLn9yaIEfzknorL5HaV1aSgVEVHS8jHwZS1oUpwFRrS3bOE3+qlGG9E9hlhUGvc3OPn0dRey2d1pZggV4nwyzkB3ZMnWYcXFt4sATNmCxtjYQSjcpg9+5QVH1dFlnglP7auFjmkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762210556; c=relaxed/simple;
	bh=Dc8533Aff9TqwV9HN1L7Ofat7h1bz9pH7F7w87LDzMY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML6Aut1n7kfF4TGDBj60MHcLnllQJxNhtFU8izIAuyTaZHPg6B+93K11V8jbFqR45LY0oLn2Q+VpxDxeWaj9f/oY2R6nn0QN0Kt668HQjKDKSJe3+w5wm+8ZWvALQBa48/PeAVdcyanASbBTN6+/K7rtuqqidQkAYbb/cZV2siI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rhj4jXLn; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg5PhwZT6NaGdRlwP1aNdAfBup83mUcPFyJ0mZn/JBSe6eQPSKxy8vsjPMwhzxbwa541tzKINoYAIGRgzJYZX84gmSc82lwpjDuy0JW2j5f44v5nm+y9vwKIk3U+YZChKaBlDyhFfTj9wnBt+qKAHeoJe0IS5fk2qXneiRdXrMhlMKbuSdGda9AXCqvMvO2Q1p4XvWphMlDQ9rDYXyM5o0NXUOHaWiR3Pp8EBn1/kFhjW0WYA6/ji2KUf+L9GIEjH8GJQKPOXD05DGbs93m9KJVQN42rEMDg2Fx2UJwSYoiFM7ClbP6quzKnMWjzKG5X22STSbZUrTHCMeZVLtj6rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=rYfs9yV39jIgVAhQVNy2Z+cPD2qss+H45reO8ZHjaTyqYEx9BI4p0QCckywx2Foq7jqv8wuSXds7NhCNxqjiyasUTqYNzJ8nIgGpnu2pAEYRK+/EWeYxLZYohKs2SEnHOy8ul25hs3Va5imh7wjhtovU2iI0DrpU64Y78EX8xs/eNCGjooEBHQC4T6/bkDlVhHJuczVL90j5z2rg8zIWUqoJxTjV86MMs9hEcruGy2J9xWnJNQbdJhvaC8PbQGhARjqrVIgNxfUE4XVXM7zxJFUADrIB5dH4BcMs2IgeL2YXUfwWU3OAsT2k0n7WpuJ3wUO31Ll+zeX60oA7fv7dgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QShZgmG69hS4sP+fAVJj23dd5ogqqm/4ha+EoA8MOnA=;
 b=Rhj4jXLnxDY80H5Nj+gg2jbddUPeFFAhgm6T2al5JHWFgCDkvdWP5ANHAm9kZyI9YPykDMzoRffQxWEm3LaNNTuSR/EbsB8pjRZpq/iFONr1YjxkA/rfg0U3pPmXBxxupP3fwCXgcG/dsgssE7HMhM2xrxhxXzbK6616xTyGSE6ZKZ8ceINEtppltwz6CaP0Yvg02TFfCOqACTfby6ljQrmCNL4c+2JcWBZlH2uAiRcfRol3i/7v7C3SQCj/EMfhijV8UBg+7lAP6NzpRoE1/zCFw7mHXuZynHcNuMrAJwKWLLYvzTdwgQk1MknsJRWHWJKWZRgOQFxAvKPahntcdA==
Received: from BLAP220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::12)
 by CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 22:55:52 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::56) by BLAP220CA0007.outlook.office365.com
 (2603:10b6:208:32c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 22:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 22:55:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 14:55:33 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 3 Nov
 2025 14:55:31 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v7 01/12] virtio_pci: Remove supported_cap size build assert
Date: Mon, 3 Nov 2025 16:55:03 -0600
Message-ID: <20251103225514.2185-2-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103225514.2185-1-danielj@nvidia.com>
References: <20251103225514.2185-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|CYYPR12MB8892:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0a755d-94f6-4381-6cf3-08de1b2c23b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ys8+kQnzWHwBNmfo758m1BnJwuGB60Y5klAE0Paaii4sO6pQZwxI0KpXGN2V?=
 =?us-ascii?Q?EkPhoBwWEwBd5xOavt/5CNXEWMu2d+pfQ/37KfHiP+4jjarsYxVJWHvEN/aN?=
 =?us-ascii?Q?2N7zNWKVTP8nqH/fzjUr3p/LtyV2VQU3dYC/od6SFj33TzU5pth27WOnfonU?=
 =?us-ascii?Q?5+Bi8J3h9jI78ZF2nz4MX4DaFX4G791qSkkAIsyYvR1+o28CbeLrs6OJHQKh?=
 =?us-ascii?Q?vFoQZ855DXgFeJT5Hx7++znOBjc/melRerHAQqFRBa3Q7yQHwyRx/bIbnzxB?=
 =?us-ascii?Q?M16L2lXnjeDkozbvF+dXXixXMKNwp4CxE5JIxgdKnArST2nZjZRGXgNyaLcI?=
 =?us-ascii?Q?AIvZSgf3v/q2d/UMIDISD3dzECzlfHf9JItsjCBmZqvg/nilFz8m3ClVqc7C?=
 =?us-ascii?Q?LAKW7ZoodX4rvc5jmCfiJPu5pHKc1CF3vj7nA7/R4tZUTXGWobz93rqh8gIO?=
 =?us-ascii?Q?WICAeatvokhO550N2FsBuvXpthG5HDON8Q1Haw+Y/S2gk2B1QWBZ1/auvsAl?=
 =?us-ascii?Q?GdkfNuo1A/YD6XpLh/JrMvhwf5zBV6WCWN26pzm4FCGi7TasJd43Cw6XTwzO?=
 =?us-ascii?Q?bTlp50BiPNUcbOlz0SagFrGfVK+aTrAjp5zS0M+ReELJWa4tvKu4vx8+kNxH?=
 =?us-ascii?Q?J4PUWkvtP9cjzeG5domegA8M7heYKbZ3dXwGrTQRYb2anZ1oQXMSW3Vnnhg4?=
 =?us-ascii?Q?oV3xgq/BZ6WHgmd8pTiB//B8Ve3WLYXCxEbw/FGi+3PaNKVnxsMuBoz1Ke01?=
 =?us-ascii?Q?GsUXl0godwzNPZB9M3LiHKOQjhjiWtGiDUQSMjitPE9y+Uodmx44060dghNr?=
 =?us-ascii?Q?J0qSDZS1GYXGjRBF4n4nWfuLNlKwrnlGYi4bLbKAuOQCprj1de3MxOJAqQL9?=
 =?us-ascii?Q?vNMz/62a4HNpQIV905rDOxdPFSIPFzf9wsRYgt5LxcGlSj8Kos446Y3BSwJm?=
 =?us-ascii?Q?mbNKen1WPm7//jbONyaUIrrv+5HuACXkh1D+umFZurKncV7SvIdbj8eeRYGC?=
 =?us-ascii?Q?yVoIyngEbI9z0EqC7LcRTQBvatzYyGenGcq/w6a/cZTn7UdHwABFRaccE+zd?=
 =?us-ascii?Q?mRRG3MmikvU9oiY156lQ3m+SowEJz/xysMgi/c7PWUd9RlbeZBANqwIi8hgQ?=
 =?us-ascii?Q?JJdBJ9RuUnVR60EEbzZAHot+dLBArhRs7k0Qf7sDG7eRWBGin+Jl1mnrna9G?=
 =?us-ascii?Q?ZkMcpwX7FS6madx0jrURokM7JTCJq+3o1HibfLNLMfK7fGbmXKwuP8+BpKpA?=
 =?us-ascii?Q?3/shG4HuD4kCgBdiA7zO1kE/fzkDUe7rGfGpDSl72PHWQg2mbbSxEH2ugrxh?=
 =?us-ascii?Q?WlF3pvtHDcflKXFX5WlIlYdLvT+fsazivcsNHbJ+acVzcu8Sdpm8+78C5ve3?=
 =?us-ascii?Q?PRnEuRU4A8iimZbziF2nY8gMLF1QZJYyrbL7IRang0vM2OCYkPbSbxG9mEzB?=
 =?us-ascii?Q?sR45BxtZhgDp4aOFSn0KQfp8+dd4rrEZKsX3hXYzMzPX8pqsomp3K94vlw7j?=
 =?us-ascii?Q?qcqTPnh5hzoAvmGrTlVwFQR1eRVx2gzFP7txcM6klxY9OSskHKsCHwBimwta?=
 =?us-ascii?Q?bIru8ReLR6fvmSkHVAc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 22:55:52.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0a755d-94f6-4381-6cf3-08de1b2c23b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8892

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


