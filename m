Return-Path: <netdev+bounces-106147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0319914FA5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E093E1C22202
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA481428F0;
	Mon, 24 Jun 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y276aaq4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250E6FB1
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238383; cv=fail; b=ctCZHos/keSSZWN8Ah7DCFepztTJ8+BbENLIoJuCK9O5EI/xeNDmdnTdDoDIr6Pe92K2efTtGgNlQbNgogbcQCfMt9lTl/MmT9rIej+xRnjR844yNkmEgC3/lhIfG0vuRu4uMBnRh8wS6uxbTd7Urz209X1xFgez3Eciry+Mj4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238383; c=relaxed/simple;
	bh=qcXMGiea3jVs6saJm2x2WE5M/oMVYxuSeIp6ujcnRfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBVbm09N7Hp82G/XkO2ugSGE9A6XWS5kDMO/7bL15VKgxfQZcRm0iR1BTPMeS2sl+nvjTwPb8guygq5JJm4TJgZYk+NHUydM+UEW8dCb3JLQgUze50ITBy/8vLlu/gjGeBFdmKmHclNV6Arb66CO4xVFQ4OvhPV3aoMui7exeWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y276aaq4; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGpBgJbpQkmTTbL2FtfcSaSCdrXDy+S+mdXLX2wliE9frDYOfTkv1zZzDiM/Lw3wLGqAlNwoNxTZ5N6X2gP1DYI2rEptdA8MUFPMR2GsBbFbpWHUP6/OnS6a/79Qey8nVDzMyyLHsLmk0BvOR1+Q9ekbO9peOPEIrqDXxFHTErjdHSq6F2qYDoInJC8j7tLgQktRvCFCe07cZVUX6fXqG2IqlXjB/Qm3CpBmkIRGZgG+ZrPKFWbTcVaDeNokoqhVG1QNPfQ2k0arxSB/hcl1VIQc9ZcRSstILDV15RMy9BTTgeJx5fF1cFKxkZ9WFFisiadvwXgKI4x+BYQH4IKIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqzvIc+y54AVEuM0NMhjSR9xCHEdbKf8Er8mtavKpN4=;
 b=F1A+C9NsIMKAmE9W1jSA8uP9bS8VxJduItJXUHZB0Cr56NCcpOMJ2ai8kjlEGciwoeMQ2zpMxkVC/ymnX8tUtpofcFYzW9a4yHsrzLdhqyfLFLNVz5owxkrLA1126ZCK7LshgP09Wj6T9y6m25wCQVq/huA9/waOQvNaUEjURkDLEE0rv8/6+fNakJnLOiKq8VtoB/j5Q8lDGaoPO9xAxswMpPsTAF3Ge9uq/VuHh42Ioqx/x2RaU6FUDAkwiMENnK20Kbur7mnzELj2vcHVNPaU3svoXDIr+msOyCtjUTdeyRJHFQ+8T8lQ//Pzv7UGYob0W/eVZlTixiy+kZD+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqzvIc+y54AVEuM0NMhjSR9xCHEdbKf8Er8mtavKpN4=;
 b=y276aaq48JimJUX3p6jxFmgp3cajbWund7ETgyQc7R3zuwVjtz9pQTfOsoOQ3oECXkprDSR2MgdgohUQgKAGRlH93KDYsutOde2uWajzOE37ZEGrBqA6xYWUzBjfExyzQaG4e07U5nMGnldjkXyI8wxpg0cPp4X2IgL8RdKoMT8=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:12:59 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::48) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.16 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:12:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:58 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:57 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:55 -0500
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
Subject: [PATCH v7 net-next 5/9] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Mon, 24 Jun 2024 15:11:16 +0100
Message-ID: <9355f490bdefde2b01815d96095953a1f130d214.1719237940.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1719237939.git.ecree.xilinx@gmail.com>
References: <cover.1719237939.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6678c4-16fb-4f25-bada-08dc9457c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5wWPhqvKg9B3kS1TzhLVh3sHIDcckVnqWzOvCF15LAJYhBrpWHgZRz9YDjvw?=
 =?us-ascii?Q?zBT84xhfS4Jr6ZyqvSEaVzGakLfiXfGwGcsBDLBD/qLlaG1fKLH3Dt9eP1MW?=
 =?us-ascii?Q?s0Qy9v7L0A+i1KFdJBod81twvRZZmEOLrKVa1sb9s4M9xG4WathwJ9dsh6ir?=
 =?us-ascii?Q?DZmkelfFxXUEWq9xN1JyxXeczVcXOwepVNsRh9rY35cNdajSbvlpH4zEhEPk?=
 =?us-ascii?Q?Gpk0YdR2XOAxii+TTfitGvUS0h+hxeIlr/kVRddnR8SL+IwFTCSu/ORccalx?=
 =?us-ascii?Q?dQssc3V/VIJUC9wNjWf7e/NgvCfnyQ7y6l5MtBV9KzXUn9OZLkEdF4GNJiR6?=
 =?us-ascii?Q?D5Bq4nqejb2Dnjr47LfdhoTPGmraLeGmz/wC+JgpdrSYCw1VvuZFhjJl82/M?=
 =?us-ascii?Q?zaX/rAmbpPIPj9zkHV7IwkTzCWjVCoWbdODCPSCXVVM4G9XcCHQCqHMzQ9E/?=
 =?us-ascii?Q?JfnjbrWP/YIfB9p8lax4CW20wDKGpUvWPaa41TMHMwre+niyEpgA2R1dWUOZ?=
 =?us-ascii?Q?fXrAf4JFZofhGNGgxEp7l/NvITihF9CVhj2HNXEY9uzHuDhwBLTx2fAX6wDM?=
 =?us-ascii?Q?s7BmVl+0DiGv6OKMDjaTIeocgWKuYkrpL/XCzNOJLTwWo9QmF6n/Q92ESaiB?=
 =?us-ascii?Q?VfPOO6wVEjIS8YWM1z9shZ9W+z9Jc8R4UQtgdmU8CeHnvliBT1Y5XnEXCO+T?=
 =?us-ascii?Q?C5gLUrGbOYmnl6QcJW//GVtk47DiEDz8IN0NAj0H/bWLcAkDpoCE/4KNbCeS?=
 =?us-ascii?Q?7GqQiKh6+T+POUMZy4yM6u1mnLrA+11BAW5ZXboTfytpSP7ES6tW2n3uYO6i?=
 =?us-ascii?Q?M1N/o/1CPRZiUC4Nqo0AIZaBJAtVH1eRSRmw9vTRLDYjBu5Kd4hN/GumUPdA?=
 =?us-ascii?Q?MD+jCBOYCld+v23EZFE8dXtUbYjpqlO+LEUmY/Z0oSO/5BpH8UnXlOkn3E3V?=
 =?us-ascii?Q?gVp6eXbj5YLVHtb3mPNdHpRD1jFz9s4RSb9SE1FmgAww5bphYeeoPw34iJUh?=
 =?us-ascii?Q?LayqHe/HpuqmGnFzIh6KZE4IP20B63n768UdCkle3DrYRfmiBN449NIVR4Si?=
 =?us-ascii?Q?T+hUsCNOJ4SKJWlINznfBOriZ7o5BEWu2ROqYUVo5AJpEkwnv32GgFYFUGSQ?=
 =?us-ascii?Q?Ey2nyYDr3Evt9UNCgiAR6mIjcRJAc95xbm61u+3HQRJuAuO2YybC6mlOFCtQ?=
 =?us-ascii?Q?EYC6Ax+wn/g8QPuIZkm6EL+u/+yOZm2ZszEwH7nwar1mcrCBoHllIcayETAB?=
 =?us-ascii?Q?8Z/dvuWXWoKUotpFv4zBucOX97Dx0Wbd6UQcss+WGqXAfFcR/KKrHqswJEHE?=
 =?us-ascii?Q?6HAVT+ID9YP+2y6FTuLdw/8StDWq4tH2UtMcJnmNozqLz4E2UYQ7qK0UqVB5?=
 =?us-ascii?Q?WIYMRCoDT70SPp3LbpaLyUoY9zpJubyPOfdioqGQWWrkDgUgoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:59.7834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6678c4-16fb-4f25-bada-08dc9457c0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921

From: Edward Cree <ecree.xilinx@gmail.com>

Currently passed as NULL, but will allow drivers to report back errors
 when ethnl support for these ops is added.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 9 ++++++---
 net/core/dev.c          | 2 +-
 net/ethtool/ioctl.c     | 9 ++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d9570b97154b..f8688e77ca62 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1001,13 +1001,16 @@ struct ethtool_ops {
 			    struct netlink_ext_ack *extack);
 	int	(*create_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       const struct ethtool_rxfh_param *rxfh);
+				       const struct ethtool_rxfh_param *rxfh,
+				       struct netlink_ext_ack *extack);
 	int	(*modify_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       const struct ethtool_rxfh_param *rxfh);
+				       const struct ethtool_rxfh_param *rxfh,
+				       struct netlink_ext_ack *extack);
 	int	(*remove_rxfh_context)(struct net_device *,
 				       struct ethtool_rxfh_context *ctx,
-				       u32 rss_context);
+				       u32 rss_context,
+				       struct netlink_ext_ack *extack);
 	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
diff --git a/net/core/dev.c b/net/core/dev.c
index be4342bd3603..16f1fc9e2438 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11205,7 +11205,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		xa_erase(&dev->ethtool->rss_ctx, context);
 		if (dev->ethtool_ops->create_rxfh_context)
 			dev->ethtool_ops->remove_rxfh_context(dev, ctx,
-							      context);
+							      context, NULL);
 		else
 			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
 		kfree(ctx);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 2b75d84c3078..244e565e1365 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1423,12 +1423,15 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 
 	if (rxfh.rss_context && ops->create_rxfh_context) {
 		if (create)
-			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev);
+			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev,
+						       extack);
 		else if (rxfh_dev.rss_delete)
 			ret = ops->remove_rxfh_context(dev, ctx,
-						       rxfh.rss_context);
+						       rxfh.rss_context,
+						       extack);
 		else
-			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev);
+			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev,
+						       extack);
 	} else {
 		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
 	}

