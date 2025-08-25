Return-Path: <netdev+bounces-216592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3146FB34AB3
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFC95E3F0D
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7985427E070;
	Mon, 25 Aug 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hHa3EvXA"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4317327D77B;
	Mon, 25 Aug 2025 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148262; cv=fail; b=OXleabzt2QLI0VRkBpshpkygE1Ao99eFq00tQCCaFJle928/k6ieIV6wLhrGuq5DnvrrPlSLeHbwbasBiZqC/LRCx9qL1nec0IPnYAl/wznFs5mlbj9iu/QHEjysIdKMTeO9ncA/QKJIGrGxie/Zj/Xjd2+wdmCqZZ1nUI0RdQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148262; c=relaxed/simple;
	bh=ptQ8oh1un42GYn/kK9PK+kOakGz2Z3/kMGoRTE1i0tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H6O88pa0lMDfgDzdPjqj+bZb9SqY08vsHory2XKtNrfDDuVzKj5xrx1LzczbAJIO4QtzsJwUxIF1s2xVrec8UM1gG9BNSmRMvILKy+cDeAJAN2yRxCYVMzDAizhsNDJKzvvN2CX8ph4l8d1XIto1I7qlNY5n3WHbIWL7pfdthfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hHa3EvXA; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keDCCkWx57iQ7xa1Fy0fpnYPgU3O8r1HtcPA1db03ncFmRgI+xcEH3OuH3hxk6vKgq3xh56Ou2UxcPgfC36HEs8xybZSK0SYYpVRPJJao5+H7wteRI0EvHRIYCVvA46P90gljGuibl60Gf/e2AEYKublcsd1qGF1sMuc2dA16lf03Yxld4siK29zHtdnrtpXao9oPOGJ/VhwTz6wp3kkDWAC5dmJV+rfGVFXbMeka5j2j4zal/2LexM2w/ilCgYsvj7XhEDn0EXSNK+ELpZ8OwZrwbzbsD5aZ5cyB2NjPebYtIudhQAmrmvi5bM4b6qwvgYSY9HL7Ue4dC7E41ag7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n2gJBrvZwbqKwwnnGAJ/L+WBsqU3gB8jR+lr2Em6KU=;
 b=SUyG0vPerhkSw8xg4hTTZNBTOir/hIe3AYHZER8nkk42mjJfenGW+Dhhbm/8O4bceZFMdM+F/ZQX+RPItp7ykb4sA0FHoqe4GDY9VLg06yBRhLHTuOrusOSJ2/G8YmTuUNUvTYlrAKuwYS2rSbqh/JrhyK9uGOB1kgPXPdNyOevk/99RvWWlasaJHUVB1gDy3QpM6G9KW8mwY9Rd52By6lynoujRl2djUvuEPGPkEXIMSYFnWM0QRVzSb7Tf5fZCl+1XA7Mgvq1qqZwGxhKcODA+I3Egl2RjM2iAJqYpME3ahE6TaCoX/O8D1dWd7OPTPcCzyBLiEPOvyIhJmAF2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n2gJBrvZwbqKwwnnGAJ/L+WBsqU3gB8jR+lr2Em6KU=;
 b=hHa3EvXADxQZfXmWj2ynLwfsnrNSTlmje4ZauzhSyOq/D+1aIhmNNOQ0fF34k0LsXlPCEI5w3oHqBcVCiYW64KYtBLWBadeCgKqyVdWSJNxeVxXn20laooQPwF2tFl5QIFV/YHYIwg208XEcdP4tMsN1HJ8EYfDPODdqKNN0VYsmGqj1PrWUUvIxn+ywgLoVkz9MRJpC1MHYQC1d5GuZ7gi/ZvEHSsVa05A/ly+LscGk/MVgL67+fgg123rxiqxxdxdL8wTFdohlP6uEM8EFVlrijwFG6K3af8iocNekTWfIz/SL/S7j0nq8ScChAPGNZ2Ept5LrIw/YZzuBAMd7ow==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV1PR04MB10726.eurprd04.prod.outlook.com (2603:10a6:150:20f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 25 Aug
 2025 18:57:34 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.010; Mon, 25 Aug 2025
 18:57:33 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcFGBov3FbXmAsLUaiStz82CLxk7RyrDEAgAENbsA=
Date: Mon, 25 Aug 2025 18:57:33 +0000
Message-ID:
 <PAXPR04MB9185AFBAF4B57B94612E0378893EA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
 <PAXPR04MB8510E7FBBDFD975D1D175237883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510E7FBBDFD975D1D175237883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV1PR04MB10726:EE_
x-ms-office365-filtering-correlation-id: 80eb895f-4339-4d19-33e9-08dde409400c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JeZAZ2/hqwyOWxrobcoRnWqCB4V1RTovX/N6cmqHhj2aFyFkMJzY7WBFVEO+?=
 =?us-ascii?Q?nskRRAod4Inysm1EG0m6EwF7CUqFk/pvTrj1rK3W4zprOtsCa+WAK43me0XL?=
 =?us-ascii?Q?Xss+4T+lJyAV5J42IjKhIN4W8aBiQ+kVV3RTVKF5UHPHy0HSyPjiDNdz4TD1?=
 =?us-ascii?Q?tvclrP2bDLpkErgGo/eEpNwJDUaJlGBf8X9Gx3hxSeb1o5mTRICHRNnNhRfB?=
 =?us-ascii?Q?gj3DJLwF/mbj7Tr2hzdMEORa+7DKJYmOG15wRDfKEvtslXhfTfoRbGjuaBKS?=
 =?us-ascii?Q?hiJEOt8LBLi2zbQlJ4+t/2pFenoYJRlp3g43fPMjzTnt+yHCxOGIyViDfVfH?=
 =?us-ascii?Q?8nyXFBj8Bq8g4WEgwWigPLNKjNoWjAnRRXTQVcGwim/dO0GkvS9KA87wEH7S?=
 =?us-ascii?Q?KtnLVqAXnkt4L4s0ouLxqJ9lUNoiiZNCPtnJiD5aN3BdD0kiqvzK9z4pcygf?=
 =?us-ascii?Q?GjusVyEINcrhuBCvhixlD6k4xgogLVOA9W7IpUS1WIyBOCATukn0MTKBYmCo?=
 =?us-ascii?Q?z3v4jFaVhN8uanPIBFbClnFsXBt7Gk5UjOiw3huDC01j6XKv3Mh1fvjjUHT5?=
 =?us-ascii?Q?TGSVezgiYwSFxtiEOKNSWoPqWFg6YznQTtr9nxoWPEYHP3zLBdCwMn7GdrjG?=
 =?us-ascii?Q?NNlv9gWSaTWYIA0yF9MkzihbGP5nrXMS8BICVwdlAQPhl58q2iaU951XO5W/?=
 =?us-ascii?Q?U35qwqzT+NP/zaNUoY1Fd7mQgeEeG3/Cg5nQYYVYm32cCDgEm3UTh79mGLKk?=
 =?us-ascii?Q?kSJNNjLYFyO6PRXmT/IduwuUAYIzpo4uLordb0l7+0UmkTdixvBREKeWWr8V?=
 =?us-ascii?Q?LZJ37tFbaefmAxoXVIiOHRKr0em+iU23Dug5ooPRefxc+0SDaDRFw2C9hJn4?=
 =?us-ascii?Q?8QegSaVu/TD2TcLzeMqAcq3lsHnGV9UgT1EvY69eOLXo/eXMjmkeHB7AUZMn?=
 =?us-ascii?Q?uzEReArOiLwSIO5Jjz7SmJRI94dQA4WRSzaCk9is+eO4mIyYwL5J7W1g2Cds?=
 =?us-ascii?Q?LJt+zYuzYbn0kH+BwXARgiyfVnAqd0l/9OXLq2BBC+i+EyQ3F9/FQlsTN/dN?=
 =?us-ascii?Q?0h+OdqYeAIocB4Wrf0qNFaS0Pp57bBk5MqCLivp1HfXyeD0ROg42jmp7PwAD?=
 =?us-ascii?Q?UxcVnMlm1FvM4Jh17cEB/Trij8VX64iM/qxD4GzJmlxqWswqDO6T9pr0EtX7?=
 =?us-ascii?Q?2XX3AU888HcJCQY15xdRZD+vl+/2COIrC5E9vt8N/YPGxXaYctM/wvQjD2Tu?=
 =?us-ascii?Q?wcKpum5h2FG6l+kS3r05OfuG7k1LngIqPgVh0ZwwOGQF2EJCADaKYqlIoIyh?=
 =?us-ascii?Q?spErRQbqE7uk4vIQgdUt1wxJ/UXZhAEaLBLmyVJXkW6wIBgcFR91J1oyeh5v?=
 =?us-ascii?Q?H4OV7DcATbvcWSHHqBf9MONGqiInx/fnrbc7mdFdkwwBHuqqrC3gWz9k1hW2?=
 =?us-ascii?Q?QDdcu6k7fyWyvZumD4bapEzYS7IDPFHdCCgZlatQbFZGMPW55MS0rw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h6bcrDlg3SdTquD/CmTdhoAgrL8YZ5Quil/ftOTBEgX6Tlq1CEs+NChE716Z?=
 =?us-ascii?Q?AcpP4nwWY+80rKihErRQ3F1IWcztQWXDDAa4vnAEEdYRQucQ+RtwYWjwYcBc?=
 =?us-ascii?Q?BYgMEvHDoLoSryKjGPuB8e/Bi4/cRK19uQfcQmrFEoIYoikDuOe45rHApf6k?=
 =?us-ascii?Q?YJw9dA0YcXBd1Hex1ggmsrEXDzd9WKQxtiR7D7BvWU9ByqtbSw/uBva2Wf9r?=
 =?us-ascii?Q?Q0lfhmH1NBnr2yqGadQgGRer/9A7xNHOEJRwGZltxlPl+7NxWd6h7Iq3fnO8?=
 =?us-ascii?Q?fHWymdc4Inr0nlsX+TT8NmVWAIDfangzju+avPZrS5hueHmyyllFgqDyznds?=
 =?us-ascii?Q?4LPrFzxtzhkZoxq7j5jvbKRe5i/JUveu+thwNosRo+F4SUjMC/BCNksFh1b0?=
 =?us-ascii?Q?GQzEXErrHfkH2Y80JKSupp9bIbKb7cu3uBzhVhLaS200kQUW7QTia5zK0/OV?=
 =?us-ascii?Q?dHMVWS9bpnn6flQzQclEmWU6N16xpwSsRP491F7/ZUULd68Ifb5hJP3VS10H?=
 =?us-ascii?Q?4G46ZVoHF0cxjECIME2544Cv5RYWR68JQ+iO+fEIfheSADVuRqf1jqxyKmvc?=
 =?us-ascii?Q?Cy0b+Qef6swhikGTECNl88sAzNE60vl/S1YebemUHkDcQE5ZuxMBuAUHWXSc?=
 =?us-ascii?Q?P0A7B4SIn6FLObh1X+ndbxPSx5eZta9QeNyrSLxQw/dKG5ojbPvDrN4vzbCA?=
 =?us-ascii?Q?G62m8//1ZRnjLdSNDz9r5Z7ZzzyWasv8ntxFS3XVwdqDKbKcbR5tEFJjM56+?=
 =?us-ascii?Q?JdL1ERmr0ufaTVE9cXnHC830JEgrjj7Tb8w/gg3L1DL0t+QeQog92ps7QHV4?=
 =?us-ascii?Q?rzPoC6AjxjDFHKFJVRrlxnOvBXryYU7IrUwpjlr19VsDp9u5QR0k7aY1zRpo?=
 =?us-ascii?Q?0VkBy7FyTmJZPlxoUJPaiyNKIDIg65xyhD7bUoVaufx4XBHO8j3Dk/JbdRKB?=
 =?us-ascii?Q?qmO/dS7917prMsc63HkAH7MoAnm+w2kQg0QpmIPqS/+g7ABw9upIp6rJGAIG?=
 =?us-ascii?Q?FpyX1UqXbrAcfkYyk2Ju+Dy5rXOLwuz/QJm5b5nk0WUaC4XRdKIDEe5/EKDr?=
 =?us-ascii?Q?UFT3oyOcGX2ZFnd1UbyF4Z783SSENXlF2RxXKmlLt0JF9O9tLiM39Ejxuv+J?=
 =?us-ascii?Q?Y1vzXu2+KacLTPZKAr/xzdEmbd92ot/odXYQzXesTlJZ7MSSNuoOb7GwVCKC?=
 =?us-ascii?Q?Acbe51wC/3JDJoEKHfZ2zuDzWc2HE1oev+C3zm5LsrT1qkMHUbw4OjdyhWNy?=
 =?us-ascii?Q?YqtOV2VrCQWIzBFzpV5bX3lz9ZrFmGup+5dG66GMwWkT6zN4XycEWT5jPDyp?=
 =?us-ascii?Q?zwZYG/atpsY+7Em6BHVb7l9WN8ztTpbJBelDGy5w8VbddgBY0qOXYpD3mti9?=
 =?us-ascii?Q?4s0K02YnsvA0RHPS2QvwzMQHgFxkBrwApjplE70Py40CPg8RS5UiN1Ip4Yr5?=
 =?us-ascii?Q?Dg6ML36QzgK9fMQM9kU9DJ2LEIEdU8SD6st1mcT7kQuSZnmNOOmEFH2p0RTe?=
 =?us-ascii?Q?6JVPEDgAfpwQtgBZuZvs7u28Uy9rYrYeSLzx7/Q30mZndZIW91O+0myErqvo?=
 =?us-ascii?Q?DtREagM008Y3DWzwue0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80eb895f-4339-4d19-33e9-08dde409400c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 18:57:33.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4QBjIDzdkw+Tq3S0iPFJR55tRNDGCljg3994No4j2vN8VuV0IWiU3QvdO8ibJ2Ml9WkbxNazQTTGxHxSGkq+qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10726



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Sunday, August 24, 2025 9:47 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to suppo=
rt
> configurable RX length
>=20
> > -		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
> > +		writel(fep->rx_frame_size, fep->hwp + FEC_FTRL);
> >  	}
> >  #endif
> >
> > @@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
> >  	pinctrl_pm_select_sleep_state(&pdev->dev);
> >
> >  	fep->pagepool_order =3D 0;
> > +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> >  	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> >  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
> >
>=20
> The same comments as in v2, if max_buf_size < rx_frame_size, the packet w=
ill be
> received by multiple Rx BDs, but the current driver only supports one pac=
ket per
> Rx BD, so the Rx error statistic will be doubled with this patch.

That's not the case. In the old implementation, the oversized packets were =
counted
as the rx_length_errors. In this change, the oversized packets are truncate=
d so the error
becomes rx_errors.

To maintain the same error behavior, I will keep the MAX_FL  and TRUNC_FL t=
he same value
as the original implementation.

Thanks,
Shenwei


