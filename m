Return-Path: <netdev+bounces-280329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDvkOuhv6GmbKQIAu9opvQ
	(envelope-from <netdev+bounces-280329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:51:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BA94429AB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0076B3012E89
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A9133AD9A;
	Wed, 22 Apr 2026 06:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="JaaLIsvF"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C1E3126CA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840480; cv=fail; b=BJQS9Y5A212QfZO65pNrqP36rsMAUltM0KO2f8sooZ9lGZWA2U2gdQmVjMhOZzLq/Ff984OioUvKCS6rAHYPVLt1yb2C13eiBjK8BqphaTfjsd0uka8xufVYHaE72vlzsAj+OyDYpHQAFG4hseF8I7SXyZLmluP2UaUOEhieRpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840480; c=relaxed/simple;
	bh=1mFfQUQGVqgv4tyPZhzXW+8D7rqIhGSu55B6BYD21Uk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ID3jEYfR8xWYH7wlUCA6K6TOS219FgXeSHqLAuiFDvWzPnjE9yj75Fu5pJNMPJ4Z88eP/awjFrz8W80Pn940OV/z4HgEni/3Uql/KBXVRr7rf/uOJbt+0GYdqHBJ3x93UKRJrcM7wAI4PZh8fS3LXcRrkbfw5YrKDaV0qJSc7TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=JaaLIsvF; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CzmZ9bmRlks6EaXrruINBqe6YSpNdpIAZZYwJUVr3RDCRRM2o5e9ANwC3ueTeWTzHbTtS57xIVt3SzeY2ZvVnoEOE/P5HfY07pKWds8079vzSrciwWeHbfEpQhVZ3tavReDF8WqqWQiLu11RoFU+HHxXiMmy65Moc9CGcrz185EKJi1rlJKyQ+h2D8WJAyA08+1VHVZ4zm7QiSuBZ+iaapAy2GiwKG+uNbyqUyGER84WDTMS5odJjxnPTwaa1m3bZLoG9k1qRkV/F62StJWp0eFlQ2m2Ob7QPKNEYP5Z8t3bCQC19EvM/eC+cfOXSAvtVq7nYpMaXpmrVySAP5zxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mFfQUQGVqgv4tyPZhzXW+8D7rqIhGSu55B6BYD21Uk=;
 b=AJ+T9+w9d0A7Qrm3ndAWlq6ag+VOPQDbkdBFM04E89b6PQD429zjljrugbfHDmPsRMsrtHRoIaU5sv7TNZQt2alO+y/ROJPLlsUOoPqKM7PJRmfmGdjOqtNy1NbP8au/bYQn9CiPOvteyHpc9XRasfpyS6/Hbghg3wArZRyluZqEg7WHZrNOysKNe1xPBVQCdku7MD+V3eltSSAx7Dq6AzywVu8gyDnhuGT/EneZjaypl0ragtrNJrlcFQ01HEWVEdEf37UzcVblmH6vxsY7eLTSUBmQ9yTq9xcn4e3BWi6GTp6LOIIZhdHtBE2LjS1RAicdcEKLLlf+JVgGhMhOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mFfQUQGVqgv4tyPZhzXW+8D7rqIhGSu55B6BYD21Uk=;
 b=JaaLIsvFx1mpGpO2Njdzt9j5QdTMJEbQ7+N4D+GSqqqj+unff/BiUBGPWa86GqslRGXkQpmC2CtWkayM/7/0BP/1Iu1Z4y0pVyDIlzYSCS5tItzy+d0Z0OV4jBMO1eKdrZar6XOjVZj1CWNl2QZ3F/FpWGySSUfeCR8bJMR7UdwUxOaN0jLhIcH0wPlV/wWgxk4MrjaWOB7pCiWKF/HEVz0FyT3MMoKe0l3zWtargvVpi++4LTGOuvNNYOJf95g4Dyk+Un3mTM+T83YKsJaKGQ3EZdahQe66sqo8EImJCQKC+7COmAXbBSG/uVw1dNmplO1KgwyWwTdE80HwRsF/Tg==
Received: from VI1PR07MB9850.eurprd07.prod.outlook.com (2603:10a6:800:1db::9)
 by AS8PR07MB9086.eurprd07.prod.outlook.com (2603:10a6:20b:56b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Wed, 22 Apr
 2026 06:47:56 +0000
Received: from VI1PR07MB9850.eurprd07.prod.outlook.com
 ([fe80::d889:14e5:7b50:cb3b]) by VI1PR07MB9850.eurprd07.prod.outlook.com
 ([fe80::d889:14e5:7b50:cb3b%6]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 06:47:55 +0000
From: "Karol Gajdos (Nokia)" <karol.gajdos@nokia.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: a bug in drivers/net/macsec.c ? (ssci endianness)
Thread-Topic: a bug in drivers/net/macsec.c ? (ssci endianness)
Thread-Index: AQHc0YNKoCch/aFIFUC74tZa1KH047Xpe50AgAEh3hA=
Date: Wed, 22 Apr 2026 06:47:55 +0000
Message-ID:
 <VI1PR07MB985021E5128D36B1905A53A6962D2@VI1PR07MB9850.eurprd07.prod.outlook.com>
References:
 <AS5PR07MB9837EA10B11F76A167FD20A896202@AS5PR07MB9837.eurprd07.prod.outlook.com>
 <VI1PR07MB9850B2C9119357C3B254F83F962C2@VI1PR07MB9850.eurprd07.prod.outlook.com>
 <aed1wCDC2Oh4eZ1h@krikkit>
In-Reply-To: <aed1wCDC2Oh4eZ1h@krikkit>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB9850:EE_|AS8PR07MB9086:EE_
x-ms-office365-filtering-correlation-id: 059fee9d-4ccb-4945-61ba-08dea03b1586
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 Np5aKIec2qfXuOcP9hWe/gpNXvbcQ9yxfWkoy/nbZixlmpu2krYy2Wpnrywr9sZzZpirPWZrljxjr5tCfBPZq4oOE/Svtsn8WC1pT6UOczmh/vSnkslHpTdXXUeVVcM/4fejkaxb5lpsXYrKyg66wejanTholTqTRZb0Ldxd5oFScYYTvZgqeZmd2bmF22Su5RFx1XnP30eF0dsFOfSXxClBxKymtCBDzpy1ZD4L3p7N7eqdxJoYrntCxcKDbIMLyecEYdwStIYYB0HkvhmWkPG3vELmRzH7Ty72IX56SMlJCuxyA7ux3ka1N/youYtXuvt/HwrDWGX2GFJhCSqeuCBh0hu1iAYTOv4FZiHgyqvqZ8THfvkArFP4+28RMYiJg+g/HzwwCZCQkBsYENs64xHl84T6TDeWOseYNxP7L0d7miW6o223I6fhX7DjBiXzA3HYgBS4M/JuVLUDYSza5jXFyfXR6ZvsX8jPiqWc4OBtmZEYnaoKSfjlCMv/jsylRwinx8GwF4X9oEILNBTcUhWiXZ4AD3LICQ8rLqk6PRtQoonb4FuIIeyaG4pyWY+WEPNRm7aWWd828h99kX/TAKCk5OqlhCYGgUg93lVMgUyYx28qhwX21zLE5lQT4gg/FR/ivpeXKAIxfSxnIt+dTeG6FCMSm9FbYsv/r9KKtQQYIaGCuHLZU0Z+hhHYS+90UYAYd0/pt2E+p06GuenY02AreZS+9ZaedarCUrGyVZWeHkM2SYhjLOipYF/roerHZfsMXTshmTJ66a+8vT5SESV5CY/ia0ho6wXiRi8mvY8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB9850.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW1pRm5BY05MSEUyeHhCMWpON3NlUjFLZkZ6Rm9UNWtrNnluaHNMNXpjN0tW?=
 =?utf-8?B?R3ozSTRMVldjVXVRd01HQldHU1NzOFE4dHZzdFVrdVFXMEdUU1NFSS9XWXpm?=
 =?utf-8?B?aE83Vk1yRzVnNk9MaG1MdFV2NC85SXNYSkpuWjNRSWFzVTdBaDZVWnZoUDg5?=
 =?utf-8?B?TW9UV09lcEUzeXpVVUlPSWFDTXJ6K0Fzb3lrejVUbk9LOHRwSWJhWStWWUpy?=
 =?utf-8?B?WHk4VTZROGRUOGxTNy80dXB0MFcyWk5qUTlmZnp6S1RtQmg5dkg5bGJMR0Qr?=
 =?utf-8?B?dmZ1MzY3Y3BkL05VcGpSZGNsZzAxa2d3VTNuZ1lVL1BDbGRTeEZzeTRJQTl6?=
 =?utf-8?B?L0s3UkVxTjgxdFpZM2hGNXhmcEhuR21UcWw5TGtzaFQwUER2UkJFTU42QTZX?=
 =?utf-8?B?L2RBdHA4TWp4SGJXdFFSWktOWk53anlNSWFmQVlGVFhraDJMNkNVeXlTclB1?=
 =?utf-8?B?T1krRVYzUDBWSEtSWHlqdXBOYVJIQzR1QU1mMTZMbnZ0b0FoVHlSYnlvNzZM?=
 =?utf-8?B?NlBuZ0FzY1JJdlpLb2dkWlpRbnhMUUVwZENIejBqY0Rkb2hTN3Uvek4raVBT?=
 =?utf-8?B?YTRWa2k3M3h0cUltRFlvUXFZQ2MvM1Q1aE9MQkhCbm1VZEdCTGpTVXkzTTBj?=
 =?utf-8?B?U2g2dHdWNnArYk8rWW1ncDAwWUVYUGtxaVJmTmc4OFZNdExjOTJ1ZFowVTdI?=
 =?utf-8?B?akRWR1VhY1VMazViK1BGMXJpS0dHVm0xMVlVRStCaUR2VUh6b1JtNlprSTVE?=
 =?utf-8?B?UjcyUGVNRVRraEJzM3lha0pScExnZ1A2bFpXWnk2dExaWkZJU1JleFlJUXZE?=
 =?utf-8?B?Z1hOZEYzbVlWdCs4TXErRm03NThYMU95QzVJSC9tSTdhdWxYeEh2OUxmQ2Mz?=
 =?utf-8?B?RHlZVXIvK3R6Q3h2M3AwUlVmVEk3Q0NEN044WGY4dVJZTy9TSjFMWm01a1VN?=
 =?utf-8?B?bi9ac1R5ZStDQjNXWjk0dkZiRGZWY0NqcDBWdzBSYVV5QU5FUnFlYW5GNERX?=
 =?utf-8?B?OThHcG1KekdzMWRUYmVocUpNcjl0akFUVzQ4c2ZRbFQ3cDVBS2U5am5ZNVRM?=
 =?utf-8?B?UERiNUwzSXJNVGpwUXpsNHF0Szl4THBvem9yQlN2QUdBak5RV0dUcU40Z0VM?=
 =?utf-8?B?UTFsejM0di91RW5iOTVxbHJOQ2RjSndlZEtiU2dabnJTRmxWVGZ2bzVkODQ1?=
 =?utf-8?B?bFlMb05Pc3pVY3c5ZXUrYXhnUjVweVFVWmpLRktqZmx2eFdNN1BkNHlLMDhD?=
 =?utf-8?B?NlZ2WmtuZXhjU1ZZellTcDY0ZkxCWnVHS3U4YU9STDNpQ1hPZjladGt2M1Ri?=
 =?utf-8?B?bkdBRG1BdFBoSHRUQnFRbUxHdzgwQWN5Z2U5ZGxiVTd1QVNlbUVhNENpWGli?=
 =?utf-8?B?SHJvc3Z6Y1ltTzYyVUl3UTV0ZkljaE5nWG1DTisvdjRoS2ZlZkkvZE1PT1NN?=
 =?utf-8?B?WS9RY0dJZzRKSFBoNHJ1OWJjbzEvcDhIMEJCMTJSdDhyRDBYYkRwM2ZHY3gy?=
 =?utf-8?B?YnhWUnVwZTVON3RvOEZzdi9RT2dHOGVtNUlTaU83VWZuVUFOQlkzc2cyQUJk?=
 =?utf-8?B?OFg5TnB5Nm1KVmR4aUNrSG5KNjRYcEJOU25xT1NXRE43OFhBcGhjckRvdzNM?=
 =?utf-8?B?OEVVNk5qazZsTHVYQ2VVYzNIR3g3L0FNV3RsWXQyd0UxQWJBYnZTazZ3bU10?=
 =?utf-8?B?YzhWc3RGc0QzL0lVVW5QWHFtZkhneFF4RUJqUjdPaWg3SlJvajh3UStya0Rp?=
 =?utf-8?B?djBodHJoVDlBcWxtSG5rYWYrTkNqbEFqcFNBNDVrUU1ObEc0S2lqandmVXJp?=
 =?utf-8?B?Z3F6TFpOVHhsVjJVK0pWMkk2dkxiaXd1cTJoN2toYmRMSDZIamRqYnMrdGJl?=
 =?utf-8?B?dTFXS3dhcmlFQUZzVmx3MHVqdW8ySU8xSU12SXRDNXhhNW95QW95UGFtTUt5?=
 =?utf-8?B?QlI3ZEJ4MjkvZmVER3NaREJuc1cra0lLclN6NFNjZWR2VFc0TS9hVWN2Vkpq?=
 =?utf-8?B?ZUpDenIyaG1LaEU2Tk9WcGJBckU0RzBaazVPK3JJS1VJbm9uOTVuUTFDaFZ3?=
 =?utf-8?B?VG1QTS9tUG96QThvUGgxQlZ6WTNJTzE5OEIyZ1JEV2I2eDZNQkdhVlE1UnI1?=
 =?utf-8?B?VFRvd2J6aGVTSXkvNFJhUU4rR0xWNjhqZ2RDaTZROVdQZEo1MDhkMTNjUE1r?=
 =?utf-8?B?Vno3TkFBUDB2MXVaM0grVlFidi9MVDA4dXJYS3R6Sm83bHdNK1FIL1JCVTAw?=
 =?utf-8?B?MHRTNE5xY1ZsUjJqSnlnU2F4ck02b21kcUx6VVpNVmg5UWdaRHJuWFp5OFZi?=
 =?utf-8?B?OWxycUppelJETTZpME91bUoyN2srOGlHZG1UcGdyaU5JMmR4TjdUZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB9850.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059fee9d-4ccb-4945-61ba-08dea03b1586
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2026 06:47:55.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bAxCXVVBG2Ilhpv60PAgRWgTdVsJZDaywWZfd8v3TnH7q5KircnO5Z24He8B8K6gr2r9hn1UsinGHB4Txeg1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9086
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nokia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nokia.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280329-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,nok.it:url,nokia.com:dkim,nokia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karol.gajdos@nokia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 57BA94429AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T2ssIHNvIGl0J3Mgbm90IGEgYnVnLCBidXQgbGV0J3Mgc2F5IGFuIHVudXN1YWwgYWdyZWVtZW50
IGJldHdlZW4gdXNlciBzcGFjZSBhbmQga2VybmVsLA0KYXMgbmV0bGluayBnZW5lcmFsbHkgdXNl
cyB0aGUgaG9zdCBieXRlIG9yZGVyIGZvciBlbmNvZGluZyBhbmQgZGVjb2RpbmcgaW50ZWdlcnMu
DQpBbnlob3cgdGhhbmtzIGZvciB0aGUgY2xhcmlmaWNhdGlvbiBhbmQgdGhlIGdyZWF0IHdvcmsg
ZG9uZSBvbiBNQUNzZWMuICANCg0KS2Fyb2wNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IFNhYnJpbmEgRHVicm9jYSA8c2RAcXVlYXN5c25haWwubmV0PiANClNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDIxLCAyMDI2IDM6MDQgUE0NClRvOiBLYXJvbCBHYWpkb3MgKE5va2lhKSA8a2Fy
b2wuZ2FqZG9zQG5va2lhLmNvbT4NCkNjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogYSBidWcgaW4gZHJpdmVycy9uZXQvbWFjc2VjLmMgPyAoc3NjaSBlbmRpYW5uZXNzKQ0K
DQoNCkNBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNh
cmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhl
IFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KDQoNCg0KMjAyNi0w
NC0yMSwgMTE6Mzc6NTMgKzAwMDAsIEthcm9sIEdhamRvcyAoTm9raWEpIHdyb3RlOg0KPiBIaSwN
Cj4NCj4gdGhlcmUgc2VlbXMgdG8gYmUgYSBidWcgaW4gdGhlIGZ1bmN0aW9uIGZpbGxpbmcgSVYg
Zm9yIHRoZSBYUE4gY2FzZS4NCj4gQ2FuIHlvdSBjb25maXJtIHBsZWFzZSA/DQoNCldlIGV4cGVj
dCB1c2Vyc3BhY2UgdG8gcHJvdmlkZSB0aGUgU1NDSSBpbiBuZXR3b3JrIGJ5dGUgb3JkZXIgdmlh
IHRoZSBuZXRsaW5rIEFQSSAoc2FtZSBhcyBTQ0kpLiBBcyBsb25nIGFzIHdlJ3JlIGhhbmRsaW5n
IGl0IHRoYXQgd2F5IGNvbnNpc3RlbnRseSwgd2hpY2ggSSB0aGluayBpcyB0aGUgY2FzZSwgdGhl
cmUgaXMgbm8gYnVnLg0KDQotLQ0KU2FicmluYQ0K

