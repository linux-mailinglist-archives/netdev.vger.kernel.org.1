Return-Path: <netdev+bounces-107371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AAF91ABBD
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCAF5B2D13C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0173F199231;
	Thu, 27 Jun 2024 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sy0ha/aD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA951990AE
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502472; cv=fail; b=BU52rHZbMBjdN42E/p8H0l7dagndgx8NKsn475H4vk3lkPuDLFW6qNmrG7p1tanZQM/kVtN/a6DtFXhySOWvPiFgDnUze8ccn6DGpujRBWaCnDuNVbJabftEWW+BDt589AGbyMTFzMFeoAZUlHeFN4iIyMR47w4skT7XJ2vV02I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502472; c=relaxed/simple;
	bh=HtajjgVbXA9f95EaBcGGdQ7at3eyStlGWNL7AScE+h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mDYFeunmScQp4W7/96GFudtp2WB7TywKS/XopZ23ouB8i73ixINOa1DCPb2E7FdNsNthRD4d0N3uTtl4x1+73Pq8XDYCOnE8bpGgczFSXOkpTpxubwbCS+wmLPRPZSdBLnrysgkEgXH/ue2zKJpjnTDFXincBo4pANuWW1179Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sy0ha/aD; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpVxxdrZjVmZh4VjR8u4lbkJTXZwm4RofHMWu7B0TMb0nJ8yJrp1m2ip4n8RKc9qvG5mXvEv2n4QdYg2I/LcpESEXAFoqMYDDyFezv518NtBPu2ve5SifqxNc1Ndo6eNyUbsbosn/sbVDYUjmi32OEk5bV1pdbyTVbcxWxcKm/693dWn4Qcrm/gSAMIzdK3biD8UK4Bw+7+sXyWhiq0bi0c1RMQUKxUjiXO4DU+Nd/jVy4eiMUvyxydx3pMvhndqh3jVguL8rNi9uhj93B5vTDkJagIer2BgD/uBaq4dYpH7RDBpSmG/kmZiVK734dQkDat+/3tQ/tY78MzJyV9z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69vJdV9vBNzhZW3WaKlAQmWN1g3DblU9B2k1DB2R66U=;
 b=WcwWK+LPDs8PhNGT0CFiyZvPpHWu04ApfeDuescwhbmkR+yPfd7FczCn0qyOVDkMOPJFJ3k6IBSqgCRyCoPz9iChG8ufiNs6v2RNTSupfvjpPLTW+8V+DibTkRKt0SO25toZDP2Fdeh95dkxb7934pXHIEjpUTLfCCNgnY7InZ9YV3w4RuPovplbinus+rGTKG621HdchQbL5IOqb3aygcdamjuxP7Rda2VO9eqbgey4n2T4un1Vz/VXaUuAP9MZN3rTUP1odt4KnyXmR/lz/61M9ej5aJJiyuHIY9yMmuznwiBxpKBGClzuz6PEXjbZ4QabtZXOIBEmhHVeL/YboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69vJdV9vBNzhZW3WaKlAQmWN1g3DblU9B2k1DB2R66U=;
 b=sy0ha/aDoUTjGmYw3UkeU4u1yVDxWYABx9zAmK6VteBOePMbXqkblp+Sk3Fx3vfkJgBHHgAge9IVCBiFkPrjMGQ2q48fVZJM4HBNYxZBMI7dTDGWTx0Y2lQQXSN66HNVMSTlYW76i9jll0Hs60kN0Y1Y37S4/4IfXPUJJm6Xsrs=
Received: from MW4PR03CA0016.namprd03.prod.outlook.com (2603:10b6:303:8f::21)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25; Thu, 27 Jun
 2024 15:34:22 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::c3) by MW4PR03CA0016.outlook.office365.com
 (2603:10b6:303:8f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:18 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:18 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:15 -0500
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
Subject: [PATCH v8 net-next 2/9] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
Date: Thu, 27 Jun 2024 16:33:47 +0100
Message-ID: <cbd1c402cec38f2e03124f2ab65b4ae4e08bd90d.1719502240.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f3b76f6-516f-4921-43dc-08dc96be9c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L7Pyg0oriqQGMkPUqUXcEjQ26oA2tsaAT16M7X9cSjtDBMvw71FBizg5eopT?=
 =?us-ascii?Q?qr1EovAoRZ8d6WwwCKaCTrp1p+lFxc4fGqSChd+ZqE6bvJvftb4jpPKic1HD?=
 =?us-ascii?Q?SrTCbrEyK6kq54qPL58t5o+m2miWJOUpKSv90OL7m1yz1WfhlYjXkGQ016Ou?=
 =?us-ascii?Q?k05pGyNYIHAeI4DxmLmkOil2lpdQR2K7Ojr50JN5C9U6gjFy/OPwiAX8iQUX?=
 =?us-ascii?Q?I6/JCLx6LR75ZtKUMXvEqkQ0PZf5tQWxh4BzVjHvOO62EmOax/hzVEJLsYZw?=
 =?us-ascii?Q?lbtLlcU5TRGQfDawqbIMwP2r2vVCd/hRfEU+RO/YjBm5zJVkM0iQcTr36QEL?=
 =?us-ascii?Q?LU1h357e7g0/PMntMn84++XYWKhNNINqna44Cqj3VDTLraEWjIb/sbKGJX5O?=
 =?us-ascii?Q?oBpVAQvrMr8qbDP5DSt/Ncy7dII7ix+iZUsa9/uGLspQiaLufayqQ1zm+xpw?=
 =?us-ascii?Q?8Guye5cYJoR9cBAd0UCfW4sJY930AiUcIgkcUXv0JOGn131dqPTXVkdQYWIM?=
 =?us-ascii?Q?vK3TzRsDv90/mgL/cr2Y9J4ap4XcVpNiC1KjN9wxBex0Po8at/F8GxuiaN9l?=
 =?us-ascii?Q?s6UwYnDDSri8RmK4qmOagDELQQY8EHchEfTx1Zp7wb88J+CKBC7MTancoouq?=
 =?us-ascii?Q?lfY0wcATW/rVKNjzvrYcK89OwO/tX3dULbc6NrR4m7U6xIy6EJm9f04uAjPm?=
 =?us-ascii?Q?NiUsVpQZHWk3WiqUwWGmDwSKPe5t3USh1jBR05jxs/A9uvpn/+STX+iF3Jpn?=
 =?us-ascii?Q?1yRNau+M8IpwVWp2VzKTXnUEDa6umuvlKLL1uEVB3zNTuWZo01Dude72Xwvg?=
 =?us-ascii?Q?T5kibuiovsjn9BwAF1OnGhTjmStW0ABBjxb6zKqxGwf2xAnlgoFS3zGaIbdX?=
 =?us-ascii?Q?jkos+SduQmu2cVpoZjveY/24QfGG1Y9L2y32PCodJGU3L+Y4CWoq6dDOqNkX?=
 =?us-ascii?Q?gP29/vRfmfdT1voXCfAoqqprbnlqgJrLi48UXYVtIoUnASChdPTl7DnQH2g+?=
 =?us-ascii?Q?BpV9m0ujhevMFzpOFKoE71KXoDs6BdnssvYh19pJsQ7nGUZsDGqEvtiuHIwQ?=
 =?us-ascii?Q?fCQP8zL3zSPGCsmbMg5WlAaxexMjxoZSx1MZ3wCDtIH2NMYfKlqu1S0JkxPO?=
 =?us-ascii?Q?/XHNbcDvdWRKec9HbNIq4gciZ9kzWt891uWBNbAdU0sdFKFETV4rcIjQH3bZ?=
 =?us-ascii?Q?T8ru02W4UV8Yn9M8XMlsOf7UXn+yd+2hBvt8ROExBgr0VJfb/fkrR4NAnWCj?=
 =?us-ascii?Q?tfcTfHgWJ9SOR15PebuEIUtC4EqL4Qks3Jns5NwQFp8nnl+cacz3Pv7Ww+z5?=
 =?us-ascii?Q?BPHSkXwACHYiq3Phw7R99iE0k/TYzkF+X4owYhbsgOL8HyflD0JB8UwwNWUL?=
 =?us-ascii?Q?nByQM/O/Q5SDllaV9tjNOGNTTOcE0nc5ngaCLNM/caE79KKsN84SK2m9Mp5O?=
 =?us-ascii?Q?l6u+82bUDpEqXBdAjwSeOG3uJ22Ht2NL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:19.3513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3b76f6-516f-4921-43dc-08dc96be9c9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

From: Edward Cree <ecree.xilinx@gmail.com>

Each context stores the RXFH settings (indir, key, and hfunc) as well
 as optionally some driver private data.
Delete any still-existing contexts at netdev unregister time.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 42 +++++++++++++++++++++++++++++++++++++++++
 net/core/dev.c          | 27 ++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 8cd6b3c993f1..13c9c819de58 100644
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
+ * @indir_configured: indir has been specified (at create time or subsequently)
+ * @key_configured: hkey has been specified (at create time or subsequently)
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
index a7f71a9c3aba..e83e75c59343 100644
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
 
@@ -11184,6 +11187,28 @@ void synchronize_net(void)
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
+		dev->ethtool_ops->set_rxfh(dev, &rxfh, NULL);
+		kfree(ctx);
+	}
+	xa_destroy(&dev->ethtool->rss_ctx);
+}
+
 /**
  *	unregister_netdevice_queue - remove device from the kernel
  *	@dev: device
@@ -11287,6 +11312,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		netdev_name_node_alt_flush(dev);
 		netdev_name_node_free(dev->name_node);
 
+		netdev_rss_contexts_free(dev);
+
 		call_netdevice_notifiers(NETDEV_PRE_UNINIT, dev);
 
 		if (dev->netdev_ops->ndo_uninit)

