Return-Path: <netdev+bounces-87527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90328A3692
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F581C22B67
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653691514D9;
	Fri, 12 Apr 2024 19:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yj/ON2Pr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA714C5BD
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951630; cv=fail; b=PtMi4wglbXkd9kSMjyfSeR7GksnUiqgR+n3ZMB/q0VTJLnWOPqPiPp8rdLPcUURhhIfFJpi74iiPDhDGMGr7AtCYxB2al0oxJ9PIFYQ1DL10jEm+SFm5/8vHsJNpCSWmSS9C9tNcUBAmQBR8ee4v5ZXR9L8VzOQHDiN/WQjFw1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951630; c=relaxed/simple;
	bh=OzbVviY9qdq/q9nn2z4N74fmYCUXrXKaDn+z+niDbpg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oK6EgI89NL9p7IZ0jhW1kMDPqKQAuQWB2XsDevtmsNWwyz6I6tVRmy5K6Ut0gv14mjv1v3XE59I2te0mIwnQN05IcXtga3dMaSfvO6ITe3qfEhIzcAoEmfOBc3r4lPDwxdJTlYnsCv7h7YNhJjKC/gELNUNQYhdbcMxunljz8Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yj/ON2Pr; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwomnGkta5t0KW89u7AtjTKq9vfNvbWbLXIgRcrnv6OLbMTUmAROepGHSGRAbkmYlW9rIyvc8Oel86MEUhimPSqMZnEeHHvOJ1j3o+yeI9CU0LwBmNyU+o6Z0Iui1KjqHMDZQ3tMbXqKtpQUrn7tSJvVMUiVDh4iLOf+gf+j80qjVOhZfzCYtbsZG2tJkPjbGLCq6e7iBnd/cMVYaWd5pRDAvHt3YkDgaJB4lMg/4xXbhh4vnJxkUY/xmKFPcHbzLOTtJ2VyvXv7F/qbS99eOXJvVKER9azlpHAaBdWQLE3Jia7crzNaDvSpQA5q2Petdl7f0owlqBK+FrkqBWbZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OP+3hkxZHHuP0fO0l2C52Hy5CFloKOKwdnnbVvuvvVk=;
 b=NXY8bt+npseBQ0TTaaLe4VG8G5KGxSc+tMDXHLLwgp44kmQByfslnMRMlxFPkA3VBSTYLeFwcW/Bhe5a8c6sD7nKpSd8xT6sI/1z6/NUh89hOhud3tWn0/MJxclCiHZTMP0w0VA71HzWtwuXYKgjM0cP1szFbEVwfQZ7/i9lWdH27hYGCnf3vQJR9Hgw62i9A/uCrIiqGRfJQFj81kv4kIrDZSrBxOTT38KhqXevp4qoZ/iRaPIQXLjpon4R+fXgpkOQX6UQFr2t0CamEFBHQCaegGiTQmIuYatE2sLRGX9m5/+SA262S/v3m7VOL99xMMMXIieIRtK+H6ATujkY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OP+3hkxZHHuP0fO0l2C52Hy5CFloKOKwdnnbVvuvvVk=;
 b=Yj/ON2PrZoSnxYC7hGLbwx7caWj/0CQZ4Y6Ir0TSIaqVhDa2jY7E+WhVKUKjnPhWLuGzWyPnRLJb6ahiXOs+LGSH/HA0qHjeqnGK9T7Wn2t5rGPu5A92w6VEpMr2dhcMYcOeNTZNUi1P3kct7ALu/r02w6ZE8gh5NsBJs2/d7lkkEOFhWhtoazyY+3wfMvQKOWi/F8rEm5UL77xESf653ZbEIgvZxh3TKCJRdFB+h1iA/Jhq8TBCLwBO+XG0XYw/V2WWgf3iKhrFuU14zzwqDqR22QSfiB/4apMNIJYC0zD8SqEF/UBSGY+9IdlyFNQHsV/OSzBSCB724FFMBxWETA==
Received: from DS7PR03CA0342.namprd03.prod.outlook.com (2603:10b6:8:55::14) by
 SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 19:53:45 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::54) by DS7PR03CA0342.outlook.office365.com
 (2603:10b6:8:55::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:29 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:29 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:28 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 4/6] virtio_net: Do DIM update for specified queue only
Date: Fri, 12 Apr 2024 14:53:07 -0500
Message-ID: <20240412195309.737781-5-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240412195309.737781-1-danielj@nvidia.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: b8672098-08d5-460e-a659-08dc5b2a431e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LO+BvGFz9uxVKngyDKSav58UrkYE79W81/1AFIgAzBWhgco7jYqtPGVHHAMIcnt4m6f7IX8qDmyXIwCudd74O9gdGGWOeFxkslWrgOTNe54G/2qibgZ9XGPA9fDXKrNY92LKSmp1SkmgpYDBaQIGqzmO56tBFv0SFdXgUVYE7aPgdqJPb6P9YLlVB6XzvQo8i+uK5C+y/0zigtZzZh718J1yiuvA2u8aZ3aZBMfAUGKucZdgMgKF0xq9AWslKJmfS9KvhtBpfnBXKJjk5SfAjKjnSRhZI3mmbJn4Y+nEV9ZKHTqFh0VI7J9OveDH9KGZhnfw6Kwm2btIBAzD0byx7QOFVDBAfCnK8rn26Xc4Jf6VEM5hDcVvPc4GIhxX+GQwJcDhLBSglyWx01deycC+y6Lgq1vpzCMQ+Ib1RrgqziN9aruJKf4pE1+DqRJiowjfEO1i/iZ2goGeFT6mmwqKFyVZ0O10v29KGBY80zVlsU1il8kgjBHxqZhbEwWSGDfSfanWJnP/+raiA0p5o+vrm68/ce9+tr7XDVERH3U/nZE+hWGAJCciYEpTMA+nzdc8OuPR7NdHXPJneVDQXryL2Z6kA7Itro81kl1wpPWU8O8S7NT9ZrvS59QPFBLkWmeYw06xESQlvgfVLTkUtmhry3xI4lnyxLUrYFBrkN/iQMalWwelO1ftAzE7dUfIF8x+diZJiGoxG/xU0srNKtOgKLR6PwNBWlze0jSELff2FARfD4uIoaSI5f83EPNPVp8k
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:45.1041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8672098-08d5-460e-a659-08dc5b2a431e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

Since we no longer have to hold the RTNL lock here just do updates for
the specified queue.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
---
 drivers/net/virtio_net.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d02f83a919a7..b3aa4d2a15e9 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3596,38 +3596,28 @@ static void virtnet_rx_dim_work(struct work_struct *work)
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
2.42.0


