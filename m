Return-Path: <netdev+bounces-279833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG2cNf5S5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ADC42F665
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5072336CB0F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFD2868AB;
	Mon, 20 Apr 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="OMnkAqJd"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0799286891;
	Mon, 20 Apr 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692826; cv=fail; b=Pj9N8ZLCYhZz1jzqF5MxvtcQBdKIEVSiclpHfOxOPBquxvqveRTNu31DtKM5OoMeALL4KpnYU7hwtUiz2/JevPl80+jrtMdFHbU6/wyGvlGqCUga5LMdax8UscOirgfg1eEQMm+IlRD5cSNc14JfH31RFIzqv+lIJyLoOsOw97E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692826; c=relaxed/simple;
	bh=bBFINNsNT9AwpFghgdayOw60VnChBfs921xOwTt2xIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kccs4RzDj/Q6klT/ILJMdnbpOMZDVAkFpV7D/lFedBAEaaeyjnL+7DYl9wOzIjg9ZLVUw4d1FDzWR+cDQsAJegH9tT3A3+uLtanEbypwMTNEDZRZ2l1mltiLKarQAkrf8xA1sAjVW9upL4NVqDTLeX15Ndfg5AuW/a8DXbrKb2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=OMnkAqJd; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2grgMfs9eJjv+kF63B6m3kMjgPlgkPDxfwoLGP1Osej73p6XjvapwFWQuqciSe5EtCffTvIjuMVOPcT4+p0Oxj3/5NGlmgiYePaRUEJlbi9AyR6pr18mg9VaE9zMyUuoF+aYbb/v4kkpYgdEY3axtW/8uMaSa+xuuH3aQMjUW0TAQqvzOGIsz+9AIal2xm65XNVeEqBbAIttuusdjtr3a5TW7yEOutfcqHGb+FMj4dAxiDcHiHLUhbCfY7Dx/6AhUKdrQbo4dOen1VMCQfKW4rBKdVv/2oe7Gl6GQAdPI0u5/urk/kGtqw9gvsmUWdTE1wsQAxWJvbyju30UF0e9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lY6o4u7l9+rHhNca5NpleHS6eaRF9OhzMkS9hkANx4=;
 b=V/4a7wimyVUwWAbiI8tWBDd4unILY8GIeo0po8bW20f/MDJLaP/tWuj0lmehKvGqeF+qM7jvCRziYRY56wYd9YWvr5gZZQqikAxAk8Bvku2M/gu61XEvZG36qrX85XcVp1m0S5SDwm6DgPvnX6OwnINLVvNDnPNrxPdD9J/mStG0rTMvN2arivKpV3INDWazk68YevmSvuyn5yqmgPbsDrCIGYC48Or6ZqKXeLR/ZF4YR4rCuuKGU9hTymjD2E3Ra4w/iip9DHJBmo/gfWeJ2mSEODTT1pNvHy143pF4sa9N1WYpKzgAaICYEN6q9Kf5+j8QDyJQ9MvYq1eVo1iLxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lY6o4u7l9+rHhNca5NpleHS6eaRF9OhzMkS9hkANx4=;
 b=OMnkAqJdaKzK1QrTuLzPD1tuIF3kJ8gga/Fno4n4iVD/nM7avw0XlixorzEawYJEvrF5GldjamFT2i8CPvAW0JIrJqZ0AaEzA2VnUvMJkkehAfwHNyrkYIESj79tRj5POQuSC2ssLKZB0DrA85fv+cpPmGpsX4R6oKSb/GgVQ9mizSAyKwigTh+dJn6orGd03V8AZmqRRQ1GoLWXPPvfYXXLy8bOCn3w/7PCeA4u/ZpmVCGe2G5B7lJV69uNcnFhK+9Gr7L1BHyof0OdvBsn4ISN6TtbCxAUlBs0ohajD5aYASsNlTNy+8+lrP4eFBbODw2iOQ7rlmNlt4INPy7lDA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 GVXP189MB2678.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1e4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.32; Mon, 20 Apr 2026 13:46:58 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 13:46:57 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Lee Jones <lee@kernel.org>
CC: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Topic: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Thread-Index: AQHc0MdsOiuDtYmLQEW/2MapjzEborXn80hg
Date: Mon, 20 Apr 2026 13:46:57 +0000
Message-ID:
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260420130524.3527420-1-lee@kernel.org>
In-Reply-To: <20260420130524.3527420-1-lee@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|GVXP189MB2678:EE_
x-ms-office365-filtering-correlation-id: d7f438ab-836e-4c2a-c421-08de9ee34a82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 5gsuUYE1+XGA1sZ7Fpk97uKXGaW7E9UrSiMqRxrGSQXSUxP+0syEwr0+YiqEcZ3N7a7SEkUi8Tot/1b5iKODZdgEDatnDBdLf3sdSaf6fm0JO/X5pyieWyLgth7EORG2UprCJOMAxJdQsejc/O8953UKdutvDlBd4AYrA6TvCGeFo5vUPg7xjKzH2ePdLGK1nYUZdyiW+VdlHcDXdGqlIWP5BGKT+4f7EY5g178Kw0d6UOna7spKtNu5OF55oPU9rTbhWp4FIBgF08/ahcsfkxaOg+jnxJ3AgZnmfu2VywbQ1a5fmqUkXw0Wc6L8deRZGuHehrUUZdgm49tM+p5UmvZ6sO5bHefN1Ef8vaovNgqyUdIaB+jrgBYRkboOFwkKf+vWXFitrwfCbOz8cJbc4VR/z2y2EE3LaMakAcf461hZMpr6SSPQchrCbSx1cbNF2DVyU5cN3t01FF5FuzJXxrsVKXiVAK9ikDmN2Zw7qjFZk2C3yB79VhhBEpibpigpxaMCehTLWIqFSstiS2lpj7cc8w+7jpTkjBayfbMCrzeV2xErXTL+49sW6qIzBoUCqs3+udPoYT8WUKuYP1Owgf42O2zC/1363MKszPm1nrocUjRf2ugQTDRNmW8XBzegngWoryKI2qjHulRgOugQYATMTcKklJZmfWjOvDWaMcoqJgh6nhtA7DF1C93izp2BI5h7m5gSNIeDG1RqR6ZSNr/iL3+BZInrCH9MOWpktd8hyuI5DrdzAud81ww8FQKPnH/Zf1hpoGfxswJKmbJcz3eMuVXJjMUjLs6hsFuNjEc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GxNcXV2QuX3xHQ/imjrXCe0hpKUBgcybuNc2Ymi0nyAExd+aHraRhv63YjHa?=
 =?us-ascii?Q?eTPioW92hrBIpVz8GLKyv+T4vjW0DKTEW93FRtT1wbkSGKkS1MMMwyRcVvPL?=
 =?us-ascii?Q?Ki/NzruYwf8sgHIIekoqXjqjspDfbukZIZJGCyx9qVJoROxUiXV5KEXHnBIU?=
 =?us-ascii?Q?K9GtISgRHj4wkPNR7lmVgouO7U22alu5LjFGux+ldsQeBHR2AoOM70rfGxfy?=
 =?us-ascii?Q?WUH5sC46rIQGPf+CNs/hj2QhYzwQlhWqktEAyvfYy+wVRXScu9h2zLAfUQan?=
 =?us-ascii?Q?3obcOHZArB3raAw9yV6oMWfb9n75ha9obAB7/yudpJ3ZFUYmPx3fAXIvSWos?=
 =?us-ascii?Q?P6GeNfxX77iutnZdAp5nqJ3AWeEll1MdqEOgWeOMADpTGKGEi0sFXRdYC1H3?=
 =?us-ascii?Q?I3Y+c99rkiofZZNwsCZHNlNPdn0a37mqrfuV9y/cv3NdHDu+sKP97Lo3+K9M?=
 =?us-ascii?Q?nz+bCI1rTm5hS1wMJ0FUmt0f1Vsf+8vpZDYy9W3tyP5K8lZZex/iG2uBYS8x?=
 =?us-ascii?Q?fe/pl+5NHMrscWVUWbT8c6loVwCH76koXSuJtNAY/mJyGVh+0P5Skv/HEucX?=
 =?us-ascii?Q?A3uONoSp0L+Ly5AfYdAQPjb/rOMoZ3wGDU2Vms4zEIj2LxH0cPkv9yQdKm6u?=
 =?us-ascii?Q?CKKW9lvqUdEB06q49Y8s00Gyp9GW7VTr/diNNTJq8hplVLseT939p/rdBNOr?=
 =?us-ascii?Q?fI2/dQNK36rOxyNDkDVZshypM2mdUHPMtWbtnTC5hkBggJrGqr0C87WhBKnx?=
 =?us-ascii?Q?Qtyn0uUzKnklUS/5e/IFDg9JZsMFexdbL6owVQMF/x4H7Y/OwfznQrxVX/Ro?=
 =?us-ascii?Q?27/Ixx+MAJ35KEf34IGqwGqgG1TTRgbv+K1iP/LpgDInxMrLyNJnp/jKW1t/?=
 =?us-ascii?Q?6J2O8wlgamXhLFZM8oWxZC2OXVrnoYMF7sSVLLAOOJNZRSThHrgBmLkLnkc0?=
 =?us-ascii?Q?5PlPyb/HTqXP2wXso7XgCV/RmYtSra80zRVAP2vAQfOUMd4mI5heprdSbfkj?=
 =?us-ascii?Q?oeQISsLkBepqbtOS39zhrbiyU2bpBa26cRA48g+vfT2/RlLEePwT9CIOXAEA?=
 =?us-ascii?Q?BkejC3Mx+WMTysdrjmPhPTc3Z+dzRWrfxq/yEjrX5H+HGUAw1LYmdKtGczPK?=
 =?us-ascii?Q?4PKAuCtVFmVLfQhA8M8UnQo2H/lVg4Wr6+vqbFsEHdzNlqStXt10ljgRZcsd?=
 =?us-ascii?Q?upxBbQYgkbqPY1p8UdYOYD8HzsFYjj47mg0X7Jtl9QhZpg5v176l0noCwI1n?=
 =?us-ascii?Q?385ZFz0GFUTZCU8Z00n4TwnFrjAuQQAthHswA799xg+l7Qgb5lQXWqgTFtyc?=
 =?us-ascii?Q?xfTyPynrfIzwwKKxlsVp0+VnoGrgfwPF3UJkHQU0b3ehzSBORkgEPmw1EIQW?=
 =?us-ascii?Q?UvoNWpKKt/eFzFjG3FqlhVFpMaIgawqZjKL6y3+CcKOd4gireM5mYyWwnQBw?=
 =?us-ascii?Q?DOP9JwSrga8fbET33za++TNyGrga1OR96bJ/bS4Wq9WP2U4qslAY4RsJlUQZ?=
 =?us-ascii?Q?fOj68d+y62xQ4Dm1an2Po/1XkSCk99njXLWrpzuBlmQD9qEpyXbBBnzLrggV?=
 =?us-ascii?Q?tCh3Z59rk0w5gXlC+FJhX0J0Eqc5hEFT76ol7yO//SS0RBZQAH6WQg+bp/vH?=
 =?us-ascii?Q?8fR8b1sCoUiPwP7WhdTicqgLEwXdEh4LpYmZ7vVP+m6rLkzvYXgt1EMl49QY?=
 =?us-ascii?Q?UvYCNWO4IRR7lJhDTGCR+eQyGAYKJ9LWdr3IFQlRn6QvKIQ3S4tKaD3eNZ+x?=
 =?us-ascii?Q?6Rp5iOgtbg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f438ab-836e-4c2a-c421-08de9ee34a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 13:46:57.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 20g+cEFT93Q6EenZ+RoW9m30fJosFpxgDk1vKOy+Ef3sU1Ggh/wF9qmPjr3XPpffpXHpxyK9Uz/GYuFURTxoqDRDPJgtGoqhXvYe1MGFWS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2678
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279833-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,est.tech:dkim]
X-Rspamd-Queue-Id: D9ADC42F665
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
>
>The tipc_msg_validate() function can potentially reallocate the skb it is
>validating, freeing the old one.  In tipc_buf_append(), it was being calle=
d with a
>pointer to a local variable which was a copy of the caller's skb pointer.
>
>If the skb was reallocated and validation subsequently failed, the error
>handling path would free the original skb pointer, which had already been
>freed, leading to double-free.
>
>Fix this by passing the caller's skb pointer-pointer directly to
>tipc_msg_validate(), ensuring any modification is reflected correctly.
>The local skb pointer is then updated from the (possibly modified) caller'=
s
>pointer.
>
>Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb truesize and
>contents")
>Assisted-by: Gemini:gemini-3.1-pro-preview
>Signed-off-by: Lee Jones <lee@kernel.org>
>---
> net/tipc/msg.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/tipc/msg.c b/net/tipc/msg.c index 76284fc538eb..9f4f612ee=
027
>100644
>--- a/net/tipc/msg.c
>+++ b/net/tipc/msg.c
>@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff **headbuf, struct
>sk_buff **buf)
>
> 	if (fragid =3D=3D LAST_FRAGMENT) {
> 		TIPC_SKB_CB(head)->validated =3D 0;
>-		if (unlikely(!tipc_msg_validate(&head)))
>+		if (unlikely(!tipc_msg_validate(headbuf)))
> 			goto err;
>+		head =3D *headbuf;
This is a known issue and was reported via https://patchwork.kernel.org/pro=
ject/netdevbpf/patch/20260330205313.2433372-1-nicholas@carlini.com/
The author did not respond to my comment.
Can you improve the fix by applying my patch?

diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 76284fc538eb..01a693559589 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -177,8 +177,19 @@ int tipc_buf_append(struct sk_buff **headbuf, struct s=
k_buff **buf)
=20
        if (fragid =3D=3D LAST_FRAGMENT) {
                TIPC_SKB_CB(head)->validated =3D 0;
-               if (unlikely(!tipc_msg_validate(&head)))
+               if (unlikely(!tipc_msg_validate(&head))) {
+                       /* reassembled skb has been freed in
+                        * tipc_msg_validate() because of invalid truesize.
+                        * head now points to newly-allocated reassembled s=
kb
+                        * while *headbuf points to freed reassembled skb.
+                        * So, correct *headbuf for freeing newly-allocated
+                        * reassembled skb later.
+                        */
+                       if (head !=3D *headbuf)
+                               *headbuf =3D head;
+
                        goto err;
+               }
                *buf =3D head;
                TIPC_SKB_CB(head)->tail =3D NULL;
                *headbuf =3D NULL;
> 		*buf =3D head;
> 		TIPC_SKB_CB(head)->tail =3D NULL;
> 		*headbuf =3D NULL;
>--
>2.54.0.rc1.513.gad8abe7a5a-goog
>


