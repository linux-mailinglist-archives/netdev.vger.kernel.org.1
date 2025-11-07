Return-Path: <netdev+bounces-236752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEBEC3FA92
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376EE3BAD36
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B81D31D753;
	Fri,  7 Nov 2025 11:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gS5/Bx7J"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1B9320A0D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513730; cv=fail; b=sWL6P3TRSXnXnJe1Zk+V8EM+VuJ2KJXQxMJICDNPx0JGtWJcupVozLyAdsJ7QccWHXL/TDtT6BPAJ25e0LZ9goRHGfAhJI65SKfpZDBoIx3dzFKALb3vRiPbcUGTEevC/yUiaDOgnP5CtMgCBK7J44cJb6JolKxPf6EZv2ohXIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513730; c=relaxed/simple;
	bh=UPsl/gFZIDDeS82G42JT8dsTiB4SPY0yRTBv2lLQuec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPeihakf2NktutJA/36YrM2ObAk7fNRrPL/krkg/xIFLn0FcFXQiCA3bbN+uNy4W2eVF6LDg2aIZYa4kOgd4wVRM557Tav670e8PcKFaPMZxm7ABo4bfl35oIzuIybbLZHzahTBP1thCwIGpnqX/MYz5MMNBEODKlOUOe1v34g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gS5/Bx7J; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b17HGVxL0Xpstg8csnYrUixFEW+KLqapLHUTjXvZKDNzkZFqrqjynqbpV15DUrjZN2g7UYpnOw4X5j9d+ToTol5Izew4DFZYI9A7VXDROrtE7Z1Fmc2HqRKUl/I0IDW325m7vQHk99UrB2CcKzAu4mcDdutI+t4XuTUeoY7sSY95CscxE3aDp3bmKgXAmiN1fG7EjZlUKlY5y7wrmIpCFDrtoaaj/PoholtRVHcZZcU21WM4trf+5oW4trQ+RQAUvWNQ3JMS19SP80AOBLS9Me8PuhNCacxBnRXbulCdS6T5VLf9WteGFIHxLZZMF0/WqgkrfzeU3bbbyLcQ+x839w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBHwjhUG1APQX00Zzx9v6yZvUB3P+IPZChz+YMBoKLk=;
 b=dtWyVfSuFbFnZO2fsQ/0e/IJv/yFa3YiimrSCUlFxEZx024umeSIQm5psBo6+pxRmEMNtkXQ5c/KIKDLu9L9BtZEqtXsJTBJWnJyWAHiKSR6LlpAwJjd97DZPeKAcq8UBfuCH0UWPJ0E8F+u5kkn+uxRwBvZxcne5U4AEFCPcASFrNJFJRdtFJGpR1RFBFpciwwo1LLY+0zxjKJTVHdQI/S5TFXYoT+624vW6YlIGW+Q1TqK8PUPnd6oE1gpQFyiNBAblK8EKl1zLvJ8SaPneiA7pvC42iAZI2Aq0G7wt5R0Zy+dN5CeDwzeHFcbIEvnENAcgan+976aqxvmNvN/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBHwjhUG1APQX00Zzx9v6yZvUB3P+IPZChz+YMBoKLk=;
 b=gS5/Bx7JCFwWht7VJNquqEChQatxXPuyBEYccvH00RWvQPRuO7Ds9xTzjZyRifqls9WFY0HC2HxOwL4hJzVcCbI8imKLA6nHiDGb4QKR/a+vwBFGiwpYnnwpLWqi8Jo1ki3KnXiYsF4yrDQEV4QgTIdGX93ns7Qe5XCwibxvKTmJ9PO1wLsb0hD8Q3CqxAlusnC/wdw3HFkM9LlfhcKfd8Uol0LnvpHVJcEbx8CLB0cijDPGgJaueJmIHuhXxsh41TJliLpLJPieBbo0Ox0oaiaZ4ZEFU4Yez/zsOGzJcPHlDr1mpYBDPVvX1e8OtpWooDzKhKd/4u/7muIxgqPIKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:39 +0000
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
Subject: [PATCH v2 net-next 6/6] net: phy: realtek: create rtl8211f_config_phy_eee() helper
Date: Fri,  7 Nov 2025 13:08:17 +0200
Message-Id: <20251107110817.324389-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1687158a-fbc4-42d1-3f28-08de1dee00d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyEWT/8vgPjCdkgAyFxFzM63WYDbd1ZS+XaWvk46nMyw9vzNLtmITBIFiqFd?=
 =?us-ascii?Q?gyY9MgQL6Zl2grvvMT4iCtXACw0QeX82EQQpuQa4BvfqcyM4ADkxoEI1HdYB?=
 =?us-ascii?Q?2wMS6I0Uz4OpraKQSA9wcQXTz5aitHhKH6IK4ordR8x1WlSGZJYQvPtqGjS+?=
 =?us-ascii?Q?a0+dbFyeem1YBiyI33Kravn0sngxguX3OziW4qyLjXXitvf9FdgTe3ZwIm+u?=
 =?us-ascii?Q?7RXRiGnMJEHr+++aRIYQ64tf1yynel0bdg1nMIqJbhXNPpv+w373I6se3YYN?=
 =?us-ascii?Q?lhy26To8cwiReBk7LdJGGSjLfTkZdwM+xVmQQZ8Fq4qXa3AXqrpW5hvXc5+1?=
 =?us-ascii?Q?IIsX0n9vZVHWuBcHaX5jThFylxtX+/Qkg1VzdIq6pWAzPAXggFNQ/pQa0+Ib?=
 =?us-ascii?Q?LokDvlYCs8gz76PudkLWrDvArXGyHdcdh9X1uOlrukiGJknewnTa94aBu5W+?=
 =?us-ascii?Q?Wtp+XHLRZtE3pqOmFwJxYrynmWjveW/H2SrQiC0Gx4hby05tjYZTFa/LHQyu?=
 =?us-ascii?Q?0pTbyIcg6063Sxpqp9MbkqDwk3p7+xk4A01w2h5BImaYF+Kb7QkyfbR4f8vL?=
 =?us-ascii?Q?wcEmbH8iiVUT0hMF6BoUKj9D6jqE1LLPM1weuebtbCLREOz3TqJ5LsVEvzf6?=
 =?us-ascii?Q?llxWvRVlqby90kg5/bEoYroRDsIoqsjztY/OPdRd9ruu4m5L7/p6eKwo4MvM?=
 =?us-ascii?Q?j67kiS1zr1vJQjAns4+T4WeGUvAplg1d8EL2cByFOds048B8pSz8vgqMaN0f?=
 =?us-ascii?Q?GUQJq+zXEhDe/DqFIw9fiq7YY9P6YhexjAD6HICqUQABPmLGAUXQux1OOUDn?=
 =?us-ascii?Q?NLDaDvd3Hu5oQDPRXhFIg0d+nM8CBATux00BjdBNaS/sAL1g8beb79/7OgUE?=
 =?us-ascii?Q?NxZRGIxSiqU9F3X1WDELx/RbT25c1NWl3mvaIGqD+vI97Ztah9yP4tB/414t?=
 =?us-ascii?Q?UkKdbval1sXP35IppccvmsI5CQgRdu1XmBrxGVWYaaIX3Yqs6RQQmCffDlxi?=
 =?us-ascii?Q?JUDzrvcY8EI6Br4Ded+q+FTZrfb71EEeNpEXCzf+NTXpWfTguizP/YajGKB2?=
 =?us-ascii?Q?1Bykt2pPDaRh+Ou4RDcYPlVszlutNp9ZV9BpPh/oqHbCiMoTQwZTrNrVK1DF?=
 =?us-ascii?Q?IK/7DmnPeijsbDHX8K0briXh+dBwpT2jkF5hbQ+de2vX6YFdwHtcEunJXtXz?=
 =?us-ascii?Q?6gL7KsugnsfhNqoPKNAgYRL0rddXQUQp1eHkSgoEnLczV8lmO0hrju5E5jby?=
 =?us-ascii?Q?nFj7XwQKCM52ftQEJmvLXgrKK0Y9W9cM9cTqFQiPsfIMOA8qKAx871j23F1D?=
 =?us-ascii?Q?2KQD3wWDPN8WUbHW7/Wq6zH7WfjjsxmQxqgIaFhFytS56BLuy+nGbiolkJR5?=
 =?us-ascii?Q?BmCzEnP5VaXtrZio6AB4sSMlHrN4OnOJcS/k/MwKKWeZsg6Cx4uLKVyeAirz?=
 =?us-ascii?Q?IkEplnXS4/z13Zf6giviWnEVu/aUkICf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nP3iUIkxDzFP8zJVSwux0XxhcKlZxCdMdIYGnkYCzsAxKv0rXu0fImzF4ACY?=
 =?us-ascii?Q?deqryvo+2VzfBIYVnWndKpQ/zlZs3uVP3NtV3OAfSp0GeFvXfcUFnxJlU+AD?=
 =?us-ascii?Q?pDHimYK9Jwaf389NA997PyzKTOg2xWjsAu19rS4X+qgGxu7dB1PSrFi3bYkl?=
 =?us-ascii?Q?YhPrMKnVrGihF9KDIbgNTDazy5WQi3qdydmXx51w+mKmBTsrfWLV6Z/zNZvi?=
 =?us-ascii?Q?N6l+RZRlq/XuLYL0dukof6ahUmg8HDB5tCMMC1+ukGs+7/U/v8/FCbq1xvaD?=
 =?us-ascii?Q?cvF1RBLE529KqxXHHL+l701I3Eta9grCxjwF+Oy6eQcfv473r9DeAr5+t5Qs?=
 =?us-ascii?Q?sIN0bf1o5qpdRwqfIHqmEcTqscXWN6/vAwlt3b8wWdQIMFCuAuzqnbZqDv4I?=
 =?us-ascii?Q?IxG1tvif6AL4gHgT42roDGyNrlbugVWtMYB5rc+2Mk6Lp8xs31LOS9F0VKlv?=
 =?us-ascii?Q?NcvXbe1FKiLOT6FVstvFSHSq/tpxmcMz0h58f8gE1StqR9N/AY9LUSnpTJVO?=
 =?us-ascii?Q?U52dL7HhNYJ5xdSG/ie/XonyPkB+YH6142yEMunkqgyiSbz2MUtqM1I9vqO5?=
 =?us-ascii?Q?1mUUCidlbCv64laguLLbecYVZ+wnAZ3bjsl9it18vTE4H5YSR+QO9auGyPYF?=
 =?us-ascii?Q?4Z12o6UCzOzOVx3u6bwt/+1+YvhYk+bm6zcxjNqp4u3/r8PbSdMsgY8ArmJD?=
 =?us-ascii?Q?FWskpj1w5K0BU3jTbS7KeMnu/HjCtcnrMdGgNmCiWnjipMqbCqnNSbBGQ6gO?=
 =?us-ascii?Q?z8PO1PjVJyu+EEulrgHENh/049GhVd1lVUlCZwlTmaYPVgSKzEbt9inErnYl?=
 =?us-ascii?Q?DewvxLQg/ea130GYQ5mcf+TUFx233/5YUnQlpPVNAomWAkAWLPPaip6yv6bS?=
 =?us-ascii?Q?kzOZ7v2OOSRPjPHw8H9lpGxhLXCbgO4aFB3XyHRbh32C0v5M+I/jhOz5BeTX?=
 =?us-ascii?Q?70HT4O6wltkrK3+tWnauTR06rq8E5LhcTFZSYIYsPKgOI4CAkFQ1iOb6I8fL?=
 =?us-ascii?Q?uVbleUdF/sYWI2UH/8gGra4b6jBvdT4uiHE8hUlo5dRMtBhF4KNbteEo0tq3?=
 =?us-ascii?Q?abeTYlFZjHCu0yoAfz1cMBm6mqv9AxmXxyvjJwB39THpYDcL4ytbvA8vCUvY?=
 =?us-ascii?Q?fkERVSKjoOgfmCtoUUWgZo/bYuz3XQqo6qp5ot2sF9/KDBO1bGvDjUEXIYst?=
 =?us-ascii?Q?oCx3r4Ab73nHmPFCLZrE3CGJq6f17Oe9xyynHwdAx5lnmD/SFnOvTh0R1v/s?=
 =?us-ascii?Q?Iuw4dqfC3LFkIfdATpckUu8TB7wHbktFlGDHZTeGu0okivra756ZoadReaJ+?=
 =?us-ascii?Q?kCervA58g3VFbaonjMpQzvbUwIom3PeSMrX3AfzS5/f+WSkGGfWWpu3f8Qzi?=
 =?us-ascii?Q?DDsXswRs/ReFYnldNK2IO6Y6Um2Yp0gSspWzwWT54OViSHc2uQv/v9lzCZA7?=
 =?us-ascii?Q?zMVMkHffSFqDMja08LWTUW5MAFh1/MvlCMRcu4h27GIDz5dd/s60M0AynuN9?=
 =?us-ascii?Q?zVWWXS/TUIxVJLcB3KykrzPnCjPmNku6MGPbmpMnhHn59XbxZHKtC8TW+J7S?=
 =?us-ascii?Q?EazizhRXi1HpqS8TGWoLvCDNRSXpvZ+vDvf45f0mOsd565n+mm4z2piVNiyZ?=
 =?us-ascii?Q?yNF2Um26Jda/FER1q6/UqUw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1687158a-fbc4-42d1-3f28-08de1dee00d9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:39.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEOrX4pCurnsiPOkIt3sIwSVuN/XRwBRxwqGzpUoeVTJBOR6nkkDhYqmqafZqk0HPuAIloZvE4JKcXqYllTH2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

To simplify the rtl8211f_config_init() control flow and get rid of
"early" returns for PHYs where the PHYCR2 register is absent, move the
entire logic sub-block that deals with disabling PHY-mode EEE to a
separate function. There, it is much more obvious what the early
"return 0" skips, and it becomes more difficult to accidentally skip
unintended stuff.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 29 ++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 4501b8923aad..6e75e124f27a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -684,6 +684,23 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
 				mask, mask);
 }
 
+static int rtl8211f_config_phy_eee(struct phy_device *phydev)
+{
+	int ret;
+
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	/* Disable PHY-mode EEE so LPI is passed to the MAC */
+	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -707,17 +724,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
-	/* RTL8211FVD has no PHYCR2 register */
-	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
-		return 0;
-
-	/* Disable PHY-mode EEE so LPI is passed to the MAC */
-	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
-			       RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
-	if (ret)
-		return ret;
-
-	return genphy_soft_reset(phydev);
+	return rtl8211f_config_phy_eee(phydev);
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
-- 
2.34.1


