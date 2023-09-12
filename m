Return-Path: <netdev+bounces-33258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CEA79D381
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37B61C20DE3
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317518AF3;
	Tue, 12 Sep 2023 14:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038118C05
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5062115
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=de/qqtoM3Y0HSTDsiCg9Nzv6FNfWfrblKfGGPq5XjtrcsxcxPGE+g2Y3VRfcr/zCvv5KM1ML/0Dj1E4gR2eRBrIRQhXljbq27r3MxM59XMc+qPtYGwEzFA7/IDNAY+MNeKkqndgtz40lL/C9Gs6Z3N90JG9e+STwypkb2c8yAsDoKdn3YJgLJFlyEc1psd77ZKi6/EM9mwe3dfybfFiMB/t57TKPUKoBaVlDIb/WDaaGYBtLEdb4x/Fy1sM6noJ5Lt0M6OERU6xjuK/WlVbs4VyWDCdLI1InvJ04pU5yad13HxtJjLoeknWbWEv/KJEDA88g3fCxmHbVoyJUpuL02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T9CcoNhkRi4iaP/doZOZKehp9MN19NM0+iK/AYfz/4=;
 b=DJLcaMkd38eHKqHtf3rtFWNhDfMXdPdOfQ4zcmXt07T27j5mWaH4HmPwJd2meCvo8NEdphFq2zYNte4R8ABS/vTZJ4opePDL/OOrbfy48yhooQ6k4OWj4eXYGcKoPrxsyQoVBEqUB7SjfsnI7ZsfJwr8bmnUoGbyV1QPI6VxN65vsMMmPN18mjvsEK1jSiA0+ZR+6M/Sfou6G/ocX2Gdf04wI858EdzLv3k0gGQGbVzYFSXcnzjiwKdcnAHtjnml+Nn8os2u+R9VN/Fo748jURNdpsLYpamv/np5tsLK0g5R3N9bDrgj0FMILrpxyeZxYh91ZPnb7UTsmHnHItCAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T9CcoNhkRi4iaP/doZOZKehp9MN19NM0+iK/AYfz/4=;
 b=fLJrGBnlQwrGcz+Y3WLEvdUuH5kVhljyDrfY/QB3Hn6oFHnW4RMuQ0oG7KjMgWwHHff8jDpw/PTw7fxU/82Bep/LGGW0p4wPzco1M2UC9fR4LttuiHEwgAHcWDU6aqvdD4CK/XgjqflBWVuCUulKhXSEegYF0CaE6xp53GFiwAQ=
Received: from CY5PR16CA0013.namprd16.prod.outlook.com (2603:10b6:930:10::32)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 14:22:37 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::8) by CY5PR16CA0013.outlook.office365.com
 (2603:10b6:930:10::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Tue, 12 Sep 2023 14:22:37 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:34 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:32 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 6/7] net: ethtool: add a mutex protecting RSS contexts
Date: Tue, 12 Sep 2023 15:21:41 +0100
Message-ID: <b9bdb464a3fcfcfa7ab01b1cf5e0e312c04752f5.1694443665.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1694443665.git.ecree.xilinx@gmail.com>
References: <cover.1694443665.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|BN9PR12MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: f174c0ca-d156-4fea-a7fb-08dbb39bb6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TK8zh0jBbcdsHE0zHH6wiA8qEO0JspcuIKCL+HwymtgwwAOz3rFqXXUnF9UBV64DoKYEc88Kya6QaJIJV6O77Kq+CiOVPkKzTRHwhTUQR39uWmi8MMZk2qK4G47YGdytUpxBeMkt3m5vP8wT4888vjAp8HGDgIvQH1K2QLcN9fXwVMSlZ3JN+LRHhCRxrPYqBppRJrdiInqgmWl2SdiyEmq8TQ7GIqzMoVhDrkX0kAbunBZYdb7JkLF89EsTQDIRzzFAnLwmT0jpXX/UxUqr4WtijAVNesq+7MHDTTdSc5OCAqE9I7K0IlWUWqz2htzd7HchYvqzGZtabYhzRJv/VDZHwvh+E8f4NeTzqQPXVC6D15sNMh1bSaGdehfCkioTItkuFLdNUEdk2ff+Y4FMKRehM2hrRgBlo7DJB4V3eOhVk6JqYDqcIOE9fAc2/SuCLCMgo7tXkLYHDqMOpUqinuiPdH88rGpEz1AHY2/RTjtasfJ09Tl2wDuvvGwiGhg3/tl3OwMnAwobYlas60yQdeLDZi9gJjiZeU1T8yM+cy0laiejs8tsWxTq0jURrVrvMBBMeJlfOaUgnIgKYs6ehIiXI5GvsaZMRJ7Wdf5Umjq8F16CtahnGcwlYUZTrLqtZXmY2kAGroXYXuPGYv8xQkd9Im6Ui5cxCjNnCcvDCgnxIBART2lRuuR9Ddcwr6T48E6NiYelbHn186QQpBZMtcVE4HWoXVSzwROWbKdx2WZEz3UOHsgfavgsOTHI3YljS+WE9YuG9f6TOsaAMySvHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(336012)(83380400001)(426003)(26005)(110136005)(41300700001)(81166007)(6666004)(82740400003)(356005)(70586007)(70206006)(8936002)(8676002)(478600001)(4326008)(54906003)(5660300002)(316002)(7416002)(2876002)(2906002)(55446002)(86362001)(36756003)(9686003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:37.1573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f174c0ca-d156-4fea-a7fb-08dbb39bb6e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241

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
index 8977aa8523e3..1f8293deebd5 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1026,11 +1026,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 /**
  * struct ethtool_netdev_state - per-netdevice state for ethtool features
  * @rss_ctx:		IDR storing custom RSS context state
+ * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
+ *			within RTNL.
  * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
  * @wol_enabled:	Wake-on-LAN is enabled
  */
 struct ethtool_netdev_state {
 	struct idr		rss_ctx;
+	struct mutex		rss_lock;
 	u32			rss_ctx_max_id;
 	u32			wol_enabled:1;
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index f12767466427..2acb4d8cd4c7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10054,6 +10054,7 @@ int register_netdevice(struct net_device *dev)
 	idr_init_base(&dev->ethtool->rss_ctx, 1);
 
 	spin_lock_init(&dev->addr_list_lock);
+	mutex_init(&dev->ethtool->rss_lock);
 	netdev_set_addr_lockdep_class(dev);
 
 	ret = dev_get_valid_name(net, dev, dev->name);
@@ -10863,6 +10864,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 	if (!dev->ethtool_ops->create_rxfh_context &&
 	    !dev->ethtool_ops->set_rxfh_context)
 		return;
+	mutex_lock(&dev->ethtool->rss_lock);
 	idr_for_each_entry(&dev->ethtool->rss_ctx, ctx, context) {
 		u32 *indir = ethtool_rxfh_context_indir(ctx);
 		u8 *key = ethtool_rxfh_context_key(ctx);
@@ -10877,6 +10879,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 							   &context, true);
 		kfree(ctx);
 	}
+	mutex_unlock(&dev->ethtool->rss_lock);
 }
 
 /**
@@ -10990,6 +10993,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		if (dev->netdev_ops->ndo_uninit)
 			dev->netdev_ops->ndo_uninit(dev);
 
+		mutex_destroy(&dev->ethtool->rss_lock);
+
 		if (skb)
 			rtmsg_ifinfo_send(skb, dev, GFP_KERNEL, portid, nlh);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 5b943db75974..70cca80cea70 100644
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
@@ -1457,6 +1462,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	}
 
 out:
+	if (locked)
+		mutex_unlock(&dev->ethtool->rss_lock);
 	kfree(rss_config);
 	return ret;
 }

