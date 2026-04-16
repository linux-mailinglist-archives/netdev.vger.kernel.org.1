Return-Path: <netdev+bounces-279067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J6dGETq4GmmnQAAu9opvQ
	(envelope-from <netdev+bounces-279067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:55:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C6340F427
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A8873015D24
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6813BD222;
	Thu, 16 Apr 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="cAoknt65"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013034.outbound.protection.outlook.com [40.107.162.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140E73CA499;
	Thu, 16 Apr 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347712; cv=fail; b=mKuNDdOz/sb1yITFhL6vqpy0Q+x00dzmhhsijMl0yR0Q6tppvU6gCGh7t4CDu/i2qzNeIWxwqdLX48YpV0Mpwmn2jZ9IdlmaTJHNxf3wNtJE3GGTGO2gENzDZphBzeOtmpgrGZjRO48/kcM19V+Xg9zLxSI8WMEICPBGrZZPHK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347712; c=relaxed/simple;
	bh=PiekqUyhyrdJZnOXlVOebmh92MIbAGoTDFe8vS88h/U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=faGtugY5ciOOVGCcUR3R3nEqoqfB8H/eQiiq1L/HNnX54yPO9pKRlxRbSS9VY/P8JDigZIaroHOT5FMK9Y4GBUitOSy+rdzCzxJ68Ulzok3S9kKn3BkV8oACZ+NzHnP+KIBUyCm3/UDuii7tjwUrh9xaGWFypN6Oj+A0LQgzIrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=cAoknt65; arc=fail smtp.client-ip=40.107.162.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4hPfOmtb5SDJhCR5c8GA+huV6ZrybMFmyt4/38bFDxHKhhUVwGbWOHad3Hi+zsRxXxXlZg8hU7jxxjTiG/IOX+Ad/u99zQQ7mElpC/gI2BYlzs2FZDjmO/Y5EJiFCqKLgo/upsY86kGygF16iIQE0RxcQ6wNcfsYlPq3ZadNU3VVuDRO8bXd8DyqDbOhAeDA0xYJbMczF48a895EqIZ/QvYsiUL2Zb8p9kpM2vFB6w5ns38keRvC057hEU5L436ylFozctvjdGQFvufOFYnq8P2D1KyMnB3UHXcwnKjFfF9IQB6GzHOPaRrPv5J02uSAYX+3DJWll6foTVU7x6iCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiekqUyhyrdJZnOXlVOebmh92MIbAGoTDFe8vS88h/U=;
 b=bFAIMF8zUgUve/y+bqf9lRLvwwGA4M5XVrddztjrDsXUcKaZgeFew7m45O3ukav6FEOAIZdBnLpLpsubX1SN7tCYcWui1CZgwfb4UogIJdKS5K9KDp5boPNJO5ErCSKEhlG7iPHese0LpCvcFUP6bKZ+9f+eVnVewBderS+1AYN2EJPyPVHo9nZB9qG9loSNRslUHAZNNt3ZQHnlH5jFonuhtyxylhnrSHYo/z9SC0bqEAWafDtqaVGdKZm4Oj7Z7K+TvxLG50/5UEvLuPP5D1bGPUafD1Yl3HlN0xfYcKsVJzioNejD8feOWHmHlQrt3lEs0Q8tlv2BIhwJef4zlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiekqUyhyrdJZnOXlVOebmh92MIbAGoTDFe8vS88h/U=;
 b=cAoknt65APKdnR3c5lebMMgJPNchP5EDbWUAnZctrehmCS+zNYBOOKaSYliUHwxmuGfBIGN1F2l/FG5fi/dg2PaKr9IbLqCF/Djf7/zkcfOWZSQAZNUHYF2LaUyILQOXmXJ8ZiHjgAmPE8MzwegN0IIFDMr20dytGviYtbN0G616FlF4F961FFWhtx7uv7GgnXfGsaK0BheMqJXca9NWzeqvmVPeMsjkHZoWtt44iFkfMlvqgRmE8W9xAgfumf9IUckaSyTcNnRUppWwBwNN+Es8MS/M7jMagMMTI/Oyif+gDma7Wf3scc4jX6wC9Ma025uKZ7crL1v6IlCLGB9oWA==
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com (2603:10a6:102:243::17)
 by VI1PR07MB9405.eurprd07.prod.outlook.com (2603:10a6:800:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 13:55:06 +0000
Received: from PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::7d41:5f39:d084:f07]) by PAXPR07MB8676.eurprd07.prod.outlook.com
 ([fe80::7d41:5f39:d084:f07%6]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 13:55:06 +0000
From: Ferenc Fejes <ferenc.fejes@ericsson.com>
To: "justin.iurman@6wind.com" <justin.iurman@6wind.com>,
	"stefano.salsano@uniroma2.it" <stefano.salsano@uniroma2.it>,
	"andrea.mayer@uniroma2.it" <andrea.mayer@uniroma2.it>
CC: "davem@davemloft.net" <davem@davemloft.net>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "paolo.lungaroni@uniroma2.it"
	<paolo.lungaroni@uniroma2.it>, "ahabdels@cisco.com" <ahabdels@cisco.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and srl2
 device
Thread-Topic: [RFC PATCH net-next 0/3] seg6: SRv6 L2 VPN with End.DT2U and
 srl2 device
Thread-Index: AQHczaX9+D/wmJGc/kysTGlMpgWG3LW9s2EAgAD+RoCAIwROgA==
Date: Thu, 16 Apr 2026 13:55:06 +0000
Message-ID: <4b26a8a72aa75045f77bf01da98960b563ea6fd7.camel@ericsson.com>
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
	 <CAOY2Bqx-ZmBm-o-BoUYCxJjGQn31WF8V2u7gbnB52gOSYvG5Rg@mail.gmail.com>
	 <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
In-Reply-To: <6fef33af-b351-4bf6-a210-ae2283ec9f69@uniroma2.it>
Accept-Language: en-US, hu-HU
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB8676:EE_|VI1PR07MB9405:EE_
x-ms-office365-filtering-correlation-id: 8dc6a942-e6f5-4a1b-e9ea-08de9bbfc41a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 mOfRXUSXlL+T1336qirQt7xzBC7DMAR1K049q9XyVn/1G1o9wNrGrbGobVdoPa0GPwcti6gPaddCwVRrclBmOMuDE/y/FExTcjB+GrTnkF+YtSJu35CsIsY+nHQlFKsnetRdOiUElX7nUHs1XsTZFUNjAUZVvo4c7EuNsHh+kYZGtWFLGtWlXeLmxEhhrKR3Nwt2wq1ogN6qKjgAO2CcQsngEd/PSYou8IQlh9Oc5cDhWvRMFCt7y680eRsKEI/3CYJs3gPtepiZ9X3b1I3mXBVMzyLa9X+1tLiQUWQc/Q/HagZ+uDu8t/Gysdo6AqJ26iRHgHafn2+djpZIT587lHriHVK3R72tET41IEStXxSf/ubs3jiq9nnFDAUbbfCfPDiT4lH+iRVsLHfOQw8v7RyjraBEJJnfv2KglMUCK2gM0rp6Z/hJivJyWCIXs0L+0yu2bJ7JZEnJi8/WSGbZLy3h8ZQkVeVmJ8wGl/weKzNrPT4SLqkoxuUtfQchW7ELJiyT3aU27E0jxFoeITjVh1fbn9YHxQ/qWLbu4UxwyqdzQcQEcD23N6qVuss9jS0Xide94Z0d23AyWVLD5ssF+ck0bJrGM1sq4xSn/uWnBWZBMp7J5NKgyp3NAxM/ABLLA9OyqHrPLfI4orFrbNJRYKC/zAyp86N24XW6sZUh/fBlxaOzfhuMlkJLmjW9rtsG8/bvStgg/ofbeYM9o4gPpqzjBE8jnR0TXXKPo5/FSyMZCFGLQgc4nOb0WMX+I4AKe82qNxPooFEgBetTBWnYe/Xsrkh/cAS2h3d2ffv2I9o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8676.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGpqYUlGeHpCeEhHSWs2QWJOaVdscW9ISndXdjBOcXFHUUNWNGJBWm1xaXMy?=
 =?utf-8?B?K0hoNXRiYXRJL0ZWVDkzTXZCbjRiM3JMUndGOEpLZUw0SVRGS2VJMVlZNm0z?=
 =?utf-8?B?aU12S2NxRVRIc0J1Z3kvQ3FRUFRkU3lpVVRnZVZSdHMyR2g2V0k0Wm41VXNP?=
 =?utf-8?B?NXRURnVyaXBIbTNkZ2Nac0tUb2t6RUpqSUhMMHU1SjFXeXpDUzFGVit3dmdK?=
 =?utf-8?B?V1FLemRwRG96UnpYbHl1ZUxwZzl4R2JDY3NDMWxDVEJ5TGVUU3BVOVhnS1JZ?=
 =?utf-8?B?c09rV1FzR1h4cno0Vy9RYTdBZGUyV0psL2JPSlR1NUJBRUhTbGJ0Y1l1TUJJ?=
 =?utf-8?B?YkhVcXJZR1dYUlQwV3hUcjRHTEFKdzNGZ3lIZU1xTUl1cjh0aVJOd0sxRGda?=
 =?utf-8?B?Qk9TaEdiUW95N3d4dlRWdVJyWTF3alpLQjVuOFVCVE1ETVQ3OEl1ck92dTlE?=
 =?utf-8?B?MmhwdUdSVEozcE9iSmlRM1FtdUgyaUU3MXlUZG50SUZFZVdrSy9mekRwaFcv?=
 =?utf-8?B?TnNlYnVTZzJDNy85T25VbTlMdHdnV2x0aDN4Ymd0UTBYeHlhTmV3WFYyUHpt?=
 =?utf-8?B?cU5DVjVod1FiVU0vaFlDYVhnbVNjMkx1T1lXeUcwTnBPcVFveTg0SG1oanR0?=
 =?utf-8?B?VXczclI5Vmk0aTlPdXFyUlFlWFRSWDdVdjZ6c25Jc1UxbXZzWTZscys4UFRy?=
 =?utf-8?B?QWFhS3ZFNXF6ejlKNU05TXJSdzl5NGNIZkZkeVlBRVRSS0NvazF6RVJyVjhi?=
 =?utf-8?B?Y0R5MXgzaldwbVIzMk1xQk13eXBnN2VpakpFRm5BOGh4WjgwcUVmN3dTZm1q?=
 =?utf-8?B?NVA2WUlNNnhDMnJoSU5WOXRkVWVsYnFabEFvNkZHcTFkK0FDQk16Sis5ZG1I?=
 =?utf-8?B?N0NHUlFNRm5mZUN3YlF0NXdva2FUeTFMNjhLUE9iMmVJSGZVb2pPdSs0MVhv?=
 =?utf-8?B?U1RQanE0TnZtSjdyNFJ1OHRiaGRIMGo4QnVwd0Z1QS92WDlZZUlqdElNQ3NI?=
 =?utf-8?B?bDFrcWJlZTNSbVlaK2xmZkNQdytJYWlTMk9LZ25wRENVQXFrYW5WbW9GODFV?=
 =?utf-8?B?dkF3Y2hpUDJNOVB4TDE2WVVOcTlUWHFWSjFBRzlzZW0zMHppdFl5ek5odmRW?=
 =?utf-8?B?QmUwRkFoUzBBc3JDeEEySjFibDhWVytRNmdpbWZiNkw2RXBFdzl6ZlBQcHJ6?=
 =?utf-8?B?NnJqWS91ZCsxMVJteURmb1d3ZTlMZXFjRlJaUEZ5RmN3TCtHMkVBSUZvR1o4?=
 =?utf-8?B?aDd1ODhEOXhYTGNWSENhREtLeGIySzRmeVJmemhDcTJ3Nys0cTk4MWVLUWZT?=
 =?utf-8?B?Yy9NQ1d6aHdJZnJuUHhCVnh5akZHcU9TVENzU01VblFzdlNXTFY2TGprSGFi?=
 =?utf-8?B?ckJLQnU0ZWRidUpYck9ZK3g2WGxFcWVGejlQWWlGY3hEcXNIcmNtZDVXSmpH?=
 =?utf-8?B?OEdqUFdjZVdFVWhPL2NlbnI0ajVrT1lWOC9HaThsYzJrRmFhRU80WFlyYmhq?=
 =?utf-8?B?bjBQeVlQWCtrSmovVEZwN3YzTG1ENWFtOVhRTG1zYjBjcktsY1ExS2ppUndk?=
 =?utf-8?B?NW1kTkZkTUVqYi8yWG0xODhxQzE2OURaeEdwcWNRajkzM2FtYnhINWxVNWRG?=
 =?utf-8?B?ZXlFWlpWVStwN1pRVHhpV3U1VFVqOVVlcFJXeTlRKzlOMXpFVXlFeU42ejh0?=
 =?utf-8?B?MHN3Z3haem8vcXArTSs2N0poUFFqT0kwRVdxSXlUTzZmNGswMDYxNFpQTVhN?=
 =?utf-8?B?RWxDL2lyUExTdFk5ZWIrWEl4Z3hpWkdKYllWOTEvcGVMU3RtWGY3VFZldlRV?=
 =?utf-8?B?eG9lVk42WWJIYndQMU5ScXhGYzdlSElzU0ZZT2liNmQ5R0N3ZTlRRUE5Qldp?=
 =?utf-8?B?cjR2eWtsVEhtZXB5MkV2VmJKaHgzOU5UZWEzSXozU2VvUGhWN2VSaGJNUmdW?=
 =?utf-8?B?RkxzWGNneDc3L3pibm81WjBWUFUxOFlCV0NEQmh6R0RoUHN6bGN4ZXRiMnlC?=
 =?utf-8?B?cGRxUWpTemtROTIraWxDYWdBTEEyRHZ0TlZ1SXRuajRDSEU1bmV4YUhKRkJI?=
 =?utf-8?B?TlZCVVMxQXN2TDBGdjlSSnovRlJoM1RDWkhFOTlNTllaTUZ4cFZ3ZHZsR1ZT?=
 =?utf-8?B?VENWdFc2TGV3WG9Gb1h0WnZpdHM1SDhmTmNPNlEzcVNnTUJ6UW5MYWFLbVQ0?=
 =?utf-8?B?UnE5RTVtY3o5WWZHeWdYUDVZQnF2cVNQeWEwZCs3OXhVMlNuTURwZFRMZlBC?=
 =?utf-8?B?QTlGbzFWVElBZWVFTXJHWG5jNEUwYkRpd1lTUGJhZWtIZy9hRnFaQTA3VkNX?=
 =?utf-8?B?eSt1WjRTb0IwaWJlS1ZFekQ0d1NGRENhRDRLQjFkd2cvZFBLTHhIcGdkQ3Nh?=
 =?utf-8?Q?qR5I85ELcrkRl9kA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <698CB698DEC5024BB8C6F49611F00AF8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8676.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc6a942-e6f5-4a1b-e9ea-08de9bbfc41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 13:55:06.4166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkUuLZyXN5vZRx32BBu760/1zs9iU96snltfttF98aOFIKpxkcJjWckULrzOiMt9OtM+kt94j4GQ22yAC+wbyLJ5ON/VWimHiDTcC/JtwiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9405
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ericsson.com,reject];
	R_DKIM_ALLOW(-0.20)[ericsson.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279067-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ferenc.fejes@ericsson.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ericsson.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ericsson.com:dkim,ericsson.com:mid]
X-Rspamd-Queue-Id: 07C6340F427
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkNCg0KLi4uDQoNCj4gDQo+ID4gSSB3b3VsZCBwZXJzb25hbGx5IGxvdmUgdG8gaGF2ZQ0KPiA+
ICJsMnNydjYiLCBhbHRob3VnaCBJIHN1c3BlY3Qgd2UgbWF5IGVuZCB1cCB3aXRoICJsMnNlZzYi
IHRvIHJlbWFpbg0KPiA+IGNvbnNpc3RlbnQuDQo+IA0KPiBJJ2QgbGlrZSB0byBrZWVwIGl0IGFz
IHNob3J0IGFzIHBvc3NpYmxlLCBvdXIgaW5pdGlhbCBpZGVhIHdhcw0KPiBzZWc2bDIsIA0KPiB2
ZXJ5IGNsb3NlIHRvIHlvdXIgbGFzdCBzdWdnZXN0aW9uLCB0aGVuIHdlIG9wdGVkIGZvciBzcmwy
IGxvc2luZyB0aGUNCj4gIjYiIGNvbmNlcHQNCj4gDQo+IG5vdyBpdCBjb21lcyB0byBteSBtaW5k
IHRoYXQgbDIgaXMgc29tZWhvdyByZWR1ZGFudCBpbiBhbiBpbnRlcmZhY2UNCj4gdHlwZSANCj4g
bmFtZSwgYXMgYW4gaW50ZXJmYWNlIGlzIGFuIGwyIGNvbmNlcHQgcGVyIHNlLCBzbyBteSBwcmVm
ZXJyZWQgb3B0aW9uDQo+IGJlY29tZXM6DQo+IA0KPiBzcjYNCg0KRm9yIHRoaXMgdHlwZSBJIGFn
cmVlIHRoYXQgc3JsMiBhbmQgc3I2IGJvdGggbWFrZXMgc2Vuc2UuIEZvciB0aGUgbG9uZw0KcnVu
LCBtYXliZSBzb21lb25lIGVsc2Ugd2FudCB0byBpbXBsZW1lbnQgW1NSLV1NUExTIHBzZXVkb3dp
cmUgZm9yIEwyDQppbiBsaW51eCAoQUZBSUsgb25seSBMMyBMU1IgbW9kZSBzdXBwb3J0ZWQgcmln
aHQgbm93KS4gRm9yIHN1Y2gNCmludGVyZmFjZSB0eXBlLCBzcmwyIG5hbWUgd291bGQgbWFrZSBt
b3JlIHNlbnNlLg0KDQpPciB1c2UgInB3bDIiIG9yICJzcnB3IiB3aGljaCB3b3VsZCBjb3ZlciBi
b3RoIFNSLU1QTFMgYW5kIFNSdjYgY2FzZT8NCg0KSWYgY2FzZSBTUi1NUExTIFBXIGFuZCBTUnY2
IEwyIG11c3QgYmUgZGlmZmVyZW50IGlmYWNlIHR5cGVzLCBJIHdvdWxkDQp1c2Ugc2VnNiBvciBz
cjYgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSBuYW1pbmcgd2UgaGF2ZSBpbiBpcHJvdXRlMg0K
cmlnaHQgbm93LiBMaW51eC9pcHJvdXRlMiB1c2Ugc2VnNiBhbmQgc2VnNmxvY2FsIGluc3RlYWQg
b2YgdGhlIElFVEYNCm5hbWVzIGxpa2UgU1J2NiBILkVuZCBhbmQgU1J2NiBFbmQsIHNvIEkgdGhp
bmsgaXRzIG1vcmUgY29uc2lzdGVudCBpZg0Kd2Ugc3RpY2sgdG8gaXQuIA0KDQo+IA0KPiAoc2hv
cnQgYW5kIG1lbW9yYWJsZS4uLikNCj4gDQo+IGFzIGFuIGFsdGVybmF0aXZlIHNlZzYgY2FuIHdv
cmsgYnV0IEkgc3Ryb25nbHkgcHJlZmVyIHNyNg0KPiANCj4gY2lhbw0KPiBTdGVmYW5vDQo+IA0K
PiANCj4gPiANCj4gPiBDaGVlcnMsDQo+ID4gSnVzdGluDQo+IA0KDQpCZXN0LA0KRmVyZW5jDQo=

