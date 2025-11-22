Return-Path: <netdev+bounces-240959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A4EC7CDC4
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 12:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A423A920F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA152F2905;
	Sat, 22 Nov 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJDrgaHu"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F178A2EE611;
	Sat, 22 Nov 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809485; cv=fail; b=R5zhsONab0LE5EehrY011dIDAKRgifADpJE5DbccBbygAcytWTtuNMcun8aUWXYj/4F5hXCkF+y2HP6OS0LM60hbRapPHl1wm+bTPdweY1MxvMcaF8E5XnO0F4WrVApRva/MY/UqIyTay7ZC+qzQsG1rnuyrp60qUpIeYW7pZEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809485; c=relaxed/simple;
	bh=5++H1kJaw5/mC9rcqYNEgmA2k5DzGpL78ualORG2l9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KjEir4PGKr6KasSkyEqccH60wYkh25JRrd52vJHa6+u26JT6hH0//qx5YsiftAq9RadPU82NxvqC5qW8nsZYZPNNFOgQMjemHWGkzygkI9V7iolr4TkHv6/Ot+2mjRXeIsAantspwL2lzyxhS5cChCE11Nbs+q0cyed9Z7zwVAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=fail smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJDrgaHu; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwJvfpd+A4Nol+CCjD3obpnCQzGOLDY1LJc+2/X8c3s/vb/SM2JXuYobpI4CsKkIIKEHm2U1AjuaFW5T+KwJ/E4wQXM8/mBP24zBvQlHJNhxt3TMH90GjzrE6QEo5nN/LBCcMImv71roh9/HpITrqpkvITS7TR3I750KdSZBNn2K0hj+sOq3WMdy4rdlxTEcWS1ZSx1G9Lyc3IztpDinkl6d/gkYVw7+n8Tdx81HvtdDLaJGDNtG3qv1vAXxiLmansPiem+Z+Oukr2u1/B94fXy5KulQsRdU/K+K2XSnHOFzOAEWZLXA5lPMkny+5z6ODgPXxTfvbt1qhAh8Y7Qauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwfZ1sB3WSOQkZwn8yhmNOOLhhQT3/Jeo+TH5qlRBh0=;
 b=yaVC7tfCj3XnOF0Rdlt7b5In4KqXjHp9mMUqeHqGszdGUIwT2uYPVUjrQFk62hYIRcPQks25jKsECyqluTAh7I6f14AOP3HqdoModx5P5l+mcirRDXEBYPlZo1DiXYCG8fJEOD90km40v/xZ6Yi4Hdy/BC1xsJUb4BpA9A9tzG2SCplQBD2PdMa1oLgfF3LIQ3HvPCYoiFpbdO/UYkJa2/R6fPvYTOm9bLrweWsip8DaXGZErI+ZaiaXgW+siZzEtwZMWr1pDh/kTmCGaeGgFfRXoP2Nqi9mN1Mh73t5cj6IwsyNpgwwUFvJ1Hs9B9o0VVwsuJrGm/TWYBsqlOe8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwfZ1sB3WSOQkZwn8yhmNOOLhhQT3/Jeo+TH5qlRBh0=;
 b=BJDrgaHuewLQU8VXRfrIAUaMZct7ZzhGGGIq+caFAmg6ceTaI0ilTBzwx2Dhu0wHfKmh+WfqpCmLBD6XFAp4AHGaUttFz8ad6OqDyTu7SPYt6Pb5q92y1+Y90FNytklr4whSC4TXC27zzoKBFxlS4rufmCMr4LP4znKR/l4ZtnlSqRs6mCl5D9mY71+hrzqVW0p8KQgBCYgFY1tXLwci/vDo6MLxrWz8WhBv87OBOabrsosMbNNbnPjr+2JC0fQgzQ3v9cpNx45tCyKoUGZNFygeax8illSdw/nax7tRMUDgYEg9RFu4LqlDB6lgtXsyKyjFuQD8KiidQyNJjeq6kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 11:04:40 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 11:04:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tan Tee Min <tee.min.tan@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: dp83867: implement configurability for SGMII in-band auto-negotiation
Date: Sat, 22 Nov 2025 13:04:27 +0200
Message-Id: <20251122110427.133035-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DU4PR04MB11056:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3845cf-0588-4a79-6f1a-08de29b6ecdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|7416014|376014|1800799024|366016|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8w1nr8umRjykT5x8th2MWQlFcU4mGX1FHby2haGaqgtDynlZfS2i5Jq3mrg?=
 =?us-ascii?Q?f62d5rbaA+nKWdkT0AgFqkPJTjzdPwYoJHqLOzNTVVr2BJW1ucQ0j02sEJ1l?=
 =?us-ascii?Q?EQ+S8vc+Qp4fnlyn76xR+E+gYCHLcIf7PH+cIh0kb8HpO38jJiQwa5bI7Ron?=
 =?us-ascii?Q?qp3sRaNwdXfJpAs6zC/uQqAjNLdOrGmEAcf2cmQq85QXZ2UOwkZz1WL2RWE9?=
 =?us-ascii?Q?HClO49HTgLt/AzayyH0JZmkpsxecnhKZmsnhIM/SA8tNqJ6vyCTEEAVZzNy8?=
 =?us-ascii?Q?UYKKq7s+6ajgPaewnfEYZJY3YA9km3XEV+A13hnqJrAY3M2C75NuW26kzNvG?=
 =?us-ascii?Q?EleZzvzZXJzUb7vdjYcQnSlgXFvj/x0UkS0gx2qNdOe+Tdv6rxT4m1J26Rla?=
 =?us-ascii?Q?MIDm3HksP1PMb9aCRVssXyY596r9SMewJyhpMpCmWb4wzO5W8CyGxknRVsGI?=
 =?us-ascii?Q?cf5+8biqj2G6Xh7tFyzdbBLEPMh7SDAcJWNXoHt0+3YASkS5XolQu53Kz/eo?=
 =?us-ascii?Q?158K6p1F8KMsSY++0EffLBfVMLh3+9aahnJZz0lYKPI6LuKL6/7LlhoIlifo?=
 =?us-ascii?Q?/PJSRcw+yMi2n19IFVvQFf2hs/bLLrzS8bUM/+ceCQ4dTCGb55qEBDENVumM?=
 =?us-ascii?Q?eYuppscw+Nzyf+RtpchBVRjR0ykqSuLHLUQEdvC46VSBSvgn3XbJZ2aUvgHQ?=
 =?us-ascii?Q?lptV1SPdF0XbjhLF5bZuQ48twnyuDRbLSWj+fLx09V33He4F3XVuZ8phcfAm?=
 =?us-ascii?Q?OH3dE+FTaxtGtSk3LCGct6cdVJcRbsnALbfqwXyBryyw+zLGA10eUZCr1k0Q?=
 =?us-ascii?Q?CUFqwofrBk0Uy3gpR4b82DfJifBuGfOmmxaN4tgQqWZThxnFMLC5UuXJSRS/?=
 =?us-ascii?Q?kTbq/tld2Fa+pv2NjaUoPXFC1nIFDXzS9bQgXB6a/F9N6yJw41XkJFwGgrf7?=
 =?us-ascii?Q?WOfPiff7ne8XSQUsvaqtVJ0XoFZYenV60KXqnqoyFQFqtfPTviDsxBQetKiX?=
 =?us-ascii?Q?p9iUK5OzGYZWf9Ncdbtds4orLuUcYOZZj2I0TX4V4A/ZOLHAX8IpRpJZcsXH?=
 =?us-ascii?Q?7NQ+Zu0zxS79otTyIc9VFTGHD4Reghc46ueo3zi09hAT+jLbrKNYkGfeFozr?=
 =?us-ascii?Q?E77g+GHHAAKBPibmRcms3BisJoSnEpzZJQoNrO37cD8dD2YG7/jGBXx5d/Z1?=
 =?us-ascii?Q?ifm9RHfZ1cFoxf5K+Y1e3HuygrQAYV3I3jPn5/gSh7ejzpglGj+faKJ0jyuz?=
 =?us-ascii?Q?Lb9rBse+6cPEKFy1fyAfl9HYZsq3TvSu/fIdqfR2VyofXGxyrZn7wpZJZBdK?=
 =?us-ascii?Q?i3XdRu/TBhPnaTW8U4zVm53uRsLcR0sBAQulpaIFCro5FEMcbDDRP4XZS0Hc?=
 =?us-ascii?Q?EQj3nBHnQ3VeIdwnwegkk1r+R4sM2noYxOQhBxTfcO125Y9DGN+NtCZ70B+t?=
 =?us-ascii?Q?8U3VyD4cm8Anz5SPyhjxqX+cinQ9mjhk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(7416014)(376014)(1800799024)(366016)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34ow2umoX//lZqgbPiR2K1XO5HG+iuP5B1BBnsQYStzu51p7eJx0KKlp7yBs?=
 =?us-ascii?Q?MyRH68Q36PPsDhfImRoyjGHjCzZAHGkX50QWfGwH7rN5UfEsiR8zT0LNp59u?=
 =?us-ascii?Q?RGJb/hPqrNFt6KjOpbkDF83NKH1O+y459cvadKV40+z1SnPqi7dti5fpvOZu?=
 =?us-ascii?Q?3oQCMMMNlFMBAFYr7Il6j8jxqAowZCIa8OtZTZHs4XBWKONN9WNsB7teY7h2?=
 =?us-ascii?Q?dY2LDU7bp/Koold12o5Wtv324e530MayNI+3unOLUf3EVcfBuywsLcXS948Q?=
 =?us-ascii?Q?T2ZAk5N1dW/2fD4jZqMxNpyWCMAE65UpuO2iiPOwdd6X97rjH77whsiQuMJp?=
 =?us-ascii?Q?tfz3oHqqC0nnWMlGpRKVeXHz0c9puwjIZtrObC/Miou+2JoAnP5v95UBjUBh?=
 =?us-ascii?Q?hsBM5c4xGp8aX8NBCeCraHaDqcsS/T8Po+Tznfpt7WFZa9PCn6awluMIeRBF?=
 =?us-ascii?Q?sb1tfdLkFyWLubJfcaYyY5G0tyk0AC7h3PruV+e3q8WTugTYX2HHxjVYHYMs?=
 =?us-ascii?Q?n9bMqo58IZxAkRmL6rtBGYEEZvGszGImYOJmaDlPtWvn733pc8iBECQGx4+Q?=
 =?us-ascii?Q?9a+GEd1lYRIo0l3VfwAQv2ehpLgtY6Bj3DD/wCpC03/ToK38VldGJC+PpIDo?=
 =?us-ascii?Q?PIAvuEpOeFtWzbq3x9hfZ6dl/NF8B6DTm7gUlG3u0TmX0fVuReope5Whj1UV?=
 =?us-ascii?Q?U67Jv1XScrxMbSwsIr7+fygI2LsC8dcXPVhXA1h2+KEdghByh1uxqJJlG6zO?=
 =?us-ascii?Q?AVzIPOSdJszmblp5sM6iRZCZYw7rdgwKNuEl/SivF58b6OCKijiMK0nyU0Tr?=
 =?us-ascii?Q?E9f09DMQO/6/k7cEHDU6vdc3l+KjwUx8iadkNdYfiJoHpGfs8hHXummNcIMv?=
 =?us-ascii?Q?RipdLltQ1wfOo/f+hJx4B/7WbV8UrjOdTyAyWQUJJ4EQElK9VEIcGamuJJCO?=
 =?us-ascii?Q?ZgP2TI0cxaLsDdjwqkISQUQcse5kTbrCEukEf6Ot8wwUAxYsKyGQZ1Ar/2Rt?=
 =?us-ascii?Q?i9V+oZM9FUUo2/b/EBXtpK2EJAE71NqZyrJoGyHh2ZrzIH/+gk3usaQCCOHM?=
 =?us-ascii?Q?8sMEMECq3WAxA8ecJDdmWUG/GKpuf9flZuePF8UYaH0/8kHpv/WG0iN+b/h4?=
 =?us-ascii?Q?D7sfunjebRlbNjTpB+z8oEz8QJ9DRHMjIfpbrv6om3/1gAs5f9dsrjdUvqtq?=
 =?us-ascii?Q?pCXRSgk04raV2H5fWcijlMswlxGDBdz86FgwIm6iKllT9czndx4dfb3eqlkI?=
 =?us-ascii?Q?diUJo6OigooZpcz8VZ8KY4q5p64o6bmL+H8vuJIoJkMQmtH1X6x1ywI/Zz4o?=
 =?us-ascii?Q?h96Zv+zhoo2UuTpbT6n2WC//kmbT6mRoPK2/jzvPluNgvV5EPle1JxNchRN2?=
 =?us-ascii?Q?ISr5yMqAaPU7HavewI/g/KtJqdKpqrFb6xdXMvroXTB+KhnE+32relyarnAd?=
 =?us-ascii?Q?i1IF816qpayAG/E0VcHfzr3najx+boab8EZYu9RB+h4D0shRBYb8MoEQ8mfQ?=
 =?us-ascii?Q?xyb5wn3zBl1CNQlvR4KHULeLPL3svaOJJ1wjlxIoxXwRXNyJ+xhDC9sHB7hh?=
 =?us-ascii?Q?MvXuW4dQnBYCkT9/9ZO+6oJo/m4HtF+Evbe9Wrkq2IySf5s03IBmuwH2n2e3?=
 =?us-ascii?Q?sFHTlG7qDCPA4ZA8RpPpHh0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3845cf-0588-4a79-6f1a-08de29b6ecdb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 11:04:40.0122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xEwAKt+vzmiNBI7f5cCipbOgR/PRM/4cs8GnrYwX62q+nTBhYJ2qhjhvbddbBh8P6d6Q7h/IgV52KyUyStLxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056

Implement the inband_caps() and config_inband() PHY driver methods, to
allow working with PCS devices that do not support or want in-band to be
used.

There is a complication due to existing logic from commit c76acfb7e19d
("net: phy: dp83867: retrigger SGMII AN when link change") which might
re-enable what dp83867_config_inband() has disabled. So we need to
modify dp83867_link_change_notify() to use phy_modify_changed() when
temporarily disabling in-band autoneg. If the return code is 0, it means
the original in-band was disabled and we need to keep it disabled.
If the return code is 1, the original was enabled and we need to
re-enable it. If negative, there was an error, which was silent before,
and remains silent now.

dp83867_config_inband() and dp83867_link_change_notify() are serialized
by the phydev->lock.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/dp83867.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 36a0c1b7f59c..5f5de01c41e1 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -937,15 +937,15 @@ static void dp83867_link_change_notify(struct phy_device *phydev)
 	 * whenever there is a link change.
 	 */
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		int val = 0;
+		int val;
 
-		val = phy_clear_bits(phydev, DP83867_CFG2,
-				     DP83867_SGMII_AUTONEG_EN);
-		if (val < 0)
-			return;
+		val = phy_modify_changed(phydev, DP83867_CFG2,
+					 DP83867_SGMII_AUTONEG_EN, 0);
 
-		phy_set_bits(phydev, DP83867_CFG2,
-			     DP83867_SGMII_AUTONEG_EN);
+		/* Keep the in-band setting made by dp83867_config_inband() */
+		if (val != 0)
+			phy_set_bits(phydev, DP83867_CFG2,
+				     DP83867_SGMII_AUTONEG_EN);
 	}
 }
 
@@ -1116,6 +1116,25 @@ static int dp83867_led_polarity_set(struct phy_device *phydev, int index,
 			  DP83867_LED_POLARITY(index), polarity);
 }
 
+static unsigned int dp83867_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	if (interface == PHY_INTERFACE_MODE_SGMII)
+		return LINK_INBAND_ENABLE | LINK_INBAND_DISABLE;
+
+	return 0;
+}
+
+static int dp83867_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	int val = 0;
+
+	if (modes == LINK_INBAND_ENABLE)
+		val = DP83867_SGMII_AUTONEG_EN;
+
+	return phy_modify(phydev, DP83867_CFG2, DP83867_SGMII_AUTONEG_EN, val);
+}
+
 static struct phy_driver dp83867_driver[] = {
 	{
 		.phy_id		= DP83867_PHY_ID,
@@ -1149,6 +1168,9 @@ static struct phy_driver dp83867_driver[] = {
 		.led_hw_control_set = dp83867_led_hw_control_set,
 		.led_hw_control_get = dp83867_led_hw_control_get,
 		.led_polarity_set = dp83867_led_polarity_set,
+
+		.inband_caps	= dp83867_inband_caps,
+		.config_inband	= dp83867_config_inband,
 	},
 };
 module_phy_driver(dp83867_driver);
-- 
2.34.1


