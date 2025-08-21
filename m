Return-Path: <netdev+bounces-215765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EB6B302E7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E71A3A086D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8C2222A0;
	Thu, 21 Aug 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYSJNLyV"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013050.outbound.protection.outlook.com [52.101.83.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F71A3167;
	Thu, 21 Aug 2025 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804724; cv=fail; b=hnLGIEchGArtVP4lvH9lSc9L/Zf3sEZeYWecKUKprOGCCAlFiZTaes8TDY4Piq21C6U6//lT4LeWk3fMId3aXoF3QICirmdHwCheGWlYtce87wAjkKO18JCVjPXA80Tgj7JGEnB4mjrFIrla04L/pkppwIfnLMLferCdrrFcDUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804724; c=relaxed/simple;
	bh=D3jJARsWv5yDvntYfcCVR84dhrzoP2Os8AShTbzlPqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CDxX8qlw+0ql1zi8oeX/x4WQ5uCSZp0OqPfuwa90a4K83kEegfoJwd726bAXbwuaRlDd1h4KPT1JA8fRi3mQkormdXW6unv3VRcTHFO2tHc05SjOYDrYBtFyYSzApWTRFys8MypisXvZLODH7SXXw2n5POIDDXL8JrRwHuJUTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYSJNLyV; arc=fail smtp.client-ip=52.101.83.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dVNXzlgK8pR0zK/t7kIzMIieoV2hcpVfz/kV1F/rGRQiBKoRhjPP/FiMD5qV7YJmvaDur3HtiTEPBYDaSYVvIwMe4X9wMN8FTpaDOW8eLmuTfcgxNHE3FTr0tVjdhc9XniCCiV25l2eJcfsYZXBkKdKxA7riIp5bH2/QcahFETFO/VPgHblgfVXWNlrgpnViFrywtdW2s2zZSfxuQeVGu/Xb5+XDE/DCWJwtXyXxeB8nQAzMbeyO7ZJajXfGai/Qe6n7d/4BqLWyjST1atO8Fr7Fvp/ykNqjGYdpM8zATrIny+xMuzFrNBIN4Xm43ssEB7gKWt0HM5Y3xkaKyJs4Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csRJa47nXpRn8x999GPPBP0wWdRnWmDFXQNIeS8IJRE=;
 b=GyIyIFbrNOnXMHRPjQZZAXoNPlqdhP+g3Wf/dqQBO57TyrX2NdTIy8GPxmQhyrteXdyDGu8IqYT++ujJYNa9qSVTWlx6XKCgbJq91GB8sRFckiWAYlVVK6pPcZxaZLmQVSI0MFMORJzCE4pHo6Vssc5DJRbLPeam36nLbTJCfBvV+0aREhHAnacPrLLjoVeNAcCHRGf9lRdDuXIqZoAaXXGL9swezw9/f+GcRBdTeP31S6AjKzAQD352bCAcUwK+aB3Hdfmbuutqlxr6LztSNbEPS79TkhUNv5EIeSD6Lg7tuaRXKwpbUWKwFNIUcGIVnrTYfT4aQeC6rpkQB4qRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csRJa47nXpRn8x999GPPBP0wWdRnWmDFXQNIeS8IJRE=;
 b=hYSJNLyVVY6GGEmHrZ5Aa31lebsZP5+AhKh+IEVQMxL3Tz4LdeuElvDPO08taoVkvCk1tHOTJipsfCNelRxupq2BRYiAYqtmrQ9vAwsHH2C2aJ+W0N7ZLij7SwMbvwO+3iUvS+pgTFkoNWG/+wqh0FqxDy96b+CkGFF09HMkcDrj+HU8yRnR+7JDlPck80AfHu9yxgkg/aIoJVsSlHRaQcdq+uF686z6+iX4S0WyO85GQhb6cjbJvnYoU0SijCImgLjCPlh6hxUCCHtIGXTetgkaHxRuU1sds16cslfwbtoNS6TGbJ8E0AG5Yc38/wqGO4bg/EgmxzNEacnAmr5gHA==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 19:31:57 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Thu, 21 Aug 2025
 19:31:57 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v2 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcEtJCJxYBf9CJDk2TgKvoSjcLCA==
Date: Thu, 21 Aug 2025 19:31:57 +0000
Message-ID:
 <PAXPR04MB9185014A230A36245436F01B8932A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-2-shenwei.wang@nxp.com>
 <12144026-130a-422a-8280-9e0b25b22562@lunn.ch>
In-Reply-To: <12144026-130a-422a-8280-9e0b25b22562@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7348:EE_
x-ms-office365-filtering-correlation-id: bd9dd3f0-4205-4097-b386-08dde0e9649e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FQYt1YLYCc3XfLegHYjbA5Xss/S1xEvsmhUZVLX41DalgbuJlmS/dVubQFrZ?=
 =?us-ascii?Q?T8biS4f5Z2sfYdJd6XTdry3l7r5klpL0/91d4MVyoDm9/lOpRGSGRrgohe7V?=
 =?us-ascii?Q?/kF6ETrZsOUdFVp1GRYzW60bEbQy0RWPGRQMVgwu4shykOEUBWp+jmxc0PgR?=
 =?us-ascii?Q?KvvMIojdDLoW/j8xucaJ/gF6hHxH/HNysdqEaCp3LFvbdbgMvpFecSlhSEtc?=
 =?us-ascii?Q?NxX5uOyD57W575gDRd1QuAv30wKCD5LVTWUNGSUiXMIq+0GbVaWS66gcHRWx?=
 =?us-ascii?Q?7oBtb+Z4DIn87AaSSanO/pl9CKd+2zB5OhGFdeAXOrKYeh6qkxxLzT8Ybdzr?=
 =?us-ascii?Q?ns2hV+TXB89s7CsR1L13vGZwE1RDItQXTz1huxzXoiaZIzc1OpLakheojGri?=
 =?us-ascii?Q?uAshp4UGb/O6cjf9TqIfYQ7xFFAE7fD5ogvMjeHdQFp2QJCCydq1naoH3Uzo?=
 =?us-ascii?Q?egUYPCL0ISGG3vuG9xBq2w29lG+xtbRHpalhYXBEK4e3fblFRQpAIgERDEsN?=
 =?us-ascii?Q?OHhYl4X0E0pf1WKGLmQVzUwZAStOUiWPVITynMIRP+BO3RpA/hRz82UYZOYF?=
 =?us-ascii?Q?PY49Evy7fX0PlxTGYo18IYi2Df4NkD42isWT9z+/VkpTbyAJrMPpjEGcUggv?=
 =?us-ascii?Q?8kRE97/wW1J3ovCOsdqST3jx3/cw7e0E6LYpkZ7f0L/sDXrOYJPW8a/wYTYA?=
 =?us-ascii?Q?gLsonMqUbVCe0MtJY38EaX6FwFW7W63fzYP5bH0NqterfhFVu0wgdN++WCRl?=
 =?us-ascii?Q?badO5E4UMToswqk0HNLfxOJahIMp2PiHZzwlbEUtPnd+uweKl2tFmPHc15LY?=
 =?us-ascii?Q?fonRYPiMaEi7TOT3UjQNkjLAXYtw7KBAWWBT2kphdPMXDzStUTecGQQ2Flj5?=
 =?us-ascii?Q?9tbcbtmEryRb9+HJOzv2PKYwtk5ykEFQSx8dsdUxLEaWOXCWLcSEbF8992fJ?=
 =?us-ascii?Q?lQ1eRnvBkr7MggRjTQe7gNi2oJiyACbRq1bO+MpbydhDrYqnOWEkVZbA5jx7?=
 =?us-ascii?Q?orHeDz2EfWfDcr5UzoSQF3iSHppu+QgWnl8I/9vB/pqmqXf64IaaPOcFI/bm?=
 =?us-ascii?Q?4oYmYwpJrSSOqAjtoVdWk+jAbESrh3mc+9cGS7ALkRy5rqFi6p5ymHnURrhE?=
 =?us-ascii?Q?7ix0XXcah7yPypKyDlnUf1WVpAsx8SAlndF/z3uuPpjLvLxYsexGnSWAGl8x?=
 =?us-ascii?Q?k4Wa+l+iENR2vHXbxJVu1u0cvjcTlUCkODBR/8gJHRupiPBUSSIbLug+OcRr?=
 =?us-ascii?Q?FxKyhn0iQqRsUDP65SQUFBzX/K8Ggge8Z8FijRQLAXL6XjdK4wB5JMbT0vdt?=
 =?us-ascii?Q?bB1zhmSytes1uT1i5Ks9jcPtODadhgVlJLLp531/9PTLNKlP6Sb8HDVygO53?=
 =?us-ascii?Q?mJm9pZiNeCyuw8iOgrlpfY7C0KYSYGQ9zl/YcODzJ6/Ji98djtU2SO7v1Sja?=
 =?us-ascii?Q?aS8Pk/5tN+DYgjjCqUnp5leblgvNmV1WsfJJLzVARmwRbw4lECWC6g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?92EXW7zaLo/gzFxaZeiQCav8tCMPlmEfSaXLsioI/iFe6wZmwg5VVz+MPi/1?=
 =?us-ascii?Q?GhlvEo7hr1uzvNa6MbClWa5rAI+9YaqdrfK96t7WtXUln842xNEfnRu/xa2p?=
 =?us-ascii?Q?1l8Ir8tUpuzV5I2DXD0r+9MHELFEn/oJW+u6DlQO7ZgI03K4iX7eIhgFOQM0?=
 =?us-ascii?Q?uraluRyDDGFkecHTqWDj1absE04GRQ3/YGIVEhePvv9YknW0iFcQKBMxiND4?=
 =?us-ascii?Q?5mu2D9R78u1m21u3xDF7sHOFZzcMGPy1dEKxQ97gC2PQp25UsKNT69uqQf4n?=
 =?us-ascii?Q?j/YDGxQhc+tfdfjZ73NHHh+eC6pXDLuMKg5t8uHmPANhauIkwkhaakQ8gBNF?=
 =?us-ascii?Q?KpJ432x73bdFPFqn5P14vdwoA8mh7e1Tzfh6wXSUJJiVrrD4Kh4ITZklcR6M?=
 =?us-ascii?Q?82JGd8b+GQ93f+JBxgjrGkEIqEGZDdVpXZI6gl3WeQIjhLsfK64jj79z8a4l?=
 =?us-ascii?Q?7lqvOFyWehroFg/uzXav0CMgngwOYVTOhUQ8Lg6o6PkCPJ9Zw8R3KL9stutS?=
 =?us-ascii?Q?bdxn2rw1Nby5SErnBlk3RtALFtOYiACDW1xHYnuWcDu4Cm0jB2+4cCyoQD9q?=
 =?us-ascii?Q?vEU3jsuAgth4U8IQ+XhLH0SU2gq5mtg2TRO4fo+EBun5UZF9ihVLTqARhQYZ?=
 =?us-ascii?Q?QCFfEHBALAgSjnghAqAkBHZBod9Wo7DfpW2oW1eYqtPvAI6rt4r5i7X9wJ1K?=
 =?us-ascii?Q?/TGJRBsz+GbaKqsNMmN5dMCJU+sAF8YqdcZcwKdSXB9q2uirg9A9siTvSSQq?=
 =?us-ascii?Q?0iYDT685kkq3DO7guYSjUHCpegX5ZMpQ/aTXVj7RbPeYEltRfgI+/vZUrLKM?=
 =?us-ascii?Q?durPWhlNkBMf+KZDujdkl+4ieucq5dYOyNC9oHg/bYZeOrp35yLo1s3DgZB7?=
 =?us-ascii?Q?QnzgfWUbADrb2zDh0fumzRYDRMmA+n4UgkqE0Q3OXlRvXf3cgilbtsZ3ZKIP?=
 =?us-ascii?Q?x+m5CJK+S6SNH4XZ9AhMhAbl3AIAjfejZjOzrthwCHeECsB71JC7e3RSk/3z?=
 =?us-ascii?Q?cMhN2Y8l2WBCr0z1qKA/lt/S1KwHv5rtH9UPEhlEAiv3FHzjcmmvwrQidtwf?=
 =?us-ascii?Q?sqk12X9xeyLXeBdXiCNR7FuOeTGeiAn7CJdwIc3jGPLZwZH1TXy3Y8sQ+1Hh?=
 =?us-ascii?Q?hlS98jo91Ud2GzcdQx08gvVB7cBMM4J61gFHkbkhY1Lv5FBFVs3V1sDdkdcT?=
 =?us-ascii?Q?+lYZkbKUQMFJWmsbij5s0z4gNXZWur54LHXuXG7Af32I842ccuW3JbHeO1SN?=
 =?us-ascii?Q?071e0J77j65qHIW8fK2PqOVNV6Jto92Mq4fosYi+tSDwGr3IZtcfw6g41ym6?=
 =?us-ascii?Q?m0gKQLjFkgx20b/9jfxwx6AbRfN528rFExsSLyjVZsneHLwIvze/I4xs10Uy?=
 =?us-ascii?Q?BGVGq0PbzLJ/XM8Rb7cjdNaAJvAbJ7v54KHoTib6MJQRMPYiG3IdASarMyjb?=
 =?us-ascii?Q?1y4227JqiYt+hqZ2IAyGEeu2lJF5voekIMG2IA6Hn0X3MipTb0kqaW6dur3X?=
 =?us-ascii?Q?YYht+KzGvYECKQrk/gr//Bbl3j+58JaTHo6r0hKi96/ZfmISx67x94ekh4zm?=
 =?us-ascii?Q?+WaLuy9wRj6ETlEecjs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9dd3f0-4205-4097-b386-08dde0e9649e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 19:31:57.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Je5SH9zZMcAVvqcSC9gpKVaXqYZ3slkAn3tHtSvnkT+OfTKLjFXPznvjGz3U9VNEg23tJl2ux76j8eXaEksJQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, August 21, 2025 1:56 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Stanislav Fomichev <sdf@fomichev.me>;
> imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kernel.org=
; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v2 net-next 1/5] net: fec: use a member variabl=
e for
> maximum buffer size
>=20
> > @@ -1145,9 +1145,12 @@ static void
> >  fec_restart(struct net_device *ndev)
> >  {
> >       struct fec_enet_private *fep =3D netdev_priv(ndev);
> > -     u32 rcntl =3D OPT_FRAME_SIZE | FEC_RCR_MII;
> > +     u32 rcntl =3D FEC_RCR_MII;
> >       u32 ecntl =3D FEC_ECR_ETHEREN;
> >
> > +     if (fep->max_buf_size =3D=3D OPT_FRAME_SIZE)
> > +             rcntl |=3D (fep->max_buf_size << 16);
>=20
> I was expecting something like s/OPT_FRAME_SIZE/fep->max_buf_size/g
>=20

We can't simply replace the value here because it needs to be left-shifted =
by 16 bits. I intentionally=20
preserved the original logic for consistency. In patch #3, the max_buf_size=
 may become a different
one for Jumbo frame mode and the condition is updated to:
+	if (OPT_FRAME_SIZE !=3D 0)

Thanks,
Shenwei

> This is introducing extra logic. I think the if (...) belongs in another =
patch. The
> assignment is however what i expected.
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

