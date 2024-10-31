Return-Path: <netdev+bounces-140613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E29B7321
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 04:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB2B2855A0
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 03:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096112C473;
	Thu, 31 Oct 2024 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQtAJZyr"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503471BD9DC;
	Thu, 31 Oct 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346413; cv=fail; b=bi1cSY17QU88owBNqNJVmPkWrXHYVYJNjHZhAv6ClWc/4q20W0pnE/DxakR2ZVIbc0GCQMu/aT+S/ZnmsAJuHY7WPTPdc9wmQ6+BKdLU9Q/wNnpMoRgmJuurtin4waBl8P7VQorW4Ja7uSQC6RpRRaIelrxqrmvEafXAos51LM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346413; c=relaxed/simple;
	bh=DeJvsWUVH4KWi2gBAho4B61R9P7osvUmeS+AHSYH3DU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HgOI/uGZlz5XBKdy2EE0GO/FiKynMNghgNoWcXfPb4N8roygmNzR00JB1SKG+Mv4uXZqn1lANKSfmiC80hs7/KZgrr4WRIrI1LNAskQG465jXN0qsYqiqje4Fzcw8zRjz8MRwTFd/isg1eNQatCwg88j1bpb39MPSW3NNwenCMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NQtAJZyr; arc=fail smtp.client-ip=52.101.66.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlGyeUW/WTlerlXSekmVH9copdvnTDHF2/J8kalFDZX5gl3ODUWtZzlJfR2vPolJRuShwdA7XtC5VoUBhKoXXtrX3MBSdXg5u4HDjrDFYOTKFcIS5rs1V//E51tGZzojWTdC95YYyO0eUU0FNESFSFnXLIEZ5LvgazLccpERwKSAFbLfwwfN1nhGF1CVlNveFzzTAycjOdtAwYAeVD+ktZjoO6Gc9DqZnEHmNVbPBv/r4wNoib0K9gHFZ0aNmiJ2dT9ScEZlhvYmcPiVJ2kx/Uj1NyiV/LuaUmQaCjBCqO8kc7pp/SjQBdGzD9SNybMHPRmmfV/TDfPT773t+NtJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r21tg5zrAKd1f/lUNPou16KYwTnrdpMpqI0kzKbo0xI=;
 b=VNSueiCl3hX7csOuGyiDNwJV7Qor5XzspG/VIWeDVh2DMaxaJO35VfgixYE08+B6nkrFN0X2/Q6uJkzginmPnDC71i6n85f0/kb4KusfWh57mw5r2DU33q2gD88kD91g2EcenA/D0km/SV9MJx9vUVtEtKaSbRfcNfyWqWzQvOLJqlqI+WH3eH/VV/HCfxmkifw39TzcJYPTJZsWEOWuj/aLPnkwoPIoxfL0fOqFgNYl8X45eOMdw8U7oKQfXg7KKtlwqJEzU0bAGZqLq63YioDVd+PgxXB9KFeO/uoxXXV1vryCqLZ//kG24iv1C8j1s+iz5jWCMAtIjRNfDQ/fww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r21tg5zrAKd1f/lUNPou16KYwTnrdpMpqI0kzKbo0xI=;
 b=NQtAJZyrGL4T5UGJh9DCIK94hU07FL0y4c/8jHAAww9H6SGFgFi+NLDuJpcRo6NHQUwIjeLcuXa39Lzg6HydS3D7bhMrBnUiUrKMBTF6tAFGfj3MHP7746a21/OyQIdRTUbYWwfo5EGdlKW+yjs+X8gxt863v5O2+VlZ9bsXt2KiFVI8npUMciph2f9wwo+BRurbCQEi3KZBikktOR7815HjmBFliUKNhjnsmSP3y9Di+eTV/My0dvvzft3Iz8+kqBC51ONUXHHLJSlfLocPbEYVIISOhRBMVEalmohj76MBBmlsFUukEWsHromf4tgcD1gLQcize8R13Cuk4KRyCA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB10005.eurprd04.prod.outlook.com (2603:10a6:102:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Thu, 31 Oct
 2024 03:46:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 03:46:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Topic: [PATCH net] net: enetc: prevent VF from configuring preemptiable
 TCs
Thread-Index: AQHbKqbVP6taxDbDNEuEvy4Pi75TqLKfZ+OAgACrTbCAACUYsA==
Date: Thu, 31 Oct 2024 03:46:47 +0000
Message-ID:
 <PAXPR04MB85104B9FCD3D74743E9B261488552@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241030082117.1172634-1-wei.fang@nxp.com>
 <20241030151547.5t5f55hxwd33qysw@skbuf>
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510F0A3B49E05554D5BD71188552@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB10005:EE_
x-ms-office365-filtering-correlation-id: 66827cd4-feca-4e36-2a5e-08dcf95ea511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uNYR88dOgziBQEdMpf5tR0lX7cewHV1qPykdkq6mtGHls9J8ct4t2a2Gu9i8?=
 =?us-ascii?Q?g1MdNK3Z6YPXJjqNi5w/4PRwDKkhbHPW0tx9q+Bs4JwYm3q2WFdWgnDwCWaZ?=
 =?us-ascii?Q?p/dHROJba4kp5dQbTfFQfNXfgLlEV/HRj1HqW2r2bSrnbz5ikqH6j0+ARCLh?=
 =?us-ascii?Q?gdBIhxOX28wEMfSrrEC5nkQWxSrggh+tRpHzCQbYVQ6QkxH9fAHHlCT+kuQv?=
 =?us-ascii?Q?zrW2iAGRTQUPssZkrV7oXIRUirIr/IyVUs4bZbozwH/ruc8a0ahI2u7xQeeO?=
 =?us-ascii?Q?hY4wGHIcyvohAuow4qyuQZZcz7ymTDL8B50fzYb2D8ESTCqcQ53AY25G9Ztq?=
 =?us-ascii?Q?kInbggA+7aihY4BiuTBgunGEIGBF+sD9hxVv8rIZ09ncYiJQPiYnzEjfo3yI?=
 =?us-ascii?Q?ylbxOu2V7NPwa6yTmNcDVG2Sal83NkIOCzwrjjLPFEUclWEA4q6+jHj4TfU9?=
 =?us-ascii?Q?0jS6bbIP4SjET7VnAzph1JGINpTKLs/qrdUcXetUHL6SlR5VyT5/Xxi30zBh?=
 =?us-ascii?Q?ppOc/98nXEXjL2CQXnfnLL1HPRc9G6f/3yx6o+GN/4liSChTwiKl3d9ee2xg?=
 =?us-ascii?Q?g4q415CGbChsFZ+gxVHCoMLCRM4t1qcPa0DntTB5OV+5/N4kOIRpTs6V4MUj?=
 =?us-ascii?Q?z1sBH4+Gm6aQspNrpgfBMXRhQPqDyodWy5YX4CoW6MXe1TtSP3J3LcUGA/9q?=
 =?us-ascii?Q?OTmQL8RzzJG7vyAbHWcmotfPypO10m1+nMxRHqDgNUqbS1oxJd4FYVCOlCAW?=
 =?us-ascii?Q?aPLzN4iPngZcoFsRcngL2gBMBvE/qxIHKgy8X8Gi6ptfYlLS+BVSpwHklgL2?=
 =?us-ascii?Q?sflznUK1xgQrusreZk6qxt3kp5pLrjyRzRpMGUfiMImsN5bHsr9YeEl10p1j?=
 =?us-ascii?Q?1e+D3sj5oVTCiS6ourydfw156EdnHRktyg9gxFeDFQHTKRwaycAPPgm7rpFy?=
 =?us-ascii?Q?bHCU564cfmTj8L/DIq7XeZgdqN+HiJWmFEzGwVVMV3+DKXIB2mA6JGQK7+W4?=
 =?us-ascii?Q?7JH7bQDPWkF58pgx3S0eo4fTo4H8+h1uJsLgIHrw+iQG1Y/jckWgsTPtnzmH?=
 =?us-ascii?Q?JZg3YyOJJhkgI+JSzrLoGkfhy+km+LgAZCXWbPV7PootZXVYry8NaFnkBKX7?=
 =?us-ascii?Q?q2DQCFSwmax9PE0T/dAe8aa0cRs0/zLz4sVfqhNov2nhrroGIzuX/VtAn7iG?=
 =?us-ascii?Q?oHK0a5RZPA8S/CdhBiWionWeGwpWDibBTBz5jmkzKh8hK9zGafgkGvZT7c5B?=
 =?us-ascii?Q?5GOCmVU3ZN+GtyFyRZPQ3g8t5myK4s+kSIjClhIsGjl1yLurYn+bBM8D/tmq?=
 =?us-ascii?Q?v9E3YBagflikEEORhNT3CDT7MGUWQ2kTlD+TUh8PQX/ObXXXlTy7nsdxAZzS?=
 =?us-ascii?Q?LfYpdOA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cvs6dq7HXmkdD2RdrXBSITMxQX553Zr1IhCdk8NlKMqX9nwuSSuhFnLDBE0O?=
 =?us-ascii?Q?7zWqQ8//XH+FGOYBgSWJkqafZ84LoHG8cMEgx8zRC2zmmkkCnKqOvhRbZzRY?=
 =?us-ascii?Q?BVG4nbrgFpMT+s0f8wrXzxwTVV2tp4D/U+fC8o1gbwJeIVb58raSq4puKrK2?=
 =?us-ascii?Q?O31PoDC9hv441Xixb6b9Xdt+9Ob2TERWSvCms+2qk2IwT99V1ZEYLroZ4WEn?=
 =?us-ascii?Q?LI/cQ0jNrIRUr3Tp5atlZs09OSWZxRl3gGtp/rZgh6N350pMpQMuDE2LDc3l?=
 =?us-ascii?Q?FBoBaAEoG/rkEnhYw5GW3i0CVYwB915mTG2/wlhq3Fi8rTBsqKvzjav4e0S/?=
 =?us-ascii?Q?pWUWaREyeyy9/Qjg1SQbZYtXPw5yhvYYFH4y/k6V3I9dUEhrdUiYpRhcuRgB?=
 =?us-ascii?Q?iq1XEHAtSRDkvwMRpXbbnZ2QSZBoB8CM8CIHcE6gd6XuvRBPHNFXDHMXT6u2?=
 =?us-ascii?Q?V7K2czDCnkKe405oxTsdVrY/lHOVt2D0ZAe0LI68y5tVwQkcmXiRk3FOw/Td?=
 =?us-ascii?Q?YI1NwIq2ec/9IMr3aCYmV4QR/9pueUwlKc3BNBx7wWHj/yrfPTRxCOzp7b1K?=
 =?us-ascii?Q?5QKwddSrK4EdHw3Ws3r1yUYmsTy03PRUsC3TKyPrnQMClp6fhkZZAMlnahlb?=
 =?us-ascii?Q?ulq+ZfJ/lrfUyMDHC8bLbl02+/kYmva3He1kikGcdAYj6FCNMprnqxXaoYZB?=
 =?us-ascii?Q?qwvgUyIkaP1+Onzth73Yp++ECCqA5yLNjOpWcPXQQN1+IPvr/QnUBKkNRylT?=
 =?us-ascii?Q?QpA2UkFPraX9+RFCOJgnPXtEwGDQ9smsaVWSFfiOWeoZat1qkGlY5UwmUyxU?=
 =?us-ascii?Q?Fdu+I0hBtyXl8PVTwlcPM1U9vuZFnBd9jFmuUh4gCPe1YBj8L34UijFpA0hS?=
 =?us-ascii?Q?BwLK2/y/f3GVvS74GpaOFYunoYCXSa/hN/5FBJl5dR5NF0rFRmID5lMegJ18?=
 =?us-ascii?Q?rIN0WCIanx8kTXP+dciF41KSH5AIZFoU1nk50dO2hkIWKozzcAI+YmdHDerM?=
 =?us-ascii?Q?LPMfluPuzO786uDVS0Y1Zkvc+mn+aVCr+E53MblFCKkZygmjrgH48yTw2CmB?=
 =?us-ascii?Q?hispCAnEMGyK+HYyXRWBdTsCMvzAuHLjABbwpbVq9WJYI4/AHScLTNgnOZZI?=
 =?us-ascii?Q?f+Vvd4W39lihFoZIx+575z1KizJeAYrVIgxl5NVF3z8Z5xueLIIw/JTV+YgW?=
 =?us-ascii?Q?1NSNZwg4ngNl2YrqL9O7rzjxLCv/3MD8ZKheyMDOBvcNj6uenS0V1fO/E+/N?=
 =?us-ascii?Q?pL6+UJV2glkfur2mb4MzO0ygB3B0Dlk7iEiClYARBKLk05Ch6wgSzz7lUiUC?=
 =?us-ascii?Q?fXrxI9T7gvODP+V1Om8EJ+DjsuLfqkdXMh+rGjlat9AvczDsQ8y3jc368OSJ?=
 =?us-ascii?Q?kng9V6Afyx/QmUQRV3A01O4aUxwkEhv/GmaWbcP9whMn81cX+ylZAbm6de5G?=
 =?us-ascii?Q?UToxS2mi6ads5JG4G0vZ14q1+JYZYhoE/Rm4N4vxI6x2hTthjzLgS71etuuI?=
 =?us-ascii?Q?y8wzFFV4DCQNkw5tFoTVdnq7+3//wcvSnVj+ga/AVPBhyoNlyljGNsNPcDx4?=
 =?us-ascii?Q?Yrn7hxVZimrkCexJ6as=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66827cd4-feca-4e36-2a5e-08dcf95ea511
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 03:46:47.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SiyK6UB4AXGYtA60WhcI/qsYbbdiqRX9fllbkQyw0xq0bdsSXwKmfLjz1tlwiKrzX7VlYBNH47p39WHw6fo+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10005

> > 802.1Q spells 'preemptible' using 'i', 802.3 spells it using 'a', you
> > decided to spell it using both :)
> >
>=20
> My bad, I'll fix the typo
>=20
> > FWIW, the kernel uses 'preemptible' because 802.1Q is the
> > authoritative standard for this feature, 802.3 just references it.
> >
> > On Wed, Oct 30, 2024 at 04:21:17PM +0800, Wei Fang wrote:
> > > Both ENETC PF and VF drivers share enetc_setup_tc_mqprio() to
> > > configure MQPRIO. And enetc_setup_tc_mqprio() calls
> > enetc_change_preemptible_tcs()
> > > to configure preemptible TCs. However, only PF is able to configure
> > > preemptible TCs. Because only PF has related registers, while VF
> > > does not have these registers. So for VF, its hw->port pointer is
> > > NULL. Therefore, VF will access an invalid pointer when accessing a
> > > non-existent register, which will cause a call trace issue. The call =
trace log is
> shown below.
> > >
> > > root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100:
> > > \ mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1 [
> > > 187.290775] Unable to handle kernel paging request at virtual
> > > address
> > 0000000000001f00
> > > [  187.298760] Mem abort info:
> > > [  187.301607]   ESR =3D 0x0000000096000004
> > > [  187.305373]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [  187.310714]   SET =3D 0, FnV =3D 0
> > > [  187.313778]   EA =3D 0, S1PTW =3D 0
> > > [  187.316923]   FSC =3D 0x04: level 0 translation fault
> > > [  187.321818] Data abort info:
> > > [  187.324701]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > > [  187.330207]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > > [  187.335278]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > [  187.340610] user pgtable: 4k pages, 48-bit VAs,
> > pgdp=3D0000002084b71000
> > > [  187.347076] [0000000000001f00] pgd=3D0000000000000000,
> > p4d=3D0000000000000000
> > > [  187.353900] Internal error: Oops: 0000000096000004 [#1] PREEMPT
> > SMP
> > > [  187.360188] Modules linked in: xt_conntrack xt_addrtype cfg80211
> > > rfkill
> > snd_soc_hdmi_codec fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc
> > caamalg_descp
> > > [  187.406320] CPU: 0 PID: 1117 Comm: tc Not tainted
> > 6.6.52-gfbb48d8e2ddb #1
> > > [  187.413131] Hardware name: LS1028A RDB Board (DT) [  187.417846]
> > > pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--)
> > > [  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> > > [  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> > > [  187.436195] sp : ffff800084a4b400 [  187.439515] x29:
> > > ffff800084a4b400 x28: 0000000000000004 x27:
> > ffff6a58c5229808
> > > [  187.446679] x26: 0000000080000203 x25: ffff800085218600 x24:
> > 0000000000000004
> > > [  187.453842] x23: ffff6a58c42e4a00 x22: ffff6a58c5229808 x21:
> > ffff6a58c42e4980
> > > [  187.461004] x20: ffff6a58c5229800 x19: 0000000000001f00 x18:
> > 0000000000000001
> > > [  187.468167] x17: 0000000000000000 x16: 0000000000000000 x15:
> > 0000000000000000
> > > [  187.475328] x14: 00000000000003f8 x13: 0000000000000400 x12:
> > 0000000000065feb
> > > [  187.482491] x11: 0000000000000000 x10: ffff6a593f6f9918 x9 :
> > 0000000000000000
> > > [  187.489653] x8 : ffff800084a4b668 x7 : 0000000000000003 x6 :
> > 0000000000000001
> > > [  187.496815] x5 : 0000000000001f00 x4 : 0000000000000000 x3 :
> > 0000000000000000
> > > [  187.503977] x2 : 0000000000000000 x1 : 0000000000000200 x0 :
> > ffffd2fbd8497460
> > > [  187.511140] Call trace:
> > > [  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> > > [  187.518918]  enetc_setup_tc_mqprio+0x180/0x214 [  187.523374]
> > > enetc_vf_setup_tc+0x1c/0x30 [  187.527306]
> > > mqprio_enable_offload+0x144/0x178 [  187.531766]
> > > mqprio_init+0x3ec/0x668 [  187.535351]  qdisc_create+0x15c/0x488 [
> > > 187.539023]  tc_modify_qdisc+0x398/0x73c [  187.542958]
> > > rtnetlink_rcv_msg+0x128/0x378 [  187.547064]
> > > netlink_rcv_skb+0x60/0x130 [  187.550910]  rtnetlink_rcv+0x18/0x24 [
> > > 187.554492]  netlink_unicast+0x300/0x36c [  187.558425]
> > > netlink_sendmsg+0x1a8/0x420 [  187.562358]
> > > ____sys_sendmsg+0x214/0x26c [  187.566292]
> > > ___sys_sendmsg+0xb0/0x108 [  187.570050]  __sys_sendmsg+0x88/0xe8
> [
> > > 187.573634]  __arm64_sys_sendmsg+0x24/0x30 [  187.577742]
> > > invoke_syscall+0x48/0x114 [  187.581503]
> > > el0_svc_common.constprop.0+0x40/0xe0
> > > [  187.586222]  do_el0_svc+0x1c/0x28 [  187.589544]
> > > el0_svc+0x40/0xe4 [  187.592607]  el0t_64_sync_handler+0x120/0x12c [
> > > 187.596976]  el0t_64_sync+0x190/0x194 [  187.600648] Code: d65f03c0
> > > d283e005 8b050273 14000050
> > (b9400273)
> > > [  187.606759] ---[ end trace 0000000000000000 ]---
> >
> > Please be more succint with the stack trace. Nobody cares about more
> > than this:
>=20
> Okay, thanks
>=20
> >
> > Unable to handle kernel paging request at virtual address
> > 0000000000001f00 Internal error: Oops: 0000000096000004 [#1] PREEMPT
> > SMP Hardware name: LS1028A RDB Board (DT) pc :
> > enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> > lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
> > Call trace:
> >  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
> >  enetc_setup_tc_mqprio+0x180/0x214
> >  enetc_vf_setup_tc+0x1c/0x30
> >  mqprio_enable_offload+0x144/0x178
> >  mqprio_init+0x3ec/0x668
> >  qdisc_create+0x15c/0x488
> >  tc_modify_qdisc+0x398/0x73c
> >  rtnetlink_rcv_msg+0x128/0x378
> >  netlink_rcv_skb+0x60/0x130
> >
> > >
> > > Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to
> > hardware when MM TX is active")
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > > ---
> > >  drivers/net/ethernet/freescale/enetc/enetc.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > index c09370eab319..c9f7b7b4445f 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > > @@ -28,6 +28,9 @@ EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
> > >  static void enetc_change_preemptible_tcs(struct enetc_ndev_priv *pri=
v,
> > >  					 u8 preemptible_tcs)
> > >  {
> > > +	if (!enetc_si_is_pf(priv->si))
> > > +		return;
> > > +
> >
> > Actually please do this instead:
> >
> > 	if (!(si->hw_features & ENETC_SI_F_QBU))
> >

Actually, VFs of eno0 have ENETC_SI_F_QBU bit set. So we should use the
following check instead.

if (!enetc_si_is_pf(si) || !(si->hw_features & ENETC_SI_F_QBU))

Or we only set ENETC_SI_F_QBU bit for PF in enetc_get_si_caps() if the PF
supports 802.1 Qbu.

> > We also shouldn't do anything here for those PFs which do not support
> > frame preemption (eno1, eno3 on LS1028A). It won't crash like it does
> > for VFs, but we should still avoid accessing registers which aren't imp=
lemented.
> > The ethtool mm ops are protected using this test, but I didn't realize
> > that tc has its own separate entry point which needs it too.
> >
>=20
> Yeah, I agree with you, I will use your solution, thanks.
>=20
> > >  	priv->preemptible_tcs =3D preemptible_tcs;
> > >  	enetc_mm_commit_preemptible_tcs(priv);
> > >  }
> > > --
> > > 2.34.1
> > >

