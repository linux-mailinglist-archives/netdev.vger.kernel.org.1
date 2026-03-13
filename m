Return-Path: <netdev+bounces-267408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBPeE2jts2m4dQAAu9opvQ
	(envelope-from <netdev+bounces-267408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:56:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE84281CF4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C5E300ECA6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4CB38734F;
	Fri, 13 Mar 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clH9dD2f"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011003.outbound.protection.outlook.com [52.101.57.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBCD3358BF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399396; cv=fail; b=kfnzJncyfAupQoL5rOAx5R5Vc9/xQsyvh2UxsOzNyXIXGZ7DKdOK6Ki7wVdLNCvP10FkGuoStzXY0K7je1KhByUud4qs80FdPEOWpZ9PIQjG4uzzert59Wl4DH4ltOT0BVjWpTW9zTxcQ8aNuyHq8r2ymvNC31bNZVsUKeTYZz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399396; c=relaxed/simple;
	bh=eWMQFTcWnIw6NW64fDtsPet0Ibxjq2EyjF7qHZsbNwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzdS1ximhoeoHXA87cC6K+blDVGm9LsMXgJuoJXEiq5sza5340sfT5FOfAQeEgJJrPghu0k4ueq4t2MXAuKm7KjDuBDY2Dw0EyHqwa/niT5nkPOgS2NO+YuhtgM9L9YTes3l1Q4un7xCd21debPTGImm9UB6+PM0Jb6d0Gu8Xt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clH9dD2f; arc=fail smtp.client-ip=52.101.57.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/zAJCXK+e0ZtpDYCrB2QDZPaOPG0UVhWMw4iclmoG8CUf3TLJ4myJ7IU0O98ZSJaezOdmA+0Rv9K3nDNH6wVKFCnqot9nq2mlEViQ+c6SxKgXsq977nz9KVoT56p58VLhYckdS1sHnumF6O9Wg0mNtosc9No6GG8nn62Oag1pUf5q+FNp9MxZztMYm2u/qMVa08Rrm6NDFkCcRJH9vvA+Uo6+R+5NVpmPd7RtVfwhaSEKs3D7SkvSsUMnY7QD0jw7URKK5dICJ6c8BJ994EBI6BX1erocEWJsrV59FVeKzOuFmmSG2FYyxSx/aFJf6M/MnvW+71cMcajXWquNg/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWMQFTcWnIw6NW64fDtsPet0Ibxjq2EyjF7qHZsbNwo=;
 b=j7UZU6bkm0gsE3n2YZk728HqmEe6xHHW7ybyKSu9m65QIFx5N+IiPBjf1TjxpG1CW3v31RGySGUYq03EROB2BhdKWawQmIfHNloMcweOO6Yjgg8o5nfhkkavziEri7E9GzLZxLI/B0XH0dd8ZIWy6iu9xqHDOX8hi4Euudc80ZWPwxm5qWarQkuUCwUZII++wwXeiHJ85Pfl6+36Qt+jnVksd0pquisYt+t4Q0PuZ2/UiKRdX12GIbgI5tz+b1uaxyRcsGUd/HSZeynFxRrGnUVPcJv1qAmFqb8NPj2bYSyFqeGN7MEr4cQOyQ0/XzbZE7JxniWBt5VlyHn9K7EMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWMQFTcWnIw6NW64fDtsPet0Ibxjq2EyjF7qHZsbNwo=;
 b=clH9dD2fdXxaMQONzJA7BjYKVh/taAsv/BMj8+gPLli5p5cBrpJQhWQn6FnjY1JXfrkff5gaTewAmHQ/OnasQ+bS2Vi1g+j8GG4QUrYhNsEum+ScRdyhSaNS5Tjqwh2aRx1ypBJWGzjQWmvgkq9J58ojf1dVLCd6Tti+E0sUqmqVua7UanBAiP7O7SQJvtTcycFIWMo/1q5jT1O7onsAUVtQLuvk8OPvD+PH4LNODPAModftWpyDsNAOZ/ZU4Z1JmWxNFIbrGzuZdZ+WPswQRcz1jWSus8OaakfCy7zN3CoPFL26nN32ZkJzEby3MoMRCZaj+pC82AkXt1XAoNOv7g==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by BL3PR12MB6572.namprd12.prod.outlook.com
 (2603:10b6:208:38f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 10:56:31 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::40ba:2995:ae48:aaeb%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 10:56:29 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, "edumazet@google.com" <edumazet@google.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Thread-Topic: [PATCH 0/3] macsec: Add support for VLAN filtering in offload
 mode
Thread-Index: AQHcsteOyxTTKlU7oEuWtuS5nAxEzbWsSmWA
Date: Fri, 13 Mar 2026 10:56:29 +0000
Message-ID: <52fca5034ae2c4b0585e4a82329b73aee720dae1.camel@nvidia.com>
References: <20260313105227.1884391-1-cratiu@nvidia.com>
In-Reply-To: <20260313105227.1884391-1-cratiu@nvidia.com>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|BL3PR12MB6572:EE_
x-ms-office365-filtering-correlation-id: a173a658-861f-461c-344a-08de80ef2e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 gs0h9roJDs6suZYpug6PJBVbXZO9Rl5JARhow9wsrecFbpIk1sSeIa/x0BWu1CuDjisJkhSv+CgB+15U6L6VkB5MTzVkEhGHZnbJT7zFdD4N0AMc4VZfAUsS/elcB1NSr5hd7g4xtYFut9f8LSOgUhsNkXN/WmuvuTNRR9eE2u+tgDAndUhx3qQadJ1dmPhIDiIvAGVV+puT6e79riGjLu83hKls5WyK+V5zyKidcy3qxO5bOQKwmJjV7FZOym/HC0SywDkdsLlgsI2sGZwsR513xGZavQ8umGQeBxCdpBRt+uoO71wOzXDqQ2tPQc3TtG50jTTyCiAUqsBXQB3ZAgAXDHwGCgCw5WwLOGXwPqbhs29I1WSz78jRyeTn3qUURK7/yLgU/WJ3UI4n1A8xrRj5foDR4ZsUZnwUa96LwzrFp4B3lzpAQw/1DGKKSS2wvruRbrD1MuUwkyfAZB9cH6XfCn3r14dbx2YSd1QJoRgNJ3FJMKOW9RNtaEs+jLVK8+yxM+wBmZ6R/DR0Y7vclBQPBm56cKupWg31h1/nTxDZiHPKxVo/dDFj9jGvIt5V7K0KNB2vbtxRKXC1pDx+D699ZIDB5RTe0Ywk3GoPSsqh5yzw+Od54wMlUBCoTU5bKPa5lN1sYenLvqmzmNeAfAK9iPrd8AaBa9oLiLCid9fTKmzDCvIoh6BbOTHSm2riQ9LWIAs2S17sL/D1BrkdqVtzNanwLCNuTRJk8Mw3UvWJIb4ej7U8rRuvzJ+DLsjB0Q+e19yj1Fw0ezqBy6mHyK2g1cpPcbAKUJ/NzrxF7SA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGVNenpibWNNOENWZ0tQQzBZb21MSEQ4cURsZEcyalV0V09ORjRSdGJSQU1p?=
 =?utf-8?B?MWYxRjlXKzZLemMwL1Y5SzFTczM2dTVBdnptK2pObElxTW1aaG5MVWpQREd3?=
 =?utf-8?B?V1NhRVp5QmoxUE1BWWtzSmtTSkZ2YWtJZVpRWUxXR0VmYjVERDAwMmJMdmdJ?=
 =?utf-8?B?L3hvdXJlVVZFekI0T3RvcnhhWlB3SnlVRk0xL25ROFFrVFV1ckliU0ZwZlMx?=
 =?utf-8?B?MzI5K1JndGhicEJHWjBCZmd3bWl6VkVFN3hYblp3eEZIY1pGTVA1LzNBZnVQ?=
 =?utf-8?B?cjNXOUhvaTNHSmtrRmw4dVZMSndZWkVQRzNwQ3lqbmgxc2NtK0xaVWxnbVlr?=
 =?utf-8?B?Q0xiRzhoemZ4K1kvOVVXME40eFJTM3Yzckl1aHZRRWw4SXZ2eVEzQ01QS0dN?=
 =?utf-8?B?MkVCQXdJOUVXVTIvWEgvUG9KZTRSY08relhqaXNxVU9OMXZiL3F2c3hhOEkw?=
 =?utf-8?B?dXFQbERjVWVBSSs4Qk1ReTNzTTVZODRiTVBuMVRWRVFyTTBiOWhhTThOdVJN?=
 =?utf-8?B?TTdsODZjSWdyYUk1aVkvWEQ2dWJleUFiWlk0Z2d2b1hCV3JxeFF3NDRYcnBD?=
 =?utf-8?B?QXBadkNObXJNZXlNUGV0RnRTa3FKUmxWc2pKUW0zQnNNRXJmSE12RWZzcitM?=
 =?utf-8?B?ZHlGS3M4TTJvZEZSQitzRzl3b0ZEWmJTdjRQY0Yxdjh2bFcxSHRjT0tJd3dB?=
 =?utf-8?B?NXVXTTV1VzBZaGZhc2NvaHNDNTZYN0lnazVZaVordng4TEM4OGYyMjNwRWxz?=
 =?utf-8?B?c0c1RDJmN0xaRWJXNHJFU1ZHL3hrUVNJNUJUUmJXbmJ5bVArdEwybE5RZmhK?=
 =?utf-8?B?dDBwVFQ4WVFHeS9ReTQwR3VrRlFrVUtJbTZ5UVZPU0dWNndyYmQ5R3U3UE5l?=
 =?utf-8?B?d2tZYnY3bTJieWlrWEJZOWx1bXkwekcyWi9Bd0d2R281M2x4VUx5R1ZrNnZH?=
 =?utf-8?B?WnJKZzN3RVo3RTA2ZUl6L3huNXp5bGhOcytPa1R5WWFtTDJybXpiNnBOd2pu?=
 =?utf-8?B?UTQ3TUpwQTZaVkV6S2xYK05PRjNmNEd4OExzWGJpMDlBQUNZUXFTSVZmWjFX?=
 =?utf-8?B?aEYvazg4Tk9jaW1ocjhyM05GOHBoNVFoY3lyMHlpY20vUWEyUWVtSERXMDl1?=
 =?utf-8?B?Z2d1QTl1NkY0bFdrOVEydnN3b1RDdXZTZW16N2tld2MyeUM3dFRzWUZBOWV1?=
 =?utf-8?B?c3p3RXY0ZUlZMWFVa1BnQmNDTktJUnc0WmtmS283c0N6Q0lVVUdJcmwyNGN4?=
 =?utf-8?B?TlJDMzluZ0IvRmFpYXJxS1h3SzE5T0hlTW5kTkZHU2ZoZ0h4R2JWdG45VlA1?=
 =?utf-8?B?QTNGSGZWcUpHN3pWUzJpY0ZIRUYwYmF6aENwcGt4eVQrVVlvUFdTM1VQcHMy?=
 =?utf-8?B?SkI5VGJKcGpyU2RmOEZqWkw1MG5sd0ZRenlZN0w2NWltQm1aNHBRdTNETk1x?=
 =?utf-8?B?Uk5jMVNqWU1sY0N4QSt0aWhBVlR3NWc0VkZqb0xqalQ5UTZWTmhvc3czd2Uz?=
 =?utf-8?B?SWIrQXdEZ1RUd2ZPeTAranhmWEN6cnZid29XOUNYNWdjbVZQaVF2NVpKMnlH?=
 =?utf-8?B?Y2JUdnA2V2thVzd5TDF5Z2htV3lnbXJ5ODhOZTBXeFUzYXJjQUo1WVpIVkRs?=
 =?utf-8?B?NS9RQVJiR0VDdDF0QTFuWGIvK2tnWFpxcmFvRDJwWXRqSll4c2huejN1Y2tH?=
 =?utf-8?B?NHJqYS96R0l3L2lnbXFhTmhGbEVidnp4amhWQ0Q1TWRxVlBnNVlkaHlsSkZN?=
 =?utf-8?B?dCtrZGVJby96K2F1VlRFcWNUWTkyeU1sQ2RxcnFubmt3VWNqTVFzNnR4cGkx?=
 =?utf-8?B?SkVLSjJSaEVXQnJma2UzRWJLWVZFZHMrVVc4YThxbmdlSkJxdkJoNHNsOHFh?=
 =?utf-8?B?ZjlZUGNZdDFDMUw3WDdZVTVTYUQzWkZDZGJITDhRTnUzR3JyQnhXaDB6OHlZ?=
 =?utf-8?B?VWVydzRrL1JFZ0cyS2xMbjVCWVBPZnVxWTVQb3pxWkhKOU91Y3Awd3YrejRT?=
 =?utf-8?B?VStZQmhpdU9YRkpWdWVRZW52UnprTlBGUXl3NEFOV2ZxSjBmczR3eWhaNEtM?=
 =?utf-8?B?dDYrQitSQnA4VUJVc3Q0NWVGR09sVXY3ZVJZRnRnZHJnbklraDFqSDQvd0ph?=
 =?utf-8?B?SU11T0JJZEZYQWFJQndrc2M0R2xKSTVjWnU0V1B4Y0cvdmJCTThSUGVwYitG?=
 =?utf-8?B?aWxqUTdRRndTQ0p1SlI3OFBxdGFaUkNQbVg1andhd0JhOHpqM21meU5Oalhp?=
 =?utf-8?B?MldJMmJnUkdHYk05VStzVXJXalFsTHVsOHhSQmhqeXh4bDdGelRJWUNqZ0lG?=
 =?utf-8?B?OWdIWEthR3NZNkdlRVBvQjJJS0tkbjdHWXFJWHdoOFNsR2FQL2xqdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B7BB4278A9D904B910EADDD0FED0F9F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a173a658-861f-461c-344a-08de80ef2e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 10:56:29.6517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJMwAXBGZ1OWEeZ/kM4DDoY4FcCCbnb+3qTbbG6l/Psl49UXQV4YhuCx7ljo6L45XqYzdFvgsptAycx+kKR8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267408-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:replyto,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cratiu@nvidia.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cratiu@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: BEE84281CF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDExOjUyICswMTAwLCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+
IFRoaXMgc2hvcnQgc2VyaWVzIGFkZHMgc3VwcG9ydCBmb3IgVkxBTnMgaW4gbWFjc2VjIGRldmlj
ZXMgd2hlbg0KPiBvZmZsb2FkIG1vZGUgaXMgZW5hYmxlZC4NCg0KU2VlbXMgSSBmb3Jnb3QgdGhl
ICJQQVRDSCBuZXQiIHByZWZpeCwgZXZlbiB0aG91Z2ggdGhlIHNlcmllcyBpcyBiYXNlZA0Kb24g
YW5kIGludGVuZGVkIGZvciBuZXQuIFdpbGwgdGhhdCBiZSBhIHByb2JsZW0/IFNob3VsZCBJIHJl
c2VuZD8NCg0KQ29zbWluLg0K

