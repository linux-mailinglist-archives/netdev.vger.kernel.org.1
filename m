Return-Path: <netdev+bounces-82718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094988F68E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE46A2949E3
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BCF3F9C6;
	Thu, 28 Mar 2024 04:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BqTbngwb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FF218AF8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601257; cv=fail; b=KVaa3b/qnjZVHfbYBe6LycITUCtJ6eHy6Z/YCC4QRHxpS4DcSJ/olYQCc9nRJdUOeGtd8TdCoMTg2ClNutvFtzPfPUYDHdO50oRm46gWAS0jf0/mPxjvFnoE9B11h1idYpaTevblfa5mmoSO2VHde6GYgbIEE7FT3iG05L0PFvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601257; c=relaxed/simple;
	bh=PW3zqvG/4pWWdZNSa5Ub+BXgKrQtNSG1FHggwCJ/07Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiCScvryU409bb/Wp8uPL0ZMXNjdGEOIq1l/wJaPrJ9XzKxBEp/SzEVCTQUXcVWaKK9iNi7jmeInKgTGyiMXtoNkFNRPMvEcAlWCyA3hHGZN/WKXml4dex7BNKjx+Ceu+nJydCOG6Dee55UbClY3Dq48iV7+zVF5w9JAi77pycE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BqTbngwb; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRdkSsO0NxhAjBlRpICY8Ir8JUtVRR/uO31nGVY+hx55e7nC1DmjXQieR8ZJN80BZ61NkY6dXNKvHBaQ5BKoS9ytb7EupMT9DFBHaesdDJWHfh1WU0Rq5EyPm9nINBBOD19eorQLbnCwWyZAIkHR3y50Y3jPSquJ5V0zyST8dQWj5NSN1SIUTKlB4PK/oaXwBuHsm3VDa+5gYgsXB7AGyWmn7YxAjNctV6/Cq/ly7kyA0MA3KAAymPLr5uNR2r7NZHLP4H/T/OHO1O4I3KEnar/+D9kxFM/Ik2YUJXWlaibiBYOZzKh9qE2AjFZuwHFU3jl51bm3MMNE759ixgCzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6Qahc8/kxlJgf646bX0I/c5wTHUAXOULpse0bOC5DM=;
 b=MCDC/l4WSu3ewhcqcEworDhEAjCVLgQqC9yGDsRj5iAHcN/S4W1KffLLmitv5K2n9QkIihBVUoQjuYs976UqAPkv+mgFDs8LAlYgH3+sWWfAm6VIsjvaoB34XW5OUVw05KQMd4OyCwG31PxWUvLSyifodgh8lWfT4SHytXY/laalxWO8RmwxklFZfE0p1cGZKB1EmI5sLx8Nbz7SDPSEh4uFx/F7gvn6fF4D6JMvLUfyIlTk4CBWOI6ApU+Pea3G00f8X3oWK+7j8rfAnivxA5055jxAhXNOt3Gb+hEU0++SMrNqK/Jo201GJlbjgwzpxXAJUyw+VFd369tEgpi4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6Qahc8/kxlJgf646bX0I/c5wTHUAXOULpse0bOC5DM=;
 b=BqTbngwbKCFatYi5eWbKfEfQgl2AnZn84Iqm7wpPtFx9jYhZgjTL11dUV8zXod2qgL+z2X11eIwCZXE4IQAAqTiuBJFOqiVw+OEnYYQXWF1irejBWIG3WYaflUTBDLPsOmOaTDJl+WJyLu5gMdpf0D3geMYYyBMIViaUz80E0Mi+8Lpt9wb4GL2XedUPPEB6bVoBkBMQXCszJHCZ6SgOxnPpbrTSwU41nbNJeS9i/qmDof7TwzTFl2dM58nfnYyLFiY3iZHG+IonELs1wg40KFE68spIYg693hKZXocLyGb90ysAhPCYHrg+GYBGUgjVggbdlMo02ywHLi67nJOg9A==
Received: from DS7PR07CA0008.namprd07.prod.outlook.com (2603:10b6:5:3af::21)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 04:47:32 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3af:cafe::26) by DS7PR07CA0008.outlook.office365.com
 (2603:10b6:5:3af::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:47:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 21:47:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 21:47:23 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 21:47:22 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <xuanzhuo@linux.alibaba.com>,
	<virtualization@lists.linux.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<jiri@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH net-next v2 3/6] virtio_net: Add a lock for the command VQ.
Date: Thu, 28 Mar 2024 06:47:12 +0200
Message-ID: <20240328044715.266641-4-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2f3f17-ea9f-4510-1457-08dc4ee22e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t9uOUrqFEqp4V+jZYa9qTq6dlgWPqP3VkVFV4Yk21BEjeZ6tq877u87TDrRzh8QVfIHHqZEb/kVLyBYpHowB84ks4P+rfQHSqgWataYqjRNDNLCTEuGsgGDlFb6oQoZXuthrzIM32iHc7+lAg3dKiMWY50N9Vx08im3LL7IdiZDvDsgnwHAKyWr+UhEzMtpu2Zu2z2AKRBhcLdNMnMIStpkIoMp5OBtIyFeQekI4GID4W/PtmG7Ah2INLzbnwwWoNwhs95bLnLaeb3IxDsZsxTzhOVU3GAERTxuQXy+3Nw4vWEzZc8FwtgG+t9okHe5DGTbeI9gtBO+eUJ1qcsufIlclCj7cbTZz70iIjkH2X5V3JbDeNo+4o5OhiDe/zc/oqkpXr0Rc0NrIu6lWVLCAanBceShsJNM1GRjNlDNtW2ECcI9ADN2JsGFYhm8CVkgHopBTVYPFm/z7PvpP74R8vPm/KxCjXc/9Rrn8quAox5DHFTBZet0Rg2v8TmE/U/mxi811FTPsOuUYR/KLY7bvxRcxFvCskTovTZ5yQ3/ksZjKPIp58tOoJ2QkvE+6h2P0nr1/8TXlJ7IhF8+dTwSZOGL+Tnbr2LQlD961w9bb5gn9KWQ+5BP0NdJCT9VBPVfhc8mIKE+1/65NWJ8ht5ZuriQZdB1fdJbmiZgo3DDY1y5xaQgbB1C6XamrPdmEXxONTYEz5LVKSlJjOP5WkPkwuAaY2ZsPT2Dt+kniyHyA1eVSUwa/MskVGS35isF77PTV
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:47:32.7820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2f3f17-ea9f-4510-1457-08dc4ee22e7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

The command VQ will no longer be protected by the RTNL lock. Use a
spinlock to protect the control buffer header and the VQ.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/virtio_net.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ff93d18992e4..b9298544b1b5 100644
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
@@ -4800,8 +4802,10 @@ static int virtnet_probe(struct virtio_device *vdev)
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


