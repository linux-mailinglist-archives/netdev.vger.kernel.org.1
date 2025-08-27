Return-Path: <netdev+bounces-217326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DF7B3854C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D511C20CC7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B745C2376EB;
	Wed, 27 Aug 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XGZTBUKF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4D202F87;
	Wed, 27 Aug 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305738; cv=fail; b=GYM3d6RepgYLYdfQ2805eLr+l2TffGeqKPpRVTaO4kh2jCMUoWgsSTb7upVHnZr6G0NI3dgSSKcr0WQH6F/Df8RCVtW5/dAOIkNY4EfvwstFJaDoFS9WtE04XV8aUAyUExQsbBzKMDVe/5uHUOJ3NJO89xY0sxs6LvWWAZGpS3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305738; c=relaxed/simple;
	bh=uBw/auJD5NL/IIpZqRsAk5nqzgSC5O/nSHuSa8l4pgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZFwI8Gm0Gqj2UTP6s5j2vwr3cLNfi85s2RNzVlZGWNCkomtxrM9GPCi6leIUh73I21QmlXmEGy02T7oad4EBLhsgEfIVlXN/wMA5zMVitjJ8v3Dm/m5bWA6rwUVA0BZhdMLhB42US/qgxlD4ThuRX3Lpj9JckXGi2GSqUQsjcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XGZTBUKF; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYiJ2hhOJAmorbCorjXgCXTtLOOTwCsioJB+OpMZXh/6vGybkWkanLdIDtO2lmj6s0qqy8c43GiRTPp/6yK50lhcK4sc9C1C+4ML0EFQ95xf1JCgA1Pgq9lEISXwCY80u9tt284B2xwjdScLYoIjBqbaEUPAaVLnkin0TT8aNvt07wsOJDwhAjOdwvEidc/uaLaiyznAApoj3E90gykmVRamNRi+iq9r7y4PyxKUw57uqslXKfjdtCSJROVTDT5yxqeQtBNkeMYkkatE73mB2+ZhOZe6M+IReZH6HUjTmg4CUIUTpOgYk8pX/RluHucdsbXf76vTQsP8DlGlPAjqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/z2uBrBNlzBOlGLrQWrxU7z9Bz4yPnsKgaDEgpHPZE=;
 b=oB5tIkkcE6kKd2gNtQyR0K/9V0im5vUaOfMvmZ1eDMlJ4RloxfzO69TvYbu7/Jt+5kJAe7X7ShUgyisxU4NRrXMdnFbRJZoejg7+OqZQX/neTRu6ayte+MAeHggiHVX6yKr0SLZMdHJyBiqKHS0gEmVcEjveeKPOpyfIl6GocsvxJmMC/UlL/+SBIJU8mqi8LxeHbyC3fRjg7zs8nS5BEOnYxPfeZRmrvJyqO39Gh5ELo7zv3oY5tlVaJLfHpmTMIoDN1JCe80zS5dUgMxw4BfWOgIaBpPhTkVvbzIs8gBzYhvAFhyh4zbUHzVdSb93g/q5yikRO1hRU+KdRKcb3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/z2uBrBNlzBOlGLrQWrxU7z9Bz4yPnsKgaDEgpHPZE=;
 b=XGZTBUKF8Q+TAzoCNA7+NvdpSZY1+BQ7VGGxjBL1RX9b4s2DKeA5NT9yf5B1VjGdyiiQ2lRiae41zWkkl/CoY5NXW4B9h0KaGeJErwH8lUThTWPMSWd+nQilUYjRc0+Op9nSYTRW/hSE6tcQD2JvlAqtSgEz0pykg6KU3wEmW+z96Xq628HFnUlT8GeskW5moLtmERw10Rn7ZhVBSKda0Kq3jDqUb2l9PGIBndW1SWKSXEKdT400JJrM/Bk7nNWIxlBX7lj60fRxd87aw60XecbuHdoXTZgCxVHD11CEfziz5i0bpYBXs93u/BkAx/Q6iACh42mUOcyNHa7T/c73xA==
Received: from BLAP220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::11)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 27 Aug
 2025 14:42:11 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::aa) by BLAP220CA0006.outlook.office365.com
 (2603:10b6:208:32c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 14:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Wed, 27 Aug 2025 14:42:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:28 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:27 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:41:24 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 7/7] net: devmem: allow binding on rx queues with same DMA devices
Date: Wed, 27 Aug 2025 17:40:01 +0300
Message-ID: <20250827144017.1529208-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827144017.1529208-2-dtatulea@nvidia.com>
References: <20250827144017.1529208-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 766b5178-d2dd-4345-bdf7-08dde577e836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rNy6LAzCk6K8LbdnNU+Dta/et4Up2PZJQh6jlWfDBx43mbOBQ6RfI+vwTw4y?=
 =?us-ascii?Q?iXXZCeRR8bFA5Wa6Ax/OvaSZ2FhSG3WXL3Nrvjy2+iZ/w4+BgbZ3k1aCO6Ob?=
 =?us-ascii?Q?106Gi7KJ+OvZ85gTGa7mH12ItK86ZLk5DngphcVpAYZv416Nlr9xxL4mPg1g?=
 =?us-ascii?Q?Q4boK80PKe/QDyfwFlZEBYDqt05L3+IesZz9nJCHcSh1m6S75YU15h3NG4ui?=
 =?us-ascii?Q?69iguEVNy4o+aO9CSoGOiY6QS03M961iwcAUx4P5NAs6RWsG0V7a9R2hB2xI?=
 =?us-ascii?Q?dYfxWY+8Ce02puYPp2oSUUgUugY4c4t6luYpqUHc3+5+BWqr/fCsDOqUOMmz?=
 =?us-ascii?Q?DxKWfuakFHnSrGu2dGpIwylqtg8zKtcSju5sbcRtb//fPyjr5I3yACuuGI1x?=
 =?us-ascii?Q?6EDtplSBMJLLJl3MQ/c6OuuIULdf4p+ZdCzxpXZ9AMuauGNe3rnfzOJaL6j5?=
 =?us-ascii?Q?CdU1m24jpGAp8jsB0lNrskWU5Ec9PlguuHSIu/4EH28SIia1BWHs5fXarRn1?=
 =?us-ascii?Q?2Ex+ktyTXCuBDlKzQbi2O9gn1UqXrtGXBLH9zTGqPPCSQ+JlhUbBUnsNDMKe?=
 =?us-ascii?Q?vChQ34K60sf2/BkxskREQzcNNdgxvZ3MCdjk9kG+BWiN9WC1TOroFqjMdXEX?=
 =?us-ascii?Q?IJGKuIDQlYdVPlje5oS8L+vjq9Su6wODFzUOyLbSbxgDmFjSUY7RL3eYWzuI?=
 =?us-ascii?Q?+FoIp8cQ+9oDCQEmx/lh7HGNWugdfEKM7pMLA07NVemCWCpkWyrSkyptmCWN?=
 =?us-ascii?Q?tMvR+0M8yhN+/xQfmxytKhuBl8XsO/qiWmqLPNOSN62wBsYMRWc5SNjy4frg?=
 =?us-ascii?Q?oxS1HdLtijL1bIUFJCa+e+ChE6TZbDvrXtPMv+Hvuu0cM765yjGYjvaYTnq1?=
 =?us-ascii?Q?sZ7yQjT33ui5mKLUrCLBaVEwg1i086oIPgan1ij2hJ8Td/7OXITWBR+y3Zrc?=
 =?us-ascii?Q?UeSIrENCO1vTCiLASKtbFMkM3FCBhBxzE5L/8jGSfjL+N96PpDNw7mVuP4S2?=
 =?us-ascii?Q?kExZtskfFK5wh1TM3lvizlwaQIeNo11cCPWyIv6mup5Dl/djEaD2EyuDmjxU?=
 =?us-ascii?Q?uQQEzinWbN5vrJgKD1v36MYORZdencXDf9gOHKhBphFQEiQXmGVzrrjEnTZk?=
 =?us-ascii?Q?TkNzvyrFjI3yUyhZBUfGOfVm1MgrqZWnKhut/DPOs6b4gXi88kINSUXFbfAH?=
 =?us-ascii?Q?HYipNl/2Zv1vwTDtE6SL9eDE0V9EiJAZ+yGj72Z7QbHxRZGPwudfrN//xl/x?=
 =?us-ascii?Q?8N3oJi5epDgCF9JfIs15WMyavmTAJ+CUZzEZB1FLEiNWaHzD7Im8837EMU6l?=
 =?us-ascii?Q?bSgLPhKeellaCDVKetWaVnCu3hPb9AxtS/Fmsh6/aLgMgdnoTt9skaAsN1gS?=
 =?us-ascii?Q?9/jmORvrANCPpvhJ/BPwg2P+BBJwdLnja7U+spmffw/Iv8bfTOYzFAQC1/Lc?=
 =?us-ascii?Q?Xu4vefhdZG5dPTIW1H3HSXrBBfamxCLFy0midSWvrRrzf2tAzGbVMg3CMkRB?=
 =?us-ascii?Q?KsHL/ObOdsvk42Do8fniM9bR+OqPVgr9qZ/c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:42:11.0812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 766b5178-d2dd-4345-bdf7-08dde577e836
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

Multi-PF netdevs have queues belonging to different PFs which also means
different DMA devices. This means that the binding on the DMA buffer can
be done to the incorrect device.

This change allows devmem binding to multiple queues only when the
queues have the same DMA device. Otherwise an error is returned.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 739598d34657..470fabbeacd9 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -908,6 +908,30 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
 	return 0;
 }
 
+static struct device *
+netdev_nl_get_dma_dev(struct net_device *netdev, unsigned long *rxq_bitmap,
+		      struct netlink_ext_ack *extack)
+{
+	struct device *dma_dev = NULL;
+	u32 rxq_idx, prev_rxq_idx;
+
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
+		struct device *rxq_dma_dev;
+
+		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
+		if (dma_dev && rxq_dma_dev != dma_dev) {
+			NL_SET_ERR_MSG_FMT(extack, "DMA device mismatch between queue %u and %u (multi-PF device?)",
+					   rxq_idx, prev_rxq_idx);
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+
+		dma_dev = rxq_dma_dev;
+		prev_rxq_idx = rxq_idx;
+	}
+
+	return dma_dev;
+}
+
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -971,7 +995,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_rxq_bitmap;
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extack);
+	if (IS_ERR(dma_dev)) {
+		err = PTR_ERR(dma_dev);
+		goto err_rxq_bitmap;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
-- 
2.50.1


