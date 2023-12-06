Return-Path: <netdev+bounces-54475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F7807372
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9237B282027
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2087F3FB1A;
	Wed,  6 Dec 2023 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="ousmG7RD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296C9A
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 07:12:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK3w7Zr5hQNfH+I74sftGxnZe+aRflyifiM7M6Yh+bY63iBsfXBsRtU0gx9uTHtPNb9y1WQySoSCFHdoNY2DFfeyni1JkRYqftCfSjxx4WERuICw369CjHlR8Ltz3MXHZZpcwpt6RK/KeGBwMsaRr3s41bN/DegGFEXVIYugRFxbAGIis6EUf1P7H34fdQo4gT6qKnhff2lZ2LjmuHnGCqGxpImm4KzLF7C02zOLYcgUioBh6jdGQKpDI/9mjsBdnMcwr2JvwDM/2FV0Usy84KAEUQHTH/x+HgXJNLw/NdYdYf2IK0VMf/7OL5j8JH/6wDcp+FanCzLLHbZOkFAZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW/C7+foUK/ndC0yIcE7/15U6ZeLv3qiGFntEWfMeOM=;
 b=nPka8Z/s5/ivdcESUHBlJkHw1B3o/ctZPb6F59YfeLDzqyV8XPHtWfGZfYEDxzPqj26y5h683osoS+WP5T2KZDMW/al3IB6SLzmOFG9OUYVtBlkBha2aBQ5cb+s8dJVhY407ned5NI5FmJeptEqkH03XoV/qD3MOL+OoUX2w8pD7Q4PZiA4XAy6OALOGdAxmY823ng+WS/kXNl8wzxPofKoARkAThSop+hYKAOhEb8ESVMVLssj2xPg3DKalamxYN7IrdVmOB8nY5MojBrczc+ZyXoLxfDKqX/UHgJ3RmuWPd44J4gu0RMPEeB1SBpQtyJ3v3TqTEsIbeSZWWpzB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW/C7+foUK/ndC0yIcE7/15U6ZeLv3qiGFntEWfMeOM=;
 b=ousmG7RD0jX6BFZdJVyDM0jRFqzpTocKK/BNihAmxuuAjyrat/i8l0aUdSDKS5JokC/qnAdzf9RhGFT8XbxS57TSou1Zf/LFyBTEjuRMWVBUGkjDQF2SPYyrSS6GvASh5bXpog0Ny+/KkgiXd6Tx21PgYp98pmzXIHHXfMVkEts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by LV8PR13MB6421.namprd13.prod.outlook.com (2603:10b6:408:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 15:12:33 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 15:12:33 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ryno Swart <ryno.swart@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next 1/2] nfp: ethtool: add extended ack report messages
Date: Wed,  6 Dec 2023 17:12:08 +0200
Message-Id: <20231206151209.20296-2-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206151209.20296-1-louis.peens@corigine.com>
References: <20231206151209.20296-1-louis.peens@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0008.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:70::10)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|LV8PR13MB6421:EE_
X-MS-Office365-Filtering-Correlation-Id: 41b3a321-afb2-4196-1801-08dbf66dc5c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ral6GYyKGZp63opQLMmzeAjTVBih7BN2iTHleGd9DlMKzD5yWytANeoBUlYmDkmQ1TQkZooZNO85+AIRE6Y6ItS+yF1UG6zJyXr6V2MQSkEIdui4mbKFMyWP8AfRfChmK5qWFMh96k7EnhFtrZrz2tpOXWFSEktuIdjf5x+FppzJ9ALwD2dlLh1fIcmHxLJmL+nTeydbUvi2k0roF9PtCxYfWgF6EDa9pQGZCvFptAIy4Zmpkl1KdGksErxdT0pBplKlErVe9uopF1+WYe41QQcNfDSeQWMh34sB+ivEEsJ5UkWkopYnEulqMlwW9OEX/CB+drcJZcWhNrfKeFXvvXeyxFXSG69kTOEVxjZKZg6ft0lGjVFunma/vN5aSJUdkmwuJUoqF6DcpvOYRBIYZcJGgTSZ692PecT1G4acRqWjNxHMqU4WxPAvosksPL+0976CRFyu7dqPe6E29o2aw0yLsHdkrTpuqcwu8LpSobdTgfi2oQqT9UASQtRQghdqwFPpm6iqyz/P59jwJe5bFk1BKP+XDrbpGWJGLkXy9D8G9zwjV/Uq/yuIQx/v5Knmx55y8xSMsRlxSIuypamzTDupxseZM92g6/9D6rLachWkfYLzpwsktXB/WksPPmAYFde8ZwT5U5RubFQX67zEiD1/K7dZbMRJuaTBnrxq0PHz8tkhFzxVeM/WFYfXd3lC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38350700005)(4326008)(6512007)(52116002)(478600001)(8676002)(8936002)(26005)(107886003)(2616005)(1076003)(6506007)(6666004)(66476007)(110136005)(66946007)(66556008)(316002)(83380400001)(15650500001)(36756003)(6486002)(38100700002)(5660300002)(2906002)(86362001)(41300700001)(44832011)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2NkrAjY7VfmRhIZwFhJMuKDIY5OmPDsM9YhwWoyw5TgUzSsR1D7viWH4iq9y?=
 =?us-ascii?Q?qPwxOBEcKJwIjK1vo0RAtUU2E6UECh3m90vBSys7QA7YPlyXKZlNXmbgQW5l?=
 =?us-ascii?Q?H/ya6M2V79VPI4jwAyiEb/hGG8GtUT05KaSGwNM1Bt7asQdZIZwHMamjPrk1?=
 =?us-ascii?Q?pOVycmpQwsiGbf2DKZjlPtvhg6Elmmd6SVYzqhezgaHvqmjs8PUnpHlqZidK?=
 =?us-ascii?Q?oh6qKqM1JoYIPWDkJjAgVi591Lz9LVlh4V3TWAIugUoxBAokBkATNwuEd30h?=
 =?us-ascii?Q?rTiiLPKbkJSjRCMDhFdRleQ3maHVElj46D/hymKgyqfTeXukncTOyGAEvrm5?=
 =?us-ascii?Q?abL9qDNhrfnJddCOAAcasxx53IsB5RyEHR8Tg6O4FggEq+Khs4PH2xyf6n+X?=
 =?us-ascii?Q?PHddVs5mGfcp0LLeZ1FDFe+Zblk2SXm+aToawuit6y5GMClWwzWJoqs3WY1Z?=
 =?us-ascii?Q?oOg/JemhTid8MbcidpyQw/9maKFLNapuI9AL4GjnNeB9nAJauGuCwwPV0nyG?=
 =?us-ascii?Q?2x3+MaPgGSieLHQAO3fbHKiP2jvS7k+sgHrQzidh9/sQobg9+L72wq9hMUcz?=
 =?us-ascii?Q?ShgCGScJB/bHa6u+eSw7txvk8q7qM8KrEPCpaT6KJ/x96+/0azCB4oGf8Ywt?=
 =?us-ascii?Q?ciaNt8pIN1gVCqgctmvqQrebBwaK0v1rniBn0RItdoTnMIrR93NDd2126Ko2?=
 =?us-ascii?Q?KPkBs1Zkln048zDgCaq1aoBUGGTM7O29Y+c7srzzLa4eS/z3WBU6Si8eDae+?=
 =?us-ascii?Q?vFvArrMdldQ4V5vVoBulAiauKTmgfiurxirXZUrODtbVVL1FdVbDvXXUXuKu?=
 =?us-ascii?Q?dgg3bEx6Ms0/LfZaZTBkgz1g+sbKrwx2c7mDORwa2Wz9QSdM7F+Xz9oBeh4+?=
 =?us-ascii?Q?WuRIWnQUYdK8swZK5fGuvj1p2Zk9ph2UQ8GE3iTC6P/uD3rh/rLX1TRCle6W?=
 =?us-ascii?Q?69yMaCQwm0kPMBlTilvs/BgjrDj0S+Ohur3RH+0MqO3qUad5fAbbZkL/lxs4?=
 =?us-ascii?Q?V5sJ78VNueyKyFa8iniV4m+agtOoidvixzVKsxEkjExVfsYVGHvwKx/FObEs?=
 =?us-ascii?Q?BQDeoqtq28Ez0cUbNW5ZlFJqRN5bbfpGx0Ptn2Hd+IZSdDcjlDquidX5OVwM?=
 =?us-ascii?Q?VRfIJ6yFdkEg/wvM/KIHuv/htFBKysBnqnDulOVZ6vIQiy5gbmE0JhBI/uBI?=
 =?us-ascii?Q?hNFArxmGZNe37Z9GWyGJVNXBHsaVDgS0XA8dzSQNKJa/CZz3TH2dapMNRnR8?=
 =?us-ascii?Q?3ZkOqyKzN+sUkuzEcCn8mli52jlM2fjchqOelqJOtTnURD/U/30ukIE0XWdy?=
 =?us-ascii?Q?TpLTuLMwaPLcYj9mA2TKBzJiUgqas0Mj8ci8vIHcs/cmljG5p3BdDTyqbqOo?=
 =?us-ascii?Q?NJwy/5nCHywqMAZv1e/1hPK53sxVh6oUkKW4m5p3dwt8f7j2ydZqwk2ypJBL?=
 =?us-ascii?Q?03qj94Jtd0vP+4uU6bbkdtluhmIotG2/VUMNtXZcoa70Zn9Si4C3xWs1Rifi?=
 =?us-ascii?Q?XRNDlbWi1E1kQYulq2OG7za6Hvf+AWukS4MQJCe7QT7Ad/1sPEKm8XMy+uKd?=
 =?us-ascii?Q?GplaQGd0ttRgw6aJ0B9Sfa2mcjLZl/XZYL84w3FJw+oD8/a+4z/8/OV6BmQR?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41b3a321-afb2-4196-1801-08dbf66dc5c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:12:33.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEqLhnxZfbpQJNFi0+GKCMaC03qFZvPnm+ciaC5UF877bWeYAu0EkPnvnU3/rza27guifEQsbh8pecvI/W+o4hcvBJsdv/+nmvnfNAID7h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6421

From: Ryno Swart <ryno.swart@corigine.com>

Add descriptive error messages to common ethtool failures to be more
user friendly.

Update `nfp_net_coalesce_para_check` to only check one argument, which
facilitates unique error messages.

Additionally, three error codes are updated to `EOPNOTSUPP` to reflect
that these operations are not supported.

Signed-off-by: Ryno Swart <ryno.swart@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_net.h  |  4 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  6 ++-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  | 53 ++++++++++++++-----
 3 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net.h b/drivers/net/ethernet/netronome/nfp/nfp_net.h
index bd0e26524417..46764aeccb37 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net.h
@@ -966,9 +966,9 @@ static inline bool nfp_netdev_is_nfp_net(struct net_device *netdev)
 	       netdev->netdev_ops == &nfp_nfdk_netdev_ops;
 }
 
-static inline int nfp_net_coalesce_para_check(u32 usecs, u32 pkts)
+static inline int nfp_net_coalesce_para_check(u32 param)
 {
-	if ((usecs >= ((1 << 16) - 1)) || (pkts >= ((1 << 16) - 1)))
+	if (param >= ((1 << 16) - 1))
 		return -EINVAL;
 
 	return 0;
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index ac1f4514b1d0..dcd27ba2a74c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1176,7 +1176,8 @@ static void nfp_net_rx_dim_work(struct work_struct *work)
 	 * count.
 	 */
 	factor = nn->tlv_caps.me_freq_mhz / 16;
-	if (nfp_net_coalesce_para_check(factor * moder.usec, moder.pkts))
+	if (nfp_net_coalesce_para_check(factor * moder.usec) ||
+	    nfp_net_coalesce_para_check(moder.pkts))
 		return;
 
 	/* copy RX interrupt coalesce parameters */
@@ -1205,7 +1206,8 @@ static void nfp_net_tx_dim_work(struct work_struct *work)
 	 * count.
 	 */
 	factor = nn->tlv_caps.me_freq_mhz / 16;
-	if (nfp_net_coalesce_para_check(factor * moder.usec, moder.pkts))
+	if (nfp_net_coalesce_para_check(factor * moder.usec) ||
+	    nfp_net_coalesce_para_check(moder.pkts))
 		return;
 
 	/* copy TX interrupt coalesce parameters */
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index 200b3588363c..f4f6153cae0f 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -633,7 +633,8 @@ static void nfp_net_get_ringparam(struct net_device *netdev,
 	ring->tx_pending = nn->dp.txd_cnt;
 }
 
-static int nfp_net_set_ring_size(struct nfp_net *nn, u32 rxd_cnt, u32 txd_cnt)
+static int nfp_net_set_ring_size(struct nfp_net *nn, u32 rxd_cnt, u32 txd_cnt,
+				 struct netlink_ext_ack *extack)
 {
 	struct nfp_net_dp *dp;
 
@@ -644,7 +645,7 @@ static int nfp_net_set_ring_size(struct nfp_net *nn, u32 rxd_cnt, u32 txd_cnt)
 	dp->rxd_cnt = rxd_cnt;
 	dp->txd_cnt = txd_cnt;
 
-	return nfp_net_ring_reconfig(nn, dp, NULL);
+	return nfp_net_ring_reconfig(nn, dp, extack);
 }
 
 static int nfp_net_set_ringparam(struct net_device *netdev,
@@ -657,7 +658,7 @@ static int nfp_net_set_ringparam(struct net_device *netdev,
 
 	/* We don't have separate queues/rings for small/large frames. */
 	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	qc_min = nn->dev_info->min_qc_size;
 	qc_max = nn->dev_info->max_qc_size;
@@ -666,9 +667,15 @@ static int nfp_net_set_ringparam(struct net_device *netdev,
 	rxd_cnt = roundup_pow_of_two(ring->rx_pending);
 	txd_cnt = roundup_pow_of_two(ring->tx_pending);
 
-	if (rxd_cnt < qc_min || rxd_cnt > qc_max ||
-	    txd_cnt < qc_min / tx_dpp || txd_cnt > qc_max / tx_dpp)
+	if (rxd_cnt < qc_min || rxd_cnt > qc_max) {
+		NL_SET_ERR_MSG_MOD(extack, "rx parameter out of bounds");
 		return -EINVAL;
+	}
+
+	if (txd_cnt < qc_min / tx_dpp || txd_cnt > qc_max / tx_dpp) {
+		NL_SET_ERR_MSG_MOD(extack, "tx parameter out of bounds");
+		return -EINVAL;
+	}
 
 	if (nn->dp.rxd_cnt == rxd_cnt && nn->dp.txd_cnt == txd_cnt)
 		return 0;
@@ -676,7 +683,7 @@ static int nfp_net_set_ringparam(struct net_device *netdev,
 	nn_dbg(nn, "Change ring size: RxQ %u->%u, TxQ %u->%u\n",
 	       nn->dp.rxd_cnt, rxd_cnt, nn->dp.txd_cnt, txd_cnt);
 
-	return nfp_net_set_ring_size(nn, rxd_cnt, txd_cnt);
+	return nfp_net_set_ring_size(nn, rxd_cnt, txd_cnt, extack);
 }
 
 static int nfp_test_link(struct net_device *netdev)
@@ -1866,7 +1873,7 @@ static int nfp_net_get_coalesce(struct net_device *netdev,
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	if (!(nn->cap & NFP_NET_CFG_CTRL_IRQMOD))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	ec->use_adaptive_rx_coalesce = nn->rx_coalesce_adapt_on;
 	ec->use_adaptive_tx_coalesce = nn->tx_coalesce_adapt_on;
@@ -2145,22 +2152,40 @@ static int nfp_net_set_coalesce(struct net_device *netdev,
 	 */
 
 	if (!(nn->cap & NFP_NET_CFG_CTRL_IRQMOD))
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	/* ensure valid configuration */
-	if (!ec->rx_coalesce_usecs && !ec->rx_max_coalesced_frames)
+	if (!ec->rx_coalesce_usecs && !ec->rx_max_coalesced_frames) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "rx-usecs and rx-frames cannot both be zero");
 		return -EINVAL;
+	}
 
-	if (!ec->tx_coalesce_usecs && !ec->tx_max_coalesced_frames)
+	if (!ec->tx_coalesce_usecs && !ec->tx_max_coalesced_frames) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tx-usecs and tx-frames cannot both be zero");
 		return -EINVAL;
+	}
 
-	if (nfp_net_coalesce_para_check(ec->rx_coalesce_usecs * factor,
-					ec->rx_max_coalesced_frames))
+	if (nfp_net_coalesce_para_check(ec->rx_coalesce_usecs * factor)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-usecs too large");
 		return -EINVAL;
+	}
 
-	if (nfp_net_coalesce_para_check(ec->tx_coalesce_usecs * factor,
-					ec->tx_max_coalesced_frames))
+	if (nfp_net_coalesce_para_check(ec->rx_max_coalesced_frames)) {
+		NL_SET_ERR_MSG_MOD(extack, "rx-frames too large");
 		return -EINVAL;
+	}
+
+	if (nfp_net_coalesce_para_check(ec->tx_coalesce_usecs * factor)) {
+		NL_SET_ERR_MSG_MOD(extack, "tx-usecs too large");
+		return -EINVAL;
+	}
+
+	if (nfp_net_coalesce_para_check(ec->tx_max_coalesced_frames)) {
+		NL_SET_ERR_MSG_MOD(extack, "tx-frames too large");
+		return -EINVAL;
+	}
 
 	/* configuration is valid */
 	nn->rx_coalesce_adapt_on = !!ec->use_adaptive_rx_coalesce;
-- 
2.34.1


