Return-Path: <netdev+bounces-161720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63733A238FC
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 03:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C861889B74
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1F1E522;
	Fri, 31 Jan 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MBMRjkCc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7C32563;
	Fri, 31 Jan 2025 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738290943; cv=fail; b=Vg6UdQrdvQ8G7uAUuhcQw22iC6yZLZCW2cC07BaW2V2+oYYR8BRTHg35nZvks494+7ha5/ZwEAR/BXQ1T6BAGpXeqLDd/kzuRT7uqfGrgMnh8otvYEQdJ9nCLRQ8+Pqk6rHq9u+1IEJFUY7hmnFAFlrmeWJ94zby75LtCmqhIy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738290943; c=relaxed/simple;
	bh=v8RJN5wl7bmX1TDmp0hyBmjJ6zuvzxQga+XsT2K1IYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xm3Dxr6qWS6ZHcLiYoY0bokvFIcdxfqFp8Bcf7lWOVfJnNh2OOAS8fJ/vry7y2IUrmdkZ7OXELDQuTo3cXKxtWA44wTxPCXmJ6BGlaZroo7T5h/UvLr36Y89/rO0ZnhtjXwtpMW7HVAZMJo2oLfChKZjrhKhLhS/Nhqi8TaV1fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MBMRjkCc; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avvONPBgASuKlgc1gKjBANmIyBuX80ozxOWx3Vc4fCjd0+49KY28IDmWVQc7U891gLSJGHctqBQuS2YPEaPWkuUUCs5yVAkkp9yL70NyOd4ME8aX3psAwayDr/p7VLFfwYC+tL/S/m0pP9ik0jnR7mvi8Q69wjFBgLxsWXV7xTyIU2FgPXCvx4cVZVpyTxl3rQw3LheDrKBbSgZORl8oP5Jm8LzQ0zBQFIN9JFnOsDwwFxv241/Q5vOfUhHM93ZbuxudczjSSfSGF6/LVZcGUrVkulKG4GZ0T6wyLujytdxEvAkvxPbpT0juwFtcz944uns9CRUB8kWSVmtv86HTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWRJaVR8fD4oHNrhosT3BiAiLHD2jsRuVtELbCFb3l4=;
 b=sEYZ17GiYisvtjznR0I1HtFTsos5DopcAhqj94C1ivHFaKlZag1xbPuPGDRIkBfmNz1Zlwe9NjL60SRuj0kxzToMHPIGPM7LPaAEhqZVzJweArYONfigpkGz0diLUOuWeyKEEW6jidVBhLJfPnNAkT7va24YZGOH9jWvhyQpxxvFV/VsBU4uEUM1dktgfVVMWNGT0gpILgQad190rSqHtujEXJoyDboz3nVy6wdKpJlrgzIQABr1NXa9xT8Bth44xNSWP3TXADVBJAAUJAET5i4SuNO0hY/PfkaNnz9ccdATzLM3D1xZMu2h8HU0dw7qDzjwhdCykZNcz9gf1Z3r6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWRJaVR8fD4oHNrhosT3BiAiLHD2jsRuVtELbCFb3l4=;
 b=MBMRjkCc+W0NMnnqT7ENYM9Xd/N4uhoupgC2Mm6lGmelOw2bp78ArTPKtO5Ro1bX1LwENMHJnHo+nlWg64gp2SBcmWB77dy3axCGW3/iuZqOh//rjnqj5ktwMRoK9JrbYNVfcgUXYH46ceeronTE+349JT0NjNdrtw9Hpq3RqLa67jKXna+6CRA+jyLGDFkR7KxreSgQKguMD8s2nTzjQrdI2OyI19GdL3x3QMpbspMvZJNjrCXm1v1n+OfbrPCOg9ZqpDKYdRRFd4k7p5wOMFlea8NZFU3i5AhZHjhyn+u4Dzk5grbaCYvDczysFDB8WlKHv9AandWec6ObAaQTuQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY5PR11MB6163.namprd11.prod.outlook.com (2603:10b6:930:28::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 02:35:38 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 02:35:38 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>
CC: <olteanv@gmail.com>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAADrgAgABkpMCAAGdLgIAA/zzg
Date: Fri, 31 Jan 2025 02:35:38 +0000
Message-ID:
 <DM3PR11MB8736A58E065BF24C2CEA5808ECE82@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
 <Z5tRM5TYuMeCPXb-@shell.armlinux.org.uk>
In-Reply-To: <Z5tRM5TYuMeCPXb-@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY5PR11MB6163:EE_
x-ms-office365-filtering-correlation-id: a914cdd2-a968-4dd4-43b9-08dd419ff281
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?umG4DoMcZkusOE2+gFz6LKL5vQUuCJAJ19TY/ezrBVnJCb80ZVvrGcyrXEKg?=
 =?us-ascii?Q?FjDgUWgjmDUcg9ys3dUnks3IIcbJcBvFI2JzDMCtyy3Gj9S1kmES9CxrBdEH?=
 =?us-ascii?Q?0wTJCqXAP3gngEIJwFX6Dv3OUmEr3azu1mBnHK1lfy3Bmhz4cOn/tV0osfKX?=
 =?us-ascii?Q?QB1sUerNMUnQ5NBBp+HfkKjfNeZG5RwELHaFC7vzNf9waYnU0v1BmomhUHrf?=
 =?us-ascii?Q?KIlpuw6lSy0K5P7c43GPlLaMVX7b27rmbnbUnQav4S/rVR0DcnJuZXtfNHma?=
 =?us-ascii?Q?OBImPcYBZvqWC/1ma/cA95U/Rm4WDFQUnX/E2kCg43c12qqJCo4BHqcONaJ5?=
 =?us-ascii?Q?slCfiOCm/BuG3MIITNRTaVkJdySVTkVwVH1Q48IQFSjsMU25Z1YQjFeWGAgY?=
 =?us-ascii?Q?lh4rz0ARwMXHbq8xJvyRwhWlidhXajM2Rys7By7qi4IMt3+0fxvtuFCAJ3tm?=
 =?us-ascii?Q?5se05jvVovnFpULalxXqzrbUhnEgIREuenTNpwuGBsymTF26or96NxhVxKv/?=
 =?us-ascii?Q?+W27btbkzC7b667KqpqkY6E1tnkswCLVIZIDNFDiEcTysI7oiIyQb1bfspgt?=
 =?us-ascii?Q?Zb4FuoBSBF8h77YOqWjCjACidsZS7m7n8UvA7YQjE73dy3bPh+jCnQf8cMt8?=
 =?us-ascii?Q?dc7fusDZ1qZ1QUo4hiiXdJ1iTJxdg43rbCIXgcuxPWw/0XXQmnsOVRO9wAWF?=
 =?us-ascii?Q?qbz4jJ2zIq06lc5Qv8zy6aIX+m9Ckeb6/DCXVnxSF0Rfh7ReY+yxzSHJAbZT?=
 =?us-ascii?Q?TDGzYTdGVtvanekZhcX67zTFBfFiIlt7wJCzD0TgrdSduREnSecxaSFSYQxd?=
 =?us-ascii?Q?JEWMuz2bMTTd0U0jngLGoKw6l5Op+XCsjL3ia+FoB58CfymRRBRy6Xj0DEq0?=
 =?us-ascii?Q?PGRDkW4s/JkHZL+cKu9t8iTbCkBHB+XJHlfUEiO209SriO8WzfEFFZuAigrD?=
 =?us-ascii?Q?5eVdeWhRdE5VT6W0z3KpKb+haRq7cq3v57UfVuLXBIYhzznAInQbdqoieiZg?=
 =?us-ascii?Q?dYGx1d1N42QwT5xvAyKttJ/obIm1SGX+tpwytEJL5Tv67BL5xZ2MLGqwCc0y?=
 =?us-ascii?Q?n7PXsGv21O0Mg8jMVkpTHOCPWc8e0qfla3UyEBqQCT0fagOhWCXKO9RQJDyZ?=
 =?us-ascii?Q?Ino/vs3gtJFT63peqelRRSooBPqeujw0vq7HNwb7tMgyuv/h5/oOaFALThNo?=
 =?us-ascii?Q?LD3wZhpusvXJDId39w4J2D4lqAQdOWJpH/qlrUp2GtNSo3wbks1ug/aN+Sbs?=
 =?us-ascii?Q?karpu8g7Z/LApZCvbTBsXZYwyQnGn9DJEmUs4ABddY2D4LU8IUWCzM4kjCsD?=
 =?us-ascii?Q?dWqAtVHxFIl04S3/9bSIrnn32VljTBn74+dpGVdcXTgnwZUaFXlLdVZNehmN?=
 =?us-ascii?Q?1ZbfBNjJ7EaI6tKm//YQMZp/09kYugcYLJkXcJIeGiO+HmZMoVA1ra/haa1j?=
 =?us-ascii?Q?csdpcBQ+himbF9pQZHv0L+JEeg1QFciz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0tAPYYTwlTjqfM18tgW7BjeRkkex8vcOx84m3fuwJ482vIUjbNOHwz+GYfR0?=
 =?us-ascii?Q?1HKhuVt+RG1I4uFEViFD6rlmwSeYEVirT+RMTPRxBfoK6+XwkdHWPBL/mAuw?=
 =?us-ascii?Q?Z0hsJ+ovYhpWl4424h0cI91Inm43vxqoxvWWwKTwJ5AL720UaTOhlH1K8RGu?=
 =?us-ascii?Q?9fFOX4nWdwcwX/L3rMSyRWcq++L3DhD7uHV5X4Rl6fzyNrKfpJMfLl00x0kl?=
 =?us-ascii?Q?TepmbP+wRP8gkEyUR4dbDge9O3BUG86yj+GBh+FR6JZsVZyOkSN7szlQnZf/?=
 =?us-ascii?Q?8Jnzq8hZ9ipsSOfirXjj1PIDCYqkXKzKsgxSGVl6/ko6Up0/tovzuXlJHTQ9?=
 =?us-ascii?Q?/AM92zcAJRXRZaJt+VBXegph0b91G2fX8XfrhgrHHkJgfhTdvnDFrrZY+OLI?=
 =?us-ascii?Q?eU9SzyYwrlJtPE8l2HA6JRDcUJNn/0du7JxFtCGcJAVHm2XFM93bNlAE32xP?=
 =?us-ascii?Q?KuhwOTrXGCALhSI8t4PKHDUoZVGSZBlVuMqQNBhSAfIAQHI7BAoAIZNKUGZ/?=
 =?us-ascii?Q?OMhgVikTZZN21IQlVoUKI4LVPBUrKvIVf0YNi5ZnCjpu/O+5oUmHGjJNHJev?=
 =?us-ascii?Q?8N1wh8CcEtAbw5qCRs+OW8Ufyct/I/P1fQUNfvWY8l5CIXNbWoEuEm8IKTea?=
 =?us-ascii?Q?MehIwS0cGt/NlLxoDJ081n9e83dOJ6TWnRe5vF1W07SyR53AHxL9YE4Fcsp3?=
 =?us-ascii?Q?F9G6rkCB3Jv3kFQVQPuCvIEKpFu9uSxhQF4qCseZqc2D73ce/nP4Se9HLaQF?=
 =?us-ascii?Q?Gxceg52MtzLFWEfw9R2KWMwIm5rVtFYd+cP68uQY7iMUkzVDCO2ERZ1am0Gp?=
 =?us-ascii?Q?1kp9CA8RiaRfegjLJiZtuou+mGM9SD2olBSjxgnvzsHvzzwvXl/bKobv/Cip?=
 =?us-ascii?Q?Bc75z+26eCNaTEdekwU+IMGP/Rbs+XsII+hd1FrKZGgEIZvFbtmK/K1+58xv?=
 =?us-ascii?Q?8TI2YfiaiEkjy1l4x4+mzk748XsZG8dO2ZWin+8BJYSkIZJH8r7dlYEVGhDl?=
 =?us-ascii?Q?mZEs3UsN0ro2PxSHBnlQnRS5T9tENPUr8z7BU+qgz6mTesPSSP8fQJz6euGV?=
 =?us-ascii?Q?f/6jiCR/ugXO9z1fY6STHBq4XuLc641RRV0w+WccZl8XUSq2e0p04uQCIQqG?=
 =?us-ascii?Q?8lRkxXZonMSCkI285NUT2TarjqJURQheXOUpUTy8z4kFu4203jKEzkGv/JkD?=
 =?us-ascii?Q?IBYTxnMRcQ7jdUdeXqswWBHbI0JDJ3BGIF+/+GdNl584u1V4hTugQB7WqHK2?=
 =?us-ascii?Q?tZOhbED2EC1HA6a47N1vAJaEtm9vSBPycL6V2wEk+g7rJi9y6oV5HxcG01cD?=
 =?us-ascii?Q?BX+1lu/etYY9FQKtKnyPRfxFpdvCyQlrKrcK3e39ThBYaYITkXeWHzrIH4FS?=
 =?us-ascii?Q?cF6B71318xxfphx3je/psil50chWs2yZqvtqSEr+aOcln13Gxu0gXUBlD0ub?=
 =?us-ascii?Q?pf4roCW+Kn2GJWcunTV+709oMjHbVcZdCsuGvPqzDFQz14hW42RaiBkjZQ6v?=
 =?us-ascii?Q?wds0pcSpkNmla7ihdtBUHxkCpb5LqqIyUxK1BR6Hs1p+fZDTWsRjo0D9OO/M?=
 =?us-ascii?Q?JvnX8j6SNjoaXJBVgrGc3ROcG2QTc3qlEFJYek1b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a914cdd2-a968-4dd4-43b9-08dd419ff281
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 02:35:38.0340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ubfswz/8vn7/ajDZMfDQ5Vzqs5/ORHRYZ4op2/K0NIxkjpnNd/nuCVxXEn5gyVcIXqOd3NOeGMb4UdP93kCE+dCxx4e2heQN02q+gA4P6dk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6163

> On Thu, Jan 30, 2025 at 04:50:18AM +0000, Tristram.Ha@microchip.com wrote=
:
> > > The next question would be whether it's something that we _could_
> > > always do - if it has no effect for anyone else, then removing a
> > > conditional simplifies the code.
> >
> > I explained in the other email that this SGMII_LINK_STS |
> > TX_CONFIG_PHY_SIDE_SGMII setting is only required for 1000BASEX where
> > C37_1000BASEX is used instead of C37_SGMII and auto-negotiation is
> > enabled.
>=20
> This sentence reads to me "if we want to use 1000base-X mode, and we
> configure the XPCS to use 1000base-X rather than Cisco SGMII then
> setting both SGMII_LINK_STS and TX_CONFIG_PHY_SIDE_SGMII bits are
> required.
>=20
> Thanks, that tells me nothing that I don't already know. I know full
> well that hardware needs to be configured for 1000base-X mode to use
> 1000base-X negotiation. I also have been saying for some time that
> KSZ9477 documetation states that these two "SGMII" bits need to be
> set in 1000base-X mode.
>=20
> This is not what I'm questioning here. What I am questioning is whether
> we can set these two "SGMII" bits _unconditionally_ in the
> xpcs_config_aneg_c37_1000basex() path in the driver without impacting
> newer XPCS IPs.

Using this SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII combination does not
have any side effect on the new IP even though it is no longer required
for 1000BASEX mode.

Note SGMII_LINK_STS | TX_CONFIG_PHY_SIDE_SGMII | C37_SGMII setting even
works for SGMII mode.  It seems this combination SGMII_LINK_STS |
TX_CONFIG_PHY_SIDE_SGMII reverts the effect of setting
TX_CONFIG_PHY_SIDE_SGMII so the SGMII module still acts as a MAC.

So even though you said not to setup the module as a PHY it may not have
that effect.

However we will never know whether this will impact other IP unless
somebody tries them out.

> > The major difference between 1000BASEX and SGMII modes in KSZ9477 is
> > there are link up and link down interrupts in SGMII mode but only link =
up
> > interrupt in 1000BASEX mode.  The phylink code can use the SFP cage log=
ic
> > to detect the fiber cable is unplugged and say the link is down, so tha=
t
> > may be why the implementation behaves like that, but that does not work
> > for 1000Base-T SFP that operates in 1000BASEX mode.
>=20
> At this point, given all the discussion that has occurred, I'm really
> not sure how to take "only link up in 1000base-X mode" - whether you're
> talking about using 1000base-X with the other side operating in Cisco
> SGMII mode or whether you're talking about e.g. a fibre link.
>=20
> So I'm going to say it clearly: never operate the link with dis-similar
> negotiation protocols. Don't operate the link with 1000base-X at one end
> and Cisco SGMII at the other end. It's wrong. It's incorrect. The
> configuration words are different formats. The interpretation of the
> configuration words are different. Don't do it. Am I clear?

I do not quite follow this.  The link partner is out of control.  The
cable is a regular Ethernet cable.  It can be plugged into another PHY, a
100Mbit switch, and so on.  Currently using 1000Base-T SFP running in
1000BASEX mode and 10/100/1000Base-T SFP running in Cisco SGMII mode
works in establishing network communication.

> If it's still that 1000base-X mode to another 1000base-X partner doesn't
> generate a link-down interrupt, then you will have no option but to use
> phylink's polling mode for all protocols with this version of XPCS.

It is always that case when running in 1000BASEX mode using fiber SFP or
1000Base-T copper SFP.

> > > > > There are some SFPs
> > > > > that will use only 1000BaseX mode.  I wonder why the SFP manufact=
urers do
> > > > > that.  It seems the PHY access is also not reliable as some regis=
ters
> > > > > always have 0xff value in lower part of the 16-bit value.  That m=
ay be
> > > > > the reason that there is a special Marvell PHY id just for Finisa=
r.
> > >
> > > I don't have any modules that have a Finisar PHY rather than a Marvel=
l
> > > PHY. I wonder if the problem is that the Finisar module doesn't like
> > > multi-byte I2C accesses to the PHY.
> > >
> > > Another thing - make sure that the I2C bus to the SFP cage is running
> > > at 100kHz, not 400kHz.

> > What I meant is this Marvell PHY ID 0x01ff0cc0.  Basically it is
> > 0x01410cc0 for Marvell 88E1111 with 0x41 replaced with 0xff.  Some
> > registers like the status register even has 0xff value all the time so
> > the PHY can never report the link is down.
>=20
> Which module does this happen with, and is it still available to buy
> (can I get one to test with?)

All of those SFPs have generic brands.  I bought them from Amazon and
FS.com.


