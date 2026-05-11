Return-Path: <netdev+bounces-286431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOaBEkRKAWqKTwEAu9opvQ
	(envelope-from <netdev+bounces-286431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A48D35078B1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 05:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB163008D3F
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B5E157A5A;
	Mon, 11 May 2026 03:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ctkVSdzM"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010035.outbound.protection.outlook.com [52.101.84.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8B23BCE3;
	Mon, 11 May 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469379; cv=fail; b=pFlHr8Id/TvhA6M1r8Dkr+oZyosyw8X/Xdaw7YwtzTQ5VCjp5wHnZOMv6dOJ0LbaxzhzDeV2jq68uBCJYOo5RDpr2Y26V6ZpoeKNeE7oZurF99DUyoccOr9FnqrmKrlN/a+Zre/fiWoGqAVN2sM+2jDLh4NydD10ipCcuIzIKGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469379; c=relaxed/simple;
	bh=emVenGvszNF+sWSCz4UEfECocl1hYHvaRhqmMiYLmXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VpKpS/i+J4uQRC+bPsF0MVbYQu6Wb5aaA0elSXtv/XaJZvJPEaVybJQJAIYDS8Ae9LIM8npouWyy6uec7TWpy5B182Bc8bnkTxWqI7nialpOmIn7XyKZbmom3pBM0S2YHfU38Zons/OMtssrv8cVWOA75iGoh2xYS4iP3MS3+1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ctkVSdzM; arc=fail smtp.client-ip=52.101.84.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf3c6y/pRU+tWaJKod1s5qv20nh4D7lkeO3FhpoH0BKfNsIL0ADPV1EJN9+M8bXmICuSz1S5dSLGtxERDBCd2KD70kEg5wlXKzMTx1Wp8nQQeZFoHsKmwVhDJrssIYaaEye0ooIU0O/esq9GlI7ajriTdI0ZCY+tUxdLUz9tufISZ0V64vs572LG1YhskirTfev5WpIbSrVx4OJ3MjgwqmbBWb18cskgvjWz3tYjFmVrqomB1hzCmhC8IL6Xui8UunAHpM5mixwKOaHC9PDSh9kwvo5N1F6V2P+8a7fooSGhbgePm37kL6vZVbOxCaLwRuEA5MNiRgwRH2QMraMUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC9RISrKH+fzgH+m3J3kAo8Adz+BpZRe1eN6bnjeG1o=;
 b=kTtmoJyxk3ehlPv+YWvM1Xyt3+LRKPwQU8o/Fj9t8589RyWI5D/A8LlaRy5MNj64wa3xwfx3pFKllq8GGqD2VEBAXSUQ00gsrHSsOVC+HD7NTvTEDUC+Ra+t7Fpz9RX1vCm0n3atzzDUtKHeGUhYlQH1ZaF0RwpcmpVCzOUjL/7UeFnY13Ir4kSdp3WIolxYKDj4b0Lenr8LqHeIbxxTrk5ysUazMbE2KT8SslGztT/Pdd/iZu9HgwI2AvBuGA4k7zgZzNFzdsyx+abX1aUV4I/kpcI0CbL7iw+LjjbEat1+uFX0RDsh2Jj2JxWlKAgeQ+GQIFf9HmPCY8ym6qRI5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC9RISrKH+fzgH+m3J3kAo8Adz+BpZRe1eN6bnjeG1o=;
 b=ctkVSdzMAiVrLp33+hbuPG8VnL5KdTfIlTrkzEp3v5Mq3mUjhyJvAzlxLYwVoVgtTeYdBr7gJCRlNlnDefKPtD/SLpQDEfvdtDbLEwp+xCWbXH3jqRCmz4SxjYO08d7sI8DM811DH6HGJjtmNWiGkouusyc1v/xpsb3nDRuOkf2BwT2TSEHykAhi5RskYrWlt1DR/DHr5a5gkUCbOMEI9ziazMlzJkBwXDDow1HTuc/Ng8Jgmvh3nAnhMJk0vaWuXo027SS9ejUbhM+2+nfn6uqdv+xB+ky1kgKY2+ma6zcNri/Un23Fu7K24e9Jjdk5Zw4i6YbJRV4MGdfopukECQ==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 03:16:15 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 03:16:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Networking <netdev@vger.kernel.org>
Subject: RE: [PATCH v6 net-next 13/15] net: dsa: netc: initialize buffer pool
 table and implement flow-control
Thread-Topic: [PATCH v6 net-next 13/15] net: dsa: netc: initialize buffer pool
 table and implement flow-control
Thread-Index: AQHc356s80TAE5PL8EOgKeZnF5D4K7YHFeAAgAETsDA=
Date: Mon, 11 May 2026 03:16:14 +0000
Message-ID:
 <DBBPR04MB75003B8627FD78829C98433688382@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260509102954.4116624-14-wei.fang@nxp.com>
 <20260510104839.696E9C2BCB8@smtp.kernel.org>
In-Reply-To: <20260510104839.696E9C2BCB8@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AS8PR04MB8199:EE_
x-ms-office365-filtering-correlation-id: fc122c99-e640-47a2-3aec-08deaf0ba8fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 wjjAJKv+0CkqlmhC27DVNlzrk4/03Rru2j6DD+Yz9m6iSyDPlwKziEd0nReHEDImrCePxLcbOSYgw/OkkPYzSmzGV1zBNxstGUyHAcP/cPGy6NvD9G/6nGCdBICWo3zeBhY+WCE6hwQ4QpYRWhxYD2/c4c0t2y1AkPe5tj9Rx9zyFeoQQe9bqKDMKuM6nKG0zDnNVUgpPZxHxEL1Hbc/XcAgindAknTIFDvdb8FWYjp8Gl6achZ9NSxaYL7cUqMPxQzSVc9r08WxheQFEtORhK5d85qtVwXQUTcsfJFnXVeq+I84iRjPTOHV2AVa6gXwSR9Cs61pHP7rHtu9yydE98sCoJmOuw33203GQsqc13KiD0XKsOu7ObXjEGA4O0DAefSPO4LCdNU6ARDD3Q2W7pQazykBweIQ9inDaA3NzQ4Vzn7G0cVce99YqKwwBuH3d5jEJGBqH3VuzjjhnlR8Tq91HDdeQnVIAjedxQhpKB+VikehiwSo3Gqr3O9omipZrIxNCT/42+MlHGeLdlLTSJzQGnuS4hYB/AvgMDGChq92YoXon1RW2d6fJj962swqvCEnTHFCQv/ejyEGom7B0Menf6tKtqSyjFKHHLLQIhyFByjJMS+6AFH85wD57blv8RzAP/mBP1i+UXQt323J7T5tPjmIqIg88mMImBMi6Fgqakr8ePzHG/Pf3u9pZurxpm9Ex8pN/LhogrhssOihCpCYViQ3N76IAhICJXnlGmbENBNtrcESUKHOMYP5Vfud
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+AF6OXHQ/6EY4wex8ZaMxHYq1rMw4e6Z2WUWn2Dn76T/3BAx1BCq71SL4Q6k?=
 =?us-ascii?Q?zKdJhAoqJ3zWEP0oP9XyvLHC1Hwv2b9CNRWR/uzXoij9xsBeApJ91OL8mKy7?=
 =?us-ascii?Q?xHrJZ8ps0jH5zLShFnOGk9d+Nf2WIanQrasdemuR0112eacyW896HpGnztwm?=
 =?us-ascii?Q?Keh5rd2GCk9EIktz+0CZarDKXT9JQADQ5wHuZKQv3hJtOZrIIb8gVL+ta2IF?=
 =?us-ascii?Q?QPcoacz9ANYHFLgDY2zo4cgXq67yKK2cNAZUX5Zp9OZRP3MyV1N/YxgaP0he?=
 =?us-ascii?Q?wbRT8uYclh+lHX2qMdQ4tjZXpzhCw92z4Zx6Di1Z7+JwasQvY7/Y6tXE3qOW?=
 =?us-ascii?Q?KtnwnRKT06Ex7XPD3S7xrBFOTw0NjYz0XMIl/UcpjizBM6mrmPlyPDPnVQlR?=
 =?us-ascii?Q?gEDGS3eVZwurLcnqEnfdcIciC7mMv0lwpUL2on3b3f0cSV6U0TzQrHA1iJXs?=
 =?us-ascii?Q?tlDhDxGQ4XtpMEWemK+6t6f3j1vJp4guoUImOLpV+KIcVtmOojwA9C+KM8MM?=
 =?us-ascii?Q?m2f82AhliEGRyHThft2wg2cJo906sNjk51NwxV8/Wt2uxo+JMHbNWcYOWf5r?=
 =?us-ascii?Q?uRYLdL0t0Z+d3UVg1q9SVE0BlOtIEKVPvGJE1Y8SNzGKH/mOMv0bVs3xmB7J?=
 =?us-ascii?Q?o90Q6XHSKy76dLTYB1u/xyLx4ThF9IzkNU7fbPiNEjsOLhra24+/Zbh0P85y?=
 =?us-ascii?Q?B1y3YGi7NDtx6faFWK5IyqOucF1GYEl2V96fytz2rJYx9gRKDkC4zO16lwB3?=
 =?us-ascii?Q?T3UwxYl2qcB0NJUEIVL070VlMxk5x3rk3rsVPKLeweoV1I/ZdNSZtNAyGVDD?=
 =?us-ascii?Q?uomoXtlJETvW516FwNgmxzZLeNhTVemPe7RFf7bNLZB6xivm51ypRIja+mKg?=
 =?us-ascii?Q?0LkviqJq5aSjcw10Zhs/U5vlkVlkkN10Chpi/b4Syt1xbVPt62PyWLcJoxlV?=
 =?us-ascii?Q?kcdOjSisFp0swEEugr3Yn991vswOxZj0e1lrwA4meKoriGAO6HTrtSJcmlZx?=
 =?us-ascii?Q?hm7QSUtSkQJMuiEhLHn5EJKMuckZZ9FqmxKe9420LrpGssWI5pczRYUBjTl6?=
 =?us-ascii?Q?16Pg8hb3ezYb5/ScBUTH1QK2l1uqsH6xHidI1sGyf5NHZ3VdYG+IFwoLvwlb?=
 =?us-ascii?Q?2QX97lEEIwhZc2h0tdgJnOjvehANs4Qe/zH9t4PfcDmyXnel/Hqvk4fBRaZ8?=
 =?us-ascii?Q?ppFaI90H4p674LK0YhdBVkMYouRWctJG1d03+M9dvJLwOm6xRKNkOdzrrGy7?=
 =?us-ascii?Q?pHVuXnm6Q5FaqhT1sqXVWT6e9QQtvKrh1nqeKXtoFoBeydTU/aK7M78s0KyI?=
 =?us-ascii?Q?AOoB9pkOaWjaBqE8E1DejfiT08yb9jbN7LccI77831OAPjC3zbexguspgYvi?=
 =?us-ascii?Q?+BaGa2Q6nTCK7gthDBMZyYcJJz+4F4hftihrIPftPauFjIrItj7ZUJj1Mn3g?=
 =?us-ascii?Q?iCJ6VVqViMyjs5fAwrVR/k5BVazuTfQpPYKf9M36UxpeP+/u4Jo7NN8KuvY7?=
 =?us-ascii?Q?rz95zcFTFrhAih9eG6Oz0GNlCoHmxxsC/hJ61xFaKv9itWIMOjHarBEoEkx3?=
 =?us-ascii?Q?4C+r3G7wmIp3q3t4RX41chnlusC+HSef9F1qR0901b9OPIBglP5nGIp1SW+x?=
 =?us-ascii?Q?Zr0mvqK0D+evy/Xd+FqmSH+7CJS1frlMoUuzwo6vjzmS5aeOlvU4H8VAubxF?=
 =?us-ascii?Q?w9oXVw7qNCDT5beVRQWjDbSnIvGRXacPoXaNEHcF8dPgygnM?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc122c99-e640-47a2-3aec-08deaf0ba8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 03:16:14.7713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUQqK+eiaLjHc0OPsKfXeVvCNDYyVtngSHZq5943sPC5JAkjbNfbZIhlcxecKwh6YZeEFAX/SmH9HbKzNiqJYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8199
X-Rspamd-Queue-Id: A48D35078B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286431-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:dkim,DBBPR04MB7500.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to
> consider:
> - [Medium] The IPV-to-buffer-pool mapping algorithm fails when a port is
> allocated more than 8 buffer pools, silently routing all traffic to a sin=
gle pool.
> --
>=20
> commit 0b5e4aba36a49ce1de9eb84ec706f482331550cf
> Author: Wei Fang <wei.fang@nxp.com>
>=20
> net: dsa: netc: initialize buffer pool table and implement flow-control
>=20
> This commit initializes the buffer pool table and implements flow control
> for the NXP netc DSA driver. It adds logic to dynamically map the 8 inter=
nal
> priority values (IPVs) to the available buffer pools per port based on
> hardware capabilities.
>=20
> > diff --git a/drivers/net/dsa/netc/netc_main.c
> b/drivers/net/dsa/netc/netc_main.c
> > --- a/drivers/net/dsa/netc/netc_main.c
> > +++ b/drivers/net/dsa/netc/netc_main.c
>=20
> [ ... ]
>=20
> > +static void netc_ipv_to_buffer_pool_mapping(struct netc_switch *priv)
> > +{
> > +	int bp_per_port =3D priv->num_bp / priv->info->num_ports;
> > +	int q =3D NETC_IPV_NUM / bp_per_port;
> > +	int r =3D NETC_IPV_NUM % bp_per_port;
> > +	int num =3D q + r;
> > +
> > +	/* IPV-to-buffer-pool mapping per port:
> > +	 * Each port is allocated 'bp_per_port' buffer pools and supports 8
> > +	 * IPVs, where a higher IPV indicates a higher frame priority. Each
> > +	 * IPV can be mapped to only one buffer pool.
> > +	 *
> > +	 * The mapping rule is as follows:
> > +	 * - The first 'num' IPVs share the port's first buffer pool (index
> > +	 * 'base_id').
> > +	 * - After that, every 'q' IPVs share one buffer pool, with pool
> > +	 * indices increasing sequentially.
> > +	 */
> > +	for (int i =3D 0; i < priv->info->num_ports; i++) {
> > +		u32 base_id =3D i * bp_per_port;
> > +		u32 bp_id =3D base_id;
> > +		u64 mapping =3D 0;
> > +
> > +		for (int ipv =3D 0; ipv < NETC_IPV_NUM; ipv++) {
> > +			/* Update the buffer pool index */
> > +			if (ipv >=3D num)
> > +				bp_id =3D base_id + ((ipv - num) / q) + 1;
>=20
> What happens if a future hardware revision allocates more than 8 buffer p=
ools
> per port?
>=20
> If bp_per_port is greater than NETC_IPV_NUM (8), q evaluates to 0 and num
> evaluates to 8.
>=20
> Because ipv loops from 0 to 7, the condition ipv >=3D num will never be t=
rue.
> As a result, all 8 traffic priorities would be mapped to a single buffer =
pool
> (base_id), leaving the remaining pools unused instead of maximizing
> utilization.
>=20
> Should bp_per_port be clamped to NETC_IPV_NUM before calculating q to
> prevent this?

From hardware perspective, each port has 8 IPVs, each IPV can only be
mapped to one buffer pool, it is impossible that the hardware provides
more than 8 buffer pools per port. This is a false positive, please ignore =
it.


