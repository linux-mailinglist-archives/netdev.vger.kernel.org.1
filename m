Return-Path: <netdev+bounces-87525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5548A368E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DC4283612
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8B15098B;
	Fri, 12 Apr 2024 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJsuvrYr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574C14F9F5
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951625; cv=fail; b=d54JPKGanUkjXQqPjEaXR230JmS/OvRl7MyaQam6R48UozDrBJAhlS1Kh1VfIshzVynekuOJvMlPC67ykSLXhmTl53UHHGXtEkOEfWOGIVuo2HGDfFTm1kKP2nZvIqhuFOVfxJ/O9932oXqggBttcuCyRTUyP7A+5qKFspSxbLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951625; c=relaxed/simple;
	bh=WmPsRBnTOg1ctT36GzpjwQXmPj051/5hr411BDH7YQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7v3ZGCNBIo1DyZKABRs37MY25EDMIlMNqGJX2sLU/0JkgkGRepoh+HoUqjwaCv9ljBPsAXkSk0V+a2+yQ6u59d8Vtd6fCRFSC0K9KL8kXGaKY6mzLTPc7O2i81D/vsWut7HtsTLRAfq3wx3H1MgcHqFVjG7/Wcsxzs/LOj7g5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BJsuvrYr; arc=fail smtp.client-ip=40.107.93.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=er6+koJXCeD0iEKZmZTUwIm6TFb04sl6oVIgpJ40SV8B03ZYDptfLuTlcgtPTBTVd1cKo0pAHZ0RaQcf9hlAmfBKWYFld5lGTDuO4oYabzg4CXOeFo0UxHuiAATo88USJlDPpZ8FU/WeIjda3wCK7sdDBh88VRxe22a2VecqoB2OU9ngOIasYlf9SFi0R+/5gssW4x+d7W7KW1EZV6gS6h2J2wcda5dmJlC4oi+qUNkWL2abCMsqKiDM+UPKua0kw4/680+2Flsg9tkYDmlnos7w96xdjoZsNsZ5WPGFBAwpG5A39ySrQt+dfMN4fqhu40tDxN3YjIzrHPmoJojzKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89qsJLn15bSs44o/Ud6PIu1rDWCaTAaoFaPLRQmXOtY=;
 b=WYnkS+nfCUMOse/gAaomsDTy993S+5uRJH4DTgO+M4Gz0Lke9SCYMABebwLp/V8rwJplL3acChvwwv5KiQsdTY6wYNbQu94gncbN06aON57VyOmLq3Z/Q+03VLTDMHUv69xZ5v5HsN+JgsaWLWvEWfHA7Lld4MahJTpISD/uVu49Fq4XUSLsRKhut8V7TcYYH3GckNp+whLtp44FnHfEBXZlRkTRR3kA1akIN7n3tIqwpm+y3hI06X1d4jkuAv1GxDABhkgCxmqNY/R11oNWUldPV1w85OrW86CiEV9kUteT1ubABxj7mmNQw1ULq6v9yN+l/wzdmWxMe1Q8G7MlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89qsJLn15bSs44o/Ud6PIu1rDWCaTAaoFaPLRQmXOtY=;
 b=BJsuvrYr+a9BUhCi+p7F7QnTD8ekxpninRHjx3P+FF+bknJhvGMW8nVGzuHodbYomlabOZU2R28aR4w1OC61jwUM2DwD54bb6Q0xkwxmPYZ5uyGN4U1Ej4OTYIrAiXt8cgCxY+giG8rMHEAgYWrLbj9W7LWOUKLVE8Yr4jlj2RecGPHPuKiQUQ76B5iurnlSP8biAZXsjRMwo6bWZCiqFX2rvzFLq3piCkXVeQpqWU96lvHj5M9grIhyyAtd0WiESfcz4QpEY1DjuldyJjhdekaGhPdwPxW3Ikh+vfWV3/gw/P1zAB1J0piHCNLJpIUhNEbJbgneonoPDwv4QOYRVg==
Received: from DM6PR07CA0079.namprd07.prod.outlook.com (2603:10b6:5:337::12)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 19:53:41 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:337:cafe::47) by DM6PR07CA0079.outlook.office365.com
 (2603:10b6:5:337::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.27 via Frontend
 Transport; Fri, 12 Apr 2024 19:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 19:53:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 12:53:27 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 12:53:26 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 12
 Apr 2024 12:53:26 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v3 3/6] virtio_net: Add a lock for the command VQ.
Date: Fri, 12 Apr 2024 14:53:06 -0500
Message-ID: <20240412195309.737781-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 59053b20-b24e-4b25-178e-08dc5b2a4126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7kZ/pYutc8Hl+JZIZON0dRXWm3r0tKKTSKITNZlM12ic7Wakc5JsLo6R2+zu8h/qaGwXwq2HmlO8+CyfGFnByVGd/xTZ/PlEw0mz3gQ42+L+cOf97P1XslmIMUtRdXF55ZbVvsP/LlIv5fYN98vicGfRgJb22M3J76nQTalTaZMrPwXk1/uieZTZeJgSy2jlua8W55vsp0RduWCz7mVfLEg1pvFTD9DbRaAIGOT0EV4ekYD46iB//v9QEVe8R/rRp+WUqdercLdDyb8WsTpG7baF6g3JXZyPYUqkvWE9+ZlgflyGCgGsJ1tbILy4ui0dUc9OO9zsf3LCVnnXUzAVXepzJKtKEYD7tAcEVWIV8lSWR4BC2melLPHJ+ctFaXz+tniqzraa90Td1/SS4n+0+QTUGd4ptBrjCkXO3xeYDtUHa2aoUGHQ6FEvJrjSpjtrVExCDtc5l2G+RoRZI32jrhRCc11O2oO5lRcHr7HhlkWOIPv+cVAqOsrkT5WJJLLtnkuOlGh4Y7IJXYNmXBaxg6u7XSpTO3UwwfURG14O3s2yGj6eVEQ5nePP2/32oWAyX5Q2qirgF6km6GsP8iPm+RNHnczL6dNW6dYANeh2GB/arrBMNPUxqq8vERV4Dpsjrt2kIIIh+/1xqY4ILw36Ssw74vLl9Vp5GJT215s0zXZUoLdWODSqFd4pVIx1Na84Fc+PchEw2gKt2/3tJP1pb+pcxBHsi0/xq/SM7sHC55VDw9m+pgKpnvcw6oNIGvl4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:53:41.8131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59053b20-b24e-4b25-178e-08dc5b2a4126
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467

The command VQ will no longer be protected by the RTNL lock. Use a
spinlock to protect the control buffer header and the VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0ee192b45e1e..d02f83a919a7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -282,6 +282,7 @@ struct virtnet_info {
 
 	/* Has control virtqueue */
 	bool has_cvq;
+	spinlock_t cvq_lock;
 
 	/* Host can handle any s/g split between our header and packet data */
 	bool any_header_sg;
@@ -2529,6 +2530,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
 
+	guard(spinlock)(&vi->cvq_lock);
 	vi->ctrl->status = ~0;
 	vi->ctrl->hdr.class = class;
 	vi->ctrl->hdr.cmd = cmd;
@@ -4818,8 +4820,10 @@ static int virtnet_probe(struct virtio_device *vdev)
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


