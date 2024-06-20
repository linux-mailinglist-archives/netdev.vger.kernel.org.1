Return-Path: <netdev+bounces-105119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AFA90FC48
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF4D1F22456
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A50538385;
	Thu, 20 Jun 2024 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L1VRZYi6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644A2744C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862490; cv=fail; b=pF/y4WTc2drylkHt75iBF+nUlHgD3Ve/kb9nv98pO4DiwKIbI58nmSfNu+F2F8GKMFXNm6VuDCNdNyibxXineOAJvxTF0OIwQ6A33bSSZxsI0PuLf+Jf+ztgLpoOdgVxVzCn1cN6SE+JOvfIS1HUIpfbaUUavsta8pDKX/oKoGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862490; c=relaxed/simple;
	bh=04/8VdElfh/OP7lEr3Z+8gjT/sPVjDNZ3DKcP/7Cz4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seVwKlaLLAQhqlMFQLCWwSfbgHX8o0q/nfjcU2gYYtEKQ5WvU9VPSD72qvvJ0+Auov6w0oJ/1AvWTjZ6F8jVtMn0CaZFArix9VZPDbsPJACicmDP2hJOzKvxU5t3JYj6BCjCzjCHvkM2tegU5eKcnrUsRDwvdjb8tPODqfqniRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L1VRZYi6; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEOVqal438uOzPe75sQhHNNbEYifzzKQ01czecJ4t4dVENiD1PhamPxU9dI43IIVvZ3w00cYWaTu8HswjzlQEsDdCZLrA57r/uQT2jw9WUCaXAzA1NKS5pICg+SGn7owgjWkmSHdQ/Nl2IvGsnZBNK/8/digZjoj1keR9vVz/i+6p3Wq1/rHLvpBShb83fWYJwGShymFZrLz6mwsc0SIYPaY6o8Go39uvl9hx+E6EFMST5cC6m/7Nz6lYpVU3+rFoEeiSczEzJyzfmT6EZO/pZxhVg90NidbTJak+wVSkZPpM2miMzBkYMJZtpxZylCqa16UX4jBko76sLqt/GdCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu7vYa/NQnI66g0JLALDTNwgr0ksJhsmD+2gfW08FMI=;
 b=SgdkzSEv0v4NvEO6KUwr2Ddm4C4oyvhFnlpF3qe+EGcb6EpgquyPgLP0twdBJe+pRAiuRuaETkcyqgQVb7Qaa9XUm4b8h2JBgmC/wH+vulwSFh5NoCKpZtuImU5MkVTxXGmOSrANs6ufuJ7sUVNObOHtzItV8ysF/6Ud3h01w0prOCf6mw7n9TJMPCXTMPkNJ6wqg4v7FPiNRg37FCi6QzqaJK03Di5VL8kKq+wZIq/zXWB1nE0n+ga9sAWVf3/doYjhhjkpqd4lw+jWR8dbLBmQee/EAwvVvFJNosjFtZof2nxefNc214FMwcEQmP93RWkNuST2bcws7rWwtjhDQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu7vYa/NQnI66g0JLALDTNwgr0ksJhsmD+2gfW08FMI=;
 b=L1VRZYi6Cv13S4sHWaZ8hEkctPYFSP2ONjIlKA5lFzsAY3+/78c0A8TCZUvXJZ3pryImWtgJ82dwnpmTk4ESc+RbFCCmLrfUrCgC0iHZFmV+CTlawVqMCCQoP+wIq2bd0o6ieOmT8XDkQgwmJqNllHv2AJ9aFgASnl4VY/wRFgM=
Received: from CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 05:48:05 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::d8) by CH2PR20CA0030.outlook.office365.com
 (2603:10b6:610:58::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Thu, 20 Jun 2024 05:48:05 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:04 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:02 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 2/9] net: ethtool: attach an XArray of custom RSS contexts to a netdevice
Date: Thu, 20 Jun 2024 06:47:05 +0100
Message-ID: <c335bd6860c2e341de6eac18a477425a7c7cdb3f.1718862050.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: 123daa88-a02f-459a-f5ab-08dc90ec8e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|36860700010|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1Mbz0H3fOceFoi8rPGPehDMRlfrrhrXoRZEi6DB0cBReW2RlqGiw6q9hMzx?=
 =?us-ascii?Q?H5i0oq5911Vkxsn8vmbgeaXPZXr4F1ytM1didzBd5h/ENbDYKrxgDyrD5KrT?=
 =?us-ascii?Q?C6KisFTrjKeP5mBIo6HyqmeRaTOnYJqnfRtbli9b03vHtsRp7caDmrHdknkP?=
 =?us-ascii?Q?4akWzQpx/RSlkXmV29tnR7Ov76uDlj0WF4G9O0L0tmD9h3eHUVVd//SBQ/8l?=
 =?us-ascii?Q?DocwR6fg5mH/4/+E3sMzmw8p250G2y2mLQBM+Cfg0DijTfK3U7snI/Xgmdtu?=
 =?us-ascii?Q?diib5v/NtzlH/hTln5BMaUg2hvUalXlSuw7V6htxmalI4o69gT/Xm9pu1ykN?=
 =?us-ascii?Q?Zfhqx5AjtUr0NnxYjAXQ6Xd8jM2l0F/bFRbcGywBXAgNHVex43CzLBh3bHoH?=
 =?us-ascii?Q?opoUNgiW+Zd6DQRzdsqZ+oLXCt5k0WhRh9jf+Z/+78d+25/93sse5+r1UJQU?=
 =?us-ascii?Q?VpX5rzwPJMZNxDnS2I2bQGt655Xs+wLFgkAkPt/OF38+WoRR8b2WyPzvTv7c?=
 =?us-ascii?Q?T/Zfic4GZyEKafybSUvRf2hn3Z+v+Lh+gaekKOoVL6K1+7cUCu3vrZuSCqP3?=
 =?us-ascii?Q?jRZTQCbVZqheOFejofAjnyBdxPkqpnahyXIOHyQOcBFyx+h5sw46GQFWBxod?=
 =?us-ascii?Q?evcjND3boZdDCUGlOMBUUYyOJTyE6LUmRY7Qf3fHbpEYWsL1MTH+/pMpmLoP?=
 =?us-ascii?Q?A0eM6ZqEphfzK1v2SZrhYBr5Y243s5fFvDlMerYqJrIi3rJqwNmS5duF+BKA?=
 =?us-ascii?Q?xcRO+3ITYYnbpOibHbUW5XY05NiXq/b6Rzst4HQy6Unuss8dUEcMzl1/w+lT?=
 =?us-ascii?Q?C/X4cCeLhSToT3Hea1J/XoNyDcc1G+q9yQiJd6yDC6RzUXkLB4lTYR2Gvj7L?=
 =?us-ascii?Q?0aXwIyaAy0PpZnF8OROKFqMn8COhlzscyeExXupi5HU5fb678rM7mDoQVOpy?=
 =?us-ascii?Q?e94qKoo0S1v0E2XQ5axQmpPq5VDFpw+hrFiiWuoxVeMnppQM8g+Af7njbnYi?=
 =?us-ascii?Q?3o5jgMAObT0IS1Qr+k5uLDlBkSCDYiiyGk16l8I+hU76kOfNeWBbTIhcs1qC?=
 =?us-ascii?Q?L+N+WmvYVeueE1TWN/Yv/jjTuoYnaCbHjnKTN/fQFoujaVbcj8zPY0IGOGgv?=
 =?us-ascii?Q?E8E2QuQId8tZvJqwcr9TNDk7YKYLgWnpimDLdJivpNsPm50OfDX+DuA8pPjd?=
 =?us-ascii?Q?sGtQMBtkF6p+Pr8mtGAg+uirRcVUhDW1YhAdqCvso1Z3FLxSEyU3z+zih3G5?=
 =?us-ascii?Q?Fm8fJhrQpx0pnbYcrFVmONCrnp5B56mnL86txADvJXjlIY0uFj8ApMIvOyco?=
 =?us-ascii?Q?KPNr/QavQ02kj7M98d0F5Z3nP3sHqe2kXxqIJMnGotpvrTUP/USKmH/rq2D8?=
 =?us-ascii?Q?jfejYbYTtoOEKXlJcMFKJzQ1NgA4mW++6psDmnQPPNjxsEuLsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(36860700010)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:05.1806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 123daa88-a02f-459a-f5ab-08dc90ec8e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238

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
index 29351bbea803..78465b69dc68 100644
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

