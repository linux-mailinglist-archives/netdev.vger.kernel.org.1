Return-Path: <netdev+bounces-215345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95381B2E33C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092FC1C83F11
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D108B33A02E;
	Wed, 20 Aug 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rrAxMNiP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA433A022;
	Wed, 20 Aug 2025 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710048; cv=fail; b=UJE/HiImHbtWTPTAPnuz6vqphFPIRP94Jb3kqmjNe0PbjnrCAP0fUeWFLMNXefoS1cpgKFpfQ0dL9A7pr6udhKC7nUgEBD7iZXK7y6aNVl7hIEgrBOdqwPrCx+llhKRAn9IqnOmo1DjCuNnmajKCsbrq+OwSPaLOoco+htjO0gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710048; c=relaxed/simple;
	bh=3JPVcHSGHpIfGU659L8QMB7TVhcSDIwBfwKXitN25eA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9uoEXb9CB0O7GiyjoEoH0sXZHndtP3aDaRhtUV9BDY0LSN+QBDSSm03m3s9hO3a/vHzPKmpbrlANoZ8Lu86RPB9nZ90VAtnEUNIbzLTH9arEocFY4p8ok8j8DulA54+Y1oPy+b/gOSjzE+SkiWmsADoISVHcxRS/cxVmLFEAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rrAxMNiP; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUQpaiZhM2IMhLC2uUxlaic6kjkafrMHoV303P0HZ/N4lVyRROiOEil9kPvQxmLynsQz4KPtWB2L7xrDaAoOPtvXdGtO1lyryCW65/VBApuUsHPbEFTt9weqgMwEZbyzOWgwCniCOYBEPlO87BGdla5D4b0dI2LCBrh/6BjybGdpxHlbFacy61poYTv7hNh2oatMKjUXV3jwgZA0DchTjTfg0YUETnwcxzBnoTcfiS9O5e5Lcw4Sg/UigEvuJWLxuid50nsPpt8BIATr23IOuE/5ESxVBtQ1AaDPgHEn2zFqwFzU7FPaoh9t+W5XV/TEt7mFz3/rt0Mrj2WUliL13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAj74CKHPBe1yyfYxuQ+vt8nQ/Gex9y+oyUhvHDA/uk=;
 b=qw2upkofGX8Bl4Ql37mWyPa16qokJmjuvXXClGAO2qCJbKCSdhAUYW2N/PgdFgIkpsBD/oTo19eOT5UWGzHA02JosHOwJNHrKU5xZBukiiuy5tH3WTBfnC59NWGY3o+btAScwZYHgLFLgLYXNuui9XHmfo6N06Psxb7Nf3ECAC5OdbhXw7ElgaBwcmNbNm9BYcfF6pEudBpZX8CKYAp/qzW4+SS++yEuSiY/NpvqEYkqlLomwx+o3gTwIA5kG1EeK4SWqQOdclvCyPo2eOER2kdTX+PKwml1iodMHrFC3nQ0IDLSjieeJL3gCp1tJgJxJL3xhzbRZFT75L81h1CIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAj74CKHPBe1yyfYxuQ+vt8nQ/Gex9y+oyUhvHDA/uk=;
 b=rrAxMNiP/MZm4zUC7am59rerF0g2M05EWrkoRg4rwBA4Gn86Ke3hIY6Y035HsL/Tgu/+5WTIE8thSrab3ogKGNepfmqyGwdFH87CPchkTt66iQirD2XBkyzbvzU1HjZzCRhVcGKsNP6lVDU9m/jdSVOv+6tMKCROL4a5qa5HZGdfBHPynnO1lCkhyArUtFNKkZUWWaNF8oAD714M8xnz15eE3fDD1x7jimh2ijlIQqeWJgdHGzes1VTFT7D+lhEVyE3eupL1elxoTuD4ZE3w9F6EeuoP5UqLlA0Ap+JfUg5wq2XjvFLwsaChijUQJYT4etrukb0HJcLnhQ6mcctiRg==
Received: from BN9PR03CA0154.namprd03.prod.outlook.com (2603:10b6:408:f4::9)
 by DM3PR12MB9433.namprd12.prod.outlook.com (2603:10b6:0:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 17:14:03 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::cd) by BN9PR03CA0154.outlook.office365.com
 (2603:10b6:408:f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.25 via Frontend Transport; Wed,
 20 Aug 2025 17:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:14:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:35 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:32 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 7/7] net: devmem: allow binding on rx queues with same DMA devices
Date: Wed, 20 Aug 2025 20:11:58 +0300
Message-ID: <20250820171214.3597901-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820171214.3597901-1-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM3PR12MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: dab94ad8-4b93-4903-8b10-08dde00cf653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rq27fsiW+Dm7mIQiUpQ+r40G4jTWSVayq/MgazZ5jhiQ3iMa5ZFfcHtWZ6pH?=
 =?us-ascii?Q?v5Z56yqorl6Hh/vWymjKisPgwYbE93GMqfVPjZiV19xXKLEPoHF5sdkjsTAu?=
 =?us-ascii?Q?kXKzzbxmQXFIWilT86wuCuKuNqeU3xK0Zd/1Yctcni+CCylAY2gjIgnNGirW?=
 =?us-ascii?Q?F1pm9VpL3sWqOwqB9lS1usdF88weYJKxxP6n0td+3QQ+TnRphmYOye3/H6/K?=
 =?us-ascii?Q?/Mn83pEwYG2ylRmRp1CNpaiHsg5c942cs/OFWa7g6KbGq7cJK9jSyaWbw2hN?=
 =?us-ascii?Q?k3VOLZKq+oTElWEhZeDWbsHucwWX0pEqbu+pEy7cOCVRZMTOiDRq2EUItas8?=
 =?us-ascii?Q?TrtVIRD7rKrBeAmAqhAO3C1eFmLcXkMJmrjMTI/c2VFhfFKH2mrZYy8XYVg4?=
 =?us-ascii?Q?ltXsb3HqGD0jThrxtzXFJVmUWjKbomuqwVj0x08xuUZl+oplgBjzE9nIENPP?=
 =?us-ascii?Q?vqEVF/QwkNNeCQyPPFcoYtAnHwnli5oUWrgOqF+A8R4ATxjRTQQ+fYIn1sBU?=
 =?us-ascii?Q?ytH9Wa/FXxz1b3A2vb2L7ixMcy7sNqndsV8NenunnOc8nrgftcbteeJNdx9Z?=
 =?us-ascii?Q?hmu5NYCG5Bc6TudOXVCou7Fc9dsAA7w0M4x29DKpiIblFWDXOoz5Imii6Nj1?=
 =?us-ascii?Q?80RQU/ZBQrBmKI+wh0Qi6usQxfAZVHo7kMk+AitOQIT3NfQ211rQe1FCMWTE?=
 =?us-ascii?Q?zHl/bTLNjFRp4haq8eEItlWzkkG1MmQqBEOtSodkI+zgaeKpYxEm3bSVrNZz?=
 =?us-ascii?Q?A+0wcUZCzA9zWrUyevatThsMF28ONxxDq2k+O170eLdO9lkbbjd8CQjH+YLV?=
 =?us-ascii?Q?ETcw62W+XfhgJuJqQvAHwj0GjpsUFqRcHciNHM2aXXkE6Mji01/UEprhLuck?=
 =?us-ascii?Q?lc2dMjiRzUrkrMtsh5Ev9/IHWERXF+l15E7TOU2zX0L9hSTFxuB0zspHigGL?=
 =?us-ascii?Q?OY/aJT0tgMjPnwGuCKJyQEr8jmZL1sIBHsItxubysFTj1qb0Dt/UXq/zVGGv?=
 =?us-ascii?Q?7W1Os8fLgekubOD7QvxwlZ+pJaQHTogMuuUHJxaJsfJNJ39QQGDFFPEP7Q3T?=
 =?us-ascii?Q?939Tu4+xkW4FlubG3fhxWQrCJdrC89W972nxOl5+D5QStpQfKfZTyI3wbZVL?=
 =?us-ascii?Q?YsVDXGFv1qDj8jnWbxBpQJmh5qySUQQjFfi94T0q2/W2nZ7NWK/LXUknztkc?=
 =?us-ascii?Q?khLFnAe/9bMbLnMBhMIuwuKspi/1LXMIVEEhe3rMXFc9fLrftABkj8gepXeF?=
 =?us-ascii?Q?mrUsl6VjurDusNiWDclpp5s/CVV0CANG62+Dh/FGBEsjdZumCq6rPrm5LsSt?=
 =?us-ascii?Q?wO3YXNcWtCTkeP866ktraQVBeV9yJIZZf8oO54vluFwgXLLZfgHA5J3ns3J+?=
 =?us-ascii?Q?JKHj4w+AKtptq7ROcF0eQ5dBnrQ+hwuhKhE8M3oPJ66w+6/0pdq51a01bCe+?=
 =?us-ascii?Q?p/Cy+NlbuaKWBH5q4X4p3LR6PEDXyAETYoP3WsW8wUyGPw2SWP9UirBgB27n?=
 =?us-ascii?Q?yMI2ayS2rLPRwegYhsx5ipUVRfmapZ8N6ixu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:14:03.1938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab94ad8-4b93-4903-8b10-08dde00cf653
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9433

Multi-PF netdevs have queues belonging to different PFs which also means
different DMA devices. This means that the binding on the DMA buffer can
be done to the incorrect device.

This change allows devmem binding to multiple queues only when the
queues have the same DMA device. Otherwise an error is returned.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0df9c159e515..a8c27f636453 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -906,6 +906,33 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
 	return 0;
 }
 
+static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
+					    unsigned long *rxq_bitmap,
+					    struct netlink_ext_ack *extack)
+{
+	struct device *dma_dev = NULL;
+	u32 rxq_idx, prev_rxq_idx;
+
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
+		struct device *rxq_dma_dev;
+
+		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
+		/* Multi-PF netdev queues can belong to different DMA devoces.
+		 * Block this case.
+		 */
+		if (dma_dev && rxq_dma_dev != dma_dev) {
+			NL_SET_ERR_MSG_FMT(extack, "Queue %u has a different dma device than queue %u",
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
@@ -969,7 +996,12 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
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


