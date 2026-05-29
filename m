Return-Path: <netdev+bounces-292949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SuVRCU36GGrapQgAu9opvQ
	(envelope-from <netdev+bounces-292949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070D5FC64E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 052E63076F22
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F8360751;
	Fri, 29 May 2026 02:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE722DEA8F;
	Fri, 29 May 2026 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021327; cv=fail; b=n29QjqIWTRpC3A9nHj+Ys/776y8JGi88iZAKN+O4clmjMFPeNzxw/NMdNzzcKI80+6Bgphx8laH+I1p7Z+ihp8nvq37zyKCerFHxGfiweJ0syXRZTG03AAP7XimPryheUyWIMMgNqhVNpTzFDKEsgGPbk1e3d/wuJ68VDOIefe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021327; c=relaxed/simple;
	bh=u0ttJTpXLlVjCz3eHqOrs8s7FUZ3P2H3TD1Yas7v/QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ckh2KnflMMYF3FTDnkhwvbOlQVDSk/GXKpZNdTabrklKR40t480mRdhe1jlQbp+19QSoLWk38RHaoyfy75VB1uXxau5lM7buauCIk+yhqIVYYsHgHkZJvk/xEIcWkaNz7DaZh/ggcsqTaHcpeH5FqCrR+BIKknEjPvNnAOXiEsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8JWWjn/zjkhzVt0ag7T95OfbcupxxMOPwihFST/E76fZe03w5X1CyKUxQ0DH4MBaRnIaPgWItV1nz4z+3gL4RWdzz3JJGO88bm+RdCdmpaoR/dgjeCrhcn9PCQC5DE62zi8JehKFWOgG1Vd7/d8TmVpnKIgqoXBI9AkXdr/gmHSLt7MJHB5JpkfYFlS8xojqhnHzfXPQVSgTse+5WRWucUcX8adNjPwKoIKd+xaAFT0y4JI/vUAa9smGVZbhXWN7BE2reyaT+zT8rLRou6qIAp1BskfZUd60yvgYpJqhA/8jLux34YerjmFsMbmLMzgLRWyOrDi0Mznr8O9Y/Tsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJuuBA5WkN1D21V/Hp+tGGzCV3cJglPR6KXNVqn9f90=;
 b=ZI6QXw4iN5VAWMiAfMovj2Nl1WWexcX4+LSBCpupuWIkx2Ej0L4z+EsVwUWyybYzobMHgFfns/jxP9CXxOwGDN7JjDibXrQs+zISuj26qpqGMqJP9sTuKah2ZUPk5SlsXv6n+Wxm4Z6gymm5QzqzvZyPGzar5nBb+wWzK+JTZApoZCZL+rZA17FOhqkI2t5wZc32lPgE7UUh2E5LNrxuNJAuoB8xtjBQNvgK9YLZwk/S9BLQkRjJiD26UUCCcWZx/1TMteBeAddsSJkkv8s4lSeYE8a5XOMTXyfREBA4nDC6xmyJi1cLGTLgQ/dOzyOwMmior1rniT8LXwOeXZ8VVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0862.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 02:05:39 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Fri, 29 May 2026 02:05:39 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v5 1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
Date: Fri, 29 May 2026 10:05:28 +0800
Message-Id: <20260529020530.16856-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260529020530.16856-1-minda.chen@starfivetech.com>
References: <20260529020530.16856-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::6) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0862:EE_
X-MS-Office365-Filtering-Correlation-Id: da681775-a88c-46da-a54c-08debd26c7c7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|52116014|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	TePkw6h0NHN8XXAObzNwecpYmkvtgR1LZOeDIocrqNPtkcFT4zzy1Jqv1W4YxyNF3EXR8rRTvIfyzQlh7xwS91WH+X7yPa9T+nQqUU/qXZIUbcSIeU5DkPQoLfpq0mBsArwJ9Y7EVBxCIDHtSDrsYUsJ/Tmddt9/qitdyq7KOGFuvV4qH7GAFnntj40A7nrccCGYVXymyJfKE76jPtz1+uBjWk02Wv0PqL5H7q3wp57lb/04+qVid3FOaWjlQSVebcw+AyXX3CI8e4PfhJOq8u1UCBV/F7EgV9I23qaiy8tgAF3HHmiR8OoRNcbECDWA3mjiD+ewl2hFSbGScJqvOuAJrJrGuVOZQFBcKkaEgwQkQQVzoVhbNh3McbCN8XzYmfMeThs8TL7LHB10dJkGYyGSJiV1s9XvwUydWpLq3NLy0oGZ2M1FX/yGKBMdO98nSEbHMLIMgKEXOyuaGux/KDWd5YxeZlM+5993Jb7ImLbzB0aTAnC6INlbzEWzDaFaxiCZhQxbcR1WKShlxrWULvgr68ep5VcFeIgf2mRmcbyJJKQ8jFH7vl3m4HzIY1bA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(376014)(38350700014)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fsq8ouOE10x3intKiWztEW7eqrtySBtZZXVA107EFwOIyFN+IpyT52TCMWCU?=
 =?us-ascii?Q?3L4bmtRmo4ZGxK4FyeUEWzz5QOwTHw3r8p7HfAUrH9VoyZmvShPEe3V9bOhU?=
 =?us-ascii?Q?y1YVdWB+US2HWJl+Eh2I5C4X+yNPUKIr7NSBb/cUwgZjYt7ln3138M9BLF4J?=
 =?us-ascii?Q?AiVrCKcehHDTkMrmnp9Yz980GRA+yXfdObd45SkpdjF5oEBCMdys/lDRA/0k?=
 =?us-ascii?Q?NZ44bR6k74ApMlDOisjWxteOJjZWOAoVqW8bqSK/jfPE5bBnUbrgK/yXif6w?=
 =?us-ascii?Q?woWCATAAd7raFZKWGcmpsbRe/KTG85KY/G72op/egZYS+611uvdYUgLvvu/f?=
 =?us-ascii?Q?Kth+XjT40bKZLyjoKUxwYJQaT4kT1RtPlKAag+jsS1ZIA+huy5unT91/Dj78?=
 =?us-ascii?Q?qWA4HZYrUgTiBmDwpBrUZhXxfosgZzhNXAsi2HxewKcYBS9Lw+j+O8cPXxyr?=
 =?us-ascii?Q?e4xm/X61NPDtlo1EgpazhwzCcCxocFBzxtrDi3e9tuLjsHOJ56xH4ZkZbhem?=
 =?us-ascii?Q?tJBEAXq41NcTA4K8ouS9fybCEi9bTUnPkYMaYfOFaMMuGFAy+/DOP+Ba+A0I?=
 =?us-ascii?Q?wqeDcGejac33k1dIzDXYjrFEYoDNU9+dTRgiTO6zqN+oWvRHqG1YmIKy/uwf?=
 =?us-ascii?Q?7e7fLfmuXyF/I+D7nvHh7TyKlV2LSnZ4wpm0D53l9x3u0qaiPcRz6kCaYOX+?=
 =?us-ascii?Q?NaOyBKbDwdYTlbCI5lUREQoLCvD9b3+aKmDXzwQc0bndLDDDEUCSrc+voifU?=
 =?us-ascii?Q?BPK7SLC0wlr5qhntU33ihnXFxnS+/jeGfCIspo+/EYbgXTInSwlbxUuEc6p+?=
 =?us-ascii?Q?qFRPrfBIm3UGQQO+7V0LH+Vjim9jTZBDJD6S0uvQklEYFhYB0QkhgNFyFE9a?=
 =?us-ascii?Q?hl+ZmFAfXbbHzyYuAeYyY0xt89yVtxntXlkp2GpED3JLUIEpgiewmQd1soEj?=
 =?us-ascii?Q?jE6Og9TynTRtUjmUbbQmxEAepPCcxroTw6pde0mWS8Sx5CQjwv6fSTytpWnG?=
 =?us-ascii?Q?BU7+QLj+hbqHpsnRIfEmfqrIHwHW6T8LJe/fFLAkyaBBsUqQzfVG8jXdH7Gz?=
 =?us-ascii?Q?lB5jnTGWdiPcJnT9sodhZCCBLa2jkFcpAlfb9jEG2by+pwkCAiOWPKDnKPSy?=
 =?us-ascii?Q?hvbGtQUBCgcG7XNw6DUQWodqsJo0zonD/oxnlS5kuCxSm1Y9XtF1xbexVvoN?=
 =?us-ascii?Q?kmeeMEwzm6CYN+47DNpTH5Fdj8lY3uMmXLEW14ilpervTN7smdQftTOnX7GA?=
 =?us-ascii?Q?l2oIHhItUs3U3h8NVrVXWtU51hKBx367ev0hXrkE2Lje8BD2FKHyT6HVGtF7?=
 =?us-ascii?Q?dQ8QuAXEFUUOX0c8wzvbypCy7rtqi8VJq59smDx6JMkp8439eDb7MiFcBFE+?=
 =?us-ascii?Q?OyfobcdEcjhM5WA+joliPUKYOxhzca1Q7lWUBMXhfNyXT6V2mMH9qkrYxHub?=
 =?us-ascii?Q?cRovPF+s5xqT7Slftp9BWmFxjumzTMJJdWif/4BgoGlRNn2bmem3pB2ryVR4?=
 =?us-ascii?Q?btT3zO+JH5ypFaFA+CEbTZ2ZL7mMjMyCG6CVVQXBJwLAkofyiFN5yBHlq4xG?=
 =?us-ascii?Q?0fYlROOGe3XJY3kTHysL6MfSuianIYVvxfqsvZqN/gf9Gh8rqmfVfLoJEUfm?=
 =?us-ascii?Q?YZFS/rwN2jsiMXlRUEDOZ5OQ7gJ7SeHYfCeCtun2OOx4BtrRUJEdj6YwKqEF?=
 =?us-ascii?Q?uAl+E2YTiMUzu25rPpRfxHyXwJSHgFfE+fjK/xhu1ytU6rNAZ22JPqOUMCXJ?=
 =?us-ascii?Q?28C5G4sA1pycMxQq0pJMHfQiARu2e5c=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da681775-a88c-46da-a54c-08debd26c7c7
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:05:39.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSyeL1s0SQCOueexF/olvoz/DOfPZBIMzWreECmvehLtA16Gj88xNIA7zz9+75XrgCdbPXWNMdGkX4YKRWH3sYlD4TETWpKgNgkjZQ3OhB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0862
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-292949-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.936];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,starfivetech.com:mid,starfivetech.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 8070D5FC64E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

yt8531_set_ds() default set register with mdio lock and only called
with YT8531 PHY. But new type YT8531s support RGMII and has the same
pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
setting pin drive strength. But YT8531s config init function
yt8521_config_init() already get the mdio lock with phy_select_page().
If calling yt8521_config_init() with mdio lock will cause dead lock.

Need to get the lock before calling yt8531_get_ds() and move mdio
lock out from it for YT8531s.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/motorcomm.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 708491bc198a..688679457ef9 100644
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
 
@@ -1825,7 +1828,9 @@ static int yt8531_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	phy_lock_mdio_bus(phydev);
 	ret = yt8531_set_ds(phydev);
+	phy_unlock_mdio_bus(phydev);
 	if (ret < 0)
 		return ret;
 
-- 
2.17.1


