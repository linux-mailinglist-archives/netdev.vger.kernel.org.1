Return-Path: <netdev+bounces-36608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA1F7B0BCB
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BEE2B1C20946
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B04C87A;
	Wed, 27 Sep 2023 18:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75044C86D
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C06EFC
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJvoohJEdB+C7C5Re5+HFxUM9ZAC/sHqsnLfw/3XYsli6CwBHddHleYHV3MpTNC1qeXNyRgraDt6on0IYnfteg7YHYYnWw+TDUPSG5azRx2IjKSVi2A45D5hzk/m7p340hUayYxuTuUA64hpgKDAKkPTib05HY9t82R0WpMbg+cwd+uGbICCmm/OmACEsh7FSog7YGxYMtynWsgYiK/tVoBnOnxKxu6ZLTNQBzJz0scFSqe/vB/9PXoAk4XE6oRjcxcUsxWLTWp4en9QKMRwJ15HNmoNeGZPIT1noWgsa6O0nvklSz0W5TT0aDgDMmCk6u48wNMjiCH9a5TBop5y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU4OL4WnffsKwFx9V86nV7d9O0Knad5HwPgL/Krck4Q=;
 b=QMORmlMQT0yHKuXIJIU4KAUZcWC8d8bIWuQqpfDzt8XUhaM4Pfjd4ejW9ny9qfwHpxbyyxQnSCAXbDk6fMctVeInAFpiHhqa7xmv5Ha+iuMWhPboOYkwdyGIusf9/IwM06vPGnmCrK7+0YGyFLccIKFzt/liyHRayykgVCLUqg+pNnOPd/HACprKiEO8rGonBRI++qaj/Af9TlnIuEBhii/i1O8VLwOGrFv2En9UtoLcyYiPPG8dUdsyHst7HkXKRqaaBwqIcCLbU7fROhKUcpEBEUDfPrg9OEsCBqu/P+e9rQopD6xJ38KKpWyjAIpu0hoFGu8ykB+MfzDKA9wnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU4OL4WnffsKwFx9V86nV7d9O0Knad5HwPgL/Krck4Q=;
 b=jsSjLAAn5iAr2pOuSubu+HwiGKkKdYG82UUjVfng5x7La9jl0W6VC8Ff3YAiOsgp3RULRueHCrPtdRT8eeF8mBe4RitNpd3E1u0mkHpZHv/p02wwYA3vGqIs2DtLu/PCc21tUG/ggf05ohV2s+0yObh9EVEV6Uk8wUPWkYVR9gg=
Received: from SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 18:14:36 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::ac) by SN7PR04CA0025.outlook.office365.com
 (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:35 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 11:14:34 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:32 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting RSS contexts
Date: Wed, 27 Sep 2023 19:13:37 +0100
Message-ID: <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MN0PR12MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8002e4-dc52-452e-0f83-08dbbf859b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z0htfQb173LvMyfshTfEvPhOrQU9IDI43OA7pjXskjtou3ISdY7yLoWLQ173AJ1iyUy6OislaLiLhTGUIPeTPOSgqum6G2ADKc3OKPgEZGC374uGoShnppWyrO8rXOMCdQN+T00TP7ALvR4d98H2HthinIlgIBzN/ahEKKvKxlKovZ+1cem5yztcoq7fjdZ+sa2xLMQ7ID15EXPW845e+H5pBncZQOz5/HNCFUUUSgnwwPd7acLKs+e4yjeGDOsZrgVpP3V/JniuvkDwAZsQ1Tk1y5i3iX/DCGkrsIZuSOYpZQ5ea0OGGCPp1SY8D11tEBkxx8VkgU6r7h9UX59wEx+3/4J61lOI4Ooj/0Dawz03YKhVP861ZFhv5Dn1MuUKHScv3ZjA0AsdXYHl7dtI4sW7hoLTUU6HrZnACv7IKlN05phxv22jygZVlLs3MO5EWHWbdZ3C6nEiyMNcGB3pm0z6lqH6A6FwD5kAW36RwtgTeU5nyQ01dXCahKmpv3+Mcd1fiGskwZPTfA15DQsSvsmTzF8tuHZ0r5vwZ4jqe+MX+iJ4OybcyIEu5gRTzysgEOvMX8dxPFC1KE9FFo/vOh5ktzfXW+SixhxF3Vyn+G+aqI8VjyMUmrg40o2ChW5UvxRYbr/beR+BbK+QUg+YCCXt9EUt03Jgw3sGj3EKMwbf6p/ZFB3Bk0dAtfowcmUFJAjVB7ud/Jn8Bo16ihR7V/ecmOa+PfIggRKDptZLtAvycQYygmTq2V8LwnZXNV8i0yWmEswZc3Xr0ihmMcE5IQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(40470700004)(8936002)(40460700003)(26005)(5660300002)(9686003)(336012)(47076005)(110136005)(83380400001)(41300700001)(70586007)(36860700001)(54906003)(70206006)(81166007)(316002)(478600001)(7416002)(8676002)(426003)(356005)(82740400003)(4326008)(2906002)(2876002)(40480700001)(55446002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:35.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8002e4-dc52-452e-0f83-08dbbf859b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index c8963bde9289..d15a21bd6f12 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1026,11 +1026,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 /**
  * struct ethtool_netdev_state - per-netdevice state for ethtool features
  * @rss_ctx:		XArray of custom RSS contexts
+ * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
+ *			within RTNL.
  * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
+	struct mutex		rss_lock;
 	u32			rss_ctx_max_id;
 	u32			wol_enabled:1;
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 69579d9cd7ba..c57456ed4be8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10074,6 +10074,7 @@ int register_netdevice(struct net_device *dev)
 
 	/* rss ctx ID 0 is reserved for the default context, start from 1 */
 	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
+	mutex_init(&dev->ethtool->rss_lock);
 
 	spin_lock_init(&dev->addr_list_lock);
 	netdev_set_addr_lockdep_class(dev);
@@ -10882,6 +10883,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 	struct ethtool_rxfh_context *ctx;
 	unsigned long context;
 
+	mutex_lock(&dev->ethtool->rss_lock);
 	if (dev->ethtool_ops->create_rxfh_context ||
 	    dev->ethtool_ops->set_rxfh_context)
 		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
@@ -10903,6 +10905,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 			kfree(ctx);
 		}
 	xa_destroy(&dev->ethtool->rss_ctx);
+	mutex_unlock(&dev->ethtool->rss_lock);
 }
 
 /**
@@ -11016,6 +11019,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		if (dev->netdev_ops->ndo_uninit)
 			dev->netdev_ops->ndo_uninit(dev);
 
+		mutex_destroy(&dev->ethtool->rss_lock);
+
 		if (skb)
 			rtmsg_ifinfo_send(skb, dev, GFP_KERNEL, portid, nlh);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 3920ddee3ee2..d21bbc92e6fc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1258,6 +1258,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *rss_config;
 	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
 	bool create = false, delete = false;
+	bool locked = false; /* dev->ethtool->rss_lock taken */
 
 	if (!ops->get_rxnfc || !ops->set_rxfh)
 		return -EOPNOTSUPP;
@@ -1335,6 +1336,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
+	if (rxfh.rss_context) {
+		mutex_lock(&dev->ethtool->rss_lock);
+		locked = true;
+	}
 	if (create) {
 		if (delete) {
 			ret = -EINVAL;
@@ -1455,6 +1460,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	}
 
 out:
+	if (locked)
+		mutex_unlock(&dev->ethtool->rss_lock);
 	kfree(rss_config);
 	return ret;
 }

