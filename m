Return-Path: <netdev+bounces-229148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37A2BD8A28
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C453A5009
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A42FD1BA;
	Tue, 14 Oct 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RCo9PFVW"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013005.outbound.protection.outlook.com [40.107.162.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258282F7AA3;
	Tue, 14 Oct 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436020; cv=fail; b=ZX4YnJInRnXSF1zA98/tDBDgvuuNfk6Q9dWZNmnxKWP+IUE1Jz35eMyOwL+o51/IkzofrypAL1eTpw9EFYcXmcPFUsSrJYcsYljqqX9jzf2Xqz5WGnQWYUxjMQoAFDmwAMa/rTYuj3okk0PeDkaHnHUxtgbxwEUaZnl3RK2GQn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436020; c=relaxed/simple;
	bh=/n6IzfiB5z77G1Xm3T7OdiRIOr/NP9QToC5PAmSIj08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/C+I+GxM4OJmSl8pEs8nv64SVfVHGfnPI8bStSRUuVTRG2cLhbm6lD+MGVGve1IEKVOKiN2ZLa9hSf0V6h68Ub4rbEPg4ZfeWqMN53/PkfijMuS6/e3JI/TEXN4BGalrC+O3ab62qD8/bV/IyOLTG109S7qqGlMQY09u4Kmilc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RCo9PFVW; arc=fail smtp.client-ip=40.107.162.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dc5O66U2kYUwrk7oQwdH+6RbOZpuTuEEqvjLqTv5qqiJiilG3erIsIymlqRrOxGZafLfcvLR2l3nNF1QrCKWgHDGplNQBlp6bIZwAyw7HyysmuFHO3Yzj5cITHanmVSRlPCP12h9N3dcblvSh7sOPn6EwuKLBMHoDRYQPkIxotIU8P7N/XqbSJ552nhXfeNRK3bwRNz56XyeOiZZFHBaZC2shSK1fviS01dScKBgrgJcFRQldQ0w9Yvkm4svJOcusbZ/s3rYX7AIhiV2ZqKEoe33dnAYZ8R+K3YnBEwnZbTo0y2BrkgGnNAmjGWALNIzM+uSqNlG1KNJmXqHwg7Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9kdL0EqYJAF0pZ6ZQRCz+p2HxWEBDU7HxyEZmwhDY4=;
 b=IP4VDi2gcjtBMF2Tysd8O2ujq0/L7HJDLDSBYCVxU2LOTXCC82ea0HubyENu8dgwKsDJVHMNj0rAgH8geBB8cX17CU7pHz7DLUoK1MDhN+6QqEKeGBib2pPlhY5tgXWEv3NONAjbGSglwwuh64GOcFMqSiKZd3zHnXyJAiMzEPVydHuOEllad5mbH53bU2AAZ67fqhYUnx9wR/42Xfs+Byp1kkEd2qeoxwuza6Lj/nzIGg+0IoOuq8pEVJcDVprAiFLfiAoqUGU05JW6TU3qekEQnOuLpBAzCQF/dT9177ErZ77If6n0JYnpf8ai9lPZNDGHSLELcxKB5qfgdnsM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9kdL0EqYJAF0pZ6ZQRCz+p2HxWEBDU7HxyEZmwhDY4=;
 b=RCo9PFVWqLt/9QxFS+h2jgY7LpNatyr1/+fqyxoZicDBjnPW9YIUGYXDT5xGp56g+9dDc2tzZz0Z0/ihmKl/jYKdVpeFyrJ4rHlheyri84fx79llHBSdDMVzzaRX9BRgpk3nfKfjjwvzXzVZPvKrZch24sTgTYrLACkzIfbI5CW8jtkkTZZbpABPxZdaovw2hUSnk9uRZJUpwPDuhLT+8wvMDUWobr0FA9q+QoAv30f6psmp8v1fWKd2RVbb3ALKZF4IekFg6CVmWBctr4lRxPA/k/LiLgxlNwui5JGwHgqRJke1i/ZB+YLWxFz/sr9qjUq+BU6hAwQmkYsxyvv4YA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 10:00:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 10:00:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Topic: [PATCH net] net: enetc: correct the value of ENETC_RXB_TRUESIZE
Thread-Index: AQHcOcsiKt52zsPKAk2fo+9Vq3ZFNLS7VNgAgAA8FwCABV0XoIAAeU8AgAAEuPA=
Date: Tue, 14 Oct 2025 10:00:14 +0000
Message-ID:
 <PAXPR04MB85106C49873A85DFB61DFD7A88EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251010092608.2520561-1-wei.fang@nxp.com>
 <20251010124846.uzza7evcea3zs67a@skbuf>
 <AM7PR04MB7142CA78A2EBA90FE16DF83B96EFA@AM7PR04MB7142.eurprd04.prod.outlook.com>
 <PAXPR04MB8510610DB455D9CF2D4E295088EBA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <AM7PR04MB7142C31C1EA26B48E92042C596EBA@AM7PR04MB7142.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM7PR04MB7142C31C1EA26B48E92042C596EBA@AM7PR04MB7142.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8857:EE_
x-ms-office365-filtering-correlation-id: b7ffdbc0-21f2-43d3-623b-08de0b087891
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JrQYqPPxN5Oxpt5EhlkjQhq/RG+YYTUJrhw5Uwvmcs8IXGh9+4a01IamzArz?=
 =?us-ascii?Q?ojm+Ix3tEzSQwQtHj7rmFB01sBsDV9kgQ8gF3cuUtLc1SKZnAACcmkXkAmAE?=
 =?us-ascii?Q?rY747QGFPEikGLP6P8b0d5v3NuL3/uHDpLnaymmiZtOqaYOPq7dZXZKEJamJ?=
 =?us-ascii?Q?9u0zOUt4QybdZhVlTtKSmXKAVvL3KcSGisJk0KB/L9PJAQS/De14XPJ2lMbH?=
 =?us-ascii?Q?jQKep7nVILL3VelYocw3KnoWReo/wivLjQ3lw+zoz9F1ySq1+fFgD2841pxP?=
 =?us-ascii?Q?5R3QnCLV4t32KArXvPImsE3OrbOycf/p5/zGqbhcmgY2iI9ljnE40WEk6Y/t?=
 =?us-ascii?Q?GSTou2kY3RnVKP0jjTvHj/IFV2p4i3u0iAEu7w/4aOwt2mju+ratMTv23cZ1?=
 =?us-ascii?Q?PjdIh/wLPWLJPuD+u3++L5Uo2/xpjLTYEguM96IKtGdMpOPT4DkpkGinkAlv?=
 =?us-ascii?Q?4HuxIqQEunwzE8c3MxyZ6SexU+NhgocM4Wpq6Wb5Je5x9p+SL4IKK9ISdwmg?=
 =?us-ascii?Q?rsHIl3KkowOazPEnI47st5Pt8yFngmhatvAQUuWo6FXCiufkDL6LX7300Kvf?=
 =?us-ascii?Q?1EX2IiQsy1eL7cuj0q8MA0TwH7IvsLBEO7qMmIkGMBN4rqcjMQNuS2MEjKu2?=
 =?us-ascii?Q?15GBoywmiqy+lyDUsBiWkGrFvwODYWZWgFmZv/p8mkSqcGh1ZizZB/L7V2bp?=
 =?us-ascii?Q?BJWqsLdIhuVp9uQRZNJ3COhXSRYeRXtxE0hC/3fC142A+vWCsr81PE3Di5xu?=
 =?us-ascii?Q?c0eYUHzpCgm0or9w8FUIXmGWD7Nf5JaJeXPoI0G3VOMJe4gGMnNbcej+ZEdA?=
 =?us-ascii?Q?jtIjoKp+HtYmnI9nAXtXvU/9J+lpb2zB2H4mWAZ+8wKAf4OIkRP52Ldk0M+l?=
 =?us-ascii?Q?Sfwc5C/s3+IeBo8TAAjo22MfZjyznuODF1gEffA9AuC6Vr3bPxYraMJ2BRf/?=
 =?us-ascii?Q?yFIZNxeygmJllP6NCJNd1uKucVpDnp+vCiUPY9JT9rjpCM25ZSSHggMk7kl7?=
 =?us-ascii?Q?fxa20J4kP0pk6V/mWGJMxlhemlH2gu4kady95jc02XOspiTchrWFHUELLV6W?=
 =?us-ascii?Q?IgsVvJHT+AJy0Jz8p6+c4i/9ycm8fIDJeWxYRg7R7cka2HMaMN0F7TDwzErI?=
 =?us-ascii?Q?O6Ok2CON5BO+ZoLox9nDJK2NcflHad0nB7Ak19e8cMtwnVXW7Jh1oFD7rsnX?=
 =?us-ascii?Q?KEOzyM0XdMjyXotir5+zfUwTCXF4ItOoQt84rHb9gldKoAk+mluao1gFbs0A?=
 =?us-ascii?Q?JXH3YRnl/zk38I7bDcs4yCXhffOwpfhK9PzI/2VbXbN62dIS7JxOI/iYdBa8?=
 =?us-ascii?Q?8BIInBdIrCLCVsrzrxWcIhA45FlS5HDsf3JmdyZx6rLE34DhotNtzv/8Jb3x?=
 =?us-ascii?Q?dutmRsyd1AQ2D2Rgq6JyqkxSAW7xD9hcOg7ZI/2Uwr8IiNUU/3m6/YQzJdfO?=
 =?us-ascii?Q?39kPU8VAq5YQeCkklegERE3YubpVVjEUZ9RdLGxEaqplTZ2TBYJF6CER3lIV?=
 =?us-ascii?Q?ahj6UWyNQUVjssQfprQd8um2SX0dz4HIHYfd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?m4X8Jxf3pdnXbM3ilwfd2E4UZoF8wdhztEmZTthIMcRb3LaINHFP5jFkv4g+?=
 =?us-ascii?Q?58IKB1jQwD18j8pjDA0PN2kOVpg2o0yDMFM//uz5ItTaOj6/yRQsvTI2vy6p?=
 =?us-ascii?Q?Pl5c9cEmilX3xzHwjR/7mzcDEUp0Jzhxheh3sdhv4ZNPBiOK9EqR5vUlf+WB?=
 =?us-ascii?Q?IMRvy2tRZjUa4olWPMdDeUm+fR3zjJGH3YLy1TCc/RgmEfum00jWrteZMzmd?=
 =?us-ascii?Q?t76p4uk8ayGNMX8QWWlKSNSprQg7pgNDBAdtI9dyU5RR+eBKwmNpmqxdZrYF?=
 =?us-ascii?Q?gB/TKg9+Rcqf+Dif3lM3iV2/0jCEx+jrQW6GPj74xgvRZktQpfnxMhioLYSF?=
 =?us-ascii?Q?vCgQ/1mN6MlJ86XO2rv4vbHNdRO3XwhIt87XYaKFGCgj37Ne0chAShd10NCo?=
 =?us-ascii?Q?zf8wfcQl7Mm9mSJJkKhXNDbzMLrtmJFfD0SiKbOSgi1OwfTlVbhizT/NovdL?=
 =?us-ascii?Q?POuOzn3gmdqtYhu9D1yDtrtZQZZ6qSFYGUTXyfDe+TEctwMNnvCmE3PFilVW?=
 =?us-ascii?Q?dssNZqSkns5+rpv7/VIeW/PXuc8cYNKtIKxMzYnYDMrHpp7/34knLFE+XXRU?=
 =?us-ascii?Q?jNmKI3uHiRIGEuNqcwYPHBJwpDT+QGviADqBuCNAvgPSTa4Cd+LzHyHAraW6?=
 =?us-ascii?Q?bUc4wMFE4E/jPLewAtAy6N6T8tetur3pJU/bovdcw6NdH514pGSLEd/mpT7f?=
 =?us-ascii?Q?Hjd8jP7ZoBq8cBoojbsTFcHUR+IGVxFhy+5ffpwqKKohUUeEXASYytFDbD8H?=
 =?us-ascii?Q?9fnXxQE+BxRcnVPzNmApomFlKnIZ3yyM2rI0za1DfDPGXMDdOzdh/qQasL0J?=
 =?us-ascii?Q?vJtuhfNNO0gdaU8KS0vUG6uQZYCZhDjUIU49vT9CeE7lP3tWjWVfd1/H/JO1?=
 =?us-ascii?Q?M90lOXRvPpNoJy6++cWNzAHidJyRhTrukvXppld3azn/P704T4uSqDa9zDUW?=
 =?us-ascii?Q?Gd9z29r6Xwvuf26BRMTLalrkMVS3lxzsiN21YO4Zlm0vFm49Xe3nKKw14cQI?=
 =?us-ascii?Q?h23UVV4/0KvXJFt6XDxc7zbZu+rDrE6hEDSLPKT7fkX9oBAO+dAgfCtU0tOc?=
 =?us-ascii?Q?jZvt00T4IKf21O6Gh2jQeCE1xtZAnNy8S695GKdfW/Tq99TpZmJyukeLJmLF?=
 =?us-ascii?Q?7e2fWYJcHEaRDb/vaIRpenVgQzkSaPP6o9k5KxUcAUpZpF9sOTbfY8jCF9VW?=
 =?us-ascii?Q?QFDpxqyu8JfNPTEIZ15sRQvIiTxMY0TvOJhAcyNhhODmdqpqtDAa4rj4d/sk?=
 =?us-ascii?Q?xv5YRv62YB4FwPbrVXAx1zx3KjbJ1Bv8NOh8kVRAj4/5TJ7/lOpj/88pvTJC?=
 =?us-ascii?Q?ePVWGRvrHOyRRIQEB2K6K9X+ZPvYZBR1QATa0qoEefexA7h3g2NJ6g17okAR?=
 =?us-ascii?Q?OFbdB6qD/l7egXxzdo3ZdKm0tU2uMEj0oE5gf1+J0Aan4cTnWzEW2k62DATv?=
 =?us-ascii?Q?QcZMputZjg0HblIQu+IVx+mr1Utt+uBJRVnLvRGndHEMIq5kCoowTecsamkJ?=
 =?us-ascii?Q?EOuLF6/f+JMjTQIuuACkhJ5wRj+GZfoa434gZBRjEObR8/J9HLAU4X9q0R/E?=
 =?us-ascii?Q?cDsIH63pM2/bIQa8BPI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ffdbc0-21f2-43d3-623b-08de0b087891
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 10:00:14.3352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLOBgoPM7OzinpzC8RyQ5RayhT//OtLkWb5al4s5jkzInFCcjJ+hFsJAJNB8m38Sfx4DJbp6tCIMu4vRfLenzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

> > > > On Fri, Oct 10, 2025 at 05:26:08PM +0800, Wei Fang wrote:
> > > > > ENETC_RXB_TRUESIZE indicates the size of half a page, but the pag=
e
> > > > > size is adjustable, for ARM64 platform, the PAGE_SIZE can be 4K,
> > > > > 16K and 64K, so a fixed value '2048' is not correct when the
> > > > > PAGE_SIZE is 16K or 64K.
> > > > >
> > > > > Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC
> > > > > ethernet
> > > > > drivers")
> > > > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > > > ---
> > > > >  drivers/net/ethernet/freescale/enetc/enetc.h | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > index 0ec010a7d640..f279fa597991 100644
> > > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > > @@ -76,7 +76,7 @@ struct enetc_lso_t {
> > > > >  #define ENETC_LSO_MAX_DATA_LEN		SZ_256K
> > > > >
> > > > >  #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
> > > > > -#define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
> > > > > +#define ENETC_RXB_TRUESIZE	(PAGE_SIZE >> 1)
> > > > >  #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if
> > > > needed */
> > > > >  #define ENETC_RXB_DMA_SIZE	\
> > > > >  	(SKB_WITH_OVERHEAD(ENETC_RXB_TRUESIZE) - ENETC_RXB_PAD)
> > > > > --
> > > > > 2.34.1
> > > > >
> > > >
> > > > I wonder why 2048 was preferred, even though PAGE_SIZE >> 1 was in =
a
> > > > comment.
> > > > Claudiu, do you remember?
> > >
> > > Initial driver implementation for enetcv1 was bound to 4k pages, I
> > > need to recheck why and get back to you.
> > >
> >
> > Any updates?
>=20
> Reviewed RXB_TRUESIZE usage, and confirmed that it's not only used for
> building
> skbs and in the page halves flipping mechanism, but this setting is also
> accordingly
> propagated to the hardware level Rx buffer size configuration (e.g. for R=
x S/G).
> The allowed h/w Rx buffer size can be up to 64KB, so we would be safe eve=
n
> with
> 128K pages.
> The 'PAGE_SIZE >> 1' comment is actually a TODO item, and I crudely limit=
ed
> TRUESIZE to 2K to enforce 4K pages in the initial driver (i.e. for simpli=
fication).
>=20
> So, pls go ahead with the configurable RX_TRUESIZE, and note that this op=
ens
> up
> the driver to new usage / performance scenarios, and user configurable Rx
> buffer
> sizes.
>=20

Thanks for the update, since PAGE_SIZE is configurable, so the old definiti=
on
of RXB_TRUESIZE is not consistent with the page halves flipping mechanism
if the PAGE_SIZE is not 4K, I would like to fix it in stable kernels, due t=
o users
may change PAGE_SIZE for some use cases. Then I will add a separate patch
to support changing the RX buffer size at runtime.


