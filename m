Return-Path: <netdev+bounces-17136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D544750876
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1208E280EC5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 12:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FC1F923;
	Wed, 12 Jul 2023 12:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81DA100B9
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:36:26 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2134.outbound.protection.outlook.com [40.107.100.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C861982
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5f3x8gLV0ckQMLgDCiShtgIJtP6ANJeb2ko/mnGbHLCFWH5JPfdonk91GAyVxmVE5sJJjcUo0MylgqJ/lrL6P7kGwkpC7rWmeX0CdhRVK641fUpu0fQr7h6M8us/rFaJk9OiMxkRHAGuJ3ZzG2433LDE8FQwjOD8gSXD3PLwk6z5mIJIBXyLpY+9w5jONbrfJWgqGw5jAIPK8nlIwpPhZ3pNLnR/AQcJ1WOnb13jfgcWygvdnrA2EfZ+GsJjqnWiOm07iaRI7x/tJ6U0/BLuoDsc1JZMU62UaBbb2fmJGg0BBHigyffzLbW4vMuVvwM7VIUh9s3z7Hd7/DGUU0vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo631KYjAFMZSUAqb0vzuS45rTpzWh9xN4/2E+9h82g=;
 b=G/NvkseBvhba5y6kLllGq/jiRUaNkrL4wkT3B48DdhqJRtOCUfVnfpisl2T5A455A9RBWErSb+waPkf97ZdHhmvS5FRYphKdz089r2hgtL/HhWUnyo1Z5lcHq816AZUkZfwe4yRKP5PjXMvnNtEvdQQxLjsnDS7otvgK78NkHkjAMZ07kld3gAhqx0vyoo+ujfdjShcSKqrydD/CsNXEqG4n2nYiiUVCf0hc+4KVE3TwAh0CEmYR7wKOBabp3VWbN+KKe8XVfniLuH3rUAu7HBSWk68MKsPzxNVNwaJKwdW2mTbDXDQ8CaMFlTqnoEph0UzIJih38/xLyS7dtmPtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo631KYjAFMZSUAqb0vzuS45rTpzWh9xN4/2E+9h82g=;
 b=VfHcmMmKhNGluzXD6CDzLZiJ7C/Qw4eFlen9niSfQw/4iB5xaciR9SVX5eK2PSEyKPbMsTeY38F9QGe2H14mY2vi++2V5dLARx05VHteMg6gpfVHJz7Crshw4Sd1QY3Xet1TF19RGyCHwpA7DDHFzGGXSGFrMGihT0JAl0fC1Gs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25) by
 CO3PR13MB5670.namprd13.prod.outlook.com (2603:10b6:303:17e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.30; Wed, 12 Jul 2023 12:36:14 +0000
Received: from DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1]) by DM6PR13MB4249.namprd13.prod.outlook.com
 ([fe80::eb7b:880f:dc82:c8d1%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 12:36:14 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
	Ziyang Chen <ziyang.chen@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net-next] nfp: prevent dropped counter increment during probe
Date: Wed, 12 Jul 2023 14:35:51 +0200
Message-Id: <20230712123551.13858-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::15)
 To DM6PR13MB4249.namprd13.prod.outlook.com (2603:10b6:5:7b::25)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4249:EE_|CO3PR13MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d78beb8-5a2c-4def-d0b0-08db82d49492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dGjQxsj2CsyRqmmrrgyuXk6IMVMYrTmhsw29QAQ9c3iozVN2BJRmgkgUeGXf2gus52jZmd0Pa7oBlwNB3cC3uFAi24Ez/IaP+3j5szaXaH/CinBg6fUOrU/+xR2EnCUcwq1/Tzhm9opx0/FNVC2t9gSgf02492pRtgKbzfjTbGtfjP982aZtO2bvm9y0CR2oOMp+3u4KXVbwYdSzD1hMrnv2LYjg2SMR2TbVQ7Ud5j749e1Efdgq+uNVD2bW5bTo3H5n6af4QviSvPp2rkJpNtAC3SD8RSWWDDkdcCZyy3Bzoc51SSy1D6v8b7gmOYOyxNbf8EA9aw5+H9SDxbeFZHEZqFYiUbLeN5vnmWY96fNtdd4xMqhOVWrmGughbsDFZSay1OMC/6eelT1vu+0RNM7HrWiylUIMO4OOhvv/wigS3g6v595SidKbFSqSCqcWRBFxqIn7HOisp5d+01esNgbTp3Kd0nX0J+rKLRuZe+J60orzw+ZwmppxqHaATIKS7vx6HEPE9LG5I5axmGjInO2l8L+viIjqU2tPHLBTodPsxbOGcfWSaKgwcoLYmhUO4aj0S6wfalR4WUExiNo7eN4oXW1bvq3BgLNt99dFzknvHjY49a/5latZxfNgfvRLPEWvh8OkJ6CXqpqiabxKfEws4MX9hiDzXT3Fo7WJBXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4249.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39840400004)(396003)(366004)(346002)(451199021)(86362001)(2616005)(41300700001)(26005)(6506007)(1076003)(83380400001)(186003)(107886003)(6512007)(478600001)(110136005)(54906003)(6666004)(6486002)(52116002)(4326008)(44832011)(66476007)(66946007)(38100700002)(66556008)(316002)(38350700002)(8936002)(8676002)(5660300002)(2906002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CqpLtpfpIJxRc3iAqDWmGYgOOQNIVP8VfkkEZfnJs9X0xAwTyFjpNzj3R9el?=
 =?us-ascii?Q?2TJs8lIvvkyfigsWf6ZZhDy81PsOt4OxXkdrVTWbUIP6KYHh3yvOqh6cJH36?=
 =?us-ascii?Q?VSEYgUokoCyion3VYRP8u+LQfobw6K6TAYhyjvZpiMdR1TG2br6m6eJ0lnSt?=
 =?us-ascii?Q?9viNgrfdVevZ9UmsJOuevCqdAuSn0hbR0eoDKHm3cZhOiZG58Q65GtVi9ikN?=
 =?us-ascii?Q?D+BxkUFhaqOga+LwDXAvCqVgmOtGkUIpq9CklZZyoB0r7KmxHDQXOiquzZfk?=
 =?us-ascii?Q?520GfGHde+QZLrjwF4lH1Tt3tSeVltXuTVlUBoxY5wwfX/qSQEtGEhm81TyM?=
 =?us-ascii?Q?1A0F5cRT9NGurUxr3UFBjkq5q+RvJtdKL52EwS70d1U/m68m+tLBBzOT1D66?=
 =?us-ascii?Q?c/uBp6JRobtX4ty76MxoWrSCfRIF9d1DiT6h2BiYsVH2PiuG5tLa/ek619SN?=
 =?us-ascii?Q?kSO12yh98zvAIKIjgDdBu050auJ5eBDHfJ9N5HIpu9LVdv/rlJ/M/hpB5Vqf?=
 =?us-ascii?Q?NXzWwrFbkRgWQ4WpjCUDKbtSJf0DVKRh+fFmk3r3r7WqQidC2EJ8AyQAVGj8?=
 =?us-ascii?Q?Wuem1zetfsdomxnLqe76Dx214Eu8BY01YJCnGaAo1ORFpr4vJMzDk6G0nnOE?=
 =?us-ascii?Q?7aeGz6x0jb04BFcxIgHhMj+qYEKDECyaRt4UYc+706PY9o5ycOuCaqi/qAVN?=
 =?us-ascii?Q?uhe8yApMScLSBR5VsNicZu3ZO+gIFbMFMBxzgGN/rzNOx4svOtfeTMujaW8P?=
 =?us-ascii?Q?p3+unacflbEm59AgGv/0qsxfGaQYR5wxkt5D3/pVoUUCXHX5Gw3vdzLH0UJ5?=
 =?us-ascii?Q?nenFYwXLiiOr7JyFpWgYL28G8xR74+Mxe2Klm4UCeqOuKlDfh3+ZVwb3UdV+?=
 =?us-ascii?Q?JwYyVuFV4ZkUU2wli1IXj3ihYuynJy2ztxpYg9elJR4hVSpzK8OYpzrYESv+?=
 =?us-ascii?Q?zQxsdsr9ydRWsJVWi3U8n9NYRoNlQdIXiZmU5C8zovUV/vruAqYz9t435/Jv?=
 =?us-ascii?Q?9E3sE1z1E0BVOR5aU71mpnAySvYVut3gVbgt8xK9jiwpgrMaU4Hs2jaESH6U?=
 =?us-ascii?Q?7EAGVu/mL6MxxgqJfwqbFN69+MT4EHrV4Dt7DSE15Y1d9XEYMhUxbyrOGDIr?=
 =?us-ascii?Q?slOFQv+KGi3MhKW5A0h5Z/FFNzX7lGCeI3KxUPpwDSr6jyg/RZ9h/8TMIbnZ?=
 =?us-ascii?Q?/CUCP/EfTJQHkf6H11sVApMvBhb6kiswOlwt15n/o+y4rbYz2QBkec2FxmqD?=
 =?us-ascii?Q?klW+rmCsQTL/P0yKFfwM37fCd3utYMATG6D4GpgfISAVA8gUIVq6RMjQZ0CP?=
 =?us-ascii?Q?Mdf+W5y3xs9Z6xYuQdkpm/Eq0Z/PoBcTIPCLcMrs/ak6P132bnLq+sFWBdbf?=
 =?us-ascii?Q?9k7GkZkYMfeS3uvZdD1bnPx6ckXGbRSsxbGK6kGi8J1NgyNVHTkHrHSBNHFk?=
 =?us-ascii?Q?5KOhjdbI4R3mFFK9Mk0GMX/ID1AuDepk1/3jBEO2+kXgZ5N+lyAT8dSt6B3E?=
 =?us-ascii?Q?MbtMlOQj0dDelt4ISiWnOinb5ASqBCKrU5xUEQu9Nem9ET0jgmNKOnIJ22KO?=
 =?us-ascii?Q?a/h/ppFpvhTCkb3JEWrQzsNkqdGz2qR+9i0rYPLz/zs8QE2Rlc74kO5IQIiT?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d78beb8-5a2c-4def-d0b0-08db82d49492
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4249.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 12:36:14.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnZN+wvNG5fKE4FqQGVwVDGuce+yNIzyJZ/CcCW8Tp/ERaXEtSAij9mqqdk7+isrmyf7wdfUtMl1HSQnoF7CmfmJZfpC37Ip8Q84KeyVleA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR13MB5670
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ziyang Chen <ziyang.chen@corigine.com>

The dev_rx_discards counter will increment by one when an interface is
toggled up and down. The main reason is that the driver first sends a
`NFP_NET_CFG_CTRL_ENABLE` configuration packet to the NIC to perform port
initialisation when an interface is set up. But there is a race between
physical link up and free list queue initialization which may lead to the
configuration packet being discarded.

To address this problem a new bit NFP_NET_CFG_CTRL_FREELIST_EN is added to
perform free list initialisation on the NIC. The FREELIST_EN should be sent
in advance to initialize free list queue. When a port is set to down,
FREELIST_EN should be sent after CTRL_ENABLE to avoid packet discards.

Signed-off-by: Ziyang Chen <ziyang.chen@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
 .../ethernet/netronome/nfp/nfp_net_common.c   | 54 ++++++++++++++++---
 .../net/ethernet/netronome/nfp/nfp_net_ctrl.h |  1 +
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 6b1fb5708434..f18c791cf698 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -924,7 +924,7 @@ static void nfp_net_write_mac_addr(struct nfp_net *nn, const u8 *addr)
  */
 static void nfp_net_clear_config_and_disable(struct nfp_net *nn)
 {
-	u32 new_ctrl, update;
+	u32 new_ctrl, new_ctrl_w1, update;
 	unsigned int r;
 	int err;
 
@@ -937,14 +937,29 @@ static void nfp_net_clear_config_and_disable(struct nfp_net *nn)
 	if (nn->cap & NFP_NET_CFG_CTRL_RINGCFG)
 		new_ctrl &= ~NFP_NET_CFG_CTRL_RINGCFG;
 
-	nn_writeq(nn, NFP_NET_CFG_TXRS_ENABLE, 0);
-	nn_writeq(nn, NFP_NET_CFG_RXRS_ENABLE, 0);
+	if (!(nn->cap_w1 & NFP_NET_CFG_CTRL_FREELIST_EN)) {
+		nn_writeq(nn, NFP_NET_CFG_TXRS_ENABLE, 0);
+		nn_writeq(nn, NFP_NET_CFG_RXRS_ENABLE, 0);
+	}
 
 	nn_writel(nn, NFP_NET_CFG_CTRL, new_ctrl);
 	err = nfp_net_reconfig(nn, update);
 	if (err)
 		nn_err(nn, "Could not disable device: %d\n", err);
 
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_FREELIST_EN) {
+		new_ctrl_w1 = nn->dp.ctrl_w1;
+		new_ctrl_w1 &= ~NFP_NET_CFG_CTRL_FREELIST_EN;
+		nn_writeq(nn, NFP_NET_CFG_TXRS_ENABLE, 0);
+		nn_writeq(nn, NFP_NET_CFG_RXRS_ENABLE, 0);
+
+		nn_writel(nn, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
+		err = nfp_net_reconfig(nn, update);
+		if (err)
+			nn_err(nn, "Could not disable FREELIST_EN: %d\n", err);
+		nn->dp.ctrl_w1 = new_ctrl_w1;
+	}
+
 	for (r = 0; r < nn->dp.num_rx_rings; r++) {
 		nfp_net_rx_ring_reset(&nn->dp.rx_rings[r]);
 		if (nfp_net_has_xsk_pool_slow(&nn->dp, nn->dp.rx_rings[r].idx))
@@ -964,11 +979,12 @@ static void nfp_net_clear_config_and_disable(struct nfp_net *nn)
  */
 static int nfp_net_set_config_and_enable(struct nfp_net *nn)
 {
-	u32 bufsz, new_ctrl, update = 0;
+	u32 bufsz, new_ctrl, new_ctrl_w1, update = 0;
 	unsigned int r;
 	int err;
 
 	new_ctrl = nn->dp.ctrl;
+	new_ctrl_w1 = nn->dp.ctrl_w1;
 
 	if (nn->dp.ctrl & NFP_NET_CFG_CTRL_RSS_ANY) {
 		nfp_net_rss_write_key(nn);
@@ -1001,16 +1017,25 @@ static int nfp_net_set_config_and_enable(struct nfp_net *nn)
 	bufsz = nn->dp.fl_bufsz - nn->dp.rx_dma_off - NFP_NET_RX_BUF_NON_DATA;
 	nn_writel(nn, NFP_NET_CFG_FLBUFSZ, bufsz);
 
-	/* Enable device */
-	new_ctrl |= NFP_NET_CFG_CTRL_ENABLE;
+	/* Enable device
+	 * Step 1: Replace the CTRL_ENABLE by NFP_NET_CFG_CTRL_FREELIST_EN if
+	 * FREELIST_EN exits.
+	 */
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_FREELIST_EN)
+		new_ctrl_w1 |= NFP_NET_CFG_CTRL_FREELIST_EN;
+	else
+		new_ctrl |= NFP_NET_CFG_CTRL_ENABLE;
 	update |= NFP_NET_CFG_UPDATE_GEN;
 	update |= NFP_NET_CFG_UPDATE_MSIX;
 	update |= NFP_NET_CFG_UPDATE_RING;
 	if (nn->cap & NFP_NET_CFG_CTRL_RINGCFG)
 		new_ctrl |= NFP_NET_CFG_CTRL_RINGCFG;
 
+	/* Step 2: Send the configuration and write the freelist.
+	 * - The freelist only need to be written once.
+	 */
 	nn_writel(nn, NFP_NET_CFG_CTRL, new_ctrl);
-	nn_writel(nn, NFP_NET_CFG_CTRL_WORD1, nn->dp.ctrl_w1);
+	nn_writel(nn, NFP_NET_CFG_CTRL_WORD1, new_ctrl_w1);
 	err = nfp_net_reconfig(nn, update);
 	if (err) {
 		nfp_net_clear_config_and_disable(nn);
@@ -1018,10 +1043,25 @@ static int nfp_net_set_config_and_enable(struct nfp_net *nn)
 	}
 
 	nn->dp.ctrl = new_ctrl;
+	nn->dp.ctrl_w1 = new_ctrl_w1;
 
 	for (r = 0; r < nn->dp.num_rx_rings; r++)
 		nfp_net_rx_ring_fill_freelist(&nn->dp, &nn->dp.rx_rings[r]);
 
+	/* Step 3: Do the NFP_NET_CFG_CTRL_ENABLE. Send the configuration.
+	 */
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_FREELIST_EN) {
+		new_ctrl |= NFP_NET_CFG_CTRL_ENABLE;
+		nn_writel(nn, NFP_NET_CFG_CTRL, new_ctrl);
+
+		err = nfp_net_reconfig(nn, update);
+		if (err) {
+			nfp_net_clear_config_and_disable(nn);
+			return err;
+		}
+		nn->dp.ctrl = new_ctrl;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
index 669b9dccb6a9..3e63f6d6a563 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ctrl.h
@@ -268,6 +268,7 @@
 #define   NFP_NET_CFG_CTRL_PKT_TYPE	  (0x1 << 0) /* Pkttype offload */
 #define   NFP_NET_CFG_CTRL_IPSEC	  (0x1 << 1) /* IPsec offload */
 #define   NFP_NET_CFG_CTRL_MCAST_FILTER	  (0x1 << 2) /* Multicast Filter */
+#define   NFP_NET_CFG_CTRL_FREELIST_EN	  (0x1 << 6) /* Freelist enable flag bit */
 
 #define NFP_NET_CFG_CAP_WORD1		0x00a4
 
-- 
2.34.1


