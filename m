Return-Path: <netdev+bounces-164154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0055A2CC37
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671EE188CEEF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB98C1A073F;
	Fri,  7 Feb 2025 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lIK5eqwv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608BA19E96B;
	Fri,  7 Feb 2025 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955023; cv=fail; b=TXs9C0Tn1kIO4IoWIM65Bi7CEJjx9N8TC87SeszCMC2OvYoDwABWZWLqPyC+HW2xKsmuYIQGDswyeXWugykhniBEZ1tiWUK1Fhtr/LY8jVN7BNDU9JltWIcgeNPw3WLDqZzjfYu6+BeUytbbAiuPM3PeTJX8087D928VACGDcGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955023; c=relaxed/simple;
	bh=QDPbnAFPYyCeeW5AiRx3OrtadE66MtvsOIkT4F6Kjpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oh3FNX6zLThtnaAiD7jQA/9bLY8dPSqgRbGO6ELDOImbYbyVkU4kHAYWERdK6usO4gGLNHnyoHBvN4pf8zEIxwi1E6W5Ggn/zFW4MkjHgAjOWnXBavySicQVhzwQfgjBNIs4QlyHEShOYMcmN0E6Aka4rYylwnQ4IvMjMeueQ9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lIK5eqwv; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzLiOTVvTVzeErDBpjrkACcoMk32RqCtqalyGEd96Xh24sFE0eVfoyni7Nu2WJr1zDVEc1951bAZlHz/IVRZ7LD5g9eWTbM8RK8Hd/id7/nZ5/ilAs8KyGEDHxT2y2eHJCo1sUkFQt+inx7X6a4cZ03ICENPs3hgSDl7jVNXRywTkGnGOidhORapbmsj0bQkbnJTFdJysFLeAR90lxz51/p2cYWuwakFOesMH/XOav1+fQ54Zquee/1xgMk9xd9juaYarFDdlgPtz9ykfXhSNFr6KRYUh8ivPLz5Ba6TcVtdZAYk60cshePog46KS1ostp+cJy9uv1k7gmcm8FjQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mvImlDbbMO//f3v6dnErY3IeBIbj3n/e0kZi/m4ybU=;
 b=PHdOw7ojGiNn8Hc4q9aAbJ3DxtzHUnKpEMM5ghqHN3Nx0e9yP1OlA6pUz/E6fFmW74aBJ3cEt4pPycqZWdogIjTlQlZ5VySfVC+sCeSnR0+KphNAohoH3fVWL8585VvWu5IBDyW1me1oTqFdfrFzXzYMdNUYLitEKXzPxUlJK41T6aNKkB+kEjkJVX7EJskyZx0idqagMYmsW+CYr/gPmEALWRjJc4M5siZlNEaIWGPa/+55TeZjmXSRxKpoSMpq0UDSMElrSUPcq6S74zJbMLp5iBhI6DMs/kK0bvh+WY+lyaFuV4TIES5DnCsudiYVoIzAegioTjb7ha3AF3jB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mvImlDbbMO//f3v6dnErY3IeBIbj3n/e0kZi/m4ybU=;
 b=lIK5eqwvk6nm7rGpS5yCgYX326e/WsugY+em6XwBRPpGPzXsFkFI8kObBkYUJbXm/23VNMJd7Knd3aYyleQId53dLAgj6EGNGuPO7lMkYsUU3sSZpxyl4mTQsFj5hhxxJWyhqc0AkAvBi1Md6O/oJX/izpAA/VWrHo5Na6pqVfEAYO32ZwmptvaE61nDXMXP3A+c4jQwI+p38JmuGNz5bXXI9JSGg50GPiI9DEynNP2rTb6FnQAcFULsTMo4cTYm0n9F2lKpXZ8TfoekK0W+VnhjN0Duz1SiAI92miz/yQpf5T00D3mq9Q3QytZwFQcZUYF8roTIAI89vbjZkz1ZRA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 19:03:36 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 19:03:36 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <linux@armlinux.org.uk>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC net-next v2 2/3] net: dsa: microchip: Add SGMII port
 support to KSZ9477 switch
Thread-Topic: [PATCH RFC net-next v2 2/3] net: dsa: microchip: Add SGMII port
 support to KSZ9477 switch
Thread-Index: AQHbeQoMxPhXkf8Bw0aF8YP1idpJ27M8DzwAgAAkiaA=
Date: Fri, 7 Feb 2025 19:03:36 +0000
Message-ID:
 <DM3PR11MB8736575BD4F4D290EFCDF84AECF12@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
 <20250207024316.25334-3-Tristram.Ha@microchip.com>
 <20250207165222.hrbylkoafpvtfsjy@skbuf>
In-Reply-To: <20250207165222.hrbylkoafpvtfsjy@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: 6f68b6f7-3929-48b2-3839-08dd47aa203f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XwZRMepwpx/pQ4KKmM0vmUOm/zDcPTxa2o+nEtCUnYLoFRgUGfQ+xi/Bmvrf?=
 =?us-ascii?Q?K3gqzZso0nilcVB3z9PnJ+7/vyV1Zf8JY/TGRSHrCJtzrfAIkKupFOOBmdc8?=
 =?us-ascii?Q?BI9yy194cL5NuQhnksJ0D8ozExfB47dXgJn9BL2nSvNoOyDHQpSRP93Wd15A?=
 =?us-ascii?Q?9a2N46MeLh2urToum07F0Z+tMh/g+e4hM2mX+uMV/kuRLA+CfeVU8JAhy6le?=
 =?us-ascii?Q?+EwyX6RAv6IwXYcUCCIan43evgvCwOQHNsCpUl7fgLrBcp13f5t6l1KumA8X?=
 =?us-ascii?Q?hf9YWzZfjZFRHSa9h5579tLnID/NkbQRI9aCv84MS+JEy9swgAtsY/cSjJkk?=
 =?us-ascii?Q?OTQlBtOuEHS+yyVXkXtWcoqvozgVDZBUvtvn6ehAILzpGEp1GQ/Bmb49lOz4?=
 =?us-ascii?Q?PZvsTYCSdN4JVyVXwCFAemNF1J+O6PR67mNg9EQIaL1n6rpe/Bo1XPqyHyHH?=
 =?us-ascii?Q?zjf/cOE+7E1QkCsBzj+CpuxnuGF3Am+aCdfvcbNTYyWEfBVbrgGfvFGSVYVr?=
 =?us-ascii?Q?UqU3egThyYHAc/VXI2/lVenome7Gn9QacToa9vguRB48WMIvLPnbr9MQtumN?=
 =?us-ascii?Q?3qZXaFRR0YeDmffKcrdC7HjSHJGqFKQkOjIQjnOcngM+SC81btoeG1WTY3C1?=
 =?us-ascii?Q?k41KtAQMfVMPE8JG7bBhTnjPr8Q/c0LdlCIaNqFphQndc2uT8xMBR8pQfCAE?=
 =?us-ascii?Q?UzF4eixs+l2MPm09crW239z1j32zyIAQ2NcLDFSsyq2sonLqw2LEv/8NG5cc?=
 =?us-ascii?Q?ATTz/G7e8E+m/F998HCz9zvQ4EzxeSVpsA+NKN+yAN7d3WrByG58A4ILZAVD?=
 =?us-ascii?Q?/p6ID5mQhpoopmiGFpguNN7uBroUtIE9RCIu3zgaaIoio1fih2cVn21T922p?=
 =?us-ascii?Q?Z77mBqQAmfIsNbDtJ799gf2S+n2ppiDLG2vgHQN74ckCTnXY8PHv/bcqPBas?=
 =?us-ascii?Q?ohLPVRjLOhQtZonRzT2WsCDqPgqCE481sydji2OehZcnUSXm9eJAtucfAaIe?=
 =?us-ascii?Q?CXrOG+QT9C9O8xXWSj7QDabDzCsk5QpU3Q6k6XP2CDvMoy6qcwfkn+HaKLth?=
 =?us-ascii?Q?bFWYm7uzJ6FdAwF3qH446nMV/jy11Im+NZeonlj8PXTdtGbBIWqWlZhM+yIe?=
 =?us-ascii?Q?L2FCqsQWQFvduKT1QF0NLLHXBinTbFqUwXM9D0LKwClo8pJea9KhaJqFcSi4?=
 =?us-ascii?Q?6XbCzXwSJ6TVy5hKlCdHPMWZVfe83Z97MwHM+Hx6wjRW2QMSG3ID5zyGxaPO?=
 =?us-ascii?Q?Ptb6TlvnVOn/BblhpUr+royKGvnS7pOjmY9FmCGKRx28cLIs9iR4+XKget2u?=
 =?us-ascii?Q?/RVWTFb/Eza7DAqd4/+bu/SHlHXiRB9tPbRX6zjf50gQHga40dMhyCa/NY8Z?=
 =?us-ascii?Q?t6pkf4g2yVByO18EE2XcuDjP+iVeKSRQYW6K69tZ4q+3gexuYJAMK9DKw0yS?=
 =?us-ascii?Q?N1/zO1WPRyGfeOBf/GVUUxcd9FBnuHgz?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6zCC8kCTy8I7ab/b7wtaaz37iirhRQ2BGPv6bL53Co+VxVH3PyQZitdpOOt4?=
 =?us-ascii?Q?Ukh7hFQ+4YqqrlM23IzDF6C2gcMh1U1CFEoe2Mj5GhVF6rHLFcAHWlsqBcB1?=
 =?us-ascii?Q?bNdOgVOLy3t5FdPfr438BrLBt+78mvrcTbY2lx73qdqGmCiLxkwZgqb5+aXj?=
 =?us-ascii?Q?IE4p7MAGzjnFIbMj+BAE9sKWqHHs2bqaTQ+3LpK//avm6IOqvOLX5j+1+As1?=
 =?us-ascii?Q?MGlXC1dOT88WZ1cOJdYOIh+snfNy/SQzqb13d3TDgclWqH4/RLGz7wI6aLH/?=
 =?us-ascii?Q?AwcbVrs+o32eFwaA7jI7HvOmOPwVe11xubjTqBxJzCdiFiwnvTLcRaQ4myht?=
 =?us-ascii?Q?2tjCDcsgo3Ux4s9t3OvWttaJF33P5TuEA6mUAmcLLcjH7rqE307xvFWwcjvx?=
 =?us-ascii?Q?zlMrg/FBFf5OxJEaGNl+rpR8ZtCxZYoiOyf0I2O4UQcZ0Qh7pt9tkwwO2YRU?=
 =?us-ascii?Q?YWV3bXtQqnxMX2mvas/S6p8UpyY7daT8hIN0Kzhv14nxopK17DkO0IHZAj+8?=
 =?us-ascii?Q?pvPDHjrsECvnxopV+fgy4rV87zsQpZgk2CBsq8Vh6fy+wNQF3W0Fpbd6vcLo?=
 =?us-ascii?Q?NAQyMnRcRX9oSRwtyeEIWKYI1JWQ6Gd9f65A5MRB2GAPNIW8eWehyEaja86U?=
 =?us-ascii?Q?VTrQkSrXcYd/vUMPodZxCULPSM/OpgYNc65B+UM+mfk/RSgX9cP4wWkJTIC/?=
 =?us-ascii?Q?H0uWsmFSCP1FpLqZs4P7Tf8ypqqsB396tutV700UBM+SHj3hoLoGw11e2/ZF?=
 =?us-ascii?Q?sV7hKviFkemso2j9KPTU5IljP7rw7g65xouNC+yEWzgsrXXZd1NbmejYMKrq?=
 =?us-ascii?Q?wkg3ZUBFIrjmlRecEUdh+fOFPu8zrIsp50te3EdoejCUPjZR9T6ZvQdZngfH?=
 =?us-ascii?Q?2OwW3IJROZ4x675j2N9cLWTCv4CMz97+vSKfyPni4moqXeDTSAveDU1OvvAT?=
 =?us-ascii?Q?uVCAyOBcKXZCaoOUGoI6XUF1itGRWYV+86dLLoOe3ovW6NAMwRrIbAvTDTik?=
 =?us-ascii?Q?O1tHn6hrUpfG3uLAO6UtHWT/l5G9N1KdzpNCz+rUcOE8GsVId5hQREnjvgAQ?=
 =?us-ascii?Q?dxOZXjFI6jjnlR+vPTYo8Zy/uFxqPLS+5TMJxEwDBwrqZXE41UMguuqdjDvA?=
 =?us-ascii?Q?sMo4XGQhxwzshGzrDvxhxgL+r/x47gAF973eBfop4F578x83xWnN1YfTaLUz?=
 =?us-ascii?Q?jW9wvPdQr+BCY7GacT2D/Uq9HDLwXji/IRR8VnwwSCq0fMcgrAT0XqYjFYle?=
 =?us-ascii?Q?ZC3xf4Y0BkWHfu50ul17qTyt8gTAYelD/PaeXznFkNY/V2hGbGL891y5Dy9T?=
 =?us-ascii?Q?PmcucvupL0pxzhHnqUD5zX6Ho6YwXeFTs9z+Y8pNtadHl2Zs/u/XBg3ydiL8?=
 =?us-ascii?Q?ebeECOakooCihJH8KLCz/uMD0dkVlvo8caszfpo0td1owpcUzL2GzdU0eAfk?=
 =?us-ascii?Q?XB7zV1N2UiELYvxsbhL5WNjsLAnMEEbt9RT39g3q75cxgu60yJutly0TZbar?=
 =?us-ascii?Q?Ys1Q2lfImmrbHYyUWZjLo3BPya6dSt1lmEErenwjRRg4QEQvTX/rys8uRC+n?=
 =?us-ascii?Q?TfFt31plTkj8+s5VHt44nOkugvVtnwKN5ErE8jHs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f68b6f7-3929-48b2-3839-08dd47aa203f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 19:03:36.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFMUh67yM8EMFDyRYeWXH+ks9pPsTi07zCWZOAFjDndta3z719FeRxyjnTC+p8SfjK8AY1ote/B9/TQt/A84/Ra7ZO7pknTAD0Z0MfqSyM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908

> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Friday, February 7, 2025 8:52 AM
> To: Tristram Ha - C24268 <Tristram.Ha@microchip.com>
> Cc: Russell King <linux@armlinux.org.uk>; Woojung Huh - C21699
> <Woojung.Huh@microchip.com>; Andrew Lunn <andrew@lunn.ch>; Heiner Kallwei=
t
> <hkallweit1@gmail.com>; Maxime Chevallier <maxime.chevallier@bootlin.com>=
;
> David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>=
;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; netdev@vger.kernel.org; li=
nux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH RFC net-next v2 2/3] net: dsa: microchip: Add SGMII p=
ort support
> to KSZ9477 switch
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> On Thu, Feb 06, 2025 at 06:43:15PM -0800, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > The KSZ9477 DSA driver uses XPCS driver to operate its SGMII port.
> >
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> > v2
> >  - update Kconfig to pass compilation test
> >
> >  drivers/net/dsa/microchip/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/dsa/microchip/Kconfig b/drivers/net/dsa/microc=
hip/Kconfig
> > index 12a86585a77f..c71d3fd5dfeb 100644
> > --- a/drivers/net/dsa/microchip/Kconfig
> > +++ b/drivers/net/dsa/microchip/Kconfig
> > @@ -6,6 +6,7 @@ menuconfig NET_DSA_MICROCHIP_KSZ_COMMON
> >       select NET_DSA_TAG_NONE
> >       select NET_IEEE8021Q_HELPERS
> >       select DCB
> > +     select PCS_XPCS
> >       help
> >         This driver adds support for Microchip KSZ8, KSZ9 and
> >         LAN937X series switch chips, being KSZ8863/8873,
> > --
> > 2.34.1
> >
>=20
> I'm not sure if you split this change intentionally or by mistake, but
> either way, you need to squash this patch into 3/3.

Will update that.


