Return-Path: <netdev+bounces-205230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F25AFDD61
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 04:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927D0188D9E8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8EC1B4156;
	Wed,  9 Jul 2025 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dxIUYjsL"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA1136E;
	Wed,  9 Jul 2025 02:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027807; cv=fail; b=t9PlqMnJ38khgpdnr0ND/2HKhhkakns89SxmW/jNBU2zyOJwLE5BtrwzPPXskbty1q2F72Mq0KxPNC0Ea8FTR4sM8XIJnqL9+C1ssv+VPAJDTHlQNMVwozMSS4RE/RBkUaA9Yh7bT8yGLC0GDxCND2Vjcf0ijBrbCj/EJoWnt5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027807; c=relaxed/simple;
	bh=XNR9jdIHT+TznoFs5CfwPbHcaK9UGC00uefG12pdpkk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FtD2c3tO9Vi1WibPVsU/PwxvmKxz5FwPnKiRBIudeILXE/wctjaLIL9GL7BdglcGRaNPGveeb5hiCbxRdGVlQF5jveBUFfE4K4p+W4IPD6WTM0eJpnFlqXv41pyVfkuCmIZdL4CxI7536huJ7PQabMTVCYyXG9ImbXHzwRJ5nts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dxIUYjsL; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jckeRt57CRywiwDW7AbwOSSI8++QbXrbYnekd+qMuOQ506dIFwhaTKl6bKoM6OgDjbFsda5ygHg9A03MD4IErBxwL4TKjy0iRIwmICZd6+EBhgJt+YIWFXmLfhBV4Q+aDGmaSTum7VhtSoWvf6peqyXTMY1x48u1jCZPOdGrmCpA/IlVnbw/ai/eD/ox4Ykh+JMEd4R/BzX15pUvYpBWaal8aNigD/42MN7hwisEs0rOqwz+hDpOa3T7XpTnC1yNXYuySieV0ehftsnT09fAVIH/Zu4nbtwtnJ+h9vm6fvjya45UdrgfZFrL74781yFoqD1xn04ysjvbQpPr2P1m4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hEYkfR21l7InawvTbIXeqjYkX9Lq5z+0tOtk/6NKIo=;
 b=PUpjaXCe85g6o56mdhrMa4ybJ2jsZ/48riagL4qa0z0sqcmryB6h5eyiNnQlcgD77XGwl8OaejuNCKy3y7ONbtqzgrNgMvci9ijx/ipaAiVdRS+Yr9AfK1vc55aNslE0rZ91G/hSxt/gMXpD08WrbD63EDdKYadnRtiVoEqe8vCJO5v4DpX6vJ1P4et3QVcXzZtvtBxNXCu/h4ilf9XtK+oGw3NakJPFNuEskHw2/RD3PFXwaVC+FopSBlpbiQw92GHo8Fvog0aCSuKhqJH1GyOciG9avjD8dlKszuWcnsbxlQ4nj3468MYnubvlXFE0ou3fhiVDbIwI9e6pXNULmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hEYkfR21l7InawvTbIXeqjYkX9Lq5z+0tOtk/6NKIo=;
 b=dxIUYjsL8e/nb5d7aVpP8F84voKJJ0RBTScw52R1XF+5fbZlzBaS1pv2/+wl/2tsjYDulIpZfODVxah3a5aXIJBuQpyxjAeQJLbEfgwF8BvFg76Sxug45MUZ+s9t7cDutuqYLUDjfR0wuPFRpTiXCEB9wB5K5QJP1e8jFdTpIKu/SekIa5o4ZrPt7pi20DCaxJw6+2BDSn0c7Y50ZzYivTOejvJj1xI4ASFA0cgV8VjL2mW8pu452T0OBKtXoKP+66lPnoZUEpfHrGyeeCAO+r3umghwGt7m3hMhESwnnaeWJqk47RPfF6vg7/lLb1H+mjB69YC/ZfiwXG4V4QH/Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6156.apcprd06.prod.outlook.com (2603:1096:101:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Wed, 9 Jul 2025 02:23:22 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8880.024; Wed, 9 Jul 2025
 02:23:22 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	oss-drivers@corigine.com (open list:NETRONOME ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/12] ethernet: nfp: Use min()/max() to improve code
Date: Wed,  9 Jul 2025 10:21:32 +0800
Message-Id: <20250709022210.304030-5-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 173cebda-b8ee-4b62-a3cf-08ddbe8f9370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gXUxHz4X2HbpX/ug6dBqOrMLXO4C80yg2Qx/TGnKYLcBTSb04dAN6p/WxNCk?=
 =?us-ascii?Q?FCnSstcKGccBBsfutR6Uhfx56WT9NW30SDE994UHgtpRymJlMNl1rg2gKMcB?=
 =?us-ascii?Q?YIMTTyTQKsu96aTOmo6e4IOOSEIgZDCdYmkU4iHkWys66Ekyc51xj3D7aJ2d?=
 =?us-ascii?Q?HSgVqXfKhS1m7/+IkSbGp0zojr6B6b4ka784QI41B9XikpebPi5+S7mbfJXw?=
 =?us-ascii?Q?b2IJuvgAo/nrU4DJiA8P5nTTlUg2P7uGrRs6DHNnBaxoAfbjslWJFjuUp+vs?=
 =?us-ascii?Q?vdJhuw1ThlUY73NUCspatIJ9fMcl9E95BzkN49D94meSTqw0kpEFvNrB1y56?=
 =?us-ascii?Q?fYXdU9sX9YxDoNWLZomVESGLQLTpI1cKnVLYBJq2bCzlO2cDjg3Vfov19WXq?=
 =?us-ascii?Q?w1Vn5ZS14P0pBgJddfPno3HtK3Ce5DVP3Rnhmmc2tF3WKBTBVRraE0Zs7ex9?=
 =?us-ascii?Q?l1WPq3i3CJmOE2u7mCiMP9CeqJ0YYTYAfTdQNZr89c6kd1HdQddjWLdZLfXK?=
 =?us-ascii?Q?okxou4Avkn8i6slpD2YXbEw+ejK1Ln6My07q/AMuO8+N9ubbs6vj2xIo2QN/?=
 =?us-ascii?Q?5xaMAaGV8UyKWjwm56/KiIGjJAgiqny9/0D3FKA7ALfWQ070PjfTbM4TcmpT?=
 =?us-ascii?Q?XSpLWb7984c9fc/OyE2jbzkeY/YkuB91FsaRhbONZkLqznzVJ384yN5dd3qW?=
 =?us-ascii?Q?LFbsD4qhUgkW5rGiz/isjhZgN9b8CgWhfNDlHai4kSrXcVgGKgw34Fq+OiMw?=
 =?us-ascii?Q?N4HnMF+xPZerfpCtSKQ0Ss/FL+pvBrObZqdewoqEm4RVcarn7rGbPGlAQWpY?=
 =?us-ascii?Q?4yMcquDcOK2r/F1LOdyFfgDviL0iWKfDKQqaXX4PhsRix6n43vgtLF1ORgmU?=
 =?us-ascii?Q?jF8/mMRYPC7aILsfmK6amLlKmF0K8QZ8hrsVGGZw7mR5DALAir6eM+WWImkH?=
 =?us-ascii?Q?+LxaBgIZC61wsMdz3QG5IrSqTVw5hWUDhW4Hlv1o9YUAeKuJA/I3BiiY7x6X?=
 =?us-ascii?Q?XEUZcSwomIBwSaS1gH6jOQ8i0nxAj9ErlOFhgHAI+yIabpH1GV0xAe/6AuHz?=
 =?us-ascii?Q?NrPmHvqIpvb4CZKuaprXHkZLYlvtu6gAZFGWK369NNlLhbeQS5Ix3HZfF7HK?=
 =?us-ascii?Q?cE/8aeUZthGp4LosIhEqpaw82Nl93lrpPdlSIkU0eRExlf467D+5S0UWe4/V?=
 =?us-ascii?Q?PweW0aIhZdfA3V1qqArkzwVoEIwDY0wLAiOIUSqcwCCXQnzMKaxW1HdjT2Z0?=
 =?us-ascii?Q?aSe3K744OH+sUqY5gdbOcgZQUfXcrQj7uCyvczt/Wt0AwxDwA4/sy4phd94m?=
 =?us-ascii?Q?QF03PpzYt+w9+Efn8iNj4HL7AoRo6XfCTpwSvrgsosqmLWIZHgkytsPV0rut?=
 =?us-ascii?Q?s7NbXWeMQXVf5hNaIw8c7nqbal2H9GI4KfDtDjJpkEzhmX1eVUJTfFW8aNBI?=
 =?us-ascii?Q?GUqCTZZDnyIPvY108qxFX9dPcEuXtIj8dAXQ/JNVq9kzHtQ9IQ/7+0LLPAyF?=
 =?us-ascii?Q?xdC31WaFw9XXjHk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JL3LM/rLYir6k71QylauY6jeGU/AZ6d/0xf3KHctXLZHOwiNR3L6KOGOaMSE?=
 =?us-ascii?Q?LbZgnam5fEFLWaIMktEdGNZXf7cdbLgpY/Z7Rs/bPT1aXOq0EvxIno6vLooi?=
 =?us-ascii?Q?DhcycsftFCy4HKY+LuFLLhum9IkWEWkFeKoacZt1qLc33jD0hsxPoUqflkzD?=
 =?us-ascii?Q?Vn2Pu43JEfr3H1mNyuNkTwqPdniC+JJqFEpfieoqmTBX/IFWA4SRn8Y0n6j9?=
 =?us-ascii?Q?UfIhRgKhoJwUpOQhDTQVCFc79tT5qhDPScssmtdICCKyz0tRELPqRtsSuYp5?=
 =?us-ascii?Q?v2+um02la37uK9p46K2ISWhIvlCxxFB6lzCL3W1Eq8elKx60lqVIN6qofXJ4?=
 =?us-ascii?Q?A7ZMWFsrLdOBbohJTcPA0XfgMaeQyeBydB8qSVNxOUlYrQ+Ms0GDuxwjf6sQ?=
 =?us-ascii?Q?S+GM+6L2QR45mrc2i+D0pGvuNXDgN6TEmLk7G+/49uYX5A8iydvPK5Z2UFHs?=
 =?us-ascii?Q?nUFpV4yWTv0CSH3YzxG/GNODen0GKLIO7XyUT/2wdcNph2LoPvXvJMHXGJUB?=
 =?us-ascii?Q?XrT69y1aBNx0DhBOs1aUYMPgA1pjDJY1DDcdYRuVsBBlD+BkShNx074235Ll?=
 =?us-ascii?Q?JDaQW3esWhSFIbN3kmwE+VedM8rOfqD9F3jcc7XjWhKHfcAmaC8aE3yMVDRm?=
 =?us-ascii?Q?ncuv9Z/LMvpceJzoKnbEVQScOFH/6meSzcXMIo9XrbRLBMH77oZnZ7nzF6Wi?=
 =?us-ascii?Q?q25hkYC+/Fdnxcfr8bnuSNrlZ0LmslnpHJ1WFFgLN00yLJOWg6qFFIn9n/cf?=
 =?us-ascii?Q?LMYPqh4IzAHhcdvgwUWAIuaANY/Lem+KaWAv1tHWkT43wQd7aUguuhQvEgwD?=
 =?us-ascii?Q?ea5RKcQc9t3RQ1MtvqPpY771nnCUeYuE8ioJIvR7LuddM7afuDLPmmfrSnca?=
 =?us-ascii?Q?g/0mRCN5bVK+qFbpyIJMsCJTIuTQZBYBnQebW9ijQpIflxEG8H+6Pf+FGKaM?=
 =?us-ascii?Q?c2Mtyx5soAJLrjIrQnjU/P0LrIawEDWyNnqdEWEWM4oJVsa1ZsXOpJy5xDSN?=
 =?us-ascii?Q?XCTecrgmfH1VLXvRC864/HAAkDOED+p6KbRR+1DQBpUdNm3oTzNAYC0kFahg?=
 =?us-ascii?Q?N/Nr8SLEQ6ixYqDgbyNTN0hLCzX4xb4Fn3RoOJPWexxyYpvV1Ca32lz9fkTv?=
 =?us-ascii?Q?vkYpnUFT340zWDAWuIOuyJ4ME6954TynsFDP+DJ0pd5l07KTUrBC0PgicYNj?=
 =?us-ascii?Q?6WP03/vsoNXkeoiwsurKohVgQHo1ax/jz8NSxCm6POiVvPciibUJb0tcYS/m?=
 =?us-ascii?Q?wnWk/LWIaoEALBtKG4JXppnD4rfwNd+Zwc9YYqo+a9ESo84eY4iuKp1dCJY8?=
 =?us-ascii?Q?ZgWhbC5GbZS59IApNgMnkoIuGQs4xD+kCfO9oSWIcNWwTcHpX3sw+Xqk4zT/?=
 =?us-ascii?Q?k4QAtJsL7vp9L1+OIgm1gSsoY77pkSEMXLHrYFMxOfor69nsB7QmztN88iXD?=
 =?us-ascii?Q?HNZ9YCVciG7q4jdDqk0IkgN8fvUDz9kNZSBRehs7t03bRjuo/CFJsRY7u+vT?=
 =?us-ascii?Q?GOYCrPxRcuidSLfahdn91cNyFOV9aT2WkhqETLmhadgqQtgTOKUeuoLmOGTy?=
 =?us-ascii?Q?wzuabNHtHHJ1snZjaLRkXomGMD+aveW4iIXm8gj5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173cebda-b8ee-4b62-a3cf-08ddbe8f9370
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 02:23:22.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/pNjIixpPBaTEqJy/nt3su3dujxEBKSbQulu+b00cyb+x4qgwOQfXVkS2BNsIlfvZLi5OOS21YP/Y6sjwquFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6156

Use min()/max() to reduce the code and improve its readability.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
index e19bb0150cb5..ab1b952ff1fb 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_netvf_main.c
@@ -205,15 +205,10 @@ static int nfp_netvf_pci_probe(struct pci_dev *pdev,
 		resource_size_t map_addr;
 
 		/* Make a single overlapping BAR mapping */
-		if (tx_bar_off < rx_bar_off)
-			bar_off = tx_bar_off;
-		else
-			bar_off = rx_bar_off;
-
-		if ((tx_bar_off + tx_bar_sz) > (rx_bar_off + rx_bar_sz))
-			bar_sz = (tx_bar_off + tx_bar_sz) - bar_off;
-		else
-			bar_sz = (rx_bar_off + rx_bar_sz) - bar_off;
+		bar_off = min(tx_bar_off, rx_bar_off);
+
+		bar_sz = max(tx_bar_off + tx_bar_sz,
+			     rx_bar_off + rx_bar_sz) - bar_off;
 
 		map_addr = pci_resource_start(pdev, tx_bar_no) + bar_off;
 		vf->q_bar = ioremap(map_addr, bar_sz);
-- 
2.34.1


