Return-Path: <netdev+bounces-143695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE69C3ACF
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944991C20C35
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A5175D50;
	Mon, 11 Nov 2024 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1qzptZ8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EC6175D3A;
	Mon, 11 Nov 2024 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731317169; cv=fail; b=btPMgbhQiVewx1bJNsJr3vCecL5XER8l61+skXjzqbTrb4sT192ZNfMx2mRNc78UIX5NlwkPn89gaS5ycxZJpQuBhk2FFn/yP6iVMlfgLVm8OlG4tYsiEYjHSEleZetfq5vdFQfGMso2trdq+QEznSbMwJHIcse3ba6wRaxQUC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731317169; c=relaxed/simple;
	bh=wbZnOaBVn/npd7DIu2xL+Dz9ecC+IKYb5P2RU9QKN2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YhQtnJIVV5t6SH5EimrJrCX3WHPK1d2J4mRarFGEQaIvVY+QJalZpcKzJiP9bPAJF/5aNvMbe2ixnLwzAhtzEFr6Hu/l4s/ZJc1Hr2EHiVluUsov3dmZv/XH0s9QgJRwNBRV6Cr9wTNOk98qmmr//agUIlFgFbuj6Xz2EU+TULI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1qzptZ8; arc=fail smtp.client-ip=40.107.22.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCySVmLs24G33gg+Jdlr2zQXPxVxJ5Z7CBN2+6hcWhzC4PMDcyAVrxKfq2QgEKXBU0FJlhauuThHKPuT9Bq5fpO2biO+rfcb4BPaGqcbK++9p76ob0HhwEWRqSCjFDfNT1i/vH8xo8UAO5SD1tuYCYoKgud5fpCWKU01nyS4YTSpOx1d7h7W3dTrldrumwkIfUnCGXRWC9rpOpcccPj3p6xYPWtf85N+uxbZ9Ofstertk//1Md8rNQBdYRZyJ8M1zXsAmBWToIp040BMY0vaDYFnVmDff3StYKob6Rwq6iqB1uA5aAQNDh8HSKKTq5b9zktlP+3QkzMs5IMJAqskUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10is/0hJrJpXdJ4Sc47SPui19iLy/wbnYQAKfWoaoSk=;
 b=VB6AyqtdZgYUGjC7R39EHvcDE/A4R80SWbL/bsgkBdroWle4Zerokzzm2C6BiichJaRteTLSYUWvceMyCPL4+w4zJUOPXPyIqJk27/dgyo7sLteiLflnC30Fq2ClH4Rz6LIjBcWk08wtfrLGPwvbzx6j8SV/LheNcGZi3YUSBJK8sW0FdpGbcoL/RPP4fOaYp5qOD0XJeY4kcwJKVZw2RU7nkhz4iHCV0RDGLGDaOEGeV3h/I6FOQ7QsYI/vcev6uUAaLDkM7GjBXiy8DAdCeO/JWFRO8z1M1bD7ALLluFSdYUry3wuhfKz9EFrLHiCoB39hRaXkUOAmWDhkiThoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10is/0hJrJpXdJ4Sc47SPui19iLy/wbnYQAKfWoaoSk=;
 b=W1qzptZ8Rf8m0fVWSFibsrMZq7zRij/aOYOtHVwjqKWCvB2+OkyXJlCUei6f1q7DmEhJi/9qbzIwMtRIaeVEselqVfc3+9EavBTKemd4JHmObfrKjYNtGoiryC2VCj6zkMhlm/a9dVM3laLWPnAcQyArJkOEsbfLrWPI36ouJ4QXVZ2ztAiRoZwmKAYvyO3i10RRoSTn0HQkGMfQy3iTPvQ6EyJ32y1G6K+bEu22wjy+mIo6K3Z9U6tUYvriC3UOi59C3vAD4Awbmfb0Ua2rZhXsj5kE79UMz3L0MKxFKW0+P4TTvbotV20bzotFza6F4K7EGV3u92kuUzavHt3Pdw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8221.eurprd04.prod.outlook.com (2603:10a6:102:1cd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 09:26:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 09:26:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Topic: [PATCH v2 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Thread-Index: AQHbM96Mok4WQFp4gEq5F3KBlp1btLKxrksAgAAekwA=
Date: Mon, 11 Nov 2024 09:26:04 +0000
Message-ID:
 <PAXPR04MB8510F82040BCB60A8774A6CA88582@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241111015216.1804534-1-wei.fang@nxp.com>
 <20241111015216.1804534-3-wei.fang@nxp.com>
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8849F3B0EA663C281EA4EEE696582@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8221:EE_
x-ms-office365-filtering-correlation-id: 9385160e-699e-48c6-f4f2-08dd0232dd7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XLRnT37G2ne5eDWvuueSqxpenaB1I0gjVec1M1gtXEGOF3n/B7B16St9CscP?=
 =?us-ascii?Q?xNgUxBYzz5Xic2qcD065F5FtddeUnuPDlAsIIW2fwJ/e5Ndt5lcmqZPZVI61?=
 =?us-ascii?Q?ZzceEwK0liofvvptkoKjjlMpSji+Qm7mOUs+95hGC6dlOTJ68nmDBOBVju5M?=
 =?us-ascii?Q?dVBEs6ioXQqMqOIx5v6STmOvkFUaJv/vgIYH8Jj7073Dyv3airFJA0O8aOPy?=
 =?us-ascii?Q?WPc/YfA8L5nxnZuBNtz7TC51Fh63FbDwAGJ5SLBFcAwIMAxOVR0blzvtAx48?=
 =?us-ascii?Q?BYX7mv4BInUM+w4oCFI2fVKLLieeBvpQD1NgB94s5ZKXQMWfkRYXMtOHZP26?=
 =?us-ascii?Q?Y9Tlwc45/kam7uvKOf0rPB4ZCDbtyJwAiiuwDX6DKuyJTeBVxDBsrrJoopYN?=
 =?us-ascii?Q?PF3J55rGGP4AEr8/+HeTPEtTfIKdFy4cY4rhoRDQtc4fXnDNDhKXHd7Abi/6?=
 =?us-ascii?Q?uYf9/8nNSZMGcibBKShkW69b2pu2kM6tvVDDFMR7RjjrsQHdvKmmepkC64Bq?=
 =?us-ascii?Q?N2/2DbMJZRziPGPhyYUwoTqOy9CFuZElIlB826qIYnmWAwaDumon2lsnfgo8?=
 =?us-ascii?Q?5ngevIwS4c55ZN8OqxqWd3WMN+ESr9aUnSuhsVB7qpZKov3GomQIiwAQD3eu?=
 =?us-ascii?Q?PxXkKBrb4kBsymJsD876stPPIr2Y+/6Qbz4aeyxW3d+CkMhsXLGUoAfz0wiP?=
 =?us-ascii?Q?9lHLAt+rIr8JHHKI69Mbr5e98sFnrgekcYmtgMKm1s6dFL8auEtxlTU+jLwT?=
 =?us-ascii?Q?mEDmwiZLVgqO0XqMThQ/RuYTFU2ox+AsOS/EzADKOVuBuA/UzSQ98K7lJWVc?=
 =?us-ascii?Q?qvUCE7xOdTYdjvl8O6kSJlA/9rdEgfsM3ahdo1C+5zwROFbQVYtSi46LbOcX?=
 =?us-ascii?Q?asjnjb/nk4MF2sN/QRbmRCYwd2/yxPDzI+qDR+0ejOuT/jDxmYYIC3UGuPBf?=
 =?us-ascii?Q?H25XQg1xySpjAVzqkEmTV5Kwc237q7MlOQp2xEKholQybymsBa5E3p0ATzcT?=
 =?us-ascii?Q?FerV6n/3UeBpHpM2fiFDuDGTyDDBZkeTQu85/GEa5Sv8GqE3LPoCN2X/SgVz?=
 =?us-ascii?Q?8qTNUgfS90dSAbgbKxw8zOrun4QA3EBIDm9kR3NGjJ0V8aypFGuv3YY3/cPV?=
 =?us-ascii?Q?s8/x316i2IZ29ldrhN15runDK1DlJ73vwv4T637RvFSWjHScJd6sHK6mpYTY?=
 =?us-ascii?Q?HSyKnLeWRjmkD+f8mbhqRTxKUg1E6+qgDpYikftOEnUErBg7sCfdmaRC9nWi?=
 =?us-ascii?Q?Aoz+IW6ZZKHyWEjXT49KDAJX5yh/ARexEKbTg56eZGrv7RXl+RjNft8YuTw2?=
 =?us-ascii?Q?SB4WWmTzoieTtylMZ8bxyJbPqi4UrKTxRAF8KvV5Cts6lnppLMp5ydcbQbRT?=
 =?us-ascii?Q?Pc93s5c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9exJS8kB8bQ2i95lHVUYfIrJPAJuCdeaf4/YNGOcd2U7TJUDzOljOWh76LG2?=
 =?us-ascii?Q?5IVAyRvznuKiTw8Blp6TZQGxTkL/qPBa8sGCd6tqWhm3+BCp1xasqfTkETke?=
 =?us-ascii?Q?ht976oKDHhtowlZf3UrmOegoIyfoVI1ydCED4oii43ZK2gLYvJW4t0m4FRhF?=
 =?us-ascii?Q?cdCgfH+6Q+nA84bCgQEvtU7oMrzF8zCcAhvfl2jUYmuDqy8C1m3WhX5lh3pX?=
 =?us-ascii?Q?z4/fisyzNxWNRmOMh8vuJ7BpGPHuEcFS+dT0Kfxi34PA6uLHYo7N1ABnnoHU?=
 =?us-ascii?Q?+6wSpZbQAQiZtLz8GBtGHfWSS/WO3ah0QfWvM/F04Ru2FGqkO+RnbZ4Pht+G?=
 =?us-ascii?Q?l8wrTInLKcYn39ciOzDdfe+dJvzzfnx2BF9XH2zAdDfLrbteneCbL6B6D9Hm?=
 =?us-ascii?Q?D1X7lZO+qHUETSgIYer9/hXP9niOS/2OqulLkzx/9rCRB+6c/IVr+tLAl6oZ?=
 =?us-ascii?Q?n70hwReaeuPtkjYJEpZgVKT5zbGwfuKSLq/uproXfFrxzfr8yF1SDh1G7FAP?=
 =?us-ascii?Q?+qJJiOxOsOM2iUP/uME4aA5dDxoQv2n8Qtc0gqoSwQ4BE5uk4nlz4vs+628O?=
 =?us-ascii?Q?AvJqBKrjG2efE/bDPvOisA5tQcRJtNUylXtIgfbmWmxTcp7MBWf291jURxhH?=
 =?us-ascii?Q?rcJyI02IK7eT+gXqIcGh27ff4ytypDb/+aU1kR6u1J2qrIXLc5PeMfS6000R?=
 =?us-ascii?Q?kvp8uePcn18Or5PsugPDq6yriUuw7fSzzm1GC4Kz1MfxX3DpYZfU4Tbkfnh9?=
 =?us-ascii?Q?sylMq6q5H1k3Q8CMpq/5fCLy+88Tki/tPHYsKn5oRhjAKTb5/Nsd2y92ef6D?=
 =?us-ascii?Q?qAJlJ6yz3IWs4IOLP+wOpBtc7QVGvFCjeKYeHkU6e0xKMsnBBDv2hYGFC4Xs?=
 =?us-ascii?Q?30uKuxjgdTju+aZ3Lxiwjdo1ZxV76U+F+tE+R4GVN7F+a3k3t4nRZHF1b0Oi?=
 =?us-ascii?Q?Ib8fWpG+lHLeM6pDg5PVAbaj51tif20juO//H90di83qkI0DqZyNnNLqxnNo?=
 =?us-ascii?Q?NdxHlCzCzmJ6QGTZSbAHvalEkWc8tRbqCf9gE2vWxJKvXIDhGffXC4OZyDOj?=
 =?us-ascii?Q?pAaKBFRY0cythbMircEnPGl/QrXu/uRK/OlK0DwyF0IbPKKwTz/SIbFnshVz?=
 =?us-ascii?Q?Jwe1PXVdvS+Nqww25X6pA1SOZBqFfk9ZO+SMOrxOvyjgml3BFwWTdi6Eyo8h?=
 =?us-ascii?Q?YsRUWrvUqRsggxyJylFYmjzbHAWvhk2Ex6yhOCHRKFjGoskS0iOQGiOq+erM?=
 =?us-ascii?Q?qPwLYbg+5rsCo0mRSMAZj8NMVyAzGD3RjGztGoLazNzUSCVFrVE2qchLXwI0?=
 =?us-ascii?Q?26fLPhm80KVFpR2cIU+t5CxZwHbeVvnJJtpXhWC1PpT2OupffE+W23W8FFv4?=
 =?us-ascii?Q?KUir9ymV6jjeCdXnTfu7CZ0XXlvykiy/mt0YtM1gxF95FcFqz2ZzZavBMOaw?=
 =?us-ascii?Q?GUSraNSaDMK9odnUN9XHMgeaNmKFcfhiv0EczAnB3ieRvphvXGCSYToy6xq9?=
 =?us-ascii?Q?iAEGno9TfKzm8MBuuh9hGkmcNkWXQb2lllInaTrbm83iiQkNMxgrDUcCXuK3?=
 =?us-ascii?Q?hBtlNpIlh0Qy+WbTYc4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9385160e-699e-48c6-f4f2-08dd0232dd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 09:26:04.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7r/8vC6HX9CvQ/pZoZ/6eKDtxH+tNI6ZK4P11EfrbaOO0HJdq6F11Q/AUTbPk/J3XuR+Z/5VVeCF358gDYyISQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8221

> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -143,6 +143,27 @@ static int enetc_ptp_parse(struct sk_buff *skb, u8
> > *udp,
> >  	return 0;
> >  }
> >
> > +static bool enetc_tx_csum_offload_check(struct sk_buff *skb)
> > +{
> > +	if (ip_hdr(skb)->version =3D=3D 4)
>=20
> I would avoid using ip_hdr(), or any form of touching packed data and try
> extract this kind of info directly from the skb metadata instead, see als=
o
> comment below.
>=20
> i.e., why not:
> if (skb->protocol =3D=3D htons(ETH_P_IPV6)) ..  etc. ?

skb->protocol may be VLAN protocol, such as ETH_P_8021Q, ETH_P_8021AD.
If so, it is impossible to determine whether it is an IPv4 or IPv6 frames t=
hrough
protocol.

> or
> switch (skb->csum_offset) {
> case offsetof(struct tcphdr, check):
> [...]
> case offsetof(struct udphdr, check):
> [...]

This seems to be able to be used to determine whether it is a UDP or TCP fr=
ame.
Thanks.

>=20
> > +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP ||
> > +		       ip_hdr(skb)->protocol =3D=3D IPPROTO_UDP;
> > +
> > +	if (ip_hdr(skb)->version =3D=3D 6)
> > +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP ||
> > +		       ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_UDP;
> > +
> > +	return false;
> > +}
> > +
> > +static bool enetc_skb_is_tcp(struct sk_buff *skb)
> > +{
>=20
> There is a more efficient way of checking if L4 is TCP, without touching
> packet data, i.e. through the 'csum_offset' skb field:
> return skb->csum_offset =3D=3D offsetof(struct tcphdr, check);
>=20
> Pls. have a look at these optimizations, I would expect visible improveme=
nts
> in throughput. Thanks.

For small packets this might improve performance, but I'm not sure if it wo=
uld be
a significant improvement. :)

>=20
> > +	if (ip_hdr(skb)->version =3D=3D 4)
> > +		return ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP;
> > +	else
> > +		return ipv6_hdr(skb)->nexthdr =3D=3D NEXTHDR_TCP;
> > +}
> > +

