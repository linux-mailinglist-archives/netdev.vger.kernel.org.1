Return-Path: <netdev+bounces-214037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF36CB27ED5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5581CE6947
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745E3019BB;
	Fri, 15 Aug 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gqUK3fsB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBE3019AE;
	Fri, 15 Aug 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256040; cv=fail; b=pKqKrJZH0i/tw5KLvi0NQ771fa2cakWsZrq+69dVa7pUX28nrsZGsIGbjV01Gw0XaEPDQ341798S2866dTkduLCnNiHa34f5aQCpA+FTHQrJuxWoDVE7QcFRAKrCWtUt0uPn73iCrWLvO+1i3MQ3JAWfrGV0+vesQVNp7hHGvHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256040; c=relaxed/simple;
	bh=00rV111LSEVx2Mf/oK0iKMOcOfQGNETUopTmcoC+FsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKGOFkS4XVuhprz/tJYYPZHhkPzGOYm1aQUgRmSog4vndco20MxOSkDMlhReI3OrKKHZY+TAU5rO3yhaEC6kvQwRkCzEWm5W9TeRy9BPGq3bwoW9hToM3pm2XsCyGjckbe2Zx1yTTQjNMIz+LvbKFeA+yZeKWTYDNMDEOfCk36o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gqUK3fsB; arc=fail smtp.client-ip=40.107.102.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4bRwF1EK9HULM+TbED41Mdxp7Rq6L4L6dDMsYObAQTgrLM6wW2x3MtzsrzLmHZ99E7pRuvJS2mvGfrTOX6qVpajcxAKSad7kkyLeJAn6DihJ5mwVYxaiho/5kCl9v26/gXKs0uNnpPsafdvAXN+P6ivOk/8Y2lI0qHiQ89oTLC/6qV5y5QqLKBRe/9PCHhRVf5lHsPPUc0ETEOCICwPnaClW8nM74wT9ZBAiimBHyOyRwLONoFBBEgezo9pfOqotxhcUKiiZf+ufm3j8AYsR3t9TEfa/8w2o/Za+zrUzHijtO0qhuxewfFc+8Jpey/SV4qgPV2mUhFhQUL3M3WEJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiDFTzSGyUxM2Iu8qO49DbJHBzDrrYTmRYKBQsjvT18=;
 b=pKwKnRl+sVjVd7sEF3CCwCsN73MVksk7fLyLfc4ansN9fEUzMpQz/3efY42DT/AGhc1lySxeGa2T3LvSOWeXBsu5PjW+zcB08LjXwzbi9hdARtmkrN8HfxVbjo/Ys6dPGRalLx7VJn34qDvkmRS7PU6zEYUTNLUCj2ZTktfql7Am2E36TIwcgcqWmvUTTNACL2w+35aBgjvBHmfVDRBkiNVRgLEDXvIEMyOJsgUg3YJ/DFtjd2I6SJKBNd8gIEBXBYJsxO6LKTIgHKWJnn02Z9G1D3zU4gMV+bJMujSXCE17u/tQSi1mDz20FSrxpWh3y8DMk59DB9bwTbNU+eMvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiDFTzSGyUxM2Iu8qO49DbJHBzDrrYTmRYKBQsjvT18=;
 b=gqUK3fsBkZ5cKsIrQr3jmva4p1P50CFt6hA/+zGDYkGphjahn2j1Th51eZQurKGNH0RfQT3EYzd1NLycdLlhV3npX4iqle4tH+HNJ0jfThF867xYi87DOi470Vi5t45FbE7zzriG3NGi+lzVOtxkuhbC/YlcpiAilfB+K1q5lwdtHRnzJeAMx1Kh7iT6s53c1ZYP9V50PTkN6PxIrNm0uxRSFjlwQQX6iAdMwCKGlqGwVs0xrQAIndLRmUX1QpYopFaxj3MugrY+WY2nuJ0E6QhZ7VfqwOtWx6fKA30HpTaSsdytBKQXfqF/EaeFez6qnchLWtF8dh8emrK1e05/uQ==
Received: from BYAPR08CA0007.namprd08.prod.outlook.com (2603:10b6:a03:100::20)
 by LV8PR12MB9716.namprd12.prod.outlook.com (2603:10b6:408:2a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:07:16 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::8) by BYAPR08CA0007.outlook.office365.com
 (2603:10b6:a03:100::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 11:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 11:07:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:06:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:06:55 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:06:52 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
	<hch@infradead.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 3/7] net: devmem: get netdev DMA device via new API
Date: Fri, 15 Aug 2025 14:03:44 +0300
Message-ID: <20250815110401.2254214-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815110401.2254214-2-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|LV8PR12MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f009bd-1995-40e3-beb0-08dddbebe4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?szQ9R+HEHcn1LFhKqvnFiYt5RCQpvt0lpnWVeeAHC0Il55QZ3s1duAS2dFXh?=
 =?us-ascii?Q?t0ooJ0zYeeW1aUg6tdI+wN3rnFzAEEjFq8o5+842E857X+t4KAvosI6gyksS?=
 =?us-ascii?Q?sGsgnbW0daFauNffR9b7gisDoRPPQ4L73vGLalvCMTk81+GEub8zF9eKKt+K?=
 =?us-ascii?Q?YwG5Jj23RR1/Pkkp3eeTE37zxSrLCLVyR1gXqc0wGL8vTkKwwgZxQVtrbPpV?=
 =?us-ascii?Q?mdopRnRfgyFnd2bJE24j+V+1+wJxM/eYiZUds49RGGKywA0992hs5pHInPPI?=
 =?us-ascii?Q?Lf5NiplP7wOoYsuSMQL19vX0Cl2BgdCA3Oa2FS2F4bMJWtZvljI+gdosR+FP?=
 =?us-ascii?Q?xQUhtZihMIyIkv0+uPAxonRWArAcK6SEn+nuJC//YsRxNZBBc8blSLY/mdDD?=
 =?us-ascii?Q?8PmTzdE5Eg1bngSylprdwyHAK5E3wRpKQ85IZG8PWbz0/Fln83v8Fy37t6ZP?=
 =?us-ascii?Q?Mkq3dPy1RIU2x6U7Ih9JxoLboIu8eJYMRNpKGALgfK85daHszrxfjVUx5h/L?=
 =?us-ascii?Q?PT6c8e1oVL4vS+P4PfRVFa1VnfNINwDwl8RYbg9/KxBwOQMJNzMmJLEOQv+M?=
 =?us-ascii?Q?jRyySGhbMg+tuSr7IVmPIdbVUUtfcOBqSKSWktrudgvKPUUUx0oRUhd/5a5o?=
 =?us-ascii?Q?fSnOF8FnZcfhCEOAfRHKDOMuJejxxdcUD85Dwts18WnpiURU2Rw97LuTLvYb?=
 =?us-ascii?Q?HY3LO0rQWuS16yhllHQUUqJ2hmM50BA3GLeulZURCT4E/11iKwB06fdqP3kK?=
 =?us-ascii?Q?mwIPkCp3OiKEqA/6HSHLAynbVP8wWFJPWJvBA/HANQ0dz3t5bzBwDFKtzOCY?=
 =?us-ascii?Q?gmbFfwLKiI+a9Xk1t2a2O86Pi33MFpvsAMfBTIWOPAeleTZDMxqHfMT/JtY4?=
 =?us-ascii?Q?h6FttIE6uMN4qwah1gDh9v9j8CNEtwo+2F4xOUTpvN8poMkoT+BHhNljZRC7?=
 =?us-ascii?Q?JzBABfK3azEdrme9gwETUevtfYDlMdZOEZd/igRNiOoG+EEUkaLFVaXmKhfq?=
 =?us-ascii?Q?eHM04H6TP3ZlzvAN/wYhhQdkBHtyIrgdu/Dww468P6EmmnfL9POdKtCg6NAe?=
 =?us-ascii?Q?G0zp8SrUpTxcLeU5XwJhOYUPpKm3kJlAYutnc0Xg9LAXYKXtxoSkV6fLZ5MQ?=
 =?us-ascii?Q?5ZS6NbsI0cG0xVkpzbVe7w+aMcfc3bTGNTEGgIBRcL/hVuD2dzRsc/pNhKsO?=
 =?us-ascii?Q?TzEe7UWulkyuw7U4g0MSmnL7WWypky7+y4NP4mPmMThmC/59+gJSMQHR7WF7?=
 =?us-ascii?Q?nG49LO+Dp2QbLVPxSJ5Xq5+kl/6sGWO5xMfKEkJ11oI1batKdkX2rZJCb3FX?=
 =?us-ascii?Q?0xe/A+oxV/e1Hi9h/Dm5VqPQIWPiUftPbxTrlzqMuuUQnVZtvdGZXN83IQV/?=
 =?us-ascii?Q?q9qNhTzbAmjTcwXpXTA+PVHVNLRJVko8vYscOCZXmHuGN5YiIKCl0qH9ZvgF?=
 =?us-ascii?Q?OMixyd99KFfyE+2TwWoIlayBoHbsRBBUADBoQZzj7VkSKlDiYe9oxgYbn/74?=
 =?us-ascii?Q?RzTd0WtQ1yNMDrkhDV2uNNAeugi9zApFRG1J?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:16.0021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f009bd-1995-40e3-beb0-08dddbebe4f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9716

Switch to the new API for fetching DMA devices for a netdev. The API is
called with queue index 0 for now which is equivalent with the previous
behavior.

This patch will allow devmem to work with devices where the DMA device
is not stored in the parent device. mlx5 SFs are an example of such a
device.

Multi-PF netdevs are still problematic (as they were before this
change). Upcoming patches will address this for the rx binding.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/devmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 24c591ab38ae..d66cb0a63bd6 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -182,6 +182,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
+	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
@@ -192,6 +193,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	if (IS_ERR(dmabuf))
 		return ERR_CAST(dmabuf);
 
+	dma_dev = netdev_queue_get_dma_dev(dev, 0);
+	if (!dma_dev) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(extack, "Device doesn't support dma");
+		goto err_put_dmabuf;
+	}
+
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
 			       dev_to_node(&dev->dev));
 	if (!binding) {
@@ -209,7 +217,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	binding->dmabuf = dmabuf;
 	binding->direction = direction;
 
-	binding->attachment = dma_buf_attach(binding->dmabuf, dev->dev.parent);
+	binding->attachment = dma_buf_attach(binding->dmabuf, dma_dev);
 	if (IS_ERR(binding->attachment)) {
 		err = PTR_ERR(binding->attachment);
 		NL_SET_ERR_MSG(extack, "Failed to bind dmabuf to device");
-- 
2.50.1


