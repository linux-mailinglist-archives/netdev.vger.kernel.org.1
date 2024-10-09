Return-Path: <netdev+bounces-133848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69FB997376
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744AB286D51
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5E1E47B9;
	Wed,  9 Oct 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="a5MmxD2z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF501DFE0C;
	Wed,  9 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728495760; cv=fail; b=bzPPnFLCWygtaDDSPJQHBqWNuR3MkJG12B95ez60UVCUm8BlKLIdFIU8qyorsu6cF/eIIT7SuF3cxwwJ7LwnDFhLe1I7BN3odgSzg1BRbKh4y8Kxg8B6uJZONvvEDYrNxnaQCuMdKLdFKAUlc3l0PEIVCjdaIOEuFZdmnm79lYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728495760; c=relaxed/simple;
	bh=lEhVMCxrpyevKKFITNLzR71o+K9bSPl8PdN8WhzaNBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E3gJztrxRTmdkOa9WyFuHzjAaFo9G3niA1hIF/zI8w63RiraYucuMolgfG5HFLtnFyCDg9k8n34VBZq/vegFMlendHhjopuoY0sd2fRshchKY64Q/m93xswAjz1MY+bbQMriEFcF8R7h3PNB2Uo6SyVcTJhI05QEO8T/4ur72G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=a5MmxD2z; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxO74FNHO0j+yGPELBROVYM6nEQ3FeH5g4DnkooxJUl7aKNtzG4AAQ66Zmr/B3HSXwfaDZLf3PXYbOydL3Xn04CL53mtNUWYz6VIN1wBUcILNDEOGGMKwUFBti/GzM8/XbxpKjpBGvi6izSzsvuIOWZ3R4NZ+J6MyFIR0VWQSkYDAgcNgm6JMIsrSQR5Fs6MiQHp1jj/G8o/TSU2+kNjknlVSd3Yh5w1CstxDAqdrLEEOi/X8/ts3a7XEKYarslT8F3oT2SwjEDtZ3hqWRNavORO4i2VUEtkbqUnLfxcA6G+rf+46/ncVDkGsyhjFFmpV8rRPDhPRXHWjfByJy2mQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27LVKBg/RMOEDP1dc4L3f7WECB1TbkpQLIQinPT6Uvw=;
 b=aniKZQpqcFooSWJZL1POoL8pzXDL9lei76BAOrCovQXSWEEGDIdlh0rGS7bnnZwsJKYgbPF6FxwiMRjJ4+Uf0lRmFYRZXa/gJXbQV1LYodDsppf0MInGGMQChSBX3rY6U/zkSpkPPifnqM5jwStbyYfnT8puNEdaedJG4yRslB/NsW+rSnO39ro3VDHh2qMiJB2vR6FYmeEp8T9jB/kxcbCDXhI9qiR+sOUbdPDykmShBKTtRvLHEqOeDf6AU0305ZZoAHht80ZHfcsyMfAu1EyMH1YlhBPi3NrAdwhM+HhT3agGwViw3jSjcbfOczaXefTrs4vNAj6hkPYvgpzn1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27LVKBg/RMOEDP1dc4L3f7WECB1TbkpQLIQinPT6Uvw=;
 b=a5MmxD2zZ8VI/0nbVuQ+hFtWjz9f6f/lpb65QODkRuawm8CWbzn+ThN6lgVuuTj4YBYsJDDmFLfbS4sfE4hWgHz2jqGfGcJS4hZiDhUJ2VA67aSk77Fc5OCwDdDd/QlJx1nRQRhAqtOF4KmbTjR2z69wlQxSA+fKE+6K9hEQ7ug=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GV1P189MB2057.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 17:42:31 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 17:42:30 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Thread-Topic: [PATCH net-next 00/12] Add support for PSE port priority
Thread-Index: AQHbFOg2kEXpUrWIdU6ri6RpZ6mROrJ+e8eAgAATWQCAACw+gA==
Date: Wed, 9 Oct 2024 17:42:30 +0000
Message-ID: <ZwbAYyciOcjt7q3e@est-xps15>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <ZwaLDW6sKcytVhYX@p620.local.tld>
 <20241009170400.3988b2ac@kmaincent-XPS-13-7390>
In-Reply-To: <20241009170400.3988b2ac@kmaincent-XPS-13-7390>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GV1P189MB2057:EE_
x-ms-office365-filtering-correlation-id: 71e7f76a-432d-45ad-167f-08dce889c006
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BrnKi1leFarOGl70XUeYXycnqfUl9GTL1IFjju9KO32WU/Ei8CFSggipRf?=
 =?iso-8859-1?Q?9fpWmbZiUXGh/uClc3ihKZ4178hdX1S+XnA6otpE6pjmNTpEulLL/N3sWt?=
 =?iso-8859-1?Q?SUFz3Ton1G1elMYA0qdp0NgWwql5f1wEiHT/lwunoSjmGz5puA5t+ty42b?=
 =?iso-8859-1?Q?zd5DxvDV7/3l9oB1AnkEHl4lk/9rDMiQ3jtMAAVo3AVkMMDLQCQDoPOyt1?=
 =?iso-8859-1?Q?0jl21BdbQ3t8GP7ByDrufeeYxKmGeF2pL5L03c1hV8H55XJGMox9tcQlPk?=
 =?iso-8859-1?Q?C9tzvtBuqEUrGM7x08ZjTIQgyy351lo6mBd8P1umXrrfikgPSB75V/Rcsg?=
 =?iso-8859-1?Q?HsHvvZswZtauP8JHmNGVIClHEy67sa4jl9ohsLwh/pocpIrMaz++qj5Fsz?=
 =?iso-8859-1?Q?KLbV/m7nK1hu57mdzmryihrjkI5HTJnQcdZSzbPE671okJWNyK15j34V8J?=
 =?iso-8859-1?Q?59nOyzALX16vWHI0C/2ZB4mR8gxccIYoTKVVct6oByS3dmVtOawndpFSQH?=
 =?iso-8859-1?Q?pUR7ds4JYwJM0E0za/mFfdqEr/KG8P+IQA5yEWtNw4vI5RAbeRtJSHgOrI?=
 =?iso-8859-1?Q?CWzMy4YQp2wf+q8KyKYTriMYay7vGMJleylT6T4QPhiWax7zTkTCPIXhWc?=
 =?iso-8859-1?Q?rmTFd5NIUcVEFoiMBC9KYSLdqjYVN2VM5ltJ2phz6NXj7g+3QYxMjQWWeD?=
 =?iso-8859-1?Q?VVFNf3lAZGAqY5Q4DUIhQRC0Y6brz1pX8wcDBHm/aj62z2VotQdEPzHt2s?=
 =?iso-8859-1?Q?s2gfsiDOXCa9vLt4zJiW4YFTZYFbaUPldtQ+RMgBIMSR5M1uHzGNjpvMp3?=
 =?iso-8859-1?Q?qRl9MQ8RNI4v5tbK5AKkl6Z7YOs+tbGsFPMEgHY9UKy/0HG4cpgOOxB2K5?=
 =?iso-8859-1?Q?5oX0NBy2knW4cqdtUSEdYon/xrr4P7UlrALPerW+hnKzcUpEe+KpqyKJnB?=
 =?iso-8859-1?Q?OKgoSeu6dnxCBRXJ0D5RvuTEMGNbP8NslJxV+jNMFkMdDkVIloEoq0670m?=
 =?iso-8859-1?Q?Pid966L05ez4BkCY1JG84N2S2vCMUnDLkBGMvMlbH3KK4R28xA12A1ShkK?=
 =?iso-8859-1?Q?YxEjgG/mkGu2cVxf8gIeE+b6+FRO+zeFMHZNPFBmeOAi/mV6WGno5u7NP3?=
 =?iso-8859-1?Q?Nyt5Hvpr8nKx7AS5ttAlj3WWfjBseOuGBKQl2advYCj5mI26uHrNcbTp5Z?=
 =?iso-8859-1?Q?KTNzmHorTwNHuWMmO05ssIn+8UnGjIrEr2MDraMADITf6ahGT6FAY2tMKf?=
 =?iso-8859-1?Q?Y58hqSUSRzlbDo+f+a0TROAWgKd/Y/lalVdk3Yo33Rnia7ADvjKfIXEGlQ?=
 =?iso-8859-1?Q?t16Dzn3o7pOrDHO0CJKyY5bAhw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KE0eVC9mUCcQe/rm7X9e0xnF5btz9zxmX4wezZGMOuGcEcuA1o11k5IPRz?=
 =?iso-8859-1?Q?eE50Zkdk6bUmcZQqDdTvN/FYsfF12FppbOmZ+xUWoA33BmxOYRthhkjvwE?=
 =?iso-8859-1?Q?GHJaRqCFUDf0/o5795A8mcKkB89VWZrML5jn5/rf154IhRA23UjZ9BQyZ/?=
 =?iso-8859-1?Q?k8A1Z11yAEiCDYfYnaGKp8GbBihygNRvDzVu3tulAQJ7A27qChWvuxAK98?=
 =?iso-8859-1?Q?1piOfUH9ITUXkaPtfxmVy9iE8ymu5K33CkQfnAebEuiUrJ6XMmM5DZHeBB?=
 =?iso-8859-1?Q?xvZH0sXVCk8akmQe2a+SvxUc3PQJ4N1t7tau4ZdLi1o90RYJCiVrGbzC8U?=
 =?iso-8859-1?Q?ZiSHuuLjPGyr5YgemPhykvSVr5IgwUthabwMDuzCP2FG+LPFr6LAapRiDs?=
 =?iso-8859-1?Q?Ardyou7ybZzOcRIQgQdQedEVqG4VuiJKygIM9rjdCVn45uGqgzNdLyUD/I?=
 =?iso-8859-1?Q?Xvu1exR9OkCYCUVhesbSk62lF/hIIquxTjPv/XGm5azLGiyYnPEARle5nE?=
 =?iso-8859-1?Q?9Y45U+H4Bn6Scda8Ie3cTFO6FwsRqX1w30jVUNYC25vsqcWfyyEM4r1rpS?=
 =?iso-8859-1?Q?ebW7Z91hka4BEWpM7LnroM88/EDcOIDuHQsYj4x0Xgw10xurRtxHkyskLt?=
 =?iso-8859-1?Q?pGPdNp4puKPUNq35GAMkFpb+BqAlK1ceHC4m1gZasx97kaLrpVqawestg6?=
 =?iso-8859-1?Q?HimQEXb6oetItI9LLMqPlV4Y5gTtCFrJC6C02YnRDrJtiY3xUEklUG+yzW?=
 =?iso-8859-1?Q?rqU6eGZU8NfhmIPO79itKrP3lFq6rSi10qTigwzApOwHmoZDBMBVgUjsxJ?=
 =?iso-8859-1?Q?9wFIgq5j8cfWTCnr8wjRF+AwQLrU6NyNDPbju7az49aI4jpYZ9uLo2/hu3?=
 =?iso-8859-1?Q?CKtoGnQ2kZ/Gz8rU/RgvLcmF2YTZ8WtrjnoUoZrzFvHmYnyQn8ENR0urOS?=
 =?iso-8859-1?Q?TCnAy3UMPDLRHLi9xWD4XWgt3hSwY4PZWELpDsub7jTXpGv6pMjB2TAwJY?=
 =?iso-8859-1?Q?qQ+/mDTVLQ2QNZXO/6hILx279KzWqnlcJNQbty0mhlpgh59+hE55DfVKwk?=
 =?iso-8859-1?Q?zw/jZrnXgmrJkYOWHV9Cgjc4+EjYqi6ooTzicayCpreQqwrr1wn3ksPF87?=
 =?iso-8859-1?Q?1yOfAvsUlq5iVV9iJUfaC3/wVjJ6gClc/8FHhw8DOgV3T/ejoJvyGg4osn?=
 =?iso-8859-1?Q?fvQmCqoV1eOfrN6W69xpUo0mu5IBRrgByEpLjAQ3YH7eV9vFUObPjOFNdQ?=
 =?iso-8859-1?Q?S9dVTqUsFYQnpSPYAw9DratwXvWBBaQPK4lQaAnRPThZc1VkX7WG2n8rNW?=
 =?iso-8859-1?Q?DBoTERbVn9l5tw2XIuN6YvGpFYXKnXJcOAOEwFnQ/l6MYjSwjWvX9zK+j0?=
 =?iso-8859-1?Q?Ub8/Aj20K2OZHQ0XPT1PfxHRhYyUJDp58UyZOLTeqeHysYUJPeLpxUdn55?=
 =?iso-8859-1?Q?VnHNfU079FSJwzbE1oDvesr883MOqaTIu/FM1sBR/2XEGXA5oSd0EpRkl8?=
 =?iso-8859-1?Q?4Ag6yVj7MVE1ltgFEoVXhfuWblteXGX6dhUuGwj9bIK9Mi/DC/FAmBN83g?=
 =?iso-8859-1?Q?zGEOH0sTSGmS18aAVpoqcRnpo5sAN1fJAJtF8d95L6kXLqPH5ejTp/erhD?=
 =?iso-8859-1?Q?f9hG2kkAjuPVkd8N1/ZMAmUe7aBVWLpCo1smwYlSt4mDUf2gdRNabS3g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4C1144E2C89268459FC60F078316531B@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e7f76a-432d-45ad-167f-08dce889c006
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 17:42:30.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+iRI4m1xVTX74e3DHU9nflBLQvraAWx5oX4RUneti9dHpBKaVQYO6d1S4/v535TwrW6C3cQq5C996G4IouwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2057

Hello Kory,

On Wed, Oct 09, 2024 at 05:04:00PM +0200, Kory Maincent wrote:
> Hello Kyle,
>=20
> On Wed, 9 Oct 2024 13:54:51 +0000
> Kyle Swenson <kyle.swenson@est.tech> wrote:
>=20
> > Hello Kory,
> >=20
> > On Wed, Oct 02, 2024 at 06:27:56PM +0200, Kory Maincent wrote:
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > This series brings support for port priority in the PSE subsystem.
> > > PSE controllers can set priorities to decide which ports should be
> > > turned off in case of special events like over-current. =20
> >=20
> > First off, great work here.  I've read through the patches in the serie=
s and
> > have a pretty good idea of what you're trying to achieve- use the PSE
> > controller's idea of "port priority" and expose this to userspace via e=
thtool.
> >=20
> > I think this is probably sufficient but I wanted to share my experience
> > supporting a system level PSE power budget with PSE port priorities acr=
oss
> > different PSE controllers through the same userspace interface such tha=
t
> > userspace doesn't know or care about the underlying PSE controller.
> >=20
> > Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI'=
s
> > TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanc=
ed
> > configuration, supporting concepts like a system (well, manager) level =
budget
> > and powering off lower priority ports in the event that the port power
> > consumption is greater than the system budget.
> >=20
> > When we experimented with this feature in our routers, we found it to b=
e using
> > the dynamic power consumed by a particular port- literally, the summati=
on of
> > port current * port voltage across all the ports.  While this behavior
> > technically saves the system from resetting or worse, it causes a bit o=
f a
> > problem with lower priority ports getting powered off depending on the
> > behavior (power consumption) of unrelated devices. =20
> >=20
> > As an example, let's say we've got 4 devices, all powered, and we're cl=
ose to
> > the power budget.  One of the devices starts consuming more power (perh=
aps
> > it's modem just powered on), but not more than it's class limit.  Say t=
his
> > device consumes enough power to exceed the configured power budget, cau=
sing
> > the lowest priority device to be powered off.  This is the documented a=
nd
> > intended behavior of the PD692x0 chipset, but causes an unpleasant user
> > experience because it's not really clear why some device was powered do=
wn all
> > the sudden. Was it because someone unplugged it? Or because the modem o=
n the
> > high priority device turned on?  Or maybe that device had an overcurren=
t?
> > It'd be impossible to tell, and even worse, by the time someone is able=
 to
> > physically look at the switch, the low priority device might be back on=
line
> > (perhaps the modem on the high priority device powered off).
> >=20
> > This behavior is unique to the PD692x0- I'm much less familiar with the
> > TPS2388x's idea of port priority but it is very different from the PD69=
2x0.
> > Frankly the behavior of the OSS pin is confusing and since we don't use=
 the
> > PSE controllers' idea of port priority, it was safe to ignore it. Final=
ly, the
> > LTC4266 has a "masked shutdown" ability where a predetermined set of po=
rts are
> > shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's =
OSS
> > pin, We ignore this feature on the LTC4266.
> >=20
> > If the end-goal here is to have a device-independent idea of "port prio=
rity" I
> > think we need to add a level of indirection between the port priority c=
oncept
> > and the actual PSE hardware.  The indirection would enable a system wit=
h
> > multiple (possibly heterogeneous even) PSE chips to have a unified idea=
 of
> > port priority.  The way we've implemented this in our routers is by put=
ting
> > the PSE controllers in "semi-auto" mode, where they continually detect =
and
> > classify PDs (powered device), but do not power them until instructed t=
o do
> > so.  The mechanism that decides to power a particular port or not (for =
lack
> > of a better term, "budgeting logic") uses the available system power bu=
dget
> > (configured from userspace), the relative port priorities (also configu=
red
> > from userspace) and the class of a detected PD.  The classification res=
ult is
> > used to determine the _maximum_ power a particular PD might draw, and t=
hat is
> > the value that is subtracted from the power budget.
> >=20
> > Using the PD's classification and then allocating it the maximum power =
for
> > that class enables a non-technical installer to plug in all the PDs at =
the
> > switch, and observe if all the PDs are powered (or not).  But the impor=
tant
> > part is (unless the port priorities or power budget are changed from
> > userspace) the devices that are powered won't change due to dynamic pow=
er
> > consumption of the other devices.
> >=20
> > I'm not sure what the right path is for the kernel, and I'm not sure ho=
w this
> > would look with the regulator integration, nor am I sure what the users=
pace
> > API should look like (we used sysfs, but that's probably not ideal for
> > upstream). It's also not clear how much of the budgeting logic should b=
e in
> > the kernel, if any. Despite that, hopefully sharing our experience is
> > insightful and/or helpful.  If not, feel free to ignore it.  In any cas=
e,
> > you've got my
>=20
> Thanks for your review and for sharing your PSE experience.
> It indeed is insightful for further development and update of this series=
.

Excellent, glad to hear it.

> So you are saying that from a use experience the port priority feature is=
 not
> user-friendly as we don't know why a port has been shutdown.
> Even if we can report the over-current event of which port caused it, you=
 still
> thinks it is not useful?

Well, not quite.  I think the concept of a "port priority" is useful,
but I don't know that the PD692xx's concept of "port priority" is what
we want.  The issue is the PD692xx's budgeting algorithm is based on
dynamic power used (i.e. the total power used at any given time).  Since
this is, well, dynamic, it makes it confusing when a lower priority port
is powered off due to the runtime behavior of higher-priority ports.
It's even more confusing if the implicit or default port priorities are
used.

Instead, we found that using the maximum power that is allowed be drawn
by a particular PD's class (set by the IEEE standard) is more user
friendly, because the set of devices that are powered won't change
(unless priorities are changed, or the system budget is changed).
For example, if we've got 4 devices plugged in, and the three highest
priority devices consume all the power budget, the lowest priority
device won't ever be powered.  There isn't a case where the lowest
priority device will be shut down because a higher priority device
starts consuming more power at some point in the future.

> We could have several cases for over power budget event:
> - The power limit exceeded is the one configured for the ports.
>   We should shutdown only that port without taking care about priority.
>   TPS23881 has this behavior when power exceed Pcut.
>   I think the PD692x0 does the same. Need to verify.

These conditions I'd not call "over power budget events".  I'd call them
"port overcurrent events" and I agree, those only affect the specific
problem port.

> - The power limit exceeded is the global (or manager PD69208M) power budg=
et.
>   Here port priority is interesting.
>   Is there a way to know which port create this global power limit excess=
?
>   Should we turn off this port even if he don't exceed his own power limi=
t or
>   should we turn off low priority ports?

I think it's important to make a distinction between an "overcurrent"
condition and the condition where we've exceeded the system power
budget.  An "overcurrent" is port-specific, and can happen if the PD
consumes more power than the classification of the device allows.  For
example, if a Class 3 PD (i.e. 802.3at, also referred to as a Type II
PD) consumes more than 15.4 W at the PSE, it will be shutdown
immediately.  This support is required by all the IEEE 802.3 standards
around PoE (.af, .at. and .bt) and is a safety thing.  The TPS2388x
implements this with Pcut, the LTC4266 impliments this with Icut
register, and the PD692xx implements it with the port power limit
registers. =20

The condition where we've exceeded our system-level power
budget is a little different, in that it causes a port to be shutdown
despite that port not exceeding it's class power limit.  This condition
is the case I'm concerned we're solving in this series, and solving it
for the PD692xx case only, and it's based off dynamic power consumption.

So I guess I'm suggesting that we take the power budgeting concept out
of the PSE drivers, and put it into software (either kernel, userspace)
instead of the PSE hardware. =20

>   I can't find global power budget concept for the TPS23881.=20

This is because this idea doesn't exist on the TPS2388x. =20

>   I could't test this case because I don't have enough load. In fact, may=
be by
>   setting the PD692x0 power bank limit low it could work.

Hopefully this helps clarify.

>=20
> Regards,
> --=20
> K=F6ry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

Thanks,
Kyle=

