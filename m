Return-Path: <netdev+bounces-285745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDUTNM+2/Wm4hwAAu9opvQ
	(envelope-from <netdev+bounces-285745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:11:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE8B4F4D17
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4FE13006024
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C438644F;
	Fri,  8 May 2026 09:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2734C3C4548;
	Fri,  8 May 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234396; cv=fail; b=d+35TDkdIediX41VP3J9DmqpV3aKsQckbkFKOMzV+jhUjp06Vs7IApOB3LBd7LEBfuTmRGW2QCWFeYrAYTdvWKjnlral6d2UiL4VOOKVqzTPgdVchAzYKRlAgmFYHR6mLRaGGK90njn4jXqkO9nF3e2rwKb1eQcTP2waybOkiSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234396; c=relaxed/simple;
	bh=vHXh5pkod/akY7YWPXbZDAUIl9ZWUsdnfrpal84xrDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2sIPLQBpdaaWJC5BofrtDuWRP0A5FsvLsSF8J7mdotArUtg5jARFppBOHqFVZx+VXBf2q/XW8GQt2SElhSpzKBbYA9x9RwZ9NAmDPlKo0m5/lWp+0nqIiOUCTW+/DpiPHeKWcrijFCvWyi20HwRh91ZJVc505/AJc2Z1kluGG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3zLpGi75DOxTB6pQc67ex6VcVRrhBQLpVwHq6BwtayztMCdpVhXgmSaVj0ZDe0RzIvfEtfXsjKHamxeScYejOeJdiW7d6eZp4feSFl5ldTQsKwfnyG+x29pvIMjCprpkK9il85ehcWgTij7bipm2xMWmL7jWbb+peZLe/5To2yV+wt27oeL7jnOJsOtiq4G0fVao+Sz68qsiaqPeGyYeki2Y+C/k6r8JMBTqPPMzML7z5yY9LDcPMtdjGtlKVKImftZrTt6h5ZB5eU7Y59FeDa2hAydusQ6CBYLN78WGSCD3W52QO4JEVteRaH7E22uYxNqu6hXXpYefvBE72AmbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnbPv8V+Cpj2NuJ+LSMLEVJD2RuILCo2O0eaScA5VZM=;
 b=jczT1/oHl9mF17eCycx8L7KXnjhPFAbTQ6jhD9LE3VgKBp8o8ftuADDlXgoNV6o5rsiqLGBnUz2zm+5lTRip8FK8k0Xw5sxCoImV1fit+Cl9La1R1apbY8Aj022eRgLAEy3P3n9y2I5ijO41h07vcuj5WjZsyXJyjKq87rx7GPkBwzJjZBr/7l2lWRmJQCZywMzaOZzKJu5tiKZIjKc2RxFZkUbdAZV3NNWI6Pa+ZiSgiow32xXrdhuTGnJiZ7sIPJXZc9sVyhONkzjmJVeZBjatl2+bTF5PmHiNa5bOBnaUxhw2HlKxCIWSFLCfxWcWGVcGOOB+Q4HbYl7cPFbwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0696.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 8 May
 2026 09:45:32 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Fri, 8 May 2026 09:45:32 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v3 1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
Date: Fri,  8 May 2026 17:45:20 +0800
Message-Id: <20260508094522.3952-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260508094522.3952-1-minda.chen@starfivetech.com>
References: <20260508094522.3952-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (10.43.109.83) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn (10.43.36.12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0696:EE_
X-MS-Office365-Filtering-Correlation-Id: 6655d6bc-36fa-49b1-3d28-08deace68ba7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 7g2SPA6KYC+xX34buesb8EKNbh2gqqWQAdE4nfRFOGbMFdAVTvLoE0WNmpUc+H3TrT91bpGo44jrdoM0+pEruNtOVOq3C2qyrkIBE1zSKxacvZfAglQ5dp0ecMeyTNpcnaMNfIRiCtiKWgSKomvMQrFSf7tX9HEnEADuZbDkmPOte/T9U2HyCksZjjikwt/aQEAAXsiTqUh8uPlQlH0elz4t7KMI5aUuk7Iy4sgsbcs+kjcyd9OWRrWNvtkAjOopCfC2IWkbLx8LCWdKW/hR5LoIRO9VuX08s76KgCFFxYegz1dipBAlhs+k3vIyYFMziwmBPs5t5GjyOUILeErGPHPZiZ4fU7rnY6paqqDSrxuO75KPuivZDDk3mnGylL+vvNJBx6iWkFKpQBlOR2gA/4jcH5Gl/Xgpped8OkUWq+748+c2TgdsyC6dM55Hh39WLSunmBgQIR74gyJG7H3GuZEwex5/jNMlY2TsKJdUeXHsliGR7h3no0C3ecO9+GWPg+uuAPGJLe4lCvxD65lbwwZdKxsJ/XWCsrr9H8xtBXdb77+1bz/yMZrgguw//3DR
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?zcJnBOqz9EOpsxRfAPAoMr6jaULUCrcQ8qM5MAo+INpDIAp68eUTtFDGlQxw?=
 =?us-ascii?Q?rqPXa3FV0Xg5l+vPNUUizp/HlFsoXQ0+xD6Ga90EPZYVYMThvotgcNWSAKrD?=
 =?us-ascii?Q?8UBA1wx3TbCEpD3gOwl4Y91F3esWc38eINMoViJB4Gv7KRif/ZEbicG6aJ6u?=
 =?us-ascii?Q?4ROawHBZUZky+h0sQvRQKdcrZAeLyDIzA6IH+4YmrBpPsdTqxOqrb2bYw9jj?=
 =?us-ascii?Q?+DAu9rWHuDXsifMQmFeqcOJbbPqd810D0LazuuDjG23qCWgGbj1sJLKi9nNQ?=
 =?us-ascii?Q?K/ikPkRjeMcpXd9+/dI4vnJJM2eX1xF9llevKqR9nvSbrdPV2aaLC7xvOn4t?=
 =?us-ascii?Q?hq2fm1uQNVi4pGqaixhr3EW6TB8sHgCjo1HUvV1E2U1Ivvbp2bQjk1KX03vG?=
 =?us-ascii?Q?EX2RRt7QfqWrl2qkCoGQkiJdmaVmOdMhF0YRKOwerHAwUBjyngTHD+oQGYE1?=
 =?us-ascii?Q?okqoDxEk8p8mPcKRQQkO6k7dC8nJGIUP2b9NRRM/6ylgTlbunEPWYCeNEBEL?=
 =?us-ascii?Q?0yO4u9pxOsyzmVfoWgVnOGDmqK+SruP0lvFyq9MAkSeoLc7W54QJXX5B0IA1?=
 =?us-ascii?Q?xtBtgPxGASDzrbK7G7I7pKqLn56ze2wjK2YA7qU/q7Ht3aJtSj1wREBY+OUi?=
 =?us-ascii?Q?fbc/tmqINqjjx1mDMHX6LaiyZZ8HHnb21NrWub/5715icbKNdUUkuMbH9C9S?=
 =?us-ascii?Q?ngjSfZvNjN4wU8/OIE7vFjc5twyhyrp+SOjgMetWNGWvTMfDa95/z1YkoD6/?=
 =?us-ascii?Q?WZxmwJP35cQ8XzkldO2d59r+l/248NQKUU1axqLAsaNpDkhmrHGNYj3jxAT/?=
 =?us-ascii?Q?iAlXLsvXDcO004OslUpZs06pZJ4f1jC0sd1q3aOQyUVJuaT+sEq93mDW1PNB?=
 =?us-ascii?Q?zYmYuzvNXqyQybM4ily4EYIK3/wfSVkHifnUjKnfjt0gJC3Ql4IBZpssH3Ic?=
 =?us-ascii?Q?2Eg8Qsn4uP5NCdLTRckZ60LRkwlGmNlwvP5Uvowa47ImCoFjpi0n0pN0Za7p?=
 =?us-ascii?Q?iLgKSJXRCEAb+k9CPBQFv0wCQJ9ZOnBJxwtsoB53KRPUyOFf1fva/tfylCcT?=
 =?us-ascii?Q?1iH4huBJYkw7lk7+i8jE7yBZPLSijr7yAqFV0WTqxU33zpre7+aHW+aA/DjJ?=
 =?us-ascii?Q?9/fRgqabYFBZJpv3t6Zo171BuChfGzCyxkhhu8BhOznF2Or55z3zhAWOyLKT?=
 =?us-ascii?Q?5wJDT8u05brve145BdBQzs3ERDgz+mvDFVo6jGzTttLYF4c/seZfsiojYR2i?=
 =?us-ascii?Q?xM3tlswREB1CufqOTByhuYU90rH9wZ24kC2mYS1bQMhoqNjWFcvU9UHy1/Bn?=
 =?us-ascii?Q?fFkrt4YSetOszcbc8PT3OpR5jcXPuVyeL2ENGs5i5n41+i9gBc+h3n05sDyk?=
 =?us-ascii?Q?9Wdpoej6ezwkhrsareeDG7bTZyb4nprsBdh2STBu3oURqXMn2WGZoK4LvVpS?=
 =?us-ascii?Q?hq7ItqDPoTgHFHbltXkVbWNVIwWg1rbIrRzj87R6G4ixRXzz3dO52pAgK1xX?=
 =?us-ascii?Q?GYPyxCgEyR9l+IPYf8/J/Bz9k/YYDz85DLRu0PpI+u1jgDf4dlypl/BkHbhQ?=
 =?us-ascii?Q?ugc0blGUNIlRjSotkwJfOVWeuagz+ydPZYofwNe2MS964RDBm2gEzZESB7PU?=
 =?us-ascii?Q?wHAEhOkio0AoNBeVoPtraqNhHTwQCXgekd5jZ0QrfpECGxfG2uF4jWMPpdi5?=
 =?us-ascii?Q?kK6rkGlQDe1kLavutbW/OAeIG7nGN4kreG2qMXEQ40RyYAAodJsFornRmfqk?=
 =?us-ascii?Q?4AZwoT2gl86RcMb7fR5sWL95GVvBQWY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6655d6bc-36fa-49b1-3d28-08deace68ba7
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:45:31.9863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPgc9TNYzBgtbA/wDJNeEUA0LGqcqle5Alhsn+7TTXZXELJMNGKFBNf9txT6Um1jyZES39JaELK7z2u3o69mWm4pXLQnvrBGvzuZZ73iQr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0696
X-Rspamd-Queue-Id: CEE8B4F4D17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-285745-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.831];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But YT8531s config init function
yt8521_config_init() already get the mdio lock with phy_select_page().
If calling yt8521_config_init() with mdio lock will cause dead lock.

Need to get the lock before calling yt8531_get_ds() and move mdio
lock out from it for YT8531s.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 4d62f7b36212..c66804537aa2 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -974,7 +974,8 @@ static u32 yt8531_get_ldo_vol(struct phy_device *phydev)
 {
 	u32 val;
 
-	val = ytphy_read_ext_with_lock(phydev, YT8521_CHIP_CONFIG_REG);
+	val = ytphy_read_ext(phydev, YT8521_CHIP_CONFIG_REG);
+
 	val = FIELD_GET(YT8531_RGMII_LDO_VOL_MASK, val);
 
 	return val <= YT8531_LDO_VOL_1V8 ? val : YT8531_LDO_VOL_1V8;
@@ -1010,10 +1011,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 		ds = YT8531_RGMII_RX_DS_DEFAULT;
 	}
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXC_DS_MASK,
-					 FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXC_DS_MASK,
+			       FIELD_PREP(YT8531_RGMII_RXC_DS_MASK, ds));
+
 	if (ret < 0)
 		return ret;
 
@@ -1033,10 +1035,11 @@ static int yt8531_set_ds(struct phy_device *phydev)
 	ds_field_low = FIELD_GET(GENMASK(1, 0), ds);
 	ds_field_low = FIELD_PREP(YT8531_RGMII_RXD_DS_LOW_MASK, ds_field_low);
 
-	ret = ytphy_modify_ext_with_lock(phydev,
-					 YTPHY_PAD_DRIVE_STRENGTH_REG,
-					 YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
-					 ds_field_low | ds_field_hi);
+	ret = ytphy_modify_ext(phydev,
+			       YTPHY_PAD_DRIVE_STRENGTH_REG,
+			       YT8531_RGMII_RXD_DS_LOW_MASK | YT8531_RGMII_RXD_DS_HI_MASK,
+			       ds_field_low | ds_field_hi);
+
 	if (ret < 0)
 		return ret;
 
@@ -1826,7 +1829,9 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	phy_lock_mdio_bus(phydev);
 	ret = yt8531_set_ds(phydev);
+	phy_unlock_mdio_bus(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


