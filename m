Return-Path: <netdev+bounces-239271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD51FC66921
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1746635BC92
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152B1321440;
	Mon, 17 Nov 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FrUY+KH3"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1230E854
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422915; cv=fail; b=HXEtx86LIszGNr1Fi91ALaNUKdRUJJ37rIWWOXoiGEWL2XFergpXFiRGpidbC/Tj0BGRy/ZjGG10Xw8fJbp7UcosNgQFsidZ7ZiPnre+1hCXPlMdgWoX1vHekFWLdwKqiCIIutbfgXGCXbLTE3kIRTywnZjH5VnsnFWF1VvFhWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422915; c=relaxed/simple;
	bh=kBZF2bO4KaBEC3/KKBDGuXTn7rxmOnjVtQ3u3kghbWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O2iVcARnY916ec5ofuJkyxeqRQFgnsCH24iuhk+NGpNXKNzR0ffiuHIOfsWtNRMhsCeI7WXKNNTpLZ8cKzzyJ4x1SGih1vTV6td/CGzo6qFOiLy+zyMKPwXOrD0KIoktq3Zxh/cl3swR8OssyJ5mCY2sLCvvHvJ+pFPYUnY41Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FrUY+KH3; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MooEVhEEaHR7IooY30TE3+NRXNoHw3QWuM3FwzrQQLP4yJoilPubU4ISPrTwRRyyPnM+b76yIPIYI+AMm4pB8N5u/X7Mk8LRAHDhSL1STPlZuJe5EnesMKHbIThldgDk97Uyr30kS6UYPyKwH1K/sarAiDNyiOigASJTTry4ZLpIxVHh34lYPppGSHaNdaILIfpRhp479nGZ/JUNwIThV4BaQYgwiPGNhLtk7JO+jrFBjQbkmB9T3y9WXVRjxPzDZtaNmkJ0XVMmcXMa2Tr04+YLGoXxuHQo091FLp14ybQuP7YGEjrgPE04yos3NI9rcL3ocDPgtbdmU50zxxjB/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxvk81C/A91iL88rzzrZf8KdzxTK4+Z92tACY2gFhXo=;
 b=gfhROvNmxCLlg56PSkRYc/DF7R+W2YWyEI0N6xzX5/Kz8brdZtaoErgzx8QR+2bO0sLiMO8iSBBCX5G0rouRTfQlpMWhhFZTjITvZU3r0sAG7ObD7ZKZCdGPk+bs7zS5urBS+DV19TV+jDHQn6PaHrdxECbi2ZYUClWGLRIR9JJtF9y7BFUhn+dib+m6tlj5XJPQqVqcNQruFtDg1dR8N2dLkOsMEZMQeUyFzH7xd+w/ygQBGwEvVEMKgeoKMcwb1I8mwJnNMzoU+MQXkG+LmvkFjMI00+MlamDYs/AMYJYwaOZ0Tm7vx1hFjqb8t5EOD7w9DoP/mPghS0+8kkafLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxvk81C/A91iL88rzzrZf8KdzxTK4+Z92tACY2gFhXo=;
 b=FrUY+KH3mJq4MU47szwI4alTYVdJyQQQWBvw3DeCvZAtAvbfs28Jr9IgjDZ6KLP2YDXv2ZtQW60IYHzd+r2IcG2uHcFrTawAz1RJZ9vXY2UEPyKhJpYpOVVP6OFU7F5GoSZKF/94Fc5rkR1blg5omL78o8bxZTXCSUXM/RRhC235AdoyBf7XTclcNcVuU2nRJB9/YdMPC8e4UTTeJ/P5dpGbuzur4fm3JLQrfwBX+7ZPtZ/AerIkLDJDU+4Of79zp3eTtQlQ0hNo/AALgojOsT5KSlbxL6656j6EFZ5+SJfcAjlnSwhc5UTO2CZOv5eTjhUlosVEHW+Fb6tkjySjrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:39 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:39 +0000
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
Subject: [PATCH v3 net-next 5/6] net: phy: realtek: eliminate priv->phycr1 variable
Date: Tue, 18 Nov 2025 01:40:32 +0200
Message-Id: <20251117234033.345679-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117234033.345679-1-vladimir.oltean@nxp.com>
References: <20251117234033.345679-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::17) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: a8121390-71cd-440c-b503-08de2632da9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I/xMfdOra4pY9kA7zW5+5xBkJhTnzpYKqvMKz5701TgsHJdmuIhuQKl9UwDk?=
 =?us-ascii?Q?mScj/rXG7MgyhgmhkDvOqBWZcA0yn00/M8oNq1M1Sy8HdOvhIq/jEVsuzDK5?=
 =?us-ascii?Q?g+YfrtFLRfLsjZjdov/OsW5AmF+pXyyDU8Kf1O+6KLMwKPEfc5VlvPnPX6P8?=
 =?us-ascii?Q?0fAsKwn/uDHLC8owdJpGcxvPnevuL/OkVpy8Hc6ncDUTmTBwtlOYBgYY5cVf?=
 =?us-ascii?Q?U7OsZzFJar0kkwvTLx2UjTMAwJ7PEBIehCn2LRQSa8aXqWB/PrtMnrskeLJc?=
 =?us-ascii?Q?oCb8g9/k25SZIMsAkMAtHUqwyaRE3YPISLWM36TFbtnmvgFJ8XYymtI2O0LT?=
 =?us-ascii?Q?G4Qn2zzWhm6qzedE2nCWNQQoy/K54BkwKoKfVaBzlAO8I+B4VR7X2dwhmKF3?=
 =?us-ascii?Q?E+DoE9n4VAwjhga46qVDVkm7w32y/+K8AcP4+78dGqdtzuVu/YsrPpfrR5gE?=
 =?us-ascii?Q?Sx6h1+Oj+2+IdbsNUZCFxnG5zy+4yv8goACyTsajwdzQqJiatZeldtRoj7I7?=
 =?us-ascii?Q?Exu6/WBKV4kTVTBjZc+ahSoZ0t690HiLLst6L2LRSv0LOcUjLL8azs3sjzM5?=
 =?us-ascii?Q?0UAguTRaFl8oSK0w4yC/IRJQkl+XkKosgGetbG1nCufwGfQ5sFRLG/8hUn4Q?=
 =?us-ascii?Q?iO5DC06gxMr+2AHjZ8dUCGgh6HWmJdn0mVnegXSXHB4aGQGvcHVkGtHprOPO?=
 =?us-ascii?Q?hpHWI6FEpfceYMu4bYb93lrC6mYXBV4p7gmalPob9kJQ3Y9Q0aM+XujGEOZm?=
 =?us-ascii?Q?nfAr7gYjXysgSROit0fPOIH6V+qOgl0R0qn4eeCZYWfCCbpbLhn1zqW8fOiq?=
 =?us-ascii?Q?tt6hXo+41rEBX+RMo+FH3CYgCYetFvPM7NO4orfdASJYHMXOljYxoWwKFpQp?=
 =?us-ascii?Q?nUgf5dvTKlYi2mQwXp5wJoFhWZinsqttwljyvqlGySo6gHaKDEmFZLWRI56F?=
 =?us-ascii?Q?uq6nQ+fMPbOrlrgVrly3TN3++1rninBNsWRoY5PUA4TQpbE7/iwblcj7/4L/?=
 =?us-ascii?Q?CQNNESYFaBhReoMH6JW8j8xGF9346BEUsoEnllx1TX8nnknBjjkYX+fV/lll?=
 =?us-ascii?Q?DEbbZK37uZZld2+f0WON5mQwVU6lWi5YJ6ve+LjTHA1ZIAWjmUcb/pa0FeO9?=
 =?us-ascii?Q?L0Wp0Hh+LXPiFrP+HTnLP66rQFp4kAjtb7QnEf7X6ojzCqOzI4YxTrBas3A8?=
 =?us-ascii?Q?wmbQ/R6vZ28MnrzfSJ5bnOctVpw70SDa/eNCbqGZNKnCS5+G+cqdgakQhYL+?=
 =?us-ascii?Q?tBOYxzj3S97BU3L4blSEW2z9y7h3VNh9vcxd7czFDOldxHNuxhnqcAdpg0zm?=
 =?us-ascii?Q?OKEKEvMmlSss3IZPHdPteUSi+eP8vFXcyHyOyI+flmy7nDDUbJ8ki1R9yD7P?=
 =?us-ascii?Q?vqRnhfEGGuifWuFOr1IEiecWANNiaYy6a/yOYJaLK+xeOw4yWcFwXcFMuJsW?=
 =?us-ascii?Q?3wHVlMS9Bk+KBsbpXmyZgDrHEN6JxUZf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FAnB9siTyQDJioqhKNG+lvp1jwxqlcHGObDaCOQB5jvqdsNLWbjR0r3SYbIu?=
 =?us-ascii?Q?8zK5+rQJNmeO6S0yCM/NfFWtTurdEluaNmmUsrb2i1ozmRoqJL6p8gTOT8fC?=
 =?us-ascii?Q?wEI2aUCQ7nV1tQabNC/DPQUchO6ruolF+/nnAlMvkn7IQh76sjyKbWdhClnH?=
 =?us-ascii?Q?/UZIBTuqi0Dj+En7++Wcps8FInGUiLUKbv76B5X2RR4EmBbb0Uns2+LjTKS2?=
 =?us-ascii?Q?/BFQSZOwQBpBDwWTuMTSrz5tHalhl/6lAgA3NZYYUc2ao8sOmulITgMsdOkL?=
 =?us-ascii?Q?CJpLTtZYxhXiOf9KkMYS3zolgdMwdqScKdSrE0H92la1mTB0EvTj35dVYfZ1?=
 =?us-ascii?Q?3UhlefIRyJM9S0tVBLy/ZhbjZwq8ZvxigrAvcM9KFQ/FXIwgkN29FGFdIXmw?=
 =?us-ascii?Q?dBdlToU4zQveMDuEDNVOYS6eu4lwo1+ACjk+zPDxrmXi9h0MLohOaWLQcLU1?=
 =?us-ascii?Q?2Vk/IvsOSQueFE6l8DAlsEa8e41BJtyJmhtF8/KGFCr52Gs7ncXIhkZc9nOv?=
 =?us-ascii?Q?Lk8vw9iR+qr592xE0FPMbgpCHBcy5iAI3j9AzXhjw6GyvmUPER02uyvoKMvD?=
 =?us-ascii?Q?ed4qSJxnLAKK/NndG3uBh+FcsDuZBrFKkXnG2I1fCEJL9avEJAGynnf/5D/B?=
 =?us-ascii?Q?P1f9VaxBfIvvaaKIZZY14/fX5qnjKAH3KJcdVo5xjfegp3wnrPTTON3aFsI4?=
 =?us-ascii?Q?LPCYiJKLSK9q8aCJaImQjzgr3OJHCFJnvtHHv4R9ZaV7y+DNcDjeDu9N81qU?=
 =?us-ascii?Q?5yLIPVgRf+81zPf2nGLZzydDbcd8dknhs/HvUv/h0ShpSyZOH2NcqRWjFm+5?=
 =?us-ascii?Q?DOZd4ZaObwnqMiJbdXJfMK4UUXNJs+0a9OwQBGF0WetjM0CGPQm9/x0iiEk3?=
 =?us-ascii?Q?oPLDJc5k9E890vNPGidiKwEw0eKYav7YJqW/6wWrFfWttZrxaY1ICBJ8InEa?=
 =?us-ascii?Q?1yjYbw2JHemRHn/w5yk0V6/FYL7ACJPSGQbRnCrbSm5Q86oQvHY1eMt51usT?=
 =?us-ascii?Q?aI3SCrtkVSsde//r0ty35b0RBJm8qkyZKKGo9HczL1Hh/XA+GOOy7Ja0Z8uj?=
 =?us-ascii?Q?83D2UVHDRbe/Z5MHk5BAlj263kgeaPedaTq2WhqvX30vrcA+ikR3LfL+90JZ?=
 =?us-ascii?Q?SFRk5prUgSqZ6EiTPJqXf6XVKitpxQT+ZAtpXe+dhKT6jpFQzmp/sOEGMQid?=
 =?us-ascii?Q?cYqIC2T3YxZ2bHHT9mismMk+9v78rTMlLOlMmIR5zv/nenyt1W1dhsb4bNhE?=
 =?us-ascii?Q?HtZ9nGpN6cxviVMXVzOPvtjMam7ooC4ZvAeKQFhryXjfCUjdsx2TmOF/0Tga?=
 =?us-ascii?Q?NnOT9EeNz20xFYf7hOLcei/h1IeNbktx2qGY2drOKU9/TVwsUiJaORKxwS8T?=
 =?us-ascii?Q?R9Ein+rrjjm39dpPp9Hr9PZLcikX+jj9VDceDL/kgJOYKyHTTPtB4fdSrN+7?=
 =?us-ascii?Q?fsyhsrSb8AH1MtgGAGp82a1H2IYl2s0fqRhOKa1BE4FHOtucbDZV4Bo03SLk?=
 =?us-ascii?Q?rCv7eeY0OHEEoiM8IBHtf3Zm5Cpqw8rbbsanyO307N3kNJFTDL+36odqJJx7?=
 =?us-ascii?Q?xBnJ3DGpvb4XBWeWrc32pKmg+7eidcuAgZPy1qUeEApyO41rKuv5uQPecNW+?=
 =?us-ascii?Q?/VMRp+Me0uF1mu9F3slLXW8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8121390-71cd-440c-b503-08de2632da9d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:39.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQ88ekcFvvQ6NzdyfrOPMl7V+q9S5eIMNjuluybpgV1eUVPGoDkQBjJXdGG42RGUV8d5qzfjo4FiDlqHY4ZPaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

Previous changes have replaced the machine-level priv->phycr2 with a
high-level priv->disable_clk_out. This created a discrepancy with
priv->phycr1 which is resolved here, for uniformity.

One advantage of this new implementation is that we don't read
priv->phycr1 in rtl821x_probe() if we're never going to modify it.

We never test the positive return code from phy_modify_mmd_changed(), so
we could just as well use phy_modify_mmd().

I took the ALDPS feature description from commit d90db36a9e74 ("net:
phy: realtek: add dt property to enable ALDPS mode") and transformed it
into a function comment - the feature is sufficiently non-obvious to
deserve that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2->v3: just context changes
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 44 ++++++++++++++++----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index da30cdb522a3..2ecdcea53a11 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -201,7 +201,7 @@ MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
-	u16 phycr1;
+	bool enable_aldps;
 	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
@@ -252,7 +252,6 @@ static int rtl821x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct rtl821x_priv *priv;
-	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -263,14 +262,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "failed to get phy clock\n");
 
-	ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
-	if (ret < 0)
-		return ret;
-
-	priv->phycr1 = ret & (RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF);
-	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
-		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
-
+	priv->enable_aldps = of_property_read_bool(dev->of_node,
+						   "realtek,aldps-enable");
 	priv->disable_clk_out = of_property_read_bool(dev->of_node,
 						      "realtek,clkout-disable");
 
@@ -674,17 +667,36 @@ static int rtl8211f_config_clk_out(struct phy_device *phydev)
 	return genphy_soft_reset(phydev);
 }
 
-static int rtl8211f_config_init(struct phy_device *phydev)
+/* Advance Link Down Power Saving (ALDPS) mode changes crystal/clock behaviour,
+ * which causes the RXC clock signal to stop for tens to hundreds of
+ * milliseconds.
+ *
+ * Some MACs need the RXC clock to support their internal RX logic, so ALDPS is
+ * only enabled based on an opt-in device tree property.
+ */
+static int rtl8211f_config_aldps(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
+	u16 mask = RTL8211F_ALDPS_PLL_OFF |
+		   RTL8211F_ALDPS_ENABLE |
+		   RTL8211F_ALDPS_XTAL_OFF;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->enable_aldps)
+		return 0;
+
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
+				mask, mask);
+}
+
+static int rtl8211f_config_init(struct phy_device *phydev)
+{
 	struct device *dev = &phydev->mdio.dev;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
-				       priv->phycr1);
-	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+	ret = rtl8211f_config_aldps(phydev);
+	if (ret) {
+		dev_err(dev, "aldps mode configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
 	}
-- 
2.34.1


