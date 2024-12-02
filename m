Return-Path: <netdev+bounces-148257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EE09E0F46
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A43EB24C29
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872FE1DF244;
	Mon,  2 Dec 2024 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FWive7kO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADB1DFE11
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733181718; cv=fail; b=m69FOZNDddnobkzcRU3lBDsetWcqg+eQhsF9feZ7XVyjkBBeVmc1cCMGbsdf8ocGtbUrkQJpcbuzUBVdMIQmVmJkKaz4PCSPWHQ2EGRc8qdFRzJRGtLDY5i3yfRWd7Oh6K7wcI4i9qj2fbKDjWoBiHx7BMJOChJmxX5JvbnUKj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733181718; c=relaxed/simple;
	bh=Bx/omNF8o8y7HLaYN8p3YeKYir+jc3n0HBLAkO80j+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t6BAl29N1v4kyIle+db8Exq4m4bUtKDGgOZeW5r+mOlY7mHiKR0K2zZWnI23OVdNVFEvUmcIMM7Sv6sCyMBzdR2KUDx5nuRgEkFZ/8qbqE1T3uikWEIuMpXmnDxxmplFntXRv6ZzUgf5ua0sb6g8D9sLBBofcgqpNKGEm/UisT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FWive7kO; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVJnHQxSscmmopW+Gl8Q/az4oO2ivmjJTWMBI/vrHetPxAIgvkGCpcYMbockgR3N5/D6PmHrgH0f+f/+FSLUbL1asZGT/UzYZJpnRjRd0yzt3SNSMTku0MSzpmLrHSr+waFBMmKTJKnIdbLnvF+SnDQtqCchoE+W5ZPdPkTan+ORySFyWg1mkBKkOCosQRigH/OmquVY6/kYb7pcp1MA1z/52V2DGfUWct5Pn8y8mQCBB4Fb/ZPth6unOGZjA+jX+9f61lTvBIsgLaUGU629c97o7ELyc4hZ68hafdJxrfk/i6+Eq1PL+XKPZmlKLLwi5/xfeLWEE4VP3WLBg8sEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TisgBXY4Qr/ieLRpBmVZxHBKMc4Tnx61Htv5zoaBBFU=;
 b=V39Vu3/UdFND304CExetaXhmJiDV6LTc8nFDFepgkQ/j6v/D2cRAtLZzW6AXbtFxXqynkSvRxxNtqd7LRRTL/JLs3AQtMXYZTQiSFIUlZf2oHSbihaRAKqfPWfjl0nudiATL6b40gnaf2D3SGeshWvNbr5zGC5GWiDTz7tXqEjZMXKRcCOim2d0nmgoYFkcCUBddkVRUZ4iyBFZYyFGq+TfniP6HJ2pDNcx78z+81rxyUCWi/n0zeOpsRmhsnBieH77LC89vMjdX8tz4DEx3OrCOcTcyBmiYO7cnBaNnMsIJ2hSJNyCm20oj1W7nmhsl3jmdgWOm/HS7qkcDHrw3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TisgBXY4Qr/ieLRpBmVZxHBKMc4Tnx61Htv5zoaBBFU=;
 b=FWive7kOXkqoH0ToeAnyK977ntv3ohHex+CFtfJozC4Sy9u5ZhHEHl2JXLDqtno33NHcFuJXEHRcThNQJ0Vc2zzE7uBSf+irXcp6sPI/+VSqJb1gUqAQ0J7jrjQQPdK2qiN1RaNFbTQFAoBltfRReCs2Em3qFOb04yEydaIi6MNsojTaBZhbke56G9ZJ56LQRuzGLhIc7PZR0RCrTpFkhHv68LCEgMYDvHkKA/vGEiA2qoqdr1iX/9iiaja34di1oSvxSp88Jw8r296GFKYxm8w/oXP7Ulh0ropyMQrmgWKCquVz65ceNf/s/xMn1OVD+3/vZaFaJBlz8hczSzWu6w==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 PH7PR11MB7607.namprd11.prod.outlook.com (2603:10b6:510:279::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 23:21:51 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 23:21:51 +0000
From: <Tristram.Ha@microchip.com>
To: <jesseevg@gmail.com>
CC: <andrew@lunn.ch>, <olteanv@gmail.com>, <jesse.vangavere@scioteq.com>,
	<netdev@vger.kernel.org>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment to
 32 bit boundaries
Thread-Topic: [PATCH] net: dsa: microchip: KSZ9896 register regmap alignment
 to 32 bit boundaries
Thread-Index: AQHbQRlZBlDFYrnjzE+ftiaJFVhgfbLTnvdg
Date: Mon, 2 Dec 2024 23:21:51 +0000
Message-ID:
 <DM3PR11MB87361344332FA27FEFA94FDCEC352@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
In-Reply-To: <20241127221129.46155-1-jesse.vangavere@scioteq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|PH7PR11MB7607:EE_
x-ms-office365-filtering-correlation-id: 2100a974-6153-4a5b-d78a-08dd13281a20
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WnuC6ku/HRcl04wF5rA/AMIiH1pQ05/Vw6fFO3DLpadCryhHf5YbP+ugKEwj?=
 =?us-ascii?Q?ZXz3jG1LPVND1Gn85V9YAzAv5w0y8klW6m/C4D46R+kqLpqv3CMSD+H6f4f+?=
 =?us-ascii?Q?qPFiiDK2Wk1O8T1XbTdZzjtdIubNedyROQzGPK/Vjluf66pQdBImPrhqpSEj?=
 =?us-ascii?Q?gVeJp6wEeZpDB4LhXIrUdg5beU2uxC/asRNYF7q1M8MLF7phpr0ptd1HqQWm?=
 =?us-ascii?Q?xFHmvwDdwMhRFGIhMXWpjtsCeFtihg965eGWtuoRy2t2ZuEAbWwUjRgIqqP/?=
 =?us-ascii?Q?L8vxfCy3xMsCXdcISQCQqH9yobLkafnpSseC8GCaRIrBuVBI+TxGy8kTfo2E?=
 =?us-ascii?Q?2XLctcxbTwuxN9UIePY64b3efH2f+ngqlx88ZsUYQwT29xR2cT6JQ5H7GZGB?=
 =?us-ascii?Q?voijy6t+Eapl4gxSIBI0UiXIixVc88vGLZJn02/RabbJe/lVTEfEFKk7deIg?=
 =?us-ascii?Q?o/N77Sl9z/8lmHB8Q8knIctpSg/sQ0ZizdaMnnCVpMiIKrtF5S3m1XSBzi8P?=
 =?us-ascii?Q?XA6G6tWeM2gzt3iEZNCkRJ7FRKOsLcnf4VbZ4Y8h6c2UAg7J5Ps24l+tgT/+?=
 =?us-ascii?Q?nItj9KCGfiU12Cbu/zFQoFuo5NLUTSiGjj73F40niB3tWtDlH4VKYU5ZfePC?=
 =?us-ascii?Q?VY1MNnvzfL+T2iYqbE3tMR+lUnSaxhcr2leCA1z2UMyL54EJfp0PAObnjgm1?=
 =?us-ascii?Q?xfdYSBGsJm+IUaqnjzES5+HStklGRtcWAx51WmFgKqrNMAEz8iraa2+F/t+Z?=
 =?us-ascii?Q?zgYpKyAD90Bx8sxke5/FLJeNz1D/5WLRmDKk8jN1Hh67ZGxc2WRL6/T+wYuY?=
 =?us-ascii?Q?IV+ySej+EmLBRIxuFkacbBTFaD+koHJjw2/YnIYnM52BCnNEL9JbbW9Z3kTZ?=
 =?us-ascii?Q?XJ5DOZ5dzIFlOm+fqxAqn2TF7H4nY4Mj1tCbMu1R3x4zKqTtEfFiHAi1Q3+t?=
 =?us-ascii?Q?j83YtLm2qTPlcKwIbJjYhy8Xfy2w8wXlTHSaIZyEXM6fIRuMC8/ybZkpcLsn?=
 =?us-ascii?Q?a/2rVyuE5555/CTY0kBn0nAalkX79rwzlIrmtis6MjRB3jox4x9egb0waMiJ?=
 =?us-ascii?Q?iXyD3SCc6fu1wSZyFuFLnkJOKTtSANOhJNUhHY/nnZYiMgOtBA1xl8PMPdFY?=
 =?us-ascii?Q?TyRudcXtmPxNDG4td9zbvkuVgz7urlbBJsGAJ227XQNNxrcBNocFNBWQx9IZ?=
 =?us-ascii?Q?blyCXK0AuQk2dPEkjXkaeXrvHVOjJK6T4aXfG++XyKHDl24qYdzL2Xg2yYGq?=
 =?us-ascii?Q?VYVSWm4qfKJZ0AtPp3TerYaJQUEHlC8tqSPojlHw/xC8WPAmWG0w+Myx8mIc?=
 =?us-ascii?Q?JBWB5STmEaWQgJRbdRWDXDwLEM/7H3KOZeHXo5NJxAw/SrA46bKYn6eaKnR3?=
 =?us-ascii?Q?tx0ZWEgm2u/h0fniIUthjfmP3XarUXUKHgYuZd13A0jRl6pvvw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6PaJ158rwgPzyF8guFCQQtsEVo1g6yi2CUsVP1HU4Q0z/ntd0nUkaI8rT3i8?=
 =?us-ascii?Q?h3abxn6+Xo6IbjCbP9qd9EQdTs0dgEBxXQuO/vA/hjlrqZ8ZHvwF14JnWUPT?=
 =?us-ascii?Q?m6uUStmPvrZMu97/ZARvFl2CEPKBjSCRLaN29A2baCkmlHUSbE7mF68Mf6vQ?=
 =?us-ascii?Q?A9ha3zC3dtgfOw6kPPwY5q7n+e72Wy+1F4cBr06gw13nESTjB5li30zB1A5D?=
 =?us-ascii?Q?viMTUDL4PdBM3AQuSlPuS4iFyzCIPWxyuq9cFbf577e73UceUqpwMn7RmJil?=
 =?us-ascii?Q?axptaDRTCPlqmx0D0kkYXJBHk+n1sDj1fl1pRoT9qutCHYe8jTyCUNwb1LOX?=
 =?us-ascii?Q?lVyj46FQ+a/4nVyXrN9XlR7t8luWLbHyZH1m0ovh44vJdOxfTl60eLxIA1SR?=
 =?us-ascii?Q?/5uBG3JIsFnaPfUt3NUxQHECiBb36A/MzCXcMJBuUadQQ5AuhNKqaFJoFm4U?=
 =?us-ascii?Q?zxHtB08k4QB8Abk2hXZskk/tBUTN78LjFxke1nJpLryjr+/kRoCzOFukuy6f?=
 =?us-ascii?Q?1T3ILBiwqK0RKHJFiIsESqggB3Qbmkh1eshivwgw077B0ERqd0m69kMPu8ZQ?=
 =?us-ascii?Q?QfQqK3bExCC8DPfNQojK8cXtsnm4+SVVybltexc/Tbs7JUteYbX2x3HUKDFN?=
 =?us-ascii?Q?tCwnrReWn3W0BJjCBTCtAZR+TBT0k8Tpjh9ACZlDUXK1/QZ460Suo6h4WCmF?=
 =?us-ascii?Q?aLw9zmjGzr68xyREMKFG4ykWauyi6nxIMBcEbSjG3NQvuhzAQ+0sWCn7Olwm?=
 =?us-ascii?Q?38FuRBskzzROluuSECuvq/gsP85o+JDAQoIVJxWu9qvhwhseeK6ce2gJRFj4?=
 =?us-ascii?Q?Vbzq1svfTQ4IirqWVQV714sYpTrAP06FFTpclRaATE4+I8XdqYA1sHiGSTY4?=
 =?us-ascii?Q?c9zugyopyjTrv1EG/CRyvnwt2arfyUqa567diBAfaOMqHNNYPoqTnQLE+fW1?=
 =?us-ascii?Q?s2hYdNxUt7bP2Vob04z2IKSx+2yRMC/Qg18xghcAIX4D5iEH7swnVA0BFcef?=
 =?us-ascii?Q?HBSGWk6676G42OsQpEMALcIvk+Nk/wdCIegtigc+VsbJjAg8H9KS2F0oRRy7?=
 =?us-ascii?Q?lxYFUM5Tg3h9hJmcIFjSOJ4LaZC9DZTFTZLkDy8ELJYju0Obb0j0sRUwGo7H?=
 =?us-ascii?Q?19KGDDwNTVnPP3xjFjTVE7k+IpI2uj3KohWgJECDuq8Lh3YwbDSvV6fInGPS?=
 =?us-ascii?Q?oJlHnRWVfFMehWJrhQ0irXV0jb+cu/GSspKzd5kFLsYjQuYTDRmBxT2r+ruf?=
 =?us-ascii?Q?BULYBSNZhRidTQVBTcIj+P0Mc+6YK48lzvdr+PAiwVMiFocOTyITl8HMSf84?=
 =?us-ascii?Q?Gf6TrWMLoWhPd+N9L2EHGrpimE1U0qOqSNMvB4U6tH0gJWp17eqZ/YHzAy6/?=
 =?us-ascii?Q?IOrmY8tAzlX/fVx39uqjJmq1jJ04/CXvyjFf6FUuWvFOFdMvjw9waqJLrqUM?=
 =?us-ascii?Q?EdEtXzvsJ7tuDOrO/XlFEVNmMjVfNUe1DTKg8QYg0JdzuOsh8HV32al6XZAN?=
 =?us-ascii?Q?x8t+ElNYg9Crf3IvzpBUaIOvhzNs55e5h65wtEWIl1NWTs1eT15/66q2WilA?=
 =?us-ascii?Q?myTMoRxKThqVeo+XclQDOghX2PZ1HI/UezxIU6gh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2100a974-6153-4a5b-d78a-08dd13281a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 23:21:51.3880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZu9mIMA/q/r3+wHEgKuAIbxNpIkJ3aDQIYDtBhUql2QS84jDNDmhBv9WWTc/KZM/+9K6K4nIA8LGmmf3+n4c0n1civm4NagGHNvMtIP9gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7607

> Commit (SHA1: 8d7ae22ae9f8c8a4407f8e993df64440bdbd0cee) fixed this issue
> for the KSZ9477 by adjusting the regmap ranges.
>=20
> The same issue presents itself on the KSZ9896 regs and is fixed with
> the same regmap range modification.
>=20
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 42 +++++++++++---------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 920443ee8ffd..8a03baa6aecc 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1100,10 +1100,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x1030, 0x1030),
>         regmap_reg_range(0x1100, 0x1115),
>         regmap_reg_range(0x111a, 0x111f),
> -       regmap_reg_range(0x1122, 0x1127),
> -       regmap_reg_range(0x112a, 0x112b),
> -       regmap_reg_range(0x1136, 0x1139),
> -       regmap_reg_range(0x113e, 0x113f),
> +       regmap_reg_range(0x1120, 0x112b),
> +       regmap_reg_range(0x1134, 0x113b),
> +       regmap_reg_range(0x113c, 0x113f),
>         regmap_reg_range(0x1400, 0x1401),
>         regmap_reg_range(0x1403, 0x1403),
>         regmap_reg_range(0x1410, 0x1417),
> @@ -1130,10 +1129,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x2030, 0x2030),
>         regmap_reg_range(0x2100, 0x2115),
>         regmap_reg_range(0x211a, 0x211f),
> -       regmap_reg_range(0x2122, 0x2127),
> -       regmap_reg_range(0x212a, 0x212b),
> -       regmap_reg_range(0x2136, 0x2139),
> -       regmap_reg_range(0x213e, 0x213f),
> +       regmap_reg_range(0x2120, 0x212b),
> +       regmap_reg_range(0x2134, 0x213b),
> +       regmap_reg_range(0x213c, 0x213f),
>         regmap_reg_range(0x2400, 0x2401),
>         regmap_reg_range(0x2403, 0x2403),
>         regmap_reg_range(0x2410, 0x2417),
> @@ -1160,10 +1158,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x3030, 0x3030),
>         regmap_reg_range(0x3100, 0x3115),
>         regmap_reg_range(0x311a, 0x311f),
> -       regmap_reg_range(0x3122, 0x3127),
> -       regmap_reg_range(0x312a, 0x312b),
> -       regmap_reg_range(0x3136, 0x3139),
> -       regmap_reg_range(0x313e, 0x313f),
> +       regmap_reg_range(0x3120, 0x312b),
> +       regmap_reg_range(0x3134, 0x313b),
> +       regmap_reg_range(0x313c, 0x313f),
>         regmap_reg_range(0x3400, 0x3401),
>         regmap_reg_range(0x3403, 0x3403),
>         regmap_reg_range(0x3410, 0x3417),
> @@ -1190,10 +1187,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x4030, 0x4030),
>         regmap_reg_range(0x4100, 0x4115),
>         regmap_reg_range(0x411a, 0x411f),
> -       regmap_reg_range(0x4122, 0x4127),
> -       regmap_reg_range(0x412a, 0x412b),
> -       regmap_reg_range(0x4136, 0x4139),
> -       regmap_reg_range(0x413e, 0x413f),
> +       regmap_reg_range(0x4120, 0x412b),
> +       regmap_reg_range(0x4134, 0x413b),
> +       regmap_reg_range(0x413c, 0x413f),
>         regmap_reg_range(0x4400, 0x4401),
>         regmap_reg_range(0x4403, 0x4403),
>         regmap_reg_range(0x4410, 0x4417),
> @@ -1220,10 +1216,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x5030, 0x5030),
>         regmap_reg_range(0x5100, 0x5115),
>         regmap_reg_range(0x511a, 0x511f),
> -       regmap_reg_range(0x5122, 0x5127),
> -       regmap_reg_range(0x512a, 0x512b),
> -       regmap_reg_range(0x5136, 0x5139),
> -       regmap_reg_range(0x513e, 0x513f),
> +       regmap_reg_range(0x5120, 0x512b),
> +       regmap_reg_range(0x5134, 0x513b),
> +       regmap_reg_range(0x513c, 0x513f),
>         regmap_reg_range(0x5400, 0x5401),
>         regmap_reg_range(0x5403, 0x5403),
>         regmap_reg_range(0x5410, 0x5417),
> @@ -1250,10 +1245,9 @@ static const struct regmap_range ksz9896_valid_reg=
s[] =3D {
>         regmap_reg_range(0x6030, 0x6030),
>         regmap_reg_range(0x6100, 0x6115),
>         regmap_reg_range(0x611a, 0x611f),
> -       regmap_reg_range(0x6122, 0x6127),
> -       regmap_reg_range(0x612a, 0x612b),
> -       regmap_reg_range(0x6136, 0x6139),
> -       regmap_reg_range(0x613e, 0x613f),
> +       regmap_reg_range(0x6120, 0x612b),
> +       regmap_reg_range(0x6134, 0x613b),
> +       regmap_reg_range(0x613c, 0x613f),
>         regmap_reg_range(0x6300, 0x6301),
>         regmap_reg_range(0x6400, 0x6401),
>         regmap_reg_range(0x6403, 0x6403),

The port address range 0x#100-0x#13F just maps to the PHY registers 0-31,
so it can be simply one single regmap_reg_range(0x1100, 0x113f) instead
of many.  I suggest using regmap_reg_range(0x1100, 0x111f) and
regmap_reg_range(0x1120, 0x113f) to remind people the high range address
needs special handling.

I also do not know why those _register_set are not enforced across all
KSZ9897 related switches.


