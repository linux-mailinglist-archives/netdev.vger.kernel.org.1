Return-Path: <netdev+bounces-216349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918BB333E0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CAD7AA1B8
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FA0230D0F;
	Mon, 25 Aug 2025 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EWcNDqXj"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FBC22B8A9;
	Mon, 25 Aug 2025 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756087988; cv=fail; b=mCioqRPW2ypFNqojuoCZYlmEfJ3qRVoPjby/iV3/DxGqEtTeYWqbx/HnY8vRanQMN7WUZOAHIJGll7dQAZA9Fu4Nw8KWgDw3nYg6q0tFzuHt4AZG04443Ge0zPjjqhXdVTZf+c6c9DcsHxrXKQyFHbHjRpuZ8xO7yNL2E9qOwj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756087988; c=relaxed/simple;
	bh=o/VLFwt+g4f5HjwUWMUVcs1oVYp8r0ktvEFHtnluujM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EmRhY5HySD89kXXcJZystoAFCczPoBOvtItFdZAYGo2f4yeMQ5ydULjaT9PpMpcyh0qyuFZrZvUJMDAS2tn5hY+3LMvGR1ZYdGW6Mms5IkzFYD8fMjGtntIDiK5IJGOEYoOkPuIWdvyYzwopLcPSSK/E09vP1eardoiK6uIC0nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EWcNDqXj; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOWe680pY57wXA9wKR/O/INGC2BIN/4430YLE9oSPZQKuCjXU15h89IeKcl3l5/Pheqsv81dn28uWAuWkPzv1UUyRwexAknujNYhkw4lFPMoFinCTfHMmtNzZiguQIjiHs3U6nxS/3Taqu/H+AI7c28VkSjoXVO32pXkoBLqmf/fzmwd36CGUcXwUa6VlGEu03O0stWYlf37bHTTNWnFv8Y+ARZqP8e2/Rx6rUWjSsMd4i4sF+mgKbEdQsZzqZcCD81B9+z1X2eGK+Ms6FImNcVxX2VTqv4VfHZ6lPCwY37UPuedusTQ64+H8hfrnoz6z4ybaqkAOS80OSfLYOApGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkT+WD64IZrsEpjOayGjZ7aulTdU5owvkjuOdsQvxi4=;
 b=mNmoHIW327B3d+T1fgrkMdp7zLjVzD/21bej+Ds00dPJvggpecFsWpAYWZ12XhDk4qF1EfC5YneCx9Bzuceeyqh6dYhSUDmb5J82XPvpBGiXmhV9rnDrTljRZSeVWmu/zlN2Q8k9ZyPkfwZ4J4+YBzUaJJtMjZiZ4EBoMzd8mPOzyekrWLAC4bbFeQiinmVlNjpJWmwAp4k+OJKO8PY38G5L9v2h+pgSMxTC0rOXCzb7AvE/kbNC7zIRp0WQGL0PQoIb3vfxUa9GZUmqSp8fD8PqEYtgJsTsXVAAhsCKIvWTWmJuJzSgpn5QwbYJzpsQWezqgqMqXnCpnPDh7NMGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkT+WD64IZrsEpjOayGjZ7aulTdU5owvkjuOdsQvxi4=;
 b=EWcNDqXj8u1t/ZB89NG1OQDmwlXGViwfrcUaQJH5xwNOhmrBb8FdgapE/v+bp8QbBDfBzg9KwCRHhdiZb4rU3wCs1YCSvrlCsHFGVDkHUYCssRBfsXPhOasJBLYdidXiCLRweyGRqYOrBFwR/yv0aN+D6BU9cLrzEe++FGno3Rfhd9LEb0/Wt0vSZEu5/XEkp+5tBRUdI6ori83nw/Enp5WvW+LY+j5Bty30UlQOrb/FTAtlUpEcMKGwp/9D2cv/fGdG37/oh0dBiwz/5ibrWkHYlProgXeeInDG+LwkqeVfWdp3tjg0G3Tq2UWMmPXPuUQeNFsX3YwbiYzgAR/ZPw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10996.eurprd04.prod.outlook.com (2603:10a6:150:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 02:13:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 02:13:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso1Ue9PAAZZWkmtSe1X7IJrlLRubSvAgAIniYCAAg2gwA==
Date: Mon, 25 Aug 2025 02:13:01 +0000
Message-ID:
 <PAXPR04MB85107C52F0CB3A45943FBEF5883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB91850A2E4ED6ED29D45BF27C893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB91850A2E4ED6ED29D45BF27C893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10996:EE_
x-ms-office365-filtering-correlation-id: 964e13ea-dc10-4a82-910d-08dde37ceb69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6+cWmoGPjjRS3pz9a9wArFFGpPKJpisM4fACrcDyoWcpv21W5OmJn7FrTqfm?=
 =?us-ascii?Q?mbHCy8Kv3HOpkjuw8X80a7Hpudyrh5SKVbBoh/GTS1/RZ3VuGawTTbJz27Qv?=
 =?us-ascii?Q?sV7uWMOJFUsc11a9cOxhf0Ne6Xh86VVZ5Ze7F/XeOG3u4G0ialvVwavCIzBX?=
 =?us-ascii?Q?VEgH0I9rfAhVvVn8bNp/7OFwkhOIvurgtpewC8AvC2IAfFyWqPsz2/OxjrGH?=
 =?us-ascii?Q?8rLLOKDkQ85AgVa6PgJpjVzbd3cK//DuzYEk3U6B377YC3eBfwWIbFw7ZKvz?=
 =?us-ascii?Q?SEMNYruMPIYiI2trjyZWnvTzGDY75cGNt9qD7gYeEIrMONc03t9Q9notLBdT?=
 =?us-ascii?Q?0l528KKtsZQZBNfECBEOK9lFt5cSy9oxYNosbSdFHtDP19uFae2v2x+t00xJ?=
 =?us-ascii?Q?3GBwX9OKATQWpvbFTj3C22r7MLcNo3JadCo8uiwwpTApL2+GOHt+GB4uFDUk?=
 =?us-ascii?Q?bckL1sL4SS9CUbU/mWgkEoiXwDL8bXZ0TCcSMErhVxcqCqLIHmts99yRCXM1?=
 =?us-ascii?Q?SjEjM9cwElF38l+MSFyTFe3p/DGEcSgM0D6Vdf5sTb1w9gz9Lg1/OZsTwJ1j?=
 =?us-ascii?Q?vb1jlxzxjQauZlIxrZNRjOpKuBRj8vnlt5ojzV3p+s9Y/E5EuNc5fYpVot+m?=
 =?us-ascii?Q?IkTaKgpno1Jp70ioEsm1iHHWysdR9DYpgburzAZrgcI7yIKYxp+DM/rgyzTE?=
 =?us-ascii?Q?DyPikTqd22EOh6dDq7rn4qudth61AbnrUS4aGWJlUdv+fTlkkxoReHbPl0uS?=
 =?us-ascii?Q?eOTWpFXMAYG0/46T5jKG8MjYNCz9l9bDX+xJTbNwndDP+kH+Jq9IBRNH0so8?=
 =?us-ascii?Q?aD5mUbFsWH4N0+1JFd0IdbjfdORAHQYA1bidSOLVlyTbWe2VHPG5KL0n0hU2?=
 =?us-ascii?Q?MAfUTTY+ITZs+7RQUw7d5pCNxmRIKdGREIcQXeMbDju0AShSRJH+0FvOYsj+?=
 =?us-ascii?Q?cD6VCf02DC8DnQlYUO00JdNZ7wB9AT5D6VbFM8YfcPlxm8u7Hi5go5HC+GLs?=
 =?us-ascii?Q?YP1ACezl91oSPJb3mA+kkVUwORDVmhEvDJqt+GKuyIFuOaOzp0iC8JUXflOD?=
 =?us-ascii?Q?6cXotONP8uVhwxjoFXryC6WZfgxkLv3dJKZJ+3157cyNMjUTKXdqI8rCPicr?=
 =?us-ascii?Q?0BrTn7/bew2farISszgOGD7A70OhtXPHskAOk5vjik7vTRJRF7dLycHRyF9E?=
 =?us-ascii?Q?UqPJ68GRy8dXmqABk9Eo7WS8GJWr4NMQdbAL4mzeTZT5v8c+Pf6i44B2N6It?=
 =?us-ascii?Q?A03TDtsJ+QK1e9HBwrGA39DOpnq8rH7H3L9OrVV6/Oixc8Jc2br9FNPezCSx?=
 =?us-ascii?Q?SuM1h7RMYYLH+elnG5RMJH+iuIpI/VUMy6CHByR1PeeKoe7z5dtvezG798Ii?=
 =?us-ascii?Q?7Hbd9WSejjfmaDKTMsCyi29TuqpIi6/VGK3vbPLlNmKULgkUo6Sc8YMBOIpL?=
 =?us-ascii?Q?JQJ7qBKiHEbCK0xduFJOpo+3qBGmQ0fOfFdyL4yL+81xsokWnAHvHw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GjyY8mDzqEWfm2noab3uqheOSsmwPVK+fHgDbpU7ugIAVsU2wBPuh8IvcptA?=
 =?us-ascii?Q?IPdchnZRVTgaLmtmGkELl0pJ6N/B3MmPgIugEsoNBi5RnPSWxlNZ3Sp2JmBw?=
 =?us-ascii?Q?StP/e3QOcpF3JoXG72OHuYggj70wChvJmXM0FS5+uQ4/zT554ulpXxl0+zIQ?=
 =?us-ascii?Q?oOrXaTbbg1cam3Pnmq19z1CY0hY+x/3qs/TklxSUJYBCk6HoDK+g4AZB0BDe?=
 =?us-ascii?Q?TRWrwZ8F32gW95mZs9bCQgj5FLpKS97auVPp5aRL1vCCDbtJxxXQg0AegcQu?=
 =?us-ascii?Q?tnTNrIhtWVCyw4aABTJTGSRkAmb3tSPtCGlk/p7o+ZckzwogBN1VgpMeRfFx?=
 =?us-ascii?Q?Sq/q0iMw0HYCP1fYRbdaxh4qK8u0zqnV9CjuIh5QlqmsG1jsSBO6o6GEMuYH?=
 =?us-ascii?Q?e4wECHkJQresnN9RmTgw2jio6JY081DPsodJh5ViL+KJhO6cFkvbtTXqAjgD?=
 =?us-ascii?Q?y2Z6cR1cSfbZD9ZW6u1va6Elvlf2ooSNNAz//pebSHmhRemZ72OWQ4USnfRi?=
 =?us-ascii?Q?UTtZWW45Z/M1AWJY4QeRZ1QvM0+ie1gzdKAbx2cvUJ0bKkydD17ajbA2070k?=
 =?us-ascii?Q?Ib9/4oQi6SeSm+3zxQYHoDlr/oKN2w/hORltSTHvtLWiYoM0k0zYJbHrtcbD?=
 =?us-ascii?Q?8SnVhgKHonLNz6p+Mt8jaFJTC6Usz1njwMRZPRQGHRGsx3qwOXMRFO/WKkw8?=
 =?us-ascii?Q?aHZ28vTym0iq2+7p8TdKwNXFolLqAqY1bgizEDwXEGn8V95u1fpDT2i3XT5K?=
 =?us-ascii?Q?eDI4eyDVdGVuX1O3lXld18mxLUfq5eancmnunkcdXrXDtL9Y4+twHWnHX1A+?=
 =?us-ascii?Q?zk5B1/Y/QVCyKquA0XG3YkDIL9PMnTqgNxGXzOWj5xzVQUt4w91f/M7hPPlq?=
 =?us-ascii?Q?bboRu11BvFEh7U3Usf6+LuOBKWWgU/SKKJYFfuPZ20VIvZJgsNYgG4loaN9Y?=
 =?us-ascii?Q?an8Z5bqaB5SVspNC6LzESKu7YQldmSO73mT560V2c1FitTVGtXHQEDLS4s01?=
 =?us-ascii?Q?5yMqPMKwDyQG/cFxvWf6/dlJAXSCiVTjhAmTSe8DVRRVYGwBeni6spREzh1w?=
 =?us-ascii?Q?/Bexv0oM78O/gBPnRF3+0OKKt7jBd0NFoDbK4Ccg2YCfLbtVkShjVfMORh1Z?=
 =?us-ascii?Q?mSuAoU1z3xWn0RN708q944dqDlukqO32z4o5QS9VCQNYyQK4thW9xdERaKjn?=
 =?us-ascii?Q?KP0oTC+lYM7r09nD5h3mPugqWadB7WgaqbSbbcdlu+DnSmkqYkSKnM2mbQ5S?=
 =?us-ascii?Q?5bq6Aj4z2hheREb7H1uWTAa7c21DhZK8IfWFhO0iGi/d0cyK4vx77PucEVtF?=
 =?us-ascii?Q?K8JYfFp0QA5FJEDrgn0XBbbm9zdSKAEOQqk3gOGyTQNR2w0+ukqKWV0AtHpY?=
 =?us-ascii?Q?yNMgZCqMEcgp7IpxxblQ21Eouc6BBsXsV3NGjgzV82YLXDGKqQXXwTiJRQLE?=
 =?us-ascii?Q?1MaL9HZJoHr3V8j3+kV3DkcEsiXbrXJEKchdM9voRx456/T/VXj5JgDm5gfc?=
 =?us-ascii?Q?Eyy9hR6vtQ8JYcIefz/haX4eZRPXeywnK8o77zE0LCLORrqMTD2V8eDdwpdd?=
 =?us-ascii?Q?ubPIW1c/2M5rHHcZeQc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 964e13ea-dc10-4a82-910d-08dde37ceb69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 02:13:02.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hj5G68+lWQQIzRc3363M3lQYJEJGb6BL1huuKLKWMMrMHYVnT8tTNkanjxRI15sU4kfpSzKJOIVwUFTElTovA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10996

> > > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> > > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > > +	int order, done;
> > > +	bool running;
> > > +
> > > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > > +	if (fep->pagepool_order =3D=3D order) {
> > > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > > +		return 0;
> > > +	}
> > > +
> > > +	fep->pagepool_order =3D order;
> > > +	fep->rx_frame_size =3D (PAGE_SIZE << order) -
> > FEC_ENET_XDP_HEADROOM
> > > +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > +
> >
> > I think we need to add a check for rx_frame_size, as FEC_R_CNTRL[MAX_FL=
]
> and
> > FEC_FTRL[TRUNC_FL] only have 14 bits.
>=20
> That would be redundant, since rx_frame_size cannot exceed max_buf_size
> which value
> would either be PKT_MAXBUF_SIZE or MAX_JUMBO_BUF_SIZE.
>=20

Looked at the entire patch set, the rx_frame_size is set to FEC_FTRL[TRUNC_=
FL]
and FEC_R_CNTRL[MAX_FL], and both TRUNC_FL and MAX_FL are 14 bits, if the
value set exceeds the hardware capability, the driver should return an erro=
r.

For example, the order is 3, so rx_frame_size is 0x7dc0, but MAX_FL will be=
 set
to 0x3dc0, that is not correct.


