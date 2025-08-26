Return-Path: <netdev+bounces-216768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888FB35171
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23B2179494
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD32C215077;
	Tue, 26 Aug 2025 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iwM/MP/P"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B21A08AF;
	Tue, 26 Aug 2025 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174282; cv=fail; b=tDs+2XfF+RR6s3C7UdZYKR/pbunRGxQ2EvcAf8BDsKtsQ7rvw9lImkVFgD10LJ/90BzGjMejPl76dPV88zq1ecj9I5Ic8vU2cN9ueXJNyaIgpaZE+DoSLNsc011aHe8cSkrw4gShKGFgPjqQD8f7kZoqGslZRJwWQuIy3rrUhLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174282; c=relaxed/simple;
	bh=Yp/feNn/OZ/xFC969g/QU6B9dPHbrQmLk1954Ho/4hg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iBlK88AJwJieSYK/zZx4/h5m8/OINGNVEYSfzLd8YBdqaestOtoGcsJTn7Nka1wmZas/tXEBTeEdh4NS5dpwCn/ECB++RoKY7vV0YqRQ/s3YkXH/S8Vi6Yj7WWVi2rTD8BW344SXPUTUXDBG0X9wrj9QJ6b/3PVM+vQOBAc1MQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iwM/MP/P; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTbrNEIRuEyDrgoEy9k3rijKYbdXjUanVtaH3DlNmi6jLtl5adX07I1DGxjvcpZ6a7IZBMXZZO/GmoJLO2qP6vK++ySHUUZZzvI7xkVKiosoztcxcyqWuJPD7HFxffdt44owp54hKMyaVrxB4g5d1tHwgHovUCtxZ5Fa+GE4K4RBd4er4p6dEDE4PedbfbhKaedIC9xl9vMwm1sI7p74k4QV8NQzqfGGvjPtcnnK6AUsBYgYoZTQ7I81BldnL4S7utHo29LI6dUCIKz2CziW+IYfBcrTW5dnn5CMIlkWiL0HuS+pJGpdS4P5quVSd4lBB0cEInfnl+OjvFbdxfisQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yp/feNn/OZ/xFC969g/QU6B9dPHbrQmLk1954Ho/4hg=;
 b=LBL5ldN/QfSJubstehdi1PEc4uZ26CD+ZR6bqLm89MYbp4D5aRNolrSgt3pktRSUaIB6ZRuJx9LRSehqzk4Q12+GFK8ijYg7GbIO1EyCqI6afealTTDfvfw4eGWi+XFgHn5K0VPEfqTb9Hz3DLNb5jR0Kd929JJISUvO68T1QSqy2hvWn7G2ppaOaX5KqcoBsGPlvUj2iZq5G/qmthV4tgR1nInV+zAhtoNPILbqJC6yV8Nnf7sCeID1VA3/Rf/K+BvBzsJ58jFmYLwJkx32ZLxT3gFi+Uj3/uHMJjKHv7VH54TpiOlCoA62vgElAmKOXi+qIPvNPlbXcSqtEggGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yp/feNn/OZ/xFC969g/QU6B9dPHbrQmLk1954Ho/4hg=;
 b=iwM/MP/P08XJbhQ7PrKvWXGVSaoyXqzzcDtCqZKKbH0fnLMAtHIhbKj4nbfHuWALQHr+2t9pv3xc6CBUR7DS8OzlylqQRamANTYDNpU1HD0S4sUEjkif7817QWBz6j+A2oCOewfvsX5ABKbySHVguW/ZiGYKds45K72nAaO+/q7y+aDMONHpUXryUQfhgHfYFDxstVbDEGaKDWqE1xIHl6yt8MrqHlgR662hlyyHGFQBDQc+v/HdZJbmgnY+tKdYyCGg7tcjIh7UiHtiu6brM2/8nVxDn9WtG/D5FaXUSBRAClGx+6n0mn7sbHOTRGl+4Bg3i9RvXCwzcC/vmCIXWA==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB8700.eurprd04.prod.outlook.com (2603:10a6:20b:43f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 02:11:18 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%7]) with mapi id 15.20.9052.011; Tue, 26 Aug 2025
 02:11:18 +0000
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
Subject: RE: [PATCH v5 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Topic: [PATCH v5 net-next 13/15] net: enetc: add PTP synchronization
 support for ENETC v4
Thread-Index: AQHcFXoC8qmdnu8gvEiM8ESE5kA31bRze8eAgACxqGA=
Date: Tue, 26 Aug 2025 02:11:17 +0000
Message-ID:
 <AM9PR04MB8505BCC32207CE23753BD19E8839A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
 <20250825041532.1067315-14-wei.fang@nxp.com>
 <aKx+h+WEyjE23UwO@lizhi-Precision-Tower-5810>
In-Reply-To: <aKx+h+WEyjE23UwO@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|AM9PR04MB8700:EE_
x-ms-office365-filtering-correlation-id: bfc43f59-7254-4b60-c865-08dde445d7c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ka3pBRL1Bvrqk31QBZcZKU74tXjS2xeTD9x+m+CJZSpOEBulQEpUeVfbmYkB?=
 =?us-ascii?Q?kLVIZO/L6I+jtkEL2ETHpmxmq6Gym8HZARbuhxUBTLh+GMur+Fmr0/KmKBnf?=
 =?us-ascii?Q?fsCtbNT0G/8GmIC6KKjgFEeLFN+7jFpD1sJSN6Jzbsa+dBJWu1FC9OkizlOX?=
 =?us-ascii?Q?7jYeNa5/V0EhXCGieNqwRxQBAWcwwqRjsjDS/0XOPjKlQgiU2rDi0uosgTah?=
 =?us-ascii?Q?L2K1si9BOngP4fQ3aNj3BvDJtJhQqweZxTWNkInSG0HVr2gmQORlhPJUabxO?=
 =?us-ascii?Q?Ui3IXufM8QWlwloCaYEb86VmllmJn3NcKWWyoDHHxjn+K3DVcLhv8A87s4K1?=
 =?us-ascii?Q?cjNcTjBtw47iZx8Bd2+LtvmWNOv4UMAI5aXPw73ME6+48q61ucsJ5FTnyvP7?=
 =?us-ascii?Q?7cIYtLA8q7XDM/4R8447fchGAYj7hlk9bR2S6aFjivKAfO57CallyWIfwAHc?=
 =?us-ascii?Q?JvA/1aq5oI4pKZqoonBQN8Hq3oBQNtIMwMAgNNtA613u9pCVTtpESqbwG2Ed?=
 =?us-ascii?Q?4qagVnbV0o7sSsDywcb4OPYLeiv/MLYARByWgxi7CZtyetYmR24EsvUc/2Dt?=
 =?us-ascii?Q?x5jpMAvSV2sh9IqmLjl/BSmnfzcHZHTdnUiBNWt+AUwbLQIYZJ7CrWKi/GOS?=
 =?us-ascii?Q?KlkUOPZRY2W0jR82+udOg7zpFaYgVZQ4MwQZsJfDP43Ych7kIDz/3Zj30fal?=
 =?us-ascii?Q?MsPOXsKuIONxOAlOcbv9w0i++2zULVEvNq92UHV2xitf2YEePWxVdq7EMiDA?=
 =?us-ascii?Q?toGTPYpINm57eXIUf8zPAGgvRX1XqkBbK9G+uiUw5XJBqFyUaitRfEJw7MSy?=
 =?us-ascii?Q?CT3FnoV/YJdb0EdlSQT4GfcbJlOJxHXDWS1gcm0PmNPvej6VrE/Sz5FTaecG?=
 =?us-ascii?Q?dbHwIno0GV0E8jIsfTtg4StJENowoJdRH4LbSoff6U7IIjpzr9YuO63bqTAy?=
 =?us-ascii?Q?+N1AGZm//GTcqYvCNTQsKUCdwjSvP/x2FyVaqpxmkcPkFp/qJZ4/XkXhndp2?=
 =?us-ascii?Q?3O6rjxXwvyocyTdNNrVDi/Z6aZguaIGbG3NHjdUBWt6xog33B3FeJp2QOB6g?=
 =?us-ascii?Q?XSiwF5JCHxx0zGXsPQ7hG7lA31PecTv8Yghoe6Y0YlGy7+h9jpBNPWMFRJEr?=
 =?us-ascii?Q?LoaWapFkqMOsnsiMs8BIMhzpZVK+Q3u8HJiMEff30Cyd2TozT+WALrXZXM0C?=
 =?us-ascii?Q?l9KRIAVR9f7f652KX/y9r1MTq5YJNdZlmeFHz1S3/4PZn3qVIyj+PyskxzJ7?=
 =?us-ascii?Q?K5fRuZQB1z37J5tVR+oLyCF6FwUyVLma75sTid6SPt+U/UqtQbU1qqUmnJt6?=
 =?us-ascii?Q?TJr+wvIJBJp6dU/xPP853iXlYXA7A2Ee4sCmFoWI+fFR5j9KI0DZPgfcwfu8?=
 =?us-ascii?Q?Bk8Tfs1TobZmJ1DhvV7ixccrKKqzIsrYOREjS/bBx2I0D5J61S3nsHGAllV9?=
 =?us-ascii?Q?GF3POE8/JUpqc4LPbR38Kz8HOxRKl9pjZHHYaau/KeYrOcZP09r78w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lEevmPR9j6BWEmmYlhRXYTvKWB7niRgII3uvvamCJUgGAY1JO0lc7WnFpaio?=
 =?us-ascii?Q?vBBbCdreIr33Xcq9V5sFzj17q1NLe1A0Jv4ZJezSPeGlPzxZppYsbOlRY+9K?=
 =?us-ascii?Q?4p0dBqqMU4Zlm977n1mQe8YS8wHDf1+49TqFi10tFsU3s8WHcdJyVq/qSYYa?=
 =?us-ascii?Q?jvrbeWsTUjRI2vabU+HoJASE49GqWgvLXJGxUAPxe8CLCoJSrHqXB0xd2mbd?=
 =?us-ascii?Q?8nAKOD4d+Tc9HGgB8bRdL+yQ2++powU0USf2/9QqZyDUUiBEPCdxVpHy0Qte?=
 =?us-ascii?Q?6MhM5g+QtdFazQpMOU/M7C7fdtnFyHwnw5Y08cQuX7B4P+dcyGIgcEdSjXNC?=
 =?us-ascii?Q?6ASaZjMxmTCvdv2QSW9pW9b99KHd6+2yQ4IOMd+ocHtmMtG4lCNXZ0hJz0rL?=
 =?us-ascii?Q?KEIDAF77q0bSzdSgvqlxARi6VeO8DZdu7ZW6+SqBUDE0LKYYZWrNsNZFM+nV?=
 =?us-ascii?Q?Xr2f9Sff/IOFcMYcGw684qWT8AK7eEYGHteD46dwbfZkCIRKG19rS+vkb/vE?=
 =?us-ascii?Q?ZR1oEbe6WLRmrzsPRUUD19faQjnP6sIYBNaQO+9VQI72RLQuiNpifWKrlctL?=
 =?us-ascii?Q?oYH4q0I7ACV9tJVFuwaN5VaczVSi58U53GuCIPfTx09ct429PZ38eOAmLzfY?=
 =?us-ascii?Q?eXPTiNvPaxPAmuIKESEzAJr6oPOFAxCvDzJN3NtLlv6lT5NDYMqBqOtcJB3T?=
 =?us-ascii?Q?zPWPlXHQF73abvmOXES7BX/1wuyvzldhojGVVMH83hUpgeCJ4QRCkv1AMDii?=
 =?us-ascii?Q?WmggoOp873hPZ4NXSIR6MFOFAgI/XToJi9G+0MQzmZNcF5+ialPlAGvP5HL5?=
 =?us-ascii?Q?j/x/VN1Vz4mnZbTGIm8wpUWtRcq2XD6sgwNvn0DesdozRh45FZTV90dLIzKV?=
 =?us-ascii?Q?nCTsMVfsVSJS53xf8VwC4vsOi6wOGUKmZ5IM+yaAa9vWuhzjHrtiY0KjeYz+?=
 =?us-ascii?Q?owSHHuWEmtge5V2A3FIVL15guZkxju3BrmIDmYSQawSAi4ZcmrW7Vtp9j/hS?=
 =?us-ascii?Q?RSyYyF1P3g2lqJ4ec0jenSrCMQNUsWo+kkurFKHZpYgx7STfT/xbG78pIq1M?=
 =?us-ascii?Q?LzWrqaIx0AumwO5qq1vnUfBtBKtgN7TVEpYlmxwIsdZAQ/Q2fBAnqX7E1nA/?=
 =?us-ascii?Q?PZjPoEl02LzsVWtsQA1V5qipvJ+KiRDyr0FjPSE8WeepFtEKnMAALDRzEPRf?=
 =?us-ascii?Q?KYefejgY3DxXk+QmiK4Ja9ggsahMpjDqnFtY3cap+L+gt9llCJmCxPhMvWbm?=
 =?us-ascii?Q?VvhmBG0Gxano4dhgV7DNnH4UzRkszOAA7ylLVo7ProEnieY/i0e7KgMbJ1Lw?=
 =?us-ascii?Q?u2bep8jOx7C48cIcdgWdxQw1Ns7zmGxd0bspH0f9o9TeuaTymIC1zAI5jc+P?=
 =?us-ascii?Q?+3MKsqAtGberMaS5dgwtVy1W+ObBOufaUyYr55baMhQU1urAO+yHvfNt9ADX?=
 =?us-ascii?Q?FWY2W2HRy85q1Qdw7kp1QjsECg3kV8DzVJ9m8PVMHSqXXm8gSwrRy2pB2JZY?=
 =?us-ascii?Q?VBZm/Kn5npPXzlPR08n4TIrFaPN5hg6teMvn6xwwaL7SPkWYLKtjdJiEvoNA?=
 =?us-ascii?Q?uryyHnxmXjelENkPw08=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc43f59-7254-4b60-c865-08dde445d7c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 02:11:17.9742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yg5XnDLsKrHmtq6Dt49ofGM2qdgZ5a7kBbeEOKm36EZbUdFYZmsYLiv6AbVavq65lgGjaXAlIfpDeO4JcNlJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8700

> On Mon, Aug 25, 2025 at 12:15:30PM +0800, Wei Fang wrote:
> > Regarding PTP, ENETC v4 has some changes compared to ENETC v1
> > (LS1028A), mainly as follows.
> >
> > 1. ENETC v4 uses a different PTP driver, so the way to get phc_index
> > is different from LS1028A. Therefore, enetc_get_ts_info() has been
> > modified appropriately to be compatible with ENETC v1 and v4.
> >
> > 2. Move sync packet content modification before dma_map_single() to
> > follow correct DMA usage process, even though the previous sequence
> > worked due to hardware DMA-coherence support (LS1028A). But For i.MX95
> > (ENETC v4), it does not support "dma-coherent", so this step is very
> > necessary. Otherwise, the originTimestamp and correction fields of the
> > sent packets will still be the values before the modification.
> >
>=20
> I think it is wonth to create seperate patch for it, put it before this p=
atch.

Okay, I will a separate patch.

>=20
> > 3. The PMa_SINGLE_STEP register has changed in ENETC v4, not only the
> > register offset, but also some register fields. Therefore, two helper
> > functions are added, enetc_set_one_step_ts() for ENETC v1 and
> > enetc4_set_one_step_ts() for ENETC v4.
> >
> > 4. Since the generic helper functions from ptp_clock are used to get
> > the PHC index of the PTP clock, so FSL_ENETC_CORE depends on Kconfig
> > symbol "PTP_1588_CLOCK_OPTIONAL". But FSL_ENETC_CORE can only be
> > selected, so add the dependency to FSL_ENETC, FSL_ENETC_VF and
> > NXP_ENETC4. Perhaps the best approach would be to change
> > FSL_ENETC_CORE to a visible menu entry. Then make FSL_ENETC,
> > FSL_ENETC_VF, and
> > NXP_ENETC4 depend on it, but this is not the goal of this patch, so
> > this may be changed in the future.
>=20
> select PTP_1588_CLOCK_OPTIONAL in kconfig will simple this?

I did not find any other drivers select this symbol, and I looked the
help text of this symbol, it says "Drivers that can optionally use the
PTP_1588_CLOCK framework should depend on this symbol". It looks
like we'd better use "depend on" rather than "select".


