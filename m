Return-Path: <netdev+bounces-178832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADADA791E5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB941658C2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3611223BD09;
	Wed,  2 Apr 2025 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnCSctSo"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012060.outbound.protection.outlook.com [52.101.71.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAC2238D2B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606570; cv=fail; b=cOIR55mSazy0yyqsISyA4iVwZggiesDa54+Gx+6GAK+as8emdpnIrtRdbKnZH5mVvvBJ1kq0Qde7E8LdJPKmsxrLxuBPCusVcJ5q5jUyGMEOtZLtJEHcdX7Mi5rtFne09zymDmIlX2taSDfrsSMgC/6e8Gyc3lr+wk5B8wAx+EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606570; c=relaxed/simple;
	bh=lMpUmxiWmgN2w3/TGHxUNmVpFB6HyO9MuCVhoCkGSvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gxPRh2lcSv+JFgImcl2LQDmjwmLOpfnba3hwzBZeb9lyBvFZJ0qmoaiqCl1S+nIt36SkqmGQ9tGs1JT4AiqoafQXkID1Ydz9UT9k84KN5x0KYZMF0dRMDcGxLDAaiicb2HKjQ9ZfDrhd+9wLkQpRCoU+6DWr8rFQwD9YZj1C4T4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnCSctSo; arc=fail smtp.client-ip=52.101.71.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlcnwPliN4PRO0fQOqAi1Qwbit8bGCEnsxznGCTBwPPWLzcXPhpGqGvVoDwtv6gDxPbAt4yGeuWtyZZAKIZq//+0e4psuC0Dc6JAzf0AZeaR8ySeZ+nGEIesXJV+90MrtowuG54MFqJYXZtGsSYf4d7yM+mGHAMyFzMux+2k25j7E/9z+zzqM+bZ7cy2cp3g/3TiSrd2OwqEW2ttvl5CYjTiPgr8X2NeQL7MYu9eQk3+LuobAvouPvVAzaTr9EC2sB802ywhrT0W/MgSJzaMHkZxrAQupro/WUf0x+oXbqHx3lX2Acqoj87Gazh8lB9kZawEdtpAgt/k5qv3wQtn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjO+99YcsFPRjz+7Bwno//qVHlN76doOn0o6QttQZ4k=;
 b=TIvkcnVB+v2hkTbNiilDGr9/5ODYw/ilud2j5mwscUn8v6R61lLtDcgAIcvXTdvKQfFaL28Aq6wAaUKP06DDKneCfv7miY3NXa4L6cyoLYO5zdm7Vfpt20ITJpiQC/J68808HQ5+wajio5zwlbbGqQidp6VJwwuxJPCkGZ7RC22lBTnUw3EDyjWD7HuPFx+EIbYRPEEydMMhTTax4WjuwWQjlT9b8+Q5xxognNGBD4zMbofq7DZqOCne42ffIW+OmUGRF4Fzwn9HCfe802WoJ2YGcj/Vc1wuSw5TFfD2tGzC2dscjS1vtp1p7DTEaw2BGTT4RNKLFjp18FAon8TciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjO+99YcsFPRjz+7Bwno//qVHlN76doOn0o6QttQZ4k=;
 b=gnCSctSoq4RnsMzxlzqNnvy3en032UzqZ0jxCCE0fATIe7rU9N1ZpCuE97RhnNtHKPqupwyr+QZsyf142Fs2H+qEful8z9VC2M+bzAMqNhwIhbbM1c3q6smfh1CqbmNIafEOxxAQfoLeGyEdBs61LTf9tQfXl0PO9tPedYvc843vA0IvG4Yz2up5vrA+7cElbvE/TFdWWd6BepcoU4Ca7otIl6Sol5E6baTU47KX5kSIepwpoQ4Aq8jOGo/sujbl03AzsoGAdVAYjgb29ePv7ByZ8FfLp4ehp2YxmZT4KVCmRzPlxgVAuTLFZZGJ3vpPbTgDQilI+HvVttcpur5O+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 15:09:25 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 15:09:25 +0000
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
	Wei Fang <wei.fang@nxp.com>
Subject: [PATCH v2 net 1/2] net: phy: move phy_link_change() prior to mdio_bus_phy_may_suspend()
Date: Wed,  2 Apr 2025 18:08:58 +0300
Message-ID: <20250402150859.1365568-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::24) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2340c827-6b7f-4188-9293-08dd71f85af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJbNPtUkfkstM1YOPYX4ZpncgyQLHUHQjKXVEyAF3n/NG7xe6cn8Wn0KzbAt?=
 =?us-ascii?Q?ZNwNBdPJ0N/B9yKcGVu78wFH4AFTtVgAFe8nCPGEDmzHgxeyB84HDbNxODNj?=
 =?us-ascii?Q?oc56BlrkWZGr8wbvf65iLog/UQMCA+GPLeCIwZc4ppcM1uFmZ1NDUh6u3qat?=
 =?us-ascii?Q?zfmHlbduGw2UH/+ucC/GFbHW3VbwC2QmdZz81U7cnfIWlgHg2XBcwpqTJYqg?=
 =?us-ascii?Q?DG12P+c/Td9BW0iuS807rObja6SQo+d/ks9gNeulPdwYe0TMDRN1+E91rZSP?=
 =?us-ascii?Q?KoP6DfabS++2Dgua+343QBgO0Kulv85erM/gfsRxduNLGhXq6+oL8c89RYz2?=
 =?us-ascii?Q?8HjYTn2LPw9SOES7tM6fzkRCE8oLNcmY7pZVlcOeY2daevuLt1+bdWpe6pDP?=
 =?us-ascii?Q?sYWbKPksMJrgAA77DwZPu49bK/UBOI4uXZVQSmXe3l8yNWH+qHOmSg+RdiD8?=
 =?us-ascii?Q?gUSg7cUifuHEUed//n6TC4tpIZ/96pl+3D11OfFFKt091yRe3vCKUBwW4cNO?=
 =?us-ascii?Q?wrDthQ1q0LOISzJyY3GlVnX51mlA7fnkCY3tgxBNaw3Ra8RpCzaRVum4qlAD?=
 =?us-ascii?Q?e/avXFwwG0RGzNT3ezSvV/++pzgXnCRRgDCFtzOe2P++KtO1k7zGhGZFxqXU?=
 =?us-ascii?Q?1D3IZiVzm9X2TXngVOTFA6CniQs6hnWRFvuoMDS9YKps2hvB9U2Galr84/qg?=
 =?us-ascii?Q?SckU2E9r8Iiq9Sa9vCfWyhagu989IAvgFSVX1LBDrZbYjYQPlQAEE5be9/16?=
 =?us-ascii?Q?6pagfjIHCwfRApmulce6wm5EyrKT/TIFSFRcMzL95cR0afxGIsNajX29oBAh?=
 =?us-ascii?Q?smzpqd2KwpPaK5pbCPkaNm/CrJvir774M7jevC1ZmvM0ptWHDeeV46hJIIsb?=
 =?us-ascii?Q?XE8MIKBiSti7xz0kF4UMhNa5l77npHYpSh695bVysdG1snY2c13zjf6VEVBz?=
 =?us-ascii?Q?cWOJI6LIsKDvakk2UB02Vi/lWYN+6peBBn2e9pI0j0ks+FKgXWSfQQwPfj4A?=
 =?us-ascii?Q?eJAuHESaj2u/nBVu+wjPClfSHxCdmI8hGBDvlZFWCOuQC7mlasNXlOx7SX29?=
 =?us-ascii?Q?Sh1pMzvmdt9dC29In+LXmx5/qh+aMrlKuWCbhPewpMAy1axS/RU/R4av4EUI?=
 =?us-ascii?Q?0PSPwcctgDFj68qrrHRrUZzQksrY4Son241Vfr8Cr/9gqJDrqjuEU1G9sHMm?=
 =?us-ascii?Q?rP+zAEsgF6Trym4l+ZpZLDUdi6oRODB7Kxh9UWG/qS/kHwtT4L88J/oC3jKX?=
 =?us-ascii?Q?YlV1pezB38BJ8ZVGx/8G+G2zx2Yq0pvfy8Ywf59a0e+yYY4lKzBhScdeD1z3?=
 =?us-ascii?Q?EDExlMMkp6E4yZ72ZykKdCLLmRLKT+3uwCc9rEJqU1NK4323Iwikrkw6sJrW?=
 =?us-ascii?Q?OGb0c0inmcUw7k/WRwxUpd8VTsW7SBgyAAnSvdZZJt2MkXJw2rGSD8z8hGyI?=
 =?us-ascii?Q?q7GaoKJDep+bnKovjDzgFNwUksFALMqi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/Y6NpVLsFqNTsv+dC9/+hUBAppTw9ZXPcRqjnVsosWxTXMYMALFbUh6ns1t?=
 =?us-ascii?Q?PGoz78P9ZyQa3hIgLufPB+hiiyNtCpjYOKP39xyOmsQKMBWaKqXi23ZVkIzb?=
 =?us-ascii?Q?AG9zLak5R+IGUwStwIKHwuFzWTIIEVPLhKo+YIggKN/YRT2fBg45c1Q0SUQM?=
 =?us-ascii?Q?Mv2WTSnRQzF8yO++Mwa3YsDf5TPnXJIUk/spTkEbmgdhM5Q0LPH8N6TNetfp?=
 =?us-ascii?Q?ATIntBB8xhVn4vTNQfT1AXQgdmg39ZlnoB7V5QJH1Wt82yZ0tqRGF2G36EFs?=
 =?us-ascii?Q?wnhdkPvSWuvUSG30kTStGqxtGhb9NG5gb96Nid7Wkbi2LzwzAWORtOdre1K/?=
 =?us-ascii?Q?IJ3/QlyETlFDv7+LXQfj99S8EFJSuyWzFARPVKO+EuoPnySVW4DNg2fZ9Ono?=
 =?us-ascii?Q?qHvUYxbwi7CdhCbglGwjNzOzXtwqznudTKY1gPDhbvAbomucb4LyqWWS8w3l?=
 =?us-ascii?Q?2zgAom4wALnWfFVQranhj7lOWrn5wFPlE3iAn508Vjyyz6FPIwsyd9zRymOG?=
 =?us-ascii?Q?z/bp/XVITlqrtQ6oPTWUr0f5ayR4WtdGIJvl5QvkKW48ET4WDnp9NMcTWvGY?=
 =?us-ascii?Q?X+Rj3XqRFGzY/4JJTTsfXIC3pvuY7Tr9mLfHvB5VkQAHsWJ+FKCIlGfD2XtK?=
 =?us-ascii?Q?/tVeLdbzKo+N8+N5NFH6/tDKfpAdEjd/aJrEq6mQ7YxkU7kPUUqRiGScFTjS?=
 =?us-ascii?Q?5n2t8jmaOGgksWWoj8ACDU07iKwTkpIjUTTmSCzIauQuVS8W6RM+g0mf/dN0?=
 =?us-ascii?Q?t/TSWqGc+dtHsIZbpVIjILZRy/IKdX5kJzgE0eArxwLQMXfAGIqFQ4BiFcWw?=
 =?us-ascii?Q?eU+Sgcr0q0bzOc8eQwXdsTXL1LW+P0VEVFLG2BT9U4S+PUYUJHeZDz8oAa7R?=
 =?us-ascii?Q?qwXHS1slqJAMP7EGbkP6XTVp6Eqq7xNsoXSiGUJevxOKDHgBS+tzFXGm5XSe?=
 =?us-ascii?Q?LLE32XewBbRRs1nHekXlTnonjuyz1jHhji+/AhVZdk/cYBotb1VapLhEd3NW?=
 =?us-ascii?Q?y3g/uOwwSs0D+9nA91aZi4tuuCm/shA4kuv9HY3D6XelfeZ9dpSgMWvmgwQb?=
 =?us-ascii?Q?MXavFDcqifV8lT1qWCvD3cI0OjpZGJQD5f6HRlhckMvPOTKnixQ8CD48WjL7?=
 =?us-ascii?Q?hTJDA4cPA5kWfD73xZ5oo/KQCLx/YGefbIgOlvcfyN6AgRPjlmndHnmYPkJL?=
 =?us-ascii?Q?8SK/2yDz0EqrUeouDbpIW7YV4Nz0SzXgmhiAdT6L2qskkViKn1YiTIwH16ts?=
 =?us-ascii?Q?VmfMRjDjbgB7XtitFOLiFa6DoMGWPjcLGabV/uJKDuMjpW5mMpVKtz5ZugYY?=
 =?us-ascii?Q?yMG6cPk6doV8DFfKM6Ijju3z978MyorvyXrxv+ByAEVsfG9c5v0zFvBD1aBK?=
 =?us-ascii?Q?/U6sQniav5/OEAbW0oPzlGAThVc+xK8tuxc1eHYLqpCnPFZVaL4ITYyKIDdl?=
 =?us-ascii?Q?zKmtwjuqvey+EUO6RG6tIWlkv+RHeGdd2doRhwXw53dENX/b2RuXMCvHu73l?=
 =?us-ascii?Q?3XPwlqgksY9+HPKrHY7Tmorgrv4aPSFynpZKEXs8aHOLWt9NGLmYonzQR+Bz?=
 =?us-ascii?Q?P6epsYK43U9UTbFn6DZRqn1Ah2MFQcME9pCrc7oXqqdHy4EDRVWnCJakkj7r?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2340c827-6b7f-4188-9293-08dd71f85af5
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 15:09:25.0972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N5dTBou8YXMd7tdEesfAhosjmIfd+oZd9zga6REfQO8sG9BLiVWAOaNPzf3CzG8Q3bLQCZMKhg3lrs/LlDNBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609

In an upcoming change, mdio_bus_phy_may_suspend() will need to
distinguish a phylib-based PHY client from a phylink PHY client.
For that, it will need to compare the phydev->phy_link_change() function
pointer with the eponymous phy_link_change() provided by phylib.

To avoid forward function declarations, the default PHY link state
change method should be moved upwards. There is no functional change
associated with this patch, it is only to reduce the noise from a real
bug fix.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is technically new, but practically split out of the
monolithic previous change

 drivers/net/phy/phy_device.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b2d32fbc8c85..bd1aa58720a5 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -243,6 +243,19 @@ static bool phy_drv_wol_enabled(struct phy_device *phydev)
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
@@ -1054,19 +1067,6 @@ struct phy_device *phy_find_first(struct mii_bus *bus)
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
2.43.0


