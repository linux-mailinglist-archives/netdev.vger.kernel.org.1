Return-Path: <netdev+bounces-93359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7B8BB4C9
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8031F264B8
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88C158DA1;
	Fri,  3 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WdrUCgTr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E05158D9A
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767913; cv=fail; b=L5g5xk5gFKN0xuPtjrcWY70dzVJY+2ctwqCMKDa7tjtwX3qhWebGF3zNGwFNwolldnqYVji4BR6+8m9N9iDsT+sBkIkjAOhZeqWFIOFKQDi0hp5uAcV09L3bLjZAjI6MbQwKZ0V7b9oZmH2DVlIm+Ov4FtKjrmdteaRsmn5ky0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767913; c=relaxed/simple;
	bh=BNQA0K8t/h2WEJmX5esJLqX5EbVUtBtGRGXFHsghqjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BADY8TTkeCUQb4lQK4GPb2Inh8fZR1D4c9xXR7dVP4PR358+mZW9CKQimIUr9txF3p+2NR2OqKtDxKx4dfwDVJbu/hxz0h2dn+goM47FVXEFfbm5+J+wprhotgyOJjrM7BCR23rPS6lvJpHoAoNDrYe1hbHHZ+zUTyzRLXo/fsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WdrUCgTr; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBAde0dsaDZ77YzxA3wTO9h9bGFt2kN3JCXusS1ygLFbCySnOITT0+zIAxP3sdD5r+tXOv0f/KOty9a6Ort5a4pCs5XqK5rbuwVbnj4plKqYXiMP8k7Mgw0iqaZ8NsWrB2mFHkqLGIUTkRqRC/ZGhd5MYi5HT+Z9OZWIC2fThFrwEsWe3ktp+z46rgRJMVhxh80CULm6arl4i9PiCQsmkDp2cQEcZ9TE1lrIZ1nc7URPtk7YiHsAz6pjb9zIpg7IVhAbnzAdII8VJg4vQp4kom6E9rNWxrMHsg8eLNJUTZEhm60FQlOIDvZQEQ5+Py0wfd1SGRqqGvH1S7QvfwVWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uj//Iwn9b5WqGZ60URc+2vucVHKJcIEa3EXV0FG/jiA=;
 b=jV2jZh8fIA+H4vGWMEVZngOrkAGdsaMB7LaXGEAFJmFz1BFUljCpH3I+M9AzW09J0llA6BY2s6NeMlKvKhIopa/a8alNhs63QlPUd6b9Bc8HsgKzsI+we6N+zj4NsTOo/poOVzI+RTUab2JeWVkVAThrUD2NgP7P6FsfKFSn1090G2Re7NYG+nbREb4EYJYLDZnp93a3wg5SYE8P9pQaKm4B376t2K+wZilUHto77UTlQNoNPBU5Z5ZzF+aHGikVED4+jZ+RLsoG7m+yahWM8nX2XUTJUwUfgP2o2tb4f1rIZ870RzliKeMxR6VEo6T7KIxosoSX07S8C7FUq6hugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uj//Iwn9b5WqGZ60URc+2vucVHKJcIEa3EXV0FG/jiA=;
 b=WdrUCgTrB0YCWWdu+sPDivrc+JZLHT5eW3kq2JlUz3HVzgKxJldxCrrijZkCLMjqpzTaGnrL3tdIA/BdBBdsDghlT44JnV6t8BIuqFU3zyrAtztdhWJQReeLoTb7P6sPElZyXwoKk0ecENq+vU7ePiVmhmzOj52FBCVt7Wx9XcIYHn7ifkvDJQmY6+dWnj/O0SzK3ZXztwDzzLsyVe2mTYUuIUKMKbONn2CTsVjY/L4F30sT91Zx3odhzFS9qmxIl9R1srX+zNjPO8SdIuBzHIe0KDjNJQc7Co+QSeXXHQA63iofLZvDkUbq/8xh79Dbe7XgmXhUxbF3jn+RUYxGZA==
Received: from BY5PR03CA0005.namprd03.prod.outlook.com (2603:10b6:a03:1e0::15)
 by CY8PR12MB7516.namprd12.prod.outlook.com (2603:10b6:930:94::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 20:25:07 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::95) by BY5PR03CA0005.outlook.office365.com
 (2603:10b6:a03:1e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Fri, 3 May 2024 20:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 20:25:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 3 May 2024
 13:24:54 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 3 May 2024 13:24:54 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 3 May 2024 13:24:53 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v6 4/6] virtio_net: Do DIM update for specified queue only
Date: Fri, 3 May 2024 23:24:43 +0300
Message-ID: <20240503202445.1415560-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240503202445.1415560-1-danielj@nvidia.com>
References: <20240503202445.1415560-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CY8PR12MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: 666dc3bf-018c-4016-f85d-08dc6baf1f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DE3v3KWGLxprVY5BES64e2yZzYPfmUr/6E4xcwy+szRsA6H+lzm7M6RMrhBq?=
 =?us-ascii?Q?Sj2faaP+fdV3LP1Erhm1FAlBZY2isbx6cet0yrvBL4ICFL7gfINTfTtwrQ/t?=
 =?us-ascii?Q?Emes7B7Vilbrx3w+eNrofgQo16Yio7F+VCcu02kXRPhkW5Mq/FmayKjq+6Ow?=
 =?us-ascii?Q?hur1OpqpMhG66SdyApeyIR9HCqQ99I7fXKcbDRUoz1ZRVWg8SNCUSNhPX9t5?=
 =?us-ascii?Q?oKLKSpL/gQW2l/o+y/duN2yM/dbj4yoMDcRpu/YHZEqttmeQKlXHhkUlzsDG?=
 =?us-ascii?Q?O18uI0FUz6j7Ctl8ZTio5UNrN1ceo1MlBvtoz98N8KhKrgbws0tvSSGNvcCh?=
 =?us-ascii?Q?WSwInQmRZ85mtUjCR9PTPwwKzEYhuQ1PI9RctJ6fVMuMOX+GJzR1hEuDD1ck?=
 =?us-ascii?Q?bKFXkj7Mi+0/DE4gBza9RO5ycO4+umK1p8CtlyagDYWqv/3jDw3rWVSQ8Mii?=
 =?us-ascii?Q?zkwQGqSHR57nefP0Nb/hli2OP25jIQCLCToLPPBcpqXizJ4/5YCkHrCpNzix?=
 =?us-ascii?Q?zYpYWwTu0hW0iWuYrmCccJBAEXTzII6rL3c6zAtyu069m832x0iunX77dQrN?=
 =?us-ascii?Q?EAGGPgr4kmtkVerJom9xlNZHuJ88g3SkbJ4wBQA3GMM8ZSPD7m9F/G6MBnIc?=
 =?us-ascii?Q?rxI+g1/ALWbPDC6URyBdG3aVYzJuKpxD/b1oStw9NjO00cnZ0Bl1q+nxXFXQ?=
 =?us-ascii?Q?+TFSD50G3c5y0FVJmYyPU9tCPMalcr8m773GhwYaDw6eEDNSvYktVicYlBZF?=
 =?us-ascii?Q?dSbuf1msIrFqjjkMNnkotfq9eRDhcRP4foj7DcDa6ZkvS77Gf7kJRkNMK9AI?=
 =?us-ascii?Q?G2h9a47SzT8Oh523nDrtnk99u0E1nGeGeJdTl3P/jdm40xHDb17utecetTN6?=
 =?us-ascii?Q?VA7+hcnL8k0tZvL2mCKt/5OViHiwgHs2mZX9RPTyIPe4EI5hfWXvJnm6V84G?=
 =?us-ascii?Q?c0JFmHqMONND4vy0ti8VT+0nxqQyK4UUxbu8IyMeOhWuVAe0SOF5CtSVcvS2?=
 =?us-ascii?Q?CvUd5z0gFfVYgsEy5qHxzYQ0Np055JiTWN9ihRh8jqQw3d/EfvI1rDCdxmVy?=
 =?us-ascii?Q?UmwOds/KSJxXBBSLJ7ZhTxwiPmRVsrGsqCQ9e1YABI0uX6anz/eVNr6n77mj?=
 =?us-ascii?Q?VVMeglSADKEK2kuDoe9IPC/V6/9lbdMeWb0TV/qdfhFmdF2qHuYwOUL8y93S?=
 =?us-ascii?Q?u3qwmfCf2mcjX6fh+uerjU2SbK+wGdw8v2QSNRrltZ3pbhlwyar//0VfHpgi?=
 =?us-ascii?Q?/jWXYHoF8AdtHLoNNX3NkggC6YLXTLXEWhkEW4G48QTW9PpxMi1N4moMm3YX?=
 =?us-ascii?Q?pZnq3YhGdsLyhC0w/BbFpI8gIBF3b2P+CJwVxHn+169jyak3AKokLkVXTOAR?=
 =?us-ascii?Q?x55d0YsE/X839nBZq7BeiGiUT6Un?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 20:25:06.7220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666dc3bf-018c-4016-f85d-08dc6baf1f49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7516

Since we no longer have to hold the RTNL lock here just do updates for
the specified queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d7bad74a395f..386ded936bf1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4383,38 +4383,28 @@ static void virtnet_rx_dim_work(struct work_struct *work)
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct net_device *dev = vi->dev;
 	struct dim_cq_moder update_moder;
-	int i, qnum, err;
+	int qnum, err;
 
 	if (!rtnl_trylock())
 		return;
 
-	/* Each rxq's work is queued by "net_dim()->schedule_work()"
-	 * in response to NAPI traffic changes. Note that dim->profile_ix
-	 * for each rxq is updated prior to the queuing action.
-	 * So we only need to traverse and update profiles for all rxqs
-	 * in the work which is holding rtnl_lock.
-	 */
-	for (i = 0; i < vi->curr_queue_pairs; i++) {
-		rq = &vi->rq[i];
-		dim = &rq->dim;
-		qnum = rq - vi->rq;
+	qnum = rq - vi->rq;
 
-		if (!rq->dim_enabled)
-			continue;
+	if (!rq->dim_enabled)
+		goto out;
 
-		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
-		if (update_moder.usec != rq->intr_coal.max_usecs ||
-		    update_moder.pkts != rq->intr_coal.max_packets) {
-			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
-							       update_moder.usec,
-							       update_moder.pkts);
-			if (err)
-				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
-					 dev->name, qnum);
-			dim->state = DIM_START_MEASURE;
-		}
+	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
+	if (update_moder.usec != rq->intr_coal.max_usecs ||
+	    update_moder.pkts != rq->intr_coal.max_packets) {
+		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
+						       update_moder.usec,
+						       update_moder.pkts);
+		if (err)
+			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
+				 dev->name, qnum);
+		dim->state = DIM_START_MEASURE;
 	}
-
+out:
 	rtnl_unlock();
 }
 
-- 
2.44.0


