Return-Path: <netdev+bounces-293563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CRcD0siHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:10:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B17619FBC
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15EB300901E
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06B23403E2;
	Mon,  1 Jun 2026 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ga/zQDCu"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3A1A680A;
	Mon,  1 Jun 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294216; cv=fail; b=GSPGkMx2jE0yRA3YOPsvuz2q2YBv1yZX6Vyy8KT/+lNUMVTdUun9BNPi1FNXt6cCNnIKv2aOkPqskcj96zex0EHn+weyf7b0wYBU+4P5VXLSyx3x08us80mNBUMMkco1mhbx18tsVc55cTVpBIAUAqI0CcjIsSw5NX3IcCE8kMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294216; c=relaxed/simple;
	bh=RoXdTE0C7j+OGETe3rvOzpi0SfYvKRLscP8jMUykWno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CZ99VrqRvBgeEbpATWM/qUAGZCKgC/hfCuBAnLneFcDre8FtQ6teA4wcPO6fCVBVmxshsgNXJm+q5d69VrvAfGOWvbdcsGGVtQ1L08MKP8iRp041aEQwvNVgM04VI1Droo8fNxBOTsICfMFfnzfP6flf9gjRFU5FdwOSzGMdWyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ga/zQDCu; arc=fail smtp.client-ip=52.101.46.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPmu8hUOMvER8xAdU4X20jm88fQ7Ey8WYfT4a+n3KO4RO0xPA9IwnQvbyWojGKH0ElOZYR35/j5sqTGrxdfFKMjKCsjaP/+u5wzQAin7uaKZdw8XKmQsC5LzMbz1zrZUip3+w5CxDMufTR+2j9HpSHqnX8IvJBALMOay6mTaAUAn9yMRMtRChFY2a4d+8hUvyNawn1gTElsuP7i0Kx/BP7elXaxaaMK6htPt0Zk3wgkqnRVZLvQIdNAgR+jfDb6DKtK2UOVsl3Ul6Kf/yp9ZvDZEYNIC3laoC/jEybFIDkdujup+EvJtPv897j/GRkje8oQZ2GdlRq4IntnjDn/LVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTbATlHfzSTkY2brDxOE9wtKoSJLB0vamT0wXqVUEWk=;
 b=pUXCXj2FTqh+wCZehG640YOXlLGk8Pe9Us96+UKxtHhb2rIfy0HBZouAa5khC+pxBGq3DXcLqLLILS6SaJjB5d+IVGsJj0BEqTTKNhA96m+cW8j8K/iHjSVbTlnoTU8uG1OQVT4dfqO80Z0IqLJHRdHvp3xAVinFeIVKpQljo/djSn7k9jp6NNm7qcR3WHGa2bWVUjN7/mo63dEeiokmYwk0GUPnnYH9FrBTafci9mG/BTKmT2twiRbYZAY7sQr0QTBAqoRbu+GDTZ2U90YYzxFyUb4pcm0OXCigWMAbz0X2lbrQ46VPYByRQg8r07F95itUBCodPw7GMh4dY+yHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTbATlHfzSTkY2brDxOE9wtKoSJLB0vamT0wXqVUEWk=;
 b=Ga/zQDCu5LFNrRHvurEyUBHB3o4mNkZD5wqLXzU7LQiwYXaZSPzP4mUSNDlkCH5OwSCp2A3m6YHEoqaXuejyMU8Ow/zHP029ftyPjJXaLuwq3zTKj0b/HL6thlKVXS51MNMWSUnIXqYu6wwL7MhmGJtAm+fxgjmUq6/Y8odp5mbTt5vFvhaHxY4JLEG8Oh/WjEJVSLbKT9rgtjy/p/ri8Cc7kzuTRZVsVKFXc4VmxzIvNLnucxZQiRgePJeIwP3/YpA2HYzxGH548HonSbIOKP++G3jrXP/a44sjkNv78AMsTw045Lyjje/zQPav9QVNh4L5vnGH7E5+avbR/3cBiw==
Received: from DSWPR11MB9715.namprd11.prod.outlook.com (2603:10b6:8:355::17)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 06:10:12 +0000
Received: from DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139]) by DSWPR11MB9715.namprd11.prod.outlook.com
 ([fe80::25ec:56c9:f864:9139%6]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 06:10:12 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<Bryan.Whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Thread-Topic: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
 device
Thread-Index: AQHc44+RlfikKcFZCUmHVVUY4T4x8rYNeG6AgBQCtKCAAHW+AIAHRDeQ
Date: Mon, 1 Jun 2026 06:10:11 +0000
Message-ID:
 <DSWPR11MB97156347E4D54CC898A1CA43EC152@DSWPR11MB9715.namprd11.prod.outlook.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
 <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
 <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
 <af49a018-952a-439a-8beb-2e300a1d266a@lunn.ch>
In-Reply-To: <af49a018-952a-439a-8beb-2e300a1d266a@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DSWPR11MB9715:EE_|SJ2PR11MB8299:EE_
x-ms-office365-filtering-correlation-id: 4666702f-a164-4acd-5d37-08debfa470be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|5023799004|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021|6133799003;
x-microsoft-antispam-message-info:
 N4LELQkqLHguxLQCmQ+5Ajda4UvI9T4ZAyLEVUBgz6SDHJt6J056HrqHdrR9ItOOEN8SCcIYKkT6Ko+wm6aulCSywLAS+dTsBNGv89+cgQ527WTysGhOSXRv9GcOrmbzqY+ezV/OTBOJOIjfOzxbqxohqa9DcLh+rmoYMWcdZcJJUx4PvBkajXbG9n9jJzKVXRZ3mNaKcdqzJqZpCSS3axyZZ4HTYbtWwBIWAvn6V3gBzxqIUxzxke3QHC2BDt6CR6hl5p6Y10majj1jGzBRvSVUO68F3lruUxEaLOxQhOdXiSNR08P86saCcYxnYyeJsnifC78a8BOJlue+ZsIsPiJQr6GMDfMzpJtyCMOc1QeLise5x8VnuPAa+mvjXR8+qhMZcQ546VjI6gVRE9cvFOByU2stf2kdRKGGC+Dng1NBihGQK0ErfR00hqTtXkRV4TTVmEJnlyBUkD40r5SJmsbkqrGSx2gqC+GFJJmfXsvIdMCkZk0MQj0z6PFQphhg/9xmw1KnUxS2NDtbjOcmwiEjL34PFmaSGiesxXIybeNS15fHtamScmNV8KjEnizOFDAY4J2cOHxfenzfUzsCC+USGDJNph56BSxWoX2vSG+bRU+b0OvTeOZO7geFnwRWapUk8CpeN9gaQ98SCl+Vw8zdDA3YL1obAKELdbGCWIhJOrODysfji+rpngp5hgMh487S/hSqiNTj7m+Kj0rCK5mygdXP9XzsF1RV4MAonnT03QYAgw1Woq4WzDgyCdrs
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSWPR11MB9715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(5023799004)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?f3BQemWz9gIir/CQOCIzqWBg8TOPqcC+FCGX1brxCbY6FLVyLLDbsVrprTmt?=
 =?us-ascii?Q?isa/6MDlYiK0pxaEe69k9Y6wCr8F2kzJvdBNKTXpk19uN8dEa0hmSxGGK/bK?=
 =?us-ascii?Q?KIUkHIogUCw3hgls6aCndYuRYnRamPg9N6A/8BWSQvHK+VGnEfhUiCA/lEca?=
 =?us-ascii?Q?M7l1u+kcuZl5MdRvOtCJZCsJgtggI4edr2pJRU9PFI6Khx8IHRzCE9Gl7U2i?=
 =?us-ascii?Q?iFTsNl6rLb3o9rUjHf4uplwSfK5dSbA1lbPE768DGRcSYAw5MyZbYOQXmAFS?=
 =?us-ascii?Q?vwdFpOUhWXCek5NV3qf6sL1dFG17a4uRscP1BuiiVUxIvDHjT8uOEv9EnJfE?=
 =?us-ascii?Q?oQX1ZYa2CLu4Q/Hkf7odQPmdlEn7IqseNuDzwdL3GysnrPC9i3pUgVgPicyL?=
 =?us-ascii?Q?1pcF8ipV/Vk0ZYI4mVEuLsV/l2aq9Id4gRkCnJglyM0c8VRjfiJcQ/WTuGwx?=
 =?us-ascii?Q?ZI3R1pxMHBSahXm+FLREgpHWmTWm/hEksRBsvT3y3tS1gytBniveWkq/ZpKv?=
 =?us-ascii?Q?ZIfits0YpgiffW7rONLl9nsni7TXvAgQ0pZTohwBIEDiD4i9Px3/we0Lvv29?=
 =?us-ascii?Q?ngZ+ZL8l7rTJFArTMjPpIHHKF9DMz7Gafze4/Mk6YnfGr0gdH2XqbWliPQi6?=
 =?us-ascii?Q?haTnE6sWdNMGTOKeUZg3E+QCyVKLkWi5FuM0G862L1RTXxs0msGnGmLE5Uij?=
 =?us-ascii?Q?Murjs+y3P2A5lcc8EEAwbUWq+KjqEf5cA+o8d3NoBTYHg806jKU43WCbejCO?=
 =?us-ascii?Q?adDpwr0jsE1ggR82mhSnbZd2KxVH8MqVTVR4CvV5YsQgN31jey0Vi/wAiQl1?=
 =?us-ascii?Q?13WVkN0sRWCKQEXSwcEK3FULCc3nZ9dIsueWxPOlOMdERIUzkQJfXo8IcFuZ?=
 =?us-ascii?Q?qxxto7Ggmvt8xv2XIMHUpNGCpi3pFKtaVoaQC2+AtoOOQ22tIbM2CpolFWNa?=
 =?us-ascii?Q?Juwaf5FTw7WJeDh0/Jw0ORhKCsxRL6Ez4M5aX2pPDWH9lhuX6MMnrKJS5G95?=
 =?us-ascii?Q?l7AGjcsai1hM0Mj1mzJnT+52LWJyBG+o0W55ZjMlWUkf55g/wj5zSvT7FeSX?=
 =?us-ascii?Q?qnJUGqfxmKWlXW+0siud/jPGOrASI4w29SFoXXC7KnSitmlWn/7UuGQQ2nJO?=
 =?us-ascii?Q?N4jauBSgcpWR/LcPQm8AsAI/d3MSsA7LfpBbGxzNobRzTmOiBWmKLy3e2gYq?=
 =?us-ascii?Q?8MRFBJZxQYsypt3BytIV4kGwBJkj35w/gnQHED8sYqe4QBHmMMc8oq2Di2E7?=
 =?us-ascii?Q?w4C4EkbX0YSW/YuV4y9BeLUhyImGGxFdo4fANcmXGbaLAw3dhKCjZBitnn6M?=
 =?us-ascii?Q?Y45TS86ictpSHD28xP238chuXCVeWJUzfoOHSBlgrKLe/Vd5Lj2hOe1BdF84?=
 =?us-ascii?Q?bu428KlOjt0zsQ+pkWARyTCFTtyfePEYwDc+X4rb6p+BXJEJUH98brnLZTBa?=
 =?us-ascii?Q?vJtinHuyPqwWIaF+/QgiA0YtFw9o5TdalvXAIPmYlX0NCWOoPtoa5mxyOKP3?=
 =?us-ascii?Q?jOa6UewdtFfrWopVsvUEuQTskm3mOvLVevExVquk6PEZ4WP5YMlrM3Ryd3jQ?=
 =?us-ascii?Q?Uf9BPfIHj0MKZExTKCPkxYPXas1K55Aiwp0vr3gf1f85sqj9MQfDDORolvyp?=
 =?us-ascii?Q?/8S7y9uRJXVA1loGErZNTfaCrihIg4dkze3deHJQSk4fQW2RD/NKcdI7invK?=
 =?us-ascii?Q?wwX4Rtl7NWtJ0vHJaK1ZE6gKhH5wHYsZAHgwm82YvXexIdBFeEc12zq2oXXh?=
 =?us-ascii?Q?MV5qIj8ZKg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DSWPR11MB9715.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4666702f-a164-4acd-5d37-08debfa470be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 06:10:11.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlYtuIDeVEGdjDKpcOMgIDUb4mqqI8gqhTV+/mgPh05j80ZrF/o7oY1FSszkkx/rfjXUXRRmUv/VCbwXQiKGIoAFc2A4lNVTz9Ojzjw+FVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[Thangaraj.S@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	TAGGED_FROM(0.00)[bounces-293563-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,armlinux.org.uk:email,lunn.ch:email]
X-Rspamd-Queue-Id: A4B17619FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,
Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, May 27, 2026 6:53 PM
> To: Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>
> Cc: netdev@vger.kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Bryan Whitehead - C21958
> <Bryan.Whitehead@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; linux@armlinux.org.uk; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x
> device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > > > Introduce CONFIG_LAN743X_SFP to guard SFP-specific code
> > >
> > > Why? Does this add a lot of code? Most MAC drivers don't have such a
> > > Kconfig configuration, so i think this needs some justification.
> > [Thangaraj Samynathan]  CONFIG_LAN743X_SFP was introduced based on
> >   Jakub's v3 review feedback. There are devices on this LAN743x family
> >   of devices (LAN7430, LAN7431, PCI11x1x) that do not support SFP at
> >   all. So while the amount of code in the common LAN743x driver itself
> >   may not be that much, the dependencies could force an intended
> >   minimalistic build of the kernel that wanted to use the lan7430 devic=
e
> >   (which is rgmii only capable device) to have to include tons of kerne=
l
> >   code (sfp, i2c, gpio) it does not need otherwise.
>=20
> In practice distributions turn on nearly everything. So the code is likel=
y to be
> built. Rather than a Kconfig symbol, can you move the code into a module,
> which only gets loaded for pci11x1x?
[Thangaraj Samynathan] Thanks for the suggestion. We agree this is a reason=
able direction.
For this series, CONFIG_LAN743X_SFP addresses the dependency concern.
For distro builds that enable most options, a separate module would
typically be built and loaded as well, so the practical result is the
same. For minimal builds, CONFIG_LAN743X_SFP keeps the SFP, I2C, and
GPIO dependencies optional at compile time without requiring a module
split.
Keeping multiple chip variants in one module is also common; for
example, igb supports 82575, 82576, i210, and i350 in a single
module. We think the Kconfig option is the simpler solution for this
series.
If there is still a preference for splitting this out, we can address it
in a follow-up. PCI11x1x differs in more areas than SFP support,
including TX channel count, IRQ vectors, SGMII/XPCS paths, and power
management. A clean split would likely require an ops structure across
the driver, which seems better handled as a separate refactoring.
Would that be acceptable?=20
>         Andrew

