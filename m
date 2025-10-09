Return-Path: <netdev+bounces-228318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72013BC7768
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 07:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CAB3E4280
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 05:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371223909F;
	Thu,  9 Oct 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FMXvoe8X"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB7221FBB
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989076; cv=fail; b=B5//jA4LKjepZCujqUhUuHENaCoNYH6GX0Mg4hb0BIb7JctW/Ymd7rKncPtv2PpHXwTZWYv6xrSMg+4QorJAEBpiOjKvrDjNtfLFzhoEWnD0WNv3W3Zqj+bYedhTiyU5BBgGb5M8AZsVIy1LkUycNdzJ+pw/x9sTRX5kGvjEglk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989076; c=relaxed/simple;
	bh=HfgtiNUThFF4yJIjG2cYizaXe2HSNWe8VNh2fFD7Oto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LU26tWsTy2uE4+rA6pY761HKwXiQAs4A9rqMW87GUbXkBTSHm1o9p0rF/DfXhBr00uKfGZkNlhfLxMWUi/2yCsN75meW3QGOctwfh5zCsp5y932ZKnIHJkYGquNpXDuLxanUBgsgde1IBywB84zoAbsD8IjlHmjKi8PnSdFDGyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FMXvoe8X; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfvrSlki/uEWkW34y8Sm1o6CZk7xKrRFXZqtZYz3iTwnaYP/h9JgF8oSjT7xfkmJuOvl8oZcS2D2U6bzgWtxYN5pIu9IF7enfmBTge1QU91A0YM1sPppGQ9TD4qh61SGqf+eMUbccVoaJFOy+94DLl1WIBNwNe8Qqny+B3a5lXBNaC/fgqKZLkbwRXgC5Jgj+3cXatbW320HaADqSg/NgYyLVcgvP2hlir0B3PVKnwBnsgNYt3eo90E/AC7p6jDIYRhXZipXjpjK7iBzP1VyZ/7lIYeNvFtCHC47qpeWs6Ijkt9lW1BYSOOfvvP0ZB3bBNBd6F5ah7N8i2DTgwBzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfgtiNUThFF4yJIjG2cYizaXe2HSNWe8VNh2fFD7Oto=;
 b=wfhS4bKpHZtbP3REfLHUPaxxy1FA5HQe5C15apSGdEq4XJ7wixNko1Qy4d+OycfLumfG6kIDnYkw816oq4Dm27ZTw4BmCeppZ3LyLP836Ppkh7abertRSJ30xch0PFm6Si0RcOeQeGY9aXpLxowLiSxivw+VuWGcn1uOP94uDvMOzvBMrtFOqsYZLgi/3hEd+xG3uGvIQPUhPfllAsShf7CHDztSueELUAbrh+G813a5Z2qLHji7+kXJGtgh+QmbGO0nqF7MDdR37PnIhgR5umsYzIoY9huXL8b0W/xDza+ps6iXi7MveEiaFqCLQW9HvkrAQWVQ0TQTjsGaUr2KJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfgtiNUThFF4yJIjG2cYizaXe2HSNWe8VNh2fFD7Oto=;
 b=FMXvoe8XBk5QwlKIe82Yg3iMh+1qK0dZtyieqFPmfbjh7Xix4WbhOuU23xW+awbC3zsIlJKtp1CYLejFS9WDu7T6EoadW//VZ7qEh8AUbKK7BUKpLjfTZ7Yosl31AkXwDjgUtPC/0PKHrDdM4WS30UAPA5IQ8y4KQaUx26qOuAQhlTPIVpSDPeeKQT9sNlYOpKJXafK/kwi3r6DZjrrevsEoeZoGj2hXfpWgq4iY/XXleBz2yKb8rrn2FYNX924RXhipMFhd0J8DL7tRsA6C/k0snANExEa4zfHnN+6KDNnr1R/gbC3FKE4A+6ZejZr1db5g3u4dYFRaVHWJChv6Cw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8808.eurprd04.prod.outlook.com (2603:10a6:10:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 05:51:11 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 05:51:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Peter Robinson <pbrobinson@gmail.com>, Jakub Kicinski <kuba@kernel.org>
CC: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
Thread-Topic: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
Thread-Index: AQHcNjmbHo/deex6Ik67RA4PsI6IZrS3dp2AgAB+E4CAAV4TAA==
Date: Thu, 9 Oct 2025 05:51:11 +0000
Message-ID:
 <PAXPR04MB8510DADA2C5A2E055C3021DF88EEA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251005204946.2150340-1-pbrobinson@gmail.com>
 <20251007181903.36a3a345@kernel.org>
 <CALeDE9MhZXmnQzazoN_HN=yTGiT=EWDhL4AQmERVvOmuELNqJQ@mail.gmail.com>
In-Reply-To:
 <CALeDE9MhZXmnQzazoN_HN=yTGiT=EWDhL4AQmERVvOmuELNqJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8808:EE_
x-ms-office365-filtering-correlation-id: 1100649f-cc93-42e3-aab6-08de06f7d9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aL799C9yxnhYDGfFLp4RGDvcvpbfXgUBJDmKHiL0vLQ0ag+jnvI1ThY/4i6Y?=
 =?us-ascii?Q?e2QngwnCO9i303TEaQEYLmcrx8KYrQB0MQQXSPS8ofAFS6HbZDmkAoeXUdfc?=
 =?us-ascii?Q?lqZrXMLroBjHJrtG3sp3CR7hU19OFWkubTG6au93Nk5BoYCqA5HeQs7j0KYa?=
 =?us-ascii?Q?ech4GyQo4yyfF4X2TM8/o8ayzk+QpllTt4UekYtYxRivONC51LMecXd8A+sn?=
 =?us-ascii?Q?noE4+vIlv5CHn9vqSmVvxX7MF6sQZwA+ayWPe/3VoVmKGQggfHiYY470yAGT?=
 =?us-ascii?Q?9geuXld5oWDPd7ZPP+KI9O/spUSg30B3SoRZ7fyScsg2Auw02aSWETVYtcqj?=
 =?us-ascii?Q?w2D5caAXnLlNbd1tFoZavpfjiVzT+MqW11dZ+DRPk57/ImT64PBtFI+Ts4vj?=
 =?us-ascii?Q?E/LbBXedbnrnN/Ea/X05ZrgneQbF09YLDnpQj0zGUtOsNJ0i5Hrv7Mv815tW?=
 =?us-ascii?Q?Wvpm1tBnxwPg1S5Jl4DM+BMQMe2Rlv4CV7ffWm3u6I4RKyjq33A3RsJUlMX6?=
 =?us-ascii?Q?jGaPpbalo4Sw7AAFaYupulYAYW5YLqGGSHyfI0zJXBwLeIyIYg4Zwfs30H3B?=
 =?us-ascii?Q?/BI6bFeZSTEiXORM+6/hw6E9ITiPJciS8U8zX5D+1aWZHeiQy6l87TrUkTWy?=
 =?us-ascii?Q?v+nNgmCKvQYeyNurrVX+Pb0ivNyHX5Y/Bhw5pH2Eq2/nnCA9Nr0ZMZ6faXvL?=
 =?us-ascii?Q?aLnXKJmH8RGg3OjD/gMPAWxobgzrqmeiLHpzbpiw1Ev+kkDiPZtgGECMTe1c?=
 =?us-ascii?Q?e2JBmXKB59A33nE5NJb8ie9vcut2aHEMkCreUq+amzYnDaASmG/GVWghGmlD?=
 =?us-ascii?Q?/K24cSF86r8zMPAHHOlewbW5bnYLsa8Z9WZFhE88orZhRur3CtIPUP29zwlj?=
 =?us-ascii?Q?hRNvEh73MRknXlTWXTQHyfOGUN8nKBs+BTAOWaOUL65BuUGXzD3Tvwd52fEy?=
 =?us-ascii?Q?EVjxwH0+yUWWYPuAAIgpB2g78Q6VzDuxVsoAYJZ2tgGXrs27LQPVJYXykf97?=
 =?us-ascii?Q?9/wv9hiY/+TCKBGRlpW8VUa39xETXhsSPMFeNNolxMCyt+dZU4Y+WLvhAMda?=
 =?us-ascii?Q?ghTi4fuJVDXln/DZmA/sgsh134W7fUREgtuYlQXS+rwhC/sFaFnrdPalA86A?=
 =?us-ascii?Q?6sBvCKQsstOWO+duuLve7h9W/Zi1/cAuuHdpWIqo5gfMdLrYjwswijWscx1B?=
 =?us-ascii?Q?7wbwXw6SilVvEqpvMe46AcGWgtalREJCr+X285/EdkKsDXmQ8DzKjdOUtmpg?=
 =?us-ascii?Q?PotxgF5bohLnHU0FyJQgoWCjB5TWsWl9b3csfXqZPSVHNXvWOpfIpuZx0DHI?=
 =?us-ascii?Q?1vhYjS2u6H4Z2HdMxl0omx4WYAOzCkrQodfTd7aJbo+X5H3wQPtioj7N5YKy?=
 =?us-ascii?Q?YbWhbxbeHBfkze1dinUvDA4gS+ynYql8MSV5lrdOnCmZlCoAnLefQKZ/Bi7k?=
 =?us-ascii?Q?gVmUHFo0NGg9fQxlEJnwGPNvA77m4ZZl4f1TPOc8f/oHw/OkFPchfuUjh6v9?=
 =?us-ascii?Q?TuoKDKtwF2GrKWPlXFuzuMRHtHY0aVqyRwOC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tbVDAllN/SYMyGeshKqXhL6p+nm7sBaBXbY5Rez8sh14yrwNugV32Z/ASEx2?=
 =?us-ascii?Q?91prRRBKbQbQFjX1Zrwfh+KgslBVPJm3NT7PhJbYCX+lidQnd9wGF2LZ0M4H?=
 =?us-ascii?Q?GRmC6IxdOwsFAitY57RzYdVJHrqfmdZB6HNFops0KnfaCEkuJNE9+wZzzNnq?=
 =?us-ascii?Q?yKtFRUewtMKyDjom6ueP/mW4LCu3Yc7e0qNM7UXIUx2S4pY6S8yEi2EHzoAd?=
 =?us-ascii?Q?9GJh8/1QeT8yM8U6H/pHcuAjL8EBYP4SzNk7wxf9V7/XAiv/Xs5IjQWEkZEJ?=
 =?us-ascii?Q?P66xz4af0FxTZxs4k5OwJufyyNAavFChtIg6B1omamScKUQ21t1EaCCbVvQG?=
 =?us-ascii?Q?/h7d0jUlPdi+84gECSMo3tEyy+1sd6hcw0s6Pv8mbdSQwt4vFnKWtCIJ3gLY?=
 =?us-ascii?Q?fyiimCDutA/kFskblwJbCpg+TW7scTmz6GWExszxVRJ05RBGKNvDysf1PIeV?=
 =?us-ascii?Q?nSdfDsqoop4W1SZc7s7/YxFnZbVPFthhVtX5J1cIFbs3MJRbpryW/oP04eH7?=
 =?us-ascii?Q?8OZy8U9Hg9HHMNxDsh2o59hAxq38sgNvd2krrNk8Ed9FCT+V8Kn1zaLpvCwM?=
 =?us-ascii?Q?GXDbiPVMKz4uSU+asiO3mrO+mLVJoKaETeG/PFCSZdpfRbZSvxWA0uvEpC2o?=
 =?us-ascii?Q?LxwyfUao8zWRc/1u99CvOyCgikxKhCCZzYXiROA7N/l5Vru2Zg8+Mq94ofJo?=
 =?us-ascii?Q?h+mgi7B0jOrTIZt5lKWGCDd8PP9F50n2gapr37VgtWTgQK9b+zLkFf2BVtyo?=
 =?us-ascii?Q?O3KoiVhreGJw1A+wzaFOuCO477kMFF0MbCp3KkmHZ+Zx954l6coNoKdElgsm?=
 =?us-ascii?Q?6qr4cjkf3jaw7ElODjPuVUcvmvPHPTewZh6Lk2bTVQSJE9uN2XI56yYJxRju?=
 =?us-ascii?Q?DTrDtanymicr8GsRwhys28x6UP8bgQggGH1mlbsbjh42ZuiU2lSUb0+BAySg?=
 =?us-ascii?Q?CfYcmj7x8Ne+QRg1U9fRUf8jEGJ/h2EWnRcaJDNSM4OUoTMHSrYZADEMjLgu?=
 =?us-ascii?Q?X0gutuwa6BFfecP5MnVpR/1+vhM+LWzKC+qhxf/6oEHMxsWU7xguW/JtgsB8?=
 =?us-ascii?Q?pKWq94rWhGzqf7XJns+Eorxrtt3YP4KR/LTZ7Sm7V+aZyv577RkwMvEErsma?=
 =?us-ascii?Q?IuGOMY4w+LF2749u/umapUiieO57n6AokMMWalF4a7Ai0H774xwVWb6Drd8R?=
 =?us-ascii?Q?sVbJ4dAREmqF89YAIAvATEAGRmNCG/pJadpjornrg5qQpiPZicjR19+OhiYW?=
 =?us-ascii?Q?gZLa2T99CEDA/0pSsi4aOBXNoum4OakTk3hTqmcb2wyDeSPRY0Y70AofBgV8?=
 =?us-ascii?Q?QIJGad+ycbgBCpWWHfOwB/EMlnqqD/5GZeYkhJQGdL6I8q9/P/cykZdI1aM2?=
 =?us-ascii?Q?xcyUkkW6hWssksO4zVvnxTZqhQ2zYdNKO2a8M2dMDKHdIQMy6QjqnoAxXj2q?=
 =?us-ascii?Q?3sg+ScsEWTPSnds+kvwWL87My+oY13CUnLcBJAHe9Pn+XwbutO1cmJtVLbCX?=
 =?us-ascii?Q?ChIcAQz6vyg3GxX/7ytTDbRDfQZypwxwAW8bglygzKwO7ryxjK4e3JaWFRqK?=
 =?us-ascii?Q?4TY92//6Aio2hSwM5Zk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1100649f-cc93-42e3-aab6-08de06f7d9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 05:51:11.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4rEFh1jUP/idS4c8mjgNJJiwXmZzTgs+UBUIOUvomDG9uFXHYYoSyBF3Xt8QiFlcD/v2Skvu7PEdIXW57Rdlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8808

> > > The NETC V4 Timer PTP IP works with the associated NIC
> > > so depend on it, plus compile test, and default it on if
> > > the NIC is enabled similar to the other PTP modules.
> > >
> > > Fixes: 87a201d59963e ("ptp: netc: add NETC V4 Timer PTP driver suppor=
t")
> >
> > You put a Fixes tag here, suggesting this is a fix.
> > What bug is it fixing? Seems like an improvement to the default
> > kconfig behavior, TBH. If it is a bug fix please explain in the
> > commit message more. If not please drop the Fixes tag and repost
> > next week. Also..
>=20
> I don't believe it works without the associated hardware so it seems
> like a bug to me, There's likely nuance and opinion. I labelled as a
> fix so it lands into the same kernel release as opposed to the next
> one.
>=20

The NETC timer and ENETC are two PCIe devices, and the timer
provides PHC for ENETC to use. From hardware perspective, the
timer is PHC supplier and ENETC is the consumer, the timer should
work properly even if ENETC is not working. For example, the timer
can still provide PPS event, outputs periodic pulse signal captures
external timestamps and so on.


