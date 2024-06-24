Return-Path: <netdev+bounces-106148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71E914FA6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B01C219EE
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3F9142903;
	Mon, 24 Jun 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J4Hh6PmY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D021419A0
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238384; cv=fail; b=lexVwPqEVklHSt0NfC9/xFXzxw0QwLPCZo7imLrixOnHSreAp9V/9dvHTRDM6eszGbIkdp7eCKunRAhwjCNyQXt9YtjhFIL+coFGA0VwK1pNMw/pkFcIRGUETvlB3n3gRglWAQ58q7ctF4B8mL4E/VxpIuqx6fBIVFHKMaIZhks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238384; c=relaxed/simple;
	bh=rYDgen6AXGuBlTehGB8K1N00m4ISxy90Ht+BSP2iCY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwBm/WBw0eQ+pHFBS5Ml8RnItzxQQbb3JY25veDeDoYH9KrnyQIQ3UIpN6pKr16/OZKHreEyn1zoFnvyUnfU5wwENnAUe/+Lm8NGlmvse4A/cjbe8cLtIPSxSwrdAL7k2yqj10Y3zWFU4qp09Ng6gF4K9dbdtMvOPMa5qH5diFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J4Hh6PmY; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGeFOA0zT8hcBzIFHcz3rcqUKYBRnA3ISAIVr4wvhjzz8Da3vLeuoauk3yGdkZaAHMeLm+xMHT2zPFyzALM/uH/ZcQ8Jn7wfXwg5w8Fx9T4oJV0zqW/0McsVNdbGcaoldT8m9pKkQQ+mjoI1Ru5jYyLbi850/Ki65f7hHodwqKjYboG9cjoBSRjuUAue+kEDX8DBDmE8KHVVSfoILBL++crqGE0BWRd0AaAhHdWIjoMIDy+y63BCM9s+4rmn+T+LveyV4ExeOlTiDM98fLu17sjnR+fi62vfVCTQMDMEA4Yhj9LHyW0+0DvZ41fzxkmwAHGRDR2xUIGxWmCSsxze0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU+guhwk4Hup437pRZ1HEBOxeA+fuaGROLm2zcczlfU=;
 b=a/zaiEQqKHQuAasG6WINKms0TFQJuD5ML3hcBI+MirHpfAquMCOMbHM3c4lJhQ8gRNhRRhyZpweJw6isN7JL7eqXXdc6y9eSJa4qQwdO2ETS5LKs6bxlQWMVr49Bg6u/NUNA4Y4uYO5fyv1XJ7H2srrlc9SEBdzfUg+NcWOvSA0vjmOla23tnHa+K0ZOov4hVctEdqFCM4yrvOMwFnzTT626eUPBVnDMzHCppf7Xy5qn2c02n1W4qpy+L6cIXkhCXLg0DztYyz9WcZnUK+0YM/fzWb8NzA3YTjWvh8rg0Zi0ujUnczGCS7ZT7cgwSCX3SBSO4xtIOYta+TD/u44RZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU+guhwk4Hup437pRZ1HEBOxeA+fuaGROLm2zcczlfU=;
 b=J4Hh6PmY3RTEVwvE0vJBCLdGAoFiIUxpjTk7bVmPrBY+nCWx6gtCtmgB8/mg8y4RNTOE1/mGW6cgbwIMuVHXWlxYFKp6414rTSyxT3JWMeEke+1tgEC86wutK3LHShDSw0TY0laYl3ZJLGKs9xI5kBKExKvfRz6q3IH8fhHWkd8=
Received: from BL1PR13CA0224.namprd13.prod.outlook.com (2603:10b6:208:2bf::19)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:12:59 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::18) by BL1PR13CA0224.outlook.office365.com
 (2603:10b6:208:2bf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.37 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:12:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:52 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:50 -0500
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
Subject: [PATCH v7 net-next 3/9] net: ethtool: record custom RSS contexts in the XArray
Date: Mon, 24 Jun 2024 15:11:14 +0100
Message-ID: <4b6d22993915fc6662680b63ee38e4a1fba9b233.1719237940.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f882546-0388-4ebc-d60a-08dc9457c034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5+4YDWD6hQ0puq/p8qTPEqJsFndsQLeEXkRGVsaryOqa8TaqF1C8FnhpZxP?=
 =?us-ascii?Q?GNFFxO0m2nUpUt/lBaPDzZ3BV+3UsxjVa0g87AmGbQQEbWQsCA2p9RUNCp2X?=
 =?us-ascii?Q?orL+4ElKY3E2UHkB7mlBHHz2aK7VhSzF5AgAYFOgFMc/K3nbVmhFVidA8DuW?=
 =?us-ascii?Q?iMYJ7NtQ9KDz9Fqoenk0+NUyKm4jOvolgGMLqHgC8prnk9GEmtIb/mi3NgVF?=
 =?us-ascii?Q?P16hL5yBlVmFgXThQYPz3JgdDCpC20r2AR3J7AxFhK/6fCZjwS4IkCP8p+wX?=
 =?us-ascii?Q?0ewQcSswRUrVjmLB2SQOScdrRnIAWgVzdW/KcUHXcYW6zMIzD7Q60Cv94fMy?=
 =?us-ascii?Q?IwE2drezjhtIaqFby95qezVxbeQre8WhdW5XDRwHMt4jyqgaAbYvJ0GatYY5?=
 =?us-ascii?Q?T0hip3rwFhwLHS6nOhYyOiiIv0fCjUdPdAWTG7j2InoKKIWpPvj5FESGjDOf?=
 =?us-ascii?Q?2uIpxz359YSqP6Qkij22Mibki2bbR0MIR/Cb/lPzaUw9BUgUjE0xM/k85z2x?=
 =?us-ascii?Q?nhYihPIpdQvEwSVSayNn/bVPnA9wUfh5FHZhIzyLnEHHL9NwOIjPd1vn+fJ4?=
 =?us-ascii?Q?PkoLFo191rfrKXXf76qJW/4NESllhy0CIm+EgfZ1EW4opOnnkBaPHnDvJfQs?=
 =?us-ascii?Q?sF/qFVHiQU81w5c3VvY5EWZAsjCY2Qm3HTvco2kez1xRLvkBv/sLyuOPZRvT?=
 =?us-ascii?Q?5w/25dGxlROdi7Bo/FRQepGVAaCEcQAoP8aGMIURp0QnOGphQbaCMlgGr/im?=
 =?us-ascii?Q?QWL/LwrB520Xd/npGfo4or3UKGZJRxJ55qyZxSw274lIAw7gohuVS8hyeNm/?=
 =?us-ascii?Q?64bpVYu6Lc2Pndx4fwHDSc7OZOsmxqZ9QiVGd+8DH2IhH27S7Ijn1avFKVSK?=
 =?us-ascii?Q?kjgJ5rD3Gwp4OZ7O1SdUp75loW3eLpny26qKcCDJcG5VH/HpiV7UQCbTNNaR?=
 =?us-ascii?Q?3td9JkuHFwtYYd2ZlfVSf9zmvouJ6EfYqmwc4jVhM1ON+l2G2+KmBCNrG49h?=
 =?us-ascii?Q?9uAX3+9QottOg9+qwL3z3AtX4IYCQiX0ErKN1VmAzdPDpv4XV+RENw6SUFQB?=
 =?us-ascii?Q?GV+3QRWPbGZ+P+UVCzhK/kdoG7yHiG+n/xoecv8nKUJ/4gWUqCtv7jytmT+g?=
 =?us-ascii?Q?UdzcbzJf40Ea9MXwf3XDOTYGyaEhEdh1tyypYAJ9GJejYmDoI997fLTEcySB?=
 =?us-ascii?Q?Rkh5IqUixDbu8iyYrcWk9Qj+kRIsOLM4qHEfxUDWC7rPxo3vqScS3HekncCm?=
 =?us-ascii?Q?XrtMjidEgLioyCpNR2tRB3myhHWYjD83SOvqZV3ht5e5yRqUX3HAyHyE+egH?=
 =?us-ascii?Q?9Sqn2rxNxQQuQ1d+louR+jWkCt8z0c6wnrSj1rQbXwgRqpGGgnZ8P9F1AkTP?=
 =?us-ascii?Q?1aJRvi92uOBuND8HBOVcgBCEGDxxvDiSHHc5Jsuj/VzhDsTW0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:58.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f882546-0388-4ebc-d60a-08dc9457c034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269

From: Edward Cree <ecree.xilinx@gmail.com>

Since drivers are still choosing the context IDs, we have to force the
 XArray to use the ID they've chosen rather than picking one ourselves,
 and handle the case where they give us an ID that's already in use.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 14 ++++++++
 net/ethtool/ioctl.c     | 74 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 13c9c819de58..283ba4aff623 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -199,6 +199,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
 }
 
+static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
+					       u16 priv_size)
+{
+	size_t indir_bytes = array_size(indir_size, sizeof(u32));
+	size_t flex_len;
+
+	flex_len = size_add(size_add(indir_bytes, key_size),
+			    ALIGN(priv_size, sizeof(u32)));
+	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
+}
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
@@ -709,6 +720,8 @@ struct ethtool_rxfh_param {
  *	contexts.
  * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
  *	RSS.
+ * @rxfh_priv_size: size of the driver private data area the core should
+ *	allocate for an RSS context (in &struct ethtool_rxfh_context).
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @get_drvinfo: Report driver/device information. Modern drivers no
@@ -892,6 +905,7 @@ struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
+	u16	rxfh_priv_size;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 998571f05deb..f879deb6ac4e 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1278,10 +1278,12 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	u32 dev_indir_size = 0, dev_key_size = 0, i;
 	struct ethtool_rxfh_param rxfh_dev = {};
+	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	u32 indir_bytes = 0;
+	bool create = false;
 	u8 *rss_config;
 	int ret;
 
@@ -1309,6 +1311,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if ((rxfh.input_xfrm & RXH_XFRM_SYM_XOR) &&
 	    !ops->cap_rss_sym_xor_supported)
 		return -EOPNOTSUPP;
+	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
 	/* If either indir, hash key or function is valid, proceed further.
 	 * Must request at least one change: indir size, hash key, function
@@ -1374,13 +1377,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
+	if (create) {
+		if (rxfh_dev.rss_delete) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
+							dev_key_size,
+							ops->rxfh_priv_size),
+			      GFP_KERNEL_ACCOUNT);
+		if (!ctx) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ctx->indir_size = dev_indir_size;
+		ctx->key_size = dev_key_size;
+		ctx->hfunc = rxfh.hfunc;
+		ctx->input_xfrm = rxfh.input_xfrm;
+		ctx->priv_size = ops->rxfh_priv_size;
+	} else if (rxfh.rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto out;
+		}
+	}
 	rxfh_dev.hfunc = rxfh.hfunc;
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
 	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
-	if (ret)
+	if (ret) {
+		if (create)
+			/* failed to create, free our new tracking entry */
+			kfree(ctx);
 		goto out;
+	}
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
 			 &rxfh_dev.rss_context, sizeof(rxfh_dev.rss_context)))
@@ -1393,6 +1425,46 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
+	/* Update rss_ctx tracking */
+	if (create) {
+		/* Ideally this should happen before calling the driver,
+		 * so that we can fail more cleanly; but we don't have the
+		 * context ID until the driver picks it, so we have to
+		 * wait until after.
+		 */
+		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
+			/* context ID reused, our tracking is screwed */
+			kfree(ctx);
+			goto out;
+		}
+		/* Allocate the exact ID the driver gave us */
+		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
+				       ctx, GFP_KERNEL))) {
+			kfree(ctx);
+			goto out;
+		}
+		ctx->indir_configured = rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
+		ctx->key_configured = !!rxfh.key_size;
+	}
+	if (rxfh_dev.rss_delete) {
+		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
+		kfree(ctx);
+	} else if (ctx) {
+		if (rxfh_dev.indir) {
+			for (i = 0; i < dev_indir_size; i++)
+				ethtool_rxfh_context_indir(ctx)[i] = rxfh_dev.indir[i];
+			ctx->indir_configured = 1;
+		}
+		if (rxfh_dev.key) {
+			memcpy(ethtool_rxfh_context_key(ctx), rxfh_dev.key,
+			       dev_key_size);
+			ctx->key_configured = 1;
+		}
+		if (rxfh_dev.hfunc != ETH_RSS_HASH_NO_CHANGE)
+			ctx->hfunc = rxfh_dev.hfunc;
+		if (rxfh_dev.input_xfrm != RXH_XFRM_NO_CHANGE)
+			ctx->input_xfrm = rxfh_dev.input_xfrm;
+	}
 
 out:
 	kfree(rss_config);

