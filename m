Return-Path: <netdev+bounces-205123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DD3AFD76D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D691BC55BE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48A2459D1;
	Tue,  8 Jul 2025 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cOSM5In7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950F24500A;
	Tue,  8 Jul 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003949; cv=fail; b=kuuGH9BWMOHYk3I1Thddingo5JeRytbqzBB/IAa1SvxzCHtiX4oRe8kS3T18O0LCNcsk/p2RE6e1KMv2LNCw50Wzl/GjjEYx6Slq6GG5giwSILgP50QAZLSkAlRY20swqaNDkWNoLUkRdDBeUl48niEav1mTEEMMyjuFuzwhQng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003949; c=relaxed/simple;
	bh=rc2Xd22XEfXmdFP+W/hVLxiIku+mahHyvI3pZyz/bkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GyeLlAIUBCIl6RMKoIcNX926jf2POr1L5CXoLYJ/RqjGMEJaSQL0qpeBy7UxT1X/AG64+BLzRAKq8/FRk/fbo/5bpYSMweqL5o2UuJAqUQtZDxdbH2/znL3280ZnL/KqnPSHdlFmW1CMgP028AN/aketObAoYYB9dmFEoIFol0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cOSM5In7; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrzKO8bmOpXDWo8PEOK5FmAZfniQmjGJonhGjW479yAgZWX+hJXxC6+6QK9iq7uGs+J85VnJsukowFbP0FuNoLOA6sParxIP0T9ZlHHsdbWl/7zzOCs1tiGLZq3q6bYSaqUSUoQ9dh7gun5/XlUfYQq97VqoeUauZ+z4+5CRQ7DdR78Z/zOMMYJmud6+qIK32FuXyWZv3Gm1AyUu04LFh7DdKpu8pfT6axhEu/9mn/UtnDhXSM30R9O7GAeB3sStnkWR8dDidAknYim+in8/rvGlkVDMczS7H810AkIqFXKhRAEHcSWeu5ig4EgzfXnvE7JqJ4erU3mKvZ9M9wJkYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ej1OpGJYwJuz5oAL4fpfOyQVfr60rcrb4Z9H5JEbcg=;
 b=hjAGsvhDvAdDSizT9X3nFS8yGHaXLUZI51GeRwnI8tXlubIvSCHZWFOQurMbXpbmzg6duAr2vkx51EYgO7Iq9Xma+u+ZpCT4BZjX590YkPckSu3w+6NMBF0fbESsd4qedW5tCNemsAIUuTLiGrWjs+4G6b5FNoa0wfEmKTEhqYX68MkYSL2LVE+SwaRBeE533Da8L09GWfDslilu+jv/XX7OSIZkLP/7oNHSS837WIu4jmyPn+rFMI/pkhx5Fz6gbIFePFQG8Kmnvb7H+A7JgXMlmIP1uJ2NDjABmkYTGacUmbJsiHKbbnH5Ey9NFJNcG00pyf2Svk0n1S35g17gGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ej1OpGJYwJuz5oAL4fpfOyQVfr60rcrb4Z9H5JEbcg=;
 b=cOSM5In7hZ+Enx6lbf6HrFlzfm/iDG3l3BRflR0+xIyG/1MiDX3wl1B4lFPKWH8jjjFoGHd6kEP7k0dOl2sMoKCMqb4RBOu9txHEUiYXE6qKOvnR/t/9okGZYz33G+/HO8kLk+85tbrLBy0dkEtrpCTu13gGlIv3gR64PQUVLlrS583DNVwZ9jNPbzJ3Pp7ZG6VUmSCsYPs7F9xugX4xHztEs3PPWSdkpHW9MoR4uFqtRxItvck/FxiGLbgt/mO64JNuNfLAr2PLhhK5nq3I6OOBLs6e6Zlbv4zx4yAIP6Ef+flTVfDxSq0gO1rKgYeYx4hiLuRvlm5HqSC3kCEWWQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DS7PR11MB7807.namprd11.prod.outlook.com (2603:10b6:8:e3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.26; Tue, 8 Jul 2025 19:45:44 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8857.036; Tue, 8 Jul 2025
 19:45:44 +0000
From: <Tristram.Ha@microchip.com>
To: <maxime.chevallier@bootlin.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Topic: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Thread-Index: AQHb77bM67Dkv0j6akiDuvLgerj6T7QoBQaAgACcTtA=
Date: Tue, 8 Jul 2025 19:45:44 +0000
Message-ID:
 <DM3PR11MB8736DE8A01523BD67AF73766EC4EA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
	<20250708031648.6703-7-Tristram.Ha@microchip.com>
 <20250708122237.08f4dd7c@device-24.home>
In-Reply-To: <20250708122237.08f4dd7c@device-24.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DS7PR11MB7807:EE_
x-ms-office365-filtering-correlation-id: e6dbd4d9-a996-480e-5426-08ddbe580747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4AYPk2hLYcNgbdZR1ls8RAkIPf2bEovQQT/a5kB4aX96HEFiB/iD2Mc/n3OQ?=
 =?us-ascii?Q?SO8FvClEwqFw3a1FFetwFM/+mLfOE54M8d3j4/jlH3UDUVjtyPHgOYZ4dk2T?=
 =?us-ascii?Q?aDR71npJVn+Dd2rGd7rADFKXYawdve4fUVM3in7ZEJ9ylaqXDRr25u5CzhHL?=
 =?us-ascii?Q?C32UOo2dHPHMlVpfazU5FZdwkRHIk3ad3t16YLTSWr/DeadoNMtql6d/aKed?=
 =?us-ascii?Q?LPt+GlOVur3QdJSdYYAm5g2yGOzz4a6Vx/HT+D2B/y42qmIftYzJ5yA23MVn?=
 =?us-ascii?Q?xG4dpdpxiLi3MK8/LjQsfXEvHp/Q6cHH3wkjJ0Ap4LqxiYp6ZZHDa6JcC6Q8?=
 =?us-ascii?Q?bkRb7dbUFrk6uW5u0iCIsuN6ir4D7yarsO8IHlAqB7dElp3ax+TrNxtiYooM?=
 =?us-ascii?Q?Qn7vypA5kEqRD63nJ8y+fNnaC+MVyIVV4dwUvyugZJhcpXBIT0tXGUSel6yK?=
 =?us-ascii?Q?x9MdjBjOm2pzQQgeNBEqSN5sBha6KFvAhRQGbqg9F12lLHQ0E38Njb8aC0Vm?=
 =?us-ascii?Q?to1Nk+Chq+pOLP4AND0xJ2CValTAlXlK1WDS2veCKABEAyp9hPWzFU5LARRv?=
 =?us-ascii?Q?3PtXlw3rJ8Zvct1JVOfoVloRHu1rHhOd6fwU9L6BiVK57i+2w4HIkwsjfKzC?=
 =?us-ascii?Q?qpCQcP8jFERpRtL2kXxPKP78L+fJGhJDH3Ik14aPKxYqvT7HBOE7hbjKVI2l?=
 =?us-ascii?Q?ngqYoizzpV/YNTCfcuPU1YWsFZwzSLvOBobdM4i5FM3VdB5n3jDyaAkvTQcZ?=
 =?us-ascii?Q?lHPWRqcBE0VG7xoDQDovTB1Uxpzs2Iayn50wJ8Q4OiQl/3mYb/7Eh6sEeulE?=
 =?us-ascii?Q?PJe6E6lRLr4vXLTe+YdNLXbOr24LWzyU/1KwkI/AmGzVQ0kkcQC8u5uIPzs4?=
 =?us-ascii?Q?qY8+f41S2Y/2LO39Che3bxsfSNudnOEU6v+4Q1svS0F8CzQ8G2m7Dm3V0tqy?=
 =?us-ascii?Q?l3+IDp8Dd0UqMha57w9k3C31v2eBJlWPdC6/QAXNl/WPEo8h3B6aanV8ZHvU?=
 =?us-ascii?Q?2MsY65YuGOFSxjZxgj/qKe88/2qGF9DzXbxuUOmvIDdWfeeYWX60r4X9dbE1?=
 =?us-ascii?Q?b51paGeDD1Xgg2RIgvSySIuDx9GomV9A7NbWJ7xuG6xD56lpUyLZSLBukoj9?=
 =?us-ascii?Q?EwLYDpI7FBJpJXgFqkuQqC+fWFspTKbcIUgnAGEMgvmMia8iNh7FZzS8F4Gu?=
 =?us-ascii?Q?iOyjTRRcaWW3KFXmSVnuMSAiGG36gyf6/IjoMHXFMVV++zQN0iYMetWnqKmG?=
 =?us-ascii?Q?thbzhEciKa+b5/c1keXMIENS0JekHb6Sjbk6ZuDEge1qSGOdWYtXJqYVl6uK?=
 =?us-ascii?Q?Uq2Ti3iLdllEFvQkgHqyM4xal6+wPuhNPvaxvzl3OoT0UgpmlbfWTb2RoS0+?=
 =?us-ascii?Q?B7TScvAYskDRWXxaWsFKAXzzEvQ0BFYBCVkNhvv31qzXSWsrFXh8sJh9Uk0B?=
 =?us-ascii?Q?8nhV2YtNbFL75xtILJO7SCsS6nIv3UpkkZVu8vUWoWM/Y5nPnFxyAw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RH5JhT23E92IeCY7eD8teUc3LZiwhIpEidU59rDGKk3fIqMbFfDetq9M3g8c?=
 =?us-ascii?Q?HWzkY1cNU5iHMMK8rIFBwnI1l/SX4o++1YnKXCzVsWyvgpqtmEo8TkxgeMx9?=
 =?us-ascii?Q?O9sDK6llpMa4wcGjOXI6D1V/S/x7eU/mqiBMFA3JexKBhuQYPie/GrvHIGwE?=
 =?us-ascii?Q?LhNPeBRweyNxs7PJPdQsZdBLS/P2eZdHIcgLM5VxYwecdD4+7nnaNMl/OPwV?=
 =?us-ascii?Q?JHdK9MzGDWAwwxed8lmTJjSY0eLjFsTpuXKYAJFP4w4UPYgm5bAJzC4ZG0ET?=
 =?us-ascii?Q?Aca4MY5kHx7g2njwx/v1TQU7GZwwxjF2EIl3/yjpMENalK0cO50rGADiIxiy?=
 =?us-ascii?Q?sqAawJIgXz6fdiErwDvcU9lU7f/E7QvhioF7i1UTHL8LGglhdLt/jFxuez17?=
 =?us-ascii?Q?h9/Aqf2yYUcwYKnNcfiYeoByTaLc7g2tJgO0WuO3ZqCln+eL+KqMOtMERP+a?=
 =?us-ascii?Q?P0e8wWFwiXTmSQNSedsH1YjwkH1tCvZ77zoUxa3lnxT1HlciE2/+WRNwgxmS?=
 =?us-ascii?Q?3SaIKC5bbIxCXVNGHAVC6SEhz92FLnWM8WYbVT6vLFKnkOGLRlQW+w0i+Cd8?=
 =?us-ascii?Q?AIBbJOmdUA3VTrxcxhncMdCATbYqYGBw2fto5oSeHJIoZZMAUw/i7CFc4WB/?=
 =?us-ascii?Q?cbdQmpx/8dqtejFzC452T7bKBo4h4hIGctO93S9pLMr2wUuNabVBzlsj16uB?=
 =?us-ascii?Q?zuBipDQF7He5mgmM7xtQjJnKqWGcAHTR5nOjsxkIvfNB+UFrvyX3T1cpUhFI?=
 =?us-ascii?Q?tahtjQ2ebAJmmaSK/QZAoIDS3EcDMaz5stuHJSBWfRTmGFZG0T5aAVBmpPyM?=
 =?us-ascii?Q?7l7N6OHySMvnxsESc3sjXqu4b8ZfPNsLiL3UvU0Q4/TZRsJ4zBscqzRqdjxE?=
 =?us-ascii?Q?5AZKf965jqZrxHDGmRVOJwb/tDfupb0M4A3z1gapEZS9ciZdV3VzxE66K+ob?=
 =?us-ascii?Q?UmCm3w7FC5M39iiSjpHNgeJ2qyB/UCzj1FUd95OQwzwvxbkdoJqiy03j9nCT?=
 =?us-ascii?Q?ev9qbhaVulJqwFUuXxi/dd/8Cm6qjMuWjCyPAJy88ZIwIJKRqIdXG/QphUar?=
 =?us-ascii?Q?I3rmEou4ymBpspLIX0rpH02RLDrJp6Lvs3PJMgvkPSTJTj+hD1HonlSXTuKy?=
 =?us-ascii?Q?8N6LUTneFtmQ6LPahJL0b95YTVYDal12SLVdg90+nZCQ29uugDddtJApvYJF?=
 =?us-ascii?Q?iI/H9MBAbw2JgqIr1aXvWEO9U3kRsTdLjwm6pG3OKrzdyjfHj68Dr1IneQXD?=
 =?us-ascii?Q?1PhdpODh6P1VsMZ8ITrsSTvhwePCbbkaTB+BMRg14PnIoCGPSSnlVg5+hEp4?=
 =?us-ascii?Q?eSCu92CQB4c00yigdE6vxqtmCWsC7Tc6H2QEd+mMzvLYpyllK/mcFXsqAD8Y?=
 =?us-ascii?Q?TGZym6rRsCGHiBgDnu7PctK4p3HwtNt3emdHGg4LgR0BB69ubOyw7owoUwCS?=
 =?us-ascii?Q?QxGIwf4SZh0GD5+Xwbdwgakp2Qpree13rbXoweKwIweG6c+Rrvly923PD/Rp?=
 =?us-ascii?Q?slwDxZs1XsuTywdaHHEsNOf8S1LFmaA/Q4e1b63i5VujKZQEXdODcoFZLy96?=
 =?us-ascii?Q?xZolgYpXhtyzQIf5zvwcc91nXnOg8Vao4lCwAjpg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dbd4d9-a996-480e-5426-08ddbe580747
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 19:45:44.4795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIkHfv2wahkpqOHYRox46Ff4uoPquguM0hhhROsoZ+WmbT0e3wuMtVCoBLZ+r4acIrONhxtlDYn9pzId7N9LL5mv5GDmOz51saK02tzaqlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7807

> Hi Tristram,
>=20
> On Mon, 7 Jul 2025 20:16:48 -0700
> <Tristram.Ha@microchip.com> wrote:
>=20
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The fiber ports in KSZ8463 cannot be detected internally, so it require=
s
> > specifying that condition in the device tree.  Like the one used in
> > Micrel PHY the port link can only be read and there is no write to the
> > PHY.  The driver programs registers to operate fiber ports correctly.
> >
> > The PTP function of the switch is also turned off as it may interfere t=
he
> > normal operation of the MAC.
> >
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/ksz8.c       | 26 ++++++++++++++++++++++++++
> >  drivers/net/dsa/microchip/ksz_common.c |  3 +++
> >  2 files changed, 29 insertions(+)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microch=
ip/ksz8.c
> > index 904db68e11f3..1207879ef80c 100644
> > --- a/drivers/net/dsa/microchip/ksz8.c
> > +++ b/drivers/net/dsa/microchip/ksz8.c
> > @@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> >       const u32 *masks;
> >       const u16 *regs;
> >       u8 remote;
> > +     u8 fiber_ports =3D 0;
> >       int i;
> >
> >       masks =3D dev->info->masks;
> > @@ -1745,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> >               else
> >                       ksz_port_cfg(dev, i, regs[P_STP_CTRL],
> >                                    PORT_FORCE_FLOW_CTRL, false);
> > +             if (p->fiber)
> > +                     fiber_ports |=3D (1 << i);
> > +     }
> > +     if (ksz_is_ksz8463(dev)) {
> > +             /* Setup fiber ports. */
>=20
> What does fiber port mean ? Is it 100BaseFX ? As this configuration is
> done only for the CPU port (it seems), looks like this mode is planned
> to be used as the MAC to MAC mode on the DSA conduit. So, instead of
> using this property maybe you should implement that as handling the
> "100base-x" phy-mode ?
>=20
> > +             if (fiber_ports) {
> > +                     regmap_update_bits(ksz_regmap_16(dev),
> > +                                        reg16(dev, KSZ8463_REG_CFG_CTR=
L),
> > +                                        fiber_ports << PORT_COPPER_MOD=
E_S,
> > +                                        0);
> > +                     regmap_update_bits(ksz_regmap_16(dev),
> > +                                        reg16(dev, KSZ8463_REG_DSP_CTR=
L_6),
> > +                                        COPPER_RECEIVE_ADJUSTMENT, 0);
> > +             }
> > +
> > +             /* Turn off PTP function as the switch's proprietary way =
of
> > +              * handling timestamp is not supported in current Linux P=
TP
> > +              * stack implementation.
> > +              */
> > +             regmap_update_bits(ksz_regmap_16(dev),
> > +                                reg16(dev, KSZ8463_PTP_MSG_CONF1),
> > +                                PTP_ENABLE, 0);
> > +             regmap_update_bits(ksz_regmap_16(dev),
> > +                                reg16(dev, KSZ8463_PTP_CLK_CTRL),
> > +                                PTP_CLK_ENABLE, 0);
> >       }
> >  }
> >
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> > index c08e6578a0df..b3153b45ced9 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -5441,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *dev)
> >                                               &dev->ports[port_num].int=
erface);
> >
> >                               ksz_parse_rgmii_delay(dev, port_num, port=
);
> > +                             dev->ports[port_num].fiber =3D
> > +                                     of_property_read_bool(port,
> > +                                                           "micrel,fib=
er-mode");
>=20
> Shouldn't this be described in the binding ?
>=20
> >                       }
> >                       of_node_put(ports);
> >               }

The "micrel,fiber-mode" is described in Documentation/devicetree/
bindings/net/micrel.txt.

Some old KSZ88XX switches have option of using fiber in a port running
100base-fx.  Typically they have a register indicating that configuration
and the driver just treats the port as having a PHY and reads the link
status and speed as normal except there is no write to those PHY related
registers.  KSZ8463 does not have that option so the driver needs to be
told.


