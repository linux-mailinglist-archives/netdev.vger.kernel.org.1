Return-Path: <netdev+bounces-171022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B815A4B2A4
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189677A3D82
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C24D1D7E26;
	Sun,  2 Mar 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Zk8hDkgK"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424611172A
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740929875; cv=fail; b=KcSAA9cGVuXZovkjAoy2pkoXiVVfZY0Da1o3dZ00mm4vVSFPN3bcMy1Be8gbPc9LcxsfwMNS31noCnRhR7zjSgU8kgaOJvEDU09LI+TDj53mH0xh9PqqJ1uZ2ZOvzwVMUr0zvVYK4DNin1PgiDT2607oAabwCm3LP9YKBiMpOF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740929875; c=relaxed/simple;
	bh=t42tKViFwjiSBG5UX2rTaPm+gOpWcgV3B5Tk3Gii/mI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOqy9jJtCpAgh43NH9UCBw4Hnm19WIxTH4P3EU2KzJqrSFOxUHO94+rUEAssOKpdhocDv5wraxtTFmL2OH48pxQ4k+QbvFLS2JpNIw7+iEFOhFajVS7fpuoDxxQmAxKWEvblPVnP4Vdl1SxnIVL3CmA1ixeIWTlNRpr2goWWx3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Zk8hDkgK; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eM0d8SwWDS1A4oZHIzij3tCur14b8PqZBwSRXeHDPQ2mzhIJUVefFQUWk69AURGYsqeOebuy0+GODI1ZoDxo4kt0c0S4OYaae42hfM/aoJoHKRg+WoLXPfRwZnrhO2UncloSXim+ZbE+l8L+hNQUItP0tJRQDbeezpvgaKYCR+ByY2K+KwoElBnX0y7zv2kD+/LjwN3WO6Gwjpek+9hlIc22y+46a9ioUq4BuenVS6KgaCcjHU/lVjjVPKoz+9910U+uvveYmf2zXNgG3LVbhTJSlgaok9uPfkOup6cTKgf6Hx7DGDLGTvfOn1jPvWY8Ep68Pd+DeIddO3hxVXZm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFN3AA8zCrRXyXg+G896p6n3mgdRRLI6uppeyeam20M=;
 b=RpeHeBBDn6H5xQlpdDDuqeNrwzjQnl7tjS/7kvIrgk0Y6ptvjiiXUBkwkmNp/z7LE34mdljw9RUpUVfvwpsvOngXlZDYajzWUTJVTvqg/bQ+Q822/fFMmjb0cyY4TUpU6qjCl8afg5SHuG7fpEQu/6nsaEWeUKp19wx3xKnRlAdaz0nEHQ0olprMbD/0ruix4hAqul3z7tpvzYcIEVRQhkxKQpO2d/bdFpRY6l5Iy5brBivahqdcQXRk/H7lfDOvDaCt9DyNu3OQluAskhcVkBtOKGjPHf3F9cmFS9nvzMciQyS5MD0qsgoWTblYGKg+UKzc212VHwbjogIW9idYtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFN3AA8zCrRXyXg+G896p6n3mgdRRLI6uppeyeam20M=;
 b=Zk8hDkgKVwp/lCjic2atcdWIIAkA+zsMjV96l6iaKLFjO9UEyWI8mLrq+6es/sNjtL1cs3Lc2fo1hk51jOh6Xgs1i3tZ+3+KmzMybEzYAoVkg2WYgWogpnhcO6W1jUZe6q8Xv5WlrGbW/6dd3o3VZwnuxCXNvWEghTZDCbWe66I0BAQpmUIttnshuQsf3bvO2Gy1pctJO1kPkNkZx479vBT9DA0yKtC1zyQmiaiFDIOnhhZRy4jNMpkGhZLRuQyhSHRXzm+rN5LKAyaL9yQcowXFz4tlNNEP1uI1GDi7kb0No1dq/vSOVQy+p1SLtCdKU458IfOOPvJG+GfkKEPHeg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAVPR07MB9190.eurprd07.prod.outlook.com (2603:10a6:102:318::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Sun, 2 Mar
 2025 15:37:49 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 15:37:49 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, Olga Albisser
	<olga@albisser.org>, "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
Subject: RE: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbhRGpRqdS8ilJAk66wE/wVU7KP7NYxDQAgAc7ENA=
Date: Sun, 2 Mar 2025 15:37:49 +0000
Message-ID:
 <PAXPR07MB79844B87A8573E4CFF7F6993A3CE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
 <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
 <Z75jOFUVWNht/JO0@pop-os.localdomain>
In-Reply-To: <Z75jOFUVWNht/JO0@pop-os.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAVPR07MB9190:EE_
x-ms-office365-filtering-correlation-id: 03944ec1-f577-477d-c2de-08dd59a0304d
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?USB3Ck5AdJWOp50MO4LQwL8pgIafUXN0fFZCIOcQUH1rP2rv3bJINEfA/IDF?=
 =?us-ascii?Q?5WNTgq98AKrSgp28Me3oG1BFFnH3+Nb5IQocnmTOXoTC/I3yHcED96J+S1di?=
 =?us-ascii?Q?bfRpLNdIUSAF6IXYs27vIfIzUuBffZoz5xfiKNQ/M5eOFODbcaIu3OpGY1V/?=
 =?us-ascii?Q?IO/dGaZqowO9GDlk8ewXN3bGYVv7XA2ZfkGCyseNuyXEsXTUj/i7YrYQnbEF?=
 =?us-ascii?Q?XfoNSIa/iRH51lFZBB2W9XW9wPDMCznossuk89KDX8BT9bXMQZ2ahtXDFamd?=
 =?us-ascii?Q?k2trULjBSV/z2z5l0g5vMG7/7MZVihM9g+3JrRjaSvOwlEGDxNS3A/lRG0k4?=
 =?us-ascii?Q?IjD2zd9fzDNZXn9CYz6XEmHCS+v2L673mFN8f9uLgJV8oGBMhH6pPlOcaIvV?=
 =?us-ascii?Q?MuKV3KN9xDAji9Wm1Cbfdp7FGhxrRe47HoGeEL6p2qbqER4s+00qc1HZbsuq?=
 =?us-ascii?Q?5/AMXZ77R3hxwfVtcYujoeNT1ZERHukfLiHnFYfoX1h6fYH2RchVSyaqVW53?=
 =?us-ascii?Q?pAgc+ElTrEnt1Z5uvBn3Mfw5vR8tLA5MGaMD6UQRKRZaJQ/zwDnRPOfGDfM1?=
 =?us-ascii?Q?nhsL/FEJoeH32Av4SgOkkCYWUWmP5KeGn0teZISXqhzqws3cWI170G7u6FD6?=
 =?us-ascii?Q?OVCRKKKjWYGWk4G21RyeUsOjs53LRtdPbTRrAlcjz0yUUl7Upd9igYwc/GH4?=
 =?us-ascii?Q?sordvpIFHXuISeXEKzXdnHmcjhaLfB7Lf9z6IawpJYYCgqNPURiPK/CEoTEX?=
 =?us-ascii?Q?ZqSRiQxJzi9xWj6fvCd3rz/SAhuJhAiblUkGBRYyPbY5oFLRxxIBdBn8hfyB?=
 =?us-ascii?Q?BWehWWE9ZG6TN8hJpPE1MnUbVE+lHAoXOPnzRZrGiDz5rWSk3V9ocfKberA4?=
 =?us-ascii?Q?+5V69zwxyxpmu8X4y7ShA+jCtKVwnMSG4JE5jHTX6ntasa77u2XQjfs6L86k?=
 =?us-ascii?Q?Ybo649hTL10/8VGt+4jEIM95dEZdV/QExOclRQ/TULu/SZpYpUyWmhrw68hs?=
 =?us-ascii?Q?GoaWDFAWX39wbhQd8bZ8fMIUvDnw99i3K+8HHrkT20nWWmeAJBWy5hi1rYUN?=
 =?us-ascii?Q?Of1/yDEC9EY3iv21rZ2QasSiYgz2jGeiQTaPTAqNzq8SXyMVziy/PFvq7Wu3?=
 =?us-ascii?Q?/L/Zaolnru8mVZ2Ze2jpTyJn6zTJPzEMttPr3i3o+ni7jDYaVAVO9BLJ5PYy?=
 =?us-ascii?Q?7koUMVRC56uCgejsDvGYOPrtKWNUtoTTnPfDCprzVFgdXNHLIse8eU2QH8hQ?=
 =?us-ascii?Q?1ghPlIOQwnY7pGvE2QIgpmL1Q+Vg4dVOkxvqlCQopddBzdJOyJtpqWekjeni?=
 =?us-ascii?Q?cKZ5mkBHrVmpggJ1tKXjWQhpglUU75MU9iQZW6zs1LZqSGc1CkKoFvlEMrf8?=
 =?us-ascii?Q?MnD8W3oxClQss/cCeabxfi0rxWBOlB2ZizjB0+jTQrozaCpohQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kQgjiPpXHeah7Ixq2lhI+KAUd8u/Ro1wAXXgO4buIPuhBvdMm2uNJbIT7LRQ?=
 =?us-ascii?Q?6Dn4FfzlnzlG9AwEYkEleBZZb+47674dUPKjW7txgjf2/9D3GMh8DepePtTo?=
 =?us-ascii?Q?nLPhlFap6SYhcFax+e9B2sndLYmOd9w1VzEZ5rhhrPx7pDhxIxgaFfQj9nsu?=
 =?us-ascii?Q?a6nsItwElbbYDDjC4apHEvNRyx+rT56EQCu3+2gqjoQKg3qLY663RS9f14a6?=
 =?us-ascii?Q?CFeIQLPXQIQ1+zWpgPo/oKeLQOnD53fp5TBeG3ekVt7QIHUEfjKaMLYyBWoj?=
 =?us-ascii?Q?01DZMMnSH2ev4UzMQybYSB/tQ9LxJ1/DOuZJoJywcOqLg1WA94mUl9NfI2lt?=
 =?us-ascii?Q?wB+c0Moy0BeNFelthPujAMNzlguXU8IiOrS8lWCnLhL0/0bAWsfFNOkepa8U?=
 =?us-ascii?Q?4taw8+rzmAlrGrQ8sD5SmiN/DnWE/FRcCZcnH//zlRMb/TY61ue3PMrClmgo?=
 =?us-ascii?Q?gaEf7NVTE11eqeqXRSlqN6ALQNMtA/m6u3v7wgRlzD3j7fin1qfpTI2eKOcW?=
 =?us-ascii?Q?gspVYG28PPL8ydZRV0jywVk1F/hLmHdvtrMFxzjL9IhKNlUkwss+tNi6m5Ll?=
 =?us-ascii?Q?EuHMWKydEifKSxF/7O4+qzB5UUdtVZO4fVFggJeh7eHaeH2aiTB4L2gWB2S5?=
 =?us-ascii?Q?bLAi+GHqEkfh8/b9S6uPeTgcCEkVTNO5aqMkPpmmirXI7PJVctPT/PZNoYWh?=
 =?us-ascii?Q?R6fVqKBfSvnVWJhi2Z8FXFfzyLDV/zbUB7W1tO2mTmYZAd2QGtPzhhtfzWCU?=
 =?us-ascii?Q?bppIUohqZhBC7H5yKsvIx2OI2Dc17MSbnkA2kxeAL7MaXVL9ou+9BwLl6SO2?=
 =?us-ascii?Q?Ar0VuKk1NxS4WeDjFP8l0nvD8jkF811VvgQ9lciUOxoYRZQ/ThvoROU+8t73?=
 =?us-ascii?Q?2FJI3hAaSxC0SOLsA+y8U/VQMV+BJoQC6P2pGIfaVQbiZRokcpizmLxn5NOb?=
 =?us-ascii?Q?Hk6hXkZxYKIc9Jk0wKqGu9bQOFgqrByBTkKMW/mn5K16c4y8bS0NOqy79dLQ?=
 =?us-ascii?Q?jiNdAf4OyBuzb+9pMzffNyNRdEiuRRrKENCm+fvq5XmDliT5BW2+SsGFSvv/?=
 =?us-ascii?Q?LF8TFNPUauL9tDExnFulhFqeUiT5GM9EMoEEDcRc+rfoKVqv694ufelnZaOk?=
 =?us-ascii?Q?jf1OYebe2DeQwQC3xTk5IytukV/HbkwsqJTS2vTy+42Ziiqb2CEXBM144W8H?=
 =?us-ascii?Q?v1zdwT/sZSTS8ZVHKlZx5tHINgrzC6dGJlR9gpSOnqFoU+TSvwnzyJq8MLRb?=
 =?us-ascii?Q?CSBQ93UfVl4jN7znlq+ehQruZ/RsSwymPSYaCspuW5mP13LV8vyUsnC3Sntv?=
 =?us-ascii?Q?SQvJwsmWHJILSs6+pJT01/qBEumjlpHKoCLaGyqAuqFJZlxbomFl3TfyGvIT?=
 =?us-ascii?Q?QD4qhklINi6ZctttPEZy9nQeIJ57orYNTd7xq2YnaQFSN1RdlFDon7nYw4vU?=
 =?us-ascii?Q?xyntzueGXzBjwlP5ZoE+xWL0Su2CGLvdQ3RRya6jLHSxQYxe8avHI4VgXWPn?=
 =?us-ascii?Q?UT4rvTuhfG9jh6T8PEebZj1Rk/hBaBVZhloimH2M3hceIsnQx28IpDojmBQp?=
 =?us-ascii?Q?EF+gdoTMJ7HDyXXnX1lvKjTnaJhhE2hF/EE1BpDEaPnUXFPRR9+4k6c66zWq?=
 =?us-ascii?Q?XrNk8/HT42BDsRfLZ5E5zHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03944ec1-f577-477d-c2de-08dd59a0304d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 15:37:49.6066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4D/r/cMNFJwRt0M2OPf7jRtTn5yBR+yZqsfVRAvg9Pzf7nvbuEOqe1DKyQuGCHTxRKHbAH09odSMlDl89XOrssz2cJ+soS4iFevhQTgbm5VbBlEQK2GurwutfGmEHh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9190

Please see below inline

Regards,
Chia-Yu

> -----Original Message-----
> From: Cong Wang <xiyou.wangcong@gmail.com>=20
> Sent: Wednesday, February 26, 2025 1:41 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@m=
ojatatu.com; kuba@kernel.org; stephen@networkplumber.org; jiri@resnulli.us;=
 davem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+netdev@=
lunn.ch; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koe=
n.de_schepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingema=
r.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.c=
om; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com; Olga=
 Albisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nok=
ia.com>; Henrik Steen <henrist@henrist.net>; Bob Briscoe <research@bobbrisc=
oe.net>
> Subject: Re: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sat, Feb 22, 2025 at 11:07:25AM +0100, chia-yu.chang@nokia-bell-labs.c=
om wrote:
> > From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> >
> > DualPI2 provides L4S-type low latency & loss to traffic that uses a=20
> > scalable congestion controller (e.g. TCP-Prague, DCTCP) without=20
> > degrading the performance of 'classic' traffic (e.g. Reno, Cubic=20
> > etc.). It is intended to be the reference implementation of the IETF's=
=20
> > DualQ Coupled AQM.
> >
> > The qdisc provides two queues called low latency and classic. It=20
> > classifies packets based on the ECN field in the IP headers. By=20
> > default it directs non-ECN and ECT(0) into the classic queue and
> > ECT(1) and CE into the low latency queue, as per the IETF spec.
>=20
> Thanks for your work!
>=20
> I have a naive question here: Why not using an existing multi-queue Qdisc=
 (e.g. pfifo has 3 bands/queues) with a filter which is capable of classify=
ing packets with ECN field.

Making two independent queues without "coupling" cannot meet the goal of Du=
alPI2 mentioned in RFC9332: "...to preserve fairness between ECN-capable an=
d non-ECN-capable traffic."
Further, it might even starve Classic traffic, which also does not fulfill =
the requirements in RFC9332: "...although priority MUST be bounded in order=
 not to starve Classic traffic."

DualPI2 is to maintain approximate per-flow fairness on L-queue and C-queue=
, and a single qdisc is made with a coupling factor (i.e., ECN marking prob=
ability and non-ECN dropping probability) and a scheduler between two queue=
s.

I would modify commit message to reflect the above points, and hope this if=
 fine for you.

> >
> > Each queue runs its own AQM:
> > * The classic AQM is called PI2, which is similar to the PIE AQM but
> >   more responsive and simpler. Classic traffic requires a decent
> >   target queue (default 15ms for Internet deployment) to fully
> >   utilize the link and to avoid high drop rates.
> > * The low latency AQM is, by default, a very shallow ECN marking
> >   threshold (1ms) similar to that used for DCTCP.
>=20
> Likewise, PIE or other AQM Qdisc's can be combined with other Qdisc's to =
form an hierarchy, which could perpahs achieve the same goal of yours.
>=20
> Taking one step back, even if all the current combinations are not suitab=
le, please evaluate what piece is missing and see if we could just bring a =
smaller new piece to this puzzle to solve it.
>=20
> The reason why we usually prefer small pieces is because users would have=
 their freedom to combine all the reasonable piecies in their own way.
>=20
> Thanks!

