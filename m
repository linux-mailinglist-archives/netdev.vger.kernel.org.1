Return-Path: <netdev+bounces-279110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC4dEQwr4WmQqAAAu9opvQ
	(envelope-from <netdev+bounces-279110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8395413BEF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BC4C300DD40
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291A3370EB;
	Thu, 16 Apr 2026 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ELtysKAa"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011042.outbound.protection.outlook.com [52.101.70.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701C337BB0;
	Thu, 16 Apr 2026 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364257; cv=fail; b=cAmsg/QXQ8yrjmGd/KjHAjpUWBoyr3zl8PSdVkf2p5mWpF3f/VOLbQ6d3RmsorwkZ+mchUHzvPvF3zxhfVrlxmZ7hq7Wrnq9DY3z4CwWJ1BwU705ms95rlOxIx09b6OZ3FTyv//LD8qSZXStAdpLIMS7SDDNWtEuN3nlsX3MOTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364257; c=relaxed/simple;
	bh=clgdMOhvZnTE1zMbkTXbqxfmo4Vjs2dWRCun3Z8Y0tk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLX0UYsG0lQGknIBH7ZGjFoCtrCkmg7TZFBTvJicGQvWyAUsNUSWMIe+r+YVhZn9JghUhV5J7lzyr2wrtVTDVmpmNk6o/gT1InlgHkxyh5TXBhQC/PuwytLe9Br4joLuHqVTVdbbECTtvuDN6+XJ9/ekrXsAUHbd5W1KErwLab0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ELtysKAa; arc=fail smtp.client-ip=52.101.70.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYuJFAlcwjnp0ZZc30W7vA8H4LDebxZEhXtzzUBQwumreXGNPrMwgB/6ALQlMcpw7Pz2CFt7veLYvESTLy89L8ml4qlJOv8uCBwLkavQg67VQglb+GpVJ9U9uk3kQ4k/cDVIZLnEG9nqJN9bW4yVCekNIsZ1jN1caRJWlbXf6sHm1656dCcIXwMYTegtPnXOL5+Ugp+IFS19tWxFmq0Bbk/XrmN0TVkRPRND/AEsIu3QiPtFTD3SuqzQbFgHSqN73d9oUp7Z03JVnGd999MHibq39l38CXIIQMCcyJZgSg9y0Nti0iRbsbOxdsRxk47hT47tldwkXZepZsGhQ6l1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pOkXaHqMHQoSuomI/D4+l9w5v6sBrsn6KIyG+rnwF4=;
 b=VYkgfH3pQcd/bRMs710+KoBGlCCQmGJoxVHhCzHsNoDkq7o33ydYX9WjP1hKxjbieC04MVgTszVjJcZBIKTbkB4ixN6VoBJIZOLOwWr3SqqHSrZ/qKhaHMBI4rnyiuR0do5Mkjoc6U9LhqtLXECe8j0ecu7lW8Ib0p3xqYZHjfB2hfLHsS93SWzcnVLIml0mWKKBW6zRVsQmjQvdK7RljakTt7hE3Pg1w6C+wcJn3SAHQeIJNLtVmBKx68p6zbaAf1ZA0+Pjx6f4TbQrunCbXlzMjlr9+ngQzjwdcvJRww2PChOBIyJhbXcrG897l8u+5ME4wJSN/jtmNlRDlvBY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pOkXaHqMHQoSuomI/D4+l9w5v6sBrsn6KIyG+rnwF4=;
 b=ELtysKAaqzQcIwXdbiWaMaSRuxhXFYGnOr+ZWScroNk17vyh0Vq9tldfGLyVfl0AwPEXMYniP+XjNi93zuLYgkv+R+OuQI34MPggywnoZ3ZjeFdWuZa9tiJgkp2kkyxnb2D1uRcR/YPbIKTzgNM99JyXeCwoTEgMNbBSndnAueIEjcWajHhMVxre4fVA4bxGWyxNOZPxEvptaTxpval+kO6ULpaHEHHCImH41OA2v7lmBWt518nIhc6XMrukcde447nYWUi87+Y9RJ2DUEQQRGW73dqvLkGwgSMiR7vJ/NH+q3pPTWWgVZMCBjiIu8pQrtBu7Xs7oDnm0RlRFQrhgA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB7228.eurprd07.prod.outlook.com (2603:10a6:10:216::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 18:30:51 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%4]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 18:30:51 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "victor@mojatatu.com" <victor@mojatatu.com>, "hxzene@gmail.com"
	<hxzene@gmail.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "kees@kernel.org" <kees@kernel.org>,
	"gustavoars@kernel.org" <gustavoars@kernel.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Topic: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimit
 enforcement when dequeueing L-queue
Thread-Index: AQHczcPB4reiT3Zmkk2SG/62ksLQwrXh+MiAgAAA65A=
Date: Thu, 16 Apr 2026 18:30:51 +0000
Message-ID:
 <PAXPR07MB7984FE65FF793F8E10F33871A3232@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260416170906.66432-1-chia-yu.chang@nokia-bell-labs.com>
 <20260416105505.22383f01@phoenix.local>
In-Reply-To: <20260416105505.22383f01@phoenix.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB7228:EE_
x-ms-office365-filtering-correlation-id: 6506a6b4-3fef-44d7-b483-08de9be649bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 7EV72GuicmCRxU+XHhzWnkwVmXpT1eBdx5sUWIN02V1tdhJTHxJCb803MKU0kqj1kRFHyxyjpVSrNbPxK/2FyK9JZ5C+3tx5HuTh61vB1E3PuZaV+gsGgh0PXVQZYDIsUgbSFafu15w5ldBW2wc1BU0DmphLNZiMa9KQ8N/TbMezf7we7JNZ3mriswvo8k/lv1tGuPRwB952mUrC/k67cXEd1hhGKpkZjSa1a7fJw/5WFdjk7LXtgrJxZmqVHqUsSqHdINpzzF6wljM8E1jNGv0SpR/LIKgis8C3gHzXsiIv60MaLmxBLRTWRF28jHGZSYOSFqCPIE321Ul1iUnYl+OKXs1skuG+Vo9T3tBrJoO8KZizIJoC7N8QLEDl0f8hPuaTtCCOM2eNvJ/pfGf0+5zPZLaxkamoRMsiM051m498suCmAsT95DHFgoTnZxEdAyTNw1JxurrZM1JOIlHYQp5PjK4Iq8SPFAmJc22jW723nMogcw2Cyn53cDiqw92h4/z0g3zE8scQiT/7Cqu3oIBADxQL8Tf5SzBEr2PwezSflHvKT3Cup9xA93nEjQki+xIZzZ/IRq6Z+UZCNVQfe+XxLYvGCGpNt3gIGY2qg6q6NwadkxNOI0VK7aIDKvg7fX1riOl9xWMi3ui2TTt8XIsLCan9bGeFgKq3U9gPi0+i1CMxmhdQuE1tjOgjdGvqTFYDkDRu7UrWdcYIvH41qoFbC8T+AJhJKP+6LFOWnHnMpgZ+xNMgZ4RyfIdFo+YsegNZRboyi7QVEUiROGxDLKXT2cJu6yEPb9XsAnNO7Z8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TF40LlAPmVgmXnW76cdaGEAKyyxsj9l14e/39gYNYtofvqA1nN8r0//ZPq4G?=
 =?us-ascii?Q?+GkPx+vBigpNolc1yyOk5aTwT0ZWaku2kjlFrVceQmwmarTmFjAifpCraZa8?=
 =?us-ascii?Q?gdklDfN3MgR+ZDM2jx3MSLAbORSHZFxct6ces31Brtf4QhIIS9zB8AOEsMZD?=
 =?us-ascii?Q?gf8VWEYiUsuKH5gULRRyqob3pNAoAc8qbSsDvvm8cL9whJV6HNGBuVako1du?=
 =?us-ascii?Q?kmYX7lJvJlZOazwmAY5mGydU/kjznsJNqSpjGdW5Hagt/RIuTBILMkgDovUk?=
 =?us-ascii?Q?tWthItDv4Vh+8wBUMwNjlsI/GbVYkSjyZ5fY8utqm/EH3YGWmR236zUY+Glh?=
 =?us-ascii?Q?3Fp+TqKZx6HC3wyC29z2Yz66INT3+jR+iMtkCWj88FVOpOGwEF50zRHPp+ap?=
 =?us-ascii?Q?RrPiZj9dOrQo+cEWURZxcENpyrGFcarvvw3RcERXQOy+xNPk6wZ5JBxANGgd?=
 =?us-ascii?Q?nfBLZxx7dMaczZZRd/2p6N5u52ZaWeL4lsfWbUA29cxKcghzYiearmV76vWH?=
 =?us-ascii?Q?OsOvWbHJ9rbmTKHr1NeKW9oZCpQPVv6QFwQBbviby/XjBqWK/nt00sS/qas0?=
 =?us-ascii?Q?ye+AwQObpC+rVkwavj11OogkMm/XbqhphkwLvHudTWz/s2gd/nnVjkkyRoqm?=
 =?us-ascii?Q?eJckoFgqCOJHsrMPAszQLEWUhlL3jWdLQqOI8pRJytYJxuYbKXxHuXN6UbDj?=
 =?us-ascii?Q?1hZGfvhORebtCNUezjGijc4UfePxZOedqgkwVQNBRR+44z9mvyoJgieRy0Pp?=
 =?us-ascii?Q?9/RajsELowpGouZ092bcnMSgz4xnfcgqC0N4byebyT2wnlQvz7C5F0/bCPi2?=
 =?us-ascii?Q?Ol5plr8uTP2sA+mXhRItlDR3xtZBAPG2R0xvSQ3OT0Rgmkj1aNIruF4Vr8oB?=
 =?us-ascii?Q?2Q9Nxe0nHPrYm0DQemrwgNQspsXJU2x/Nr4cLwQZ7OsfNMbdlNYPXVq1K/3s?=
 =?us-ascii?Q?uzecXr3zi5AiaU4iglReGQQS46Do82LpRHYxWoPRQDEmj53reZPHfzUn2jC3?=
 =?us-ascii?Q?aiQ5m3Yju/6n0Rlxo1ZqLFxHsVEyNb6tqaUBOKZPEejlMeUFu1wDc0fRiem7?=
 =?us-ascii?Q?m9QEBioUY3W9O9QpOSXfd+jKBmwpKU+PXR9TPm5c/ma6C4vR5TFIlxx1WcxR?=
 =?us-ascii?Q?rOukIlzZGs2gViXNyBRxhipwAIoTO6/buIeHwpjBRk9A+hMKylf+52rRFKpz?=
 =?us-ascii?Q?7I1lsDLh4ZOpuCta8UlbnBhcb+0usM5DD0GhrwMhm5Y3FhbmC1KRny6SS6mi?=
 =?us-ascii?Q?+L1RHLhHk23PI//txJkd+JDz8FrnXSmwXZMF3BD2yuwEcEJkCEvmcUcfazLf?=
 =?us-ascii?Q?O4Pc/lC0S2iNoMl7tHfb0ys3IuEM0fwNW3PejZlLSDJa42FVmyUCQbHkDcYr?=
 =?us-ascii?Q?3PpXwzO35ZlxH0Uuj5pMUly66E2YbpjkVKNyHpYEFj8uHZVimjUmYVBs06kk?=
 =?us-ascii?Q?6PkQPURBzfCDi62SDkT8gFiAPx9BID8kzLveevhV/hRVEzrnvaflq97D3Mk3?=
 =?us-ascii?Q?dbymYjfVPIb+sOLOV2uJs01Row9HQpefvh7u3BnBxdyoZ8slWuvVDhmbz9J8?=
 =?us-ascii?Q?Q03ier7lEP6/UdqeKarbCpY55Ieju+S1eQjaEJLvNSJwuyLkZxSgXnpsImdF?=
 =?us-ascii?Q?8P32lLn7KjowhWyE1GDktywLEgaU480uK1z9DfdD8kgpE7JbBlO/dsp8f3TP?=
 =?us-ascii?Q?q4zEZpJge4G692veG389xCqXKqrkq37hAFbBCXrgmH1MMDmh1NpwIC8YagHC?=
 =?us-ascii?Q?gzmngV+B8+zxpcXQAzL5Xu2GcVhMtes=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6506a6b4-3fef-44d7-b483-08de9be649bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 18:30:51.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF8YqxTdB8hq3yUivuMer8Csl6/YumcNiNDsFTz0UlnALr4RtBOibGrMi3eREyUYbq9wFDx2SZDN9/fPTbp7we1ycDsRA3YGC5aLzXCubH+CfFAxtF1UPeRWXSmTNNmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7228
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nokia-bell-labs.com,reject];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,vger.kernel.org,kernel.org,resnulli.us,davemloft.net,google.com,redhat.com,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-279110-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email,cablelabs.com:email]
X-Rspamd-Queue-Id: B8395413BEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>=20
> Sent: Thursday, April 16, 2026 7:55 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: victor@mojatatu.com; hxzene@gmail.com; linux-hardening@vger.kernel.or=
g; kees@kernel.org; gustavoars@kernel.org; jhs@mojatatu.com; jiri@resnulli.=
us; davem@davemloft.net; edumazet@google.com; kuba@kernel.org; pabeni@redha=
t.com; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; horms@kernel.o=
rg; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_=
schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@e=
ricsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx=
.at; Jason_Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v2 net 1/1] net/sched: sch_dualpi2: fix limit/memlimi=
t enforcement when dequeueing L-queue
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Thu, 16 Apr 2026 19:09:06 +0200
> chia-yu.chang@nokia-bell-labs.com wrote:
>=20
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Fix dualpi2_change() to correctly enforce updated limit and memlimit=20
> > values after a configuration change of the dualpi2 qdisc.
> >
> > Before this patch, dualpi2_change() always attempted to dequeue=20
> > packets via the root qdisc (C-queue) when reducing backlog or memory=20
> > usage, and unconditionally assumed that a valid skb will be returned.=20
> > When traffic classification results in packets being queued in the=20
> > L-queue while the C-queue is empty, this leads to a NULL skb=20
> > dereference during limit or memlimit enforcement.
> >
> > This is fixed by first dequeuing from the C-queue path if it is non-emp=
ty.
> > Once the C-queue is empty, packets are dequeued directly from the L-que=
ue.
> > Return values from qdisc_dequeue_internal() are checked for both=20
> > queues. When dequeuing from the L-queue, the parent qdisc qlen and=20
> > backlog counters are updated explicitly to keep overall qdisc statistic=
s consistent.
> >
> > Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2=20
> > qdisc")
> > Reported-by: "Kito Xu (veritas501)" <hxzene@gmail.com>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
>=20
> I was a little concerned about the complexity of managing qlen here.
> But could not find anything obvious.

Hi Stephen,

This fix relies on some existing assmuptions of DualPI2.

>=20
> Turned to AI review and it found some things:
>=20
> Right fix direction and the reported crash is real. A few issues before t=
his is ready:
>=20
> 1. The `c_len` construction is fragile. Declared `int`, initialized from =
a `u32 - u32`. If the invariant `qdisc_qlen(sch) >=3D qdisc_qlen(q->l_queue=
)` is ever violated, you get a large positive value, the C-queue branch is =
taken on an empty C-queue, `qdisc_dequeue_internal()` returns NULL, and the=
 loop breaks out without draining the L-queue -- leaving the qdisc over lim=
it. Simpler and more robust to just compare the two qlens directly and drop=
 the delta variable entirely.
>=20

In current dequeue_packet() of DualPI2, we also calculate c_len via the sam=
e approach (line 524).

As we only have queue length of L-queue and both C- and L-queues, so this i=
s the way we derive the queue length of C-queue.

> 2. Missing else/termination. If both branches' conditions are false (neit=
her `c_len` nor `qdisc_qlen(q->l_queue)`) but the outer `while` still holds=
 because `memory_used > memory_limit`, the loop spins forever. An explicit =
`else break;` guards against an accounting desync becoming a hang.
>=20

This shall not happen, but adding an extra else guard indeed is definitely =
a good suggestion.

> 3. Whitespace: two lines in the L-queue branch use spaces instead of tabs=
 --
>=20
> +                        q->memory_used -=3D skb->truesize;
> +                        rtnl_qdisc_drop(skb, q->l_queue);
>=20
> checkpatch will flag this.

Sure, I will fix this, sorry for my miss.

>=20
> 4. Comment style. The three-line comment at the end of the L-queue branch=
 doesn't follow the net subsystem multi-line comment style (leading ' * ' o=
n continuation lines, closing ' */' on its own line).
> Once the code is cleaner, the comment could also just be dropped or short=
ened to one line.
>=20

Thanks, I will fix this as well.

> 5. The accounting in the L-queue branch is correct, but only if you trace=
 the enqueue invariants carefully: L-queue packets are counted in
> *both* `sch` and `q->l_queue` on enqueue (see dualpi2_enqueue_skb lines 4=
13-423), `qdisc_dequeue_internal(q->l_queue, true)` adjusts l_queue's side,=
 and the explicit `--sch->q.qlen` + `qdisc_qstats_backlog_dec(sch, skb)` ad=
justs sch's side. Separately, the C-queue branch now quietly relies on the =
post-CVE-2025-39677 semantics of `qdisc_dequeue_internal()` handling parent=
 backlog -- which is why the pre-patch `qdisc_qstats_backlog_dec(sch, skb)`=
 could be removed.
> Neither of these load-bearing invariants is documented in the code or the=
 commit message. Please add an inline comment in the L-queue branch explain=
ing the double-count-on-enqueue, and mention the
> qdisc_dequeue_internal() dependency in the commit log.

Yes, L-queue packets are counted in both parent qdisc (sch) and child qdisc=
 (q->l_queue) during enqueue.
And we re-use the qdisc_dequeue_internal() of sch_generic.h for C-queue cas=
e.

> 6. Commit message / subject. Subject reads as if only the L-queue path ch=
anged, but the whole drain loop was restructured. Something like
> "sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()" would d=
escribe it better. Also, on NULL return from qdisc_dequeue_internal() the l=
oop silently breaks -- if that ever triggers it means qdisc_qlen()
> > 0 but dequeue returned NULL, which is a real invariant violation.
> > Worth a WARN_ON_ONCE().
>=20
> Suggested shape:
>=20
>         while (qdisc_qlen(sch) > sch->limit ||
>                q->memory_used > q->memory_limit) {
>                 struct sk_buff *skb;
>=20
>                 if (qdisc_qlen(sch) > qdisc_qlen(q->l_queue)) {
>                         skb =3D qdisc_dequeue_internal(sch, true);
>                         if (!skb)
>                                 break;
>                         q->memory_used -=3D skb->truesize;
>                         rtnl_qdisc_drop(skb, sch);
>                 } else if (qdisc_qlen(q->l_queue)) {
>                         skb =3D qdisc_dequeue_internal(q->l_queue, true);
>                         if (!skb)
>                                 break;
>                         /* L-queue packets are counted in both sch and
>                          * l_queue on enqueue; qdisc_dequeue_internal()
>                          * handled l_queue, account sch here.
>                          */
>                         sch->q.qlen--;
>                         qdisc_qstats_backlog_dec(sch, skb);
>                         q->memory_used -=3D skb->truesize;
>                         rtnl_qdisc_drop(skb, q->l_queue);
>                         qdisc_qstats_drop(sch);
>                 } else {
>                         break;
>                 }
>         }
>=20
>=20
> As with any AI feedback, expect it to generate hints but also be wrong.

I am ok with this suggestion and I will take action in v3.

But I would say the origianl c_len calculation already existed in dualpi2 o=
f dequeue_packet().

And this is because we maintained parent and child qdisc statistics during =
normal enqueue and dequeue operations.

Thanks!
Chia-Yu

