Return-Path: <netdev+bounces-197926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62673ADA58F
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74FC5188FA51
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87651EEA31;
	Mon, 16 Jun 2025 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mb5qXpt2"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3DA1E1E00
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750037544; cv=fail; b=EW+QRkPFueaGwNHmG4JD3eIRjZKhAuMXAlzystN4E19Qk2tooH5RyQnTfyIw8CY0SGagE7n/u++u2dcZ+ep4nkJG9BaGdp+oPxCE7MFs4/uyPLVQhhYSjNirbB+y02UNHUoxhZ9AUyPqOW6zQRV4CPRZVXVPH94Jm+oZgwzHNgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750037544; c=relaxed/simple;
	bh=p6mbfexPXwvzvbsx5NNVxrXiRTDRaI+PU87O9vWjBeA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tu1APX3H1c9ElUU9Us7qqIc3URuwpFc7gNVOA0WkzxGQa4SMBf66Zpmy2Y6f5suatuS7+snJ6EUdZ9a3reJgcEAPxEbLm6WHdOnVw5IP6Yemchs+5n9hanHzqTggyNDY6+3yhJm18xfjcqpxDdeYSHpjmi70991R5j/N3GC96Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mb5qXpt2; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmj/b88QgmuXIqrZpGVA0FxkOAsYlJ1Pi30BzDWj3ynVQ9acV2fyVIDnuI8tmTnbbJK0HEcKe3h34dpu5XMzjWZy+IAAN/D7hVB5a6inZEPvXnqQQBnS3KM9a5ighEe+fLFuM9F+8/2GAAiTQBXsptLF2KPDm2jIwkDUK0Z88yv9M3wOv2e/xEzQq5HNlKppMdw3t1Rt6IqIyUM4E/sf8hSloaSMs1DUk43oeRpw9oj/coc3tX38YGVciIZFddFfK7bLbxJjDmHPRbNr2jEqfW1O+w5aLDzob/6vWTyzr63KJLej5pEddCDT5GI41xJo7XYXGeWKat8CJq3n+ckYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmIaXR8cU9EHHw++1BwzJBp1TKZr/s9EP7menrYxhsM=;
 b=c3v8zxJs5ape26M6uE314YCDeZJGcfnemKcLJs8MpJeC6XkXHh7OaG8kJkd5D6CkEDkTzuMt9nJC7SDoCGzx1/mF6jpGYZ2FbyHFuWvwG0iw+G8l+Fw8LBq50JahccgXCHYUNG2QF9gt2pzzJlMTS4OveWjsMOp75kxiGS8FqthOZXQ5zhX+wjfqFfGU6C68kq52pd1mZWig30ttLfW+H2G3Y4xaoqZygEvjRVqC22su8df2Rw9ntjucWcps+IeNWpKSLHc9s+pp9B+wW7OM3jUFW/mqs5FDhxtMFG4NeglcPbF6jrvj2FgDhJa6AAjH5imNBEgCzfFfrQYQCzrJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmIaXR8cU9EHHw++1BwzJBp1TKZr/s9EP7menrYxhsM=;
 b=mb5qXpt22LCbI2fofVaaY+fVp0aDXrFwqaQwwme3N0vZhhIZUwDWYTiPVKjApiCrFwB01+XTqX/mUvcmEAzvgMZKMFJ6RJeZNXyG/mLjv7Wuprr9QfjAeHOr1MQ+CXjVsv9KxleYTilWl0I2N8fzNXwxEuOX3s7A2iGzFy3FH2/tQm1SzXSmwqZDkWQjqdhPvOuiWy/fnPoTq0HFuoLht+nCNV2YlbfYzv57ea+0DVSpQvjMM1KKHQHxH9U6df1jDIQ8hMIVVWIE+2gAcwjpQ3nktpaPeOBPegWyIKB1Plcur+yuzf3/nm65dOdAIoUgoivtCbLiqJXk2ZjN+lP6wQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB7186.eurprd04.prod.outlook.com (2603:10a6:208:193::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 01:32:19 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 01:32:19 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "bharat@chelsio.com" <bharat@chelsio.com>,
	"benve@cisco.com" <benve@cisco.com>, "satishkh@cisco.com"
	<satishkh@cisco.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>, "rosenp@gmail.com"
	<rosenp@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next v2 5/5] eth: enetc: migrate to new RXFH callbacks
Thread-Topic: [PATCH net-next v2 5/5] eth: enetc: migrate to new RXFH
 callbacks
Thread-Index: AQHb3VcdvlBp9agTIE+FBBoX9Ct4+LQFAfWg
Date: Mon, 16 Jun 2025 01:32:19 +0000
Message-ID:
 <PAXPR04MB851061D7E3DEB4EF89B9225C8870A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250614180638.4166766-1-kuba@kernel.org>
 <20250614180638.4166766-6-kuba@kernel.org>
In-Reply-To: <20250614180638.4166766-6-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB7186:EE_
x-ms-office365-filtering-correlation-id: 9394b3d9-c5ed-4a8a-16e1-08ddac75a28a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sIELtjl8Ao9gd0D9+maXb0fDkVWQA7jP2PxDhynk5zKIDEBRbiC9uknOZYw+?=
 =?us-ascii?Q?ZH+WHAmQbJFcAeFd2e/07CpFeQcn8SlDSYKkWAM3S6vrqF8ZPzTSsk+X5US3?=
 =?us-ascii?Q?jytjpfQ6uFMYM5DUrmyoaV+HDQ+unb32V5g88Rl9Duby158hyyAHdWxqqsuW?=
 =?us-ascii?Q?l1Ax3I+xAMu9ZZlrw1qF0x3xW4TbJAHzjGpi0Z3JH0Bh4uIJPKHSp7HmsZFE?=
 =?us-ascii?Q?j5cIdmw6gwAtoP5Yzk1HtYKSbEXQWjchH4HqL61UtUgWWMKiaLCV+IoDRWIk?=
 =?us-ascii?Q?NnAHihpYWcSogqePrMxLryjkIfv9/1NU+/W3emVfrkuWpe+nyjtcIouo86If?=
 =?us-ascii?Q?0YrZ92iBlQ9UM0c9zTtE2ABIIyk5jX01ZHKqL6+geV2Ju/OGCpRPKQRffHxZ?=
 =?us-ascii?Q?kEejvHqzPx/tWnXYlRZ0+9fVQ1Q2PUGBgXG0hb50JPBQKuhCCEp/pQaJVF+7?=
 =?us-ascii?Q?LgBPlEd/rFVej/DRLSUIkwmheyzaVNpNsxBBhXPEZZ6SH7LnuGmjCr8BhiEX?=
 =?us-ascii?Q?pCbwmvSzu1Y+8no8+rfATehTus3Bl4n0CpPjcYfa2c6Bzjy2DRSepCuZJLCV?=
 =?us-ascii?Q?oSuDTJxsLKfkWmHkIysuQ5ZDzdSgMlkMWm7Kyugt3vYrI5r2CorMdTIX8Gkj?=
 =?us-ascii?Q?moTMFScXrH2a7KjOPViUi54Ss1MzQIQbPB8viuzOSRmBKeLC2hA2a46cJj44?=
 =?us-ascii?Q?8zHDxTR3z3xageloOkXoxkg2JtjB70KZ1f/aaJ8G9g4ycl5SoOJtpqF33eCD?=
 =?us-ascii?Q?RjYVLy9h80WkJckxIMAzG5dMFZmCaPYlAPwGu9DQFXDDj2KcQnsOqpzL8AkS?=
 =?us-ascii?Q?N+khNwlUSrgM4b/Djr5NEvu5l5sogV/YngdqHXvGhVgMF1wVG8SlmsCWlkYS?=
 =?us-ascii?Q?oqbgoIPasZY5186ByP02KxSvPtCUCa/nIs35UmOve02Fq9INfXHSibx3EcsN?=
 =?us-ascii?Q?nFTAFii5HAaHVhh98w/JGdkkFG07H3kpOyA/tz5dg0+Cid4a8MnnrXunOrJD?=
 =?us-ascii?Q?k3itKvy6emzKtHUZ/sqYp/GL8sDKI22k7z25mX86hLzU8aqj9qtY7GexnpLW?=
 =?us-ascii?Q?4xjJJSPfYMQ2zv+Rzz88fj//0VLcwh4z/+OrSmxFU2HQNdSsvx375EJjuQh9?=
 =?us-ascii?Q?+9VBCQwGq8c+7v+iNxG2V23HyE92ZTfdeRrsl1jPs8NzcyYb9RLmkfFKtU+T?=
 =?us-ascii?Q?+Y7UDzvz7BjsXqIy9z8oUC2r+PFWke2aB/Rw9ykBC04O55WyY/Vyg9D2B5c3?=
 =?us-ascii?Q?q/7jaQP/gRhNrddpaUWtMzMb+sXdecWIEKbgnPY+iZd+peOe6xssOVjY7aZs?=
 =?us-ascii?Q?IAU59b91krEQ69QgB84LiE/J2dxRjvEBcrOECk+QXIoEdvAzKAfNY9gsr0OS?=
 =?us-ascii?Q?rbwCeyU6W+boKo8rDtHhD4CVaVTFqNdb3fL0qgYRTFthyt2qL7jOJKCYB+qA?=
 =?us-ascii?Q?ykKuDHHEk35ZxycIhj9Tg/9vAuU3RCimf7kVOZWy1A7gukcA9PM+aA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?A2578rdR2umZ3mVRJyDHs24VMzjKuoQETa+2WRwzXI3XAb3TfYDDV6yHtpPP?=
 =?us-ascii?Q?MW9LhsXf6c+4kLa4SOmSZZ8Gg8qnCkOlL0+ML4j6PXvs9XokTXstj62lqtK5?=
 =?us-ascii?Q?nX+HkFMlhxkOuUP+s+gZKrKxOXTDh9+wbCn+BZ0KB14AHPWiSbwvfgknvZK9?=
 =?us-ascii?Q?lr4Ld69lpCahKsjeIsJcO5EQ9G1FHHm2VnsMgyBzq/CNNpfxtY6AryiKpU6g?=
 =?us-ascii?Q?gjUmXzr6VMb3DA3M7gSqofQoSdVHdaFdP9Tt99BvWFkWwwd9CpO3TDeIcGiV?=
 =?us-ascii?Q?otq75JcO4zhmvsXgZ1SEtd++qpT10/tju+UTE4hq/eETbbgUnVu00BtaIMnL?=
 =?us-ascii?Q?suRZcY77xpIZQnmj0D1SG/L+LlNjTEtOJfDaf7N30bqF7eHa9lRKwDjt7v44?=
 =?us-ascii?Q?7H+lTR5thNMN2weffoFs84speuzjK0FO0WriPtR/6o1vJqYLeUtqHk+cKPhZ?=
 =?us-ascii?Q?qI5KVD1B/ChSxr2TcXNj2p1Pt5KA2FoLhcIeTOmIkZyn+aimhYmtihxJ+zA6?=
 =?us-ascii?Q?+htVhxw1DRdfQGNlhFEh4eHFUD8hogMkiLtxLcv35qGD/6FcG4zonWZEYx53?=
 =?us-ascii?Q?ckR0Zc/cy5ZcUHL2cB6HJ1zwhA29M47DVQk+hvh3FumurS1fOHSIEX64CBhJ?=
 =?us-ascii?Q?aM2KWXco5WyRemDGb83enT4r4lR0Feg5j7+kjq4AAvUvnOvmIQ/IPYU3VnSn?=
 =?us-ascii?Q?uCN2tsXDfwY3WOhmSimk4us3toLCVnY1IDbV0LII76H831NzAh4EWp4wmDzt?=
 =?us-ascii?Q?H/IiT0qQW3C9vTgkGane5CGFHMWaXW0wqIYYIhP+LPDesdOcgqlOkrHsAAm0?=
 =?us-ascii?Q?dX0OYhAPz9+E18vkjVn3BAsEKz2Hta0rcnKa9J572oL3iSbrFIeXJKioY5qE?=
 =?us-ascii?Q?AhtVORLOSuO0KJBinJHi3/YrSugGKF9B0a9kEuLQX4X8dVaCc1YvUpssx7/W?=
 =?us-ascii?Q?4kiJca7Y09oux6W30brKEDVVr/4vXlrDj+P49kRccEC2CW9SVMoeH7HrrrM3?=
 =?us-ascii?Q?evQUcSng0MPrOLi5540S2IDm0fSruLDAfSGpYYR6PQft1mp3tdsYl2bSDDP+?=
 =?us-ascii?Q?ujzW4QysxNHl6KdiGwZv+z1vZMOQ/B1Tjx/XJenuw5jmOHxb5iHQuXqnYysb?=
 =?us-ascii?Q?lxilIuRoOEG+CHHaZV9XK0uWm0IFTNmx5mV8nszRDczrik+KW/T20x3elawf?=
 =?us-ascii?Q?sABiok5cZj3srff4EoS2e0raEkY/7kPViuRdBsXbYRnC7aoT+hl5Rt7cPZCB?=
 =?us-ascii?Q?4kw34gabP8c4MsMjZva/En4oXTCxl3/EINgthnDzkLL0TPb2zXMWNQ0g7QKE?=
 =?us-ascii?Q?e0H8EQqlCieJyteyj7HtfsowqezZMMgOaaJLULS4FqEYZKRprLJwrWzWze5Q?=
 =?us-ascii?Q?nAMJqAIplgViqeNYRqovqNfeXniDX5opTq80Lca6GWHbUmeTEFRnvdDwQGv3?=
 =?us-ascii?Q?3pwS28Z5eUG5fIDQfvnbF671iVY8gbDRFPtMFQfGt8vi9LenudjLXo80J6pz?=
 =?us-ascii?Q?BJNfNoORS9JbEzmdQcwF6sG8Ub8HYyWNX8zGmSIF5B7Xpud/CX0yePBkeJbc?=
 =?us-ascii?Q?hed8tNoRz1lBcoGiRLI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394b3d9-c5ed-4a8a-16e1-08ddac75a28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 01:32:19.4206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pdg1xc/aRbOzesze4L6F9SlAxMd+dvC8y3RrzdjOD0LhPwXqexxLXh/pP2NCrJEHjwqM+t4FOs0YyPpL7rXZSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7186

> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> This driver's RXFH config is read only / fixed so the conversion
> is trivial.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add get_rxfh_fields to enetc4_pf_ethtool_ops

Reviewed-by: Wei Fang <wei.fang@nxp.com>

