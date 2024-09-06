Return-Path: <netdev+bounces-125847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A496EEE7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E498F1C23272
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 09:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1681C86F9;
	Fri,  6 Sep 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mm4H4JqY"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143D1C7B8A;
	Fri,  6 Sep 2024 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725614074; cv=fail; b=J2/wzpKKc4H7qjtxFzvIbu7lG+stFq5+/fx2EK+fXV1LMaqGvFsi44JleJoupPwNyRe5LpuOEZk/tjigkM7iCDNb8yYCprkB6K1bUnaWKScpfq5TtgACoLqtetZsgeHVuNFlGlp8ayBLme7iLtVLQDeVfbno4adVTAgmwU3a6HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725614074; c=relaxed/simple;
	bh=EnGCcPY7NKXuzahU47QNNW5q7uXAZjuP4ogQhUbpPFw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dTMepVCHKoxsQtJavZ3DuqY/s3Wmh0LF63QQoqij3l1b8A5qcdQBt79hi+nQrmQ8QCcy6c3glqZh6Bh+N0cMjbQLjXzBWdIPipc6F/pG21cqYZwz358p46ox3wm5VJwtg1/Shv9nuPsqNzaLZcID9oGZYMg7bmmgL9v2VKdphIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mm4H4JqY; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxl5LFViQnOwDnW34SbS2ogUwaZbgCAMUfAOOAtIz+Bi0OYOGO2CsnclAJbxGR3MoVG3grOARYNtenaaheJ5tmoqjrdNFHjyVQm7Y7n243fL/2Sj+IhVqJSf+dPn5l2+ebAsIv1ebrK+NALT5oqd8+KQoavRCzyHFpDLv2121i0U7fBi0eWZazBxJyTAC8WhyDc2PxcnFwhqOcKBpM+7AcIItpUAxyK2ml0erfaVbDRwR3HBK8hivCQt/I+Sj2qE3nRK9jFrbrWimk/Wn4hzKLdaOrABYAZvzT6yCLQCFWIpzNFAUjYsAZ30LTYdXVZW8f3hskMNXx7KisSSGQ09/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnGCcPY7NKXuzahU47QNNW5q7uXAZjuP4ogQhUbpPFw=;
 b=S5nzoWfn4DvAYszfRsn3rc491ShmPBcULFx9CpFiPojazJYYoaWob3Edsl+G2bFRujbcuQ5CLBRlrxiw/F/Alec5GqPjciEXFi0K9MxbcCTWrkHlJ/0DRozuDZEeU8+6FdInHSJireCD7umhf4N5o5gdbvlFusAy3Z6GZwLUzh9eRIAnkqoMtg7DFZNr7XyB6it9gTKVnJwL5cJkHe1ttnD7qrul0i7QQEQYqsoTzLQxPh/wHgHJYhjAsiAxDGEzmxX8ShIiBuMjjQ4QhijTItWa2xBrfc0mPMAH2m+deC+0I+hAakPKSoHjK1uFKzt4YxZXdP1DlLung9lCfkWL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnGCcPY7NKXuzahU47QNNW5q7uXAZjuP4ogQhUbpPFw=;
 b=mm4H4JqYVsTfs1ONDxD3T7+M4RaaSivteRiwX+zeNgs7DfhOaOarSyYOgKO81082PD2crMYfp30THjSWVquu45/wE1NaEfpLSaumsqpSzfZZhACOtSyeWuR5Qy/L+4ejBcp/NGxUu7BsXBHINXQjlo/u0ZCo5J0lnd5hY96WG5siJFdx9yZFd9DJMEmszR/DiXJpZBWhzq2ZQhgJorpWzirX621dXuIJEKF60teg+zk6pIShP7B6Ra8yPpx+K3TQoiBUGnNFUb+m8gc09cNczyPwst73h+YXd2SXkWhBIE3hNr0SMONPt3T2IHhN0LeO5jov0Mp8v88w5shnQdGn8Q==
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com (2603:10a6:10:371::5)
 by GVXPR04MB11018.eurprd04.prod.outlook.com (2603:10a6:150:224::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 09:14:28 +0000
Received: from DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4]) by DB9PR04MB9259.eurprd04.prod.outlook.com
 ([fe80::dd45:32bc:a31f:33a4%4]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 09:14:28 +0000
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "michael@walle.cc"
	<michael@walle.cc>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: felix: ignore pending status of TAS module
 when it's disabled
Thread-Topic: [PATCH net] net: dsa: felix: ignore pending status of TAS module
 when it's disabled
Thread-Index: AQHa/rJKlXY1TBKTTUmTMzuG8nTqs7JHaG2AgAMSYHA=
Date: Fri, 6 Sep 2024 09:14:28 +0000
Message-ID:
 <DB9PR04MB9259A724BCA28FA199B94E57F09E2@DB9PR04MB9259.eurprd04.prod.outlook.com>
References: <20240904102722.45427-1-xiaoliang.yang_1@nxp.com>
 <20240904101213.oqdf3brqlzzmgln5@skbuf>
In-Reply-To: <20240904101213.oqdf3brqlzzmgln5@skbuf>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9259:EE_|GVXPR04MB11018:EE_
x-ms-office365-filtering-correlation-id: 6dfc8cb4-545e-4b1b-304a-08dcce544f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?z9C82zs0ogj+kzKwHXlACER4AV3Y5CrUkPOxpIYuE5K3wGUBV3JLTFkyB8pp?=
 =?us-ascii?Q?Vwue4sbR59NoxKxYEDFEe7QLBIXfLgtIxC4GCqQIX2BtHgju84ZB9hZ/Hbcz?=
 =?us-ascii?Q?7lHze7zcXL1Eeir7SXfDtg8vg3xoJX8ZcAZFqTTx0kwzihC00TQthUMqodtq?=
 =?us-ascii?Q?XoBwZBnILiLVAKiEFDslheuNzNeUPeoCK1dndy1/ZrzPkG5YQHeiJ7/yJUYM?=
 =?us-ascii?Q?xBgE1TenUbgaKU9T2MHWgYUPtNLTDDJ5u7iD4roXg0eSIPtRvWW7wZp0Np5n?=
 =?us-ascii?Q?4ZgKzPBaVWG0HP1475LvRcnLcZv0+ipEz69FWkHkMoXlcPKFO6khhX3udUa0?=
 =?us-ascii?Q?t3mq5sNucYY/GiVLrHijr13rDa103tCGSjPKLG4lJ8PPHmtPPCuCMfviG901?=
 =?us-ascii?Q?AnVy8W3VQiw6hE4E4OgZ4sdSXyVA6PjLuk0v7i/7Un7j9BDGXoGyUXfrtpm7?=
 =?us-ascii?Q?+hqaXbA+VeFjsuLbz84ZzwSvq6CdPmqsICNbaMfe10D36VZQmO3CZzJ49mvh?=
 =?us-ascii?Q?DL0WsySuFOr/Z805GRcw9VVzJsZWe5UMdyB+PwLuowCD9q5IDI0MDZKUHsoc?=
 =?us-ascii?Q?dBBNTaMyEvLizrrAv0hJ5qzvObZXEECVoiheR8IrwgOWN7xfN8prCJf1rfU8?=
 =?us-ascii?Q?ugHnhJvqHv30/ABqGYFHwL8b6YBMNkCdpeEKiId2nKgsIZLNo90NQf2cx7Cw?=
 =?us-ascii?Q?Nsyc2A1eqBQWvP5Uj4l5t4APPWn0OGgN2o3M6MJvFdCxu9Ikl+AanoHDMJ5v?=
 =?us-ascii?Q?z0zBt5bnzMRGFToQgG01QFFxjmYLJd8DZFwjr1r2N065wJ3yl34U5s3OZKvJ?=
 =?us-ascii?Q?xvqDdb0DiVvTz5fkMcj2mU59t2LCxHgtuaK/wMzVSIwDxzYK5sh9HCR254/Z?=
 =?us-ascii?Q?otjDQtEFmLfj7bc/GbmS7DUwgdqBtuqjyRv2fJJyBcR+/YZYuE2C64vxLgRo?=
 =?us-ascii?Q?Q7rJysSY2U1x8TQhKD9VlkADGMxbtFyqTasktwkntD/xRaYtEAimRuGphKKQ?=
 =?us-ascii?Q?zprJSiud84yk6Go3XJVVbal8Ibafk8HswmFpfX2fSxU8djlpRiSz8WDPI2JX?=
 =?us-ascii?Q?0BGr6ZLAoLfPU/aRW5405bWi4GCpU1HedsDJW2CUoI69hlyiyRZgCorLmy51?=
 =?us-ascii?Q?RB9XrPdQm8Td7O13f0ksHx3HTWOlnMO4Oue0xbPDmPpRRrd3T1tIrWv9E2nQ?=
 =?us-ascii?Q?f16Xzp2w2Iumahd932ttJRRHqIjiz59CaWazuzkCH+BJOKvJIBc6jKJP/pRG?=
 =?us-ascii?Q?X/Q+KK1zYkz8n3q5YbvdcN8LtaV6wWd4ve0nN0vnkBWwLCQzAXPzT0FZXFhq?=
 =?us-ascii?Q?qmMnPYYfmxjW5mUSyRD8eBIcvUTwM1n7XhrnaejThFO9Pmi40PO+x7Tt8hwy?=
 =?us-ascii?Q?TJVTC6bTyGmh1H4vjsv1J18OZodsowWWBwOuWVUVLNc1Lx0Neg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9259.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lQBamnmlzwPizRKlq/qhMF8cjasNM4KEoQfXfZrY3i5WWSD+yRC9kZ2hEydr?=
 =?us-ascii?Q?RKi1DTtCTtTfbjJ74w1ro+U5ILESo2LW/15x5r4tWb3hv3q3K1BQRT3iF/Qc?=
 =?us-ascii?Q?3HjmCEOPp9SoYhTwNv9XiPxh1P4nM/BKTKkCtTGkPfQW8cs5r/Jx34vweTFK?=
 =?us-ascii?Q?2jOrmCH4afwky76dl54YZqem9okeCOJ2vwMqiiC4l7thocqV5YuQxoKTyvbA?=
 =?us-ascii?Q?WEakGSAvSuRAWpIBmVAqezPB9qs53/8ASWityVEJfFvQZtJw44EncETDdZe0?=
 =?us-ascii?Q?i9lUjBMPcfh//QI469g97l5mJeH92SLmJr4nYAAxE1l6MKxM8HeO26UTXaQT?=
 =?us-ascii?Q?79E6CPSRUJKP6gz+GrtIs+haRNu2OQDhzeo9ZPiNwn+ljvTh3eeP7l4L4VV1?=
 =?us-ascii?Q?6THi9EndbAm//OCaWVg0CuqL1Z2DaMAR84sbatJQmKheD4RuxNdIelvHDipg?=
 =?us-ascii?Q?IjrKW24brzycdu5d1Vm/raKMNnHXymI7Ons3ssJe2ai+sxo6TTTfJjizYpKi?=
 =?us-ascii?Q?p1yCYFksZdMfqx0OwQ7sE1Y1wMFAThIgkDtvVF+4gcPXy6sPfpDP7I8GqEgx?=
 =?us-ascii?Q?A2wOA76j+BSVy58RM0zdzstYnV7ZpJKUdSUhQhQAuaUeXfVjT0ST/Nb2EkDU?=
 =?us-ascii?Q?3AL1wjjn6IA0SiiuhcJDgwfr70RB1e2zyqSJiyCMlqDjlz1RLhDZzUU775OM?=
 =?us-ascii?Q?zedKkpKuZJsD6cL/LDVbb97df0uux9jHoW80J32fySfdldmMgfgRHl1dawvG?=
 =?us-ascii?Q?W/FVK+IMYYR7yMCih2OvSZ59zAfrdk7WBjwjYaoiQOmX5cZ4x6I1iTnQ+FkF?=
 =?us-ascii?Q?eDN95oC5RZw67hAahTnUpQh71aLwhO+QbOlPkOw2MPp7eD2+9jgAtDNKT4cO?=
 =?us-ascii?Q?43fG+nlZuIWYeAz5fafR6wDhEbKuTP42NXZ7hz1+cO3OXyaTqGrWhvXb3Cfv?=
 =?us-ascii?Q?Hq36wQ3zeIpumeZTRbV8lnvHHqtmDBtOQgs1b04UK/WqYjCQp1RwM3Cdclro?=
 =?us-ascii?Q?58gaQYJ9O89w/Kgg0dCvAsPFPLwK18Op/mbBAYT0HGWWAp0N+MDr6SUVg0iz?=
 =?us-ascii?Q?s9wHgoGFsnYCyCJIsr/3nKI0oR+4sr9x/sppP7Jgwkpgp9VDdURkXUK6WWch?=
 =?us-ascii?Q?164TBvZ4/GwvGbsjnuQ+FBWzRiMCt60ZSqx5vlGKZexlPzigiJbaANQSl/Hu?=
 =?us-ascii?Q?nTj5NdIGqeWYEJYv2KXUPGC6z4B0jJGKihEx7qJvpB3tC3F3H8jzmw8/krwF?=
 =?us-ascii?Q?vXttNPyXSjIAxdBCl0wp3bv6J7ueQNw2smXU0d9VWcKvrUDxYg5qegvL3Xif?=
 =?us-ascii?Q?Yw32Qh6gqtrq4YdtZUgBJx1vjih6/72tIRvSQrZwaDH+peMYZoFl/NFocc43?=
 =?us-ascii?Q?3EI4/7aCz+WmomU/O5k+fgVaQTSKh45Fp7KHwxjkZn6Oa0OVQmAop2MiJRaE?=
 =?us-ascii?Q?EAA1Hw4fIki6wv2+Jlua8cxvGr9aeEnzVC7n95mSmHD/x9xKy6lAydO4TSQ4?=
 =?us-ascii?Q?ekqGuUpMzUrfaCVW4klX59aTGV7EnymNwvtNumvQ+C6oHJnQqnitXKHTW3zW?=
 =?us-ascii?Q?/BcWcGkkpBVij7mL9GIUc+KUzIwbZwRcQiN1RSJe?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9259.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfc8cb4-545e-4b1b-304a-08dcce544f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 09:14:28.1116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHrnzNuGpEc3YKRxvm1ZWltZZ7yEh+CBRCah9btpvpDVyUPrGmVVkd0bk1mC2KW4rb9S+njSxk6d0xdVchgAFEuu8fMAOooM9q6PzKT+baE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11018

Hi Vladimir,

Yes, it's a user-visible problem. User can't reconfigured Qbv once the TAS =
is=20
in pending status(configured the Qbv basetime as a future time). The driver=
=20
always returns busy. Actually Qbv can be reconfigured after it's disabled.=
=20
I update the commit to descript it and send in a new patch.

Thanks,
Xiaoliang

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Wednesday, September 4, 2024 6:12 PM
> To: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; Claudiu Manoil <claudiu.manoil@nxp.com>;
> alexandre.belloni@bootlin.com; UNGLinuxDriver@microchip.com;
> andrew@lunn.ch; f.fainelli@gmail.com; michael@walle.cc;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net] net: dsa: felix: ignore pending status of TAS mo=
dule
> when it's disabled
>=20
> Hi Xiaoliang,
>=20
> On Wed, Sep 04, 2024 at 06:27:22PM +0800, Xiaoliang Yang wrote:
> > The TAS module could not be configured when it's running in pending
> > status. We need disable the module and configure it again. However,
> > the pending status is not cleared after the module disabled. So we
> > don't need to check the pending status if TAS module is disabled.
> >
> > Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
> > ---
>=20
> Does this fix a functional, user-visible problem? If so, which problem is=
 that?
> Could you describe it in the commit message? And maybe add a Fixes: tag t=
o
> the patch where the problem was first visible?

