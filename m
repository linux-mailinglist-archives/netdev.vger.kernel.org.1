Return-Path: <netdev+bounces-216232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39170B32B7B
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED485580F05
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C5F24A05B;
	Sat, 23 Aug 2025 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nnem+LcP"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D8D2528EF;
	Sat, 23 Aug 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755974324; cv=fail; b=ckM6QlNl55DZQ9eAUs8mc21fBqbYK5BQqNiNNMMEVtNowJzV8FeYaatMwZyeYoTKHzVcszVPcs56ZZnBwKQrw3zAD3wh6MzbmFhv+m2YEQE9qHm+i7xTOYdIcAHE9Q6ChMaKWbghJ5L5hD88pMoL9eYprjKlDL2uhYxRMFmq3OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755974324; c=relaxed/simple;
	bh=S4xY2LWBG3EbG8Z/s6/SO9DuyXo1pXtH3M3yCaxzzkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XL8po92ndfY1INogja52zgflAGa96ILxzJLzJyP2ue1cs5Ws5k22vm1yH0mVVFV6A7RyI93zYLzm5v9DY3VWRzFxUf2i3RWiL4Uvv9xgnuGRlQbUt0wpT3H1VgbhnegAjkERyYAVnbKFyV1/Zc4uTqayCoZIqM56iBkS4f1a5XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nnem+LcP; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMX9pOWGGw4enWAv0AZ+FaGhL3dyo7qPcy/sBe2Ue8FjygdReuBsiGm+bb/nlnXHyVIE7ghRos7h4rHTemf1p50WO33jk6RbYVNSS3UhbID/xqZ44a4r4xGsOPzr1l5uUPOUmLq0aVIE9V5Xw8gC38jZQvcLGRwlJfCR7ukgL64vkwfdf/Y6CpdkW2flr6mpFVGN1oj+Gg2pTtmwjfdVkyFQWTwZFKYdC4cFOobXsGRRSzIo7B/gJV2upzgenaP6xXZ2k1y8/O/8S9eDzsUFpc0J4PUydOKQEXUaUDlc1w7v1wzI6d3kGBiWzEZ3YR4vSnhK3r6/plLsiDAa8QmYGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58tuduXacff24NjTrICEqwONm69+xZlEy1yXoPtWz6A=;
 b=vKz66XN7fIaEEHmopD5CD1+xLkEQHPB5yZxcsfYuigh8RdFm+xK4K+4dYSef8T0jF6hL9iPMnXJC4N6UGuzYoyZ16hdTxhxDFXYoKMkjr1B0/ZLzhGJpPhBLdFlWE81/NouhY6/WoaeUzauKGHQSH1yyPgjN4UNR2QsyRaatL9ci8Xvb2gjDzVeIwNIvEKqrWe595vEfULAh2d9ckfH8XRb8/sovQL6UnW8mIRVKCSBguQZGqSWB93MOkrGZE4Bb2z7vRuUyjB+UsMGEnN+WeD+N6q4DOTLDf7AndxCDRB5lE5zm2B/lzETrtE2NIwwbgZcTU7JZGlfIfoeafB5NIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58tuduXacff24NjTrICEqwONm69+xZlEy1yXoPtWz6A=;
 b=Nnem+LcPzCrg9fxwyVE+I2Yt8JsWaBBJRMkDsv4Mw5FjoDyCTt1RhxHQI43qDocKgKydtRrAvO0ZXtj4ZM5fJXIVWmgSXtZeiwV1wuS2W4/rB1hRBpiHo6LHAiWsVzMjE9oRdhfSW1Qo61sZ0kapj7OH9TZDvwt2YHTRfDRyeyPNgHJPFtgpz9JnGsqCnJyNaibvifw6pKc/f1ncqgCU65NEnYIVr/jgi7tQFB57xC8BOhX7Nx52VQz+hLYoSQtotEZBAUHuNFT+0RMXqDpu8mzQQ2Lwycf6rKj7jAMjViKlNTolMPiDvT7o28LniXyq2kHZXdanpKxak8ZCmvUVMw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8156.eurprd04.prod.outlook.com (2603:10a6:10:246::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Sat, 23 Aug
 2025 18:38:39 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 18:38:39 +0000
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
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso09J4T5pZDZES+itLWSHrcIrRubkkAgAIk3cA=
Date: Sat, 23 Aug 2025 18:38:39 +0000
Message-ID:
 <PAXPR04MB91850A2E4ED6ED29D45BF27C893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85102101663ACE21F6D75562883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB9PR04MB8156:EE_
x-ms-office365-filtering-correlation-id: 6ce2fd7e-824f-4681-5921-08dde2744716
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?REL9MWLm02aCimIZkJaM0GoadpjErSa48z9uKbLlcZDw3H2bZC0WGoV7Gn59?=
 =?us-ascii?Q?exa852qEQ+TvYR3bF9jk+hN7/6ruR20AXJxgFz4ldTf4YpsVk5ge3MzES2Ol?=
 =?us-ascii?Q?vWvezbs67paa6ytz6rQBS7ACxQe1+jdon6pOEwqDHDn1Sa7ztbZK+lNuc4eh?=
 =?us-ascii?Q?z3Zz7iccmAE8GNxk1eaqXRQt3UEhcwTRNcbUbRDzTE0W2BDR4knd9sUrppyW?=
 =?us-ascii?Q?oKkpdaAOHTAUQrQxC2PSsOozPPNq5RO8Oom1AkLty/uTgNyOL5GL+WK6ESnS?=
 =?us-ascii?Q?+JO/B3pDrPQ+xBp10Mg010qyYZCY2leGkTimJjCKp0I84kE7V6MnZTjAQuAV?=
 =?us-ascii?Q?luudMYYjluWpWiWci5/k/NbJjA9Ocr2fz5Ry1HfsPdZOR0gTtCYA3N0U9nRy?=
 =?us-ascii?Q?4Cl0QxSwJiWWxIWKXsFXjrNKqCAGJhmwPmQC5i51RYUIV3vIOAFNxcchUMYz?=
 =?us-ascii?Q?/gSFRREgcbmVHWgIWhx3nIDWdqYwpRo8HyeZnBuQVoEg+ayy+93jVSHH8O7Q?=
 =?us-ascii?Q?esWuNyGlPhfVr1n2lRVnMtjGJhtvlyr/au393B2w7f1SoqFUTFi1IlEpMI+D?=
 =?us-ascii?Q?uQvwxqzhwb4L84yG6duOlJVkb/HQ4+16H3D3wu0h3rxY+2Qp+rWAdq8Dmt5b?=
 =?us-ascii?Q?1a39uDHds0fhF50pAU+jd4//V0EGDTcdZpdXjCDPfXkNVlTOvj+wWA1IndVI?=
 =?us-ascii?Q?LxcTT6VwRZR8EOq897N2lllb9H+dWQvZvkLY0vHg0JQGsRg3t7SDbl+Ia/18?=
 =?us-ascii?Q?dw0Ztb2bTiQxb1raP/rJpAcd/eAMC2XU9fsmZCHrkeZYojZJSvo72TJFlSC9?=
 =?us-ascii?Q?8gsS98RydZ+Zprbb9oNfTu4Pivy6ww1O6+BlKmnauMWZMlZ0RRBaVXmo7oa5?=
 =?us-ascii?Q?6W23BrDnfjyNfImLj7OK+RSeowJzNOX+Fn/UNxg2VQJsX2erLCs0HKYSNaM2?=
 =?us-ascii?Q?vQBeZDuc7Jwdsxk1GlvO2Rhv3pNCvb1jXwr5QBL6tmeSO/tCqWtowVf7qZ1g?=
 =?us-ascii?Q?PEth9F46PpakOl5B55Wm7aQQ72YugBlXRN3haKevg8kO8gAhgth9pUMY0Y2B?=
 =?us-ascii?Q?NYE9/4d19ie+gAFHRGY3EB0gh8tv/M4Yi9xJf9G9oQGBcR+g53X4eFQkMvcX?=
 =?us-ascii?Q?9BxXYHtnRNy495sz6EIShVqpCyl3GUPTaLOsWsVw62x/IIfAVUZIjCe049eY?=
 =?us-ascii?Q?CrMUkqnIkkl6t1Sdmz0wgpc+kEHcImdHgZDyMjEtl4gCiynWXwY3r5ie5J3/?=
 =?us-ascii?Q?IEJARnWONSqHSPBbQMVtHMmNn0uMqDG5gYrSESqiwUKg65ZueTxg6o7LvJeU?=
 =?us-ascii?Q?GYYIYF+F2EWo04lBE9mF7qKQOxYyb5FSIfubD4JuUJL9b7OL37O0dufpiZMZ?=
 =?us-ascii?Q?OMHM9HosPDN9nmbogg3PLSrBalXPmwj5O0qbDANPSaFqxbwGDyv7QieDAkAB?=
 =?us-ascii?Q?rHk5rnHL8jOJBfsDO+gSyXPlFLEKOOADBNhYyibOJAsemxX/+cQqEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NidD1QsPOan+TLdnz3qWMrr+pcTAXgcm18ySp+pj7UBywV5twmzRgNaQoXob?=
 =?us-ascii?Q?q1NFWv5c+fknPqHC60bTBpxXDg9X0EE2SVvmrwRecXQWkohtxmhEitIcTFog?=
 =?us-ascii?Q?eu0qiXHORVe9TucqP6ME7Dw8qRYg0TRXZCd9cCknDPbNNXk42Ejo+CB0X6/F?=
 =?us-ascii?Q?otsHT0sEL7FCj8dZOamZcu5R+J848rq9b7ZRRmbKezHJaykukozcWjuSFykF?=
 =?us-ascii?Q?UJY+oOWq3e5xIrZoAC+7FpDDBVSff4CZ/IDhnT46nkomNfA8/B7sEBPiMZzx?=
 =?us-ascii?Q?LlMO19SX175HfsdIs8OWMwdX+/3WasrUW20atiZHGzp8nWwp1CDBT7cAd5lx?=
 =?us-ascii?Q?BBMiqrHgMu3r4RSkDbjXNt8lS0ZCQTqUImHeDDo6M0rc9ZRW/QUjB/ObQw1Y?=
 =?us-ascii?Q?JFQ6LE6wPnIWNxFydZC64Xjc76mBKW7ghRei+9PzL6LEr3VHGnstvDCMaD+2?=
 =?us-ascii?Q?cP3kgCZL7tFPiWZ/aUpOJDdxFGgM9vNaQr3ur3OtYPertx/EERX78w5xhrcZ?=
 =?us-ascii?Q?ibVbUzoo/GwmLc1vNnjIQNDtmM04fTd9GXRpewG+6H4L5/c8q76IE/h0PPgb?=
 =?us-ascii?Q?jhWv+Q2oHQHo+xa/ALwX9a6fB7atjY43Gnpk4LdxoFYznKDwqsyn9uDKiW3B?=
 =?us-ascii?Q?qpb/8Ff8M5/YaHpY591aucZFYDwsLuytcmqJ0UaGaW8mNz/NOpXQtD/YfVRk?=
 =?us-ascii?Q?LLLQL47Asq6HX4I69Y1q2ZjAcgOonaibjIM7Wlf5P0XRpw75gBhnFeVV8jDV?=
 =?us-ascii?Q?b/Xyzztu7dF0+tDPtRixiT7merzz8gOUCPzc/ak963JdKxXXLiIOJCYruqje?=
 =?us-ascii?Q?vLuiXYoD4WRBmY6QLj2FLhN6AahYTffvpUWA2HqutzPsuDzC1VXMGXV2scBG?=
 =?us-ascii?Q?7RAqPfcT2LexQIxrGKUzyOPQ4SNk+Fckl3aNFjNf9ncwS72rmXGujik7B40M?=
 =?us-ascii?Q?xrGr+yLNxk1aLvQLZ2cciL5KW63g6ZTwW+IsCH1e5xqDecU4ZHopsfTdSGMq?=
 =?us-ascii?Q?4MntCL7Rdd0R17jirgEBGq1ATIGZoP8X9aE5v1GsUiF+FBCnEXFmSgzkA2Ld?=
 =?us-ascii?Q?ih40EsaHnpWifsiMWiztQfhlWAATLrHAlxsrUhTDa46xVaMHXN0/4BBjdwpo?=
 =?us-ascii?Q?B10GIHZeAFH0Jjuy1WLhhVnmTaZXnQFWLXzf0JdxmD/Yhxpj9ui2W+WiZinq?=
 =?us-ascii?Q?y30frIHWRYBA4vHWLKmkW+6yIDuNGQFy6tTefAsyoElBmR+lZJ8PHPvv6va7?=
 =?us-ascii?Q?em8t5gW+MN844GTo4HI6Xq8aFMYqy2kXrvcDkS6HZHLcAdJb+YvZwWVyhsqo?=
 =?us-ascii?Q?a2lR1wnuAqWuMumQs6PltWjxh12HQLbUZHpexCmV/7ICSe0Nm4Kyzox9r/tx?=
 =?us-ascii?Q?Vonw1/XknduLdrL2Cup+eH+tsB6vj6ZP5yAfCz8XuiPxwuRfZ8LGZhF5SHLh?=
 =?us-ascii?Q?eGGu24Z3fWPUwPRShaXBQjtDQadxVaEG+zCUK10py3wxquHOs1xjv2EP2U8f?=
 =?us-ascii?Q?+nXxyoR5q8+d0ty0eZteW9bF4SyVACo+OybDhk6VxuU/H/BKKQVQKGbkD1kJ?=
 =?us-ascii?Q?41HouPwlcsM8pXpT/rk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce2fd7e-824f-4681-5921-08dde2744716
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 18:38:39.3145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9UdNiJvSCTvyDhNf3u6uLSeqfmAAX5k/4DU1xq11XLOBC9v3+C5PwobgK42svRbx7rnCash7u3XEAtjypVlGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8156



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, August 22, 2025 4:49 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
> dynamic buffer allocation
>=20
> > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > +	int order, done;
> > +	bool running;
> > +
> > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > +	if (fep->pagepool_order =3D=3D order) {
> > +		WRITE_ONCE(ndev->mtu, new_mtu);
> > +		return 0;
> > +	}
> > +
> > +	fep->pagepool_order =3D order;
> > +	fep->rx_frame_size =3D (PAGE_SIZE << order) -
> FEC_ENET_XDP_HEADROOM
> > +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > +
>=20
> I think we need to add a check for rx_frame_size, as FEC_R_CNTRL[MAX_FL] =
and
> FEC_FTRL[TRUNC_FL] only have 14 bits.

That would be redundant, since rx_frame_size cannot exceed max_buf_size whi=
ch value
would either be PKT_MAXBUF_SIZE or MAX_JUMBO_BUF_SIZE.

Regards,
Shenwei

