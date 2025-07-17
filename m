Return-Path: <netdev+bounces-207852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B57B08CB8
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4635B1685A9
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 12:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0CF2BD00C;
	Thu, 17 Jul 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fp7NMoxo"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D01A288;
	Thu, 17 Jul 2025 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754823; cv=fail; b=kZzrC/cfNyn6TTxqxH0lM/MZMTKM2U95ZyuTF7zVY9e/QcKcPYclRMZ5L3nNzgkrefton8RRaObWbaGZHbphDNX1lKcfoxNMMcVm0GMyw93+QrZomJA7DGIsa2ZjWD4FqM23T/o/wp/FdfEyWiFuvOguTkvAbvdKVBn0sfWzObs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754823; c=relaxed/simple;
	bh=nzII6kfPIdvWP1+36KneMXBQLce1cfwEnPDFZRwyZWU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dm2fwvPYpJRP44lkHy7bJ80J3qC/xsAhwHvjrnIwuPJuLEId3X/CZh5/FADoFEidYnUvx0IRqVF0ZYHZXy017/4xpse8/KBlu+fmP8yBiiQoABQvxqH1MJIrtzzJzF6GoFp7ZQyUqVZmu66Rz6dIH+PG5O6IKX2QKzCSutnC7V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fp7NMoxo; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JD2+a6Az/Zn8X30jshmLnGW/KneeQUIkHxhR+DcD+KCwWixyfRhJhFICBoW8T8xFLQJWr30Nr1VxMex4CBDg3JQDSuH384XlwrOwStkgtUIpmY9HlGRlcDpnBNzoajkhCIPairN8CiZVqbpe5aM9mOd34Qp0fZrC+4GffUdtbT4tnuFgP62g1M5s3bLTeD2YiV+ZsZfx4vQHIaBL88dFCyAtesnlv24tURJxzT3yIMIVSoPJM4uwpgT2FgfMyfQGG7jxiTCGPB/sCl3/9zC5oFKieTxYWAT9UfBaN5sSJiCT5LPGSSclaixIMZijSwOUovh88HkaXRRt/4vYNP7vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IowhF6B3SuV/JtB7K5aGOlepR7mjqlFrY3a5e+hrbeA=;
 b=J/2aNTMQKOzNRVd01Px1L3ahH4bdnRITOw9Z0J9XNRibW4C3u7jRNcHRMNRAh33JAAbo2gnzG1Mgdlzbl5bHqpSakGxOTWumbjsV1d4WyGfOnsTc8auX/4A0yDh5+mT672y/dsWNyYV+K+wGdzDpjwObKb3NBpxH8MJFlyOE12QZ/dY9RvfdTmzUq/nC3sQu48Au0H6u2gQ/4VzLRLA1Ggi1PyABQ4Fdc7Tjqkm2rUqb8xzKdndfE+BDFnyic+F9SWNEEY0etD3gFeM6BxP+swxV3fTXho8C+VwA1OJwNVcdG3iutGDNtn9iS+RLR98CcJgqA4oNa7IqfpNHRFWhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IowhF6B3SuV/JtB7K5aGOlepR7mjqlFrY3a5e+hrbeA=;
 b=fp7NMoxo9YbUons33QhbiIuRVex0ckFpWGn0u4MOVxbAnSBzV4SU/JsmfZp7rJAICD2ZjGl7whOmJrL3KPycL70V5nWWSuQsPtwiQeTDu3oebe5VmEEfzNbt5CPGtVDgmuKyaPafVJJzNjEiofQqZ84uY10TMirK6WE1TYnDuUUyOHajlze+AgjOPc55HkQoekPGYxQb9FYpMwyiH6STC+5f/WrwNh0j5RKOUp/ZjR17nymcXa3/RfsK8wDyDq7goFy/to8r3/EKBTuRzcICblHmMGlpfuIhl0Ms4ZTdRgWQB4F72A0+K98wTmckAV2Mb2wXVByu/hcpaZJdcytPog==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:20:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 12:20:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 09/14] net: enetc: save the parsed information
 of PTP packet to skb->cb
Thread-Topic: [PATCH v2 net-next 09/14] net: enetc: save the parsed
 information of PTP packet to skb->cb
Thread-Index: AQHb9iaFET7Qgju8UEqMGYTREvwIe7Q1OQGAgAECrZA=
Date: Thu, 17 Jul 2025 12:20:19 +0000
Message-ID:
 <PAXPR04MB851096B85B36D611CC12C2CE8851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-10-wei.fang@nxp.com>
 <aHgPjwiIWfhYnPyC@lizhi-Precision-Tower-5810>
In-Reply-To: <aHgPjwiIWfhYnPyC@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7602:EE_
x-ms-office365-filtering-correlation-id: e08271a4-dafc-4f32-faf3-08ddc52c4b69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xg44I7Uqp0FZ2PsZfAq1vVdl0PJqeccWQnWdU2cunNF/yoKrhxZFhpqgk+K4?=
 =?us-ascii?Q?p3c/BLfctvY8QhpzTeRp0Ca6Ug78FxCQnSRnbkCsqspGtlFSlbTgKnmLo5rT?=
 =?us-ascii?Q?KQAymwYngQiGb5nB0DLnqGyIHp4jmu/MrF3BeS6dg45XBnsXEcq41MdRo8o5?=
 =?us-ascii?Q?GeH5AKZGRTR+eyF7k7hejp4+0GS3WqIWaJ7iS48ymXxDGXqITCfzdrnoIrcS?=
 =?us-ascii?Q?jFf3d8ZPSki6odWjbnmcxwJrXPVzeiYjz3lqwOonHfbi1JJr65dhjC7/2XSF?=
 =?us-ascii?Q?pxvkHtJdF38XjSighRbubGH8DwPjK5f4b0KiEBIR3EEHw3X8/mXIcip9L56m?=
 =?us-ascii?Q?UevJI/vIQnlGpV1puK04MQF574rkYpAvC/PVNTIn6Ome3cNM7AO5bfnu6l7k?=
 =?us-ascii?Q?ezQ0UxVpRagRjnk6/v0483uvvG+i1/9u8ybBcK2mc5tZKUm2NjOt/kcRPcII?=
 =?us-ascii?Q?Zx8/E7Cq5y95PEC60Xjt9cYMbR2GKgkHd5NV6rKg4xdqVlebQG3XVIbjcUt4?=
 =?us-ascii?Q?2hf1qg553PEcvljrwrmNReWP5hfkWe69kn2X7+PELjlb21lowIPEPVniOksw?=
 =?us-ascii?Q?B759BhWv42xvvOUB7Mi7IUjBq/QARh3UtTSQO33WgxhzvNQFRTu4jqZKK4zN?=
 =?us-ascii?Q?J1Md2/mN5fSf3GEDhKvbcnV/mHXbc1oA507b+zm+Vu1/6ma+8POeQqi4Heoe?=
 =?us-ascii?Q?s/U42MYa1cvKNzAf9UnDmXVrQ/y7ie0s4yoYuG90Y4wgsXXGPba5vqgIEEDQ?=
 =?us-ascii?Q?uDdriBB2OZ1pWYU6du1ftt1i0aIpsexC9UR5dO+02hFbtfyWLsbMQsn+sl9W?=
 =?us-ascii?Q?P2iqFLJmJ3WAUjGQaVFb9p6BvNauEZw9ZwJcB/zUeXHGFZqpVPbRHGBukhsf?=
 =?us-ascii?Q?zH6pnrYxKr2e5pl7RqR3dv/40qFvjuFtVGLdsON74ieincMWlsLQEMPaBVan?=
 =?us-ascii?Q?tweMlDGJbyhU1ls70jHGt5AsANEUHNzxINeKTj26qeyo/uMndtjXD8sbmpsI?=
 =?us-ascii?Q?tATt/hDDx9Ayhog/vCjFHIl9KG/jNzF1G9aaWDzOxNfsIe+wT0LiL+LgOIyn?=
 =?us-ascii?Q?V7tTjVsZksMlQlWFqKQykqqy7eEESMLg5MITEUtwoLzBHE4xK2vMp4EzngpZ?=
 =?us-ascii?Q?VytyRAsK8TwLuua412tho++gxPaiRMbJHovM3maGtP6aNQw2oCqZyAlDikyT?=
 =?us-ascii?Q?mC9ksF7CM2aDarS/V2Hj095ghDVgUe2LW8NS8/RCurHAxHA99ldQGRqhA1VU?=
 =?us-ascii?Q?8HPrTo9Y0JEsW+pRvXP/fpzJzA9a6gC7YA3FduizgbVOoyb+H0fC3dPixm93?=
 =?us-ascii?Q?9+uyGMMC76ZOxFo6T8nNbK/2rCq3ojlfHtg6YGQtG59BKhIIWXHlxIL52NDc?=
 =?us-ascii?Q?XgGa99yy3oaAKlOeupOg0kKnHrUm2x9+vJsO7+mjd5wtCcEwIkG5e6JWzhNF?=
 =?us-ascii?Q?sOiCtnb8FBQ68T8+UpmZYO8fLshISA8WDVsRlfnXkhefCnFm55awmg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cvpyZvA9KmBj+if3rNsBhGEb4rzqyAhMQiuxI3+RM3Dkdmi7SfiMTImYehj/?=
 =?us-ascii?Q?ciSHX4naF722hGCqDwPvfpK0z77GVJO4noaupmOkUB+4xG6fvQ9DAlQTUogb?=
 =?us-ascii?Q?N8l99W7J4AfIOEWNKnc59znU5r7K34LnUgH75/qHUfVsuzESWNMmZd9+vj/C?=
 =?us-ascii?Q?RTIu8Auu4AbA2yyORiScji50aVp7hWdY8vz3k8A5Y/4iZ23tpQhRwV3oanwf?=
 =?us-ascii?Q?kFYn984YSv83keGU1LaGOFSO4hTjJn7D1XDXjvAGEG2UqPVfBYkvekTJPt5J?=
 =?us-ascii?Q?jx4rmdF5WFkiY4PzdppWuvGSNlThpNRBWbgoi8XgJ6ftITIsigEcPax34ji+?=
 =?us-ascii?Q?Y8Ckmw8yENN0LfYeJl/0Gwi62FtlSF7KKuxbfMIm/NXmAYJHZGpN2+Jx8eH2?=
 =?us-ascii?Q?wfLNMYbF6vuPHpqUpE9ATMLCXJSpYLz2Ekyp8yHyCIEbrSINsnZlClnYYdgs?=
 =?us-ascii?Q?iArIot1bowDk15FlzesYHzKvIhXu4yAHZeh3fXxqym2ZLIG2M1NIjm/E1nGN?=
 =?us-ascii?Q?J2MtLAgNk+D/M01lEEXJ3MK5PYiGIXxnZ4L2u8EnayOoabvOD1rhskkeON8d?=
 =?us-ascii?Q?UBaRjE9TxpQ1EnsBmPoVy/fVufLsvwWKC9PvydjiE4BSjWe0S14eh+REcHHE?=
 =?us-ascii?Q?Eg2E4QxRq/VaiGU8NK5TvfsNmhGZ9y77ZHQ5N4oORIzfyulYCSnyLLcknpcK?=
 =?us-ascii?Q?LWxXe4YzECtNESPSw1HjP4mOY4xbHw9/yJlJhnvR5ViC/t/MhzdhXWeU8FH4?=
 =?us-ascii?Q?yDixNp5jOpJ+FM1qog9vldRGNoYN2ohECcVbmiTuiZrlmG0LClcmnqt/tyt8?=
 =?us-ascii?Q?2lBRR0XXzcDxZwoDUGUXN6exfqQtQY0ruCrndS0nfnU3bK6zuR3xsRjp9xoH?=
 =?us-ascii?Q?QS6wxXQFaDc3/CF9gJWyMjOyLY7aCm0PyDfDEPrq5LCursdX6ohYo6vKDdAU?=
 =?us-ascii?Q?ra8rx3G89W4J9x0oxoA6Hf5KsIQevdUUhkJhDrmZkB45rP/7vz6Ml2nB/fDb?=
 =?us-ascii?Q?bx1iTDB8CzPRm7v9ORplb1ZApT+gkc1sebYE07zNiCp2EMTlvzcRwRcPLVTQ?=
 =?us-ascii?Q?TTeULmZc846NSoY4VQjU9z9xtxLChowTllaLpKytB+VL4QcxzCk0IK+Ilh2H?=
 =?us-ascii?Q?woIAVCITzuN+zYhVoMkaHgcBNXNqNwXIm5hBAQo4xOCLUjgQ3/qWvWA4sU4W?=
 =?us-ascii?Q?J6P+i08Aq41b1m0KbSFHBQ6BEv05K/bjQzFbn1KEzW87dca1+Km+lunGtWd9?=
 =?us-ascii?Q?GiAzKcwNWYeAZcA+RLJkQcrOVzM9bA87bWWSrLuN05+QZ+F4QakVHgcuQbRV?=
 =?us-ascii?Q?DvZ1X9aXBna+a8irWhNzuyC9u6I6cq3mBBlkYaZ0AQ0O/ztOzJmQYV62gFwd?=
 =?us-ascii?Q?Rv3cWPME2fGtBJhirQI/GWpQmpmoXvz6RSLP4uHfyJhpUx8XbJ1oEH1YbX73?=
 =?us-ascii?Q?RmhdHRHuwbLp6sFQGhen9xl6lG3LwGFevhZUfJXOdJZRWo+Kle3Wy6F9xIeD?=
 =?us-ascii?Q?T3vMROwnK1KxV9qQXr+WdE+KzEONTuHluCotoREZJHTAE6lpxpPzUc7TYHwA?=
 =?us-ascii?Q?1b9FfQuA2xJWvTHC3Vk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e08271a4-dafc-4f32-faf3-08ddc52c4b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 12:20:19.0447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6u5dYEQVbITIFbM/jKcCdfqKpu1TIYBs/CHvzu+DPLSKMFIkn41T84x6fXSmonoefTwNAmmz775WnC0tCmnkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602

> > -				old_sec_h =3D *(__be16 *)(data + offset2);
> > +				old_sec_h =3D *(__be16 *)(data + tstamp_off);
> >  				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> >  							 new_sec_h, false);
> >
> > -				old_sec_l =3D *(__be32 *)(data + offset2 + 2);
> > +				old_sec_l =3D *(__be32 *)(data + tstamp_off + 2);
> >  				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> >  							 new_sec_l, false);
> >
> > -				old_nsec =3D *(__be32 *)(data + offset2 + 6);
> > +				old_nsec =3D *(__be32 *)(data + tstamp_off + 6);
> >  				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> >  							 new_nsec, false);
> >  			}
> >
> > -			*(__be16 *)(data + offset2) =3D new_sec_h;
> > -			*(__be32 *)(data + offset2 + 2) =3D new_sec_l;
> > -			*(__be32 *)(data + offset2 + 6) =3D new_nsec;
> > +			*(__be16 *)(data + tstamp_off) =3D new_sec_h;
> > ++			*(__be32 *)(data + tstamp_off + 2) =3D new_sec_l;
> > ++			*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
>=20
> strange why there are two ++ here.

I do not know, I will fix it, thanks


