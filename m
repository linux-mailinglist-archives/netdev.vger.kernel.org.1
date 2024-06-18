Return-Path: <netdev+bounces-104673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 770CA90DF35
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048D71F2364B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FE1741EE;
	Tue, 18 Jun 2024 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IOgZSOtZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8728DD0
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750728; cv=fail; b=Bbw0vPIvFzTvLUXzBTczWR41/fYDOVG4V4CKIXJRoED9iO0lPI6O0QsAiuTD7KSaF1hSCVuECRoFN938LntLX1wlW5TWi5AJfXAnhrolvFvs7MVV98cKaXHbg8+pItO7rocClPvbgtvi7EeZ/tPBY0gf2BTX8S6qfOMnYeqVkZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750728; c=relaxed/simple;
	bh=juuiHLs2BHljX700KBXmd4jGsVmi7/mm37Y5HR2Hl+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MvOYFADJvVokR9KETuBQd5ttkGogkoJPExDIDkPOs6R0O0Y0v2qm486IkjmKgd7yW2lBgcmfMntmXaNDQBUGl5nTezTIkRoCA/841fhoPBIEpxDJHScw/5n00MfakpOiu1EAji4ZNzZ7Xe6Le1M931/viBrveTvjMlzZQk1M/As=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IOgZSOtZ; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihzfHUYJpKBbE0TW0MqEQP1YUD0AWBawYfaB//4ZN1aRsTUVfJ+C1F3rXnqjdXtg16cR8NwjZomip2iYZwjzFpF1qroG2sHx/F4m86ZQGo0pu0DFrqRebmLKotQPB+QmearjFYfGZ/61c3aOeU/uyUO41D/Zmy6APHPXzJEKm2jBJzurGO7HmxhfaBWHBdgGdeD7rO/GrchRsbZoeIOalfduEkug3tsaVJAqAlTTovLrYZWdNwpQAuATPU00JKE6X4AiZZDbXa6cwJTyS/p45B8KvBZpY7s9W4IXfZKTAmUkOKoJDWQ4V07e++cJMsIaX7NQ5JnvuDMwbeQsQBxb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7PxDsoehu9MdvHtGqyyASPJQFjINpvSHOaXzMmniJQ=;
 b=W6rXeme9O+hzQzuMstSkEKcWBK8s6zAMaYQG2+1MFNpXbrlmShMDAtQob9FbZwMNz194aooz+aWpaQcVvkrf/JidlaqHZboLOiWARJfPwlI9Z+sqiccK6/8lTdDHJyXz9pqLVKBf0fbENAhTwymFxKn0/NvrTofefbJzRxHjGLHfraTNZIsZlyrOMfmzXc5brZezV5pIwDKF4knC5ZtCZrKOWoviw17SVGUHUWgDBpgBtyZOS8cobM2MrNONWHf/IxYe7Hs7IbHP21H/raDhj1sl/C/tsoCruWuqblEgAYTxi59ihCmTVs7LHJqXgBd20r0NKWaL9sClpx5NWTnOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7PxDsoehu9MdvHtGqyyASPJQFjINpvSHOaXzMmniJQ=;
 b=IOgZSOtZ26Y9HNwunAGiIoTMDMcoq7jkZ+ahieQTRZQ+zOb5RVPGEfNv4ignuhwbI1xbQ2yYl/nyxm+en1ZQMck/0dQIinYnO7ejCbGRsUZMtATJII1PdptyRuJcLPsY352JCzWmkKeZx63SnOV0XFUFuLGvtN2SRxj2yqFi2Dg=
Received: from BLAPR03CA0090.namprd03.prod.outlook.com (2603:10b6:208:329::35)
 by DS0PR12MB8502.namprd12.prod.outlook.com (2603:10b6:8:15b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 22:45:23 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::7) by BLAPR03CA0090.outlook.office365.com
 (2603:10b6:208:329::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:19 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:16 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 2/7] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
Date: Tue, 18 Jun 2024 23:44:22 +0100
Message-ID: <9976837c86b656c1f2bea7753362f4770530f49d.1718750587.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS0PR12MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 895a5c78-ff7c-4d59-5b68-08dc8fe856f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4sJb23HhXwUm4IF6pW7r8HiF+gLD7COzZdL/36VsgsJPqEkSQarivxGAZOXM?=
 =?us-ascii?Q?kYKzWKUu7YIb74ncRp943OEbuSouMvd5vBYbk013NTkNq2iDzzDj+S949ST2?=
 =?us-ascii?Q?iHDfBQnrcJVlnm+Tr2sVOTIq6+/COe0GYcxD0bG3TScijH9Q47OsrpopSr2u?=
 =?us-ascii?Q?L4sturYPBMd759MuXAwHEeiYdFvjKTaovsBRm1HQbNoUlMfnfBaLCr0ENQm9?=
 =?us-ascii?Q?RVZZhXh42FZYANPjd/Lj88FMMffqZjVk+RIKeNPX7+wxXe/Qt0qu/gssxOu1?=
 =?us-ascii?Q?XgqggIo9kA0Zs/WVNvcJ3WNGfNOJzh6H78cvX63PF0xvqH+gT195CKMMBagQ?=
 =?us-ascii?Q?nJeiAvBJ8IyHWZDsjRsaagcoZYlPvmGBDn9dHS2FcSvV9r5kTLAVyvslA/vx?=
 =?us-ascii?Q?TaD2s8CUClKVsmKmdRfR5oP1aCXDT8VfpV6kylllbMCEdX0Vjzhmb5faZ8Fe?=
 =?us-ascii?Q?i30okGTfdnUSJBIBXDL8KGC1GuLTs+hEDfT1MV/Iqv3m3gbqtr8vOGKVcIOb?=
 =?us-ascii?Q?Lj/rR0d4fm/u6ypqPDIw++yOoDHQH3RXEvfWGvWPcYzCumSciEgrps7WU5SH?=
 =?us-ascii?Q?WT1irJXfEibGezOb5pyHxHK7RA+P2p9w/Lw3zOiUnOmDYhizlSZb0FEGvc91?=
 =?us-ascii?Q?t1AlT5Ku2MThwjVOa9FPKjWsqLGhnj04sVd0RZZ+5yGKSa93QlFDuqGkdXr2?=
 =?us-ascii?Q?MjGW1CcpNu40P0s/gLX+s3HSSFOcaEGeJiXKX5mISpzfrEiho9mA5ltT8nuI?=
 =?us-ascii?Q?lU1H5qSt4UCeYMXSKmmkZ626SvKLu9ZT74tm1n/1d0U/Q78VZOaGRCfaZhvs?=
 =?us-ascii?Q?eqx2+QqDQSYFYfbDAWSRfWAxBUFaeVbCEemg/j6XKynHDfDNmvz5Qep9Xjtc?=
 =?us-ascii?Q?Rm+Uh/ArZzqly0Noovp8bqG3tZ4laQ2872M4lTa3n8HY6CjqMFf0zSPQ//TX?=
 =?us-ascii?Q?6uWwwJ9LjB1HmO1D7aE6eP2pbsbJlVVS0itsaCVrbzfO7/8GYv6jDJJ3Ij90?=
 =?us-ascii?Q?87TLNYxZpmHIZPKZQ69e8cZLlq5g3BBFnNCA7Tc1mFTvypuUzlOner6Nh+mc?=
 =?us-ascii?Q?CM6y1hOOy2hPW9Ehs0PzyvZuzEYqUKh1lDQo8meR86jlm7O83cuts7SeEbjV?=
 =?us-ascii?Q?MoBD/ZPreOrqhYcetpd8F0vrsgwJza1uiOFXJEDkd1+pybONN4rufPqm15wd?=
 =?us-ascii?Q?4MjY842Mr6PqT6kmabVQBskwCf1RJl6dcVjBKUZ616BBqqTPkdUKqGUkHJBj?=
 =?us-ascii?Q?F+s831Itk/FyV+2duNjrY9dfaiZGm8V93GHBHZ5PW27F2IauvfwJ7UnfCiho?=
 =?us-ascii?Q?cMXM86I2LqTk48Fip8OffBQII8a3yfx4p+kB/aeU90dCG8ZmY6Bd6uVLMVqP?=
 =?us-ascii?Q?O0mvObiqTF9b3094D2eE6qcByLelzEkdDvCmPeZigCM8tO6UeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(7416011)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:23.3156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 895a5c78-ff7c-4d59-5b68-08dc8fe856f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8502

From: Edward Cree <ecree.xilinx@gmail.com>

Each context stores the RXFH settings (indir, key, and hfunc) as well
 as optionally some driver private data.
Delete any still-existing contexts at netdev unregister time.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 42 +++++++++++++++++++++++++++++++++++++++++
 net/core/dev.c          | 31 ++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8cd6b3c993f1..a68b83a6d61f 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -159,6 +159,46 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
 	return index % n_rx_rings;
 }
 
+/**
+ * struct ethtool_rxfh_context - a custom RSS context configuration
+ * @indir_size: Number of u32 entries in indirection table
+ * @key_size: Size of hash key, in bytes
+ * @priv_size: Size of driver private data, in bytes
+ * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
+ * @input_xfrm: Defines how the input data is transformed. Valid values are one
+ *	of %RXH_XFRM_*.
+ * @indir_no_change: indir was not specified at create time
+ * @key_no_change: hkey was not specified at create time
+ */
+struct ethtool_rxfh_context {
+	u32 indir_size;
+	u32 key_size;
+	u16 priv_size;
+	u8 hfunc;
+	u8 input_xfrm;
+	u8 indir_configured:1;
+	u8 key_configured:1;
+	/* private: driver private data, indirection table, and hash key are
+	 * stored sequentially in @data area.  Use below helpers to access.
+	 */
+	u8 data[] __aligned(sizeof(void *));
+};
+
+static inline void *ethtool_rxfh_context_priv(struct ethtool_rxfh_context *ctx)
+{
+	return ctx->data;
+}
+
+static inline u32 *ethtool_rxfh_context_indir(struct ethtool_rxfh_context *ctx)
+{
+	return (u32 *)(ctx->data + ALIGN(ctx->priv_size, sizeof(u32)));
+}
+
+static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
+{
+	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
+}
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
@@ -1000,9 +1040,11 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 
 /**
  * struct ethtool_netdev_state - per-netdevice state for ethtool features
+ * @rss_ctx:		XArray of custom RSS contexts
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
+	struct xarray		rss_ctx;
 	unsigned		wol_enabled:1;
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 29351bbea803..cc85baa3624b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10285,6 +10285,9 @@ int register_netdevice(struct net_device *dev)
 	if (ret)
 		return ret;
 
+	/* rss ctx ID 0 is reserved for the default context, start from 1 */
+	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
+
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
 
@@ -11184,6 +11187,32 @@ void synchronize_net(void)
 }
 EXPORT_SYMBOL(synchronize_net);
 
+static void netdev_rss_contexts_free(struct net_device *dev)
+{
+	struct ethtool_rxfh_context *ctx;
+	unsigned long context;
+
+	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
+		struct ethtool_rxfh_param rxfh;
+
+		rxfh.indir = ethtool_rxfh_context_indir(ctx);
+		rxfh.key = ethtool_rxfh_context_key(ctx);
+		rxfh.hfunc = ctx->hfunc;
+		rxfh.input_xfrm = ctx->input_xfrm;
+		rxfh.rss_context = context;
+		rxfh.rss_delete = true;
+
+		xa_erase(&dev->ethtool->rss_ctx, context);
+		if (dev->ethtool_ops->cap_rss_ctx_supported)
+			dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
+		else /* can't happen */
+			pr_warn_once("No callback to remove RSS context from %s\n",
+				     netdev_name(dev));
+		kfree(ctx);
+	}
+	xa_destroy(&dev->ethtool->rss_ctx);
+}
+
 /**
  *	unregister_netdevice_queue - remove device from the kernel
  *	@dev: device
@@ -11287,6 +11316,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
+		netdev_rss_contexts_free(dev);
+
 		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 
 		if (dev->netdev_ops->ndo_uninit)

