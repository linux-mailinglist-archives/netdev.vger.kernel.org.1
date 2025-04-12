Return-Path: <netdev+bounces-181854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CDCA869BA
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 02:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6371BA4C45
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 00:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1678828;
	Sat, 12 Apr 2025 00:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r+U5Oade"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0BC80B
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744417120; cv=fail; b=H2Fv4fu8uEaFk0m+Bduqc5m4Fqiv30HvML+++NA+9W+gA+y0RGLesdirP/u04GTbTWaOKHAJ2CJ8QrVGTDNYxbKRT0yLNk3w+iyHJVMX4f7TDks8dk14KuI3C8/xlB6zDnox3uby6WlP8RVFBvTu/qnIMcxrrOv63+aKcaHb8vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744417120; c=relaxed/simple;
	bh=cbFy5I9dWoMuohbzjTCQlvHcV7olnVfGzDhFqEkNko4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OhxctUaegfI1vRqZP/qx+vABhWEyb8zhROD1t5JqRftdPoBTfSeQJzHsnuraWfyL6VNiFx2iIGH823BVJebULo/JzUXG35xkLB/8KfCYo7n4oDyo7JxWP49S+1zBINyaud8ywng8TVRtHQb0rEoX4q28IogD7WHPYSByhj59WJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r+U5Oade; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pacd8ZpaMZn/0oeXKiOR3sBzVPvaNCtf18BNk1xKV+upwV8IlPcJFxTLp6VOUGVsqQYVgpap8aBdiFXfdbiKcpAsHM9pnJfUrJQhLlVLYe3MJNNNRs6zLnkIrGQPViA0S0v0fxD/H2zsJ7H1qG5Uz16kgUkSgX5XnOsnPTI6mBZIaYSUYoHPyUdF+xDEK0bIrBXRs6tx4lXdnR1sTfvEb20bkaXCO1OM58Kbm4E/UvWTICM5syxIWbjZtXRewP0AwiW8gfT3+tlD29ifGJBn0JsK7mBwO9HDBpErGfDXvXVMyki7OkyO+86gHWneMCqYiEDXgbKyd2kndUIRSkPE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KswYS20VuCqpwnQinfsaR7Xmw7lFlfjGvoEvqDM/sEw=;
 b=Z7lk3hv4kb5fbTHL9xFFHVqn3uZG2P4vqXM6oopRe904Hxnr+RkZ6ANiLLsMy43/ccBDZNySMwVIqdg9zVE/A6BVjvCOlyxaZulssTQlC+2nSGbPtDF0YKJw9gKRsB64lZJplqmS4Asm4zz8aBQ+Mv04ZCfwDY2tLx/jkdaWl1CQ+2e1b/w4H3p/m69MIKRWz5RSZy9MOJ1xh3owcm0y99sY6ZQK13PvzdgLtouQcsUPWH8ED3IIYzcITmMExAJqenOgT2gqOZJMzPEtcTpdrNbSQzfrXA7DLTIiJ+1OTHYwF9S82ioafk2vTGnV8MCs06bSMjXdPh6BF0dczocWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KswYS20VuCqpwnQinfsaR7Xmw7lFlfjGvoEvqDM/sEw=;
 b=r+U5OadeY2L2w5eXnyhd9gboiZPA0UTb1Uh9nMscLkFWQnrcl47hDe43hI8e/HZIT62VKwLOG8LnlDQGXtJBgLHUb06dVXX0gmYHAVF+UeKW/vywLlXoPHzpnrU8uLDmt3JwrUM+dd1BYpRd5AAJLf0cnBnttXFrhwYDn7bFX55UPh9nl4QWYLaTWTY/6E25ZfzzAlW2jNQHkGVRFbh/xf8cOx3mczyrxM9ahvxdgGWZ/xtOlIHFKQUr8q9oaGJ3DHnamwo5GZ46Z80kuVLRJ4PC8iXpBDzYAElVLuwMDBO2sy4HdIw6BINipMIgg2jUqlJI2cJxxSSiyWU+X11Mbg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Sat, 12 Apr
 2025 00:18:34 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%4]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 00:18:34 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <linux@armlinux.org.uk>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <hkallweit1@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <Woojung.Huh@microchip.com>
Subject: RE: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Thread-Topic: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial support
 for KSZ9477
Thread-Index: AQHbd9G7VcLFvSdnAUmXjlhnL1yQjrM9UseAgDw9RUCAFBN7bIAR7B9Q
Date: Sat, 12 Apr 2025 00:18:33 +0000
Message-ID:
 <DM3PR11MB8736B75C8846DE3816F42935ECB12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
 <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6dHo0DFWUiMMUyN@shell.armlinux.org.uk>
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736D45A311DA7C448825BABECDE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250331143113.r6t5we52wp77qqjr@skbuf>
In-Reply-To: <20250331143113.r6t5we52wp77qqjr@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SN7PR11MB7592:EE_
x-ms-office365-filtering-correlation-id: a711c2e1-4fa7-4ebf-7127-08dd79578fec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bObASAID6SxWHnCQdmTQMoWi/bfrZNnyDMbi70iympUbHxZPdxBt16IcZ9bm?=
 =?us-ascii?Q?Jh/hyPsq6S8pqFiohzooGQ154kjyf+Sl1aMkOhKzdRCsxBeCnWIydkPbtw/6?=
 =?us-ascii?Q?XO+H0eQEmDfkjROehLXft8RZ4++6m+yaZhF6iL2PMtFFHwR2h8kTMBBth2XE?=
 =?us-ascii?Q?wHJcFoVIaGJB9T0J3+8iuwBsbDqhk5zU9Kyi0oxfG8kSULxaxIfUcJqNCiIk?=
 =?us-ascii?Q?BQdTCfki4Htq5B15vpvWGM7lx04jR2iX3aPTFOx90fJ7cBEvnNgtII45eqM0?=
 =?us-ascii?Q?5uQb5rPKDlQvna50HGklkVrSTewos+o1CsVmNfDXGTYq1To+OShhc0dgfqGt?=
 =?us-ascii?Q?EGbPMDQUhahQv7qfsnEYQY6M4eZU7CUyzSVz41EkhumJgkongF6p00fbb0bY?=
 =?us-ascii?Q?mcSfO4+iuSciB6NaKpGr1m/lQD65DeZjKUgEI692ved8W0Q9xRRG38LY//+b?=
 =?us-ascii?Q?xfqNoRsf4lFRrE84U/3sZIP+2EGvON6FV9/1ayricBnK/CsAh13fToed8ebn?=
 =?us-ascii?Q?EOxtdYX5E+XWjDoNDwgvXaNnbqMZyHsw88oRxFr/v7OQ9EEqmjNfJ0Ne/BuO?=
 =?us-ascii?Q?o1i5glbdIsRShhHY/cCqSOh5kozqAY/oI83DA/e2x0/EPfwll5JAuYGTNmbT?=
 =?us-ascii?Q?4O5W7aIvAng2LoYt2pmwxgrU6tD++UvPHiigEmXZzm93HnEcYXsgbUWX07w+?=
 =?us-ascii?Q?VJOVWT0Ojggg6zWFyrirEx6LScPHr/drpPDS1SGN3zBbIjsRMIzmZIHoflKA?=
 =?us-ascii?Q?fW/XdtJC/F6IUzaiKNwu95xuJmdISKIHtIY8Tkr5NL2fWMV97El4IATb871z?=
 =?us-ascii?Q?nLSEr/qPJrWU+wXvbEoAzb7Ga0vYVMNLPZ5s86SwM10A/B6o30pylyNI+Aln?=
 =?us-ascii?Q?ejBIUDCxbhkYFffwi2ocrNpt+UrjuJ2wtP9OgF0h1RQKocDZadjw1sMgBKD0?=
 =?us-ascii?Q?GZrfaJ9UAXfHyZQ2lAa43eRWtbK3Z+WxicsjuNYS16ka9gi9w5n5IaubbDTm?=
 =?us-ascii?Q?uewh/qqCLR6ZHUHtv8Dr5dHeUSGA9rYnTLlQeGWkeVcEAGhwhY7/7fdHMaVG?=
 =?us-ascii?Q?8GUY3+yyrgCFvLQwqnaicnN14UBsSpKomVLzaDXKLR5aqJFLmKXWccl2WQQi?=
 =?us-ascii?Q?LvZAwxXASRvVmUgj3/cmvcgG9Sm3L3LNfDUAHwMULMd2zFCl6oDz9MZw8pv8?=
 =?us-ascii?Q?twfwNnwn5jYG2135PR9XiPffYYjQL2F1AugVfIEbQ4yCzaHyZhCk1Pq0BHJW?=
 =?us-ascii?Q?m6fu1p7/rmj8AMxr/pPcEM4DFztupk762VrJd40f09MKO2untILozn3iLtun?=
 =?us-ascii?Q?F/03ozEx8JJpFHlJTED05HPawxAbIdhzD7bDqV/TvyS3WX0W40d+/VbRV7RB?=
 =?us-ascii?Q?mMPdimuUuvcMPoM9MKlBJd46sB2Ey8Nfka1UHI8OrHXfIATZD1VC5ybeptOW?=
 =?us-ascii?Q?MihedHs/U8tIP5tYQNz56W4vlOA/sHye?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vP2HGOtc650K48je7v2/qEWJEz9Ef2DqkecBHXWE3Zm6yoKVGeFMfdyC99kD?=
 =?us-ascii?Q?zHPQC4+xn51hWqBM/2cm0Ecr8pvi7uZFf/YPmZt+K58jOokN6dmJlg7npZVU?=
 =?us-ascii?Q?pOYBLg9Kl/r9OcMeAvgrQAWyo3h0dCgmNwPdHYSZIEEMWLsi0Ba9piMkM96k?=
 =?us-ascii?Q?yQYHg4OhwpeCCiyIR+acpZ4v0w0oUl4LuTlO12SrGbds0cXmbLF2lRONNK/W?=
 =?us-ascii?Q?hX2VwoYLaOYIPhP9NCS0EhiSmDVwek9/Sot2+CGlDahvsg4SZBHxxFDiwP22?=
 =?us-ascii?Q?zMQg/PnRlTiifkex+FaqQh3SPe9C3ynD0sjKaILWaXmtY1uV8hk90AyE08Tc?=
 =?us-ascii?Q?uu+7qrxr1nAQHQN5BwQFzvPiIsbelTyQcZQe7rWnIQVNOHzShXQFIjUZ7JIt?=
 =?us-ascii?Q?oubWyfQv9RAxqbuqyb+Ys6RhdAOF3z9esVH98tqw47jNxVuq7FdrsdRc8lko?=
 =?us-ascii?Q?iAH1r4KDCVj+PZpoNVAkmDpaYcWXBhoNB+8N1bq2dyR1+axDPiqQYg8dC5ul?=
 =?us-ascii?Q?4k37uOTEHGd8EP9QlCkWA4/VfYZeo7AJtUGmKhleWOSuRgyKM1v9U08fkp4L?=
 =?us-ascii?Q?txVTl7BEoYF5HC9IlXbirO52ewQx6f2ybqBKcRRCy2AMmfA5A/ku1By+EPeq?=
 =?us-ascii?Q?a6+mvPaHi95i6SfsiBXInFyo9e3Q2ciBl2VHmTnbZ61eicNgCDxmcwj4Ut5A?=
 =?us-ascii?Q?kVxqr/1VvWWK9tv7OczjJMGVWaEwYNDIqpObwknu9s/8ygZube5knV4SV81u?=
 =?us-ascii?Q?X/2nl/+9t680OZm9EoFYn4LAH5zoHiJkXpz9dWFun4YMiisBjYHaeoUFML9X?=
 =?us-ascii?Q?84E0hsKyEmxSDBlKVWb7x6BJrtcD3qyS37NjZgbeeH2Qy8VE6tUwiWKqNGFb?=
 =?us-ascii?Q?yyxW8XQvlYHjBRDxzKdFYUq3MRpn4WoUt62CQUSCbv1q4otyg2c0CtIbeJ03?=
 =?us-ascii?Q?JTeiQ1eQDUQkcE7rcxoa+l9YSc/TWVDfADoJ6H3Ig0ELjyXqle8DaHIxkydd?=
 =?us-ascii?Q?/6YzSdxFJnESt55wsh4Wi0vzBr64I0g57lTsy3852RhEmHFWXYmTy/Q+oI5Y?=
 =?us-ascii?Q?LujJxCSiYCQrq2qnNDB2ktrfAbqf+RB6/sufb6hMMHy/4nM+lHJm6Sak3Ciw?=
 =?us-ascii?Q?A5l14+exb8vxoQCX0fHnn/YsLESSpH70zOUrT5zZg1nllJ1Wzw6TzO5jfOII?=
 =?us-ascii?Q?TmLzp02EfLVx71lat/EL2otpreduEmVLnOklcCjgJbHmApKTjJRw0Gq2t1XQ?=
 =?us-ascii?Q?EYIo1LfRS59KbqI7dX4h3C91651ix4L2lQBkBOEJ32zSJolee4pyIWcWgdyg?=
 =?us-ascii?Q?5lz2QyKMIKfRR3bcT8PoCRuovsbSm9xKkrpshHNhH61JlSvN+FazieUpTzRL?=
 =?us-ascii?Q?AZ8dX2sSDKZJKgpAXDZTlwEPu6wA48tFIGH+5Q63Koq0Ms8AQXnfQds1xMLJ?=
 =?us-ascii?Q?4s9nL7folr4+wrcqQ53ivBQ/SvjnSEy7pgjN3N6laMKkXUqlq9GQqZo3p4XD?=
 =?us-ascii?Q?axj0kOcuETQW9wq2k98WNmTlIM0sSZqdvJsRlAZLiZ6J0PNOfarN2oJwVq/H?=
 =?us-ascii?Q?IC5exk8PrsOG/XiUM43eBTqQ5b7a44G9jTx8RU5j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a711c2e1-4fa7-4ebf-7127-08dd79578fec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2025 00:18:33.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MSE4Ws0QM4ZG5g3TJgoKedyoP5qMynDACJLUjC+wPblVm40EZkzgOmgtJzonkBCGt6ZAre3Jfd1Cx1kFexYAX5+/CNPwQAKYfwV4cHzI/1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592

> Subject: Re: [PATCH RFC net-next 0/4] net: xpcs: cleanups and partial sup=
port for
> KSZ9477
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> Hi Tristram,
>=20
> On Tue, Mar 18, 2025 at 07:59:07PM +0000, Tristram.Ha@microchip.com wrote=
:
> > Sorry for the long delay.  After discussing with the Microchip design
> > team we come up with this explanation for setting the
> > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII (bit 3) of DW_VR_MII_AN_CTRL
> (0x8001)
> > register in 1000Base-X mode to make it work with AN on.
> >
> > KSZ9477 has the older version of 1000Base-X Synopsys IP which works in
> > 1000Base-X mode without AN.
>=20
> I was unaware of the existence of such Synopsys IP. In which relevant
> way is it "older"? Does it specifically claim it supports 1000Base-X,
> but only without AN? Or if not, is it an SGMII-only base IP, then? The
> two are compatible when AN is disabled and the SGMII IP is configured
> for 1Gbps, and can be mistaken for one another.
>=20
> You're making it sound as if "1000Base-X" support was patched by the
> Microchip integration over a base PCS IP which did not support it.

The 1000Base-X config word is sent correctly by KSZ9477 and link partner
can receive it.  This is verified by changing the register MII_ADVERTISE
and observing the link partner's MII_LPA register for the same value with
additional bit 0x4000 set.

The KSZ9477 1000Base-X AN is broken and requires the workaround mentioned
in the app note.  Mainly the MII_ADVERTISE register needs to be written
once after PCS mode is changed before restarting the auto-negotiation for
the config word to be sent correctly.

> > When AN is on the port does not pass traffic because it does not
> > detect a link.
>=20
> Which port does not detect a link? The KSZ9477 port or its link partner?

The link detection issue is for the local port device.  The link can be
detected properly, and the interrupt can even signal the link up is
completed.  It is just the port will not forward traffic as the link
status is not passed to the local device.  Setting the 2 bits mentioned
before allows the port to know about the link.  This is just a side
effect and is not an intended design as it is really the hardware's
problem not to pass the link status to the local device.

> > Setting DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII allows the link to be
> > turned on by either setting DW_VR_MII_SGMII_LINK_STS (bit 4) or
> > DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL (bit 0) in DW_VR_MII_DIG_CTRL1
> > (0x8000) register.  After that the port can pass traffic.
>=20
> Can you comment on whether Microchip has given these bits some
> integration-specific meaning, or whether their meaning from the base IP,
> summarized by me in this table taken from the XPCS data book, has been
> preserved unchanged?
> https://lore.kernel.org/netdev/20250128152324.3p2ccnxoz5xta7ct@skbuf/
>=20
> So far, the only noted fact is that they take effect also for
> PCS_MODE=3D0b00 (1000Base-X), and not just for PCS_MODE=3D0b10 (SGMII),
> as originally intended in the base IP. But we don't exactly know what
> they do. Just that the Microchip IP wants them set to one.
>=20
> If their meaning is otherwise the same, all data available to me points
> to the conclusion that the "1000Base-X with autoneg on" mode in KSZ9477
> is actually SGMII with a config word customized by software, and with
> some conditions commented out from the base IP, to allow the code word
> to be customizable even in PCS_MODE=3D0b00.
>=20
> If the above conclusion is true, I think we need to pay more attention
> at whether the transmitted config word is truly 1000Base-X compatible,
> as Russell pointed out here:
> https://lore.kernel.org/netdev/Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk/#t
> The discussion there got pretty involved and branched out into other
> topics, but I couldn't find a response from you on that specific second
> paragraph.
>=20
> > This is still a specific KSZ9477 problem so it may be safer to put this
> > code under "if (xpcs->info.pma =3D=3D MICROCHIP_KSZ9477_PMD_ID)" check.
>=20
> If the meaning of these fields was not kept 100% intact by Microchip
> during their integration, including the context in which they are valid,
> then I 100% agree. But I would still like an answer to the questions abov=
e.

Since this is a KSZ9477 specific problem is it okay to just program those
bits inside the KSZ9477 DSA driver when the PCS mode is changed from
SGMII to 1000Base-X?  Then the XPCS driver does not need to concern with
this code change.  If a SFP does not work then it is the fault of KSZ9477
hardware and its driver.


