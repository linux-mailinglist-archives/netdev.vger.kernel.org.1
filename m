Return-Path: <netdev+bounces-173160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9AAA578D6
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 07:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6ED1892AE3
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EC519047C;
	Sat,  8 Mar 2025 06:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TyjKv87C"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5B137E;
	Sat,  8 Mar 2025 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741417116; cv=fail; b=XS1pKG16SoqhTtGDRdWvoPOM5PNxaZ/Vrm53EchaBY+AAHhMwFDfNyrertb7Wb3LValgBzWJnJf0KLunX4PQoJO0hXHRGAwQCE9r7CWQkfmCSCcUTwNv2ojwL99RwlQ+B1A8Njoc8Sc0gjy4BeZ9t59ogn6cJ16RmEHomn2fegI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741417116; c=relaxed/simple;
	bh=eU27EIXvyw/n04EcsY4NoM+U6kiUIem64UgRBvitWRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYV4U9cDzvM5RT1m9x5pC8rFLCiFCK9XVt7IL3kGhMXaPuYYiGkHwPQ5MgnftNKDyq/QKKeh4SdcnbAiVuDbRsUmx0VAlM9L/28W93fnE2qUGN4Tgej6XhSvSKKcf/cIjDH1+rGy6TdA/lTejrBCzJMmGfM8Ikc4ivDTcKcW5n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TyjKv87C; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz20XAbJdgb2L61WKsfRwz0vWnqzq8hM9I2LdDE0E8wew1KWckfefQj0rjLPgj7DuPVydEtVt8jd4e6zJStahiISiAFm7uIMCzZ/6M+QUfWWmpnl+2yHL3AQqNgZw1PcEcjlL61yxeCChqrTYaVuYRgRJYdpmlkgd/V9u0S+Dy7jJBj1eh3i8XWkt8o7/ZM0Z/8fAX/0cxGPybK7bNfVzEfY5KIvvy2VeqnGn5G2KaBsqC5xP3k6Vq+4UQsJTt80UVGSi3pgMOwfIvWCVbnajK4dwhEzywIJ/RP3t3rhbbDpDaf2MjRxdjuK7fSNdtAeKO01VUB99MhGeCVKTF6XeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6pZ8rkdSaVuEJ8JCUWFQBGtDJeMckIEv/9XXffG91Y=;
 b=fBaaLHV0TEB77cxcOgmgfXu6PWOD5/Flrlkp3sbBd7TLmzSUvKd9w6LVrCsyeiu8L8qv8RUGhaFYKK677gfa85vlS2NbZ105WDDjsbyaJtErHewbf23lfEb4auuifgfzYMjcmdsPnnULvtfBv1z5UiX6muD+fHWQ5fe2aPs8CTGImoCFwv9npXyKuB16BBpVdzTXh+IXHrkoUIyoCFtHoYf3kZaOW+YYKIRPQ8taNMIjh0iISA22nG7peDgZBimr+8p9po4GF0KCoO4xsSoW/vh5BoR67d2asTKgwbm25OXSRltYaafYxDKazao6WL6PUuK6iQRNgKFOIUcThYrq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6pZ8rkdSaVuEJ8JCUWFQBGtDJeMckIEv/9XXffG91Y=;
 b=TyjKv87CxLi7NxqgSOUekzBzSunDW8gNbpzHPDNJgAsmUeVEfDhjj3gnTm+/1wbrEdxJOjGn0mNRWA7Z+HtNKxvsTUltP3ofASdsn75WN/aZDWyF1PDZ6pnIPkTgUD1FshV7XJZZ8+a1D/HwUGHH1D2bFGDkxecRVrk+TsogN9PzO9HRVqksILzstsDwWtcHaUbERgWJ5mHsculF2KIf0S4V4E0d+FZyZc89DFf5PlLKb22Gm3EzDX7xirhWe8fHqwfBOuFXY61Zz1UGGcqIdRi9Sx4TFZM6YSwRSckvHh6tuW8a9l1xckiKnBFQbdnTGmURMpXkONP1TuIUEFkNdQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9904.eurprd04.prod.outlook.com (2603:10a6:150:119::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Sat, 8 Mar
 2025 06:58:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8511.017; Sat, 8 Mar 2025
 06:58:29 +0000
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
Thread-Index: AQHbjNiMrmwkTzPG206zUiHxDe17mbNmtIkAgAAxcACAAZzhYIAAD4wAgABB49A=
Date: Sat, 8 Mar 2025 06:58:29 +0000
Message-ID:
 <PAXPR04MB851024A8448430F298831ADD88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-2-wei.fang@nxp.com>
	<20250306142842.476db52c@kernel.org>
	<PAXPR04MB85107A1E5990FBB63F12C3B888D52@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<PAXPR04MB8510771650890E8B7395B2DA88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250307185902.384554a5@kernel.org>
In-Reply-To: <20250307185902.384554a5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9904:EE_
x-ms-office365-filtering-correlation-id: 6e963b29-9bc1-415b-9123-08dd5e0ea1e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EUM8864rqNGFFZoCMcw3B5xIlTnvvuxiAP6KoozgO6m6hIvrTtufwVptMnxF?=
 =?us-ascii?Q?BybD3pcDz1DDaswgVNd2oVVyjpP9mM8Jq+ivS00oAtYmv3SZkZ5OqmER4+0U?=
 =?us-ascii?Q?YTXqX6wnJ7j6gXeWCceSAnNpF108ZlgRyMFXHkdyD4gZqo3Y4+P1S67c+Twy?=
 =?us-ascii?Q?ukHi8VK80po+6Drs+B3TYno+otSqJpD4dluOJTE/DuxTt/enS17BD/IP2uiS?=
 =?us-ascii?Q?I0TetdFRYme+c/+7TBZHpJOnaVPXkYGJ2WktjDtBtIX4Taqg8/PLvQqaAgqF?=
 =?us-ascii?Q?QQlyABOcN7/QqQA4PlniQI7VLEd4XGY7rRWEbcsD/UMfHQ6Yo694tsik4nzT?=
 =?us-ascii?Q?D5Njy0ALA2C61xZP5qlIK5U4uoLRTdwUB1gvfp4NdJDlfp1P1DaLjDWO1puU?=
 =?us-ascii?Q?uH4+IwPDbmNx91BL19t3tgfgkkUOvIE80GzTNmIGmrX6TtA9sI0m5OWYh96A?=
 =?us-ascii?Q?n4AwIPvSARGAGp/itfg5G7Jmor31Xch0Tkp210exoffBJ+xXzGP9zXVq9wJv?=
 =?us-ascii?Q?8cBxwpHlf1zitouORDDWQAagFKmNcIoWG651/E3S9+7S8UNEEYC2juvjt+yB?=
 =?us-ascii?Q?fTIrADIxUShDCgF4MJtu3/ieO3uz0iQMQTnFm3fQEggCyhesXQfE9HJf/YJA?=
 =?us-ascii?Q?eYCKjGv/7DKltTH8AcHKJOMnBIneVmi8ds4VL9ef99mwgGA5/4VCqhJN+VwD?=
 =?us-ascii?Q?qbfcFGO4AyAigly2aYtml/c7I5SbxerkDWYb9cFzk2t3ui40AuQDtgwhe+FN?=
 =?us-ascii?Q?Kyc3ITdK4xbSy5UJjB0DNSMcqh5sZu9SA8gUuCYiF5B4Rx49ihyIUaboRKt4?=
 =?us-ascii?Q?MPJ9NDCMX0c3cZIyX1M5Vt1Ek4CAzc59qk/IAttvZlAGZ4z/8Ve5qbv8RtVf?=
 =?us-ascii?Q?ACr0pdqDBHIUzOUiGN9DiRWY5IgYECfRPZ/C9cfWTsVHWN0Bc9gHpXzuWFeV?=
 =?us-ascii?Q?8oN7+eZo855jJLs93brm//1pmelgiPBXMSGD+hKmfK11mD9EnB92E2arJamr?=
 =?us-ascii?Q?hftO4lz6ICyinD6LtOvIT6ibOCtiLojLsNTSrHNbaJGZi7rlSygOT8Bosuzu?=
 =?us-ascii?Q?ActvfmyLFyl3Gs8VV9fQ98X6DEyipyl3RVcLc0cMBOM88FaC2EK2eNtLfSqC?=
 =?us-ascii?Q?2Vr3bV1sq3LaDmQ+LlFZq2Yd77vSBG/LSfd7S5W5iQmhHWvh6xx1nj2DffD3?=
 =?us-ascii?Q?GHSOnDsVYl1We/EXBPVABDKBwpFM9/QgBKi8d4Q/m0fovuedMT3ei4MbhXNo?=
 =?us-ascii?Q?1sErGEDa9ZAjQGnvNbQhZuD3hLR3wB0tL/sDL7Ga4MrS4dQKJNgog9ZLdCNF?=
 =?us-ascii?Q?gWvigjyXpHbeCP/CGVCmf18G/4SjK5ON3C33jeirreN7OXfIOlDkNGugQ+tz?=
 =?us-ascii?Q?X3Wr8XrblTMD0EEnZ+GLyrAdoHVNUD6FFZ3fRiDyxoVGly0LA+12ATAbFF6P?=
 =?us-ascii?Q?YdpQ4qgD5mg2TQycirFz25QbJD5ZqMwR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ky/jifM7S8igPF8HgGqCwTHDdbuZrUcf4pzdbyUGlFi5Wynjz6SxVSB6Ok+N?=
 =?us-ascii?Q?I5EKi5wtU24XMD8shpEI9aOY20AbS08z9kGCnilGtXA0MjtuU9O8Jt6eQ0K/?=
 =?us-ascii?Q?95Ezf4Qm1O1DIeU0yI974sJCT1esBC2/Us3fcq12uH3B4FHPTaIR+EnsIZ8d?=
 =?us-ascii?Q?SvmEAAam/h2bCISNdANv4JmeB8XtYRjGNhtCVfjwziPcmQMFAjsoAqr3n0b1?=
 =?us-ascii?Q?Z6uw7/3Oupkfi2E9g16CoavgZU+AxNVFxY/yFNXpAEz3ZiA8ZxQMBSg1Ztz7?=
 =?us-ascii?Q?Hh3le6jF4WaQFiDB2TfBOM+Kj49f1+CvzwvF9OIfl5iP9GfW+L6fQyrShZCX?=
 =?us-ascii?Q?MzYb/22vJr2lR49OPqayLB/uaKf+jTld5o8jwRyVkUvWJ+MNR0k/oXsrt/UT?=
 =?us-ascii?Q?AQSJWBl7BM4wHhE8PBIwS4mE9yiKKhmHchbnoy06mUWZAVKSYf4v5K0hjM0b?=
 =?us-ascii?Q?PaLqSEKwsGNH8F+yXcMo0gBRPya50EDL8uMVrLmkNFyEvfSYEkN5wtbNDZ7b?=
 =?us-ascii?Q?gZTNzM7ypuxu5QBToBqWU2olXXKxN/ijEXVeXDB6hmSBUTl8Ny5oifXyQgfg?=
 =?us-ascii?Q?bY93TB0DKwWone5ukO5OdW5iYj99AEiWEs8CL44ExgR4Kf1cHWDeVX3h8hHt?=
 =?us-ascii?Q?/WoHqZOID34k+So43pWDBGWBFyd/6IKbl57yzgUTY6T3xvlUt9a0UjfbN32D?=
 =?us-ascii?Q?deNuk9Ud4FAg6r2KPql7oYLHsBxYdfjm19Vetxsp7FJnkAldOv25uS9qYypt?=
 =?us-ascii?Q?wG5KzkWSWoicgnixwa4vldHB13ytq2LQmxMJY3+zNxn0wcqp/5PL5pcV4uj9?=
 =?us-ascii?Q?IrdG5c1o/5bc8UOz65wfHpNvVFj8ZKguj581eeO+CLRR+hxuetfteiRaQLcS?=
 =?us-ascii?Q?zvQ3/E+ccNuiSR0KkpNAf4RPev0xi84/CNJWBRI1cPobovHa4lAgDejpcZjP?=
 =?us-ascii?Q?BuE3g4Kvcnr7SyZkVehsqQvyRKLBeTI/30l6p7vr9owrJEaBs8R3H4i0ULpf?=
 =?us-ascii?Q?S2GzSt4nsC5/mSmwGQrlXmAGtUw+ajcZDZ6VRptCusfxZUA55abGfHpWcfkn?=
 =?us-ascii?Q?7GA8yUfA9jsIGvssXu8sMGS1Gfg2V/+Uw1SmPuS9YxPZumGIYYtdA5V4EjxD?=
 =?us-ascii?Q?of+tOQThJFhRLmwQzceQn/NV9HX6xztYku2yfb4KmVbDZCkVW1oOCKJqGC52?=
 =?us-ascii?Q?XOxtd/hVHPpi0nyDkv8qiIF3/A9aOdisVyfdUyrf5gCVQ/455hpT5G7gxAHM?=
 =?us-ascii?Q?8GFpjTdUrwRer4uoiawOWI8Qu0Hl6iw755y8cpWgMcIlbk0P4d/PWXfGyCyo?=
 =?us-ascii?Q?TdnP+TjG9kSljRPHbNbAIcddDoXvt6F7h5LJV01aA8UrzElWhF/YX0MPocuw?=
 =?us-ascii?Q?70HkzVZqKFa6Hjle0AkT0o0YrDqGbiXb82I26HI9DRSlGc9/l3iwPXK5wqMF?=
 =?us-ascii?Q?kkhdQqD+I7OgCbaDG9cGFGkm/lG0DIBYvldWg7PwimpoULXG1xZW8F8/SCu1?=
 =?us-ascii?Q?uTKfVzaRD636AII8WcIPadbwbJxZP2CIkbAwz1OE7hzFz2LAIn0a1Cl/lfZ6?=
 =?us-ascii?Q?HRClsj3FG//5YefJjf4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e963b29-9bc1-415b-9123-08dd5e0ea1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 06:58:29.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNxz+MimmLvb8wMI2n6OySl6AKALg9sBIheosoMoW0v5Q6fmOf4+kNMA/J47oFIM/v5FS1mA9tO1MDgEUMrH6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9904

> On Sat, 8 Mar 2025 02:05:35 +0000 Wei Fang wrote:
> > > > On Tue,  4 Mar 2025 15:21:49 +0800 Wei Fang wrote:
> > > hm..., there are some interfaces of netc-lib are used in common .c
> > > files in downstream, so I used "ifdef" in downstream. Now for the
> > > upstream, I'm going to separate them from the common .c files. So
> > > yes, we can remove it now.
> >
> > Sorry, I misread the header file. The ifdef in ntmp.h is needed
> > because the interfaces in this header file will be used by the
> > enetc-core and enetc-vf drivers. For the ENETC v1 (LS1028A platform),
> > it will not select NXP_NETC_LIB.
>=20
> Meaning FSL_ENETC ? And the calls are in FSL_ENETC_CORE ?

Yes, ENETC v1 uses FSL_ENETC, and some of the functions in ntmp.h
are called in FSL_ENETC_CORE, enetc-core is common driver which
provides interfaces to ENETC (v1 and v4) PF and VF drivers.

