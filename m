Return-Path: <netdev+bounces-144213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9A9C6125
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E420E1F2189E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDEF218946;
	Tue, 12 Nov 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCAY/S4Z"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2078.outbound.protection.outlook.com [40.107.105.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49EC21858F;
	Tue, 12 Nov 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439044; cv=fail; b=P+9JNiT/lxXCGd0PMVS60FnS1iXvOIz1vLlx5dXg176Q1mPhl6FW+X9jONCLJpEpXxCIP+K8ES3bafRLiRoP+Ng0yb2vbBfDAKF2L2FplHYQhoHzals52HPnJgVlZeefr+iveHWi9XWMMGjEXsTS/GA9UQwJt6LjMrrqJQa9sFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439044; c=relaxed/simple;
	bh=nKKx24gk/aVZOCZ5jZr0J0FzuLd354UjWhmuHdRaVSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kalinNqVx2gLTGSGrBzuv7rGfziXDqIv7pBaLLpxse6Afsxm7MmqImnhB6X22bF6EW6n14AvYfR2JQiNuruOteZOrWBK844o6SO9bJTSKdTvNlr7YLkrYtZgO1Xg0o0ZYm+cprMAekTnh0jbWAKOI/Tz2Gbkevd+JqKf+Bv4A+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PCAY/S4Z; arc=fail smtp.client-ip=40.107.105.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKXYLMTOBpxT7zb2YGUM3d3NGNbV33KuyCNpbhI09zDIxZBg909H8v6i5ShwEbPMtLuFiE/7aG/2g0oC1fF4HAGLdwBGztM/+K2YnHo/nZQQmCcFZBDj/H+tUeFM5Bv2Wwkq3MVktY2by0wN4STxEtpfIOh0+pUjC26P840sPQCSwbZ9NBZLrz7z5sNqrB3HG7oEKC57A3mT6LVpIPW8qZhfXt2WtF8wclHvSSLnwBb5SWM3lk2FcAIo17YdSrcpf2ynpZtgQqU8lf4v99Rj3eet4/rIy6mhHk/s83hojQpf5CL9ehtibmLNLCcMA+Ak4B6R22jVyHZc5h8n0t37QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKKx24gk/aVZOCZ5jZr0J0FzuLd354UjWhmuHdRaVSY=;
 b=H9zQ05JEBEkm9FJ1ob+4cl7DoBZCurK8Hh50MX68UBYocj/V5lSvhZu/QqMQi5Uelq8hpu6Q04nqIH/uunsXVsKL0xzLBvoCmsvxlW+7VUJU3WihnJ6corL0DXYXPwIA4P+OfksG82Eis1ScAFb5faNaGsF5fGK3eLNPq6S3Ur6UIQ0HQOtR+HDpNNzX4nf7bl9yaoAlrq8/OVNM/urOaSi60EumIRlp9Gw9nyNfoOAYgmA/9EY4gIErwHEHImF3P7lYXyehLpCPX/vwjEOhitg7VjRlJp5q4J7+DBLct1217egwkVAAGI+mEA5tStLQJ/iw5UfC0c9zLOtlWuOTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKKx24gk/aVZOCZ5jZr0J0FzuLd354UjWhmuHdRaVSY=;
 b=PCAY/S4Z7XrNGnmG7iRaLuk5ixY8sk7z/o10lXtB2zGAbAWgNZQprFvmTxevKRJQS6lR0reFoyg3Cy932ytDr7rj6GSteZ2gMOG0UfRnsT2Y2/En5SJ3vIDOBNxvvHxBQnzGKNANjh9LNJabHw1qfyz4t0Z+wYVdGW85cAbMpr+QJ2umgxsfSh2NC8/z0J8r3FxnWL6Vqqe/nMwl0PNbmPhsVUr1cWqvRXMTb/Agu29y2jSz8RTNsdh9gnp7MkB1eDcttQy8gy2aMGp3acWDmTrWe56CEW4vSJ6O11fCieRrf2NWODodM/z0AESfeNdoYf59DbN/pedzHocKyRwb4A==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by AS4PR04MB9552.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 19:17:19 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 19:17:19 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v3 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbNOWBrtqGOziw7kWCjEQIO7f8y7Kz/xWw
Date: Tue, 12 Nov 2024 19:17:19 +0000
Message-ID:
 <AS8PR04MB88499F4A54EBA4DC75A78DDC96592@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241112091447.1850899-1-wei.fang@nxp.com>
 <20241112091447.1850899-3-wei.fang@nxp.com>
In-Reply-To: <20241112091447.1850899-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|AS4PR04MB9552:EE_
x-ms-office365-filtering-correlation-id: 45566c97-8830-44ff-e11b-08dd034ea09c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yEgxssYXn2Yv9k8TfRz8qdKQupst2Q/JXu2T+mLUefiXZVd1/HRQIBKC44ME?=
 =?us-ascii?Q?E8Newj6PQPWeIZpfNGsoYh1AO88f03ZUI16ha+E0OM4DBDYHmXtTe5VDJHDf?=
 =?us-ascii?Q?ZAEp+3uiFd4u1EBXBEaqsm3KySAD/VqgC50gZ2Y7O/dHr3z/XDLop8pNAk5a?=
 =?us-ascii?Q?FFytP9Uj3mVW6nBPNE1ME50O2WfVFcw4Maf9dFROS04LnXHuS+hd7/hZ4oD4?=
 =?us-ascii?Q?vXkR8r8oRnaAk1lAmLdml2/ygHWvxuAVKsDNGakER+f4B2TmE2UdFWkMdntt?=
 =?us-ascii?Q?eJ1WvU1G8sgQSTkQPYsJaaDSycdUbiQZkf3JCL6v/JzstENR6gI8rR++hiif?=
 =?us-ascii?Q?xbj9JWnWuxr7g9IKuYADQUtP0eVHorQ9E2AOJQSKYNG6ww1Nrxx8iWv1OrI6?=
 =?us-ascii?Q?pn5N5EuT6HcojpKLBqAEjDUIy16PrNhRYot+y5AgWdJxGUtFhn/vmD2WTpSY?=
 =?us-ascii?Q?Q2FKmmA9tRag661I0+taPhxeUkiLH1GO9JWy9NHUKdVnD8TfaJ5FtjXAkQz3?=
 =?us-ascii?Q?lBlMgLA6/0vXRBRwbX8n3ckbGM6ZDYJDlNXMAydcD1PDUdtoBmsK3TCb2KI9?=
 =?us-ascii?Q?NaAY+vMCo/zI+aymhrsF6tNn+IRfVFI0bjq7+l/6Az0UBuIcMdHbU+fIxtyy?=
 =?us-ascii?Q?F206hGZEnU7JZgcsImgMfJ08f3nzKWvZSLOh8VN2/0BO7P9HRCTppwHGaKOQ?=
 =?us-ascii?Q?n5u0KjX1PV+Su+jYblwqxsooMXoV0vasFjOmpzRk/tdsJJx0jBQ6E7yx8Pn+?=
 =?us-ascii?Q?YUJFHgtkBiPssteYVrQFEP1FQbQ1iBsM9n9mKQrnRd47sgIj0x80ZLqTtzkA?=
 =?us-ascii?Q?euCdhbBM2NOpHXrrZ/p3oCkKciUuia62FYHwpQRJsvWQttiZFlYAnDTxWwjx?=
 =?us-ascii?Q?HudExrW8bficU9K6xeB85tc0MARGWFm/RxfkGuOcIH/YrMvj0s4MGUZ7bhNb?=
 =?us-ascii?Q?FekLouoKRaM0gqmoFj6YCGNf5ZWClWuedsyoT8OS0SoX/Te0Ee9gh2ZdIvRm?=
 =?us-ascii?Q?bns6mZ2aveSP+R08H6U7XD1NcMJ0iwZVZ8AAVX8Z1gH73RZ13A95rWzhRLYf?=
 =?us-ascii?Q?JtRsHzSFTLuUqqWdqg7s1x/WT9qmfnDbjtEYBoayNnunrhJ1Z9Eq1oNRqz6r?=
 =?us-ascii?Q?Wi/pg+dmd0BeKHQtv42/tgEel5c1IOwXark6MzNWPYGagdIE+8j3oD+ODlmZ?=
 =?us-ascii?Q?X4PwUsuHVsHZKD44J4uiNROtnlr4gPYkXG2I6f4M9vpC1tk3kF+ibp2pSSPo?=
 =?us-ascii?Q?U3Ja2qmBuzFRnHEV/59tG5sgW/nSAL2wAn6wxjWU0M9YFEEAAd4FTkHCLej2?=
 =?us-ascii?Q?cHszm3RuWTETJ5ER0yhcP3HcgV3Po+bc+soNZjZUQwRCA3vlWo6oq7vVVDzZ?=
 =?us-ascii?Q?Q0JvakA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qbGGNaTXRTWxJ06w8yCAC72O2Tmqy36cfnHjKbqPO2v895tdA3Nu68qnSqZj?=
 =?us-ascii?Q?DkRvbjxfCW74XWCS4o9At3LBIU/Vl1wGs6ngPcwH7zQWcv8Hjjujx/oDm9i2?=
 =?us-ascii?Q?l71VgdumWa4nHHP6Tn7RSNajmxcE10GKn5yxLoXUJVmsUAaqVsU8qAw8zHyH?=
 =?us-ascii?Q?cJYHtINbQf46LVvqfNzCz5I++MZlkfw8HpQs4x7l7l9m3vCZIq4xOHDT9hUy?=
 =?us-ascii?Q?jUWKgtQfv/4HWFI2VzExH3jVxLwxO5fOYJE9bWzCnskTo3eOlHmiByXONAWt?=
 =?us-ascii?Q?OCte5L3eNEkJ5ths3qaW64uyQsa85lXpSt0l9Y4yhojQs63mws1NuLH8qNLw?=
 =?us-ascii?Q?Rg1QQXvfVmCtkPUC5VGyXQkcL39LFKeumzyeV0AjM6pFnDeSeV/0nWUs+blm?=
 =?us-ascii?Q?P+eLtU4t1UmHojbhkZQuyuDlV35nq2T0i/VneV8hBesk/6v+9zU1knMTt14z?=
 =?us-ascii?Q?Ul76ZWNkJ9uqnA9iA8K4t8hXUKirRsYRx43lJinAJ+lcJZM9U1dscmjfTICd?=
 =?us-ascii?Q?jrb9eLuYDMYOLZXqOAlN/R2loNow7gnw96OrpIgNnE37np2GNH//BwV3Tj14?=
 =?us-ascii?Q?SBDqf+PHzTJV6Bnz0S/NutA88Avdfvrs/QnFU/Uditdlplmv3kGfiARUmU/P?=
 =?us-ascii?Q?S6hZxn7sBHSIZbIZ2XU+2mrVWl9dzIQdO5GGf6cqss7hmh49+H2B3u1y5qqV?=
 =?us-ascii?Q?78g5rPoBix1VInsANXWi0hZ9joU0xLOWyMq8ePAmQ2lYJyx1F69kVZv4p4l/?=
 =?us-ascii?Q?WAbsC+pTZe2qheymKh81JDW9D3KRkUNj5RsLzVxGuwV/jvt6yA7baexAEbME?=
 =?us-ascii?Q?lLVYXs2i51bKQpMQ0nTFITHwrEAIrLLGg7gMvIHImH8GWH1sUm2DFonf59K+?=
 =?us-ascii?Q?PQoWsO2iU1C8heHk74nKv3VYsxnkJuapik8ECfYCYbj9ILiZUymdxVz5ZePN?=
 =?us-ascii?Q?SMKB0maCWLlCFUkwMwrkM042qhNSJB8zmbq67gTQvW/wRV0tSnx2VQC6u/jM?=
 =?us-ascii?Q?gOdcTkgFz7uNn7mj5QtVHwMtMn+4EPLPiexhjxUNQUDkwGmiFh6Zcr68gktZ?=
 =?us-ascii?Q?AziWg1gfLvYABzq1kodNRbYm45LQfs7wzP2sBKhDpEqcFRgZDtsie5u8TEuw?=
 =?us-ascii?Q?ein2AtD7OpI41KcfW4nrX5uFDSUDwMxZsVnMIvCn2bKJdtQZ/KgX7cSpzlEJ?=
 =?us-ascii?Q?7mJuE3i8scGUXVlHvIo/zzeJjvqxAe1we6t6Ue7w1lPh6XoFx5KukM6ZhwXA?=
 =?us-ascii?Q?bG/l3sPeWeMj5JPWP0OudST2j31gHNYd6jW2zxjdo3pmYRfkq9x5mRxhEf49?=
 =?us-ascii?Q?GWlPTWYCo/EXt60UATv2dFMJvIl3iWQMVxxZxNxACMq8p2wZcK/KeC9GQlMS?=
 =?us-ascii?Q?4Nqbt2dprQrP6WVp+zfHcNhlM7VnSXGB/AKIrf7E7C3H6ahRnXeN0bCSEcyX?=
 =?us-ascii?Q?x+CUymqQ9L3ZgX3LyeNkCDiqUA6Fwk+/hgivUjDR1yflbv60j4WnSEbvXGQC?=
 =?us-ascii?Q?6ZSIYDH2YFp3rOFEc7a7A7E8C1u0uxPKM0+r8BfbXWhGFjgg92+OGsGzZRLO?=
 =?us-ascii?Q?MQtFFUxBOBnpna2TN0WoctSI9e82I0cHrShVHJiq?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45566c97-8830-44ff-e11b-08dd034ea09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 19:17:19.3199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pcZcxMNjDJZgUasr+qJxZocCVvITrsXYo5gWDIoX1RLerJHxbXeJd8WfK32LZPC6jtkBhKGBFpc2xqn/Nah2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9552

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, November 12, 2024 11:15 AM
[...]
> Subject: [PATCH v3 net-next 2/5] net: enetc: add Tx checksum offload for
> i.MX95 ENETC
>=20
> In addition to supporting Rx checksum offload, i.MX95 ENETC also supports
> Tx checksum offload. The transmit checksum offload is implemented through
> the Tx BD. To support Tx checksum offload, software needs to fill some
> auxiliary information in Tx BD, such as IP version, IP header offset and
> size, whether L4 is UDP or TCP, etc.
>=20
> Same as Rx checksum offload, Tx checksum offload capability isn't defined
> in register, so tx_csum bit is added to struct enetc_drvdata to indicate
> whether the device supports Tx checksum offload.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: refine enetc_tx_csum_offload_check().
> v3:
> 1. refine enetc_tx_csum_offload_check() and enetc_skb_is_tcp() through
> skb->csum_offset instead of touching skb->data.
> 2. add enetc_skb_is_ipv6() helper function
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

