Return-Path: <netdev+bounces-169562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE11AA449AF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A540619C4FC3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2018C035;
	Tue, 25 Feb 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="srLFKGac"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012045.outbound.protection.outlook.com [52.101.71.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB48C19E7E2
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506884; cv=fail; b=mmeu2zTPsg4BC9HPWG6dZB1WSoQIgwkHOs1iYQMxo4q320/ODu+JVjwaWInF3awlu0f6g7rJRFLYyj9Lpl1clZzs+bL+RMei5Qpg/myJWXWDh4l3Cjobw+avev9c0F4vr7K1+cFPukkQG0ORe/4nnlszNMsP9tA+ypTfSPamWok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506884; c=relaxed/simple;
	bh=s34BEPPj+RuTpBT5liNmEr6aO1z++djKMabBQwilWls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cu4qLlvZq0DdTYJGu7TCe+BHKfr7iIKLnwwyGYxIwduewP0TUBZU9DqthS++BXeg7uW5iDn0einqQdZyapsQURdDosocHL0xebDhX2stuAzbigiReSl+lmNJGx6BLpVdu39ZTcgmtcvsQdw/n1Tr5Kcjie9eX6jV3aHh4s2qqH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=srLFKGac; arc=fail smtp.client-ip=52.101.71.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxRnxjvmx0FGQy+XGPFS+nd8CqAr+g9flZAdfs4d0o6fW4M+Uo7mKQFRyRFQxTzJn/wOHtPR5aLSu/mE6pXANLppphIveOC9egSlz/K/QgI3Uu1RmawHbkJ4wxeWZeTkpyciivb9MDxKCJCe9k/BTajVxHxvc2pSLrrCV72QnCFKWETkxgLxS6IwTFzjrRTbVhSIgvu5VXdyxixQai02y7dGCGfi0qiSgSMoEBddDmqFz23QN34LnDb1E8PR8WUMi0u/Tx213aBANxX+Q4yW23YEDp4+yVnK3HXkMNI/YF91ywKWuY/af34DbUGE8Q5M1dhUnOrK8GjMwJEtElekXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AAaEeRBgS9E0UUQd8ZQH2h+gzUvNlKe/4znaOsHzAY=;
 b=p5mwsjw0YsWFIyhmLXGEygQKOTWTfDYlRFv5eOOJeCvkm8Ol5n5RcE3PV9PS8Babo9XMLkJsvmeFzq0sI4hB+77DYE+ecxekJn5B+4kaJ6hHGoUcpO2H5E4dFRZ5KfsdFFQg7xlwHva/heN4wk6UjaGWFyhFvPol61w6zU1XSKAvfnz8ZyLzVvSQ8JPt7HUcLiJHAwb+p8fMUJ+/QeuQeEVwIqJUKG1kTG/iZcOxiReqg8JpnVi/kLGKQXdSJlIpwBsX396pihhaVSKPcsGgZNrZgLBvtRKF6A4d3jHiUU83Cxe7MaPFtc9obRam6Bt8ug3Ufp1zaw/wxmAbv62rZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AAaEeRBgS9E0UUQd8ZQH2h+gzUvNlKe/4znaOsHzAY=;
 b=srLFKGacw20rZC7RWFvYJ/tvB7J/ma8WcmYssDCU1EUwpxZKmsrFXIcm2NesEoA48atr23B9a3vvnfTFngPe1ybnbX1xPlxc7eQaf83YKCecU/ohWHX4c0p038qMt3WsKk+mYiGgxIiP9odDD4V3WY1Q0YfPEF365h0szb2fCLZIp6iS4n8MqNFqJEPKpKviwQSzNBvkSHwyUZ5SL5aek3btFuIUDXu4wVkWcFHfXJ77pvW2CS2pSZXQ01vX7AXLE+hK5grGFRaMkO8AMTjR5xrgigqgyMuN/bWelXAjEZzyYVZYGMcxCwLftF6hQj7u9YZi6L/k1PYmby6JULsHyA==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by DBAPR07MB6823.eurprd07.prod.outlook.com (2603:10a6:10:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 18:07:59 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%6]) with mapi id 15.20.8445.008; Tue, 25 Feb 2025
 18:07:59 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "ij@kernel.org"
	<ij@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, "Koen De
 Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, g.white
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, Bob Briscoe
	<research@bobbriscoe.net>, Pedro Tammela <pctammela@mojatatu.com>
Subject: RE: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Topic: [PATCH v5 net-next 1/1] sched: Add dualpi2 qdisc
Thread-Index: AQHbhRGpRqdS8ilJAk66wE/wVU7KP7NW68UAgAFp2NA=
Date: Tue, 25 Feb 2025 18:07:59 +0000
Message-ID:
 <AS8PR07MB79731B42937B337EAB751913A3C32@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20250222100725.27838-1-chia-yu.chang@nokia-bell-labs.com>
	<20250222100725.27838-2-chia-yu.chang@nokia-bell-labs.com>
 <20250224123034.675e0446@kernel.org>
In-Reply-To: <20250224123034.675e0446@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|DBAPR07MB6823:EE_
x-ms-office365-filtering-correlation-id: 5909ea83-095d-4e78-43da-08dd55c75691
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KAIA/gJ0qMetSoLrYV6z92UOTiId7L+LmXhHbLX5432+WAefZ3oe63GUA1qd?=
 =?us-ascii?Q?y7ohUd9DTJnutN6mLWZFGAy1SSrNy4Oy2FQhbk+cFjst81GgPF3JSIzXlVaX?=
 =?us-ascii?Q?vZHmws5HIrs4A3gUSxm2adMFDhiPUeQxcCN6SFRspM6aIj9huYOQOXMbPJMu?=
 =?us-ascii?Q?M6uqQZmhMkxzqjfva/RavMEhZesZnDGwLNr/5dBIOaFt8zOOdZHvC5u6Lggm?=
 =?us-ascii?Q?VRpjwONi4TS0TRkqx2+4BdvSPkTTx4LVT3wkEy7VUjYSw1/Y0Wfer2payrKq?=
 =?us-ascii?Q?8+rtMWukOwb5Uo/3g5x1UGxt3/wOEeUHrNQf1IehXj8jaAYgbkdqCtjwVfsc?=
 =?us-ascii?Q?Bjom9RA/sDyJ8FLIPSb3tBblO1sYMZp7WvlzoBB5VCmzPrssz9Lkr6CPu8RV?=
 =?us-ascii?Q?S9hLltF8rQ0CfNdoT45LDx92/qGpkoUrl6uu2RThmKVbU2FEFcR7m45nvcE7?=
 =?us-ascii?Q?g7SyCOAh+u8MJ+Bh9VsgPThUSh/hD0rUBgfOsWZttejOY9ABQbGYyR8lSFOA?=
 =?us-ascii?Q?r7GJA8IzteKWWFEVCbS3HnMyFVtdCXZ4ptxxLQKxpkDpAgtlzpEo3E9pA22G?=
 =?us-ascii?Q?n5Xezb+p1uMiyCPV52CE46AfJZGvHBASLUjFM04fSJa+PMobA4bEHppOOLTw?=
 =?us-ascii?Q?JNkFlwhM09Uv12Y1dUeo88Zb7KRkBZ+S2cNG9M/7+HVBbq8UIRter8m/r8YW?=
 =?us-ascii?Q?ziSyuWayzIuG9nxAVS6/vw2Dl5ekPVWlKxv/BPSRnVf6LOR2PUw684nCn97d?=
 =?us-ascii?Q?BCroitidN7zhqulhCLjOLshaOvBUImW5M97gmDC/HYerZr+gG0G3gtuKc/9M?=
 =?us-ascii?Q?mUuRqHEzmwYUiH7fEunsQCuoo6PbX1rDg7vdD+O2zx3vNa5/WFKvWNvudio7?=
 =?us-ascii?Q?z8Jc9ikexjQFOYbZi4peUPGEbzxeE7l2dJGh+eEMXs4yEKpNGQHGz0VJC96L?=
 =?us-ascii?Q?jQsq3pqEM5er+Rwp7bvylY72Tw0hYHqakAYL/CS5o4YmmdxKZsCgvlkvXeV1?=
 =?us-ascii?Q?2UB5PjL9Bzn5HUkVqcBP+BsxYghkraLkBIQDaPhCXRXnVGqg7PsScwQ1LCPZ?=
 =?us-ascii?Q?VGJsLEmyApdTR8sj6Sn+FiVITo5WvySSYX3dieCw3gwXz6zjJSRyhJPF91PP?=
 =?us-ascii?Q?Q3JYo1SUshLoCAbe6w5Yzcm3GzD9RA++SDCvpcf+CS+lxD5sS2QCfiB8pU63?=
 =?us-ascii?Q?VS5U09JAGbvtm0hRb18CQXaagT1GlEx2cXLmODREssRq4GWhTC5rgxUzu+rR?=
 =?us-ascii?Q?5vdPY8/+iw3Tyh1Vn5Y3KxbmycBjTu56jK+Uz7wgZC/JYFKFWoz5kfMV24Hx?=
 =?us-ascii?Q?QEc6uGahr4tg+l8y2/5kjPlab5jnX4OGgQD1H4cOVMq6PnJ5SMaedo1pXu3U?=
 =?us-ascii?Q?uamnWXLBIXfiJgMRVedCbyqm1GDPDA9IBL8H3wRxxeOQRc9O7nosOmVOxWfc?=
 =?us-ascii?Q?T6QuVH+VsVklKHzH57ZUOwcLrQWv7nCB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F0/uTwrZt/TfyEhUrTYzEVbYWoeE1NZVJ+BX7gfLBWSrMuU5A7UN9geJLG1I?=
 =?us-ascii?Q?Zt0PxUPS52fKk6C87DHyTQ5X39mMa2othj3fNMm/WKUNJ3owx1VKvrrhLjN4?=
 =?us-ascii?Q?CgEjDJoS+ynzid91GQao/Ielw+RPzXKkLQFvpH86kdzcZWaYaTicv8DhYW7K?=
 =?us-ascii?Q?bhgCMP2/k0LXnp43eH4P1huanYooaRp4/6bzmG8icVJvmyl60u+7izHtpRCV?=
 =?us-ascii?Q?7pern8pIOeQVhcXxewq2iy/5tbiN+WjeqtRJrB2g2AhuosIEGaX/2uTzS/FU?=
 =?us-ascii?Q?y/hofwENtEbbIVTpA2EIWBsku6EgKQS7IJTtdz77u2ut57jgvXTOCoOC2Zj+?=
 =?us-ascii?Q?NVH2Qa6+Jd52KvKLaGg/HlgYfdIN6af6oUxfsJY+VkrUp1P/GuYghtRZnJMN?=
 =?us-ascii?Q?WsucqvhPpPgaHYmehmj3mgvXlHSCgS1BzIvkls5yUgw114awBeGcxuJ4slpX?=
 =?us-ascii?Q?9rSpM334HKneeXOE3GU8k+ZztF590KfRMwCEZrDLh3zGVc41YgmnGTrD09GT?=
 =?us-ascii?Q?Ir5FhlVRhk2A4Dgqfk92RH4OIbZeKQUrAqy28lc/oxbGAJ6Nx3wT/nqWw+NW?=
 =?us-ascii?Q?f5IUXpv4jp4KIb9beeJVS/H+15Ag9PVSmAJZdXfyvDqmMQulnG4O6a6emcFI?=
 =?us-ascii?Q?nY9pPHhU2jgnaGz5Y+xdjhHLNEW/f5BTpfs/HSlBw5dvwClJzhK1nQj6KJJh?=
 =?us-ascii?Q?WvlFGIx8iAG1UYAZmE+LCkVyHw8oJMO7Q1hbf2SG1euWWcT6rPBGKxlZT1h9?=
 =?us-ascii?Q?KfhvEh2bG+YXPXsiyGlV8kgkW8L9bJYwtoPorS2zL7aep0opwuW6FuD74RyX?=
 =?us-ascii?Q?StywR/DXUJS6rTuK8rZJJsovBKYKqBuv0IH6ofDv/qbLodbXDaL5NRTyK0b7?=
 =?us-ascii?Q?rX7Kkd5om+oNjcxYoeb27a04jYk4dXaqd0lqbIu9DHmn3dEjs9aJM4KYDxt1?=
 =?us-ascii?Q?MkHwdoG1kAu/7pLP8WwZFKFVzrm+W276gOfGFVwG6QjtjTrQjTmp5tuyxMl5?=
 =?us-ascii?Q?4gAxo88j7VH4tCVJfouU0O1FzTuPLeMwxSTBS2lEdpZyroyWUSkn4qDFq97T?=
 =?us-ascii?Q?hHBXILozRAHrGtkHhaX7txwP5Y9JII2UD4Kikfi448DbaKHcIYVjWFXL/9s3?=
 =?us-ascii?Q?XyDLCgHjRIyovKMgduTyss/vUb4RLdfGKz06HRzvAN462Xfz73mvA8EU07XE?=
 =?us-ascii?Q?2Xi/QmXE0a89s6kdlmVUwutSKgIKquy1yHWjjZ02Uy+BE+EOaraIPt/Ke/sv?=
 =?us-ascii?Q?48bW71TU1Py0p0spPMKskuGflt0ZH9j9TFlzO1t3idWnXJ5Gb+KJF/pkr56b?=
 =?us-ascii?Q?Z/lPg+4LBOzuLuRQF267ekVIWLDQqwa9VwDF9G7VkOCrzWN53jqSSW3WVmsS?=
 =?us-ascii?Q?/DsQf+uUntQI9rd1lLEhvc9Btfd2UYUXkOdhd31BVGUPk3m0Sp4xgAHM+BZG?=
 =?us-ascii?Q?I4Vd6/mj7pvsVIGTkqONmE6uIgvDW20t2SZX6mhEV5S33olht1dO640ASNIQ?=
 =?us-ascii?Q?O1CljlgBC6sWR3my4PpsZfmti9MjktboRcJguDIKNu9XpkEY/b8nqrEo2m6P?=
 =?us-ascii?Q?YwIEDIzQIwEkinHGJm1TVVZRS1WLYcuZ1ln/MQYXZckxTkQXwTbtXUZ02onR?=
 =?us-ascii?Q?nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5909ea83-095d-4e78-43da-08dd55c75691
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 18:07:59.5503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2tzVEEvLcKW6oWqCD9d4i/FcglQGkEYFAAi0smx/u4tWxtQm5tiB55Bp1rUOZf65zC0L9/HAhGiZUnlkDvNUzhqNkxmtCcRrKF9rrYaKOgf9rOdcN2G2Y+EGbrLC+r9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6823

> On Sat, 22 Feb 2025 11:07:25 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > From: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> >
> > DualPI2 provides L4S-type low latency & loss to traffic that uses a=20
> > scalable congestion controller (e.g. TCP-Prague, DCTCP) without=20
> > degrading the performance of 'classic' traffic (e.g. Reno, Cubic=20
> > etc.). It is intended to be the reference implementation of the IETF's=
=20
> > DualQ Coupled AQM.
>=20
> Pedro reports that you're missing:
>=20
> diff --git a/tools/testing/selftests/tc-testing/tdc.sh
> b/tools/testing/selftests/tc-testing/tdc.sh
> index cddff1772..e64e8acb7 100755
> --- a/tools/testing/selftests/tc-testing/tdc.sh
> +++ b/tools/testing/selftests/tc-testing/tdc.sh
> @@ -63,4 +63,5 @@ try_modprobe sch_hfsc
>   try_modprobe sch_hhf
>   try_modprobe sch_htb
>   try_modprobe sch_teql
> +try_modprobe sch_dualpi2
>   ./tdc.py -J`nproc`
>=20
> --
> pw-bot: cr

Hi Kuba,

   Thanks for the feedback, and I will update this shell script and the sel=
f-test file in the next version.

BRs,
Chia-Yu

