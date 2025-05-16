Return-Path: <netdev+bounces-191185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA51DABA590
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A0A01F88
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3691280300;
	Fri, 16 May 2025 21:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fFq76CWa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B96128001B;
	Fri, 16 May 2025 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432409; cv=fail; b=IVP6G+OqRhvaUx8dK16luO91q/ENqA91g9dXyUxCnlJRh2XeoQpu2Wc26QrXx5MkA/NgxgEKVeXUsxAqRzbzt4iyqrSa8kC/nuzM0V1XVuKMux6wC+JJ9xWkJUM5XT/GjNq2QOjWpl4gcskb3hE1NmQ4XC1ZC+9EaJzC2nlCRg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432409; c=relaxed/simple;
	bh=q16NTFnhHcXg3f4kzAGTsuPNI33NyidZSI1r63NoQQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMHdAeeSjPr3908HGGjwjVczJnkRc8Yl0XQqsVz2wXEZhA2tZyvN+ksq0zu/0NVWvL2xgB06VjZyV6vhI2Do/B3LK0j8bea27cxys67TovzdaNWktZmV56x7UPd7ANbxTtmkfDS+bnpMNXVY986v9+Y3p0k+ZlFMIOpjQrVFtyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fFq76CWa; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrgXuQpHJEGxIN84PikVecOpuoGt4NmAVgsRnh3zsI1Juk39Rngz4r69SSNUHjxfdYYPRbdgnszJZmwNCzE8Pbrmop/FGf+1WrdQa9oa6CD18pjeslxT/dp/eCpje3B9lK4kzP/gQI3yaTaj2dSApMImlhTH5Ovnc2qiZxrdpLrlQ26lC9iZsbAiHdtv7oplbjMDCzr5Ev7EmXF/f1jlytVlVEvge8wzhuCA+jXWPxxR0nK9nIaQPsBpkDMeORQ1sUsJRT5D2K5BuIEL2HOF7X4Dqxf9P7VXJ2hqW0nrSX8Wc/0sznAjP1d+gBA9EJmNw/sSVXpnd1Z9L9hkeKfbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q16NTFnhHcXg3f4kzAGTsuPNI33NyidZSI1r63NoQQk=;
 b=G4QFK6cDC+M76NmL5oyO6Jh8wbBQKFyreHi6yIj+pv8vg03jL5mY24SHGoAxvLnQkDOiDH7M4p61lnCet56y1D1JPmxY4p98fBBi39c+0zs7+AQfoTlMlhwkOPO+2UJqj4rXxLums7N9bTvDX17GrheeC9st8jbWq+e5581LBY2Sxe5BM3Ke1oXHrpAVkO+LfKa1s+LdbFD9zgF6VYS07I+e0jLq6rkkaUwLGHh+K5oFM8aTH+K0xUtvbqvoBAk0evKRdA6whProE21NuDhIsWFmYoHuuM0aBfDNinHN48GTv6/al5MtPFzfC4Otg13x5a3UPep6uNDn+CwwBbfboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q16NTFnhHcXg3f4kzAGTsuPNI33NyidZSI1r63NoQQk=;
 b=fFq76CWaayqSbswFzrOdaF3EazOcAtelycEwi2UAi20UMrGs4mL9VHD0xJdGiRQrdU5EXxxrJHuk3Lw3Aub34G0ghZeIBvmwi999gTTDl/R7wahn+X/UdTPfUDCkWLvcfAAC6bY3lHxoX+eUX8GQOi4G2R3dTKMDllDS3xXSUuQfpD8WCIulwAOTApq6W6NbADr+iuXtcltxDZuAIYLY2tTuTwHrFhZRisi8cZQFZf6jw8jPD9/gnPsYTqgPoZ3x52tjQYf7lKmiPbyI6xK5rZ6bIbtNnuZ4asUHhm7GX7WoiO/n3MKJ3sNSyHDfudoP6WxlTPH1QyUCLtPWQ3d83g==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Fri, 16 May 2025 21:53:24 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 21:53:24 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <Woojung.Huh@microchip.com>, <olteanv@gmail.com>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v4] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index: AQHbxgwLVyZ+0FlRMUiYEmAbgLH1dbPU7V4AgADfCXA=
Date: Fri, 16 May 2025 21:53:24 +0000
Message-ID:
 <DM3PR11MB8736778BE6F9A4B2F35594C1EC93A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250516024123.24910-1-Tristram.Ha@microchip.com>
 <aCb3kNniIhtmIhf1@shell.armlinux.org.uk>
In-Reply-To: <aCb3kNniIhtmIhf1@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: ac1118eb-da89-40ff-5f39-08dd94c414fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rLywfMx5UXOXBgJpbDWT0PxGhkOJMCd2qZ0B/WiWwE/9I0b6gBYhViQsb2Yz?=
 =?us-ascii?Q?8srUhlmxq0NYcs7V4m1qnHva3okKV1wui459fXsOx5EMe+I+bCsWNZyZjbSS?=
 =?us-ascii?Q?WzvFc99Za4SN4yTKrTSBfPEH4gxYagDYv8KMIiRLFFXsfMLwppn9jUDP6y5A?=
 =?us-ascii?Q?8aF7W7dCNwTw4se0eQ2n7TyeKPVIADvATjtyyo8rBmDqJWMBUmYa5O3bFO1+?=
 =?us-ascii?Q?c3HWQP5O4ZHPYDCAqVd57XqgJ1CB/JlpPPnj+a8Aa4wPw5PNU4dizEmB8e/J?=
 =?us-ascii?Q?eJoiuruoowZI0rcSwJu5BKp/5rbEU9Q9HgmfpPKWW1Dwzsl4H3znn7rYdUG6?=
 =?us-ascii?Q?BxwzZigEz+5NEmUMTov8xpSWqQ+iUGjfy4uMftErpoaFzcoyhBEIianCBChk?=
 =?us-ascii?Q?YQ5GpOkJ37SQZBxhMcgzOM1MYAqgtLFW2oG9nJ5wGaJu6OzJpg9U7kgBN/tQ?=
 =?us-ascii?Q?FN7MAyMLQuiByxy1pEr+u7KCpM4MSsuRE7odq44nxJnnBFMpLwWwqD+ixNCb?=
 =?us-ascii?Q?QVOuFYnasmq/I3gK6gJghUAtv3ug4FliG2hK3agK7Ja91skewoPfo/3gUfs5?=
 =?us-ascii?Q?LWU2+5/rZAbjbilVGzuH5f/HyHz/Q8q3clkG0XD8fI5Q1ONhpoS8f3hvopZS?=
 =?us-ascii?Q?7KUU6/TugqN2AXyg3qM1PG1uRN0Soq+sphUF9Yl8K/Eom1JzW/tjDh9esMGP?=
 =?us-ascii?Q?ls6YGBJcYXalmx1vk0ZTMFLGVWptqwFTxzaCBVNN6V3NLUEQkHxWuZhiam9M?=
 =?us-ascii?Q?4qrY1e7hRM0ENc4m7dc6cv4jHZ7A0k8tX+CxrRC2Jqfy4AFzFcrO9VIcysMJ?=
 =?us-ascii?Q?M3TBID/rVrbRIeL3ZJtBzQUzR9vB4vToVFBWsCLqO/wULpGCkdJlJL6QZSnc?=
 =?us-ascii?Q?mriFg7r+PGmnO/wprkZOUY/n4ljDr/2KykAhwgGWY3V/nHEkOHCLp10dEl/k?=
 =?us-ascii?Q?OOOAF3UeOA4uMUeamAA7bA5hV5rAxHp/KiI/bROAIOvDjanSPuphoDEETtkB?=
 =?us-ascii?Q?tH4fWgMub+eWvPlcT4QScmf53KUiOWaOKbqWPAiWRZlrz6HDmuooUsBJu0i7?=
 =?us-ascii?Q?5D6XjLtdXmeZXerCD3AaV4VjRrutHYCTIBqlqVg7ayACFw8Vy2q2kgMbzUCU?=
 =?us-ascii?Q?UcmVvbsgOwvoftlWDGveVNklGcOJDf+6uvwRaZaN/RrpmJRN8gByfIILuZsn?=
 =?us-ascii?Q?nf7PluXqw9T2pQ9xFGiJ08Y7OThK4efsbjQAIJixZSnw/QZVkqVOVtv83Chk?=
 =?us-ascii?Q?pe5EHpjx0iwatKv/5Iur2f5JSg8qOwI1ibz5h7rPHTlvWLjXTwrL5MtYCwKx?=
 =?us-ascii?Q?38Xw5eYOWNoCf7UGWXXur4qBAWgGUC9umqBXS+pD7jkIGz9jYhO6cmlHwlGw?=
 =?us-ascii?Q?WZ1HJM5Jpr16OPn01iVLu9zPpM+/uD+8Xqa9LzR2KcbPCL6PznOcezuYWeMV?=
 =?us-ascii?Q?srWaLTeuKGkhPW9sDYpZsm5quCA1SK5nR7DwcIP1Judkgu0fA2SoLA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lo8V1sTiRkQR4AYgirof/UuuxD2lWw9t2Aw25E74tvsL2NO8q4k+SXrEZhy9?=
 =?us-ascii?Q?MJh47V4jLqk+3hS06OsDCSeeNZBIpOwQBs82Eti9JVddw52m6qq7KmeqF61h?=
 =?us-ascii?Q?MDi+a1DboQElQ4RYdj5azjZ2XzDmC8/hwOSsIMNasZz0iRo7xhaNlVU1yqlz?=
 =?us-ascii?Q?ZDgZoWCmlC3mss+sPSwdtr0JCFY+bQSrkl5/gr4B2+aoIdUOCx23vK/j1WfH?=
 =?us-ascii?Q?BqOVHYd6lvAgybzlg0KqGhBnpRL3SovDj+Zz+OGFzxpwnJdBoN3aSgra1cIc?=
 =?us-ascii?Q?OQQqQduyT/7ETCDXNXljihsX7mnzaefTiBZQQ694XyPWUwS+ivSQGvMJOgiw?=
 =?us-ascii?Q?Jo2A7/r3nNJWbiuG49+9y6ze2L5gNoU8vz5jjo3idhXh4dofswQs3CtIHTgn?=
 =?us-ascii?Q?YxfQXCxkC1MLmak3lxZW2NQFiz9itkRHmWhbJoEE6PcekMWihvKsNZEbnBVz?=
 =?us-ascii?Q?mlSg1dgAbRZdIoETWSS6p/xs0ZbwO8tHPkxTiqojO366h21oFxNmcRVGq747?=
 =?us-ascii?Q?eTK0A6vgU6+zC3ph0iBpzgVmvBNvODZO8zWhZeEgUSjHtxMABskfgFsNy4aL?=
 =?us-ascii?Q?8U0looS5xr1Xiuccm4kns7d7L0hkcacV8kse0q2GPAP5whICKlqPovmUMo7e?=
 =?us-ascii?Q?y/IYnd2qaI5VGIOJWjwh231VhylAy5TBc08oN/nctoWgxdrYenc9Uuv7qWZP?=
 =?us-ascii?Q?xoRMJ6z/Tnm2e0aibrG1ZZiVyG45Ah/y3QshO1vdFQR64wvYJ+BMNIR7G1vS?=
 =?us-ascii?Q?COwox1n1ljV79cCG+N1TJ/Bt2hHmm/FRP0HbNyxko/5qsCB/8lCiLsr0PmpD?=
 =?us-ascii?Q?SXf5vmdU3G4OwKGBBzxrgNbEP79Wt3YXkljPtrNDd9zGMNF3fNKc/zQ0Sh4/?=
 =?us-ascii?Q?mL7NaNAkdf8JTAepSEhw4Zyb8gFfNN5XHXFAC1QJFf0wmjvm/KWZCIsnTKay?=
 =?us-ascii?Q?rAXd2pFODXj5zCkMgHkyv7wHRimOYhvh7+WqNoh2Z6AsCW1fm1bXd97+DABB?=
 =?us-ascii?Q?Jwe7H23frWagC2FBTdB9PW+4FZJapxnglKS7HfcxeQumsBBJsZTHwaNky9AH?=
 =?us-ascii?Q?R0dy8Q0Xti0UZV5rUDkIZYNLyTvXztYpKHk+50c3mzrROn0CMPWE+nODu0ra?=
 =?us-ascii?Q?gH0xUBYslCe8KpgGzTQQoLuAmSc3N+fej2kEsnjCiBTXhXrHUbDBnFwjgwqx?=
 =?us-ascii?Q?d6BymlKQII9kzDp4DbTYxdjwdCQsE+JNFJc3M40+RZ9zbAWyUSoyWHvmxzYO?=
 =?us-ascii?Q?xKf+8VQ1atWv5Ggvb9Nlf6yyOfd44kPEFUqQ+YUWUkLFQuiftnmjXFbaTXUk?=
 =?us-ascii?Q?3Ep0ysqeEznbKdWAcDyLZct34QJKRQGQQ8mZoPsCvoylpXgcU0qZK5orabeU?=
 =?us-ascii?Q?XC730CXy4z0QC2akJOzNZb4pdpVEZvDfT2bZUcnWOXpFVCqs6jlG6GAU49Kq?=
 =?us-ascii?Q?IqvpaMef4GV5J+/elOVInjxXKYoW7g/2CeeQCFnsGhAXUAWqDKX9/Fyg1JTh?=
 =?us-ascii?Q?V49aAI+oRcTBRxCLYkEi350siscWYwmrQizOmf++pxDvLwdvcuihk3MOnt7F?=
 =?us-ascii?Q?5uvGCizQW5Rx2bqcBeKx4pekukA7N1mm49qNd9+Q?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1118eb-da89-40ff-5f39-08dd94c414fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 21:53:24.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+ql/B1T+YvNo7nnFI+BiEoEgvvzVrHvAXADGqiVNUh8Tc9qUZp/XnRBgmLxIL1mhZRNTo7FAS9Mgzt334xfsU94NQ9wT4dTEnRW8LQ//pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4657

> I think I gave comments on the previous version about this approach
> but I don't see any change. Maybe I missed your response, I don't know,
> I'm only occasionally dipping into the mass of emails I get.

Sorry if I missed your recommendations about the patch as your last email
was chopped off.

There is no code change from the very first version.


