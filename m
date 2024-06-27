Return-Path: <netdev+bounces-107372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7550E91AB79
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F50D28A45C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04A19939D;
	Thu, 27 Jun 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mHkuJPzZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BD21990AE
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502476; cv=fail; b=a7zfV/+yzcuS00WlG5Bp3PIFgFTnl13fpS16VxtHSw589pLdfqeWkRAxYFKsYO6NA2iruk28L1peojjv6jvYAcWoCIWfVECGcS+e0p0/zUu9PA0oU4bnK3mj75opEMGpRH+qtnJ+yHAGXiOSrO6BbooktIGNfXP2I8rBHSh5Kjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502476; c=relaxed/simple;
	bh=qprT0d/IuQqx/m8Dkx4fl07p7r40xQLFjFAcnsNh/7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad4fRNtSd5GbAsRcHoCbufNc453X6U7b6THYti+HEjcG1hgw4jihhbhll7PLfpCm6b7bEacpl/Fr9ZItUJnVTIrMqFfChlbsIs09k120rfKjYzv3ckjG/ekmsXGrIo4rEc5ClNIa0ZC62dFVy0jEr15fWKELIRA+g3ghWCpOSDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mHkuJPzZ; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSZSN6gYKx8fyONIDtaOawI10wEDodENK7hZVp+PGpmtJs6HYZCB131efIJscZVJ/aSmOYxNhqGJnFv7nnbTVggEO/g9iMzkdqTRy/R5QXWFJWlTfcFXOGnswrD8cZ46VTmFd/T4VA5yLgwNwHVvL8+RKJ2xRWhlr9SY8wxOJU/ZthWJOhj1pKXBdo5OpQMIvRgKB2tH2tJNkN569eHj4xau4KfRnVbzVjq8zhbPNczr2yN5RM1l08BwwW1JZxG/mp98xvPi5zJhoGNP0XKGW19Hwwa5/AgX0z58urdfAvfXLPjksd0C/X1p2FiLAx6GH2V24mZXmqeelbJcGal2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BroOOsX1WP1kAHaFcaZSG6DUoIX/EdXT7I1BI6L7XsI=;
 b=RZEC4JFvoUZz8SvygJfNpdW5xzJYSwrRY+8G84aE/e6OYEvuDt5MSqOsxikaGfbu4gzH4sxe/Ju/25czVbTTYkqJnaCL8TXglbFCikO0olF/IG8pllsSa2zGj8xL6wIKXhyRSQM0txDsSvDcRLdEuYeUafMZ39qmgWVpLTKiZNFFi76P9AxlJDQeJDqtIgP9qEtYsKVYF8TgQAkjBMB4PpuplxwYGDu92s+ed8YOLzbY9JtbVwmnMYUrGYG7ItIWN6Wwq6MUVxJNjsmzFNgegudVhdMlzGtBBhyyRyYwQFpJbwYL/e9kujRvaa2Jr6IbSqk8K01XVZFn8cSzTjmEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BroOOsX1WP1kAHaFcaZSG6DUoIX/EdXT7I1BI6L7XsI=;
 b=mHkuJPzZvjpRY89zg82PfqGexp+kooi6RC8pIE5V6XB7pHwGXcwD7O0zp4A1HEK5Dpbc5eg7IVPj5+k/nYfH6sdBOIpdvltyJpwMUGKUK9Et+W+RlmdDSBC/RWRDGAkziTUfCb4+lB1JAPHOiRoa/ZfEr0n+2ZQPtVpkDEPXnG4=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by MW6PR12MB8757.namprd12.prod.outlook.com (2603:10b6:303:239::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 15:34:31 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::43) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.24 via Frontend
 Transport; Thu, 27 Jun 2024 15:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 15:34:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 10:34:29 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 10:34:26 -0500
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
Subject: [PATCH v8 net-next 6/9] net: ethtool: add a mutex protecting RSS contexts
Date: Thu, 27 Jun 2024 16:33:51 +0100
Message-ID: <7f9c15eb7525bf87af62c275dde3a8570ee8bf0a.1719502240.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MW6PR12MB8757:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc2a38d-fd31-4ac4-bcc4-08dc96bea3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELzcu2tNEz0Yutqn/3L3BXSk1DyWtvYTHLflldiM6OyhMNgrDhAQQRTc4N4R?=
 =?us-ascii?Q?RtpFaTEiadRW/hQuBmAeqRYbH1gpinX1sa/AcgcG2kMj4u9F+CMP/VxvOZkQ?=
 =?us-ascii?Q?zVFnfdzQcSlYG6d5hxZWXBzciDkUx8STRnETZGnpmbkNqg1n5woV258Zv58l?=
 =?us-ascii?Q?sREIcMjKuLiGo9e8DhbCo4S5WLFpRTkNdl8sUpFceI/ZQdYuPB3b9+4Z90C/?=
 =?us-ascii?Q?jTD8jhvo1f+OfiqBnTmkP33XrpxpNaoPXd/csQEs6HBzLpD+jgmnJ1Ku/cJV?=
 =?us-ascii?Q?BU0HooRvUEb/gnZZ7qX2RRN12cqM/ADBzFIkikIAaO+XSulKqQGmcR/ltOKF?=
 =?us-ascii?Q?QxNJy/K6nfoHm7PwFtiK8olu4nWgSmfhxcKDSegvRNppzCuFekeM1lhFuop3?=
 =?us-ascii?Q?8yV5cl1lrOxCuazhb+2z4eyDPBVSmgUdnaFivmhul/GKMsuLo0LPQcwauy4u?=
 =?us-ascii?Q?aFfMn81GNPc3unUUpYYHmrP82YYu9GGyFQg6vqFcqKYhmnDgl4I4Ivu87tYj?=
 =?us-ascii?Q?3SOKM8Xs5CNIXg6q0hASMp1EiBZ5s47Xl+oZIotuWHaPOHu4n6MzwxWpIYwK?=
 =?us-ascii?Q?A27yeet/JoVM7esHtd12RYYCmsSG+MNC5sGUcdCCVfosFdEtr7jjJNrsgmGX?=
 =?us-ascii?Q?4KPRjQE0utvL/22Mtw+df7aoHyUesV/nRamvcVsUI0uC+4bEvAvdsBpy3Wub?=
 =?us-ascii?Q?sqfReGh76a/ZjcuaLA5ktQ1sAzxe7NT3yz3HNLZcW5VhyXW+ONa81BE1S4md?=
 =?us-ascii?Q?kUTOOu5va3Tj+phbEKJoe2rChKB253evi2bWSvH5HyqI9hqitw8oaE+8zGXy?=
 =?us-ascii?Q?g7hmXMsaLhs2TkqeyciKsE/TApba8xjzmEWTEIGdfYFe64mMLCvZROeE9p7h?=
 =?us-ascii?Q?3U6LJ9JQ6kmbWNJVPbXsjZL/akKY5Czi1gd2qrEsp7cjkd5VscfBdkZo8FeR?=
 =?us-ascii?Q?Ocm2LBonoUqylq/dMNPu/rWxdWGdHk+zrBm0/NuI84z4E4lO1D9qSfHTUtOx?=
 =?us-ascii?Q?DB5LaTR9OIMv5cUb89o5+v0+oAGcfcA8iXMFdQQbcsonEir2LU1ifT8+nuRW?=
 =?us-ascii?Q?kYTuyy8Tc5xOzfJK1GkrN75jBHkZ2kSbOKFu1KejMtDIse3gTxLcn44mBKiK?=
 =?us-ascii?Q?tSMhabNa1F+QQDu8+4o5cQ415bAeVeVAM2O40wqoYKbfOaKsypnMDtNGmfl2?=
 =?us-ascii?Q?BBfvaF+5qpcaDgh3FIINAUDWpGzjz5o0PhW7GBsFDsUz5zWf4BY9ELW3ThVg?=
 =?us-ascii?Q?jDMoi27imWxzUw/AWtoVvHaOTYq1XrndBsBJICc5SVNKY7uLBlovoMJFq+Pf?=
 =?us-ascii?Q?UfDdmsmeTbVm/kjjCKFo3W7a/iytfvjVQAjwue7H/lB/BsvsHpWuit7nMwxT?=
 =?us-ascii?Q?FlgwZHem7PzyHdXp9jMOfbqd5wj+xb/tHAnDlQcc+GBeJVMjIoJTRmr8cPr9?=
 =?us-ascii?Q?XI7HbuEonN4As9HGEMqPBDxZJfjHJQbI?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 15:34:31.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc2a38d-fd31-4ac4-bcc4-08dc96bea3a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8757

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
index 533912386070..cbabe21d358a 100644
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

