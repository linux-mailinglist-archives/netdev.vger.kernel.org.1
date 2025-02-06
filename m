Return-Path: <netdev+bounces-163512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D60FA2A86E
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 13:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5384168841
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 12:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1A22D4E9;
	Thu,  6 Feb 2025 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="MIBZY8+v"
X-Original-To: netdev@vger.kernel.org
Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11020117.outbound.protection.outlook.com [52.101.171.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA022DF86
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738844600; cv=fail; b=Wr8PphSrSRI13ypbpvaNdZqde7Sn4nUyMkkMhyO7mqyFJtc+nCyiSx8woG65SdNg2uHY6270anCS77BXyQvthN7XODg0NTBed9luXAQgVQqUGQWezp2YaV6IIKRPKvAk4qyrF77t92km+V+7+1JWlglKbzt0mJxefNPqTRE8Uxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738844600; c=relaxed/simple;
	bh=Z3AzdwSxvkax2wqsHW3OyiFwvyILDyiVDtER+Ziuhgg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bZiUFYsWlJhMalyYjN4zXGDtzPTHuFfbf1FgQVHzA0mV07QQlsrAOBC/egjhkg9/VlLdRjAdgHx1qfyxNrM/tOXDCeUs/d4+y9a9qK3jgDhyUvASmlXU9YsUuEg0LkeRDY86+01bTgfkCdJc4wsMThLjAg15FahHnNJCY9XpvYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=MIBZY8+v; arc=fail smtp.client-ip=52.101.171.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AupmwcZc6drHnZEdor9caIvC+OewYj/2PFCDXW1WI2AEu0+0tTONtQuchKNQsYtbLz0DoqUoaEqH5Cfz4h4eYYM46YCunWEHQXH3YWvHLwhqT+zQkftS8yQBikmsQlz36J+DUTgeJynnV7dVfoL/60d7TqlPUeNnpQ1P3oZ0lCcAJ6Jg63iZWYfnQE02ekZfmRmAHqTQaCuTu7egwD3u4E1hCFDGM1f3KPEXn8iw1vEMWJPjkEfZG+B+xvca3GdfjR7dRvWBVmbaw6Qi6V/R4CShT3oEI/5QydJGGbiirWrQcmtxXNTqrcRXIdjXlk1kH08HZXZE+A9tUYYzjhYYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYjgGwm+XmApi78rSzISEbxSi8k/Z3vS+fCiWtAV4V8=;
 b=u5PYBSnQRRu4KqUynwivHjxWymoZ3/YqsZF5/XlmvbSC39tplpbvqoCJJ21SeKAEriFTzupeR72kIs6orG63rL8dGza9OAvnsl10Jd3SIQ4Nu/XOVPMfdulZN5zQwbMZ9yVhbC1K+/uUJKXDxdpfuw4N+hQkGG5aoSra5+GnKl0APcbwVkXOj4kSq9BfoYpA4W6bbGMorV/Wv1G4kEWKMPau8gatePUDMVT4EsrjZJkz5+TK3nrAndJto8UuGM8zXQ7AUUob/EX36Kko8hVGEDh8Jr8MEhhIimvj6xACDr5JN/F+0Tn6jLIRLvNgAgy8xyCj0/f1x2ppJd3tHz5IAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYjgGwm+XmApi78rSzISEbxSi8k/Z3vS+fCiWtAV4V8=;
 b=MIBZY8+vwOI4ZcK8c5Nm+35r9yBCCbyl0KndVWByRI6Um2F4vG/MHOKLgA7ITNCUOMl26lwiRk/CRazMEpSp/mbsOqRoj3Agpi6v0cfj+LyA7ZdDvCkvNC2klLbxMRPsj5ObuBzDFUfeKznf6k/78kNtfMCQ3aMm1e/TCXMztqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BEYP281MB4405.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Thu, 6 Feb
 2025 12:23:12 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 12:23:10 +0000
From: Thorsten Scherer <t.scherer@eckelmann.de>
To: netdev@vger.kernel.org
Cc: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	kernel@pengutronix.de,
	t.scherer@eckelmann.de
Subject: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignment to 32 bit boundaries
Date: Thu,  6 Feb 2025 13:22:45 +0100
Message-ID: <20250206122246.58115-1-t.scherer@eckelmann.de>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BEYP281MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f187e7a-ba2e-437b-0b84-08dd46a90449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UARl3SeskQju7ATPGMxvU6KbKabG6EqTUFZWZlV1RKiN/nx6E2WwXukieMWQ?=
 =?us-ascii?Q?BPhXqj7U/CmRl2egbE+IwlLbsHAiDMsPWDekxmi2upbDP6R0w5ZMCexGzMkX?=
 =?us-ascii?Q?f5tQadA7ufHhrdGFciNlEBXjlMcwVMx6MvT7xxChMx3I0Ecw6tqgxffl/n2E?=
 =?us-ascii?Q?Ldkj05wxBefbLVU5WR1wvrLz3+iQJWo5qrP5AMgn9kRxvxXypXs6llvEpInW?=
 =?us-ascii?Q?QJmA++sIOjeuaiCd/dxEj8Se9moGbJ5gTmSkvAphUGjLhEtmDFaz9GUQz6ae?=
 =?us-ascii?Q?n1ewg+nDTMaNftaptfVJxqCBNmGIscjf8nu8Yej4xl+YCD+NqEttxNYRbuO5?=
 =?us-ascii?Q?o4EKtlJZkYDE5mUOp+k6St2JeRmecYLUfaWrwn5PUCOJmdbc3YvKrkQtS8D3?=
 =?us-ascii?Q?TPeB7tIY79nA6+JE3pdF5W8LGN3Y3cIxqcflsmCELU0ny3Zz49ooIJExM7WA?=
 =?us-ascii?Q?+M/ktdrbrADJJIKqkbvcQOed5zKmcJM3kb2PNizbedoSm5xwg67JSYb8oZds?=
 =?us-ascii?Q?eep7EZnRgmxt3HtqeFFY7dvw+XypQHOcwIe7V/9ZvjaOJQ4gdZPn2wCFzT/N?=
 =?us-ascii?Q?HFCU0BeTjGTxdUhNxtUNfDMZUVFBB6f/piQ/XtY65wwhUfu4KMkoV/SGeWGm?=
 =?us-ascii?Q?sWYzLmO49ZxNaqkUnOwJE3iOfsgKVbzXjqBzMfXJil6MEXnU75NV3zyxyuvS?=
 =?us-ascii?Q?JRy98jJyr/lHKPDHa52YSDbm0N6INy0GV8Jom1/7Quv0M1NLNN5+oMuNCQbX?=
 =?us-ascii?Q?Gqj3TOnx7ApgEacJDvxBsI5kvaz2PYPlY4WY+FIchcjViI2yN2dxjJa5JoQQ?=
 =?us-ascii?Q?kJfz6i5vfGtqIMuLPNwzCXMHZQ89KcjBuYp4JVUnH55DxNR9h19xXTJTJb97?=
 =?us-ascii?Q?Ekw784vrbFiuAOCwpOcQXwHyGqpuNTaqtD6JLHeVOY0/hbn7EjoeEMACkfD3?=
 =?us-ascii?Q?PjtjKk+5vDwTeuF/ovo2MES6iYcghViPk3H1RjU4/4zBR91btPcqY6FN/AMN?=
 =?us-ascii?Q?TjCzs32HYzWsf2ziWo/g9Y80XP4Se97d2m7mKkN+ifejaGBed2YG88a9E5xo?=
 =?us-ascii?Q?bGFJAEDwdwpdyCkl/PGEOzaI8y1ZyOXaLoqnRr651NckdmeXQ/hp2w124/0D?=
 =?us-ascii?Q?P9sg6XmlGcptjOddEJGHfObnA8fytaC88WZHJCoXSlG6MerTyXAdg7dRqXwK?=
 =?us-ascii?Q?IdNxgy+uOmbrCwx/h60xjOCA5hc5HTuFCs9MUzF82y2Fkv07f+y3/ADWo8ml?=
 =?us-ascii?Q?e0wQW/VxEiHdKDqKc6aXxnK2fIsk5R7F8ZQWhCGs7P5RjHhCpIyktVraGgsc?=
 =?us-ascii?Q?UNlyOoPKHkIDE1KPMa4BO1edT2ezzVFyN/Ceup5vV/QguD+j9B4GOJedcgYM?=
 =?us-ascii?Q?QqAXNPoEJfp7RhoxPf8ZX+BwwVaN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbJavuOvYcQdmyRDE4ryHJ1iQ/lYJTD9LCsdc3q8zLniwbGaVVkvSL4JR1ms?=
 =?us-ascii?Q?waZMwYlJ+r7lmCqShqt4zXzvjvK2uYBfngNvY1fg7pOI1zl97BgrS6Ivmzjl?=
 =?us-ascii?Q?Ld9lUVvgooqTgCjAqksJaVRrQlydYT+R/WbUNJspKADxQArrblScByLb+PlP?=
 =?us-ascii?Q?hbnIlBKG9X2pSiV0RNMwQlcKG50IltYuwITIZbrNKFIXm/X0c+xzIM5Nb+rM?=
 =?us-ascii?Q?V2AyoWXLaReXLCY1BJnvSt+Fe3+3E3DTGRnMWhiNpv9TrBNnDoq9PZcHeCMl?=
 =?us-ascii?Q?KJUXoOk/vkc5eJJRRFRaxS9MBKLPO2+f9841lFocO5ityTGW7dzdgutu99GE?=
 =?us-ascii?Q?Xm9tFWEeb8ASz1TxK7+cx9rL19x0Rj0pjO9SUXtJtMHhi/ULHUIwS/X9oEMG?=
 =?us-ascii?Q?99/AEj+rQk31EaqUlE2nmieftpK0YxR2KpV8EVRw7kPf80twLS3Tz5hCnwBS?=
 =?us-ascii?Q?ylC+GOO4wccaYd7YJ/j/AQWy7O+JcLEuSJLf3PGcaWiLQ3NtAydygvXi1JYx?=
 =?us-ascii?Q?WRYxdJ60zf9rde5Uv2buu7jl3p7tGMcRK5067qHINWjqBCetXzxkplx0s4dz?=
 =?us-ascii?Q?RFBs0GQrR3OkV0mTUtz0OKVG5FLHR78XBjg22b8XObldLklvJFoFz1e/T186?=
 =?us-ascii?Q?rH2OwED/60iDylyASCCHh7Kshjn2w/BchOuORcVcJRG9b/RlJPzkMbXmOg8d?=
 =?us-ascii?Q?jlwiRz0o2xAOMFk9KNVa3a0qMffGOJmnocgYehnmBKDmqSQ3C5thAAAUECP/?=
 =?us-ascii?Q?IhcDAa8246fYpC3949tvA8ME2lJ5wHhODA64y5iFMR/anAPMY+kcnT0qnCfw?=
 =?us-ascii?Q?epQ+sRtfmV3F/aY6OY2/lPER9q9R6o9bjIFAqQhnuJqVsRrx3OkeE2RnKXMJ?=
 =?us-ascii?Q?RZgIYhsSf/ebmfFGXCrlLiyi7yYr2m1LAChfYnaQ4F7vNjK/UKzNu+5bB8zV?=
 =?us-ascii?Q?xKrSAQP7oQhs43aX4ILzcE4J1vNgNSKk0CBzHoziCWkP4a7XsGCDEpyvkcua?=
 =?us-ascii?Q?/WPRj0jDqz7w9VOwxTkBVpDY1wxL4zpqGD3N0Bl/juQerBc/DV8Gtu/temc9?=
 =?us-ascii?Q?iTE+rM3Z6dO2OAHpDgBErS1oeAL3kUnNrIlEKmIqSGPevN70OB9ivXExYVE7?=
 =?us-ascii?Q?eeMI8uyFq0lbgiTN6y+Hxk/mmDckK/UifVCHcI+LMEFVO31u/ZG8vHbWoBDF?=
 =?us-ascii?Q?YUVifpsXpS5MWOrKbm7/IvVrxrfAsta9udU5nfQQt0W5aw/2t0H73zWwXGg4?=
 =?us-ascii?Q?MRqhJakk+9zyProDTyPbo1nnECWePBOMm46c0dRyuyyrK8BEu+o1VQy6rl//?=
 =?us-ascii?Q?t3GeikfZ+VxbK/Ba3GamwnJEnB+6JETh6VxoDILY4oAmFmyCJniJuXnqDxo2?=
 =?us-ascii?Q?2/lBKMhgwaw5DzMaO11vEIgT2jOxzOI4Mw9Swsy8Op+W30tHY89b+lIqF6YO?=
 =?us-ascii?Q?0z7ndQLbUMkE60Ax/v0GIe6pYshm9t6z81lOCUOiVFvcD/snarvFpQBqLeZ8?=
 =?us-ascii?Q?MCfhNSAV40pRJ7wDzXITIwHGhs10BVQixIqvp0NtGCLtnjLF/hdgRHyindIT?=
 =?us-ascii?Q?kxlwHPHoZSqU59mXpJahmFsxCUADJtiRJ2MrYmxBXhsBue7FvDfkVIWov2vK?=
 =?us-ascii?Q?QjiMnHsknOp0JCskBpzMHNlt7+cUqB0WtyTN+t0H22HPePGrI8lLgdTtnvUQ?=
 =?us-ascii?Q?8pf7tg=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f187e7a-ba2e-437b-0b84-08dd46a90449
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:23:09.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+xqfi7h2h/WKw3O97cT2mZAx8oBGorcDmM441/OIgp2OOAqtGlaIbn5O/ywY/7qo8tJpUchs9DtvwjJyprsDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4405

Even though there is no errata for the KSZ8563 the device shows the same
error as the one fixed in commit 5af53577c64f ("net: dsa: microchip:
KSZ9896 register regmap alignment to 32 bit boundaries").

ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
ksz-switch spi1.0 lan0 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan0 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0
ksz-switch spi1.0: can't rmw 32bit reg 0x213c: -EIO
ksz-switch spi1.0: can't rmw 32bit reg 0x2134: -EIO
ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 1

So apply the same changes to the ksz8563_valid_regs struct to fix this
issue.

Fixes: 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")
Signed-off-by: Thorsten Scherer <t.scherer@eckelmann.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..25226490d467 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -717,10 +717,9 @@ static const struct regmap_range ksz8563_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1111),
 	regmap_reg_range(0x111a, 0x111d),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x112b),
+	regmap_reg_range(0x1134, 0x113b),
+	regmap_reg_range(0x113c, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -747,10 +746,9 @@ static const struct regmap_range ksz8563_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2111),
 	regmap_reg_range(0x211a, 0x211d),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x212b),
+	regmap_reg_range(0x2134, 0x213b),
+	regmap_reg_range(0x213c, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
-- 
2.39.5


