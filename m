Return-Path: <netdev+bounces-61585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B55CF82455A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8299281980
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BFA24217;
	Thu,  4 Jan 2024 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="QHlNftLE"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2128.outbound.protection.outlook.com [40.107.241.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02C24B23
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmQYG2ynaGXMlDnks93NfklyELeQNGALyz1fcAt4sacVl0joVDjo5Zr4zcD5fbbZGbFRf55168JlfSYMjXJzTiEPCZ0mKk7yE9HAi/ymRSLF+aOxre3jLtOxnVwUZJ8WbNBlPU5BL1nRlPtU2m8DeXedA1nSmUXsJxK57SjyU9N9C4kbE1ScCvXr77aOIJ7AH2ZSCukHwF8bKkIaVdEWXro2B+DWBItcQML+OVxzUimNxOjGYB9GBvhtqr07RbJVwK1zddvfGLOmIAkNsZ2oR3DsyOg3SVPHTg3NhqEgFS6oDONQ3om3dMzrACPNfxhcJX2T59nFxSsXYIemoRVkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apioIzgdpGuK+IRB0BfOEUAiBD7hgqPUq52P88NFKwo=;
 b=a8/7Ae5u076fXpAt1fdRb2WiTCvzMH2iJ1PL9ERR9HaBYQgB+z+bbWG7/zi/ZiRBiIIlhdvB2clkoNWEE9FA4SMkteO0BjQiFJJJIEhThNdk9b03PCEWHHpQZDqBVmHiNWiIm5a3hmKgVYjx8FunL6x9WsKqUAQD1U4hFLAzox0pWEsHYBhle8I8sQWHqDn1aA7etM7BGR4pK7ZLPfP30YF22Np1LhCR3QEeZhff/vKewBX7oqQYu5+8+k5bo6np5kTu8D3AjfVHbPYb/ZAmo/AikkW2doz9234dMMssvduos47uHN7S3YqtO3ZUHlFg9pmyKXxcXBF7iHVlr9vrmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apioIzgdpGuK+IRB0BfOEUAiBD7hgqPUq52P88NFKwo=;
 b=QHlNftLE779pRA+emv7Vm8YV7Fmu4a9kqD33wWnP2p9zY4HQ60RxUlm337NuUKKzxM4zzyL71CpU7Vbew8vZ/72TENCslVRr1/vbWUIAYLDE0lgQttMOQT+qJb825AZl0x0pdNv5TuVmqQClMwxdFvMUYwBUVaCaxOZd8vtX4vY=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by GV1PR03MB8709.eurprd03.prod.outlook.com (2603:10a6:150:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:49:24 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:49:24 +0000
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
Subject: Re: [PATCH net-next 07/10] net: dsa: qca8k: consolidate calls to a
 single devm_of_mdiobus_register()
Thread-Topic: [PATCH net-next 07/10] net: dsa: qca8k: consolidate calls to a
 single devm_of_mdiobus_register()
Thread-Index: AQHaPxZ/mYyjKOV2fEuSpcWoG8arJ7DJzP+A
Date: Thu, 4 Jan 2024 15:49:24 +0000
Message-ID: <2bx6tn3oovvtp6j6chpsxithjastispxayk5jcyajiueentduq@j25urork4n7w>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-8-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-8-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|GV1PR03MB8709:EE_
x-ms-office365-filtering-correlation-id: 94df9c37-27bd-4498-bab6-08dc0d3cb97a
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NTbe2eWzQWjXb0dgUh9F1Fh+XiFTw+XXIhmETEWxA2ZLIH3bYuAF1jxbvmGNcIqBgtLEpLEpXKFS0yW2yVcLI/G+mDFxLJvwbVMfQr8R+z0eeN+pfdx7ChA+mnZ+XraLTwHGdWpB7L3P82nY4eaBxmEqvtLBrhBX7tSBA8gzqFYZa9PdFR7jX3x34Auwx2T/687beNJMRXUgRVFuQnCnvxoH5cyrQXWj6fBDl1T8rLku6VlX9bp3MC4SKG/aXO7omHFo2iyjYTQy/DhW7mUcxIOxjWWujxSleuaZ1xiKzJq5+Tg1kVoGuEeOIKYSxQmAZ6Cn5hwPXzCW5Jy76aCOSSNmKfs+5yvwiKLU0VZdC+9Y9ZrBG75kmHT/J0yywr2OHcMSkjgqmtXjbFWIVVcTPb9aCebDq93w7mBCFEUbFNnQijFYta88BjZCGvLqYKBt/l4mxGYqgrY0kEZpzfVGlTfSv8fUReDy5Kh8VK/yzwaWIvr0cR/LXRFqBlNseHfciFV0P1LEtRydmIh27smxhRzJ8MD9SJAjYG4tmQYjWiIljpc9mmdxp6s5SMGDqfzxFZQK49fALeLxGdHp+P1VNkFrBlxZ/eODyxk8xBzDTCf6FGagTESU7xD24TCnSZF+DkeswW5DF0BsPJKxwgERLQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39850400004)(396003)(376002)(136003)(64100799003)(186009)(451199024)(1800799012)(316002)(9686003)(54906003)(8936002)(8676002)(6512007)(6506007)(4744005)(83380400001)(85182001)(7416002)(2906002)(26005)(5660300002)(4326008)(38100700002)(41300700001)(33716001)(85202003)(38070700009)(478600001)(66946007)(71200400001)(66476007)(6486002)(66446008)(91956017)(64756008)(76116006)(66556008)(6916009)(86362001)(122000001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW44VFFTT1FyMXM4Nzl4RHl6NHRlM3JLYW5xdVZGYm5kOU5yVDAzdmV0K1lp?=
 =?utf-8?B?dTk4MFJZalo1MUhDRjJ0Q3BNVUlybGsvNXV6bHJRSmFBYWQzV0JhK3JEajd5?=
 =?utf-8?B?NEluMHlPd3pkYWZUQ2p6dHFDcE1GWFl1a3dLME1odjY1d2hGWjl5TkFFWk1q?=
 =?utf-8?B?c2lla25OUHRyZlhlQ1VRWGhZbko1UjJBLys4d0wwM1NIUVh0YTh1ajhnelE3?=
 =?utf-8?B?MEVvSWZ4cUdvQkxuRkpHVXh3bTYvWkdWVDBSOEt3RlE0QjZocjAzY3BSTGsz?=
 =?utf-8?B?bTZPWHdhNHRqMnJkMVVJUmpoTlZvL3JkWVVTa04va3FmT2ZEZWFldGgrcGNx?=
 =?utf-8?B?SjRtTEhoT3F1YXd4SlgrYnlZeVB5SGJTM0VMZFYrckZWbm5kaGFxSzFwVEVj?=
 =?utf-8?B?VDlBSkpZZFpHNjNuc1dCSjd1RXZ5K1Y4bUxwVWFpRHR2NzEyaTRPN3A4aHF1?=
 =?utf-8?B?ZytoT2RYc0lCNnFkVE5ac0YwNTBNeHJhUktLZ2V1MVAwbU9xa1VLaktpQ0hm?=
 =?utf-8?B?VEk5d01tNUF2R2VRVDE3V2FsRklXOGp4QXp5cTY2YnVSNGxRaDJSMk92ZCt2?=
 =?utf-8?B?cS9QMjNzRlFQazNIZ1Z3OXZNU3ByWGJuRXNYSFRZL0MvR2N3UFN1M3ZsOVFV?=
 =?utf-8?B?RSt5RVE1cHpzbTJCWU9aMXZpTUp6WG5qOWlYbzdPTzFCSmVJblZFam01OVV0?=
 =?utf-8?B?VVJFaFBkZHRCaXhRL3lnVm5sTnFqai9pOG04S0d6OXFuOHdyZEE5Q3RLWjUr?=
 =?utf-8?B?c0VjSlpmMjg4NmdybUcveWJqa2tSOVNQUUdCTEgzdVFIRUw5NWMwOWdVVEFH?=
 =?utf-8?B?NzliNW82d1dZTENyMlNZMDZsQjlrc1lCQUtRUTBpSTRMdmVBaGdOWWhYZm92?=
 =?utf-8?B?Q3JMZHJGd3FoMVdQVEZXLzVJSlRFbnA1Y1JQTHBxM0lPcE1LdlZ1SmQxMjZD?=
 =?utf-8?B?OCtGQm11MUd4VktzU2w1UWNzbFNaMTE1UkRnTjA5SS9PUTFzVWJQSkNocVpB?=
 =?utf-8?B?QmZubituVUhDa1VYTHVpOTFnamZxSFgrYUE1UWFNdk9JYndjUTh1bTlIOFpx?=
 =?utf-8?B?enptdVZJSjBhcWU4NlBDYS93d1N2VEJEZ1ZPakRoWlpnNG1LTm1wT3ZtWCtu?=
 =?utf-8?B?RFdsR0hTOUNZNVZhMk56NHJmc3dkUXhSZGl3cHRFNWZRdzNyYXcvNE5rM0VY?=
 =?utf-8?B?ekdibklKbTFSZkY4c0JBMUJTWEg1V2lyMUpqZHZvUVJQNzFMeTlPQXVOQXA3?=
 =?utf-8?B?QnpZVEd0MisyWllYbHV5bThhQzUvbXY1RlQ4cUdqMmc1b1BabFlpK1FwQ3hB?=
 =?utf-8?B?azkyZTJUWnNadk5rTi9CV3VlRzJVVGJjbnBJQUNPUzd2L00xNnZYRnphWGFo?=
 =?utf-8?B?OGdHRWY5aDlRaFU1N2w1d3ZoaHRVMXMxVmRHa1hCVjVUNmZCdkc1Mkk0MUJN?=
 =?utf-8?B?Q2ExOHZKQ0RsU2RmYW51QzJ4TlhxV21WMHNNb2RjTFZKT0c1K2VFb041Wlhm?=
 =?utf-8?B?V2hJRnNlekdabnJvbFE0ZUxnUTJoOGdlSk5EaVNyMGEwaFlUdGE4LzFVRmxo?=
 =?utf-8?B?a2FsVFBkeWpRK3NVMituL29zWGszL0Jhd0xmbzFXdFJFalZFOFl3aHRwWkVo?=
 =?utf-8?B?bnNkdVJ2UVUvT2E2YjhvckxtTjJsTDZ2NVhyRGx1MUJqa0FDeDViNmZUYzNV?=
 =?utf-8?B?TVlVQk4xbFJOa3lmOGQreTFTRXV2YXhMYkk0TXdpZjBaY3VoWHpLUmpVdnVR?=
 =?utf-8?B?OW4vaWhjN2ZNR083eUJkdGtHWk1FUFBnOS9MS0FRdkZmcDJDOWYreWRhcjl1?=
 =?utf-8?B?VzRtRnhocktYQ0JRQkRhajNzWm1wTXJVbUlSU3JqREhnc1VvWWxLVTYrSEpL?=
 =?utf-8?B?blZaREwvaGFheXpzVXE0NkVIT3hYS0w5VGpNaDNDYytPSmR2SExudG05d2th?=
 =?utf-8?B?Q1lWMERkTytNbjhyN3pZYnRVWmhLMXdrT3NxbnY0M3k5SHVSQ3ErYkNodzN4?=
 =?utf-8?B?T3c4S2JRRlBCb1dYY2xSalUwenZlbEN6cHltMHJQWFpvRWlpa3VVaEhGRXpi?=
 =?utf-8?B?b2hEUkNaeWxtWFJoVmdQQWtLZmoxN0VlMEpuakxXeXNzS3dtQjB4SmNxRHBD?=
 =?utf-8?B?VUNoWncyWTJBMS9aZlB5VDlvdGZYUmZ0aWM0NmVyT09vTk1qckxEdm5kM25w?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26236D74E64B7A469F27394F24D4DCD1@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94df9c37-27bd-4498-bab6-08dc0d3cb97a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:49:24.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41WRuFUtPBoPyDwvP0syA8dfnqqqNnN/YgNE+tc3MgLQgPxKnUygX7Bt3/Mhqrobpwf8Z1cLW2O3ftuzdjn8ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8709

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzRQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBfX29mX21kaW9idXNfcmVnaXN0ZXIoKSBhbHJlYWR5IGNhbGxzIF9fbWRpb2J1
c19yZWdpc3RlcigpIGlmIHRoZQ0KPiBPRiBub2RlIHByb3ZpZGVkIGFzIGFyZ3VtZW50IGlzIE5V
TEwuIFdlIGNhbiB0YWtlIGFkdmFudGFnZSBvZiB0aGF0DQo+IGFuZCBzaW1wbGlmeSB0aGUgMiBj
b2RlIHBhdGgsIGNhbGxpbmcgZGV2bV9vZl9tZGlvYnVzX3JlZ2lzdGVyKCkgb25seQ0KPiBvbmNl
IGZvciBib3RoIGNhc2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0ZWFuIDx2
bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4NCg0KTXVjaCBuZWF0ZXIhDQoNClJldmlld2VkLWJ5OiBB
bHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4gLS0tDQo+ICBkcml2ZXJz
L25ldC9kc2EvcWNhL3FjYThrLTh4eHguYyB8IDI0ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ==

