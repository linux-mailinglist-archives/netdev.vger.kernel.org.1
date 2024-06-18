Return-Path: <netdev+bounces-104678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D56F90DF3D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 00:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E568328443B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677F5188CC0;
	Tue, 18 Jun 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LbznQXgH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794B185E6E
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718750735; cv=fail; b=MaBFeq10lfnP/uDhXP+dfFLv3ff0wKUwAD/OsJ91Dgsh/958H+X5unj720uryMWkOIw18xzCiJarzDCHPyuz+jSMS+CUbWcPhbr9/+niv/W2opG5VHKsCpTKm3i8JL0hOB8UdkuVDRr/mJ+KDuxNnPmN0AgyLrTMVharAB7nEWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718750735; c=relaxed/simple;
	bh=/CEEWtzy2oFVItXYX/X6gQuOirB6xIljdOYf7Ys+QHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gPrjWrZxOtaL/pOl95fe8VsBwq1kIN348kJ003xkFVr3GIGkr9RdJhwdYHwQRoeCo9+aBNGehnosYB8WjMalscQtncmOvxjtMdyddY0Nt9nUKbiyKEf77+1lBApg80ZSvWYp6h5artQkHeGK9S3G8+SzkOv5vFfSFzq2SYwKLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LbznQXgH; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHzN0sTTbXrnPineA0gsHS+yqOp6uSiC5t6stAdnyTv9PBuA+WnYW/2f/ZJHZi1hfZDfa0nJ1zXpjwv7xMX9eTnHuS7lBfE4hfvmX8Iq6/hmaZmJFGkAze+RxQwGr6r1Gf/6qNMfi/nRHbFvjaQ1I6bC1s2DSjc5q4lKWIgOtBAevT6wYiTOIhiDdt8TdRvWjA3r9A3NrN0QYe2pPH3tlJWVf1MGTHeeGra9BYiCWzfEE0SwQJAYNS5h6Q/JGkOsAAKiMZojtOxIlFomhZmKtE1TKPhpPoiuIAoP7bFf18XLVhQdg6VlOvzyneV0tw9hihktvcEnA5O4AY1Ls8Xg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oktth2skh6kb7NtJNsqy8oVgjIfZCMBE1g2+NG4yIIs=;
 b=OkvKD1UUzC8qZYS8hRKIlnXMMJOSFYklV5zP3wgdsnTWqDLH2l/WGIbKW6dzy16kLlYw803Xir6c5EeREgwjpGPkODUv7OkFgfV1svICQZIVkmEUgBKMmwiiCxwzZ5Ql+B5D1RJ+8/jERIvZ+SpRQB1ug70mbUlV5OjfVzEawoDpfEdP1tkRiRsTVz9XDfF8pTzwGswxpdUaoQ8sD+g6Mi+JhV57WdLPJsssqS9j/ZxiAh5qqM1KW6kk15Ibnt1wq8X84kHfMSZhW5p1hk+qh+t2/+r2Lf55MyrfgDwWacjKQt9pnOdS00aAaTY44yaPbpQP7QqE/kTZ2nxZ9Eu/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oktth2skh6kb7NtJNsqy8oVgjIfZCMBE1g2+NG4yIIs=;
 b=LbznQXgHrtSm5oA9DzEtZh9QjvxuSGBP8hEn7GCk/xVS72ZaPM+Bt9p6vOF0GV7e/PjdqK3X613pbfXUDOBCnuJBzgxiyjvI7a9fK4HdJO1yeQzzBjFyOZqE/X3gOcPPR4X5Poktduorr1g5Jy8nWGdxaB5Pa7WhkS0G0H3nnJ8=
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Tue, 18 Jun
 2024 22:45:30 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::6) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 22:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 22:45:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 17:45:29 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 18 Jun 2024 17:45:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
	<sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
	<hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
	<jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: [PATCH v5 net-next 6/7] net: ethtool: add a mutex protecting RSS contexts
Date: Tue, 18 Jun 2024 23:44:26 +0100
Message-ID: <a759188249f29e88b9d13fd8e943c544fe6c4a9f.1718750587.git.ecree.xilinx@gmail.com>
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
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e6c8e0-00f6-41e9-15b8-08dc8fe85af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|376011|36860700010|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fvplhKHy153wfw7ZCpMEkZrpDHx2g7y2nsJ6gMrweVxkwuFx30tXUrU+91aQ?=
 =?us-ascii?Q?Lj3a0jA3TdQl9QDHebwyPYpCJwKZ+MVjspHf5XEURf9BJLAuhOjpIkFHhA+I?=
 =?us-ascii?Q?3rHSN5NWG01NVcST12mCwhqCZUz/6mzguBpvv3pMGF3praVB+uuJbPkOUUyi?=
 =?us-ascii?Q?yGv58OqhblUozec9tSun5ZgyMAj3FwKMRJyCZLBIZk3h+3xLxhIjmyDazmhA?=
 =?us-ascii?Q?k+YV2ItUGTfgemIEHV0ZkJX/Ufs7DLx2yl8lm9eRqX8I3gpsqqRVZjElBrAE?=
 =?us-ascii?Q?DZcrpEy2yhyPSsvFILYWf9p8d9Wsqrvv+NlqXlMeRAAncg+DxgvwHGZOerbV?=
 =?us-ascii?Q?9cv/+np8tfCuzaMC2J6nDfDpWbj2MkNIp1hsk+TwV+4L/SCZEOF4NoI/nJGe?=
 =?us-ascii?Q?iFzH5TqibDyPJFscro+4OJ4LXbzSCKMutVUeve2p6MntoV/E2aY0QoAIO9wN?=
 =?us-ascii?Q?01jcfyq9+w8zNm0nASrhXpepBOvw9R67z5eA/QN0ijksLyz/G77KVGVQv0Vb?=
 =?us-ascii?Q?4Tz6GTBWnoVIzFjSiZVS62+8QrmwVCtDcCjjWuFryF/lpUfStvEStnwFR342?=
 =?us-ascii?Q?Nb2dZh32pmi+uZX3q75BrbLI+CSQI9dZpdIqsjTux71Ll3+AsHDH4xOa31kH?=
 =?us-ascii?Q?1gPpSk1fOJ5KpK4k/hngrOX2yFUfTrv1aY3dCq8wUEPFlAitjRFEI8OBmpvf?=
 =?us-ascii?Q?adYVVdxpQDEf6t85VBe7c7+hLOhA8RaBaDeCCeXM30XXU742g8VtHqq5WukO?=
 =?us-ascii?Q?tNm7fZDxIZ5cicZuZctq3q/KeesvsI5nhwmnmVDzjHn+H7XrSJjKJ9Wq3FSF?=
 =?us-ascii?Q?ilIIqpeGQC2XPRN2maaZaNwVbi7iK2FGIs+6+UrMDM71I2+btq+QuFdp6wxS?=
 =?us-ascii?Q?jQ0WdtfWGGX21dwIA+5CM2mFlxLNRd099nUQrTGGoGz5h3wMYe+eEgn0+5/Y?=
 =?us-ascii?Q?lQiddeo4vD9JmoZWm41fd9yldEzTLb1/6a76xtFDXHD4D8qTS/7J0cvLg5gI?=
 =?us-ascii?Q?GfkPrxOIEAWW9Pt9taGYV+gOX7+hzUuYmsGejo82W3zQ3A7noBkefQsxCFH7?=
 =?us-ascii?Q?AMkDejc3297PoA1PSlKw4pwikf0lKicNPgCXM27Fio9rN48oANlqfmv+SSrB?=
 =?us-ascii?Q?Hdyhcs9RuHOWd2xZS9pvhUzjneDXU7Jcvd5Sr8Kf9pj4g/QwQYuC5TuhayjD?=
 =?us-ascii?Q?WIOy5aHoydPNHHvwFbA4IJks/qXN+M2ytLXrzNeJt68R0pPBQp4H+/cazBVW?=
 =?us-ascii?Q?gA2xc0YRMCM4w9kwWrkNqOt84AkSz9+midjjXTtop6W6bjVp/+sAKGzk0N1n?=
 =?us-ascii?Q?ab5+AlVALmqO38loJBud83kPcXrtytkoSN1f+wVsDE0smw6C9esibkFT6RN7?=
 =?us-ascii?Q?n0n8dhGXiBxpAM6PkMeSfsJt2lCvyyxlfxpqEmtVULXgN8RCIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(376011)(36860700010)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 22:45:29.9920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e6c8e0-00f6-41e9-15b8-08dc8fe85af1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

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
index f781894a7cb2..73481a69c17d 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1095,10 +1095,13 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
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
index 09d01b49a414..6679834be301 100644
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
 
@@ -11214,6 +11216,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 		kfree(ctx);
 	}
 	xa_destroy(&dev->ethtool->rss_ctx);
+	mutex_unlock(&dev->ethtool->rss_lock);
 }
 
 /**
@@ -11326,6 +11329,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
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

