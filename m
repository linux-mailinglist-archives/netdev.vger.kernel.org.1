Return-Path: <netdev+bounces-105124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEC90FC4D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 07:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434D01C21102
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D738385;
	Thu, 20 Jun 2024 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OJRZdYbS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805E381DE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 05:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718862500; cv=fail; b=K8+wkb/074/YxN5vwC68o1einp/GNtNpX2MdhCif6fzPo8SBFJat6sclaHZfU4OJUd21QfJ9WxCuCbI3Zg9izVmtn2jIBHY4XTVVwiIdSOyaJKEZ5YQxfKw39/YhghRfokLakouXueNQSTlsEb+OXfuusU+KCe7fcYT+rB228T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718862500; c=relaxed/simple;
	bh=K2lbEuHcgFmq46cQqGh/D0XHvl/WsPue3D7qyWPfiPA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0O9ICV0+izYRGr1K/pUkgwauQTigS/Cou55e0kqGwiVV3pBHRmsmLvs/bqCv6JoZboNasMpGhBl/p1i/c08VkThd98xDTELlQb3oX2uOnmGH8wBhRb+xaWaz+JiL6zqssqEaMJLAFRcenIYiBgXhuzXb9YerEHAd+XBU2Pg1ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OJRZdYbS; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAf4nNSosxedPKiQy5OVVf+iug4yv8tNNgzlEmE0BQPdvhwVFtjF8lQUXOJN8fApyRJhgteO8MOATsO0L1CCUl1youFlN9prycncPfTnwjLcPZQgzQOTLc8xDUF4sIt7sxtOzAl0l2apankKtTCtn86H+DIPb/oZXdvOHBK3QJcIJiddYexwyRZTxVZDPJ0G8NcU7ykmr7riQb/iTUNHpbMX3PCHFIjFHc3zVM9Vf6IwOqBeyv1dZvGDcedAwV04w5LyA1x2OyQh2AY6PbF0B5vR7lD1LdNhHLr9mqBslvoR4BgzX1owHv04ST2TADic5ryhZ6AOsDTse3YwnsL17A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl2O1y5Fp85cOgybWxSQrtQD9aT3utB2CiihAy+Sp60=;
 b=WeBb2vzEs8PMSRzAl5smZnzb/7ZuxMs+Nofsr5kCYBerarqZBv4ThLpRKJHD3N8u9YjUjLVKXrrqtV9gqCtBV0o0HTlw7uO1G6tOUIL0QL4AxxLx3370JIc4AqM92mLitFQr7f5jIKotCPNcSTABqJBFUlHxnYI9Kzy4Bsn5DI+CXh0V8cDJ3MTM7k0M2tsKVrP0Z42UiTIPc7oaG2MTr9565WnvrBY0sG3ID+fpGQrBdQfZMort+wB/bETL+eUxyZ45iwr5Vk8YJ5F7Ge+pkBtW/kITluYXAzBD6NnSJh68tCOhaaPNJzjqr2e6EIqcuNL47awWA7vPcmoJZZVCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl2O1y5Fp85cOgybWxSQrtQD9aT3utB2CiihAy+Sp60=;
 b=OJRZdYbSzfXYtOkBlBWpQbsS5lDtjLFHbltzR7NHvr1NqZWC7Ke2zEQehUdnFWeePlAcRjvSYcV3RLv6+uEWVggS9ximEr/Zd8vvbWv0SB/6N4vaIb/BTuLx4Uv1dvV8NlMrYqfFkLBsXn/ajritjoqEjPm82YKARBTkSZrU16I=
Received: from SJ0PR05CA0039.namprd05.prod.outlook.com (2603:10b6:a03:33f::14)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32; Thu, 20 Jun
 2024 05:48:16 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::10) by SJ0PR05CA0039.outlook.office365.com
 (2603:10b6:a03:33f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Thu, 20 Jun 2024 05:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 05:48:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 00:48:14 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 00:48:12 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v6 net-next 6/9] net: ethtool: add a mutex protecting RSS contexts
Date: Thu, 20 Jun 2024 06:47:09 +0100
Message-ID: <6781c564c4629c2ed9c201ab7b67296baddfded2.1718862050.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e3f356-ce2a-432f-53da-08dc90ec94b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|1800799021|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k65RwiD8ZLVmtzjLPDXLy4oWzSgAP6/rBoVMnoab/YU5b5H83oIp/LmIogZs?=
 =?us-ascii?Q?s3EdbxUr2FdaHaH9n7ttiCeipiJxh5WIpzaglTnE3zoyxyXvYNYaFKr+fVij?=
 =?us-ascii?Q?8gwEyoFf9MmY7mypnZYdmbov2myXupf1cSWq/zdR9F5TnSL/RNct/u9ukEjc?=
 =?us-ascii?Q?3wDhqUWjxR+wpVVx9DQPn3E0fHmYjd+f8vwT7dzSEbesHrmNOqzvVuvMMC0i?=
 =?us-ascii?Q?/TE1ieNZHdbksAderI6iFUUXkPBMYEfG22uE37smKIpisKao9GwhC+6v7sWt?=
 =?us-ascii?Q?14lUCkiDi3i1jWBp81jlQSMQk//sJs6uK4WvJws37/d7O8KiTJtC06vzdwO+?=
 =?us-ascii?Q?+o16EevV0zo7X9jOMGhs1L3sehaPgRlLm1eUHvpSRBMT47H99AGeCznAaPt6?=
 =?us-ascii?Q?jPiQgtVomi3TSa/PU+bwPAOEguoPGxPTnieZWsB02PcX2nOMhoyyOQBxXsZE?=
 =?us-ascii?Q?ZQFZtuL8iUsnll6AT7y/poMn0gAqUOqgclVXphNoXHzyCm69OQXbkS+DJIkB?=
 =?us-ascii?Q?K/RUaO2/nwUSBp/oxAnADYmo3YqrxArUmANxTpKZWOeELl01zk5mZcefS0YX?=
 =?us-ascii?Q?uivm9n5xHj2UOIRojbTrQcvt89fsh+kH7tljbszOxkX84NQkdHnE/llMtRHw?=
 =?us-ascii?Q?P5+3V4sDwOylfUo7pjuzLN6vu2GZo5yN1YTXxG7SuOB9CUoEBYNyNPTZWBpC?=
 =?us-ascii?Q?tOJwGa7cPO7aj4TC7KH7HGqe2mUKe9yMJjxAIIocKuvkhVm0TH8laCWETg/y?=
 =?us-ascii?Q?ZG/v8cC37xbagEh+DUAPGACysYmafJOTFX5EPJM44sHy+30tvUjOaG6OT0rM?=
 =?us-ascii?Q?gU0sijtVrDFW9Hl2XlE+NtPB5F2O6af3vHY0Snxabq3KCuWrmC3JkBFMVP7L?=
 =?us-ascii?Q?gEyTf/EfBltIvypdylqc1VVLo9/zwtTjA5TGF4cGZNDRxTqu8/1ULll1xiPU?=
 =?us-ascii?Q?MKvltYbfPRbg/JD4Yfj1xHG5LIVjctzHauOTR8OlbPulAKnpExVzuayB0jbU?=
 =?us-ascii?Q?IJnWWmz0p86OnK4g6yrTyCBw/6q1t32p9xwG9lfXQv9d+TkvWivtcLKlO4Ch?=
 =?us-ascii?Q?LEhumKN7OdFNc93m0DmDJZzLTMUy/+02t0z5wm1K5+sfeMpA3ez3CPHQ1s/f?=
 =?us-ascii?Q?qq032BbxE82qIFHOJvO7FjKdhTmjv9eSDNx1xy4WE//ZQCpaJFOsJuaCiUFh?=
 =?us-ascii?Q?5qTsciAjlVVwtOuxnOiXx8RmFjZ6Rhj4TBv25NRE6yj54U5+rQc+kefy4JzJ?=
 =?us-ascii?Q?JpaUl55Pg4TxPJ2NJ+ul/oI2fYRaD7evWoVmjYdu87fiYpgyDjlxrz+YGoTA?=
 =?us-ascii?Q?1/1QmIXz7yI8Ni/zAIrBgAAB7PaLyOhB/xu9DbO0Hj3/3wgvNJ9bknVlkVd9?=
 =?us-ascii?Q?x5HVZ53nKzkcmwQDr5bv5Ho7mywVEnlh5GsnitLwxKKnWr7Odw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(1800799021)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 05:48:16.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e3f356-ce2a-432f-53da-08dc90ec94b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

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
index 9ca9424ea8b1..4cd988b8a74a 100644
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

