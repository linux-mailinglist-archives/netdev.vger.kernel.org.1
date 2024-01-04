Return-Path: <netdev+bounces-61587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF6824561
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF65282D44
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CAE2421D;
	Thu,  4 Jan 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="CBDT4D02"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2096.outbound.protection.outlook.com [40.107.241.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5C224B22
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjj4I2ThgypvNloP9/1k8ELhJPAc4zu54oe1+gzjFnOsBfyY1LN3004Y0R7O1okbqZYnPDghmIYLYhDfKlCYrf72k1LLWBvu9oElkAA6OdG1i22sUbbHGa+uGkbZvJK6w1SiWTnJnUYjTv1qkDBn5JGVFDkgZZGO3jm80bMTCV1X4qbzXHzJF10PtzPVv1RCCnULESwxBEONYqamuoEfiB+2SYhzOdUmZJuhnMOOv3U+ZcJhBytU7b6LNCinXqb3pjKiE+uXI3UiC7gCL0x89JlzKyYu8hFZgr6gYpiw9B7Ftm814rrVVzz/4maKPnr+JGu//EbKwzUx21KaDTMI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tTTY0MEAIcjCd8RMGvnElkFPdxGA3upOdnbj3ckHTM=;
 b=hcAHL2FbGrGN3yQS6CUC5JQ940wVNG1GtWMaLnwQgAl83RFnKTDPmG+7EM+kN3qr/UybVGjpQh4uECAKBbnBECzkPb7i2CQB3dTlmamLY1+O6ivSxkAf7zZjClrNNQNEM5L0Qar2fy/DCVPiia+1uUD3XmAYhCIi7dLGb+XlmRo8ARNQ2bCyhXcImDHGpSfSPzXeMjO7XS6CSYpn3nV8a3Q70qWJO4zxDdSkEyqjtp4SYLHV56UiBIxje/0G4YhhbQ6w+8U61WWFHeokVTm8vTuzip3fmhMkUD2D3KGMzErVc0uSj04u+YZ3LdShV2gqcqaszjTtQYGinVDOtitMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tTTY0MEAIcjCd8RMGvnElkFPdxGA3upOdnbj3ckHTM=;
 b=CBDT4D02EY/hEDXw8/dlBEAbK3MlJAQsumiMjH/gObVKdUBBcQkjqeEdBYMTiAo7adsIsXEEPY1K4FsRI7slf5pOLoMGsY0uS38ugTsXp3cIzHHiy5QxyQkLwYwr9XKM/D+ZVoGGViRaZzV9koKFPuuX44yYeMwkhCeJ/Cs+aUQ=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by GV1PR03MB8709.eurprd03.prod.outlook.com (2603:10a6:150:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:50:15 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:50:15 +0000
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
Subject: Re: [PATCH net-next 08/10] net: dsa: qca8k: use "dev" consistently
 within qca8k_mdio_register()
Thread-Topic: [PATCH net-next 08/10] net: dsa: qca8k: use "dev" consistently
 within qca8k_mdio_register()
Thread-Index: AQHaPxaAhD6RL6Xb10OdEZbDM+pY1bDJzTwA
Date: Thu, 4 Jan 2024 15:50:15 +0000
Message-ID: <efelv46zjcnswqwvnwtc4aywql5pv5ttiacjwtriqy3qckoco5@5v7bvascqsqp>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-9-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-9-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|GV1PR03MB8709:EE_
x-ms-office365-filtering-correlation-id: bc8cff0c-7394-4d73-83c0-08dc0d3cd7f1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pTWj+TWZW0jnR4e4bIfS47V1CTnuSM9ufmL22CfYlux0tQJgLGtMxIDXwmXwq+1OMlGF9tZUa41HlrPsD6QLavWscck9v8iv6qiB6CXuztx6fSnPiMXT5a8Iyyjy7WB3gq84MOYiuhfCcAsnaRPnM1aHnLmbPv/YFYrNN7Pj1dDKra/rFwuDyRKRoWNOdKg37QKgaSN3k8rghUbFNKxCJ4zYPjq3P/+SOOv1cZgJuS4s83t7u7cEUarhMi51/KCw5yRW9jgSy56tXlg9qy9afoDMpRz8qVu3eP74IUSNpxdjqk+lO2kh4jO6OfOGhBNiSCtKBaC8SX88AEr8Mj2fY24xAMqyRkDAm4t1rK1GiIiy2Ob+Fl6H8tOVu0JSiNFogWFRKUIW4/O7WoWJ2+LWHfxMGW5v3+FZEbFb41o0Bo+JsqWMkBcs1SYaXEMudhIvyx1ABO3hnx3By7oB2lauqaYbJcboXKMSsZJAcxBx3dQvoAui7Vq6TTNc997vR6ejpaFhcOkrYs7IqAe5B6oVht+IDng31OoC+wdrAe43ZYZzdEnNGWXhUrn7BY33aVI9rTE/rkxClA6e8ci0G+vLbs43wpoxL36xnpmM2Qw4bjyZP7DPYrxljD4O6vJfGL6a3mXwoO3AKVS0xwZHEICBEg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39850400004)(396003)(376002)(136003)(64100799003)(186009)(451199024)(1800799012)(316002)(9686003)(54906003)(8936002)(8676002)(6512007)(6506007)(4744005)(83380400001)(85182001)(7416002)(2906002)(26005)(5660300002)(4326008)(38100700002)(41300700001)(33716001)(85202003)(38070700009)(478600001)(66946007)(71200400001)(66476007)(6486002)(66446008)(91956017)(64756008)(76116006)(66556008)(6916009)(86362001)(122000001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGhiWldySzhyVW1yMnpQblB1M0w3c3lwNUd3ZTQrekdtenRSQXJINGJmVFUx?=
 =?utf-8?B?c0V6U01aY1VpV0k3RGhHTXJhbE1VUzNjc044QldReUphMjVDRE1lODQ1bVdT?=
 =?utf-8?B?SUV3cGZ5VXFodVJ1RC93ZEdjZ0FlWFI0Q1hTaElkbHZsZFBocENLeHBic0Rt?=
 =?utf-8?B?bGp5STFRV3duenc1U3Y0a2VBVVRtRnhOd0ZPSEh3c1hqNjJTRXpCVkFxelJw?=
 =?utf-8?B?Z05yNTZieVVYVzVzeU56OE00dTB6OE5Tb3VsMC95STRzVWZuQTRZOTdVbWRN?=
 =?utf-8?B?eklhTnBFcXdhQXZRZW9xdFRsOGN2SlZOc2NKSnU5S01kR29UNGdPa1JQck96?=
 =?utf-8?B?Unh5bk9yQVl1MGZYaDJpM2szRmhORGtsc1FLa2NQdUJpYjlObnpNT0YyQWZW?=
 =?utf-8?B?RlFVaU5xR2JYSVlDRUdLaC9ab3p3NWM1dzBOUVp1WmhwVE9NekFRZGFKTUty?=
 =?utf-8?B?dUcyM1JRU1UvOUo3b0x0UUUrTDFpSkx3UG8zMEVkRm1Yb3dOU3gydkJQU2pJ?=
 =?utf-8?B?OG1rYWppZmo1a3ZCYmQwRFRuN3Y1NU96Y3V5NU1iQlFRMnpYb0ZjajRPWVpi?=
 =?utf-8?B?L1VodTFSejQwRG1lUHplVElnWmxMS1l2ZEtnUmJwNGg0djdHNFRrL0h3UG56?=
 =?utf-8?B?dlJDNzZBTS9qSFpEWTJ5bHQ1RTZidjRHNjZsR0dqTEFMZklaL0dmVldIalBT?=
 =?utf-8?B?alJ4NHdrTk1QeUQ0bjdzL29WRGxYRXNXdnJ1Y0pkQkovSmwyWGhoTWlNMk1X?=
 =?utf-8?B?UGZsYnB4S3hBa0dFTnVDdmZ2cGxYZlpKeTJRRzYyanNZU1FtUGhUUmxUYTdy?=
 =?utf-8?B?Qit4c2Q2ZnJ4MHFPWVVMWkxMTktxbE4yTUxoWTVWakhmdzRob3BVOXBmeXcr?=
 =?utf-8?B?Vm0ybnNVekR0cWt0cWpzaVFjVkFTb1dBL1FxRzdWMUh0RUEvMHp6enAyYjNi?=
 =?utf-8?B?MDczUmVlbjJGbzdMYVVtSmpzYkJpWmFlNDRVc2J6NmRmWkE5UXVoRlVSaDVK?=
 =?utf-8?B?UThQVktsYllxVzJTeTkwNllCZUkyUUdjZGdvRDNNOFFKdWdCdVhnam5zWVJY?=
 =?utf-8?B?YnZXMW91R3N6Z1lNdVFJekhLNE9WeStLdGRoQkRKK1dUQkRyOUJpRFJ4L3Nm?=
 =?utf-8?B?T2hQMzBvWTJRejY1MVNhT0RkbG0yTTBVc3dDNnM4QitJZG5uUTBqMmE2Rzl1?=
 =?utf-8?B?d3NNRXE3aklGb3l3emVYOXMvZktjWkQyWng5S3ZkODBlRHpVY0lrRDkwUm9M?=
 =?utf-8?B?aGpvQ0xPaGVlYm9ZOGZUbEFIL2xDT0JFK0RVTVVIU3RFVGR3S2JXSzZVOTlr?=
 =?utf-8?B?aU1zOFBYSTJDNU9mWjVjY2xERHNtdlUvbWhLbFB5aVBUdEN5ZFNsYjFJMmhZ?=
 =?utf-8?B?TnNoNEI1bjRQU29va1ZERUs4dzYyWlpYTmVQNjE5RFF1L00xdVZMZUloYjZa?=
 =?utf-8?B?aFkxTU8zU0FxTmV2eXVHSWlCN2JsZnJnaElNRldvNWZ1SDQ0SGtiUURMS1JJ?=
 =?utf-8?B?bXlwUUF2aVFjV3FWQkc5aHJIaWhCUDg3V2xubWZXN0hMUXBzK0l4ODZsV2I3?=
 =?utf-8?B?RTZqdTJGV2FERUlXMjNNcmNUKy8zZ01Vd3FQcjBPOFpxaGVtKytJTGprcUdM?=
 =?utf-8?B?a2R6dU9xZ29HdDhOdTBrTER4b2daMDFMWWlLSXZxazIybSs3SitIM1B0Rzdv?=
 =?utf-8?B?ZlRRS1dPcmY2THVIZHRaUEN3VTZRQVR1TElTaTRsZFdKaEZJc2wzMHc3MmpI?=
 =?utf-8?B?OFR1cnBTVEdXbytmeFlZL3ZTdmVoSGg4Wk1KSnI0allLSjg0YmMzSEZJKzJp?=
 =?utf-8?B?em03WXVpSWJTUVVxdXZmTTVCL2lkTnVqOU5qcEErMEpRZHpnNmpnQy9qeE1B?=
 =?utf-8?B?MldITHh1V3NXZ3l4dHVaRDR2WEJ5RjdOQ25CTkU3dEhLbEhHbldPb3Fvb0ll?=
 =?utf-8?B?bnJxcjV0alo5dkRWVko1Uzg3dlJqMXBCcVlTYnRYMmt2RGRRTEdta1lNa2Nm?=
 =?utf-8?B?cTJ3ek94bWt4S2VleTlXL2ltR2pCMFNlL0wvbnlPR0xGSWNRSDREWFUxM2NH?=
 =?utf-8?B?OUd4QXE3UFZHS1BTREFlYjMybkI5NFBuWkxtdVplVGR3NW9iYjdXNEhpV3Q4?=
 =?utf-8?B?eFF5cGVqQnExU3U3eFM0OVBqR1dNTmdjazBmTWZISS9KNTdyUkFmbnVvbHBU?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C21B891AEC1D24FA72A0E814F7456EE@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8cff0c-7394-4d73-83c0-08dc0d3cd7f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:50:15.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g04ar2hBzt56q1bLy5Qaw9/ESPgAWO0HUofhlnIDI3fbupzI/SkL0iXWGuTQtq//iQclofvl0CunK26XrAO5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8709

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzVQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBBY2Nlc3NlZCBlaXRoZXIgdGhyb3VnaCBwcml2LT5kZXYgb3IgZHMtPmRldiwg
aXQgaXMgdGhlIHNhbWUgZGV2aWNlDQo+IHN0cnVjdHVyZS4gS2VlcCBhIHNpbmdsZSB2YXJpYWJs
ZSB3aGljaCBob2xkcyBhIHJlZmVyZW5jZSB0byBpdCwgYW5kIHVzZQ0KPiBpdCBjb25zaXN0ZW50
bHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWlyLm9sdGVh
bkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFuZy1vbHVm
c2VuLmRrPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay04eHh4LmMgfCA5
ICsrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSk=

