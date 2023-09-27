Return-Path: <netdev+bounces-36605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170EE7B0BC8
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A07E81C2092C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A84C874;
	Wed, 27 Sep 2023 18:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84965689
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A48A1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gaw1YsyjidvU0ruhqG4zY0Iot6GNdIVv58ue2IW91oo1NsK93wuDLcrhdf40BGfyxhR+OW03+TJHefzfnoit/VKU4q2bl9FnBM/o4o2014h0XKRdIeqetQ6mUlqNI6f2Q8E6lmeJqA/JBR9wEpr5ZIczDIu7oElDrD87+24slADVxMpHMZ3FWSrzGpRvaGayMeXHldHkb27nqZ4rc30JENHBTw+XrcQU4GjDjvpBcmuqsREhmj+ZxWPz8OWyuIELcTPQrVN+vBik1Bk4jYI7Es66GWrJpU2rfRRmS2PiPlpUBVSOlkq3P1h+yIfZe16KbOlVsJiBRMhYOaJ4asQFvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjPAnN451aNNaJlzdm5VfBuLdylxxOwXUrQiWWX3nJY=;
 b=eUzqHIP18cPUaAHCvj8fbRG+Stl5Ial9DSyXixBgVP/91vZbw60ZPm66UlfERkJUxdwFaMglhly7DKvX5pM4UQeQ7DbyEkLWGXrImGK52NdAdWAkE8t4JJQoZVYsE5DJ3HiMtNYGeBbo3FzzjWLFLpMMPxRusXe+8r+MmdUc1med8s3Ak9NBPsGPy7SLnDoM+VBYKYC6Cxq6pNNZ8AP0D5AXTzZ3sfUwiwhjBbTXOJuMKWxVk82dJTK8lwR4h5T1gPletrHHloTlWc9em/mBx+TZF6qG+Db3n86DfOw6O2icGZEy0YruLn9Mpu8TM6scORUSZS4tZUHYqDsSIO5AMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjPAnN451aNNaJlzdm5VfBuLdylxxOwXUrQiWWX3nJY=;
 b=wIeOnZbg1hsc1beYBMX7GyKeKM3k3fhwjGQ/3ILHCWXfQwzoKz6MdbCDuGfh8k8DwkoteZOoeiV1r1W3PQ/WrxarCuLacpcllWoCgLf+e5SNNx9tZYHgbKnZs7FaTo2Q3h2s8a/6CjT7uZqPSvW+rfFBJrRdzEdodvfLDec1hKs=
Received: from PH8PR20CA0005.namprd20.prod.outlook.com (2603:10b6:510:23c::13)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 18:14:31 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::8c) by PH8PR20CA0005.outlook.office365.com
 (2603:10b6:510:23c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 11:14:29 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:27 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 4/7] net: ethtool: let the core choose RSS context IDs
Date: Wed, 27 Sep 2023 19:13:35 +0100
Message-ID: <692201a4fd89cdf8ead6517fe0166d47385767ec.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: a06ee7a4-0629-4bc3-ad24-08dbbf859822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VIJ4p2ZVWQAWV2MzX/OOdVhnYm+4IuyNWXzBq7XoFDxjKrfXOqAGyiv0csY17fS7Lwwe/WSv1gKRpa34+foq6WmOAC+8JdEzqVK2QO98C/9RIYagFyxh9y7vygslxQFR5vaVITPqQYrqeds00OYUwPJAYT/9OzADowDF07FqlUULC1KLFoNycZFvDh/yy5R18b6gnI7UOdInPK3bu6wMv5n1NPwOLRtRb0C1nQD5Wwa3uUzqe4D0bfIsLYod61R3ZYShODbefvG+E5fGXQXGaxhUSuYjeGmfd8rZFPDR9yWhIZgKDXZR5BQABZStznPKUTm4w5o36T8mV5YxuSNayzLdb6AnT7nNodtRclHooDwdZXJwjM+4HnboHwGdTmPnCyywHKRGTqvxFv+TJ1VVYFixIm8r84eJyEFLI1xwxlnJZ44RVYccCIGTMVXgI5QodrAqjntvjl3tEDNXQtqb4HLkCPh/UfvdH4shMgIjXs8fr52syfAugut44ifm1WD7omW/45yRpoFGOKEsjSydArgGSmJArIFdM9Qq6Wyvl2jLRZg/WqhW4k01KLugXKnaNssNoRWoquLAlKZxnQ59PB2jGFd3c2wBfD0ZLKwu2QDWpN+KCv86wvDBD4fdqsGgdBJETQaHGrWW/uMo23DzB/vKfJEZ/w7pSzfAHI0SSyEoG5/BdFBzOJr2VdN494Z8DWUNnFTIktLi9M6Mn4ozO7B4pYlhgIk4My4a0NB7UZfx+DwV1LSCh+FE4VHRL0q8QVdTNKWK8Du6VE9E46hk8Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(40480700001)(66899024)(336012)(426003)(2906002)(41300700001)(2876002)(83380400001)(86362001)(40460700003)(6666004)(82740400003)(478600001)(36756003)(81166007)(356005)(9686003)(54906003)(316002)(55446002)(70586007)(110136005)(70206006)(7416002)(4326008)(26005)(8676002)(8936002)(5660300002)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:30.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06ee7a4-0629-4bc3-ad24-08dbbf859822
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Add a new API to create/modify/remove RSS contexts, that passes in the
 newly-chosen context ID (not as a pointer) rather than leaving the
 driver to choose it on create.  Also pass in the ctx, allowing drivers
 to easily use its private data area to store their hardware-specific
 state.
Keep the existing .set_rxfh_context API for now as a fallback, but
 deprecate it.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 40 ++++++++++++++++++++++++---
 net/core/dev.c          | 15 ++++++++---
 net/ethtool/ioctl.c     | 60 ++++++++++++++++++++++++++++++-----------
 3 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 229a23571008..975fda7218f8 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -747,10 +747,33 @@ struct ethtool_mm_stats {
  * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
  *	hash key, and/or hash function assiciated to the given rss context.
  *	Returns a negative error code or zero.
- * @set_rxfh_context: Create, remove and configure RSS contexts. Allows setting
+ * @create_rxfh_context: Create a new RSS context with the specified RX flow
+ *	hash indirection table, hash key, and hash function.
+ *	Arguments which are set to %NULL or zero will be populated to
+ *	appropriate defaults by the driver.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that the indir table, hkey and hfunc are not yet populated as
+ *	of this call.  The driver does not need to update these; the core
+ *	will do so if this op succeeds.
+ *	If the driver provides this method, it must also provide
+ *	@modify_rxfh_context and @remove_rxfh_context.
+ *	Returns a negative error code or zero.
+ * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
  *	the contents of the RX flow hash indirection table, hash key, and/or
- *	hash function associated to the given context. Arguments which are set
- *	to %NULL or zero will remain unchanged.
+ *	hash function associated with the given context.
+ *	Arguments which are set to %NULL or zero will remain unchanged.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
+ *	note that it will still contain the *old* settings.  The driver does
+ *	not need to update these; the core will do so if this op succeeds.
+ *	Returns a negative error code or zero. An error code must be returned
+ *	if at least one unsupported change was requested.
+ * @remove_rxfh_context: Remove the specified RSS context.
+ *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
+ *	Returns a negative error code or zero.
+ * @set_rxfh_context: Deprecated API to create, remove and configure RSS
+ *	contexts. Allows setting the contents of the RX flow hash indirection
+ *	table, hash key, and/or hash function associated to the given context.
+ *	Arguments which are set to %NULL or zero will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
  * @get_channels: Get number of channels.
@@ -901,6 +924,17 @@ struct ethtool_ops {
 			    const u8 *key, const u8 hfunc);
 	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
 				    u8 *hfunc, u32 rss_context);
+	int	(*create_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const u32 *indir, const u8 *key,
+				       const u8 hfunc, u32 rss_context);
+	int	(*modify_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       const u32 *indir, const u8 *key,
+				       const u8 hfunc, u32 rss_context);
+	int	(*remove_rxfh_context)(struct net_device *,
+				       struct ethtool_rxfh_context *ctx,
+				       u32 rss_context);
 	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
 				    const u8 *key, const u8 hfunc,
 				    u32 *rss_context, bool delete);
diff --git a/net/core/dev.c b/net/core/dev.c
index 05e95abdfd17..637218adca22 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10882,16 +10882,23 @@ static void netdev_rss_contexts_free(struct net_device *dev)
 	struct ethtool_rxfh_context *ctx;
 	unsigned long context;
 
-	if (dev->ethtool_ops->set_rxfh_context)
+	if (dev->ethtool_ops->create_rxfh_context ||
+	    dev->ethtool_ops->set_rxfh_context)
 		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
 			u32 *indir = ethtool_rxfh_context_indir(ctx);
 			u8 *key = ethtool_rxfh_context_key(ctx);
 			u32 concast = context;
 
 			xa_erase(&dev->ethtool->rss_ctx, context);
-			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
-							   ctx->hfunc, &concast,
-							   true);
+			if (dev->ethtool_ops->create_rxfh_context)
+				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
+								      context);
+			else
+				dev->ethtool_ops->set_rxfh_context(dev, indir,
+								   key,
+								   ctx->hfunc,
+								   &concast,
+								   true);
 			kfree(ctx);
 		}
 	xa_destroy(&dev->ethtool->rss_ctx);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1d13bc8fbb75..c23d2bd3cd2a 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1274,7 +1274,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !ops->set_rxfh_context)
+	if (rxfh.rss_context && !(ops->create_rxfh_context ||
+				  ops->set_rxfh_context))
 		return -EOPNOTSUPP;
 	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
@@ -1349,8 +1350,24 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 		ctx->indir_size = dev_indir_size;
 		ctx->key_size = dev_key_size;
-		ctx->hfunc = rxfh.hfunc;
 		ctx->priv_size = ops->rxfh_priv_size;
+		/* Initialise to an empty context */
+		ctx->indir_no_change = ctx->key_no_change = 1;
+		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
+		if (ops->create_rxfh_context) {
+			u32 limit = dev->ethtool->rss_ctx_max_id ?: U32_MAX;
+			u32 ctx_id;
+
+			/* driver uses new API, core allocates ID */
+			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
+				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
+			if (ret < 0) {
+				kfree(ctx);
+				goto out;
+			}
+			WARN_ON(!ctx_id); /* can't happen */
+			rxfh.rss_context = ctx_id;
+		}
 	} else if (rxfh.rss_context) {
 		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
 		if (!ctx) {
@@ -1359,15 +1376,34 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
-	if (rxfh.rss_context)
-		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
-					    &rxfh.rss_context, delete);
-	else
+	if (rxfh.rss_context) {
+		if (ops->create_rxfh_context) {
+			if (create)
+				ret = ops->create_rxfh_context(dev, ctx, indir,
+							       hkey, rxfh.hfunc,
+							       rxfh.rss_context);
+			else if (delete)
+				ret = ops->remove_rxfh_context(dev, ctx,
+							       rxfh.rss_context);
+			else
+				ret = ops->modify_rxfh_context(dev, ctx, indir,
+							       hkey, rxfh.hfunc,
+							       rxfh.rss_context);
+		} else {
+			ret = ops->set_rxfh_context(dev, indir, hkey,
+						    rxfh.hfunc,
+						    &rxfh.rss_context, delete);
+		}
+	} else {
 		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
+	}
 	if (ret) {
-		if (create)
+		if (create) {
 			/* failed to create, free our new tracking entry */
+			if (ops->create_rxfh_context)
+				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
 			kfree(ctx);
+		}
 		goto out;
 	}
 
@@ -1383,12 +1419,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
 	/* Update rss_ctx tracking */
-	if (create) {
-		/* Ideally this should happen before calling the driver,
-		 * so that we can fail more cleanly; but we don't have the
-		 * context ID until the driver picks it, so we have to
-		 * wait until after.
-		 */
+	if (create && !ops->create_rxfh_context) {
+		/* driver uses old API, it chose context ID */
 		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
 			/* context ID reused, our tracking is screwed */
 			kfree(ctx);
@@ -1400,8 +1432,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			kfree(ctx);
 			goto out;
 		}
-		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
-		ctx->key_no_change = !rxfh.key_size;
 	}
 	if (delete) {
 		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);

