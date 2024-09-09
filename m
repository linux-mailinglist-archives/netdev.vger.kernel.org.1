Return-Path: <netdev+bounces-126373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80905970E17
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 08:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001D21F21327
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 06:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80121176255;
	Mon,  9 Sep 2024 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="37QDRQ/L"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC04175D28;
	Mon,  9 Sep 2024 06:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864422; cv=fail; b=oQIDA2DL5SyOC81cWP5GiQIgzOAkKFTNYR4Mt/g6JsvQIr5JO0XNy/rMlvKSWjJ7BT9lw1hrivT+f1hN5G7AwVMrdEQ18HCky37HqC0s02fDWX/S8le14AAnWl2zDKKqqG6drD/RPUIxU2ZYIvKakrULz6omsESXCh9Rn0m//0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864422; c=relaxed/simple;
	bh=e9dCBX8IxRnRY+REbmgrUORub35odPz3qmNbDqBIF60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qB/EaOua/3iR7RXeDxYhiA+Ias451i68Fp46E9AunZaQxbU405GQWyT1PdiPHuk29cI47AMDWW4Ox7+6syRAD6dyAW3Xjp0jfSo1c7129GLvcYpSNSoOUsl4PwwJSuOdl+f7G5WrWW4I9yMjSJ94zIodFewUuSSHD+50BRuOhyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=37QDRQ/L; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj1NRsoWvsv6ljQzE8mCQZ5K5Nw7GXh/3osvLCKA4+osxpKiRivVDV//hbvbdaluk/Ai0O58zaJyyVHgNMR6hp4mMQT8KO7E5weJmyHz889A3xuJti5LymLEckXSqFJchWUgcG71XSyMy2T/wDXOkQ3hl1TFigyHlhycrueCBOSHMlk86EoKLOko4gs1rGfuxAyArmdRJxNfNV6SCywkhDqnY9RIABJeDRcGlk92MQznkSKktK0PCHsZ6lpZck+4b+dQ3qfjX4K009YH0Hx0/9DBf6batEeEccsVEpWtp9+aPcOgL5K+PqeQvIAau8YBgY8mLBRFdcz+uy9kGhBmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGGmhfxAN4pRtrILVYWOXm/5P2ELJ6ZEgPu6CfOfhhk=;
 b=XUtuBAlazkJDtRgjS3JtzXVHCX/2wsnriMYKVYD6y/ahnymtm7UiocqZfhGIkss6zm1Hr2d27oItTgmCn9G0/uWc80t2xFVU7Zl5MSm8ZVJifmfquWjFoobXHYbe+SCK+OxRXY+OZ54m7VNnkDJoTmg78MhGMWciOd4C5c3FYc34D4sZiD6hj0Bq0bBy+18SLDxQOV2fGRTs/z6xszsKM02WwMHVUKHTX0jF0bLaiFMowoh5P4aEhbpEaVVSF9KavRWaUugyLHax50ZcJIQiTbF+i3GtZVUqO8mAQi2KHkhlnCMlgjKuCzy/bFEwkqxCXO4/0fREAdxPMLUBo1NHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGGmhfxAN4pRtrILVYWOXm/5P2ELJ6ZEgPu6CfOfhhk=;
 b=37QDRQ/L33fl4AIxlrnTLsfF9k8HV3TvRu7xP7pTW2UbK7bDaIObZnWq5wTb6UkssQmBRb0r1JwJyZV55ufdGih+tGRP0TRYPVKmjkAkxWPusm1oACNOcrcfbu1zGWH5jmYDMWu9ZB0flIU4R5tVdNrlpESTCaQ8JnVsGNFSSFmRhJhb8ubPhTHrJjWjQEqYgI0uRRyoNrAYNVzzZWUpMqWHGIfDtmPO/3MFAwy45x+AZVqLWd/QoSkN4kVRobd7lRl85ssr2MAeJMVaPNLNU8S0Vz1z8RC0r5XZ93EjCB1Nzg0iXbfhlMCqaSWwPdwtWwq/rMB9k4auMsZdxl14Ww==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 DS0PR11MB7412.namprd11.prod.outlook.com (2603:10b6:8:152::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.25; Mon, 9 Sep 2024 06:46:57 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 06:46:50 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Thread-Index: AQHa/rWByazDEsACsk+UoLsvK/nR0LJJI7UAgAEMJqCAAItpgIAETWbg
Date: Mon, 9 Sep 2024 06:46:50 +0000
Message-ID:
 <DM4PR11MB62394BE8D22B85DC9FAFC1808B992@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20240904102606.136874-1-tarun.alle@microchip.com>
 <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
 <DM4PR11MB623922B7FE567372AB617CA88B9E2@DM4PR11MB6239.namprd11.prod.outlook.com>
 <af78280b-68a5-47f4-986e-667cc704f8da@lunn.ch>
In-Reply-To: <af78280b-68a5-47f4-986e-667cc704f8da@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|DS0PR11MB7412:EE_
x-ms-office365-filtering-correlation-id: a3185b32-2afe-47e4-8ceb-08dcd09b2f26
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GU/t1FCb4+omOxPvu9kM4CvzZGSJsUd+KWFb2OAy0zDc018wDkNnTPTnnO62?=
 =?us-ascii?Q?dli6+hpz9z+a3LCyHXe+sDEwFWUQXnA/2UiMRSE19BXQODL5cEMBBXKjMQiP?=
 =?us-ascii?Q?uAVTsu3yJWG7JR9+n20+s35M7qmrsm+Seaxinrxw98qvud1ZKkJq8lOlm5Gz?=
 =?us-ascii?Q?cNCcFm1K7+YkWdCcVchTUw3F3/DuXyCdbKWTxVJu+RRyca9e+AbgVLYH7T2c?=
 =?us-ascii?Q?Na94yNDKTKF6E5MjGngFi+3ncG+tprqU6ZxLOWWxOl3LHbXS+Zvw+Cqhcbfr?=
 =?us-ascii?Q?bMvQcbuSfEOxc7BsZLbsRyHbOglYINsD2BfJkbJmSrb9O+U7+29lCtvMOEGo?=
 =?us-ascii?Q?L5a/HLhiLQhyR2yglZycTjxtu3qLtMv9VPbMcgaoK0bObWIipnec5Km1bvHz?=
 =?us-ascii?Q?blqeXdFxWlN127ju/phKvN5dOgzdopTjRScXz0kRhBd6Fq+/bid+LnLVG9wr?=
 =?us-ascii?Q?1ZpCiq33E/y3vD/nijDYDo70bxET6DjgWp1fUCwc86HUpxSYyyA1rQ3MtAOD?=
 =?us-ascii?Q?0DIHzVG18r7HJxHKLB6kiOQCYnD7jnX6KVDLYd8s7dzdCm9yU0e/1FtU7l/f?=
 =?us-ascii?Q?/Jsx/Y1HmCIVJzv4I2Gugctht/XL7smxv/BIojDhk5TS9uJoyTVE/PmBd+V2?=
 =?us-ascii?Q?prU2VOynq8NWgvXthKuUjZQHqeG0tl+FLyn+Qii2vxTU6uzgYad9bPVR+buj?=
 =?us-ascii?Q?15+S9NYJlitExlyGlUorAEAw1ckb8aghGWVDbZ9XarKJ4WJYYruiYT6Vhg6S?=
 =?us-ascii?Q?XC41JfEZdGQTCV+Hjbje5JeZ4WQ2QhaWN2ulqejR9FiuV45uHG53AJEJSf2E?=
 =?us-ascii?Q?MAVjceaTD/a4dJFmhTcNEHe51PvjkvF8CCcZdOElkGsLhoF8X+5E68ibFIu8?=
 =?us-ascii?Q?BXILdVLwpo4K+lSeTp1yigo1SHPa5NU54g0kXjnnFASUvAR9vN2XD8vWdLbO?=
 =?us-ascii?Q?7K1R0cwrAUlmJrUPfibGtnRU0OXGM+SoThrSyUAyPKz4R7OGaRNn/z5L3lgp?=
 =?us-ascii?Q?qZyXU5Nr6kJPgpoDri0kFjIDpe96LPcXb4j47+mD8mLytr2lt2LZQ+vsoRwZ?=
 =?us-ascii?Q?ic9y94/z/WpuyJ26J2WAM6/UgG4JP01JYLne94Qgo4+RqeeAf+UAuAxjUl6C?=
 =?us-ascii?Q?kKgUCmTbKahChn/ITBhTL4Xi704bgpzzmpeFmoqn6kvtb8ogdwVHxGXwXUQm?=
 =?us-ascii?Q?GBDx+2Joiru2Ynxg5+GoZrROVHLiv76m/rphnkb3kimsV8hM20iSSqHsC4Zd?=
 =?us-ascii?Q?mCXS1anvQJwieaVuhRGDXnIIFOMtHpVeLtQR4bIyBG/FG/PW5KUdPR0zsloQ?=
 =?us-ascii?Q?HfYxgbXTYufb1fnjESDC2cWAiNcVqeMrl2u4ipMzZR4GfgXiejeQuIX13sZT?=
 =?us-ascii?Q?UHYbw0SdfBOY2Z62GFyaTwS+0VVw4UhqBcjSC1F2R7RK0/qKCQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MKvoN/PolYwaR4Wqlwq+qChp1wJ7jHVTLUvXbbEhXCWZL2B3MMPN0xYc3wt3?=
 =?us-ascii?Q?laOkmE1ytLIL3bNdG01X5HOU94hKvi5+ltno28J2XEK9OSeNgMWM4SMm145a?=
 =?us-ascii?Q?jhL3KjUP57qGHOlcBE0hyTElsZFSnaxGVDWqee+He80XwuBuE++aevtf9skN?=
 =?us-ascii?Q?FmlkjRWWxmw32GU4Qyo+AOfpZWf35RqP9Gikzlx1FFxKVSNMXXggZ0HVHtGY?=
 =?us-ascii?Q?/2P1oK6FTmoEKuDCkLYroBGBNwfINcQcnrCci4vn6q7tPApbmc7qW1oKxbVW?=
 =?us-ascii?Q?9hO79zWHR1VzfGUSkyVIPRHl8oESUPyTnd3X4K6yi0FBxGAS5uOQzgmu/l/q?=
 =?us-ascii?Q?50D3ezJzWGaL0VZRI8EH5s35MPAApyOCb7AbM1EdD7QmQwYKSyJtWIQ4evZp?=
 =?us-ascii?Q?2EnBoDrcTuPISVe63tAgb2FeOeW02GLCk8808iQPzhAl0NJukvocsm/+6sGk?=
 =?us-ascii?Q?PWQs1/ZYmQIVuUOPkw7m5bBEFP8neaV/eyih4IZyz3j9KTdQ02/NmiEWTEQ6?=
 =?us-ascii?Q?N3Lm4bi020R8wps5WoGxqhxv0yO/0n6QWW2PjvxviU3N584+rTw8JfWvB8zY?=
 =?us-ascii?Q?T5ovoQNCs2ANmNEhq8zRzP4JzSwa/LFZpsdVJWxW6R84Ga6QyEfBqK5me8CT?=
 =?us-ascii?Q?5qXVxd3U+xstaACjXTx/hEa5KVBSN86o7VGz2xY+TLIGkwXvav9y/aZ4jKG+?=
 =?us-ascii?Q?FavD38OKeclG2/ceYXor52hK7fBpyC9dfdgBpzfZYDRlszD1n59jO56qRh7o?=
 =?us-ascii?Q?vCnWMOBra2UxHDd4eyvnosFu2tN6hhsekEl/xjp0DpJ1N8SzaICI1CODr22V?=
 =?us-ascii?Q?0jixIIsjy+LyfaSPhwFStJtdME5n3HluGjUN+d79aGPYBVS1C0l8+U1FJr89?=
 =?us-ascii?Q?oXiRYAUK2EtkSGSGxKTIV1pUGwmbYFeFAtqXh4ydeglHVXTwAyamgZu1ImJe?=
 =?us-ascii?Q?yZBiEzcbv/xohmSjH/t9Fb1rPjMvbIsV0dNVkqr/E49kevj7T8M6YHXFnFsC?=
 =?us-ascii?Q?0o1laS1c0imms0uyJWyEPaB0x6k/wOjhW7PmTRBvMkB0N/kBZ6+Wuj9Uclas?=
 =?us-ascii?Q?LBlKMJNxNCZnerdM1LrobAWo7MMyBmr8jyfvtNiDJXNF2FW2jLQ6hZGF+l6P?=
 =?us-ascii?Q?5Yxc5xAT6J5CLNd+Xzj6tFLMba3i3l63LNW/xR+fbhaHHX06KvrK7ueMHP6d?=
 =?us-ascii?Q?/Hky5VG1b3n7UzzqFZUEpe7/GPHxExRvOHpgMvnhPIK20WiWuW10lFIPkFCj?=
 =?us-ascii?Q?7uqK623qC3d/86CyVykbe6p/+lxB47EUc5n9FPU8W2YnOZdSqZ80F67PtCCk?=
 =?us-ascii?Q?XNop9w0/LLYDAg91EHcjBVI5Lgf3uOUTcEw3oQpYX6Yyrs4xQ0ABFAXDvuv4?=
 =?us-ascii?Q?jAcEBoUyqTdP8c96SNZekGETLKf35BVxYO8ORNZG7snYrZm5Jm4IoFsxfUFx?=
 =?us-ascii?Q?yePKlu1ygtQ0i+z6S2klOWCw33G9LUqtN4uq/4wQ3Kh1k19SY+39lyaNGzwN?=
 =?us-ascii?Q?GOpsVFnTsA5Pdr1AmsSqVYL5aTUwBvTC917p7a9t4zafiUMV0jGpmw5y4zXq?=
 =?us-ascii?Q?1kvraCfpBg93SBMwKnlfY0heJGRQe5zE9Ddd7RQz?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3185b32-2afe-47e4-8ceb-08dcd09b2f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 06:46:50.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zF3I8Kx1ZR0hyt9p4TyAwk6XIUWyXXXjtsbpJN0RVJ55zoSx37EAhqENq91InAcSoN2pKrqvMhy2sHsfux8JifHjWFMSPrQCYjSlmJ+EqYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7412

Hi Andrew,
Thanks for your review and comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, September 6, 2024 6:28 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN=
887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > How long does this take?
> > >
> >
> > ~76ms
>=20
> That is faster than i expected. You have a pretty efficient MDIO bus
> implementation.
>=20
> > > genphy_c45_read_link() takes a few MDIO transaction, plus the two
> > > you see here. So maybe 1000 MDIO bus transactions? Which could be
> > > 3000-4000 if it needs to use C45 over C22.
> > >
> > > Do you have any data on the accuracy, with say 10, 20, 40, 80, 160 sa=
mples?
> > >
> >
> > Here number of samples are suggested by our compliance test data.
> > There is an APP Note regarding SQI samples and calculations.
> > No, the number of samples are only 200 as any other count was not
> > consistent in terms of accuracy.
> >
> > > Can the genphy_c45_read_link() be moved out of the loop? If the link
> > > is lost, is the sample totally random, or does it have a well
> > > defined value? Looking at the link status every iteration, rather
> > > than before and after collecting the samples, you are trying to
> > > protect against the link going down and back up again. If it is
> > > taking a couple of seconds to collect all the samples, i suppose that=
 is possible,
> but if its 50ms, do you really have to worry?
> > >
> >
> >
> > Sampling data is random. If the link is down at any point during the
> > data sampling we are discarding the entire set.
> > If we check the link status before and after the data collection,
> > there could be an invalidate SQI derivation in very worst-case scenario=
.
> >
> > Just to improve instead of register read can I change it to use phydev-=
>link
> variable?
> > This link variable is update by PHY state machine.
>=20
> Which won't get to run because the driver is actively doing SQI. There is=
 no
> preemption here, this code will run to completion, and then phylib will d=
eal with
> any interrupts for link down, or do its once per second poll to check the=
 link
> status.
>=20
> With this only taking 76ms, what is the likelihood of link down and link =
up again
> within 76ms? For a 1000BaseT PHY, they don't report link down for 1 secon=
d, and
> it takes another 1 second to perform autoneg before the link is up again.=
 Now this
> is an automotive PHY, so the timing is different. What does the data shee=
t say
> about how fast it detects and reports link down and up?
>=20

For 1000M this sampling procedure will not be run rather we use SQI hardwar=
e register to read the value.
as this procedure is only for 100M and linkup time is ~100ms we can check l=
ink status before starting the sampling and after=20
completing the sampling. This would ensure that link is not down before cal=
culating SQI.

>         Andrew

Thanks,
Tarun Alle.

