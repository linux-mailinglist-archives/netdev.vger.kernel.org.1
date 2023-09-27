Return-Path: <netdev+bounces-36607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0944A7B0BC9
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B0C6C285316
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A824CFB6;
	Wed, 27 Sep 2023 18:14:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1BD4CFA4
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C6910E
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcIXhMGOqvU1I/9nSwmMN4XVZLIgCIoedmaXjwXkl9s92AnKmeqlS8OlVOFqI/kciCDS35g+K+6wiC+OZEd2zcTDsylaCsAP447m1mIVjyq6HKs2bT1qWB4Ii5uqR3Lhoa/y20l5BECC9UCwAD4oCYa5h3KhS62yDZ9oJ85+4ZKx2RBvAfV+bY/J/0OgPWr1fMwBUWO+dby9qWTef7iJHn7jd+IRyQ572xDpBM/HqRnAhaxtMtszACbQJ9lQPCdjgozzMCjPOCOvwBhaPDJEc8kxiDzSkNJKTbBmBxL1qTYt7s4c2Bb6wyXurYFMr6+dkxd7JiCu2vvHlmvn/bUbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52p/798zbF3BF0+uj64akK/35N7ptMmGuo9L+VOmIuM=;
 b=PR05AKxfA0knK3pdjht4I3HqBsxDYSlXyg/nv7xAO725+jiPO0r3Krh8XEQSSMr+tcuakg81NC8hqgIvXH87ZQkqP75ezJBHtIrJ+gb9ZG5t8Wfm6detPFsapyRiz8rzCmWt5I/ycUuq/683LrWSj+gnrW83VB9/OoTp1a/YXgXDTRqGOLn2X2fWAlT5DTiRLrTO3HrRGPK+0Ts1OqTCVtzz6Th+biHqMwqfPy5FWpIXUlOyywHZYOIQ8hSPrlBQ7UWPjI7hueTRXdO/svDNmmB52Z+IYK8qW4TgwABMdYLl05pAPQnrVKtwBRkVJplIii7OyNbsvptMUe/s5QHhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52p/798zbF3BF0+uj64akK/35N7ptMmGuo9L+VOmIuM=;
 b=b1mUFy3kSmfIIZe+qb5fyzMtkZzgiixSPOaTmr+DRkWDoF+UPu6MWdaj6FrwFFtm/6pRcb/kR1RCUA8Zd43V19m2Tlw7xmO5rhtSYsMtfjyaJV0M1ylbKTZx/9EX2eoBWhjujFHAND/lEP0paES2LYwmrV674XjRYMFoQFyWc+0=
Received: from DM6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:5:14c::45)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:14:31 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::a9) by DM6PR11CA0068.outlook.office365.com
 (2603:10b6:5:14c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:29 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 11:14:27 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:25 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [PATCH v4 net-next 3/7] net: ethtool: record custom RSS contexts in the XArray
Date: Wed, 27 Sep 2023 19:13:34 +0100
Message-ID: <97db46739ad095e0ed50f0dbd90e1b506c2991de.1695838185.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: ca15b160-47fd-4f99-0a2a-08dbbf8597f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jGboHPJJ+W7iJI2bkEKIrv3Olg78D08V2vo+EflvoGtOEI9+rROd7iOjNt61jpfVI3eb2abWtcMwVGTQjFw+OFsq32mzlUpWoyts+kjhPBpko4VnTO+5mwFsPO/5E0Iy1EQyv7vk/naFi3GGGDhOBnACA0F77v9DlIih/laZMj7aMqzwghAgXANhQSgJrNpa+HwHkl2tkzL2CgXjaEzuyFpw3O4Sv3qCGdUWAhhmLOPamXN6qmlUtIDokSoWi2QLEVE/lPL+0kSZsBV9SYFCqzd077fgvKo+rpUG7y9HTCDRPEXUoQdLip5PWhhsZFfm4BtOGH0U0kmgfts3E3EiavdwkDh+DdxqEzPjVn1NJACGdB054TYaORVUiO09by3Ftg1G8M6dUwxs5rYDClJXWkGyZVtYcvNuMteBpqVftUr5YdxZ6r4ysSYmrq6Va8C1kjWX0E5xrcISN/0ENbBejNrgEHdoZ3U/Sg84jMzAKWK4ASulMKg6kGEmXVuJ4D783XO6M+B6tXE3GG4zBsB2QB86vC1g/cHieFIQc/PY243vVWe/OoYoQIF22Pegh+T4d7dKgohnT7LBB8j0JhkwW2d+U1C6Ao8WqAmW77WsrSiuD/g/QG4VAMwAwGgbVErH7x0OtO5cwSg3U68UrSbvmT5L9CJ4Ah6cGoNmBZCCCjOW32GT0Zr7BMDqkxvIXFl/IsadN42nMUQfjseDuXkVE+7H++QxnDizkQh2ITvKAUbM9m/F/kVwgdCQYaCFOwv2CCQ2pv34fr3zGJjQj9BahA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(40470700004)(36840700001)(46966006)(2876002)(66899024)(40460700003)(356005)(2906002)(47076005)(478600001)(82740400003)(36756003)(336012)(6666004)(26005)(86362001)(426003)(83380400001)(9686003)(81166007)(55446002)(40480700001)(36860700001)(8936002)(41300700001)(4326008)(316002)(8676002)(5660300002)(70206006)(7416002)(70586007)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:29.5074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca15b160-47fd-4f99-0a2a-08dbbf8597f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

Since drivers are still choosing the context IDs, we have to force the
 XArray to use the ID they've chosen rather than picking one ourselves,
 and handle the case where they give us an ID that's already in use.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 14 ++++++++
 net/ethtool/ioctl.c     | 73 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index bb11cb2f477d..229a23571008 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -194,6 +194,17 @@ static inline u8 *ethtool_rxfh_context_key(struct ethtool_rxfh_context *ctx)
 	return (u8 *)(ethtool_rxfh_context_indir(ctx) + ctx->indir_size);
 }
 
+static inline size_t ethtool_rxfh_context_size(u32 indir_size, u32 key_size,
+					       u16 priv_size)
+{
+	size_t indir_bytes = array_size(indir_size, sizeof(u32));
+	size_t flex_len;
+
+	flex_len = size_add(size_add(indir_bytes, key_size),
+			    ALIGN(priv_size, sizeof(u32)));
+	return struct_size((struct ethtool_rxfh_context *)0, data, flex_len);
+}
+
 /* declare a link mode bitmap */
 #define __ETHTOOL_DECLARE_LINK_MODE_MASK(name)		\
 	DECLARE_BITMAP(name, __ETHTOOL_LINK_MODE_MASK_NBITS)
@@ -731,6 +742,8 @@ struct ethtool_mm_stats {
  *	will remain unchanged.
  *	Returns a negative error code or zero. An error code must be returned
  *	if at least one unsupported change was requested.
+ * @rxfh_priv_size: size of the driver private data area the core should
+ *	allocate for an RSS context.
  * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
  *	hash key, and/or hash function assiciated to the given rss context.
  *	Returns a negative error code or zero.
@@ -824,6 +837,7 @@ struct ethtool_ops {
 	u32     cap_link_lanes_supported:1;
 	u32	supported_coalesce_params;
 	u32	supported_ring_params;
+	u16	rxfh_priv_size;
 	void	(*get_drvinfo)(struct net_device *, struct ethtool_drvinfo *);
 	int	(*get_regs_len)(struct net_device *);
 	void	(*get_regs)(struct net_device *, struct ethtool_regs *, void *);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index de78b24fffc9..1d13bc8fbb75 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1249,6 +1249,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 {
 	int ret;
 	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxfh_context *ctx = NULL;
 	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	u32 dev_indir_size = 0, dev_key_size = 0, i;
@@ -1256,7 +1257,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	u8 *hkey = NULL;
 	u8 *rss_config;
 	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
-	bool delete = false;
+	bool create = false, delete = false;
 
 	if (!ops->get_rxnfc || !ops->set_rxfh)
 		return -EOPNOTSUPP;
@@ -1275,6 +1276,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	/* Most drivers don't handle rss_context, check it's 0 as well */
 	if (rxfh.rss_context && !ops->set_rxfh_context)
 		return -EOPNOTSUPP;
+	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
 
 	/* If either indir, hash key or function is valid, proceed further.
 	 * Must request at least one change: indir size, hash key or function.
@@ -1332,13 +1334,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		}
 	}
 
+	if (create) {
+		if (delete) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ctx = kzalloc(ethtool_rxfh_context_size(dev_indir_size,
+							dev_key_size,
+							ops->rxfh_priv_size),
+			      GFP_KERNEL_ACCOUNT);
+		if (!ctx) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ctx->indir_size = dev_indir_size;
+		ctx->key_size = dev_key_size;
+		ctx->hfunc = rxfh.hfunc;
+		ctx->priv_size = ops->rxfh_priv_size;
+	} else if (rxfh.rss_context) {
+		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
+		if (!ctx) {
+			ret = -ENOENT;
+			goto out;
+		}
+	}
+
 	if (rxfh.rss_context)
 		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
 					    &rxfh.rss_context, delete);
 	else
 		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
-	if (ret)
+	if (ret) {
+		if (create)
+			/* failed to create, free our new tracking entry */
+			kfree(ctx);
 		goto out;
+	}
 
 	if (copy_to_user(useraddr + offsetof(struct ethtool_rxfh, rss_context),
 			 &rxfh.rss_context, sizeof(rxfh.rss_context)))
@@ -1351,6 +1382,44 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		else if (rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE)
 			dev->priv_flags |= IFF_RXFH_CONFIGURED;
 	}
+	/* Update rss_ctx tracking */
+	if (create) {
+		/* Ideally this should happen before calling the driver,
+		 * so that we can fail more cleanly; but we don't have the
+		 * context ID until the driver picks it, so we have to
+		 * wait until after.
+		 */
+		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
+			/* context ID reused, our tracking is screwed */
+			kfree(ctx);
+			goto out;
+		}
+		/* Allocate the exact ID the driver gave us */
+		if (xa_is_err(xa_store(&dev->ethtool->rss_ctx, rxfh.rss_context,
+				       ctx, GFP_KERNEL))) {
+			kfree(ctx);
+			goto out;
+		}
+		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
+		ctx->key_no_change = !rxfh.key_size;
+	}
+	if (delete) {
+		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
+		kfree(ctx);
+	} else if (ctx) {
+		if (indir) {
+			for (i = 0; i < dev_indir_size; i++)
+				ethtool_rxfh_context_indir(ctx)[i] = indir[i];
+			ctx->indir_no_change = 0;
+		}
+		if (hkey) {
+			memcpy(ethtool_rxfh_context_key(ctx), hkey,
+			       dev_key_size);
+			ctx->key_no_change = 0;
+		}
+		if (rxfh.hfunc != ETH_RSS_HASH_NO_CHANGE)
+			ctx->hfunc = rxfh.hfunc;
+	}
 
 out:
 	kfree(rss_config);

