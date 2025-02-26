Return-Path: <netdev+bounces-169935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C0CA46851
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E321D3A3D47
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0C2253F2;
	Wed, 26 Feb 2025 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LlPtbMgm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89BC2253EF
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591821; cv=fail; b=DgzstUgVls/WJZeToRKn2D0lnF36Ax/v2hpL+h4o4zhjRV98ATTNYB5vLzpsfbMZlaGL5RA98CTSSbjkJSgQkfBmA0CVonWvt+kJim1fZ1HpVdvAcvxQMXwEWOWgHMCTB3idkY76w/8sJLc97yxdl+P5Y+nZ2gO7G+0RyNGhOl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591821; c=relaxed/simple;
	bh=HgklPYY2gUcWTh4KAD0fhQsgvuAwwgzKi12LbQDMLVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tn49Qjwe5xFgzH2rczmit5wwZKg44D7rEjzQuqDp0wyiFvDRtBPOiN1BH/7xc//VurlbIAoLR0PNGWYtpn4FqrmsKJ2WKxw+koj6+AZGdWTzC4wETIwO2d6x0RXnTxMNIrqOxTp3kiY4BaNCBfUx2xOGoHdYk+F5VF98A+NpZlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LlPtbMgm; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn/ZAre+OqrKhutnOspZKG8vbMG1ckfNKYt7jt7j6t0I+p4Dm+HvfMPCxICA1fku9C/Tt7iMqo3TEZDJ6XHITsW51Q0aduvVhQXH1Zw7/keiZo/RCwU2BY6Cu1nltQNV5uNRoxFAZ/xi7joA1rUpcuSFVFcz751E/pke2YgKCZUryGGxpczTOSyb7pY0LaPrEGTvP6RCicoUwQ3SLpqJPxTf/sgu1B4aP8TrZMflx0EUAIKehk1cE+ETK4AUbAUJaO6vr7jpxvtoMZA3D+QU/9+KU/hbKyHDzpOM/nspgwO3+YbTnXZKpGOS3GsEiniOrf6QYWO33N2OFPpTfzP0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgklPYY2gUcWTh4KAD0fhQsgvuAwwgzKi12LbQDMLVk=;
 b=pGOV62slq5Q/GTTWKQL388viRb1vNvBtzSeECpx2oGRxQr2hnVuenggASQsCztVoAEpyA+ok7LX5EclciuK4TgRohqHOUzEHCKJlp3xgpp8Z4MeRu0+yUjZhXoatLmSD8jaKDKuojlSK+32iCvmlzmW2PwtH5ETHCnON16AP/2plpYY9GHFvY6rdm+oAlfjJpzXtHzFZduDQJwlKp+4fHYZUmgOz1Qhkl8aQSApI8kc98/tCEeVaDQva6VcwBQG8BANzVUPSamZSBYToBCA8h9qs5n8mr7Xvwm/XoiNejMsGSoTXnj7l6E0OAgpvoIfuzxrPc747l1FoIYC/W/KPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgklPYY2gUcWTh4KAD0fhQsgvuAwwgzKi12LbQDMLVk=;
 b=LlPtbMgmgLK8MXD26m7bAyiDvZLHubRpEqF1p2OnteHt6JpFtwzyyF4k/LePhUGuP6BcZbh3F/KF60WgG9jV1V1DQ4cFwABcPf6sE0fSUen3MY1aDb4Bhor87fnSKQzvrm+zaMvlhqFXS30Dk4Tw8ewM1mezoZiUA9Gx5sTlRSBBlkxziJTs9kTPWOTU1mhcMVbCjcqxYKLhfFfFcBFtP5tWfYZp+uWQVdgN1FNxiMsKs8cim0uh/WdWfk7evswXnaRK7tEfm17wYJlrcd5jCAT7RDsj3rA3Z4a7my2fDbmvTFw4P0LGnQQECpwoQj/IQ+XOsdtdDpgglpKJ/uTpMQ==
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com (2603:10a6:20b:44b::7)
 by AS4PR04MB9714.eurprd04.prod.outlook.com (2603:10a6:20b:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 17:43:35 +0000
Received: from AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0]) by AS8PR04MB9176.eurprd04.prod.outlook.com
 ([fe80::4fa4:48:95fd:4fb0%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 17:43:34 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Topic: [PATCH net-next] net: enetc: Support ethernet aliases in dts.
Thread-Index: AQHbh86Qxhmr48lZHESm1vGKxIPiSLNZvAB5gAAFn9CAABGCgIAACBHw
Date: Wed, 26 Feb 2025 17:43:34 +0000
Message-ID:
 <AS8PR04MB91767705160830CD63341E3089C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
References: <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250225214458.658993-1-shenwei.wang@nxp.com>
 <20250226154753.soq575mvzquovufd@skbuf>
 <AS8PR04MB91761FDBD0170D8773395E9289C22@AS8PR04MB9176.eurprd04.prod.outlook.com>
 <20250226171045.kf7dd2zprpcjrnj7@skbuf>
In-Reply-To: <20250226171045.kf7dd2zprpcjrnj7@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB9176:EE_|AS4PR04MB9714:EE_
x-ms-office365-filtering-correlation-id: 99b2744c-d02e-4feb-dd96-08dd568d17f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7YZ9MGIWLpIhrmmj8zNE74nh44V3k8u7uRFVl0W2lwv5FQn/xO37MwlPD7UU?=
 =?us-ascii?Q?YkvCz+nvRrsOz6JrVHMbqVNQ95kutZuDY0osSHh2vPbAyPZ0np59IlEecmxI?=
 =?us-ascii?Q?fYXqUALvtbPsRLU9JGcsU7z6JwH7VYIw5nXUw8I2lUboJZWgr+p/hgO0YLQ0?=
 =?us-ascii?Q?rrQkoRkOWCQCZHTMiRf+sq+gN1T7fuH5Qp2ozVXVCFwBc9YeICHhF4ya6vV4?=
 =?us-ascii?Q?8DN11RN86F+X0rfMxwu2OnsJE+nhy3ScGEWFtcek9uf+I6tD8qVLZQV/k5xo?=
 =?us-ascii?Q?uL647mplsS/On2r3Kw8lAeY/F7y8QOUccRfLeHeMxq0pFh7sqYGh1En2z5iB?=
 =?us-ascii?Q?Pyu7lv8K751yY5fDgvpzNzOGc9a+7t3PZnhYek5jPRgCH8aY9XxcfOl20d+v?=
 =?us-ascii?Q?TSXgYnKNKp54+Mrv+XcqPdNl55maTbrOGKKske0uCMyKSYfos8Rzr5gVQyDs?=
 =?us-ascii?Q?eASszC/6pLG+EdMa6RCfEhRkNkAoPfm+jhE1tnuz6z3fp4sd4hCWUfOi9Mny?=
 =?us-ascii?Q?dKWQUMGGRLwAdLhMDOuhOzJOcxwNlQoswQ+uDwXo39l4oeAHId9FoXHj82RP?=
 =?us-ascii?Q?9DIlu45zXnA/NC92SWPez0nwqiZgjhY/3RFnOEIjvHeCK+6HF4fmx3D+RXQv?=
 =?us-ascii?Q?r1Kk3adXF30tBdrjP6d7j3fDy5ccRWrE0Sfqanj0LcsU3K0G5i/+tuF+pd3m?=
 =?us-ascii?Q?qZXA9SgnHwcEV1OZDULEpiY4Qd87Y2WAaSniFYUPfQF9kFEa8XO66XzHxEM7?=
 =?us-ascii?Q?8ec/IVL4ykWpUaJ/jza89UUinleXvfn0UA9Th1gNtSmLSXPZwf1EvAF3a1aL?=
 =?us-ascii?Q?UAp7+wTv3P0vRalF05I9dLr/bifesHELfzi0jTfR22GoD1ndwUQvsUn9vQ7U?=
 =?us-ascii?Q?bbW1lp72eniSgdrggPZ6a75gJp6G+rgyQ0d/XuuAWAMPR/bVb0+Z7DFMnQnQ?=
 =?us-ascii?Q?HLDwBTxS63eWtpdPC0xU+Uhjuxvrjc3AHf3blvEUptwJPkoj4ntev0kX8NU2?=
 =?us-ascii?Q?7JWc/pdkxfnFM0ESMVFaTJzbXmXORDZqWwEL0haCCoDYN8b/UXkcxEOvoU48?=
 =?us-ascii?Q?v5bZ3naOWkEO88YYvANHLX9WiJOuG4VR7LTC+7gPDB5jENNWPa5kSamBtrGN?=
 =?us-ascii?Q?NPE70RgoUNp4CY3UxKJaERlIJs9lSgpVzg/64Zv2sZMt9o3goVNry003c09e?=
 =?us-ascii?Q?TJVpyba7bgCmYtcwjF1FKtkPP4TX56tdVduNUY7DnTd0LML+HtmrKdt3N3Ck?=
 =?us-ascii?Q?E2vKn3UJ6zWoUurXcMjrfrzBsFUX1Wvy7UfWTBfA2VKT59x+t4BgRPOCCXhC?=
 =?us-ascii?Q?VTLxNe3BPgq1jYjK//qygIliGoauDAz2Aj0HuNT3v1Zl6dpPCAaRmroqryca?=
 =?us-ascii?Q?A2OFo1r/zvaA72jDBQCRkkkUQ+h7JWaQLAdJP2xNIyYeLFc1q/3izUs1ARlT?=
 =?us-ascii?Q?YAZ5m0zmfgoYYF9paTO/BmwxwQE1N0P4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9176.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/z/8lqgrbIbdlXQvAOw0sM5B1Wc1T6M08AJnn4QvKZMDLmNgzgaoWTZMMGvM?=
 =?us-ascii?Q?oEZ5m4Ura6r6bFp1T8OnYf+3pEX+5yLYhncD1N4Ys4B+5imWIE43zNqheCd9?=
 =?us-ascii?Q?pfEmmf+rGOTx0GlY8NIXNDZr0f43yS875yXFmJehrHg9DZbW2QlPUuWSC+Hy?=
 =?us-ascii?Q?InFdTlcIJBtaE6eywPKSpGcL2HgSmfw0nZ4LPJutNWfMFapage8aSgxtU2uF?=
 =?us-ascii?Q?1DTKY6yaGRp/gNnw9+cTLmOXSUA8jKgJWg4rsQvcwUnX1dokXgYvKT+Qd89i?=
 =?us-ascii?Q?PQlZ7KJbhsWjwVRaxGoceCyNytYyPC1+pa9xoTfeFFyglnk4i898OlgsPGOe?=
 =?us-ascii?Q?BoN1zxCQuoS2PO1zGwOUu8eaIY21qfBIpJtPTuY7iwtyL2WJ0rwbSF+86CN+?=
 =?us-ascii?Q?PJsO3brEMdETrAVHhDeudbMBmrjMFxlnDFgVUd7mwDfTguiDO3hmRZLXUcLT?=
 =?us-ascii?Q?xh8J8SRjOP8pBJfgOqm94ZUgGq6AlO1AkE5rlMkPt3WQ1IBPGMiAoIsdsZJw?=
 =?us-ascii?Q?cW/Yie4wduzQlJFLNty1wpVik4HFcwCih2IFbhjmRX5UE7gNDeh9tZj26jM2?=
 =?us-ascii?Q?Xx4yuWnl9tjQwOtcCzMBz12jjQQuMfkbY+srZOS5lgeyBOebgivgm6+Nn34v?=
 =?us-ascii?Q?vyn/G17uISAiGyfXZlF5rWbsJhMbY3rMcAx7/V+qvTD3ifuboe+QUe78WlZD?=
 =?us-ascii?Q?e8U9zCumiXyKxzllYx4vIRuvnSq4bbuwrskLQM/45/s+Kt17A1fwoyspovmN?=
 =?us-ascii?Q?4hI0kH9W/0bCNXeo146SVDfXtKPdcq96vOgp+jCZh8LfaHYcNPwsyRon0AQ9?=
 =?us-ascii?Q?Xu4lnkncIG4/tDK4MNZlAdW7sefNG/CkfMXuLuW7yl0fLKaaDBXmLdcJ10dn?=
 =?us-ascii?Q?uTNp0DA0wQJDvhgd6fOM+npCTWAFCz/BVHFANCvZN2B/eMP9yQpN68A7zD0H?=
 =?us-ascii?Q?hmtsTqt9fgwG2BNVGzr91A2mhk2xTEaZjkAkRalFc7AurHLllc13K7dA+Z2a?=
 =?us-ascii?Q?MyAWUg6+fVvOk6hzMlZrmIysBF+xdqt/sPMDZRDk5w7EATbvQlQKhZuYwGN7?=
 =?us-ascii?Q?mzLZVsnMmzwFlNtSsDDpA5W+PNKRacYvqdacjAub0OYdvGikTmumBGp2Uq7t?=
 =?us-ascii?Q?5WXJaTDGHWlCSx02oephoj+No5PNlPg2VsZ0Twx7tL0K1bSFPbt3Qg4OU22W?=
 =?us-ascii?Q?arvQ4q01FXn12Lfvynvf9HaMqmWcZdPQ8KdWpCwQ/BT2pMhBn5N7bDOQtphw?=
 =?us-ascii?Q?kZWTYTbQCT+bDbEC7eC2yEf4R1Qf+l86m7N1fEDIxaIK1WGFJ8FhvoSMeN/f?=
 =?us-ascii?Q?uhKFHu+9GVih82VLJsSZ8GqYNIkhjqxEfdNB4zk6QkDogcglMDXMOrJMsIBH?=
 =?us-ascii?Q?AstNSTF0/bKpJrFBKkTNEMnZ8HEHYDD3IZRPN23oeIZSdmHVJReu7n8l4o29?=
 =?us-ascii?Q?k/SUOlaeWmvD9l1Of2ioUS/AXFDtbogobCb3JVnjiD5jwMQKE2fZ1hsHNKB+?=
 =?us-ascii?Q?O9shC86u5+QGHsKmsO+s0DwEClwkKejOCXPxITIpfTrpWZIWfJNE/chIP68t?=
 =?us-ascii?Q?OJyJnofad/spJA2pKHvfysHT3dfD46YNi11wEpFH?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9176.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b2744c-d02e-4feb-dd96-08dd568d17f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 17:43:34.8098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rs85vCUelIaYryU8y5TieM+9aeSsKjGE/SJUjNK0BRUAJg9DfwKxgUF717rklL5Uf5N328pNdzX7VGJt0IOTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9714



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Wednesday, February 26, 2025 11:11 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Claudiu Manoil <claudiu.manoil@nxp.com>; Wei Fang <wei.fang@nxp.com>;
> Clark Wang <xiaoning.wang@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; imx@lists.linux.dev; netdev@vger.kernel.org; d=
l-
> linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH net-next] net: enetc: Support ethernet aliases in dts=
.
>=20
> On Wed, Feb 26, 2025 at 06:46:54PM +0200, Shenwei Wang wrote:
> > > Shenwei, you don't want the kernel to attempt to be very smart about
> > > the initial netdev naming. You will inevitably run into the
> > > situation where "eth%d" is already the name chosen for the kernel
> > > for a different net_device without a predictable name (e.g. e1000e
> > > PCIe card) which has been allocated already. Then you'll want
> >
> > The driver just provides an option to configure predictable interface
> > naming. IMO, all those kind of naming conflicts should be managed by th=
e DTS
> itself.
>=20
> Good luck adding of_alias_get_id() patches to (and others) PCIe NIC drive=
rs (with
> a real PCIe link layer, not Enhanced Allocation).
>=20
> > > to fix that somehow, and the stream of patches will never stop,
> > > because the kernel will never be able to fulfill all requirements.
> > > Look at the udev naming rules for dpaa2 and enetc on Layerscape and
> > > build something like that. DSA switch
> >
> > Even with the udev/systemd solution, you may still need to resolve the
> > naming conflict sometimes among multiple cards.
>=20
> Yet, the rootfs seems to be the only place to keep net device names that =
is
> sufficiently flexible to cover the variability in use cases. Maybe you're=
 used to
> your developer position where you can immediately modify the device tree =
for a
> board, but one is supposed to be able to configure U-Boot to provide a fi=
xed
> device tree (its own) to Linux. This is for example used for Arm SystemRe=
ady IR
> compliance with distributions, to my knowledge.

So my understanding here is that the primary purpose of Ethernet aliases in=
 the=20
kernel DTS is simply to provide U-Boot with easier access to specific Ether=
net nodes?

Thanks,
Shenwei

