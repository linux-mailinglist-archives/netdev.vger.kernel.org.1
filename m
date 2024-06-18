Return-Path: <netdev+bounces-104675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5290DF36
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B09871F23626
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA61849C4;
	Tue, 18 Jun 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WZ2pcZXo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80BC16D4DF
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750729; cv=fail; b=XWafIFDh+YbqcsF98PVZYjIcdWuzJ2TLFbqsfd5m/chuYMMq28atWv6XjUipAmpet9BOv9sZV3C6EHWHqkV77WQZy4yaYaGJb3y7SHKa/uBPi1CqIN2taPRqk8X0UIYdA+w1F8gKpnLwGBr3RxHT2NHExq4O1Nj9dDOsbqboSDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750729; c=relaxed/simple;
	bh=piF39xBWovecDXjzuxf0dSV9Li4FFy4spjl5ZQy7gNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrVZmsEpvklmITQNe6N+5NsX7NPqfRQ47cUPWWgYU9dsEbueQtinqriTvj4N0FTrE+fkDodd/DzUn9xJjEieIT5+KiIITYjRCCCPVPUHz+rJMSI6aSEA8rnJsOBjALJxaWrCcQP4iaz+ZK0GTAt8MTKMdZChhx7E2fqeza3oc+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WZ2pcZXo; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJsHNrKuTWIBXIDCaOrneoI0yK9Pew6nJ2EKhix2lPvjTz+CtM8YRsWJFzgTpvBpPkzbgOW6fG9qQsfR1BhjDRw9PF4mm0dWZOtRqJFvknpQOm7c2GMv+JXNmJa0R58MwJ84XpL38L/2Hrmt18dTc12MR5rfuWARja7RFeEwWWJmND0MqhT08L4OCoU9zsZkS4lde0TCJfImuMbZydxMbZ9ePGeduS21nScIQSyNSCyD8yUxMww2sNlyJatmiQazmd3StEr/4VeZxAUrZ/Bk3qXjJqmlxd2WOASuRV3KW86HCzJ53NRKFb9SAXBkEYrV4cVvM/yAR5qrfxwxcuRYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR3/d2oSz1XTd268Ae3dsxOGtJ55XR1ONYQRigVY/hg=;
 b=X6lsw1RR9+8ykJsUhpyU0mtfUZWhRXdRmDsHXaJOgcCWEEbGEFIWo7l4LmsxhkZQGFlZ7HV0OzHpgea1RckBn+HbnIGvU7GC48h3PaimTXcdNHXWrZGmK50vqiDDQh4p39XSqYjpvAfxFaO80ODssURXqlOmNvR6M2BU8lID6Gkbph1jCuyfrpJbRB3sY1dqW14VDE4Itv/SisHbYCOkB6Zdz+Zfp8N8cHSWnqwUoRRXKtHV2k8FRlBxEIAfnAoWJwBqPfwxzyShmnfz1rUkuqUlWPmtv8CSEPkWmLFfLdFyJWyHBASRMmUJwj5GoTpirLjuvj8r6qe7o7rb6IqYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR3/d2oSz1XTd268Ae3dsxOGtJ55XR1ONYQRigVY/hg=;
 b=WZ2pcZXom7fcqGiTmZi7dkISB+i12ZV56fazOzZvTsi5x5wtbW8SBJk7MuwAzyKHpnCcQEXYLrcYvoYXerG2IghrHKX5vH0uCmcE0F3f6vEOmsb9xLe98dVm8MhxDXyTW2mhIbmBm8Y+AVAui/5FGrlD6+H4oQuN7qTXo9b+knI=
Received: from BLAPR03CA0074.namprd03.prod.outlook.com (2603:10b6:208:329::19)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Tue, 18 Jun
 2024 22:45:24 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::bb) by BLAPR03CA0074.outlook.office365.com
 (2603:10b6:208:329::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:21 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:19 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 3/7] net: ethtool: record custom RSS contexts in the XArray
Date: Tue, 18 Jun 2024 23:44:23 +0100
Message-ID: <889f665fc8a0943de4aeaaa4278298a9eba8df84.1718750587.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1718750586.git.ecree.xilinx@gmail.com>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6fec48-664c-46bc-6a0e-08dc8fe85766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|7416011|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u5M3qa/krEENWkhlT1LGFFKud+VCr8iCmKfTjjNnbOnQ6oTP/BYO/QnKJkK0?=
 =?us-ascii?Q?SW+GrSaBCMES+dfgOAJUiYcLR9WSJP/mLIPE2NBV0dloby0a2shACT3elJ3h?=
 =?us-ascii?Q?kGqnAEgGrkuJqQKhP2nLJpAkHyH/BjNVSchRTr5ucRsaSaWyf1PhpNxr1YeD?=
 =?us-ascii?Q?ALnB6Ssnw14IVCu8e8ghrdr5bHyczD7HFiFTRArZvlwreTYOyZFBnCcSkPDU?=
 =?us-ascii?Q?32ZNRQ5FSVNobx3lpUfI6rhh/aCE8XtNXhXuFgjYjow3nU+ogrC7xpSSV/mr?=
 =?us-ascii?Q?gx5SqKMVeM/BMwqqwRaJhYwdaUyNCVMjuUfyzW5Hz18osc+b2Jdl/Nzk81XX?=
 =?us-ascii?Q?XcDyynhi9LQmmKUTzDJsQKdlp3tSIXfdCouu9hIL9bKygdobo7as5csfTvar?=
 =?us-ascii?Q?PXDEwo4gkU/eRL3u+Zj6YwvyPwtGm3CDRobK7vd3OqYJupxIU/md5qFVa6P6?=
 =?us-ascii?Q?OtaHTgSvrJvtX9VzVI5POvx4rq8+atbYGqthFVGH/zXeY6VesopDz33H9p2h?=
 =?us-ascii?Q?RUgZ7dkLHSxVmlzKrBsu47W6FJc9keJ5YCy/KBnOqAhzU/+vPhn3Z0UFGSSW?=
 =?us-ascii?Q?DqjdvLrlULPeWKOLsVkIxCP0EQA4oJWmGCiy2vCOK+JDznIcvrBKbME5pye2?=
 =?us-ascii?Q?0dqYUUxDizGQvg2XgwAoiCpJ5SnE79pSA10yq1L82jRdzkshwIDSUY2lJvEb?=
 =?us-ascii?Q?eLjjPUX+oP/49Fflht5XJBd4iPKAnQVx0T84H85aSSdX38AUUED1i4PYijay?=
 =?us-ascii?Q?XFlUkk8jD8L0tOJRtH3ZWEAQNgdMt0NHzxPwsfIAKOdvSsuVwIIJtUTcQd7D?=
 =?us-ascii?Q?SblHkD3Vn+01+QfPf/s7vP9rHlbjWfLYFnMYO3bisUttqDhW78r4EkIroP3/?=
 =?us-ascii?Q?0mwjN5zQDVxTj8+0Lq/ZlrbrO/NuOO9bQ/U0vDp4eGoLb/3H4Sm0Rh7GNaJ9?=
 =?us-ascii?Q?HjzzAyF+ADeIbw5nHx8hL6xL5VrQIJ8Dx5g9P04mv+teXcYz4U3RK8zojgSQ?=
 =?us-ascii?Q?5nKvySQ/3f7d9XMSeGP4QzCauVdKL6Qs5wil7drD2oFf9gr051sreg1NZlk6?=
 =?us-ascii?Q?JzYKH/+LMkiprYa1Xx5Sv8NComI+bb0Br8ZJfltvNVsk/kiDpBxyQg2CBiBH?=
 =?us-ascii?Q?fJJZ+QYeJe++mAM6n8oU5qmSBQxW+VTCvP/y3/hkhAWYGqy9iD6ddv74Kj++?=
 =?us-ascii?Q?zKB9btCnz96l3veN3YW56+cCh4bbmCeQ3SZlygu30eoNdf5Ti5tcYbwFXBDu?=
 =?us-ascii?Q?EGCVa4pPBtE8Qyh5LcJNRMugIoD+6r4WK31kEjPo8c+4IwQWQqYe0LgSupR9?=
 =?us-ascii?Q?YfZimWdHtvzmAUtCwe2tIHwZbW/swlereB/S7Lq8oPRmRqFIXNiEZcgx9MZE?=
 =?us-ascii?Q?sPAdNuPR4NGq4QHya+8ajVqY/qiOWN9Y3speYlmWMLsj1dXllg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(7416011)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:24.0657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6fec48-664c-46bc-6a0e-08dc8fe85766
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846

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
index a68b83a6d61f..5bef46fdcb94 100644
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

