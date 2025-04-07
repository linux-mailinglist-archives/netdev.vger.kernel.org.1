Return-Path: <netdev+bounces-179563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A886A7D9E3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98CDC3B2ED6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4464522655E;
	Mon,  7 Apr 2025 09:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GMza/jJi"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011051.outbound.protection.outlook.com [40.107.130.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068231AAE28
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018786; cv=fail; b=Url6iptCD7dkM82OqCgxNSzpo062+QVP9+n00KLL4MjvzphMXJ2bpGQ8nqbSFSXfbHQBOj8cD2luFuVgjEWhhd9voD3a5EVyw3DT4eTlFyCN/CSj+bcNJPwGJiJUawhkmJBwNy1GG/1MeNcDyXj80BYGbF77A5DebEBcQSWEQMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018786; c=relaxed/simple;
	bh=zP99Qlfl7dX+602H7WN+wPhC7j4aQ/t/rGcLrMZhtYo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BMTr2SC4zrmLcGjmMDchR0UZgT6/tDLi9XXXn9mm68X6e0mou9GOoZt5eQYRRR7eN5AJ0ysugSjhHYN4MEORh3h01PocIFXE2y65n6wNVzq3dJQx4cdWKUUqaDlWUig4NdteAxLa+FOREnw1ms9lsJkHyrcS7YMX6+LxtaPwBYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GMza/jJi; arc=fail smtp.client-ip=40.107.130.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbCrGlyUpb+kV3VVLx7xFkw96q640kcwb6kmnWa/DohNzo3kkwwD/mk/94aRQwqbW0XKnYIsPezQrJGz5K5v5OGX7r3atKDY3y+13NO9NGam1YEKDgRfcZgygJ9n+n3k5wjXoxzZKVVwjeKWcOEzW1Qu5aGuINyPfb8tTMafvBGs5f9C45ogsUYeFSfgDqgTx6h8xogMZqUWZh1jBuGZXVBtDVQ64/nu4q2C5jwvNml9A2tg3A8BD1vgpP+3ryidfZbTlopnVCWZqCWA0Kne35iRe2Ke/sgXJ8p2gf4s1ku1cmyupBKJftbg7G6R5NBfQjJJdxU0ZT0t2BpuvyzpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMDvpLqf0hAU5l0MxJHvHYI1UfwHJmZDca9Q3Ysta14=;
 b=r12COU/kJBmNvtAVvQ2A0h+B8iaeu1OHx7wYOejs0WCXJIGDTYLMA4ruDKpehA/54e3f08MESZznN/dnS2k42m99SF6kt4MXRs/zqxGxKK/jhEHIxn7+kwsW+sMdhz3G4pb+sbi7+I4xycKBxt7bw0jper9MP5z4qkHQ3HSP3dZQQB4PhIJwGLLfvsRyq8fLInWKt5H2FplaDvPEdhtL3oLpOoBuG8b9V8cDjGgS+JZmY2NC5WpnXesQ3tQjqv+S1SrVvZj1EspwtAROMznwne64Z71D88+xPphlLx38VEm8GtldAEhcYEraJVQTm7tNWPms6+LdtPSixYuu2bDbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMDvpLqf0hAU5l0MxJHvHYI1UfwHJmZDca9Q3Ysta14=;
 b=GMza/jJi8MiEk7a8NC/95niEmBWKgzOqNuSCcOHDia/azcDMHBB8jlxODK69Xo+7/yBE3QvIhRDjCTNCtfCKc5OWtFXBacSTuQ++rcEj4DnR1qcvVsoApIhr28C6VkPSAPjZHBPDfKWj06+09uzuRRwXnX57IpPjuH4dwY9ctQfU85KDZKyzHZhmsNGA1PDPOhvdqvNtiO5Mf0pTJg/uUxzmQRb0EJrneP9L+ffg4SNE/57HWR6xhHTNRs9+t5r2g1K9JWAIFofPv9A03/0iZXZqXTmISkBtSvLFHuRNt1D9jVruQ691Aia3sJvYubgnpVbgfaNG6oae0rWU9QUm9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10308.eurprd04.prod.outlook.com (2603:10a6:150:1c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:39:38 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 09:39:38 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Wei Fang <wei.fang@nxp.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v3 net 1/2] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
Date: Mon,  7 Apr 2025 12:38:59 +0300
Message-Id: <20250407093900.2155112-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0039.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10308:EE_
X-MS-Office365-Filtering-Correlation-Id: bfceb78c-83e9-4446-10cd-08dd75b81d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0oymF06nKTnk0+PrRin3ykuYtGC++DFyHBTNQ4DlkFunSDippRQMBXzBrdt?=
 =?us-ascii?Q?CFIirEGjrY/rg7fgHCNOjJxZZ8YLVs+nnDm3Be7ccDST1UCKoCReN9iITeXw?=
 =?us-ascii?Q?DeM9FvUPMgqnevacDVAFLOmkwF49zSyF7MGmyPdWnzamVyRA+GzrpXGGI+cV?=
 =?us-ascii?Q?WWqHqbnhyu1tym1Sw5nCpjHLmOuCIHd1lRFw6qL6OsQXmajjQD0cxYBGO6iv?=
 =?us-ascii?Q?1xakw02aydxnOdoY/Sc1Mf/iYW1dZnGHsTIJ0o9hVytIskOSOcAqQX6yGvi6?=
 =?us-ascii?Q?oraCpEMHhY9evKEtv7/aewk5SXyDfbCfecyU4J4303h/63bkEyEBnjhLmXr/?=
 =?us-ascii?Q?6QGM+pTHRNeobL1rq1yn9ALlxrmBP+/UOo4w1tZ7dbWFEGThBjbVJAsFQy8O?=
 =?us-ascii?Q?oTcCj0BhFFa0fPztZ/66cr32VXbpV3ea4DjImo4NBalXnN+WV5pw6PF8DgrA?=
 =?us-ascii?Q?8/f/90gidmAl3kUeOEUUNIAkZVaK79JWeXjSounCyEqFIVvyivJJZr9e17qW?=
 =?us-ascii?Q?j0GsCqZc+EQN6uzj65nEyp/aoN16llOM4aQkMp27zeRL0rvx+Favyl1vfCH5?=
 =?us-ascii?Q?Cpi14rvmrcwE2BfcteT9zc6dCPe8KkX8lIpn7xhajEQyMXWY2nvpgUcEOtF8?=
 =?us-ascii?Q?FthWJmxshzBxXgQEXLQH23ghC4uswlsCkWPNz9AYNa3HpCiyZNf8yAwjJv8F?=
 =?us-ascii?Q?hqac23Uc+S/jJNu3x+/omccUyZgFNX9uLDggOf6zz/6RYQmNZG2VEz2ha+ej?=
 =?us-ascii?Q?pFKYBS9Dgtmc3rLKWKg2udsjqBtXbkC9mrl4UW343VXksKb9lIfB4HnUmepT?=
 =?us-ascii?Q?qvO3ebKEzM12N7iXdXADoMR8gf1gRuSRml4QfhsufbTe7o3vlTgIortTvPx3?=
 =?us-ascii?Q?hnt265lLUGFpV2WeETNvA4/j4IL7L/ER/xx95aATk5JLU8fq7DzhtvBcoWKf?=
 =?us-ascii?Q?aMOaPeGAOOAlE6l89e9sqiwl6ttIrYuovbthpxb1IZ93sZ6N1mjO+Paa9Lhy?=
 =?us-ascii?Q?/RHRtKlvb7BVo7SbVAovHA4AZP9Wh8Ngz5al7k29nE/Pu9KbzAmfS51NdeCL?=
 =?us-ascii?Q?zeEeJKbe97vI8Fx+dWyF8TPAQ29qKSxS7nA62gudBu8Ncxkulf5ohSYMk+3U?=
 =?us-ascii?Q?zc4118XNWCNnGCXAK7dlx0DMPzDn8OfepGBDoTPhOZTbIdKKKLVAbDebDKjz?=
 =?us-ascii?Q?0Za8LRBU8qgiP9N3dAxdK1CpHrmujyKqLcIfiLsxWDpUvP+6EoJXy6baSDs9?=
 =?us-ascii?Q?AXv9jpME0k+qlnhpHZSUT8HPNgsDoWL/r/bB8qSyPksVX6Xs1Vdo4sIQSxpD?=
 =?us-ascii?Q?/uxf6TnK0c2WLY3tMOounrbdLrTA2rM1STm5gpRw7WQs79eeWDpfvoHo35uf?=
 =?us-ascii?Q?So6NB06isbSQ/JjRgq0bAuPNIk63Z32p/gU/mTzgStwqjylMloeeWKW7VDsA?=
 =?us-ascii?Q?D4edbtcHFExHh9k0sNdFygYa3pQSThHE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MZUywnU8kG4u7tI/0EcQvG8VTwvtgLBFkkPL98cyybsDmGVnYVLysf4moc8J?=
 =?us-ascii?Q?N8Djdtlq9lKXtZKHFZJ1kBx+TrNmaJSzVws9Dm958rlEGsbv8lra2zrVHBgH?=
 =?us-ascii?Q?FRrs4FbZv3TZoaPB+c5zf3Fh49olRTFYfty0bZFRfPj2gNUz1DBr1PuNsw/8?=
 =?us-ascii?Q?3qu6Ppm/w/aYrG7oo48KDqC+0d92u3LXpYFMpG3mC/zTcvdyAclJ34xEMGJ6?=
 =?us-ascii?Q?MQiKnMAi55iVvDvQzzrTWp2tQxV/miDPDAHhA0qHX0Lq5Ttj9284iuXMAFjC?=
 =?us-ascii?Q?zQ1nUkdi9e3rycQ+5DZkV07oFo/meX3PLn5+Dnnf4WDx0NVcf2LBHhbrwtL1?=
 =?us-ascii?Q?WsGr8SZXVEXpS7+diAx2OqXcfOSVxh/gyN9WfsFp+QpUw6IXWHE9n4awlAg0?=
 =?us-ascii?Q?qvF4bGldzlu40vk5mtRi/Lft6+ceNPwu3fU1yTZ4UpL+HWpnimpKJnFFqDI0?=
 =?us-ascii?Q?5cCzG7LyzhmQK3nTkrQ3ieeFkdbC3I7MSGscPc74W5b7YlEIGybejVqaW8T4?=
 =?us-ascii?Q?VTwdsZ4iIKwmvkWrcDbxjYeiot1UY9Bzz8DcdJ60JqR+i4P4JmlTwQieSQwB?=
 =?us-ascii?Q?LcOeKgmSprR6GF5TjZ9rRLA70Bt3DvsiV+Zix+CcB2QGuUk+FbwXcvayK8VZ?=
 =?us-ascii?Q?N68Q087G9b0I6aAjHpAv8p7W4wJfC296SdIYDSuS1XqxoBLswqrPERmQ9j14?=
 =?us-ascii?Q?gG8kpvGEIbP72+4XNJ7+1BD81PY+uWerTy805xuePd5m8QhraWod9A8+VkUG?=
 =?us-ascii?Q?uNd6eFk7zOLRT5GSEoR4zGzC5R0LSG7fN4DJYgHBX4Vrj++dd05lF3PDvaVW?=
 =?us-ascii?Q?Q1i2kmMesl1sJGmtYp7PIs4FanSN/2nHUV+EvkiQKouQVAt62WCsW0zgiL1b?=
 =?us-ascii?Q?YF9RZYOH4GcTzrN8GiSVf0T4QNCDLXNIbNuJTCP2FrQBwZnJeQ6kux+yLMR4?=
 =?us-ascii?Q?LLVLwLMaHx03t90IWHbQFnOOKytc09mFL1YJAKjlU9szMaDJNoR1HSEMAtQ5?=
 =?us-ascii?Q?hN+YvWHWlopMrk8kWBhfuV98XUcucOhbrKtQLamDyMbRnLiNIuU1BzG9sBn1?=
 =?us-ascii?Q?QpGQmN280eg18z76JQRHsTLmG9socqlqOjL23EvvZBVdKZDl3zQMjUAUaFSW?=
 =?us-ascii?Q?uVAH+GXS9ATjA5lv6YIqruPJ848zKXyD6Il0H7mzYgcH1Go3HsjL6rRYtmo/?=
 =?us-ascii?Q?1dNG8GxIt7gRAiVuCCRVtObF0HdJoA1uB+ZY03X7sIoG4yKaJSBfSPVx97LN?=
 =?us-ascii?Q?MvSIh28ItDaD8wqJIE1DzbKte9wWTe5J2g/IGBvklHzuiQqm54iRzSLjG0s3?=
 =?us-ascii?Q?eVdnCTV6kMUAbDlsUMoE0Ep8sAistq4gFRL1Bc4KMHMAAlM9+vOeU3AN//Cp?=
 =?us-ascii?Q?xyHwntKURM6VauuiOU8O0sTPCPMqtRhw/eACtnIrudZSuMaH8wbdiFA4E83C?=
 =?us-ascii?Q?c3DbceCDNA7Z4rfpI3WL+h2A2VGdh6U4JLOcGsxTkoHhPJ+d7KENwu6AsBqN?=
 =?us-ascii?Q?yglXv4GID17gG6jf0LcaCZFJeVlojAwDOJcEV8GdFCNpk+8XngjNX06VWjJY?=
 =?us-ascii?Q?H71TK43YwGa1q0iR94WKAD9XNe3p7oCGEIqOCTId?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfceb78c-83e9-4446-10cd-08dd75b81d2d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:39:38.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw/+vq5vq5CzOsZKujscvF9NSH9ERfcl5qVjOZ9k+82xiu2QGBQY2X7detGav9eiOEaO/kLhoNfnnoCc63kfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10308

In an upcoming change, mdio_bus_phy_may_suspend() will need to
distinguish a phylib-based PHY client from a phylink PHY client.
For that, it will need to compare the phydev->phy_link_change() function
pointer with the eponymous phy_link_change() provided by phylib.

To avoid forward function declarations, the default PHY link state
change method should be moved upwards. There is no functional change
associated with this patch, it is only to reduce the noise from a real
bug fix.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2->v3: none, added Reviewed-by tag
v1->v2: patch is technically new, but practically split out of the
monolithic previous change

 drivers/net/phy/phy_device.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 675fbd225378..1367296a3389 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -244,6 +244,19 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
 	return wol.wolopts != 0;
 }
 
+static void phy_link_change(struct phy_device *phydev, bool up)
+{
+	struct net_device *netdev = phydev->attached_dev;
+
+	if (up)
+		netif_carrier_on(netdev);
+	else
+		netif_carrier_off(netdev);
+	phydev->adjust_link(netdev);
+	if (phydev->mii_ts && phydev->mii_ts->link_state)
+		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -1055,19 +1068,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
 }
 EXPORT_SYMBOL(phy_find_first);
 
-static void phy_link_change(struct phy_device *phydev, bool up)
-{
-	struct net_device *netdev = phydev->attached_dev;
-
-	if (up)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-	phydev->adjust_link(netdev);
-	if (phydev->mii_ts && phydev->mii_ts->link_state)
-		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
-}
-
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
  * @phydev: target phy_device struct
-- 
2.34.1


