Return-Path: <netdev+bounces-105122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493AC90FC4B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB8E1F22F22
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8B39856;
	Thu, 20 Jun 2024 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cwfuNMpL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9739AEB
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862494; cv=fail; b=s8C64PFr8dqz3EzUn9xrwG36QStPCEdDSFiKdcQILze0xtYHfPf1YxWnD4RPUDs2iYwpChUfKQyP2b2/qJhFnKMwlytu23GZuWN9F9AjKSYlsB5ud69KgxKkGUlzKdyl3i3dD0A0gkOYt5Y2xqOA2nEWZux0cOOKIHQL6UIyISE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862494; c=relaxed/simple;
	bh=EhoY9PHrHMwjzxsdbl9Ef+eZe0heLALeMdWqsG/Ae2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+/fChqtgwGV6Et6YISXfF/x79tb/hv/BIfFnEr/Q5ItSXiGdhNZiDGtApEWOClLxJCzRIA4aIe2hlw+SVlqjAKA+oAIDVDuPT33SyiBYVOv6mQ7O8mnqnWIXakTr4oK2/JUu0JFG4aqRQkwj3pWOE9Or771gmTHAxKYg1BmT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cwfuNMpL; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7NOUKPr6uoiks4mYC3w8r1ORDYRy3lfq3ZdcNcELkT7c7aAgzQ12YCCJFTu/vUYcfRhjJ+5px8Va/q0YzY7BW9XizU9Fa/l6El5BVfCuItWS3DMiHYtBGCeVvVaG4ayRPEstnfN35IUTWcqTB12m/wtPROPms5KC711xxE3GIOCezXSbZydAHjHVbVzQsS6GP8/GiWYQ16iVPFtH+11u9bJzZuS5J/VB6umkqzsupugwdOYBbpl1iRhs5agV3MbBwecOmfqWb0gTsR9mJyH9Lou166NED5i5klSmJSO9YLI1QWgTFpOP5oRfT2pylJoYR5/fV8Z0GY5QX1QqfG5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bYBlgMfSAqqqcQDsEeUcNXbmhW47Tl03x5sNmoGBTI=;
 b=lmTXpK87sBKLtjFNGfZDxPTTEN4b8mjhzRqrFGIqp/UsItUPXwVNRK4pPO/MbBGnUrcAu4JczFeocFvsf8lfmWcx6rQOp/PAgDe2McjrMbXpojr4Yt4R5ocLuGRadHLAMSgaQuL6p60EP6tERfAlHany1VQuZTMmK0K/IU7qI9xKKCQxILzMI2lb30agSgXS5XbGGh56SGyKtmwEm+gXWVsHm3VniQOzxRwx8h9K3ke6anwG0E2CKezaQGOpDSPXjsKnAMvYJ53JHfaAkgf7wozmWrRqLimOMH8E84YovcXlMqp2m9mdjqypzLo6x+YSE6nQ01DtuAY0x7Cx5X3law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bYBlgMfSAqqqcQDsEeUcNXbmhW47Tl03x5sNmoGBTI=;
 b=cwfuNMpLDWMykV78HuFcnP5x+wcRE4aEzqclF79vLKRmfgyt3EdAWxbAvC1KLEnrGLg2ugW3DN0UPckMa91LY9uCw0WM7V36oEzyYZBotEaZLoNhY5i7GU1XIhSVoO5TbrEpiZ43YjzY5I6JYp3bDGV6Ge/xRiYrUoj6aPPYhZc=
Received: from CH5P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::8)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 05:48:10 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::c9) by CH5P222CA0004.outlook.office365.com
 (2603:10b6:610:1ee::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:48:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:09 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:07 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 4/9] net: ethtool: let the core choose RSS context IDs
Date: Thu, 20 Jun 2024 06:47:07 +0100
Message-ID: <8db50fb9ae4bb623cc0cb5a5e99d70fab2f32d4d.1718862050.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 89566c3b-6f84-4ce7-2f60-08dc90ec9171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|7416011|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FeNmEMM/yxeTyS8jnztIptA4pndpFWPXKW/ZaEJojWm3A4qRLQea/3WFC9zC?=
 =?us-ascii?Q?qMNZMcVADg+rWCYrdT5d7IBVx3oHnOiF6yHkzYXnz9OgbBaMQQZcS8KBOxAY?=
 =?us-ascii?Q?kpdMabFtOhM36yk5FMkmfa2kO85XQ99tScANekKmVdrtNSU5L6lgh2uSQmdG?=
 =?us-ascii?Q?AKSGATWsvILRjNh2wssxHIJzkh3o69JJW50Nae0ArYLp5gaLg/xOd0CNLJWN?=
 =?us-ascii?Q?S2Mz8TNgQ8OQAexT/OTEPkxzIdWmF4V1hmNxIDLuOYSImyn7dvY0nt3qDn12?=
 =?us-ascii?Q?gu3xblSS0Qvrxg1NThIATPS0UvKoyIHi+Fn08K8LkaMz8wZ5wakmHZZJJN+Z?=
 =?us-ascii?Q?rqMLAoSnfTLdtO/SCnCOqoFF3G2XqPjQk6KPYUU1A2OkFvXkmwFFYnmnBZay?=
 =?us-ascii?Q?L+Fs7NWUu8Z0IKIBIXWzWns3mwgN65n9SLdN4rdWG5NE3c57Xy7S4N7vJ75P?=
 =?us-ascii?Q?x+Qu20pcaamSCVlinfbV1IDjQ4prPJl90HxtnzPFiA+Ez35RUH0jPcAZfrtJ?=
 =?us-ascii?Q?yCFblI86LyuX/5PJvLqavOkhrB6OyFSoGeKEeUIJ/GHE2V9FxBc6sBliQNPT?=
 =?us-ascii?Q?Odj7coQ6CIpynI016ocA+QctOrvrMipRGtX9dr6VwBIiRDHDKaIuyUehUxh/?=
 =?us-ascii?Q?pkkx1iLB7ZizA8tN4M8hlNQ8YB3Oc2nCP48nPitMZjRh608BgJl52zwUKNHt?=
 =?us-ascii?Q?IluI0uDQZhhnVTBNinXQwXUVl0crDizUdzT3jV/mTxzul5iXtsGLYkLXRfFj?=
 =?us-ascii?Q?H0NDkPUBv5UyjK9sxKe8u6z3WC0rHbIc6NfLmQ+zcqLBGCRLiBGUfem3owfi?=
 =?us-ascii?Q?Dw84YLMdqgre3fPrHbPXEVt1umhUOTNIJZ9hmoAIJm46kVA0S8FH7t5CLRlW?=
 =?us-ascii?Q?9ll8TR7HUjSrSqKhD+SEoUYU7NCGSOiwngryVyYBIpdQvEvBpCIBuGg/7IhA?=
 =?us-ascii?Q?NLJS5HFt6tXMwr3KuI8eyRbTP8TW+l5BO2ihZNXTnszMvj3hCIf1bwCRPPfC?=
 =?us-ascii?Q?6w0gv6xMofP/24T86j2eMC2SSegR/kiY3nWPoXMfA5Wka5QXOwFUYkp5ztST?=
 =?us-ascii?Q?Cckm19FvWgk4CTSKxeYJVI0O7E7InfJRiZZ0/DlNk3Z8w2L6GzFq6RhejpMP?=
 =?us-ascii?Q?O0Kwo5APUZDNASH1qS4tC36NtejkUQfl50iNTRJRZGOBMPyD4KkQeIP8bNci?=
 =?us-ascii?Q?c8CFbLUhk+xu00CctcEFjbA6AhnQ40e7bGdo/v76MTh51r28+XssDJ3lnG7Q?=
 =?us-ascii?Q?7/ceL14GGoXjqR9l8pSMZh8svil/kAjKwcv8NlZWSbZdwT6LPruxB+io7v9X?=
 =?us-ascii?Q?6xno3oexkySC0/J9eLxe7RR/zLGd5HPCINNWqo9GGxC/3qnhucO18CUOq89j?=
 =?us-ascii?Q?/sI9DaaUGYtOpnU8DXHhJtOp16f4jpv9vZ6CG+XCcNdg10IiKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(7416011)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:10.5782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89566c3b-6f84-4ce7-2f60-08dc90ec9171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

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
 include/linux/ethtool.h | 40 +++++++++++++++++++++++++++++++++++
 net/core/dev.c          |  6 +++++-
 net/ethtool/ioctl.c     | 46 ++++++++++++++++++++++++++++++-----------
 3 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 283ba4aff623..d9570b97154b 100644
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
@@ -818,6 +822,32 @@ struct ethtool_rxfh_param {
  *	will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
+ * @create_rxfh_context: Create a new RSS context with the specified RX flow
+ *	hash indirection table, hash key, and hash function.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that the indir table, hkey and hfunc are not yet populated as
+ *	of this call.  The driver does not need to update these; the core
+ *	will do so if this op succeeds.
+ *	However, if @rxfh.indir is set to %NULL, the driver must update the
+ *	indir table in @ctx with the (default or inherited) table actually in
+ *	use; similarly, if @rxfh.key is %NULL, @rxfh.hfunc is
+ *	%ETH_RSS_HASH_NO_CHANGE, or @rxfh.input_xfrm is %RXH_XFRM_NO_CHANGE,
+ *	the driver should update the corresponding information in @ctx.
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
@@ -906,6 +936,7 @@ struct ethtool_ops {
 	u32     cap_rss_ctx_supported:1;
 	u32	cap_rss_sym_xor_supported:1;
 	u16	rxfh_priv_size;
+	u32	rxfh_max_context_id;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
@@ -968,6 +999,15 @@ struct ethtool_ops {
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
index 78465b69dc68..e875b0a579b4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11203,7 +11203,11 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		rxfh.rss_delete = true;
 
 		xa_erase(&dev->ethtool->rss_ctx, context);
-		dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
+		if (dev->ethtool_ops->create_rxfh_context)
+			dev->ethtool_ops->remove_rxfh_context(dev, ctx,
+							      context);
+		else
+			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
 		kfree(ctx);
 	}
 	xa_destroy(&dev->ethtool->rss_ctx);
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

