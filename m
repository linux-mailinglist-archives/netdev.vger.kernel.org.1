Return-Path: <netdev+bounces-126028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FDD96FA10
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66A21F21430
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C51D4615;
	Fri,  6 Sep 2024 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l0NvL8o8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5910A18;
	Fri,  6 Sep 2024 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725644669; cv=fail; b=orE1bannCPnhVTIZckSZowmDhTnC8qtO/g+etbqaoKwuDD0roeGy99yGWWtCWF7b5FKmTzL7GRJS7R4GF+n8AerLmuBRei82bWGzMTwcSxe4Zc2ziKwvjtNxfzLeMBYr4zxu+BORN0KC74Twls79vv7Z+kUjeOyNfxOlR4OQ9xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725644669; c=relaxed/simple;
	bh=co9CnoDTszHsgGXGB3FxtllYrHSNFvpEQKoxTCbD4Zs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PgRdKk3Vd4hhzB2Sbmw0Hym4kT8q3/nauQHA8XLWfmb1yCSbyMjFDLtgK76fFJ9RTcswt2XQEpKrVpUrP/UEXARkTHtbUzkezr5E9hgIQdtAoK9WDZhJvZGtEBDrkui3GSPdsjp13ycHOhWFFum8wA3acDKdfmBtVH6nrHUbR6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l0NvL8o8; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glUV95VajZXT99J/qy1cp4WCALBgdcyNgEc9mCNXClZZcSraytbe38FiZlo6WE164KixPdi9Tnr0IGCI60+ylgIvyr7jPj8fmZr2p+gHEm2M5R87YiGLSkFbOCkrieL9fLa6WZ8W02SlJbSiOwISISLzIOtHWkGL7AkZzEDR4DBbTn9S/5EdH4QzX54HK7IbXWmcCYPhuCMSTUJr7vhlp68j/1Ej3/4XUpH9eFJSGmINeW9JNsfW2FWirDdG1WgVCg+rU6fK+9usS7K0FOp3UZyyD1mK8nHYqBAMdshICoXofe35tk7/31Rxb+dckx3NbhD6J3+iSW5IN5YToiONKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSau7NADuMQTZwvYB3RNcp0e9RUvZ0bW0Gv5I2hhG78=;
 b=ETsD2gXsRLVG+E6Wbub15osZNx/5E+ajLe/y1vVQKg6jjhLsaOG2sqtdKgc4pxRvqdmvnv//Tqs/1/dBaMom2ifV6hZTYJc4TpVyCMfl4HjkXx81JW0CFaKDvkZ0jx76r+r11aXsIRNcGPMJBdGZfcVJQ3bUCB1G4+oR2hbIG7HcsKzOzDx4iqZyAgGw11SOIuLSUqQgo5n27f1FBV03hSypMd8DfqnP+vWZH0/pxf/2+P9F0wnSrwgJSTVDWyhXTuPYyFVgQuXLWCbGhXD9i2026VvsX21So6PVy4g1LHrAQtoZpygwY95oihjnhbzkEXa/Y5HGdKsIG4SrpQyhJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSau7NADuMQTZwvYB3RNcp0e9RUvZ0bW0Gv5I2hhG78=;
 b=l0NvL8o8xhWrWVrWiR5fnNo1CWV7QM5x4SsFCMdU4LmOvlG87BFCxOrUdRGnGOSB9qin83dtqUaFAJcwsJrJSGQIrO6/BU5mRk+LGufBctwsem052AyG8i76OCh0JaAvDR6S/VV724+tgRsllDPc+31v7rV9Cune6Sbl1FvUfnc=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 17:44:24 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7939.017; Fri, 6 Sep 2024
 17:44:23 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Chiu <andy.chiu@sifive.com>, Daniel
 Borkmann <daniel@iogearbox.net>, "Gupta, Suraj" <Suraj.Gupta2@amd.com>,
	"Katakam, Harini" <harini.katakam@amd.com>
Subject: RE: [PATCH net v2] net: xilinx: axienet: Fix packet counting
Thread-Topic: [PATCH net v2] net: xilinx: axienet: Fix packet counting
Thread-Index: AQHbAHvVuwbq4/r5M06PX1q73duZQLJLBFFQ
Date: Fri, 6 Sep 2024 17:44:23 +0000
Message-ID:
 <MN0PR12MB595376E110FB44EEBCF9C7C3B79E2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240906164227.505984-1-sean.anderson@linux.dev>
In-Reply-To: <20240906164227.505984-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|SA1PR12MB8119:EE_
x-ms-office365-filtering-correlation-id: afd3ad4f-7009-4330-5532-08dcce9b8bab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aYWY5CyYntS968f3SXiD5vrccUW0Lg7Qqo8cfIy2f7ta8zGxPnIspqyKX2Cg?=
 =?us-ascii?Q?Rwgg/JzMxO81JnNTaXPFQiwzmhmZI0hGj5oJHzdjO5cCU8sOINmey3fX+2vI?=
 =?us-ascii?Q?IEeeB6ZnDv3xoJZ9XohIXoA+DAI5xufJ0WhYWZfq0XvGOGUUhj2+bH+LqkkJ?=
 =?us-ascii?Q?Y6pFuqSMHAC3zvJ8okSNHhc8/ULWYraeLo5H7JsQ5OoMs4czthyFdOIZdY8m?=
 =?us-ascii?Q?mDZ66+ixbRhLGU5sIVL5suy/eIRIee+h24IdTrZQwknYPrBghjmCSOAyuFHn?=
 =?us-ascii?Q?TJNCicRJZbFz5lOrcSglp46Oa8iWxkG27KbZ2fOEGDLWjrdKZ2y/5/lsbJ/1?=
 =?us-ascii?Q?8qr8Hskh39NALx0S4vXvLrrriHOWsmD4q3zLUTVnJC44REBXhdVwlJS9pU2U?=
 =?us-ascii?Q?bqj7QGO5ETkdbz5djw+uS39sJAi8URBcvhdxI9BU7+E502B/AfiL/nOWrkq5?=
 =?us-ascii?Q?fLGLMOrLLSO9UYdXyU6gWmXu0Y2hrYqZXgMRt7k1yym7mgghcmvMa94t7uDF?=
 =?us-ascii?Q?vLktAVVLoLw7cdeNH267EVXfywh5YFas6PvvaaV2in04452/aiMp7Z2wDr68?=
 =?us-ascii?Q?wGnnvOmOp3ggEiLAvY2IcHRM53b5YrCyenOmlttEIFHoTXu7hYiFl7SMc+yP?=
 =?us-ascii?Q?/6wYFZuKSuO3v+z2cX1GQdzLt7c7aLhACEt28g0QpH9Yh7dpPY07jImWpTiR?=
 =?us-ascii?Q?NaZN5wNC+Wok4z1jHTtybmFqUHIymAezbMfdwakG+PFW24k8acJ57ogRqJ88?=
 =?us-ascii?Q?xxCHICg2/sxfq2Rs6nUL434N5k+5WI7QDhbArwoeIkpDKz8AD5wz5bcxGvGO?=
 =?us-ascii?Q?NpNVFknjD9FO8dOEXJmegC4m48LuH+19yydDDqbi5rvjJyBBw7U9ink4dXVs?=
 =?us-ascii?Q?wgsvMn2Y0V9UoBCQwUcqluj8yhYCez0MPuDOsEqrMqtEYHaH86TEn/lWLtrq?=
 =?us-ascii?Q?FIoPN7Q4Cb1j4Ri/pgN7xxpd8QUu1hbl/r6WY5ZHwH6CkEu1uZx3Rg/hm+SA?=
 =?us-ascii?Q?v6BCQe/2W0OZrkmcjZSWuvn49Er5afOTDf/x+yAyRcS7EInseQIiR04fELRT?=
 =?us-ascii?Q?7UP7Ku0URzUuzRH0r525F/OfkL35pqMmWzCQPhDNtGU0z3rQXbC2Qp8l70US?=
 =?us-ascii?Q?0BXVrNPnCPRN3zyRDspjolgNcoUeUqJU0WV5gE/2jCqD4GbwbM66X+LRQZZZ?=
 =?us-ascii?Q?msyHgoktYyWrtavvvaFrvhF+41LpNxES/+8dY/mgJu1fnEfVL5YR+UKJiW38?=
 =?us-ascii?Q?AJgXQ0pgO7vfrTtQBLoF8iGmLuMMpes0yfpOHKfFEZVd052hybgbCe7EVesT?=
 =?us-ascii?Q?LzKvNnl44QyrWRzJWJySiBoCiH9hMvAAld3UuApr8N/1ZcmA+Z8ARPFx2FoR?=
 =?us-ascii?Q?MlC/k5hPW47TLeH5jHKlSysjCJ9eZI5p+9fjJO4++isSV9u6TA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IRob4P8Vs9lr8rEAwolEwmvG7omahnoRjgzQpK5ztY29ZLPySynBfENxcuot?=
 =?us-ascii?Q?B7S9Ir8f7xG3IMUjHe7rWaDJd8/s/1NBtiXzryO+EcKCgwL1N7gxNFj6ZYTL?=
 =?us-ascii?Q?JGdwk2ge/dRgZBTuR4vflwEXG5D7oiOOXotfqt+QPfQrs/lRJXo0qBegMRmq?=
 =?us-ascii?Q?HNHs+mui7O/KJxLzPB2BT4Db1MXCiGVqXmuJVZMo13YDOSOLrQKBrauA3QSH?=
 =?us-ascii?Q?xp0p3OQf3tVVHSzTN69WDWTFJOJ9opo5qHUha0Yg8fkHfFClyZ0Nz5h1hFlP?=
 =?us-ascii?Q?Grue6yTftnG31uTBAkfzaOxoqqjesm/jvMQfePbenyo9SviS3nWsUfNi4KGv?=
 =?us-ascii?Q?oG1AkLb0W5rLCN1gp7SgJsX8x1DbnZd5n8hwyRrGPC5vjefhO9pYQvetFNQh?=
 =?us-ascii?Q?hh403yqO1G7qUcysxzleMgTuCC6u9z/fp4ISmUPwu8YsocSoYHu6k4HtWXA6?=
 =?us-ascii?Q?kZE+qt6wzUxyAaaFCrNIHmcHAZwyNFzwC2nc9nxxsGhaQvf0jiVPncTZJPMc?=
 =?us-ascii?Q?SO50BDSqoFqE7PmMIadVmjYWpbLNmAL2olkVh/v/6UL8toh9lvaePxEMrKlp?=
 =?us-ascii?Q?Cth8nNFk7j+zxLQV62lqNzwd5GFvsyP4XflWdp9mUACSjnd/gvcNXkazLh/Y?=
 =?us-ascii?Q?rJupJmUvvLscXBQagqMJ7afknezPX0t4Cqi+lQnqxNx1gBRLEnmfKAaMXR05?=
 =?us-ascii?Q?UrxQwiGZB8EnE1rN5MyXCQTcFeAJM0VaUxeEWUA1w41zzyvd67pS8YtInE34?=
 =?us-ascii?Q?pVf64K5YnWwNHwRoWiAbLS/0XkFINmLBbAGQ0yqGFJNIUNnDU5NiTy86vzo0?=
 =?us-ascii?Q?GK2pSSAK+S4MinF6MiSx7GGjXqh+NaFd5MupJNjp/TIjx18Ve5rPUG9OOF0d?=
 =?us-ascii?Q?Ew6l1EjuNEhEvSP3VV/q4tXv6pPIgB/vvU35QPwJQ/nwdnUaEc89t8QiJUBc?=
 =?us-ascii?Q?q7BotcQ2CCxk0wzTezvn4mWDeXurgAqvNOqEWi034YlYohQyLTVF5K2UK32K?=
 =?us-ascii?Q?YyfsN+uH/XUJH0GQw6k+9IA9AtbG819tJy+ubvSwkUkGArsJQMc3lu+VjpJ4?=
 =?us-ascii?Q?IW/HiRTgshu5M/QKPEXQgr5FPujfzIFHsrZ54K6O8eWxHMvcM7qQR01tNTEA?=
 =?us-ascii?Q?1nWWGkMKXze0BHu5+6Ub7dK5SDAQxVD5cTfIEc7LJlzDTSHuhAVttb+sbnln?=
 =?us-ascii?Q?3BnBVY8cOpWS59TYGxO1wjQrliNN6/CVKsS0M12i82/u79RoxGbqIR0RJ0Iz?=
 =?us-ascii?Q?rt6RjXS8u3rKGjXZpbNSrkybXkg6vDEuOJpQYtlBPSWnIMHAx7okP4+vaLnR?=
 =?us-ascii?Q?U/M9jeryGwzH3XzPNgLDCCoxAcDlK0TXQrdjULXCWByMlSe9jMo+ZWEhmhzL?=
 =?us-ascii?Q?3E+r4fdLCfcSyY6hpv3hsB2h+mg44k2MGecrWL0mNvz/MhtaSpyGuA7vQYwd?=
 =?us-ascii?Q?e416hIa2Mrs6XDMeLshGfWSw1vaEPEhTfriqk9Jbt5eHB76a1QFXk5JfZ5tH?=
 =?us-ascii?Q?56VqzTk0LCLCdUwhqlH28hrtbEDnzDKfK3mbFACZsz4Wswu2au3jXIMcG6qo?=
 =?us-ascii?Q?xdoXN5v6em5pCyd1RDc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd3ad4f-7009-4330-5532-08dcce9b8bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 17:44:23.7677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jz/6kii3gqk/6X6L/t9qR5gOqLtLGxersdlOx0dppDMI/U+XjfBypDsVC+bKWyO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Friday, September 6, 2024 10:12 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Andy Chiu
> <andy.chiu@sifive.com>; Daniel Borkmann <daniel@iogearbox.net>; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [PATCH net v2] net: xilinx: axienet: Fix packet counting
>=20
> axienet_free_tx_chain returns the number of DMA descriptors it's
> handled. However, axienet_tx_poll treats the return as the number of
> packets. When scatter-gather SKBs are enabled, a single packet may use
> multiple DMA descriptors, which causes incorrect packet counts. Fix this
> by explicitly keepting track of the number of packets processed as
> separate from the DMA descriptors.
>=20
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net

Isn't it Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion pat=
h")?

> driver")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

+ Harini, Suraj to review and run this patch to ensure data path sanity.

> ---
>=20
> Changes in v2:
> - Only call napi_consume_skb with non-zero budget when force is false
>=20
>  .../net/ethernet/xilinx/xilinx_axienet_main.c | 31 +++++++++++--------
>  1 file changed, 18 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9aeb7b9f3ae4..556033849d55 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -670,21 +670,21 @@ static int axienet_device_reset(struct net_device
> *ndev)
>   * @force:	Whether to clean descriptors even if not complete
>   * @sizep:	Pointer to a u32 filled with the total sum of all bytes
>   *		in all cleaned-up descriptors. Ignored if NULL.
> - * @budget:	NAPI budget (use 0 when not called from NAPI poll)
> + * @budget:	NAPI budget (use INT_MAX when not called from NAPI poll)
>   *
>   * Would either be called after a successful transmit operation, or afte=
r
>   * there was an error when setting up the chain.
> - * Returns the number of descriptors handled.
> + * Returns the number of packets handled.
>   */
>  static int axienet_free_tx_chain(struct axienet_local *lp, u32 first_bd,
>  				 int nr_bds, bool force, u32 *sizep, int
> budget)
>  {
>  	struct axidma_bd *cur_p;
>  	unsigned int status;
> +	int i, packets =3D 0;
>  	dma_addr_t phys;
> -	int i;
>=20
> -	for (i =3D 0; i < nr_bds; i++) {
> +	for (i =3D 0; i < nr_bds && packets < budget; i++) {
>  		cur_p =3D &lp->tx_bd_v[(first_bd + i) % lp->tx_bd_num];
>  		status =3D cur_p->status;
>=20
> @@ -701,8 +701,10 @@ static int axienet_free_tx_chain(struct axienet_loca=
l
> *lp, u32 first_bd,
>  				 (cur_p->cntrl &
> XAXIDMA_BD_CTRL_LENGTH_MASK),
>  				 DMA_TO_DEVICE);
>=20
> -		if (cur_p->skb && (status &
> XAXIDMA_BD_STS_COMPLETE_MASK))
> -			napi_consume_skb(cur_p->skb, budget);
> +		if (cur_p->skb && (status &
> XAXIDMA_BD_STS_COMPLETE_MASK)) {
> +			napi_consume_skb(cur_p->skb, force ? 0 : budget);
> +			packets++;
> +		}
>=20
>  		cur_p->app0 =3D 0;
>  		cur_p->app1 =3D 0;
> @@ -718,7 +720,13 @@ static int axienet_free_tx_chain(struct axienet_loca=
l
> *lp, u32 first_bd,
>  			*sizep +=3D status &
> XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
>  	}
>=20
> -	return i;
> +	if (!force) {

Is tx_bd_ci increment dependent on force state and not done if force =3D=3D=
 true ?
> +		lp->tx_bd_ci +=3D i;
> +		if (lp->tx_bd_ci >=3D lp->tx_bd_num)
> +			lp->tx_bd_ci %=3D lp->tx_bd_num;
> +	}
> +
> +	return packets;
>  }
>=20
>  /**
> @@ -891,13 +899,10 @@ static int axienet_tx_poll(struct napi_struct *napi=
,
> int budget)
>  	u32 size =3D 0;
>  	int packets;
>=20
> -	packets =3D axienet_free_tx_chain(lp, lp->tx_bd_ci, budget, false,
> &size, budget);
> +	packets =3D axienet_free_tx_chain(lp, lp->tx_bd_ci, lp->tx_bd_num,

Why do we need to pass tx_bd_num here? Is budget not sufficient?

> false,
> +					&size, budget);
>=20
>  	if (packets) {
> -		lp->tx_bd_ci +=3D packets;
> -		if (lp->tx_bd_ci >=3D lp->tx_bd_num)
> -			lp->tx_bd_ci %=3D lp->tx_bd_num;
> -
>  		u64_stats_update_begin(&lp->tx_stat_sync);
>  		u64_stats_add(&lp->tx_packets, packets);
>  		u64_stats_add(&lp->tx_bytes, size);
> @@ -1003,7 +1008,7 @@ axienet_start_xmit(struct sk_buff *skb, struct
> net_device *ndev)
>  				netdev_err(ndev, "TX DMA mapping
> error\n");
>  			ndev->stats.tx_dropped++;
>  			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
> -					      true, NULL, 0);
> +					      true, NULL, INT_MAX);
>  			return NETDEV_TX_OK;
>  		}
>  		desc_set_phys_addr(lp, phys, cur_p);
> --
> 2.35.1.1320.gc452695387.dirty


