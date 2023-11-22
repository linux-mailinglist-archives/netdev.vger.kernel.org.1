Return-Path: <netdev+bounces-50151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB197F4BA3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A211BB20DE5
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53E58110;
	Wed, 22 Nov 2023 15:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OAUib04E"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E231702
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:51:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLFlRRTYFQSxErxIwjE4H/UZOWLC0ZMIubTjpnSy1SQLHGurZktO4ybyo+e+zZaLIRJpzjj0shL/jfqGNihkmWsFfpTWsyeSzaCyyA8UNsWiedF8yOdYKhRXMGvalpzqfP/wgT1bQs3/N5oaozA3VpLFqLdTY5RkCqbGgQzUxmgPMUNbutVVW9nAvdPoRMXlw+g7nPjoH0/XJLy+CVzKApedJb8VppEBJctBpcLVyVMAIMvgQy/itd3U/f4K1OOMXk515WKz14vweYrtaEzUWYddMpqlrMQy/HZtAcyJkl6xcO8+l+MCIixegjxzXCp53kcZap9N3XSSI8+QyNzqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/MlaStpUgmu+fcWEIG8WokWEr6Kvy9orMpe0H0H30c=;
 b=TT2crHZBTC/6kZjQH/aavp3WUy7HtKPiHCZ0NCxy2nGyuaW+Dwd0LkNTL/xljpE0qKO3292ineAOGkT53edIY00wb1VhpHiG72cKART4X11pyHRMbsSmpgCkr5wTVxtqYWS8dgWtOO7lW23YHRP1lYlgDyEl3txocJeqL1a/pYI/geuJ3RnTFd1CI4cRFBs7hlCFCHGZR51tZa4N4dljpijNrMy8hH7Lxv6r88yYRUYk3yDngCI6hwxEXWFmXWsUpEYuJToz/77dPooHO7uLLiYOIICdfa2VRgjuZRDbqtV3H8oIVvpjUXnacKiF2HXMJaeuRjF75UcFQxU19ZDh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/MlaStpUgmu+fcWEIG8WokWEr6Kvy9orMpe0H0H30c=;
 b=OAUib04ErjqtM53VJSVfJjlpTqPGtLRsqR0MV6Ujg+OdbM8FHWeumxwIhWP5aSEYhncx54X6rePeTtXu8d9uwj4195CKs+HCPYAy/2O5FqF2xek/DauJVNvbMWkpT4NSFNR+LAojAq7XOOBJfKwq0imgNXMyavgfESuK/sfIbPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com (2603:10a6:150:21::14)
 by AS8PR04MB7878.eurprd04.prod.outlook.com (2603:10a6:20b:2af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:51:31 +0000
Received: from GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35]) by GV1PR04MB9070.eurprd04.prod.outlook.com
 ([fe80::1290:90d4:98c1:3d35%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 15:51:31 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: andrew@lunn.ch,
	netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH net 2/3] dpaa2-eth: set needed_headroom for net_device
Date: Wed, 22 Nov 2023 17:51:16 +0200
Message-Id: <20231122155117.2816724-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
References: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0033.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::22) To GV1PR04MB9070.eurprd04.prod.outlook.com
 (2603:10a6:150:21::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9070:EE_|AS8PR04MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 3628f2e8-7d66-4aa4-1d61-08dbeb72e5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jyrepGAa/4sH7pmsqG0JtmhiUORkI3a9UlhuDMJK+bPzz+J2Q9WAGY+d1BMQ2PQdStKpCoTfMJml954nQptCDu2jv0cbXwQktV873CFa2ZgW5E2TFfgtl0MHdmPVRtErTLLqcDree5Tg10U+PzqSzx0F6D+vaZOC1jQq3Erk3J8zACSGQbLKcRxKb8IVbrkP6Yztmx+2yT3dST4JUdzuDx0at6kByXyojYzM0ltCpy115mEdiv7nvpkjY96fX24z/KEl8y7+AIa14qdVEEnf/GPSRA1iDoWpR6HcDJ2crbbB3zt0hFVQo962SdXRuCzhW1kC+Gqrg0eqCWG8p5FzCTmPVdoHOUPJm30jbKA11MvOs/3p1J2jmulfGWxep2m3uRQgxX+SIRieu9xzWOPmYe5A3WStszkn1xphvu/Uy6n97nS7IeKm30fy5/6ijKSJI4+F5YjbJgeg80QGc5590c4F/x+bDpblgjy7atebLz2Z97OokHZmmVF7/BR9mrPHh5Mj//p81kFrGl2KMHTLWuHOEtjDiREZQy3Hz2mEsix9VCRORU8DnM1eUR6BF6HI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9070.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66556008)(66946007)(38100700002)(66476007)(36756003)(86362001)(6512007)(6506007)(83380400001)(26005)(6666004)(2616005)(6486002)(2906002)(316002)(478600001)(1076003)(8676002)(4326008)(5660300002)(41300700001)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjiyKmje+1raK3AQ4fYJVL3Mx87jklGDTRZCYDPiSqC/IhmmWhEEzs8+CeJ2?=
 =?us-ascii?Q?rDgtqlBPW+mVV51t5VvL/2jeAy5T8A0W5mTUB5BrcKUTg/+hbYQ1Lnaq44kS?=
 =?us-ascii?Q?Xz54bsK37bJ9aweT+UjAE6mWhd0CR3HC1bvYdjAJXYkw7XF0tMuqFIouNeUz?=
 =?us-ascii?Q?vsI1dO4PDkzZt/CT5e25N3A8ia8DAONYYdfKVghacWPrjKOJVmcVIG+gwL/0?=
 =?us-ascii?Q?swvov+km1dA8Rie5SXXP1CrqrHlLmpLXHSZh5Z1FjcYLekKR3MeAHq4N9fjT?=
 =?us-ascii?Q?KFXRm2WWMfP9AWsD7Y9brV0O8OvwpzBH8v1lv7OZaguzBM4EIGv2+18qXzio?=
 =?us-ascii?Q?4GhUgUbebEfS5UjprdgeXY8oXEQVHeWNmo5MNHVzPbPpFIb0koOMQlEzvQaY?=
 =?us-ascii?Q?Ri+8kkn6pHSrh15H8NBShwMrKlO8kY3ecCMam+BOdsHRd0zesN8fjK2+zeCP?=
 =?us-ascii?Q?dtYlv7OgyC0BGgSvZyf1midHQ8nnUeq5iEmzRikBg778Frbm0qulx3Ru7XYg?=
 =?us-ascii?Q?FMxj6oQukhzmuW6i2w94FH0f1/yEF4WhQ2Z720gOxpJ+N6L61gNrX7IWiFCF?=
 =?us-ascii?Q?Zbq/Ig7F0KAMVNAvTbCaEfcS8T23Hvm8487D3wsOEJUhBwJYKtZCwZzjgtsu?=
 =?us-ascii?Q?Gm83gtW9Ri/2z+tpOAnt2Kfpb5WW6iYVQpPsr6uTPlDL8GFJBOxksgRl032i?=
 =?us-ascii?Q?qcwr++5deCdxgaOdZw24qZ9mePOq6srjOnuLWm0MyLfy3uFSKt+oxbHI2cS5?=
 =?us-ascii?Q?tDCdtYlq1uzXhMPtZR2/wsr0wkP33+Ha8k2/QQK3qzz+dHysYrNonwWjOFNl?=
 =?us-ascii?Q?MSfroHeiwctJMOgSRo1o5DQ4WeoP0cCeT1QzrnPGZl8VzOuOoEve21/uTbLt?=
 =?us-ascii?Q?YfwisGxcEFfgbRrmDY5gG1SgLnaMPFngwOB7RJHGokbxCyvxsueWJydu2KAE?=
 =?us-ascii?Q?B/tT8aZB98X5FsrCpip9ZtpDqlqEGbCSoX40OjQuRnTbjsFWxVAwGqoQJo95?=
 =?us-ascii?Q?RtWqWuf1TfbKoQgbVtb7SBPoEa72NIGVWtaaqLl/WHRyAGMZK+F+mNdsgAUy?=
 =?us-ascii?Q?OCSXqUC/TXWtUrb1yGNqnh7iOLD2EvEyqW67LDAxF+oq9tRGbdZkgA8evCjG?=
 =?us-ascii?Q?4bwt/lvq1R/VWmayAUZ4m3Vm/uYAKoiLfwmRbe1l1EVn4NpJVrNxQzm+psL+?=
 =?us-ascii?Q?4us0DyxnbJbKK1FU3Z+lwfEJzVWSE8SO9cJUfgzcd2Ci6jmA0ZThx6Ut+aF4?=
 =?us-ascii?Q?o5oWUhUPcPumzYuJoHbQEUYafnOdJ3sMvMdAfJSPw/MvhcNX6Q+xjss1Q1M5?=
 =?us-ascii?Q?A1iwJLfccG9vTG4uOpnOLsKSmA2IgdT0NaSrFzSXQFqvFLR6U0E+PZOkFlhc?=
 =?us-ascii?Q?OKZO1DbtLku3PZD2944XMX5Lf8FdKTYheI1vRv3hv4va0G/J+HnoVYLA88vu?=
 =?us-ascii?Q?n2xb5ZmmgW0X10Ksoxi5XGaiRHaCmWmiCXCqYLQkEbxKctQqblVjhDNYYAOp?=
 =?us-ascii?Q?svjjye8rX7X6hQKAM21VAiqJzji2fSlHaVCOWaNmLYex0Y4aqSIbvUJIMP0y?=
 =?us-ascii?Q?ESmjwX075qaIro+wHusdxzxvP21S31Q/ys+L7SJ5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3628f2e8-7d66-4aa4-1d61-08dbeb72e5b8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9070.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 15:51:31.6854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zAt2NtkQV0d7QInlGND5Mss88YLompfM5ToyWUiVFA1Bxhw5aY92zIrkIvr7MLF6Ynluhi5hSgvMfdL0iWQNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7878

Set the needed_headroom net device field to the usual value that the
driver would need on the Tx path:
	- 64 bytes for the software annotation area
	- 64 bytes to account for a 64 byte aligned buffer address

In the circumstances in which the needed Tx HW annotation would increase
the needed headroom, for example timestamping, the driver is already
capable to send a S/G frame with a single data buffer which circumvents
the limited skb headroom.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index f2676fd50e1f..774377db0b4b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -4965,6 +4965,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
-- 
2.25.1


