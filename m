Return-Path: <netdev+bounces-215341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10417B2E319
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF1B1C83C2B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265A33439B;
	Wed, 20 Aug 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0a2hFKE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C60E33768A;
	Wed, 20 Aug 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710028; cv=fail; b=NKwZp9rkb2He3bniIjRzgg340S/1uTJ0z277zXrBW79pldwo8BBnGtteO3C+IjjSu0oNHU3Dn/TKzQHcl91LtRKFSYKe/gB9CyH+nNb97qCvf/6CnM7ZYFFezNBM8zw0S5CfR2hmRrKJabZjiwb5+Akf7vJRdMyEGH1LJfKmeMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710028; c=relaxed/simple;
	bh=FrDuwKKKi7b9auCjmahy7DZC8ZuzkqFji1iAGfvei88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G50JUbAO1hWToYYp2x4UdSY4XL0L5RHqI2L51a8lkDOH4TBkGVr37NPf4NYZkMVCYt0UCtQeJ5AtC+zQf0sZEE1toIJISB36Jr7v8yWRcAYbO3rTPijASs6DSmDVCNcFIvGjfRrUmt2eXUzDA6D7dw94j055VGUJtqBuc6Ml/8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0a2hFKE; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JloEHgs2VekngvtpQ0xkyFeKv50xkFz0Coa4xTC/U55LJo59KWRBe7hsg/T/gosnNnrvARb1j/w+y4U9xpNVVyDkjmqDTwu+I7F/Hy5dchF0UHG6I7fn4voM473QUo+UV4XYev0DFaKySR5en00skteXQ5S8rtZtXW1LOxE1WBve7lqPbP/04dskW1JgaeOpl9y6QT2zoIpMhHG+XKKvL0HPx81gaSNBYKsAxLupJQAz1kEPRfbbKfAaSX0HcJtdtvS7vPfY6f0Hac3vd8hkWuDcfvP6+sUAhqjRlEIR9ye2qR9Fo5cLXexyjxw2ZxSAKKeLpMoI1uftRGozWCAQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I90bCRVE1HfuRVa0WXRJFRS+6tTRV1xbTSP2ZDMKTSQ=;
 b=EOhfTDDieWrke8AbIEOxHRq0adxu3wtXGdjkeqd130DmtcjmB2Laaznpa4Cag1joYG4jcXNBcSsoI/fEHeHBNQ9FoNohePKe88cbLMfe6LeGr9DwewGsZLzwEXamIIOpnrNegcNAzcnaAMf09G+DqWWJowcp1+QpcDn4RC/RfQU3TMhEBGfpTCjPr65JjwWV0WtCcCrUmW5OiTmUeRJRVjPO0VioTXW1V0kaj6VyUNkx7nbWUtp8OBEvs3Uztmemv6qcLFGDD88nwbtIdtq8Tz5++ZovMrxON/S0OI0vWhZjm20utvUpgc8y0ZKk9PmG4TXN6lMgs8KgHDJUBrIfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I90bCRVE1HfuRVa0WXRJFRS+6tTRV1xbTSP2ZDMKTSQ=;
 b=h0a2hFKEzLpk69dUMGMKQc0yKHu2wx4jiAX0j0wS7JnK2GnHl6W8u8HUYJSnglfxQPo9SKd41PR4kwmmiyy6ws+n/YguWc5WHxDW2hGtzJkSwvZG1i4h96UnSLpXoAek8Qu0Hg2c83MGKvLBQjHgGfAvdE+OuiVY15gEBenkGMeS+J4XsRmLJQgPFwxhQ1uAKuFMbmA89uZsS5KqUm7yIcSIu11/LggG5gPDTNueWotoItXvg3NxVggOTjNkHnOnILat00lw5hh6jOScr814wDg72Zrp4DnnYUXDZfuY7qFVoEWMnLDE5V63ux4YJ2PdFscBOmaShPpJdGYsTf0xxQ==
Received: from BN9PR03CA0164.namprd03.prod.outlook.com (2603:10b6:408:f4::19)
 by SN7PR12MB7933.namprd12.prod.outlook.com (2603:10b6:806:342::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 17:13:43 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::8a) by BN9PR03CA0164.outlook.office365.com
 (2603:10b6:408:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:13:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:13:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:15 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:12 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 3/7] net: devmem: get netdev DMA device via new API
Date: Wed, 20 Aug 2025 20:11:54 +0300
Message-ID: <20250820171214.3597901-5-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SN7PR12MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: acca88e7-fcee-42b1-7908-08dde00cea58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYPcA38TkCujGPccTijIEtW/2x44T33odxYV0NGuH4kqDkTex5Yf8l+5G3vL?=
 =?us-ascii?Q?xnJUmxGTH14HpRWXN4wFuU0b5K4PLuY/usV80ORH2sygx8WGQeyBKtg78sii?=
 =?us-ascii?Q?fovzdn9+pgrHVfDLa5+zKJFit/EoB4iCK4VTEqhX7G3lOZydhzBEvGEkb9AA?=
 =?us-ascii?Q?tq9qftOStZ9iCsbG8hDXi95TT8PCNrjXew1+2rxNj0172to2KbJiRxswCmmz?=
 =?us-ascii?Q?brpdaGqa4dQBCObbnv7vobdKAf/TrHh0eDQxTL9uteqA1y3C3JEoM7WZIJRc?=
 =?us-ascii?Q?7C7Z/W2FxR+rNvoMhdtPmNtsgu70KZeeFIiV6xMP6BJuENH0kw/XeHeDJCcc?=
 =?us-ascii?Q?kxsky2nCWzqTMSSt1L1yGp2tYTQ5BszkbCH48CAgg6dB5ZFOYBEK7XSauU0H?=
 =?us-ascii?Q?Y/PHAQE+dPIossCC7mRNZGtY7A70zWloW/FJ/GPaVbnskEF68AphGlqIUVoy?=
 =?us-ascii?Q?rxato70vrX+7QKy4m4REypWn8cmoGkLOCtr2C77wbuqLxlT3+Z9SWUctayU7?=
 =?us-ascii?Q?yJkDUEHNuveLTyfD/JVJi/rMB1GVJKyB/mesYWf6Ix0B5RcJndICzsQnwbeM?=
 =?us-ascii?Q?JXPrViULf1aj7nZrP8lrXfYIJuLFtc9f8onnW3QePLzeHSaseEhQP/rTJGaN?=
 =?us-ascii?Q?xh2U95rlTO0SwbuCO+5F+qhHL9/64gKyglMYCSPfOmSOcqBFhEVDwZgXp117?=
 =?us-ascii?Q?oghXjktoYCFZXr5HTKFsi4leDuoPO9V/faezmwpkkZq5uYWLU66v0ubVkwy1?=
 =?us-ascii?Q?/dt+tsEjANLEloG+Y+llnR+IQDgT5WQDGzUOxNLRGWAguJlnHpXy7uIGTV/j?=
 =?us-ascii?Q?Tpl4iOM1NvfH9+/i9735i7iI7EsjEmxx8BeOg3ouNrvivN8z4A+VEcIhx1rc?=
 =?us-ascii?Q?u84yd4vWFKq3N7azhmBb4KYkF8/J2y0sjKQO0bmzyN5J5ubQS183tRfSc9vf?=
 =?us-ascii?Q?ybJb34MRTYnM7jaISevZ1j+PCoEr55p0dTfPCxO7ACOrRlI0wTVbObkg0wES?=
 =?us-ascii?Q?aZrxW9V7v9VdHVSHzgr5jFt/v421jKMTv95s3vzeWZN3JkWGZmzw0V2+DXOg?=
 =?us-ascii?Q?6nglAX/2XGN1Ib40+/rGSl7nw1Ym39HGRqTA82PKD74512A62gtzs3QiP29N?=
 =?us-ascii?Q?i73hucwc6ZhiZ7Wwbrx1Tiw+HJ9JtE1cTKC0Wqg+4OQC8m6WmAAExFskaFcI?=
 =?us-ascii?Q?Rywo2ylhedSf7emIN4M4nyTu9aCec1Bkd3rBP+HIwS7/ipR9KnSVDl2R94JL?=
 =?us-ascii?Q?+DIjx8bt906CeWGd0qpgdlqzc9lbzWvCTV0KHO1UZyDAQd8Tor994Vo5vSfF?=
 =?us-ascii?Q?hFrFTwrjvEENZU+aS1tPonIhjrcxhQ8jAl/kuDq0LzKlb78iiWePS/M1an4B?=
 =?us-ascii?Q?5db8XBhjMUVUWVAMlAoe14uuHv3+ZXknipKUwLJT3JWc/2ZvFEMvz2L+HBXB?=
 =?us-ascii?Q?J+Ww1dmdLI42uoGEEDGS2uJsF2rPiOUiUWo7IjOqx584NqwJLSoHGmnN3rrz?=
 =?us-ascii?Q?HcaQWB4Bbw1H/UAaekzvtBlW1HV8HUyV3Jjm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:13:43.0503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acca88e7-fcee-42b1-7908-08dde00cea58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7933

Switch to the new API for fetching DMA devices for a netdev. The API is
called with queue index 0 for now which is equivalent with the previous
behavior.

This patch will allow devmem to work with devices where the DMA device
is not stored in the parent device. mlx5 SFs are an example of such a
device.

Multi-PF netdevs are still problematic (as they were before this
change). Upcoming patches will address this for the rx binding.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
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


