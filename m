Return-Path: <netdev+bounces-159689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F70CA166B1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 07:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B493A7EAC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 06:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF92188012;
	Mon, 20 Jan 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSBa1EYJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB817B502;
	Mon, 20 Jan 2025 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737354837; cv=fail; b=h+kdoCPwmJk66ExySCZ1BMoEU8g4CHak1LKCQz/DsGFp/XukXIibE8On2zOYMthpstLR+vaOHqKgaiQB/Jk+ZvdgHNNt0bPMcIGuosKHTG/zIqbYYt3PX5ibBU+3pBwomGbojTRijvM5rHkrMO6pxHyW7ZUZmYT2Y80AQ7cTIEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737354837; c=relaxed/simple;
	bh=u0LAv/e7fl27m8H3yJVq9h3EJ3p2pngm6FGYHRWuvSM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WABZJEK2xv5nDxeNXASYSu/2Kw1Ud2cRvvTL05Dy4Aif/1ZGj05u7sJh1yT0X5jU2pQlMZUWGzFt5Qb259+IlXXppGBgIVDzS+ksH1l6SsOtxksyFDZpceN/eH/vrFx3svUkbY5sNK2oAuLC98dnRWgjVqjADZvO/lL983Os/Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bSBa1EYJ; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1RKhiZ0fEy/Kx/T4cVf+ivOeLaAldN/bstvgJrfPDslHTQckfDO8G1EksR7xpkv7F0N9kV0RJamt8eEo1zI2UT0VegWQBqnACWpyzdDpQkX2c2ftIXCUhq020tj+kqrXF99lstgiEotgRIuJMnAHdB9AI1sp0JV+FASvTV2MGpjKVjt3E5GamwB9cerNHygPxcsdXRwam9MhLYGjtEUBgZ/gpTTfKCKlQHy8wGeV76TKLMzpkAuOHw+B9jptcbSPnzDgRoHRgMEznHT/W7w9ErP4zfPlDS+o1jZLaGrC0dgHLRy6oioinagF+66wVEmr4M2eWTmuAKyBd2k6RqjNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhgnmNAZwzWYaB129Fe8GVZKqv8htEjBTVFnc0e6Huk=;
 b=Q1AaZ67Za8+BAjokVez00AzP7QiXiFiLBtcjn2qmElhbDaiNMjCM0BVyXEqikvGdcBYv88eUN4duqFMUEJCNdyuzNH0/SQzlGdPP7IUHAQI3OZvEtC0ymrXn8hEm74cNd2GsscvfhFUrQPD6VnMRCPG+Xi22k73K6+reXR8ZoJ/v+W5TnH0gmkZAo4iebW4Z4QclrR/L7HWZdS5zoXygansNFHSYuBBQpkOp/CgP8hRPo6k1Al/AknAl45sauoXCHHO3Z52/Lyn9EhTWmQSxCaFzFNsfuYPEraDoq2zoD1tRvTP1AybjUDXx38o3nsI+YP8aw9Cim4JictLxT3Z7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhgnmNAZwzWYaB129Fe8GVZKqv8htEjBTVFnc0e6Huk=;
 b=bSBa1EYJXbwljrV7by8PyNQdo5mjKA5nVfm+Mycv6TouGecWgSsRxFadNC+f2soO1zHYlSLOdxur0rvv+yVrvdinFDuxO0avHsCAlqJcaoVK+U0Hmnaf9tWU/A2MgC2Ewb2ZS9OpzfHLVRFWXYnUWeIQHLZYk0YCBRutkvTBJaCEHwRfM30CuHFXb1mx4hO3NJoMa1HPetmTjE4b3ExuLYkVS1o71pgNl1h5ErZc/qV0pkUwYpRGi+uXVQXA3yHyqzTMZF2zdJFivHFD9K82sVI6QadXRL/VpQ72jQDaKg3IMsr8W9CdhQqnep6JMPjqx7HNMe3m3a5AV6nFWYcJNQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9010.eurprd04.prod.outlook.com (2603:10a6:20b:341::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 06:33:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 06:33:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 net] net: fec: implement TSO descriptor cleanup
Thread-Topic: [PATCH v3 net] net: fec: implement TSO descriptor cleanup
Thread-Index: AQHbavN8sC1n/whXdk6lZwFgoNPY+bMfM1RA
Date: Mon, 20 Jan 2025 06:33:52 +0000
Message-ID:
 <PAXPR04MB8510BA544C3AA09C2F9EDAD988E72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250120042624.76140-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250120042624.76140-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB9010:EE_
x-ms-office365-filtering-correlation-id: d67e6ec3-9cb9-4092-51d0-08dd391c6847
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?04xtPEDvzr063i9XY7Ao9ewAlWQ23JGoCjdRe3pCfhcaZpdNYovQq774VEuS?=
 =?us-ascii?Q?J+wDScgxAXF2ZKFMP85vPS6hMjz0wQaYbviqYZBk9lCFJQo4Wj/ldJpm9h0K?=
 =?us-ascii?Q?3hQa0xgRyjQSEDbzP0pstC3yRH4JFxMb5B5J9f3b4RICrjtqT3bOh51/fY7B?=
 =?us-ascii?Q?DoRX757aqvWUHjnB39Ffg7bSzzNqZOIvMBXyW0QkjqgvskJd/acO4TQnEiyy?=
 =?us-ascii?Q?nTAuDSVQvBo9+l7Z4TkREVOzfGrDDmWkk/CG2if5MtdCpY5oM4CzhdoI6CaF?=
 =?us-ascii?Q?OBhKaCgrPdao13NGdA4D85HNEIDmlo0DzHReNZo/CVZ4beCEBpy0vw2iRKH4?=
 =?us-ascii?Q?WeYotMkrBPSta9RtrpOl75U7odm9llTnN/sY9VU6H6Solup+IX5SYccvZWgF?=
 =?us-ascii?Q?QkOXE55WO7eMWI1ZjgLJpigSMhqLnFZpxXgdvE4tSDvQ6va0jnWmQE6yPAkD?=
 =?us-ascii?Q?BjLb3pN3zb6/zSv2x8I5jh5A6RHiTX9/qi3V9W+D2XrPkUe+UHmfxLlqkmw7?=
 =?us-ascii?Q?dJgVQhmQeeg/sxdfB6TKu5js2/n4zzV5zEGlotbhGVJfdSDNEnrRrDnCNdn+?=
 =?us-ascii?Q?ybzgLuzRsDcum6ohWr8+xiA4UcIQxn9LI1rvsBcCNyfmtMGIflPUp+I34MkF?=
 =?us-ascii?Q?A64qEO2QCqetbfIGF6BqmIl4jv9w02DzVjJHw22tOUX2ZoTbpZSGmz239yPj?=
 =?us-ascii?Q?o9i5vW2wChuW9gb1jNGjx+mqOgp8zrzbbSxtkD9i/fQf+3I1G+UcpaXRdoEA?=
 =?us-ascii?Q?265cfqvryN+vEwNB7I/pAMS/ldNUQHb7E2OzvzU4rI3rApqu79Csf0P4+VG6?=
 =?us-ascii?Q?pTDDKDwLs4Fp+4XRBU5PjviY4b2dksYKpMjrP9D/2TWCALrBrsmjdLn5bAN+?=
 =?us-ascii?Q?Lyn/tvzsn+NSdov484K94FNyYcWBevr8gclbw+tnVVDUCBgyR8wiC84fn5ff?=
 =?us-ascii?Q?H7NYTsvVOrOiV5vg6NXtBkDz6zZ95NWSlemEXPRJqk7L8q1vbqNRvXYNkBB7?=
 =?us-ascii?Q?vZM4zbIY3VmB3/c9sv5y/V3q1RRAPOSBrB6QqtL3X44tgBHopURUbW4hlN2P?=
 =?us-ascii?Q?yT63VXptItziKdE5fvwbxJbNi7PhhvPXRFtY6A3Fx7AQpobt3/B8YcJhMunm?=
 =?us-ascii?Q?pX0B4csnnyuXCjTMlFTOVnNi9J6DyMIE1OtSC2/Ti9TjH0w9V5WDXAFzJu2z?=
 =?us-ascii?Q?5DAcOO5aKbUTcE3Aj2lw042h/AcA0rdn3OsU8s+xHV+cfQ+lfr9rNjXKsf6W?=
 =?us-ascii?Q?RFVx3N/SrCAmL+e7DGZIqlkNWFcQ0ePf/HTPxkt4mTZ5X/PYHhI76bXHsmau?=
 =?us-ascii?Q?2vcinXZ+lHeoLnN9MmmDbyQH4SgvH7RUe58Rx29OSwFMhha64Xd1JNGLe9nN?=
 =?us-ascii?Q?Rbr1PoGVc6/15SGYF6xsqiGaz8ucluckWjjtVuVX8hgSYzl4rIA+Z2oAy4gv?=
 =?us-ascii?Q?LKWpmJj7Cl/Qwk6Gntv/243o5kSvWnp5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?exCeGvE/pqjbpgfY3iRyWrfPdtfV1DepLCvIrezAy9DuOz2rIIhESywKYJ8C?=
 =?us-ascii?Q?bTnJwZz4uPo8/ewUM7RVMjrs0QxM/oe9HDen7P1oz5V7BHy3KCAMoj3Qq9v3?=
 =?us-ascii?Q?YCxGYpnOpC43kS35eIPTSa0JgRODnDJU8cE4NsDT78lxj5qImx4GJWh8lVsV?=
 =?us-ascii?Q?7mlrPgfyYzn8naS78HNiwesEOtqr3tXeEOatbLAokrq7TOtxqxFrLj1qD7tz?=
 =?us-ascii?Q?+sJnePHKgnnEEBW9Jf9zcxrGnlJMGR/U6okTnGLXiC5X6C0wOhEUpMXApmpZ?=
 =?us-ascii?Q?PDlvDcyi7HbojUFt9FcglG5ALcTsPEduEKhghp1RzolgcMPZ463WJJCknSC0?=
 =?us-ascii?Q?x/wqFZFLhAxB47BLui7wR8wvwB6EvD2gK0JRJikeRt6VxMnCB5OZzFE76TPi?=
 =?us-ascii?Q?KYAThODUrpxV47aY1s8RHCMBIIOWf4UnSvNZWbuxnwsZzQRAiT/iiBxJy5Y/?=
 =?us-ascii?Q?UHiw3vzJdCDcXqd4eBXEOPjq7GDlGevkHV1zRW8fwn5pE44T7T6rgFDtLfLZ?=
 =?us-ascii?Q?4itFp6u1RLHowJeRuTr5i56j7XKGezNCHS2HW2FzF5tNZmzzv9y1/FoMGFrZ?=
 =?us-ascii?Q?t5qqpdzqAXHIbgv6iC/0OcGfr98bF/b2LLBHkDH+t9bPubQzW32anotWErK/?=
 =?us-ascii?Q?PyneJWbuJQQ4/96btXub5JVn1XonURRcOZ5qZPcWY92Wzt583eqTpT42ihDh?=
 =?us-ascii?Q?Uu+g/OtGJ1Gqf3UvX3DUI7y+S7WCW1h2ZoWVrQIjTKMhpoiTeEMSklopbyPF?=
 =?us-ascii?Q?xwv64VOH2w5q2UBNSYp9vnjEVNl7ioTOARvbG+yOIla9Ovm6V774NDkFv6pZ?=
 =?us-ascii?Q?tySlnZyD2yJFrJve8Jv0U19wyqAX/rJ3ZGW+oEaw9/p9CE+MmPxA6OcJlIE7?=
 =?us-ascii?Q?w5VkSpBKlEQHucIdflRl2bp3Gx0C8A67sHoUT+0mm0Q5RwLULj/+qQXCVcij?=
 =?us-ascii?Q?FtSokXZ27hiVF/pRt7l+RpCoiyq1/04XVnCnSDFo/JIDNPea21Xkb/+dVKBu?=
 =?us-ascii?Q?jFXI1GQQFC/Jjbog1O6UlpjsLFvDtvZ43N6cRk1zSrg1YAss0k3h4T1afH7S?=
 =?us-ascii?Q?p+NWoTeaMgVfZ04nF6qqdtzpOD30yuN+piVDtXNiujXJ6TCgXKM4sm1r/2+c?=
 =?us-ascii?Q?jRRWquf/IeJpBGFle+EpbdAdRmDRS6i6wOGZ/xdKVd4xLLBqr36aZcWq69N8?=
 =?us-ascii?Q?dMP0m6AR/zSFYf6nY5dTze9cdqiwo5pNC9JQGx9XIiUNS4IpuOEabMeM0PiY?=
 =?us-ascii?Q?p2Ra9Fe0Xgs+Be+1MOTdS1LEBv2OJnucjh4OwwH/Z8aPGZ5goH63+6WzNN/O?=
 =?us-ascii?Q?5DCRn8B4foBXZmw6+FPF6WtFq0wEPeA6+O5DvtNzD2mLtc7ixHTTJt4Y5GfU?=
 =?us-ascii?Q?iXVmBDUCIQ5Z9ltvOUaMwJ4J+jtq69gycmopLXG+V93QzFP7WMV8s+6eZcie?=
 =?us-ascii?Q?a1Jdjmavz6D197BfqTeomU/rMghwslfNPHRJooCuL7maQPMVYBdcviv4DEvj?=
 =?us-ascii?Q?/5bcnHTTYySsOd1IcDkdg7w2fzGZZjPv6NH5qoIoJO7gW/YYzZmD23Q+Qz+D?=
 =?us-ascii?Q?muwnIV2ZYdnwzrfHyEE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d67e6ec3-9cb9-4092-51d0-08dd391c6847
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 06:33:52.7505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqalDcYdS//28vNeC0fyVq9tTzainS6JgQESWzPr4VksNpR6ezwLz0tZoVEQNJ2BvyUCF+r5CZKpAPZj5RQUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9010

> Implement cleanup of descriptors in the TSO error path of
> fec_enet_txq_submit_tso(). The cleanup
>=20
> - Unmaps DMA buffers for data descriptors skipping TSO header
> - Clears all buffer descriptors
> - Handles extended descriptors by clearing cbd_esc when enabled
>=20
> Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
> Changelog:
> v3
> 	- Update DMA unmapping logic to skip all TSO headers
> 	- Use proper endianness conversion for DMA unmapping
> v2
>         - Add DMA unmapping for data descriptors
>         - Handle extended descriptor (bufdesc_ex) cleanup
>         - Move variable declarations to function scope
>=20
>  drivers/net/ethernet/freescale/fec_main.c | 30 ++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..9ac407d30e85 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -840,6 +840,8 @@ static int fec_enet_txq_submit_tso(struct
> fec_enet_priv_tx_q *txq,
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
>  	int hdr_len, total_len, data_left;
>  	struct bufdesc *bdp =3D txq->bd.cur;
> +	struct bufdesc *tmp_bdp;
> +	struct bufdesc_ex *ebdp;
>  	struct tso_t tso;
>  	unsigned int index =3D 0;
>  	int ret;
> @@ -913,7 +915,33 @@ static int fec_enet_txq_submit_tso(struct
> fec_enet_priv_tx_q *txq,
>  	return 0;
>=20
>  err_release:
> -	/* TODO: Release all used data descriptors for TSO */
> +	/* Release all used data descriptors for TSO */
> +	tmp_bdp =3D txq->bd.cur;
> +
> +	while (tmp_bdp !=3D bdp) {
> +		/* Unmap data buffers */
> +		if (tmp_bdp->cbd_bufaddr &&
> +		    !IS_TSO_HEADER(txq, fec32_to_cpu(tmp_bdp->cbd_bufaddr)))
> +			dma_unmap_single(&fep->pdev->dev,
> +					 fec32_to_cpu(tmp_bdp->cbd_bufaddr),
> +					 fec16_to_cpu(tmp_bdp->cbd_datlen),
> +					 DMA_TO_DEVICE);
> +
> +		/* Clear standard buffer descriptor fields */
> +		tmp_bdp->cbd_sc =3D 0;
> +		tmp_bdp->cbd_datlen =3D 0;
> +		tmp_bdp->cbd_bufaddr =3D 0;
> +
> +		/* Handle extended descriptor if enabled */
> +		if (fep->bufdesc_ex) {
> +			ebdp =3D (struct bufdesc_ex *)tmp_bdp;
> +			ebdp->cbd_esc =3D 0;
> +		}
> +
> +		tmp_bdp =3D fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
> +	}
> +
> +	dev_kfree_skb_any(skb);

Sorry, I didn't catch the nit early. Please add a blank line before return.

>  	return ret;
>  }
>=20
> --
> 2.34.1


