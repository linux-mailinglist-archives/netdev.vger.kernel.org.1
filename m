Return-Path: <netdev+bounces-195230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B28ACEE4B
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DF43AB061
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535CB20E031;
	Thu,  5 Jun 2025 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJp8o1PM"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEB28E17;
	Thu,  5 Jun 2025 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121553; cv=fail; b=lCcq3k4EsoKFx7lfckCMT38FceVXOaaPliwgMr3khSwbK5GOUumr75GmNaik+2F4NFXeWsEMNQRnKHMaVlgsMQ4yD0tDA+Z+QWY7GaVeHOpV7eOAE6e56gMuSxaE6BQWg5Czo6pcK1D4qN8K8N3o/zePwi/8KLWmizxpjMHFyf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121553; c=relaxed/simple;
	bh=aqL+jJjnM+F5+o9ocnSzwDJSUzokkLte/QihK4g4QDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcsaDmE3EWjTbLL4KJsmlxDeNuIYZI3Ad9og77zGKWzNOyX8BELQr/Y4W96Kl4Bq5LvXe5dzhc0AZ1GB0gKYimb/Vy12DmzD/Qcl3GM+ew96cks/H77f1vqkafuM3S1/lLjVKtPsChoG7CycHb2ZZo8WDOnVtsYWrJYtUHFVSE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nJp8o1PM; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/entrX+HHi3hBXPQhuuSN8cBfZSAg+5zZurCiavm6jUfjBMDCbXjAMSXH88tpzALPe344scq9g+qBvAdKuUrwWkw1hjJSX/5T6+rS83EDGbFGjcvY30A4UI01iYbaeJWjFoivgekpFYF/ymwSjnttOK4ZpsEJgcMAxkB2QRPG7spiUeIkA5nLtZdo71Q7R1qyToVsR9ge/i98xe7ZkKLcLymE2vPHvF+7vfgT6gHSncxFoGnQAE04NsV0PEKzPZCrd54ZwrNQtXhAocqLtpT5Ih1mDFt5CiyJ6Rb5kehspk+rs3NPshjobdhYi/fFr6YHCgY5w80gcyEkeXxcp8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncy0gzqOc45mT8fsdyJDGebUOOlXVYX+ly2ZvuuDAI0=;
 b=NZGbKvOhAdzwALI15TUQmx3+o9GIylj59PCPDta2c2aZW9g/PSGc/S/HxdAbnTds2hJHPW4fGGQQHeY3ryG+Ju0LxABrYESPssnc/ck6A8xRFkHn5Cm6pgweIF/itp3IINdRVIZe7gKpZhKEnftQaODjYClbG/+cKYU5AtgsmQJVFoTliXRupmUbCKOCyydHotNVyIOhyssU8yOA0VgU+scb5ouSF1kPvn7bplqQZ7L5dt+4gtJ4GhD8V09oTPcQWeyjLVqGRH8AGGAprUUwTYb+Np+Rs4F1OjhRkdjcB9VoK6m4aW6XFCSaJM71GNKyDkzTlk/NzEwOFm5v4NKnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncy0gzqOc45mT8fsdyJDGebUOOlXVYX+ly2ZvuuDAI0=;
 b=nJp8o1PMUupqfdnglgPu1GQhOUkuT/O43xo9ckmWyVcHAV8eJwH8jJQWM7vo07KrZSWkUTuhtr5nZ1t6/ZYBZfWg91tpJ66qAFDaHbtlhCFSV/I5iFL7zm6FlSGkKNPzW1/wzV7fvP+kX1uHEHB0d/O8cXX45ZtyrdCW2+SVhu2+P1LbX/jQxZXV2at+SMiu2k6Wei4Oh1yhokQsoI8rykAGR5Z1OhRF9XwqnJgp1hOGCE9HkOvgTtOtFqzU8kqecaGGm7xCSioZtY5lz2gdgfnP/S3gl//jHhjgqwmyDJGpeRIsRMM6RHgM01jysakChhoaT+0hqz9vCsB8XwltNg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV4PR04MB11331.eurprd04.prod.outlook.com (2603:10a6:150:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 11:05:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 11:05:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"arnd@kernel.org" <arnd@kernel.org>
Subject: RE: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
Thread-Topic: [PATCH v2] net: enetc: fix the netc-lib driver build dependency
Thread-Index: AQHb1eMWCvjpAXizjECRn0e/ijVtDLP0Q5QAgAAhgzA=
Date: Thu, 5 Jun 2025 11:05:47 +0000
Message-ID:
 <PAXPR04MB85105D979659D1B8D753FC94886FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250605060836.4087745-1-wei.fang@nxp.com>
 <20250605085608.dyfp6zy37c6i3qnp@skbuf>
In-Reply-To: <20250605085608.dyfp6zy37c6i3qnp@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV4PR04MB11331:EE_
x-ms-office365-filtering-correlation-id: b9ccc515-e291-48ce-9d49-08dda420eccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yUbe5BM+veZYCRDluf/1+eDBepKFxnBEjp4nqYNHfbq0QDwFS8Py4DkFzv7m?=
 =?us-ascii?Q?4IlXwvIVJH8faNgrfHmfMdHh0C4UK1Be2It3H1yLuw8pwRTKdGJE0NQOjB2f?=
 =?us-ascii?Q?kAq+z6dLATPQkJEXsqjLQ/XNVxnAphE+SQQzP5aFyG1BanHNBzaXTF4GvEvn?=
 =?us-ascii?Q?VDzomnfLFSKMiqaF2mRCJc82rH4FTQnBgi2B9XCOwrNT8ZdEDZ3OaUYJpd4r?=
 =?us-ascii?Q?eU8Bgz+axKwyeSQ8ZWl/RuprYS0K56TPYz4OKGpCRFtGH23NSKtJTFyexNsM?=
 =?us-ascii?Q?5OyRdmO9CegQdK3sZMyQApzttoCuAXWQSQKGJv9eMiF83lVqPPAW83w16qzN?=
 =?us-ascii?Q?Xtdr9aPvlboWuTWRnKXW5B6TWzZSoyIzXcSZXQ7H3+RbdQZBhgpzOAP1W6k7?=
 =?us-ascii?Q?BvhsxFycouJiVpQ70XdPo7/WID1aukPoUlZTJxxMdng4qx2DWec2RqfoF1Vc?=
 =?us-ascii?Q?kaw9JT2eUeC0Ankq/StfEaJaCJtmeFpHJgHfRem8q4ei0VdApkLFKt76FWJ3?=
 =?us-ascii?Q?NYadX/grJP6InYRiCNHz8VsYvL2Ijw0nP0J5B46qGz4KR0rCb3BG6Azp2uQA?=
 =?us-ascii?Q?qmDcLDkpGJ66o1k6lMsNechyEyJZa4KmEneKliZhNkcbutTZYR9GL0WvZWFu?=
 =?us-ascii?Q?3dR3w0lglTUutHqM4pksFL2tWZ/08SCE6rWvILPyyM5AB/tUyO5upUJBZ5R7?=
 =?us-ascii?Q?Iae3SL7lgrd1avRPD5mTHaibpxMQLZWirkBoHZ3n88DPPTLl/FJR+yjLKEHd?=
 =?us-ascii?Q?yOSr3KYafoMiLAFHmTat1OIf4ZoDquPsQfAK6ar35/N4YN3lQC9Mxa8z6Ey4?=
 =?us-ascii?Q?8tupIGlVPGgJRNsJtl/L72iMOvFuSy0l460tTIfehyDTdrf/eASOssL5xUDk?=
 =?us-ascii?Q?eyIxg1xVJYrS9xhWPK0lIFYeSk2euOLaLk7waqgnFj4X8Y4NYptRiA6tdT23?=
 =?us-ascii?Q?141w/Aw0zeM3Va647o4Rd8Mrr5WC8Cgl0idBcBlDJeNhu33gkNHA8pTg5vPR?=
 =?us-ascii?Q?Ne2NdYYwV2WStCNbEtS6a4ZTu9kTLFm7qIUPZzQnKjthO1CE8L4RJZ46oN4f?=
 =?us-ascii?Q?NoVFhNBtSWd/gjA3Vv8kfdE2cQsvjMhFBqKfBOuPUAmlr3+r8HH6Q+k6eQGy?=
 =?us-ascii?Q?9qlkhB6RIsCZguLqzktWWHGB+I4rVcLFQ64zCT77bfdGI/3huz7gVy0xmDwl?=
 =?us-ascii?Q?qFhBikZeAkCQDzbYOPXQpGuZtFd0PkriclVGG2Lef9Iny7G6q2Kk48ucWcXj?=
 =?us-ascii?Q?+HKaF5EYznc0BJ1grHtA7Z9hWUsqiyT63+2jfOBF4XF42Fg29kp3xzucFia2?=
 =?us-ascii?Q?vBLCTBTmx3GvwjZ0Q+RzxLmRiKUlgYydIS3foKo45RKRWhOQ5rWimGWcC+9X?=
 =?us-ascii?Q?MLhBH3L63zdh7Xf6WcMuhlpdSTrOd4rtYLYhMM3ZD4GSNfXkamxkMte0eiDb?=
 =?us-ascii?Q?VXP/M9Zk5r5eyT1kR+vV9GQbZ3Qf/w/YW05ZZSezk6pr1oxFt+glsdmZG95X?=
 =?us-ascii?Q?MbhanP58JXZtIgc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QUZrPHMDKqBhcTE+vGXJmXPBAd7Mw5U+ES+0uAqoAY82w7OtFFU/K5qgpvr2?=
 =?us-ascii?Q?TxYCO3Hcf3rhzd5lBcossECP9SFXKN3ey4w52YWIYWeNQX7vjtKuhkL+bVKp?=
 =?us-ascii?Q?Yn1QZ7QZJLq4sq7Hb2jbGkpJyxSvPeDSzQ01VW/WLsk2GP9rKN16VF2EUBks?=
 =?us-ascii?Q?DtPir55yEgI/9NmHCkS7NBEznsRuAYDnJJ6bELWn1aydA/58zx6U8X/FWg1s?=
 =?us-ascii?Q?GOY/aC9z3Vv2+b+g27nipOdC9QjILv2hPfaIDRqATqmklH+Kcmpv90ydd6Fm?=
 =?us-ascii?Q?yA3gsdA5OFo8JvF8E5PUZWeZ7JFJ4sfiBE+O7XEmNK0nsGX0DYTt/6oaDtvC?=
 =?us-ascii?Q?qz/gnPQAWzXeLz71TbfI7OxZgWDWdYRcP3EI8lnZS+CWNRgPpNwS7M84gvsK?=
 =?us-ascii?Q?XKq2frWWzzuIv533ZfFexNveCiR9NvhrAf13mF7B7+CPL1kuM70dGAzwvSJJ?=
 =?us-ascii?Q?vt0VQtQzCMWU6tNUP6MUoe4OxJ1iCqKbipvnyQC89UFnsHbOznPyMl68CcMO?=
 =?us-ascii?Q?QwNeWKae8t24RQqiSir+nLPc9iUoFb63ex5BtF6mnbo/Fzxr7wpVpmN1Iq+C?=
 =?us-ascii?Q?z9CEQ2lpSnlmzWhVR/89Qo/vrjeTwYyxy6KL93QTuHoYj4k8ZPUchZKaILBh?=
 =?us-ascii?Q?3ubBDabV0ds8EEd7W1wHVTngcMrS2q/9LCW22+ZDXjaAqo/81ERVv7X4XDdU?=
 =?us-ascii?Q?rSORtSdb9KT3OAh15rM9y0CG3CBei/IJu7rBdDuzF9/LQb95CYE2e+PdTkzZ?=
 =?us-ascii?Q?Frq0Ou3ZufFS9o8Q9N3FHKoB4EJaJvTuTx+jQrpppY/gqTiKQtlqs6iQCh1D?=
 =?us-ascii?Q?anAuRB5CGQOdGRooj+i4MQzJMTDEyM8Y8/X/Dj5205IK90x/O/+p6j6s8B36?=
 =?us-ascii?Q?mjH5znWLQTKGK/Ijb5PBfjU2iClefPJRj0NFYkLr5cuEbxe65qYtWpU+fTIc?=
 =?us-ascii?Q?XOYWzlO32PxbCGSROJtSo6nJlyMWtYP/Rxlmkk24MEkiCruMSPc3hNZYlkqH?=
 =?us-ascii?Q?tSdKPmqDA+AU2GIlRWCk7oK2emE9ROSVb0oDgwqHacBi9pyzbRQ5Mr2IGIkR?=
 =?us-ascii?Q?/lx9w/NQxJkIjign3MJDD93AIdfRNGuJPyvpBJcQuwZ70E4BHaBjA2UkvaEd?=
 =?us-ascii?Q?gCkaOcaujzYzbF/gQhcu5emaG814MFpDDav7OqYv5G25txYnjJjZFMOkHBUN?=
 =?us-ascii?Q?4Jf3RCQqVq6OBz68z8vWVaFl0Qe3A2DNermyOhYU0SxotyScqf05RlmQhSnP?=
 =?us-ascii?Q?/dKrZhbT7u4uX2gUoKT5UowfuokZVyKIpVnPgtlua6s9x0YpobamNOC0TTAr?=
 =?us-ascii?Q?9mWGlFCdF6sUjwCSAGR6ZWEwx2e/fCOwwuL2GaOVUd1PEiiYXK6JehSHByOf?=
 =?us-ascii?Q?b8Oyn0yY1ULtOu+bzI1Kdw4aX+rIM2RKMchzqGlFtQqJN9jcVqXU3nzp+I62?=
 =?us-ascii?Q?QTUhgbmjui5jbTqb+5oGyKMtxE2f4X8dBLzkoqbRcYkCaCtjaps1oZxPuKc4?=
 =?us-ascii?Q?A0vJhOKhmpPtE9oR0Y5v1h7JQvpsNXJ/2beBak8JBJLbZEHjUsYbftKzzXB6?=
 =?us-ascii?Q?e+DWbMIAXnDbj0EYGUk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ccc515-e291-48ce-9d49-08dda420eccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 11:05:47.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y07iPA7ixV1HGDIt6F/NgCUklZPtL+Nng9ZYDfQ8ngL6S8Vxbd0lhHyTvOewZQ+s6K2pcsYcXLPoexR/s0Mwww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11331

> On Thu, Jun 05, 2025 at 02:08:36PM +0800, Wei Fang wrote:
> > The kernel robot reported the following errors when the netc-lib
> > driver was compiled as a loadable module and the enetc-core driver was
> built-in.
> >
> > ld.lld: error: undefined symbol: ntmp_init_cbdr referenced by
> > enetc_cbdr.c:88 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:88)
> > ld.lld: error: undefined symbol: ntmp_free_cbdr referenced by
> > enetc_cbdr.c:96 (drivers/net/ethernet/freescale/enetc/enetc_cbdr.c:96)
> >
> > Simply changing "tristate" to "bool" can fix this issue, but
> > considering that the netc-lib driver needs to support being compiled
> > as a loadable module and LS1028 does not need the netc-lib driver.
> > Therefore, we add a boolean symbol 'NXP_NTMP' to enable 'NXP_NETC_LIB'
> > as needed. And when adding NETC switch driver support in the future,
> > there is no need to modify the dependency, just select "NXP_NTMP" and
> > "NXP_NETC_LIB" at the same time.
> >
> > Reported-by: Arnd Bergmann <arnd@kernel.org>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202505220734.x6TF6oHR-lkp@intel.
> > com/
> > Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to
> > support NTMP")
> > Suggested-by: Arnd Bergmann <arnd@kernel.org>
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > v1 Link:
> >
> https://lore.kernel.org/imx/20250603105056.4052084-1-wei.fang@nxp.com/
> > v2:
> > 1. Add the boolean symbol 'NXP_NTMP' as Arnd suggested and modify the
> > commit message.
> > ---
> >  drivers/net/ethernet/freescale/enetc/Kconfig | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig
> > b/drivers/net/ethernet/freescale/enetc/Kconfig
> > index e917132d3714..54b0f0a5a6bb 100644
> > --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> > +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> > @@ -1,6 +1,7 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  config FSL_ENETC_CORE
> >  	tristate
> > +	select NXP_NETC_LIB if NXP_NTMP
> >  	help
> >  	  This module supports common functionality between the PF and VF
> >  	  drivers for the NXP ENETC controller.
> > @@ -22,6 +23,9 @@ config NXP_NETC_LIB
> >  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common
> tc
> >  	  flower and debugfs interfaces and so on.
> >
> > +config NXP_NTMP
> > +	bool
> > +
> >  config FSL_ENETC
> >  	tristate "ENETC PF driver"
> >  	depends on PCI_MSI
> > @@ -45,7 +49,7 @@ config NXP_ENETC4
> >  	select FSL_ENETC_CORE
> >  	select FSL_ENETC_MDIO
> >  	select NXP_ENETC_PF_COMMON
> > -	select NXP_NETC_LIB
> > +	select NXP_NTMP
> >  	select PHYLINK
> >  	select DIMLIB
> >  	help
> > --
> > 2.34.1
> >
>=20
> I think you slightly misunderstood Arnd's suggestion. NXP_NTMP was named
> "NXP_NETC_NTMP" in his proposal, and it meant "does FSL_ENETC_CORE need
> the functionality from NXP_NETC_LIB?".
>=20
> The switch driver shouldn't need to select NXP_NTMP. Just NXP_NETC_LIB.
>=20

For the case :NXP_ENET4=3Dn , FSL_ENETC=3Dy and NXP_NETC_SWITCH=3Dm, if the
switch driver only selects NXP_NETC_LIB, then the netc-lib driver will be c=
ompiled
as a module. So the issue will be reported again. And Arnd also said "The s=
witch
module can then equally enable bool symbol."

> I don't agree with removing "NETC" from NXP_NETC_NTMP, I think it helps
> clarify that the option pertains just to the NETC drivers.

NTMP means " NETC Table Management Protocol", I don't know why we need
to add a 'NETC' again, it does not make sense to me.


