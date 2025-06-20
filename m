Return-Path: <netdev+bounces-199747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FABAE1B39
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772863BC1A1
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF9628AB03;
	Fri, 20 Jun 2025 12:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aoC+odgN"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012023.outbound.protection.outlook.com [52.101.66.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54427FD72;
	Fri, 20 Jun 2025 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423870; cv=fail; b=cX4bfmJIe6jzniX5cOekwpbEmNsOc2+wQjtUMMjorqcYzDEhphV0G8KFzAQwYMR1dLbZZDE5eL95K/bCRmZ8bT3BhTvYdpPsPytMNaCtOwyHf4FbSPWeV6oHjs7VCsTDClIbti0nCBeHFfUuyXrpkedY+TujwSxVkzziJT9smag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423870; c=relaxed/simple;
	bh=Nx2eL4jRdMG6sr0vNYoRwIXeBBCVyLUzpD3wznBG/rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rZpU7d8aHONAOv73/3lUFMtHs+CQ0rfnXSnTDoPf5HPdK+bAaOxFJaRO+/jGli/nSw2O4f+TYTcao9Dd5CwbUDmGuXuG+rhAAvc3QUf6rIN869vqMA6HMxUaolaTPVl87r4lZFLDay4O2qFMypj35jsmXhwpy6NeVpKjAML4pvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aoC+odgN; arc=fail smtp.client-ip=52.101.66.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4E4uz/iZWO2cN46JwpN7QevU6wNOfTYK26zL++RORlZ+47iLua0QaAnMDDKHldFFejW46xoIQ2/AvCwV1qvGkgCjkug0MDHUVGcXOZbuGkhuf2whx4oTa1FxWZNhTPjjzBCqJa62cgwzHs4kBEBpj+LVMv05lTTTNxjVmE2rjK5E565OxBP+D/TCBnteKcdH60r/lflXQndAYqsWEBoCuxwPHIK4/4d51t3W91d7kMJY/2fYogYmNbKrRXSpVXa8bFlrHeyARv63Ymwk3Q5T/7jvi8SvOOsJVNrRLppGWSrdGkLXM9r2VvcxGQswGeDUA8KWlc4rCtbfiySwN9bDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nx2eL4jRdMG6sr0vNYoRwIXeBBCVyLUzpD3wznBG/rU=;
 b=RF/U0O97YoKcQu2U9mG0JVjX6dU5Oozr72uDmCnCJ1WkuI8PKwuKlvxk7NfSAdwCJuXN9H0ToNkbEdvW0hRSQUd/y2KwRb6vRvXOuM/OXSeJUBHV8rN3rjVatW8nxsG980eaSLRBiZox0/2hMoxj+UeZtmFSmwcnVEo2SLkkEXaRgKY4YUL1TC3E8WbJ9a/tuyIu3z5GSgK+f2aILKCLnF2irIw3xjjFTYdYW7D8At4VXtgPzJO1CJUzvVa4beqcmBudHJqFmKlaF1XRp6S8ZaxnA21Toah3l88BdFMcT9gG1CpSmfyt0NVBibLWD56IpzP06s6QAfTsesN1+M1iLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nx2eL4jRdMG6sr0vNYoRwIXeBBCVyLUzpD3wznBG/rU=;
 b=aoC+odgN3Uxnv/Y5k1aYAgp0pPmDiv1GW0INYp63kxqBuf51CRB4XgluyZFsxjWwCU4NIDRh/cFLv6zHGI4eh5CexOnE5RWwH7V+IHXRIpwcM9rJpizYH9v3kavmB5HTdAyW6Uaa+P3+G1uFcQt1TeZWcnMPcRbu+o7EvLau6Yaj+Y9ECXJO6w3RiBX7rUJZ7SZLGWq2pYUfxM23wFQOvG0xvL5CX/X33VrxQB2pM7KJzivsXFMSB3VAAXQ+BQzy/E2EziF4BGquWmC192q1oo/CHeD3ZpwFvYhO7YtfWRHLpg4ZQwpV3O3hZyFrUUcLZkdCCkmeOPcBNru9FOLZsg==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 12:51:05 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778%3]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 12:51:05 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 1/3] net: enetc: change the statistics of ring to
 unsigned long type
Thread-Topic: [PATCH net-next 1/3] net: enetc: change the statistics of ring
 to unsigned long type
Thread-Index: AQHb4czKK9pVsyVUyEednIW737xceLQL/JDw
Date: Fri, 20 Jun 2025 12:51:05 +0000
Message-ID:
 <AM7PR04MB7142F396D0BABE40F6C9D9B6967CA@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-2-wei.fang@nxp.com>
In-Reply-To: <20250620102140.2020008-2-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|PAXPR04MB8783:EE_
x-ms-office365-filtering-correlation-id: cf1d52e3-f16d-45ff-ce06-08ddaff91edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EDvy8H3zQIUxB9nsaOusjjDyikyvGsya+py2wiaK6EZ5UUfAPkUPdrGM0LBu?=
 =?us-ascii?Q?6vsCBPJHD54D2o1/sftYn2CqmPQfS2RKoh7xoo0tg3JzfoCmn4zvJJ9zk9ed?=
 =?us-ascii?Q?axvTPQepxmppNIgm8tsI1GnwJqWt6yUcL4jRWd7soiNYcltpowKIeYjpUvwN?=
 =?us-ascii?Q?SICu9RjDjI8HXcXrJuKz2I7kRDt3aQhscn2kvNvSOUbvItMfJkUhP/XjgS35?=
 =?us-ascii?Q?vlGgMqeOkYsR/3lg8Va9bvygI9FnORCngHAgSH7mX7Tvw6YRJIpIF5YS3s4w?=
 =?us-ascii?Q?NdxLPhfn7DXioARP7YIVZtxLyU9kO7U3zbTpPGA0/RSXLFU2X1FExcr+QL1b?=
 =?us-ascii?Q?fJSRrxfFnOblUvsx373KJMntfQlC4rJ2azBTG2emX6/h21qLOwL6iO5m5j9V?=
 =?us-ascii?Q?Ebr+3KXjD3c57VemrQRkYsMJEaMxFGXo+XwKzNqNP4J9c/0EtM8YXmHFNAlg?=
 =?us-ascii?Q?SSkFHxt6skGUWTCFYbRHUfEFYFGXRRnZmmjjZMGrwC5BogSrsXJoqQqgrLs3?=
 =?us-ascii?Q?GdtVfG1f+VFScCzqCKpszAI6AeB4MPJ+TFT8Asu7r4qm63L61+8l09II5osJ?=
 =?us-ascii?Q?BUQyVHOQo3yUAXWfQnGcBwhQWM5lJW82EpWiKYhOS2HFALEdqV6H2dtQkiRc?=
 =?us-ascii?Q?2QN7KbQy4whQDFZl8pZeXMrEhqvzdzeaMroflI5nA7THEnX3m2rVcp1qb+bT?=
 =?us-ascii?Q?+DTrz51arCGmbf2K/YrqKHM53DxYzWpxtRNEdMqYBFyP62dwqOAMkwqo97AG?=
 =?us-ascii?Q?DvkGSvUMFpbbAJZF2RNgtdWBHndYKJ/SdTjSf9iIyX+T4p5A1ojZN/VwpIIA?=
 =?us-ascii?Q?USoY8e2gzSVIxMSj9Xab80wA9Abk99vmlJqBkZvXGque/Ubo4aU0i0DxTaly?=
 =?us-ascii?Q?IILByEKO4894y6ilC9DaO2TjsBlXrrWSH7M7dwx4igUzhK8mR+W6qFme9MX8?=
 =?us-ascii?Q?y3klzOsenWCqyiSVJbFT96v5H4ZhdvRkADyVZ+ZeWK7m6uwlucJ7nqsZOOOK?=
 =?us-ascii?Q?aJhJpLd5sc+aCtPDl53GzG1qiLwI9ArvdexjwDqCF7yyDr596Oki5L69C/+2?=
 =?us-ascii?Q?ZkSnQl2h1VwsqSxx/KmuuYcC9Mzmnd7gABRKHxtjZNMGj76JfxY4YtWUeeaa?=
 =?us-ascii?Q?A7Euz1jxFC6zMHAkG+T/PvcJAiTtSRz9VzlZhkwSUdpa63iCan5jmj/gSTj7?=
 =?us-ascii?Q?xjr2ad1Y+LIfrJwDL7UwSxSOQ9dloKNTZhmFu83V70O4dg5UL7zgXsC60wNB?=
 =?us-ascii?Q?h/GReTbvWmAcCYaaPyazf+e3uae0cT4oCD0TB1tjbFPt6S7K6dnTTMpJGWzK?=
 =?us-ascii?Q?DPBxFNdWQh03IP7O2dqM/OD6R/Zptqoh6YfmdrBrCDhVEM1LlqsqBykFYdJx?=
 =?us-ascii?Q?CGBKmmdF9785M5ILGwQvigsJmrTh0DcHgmwodMp8UzwWfqZzhk7fMcKJBq2h?=
 =?us-ascii?Q?P4h88HvaonPsHmMgYZZAYlvjw2wf05BC2W+gxcmyecd6UQLVfCJktT+YeqNo?=
 =?us-ascii?Q?oRXzN9rQ80Snxyo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rGs8Y5E7MB7C5WxXv7cT9+/LZt/zQ8BFCCtISxqWJG4uzFJiUJdBqYRDLL+v?=
 =?us-ascii?Q?8XSqbrIWyF116mxK0EfhOBDdmAMDVwAaNpjl7DyEPno+DWHfqzi1hxOTSn0B?=
 =?us-ascii?Q?shts3e2VwSayCDg5fZJe5/XoMFqtH11JXxrwUJuNJUT6WKT+4uRW8FuZ6wcU?=
 =?us-ascii?Q?niRFO4nKucK1fETPDa+5qtlUQW1XUuNqkSfP/OUZbVhYsYQQ2ZYXL8M2vqyQ?=
 =?us-ascii?Q?Iactl8yMK1n/2p5tI0yIh74NkbzltMk9THA1/2EneR/u/AjO/za2zTpaCWHc?=
 =?us-ascii?Q?Ha30oX4M3NBrp7hrPie0Xfqto2XLdnbOeeUwkFqf1k0LloJhBUpncR6Bm5+g?=
 =?us-ascii?Q?Gege0fAF0qF/0U/Xgq8kbc1D9zj/hFQvYENppjupzsmYtqBKJ8A57149T1J4?=
 =?us-ascii?Q?faVvaJRf7MzuloqJiksj8jxusjOMR2kS2asxegL56igb6bitOlYRaoLc6MuO?=
 =?us-ascii?Q?5wKxWQf2i+wMqz2usSauSs2wWB3BV6KuwiDUnVEmfEoVC8agKVAlcPRnWOXj?=
 =?us-ascii?Q?QAeHQ3s5gtjMfSYSZ10YkQYAxLTTlJjFmApyIJX68G6VwpsehN2muVpTdyBr?=
 =?us-ascii?Q?SgSlrM7ocduG1DZ8k1bWiHyiKD1L3ZoCq1SufBJU2IiGZ2nqTsaCxPaGbpN4?=
 =?us-ascii?Q?KmrdxWBDZwfyLTC6ZakQlDTdEm0GaegN72mT71N53grsupgSvJO7o7vVqISd?=
 =?us-ascii?Q?IkM9/5vn0zXjSKG9xqu+J6sQt5bMzA/lNSkynL+nfyM4p0yv3iNTRu+Are4t?=
 =?us-ascii?Q?NQp7Paj7B36OxD4xPJsfKF8dtHPYRpL82M8IzjtOLk1+GmgEcjZ27UKOT7Ls?=
 =?us-ascii?Q?TvsEFbAdDYtZSBPTmaq65bE4lXW4DnfUv9eT6TH9uCcXvJ7CIEjXHGarN6FG?=
 =?us-ascii?Q?JiLskIbcmbv1e8CDVnJtCsLLpON6dyyyOgoK3erzZGVZnp/zuKW+lsSVSomV?=
 =?us-ascii?Q?Du+YFR+7BEiiNPm2V+8nVpqJ25cdBYJiwPp4CgQKDNeqAfw9/E/L8ukZ7ew7?=
 =?us-ascii?Q?HD5JWHC5DuIedtFAn1YdpgA+IKjkmjKpPKc+L4vnuInWHBklVKoRDraPed2f?=
 =?us-ascii?Q?tAyhyigjMEktPSb+P1EUYwCeTafYDpWNBLO/abbNscYm7GVml9+NUBR04eRK?=
 =?us-ascii?Q?A4QjDRwc/M7LNbWbaq7gHkT8eSd3F1MERIohsUYDG9rPwW9twxJWV12X7gV9?=
 =?us-ascii?Q?0+P5/LU4GKZyBHRp7eZNj5RkuXBkji3p1jIR2qhPAZuR9l3FgvwdSpdDjBAo?=
 =?us-ascii?Q?5pe/AqTUu85NRPUP7lskKb1/YY2RTFjw2Pt6D16Pw0DljnTTRWJMojLSRd07?=
 =?us-ascii?Q?YQG/lstQHUrEeheF4VYEkc6+SZ85oqVfmkWiaoUPLNX04Ctd64FvTNZUBjtI?=
 =?us-ascii?Q?pR1gku9JQsjnbjhrGsJ8bxc7Neg3t/wnoWDKUNMJzEWeYLSg1Wxm09A4oWIm?=
 =?us-ascii?Q?z5wrGw8ESuGebloEpc0h/wQQSgPThjGEX6rSniKOdPSCEoTBMLiS+ebIQNlW?=
 =?us-ascii?Q?uHuJNgBIociQPtElDcJ7IW0Vl+7NPMHEi9eVq9VwIIJJ+96oNNFK2xq/wyV2?=
 =?us-ascii?Q?3YW+QcOOlsI4o8KNHltohLYroMPJFwafoqs5i+OL?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1d52e3-f16d-45ff-ce06-08ddaff91edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 12:51:05.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oAoXENCVk51rEQXSCDA5709WItiIJLW0Al7zCjsayxYZtFH0qd6/dX21gsELFHwyR09NhM2rJhwmr9WnYyq6oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, June 20, 2025 1:22 PM
[...]
> Subject: [PATCH net-next 1/3] net: enetc: change the statistics of ring t=
o
> unsigned long type
>=20
> The statistics of the ring are all unsigned int type, so the statistics
> will overflow quickly under heavy traffic. In addition, the statistics
> of struct net_device_stats are obtained from struct enetc_ring_stats,
> but the statistics of net_device_stats are all unsigned long type.
> Considering these two factors, the statistics of enetc_ring_stats are
> all changed to unsigned long type.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

