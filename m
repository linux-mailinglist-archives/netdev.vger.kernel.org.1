Return-Path: <netdev+bounces-82722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1D88F696
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D72A294BD8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7C39AF0;
	Thu, 28 Mar 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n/ChnUMI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F8045955
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601265; cv=fail; b=GJkYkci+iVb64ucae0Btk3uanvGK6JMW5tGhdVhbtq0CuoQUYRieQjyfTEATRn9fGgRLI6Epqj5TEIm9miGfQUcDQX23kRjpdTEv3CE+XdEW7CGZGV6UdI4FnZSIUrKNvkRp2oGiKvIUKu23WSTPBgDvcubb/+D+IY7M8HlH4Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601265; c=relaxed/simple;
	bh=8asetLhAtj+Mm4mafBKKZ75rVW+ctuS2cn954eyDXjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnR/DVYfs3XIXwkASOQNRATi95HXnl56h20d9Cw2wUokfWHVGDpB0oISd30z/rDZ7zloQQzjd74LYqrIUWJdpnhLQEa0vVbTkajhR2M+6Y5WajMsbcK4sdPkPau4JX1AcZTteXwto01GYfPsJuPaiqGlfBUYd7ZNCqmEt7MCHeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n/ChnUMI; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI5Ex/I0t+UXGBWX0xB5E4oHafiSTCxXNL8inb7C/p1ffHT+kaEMu3fpwk6l/ZKFp4vWBU3Px5dpq7gRAe6YU8sWOtWQNrVt6mqObG6Pgi8qSjEvPmz7nbk/Ly1bm+iVECBTn3l/bGBlHkHEnzpC9HFejqBDhaBWjrMkMQ5ni8aN2XEhejD9eAnVOGHkGCI5+/FpBVDCf22LOLukqnUgy7FCq7pWvnr53U/XXRBHVaXeS+f5etYrf9ZdLM2Bs8nGHnxM1at+I1eIKMr+tHrgL+BxDZ2dekDAk84AKgkwu4Pwxvt2t2mvD4sMYvGaSIH6czLt17TlaVUcsU5JISbK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka69XECIaWNdry0PCShmXJjUTPA65RpARbEEbcdAteA=;
 b=SHZpcWFkjPF0B5vIfHsCCrPm2KZxQS1S4mRswL8Gw5rCXQ3nEdm288AJLz2cxAg3jgkpefk9kPL5meLY4wNZzYvCYmJRlW8fqUQH3f0lAL5eYLocEyqrCkF8bT7zqXGP+db0qHSzMtThazdZnMZjt8qLcfKQzFwzcRMExMW6/ZxBZtbs7076k9JeJi9IszZIQeLEsX+cph60qH6RuGVxYpBgghn/AtLN2G4oKTfBO0DNmTXRUr+RPyFszfC3x9rXmIgqpSLLE/TyUsqrWsq3EfRoRaZ8XsaGF2o5lGlOniihCUQ92F3agGrLbE5lJsYx18ghFJhGDo3XYefjwdxn1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka69XECIaWNdry0PCShmXJjUTPA65RpARbEEbcdAteA=;
 b=n/ChnUMIfBO5jv7VmRCcXdCDwh2istwp7KbafRPJNWaF44iIaeyC11exQQQ9nCW1wXI95K4DoRcUxhaa8kuJ5brPX4GvSfzmOAHv63nPNMWCghuRPBY2r7ZrWHJon7ocCe/m5Sq2zjYoiKahGeh52NPIc7eOZpyx4T+TAEEKamPraALTGEC2cD91GCDid6X4lgJithbxUzF64G8f19fHb87pFQSjhglJq29xiwSj2e3BGSnS8ScO0dtiyC/wgqyHWKVd3FNrM9lj9ioIkGWSumRrsNHNx83f2LsQ48Tzv3laK/fCKQwvEg2v7S+OZUMr7R7dn7vwN0ybZDs4h1w9IQ==
Received: from BY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:a03:1f4::29)
 by CH3PR12MB8969.namprd12.prod.outlook.com (2603:10b6:610:17c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:47:41 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::16) by BY5PR20CA0016.outlook.office365.com
 (2603:10b6:a03:1f4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:24 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:23 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 4/6] virtio_net: Do DIM update for specified queue only
Date: Thu, 28 Mar 2024 06:47:13 +0200
Message-ID: <20240328044715.266641-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240328044715.266641-1-danielj@nvidia.com>
References: <20240328044715.266641-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b5128b-12d5-452d-3399-08dc4ee232d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WgvCkGFg3JS+p0eVq09AYq5rfIUSPdRInzqf2aiDdDHlRWofZg2aVfUVKdVMedC7fMKitYFapKFJ5d1yYXVP1SLk3DZYixBwuUWfmTaNc6uKXh9Cc0iNdBPVilZhvFsQWlJjf+ANKZ8CVOFnubcVn+yPNIu2HGXVJA30hTILmy8m+/r+MNs2etUkFQcOF6Xo7s3J5cxlHn8A1Io6NKdmi3IjjKIE7FmZ5uEtoi8c9xGsd1u1hMU98Aaaxl65CrIzSgl/kYRa8pXi6Avf8+kp31ts+2dvNX9Cn57FEu/PuxxwlJ7YaroZ3wwMHvFFb3OZK4N2l9mH5odEPkb5kzNH/8NXAQZXv+OvNb8bRkozEBSMBt+rQPzc3EZRXVoLLNQeFfb1waySXFhg82O4MobTyildOIGZs/guyBMV1xG8tq1Xo4A2mp5js8ip6QdT5uNd9PoaV1k0VONBy9CKn7h0YMr4mqi8/wgBUxxZQvXGRw+o/WkVixNofbfpba1UjfmqQx0p9E+E0HAZFU8XV0nstzFnFvrd20+rMPDPBYloI11Lsz7UK/40AIWVDVjG0+Md/liK1Otk9LDo3lcnfAYMhy82C75NAWy+/bWcMlnV+NnCuaHKZ7NinhPTQ42apVn/Jvin/fbbiip2ZgBBBbqCSqhyY3PEacdrWR2CmELZ5fgAJjlpD9wvsugm/9r9LYwhkQIxYMFk2TBVPFVmYFTaVj5C7/RyQdvs/55lPtusQKrljexm/usDS/39mCTEFdt7
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:40.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b5128b-12d5-452d-3399-08dc4ee232d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

Since we no longer have to hold the RTNL lock here just do updates for
the specified queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b9298544b1b5..9c4bfb1eb15c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3596,36 +3596,26 @@ static void virtnet_rx_dim_work(struct work_struct *work)
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
+		continue;
 
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
 
 	rtnl_unlock();
-- 
2.42.0


