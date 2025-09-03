Return-Path: <netdev+bounces-219612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9E9B4256E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676291BC5244
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA78D23D7CF;
	Wed,  3 Sep 2025 15:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ula8twtG"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477B23BCED;
	Wed,  3 Sep 2025 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913051; cv=fail; b=COswVeEn8+uMm5DfScLuucE4fsjnvpPqffl7lf7Hhse/X8WyI9P3F9wailq3qPApOeVejGtRZAIFJDVFyej6cLnOAby77njdeBMGELY7dwPdREx7jwKRdpGSO/KjwXqwp0wzBVv7tD/VGdovXYIqrPJC6VOCJwgqxtmhyekfUmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913051; c=relaxed/simple;
	bh=7W/p0hPqT9VysgR+mVkc05sAICJZNKltl3v0F8gwxSI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dSWWpE/ssmwRWS6prb8ZRkfQtGzVBvSx0o/eiADGZzgu5eMnzgG5qqx3Iqj8KhKz1h6oVJyroxfDS/tfBeYnrn7lf2rRqCI7VMHHgUOsVlT+p/9h+/Hky7j5FRQkpfsWJShcKheOTaP15it8um4DE2N+gVbAqVsOm2/z85AEKvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ula8twtG; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKCyANs7PTYbSyMe9f9MFe/YRx9mcdnIzfxu/3lvvCsHvvrJk8O3GE8EKihPvteiFyprbsn8CWWJQqDWJNlRyJM9eHVFxbrxntLbxWmzQEPGtN8jyT8LNvPg2I45bHeZ0buKx1QUMoMPLs0YlBCWCCkUmc2ekugxCcFsSN5KrY/yYsmxEKkSKQL/TqnUuNyWqPqslTgMV/dvDgcF0zxDCaNyqZOsskKqIZVtQSZwob03lrnAtUBCYDMzNNq6kzGBtB1A3IasrVo9O6PIeuN8jq/g3Ei5V237qKLBCH5cqpTlrYoAF7vmql0OSelfWTRlXnBnBce8PjBbsVlJJBrL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USyEviE9/8wwfEQva9ZbHjfv0ev91+9jLUhGwUnz7uY=;
 b=A2zlU4o1luZGnZmBwxzQMefA5h/4oCOWD1K4BnZeag3/xy3Mrj8VSK2QzM5SxuMUem00+PJ7ZEF2fZidRrfm217csH739PEbRL7HEebExyU/zzsbIFjInq3t3/MH2FBhy7Xv6mxc42qEEhNfQ90BRzp5oed+MWACsgwAfkrvUeShKWb2ZAJc48Vis1OQFN0hWj8hUzuJnXuySSMV79uePBoGV2Hm1OVONxZlbI+469tSwm74QZpaP44Kx0gMzLCZbede2ux4JUWd+2D+/yvr/It8kZBaEVQqe6H9Smw3Ny7fmCgnRJIrkLAbl7544vSilWXVktDOishRCS4CVWKjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USyEviE9/8wwfEQva9ZbHjfv0ev91+9jLUhGwUnz7uY=;
 b=Ula8twtGlbVM6zm+U14JjHZVVaQbJuKGFmkPGPsSn3Y0hgHlkhw3ggZLR7FAbRr7RXiC90kEEZOGedqe40JyGhnUeU37eym/sux2egw3ANcWfnfByJ+wIwaEaYCQNSLsUEw/HKqSSWvUV2Jy1G+vT8ZEGM9uxMzGHgK/Xp90pkDWTebLK/qcVstDhB3IhD8F4O2QAs0z97kUTiaqxA5tt5wwsfUbZ9ZOuXmzUnD9gC5RWG45QlcafWRKkxo6A6h1r1K+xGtwM2D/NMFNrGRfKHh3Dj581G/n7yl+6eJuJFItra/KmYxprtYbjVl0jZ1ri1hwb1JeFPBEofHYKf+Fdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU4PR04MB10361.eurprd04.prod.outlook.com (2603:10a6:10:55d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Wed, 3 Sep
 2025 15:24:06 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 15:24:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net 1/2] net: phylink: add lock for serializing concurrent pl->phydev writes with resolver
Date: Wed,  3 Sep 2025 18:23:47 +0300
Message-Id: <20250903152348.2998651-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0016.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::29) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU4PR04MB10361:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de6a8fc-f6f0-425c-0b51-08ddeafdec07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UpgVWP4hAKBgTYQbFCmzsKMpdGL5c1hltp9gUHqiWhi3OCJB+ELCjlrbWDIr?=
 =?us-ascii?Q?0fnALRi7nbIp2OilOO+1WJjAAO7zdTNnio5fymOqCU+inK/cfmy3XuVCyw7m?=
 =?us-ascii?Q?5ZeSL2Ngviyfx8nfINpHhy7osy/DpuJzpuq6YZVbCWHpjljGPnypVGLBi5dq?=
 =?us-ascii?Q?gmYGzUqFU3+4gFiT3L6zUxpCoujLFBHMhyttJjOpEsf6XQ6CszZkHCD0lbw2?=
 =?us-ascii?Q?XQhuV+l8xD+t5/s+h4tUUQtLTQ6OrhcAS5xCcttnwUPFWWi7aOM3gV/o8a7f?=
 =?us-ascii?Q?YUPctIPh23qtZHIJOlazN2e1P4CcaJVZ0ASLW1wIunAK/f42F6cuJNqJKu26?=
 =?us-ascii?Q?jfnen5ZCATNRBl1qPfms4idR+9rbEE4sJQaKLTOryLebt7qPMSVRAK9o6rak?=
 =?us-ascii?Q?2wSWVVPJvBw5RO2Ejs0G8voZFaj5anzB+5fR6Sk1tng2j92T6q/srqn93rU/?=
 =?us-ascii?Q?HTkNaihUMzvmgxgt/siH8S4cYTGssSXCXneyk2p8aUTxe36Qp6h/9w79xZzo?=
 =?us-ascii?Q?NVPethtZpgL7COG2vgnYSy7uc32N6ttJVdyDvzWu+MDjBWXQG0lnGsWwn7JH?=
 =?us-ascii?Q?EgN6DjgI0KwMv7l/Wwrvcghiv3Cfe589TIvMlvZ+L/lJNP/yXJylIinxUfkM?=
 =?us-ascii?Q?u9/CzDb9ISYkAo7mAaCGNYpd3T4K/9QgLMyjhmz9NagkUNHRBZ9l5LzDZt5K?=
 =?us-ascii?Q?YN2vRz27x3fhHAXSaAWwMx2j2bGY0LeeVZ3XPZXtJsXt35Gqs/aGg72buwTy?=
 =?us-ascii?Q?KKt728sqmCGOeBQz1D9/3KoTwQAFBenF/PVhRtMnPYudzTuITTab56qCQLnA?=
 =?us-ascii?Q?qULnldyGwtW+rTkE6W5DcKLwLO42cAy9nAKhVB4iyBkoy9B9TUPCYdT43OHV?=
 =?us-ascii?Q?0JIhYFvEDC5ylWq2+pqSO8h2fwwI17bz19NBDOYF+Ju7wqb8SVC0NQ8oe1lJ?=
 =?us-ascii?Q?YMrHu/cX4ZgXeshYckt32vzKMI9UJKgRRoHZk5TReBveG3v16a4wxTAAUels?=
 =?us-ascii?Q?Yh1kcXHKb4q4genG9MbcDw3ToO/ohEjSPaoU5IvvbHFjHDJDNkblhPMxoXLa?=
 =?us-ascii?Q?Vjg8S0QpT0yaCeQvDjiw9LKmXotsuXwEkBESKTWtBV8lnIl8/1TjMA4BCt4V?=
 =?us-ascii?Q?fH34Yeoc1Ie7Hn3Wfoh7kmqVn0E0ERvpQJHgvJRl+S3OYOhG1y3FMGK9gjWe?=
 =?us-ascii?Q?ChgZ6orZdoqxEF2EaiFEPSfiwKkrklbMYtVh8xc+E6f4E/YcubXzSxcA4UwZ?=
 =?us-ascii?Q?A84bP+q4hUOzVwmzSzQfU+cXCyRUdDACzr4KkyEKO3gr8nV6Am3JZ0KN69eR?=
 =?us-ascii?Q?BYrnT0cFrm7OyhH/3TfxGLvKT0yFnHd7ccLLWFT2IS8CaiH9h7Zcf4njlE52?=
 =?us-ascii?Q?jv9YAHtFDMuoJkGkeAzXfvRMljgzMSD3ADBcpK9Ag8MiHdOPgM3tuGEiCn6K?=
 =?us-ascii?Q?LSn0x/gwQIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JIVhkzSfEm/kxfRqT8s/FX6kYPbH6AOdScQ4kc7JKrXrQvwxYGD1F+1HvJEX?=
 =?us-ascii?Q?fdipQF201lZNmo7gHalROWsQ9sXwuC6TUOrI+5BIY8VYoGmQV7RE9ePPLqZ/?=
 =?us-ascii?Q?pR/Fhtte7B0jr86ALo0E17QgPsiWeIIa5SdA0goBOQF9npC6ku5c/aGalnZW?=
 =?us-ascii?Q?qMaK/V7aSDEll7fqPTL0kh70k3M9y90+rlk98r842ljzn5G1S/rd35+UtWbp?=
 =?us-ascii?Q?SqIQIk7Rd4QIKinr/kdkj5Dir74Co4eU3F3Apmimuuw7+ZrkbWS7dEH3s9Xa?=
 =?us-ascii?Q?A1J3Pdi1sDmqII3ateF4Cr5We+eStJoS+LnrTtsn7JSv5uhTfJpAZc3nHT03?=
 =?us-ascii?Q?IgEQILicWK09ytZIADrqR+iWKgs1gUPWJQMXTTdqoGBnCiskcSFyTc9nAk4p?=
 =?us-ascii?Q?VatGEmcbRfFjkChbnnO4rPgQqXeh8LyUiDcqNH5ted6eEwNigRTxVIgSE2dG?=
 =?us-ascii?Q?q2L82XhuKLu5GtRwcUa4iuh0znBe6X1QLsJUufEThxhPzKZtzqnDK7i1sbBL?=
 =?us-ascii?Q?fMthSWrYw84Z/OhAQwp8t4aUG7LzQVufewDN/lKAVI3glxyauWkniSnu2imr?=
 =?us-ascii?Q?BSj3nyziiPddVPh6kc4NTVwqW9LL6vNNdDHrZNYFtrgzuKWAtQJw3hpw6BHr?=
 =?us-ascii?Q?Ni4hzYVhB+xoKJcQWAfbbO3uuyeU+xFfbFl7dq7+PloDh/azHcuB8Btmq22J?=
 =?us-ascii?Q?QrEf+j9hxgumYCQp5uhRVSfhO+op5VvRYBFSLhSHHTx9S2k6Q0xcK42UDOjx?=
 =?us-ascii?Q?WzpsFeSrUDeG5c/tB/wIsfEGtK2JYPx0/rr3v+IT/tQmhnUT7B0pe7BxYDur?=
 =?us-ascii?Q?EuWL6wqXm5phLNkQLENm6fpwE6/FetDA4slxESysMQSYu4v6B1Dcwm5syoiM?=
 =?us-ascii?Q?gZVvMLcuBXH0QibbdCDi4DG3LV8R0peepaMNW7kGnbSAFvd6w7kmed/B4eo8?=
 =?us-ascii?Q?WAtLAyuuFw57z4BZ69JfTt2EMGgn3qJT8uD9QKE/+esnG3hacqgEEV7pRNKh?=
 =?us-ascii?Q?RGKAufXjDZhtBAHA6wagh7miNK+IDn+54SPQzlM/GRlHtbC+NVo3rwiUjWQs?=
 =?us-ascii?Q?Zme40mz8la93q/DUR9zGsPyh4NQUIBGYnFrAXnyzrNIIEVWg1sYIFVgzC2Qb?=
 =?us-ascii?Q?2+/EEz81xuNk+edk3DoU87Hnr9mxCKzqsu2UntXUnJDdoXSCpKPNIQQUn01Z?=
 =?us-ascii?Q?/gxuPcQigJ4wle+zQFAir3vZbj9O6APoSQysHDN+mcP3EzX6aWHcPdbVheRY?=
 =?us-ascii?Q?f4YQzvb4gyOSKDDQ6kx5HnTM9IFvS3Qr/xN4RQ9eqm0wLIKskBl3KU+9VHUU?=
 =?us-ascii?Q?yfSGzjM+IQL9xpWa2mXn33HP5CaW+h83X5H/YBDZGkZ38xs7iWF0g5dqJl8K?=
 =?us-ascii?Q?9LgwP3i6qeMmFlkL4/oLZ2XdHy79ghQonJ/8eg89aUnLT3VS36RItYm7h0Zw?=
 =?us-ascii?Q?3SpQnH5xT+AopXg6tcFlBh+0Ba5kL/M8gXTpT9RVWI8i9ParThE5Ejlc6f8Z?=
 =?us-ascii?Q?9sMcvDP8OmDzShEMgWGwDj/FNWzdXM2D1Afu7WgX52dfFPNl9SbErckZKao9?=
 =?us-ascii?Q?3qkJJvc/ZL/mQ0DQEK2QVlOlI4ZInJGiUuoatZ+4TFSdG3T5ujr497PFWC3Y?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de6a8fc-f6f0-425c-0b51-08ddeafdec07
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:24:06.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NDl1+2kOpM+T59ruX5m8nNXBdWZHgsv4KW2Sg/hlj5m/UrFNHk9MzuNSuDeUaLwpMaP5E8NZG6v94IF1mWWsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10361

Currently phylink_resolve() protects itself against concurrent
phylink_bringup_phy() or phylink_disconnect_phy() calls which modify
pl->phydev by relying on pl->state_mutex.

The problem is that in phylink_resolve(), pl->state_mutex is in a lock
inversion state with pl->phydev->lock. So pl->phydev->lock needs to be
acquired prior to pl->state_mutex. But that requires dereferencing
pl->phydev in the first place, and without pl->state_mutex, that is
racy.

Hence the reason for the extra lock. Currently it is redundant, but it
will serve a functional purpose once mutex_lock(&phy->lock) will be
moved outside of the mutex_lock(&pl->state_mutex) section.

A less desirable alternative would have been to let phylink_resolve()
acquire the rtnl_mutex, which is also held when phylink_bringup_phy()
and phylink_disconnect_phy() are called. But this unnecessarily blocks
many other call paths as well in the entire kernel, so the smaller lock
was preferred.

Link: https://lore.kernel.org/netdev/aLb6puGVzR29GpPx@shell.armlinux.org.uk/
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/phylink.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c7f867b361dd..5bb0e1860a75 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -67,6 +67,8 @@ struct phylink {
 	struct timer_list link_poll;
 
 	struct mutex state_mutex;
+	/* Serialize updates to pl->phydev with phylink_resolve() */
+	struct mutex phy_lock;
 	struct phylink_link_state phy_state;
 	unsigned int phy_ib_mode;
 	struct work_struct resolve;
@@ -1582,8 +1584,11 @@ static void phylink_resolve(struct work_struct *w)
 	struct phylink_link_state link_state;
 	bool mac_config = false;
 	bool retrigger = false;
+	struct phy_device *phy;
 	bool cur_link_state;
 
+	mutex_lock(&pl->phy_lock);
+	phy = pl->phydev;
 	mutex_lock(&pl->state_mutex);
 	cur_link_state = phylink_link_is_up(pl);
 
@@ -1685,6 +1690,7 @@ static void phylink_resolve(struct work_struct *w)
 		queue_work(system_power_efficient_wq, &pl->resolve);
 	}
 	mutex_unlock(&pl->state_mutex);
+	mutex_unlock(&pl->phy_lock);
 }
 
 static void phylink_run_resolve(struct phylink *pl)
@@ -1820,6 +1826,7 @@ struct phylink *phylink_create(struct phylink_config *config,
 	if (!pl)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_init(&pl->phy_lock);
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
@@ -2080,6 +2087,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 		     dev_name(&phy->mdio.dev), phy->drv->name, irq_str);
 	kfree(irq_str);
 
+	mutex_lock(&pl->phy_lock);
 	mutex_lock(&phy->lock);
 	mutex_lock(&pl->state_mutex);
 	pl->phydev = phy;
@@ -2125,6 +2133,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
+	mutex_unlock(&pl->phy_lock);
 
 	phylink_dbg(pl,
 		    "phy: %s setting supported %*pb advertising %*pb\n",
@@ -2305,6 +2314,7 @@ void phylink_disconnect_phy(struct phylink *pl)
 
 	phy = pl->phydev;
 	if (phy) {
+		mutex_lock(&pl->phy_lock);
 		mutex_lock(&phy->lock);
 		mutex_lock(&pl->state_mutex);
 		pl->phydev = NULL;
@@ -2312,6 +2322,7 @@ void phylink_disconnect_phy(struct phylink *pl)
 		pl->mac_tx_clk_stop = false;
 		mutex_unlock(&pl->state_mutex);
 		mutex_unlock(&phy->lock);
+		mutex_unlock(&pl->phy_lock);
 		flush_work(&pl->resolve);
 
 		phy_disconnect(phy);
-- 
2.34.1


