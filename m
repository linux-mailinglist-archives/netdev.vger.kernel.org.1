Return-Path: <netdev+bounces-172736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D508A55D4A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D5B7A8E32
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16C615573A;
	Fri,  7 Mar 2025 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyX/cjBY"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6791531E8;
	Fri,  7 Mar 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312029; cv=fail; b=bsqsR4HWLbQDHmsOtOaoAQ37a2Ef4mKZdqdg3zg0JCXIVvNuFqLblJ9lsfPyRIJWrmICRnVeAX5EntUGg36jJZflcJEYiQ0zbXoEsd8IpOCuDfJiPqEabg1RBlliPiYNtunmbuT+ByxLrGHoPeF5pNKm2XRGtLBe+ABYeb6PUDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312029; c=relaxed/simple;
	bh=/WdUNGnSmRG7LRYqd3AhlB53tJ1rg5PQoa/mfLHbKHw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j15LKZiEJdwK86owP+FCKRXbKv5oRAG3Gz0phSpWXJ6RAe/KAj9ikpGzBSasD/inX6aj0o6jKisNW/76ny2wYRwSwOs/Xkeocpo/hDCEJ0rOg9J69uxFYKIqzJK2wnjIr2GsyhDTB+UPjjVH0dE8bDf0h9+txdXUKM3OhPKBOzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lyX/cjBY; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiliFfcrhkZ07Bits81o8fpWe2FJJmTFfdirsP6KzAXq8uEoQRjhUJttVcwjXR5rliS3FaMSA1ctEmv9ag05sKvqE6cApvDB2AGocV+d8flrPSQY4JI23wsQ++HDrEBcRO3tUZJiAQaLX0IAdtGMx4H22WdvPMbXM/LWC2QXG12ZDhzImlm4gRAPMt2biM7V1hCuBQ+b1AspcInk7imXS8oe8rDNYN7dCczXoQBKrUVIxhVnzfsH7sUNzFnMxiypHCVV9gFVKh4cIVBByN08cvlnGGdE27o5ldOLOIAIVXR3LeSaeRpDhuUZF292uTS2O525eAc3Z/V1oF6PUSCyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLVfjQvwIaKPLxk7MK99l/+Dgkp2XVZMK4b2GISnKYA=;
 b=gTYgXc+wOo302kUI9CaEa984Ck4Njfy7Jwl5cp60s1H7mv3GBlTvnjGM04jy/rydPwd2rFIXDfNIzsGizF794svWE2bP3o8/k6v7DdVAAOWfrcp5ZI0zQ7YCYrWeWrv23Qc/vMlSk0VCTxCWe+I1StSyaN/T0h1FdItKPGh0OGO4keUGGuOO3NZ5N2XtGuUagD1YDULKrQBm1JlZ0bDspu0VTMQlmgUV37lmxfGJtyOe0Qeb9wRuVlKf2KONuY7WeruahNONFU80qXPdqItaTQMZtCoH5vbNtdfPnF9eGYWYFuzBkk1v7b6L3POi0Wt83Ir9NSsIDeFddX3YZZy42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLVfjQvwIaKPLxk7MK99l/+Dgkp2XVZMK4b2GISnKYA=;
 b=lyX/cjBYIi3hVPrtU6WnDRfeQBlrHK6YF02hDPIre6LdUGg/aAhQ+9uaLmoF3y3OWUN9ZdihjFelas5Pfd60Iiq33ttN5R6qOm3uQ7tbyBFyuQK08wAE4FpEtf9WirhsBN4kOBtJQNcj1QoaN4K2T+kNp3z5yO7TzYm7q2hk39TjRfOWJCNukG5AJ7lrGQBS9V0bfoUcfQTgh4kQq4B/ygGLsJDqXZXsp5mJRPDQ0R3P9uv+AslDiosL/odTp+OK9oCV4BP0gY4TGOk+3jH6LHEKaqh89haM++QVek2siX0LM/myGmUwkAChf6EbdgjMVDEEW2miU0B56qdEkAxTVQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 01:47:03 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 01:47:03 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 net-next 01/13] net: enetc: add initial netc-lib driver
 to support NTMP
Thread-Topic: [PATCH v3 net-next 01/13] net: enetc: add initial netc-lib
 driver to support NTMP
Thread-Index: AQHbjNiMrmwkTzPG206zUiHxDe17mbNmtIkAgAAxcAA=
Date: Fri, 7 Mar 2025 01:47:03 +0000
Message-ID:
 <PAXPR04MB85107A1E5990FBB63F12C3B888D52@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-2-wei.fang@nxp.com>
 <20250306142842.476db52c@kernel.org>
In-Reply-To: <20250306142842.476db52c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7279:EE_
x-ms-office365-filtering-correlation-id: ea4faed5-0803-4bfc-9165-08dd5d19f5e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+mxx7ubGSVjbh0Qweu2M8mvPswQOQukukSLXKHKW41DG7agnPEn6Fh7GGiko?=
 =?us-ascii?Q?5S06m7MP53lWOBK9i56OFVAz/wa/rNzCHDiTjj/KjK0HdPWGx7L8a8c7KtyC?=
 =?us-ascii?Q?3c/sZ+28g+6KwTReOdrzi/UtNk79Cm8JQnE7MdB9pGdfhXwUAhWoIMDVneNR?=
 =?us-ascii?Q?WmXNyO71biExW5axeXPUPs6bivbXhB7Gz8SjKXJoJFTo78FpTrS6lmVWYtib?=
 =?us-ascii?Q?zzFv4mgM0SFZ/n9N0PqwsgSxThTWzWZ3X488cuL6DRGkwycleJ7kvoqX39CY?=
 =?us-ascii?Q?FFPIVhH76ZUmqnXqV7ln8hfN0XoRJHRFCuHKwawcshTI7toCCAnmCikbUW67?=
 =?us-ascii?Q?MmfGxoNIXX9QLKr/z5ELt4oLPqGZXzul1Nq8epL1kI+Fkdk3Z2XIf7pyFpRZ?=
 =?us-ascii?Q?1wDSKCEKfAvxlH5IGz3zenhBZgmUb1jbzDksLHgEKPT1JB3De3wqFAWLsyk9?=
 =?us-ascii?Q?FpbX3zGhGpb1blS61OlNyBKhYEj8oTWMk6YoClQP7KdBaU93NeFXtZiMkWXY?=
 =?us-ascii?Q?4bWkyHjrpH3QX+SbpE1/7jZW5QSAf96dOlfHs54WVu3mMtrLqE8vglFb8osO?=
 =?us-ascii?Q?TUjLsd5hajvTkdpTdv6T7BRD8rNWp9AyX81bn/YPBq1Zs/xNJV7FajepXJtF?=
 =?us-ascii?Q?dLUCxbyDqnCn9iKfGWeE3de4Egp5JUVdbKtF0IdajUQbKGHs5YLFWXemICGo?=
 =?us-ascii?Q?enO+OEJIfC3AKq/ioYJV9DxEo3/2T5S/t4h4DKrVom5JjBI5Hv4CgjXUvZFl?=
 =?us-ascii?Q?zZ5nwTasz1vW+lSkXP0TX1QrXW28asv/UsJK6MkdPsywUrp7lCT5VGIpERCW?=
 =?us-ascii?Q?famWOo2c42//U3uGVCbkTVJPhO0q+cTIGD0NZuIf5qyGBLzu3hn2ND+FkUEc?=
 =?us-ascii?Q?4H4wKV0zF+4p4Ua3IRDYIJV7vs6oGp5r2rCtMMsCqCpVHXjHiwIyxQQLAhYo?=
 =?us-ascii?Q?pbNSbVyxJFWH0182l5s5Q2tOadY/W52YLJS/Ba2CuaUy7kqvl7VpDieQusY+?=
 =?us-ascii?Q?TmVVGmwEvgAY5LjBl0U/EXYG4qglqz6KCVgxtuMs/Dxc6OPvc4+zvXYtcITZ?=
 =?us-ascii?Q?PTzV6V1N57Cg0GwnLA21ENrRn2rGa4mpSF9BBWp5mLLEFDGauAUwhJGv0Bjl?=
 =?us-ascii?Q?tiv2nnXt+GzK194wb05NZtfWKmCNS/uIFkULl4S4YMo51X8hCtut3p/SUNp9?=
 =?us-ascii?Q?cnhkRD0qWK1kasuWAAA5NKk2Mkdz56W3sQbd6do6+1NgktZgADf7Lr1GXLyO?=
 =?us-ascii?Q?v68WvKX9Tw79FNe0ZPiNmwadYe8ZSrNwSfHqGryXGrG33Cix7ftnzBI351rP?=
 =?us-ascii?Q?QeIqCAcAD5F/0pcvBIntQoa2PZR5USmqgIyQGkeQm08sC8hqTFlm5dMhOs8o?=
 =?us-ascii?Q?JczecEhZWVgjTMa6YYNxFBbRFu9x5JuqEPsjfznaWCdFqHMHLFGTy+Lx+5LM?=
 =?us-ascii?Q?9jPUca06Of5uA6YD2z2HEQXbQB5svwdO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GWmR+GNkI4jkqDy/jX6mFLB3GlvYGtmABvCeKy0CI7vn+8g9gNtMcLk0hyLD?=
 =?us-ascii?Q?3FEp0g0wTeUPqw6Nizi/knx4ZMYRIndpsCP+1AZCdKw6qBNWwmAQv5DERpWF?=
 =?us-ascii?Q?wPrkhlGNaDwO7xOsRjUN2/yvKmAukWwDsd/n/KoD4C3WDRF7qTAFTFm+lRo/?=
 =?us-ascii?Q?jEcdi+3+LIJaCsgK+o4w5mQjjA45zuPpkOefLBMTq3TF2v5mgi3GSTzbkdqP?=
 =?us-ascii?Q?v/f2f9ejoNmQOpM+CzgRwmndVXEmo5PC4UsVtz9rj8LOSiuFgZDROOg1V2Ik?=
 =?us-ascii?Q?CndW2raQcpHritW0fMHtKqTv3Xw/RpbjUHPpcxCBs6eBSvhC+T0nwv/LDxDK?=
 =?us-ascii?Q?PSNkE5HrhjYbO4qGoq7cwvRoKYlhL7fMSOiKirSgjL+9D3NqhQ/k9R+QU1Mi?=
 =?us-ascii?Q?Sz47L43IW1kZmwtYU3BsxMJsN4ZVkvGiewKkEhdDRMVzSBdlJ6iF74Zf8/mG?=
 =?us-ascii?Q?annlI1Xcn8RU8uY6+OzE4X0e74CNVi+UFEGpwamdz8nDB6hI4JyLBOHgw1Te?=
 =?us-ascii?Q?0sJQKS2Xe1HTO5iWV5rzP4yRjtNynGdjts4e62q8G6VX7Prwhma8DRlhhZNB?=
 =?us-ascii?Q?npGzjFzni2xlibtngLBMo7mJalqv9dz8rdmSsucboJs4yNqe8m1vFbow7PgB?=
 =?us-ascii?Q?hNoSSSyX2Ygfq8gtvxTTdT3rDdElqcIVTaQLydV3MfNnVeMbCPLY/PbQYs7o?=
 =?us-ascii?Q?vnEDZgMReNIYRRP7VGHTDnbwZbBiKSA17CWC5GNtvPCOBPpebMxHU2ExP5pv?=
 =?us-ascii?Q?JIYR5ke8qL0DOMFVHD16PuBUv+oEV/G4+CCV66vIhVF+0xCkJIBh4fq3LJrr?=
 =?us-ascii?Q?N6/A3jffvRSTwKS7iemVgjv2vrPueyyrWkZGDghjY5b3aO+b/tt0nJKdXXwq?=
 =?us-ascii?Q?Pkt/u5VhGByaCuWcX2XFXOChdpTziZ8q6NoWuWuQY5vjU8fiSMvPMNVAJOST?=
 =?us-ascii?Q?rdMCU47qbGmrdFLjik5rE8fUFlOXWeAv8pUQ+/6ccoSdQWf/InHbsoJr4Vid?=
 =?us-ascii?Q?z59r94EsjTd2NTtUAkR0hpfAdpaZoN6PUPgONXYoU79hy2IfW3cWakCZelGb?=
 =?us-ascii?Q?TL336vJ9W8RoyMmavXRAJLoLYSKQW9394CfPtiwIBMZnmKx6NVpUe5J4vYai?=
 =?us-ascii?Q?BrTHkiPDmda+JoSmHJhIklh28O69GpU2j2v7stadKJbQJW6aV5/xjDp1u0co?=
 =?us-ascii?Q?vL8Idjn/J3knd9SQvNt0nwlThFtiFBGPlDVwD9eIfRFLP5BWfve6cfsTENlh?=
 =?us-ascii?Q?418Akm1WrlcwLgM4LgXLXljbOVc04Wvlr2mhCBVGvc3pE3oq+Xyn1Mt5fHEt?=
 =?us-ascii?Q?SQOPLumZw362BKKwmgh+YuuyTCJ1c+MPWxisTEdiDXi1Wh7aUUJzmWOHUhjf?=
 =?us-ascii?Q?VXxKc7UCKQImBXAHcRKyGYgbaDcPO8YWuSy/nENVa3dgjRpXijlLMWiLA1Ai?=
 =?us-ascii?Q?qovSmsyycHTiNI2IMIfKyoe6qRrwQEf18eJ2p51LhSM07VYzbwWki+WF4/De?=
 =?us-ascii?Q?Q/TisdLqOi8FwoaYYEZhCBhiXWnRES1w7A+nmKdEpsbYl6POMYHxLpk8BG+1?=
 =?us-ascii?Q?2UqBORTno4Sitm3Bq9A=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4faed5-0803-4bfc-9165-08dd5d19f5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 01:47:03.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBOrVYtwHDduKPAQx6996tW8nmOVPav+hbr1XGH6jN/mvACKaDuHuBakOuSs9APwAXt2/+mZODIOjc11ocKGoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279

> On Tue,  4 Mar 2025 15:21:49 +0800 Wei Fang wrote:
> > +config NXP_NETC_LIB
> > +	tristate "NETC Library"
>=20
> Remove the string after "tristate", the user should not be prompted
> to make a choice for this, since the consumers "select" this config
> directly.
>=20

Okay, I will remove it.

> > +	help
> > +	  This module provides common functionalities for both ENETC and NETC
> > +	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common
> tc
> > +	  flower and debugfs interfaces and so on.
> > +
> > +	  If compiled as module (M), the module name is nxp-netc-lib.
>=20
> Not sure if the help makes sense for an invisible symbol either.

Yes, I think it can also be removed. Thanks.
>=20
> >  config FSL_ENETC
> >  	tristate "ENETC PF driver"
> >  	depends on PCI_MSI
> > @@ -40,6 +50,7 @@ config NXP_ENETC4
> >  	select FSL_ENETC_CORE
> >  	select FSL_ENETC_MDIO
> >  	select NXP_ENETC_PF_COMMON
> > +	select NXP_NETC_LIB
> >  	select PHYLINK
> >  	select DIMLIB
> >  	help
>=20
> > +#pragma pack(1)
>=20
> please don't blindly pack all structs, only if they are misaligned
> or will otherwise have holes.

Because these structures are in hardware buffer format and need
to be aligned, so for convenience, I simply used pack(1). You are right,
I should use pack() for structures with holes. Thanks.
>=20
> > +#if IS_ENABLED(CONFIG_NXP_NETC_LIB)
>=20
> why the ifdef, all callers select the config option

hm..., there are some interfaces of netc-lib are used in common .c files
in downstream, so I used "ifdef" in downstream. Now for the upstream,
I'm going to separate them from the common .c files. So yes, we can
remove it now.


