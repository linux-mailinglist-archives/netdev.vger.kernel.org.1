Return-Path: <netdev+bounces-215993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066AB31481
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7EF3AF9F1
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483532FB601;
	Fri, 22 Aug 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcVJ+xlp"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011065.outbound.protection.outlook.com [52.101.70.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFC52F6198;
	Fri, 22 Aug 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856124; cv=fail; b=tH5U0sTnGah88+slCR/5qj7XysSSjPTC544QS+JDvHO+lkjROFHp2SOqhFzf06lat1Ubbw334ngwt26Jb57fruxiaCJ+3oN/T8W3r1NL7bbe2pV4Q0A07h9DDJqzJQmCxVzmfpUSx8QDET4ypGcGnLI1eLdo5P8UPX17A6zyrFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856124; c=relaxed/simple;
	bh=ecGvkyREtvFWs8GAJRReSpD8qis1WM2vmcC2BrmRp3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u4NV16istjHil0Y5O5RoNOYHRQPd7eFaxnEPGh3Va59Et4NoGGyZLTlBrk8+7Wuq/LNDaGDneRHMwU2QMcxBYuvt0B3R9HRhJV+EuIBdS/KB0fEGqFrOCrguS+yHDxORR6nBcLWcuJJLdRzmDC4b15dZZOKZDiHNrjaQ4VovL44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IcVJ+xlp; arc=fail smtp.client-ip=52.101.70.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huTpISQobZBJ4vuc3nV/Vs1pJ0g+Ai5pYFmfOIxsEboMSekNzP8seIstTcxzxfYqcJBH4xJ6GoVOzp/yidV2lKAJi4IdZetM667Js+tSw5Ju3lAioyyOCKtWzQjrZUhRnp9Ym1oEae5vBkGxgroby/mn5lxkQ4d7Bpv72/LocSCYafhY3ySsFj6t52IWJ9qGrTLjtDGKwsh1cIHlOLe3U1NfD/buqTsoGQAawEBpdYgFr7xrZjOUT8KP6ZgRfZ1lHS7U45efXYhd8C3UL5aGZePveKwo/x2ult7iJKqhTmXWNrUFZrd28jayFSPiWzzPj/RJEXJF6b1vIumKFAOe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwOUSQdzTQBx4bboAiqH3j7XN9SGNWLhLKLhl6OYRoo=;
 b=E7WWmr/V4bpyt63hYdcFmysZvL9gd9vlzq/ZJBWP6pZ0LEmCfGaO+ebbzz5cdal225SIN9wbP0VEYo0od0C3n+9hQZ/+DvgAmfkoa7pf4zHF4ew/VWbwVGIS+JVPbwg4k9cBXhYXVmpZFte82e7zM2a8PMMKPvTIq/s1wpNz+8+btfffAQxQamOCzW9krJ+4IBw7/EB3wUR5gARKzmal/PFtgcEJyZs+ZI+zQDEBovShMa28Lw9saysEsP8NPrLkRkaoogRjxeK+4/CIQbEcSVHQd04+wy7ci095jK/tEM43M6FY58CE4yUUKv3Afx831cZ+pC+3hCAGY/5Rxs1QSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwOUSQdzTQBx4bboAiqH3j7XN9SGNWLhLKLhl6OYRoo=;
 b=IcVJ+xlpjLeQmCQgurkHFZk9PLOrHGNf3e/96TayagIUmWhUXrVqiP6DNjgyb67uZRuaXRE/8Jc0kEe77foyL65/yRuK+rh35YtZDT/Y3Q7rTOvDCNL6oK4H1vwr4UdeLu2IUnghBuImjGvGE/OiX7K8qtjiePDMGNiFyVP79DSo3/yVU10I/5ZHtUGi6Yv4IPjwNRTai6YmBdxuIHYaiRmKWxO0RUDFL7UCf1t5vKB0WAUg8xfIBftmAoScbbKDt0Wfy76jZZRyfqUNezcfPxRrt1Ntq0VYXrfKlYy5CzEycioNZslppV9EEwAhj1xo5S7WpKWl4CusuzAuHSEMJA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 09:48:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 09:48:38 +0000
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
Thread-Index: AQHcEso1Ue9PAAZZWkmtSe1X7IJrlLRubSvA
Date: Fri, 22 Aug 2025 09:48:38 +0000
Message-ID:
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-5-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB9122:EE_
x-ms-office365-filtering-correlation-id: e5c0dd5d-b25c-42f0-2cd2-08dde1611203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G2e8UZIlJGSuLyPJi7c3lEOyIh0NyS44T5+cIqL2MeGhbHmCi7fi9VR3seZ5?=
 =?us-ascii?Q?YcN44PbV2fZvk0ed6sPMZ2lzRLhwSLjrk22T10wGFgWcSD3cfiEI7IzVd7b2?=
 =?us-ascii?Q?IyR6OtY2dIi27rNTrEHFuln53RZJFPQgirKYw0nEM2x/ist9L8qNtEhfn3yE?=
 =?us-ascii?Q?7gkNm9hVbfywgmmHcZt4+LOO0SGqiGoS+Oq3Ko8Z+dnekSXmFZ5ZVshv1Yg8?=
 =?us-ascii?Q?yTt/N4LfFAeT2ZdJ1Dyk5zzNH5AHtv3wEM2AlXprJ8+Ajm9kr1I5LzoxgoDM?=
 =?us-ascii?Q?Kyhtbo2BI7YvHIXuC3zIw821q9f6bYfpFQC8qGnxF4CRGmYk5eG7pmaTg1v+?=
 =?us-ascii?Q?Ey1Yz1RI1xKnXbJ4DZ32sfF3WRBkgijFkY7CIpjjGySZ5FKuqRKv4M3JobVj?=
 =?us-ascii?Q?14b4MeDKZNsvaf+3IDEAVGM9cdl5v+oa0r4nnSTwuIebtY1Wnp0bCvAmzvq7?=
 =?us-ascii?Q?0d/fs9AxWiImxCmnWLHGVm3iUQCr7X+qpVfE9Ce+qAWCAbNnH059bOC7PJEI?=
 =?us-ascii?Q?YJFnJnC2HwvwokWMlBxyRZhRQ+tg8ULALmq2mSmwsyR3r/jDaGLUbgO5Eckd?=
 =?us-ascii?Q?1945/6//JHQb2q3zPXGFYaGOGYcW2HiINiGlLbR23y3aBYGoY+BBQCwijtB9?=
 =?us-ascii?Q?8VfAFJ6Z3gGpkL1spxMpXq4xTA+bJ1O/KUV0uoy/jQIyq6hueJ5sZA/15RaA?=
 =?us-ascii?Q?aPX8/1WrFSSMPGrXQjRaXoax2byGOGsune9bTn1/uA/fMzmo2U6nEVKYAb5Y?=
 =?us-ascii?Q?5QYcA/HE3mv8eSnlOM0qMhHI3AgUXxdLpcQN/ySLfNO/2oSPt7+0U0cDStM7?=
 =?us-ascii?Q?qZNnsF45V/Og1ENLT90ZVpOM3X17kXHPkQqTXu8DmnjbPaqdW0mJut2LzhHI?=
 =?us-ascii?Q?U1wFN4/MkJKJRcFpGgkPddo3DVhnkwFCcDOzV9G05vjPsGpaQmrSqieQQ4JC?=
 =?us-ascii?Q?2du7gynSmsubOgmYC2CrC2Xty+0tYb2Gbat2jstPJPTXl62VuL27sqpsMYBr?=
 =?us-ascii?Q?oZakvxdmNwKgdI7xlabvMXiXDP8Z0cFldQJdR4zApzJj3frKzK/sQFDdIBRG?=
 =?us-ascii?Q?sKbEJkKEyvJHWeqLqHwtVoGPZPuLs/HJnc0WJ68A61ktCIjtpeb/vuIDl+S7?=
 =?us-ascii?Q?A9usQjA9jw+3zQZDjIVrRv6Dgp/sFM5gxKN2mxccOukPxvGLxD+MG9ymJP14?=
 =?us-ascii?Q?aTZyCfxVlMW1Poo1clanK3Pe5RDgNQCMfBZAkT7TBkWvgwdA0ZRE8GRE/ytx?=
 =?us-ascii?Q?74BPz4IdRqW8NhNUnHcKe6gbAaZ9Z4IJhewxhQSx4SD6ZyDEbhgZvIz+3bjC?=
 =?us-ascii?Q?LwUMJ745AXccIM/3rkHfDBO8cfBrf3+ySLuTai1aBthMr9N5/c7VKAXSyPL8?=
 =?us-ascii?Q?HAIGUIVr7gKJT37PmwFTMoRar2M2ne4ExntlWavKMLdlAWuCaQV14CpStvLw?=
 =?us-ascii?Q?4ZvOFvjdNDzStxWsSZo3mfzPhvKLLunjVcDFHQh1WLdfmWzrhyXiRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VZZRCuPIR0kayxfgvQQMJ5i2HZSPTsZHfOSgHZiadaNTSy0fSwswfFyyrahe?=
 =?us-ascii?Q?Dx88tpVauZMf/0p37MYcwNjDdzMzWnveDitQevE3H5qW2OayJg3xyX+oBd6V?=
 =?us-ascii?Q?LeGUeb7Nd6NlurR+YLmVZ1WFAR/XwGiTkMynzLHUoBs3DNwzatt//behTAhA?=
 =?us-ascii?Q?jMbuFUZIRbtBDnZq/OdnUTTjHHmVT3KK8TJYwotYp/hhEPX9AM81k6v4tqYe?=
 =?us-ascii?Q?42domiZxZ7Ezw3gO0n3LWNZXwC5Pm6OMD8e5zoTh0pb7wC+izSG9A3ssmKIJ?=
 =?us-ascii?Q?sVuQO+RYLMjJqRu4suA10SDhruQcbHRlsFTRm5JtvBJOU2a2VJEsT5OYC+F9?=
 =?us-ascii?Q?TP8M1i9m09/UaTEAaamPWqC3FE8NtWyec6s62w2OVeSWOuP3WTHNYA3Q63p5?=
 =?us-ascii?Q?xRNJ9mK0JfqHGa17CdhAlxEApX9Sld0F3XMMJ3f2evtVf08kDvOke3ylVuMe?=
 =?us-ascii?Q?1kQ/cfjotEdTBNt6ByXFwH+JF4107jtkgmnsjcCCfOOpZQqxidQxQmjjLEiD?=
 =?us-ascii?Q?B9vlndngsLuy/KHOow8FrLvC1as6Zv2z2epDEig9vpY5RLcpSruUEiQCO+Qz?=
 =?us-ascii?Q?669ZWZM4L/1oB8hpnno9pfRys+plr2BpXoh6IPAd+tIlGD06YDg1dV/geNKZ?=
 =?us-ascii?Q?6+llEZn5I6AcJoLhB2um3Z+m8hbEPGdpSggmrijNR57Dbtnyg8qfcspHrEM/?=
 =?us-ascii?Q?F8v9/SW7D2L8KuuD1FWQJvB+c1hc4s8ZK2eKEuJuufD0d1hAtj58sdbbbecW?=
 =?us-ascii?Q?+7/7SenUWEl7sW/vXQRxTkXs45ymDjeonG3Vvp/KGIKx/xbzwBa+7m/oDpP0?=
 =?us-ascii?Q?9eJBQfe6KwqxOyBR+tV6wH48jpz2xDWFlt7yH+BLl6LF1HAZBl9iSwhIwmuz?=
 =?us-ascii?Q?BggcU1W8/f18e5n/ste/TCQU565zHec8yXbvOwsThQeX4mzOsueZfDnDHuKl?=
 =?us-ascii?Q?8xRZLFp169au1u5PpdWOX7QDmbHk8diSnzKVzmCD+rx4OD7OPa308MFUfeF6?=
 =?us-ascii?Q?bTLgzY9rONTCkX5SXEwrjWJUR0L8RKoHnHSKSqKqZaJ7jJ3upygSvi9/Eypl?=
 =?us-ascii?Q?wyyNb6vUGYWoXQDk1uP/tBmXfdZr6JlT388Ped0heyh4NN/oIn1JHLo8YtSt?=
 =?us-ascii?Q?rzZp0RRIOrp4bX9C+SoyCG+9kKQX5Rt0wqNdsVZpeK0crsxD7D5QwxE2AaKP?=
 =?us-ascii?Q?V952R1vXiYr0xR9TKOlXDNj+KgYqbUSPNmHC7AUoN4ZgtXkVoEBR+OQBW08M?=
 =?us-ascii?Q?MUeCA6puLeHE7KpRLxO5L7VNKq2Q9tsAzXiDqNf9qxw6V9kilCU+F166Ohpt?=
 =?us-ascii?Q?JPuMv/yIDn7MhwDwqP9lpkXFbCcHiJTsMEaBy+K8OJopUa94tJ+a1pEM3KAy?=
 =?us-ascii?Q?0+ebeySGOz3t7lDqLCx7OpoO5s71dWp0F86BVMf6Fu4m1HUlzKe+JvnpSYox?=
 =?us-ascii?Q?UBzFigCbEBqjtunzJOrny7t3AjHBKApFpTXmzf6FZKGxI81Y6nNcD6ToWhua?=
 =?us-ascii?Q?ZxmkAsglcjF4vMGy7vffb764ZrcFHHhJSFNuG2d2YuaQXEKrcbF8vGEycHwi?=
 =?us-ascii?Q?OhUnX2rLQ8iJoSbcbQQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c0dd5d-b25c-42f0-2cd2-08dde1611203
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:48:38.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+1QihygGH8hyRoTtNvFZtpRijH7faOQ8cfzhghk2Wg5DShs3B/KvxED/esM8X0pIzkLqTi9807YCg9s54jB8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122

> +static int fec_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> +	int order, done;
> +	bool running;
> +
> +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> +	if (fep->pagepool_order =3D=3D order) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	fep->pagepool_order =3D order;
> +	fep->rx_frame_size =3D (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
> +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +

I think we need to add a check for rx_frame_size, as FEC_R_CNTRL[MAX_FL]
and FEC_FTRL[TRUNC_FL] only have 14 bits.


