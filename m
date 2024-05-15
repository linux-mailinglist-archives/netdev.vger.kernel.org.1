Return-Path: <netdev+bounces-96612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B818C6AA3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E085A28542C
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB3ABA46;
	Wed, 15 May 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BX6rxjzK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EA1392
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790723; cv=fail; b=GgghSf30Wf5nloBk+/88C9qXwHB+N4hZS2N0Jlh6T4o+DbTSuNfFiGzzQYe3X1yvmE8DNxIJ7IJbxf7aZHPXnDxHRiYuXnUo2EXydnLD5y7RRiODUee1O+1Ap3mvn7qyVQmSd+jnwV3+3+lmkXPcw90bA2ON3gxiRYNW6ESKVrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790723; c=relaxed/simple;
	bh=MggjUVMhsZsVZIDpD0tuKk6IXs2LzRj1/MsGzF2VOCA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/BAInbOrTeFxAOIFCdgdiCBTuMIr4TIsuzQw79ZyfokKH2+fnJMGNpTzamLU6LVWwOy3cOXvBOS3VDRWiyTbXpiXKEhuTSqz/AB9OVeVYNUysx6N0CaQvCrjmoCHJzMwCFmODTZOXHWWJGWKSQUIVzT87/z8gairRld28mj/yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BX6rxjzK; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c88WekXe6+wHvBeNmFzXZlF0sZ3eJHjQ9eJgmE14bf0fKQYVDG+XUxYIoObL4gr2LgYnl4mwfOHcWTTsxlOoI79hKFHfNs1QcSUIAvQJ1r9zpZGeJqEeRJEchxg9bn5ZCrP8+CQjr42LXxBjgUWlqAo5xnLvRCmu9tNdyERDr6wFdbkfy4HyOB+zg0PcppR0MwMXxr1j1PWfH/eFwqy1OnDMARofl1qoFEFZUVbrnMQ81na5Nl1Q/3VRwDGLx5H3BonowDPe8A63GR2+0tfhPXWqBT8DrRi4BST2qTIaUB0gdfYWWhYdxKwv6f1b1xn133/fVBCBDyQn0sxrufJd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBIvjOs88Aj2CY6XbOtzW2LSJ5cGx3sCDIYKJJTiWfQ=;
 b=c3bLakC6/B0EHBKsMbBbgli4xjy0ZnZXfY2X/9hGfRXc2hTDxVtrJTJkCU72yAhe35nBDocsr354AN/Z+xZ23BAQAY3vtkCUF3ne3KcxKzMoJFwTXdeY69ztNkkJaVLEC7bmz8A5Uj6r5uEG7tXfqA91mhtkTb6MJKNC1qxadwQvA3Wz0hHbbxyDDC2N4hWQ4i9ac/hIg6+8Vo6MYUlijcjIoGOMaxKItvrk2VLp6tTHLqZFZpHcPh8sr6y+AdySXX4iIUBWsbfQStYxXRRSy3bmI2g4Mw297rN7X2rdMFDhSMv6KoGT/ei2X1NDAhC+rWI8n3d8iw1Ov2whSYNdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBIvjOs88Aj2CY6XbOtzW2LSJ5cGx3sCDIYKJJTiWfQ=;
 b=BX6rxjzKHyI1xUuNCrvYnrpNoXg8TTuZzO7K2xEuxgkDMgAIaedfuL68dJuagLduXM9t6B7XAP5sQ++qNcLpsMSYcN64E4I7Ty/BjWtajqEGF3fbNOk3Dta0Q9fNLxAVgxKUp9xONkDBVZTDfjz3PYF9TRYTnjRWU30DnvYcfns76hhEbV2d5o0vGBebEvOT5bESo+G3XP9VhbCwJz9C9bHsfe0uIJZxYDfjqg8bvFiT5tntcozdJDdjQkshG0f6SBRESjuW/WbSu6XGTRcRgWVebNRo8nVtvRcTgeiKSFEyGZ4odMsC3Bqnlq4wWbcizJcy6j4UJEnAeCML8zpvEQ==
Received: from DM6PR02CA0059.namprd02.prod.outlook.com (2603:10b6:5:177::36)
 by PH0PR12MB7905.namprd12.prod.outlook.com (2603:10b6:510:28b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 16:31:57 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::e0) by DM6PR02CA0059.outlook.office365.com
 (2603:10b6:5:177::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 16:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 16:31:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 09:31:31 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 09:31:30 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 May
 2024 09:31:29 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Eric Dumazet
	<edumaset@google.com>
Subject: [PATCH v3] virtio_net: Fix missed rtnl_unlock
Date: Wed, 15 May 2024 11:31:25 -0500
Message-ID: <20240515163125.569743-1-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH0PR12MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cbeeaf-d8b4-4753-032c-08dc74fc8992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/kBOdpb09xwpjV+aqf+mOc1PxlYd96AVXD/9cimLRKKtFd3ONlbQ+jrH88WU?=
 =?us-ascii?Q?YNQn8jWGn1aioJ8KCYSmHQuaCI6c/eadI8XFWJymNQFsrXoH1OdgplHOeDKN?=
 =?us-ascii?Q?HuJF2dkXFZN8v/3b9sKAMOvY/QwgNtVeVa0XQ9gVbjG/KHQ6Hhq3e4K+awDw?=
 =?us-ascii?Q?R8K6nliC2OS5YeZre2n2T0cEwBEL8R8fLKV7JoAagw8ymLKZg+b/n6ASbLdo?=
 =?us-ascii?Q?XSxbQFQu3sKfDN4kVRShkZn+RKfcYCx0SBWDTuzMDDMILT0ZMu+zJ1l1Pj9H?=
 =?us-ascii?Q?cgVsgNK/0NIAPt6JCam9odSLRl02cEUtPK8pS1o3s5XY+IMF/g8pDFL8pNAn?=
 =?us-ascii?Q?iaBbErCAKBTEPauK5PnZr4fTWuwjSZC8deD7D79piph0NZhEahInWfUr3ziw?=
 =?us-ascii?Q?PgjSbpXmKMGTeMTu6D9tlznOe0cNnXLlwV5FouJxxggB0JnyTnW9pelFLyId?=
 =?us-ascii?Q?l/RlFhqxShD+HRAYqa+t/Yc+jFdcvT7eylLCtbXxzeTKl2f0vaSSv2M1EAEd?=
 =?us-ascii?Q?K/N3+9WBfiigpGugm4KrdA/FL72luaM8BZM1f1n2EPsVjpGOotjKJio5Tnwo?=
 =?us-ascii?Q?+aH3Slzb6avs6oNjGo8JDQrAJ/vArQVKBQfDTAMRy5wiN/iz+xL4N3NDhFxp?=
 =?us-ascii?Q?9IsSxoYPqFsz383bokRmrTTiP5lBSzACMxtDoEmqUvlnNXHaK8dkve0luVuF?=
 =?us-ascii?Q?tVE0cbB8uBeowQzqKZBRBv9eoOhztFzq0+7wDe32HTKqfzkF6KVfq+jjJg5c?=
 =?us-ascii?Q?swfzPxqwfDdS9PBEgZgC5/Q+UtR9ylBoLLj+k53A+wp2X28wVEJbGgSJH/zG?=
 =?us-ascii?Q?Vm5Rta0H8kuzeTtLDG9CTLPx62eEMT0xkQcu5BWYLLG7wnUWlyuJTjnTKPiv?=
 =?us-ascii?Q?fJG31b64efp4IajUp+AsJcWIQYvVVOTJhsSWhbd5cf2xKEmr89d1PntOM42Y?=
 =?us-ascii?Q?6pZFfneA+Z5eMzGpoWYv7pngSrdqbol1t9JEQoaxSNyEvxKDqf7VrbOTB5J4?=
 =?us-ascii?Q?/ljBhjG6DcEkA1gOaiTPBE0Dol4z+wuL+JbghnD+F1IM8zIABS9/J9CYgZfM?=
 =?us-ascii?Q?vKMeD7P2n6bB9VfPf/7nm5/Ls9RykseJUsBvapkCey/OnAPCVPRU+87GuHc2?=
 =?us-ascii?Q?8q6023g+4xXbNMpYOSyeJ/HbnCCUtS2VBCVbB7BKG4uT+zucr0vuneToQM+C?=
 =?us-ascii?Q?YvSnsEzAXfgh1IE19tgCJ8tlLAIVAFPJJ/Dxl9EzAuYhGz5+5/ViqpRp+FyQ?=
 =?us-ascii?Q?/r8exetLD1aOhCeS1YWOod/UZWMxbQwFLP2BIdS9NZwVCZdzJTUEjQ1lgJXP?=
 =?us-ascii?Q?ss/AMgv3CBblw/QvDYyqKpd/8EXhZ7Wu7GaErJahqXex4pD+4mUsM4OT0fKi?=
 =?us-ascii?Q?69mLmkb41Q3kz9zYBUIKIjUincMO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 16:31:56.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cbeeaf-d8b4-4753-032c-08dc74fc8992
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7905

The rtnl_lock would stay locked if allocating promisc_allmulti failed.
Also changed the allocation to GFP_KERNEL.

Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
Reported-by: Eric Dumazet <edumaset@google.com>
Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
v3:
	- Changed to promisc_allmulti alloc to GPF_KERNEL
v2:
	- Added fixes tag.
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 19a9b50646c7..4e1a0fc0d555 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	rtnl_lock();
-
-	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
+	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
 	if (!promisc_allmulti) {
 		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
 		return;
 	}
 
+	rtnl_lock();
+
 	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
 	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
 
-- 
2.45.0


