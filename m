Return-Path: <netdev+bounces-188845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BDAAF0B3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B041C24E4F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EC1ACEC8;
	Thu,  8 May 2025 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TsmTKKtU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6C4B1E6F;
	Thu,  8 May 2025 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746668476; cv=fail; b=MR3RIYzmQICaHPfolktczKD8ATOdGsXnAzVuZWtGxvVE/FTPJLb8S0CBUJMjKRYYJEBerX6l0vR801fQRwyjvTiY5vMMaKNYvI4u3jGMuUkB4/5Ze7hLVllyfyoRqxljKpBmF/bglCuUnyxffmH94Cp6rV0tNEzbjEGglsvhwFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746668476; c=relaxed/simple;
	bh=fmO0MmM27BRXlMbGAenyc6JS0GVrZJAMXq2ie9ZY7Cs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QBfGOxpV+GoDrl3UWCWWo7vfs+QEPjU9G+SSKWmUjJ1eXM+KrzvfiyRRL8sRxe01nDovX3VAl1714HjlBRpLAv9pze0SECpIpta3EI8FAGa08rJzP58RVt1wmFKKRKKNc8HY5NKATa8N942W06/dDNFaVZxRy3fuBCSatuWBe2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TsmTKKtU; arc=fail smtp.client-ip=40.107.92.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQxkZ+8cAl8ZeRNOadbJN/15eO3Ks8jfck4YFl3VqR1gecrDDNF6x7+FpR5d+DOW9c9mnYOiF6112ZFQ2y8A2cU9nmAbcT3buF4BHh1KdxQp5163mHfS8280IxTimor3E5VKyG09NpHozEFXT7ilR0SX71o4zmREMETi9nnhA4A0JD05EwbTkEo7MwYkVz86x3Wgxr4uguqMFKKf5B6bw8ll4lDnsI6sERJt6rdMFH2/uZ4pYDMuP8dtHuexB+JPIzY2jcnMNZnnb00+PEO9Z3qEptjkO2blPIptAZpAj4Ik/LlwFp/8fGEA8c3CpusESx4WhaYKqeCSb2nW4FdDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7o1YFzFYNxCe71AzQR8BNEF/VXyoabTAp54BNI4MMUg=;
 b=NL9gWyIF7jwuktN1naQomfUC5UpO5yhjyYjRHN7q4Q3oGq7XREUMOynZyi0LbFYa5yEn2G1oFeLaTKzNCpNc3BzxD/aoANltemn8+sdhRmCZz8guCn77drBCWU7IRxaK7rcBGl7xoko5Wk09fGogAQ+2TI5K3C4zwuNYrNhbKRLzeITlC3TN72O0ffbKSIotopdEE4gMhiuxkhS63pJbiNEvjq2PvyfhfHNQxydJ5mceU006XPdY0tM/+LJwHBPU8dDayEegdBReOx2bKB5sjyd1V48qMj2S+0A25eoBLU+p4P4pyYTYlY2foS83vOv/kyN6AExDYo+7exc6Soc5Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7o1YFzFYNxCe71AzQR8BNEF/VXyoabTAp54BNI4MMUg=;
 b=TsmTKKtUhoO6dssxpLnVVL+Va5rOvEV6veelbUHC+jCwBB7h0qOgv504EvJWdkMkqjbcwdA7vnEUv6OuYymg4izhlIIfDgyUKeB/mPUqzzaiEPh49X9c2L68t8BbWAFxLqoK5kHMgjI8b/5wqsrglwvXbBkDm0NT8Tbx52BdtNNtyAm7uWxdn74L4ecAq+LkQsxc46grXYxfsQGYP32Mj+N71Wr6tvFLWO9yxuUHEb2d4F1UpWJ99a+8qxkDRglllCYV5KiqUQGfFPRgAgnJHztKU04+guIW3U/IGSP3sXE9i6ZjAMYhNnkK4JWoOsltpusAfvLxZUs7cbRSE9XWNA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 MN2PR11MB4629.namprd11.prod.outlook.com (2603:10b6:208:264::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Thu, 8 May 2025 01:41:05 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%7]) with mapi id 15.20.8699.024; Thu, 8 May 2025
 01:41:05 +0000
From: <Tristram.Ha@microchip.com>
To: <maxime.chevallier@bootlin.com>
CC: <andrew@lunn.ch>, <Woojung.Huh@microchip.com>, <olteanv@gmail.com>,
	<hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbvuRWhyMLNrGLcE2+FvLjJXgIz7PGygmAgAANIACAAAZ4gIABGGwA
Date: Thu, 8 May 2025 01:41:04 +0000
Message-ID:
 <DM3PR11MB8736B36AE8B73C3804B08F88EC8BA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250507000911.14825-1-Tristram.Ha@microchip.com>
	<20250507094449.60885752@fedora.home>
	<aBsadO2IB_je91Jx@shell.armlinux.org.uk>
 <20250507105457.25a3b9cb@fedora.home>
In-Reply-To: <20250507105457.25a3b9cb@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|MN2PR11MB4629:EE_
x-ms-office365-filtering-correlation-id: e7b3e5e5-04cd-42b6-5995-08dd8dd1659e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qIurN9zF3Tfj10Um5YF45rcX7DGbWVarSf/O4Wh1PhrWxg2Wh+w9s8AMIT+c?=
 =?us-ascii?Q?1IKXc6HLC0I65NnS9uQdQUHO5c0OjgsrvfAXdsbUQzKUbF8Xb63b2xRZAIvj?=
 =?us-ascii?Q?OuW8ZABisqqzVhsGt5uk1pInUPaEgkHOtjlKzG5AHziQW6tkpgbQiO3e3va4?=
 =?us-ascii?Q?XzbTS5zuQ2aRlaEqjdSAjXCpntQiO++FPGhjgKadQtNj12iXd402mdFp0vtb?=
 =?us-ascii?Q?0roLob3KjIscNtzn/uJkn+wjxsaRw8rHqorWTJgCiKOC7bhZQeM+vtLb6cBk?=
 =?us-ascii?Q?5Sdm71UPYA0hqq0GTsJVBSpFC0ZNHpc4NHFJjOULVoHcvkT2OgBETKnsIPRp?=
 =?us-ascii?Q?OtNQackjQYO4PIquCwuy84zIdSu1NwgrllZujEmYn94rHAqiKB2kkNtbAr55?=
 =?us-ascii?Q?/sgPFiBIH0wNbgYxPTO9PECvjHdtulnAYDq+h6PnXBFPvQXHg00qDWc9Mz1q?=
 =?us-ascii?Q?Tw3n81Dvs2uREW6w6zc9A/JXuFwUcloEoOAEERRtsYYgfNYzi7bQtM86p2zo?=
 =?us-ascii?Q?O5foyGaAIEoCY93xFlTr9eamxWsr+cpGfRUNMyfusRJYn9caGdEB1B5XJfvV?=
 =?us-ascii?Q?XB1Vu7XBvHo8/KuBM588W1wu2g1qXwmqfQuLfwXVLituyziJtLhRaHR+etB1?=
 =?us-ascii?Q?2yVYiTfzZvZ886jZEYRz+EG8vF8IiP5/VueLrdbADlAhD0CjzQbfbnMpyygX?=
 =?us-ascii?Q?otGHsA472M/eVxuWR4kIOzLHZ8bVAO0NbRJ3/pE3wEsQiV6WyBc2mDhBtjTh?=
 =?us-ascii?Q?VHGIytcGoh7b0KtvEFLac8Gs9MWfe8irUprH5Wtq7C5uv/Ep1rJgz2CLp8me?=
 =?us-ascii?Q?6onVLGz0NCTOkJtCg2fuqRyWm40o28UW75zswG+SIhMvg1Ub5bjODoQ6S75+?=
 =?us-ascii?Q?+nwXA/31FR7+Iv/cmkVUW1SBDdS9sVJh0QeNMEaIfmUYMUDTjD6S1WAQeH8F?=
 =?us-ascii?Q?hHskqnkmD4ezqFUC4RHiNKIPUGQPkaFC3NWXVfHkwEUie4q3rTLa7jtPd904?=
 =?us-ascii?Q?ddrCHMbqXBUL+NApYUB41Kk+Ec/1wwvJCJWeVbDa8NdIQrsT2nBv6cdJ9UFy?=
 =?us-ascii?Q?P81zq9ZlPssU5MxKNeXC05Z6v/4bwb9OXQe2ZZgwUShK4UpkvtV1fRdsol1Z?=
 =?us-ascii?Q?ovDDGnb/Jo+TzrV1Kqf6cst786VVguDV5vNg1qcI/KDZ5vDP2yhTpLIcizlU?=
 =?us-ascii?Q?cm7Q4oUdOIPBDBrq+OyFB4bZVQPVlwiuCYL3BcwQWX7hbkLidncXkHGjjIOj?=
 =?us-ascii?Q?31bYDhtzLBnBVZUSRmPfOgzYw7uo5eAfXa9RMSsKtmXb012csE2G0H5sw2p9?=
 =?us-ascii?Q?39k5AI2KdF+saFeYZHROcimeBIbo93tx/NINJbJM4wP3JqHqCrQKm/oTQiuV?=
 =?us-ascii?Q?PftkTzNSN/LZhYZlLcONs2n7txhohTsy4ei6/YgBouF5GFfYnOtmAShcp40G?=
 =?us-ascii?Q?PyInn6z14WM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yxcqd8FtkyYU2kSPD6qFi0hvwCz8RXz3l/sRQPmhlascG5rcjC/DJAZl/VOz?=
 =?us-ascii?Q?7vGI8t3HiMLcSDaRX9wx6Rq0xcsQzIiHIKLg6jwDTqxkST27AWC4defWwDEZ?=
 =?us-ascii?Q?4zBtaHPRbvshEicrjelzZX4st5pXOxwdSF7HUyEwv4LBbFcUZXxcZ6xAnQIt?=
 =?us-ascii?Q?HRqoQiX5PfhF5XbQd6gucFO8qgpQET+OZzQif7/LoCyiSo7egN+3Xd4PoEHi?=
 =?us-ascii?Q?e1hFOnSG+6wgIFQCBT8sBTrzQVO5Yt45lRfcq/8VsKo5Q40enpzRSVBxCjLh?=
 =?us-ascii?Q?pn0zIk1N64fp5yHVa7O4xNaOjnqVInXl2oQcTnCixMJpypfWgduDuHyvnAfR?=
 =?us-ascii?Q?Lu1HspfnTLFL/2dsS2qd7wUshBKnLIj9IscRKpkS0OpEfMwVqSu2nerNmCH8?=
 =?us-ascii?Q?rX0V9w6JGkPFLv60UImvJKNqS6dtxeqL9q386bZXZb2B+Gf3Yc8EcWuyJ2jh?=
 =?us-ascii?Q?Mm9AxUx2FhmxUKEJqabXITKXWdts8JxwQlJyjAYCEgyCUs2upv8BrJtGspXI?=
 =?us-ascii?Q?bhZizjVtstn/6NNEVuAI2x//O5z+pN8W5eZX/nOXEIUjjhtVVCYrbERbN/ZI?=
 =?us-ascii?Q?U3qOmBrcoGQSfWgFVLD9TKxqFkIGL766ayyKEnV5lskG6k77Weidr5ZhPhxq?=
 =?us-ascii?Q?e2NVd3CWwsH4KWigibgtA+eFHrdfrwsaRRs6ek6BfS23hFALn/kUr+bpwjjA?=
 =?us-ascii?Q?DKK0W6a6qY5Sq3Ym2DUo+9QF00+UKii41pTwPWeCIcYLnQFYZWtNCMjLEnDI?=
 =?us-ascii?Q?WfnJ8TktzILV1AHSBebZ615WBBEVmcwjlRpTnBQD4I4EXgvRZ+/g51Cw2Jti?=
 =?us-ascii?Q?cWejoW+IwsMR1cCICD3jVkGJtCeJPAHGR914227foyhopSF7JCswnjkTHyqJ?=
 =?us-ascii?Q?IXSJGPZIuSBoOJ9Ml5v/8ktbxw4iJlGtfbV+KtjMVof17ElUtVIqtf/pIt4b?=
 =?us-ascii?Q?eXbJMXfMAxGMzVS28CuYh7vf+40j8hcKV6uhlPCrltMO6ONReOUt201BsYb/?=
 =?us-ascii?Q?KnEadMQZKSyxsYLEtI8S4BSojZYkSeCliV04ofStEw3j8wq6ckNW7ff6KgQP?=
 =?us-ascii?Q?8FVa2XspxQAg9AbCOneNx0YnLoM+/JIb38s6UGFsAe47A6i3srp04cU/TXqA?=
 =?us-ascii?Q?BxfSGsNfKoQC+0Wfj3egLPQHW/2EPa1RcrnPCg/YmJ375zrRoBOOjPk6ujwy?=
 =?us-ascii?Q?9anbYF6RR9WDnLeR1xr7t4YMm3aqgUhVt7HCdzYKhOooC/ZAaQanesoj5zol?=
 =?us-ascii?Q?a6MijBX7S8CptrcoHDHfzkuD7JETgxPzRwib4zmVorKt6tb4wWpdfBrCaJFf?=
 =?us-ascii?Q?UVnsNi+5nXFi0F8+/DVB5bgP5cI/L65hZ0nHJ7i1WIOq26Iabs7Q0LcdA5Gi?=
 =?us-ascii?Q?GhJjbqwvSTmApHVLDBJZvuJOwkOQekfFJYa3AkbRmGFRu4WBNGc91nhalL/L?=
 =?us-ascii?Q?5bzMmYTCRcuFIcFtsc8/RBrPWMf55auVGy6NkK94ez4UFa2+K74TOl1dkF3H?=
 =?us-ascii?Q?+t5g5qyK33RFzCOM+Rf6CX4BhdHYu//gEPgRbQoGc4hzwGYkjHryhxtX/rt1?=
 =?us-ascii?Q?9zk6uOG0yuJdbTIyIhtQZiExr8Cl3B/SEGMUjc0X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b3e5e5-04cd-42b6-5995-08dd8dd1659e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 01:41:04.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /boVjslsGOLT1/h1MUIA3YpfxRy9TlRjQxUXTAn1a64iM5ev8joza979qFd43lEuHZxA9f6CZrk+YwMde9hq62y50gVNrN2ImVvDnm18V6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4629

> > > I'm a bit confused here, are you intercepting r/w ops that are suppos=
ed
> > > to be handled by xpcs ?
> > >
> > > Russell has sent a series [1] (not merged yet, I think we were waitin=
g
> > > on some feedback from Synopsys folks ?) to properly support the XPCS
> > > version that's in KSZ9477, and you also had a patchset that didn't
> > > require all this sgmii_r/w snooping [2].
> > >
> > > I've been running your previous patchset on top of Russell's for a fe=
w
> > > months, if works fine with SGMII as well as 1000BaseX :)
> > >
> > > Can we maybe focus on getting pcs-xpcs to properly support this versi=
on
> > > of the IP instead of these 2 R/W functions ? Or did I miss something =
in
> > > the previous discussions ?
> >
> > Honestly, I don't think Tristram is doing anything unreasonable here,
> > given what Vladimir has been saying. Essentially, we've been blocking
> > a way forward on the pcs-xpcs driver. We've had statements from the
> > hardware designers from Microchip. We've had statements from Synopsys.
> > The two don't quite agree, but that's not atypical. Yet, we're still
> > demanding why the Microchip version of XPCS is different.
> >
> > So what's left for Tristram to do other than to hack around the blockag=
e
> > we're causing by intercepting the read/write ops and bodging them.
> >
> > As I understand the situation, this is Jose's response having asked
> > internally at my request:
> >
> >
> https://lore.kernel.org/netdev/DM4PR12MB5088BA650B164D5CEC33CA08D3E82@
> DM4PR12MB5088.namprd12.prod.outlook.com/
> >
> > To put it another way, as far as Synopsys can tell us, they are unaware
> > of the Microchip behaviour, but customers can modify the Synopsys IP.
> >
> > Maybe Microchip's version is based on an old Synopsys version, but
> > which was modified by Microchip a long time ago and those engineers
> > have moved on, and no one really knows anymore. I doubt that we are
> > ever going to get to the bottom of the different behaviour.
> >
> > So, what do we do now? Do we continue playing hardball and basically
> > saying "no" to changing the XPCS driver, demanding information that
> > doesn't seem to exist anymore? Or do we try to come up with an
> > approach that works.
>=20
> Fair enough, it wasn't clear to me that this was the path forward, but
> that does make sense to avoid cluttering xpcs with things that, in that
> case, are really KSZ9477 specific.
>=20
> I'll try to give this patch a try on my side soon-ish, but I'm working
> with limited access to HW for the next few days.
>=20
> > I draw attention to the last sentence in Jose's quote in his reply.
> > As far as the Synopsys folk are concerned, setting these bits to 1
> > should have no effect provided there aren't customer modifications to
> > the IP that depend on these being set to zero.
> >
> > That last bit is where I think the sticking point between Vladimir and
> > myself is - I'm in favour of keeping things simple and just setting
> > the bits. Vladimir feels it would be safer to make it conditional,
> > which leads to more complicated code.
> >
> > I didn't progress my series because I decided it was a waste of time
> > to try and progress this any further - I'd dug up the SJA1105 docs to
> > see what they said, I'd reached out to Synopsys and got a statement
> > back, and still Vladimir wasn't happy.
> >
> > With Vladimir continuing to demand information from Tristram that just
> > didn't exist, I saw that the
> >
> > [rest of the email got deleted because Linux / X11 / KDE got confused
> > about the state the backspace key and decided it was going to be
> > continuously pressed and doing nothing except shutting the laptop
> > down would stop it.]
>=20
> Funny how I have the same exact issue on my laptop as well...
>=20
> Thanks for the quick reply, and Tristram sorry for the noise then :)

Thank you for testing the code.

It seems the proposed XPCS driver code did not get any comments from
other people using different implementations, so I think it will not help
others.  Since the hardware issues are KSZ9477 specific it is better to
implement any workarounds inside the KSZ9477 DSA driver which is easier
to backport to older kernel versions.

As the KSZ9477 driver already returns a software generated value to the
XPCS driver probing I think it is okay to do additional register
programming with each XPCS driver request.

It is almost a year since the first submission to add SGMII port support
to KSZ9477 switch.  Customers were asking for this and there is a product
launch with SGMII port as a main feature.  Microchip management is
pushing for an official software support in the kernel.


