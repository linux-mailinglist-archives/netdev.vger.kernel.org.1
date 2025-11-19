Return-Path: <netdev+bounces-239761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D807C6C3B4
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F23834EBE3
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7221D3CC;
	Wed, 19 Nov 2025 01:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtVVGvqj"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013070.outbound.protection.outlook.com [52.101.83.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B71AC44D;
	Wed, 19 Nov 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515344; cv=fail; b=INZta1ZsAiv8lT8qnT5qeuRbLE4dcMwzevTTiIU0x8kaSscsm2LbdQf7HOB3O1RdebHUqA5b0fs6CpwiYb1yDH9Mmp7QsVBVccHiAgfA6XoYBZ23XnUkiZx4T/zzN38in6elwTSyXal8mvTo0PRLaCAoCFwyT05RrJQj7Mfwk+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515344; c=relaxed/simple;
	bh=+ONFM0UJZxLN3/6JbeANzfTjhECrpcN/L2O06lZyyeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XWgFOcZGB2/YnLGRakEwXFPEe8o9J7r0+sMo3VaPo0wleGS5iX7R56Rmhg1cCMcuWZa/W3T70k0PqmzZmQxml3pQJjYOBK0k5kM/erh+PD71ZwwIbyzkvGwiZnl67JWIPC1rwz10hevjAcr5vBURqHwJXt2xlHzqjN3/Ejc3uj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QtVVGvqj; arc=fail smtp.client-ip=52.101.83.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/1asJ4W25Rzij6Ive8VZOn1uqOdvLrmy2LifaElUneqxq6HvPjidgqD9wv3VkINWTszVdC/yep/ABgXxzKT0NcfB2NX9paL2z0roy6kPH4IV7QB6l2ousvbcWbVDKTzNw2CS5gHDrrSTIRype5mwmlTiKajZybaznq0TozCKaFxk4tol7VdcUhEXapMB0LwPVyE8kumSOXmECqGtNT2MwNVoXwumNL/W4xRg4IMljo3DnIf0Xh7rZBwOHlQMXP7NT0G3k7mtWF1StnWmAjnbv2xh2YB9lLrPNcbftQf0bLOmmmXVc9mdRK3mUIX1PQvTqI0zE+t6ZUkmMHMAjzIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ONFM0UJZxLN3/6JbeANzfTjhECrpcN/L2O06lZyyeY=;
 b=bdNVF4VDpT7QvflEBglmy01uQR6u3Iy1VKMsr8rYEkBnpGs5Oy9dys8AkIMz7Mcrt2JgBDpHxqyodkhK3aF+sVqnDaC46kdYoVjEL/9E6pvW0J78XqT2vB0EiD+RGPQNwNnDYTYJurEPjGwgXZzBENJeTS4WIL35zr+buZszkKLipUnULSbEwALEjGxpo/4DeZ3b61gwT8pM3z5JU/RG48Wo8YPPuzStv5Y5xwKEk8LleA21SVnA+N64RehaTBMJ69mS/S64oQkBAQv4DZC4io+yXeZ9RLAr/7FjUGdbpTkIbxvh1F3LYWEU3KTYxNZ7lDs9tCIyYdL5zqgBBx+5Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ONFM0UJZxLN3/6JbeANzfTjhECrpcN/L2O06lZyyeY=;
 b=QtVVGvqjTbIEkoWLE44ZknGSgy9ciaWiQjUeKRrPzuRs56GIDTlhMqVZK4xXWQ1+YoPh+BdGyoNr7dmkUUdHdIPQ6vvbRn63taolTOdTn8v2qxrNBq7GP8O5tmXlqJbeXlU+nhDymV0VoJdocqyTEyymCgnR74AmZPGlRoyRcRzuMBcNAV4UT+pjOT387O+J+H0L/ScbkR5G4On+CXrsr6Y56JZL9plc7wVAE4CxY83j9+bIhzNasrxmmlf7MjtWfDIloywIfLrOnMpvHgXU4DnfWTCiBWsV85FYe66cE1yxByG01nNjDxOjOM199AkJj8449lpbqYSHKi7NAieFyw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9269.eurprd04.prod.outlook.com (2603:10a6:102:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 01:22:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 01:22:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Topic: [PATCH v3 net] net: phylink: add missing supported link modes
 for the fixed-link
Thread-Index: AQHcV60dm5OqWbGSUU6i25P487WhzrT4GfWAgAAFJkCAAFjMAIAAAKAAgAC7kLA=
Date: Wed, 19 Nov 2025 01:22:17 +0000
Message-ID:
 <PAXPR04MB8510BA569EB34E26E1A499BB88D7A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251117102943.1862680-1-wei.fang@nxp.com>
 <aRwtEVvzuchzBHAu@shell.armlinux.org.uk>
 <PAXPR04MB8510A92D5185F67DDC8CC32F88D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <e7222c87-3e4c-4170-993b-dbf5ba26c462@lunn.ch>
 <aRx8Zh-7MWeY0iJd@shell.armlinux.org.uk>
In-Reply-To: <aRx8Zh-7MWeY0iJd@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9269:EE_
x-ms-office365-filtering-correlation-id: a2a345ca-2765-4e28-0e35-08de270a1479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Bm8Y3nfbFqYO7CMAR1yb5bPyWamFe1f01xzmPV/OudecW0SpCTQ0OPD09Li6?=
 =?us-ascii?Q?RoRfLg4acDTKQbm+BWULhopkIJ/h5WY4dF+t0wKKg1IpaLsQzPcXrN3mTfWT?=
 =?us-ascii?Q?5LH3JGK8lGo/IRpf19QYMuvcJckIH2GN7en8qHFgeGnWwTlYzlcB4Meh2N9i?=
 =?us-ascii?Q?OivFIfYD9dJdjDNwxp6gxAaRb93oOBQldzU865mUHCUACpV/Nwbqta8KZliP?=
 =?us-ascii?Q?mu/cThkmpIrALAWWEVzhzG+NqxHptsvYh6G2gMrw4YPEl3bdVxvrfQaosdOa?=
 =?us-ascii?Q?A5LIBMmh/dEgesJnwAnRkizbQkA2squz6Si6UVeqAvc8r51oT2TdqR8u3Pvu?=
 =?us-ascii?Q?FsF71hqK0w4rroRY6Z8BM8/cPKHCJtyrCDMXY+rSF6wiNV10cy11P+D1exPi?=
 =?us-ascii?Q?cWSGQ2DVMDeNxnT0OABiwiFFaZeKvWnAaP/V2R44snCxAwpIJWPTmr4gdcX4?=
 =?us-ascii?Q?T+YX7W0ftGe/PmTp3Qmx7P4BTJ+78r80CnIz1OaNCXsPbbNIE3p3oE6tKfME?=
 =?us-ascii?Q?p+4hEa/6PXzAtw4FoVqZqu0hq8MXbj7PateghryvdTn9PInSJQnq5Io75UFt?=
 =?us-ascii?Q?zwjsD1ftrvKlCWBYCWSpGdpZKf8AYP1Jt2vDy0KezTTuKajWVrW9BfFXftmt?=
 =?us-ascii?Q?084FxnvF3iKppLITNN14GIzddOS6HMUC87vGoEe117kx1I+7C95qMTxLZNkx?=
 =?us-ascii?Q?VEv/doeGAuW2M9339ZWGIWJWN+g8wHZIfflKro1DCuJmfFG5j5BAVCYJLRLp?=
 =?us-ascii?Q?BqI/wM5TxP8vVLjwk7aqhdwNuMBpx7ukMkIuDXHp3WJUCgw/F/HuEIuUoDqd?=
 =?us-ascii?Q?wWy0F+S/eixE5QNFBDMT5YPpbewi912kdiLrm/lvlvwsTCzbMGmTfzSAVFnR?=
 =?us-ascii?Q?pFc/zOcyrJ7Ji9ohGxIRm59AYTQqYC7tgCs71hw6q3PGYGMltxSPflxg8Mqj?=
 =?us-ascii?Q?f8ZeJnCGEnp6lNRJ2R5waSnoIUqK3RSEv1wdWZl7m/TXj9y5CrpLq8WVILc5?=
 =?us-ascii?Q?9ARR+qHMXjxs8kRIx00Fz7b9gpiIIDmtMO88uKNJAv7aS+80B29s1Q2F9ssg?=
 =?us-ascii?Q?QKPKFy2Tg5Hm57hNgQe4KCFAeqSNEvq0CzQRY1Iy6BKK1gJXd1ZFih0IoOA7?=
 =?us-ascii?Q?S/fdW/Z0P1r7VWUqgIKl9icvH6ZHSpOuasWq6sBpAwnKbUJX0Wd3EAempGkn?=
 =?us-ascii?Q?OtwwBGUBKE/TpOJ/QVjt2yicbfGII7jzZMQ/9sUhq938Vbit/YupSPGVAqqA?=
 =?us-ascii?Q?QHosRwBiwfWPV2wayLUk1jrp1hudYxtAVw7h28iXZU4sO/3a8CQ8KtkKlCy1?=
 =?us-ascii?Q?59cOhTO+GBmXj8THsvXoUtzGMMklPZrr8Hft6vaNXUdXUth2Ju0I7Bh61s8i?=
 =?us-ascii?Q?qplEt1yoIx9kUI+z4XopY3SPpBTCcManyb/FvmBgkOA2q44/T7MFE3Ek/GAC?=
 =?us-ascii?Q?aEB5B7JtYmkQ5FNzQSMSQ67iR+gbrnXuOuOaamFYdAkCiNSl/hY48Nh6TIvh?=
 =?us-ascii?Q?FXzJgU7u8CRgusxcvBH5px4kHQVxz9sSY12Z?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HrMxUccC8HWS+1Fr1+mcjNbLmdkAf+V4yzm3phyBwlqMG3A89WJtNjzpgVgj?=
 =?us-ascii?Q?rvQa7MUKh/8IPAi7r2kmoG1wH0qg3QP6jiIM2QkwI0BR6xevSpJIvKnvQ7yD?=
 =?us-ascii?Q?uMicaKMZ2tatc3XLFZUym1YZ0ENsv0Y2L5skd+Fz6tunoXNXib5phHnKxMlG?=
 =?us-ascii?Q?T2MX+6G2pbalF0+LqE85+NjBuY1APqx1GaFPImhMN/Bodis0pHdai2s+Ngf7?=
 =?us-ascii?Q?kSIcnizcrB7FwgIv9MS8wGIJQ1YkVHFcQomZhcUwrN2C0r1ZP6TQVvyoInZ+?=
 =?us-ascii?Q?NTbsionxPjsz+Bpo3Ky/CoX7W8KyVDj58y4vyD5d74rwNIkX3qKWNfiJCUQ9?=
 =?us-ascii?Q?sTTAMOqUnqF+k1jNa61Utl7Y0fkkcjrFwDoeKy5QS/58wSaaNdOTGQgJq6Du?=
 =?us-ascii?Q?4WyHy3JuGRzxnOJWjQHJ+S7T4/mBYR+fDqpkThnwDqvQka2fK0QqXcZy4AsN?=
 =?us-ascii?Q?fFrSNSZwOXY4CFtFB7ed0AQ2F7G/l3V4qfZpMCjqa9xt+RSfcYUBNB2Y+R9e?=
 =?us-ascii?Q?AeNCyU4g5fJU3+G0kowLEN8CCaG9Y3ip9QTebZDVhG1gF7kacX5wWozwFLwy?=
 =?us-ascii?Q?gaZ0HKdDGVqqEiNungY5DccEmFa1PwEAxaHJGo5NUAamJYPnxcq2/Pwuw6Q0?=
 =?us-ascii?Q?rNSN+vrnNQFuOxfycj0kd4n085eUz5DuJ6Qx7X96f3EOkxCY2+38k9TkeeLY?=
 =?us-ascii?Q?hlVmFIuMZnKtxYAjoQkqBd+JQcQAMYLa8QTJKCL8gBBMVwCEwSGaerp+5sM5?=
 =?us-ascii?Q?RQiChu3kTZIaQNndmgYbMxmWP8hs9iDRsR28de2+UOXk1PiVZg1ABpSfNkQ9?=
 =?us-ascii?Q?VhswU2s+5NIbo3I6iLOkpSBKgDI9qkpHHvBJjchO3jP+vGwtDqzGa3fWc2zv?=
 =?us-ascii?Q?qfzsv5Cv5IHnsQi2Vd/oNqJ/07gN8KEOZBLFT+Exb2DsuCI7aVOiljUwhlM/?=
 =?us-ascii?Q?qvlR2QPmKSAjMOXVKaRCPTmhbWKidsT5eivHBmqUb9icanNrVVj5AApZL5cW?=
 =?us-ascii?Q?3ugxiSvdknu1EdVeegQTCDsWLowRcTnRdcA86S/WA1ByHrlGsDruIbJ7dASb?=
 =?us-ascii?Q?DhCRdxZjRR/TFNnhQBOq1r0YUxQuD1q5GqhIJG1PUbVLcPnA+CPEEtvooSy0?=
 =?us-ascii?Q?czWtK1KugYqazRE40poD2LPDrOoezfByKlsaQyIT4X4Nk9Ooyd9JGcJcql2V?=
 =?us-ascii?Q?WTwPj5tcMw4J3aWxpZZEYJYotmSSEf660ffoEsg7o556Qpuuh5OYoGk4Nn/6?=
 =?us-ascii?Q?2E9AgXvCkxJgCwl9Q4Cg1YikFjHpk8k3Zf8KpYB+X2snw/VrVcaiNvtGl/Y3?=
 =?us-ascii?Q?vNPCK2HEGXVnLuU+xxO+YL9OVKdxA8kUrijloH8B5snfh2aGVlGYRroVB3Vq?=
 =?us-ascii?Q?hH+V31Y40Rzt2qM7UFSKhs36qlAL0UOygjo3o76e4mIzB0VGE956pKiwJP+2?=
 =?us-ascii?Q?b/CkBED0e24LkvdS5TzNEtxL+rPOnmF4Wh36MTUUNl87SiQ0qbLOwvTtUm3A?=
 =?us-ascii?Q?0g+8xJrd5956sVuoRFwv+l/imaf75Oc5Lz8tA/povi5ypuJDRM/YxYHvyuLZ?=
 =?us-ascii?Q?KbQ7MRmZ3zSacAIs/Qs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a345ca-2765-4e28-0e35-08de270a1479
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 01:22:17.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUMSIllUvBvnfRmgCqJdIb+ETG0cxZDnAH03kT0F9Y1vZWFNORdFXtKUV/Dt56cRpvDFdq841tDwcMSJ0myEAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9269

> On Tue, Nov 18, 2025 at 03:00:00PM +0100, Andrew Lunn wrote:
> > > > > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed=
-link
> > > > > configuration")
> > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > >
> > > > NAK. I give up.
> > > >
> > >
> > > Sorry, could you please tell me what the reason is?
> >
> > I think Russell is referring to the commit message, and how you only
> > quoted a little section of his explanation. There is no limit to
> > commit messages, they don't need to be short. It is actually better if
> > they are long. So you could use his whole explanation. And then you
> > don't need the link.
>=20
> Worse than that. I gave my reviewed-by, which seems to have been a waste
> of time.
>=20

I'm sorry, I was in a rush to send out the v3 patch, and I hadn't received
your Reviewed-by tag at that time, so the tag was not added. When I saw
that you gave the Review-by in v2, I realized that I could no longer add it
to v3, so I replied that I had sent v3, hoping that you could resend your
Reviewed-by tag.

If you don't mind, I will refine the commit message as Andrew suggested
and add your Revived-by tag from v2 to v4. I apologize again.


