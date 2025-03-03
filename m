Return-Path: <netdev+bounces-171075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098FDA4B5B9
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 02:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CB616968C
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 01:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B362126BF9;
	Mon,  3 Mar 2025 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="jSXH0Nvu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012078F39
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740964242; cv=fail; b=BGreOjppBi4lVoe1KVXFx8lgaNh+hHkf3MV2T1tvKMgjCAUluUbmEPqGJuVtzLt2sOQF6qpa7FGDxAjzZeeSBhD85Ahb1LNaiP36y8uEX0lHT7pPwCJF/wtC6it8rLnP2Wz3A3LXai7eXCi2Vur0iZOvIDZS0ApFSsGrZQS8wgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740964242; c=relaxed/simple;
	bh=xYD/her0JJXAxRdkFYT3p6jDBChMD5FGVNR8Z5lKiiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLGqE3KDTD1D3zqJBU4ZNJ31haPpJGUlJExFgoDqoAqxrpqejnf3MBgfU/7WGSHc0Jaj8TgDp4oXeImmoKys8ipV5CGlC15irdtKG5zW8IRygYB1UeJvbhJ53IkFjQAyhJfDb8cA264fPhwW0GrmRYG7nZ2NXlBIkTzS4fC4Ah0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=jSXH0Nvu; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2yeQt4KbyGvz9sSe14jVWxBifwUPFUK4UMf42cE8S0OnXhHy4rFqSaVlUR2sHhLNxazugNs0rmmBRgLs5CjY+MfVTt3BGGnvbO8hj5qmrYGWbBHFePlvDe7a+Ff/Hr7QusvBadqj0m3TMS3LGZLA4/ZBaji/jcGvg12w5SN/SqWhHUb9V8RvYhJU74W7YEXWQylp+rzJH1XOEqVNQ3erK8rR/eMPgHIi+DjMIK0RFk0ow058qI2c5ROHoZr8FLRQ5FR7rcPQNfZUM6Ce8kCwyzx6wj5DR+RFddk/fzeNG4YrCvNE5Ys2eweTyj7jTxS18HRFFOigoVyMwYBnTjZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYD/her0JJXAxRdkFYT3p6jDBChMD5FGVNR8Z5lKiiI=;
 b=bAQroEFduotOeaGWos/z67PtfEeah+e2y5F8USUbf0l2v8S6t2T8yVp7ieOBzgiGy71hcazTng+R20o+wwpACFA9HVgh6oQEF9IvOwnjUHxBanybRoRrJtGFXS6mHZhYeEL54/Y2nx0DmceFyZG4mbzcuTdyFQQwtYK04STlvsKoRnyzv4zB/KCR6JJdZ0/ZfAMfJ8c9PNVTjaRZS33k8Gy5ihLAs9HCODl8HT5XFscbE7dectABp46M8x2gOXvbx5MtV028M/uNAVqh5c0l9yakRTCVUT9bik5hip310wMAi14thjDuC0q7wPv0/rYDsdesNyCdeKRWOFVYJSQC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYD/her0JJXAxRdkFYT3p6jDBChMD5FGVNR8Z5lKiiI=;
 b=jSXH0NvucaYzYEIN1C3Ey4CPSrxtj1+BF/BhFZVUsdH7e+srspm894fe6ul5efaTYLKVMpgpZ35HnwcQApeOT6jtboLedsqavhMU/9gUg6BuN23/u+Vb34GpH/cyWvzY1vVk5d5TlL4ML7OphnONTCHYMik35+q5XcwV9czxJ08QHCVaD8lIO3R8P8BsDeiZ9JJid743qEjG2vktZdLYfG0CGIsRZJhqQ4pUSI7yTRoFKSnCJK2WqNlrCudFo5DHNq6u9L1P6vnWVod3euT6a9JhjfaefM1tzh+FefUZUSTgGbN56t/w41Ns/bbDKXg/RQSY8aoEFlyUAS5I1omoEQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB8769.eurprd07.prod.outlook.com (2603:10a6:102:244::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 01:10:36 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 01:10:36 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Alex Burr <alex.burr@ealdwulf.org.uk>
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
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: RE: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbhRGpRqdS8ilJAk66wE/wVU7KP7NYxDQAgAc7ENCAABaQAIAAi5yA
Date: Mon, 3 Mar 2025 01:10:36 +0000
Message-ID:
 <PAXPR07MB7984FC1BD619D9F667DD9A00A3C92@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
 <20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
 <Z75jOFUVWNht/JO0@pop-os.localdomain>
 <PAXPR07MB79844B87A8573E4CFF7F6993A3CE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <s6XvSuJ8nXItuCMN4KLwbJvYh8P3pAtM4TpVWLomsju1tts9T7CGMmmuWSJcIhkC-aXOZndLLoB8jIfDCwdkVH6POUi86FIO5jfkcUhI2nw=@ealdwulf.org.uk>
In-Reply-To:
 <s6XvSuJ8nXItuCMN4KLwbJvYh8P3pAtM4TpVWLomsju1tts9T7CGMmmuWSJcIhkC-aXOZndLLoB8jIfDCwdkVH6POUi86FIO5jfkcUhI2nw=@ealdwulf.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB8769:EE_
x-ms-office365-filtering-correlation-id: 9f7b409f-053a-4016-f5f5-08dd59f03475
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XC+yN/HvzUQvcFburg7t8o3riDFI/teHXzdTH29ffWeLNqt65QunLc8IN+xN?=
 =?us-ascii?Q?D5HJM5t+5MiQn1Se0zivaxpUAjuyv7aWOd0N+1ggsmm8C/YYYgDc65b80Pq5?=
 =?us-ascii?Q?m2YrQ6w6iDsbLB/nMtByk5qIxq5cCrLCwk25NoHVOB7zeHK0ezqM9O9VtFG0?=
 =?us-ascii?Q?jow0jMOjht+yoxMafeSq0i1j2eQuPKW4yCQ98mXhkwspzyvZVVehY9SLnsDB?=
 =?us-ascii?Q?0Ga1mn6vEIcbio862pzJfyUWMElBNXl+nQOJAcFI8olr9BYpxPdxZHpxFjqz?=
 =?us-ascii?Q?njqe41wACh5YcMWThYIqHMnnueMNdxOGshk/tWKyiAWpVIFv4uu8UrhQYBj5?=
 =?us-ascii?Q?HEMm8DCU2og81lIN8ES7FxBTbKT/MpaeyOwAbJ5UORRmK6HosmH8whP2ZdXg?=
 =?us-ascii?Q?1/5i0soD8/3vIf7MT3fHWNLALhkCtovTV6xto7I2O/gW9wEnbsEwcXM26oPe?=
 =?us-ascii?Q?EFYkBTLVLn6sLhzwIvWzFxc7AQ6f4bFGpH30c0mcXDT5zkCZQlSPC/Ftj39R?=
 =?us-ascii?Q?31eY0H34rZ/y78jL6GkVOJ2vJ4UwFeR2eyt+ILG74y70ysYQDPxSev+Dikbt?=
 =?us-ascii?Q?IpLMIX2JVV9ib/xOU6mPAcxeVuSfy3lz3d7G2As9w69Pes/pn5D3Yz36lkdQ?=
 =?us-ascii?Q?4GhqoF1f4k+e2Ku6+4R474U0BY8a4RjP6ewn+qV1QbhMYDtJR46zQUioVtTS?=
 =?us-ascii?Q?ns3uxDPDNh09lxCTn3ZsEF3zsxzlrac7Cmi2pCLARh8StJtIk0Ai2ngL0wql?=
 =?us-ascii?Q?NSRaoNllgW7HGdHSR77fvy/BDIclPGk+xUrI0hBz5ikPeBwtdeZiCwJVIoJQ?=
 =?us-ascii?Q?cGt1WLYZpkzA8bssOmKLDdmMG94MtdCNyQjB7R2OeXY5Qy6NQBGJ+pCTkl52?=
 =?us-ascii?Q?s0oyni/eTmZnZNiXSdrrC2vsj6D+r3qwG26d+Sr70fFYkfAi8iQbdOceT+10?=
 =?us-ascii?Q?nwJ2DDD2U7efvp4NPkjPaqjzLRCk4eI/JZolHhhHpgIcYimBgGXxWac+3FF/?=
 =?us-ascii?Q?q+QaitQp33UuEHmBlo3LFPzemsf+10R+MZQJ16EstkveR9TwrPjAwSaDq9JY?=
 =?us-ascii?Q?7tArrt6aj73vX1CtWBdG+d0OreB3zZdHcJWiswu+D0sj8l3vUWFTZCUCwCVT?=
 =?us-ascii?Q?/sTyS1ur0++jgL3Vja8n5Md2QYaJGwNYYJvAKSrLTqPCCQdomifiLSyIClEu?=
 =?us-ascii?Q?PmuKQtuj+9yiEhEdEVyqnR/YNGaW+QsKBHo3CdN3yVJFk1XyWzHsJATb3lNd?=
 =?us-ascii?Q?93y6wXRAcs/1bpPS/J9pJYEf/lwHBYVRX2Z0skXW2IzgrWoBU5Mg0txL97m0?=
 =?us-ascii?Q?CW9xBPj/wgseGIcjb79GBCXAoRT21Bz2hXMtAWRe3K6ZnVJ1N8DH5An9koIt?=
 =?us-ascii?Q?TI7LVaKESK33pzfzB1fRPK2NbZum?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pJmaFor+54tgtM0IHY8llubw7OQ9Vv9Tr12k1mXDivZ7p0ELl31+bCTKTNma?=
 =?us-ascii?Q?wMbjLV4Z2U1ORXsGtCcUtoy7hwFU2w8+vVAwlHiE4LpU/bjjLpiTqf6gSenw?=
 =?us-ascii?Q?WnMOLkrVg63qlLlv3rewNc+nUTAijpUZbHqXizk8LY1wGc0aEHMiv3YOpZJo?=
 =?us-ascii?Q?9VuR4b7dEjVBkW93VDRFOUjkMawC4AgbM597FFwHUfEuvoR/h+ku/LNhu+6r?=
 =?us-ascii?Q?dbrIIn7FElq73axs5Nr+M+Sqx72bNyFl9sIIrYlii6mCNXINCfdgMDuPee2h?=
 =?us-ascii?Q?L01R45fHmdNcQXXzQhL5+jkSJlTF2rdqCcIukNsmI115TJiQ0SZPrbb0Kgh2?=
 =?us-ascii?Q?rp9DAxAhKCrYMtAeFPdtR8Ti1s6CutO4esCn/sTqNNchTg2K/J8mSF9Y2j2Y?=
 =?us-ascii?Q?FKgQCkRUKZ5a4FdaJ9vb5HiWSUfMicfL60EAYLkrYg+2OKZfSz2QSjcpErG3?=
 =?us-ascii?Q?wFgVE1Qzsal3FHwYEC9vHNto9BhS4Hk/htdzBIaTtmd156tPhxlTnOwPGKVW?=
 =?us-ascii?Q?Q/4ld/2PeNTYIIe5y5O/PInz9Q2SGaclz6ftH2/bjWm+gRlv+uszZmUIVOGH?=
 =?us-ascii?Q?VJBHnPEyu6BNV3R/Oj7rzgX2eIJaFZ9PUfro8KePRtaIHKKhY+WBcvfU7QgX?=
 =?us-ascii?Q?TzXG5IWTw30zlNwXtbQ8ML1myDdmmrDNfsj/86u+o5DO3mrNiOL9ICwCYVT3?=
 =?us-ascii?Q?7c+pHO3SShEgSPbl2Oah14V0Fe6ha/1R1K/xq+j3YAW5ZrNSLWAQRJp050Vv?=
 =?us-ascii?Q?skaHo2fhJQaafUwCMb05EkMW5ALSh9TAzr8R0plQIstnLdDJHRvWYe1nZ9Ax?=
 =?us-ascii?Q?UkIE9CzNPSB7IcUg37GmnSnGaxSks8XgU606FGpmSYQMC5Qbu9MiohoqsdWF?=
 =?us-ascii?Q?bdtTlRByxAksazpVzOLB6aZvoZmUpzMzlghedMJwiRYr+GNtezvEbOa3mP46?=
 =?us-ascii?Q?e57avyVJzoG5gaZRTs95Tv11HtDDlHXqhLxBnWIoRHOHmJqjyprHT5j+u3f4?=
 =?us-ascii?Q?wmvSvD6uHSk1anaQrJs+9Ha6hVDS0wIAR0OGUOHmd0D4KnqyRFrgDP6RsD5t?=
 =?us-ascii?Q?1BksNDjbOZpN4sekZw5gUfvCwNUqw52K1oOSuhGXbgvaEWL/nheDaAyM2R0Q?=
 =?us-ascii?Q?Q3Dbk0joUYZpm4LXFHwKzt1knypwqou/G5T88KoPKjS9c7jTdEJePC+pBZkI?=
 =?us-ascii?Q?s51Poco74WL6fh88pfde9kW+N95nAaGUcZUEh7oIH4ekBm2qK2tEr8pPe40t?=
 =?us-ascii?Q?WfzLWMLDb6CVKp+OMPUPh26V35n3PI3zJz5mGCqFJncozN+7tSIeBEWCx7bj?=
 =?us-ascii?Q?1eam4JKMZZmjNtaufIiBVzYd3SYbninaFXqMa7iPT/JMZi8+TYSVPO3kNHNK?=
 =?us-ascii?Q?OeTfF1feeA7bwnyg9KBttDIgMS3rLN09StF0NlGZfcoF2KzL8dioSrdGngAB?=
 =?us-ascii?Q?mshhL9gOObE5QKvr0MgGe6CG7XqH2pS8+IMw3cnrW0yf9JRnDhihEJIgePAw?=
 =?us-ascii?Q?/gtM+ZHHQ99ugQQ6AvWhv8KRelgObvvdMw9pGYLNcnrgprSFCI46YqTy0xfB?=
 =?us-ascii?Q?FpzpbrH63fWZxb64LOOFphSfgvgJKCwkVe+qNOlLg3q4kvCiLZQBdkemP5vE?=
 =?us-ascii?Q?a9g0AnMjthOqjqiFq4RnX7w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7b409f-053a-4016-f5f5-08dd59f03475
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 01:10:36.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bjdWWBhNL4FXleCS7a0XjyJD0TDp+2FWsXrAgFjvCeWSyASgjeIllASaQjIcmcIWYKKmCgl6O7SgsB4/2qnLxePltG9BCt/F0GbKPWOwtT0Eu31EIbKiMz9C8KHJWyX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8769

Hi Alex,

Thanks for your prompt feedback, please see below.

> Hi Chia-yu,
> Please see inline
>=20
> On Sunday, 2 March 2025 at 15:37, Chia-Yu Chang (Nokia) <chia-yu.chang@no=
kia-bell-labs.com> wrote:
>=20
> >
> >
> > Please see below inline
> >
> > Regards,
> > Chia-Yu
> >
> > > -----Original Message-----
> > > From: Cong Wang xiyou.wangcong@gmail.com
> > > Sent: Wednesday, February 26, 2025 1:41 AM
> > > To: Chia-Yu Chang (Nokia) chia-yu.chang@nokia-bell-labs.com
> > > Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com;=20
> > > jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org;=20
> > > jiri@resnulli.us; davem@davemloft.net; edumazet@google.com;=20
> > > horms@kernel.org; andrew+netdev@lunn.ch; ij@kernel.org;=20
> > > ncardwell@google.com; Koen De Schepper (Nokia)=20
> > > koen.de_schepper@nokia-bell-labs.com; g.white g.white@cablelabs.com;=
=20
> > > ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com;=20
> > > cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com;=20
> > > vidhi_goel@apple.com; Olga Albisser olga@albisser.org; Olivier=20
> > > Tilmans (Nokia) olivier.tilmans@nokia.com; Henrik Steen=20
> > > henrist@henrist.net; Bob Briscoe research@bobbriscoe.net
> > > Subject: Re: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
> > >
> > > CAUTION: This is an external email. Please be very careful when click=
ing links or opening attachments. See the URL nok.it/ext for additional inf=
ormation.
> > >
> > > On Sat, Feb 22, 2025 at 11:07:25AM +0100, chia-yu.chang@nokia-bell-la=
bs.com wrote:
> > >
> > > > From: Koen De Schepper koen.de_schepper@nokia-bell-labs.com
> > > >
> > > > DualPI2 provides L4S-type low latency & loss to traffic that uses=20
> > > > a scalable congestion controller (e.g. TCP-Prague, DCTCP) without=20
> > > > degrading the performance of 'classic' traffic (e.g. Reno, Cubic=20
> > > > etc.). It is intended to be the reference implementation of the=20
> > > > IETF's DualQ Coupled AQM.
> > > >
> > > > The qdisc provides two queues called low latency and classic. It=20
> > > > classifies packets based on the ECN field in the IP headers. By=20
> > > > default it directs non-ECN and ECT(0) into the classic queue and
> > > > ECT(1) and CE into the low latency queue, as per the IETF spec.
> > >
> > > Thanks for your work!
> > >
> > > I have a naive question here: Why not using an existing multi-queue Q=
disc (e.g. pfifo has 3 bands/queues) with a filter which is capable of clas=
sifying packets with ECN field.
> >
> >
> > Making two independent queues without "coupling" cannot meet the goal o=
f DualPI2 mentioned in RFC9332: "...to preserve fairness between ECN-capabl=
e and non-ECN-capable traffic."
> > Further, it might even starve Classic traffic, which also does not fulf=
ill the requirements in RFC9332: "...although priority MUST be bounded in o=
rder not to starve Classic traffic."
>=20
>=20
> Nevertheless, RFC9332 allows the use of different AQMs. It might help to =
get this work past netdev, if you can show how the PI2 part could be split =
out if, eg, someone wants Curvy-RED instead.
>=20
> Alex
>=20
Yes, you are indeed correct, RFC9332 allows for alternative queue managemen=
t.

First, the dualpi2 formulas can be found at https://www.bobbriscoe.net/proj=
ects/latency/dualpi2_netdev0x13.pdf which may be useful to see its performa=
nce and people to develop based on pseudo code on particular hardware when =
L4S traffic is needed.
Also, in sch_dualpi2.c, the must_drop() function is the place we decide whe=
ther we are using dualpi2_scalable_marking() for L4S (i.e., the marking pro=
bability is 2 times the Base PI probability) or dualpi2_classic_marking() f=
or classic (i.e., the dropping probability is the square of the Base PI pro=
bability as PI2).

However, related to split it out, I need to restructure dualpi2_sched_data =
because now it is particular to dualpi2 data structure.
I am now thinking about elaborating it in the function comments and can mak=
e it more general in the future if we see other really wants to try another=
 AQM.
Any other ideas?

Best regards,
Chia-Yu
> >
> > DualPI2 is to maintain approximate per-flow fairness on L-queue and C-q=
ueue, and a single qdisc is made with a coupling factor (i.e., ECN marking =
probability and non-ECN dropping probability) and a scheduler between two q=
ueues.
> >
> > I would modify commit message to reflect the above points, and hope thi=
s if fine for you.
> >

