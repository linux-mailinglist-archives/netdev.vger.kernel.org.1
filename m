Return-Path: <netdev+bounces-203473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D8DAF5FF6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2524467D1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36197303DF2;
	Wed,  2 Jul 2025 17:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tllpsM2g"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC91303DDA;
	Wed,  2 Jul 2025 17:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477231; cv=fail; b=Ins1au7uWONUDIwYe1rW8U3Lg2UyXDQ8jGOHHzprvT9cgDC2wDcnJR7dc7l7l67nt8Vb8BRbhb7uaqlL5uAy+QooxLPMeMPyvZ/liUAxUPDvmF3mBFhBM2EaatB1J+S6rcBH8q2SzKZcbSNZ02FDVa7MQwMOSfN+tUGg1FCs4U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477231; c=relaxed/simple;
	bh=9mfxkwTaFlgT5/lY1FN7vrbq4BSra95MLYWIOkI+I00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KttcF0LGxaIrXoXe8P8fp50c43xFnItHbRuK9tanP+YL3XFGl+L7f7Hzso8Vy4K8YT+/Yxtky6ikuUBR4l+AoSrYTUF6JqePfsJMDsxp7GSNVut7S2XD4fZedOKAw1E/0FJ+JEp6H8J7EMZIfVcqdlcbo9LnbYb9caF9gUK8eLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tllpsM2g; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+6YV3aoQ57REP5hWKwRayPvAS7WjYkDJG3s+Q6ZYg6pwjzDF7S9NDGSmYFxRZQbf3hyqookrABhy4VRYMfSEShPWofMy5vNlCDJmcA4DatvBMiVec+/dR3ltp12emubqq8Wt2gyOm6mUyG6T9kma7/JKx58oeO2Yun1QpKmhsCA/p2Ehz3FuToeQ9CEbyNxR/35oULzo/Pfu+m4aIUzdq0HoVe9mXJMSYJNKDvc57JSL5Qz8KFrYTuVwgziarx7FpjJITxL0h5uoX5jh5lz5eXzVTA5UnSSSW4hkwCY1skfEsg3WZtX1jkj0iAGqVno8jg7vdvj2FmXWJQwaInj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YB6RbA64MKfFLDnIgmf0xQCqxVznFM4ImyNahAtAkk=;
 b=HK0SUd7NxnSpZf3qxwy8HwnJqJhHkkknhWb9r3AI1JWPG6el3JLoX5myC/K91uUCEJwJNhwJlqQqjU16i9MEZO45a1RXQNrgwrlw5wjtnReEAV15gSUfw/m6bk+Yf8Yd58YK7gAy1koSO6FNAHnt3IpBTPzAMUgY1MWIFmu9MeOB7vlkMcb/Mq0FWcijg/AG9V2588vUFXHxQ9Fl1W/KajrU9qoJc646ahKtdvu/ffgbt7jtt2jgRK8Ucm4RhY//NJrVV+RZXjOML5QqeCZhS1+Ioml+bSAih3H42VhLHKOfOdVYIXuoKkMwG2eLFwv8YEaR8biroe636jC3U0WOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YB6RbA64MKfFLDnIgmf0xQCqxVznFM4ImyNahAtAkk=;
 b=tllpsM2ggZ8s8C9oHWQNVZ7wJsDJCJLrX9yZa669t92qC4Bai2e4UcA0cmJ3PWQn2M1/UdhMe2/SPRwlnv9/6vRxLyoWhtQ2zIDjLdzc1/70YyUGgVfpCLBcxnOKTTAQWpA4Le+RyE37e/Z6jtoBODzv1aqPMMxBWgGHDp3UP66uM4ZxRL3akEazWD5gdSikPBNn3Wbb1SRDXWph7fiEloQcQ2gSVKxv/jnNymBvGu86cgKo3Oce8jZD/ZnhBkiBC5TWAkrvfgxBNNffTUxn3yf0iohL6ubaWEv+8Df1GVEe43PUcrdFJE+MBk9uw69Yfg1IA0KGQBmtFSZ3CY1F/A==
Received: from BY5PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:1d0::18)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 17:27:06 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1c) by BY5PR04CA0008.outlook.office365.com
 (2603:10b6:a03:1d0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 17:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 17:27:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 10:26:47 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Jul
 2025 10:26:47 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 2 Jul
 2025 10:26:43 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, <cratiu@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC net-next 1/4] net: Allow non parent devices to be used for ZC DMA
Date: Wed, 2 Jul 2025 20:24:23 +0300
Message-ID: <20250702172433.1738947-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702172433.1738947-1-dtatulea@nvidia.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a713e6-600d-464c-a79e-08ddb98daabb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w3nE4PlS3wEVLGpfaRNaaEhm6hgIORRYtge2ZFeK0eSSzbC1/tDn7Dp9gKk+?=
 =?us-ascii?Q?U3gwoesrr4B5TenALVuzMNI+cjt92j4CTzouZ7Hba1+hxJu6l2tbZRaSHrQw?=
 =?us-ascii?Q?LnzvmltIXZkcdqDLH8g29486zTsJHWLJwGS9iZlyEOz6NxoA50ASHpUPdlEh?=
 =?us-ascii?Q?Uhl8Sc0jUWxGZ6Tuvm+9Dmnl2JG6xbkBuvsyn6u5kjbBuBAlod3BBxssFi5E?=
 =?us-ascii?Q?AKsAbFC2VX0eVk+NlcMQ38vP3mPJtEAQJnZRKRwGplmQTuQ4b1atDf4eGSUU?=
 =?us-ascii?Q?kjPYl3Wzyanphznw3s/04uBv6m3JCOzHkmnMap01pnVTBwMsYLH2I9gxmLD4?=
 =?us-ascii?Q?ePmSmH7iFh4i/P1N3itJjXjD7Kfa6EFWvwkZHO7G40MaOKPryKcCJh7cnRRK?=
 =?us-ascii?Q?JkRVG2ptCqOYimBUgYj+B70WwbnCPBwj03YTC73yf9GzzvHTBZ2wAhLKDCG1?=
 =?us-ascii?Q?liZvsB8K7ifFBScGEbxhq2bGexHJ0I2Eu18OVG0cy2RnhVIubYRE+IP/rYtR?=
 =?us-ascii?Q?GwPNf1cjl8dWsVKnRubFKdggc+LWQlJEB3akxOS1eHDWrH373hE4FCujH6sQ?=
 =?us-ascii?Q?lSbLriM4uuq39jMZCGoDQGYvXyDtvL8icTjGNhpcOhkW3qNnMbMIlNgOMGpy?=
 =?us-ascii?Q?hZ4RTnyncljdKpodqnoGbJL126lkwVgZOv1zzNNfp4Cr0lq4e5gNR+BxkJAf?=
 =?us-ascii?Q?6Jx/7X2X0SUPIQwcZgmIemwo6zcVNM+AEdNKadnlXq3KQsFu52BvPrCcOsEN?=
 =?us-ascii?Q?aHdmQKkpiCiodynuFJ6BZ+1ayIRqHwV/2V9cDLyueFV6qoGqQPQPC9Paqvvl?=
 =?us-ascii?Q?Fp1NcE7x2oLR6T4hMC2EEcPdvy9Zib0yrEnMwJ4wl9n599Lf+XLXC9hRhATR?=
 =?us-ascii?Q?NBPp/ssWAqTQBNVrSGwC0zp3HqhKxp05rlCeLKiaqimnzty8gVCxzJELA6qx?=
 =?us-ascii?Q?sTcBc17nciFPSbG/lLyceP8zufGHv17zx+1ijeSXnWpi+RLqeGVv7mJbaxAJ?=
 =?us-ascii?Q?ZlhkSbjFFw9GTD19VTnVfOyy525y3VhtCCeMO/HJv4+JZikIpsT/aUP0RYIK?=
 =?us-ascii?Q?HGj0zUcCGm29RJDQuxhXuj7SQQKP9zN82ihjxnqCUTqHGyM6DfGapwpeku4C?=
 =?us-ascii?Q?kpUdWOBVK3duHIqjv4hYTtbrzcAiioIjV0+ojVhvzhMZ2C+PvB/+N/9J4Qay?=
 =?us-ascii?Q?GYiFsLkWIhh3L4C5dQoRD9zymJIyGb1RYMrItus/YWqNAHm5yWeEtG2fnXzs?=
 =?us-ascii?Q?6UU8a8UA7F3Sc1bOeMfbdQWju8ZP0+0LZCD7Dw3F4HCifJMyPF+2RxMU4wAo?=
 =?us-ascii?Q?WnMYM//7nExLQQoI3yxOTFukZMTFEGyHeIVMO2Ju37EcAFdsZ1URS96MpSNY?=
 =?us-ascii?Q?8Fm4RwhR9WEY+98Qsjzf9xoEb8bgCXsyxDFq50rMV+TcD/Y7PC00OfjszTMY?=
 =?us-ascii?Q?Wigl9HGTpnooixKmEjUPGT3FVUhppOwBTPhm4FPQGN1MV3iFu1Q6EdIeEeFd?=
 =?us-ascii?Q?1l5Y6sTfn3sa6KDoHU9151he6U8LIIXTmIuK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:27:06.0920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a713e6-600d-464c-a79e-08ddb98daabb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692

For zerocopy (io_uring, devmem), there is an assumption that the
parent device can do DMA. However that is not always the case:
for example mlx5 SF devices have an auxiliary device as a parent.

This patch introduces the possibility for the driver to specify
another DMA device to be used via the new dma_dev field. The field
should be set before register_netdev().

A new helper function is added to get the DMA device or return NULL.
The callers can check for NULL and fail early if the device is
not capable of DMA.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/linux/netdevice.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5847c20994d3..83faa2314c30 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2550,6 +2550,9 @@ struct net_device {
 
 	struct hwtstamp_provider __rcu	*hwprov;
 
+	/* To be set by devices that can do DMA but not via parent. */
+	struct device		*dma_dev;
+
 	u8			priv[] ____cacheline_aligned
 				       __counted_by(priv_len);
 } ____cacheline_aligned;
@@ -5560,4 +5563,14 @@ extern struct net_device *blackhole_netdev;
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
 #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
+static inline struct device *netdev_get_dma_dev(const struct net_device *dev)
+{
+	struct device *dma_dev = dev->dma_dev ? dev->dma_dev : dev->dev.parent;
+
+	if (!dma_dev->dma_mask)
+		dma_dev = NULL;
+
+	return dma_dev;
+}
+
 #endif	/* _LINUX_NETDEVICE_H */
-- 
2.50.0


