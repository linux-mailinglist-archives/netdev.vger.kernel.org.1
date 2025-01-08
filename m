Return-Path: <netdev+bounces-156112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D335A04FE3
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A94188319C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D0013CF9C;
	Wed,  8 Jan 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V4fL2YUx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24378634F
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 01:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300972; cv=fail; b=REeyCxPnjSDkOx3E3oir2N6eE7d1IUuwCj33gZG/pYLi/v+Y5lqix9fZuHWcMzfM/SqE8638mYun8w5eJjyA5v4WcdMI7AkTohx5WCXWEpIQGA12tgjxCAixMkhIP9D975i74J6R7TTYZJztYZB2b1aLONTnZEr3WFNWZne7s+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300972; c=relaxed/simple;
	bh=jK06THocjm8Y2nu3nIU69gt3KiuVoZZT9ojdZeWabTo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VnapL9Wgti0d41Sqdg9vSWCWDBavTiMxPAB3DGdAvU+Wot9BzF6cpNjF5nQwX1A7TVZVPeoJvZOPlnY0joiLBuIiGGISwc8n6NXNtYTru2mO937OkAMamrS2YaUOMiF3BW85sESeLjyKtMNsLLCCUcy2sGwxy+uubLWpFVNxr0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V4fL2YUx; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2EXqq+rPi2pJlrmEZnSwpcSzuYQSVmoAp5h4nf8752eOJEoktLflEIne8NZlHzDOpvvtQuiKfNsG/ivf6bYdY2O5c0S+DIhnCWlvxMglNGq/4/D86WSCC3H46rEyWkhOsWCFJPD1hur27m8Pn/3+PU6oTUohbMin96Elx8NKnM+EgKNHXzceMNPPLn6+DuMJNPJu9PKo76iroRX5X9NPR2u0Xc3NvkGO8IFRWHma+X13zr4ap7bNsILVXO5BE+ieqhmWrS92pI2Ns+WmG6uCE/Pk2Qq4xQdlq6TF1PhARoicEHS2TO7qWmhii45xpIJLJThypwUolX100YDkZ1nhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK06THocjm8Y2nu3nIU69gt3KiuVoZZT9ojdZeWabTo=;
 b=DwujpRA6YLm1qZODBgGT/iBpuqW5er631hI7T4XH+OQ2KSmPuDZqmqzbywYmkKa9HPflpB8JstaBRsfhq8GFqfSRqp9+0X76ROjbVfsg82U0QbDcpmS0eZq/vTeI2xa9KW5Ye7RnkDEhKFUVah6+usV6ozbIr8gpa4h05AiWDcoue97NnPJqC7C5hkVn2D+5cDfOgQQI3XCGyQ321Y5RIl+5Vch1RRbTEO+S1gdV+5Xh0HzbQZb6POvvA4jJeRhX9jDas7Ma8P9rRJmk8fpD6lY/cUtihzN+nuUlG6sgwmlyXoQ4nKrWGDOFR5O0JCRURYDUdDiTsNlHNTf4bzsNmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK06THocjm8Y2nu3nIU69gt3KiuVoZZT9ojdZeWabTo=;
 b=V4fL2YUxkCMJjCo+fYmErUd0woc5Ox0kDAs6RmVs2ZB9++syA2TmU9x9cO0nHX1qmSemLTlx6+9AuHUjH0Cl2qgdljLclg9v72fBhqYlZQB+hXzszpTJmxYQJZqR3ZmG4BYQjO4o9qE3C69ovuqzhMki4y7eKFHsDI0cmUJDbhsIL1+lxN3IJit9lW9+hwNZtKrH6+pUF/PteWg1bZTJIs+g3hrMeMWB55fbhENm21PAbaaLxOsDChlqGAUUjyrUZQaLAV9mKeaflqUe9PwbPt7gxTMCrLO6QidcC7beqMTJRs7Bv3z/QjhXhLcDIYOMQnpwABDE+PcSKeqaCajWXw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB9929.eurprd04.prod.outlook.com (2603:10a6:800:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 01:49:26 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 01:49:26 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Russell King - ARM Linux
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: EEE unsupported on enetc
Thread-Topic: EEE unsupported on enetc
Thread-Index: AQHbYEAEPp0VVipOt0OTBhisL57pd7MKgsxwgAARFbCAALLmAIAA0+cA
Date: Wed, 8 Jan 2025 01:49:26 +0000
Message-ID:
 <PAXPR04MB85106EB2145E199F8393BE6388122@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510028FA548562F1A7B7A1688112@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <99eb663b-02c5-4ddb-b1d4-743baf2cc06d@lunn.ch>
In-Reply-To: <99eb663b-02c5-4ddb-b1d4-743baf2cc06d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB9929:EE_
x-ms-office365-filtering-correlation-id: 7607399c-3243-4eba-c7d4-08dd2f86af17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?08aAB80vkFRf35CWPf4LmLiTecZhW1lKCngXi8YNS77KevlzkMjQaGidypx9?=
 =?us-ascii?Q?uPmQyoOCFofh3x1rGSMoXkZQqcfYbxIh1rsGAT2a9V1mK69EJ67H/il2YVhy?=
 =?us-ascii?Q?TuiPZ9RlXmXs+ePyUSIrFreWj1g+rvtQSA/NK92SkFRK7Awe48MnnCByXkZQ?=
 =?us-ascii?Q?m00MMIXQpEcWZ+pWuKoFrmh5KpqfZnzBS+Jnmg4lUMpgUzBwIDtrJcE7V68q?=
 =?us-ascii?Q?BEBJXd9ks/OoCtaFKu1fWYDgnW41PeLK4ZAm6nSTlH4G6TMOETr88BRlSWnj?=
 =?us-ascii?Q?kTpN+asm7IlPazJHCCc8JuPcJ1ldVf+MbbdRDyqgnk3CIAGQTKDtlQvr8IRC?=
 =?us-ascii?Q?1Of8Y9rutKD0IsF7+t96RWnqNp2CtOwz0wePgwt6ncmq72DQS0+xTytz4g3v?=
 =?us-ascii?Q?GRsTYWGRbUBrzVomgvPtbppAYL5OHGGg85EYDc1RmhdgoDhZiF2iFAhLJ+8A?=
 =?us-ascii?Q?8wD2OtRqz+vQfGptHLs7HlAeEpkYuYaa3hXM4/y6gFjCgZWsR5WcIr2SFUxG?=
 =?us-ascii?Q?fb0I8QCl7Y9ufuKGdU2WGIh211snCJR+prgkZl87QPuuapmT3eF4ODnV0LVE?=
 =?us-ascii?Q?lRbdda/7WQuIss4XhwYhyY1rem9gN3neO5vJi4/yN8meMMMkdZx7gSXe3DOl?=
 =?us-ascii?Q?L08Cj4onA6iPLIYQXReJ9I7UDFSn0JNatEiN7Emjc3S5Is4jvxTmQgVipRd5?=
 =?us-ascii?Q?dqdAGnn4/jVRwcuEb6vpyVgOJ2kN6OZCQ+Yga47tzutXlXGOtfbQ7vL9wysu?=
 =?us-ascii?Q?bZy4U5/wJmX8WU58Z/B51Og2N0+mb22NhVaIPN1HrWMs6LmdnZlX5vImtZh1?=
 =?us-ascii?Q?jXxNsGr7Np57zgIXmGfXY3sdS14XRBGkiZpChc5wx+UKEIdFVgJO4CAZ0rkp?=
 =?us-ascii?Q?pcnuirA6TY1271Rc3lO7TkCmRvHYRVMGLEsyoI4/PUSAb1jQxqG4cWEeZUrO?=
 =?us-ascii?Q?sHINi/nNOXoyaX1YaWu8nRc1LisUhvJkL2Xt9xv+1jLpU5RF0PuC2S5AFawb?=
 =?us-ascii?Q?mmAbsW6qCgzpqWUrzZ7YqRJZwPs/jXHC5DrKBHWWlaCIZSziyl5BFx8XNKae?=
 =?us-ascii?Q?xMorTOdUGhGjPghJqL9Yuck0PgsLYYWGeVltm8hBm1U7Qij0pGydOwd1jgF1?=
 =?us-ascii?Q?22sCrPxMEAMPlabSDMOm4iaAJ01s8p0IRpBBOuLpdNsYsqAwI8fME9otYhXf?=
 =?us-ascii?Q?XiX6N7a4vGEIV5vAjTlC8Ottp/rzyiwVM/8X64plW+ZWWzke82msfb0UHCdt?=
 =?us-ascii?Q?aafNQItKomwaQVnKiITHv/bpOI1Av+nRODvN2LH/+PU5SJ8HxXKpyxVozZDS?=
 =?us-ascii?Q?NiE3usGb1Kwq7ksdFhqRPRv0NEuvpKfflarptu5D9GyAL2ZuAetN2o6ux2i5?=
 =?us-ascii?Q?mewTbiLkqw1DsUgHazptRKycCbRQdYBnv0Z72cc3wyvemdeAjNFkiXBS5l+/?=
 =?us-ascii?Q?4c4HS4TeAdbrsbDMLBa7dTgLqzC/aD+o?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LOBjCyTqWirnKtZrlyaL+CIRPSLdBxPaTNpu+nAglXnJfVOPPGiruzt5ipLe?=
 =?us-ascii?Q?iwZkPJNLEiPc0ZxakU0C2oYnDBlCZShdUbTlsQkbRPKI17oc6r21i5XBz3NU?=
 =?us-ascii?Q?4+7Eo/CQ9Rh3MYaezWdmYoHsdjwd6eiV3WT/vok0GtcjMVdGiHmVry/2zfFB?=
 =?us-ascii?Q?JFG57rf94XF+p7gBNuqmtPLzjWfTwBtrea4tKLP6cV4Gmz8bwCZstWmv6aLU?=
 =?us-ascii?Q?vRZzPMWsyt3esvWIcq+s1mN7wBr+7gexjoeWwXOx0Qn2lsRwURN6EnTnznke?=
 =?us-ascii?Q?+k1mSE7V/LiHYM+nhJL3q/86KjgaBZdVe/UIngo4X7gGU59YpQmh6BbSYz8H?=
 =?us-ascii?Q?wV2JD5Jt5g7oEvO/GT4E485IHjigb6egjrgVoMwXn+iz+b7tBC9uiUfKkn6e?=
 =?us-ascii?Q?BNd1iOHA4KSzzeOBHcUQQuX//8aSQRMDqA7hsTvDckZx0KWI4Tisn4WEEmCK?=
 =?us-ascii?Q?VR6SG8hHmYjJvEElN6a6aRKRKQeoRmhbSQiEQxvlJBlPyRRprr+Tl8gYvJ9I?=
 =?us-ascii?Q?+xWB2yMOBgOJaTyquo/kwHSuG5W6N/zL3XqvY2ADcH7LQ3EtXzP3J129jctv?=
 =?us-ascii?Q?njBfwRst/DGb5qJTa7pKqT9qrN4K0jJL5BWVNdnh5rhQkCgaqpIF8SvTm9SU?=
 =?us-ascii?Q?xmqu2Xt0qpF86gtgneRM26YjgPIRdWuyuobKjkHm5UfGDbeRydOdZ9ag6MNI?=
 =?us-ascii?Q?6l3yzWty2fdxEL7VNUoebzgaD7Jr52q0i4ISOkfj0XQWRtOnanawFathvqs9?=
 =?us-ascii?Q?rl7aguFQDh0KLyg72Z52ZCAYjKyZglT8h5/UEGGJjSGN1Bu1rCtf5kmgVj+Y?=
 =?us-ascii?Q?88swEP3Ntx9tPjYy8/+1bbmQT2iIDYFKqyBQr4reBz1cfLK2PUYZwKPlNRY9?=
 =?us-ascii?Q?5RJMymDtlJ+RU92QpToMUGjqfDmeg8muEq/ek2XuNhGDuEmrXXb5do9iAF5j?=
 =?us-ascii?Q?bBOqexHE0Ny6Bg6s7syiUwFM6rOkWc4d4tSpNfKlf6Cqs08xrMJKfc3rH4vQ?=
 =?us-ascii?Q?+vt2qnJ/ta2qhx0PGRAxOjALhRlI9NONAkM0fd20JkurerHLOTYds3Z/XD5y?=
 =?us-ascii?Q?MCWvrABgpQT+l2VNjp+SV0BkEsceUDBNRrhwRSHTqJ/xU/wNW9hErmJ7AK18?=
 =?us-ascii?Q?ZqUt7rcC5W2088JELo5ioylzmxe24LtK3WWuGLDBxULzktcuCRiWvTNILrxB?=
 =?us-ascii?Q?AaukGLrJ88zypPd2jzxP0/jtAUenz9bZdgDMrx98C6/4ODstzhb6OiUti9gg?=
 =?us-ascii?Q?UbyCXXeFVKqv89L7GLoONGe9dmIbO9Z5NxHz/8oIDRZAiXEoeWSMzVN7x4q/?=
 =?us-ascii?Q?fNmiaDHAjn4H52hkP7059jd0hKxNFr1qTOC/KXf25DV1I31TdotkMUByKUOf?=
 =?us-ascii?Q?ivLUyyJWF0MLP5hhV92whQM7rPS9PgU6W+fEdJhV/vjsLlQEbDVc1gQn74gg?=
 =?us-ascii?Q?TEkkUqfH5MVAOs7SfuaG6LFl+pUhW+PPd6I32e9ieoGHcv6T2MIRBdH4wWIm?=
 =?us-ascii?Q?BkXAE2NKYUeFdjtR24Ni/J4o+VQx5vefkSAZNNOELet9Yq3/aFnP27o3JSPt?=
 =?us-ascii?Q?tv1BDdnoyQ1lARUlezU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7607399c-3243-4eba-c7d4-08dd2f86af17
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 01:49:26.5556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDQXNP5Hqu57gMMWSsfmJIANJ0zPIiW+PNNBllZY8OkGUbGGl5EwPUjJDOz9tNyt+rG+f4xKZ6j5yFvAxTggUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9929



Best Regards,
Wei Fang
> On Tue, Jan 07, 2025 at 02:19:53AM +0000, Wei Fang wrote:
> > > > In enetc_phylink_connect() we have the following:
> > > >
> > > > /* disable EEE autoneg, until ENETC driver supports it */
> > > > memset(&edata, 0, sizeof(struct ethtool_keee));
> > > > phylink_ethtool_set_eee(priv->phylink, &edata);
> > > >
> > > > Is it a hw constraint (if yes, on all IP versions?) that EEE isn't
> > > > supported, or is just some driver code for lpi timer handling missi=
ng?
> > > > Any plans to fix EEE in this driver?
> > >
> > > Hi Heiner,
> > >
> > > Currently, there are two platforms use the enetc driver, one is
> > > LS1028A, whose ENETC version is v1.0, and the other is i.MX95, whose
> > > version is v4.1. As far as I know, the ENETC hardware of both
> > > platforms supports EEE, but the implementation is different. As the
> > > maintainer of i.MX platform, I definitely sure Clark will add the
> > > EEE support for i.MX95 in the future. But for LS1028A, it is not
> > > clear to me whether Vladimir has plans to support EEE.
> >
> > By the way, I am confirming with NETC architect internally whether
> > LS1028A ENETC supports dynamic LPI mode like i.MX95 (RM does not
> > indicate this, but the relevant registers exist). If it does, we can
> > add EEE support to LS1028A and i.MX95 together.
>=20
> Do you know what the reset defaults are? Can you confirm it is disabled i=
n the
> MAC by default. We have the issue that we suspect some MACs have EEE
> support enabled by default using some default LPI timer value. If we disa=
ble
> EEE advertisement in the PHY by default for MACs which don't say they
> support EEE, we potentially cause regressions for those which are active =
by
> default, but without any control plane.
>=20

Which platform do you use? LS1028A or i.MX95?

From the RM of LS1028A and i.MX95, the default value is 0, a value of 0 doe=
s=20
not activate low power EEE transmission. I'm on a business trip now and don=
't
have a board available to confirm it. Or I will confirm it for you later wh=
en I
return to the office. Also you can find the address of the PM0_SLEEP_TIMER
register in RM and then read the value of the register through devmem2 to
confirm it.


