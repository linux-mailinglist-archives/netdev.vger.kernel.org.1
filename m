Return-Path: <netdev+bounces-307338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id emOaB/OfVWpcrAAAu9opvQ
	(envelope-from <netdev+bounces-307338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:33:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6650D75061B
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 04:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=jooKQP7Y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307338-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307338-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BD73036ED7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CB37F745;
	Tue, 14 Jul 2026 02:33:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006F2652AF;
	Tue, 14 Jul 2026 02:33:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996400; cv=fail; b=ODdzsyASAd5mNzLypVshqawW1y1YIfUycILUfk5LJlnvpduW4PVU+ddIFScmLtiDneAkitukVYMSWf5Xv/4whgZmTmLQqGY1ielXkqOJniv2YNQRNvCUjxbMcJSghwobud+COzgTJPIdXRuJJUR0Au5tdr+450UgfenaGRgyJLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996400; c=relaxed/simple;
	bh=bs5MtyNgboN63o+w+o2rFSPYyRZudIVzeWj8ZV8PlD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZpkZdnSwDpgKYIMIjiyTm2EcHFQUzS/3mwu6G9eJ4JNDgUUgVB+1zBEvhoOtLw98NOCiaxxbyXJAcsDfz/e7oAD2QAnmWXQ7AzB9cNlMCueUVO5lBZ/BTjZkKwBr0f31aNtLuWMRAFVf5YRamvQTD74a/kNtiWiymBwm2AFuANc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=jooKQP7Y; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3nLoBKe+Og3FLGjy+jss+YqNnOi4O3kkLi/xupv8FehMFZRjMX1r3p9oqu40zahqqA/VHYqbOBjGLofw9KjboH/izpPWJW0rhIixGXBBKnuSE9nC8I/F+zEReYIVUEOPAen6KQBqdyP48lLwZkgT6narhELgkXyK1EHtvyvgy4RtVAvCfd53/oQjfegGcHNn4O49J24JYZYudobWTVTYGFm/9SlyFiV5fm1Dyb/659MdeaT1Mh66Sw9kvQkwbH4bzBAKseKhuIbgzKyYG1g7oROISB/CD3N67VVzzrYKUFult09o/ky6hCHqqwqVxVfuw7anpcUSlmuX97CI9J6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs5MtyNgboN63o+w+o2rFSPYyRZudIVzeWj8ZV8PlD4=;
 b=hM+umgFQ8Ge1UapfOesA2fuV/H83x0gqXrivxpO7Z218CpLjtEidjdyJUIP6hizTn/+D/Ua0cBEvdBtNiBwVlxBQrqRjptZU1t/lUFMeqTDN7lWJpvL8FqxxDz6S1hvtBWcCDYqEn/gjIxyszFhRh10zRR+vC8NuplFOMR3tLyy/ErTGvQQAmlqUc1u+pD94Q2eVENj/AgcagBSb3yroQGO16EaIclp9tgNiKjceCdENgyTmm9TqaPKJzv4diSo5lCHZ3pWeQta27NmryRJVbdlO420a0rJTq9QVZCwUqbESnakow319LxqLh14Eg7TVardJKzH8QbArz9WqHCPrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs5MtyNgboN63o+w+o2rFSPYyRZudIVzeWj8ZV8PlD4=;
 b=jooKQP7Y9HPlpsMpCsyNXsrz42sUFEPjFbI5o19KbhpqEeQamtmjSpQ2QwUynJJqJAvLhLZmPaVQVArwLSqPKs2yMQWKg02jVJuMy17Ow0cDF7KR7PnsQNa5La25/pNpjDNFO6wF+VUUjtI3a3biy2HlOeN/uzggH//VkqY+BixSkEmxdJzyOJBwspCtyIRU0GBc5xhK/y1pBXeqzj62oCK3tJFjFfwQutAL1SJ3i5Wh/EupMY4oTA8okSWCHRYuHB2mrpJUaxcYWJgKEuY5ezfd50/MklZWPMx+lfT2F6H+NtLDiwo1IlI+A6y0m8/nfeDfwNqCUJNjV7nevtPHMg==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by IA1PR03MB8336.namprd03.prod.outlook.com (2603:10b6:208:5ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 02:33:17 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 02:33:17 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
Thread-Topic: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
Thread-Index: AQHdCId5dd8v3hu11kaAs6MfjIzgK7ZYP1UAgBQh34A=
Date: Tue, 14 Jul 2026 02:33:17 +0000
Message-ID: <f95cb82e-6bdc-45a0-845c-99253b0d4868@altera.com>
References:
 <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <7a861f08-6bfc-4ed8-b8ca-9f4317dde630@bootlin.com>
In-Reply-To: <7a861f08-6bfc-4ed8-b8ca-9f4317dde630@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|IA1PR03MB8336:EE_
x-ms-office365-filtering-correlation-id: 61fc37a3-ae99-4ca0-3641-08dee1504308
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|22082099003|18002099003|55112099003|4143699003|4133799003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info:
 FVuOmoYVv6Tw/Sk2YDB2T8G6DOCl+e0+FqmcECsa8U0lBilRG3OwByVngy+Ljmj2lc5C+Bisj1umgDejmCQ2I7NCz6pZ4fRsS0SYPlaT95I3rOfkB7IftFq6HrO8toRhOS/y8zpzfgTc2ca1FiW79XCspWTmiBn+stGvwvSFjb4m+4yXtHac6gjpFs8d9/wdPKv38aigqcUDpgacSkNlhmQJGPEAgi5OXPq3OR+xDm5u2lbwfZK20P+B+DzLT/0+H2RncGlyvRo/ZRzWyIGmpmW6OLeacpEvuyD9v5rfzedD8sw71myIyyvUQC7zg8AeQUwEKXmgiDN2IAtG5Qf+9Kcwd31Kydh6VVggZb5f7b0vb8bp38t3ekb+FnXNz/gfFLexPyEgBfnoYS4nytxegr2t14c05JyrmG0rvmTsRyWExWZ1AhrnPHHys9lXQfHj4SFfoBUO0yTQtiSrqEq51i65W9v7P32/iX9ql1NjazMREjwlSr2gQmbK4XNa2zsq1/JxCZyZSDkQJRXkQDfo/5Ecy6Nf0rHjp3d672X87hDO39kCgmIhbAX++o6WHbXXIPOz5JmkH1LYb6l+x/uz9D6W3ELDJHcZ9A9qGu+Jzx/G3G+5/acd2FhGj0wc4Dg69hVBSoya/8MFxYmro/WS8G70mvzD0kkUqXP5SfAsEIYxLld0C1qXzghq9l1/vSYO916pRX6kofCgMw5laiEIq22ZP8qY/RRv6jC6f2CaWCI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(22082099003)(18002099003)(55112099003)(4143699003)(4133799003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1RLbmJpdGZEdUJ1NDRvaEJQdHh0Z2RhdEtjOE84ZDhyZFpTaDJKQllqMDdT?=
 =?utf-8?B?UG5TZHE4dUNjU1pEMGZwUThTYkhmM3doUDVCMHJzc3Vic0RVTkNsb0RyMkYw?=
 =?utf-8?B?L2JQNXJnbmFGcjhPd2QyYmhjSFZJMWRZRm1YR0R0TWh1RFl5dEk5bTcwMUZn?=
 =?utf-8?B?cVNMOGQ1SldsZTMzckdMQkYxVDNvM3REZEpkRm9scmdkZzhMQjk1UCtyMEJy?=
 =?utf-8?B?SzFRT0gydnprYjBRS3JxZVFRWTBnNkZ2ZFp5MTBvaTk1VWo5VmJsRFFVQmtN?=
 =?utf-8?B?a2gyMW0yK0x2eUVEMDJjTkRuanh3SVcwdDhnS0pmelpKRWJsbDMzVDFLRnNX?=
 =?utf-8?B?VjRSRFdhbW9vY0xSbUVWN2FmVFdwM1QwMGl3RFI4aS9LWkd4cHh2YmJQOWxz?=
 =?utf-8?B?QjJWaE9XeGR1ZXgrcXdTd2ZHMVFOUjM4M2Fwbk0xZ04xeFR0L1ZjTnlub0JV?=
 =?utf-8?B?TDltSlFXSGdGbFU5cUliSVErWDJrWG9kTE1DSzQwdysxR05Ra0t0K3E5TWxk?=
 =?utf-8?B?aDhvUHkraEJ5d2Q5WllVYjF0QkRGZWxYSGhBMXh1L1NNZloyK2Yxa2d2NnFi?=
 =?utf-8?B?YlFnZlVWYWMwclhzb2F0dHlQZVB0QUpWMkYrUGFHV3NJMmdrM2dMOTdaN3Rv?=
 =?utf-8?B?OG5pdkx5Y1FxL1pCMlBUSkpoK3cxS3U4eWg1eW14ZkR5UHJIYlo0MnZBTDZK?=
 =?utf-8?B?SlVjSFVVMFRVS3Axb1JBczBRcUEzbkVFNFZyRzNKV214YXhWeVZySzVmbXBY?=
 =?utf-8?B?SWFLQzBYNk1BY2FuOUVRR1JocE1aQ0VBZ0JrVHFvQTJqQmR2QjZKY2JRVnRk?=
 =?utf-8?B?UyszQ0E2S0U1eTQwRUNFd1hXU3RDRklSVXROc0VOV1dqcXdGVDRpdWJISENn?=
 =?utf-8?B?bkZJcTM5WXl3Mm95emN1WTNaOWgzZzUvOWhueEhRejVJVk1VQnp2SUphRi9G?=
 =?utf-8?B?dXpyWmNxY0RKVVg3VGhNTXlVWHVUMzAvMFJKVUJTeHpQV0c2MW40QUtlUlFa?=
 =?utf-8?B?WGdwZ1VhdHF4OTgwSlhGcmpnZHZDaldaOUs5akVJc1licGF1WjdTT2tZZWFT?=
 =?utf-8?B?citpZmZVd1hTSDBDcFFjNjMyRjcvcGlBalBNK0pVdGozV0dTTTBTRUluZ2VZ?=
 =?utf-8?B?aHNVcHR4TkpROENYbThUZjFPZ0tYdDc1K1E3VzU0dzBjMTlLRHhEaEg3em5G?=
 =?utf-8?B?Qkg5RzZpbkFFVnZ6cGlDeEc1aHRFNG1UK2ZwdHd5ek1iUEpRdkc4UW9KTFY5?=
 =?utf-8?B?RzlZR3MzMFV0eC80blVDTUpTdUF4c3N2UjJJVDhLNlh3U0h5YXJ5OGdsS3lH?=
 =?utf-8?B?SFg4a1hpc3dKakYwR21hNzc3MDNIVWtreDJJam4zS1duVUpwNVhIYXlIMFZE?=
 =?utf-8?B?SERWdC9CajR1ZlVCK1BYcUwyK2RvTExYTXhtaHRCYytFL0xFZ3JVOGxMZ2gv?=
 =?utf-8?B?K1p0V2VySTZUMVd2VnBTaUxIM0N0Z1Y2K1Q1UGxCd3RDeWI1dE11dU5hMTlo?=
 =?utf-8?B?TW1hWUkyeVJqem4wU0p6YnhxOG1FRk1ITlIrL2lEenQ2TTdkY01tUFZvVUd3?=
 =?utf-8?B?T21SQytHU3YzOVVGa3Qwc05wZjFNMHZpYVdFOFlHSlFOVnUzcjJ2VUNNRjlT?=
 =?utf-8?B?TXh4cTh0aUNSNjdaL1ZEWWN4ZERQTHBaYkRBZjlidjExb2lheFJmZHRhbmFl?=
 =?utf-8?B?amRORFRNQjJFTlVGek1iYTFKeCs0eFRXSW1rcjJDUWNpWkhwcnlKMDNsN2s0?=
 =?utf-8?B?N3RSODNGQmU2SWJCTW43a3hJK0pFRjJ3SHp0NWcrS2RUUUk3V0dPMHpnT0R0?=
 =?utf-8?B?bXZJbDZvZVZOQ3NHdk56NHNhU3VLYW9BdVV6U3l6cDh4b3ZhOWhFb0YrcnRK?=
 =?utf-8?B?NHVXOFFDaUYzSXNsYlNvL3dsK1hwMVNkTkp5bm5oamtSOVFMTC9GRkFKODZ0?=
 =?utf-8?B?R285bE1KZHpRYUR1d01XeU1VVlFCZ1FRajYrUmFVREFVUmh1dW1jbEQrWjZP?=
 =?utf-8?B?U1NjVmhyYUVsbnZ6TFhLdzJ4OWNrUWpGZHJIbXJvMmhRdERYN3E3ZXdSNlA5?=
 =?utf-8?B?VDRTVXpYNFV5VGNvdUptTFJJZ1dxQzg5VUpMR2gvVTg1YVVTdG1WNzJITkxa?=
 =?utf-8?B?N3pKbkE4MkpJL0VoREhPOU0wVGRYaFdHa0VQc1VKWHRuWUcvV1IzRUdWNFN2?=
 =?utf-8?B?K3BZbkVRSC8xWUtacHU3cW1RMytwWU5nL0NJcHZXZ3N1bTh6YzA3SlR3bjho?=
 =?utf-8?B?ZUFiWDcvKzF1a0lOUnlWQ013S2NYTEhiVTV2eG9aK204SEduZ3BNcGp3MFU3?=
 =?utf-8?B?Y3VGK0lYTFVnbVQ2RmlZUFRkV0Z2aWdETUN3T2ZMMVRYZFFFNEYyaW00MXls?=
 =?utf-8?Q?8ENeFiHUbSdFf6wIfSNco+aYGOo5Kg4iYUeLeD6qtliNh?=
x-ms-exchange-antispam-messagedata-1: bbH3L0+H5qYXHw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <19632A62DFEBC34A8EC20DE2C4249A08@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc37a3-ae99-4ca0-3641-08dee1504308
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 02:33:17.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seKos5aGftyqQFAdTET5YJb2ToxLk5TQ/NeejGu9tEH98RPuj+GPfkdLHkhGoYeyQkG1S8FSv3QQFlRU/yws6SS7i/SQ3i9zlMUsbE7cGNz5I03NBVk+GRagkmqbJNEDg0+nSP+FU7cD7xyJ+BWHwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8336
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307338-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6650D75061B

T24gMS83LzIwMjYgMzowNiBwbSwgTWF4aW1lIENoZXZhbGxpZXIgd3JvdGU6DQo+IEhpLA0KPg0K
PiBPbiA2LzMwLzI2IDEzOjU2LCBtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFs
dGVyYS5jb20gd3JvdGU6DQo+PiBGcm9tOiBOYXppbSBBbWlydWwgPG11aGFtbWFkLm5hemltLmFt
aXJ1bC5uYXpsZS5hc21hZGVAYWx0ZXJhLmNvbT4NCj4+DQo+PiBUaGlzIHNlcmllcyBmaXhlcyB0
aHJlZSBidWdzIGluIHRoZSBzdG1tYWMgTDMvTDQgVEMgZmxvd2VyIGZpbHRlcg0KPj4gaW1wbGVt
ZW50YXRpb24gZm9yIHRoZSBYR01BQzIgY29yZS4gQWxsIHRocmVlIHBhdGNoZXMgdGFyZ2V0IG5l
dC4NCj4NCj4gQSBxdWljayBub3RlIG9uIHRoYXQsIEkgbm90aWNlZCBhbGwgeW91ciByZWNlbnQg
c2VyaWVzIG9uIHN0bW1hYyBhcmUNCj4gbWlzc2luZyB0aGUgdHJlZSB0YWcgaW4gdGhlIHN1Ympl
Y3QgbGluZS4gSXQgc2hvdWxkIGJlIHNvbWV0aGluZyBsaWtlDQo+DQo+ICAgW1BBVENIIG5ldCB2
MyAwLzNdIG5ldDogc3RtbWFjOiBMMy9MNCBmaWx0ZXIgYnVnIGZpeGVzDQo+DQo+IHlvdSBjYW4g
YWRkIGl0IHdoZW4gZ2VuZXJhdGluZyBwYXRjaGVzIHdpdGggOg0KPg0KPiBnaXQgZm9ybWF0LXBh
dGNoIC0tc3ViamVjdC1wcmVmaXg9J1BBVENIIG5ldC1uZXh0JyBzdGFydC4uZmluaXNoDQo+DQo+
IGNmIGh0dHBzOi8vZG9jcy5rZXJuZWwub3JnL3Byb2Nlc3MvbWFpbnRhaW5lci1uZXRkZXYuaHRt
bCNpbmRpY2F0aW5nLXRhcmdldC10cmVlDQo+DQo+IFlvdSBjYW4gYWxzbyB1c2UgYjQgZm9yIHRo
aXMuDQo+DQo+IFRoYW5rcywNCj4NCj4gTWF4aW1lDQo+DQpIaSBNYXhpbWUsDQoNCk9rIGxldCBt
ZSByZXBvc3QgaXQgd2l0aCB0aGUgZml4Lg0KDQpCUiwNCk5hemltDQo=

