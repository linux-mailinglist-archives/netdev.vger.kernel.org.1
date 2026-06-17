Return-Path: <netdev+bounces-300079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RsxONlpgMmrSzAUAu9opvQ
	(envelope-from <netdev+bounces-300079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:52:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396B697AC2
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:52:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=FLjrTQZf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300079-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300079-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45DBF30849E6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 08:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3B383C80;
	Wed, 17 Jun 2026 08:48:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2673D9DA9;
	Wed, 17 Jun 2026 08:47:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686080; cv=fail; b=g/f3kibe54AlQYwHbF5Ak+wdgfghf8gU2BiBvCibMU6ju1lPu9h76rG2ugvQLHXbe5fGWv2k4P9wOeMdFb3DAWiZXlfdawdBtpFZFVmSDCc+LqINtatsPcIpwPxGPiGa8VDuwfF00KmDbdvBwu/YRP5qy47/ksnLD2wH6SnUWdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686080; c=relaxed/simple;
	bh=fqp/801ETKPvM74UU3UUHglzWSakn07SVwvUnjcdK9Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hTynPQE03GjCTlkTZ8VsXyLzqYrrJbFevRf+JwdlmobFOBvhwcc6HLl07f2yLUOab1zXCrMv32YNjjkxsg5kFCHWf4mKit8vCYOAI6ZtodY4KKi4+RQ4FFp23wQ55MvUtyC8TUdI2AJdv4RVtN0h+7g24QiB7N6SVuLBboL5ncc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=FLjrTQZf; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9jWJsxNBClv2PerPjMIgnZIrP1W+LP2Cpq45npqpzEpLKgf9hNBCyKVA3QQmGdNXdUFqONLJN2u4FuxubOhIWjrzKPrn401A5YUztL2klueGfNyytKEiMnp/mHnk0hiNr1gPmTXGn8eDbtGDSrUcUcOTiCVxUiI0FHgNEZK5mb11+cV6PiDNPwDtxTfln0+N6UMX6Jz0S6szNXs+QOePLRAV/iCKXIoT6C40sBUjUzJouIruFR99zBX+aKshsqKfhh+D8VbEM0xuaijPWCUZapkK0Um5RbHGPkumtG7ibAX9NSR3s4cSM21AD33m16tW9lXNPTiAKBcFE/corQFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCtVnQ4XJbERbjOcq1UZNodgG6m8BZ2gPyqfWzkPXpw=;
 b=OW6FR2t4cokXhVoHs5q7CSLpqjlOQnLmY3pkcPSDLRsHY1iXdhVG0xr5/bZ7kK9JQy1LbwQLiu2k0nwgHklGOhcVPmdpKeAQ3K0hXmEAoBLf1uupw4aWs8aiIF4GfBOYYpXAiVQOj0pd7X+oTE1oE7yH0pUKsA4n70y68nApGdZiMONZe7od6qM2V83e1cb9kcBUtb96ZF7H9E6SFeL4Ety09kejomvOrgKiflzQAIzI83h9Jx3Vv9RjFkqhenJRsqF++URUrZv13hf2wARS1R6vUMxK+LLUftLDMFQcixKFxp/L5nIQ3Q3AhcZPGAc5xTAGbfBCa1PRefPB/08dUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCtVnQ4XJbERbjOcq1UZNodgG6m8BZ2gPyqfWzkPXpw=;
 b=FLjrTQZfKL+jQwxnxVnU8Yn2+q+uHPwgQ4+uG/WcjZADHy1Kbl4xD/WY7vErJYieaGUvSZ/M+AoIK7q++iGSuTTwe+WU/TksYhu3xnbR1hYVOxa0/HJZUGXZbA4cB0mPDhfgALckMdiIA5+b5+EGo6x89oJ1S+PODXKsS1PrXy9q0d2FQcaP55GBeyNGRriSqo4Cawg3j06NZCdzfFYXDhUtSdfYZixsw0lGihDsRdkz2/vr0EZYIC2Jtj58DKQ0esLzsY+FZfgGvDKoNzmB6IGXK5z8Avk/ZMGOrwyXL/8zxcR42/UKDiQoTruIL5DM/3zAJZv9vJ940yqm39AiGw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GVXP189MB2056.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:69::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Wed, 17 Jun 2026 08:47:44 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:47:44 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"xmei5@asu.edu" <xmei5@asu.edu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] tipc: fix use-after-free of the discoverer in
 tipc_disc_rcv()
Thread-Topic: [PATCH net v2] tipc: fix use-after-free of the discoverer in
 tipc_disc_rcv()
Thread-Index: AQHc/Yru+qHFMJgQfESK2HWC2Ieux7ZCbIwQ
Date: Wed, 17 Jun 2026 08:47:44 +0000
Message-ID:
 <GV1P189MB1988614C09148258A9844D0CC6E42@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260616122246.3136462-2-bestswngs@gmail.com>
In-Reply-To: <20260616122246.3136462-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GVXP189MB2056:EE_
x-ms-office365-filtering-correlation-id: dd63c07c-d989-4013-1ce2-08decc4d1954
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|5023799004|11063799006|6133799003|18002099003|22082099003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 eHENrVSTYNRZcb5/AwoDqh2+sLyQMnPq9I0ioKZdOpC+j8NZLIKyJWWSYqIwaUlUXoM+pDaq2ICm3e8IBsYhNQsKZDdvj9kuYfrdeoRDYmyF8P0iaz7hBDb3sKaUZHPSjeE1PScGtTOFW3lfHqJyfaviJvbDTC91QQhRlRkzeWUJRpSlUGraY+uuhwI0UdYH/e3IIY00HTBXZCI254t+heNCMipqhN8kvBU7o164smgjSCltUVnLsTlF31e3pMZ5peozHidmz0DjvVllbXfTeE6uAy8ekTTKvzi+vs0SSaPwLDQrYAv1WXr8W9FMpE6/btSmSKQiICjm3XEkU57ZXdrQqMYM2UAzeqSYnhLw5zJi1Icw+SlNd4khPV80L4m7vN4xdBpe5yPwDsNJqxnxJvuxlLlZt2BCdmHZJ9jC2kq6I2di1MwsmL9ZEXojcH9fBL2LAdMZzwOfley9MojveQLIQb0F+dQyKyagOKjHReXu0q0NA7be8QdjF3JEdoXpQjjr2iYB3HcW7e1wULFWHPufEZzWBsYG08gheMPEHr2uUJdaRJdJ/MmngAwI2drZYaVPTPUQg4Vk/PwxHAW3X2q4631CY9blnFgT6+nxrtJbwTXIWwYdxUfuj7O6AuGop9INL1S2QOUGMKvPFuSJA2Tt8gqGXFZuUmqUQSQfaGBTxetAbA2wg1f7WMDhMgIAtZtGRO+F9xOIO6uCJiYgrnDDnDY4lF+RCfFBAHw/cNURwGSMr+mrBMzJWDmgFyLH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(5023799004)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P1W03wuEJ1IWW8nCPNOtKvgvkX8YmFpsKJWSn+ObDFVDPWDjTVMZCfNqLtmb?=
 =?us-ascii?Q?dxtfq6mEr4JaM+rKfpsSUf+9oswGz6LGaUSAJIZJtp1LWaTDYBlOFnn3uNpn?=
 =?us-ascii?Q?H4wDVMB1PL6sIB/iTeLQeRaMlVezUsoXYnWw1xxZCgMYlksKzjSSBP+9hxwx?=
 =?us-ascii?Q?/RDk2YsqEkZiPa3oL/aVLi39FtrU2ZdFINwDtrl4ApjkkaR6usyTZBrQ3f82?=
 =?us-ascii?Q?Nj7BtEAfBIjebjsp6wpMQ+1Vo/cGN5Ga4fnzYetTszu6lLPZnnFU7qT/vsI+?=
 =?us-ascii?Q?EImSpUPjVBuBSruxqvq4yn64UMf1CndtVzm74S9qOf8ZqBaTs8WdzUwH8TyD?=
 =?us-ascii?Q?X4wBj6qXQnbFZuvcVQYcL7jWb0bh0iDbe5GZP00r8OSAqpRmQvx0IkRrn7CM?=
 =?us-ascii?Q?4YR8Ia42r4/jr9F0GxbHzYhKymnxKEXvuXmxAbxt63HqQY3WKQKbVxOHfR7y?=
 =?us-ascii?Q?5Iv6hH2f9wkhK1qJQaXaQVvWeqDs6OF1rTvVqC4Tp6Bpd8OxeyaN2cZeYSED?=
 =?us-ascii?Q?X04a7ZpIJmLdq7ohcbrruyBGhiltX3h1koXAQQuHZY+wEggIvi1VR0vf7Yo8?=
 =?us-ascii?Q?/bqH0e3yI++EYuPFgzTmBHaMv9A5Se1CbE/TwjJbVkXuCfjTShjJF6ndZyYz?=
 =?us-ascii?Q?m4iriM1OZtv9rd134CZiUr0VnQtFGHNE+8MEKA9p5HRHbxxjR7dnxqLDAaJK?=
 =?us-ascii?Q?59m5KHZq9oEynClzNI+KdHU3dwtVXLub50U8yIIdbuTGyv15ASucHxwZPpOe?=
 =?us-ascii?Q?Aj6G5OJUlGlosB/fd1mEyk1O1wdGMn5Mkmf4Z3NDc6apENdlCAFJRQN1/9Sv?=
 =?us-ascii?Q?TAKMyqSiyd5KV3FKd2ULWGYsTyAdGMGBQDRvZxa2oswc1ZSzeHuq7KguIJ17?=
 =?us-ascii?Q?Z6XI9mMCZrDKlg7lH5mj3Ydb1P8VZyCLevSUG+ri6f2n1jiN4dKH1IcPkW0W?=
 =?us-ascii?Q?wnvYW+8QIm0JwOQ55bZh9w4gp6k81j1xVnykpvxzE9r2EReCwnQhbxpq9Fvo?=
 =?us-ascii?Q?Q1efscG+/amqPnSrg09y86oigQRl0eEvkTwKIjzK7Qo1iizoVuUEvLyPZQlq?=
 =?us-ascii?Q?l7XKh3euKfJwQH/gDmO1mjG0d/qW//XEFN0sNaLXQuZ9ikKPXBtmQlGlXRpY?=
 =?us-ascii?Q?3FHwqgbXYTC1rbGA9vJIvy45Oz/PT8dwOsIBOEGVm2Om+ODmblvcN0Wma7t1?=
 =?us-ascii?Q?slpkFkSRu8ullVkbrD6oAcSIw1BRuK7FOv/+Aoa+X4lYz7g1FolTsNrZNyaT?=
 =?us-ascii?Q?xOoCX1j+n5MK7AsfoXI79BiVpCSaZ/IwhTf7QJMH7DzFLNYKzUYnE0uwTpPg?=
 =?us-ascii?Q?n+0Xd1lMoYKw2UEvsJFU/BFNsQ0eDwY/eK0dWnkazXC/iOVqVuCTYwJx11/n?=
 =?us-ascii?Q?uBX7ofSIPk8Mn1LJlhQr27zByjUqTtklbYz8Ftkqe5YeqfRZc7wvwm9VFqF0?=
 =?us-ascii?Q?dLkSs6ehG+gHMBNn436v+bPJa8G/QZfdzszeCJeZpdJQ2XAh9hwfm8HNKQbK?=
 =?us-ascii?Q?6PUpPq/YMJ46eL5FgRhku+Pk19+eapN6O9UlElHOJ0FrcNJyRGGSNRGYu+8u?=
 =?us-ascii?Q?CsY9SiwFKStt0zwOSkHqq3PlsqoypyyWSzbzq3wsT2eR61+N76VsSyfWenWV?=
 =?us-ascii?Q?9xQZskV3+L3qnZfeoyZfcqrOcq2YhzxI33p67KxIrlTxxZLnz/1LqQuu1I7U?=
 =?us-ascii?Q?/JlVFyqoo4/VTmNZGfYWusLVw80k3fxmS8ro1uUIedPr3O0gyzaTemVFf0/M?=
 =?us-ascii?Q?idWqmNHLsA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dd63c07c-d989-4013-1ce2-08decc4d1954
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 08:47:44.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ho2+h8A/cuRg1wNrL6XwAGEmdIw6G8ZdkSplsnbXx/2hfGHDSvat3JnBwcr2s+g4D46WULJnJ40GyCADJDXFklZP3ht5pk+VxGsgb+pCOg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:davem@davemloft.net,m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300079-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,est.tech:dkim,est.tech:from_mime,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7396B697AC2

>Subject: [PATCH net v2] tipc: fix use-after-free of the discoverer in
>tipc_disc_rcv()
>
>bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(), bu=
t
>tipc_disc_rcv() still dereferences b->disc in RX softirq under
>rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).
>
>L2 bearers are safe thanks to the synchronize_net() in tipc_disable_l2_med=
ia(),
>but the UDP bearer defers that call to the
>cleanup_bearer() workqueue, so the discoverer is freed with no grace
>period:
>
> BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:149=
)
>Read of size 8 at addr ffff88802348b728 by task poc_tipc/184  <IRQ>
>  tipc_disc_rcv (net/tipc/discover.c:149)
>  tipc_rcv (net/tipc/node.c:2126)
>  tipc_udp_recv (net/tipc/udp_media.c:391)
>  udp_rcv (net/ipv4/udp.c:2643)
>  ip_local_deliver_finish (net/ipv4/ip_input.c:241)  </IRQ>  Freed by task=
 181:
>  kfree (mm/slub.c:6565)
>  bearer_disable (net/tipc/bearer.c:418)
>  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)
>
>The bearer is freed with kfree_rcu(); free the discoverer the same way.
>Add an rcu_head to struct tipc_discoverer and free it and its skb from an =
RCU
>callback.
>
>Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
>call_rcu() that is still pending when the tipc module is unloaded would in=
voke a
>freed function. Add an rcu_barrier() to tipc_exit() after the bearer subsy=
stem
>has been torn down, so all pending discoverer callbacks have run before th=
e
>module text goes away.
>
>Reachable from an unprivileged user namespace: the TIPCv2 genl family is
>netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs
>CONFIG_TIPC and CONFIG_TIPC_MEDIA_UDP.
>
>Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash
>values")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: Claude:claude-opus-4-8
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
>v2:
> - split the over-80-column container_of() line (Tung Quang Nguyen)
> - add rcu_barrier() to tipc_exit() so a pending call_rcu() cannot fire
>   into freed module text after rmmod (Eric Dumazet)
>
> net/tipc/core.c     |  3 +++
> net/tipc/discover.c | 14 ++++++++++++--
> 2 files changed, 15 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/core.c b/net/tipc/core.c index
>434e70eabe08..747328e58d30 100644
>--- a/net/tipc/core.c
>+++ b/net/tipc/core.c
>@@ -218,6 +218,9 @@ static void __exit tipc_exit(void)
> 	unregister_pernet_device(&tipc_net_ops);
> 	tipc_unregister_sysctl();
>
>+	/* Wait for tipc_disc_free_rcu() callbacks queued from module text. */

Please change above comment to: /* TODO: Wait for all timers that  called c=
all_rcu() to finish before calling rcu_barrier() */

Note that call_rcu() are used in discover.c and node.c. So, the TODO commen=
t helps we add more checking code later in another patch.

>+	rcu_barrier();
>+
> 	pr_info("Deactivated\n");
> }
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>3e54d2df5683..696b7a8ed54d 100644
>--- a/net/tipc/discover.c
>+++ b/net/tipc/discover.c
>@@ -58,6 +58,7 @@
>  * @skb: request message to be (repeatedly) sent
>  * @timer: timer governing period between requests
>  * @timer_intv: current interval between requests (in ms)
>+ * @rcu: RCU head for deferred freeing
>  */
> struct tipc_discoverer {
> 	u32 bearer_id;
>@@ -69,6 +70,7 @@ struct tipc_discoverer {
> 	struct sk_buff *skb;
> 	struct timer_list timer;
> 	unsigned long timer_intv;
>+	struct rcu_head rcu;
> };
>
> /**
>@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer
>*b,
> 	return 0;
> }
>
>+static void tipc_disc_free_rcu(struct rcu_head *rp) {
>+	struct tipc_discoverer *d =3D
>+		container_of(rp, struct tipc_discoverer, rcu);
>+
>+	kfree_skb(d->skb);
>+	kfree(d);
>+}
>+
> /**
>  * tipc_disc_delete - destroy object sending periodic link setup requests
>  * @d: ptr to link dest structure
>@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_bear=
er
>*b,  void tipc_disc_delete(struct tipc_discoverer *d)  {
> 	timer_shutdown_sync(&d->timer);
>-	kfree_skb(d->skb);
>-	kfree(d);
>+	call_rcu(&d->rcu, tipc_disc_free_rcu);
> }
>
> /**
>--
>2.43.0


