Return-Path: <netdev+bounces-208076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEFEB099A3
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0800816D747
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C3E52F88;
	Fri, 18 Jul 2025 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKsf936w"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE35BA27;
	Fri, 18 Jul 2025 02:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804495; cv=fail; b=aHTc7s7GTKrQmF98kdt37QpQ5W/6NsTGG4Tq7qqieFF0ZJV9sHmQ+1xHJUyYsevvBYBkyXTCoftjvS5bNKrK4X1ACNcr0Xh90ooeKZayyEaRSAGl4YpbrXiw2ZK+ivgNeyz0de0l3mdu+34tEWnv9d8K2Q/bznQb0OcTddwyG9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804495; c=relaxed/simple;
	bh=C1CAxNfUGWTy9lGW4l4NgjPiucoXv1AjgP/QSFhbekI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DIqEa6N9ko+8IlkXRi01+uHzm846mYlbyrsfWX+eUZO6GMIx5tKJxuv9RGc369Vsj9nYz3xlHIMceGG/2pFnD1DK7qkJyM6AvEYisULa3wa1NyeqEIguGrKUGCL0GA2A0nl4wKpNRwYrYz3/K0zdH6HL9QBvidmTFNpgKBbYUoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TKsf936w; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl9tubzBfPoE5ZyH92Qb3n4kl7dofNGrqxjT3vKq/EZwtVeAqWXkPnwXI5O/YLQJ26Z/Q+jbcWgE/hOkIrTkGoQzsOhX/wPlFxCnh1aGFiJGqusREgmUK3wQGnv9CJICbgWVHZQ3b8URHKla6xcMBreZHRtngzM4O5E9vAQyUNHsXvEAyiILQQhXXHtveLX789/K6jfxPuU1WfjN5DJ69BPIu/hS0S4zBGX6u2bkiAMdUO8sD2x4A2gspM+6ZVbWa8SdsbGkvAGcvAAn80faYgr4eYmiMxR//3FO8H6GKc31n3WSXWpzYOikRHg9++Wmu/OCmwSuZVYp59vo8bJzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuOtR5fJmWANoToG8vblORON94tGdPvbo1IPcxWNvGM=;
 b=Fo31qt0wcVdSEahWYten5YTGno9w/55Ebjf0/Lo5wKY630qin4vwd4O4UrUaJzFXp6NtiM2ROEtmYAav81LZWupnGMKBQYJDOK1dAR0d2ro00qFDxSCChYE0fy6drkXpDvtwwaRVk8RuAPlwh1pfUS95zWEhtIeOCvdGX3DOCO27PLX9GRcVEce4fLIMNB+vKHmoplfI66YQhQBGN71arO6mi9/AupD9O+NexX3ZONVza6pu0IgNLD2lvOS8IArW/d0U51YW6qrzM6g9CFNE1WF5lwYxeGbDm1+rwGXN89GQ+uqdTBS79wp5CIxmHhnu+3/rLw/uW0p2hbXpdP+u7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuOtR5fJmWANoToG8vblORON94tGdPvbo1IPcxWNvGM=;
 b=TKsf936wpkYqCazqluCKJoROHnRLxU0BUQnV02Aw29MuTq5k7LKdzMEsVAmKUN1Wcf0T+21j1xsWnsch9i/VvY4yz5j78rtXBugRb1oX7KANBCSb5rR7THs8rloY3qClF/e9e7IPujxHkThs4uNjCUfEBKOwlhP4TEvQJm3MwBk88rRYpTnMpKTK7oVwXZ9JFjNVN01ZHgMfZRy0WhPFcH2T71STby/hC3j0QbdisDZBv/Cw/sWJUUhSe3AAM9kreaKX0q7WzGjGKLOnmglY6opBGtPAt6snB+iAKemoZGHk6Vz4vVc0BKHqSfAIrP1BFzwupltnBA//ym61eucuRA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9742.eurprd04.prod.outlook.com (2603:10a6:102:389::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 02:08:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Fri, 18 Jul 2025
 02:08:10 +0000
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
Subject: RE: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v2 net-next 12/14] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index: AQHb9iaTMw7wWMBukEKvuK11OYCKQ7Q1PTuAgAEA5pCAAKP7AIAAQxZw
Date: Fri, 18 Jul 2025 02:08:09 +0000
Message-ID:
 <PAXPR04MB8510D86B82F03530769569958850A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-13-wei.fang@nxp.com>
 <aHgTG1hIXoN45cQo@lizhi-Precision-Tower-5810>
 <PAXPR04MB85104A1A15F6BD7399E746718851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aHl0KvQwLC9ZCdtM@lizhi-Precision-Tower-5810>
In-Reply-To: <aHl0KvQwLC9ZCdtM@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9742:EE_
x-ms-office365-filtering-correlation-id: 99495dd1-6687-4ac0-7af8-08ddc59ff19e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q4eZMnIcvj9tdu/HhkSx5157E5j8XbHu8oBvatHTcmzylgTLvy831bc8wjBI?=
 =?us-ascii?Q?vP4BIlhSgVCROinZdzap8w/xejHdOCL6hps146HhNevBc/hMnj3Gl2UfF1si?=
 =?us-ascii?Q?rjxDKfT8BI1kok25MlRDMdDjVqjI02+qdZ9+S7OynDxE8ixaAJihYiv/Bj2a?=
 =?us-ascii?Q?p/y9ZZGtqN5Gh0C33vzg69lYc6NMefnXjojUrhT6dJbrqa9E6SR6s2RU4RYc?=
 =?us-ascii?Q?ynjymvN+vn/Qf5n6nVP7A/tMLuQevsbxZS1BiFd9rt8rujxrI/ydY14oEa+P?=
 =?us-ascii?Q?2DNk7eBgZYRUVFXTfrNcM+mGglz4qsr+SBPU/cQi4qMGwjk/9wJxA6yghYR5?=
 =?us-ascii?Q?qEA0FPsOQiVWebtN4mONewnTXBkGHWN+CZtSq+asJVjna6z193T7mrcNUHRq?=
 =?us-ascii?Q?Ybxwjijpb7FBrXflY2zSp/cZRJNGOQ/+ty9IgnFsJAtGpM6MsMusi8urBwS2?=
 =?us-ascii?Q?ZSdUD954FFnC9AUXe269W7Od/bNsRdmTEoX9ajUzyHfqIao1NPr7ac37d8j/?=
 =?us-ascii?Q?dBMD6ReE0Y/MzmCmU09478I5+JQ06Kf4fQ+lzpeznG8hAgTaDi3bt/fky4B3?=
 =?us-ascii?Q?xBIn1ubg0mr8IZBo5aUqMFhYhG/eehcA9MYExTbPl6ySbctQu5JCGRcJmOtW?=
 =?us-ascii?Q?pp84W6UbHLUFEKczWYd0yjw31PKPOjVCVXV8aIp872ItMsJWJY20r3kOk5o2?=
 =?us-ascii?Q?iBXDg+hLLoAHRaJGJ6mG38Ml8fCoLjnbszFmGcM+3IyyYR5+RA3ZMrEgGnCK?=
 =?us-ascii?Q?cnEm1Tg+/ZcTvYyP//6367Xu6GWXkfoOP3VzCFSNf7Ng4ND9u353DglUJUlB?=
 =?us-ascii?Q?IpwjK1YC2/nLoHURzCOO3/RiehDWANOmTRLDnbAzxf+Y+Al1IrQWJcK9L+l/?=
 =?us-ascii?Q?R3D/6kxiSCx1sohR9MY4aANMREp8Wrm38a4GvAsiI2rYzDyp0FdQuOJ0pvDV?=
 =?us-ascii?Q?1XBkwpUr5aSjM75MbBRfaG0m/xaZz4s/QEzis8OCo+RoKRBa8l8nClclwyNz?=
 =?us-ascii?Q?iTuhrhDo4lL+SCuke6Ezvr5E65QjdiDmjdTliTqkIg+SOThKCQ2cORZh/fq/?=
 =?us-ascii?Q?n5KdM5WGgZJT3R61qc6fsmjBNkN6Jb4mYhldvmw1rjs5JecE/yCr93ZyogVe?=
 =?us-ascii?Q?ZNc5xF9crrCPnxxfAJIYusMYXFxLdRpbgN1FeUbLs/XzuUa2nyWXkIDENNxB?=
 =?us-ascii?Q?sG38aLdXBeXlvPhvT4hOj7ibyu9LnR30fwwwL1u0UgSFL2//Ml1/Mto37gBw?=
 =?us-ascii?Q?wsKJ50JR8BnEi7in1pZ77UeN7q+amHWqyVdoP7bfgNP/oDIAOtMt8sXy7dXD?=
 =?us-ascii?Q?fZa9zokiNOevb1zjydkeubm4K0pzpNxDZluHi4daZWpeS0Dt9MDqd0R5fxTV?=
 =?us-ascii?Q?Yg3X3YOHClSWEa0eT3ImHG7JyABWjK13qF9njxe3nUNfpYvUULr5zEADcvjJ?=
 =?us-ascii?Q?V5CfKO/40ofPOZfrC8+BZxT9S+v0ACRLTN1w/XQHe6WI9IIcmONNwYM/Lffy?=
 =?us-ascii?Q?9IWphR4YyX6d7rc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PmCB6Ep1Npsn6nlvdV9bsES6qvPsOX1rERFT76X/zWeh1txilz6/7+MTOB6/?=
 =?us-ascii?Q?dilMKPQ7l+b6A5w0pWFM+MdKKxlLzENGfjG7zASNX/jVgtkqnPo+2cnVJFzv?=
 =?us-ascii?Q?puimzmkg2/AsE4VQLApLFMZ4jt91KCcxeOtpRXCXqSzoepCxhsriICuUaOMr?=
 =?us-ascii?Q?yjEcxneRgnEo/rWBl0oQVRSxR0TtMj1kjZ123Qu5s3sNmaRlj/lqp7nzMdXD?=
 =?us-ascii?Q?6C35qHSyfRzI8wj3bzco+5sTYP847la+5QioLfp6q5eX+LJAIlzYakGCo7kj?=
 =?us-ascii?Q?evpV46Of75MuNVnCiipX6OHE/Iyv7MPVMlkUBLp+/tZSjVWze0Vs+KonuAnV?=
 =?us-ascii?Q?qWFjND8b7crU29vp1L+cj4YtHaZdiZtmgED0uNJstiI8tUxhMqq02py/EDde?=
 =?us-ascii?Q?BG9Iy5Hiv3z4NVBh8sy2uKbEMsOOl1HAc/Ji/uRxY8/JzmW4EFMF1hpg4g5V?=
 =?us-ascii?Q?VTwgHBQdaozzQZo6yeoDxtD2aaf9EpwheBPOmR/YcIuEhdLAf6iM7L8yGZw6?=
 =?us-ascii?Q?rRFgW+0mPztOSxkU0K4ELwMK1SeS8p0PP0Bz2c3friiT90zLaSSn+YHcGlZu?=
 =?us-ascii?Q?Kf49Vt4tFTv0RxkI9dpMU7QS0GVWmEiWUevAyn0WOl4kDqmLFszWO92Tboq/?=
 =?us-ascii?Q?ofpimfXh227alPv7abhXnHprNEH6eQaH16BdGlje6wlXReftcLy2B5IknYAf?=
 =?us-ascii?Q?oP2+BrFHIRrZaPqcggX4UkrMceDw2PKSGgAoTeDWkEFVrew9LRWVCVIZff1X?=
 =?us-ascii?Q?KZn+MPU5tg1aGtCxklSAczAjSB7A0pLNGYbnbH8oYNOhw0Bvc0rKXzmwSffo?=
 =?us-ascii?Q?kztp0wgxdSGjkw5Xa3MfLz576kurJpY1j6qbogVzt3vdvoTARfu3PkKPgJsI?=
 =?us-ascii?Q?TnHvd/RktgeKttZxyCoBNNhny4Adi0mBEFBmpCPTWEPMhhKiq79uL6ixbJpf?=
 =?us-ascii?Q?uwHn6+fKQIVUKEtAh/oB4T9oXSn3tKBRHVbEn3d3a5YsxZMsOQWeduhuWKmu?=
 =?us-ascii?Q?ER5W15jhbqFSuwH686mFmaYj4c6q1StZD3zp0747aBF4wqbbXyFPTg6TfnO8?=
 =?us-ascii?Q?DXHlU5b32PyMnTmd2XFZ8J1Xa6BEjykUffD9R1puNS1fb9NozVTQVcb0wpY6?=
 =?us-ascii?Q?k5gcM1Y6cDnaCdflUNqLatI55Jl5H+laYgaQ7uGvEX6xHrYwHNrj/dX4CJei?=
 =?us-ascii?Q?jH02yCpwTiExe+uBPk0kPFyuyR6rTLqD2mm7Uh9zGL0huj/RRWizS1/NuaVm?=
 =?us-ascii?Q?pq3S2ZgCA+kTW7fiAZQj2sCpnuFvHrevgGSQxpa5txr5cOaCc04IxQOKB3RS?=
 =?us-ascii?Q?7GxwHFX3Mqp8HKYJq63UuQ3LPgyTmkSdIzTg9YlaEM84s2M1Cu3yh53Z3sHV?=
 =?us-ascii?Q?UE5cNa12dqFtvRhPY6YWAApQ8jiOTTjs3sKFumNvGlf79ZAJIxwSaU/a7+kG?=
 =?us-ascii?Q?hwtVf4iZAKbVKZWigu8v/ul+LeXHZE53fGu6DZUjP6ujAE44+Ncqaz39xJfK?=
 =?us-ascii?Q?/jbqJDrrF1GyeYELkbdN73Bou5mhjwA4uhVwJo52Cq39IQyYcBbZ4sQEZ5ga?=
 =?us-ascii?Q?1HxgQTOew5EBj1GrGho=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 99495dd1-6687-4ac0-7af8-08ddc59ff19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 02:08:10.0221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgwxqaBUIUTOWkcJ4gQNoeQbs6QUY8TttbedUUarZh1sAXEOgxfbihmHkzIjcWIY/PZe8v7RgdmcBsuC08MO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9742

> On Thu, Jul 17, 2025 at 12:35:10PM +0000, Wei Fang wrote:
> > > > +static void enetc_set_one_step_ts(struct enetc_si *si, bool udp, i=
nt
> > > > +offset) {
> > > > +	u32 val =3D ENETC_PM0_SINGLE_STEP_EN;
> > > > +
> > > > +	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(offset);
> > > > +	if (udp)
> > > > +		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > > > +
> > > > +	/* the "Correction" field of a packet is updated based on the
> > > > +	 * current time and the timestamp provided
> > > > +	 */
> > > > +	enetc_port_mac_wr(si, ENETC_PM0_SINGLE_STEP, val); }
> > > > +
> > > > +static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, =
int
> > > > +offset) {
> > > > +	u32 val =3D PM_SINGLE_STEP_EN;
> > > > +
> > > > +	val |=3D PM_SINGLE_STEP_OFFSET_SET(offset);
> > > > +	if (udp)
> > > > +		val |=3D PM_SINGLE_STEP_CH;
> > > > +
> > > > +	enetc_port_mac_wr(si, ENETC4_PM_SINGLE_STEP(0), val); }
> > > > +
> > > >  static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > > >  				     struct sk_buff *skb)
> > > >  {
> > > > @@ -234,7 +259,6 @@ static u32 enetc_update_ptp_sync_msg(struct
> > > enetc_ndev_priv *priv,
> > > >  	u32 lo, hi, nsec;
> > > >  	u8 *data;
> > > >  	u64 sec;
> > > > -	u32 val;
> > > >
> > > >  	lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> > > >  	hi =3D enetc_rd_hot(hw, ENETC_SICTR1); @@ -279,12 +303,10 @@
> static
> > > > u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > > >  	*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> > > >
> > > >  	/* Configure single-step register */
> > > > -	val =3D ENETC_PM0_SINGLE_STEP_EN;
> > > > -	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > > > -	if (enetc_cb->udp)
> > > > -		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > > > -
> > > > -	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > > > +	if (is_enetc_rev1(si))
> > > > +		enetc_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > > > +	else
> > > > +		enetc4_set_one_step_ts(si, enetc_cb->udp, corr_off);
> > >
> > > Can you use callback function to avoid change this logic when new ver=
sion
> > > appear in future?
> >
> > According to Jakub's previous suggestion, there is no need to add callb=
acks
> > for such trivial things.
> > https://lore.kernel.org/imx/20250115140042.63b99c4f@kernel.org/
> >
> > If the differences between the two versions result in a lot of differen=
t
> > code, using a callback is more appropriate.
> >
> > >
> > > >
> > > >  	return lo & ENETC_TXBD_TSTAMP;
> > > >  }
> > > > @@ -303,6 +325,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb)
> > > >  	unsigned int f;
> > > >  	dma_addr_t dma;
> > > >  	u8 flags =3D 0;
> > > > +	u32 tstamp;
> > > >
> > > >  	enetc_clear_tx_bd(&temp_bd);
> > > >  	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) { @@ -327,6 +350,13
> @@
> > > > static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_=
buff
> *skb)
> > > >  		}
> > > >  	}
> > > >
> > > > +	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> > > > +		do_onestep_tstamp =3D true;
> > > > +		tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > > > +	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
> > > > +		do_twostep_tstamp =3D true;
> > > > +	}
> > > > +
> > > >  	i =3D tx_ring->next_to_use;
> > > >  	txbd =3D ENETC_TXBD(*tx_ring, i);
> > > >  	prefetchw(txbd);
> > > > @@ -346,11 +376,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb)
> > > >  	count++;
> > > >
> > > >  	do_vlan =3D skb_vlan_tag_present(skb);
> > > > -	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP)
> > > > -		do_onestep_tstamp =3D true;
> > > > -	else if (enetc_cb->flag & ENETC_F_TX_TSTAMP)
> > > > -		do_twostep_tstamp =3D true;
> > > > -
> > >
> > > why need move this block up?
> >
> > Because we need check the flag to determine whether perform PTP
> > one-step, if yes, we need to call enetc_update_ptp_sync_msg() to
> > modify the sync packet before calling dma_map_single(). ENETCv4
> > do not support dma-coherent, I have explained in the commit message.
> >
> > >
> > > >  	tx_swbd->do_twostep_tstamp =3D do_twostep_tstamp;
> > > >  	tx_swbd->qbv_en =3D !!(priv->active_offloads & ENETC_F_QBV);
> > > >  	tx_swbd->check_wb =3D tx_swbd->do_twostep_tstamp ||
> > > tx_swbd->qbv_en;
> > > > @@ -393,8 +418,6 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> > > *tx_ring, struct sk_buff *skb)
> > > >  		}
> > > >
> > > >  		if (do_onestep_tstamp) {
> > > > -			u32 tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> > > > -
> > > >  			/* Configure extension BD */
> > > >  			temp_bd.ext.tstamp =3D cpu_to_le32(tstamp);
> > > >  			e_flags |=3D ENETC_TXBD_E_FLAGS_ONE_STEP_PTP; @@
> -3314,7
> > > +3337,7 @@
> > > > int enetc_hwtstamp_set(struct net_device *ndev,
> > > >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > > >  	int err, new_offloads =3D priv->active_offloads;
> > > >
> > > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > > >  		return -EOPNOTSUPP;
> > > >
> > > >  	switch (config->tx_type) {
> > > > @@ -3364,7 +3387,7 @@ int enetc_hwtstamp_get(struct net_device
> *ndev,
> > > > {
> > > >  	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > > >
> > > > -	if (!IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK))
> > > > +	if (!enetc_ptp_clock_is_enabled(priv->si))
> > > >  		return -EOPNOTSUPP;
> > > >
> > > >  	if (priv->active_offloads & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) diff
> > > > --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > index c65aa7b88122..6bacd851358c 100644
> > > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > > @@ -598,6 +598,14 @@ static inline void
> enetc_cbd_free_data_mem(struct
> > > > enetc_si *si, int size,  void enetc_reset_ptcmsdur(struct enetc_hw
> > > > *hw);  void enetc_set_ptcmsdur(struct enetc_hw *hw, u32
> > > > *queue_max_sdu);
> > > >
> > > > +static inline bool enetc_ptp_clock_is_enabled(struct enetc_si *si)=
 {
> > > > +	if (is_enetc_rev1(si))
> > > > +		return IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK);
> > > > +
> > > > +	return IS_ENABLED(CONFIG_PTP_1588_CLOCK_NETC);
> > > > +}
> > > > +
> > >
> > > why v1 check CONFIG_FSL_ENETC_PTP_CLOCK and other check
> > > CONFIG_PTP_1588_CLOCK_NETC
> >
> > Because they use different PTP drivers, so the configs are different.
>=20
> But name CONFIG_FSL_ENETC_PTP_CLOCK and
> CONFIG_PTP_1588_CLOCK_NETC is quite
> similar, suppose CONFIG_PTP_1588_CLOCK_NETC should be
> CONFIG_PTP_1588_CLOCK_NETC_V4
>=20
Okay, it looks good


