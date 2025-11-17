Return-Path: <netdev+bounces-239267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C1C66912
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CBF3E2957E
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB3A31987B;
	Mon, 17 Nov 2025 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FSqLpYkw"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2853128DF
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422902; cv=fail; b=PfHyMlDNNhh033oAJ7gzmjPhBdJ/ShoMY4dEpHQX68kwY/sLVtE5M4pJtnxc6WOqBGvXvpbyjaYnYjDQMtS/vjz6/4zl7TekJrCesbdSXC/ghvr4RdtEfZmz3zC1d/x0sOJyO3hvpoU8Zjl3ivBY3iU327xqRIJs2gVF4vNjhxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422902; c=relaxed/simple;
	bh=HmYTKKKbaajkZJYeFZYM61eHQS1BjCWpcC/xF/rceIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5cQpHvzdaUA/VOv/hNtb1nZsfJqhDmntXGXIuCKUDJjNC97XP6KGSTkL/OJRtHaoQI/cmok9/tqMBXX4iL+beReRvQqSwrn/Hxr75Vv1za9FUsivrVHcKE1zR05eMLF/+kup4hU/QFYzgBg4ldZZ/MmhyrIjnJDh4DURwWh4U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FSqLpYkw; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSzo6OUVE/uMNcLC/NrIb1iwb9u6uIoToEaFkg04FpS15eBFoX3ZyPjJCsCrBcTc+Z1UogQWQNv1QXG79roKHEYt8CnKkRf3VWIXEVdeZuq8b9hkppqeEKI3cNBVR0fbYSoYHXE5r4wrmdR3KlHA2GsAZyhgG2+i/NAs0SUZH/cguxxHj3ZLeB9eZyXIT8jI5jhFYX5AnMjFIjUQcuGC5WlCfXkv5H+OIptu+heEK2BxBYatLWeabHzGuUylpNk33wx2mPpvYVin73mR3FvdbuCBXMjwuuoKuRJvzfZOV49vqVRFOLIXko+L2OjFon4PghWAPs9aOecKALYV6WZDMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3k1pgCIpSKnTe3gneADNdlfcsRi46LLRD4v0foBwRs=;
 b=yBk2hNQ6mNjdzQgGwlusoZPAoW9ZYmftNLAMjfQOm+h0ABPW5m2OFV6UtgDsJGLqy6oEyfLfL0HsHk9yWHxPDjmCE2rgK5xWmGJ+8KT28pMHQuDyPsU5y3VBCruYXmjN20qva7Ijz8//tOwIDRdwkKqnyyt2nV9w8QPF+dzjsLVuaUAxRIyQGMmgH4V57wX5kUQN3rmYfkj+Iej3xSmIQfoh4ZQaLTUXSRIHLHig5bqvLGxIh1eOxr7zm4ezDSWqpeTJPdu77S0pINzI24E8dJfY/9sAK51+kbaSJSLLix77FH9ASxPycVNK8Yhafx6XLFntYX1qXrodUmR7435v8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3k1pgCIpSKnTe3gneADNdlfcsRi46LLRD4v0foBwRs=;
 b=FSqLpYkwmkO+9k+jMNu9v2dEhHiV7O0XcBP+OVjUEr5zgopMaCzInz4SLPWvwZQxzwczs5gTRiVnP5kHbVFAlBKFhwOwuztQ2+3LplTpTnESG53RdwCYcAGPeleyQs6mMX1xrpE3fH5QxwZ5bpJyR/iahnX2naKQdkb7dHiD8ZZQ8C2jQHjm3LRS7cdpthkEXnoHEo+MIikZVT/cWww3xP346thn2OUzSu27aHGuyR2ZLZz3RIKEDub/5zQ/cicu9qTeWnA34Php4L/8ehDypwI0ms6X+sqNdkV4ajuSUSFSu9Bj+csM53a9Jt3mCsoa2HXtSrXZzuYj3cjqSSqTKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:34 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:34 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v3 net-next 1/6] net: phy: realtek: create rtl8211f_config_rgmii_delay()
Date: Tue, 18 Nov 2025 01:40:28 +0200
Message-Id: <20251117234033.345679-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 26257b77-e270-4764-564a-08de2632d79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fzboPdXkr+Xi5VVhl8dLloOlmhVMTAEN6PSPH/Itm1D6409Er9mBlmManE7J?=
 =?us-ascii?Q?Au6nE9SWdfDEw4uowgmlX/wwm7vYH5EIuIIseOys9LQuF+cECcUIqQQDwOcv?=
 =?us-ascii?Q?vnWM+aKwHHBqE4D+gVnrxZ8FN3RbNR0xFdqrYLpceJ9YR2Uu5r8PU4c5e8yl?=
 =?us-ascii?Q?CS3uPb7Xe/hCbCRQ6EeErx/IJZ7VaY/PJcZ1d05IDXzlJDhv4FsX22azBAcX?=
 =?us-ascii?Q?Y5KnvKOoSwn9ZutVwoTYwCutc3U22ldw4vNRDtnZe1AAUQCuK26l4z97p4t+?=
 =?us-ascii?Q?pvYt1XX1W/05ZNqYzR+YBLCcM8B3jLE1aCLS2OedXspVA8LJGw12iLyLaRIp?=
 =?us-ascii?Q?j2YIIrGM836b370CyPk6+xji3Tjsix8skyeAOeuF2aLAyb/R02xdRPDp9pJg?=
 =?us-ascii?Q?HWKNCNw8y/cdzqexi+tl+gQtLvpdAKWxCBA5Jkjmyx2s7VvCF4hibdqUG3IY?=
 =?us-ascii?Q?7DcRCGVIr64BQ1peh0s666+OQ7AiafxezSnl135YR9swqYug4IXmMyu2MkIO?=
 =?us-ascii?Q?E5SL+Y7WDoyAR62cgfj0dULTsJBGGnJgstTuFUQ64EPvzsyc6iNsjlxGYsvL?=
 =?us-ascii?Q?M89ts2P++HsoI799TGqM8UJn5vFgHvqDbMq0ZJ2uoblVMlwtapoHMCaC3t8J?=
 =?us-ascii?Q?7+IuT7F8lNtgaxmkB4AXJUkuFf4Et9MNW3oEDzEgzJceSpZNi8IrfBTPSzTG?=
 =?us-ascii?Q?h7RqrvpMYWNZ4TlJeJAIWmPMcoBF17zhhY0yE9Cn5ULW8l8HBrLlrvRd6mVz?=
 =?us-ascii?Q?rF85UNlpL9ywD0lhZ7AZoayVKAd1APiWwpgkt+WM5akhXZ1ZFCRFKqZXQVIB?=
 =?us-ascii?Q?Xwd0LvsrnU1ws3Pvu+do8f/cIjnRL4XceqHg9LIRTYNc1fnlB9k/CIJWLi7l?=
 =?us-ascii?Q?O6fQy+0lsYLkFQVSD6zMbQaghMBaByty1gqpCM/QraAzyshPvZmo7BK6v+H6?=
 =?us-ascii?Q?bt7ZD/9yFGiW4GAD8v8U4N1pA/hdNnq96ee9CKW9V7re1dEvCRxaD6GNJWc4?=
 =?us-ascii?Q?9bMUCNKmjCOS0eykjD8wjHRnj6AkfHVBXSIeP/FR9GFPW6in4NKnvrEVUw76?=
 =?us-ascii?Q?lXh3Pj/dSNcgRAzdGzKyOXE6AqRe57QUEOmbrWAahD40IPPceZhorCIvbDRr?=
 =?us-ascii?Q?ENGVGXKaWl2NwRqavJD5SOLRUmfF4z2HLtDsvcMNK1uEIN0m//xOWF4g4ktD?=
 =?us-ascii?Q?AL6O0aKQnSO1LSOU37cBItII5+y0UUpf5BtMoKBVLqRlQNveMtEuyJ2LaeIL?=
 =?us-ascii?Q?OrFtaWilsnrsNnK1Rn9gEQF9csjqE7gY3TAKT0rc2e4mXKW4o5os928pwHbl?=
 =?us-ascii?Q?HT02iM80fyfXOTdlRb+0/klPhmdCd8K2maN79OyooFNRxLcAZGPoq2lFLSmX?=
 =?us-ascii?Q?7Nh7YBc0x9ePRB8sLpSaX4/anybUQg1qsEyrNNauIJkRtg59fS2Z8X0oEWTi?=
 =?us-ascii?Q?Gqi/0IwcPTuWGnOpzXe+WhbAd1v0cuFg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I/r41x/5u2L6grW5JuWnCqYRYZttj9X3aD9RYlzJnfbhGB3dnkqFHiPN9ciQ?=
 =?us-ascii?Q?Tb687b2gL0HGnazR0MA60jT++FSjwYFrxfFHyq8hvLZ8eOQwlRuSC7WF/aLV?=
 =?us-ascii?Q?5LltYK95eHRNGN0vB7Not/iLfTdCO17TuzIG4qElaEHBZN9Q9CPtg/Nnqh9p?=
 =?us-ascii?Q?+bE7Xake1iOuZ0puBybsiIybyeL/okU5ZkT1qpw50+P0Nj2OY6/dV5aW78jA?=
 =?us-ascii?Q?6LAe0TcxYLzgHQyAEe4GGQ9+FO6fSuZyLC9bSeBNsgKgUh133PPauNerjMQn?=
 =?us-ascii?Q?ckCQfLsRxdGm0BB0QcyAhsMYN08QtwWm8yvtQLaj51y9ILbQH3Yj0RGOwXhZ?=
 =?us-ascii?Q?qx9pRW92PH+maXi+urF4OwANMD6G7/KjE5mKGzk8j5udR5lJvaG7b3dFo9LK?=
 =?us-ascii?Q?JxBE0bwDhrCcraylmsD9Fu4jHLAG9lS9Ccmz5e+v9hw+O0DRwz5Fq6MajMJq?=
 =?us-ascii?Q?vmmSEbgFEcC9jeEqIFP+ArqvdOWbQ0TkHdaoXrreduaFol0DS8beffAdilm+?=
 =?us-ascii?Q?ienObqlST6MH/sT4hQcltZtbOkYtVi8CUQTPkZrJTtpi9WuPq5ANFsiSwwm8?=
 =?us-ascii?Q?vrIIwrxEtm4DI/BDWVUeBnziU+RmIkFv99iZmGkQTXk/iOOCcvyLvpGmNXOG?=
 =?us-ascii?Q?HFT1ljH0+C0PGnaeu+ixTqZOCadKUf/IvtIxKsNdsV/IFGICisDCghksnZzf?=
 =?us-ascii?Q?X3kDoEtvuEkRy15nXevvPZ4hYzWN9y0Urlz/0iLAUO1CqNmCvsY9RUdzvVZa?=
 =?us-ascii?Q?7e/tBLE4qn0wOXQVwShvkkyQlxYBLtmvnZWAkGvpsf/T7OyEZqApeeNlokMT?=
 =?us-ascii?Q?j3xnlQvT5hoxgEtEJQ1EwZgfsmXtO2r0p1766pDeZOFEtgxg8VGT332zzH0g?=
 =?us-ascii?Q?wtoer9g/iDaqUuicUGRlhNzpBkayDEhX4OU/nWe+Vl4uZHS0BvaKDCJKkQIB?=
 =?us-ascii?Q?fgV5lwsWS49sUa9Uscf3ps2YWGRjfraRXAMoYEDWK+Z/AZ9qjXmswpTyuQuN?=
 =?us-ascii?Q?J+QN+pLc0RNlYEl2Wvn2/UAbQ7/eJ7fgDQIOpTKvNz7u6ju+nRevpIVCgZq0?=
 =?us-ascii?Q?Nw7cm0uET6uL1LlQ6Ws27jueAilMJmuR3dmvVI05+A+39QcX5wNSTuukuHXJ?=
 =?us-ascii?Q?yrRNBzH/oCfeDGwGJkZzzZrLK8h7aTCUNKbpJvlVlXn7cKZvhND+fOkuWTkK?=
 =?us-ascii?Q?ImBazWhuubqz75zX2Ox8W806A3u1JxvQQuP2zh63PrXkn0ZGZeYH9F8LWWZb?=
 =?us-ascii?Q?ny9Ek5OIpinMe2DU/nBBkSTFQy0fB7em1OaV67zMtuUns8mCCKQQGrbaTA0l?=
 =?us-ascii?Q?EmPjbKlyCRv7yFutTNb+EpZEzXJSY4GN/6IG99/3wJNpUnjww9sKfIVN4+7i?=
 =?us-ascii?Q?Tl3qnFnzSwmG1XSmgmTRjAEBZScOhaYWsIROhMx6eBwmLM7Qgl9jlsCnxfRN?=
 =?us-ascii?Q?bos7zzc3TdbbMFz0Sn46W2gey2k2y9Exy8ClclE8t1botkk4rPB9S2lkWEQn?=
 =?us-ascii?Q?b1zVAcSR/cvhFzTQ22RImvBMKFqhOsQj3Q5uePW5USwdI9hiMNAmXIYzQQQS?=
 =?us-ascii?Q?Vhx528Gx0gxXCAeCIEDdZeaAOcwH3LIFxfjUbW7g3FNUuJMdNTpIck1pAnlM?=
 =?us-ascii?Q?8xjq9l4XONDquxZ2B5AOkm8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26257b77-e270-4764-564a-08de2632d79f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:34.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJPPHc9lz6xoPS8S8glvPcpl6tqiDxfvfSiPf15jgUAUhnqtXBGWZaPVbDeESokPHgdWILp+SnrUx5+1q1uB7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

The control flow in rtl8211f_config_init() has some pitfalls which were
probably unintended. Specifically it has an early return:

	switch (phydev->interface) {
	...
	default: /* the rest of the modes imply leaving delay as is. */
		return 0;
	}

which exits the entire config_init() function. This means it also skips
doing things such as disabling CLKOUT or disabling PHY-mode EEE.

For the RTL8211FS, which uses PHY_INTERFACE_MODE_SGMII, this might be a
problem. However, I don't know that it is, so there is no Fixes: tag.
The issue was observed through code inspection.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2->v3: none
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 65 +++++++++++++++-----------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 417f9a88aab6..896351022682 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -587,22 +587,11 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 			    CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER);
 }
 
-static int rtl8211f_config_init(struct phy_device *phydev)
+static int rtl8211f_config_rgmii_delay(struct phy_device *phydev)
 {
-	struct rtl821x_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
 	u16 val_txdly, val_rxdly;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
-				       priv->phycr1);
-	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		val_txdly = 0;
@@ -632,34 +621,58 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 				       RTL8211F_TXCR, RTL8211F_TX_DELAY,
 				       val_txdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the TX delay register\n");
+		phydev_err(phydev, "Failed to update the TX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
-			str_enable_disable(val_txdly));
+		phydev_dbg(phydev,
+			   "%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
+			   str_enable_disable(val_txdly));
 	} else {
-		dev_dbg(dev,
-			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
-			str_enabled_disabled(val_txdly));
+		phydev_dbg(phydev,
+			   "2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
+			   str_enabled_disabled(val_txdly));
 	}
 
 	ret = phy_modify_paged_changed(phydev, RTL8211F_RGMII_PAGE,
 				       RTL8211F_RXCR, RTL8211F_RX_DELAY,
 				       val_rxdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the RX delay register\n");
+		phydev_err(phydev, "Failed to update the RX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
-			str_enable_disable(val_rxdly));
+		phydev_dbg(phydev,
+			   "%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
+			   str_enable_disable(val_rxdly));
 	} else {
-		dev_dbg(dev,
-			"2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
-			str_enabled_disabled(val_rxdly));
+		phydev_dbg(phydev,
+			   "2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
+			   str_enabled_disabled(val_rxdly));
 	}
 
+	return 0;
+}
+
+static int rtl8211f_config_init(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
+				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
+				       priv->phycr1);
+	if (ret < 0) {
+		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = rtl8211f_config_rgmii_delay(phydev);
+	if (ret)
+		return ret;
+
 	if (!priv->has_phycr2)
 		return 0;
 
-- 
2.34.1


