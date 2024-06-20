Return-Path: <netdev+bounces-105121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCC90FC4A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EBA1F24D2E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781E39ADD;
	Thu, 20 Jun 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mhU3PnPh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C239856
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862493; cv=fail; b=VOFaup6Gu/VXYpIpe8iR3oUKMJ6voxWPo/suIzmaSDZWsxMmM21u7BfzQKVdFUpySw7PQRLi6fOrcRKd6iynqeXesq6fHA8pLwIBEQ2HMzXVxo8C3nKAIMFeF1Mj7BCmFaKg9C+Zr+842UZ7XVv0Pvm2Bdby3xx/RHEzC3jKZnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862493; c=relaxed/simple;
	bh=rYDgen6AXGuBlTehGB8K1N00m4ISxy90Ht+BSP2iCY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0UfuVmJhrrGry/8MusVBsL34oDBQDHvwndUeNnyt0Z4SzjMvSFymKo0DwWftf1rhpWZy0pFLuO1OLJ2WJxQ0ZVeruuP2JPHXMF7iGWvyvSRnC30amdUAo0qr8PHpUcKoqpFm5fSW5YdwahdSCTeCrp/qwdPXknSzcN227Mt7XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mhU3PnPh; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agr09wYIbBTJHdLTot41LV9ubzyBwprfjfdhgqhscYbyQ1qjVEoOVdtAON/cFhIDDCZ3tgA9gfryrrC2VoDg8Im0O+0NhI9cYbDHH8ZH5slP5LFdzIDg5jCfbknfhLWKRp4zGO4v7IPaJh7gZOYPlx6SQXivUBCIlPCft1PO7Te62YyJkGQMK9TN0AhW+gcrC3IKRPeVZ1hzxCXm5FfoU7GubHQZARxuZ1C6baRFuN8hcfosgvO/mQG0o6AuisB/Miiwy8GYYba0OzZsuJEnI0IZqzDJ5mVVn9JlCvgfaSyg9CFiXZl4TNjulBEOF1GDKVAKuQ3tpAb/TY2ax8epiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU+guhwk4Hup437pRZ1HEBOxeA+fuaGROLm2zcczlfU=;
 b=XWxk92h+PTTF8gJ33F0NZKPwO1a/wLyUmpjgKxUinTwVeRZ12lNyu/YHS9Ctu5DehoOxkKrzOcxAeItPVQ7pHlpjuYVsaXkv5lDqHPCykJOYtKG6NFVFOjLFn1OXwadFnkYd4UdTKyGOBnOH3Jzd4D73J2FptiFt36YWC9pZER/9G0dRLW8WFNP+8TKgw6Q7GLxOQzfSzwzrK+PFe7GYUAie2P6gMlDIpQ2DtAR8T0s9ZWr8ICQeHKOUD+lyKFF7+Mwe7BVvkCdymOifZVXuTFIgETRmEbKbALDr+4thEx9UCz/sew2ShfL/R4nSNHD1P1yHbWCeI+5LmYtNuSyTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU+guhwk4Hup437pRZ1HEBOxeA+fuaGROLm2zcczlfU=;
 b=mhU3PnPh3hPWCSwi6VRxP6q82MrCCap82V+piTChLrE46E09a1WKerueqgvl1+PpYEu4OFDMXLsisqiIUNZs+D3Clu2QlSKfvGbsV6LWn3lDHoycTR0WGAR2lFmez7wAot1+bW+uG1xDKFnzJLzaWN5l/Ypgoi4TfevkTewxKi4=
Received: from DS7PR03CA0204.namprd03.prod.outlook.com (2603:10b6:5:3b6::29)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 05:48:08 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:5:3b6:cafe::7e) by DS7PR03CA0204.outlook.office365.com
 (2603:10b6:5:3b6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.34 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:48:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:07 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:04 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 3/9] net: ethtool: record custom RSS contexts in the XArray
Date: Thu, 20 Jun 2024 06:47:06 +0100
Message-ID: <e5b4739cd6b2d3324b5c639fa9006f94fc03c255.1718862050.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db75ab9-a57c-4ee0-82a3-08dc90ec8ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUBJglbGyBxdj3aSB9fHGp5TWWJBeYA3SBZ5IfakrodQTkS53/Xtq04qhlPB?=
 =?us-ascii?Q?OLDnY43yWzoSZhpFVtcu3KRbWPqvwfMAxSLO7QYv590O5hqqcb5cklZofUcJ?=
 =?us-ascii?Q?VuzPZoJVcsJvRfPacndn6/DAwYztyhU66H9v/eoHXeuvrCJ9iipBchCYxeHB?=
 =?us-ascii?Q?ttRIcLl+3I+ovunoiXQBEvS5oYIAVi6h+x1Pq7hNBIdQw3DEtfhcA9/ZM6/L?=
 =?us-ascii?Q?P2A3JVWhyq1n1tp5r0gCMJ3gECQARBLANFmJ6S6d2dbJGG9BbcrX89oZirCZ?=
 =?us-ascii?Q?NCBfO/jwlBN0TapAKJPMHemLubocBUvJlw57g6HqOBCpJKMujiTzzKLT5/lL?=
 =?us-ascii?Q?LkJ4zA7eDq6zbip5cCQRhazvQsBXZfOIj/2GcxtPb8mLNq5NS7lNCY9A7XMX?=
 =?us-ascii?Q?995p+1dRRDBUwQpzW71s+3emrK+2PveVeKTRyHl6z7LBWSpjlhMORBJYUBqG?=
 =?us-ascii?Q?KjwYn4wFvUcyMExYAIupUANqntpgI0qIya1chLQd1PLQi7vVJesJh20hpiMu?=
 =?us-ascii?Q?37pqbfeS/oJD78x+EEGt/U94gXB4V9RuLQmOtRkoOEBAURxXvGjIYfJAFenF?=
 =?us-ascii?Q?3ndx3vdH25orne9z/8njP83Tvl945NTRaLto/JK8kXPrkxBjDNqjT4K1rB3G?=
 =?us-ascii?Q?Ya5DnO6lASkBbbOEU5THnQptO93FjjcKfI5YcEgLkwNjrVwCPyKJX4RoZImB?=
 =?us-ascii?Q?96IsrDpmiNkVo6FBicm29EL6DbmkeV8ssSNxeYSMgFa2w2XVjc64TfveWspS?=
 =?us-ascii?Q?GxSnVTEVeGmMV6DSh08OZ/lUAPlGB69BwKZYcu2zvVeamXcPKMV6pzXRz/xJ?=
 =?us-ascii?Q?OCH/Z2URwVoRmzS/s22kvflgycbF+KLxxwp4pilvNQG44jk31Detrp5ExEhU?=
 =?us-ascii?Q?OYync9bFTOVO1saV02OZCtHOZANF2MwBKG1bekreWUn4OMDT6JcnbCQ7+WiJ?=
 =?us-ascii?Q?F7HvXhuqkITKyddRdHH7EaYbJt9MUasAdaH9IjOOy778rK84DbXibRNgVBrR?=
 =?us-ascii?Q?AvKp1Cbhq5eGirdD398Cg7tlzRI3qVxNGP8OndHWmn4ibiUOuaIaxUz86eiM?=
 =?us-ascii?Q?evryb3tLBEg1fZ3It+sr6qZf9sr0IChxaa4bv9SlgDKJPLdWUNH714nLAtVd?=
 =?us-ascii?Q?DPAo9Miq7GWUiJv4k/M3oPJLrFxnaoA0uObbOG2OiNFbtx7sLqJE6mqTWHIt?=
 =?us-ascii?Q?WqMNEbGLxDAu63dCe1ieEEonF+/Q8N0bd9I/Ww8ssKbO3rY/zoGPTQ9UQPRJ?=
 =?us-ascii?Q?b4TTo0cyKo2eu+4iu61oCHrBwyinZxdpgs5DQIkMyl37L3kg6gD5XSXUqUfj?=
 =?us-ascii?Q?84h2v+nzDjooDyr3A4PKqOYMAQF89v9WN/o5QOSVsut0yRhmo083e4pieT2I?=
 =?us-ascii?Q?mZEeKXtCqmwZFPYt8iTJD3HnBfmbBvfC+iHp46K+j3ZGUMOSpQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:08.0414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db75ab9-a57c-4ee0-82a3-08dc90ec8ff0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084

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

