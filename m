Return-Path: <netdev+bounces-216353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29114B3340F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC45F202709
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 02:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE971C84C7;
	Mon, 25 Aug 2025 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V5kpKXFG"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A82818FC91;
	Mon, 25 Aug 2025 02:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090005; cv=fail; b=pGJJwsCMUG4XWW6OGCbtKloz3CcU1iETedfZ4SnAVbMB7m52KgDb5GDZ4MhSlVwAemLTZggMChwwvQ1dQ5vCgvs7xDx8RmpM73d4Va9Dl02Nx83kHTdTDIV1Lkl4+59LyY/HnP+x6D9o2TIZJyK1qqK3cTP4s3gthl7qhxAI9rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090005; c=relaxed/simple;
	bh=ONO/kq8lieWV75CTxEoPENCE99RqxpJJbjPghFpkbio=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACpYZv7l4nSs7PjRe3ehN6Q8JKwcyT7ar5gYjQ7EDldZa0Lv968MHBmtVkxogr3h527+iSfCOM41CwweBVC2SZzZX2OO46ndOeBS1u/1W73lozuDoDmFkGpobX+KlY8tlAPdG9vXjklPZmkaWkvA3DiWjNzEWj7WzKyGRqWNBo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V5kpKXFG; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrPWGLn7WDD1lm9ytpn+JYAQch6f01ZNQ0t6vPm84bvDOqPCbU75aQcJtUgAkiBCpkKiB0HtzZ6wvLjWRM2nr2YEbM8QjSczyEJ8GPjYGTkve8r7Wm6/SJRORX7RJXjTn55aKSS+/qcJsD8tuNl9cORi/+5KpoyLgKtBMR4epdqliY0dO2OJJfRkSdHkRrQD40epMd3SrGhCIDSjwbBICSLMpQTkPRWKPo0bus3XqxfJMXsH2o0Z4H3tl5sMU7M/LfzfeSvr0xNdYxIdWnWRC/PJz5DnD5HqnTf0wQ+VZGFIlnBfA7TMJ4z5Cqxyh8Y/IMNyTFaWribyRVZN69r85A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH03qmXFqdCUI+ISuiBE9w2Z3I4a0tRg4hsmbbQx2Ws=;
 b=KXPT6KlsB1ngs0Zwc8wXW6S/lXFegFHGpuz5tXnW7Ko/yPl5IfSQiY0cOeYnt44ZtV03zknvWHmacSeWnNuQ/JU+gi3WaADc+zW4Hjtpt6ltgfRioLYKQHN61v1byqaaV1+M35KsIdc4SpMq5xc4N9nee6vpn1qeqGGaBOru0LELVxWPP4NmzUGRiFNT+xDaBqC+wQ/l3O0Io9rw6bvvmfzp5jaur2mQrR04jQnaFinsA5scDjYsPbtt5e5rj31v86bPdMc8Ve15oVZo4UT6lohdt5vZKpa5knPgszyx6IH3yyuqRX+olg9g2qPQKpEekop51SeVVI6clCdqcI2h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH03qmXFqdCUI+ISuiBE9w2Z3I4a0tRg4hsmbbQx2Ws=;
 b=V5kpKXFG4T+QdGEx1iIXXSHdOKhimfKgbCYVPoB3r317ssauUSa1oqHOS/8OULb1rFsKE2zzWYtlXZQtr1LvZr1EJHbosvq+icN3Kc4M+LjJI9NUPHq9d1LQequS2p60xMVtnlwUWLRG7E87x0pIhhDI2tsUu4Yqgs5oP4h4SkoGL6QIH/oLNjnOxsz8DvTVQTtYhCU1lmQoJu3hb4hLaLx+2kOyiGK51o2u+UkbL8wF9cw0vmOEMdCAsiSpjTpeM5o0ukSTIrCoI+TB2NyTZ3AAPofa19mMbvHsZN04AdwuvCOQw/r05FHVN9lhGwOHfNmycJFZtOxBilfuj6h0sQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by FRWPR04MB11197.eurprd04.prod.outlook.com (2603:10a6:d10:170::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Mon, 25 Aug
 2025 02:46:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 02:46:36 +0000
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
Subject: RE: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcFGBqwkKg1yY4qE2RlVidt69+ibRyqIKA
Date: Mon, 25 Aug 2025 02:46:36 +0000
Message-ID:
 <PAXPR04MB8510E7FBBDFD975D1D175237883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
In-Reply-To: <20250823190110.1186960-4-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|FRWPR04MB11197:EE_
x-ms-office365-filtering-correlation-id: b6767fcb-5d5b-428d-fb15-08dde3819c28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CR3RISEu/kP7VcdHWDD15clrAS2sh0NbgwwDbPXPI1RGeo8ZFA+pTY/v+5lq?=
 =?us-ascii?Q?rVz1KxMR8ydgbpZnntG8cl+KbpvOqfqUrY0j7ggfLdI1owUI0MN5ZxexVJZi?=
 =?us-ascii?Q?v0r6lK+RXjT6Y0Q5xspWYWOphmZTAy28KFMai5H/nnDQF552gwsAnsKDOf/B?=
 =?us-ascii?Q?rCy89awAbg7QNDo+FK0Q0V5YJYJn4PTbG1omjEyI9pvckvp2rNVSJFQPqE0s?=
 =?us-ascii?Q?BwXtGzFH5OMqV+b/nN6Te5cPvDQZ0XFwYOvondAEuzm7MWXIOq/2/d0YHSjE?=
 =?us-ascii?Q?5HpY9yO2dGFCab95lnVgXqnh6bglitu55UeD6+w7unL7RrjXlMMbEyA5u6QB?=
 =?us-ascii?Q?lShJT6Uvz6Ef83FV6h74Rkw4V1TpwMihGiwMK7TvNQDVRziKQmMIcGdWGrw1?=
 =?us-ascii?Q?MgGEwDPRQICUgAgcYCKySYEe0oVHkM5xByJdG54vAjQYCRTA7xcUnBw4j65N?=
 =?us-ascii?Q?FOEy2yTMMXcSbLbwWv7l8l+zZHO1tot42zzHA2f86C/IIIHyQMavpPGdQWsM?=
 =?us-ascii?Q?5Y9JiJfkM8c0s3Wgf68GWtTUwQqmQ+eEK/ACSEYhX7cnSJcW7CKjqYGe42KS?=
 =?us-ascii?Q?2SekbhZbOo1RxfwLhjRjRDSrTFomzCdIM7Gwkjbh+rQyY0/eSODf8Yoi6NNi?=
 =?us-ascii?Q?x8Mzmutqf0j2DptvbqpDjb4rZ03zBXeTxtyHkz8qrcYEhfcWPIFWPaObZX7m?=
 =?us-ascii?Q?fcaIZEGSsWfGmSUugUBw5XavRSFiFCiejcT1h5tkTHJx8pdDwnAV1CE8PCCn?=
 =?us-ascii?Q?4yg6fqL4TCDEtikrJdUeuVu7cpKomWP7vyZ4tGP9VGtlUuv1pxv/Z9/G6d8g?=
 =?us-ascii?Q?BuCr8DHEvodr3EPrZctTMVM4ZqOTPU7jwk3mv/nOlcBDDCD7Ju2nQmaEWgFf?=
 =?us-ascii?Q?LKDiThtKTaEnH6yqIq0nsXX/S7znNVCPbUQkyA3wd6KngcTgkHpZdB67VDBv?=
 =?us-ascii?Q?4FHLqHzzYgXQXf0OBwvtpY51Ah89cM7RLvWlLEn1h2mUwEbo5JsqYMvxSn26?=
 =?us-ascii?Q?HJ7rKqaFnVevG3wxXrKPtda6+H8IvqWmNVEmsZ+a7K/9Vm0z37oSi50woV/t?=
 =?us-ascii?Q?fD4NfXPnNuoqddRN4PHOWGqbqGqMMKEYv58IRpTJVebfUbWLz6FZkBhAxNKQ?=
 =?us-ascii?Q?quCuaqlv2uMxCgtHH7ARADHEWKZ55tB6H1bZ5qLNoK3NgLXMOOEJDF9hNCah?=
 =?us-ascii?Q?ctZoPFFbos090NTSTr2wo9iIl4swET4FU78vK1yNFEPtxOoffPhEAB0z/D1w?=
 =?us-ascii?Q?guIVPERbo8o3VmktiqqrdaBa1koWLaoHZA7ENXeglFD1iIBGTDm1gjl+DWMI?=
 =?us-ascii?Q?W9GutXhbs5HvjrL5XbI2Y+ac2z2Zae7jOBdMcPZiNjT89UhUla+pE088f1ec?=
 =?us-ascii?Q?xtl2lEtxe36qbFz9IxzpLfIRB0ck0EMzzdEHkjWngIjYH99DTGrzxZN+OLft?=
 =?us-ascii?Q?k6okMSLBq+MLSMkU/fKz1dcswX2ZzsM/pgOcHD2D0fqMr1uSH1irgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DvEbGcfAqe4rBl8afPR7KRflKAI5sWcGmLeBkDhEJn11SZnwXOvJgCVkgIlL?=
 =?us-ascii?Q?VMLob5R0ZOir+OjHexugwxdN2OxYnN6tIZOocRfsuN4OlGBAI/f/nmEJrb1i?=
 =?us-ascii?Q?tJWCu+n7ACb3+iG9c8kk7OkCIItDNVSIh/TkJu5dh8JL+80t/vxjbVRK4zhP?=
 =?us-ascii?Q?l+7rDucrEdWKVVhP7/ZUFFqY/xIKumZpURf1LGe8MXM9PZOx9ZCbtYMi8K/q?=
 =?us-ascii?Q?GOrgHTt5UjgTaChNSJKWPjxNB6QcriwfbaLT7Qf7hLCknzwXzdzxU9zI1+e5?=
 =?us-ascii?Q?va3RQrYDJs8b11r9wme80yvPJwQDJXaJDNU5+HhjCNi+/Ye/2BeYVjJcPzD7?=
 =?us-ascii?Q?3uAwLeYPsVzqDCvFir3ECppwx/qk7QDck8cZDko3rUpLxEJpQfUjD2bzbcn6?=
 =?us-ascii?Q?gO3YTEf9LJZl/YNtDU04lSdzUcaJ3lshOiQacfBmNsVA0lKjUi9/051aOMAY?=
 =?us-ascii?Q?n+iQ/rF7D005fiJBhVWipGqZg0l6DYrPnJ34NgovHMDbQqBh8pHgwUvvUoa3?=
 =?us-ascii?Q?YQ/LrFTY6WvARMlO8VKzgx/0sWgNhF9faYtVnSg+clYjL4KIMFEUD6WqM+h1?=
 =?us-ascii?Q?shJRJRY0aru5IQELyooGvOyCxOa0WTwj/1+ZT0YxybWQuJ+JfzF522gdhFnC?=
 =?us-ascii?Q?4elTFOgOrWXZMQOZ+689uSsekcEBJUV0ZPKlBusKB6AAwimD8YV8nMP1JZkA?=
 =?us-ascii?Q?NkiSqYil5Kp+kp17TrJcZD2dJ3nowJvJXiItd4CI21vNwWpANf+2YVQBHcRg?=
 =?us-ascii?Q?oYQuWfUhjv+MnfOP4oSqyyNXSZdSznD/CIax9uaZwl3TRgtAAz2cwezfvvxN?=
 =?us-ascii?Q?HGchbaBLIKtsu20X/4mLDdEySGO5VpjJeRTYHTRl8P0zuugp7mlijLm1xNp3?=
 =?us-ascii?Q?eQ0il+Zy9aNwFdRYnBzQbxG5zrmUti4uOf8WhEWeoSAthYqbuGXFMuH7EwC/?=
 =?us-ascii?Q?YpQ5Mm25hccjfIoiCUi2p0v6Y2yQPXiyQSK6n0oyIw21ry4oX2Y+Ng1JTEwg?=
 =?us-ascii?Q?OUdORnaSTUvZ4m4lUjoI/SYTFc7VY9Y3XhppdtsPZloGlUuOPto7WTKZN759?=
 =?us-ascii?Q?ZUF0cgvhL1dpq5O6/uOAC9NXy/L9+4hiFwWwIcc0Au/FZYzbAmygQEsV0Bo+?=
 =?us-ascii?Q?HumcLWxCH0LGjPcTqEyNyLO7ybCKs+mGsEcqOwLpx83wxf98He1kE4TNVm8d?=
 =?us-ascii?Q?4nh97sRIfXK49P74uLJ0PD6/6AIGFkQoLu1Zv85WFJ5IPwv0gtD/8kGp1dpm?=
 =?us-ascii?Q?OmhEVNRuz9IluBMuUdlq8lLK4NSI1i6xKjK92AyiS0ohW8xk3AjzRKm6BHQJ?=
 =?us-ascii?Q?OWAuhzihX2ZhEKDxPCHXATYx6+rFooYz2fawU3OPJViAGkFMe2toLIYFDf86?=
 =?us-ascii?Q?99ceG0iysDApCP47n6gbfUK0K4yBk7C8lj5vflrp6slM07ipiW8ix5aqnbB+?=
 =?us-ascii?Q?LooFhtPzSxzmYrAdGiGDHryNFUBfy06bpZxDNtka4jHba6O3hmX3oflE2tR0?=
 =?us-ascii?Q?zLmlxDMACvYwUgj8jzUwmV96fjOpCqwpjOW7EAvM1JNI5G+4C+D19mhoHTvo?=
 =?us-ascii?Q?6/78WUm12BVi0AAB9KU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6767fcb-5d5b-428d-fb15-08dde3819c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 02:46:36.6108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZENVE6sYTIIGXhwjlbJlJ7hfT3zoUGPi2HHiGXdh0yhGPy/tjXjVi1D2L3t5fMimYTb1L5acHvCKJFwLAefZ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11197

> -		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
> +		writel(fep->rx_frame_size, fep->hwp + FEC_FTRL);
>  	}
>  #endif
>=20
> @@ -4560,6 +4560,7 @@ fec_probe(struct platform_device *pdev)
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>=20
>  	fep->pagepool_order =3D 0;
> +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
>  	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
>  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>=20

The same comments as in v2, if max_buf_size < rx_frame_size, the packet
will be received by multiple Rx BDs, but the current driver only supports
one packet per Rx BD, so the Rx error statistic will be doubled with this
patch.

