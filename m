Return-Path: <netdev+bounces-189129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE52AB089D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 05:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E811BA2B1E
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 03:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452A1D7985;
	Fri,  9 May 2025 03:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZFdsS7Wk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC6B64A8F;
	Fri,  9 May 2025 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746760546; cv=fail; b=jnW3IWJAljxfQ3QSjusqPCroGcHOpb8qC1mJa5EKqa/mihoDvebJQx0bfoK2KxoNyH5OL0BTr0OmlepflKSzC9lR3hQPORjJOe7ISc5JHKOciKJmDPawEG1iPVqpA9Am6XaJ3yAMlJ+sgxIIoDqpmdcw5JLXzoZsStK2AJg+Bew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746760546; c=relaxed/simple;
	bh=FGaqPtvKOY2zDDyX5hX3cViFFIguDRwJdvFm0yv9Z3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/n+L1Db3RNememWtHNuLcZg/hac/V2K+yNmef2VqwtdRU+iiOXGhI5gLzjdApe+vDTthk1H/bR0srG54siLgECh6Y3zH8hE1sNlKaFDWKji9LXYzQ4yrZDA0IcHieVrzPhqzvqBqw3G3vLv71iT/G95VjtHYrzTmN11Hy4v0zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZFdsS7Wk; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkU0TsYsJI1bah9g9UC57aKeCV2JRK46OzUF4MDKoTuIn8mq/OZWhLoetXvKATiyDZLF0/0iF0xtEsUFmxcK8hbuRAiJY946xNVxRLWenoqnL/rEKZBBKeeZEPvq14AYvqd5/EEGcMBkSm6SO9rpcjS+2Wf5Afi0uMqMBiwx0MsLnHjYlbS/QM0MsQqR2v/3+vXMa1WVpHvBPY/ukvG4FrkEhWzZrVm5s49Bb1MirJswBzD6IK6P+SfGkFPGNNLo+VCq6bpJdXXJFOCutf8ISJui2PpopqkctzHpqMPDjPgOkwApjotNmqOmMk3Q12pa8zwiiJYygLjajyer+q7vUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6lfgGwHkSBD5m0PzDqMO2jL65duEztLC2hruVxx7qY=;
 b=cXR54Yy054dgzKWSFPL78LCGJ9X94G4TlCrvA8H/ot+rgdT3sThJEsIutbhj2xh7C0DXBFn5d7aIj5zlGaAzzXbUg/OiNZHL8AYJhjv5MnKDiAW05rhI6ZEAsNeAVZDZKsVtmPFWB+tBisKnsiIf54/McpB+MbKCeBhRFT1GT93rKZHxYIGvg0SVSuChylfotndjayo3ntwymnulZwKnw+e49WfZ/kCuQUOz/OgzCxKK0G4cEofscWxIq1c0khmZGTL0rOiPu/E9iqPRRuyj/AljEuxZI/wqa/Wo4QnIC+VtWnExd4eqQNJr2IFKc7s7NFyqv47Jbs4M9Lidw0XoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6lfgGwHkSBD5m0PzDqMO2jL65duEztLC2hruVxx7qY=;
 b=ZFdsS7Wk0Ahx1qkwMOqQFGfy6X4Ave4hKpJqLgcU3fd7r3ypdi3QgzzymgIOaj5OANrBEYe8A72Y0QKeY82J0Ix4Uh92H9iIYbT4kdF3e9f5vVrKmCCbQf4n6Ybs7FSKJ2h+QPQoS2SLcfqiWWqyWBDM0SrpSxBboOkHrLXZzLCiRH/V9KDTajVr1zXBZo707VJdVOPcMtJJpk5oZ8M+3UyINJhYjY4iM7ixqIeVFWzPT5gE80WL5bt8aoD1V6JjMa/BtNSzWNk+dCxW4RU4D0FnWNHYecizwRFp808XyWUxHpamBf9gzklOHjI/5RPP7+ByEmYzcJ2C5i8FFg4V9w==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 03:15:40 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%3]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 03:15:40 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: =?iso-8859-1?Q?K=F6ry_Maincent?= <kory.maincent@bootlin.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Thread-Topic: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Thread-Index: AQHbwA5l/ikZGExa/kS/iUo0LhdZv7PJnKig
Date: Fri, 9 May 2025 03:15:40 +0000
Message-ID:
 <AM9PR04MB85052DADEB4DABF9C7F83BED888AA@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|PA4PR04MB7999:EE_
x-ms-office365-filtering-correlation-id: c91e38f3-7b44-4b99-05d6-08dd8ea7c700
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QIaTSuHALh7VEiB9sK0i5fy6xHTHZ4Sa6Bh8/HTlqrqShKyqRhR2CrHsjG?=
 =?iso-8859-1?Q?/SMR9/tATUL05jDa6CzXO7AWUqtbAbI2S3Y26WGVLpqye5KR6iU1VKPKfL?=
 =?iso-8859-1?Q?TP1ZRr5Olv5xhobNX/z93FbYtYNNvNuO1HMulvcLljWNuYWYcWaDvYi4M8?=
 =?iso-8859-1?Q?VND+kDkvauy9eYaULKITn99/M1ASt25QD2cOMDWthXBsrsWXaOz5doRw2K?=
 =?iso-8859-1?Q?vqXedIM+0RHonKpoiCa3GeBsQ4QRx5vx9YC5Fht0o8aaP2H7y0t7ITzjNu?=
 =?iso-8859-1?Q?sBKyqcLLbdsZtQBpNI1m1Pib/kAzwYjEQdX8g83qt4wSU1g6d14xOmcy24?=
 =?iso-8859-1?Q?95/idfQx6oc3JAIK6dgfnkUGC4IRhz3jZLZ6CP057PirFSa2ef3FQmjaf4?=
 =?iso-8859-1?Q?PK1yBakI3RdyUnvJzJoyl/sShaShL7E0wX9Hg4HJF/CoflLsq/SrSTP0vJ?=
 =?iso-8859-1?Q?Bo+u70FrU+UbhtVbQVxTSIugvYYSrzN2o5blRNWVS+d41nbYjHVJNqTQKK?=
 =?iso-8859-1?Q?n2k01ffNMSiBQqH0XDyErvDSJGlwYRyKg5CqZwQUA8PQTkB7gM2n4hy/nX?=
 =?iso-8859-1?Q?o2Mmi23m9a2JAVU1AADE1o+OQ5eFNMTyw1sklHL1fUO62v138wrA1SLKu9?=
 =?iso-8859-1?Q?oumunE9eKr3CazABqEp1kyKJ5p8VK7D82IrCk33jf6GNX2xRILB3Fys+S5?=
 =?iso-8859-1?Q?E2J81Cg9sHPSjOaTZNDupkr59yXheHdNtuvyQHWRn4Tv4F9mAhrdIHIkyE?=
 =?iso-8859-1?Q?sM2AglFz/TAbb7DguXWxEGnOhO2sNUr6ZEu0i9JfnnxuU886hiYv6/3gAn?=
 =?iso-8859-1?Q?7vHVi71taSH6T5LPQsIZVNeOSINJvKIA5ac6mNfZ3P/T7WQp95gYEI1b9V?=
 =?iso-8859-1?Q?y1IbdMU1bSn8E8qofeHB5L/RBwwOxJSniPr6MA38/KOJRNEh1KyLj8eSUC?=
 =?iso-8859-1?Q?IVUMz71I4d5Pu7O6QG3Da+8I96PRZxBzm8j9m1d/93xlFXYf8k9NALRUaB?=
 =?iso-8859-1?Q?vEqLWR8l6uOl/Pm1a01TV6B4zARODqhEDON7HUOh9cS9YuYJ+RX+I3J+e+?=
 =?iso-8859-1?Q?vNw+I4QFPxFYZtfsOmgmlxxXFYYNpmNUPH5U5/NSs7usi3PfZPXH0sjIfi?=
 =?iso-8859-1?Q?EDk0lLTZp4NO0YnOzGQVt8jFOXSmj5Am7HCBSYO/PvZ0ZNyZ+KunaskpmI?=
 =?iso-8859-1?Q?USvIkVlOUQR/hK5VYPGyOGBbdpu4C/1sBtmWEtfdBhlI/iJcTdLtA03BA6?=
 =?iso-8859-1?Q?e/LQp2fyKYsc2HPkRj+fQg5VE5vQcICE6Mt90Mu/YfNJNYsyegonCNnUhA?=
 =?iso-8859-1?Q?+NehCIHl9oLvk/VSevAoGWEk6TsyoLKQ06Op8iCB7W9QGQKfGd2SHq/c09?=
 =?iso-8859-1?Q?b03TygmXFOMzzTYn59Y/YewtDYwvP0W4au3Rnp2IvwWHJ+I+60lnbzTGPe?=
 =?iso-8859-1?Q?AoNSDlh2FKP2E8QXT6JQ4OwxhPvTNAAxrltt+l3O1SibAvDaszgdue5MV3?=
 =?iso-8859-1?Q?MphmLeGjB9o3LzftlB8lKDuhkOla4Pnt9RdZNLfpsp2eIvKtZbCMJvGUpk?=
 =?iso-8859-1?Q?/fK8Se4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ie9CiPrZbFastEiTPBM5uIB/9/8HhDksLOeWfoMqr03w48o9cpMbf7RkG4?=
 =?iso-8859-1?Q?8Gx1weq5np52st4O72osxeAp4BjItNrfk2KDj/iv3voP9hQM8NNahfBIN/?=
 =?iso-8859-1?Q?c3Jm4y5Xz6g/+U/TYnd3rR7139gMDuYOsPllJL1VDflc6ckjS9J/mNWRvF?=
 =?iso-8859-1?Q?e1LSW8CcbiICxhspbg8DQarNmp/HRfMk2IYkOwHqdzKOYhGa6QnokVht6v?=
 =?iso-8859-1?Q?frVOFZ4rIhEcMOieoHnw0WS50a9PRTmZsko5ckpxJeugJpAKWql/2o8t9a?=
 =?iso-8859-1?Q?1faGQyO7nQATrlDRwaiG6rMeJWfLaboZd0UoO3UDCEEUTu2b+klPcIblj/?=
 =?iso-8859-1?Q?Vq4iWy/lY7nul23/ONRxq/36bX27D88iJzi+Nzr1YPhQq9dSQ901zCKGjj?=
 =?iso-8859-1?Q?Cu2BMJVYSpnHdqcAg0VBt8vooDrqpX+QcJ66Oyn5kkdYw2wyOED/fFfFtJ?=
 =?iso-8859-1?Q?AsEmARnBYK0ygiTK9XrFdkw6gqJ+t6OqKfIV/A/k9gaWo2D2/+GzHkYwne?=
 =?iso-8859-1?Q?2W8/5cpQUdib5KT4AhDFO77tjBNt3o/SSK1fIGB9GfdhwNc1g5iLvV/1MU?=
 =?iso-8859-1?Q?a5RHWMckcbwCWZTgPgEYqK5qd2k/8VdogMxdTFDQfHE45R7SZ/E5Ibjca7?=
 =?iso-8859-1?Q?8acLuLn8Mo+/TuKWPBXFxvObhXaRlhemJEXRqwXLRtsCmTLuVQZYe8J8F7?=
 =?iso-8859-1?Q?VbaA1vw4af6MnBujtLaDhdG5nz1Y7yu57UWe9oJjyMVyGQveuQXL0SOaGr?=
 =?iso-8859-1?Q?Uaadb0e1BVbxmpcILl+AJ0F154dr9EB+SZCqlgME5R8z0BGbVbsKYU1gON?=
 =?iso-8859-1?Q?XCpHFULw3nlGWWz/lmobhlXYdMvp+9AzoELJnJtbTIDclhBz5nAZnDWyv9?=
 =?iso-8859-1?Q?hZUcRjo5uDcvcStEIaRTLmJCXYsm7RylP5SDCWh6+vEhmXPRd0iJ/+J4/X?=
 =?iso-8859-1?Q?onm5vpvkHeervxsYfAjwZ2bx6fp1Ulf2O6FE4rSZtkIX6s+doeyjDpIsM6?=
 =?iso-8859-1?Q?KDQtRZAr8ekjYhFDGnVh6HxCdjjdWwmvFNF/owHffqpCtSqK7+lQuF41UW?=
 =?iso-8859-1?Q?9wX/XfUMxjAWaP/SyMtUAvncpiMBdBpjTb/6tdlY2TmEqf1yJcAfSmzrPi?=
 =?iso-8859-1?Q?pP1dJQDgx4AHXGiTfkFsI1ZCQbh0Tdn8oUrD5a0T+5H+iFhrJ3w7k7PDaf?=
 =?iso-8859-1?Q?96pUA1ezvMKRLwo/kNnZCiZIlW2OKoK8XDMOweg6Oovn3CczsDelXtJcKu?=
 =?iso-8859-1?Q?WLZX/kiu7tby0hp2xHlhhFfc7OD5BNE1/VMysotcYk58m9rUWv2vomTx3S?=
 =?iso-8859-1?Q?Znt9sAfnZmsK4fa1+9t0tqUfnM6KveSXwhZd1SroF3BFOx8+Urtwvdee5Z?=
 =?iso-8859-1?Q?bKtJ8x9StiReMSjH4RNwIe2qcNOgY19pqz6YQn2yFvD/N+G1d1Lpox7zFp?=
 =?iso-8859-1?Q?c78eNK5W5I62QYmHfgGVA6aqn71TRvr3Wc2XOEWBSFT6kQXJT7ODNTjoVe?=
 =?iso-8859-1?Q?rThrtOtuMjuzYAjqvhsddq2J24G1mXqaMtrLJ/EdFWIs+VeY9CD9sAnzPX?=
 =?iso-8859-1?Q?hCiXBuZI+4IXmSFgQ4teRg7YByUt46gTpQ9X9TohLPUVRiebSAI/FGLNNT?=
 =?iso-8859-1?Q?AyaM3R9KG59qk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91e38f3-7b44-4b99-05d6-08dd8ea7c700
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 03:15:40.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62W2Z+M74/oXV9QtNscrFNgNtqBX7LDJoGRVuMPB0yUN6GOvIQbBVGJehj3DkoyKeML4lNLTHARIj8tzj0x+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999

> -static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr=
)
> +int enetc_hwtstamp_set(struct net_device *ndev,
> +		       struct kernel_hwtstamp_config *config,
> +		       struct netlink_ext_ack *extack)
> +EXPORT_SYMBOL_GPL(enetc_hwtstamp_set);
>=20
> -static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr=
)
> +int enetc_hwtstamp_get(struct net_device *ndev,
> +		       struct kernel_hwtstamp_config *config)
> +EXPORT_SYMBOL_GPL(enetc_hwtstamp_get);

The definitions of enetc_hwtstamp_set() and enetc_hwtstamp_set()
should also be wrapped with:
#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
#endif

Otherwise, there will be some compilation errors when
CONFIG_FSL_ENETC_PTP_CLOCK is not enabled.

> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
> +
> +int enetc_hwtstamp_get(struct net_device *ndev,
> +		       struct kernel_hwtstamp_config *config);
> +int enetc_hwtstamp_set(struct net_device *ndev,
> +		       struct kernel_hwtstamp_config *config,
> +		       struct netlink_ext_ack *extack);
> +
> +#else
> +
> +#define enetc_hwtstamp_get(ndev, config)		NULL
> +#define enetc_hwtstamp_set(ndev, config, extack)	NULL

checkpatch.pl reports some warnings, for example:
WARNING: Argument 'ndev' is not used in function-like macro
#140: FILE: drivers/net/ethernet/freescale/enetc/enetc.h:531:
+#define enetc_hwtstamp_get(ndev, config)               NULL

And there are also compilation errors when
CONFIG_FSL_ENETC_PTP_CLOCK is not enabled. It should be
modified as follows.

#define enetc_hwtstamp_get		NULL
#define enetc_hwtstamp_set		NULL


