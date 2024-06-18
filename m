Return-Path: <netdev+bounces-104674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7D90DF37
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ECD7B22ACF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F048181CE9;
	Tue, 18 Jun 2024 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mswazMft"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13B16B3B2
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750729; cv=fail; b=GlQ/raz3oC9UqvHvHmrML3FuPlIg7NevsDPrJ0Ig6HvUmFEbUbnn6yH7fY6ALpihfko2fZjr77Kodu5GIgbQhjZ7BmU70S5ecTJ/i96WCiX8ee/U1S3n8rvwYCtdQbwYs5E4ukfDA2MuOyQuGe0ULrRNnwCdD645rpeBqSDzk5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750729; c=relaxed/simple;
	bh=Xoto9PGikraoMCDBy2QF52bwiWZCyotnUI4nNloHfIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oCJxYMwW1DfVEP1sMMiIHXyDHZUlAs6zG8c4VPr1Tk+sOK8KufGJhHYMzmLcqhwYuDsDR9m0eJKpER3P43o1Sa84obZ/DT4w0tVIMQvuEfwJi6B/OKi263JRE6+iHoyrKgO5KSfiu/mU5tU+pDoYggODnhhOiSJtfcylgFmPhwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mswazMft; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiBBuM21BeLqWvCvP+jqMQryoifSWu9L3JSDIqu+8dzjsN5IMlhnhHHKC/ZMxHFo61ZqqeXOeXQgksya1frt7BloonLdgmy6pqBWnjjQ2eCd+Vnb6eqH/Y38clItUgaSIumj08rtQBEbyJfTY+dfuAGXsVAhWq938cAI5Z+da/62V5q5wlSPnDzZ/hR/VHxTZjp36EBqMgJC00PgaKr4TD7gcCW9p/sQ+n8qkU3zTj0WT2vbkI5y73bLjP74lTMcWkx1VqU0au9xprK9llNqLylFYHji9N5ZWqSkSOYOW9tADrs5HLuuwZT9T9IKITm36/84OdxTXgM+t+S2duZChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0YssiqMWFu2kwokIq2kObo97/zNJoXmGhlJrubu4G0=;
 b=DMphKOkAO+6poZl9uH4SOvNHa6fh/MlNakPf9oiJOMnyv9IphdbP5MBQQkwH+9ZsIucRrpi4Ct3RB4QBs65IQHuwOq4LmALxUaBROFWKyxc3GybNAooBD8si+0H4S1g+mLRkLapGMC3LwGa78VFNPHX+fbbrIe6cNI6EOrjF9nXHLUcEfFf6WfydGrkgQUH9ox16qAB7cdgvpC3acuUS0/dgoOlkIFx2JQpEcQOgnLYmWGsWcUGRqbvkKhLH/PrzrrwhozRVx2QOP2rcuTELnBFEZWJ3bAO9pt8ZXBgWuiKoqWG8JVojm6RSSxjrNAhUjoSEg1qbkKrF26wuGCT6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0YssiqMWFu2kwokIq2kObo97/zNJoXmGhlJrubu4G0=;
 b=mswazMftKDImarx7JqksiWZVAgeieunBNTrFdijUoBiikesbclkoQ6JJOBdv5O2C/gvDdiirbmVmxJtCxPAmLzAkFtOAuN6Bqt/tbU/mWcqsNEVv2GoYhJ0/kQ/lCSKnDwTprxTbp1ry0zJMA1SlItBeRCIfXCA0u7SxbiB09PY=
Received: from BLAPR03CA0155.namprd03.prod.outlook.com (2603:10b6:208:32f::13)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 22:45:25 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::73) by BLAPR03CA0155.outlook.office365.com
 (2603:10b6:208:32f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:24 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:22 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 4/7] net: ethtool: let the core choose RSS context IDs
Date: Tue, 18 Jun 2024 23:44:24 +0100
Message-ID: <7552f2ab4cf66232baf03d3bc3a47fc1341761f9.1718750587.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 144b8e5f-aff2-4c78-2570-08dc8fe857e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zLfnTDTFUsTxNxQ5sh9bq6MIp+31cf4Za2DsyMuhInG4lCLkFZXxoRv/JoYn?=
 =?us-ascii?Q?FiSxtizgGiRyXscfHkHDOd75uigCD38TlaJ7nXcd70uMsseCa4ctVXYsDRGu?=
 =?us-ascii?Q?nARCcZIbBaJnrWK55ggaW9jDGMw73xNT6EKbT0IvEiDbk4r7l561sap4BMWX?=
 =?us-ascii?Q?w8t/OfaLcu4gBH9NwNuiRVBL+g9S16iScFICJtAivBTrDO25MGSdhEHgEiTj?=
 =?us-ascii?Q?isiaDeP2XX1TulE1RH+7tVGKIYdy6U2fBgo+HldqKjxgMRnWGbDXH4hJhULQ?=
 =?us-ascii?Q?C0yvTpLRdp8xzJHirXBQFt7KMvk0GgDSuVE7IvrDeysGHeWFetDk5S/8mQ1A?=
 =?us-ascii?Q?fh6qwsdkMVt0s9dlRTyWUuHHdYs6wpA61k40qQ6+ek2AXBbT38jYmzfdSMrB?=
 =?us-ascii?Q?6j1PHUz1Q9inZCEj0VHvFpdWZmPs3c/SQi/L3V2hOEqITMlVDZlXSoMULe49?=
 =?us-ascii?Q?d6JYaBWUtkd5FtItWskIIQVVyCcDjYtKmo2IcjuaC8rjgva4rBpYtyKSuoIr?=
 =?us-ascii?Q?spi87LPdXW/gBIEF4bUBJd5zXE2xW8kmrFCb7X9FBrCj3lr8YoQVYUoJepLJ?=
 =?us-ascii?Q?3yUkopPqFYq3jGDaG2sjih/+oHnsskT6UQeJcHFerl2hAGPCw91DqDJDwcu+?=
 =?us-ascii?Q?aMUNb2vNGrB4H69LjyTYbwJ65X8eCXwJs5ghS7cYTyZrHEeXUVqkhIYvzJJ4?=
 =?us-ascii?Q?je9kl/nCHleGHzGSG6eMvUPJOe2oOQpQDkAdRxD/Rj3iRsj258JR/SEvUX+9?=
 =?us-ascii?Q?FA1lJ5036sB+kJnj/wGv7gIfEHB1tmHrvRfmaHdvU8DqrEzQFR4k84Hsx/wT?=
 =?us-ascii?Q?TrehecRNWXeOrwZexSSCOaDMho4cbSd6Jc1xZeot/pPL9NeiFxv2g0C+C/aI?=
 =?us-ascii?Q?jVXf5JsK0wklnIzz9oXXh2FzqWad0Ff055eeqAwdMvzqVwf37ya0uIbCH45X?=
 =?us-ascii?Q?QwlHL1rZWXhTNklgNshjg9eHAIafSYeMJOG1M/JmLgCGjID/EG5+Go/mwTF2?=
 =?us-ascii?Q?c3HzNFfJQmkOG7DTFmDqJAysty0DT8BfNOTuHqRxOeXABFv8gSDX9zX3OE9R?=
 =?us-ascii?Q?OSGRN77ouBFZen+iLqaINGNEnVA2rlI/CoaVlFmGs3T3KYAQGWSRmeu3j1Rv?=
 =?us-ascii?Q?TyNPxd7v/L3EeI+DMcUeBt3/XOBVByfLDVdRgB/jNGtWvFK+R89JQdctsuPz?=
 =?us-ascii?Q?RG8w4UPH/8HjjQXO0+mVaguZsAApeWN9j4IkeTyEGPCGUyAddGrLPeF48KDl?=
 =?us-ascii?Q?ygvdO6omNQD9qR4+1p2nyCkjE2tKZVV7GP984sX5lDcO+ON8gIrniZmQq2FP?=
 =?us-ascii?Q?cNGTiACDn3j0AxU4Uyv+nmTG71wk/5tOhyO1lOQYD7z4WcG7w6mdafd4pdPk?=
 =?us-ascii?Q?nj9veVVGDlVLPef84IDogM3Fq3cvVU0njMQDIPdyVdRCiLk44w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:24.8765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144b8e5f-aff2-4c78-2570-08dc8fe857e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642

From: Edward Cree <ecree.xilinx@gmail.com>

Add a new API to create/modify/remove RSS contexts, that passes in the
 newly-chosen context ID (not as a pointer) rather than leaving the
 driver to choose it on create.  Also pass in the ctx, allowing drivers
 to easily use its private data area to store their hardware-specific
 state.
Keep the existing .set_rxfh API for now as a fallback, but deprecate it
 for custom contexts (rss_context != 0).

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 37 +++++++++++++++++++++++++++++++++
 net/core/dev.c          |  5 ++++-
 net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++-----------
 3 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 5bef46fdcb94..4fec3c2876aa 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -722,6 +722,10 @@ struct ethtool_rxfh_param {
  *	RSS.
  * @rxfh_priv_size: size of the driver private data area the core should
  *	allocate for an RSS context (in &struct ethtool_rxfh_context).
+ * @rxfh_max_context_id: maximum (exclusive) supported RSS context ID.  If this
+ *	is zero then the core may choose any (nonzero) ID, otherwise the core
+ *	will only use IDs strictly less than this value, as the @rss_context
+ *	argument to @create_rxfh_context and friends.
  * @supported_coalesce_params: supported types of interrupt coalescing.
  * @supported_ring_params: supported ring params.
  * @get_drvinfo: Report driver/device information. Modern drivers no
@@ -818,6 +822,29 @@ struct ethtool_rxfh_param {
  *	will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
+ * @create_rxfh_context: Create a new RSS context with the specified RX flow
+ *	hash indirection table, hash key, and hash function.
+ *	Parameters which are set to %NULL or zero will be populated to
+ *	appropriate defaults by the driver.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that the indir table, hkey and hfunc are not yet populated as
+ *	of this call.  The driver does not need to update these; the core
+ *	will do so if this op succeeds.
+ *	If the driver provides this method, it must also provide
+ *	@modify_rxfh_context and @remove_rxfh_context.
+ *	Returns a negative error code or zero.
+ * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
+ *	the contents of the RX flow hash indirection table, hash key, and/or
+ *	hash function associated with the given context.
+ *	Parameters which are set to %NULL or zero will remain unchanged.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that it will still contain the *old* settings.  The driver does
+ *	not need to update these; the core will do so if this op succeeds.
+ *	Returns a negative error code or zero. An error code must be returned
+ *	if at least one unsupported change was requested.
+ * @remove_rxfh_context: Remove the specified RSS context.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
+ *	Returns a negative error code or zero.
  * @get_channels: Get number of channels.
  * @set_channels: Set number of channels.  Returns a negative error code or
  *	zero.
@@ -906,6 +933,7 @@ struct ethtool_ops {
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
 	u16	rxfh_priv_size;
+	u32	rxfh_max_context_id;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
@@ -968,6 +996,15 @@ struct ethtool_ops {
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
 	int	(*set_rxfh)(struct net_device *, struct ethtool_rxfh_param *,
 			    struct netlink_ext_ack *extack);
+	int	(*create_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const struct ethtool_rxfh_param *rxfh);
+	int	(*modify_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const struct ethtool_rxfh_param *rxfh);
+	int	(*remove_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       u32 rss_context);
 	void	(*get_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*set_channels)(struct net_device *, struct ethtool_channels *);
 	int	(*get_dump_flag)(struct net_device *, struct ethtool_dump *);
diff --git a/net/core/dev.c b/net/core/dev.c
index cc85baa3624b..c4e880397c07 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11203,7 +11203,10 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		rxfh.rss_delete = true;
 
 		xa_erase(&dev->ethtool->rss_ctx, context);
-		if (dev->ethtool_ops->cap_rss_ctx_supported)
+		if (dev->ethtool_ops->create_rxfh_context)
+			dev->ethtool_ops->remove_rxfh_context(dev, ctx,
+							      context);
+		else if (dev->ethtool_ops->cap_rss_ctx_supported)
 			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
 		else /* can't happen */
 			pr_warn_once("No callback to remove RSS context from %s\n",
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index f879deb6ac4e..2b75d84c3078 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1392,9 +1392,24 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 		ctx->indir_size = dev_indir_size;
 		ctx->key_size = dev_key_size;
-		ctx->hfunc = rxfh.hfunc;
-		ctx->input_xfrm = rxfh.input_xfrm;
 		ctx->priv_size = ops->rxfh_priv_size;
+		/* Initialise to an empty context */
+		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
+		ctx->input_xfrm = RXH_XFRM_NO_CHANGE;
+		if (ops->create_rxfh_context) {
+			u32 limit = ops->rxfh_max_context_id ?: U32_MAX;
+			u32 ctx_id;
+
+			/* driver uses new API, core allocates ID */
+			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
+				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
+			if (ret < 0) {
+				kfree(ctx);
+				goto out;
+			}
+			WARN_ON(!ctx_id); /* can't happen */
+			rxfh.rss_context = ctx_id;
+		}
 	} else if (rxfh.rss_context) {
 		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
@@ -1406,11 +1421,24 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	rxfh_dev.rss_context = rxfh.rss_context;
 	rxfh_dev.input_xfrm = rxfh.input_xfrm;
 
-	ret = ops->set_rxfh(dev, &rxfh_dev, extack);
-	if (ret) {
+	if (rxfh.rss_context && ops->create_rxfh_context) {
 		if (create)
+			ret = ops->create_rxfh_context(dev, ctx, &rxfh_dev);
+		else if (rxfh_dev.rss_delete)
+			ret = ops->remove_rxfh_context(dev, ctx,
+						       rxfh.rss_context);
+		else
+			ret = ops->modify_rxfh_context(dev, ctx, &rxfh_dev);
+	} else {
+		ret = ops->set_rxfh(dev, &rxfh_dev, extack);
+	}
+	if (ret) {
+		if (create) {
 			/* failed to create, free our new tracking entry */
+			if (ops->create_rxfh_context)
+				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
+		}
 		goto out;
 	}
 
@@ -1426,12 +1454,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
 	/* Update rss_ctx tracking */
-	if (create) {
-		/* Ideally this should happen before calling the driver,
-		 * so that we can fail more cleanly; but we don't have the
-		 * context ID until the driver picks it, so we have to
-		 * wait until after.
-		 */
+	if (create && !ops->create_rxfh_context) {
+		/* driver uses old API, it chose context ID */
 		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
 			/* context ID reused, our tracking is screwed */
 			kfree(ctx);
@@ -1443,8 +1467,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			kfree(ctx);
 			goto out;
 		}
-		ctx->indir_configured = rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE;
-		ctx->key_configured = !!rxfh.key_size;
 	}
 	if (rxfh_dev.rss_delete) {
 		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);

