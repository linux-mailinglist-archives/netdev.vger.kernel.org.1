Return-Path: <netdev+bounces-195075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AA6ACDC96
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1426E1896088
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD328E5F9;
	Wed,  4 Jun 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dOUSbhLf"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544D1E2848;
	Wed,  4 Jun 2025 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749036783; cv=fail; b=nXitjbfkyYwErivzGfy7uUEd8SliozqG34tjN9tMudDVfEXah4mgjP8wPb5IYJ+tg+b7IeJz0ARpR8FXVtvRDK8THAFwpPdT9rpzv8TiIRBLl00Z3TiJ4ogtuQWEcpO556u7FDnDOYj+oC5cYsiJmbdjYNa7TY56wZt+TydcyY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749036783; c=relaxed/simple;
	bh=EUgTjBA8mgSmMI7TRIn0vJOMo/SxMAmSEgWBgZUKQas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hXc8trOCCHQ+0l8pytm32sroGIGUi6l9z2SRpIzCokh1gHDAmHTNHeYEDg5FcGiuiEHubjjXy/Qr6Kz6yhkxzJu2SAEu9lDSqQ6C/XBa+BAZBKHWCsJ1l4sZZpx3ixw9mJJylgi2gdgs+gAhd32o38JEiYix0vczbMTs9sM78O0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dOUSbhLf; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgTj5w7ngrbLP+BuQ/YhMEFBKr/DdkHIK0uLVEhCr6wt/IC3vI6n9n1HhCUYg6TA+JfmB0xcChXNnt26hRx5hqEkfCeSk8uL2P9iL1kZrsMtLO9MS5smuPbdG5Yf06hpwZc/BC+mi0XoLspzCadinW9kOEH28SgdsZ1JpzuB5A3+Fbm5Dwm7FKlFutnq3Fg6vOZttqzLX8k/L5/3n4OYrlFrPX+WpCoJ5tP9/RIFoNiZjFSsYrw6a9vBwRQGz5c6iOlTSgqKHLXbK7/4A4kGHb2R2bTrDb3MxOvl/43JD1UF1TSYs3Uf/Fqc6fm9c+fa5y3BsLW8sBEHfDm0q1QnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUgTjBA8mgSmMI7TRIn0vJOMo/SxMAmSEgWBgZUKQas=;
 b=tLgNj5LMp50b+w7hIFVrHCajm9BnYZYIlmalEyDqCLY+bp/hbMheZeS3EFyu8G2TZYkozdF++tTajzgTsaWQZHXw3hRnTgJNmbgqSrpkihZCblkthOsyr42rb1DkL3LWrILfjT1bcxcObicq9JBRIkgVE26+UE+oGYAbPm0y0vJ9/Fjx9GZau1dxWnWiPquJWEYzVuixsPN3vLicrsVF3zyoRpbjeNFXbRStP+48dUOHR+jqS4aESc7QNWaDAyEaSMw46r4x3gGV70bQRng13uvNxU51IwzPkj9hxOD0IizNk2Yfl3o599cEOaoBwtgCXjXNbDMCm1M4ysmIgK2/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUgTjBA8mgSmMI7TRIn0vJOMo/SxMAmSEgWBgZUKQas=;
 b=dOUSbhLfRz85lyX47XDXDD0riRh13bjC19MhnyXZaw4CW1vpykj5qiGDXmCE35on6ZlccaH+5fWp7sU/kM4q/GwacQAx8Pq1xXvcYpNu5UDPv6KBNTCL4HuibDmKAMLtJ96FqnBPSl3QpbEuApGG47AfAB0/pA0atWEIaFwhVa/BF/fgk8WJx/ylXg9miNLUUEx4Lu7Ds6yQmwkWFuEoc8aygT62g7i5SXgoaKnz29rpoFb011HeF36WOMnfCPTfdEY1yt+MwaxZEQEDu8KPQyHQfA0WlZ6CsDEDh6KSdL9Aze69Xj+3W8xpPCdmhN5enSfgx5glcDpo1XPtZaWjPA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 4 Jun
 2025 11:32:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 11:32:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Netdev
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Thread-Topic: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Thread-Index:
 AQHb1Hg4llIxzk9mvU6olT1BgH8nCbPx58+AgABhlvCAAFEMAIAAHdiAgAAFhwCAACHfsA==
Date: Wed, 4 Jun 2025 11:32:57 +0000
Message-ID:
 <PAXPR04MB8510DDEC9525F0D6DA6BA7DD886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
 <20250603204501.2lcszfoiy5svbw6s@skbuf>
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <b2068b86-dcbb-4fee-b091-4910e975a9b9@app.fastmail.com>
 <20250604091111.oo2o2xd2zeqqisaf@skbuf>
 <effd3e84-8aa7-4c06-ae36-effbf3b4f87d@app.fastmail.com>
In-Reply-To: <effd3e84-8aa7-4c06-ae36-effbf3b4f87d@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7988:EE_
x-ms-office365-filtering-correlation-id: 59a68fbd-23a1-4355-ff8e-08dda35b8db7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o3zthYKq5NBjV9sNqray2VwAXTHjEBfBY6BorA9XqR8Rzg787BD3sWECxOSE?=
 =?us-ascii?Q?pCGbV3/prn1k1qOBqpt33s3Utu4H/Bljuei59bx41I8gA4TCHatdO8j5TLSo?=
 =?us-ascii?Q?P2dPgCMIKbF/6EYdRZpgpc2XO1Q8fWxkyhYgFmUc3ABFelh+XzdobY3uo0Wn?=
 =?us-ascii?Q?3Lz+PMZpi1YfgMA00qMTKZyhnZlNSdK4SXL+IxVx0bS7i5ag63td9gY6nsIJ?=
 =?us-ascii?Q?iS+elGy2SmcYGgoGvwB3D0QHcGOIZvyJwFBEVKi6iAW5cApRkgOmPXC7nYvv?=
 =?us-ascii?Q?Kb5CyJOVCNRRj6xlRqj5vZ+8t6TTTJHQQ4xKCAVgRNhBISgwMwy8GHQKkWKw?=
 =?us-ascii?Q?0QU4WXJD7vdOiOhesNi+Yf/uRpcieuBl3izrtxTL6DRxQGwmPRch2WJxnnlO?=
 =?us-ascii?Q?vpbyjzdrycPBWCDtNa6tGXu8PheSr0WJM5hVbAPVWiFy8SGBNoRhm863I9PC?=
 =?us-ascii?Q?53f6822+0h9ucEZKgXgP3sJYapKRxeE4uH3jrW3ZaAanLNFqfqL9wSk63Rj/?=
 =?us-ascii?Q?ziPl26yFKvlfEUzDl1aOLmnu7P64YJwQrxrScaMx98QORTrG5v3wzTgcwVgq?=
 =?us-ascii?Q?0cTN9+HF4iytXTUnVB/bY1/Y6JIYbtUJqKUHQO3nW9IzuV+B9cfNXldbng4L?=
 =?us-ascii?Q?DntWUKBIeVxzz07PrqHg9I8jgHN1dtm048sqGQsbea3tG2zWsKN5ENM/SR1J?=
 =?us-ascii?Q?0I/iyBb14eKQAcqVkIP33i9/ancA2H+g6mwuVNUI3qYfe2AvcgFysfGm332y?=
 =?us-ascii?Q?p70RXx12QSTXvxWdfmMP5+G0r+Wcr7cKX8QCSisHhKk7/oheFaw8meTCVXs+?=
 =?us-ascii?Q?2QqSXg76Dsi0lgaGSP3ruOGHRhbqhErusAAIhEe3sQERCd5lqUqed6B4fP9O?=
 =?us-ascii?Q?1yLtnxYUIKT7KKrxdSmTW00lAkkKWm3aAw46ig90mUuFf4vl4gEIYurEZ3+s?=
 =?us-ascii?Q?aJMSSgi+5Kye1Q5mgFb77gDyMFhkD86mX47TlyfR46jYJBOqKV5JOMLUguQE?=
 =?us-ascii?Q?v2xaScipsxxq+S8uNftjtel0JvTdBk/C5Hoyxlth4syEeV1JY1jIR9kcphHz?=
 =?us-ascii?Q?schKvTFGMvDabJ/ZY1tOYsFMjkgdZiCQkrCos1D4Fk8mjIbALypdzMXO5Hbf?=
 =?us-ascii?Q?a5BCOBtwmivwHaoW/c+WJ+smm3h/B1PEsakL3xr9D20kH1cNDkdMi/m/LyWT?=
 =?us-ascii?Q?i3KItJHfZMRG5SWTeX76/V5LHZv1ySBKheD7Kl1sXW+AXy880wOiC8mdEDWN?=
 =?us-ascii?Q?4Gmx4GV4ULmcbjydshRVvtHf2jB22apJUopikfDQGx//kkW+AnduGdPBvi+5?=
 =?us-ascii?Q?As6JNXF9TRvneF/UJOyc3YgyjPNVk7L/uVJHG+xhbbW3PAwowuwfUBMUWWIe?=
 =?us-ascii?Q?7TkV2UMUpz2lsJ+dN29T1UU7lPsfqsBVxh+jrqpwMf6TW2fZBThi5i5rYFFj?=
 =?us-ascii?Q?vLiKXgpzt4PiwNIUz6KnUZao1rXHl7suyhM2kWouaTe/EWYd9NC0zdGfaEoh?=
 =?us-ascii?Q?3W1LLe8C9iPBG+M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HEPUS6MP4hZir6UG2zbhAyTICo3qwBvM683rLd8/9z3dbtTJ0s8dCmS8/CnH?=
 =?us-ascii?Q?g+juGWRQy9QlVmBf6enCyGZBC8ffdA9iWz+DFIyEMuE5EcYJYGAdWYP7M20v?=
 =?us-ascii?Q?MlOeqvs1Z/DWZ+gAMcnfroUhZ1tWbCDCcZVutFeDdyp1czgk89VBzZw05vu6?=
 =?us-ascii?Q?2dqtT/teBA8MLHkrAzr6gWs8nsnrLb/PTXyhAKiDGVQokiZeNJi96IjifweG?=
 =?us-ascii?Q?D795bn9GkSNkyLIKKHyoX+qMjdSfOHfGC8Uukb/YC9uJ6cGLIICCfG2jM/03?=
 =?us-ascii?Q?cZfkQTduXaErfHoB2WPfsmU2OOv2bRs/zxpGI/+dyRVMU17RmQPsGQebEl/a?=
 =?us-ascii?Q?s1usJ13dq2QK2N0ZW41X+hJCqeN3WCvnC3VmVAE2Qrx8HKEwpij3oh4kzgA2?=
 =?us-ascii?Q?bBs1FlWjEF0esB1rJZupCBBq4yOgtCRbC8IW6QljgGE3y6tE7VrcMt7N/DGa?=
 =?us-ascii?Q?eP2t7ne1HpaX+k6AJtusL6FwApPrc6ifX4EmMOqVF3h9DYiNNbV+KkW4cmE2?=
 =?us-ascii?Q?m/AJrsVttAIy8v7jLe14O/8GTOlC06mYAvUH5KQzEDdWnLeC9xvvg7rrNFfC?=
 =?us-ascii?Q?QawK7pTLtjclFp933E6sDBflq/Zwm1st9LBUrIuUrqxm+HgYqLSQQTJkxElR?=
 =?us-ascii?Q?8MNSODkWZb0U70CoKUPYRDQw9DjmPnYRkyJh/IuibpI8VHmBQv8xXl95hjWL?=
 =?us-ascii?Q?7yFcGz1luO3k2Oo1M7daWuVHxrQLDYb96H3IDbv9q6AGfRtGYcNBmM+xjq4z?=
 =?us-ascii?Q?BypKXj07TxxOk8LOSQSJp1Mts2mbX6o9dR0FDnZQ6sW6We6KaDh6n8iz1clg?=
 =?us-ascii?Q?YPRyxQSTzuqtizyJ+ciCUVbuH995mA4N3pal2MTmkatfIWv6t+KoOIFFoOgm?=
 =?us-ascii?Q?4XRFWGNvPhKV4zXeUFCV6dCAihiAoxbW1+yEEKKuy/LsR2Yq5+T4bhXmEs7U?=
 =?us-ascii?Q?8y3Zck2WF/MAGpgdVwBy4z20Htov/peoECGjHiW+lY5Pa5p3ny2i21MdkiHl?=
 =?us-ascii?Q?YwP3v9QbC2/lTbTgoUzJa8tItzfI9Ii4rKXBfN+B2gilytSBPfPbplg89LKc?=
 =?us-ascii?Q?oWSF0PHt75ORzU3E2fioFmjS9C7JJcmmaItgfYnD9GK6JtojKt67S2psY0b3?=
 =?us-ascii?Q?hkUWw39vRy4cvLbBVSd+wSCLrD8OTJQbEcMAWG3lK5plmfP3JTq/xdODkSZQ?=
 =?us-ascii?Q?JAp83b/a/ZNtxZDAoN9LA0FbKUDL40owEzISC8fzFOvE4wj38BXrZgJYeXP1?=
 =?us-ascii?Q?YQcEFya3gdHalCMtaNkHHE7YwbIhfd5vpDDlYBWtGs5gZ0XClxgQ0DJfhEOd?=
 =?us-ascii?Q?5w+AjHHjLjiR6uKB966DmwoV4PUlpJhIZ6hmW/it2uRQPHtxNKfxBoNAcryZ?=
 =?us-ascii?Q?3J/0im0/4W5ugkAd6CCyHoJFxeS3bb88pIudjhygl9Yig8ZomHvkcRdKyApv?=
 =?us-ascii?Q?y+Wx51XhbvNS07zS27Sw3q9KUQt8lwi5D4WtQA7jdc7l0F+9ITvYKhOCeEZq?=
 =?us-ascii?Q?G8CvDsjddO9zCm5Msgt3O7JdAUnYw8ZRSSthxKlcEZK4gu7GsaEkq6uNRG27?=
 =?us-ascii?Q?GA/SbTX4ORlrZqwZ76I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a68fbd-23a1-4355-ff8e-08dda35b8db7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 11:32:57.1097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/1UzBQ+vjPZHTn6CvQ61wamPoapX1BS9iVuQCE9d/fguJdeOBpFZdhx6NNflG1ZAmeAGUUxwzW5qmZS8VoHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

> > Thanks, this seems to be the best proposal thus far. IMO it is also
> > easy to maintain and it also fully satisfies the imposed requirements.
> > I checked that when FSL_ENETC_CORE goes to m, NXP_NETC_LIB also goes
> > to m, and when it remains y, the latter also remains y. Note,
> > FSL_ENETC_CORE only goes to m when all its selecters are m. More
> > importantly, when NXP_ENETC4=3Dn, NXP_NETC_LIB is also n. The drivers
> > seem to build in all cases.
> >
> > Will you send a patch with this proposal, or should Wei do it with a
> > Suggested-by?
>=20
> I'd prefer Wei to send it as a tested patch with my Suggested-by.
> I've also tested this version overnight on my randconfig build system.
>=20

Thanks, I will improve the solution.


