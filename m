Return-Path: <netdev+bounces-219578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34685B4208D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9183BE5BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208433009F0;
	Wed,  3 Sep 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ms8IU+wz"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493627A476;
	Wed,  3 Sep 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904880; cv=fail; b=BYNo9ku9o8k/19xJ93Z73bwHaa2eZXdg2/kZN5CYnFNVC9vIR1IaretYzI9nl1gbhg0fh4/RTBzGvF0Y/2wvK38aJyQrStpQdYgrtXOPLuqdPdAIUmIBnWJhGWeZ5dK9NqLn9dleVseMo97O7nQea29txNM8CjpbWENianDl0MY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904880; c=relaxed/simple;
	bh=0Nu1mwCL0ycqXzGwGGMf4EREOyNi2vo629B1leu45Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sQt2nmlANcHF73adUgrxq4fCVie4+MmYxlo7tLDxcR9EcccFkWZPi+2Dpu+vH1zUT+MuJyJ2VzrLaB1Vh87jRrgEyrnlQTd8VB7IVjoKIHXXC2ApZAOrLWf4sFJWI18feBfesOo1MCWaX6IGhl9xAy7qSOr1aXl/dfzUqVHLyyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ms8IU+wz; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncxKbtuucX1MgBjAe0DRQvfrwQf82+DVTjQfN5Lx/rpuRddzRNMn5HpZrHnuqIPumWg+WJDY4GqKU/mgtnR4QRhD0Su0s6D841fQLn9GLkxOOjemi03+V0m+Q2a9Pmwvl7swmV1ZG9lVJKTV1DjZu66+JQFXMEUPdlw9TCwfpoaRsG92Zi3etzBijMFFuC2foKBg7NvZhr32HpQF8jR3Ei81YMf1cQTetGppfArgAGSqcHk4wUkEynZ7XNU7l/sMq3D+36YRD29AGPFjv5VYHgCXNFkvEriiM48ighbgLRji/Fn/08hJfbrbsnA3ZMw1u0Q/oEG51/bHOghybvtZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPnh8YvZAZxjeBjj88rNPhDQBdHsPue2+ISI6rdHNKk=;
 b=JMyPaCNxzAOo5Dz55lz6st9ePJqnsIuJxtP28oAuZxk9Db0/JpLi+MKuMK+ER1S6v4xSbWSai2KUrpw1Nw4J+zJCwI4Wt1cCqDW/UPfQQR8JATuYhNGPE34Vw9vj7qpLA3BMUOYJ7BQYxSPDtiPofZKTjaL+dhfaXvlTVvcPK2jmg9ewPZych849W/QGqkhUvONfJ2HIOZnKdQzuMJTJrnHbtpNFgTJoMgOYIDqVA6M7RKVU0riCmQDAjn/wzlc8yOloyZcCfUhBUGAMXcUgXpdAi1udFObGzGAKWch/zwLvioWlTaXZ9O+hZ3D6OQAJr5byrQdgRtVOJTmihquLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPnh8YvZAZxjeBjj88rNPhDQBdHsPue2+ISI6rdHNKk=;
 b=ms8IU+wzrIIFfe1dbgg3FX1VP+JM+J1Yd/FMA7SR5lFsSPz9ayfWu1rsNt52TKOsfDJ18Vvqbha1eZ2X0HWT1THfn4+nKm/aUZYnfJ0iIoZgrIYwy0MxdxX3kIrH7SctsfmEwbxtffoGkpbPFuhCsHYH3qbzbK6IO5VbCRYYKukAJgBli0COmZQC3y7K+qHupOm5evQBpfaxe2ZLxVzCmK/W6LGAFAjr5wvU4Xcj5TRZwcZUNuOHkdEq37XmfBGqnQzR4W+Wt5RJsj5pABgdQiJYFmfazLePdcRLgUkrHZwlRAp1ohK7r+i9yqs8U+BVcBErxgQ/gJLgqoZXqXHCuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10420.eurprd04.prod.outlook.com (2603:10a6:800:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 13:07:53 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 13:07:53 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Luo Jie <quic_luoj@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/6] 10G-QXGMII for AQR412C, Felix DSA and Lynx PCS driver
Date: Wed,  3 Sep 2025 16:07:24 +0300
Message-Id: <20250903130730.2836022-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::9) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI0PR04MB10420:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b42590-fd0e-4403-15a9-08ddeaeae445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFD0Ul22KUkhIonOdY7YANJ6+zzqnwv+biLUEfabhD2jatVVPjwgYfkkHStw?=
 =?us-ascii?Q?LL876M35MlJAuvgl3qh8VfAd6lFRvg5zy41dAcZ8Qe2xkPAFn/Y77TcvOgnV?=
 =?us-ascii?Q?TqMVcg5K1qeRF+xOLrPXHuu3N0anNtu9RHJ/pe7e8VmUOrgzIix/S9pPmgD1?=
 =?us-ascii?Q?Kwa8Qs5Bg++G3DOlGIP5EHfoAUxJQXqq97bPaaSZr8/lXoXKBEyWoYZotYDy?=
 =?us-ascii?Q?ET0V+VukxM3YhDATvEE3UnDHeV2h0DITtwWSwKjw/y43LBIHRSKzxWVkBaFY?=
 =?us-ascii?Q?vXtKP/bwgs1XQkWuIt84lU4cHInyeOJB6CBugYPPN7Yk3i82VOYIsylOvK2F?=
 =?us-ascii?Q?/+laoEwyFCJPL3v0EZHyF9V88cBULZod3IVOcdXEDyEFrqwtm6dGX1jPlR8H?=
 =?us-ascii?Q?TzyRziShnrb37srgewVykmLMurN6UrlOKz2DejODbWxArkq72tfgiZfBgAVJ?=
 =?us-ascii?Q?RfDcjW0an1aW3voL+n10yeCjOwtw8Ame6mQROuKOvOwGTWPmATGT2r7vayv+?=
 =?us-ascii?Q?1K76sfH/MtRfXEPWDHBrTbcsq3vs0wv7ViQgPc67u2k3Qx8FBCiHeEVIRVwx?=
 =?us-ascii?Q?Vp2hLwH1L0uOQ14sVW1+flKqRQP6Ja70CQiITPUJi16HMZ6lVEzmGylmFAR7?=
 =?us-ascii?Q?HaBE/MDTaahwcrQkQgibFT57su9oHEO211IfCvgFGIiIciHdElIV954T80p2?=
 =?us-ascii?Q?RjhjbD3aaBbYqjIV+zY7x/6nBUxJpWMgCIX0hv/yAEPWwb6NNb2AEfSqF3xH?=
 =?us-ascii?Q?sYx8BfTA1g77qy0oTprE3pnUF/8Y9dux6vfI/9UGAq9j9Z39sLEljLugaqoI?=
 =?us-ascii?Q?QJxXdiM+nzqxhehFgv7UBOsuWPmgNeonQbwO8iypfvnZLFQjmXVPRQSBDccj?=
 =?us-ascii?Q?k0ng02dA6t2z3UETW1NnblvCXoxDTo7HyDMlSFOlMZ40V6+MfVBqA7gZMKUb?=
 =?us-ascii?Q?J1Dv8WuWfqqNrdyk+us4qZ1iz3TgMbHuwqC9dR7HxLLbl9nFwC0+aivscFRp?=
 =?us-ascii?Q?X3j4NVhcPEl9SyL9HpbP7rhRbNjaWwyGjkyKSW5TQjPW6xzla+swAK9+Ry5f?=
 =?us-ascii?Q?1ch8kCGOMtoEc4onsF/bhh7XcogjA0Vkgc9q+nB0uUUy7O5UTbGWv8xoiMvc?=
 =?us-ascii?Q?/Fgcn5jLkr3MEDlTWCtyiOcAHUt7xMvW9qSuRzqX066BXk+eeb4zZNMZhjEw?=
 =?us-ascii?Q?aoNU/JlpJR8dPWi0bspylHPKIjGDeGQLiIl/zmKT9v3TNm3afmFI1jfMsu4v?=
 =?us-ascii?Q?jtFTZIMqKiYEETAf3H/jwV6YFfT0qzqldFhsUOkJzVujIw4mYFy9H2ZUBjDn?=
 =?us-ascii?Q?lX8gVE0TU85sHhqP/QYeCRfFGuJDNlp2swdkcl6AThODI6xWrlKlA8187Gev?=
 =?us-ascii?Q?hEiEVteoFw6hXdrcnHTFvdomBY+/cdTmay6bh9xbioYxnxyZ/eZibyHaqldA?=
 =?us-ascii?Q?78MRsWP1IPy/+GX+3PmbJinTqFhkIy+gBY+DwgzCMffyEB+7KEgL8w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+GqbckVRvJRx3yAgMDMwq+bEKGh1O8qr3sSL1R6IDdA3TD5aRaZOZ1FA6Ev?=
 =?us-ascii?Q?8aP/Cs2iq8HHrmPGoSK/iaO64e8/f+yhJmYZwccXfXA9e+s1NPtIbX6SrXQ9?=
 =?us-ascii?Q?sPRW3uVvY1143JFT2MUKIclZH7r8gFlb6t4XGuWKT0XwMFruj0LHKnKcgPNN?=
 =?us-ascii?Q?+Y9uuw/TCQgHdmVROg41dBZHMf+Dt2wmV8Hz3RaROcntPNW0wcxI5USeVgZV?=
 =?us-ascii?Q?Aw+vbGHMMWPd8dOTyMLPoc7T2BoVOQqcjilHL3/hOjoCysmwZQeCE6rqUfnO?=
 =?us-ascii?Q?FY+vpGKi9bpdD+UvON78HRsZy6p0w8njFd6kXJNGLrmyeYworqG3hzGEPL2U?=
 =?us-ascii?Q?bevLA1DM1g8taHbk0qK7VToOoiZTT9c2pTfY+gBkqVQs/aKlRxTaZnADRZzu?=
 =?us-ascii?Q?uNQb9rEssuYk1ckB+6ghLCrmhTQxHwAr9GI84jfc0s7USrv+cK/SFh/z5tJD?=
 =?us-ascii?Q?yK5mbsp+8RcO24FJ8mSKaeAkl+6vZQJY8rmJjpR1abrwkPpFR7yM5d7AqQSb?=
 =?us-ascii?Q?sWgisni0bQrC38w0zuExnvWfPFntr5O2NFpfOEa8ACWcC78lFIpJfXL4IIMq?=
 =?us-ascii?Q?sQV/wDjDLV1o3jJXfUatRKY++cIkbTNunVaJuOmyWSfV+4LJY1qr5ztDNxHf?=
 =?us-ascii?Q?WiGXrucTCguV1ukoLDNK7lFVcjJKmb/3f5EFoMyzjdRHXJeDxdSL3N4AksGx?=
 =?us-ascii?Q?BXhOieXyuKVClQDA/JDZzyTd3UaqM342pWcu0De/jID1n02MTheSZ4xVx8KR?=
 =?us-ascii?Q?f3gwXUPMvJ1fMs+Cf1Dp1XC8rMdpMSS+JbDNpR/PdWXysyF1I4+aSNjIovm6?=
 =?us-ascii?Q?C7DbaVlQgdBYN53CAdBSKRYEzd1cSguB27utr/+t5hyETT6BW3G8KbPN7QUo?=
 =?us-ascii?Q?s3m8oyKbO1EvURWLiFFO5wxc7QUjmdHMHwcNCjc371d/P5sp6k/pX8Mu9xwp?=
 =?us-ascii?Q?Z+mSq+zcJ0vn3c0uvK4uXKbpvXc3psxqON2D5920EiSExNgzh++vhXsaGfVr?=
 =?us-ascii?Q?+3NuOMs96+xT1iMy0f3ETJ7tczLYTbyLwRXCCB54fS4hWzcfcBW5GI/qBvwz?=
 =?us-ascii?Q?oKgmjwzg4p7K/AqF8Th8JRj7cImby29YjaL7553D+km4XmxSG9YNtinX7QdL?=
 =?us-ascii?Q?o2H2nkncyoS6Y/DEf6t0l9mowQsArcQAgelY2058aDJUh2OFuB4RVu2lZswr?=
 =?us-ascii?Q?mrpSpeBccTExXKYvY7n+8uX3viyB5UrITew66PXMAHIS1OmVOZtLk1g52PVS?=
 =?us-ascii?Q?PlVmKPnnCNggg5zem5k+OaFuzWTvvOQXEofZAuzThS2Xx5kmQRvMBMgl/AoH?=
 =?us-ascii?Q?bE5XqBJ1Dgfam43F+DROvDvBw29zfyKtWFiIMeVpNePMfnYGBLJh9JqhrrrM?=
 =?us-ascii?Q?jceSMsZvOMfKRGDPBqlv9WayXbdCyKO07PlfoCd4mBZRKG4BxohlWAqhKn56?=
 =?us-ascii?Q?bJpmkFFCQ8jv2xJAuCK9vciqM3F42ZE0Bq3N/AuBwVim3FzdTvOKg/2MxLRM?=
 =?us-ascii?Q?LEbdjAT0HcVMuyFXH1kPrh1lXJ5Dj1ahLo+m5ODa4Yf2sp99FBdUQRiBc/oW?=
 =?us-ascii?Q?k9A16DGAkzbbe7UwURWln/2eH2RoSjcuZDAtY3DL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b42590-fd0e-4403-15a9-08ddeaeae445
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 13:07:53.1781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpgUdi/zslHECg3HjtSMsYDA+lWOPZEfD1DZIxEoL98n+uf8U4lip6A7xVn6ZDwxwItMwAtMTbBBz86r1w9Agg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10420

Introduce the first user of the "10g-qxgmii" phy-mode, since its
introduction from commit 5dfabcdd76b1 ("dt-bindings: net:
ethernet-controller: add 10g-qxgmii mode").

The arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso already
exists upstream, but has phy-mode = "usxgmii", which comes from the fact
that the AQR412(C) PHY does not distinguish between the two modes.
Yet, the distinction is crucial for the upcoming SerDes driver for the
LS1028A platform.

The series is comprised of:
- preliminary patches to the Lynx PCS and Felix DSA driver which accept
  the phy-mode and treat it like "usxgmii"
- an ad-hoc whitelisting mechanism in the Aquantia PHY driver based on
  firmware version, which was agreed upon with Marvell, and which serves
  as "detection"
- in-band auto-negotiation capability reporting and configuration. This
  makes sure this feature is enabled in the PHY, because the Lynx PCS
  only works with USXGMII/10G-QXGMII in-band autoneg enabled.

Notably, it lacks a device tree update, which will come later, but
should not be strictly necessary. The expectation is for the Aquantia
PHY driver to pick up "10g-qxgmii" with existing device trees as well,
which it does, except for the slightly confusing "configuring for
inband/usxgmii link mode" initial message. This changes to "configuring
for inband/10g-qxgmii link mode" once phylink gets a chance to pick up
the phydev->interface in its pl->link_config.interface.

$ ip link set swp3 up
mscc_felix 0000:00:00.5 swp3: configuring for inband/usxgmii link mode
mscc_felix 0000:00:00.5 swp3: phylink_mac_config: mode=inband/usxgmii/none adv=0000000,00000000,00008000,0002606c pause=04
mscc_felix 0000:00:00.5 swp3: phylink_phy_change: phy interface 10g-qxgmii link 0
mscc_felix 0000:00:00.5 swp3: phylink_phy_change: phy interface 10g-qxgmii link 1
mscc_felix 0000:00:00.5 swp3: phylink_mac_config: mode=inband/10g-qxgmii/none adv=0000000,00000000,00008000,0002606c pause=00
mscc_felix 0000:00:00.5 swp3: Link is Up - 2.5Gbps/Full - flow control off

$ ip link set swp3 down
mscc_felix 0000:00:00.5 swp3: phylink_phy_change: phy interface 10g-qxgmii link 0
mscc_felix 0000:00:00.5 swp3: Link is Down

$ ip link set swp3 up
mscc_felix 0000:00:00.5 swp3: configuring for inband/10g-qxgmii link mode
mscc_felix 0000:00:00.5 swp3: phylink_mac_config: mode=inband/10g-qxgmii/none adv=0000000,00000000,00008000,0002606c pause=04
mscc_felix 0000:00:00.5 swp3: phylink_phy_change: phy interface 10g-qxgmii link 0
mscc_felix 0000:00:00.5 swp3: phylink_phy_change: phy interface 10g-qxgmii link 1
mscc_felix 0000:00:00.5 swp3: Link is Up - 2.5Gbps/Full - flow control off

Vladimir Oltean (6):
  net: pcs: lynx: support phy-mode = "10g-qxgmii"
  net: dsa: felix: support phy-mode = "10g-qxgmii"
  net: phy: aquantia: print global syscfg registers
  net: phy: aquantia: report and configure in-band autoneg capabilities
  net: phy: aquantia: create and store a 64-bit firmware image
    fingerprint
  net: phy: aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841
    (AQR412C)

 drivers/net/dsa/ocelot/felix.c           |   4 +
 drivers/net/dsa/ocelot/felix.h           |   3 +-
 drivers/net/dsa/ocelot/felix_vsc9959.c   |   3 +-
 drivers/net/pcs/pcs-lynx.c               |  11 +-
 drivers/net/phy/aquantia/aquantia.h      |  25 ++++
 drivers/net/phy/aquantia/aquantia_main.c | 175 ++++++++++++++++++++---
 6 files changed, 200 insertions(+), 21 deletions(-)

-- 
2.34.1


