Return-Path: <netdev+bounces-106149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E2914FA7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CCB1C21DBD
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3916E14290C;
	Mon, 24 Jun 2024 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bcldYFWv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBBB13D62B
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238384; cv=fail; b=Al1niCMFnwa3M7WwGRoEbxHVOURc2Lg+InyR068Ue3OsOtAueXnVwRigAQyLiGUURVRkJG2OrbXqvq/XUoiu/pq2fOoIvN9HfwlmzYICu1SF6a0mnjUwo68nR9rTl0cxu4YOGTOGbv7SItXFwNpZI3bmTViQhSY7TgbIH1EU62Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238384; c=relaxed/simple;
	bh=re11GwhWl+9kqmFOX0VQz+hOWXZ2qJ6E/ywa2EsoebM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ro6iynXRl2i6LcqQ8Fw5aIVYk6J9VE+qd7+/0k0YzcW1umBgiyrmU2elHGAM3DPck9YleamMd5DbeOwFR6uPH0KkfDcE5mlTwPpJCvUkrO66dQRM1l+a1US0DdjJdKQD5cki+ZtC9eUqvLYW5Mnymo/0mwDHiujGnt7MoZIoK40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bcldYFWv; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw9zx62X3XO5eB0aO6ff4gL01F/yU1LDXuTI3Q/vEYuUB9CQauCOI6aGNjNf0a9ALa58UhRFTI6eO6qBw9tS6HXY0lSJ1ZpOsnjTla2lMc26TWidxgEC1JhvchflAgr/FUNA1tpWpvmLqnORsr1/HHjTZLh3OQRIl0agnhlUjdgPdBtOoZAmhb5LeSFgIbOAyA8SXHGjkhIc5/RGfij2EpMSfz6IcvBsUS3AWCs0MNJStOb9rtoJwQanEgMEnzd8kLzCgY1KuIFZC8KapH+zmeB/gzu9EaIQkG0b/rgOgfEDQXzBrdmYo9APuMJPFJsoykIdgHaCA4wa9ZsVfYx20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRWFEhQCkKT3LSxuU5bvkHzJ7ZxW2e8P9I66axHafF0=;
 b=HP3k2M2v5K/sTBwohl+PRarA000fCrT3QFlNUZw3EjYXL1xQL8fYhE1GXJbHj6DKSHW/fMEoKHYNqvRGjfeaW/ulI7JjIK2GCB3qc6FNeLb3nuy0A3PrmzS3w179bat6xDiojczP45kx+qGcJpZCvfXcV9mt57yqyahS/SiQ/LnkcRFKArfmkCyYLDri3SKz+VSLQiqdU647jG88zu2sbkm4UkXjuSpEQQyae2YMqXyhAGVB/rkTltB4RjAP5mOhK7VafghJAVYvNrfE6gnn8dtnNVC7RnWikM4Fj0vd5i9a2PoT0z8hdM4ivqddZlIBoUR1nODBhsanjjxoQbgkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRWFEhQCkKT3LSxuU5bvkHzJ7ZxW2e8P9I66axHafF0=;
 b=bcldYFWvPkhuF6PVrTbxyVnN5Hv0IXAJQq04jsNYATJ0mjhyfJsvOkZeBvDw3mg2REyv/q/C1rOcdBTiBzvsElWLlm1mYSyknkCoKCKWavVw7qhI3Gchhs74zGaGx1S/CWabHF2UMXXQguTUq8MpuWv5hz9ENo3ts5fncD03U8Y=
Received: from BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:12:56 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::95) by BYAPR05CA0070.outlook.office365.com
 (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:12:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:55 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:52 -0500
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
Subject: [PATCH v7 net-next 4/9] net: ethtool: let the core choose RSS context IDs
Date: Mon, 24 Jun 2024 15:11:15 +0100
Message-ID: <7c79f47665a95da62223d4b7e6cd407e9132e329.1719237940.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DS0PR12MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: f04c43bc-e2ec-4bc0-38b2-08dc9457beaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|82310400023|7416011|36860700010|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U07uWA4SB2Cr/OmSivDRUKJ0OoIJTkyP9S4QYBpY+tGA6DvhsQBk1Xm6aMX6?=
 =?us-ascii?Q?R0zNkTCCCSBMpLJWBswQ/FxJRFa3IbD3dyyiDh1RTgdqIliwpJRsD3X//wkI?=
 =?us-ascii?Q?CFzeBaUlGOJzJKGKlommp5941aFztTW7FFr0bIRdxBUcUBsPY3BXUDJlDgHn?=
 =?us-ascii?Q?ksJ+dCJ5wNXZ+oChKD401PeNEBtAvvUfybDECK2d8sNYw3dK83gBQyLrTVlU?=
 =?us-ascii?Q?0HXqqJDqAAQ1XvtJn72XTmpnYfK+BuoRXOD6HU7PNKTGdC/NEX3WFlCF3ObN?=
 =?us-ascii?Q?AUJi/kMe9m6V314h14m6blhG3H/u4X00zxyBnCZgYdUwkqqGCPU8Jm3roFd6?=
 =?us-ascii?Q?Sot5nqbMk3zdKNRN9YsGbNMPBjAIde/ldZ5CdKv4zVpO44UxtICJOsYRkYDp?=
 =?us-ascii?Q?FFQGnWVQyy2ZG5VWUgOAOpv9coOjzW7AoUwRYWzLgaVmlotJJrdXohjcv6zH?=
 =?us-ascii?Q?9nFs/qi2Q23wXJY8ACA89EueVFjHYvN6MsDaExwsUWHLQAJe/QEi3xEyps7m?=
 =?us-ascii?Q?8irjq0Drb3duV7+yRf4JGVegAYlLBu5FqnUWkWpLj6hFIUk0ANFaDw29o+6E?=
 =?us-ascii?Q?x633Js0XM3b7POtjUdWXNZ8GnQrBITU1wUrHJRg5pRwk45J31W20JGQ4wfwX?=
 =?us-ascii?Q?/JX8GPYflWWRa2G3EB8GaVvonoddcsj4vwDllepMspOpV0skN7a0cGtXgSLz?=
 =?us-ascii?Q?mcOx5p1UKN2rGLD/lAiU18w2iCFb9pljSqRT30FxMdS/m7kCn2YZaWm5Po8d?=
 =?us-ascii?Q?NWBpFiD8WUaiWMKRo5kDg9OgYfIuKER+gkKjJkRMbgw9CocuHQWkD0/jb5uW?=
 =?us-ascii?Q?FyPFTP6wXLUYIti3Ll+iL+ncZts2uWl5RMdqbU+iTZtFxvPrHh2JKuNVAWGn?=
 =?us-ascii?Q?rG7AoWswRCFEm2uNTkO5Ia5SOZJSqZS1kiMtT3/zpGMq+cb/fGwPRiy3VGZP?=
 =?us-ascii?Q?FqOZ4A625Yl5U7waWNCgwquFiRC0uVSbLKznT201wwOuvglM6IctmbPx8c+o?=
 =?us-ascii?Q?xYkK065I8dPvkjVbK0axuh4M4GGbsFoItj0Nmit5H74iiwDbofFTJ62mQwpJ?=
 =?us-ascii?Q?9V59wspXXjRAx+bBylNPpsqdS5gqDnhDg7Je8JA4PVr+4/sy4J6I6fUzXAPQ?=
 =?us-ascii?Q?hCcwvDsnzkRrftYo4vSENAS75h/oJfxBTfdCtFFS82v1TLlfSUtz9Uqcp7As?=
 =?us-ascii?Q?YPHEQVLjgNzMEqR5l+YluWZlsI4U0IbbEkYz7elL5gD+DhM82RLDVNDopYz/?=
 =?us-ascii?Q?ScsRoxq8yQeC1XtDaaEGyjgsW3sSLwULnydWklS1rosLTZf79VAxMKEHAkDL?=
 =?us-ascii?Q?a+SbtYkH2f6yjbk/NHpgXtlqfqkHH66osCXS+/Tts30Sf0ykOEkFmgzgloFv?=
 =?us-ascii?Q?HW3L5MCLWbOvrvwbaK31oNg7AybgcBvwPvIq0RZsN3e6eddckw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(82310400023)(7416011)(36860700010)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:56.0097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04c43bc-e2ec-4bc0-38b2-08dc9457beaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

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

