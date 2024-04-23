Return-Path: <netdev+bounces-90340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96378ADC84
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94671C21B8E
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730831CA82;
	Tue, 23 Apr 2024 03:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQtzW5RD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FC1CD3B
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844696; cv=fail; b=hi/XUvsUo32FU9ajKY54T+8i3kpVr6AG9WVjoFxwfCXjomn2klVrvWzhXd9/5/IXybeoMgABahp0NnixckPLI3uczfduf/TQdvWduYM16/cEhdKTY2oekAzUMvZpnpo+PfJvqLsr7kIPXNcSpxeMcNd1wuSLXNUd5NdlcunYaPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844696; c=relaxed/simple;
	bh=ekmy5GIxckeBoex3o0comzFUbdMH7JBLVPt2nv2HyG8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UqP8u9TTf/s/B88GWtmq9klVHsxyPEx+QKHjZt3r5vNDICTJgFURIfJKvQiaMTpkSmp7AG2JgnLySUoyEw29HjlkRKME51kspIRNmbeoyPfYAZ9biJxabsDRYtrIM1nCNXgH1jZmzC1+Bw8Vd8p+QW8gKGgPx/0hlw5q9Jbral0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQtzW5RD; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjCtlLEHGQoonL9InD50PmW9zQWXmPS6MEG6NysWTC24lh85MwAiWgHb+ba46JF2wJUos4Kql1qApyHr52BGv+oJf6u3W6u8a8AH8GTIw0Vc/vw6Zg66fidHbs2uwEthONyno8H5N+96tzYoJh3KEJR08lIYXxgHNPpFU2DW9j6K5FcohZpe3yOYcuxGJz+VC464JCp2HwOljV4um9FDJIveBT5ao7NGPqB+CHapm3jBU4x7AokMHhZLj6s105+lwUk50CALxU0WRn4OIoveIDyTV8ECXsenbuoUJypAKyqh+VfItZCv0k63gGQkTTO95rdgmKsMTEy29AYl0V2bDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZLhlR0GLG/5JIzlUhCG7S18P8sFmVzFuv+QIsHi8A0=;
 b=O+faceyNKv+4Cts+0p8hq9FzW+6YhSrAZYx42DzTWtfEDXUMOXtNCj3MyWKTJk0eyszyVUcEYC/VTYEQkwe2+gFDGxfc9jumPYfIOEp89Xy0RPkXpzdDbHzVCUk8NgjoYcgI23uhN0KehHuWI0USjwCq23A+njB6e8SMjS5WrYuGaewXGCsoVKhUR10q0fA8lzx1Zv6LWs0Dq4Yz4yKc2S5vbAX9v3Wq/ZyWwIGBiuk0mx+kocf2rGuA4lj4OX7d0USrqgBVNX6RRREk05BdAkuwETDhz0+FqivYyNlzlnkB/YjVKW+xHZ2xYQ+E3jr+6l9BAkdyzOGuaILoBwMTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZLhlR0GLG/5JIzlUhCG7S18P8sFmVzFuv+QIsHi8A0=;
 b=cQtzW5RDaVw5J7BLP946ErgVEiHnoBXH/kS85ijFjG2Qc7/SR2l3xpDCdHIjYBuld7/e20PVpGtXUv6mtF3Qte0FrW48pGkeYUlrrYhsgXkwjcF3Dh0FOzSRDracnCNTLr0f/f8YwWjkmbGPUB+i5wbuqaJ0uNI/ge8jW+q5IwpfbS7fOHXHDbcwYPjNzltIhZ3RMnfFgLK8f0isuNWwn/WvJgTe/5UwxZVmJuvWi6Fid0wOmrWwbDPVS8HCWEx21aV6r/TL4DSEpVrD1xRBsI93TDefPXUFihmcdbDYYGwSwnaojCU+72efbRPmTHcNLTY00nPdtlqrJfrbOZxNog==
Received: from MW4PR04CA0220.namprd04.prod.outlook.com (2603:10b6:303:87::15)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:58:12 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::6) by MW4PR04CA0220.outlook.office365.com
 (2603:10b6:303:87::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 03:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 03:58:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 20:57:58 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 22 Apr
 2024 20:57:57 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v5 4/6] virtio_net: Do DIM update for specified queue only
Date: Tue, 23 Apr 2024 06:57:44 +0300
Message-ID: <20240423035746.699466-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240423035746.699466-1-danielj@nvidia.com>
References: <20240423035746.699466-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b150c0-ee72-4d8d-a2ed-08dc63499859
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khEkiWa0FMQsgm0P5FNc1HAfd05vllNGjrSmDxlUUjtNgvGrxI5DV/uW5rHa?=
 =?us-ascii?Q?QmaPdKLjTUWLF5rtwHHOPGYBnwX4liVpD4ibQouZQURF4IjuLcAlQK4Fs+TP?=
 =?us-ascii?Q?myB8nZAedKUVzXu8WWTupG75b5FfUKCOfIJzsPYs7EOU/A/0ibfLaWF3wvmP?=
 =?us-ascii?Q?G1Z7Kq/paAjX3LJB4GwaNLLS4VKH8iyxE1iAh1XqXJr2UzDaYBeB37rKp95V?=
 =?us-ascii?Q?tPiQ0VRpkcQordW4qJc2xiRnY4BeMj3XjAMqDAT7XiRMHttaWGUvT/7rWDkV?=
 =?us-ascii?Q?1k5EOSYfzduOGRmkCZdiARhdtNQL8kwrTddZL6GC9BcpzqYZ929ptqmVQudJ?=
 =?us-ascii?Q?mBGXnmnl/FK1MCnnXOOGX3LGQBcpmDRJq3BWLx8Ft4ZSX3AOAiB7RXQK4PFO?=
 =?us-ascii?Q?PmVuXk2fPCKJA2G9Z20ULqj+/sTpkaCsGHjCE7tg6C39KvB32FUK4b6jOqNm?=
 =?us-ascii?Q?Sc83VVHVOk+gH84SxU0S4ddS7vdZ/rdXP39giC/zfAXCGPO8dOcEHj84ZyD/?=
 =?us-ascii?Q?tnDZD/5lM/dEPouZTeNwDJmW4KbGiK45j4GdLy0iSa8hXNObkiSf+E0ylp17?=
 =?us-ascii?Q?vrXQpF1Ihp2+JgpecroZ5L3TFMCiPJxOTj9JOUv2bd0yvNgcdJccjOXrhmhm?=
 =?us-ascii?Q?Lfn/UKrk7VbPaivtNxKPK1pMc3DzkW3jystNRoTnPG8qWfy4GkNFbsiyEBhf?=
 =?us-ascii?Q?UdPGBzZAjzCY/dE5ltGbFVZSIDVRzAinO/AJB2e/MWpo45BHRqRtoVtyKvSR?=
 =?us-ascii?Q?zbJy0GzR9VgLkUGtp4lEoqEPDHfEBwapsIpEMI74mhzVsItX8/docoWOBu+a?=
 =?us-ascii?Q?MtkCyN2HoGMyHZA5+/uwOsh0wM+TTrkqfl6ME1F2+EG2xm1oUdAfz5NPY/Ox?=
 =?us-ascii?Q?+bpiKYyEAivAkksVjkQI9lBA5+gn6+supKLAAbcAJ/nM8PBgyhijPE+LO4CW?=
 =?us-ascii?Q?ddkFKCq3czeCdvkGJ4H0W8j2EH1cvUlEOi2pWtrg8SouuIp7S61bihvy02uE?=
 =?us-ascii?Q?vmrG5BdM0OaXVSvbMUtVGsESqxw3qU+IhFOPZ7YoGIfEa/nBdgse7mzboNYU?=
 =?us-ascii?Q?jXjql9yX5kPEOeWhEruFOxQHg6pT+0N5M/Qvjhia0CtLFsq6YDYs4aHP3p2y?=
 =?us-ascii?Q?13RqTvJ+Om7VgrHwoWpCx0DnDnbPXAZdFaxLlOJvoHiNUD4SAH3l3Q8WDFLF?=
 =?us-ascii?Q?PDC+oojmxTqtSgxfl4SRjFfRC8L0/NX9kTFMLLuchK8J4DGEgbxKO0TrR2as?=
 =?us-ascii?Q?ZB899MJodxLkn+XXinie80q1jbypAaIuSa6GJyxP9FtpJF8AVxQ0on+Gzxhc?=
 =?us-ascii?Q?O2UNaGpl2+GueuiFMrm+C35FrWC61plPSfckOfKsvTxiWgY57fSE7gWhowhw?=
 =?us-ascii?Q?t9cU0gZgQfv2Z/TrkD29phpH6VE9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:58:11.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b150c0-ee72-4d8d-a2ed-08dc63499859
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493

Since we no longer have to hold the RTNL lock here just do updates for
the specified queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d752c8ac5cd3..af9048ddc3c1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3600,38 +3600,28 @@ static void virtnet_rx_dim_work(struct work_struct *work)
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
2.34.1


