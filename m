Return-Path: <netdev+bounces-145709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D4E9D078B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 02:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 408A5B21204
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 01:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72614263;
	Mon, 18 Nov 2024 01:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T4vUxoM6"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F7D2FB;
	Mon, 18 Nov 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893003; cv=fail; b=W8aFBbF/pu0wdg9C/b2blgn14h4KKwJ2mnhPP6zXAZ42sVHQPjeq4/dtRjAVK9sbFasPxqXns7nJoB1elmmUkNJ2Flr6JD6VtDk/XfrtCTlYTyKXc9NicTzoJ2/C9oDzcYUTXiZ8QRrx1JxVkBNhaFdITep+WOct1AAvuU3OBms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893003; c=relaxed/simple;
	bh=th9lKV+s3J4FNMK9wrqSlEavvofUj9zwgZytBSJIvFA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aJiEELyKICyn5x6jgX9aZyW8DhdELMrTdwHSae/8FU3aa8mfRknJ+9xkQUoQU/n8gqI76pyosPrdyfFH1yWeMF5T3I6PRCo8Rtdh9ZFRM89naHPYusoH8wm4OcdOsQol7TyChQX6Pifxz6X6EqN0ELiKub5gopr+yGTvPv3jfC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T4vUxoM6; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RdjnjfepK9J9IG1yNSWS8LgSWRk12C9hgFalIxEShTe2AxgBI4YQ0pxAKrE6hv4JLg2VznwVk876/D+UzB1fG9smyLHTP73sKiEbt6XlT03n7ckjrz54Len+xB73mZC6R6zWI3umLEoyEEiItsfhS6yOJIxe6zclFtvIqVluWpQkCK8wW0HEWGlGIPXG43nfDg4ZeB+qbY1MkH2vWYQh2EMsjqCJWiQMdNZuau27S6sU6AlkQLnI0llrhi8ca97WtpjSJAFbcK1StrkX8/Wr8anK7boHGLAUI/1aoeY7Bk7yfzd2etaQhnajY2FKObKfFfd7s15mJrifJsNBWHg3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNBer0psvK+rZoym+inEYB/DUew8FshfFU7WAqOCPLE=;
 b=Z92+oHsx+kf3qRYvCh0TZCxdx1MbBT/2pRmCrkISTGAYo2h2Af8wKAo/xn+43Zp+5kuhwoo29OJjYTP+xkVQ3Pjb9L3Uetv2VOjbW7TklQoftIApkEABeCVF35b9MdrBDmtNEQZZ7owCO0WU8wmxIM9d/XcFaDeCvmDntYelFk954jATteITF3B/9bM3mtqY8yV+SBwylF3b6hO5siEShGXOGPRd7KnLjq7V65hqhWBc3S2VowZpMyl+Y17d2DiKf1RN5KuG/ZsDCGKn7z0x4U+XkhiqKDXsgeFFI7CTNx1gha8IkxLLWUA7GQSyge0LcMQWcMKVKYRaDiJxIUiFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNBer0psvK+rZoym+inEYB/DUew8FshfFU7WAqOCPLE=;
 b=T4vUxoM6J9vsnQMk5DfpofiYdnZ+ZqcQZXUoD0bd82ung+JuLGEbOG+sLaShg0+TnsRT6OqwB/1RIREaGfsYEvpQO+AU124TogPV8jJTOCCarTsJN3Dt5a5cGlDMsOM5DUVVVkda0ootBGTydxL/PrtCVh1usPR1g2dJH4pUG5a/yXXEtRbyBGQQJ9fHcXdnyT9e7L5g7DcXiWWZIZ42uksV5cu7sliaOkFYvai/i0nub/f1FKv7XOncMTgFwyDdjVQ584tOoxijQskXF/h4lZvvr2bHzq+owT9yL9qrs3JzOyOq9dTgA26m6aOEJRL9aNX3lirNxHJ9gz+QuBLjUQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10874.eurprd04.prod.outlook.com (2603:10a6:150:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 01:23:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 01:23:17 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v4 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbNwr1A8eHkh5jjEahHHolwfLwKLK5OVGAgAMJU0A=
Date: Mon, 18 Nov 2024 01:23:17 +0000
Message-ID:
 <PAXPR04MB851082CFB4011ABB615AB20A88272@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241115024744.1903377-1-wei.fang@nxp.com>
	<20241115024744.1903377-3-wei.fang@nxp.com>
 <20241115190033.7452392e@kernel.org>
In-Reply-To: <20241115190033.7452392e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB10874:EE_
x-ms-office365-filtering-correlation-id: fee4a2c5-db55-44a2-b4d0-08dd076f94e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZWc8ZLCiX/wNipXtQNKAVPgGe2K7t69Q8xhXZ5XCiXujnX0iRLmIjLRY49B0?=
 =?us-ascii?Q?ZthCMWxr5tlOS107Z4rt4vBN2j8os+3VvgxXPNSNaKXE468vr6ncMncCOhf/?=
 =?us-ascii?Q?0FRUeN9Sxbo1flXFLZg+XWbDSL1TuCf4J6b7kX4zdADjCsmSxi+cFFf3zvou?=
 =?us-ascii?Q?v/aSk2MK0AhY4KU0rGzgmriM4a+AjtplPYkxzBIlItC0zLT5Tq9GzNnaasHl?=
 =?us-ascii?Q?AgmVBNzxIgKILDvPWIbMkKtWf9qfE9pDq1SKhvZI74QMNEibP+0+VcPlUdNA?=
 =?us-ascii?Q?C5PAoM6nMHfivGPRQTbHzZbtKrp4xyRKmDKMdpi08rYBfCYMY6ejqEs3ZWQy?=
 =?us-ascii?Q?3SmDRdRJRQg4jl7mGkYb/VTaMdJB173E43PFatJrKk+KncPyfbZdXwdp7B8X?=
 =?us-ascii?Q?C2422rFivGX/xAUGXT4mSx69L246dAmJltH1QUjFjKFAuo0ZnAH+2iluZhzE?=
 =?us-ascii?Q?lyBc9RJFDDcw3rBgOqHF8BTYSBjs0pR/X6WLPYmfYe4OIp0N2flH4++oilZ3?=
 =?us-ascii?Q?DPtqSmFyTZeU1TQK2XsiX1GPpmmnjIeG2bK6MxZ0JxYvnvzt10WdkYC+benQ?=
 =?us-ascii?Q?pm3aRlOKOAqx4ufLdZDg1E2vQnfkdKzdm3JSoip7p5ekf5SU6rCCRlAHXaaH?=
 =?us-ascii?Q?nZyRxkB5IrskJdv/390jv113LPHXiDID+NG7wh/sjVNlQzJI4EUggf8MQNt0?=
 =?us-ascii?Q?hyBSNGtkdMxZItKpbgOVkkpuOQLEBckOzdCxoZAaJRTRG3UIkejOqi/PrScE?=
 =?us-ascii?Q?ULTINZjcejtMdvzf6VBluFv1PzYFNoFXg6dVAvk359tynzmHgNbwtgoJGYPU?=
 =?us-ascii?Q?DiCNzaG0Y31QxOwQ2aQSTW+4dHW05qDi8Qb+cfbcCVmKvKCv02ztBT+82J3d?=
 =?us-ascii?Q?moOOgVg2U9tKHCeYYU10lTyPzyjsdK9K1J2wbgam6VR04SXnYMqMf1/Y1X0N?=
 =?us-ascii?Q?Kowc41XA2G5KeHksYA1Hhn97eXZKOvE3Ya0gEhJOCMgpbtO1ayCDE1mpzuf9?=
 =?us-ascii?Q?AGKhv7tf4XDQuo6nHoyxbBYFHf84eoDEHCodL4Anf9fjUl1GKJfGddAoRZN2?=
 =?us-ascii?Q?S7+UZ3BKtB2z7k9iQ9ZChtQMDG0QKLxZXVz00Z2YUzuix3Ki4iADkcWSeJZ3?=
 =?us-ascii?Q?Q49tyjWY/TsrwArKSkBBbsMR/DZQWXw2vk7dlM8gz+JCQsD/bp0DE9+ObS3h?=
 =?us-ascii?Q?4Kot77d6BNpFWLAg+D5MJB/i1+rhpdbnUnraziUcF9XyHnbZ+BBS3TgCKBl7?=
 =?us-ascii?Q?/av7w4dvxn774eZ8+Ov7pQbplUP94S9DfrCmtXE0c6LYF7jTpUBU6YxRn9HK?=
 =?us-ascii?Q?dXRS2qG6vWwmuJIPojxSpoKxlOUjRnq1CiXCaxN+9vUiBqAJiK9A4Fexm12i?=
 =?us-ascii?Q?efzGVNM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kQ4SsdE7pTxeyKUbfPI+iq9P9dr16f673UeTk0LQn6jneBeNhKEroRS6MahP?=
 =?us-ascii?Q?zawDabwx1er5aPo0V8A3ukMIeMegEEcsRm790g5JG2jGio8oMX5VVpZcl9fX?=
 =?us-ascii?Q?D1BuJ5IBvWvAunnre2SE3jORCUyTSRDDoPm/ZIC3wYp1ZenVjTq94wq6nl9X?=
 =?us-ascii?Q?bl43e4DH2OAwNmr7b/9Cs0N8/Blq3kxK2ufJK8sKc1iItZ3kzTTP1BhCsCIB?=
 =?us-ascii?Q?gyoUmvSGjZ5JiLwCQVsuGbQQGUAJoDhnH894ycBQ+QcD3CxblalKHBPGCmYs?=
 =?us-ascii?Q?ykOHmPntYB/Agk0Qds+IMHPsTgbZx4qwXcE/XeT7uXF78lQWebk/7Y7/WGVu?=
 =?us-ascii?Q?tl1axVXDta+4IvjZN4+L8AjgYxWg6Kr4dONmqR7L9fsUY4Xw9a7XSZ+tYfPW?=
 =?us-ascii?Q?PFjJ+6lb643XTRs1qo1msZFJgkiArQQQA4WNLulppOFhq97PCnJr6zkY40mC?=
 =?us-ascii?Q?KK8HBQ0fOuTp5rCokoShQKeBjuGOcFQSmNNAhK72Qhw1EXJydTiJD4UGBD7O?=
 =?us-ascii?Q?uwZZdABxalfp7hHHst/Za1GiSYYKqYCkI9RVxVHEa1G4e3BSwjLTDE5T9cWB?=
 =?us-ascii?Q?AzrMrpd722PYzMpc2M+GoeE7CG5pw9emQes+r/yRar7Gx1C/FV5exInt6O3F?=
 =?us-ascii?Q?bMO7BvD6WPGOFk5MeGJAxIoNEr5Xk1HnkMPWzI4Ugy0+CaAr6js1RANnhztD?=
 =?us-ascii?Q?DZLFThgCJCOD7967Z8aMn43G5s0lMJs47q1ndz4Gj3NNwk0lNAhkyYWxQAt6?=
 =?us-ascii?Q?QnZUUHqoALFcOox2kxKv4P7UQufy3mECdQ6PQ3xo5Zx+F1wChS5Yzwg00HxN?=
 =?us-ascii?Q?Pzs+BL0fVEHAwdHKVSzkco6qWYXqvKJYJSc0pN/H/P5wNVWOijyR632etc/v?=
 =?us-ascii?Q?Stmv8RxvzLrUzBOCTJnIB84XwcjrUbySoeHBbKCUybzmtqwCOXaKVZ9xk7+6?=
 =?us-ascii?Q?LBjquIxF9B0CeUrP1pePckSIxYwyLgxHzu6JNcDh2INHcG6lrSsMjAyKTfWR?=
 =?us-ascii?Q?lzzl/SOzvfChXb5QwM6elPrj7kVuYHyq2N80OEqXBM+IPMj8BHLyO4jB/pPF?=
 =?us-ascii?Q?lJMmn3EYG283AhBPlJUJmi0TQ5L0oDYEqHqCBrJtLqZer65XA4HEg4k5kc9/?=
 =?us-ascii?Q?ttjj7NHapZpvwo9GVcgvACrJQqX9X/C9AV40ZtrP8u27he4oWhyE9OnuUdUI?=
 =?us-ascii?Q?EF5FjsCXISXVnx5wISc5IoofdOifhHu2J/TrK0EGxU2DfL6vX4VOR3oNklFR?=
 =?us-ascii?Q?BTKkOYjXk8MIOu1y662/1Vei9PpqVcnbYMxwGkmExxvKkb4idpiQNWPs4w/a?=
 =?us-ascii?Q?YTHZxOVBHDNdCeFAk+M6n6uE1yrDN8CDxyeUV88xfYuTFVbkbVsrr+WSRqIP?=
 =?us-ascii?Q?WJfxDcm5c4NAVdpGT93ORkQ/JI6fSqCXP5/7qn7xZVn0sC5NK0aOT7wbtMuM?=
 =?us-ascii?Q?wBrAvPkWOm6SYqupYofLr8876ZIsOy/vG/zP9DQC+tBkIdb10YY1S6hPUrkX?=
 =?us-ascii?Q?BaJqfc/sSpql6ZqeP+Pwqdfj4dhiVG25/9T3iW/29N1mQMCu5fifutHHPEbY?=
 =?us-ascii?Q?tYK4u7pC55bwUIBI5WU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fee4a2c5-db55-44a2-b4d0-08dd076f94e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 01:23:17.7151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dFDf2CgdqTGfAFmyWNlSgdCcJVpP+3pL0EgdgtCbVEnBX8CQB80ezzU8NfnWTEvUi5O08K7sbPQwRdkCfb6Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10874

> On Fri, 15 Nov 2024 10:47:41 +0800 Wei Fang wrote:
> > +static inline bool enetc_skb_is_ipv6(struct sk_buff *skb) {
> > +	return vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6); }
> > +
> > +static inline bool enetc_skb_is_tcp(struct sk_buff *skb) {
> > +	return skb->csum_offset =3D=3D offsetof(struct tcphdr, check); }
>=20
> Please don't use "inline" for trivial functions, compiler will inline the=
m anyway,
> and it hides unused code. In addition to being pointless.
>=20
> >  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct
> > sk_buff *skb)  {
> >  	bool do_vlan, do_onestep_tstamp =3D false, do_twostep_tstamp =3D fals=
e;
> > @@ -160,6 +181,27 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  	dma_addr_t dma;
> >  	u8 flags =3D 0;
> >
> > +	enetc_clear_tx_bd(&temp_bd);
> > +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> > +		/* Can not support TSD and checksum offload at the same time */
> > +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> > +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> > +			temp_bd.l3_start =3D skb_network_offset(skb);
> > +			temp_bd.ipcs =3D enetc_skb_is_ipv6(skb) ? 0 : 1;
>=20
> Linux calculates the IPv4 csum, always, no need.
>=20
> > +			temp_bd.l3_hdr_size =3D skb_network_header_len(skb) / 4;
> > +			temp_bd.l3t =3D enetc_skb_is_ipv6(skb) ? 1 : 0;
>=20
> no need for ternary op, simply :
>=20
> 		temp_bd.l3t =3D enetc_skb_is_ipv6(skb);
>=20
> > +			temp_bd.l4t =3D enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
> > +							      ENETC_TXBD_L4T_UDP;
> > +			flags |=3D ENETC_TXBD_FLAGS_CSUM_LSO |
> ENETC_TXBD_FLAGS_L4CS;
> > +		} else {
> > +			if (skb_checksum_help(skb)) {
> > +				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
> > +
> > +				return 0;
>=20
> don't print errors on the datapath, it may flood the logs

Thanks for the comments, I will improve this patch.

> --
> pw-bot: cr

