Return-Path: <netdev+bounces-106151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97670914FA9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA21F23011
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF741428F2;
	Mon, 24 Jun 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m10Qt1xP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369513A894
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238387; cv=fail; b=gMM7HDCvv/RQpVAeElxAtFml7Tv5BQtTc+LBj86RfwGsKyPK2cl0aM+zldhjQWkfljUs1rBZRBKfevmUpP6Byw4ju/rRzsP4BuCU6AZBZLggmLhKhb2oBOxVaQODsxGIgYplHk4ZzdfvPC7CzlhJ5UdVi3lkyrqVJv93biLOO4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238387; c=relaxed/simple;
	bh=Q1KOiQ9JqnYIqXhgomLKn7hrewsbDmc3rbWaiILCWPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdinKD/FLrUdZ1vJRRwKQdMLenmDlQchNsH1gH5d9BTiExqGdkHtwmPpeJWv6v2ZUaGaGEE7PA2WgZv1r/REoEPfSmdgCBCr//HMejIvaC2a9ISAnbuRiLivJq3g++bpzwPy8y634SsT5fzyGhkH7ZsNkMZpWJwZsnIuuzqySJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m10Qt1xP; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXQSUKMA5bwL1sB5htNG5sbRPokXdDr/JXi8hJ6pDqbYP94KfUPL7w7egt/fQkm0DCylRPA8ZUaJ8itfl2KSg7eQP8FpjMnmOWGH5HlUyjrfMSE2iMSnstE2APxlRwHSCZ8g4uZ5hS+NckPoZE5MOoVIcwdCtm2Zj4fcIDx1dO58r9sY4hYkItu7Z9WakWqiJavGQcBjpr9Dm9O//7ZKcQ10Rm55MSV7HnsvptM8iBxZ8UZHwp1/mhQV2+d5fP+CTUe3sTNxNewwcXwrtVmW8IfWPRGIzK6mag8NDcDzgBqSNG/KntVhkXeL1TrFVwA4rv9E/urLapbFzNLv4Yu+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOni6E3hmL1Mz/VvbuB/Q6rJ4b4tBTi3Xq1swa07u7o=;
 b=hUmXTEhrnTw6idEwPNlFarF8A9WF53xz11vcVz6OgZOPnpkyRtH0ZAbkb2dVy8cRg8cYvNBtOjwaype0xdFGMmSCeIJbdJ9ZF02tjW9F/c7R2lVE/gJRRUwVrV7i2EAuHf0l9gja+zn76dqxnQHfGsIJhHbAhAfOV5HNLCQg4Lyh2lH/2QxZC96aOjrssJQnfotic2G+U6LO/U7lu2TVUR/15L3Md0JdXpNHA1Xbj9Dq75VsfFkCf6m4j1LTBgLCdXRxddf+gpQXu1PDe/VhtQM+Vm6tywgBs/bL0HoQci9K39XfdOaj1KdraEAF1q4y5tBz0GlvQs+gUksar7UiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOni6E3hmL1Mz/VvbuB/Q6rJ4b4tBTi3Xq1swa07u7o=;
 b=m10Qt1xPiHcCsPmnDGG0YaXfXEF/ijBwkJPkBtomMHwmmHi56nE74h6ZcX6J9cJaQ0wtyc2576asBYJ7AB9zqNeaTx6p7m7GRkBVvZPMWMcLgI6Q7JaWDx6zkOhrIwFcip8YnNihkLD4jWP+PfVHA0/RI4Tjt8KmYgBqstloE1k=
Received: from BYAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:a03:74::17)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 14:13:01 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::c1) by BYAPR05CA0040.outlook.office365.com
 (2603:10b6:a03:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Mon, 24 Jun 2024 14:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 14:13:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 09:13:00 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 24 Jun 2024 09:12:58 -0500
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
Subject: [PATCH v7 net-next 6/9] net: ethtool: add a mutex protecting RSS contexts
Date: Mon, 24 Jun 2024 15:11:17 +0100
Message-ID: <844a86646e6be10d34589f59b538498340a513a3.1719237940.git.ecree.xilinx@gmail.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 446dc197-1b0d-4fb1-1540-08dc9457c1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i9QepkIKXWCy7NXJFYo6aZ/ECsNa3gc/Cg0C/q9iFCNcDpXBs1z+f8GDtV9Y?=
 =?us-ascii?Q?We1pQsYxSoKC1en06HqUfxBqfqlx7OULk9Kq2BimJuPttUAUW9IY8BHPGffM?=
 =?us-ascii?Q?llWvRVQIqP2SvQKBpJNUj8Gh+LTfsec0MRpOWQ3dXoTpZX3ZIbMR6ZJ3bR3m?=
 =?us-ascii?Q?VloqzTWkOqMuBkVE9mnF1Xv5icCni60RzXnBVmnQeOIFCAiLQwDC7QleI0vw?=
 =?us-ascii?Q?5wvDL0ajapqS9S6yjuldDNWFG5c2mWeGPpcDZpVguQJwStgnbQ+n7yeiRRMC?=
 =?us-ascii?Q?2Ebp/zmyo1g2iLLEs4vkZd5nt8Ses86spuPcREzTaSeb6LegB0YpHoM2GrEv?=
 =?us-ascii?Q?MP1E4pbBG28fcg7D39/hUoMhKVhfDB1vbTX7jIJDjIFzJ3FyZ5fW/PLwCLtO?=
 =?us-ascii?Q?9iVYBMkk4Lxw3dTqB4Vlae7kBbZ+i3bMf4J6yPz7pxMa564aJONWaTG1Un28?=
 =?us-ascii?Q?LG/P2lSGO9J7WgBfH5PSqDfX2t8BFzwQvAPj1DGzM5ZM2qSSge9a0Z5v/oud?=
 =?us-ascii?Q?tXBrH7wqzFe6g9rtZEsTrKs/k/9Im5Dul3nHFNVHSVuUVuS7JkAsz1XZ9XEO?=
 =?us-ascii?Q?Wi/1N/yb6QbNktRa57mC7Qr/BtYqiscjjyBo7CaWS5DEdOxs0afyU2MRwROG?=
 =?us-ascii?Q?Lq3bK9Njtogy+wETR8h7U832beHJnFI0eKs7ORAu9d7eZuJDe2+rJNMdZQ0y?=
 =?us-ascii?Q?3MW6nK/CUb3S8Toi1Y38/D/XLGTRCkQUSNRkwHMVynX/tcG6jNqCFo7iB8M+?=
 =?us-ascii?Q?wRvZoZqdmi08xbiwtZXxvmI4e8XJ3rqq9r+nn6Uy8pJdFLmVIbJG7NXJteal?=
 =?us-ascii?Q?sOGGUSmEf/O7K4cIqxs0PTn8I7sejtOIfttokqSZSbYhY7JLKOb2wYqIDpiv?=
 =?us-ascii?Q?DcC5Jb7BTVXXrHJiIzKCU6DGD4uF2c5//7ek8NCAnMe9wDLak1t6Mxh1B8so?=
 =?us-ascii?Q?TehZ5FNe4X9M33UOfg1inh8laROdBU1X3Jh5AhJDJh2pf5qHaAFSdTVptHPm?=
 =?us-ascii?Q?2BGkgL+yvnGQDrj7xLx+2XoKR/odEXQz563EFQIo9kReu/re3++Vb0O4wMsr?=
 =?us-ascii?Q?GZIShQ2jllP9KO3g2+RH1HpMyu9UXa+7+J6AmTrGw5A3wsT8MT8zvgrh9Yx7?=
 =?us-ascii?Q?GNMISTTEilduXtqoKsQzfCbLjmwGGYgvUhhIVdjtN1pJfftO4P1rTl3PpvbU?=
 =?us-ascii?Q?FLRbFVWS2ydu/iHe8BB8vuvM6/Bq3VrHJ6qDLFEHAgSzzKMlhdnELV+1t8Rh?=
 =?us-ascii?Q?MfJ1lJExXvw1kRuiKFpM3InVe0LXjlVIQI4vF85q0s171V5fmBdm08AUFAn7?=
 =?us-ascii?Q?ZSeF7doLYa5S2vLO/KyzdtV2p6owYUkGJs/V68gorC5tvGppAx9SpbiVC7yE?=
 =?us-ascii?Q?hpcR+pDqjytbOV1EdEg3YBd5GMTauPCsyiMm1rNS54gSc43Gyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:13:01.5098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446dc197-1b0d-4fb1-1540-08dc9457c1ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

From: Edward Cree <ecree.xilinx@gmail.com>

While this is not needed to serialise the ethtool entry points (which
 are all under RTNL), drivers may have cause to asynchronously access
 dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
 do this safely without needing to take the RTNL.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 3 +++
 net/core/dev.c          | 5 +++++
 net/ethtool/ioctl.c     | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f8688e77ca62..0d27e13952ad 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1098,10 +1098,13 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 /**
  * struct ethtool_netdev_state - per-netdevice state for ethtool features
  * @rss_ctx:		XArray of custom RSS contexts
+ * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
+ *			within RTNL.
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
+	struct mutex		rss_lock;
 	unsigned		wol_enabled:1;
 };
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 16f1fc9e2438..51476171374e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10287,6 +10287,7 @@ int register_netdevice(struct net_device *dev)
 
 	/* rss ctx ID 0 is reserved for the default context, start from 1 */
 	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
+	mutex_init(&dev->ethtool->rss_lock);
 
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
@@ -11192,6 +11193,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 	struct ethtool_rxfh_context *ctx;
 	unsigned long context;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
 		struct ethtool_rxfh_param rxfh;
 
@@ -11211,6 +11213,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		kfree(ctx);
 	}
 	xa_destroy(&dev->ethtool->rss_ctx);
+	mutex_unlock(&dev->ethtool->rss_lock);
 }
 
 /**
@@ -11323,6 +11326,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		if (dev->netdev_ops->ndo_uninit)
 			dev->netdev_ops->ndo_uninit(dev);
 
+		mutex_destroy(&dev->ethtool->rss_lock);
+
 		if (skb)
 			rtmsg_ifinfo_send(skb, dev, GFP_KERNEL, portid, nlh);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 244e565e1365..9d2d677770db 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1282,6 +1282,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct netlink_ext_ack *extack = NULL;
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
+	bool locked = false; /* dev->ethtool->rss_lock taken */
 	u32 indir_bytes = 0;
 	bool create = false;
 	u8 *rss_config;
@@ -1377,6 +1378,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
+	if (rxfh.rss_context) {
+		mutex_lock(&dev->ethtool->rss_lock);
+		locked = true;
+	}
 	if (create) {
 		if (rxfh_dev.rss_delete) {
 			ret = -EINVAL;
@@ -1492,6 +1497,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	}
 
 out:
+	if (locked)
+		mutex_unlock(&dev->ethtool->rss_lock);
 	kfree(rss_config);
 	return ret;
 }

