Return-Path: <netdev+bounces-299758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hXTpLfDzMGrFZQUAu9opvQ
	(envelope-from <netdev+bounces-299758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:57:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DE668CAD4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:57:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=GtJJHujN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299758-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBAD130B76CD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B82314D14;
	Tue, 16 Jun 2026 06:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4621FC7FB;
	Tue, 16 Jun 2026 06:57:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593030; cv=fail; b=fX7lT+tBRTWBTPzhCIx3XdJH9F5d406rbVZXX7O73RkaLBV4mzPemrdWCcXAGEAfYd0L5vO7unwAW1J0AIc4UU073015bYhuUUTPGyhS5HYCsL/rEvUgHTNrMQDf26QH/YoMqKrOULXNW/miQBJRh/hbkvOknvXdQw/ozH7yCIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593030; c=relaxed/simple;
	bh=es0Onm8RCFqQS414isxjdx71AkLvyokrOyvrlzBFvyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dL5yLw+eo0wB44eUpDeP73ASuRW+Wlk6S4Xqp/WYmMUtEImeo7KKlEn0sbxpIbI/xNYZ1sjBgxWVHpdYGSEauPXVa48he4+1DWiER+UEeh+sGr2J7sXVovdcE6rxqltqpoXRtxfEAd0oTeif/IHuyVSFKOmhi0pLt6PDgOhmspY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GtJJHujN; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ1Wb8rLto3p+pPC6wObwBU81swww3YwZKvnIf8wBOW+RMdrkMQbhyp7/e0s8SQUB0eBHPY5+Ezo7vzeIl1v+Z7HyKF2zYW1jwAr6YedsFPAubReOED9h/0C06oTXUaId0/AM52k2vSLUZC6rkVBsdqrFgZLPhE+Xx+ZhOqAkci4XGJ/phlRZscUb5aEORFUFCUi0731n7o+ZdgjUNB3/sWNF88sm+Bxbrw1pksJrVqNaSyIqb55/Q9HsVUM8TbAFQHsgdSFdroHBB0Hu07HyWNdjWx70g+KL4B+L74DRJKFK72vCP/xOhSWHiafshoISDJCzcIWtcG8A7vsaf+flw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es0Onm8RCFqQS414isxjdx71AkLvyokrOyvrlzBFvyA=;
 b=srP8gZHgb2nn1QVaeNWRKZ7Uz+VjEAmjG84LW329yQrX43WpPie5TlvOvwD2aXwbai//TiXKLoDmQ280XTw7x1s1YUwf0xFfoelVKkgeJJwZTVTf17w0v7S6Jr0iRUoHZWJZ3c+DKtZazjNX0rWII1wJHlszMkugaIVrz4HxMTymdPmMXe0GBYNZhkL+zdMhNiqo4sJ2bWp3r+/5tqprJHPZ4YOn8A3vSlIUyo2ooljKkAxvgRQFH03PDDWBpk1ta2/22e1RepQmCk7b7osuhW5IqldqxPBMHNQoCbw1yLiSzJs+5LjfjeVuhOi+lrjK87ZzogL2wh0sfgdo1LuEDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es0Onm8RCFqQS414isxjdx71AkLvyokrOyvrlzBFvyA=;
 b=GtJJHujNefSUImEWehGArondBU5U7CFB4Vsccs7A1vVmSJx8DbiuDoYV/8CWbB6dDHduCkJ0TBQd2Amnm2OipS8Hb/LrKHiIbYknjFcsTHKN4y/IfcimDpcZ/x8ybnIBDfvBQG1vEwh/amx1iC2oWWoE/DSxV6hBA8HnZQtwXElq2+50BWqsBtHtACB3Ls2LeQ1j7PMGFqWWrWaPjjzyo+JLky8qysur4i5r/aSNnh/AH72jdL3Z6BtNK3LA8ajWc4ynj/rI/0GqD1EE0k3Qkl6G2dgSZxS+iBtmm852wjFDE+yqF85O3KnTfph0Ur2PV5/bct7OumXnwJdWYdD7dA==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by SJ0PR03MB6391.namprd03.prod.outlook.com (2603:10b6:a03:38d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:57:04 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 06:57:04 +0000
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
Thread-Index: AQHc/UhdtUECrMP14EyouxbPwJD//bZAsegAgAAON4A=
Date: Tue, 16 Jun 2026 06:57:04 +0000
Message-ID: <d71a892f-1296-48be-b9fb-229582b14289@altera.com>
References:
 <20260616042655.7782-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <fbe4294d-98af-4817-97de-9b20df89a240@bootlin.com>
In-Reply-To: <fbe4294d-98af-4817-97de-9b20df89a240@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|SJ0PR03MB6391:EE_
x-ms-office365-filtering-correlation-id: 37b7f240-20f2-43a3-ebb4-08decb74796b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|38070700021|22082099003|18002099003|55112099003|6133799003|56012099006|4143699003|3023799007|4133799003|11063799006;
x-microsoft-antispam-message-info:
 pytRWGwySC2/Jb7ndY4gWDUeVrqY5LXiJ+ldc5B19g0dDg0maEOu6qT4fchmuhV94dJ42qVU62sZS0tL6KURVXRPyZlEDLMJBG/dN+KO35Nu6+FdLJNlYPDtziMGuWFl2/yPg2vboDQ9leMWpwZN2sZXpBxYxbKiBipHKpLUo2PwUBQqJvC6Hty4zWxgJ5+p6BZHJAVjTwji9rjEXcuE4YaHTkUpqrBkv3xT0QAz0SFz7T2ULATg0j03ReqAf/YQXYMNU+VLuPsl2lTYERECgabs9H85ZGzbczSQ+INxkpGicZ1qcmtbWfob0Qv6CaeSGmWYxX7xIuxAfrRn63YMu74viLWnnCNZlAJFTS87rC8rnHfj1w24OH3D5k2hASBsq5ScmnOj0p0av8PMKSOLLBR+/C/tT87PFmaKhSt4r+rJlfTNZCsBGxjGJ6/5CwzTcRnikHmQaNhwNxZ74PTRo46Ab9RrFQza9gvT0k1m2JGzgpoXe9bn6eHRxK2b2SV4gmwjyQK+H8L5bdv5y+T4J77k5puMkibgqQGdyUZlNBjjXpeZKxhE+421QZxZJXv3DYLIw3KJDDDUF/WpirVXY3CEkgnmRvBr6ejveC+bO6B1IDiHcwE5p6Sjol6Dw7aorzPe6MoFiahzLRlpvAfsAYg7DLsAuJDghkb9xReKHfCjb8/pEBvtQkf0p/bHkr204c90qHrrI2TymanQRaKXQQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(18002099003)(55112099003)(6133799003)(56012099006)(4143699003)(3023799007)(4133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnNHeTNrNkkyS0ExVnFEVTUzbE5pMFdDcjBlL2wxVGRRZVA3YXU3TzYzTUdO?=
 =?utf-8?B?NUZaeGpHUVovUVlvMVlxVmQ3Q1ppV0NvanpPeUUvS0VyOUVrOHNYa1BXQnpL?=
 =?utf-8?B?c0JpdUJ0OUNwbVIzN3krNndoM09VN2FsbTVjTWNWazhIeFo2MlV2TW1oVVAz?=
 =?utf-8?B?VUNYNGJLZnc4Z2FqbThjR1dYRGx0dUxNZXN5ZnVwZW5iTm8ycitsVFlvWmxV?=
 =?utf-8?B?aFN3VTBBcS8yQXBZUVZpU3RzeEN3QTlIZFBpOTFPWVNLRGpFZVRoRm4wR2JI?=
 =?utf-8?B?UXd6Q2o4L3BXSlUwcVlVWlJsejAxN29rLzhhaHplbUl5cDlkaGs2WFBSN1k0?=
 =?utf-8?B?QmJXQlBPZUJVeEJ1ZHQyVVV5Nkt6TkdOTHZLcnh2azFOZnl1ZGdXNjFHMzBi?=
 =?utf-8?B?THFSbFdxbWlRbjl4Z2UzTjd2Uzg3SzhjcjdvdTY3M3JwMEJvbUIyTXNhRm1w?=
 =?utf-8?B?bkZhckYzQjNneWJERU5jYzhZdkZtSXVLTFNPT3MrV0JsMzdQb1NqQ0VpQW13?=
 =?utf-8?B?QmthWnhNYk9aNUNNYXBDdVlsRkhyVy9Hc1RDQUFud0lCZEdXK0dwakNBVDZr?=
 =?utf-8?B?NVk5YUVVWkZralN6WWRJV2d1VmdqVmNNdURVRUFlOU8xVEpYNTBmblcwMWwr?=
 =?utf-8?B?TktCZ1piTGZpR3hvZVZUS2JsSm1hYXFaOGF6MXRlZGFQSVhJdGVVWFFpcFNM?=
 =?utf-8?B?VmYzcm0wMG5KYkdQNjN6anBRWS9LS0tESzJkci9BNEdZYjZRek5qVXJsUXV6?=
 =?utf-8?B?UVJOMFpUZkRNQ0VVbU5FK0xMUFFOWlFhc0VzRnk1VkNPOVBhTzF2OVg3RlFI?=
 =?utf-8?B?Qmpva2JjcWxjRFE2WXJkcDZyc1hpOW5xaHJwc2xFbk1saVljcy94SkpwZmgx?=
 =?utf-8?B?TCtpZGh6V1E1WUdPeXBKZ01yNFNtenc5QnRoNlpIZjVUaVJrZkwza2FaaEJC?=
 =?utf-8?B?SytkQXRXWVBaVmxBV0cvNS9PKzNpVU43dEQvcXFrY0xaelhsTDFKWEd5YXZM?=
 =?utf-8?B?QzQzSStRcDBDM0dlN1d4SUtYbWhJZWlOcnhaSUZ6ZjZ6ZWdLWkUrTVNvWFhh?=
 =?utf-8?B?SzVVVkNIZjVBMGJTWE1uNWY5Um90dkJEZXlnd1ZlK0FHVkxqZTRuVVRWOVZP?=
 =?utf-8?B?NThXTGFtYVZCck5Zc0VuajQvc21YUHhqN2FUSHpXQ2lDeXFHUnRqOW1ydlM5?=
 =?utf-8?B?V0lvdlBKNlI5YzlDTHFwY1I5RHNCSkN6RUdsMGhZeFlYTGZ5SHg5L0QyVTll?=
 =?utf-8?B?OE9qZ3JWenRVSXhUa3BhWUpvN1R6ei9UeEFnTUo2bTNBSWhBeXNmWlQ3cHVx?=
 =?utf-8?B?QnkyYkJJZEZNdWtpdGl3bDRLZHlkRXBMNDM3RktlbzdlbVgrWkJTM2E0a2xa?=
 =?utf-8?B?OWxlUXdQNGxMM2VVZVQ1NmtTNTdMbkhhdEd3TmxNMDJuLzA2S1JSYVkzREs3?=
 =?utf-8?B?WHhnQTBodTBZbE9CTExkcHZ3VHN2QW41UkJSUS9pM1BGSEVqMmUvdGF6NTlk?=
 =?utf-8?B?Y1VpWVM4QjY2RUUzVXpCVEJoYXYvM2lKNnJnL2dhd01jL1FaK2dzcWo4MWpj?=
 =?utf-8?B?eGNWZkZmOFNYYkVMalNvTkYydmFmdUZXWjU5Yk1jWlhuSERoYUtDMjlLbU9M?=
 =?utf-8?B?aGtXbVQ1K1EzK2NJV29nTWozZDdtSkwwMHhqYm5hcFpiR3Zib2xvcCtwVTg1?=
 =?utf-8?B?QlczZUcxWlpTU1hySkdjMkxGSEMxdlNJK0dNVFNQMFY5NVNBb09NbC9WNUxq?=
 =?utf-8?B?SWhvdk14N21HVkJHRVRjM1lTRU5CVDA1L3h0WVlnTWV4enhKQXNtNGFZT0xS?=
 =?utf-8?B?TWZUc1FmSG10T0EyRlg4aWlnMjlRZ1krQURRSHBEdkVaUVVoRG9ycFQvMTVi?=
 =?utf-8?B?WTlSZ0w5UWFzZlFuMHVOcTFHYStmY1RiaVYzcXBzUWRCckhUb3l4NWU3OEFJ?=
 =?utf-8?B?ZTNFZ1N3RFJ5NjNNbVBLZUxhRzNvODhEOHYrL0MxSVFuZTR1cjVFeWdCeVg2?=
 =?utf-8?B?NHNLOU1LUmJBR1JtY0NmMjc5WWdqYWV0US9ndlBta2ZUa1Brdy9nUktrdWRN?=
 =?utf-8?B?TUdETzNmMDlTak5Nd0RQZUZZYXB4b1c1ckxacjJJTGhQZEk0RXB1eDNqQXFs?=
 =?utf-8?B?QlN3ejdTWXI4bFFzMEZjb3VVeTZwQlg0YjdxZnkrMEhjTEQ1ZUJPdVFJS2lm?=
 =?utf-8?B?dDVyWGxhZ1R0MEt1Z1c4SVlIeEpmeW1OYjNpbHFnRFpESWVSUTk0cUEvZ3Qw?=
 =?utf-8?B?YnJNRnc1MS8zZngrVUFkWjUxNGFEaFBtUzVyQmptQW5JNzc0OGtnTFRBYTJs?=
 =?utf-8?B?MmFxaGhXeC9JbnpmQzFrdUNUK2lQS2FlT2RRQk1WNkJ6dUVWY3BKeVZqTUE2?=
 =?utf-8?Q?d1Nml7t3DCzFz3JrTO26NUfiKJkIZhsCY5T5fMJ1xJ8hJ?=
x-ms-exchange-antispam-messagedata-1: J/3LAVcwvRBzbRvnZJOwYkX9e1wWHXN3Cog=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B72E67C0B7BEB74188A0925259E6CCB7@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b7f240-20f2-43a3-ebb4-08decb74796b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 06:57:04.6631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlnXOvRRf/0aB4V0WKjRllyUOLyji4EceJkOvgd923LQRGM3dXFvO2jU9XaM08jRe8qlkFvBs/ryi6vNFa50aokGhDnSiLRtQeiLg6xcMxcRsiGpY58S2ujGUaCRmGXA4N88C2YtwKiC2J6DojnHzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299758-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10DE668CAD4

T24gMTYvNi8yMDI2IDI6MDYgcG0sIE1heGltZSBDaGV2YWxsaWVyIHdyb3RlOg0KPiBIaSBOYXpp
bSwNCj4NCj4gT24gNi8xNi8yNiAwNjoyNiwgbXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFz
bWFkZUBhbHRlcmEuY29tIHdyb3RlOg0KPj4gRnJvbTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5u
YXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+Pg0KPj4gVGhpcyBzZXJpZXMg
Zml4ZXMgdGhyZWUgYnVncyBpbiB0aGUgc3RtbWFjIEwzL0w0IFRDIGZsb3dlciBmaWx0ZXINCj4+
IGltcGxlbWVudGF0aW9uIGZvciB0aGUgWEdNQUMyIGNvcmUuIEFsbCB0aHJlZSBwYXRjaGVzIHRh
cmdldCBuZXQuDQo+Pg0KPj4gVGhlIEwzL0w0IGZpbHRlciBtYXRjaCBjb3VudCBzdGF0aXN0aWNz
IHBhdGNoIChvcmlnaW5hbGx5IHBhdGNoIDQvNCkNCj4+IGhhcyBiZWVuIHNwbGl0IG91dCBhbmQg
d2lsbCBiZSBzZW50IHNlcGFyYXRlbHkgYWdhaW5zdCBuZXQtbmV4dCBwZXINCj4+IEFuZHJldyBM
dW5uJ3MgcmV2aWV3IG9mIHYxLg0KPj4NCj4+IFBhdGNoIDEgZml4ZXMgYSByZWdpc3RlciBjb3Jy
dXB0aW9uIGJ1ZyBpbiB0aGUgTDQgZmlsdGVyIHBvcnQgY29uZmlndXJhdGlvbi4NCj4+IFRoZSBY
R01BQ19MNF9BRERSIHJlZ2lzdGVyIGhvbGRzIGJvdGggc291cmNlIGFuZCBkZXN0aW5hdGlvbiBw
b3J0IG1hdGNoDQo+PiB2YWx1ZXMgaW4gYSBzaW5nbGUgcmVnaXN0ZXIuIFRoZSBvcmlnaW5hbCBj
b2RlIG92ZXJ3cml0ZXMgdGhlIGVudGlyZSByZWdpc3Rlcg0KPj4gd2hlbiBzZXR0aW5nIGVpdGhl
ciBmaWVsZCwgc2lsZW50bHkgZXJhc2luZyB0aGUgb3RoZXIuIFRoaXMgaXMgZml4ZWQgYnkNCj4+
IHVzaW5nIGEgcmVhZC1tb2RpZnktd3JpdGUgc2VxdWVuY2UuDQo+Pg0KPj4gUGF0Y2ggMiBmaXhl
cyB0aGUgYmFzaWMgZmxvdyBtYXRjaCBwYXJzZXIgdG8gcHJvcGVybHkgcmVqZWN0IHVuc3VwcG9y
dGVkDQo+PiBvZmZsb2FkIHJlcXVlc3RzIHdpdGggLUVPUE5PVFNVUFAgaW5zdGVhZCBvZiBzaWxl
bnRseSBhY2NlcHRpbmcgdGhlbS4NCj4+IFVuc3VwcG9ydGVkIGNhc2VzIGluY2x1ZGUgcGFydGlh
bCBwcm90b2NvbCBtYXNrcywgbm9uLUlQdjQgbmV0d29yayBwcm90bywNCj4+IGFuZCBub24tVENQ
L1VEUCB0cmFuc3BvcnQgcHJvdG8uIEV4dGFjayBtZXNzYWdlcyBhcmUgbm93IGluY2x1ZGVkIHNv
IHVzZXJzDQo+PiBrbm93IGV4YWN0bHkgd2hpY2ggcGFydCBvZiB0aGUgbWF0Y2ggaXMgdW5zdXBw
b3J0ZWQuIFRoZSAtRU9QTk9UU1VQUCBpcw0KPj4gYWxzbyBub3cgcmV0dXJuZWQgZGlyZWN0bHkg
aW5zdGVhZCBvZiB1c2luZyBicmVhaywgd2hpY2ggd2FzIHNpbGVudGx5DQo+PiBkaXNjYXJkaW5n
IHRoZSBlcnJvciBvbiBGTE9XX0NMU19SRVBMQUNFIG9wZXJhdGlvbnMuDQo+Pg0KPj4gUGF0Y2gg
MyBmaXhlcyBhIHN0YWxlIGFjdGlvbiBidWcgb24gZmlsdGVyIGRlbGV0aW9uLiBXaGVuIGEgZmls
dGVyIGVudHJ5DQo+PiB3aXRoIGEgZHJvcCBhY3Rpb24gaXMgZGVsZXRlZCwgdGhlIGFjdGlvbiBm
aWVsZCB3YXMgbm90IHJlc2V0LCBjYXVzaW5nDQo+PiBpdCB0byBwZXJzaXN0IGFuZCBwb3RlbnRp
YWxseSBhZmZlY3Qgc3Vic2VxdWVudCBmaWx0ZXIgY29uZmlndXJhdGlvbnMuDQo+Pg0KPj4gQWxs
IHRocmVlIHBhdGNoZXMgZml4IHRoZSBvcmlnaW5hbCBMMy9MNCBmaWx0ZXIgaW1wbGVtZW50YXRp
b24gaW50cm9kdWNlZCBpbg0KPj4gNDI1ZWFiZGRhZjBmICgibmV0OiBzdG1tYWM6IEltcGxlbWVu
dCBMMy9MNCBGaWx0ZXJzIHVzaW5nIFRDIEZsb3dlciIpLg0KPj4NCj4+IENoYW5nZXMgaW4gdjM6
DQo+PiAtIFBhdGNoIDI6IGFkZCBleHRhY2sgbWVzc2FnZXMgdG8gZWFjaCAtRU9QTk9UU1VQUCBy
ZXR1cm4gKEpha3ViIEtpY2luc2tpKQ0KPj4gLSBQYXRjaCAyOiByZXR1cm4gLUVPUE5PVFNVUFAg
ZGlyZWN0bHkgaW5zdGVhZCBvZiBicmVhayB0byBhdm9pZCBzaWxlbnRseQ0KPj4gICAgcmVwb3J0
aW5nIHN1Y2Nlc3Mgb24gdW5zdXBwb3J0ZWQgRkxPV19DTFNfUkVQTEFDRSAoU2FzaGlrbyByZXZp
ZXcpDQo+DQo+IFBsZWFzZSB0YWtlIGEgbG9vayBhdCB0aGlzIHBhZ2UgcHJpb3IgdG8gcmVwb3N0
aW5nIDoNCj4NCj4gaHR0cHM6Ly9uZXRkZXYuYm90cy5saW51eC5kZXYvbmV0LW5leHQuaHRtbA0K
Pg0KPiBUaGVyZSdzIGFsc28gYW4gYW5ub3VuY2VtZW50IG1hZGUgb24gdGhlIG5ldGRldkAgbGlz
dCB3aGVuIG5ldC1uZXh0DQo+IG9wZW5zL2Nsb3Nlcy4NCj4NCj4gWW91IGNhbid0IHN1Ym1pdCBu
ZXcgc2VyaWVzIHRoYXQgdGFyZ2V0IG5ldC1uZXh0IGR1cmluZyB0aGUgbWVyZ2Ugd2luZG93LA0K
PiB0aGlzIHJldmlzaW9uIHdpbGwgaGF2ZSB0byB3YWl0IDIgd2Vla3MuDQo+DQo+IE1heGltZQ0K
Pg0KQWggSSBzZWUsIFRoYW5rcyBNYXhpbWUgOikNCg==

