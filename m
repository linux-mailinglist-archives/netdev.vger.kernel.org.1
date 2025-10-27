Return-Path: <netdev+bounces-233103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8053C0C4B4
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD14E4B69
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DF2E7F03;
	Mon, 27 Oct 2025 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iFmn4Lik"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013003.outbound.protection.outlook.com [40.107.162.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D42E6CD4;
	Mon, 27 Oct 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553622; cv=fail; b=GZoc+/G/lEwN5qF1HKbDsFu7tj7eVfTAao4JxlLPxvof3qLNsLuxTAlUOS4KHmGRv+uoQ/dTcmJCybZRgWsrE0A2jkY/3zLFkSk4Sl0Vg/ceSf05P3ScdFt/bxXORhYloAhYdZPBwjXnd1Ve8Nop8xJ8FSVDuDFJe1L+mHUWf3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553622; c=relaxed/simple;
	bh=cLbtnLL9v8a1mnEbZ+/1NupB+BOTb7elAMWn7UUSPbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhx04f5iEYmZU9PmkXLSR4X/ME2mPZSVGOJUFIEJwPjYtfugLILwzrnVH+egiyyLCPLdMEta9rt8ZmBu42iTB5FlpiO7IRb+UwzvuKqpL1ni/FJU6cTQRa0ikIlh0vq6fYMtmaKeHFZn2crq8XW5GJ5+xf8lttMYYQrgdgP8uaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iFmn4Lik; arc=fail smtp.client-ip=40.107.162.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DyD9FxeCuxR59GePEBW+L/7aCaSiG8lubcs6eNmlW6+WRwJjH3nsGBRPXdsXahe8g/fu6a6egBOXDeI9Wdhd9/NlamqMO60RBppoy2MO+zzaGt5p802O39RiZAPGe+JNI/uZ7lon/PQxNfgKgYzxs0/XiBHFttclmV4EMEAXZ1Wx8ijPd+JSRZuEgZZxjHKWtJrxq89XHn/5O/ZOyLY5mOFuzXdhoi7gPUsrn5u2tH5nlkyq9/c8+QOVkgEBJDTIKAgzZztfR9YaJsVeTZ+6DC8Tf/f9G4bgqJcBth3SKsBiqpaXB1ee/xrbQTL6cjPyQgIUezvyUK6cJf/FoVdL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLbtnLL9v8a1mnEbZ+/1NupB+BOTb7elAMWn7UUSPbg=;
 b=isYulcDVJMwA+JnRx2QALcdcVA/be70xT2i0mh3LRZExPl2Ds5i4LwANzy0GVGjY78p/Z0/lBEiEsyfccM9q5nGa9Wwn4Kpzo8+nJySFRpUF5JMD2G80jic932B+qj8PUY4IlGcM879dWlRs1E9Uxlh/PlS0BzqgIXCmHCyIOeVhEbmHLhPmTQoKcKrqXMv+S2UTQ0Tm0ORolemIHXgXDRd96278cPevXa0c57jue8x0EFNnJmXOokfrvW1M/gby+DxxKSwRmCtLGYNuH3s2liJ0VK1DiWDrrnuQvKz4bKW5xnrJssGI2XA2Qhyn0BZHRwRkudmViyLgl8/hrZ7Qiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLbtnLL9v8a1mnEbZ+/1NupB+BOTb7elAMWn7UUSPbg=;
 b=iFmn4LikpAcAWZDv2JclwpQh5xMgfehRrk7fzoIVKyZDdi2c3MelNmfNLIK9LGYWO9VJnq9H+b4wVpT/cBdDdkgDLf9Cnf3K5srAvajI3l+Narh3XTZ8747ZbcTQu8YqJjD3geSV60PLHySItdgWJJixs4GbRX3KjQExi5rJsx/duNfxcXfJ8c12/zTVWzJw2eyIXk0wU6KwwuA+WjkIF6HGf4MR+TG6buQ/sT7LyG0tTQ1GU/vlERyNgbBOajlxFEOhwWB28rP4/NMSaL4rPMzGdOuUOBvA9nDDEkee0m2Dgmj3Cfp/wtE6idLsSspY4MNiWtiOZLXWcfc2Au4Ohw==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:26:56 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:26:55 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 5/6] net: enetc: add basic support for the
 ENETC with pseudo MAC for i.MX94
Thread-Topic: [PATCH v3 net-next 5/6] net: enetc: add basic support for the
 ENETC with pseudo MAC for i.MX94
Thread-Index: AQHcRuaDYWINwDLAukOlcUFMrdP/NLTVqLKA
Date: Mon, 27 Oct 2025 08:26:55 +0000
Message-ID:
 <AM7PR04MB71421B44BFAD7BA1C96A60EB96FCA@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
 <20251027014503.176237-6-wei.fang@nxp.com>
In-Reply-To: <20251027014503.176237-6-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|DB8PR04MB6907:EE_
x-ms-office365-filtering-correlation-id: 78b7db89-0818-437c-6f5f-08de153296f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NRn0zz7oJSMWsL0cZRhhWK/mGfc4ppm3W2nEHCSq+2dArt3SCeqs14uYUu/N?=
 =?us-ascii?Q?mA++/L/YIUdgutZVTcYXAY8inQjJqDFYlP3MraEcdKa1ZPXkOCWL9NDeTxXC?=
 =?us-ascii?Q?aVOlsD5PBn/LiexAL0uW2INHsRdXHPaCFl8H3WCToVWSsGBUHP1bVomDxxNC?=
 =?us-ascii?Q?yIhPH0iO+s8BNOU91dav9tK5WtsQ/dyxrKwFSD2v29uodL1lSn2g/7ZvOj2U?=
 =?us-ascii?Q?aiqeMfWzNoHp/NrKH6w/CbdYVmmiWw79hmtczNHeRfBq85apL9CxEoHNlbHp?=
 =?us-ascii?Q?9oWB03FcfzLe4wdH8I1G7bsKpzzmLwaAFzPbujU3A3jmtaWx/hbS1Pbk15I3?=
 =?us-ascii?Q?Hla3h2mC7DJvE4M3nNELOo1TIpo+CyK/cwGJjJv3ll4F2AMWyN9c/SzyI1cB?=
 =?us-ascii?Q?sczLmZt9CpmkfFloLIfBOw8Qb6R3DDer+oxPdBwcx4zTl3W7pgrZ5LO+3sHW?=
 =?us-ascii?Q?WShTuusRfcSH6szOjfibJo5fnObpWGzt1d2cKuS+X5aDIp1s3gkwjjBvSalX?=
 =?us-ascii?Q?zICIUhkuTcZd53UrEoO5mcxd/4WXdXzZygzLMBMfhku2pR+u0vg54IIjx7qT?=
 =?us-ascii?Q?U9ggYVj7l7k1GY/0YsHSY1CLvD9XqwlOBJZiAtATGpzNXzkUH1EGDjFlkFw6?=
 =?us-ascii?Q?LYtcvdMyeQ0n6F/hUNgK00QElW8pBxEzhtha+E8n+IqAktlj0u+bB81ppgyo?=
 =?us-ascii?Q?2vNDmJZb9v06kXlf3Z4KKzWrZPvgbz5bLu2r3iB4P0b6fkb3Os8Ka3z12Plu?=
 =?us-ascii?Q?iOl9WlvIsFdyifiaQe/aemiKCuwtiEEn3k44VAmiVrjk5GtGunsO7h+3ZXsH?=
 =?us-ascii?Q?6PQu2hwgYGIEEMPSiOtYvJlv91LDpjt4fp9bIZyA9pJFM7y7rnXeEP5XFWaE?=
 =?us-ascii?Q?RZYAHsW6SUfiFgHVG8t4C8jPyzCRqBHzIQVOHo/2cmwUN38XcWvRk9/OZfFr?=
 =?us-ascii?Q?hwpvhFWnVStZH/LwNrK/bqUxnplLBdVlnyVanPm8GotJ8bJ8H+4Q3j5WbBEP?=
 =?us-ascii?Q?8LfQ2yJnm1NPCVSA1xNni+2rz9OYlgqJEqntUYTTzg3yZJsIiiO2hNGWG9NB?=
 =?us-ascii?Q?CZRSqwCpqVx/jBnoz69Q//SxziadMnR3MpIBV9JrXehE07cTpQYNxKPLPdIN?=
 =?us-ascii?Q?aUp/jBCBdM3zsa8lwi6AMzMajD8MTPgKzwdAsR5X13eGTdLwA+c0peeyrnFm?=
 =?us-ascii?Q?bbac82Y0tKzn5yL3kteLBV3rx91c36Qqdgz0BPZYI+ehzaBo/hLQAB8Zq3mw?=
 =?us-ascii?Q?vGQsIeOujOu9rPbbqjzgzCJHRUU1lJXlnb68SO/oYRMbRjJL3dJd6K9U1vy9?=
 =?us-ascii?Q?QTTlq2cNxPNpqdZ4Y1Hg2Ubxf3RgRrLYuExW4Zx3ZbgzXcOnCSUzryVJyKeL?=
 =?us-ascii?Q?lJoQK4zu+FOiDubpsSzgvmHqAw8JE3hbdayq2AnemBJ7ue+VjyJJ6fH0swRQ?=
 =?us-ascii?Q?ceeaifdG0FjEqkttJ2ePOJf0SNSN+V4tw2sqNja33Et1cCaD5kjPa3cHRMzg?=
 =?us-ascii?Q?SWY9zgKjp42xQCoIFf3VaFLvFcudf2oZ/Hyf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bWWbVJf+rvBLpydpKcjHqbnwXvz00U7onp1H7FZSr/0ONKRbVcKiHuTuPv+D?=
 =?us-ascii?Q?1IF/ytzVkvOQn8897xSqZ7pQER/OnkHnIslAZuZ5L1zR/QilWsBtdXTI/miY?=
 =?us-ascii?Q?rRbSBT2rL/0innd5vucggisxEfRZEo4m1/hZGd0c5QamdMIv4oFyMnNMm1Wv?=
 =?us-ascii?Q?EVsUAI2o4SfNsVhBeN7KvieyOI0Peo8CCq2zHibbe7zRXGFABpHXYREI6BNd?=
 =?us-ascii?Q?ngFXB27Cj0XEtg3E5CYDLFpMufOSnGa4PQqT/fj8gPs443bgTeTtisyVUK4q?=
 =?us-ascii?Q?83wPQTfA8ZulUXJVXJi/TUg8LFS2cUuu5Kv2byg/3MmZdB+uPUDCLyT0Vr5n?=
 =?us-ascii?Q?3x7ic+3dVsVY+ryTHzz9/S28v+yU6IUMZJ9pOo+4TQo3KkfPlR2+pZAPv7Gl?=
 =?us-ascii?Q?MN8ICHallBUBfLoxyKEHe/l7Y8NtCael0l5YtrOpAWAlaMx8LM7DK06Dlyl4?=
 =?us-ascii?Q?z60lQJMUqHxs5zwnZWdVZdwPrmKbM4HEO6j5dodBwaT2mFjsMUK5SKIev/ME?=
 =?us-ascii?Q?hO5XaFLG/FAQlu3u8WaM70FtnIGkMrbJ/FdmndoPIapSlx8NP12OtpaYk7Zm?=
 =?us-ascii?Q?N2v85MphdZnZFbos+au7qDod/Uvr/u66G0ffB9YueB+S7onN2opGEmng0qlH?=
 =?us-ascii?Q?d1Tqh4jn+EWMIhHkg7fP+W0ufuUdO+cNlMmqa1PkqVGnfYLc34RLu7ygnbJN?=
 =?us-ascii?Q?tiKscQU3kIbRq/SWghkcmpPaoHS0YYFy1XkIntxUyS30fo5eoTpAJ1NIyfan?=
 =?us-ascii?Q?UFyUqByqcD3P+OEXP/jJyy5jv6+Y0xhKtv7WR4Dzh+4rm+uyuazpOXZHl7BF?=
 =?us-ascii?Q?2m1WK9TE73JY4Qmgh5bQxorNuH+0RA3UmJl3Jm13scHlqjH6+6TrcsAaFR5d?=
 =?us-ascii?Q?WCHSoJIuvjLw7F4fzvSmVQ+mrZ6NEcI23zvHKSYNLwrrJ1P5ZyPXOiys6jIb?=
 =?us-ascii?Q?/PT3Wj5g+8oDWzNWqUJ8chr5pOUeakdGtgoytqxuWOI/IVUTaswVcgAa8Jgt?=
 =?us-ascii?Q?QwrIpvL7lWD61o0CwNHInPwfSa+xMmd+9amwbeyags+BX63O5klX0NQnaYDi?=
 =?us-ascii?Q?GfRakhXB5o/S5NqyTq94i035s5+k/dd8yJckC/7owesgPLlu6DVeNhR/IwjY?=
 =?us-ascii?Q?tubCWCWqlEMYGm/R1MMAAEplrBj6HHsOm8QzMEXDHc84WvJX1DU/8uey9MSo?=
 =?us-ascii?Q?vLIZ2QQrMDS7Df8sF4+EJozTBLVWbJMZZyIFCo9P/TRchhLoU7ZL2XGRhSIM?=
 =?us-ascii?Q?W2Qoueu8t29nUWk3R1AtKYz7/4S/RRH4RCWb+YqY2cUcMOsT7+GU40aKFRLC?=
 =?us-ascii?Q?eHQnpf+hcqaFEpUWt7/lXdnMSvP14CsrC24mSAdYJnFK++cJTJ20074erCO+?=
 =?us-ascii?Q?ass48hKnN6b1sOCWPD//gsM+tUT1UyprVJ9k27RWoOdMJc3XK2PKmrd5zU3S?=
 =?us-ascii?Q?hQV7BI7DnTOsGIUlQjqjnicvNNVkOuOpD8boDfegyMVoBtilDHHFMH+LgFWH?=
 =?us-ascii?Q?17glwDO4w0J5oVJtc92jKXmiaIQxijCGnR4lS9IQD5QqV2vBn2kEkamR+pU5?=
 =?us-ascii?Q?4uPtPmNopMh6EDui0iNEiv0AIK1QQix0kiaoJH/8?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7142.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b7db89-0818-437c-6f5f-08de153296f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 08:26:55.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CVxSiLuhQi8e9l8kM423udIheYJLxFBk91NoVgX6Xnh3XV80SbOWsLbwMSKjwNSLAHjuF7AEJChpngemX+JveQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, October 27, 2025 3:45 AM
[...]
> Subject: [PATCH v3 net-next 5/6] net: enetc: add basic support for the EN=
ETC
> with pseudo MAC for i.MX94
>=20
> The ENETC with pseudo MAC is an internal port which connects to the CPU
> port of the switch. The switch CPU/host ENETC is fully integrated with
> the switch and does not require a back-to-back MAC, instead a light
> weight "pseudo MAC" provides the delineation between switch and ENETC.
> This translates to lower power (less logic and memory) and lower delay
> (as there is no serialization delay across this link).
>=20
> Different from the standalone ENETC which is used as the external port,
> the internal ENETC has a different PCIe device ID, and it does not have
> Ethernet MAC port registers, instead, it has a small number of pseudo
> MAC port registers, so some features are not supported by pseudo MAC,
> such as loopback, half duplex, one-step timestamping and so on.
>=20
> Therefore, the configuration of this internal ENETC is also somewhat
> different from that of the standalone ENETC. So add the basic support
> for ENETC with pseudo MAC. More supports will be added in the future.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

