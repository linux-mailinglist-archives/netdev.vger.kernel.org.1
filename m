Return-Path: <netdev+bounces-96596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B38C6966
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B9B1F223DA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5000155747;
	Wed, 15 May 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cv+pTCQU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45A15573E
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 15:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785951; cv=fail; b=AJl59p6p8eavYRhsWpzxAhfzA83oyfTu3XcvlK7uzn9CuoALLJHANkECzOL+/g1WSrqvJZifH/RB5XF15djpLGK3yce/oHZZQ4+gJyWnstnxO5/X38L+esSAEyVNC4RFJZnBiOFkD8yksdyvtDKPV9cvXyvRF5QTrx2ZWWZGJ8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785951; c=relaxed/simple;
	bh=kcVChucgLxwaynYmyKBycSxNUa9cdUHbFGr1iAd/EDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGMFdHoeU/AvIMvUivAWYH3pOBUi98Vyj+/QHD6PdpCWAcgw04rogr3TY2cyhYveBIRqeop2FctttbmCmGkSwVLvGJGvTk0KWkGx8uSRKd2i4gv390AnIY2dO3ZLHBiJODw/NreEnG2q8uyohqfrMR1JA2fPLluvFEVFuCHyXiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cv+pTCQU; arc=fail smtp.client-ip=40.107.92.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJa8rHYuIyFOtxvsz/D4eiF22iRQfNCYYJHBqnPCUUo2ymUwTS/OwncuJcG8gJV3afY2NRMQXAf1fplI6cfemKMOWqUyDyIX4FBV2nFVr22pKzjshYUqZBaB7GC9gjmvcSSYQt9RVd4oQNin7rB/TQmoa2+d9+PtYOAAiw4wR/68YumjF1c2L2XCPiBqEBFVMhc7GGteyKTzCfyiDxdrKWBNtlARuRXXp5ubeH1f18dvtqaULEziCz1LieoYymid7XUUt8DCS6/9wopkBFvluRhpmFWPC4ECWI2JpyUfyqEjUcfC21QXemqp6YSKOjQd1oqmOtzQLmmbSezxVsBz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4f3mBPn8MfI1PsKxymSiMMf3m+f9zLb9vwJFG7kdoFo=;
 b=mTCwGnmXlu2hBu21+bQt79qPHSlwYvVuK33t0HxH6944ewvTvaBe6v6MlgX1NMYt2h03LnM6YdxRjyzrhsEE3zr9s0PGDthFAFyxQh3A4nl6LINo+Em1tP3Zt+LKVOchfEU48hWOs5HDNgOgBw9iwCdZy4BYkST7UQRMqUihABQ/zuG9oCCtfe1SheLlOOdZyADXLxnbwHBSqnTvvCD6yeExzXxat1Rf2ThoTztRBCItG45WRqifSsoje329AMdS0z9TRQwY9g1+hiGaaSWuvutZEBb1nPAZcgJe19hMqvcxyQj5H3E7o690nC+BlXZy7I40ng8KTriLlKktY3X25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4f3mBPn8MfI1PsKxymSiMMf3m+f9zLb9vwJFG7kdoFo=;
 b=Cv+pTCQUEAjktTjDVuHJ9ijpKFWuaNzEOzGvw4tp/1Zy8rhnH591E10XbjLE3GNwrXfJ2O+gNdutVjkvF/0mBKMvvTNkh6cNaosdyjSFznCIVqLN80eUMMoVuf3ff5K4hVQ73oupck4G7A5bvM2raAYY7iIb4FtLJDcTpBEvfdA7uSkt5rEdhAp773ZwjXlsTpQgRP5kvs0dUlOAylp8Iq8wT/957Nm8h+rLlbmX8o81ztx33Z0XfBzU2ZpQ8wMv3jf8NzoL+JDz+DGw+fxGBytoRpth7gLZaI+BTMdZDkWw7YmweyKfxakbF5Pw6A/WdxEGueTVor4LBs8rCbSIlA==
Received: from BYAPR08CA0029.namprd08.prod.outlook.com (2603:10b6:a03:100::42)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26; Wed, 15 May
 2024 15:12:20 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::c9) by BYAPR08CA0029.outlook.office365.com
 (2603:10b6:a03:100::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 15:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 15:12:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 08:11:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 May
 2024 08:11:59 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 May
 2024 08:11:58 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, Eric Dumazet
	<edumaset@google.com>
Subject: [PATCH v2] virtio_net: Fix missed rtnl_unlock
Date: Wed, 15 May 2024 10:11:52 -0500
Message-ID: <20240515151152.564085-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2e5a56-2c65-477b-2fda-08dc74f16a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m76u1Xe+QW9zZ/tWkY+U8KDviExtgfzHcZz14v00zDU/VjSBmzpYJ5fKhNVH?=
 =?us-ascii?Q?Ktsd3JcE2ujGwVkxuTPy5a8xqZDdv/hGBYZfS0GU3cih8xjAdsI2wrbUZdk3?=
 =?us-ascii?Q?7xf/in2ty4+vuHH79xoH9kurecH73gyLZ1xenyZTzSnY2raSCKauchXSub1l?=
 =?us-ascii?Q?U7H4S92QoAaZrfjtYpWuW3135Dq/l2fs1T0r07e25WphhJUTTX17NG3t+d2z?=
 =?us-ascii?Q?8dT9E/CNa5Q49PoiseLCYA/vO2xnLMqo9mLe99n0TC0I6vo0T/48f0GMODvw?=
 =?us-ascii?Q?wZL+PRdtJk2sB2vshBP+6ALH1/1b2FnCymDBv9exPQVakFQ8KKoK0pzSSRuq?=
 =?us-ascii?Q?ASxrZucfqr86FwgXRXScJ5aqmlAbRv+WPt03trXG/+qT2b4NoNJCmiI3dan7?=
 =?us-ascii?Q?az4pk6fyGeVnuC1ds51vZWJEx5HZhoaxrHqhDL2S/JMQzBt7znb+nTrrhn1p?=
 =?us-ascii?Q?KQC5CY3XQFzkpzJHxhsq44kXni4siDoW3cC6FYTwHiHkVwUFNEs8nb+R33sA?=
 =?us-ascii?Q?Zyy8rJ83OE2Aldd/ulci4hvS0Yk4SxSaXThKyopQ+ZoXTuc//y20hizJuDzf?=
 =?us-ascii?Q?5kOZxh6nxZwV+WkyGqSapOu8tzzudAqE87r71iATQafLsV+SFwAwrXe3zO7x?=
 =?us-ascii?Q?2ShKsQINHQzc9sJ2tnXeEIp38BeNt868pVvAurJqRhGMyGbMkYpXqWR4Idiv?=
 =?us-ascii?Q?ke5OT4rNgMmcaNyWJHAuVqIuAV3kgo/uUVb00cTyiTBimWwKqwSqzeLM8FJK?=
 =?us-ascii?Q?jQ5XHbhTISvwvkr5PI2sA0X7T11t5lZez3A8DdqCQ3urb9nbsDaT6FF2xKPb?=
 =?us-ascii?Q?cULZPFFwRUv92fyLJYSEqhImYUQk2jEySR4l1nZGfL6O4+rE6ydYLZdwIHpz?=
 =?us-ascii?Q?HFs3s791mfqryeH7KysXKyVIpxLUaPJYyLkx4oTemxfzqCZdtfJJ+yRGx3tO?=
 =?us-ascii?Q?drouYLRBZ08G+lQSBDvyIBGy5TYvSzrQFWaj7AyXnK8OCtpiD6slZOWZhFGk?=
 =?us-ascii?Q?ZstzBfW3pTopjibdbNBfTE8TCx17v2q1/5UFzODVuVDjB2FSlhitPkLe4aGZ?=
 =?us-ascii?Q?9X970tF/HGo7jXIuPzz9ZanbmM7GPEEaTEJWn96zROekE8DMioFTvnvKAnDk?=
 =?us-ascii?Q?uqnNSxvIwb76vwi7h4Je1SxP8YWCx7Gq9aaIrwYDb4z98logpjVcwDOILppF?=
 =?us-ascii?Q?NH2DLpxUdkBBCoHAU57izxwOh5zwnewhF9LI13ZyVzoGUnn3IkfWCbx/xNg4?=
 =?us-ascii?Q?JXC5bLCUuFSSQB1NzhNkWQT/+2jn1/nHw5liAju7bS6G8KZeaaj4uq830O9i?=
 =?us-ascii?Q?S7JN/L1i8hMMPhFjCWY/ir7nczxcI3jkZciCjZFD+biPYAxrpo2jC7/gE5fN?=
 =?us-ascii?Q?x271j5KNqHMpnn/5kbgyd64bI5vZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 15:12:20.1611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2e5a56-2c65-477b-2fda-08dc74f16a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581

The rtnl_lock would stay locked if allocating promisc_allmulti failed.

Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
Reported-by: Eric Dumazet <edumaset@google.com>
Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 19a9b50646c7..e2b7488f375e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
 	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
 		return;
 
-	rtnl_lock();
-
 	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
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


