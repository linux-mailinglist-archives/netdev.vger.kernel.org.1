Return-Path: <netdev+bounces-176371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8956EA69EA1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 04:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFBDC1896958
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 03:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EA51C1F0F;
	Thu, 20 Mar 2025 03:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TtNz4e8W"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E12A149DFF;
	Thu, 20 Mar 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440647; cv=fail; b=hMP1lxqMxLSPsRO/Ee2vFonaBlaxjZbuO3yZYX4Wg1oUJ177FpNkW50EpsGRwVinYzJao3B+ocW/vNjagMvWf+vVsHC7X6cEeR/Trx8wyfXyYxEuJ8OaOgKTnpCOING2/Bgve5JceEkJWzFKcXx698r2XxTVdBQd1dkxe5bK8Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440647; c=relaxed/simple;
	bh=mQxof3DwvOYXt9SNgyQvpTeoJkkL02ZcRMPLd8TiK8U=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OJw2v7iHqyQxN9AZYWkesnK20KpGCmHJT1qhsAGzVggjjGHrpw/A1XuqSnk8WRGouMoO961G3x26HYwsloItFm/N+lievIRASxFuSFSxPZRmbIZ2wYOySkCSlia66aF5SuVHY5vjb5o62X5O2tbpFD139YUw370s4jKWGNX90rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TtNz4e8W; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTE/QJzLvXTaY+RsyfF9oLJMzcHNVkACW/BKwPccAt5nojCZqJZRbf46XPQcYWY8fxKzMlDpeAw2VIW+lySVTffALiA5SLPoMnMVgLxS9kZBdKNYDikur60p9Yh8QpZW9rYTw9hhE8gJbwUefCRpjL5iBjDl4VJG0lrjpjnOuVxHjackoTwRVEFhRbYeCOO6leguhDmcJLlfM5EXNHCw7Kv/CplxorNjTU9qsaxl4Au5Wne1K67eEeTgKJoVxhmVaon41QgtJX9+Sz1mFrbKg4qrcou9YgNVB3xH6os1J8Q6vjKqId7+qAx4+HO+sll4SyNm2FZxneL1rvobgYmyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCzdUzo8B6hOP96M1PDbcKDUsoAMcuk2uWjW58shMOI=;
 b=JSblVx3naXCeJ+eel2zcnecvYFixoYafwu556DbmamUCbVhsWZcJmIbq9HPaoMzSm3M0NS6+6O1FsAs/QCnnNJYbtL25vUS2Uz7Hd3B/kgziqEs5pCFGtSOW0+4ZcMFGVfxV1AcqpAS6DgMf6FlDzcSUgbD3tI5BMHzBLyOSM44ybv6rrI5rGr6NKBXYe9uFGe6Sq0I1AdanM9YKvI7D46yOLyPriipipoCEU/5IIplKIy7R2Iv2A+VSz1e6hZWdrtNoxd9hkICC/F9HxIKmjJIwwfcOYLnaMTzdapmpeY++DWCPCYD48KSIviw+L1799689su4cSrZjaXZYVkwEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCzdUzo8B6hOP96M1PDbcKDUsoAMcuk2uWjW58shMOI=;
 b=TtNz4e8WxmTJrpYVgA3fNJ85EMIATW9v8aljzJV1YMpcIUvUMzL4tLCojr4jQ12+2rm0NPvK5NgIsGlFISCAFBeylXH0SDvnKlkAfAT3rfQXOCIHCk6628gb/+WLUGiz3+LZNLBNeth5tac7FwoSPeWizBF1HCX6EyzqYIDRLWJUIY8IzGqUYpGzRhMWKALHsiHaIp9X2/7gQW9ITjYbfYwf14Q6SDunH6ON2yjrfBbci/BTkSc5QgYXkfDGotx48IhwubGaldWl3zRf2iSa1qShicqf4RpbsURairXyH5mEVZItDmz416m9wNOJLc/P0M+8S1WVipzdlwCl5Y3eGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9404.eurprd04.prod.outlook.com (2603:10a6:10:368::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 03:17:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 03:17:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Marek Vasut <marex@denx.de>,
	Simon Horman <horms@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Peng Fan <peng.fan@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	imx@lists.linux.dev (open list:FREESCALE IMX / MXC FEC DRIVER)
Subject: [PATCH net-next] net: ethernet: Drop unused of_gpio.h
Date: Thu, 20 Mar 2025 11:15:24 +0800
Message-Id: <20250320031542.3960381-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0128.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 891ded74-e038-4b1f-b107-08dd675dbabb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CeUoJmGo4ry+VNqdAe50c9ZA4iySQ4J7BAJeg3ssf1tsOOo+1+mLLxOOmHZv?=
 =?us-ascii?Q?+6//IjU5wI0tPiUjewvM5RZFhoSP49uDrSykQIkTredJI28cp5se6ulhr742?=
 =?us-ascii?Q?SL/XmONZNCbP61F11YeV90Jty8rrTvjnhG3VfwJxt2qyLZREtK/LtGhujiBD?=
 =?us-ascii?Q?3I9pzTiibPSahTQj31t3Pwc6a6ZZuYBuZK1dAaPAkXRU73NRHj8KqsQWH4Lx?=
 =?us-ascii?Q?iRy2Bzr2AGwxHZoKACIK0JtYL0qK7hnCgAgur/8KNRL+NwH4kxXlj7BXYFhS?=
 =?us-ascii?Q?mgwTt0Fw21cTHRhzOsKCF9gCqlA268Cb8bE6aWh6/jfXV2JrdWY71iK1MNvG?=
 =?us-ascii?Q?IzbeOAhGNQ37HG5JF4n+fiNyhsdCWhLQo31acJ/UqbnRbYLc4U+d4F7URwwz?=
 =?us-ascii?Q?XTyBP3viDDdomI7zTmaaRTrZbEfGH3laQn13fKVjH3dZvQzmqF5zwzSiLMhW?=
 =?us-ascii?Q?992LHxaoOVO5+mUqHLkzycK6zsfRSw4L/LchuEuXBDSw5twzkFcu7eFOiU7o?=
 =?us-ascii?Q?dTVqivTfEBdkSqNjjjhf0CVj+6mg+xnhluXBoFZ9V2wViUo9wB3U2rVELj7T?=
 =?us-ascii?Q?tqoja5Hc+IEv6cU43xRXiAjaQ311qSc6Ja/Dd1z6k4djhea2zzI3ggfe/EuX?=
 =?us-ascii?Q?iHcbLD1l/ZdI9cdk6klf72/mny32cI7vboWoJNpycBLTEjVf4g8tGf3FXPUV?=
 =?us-ascii?Q?2o4L+jKgvG4JO7Ds3yVYMYSrZy4UOQosQ3YQUQ1XBtQy1KhTL0Bd9tlRQ3gA?=
 =?us-ascii?Q?ZiKD5ZZJr23J9X81MqyG0vV3acN3CcMl8wqvgW+b4ew3UiqrfIn0m/2+yhMH?=
 =?us-ascii?Q?lfR4DBnEqJ1gcUzIH6GviCBxDkgWj/nOM3E2wVY6iYZYAYEJTAGq/7Anaxb1?=
 =?us-ascii?Q?xq++RImwNac2cYAj5NuPWHH0W5opaIZPJVIY+AvjP0EfsA5u8FyeQz/4T/mN?=
 =?us-ascii?Q?RQdfoCtgypK2MWsgoymU0QrTInEomk2ghqwMXx9M1aYJUmr++UP2Etw+cTHr?=
 =?us-ascii?Q?I+zyE4VXf59eUjePBRxMrKyvyIwozC9A0GM0vBSmEWf0S0eLdHKmqFnU3dFP?=
 =?us-ascii?Q?oon0W6H3PTWHWlYXlH/Ud1cXIwZr1X+fJaFogVTq8j+f6PS3hyYzb+kJAOl4?=
 =?us-ascii?Q?MBFTrJc529y0j8Y0clHxf3cjQXyYKn49pssNqN1Ff1zjBwfjk64XSo0TTuMg?=
 =?us-ascii?Q?kXlh8NZkQIzrBan8klVbRQwDirS9rLiyuLdG+dH8VT9kIeIsspcBj9InivuY?=
 =?us-ascii?Q?UhhKrGZZ+AND+am2iE7PV4JDSibsANonKSLPsVTpaps1GFaeU1HYJGGGjGir?=
 =?us-ascii?Q?v/8XpRmtbMqXx96awWPLahWSq+g4tSJnIlA0FMy214U+JTGl9zNVDSpyA1n1?=
 =?us-ascii?Q?c4Gx4LBDHh8qd177+BiFjvhOl8dFAs8GDf8LypsHHAd6XYC6lLj0hM8cOJ4e?=
 =?us-ascii?Q?gZzgMa4+uAqbXKw8FZr1yTI5HLhEkmb2/muKnkTDHlPoe0bjstIEFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FEGA53CVS5IAomw406stbCGvEVcidUId8HiQCPeCi3cNO21aPkover/xTgKK?=
 =?us-ascii?Q?H2NXgYza7phV8G71AGy8x4RT+0jW9shQ+ZWmyqF7hJGy6BVWBRnhuphGGqZ8?=
 =?us-ascii?Q?2rMkR9C8nnXivTzxBBa9bfzIAbkzbgDI8cCNG/MHuZ1HxtECi+iAWBeA4exm?=
 =?us-ascii?Q?mFH1Phh025c+eZ3DRmnMM1mJCEubBzGyhcJIIWx3Q2dxhUNh/YTZSiriLvlR?=
 =?us-ascii?Q?kkQ2jYsyh/dRgJoruKE44V3BxkaVF9pMdfBOMSlqKaooS3fVqqv83iPFUWqM?=
 =?us-ascii?Q?Ko0p9av4IbvfYvICn180JPS4nD7Yr2XAHxInPZW3koarLSF19M75LIePp0iP?=
 =?us-ascii?Q?WopzjjsKnUaE65m/EhBj0lkjQsP04kAZweYVFi+4y2Cs0fH4GCSlU7HmQYGh?=
 =?us-ascii?Q?BQ7P3KRnGlZfAkrhM2Za+Y1CWfXIr5yVLK63DW0srbMLpCAhmgHyhgTmbmEz?=
 =?us-ascii?Q?YsDsyXCWKepTyNC9XwYFW4Pt5pRq4K0RlG4DBghBLv1ZgIA6CaKO2cAjHTmN?=
 =?us-ascii?Q?YBG39OWn4mwXOIacJbYkxI7lLmtV3vNHhntJJY0ar+qZMyEbJflMzKHir42c?=
 =?us-ascii?Q?SX0snzvySCuoMUJ2CvY9rcc7O9JtYzmBnKjrggbVXigOzdW/d1Kqc3enIIG0?=
 =?us-ascii?Q?1ef9L/EmgOKIYfE6//xaYiXLBrrsSX9btzbTd5o5PtuFP1ayghsixkBeaKHX?=
 =?us-ascii?Q?IKsU3xgtPi5rByeCsrKS2kA+i3oNlIS7Q4CzqIbQ3RX5BSlicYIBpnZib01y?=
 =?us-ascii?Q?foPxLD/oE0/PK/ueO3/CgUb+zbX/2uKbSZVNA6vhAXNGFdpVFALjyGqH59qf?=
 =?us-ascii?Q?qPdX+0nDW7YL1VZ4NJCfEAQWZFRZEEwFRUt4hnMTuU3YVN1iSPv0SbCerLj6?=
 =?us-ascii?Q?SoN78hY+HrcenTgGKoMAcUcxyLM+ylGfAN110Y210X6aYNEEKCwgem/DbcI3?=
 =?us-ascii?Q?c8dA9y3uKfu/54BxrQUZG2lVKnaaR8oWb7mHQPV63FkC/N1WofdWhEaHlw45?=
 =?us-ascii?Q?qUalSOcTdHVcCB4nH+BEInn0wCygKDAvRGXMQ2i3qzJx2C1qs1Pb54csnNtZ?=
 =?us-ascii?Q?r7oYaZumGhwdZ7sfCa1MaJjzz5kmig/aUHWEOsmb9TQuG15KclpVfs3hvTyx?=
 =?us-ascii?Q?x5vVE21tsj0L/0/Wa2ct3vmTqBZ+pwLCxwnEEEVgiDJ9zVwSURvlHn17+KBo?=
 =?us-ascii?Q?bcR45fQ/ififVNQSIvu0nKaEtiN/FysLFK2dlGEx6S9jYKd3Bd5HmHQaAT3V?=
 =?us-ascii?Q?SAsZwNW0tAr0JX9thENoNUwxYMHDkRA3Z/teeLosJOpUQyYbJvZYyZtRHraH?=
 =?us-ascii?Q?3xm8oJinYzBGF0VkD12vimweKM02bkOYKf40n1JYVEOHJ5wXw6JCTbnFmxEa?=
 =?us-ascii?Q?GoPu5iLxrMJ40iPlnrUSwrU8XxmZSCIrtsFlLy91kNUlWOJlywHCNacHURcu?=
 =?us-ascii?Q?jcDcG667PhU0TQWFSVFkGnmzWf7Acxvj9G/qp/JF7BXljydVWkPtQV0hUP2C?=
 =?us-ascii?Q?RnSNP35bLZ/9kWdQjtSemYAQa6S4mS885FkZKUEsh9nuX+qinP5fbCmgsOSt?=
 =?us-ascii?Q?9+b8y/MH1Nq/6bGVX35AMTgYNAgjjcCfAzzlojF9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891ded74-e038-4b1f-b107-08dd675dbabb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 03:17:22.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVUOlH6n2XBEH4FfDiSq0s4SnD+Cr9fmbacy8fnX86A128/jVLLGmDP+WFr9JVtRG4nAEyfOLyngye7OoNX7Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9404

From: Peng Fan <peng.fan@nxp.com>

of_gpio.h is deprecated. Since there is no of_gpio_x API, drop
unused of_gpio.h. While at here, drop gpio.h and gpio/consumer.h if
no user in driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ---
 drivers/net/ethernet/freescale/fec_ptp.c | 1 -
 drivers/net/ethernet/micrel/ks8851_spi.c | 2 --
 drivers/net/ethernet/smsc/smsc911x.c     | 1 -
 4 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b5797c1ac0a4..1fe8ec37491b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -17,8 +17,6 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
@@ -26,7 +24,6 @@
 #include <linux/platform_device.h>
 #include <linux/phylink.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/ip.h>
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index fe4e7f99b6a3..876d90832596 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -30,7 +30,6 @@
 #include <linux/phy.h>
 #include <linux/fec.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_net.h>
 
 #include "fec.h"
diff --git a/drivers/net/ethernet/micrel/ks8851_spi.c b/drivers/net/ethernet/micrel/ks8851_spi.c
index 3062cc0f9199..c862b13b447a 100644
--- a/drivers/net/ethernet/micrel/ks8851_spi.c
+++ b/drivers/net/ethernet/micrel/ks8851_spi.c
@@ -20,8 +20,6 @@
 #include <linux/regulator/consumer.h>
 
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
 #include <linux/of_net.h>
 
 #include "ks8851.h"
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index f539813878f5..2e1106097965 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -43,7 +43,6 @@
 #include <linux/smsc911x.h>
 #include <linux/device.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/of_net.h>
 #include <linux/acpi.h>
 #include <linux/pm_runtime.h>
-- 
2.37.1


