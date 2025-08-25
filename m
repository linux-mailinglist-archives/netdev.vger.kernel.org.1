Return-Path: <netdev+bounces-216474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F87B33FAC
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 14:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288B17B19BC
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3C72639;
	Mon, 25 Aug 2025 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fg/FiAZ6"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30103347DD;
	Mon, 25 Aug 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125489; cv=fail; b=ULJjstd5CMmwgMSnWin2RfT+Sh7EsEz5f8m31O8sCltu1JEV44Peeon4Q/Ia6tT+Z/N7fZoEWgV9PSjyDWYz+trj6oJPZ9U9uhCR4+ksz/8SD4vgiQqAa9e1YQgoketn4d2yuSD6L2NvzlFf9in1AODjtafqMnH6FIK7cOCV0M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125489; c=relaxed/simple;
	bh=+lm0I8L9OB4rAJXTg8zZ4l0xGvBJzLtTUBHnAhsmo8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkT0RsSrVcQw7QT98YDsClgWxeVSVY3dC/kJUG/Oe9oey1Gzj+z4NyGtFxdZCjfWXMDQQ/uHWsT4N+S0HPoYqTGk5u+2Ms39akO7UKGe3WJqDCi7Z6cUn5E9zyIcCaF26JWvryOjUf11fi/3Iag0cPdxfGwkMI9EJEDfnctnpTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fg/FiAZ6; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZabJT6rU0jDhFGbKdv/mYH29+fZlUXlZ++2cA8bp5eZ17zwYJOor/VgyTfs+fegQ49fa2Km7LuLcLAcp1ADgzNe/RsAiZGJlZvUaRepzpG/AHjfggQef7XLYvVCAiJ//eeggnRniCi+294YoEjwoy/e9+oyxvbhy6Jef82TKOpVzlJ0faPHH/8WUBz7ruNAszsiq6SfGEGt838cHlhFDSR4uY5mJKyeNYQoLe4JPThHIqKEF3AcddWCkTV4+Gk2pUlPdGzZJ5/eHxmMvK241Gky0hENsRR4L7R2GwNd4Rd2aJLE8V3JnlwqnOGLB/h7kozj5x6pdsDx3HJejQ31CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzj6Zjqq79oOUUn2UPuqMhfbVKC6XuEPUeHyGU5U4FI=;
 b=hSlP7JGoAdI4FQOazLxijpmkcp3tgFK59Ll5a304XPQbLgLy8+rS4OXqmP1KHABCAx7bqQb47MuxxBuCL8ty3L4jgq97BiT+Rx3ul49I/77ZNy0OG/kzPVCDdOcE3diBxFRmQooHlJKia5TMThEAQW8aiRTwydxtwLI3YDKGWaIaXwsBS77R4ZJy8jx35V/QDbEq5hSQ31ttHEC24B3ky4KEioz6mcb2VOyIB1Fp/vDLHnkOL80I4b+xa2vkDJ2hUvosQtUthczfumnV34Fru68/B+0peR0bBX3Ua6XKowX17V1ivWk5D9RN95+k9s1ls8ee5jnCPBKkwHTg2jurRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzj6Zjqq79oOUUn2UPuqMhfbVKC6XuEPUeHyGU5U4FI=;
 b=Fg/FiAZ6WvmwoVA/EWCmGk0yGg9zxDi4VqlE74MVvNRi3etxIbhvibQamQq8CnnEhoCm0Vlk8xYQUiizNIPZa4eL7GyLB4Z/icaK6OypAQIpvyy5Quw023ZqaesEt+SCJfa6R/vGmoKFjpasgu3Ef/G4tSmfp54fjb6CHJAP/yflYnJcEMVDOTz/imiEegIF3pxdk4uIQQiBmm6qH8gs1iwJiUzJV5gf8h5g9GAu6M7NIxvA6rCNdSCfVBcAt+niziY8HOXMfEkPwUcIVwLiiOF+zhdpyxFwVFfkzli4PYQhDWSjMgXqmEM1dde7PmaBOxejEDRYZxHvIdTNvnnsyg==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB7671.eurprd04.prod.outlook.com (2603:10a6:20b:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Mon, 25 Aug
 2025 12:38:04 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 12:38:04 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoxXGKzYnBdLUK9f8noPKEV4bRudCcAgAA2o3CAA/7TgIAAqmqA
Date: Mon, 25 Aug 2025 12:38:04 +0000
Message-ID:
 <PAXPR04MB9185FC62D5928E5B265F41DC893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB918588241A96C60E7E7E4FE2893DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <PAXPR04MB851035376B94859B359C3A05883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB851035376B94859B359C3A05883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB7671:EE_
x-ms-office365-filtering-correlation-id: 90612c7b-329a-4af2-ed9c-08dde3d43c8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ez7hp5U7iw8RqOKKhkXTfWzV2DoodWawooqgJKoe1G39F61mh9bqmcFukHxS?=
 =?us-ascii?Q?A4ig40EP6JSKM5FqIx34fiMa7QQB92zCHROFzwVJPKHBisYFhFJnZ5LWRPWo?=
 =?us-ascii?Q?eSA3Oj1QVIwTxmHC14AD/G8nrUrWhk8IRD9Sh8hcX+9qQBFH/ZFJmLnNtatu?=
 =?us-ascii?Q?afxTxJK2C2qqQtaVI7GhPxes85sEhayGggly9m9hJk0lRt1tCzgKu6rb4KR0?=
 =?us-ascii?Q?96d3/tF8rdduYExNbvhoTiZ4FMs4F51Ejukg1ns5TZqptE4O/uHfmR12rKh2?=
 =?us-ascii?Q?bm5zgt8JrJtmXiZL/O91d1heLp3QX9tN71ZXjDxhLblsb7VvOnAbwK4x1iPq?=
 =?us-ascii?Q?+bQZLxoyoAiByMJ31rJQE1U4L2nOvkh6kNcxwCnnmzyoRCjT3NAZ2EHkxPvr?=
 =?us-ascii?Q?2FlPOFhSmuwtK87dJH9NvDQUJpKngnLJDhVqp6lHCqvO3RXjAJLVzZ8GXfY2?=
 =?us-ascii?Q?bnIxCp+/HMXv02nwElnyHMAaDLz2rpH69cl3vjIYij4EFd3h5Na7MtDAOAUt?=
 =?us-ascii?Q?ZAPMb1Wh+G0u3CflkiHRkqbVF8XtR+EzzI/YllBVnvw9Ez+ErdyYTErjtjTS?=
 =?us-ascii?Q?OCGmZ5aJggLBqBCi6gf0YAYM6eW3Nju0EEWsCFWqMTCojDN8PEn5UDX8ApJw?=
 =?us-ascii?Q?kV+4Ba3oDaFWWUPHMlebmdey03jkzOnahiyBztaBhclVmvhv7Q4w83tH5O9p?=
 =?us-ascii?Q?zoSRQR4PDx3y19PWPoR3RGLFwF6VXEZHW+668J7EpUJL8zw5M/RkZBjjmLCf?=
 =?us-ascii?Q?bcz/ouM/KFiODYTH6c4Ojc0JsN527l5COFniIYK8qhyehiSLMSV7fjpp+B+m?=
 =?us-ascii?Q?hyjMPEwTCC5oZ6puXZCPwGvj186+rLZYHB/t2rGxfct3fEOXEF952KJp+8xo?=
 =?us-ascii?Q?sAMXC6uJhriwvbqE4o+F8I+qNW/F/BO2YSwRFY0oyTf0bIEPQrpwlrFigmou?=
 =?us-ascii?Q?6BNL81dnn705YOo1yOkUOo8ueuDhoK1Ssfm58jpV/D2k1jzA2xFDTk2IUNld?=
 =?us-ascii?Q?PVOvxjstO26lRx9EuMYP99fnJFTtC6HrylkC4ZF7CP9FTi/UzH1aPMLyxATB?=
 =?us-ascii?Q?JAQ0MxpWQLKAZbDLrH23qfThlqFopGUiexXbukuZqw7SeY87MUvDfb1EksfR?=
 =?us-ascii?Q?30Q+v/HQPVX0lPK3r3yyGTIab17vSN9x4KZ2Xxxu8TZK+EhVJlT7xMiQ3Q1r?=
 =?us-ascii?Q?n00/jjmV4cIeO8QaEmr9zJfoDqgv4oV8ujoYV7RoGcll40GQlYeJCj1WIS6e?=
 =?us-ascii?Q?ConLoRF0PRJ5+NAQXje+w68DNmwq7I1K47YxANxFHkso+5uE1zy11zcSCY7J?=
 =?us-ascii?Q?kM8ylD5LtzTNKsqLVOlFtqVLuOwxkPZE2AmxmP2UoR5fiakvSqExgrMXKlqE?=
 =?us-ascii?Q?XGQ+nzBhDjRTQ0CvsXPLqRxKHqo4YstsJGNQf9JrhNDEavckTC+zrwliJDUh?=
 =?us-ascii?Q?QQGPebCSCht78UPNKYPccLuXx2qF93qkYHZ//y2lI0DXlAfr4+QYJg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ssznTUYD1WsQfc8mSC33x0p3Ev4AjjkOXGFU6Mz2r6PA81RC3n++JtpfDsuz?=
 =?us-ascii?Q?HfFuI1eQUfX2PH3cNig88/sm6Ruy3Qxl59sdiPVOlQIxV8b6WxgQdT0jTo+5?=
 =?us-ascii?Q?ysSfsSIu5dS1viZjnQ+lWz9VTdQoZ2mfEbHauQrZQCR4B/9ZfPF9JM8gQp2z?=
 =?us-ascii?Q?tfgBVts67PRHUg72otKRFUb/n3+SfuMGcbf4RhN2qUPap5ERHX6tNev1iktb?=
 =?us-ascii?Q?rCkr1DgD96RIhxrG/Ngcl9WdnZ72YrYf7G0fmpZq1joGl0GwcZA8pc0hYkF0?=
 =?us-ascii?Q?CiN2pCVBYoxEuu21oAA7a4Co+zatQ0llvY1LiNS9kEBOlbWd1SHJk/mbxWR2?=
 =?us-ascii?Q?ap5NRy74FjqQKK+mapr0h35i0fc9vqSoYZrSql/3yc7QROIXBrYtLuac3vxy?=
 =?us-ascii?Q?RyYzroTWk8KvDTDbiayvwBIaJnZpszaqNeCNJjawVQMvj8k66qewFcP8MofK?=
 =?us-ascii?Q?HHdT0gE5iW4IJALwXE9AK7dTWX0S442svJAzyG1Gp3i4AZNZFvsnG2NazWxv?=
 =?us-ascii?Q?FT1itA8I1b6eIcpJY2sntBJRsTvIZ35X7goo1Yz00XdYYEVbGfspauJoALlZ?=
 =?us-ascii?Q?BSKDIfzj5LXU1gB5Nu33PA1WNlWe399XT/j+KKBxUAfoLtTzFWvDbpwJybct?=
 =?us-ascii?Q?cELIZbtOoY9G6LGwVZmBDyww3DFzJuVpSsbPhfdRwSh6zwZLRB0NOUpC5bQY?=
 =?us-ascii?Q?CK91sbfD7OBgdWb8Dwqc9bSf60Pjs7rSeDXtT8ADirxzZqYFgPrnYsz8wi2m?=
 =?us-ascii?Q?8TLaGNxOIw1NNXd3dFSVawi5Ve+bVGMnP4vuiDy4vQulU4mTdIvbu/IpxgRw?=
 =?us-ascii?Q?asiqJRrmJ2DJO9Vqn8c6W0wfm2Ap0cokcvFhghvT3HZnq0vYp8hj1X8xYSU0?=
 =?us-ascii?Q?TdoFZogoT+B4K/un2lKDhKtsK/e7PWQRyDz0O7uIFplXLRKXXat9Vs2m8JZ5?=
 =?us-ascii?Q?sMMm6XLe7skaXDB4ZYjvYJwRMKW1RVn9yJcvbmKhg2NwESxBYtEUSA/17Ts4?=
 =?us-ascii?Q?Il0WiFHoQKnbI9aDgkRQSfAXhbX/dGp/c/S4U+TJ5tAxm5HbVatvT/KdH3pJ?=
 =?us-ascii?Q?x76dpN1UwNDV1EHBbvxgBPuJb0Cc46mbyQIATsZ7FC6jU6TPyznDnysWCShm?=
 =?us-ascii?Q?CvtEIbhvxSguo65tBex07+XUdsqOT1P32GLgXjhpFbR4WSLfczMp86bMCOnw?=
 =?us-ascii?Q?853GDCB4oISWTLAqOdG/rUBdqYlqFce36Vi99IaEQb7RA4E2hFLYG0FaE+cV?=
 =?us-ascii?Q?CVK7I1F5HY4ufTbaD6qlWQ0wvvIDvOAe4FYq+wrYxQTl5PO7PiXB6CylHsCd?=
 =?us-ascii?Q?HtW2rfeA3ngryvjNuyIKAhZ/tdDZYr2q77gGb4bwyLVG76H2hUtIwNc4zDpx?=
 =?us-ascii?Q?65O0TIwgP9l3OcWpyBDGeiqIlwnu1g3xOn8QLFf3Obn7+/9Bau4bhxi0UZrV?=
 =?us-ascii?Q?IefJOz7GZd3vO77DfBenNK3Wg4WuZOV22vayvDpCCwiv6gGJ78hvpkee3iFj?=
 =?us-ascii?Q?tf71FrY3FlvjEvsep986yiDM+UMDYOq3ZKEKHuBSFtNNCOGBQwsOYCuqKxlx?=
 =?us-ascii?Q?CQVGlAnAglpsYaxSpAk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90612c7b-329a-4af2-ed9c-08dde3d43c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 12:38:04.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWt3Ps4zZA4v5fvVDxzb3OqLYAt1IxnpxM/87LYoMRzQW4Wy1P9UVSZQUgcHd/lDW4byfc15F5viEsvGYxNDHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7671



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Sunday, August 24, 2025 9:26 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to suppor=
t
> configurable RX length
>=20
> > > > @@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
> > > >  	pinctrl_pm_select_sleep_state(&pdev->dev);
> > > >
> > > >  	fep->pagepool_order =3D 0;
> > > > +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> > >
> > > According to the RM, to allow one maximum size frame per buffer,
> > > FEC_R_BUFF_SIZE must be set to FEC_R_CNTRL [MAX_FL] or larger.
> > > FEC_ENET_RX_FRSIZE is greater than PKT_MAXBUF_SIZE, I'm not sure
> > whether it
> > > will cause some unknown issues.
> >
> > MAX_FL defines the maximum allowable frame length, while TRUNC_FL
> > specifies the threshold beyond which frames are truncated. Based on
> > this logic, the documentation appears to be incorrect-TRUNC_FL should
> > never exceed MAX_FL, as doing so would make the truncation mechanism
> > ineffective.
> >
> > This has been confirmed through testing data.
> >
>=20
> One obvious issue I can see is that the Rx error statistic would be doubl=
ed the
> actual number when the FEC receives jumbo frames.
>=20
> For example, the sender sends 1000 jumbo frames (8000 bytes) to the FEC p=
ort,
> without this patch set, the Rx error statistic of FEC should be 1000, how=
ever, after
> applying this patch set (rx_frame_size is 3520, max_buf_size is 1984), I =
can see
> the Rx error statistic is 2000.

I don't think there is a case that rx_frame_size is 3520 while the max_buf_=
size is 1984.
With the patch, the rx_frame_size should always less than the max_buf_size.=
 Otherwise,
the implementation might have a logic bug.

Regards,
Shenwei


