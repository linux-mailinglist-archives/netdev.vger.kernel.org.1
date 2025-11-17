Return-Path: <netdev+bounces-239272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2027C6691E
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id F2DDC29897
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23932862D;
	Mon, 17 Nov 2025 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XbbZu2ga"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4713A32695F
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763422917; cv=fail; b=Bmlxm0XcJcUxJybkNpaAX/d1OcfrnyeQU+WfYlmrna1bIxBLdfxgW9NBjQZt66QlyqDuGzeVn8g8jtEQCTotDm9lhPHQuFCTwYCS8p9J4EAt5QJxqL49Eyupm5Q8RM88HBR35vGA5nuzlh964jJsDOdMon/EOCycV0IV7/xEzwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763422917; c=relaxed/simple;
	bh=zKYCeSwirZlsM5JyFLOQ+LtCNPDSnJJKwMm+EHkgA/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oe02WJme+bs/9T+9iExh3cO8Ge6L9zOakjP2LSZc0LLR4RnsiFNLjjRF1h9akh8P5+fpLE3j/Xk4pycaVB6nzhivbn/Rr4KF1cJ8ETKHBxugvTDLX//D/guVtqTN5Nr8ET6uiVdrhTEOr8HQGpXgIdLhOLa96SlQXkWDobHRY1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XbbZu2ga; arc=fail smtp.client-ip=40.107.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKLtAVtHenzJRW/ic6RnMXe1HxvtldXNgjAsT8C+3xKrQNB+oUfZYdU8LvWDZX7+7od9OHkYHNxSnl4qmuFr0l7UPYUHKf0LZafDkLJv9h8pcYytYdVPp67sDK5pKGXaAZHTs2rea2dSSqpvXF5so6BMS7aAnGr+ZzhSwTIzBt12m5oBeEw+JxLEWNOKqmDsKSOm2nrcBUpneez6b2djMZC4ZWu2ENVkmSyJ/LnXGx4jdz3GFUvin6SKzGt+kZuxxKGr5rKrzehcFYD+mpEeBf1M2mxe9WsgRQbg83tR+DKoO5PSAAgH2owzuEYYFtL9ju0D8oxhl+aeApe8qjQcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0hMzaqyGPxEUsk++w78xFxj9ZfDXVML8F1FqlHCeNA=;
 b=bwQGlt+VUsWkJFtJliVTYrn3ndzdQowq5NuWwM9+hYgTC0FQIHBwe+I01S/TA/FGuf7r8vjUa+IVVz0Fbjef75OKWaj2o7pQnvPdT7gamK3QyKKWfs10PoUiuMmVXYAacYrJytKu0WeVVKxIzrEhod/E9crAdsBKbukAaHuVxEBHOdFkkYy9UT3n0uwrdyrGYXmGuW514EgbOfkSBAgaiXF8HC2KLZkNwtucFgwMUhZt355tLK0dPCf+YSSoB9InazV3pWsxKnFSapilrH1ym0irzDHaM/qrBxyd4ktbMH2dSI9iY96qrFeLC8Mn7HleX8qL1UOoI/fL++J9J3+k7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0hMzaqyGPxEUsk++w78xFxj9ZfDXVML8F1FqlHCeNA=;
 b=XbbZu2ga5zeeBYUkXhT+igP5CPu2YrlTmXRCumXQstH+Qh3+mZsagaLeuUMFd6OamXI2ZnvJ4dw80qDVKf0zjta/KeLoekDEleQiVHrLigUOw90GtecPDe13DOz9umhtf7liNZOFJ0RtsBCzCEXx6xCtG69kvrHEocIuU7PSNKs3ejiWcPEn56V5wu+DOzKjAfx8MRvps00/4eCIERS0eR+pibiodTBRxQ/4Eua1eUESwn+mlTKsaANsE1XGhzNJIbdMXW36PHL54FS3XqB3/5CU0bS+4und1h1DPzriQ90UF9D+4AUilJXHP81KeIG0+s/tls6D5AOylfCcaD+MPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.23; Mon, 17 Nov
 2025 23:41:40 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 23:41:40 +0000
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
Subject: [PATCH v3 net-next 6/6] net: phy: realtek: create rtl8211f_config_phy_eee() helper
Date: Tue, 18 Nov 2025 01:40:33 +0200
Message-Id: <20251117234033.345679-7-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: df3f3f7f-5a10-47cf-31ea-08de2632db5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0QI8MNtmrAchLW6ohLgcos3U+e96BY+RM2JQ7TXChgOH083hX8fcKdFe0SNz?=
 =?us-ascii?Q?Hd7sP2fbuZ3qYcMEUN7rgIv6VrHTxMB9H3Uz52f59HSUJv1AW1JGo+y0QU8z?=
 =?us-ascii?Q?Hi7uS1fE+Mv86hPnb9RM4qwg5fmMAPXoKKzSr0R4OkbhqBLTud0A4aA7U/iI?=
 =?us-ascii?Q?ueTT77Te2o/RM2P68MFvK5AjBEgoZ7+UxjZ83M1hG3fkvzb+jDWOvDSs28wM?=
 =?us-ascii?Q?fwlRltfEb+gvcPpWG2Bv9WcuQEWECG9Gz54oeZMDwXcQS0UKPg5k7J1gl4VQ?=
 =?us-ascii?Q?WUyunFjjj6RisIELQu9n1Kkd8MtaYopqE+MLRAimLvdAU/6li/1cHCyPeV6Q?=
 =?us-ascii?Q?Q+Wp9wFqdbPf0x5Mli64MdnJrypm0ADJt/4TMTipCZkiXhhBpoO8C+btlw/a?=
 =?us-ascii?Q?Rqcn1ZFK+Zx9qBP60DpYF21VgftY8kuQ85kTBDilTWlaS+NoimFNYl0dN+GN?=
 =?us-ascii?Q?C5fPfjwGtTAle2EEkddE7E2smlrWhgJ3sw28Y5lEoRdd1VuknO1BwC2gxH2R?=
 =?us-ascii?Q?OwA6atGEBci22i/8T7rgAc/fmAnGnf2j/PTs4HxLVvQvRwT+HbItwycl1YO5?=
 =?us-ascii?Q?LxSYqGtkb+2Qj9Rwav2byfgmYGTlndJ4dqxW8sbvYjV35S0knUA8cvxA8MHx?=
 =?us-ascii?Q?ELOEq/m7o9LQbINJGC1yCpwL0ncn0qGXb+MS/4/OdUSdoC0s5/2F3a2Fzw1E?=
 =?us-ascii?Q?Hf0NsZzmccUY3VOi5IEfsHuhaoOPCTO+0ejFdHhAulOFgo5xJK3XTN+BC5QK?=
 =?us-ascii?Q?JmT5FSjjGBuTwsbCFXGaLVwN5iew8ZeLHZKIqCOeXkQOsqvxi1Sv/YpOoyCY?=
 =?us-ascii?Q?bHWPMIbLkC6FUPokClYVFgiDfxgpOgEqz3FycAM2HDPapdfBwAwtZoMW2psy?=
 =?us-ascii?Q?BIFrvHoDyO6OsiciGx+LIqo/ZEu0Q3x6UjznSGOH+yFyw+TyPNianhbi0rCd?=
 =?us-ascii?Q?JK+lwcvKNmAjElLAWlfRk748/bD9GlQMdSAi8Gbj895hj/Ce1RL4HASAmHNz?=
 =?us-ascii?Q?6tIt+X8xlubHK7HnBsu5er4vz1Uht0Z7WhZgE9ar5wqDS/8WeNAQ9nEsxpnv?=
 =?us-ascii?Q?xQAzf4lhGG0WKK1tNn1Fcu2r2HA+nDc1z5aHxGY7m2V9i1zy3YwghqK9P93I?=
 =?us-ascii?Q?W4YvFwcwzzQc+oCUqIenttw6rRwjLgU0mnbLLkdv2fQflaqd8WnJRNR/8XFK?=
 =?us-ascii?Q?f8bVoOAZvVv+bs1rWWS6o26j80s3u60NDqM2Yd2TPgYOMx1xYkz0qeoXuGB7?=
 =?us-ascii?Q?nFRg3Wdm4ABAnE7W54fq0PAKBIySnwvU0p9zQkPPtiA2o2PFoGGRu2aHziZ8?=
 =?us-ascii?Q?KqbYwYOBTxVADjrt/eGeBmGwrulqcWAOhPckWCzjs4ZSvCwuEMZMyFTIW8Uf?=
 =?us-ascii?Q?j9LK+2Y3RsZvfTOhp3iltpGAlIqIFP+3oRonLaHhLZntjpt++mDcouqg6JHL?=
 =?us-ascii?Q?rjjlKnigHfw+T9wXcpq0VhMjn7Ptx3zh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rf7K0OaWejjjFY14xcy3vJ/jHbfN95LbHwrdasViY7xZ+AITszbAL6Gc3Cmu?=
 =?us-ascii?Q?E1QR/bPMRbc523d9RE97fCjia0v2OHdlo8VMLDyM2xohXF1uyoP4DCYjIwgq?=
 =?us-ascii?Q?LVQ9P+iGqnd8AFB1LGYGhSXRKRYKwUcWAADSESRXU02g9P1GWuTKm4X5yLOh?=
 =?us-ascii?Q?6SW7LaPyytVJCaCtLJgpy3WytR3nD29wfZMkqA6Q6ZVdQAoXTL7abTg3D/z4?=
 =?us-ascii?Q?g1hBiwvCup1Rw1mginItX/fG6sGmGbtfS+aQUFo1FVR4TkbBHfre/JlM4ICZ?=
 =?us-ascii?Q?7syVOckqAHt0e2NI2uaaku//EEnz725zHr4TFXAjuhsmpCPTQWUKftfgll0C?=
 =?us-ascii?Q?H/d57EleybMpg9hgpcp8zklC5XxKOcU8YJ21mdVG5NMIuYrbAnZAJoq3aVut?=
 =?us-ascii?Q?+AvvLtm2CNKSo70iq5Ivp+7zPYDz3oQ0P/uYrHhQSZevFyyqmfjExgc1tuYu?=
 =?us-ascii?Q?kziPibm66ldlOWQxTatkqNzTVmdtM0DLEjyBirxPC4RiWIywD4oV1DZCRc1w?=
 =?us-ascii?Q?VNVrac/PNTqMNsRppn46ot/wP/9xw4LLKhDOyv67RkmPnRQKgrkfGtmS34H0?=
 =?us-ascii?Q?HrqsOZvbtUwVMgYGo3aPeKlSqJ47QjRQHSgqZnxfMao4kGyii39+y5QGj1wC?=
 =?us-ascii?Q?HnZlJoMse6h3SHy9YNecx8wj/AxgbMLZVVwTovlNVTJmyiBxLEpUq8xQPHOg?=
 =?us-ascii?Q?PXDafKZCjwQqywKXMu9iM1o6maM55FJxBoM1NuBlPTG8uWsGXnPFGg97Xt00?=
 =?us-ascii?Q?hKyxaiAB1At4bkr4O3iyJsoXg+eVLOrl9OtB8tN8mmysQLhNIJJGlxvUy8CE?=
 =?us-ascii?Q?8FStQ5nhR8JckWZYfkj+HPw+TRtNPIdCE1JkEcgVfAnBTXcHoDGQYsZKSsA/?=
 =?us-ascii?Q?knKrwShiAuNNpVr6q3ang21at9OUBupPD38QaV59XLGJj3FR8ckasKpSg1va?=
 =?us-ascii?Q?7JDdUOW9wwKPcI0WpHGNCxjZjJ4J9jg/f+42g6qfH4VuDn61DJgSg6Oc8mus?=
 =?us-ascii?Q?BkdPBSqnHrLvGWTF/p4L99QqqcK+BdoxJgTBImkAcAeZXN2zs/jcXgDiilln?=
 =?us-ascii?Q?jWbv2B7sm2QtF5OZBdoRUDhh0IUxQNavJRKXzezQ+tSviL8N3y5BnZpr4kHk?=
 =?us-ascii?Q?hz5mAjgUb8QyyhCiV8H9hEXpcwUiWlAJG3bZh/GfQc8yMFBrhyIiSA0JVxEr?=
 =?us-ascii?Q?6Fiksf+8BuNNj/d8K57pmLU5eMC989Iwd/r9FgDnX9UNq9jwu42NJlzNVj0K?=
 =?us-ascii?Q?G58PF9Kzgibbse4HT7vjfnqLnEzlOUXIeD4WzGGLQ0SB22bWmwZKo/4CEpbq?=
 =?us-ascii?Q?2WJbN0TmH0qOCMJMjc1A4RK2W+GXQH3UyZytDm6qGSYY5pwtXcK3tauCPGWv?=
 =?us-ascii?Q?sNzDJhR6fF6LueVPZgb9uww3sELln+wPEYmDeGUPHWNHVXAdG2VOvj3i0OSS?=
 =?us-ascii?Q?5Hdt9M7eFX7IT0jb3PWaIXJhzIP7bppmfNN1eHotqkFjr+kWPcDvmQzShzT1?=
 =?us-ascii?Q?H2isab1WcKIyDIdAVdzpveaoB+Xl1JQAMDx2XwYZkUjmB5lHOHwd9+t/3kwW?=
 =?us-ascii?Q?LXyRKQYJtXbZiASvIAY5k+NjQnEN4UvdodIu+IGr15J/HfMPvQikftFREVOy?=
 =?us-ascii?Q?ZENgyK8CwyP8/I0tN5vTcC8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3f3f7f-5a10-47cf-31ea-08de2632db5a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 23:41:40.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDJGET1ij2MH18M5yvtMInCh47S/ZePkjnIVUzE5HjLr8ZGGwiWM5ZVCCoI9Dp+CiKMJdGckvDziMPvRld/iDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999

To simplify the rtl8211f_config_init() control flow and get rid of
"early" returns for PHYs where the PHYCR2 register is absent, move the
entire logic sub-block that deals with disabling PHY-mode EEE to a
separate function. There, it is much more obvious what the early
"return 0" skips, and it becomes more difficult to accidentally skip
unintended stuff.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: rtl8211f_config_phy_eee() should not contain genphy_soft_reset()
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 2ecdcea53a11..67ecf3d4af2b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -689,6 +689,17 @@ static int rtl8211f_config_aldps(struct phy_device *phydev)
 				mask, mask);
 }
 
+static int rtl8211f_config_phy_eee(struct phy_device *phydev)
+{
+	/* RTL8211FVD has no PHYCR2 register */
+	if (phydev->drv->phy_id == RTL_8211FVD_PHYID)
+		return 0;
+
+	/* Disable PHY-mode EEE so LPI is passed to the MAC */
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2,
+				RTL8211F_PHYCR2_PHY_EEE_ENABLE, 0);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -712,17 +723,7 @@ static int rtl8211f_config_init(struct phy_device *phydev)
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
-	return 0;
+	return rtl8211f_config_phy_eee(phydev);
 }
 
 static int rtl821x_suspend(struct phy_device *phydev)
-- 
2.34.1


