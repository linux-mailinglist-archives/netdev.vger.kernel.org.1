Return-Path: <netdev+bounces-213147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51341B23DD4
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A0F6815A9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78737D07D;
	Wed, 13 Aug 2025 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5SShn8D"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E9F29A1;
	Wed, 13 Aug 2025 01:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049575; cv=fail; b=GPn+CfIp863/agGg63h+j931rpZQrxn3U7Np//cW9qx1EsxXLYuXkvD5MdhKq53vOH3Y1P/beQHAwaHYtpw3lVFoYuauVlwRX7QS5LQwasYgzvcjPtAxNYNAhKlYrpPmqM8eVayKRgAGrsrsz5V0Q4oNdoeXK83NGQdA/YSv1cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049575; c=relaxed/simple;
	bh=iA477AbTuJq1AedmAUYNUGhow8q/IbsU8vsQ7FWCrcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5E2OR5F2I5CRra+j58yEwgzH6OttW3+ty63lECNSfNeBzHF0Djw9ADzH8TPqOmC2BRfV/51Qy+hgDI3mn45pV683Uq0EsZK2lkAvy3CetQ1+UYCiu8LsxQk/QqYxzH+HPzN4Y+5jZtS7n6Tw6yQg5aYWC4vRZiS5ROwIZm5G6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5SShn8D; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=npkfxIknkaB2/nA9B/0ah6vG2actjM/WIyUxjx19KZhRcadhpZbgkycNfRRMOYdOQiVYC0zbaEklczUdZMqg/IO55XApGsWXMPF64QvqiKIFU3dlQI5jNDC0JN1fbVVIfBPDdAxWgJSn/jgLfaDuvDhIwPrs/i2WxOBDBbczm3jv81yoZLJX2FN7JQWhoYwFvi2uTvukqQaedLgrPCEVkGZX8laket1fxygGqxGDVr61m57GVLGfwZ0OsWk0r2/yMiQ/Fg36FdhQ+/A8n+6Y2Uj3nRuqJW3BUwrNBicx1Sgut/VRrI4F/RlN/olhHgjAgWNCTLgbehLJs08S80onQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc/xLeobpUyr4REZlKCSM9fW5f8b3665sueyln7+8A8=;
 b=A/ugj3/cGIscJHQBwKhgiUrjyU7psA1Wz7QsUMka4YfR5JEcGS6XDROE1HZOw33o8b9fdutr7dqVXi5h3j6YfH0bYGrO59jGciq5Ea60hCEhOTl8GG/FNmhbWpY4Rt2RfTqDi/0UEHBSgJFQhaUoDYqEfyHuKjJ+uQwpybo0R8nIxw1XF9adji1xGsdcwwMz2NZ9zHwulpvrX+TJ7sPKdw8fKMGglu1o2QivQ/PCqLd2/NJ5SciRpXAmMr0q3WSErCPBT/xjVme7jdu62wSiOOhefcWq24gNE8AXFJigGhAfMbJVMzzTxDH+SsN0YceTmYpliMCbKlPItJGIzDP9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qc/xLeobpUyr4REZlKCSM9fW5f8b3665sueyln7+8A8=;
 b=E5SShn8DH1hB+dEsBBZ3fveWS7s/RHfHChgruUeIo/NLETkmSN8/2v4Ir1V47xb1SzDw0q4V8u2nRbIR/5odQjXyutG/T9Jg+1pm6ayW/9WccQdnEJGjJOqZ9/tOgClb/1Bfh0mLD9al0fkD1VMfNrQhVo6SeuIUJnTR5T2Jm6+q6nIi4A83EhWlYYJyA5FwmC5BpPwxsqAk+iTd9ix7ugpj6eFLEGjj6j6LwJVPUTUFwO0pIX4D1AV8BmGQT1q6EBgnYTsghJP1RuL5P7siJSBzrJHrqcK+N1jE75uMJyWqn3/gJSPev/UOdUacI62poEzEpwtYGJhMj6ed6guMTg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 01:46:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 01:46:10 +0000
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
Subject: RE: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver
 support
Thread-Topic: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Thread-Index: AQHcC3Do+INtWX5a2U2G7TLOdSVPWbRfHP4AgACzvvA=
Date: Wed, 13 Aug 2025 01:46:10 +0000
Message-ID:
 <PAXPR04MB8510D9B82C03EF2A4379A14B882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-5-wei.fang@nxp.com>
 <aJtXNrndlngzeSm8@lizhi-Precision-Tower-5810>
In-Reply-To: <aJtXNrndlngzeSm8@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8621:EE_
x-ms-office365-filtering-correlation-id: 0b20dee1-c05c-467e-d6e9-08ddda0b2dc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C7Q7bMWaKkPNxROQtJnWBFIMYKh0Lm3yMvNgaNNfWcggRQiPyJp24LXyWUcP?=
 =?us-ascii?Q?Mjlw4tQdi/YvuFoNviiqTB5KmSxAtbBzOE7aOUXL51EseirI8X9+WVM/mOzU?=
 =?us-ascii?Q?pkxOEDVBNA8lM9zyDe5kV7Z6rwEtKEMDMxcV3RMMDiiOW/PSC5u1IJ6F7UIP?=
 =?us-ascii?Q?zFdTYV2O8RIm8v8b5QEo4CBBM6a0HQmYUkSw0x0H9Cptwwq3bF+Tf6kGk8Ml?=
 =?us-ascii?Q?i0OqTD63+vYLVkdnlJQRt3aa+vF+W0EL+YqmcVdf1iNL0TYzHfWghG2Qs3uf?=
 =?us-ascii?Q?xnFhTCil7VfiVmC/jjKOSm0nDsBJ6QGlG61+9auC6olGAfAn9iuzmn7CeyUf?=
 =?us-ascii?Q?fu1zl/76HCviqZ2UoUOxHFyv+I06Bzz3vcjI5+0Vz0WNh53VdzFejkIiyfU/?=
 =?us-ascii?Q?BYY6wIIX8kfgRO2UsMrTjtnnnHhaX6Hs+S4M56AE36HNMCcSeHE/rzF3s963?=
 =?us-ascii?Q?XUk8WPzsZe212yy08U5pZy3i3ksXy8LCcBrBg+LpWgaBVwaovIexSr3eGYsl?=
 =?us-ascii?Q?23wcKc4PLhT2mCprfjPdhJZYd5xoMfAIiYkcg9CH1goU2FF/xR1jh1zZZ3F4?=
 =?us-ascii?Q?RZDRVfWbqJMWuVeQnJ/JRQIlwYBRzAzL/XqYAzdYe9VnX84zDDtIPk4rhKZh?=
 =?us-ascii?Q?TExc3ptMA145785M6nR/EQe24MJQWUS5oyaV4OUDTxonsK0ghKAx0/0ViC6w?=
 =?us-ascii?Q?wGEejUR8iNwoDiHoBkbxMK9CgxjLDwwAekoUEC8/UKen3NzbnO8Ui5wwTuOe?=
 =?us-ascii?Q?IYgncjz+LUpe684Z9S7AhxNFXjZM9jBp3f4sfR/+9mzntl+mvDh+heYXzRXH?=
 =?us-ascii?Q?da7CIsZI9zHmMxi/SNvdCXmpXgQkyhBmhgYJxRWsVPeevmlVZh+5ctZK6SIq?=
 =?us-ascii?Q?vmSgHrStjx8m1T7zk+rhOHC41fpfwMxFo8dSU5rdu1xg/XU1mSsBXL8xpdEz?=
 =?us-ascii?Q?TnxbCdx+uHGGv9s5PZzu+UDBI0owd4reNg1JFYEyGI3lB7Nddu26hI5jnLCv?=
 =?us-ascii?Q?cdYwP4FF+JP9RyD3HixZ4dyHseYQsZXEDU4mYHcm5ZUCzqjasrZHtHO98MGM?=
 =?us-ascii?Q?71bUBbGCF0n/CtEF2YaprbjllF5Ia5xC7wH6mSvR18DMzFEmiyr9IrGOedxM?=
 =?us-ascii?Q?cEggobzLo54MS0y1OFUsqkDYUhQNrINiLeUquVuEot+6xSJARoz4pTMWgOLw?=
 =?us-ascii?Q?J9FadjSRMmDfSJWYAcUPQCo5hbaBhprHKrtqdaj1hY2dWTL7ihGh1TbDUjxd?=
 =?us-ascii?Q?1spMe+aLlVzCm9tM12GmhKsxtWy+VvAuFL5aqSG7RSmgGkdLB4JtwiqFJ3zF?=
 =?us-ascii?Q?dVC8MBKMS1bXRT7d2SXMpzd5+a6romy69QyzEBwEm03cz4dPEiyJEsgnz1Mq?=
 =?us-ascii?Q?gSSVXLN7apHzuE/27WlnyVOASuffuLNGQpGG37Uycfufsb9LHP99EuQxs+CT?=
 =?us-ascii?Q?Gqmu3YLRrfGJb5PahBjbvKM0iXo4w8uKpoge+Kkc6cIeuxDuuxrjkQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iQBXmup8RDDIIMB/cjic7rAb7nzSbsqXqBMFwjWd254jHfaPxOWPZiKNquIE?=
 =?us-ascii?Q?RxgBwbzVUNcr4O4Rsu8QATf3JlARP0gNzf2SxI3sdmTnPSE8x3bHLOBS/8ss?=
 =?us-ascii?Q?6X0vluWbbys+/ZaYtu4pchrbeR+mIbZzQgdPZd8vTmEkngM1pWiEppQ3kGkQ?=
 =?us-ascii?Q?AiJVOtIeXhvyH6SJmnhBBh9bLKZe92OA42fceXPaDNnSp4VDQCNMz3PAV0bo?=
 =?us-ascii?Q?iKgiQyGKQWxs6OnccNSa5Qjij7KdIDM7RVGu74ofK2iYDPIu7r2eKqinNTd6?=
 =?us-ascii?Q?3xRgkBSppq+/Knsr4WuRPPmFZAKnR6MrH57OIWeQi844oPEiPSxny17d3mb1?=
 =?us-ascii?Q?QsbwkxHK7WMLK+sdGpOAUvs7r3DHk7uI6/UGCnYfXfyjXYam8H7a+Xkc3kjA?=
 =?us-ascii?Q?G3Iq8Zz6Ctk5i1QXF4OEqZtFhdgrEGx3NWkBIXCyuUgb82Bd2UN6Ts+yGFIr?=
 =?us-ascii?Q?odLUid2JXIlgcke2tm/HZdmzm+02i49lo77/3QoNZKJdKnnyzkYsyB0bxSnF?=
 =?us-ascii?Q?OHU5mBEZVLxUF+ctvgg6/4a54qoY7lVp4sk/o8dgLFlnghH+UWYsFgCayo6T?=
 =?us-ascii?Q?uIFUxOLV9gKgif1vvGUCGNWrcTisPVJ+ShVkqSFt0mMotUhqumZ5TwCSBtAB?=
 =?us-ascii?Q?WJxqHmWlrsmYntPy19Z5EerNsqftS4sR0grA6KPfETbu+qKy/dqpykiR/dUC?=
 =?us-ascii?Q?gkz3Kl/LJAdMdzDurZH6yHjWHW+IqgeTY8p4So/kdOFQci5U9qIGbGDSFx99?=
 =?us-ascii?Q?ajWErfZZxjNn56vTdgDsLPC4QS5PAVDvWXmpue9dubRmT94wQ2py+zN6TA6z?=
 =?us-ascii?Q?pc4COA3F7zvOU23ccaabkZUpz/eBX9rkODCDZqecnXx6+oL2RXW4S2H5nZvc?=
 =?us-ascii?Q?tMwcMVP/bK510bFEHirQ0sBNvHzAMwnDIjxzg77/El5TvbyffEVEGU8MtZRj?=
 =?us-ascii?Q?Yq6g8poNmw9K3anzSVf89riZQYalx2FzCZEpPTXH2zOykNctq6ncJ8z7Mt7u?=
 =?us-ascii?Q?pvlKyhT23gXVqyo/GDLOmi8/gY0YT+5NR/cYHDmQfs3dOjDysq6Q1+HqOK2n?=
 =?us-ascii?Q?IxYeOas5t+udhvRL8bL+qIfQqhY1lU937i0m80XyxmWEwMl3BftVTKc7LCCz?=
 =?us-ascii?Q?QNaIGTTnDoGR1HmXUywegwwYC/scLpBPDn5uUMQ7fGBZb8QeRA00TeWDDjfP?=
 =?us-ascii?Q?LW1TiNXY0VfqrpoX6XHiOkXuAFIvZdIXKKUC8apCydDYuq4Xf0Cw8P3kXqfW?=
 =?us-ascii?Q?bzoASBpqdSyhKZIW7KpBPdQqU+6r4T1FXqJQd69TBkascYgG5+6qPSffNtRW?=
 =?us-ascii?Q?jmJaMvQ241wXzvhxTmH1w0kLCV2EngfobYVHBJDrBskmsmznMF7GK7cLZXaI?=
 =?us-ascii?Q?Y//0FhwVoRe6EM4Tjpn6W60f4f1VkXhOQRjaL1nEcbbSudjdycVNThHtXs2V?=
 =?us-ascii?Q?pR3kNSUyETIqd6DDzAFvR71Qc4qSkAo4GGadW0jE4Biu19rq1CWl0okNYklV?=
 =?us-ascii?Q?gJdbSeLcrZkQwwDvBuusrM0/IHl3pJdjprs+zy0A3oSIZF5/mIiEg5al+l8p?=
 =?us-ascii?Q?EaMX+hS2b7OwtBAVYng=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20dee1-c05c-467e-d6e9-08ddda0b2dc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 01:46:10.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teVndc6y4we5MdvO8/1iBkO9YlFv3zVRRGjC/EWVEjpeY900ehRkKjN2J/dqGz95W5H8Nh1M4YyRmhy5LerD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621

> On Tue, Aug 12, 2025 at 05:46:23PM +0800, Wei Fang wrote:
> > NETC V4 Timer provides current time with nanosecond resolution,
> > precise periodic pulse, pulse on timeout (alarm), and time capture on
> > external pulse support. And it supports time synchronization as
> > required for IEEE 1588 and IEEE 802.1AS-2020.
> >
> > Inside NETC, ENETC can capture the timestamp of the sent/received
> > packet through the PHC provided by the Timer and record it on the
> > Tx/Rx BD. And through the relevant PHC interfaces provided by the
> > driver, the enetc V4 driver can support PTP time synchronization.
> >
> > In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it
> > is not exactly the same. The current ptp-qoriq driver is not
> > compatible with NETC V4 Timer, most of the code cannot be reused, see b=
elow
> reasons.
> >
> > 1. The architecture of ptp-qoriq driver makes the register offset
> > fixed, however, the offsets of all the high registers and low
> > registers of V4 are swapped, and V4 also adds some new registers. so
> > extending ptp-qoriq to make it compatible with V4 Timer is tantamount
> > to completely rewriting ptp-qoriq driver.
> >
> > 2. The usage of some functions is somewhat different from QorIQ timer,
> > such as the setting of TCLK_PERIOD and TMR_ADD, the logic of
> > configuring PPS, etc., so making the driver compatible with V4 Timer
> > will undoubtedly increase the complexity of the code and reduce readabi=
lity.
> >
> > 3. QorIQ is an expired brand. It is difficult for us to verify whether
> > it works stably on the QorIQ platforms if we refactor the driver, and
> > this will make maintenance difficult, so refactoring the driver
> > obviously does not bring any benefits.
> >
> > Therefore, add this new driver for NETC V4 Timer. Note that the
> > missing features like PEROUT, PPS and EXTTS will be added in subsequent
> patches.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Rename netc_timer_get_source_clk() to
> >    netc_timer_get_reference_clk_source() and refactor it 2. Remove the
> > scaled_ppm check in netc_timer_adjfine() 3. Add a comment in
> > netc_timer_cur_time_read() 4. Add linux/bitfield.h to fix the build
> > errors
> > v3 changes:
> > 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read() 2.
> > Remove the check of dma_set_mask_and_coherent() 3. Use devm_kzalloc()
> > and pci_ioremap_bar() 4. Move alarm related logic including irq
> > handler to the next patch 5. Improve the commit message 6. Refactor
> > netc_timer_get_reference_clk_source() and remove
> >    clk_prepare_enable()
> > 7. Use FIELD_PREP() helper
> > 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
> >    help text.
> > 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
> >    confirmed TMR_OFF is a signed register.
> > ---
> >  drivers/ptp/Kconfig             |  11 +
> >  drivers/ptp/Makefile            |   1 +
> >  drivers/ptp/ptp_netc.c          | 438
> ++++++++++++++++++++++++++++++++
> >  include/linux/fsl/netc_global.h |  12 +-
> >  4 files changed, 461 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/ptp/ptp_netc.c
> >
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > 204278eb215e..0ac31a20096c 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -252,4 +252,15 @@ config PTP_S390
> >  	  driver provides the raw clock value without the delta to
> >  	  userspace. That way userspace programs like chrony could steer
> >  	  the kernel clock.
> > +
> > +config PTP_NETC_V4_TIMER
> > +	bool "NXP NETC V4 Timer PTP Driver"
> > +	depends on PTP_1588_CLOCK=3Dy
> > +	depends on PCI_MSI
> > +	help
> > +	  This driver adds support for using the NXP NETC V4 Timer as a PTP
> > +	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
> > +	  synchronization. It also supports periodic output signal (e.g. PPS)
> > +	  and external trigger timestamping.
> > +
> >  endmenu
> > diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile index
> > 25f846fe48c9..8985d723d29c 100644
> > --- a/drivers/ptp/Makefile
> > +++ b/drivers/ptp/Makefile
> > @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+=3D ptp_ocp.o
> >  obj-$(CONFIG_PTP_DFL_TOD)		+=3D ptp_dfl_tod.o
> >  obj-$(CONFIG_PTP_S390)			+=3D ptp_s390.o
> > +obj-$(CONFIG_PTP_NETC_V4_TIMER)		+=3D ptp_netc.o
> > diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c new file
> > mode 100644 index 000000000000..cbe2a64d1ced
> > --- /dev/null
> > +++ b/drivers/ptp/ptp_netc.c
> > @@ -0,0 +1,438 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/*
> > + * NXP NETC V4 Timer driver
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/fsl/netc_global.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/ptp_clock_kernel.h>
> > +
> > +#define NETC_TMR_PCI_VENDOR		0x1131
> > +#define NETC_TMR_PCI_DEVID		0xee02
>=20
> Nit: Like this only use once constant, needn't macro, espcial DEVID.

So you mean directly use PCI_DEVICE(0x1131,0xee02)?

>=20
> > +
> > +#define NETC_TMR_CTRL			0x0080
> > +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> > +#define  TMR_CTRL_TE			BIT(2)
> > +#define  TMR_COMP_MODE			BIT(15)
> > +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> > +
> > +#define NETC_TMR_CNT_L			0x0098
> > +#define NETC_TMR_CNT_H			0x009c
> > +#define NETC_TMR_ADD			0x00a0
> > +#define NETC_TMR_PRSC			0x00a8
> > +#define NETC_TMR_OFF_L			0x00b0
> > +#define NETC_TMR_OFF_H			0x00b4
> > +
> > +#define NETC_TMR_FIPER_CTRL		0x00dc
> > +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> > +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> > +
> > +#define NETC_TMR_CUR_TIME_L		0x00f0
> > +#define NETC_TMR_CUR_TIME_H		0x00f4
> > +
> > +#define NETC_TMR_REGS_BAR		0
> > +
> > +#define NETC_TMR_FIPER_NUM		3
> > +#define NETC_TMR_DEFAULT_PRSC		2
> > +
> > +/* 1588 timer reference clock source select */
> > +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from
> CCM */
> > +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> > +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> > +
> > +#define NETC_TMR_SYSCLK_333M		333333333U
> > +
> > +struct netc_timer {
> > +	void __iomem *base;
> > +	struct pci_dev *pdev;
> > +	spinlock_t lock; /* Prevent concurrent access to registers */
> > +
> > +	struct ptp_clock *clock;
> > +	struct ptp_clock_info caps;
> > +	int phc_index;
> > +	u32 clk_select;
> > +	u32 clk_freq;
> > +	u32 oclk_prsc;
> > +	/* High 32-bit is integer part, low 32-bit is fractional part */
> > +	u64 period;
> > +};
> > +
> > +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> > +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> > +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct
> netc_timer, caps)
> > +
> > +static const char *const timer_clk_src[] =3D {
> > +	"ccm_timer",
> > +	"ext_1588"
> > +};
> > +
> > +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns) {
> > +	u32 tmr_cnt_h =3D upper_32_bits(ns);
> > +	u32 tmr_cnt_l =3D lower_32_bits(ns);
> > +
> > +	/* Writes to the TMR_CNT_L register copies the written value
> > +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> > +	 * register copies the values written into the shadow TMR_CNT_H
> > +	 * register. Contents of the shadow registers are copied into
> > +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> > +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> > +	 * register first.
> > +	 */
>=20
> Is all other register the same? like OFF_L, OFF_H?
>=20
> And read have similar behavor?
>=20
> > +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> > +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h); }
> > +
> > +static u64 netc_timer_offset_read(struct netc_timer *priv) {
> > +	u32 tmr_off_l, tmr_off_h;
> > +	u64 offset;
> > +
> > +	tmr_off_l =3D netc_timer_rd(priv, NETC_TMR_OFF_L);
> > +	tmr_off_h =3D netc_timer_rd(priv, NETC_TMR_OFF_H);
> > +	offset =3D (((u64)tmr_off_h) << 32) | tmr_off_l;
> > +
> > +	return offset;
> > +}
> > +
> > +static void netc_timer_offset_write(struct netc_timer *priv, u64
> > +offset) {
> > +	u32 tmr_off_h =3D upper_32_bits(offset);
> > +	u32 tmr_off_l =3D lower_32_bits(offset);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> > +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h); }
> > +
> > +static u64 netc_timer_cur_time_read(struct netc_timer *priv) {
> > +	u32 time_h, time_l;
> > +	u64 ns;
> > +
> > +	/* The user should read NETC_TMR_CUR_TIME_L first to
> > +	 * get correct current time.
> > +	 */
> > +	time_l =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> > +	time_h =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> > +	ns =3D (u64)time_h << 32 | time_l;
> > +
> > +	return ns;
> > +}
> > +
> > +static void netc_timer_adjust_period(struct netc_timer *priv, u64
> > +period) {
> > +	u32 fractional_period =3D lower_32_bits(period);
> > +	u32 integral_period =3D upper_32_bits(period);
> > +	u32 tmr_ctrl, old_tmr_ctrl;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	old_tmr_ctrl =3D netc_timer_rd(priv, NETC_TMR_CTRL);
> > +	tmr_ctrl =3D u32_replace_bits(old_tmr_ctrl, integral_period,
> > +				    TMR_CTRL_TCLK_PERIOD);
> > +	if (tmr_ctrl !=3D old_tmr_ctrl)
> > +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags); }
> > +
> > +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long
> > +scaled_ppm) {
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	u64 new_period;
> > +
> > +	new_period =3D adjust_by_scaled_ppm(priv->period, scaled_ppm);
> > +	netc_timer_adjust_period(priv, new_period);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	unsigned long flags;
> > +	s64 tmr_off;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> > +	 * counter keeps increasing during reading and writing
> > +	 * TMR_CNT, which will cause latency.
> > +	 */
> > +	tmr_off =3D netc_timer_offset_read(priv);
> > +	tmr_off +=3D delta;
> > +	netc_timer_offset_write(priv, tmr_off);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> > +				 struct timespec64 *ts,
> > +				 struct ptp_system_timestamp *sts) {
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	unsigned long flags;
> > +	u64 ns;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	ptp_read_system_prets(sts);
> > +	ns =3D netc_timer_cur_time_read(priv);
> > +	ptp_read_system_postts(sts);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	*ts =3D ns_to_timespec64(ns);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> > +				const struct timespec64 *ts)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	u64 ns =3D timespec64_to_ns(ts);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	netc_timer_offset_write(priv, 0);
> > +	netc_timer_cnt_write(priv, ns);
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev) {
> > +	struct netc_timer *priv;
> > +
> > +	if (!timer_pdev)
> > +		return -ENODEV;
> > +
> > +	priv =3D pci_get_drvdata(timer_pdev);
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	return priv->phc_index;
> > +}
> > +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> > +
> > +static const struct ptp_clock_info netc_timer_ptp_caps =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.name		=3D "NETC Timer PTP clock",
> > +	.max_adj	=3D 500000000,
> > +	.n_pins		=3D 0,
> > +	.adjfine	=3D netc_timer_adjfine,
> > +	.adjtime	=3D netc_timer_adjtime,
> > +	.gettimex64	=3D netc_timer_gettimex64,
> > +	.settime64	=3D netc_timer_settime64,
> > +};
> > +
> > +static void netc_timer_init(struct netc_timer *priv) {
> > +	u32 fractional_period =3D lower_32_bits(priv->period);
> > +	u32 integral_period =3D upper_32_bits(priv->period);
> > +	u32 tmr_ctrl, fiper_ctrl;
> > +	struct timespec64 now;
> > +	u64 ns;
> > +	int i;
> > +
> > +	/* Software must enable timer first and the clock selected must be
> > +	 * active, otherwise, the registers which are in the timer clock
> > +	 * domain are not accessible.
> > +	 */
> > +	tmr_ctrl =3D FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> > +		   TMR_CTRL_TE;
> > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> > +
> > +	/* Disable FIPER by default */
> > +	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > +	for (i =3D 0; i < NETC_TMR_FIPER_NUM; i++) {
> > +		fiper_ctrl |=3D FIPER_CTRL_DIS(i);
> > +		fiper_ctrl &=3D ~FIPER_CTRL_PG(i);
> > +	}
> > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +
> > +	ktime_get_real_ts64(&now);
> > +	ns =3D timespec64_to_ns(&now);
> > +	netc_timer_cnt_write(priv, ns);
> > +
> > +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> > +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> > +	 */
> > +	tmr_ctrl |=3D FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
> > +		    TMR_COMP_MODE;
> > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period); }
> > +
> > +static int netc_timer_pci_probe(struct pci_dev *pdev) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err;
> > +
> > +	pcie_flr(pdev);
> > +	err =3D pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "Failed to enable device\n");
> > +
> > +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	err =3D pci_request_mem_regions(pdev, KBUILD_MODNAME);
> > +	if (err) {
> > +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> > +			ERR_PTR(err));
> > +		goto disable_dev;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		err =3D -ENOMEM;
> > +		goto release_mem_regions;
> > +	}
>=20
> move devm_kzalloc() before pci_enable_device_mem() to reduce a goto
>=20
> > +
> > +	priv->pdev =3D pdev;
> > +	priv->base =3D pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
> > +	if (!priv->base) {
> > +		err =3D -ENOMEM;
> > +		goto release_mem_regions;
> > +	}
> > +
> > +	pci_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +
> > +release_mem_regions:
> > +	pci_release_mem_regions(pdev);
> > +disable_dev:
> > +	pci_disable_device(pdev);
> > +
> > +	return err;
> > +}
> > +
> > +static void netc_timer_pci_remove(struct pci_dev *pdev) {
> > +	struct netc_timer *priv =3D pci_get_drvdata(pdev);
> > +
> > +	iounmap(priv->base);
> > +	pci_release_mem_regions(pdev);
> > +	pci_disable_device(pdev);
> > +}
> > +
> > +static int netc_timer_get_reference_clk_source(struct netc_timer
> > +*priv) {
> > +	struct device *dev =3D &priv->pdev->dev;
> > +	struct clk *clk;
> > +	int i;
> > +
> > +	/* Select NETC system clock as the reference clock by default */
> > +	priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +	priv->clk_freq =3D NETC_TMR_SYSCLK_333M;
> > +
> > +	/* Update the clock source of the reference clock if the clock
> > +	 * is specified in DT node.
> > +	 */
> > +	for (i =3D 0; i < ARRAY_SIZE(timer_clk_src); i++) {
> > +		clk =3D devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
> > +		if (IS_ERR(clk))
> > +			return PTR_ERR(clk);
> > +
> > +		if (clk) {
> > +			priv->clk_freq =3D clk_get_rate(clk);
> > +			priv->clk_select =3D i ? NETC_TMR_EXT_OSC :
> > +					       NETC_TMR_CCM_TIMER1;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* The period is a 64-bit number, the high 32-bit is the integer
> > +	 * part of the period, the low 32-bit is the fractional part of
> > +	 * the period. In order to get the desired 32-bit fixed-point
> > +	 * format, multiply the numerator of the fraction by 2^32.
> > +	 */
> > +	priv->period =3D div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_parse_dt(struct netc_timer *priv) {
> > +	return netc_timer_get_reference_clk_source(priv);
> > +}
> > +
> > +static int netc_timer_probe(struct pci_dev *pdev,
> > +			    const struct pci_device_id *id) {
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err;
> > +
> > +	err =3D netc_timer_pci_probe(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	priv =3D pci_get_drvdata(pdev);
> > +	err =3D netc_timer_parse_dt(priv);
> > +	if (err) {
> > +		if (err !=3D -EPROBE_DEFER)
> > +			dev_err(dev, "Failed to parse DT node\n");
> > +		goto timer_pci_remove;
> > +	}
>=20
> move netc_timer_parse_dt() before netc_timer_pci_probe()
>=20
> you can use return dev_err_probe(), which already handle -EPROBE_DEFER
> case.
>=20
>=20
> > +
> > +	priv->caps =3D netc_timer_ptp_caps;
> > +	priv->oclk_prsc =3D NETC_TMR_DEFAULT_PRSC;
> > +	spin_lock_init(&priv->lock);
> > +
> > +	netc_timer_init(priv);
> > +	priv->clock =3D ptp_clock_register(&priv->caps, dev);
> > +	if (IS_ERR(priv->clock)) {
> > +		err =3D PTR_ERR(priv->clock);
> > +		goto timer_pci_remove;
> > +	}
> > +
> > +	priv->phc_index =3D ptp_clock_index(priv->clock);
> > +
> > +	return 0;
> > +
> > +timer_pci_remove:
> > +	netc_timer_pci_remove(pdev);
> > +
> > +	return err;
> > +}
> > +
> > +static void netc_timer_remove(struct pci_dev *pdev) {
>=20
> use devm_add_action_or_reset() can simpify your error handle.
>=20
> Frank
> > +	struct netc_timer *priv =3D pci_get_drvdata(pdev);
> > +
> > +	ptp_clock_unregister(priv->clock);
> > +	netc_timer_pci_remove(pdev);
> > +}
> > +
> > +static const struct pci_device_id netc_timer_id_table[] =3D {
> > +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> > +
> > +static struct pci_driver netc_timer_driver =3D {
> > +	.name =3D KBUILD_MODNAME,
> > +	.id_table =3D netc_timer_id_table,
> > +	.probe =3D netc_timer_probe,
> > +	.remove =3D netc_timer_remove,
> > +};
> > +module_pci_driver(netc_timer_driver);
> > +
> > +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> MODULE_LICENSE("Dual
> > +BSD/GPL");
> > diff --git a/include/linux/fsl/netc_global.h
> > b/include/linux/fsl/netc_global.h index fdecca8c90f0..17c19c8d3f93
> > 100644
> > --- a/include/linux/fsl/netc_global.h
> > +++ b/include/linux/fsl/netc_global.h
> > @@ -1,10 +1,11 @@
> >  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > -/* Copyright 2024 NXP
> > +/* Copyright 2024-2025 NXP
> >   */
> >  #ifndef __NETC_GLOBAL_H
> >  #define __NETC_GLOBAL_H
> >
> >  #include <linux/io.h>
> > +#include <linux/pci.h>
> >
> >  static inline u32 netc_read(void __iomem *reg)  { @@ -16,4 +17,13 @@
> > static inline void netc_write(void __iomem *reg, u32 val)
> >  	iowrite32(val, reg);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev); #else
> > +static inline int netc_timer_get_phc_index(struct pci_dev
> > +*timer_pdev) {
> > +	return -ENODEV;
> > +}
> > +#endif
> > +
> >  #endif
> > --
> > 2.34.1
> >

