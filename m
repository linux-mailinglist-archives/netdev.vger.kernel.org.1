Return-Path: <netdev+bounces-121780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C416295E80A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 07:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE2228316A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A4681AB1;
	Mon, 26 Aug 2024 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bXMq8d8x"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EA7407A;
	Mon, 26 Aug 2024 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650895; cv=fail; b=uYPolIdfFIGiQK6OArQzHtWAnUJXG2+K/vRYLyLF9oxoMrW7wNQItQgXzm4cop+8jSfmB5O1AZTd/WAEas7rWM/mrOsyZXkNkRwmxg5LBuJ9SCPhtr/E3vi4WKZeLmN72xqw7dpJHl4PiVSMgSTWD6aIYTJlVx+JsKxQk2nRLPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650895; c=relaxed/simple;
	bh=dTh6wJYUtBEZKl9qoBzB8sYAYbFee47xoW3jN6rzvNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fH0Wx5aEG1VvQIcHVWo9/VEr0kByVbHEdfSugZL+JhosC4saP4+sCD6KzyGnij5PSXrFJXOS6gx5mMOmZlYwt7Xll8H6yA2prEwz92suS3Jl84s1ODGXp5VngGqZTl1HXaOvbZpUZXruwLjvVRGXol4Zu3h4KDxvuog4zjPuopk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bXMq8d8x; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/Nbq94NsjzY2uXYf0Wp+m47zUcFaPEY9cLa8b98fWFBIanRfygPG4eEqXhP5K+ogfos9N/B/ZmXbUptSrmg6/yqiNrrBNtc3QqaxjwUpjhs40KaQYmbl75xYg/OPSnS5mpqLxaT97HCd/MoMEP1EYAdqJJAS0+dUsSl3u24CpymgvaD7D94BTv51jgTmwx/F1Wemc68gFwNlo0GKMoc09RfC0l2EjAuop9UQVGvJpmDMXMu5FvtDBJ/dWxqAP4Z3LKv4SoH1Uc0L2uVMfS+yezt3XZ849NEmLwqbkO0h16024LSGwXr6cj4p3fu19ObQ2kEjNpOKWYYNXysyNGSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxcxAgBuaO9j+hcxrrxig7XYuhzpSqsDRdxv+wGjRRc=;
 b=XJH8OYDRvL2S0QEfM7QeQe0T1ZZKrqKu9GzfDkAWjQnrm04XYNR2wmVVkKSl9MOMOlIuS/8hlL9VPxoNh7BVDc8vBxGJPkv9q3FDGSjnMFatV/op52ZOphmLOSRacPL1TOgfrDswY0iC+CeEePBPe21NbpYX9NB5eh7enEPmy6KAbgE4u07fUosC1WVkhyMjm5MXVIIkIaItTUjyHqhdV0Irq6bIJUCQe7UIVl9GJjFX/aOEWZE/GyLf96WGBGRHWKrCsToHIAhiBEYaofVPm73ZenE0NK2QJnBs8/3RavaW+4/LmmRVeIw/7r88i441YJjUOkbZbeXv+yfLJgPA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxcxAgBuaO9j+hcxrrxig7XYuhzpSqsDRdxv+wGjRRc=;
 b=bXMq8d8xdULC2K0d9bCXRZyJB8BcroJT45SKnBZ+Lk8HySL9QrQsV7yLkI+xM5IBgMx0Q8YsY7iCrMvIHagSDG8TAWDUPBGKH2lbLPPLMO5q5kc/kjOZohRGkUYyd3i42YYRqnHu1Y238vEvxna/H+83HS4DZUVAFpvbT4q4cTK7yAD3u94fp7HWRpIP8gOeAdDliib5j2Dme2pDfp7iSWBjKJSctiJVgPsMXYNDRX4ENEQ/kRRCqhX5GFpMeePflgsfGtIMmEXzMKaG2C3VRpy2BtC3Sy8xNsmGv7G39WaU79yUCm8LT/TU5/WxPDEFxtCNQDvFFLvOHABZY2zHUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:41:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:41:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 2/2] net: phy: c45-tja11xx: add support for outputing RMII reference clock
Date: Mon, 26 Aug 2024 13:27:00 +0800
Message-Id: <20240826052700.232453-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826052700.232453-1-wei.fang@nxp.com>
References: <20240826052700.232453-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b6ee90b-dcfd-44dc-8814-08dcc591bc7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hkBHz8jdCEYvmaIN7avpgNW3oCJ23P5JLRYyNsnDDu+h1Al7z8kr7gKRHqeV?=
 =?us-ascii?Q?4mVlQN/K1Knk2s/TQo5mEv3Az1eKgr0wTXn7X7vilIw5UqOW2h8o7a7xeaAt?=
 =?us-ascii?Q?gHCdDjwrnvaSkmpVRsVhHa7JzReyloqOW9g1f+R01xEGoftQIrj4vDKtMFM+?=
 =?us-ascii?Q?Q++dgVQNUr6EDvELsDmQjQJlPvrbPzhnibHsaj87oFFEGrHNG7jrLeoJwYBJ?=
 =?us-ascii?Q?mlTjpy8s4CttMV/W36rCg7GNnFAMTzyf3LjrbdOcj5vO6YJiqQbN3G2VVTY6?=
 =?us-ascii?Q?N80e2YzP1Bk62LKluhtrccdILhBp5tvxzFv530M7LKtcPqF0wFUnuxKujYmS?=
 =?us-ascii?Q?e/CdgFPk6FTLN07rtFFLlYXFlFBv3la2nmhaJYM9/Bs9tjEiStUhUEQ7g44a?=
 =?us-ascii?Q?hXxQnpj7p5yf5NVY/ipoJgZ49ixvViwzDZyb9PYCXaef/8IPkgEEJXniFvyd?=
 =?us-ascii?Q?CmYRwgpUH/EioWVAS1iqB+O9Znj9A4bcflSeMIuq8Qr/2LomVcft5JI6WXl3?=
 =?us-ascii?Q?CGO1YLs5y/xxsNbawk1VdUpLifdVfqM+4vQ1qvi95hONup/smQD9ktacbS5t?=
 =?us-ascii?Q?zXgOZCTzAb/bIiA6CEyK8CGf7rX4WVhq4DJiDWDoypvxBLnK2+8faHcHDZXo?=
 =?us-ascii?Q?Zp93Kz7xot6gjtFOGLBK4dNkOP0wvnUIFDs1IDywe4dlKvZzwoggBuHsto/a?=
 =?us-ascii?Q?6QIFOI+Ezr/oyhWzpspFXDWWQZPrpUecuvAHPvHAYhFVIe24bsauSxDntVgj?=
 =?us-ascii?Q?LVLaoHBUO59frCyLOjtXG6vncb/RALQF5XmlS3k4i5pPoSSXZsjvV/vMGWPI?=
 =?us-ascii?Q?/kGh++fce7tdtHO6B9Wz4/vzEhmfgPhogWE/xkopfg5Y3L2gt3br1ZYhASBW?=
 =?us-ascii?Q?y4Q5R+E9/2f/mA9z7bQweD6rKBVHj+NAJDadmNFsE9UR2vsRj5pcgLXkjVYK?=
 =?us-ascii?Q?GBJzr/eh8MkPkBd19RH7sVRqq3i2cau19YltQtAeO4GLQGDvM7uGOlyprkhO?=
 =?us-ascii?Q?fv6cvNqGHoWJY6K3IAuHppv70t2wGWAveUD/J/V9ZN7qK94sBDBgavLnX9Ra?=
 =?us-ascii?Q?rQxUDuokH31h1XRgkKSWTgSiv3M5V7QJ4DPyCR6XSv4KCnjCf9bdDYaYGUwi?=
 =?us-ascii?Q?R3sP7upfr1/jbFm3co3RAOwwqj/xvXmSGL4gmBUYFvg2d464+eklAQFZBfPj?=
 =?us-ascii?Q?xb5vhl+gGDuBeWTj0+AY4qpEymqcKJFW8Jc/tX+3XPQke16DnLj9p2JsJpJC?=
 =?us-ascii?Q?opcBMX4XENpauGPk/L7PTF92nejExNVS+Wnv+YgNEZ9OBpY3Xuz/eRs+svjI?=
 =?us-ascii?Q?KrU1M43jHzllXf3N4sbxz61NGGuHlyT5eEy0+gYpukOTjS3jV/ImuQ0fMgHW?=
 =?us-ascii?Q?Wj64qFMNeVcPfWvXeGsMNEfaqDJIoHxuA+5M24tLeUs+n996OXPJ6sftqyb8?=
 =?us-ascii?Q?QgoKLkQdQ8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6ARr1nIVw0HwVX9eKOK8SY+3wV25akODtJ9HNprtixZp9pznvOgX1plTKME?=
 =?us-ascii?Q?jmYlKw8HsFU603706VmxWoENdkemXi6GJ9EBgaq6QHM63QAB0YYBEHx1+6Yx?=
 =?us-ascii?Q?oduWFnw2lAT7PqGR/LUHEaueqGXPl51gtp93j5UM9LHGrS2p52Bapm2o4dys?=
 =?us-ascii?Q?I3uIxQOtkMXhmE0Jvy7KSkXwaHyotqDR01i6IZt86Gk0GQFt+mEt0eai04hE?=
 =?us-ascii?Q?gHsZ4kDyvLuoUU2fvnzZjIHZq8zWQvEzRhRVrRGQ0vEudjtcOokP5qQw1Oaq?=
 =?us-ascii?Q?dFsmyRVKzEEROhS0dJnsGEl0M+UZD5onSyWYfexeKFPgARiTR7YcUvBW9gQI?=
 =?us-ascii?Q?b1uLrnLuiZ+eioQAJhycsDjdphe8JUIgBzeKNseaYDiVNcMPIRzp+p3JN0lH?=
 =?us-ascii?Q?f1XmTUaxS4wlIBxr5fqCz41lmy/cIvqnC5kXhWKLiKQkhVJSb1updgX07Ais?=
 =?us-ascii?Q?rprdh9+yD2EuKcYuISU4dJLO85aY+GIZY9htXLEjtk7dJYPxJGgD7QnmDS4f?=
 =?us-ascii?Q?kEsyR/Z9s/3KdreSgSQw/R6w6HsA6o9MH4rQn7ZxeusxD7zMa9riryZo3p4w?=
 =?us-ascii?Q?f29Ydm9gOUHxdGO0WwPUSOCfliTyjRHtt5aRGQYpVV1Jc59WjQ72j7juy8Am?=
 =?us-ascii?Q?GVU+FszSEYXvMYCuRijdhG1rSoO2KFX0OGZQ8D9Sp3WutnTeTb65ITU5tXvK?=
 =?us-ascii?Q?zz0AMzXsbz65olaocf707TKEVLD2TrYRKISWJwHF7BmPflNr4enkPP7ktlRA?=
 =?us-ascii?Q?hsLfwt3SCzrhRdyBXaatV4QvnnM3XzeaKs368FhBWYyRI2gBdbicEVIVY4zo?=
 =?us-ascii?Q?lvt297TBJihOWucy/UUBj4iIEnRA+ap7IhGE1WfdeXjHlN5+PTPkjp38aT0B?=
 =?us-ascii?Q?uNKPs4LbiDR964cNPvl4337fq6IxC4WvgSSGtE/de4lqPMEiMfj0arb+oHG0?=
 =?us-ascii?Q?QYFO88Qk7VMiQ515B2myNF7m4RbHTon79TmJqMR/ZA1WDY0ASdQKVl/ZVq+m?=
 =?us-ascii?Q?fECgCZsRryBVpt+UtjYkFrcZwuYiBIIMaf0y+5mn3bya94AQ5kEdxSHgFcBs?=
 =?us-ascii?Q?T7HZrOt6aeSRBlfPxkxVd0aC9RNS/BoZ73QNe9BK0rkqVqbsVU/M/2aMjbna?=
 =?us-ascii?Q?jJ2BTTsVTVTtquIPNgW6VnglbZP6B9d0eFzxqUXtrmnq7Bm+RwsrEwxybbYr?=
 =?us-ascii?Q?PlVXHyadlK4IgUFFmFmSbcscfhg7GBskrWUdl2e++TSCRTcMcpHwP8PE4m9U?=
 =?us-ascii?Q?mBJkUCjrnz2WUR5cAqjY+GNp/LS63TGn5Z0zwjPBIl05dD14G+XHt4wrp6Qn?=
 =?us-ascii?Q?U4W0sLqxU9nS6LGdJh3snrgWfpxw9KGI/HRshwRvEGL2OWc5fZ0ievT1WKjs?=
 =?us-ascii?Q?hcIGKVEVBLfkWeUwttKOpkMMOU9DflUQnCgqfR4WitX0rYHuDiJQvFypqtqL?=
 =?us-ascii?Q?Tm+cAYF2jiSyCR5vvFRjgJN1JaPpPaVIjrMQ6HCyxJqKZIEIxxy/9fPtWVSv?=
 =?us-ascii?Q?wkpD8ntg2CIgq41txWdtIAb5ZfRChRm+fi/cGs6Gs9KSmscUFQOaYus+ABSh?=
 =?us-ascii?Q?f2V3azTI7YO3vwfNmdNfGAThCMIXqQGkGGtYWjGf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6ee90b-dcfd-44dc-8814-08dcc591bc7b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:41:30.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzZeTTWmvsTW7s0MkC3WJ+ROm9eaHbcN8HgBaIXQKGrM/KkzGdW6kFFBkJ5LDNFgmoD0bTuEEyVBbWRA5ifRLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

For TJA11xx PHYs, they have the capability to output 50MHz reference
clock on REF_CLK pin in RMII mode, which is called "revRMII" mode in
the PHY data sheet.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change tihe property name.
2. Modify the subject and commit message.
V3 changes:
No changes.
---
 drivers/net/phy/nxp-c45-tja11xx.c | 29 +++++++++++++++++++++++++++--
 drivers/net/phy/nxp-c45-tja11xx.h |  1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 5af5ade4fc64..880d4ca883a8 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/mii.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
 #include <linux/property.h>
@@ -185,6 +186,8 @@
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
+#define TJA11XX_REVERSE_MODE		BIT(0)
+
 struct nxp_c45_phy;
 
 struct nxp_c45_skb_cb {
@@ -1510,6 +1513,7 @@ static int nxp_c45_get_delays(struct phy_device *phydev)
 
 static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 {
+	struct nxp_c45_phy *priv = phydev->priv;
 	int ret;
 
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_ABILITIES);
@@ -1561,8 +1565,13 @@ static int nxp_c45_set_phy_mode(struct phy_device *phydev)
 			phydev_err(phydev, "rmii mode not supported\n");
 			return -EINVAL;
 		}
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
-			      MII_BASIC_CONFIG_RMII);
+
+		if (priv->flags & TJA11XX_REVERSE_MODE)
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII | MII_BASIC_CONFIG_REV);
+		else
+			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_MII_BASIC_CONFIG,
+				      MII_BASIC_CONFIG_RMII);
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 		if (!(ret & SGMII_ABILITY)) {
@@ -1623,6 +1632,20 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 	return genphy_c45_pma_read_abilities(phydev);
 }
 
+static int nxp_c45_parse_dt(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return 0;
+
+	if (of_property_read_bool(node, "nxp,phy-output-refclk"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
+
+	return 0;
+}
+
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
@@ -1642,6 +1665,8 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	nxp_c45_parse_dt(phydev);
+
 	mutex_init(&priv->ptp_lock);
 
 	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
index f364fca68f0b..8b5fc383752b 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.h
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -28,6 +28,7 @@ struct nxp_c45_phy {
 	int extts_index;
 	bool extts;
 	struct nxp_c45_macsec *macsec;
+	u32 flags;
 };
 
 #if IS_ENABLED(CONFIG_MACSEC)
-- 
2.34.1


