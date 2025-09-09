Return-Path: <netdev+bounces-221043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2BB49EFD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8C47ACA1E
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541A24466B;
	Tue,  9 Sep 2025 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OK8xxdUe"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3520FAA4;
	Tue,  9 Sep 2025 02:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757383933; cv=fail; b=fZXj+HKlZAysQ+qOBLHmHnlDfECrZbI/gIj4H4aJIQR3hQDo2ScvT70tRUtAgYfnpIV75v2gROVOeNvgmcBOib8mAHzDfE1XMiu7K6HqJqg/DvPHl5bX2x3trN/MvyIPpgNY5dnpKHvfqkTr+dRfnRg4Tvt4/p5fGl1WjQCqur4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757383933; c=relaxed/simple;
	bh=e4PADGzLBh5PAyBxUxr9C7A3EDJhg2uiZAhiUA9EA34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QlLXNLDJJTo70Z4pETNc71cZH90hWUu6UBKYAXs3taD/UMhnX7ihU8+42JMsYu0wdl84wZ7bvy1S4OWpZmNjz2JCam3UqQ0ntUSgDi2C1XXfn+17XmgaMIympiLsD3rGEIMpBmezylZlSjT95e5V+T3QYjXiwyYfeL+2cYOqx08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OK8xxdUe; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU+fLl2DHgxtMQR0P2lH0Fp6GsJCbeAruoI8BRgLbiZeHEp04h9NF51R/k5qSLOtRKC4KrQFJiRmaDTH4Gamhw+9Qq/sWHYvdyGOM9Kgs6NZV4sp+yQBhbaTIu+THKvU9Bb0EhvO9RlPE294q+0mHupZ6hI1kyKbNF0DMEyEYx1osNFvsxz+5WgfDqdrfO7sEvfgZXopr2t3rPwcM/jhjplHyHKsl5tfUXlTPOLOOKRA66rEkOxkwQwWQF0xDokweGzN0UxKrrrDtFONKT2MYwSC8g8UyCcvS/KQzHWrwSY0M/ELRSd1Gk+WfywbEPYv0ekhuNzcLsz5BQCmpE6GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMsErcfqslu4Yj8knXwFO5606J/wEWrqBWzfzpFgYWM=;
 b=l6IOIeK8n9crPcjJ7xRhm58yFMmJrC/vbCKmwl6sryYUBkkgkXtcA838jWJdmsxGefGd991HXR6riaq4NK9gCSnfC5SN5XO2w4F0FX3R6fKbo+RfS2Sla+t98ws8p4pyGeoK6+KTaAL/8ccJ2ea/D02BW4L1jYjcRygJevQhcZ83hQshQ71U6+HIAHQkTibF1cGXWtgWse4DHQsG7UtAOJyYoIgiLUkcQPO7oc34AK77AUZ5vY4g4+AvtoB4Dh1S0yhti/MbcMoDp+k1aXcpcKmNJN2LXcp6Ds/RxRZIrDwO1iC+u7GBauIjc1gtfL1OwxcwMjhIrXJJowT3UQqZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMsErcfqslu4Yj8knXwFO5606J/wEWrqBWzfzpFgYWM=;
 b=OK8xxdUeToiLqbUfI7yNjvv1YpAU1Qc8cCLAltcN6bLTZZ+08ywgEX3ri5d8CF6xLz2u858R1D0vYG/zQNCZVJV04ad9a33ciAM+ErQdzP2bJfabQ7g0FcyNIO37327/SrC8MdCI2lq1DQxppH2NZetLZjF552p5dPrtBPYOVmuXQOjYZFSjZYx1IRLYc6bEe54KcepjCwqzuS5oe+U4V/lk9Z0ccPGmKonqrlOLDzeXRnd8tRCD32Oj1dGrhtpOfQ3n58DZm+0m3coD/GfZPdhzFnnIpGm3kuqQQwBXaLcYnm1LSUz+UbXsSOQVEMD+CfTZuA748HZ5HvvE5y7gJw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by FRWPR04MB11272.eurprd04.prod.outlook.com (2603:10a6:d10:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Tue, 9 Sep
 2025 02:12:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:12:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Frank Li <frank.li@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcINw8WFVpNWz3XkGFt7EQK+FfVrSKGSmw
Date: Tue, 9 Sep 2025 02:12:07 +0000
Message-ID:
 <PAXPR04MB851097411AD8CF1B4250517B880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-2-shenwei.wang@nxp.com>
In-Reply-To: <20250908161755.608704-2-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|FRWPR04MB11272:EE_
x-ms-office365-filtering-correlation-id: 8d374d4f-c300-4702-8bcc-08ddef4646ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p5U6XJZgQA4m4LSRO/T0dDyq9z8ASJRPYCgU2rbDcpvIt9mVK/Pryfvclph4?=
 =?us-ascii?Q?EqBqb6c5q0VesYlmBZYLgr8zP6ItO1+qwMkBj86M/kqtuUIoFQhm+LIJ5/U7?=
 =?us-ascii?Q?Uo67k7LrnGu47VcNbSoDjjUagf499BaA5tq7Eh32gITb0CiEy4qtpiEr6Duf?=
 =?us-ascii?Q?pGjrDdJW55NAF9gEXUmHN2pk12BZIX9agj2SDc2GQ+oJeKmXDT7DsRgVZjGI?=
 =?us-ascii?Q?A7xg8sdPNsDx+qiFsUpkxS4ggJUAAP9YkPa5S4KVGjy1ToL2+XUaOl1ESV82?=
 =?us-ascii?Q?ci5pZlyDr7mvUNBJoJmbrJ3+bjQuZuCY8S1FZ61kCpKQ25oKZ8P+s2uwoCBA?=
 =?us-ascii?Q?iLPZg7/WZQTeI7r3P4G68rgzvZ33o+/cES6HcNyHOj9CvvWYPyjjjbgpaSuP?=
 =?us-ascii?Q?LRzV9BNfLXGit+YmyGFYKs2M/cAeSXw2LLm9cylfYYjOKR4T7iLjBrki+S6y?=
 =?us-ascii?Q?G5eJ7TVbiSwdOk1kegx7S666sSwG1fBS6am64Ksx91ZMhuuiSWvJVERhil0I?=
 =?us-ascii?Q?r+88X75Y7wAbMJSHJgDTI0Z1dxIb+Ho07VnV+57CZcUI4XTNMj3HfT3I0VRW?=
 =?us-ascii?Q?4FvKuNvI16KvbtR4Os6zPt1jrjOAtMSuditRImsbmjt+RhspkSwFVoy0poI5?=
 =?us-ascii?Q?FownE+7vCCms0h7qpCkPRMh0L3PKXn7chkgD7agDXqXvhlQInaknLq5Iskzf?=
 =?us-ascii?Q?J/L2CgTkSjArXS0a/oElOJztHweuCQ2igdvskX9rNVTDZP9IYEhvCxbCxIiJ?=
 =?us-ascii?Q?AlRrfsSWZkRAZXZxzXE9lQiXYL1bMENJEQIOQjK4Ku9P6ubXupjoTQLNPT9j?=
 =?us-ascii?Q?ah4ulJOpSsmJI4BbD1zBV0cGuSSBZFYTjse0BVg9vxmPS/7eYUwr8lf+88cM?=
 =?us-ascii?Q?vzG0mGxFLPw1IVZxWXjJviBhfjNHMnCK0S9WG0Qy9XiyYo/9hJzcNjFFZ1OD?=
 =?us-ascii?Q?t4PRyALqXwZqsfTV6+fYBaYokV1igIAbrDXQdseBbjv+5aGSTqnIa3TvxZah?=
 =?us-ascii?Q?mvpN3yRy0q0oHhLhJmHqgAclUjEqb4ISmdCp67t9p6N0lI806AhP65oWGX9j?=
 =?us-ascii?Q?ACDYiWJaXoUCu9nQ5uPa1efQ8HMdiGaN0c0aoGsC0U1G735ZHm4zr9qCBmhp?=
 =?us-ascii?Q?QjH22ctqQBhPMFFJQ38nvOsyYuWS0knJy5Ye4g2Kw8DX4Y66gheBaIwPopZG?=
 =?us-ascii?Q?L8JjfMVJwYKiO6vFLhdBZJamJhLhht5JpoT1FtxVDpgqp06bw4GlyMdn+9cd?=
 =?us-ascii?Q?qJ1Nry49R+azcXDhB0ewaTLS02wPHjonez5OWDkIbWWFRQ3Rs0CcATNNvlHq?=
 =?us-ascii?Q?HlGUq9oE42dRELPZqEBRI+M5Z+IFmwbcIIF62FKNtBfAJpDRRgdJjTClfjJm?=
 =?us-ascii?Q?Vk3YG+594/1Yr7ELw+QsIVMFgqhhTg9vRUNtGDA6k3KcOnzbe8hc5yKxZWgs?=
 =?us-ascii?Q?PnLRo3O946WrXLAzzD+EV2gX5++4yXCgrJbN43PoV+q6UFlyz1u+N7SfnBaN?=
 =?us-ascii?Q?vvLNyCmHs7S4fZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yr0Uz1+T0sAfM6IVqbEeAqKPJ2E/17WjTklirSFPprgmN4VWMGB3fmYlXX5B?=
 =?us-ascii?Q?4ceFp+0pa9Ddnv2Yk+TEAx7OVs35QwYNdLmU8dzU0a5ZLlGDHZNB/kdSFsAO?=
 =?us-ascii?Q?hM9Sr3IOGT4d5tdQyg5hkelqcgq/xx1q86SXCyDpQbnkq/WbBJsp/rUGkuh9?=
 =?us-ascii?Q?s/X/12joAlwh2fZpbSeWYUIjdVgFOLrF5KE+trmsynjWgrFAXcjH9Pkzzt/g?=
 =?us-ascii?Q?+IDvWECz2LXS4tV9W+QT37u9ExKYWXNh36PtySGIVXdFtVzfvd5R5jrJbZhE?=
 =?us-ascii?Q?//EtMAqlulpfc1gTEjzkNftbqHR2vBN+Eey5FmVoqNG446tXHUEMl5vWgjA/?=
 =?us-ascii?Q?Fyc0cZxtTq2/+kZxcRPwwNVB4mqXADgZAcIiD4r76mE9ZyelLgzbcPNXKcfI?=
 =?us-ascii?Q?my1nwcbRAsw+JiBz8F+QBe46YO/LyJToZlK4QBoL9b99mcmX6oV3PhYNvTCJ?=
 =?us-ascii?Q?Vrvr80Fg7Zz6eCZNChZYDSnvWvUdl9RFDY6dUc8K36sOyeSHJ5RQG/TojPAQ?=
 =?us-ascii?Q?esqe8V5zdaQKtex0quHqkhL4FUZZmsiDEUqn2khObrcVO1W5JRGTsS+0HfrB?=
 =?us-ascii?Q?Nn4B2h78FOKc3INWj/Sqk3AImKbV1uRSSA4x/NuA2vDEcKbSpZrOX5suNnBG?=
 =?us-ascii?Q?b8VoRTiTjzlR19Di6kosYe8FgqMMfHo0I2Vn74UE7DzyeJ9LnOcVfWJ3Ubq/?=
 =?us-ascii?Q?BxVZLgm1trlkmDzhyGggdRUYjG2WqFZKZsEW114muNrWisag0QnyppLoqAgX?=
 =?us-ascii?Q?NlIU4LED3p6dio7s+7tY3ZNy3in0XfBc9sz60ZENaDhUhHpB2DdIqtbbErXZ?=
 =?us-ascii?Q?efh201cMzCLYc8VeuG8t5J6Iz3nla/LQcPaVedQjYrrgGQBHoaZVm1QKNtF/?=
 =?us-ascii?Q?bF49y4UMu00oHT22PY511IMllOKqe2mDEGUUtySUYNzWhviSwGimcLLjF7+p?=
 =?us-ascii?Q?qLYtMYUlwHyxAIgSqHqIuoLKPiC7lhsnS5AgeUMtssCV+TmGa4LuMDUsP7bA?=
 =?us-ascii?Q?XoqFuSJvqfiTKdGCkWmBRpQQ3QGG0D4d3ARO7Zq+emdnsSmSB54WcDALZ0nl?=
 =?us-ascii?Q?twlezRN4C3mfRkfHQFrswhnMnfwpP3LEGDlVXMr8XMdsPF2bBWHtSPCo8hWY?=
 =?us-ascii?Q?3m5yFNxXJKfuafLwo7lxkoWfrgiJvo9QrwA5GquJyxRnyu1uQm0RDhpqXnyU?=
 =?us-ascii?Q?OtncI5udDNvne8HXa1EHHekfSwTgbFFn4fjWzhDWBOaiWwTuBcyzATdVwYA3?=
 =?us-ascii?Q?hC5HRdY2gkcaxqmpdCI26fw4AXvG08RNqIjQ1FQ1WEQVPMYNpaAH+B9U2w8T?=
 =?us-ascii?Q?lmX+st53nGBwSyoDVuqiHNmJoLVAa9XpBBK9xLLnDAG6DxNCjST91uvRLmsD?=
 =?us-ascii?Q?VzX19VkdPJ9AzuybxHi8JAZyXOq6mUnOj1wDo7UhZs1gu1kXFzZ48bgiHFH7?=
 =?us-ascii?Q?JDqpW6d1HXUD7xzZYGyyP56cnCvQzIM6vn097Ky3ma9rfdYFpUgmzUw6EvdN?=
 =?us-ascii?Q?BjB0ult91i5EZh9vvwm1mSQP6j3i5G4nM9nrug/BE6kJxdf9FqSyXHQM9Jwb?=
 =?us-ascii?Q?EZsCOMZ/yai569YK+vo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d374d4f-c300-4702-8bcc-08ddef4646ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 02:12:07.0566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2eiN2gCQWzJyfCHrqVO5J0/oOFvoZU7P6Iu62eu0jRAlU55ISf2KwbPpz3ycf3wTaHuQkT+AbnzK2yR9PEdiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11272

> @@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC
> address");  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> defined(CONFIG_M528x) || \
>      defined(CONFIG_M520x) || defined(CONFIG_M532x) ||
> defined(CONFIG_ARM) || \
>      defined(CONFIG_ARM64)
> -#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
> -#else
> -#define	OPT_FRAME_SIZE	0
> +#define	OPT_ARCH_HAS_MAX_FL

In the fec driver, I noticed that the expression "#if defined (CONFIG_M523x=
) ||
defined(CONFIG_M527x) || ..." is used in four different places. I think we =
could
add a separate patch to define a new macro to replace these occurrences. Th=
is
new macro should be more generic than OPT_ARCH_HAS_MAX_FL.

>  #endif
>=20
>  /* FEC MII MMFR bits definition */
> @@ -1083,7 +1081,7 @@ static void fec_enet_enable_ring(struct net_device
> *ndev)
>  	for (i =3D 0; i < fep->num_rx_queues; i++) {
>  		rxq =3D fep->rx_queue[i];
>  		writel(rxq->bd.dma, fep->hwp + FEC_R_DES_START(i));
> -		writel(PKT_MAXBUF_SIZE, fep->hwp + FEC_R_BUFF_SIZE(i));
> +		writel(fep->max_buf_size, fep->hwp + FEC_R_BUFF_SIZE(i));
>=20
>  		/* enable DMA1/2 */
>  		if (i)
> @@ -1145,9 +1143,13 @@ static void
>  fec_restart(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
> -	u32 rcntl =3D OPT_FRAME_SIZE | FEC_RCR_MII;
> +	u32 rcntl =3D FEC_RCR_MII;

Nit: please follow reverse xmas tree rule, move this line under ecntl.


