Return-Path: <netdev+bounces-61597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EB98245C1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B071C22084
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A4C24217;
	Thu,  4 Jan 2024 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="eWpmYjZu"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2139.outbound.protection.outlook.com [40.107.104.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58A22338
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVeQpJmwhq97xM1C7a2tYO306RTvdw4QHxbykbpWgzg3vtZzyQI0r/rAd8wSJjDZoB+vFiH4ZhrFUrrKjMzBjbPUE/rw9bUV23p1JSi/dTnNg9T63VTjP7/8WjDfJFV09ecyTH0HhIXNn+H8bB6/ZGpZG/GSg09YzTP7YKBqOyiaMnDfxnNbNH1j+SMNiXMKLiinivBY0Mun4O94OiAckslsEsLah5V3w8KEW3E2f18CaGfEA0Ti/UguUPCB9FyFsJu5+1z7W9nmd2EgAnLCVVU5n46O/T7vydY2PUhTUudKqxfXLJuI/4XPDfErbMGOlbsRNOS28e6YEestDw5aiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2PtdfSLi4xUs0He9IzqvcLlEj6wGI7j2wkxhMg+Rig=;
 b=jYvzwP2/8s2LV//8MqW5zr1EWl/hEcvilyC7dWMwje4GYys2Vb15remRv0zb18VCvmDksz4rf8cy5WLjlqriu/AMqTAX+c7YGTD61a2nLIFxqs04DWqtdxXGHBXZ8IXmbXid0RQTHifQ7s8EA2sAfZpPecxTZ6VfMQnvEx2AlpzswVhcjzDhlRe9RORe+qfv6TOgrcQT/E2eo3HWDG6visVg+lA46WbXS9BEjvQ2fJyRhmSw8deGobP+oNdmo1GDsoCxkYIQFYx50ymZXlRf32cgi8g6JdBXyDnvnv9PuCNoFyoBhVjNjScz+nSoQQSdVLKN+golPMfZptzcoMq+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2PtdfSLi4xUs0He9IzqvcLlEj6wGI7j2wkxhMg+Rig=;
 b=eWpmYjZuPsrn6tx3eoVJ7EnJx6eD8O/QOa8vHihoHLfkeJqQ/7OBO2uI6gwPYJfnbtinH9ZrwqXxhlg5nSQFFKzNJqCS9HKxGysFG2wRNN+2dAUgNjwbn6ZKt64/oUiz5xfY/upon3XiDEnF4o24Lt+guB2rTU02u/WJ4c9fKuw=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB7243.eurprd03.prod.outlook.com (2603:10a6:10:220::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 16:05:19 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 16:05:19 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Luiz Angelo Daros
 de Luca <luizluca@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>, Hauke Mehrtens
	<hauke@hauke-m.de>, Christian Marangi <ansuelsmth@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation if
 its OF node has status = "disabled"
Thread-Topic: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation
 if its OF node has status = "disabled"
Thread-Index: AQHaPxZ+Wr/T9RNNP0Kzcp2ZFGcdbLDJ0XOA
Date: Thu, 4 Jan 2024 16:05:19 +0000
Message-ID: <q3f7salrzk3ppt4g3g5qsey3h44lmymrfullva5y53ku4tn2lf@wh67eeb67wsv>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-6-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-6-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB7243:EE_
x-ms-office365-filtering-correlation-id: fa2016fc-0945-4ce3-54d2-08dc0d3ef330
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qat3wJ6pj15GqjTc5QtxQEvqS60gZTYS2Ii7+wCoZCYbjMXNmT6wSpUYRmpvE0s1FksKTxG1I3TtBNU5eGR4KNsDSW1rCa8Y8F3szPQsBhdHK7xFm1S62VU4cv7XHtS/bcnnkKlg57B7euOEysZ9atUdtc0v1dGEhKCvvG0TxyO/g8ClCuZbAOCraNOdziV33ytEXAysKC1gwd3AQDA4mzadTFePTZKcV2kx8Jmp7TuLfJYnJfI5spp8kzOA4RpaFIINDHvfwZasWr0H1rymjyoL2q5P7+n777ZrQiWeIlvxsidUt6Kh8w65aYIqCgwKAQDgCN41cF6qWa1kEm/5un4po6xiLyyuBEfVk/+ir1QwVBQxAELwNe9cz5rAVpKi6tD7k20wBypg4OewU/FdUho/CZYfxEvIO3c9vwvAVe4+KbWSVayrtJ3OinqkSgLWYO6WOFWUF5a4VfyMvCWCmtZde0FehkNHsn2oMTafdOVSBA0XeLceXjdoWNHQ1dFQQMrr6bKpHTz5yZakVVY+dZ3mcejWIurVy31q1eXvxgISegxJu3Gu6Pgx4kTqFytn8WCZ1/sRy5C6P8bLnzjVLvM8Vqwie5HB9H1QCAYqZlVNQvS3+71a7Kn7zwb14cnKLkWI79Y9tS5NPxQZewWCxQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39850400004)(396003)(451199024)(1800799012)(64100799003)(186009)(66476007)(41300700001)(26005)(122000001)(66574015)(83380400001)(38100700002)(33716001)(5660300002)(54906003)(8676002)(7416002)(8936002)(316002)(478600001)(2906002)(4744005)(71200400001)(4326008)(91956017)(38070700009)(64756008)(6916009)(6486002)(76116006)(6506007)(6512007)(66556008)(9686003)(66946007)(86362001)(66446008)(85182001)(85202003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnFnMzFxY1M5Y3JadnhtRGpEekhxS05qV3hCVlZmNzRIaGViY3BweVN2enUx?=
 =?utf-8?B?NmVnSjMyTG1ZaUIxendua0t4S2JWR3lZZmRHL3UvTjltZldCcENmUjlQS1pW?=
 =?utf-8?B?QlVwdDRObXRlMkFRWmRNL3JlN05sZzFyU1I0TXFUaXlod29EVTYrdVNtQytL?=
 =?utf-8?B?VWtHVUNZNjlJd1dzbk5paHhYNzhQclBKVGRRY2ZZdUxKOWNqWE8rOVBUcFFF?=
 =?utf-8?B?SUJ3ZGExRjFCQVhtVWNIQ25WQzhrNDNDNk52NWxtc2NPSGQ4aGFSWHJkQThu?=
 =?utf-8?B?RWp6UVBBSmpCV2ZIOWx4RjA1bDVZWHlFTHhUWnk0aTBWa0UzdGJZMzBUcWJv?=
 =?utf-8?B?NnNISXRRU0VaZHJQOVY0VjYvNFdGeUtGUHZhVWZmRm5zVWFIVk9JQXZEcnVQ?=
 =?utf-8?B?UVJ0QU53THZ5MkJIVWdJWTRWUHpyV2lFWmcxNURIZHlhNm1oMkU3ZlJ3VDc5?=
 =?utf-8?B?OXpqNjgzcHJLeFdXZlJSdHRIQkw3MmJ4MlNhVG1qVEZwSjlDWG5XMWRJZU9I?=
 =?utf-8?B?UVg5OVE1VkFSSUM1QnRQQlY3LzdPYnlCWHpoSEQ4dHhLWnFzakREeU42Mlpy?=
 =?utf-8?B?Y1FGYlpmUVFzY0FNaHZheE5mbTJRRENzNi9nQVhETnVieFBHZk41SFFBOVlF?=
 =?utf-8?B?MENRZTRPNCs3NzI2Q0ZHbHRCTDZHTFFJMjc1NVlUNzZQOUppcWFpN0V1dEpQ?=
 =?utf-8?B?TDR1Y3dmeEZodXhBQ3lMQ3l1aVIybWdsa29nTmhtVHNBMi9xY2F4UGhlYW83?=
 =?utf-8?B?ZjBnSHRHZU93ZVlvMGVNTUJORXNpTC9XUkQ2YVJidmU5MCsyYThkS21BVWNn?=
 =?utf-8?B?eFlGR1FIWnQzSWhSUUF4dHNUL0Z5UFVOMVNZbXA3SnhZaHl6Z0JnSThESGpl?=
 =?utf-8?B?SEg2WHRubWhNUWs1RlYvb0NsTHVOcktBMmMwV2lyV3RGS1dWOEVhYjRrRGxU?=
 =?utf-8?B?eXdiVnQ0d25DM3RPRVNBTTVvV1AvYVZYMzVKYTlxL0FVUnk3NkJMbGZKK1FE?=
 =?utf-8?B?RGZpVEJuOWlFOHBnY0FMVm5vd2tKU0pzSkh1dkcrVTVtYVZFVlQwWHN2NStG?=
 =?utf-8?B?OEZhcE9qR2kwc1lmN1hzNVpBS2NsQnVFWHhRalNBVUMwTk5VcGxla0hJemY1?=
 =?utf-8?B?RjFQbzdPeDNwNCtuZ3pOK3BKcG9VenU4YU53UlgyWFdXdllqZlVoZzZxS3JV?=
 =?utf-8?B?V2hQalNyVHI2NEVWSXNPZUZreC8wL2xrRUZTc1M0ZnhqaTRaaWxiWURXdXpE?=
 =?utf-8?B?aTdKYjErUzRUSUxLNmNNTXJhMTVNbGZGdCt5R0NkQzQ0RnhOaUViZnl6NzJl?=
 =?utf-8?B?OC92RUVPMm53R3FKbEQ0bG9aQVVTeDRRTmg1U2wyd3psYWR5WDByN0UwSkFP?=
 =?utf-8?B?c2Zsb3dyeFNoVCtabWRLZDFFaFJpZDZjVkxVMExLaGNLZ1ZYMWh0aEU1eW1H?=
 =?utf-8?B?dnRjdVdJa3p2TkZtM3FRL1JYeGVTMlZpd2VXWWRLdkkyWFNGUGJGeGR2ZnEr?=
 =?utf-8?B?MWVxMTFvd1NxUkV0MmJBRkFiMEtRR3B0eUc0TXNMUVI4aGI3VkF6YVBlenlw?=
 =?utf-8?B?MTU1TG94eEdLRFlBRGZlS1J2djFTenZxZ1BUdzkweHNkZEpWV1pzVE1VUDVl?=
 =?utf-8?B?UndaVVdtOTJLSEhXRGxGeitLaldvdGRmdTFFdDU5UGpqNmhvTG0yUHJuWnV0?=
 =?utf-8?B?SE05N3dnSS8xZGk0UHNYdUx3TWJuR3NxRHFSMWtTZmhBS2FSeVhIQzNOa1ZY?=
 =?utf-8?B?Tmd5Yzg2N0pFM1FmS2xHZEdQL0ZzT3l1Nlg1THpoTGFtSHlkYzJFQjVVOVJq?=
 =?utf-8?B?d2dTdTlDVnFvdXRnTVdLNko3QmNwcWJacVBhNHoxU3ZLejRRZkErWlVuOTlH?=
 =?utf-8?B?Ump0dk4waW0xeTlJUFp2eUlSTEZEZFFGYUVZYW1MMUlkbUNCa0ZhSGMrM2po?=
 =?utf-8?B?dldpeFpJcXBhMHg2emM5anQra1oyMUduZFlXS0JUOGFWeDNCY2pubEpxcUVZ?=
 =?utf-8?B?TWJHbGtHeWlMOEQ0L24xUHNzbjJtSzV3TkEyNDRxZnA5MjJvdS9LN0R4SWtm?=
 =?utf-8?B?QyticjZwd2E4WUtLUkxncDloblU4Tys1eTNaQXRhMmFXMm8rU3ZuRW8yNm1a?=
 =?utf-8?B?TDM2VlozYnZUT2NYT2FwTHIrZ0pRTURhb3ZQRjAxRFVmZDljZmQ4MzRkUERz?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7430042D472F84449F2DBB0AD0F4B120@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2016fc-0945-4ce3-54d2-08dc0d3ef330
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 16:05:19.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVDVHyn3PjodEM8O27LHe/ykwHEsOCv2YDlNSFeSXAQ0s8jc60g7dzfCStXBfdS+cJTwx/f98w5KkJ+QvPpDKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7243

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzJQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBDdXJyZW50bHkgdGhlIGRyaXZlciBjYWxscyB0aGUgbm9uLU9GIGRldm1fbWRp
b2J1c19yZWdpc3RlcigpIHJhdGhlcg0KPiB0aGFuIGRldm1fb2ZfbWRpb2J1c19yZWdpc3Rlcigp
IGZvciB0aGlzIGNhc2UsIGJ1dCBpdCBzZWVtcyB0byByYXRoZXINCj4gYmUgYSBjb25mdXNpbmcg
Y29pbmNpZGVuY2UsIGFuZCBub3QgYSByZWFsIHVzZSBjYXNlIHRoYXQgbmVlZHMgdG8gYmUNCj4g
c3VwcG9ydGVkLg0KPiANCj4gSWYgdGhlIGRldmljZSB0cmVlIHNheXMgc3RhdHVzID0gImRpc2Fi
bGVkIiBmb3IgdGhlIE1ESU8gYnVzLCB3ZQ0KPiBzaG91bGRuJ3QgbmVlZCBhbiBNRElPIGJ1cyBh
dCBhbGwuIEluc3RlYWQsIGp1c3QgZXhpdCBhcyBlYXJseSBhcw0KPiBwb3NzaWJsZSBhbmQgZG8g
bm90IGNhbGwgYW55IE1ESU8gQVBJLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0
ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXBy
YWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9x
Y2EvcWNhOGstOHh4eC5jIHwgOCArKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSk=

