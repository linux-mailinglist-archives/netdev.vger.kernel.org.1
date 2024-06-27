Return-Path: <netdev+bounces-107370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAFB91AB78
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934581C218C9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2591991D7;
	Thu, 27 Jun 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KIPVZ6yt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10A1990C4
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502467; cv=fail; b=Z7CCDN4ziKUNrxHKtipbKf0T4nM+fdaphZiZBPOMbeHbbOtUF/Z0U++PZkWnI9nKDPNKi7MIzV/IhQ1uNN9JLVdYL6VKy2jR83Bo3YcTTLSkPFQa/yMKhVnaaHOaRTrXX986dpJIRuMXtDNem0AqxK0XTJ2E+v8pcZ/WdWwohAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502467; c=relaxed/simple;
	bh=7bFWfJOKkyCOQxAbbtRwj4NOuLDFYmcvzDFPz1rOyGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzP6grNGsK5WM5Bej+oWV4lVwlDzvvnpLC5DoVt1ILs10GgN5I0zEYaqnG/g+XCDZmNnf3wxFc2wSR9rineU97C6JvmHQzULLBTgAwUDWqfzQtFvsUzFzDwWaFb/Ti8tPiHMxPyfBlFr0BtLjAM2OMjewV8pYgrG44KuTOh/VjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KIPVZ6yt; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR+z9hkZQ7IA7LxzMrjRSXQKSzJU2NZ67Ct1/RXaoYKBMIS1u5ioRjvxWCtwCqc51zo2/1Xed+/TjAP6bhq0Mfa2339Q5FDuCFEY4L6GfDpbNUMEWlv+I94uttnwGjIn2t7mIHuVe5eR2GWYCzWfnMWUMqOcNthlOijDRMmVHn29cIMIY3sOy9ZTAOyRpljxahR+79UKyIB7oZ/L0ns5DIzRcB0D0b4q6JJgdTy+Sc/hQgSK8Qft+w3xVaxwe2AHEniadxi1Rygdpbks+Ft2HTiHwuMygjbaMq5LF3cX7mUOP7cCjnG1xSN2rOFOqUaBKDv1ccKKzMKp4+qpacNknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLYH4YqL+MJRBEdIAwU+04dMdAmyQt3nUANrt7/cs8c=;
 b=dU1zouVL2Ar/ONf/QiP5u9D5uZOUqjCNgKFSOP4+dqHtX1X9cbhLstTWMqLCo59ygqe+ym5oZSTl2zUE0833fE5DjKM30GYxRjVfhXgD8j53LPhpQNLRyjOVWGMcH7v/lx/hdYwLJ/krAaSHC3i6tzA1cTzirnDBdPue680vMok7gp+FEiJQiy8Qn2uB4R9iw3BZWKJkbUx2zKK4ReTfnzrLP2w61SG3CnAB3OzWudgYJnxgDps6HLttxZwc6xaHan9py6OGrgXsdDr9fMkynNBe7LEYtbrb47WmVh3ZSDoLcblvi59Wk8nChGaF5FAmlaAd6N6n5fNAh3889R1BVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLYH4YqL+MJRBEdIAwU+04dMdAmyQt3nUANrt7/cs8c=;
 b=KIPVZ6ytTak8z7fqdkexprXTPGelw4NLgwwQQkxogdiuxn4j3aR6ukd/VHyn3ziobzlhVvhUh6dApTlPz7NvOiDFAWjS/qPTWI5+5m/C7w9UYtS8W7yrEuhHe1el4g0b3ubuGR35vlydHveeGyisQNNR3QR2mutpdvbWfXgb0uQ=
Received: from SJ0PR13CA0167.namprd13.prod.outlook.com (2603:10b6:a03:2c7::22)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 15:34:22 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::f4) by SJ0PR13CA0167.outlook.office365.com
 (2603:10b6:a03:2c7::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 15:34:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:21 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:20 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:18 -0500
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
Subject: [PATCH v8 net-next 3/9] net: ethtool: record custom RSS contexts in the XArray
Date: Thu, 27 Jun 2024 16:33:48 +0100
Message-ID: <801f5faa4cec87c65b2c6e27fb220c944bce593a.1719502240.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|DM4PR12MB6637:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f3c761-ebcf-4c75-4abf-08dc96be9e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0F8cjvi6u2r5g57sfzSVp8hSkfe8jaX5b+FaCFkRuYeFnKGFANTj1dPhl5cF?=
 =?us-ascii?Q?jPMqgZhCOgEe4skD7lkvsRxpdeM55hy/F9T4qH1hRIzwesDnzKYeRyrhjf5R?=
 =?us-ascii?Q?fmOhJtseBlpOogRexivF9Q+7Aqd45RQ1F4DZgt/cwvUsecLx90QrST05d0/S?=
 =?us-ascii?Q?yf2Au8XSrLqJklC+jUduUI5koIki5vyNemS0siQZLTa7pYw5sOWGGHjsmTJp?=
 =?us-ascii?Q?36+pNCV5GyL7rl+YMdqPCLfklzqMtXztdKirr5K5y6tKigHHWBX2Z6lH1bU7?=
 =?us-ascii?Q?Q3XL98w/FJAVyTYSA4Z/ulTJReHCU3Kp6CF0wuTGMq40he7LHPy5nGlupghd?=
 =?us-ascii?Q?7eHujM5dqcK8VJkUwMvjW57H2X9vrFsiH04OOG/AI6G5Bcv0pXbVC92PseZx?=
 =?us-ascii?Q?j1+aJ+strNSguH+FZ02WNLuTHeHfLl0Z4ukBOckFH2F9dAQHiwAdqsFAiG+3?=
 =?us-ascii?Q?4qFAVOAeoI60v37OBgKJseygXqT7oqUvddZQW8HIljD1w7kEaEwzUKY4kWwk?=
 =?us-ascii?Q?dcvhV6UZgx5hOiKYzexHXFnz0loQLCxkaVE787SGBSOan3Cr6GlbMVSyW2oN?=
 =?us-ascii?Q?NAM7F/GGwf96juVTum8HeI9hF4yInz0in477BPJoZxoYWophiJ4anB42HDML?=
 =?us-ascii?Q?kmwp83XIYpfNE1PVcdA97eKNWTHRghuWN8f4ouJ7jkfALEq4RpScaEFd8VXE?=
 =?us-ascii?Q?y0Iu/uYyyEnuNCRTCrgBD7IEol623lecM6Z7phJvx9miYnuDLaN4twlew12v?=
 =?us-ascii?Q?O5s3gUVfJhqL66FRiW22vWTu4JeMJAEb6jCT2BRxv4cS2w0J3rOWGfgjxxW+?=
 =?us-ascii?Q?yrc5b/Vdx9qsbuKcx9g1aZMVH++u21nwkQyn+LSwSrD+TdOH/sWDoSV3R4m1?=
 =?us-ascii?Q?2iDMSKZv0kihMnL/T1P8OkTCc9BSZX4OBE0hFxVP2cB1XH2LaquHVQqeZV/r?=
 =?us-ascii?Q?pwwPi/l1tmLRvrVcZqa/Ek2QQ9nMUYveX8QpYT9jIrHoBEa02pZE94H6k+On?=
 =?us-ascii?Q?iOTX1OIwaMIXM6liL6nMmganENALo2S5OzDQhYqKIqw09qjop2Hf24Lr5qBa?=
 =?us-ascii?Q?NUEWjyl2kSu2ypOPvrBpcIzH/DW/zgXmj2CzLSUcUZqcGTmSfOfOgZbyBP2D?=
 =?us-ascii?Q?3uvIykWj+1upTCZQV4kCT00ahxgMzDRPf+0TQgkp8hCHvh3dvA3BUApjnTWG?=
 =?us-ascii?Q?5sfjuG62iMKWXyCDe/55AYW5yJ3eiaUObI4NpiUR+lVUfj9Lpsjcvw3W0kuw?=
 =?us-ascii?Q?3NIc6LLNO1iyQ4lPgw7SOoF7PTW6l6aTxx2mhf+19YkufXehWJA7lsqx3VSy?=
 =?us-ascii?Q?i/VdldSdRXqSxv4w885Fa6pdqOjf1tNF7odoUH7Z0ps38s0pJK++RYbbwpuk?=
 =?us-ascii?Q?T09cSJ82/NTo7RgLMFriG20IZnAwxosD+jaYS4sdMTniOH9ReWCoOjntfVLB?=
 =?us-ascii?Q?ettvFgyTInpaYcU/u5TiEvGcA9+xfsbn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:22.0687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f3c761-ebcf-4c75-4abf-08dc96be9e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637

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
index 13c9c819de58..8fa2f8bd474b 100644
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
+	return struct_size_t(struct ethtool_rxfh_context, data, flex_len);
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

