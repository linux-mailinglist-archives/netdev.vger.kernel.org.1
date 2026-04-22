Return-Path: <netdev+bounces-280354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKjEKWuL6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:48:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6F443A36
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 616D53009B1E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198726E71F;
	Wed, 22 Apr 2026 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="gJzTHJhi"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BD370D4D;
	Wed, 22 Apr 2026 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847648; cv=fail; b=s6LsRmBMpZmMGTQwUerMjB5t73EkJF685oOPd6JkKQTkxgpCRLAzDYBk3LDoAvcrb7TCPBfQaJUEGV3OZN2qVsw8BZyhkSkJlYi8vV2HXoZmFpH9V967omx7oIeJCC4Z2M8wgv9HJUXc5T/0wPsbTTu3711CYNMvDHb1RFWb8Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847648; c=relaxed/simple;
	bh=kDt8gL+ICeaR+rycOboH8/3bEVWfSxlDGos7VESD+ks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NfKiLeSDKX9JZPrmdNqCasnxvEsYZiZokdJyS8MrtcY2iqBK3xfse0kCvY/p/aBM2cuYXXviKQdta9SgMcHpWT0XB1DKRqwaBkZm5a5w8EgGgiwMsiH0X1VIZ1BYMzZFIp7dMqNhVyvukffkkwmOe9bBQ1hkwaju5jXtq7xFudM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=gJzTHJhi; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UK8V4S9J6vKJlsxzr6fJdBLLTptGEmuaZJ58m55Xf0J8H8ZKLuezZ5Wr2GcJZ3Qsah9kMUbnufxLUqn/z1it1z8kVgQq3eDNEEOOnBqboOMCgwrcj6aQQMFP/jMh9jMdoWbtRhH7HyYY8wcAUUPHUQI9XkZl3/3RX3tFxZTSwhchlHH/UCUeHTW1HpRmC+EDjlcP4yGpw3VgI2v/+4XGUSXPMePYfWkC6gAvk3tNyTn/+a9OGyG6/736fRIe3sEN857IJQHDavz+9UnDkvDtaOoWejpscxxHZRzrU2DHXqSC7ybrF50J1ZdLv0BQBNGhcfZ+taAD9uN2YjRMjiKoXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VrH6LHFLNvgLNf8o0i3oFzRh/hnivNyU584PI3c4xQ=;
 b=xutBmsGyyrA4yuWmtJESF7GByf+WhVulZThiPk2C/U7TFPljGs25vDUbNIx3dKmHpwaQ5sBjRhw6OMBf4K/vTw0kc/Q+pUbOUOKyat0IAMLfQL0hchbg5G6uQt7uS0DMmTKqs8wZ5Nl0kgsuEu0QUzjL5bLphgyLbejk1N0gKvMFoW7pQRs8R2kXA3mjbOEg1qI3L0E01pf4O8gAQfD/2JU7EnwK1pXyNaP/+/bxdOVFhluGcusnt4TIbN0UCieAnvErh62N3UHCAknOv/U2OlvGt+5cLIzUWZqjYL0fYQ3mqDtTBCSKfS6Obp5F6JZpbR4cYdHvslSkSCmnOiJb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VrH6LHFLNvgLNf8o0i3oFzRh/hnivNyU584PI3c4xQ=;
 b=gJzTHJhir1X120ZewqYMrYH1+oB3Fhlyc7rMZy7qZPNeyaEGDAg6/RTN3v2mlaTR511/3HwTxXBtkEjLxQuqz6D6fhaWWntKiOlqd7V9mKlH1iW2w1jzodEXELoQzLBPdjAGk9j/HJfEmsn8fYB3szAx9De/pq0USRzxUO9BKR/a+g0lyXwMVsiAgbAu50o/p/z/ZUu0/srXw77yyEZmtcLlptne/VqfNrkejMt5xCpz9fZsek3d5oSI85TvS6wDTAciMORgCKLl0mIw1P8F4NrvuxTh28aAZIXjslwLt43j6dbTZ1rDoktPinS7Cp5HCM8RM/jKDXG6s8sFjXozvA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GV1P189MB2217.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18; Wed, 22 Apr 2026 08:47:20 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 08:47:20 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Lee Jones <lee@kernel.org>
CC: "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Ying Xue <ying.xue@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Topic: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Index: AQHc0YzJfBmNLCbjYkaB6vq8Wbu3ArXqxYqA
Date: Wed, 22 Apr 2026 08:47:19 +0000
Message-ID:
 <GV1P189MB19888E6F921AEDEAB420A34CC62D2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260421124528.162996-1-lee@kernel.org>
In-Reply-To: <20260421124528.162996-1-lee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GV1P189MB2217:EE_
x-ms-office365-filtering-correlation-id: fec8ae9f-f46f-47a3-aa78-08dea04bc3a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 sjUPNpOESS7E3Adj1W9/6/W7taEMOzTe5aa9yk3wGzlS+5ymjFGyaVeoPHOz2q3gdnGUe+BRFA2dpU+H7z3Dlop3LHwzS8P8Vo9MeawRaRcM6dUk8QoathUlONoyvO1ktwBwMx1LYtcGaGc/CzU88kqM1gEekqxN9V9GM8L02D8sET9xMqrAQg0dCEYAfi9pbHFAGLPN10wjkaW1XdYH/VAGEqkINQlAzPGpWMXWZFsuhy8LSsTd7voBX8fflK8b/I4LuxMcqS2fuh2eoiV/CtWOtzn1xmY+pN5J6kraomKsrTmXLiQ9pXX+fNAmyUbWPaqSTlOLdzrWKAgsasUV2w0QYGt3G2MnG4K+YSkZNWJiGXOETZr0xWeLqqNgPNNCIx1j7P9jdj7tDH22Uv8hS5nG52Yb7GsFn5dcJOJOdyW3Qug29QTmv/RKCJoTM4xnojJ7hCb8+pCDkzqZq95ckVUq7u5KpdvFmPF1+qzXJfnRWXxiJeo2XACyrQbANtB/uoyLRWdTRCJMiph+aeco53vBUfpB632WYxvnWYxGA3UaG9Nj0m4qMFGo/cVEoc3oiSo60AT2d2OGHWrGESkuquufN/Z1X/0HKEimA9zw9qz8r3OTJSXepITPyFzaBkyX/W6sYnmyYhPaH1dTP3phkzDvnYs9p4aNK4vYD6MeYeHQJe4Fod0O3Wl7f3b3viVqEkg1W+JsK3VszleDoVVFCkilrvwtTc3bW6K2QL1OuJ2nbT0+6Gxxzwhzd+qhcMqWrPC/EebVk0ktDmkqm8o9MXFxc7pInoFyBtC29oxbSQ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LbcusRiou9X27FED0Ed9RPYfRNx7hZ22l/rT1Uh5rLhmrP9cHM1G2IHswFU0?=
 =?us-ascii?Q?7OLMo41TS1NwmQS7UVxg3lVwf0ipXZ6V6k7h3uQQsSwYExKHwhbTSu0kbyyN?=
 =?us-ascii?Q?Q0mkeZEBdEk2pPe0592EPyGHu0OEhWFtxZLehECZgxXVek3UA1hqOXrRvcgm?=
 =?us-ascii?Q?/qRKgXRmsYqOOcqDtm3nihrrQ0Xq2cgzSgsBwt8mdjfJ8D8NkJxy7VVHixQo?=
 =?us-ascii?Q?BpSedcxJqbIqatmwm9duG1KZdk1jYbqafjAXNGqamiwotdRNqz3Epj9xgwK8?=
 =?us-ascii?Q?k4jC1AcIELxg3nPX0Kh7mRzjpuNx3LDu3hga8Wz50rhW698MaBP5TLTRw0XT?=
 =?us-ascii?Q?LXvscYPkA5pW0d28U0QQcD3M3g8CPL91r3wgLVf63EuNnw2UHG8eH7TSNCSY?=
 =?us-ascii?Q?wA1cgR+BCBiAl2HxfFLWgQql6yt5SCvz8Rb9y6ZYQIGo15uq8nri3+es2D6o?=
 =?us-ascii?Q?IqGU3ZrwNtvQhxTvtD4PUFXdB0H/r+kx0rfO/irm1cQttPLccjSxhDQvHlFc?=
 =?us-ascii?Q?FyYf7v8LpGkh29vi+Sgstk4MLA1uTjIU/3UBEn1+Xij10HIoZya+gb/1OKbK?=
 =?us-ascii?Q?Qjx4j3NbKXzU10vQIN225Goda8TZUwdp7Cp5KYZ3PoxNnL52IUUpFgMuRY9g?=
 =?us-ascii?Q?k8jg/386PUTNZJOYg2pPsWM40JXpJFEujv+bfgBycXmLUXZVgp7Sf0iwHDWv?=
 =?us-ascii?Q?YcpWgsf8euCb+0RU6SeemJZolowqyMK5XxNUCdPvcfknWadj+m5iutaSKZKB?=
 =?us-ascii?Q?86bRcvI5R3WajBzmt3J4hc7yNF5FL8wsbbi9NMYu5VTOiHMLdNtlMGeGSp6o?=
 =?us-ascii?Q?87qJSj3gv8EERk9PLnIXU/mlOZh74UDIXgNV8/01iVP78zXDxAhKryNjD0NB?=
 =?us-ascii?Q?LrbHDGbsv3aYPXM/Eym/UvlSUJDr3mI1pN/+uB/krbWs+uWeb8p+wSvfLyVx?=
 =?us-ascii?Q?LmKIrBVCowXEUZ7Pcv4FODFAnf2nQZv12HEt25NuDHii5uxWebyw/fBwpLtm?=
 =?us-ascii?Q?7YK73K7Raz2mVXOKncEB2MmCd76UyGO5BJStSmwhCDNAsH0xk3S+BqvOyc0E?=
 =?us-ascii?Q?rgoa1eNdQJasWmG6mu5K0dnCZtn8LlZh7sumw2lPbkpTNYl98QaHl4wBR4jS?=
 =?us-ascii?Q?Ug6NwRGxszbHdOiLQEiZUnpAHBct480KadVhL0eR2Jgjhui1HaBuTdB/yTdM?=
 =?us-ascii?Q?E35NllsFKZY946nnsumQDSert+sSHNsAOYqdvurm0SDe+TY4tfHBfRJDYfo6?=
 =?us-ascii?Q?YDR/T3V36LJmcLNFEqBekp5TVFxhXYTaz2zq2JsGpq1fm5/SWKxMvpXJ9TRk?=
 =?us-ascii?Q?6zvkW1c7GsL7N8FPO5c0YerpD6nXtFNdfLpA3UMy84rywDofsIoCwPmIC90s?=
 =?us-ascii?Q?ZixbftrIGcPfBPj+KC0lMU9KeyiKj/XhmYZ7eTX4NfApuHsfeALqBgm5dV7w?=
 =?us-ascii?Q?IddMaSnMAG+4zJOVFkqPYdt0u4la1Q4S0ljmNlkTS3crviV9QF5DmdFmiGpA?=
 =?us-ascii?Q?LGjUS8b1o/8jJHnr2SNydSZwYtfTyho7uMNBK6gjoCLRX4n99OOwy3CUcS5X?=
 =?us-ascii?Q?gij7sAZ/y5LohXlDyuA+ys8R3WMov4ebeqAoo+V4/xn5cA/5vJ+im++GM5RA?=
 =?us-ascii?Q?XMAaGep0+g89Ma+OrzKwfIccEBLq+qEvIqhmo2p//IQ7gsF4atuE58WYuKjt?=
 =?us-ascii?Q?3DRu9Y3CbIJkQo7tq9LAf20OEUd9TU8qes8uF3nlK5w4I3xNENp00mgCUb1F?=
 =?us-ascii?Q?HgvTdKmTKQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fec8ae9f-f46f-47a3-aa78-08dea04bc3a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 08:47:19.7111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y+7RTcJ/nQfQf6Xl6cUDAk5Btu9fNpnzY9dx9isLwFa5t3mk2fcRaTvcCl2wKdNSkSA55F9tBZdJAbTZWJivQcxlPeAjLt00l7T+yYFDCY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2217
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim,est.tech:email,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 07A6F443A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH v2 1/1] tipc: fix double-free in tipc_buf_append()
>
>tipc_msg_validate() can potentially reallocate the skb it is validating, f=
reeing
>the old one.  In tipc_buf_append(), it was being called with a pointer to =
a local
>variable which was a copy of the caller's skb pointer.
>
>If the skb was reallocated and validation subsequently failed, the error
>handling path would free the original skb pointer, which had already been
>freed, leading to double-free.
>
>Fix this by checking if head now points to a newly allocated reassembled s=
kb.
>If it does, reassign *headbuf for later freeing operations.
>
>Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and
>contents")
>Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>Signed-off-by: Lee Jones <lee@kernel.org>
>---
>1v =3D> v2: Keep the passed pointer type the same, but reassign on-change
>
> net/tipc/msg.c | 14 +++++++++++++-
> 1 file changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/msg.c b/net/tipc/msg.c index 76284fc538eb..b0bba0fee=
f56
>100644
>--- a/net/tipc/msg.c
>+++ b/net/tipc/msg.c
>@@ -177,8 +177,20 @@ int tipc_buf_append(struct sk_buff **headbuf, struct
>sk_buff **buf)
>
> 	if (fragid =3D=3D LAST_FRAGMENT) {
> 		TIPC_SKB_CB(head)->validated =3D 0;
>-		if (unlikely(!tipc_msg_validate(&head)))
>+
>+		/* If the reassembled skb has been freed in
>+		 * tipc_msg_validate() because of an invalid truesize,
>+		 * then head will point to a newly allocated reassembled
>+		 * skb, while *headbuf points to freed reassembled skb.
>+		 * In such cases, correct *headbuf for freeing the newly
>+		 * allocated reassembled skb later.
>+		 */
>+		if (unlikely(!tipc_msg_validate(&head))) {
>+			if (head !=3D *headbuf)
>+				*headbuf =3D head;
> 			goto err;
>+		}
>+
> 		*buf =3D head;
> 		TIPC_SKB_CB(head)->tail =3D NULL;
> 		*headbuf =3D NULL;
>--
>2.54.0.rc1.555.g9c883467ad-goog
Reviewed-by: Tung Nguyen <tung.quang.nguyen@est.tech>

