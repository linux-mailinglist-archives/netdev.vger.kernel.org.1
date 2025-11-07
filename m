Return-Path: <netdev+bounces-236749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC4C3FA71
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2D584F1A70
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414B31DD87;
	Fri,  7 Nov 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e44EAsAq"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8832131D366
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513722; cv=fail; b=QkzjP8G8ZpQfU/6vt6Ov+vzPQXDlRYjVmxT1B9BgUqabgBfS7d2fxYzNx74yscYsaMmp/DDtQHdYB2zMqEnaqi+FFrqaBPJp5dHlqFmurRvV3+pwHVSxTjkYfYvFXFCeuszDtl7BR4ytg+lhEd1av8IlFbGUfpaRapgTI9mj+Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513722; c=relaxed/simple;
	bh=1Me/ciKvqU4K4iSxZJcs3rnpBpMC+l2yE89WYf3KLhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOL/jp0hHZN8WOi5YlraQnoL5h2TGH8f7z4N93jF4FNMLlJxvlxYDSIK9FBXTtxQQbof2TZKXKAAPWso8Vjx+ojcQtUBUbkKWBT3kjlkxHu4z/eoJ/1DRHbFChRG2u1YcPuzUxkZ3ee+lLSC0IRUoG2JAbGrfEWAVBzjFI4P0b0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e44EAsAq; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bxhnqOkPG4wggpB2Wux1Yebby1gSk295mjK2nbmuBkz9LE6Ft220DpWgvBU75Gykg6R96akVRUX6mWXuWw2P0NGAa/jrmTU7GySZQMsIoDWF0Iof+ilincaV0JPS5i9CE9MmqgFlJQRhq0esQpsFHUy2ffgdD3yIjGOkgINo740sfvzZLNZ0v5MYmMKhltVwkaaCz8ynqjWo20YyTBcxU8QvN/b5aiLRh8b/xVJ7sl+E4dUyi5r7RA2WMQxT4oY0BGpdn15USRkmrD1+HtSWrIcJxMz3AdOuTTgoOGMVz8mc/TmrRCbqa+vDYaUVGDsRypvMmWOethJOjTFEP1Qbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPRMJsZ4DufZhJTGUi4MVK0midN5K2ZW4O+O7/kn1AE=;
 b=hjTMpl0qJdXEAMDR6bfmzquow0JC+w6oFe+TZu9bZq8HjZW/NXbFKd6VpB/DAp5vuSOt4foj4RlDQ4dPCbDHzpNsPWFlz6zPdLbbZnKuuYTWarGIOorH6LlgxCRkPwhhQHEkfvg1KvPJ7dh7llIZyWVghCf/MnCYE4RHEulc6iCaCVUqVw11OJYtKthwbcoeSQE8kGIBODEb6tpb9Iiq3Mm1GlOJyT0NGNxkeFl1wYWbd1LwWMvi8dxB9Df3tu4FkC9PEHUSROVK/pi6OWg+FP28f3fqDVzybUtOist0+SZJS18dS+5ues54lO8y0qPtO0Gx07bQCqtJGP5ocnuYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPRMJsZ4DufZhJTGUi4MVK0midN5K2ZW4O+O7/kn1AE=;
 b=e44EAsAqkzdQExXek61uMioUOfyWesUE54bzsrl3mjvUyL3oTEUry7ymeKOWJPvz1F55X894z33kjzzRGDTLWzi+YV/ul6G0SkF4QO5dZJqLkOFy2GZYT7Jz7esOoAAhFaXBiB56v7tR6jBJlVedtiVvVq7h+gkV4KcbEVoIyJ5b7xutfLk2iuB1gMF3K4dQeDW9ba7kF69wJtD/ezkA5T4ejIOZx/RJut/iWdejZU8SkE2xNDc5FEbiW3OrCb7Ke9pBcHFY2bDG8dJDTrutTUNp9pyFHxss3gt/Ui3eh75qoTZYRFoPP4/FaeBUk7+yO8V7jrfwQoBF3vyInGfV+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:34 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:34 +0000
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
Subject: [PATCH v2 net-next 3/6] net: phy: realtek: eliminate has_phycr2 variable
Date: Fri,  7 Nov 2025 13:08:14 +0200
Message-Id: <20251107110817.324389-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107110817.324389-1-vladimir.oltean@nxp.com>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 139f1559-af3c-45bf-ba9b-08de1dedfe3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jR6M9Cln2/aVWwfNJdmYY6FgxAX2s+fSvznpxrC4nZPL2tSyF14vicKlR4xE?=
 =?us-ascii?Q?gubO8ig/o6BwRakxCylEvAPPDGwXnIr695CCMegoVVzruuvTY9XNYn0GgqDD?=
 =?us-ascii?Q?ANj5J5RkeNxZ1WDpKHVMBybmyajdHQoIriyLUzUMHxa2TXRkB+X2lJnvrhKW?=
 =?us-ascii?Q?AVLd4gYbYRGItDYJvSvQRzqYlOINqcLYi9dTD7aSGwulJ1ja8q9tEDAyT6i6?=
 =?us-ascii?Q?pD/FHsT24BO024mJNNs0k7PpLgqfSlcHUT42VrcWSC60piUmvwgDh1gllsL0?=
 =?us-ascii?Q?6KXSKdJEh21mEx+CTdHGTttMS5BPLrkI9k7aeRK93ecnwFu6c/2qlxbSkghL?=
 =?us-ascii?Q?8czlwujLSP33NdSoEMgwUd2T6hJaKulK1PD2SvyrD8HKD6G74MPlLZvnQdDB?=
 =?us-ascii?Q?d8YG6jmdrpQnmc4hsAVYOzRuJuJt3+fgfsGzbFZBmKqW9aUB2FOgZpsHGl2s?=
 =?us-ascii?Q?aVXpH1bcC1RpefJ5ZLkTJZt3LqmpuIpuPhRIBh1sY37uKwVnvzB3InL64BYf?=
 =?us-ascii?Q?7Qe8eATxhv67HmI6rgCSJEtS1j1DoTMuDf+UCCb5hXr1TnogEZc5ybMS8cty?=
 =?us-ascii?Q?8oAoLWKA+u90BYbcIXSoMMBv+TS1r/rBzvN+3REpXnWl1bcaj8Z8XQ3Ei577?=
 =?us-ascii?Q?BoHlcEN0GP+pYuwsWBWFgfoWnr/7zYzFClfqAZxa+8Wrn1DYsZM6iX1vjZYd?=
 =?us-ascii?Q?dRU5P/Rw+VLvCZuhLss3Ui0KoZ9ruoCuelqJEMSyJ9S7xBKeLe/GCjK4QJOn?=
 =?us-ascii?Q?80mDdnZfvd96ZkLLdjs3vJvSjJSi/vczSgn+hBD9ja5o26PAGQmQCXQMwHlX?=
 =?us-ascii?Q?jJ1isdu/GmBcIqzOwSDWBiPy882+c1aq9Br32Kh/7aIFIJm+BRtsMz3wltv9?=
 =?us-ascii?Q?Iu0+if8z8TP6zXWqEGIU0JCHm+01QUtzH7QehOoou24PspuvR0R/dQGL+CUn?=
 =?us-ascii?Q?UNDvc0pmBG3kwzElO5EqlpRrCL0M2euAgxKXe5SCIsu5ihwoNIeHsXHLwVJj?=
 =?us-ascii?Q?UbQ+710npiYTdzQ9H1CbZem3IZ2fhsnt3Aw2Jpf9rHUQJNZS+MReOPu7mxCy?=
 =?us-ascii?Q?dCuZv2LJAkr++DoxA5VQw1Gx7PfXNAaeVtPvCJGZQ9w+szBlwgtX9I360Bcu?=
 =?us-ascii?Q?ey5Ak5H2ULCriOTKEXwUI0r1cgTsNQT3/C23lus4v/fRSJ7bp6+UX6fMHkfY?=
 =?us-ascii?Q?TfyK2Cxwjwtx9c5IS3akwN+xOuqORMLKIwdEgqaV3M9DwTNgSCCxfIF5JYZr?=
 =?us-ascii?Q?oetuSgNPGys0s2XJBy6yekY1B8wB19FgllamdhLOmS8oDvzH6x/7b1lKAj4j?=
 =?us-ascii?Q?LG3suvmbE16AYmRTup24xA7OgQuSSo20b85skpze/xIE7E4Ha8LCTf9MbPDL?=
 =?us-ascii?Q?FKpDTIYNmtswHiTDDtAb10u2faA/bJP4yUEwFlAeGCbVcsx/91gA9B6r0Y5y?=
 =?us-ascii?Q?dnob1DbWry2b/x0SVjgB8pHAhfw3AE6q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sL1+uX+Y7Rtqj+7g8SSV8qiJ3UiVqoBDKKiMOssQnjILw3x06F6L+ZIrh59a?=
 =?us-ascii?Q?G2TdFb3Zu52B8qR7HMNbH4EV6K9i3ER4PWH2RiH/WGcSfZxNSdqSZ3F5QvZ9?=
 =?us-ascii?Q?L6k/PKi3LJpbwHrxuGyrzwBxSBwhUUoZK7AHStDAwRc/w67puqHmGdxpWMaY?=
 =?us-ascii?Q?5U/bZyzyxJ4a+mxfCa/gNNN4Oq9qN2d1npKzV8YrRf+JHeljhtkC8eZku5hf?=
 =?us-ascii?Q?VYIlOIzwXgR9vQ8BliOE1AwBOCU8O53kvK15Yoe3IbM4x3y+MC6EEue1lbj/?=
 =?us-ascii?Q?qXQVQeyJeF2A3lRzURtJWn/BqdJPBjTmDpRwIxofReDQgQior2ASH0Qy+BTy?=
 =?us-ascii?Q?a38+yBtzoQ3NPxIwVX9vVFov9QmO4QJSYilQ9m1CWtaeoMeOxWDQEZsK4pku?=
 =?us-ascii?Q?MIgR5VhVeynplkxR0RRQXWOsNhtMWD/YpdTOCBaARbN068tIU0PbvEv6w3ju?=
 =?us-ascii?Q?erxa1tVlcDMEv96Ust+AkBHLD6puSkl7xDqfqPtjxCIV/viY8cdUcDC6vI9r?=
 =?us-ascii?Q?PYWdbEAZFtt8xlZ7l6jTPHDOfHJ5HvtuWTFsnJXFKZCLw8qjBsatoCiPNWQM?=
 =?us-ascii?Q?w5gL1pDVJGgHJSi41IoX2c399PCzMe8ulG+E9MGaghF+pp6OM7j7umMdvYML?=
 =?us-ascii?Q?rCvdxE6GinDto+goEU48ouhrajBd5xI/cqgvc2jpl3t38nB1pchDs0CErBJS?=
 =?us-ascii?Q?hzJCk8q7X3Fww9PWHrrgSsyCJifgjx+DQcInrOtFaDe/P4ju8PRWmf5PsvjK?=
 =?us-ascii?Q?GURn3qi7DH1gMxCzeFyuBuoEhoIen2epUmw/geAWyipMILnCwG+HL8u34gOL?=
 =?us-ascii?Q?FZkLLCE5Mu2noD/TVIrwS4FU8UvZoHLRG4mt4L0FSvLgmpRQ1FgpkGNsnBe7?=
 =?us-ascii?Q?3a1KP5A6a+ZpYiKR8mOhQNQujPfTa9KThG0qEZXB6zm5k6TFRxKm9vHEJOfI?=
 =?us-ascii?Q?FoBN/UtgxXs2vEIMlP46CLdu23CHQ/ZFRW46c3KztwT7KvBr9r/RyCWNIIEX?=
 =?us-ascii?Q?sUXAsJ3nnieKQr0jujC5ltps6t6kSP1SiTGnzAy9jMXnzDpVn/VeiZxZtoBo?=
 =?us-ascii?Q?wTJoxyAY0OS6zGv90OvaLhF3pbWg2kwKkbP/PmMFYZ8HRkfYB35rhVqObhBW?=
 =?us-ascii?Q?QEF9PxK53w3JdpOXrtRN+a9mxcmXFLqcTFHRYVPF8ZHiSvOdAKz0zLziQw6i?=
 =?us-ascii?Q?oo++hUpWRtd4ulqpLPrtZtRYreAs2yobwW80TaavsaHh9FHcfpu+EWH04Qyu?=
 =?us-ascii?Q?8YppY97KYCGyOdy2JcuR+JddBZKeQIBmIGLFj8PxcjZoquJZzY4QXjU+ChQ+?=
 =?us-ascii?Q?SXrWvVqf0CTmD5IjNLRB+YObsbeVsItK7QFKOSEor/Z9plHS+FP0g4IUetvc?=
 =?us-ascii?Q?PmxJ9SKdqOi/meTn2gCYiurJEOLDxkimGk0il1hY5NSxy5P9Pu4f7ZuJ8iz7?=
 =?us-ascii?Q?n62o0XrnSxfG7X/9gVyMrD3UZ8d2DQBZDEY0Ngesp/EWVoXS4mfnKK+MAnVY?=
 =?us-ascii?Q?+QHQDU8UZLHIePqPXDsC3VAGkolFIPqapIN3EjQLDQjX3R0PQYaqurBncHqQ?=
 =?us-ascii?Q?XM7JogL/HbhhxbJFMNJdL6NIIWLuzaP5UryGlYOrLTvEgml5SAayXtbhDRqc?=
 =?us-ascii?Q?/NFqNdQglVrKzBPh3NuOr5w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139f1559-af3c-45bf-ba9b-08de1dedfe3c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:34.5619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6O1WLmCISK8mpQT3t9Kl6iJPwUggiWkrkz6Qew70zw0HKTjbsn40xo1IMvKcL8ez/QVKhTEQHmosXd53LluIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

This variable is assigned in rtl821x_probe() and used in
rtl8211f_config_init(), which is more complex than it needs to be.
Simply testing the same condition from rtl821x_probe() in
rtl8211f_config_init() yields the same result (the PHY driver ID is a
runtime invariant), but with one temporary variable less.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v1->v2: just context changes

 drivers/net/phy/realtek/realtek_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ba58bdc3cf85..9413c5e52998 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,7 +194,6 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	bool has_phycr2;
 	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
@@ -245,7 +244,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
-	u32 phy_id = phydev->drv->phy_id;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -265,7 +263,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
-	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
 
@@ -678,7 +675,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!priv->has_phycr2)
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
 		return 0;
 
 	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-- 
2.34.1


