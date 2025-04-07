Return-Path: <netdev+bounces-179564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F113BA7D9FC
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3F5164DAB
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA74218ABD;
	Mon,  7 Apr 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/XCpq6S"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE012E62B0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018875; cv=fail; b=GCo13Y+HlOTdRJpX7rjAnN5lnPu6+TXdkJGigXvTv5E3Uy4Q95HfhOcG4bXnFJeOHH/pEyBXxZvaGQI5a60A1hv1/BCPeo9/7q6aY3aAj8sqlswS+wiM3o0tB7fUVNjN9ExERoYOClKIauehiWztyANHO9ab3P2E1DPx3aY2cUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018875; c=relaxed/simple;
	bh=71W9/ahDDsQUXn8eq6J2F5Jwkj3VSz36KvidmTY2c44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fMiIsq1DzlgiVwH0l3s2HsvFkUCLbE0PetEhPBS/QXVs3ynuN2C1nHAqng0nWRjrLJ/qeYzrN0reUIstgeBDJe+nZ+eot2+13i1iTNy0hJBsk/zHCJke25RyYvjXLK1s56zjwJmNSXCQre0Ca51Ee5H56PwYw6RCaqp//H9IHpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/XCpq6S; arc=fail smtp.client-ip=40.107.20.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ1RGeZgo5WfPRK2k5coxC6JCLqESK2Bj8n+XQniq6zz7JSIj04RXXpkn56DSao0MOKhsYLXPDnJLME8MrD1KijjEXIm3+BJTOnai2y27xsVF+3fxOseBKdLTUpjBgkBe24gfAWtFtEiusQ9tQcanJdZRhxoWOAJVWD3TN+ClqwWyosqMzYxfxYhy1xwUUQ2x/eT24V0rdMmFcicUlm9O3ldmKWMEfRpfQ6k+pyrt941iT8qsmJat+ZIdJGm1CZTe12uu8DYz6C6/riJ3VC4V+c6rCq5RKBWPTlqiXeNaOw2QWkRY4P9AwH4LLLSw8AWvC0ZRe4DxkTnW8EvfFCeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ/G3vIlHtd4I2Z/78NUVb8NM8aquDdNsoFEHiL5+o8=;
 b=Xgc99GWfhOP6YWl6OLVytjSv1cK5wn1nB5pW80N4IlhcTObAG54rDrZKOL16ecAhFpojzRnvmXhEmb0dz8iwF5zBmGDTiTvzi6qY02AyQIGbe4aWELQuYsMpQrV3X1QtVDAoAxLrnpC2WJ0Y5GwnjyCtrE6ASNV+6ZZTUdbjW9UskNWmb5ECNqrBkkRoLPkwVv+5gxLslKEYjOL75B1AL8b/ElEOaUWtr7pGycZLmeRUUR1RRX4mK1K/CXSW4b3FXrlFKftvtFtWJyJ4vDk0DSZ4Dxt53AXN1EhyPDeNc4kokKQ6yFxrOzPSPFbeQeAx8A0KqL+VUgDQo8/9hBkH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ/G3vIlHtd4I2Z/78NUVb8NM8aquDdNsoFEHiL5+o8=;
 b=D/XCpq6S/mRDxVeZIg4RsQo+41N+bCmWfAElMl5TNKQW8iAko9UONMKSSQbc/U9LyUNr3bh/ZMh8FWXwg06/m7vfEq5hJPx1Tz7gCghgVDNDOSbNSTNcReM9Db0YwiIIFHYsIfnwIpMy6vebTyQ9c6NM+uhwSEJBvmJALuH/GMAE5r5UwRhHLNKO8OG7iX/W0HxgWFht0HkGqMjuGTpmH0Fl9FCTTxuf+Lmpe+ol2phWzJMyrpOlGc9sl1lOEiwp20MeD+JgfyHbaXWa4bYXXx4LrSSBUtY/cmLtVQSE7OK/GuOe+NDz6kwUZZPGfjJT3SiDTIJE/8h9pDW+aqeVqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU0PR04MB9696.eurprd04.prod.outlook.com (2603:10a6:10:314::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 09:41:08 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 09:41:07 +0000
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
Subject: [PATCH v3 net 2/2] net: phy: allow MDIO bus PM ops to start/stop state machine for phylink-controlled PHY
Date: Mon,  7 Apr 2025 12:40:42 +0300
Message-Id: <20250407094042.2155633-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407093900.2155112-1-vladimir.oltean@nxp.com>
References: <20250407093900.2155112-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU0PR04MB9696:EE_
X-MS-Office365-Filtering-Correlation-Id: 8856b952-63f0-44d3-0d44-08dd75b8526d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XjWPZDEY38yj+yQi+vFGwzrsmpAc+wPp25amEFaNOjK0l2VFnKkiGG30cz+f?=
 =?us-ascii?Q?flYwfhzwtGoPsTbElT8QyJL+Ige/ZLtJS50pGcWQLXe6iLxl7QcdTQw16EV0?=
 =?us-ascii?Q?7la9nPJSOXdJPHxa2DuVBCT4nEjT5nRjKGJpr6NZtSxeS8QEFkObAPVEKL48?=
 =?us-ascii?Q?dCghPvC/m3+LFCpTiN+zrJ0iVPJLhXaPSX1yOgBSQ3EmzI69VJvya949JhyS?=
 =?us-ascii?Q?zRC/PGqv1PW1kUpK84AYFJLDNW9aEyue56OI9x1gVJno1shn/FsCErpmq53T?=
 =?us-ascii?Q?5NjE2CeaYQeZIMFPkfjoW9F86WiJduvMmI0N7Y8jx6JxvF5+cEIxIqrYKPrV?=
 =?us-ascii?Q?+/Rf39oaKiN776oPhXSmYfVT/d2bhnyoW0m5q4kosGQlfuoTaqHCIeDu9xYF?=
 =?us-ascii?Q?74UbiFzkk0aK5H50tR+8WvlzP30Y2EoKKoEGXDAD7mfSD89FQqCSdyDx42zJ?=
 =?us-ascii?Q?dgzTpIuc2Gjh2piEvROMzb4ZB94BDAmWW4iA6iqCpDlqfv2V4tkXeYxA5Dyq?=
 =?us-ascii?Q?i3umlfa8ImTUd/mkqc3bh+357yzuxTShLFsNucT80voQaVXwvCMKt3WeeBon?=
 =?us-ascii?Q?QCDfRX7L/TUq8mExTnTKrOLqNsggj4S66wycjqhJ+vcmtBwhattP1mgIIL9j?=
 =?us-ascii?Q?uysjQs4Ah2sqjHdFET8kFoeaCYnxA+CagTecHTGA2tJp44t4D17BpEGuJQOy?=
 =?us-ascii?Q?fgl5+cPFC6ra2Rgh3PGyB5/T3GjxJBp1JtEDX0kYGikZ/oKeiCDvMs5oV/Sg?=
 =?us-ascii?Q?W2Yn9qrOO+E2hIab4L5RNQ4UON/OccRoWYnEjDcVNIWlequ150roiHvLTTMv?=
 =?us-ascii?Q?oYc6zRfaqe1/Xopc6wmaR1Li20quxcb/3FZ0kOd3Y/8FlIBJe3QL38sazDyf?=
 =?us-ascii?Q?u54mFHe4jPEQ8o2/7YFhPQqcJpcWtAsebDzEIrydF4QPj1083Q0N22Z/t7Fx?=
 =?us-ascii?Q?yBuoyAoxLOApS6dbW64TpxbZKgrU2zDs94QHVeatNLtXDq/6bPJXTaPw50Ob?=
 =?us-ascii?Q?BUjeRxL2fabWvu33rvze2RXkHaw7+0a4smOyPxSGsdbsf5X3BnuftwrsP8En?=
 =?us-ascii?Q?haCDPCklcOJq7SQMJF0IS879uuWNbsxuqk9FA4t/JVHemztTQrdnjt/yVeQb?=
 =?us-ascii?Q?IPW2hPyenZA7cl5LuFz8HmsycpVKi52SPuGqSmyfqfTg37d/TXi192J7GaU4?=
 =?us-ascii?Q?v/KmuzxaHqrIuNfdbY5CxxRwumgA/OhdPDH4H9iFUUc1iCY3WMVnGyRuce7l?=
 =?us-ascii?Q?obfLY7VbQUIaQro6Quc0VZWYtFBNG3kTIh6ZkWzu9FuRh7QYUoUn9MtDvIb5?=
 =?us-ascii?Q?08BVKtYj7wJHywNGmmOnFBfHNqf2XpkvsKdCAdHTU3WNOIrcKtzkt3V6GQaf?=
 =?us-ascii?Q?ZD6/s10g1Xgq0McqJqh5Z3i7ahWtdXDRapcNEoDd32tBnAuZfrligQqeMyUk?=
 =?us-ascii?Q?dU5+UQqTZLVSPB4HJ+z9xA42VEeY5/zAHgyckvDx5Fg/tSMv0dGqwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4rFX2JYdQR1rOJ+gZ/8kjG4+xrIKJdL1tqQPdSiRgzyXjWnNMHPB/jrHRtaS?=
 =?us-ascii?Q?N29pgrZt4pQ50DpU2OfgfczmDQLd5hQB3PS0yvVZPUDkZQbET86P1Hz4xDFP?=
 =?us-ascii?Q?6UFj291GUc1kVmoRszPmZCeJLeLQ+FxCSKeY0rcRTLcahUW1Mm0C5tqbe6gj?=
 =?us-ascii?Q?YF7GKmcZAu12f9El+zA8gECV3rCwssmuwcQkbBjf/RkzppTRSUJUtuRu+hvQ?=
 =?us-ascii?Q?vj44QO8A7E/Ly1R8eGtb0ZJg7xG1fBJ9VzIs/DKu7JYoCquXpIEhszmE7Nra?=
 =?us-ascii?Q?VoMFF57EJzmp5wBWIrQDZZIxrpcKNMFNTM47yW15sllZ3FEEz3p2St6BH3sA?=
 =?us-ascii?Q?XkplRF8xmDZGrvVWiBeD5qBzGnFzT4r2kxu8A1dJWrs2TB/Hnfja4bDFw84S?=
 =?us-ascii?Q?sRrtTrH0s2mIqiR9PjNNPrtwsdu23qjaqe/m/ouAEJc+phr7dap7J03Zb2aP?=
 =?us-ascii?Q?W2TAg3PAnTOOCYWguR92eFNo6sRrJrkU//X2iqeo9PNKgnCvucGsy0TaLNBa?=
 =?us-ascii?Q?18/F57NpbekC+BgRSF5aR4Iw/Q4s231uGEBeC/3t9RSyHhokmzAN1yZ9j+qB?=
 =?us-ascii?Q?XJpWzeCT4UiuN2EiTUEFKtVCHJxZIjD+22Zd6f7wxeOQlMmynLJNlXKc4Eaa?=
 =?us-ascii?Q?fcP3BhcLsk7TsenopLpAk20d0+HKpH9/0SdiF2ssL5h/sixInoli1uVdpKMU?=
 =?us-ascii?Q?f0LgXTBjceZrNRIboCdtLRLRmkKVUN8elUs9Unsjw7mf39eYazU28Uw1PGzn?=
 =?us-ascii?Q?lggIOsbUo5fnsLq8IJJToBmiA3h49pAouOUSfxFSN4l9jJ6U9cNTY8w3Xw1v?=
 =?us-ascii?Q?bFbHKgN8ABZ2IqJgjMIFbv54itTUN332TXEHe4GJVxJbqMo0Tzfkd8nxw+2A?=
 =?us-ascii?Q?xU3Pz4+KBzI6YGShYa4tB/PR84Mh47r1iqr2+BSp7FJDjTp2WfCtltHR0vn7?=
 =?us-ascii?Q?sJ1+NjY8HCFRmB/rfP1CtrQOzbRpFCa2h28OxtJNQAeXhuow0OsR4r85x4XM?=
 =?us-ascii?Q?nfj+LQNX5lyNIqUgTkHSt6t6DIuArVeXKsyhGKC3OAx54PghFBK0zuMPyU2j?=
 =?us-ascii?Q?lnNnyvqJf7KgzoUU9kTmss030Z8PdEh5OIUIXwzaDJykOWA50b0G25/HZJu6?=
 =?us-ascii?Q?cqss1jMWdHlWE14M/6rJG8lOlWSljIs7gEs9OSZajxgXj5nfJmo4kj6vncdG?=
 =?us-ascii?Q?/6RAInNVx7sFBKQ9ER9fDT7YZPPkP+t28nBaIwJ/HviQ+ZGe5hoxrB2QuA8a?=
 =?us-ascii?Q?5WCNput6vkQdKtFoYZt+Mbq/CxDW6y1MPs/Tdwhw99NzDOUszfpVxWJdx6Ab?=
 =?us-ascii?Q?zEeiERp/em6XAfa7ud3LPav+42zU52UY5D7XfKjeVL4hY4oBOyqoCpgD6DVL?=
 =?us-ascii?Q?iprZIPFbwExuXbtTKSsWal0IcoZY9g+lgOC/9FndSwp3B3mPPjwuY3olFelN?=
 =?us-ascii?Q?SYunvVshjsBsuVwB7oK15/l59c6tnPrcpsEFeyi0G+C074COA+wXpOwtjvUH?=
 =?us-ascii?Q?5w16eNqf9JOUO6VCpAAqp9FbU8vAsZFVOh8ETWIvEjfg63GgoyFYia7JumLL?=
 =?us-ascii?Q?Bh+hIND/93AKajhGNni7yvujMcEp0L9dVDT2+YIy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8856b952-63f0-44d3-0d44-08dd75b8526d
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 09:41:07.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxux0LFoTyC10EEie3n1MFGYbJoX4VB+UOhWKUuRXUgGlCyxhLT7aJYIdtfFbxMsBiiHjIMX8d1dHA2WPwFKdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9696

DSA has 2 kinds of drivers:

1. Those who call dsa_switch_suspend() and dsa_switch_resume() from
   their device PM ops: qca8k-8xxx, bcm_sf2, microchip ksz
2. Those who don't: all others. The above methods should be optional.

For type 1, dsa_switch_suspend() calls dsa_user_suspend() -> phylink_stop(),
and dsa_switch_resume() calls dsa_user_resume() -> phylink_start().
These seem good candidates for setting mac_managed_pm = true because
that is essentially its definition [1], but that does not seem to be the
biggest problem for now, and is not what this change focuses on.

Talking strictly about the 2nd category of DSA drivers here (which
do not have MAC managed PM, meaning that for their attached PHYs,
mdio_bus_phy_suspend() and mdio_bus_phy_resume() should run in full),
I have noticed that the following warning from mdio_bus_phy_resume() is
triggered:

	WARN_ON(phydev->state != PHY_HALTED && phydev->state != PHY_READY &&
		phydev->state != PHY_UP);

because the PHY state machine is running.

It's running as a result of a previous dsa_user_open() -> ... ->
phylink_start() -> phy_start() having been initiated by the user.

The previous mdio_bus_phy_suspend() was supposed to have called
phy_stop_machine(), but it didn't. So this is why the PHY is in state
PHY_NOLINK by the time mdio_bus_phy_resume() runs.

mdio_bus_phy_suspend() did not call phy_stop_machine() because for
phylink, the phydev->adjust_link function pointer is NULL. This seems a
technicality introduced by commit fddd91016d16 ("phylib: fix PAL state
machine restart on resume"). That commit was written before phylink
existed, and was intended to avoid crashing with consumer drivers which
don't use the PHY state machine - phylink always does, when using a PHY.
But phylink itself has historically not been developed with
suspend/resume in mind, and apparently not tested too much in that
scenario, allowing this bug to exist unnoticed for so long. Plus, prior
to the WARN_ON(), it would have likely been invisible.

This issue is not in fact restricted to type 2 DSA drivers (according to
the above ad-hoc classification), but can be extrapolated to any MAC
driver with phylink and MDIO-bus-managed PHY PM ops. DSA is just where
the issue was reported. Assuming mac_managed_pm is set correctly, a
quick search indicates the following other drivers might be affected:

$ grep -Zlr PHYLINK_NETDEV drivers/ | xargs -0 grep -L mac_managed_pm
drivers/net/ethernet/atheros/ag71xx.c
drivers/net/ethernet/microchip/sparx5/sparx5_main.c
drivers/net/ethernet/microchip/lan966x/lan966x_main.c
drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
drivers/net/ethernet/freescale/ucc_geth.c
drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
drivers/net/ethernet/marvell/mvneta.c
drivers/net/ethernet/marvell/prestera/prestera_main.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/altera/altera_tse_main.c
drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
drivers/net/ethernet/meta/fbnic/fbnic_phylink.c
drivers/net/ethernet/tehuti/tn40_phy.c
drivers/net/ethernet/mscc/ocelot_net.c

Make the existing conditions dependent on the PHY device having a
phydev->phy_link_change() implementation equal to the default
phy_link_change() provided by phylib. Otherwise, we implicitly know that
the phydev has the phylink-provided phylink_phy_change() callback, and
when phylink is used, the PHY state machine always needs to be stopped/
started on the suspend/resume path. The code is structured as such that
if phydev->phy_link_change() is absent, it is a matter of time until the
kernel will crash - no need to further complicate the test.

Thus, for the situation where the PM is not managed by the MAC, we will
make the MDIO bus PM ops treat identically the phylink-controlled PHYs
with the phylib-controlled PHYs where an adjust_link() callback is
supplied. In both cases, the MDIO bus PM ops should stop and restart the
PHY state machine.

[1] https://lore.kernel.org/netdev/Z-1tiW9zjcoFkhwc@shell.armlinux.org.uk/

Fixes: 744d23c71af3 ("net: phy: Warn about incorrect mdio_bus_phy_resume() state")
Reported-by: Wei Fang <wei.fang@nxp.com>
Tested-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3:
- reword commit message to integrate some of Russell's extra comments
  from a different angle
- simplify the phy_uses_state_machine() check when not using phylib's
  phy_link_change() by simply returning true.
- add Tested-by tag
v1->v2:
- code movement split out
- rename phy_has_attached_dev() to phy_uses_state_machine(), provide
  kernel-doc

v1 at:
https://lore.kernel.org/netdev/20250225153156.3589072-1-vladimir.oltean@nxp.com/

 drivers/net/phy/phy_device.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 1367296a3389..cc1bfd22fb81 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -257,6 +257,33 @@ static void phy_link_change(struct phy_device *phydev, bool up)
 		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
 }
 
+/**
+ * phy_uses_state_machine - test whether consumer driver uses PAL state machine
+ * @phydev: the target PHY device structure
+ *
+ * Ultimately, this aims to indirectly determine whether the PHY is attached
+ * to a consumer which uses the state machine by calling phy_start() and
+ * phy_stop().
+ *
+ * When the PHY driver consumer uses phylib, it must have previously called
+ * phy_connect_direct() or one of its derivatives, so that phy_prepare_link()
+ * has set up a hook for monitoring state changes.
+ *
+ * When the PHY driver is used by the MAC driver consumer through phylink (the
+ * only other provider of a phy_link_change() method), using the PHY state
+ * machine is not optional.
+ *
+ * Return: true if consumer calls phy_start() and phy_stop(), false otherwise.
+ */
+static bool phy_uses_state_machine(struct phy_device *phydev)
+{
+	if (phydev->phy_link_change == phy_link_change)
+		return phydev->attached_dev && phydev->adjust_link;
+
+	/* phydev->phy_link_change is implicitly phylink_phy_change() */
+	return true;
+}
+
 static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 {
 	struct device_driver *drv = phydev->mdio.dev.driver;
@@ -323,7 +350,7 @@ static __maybe_unused int mdio_bus_phy_suspend(struct device *dev)
 	 * may call phy routines that try to grab the same lock, and that may
 	 * lead to a deadlock.
 	 */
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_stop_machine(phydev);
 
 	if (!mdio_bus_phy_may_suspend(phydev))
@@ -377,7 +404,7 @@ static __maybe_unused int mdio_bus_phy_resume(struct device *dev)
 		}
 	}
 
-	if (phydev->attached_dev && phydev->adjust_link)
+	if (phy_uses_state_machine(phydev))
 		phy_start_machine(phydev);
 
 	return 0;
-- 
2.34.1


