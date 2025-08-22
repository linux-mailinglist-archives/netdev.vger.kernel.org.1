Return-Path: <netdev+bounces-215998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7808B314D8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3214CB6810F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDE52D3ED3;
	Fri, 22 Aug 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SG7D2pum"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011071.outbound.protection.outlook.com [52.101.70.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17BB296BA0;
	Fri, 22 Aug 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857384; cv=fail; b=t87gOnAQJPKKeQjwPftRKGA/cnaCZm89gU1PhzQjZPouRNOLE+wuhfVgwpntcrjMNr8hMDYvQYrRnSLeQLg3xm4QQ6bcDaW9KhLZ/ojnYWip9Y6F7apVaQ8OlG3wiQ3AuWHTgs6zw534IqxW53k2dhbatR2dq8H4y+rJCzpyGFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857384; c=relaxed/simple;
	bh=a/Jqly8jVBtUUl7HDyYvmi5v984qbk1WTLVidod+biI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qulGswfVw9SXoZkuOguZBwSGOwwvtnmIRzmPYb0qdWeE5ehsJzTFvqYI1Ic+mZsdDdjZXEP3LPFYcNn+wyvz8ZfGAt6gLIrtUST6IIIZ8ZguLTqrOkhY86gswGLIys/JEtIb4JoW1IINKH8lUOlkLfvl7g7SqiaVh4pqDUVbfcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SG7D2pum; arc=fail smtp.client-ip=52.101.70.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5rzZSHnY+OkOt/4nanrPG72F0s5JaftC+c0WaC5pImpNhvYNCHtIHdAx9RD0wG++6QNYlLxEKeCW5PZjRmMjcriRN6M69UIYgHdcBZgk3GDbIfCF4t1hdkhoojeT9IMQhiVHxyL0+qkCD0agqHvHC/mB1WWZH1eIvULh49mylO669sk0PCTiKhV4f2LI7kmz/kXlqG5zQrZErrYTLl/kifIPHX181x4ZvaFrHiZh6fHeIlTIpjFufidAQo8ez4SNi5NzT5a1Kai6zVtGDSKggjkXqQPCAdSGatgNVrzK3bqvxuozZglHOmYixpbv7E0/1KNspCAfoqHefyM25BAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWpZA2XtMd2RPv+RPQaaQtdBGy2QBN/UDAEjy1yzQaY=;
 b=hjCWCmkYAoV7y3eA6Blzy/jOKGjovcVciwr5AlDbmOn+pf666zFk6/WncAwP4IHBWkzL36InbMwarJefbgd3mUmAGnl08U96/lEUbVqKx0XTXVKfQxjZ68z7QtshHO9VHP1OnLQqcdd1D3bAXiV/rwZGc0+7naIFQyEvbnUORa4VxpGtjD2T3+x4vHAHOflCU/adfs3TBzsAw8emF+pqRtKcjQxU69GM/Y4c6xNLtLjTd4byC6G24jjOqZTg1M0TVOuC0Fe86PoR63VBaJKkhCyQcwjeXH25C+icCrCkBy9pnX6D5HzVRwRuK26zLopk9OGuhucZAxm+4FJE1AH93w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWpZA2XtMd2RPv+RPQaaQtdBGy2QBN/UDAEjy1yzQaY=;
 b=SG7D2pumYuGzSR2mQDi5BOhPaHq5l6eghTGW7SCEi9/xs49zEoG5WFZhux4Ft44D2Dt5Pt5u4a/IfrPxinJv++Ip0QSyrjMQopMniHhR+mmbxkXdyoiOhEbVjF2/Wf9HSUx0+9SDQ/k/8PbdxR/EcH+HieM4ImEgCk0007GVrHo62XT1r/B6G30/3+L19gvPWqFB4RqcOJZUyXi4AVVODB39dRO+nM9LmLN52lB9cQvkGGZ7MuhANTAB/PmXmyw4EkqXwF9jRvVXjtHH2RusGefMCZ+B+jDWhtSkpq65w3ep3xxZW9o0O8xzEUxnuwe1UpDBsY5tfu9ygJdcSDMUKQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 10:09:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 10:09:38 +0000
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
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoyoJ7sYfSghkG8db/Gx4Jg+bRucgcQ
Date: Fri, 22 Aug 2025 10:09:38 +0000
Message-ID:
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-4-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VE1PR04MB7471:EE_
x-ms-office365-filtering-correlation-id: 77b5cb8a-2642-4ad2-acf4-08dde16400e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4+OVS42lBpwGdKOgKsQ6ZQUKAwX9DhicwWQIbdLYNVt2XyDb6ZmmFtoBtnj0?=
 =?us-ascii?Q?FvOGjigNGaKM82/0r7TLfXZI2xdDeSjutxHM3AXs7T0jP2u3+SnYJQZlFo+A?=
 =?us-ascii?Q?sbU2p7Fj2M+O1s48UkwcMrPcTnoFrd5SAS/Yl3X88AjWeitA+agfFtLM5r85?=
 =?us-ascii?Q?aaumjpF7pyluxtelK6RJz25z84ihr7xLmflSJk66LCGmjPa2B4iQN0WIxcTK?=
 =?us-ascii?Q?PSKokc085mIyZ81zn6k2XXal/zPOOg5JH81nAeLX29mujxnMmw1U3atiT3pD?=
 =?us-ascii?Q?5v+2vPaBlyPahEda3EMgGFtVoNmX9esSxElVMC1XXx16gd/ZmsrvkaE21yQY?=
 =?us-ascii?Q?jpMpvo1RgaY4gxFouLtO6kPaJUDGSlqOsvxk++3PSFJU5Z9ItEHOSTdavzSY?=
 =?us-ascii?Q?WEfZtNu/8DNjCE08c8/SP+H5lwguwrAoSqpd7b0ZpZ1h2NwygZnsl89iRcvw?=
 =?us-ascii?Q?IM7hWosrO99GohschcDx7BhZ6QVG935a5nKZalN+RXfdCMdvWYKBIajLTVuH?=
 =?us-ascii?Q?Pf9sotwAdG5F3TlEF0otxR2C6VHqfnZ3pmEHITVprd1dL7o5p69XInEiLp/z?=
 =?us-ascii?Q?zn6+oDeAJqQMBIEcKdcbwVIxJ5h0hLZpp8HB8Vw0eKA3QOkvonIwLFEZZA0b?=
 =?us-ascii?Q?/uvdZk5fefTg5iHh1LCtog1co0BCprKhZVnrUGMyGMDSqfcrMm8Rqzj1DTRA?=
 =?us-ascii?Q?r47QwRJwhRcHJieyvmvpSDlenJsEAP+oeleVq4u4B33kmyo9ZCn4EwSHGLWn?=
 =?us-ascii?Q?SYLwXvig1wwtv9UtkQJ5Zg8XygHeWAJDpTmG4MApAwtMbUnJM1Xy6L9H2IHE?=
 =?us-ascii?Q?TOJLm5HGCHtf92XN30fQcJyOa/Ru6DWprPQm74jgBsQrtsHQs842pGjeanse?=
 =?us-ascii?Q?6QBRFK4JXafXR+EqeZ30MqDsmCIxebJGjb9L/fhkSxiB2g/xafwEp8LlTAqJ?=
 =?us-ascii?Q?44WJ3rGgavTMvmp4rrnfJpsvvPByA31J8lmSUtUqCUuf6UAD2i8BAMb8FTmi?=
 =?us-ascii?Q?W7VA27oW629HtMho3cm6Utc5gMHqIgIMAbDj0gRQ+vZtT/KRyuTcLf5O7vOq?=
 =?us-ascii?Q?WvPZ9OBFGqn3CLmFEWHa9dXuKlto/zfOXvX1fIvgZ1OPwQJ76YF5AXDeibyd?=
 =?us-ascii?Q?hZrdLMbGf8G2GQnFH/190NnLgKaBES+celuR/Pou2g/KWkU6tx6qxNjAHzfe?=
 =?us-ascii?Q?okSWOt7BW4mw9NdP7llzKk2MruwW51IgSYZSxxCvs4g6LNy4xZP9wixnzXDO?=
 =?us-ascii?Q?dWfJkz6OfkpFo5Z8NFQ/LORDNr/Ch1Vp57XROXNifISuAqzqxEcyHPAbj3js?=
 =?us-ascii?Q?1xUymFUaOc9KUeohyWsKBED4Z3KzLVroDapFqegfQrXJn0YO6sf5/lgjOM3M?=
 =?us-ascii?Q?BWlSYT2TPNW3z0nQsSeEQBuRNyV0eGYyBDpWyKbQrOfwI3fX9zLAyNj2h9lT?=
 =?us-ascii?Q?MEtr14AyxSBgZnzzZc7Ge5S3MRo4WT2CWAi2y+3mTBfXO868RMkWoQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EW56l0VePzcwjjn97GPy/r9XPb57FjsOk6wBY8SRzoOBpFJq0vRXFFk1sD30?=
 =?us-ascii?Q?9R2t1ar4mp7xs8vqwYfenKYvvZiKOOi0l58nncx1tohoQahXJV4VkmpQZCMQ?=
 =?us-ascii?Q?LeSt3H2RbR8bj6UczA2gJi2qRURgYyXAAsMqE5iV4T1588sylUKYJqip8yOz?=
 =?us-ascii?Q?0WxJo1hWDlRFfyzMbrBVeCbEEZqFiy/vfpB9zQaaLP30oHC0dwaF0piw1pGp?=
 =?us-ascii?Q?Z5VTxlU+GjcYb1yLOo8Lo7SWdHL4EXQPk6CNxBRK00IbCMFVEwEhzkjgalPC?=
 =?us-ascii?Q?psEpto4vt8o18lqui1/mry2jBSgu0CX23Crllfx0v/n8hYmFlqdcbnWe/ogK?=
 =?us-ascii?Q?hZIUPosKRtGxVqTx5X1dlLPgFc/lvCh65BFIIVhEEyk5Z190QvxnoPtS4D0S?=
 =?us-ascii?Q?wpaQEf0GdEw92nhupb4Un0teQwyzo7GYK6xY916Zf9qdzEkrherOaUcYTeZP?=
 =?us-ascii?Q?LkCClDoZddhiKYVLcHJTEuUcPh0Kjzt5R1c4D/5TtUQLIT/VF9M3NeEsq5SU?=
 =?us-ascii?Q?heDyHun1xikCBkHhEZ3mld5oiUTkBdae1HTS6TrzIBWKhhTBQgMTqdr2txa5?=
 =?us-ascii?Q?N8MEG79h27CFR4AS739lg13EAZ+lEG+8NuYjXJF0jriGpJxelgWQSK5ksVs1?=
 =?us-ascii?Q?hpEQQCxLp3srJ8RGibJJJTRmXFk3/yzTTxCFSHOCM35k1LywFVe1JbUZI3Oa?=
 =?us-ascii?Q?8D6fJIutsksZic9RwUE63RvOES24TY5/XmL1FfgrDV+vuQL07TbRN0yrE7aW?=
 =?us-ascii?Q?GKu41MzGlSGC3v2+Ebl3JGAnc6AOKzilXKuHxGRFzyy1EZuK7SSdmaiYWjcV?=
 =?us-ascii?Q?DC2nP2Ccg/eBot4q5dXIcNo3BZTcqp1lESu3uaATu9dZ0SRDtRxcPX+fYUNb?=
 =?us-ascii?Q?8I/NSkXYYnra+t9Qsp6HSnnisVUS4H/0w3tx6A6pOhAK9fnpUeMDEyuuZEk2?=
 =?us-ascii?Q?jjUp1WVffZfeZPoMk0edsU5RBPYK8Zi4UOON/Lm2mKlirOVHKuASFgUslJUl?=
 =?us-ascii?Q?Ej1eBNV4c0k7pCcHUK6ATdhkxAgmELmt7w4UBhUIM0qavXZRDzh1f7CGiBGG?=
 =?us-ascii?Q?wriTFKKOhU4PAzHMozbJi4zWwSdCq/yqhO6+LMdMOBfvVHa/mTXXnZ8thB1K?=
 =?us-ascii?Q?jU8GD8CfNsJqTr1vSdczlyxG4MkaW3Z3Cc02s6elzOJQo+0UXPIV/baLduc6?=
 =?us-ascii?Q?ziHezFKk1GnUUckivBhQdrBA0TMT4oVfqbpSQHaRx1CiGzbLArnYvY/tWNPz?=
 =?us-ascii?Q?QTUEoeDuupq0nIBtGMjWOL9sJRrZbTv8SN1GSKMrTXGS380x2XEHULGm47Xg?=
 =?us-ascii?Q?H+Hq4kgnbcxtBuebiXP65vZxI1FlicKSNzhc9Xb8AtVbKg/TiAUrD+dCDhGh?=
 =?us-ascii?Q?+8XLnz1aa+PDYwUi4BY9k4s0xo7s6aIgP8c+VK3aeooOtmumX2FXi4ETWiGt?=
 =?us-ascii?Q?6mALq6T8OC8Y07I6lxwbKVEAlW/FDUXjA6yJfomCQnOcOgv15d2eO639FQLo?=
 =?us-ascii?Q?6teXppIJvWTUz32XjhU6pUBGjT91TWuG6Clv1Meqtpd4T2KEzULfiv2EMW3n?=
 =?us-ascii?Q?DD/uTM0D0KAoZKyyM/Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b5cb8a-2642-4ad2-acf4-08dde16400e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:09:38.4027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zopX0Oaewpd0PfUwOxfk0aixGu+OZE4nhFEfS86ejJG8etm4XRnRSAnBA9ilSnH707xpGNwZ9iNF+K+0Lu2ciA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471

> @@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>=20
>  	fep->pagepool_order =3D 0;
> +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;

According to the RM, to allow one maximum size frame per buffer,
FEC_R_BUFF_SIZE must be set to FEC_R_CNTRL [MAX_FL] or larger.
FEC_ENET_RX_FRSIZE is greater than PKT_MAXBUF_SIZE, I'm not
sure whether it will cause some unknown issues.

>  	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
>  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;


