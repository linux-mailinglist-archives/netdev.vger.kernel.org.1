Return-Path: <netdev+bounces-298528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G25hMgPJK2ruEwQAu9opvQ
	(envelope-from <netdev+bounces-298528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4C677F8D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:53:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=est.tech header.s=selector1 header.b=WHfNLs9K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298528-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-298528-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCEC2301D5B4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F8364EAB;
	Fri, 12 Jun 2026 08:53:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2234252C;
	Fri, 12 Jun 2026 08:53:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781254401; cv=fail; b=pKhx6LNeFnDQeRJi9I1xGoMFSlZXsYvfpZwJ3khxwnFtlF96TZSYK1g44WYM7inTfrZ+gZoo8/PhvSqMDMS/SMxDj2dzEKTiLrgYmrqYT7DPBNFtVOg/3SvxHRwB+w8NESPwQ3U6jSeI+w+MLI0kZ6tDDLdDPV7BXOb35c0sKzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781254401; c=relaxed/simple;
	bh=p9+o9ywDDqiQg3uqsm/2BVWt44K3l5EjD4Lco8ctBAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwRnnvQuUjfdny+Uw3SJVg5I9Xlu+JlGHlj83ynuG7K/gE0citWkPCR1hxPa+qQiK71kI5QPo4s1+s7+InnvLJeU7gNojWqeDxgbvQp6EjGXiuzpaBplixuqxk5JSHaX3iLe9kIbhOWlBa50F8bhX080pcdtYl2cHJZOISUr5Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=WHfNLs9K; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPe1BWkeOs66mdjdmL8GvEcc8gkTP//27iu99+josBZTh11YH8gnv1n1loNp1R3XCfu3m3WRUX9TPEfneXoN4/8nNVSC8sbmh/Uhc4rVUWuGAozN6s1d4FlPv4sxQhde26ga0uSXhdgEtpF/xGHS5sqNX76Mj0fiXoyhWSV7LH/NXf1hDDJoz54Dfy+kekkecOtTUzxipHEWHrV69t1PzwF9NGtY9LM7IU0PZ3cyuRtwyFNF9/kVghDXZ1wlb0wuJsrL6HcbJYhysVo7RMxW/j7SPIa1I9IfY1UQQPzqX+PS85NrYTvD8cfi4oah/+Sqad3nuszqSek7mUSAkROqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWzjSy4eCvKAQU4TBcNx20ywVaJ9/JWFiiOoKyIaGd4=;
 b=TGELTyW2hjKUQ/t5iBSldA+FN8yxgDLsJOrEpEZqno6R2PMsXBxe5Fwh86aFyq8dGpWUZcqFTw32FYhntMc7m7LBnOhBMdymvl75c4KccWiEo0vndT02ShxihhfHGjw44zYuTGoHA7NhZPT69x8ZECBifjeZ+3uK3AC6mV/FYC/SEcvLRbK7p8dWK7kPtVzW80DbktmGXwAede2VrsRxp+IqmPIKM2WGKg7s2U2mDDab4VIzynl91JmRKSMd2ySyJ+CWQyVBoSDoW1yTz1if4tzZmYoWR4RL9HthKUrDj1g7L1HuEj+v9Sv71Xgf7BtLqYVbji0Mh1ZPPgHyJJfnqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWzjSy4eCvKAQU4TBcNx20ywVaJ9/JWFiiOoKyIaGd4=;
 b=WHfNLs9KRgSyLVZjg7mTkIWo2TRbKBLX8TYyUa+YmVW42sOsOj3CFVeYLnbXzzZS2+KWl7Ct/k9cOhdNP81MXfXm6thsP50xNbgH6E2EDt3jVF/5hQfqufJ9h9TV9SB5zzdcXatXJB0fSr3SKK8v/01pEL3LoX7p65WVeh7lTCJygUQHpxa8i4bAjADkgHFMDN8QLy71bANjWJADZIyJ762D1ZleJSMrrCYZmqkqFEG6hj9VBA/1/Mygpa4CCO2TqodeIYCi7sGUaGXnDoMb1L+yFYYygmPpFzEdL0WCdluFP+nh5FUe+3b8I+3XVOht9x0unicqhiw8OrU0IXoXiA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 DU2P189MB2522.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:498::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Fri, 12 Jun 2026 08:53:16 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:53:15 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Weiming Shi <bestswngs@gmail.com>
CC: Simon Horman <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Xiang Mei <xmei5@asu.edu>, Jon Maloy
	<jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net] tipc: fix use-after-free of discoverer in
 tipc_disc_rcv()
Thread-Topic: [PATCH net] tipc: fix use-after-free of discoverer in
 tipc_disc_rcv()
Thread-Index: AQHc+PYeJoL4lpxwtE+uQV5Hoo332bY6nryw
Date: Fri, 12 Jun 2026 08:53:15 +0000
Message-ID:
 <GV1P189MB1988A1CFCAA9214B6F009315C6182@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260610153349.2546041-2-bestswngs@gmail.com>
In-Reply-To: <20260610153349.2546041-2-bestswngs@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|DU2P189MB2522:EE_
x-ms-office365-filtering-correlation-id: a758f9ff-c3de-489f-a123-08dec8600ac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006|3023799007;
x-microsoft-antispam-message-info:
 6jK4Mo9kCFkTdEdVVONd6mPkgRpJKTu1B7geDwtGYSrjdVqb8K851RNY4wm4QxXGuhfigjuTA9g8Fx9UYZGfVCX0JRGcWqEu5AOhc8ORacWyvlpiV9bVFfo8JP8XKRxlFSQFMLag7jQIljMlwCZOps9IbVNC8vDu+mQ4MoGIqIXA+hz5RlTSVYagw9At9SzZ5WdulpsWO/RJXEP6A/Uz8CX1dmsNDAaFvOO1iEKtzM5tG+SPOOV/YSnOEjferm6oF6uKZkAtw2+q9YiGLxsfHljsyD2WcBXD2yQ/oc/+7oTERUIRpuria/n7PdALm6EUiw7hhhDwkx4dSkPs73aAZ/NHr2PhUvaqO6WT1o4KjsPvd0XFsqVt2qHmXWnLRur+oJ+3V/hDss+9kREBj5eVoLTOlEFF4AkesqaO2/H10mCdRGw3b1aWvjPyq1ThG4PFxzc2LwClCbSpCbewyQCrWu0sfkQPH5CQswyXTdrQru0x1k2gDbLWsLHBS8NJvH3wi0KPLrYpyrArHTCPqrPXw4E7AT4povVBGAUc7KWMt46O6X6JPd+vh01h71JGl2qmdIL3/Mr0uoU9TNK3FsNTilr7YKe7KPrG+SaBsCnp3sYh7CRK6em69DJjnJY3KMCmT1pkyCXEHHc5u0giOCdLicPqlU4V+wo3gqvc1CZ8IqAJiAxcLvVZYlax95nPnro8PSIKBX4pNcNDIf/rbaqECGCc2CDf+nqyqFFzUiK1q7qEQm9Tn8XwYgHxhSSX/gNT
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?73fh6QKVJlGvylmHPNKOaIsCwXsXio8ToeQcuLkFOl492C79Hae4zqhMeYn2?=
 =?us-ascii?Q?P3DEqz/LeUwqsPcLra2a/824qmVP6oejUXqeZ4IxFqWRlKW/M0qkdTsRktua?=
 =?us-ascii?Q?IFFO7CiOr9aetPYIM8wqff1b5H0xJGILHmP8DehVUpiavtjtRy0nJqpf4r20?=
 =?us-ascii?Q?+eyO9I3FeWSFNTBqvwOuFsy1y0lj5OVo0ml2zjF46Q+iJoSAs/yTBaYxRrJo?=
 =?us-ascii?Q?+xcvxROZ+1n2h7YKNuu6VW3AU9VTVF83wP/GfqtVAsJ3dN8l+hfvEhpUaUId?=
 =?us-ascii?Q?SuPZGl9Btp3I0Q2KIA6Un5jm3/X/UiDtiU2xkyGWkZ7g1n/vme97fM0UK1kq?=
 =?us-ascii?Q?R+gy7JP2KneRMCxlbOPwnUHBVzdAqU7eVkKZVFp3kNpeTHJVz1euHOH6SAuX?=
 =?us-ascii?Q?vNhyZrx7acir7vNP9LNgAStCNrgaWshzSdT7Gb/n4RYzae7wqgEjJkA/wdAA?=
 =?us-ascii?Q?j8iXhiFZSV/XLVRWBfEc9lNw8K9vlBbcd3dwriXBTMAohPbCDS1wLoAYm0Gl?=
 =?us-ascii?Q?cBU1miIkyf0wZ1lUVV4VDX1sKs5LDPPrp0wU5430WvLzCqC3t5cLynrjNSHU?=
 =?us-ascii?Q?y4fo6JxN2dh8lHBuGh0XrPnszux7n0btEODafr3mQWWFuxXq0yJotlm1sUnp?=
 =?us-ascii?Q?Kj7i7gyPddw30lLRENodWxlMisf0Rj9lQTkMz1KopLyQ0vnVno8o7MTvP6W6?=
 =?us-ascii?Q?bjwfLIMK/bq9woNqKbL/udts9AXxy/kOoOKGESkpALknxHDK3qDJE8AhXzrD?=
 =?us-ascii?Q?Yz7bbOZiXqRQw3W/TwaKQZU9amUhHKFHnZ/cg32CzSlrqQ+5zBHsxGqcxBqT?=
 =?us-ascii?Q?tX+2nncuzrYGOShCfPLgIan3t13EwScZrojXF+CiGxEiN58g4dMfyxUQVGAB?=
 =?us-ascii?Q?/JDbyj4xnGvTKVrOeX+SleXM/rnJ3jYLp7pEa/wlUKpjf0uOQJ/3EVxHVk1j?=
 =?us-ascii?Q?x2xKohownYVSGQB3+u2gVIbQ4yUkzkua6LHZG8D8x7fTPTsK8fhkiN8hpZv8?=
 =?us-ascii?Q?Xv8KT7nupsDdsz3NmMvFqskCb1bakhcTyEDOFVTUcMw/G/TeG/I5VPVXrP5y?=
 =?us-ascii?Q?YMLN6I8hqRzbduQTo9hP2IeAOsdZyF/QWitTZorkqujz2fbhyrFyScHjyrrR?=
 =?us-ascii?Q?txnqMaCwHZXZz4RzqLIHqavOMYxVdwgdtqYZ++fGOAkiOVOOeVh/Qr59s33T?=
 =?us-ascii?Q?3cEQ73tApqDjvaTUb8nLu8V1VRIQa8NcaG5DvirTiPnc7rOjcZe/3MpfCz3K?=
 =?us-ascii?Q?5FSjZULnxsvdwW7T0HM5SophAH0LKQOPYsbNTGypZqrpUtU00y3eF1xF9r8J?=
 =?us-ascii?Q?02V81xWuny2VhlRNjZ3FW3qQJvVi4yqIcSejr+ET+LAHoiE1Jhf1CGZ5ks4f?=
 =?us-ascii?Q?0g8eqwrJ9+q8Pxt+axZJQw8/CFK3nDwnwgcMzCWI0VYnHRBCspF7ZO+EC6/j?=
 =?us-ascii?Q?XjhCJ5nwnNZSb2YayOGcUsj78V4NngCaeSI/zaWoneh445NU7oc7sK/L7aAV?=
 =?us-ascii?Q?zy6h8ud1ncBQtR/aLgV+eGAdSJMtsM48cNAbxa1eoIO2mwX16omUyd9PxYsR?=
 =?us-ascii?Q?3hq2dOJNWQBL+KC/hPeC+AcJFptMHzV+hSK73zYlt2OE2fQ6rXiqbOIFlPou?=
 =?us-ascii?Q?A6xlBw2g5oSbVeHWAvDi8umaSxOhKfpbSVYWXlRSzMZtnKzjgz67y+AM84gD?=
 =?us-ascii?Q?w+zN3MSmJAiJIN4qbnuNHRNf4HmtT7ZmmLVn2yQMWvoDTXm9NStAMpln3Pb6?=
 =?us-ascii?Q?gTNH7P8LZA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a758f9ff-c3de-489f-a123-08dec8600ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 08:53:15.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 310FHdMrOldh1qJo/yTNSXhSEKXmh8HDAXSbGiFGTTyBVcJK2qWv58xiRmAWmlZ9s39H9dmZ1DK7H2ks50bPv7J/l0m0Iv7EyGZ6feDPNoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P189MB2522
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
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298528-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,est.tech:dkim,est.tech:from_mime,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69C4C677F8D

>Subject: [PATCH net] tipc: fix use-after-free of discoverer in tipc_disc_r=
cv()
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
> net/tipc/discover.c | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
>diff --git a/net/tipc/discover.c b/net/tipc/discover.c index
>3e54d2df5683a..34dbe5ad10e09 100644
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
>@@ -382,6 +384,14 @@ int tipc_disc_create(struct net *net, struct tipc_bea=
rer
>*b,
> 	return 0;
> }
>
>+static void tipc_disc_free_rcu(struct rcu_head *rp) {
>+	struct tipc_discoverer *d =3D container_of(rp, struct tipc_discoverer,
>+rcu);

This line is long (over 80 columns). Please break it into 2 lines (refer to=
 linux/Documentation/process/coding-style.rst).

>+
>+	kfree_skb(d->skb);
>+	kfree(d);
>+}
>+
> /**
>  * tipc_disc_delete - destroy object sending periodic link setup requests
>  * @d: ptr to link dest structure
>@@ -389,8 +399,7 @@ int tipc_disc_create(struct net *net, struct tipc_bear=
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
>


