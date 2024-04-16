Return-Path: <netdev+bounces-88455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B398A74BA
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 21:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276F11F22643
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A02139577;
	Tue, 16 Apr 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHoOlRBC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713111384AD
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295886; cv=fail; b=UWryY8XQ8TGVb/dXvNxQE21Zt6tnUh6lBvTRyfrPg9vZZ9mM8Mn0ekDR8BiYF3h6i77t+HolKpRmBt817DFdcrUj9Sa+Zts7RMjlk2Z/XcQv6Z+coSrhizpW/DUqMB0mYDjtY+KXPBcRPLMj9vZnS1prO96xBQEibw9rYiz9awY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295886; c=relaxed/simple;
	bh=91KjVSUx6x2TymBpbaCxfcryxEjo9MfcJ39qfDsuBKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTl6RF2ccwaSvKByaD7sKiQzp/Gp5Y/gqCWT4GQHcOuvpcaU0+M4lz+s6yolN55lVXo5mE1Raak+jcRXowlRTHLBNil4ZsUWsaDKk+ywAsj3BWwLRgDECJJlS1+TN2hwQUzU+gKP6/D9QMuHzSGjz1oyQzp1XjLC/3milnAmZ24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHoOlRBC; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ/aPv6WvgKUEH3AP4XzaDPaE0+gTazt5B//zU3rsab/Wc14DUgv4+k9mbgRPjUwhyfxdza7Rce1FXk5eCd6x3+gK7bfjbAC+cQKka67KYCqFVO9z7N5A98/+w+gZoqJoVScwXbwMgl997mbqz1qqXb8g8+Pzbn1l2gv8pplXJqiK4iuproQRed07TXGi/BgJaQR5RaYWGqQCBy7/9OlnALOqnWb4Xpr4qRZR7GRJzC228PMEI4vrnjHyrVdqkPNEK3O2AUjaetCRA5c3zKlExsSwpVRCDdQuIPrlWKBffHjY0AmwQixq8pvpm1LMvEHGo15AgX3Pwu7z0JKBIUaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eF2iGZDKA454GaqRNoUz9a3f6MF3kfnlHvM2eef8wA=;
 b=RrU5WrQTv1tzJtC2edcwkN5Tw0JUFnNAbCb1f5UOZZnZnu6oYAgvdp4OHYesqK9uOP7uaEB/FbQM3Ebq4H/yT6bUx17mf0QPBUrYGOzwSvQbgFp1V5nApMVxM/jdB4nN9WtxWIfYQPuSyncO0LK2n/6zw40QEJ1+DZrvHP5SmEQ6GLv8I0iusBkpVCt4ZmXuw+mJAbtRX53/y0KMmWI+7hetvfhc/jNw9YUNOrFYICfBi5nxPm75N+AiPbMV9zt4XwQGW3wx3dxGIHKFMzb1+AK8aqLI6PsYJvQk+8H3CCxMPBhWM1Zo9bgz3707Fyvj2zbe5vTJQTgiGA9Ug1AQBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eF2iGZDKA454GaqRNoUz9a3f6MF3kfnlHvM2eef8wA=;
 b=iHoOlRBCY0ILGEmM6jm4O2cQqCF2uIEsRQAqVrqrSiah4hEuG7Y69gzvSUoe67Q8v2dvTaLuimJw3dOrkuFfD2r6ziHHDo11fprc0pYkwzzXaNwaag4Q1yQRHpcPxLmF3I5ahb7Ez7iB4GHPL2N3+hNwo/0ktOcHSCyAStQiBzciOLdidP6CiCxv4cqUGTslUT+2lYluBIEkDnm0Mx4ghzKOeLsTRzGaSLZ1G/nCdvEowIeTtJJ1sSyqwCEwSC36RQShoSQ4PFkMGuNgMkqR7KMc2ml1KIQCzY8uLmZsovq+NqEWHW1OjASOXPvGox6xNqQzsXEo/N9ItZytGvi5qw==
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 19:31:22 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::83) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 16 Apr 2024 19:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 19:31:22 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Apr
 2024 12:30:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Apr 2024 12:30:50 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Apr 2024 12:30:49 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command VQ.
Date: Tue, 16 Apr 2024 22:30:36 +0300
Message-ID: <20240416193039.272997-4-danielj@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240416193039.272997-1-danielj@nvidia.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd67a66-778d-4031-2ef4-08dc5e4bcc87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a1VxGcIvc1k9UxwvBOdjtzQaBbnkHXDDEzXgiE7Hx2xqAky7+Y7OH7mcQaiBd34QBfaDdJai2mxhGW+Po8xaC3IcbpNfH0ALC1MQpEyQRDIA6OXveXKU9mlh6BWRTUuOESXiTcRGdhSTLr1UKxalaR0KY/ZoqKQjNuJGtxT7aBGaL+csyaz0fxNOFFR4EE77j8nitg8t9uWND3wqAv2RlgxsoH4nlb69yxX0zZWePkL+XVl3tF9R5QFaRQIcE6sIX4hrxMBT3wVa+s/Z4HjPJdL4qQUUYrbMBZlBYElqdPjRncccPBkMPYAH1QDD9HnFdxxvzv6AQxfVdH36IYn673mvaV697K4M+cbbQLaVAfozm101+WapRBWgrd2JUbRTQF15wOIsYrAbRAP+2UlC0NxerGsMiBwtebOpwtuMB1vs7YQTbsd+HYMKm4j+frf6ZQU9xJqmEsUvhgSjeHIBc5Hr6GS6w5uPx0eqONp5UmnEOKY703pPz34oOBifJM6I8Mu6w9qPwE2+cZMeXfWTKVXZmAjnzfcmF1YorqfX/YXo1BGPwfdjJ5argYoCjYT3IZIsuSiYVc9AMhh+yJsCPA64xgA8B7uGos6bneQw+VxOFlxjSmC/Vt6FNjDyG/z+1sNaGoNEA8k9kSNZd/9cMDG8V2VMSYV35rgfh2B8EbYjZ6V16vJXpqdNl38ncxH0BKN/4nweBK5x/vnzDcM5KEWysyIx8NZfv97abdczYLADNypQobP/Wgj8ATkW21sD
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 19:31:22.4706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd67a66-778d-4031-2ef4-08dc5e4bcc87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820

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
2.34.1


