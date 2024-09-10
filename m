Return-Path: <netdev+bounces-126797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4470A972893
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2161C23AE2
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 04:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1791386DF;
	Tue, 10 Sep 2024 04:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VOIJJq+6"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F11224D2
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 04:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943786; cv=fail; b=P1CY+wzrdw1z76jY/7VnQLeRhQC6dO4OTyt5BYxCPllc12h/rNJUZPiUlJdH26HgK2rl0EvKgndX0IXsAZTLirg2SKNS2wsB+qY1/QOC5UXucDhtZfidvRpp1hhwLYpZ2wOIc/zoUuWQW6aPwaKBYhkq7cbOLQAZBJg03y7c6Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943786; c=relaxed/simple;
	bh=/LhXV67VO/6AXM5wYn0ZIzRNMKJk7VZGNe4G02IJsoA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xy1rgoQVapfoRK3CXdaVqCc42Fh2RseCX2Q8GT/S+1YSQbJMdkHHnnS+CTIr3/yzeYkwdE7l+nCQKYjBThcj1+L2dP4NqfAsnTnRrchCbJABrHsuUWBonThfzRS6hipgJy6EgqQL+DRmS3CH6Zi1qVttep+og34vzTs0tDpGvSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VOIJJq+6; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODEBalWWtesfvssnxhCbmLCJDbVqPEyXKMQe8Eve2V0vAY++1q7nua+Qlbui7eKgxj9nactr5OlaAsDL9BiU6bnFnwIULBwyudwvcNdsC8bL2K0UFSXKm/EsK4Lv3tXr4a/dDVbhOshUrlNYeUQQ9K7VVtu7I1wsic8Bm0NuLOg4y95Y6kbai+NQhVy2guOw5gY1XfMa0LlJ1ZuMvCYmcyjur/lIHkoT1vE3qLrhoSnNdKoihojzTCJnB04xZ3jSU+R9xxYEtIrEuoLRFAlX1qODktDgkI3pb4EeTnJ9pN0EGeidPdpd0fJj5vZ2plVAAdW/mM1PSS0LUIBukYzckA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LhXV67VO/6AXM5wYn0ZIzRNMKJk7VZGNe4G02IJsoA=;
 b=NgMe4HdZjSeUsv0tCY+eoTA6BKBprqW6yUchyMnW2uqQnzC1GIl9C/qdufHmgKdRkugSXeVJcPsVUvshIe3Bi8CVU31fiVR5fGebF66u54qjEA+c0+OKM2mr6zxwtpT0ipzRtJV+0dc+foFGiKkeI5zfksNSrAYXJbpwMYJPOlki1BObZEO68ta0O5wSYtwUDHGhe6JOZwsuHijsLZHfrIN14ZZ87H4MJM1tL7AqbgJg1kqR6TbXG4RwUGvWuC2yZfWRQMSpfTkah+szfeYZlUwRqe1ogsAmW4rdeCnPgMOvIPQLwb4hv2dwymQC7EGBaidtHG7MLGwDxSVeiLrY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LhXV67VO/6AXM5wYn0ZIzRNMKJk7VZGNe4G02IJsoA=;
 b=VOIJJq+641QUtl5ghjjWAElWz71/+ADS49x6L4j4w2YU41gg3kP+vbDJHRTlVClj/DWx8CvTSXIosCl7wEZUd9E7Tar9aFJrw6koVQY6WU7ZcRNCqAvD98I8t+gFleF557IscDbGrhUlu07af3/0hE5iQPdet68YJVzOcGXot6TtO+F2HiezDV7zF/GKuElf0nkqlV4QQm+cj8g3QWhA0OZf8C2DO5beduAtj7spGi3kxUj6tAKQGlvQiFHxD4CfPJkg9C0CF9jFHO8ii3CcAF9OjJ07CpSCaCIoXeWqAt1M6xMW7QNT+Sntp3t2oaGEDkT3bhRzB31nKbZWrxNafQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB8727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 04:49:37 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 04:49:37 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"daniel.klauer@gin.de" <daniel.klauer@gin.de>, "davem@davemloft.net"
	<davem@davemloft.net>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"rafael.richter@gin.de" <rafael.richter@gin.de>
Subject: Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on
 shutdown
Thread-Topic: [PATCH net] net: dsa: fix panic when DSA master device unbinds
 on shutdown
Thread-Index: AQHa/qDhxv3gRVoD0kGEjqt23TbnvrJIyHgAgAa/+4CAAAIWgIAA8eEA
Date: Tue, 10 Sep 2024 04:49:37 +0000
Message-ID: <c5e0e67400816d68e6bf90b4a999bfa28c59043b.camel@siemens.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
	 <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
	 <7db5996ef488f8ca1b9fdc0d39b9e4dd1189b34b.camel@siemens.com>
	 <20240909120507.vuavas2oqr2237rp@skbuf>
	 <7413d3aa76b4a9a98000903bc057993ea473a7c2.camel@siemens.com>
In-Reply-To: <7413d3aa76b4a9a98000903bc057993ea473a7c2.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB8727:EE_
x-ms-office365-filtering-correlation-id: d1063741-766c-4bbf-5712-08dcd153f95a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUVsaEpXRjF4T2FkWlBTSzlwWW82MCtsRlEzT1ZPM1M1Wld0WGJWVUt6MFRL?=
 =?utf-8?B?VzEraGtianQ4ZW9uamVITE1WNnhqSGZjcG5tc1JTdk15bVNYeURRWVJVOGRF?=
 =?utf-8?B?ejI3M1R2bEU1UzczRGdQL2djSTV4ejBQTkFKT3BFWVdBYzMrYzQ1ZnVRMzk2?=
 =?utf-8?B?VlVVSHdZUlJxNWhTYjhtMUtrd1N2ZnlpZFYvTno5MnhiL04wWndEdVIrTU1Q?=
 =?utf-8?B?M0pXeU1EeGNKOGh3aGVoTWNPZzIvTjFxZTZseUxUbnRaRVJoYmZHamovVW41?=
 =?utf-8?B?a0N0WWtxYitnbnZsaHprZzlkdDJFcUROS0l3a0JDd0NGWmtqbmJDZUdzL1lu?=
 =?utf-8?B?Y0dWMWlhajN2QXI0bitCN0VGanc2TUtoUGJoTUtneDZkbHRkd0loRTdRWity?=
 =?utf-8?B?a2lyQ3pGL1NDeUt1WnhVbFo0bmsrQkY1UldiMTFnRS9OMnBiNUJlZ3RuSHli?=
 =?utf-8?B?N0QvaG5jZHpaeE5yd09MYnhZZmR5ZFM0cTB1STFIMVhBV2krYnVlODdENXlD?=
 =?utf-8?B?bkpTaFZkUHF6WDlFYWVldFgxMTJYLzZzL2ZPbFF2VkcrUS9nRTNxNmp4d05k?=
 =?utf-8?B?ejljVHlMaE15U1V4UFBSM0c0RDZkRG1KL3BnUnBUWXVOSHFBa2oxTVZNdll5?=
 =?utf-8?B?M01xTUVlY0pvWGU5YU0rdFZWWVA0aVFZZWhqamk0SkgyYTRxK3owZWV5ZVhT?=
 =?utf-8?B?YW1rUHBiRDJZMUdXTVpXSCtNS2ZkeU9qQWszVzZRRWlHUk5JeUxyaGhucHdY?=
 =?utf-8?B?WHZWVVFObFpKZmV5eXYrOWYzUWpJNTRBNjJpUldyUFQ2TGZDdXB1ZHIzOFBG?=
 =?utf-8?B?d3VpOC9LaGMxMG1qd1NYOVczdWtsb1o1N05qbGVOcGdMbzVsVGNTYnUydUl2?=
 =?utf-8?B?QXpodkI0RHUwRWcrTThyN2h6eXhWK0kvRkdycEUxVk41UWkwWWVVcEhXR1Aw?=
 =?utf-8?B?SDlkSGxKSzdqeC9GNkVGQ2crdUZ5R0xkaGtQY1dpbkZwTE0xUkxhQ2hnTG9k?=
 =?utf-8?B?QzNFOUhNa0dXekh5bktQZmE5WGV0RDNXOCtSY2RJZ0VmU21HSHdjOWlGSlNh?=
 =?utf-8?B?MHF5WERTYW1BdElTNTM3S2tpek0vY3VoVGlVSjBYQVZoQjlhZGlUR1ZPZ2Fr?=
 =?utf-8?B?TzNBR2NJMFd2cUp2UlVINHJIb2ZuSFlUVWI0VlVUNHB6ZlR3RFZQUUs4Sld4?=
 =?utf-8?B?R3Nma3FGUnhBQkVXbG5sL2YyK2RSNjMzOEQ5ZkQ0aUNqN1RGNm15dGRnUVM4?=
 =?utf-8?B?cDZEMi8vME5PeWNDNWI4MXN5ay9Kd1dxTkpSbjUwR3Z4RFBEa1hCNDk4QnVX?=
 =?utf-8?B?THFDMEM3bzZWWStGWHlUeVdxY2ZKdzNTTk5JelA4ZFRoL0J6TFZmamVPUGFj?=
 =?utf-8?B?U3RKVlN0ckFSbU5GRmdvWXFrSVFCYmRtaS9UK2lVbGdPaUJqNnRja1B4dFVH?=
 =?utf-8?B?QjI1QzFGbkpBRmdYUkZ5MFhMWkp1TXJXRWhyeTVRckpha2lxbTBhZGpidFQ4?=
 =?utf-8?B?amtHaER4cmd6SEtWbmJHNThNWk80RitZNFlRWkhIRWs0OEx2WDBpMGo3SFpS?=
 =?utf-8?B?c1gxWTcwWmE0ajRNLy9RRnlXRkJuNmhJM0V6bWVYL3RiKzgzeEVvRHd1VkVC?=
 =?utf-8?B?S01RMndJbEJ1TmRlTWlMSWhlWmFOcjJLSkdjTS9GN1ZuMy9YNmRCaXZBNkVP?=
 =?utf-8?B?VndkcGxOb0JQOXdHeUZ1b2ZQY0l6c0hPSGl6SUdTbERmU1g4K1FyYVBQQUQ5?=
 =?utf-8?B?Z2dCUmpYZTduMzJmVXdyYWQ3cGJsTVVHUWZPRHQ2UjdoVm9BbHFQL1RQZ0w3?=
 =?utf-8?Q?uMBOkDtHFWkrEi797Aa/5BytiXJE0B2DLi9f0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?em5jMlVib0VITHNpeXIrVGZvZ1dKQTlFL2Y2SWNubDdNaGZtcW4wdFRVSUY5?=
 =?utf-8?B?U1dZbStQdktwNkJNT2xaeVhaU2tLbVZYQzBnZ3NQZ2F3NW5ORTJrbDU1RjRp?=
 =?utf-8?B?WGw5K3YrR05DL2ZtbnNyWWZZblZzVFI0RWk2YWUwNHNEY29FSnNFb0luMW9T?=
 =?utf-8?B?bDZqWWJzQUlGemxXbllpU015dXd5MWtlcC9OL3pVenhFdHBJemlSNTV1RW50?=
 =?utf-8?B?Q29Ub2JWVG5tTmF1anIyTTd2M00xUmtqc3ZJdTNESHNwcFl2TE45UzJRTzlk?=
 =?utf-8?B?cnllZnFLNXUzMjNyTkR0SytRakRNUlJ0SG1KQ3FFYXhaYjR1Z0N5RnJtSGsw?=
 =?utf-8?B?YnBkbmhjbVYxR281MkZuQWRJY3BSWnlOZ09qZDhOTHpNWk1POGFIN29Yc0xB?=
 =?utf-8?B?RTVnbUM1Qk1remdsRGtHWmtPdmlmTXNDdG5LcWZobVcvczc1MUJ0SEV5Sy9W?=
 =?utf-8?B?UCtDdHhvRjZ3ZmJSS2lvQmJ3eWlzR1Vqd05tRzVxTzlORU9ybkdvUWw1b1JK?=
 =?utf-8?B?Q3Z0WjRFRW9qNi81cnVqa0Irb1VxTFczYUxmS3ljKzd1dFl5dEcwQXpPZVFU?=
 =?utf-8?B?NDRMQ1B5RkUxeVZZNW5OL29MY3dOS0hlS3BpNVo0YUhnblZWcVk4eU5QQlI4?=
 =?utf-8?B?OXpOUlIyQ2NsTkpUVW9xcTNrRlhOaXY1RnQ2RmJTTE5zd0RvaE9vK0o2ditk?=
 =?utf-8?B?dzdyWmNHa0ZycWZKQTZ4UWVCSEl0SjJxeG10bldzVFlNem5ML2QvNDd5dHVL?=
 =?utf-8?B?YTRvdVdnQnFKNW5ESEpQRHhXR2JGTkd1R05UOXpxdTJYdE43cjNZMDFXYW1N?=
 =?utf-8?B?SE5rYitLOTVjNGxHaFprdmhodkQ2VTBwa0JpUUY1ZnpjSXlXYmlZanVxYys5?=
 =?utf-8?B?SWpxU0tLeVFTM3ZBRHR1alJKb0ZSMGdjcklVS292dzRiK3NBMTRxWHpNUGUy?=
 =?utf-8?B?UmE5YmwwVHZpV2lEeWduZUxMOTJaV212R2hqbG5OK2pZZ20rb2dMM0NKVFdB?=
 =?utf-8?B?TCtpV0ZoTWVsaVJmcjgyWnN3aTBPa2RCeFpIUEFSTUVYRTdMcmE1NzBWQkZs?=
 =?utf-8?B?NXFnSFpOTTQwV29OWTlUendncXFmbzBDR1FrcTB1eVhBQWp2cDRuVnc5MnVr?=
 =?utf-8?B?WnBlanJ1SzZQd0dXYXp5S3FIcEYzNjQvTUkyWGRmV295U2VwbEFMZ1NKM1Fn?=
 =?utf-8?B?blZ3eHNsRldSeFMwZElvTnNWSzQxaEJ2clZNU1FaNzdJelJwWC9KNC9SdG5S?=
 =?utf-8?B?YURxZXd4QW5RK2ZOTWlMMGs5ZG1yT0hBQktBZEtlNWhNRWgxOXJmUVpqckdv?=
 =?utf-8?B?cmhHd3l0VmRSYjF3Y0luS2ZidXhJZ0ZRRU85THlrQWhSRU5lVDhsdXpKMXdk?=
 =?utf-8?B?Q1VpOXVqSFRCNFdGdCttZkh0Um5WNFU2MTJOUlZZelVTWFI0RDg1dGFKRFlQ?=
 =?utf-8?B?L0NrZG9BUGlWTk44OTJhRHM4dG5RaTlBaTdPV2d6OWFhR1pVVldTeXRRSUpM?=
 =?utf-8?B?dFVPTHdQYkQ4NHdjRjNxWXJNY3loYThLUWhTODI5b3RqSGVBU21ZaXNjQzJP?=
 =?utf-8?B?WnkrZEt2TkVXaUlGNjZLeHl2RTVOMkFEVVQwSGw2aGRWc3BYTVRodVdNOFpR?=
 =?utf-8?B?cjZVek9qMTBNWklXRWRBWG5NK20rMGErK1FOb0FZc1FaNGF4WllPaGtuSmtQ?=
 =?utf-8?B?T0h4R3ozby9Md1ZtN2Jza2lhTXRCdWt4Y1cxb3R3eDZDS3pxb0dBVFQ3Nmtr?=
 =?utf-8?B?U24yNTBBWU5OeTlFK3pyS1JYaXVvTlFaeCsvbGRRT1FwNzJVWUhaOGVLYWtJ?=
 =?utf-8?B?TElLVmtVbE04Q3BiV3JuYzJwMVRqOFUrYUlhUzN1YjNLdU1WZmZ0RzNiaFU2?=
 =?utf-8?B?dzRkK0FyTWxDdERpTGZPaVlRNnk3cXJyVzQ1dW9QWExIWjhaK2VwTW9BZWVR?=
 =?utf-8?B?eU9kTFloNkFueUNrYlBVdVdGZlVFRy95Sncvbnh4TVJGR1JoV2thUTF5OGtG?=
 =?utf-8?B?Qkg1RU53SVB2WFJyVTVRL1hGcHNTVzBGb3ducXd6OEtvbDRoSU9TVWc4aU9a?=
 =?utf-8?B?MmZRUTc2OCs3NURGaDUvdHRmR3hCdHpEQVBUK2pqMHBBN1h0bHhrTGVmQTBy?=
 =?utf-8?B?RmtZZFc5OVVkeStnSnZUM3JQTlRsL2pBeUVKMklXOXI1K2d6cXhhbGtkd0to?=
 =?utf-8?Q?MGyFJoGAv9YJNmScndRf1p8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <629C929F896D524EB8BDC1194FC08138@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d1063741-766c-4bbf-5712-08dcd153f95a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 04:49:37.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91KuNa4Fvt+igFnBAlXYhH7989H4t77FYkUtZOuGKwk9knktfh9JdkCOvwN4VMg9oaekqbDBkennaDQxZV09RkA7fBWGXH/BM5UgHSAP7Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8727

SGVsbG8gVmxhZGltaXIhDQoNCk9uIE1vbiwgMjAyNC0wOS0wOSBhdCAxNjoyMyArMDIwMCwgQWxl
eGFuZGVyIFN2ZXJkbGluIHdyb3RlOg0KPiBPbiBNb24sIDIwMjQtMDktMDkgYXQgMTc6MTYgKzAz
MDAsIFZsYWRpbWlyIE9sdGVhbiB3cm90ZToNCj4gPiA+IGFmdGVyIG15IGZpcnN0IGF0dGVtcHRz
IHRvIHB1dCBhIGJhbmQgYWlkIG9uIHRoaXMgZmFpbGVkLCBJIGNvbmNsdWRlZA0KPiA+ID4gdGhh
dCBib3RoIGFzc2lnbm1lbnRzICJkc2FfcHRyID0gTlVMTDsiIGluIGtlcm5lbCBhcmUgYnJva2Vu
LiBPciwgYmVpbmcgbW9yZQ0KPiA+ID4gcHJlY2lzZSwgdGhleSBicmVhayB3aWRlbHkgc3ByZWFk
IHBhdHRlcm4NCj4gPiA+IA0KPiA+ID4gQ1BVMAkJCQkJQ1BVMQ0KPiA+ID4gaWYgKG5ldGRldl91
c2VzX2RzYSgpKQ0KPiA+ID4gwqAJCQkJCWRldi0+ZHNhX3B0ciA9IE5VTEw7DQo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgIGRldi0+ZHNhX3B0ci0+Li4uDQo+ID4gPiANCj4gPiA+IGJlY2F1c2UgdGhl
cmUgaXMgbm8gc3luY2hyb25pemF0aW9uIHdoYXRzb2V2ZXIsIHNvIHRlYXJpbmcgZG93biBEU0Eg
aXMgYWN0dWFsbHkNCj4gPiA+IGJyb2tlbiBpbiBtYW55IHBsYWNlcy4uLg0KPiA+ID4gDQo+ID4g
PiBTZWVtcyB0aGF0IHNvbWV0aGluZyBsb2NrLWZyZWUgaXMgcmVxdWlyZWQgZm9yIGRzYV9wdHIs
IG1heWJlIFJDVSBvciByZWZjb3VudGluZywNCj4gPiA+IEknbGwgdHJ5IHRvIGNvbWUgdXAgd2l0
aCBzb21lIHJld29yaywgYnV0IGFueSBoaW50cyBhcmUgd2VsY29tZSENCj4gPiANCj4gPiBJJ20g
dHJ5aW5nIHRvIHVuZGVyc3RhbmQgaWYgdGhpcyByZXdvcmsgc3RpbGwgbGVhZHMgdG8gTlVMTCBk
ZXJlZmVyZW5jZXMNCj4gPiBvZiBjb25kdWl0LT5kc2FfcHRyIGluIHRoZSByZWNlaXZlIHBhdGg/
IENvdWxkIHlvdSBwbGVhc2UgdGVzdD8NCj4gDQo+IEkgZGlkbid0IHRlc3QgeWV0IChJIGNhbiBk
byBpdCB0aG91Z2gpLCBidXQgSSBiZWxpdmUgZHNhX2NvbmR1aXRfdGVhcmRvd24oKQ0KPiB3aWxs
IHRyaWdnZXIgdGhlIHNhbWUgY3Jhc2ggZXZlbnR1YWxseS4NCg0KSSd2ZSByZWFsaXplZCwgSSd2
ZSB0ZXN0ZWQgc2ltaWxhciBwYXRjaCBhbHJlYWR5ICh3aGVyZSBJIHJlcGxhY2VkIGxhbjkzMDNf
c2h1dGRvd24oKQ0Kd2l0aCBsYW45MzAzX3JlbW92ZSgpKSwgYnV0IHRoaXMgb25seSBmaXhlZCB0
aGUgcmFjZSB3aXRoIE1ESU8gYWNjZXNzZXMgaW4gbGFuOTMwMy4NCg0KSG93ZXZlciBJJ3ZlIGFw
cGxpZWQgeW91ciBiZWxvdyBwYXRjaCAod2VsbCwgb250byB2Ni4xLjk5LCBidXQgSSBkb24ndCB0
aGluayBpdCBtYXR0ZXJzDQpmb3Igbm93KSBhbmQgZ290IHRoZSBzYW1lIGNyYXNoZXMgb25jZSBw
ZXIgaG91ciAob24gYmFjay10by1iYWNrIHJlYm9vdHMgdW5kZXIgMTAwTUJpdA0KdHJhZmZpYyk6
DQoNClVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2
aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAxMA0KLi4uDQpDUFU6IDAgUElEOiAwIENvbW06
IHN3YXBwZXIvMCBUYWludGVkOiBHICAgICAgICAgICBPICAgICAgIDYuMS45OStnaXQ2YjRkZDhj
ZTA2ZGMgIzENCi4uLg0KcGMgOiBsYW45MzAzX3JjdisweDY4LzB4MjIwDQpsciA6IGxhbjkzMDNf
cmN2KzB4MTRjLzB4MjIwDQpDYWxsIHRyYWNlOg0KIGxhbjkzMDNfcmN2KzB4NjgvMHgyMjANCiBk
c2Ffc3dpdGNoX3JjdisweDFkMC8weDMzNA0KIF9fbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9jb3Jl
KzB4MWY0LzB4MjIwDQogbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5hbCsweDFlMC8weDJk
MA0KIG5hcGlfY29tcGxldGVfZG9uZSsweDcwLzB4MWNjDQogZmVjX2VuZXRfcnhfbmFwaSsweDRm
Yy8weGU1MA0KIF9fbmFwaV9wb2xsKzB4NDAvMHgyMDANCiBuZXRfcnhfYWN0aW9uKzB4MTQwLzB4
MmUwDQogaGFuZGxlX3NvZnRpcnFzKzB4MTIwLzB4MzYwDQouLi4NCg0KPiBXZSBjYW4gcHJvYmFi
bHkgdHJpZ2dlciBhIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiB0YWdnaW5nX3Nob3coKSB2
cyBzaHV0ZG93biwNCj4gZXRjLi4uDQoNCkkgd2Fzbid0IGFibGUgdG8gdHJpZ2dlciB0aGVzZSBl
dmVuIHRob3VnaCBJIHRob3VnaHQgaXQgd2lsbCBiZSBldmVuIGVhc2llci4uLg0KDQo+IEknbSBh
Y3R1YWxseSBjbG9zZSB0byBwdWJsaXNoaW5nIG15IFJDVSByZXdvcmsgb2YgZHNhX3B0ciwgYnV0
IEkgd291bGQgbmVlZCB0bw0KPiB0ZXN0IGl0IGFzIHdlbGwuLi4NCg0KSG9wZWZ1bGx5IEkgd2ls
bCBiZSBhYmxlIHRvIHRlc3QgYW4gUkNVIGNvbnZlcnNpb24gdG9kYXkgd2l0aCBzb21lIExPQ0tE
RVAgYW5kDQpSQ1UgZGVidWdnaW5nLCBvdGhlcndpc2UgSSBjYW4ganVzdCBzZW5kIGEgY29tcGls
ZS10ZXN0ZWQgUkZDLi4uDQoNCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2RzYS9kc2EuYyBiL25ldC9k
c2EvZHNhLmMNCj4gPiBpbmRleCA2NjhjNzI5OTQ2ZWEuLmYxY2U2ZDhkYzQ5OSAxMDA2NDQNCj4g
PiAtLS0gYS9uZXQvZHNhL2RzYS5jDQo+ID4gKysrIGIvbmV0L2RzYS9kc2EuYw0KPiA+IEBAIC0x
NTc2LDMyICsxNTc2LDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZHNhX3VucmVnaXN0ZXJfc3dpdGNo
KTsNCj4gPiDCoCAqLw0KPiA+IMKgdm9pZCBkc2Ffc3dpdGNoX3NodXRkb3duKHN0cnVjdCBkc2Ff
c3dpdGNoICpkcykNCj4gPiDCoHsNCj4gPiAtCXN0cnVjdCBuZXRfZGV2aWNlICpjb25kdWl0LCAq
dXNlcl9kZXY7DQo+ID4gLQlzdHJ1Y3QgZHNhX3BvcnQgKmRwOw0KPiA+IC0NCj4gPiAtCW11dGV4
X2xvY2soJmRzYTJfbXV0ZXgpOw0KPiA+IC0NCj4gPiAtCWlmICghZHMtPnNldHVwKQ0KPiA+IC0J
CWdvdG8gb3V0Ow0KPiA+IC0NCj4gPiAtCXJ0bmxfbG9jaygpOw0KPiA+IC0NCj4gPiAtCWRzYV9z
d2l0Y2hfZm9yX2VhY2hfdXNlcl9wb3J0KGRwLCBkcykgew0KPiA+IC0JCWNvbmR1aXQgPSBkc2Ff
cG9ydF90b19jb25kdWl0KGRwKTsNCj4gPiAtCQl1c2VyX2RldiA9IGRwLT51c2VyOw0KPiA+IC0N
Cj4gPiAtCQluZXRkZXZfdXBwZXJfZGV2X3VubGluayhjb25kdWl0LCB1c2VyX2Rldik7DQo+ID4g
LQl9DQo+ID4gLQ0KPiA+IC0JLyogRGlzY29ubmVjdCBmcm9tIGZ1cnRoZXIgbmV0ZGV2aWNlIG5v
dGlmaWVycyBvbiB0aGUgY29uZHVpdCwNCj4gPiAtCSAqIHNpbmNlIG5ldGRldl91c2VzX2RzYSgp
IHdpbGwgbm93IHJldHVybiBmYWxzZS4NCj4gPiAtCSAqLw0KPiA+IC0JZHNhX3N3aXRjaF9mb3Jf
ZWFjaF9jcHVfcG9ydChkcCwgZHMpDQo+ID4gLQkJZHAtPmNvbmR1aXQtPmRzYV9wdHIgPSBOVUxM
Ow0KPiA+IC0NCj4gPiAtCXJ0bmxfdW5sb2NrKCk7DQo+ID4gLW91dDoNCj4gPiAtCW11dGV4X3Vu
bG9jaygmZHNhMl9tdXRleCk7DQo+ID4gKwlkc2FfdW5yZWdpc3Rlcl9zd2l0Y2goZHMpOw0KPiA+
IMKgfQ0KPiA+IMKgRVhQT1JUX1NZTUJPTF9HUEwoZHNhX3N3aXRjaF9zaHV0ZG93bik7DQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==

