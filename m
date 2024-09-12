Return-Path: <netdev+bounces-127877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF5D976ED8
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF5728576B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D501B654F;
	Thu, 12 Sep 2024 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x1ROdXH1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717341AD262;
	Thu, 12 Sep 2024 16:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158972; cv=fail; b=ZbFroVHkkL9Q6drzqw05mlsvosrH3Bg3xf3CUEuEh8gO0Yf7hGCuyAug91mMohs/Ngh0adSJ+vQlZTidL2wXnGcXAJcdq8wpJQfxoE/h727UtfHuLix219fEdxrIpfZr2oud6aJ+mHGzQdRJmuulDkSAx3v9ZOjb1crCdWfhXN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158972; c=relaxed/simple;
	bh=Zq6PU9hACj3KBGbkm8qibNN4/1XzICfyAb9+UAMI8lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kV+gmlfgaCtIiznnORK7EhaujxTABaOm1JcbmgXYkPYY0NVzyLD0wU/ylF6JXJU1J44zMynE9/K0Zx///qzjEvzgSuIBaeQLXi7xzReiWMul6JsliyF9JX6WXoGeWnsolG9VDO97RP64Fs+Ut210H4tiHRKpAXwrZemv07KxP6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x1ROdXH1; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH+kFncMimfhsMzYj0TfWC8Indn4mipqZ03UaPEx9fmwRQR9aQhZt3sOwE4jKquq7tjKNrFrO0wX4QNm+viJUkTM3rPMZbz+qKk39/G6/0I6O0i068ns9pq/MdQOZ/4/zJTQIsHdc+QUGtlYU6dFBmPacCK3NXsKtg3mdDvOQVNgKd/xoYHm+XmfFq553pRZq/HLINtLMVn8riCi9Ecai1nh243pbdPPyrHfT7yiBaESwqZOYHeTQ19ZCt0bRlFkFGLqfCnAJKOfFqeDqzDfhKhV9q2875+kLj0dsjr9oi0/a0dF6DmRAFAGcpGemO0HO0xM/QUgB4/nNo2otYvR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgA7m0xByn/+LLF950yqNFSRGtedM7rBCP/zQSRSRVc=;
 b=Zu0W6pK3bGiagiU/UEwPGcJ19ln+h9S9Dn3wq2ufSaYaki/Wj9DWZc4lRo88v5INb+ucxLzSVJn2BLAp2zjndGvNn9JzMr3XQD0LrFUqhOLCixLix2srOSX5QwuqjdRvgCJ/TOv+Nkh9hQGioHuUvqEMdqxqIp4+HdtRvqJQj5nD61KXr0En2MMCjqW5OHUo/M1Ugu1BJRxB1LZy+Kf2nmM5vZcfnps5UjfN84GkhJ2SQnDttTy+iFPFeqvB6cLC+dB3+sFFnxq2NeydMw/MpVUBm9Q8YiN8dGzl7jCqlnml6wM7oENhvQV8PQSkGvgECUp16FChxiIeQdxZN8YkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgA7m0xByn/+LLF950yqNFSRGtedM7rBCP/zQSRSRVc=;
 b=x1ROdXH1tE8Z8IOU9ot7T3jBT/4sZ0eXvFHNQlPUQPIAm3xSuuaPKFrkigzUizbH66zsA61LtXwe2aOLBM4PDUT3nK7nNS6F00aQpMGAqwdZcn3DWvPuwoDol0bCWfTURCEPkxOyqZ2iUuSsc1Tr0TOG6YN8l1MFYcGrbZUjsp25HIeiq6f/mWto8hQgCy6nbFTONtInr3AVzIZ4gdA4G21jDbBrZrI72I0INCvmqC0gfKHeFVlpxKsJw6U1BFCATRjNm9BA2R1N7Yq73H8Gmn5HXeWoc990TbHrsVHfe/8yNOtr7bJfgIgcnY+GNcevaePuGYJ9ZqixRhGkFVHxsQ==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by PH8PR11MB8106.namprd11.prod.outlook.com (2603:10b6:510:255::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 16:36:07 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Thu, 12 Sep 2024
 16:36:07 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Thread-Topic: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Thread-Index:
 AQHbBGXGELjLauDUqEuTABaTIHCmgrJS0SWAgADgLwCAAIyPgIAACRTwgAAJYwCAAAOM4A==
Date: Thu, 12 Sep 2024 16:36:07 +0000
Message-ID:
 <PH8PR11MB7965DD30A84DB845BEC4070E95642@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
 <a40de4e3-28a9-4628-960c-894b6c912229@lunn.ch>
 <ZuKKMIz2OuL8UbgS@HYD-DK-UNGSW21.microchip.com>
 <e5e4659c-a9e2-472b-957b-9eee80741ccf@lunn.ch>
 <PH8PR11MB7965848234A8DF14466E49C095642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ad0813aa-1a11-4a26-8bc7-528ef51cf0c2@lunn.ch>
In-Reply-To: <ad0813aa-1a11-4a26-8bc7-528ef51cf0c2@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|PH8PR11MB8106:EE_
x-ms-office365-filtering-correlation-id: c6a0a041-ad96-4163-f103-08dcd3490098
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5OVZV9IaVlL4f9lwbXNT15MS1WcVCermFPNfEOw1Jg0uebR7S0XS8SIDSDof?=
 =?us-ascii?Q?0JHeRHWlllRgAJM8a/KQKI98jW3IakXk9fjr91A5caOrK0t5MDG+fiBNpH/U?=
 =?us-ascii?Q?aFUcAWk5kTFbqJFX0LITKoUrc6B7dR901+XY0XmFugL+FjTOy2lIgStcfGlq?=
 =?us-ascii?Q?Iw5OAlqEjIbEY1r4yiz1BzTrjafEZfMZcY5h6nuuyLWvZNoeRBCS/NN/xGvS?=
 =?us-ascii?Q?BLTabNShmjCWEPMd65a0avx3CNFm1i8p/sm6gN32RQUYqfwzWau5gFpmZR25?=
 =?us-ascii?Q?0CkVRY1LRVCOl7I/xP7olB8CrrPAiyBs5Xbiru5H4OnliXGMkl+uponw02Ls?=
 =?us-ascii?Q?DMuYn1l1O0cmIKHGJ26TIo5ipJEc6dlAPJMgjIAeZzHrXfIePE7ZaEJDVpUv?=
 =?us-ascii?Q?i7hkSxVtO8858ai4jmG7L3yKnXXqey1vbZ/Vd8KvKbZYOVa6TxYizjRihBFk?=
 =?us-ascii?Q?hLPWRTZgfK20TqeekMxEtcsBue0sMd8PXcodcWCQrIeP7e2XQ88vcBCPzX67?=
 =?us-ascii?Q?Htgf/TIR85T/4AKsMgYQubbPaHcwO+wJV7Lhv/F2lhPr78CJpJDKN/gGPZZs?=
 =?us-ascii?Q?HUMe32YzoDfnSIUnizXlb4QTpm+xwHUJby+gXZjlK4b5ZPcvX2WA95OfL9ZN?=
 =?us-ascii?Q?evSVh4OwhSCy9VzEN1ADqJ/Y5q/J2JYWNesM17NK4Sw8edwKDHjpk9hy8GCC?=
 =?us-ascii?Q?zmxFjQVk3LzEFMWr1pd1SXDHqVn0baOISMNLDDFXoPOQpBKUcJlEt0nztaVy?=
 =?us-ascii?Q?r2omWAdNBECCE3iHIjAj75YGY6c1Wb+luo959fuvPL1EtvmATnJF3R7bES5x?=
 =?us-ascii?Q?tqqKBQLdh+yi1WR0l4lU/Bx9q7uWnII3x04kkQPq6Hv3q/Dn0T5V3kTsQtPy?=
 =?us-ascii?Q?MX5SbkszGMO6ZYuJnqL5VQNxpf/o1iCm/G4rWaiF/k6QLXI4iVCqnJviGKxv?=
 =?us-ascii?Q?xLEH9auDgIulTEYS0y0qP1v53YgRSl1629D9UVjWo5ARckDmb/v6kI8tNdcu?=
 =?us-ascii?Q?KGd5zxugmRBI/qU/eAGfXntRA7cd5SPFX4LyUhM3xH4CKVoS7wVVTID9oLW3?=
 =?us-ascii?Q?LtkjaUzRoq1qorIjcwTxd2Lj06b+ZpMhqtzJurXO3Nk8v6+qbtZ66BAsLY5h?=
 =?us-ascii?Q?tPVSi5QrwO7E/joAg06GxfdN0lyIINVrm3nq8cWgx41QDYByVzfTFXf0aBxr?=
 =?us-ascii?Q?9LkTNpfB7MH4ubHI0S5R8vy4TiLxUUL4sqP+Gj82pzH9nZOi24xZ5MSr70+i?=
 =?us-ascii?Q?mlHVQY2MpYJYOWHgQIX6lVWRsumP52/qaZi9+BlNZ/XB/nxPKAt66jzfW8vh?=
 =?us-ascii?Q?PTpsLXxCHk1m8ralw4MvLM9rqgoz2Ia0Ddtu0fS8m5Eax+RvRXID8jV+Zc1T?=
 =?us-ascii?Q?4zGWRH/a4J+b6p+EkB9fr0+Jo03n6uV1FGjf3UOFMrdcGvpNhw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EsisSVwvxA/B8GdmcY+B79axpSkOo4QcTV+GgIG7SZk+dc2pRpfNaUsV4U+B?=
 =?us-ascii?Q?an8nMpHI0HrhX/zxk4UP1aFZ2A4vB1nptbd9eihj88a3lGshmPVVlg2zUcbn?=
 =?us-ascii?Q?ZAroGA48BkmL7piF+gLTnKC1LFlnc3kdME3LHMDftaxJQpV+OczzHvqedDBA?=
 =?us-ascii?Q?m05VziYcix3jL6HuzHRO/upJZkx0FLBQ689Rok/jcm859M63TxicW999Z3qt?=
 =?us-ascii?Q?Xjk52NVakG/F+yodH+z4DIzNVg5Z88FCvUS2WY5fTYHkaA91TJlDlaklsADt?=
 =?us-ascii?Q?CEsjc9izaK47UTMQBkOfn3bJFDNdI7iG7mWw8FLCjfP7KWN58Rqu4UTj/HvJ?=
 =?us-ascii?Q?tJriCdjRwm+fqZD1YsUwbf/uDacedx5DKg/gQ0AkC6sY52KifwxasFjSQwer?=
 =?us-ascii?Q?w4cJxZ0nNYYNq2NQ/FR31fKld03EAoWqb5IcSJOHMwoO999NOuq4/s1+jMPf?=
 =?us-ascii?Q?pl8TY+jOlblnkcWtjSqpfcpT3paCZiZC1sIw18HWnK74L7MEaQ9rk2A0UJFY?=
 =?us-ascii?Q?ga0xMpIfHv+naGNXdv4nl8oZNH6GwF4QQ39Whd588hAMVcBVWzvOETJPJs3D?=
 =?us-ascii?Q?LbK1XuIKHhhgGll+AODv7tsd3EKO2H6vzPPWmjjQ4vZ+u45SmeID4B18yKOm?=
 =?us-ascii?Q?x96LEVy7PYDkbaEYr5WNE0RUIb1WwEeo+MVs48S7peHGAB42BvdvqfFoIFTV?=
 =?us-ascii?Q?BWeJ4zu5m7QG47F7skbUWnIdjp99ASYgAE7keRGuS/LLNhVZPNkiIJoR6xbt?=
 =?us-ascii?Q?U5aFVkYK4HjqxkAOwtgTZNXi5Ba9ZGHB/CB2GTPSXco+w6rHtBBYVgzIBuei?=
 =?us-ascii?Q?WnHzjmc//aQtLldEvuSq76vLZlg31Je0VerYZT08xgDm+FOsG9vkxBW/ZlxR?=
 =?us-ascii?Q?K8LX/Ma6rF341mUHsag1BGnAOs4opgKX8J5Ki13DFKPR6uAFY+VAbcQ8H+dH?=
 =?us-ascii?Q?CB7bsQkfWTJvWP3znTXOxj16rHndvIY4c7z7K5JhxRFPEU8JeFXLKCDO5hKy?=
 =?us-ascii?Q?Mzas9RTpkDZTaEk7D3NPsyz6AGkxoBwLLHxaP14sVxN2ePrjbysxNc7ieI2C?=
 =?us-ascii?Q?+c2lv2WgfVE8CkU9AzgpS9xRCpHKjEcuFtwxikYYb1kEHXuot7pZD0CzarYV?=
 =?us-ascii?Q?D5/LPYHAxZ0Cp2D9e3iCeywoWDjijGtn3VUsoY0EJ0+FWDOwXdufWnRai+KF?=
 =?us-ascii?Q?uXLTsVn4lLZyiyQy3DZGNQbGFeL0Kl59GKsrpksce10inQf8LFptbR5SkmZ4?=
 =?us-ascii?Q?PCJYgRMJ6lyItxDOxaWBcnQsLsiRGpo21B/v3762vfjjtIobuSQ6qKN26Cy1?=
 =?us-ascii?Q?3xo8z3N4yzcXdAs4WdUmQ68purEGokoOJZadp8xNz0mEfB6ztdaWsJq0j8Qb?=
 =?us-ascii?Q?r8riYfSrbwQtw6N8rScbZWPuaVyw4LPmEd4hQXI/Wbh+mSOH3wzruOAMOa0W?=
 =?us-ascii?Q?+rLauuDj3jlPPvrkCG0azs2qjfsguok/pkuSPTlKUni793QpKpi4EpXZFNv8?=
 =?us-ascii?Q?Ap+/ZLtaGQlP08YOEcJogHE20snz7F+0iZyodROta8paUTfSqKCpmB1GH81R?=
 =?us-ascii?Q?3I3id/ZyKBs8IFnETILH7hxB8IkH+D7MX5YlSoeN?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a0a041-ad96-4163-f103-08dcd3490098
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 16:36:07.5715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXN2r+My7rHh36EZjomyNDrknvcuqIKVRWgOkK/BWprr6psBUyGR2CyIAyAzYlmugFLwC3fzC0RLdRhr+D0hqsZ1AjTTkaqmRZdDGuegyTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8106



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 12, 2024 11:58 AM
> To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
> Cc: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>; netdev@vger.k=
ernel.org;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redhat.=
com; Bryan
> Whitehead - C21958 <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; maxime.chevallier@=
bootlin.com;
> rdunlap@infradead.org; Steen Hegelund - M31857 <Steen.Hegelund@microchip.=
com>; Daniel Machon -
> M70577 <Daniel.Machon@microchip.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check =
flag
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> > > > > > +     if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> > > > > > +         adapter->is_sfp_support_en) {
> > > > > > +             netif_err(adapter, drv, adapter->netdev,
> > > > > > +                       "Invalid eeprom cfg: sfp enabled with s=
gmii disabled");
> > > > > > +             return -EINVAL;
> > > > >
> > > > > is_sgmii_en actually means PCS? An SFP might need 1000BaseX or
> > > > > SGMII,
> > > >
> > > > No, not really.
> > > > The PCI11010/PCI1414 chip can support either an RGMII interface or
> > > > an SGMII/1000Base-X/2500Base-X interface.
> > >
> > > A generic name for SGMII/1000Base-X/2500Base-X would be PCS, or
> > > maybe SERDES. To me, is_sgmii_en means SGMII is enabled, but in fact
> > > it actually means SGMII/1000Base-X/2500Base-X is enabled. I just thin=
k this is badly named. It would
> be more understandable if it was is_pcs_en.
> > >
> > > > According to the datasheet,
> > > > the "Strap Register (STRAP)" bit 6 is described as "SGMII_EN_STRAP"
> > > > Therefore, the flag is named "is_sgmii_en".
> > >
> > > Just because the datasheet uses a bad name does not mean the driver h=
as to also use it.
> > >
> > >         Andrew
> >
> > The hardware architect, who is a very bright guy (it's not me :-), just=
 called the strap SGMII_EN in order
> not to make the name too long and to contrast it with the opposite polari=
ty of the bit which means the
> interface is set to RGMII; but in the description of the strap he clearly=
 stated what it is:
> >       SGMII_EN_STRAP
> >       0 =3D RGMII
> >       1 =3D SGMII / 1000/2500BASE-X
> >
> > I don't think PCS or Serdes (both of which get used in other technologi=
es - some of which are also
> included in this chip and are therefore bound to create even more confusi=
on if used) are good choices
> either.
>=20
> SERDES i understand, PCI itself is a SERDES. But what are the other uses =
of PCS? At least in the context of
> networking, PCS is reasonably well understood.

Here's one example: the LAN743x device, which this driver also services, do=
es not support either SGMII or BASEX. It only supports RGMII, but it does h=
ave an internal PHY and its MMDs at address 3 controls the Ethernet PCS.=20

>=20
> > That being said, if it makes it more we can certainly call this flag "i=
s_sgmii_basex_en". How's that
> sound ?
>=20
> Better. But i still think PCS is better.
>=20
> But you need to look at the wider context:
>=20
> > > > > > +                       "Invalid eeprom cfg: sfp enabled with
> > > > > > + sgmii disabled");
>=20
> SGMII is wrong here as well. You could flip it around:
>=20
> > > > > > +                       "Invalid eeprom cfg: sfp enabled with
> > > > > > + RGMII");

Agreed. There are some other debug/err messages that were not clear that I =
also suggested Raju to change and he will submit in the next version of thi=
s the patch series.

>=20
> In terms of reviewing this code, i have to ask myself the question, does =
it really mean SGMII when it says
> SGMII? When you are talking about Base-T, i don't know of any 1000BaseX P=
HYs, so you can be sloppy
> with the term SGMII. But as soon as SFPs come into the mix, SGMII vs 1000=
BaseX becomes important, so
> you want the code to really mean SGMII when it says SGMII.

That's fine. But the particular strap (and that is what that flag tracks) y=
ou are talking about needs to be set for either SGMII or BASEX. Whatever el=
se may need to be handled differently is taken care (I guess within the Lin=
ux framework)  when the phylink interface (PHY_INTERFACE_MODE_*) ends up fl=
ipping=20

>=20
>      Andrew

