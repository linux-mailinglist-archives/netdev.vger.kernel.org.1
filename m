Return-Path: <netdev+bounces-107377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFE91AB7B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979C61F246C0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE25199E9E;
	Thu, 27 Jun 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2mk6uKYM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57139199E84
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502483; cv=fail; b=NxuLUmdfjy8/rKTTop6xaBcXMEBzxu41Kpx7PRSqPoH5QcQ+9HP6LAwxoY80Pz5cg0WttYkogZUYNqUkUgXtcx4rtUWxEZEAMPhzmkYnkAxQdPwvsjT/hUQytq+prsvP0uf0MWJ/+vym6K7bI8Gd7w9Uf2EdFuvD3NislgsL1Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502483; c=relaxed/simple;
	bh=u/oLBJGYM+SHBWFc/06tAlZVNGvjaAg8iMZdKULq8s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCWoqC5YZKZBtMAjDCfCK/pJGS7qCIroczZ34jdTZgApiqWSV2re8QqsIOK30Cum1ma2ptcdjTHwbfZH6+gSxY/zB6W3vnWxXiaHbKUuevmfcaa2mBiGiubw1w+2a8FRw/zPn+BG+4AUtBajAi0QRhYj1VqngdnaFSBHbZa/IFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2mk6uKYM; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWmjHgp8FI5qKdj5ibfFvouiR0ZeCjst1kyXaG3vidzV1sgARZXOAf5K0qsCPFsR1SAN+N4fN5dTnhBOOcbGcE6U+Oyc+rXk7cp1DrClOAiKJ3dei55LxTeE++Tc/p2QrTrTXmkSPgE2H1gFyuHlx6l2FMwbzlkAlWlp01fVPBpiOAIvFKT0ARx6CZkEKnqTTLAa8ceBuPOVJBibMu1IKVBm3eDxjNJgVE2wm1eVl/ks840Gqd+1YkHoYrxEUIxoPTuB/5wyYxin6fNNtSy06k6r0RwuKoXD6qsedCajIblb6YUiJRn1jn/dV57ZzDigNd5diRfC0gtnvIhkyhkQdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tabGXzXEJqtUzUYaIu1Ps9NY28QvlRFGwMibDBA8SUw=;
 b=QxjvcploQIuRGnUZKKvb70PHDXyDjGucNQE8b3tZPz1ZRrLvGSTXRZ8HGnFmMmJnsUfe44POHbGzoyEgKbRKVVaVkA6k0suoiKg04oY+jYvXy2aaYeTs2wveB4THUd7Vl1DAt4Er6QPLAdYqGKl7PA14jvFf7yhYY+oIhjcgSr0syCrKYNHYSxKyQ7+3qJvqHZjyJYYglpEIY7xlHKRzdE6z5XxeYz+jVPghNK3k+jZIwmgkT44sq+LHptKC9uX8FAgHJhYtgRzY9SsM3LwoaIvEt60FnPHEWHJ/mqY8rZlbrQeV5CPCTiC5GrXbQf8zOjx/v/hjjWV5hw8GmOjkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tabGXzXEJqtUzUYaIu1Ps9NY28QvlRFGwMibDBA8SUw=;
 b=2mk6uKYMctUXgUt2A8COu9F7/PDfNxdOIeKo6OEa91QZqpML/wlyRtsSm6ciZ701SPk6AFBvu1FVpMvn9C/EwPqj7/NyBcjrodf2lz6lZy+mZ7Q6AUv18mdXEDIAJFOUIOkNmQg4QOHw24pzmLJjYoGUkmo36P0Fopr6osAPTig=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by MN0PR12MB5857.namprd12.prod.outlook.com (2603:10b6:208:378::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 15:34:37 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::6f) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:34 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:32 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>,
	<horms@kernel.org>
Subject: [PATCH v8 net-next 8/9] net: ethtool: use the tracking array for get_rxfh on custom RSS contexts
Date: Thu, 27 Jun 2024 16:33:53 +0100
Message-ID: <2d0190fa29638f307ea720f882ebd41f6f867694.1719502240.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719502239.git.ecree.xilinx@gmail.com>
References: <cover.1719502239.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|MN0PR12MB5857:EE_
X-MS-Office365-Filtering-Correlation-Id: c58d13a8-2674-43bf-a6d8-08dc96bea681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N4DOGp8+0cEfqIlpmFoWutu1ylM6pvvjI67iUleXRScGGwn5vIXwwPCqABSi?=
 =?us-ascii?Q?UYGlO/k8jd5YCtJPpashPy5fIGyfoNw798qJE9Azml0rgFdQno7l5sme9rx1?=
 =?us-ascii?Q?bP5EutMTvcziuhX22eMKaZPZqRRoz27TfH5kegqju7rZ7Q4Hha8zlJS6QfrK?=
 =?us-ascii?Q?KUhPGsStyoWTekbCcvJj6+Qh6vk97dKt7218TD7qdoQfKNuHslR0Ib6LlzAE?=
 =?us-ascii?Q?Ph+zVDfJ9XB39y/5AY1rKU1WgXlzqJ/jbQynMtjgUEzoyo3sPODyqj7s0KpN?=
 =?us-ascii?Q?EvQXqm+oZtEpYL/nAB1GdlvSCX5ZOMO8I404GpkPt9iVfht39oMy85A42q7y?=
 =?us-ascii?Q?Qxek7aUj8jufwuRqsrVeOT8YBPo+QNOivH9dh3Mif56pOctd/r4ZMAFignrX?=
 =?us-ascii?Q?0eCcq/IfstdssnER5/EramDn6xdaHadZNvUS+1DEGL0i7n0v/BReyyrajWF+?=
 =?us-ascii?Q?OgoZyV5zDqPIuzxqUYwUItcdnZbZyL/n7d8z6FUd4WxrwSRg42EEKKpi6LFG?=
 =?us-ascii?Q?JK/U19fNxXgt3aqDKE1cOCB1oirRJkj35wfOLDb9z5iOGQP8umqYrOr6Xdwg?=
 =?us-ascii?Q?eQofVu2/mwUuIVfInkFQ6oQUyeVkWYwCwO9Avtc4C1u4fm0p1jfoBjh7TF+7?=
 =?us-ascii?Q?W7VtTzceJ+32hPy+49WQIKFv5I1AIedlSYqbDKh16i7htgSpokdWJdL69y/p?=
 =?us-ascii?Q?8XfE2Nfo3gYEj0wGDulFuikJK58R+Knsa93ON8aLAH3sQWOi13W7XHpeS9p9?=
 =?us-ascii?Q?Giiv9/pFBBE2N/8XjDzkHrE85iL4DAt6WWuxZSHwTTkxGSu2deTMB6VRKwcO?=
 =?us-ascii?Q?nUXCm/MLwSuJ7h0cd6VvX2vC5EQUfR8a4mg6GAgZ8D5XZjfrqW5YHRlD/9Yc?=
 =?us-ascii?Q?Tt6wRL5xUwg4F5HHiIKTp1qxGGR3x0/P8DRAPwi39aLzqRxOE2N+XjPTY8qF?=
 =?us-ascii?Q?iitm0pWETCifTGnmfmfAWmm1fbK4B1wQ7zNJvgILesGHzwkE9QE22RoK3x8i?=
 =?us-ascii?Q?Qde5KM+cm+xXCwzLUqslgNbw4L3I8D0//K291weiKziNlw9Tr0rMw/JQJzlw?=
 =?us-ascii?Q?9SgMyJfTL/pKhA0QprGbV7z85c+sAAoVib8PJ4YzbiwmSS//iCRmJv6rLWf5?=
 =?us-ascii?Q?FXAVYf1FN6KRcwv/7uSdjiXKSQk9J70ef/e9VSbYnjnGAW01XpJJqryrc+Ah?=
 =?us-ascii?Q?irOcSoOBR8FDH9ASM5gUPfqerr6Rsgtv4fARl26LGxphBxSN7yP9S1e2/e8m?=
 =?us-ascii?Q?cYAVnbpw9r7ZAWmvbGMwb7nlKkmcK3b1HPuWY2LSnkyycz5GVeVrRYMLdVFY?=
 =?us-ascii?Q?vsjdd9peoiB2CsVYF94kIQuMCS6oFWTttBgiSQLrfecFz6nhd8P309owlAYs?=
 =?us-ascii?Q?HF0XEUp7P/MJrAbF5q481LRs5JdFFJj6l1wmPEGwUEFW3oyZGoYYpHrFLHVS?=
 =?us-ascii?Q?SF/MHsIoFRndDcPzKMQYr0pY2kkYfT9y?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:35.9516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c58d13a8-2674-43bf-a6d8-08dc96bea681
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5857

From: Edward Cree <ecree.xilinx@gmail.com>

On 'ethtool -x' with rss_context != 0, instead of calling the driver to
 read the RSS settings for the context, just get the settings from the
 rss_ctx xarray, and return them to the user with no driver involvement.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 net/ethtool/ioctl.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 9d2d677770db..ad10ce44a3dd 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1199,6 +1199,7 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct ethtool_rxfh_param rxfh_dev = {};
 	u32 user_indir_size, user_key_size;
+	struct ethtool_rxfh_context *ctx;
 	struct ethtool_rxfh rxfh;
 	u32 indir_bytes;
 	u8 *rss_config;
@@ -1246,11 +1247,26 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (user_key_size)
 		rxfh_dev.key = rss_config + indir_bytes;
 
-	rxfh_dev.rss_context = rxfh.rss_context;
-
-	ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
-	if (ret)
-		goto out;
+	if (rxfh.rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto out;
+		}
+		if (rxfh_dev.indir)
+			memcpy(rxfh_dev.indir, ethtool_rxfh_context_indir(ctx),
+			       indir_bytes);
+		if (rxfh_dev.key)
+			memcpy(rxfh_dev.key, ethtool_rxfh_context_key(ctx),
+			       user_key_size);
+		rxfh_dev.hfunc = ctx->hfunc;
+		rxfh_dev.input_xfrm = ctx->input_xfrm;
+		ret = 0;
+	} else {
+		ret = dev->ethtool_ops->get_rxfh(dev, &rxfh_dev);
+		if (ret)
+			goto out;
+	}
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, hfunc),
 			 &rxfh_dev.hfunc, sizeof(rxfh.hfunc))) {

