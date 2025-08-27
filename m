Return-Path: <netdev+bounces-217242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A8B37FA8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DEE1B60E63
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1A34AAF6;
	Wed, 27 Aug 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DQp4Kyh6"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013027.outbound.protection.outlook.com [52.101.127.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779334DCCC;
	Wed, 27 Aug 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289784; cv=fail; b=G1GOS5SCgmkLpg5Dub/wZlzfsDc3LFxEYfaKmTkBrnizrpE7LMxcEmG+ukZ+sq893G3A6ivHORvqGT9+mO0a6SkhQ5FFTOJZZHl/fvO3mdmGcFFMHIbHmlBfr4zco9ixkYB3NsUVVjIRTfiVt9sN2G8jk3WPm0LqzdRsHgrhUB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289784; c=relaxed/simple;
	bh=3kdcOV1VA7zSF1/2/A2TsbsYuIRgtvmQaiXGguAIq6o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JcG+wIcJlnZSl+dcbWvOaqnoRImlYw5pYZLUnk5y+Zz3JhwAnK0y7zHHkr7ksSPwahccTBE9yY4baOTXQU9O4PQPXFEaCPgH7JHdLrq0blfcvrt9Wo+Sd697Szfo4mJg+AQUEtjJrXDfL+sdl0ZcnNjUdpxxQSw5QIhhRozrB3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DQp4Kyh6; arc=fail smtp.client-ip=52.101.127.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM0JA7ExeXaq8ICcpg0KTkk+LfIrNo79ULNvg/+743/cj86VmGZjHDbkjlmxbeDJBlHUVaJgdhQXTiEPqQ59Wvrl6C9hUXUV+NjfXPsiSXUX6lg1Ge8SU+Q//sPC4nH+Y1JfgJPI4WsS9M7RWLDAOy0W/tXMh9Y0yMotQOMFqsZscDsImbOiClMQ0xAuCwVLoiSNO9WqOkf6BMtEAggL0sblTCKqf5y9Djr54r6dRQMQgSqQmnK3so8ZdM5fBJ9c0vP67f5F++dWNzQRQcJLuWUjbJY5mQkzaYJov+LZiBFtNhpD2OHPnCUGYYde/1opuGU9CV0rtdwQNf/zCAORlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDZVNExzGsLb0DiW6lZ8kUpFn0xEpdkkHQ586earrhE=;
 b=gvD6fI/ZDknhrC3niGQctsw4ShTrc8FWBlvie/sUhMawVj4ngA0yTm5Wqbnd9VXLQZHTs5QS6d0kH3QAtFTSnqqDXp5IzICFRgwSussEkYkXPb66//Mx4OeRVwUjfzcOzuVuQEW21jdjryfDDVrYUJXRoAKYffAo9z5mRAnzGWDcKwH078/QWuM4uOddPFpNDqc/qOwgQb2nZdwCsHZu95VzdYfFyBAAyHEgfBSzaAlQluep4NbflmPZc0JVhmNq92eJk3F22DnSqqXKvkxH1yVvRWCaHFVTHRWcZ9hl4R7cpOCc5wgZEDQaGxuEkfu9SLm4YG3VqxyhRgVqg56dwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDZVNExzGsLb0DiW6lZ8kUpFn0xEpdkkHQ586earrhE=;
 b=DQp4Kyh6eFtmuh0NIR20ZwC+Z1BvOdqP2uYcR2Th93BH930pT2bCnNjtmr6pkzhjH6T6xJ/y5ziCTcOz5SD13JDDNu8HIUoC316kacWLebivI7g+XCtiUcPS3WLDF6m07rxuPkcxaYZ6fq/E6duZHlub9dYDHJweOIRSmoZrNznufF4bNARbWdpK/gWL7boKWxpnZ8xvevuzH1abrCfDXS6e0n5FWF8FNRjyke+846ISG0Bhju/WGGJF3PegTEISI6agBfEs26TFsf85cDexTnPVfkipKFPUhhFiXamadrDi05LHczSDTvn/qhpnpwNlD07DpOckWJYnVbdoDQKQ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY2PPF7BEC1550B.apcprd06.prod.outlook.com (2603:1096:408::797) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 27 Aug
 2025 10:16:20 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:16:19 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/CAVIUM THUNDER NETWORK DRIVER),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] net: thunderx: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 18:16:07 +0800
Message-Id: <20250827101607.444580-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY2PPF7BEC1550B:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b53b031-4654-4f31-26c5-08dde552c426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4743pnwZvn6zCyKo4TmZNBlShwvg+XH84PrmnDHAn1PDO3NoEGRTG+yaWkQf?=
 =?us-ascii?Q?AHZfmSjpCDB7jOYxlSvgJLz/Z4sxcLixHCj5qR/7iuOxWWh3cPVDZ5ipOORi?=
 =?us-ascii?Q?o6joRpjCopbKvXh3gutzovsvvwyox83g8P6VlSHh/97Hrb3SpnM49G07U0SQ?=
 =?us-ascii?Q?VVyMjfYwGxAMNPLRrr+VeToVofmQdkQZ11nR4w+p4dQdtFXDyuXmGFAz6q5J?=
 =?us-ascii?Q?didBcPGx67wYp9vya/cQvr6IX9U7kJqa/fKn1H9KX6z5uDr8tjC8lN4s2OOT?=
 =?us-ascii?Q?Yhnec6Pz+oDrz+i3o/XHaT9zVmoBMC2eGSLo3zcKta+OYDKh1kCotqTbW/bC?=
 =?us-ascii?Q?qz4wmnjmjfQsuxSzEJPYxPpigd9h9H3QR8hivvGWW3YU/CTiS9up7JvAxZVX?=
 =?us-ascii?Q?aYDab1o0ECKKO/r85+tGmhme+9Bf3wpWqd2LEXQcTeW1IcbOsVVzsHqh9jqP?=
 =?us-ascii?Q?FMVggP2yxvLhFoTAkvOz393xQV/FNPhq6T6M7zjBufPUrlVoXG+1NCpF+fu2?=
 =?us-ascii?Q?AMZtEqmCmy4Ub2O4rtcpG4Txl6VDMOGVcC0XsE7FHp3+PLVbX0Gzy7ZoduAd?=
 =?us-ascii?Q?6tOgv0A+HxOdur094/bheOiO7XNoq6Zmh0r4TKv12tUggO3dROlr4e9pQcgV?=
 =?us-ascii?Q?jieIOZu5PfylOhHFWd0qQHQYby+gGtGdtA0CimgEZUGk5qF4S9ILvaDFT55z?=
 =?us-ascii?Q?tU/AOZhSPL3v7Co6TxDttNZcIgt18nGChmccT6HzXR0NgXMCTC4CZyaHIrru?=
 =?us-ascii?Q?Hj/ThOfAgozfxZvgpf16XFklIDqhcz96AlWBZLpADAfJecLpGvinUz4oPd8j?=
 =?us-ascii?Q?ThCmJ3wD1WNPC0Pcwrcjss0vQkuCvvEjQFZ5jCV1N21up5OmtAcArt84W/PQ?=
 =?us-ascii?Q?0zc32QXXwhR7/nKTNY6gqAl8Fo62qzGjB2zmn/RfjNdcmvnyGOPqk6X31UTZ?=
 =?us-ascii?Q?Dm8HL5GDMbaO0BHTt2IIYW3ALM7naTEhicZEdwOjDm9L06+J4fsU105inpHV?=
 =?us-ascii?Q?0AyQjwUEMaOR/dXwVmuWDFmwrFNrSroGEFabTHST0HtrzoDpk+K9WFiBLOj1?=
 =?us-ascii?Q?LRXXRX4E3ZVTFhYeq4MGxZTLWyuoL2akmaxMTAKFw8yhyoLL2aWrEFkfpoz/?=
 =?us-ascii?Q?sWtHhBwDhqqX2YRBgw++1LtYKsvShco3T9afDwbgpyzLR4YcX1EcTnxdeKJ2?=
 =?us-ascii?Q?DjbAwvqQjAcBpRsjgpFaU7F0k1TFg/V+FXcDe909r3kTB5iwfps4PdGmn0bw?=
 =?us-ascii?Q?AcJoHtl+EELoJjxoK4EZ5ij5cJEIjGGTd471ZboBUmTiQWkQBkp+15Sj5C9D?=
 =?us-ascii?Q?joe5VW+3NfHeysHPBJ78bf8TlcHmIf95AkCFIbxUfHZRF935KrDJxQgRyGhH?=
 =?us-ascii?Q?u2uu3khY3ntClR+WSkYpwbcasLrclVFLgzrXhpH2amtrCTyz1R4rARkJ/8xn?=
 =?us-ascii?Q?qU6dAj8YHXvwZOyAP5tgOonT4RusKUDQLPQGzEAJuJaTMHRDAzg7cw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5L/15aWHQwOXJ3Heq5sdWkLwatp70hB9xRekA+jEvlHg5i3yJtn+QfSUDsS1?=
 =?us-ascii?Q?0nHH3fbV5+0jPJZKQ+HbtOtxP8jnd3nphAOItH3kIzGcHuT/Wf1TtRsqbwFg?=
 =?us-ascii?Q?WZEndbrHXcWMKeow+HpBwLTVNZ0oq7MCyjTAe8e9SAu4EMvcVzg37CfFh3An?=
 =?us-ascii?Q?MqLT7uAlUsqzdIc3bniswS2uGFlzfdbSC5BVyrB+eH41MVw0xzSzx+MNZF4w?=
 =?us-ascii?Q?dyKlGrQhLe2WMbfuAUhGFXcc2+bhaZr9rrrHmI+fHsJS74Q7yDEmexS8WpPA?=
 =?us-ascii?Q?i+LMNaBEVhO1875Go96HbPsCTDRGZiiqmM3h44hJd7JTcrNwzGF1S0yvAnfK?=
 =?us-ascii?Q?1+SQV4OULvrGCHfVutr0ygeLIvHiH7pSEGjMFt/pbjJ5/pf/bVd1DH+Uhrkj?=
 =?us-ascii?Q?3FJlEsD1Y/dOt9n+Nr2Z2TwPx0GTmFa2VP3k7UWqR7lqFQvLjnq7nkEL8jYQ?=
 =?us-ascii?Q?fw/6pbwJooysJp83I82eka/zpjvpPEDrN+i6QIRvciwMrlW+ggrL8uYUrqr2?=
 =?us-ascii?Q?kcJH8Iz4bA8SuS+73y6r546gYQVNjXrPIOfez3D3e35OIq7MZybzLefxVwSE?=
 =?us-ascii?Q?pXXgFunCK6rgYK3A222cxu5STJj995QZ6hRyQ5tgTwwvXuphY7fQ822Mm/RU?=
 =?us-ascii?Q?Dhd0/SIR9Zwx12S2Ed+YVNRNgDMFfRwiFXy5u8NGFlq4zYn/ZBK4UqowDO+0?=
 =?us-ascii?Q?MOund91e0x3wkAR5l7gJko+i43DUBd99K2eUULgXHe3co1xNgNhmJKZ5otEb?=
 =?us-ascii?Q?8Yq4oOydgYXhCCMZwbCpL63ppJ873Ze72WHlt2+MGsYXOS3IxLXu0pFU651y?=
 =?us-ascii?Q?a/FbP+MiS0GKL4s0mWwC3qr4frbITvE0pR/cmRHhIbGp5ES3FCmEpoexgH0N?=
 =?us-ascii?Q?cUi1Il2CnyOk7QJiF/7TlLc1L0lMZ+WqQI0tmYoTF40L81h7aoQLQlGgvQPE?=
 =?us-ascii?Q?I4nnBlzF6YkKcxgT29Segkn6uWuvdxCKbZO5D9HTAzz/dIiTQ5moRKh4sbiz?=
 =?us-ascii?Q?MT4yKubUs5Me9CrTrDkPUy+WyTXomIO2I5pHYQMkjCHw9xqUcmNBduVoXSnQ?=
 =?us-ascii?Q?xoL7x/mReW30b1JlUwlcnR2hGjUdVtWIO+nOpIKv/rtNVx2rXXZVt1V4CkAW?=
 =?us-ascii?Q?V4V/JJgv8eP9eqobsxrQDNoN8hkLxIPHmsX6tXCteJHyxOeh/cS7lXsKvhSL?=
 =?us-ascii?Q?K+arQVWs6p4fHjn1Is9TyuZJSNfkdtZB97yR1BcG8LILFjVqxPNw5E/exEph?=
 =?us-ascii?Q?nYAyibWwd1yMnbVMbkxWJDFVz8M882xhV9VEQeSnS7bSqMyxwrqYSLjSAsiY?=
 =?us-ascii?Q?3ZbDcIl+GqVaRO+OWPRgMaHq0J+ZSX6YGEdhDVf5Y3luDERNl0BboTe8+DcP?=
 =?us-ascii?Q?NzEocScrjKImnTQvBSPJK5ZHnUeSICkpL/CO0FGJke0g58F63WsDmCH9jzm0?=
 =?us-ascii?Q?ZcAoTBjPXpgQ8a7+jkAhFDY8xfXOPusIyZq1FATIXP7jl96YrhXvo563iiHr?=
 =?us-ascii?Q?k9vZOB2zp5Yg8MalhDYug4L+L4WvIMt7AEtO+oVfB/naxhDRU2gWZnPfxo/f?=
 =?us-ascii?Q?yJIWWRihIXOjbUFKt1MZrTWhB0DNzJsPEKO+xi6M?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b53b031-4654-4f31-26c5-08dde552c426
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:16:19.9292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UUCAVFuKD/9tqT1EDNRTG7rBoB/UVyBSVvHpA+UoSIlYuNBxhl1oZpFPkLOSt1ssWldPPhr6TmwK34uUlZ8Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PPF7BEC1550B

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c    | 2 +-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 0ec65ec634df..b7cf4ba89b7c 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -174,7 +174,7 @@ static void nic_mbx_send_ready(struct nicpf *nic, int vf)
 		if (mac)
 			ether_addr_copy((u8 *)&mbx.nic_cfg.mac_addr, mac);
 	}
-	mbx.nic_cfg.sqs_mode = (vf >= nic->num_vf_en) ? true : false;
+	mbx.nic_cfg.sqs_mode = vf >= nic->num_vf_en;
 	mbx.nic_cfg.node_id = nic->node;
 
 	mbx.nic_cfg.loopback_supported = vf < nic->num_vf_en;
diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
index 21495b5dce25..10d501ee7b32 100644
--- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
+++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
@@ -959,7 +959,7 @@ static void bgx_poll_for_sgmii_link(struct lmac *lmac)
 		goto next_poll;
 	}
 
-	lmac->link_up = ((pcs_link & PCS_MRX_STATUS_LINK) != 0) ? true : false;
+	lmac->link_up = (pcs_link & PCS_MRX_STATUS_LINK) != 0;
 	an_result = bgx_reg_read(lmac->bgx, lmac->lmacid,
 				 BGX_GMP_PCS_ANX_AN_RESULTS);
 
-- 
2.34.1


