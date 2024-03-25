Return-Path: <netdev+bounces-81823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D075B88B5A2
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 00:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1015EB67747
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA4671732;
	Mon, 25 Mar 2024 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMZS2SkC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217A6FE05
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403392; cv=fail; b=cm50ixSKmRdVecvn2++8nIVDSVJ5/XY93WPKR3ACkL6mixQIF8LruP3lmUMfJM4cT7Tao8hxeRxwqbMVQ+UAjJHYlOzFDUgOVDKVUt2prHWB+phOKngEQbxnPHTDxz1bV1yvpqIOJAMpuvqMGwAKNs73rLM6xLvgxolA7rgms38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403392; c=relaxed/simple;
	bh=fUrSzEmveQ/tacJU4e3V96M2ymMTxnbpApaYcYDbCgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbLID1GEzYGbUogQVirAnSMntNaLAKiQlbrjQGv2mrN5G33PAlIIUdoh57208Ltm0XNYuG3Jbj9S7FhUTATpbBCWa1nd1rKuDCNYtF/ZkwlJLvwymMz/YXWtIZAzFQfoBY/OVBWjsxjF6YZdgtOXGBA6qMZL7Bos8FWBFRCuTPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMZS2SkC; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsMKmvycWQE3mYAOwf72zk/khf/N2J4EzF6a8Z7ROnHi2eU7iP5xoJk+mdnQ2mZSJlA7c3JBiw+RL2GW/43qok6op6slYtzvb5K4ViiKiosrpgotsNt7ncovPO6dx0bM9WNLjTSCG+9YaFyWVbdp78ftvNz49r4ckCKgrp4HXRR7TpBaMD+y1nY9lSGYxLlysRh2zywuFhPurMjBpYUHbbaDjSCUlZFRDBpIJWOysrFWfum6xO4R5Pps3h4/dLjT/9xHRiilVkhSBLjgIT2dbVWyU8pNHfjTu5GQt2DY7Sla1rRRMwC6X1L876EQFmNeZQWL6z7mZtXficC7yKRdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1E3CfvFNUR8kZ50Cu+rMgjo9S0fkhN+zy7z3RkkTwEI=;
 b=RSkfM0KSjk++WmZ+RBCDi3nWwsyX49wsySw+87xTLBfUibUuNy9y0FEXU1aMHAwlrRNzI2makwlK2mBTHy0U68HGIvzA0CW7FkGdCcV/exrpCeD/IQWB2Ha6h8/SLMWlc6c9QTMPjj9DVVGjafaEKhveGrL09I1Q4Fkk8bof5hLviTvWiz/2z5me4kYKOHzsP9o7bz+Aq96au/+y9mliIOX8Rh+QTx6aMQqYGc35VFeOQOzFdyAXl9kyxIwj9Qdk9tHKDkxSW4vCbN0vOrzZmprf6DolXh/beHhHctMkfHYCMapHK4X9i12ndQ2LJY9p0DqoaOSHzeOWcQgOnwDz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1E3CfvFNUR8kZ50Cu+rMgjo9S0fkhN+zy7z3RkkTwEI=;
 b=YMZS2SkCCmiWAxvhjXixzYKI1xeD0h2DBGGQMw+ahlQbUGJ6OgMbp3kHG6QlkaJvhGmfpUBgC5MgS6EaWZrht//xprFNOtsyZAw2KtBGgaccjNXwZi/SkIKwHMZIsmVbUnIxSQLRSIeII2NnnbnT3znmq8Lw2iwFo3cvBdW7RIIxe45qJTI628n+yW0FD/SJWSEqfLHi5fDtEPGc0kd2Lu+/v/K2yz7C80+CYYV62Mmq2t31xD9ltGC5anqe5d/OeaGSNAxmC/g4IeqYmTOIjorybpxVgKYpbx5OTPzcyBJz878vyO8a+o1s6GaH1ExYhMqtHirswGFQZPpeVfB4pg==
Received: from SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::27)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 21:49:47 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::12) by SJ0P220CA0017.outlook.office365.com
 (2603:10b6:a03:41b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 21:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:49:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:49:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 25 Mar 2024 14:49:35 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 25 Mar 2024 14:49:35 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next 3/4] virtio_net: Add a lock for the command VQ.
Date: Mon, 25 Mar 2024 16:49:10 -0500
Message-ID: <20240325214912.323749-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240325214912.323749-1-danielj@nvidia.com>
References: <20240325214912.323749-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2baeb8-7890-4789-8b46-08dc4d157d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0UpI8s0G5KWolWrX0aHR6TM4dCzR4tzWJHrVrjhOZgGlIfXvHyFFDu2PfZFojAoRJY+PDaPTkkJR8MO2HwNE6f2FBP8AkEygNUS9bsd/gO1mUqS3/6WfVwqNi8uK6fNiMu3mUGxyUiUkiYxmYrGuQK9FVB+wHth/AYRFxStf3zYR0nGyymnJB5PwtWk0rVwgLzcovdxSXN9IdU8bZcrFklLbsyy3c+2+l8WaJqzDjwjIFoZGa+vJEIrVOPd2JGSkBrWACPhrZ7RJ5MPYb7WXycCv0pnEXr1TanokWhDsyXCtfXCTqH56oBloeJPySwogm4zi+Kz7+cesP9HUNs6vUBf0sq60AEdr3SauJsC91Z29CDiiWpdh7EoyX3j+iUdvY9RF3Z87juXW9px+rPOctDndYZO86pMaeO5Pmme/np0OYDm4hqMZasaUQGdPIZo6Vtw8cYi+pt1rS3XFT79HmRSU33Jr0/Po+laercIXSPEj2bu1x8VI47+QhXdCObXmY3eOFS6kw+p5+xCNibaVmf/cEhAhlhx9YfOg2LEEDUjQmlHWdbbrjMrsXI72UemH+J8SU+jHxwWG27i2+xNcfoUtXd2uM8593p0tGgyU3zEWpFbK+TWReqF5iWPhuN6hhPfuW/J12+sFZINAPnPxSltrOOUlbMkfNaiTNRyCEaAttv40mTJ+l/Kw27c9UxcDIRs/3lEdO/vTEUtCwrcbfOBrcn9P/C4ZNpNNDCbjECBw9FNs2/icD7Deno7GRfj4
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:49:47.2742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2baeb8-7890-4789-8b46-08dc4d157d60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

The command VQ will no longer be protected by the RTNL lock. Use a
spinlock to protect the control buffer header and the VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6780479a1e6c..41f8dc16ff38 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -277,6 +277,7 @@ struct virtnet_info {
 
 	/* Has control virtqueue */
 	bool has_cvq;
+	spinlock_t cvq_lock;
 
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
@@ -2513,6 +2514,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
+	guard(spinlock)(&vi->cvq_lock);
 	vi->ctrl->status = ~0;
 	vi->ctrl->hdr.class = class;
 	vi->ctrl->hdr.cmd = cmd;
@@ -4756,8 +4758,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	    virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
 		vi->any_header_sg = true;
 
-	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
 		vi->has_cvq = true;
+		spin_lock_init(&vi->cvq_lock);
+	}
 
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
 		mtu = virtio_cread16(vdev,
-- 
2.42.0


