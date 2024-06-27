Return-Path: <netdev+bounces-107374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19F291AB7A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677D3281179
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116FC1993BE;
	Thu, 27 Jun 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rmMpqjGn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91B199234
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502481; cv=fail; b=bElpe3ek+VBQCNZVT136QSyyCF0iesJR1WtGSTnYAJiQUYJ6g48E7/3K+XHiK+y/FfzQdOH3ZB4YsMg3ISH+DjOAFrrJ4Z740si6a4KSzHkydGtVpwLTX18Z8ZrTGJNS007TJ0pgb2E3uCubhkj39azxCTX7bFTOFa1yBFogBQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502481; c=relaxed/simple;
	bh=/aMrFBD4uwAYoNum9IzftDuAtmbujuLXY1rIZWtrfOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQy4vrS4qLZCVfUHQjtX14KtQtgiewrQ1CuiDX3lhepBDSHZ2cHpdjLEOtIKDxp+uVOZYHLXU1HFdAaSy4iSk7Op99hlFgQuA3SfO9meYHy3uAXqdkD8Sjw8L1rGLiegLhB/48GWo2tP8OV1bw2ma2Wyaqhkvcz4PiAkPIivBBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rmMpqjGn; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiARGHp6F0NP2eDssNDuoJnNAf8DBlFztYqM0G0YBvgqbUgiDo8X7GaprexfOE9FyUb/Q7+NplgZvwBItyoPqCyBUyFzpIoNeVU3nH3jmpLgHkH8zW4X+egCshfhCq56k6ZMd2QDqSYcTHx+Ij/6CtZRXACPCD9PKdagikDR55rSV5Wi9JA8Th271gngQBSv+ujtsoDqMsQDc3r9RtfW6JrHLYXN/BJ0dX3sSord2qQX//bUbLQ+j5ZLNGhgNLyX9N4rnXP3+3WFSYYIF/yt6dguvxbPa23zr9NiEWp4bKkbTwPX5sEQxpO55xqAsLnC9IgM7zeIMAO1qsKaUVuq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAA3M9GOaET8ef7FrvcFdTFVc4ffA2Pt31f6u1tv8xs=;
 b=hrtvKcZCPWOggNpSBdgAj2LRz2KIQEFowBjDRzEnE7r1ta7/cJmwD4Zd6WFKcjKtLYu3VKc67YXuKOrgx0/of5REnIaqfaHRjrev+2WuniqOzMro7UhtrmLn1Bl2YIC76I2KhX2V2tadNItpEMc0DCyTX32bc6puE43ziu1qrrYrHZ7VOhu3cr8YfP17ysRbrwsam0LaHl8D7bOcbnW9vlKy4+oNdP8WYf4yslcmk04HGDgRfAY2he2MKOLeAtvLS3H5JzmV9T8sxlPUS7ir9lsCRbbx80Tq70j6spaRLZLT4sN74vqEcaFfbsuAM0Q/po+WXpvIPgYhUVJki/lGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAA3M9GOaET8ef7FrvcFdTFVc4ffA2Pt31f6u1tv8xs=;
 b=rmMpqjGnxaQg3dDHejTD3mX9Ufm6qDPFedfVRqYE3jSKk9brAc9mD3OpErXnPYJHWkykCt9M8Er6j1OTM7rSB83R1jwEQVqPDCew3rz4b4mIRWsxz8WVcKzLFatYJUBsCwPgB5LHVC1kghrGFWD/8udJ39vfgiZPeEjGDnCWLJ4=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 15:34:30 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::1f) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:26 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:24 -0500
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
Subject: [PATCH v8 net-next 5/9] net: ethtool: add an extack parameter to new rxfh_context APIs
Date: Thu, 27 Jun 2024 16:33:50 +0100
Message-ID: <6e0012347d175fdd1280363d7bfa76a2f2777e17.1719502240.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 33548dde-424f-4d62-1b5c-08dc96bea34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmoojEjatQT/WOCpnAA1zqt70GzY5a/HTHaRY23zaawgasav4XzEVR1XFoiE?=
 =?us-ascii?Q?Gbl4Ikj50v0WATPoWEEwxRvPjFeB9nZKP8lspxZ/b4chghmk33eYKKj44jrH?=
 =?us-ascii?Q?bSZCyRZ6IGuG+GKeHYmc2A4rBmYDf766qEdC9VrBb6x6CoA0wfNOUHh2JJMS?=
 =?us-ascii?Q?7ZYiE+ZqMe9yokOXvTCKu1Ah653HInX0cNanzJbaqAYCp39D+I1NHR1nxzy9?=
 =?us-ascii?Q?8CVS3UEiPFkoCypMnHibBzmCGWWUt6TAsZNL1B9UTtyj7/VUQAPWfa2fB2iU?=
 =?us-ascii?Q?NJgvL1uAclbSRezofoi7oJST4WK84bG/KtMircNxBwIi2S6TZFF55H9zObLy?=
 =?us-ascii?Q?bEomRMZtn2DYbyhaBFqPLTJyYkgJtZn8SSEsQRcDjydRB0waw1rU8j3+pnt4?=
 =?us-ascii?Q?g//CMYJUc40Cn/LVF0DySS3A5+bmAD4ERaQ3Lrs2JSsixTaD9aPz8sUQw6Wv?=
 =?us-ascii?Q?uxpYy8PhkQ+bwtarNEwA14B/HVRYc5EUtZryt4VI+QC/VWHW0OiSK+39zTRm?=
 =?us-ascii?Q?Pn0IgPU/umKNjjgyCZxogpaUoxen17KWFSdZYtDwhB9QSEUZf7y2o+Ua8Whz?=
 =?us-ascii?Q?/C0qT38GwdgC+xR16VDwSyJUcT11g5Fc3W1pVrfjlpccsFVsA+tD/Wx+vfRg?=
 =?us-ascii?Q?a0hkywe+MTsOYopgWFI37TBLNSsYW1PcZxhrvH+kcW55EXZ/w5wHZt9rin/A?=
 =?us-ascii?Q?ODwmh3UOioImgGgThCzEE39X+Omcjww2AWwtZVLDs20gh6eX76/2F4Es7WAs?=
 =?us-ascii?Q?wssNujdI4+Y/ul1LhtBdJ/vcDfWDW76bqxV/Sg92X6dexaCvHbQJJz5bcidg?=
 =?us-ascii?Q?Ue7D9Wgb2GvTaOgSc1PD2yIlgY5Ucz3d2FB8yd05wKEgMJh9GKNKrvu+0Qi3?=
 =?us-ascii?Q?m5wrXKlTidMbtP2IpnD/al7h/FTjjk+uu9ACEqhvetHS0Hu5b5bb6YdqKJqg?=
 =?us-ascii?Q?b+TLTW97ji/WCMWR8JbyKaWGNmvVIXlJ4B8BLpZlZfkGfBTjtgCbQ/83wrT2?=
 =?us-ascii?Q?c+au6vNcx9bKsgxyvjANoF3lvLpP4L+nQYbvlsBVi3Zu+ILoBVthOKt4HiVH?=
 =?us-ascii?Q?ZwVjFXpxe+xDkF4BI0SMUbzL1KJEPiLm9fPquQ/F3b3muXt+5Wo9/OH0ZPwG?=
 =?us-ascii?Q?kB+/N4QwbrGdn1qusyz8dttRwpv1D+hI4aOd0IHAq0RiJOR5ncEm3XSQnH6h?=
 =?us-ascii?Q?r4dbbhLRvK9oirY0i5Q+jLjza/oaPiFnzdoalM63RPkJIzI+/qfLQzL+E1L+?=
 =?us-ascii?Q?E+Fn2aLTtQPhsOXM6si/obuQP0nA4pgmrJL82WPeGzXWdtAdTie+bCqk2BJU?=
 =?us-ascii?Q?4A4Rkz4W7qhEj+zKPF298JojnazrDZq07RtCsJlP0AwryFDm7/6QmkaQe8yB?=
 =?us-ascii?Q?vK2f9V78z2jkFZmMi4uV/akh78W9sHdO5jkGYMcvN5DFjK/rV/FGCBc16e+o?=
 =?us-ascii?Q?v/+JKm1xBGLCP+Xk4sDMq3OU7U1uhK/0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:30.5544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33548dde-424f-4d62-1b5c-08dc96bea34a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540

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
index 197511c91836..533912386070 100644
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

