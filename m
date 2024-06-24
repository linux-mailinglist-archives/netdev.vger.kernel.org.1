Return-Path: <netdev+bounces-106150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA47914FA8
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB31C22280
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3E142648;
	Mon, 24 Jun 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dJ5aCCDn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6FE1428F2
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238385; cv=fail; b=kja0qQb8hvvkimEQx+9ScxYcgB5YY4pYMtlTLjrhktL1nnUWVNUFf3Xbd1oPWt4mYHOWWmeFvMBMkh8g+E48SQxtnVOZV6YVSHkculgPibJyOJ3lTbVhmAifu4J6atreiINXxL9WM1wgYRDep1vDCa32km0VKtAwss6/Yf01wDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238385; c=relaxed/simple;
	bh=HtajjgVbXA9f95EaBcGGdQ7at3eyStlGWNL7AScE+h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okmzRJUkP+2picBtD3iESYdGDCBKH9PmBCmwFchH9+P0W77z+qPijkskj8Vo9aGUDYO/NuD1l5w/O6jiZ6oiUeok5Xfj2VmITstRWK7qPE4dE8dIky1ybWR+1UtaG55CRdGqtX3XufigaVGr+B/jyfE1xpcJT8PHjw+DrKDzwJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dJ5aCCDn; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHdtUMyxeXU6GGj+soneMI9duaJfjcoFCUt2wd2hgsYozlCj41agKX+iuzwqxw/jSA+HQBhhHyGDg5tgtRAJcbOoNyzEhoIG7XEnl12bQHDHwk4t7YRbwEne8IW1Kb1bXakWVmqL/cmtJEeJM3hSkgxNEuij82HvnghEvpkUXsdjalDxuJhwXs5filZPaWGAm5nSHKkw1gb0k8iIKTRGtgTekvTMhb/hL31dIRtehLbl3IN4XD0rJ51Ap/TRcjRkBRyI4F6QczQ3b5S60YVxwvAX1ekHf1+pSq9GL9hVrRZdLK9FwmX91xsoe9sCK5SAFGCqQL3tzfTIAkHJqGwu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69vJdV9vBNzhZW3WaKlAQmWN1g3DblU9B2k1DB2R66U=;
 b=YQErzkzrzLrrFPczoWWFRsFANCIFb6PBaWLrQiJy0zR03hybxRivPeaQqI9MuiSolrDzvdzPyhmKCHVlV0gYPeHLoFJj6pHQGRz2u5ySBnVcIauMo89CNBD/CnfwOuN6yhz9OLyH+Z7fM6Z/MN+ZwBUu4byz4C6wPfi7WpEe2OBeqMgPPwBzSY8Q90/m6T4KQ42T0Y6BrTyu6GzRYNaPT1tHiihczEZJ/qAY1Qa2gtj6OAa2+ynGXtA5esQKTvWlbeSwu/jht3W3Tu8IWOcq429UX2OlWw3kUcVAzJhaXbxOD8KTh5dK/XQP7CFTcZIlP69CQCjZPpTI7mnP8Y5Nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69vJdV9vBNzhZW3WaKlAQmWN1g3DblU9B2k1DB2R66U=;
 b=dJ5aCCDntUiDjv249mC1P8uN/zc1oP3WQrAMWjtyV+XllHqA3DgzhKHmalM67NeuGp9eUrfhROmwtq90Sj1BFRFZWoECjNbIfusHaeO/3wiOD7237UmF1984fnd2Cn2g3zPq5LYuCArlbaFtiheagpgChxfmbkr4/HgTVTEHP7k=
Received: from BL1PR13CA0230.namprd13.prod.outlook.com (2603:10b6:208:2bf::25)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 14:12:58 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:2bf:cafe::56) by BL1PR13CA0230.outlook.office365.com
 (2603:10b6:208:2bf::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.16 via Frontend
 Transport; Mon, 24 Jun 2024 14:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Mon, 24 Jun 2024 14:12:57 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:12:49 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:47 -0500
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
Subject: [PATCH v7 net-next 2/9] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
Date: Mon, 24 Jun 2024 15:11:13 +0100
Message-ID: <cbd1c402cec38f2e03124f2ab65b4ae4e08bd90d.1719237940.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 186c1bd5-f5c0-444f-a1fa-08dc9457bf9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hy4Q6kEftQuMQyk0vu0/hKQJH0S+bZSKSHziP40DcngUwQfsiicLZ12l2KS?=
 =?us-ascii?Q?7Km5Fqa1YlgTr+5vg0hJJXDRgc4zu1zf181e6QYmlI+m4LfubaTmI7wx1Mci?=
 =?us-ascii?Q?TZ0zwQVJbe6SNec1x38LHvJkNQMzNfB2eVTNzJlK+LzRE4R2y1CKg0wMkyo1?=
 =?us-ascii?Q?z+9Hk4ElvvCtbvBV6E60nZ8nxcHyEYFN+Lwfn8NryPCRnCz8uE6aVjGgI5sj?=
 =?us-ascii?Q?xj00hpQpr+PPzDlk8/5Oa5IkHyFGTCzUPr7J4ORHNzJRZYl5453r4wLjmxrl?=
 =?us-ascii?Q?ABbEaawOVdTAPYFb8SMOC0vz8k3hVsGg0NZuyihTlfvLKw1IdcDkVF8DMAIE?=
 =?us-ascii?Q?Ev8eyaKSb3Bdg1nESyUs6Ns2nRCzErzQ02U8YobJsgmPBFM8NhhKtDDkkpbx?=
 =?us-ascii?Q?CMJRnmMW1/D1Y+PhPzDbqb9BbC/WyRPFYpXy7ePEpK+xCawuAlsqdG78n0QP?=
 =?us-ascii?Q?PJIvep4liyaZkFyWPgy2jWOPdg16DErUY9BkftMjG9eNsHHVCVIIn+pQh/VS?=
 =?us-ascii?Q?lpKwcdlmCJQPILdcXRNcx5JAm0PF/2Wq8GhWWZL0xv7cUcsptmlQa9jp05LG?=
 =?us-ascii?Q?WxZBfg/0mnev1Nb9cu7/yG64RzRB/KHhe02gEafHjhhnD/jmNn2Y5xi4EdeP?=
 =?us-ascii?Q?xpBoIhSERsxhq9ukzWCJyI5ZLMado3M+BGkBviuRQrNV2qTQKpIcD2U9xP4f?=
 =?us-ascii?Q?x4XMfFTHhNNKTJHj7XJ3EXZEB7EIFLcpZdKI6Z3XfvpdBZYbKH6gPIRBXNk5?=
 =?us-ascii?Q?iaP65fDWqHkH8xogKD2T6AX8KF7X/aoYbSHwUoPS9yxX0ayqa4lyFfnRA+7N?=
 =?us-ascii?Q?HgbW+LNceCSSg9aFjZEztAR62WE+mIEokXNN09cykBmvoObdU/IfVXnbPaN3?=
 =?us-ascii?Q?podCXotbWhtsd0rJx2VOt7ufgqh+q+EnQXDYqaA7QFizgHJNsna9PVD7sIjB?=
 =?us-ascii?Q?uYc5i7pvkNX1WZ5kEVzodxtud0nrFQ43/JQnAA0Z/WU81UCpPvJ3OH8umg1u?=
 =?us-ascii?Q?ESSCxfVoDAnw4ElU77UCQck6eyPDEYjUIFnSaC2cGjqvp2qDCiokqOyTygdN?=
 =?us-ascii?Q?v7kUAAVpzbCROboBGVw+riZx+8apMhz2X7hnQN6NrtF3KHpwzNXusCyzoGr1?=
 =?us-ascii?Q?Nk1y1EFh5CV7IzxNEGHunedO0eQmpQk87EzNi+EywiBNP6FpPrcepHIKcZ+R?=
 =?us-ascii?Q?kEwfVXnZs0a+Sv95zVF9DAwSUh19M0RTDbOTa+eJ7UPc55aLag/7L0M4ZOHZ?=
 =?us-ascii?Q?wK7jygu1kaMrvTiw6bJPXp3sPmYCWB5LYIIFwhLvhexe/FyuQkNNK/qie0Oy?=
 =?us-ascii?Q?bt6k3lrTb69+znPAbzG8D3BhJaF68FcIcpjw4W2WZEf8p7gvh1V7qDwDNHsu?=
 =?us-ascii?Q?rs/CxNeiO0CyTGs87iEhB5d+gCPVP2K5IzyoFrCP9G3YSZ9HXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:12:57.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186c1bd5-f5c0-444f-a1fa-08dc9457bf9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

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

