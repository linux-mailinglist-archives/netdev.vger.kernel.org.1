Return-Path: <netdev+bounces-33256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B879D37E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F1D281DAC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE018C07;
	Tue, 12 Sep 2023 14:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5D18C05
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:22:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E045110
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbfRkWKMukW1pBn3IV5vE5ba1J82N4o9/ZkikX5l+E9X1XHQS7wLsPbgDSbC9e1aA9p8GW0VZ80Z/iNcY1TWXH/f4eUiX64CktO/sEJJElTiJi1B3JuIsSr3mE0hhJ3akaYVsU+vu5RykJRHiS9YOvf9Lf3pekzMQDa3MrYQM8PESGcACFgqhAXghe0K8gPNsEAmzcgsPj+1/cXs8eEK0riD/WvKHYYm66v5DM63mN7V9eRH9iFQHsNwydB85y5v6MKMhfv0GCTRGOBXZnJhI5tGR9ugmeBbFp3xfQpGqPVnGa5qnUBdjPbpgHelWfiEZDYFHnsJjJMi8oA0cjB/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkPZIOvLmcamijvDNSr4ylLqPQE0tipxzzi5aW58+3I=;
 b=SFskCVs2H0I1FguBhVuqGze3wZ1MjJZ9W4XkdOUrixa+kub6C8kAjXyj8qSzSlQisO2hljTunNVqlvPPB4vFp4D4Wn+IAwt4UCbHv/HA/d5+9vgVsXDq5dclR8HrItG5iN5b6m0XrEM+1QSNUn25nz7qJXOfjbsJ/eNZrAuDxFyEY59fxnQTsoQ139byAUBcaGgG6yqo2PawN5oJvF10LmcAtBYt0VMSKHgf5MTklSLw2J9HBJpKDI0gGafKSdKyE3P/KpvBNz4zeIOIwHYbZx3VLHqIxIVlbBBMIEUV26LGG5wqJ1LefgVC2OH+Aec1qT4QLDVvyGaOufcmjAr+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkPZIOvLmcamijvDNSr4ylLqPQE0tipxzzi5aW58+3I=;
 b=j5lBCwzuURSvsnKB071gb1SZxP9LQ+IkefTjPVmcGFiu5ZYUvn+4/WR+OqOU6vdWOsxKclAb/tw7yXDzqina1d6ev3zWZLbIXhsATVjSFCpWXyWwNynE4bDiKhSOXKtYP2ITPWwnPvNEvPz+8pa0emclIKEOhEPmSulmxGUOtzU=
Received: from CH2PR15CA0001.namprd15.prod.outlook.com (2603:10b6:610:51::11)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 14:22:28 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::b2) by CH2PR15CA0001.outlook.office365.com
 (2603:10b6:610:51::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.41 via Frontend
 Transport; Tue, 12 Sep 2023 14:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Tue, 12 Sep 2023 14:22:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 09:22:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 12 Sep
 2023 07:22:27 -0700
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 12 Sep 2023 09:22:25 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
Subject: [RFC PATCH v3 net-next 3/7] net: ethtool: record custom RSS contexts in the IDR
Date: Tue, 12 Sep 2023 15:21:38 +0100
Message-ID: <455d409bd1f54dcf552c6c60c46167ea726bbab5.1694443665.git.ecree.xilinx@gmail.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: bce80659-563b-4915-07aa-08dbb39bb177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bGYY3BGaS0BcGYUmdusRbWPhClrRxK6E7oM9yz8ykVk3CQ8Snl6meDju3thMyPNwwUIFLs1HiRK7wjte6LGJW5GhcPCYXOWtQhpb9xP8CHbRDsAT+FgCweWjPXxWSFpUbpe+x2iyCb+Gr4+M0KwPcHVGAWCXjYNfDUnt4modx36HWAgquHQhrGepq8A+rsXYrVXjT/ZRvGUv9TGBqK3v1PqcosSePwFxSvepZIx8EAdfGR8sggSD7pDaRdNWRX0YZeG2sVxQZpquCFtcQgrh8jRYhH+BknOH03JqLFFMW4NtJq5q8dosNlOo1R4tTIFbOhVw3LnJQWkmfCJtb9ESV5QliRwUXoiaJXH9KgZHxdwUR1og0BLmL2cFCG7SFSBMVsxT7NwIoT6OOWOf/BUVA6mYrk+cnD0poPPbZ5S/DKf65DvihrXZNOE9d8XhK6vjbnyH+te4bDXVQpmMYCrwylUJ7SNKLNuL++U7VMmdKH9HbzVZMRvMB2JEmMSO47a/zgVdlvkbweWt7t0OxrrD6oe4FGSYx9/RtRICPNdQf6cZLYKxJ87VnftXAXL8efeWvw+kv1igChls00h59rXx2Wtzy5eVXO3Yb3zfusvAEvRDdGzwAN46weAdsZzpDC4d5eM2iGltaeEPL6t5s8U9BEczM7WiVJhmSd5punnJ8eHXE+/qpYkUguQjVSpnM8m8hYCOhqGnbdXWEZ9Qe6rVHHx2cPMQSf0cFw/N+yK0ow83wlOFXGXF45BTpjKlirry5x5k9RGd1gCe8exBqRy1cA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(8676002)(86362001)(8936002)(66899024)(40480700001)(55446002)(5660300002)(4326008)(2906002)(40460700003)(2876002)(36756003)(9686003)(82740400003)(6666004)(356005)(426003)(336012)(7416002)(81166007)(70586007)(478600001)(26005)(47076005)(36860700001)(83380400001)(54906003)(110136005)(41300700001)(70206006)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:22:28.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce80659-563b-4915-07aa-08dbb39bb177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

From: Edward Cree <ecree.xilinx@gmail.com>

Since drivers are still choosing the context IDs, we have to force the
 IDR to use the ID they've chosen rather than picking one ourselves.

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 include/linux/ethtool.h | 14 ++++++++
 net/ethtool/ioctl.c     | 71 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index c770e32d79e6..f7317b53ab61 100644
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
index de78b24fffc9..db596b61c6ab 100644
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
+		ctx = idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context);
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
@@ -1351,6 +1382,42 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
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
+		if (WARN_ON(idr_find(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
+			/* context ID reused, our tracking is screwed */
+			kfree(ctx);
+			goto out;
+		}
+		/* Allocate the exact ID the driver gave us */
+		WARN_ON(idr_alloc(&dev->ethtool->rss_ctx, ctx, rxfh.rss_context,
+				  rxfh.rss_context + 1, GFP_KERNEL) !=
+			rxfh.rss_context);
+		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
+		ctx->key_no_change = !rxfh.key_size;
+	}
+	if (delete) {
+		WARN_ON(idr_remove(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
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

