Return-Path: <netdev+bounces-216351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73071B333F2
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D953B84A4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39E22B8A9;
	Mon, 25 Aug 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="du7KeF2T"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D71C861D;
	Mon, 25 Aug 2025 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756088977; cv=fail; b=TuTfQ/dLL9gQBNmFHQBr0ytAYWqtVqAeOAFU118AqglFVaCiJn1wMA+K8nq+G7hy1G5NucTHZ3dpKxgqSJcajLvc8J0G5SkBIAoLOz16pfEm5IWXaDPaTpLQ+9eNNuOI1FTtv6tywA0AyY1xJywmgR63Ex9X29K5Y9R3LVSBdcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756088977; c=relaxed/simple;
	bh=e6ZE0W3FklTzYQ1HkcJYQ9jq2QS09ScK56ad7jxdwVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qAQaO2Is7gBrav5Y/m+W2glT2hf4u64A7v8+lWu1gqX/+Nt/2IL9+V2Dc1UDy7ovjj7SO84NwUPugS0oo6Eoxk8sJjhihxlckCckl50/jdFwb0puIcdaIWWGdU/2T6KT41KPwyrdCO2Ar4VU/QdZZXwEVfEdUi+hewAhJi5BVYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=du7KeF2T; arc=fail smtp.client-ip=52.101.84.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK4oYO//f39H9oX2OJy4esp4wP6ePxoU8ui/H/ni4hqbD8dcxPGMJfmlBtKnvCe9+jK/6xVZPGGsYzILSy/3e7nldtQaNhGmwgWHbwGKudyVCk/DuxDTfmiSb0kAGxbDFbNdkdHFY04WXlA8R9CRlg7vhyhwh6BbjBp2/+mihEY3MVeYWXgO7YD2STAbvqTEYEmsy2advE3pXXd36T79DvdVMeyPSQZhA3GQ0q6f7OvDrQBYt1uZex0mwH2w22WgsXUnilzsC97g8LAJlBx8LkplRdeH8PXnwQPMLba5WphsgY5xkFOJHY5PsbufnzS6JqjgCPbGR7PHnqX0vMgfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6ZE0W3FklTzYQ1HkcJYQ9jq2QS09ScK56ad7jxdwVU=;
 b=Ma/1SBM2QOQ1VCwjGtOIfNUV8Nq2eBO4FTerE5zLcmZM5bVDn8nrMOXnwy+0TJS6FCOo4dRszpi+eTEk29HCx/p+/vL5ul4fDlPWRezEfNyo3lfS07WAEPbNywAPynzuKDduuKL8sniJNjPG8oN2l1LrZXwE327EI10Ksv4/rOMV2c5NfHwQgjpglm7ces3t3zDG1WMyKPSxy7PCnJPFQFXxJld9gyxnTxvvLHqXvmhcGRddDpe03r0IFFsITSTktlVX14S5ABWfkEZeXW57ESK+b/uXIOMfc2cf8yJus7FLipkEeyGj4njDZTAx18NswVbQ3omIHysXZ3q1adRnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6ZE0W3FklTzYQ1HkcJYQ9jq2QS09ScK56ad7jxdwVU=;
 b=du7KeF2TqrrsaBRkGYyGZr5MlILRRDrULYBKKN2zMD6c60uvbBWZim7IeMCheX7NfIQmhXPvCmK14WYzpstN0TtqmyMMdeVzZSFXPm67M4mr3eOmtE9y3ApsltOJ63wB2ElBinLbGCRV+F8TGAXopt0OxskVR58yTn4ObjW5ROxfaNF52abOpqXKiky8F8Kc69/SZMbiPqtWyigufXrhad9Go4eFf4PldJZvoPa2slY8YuwIQ3GjGPgAEwLBcWQWqbZJ7sAOnycwyl2XFtGtH8S5z3PYqLm9XBLK5/wV/02TJlQhxDGBg8737PZZloeJT94stpfXJlejfnHE4RCBUQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 02:29:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 02:29:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v3 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v3 net-next 1/5] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcFGBjO7BKM7BP7kauJQbmC1MUVLRypyGg
Date: Mon, 25 Aug 2025 02:29:32 +0000
Message-ID:
 <PAXPR04MB8510CEE721C28C1E2F62A2C2883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-2-shenwei.wang@nxp.com>
In-Reply-To: <20250823190110.1186960-2-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: 90f16523-663e-45a5-5ca6-08dde37f39c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BW+sAqMVLrhtN4zNynJZmvyen36Z5DkTNW1IC2B4/7v2a/mleAweGjGz0cec?=
 =?us-ascii?Q?WwPOqo1LcV7+NfNduz7ZQgmK37jll9ztB1Znx4flrdFa3MUAjdWCnac5f/jf?=
 =?us-ascii?Q?ZUZ++x+vF/CMEBuQ1oC/VKYqnKO+4PMNuZwGspW5bVwpqwsYhCrup2xGFUlW?=
 =?us-ascii?Q?2zoa1brSL0+rS2U2cK6sifMGpQbRtW5bGC2AmcXrwaLuTjlWhePzWFYVYegc?=
 =?us-ascii?Q?2UADudjujOdujL1qRM0kwwlLiBEy12TB+Lu3YM6iPK3gHH5KILkxhMNwpWLf?=
 =?us-ascii?Q?esAmNGVYOkrWOKiWfdExXvZGd6ush2eWQwfawHfUP68rNci7vK7Bmcutz4X/?=
 =?us-ascii?Q?ljJlPX4/7pRlcxWJDgNMZYiC1T/Tx/3+71KsZYyVC6aRu0roS1BHrejvD4if?=
 =?us-ascii?Q?hbNFV5ERCZLc+/1sawE1MXvQsHhsic4cX8uDYmurVQpCoTxA82+lAo6E55Qe?=
 =?us-ascii?Q?crG9oyB3sRH95zwVErgm/tWP5a2a+Diva117JPNriXIQ59h8oC71NN6jIwln?=
 =?us-ascii?Q?OI3CpF17uRELC4qNtaT299wyFQepLA7PsgPdoSJlXQCeikkDWK808V+3nm+3?=
 =?us-ascii?Q?ncW6ZvKka5GT3FtCrKS7BtB76ym01nQ318Sb8JlKlgfjpjxg+gMdHouXV6hh?=
 =?us-ascii?Q?ZgoDppLFpQlynWrS79hjVDVo48j5uICU/Fwcm4piQARKLSNcFdkXdzUzb79e?=
 =?us-ascii?Q?XDG4znq+j2HxHN785EdTBLWceIFsOHjfijoE1aw6VhaxxfH8l39qPx+ChQ/m?=
 =?us-ascii?Q?fzuIYJlBEgI7kadiqzw6/oOrwlVdg4eqXD4Z6+/IR900GjU+IQcVzT0n/ZE6?=
 =?us-ascii?Q?/axizneicFvyXvddCn5PGfAxhwBuINEISJBqsSjTaJIhcA4sJL3WeAwEdYCS?=
 =?us-ascii?Q?JzL+OQnzEOwW3ltzWEKEkyNM7gKJfuGjo8jdCdYyCdD0819l/FcEpduiaS6w?=
 =?us-ascii?Q?K36Ap3HrRt15XOqUHLRrYPxFcaRxMv+trqR8bcHr1wUPHT3y/GyFX+vl1est?=
 =?us-ascii?Q?YnpSKNqXzbn9WlESZWtRA44rb3NhV1x0HM29YkuNkP8lGwL8wPx6nKQQ0mV+?=
 =?us-ascii?Q?OmB7bb4i0PYj0xeDi1RTme/fkezAhlcYd5+ZVvbt46iImn1N3nht3egmHqqH?=
 =?us-ascii?Q?HHTvB5D4Tr/+UP18p/rTG5mBwiPwluTp6jFsR47DqWMP5mZu05FdCc2uEW1s?=
 =?us-ascii?Q?g/Wbr5UwnCsA67h/bEDIoxBIOYvvfEvSrnHZB3vtAsr3z4EII/qur//92AP6?=
 =?us-ascii?Q?EnZd1oQEXeqrlUSl0BIyoNaVWg4hm2qkbKPfBfw1lw0eFe8AMsfKK7KhyLqQ?=
 =?us-ascii?Q?TS2RTV5fF2aOBQxbYCtzAg7kABWIJMB1gOJEQE5FOqicnmHgllkSi94cHbwY?=
 =?us-ascii?Q?AyopI5MoL0c0Fvk9zKfY91zUcCGIp19rvcHlW7YB7g2NgFUHAtPWdP69r0EI?=
 =?us-ascii?Q?gj3GLLxKM4AUFzQ0sRHizzkyaMEGiXoV7jpBof0+eSkzQ9oFuznGKQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h0ZETNmesB/WZwmhl/tyLh3WDR2xc2uBiks5to68MH88p5yddIL4mFRZSafU?=
 =?us-ascii?Q?na5OB4qYep/vJxG9JT/+qqjTLKP7Jb20PCBvpwwi1GodzL72mOnactt2aIZD?=
 =?us-ascii?Q?6f7YLyjK8paG5fZAlWwR4Wm874tswBnSRmwiuQoXRHVyXaJNUv1xIrj828kY?=
 =?us-ascii?Q?YRQkQTZ+aH8bgO0ReGCrfaSMBV+EjiWl8ZxfgQVNG3d5yUKYzhJOznnXP3TM?=
 =?us-ascii?Q?IjQiSJfzOQ48kXZx8F4VYs7O2JiZrXPmA5u7GZah1vCXFA59LiLezYHZEDdc?=
 =?us-ascii?Q?MoR8AuZ3z5ih1Kga5CgqQ2bVM9tPpGxzceiy4+jdLKru/EV+YHpkkn6/NAOS?=
 =?us-ascii?Q?lwsqXFnk7lvt6HTCwN74uubR8EqHFW9H5pb/+D8hhJVqNEWbtw7cCgU8Jq4l?=
 =?us-ascii?Q?uV4V+Ja6Cu4MCBw2Ip3Vi/ZHBjG6F612Kw7PTc4x8oMp5HfelVXyzLLtwIYM?=
 =?us-ascii?Q?DkZBhUGMS5rk/Y6lJXVClVMgmGeEmUZatLTSmRGdxC124jQPjIhPneZetkKf?=
 =?us-ascii?Q?TxZ51U+0OfLp4SmfmnP+N6JXJRvgpk24QnldQq3x/QEgX1jGEX6g0C955YVF?=
 =?us-ascii?Q?TTkREXnS+fJgDA8fzZB8OcJTsVTk0aRTwGABD3ksVgG2BkyFlMgF8QYVqwIB?=
 =?us-ascii?Q?xCfNuW8HL1YvOlQMKbYLpFgMK1AQSTF38ynZhWkXZNcgXkwTpRbQPSyfAvLi?=
 =?us-ascii?Q?xkwB5LI39+5imjmbLN8vglh5gN5Vh0TbICJ7+0dzMKgZc4iRDJOufRJ3wyvr?=
 =?us-ascii?Q?gan1UyyF85gTIMqyfwlcNwKMIPGsyFNLHgvYEM2PsQrt6jutXchh0i2LNlOM?=
 =?us-ascii?Q?3oDoZSTC6aFzXIZGPLeW6tnMbX6BF3xDFYbA++aagHJhrzdgE6Vk60qsRGAm?=
 =?us-ascii?Q?2Mh/R+ByeLP/2/S91fBCf5nO7MF9RiJUe36CJXgVPXgd23UrBG1PWzEH0Cah?=
 =?us-ascii?Q?OPHAOWtPOdK3Uj37w56JRU0eegUZ3atBf7O7kOjj2oHqZrq/QDOC1s7nSCAp?=
 =?us-ascii?Q?B8mD/7SaCDiO780OzAuwdKMqg/i+rYkqSyJwQZS2EBgVL8iHUHk7KR2WimOL?=
 =?us-ascii?Q?UuTNeY4vipybT+i2wh587ez/GGwWdDNOcxl9Yim1OMufV7mURwMcTN3BWd00?=
 =?us-ascii?Q?CGTtoidF8uqKgOIaNW9WxCJCMLP2Po0jv8CycfyzcSIXy6gegmawHZbhafdY?=
 =?us-ascii?Q?XBnX2DOCjSlbfX/+xAerAm60+eaJKaYdcSFb3whNEhtz3xoncLl9eof5uBOf?=
 =?us-ascii?Q?tyl1SwhC/VanQUbjNcwPEgvVbDJYUfGnl6KiFd+XeeDVjd5VA7mtQvr5DoNe?=
 =?us-ascii?Q?jDu6AapqLaMtuUgyzLTmPLriF2wAohu329Hmm8IMusXTjls24dH8944uDE1u?=
 =?us-ascii?Q?rVgUxcklc/kUHK1q1cIK252lbEu5GL718+4tAl5p3+1ttrrirjR8tilRKr6A?=
 =?us-ascii?Q?gwbu2KdRlg1ccboAi0ZV7hU9WN6WsHE4c4r5Ge/NYkV9JKmseb20/krmqZ8B?=
 =?us-ascii?Q?jLWIM5hSvFwLfcNUCWdNDpk1KStpCM0COLsRgd724kSOqYAX8WrO5vZnVSMB?=
 =?us-ascii?Q?Zi9U/m3CjqBY+UTYCj0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f16523-663e-45a5-5ca6-08dde37f39c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 02:29:32.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KwqqCpo3ErjSz85rpicNmJq2OyKDCyZOgMZwbhSo0WKjkq260JNLUBfzrZ11ZSeenfJDVYqO4o3S+URuPDrkWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

> Refactor code to support Jumbo frame functionality by adding a member
> variable in the fec_enet_private structure to store PKT_MAXBUF_SIZE.
>=20

Reviewed-by: Wei Fang <wei.fang@nxp.com>


