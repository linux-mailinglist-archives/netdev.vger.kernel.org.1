Return-Path: <netdev+bounces-107373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC91F91ABCD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9570DB2D2CA
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B31993AD;
	Thu, 27 Jun 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xoyJGxaZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B88199234
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502477; cv=fail; b=cV/2hiULcpZBybm/kSd1SlBb5RSbZkgJ63lBW6jQJRs8fq5HF8zn7qmsrr8dOD0QZmaNtXwrcJz5/s0cepvFpLYJ1Kur17hc5HHFv5AkvFqFTavDjaT7+yn+3SZd8q/7p7Pt1Y6bX5z5DifahcK/id/CkoTgz5yDjf0diNr8fJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502477; c=relaxed/simple;
	bh=R8TZt7ia+plDs+DcJE4F5c8+cP6P8u1ZsuSlJy+Pnnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpDVd9fer+ZBEUFFnT/ZZdURXT13IFPluQ49smW3lIOXPj4Bkvore5K9joPBcqe5pBnHjFcdcDJ66koKp4E7EkfVuAwv1BC7hUxrC5gpqoprTl3Jq6AVoTSojdiZHdieY1GysA5dYKlT29/dZYSLWrya2HQIknMeRza38QQjzwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xoyJGxaZ; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHhtSdBJg9Z3WQsdwydJnrdmhiiK22eW4HIUmfntD6vRq8PP8HmquLirAAMoASj3rjEyxahXfTIkhuV8WkJ+ts3ou1S4DXU6576aCR4MfuNjmKvZcu/ikZKMcY2Ud8I9VGRkmuyP7XuOSKTiPBuvVpnSsenX66DsFGtIiL9MxgId06uaE2i5nBhANE/WIrKiTY0AWeYVR5PfjdLxo+7GHNzMBTNCQoXeB0G6rJD79GNGVxGoGZOLnh1rBP8emrgMd6Ez1yDVIyLvMmVQik6tYcB3uBgoLr5sy+br+YiLEWQc/nbgWiGz1mpe32c4mYCGy0D5QajnQL+4RRM4doAKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naI47A4KkhjInp9EQBrN5EuC3hCsdVns6UCPRjGw26A=;
 b=QkngyyDDeGOxfDWorS9kKMscjfgYNb9N2bb+dPwrdbPy0QAsWYF56jdzECAA2JDdfy1hwK1psM4NY0n2fn8fero4ZHfYfNZv1ufDHTtwam8cXXd/dOiNA2um1SJ/cOaTaYAHN60GRBk1VTgHe0WvXNQ0/SwdSDHjqw2VxOuc9yHsAzZ0SKj78yHUGGT4bn36lgqDVwqARc73c2G1IAhwrZu2jAkL4u/LRNY1gQZn7TAxNP7dO+c5AgNiJVCbl0Sgbju8OB+qOftehHCSGRatgnQTVFvdnhTV78t5OPlMwhxo9ALa2xcyMgsSxSWj0aHWm9keojxicXwzsh5121ihaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naI47A4KkhjInp9EQBrN5EuC3hCsdVns6UCPRjGw26A=;
 b=xoyJGxaZQe0KSdo4pWeqfPPoKfZtpz8TRNHLWBQru8//ELufvY9P1M4Ov65cn7zTxfYJArDlJmXXDFckIoOyx+lesphYlhN0riVQA0wVS2rW0b856NrIq3RAJWw3m/UGxli/aKqGEMkeo1N1rhKtYHQRXj/kkaOIZxhOzTmFq98=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by SA1PR12MB8744.namprd12.prod.outlook.com (2603:10b6:806:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 15:34:30 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::dd) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:23 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:21 -0500
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
Subject: [PATCH v8 net-next 4/9] net: ethtool: let the core choose RSS context IDs
Date: Thu, 27 Jun 2024 16:33:49 +0100
Message-ID: <45f1fe61df2163c091ec394c9f52000c8b16cc3b.1719502240.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|SA1PR12MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 4178ef9c-e94a-429e-ec5d-08dc96bea2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W486YrDHgk4Kj+vJQnh/sFh196UCYHIOUr7EW04x5ZqR6ZW3Bi1ORR7maOPI?=
 =?us-ascii?Q?Oged32xLY4EeCc3PssYddJI8iWXobZzfNLCXUSL50JcIRP2EeOb00GRYtaiB?=
 =?us-ascii?Q?W81P7M+iJ3C5R6t6Mf5RZQ4Bx5OxkVVPgBHJ4ymMlsi8SkXt0f6PPL4ouOpg?=
 =?us-ascii?Q?emMYxdcwaBP6xIyDEoN22Ja5T3NHVVieIl0yDT5m0CWH1xadMpb/qx2vSUTp?=
 =?us-ascii?Q?JMtYTae8TFrmX5vLn14Gq/m1Ezp/+CjpN/gHDYSCSPk+e6NYietIav7Wg9Sx?=
 =?us-ascii?Q?198Zat04SXNoQ2VzyhzwEgZClMnfcbwOobHR9rBqQtUu816sbFSz+nRTzzoM?=
 =?us-ascii?Q?/YdUBpYW1AuAHUxk+UyJQZCnkl6Jp2fGcoFHKkPnKtGQxGbupdIdjj0Rkdon?=
 =?us-ascii?Q?E5ve+3PwuHCESciFDJFQpUyxM995HiVRSKDSr1DIFmbnsGAExoNDBCKmejHI?=
 =?us-ascii?Q?zCntxF6J8ZE8Ran7tBuYN7MqayEpJsr/NDwCmHUuRjqSMPeYb2XweG62/8AU?=
 =?us-ascii?Q?xr2LHnrbu/HYP14Sc+ixz7EzMh5QM9u4DpdB1fy9zuFhBQqevApBKlMIU+Xt?=
 =?us-ascii?Q?6mxupGqU0oDG0OA6qYKIqoyMSTTWh52vCpsjfTwCzfKOZSubKgQCYMHfilu6?=
 =?us-ascii?Q?IKCPEYvAmfdjGjbjQxr9BAYqavMkZWBOeA9Zu8cekurywXVw8C6wcqKLra+E?=
 =?us-ascii?Q?KIbLDYirDS15BuTP/pxcDLlIyHk622PwugtBih42rjNvd+mRjk3puPYiga8b?=
 =?us-ascii?Q?m+7tcBr8Rrs/uIk5i7nc9WfD4qwR4cxsN/AlUsvpY6Yr3BOnvzXRfJOJ2O8q?=
 =?us-ascii?Q?EVRGa7Sen/+tzDYLEyLKjGWEWexIAIv6lHjORpwWSJMxkUCDIa7oFz0mSkje?=
 =?us-ascii?Q?UvEfrbSJcc26JaQs+b+lTsOh8Fs8m4Nrz1Pyueat6LSswfZ6ec6H7eh1NLxB?=
 =?us-ascii?Q?YdK4TZWWkV3rJtBJe94Gcbm6G7oeJvlmZUnEf5cX6u/9hQ4t4bXyri+UyC/s?=
 =?us-ascii?Q?8qE0Lh1AICHE86kkVGri5EwHUBhOoPaY5t9pFZpVhUi5JuDos8In38yVmsTg?=
 =?us-ascii?Q?mHmJwb8JSbRJEjOKDsQ2Wd4RhiBSNBynfNJkgSQpDqmouXzC2N0dsrfSmPcg?=
 =?us-ascii?Q?nNASaeV4SD6rIrVm77f+HFkI09f6WgO3YWtULK18Wreszi+gzOHozQoF4+lA?=
 =?us-ascii?Q?wKLbPok9eBeVwSaOR3iOkPcDAcoJPLfEkpmYDY8T1eBHgbMfMXcj6ArpHKKZ?=
 =?us-ascii?Q?zYfQSKZWUZYvFbc1WLaz9Shw1yzyv+dU7mP05TiEA2uEXgnvhJziCeUefLYk?=
 =?us-ascii?Q?sO3VtAo4ZlLxeXWlq9ep22JXzZugmmEJNvSWhj4yiSK2WzKkUprvC1QtrNbu?=
 =?us-ascii?Q?jn2SCrmH7/1J8ZSnXWytpihc0pjr/qo+wCwIpoL8IQcM400xdxNpiK0lcORM?=
 =?us-ascii?Q?ftoeFc7UUEBbhKBONaU2AR6VA6hM/qHx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:30.0249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178ef9c-e94a-429e-ec5d-08dc96bea2f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8744

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
index 8fa2f8bd474b..197511c91836 100644
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
index e83e75c59343..be4342bd3603 100644
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

