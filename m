Return-Path: <netdev+bounces-278024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD4kFgG/3GliVwkAu9opvQ
	(envelope-from <netdev+bounces-278024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:01:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D95FC3EA215
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C3FA3009E1A
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D83126CD;
	Mon, 13 Apr 2026 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="JcC82EKk"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1D1D5160
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074476; cv=fail; b=qtJADY0kTQFLHTigS1UyLA66ulzqcPbeu6T1aTE1RUkKUKDd5pEhm+3N6UTakSFaD1rVX/Rfi8XFk+5C3tZi0F+liE8GnjFJ0dJEcVwhVejZnfIw0kna9xbhApnzCI/xij8nPmaNWWh+mJbWJjUTe8dZyefwNBiLXey+O1B83gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074476; c=relaxed/simple;
	bh=e06J8mhnWnAhLlzf7D9R4eIoRoR+IfN5cMIxHRupc8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ORRsEmeMY8VZE05TR9t2G8c3XfUmngg660wogCoWMfuhCkFmTjYKzm5aKdzQX1RB53NV6+zF5RzdrPl4XOyy5IUq0ON3zGiWKHRXQ1hGGEhwgbk8IW72wUckwr5PYZaht3EfW4fEBLalz28YA1l24cvQdYMssN9xI4gFQOL3+GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=JcC82EKk; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOt763d29PZZIXZBiz/lIdm1WlDrW3DpxFRxjRsYt8H2HDclgbR7bfcnf1YU5KLADVpYZl6p3c5YVtlPVc5hqum4WrNYECj0qNLeXZ++PA70Dj5WluP8iyLnqRJnIlAKSCK7hGOR8Uq/OkM4kcjJ+Zt/+6ZLF+ANHgEpcQkGgNUcG51DM+ujZ+0av/dZZi2uYwFj3PMIglSjhL9KLwFiffr9PTDIPDBmrUObJtbNNumL/Fpz2dEJLCJ7fcnADtm18d7aLwJSbeI3fyVeHnKcYM/B5bZ1AUI2FHcL8TW2AUqwZiQQfMFagKEfq6VzkKefWAVvkSh7/vRZVNQtWRIaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e06J8mhnWnAhLlzf7D9R4eIoRoR+IfN5cMIxHRupc8o=;
 b=HccNv2hg9GRGRP4zrOqqvvTFi5yL2zji8eNCyTT7MRqytIA0FM+dkS0ataotFCdvvAkc4Q7DrLA2Emip1wGO2MzxHtMvMRkBJQoS1/hYuwt7fy5cgtpqyqDyt9u1VaGmqTsU7Zp29tOB17NRV/zEkLPvGixvndGa5KKwFdhWpbGQM1g8pEA8kYlAAiF0+3eDI/p2boS8/mk57gJBO6x/R81rRR8FezRUiWTR4FZ3vl3Sje59wtaQDA2+MnEYG+EP77g1W5+mKTC0iW+704672WRfiaRGRMQNCdBuCIacywK5E8hNp6pgRvXZ1W3Wv6f1m5+Sj3wYrD+Nn0kQKo8exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e06J8mhnWnAhLlzf7D9R4eIoRoR+IfN5cMIxHRupc8o=;
 b=JcC82EKksEGPJ0ols0631pG5WojH0pOnPC565YHe/pmocxfkqn2pJkcjaj3BoM8Ibx9ysuG5VB4q5Tj+XUnGfUkLKEHy9sOEQbRhMrBuiJE6FboqZv9zRa7DhtMInlS0kzaIVEoS7Ny+SUn+C8po8xp4FpJvvSCi8+Rao4DJ4gglM2qJQZPHDVpXOdRc6OaTHNyBItu+2BcZCe3B1loT+cMvnVTO3thOMU8zQHfOyCW+fM03vXLtej+Pql0fzfuUyxEJhrdqmhdus17NCxEuuT6/PhA+GeYsvRuPTQMU14cVifmNJjns23OAeX4oAx0qV525PRZS+Y96mdArgHtovg==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PR3P189MB0860.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.48; Mon, 13 Apr 2026 10:01:10 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 10:01:09 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Ruide Cao <caoruide123@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "yifanwucs@gmail.com"
	<yifanwucs@gmail.com>, "tomapufckgml@gmail.com" <tomapufckgml@gmail.com>,
	"yuantan098@gmail.com" <yuantan098@gmail.com>, "bird@lzu.edu.cn"
	<bird@lzu.edu.cn>, "enjou1224z@gmail.com" <enjou1224z@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Topic: [PATCH net 1/1] tipc: validate Gap ACK blocks in STATE message
Thread-Index: AQHcyQU+q1pLJ6SEb0eVRh2lUE3uj7XcUDgwgAAzqYCAADn5kA==
Date: Mon, 13 Apr 2026 10:01:09 +0000
Message-ID:
 <GV1P189MB1988D2C15EF2E9E629DCAF74C6242@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <cover.1775809726.git.caoruide123@gmail.com>
 <1316452e465e9a96fce44ec15130a14f3872149f.1775809727.git.caoruide123@gmail.com>
 <GV1P189MB1988963A155568005A37BF7FC6242@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <7369ab71-e3bc-48ac-8165-439ad8595fc0@gmail.com>
In-Reply-To: <7369ab71-e3bc-48ac-8165-439ad8595fc0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PR3P189MB0860:EE_
x-ms-office365-filtering-correlation-id: 62326fa0-acdd-4250-3767-08de99439622
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 STAUz22apeFJuVvsPBsMKlqZgoxOqsOTxSlP59F419YsJ1DAaDMXo7x9Vf6DbEwkZgATgCm4Tyoa1B3hA/IO8BgqP7Sw9ZJ0iO/PQkZEruvnPi21JThe2eHDKFIRnp4cBILV9rrS6GMje10ibZ/LhoGGHzkFiVmNn+nbm1dEtoroVIMe8xJLe6ilvOWKIB71NU7KDPD5aAuprhrOzIHpp/EgflkxtlJDRlC9tcsiZChlYlDHP21mHyglTOXimZkAvLHV3p/lGiCZkQsSbdNCvKN9sw8LwCSI/P5aiUCSp73ch3yWXytwC8c7wDRt9pcLgUO8gJaIIN6KA4gtTuezAP1Jo2kxuc6c/cOMKS1QXbJ+B/QZIYvaLsMAQYBnns44fRmqp8HjSA1eAMoI+op5Gg0426yKfMSBmbawhZ80J1aNdcWefdGsqPJtdZiFBoFHkTpIl8syNxJZ8kr2yZu9GPt6+nGYouKOdCsr1ysMAiFQsE349J4nKIYjDH7ylnCmJaRSKyqnpc6qfDrkqwnjvjiEFU3Z9pWGSYUJ6UDQN2+gcJ2wB/RZi0R1JCZq713FT//i6uEX+hrFDYZ5lgS/NHM5Bnj4d8QpLHaGaNSPcEQT1LdZORZlGr3JRl/0lGR7zqYiszo19kqj8kk8ewRCnyvD2++ALlYaBuHnB5cRbc/Rq43Pj9QGAlXa9gXmaTZiq0n0+x0maBhsKnAI/855FwOHiN+Zcfb+hwJ6HrWbXhYrES8KtHiEi8bJpQI+Nc1ENx5g+o24t43S2xly0GkYas45qauUi9h7/WFQvlwYlg4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG9qZy9mQnAva2EwSmh6R0o0UWVKWlk5Tkwza0JFeG9xWjB4OXNoNlpDcFN2?=
 =?utf-8?B?d09nMXFmY1FkSWxnUVZTaTJpbmt0N1F1d1Vsdnp0dGRYOFhHZGN2MWk3cGM0?=
 =?utf-8?B?T1VhMWpmVGFJdGVtWk9nV0x4VVJ1aS9WekxCanoyN0VJY3U4aEJISXpFcCs3?=
 =?utf-8?B?MVJzeGlGdndtRWpYcWNOQ0RkSG5hbkp3NTZlSHRIemk0U295eFhCbUNZZUsz?=
 =?utf-8?B?cERNYVRUcmRtZmt3UjkzUjc1cEUweVNCUFJPMVc0Skk5U2tZZnhSSXNsR2F2?=
 =?utf-8?B?L0hRS2xrYmJ2Vzl4d0N1SWVEaHhybFlBOHZKaXlHZmUvaEIxb3lobkdqbmFw?=
 =?utf-8?B?TVN5VDV6ejJzNmVzNFNmY09RM010RVJWOXhpdjJsUWx1c2VwNUtLSXNLaEli?=
 =?utf-8?B?RjlQV1RjTzBCaHplMFpGRFNqUG5QR0h4dGoya2hOeGhDWDlGYzlEVHNFc3p2?=
 =?utf-8?B?VEFSTkkxV1pyTGRONnQ5NEVoc2hrL2tqWVErdlhEZFBSbVd6L1IzY1FJQTNu?=
 =?utf-8?B?T3ZCWnNVLyt6TUNpTFlTTXJuMVhEVVFIUi9qQWdEbFJHeXg0UWI2NS9xSXRG?=
 =?utf-8?B?TkpJbUVOTDg1UXJIM3JKWVAvSmVVRmpsTWc2VGdZZzlrYWhmVXgvKytSelBu?=
 =?utf-8?B?dytmVkdTYlNjL1ZvTnJqYXBrR25iNXQxRzRnUk5Oa3ppOTQ2djlnMjBQbjk4?=
 =?utf-8?B?a01FMUJGblNDcnF6SERkVXNBdXU5azFvRTQ4TVJpMW9CekRqcStsQVpXd29i?=
 =?utf-8?B?dU5BY1FoZStGcm12bHk1a3p2b3VyNzFHK0pUSHF1Y1UwWlFhRHoxMi9DTmdw?=
 =?utf-8?B?OUUwWHhLYTdaYzV2Y21oS3diYTJIY3ZCeldQRFBsb1FFQS9xTUtLM00wdlRp?=
 =?utf-8?B?MzNRSk1UTzJ2WDdrZU1UWXRHbWtKaTVwQlZ1QzRDZ0M3eHQwY2pUN25Sb3dn?=
 =?utf-8?B?VldWZkRGWTVoNjJCR3JIY2x2UWFwSHlidjdJNlNtRWg4Zm5jVXI4RFZMZk5t?=
 =?utf-8?B?NWtTSGRyZ1lkd0YrUENnUlpNUlpzVkxPeURDYVJXWWMzaFY5OXNlaGt2WHVu?=
 =?utf-8?B?cURQY2U1ek1oczh2UVRYaDBPaWNVRFZLZWM0cStvT0JGcWdrQnhuK3pVaVlE?=
 =?utf-8?B?TGJUcEhhczdra3hYbjZUTUh4MWRzQzZzczdNdXRXcmNCaWFVYmlUdlJ0OStm?=
 =?utf-8?B?Wkc4bnlOdkc1TGtBUUZtTUlGTTFTUXYzR0ZmcldoVEsxMUQvb1U0eEY2YXAv?=
 =?utf-8?B?Z3d1YzNOK0NCZndCdzAxZUZGbllOTW16Q1FJdWRibWF4eXdlT09jRmJFdzBk?=
 =?utf-8?B?MzYrVy85SnJmRE13bCtrbXJKaktaSFduOUUzQlVSUDNvOFh5NHplRnFDVU5G?=
 =?utf-8?B?eGlQczhlZ0dhc1kvTCtEV1ZIbVlIL2xzRjB1MDJCdFVTTUtIazFzYWZzRGVq?=
 =?utf-8?B?TG1hSEN1S1E2VlMxUkhGT25TanhUMHhpOUU3L3hheGpyK3lZQUlXbFFDY25G?=
 =?utf-8?B?cTh1cHN2cndZZ28xTWp0ckJyQkxKNHNJZDE1SzhQQTdOR3U0UlR6Nm4zK3lC?=
 =?utf-8?B?UndCR0hHdGZ0elluM0FIeXl2QWdDWEVicXFyNUVXZXR3SC9Ud0Zja2E1L01L?=
 =?utf-8?B?YTZEL28ydzJyZThxdnJvT0xZRHNUUzJCSUwzd3pGcGVuK2s4VE1hekRhYVN5?=
 =?utf-8?B?Z3VVMVdvY0VSUDFveU0rckdSbHlpdkNtdmtLdlFJTVNMRU9NVGpTTUNNc2tL?=
 =?utf-8?B?L2FLL3JvU1ZQQ0E3QjVmVkdSZWxwUHYvVzBBUktDM0pyMmg1b01FSUkrTG5j?=
 =?utf-8?B?R2Z2Vzg5ZkFHZnZQM2VWSG1wS3Nqd3JaZ2RTY2lkVXJXb1BmTFRXR0x2SXJl?=
 =?utf-8?B?WDM3NjFoS0VlMURGYU02QnRPNklrbVdac1NkOEdhZ01hck1JZldMSFpjajFJ?=
 =?utf-8?B?K3VzSEwrejkzL1UvY1BiT3JsVXRaWlkvNXR0Sk1ZUEZVU29CMElxUEVsMUhK?=
 =?utf-8?B?bmd4ZG5TV2U4bzh5NUpML3hubmpSMkJ3bEZpRGJoakpXbXFEeWRyaVl0T1hZ?=
 =?utf-8?B?NUhHQ0x4YmdLY3BwU05LS2tRek9GZ1VYSGlJVklFVTlGbmRReGxLYzVqWjRO?=
 =?utf-8?B?Q1FVeksxemFYbWlNVEE0Lzdiai9xOThCQXhXOE1BdGtVbkRsRDE1U01WOGl6?=
 =?utf-8?B?M2tYc25HdFpyMEVkVVFXK2RuaTlUZFFYdUlUaE9qNzRPUDd1N3ZYN3dZM1Nx?=
 =?utf-8?B?dzRIdSt3aTl3RnRydXFjbWNmZ0NWQ0FTeXZJRERpOGpwNnR5aHFsWklHYTBG?=
 =?utf-8?B?WHl1QkI2Zjd1NzFHcXB6QVJXcURVODlYdjYxK3pwREc2VGdZaHJ4Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 62326fa0-acdd-4250-3767-08de99439622
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 10:01:09.3266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an0q1ZaGtgSeT6T9J+di6BYLWDwbIuwJGrcLU0O6FsvT2ongnu6VpgBmXsgmKh8RcH0M1EdgPBSE2ZBRzxXBJ4CQly1nSq1A5PEd7aW5KA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0860
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278024-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,gmail.com,lzu.edu.cn,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,est.tech:dkim,GV1P189MB1988.EURP189.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: D95FC3EA215
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PlN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0IDEvMV0gdGlwYzogdmFsaWRhdGUgR2FwIEFDSyBibG9j
a3MgaW4gU1RBVEUgbWVzc2FnZQ0KPg0KPg0KPk9uIDQvMTIvMjAyNiA4OjA2IFBNLCBUdW5nIFF1
YW5nIE5ndXllbiB3cm90ZToNCj4+PiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDEvMV0gdGlwYzogdmFs
aWRhdGUgR2FwIEFDSyBibG9ja3MgaW4gU1RBVEUNCj4+PiBtZXNzYWdlDQo+Pj4NCj4+PiBGcm9t
OiBSdWlkZSBDYW8gPGNhb3J1aWRlMTIzQGdtYWlsLmNvbT4NCj4+Pg0KPj4+IHRpcGNfZ2V0X2dh
cF9hY2tfYmxrcygpIHJlYWRzIGxlbiwgdWdhY2tfY250IGFuZCBiZ2Fja19jbnQgZGlyZWN0bHkN
Cj4+PiBmcm9tDQo+Pj4gbXNnX2RhdGEoaGRyKSBiZWZvcmUgdmVyaWZ5aW5nIHRoYXQgYSBTVEFU
RSBtZXNzYWdlIGFjdHVhbGx5IGNvbnRhaW5zDQo+Pj4gdGhlIGZpeGVkIEdhcCBBQ0sgYmxvY2sg
aGVhZGVyIGluIGl0cyBsb2dpY2FsIGRhdGEgYXJlYS4NCj4+Pg0KPj4+IEEgcGVlciB0aGF0IG5l
Z290aWF0ZXMgVElQQ19HQVBfQUNLX0JMT0NLIGNhbiBzZW5kIGEgc2hvcnQgU1RBVEUNCj4+PiBt
ZXNzYWdlIHdpdGggYSBkZWNsYXJlZCBUSVBDIHBheWxvYWQgc2hvcnRlciB0aGFuIHN0cnVjdA0K
Pj4+IHRpcGNfZ2FwX2Fja19ibGtzIGFuZCBzdGlsbCBhcHBlbmQgYSBmZXcgcGh5c2ljYWwgYnl0
ZXMgYWZ0ZXIgdGhlDQo+Pj4gaGVhZGVyLiBUaGUgaGVscGVyIHRoZW4gdHJ1c3RzIHRob3NlIGJ5
dGVzIGFzIEdhcCBBQ0sgbWV0YWRhdGEsIGFuZA0KPj4+IHRoZSBmb3JnZWQgYmdhY2tfY250L2xl
biB2YWx1ZXMgY2FuIGRyaXZlIHRoZSBicm9hZGNhc3QgcmVjZWl2ZSBwYXRoIGludG8NCj5rbWVt
ZHVwKCkgYmV5b25kIHRoZSBza2IgYm91bmRhcnkuDQo+PiBDYW4geW91IGV4cGxhaW4gaG93IHRo
YXQgcGVlciBjYW4gYWx0ZXIgdGhlIFNUQVRFIG1lc3NhZ2UgPyBJZiBpdCBjYW4sIHdoYXQNCj5j
b25jcmV0ZSB2YWx1ZXMgYXJlIHVzZWQgIGFuZCBvbiB3aGF0IGZpZWxkcyBvZiB0aGUgU1RBVEUg
bWVzc2FnZXMgPw0KPg0KPlRoYW5rcyBmb3IgdGhlIHJldmlldy4NCj4NCj5UbyBjbGFyaWZ5LCB0
aGUgcGVlciBpcyBub3QgImFsdGVyaW5nIiBhbiBhbHJlYWR5IHJlY2VpdmVkIFNUQVRFIG1lc3Nh
Z2U7IGl0IGlzDQo+YWN0aXZlbHkgc2VuZGluZyBhIG1hbGZvcm1lZCBMSU5LX1BST1RPQ09ML1NU
QVRFX01TRyBhZnRlciB0aGUgbGluayBoYXMNCj5hbHJlYWR5IG5lZ290aWF0ZWQgdGhlIFRJUENf
R0FQX0FDS19CTE9DSyBjYXBhYmlsaXR5Lg0KPg0KPkNvbmNyZXRlbHksIHRoZSBjcmFmdGVkIFNU
QVRFIG1lc3NhZ2UgaXMgc2VudCB3aXRoIGEgbW9kaWZpZWQgbXNnX3NpemUgc28gdGhhdA0KPm1z
Z19kYXRhX3N6KGhkcikgaXMgMCwgYnV0IHRoZSBhY3R1YWwgVURQIHBheWxvYWQgc3RpbGwgY2Fy
cmllcyBleHRyYSBwaHlzaWNhbA0KPmJ5dGVzIGFmdGVyIHRoZSA0MC1ieXRlIFRJUEMgaGVhZGVy
LiBUaG9zZSBieXRlcyBhcmUgdGhlbiBpbnRlcnByZXRlZCBhcyB0aGUNCj5maXhlZCBHYXAgQUNL
IGhlYWRlci4gRm9yIGV4YW1wbGU6DQo+wqAgbGVuwqAgwqAgwqAgwqA9IDB4MDdmYw0KPsKgIHVn
YWNrX2NudCA9IDB4ZmYNCj7CoCBiZ2Fja19jbnQgPSAweGZmDQo+DQpJdCBpcyBzdXJwcmlzaW5n
IHRoYXQgeW91IGNhbiBtb2RpZnkgYW55IGZpZWxkIHlvdSB3YW50IGluIHRoZSBUSVBDIG1lc3Nh
Z2UuIEkgZG8gbm90IHRoaW5rIHRoYXQgY3VycmVudCBUSVBDIGNvZGUgY2FuIGhhbmRsZSB0aGlz
IGNvcnJ1cHQgbWVzc2FnZSAuDQpDYW4geW91IHNlbmQgbWUgdGhlIHN0YWNrIHRyYWNlIGF0IHJl
Y2VpdmluZyBwZWVyIHdoZW4gcmVhbCBjcmFzaCBoYXBwZW5zIGFmdGVyIHlvdSBzZW5kIHRoZSAi
Y3JhZnRlZCIgc3RhdGUgbWVzc2FnZSA/DQo+VGhlc2UgdmFsdWVzIGFyZSBzcGVjaWZpY2FsbHkg
Y2hvc2VuIHNvIHRoYXQgdGhlIGV4aXN0aW5nIHNhbml0eSBjaGVjayByZW1haW5zDQo+aW50ZXJu
YWxseSBjb25zaXN0ZW50Og0KPsKgIHN0cnVjdF9zaXplKHAsIGdhY2tzLCAweGZmICsgMHhmZikg
PT0gMHgwN2ZjDQo+DQo+VGhlcmVmb3JlLCB0aGUgZXhpc3Rpbmcgc2FuaXR5IGNoZWNrIGRvZXMg
bm90IHJlamVjdCB0aGlzIGNhc2UuIEl0IG9ubHkgY2hlY2tzIHRoZQ0KPnNlbGYtY29uc2lzdGVu
Y3kgb2YgdGhlIGF0dGFja2VyLWNvbnRyb2xsZWQgR2FwIEFDSyBmaWVsZHM7IGl0IGNvbXBsZXRl
bHkgZmFpbHMgdG8NCj5jaGVjayBpZiB0aGUgZGVjbGFyZWQgR2FwIEFDSyByZWNvcmQgYWN0dWFs
bHkgZml0cyBpbnNpZGUgdGhlIGVuY2xvc2luZyBTVEFURQ0KPm1lc3NhZ2UncyBsb2dpY2FsIHBh
eWxvYWQgbGVuZ3RoLg0KPg0KPj4+IEZpeCB0aGlzIGJ5IHJlamVjdGluZyBHYXAgQUNLIHBhcnNp
bmcgdW5sZXNzIHRoZSBsb2dpY2FsIFNUQVRFDQo+Pj4gcGF5bG9hZCBpcyBsYXJnZSBlbm91Z2gg
dG8gY292ZXIgdGhlIGZpeGVkIGhlYWRlciwgYW5kIGJ5IHJlamVjdGluZw0KPj4+IGRlY2xhcmVk
IEdhcCBBQ0sgbGVuZ3RocyB0aGF0IGFyZSBzbWFsbGVyIHRoYW4gdGhlIGZpeGVkIGhlYWRlciBv
ciBsYXJnZXINCj50aGFuIHRoZSBsb2dpY2FsIHBheWxvYWQuDQo+Pj4gUmV0dXJuIDAgZm9yIGlu
dmFsaWQgbGVuZ3RocyBzbyBtYWxmb3JtZWQgR2FwIEFDSyBkYXRhIGlzIG5vdCB0cmVhdGVkDQo+
Pj4gYXMgYSB2YWxpZCBwYXlsb2FkIG9mZnNldCwgYW5kIGRyb3AgdW5pY2FzdCBTVEFURSBtZXNz
YWdlcyB0aGF0DQo+Pj4gYWR2ZXJ0aXNlIEdhcCBBQ0sgc3VwcG9ydCBidXQgc3RpbGwgeWllbGQg
YW4gaW52YWxpZCBHYXAgQUNLIGxlbmd0aC4NCj4+PiBUaGlzIGtlZXBzIG1hbGZvcm1lZCBHYXAg
QUNLIGRhdGEgaWdub3JlZCB3aXRob3V0IG1pc2FsaWduaW5nIG1vbml0b3INCj5wYXlsb2FkIHBh
cnNpbmcuDQo+Pj4NCj4+PiBGaXhlczogZDc2MjZiNWFjZmY5ICgidGlwYzogaW50cm9kdWNlIEdh
cCBBQ0sgYmxvY2tzIGZvciBicm9hZGNhc3QNCj4+PiBsaW5rIikNCj4+PiBDYzogc3RhYmxlQGtl
cm5lbC5vcmcNCj4+PiBSZXBvcnRlZC1ieTogWWlmYW4gV3UgPHlpZmFud3Vjc0BnbWFpbC5jb20+
DQo+Pj4gUmVwb3J0ZWQtYnk6IEp1ZWZlaSBQdSA8dG9tYXB1ZmNrZ21sQGdtYWlsLmNvbT4NCj4+
PiBDby1kZXZlbG9wZWQtYnk6IFl1YW4gVGFuIDx5dWFudGFuMDk4QGdtYWlsLmNvbT4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBZdWFuIFRhbiA8eXVhbnRhbjA5OEBnbWFpbC5jb20+DQo+Pj4gU3VnZ2Vz
dGVkLWJ5OiBYaW4gTGl1IDxiaXJkQGx6dS5lZHUuY24+DQo+Pj4gVGVzdGVkLWJ5OiBSZW4gV2Vp
IDxlbmpvdTEyMjR6QGdtYWlsLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBSdWlkZSBDYW8gPGNh
b3J1aWRlMTIzQGdtYWlsLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBSZW4gV2VpIDxuMDVlY0Bs
enUuZWR1LmNuPg0KPj4+IC0tLQ0KPj4+IG5ldC90aXBjL2xpbmsuYyB8IDE2ICsrKysrKysrKysr
KysrLS0NCj4+PiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9uZXQvdGlwYy9saW5rLmMgYi9uZXQvdGlwYy9saW5r
LmMgaW5kZXgNCj4+PiA0OWRmYzA5OGQ4OWIuLjQ0Njc4ZDk4OTM5YQ0KPj4+IDEwMDY0NA0KPj4+
IC0tLSBhL25ldC90aXBjL2xpbmsuYw0KPj4+ICsrKyBiL25ldC90aXBjL2xpbmsuYw0KPj4+IEBA
IC0xNDE1LDEyICsxNDE1LDIyIEBAIHUxNiB0aXBjX2dldF9nYXBfYWNrX2Jsa3Moc3RydWN0DQo+
Pj4gdGlwY19nYXBfYWNrX2Jsa3MgKipnYSwgc3RydWN0IHRpcGNfbGluayAqbCwNCj4+PiAJCQkg
IHN0cnVjdCB0aXBjX21zZyAqaGRyLCBib29sIHVjKQ0KPj4+IHsNCj4+PiAJc3RydWN0IHRpcGNf
Z2FwX2Fja19ibGtzICpwOw0KPj4+IC0JdTE2IHN6ID0gMDsNCj4+PiArCXUxNiBzeiA9IDAsIGRs
ZW4gPSBtc2dfZGF0YV9zeihoZHIpOw0KPj4+DQo+Pj4gCS8qIERvZXMgcGVlciBzdXBwb3J0IHRo
ZSBHYXAgQUNLIGJsb2NrcyBmZWF0dXJlPyAqLw0KPj4+IAlpZiAobC0+cGVlcl9jYXBzICYgVElQ
Q19HQVBfQUNLX0JMT0NLKSB7DQo+Pj4gKwkJdTE2IG1pbl9zeiA9IHN0cnVjdF9zaXplKHAsIGdh
Y2tzLCAwKTsNCj4+PiArDQo+Pj4gKwkJaWYgKGRsZW4gPCBtaW5fc3opDQo+Pj4gKwkJCWdvdG8g
aWdub3JlOw0KPj4gVGhpcyBjaGVja2luZyBpcyByZWR1bmRhbnQgYmVjYXVzZSB3aXRoIGV4aXN0
aW5nIHNhbml0eSBjaGVja2luZywgdGhlIGludmFsaWQNCj5nYXAgQUNLIGJsb2NrcyB3aWxsIG5v
dCBiZSB1c2VkIHRvIHJlbGVhc2UgYWNrZWQgbWVzc2FnZXMgaW4gdHJhbnNtaXQgcXVldWUuDQo+
DQo+VGhlIGBkbGVuIDwgbWluX3N6YCBjaGVjayBpcyByZXF1aXJlZCBiZWNhdXNlIHRoZSBleGlz
dGluZyBzYW5pdHkgY2hlY2sgYWxyZWFkeQ0KPmRlcmVmZXJlbmNlcyBgcC0+bGVuYCwgYHAtPnVn
YWNrX2NudGAsIGFuZCBgcC0+YmdhY2tfY250YC4NCkluIHRoZSAgY2FzZSBvZiBkbGVuID4gcC0+
bGVuICBhbmQgIHAtPmxlbiAgPSAweDA3ZmMsICBwLT51Z2Fja19jbnQgPSAweGZmLCBwLT5iZ2Fj
a19jbnQgPSAweGZmIChTZW5kZXIgbW9kaWZpZWQgb3Iga2VwdCBkbGVuIGFuZCBtb2RpZmllZCB0
aGUgcmVtYWluaW5nIDMgZmllbGRzKSwNCmhvdyBjb3VsZCB5b3VyIGFib3ZlIGFuZCBzdWJzZXF1
ZW50IHNhbml0eSBjaGVja3MgdmFsaWRhdGUgcC0+bGVuLCBwLT5iZ2Fja19jbnQgYW5kIHAtPnVn
YWNrX2NudCA/DQo+V2l0aG91dCB0aGlzIG5ldyBjaGVjaywgYW4gT3V0LW9mLUJvdW5kcyAoT09C
KSByZWFkIG9jY3VycyBiZWZvcmUgdGhlIG9sZA0KPnNhbml0eSBjaGVjayBldmVuIGhhcyBhIGNo
YW5jZSB0byBydW4uDQo+DQo+Pj4gKw0KPj4+IAkJcCA9IChzdHJ1Y3QgdGlwY19nYXBfYWNrX2Js
a3MgKiltc2dfZGF0YShoZHIpOw0KPj4+IAkJc3ogPSBudG9ocyhwLT5sZW4pOw0KPj4+ICsJCWlm
IChzeiA8IG1pbl9zeiB8fCBzeiA+IGRsZW4pIHsNCj4+PiArCQkJc3ogPSAwOw0KPj4+ICsJCQln
b3RvIGlnbm9yZTsNCj4+PiArCQl9DQo+PiBUaGlzIGNoZWNraW5nIGlzIHJlZHVuZGFudC4gRXhp
c3Rpbmcgc2FuaXR5IGNoZWNraW5nIGlzIGdvb2QgZW5vdWdoLg0KPg0KPlRoZSBgc3ogPCBtaW5f
c3ogfHwgc3ogPiBkbGVuYCBjaGVjayBpcyBub3QgcmVkdW5kYW50IGJlY2F1c2UgdGhlIG9sZCBz
YW5pdHkNCj5jaGVjayBjb21wbGV0ZWx5IGZhaWxzIHRvIHZlcmlmeSBpZiB0aGUgZGVjbGFyZWQg
R2FwIEFDSyBsZW5ndGgNCj4oYHN6YCkgYWN0dWFsbHkgZml0cyBpbnNpZGUgdGhlIGVuY2xvc2lu
ZyBTVEFURSBtZXNzYWdlJ3MgbG9naWNhbCBwYXlsb2FkIGxlbmd0aA0KPihgZGxlbmApLg0KPg0K
PldpdGhvdXQgY2hlY2tpbmcgYWdhaW5zdCBgZGxlbmAsIGFuIGludGVybmFsbHkgY29uc2lzdGVu
dCBzcG9vZmVkIHBhY2tldCB3aWxsDQo+cGFzcyB0aGUgb2xkIGNoZWNrIGFuZCBjYXVzZSBPT0Ig
cmVhZHMgZHVyaW5nIHRoZSBzdWJzZXF1ZW50IGJsb2NrIHBhcnNpbmcuDQo+DQo+Pj4gKw0KPj4+
IAkJLyogU2FuaXR5IGNoZWNrICovDQo+Pj4gCQlpZiAoc3ogPT0gc3RydWN0X3NpemUocCwgZ2Fj
a3MsIHNpemVfYWRkKHAtPnVnYWNrX2NudCwgcC0NCj4+Pj4gYmdhY2tfY250KSkpIHsNCj4+PiAJ
CQkvKiBHb29kLCBjaGVjayBpZiB0aGUgZGVzaXJlZCB0eXBlIGV4aXN0cyAqLyBAQCAtDQo+Pj4g
MTQzNCw2ICsxNDQ0LDggQEAgdTE2IHRpcGNfZ2V0X2dhcF9hY2tfYmxrcyhzdHJ1Y3QgdGlwY19n
YXBfYWNrX2Jsa3MNCj4+PiAqKmdhLCBzdHJ1Y3QgdGlwY19saW5rICpsLA0KPj4+IAkJCX0NCj4+
PiAJCX0NCj4+PiAJfQ0KPj4+ICsNCj4+PiAraWdub3JlOg0KPj4+IAkvKiBPdGhlciBjYXNlczog
aWdub3JlISAqLw0KPj4+IAlwID0gTlVMTDsNCj4+Pg0KPj4+IEBAIC0yMjcwLDcgKzIyODIsNyBA
QCBzdGF0aWMgaW50IHRpcGNfbGlua19wcm90b19yY3Yoc3RydWN0IHRpcGNfbGluaw0KPj4+ICps
LCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPj4+IAljYXNlIFNUQVRFX01TRzoNCj4+PiAJCS8qIFZh
bGlkYXRlIEdhcCBBQ0sgYmxvY2tzLCBkcm9wIGlmIGludmFsaWQgKi8NCj4+PiAJCWdsZW4gPSB0
aXBjX2dldF9nYXBfYWNrX2Jsa3MoJmdhLCBsLCBoZHIsIHRydWUpOw0KPj4+IC0JCWlmIChnbGVu
ID4gZGxlbikNCj4+PiArCQlpZiAoZ2xlbiA+IGRsZW4gfHwgKChsLT5wZWVyX2NhcHMgJiBUSVBD
X0dBUF9BQ0tfQkxPQ0spICYmDQo+Pj4gIWdsZW4pKQ0KPj4gVGhpcyBjaGVja2luZyBpcyByZWR1
bmRhbnQuIEV4aXN0aW5nIHNhbml0eSBjaGVja2luZyBpcyBnb29kIGVub3VnaC4NCj4NCj5UaGUg
dW5pY2FzdCBjYWxsZXItc2lkZSBkcm9wIGAoKGwtPnBlZXJfY2FwcyAmIFRJUENfR0FQX0FDS19C
TE9DSykgJiYNCj4hZ2xlbilgIGlzIGFsc28gbmVjZXNzYXJ5LiBPbmNlIHRoZSBjYXBhYmlsaXR5
IGlzIG5lZ290aWF0ZWQsIGEgdmFsaWQgR2FwIEFDSw0KPnJlY29yZCBNVVNUIGhhdmUgYXQgbGVh
c3QgdGhlIGZpeGVkIDQtYnl0ZSBoZWFkZXIuIElmIGBnbGVuID09IDBgIGZyb20gc3VjaCBhDQo+
cGVlciwgaXQgaW5kaWNhdGVzIGEgbWFsZm9ybWVkIHBheWxvYWQuDQo+DQo+VGhlIFNUQVRFIG1l
c3NhZ2UgbXVzdCBiZSBkcm9wcGVkIGhlcmUgc28gaXQgaXMgbm90IHBhc3NlZCBvbiB0bw0KPmB0
aXBjX21vbl9yY3YoKWAgYXMgaWYgbW9uaXRvciBkYXRhIHN0YXJ0ZWQgYXQgYGRhdGEgKyAwYCwg
d2hpY2ggd291bGQgbWlzYWxpZ24NCj50aGUgbW9uaXRvciBwYXlsb2FkIHBhcnNpbmcuDQo+DQo+
Pj4gCQkJYnJlYWs7DQo+Pj4NCj4+PiAJCWwtPnJjdl9ueHRfc3RhdGUgPSBtc2dfc2Vxbm8oaGRy
KSArIDE7DQo+Pj4gLS0NCj4+PiAyLjM0LjENCj4+Pg0K

