Return-Path: <netdev+bounces-159668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6E8A16531
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7816D7A1E48
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F80182BC;
	Mon, 20 Jan 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RdgnSrNF"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2FBE4A;
	Mon, 20 Jan 2025 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737337642; cv=fail; b=p5QHBgrBSSEwtcb+XuVCW5S0qLqz4g1bzrWRlqy9TVxwpfs+Kgr3Gnpp42cXySuAMPDvyoG0dJqn4hBc49dkYRSuC/eu3AwKiH6RO7qYbo4ccrcsFiqCToE91G4G8dQuvTBX1DTx5u05AkGaDoZht7/S55EsL1JVCag7fhV813Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737337642; c=relaxed/simple;
	bh=/wJtgy2nFxVzYdnerFMCRsoTqT5SbWB63w7yfTo9EQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LniN4ND+OxXlGgk6y5I+monuCSS1I/9ya/p23+oOKRr1eRzbhky4fkSSL9xqUOV/cOYIBAJ9BWm9ykryHZmTKiNkrJhmplwcWxgnuxifggEUO2dzXHcQySny5/SvjkqbTJocE+Hk6Iix+Qv37nHwxXJWq3cJkTJHQxa1wgS8xqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RdgnSrNF; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNc2NBvODKPsUIF3nDrZ07SGb8pf3jUo5y0jPcZo8l5hNTQzZDoVt1HRqQJO8QEaLanQigrzvm3EbJz2QVmek81CvfMQLuuvjsYgwtGEb35KHryc/MArNSSixSP3MbRDYdVqRYs/U0mJ7X5bQwJfgr2qn/wRWRx8IsZuSnZepYI9acsuGrjgftjdWwKqRGLwbitgjnJFKt1fKZID8Hjt8Vq4X9pm6iiuO5K5D96ijwcUo6VS9XvWfk+LcPrHdCtWDGQhZiqO6UjzQOyNf3a+M7Xsp8dqdoaZkqoLxzBkgQXuteya7cGHXgwZctdLgcKpcxo2O3+C2NXY9Giw4aO8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbA0TkEtyJFPHEtxENloM30FBhgt2w2qkYa0oEhh2xs=;
 b=OGw8E4ItK/CjtHHdPjTZwzQ7ppBDq/fNdw1hsZrE5uQ2HVHTUsHe9cgyw7Pd/DxUb5k6R+Mqm1EDQM3hApkawr6ON2KBYQJHcsdh/CnaSF3mu2JGpFe6fje7TZWb9loDcW3ftaZpY5rTBgq1UqEZnx8+Fkg1a0RGwAQlSPgZXV3/gGQw+M84vXdd3gIjjkQRZwY1hgrvgqNKTnENbzceoYsU2dSxuSM0CQbVxUfvVFuG6a5VL29UK2knjB0wMu1P5w2j4Phf/7tWxLxBND48fGm0qSFgeyyYEAID+XLbIM/EH6/bwVALJXROlwt7Oqij59Qultdp/j93tQ3tboCqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbA0TkEtyJFPHEtxENloM30FBhgt2w2qkYa0oEhh2xs=;
 b=RdgnSrNFpUSpEZOTer6NLI3YPAvNuJN1Mc+ULLMOyppPt3lN0sTJl+2grVavZp4kzXpyQUb763k8OMlIDVknAOOPcw1zHfGpr0yIPQa2tl1Z8S0TUlfasgrFOZTxRqexAx5LMWs/tjwb9KHDCy5y1k8viJHFEPtWbqMAxfZ/OeTQhd7qGw7Xt5jIB803RMtY9Ka7VXR75AvGXYoi5NuNSzCvKZ9ntsGEPiaWf5AOelaZJALR4jq3i3qAzeHKbUf5xPaoyNPq1hLltlAx/+EZ0mqnvka5CDyEnyBmDW57hzqSQa+SJiLn4udAk/1mT+zTKlF9OUJHwMQUN3Z/R8QPCA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 01:47:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 01:47:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next] net: fec: implement TSO descriptor cleanup
Thread-Topic: [PATCH v2 net-next] net: fec: implement TSO descriptor cleanup
Thread-Index: AQHbaajjrdR5M5nnZUiB1SJW4i6ta7Me5GpQ
Date: Mon, 20 Jan 2025 01:47:15 +0000
Message-ID:
 <PAXPR04MB8510E6F1318202CD7F0A833288E72@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250118125952.57616-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250118125952.57616-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9150:EE_
x-ms-office365-filtering-correlation-id: c83cdeb6-5e25-44fc-dfae-08dd38f45de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?N48JkSckmM74U/KjAdgRYf5mBvdCBfnF4suaLvZiHUpTTkyBSlVOUIwyHeJk?=
 =?us-ascii?Q?1VS00wAw3NbHTlCDHClwxU3b/MXlfIk6IbzVxzHcRB/SLO/Dt1sOsi6miaUB?=
 =?us-ascii?Q?G7Bgbjt/gUZpZzhrf80HXjHaoVRT0Dj0/48QpZNAMjn4sY9NQxZTIQS0E2MM?=
 =?us-ascii?Q?79cEVnIdYMuagxcGTK7m2nSZD8mkfVROkISl3O3gdK/0BCogEL30KWR1bxmI?=
 =?us-ascii?Q?CtdXSbjpS0i+xJxiHspHhVkQQ1INnQBbienfs39dnY/D+jZA9o3b/J0GIcJm?=
 =?us-ascii?Q?SZWQSPdUUj1PwV9dcwS4a6mqm23F54Rtdv/75TyFRsRLJtj0lO/nhbZQ5iGY?=
 =?us-ascii?Q?zH36ZduuaG3iKnzCEee2bPMtS1oF0NqnShzUTDHtYVzYLu727FzL1fjbiwQk?=
 =?us-ascii?Q?SVkNKTSEAbI9bX6puOdB1dHGGQr2ufQPaNxQJSjoNSqiHcft6rwlnBZHbVVq?=
 =?us-ascii?Q?PmEzND0GsC+BzJ3SX3CktP5pW6K6wAx1+8+WPO36ISEwqQIQz/z2PaW0ZrVJ?=
 =?us-ascii?Q?Z9v+wn1+86GSCLcc4WtZGaoCoBq72UAZrlZy1rU9x/5mbyHEH2le2+zHfYug?=
 =?us-ascii?Q?h9NvTYtLg139HTFvGx5oQRWIJzG2N2O2XIa0Zn7DxQaChkGbeqSofUz42RDc?=
 =?us-ascii?Q?AtEYFOL2rHNARZHyVvn6pnGjjHVC/SeGyguRzLgMeO5E0bCgKVnMPmCY42P5?=
 =?us-ascii?Q?MAirs8w1ZBWPMt6lWS6ZedNTkGOVQbGnMtcZI6yg1GNgYiIZDBv02GvmAJD8?=
 =?us-ascii?Q?pQqG8EnPA3GnWGvgNVPjlmvw9rXPRn4vSztT2qeoi4DnaL1HtCI0YEGtT50n?=
 =?us-ascii?Q?bPnzwfqwaP90w4KZLtAi7dUe+2gj6LsSJwsMlKRCjEjkABtxzMRS3bwXVHR6?=
 =?us-ascii?Q?Wz3YZJd0iUl2Wilhu4hnnaAfNC3mEwmQhSQFCzjIJSsarifSASUKH6rDagT6?=
 =?us-ascii?Q?BqQhg3yAC91OfxxzFy/45OawdLykj38FCW5CEbnCWJQMqwaxDQLD5tvZ8eda?=
 =?us-ascii?Q?13uT6zKA03eZP9ffxngdo9uV4xfxOJ45mYAxj3jgVp13PECR54QWFKL/7yg5?=
 =?us-ascii?Q?yQs5SeHO6IvX+oJmN15HKvwY3YAIiV9G0ydoJ6kzes5UbPaJOxdx3q7oE07n?=
 =?us-ascii?Q?fWKzdz2hL8gtI0ryk3TWv8EE0ReWUv+nwtEC6xZrKv/lCGs6bvcXztfh5IPA?=
 =?us-ascii?Q?SYTpZQ2rQsWkDhxrSVstnvHbCC+/6xRRY47EuM9BYx9vkIXv7vkDo6potEiZ?=
 =?us-ascii?Q?wk9kKjglUaLYIezhv0wj1dGd2JnRyVWkuCvOcjirWwLO/wkbKeiNoM1D0H6X?=
 =?us-ascii?Q?JRrerF9LRqD4Ph5P5+3lQvA0+Q7+i+UbNDpy6UbwfEOjd2h5LU2XEIGyrY06?=
 =?us-ascii?Q?nhtM20UpHYS4pqqG8sVLiZpfLQiKWlqA50Fv91qqryVIn1gTb/+dquzhzOIB?=
 =?us-ascii?Q?Px5kBBBWdyk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XkmcLcsc7FHdKpwkMNpqe/9AHbsq0Xm4zyUJCbMb9UXLwW+rZg82MqZB/NWF?=
 =?us-ascii?Q?Ib7Vzh77DEw0cfVBRHy/z8e3xs6To7rEDrVddA/ijZKoKW8bkdr0oyu3YufW?=
 =?us-ascii?Q?LPEuBABVnDzMjEAvL9GtC80rmaanFCuZP90Ezdh4JyyMKO0c/5e3eWjvEfaq?=
 =?us-ascii?Q?6YMfsgEV+Gokd38zN1KGZYXYG85/2IO8xx0sot3x9wFVbJszSLKv9SOE0+kv?=
 =?us-ascii?Q?wytT3ue1kBZUxQ9nCEv62IdEtsZNAvXcXJfOcL/lGMEMF5kUEqC8JVSSHqpA?=
 =?us-ascii?Q?D8g1d7nNYnkQzH+++sv8UZ1IG/klwMupa2e3vh+GgUPaqpI8hy/8d41T6xgb?=
 =?us-ascii?Q?SCxUUVsayNhjsrc9WjzOEWTqmV6Rqe/pnobwsWln2AFDlxomSR2iJ6Dl+LVo?=
 =?us-ascii?Q?7htixxG3GdpYT1gWYt0Mz5YANfAq6poH5DDXTxZ+jJDqNx0v3v8a9Tk/TF4a?=
 =?us-ascii?Q?EwnZNiWLFZv8g00B1+Arhw8waxThyfGm1icDkzlRyX1b4L+v1VztYdB0G2BH?=
 =?us-ascii?Q?/yziI34AhnTJ2uR6Os62CgFsVx8yW4Lxwys4E2S1BLkaNmaXTUVVIttyb22B?=
 =?us-ascii?Q?F61P03+okbcOhoWUCPXVjqTKzcilfYNbws8IjU91qxBAvtH9WiCMBidDiuRL?=
 =?us-ascii?Q?Bq1h5U0xzskA/pxlP6CpNlWW0VnLMvcytKDTga8PLt7oAVS4n4uORWj8YhwD?=
 =?us-ascii?Q?jzVJ8uRwp9K5Gp/TJPByrYO0wycs+tAe9ouiaLwIIoEmyiGFFHnUPyntcM+s?=
 =?us-ascii?Q?wpfEcRC62ygNBm5katx7o2pFaGNizQghqCGK7OHFxmZgXyUyyJ404Qa+ERqh?=
 =?us-ascii?Q?GsS+gVwN4t6bzqTjTDR44tDVYtQ8RTq+G42N0SUZuoXtnQ4PKVgiWOXu+QZl?=
 =?us-ascii?Q?HIa67fUSRkS0mUgfGikQVIPqTJJ+5vFhrqelyTSSDWosagojgx0BNsqPNJiA?=
 =?us-ascii?Q?vouzRDC71+l7WPd5+kJDVTFXrj2NVXygrWOxbxMLOcc+yafNQV9qmaIsgl2H?=
 =?us-ascii?Q?kef/J6comqRBDcPX0/W6NL/yrHep9w7OMo6FgmmGNJWNAOKazWaYGozkx8oc?=
 =?us-ascii?Q?po981R/yGuYNtLWqKwRDFWZkacDY0HiGZtT7SPq2Q380ERtFf6F4yE35fTp4?=
 =?us-ascii?Q?7hBchJ7kKC4/IjAkm1hnFLtKmDmjthkP/eKws6xVh6TtzZzCTYR8kThvofR2?=
 =?us-ascii?Q?39pu8D09LNNFVWdZ87geSiB5balUt0of9bILA88T9+uZVMIAX5YAt5HZlF00?=
 =?us-ascii?Q?Ih3+bwJC/khAF2r9XITLI4Ro6R2lmtTdu0p/SwTL16cZaErFUr/RnSiqV2Lz?=
 =?us-ascii?Q?A5+7wvKdxuHtB6oU7HvN5EJUyMQ7qPRbDyXL3v/+BAJ5trUAiGdKsRelFTE1?=
 =?us-ascii?Q?tCDM4hFdIBkLh1fV2GFvXaLsgifaiYWAOhqSn6Z/SLbkWG0YxnCIRhXQDC+6?=
 =?us-ascii?Q?7TTNbWP7/xKGm2QKkO2oXAM2bw71Or9xN23CvBojVatUWb4wSyldzlbOUioI?=
 =?us-ascii?Q?au86moAPUxJyjKK/nGQmYxDW5wN75spLLk6PZDgB5rUtGb6aguQOmY3LKPDU?=
 =?us-ascii?Q?BR642hOZpBE5CA/+a6c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c83cdeb6-5e25-44fc-dfae-08dd38f45de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 01:47:15.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8TAhiwKRvv5/aE8Gg+Vqb5qUIQVETGNzqXToTTtCHBcObqRcPqQn4Tjz3jtKeAnV/N/mJRITCqu9j5jhuF09A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150

> Implement cleanup of descriptors in the TSO error path of
> fec_enet_txq_submit_tso(). The cleanup
>=20
> - Unmaps DMA buffers for data descriptors skipping TSO header
> - Clears all buffer descriptors
> - Handles extended descriptors by clearing cbd_esc when enabled
>=20
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
> Changelog:
>=20
> v2
> 	- Add DMA unmapping for data descriptors
> 	- Handle extended descriptor (bufdesc_ex) cleanup
> 	- Move variable declarations to function scope
>=20
>  drivers/net/ethernet/freescale/fec_main.c | 29 ++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 68725506a095..acd381710f87 100644
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
> @@ -913,7 +915,32 @@ static int fec_enet_txq_submit_tso(struct
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
> +		if (tmp_bdp->cbd_bufaddr && tmp_bdp !=3D txq->bd.cur)

All the TSO headers will be unmapped except the first one. So please
use the following check condition.

if (!IS_TSO_HEADER(txq, fec32_to_cpu(tmp_bdp->cbd_bufaddr)))

BTW, the net-next is closed until Feb 3rd. And I think this is a
bug fix not a new feature, so you can change the target to net
tree and a Fixes tag, thanks.

> +			dma_unmap_single(&fep->pdev->dev,
> +					 tmp_bdp->cbd_bufaddr,
> +					 tmp_bdp->cbd_datlen,
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
>  	return ret;
>  }
>=20
> --
> 2.34.1


