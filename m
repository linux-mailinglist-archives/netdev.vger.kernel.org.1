Return-Path: <netdev+bounces-105123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4342990FC4C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD19E282D8C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D97381BB;
	Thu, 20 Jun 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PNcDwllf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90E36AE0
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862498; cv=fail; b=PAwU4bxJ26iCEZigKsvqtKMoOJNiNRZSlmntLZsXJClDXVHXVYUrPz8gqPzhpZowSlwrplGpA4olUrlqpn0CUTBSyqIAiDeuI3nknB1Yz9LBBektkFFzk2TGhYSR0A5BXQMkzbfinEoVk66lq5BVpYUYnlwkFQRdiSyUF1E1qT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862498; c=relaxed/simple;
	bh=QOyJPZTmtemYx2gxU6YbM7tx+8q1Wq5GFQ2mOqjWe8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pjivd+Fut727Otwo4V0LgUgM002ELL38Mvs5WIrUzyGHOE8lGtZG2eNnBnsmGH4LzwNt8HRMDFHnOPlkG7Li84KBz2ZMhHdHe/IDdWnxTD5FNkqrrf2QRPuaLms0MgrH8H12cSmKjg81NcP/gTc7Cu6Two0yaeG55S0Oc8ltRf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PNcDwllf; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L48cLjF4h9VYQeM/SzJalm777rPxQf1fySq5cPBuW31KX8p/J2KxnZeWBpVkmbpwDV0II5us0k1GwQj9yGnFAXr4+g30uSzY+1M3w3yTb2lS7q0Waes1T5HSbnS6H9mNVz7g3VB6C6uctJNobh95hnm8ZbdkG94Ja3HiXJ0sUbR4hps8m/d8/aiuuPaOFShd8KmRZaKWHHL7SL5J2eSlrejfWc5pz9j3fRnkeuotI3grxkUnxCX1zeAjh+yY3f5olhib3e7H3aNAW0JQZEbMD1I3Cat6qy8CC/Vmjjkr9nlpr4B4grInL9q74YWak4GdvKytMhH+AGOMWmFTbl7Ywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf4JueDXN3tzBTkABoRx+ja7YEDbKZ624T7+X1MZzY0=;
 b=Nf4KgF4XOJlhoeCrFH1rZ4mSZHo8CuC473JXp/zWReuby37NPFuzlvZlL9iIavtVAXODVI8z4A2JxgvKxHrC/mjeiieMM7rs6FLijytUyODOkluy4HX1XkCAZvmLljjHRD8VegVwi5L13HxLm6PtKqA87jL7DT1qFo/5xjVcf5VqL/lv+2YmEvbPU6kEY2qYpiTCeUEaZXt7da2jyBDO/kvL7mbfwlDJcI3w5BqDvImjYS5smXzYr2qm8Q7fEvqPkaQp1EmIKCNdmDpO4sJlbqw6tMMN73kZp611Y8jEVLkiAg+psUA/cjQiMRYOsGZkpWrY/84tGvQ/ts1+iuE+cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf4JueDXN3tzBTkABoRx+ja7YEDbKZ624T7+X1MZzY0=;
 b=PNcDwllfhqqBCoWxyEBwwkT9xSbQXkyi73p1mIofllP53SPMeh+qZzG+Qow2kEJiwu2Frs3h7buWQDBx2LoijUWPKFfc8f4KUYCwtGeqq7kgxhdMtLZdC3W7SxOP4od2PaFE+mCDdk/exbkt64FAZTkD/LJx9jrxuUQGdH7qOi4=
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 05:48:13 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::de) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:12 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:10 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 5/9] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Thu, 20 Jun 2024 06:47:08 +0100
Message-ID: <9bab54f2bf873605d200e6fdd0232dc7fd8d084f.1718862050.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718862049.git.ecree.xilinx@gmail.com>
References: <cover.1718862049.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: e1043c46-dd85-441f-7d1d-08dc90ec92dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyiLOChj1rQJo2YJXYioVgJxcUT6c4cCVPtC98zp3R90gYfqFvBdM0uR0U9T?=
 =?us-ascii?Q?AJ6tcW1whUxCVS0ZmRTklnUqzPUks/PUN3pXZACk2/bjy/SkyJPybH+yKx32?=
 =?us-ascii?Q?eyReeoEB6QxFuxurXqQjV8LG7jmGJceJIjodd2EVAWXhPV2EA/2UcEmevNNg?=
 =?us-ascii?Q?lB5+kyPkZewBpAJ5+qrwRqWsKML8ngZE1Y/tFUxGyGFMjVgS++Yg/4Oo5+O2?=
 =?us-ascii?Q?BotzBTxgQNdCQAIhv2oOUYEjywxxlK4/Tl5puZ+hH+4MATVOCx1IDl63doDr?=
 =?us-ascii?Q?UVXr1mWIZLU1XnbvhTpE5AzM/6qn4wPi8gH9RYk2p1U2+wK1DTJQ4pHjo7c3?=
 =?us-ascii?Q?U4eJGz2rnewgkrdkLmXyl211FZlzHKZ4J99Naa+UJ7o0/D9677eAsbsvMvwa?=
 =?us-ascii?Q?qRkkW8nNNWJgCbvQs1aM2scIcN3w9UkmlUuY45vWNsGMnq0PyjO1Q7OSd37W?=
 =?us-ascii?Q?t6hqPd5K9rl9RnY4zevFl576DD3qJfNOPkZpQ0xRvjn/FZp0N98U8H6U949y?=
 =?us-ascii?Q?GhfB9i1OhGnEU0IriQlNO2CA/aYx/Rm2WM8qAxyex7Pgf16zaAUpun8FSLDi?=
 =?us-ascii?Q?tcKoxaSol53WXzRrdYPYtmGvDOqmd5/99uW+dwwSfP5YclhsOf4xQGvqhOE0?=
 =?us-ascii?Q?XsXwrk8pbC6xOgNgTDEgZr3McewTLfFY1mYgEZ+vI9NW3ReLjIDm5K39THvY?=
 =?us-ascii?Q?63laNZiaCejxcorZd35NTLelwxKEGQoCoq+twG9lL29/Ue0fGb8lqfv10S/v?=
 =?us-ascii?Q?pS9EIu/ZnE/XvwSk0i2XI5U0CgKhPUA40zv8TpnXJzqOlp5hkm/+7vMsszyi?=
 =?us-ascii?Q?gRGHWJlDQVybph7m4a2PaTLWNr0uvQdcw9QqWwrVJJdHXq+gmcFsi72mm73t?=
 =?us-ascii?Q?JE8bOpCio+pZh0uzqt7PvqWIkfuIE5nfoX4jqq0zrSsXKdV8ZI/jAzCcO2lR?=
 =?us-ascii?Q?r8dMCF+CEaNIuCxlaKadJMtzrcoOWgEismVuP5k0mQIMj95wEQo1CzmfCUMo?=
 =?us-ascii?Q?IySpY32ft3QLXOXkyNDPilTfuVhsoN9Tk/g0ZZ+ZMVgUWzfpqvgnrvlMKlMx?=
 =?us-ascii?Q?N/JniTBCeAzObbm0SHjuyu2gSNcK8/8r0EGL8CCPg6BXDrWC03/SEnNwCWV5?=
 =?us-ascii?Q?3K2zCC30gae7l3DiN+dO8/bYGzqHpLVI+euPxYx6QiaTzCXukY6doGZN1VMa?=
 =?us-ascii?Q?JuUz7JteqnXotdFPdKW2LqGdmbM90VnW3F4BYUglpDgkflWsYWQG00d18OZg?=
 =?us-ascii?Q?4vCjKCRINf5RbhNFJ9LxFgh2SfvNXvnk9cLCwwX4XplpGpZ5zOp0UuaTBEF2?=
 =?us-ascii?Q?RRm3eM2mJ57RjBBe0cprItwPx1NH6x7l3qQwYBTnWgQQiM1O3nSsJKsYTiXw?=
 =?us-ascii?Q?kqsnkHmghALzSe52muaMgWK1iuXtOQ9SKuFBKwCAgGyUJPxc1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:12.9122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1043c46-dd85-441f-7d1d-08dc90ec92dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703

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
index e875b0a579b4..9ca9424ea8b1 100644
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

