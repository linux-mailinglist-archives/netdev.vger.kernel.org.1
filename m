Return-Path: <netdev+bounces-238562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB6EC5AFEF
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDD4434C033
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFB219301;
	Fri, 14 Nov 2025 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/mEsRnY"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9C2153D3;
	Fri, 14 Nov 2025 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763086826; cv=fail; b=Zxy59aJPBBjxmJbDgBnk95cXJTvy3lE7a5zyzECnGWo199N63UyOXhUHObhPhAvGuo5RT2g88IkR7q8cK1m5n3iFWldaaMgGvzU9mE9oeJyd3WZPlqqFjUQxBkBOr6QIDfkvbVM9ngGVvZkib7npjelbh+eIzRk/Fy4tkWfwqVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763086826; c=relaxed/simple;
	bh=wT8Kkg104jEwMa9RSAJ+J0jQHMzKDHJr5tRT5x/Ynj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1rdqs09l3EToWRDqFBnoeV7BSifQHIEOfnBrkihrGEAMzDDZmzswJukxYkp5bq6PFKAlyW8Es5hsMJ5/7VOG5ANk9R60DP5zTPYCNk8Lntxz8wYUcBppn0QVcYDceAIK51U2EVSYXpuGf3Q4FwAVe9GVmNoSGfAoNjlR6vbwK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a/mEsRnY; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX8jsxKUcGFi7U2TtWB9ChIACBHzV9UXbdIkyeZO54cICQEKH8AHZtp32vTUmU+OxdwXofzBCD80heNPs8XJw7Cb/+BWYedIFjxVRvTF6fiY8DgMtdP8awHDWFWjIEUErzMvc790bP9S3+7+zD/apNvZKav1cYVNoC/mvCsaUHN5kXWnwAH3ezjsz38vuSEBOm234Ghrq4As5UxAiSUcLlsnUrbYqUkJemCOCBUJzDid6NQNnY21VTLJG1vLoCoIL9ObPpJdMBm6wrvCQjLTbq82VygJYUWsczHGy48NBovZv7yG53HZ23owAVhpVk0HkmGB1z3ZQwSniVhHGOdsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q36bI7iVaMEOMKQmyZWk8hiAUtCqCAYIo0gbaokqORc=;
 b=Qxo8Hq+1QcE6aISuIxOwx8kLfthmckGP6jVcVHMJtRLzm8Bk3k5lV5/pQkRB05YanUPXDVU7mAlvLGrY/SCkluuR2AjghZOKrmbUy+XrgAWDpCehYssB3SHLx7y4jm76eVirg5lI7QyDzUBcCw2gf9Xd6B+hfcxIpTew6PXAbRwuxzoGxrRghihIeRH+Xll/cEx7X1u3/Sug4j9Urb9h6v649SWMuwFvi+wgWISc/V32BkwqiohbbhZP0DGhz5mRnB0+e+K/qqFNyldLM3mS7IEEkoGfDdyQMEgZgT7dfjPTcRtnoQ4Sv9S+rTH7Cfm2EOUCPkUmDlUt4Szprk+GMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q36bI7iVaMEOMKQmyZWk8hiAUtCqCAYIo0gbaokqORc=;
 b=a/mEsRnYMNapZ6jt/G3SPif0O/5oJN3A/78qQ+oUt1pT2MY3f6MnHUuzLBAyFrlL+vG6m+Ejb1gQZ+QG4N66ijNGMMkkUvW3vmQ2JbC5pb/KE2hgKGvVbTszG8jUsdc5BrDEBCvOlDMCh7U9kQ2caUKlnYGTWrfAvHQdhb7wusLXK9x/I/33yvTID5HQZYPRd9I+8t4ScSv/7X3seqws5MzzoaqYzh5Uo4ofeJkuoeTusbuLgTYmtzNrIHVn7vzQWYYVXGRHhmzWS8c7BZ8VBu0e2PemziZH4/8bYrNc6J1ZkuNy/ljJpPbyHsRR1XeUMDFyfIc+ekQOn+Ri6qpY7Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB10573.eurprd04.prod.outlook.com (2603:10a6:10:587::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:20:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 02:20:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Topic: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Index: AQHcUvIHSjOTg72StEO1LGc2qBglv7TuDf4AgAA5wiCAAocOgIAApQhA
Date: Fri, 14 Nov 2025 02:20:21 +0000
Message-ID:
 <PAXPR04MB8510C99BE9177113B0ECF3B588CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-3-wei.fang@nxp.com>
 <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
 <AS8PR04MB8497494755B820A2D33ED39488CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
 <aRYG2YqpeOr3U3XS@lizhi-Precision-Tower-5810>
In-Reply-To: <aRYG2YqpeOr3U3XS@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU4PR04MB10573:EE_
x-ms-office365-filtering-correlation-id: b03e2eb5-4462-4af2-cf71-08de23245cc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?M4D2BhR25OIwoEnrIAIvtDpcEluLRixmQebE5WbCAg10qTr6pFwm/ah7Aec+?=
 =?us-ascii?Q?Z6GE6ceOskBbDItN8KlpH+wiB8i/ihGiPRVix8NIe4ixVra7K3Ca64xn5iUv?=
 =?us-ascii?Q?4JJrAImCU1dALXM8r62PjedDC5+3PpIeMcZOKBFxTASvwCqUmk85mvkYryzA?=
 =?us-ascii?Q?YE2If8gmcH7VvxevknKoBYCAHZA70yd0JfAlmYqMWicBnvvcguF3HFPsUWe5?=
 =?us-ascii?Q?VoFLaQbh/LJ0PnVZpVbyDp97l1CBex0at7G3UOAATegwG0BVNTCjqpUhYCRP?=
 =?us-ascii?Q?EQMk9Q+WR5e1aiI5CxRtkug3bxXGXdvdtdT4NQvPwlFH8YjqVwvb66gopOVu?=
 =?us-ascii?Q?J0puw66ID2AOoew4LjdFVMMv14kgzW2ILt/dDFqqyQ7LO2WdkLCGPsi3tXWc?=
 =?us-ascii?Q?hCsNTqbSIPPN9E/C0C4vLLNrmOAzyVAkAi8ATQWMvFeXY4bkcI4m5RRPtlKl?=
 =?us-ascii?Q?gRKM6j6bSXPDQBmq9UGC7wItDrPIUeVvrAZgxOpueM4fZhDWYTwEfZJFRsLO?=
 =?us-ascii?Q?rNL907N478jA1PXgYDvLSfmHIlYiE6XC8vpqfLjurcGry9ynJWsmkpxytCZZ?=
 =?us-ascii?Q?x7ENkhjIaV01cP7nlLlB0Ah4MLIhStE9WcPgUuK19NmBmq6Ueo4lmtITdqJI?=
 =?us-ascii?Q?ag8UbzdoqYNauqRcpeaS/yZM5Po8qGTW0ernRhQUiaeicdumrPRzMaKusBXi?=
 =?us-ascii?Q?Si1B1CMrdyZ0yoW6ky6Zcj2w709fboH+peORtBANgVN+IzdXBs5jC9HWSgdM?=
 =?us-ascii?Q?EQXDAVP8wCvMTJCAQZ8yL4irIhfO6fATbPJfyQ0cuYRimVDgfSEsISFrfV0W?=
 =?us-ascii?Q?o4EI122HXc1loQXOjC7sk760exbhIGF/2Lee1rGPI5HFgfdRK2XkKGlrSkqP?=
 =?us-ascii?Q?DCuewKtgvpyt/Iw4mDgibCfLZ8Wh18nfc7D6ZVbsbdl5jazsPQ6ni+b5BmWP?=
 =?us-ascii?Q?k+dkAlYBu3pfITdmU8NHqVMS+Kz3xb6/IiDIEHFCXRpJ6voTH1MdzJfFutJi?=
 =?us-ascii?Q?+UTJC/tY8lg8Lomz3ExqBItTDbGSsVNPimNznx3C/8U5U9pKUMacJelDI51D?=
 =?us-ascii?Q?sPfl74icmFd1pqTHX25Fkmmo1TZWPo5Pba7mP/8XAhgJVP1OyvCBBA3Yjn+y?=
 =?us-ascii?Q?k854wT3CcyB0mRveremSujg2JlcX1cZ++NhT4oFt+t/2SK4wgSsSdCugMOHl?=
 =?us-ascii?Q?804mGKtpKIG2dgQYWORlW8AfVyuk4NxkOSHtiqHQLZIEb0TUhEnDvCYx7TsL?=
 =?us-ascii?Q?b2n5ceF3v2dhdYhf9nZH8AFAI/NXv55rxV5WKp0Z5dvfp3CR2M0pU624O3dI?=
 =?us-ascii?Q?ev/IFACXdMf2cdqPXwRQ+qxJXk7J0hd4ATvRk429Z+ukIp6VgcEz4mYO5c1O?=
 =?us-ascii?Q?BMkOclH3Rql/czX5gfa8UCTLQaBeSvcKdWzpuAx/DEDGvID17kWwGVcfqMff?=
 =?us-ascii?Q?W+AIfKxmQGkBlVuniAjV6cTfUN+dsp6frMOIAoc8Xcz7QTJLocMe9x1qr32u?=
 =?us-ascii?Q?Sfzf6KNnmr5z12YVsNdehhwIj7tFkTWcZiEO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mJtw5RetELmy+p6oxDg58hOc31uArS/kO9vcXr2FuHS8PQuNDOt4JpGZ8hwY?=
 =?us-ascii?Q?+ALltFEccJFUHeoF7Q/Jg+b+SxYNw+a2j+BJBB09CtEp743iOX5aSGWAZO/R?=
 =?us-ascii?Q?mvLU2GppqgDThQ0zMM+MqwIGtkEaagGi1McfI6aW5LuLxrcE3grPtIrida6X?=
 =?us-ascii?Q?cjhmIc4X3yBiGXQQ4J/aAKUqg8VnJTVnaUN+uQbUTEskRzi3zxXmrC4U4Zx+?=
 =?us-ascii?Q?AOiIfK4xS2GovfEIkjAOEdnUr7cFhYeh3u8A5oS1DlsS967vhDij5Z1uSjOk?=
 =?us-ascii?Q?gblbY90OJr/EyJvrt9XVoLQsSNMdeJ9y4peSAAdOHiq+OSqOg+DHPGec9EBb?=
 =?us-ascii?Q?VSJyR1o+qOER0iEMR09Zn2bUjPT4NIRCuCG9f6mqpQtyMEYu/2iJ5zAnxjei?=
 =?us-ascii?Q?21MKnfZ9EZKJyMZSoMINPXHSwuBvv8fiD3aBEEwIZ/zWRerQ8c4f15LMtWBX?=
 =?us-ascii?Q?dNhsoYBvqVmxMsj0s0ru+tjAO0oKhR2aWZYZm2Yqw2NpAacP7AlYaUE3o/OR?=
 =?us-ascii?Q?uMJUATXcyXxFcXM3T4lcKp0pTJHDpsYKcjgbLLKNV4EeSuoPRNA2WIyNTOOj?=
 =?us-ascii?Q?N8GeK3KQXg4eo78hqtG8+ypAVvZAfqBjilJoj1PxaL5EsJ1Jpwufwg2ew9mZ?=
 =?us-ascii?Q?Qb1RsoGYCs4YrfVTxdfHgEiJdaibJ5n1O7WPHz9Xv1IcbYN31dhRs9bN/21j?=
 =?us-ascii?Q?FEI2nRXELK9jNYRRbJMEMQXPTcz7VyuR17b+JRLZJ7Cj0uuyx9dw8CSgX/JJ?=
 =?us-ascii?Q?tVdzD0UxvMoUjWk9DrxtVXRkyGDziIhg3RHUB/nRUVXSSt82CMmV3GkadAXa?=
 =?us-ascii?Q?K2o4+Dx4m1sNG7ZEze0UqtxYEKmFDWbz7BzXhMpQtcmY9pmkr94By64s48vR?=
 =?us-ascii?Q?/0zCOEnsYQaRN78VxMyTBdPuIK/uhxccIOZC3M1p+Rps/j5UmlvhPGmxmMmR?=
 =?us-ascii?Q?6T2DNjsBOrlwWzXzKETTywTYnZIKL5rGVWHcL/gReI3rc54nD4NEMXouhGcb?=
 =?us-ascii?Q?tKhmE2gYR11617rni+IvrRtsXWNelfVOLTSpeby/2nascIIsfYiSQRU5/SIX?=
 =?us-ascii?Q?ViicrU2szf8o6WvOr6IVEB+Q/QwdMCBHEFirzeW4BlO3/J11nqYCL42oiDwG?=
 =?us-ascii?Q?O6617KLWFn5Wcg7MhKuulbprk4WFnY52vQn5XmDqKZuRPJ6TvCPlfFGSAwLP?=
 =?us-ascii?Q?JWPx/buMNMXZ+x7G+QM/o39tP8EaFUUGGafLx3BHoNC8V9LUTqDo7bZCiuMt?=
 =?us-ascii?Q?JssHJzVUglwR4QzDB4OlqlJZx5QMvfK4fozN9KT51znjwVJL1a7zk8J2xGK5?=
 =?us-ascii?Q?l+qPbPanIiu5/aaiTFuOkRCKzu22WsnYN6H8NA5ipdE65I7IKciKEVnvmpOx?=
 =?us-ascii?Q?FX/YxIVOfPi+8zCUq1FCipPuQdXqICZEOX6t65092XaAznz19LtaCNhAW0cG?=
 =?us-ascii?Q?nICOPo9DArH6HtKVvdy2tm6DicKOxrdwBlvTPW3Ba8adO1xGinH8+CHUHRWx?=
 =?us-ascii?Q?knJPhpE0T0DXDC3lesPZt/tdRjNi5JRPg5lsfA/X/inEq2gpJvF6GaOHVxQB?=
 =?us-ascii?Q?l+cp69fDrdBm3tltACM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b03e2eb5-4462-4af2-cf71-08de23245cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 02:20:21.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lB/EcNGJEcqyV+oN6p59oPET4W1SDOB+88hPcyeb5Xvv4cUmvSYigli3yvZsG0HY2txhvNP8Lifu3FMEwYwGLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10573

> On Wed, Nov 12, 2025 at 01:53:15AM +0000, Wei Fang wrote:
> > > > -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> > > > -		reg_list =3D fec_enet_register_offset;
> > > > -		reg_cnt =3D ARRAY_SIZE(fec_enet_register_offset);
> > > > -	} else {
> > > > +
> > > > +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
> > > > +	if (of_machine_is_compatible("fsl,imx6ul")) {
> > >
> > > There are stub of_machine_is_compatible(), so needn't #ifdef here.
> > >
> >
> > fec_enet_register_offset_6ul is not defined when CONFIG_M5272 is
> > enabled, so we still need it here.
>=20
> Is it possible to remove ifdef for fec_enet_register_offset_6ul?
>=20

Yes, I will move fec_enet_register_offset_6ul out of the "#ifdef " guard.


