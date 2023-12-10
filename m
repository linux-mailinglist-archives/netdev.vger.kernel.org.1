Return-Path: <netdev+bounces-55635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1876A80BB46
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 14:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A891F21078
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650D11739;
	Sun, 10 Dec 2023 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="tXzwdrLj"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2135.outbound.protection.outlook.com [40.107.14.135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283DBD9
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 05:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RREIv4oTXotg6Kas9/ID8EYH6IDg7vfFQe/G6gB/grstSdrjm5ZkrgXcgB8tzIFSnKAYJBF/YJr8SphMsd3bTAp5pwl7gc5pfGBUFU79ZkIcW9fx98yrObZ2+loO2MjCM8nCaTtWsf5pjKPb8ZruZ8hPwHonBv4sVhLzaw3f9FTwh0Gr3gefXAm92QQmSdUmfl3OM4YGtkmxIigOmPYv/Xe8LYcUOl31PQUL5+vtc94VO/HNTBK216zyo/22lNtXha7bGCNT56PNKy58SMuXc9Ye5Gt44Yiv2zZ1VPiMepBL7Dta/nhQyBMuRR/+AbgXo8SMo87hcy6gkjzNT+HK1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmWBLHlcLANIBiJ1ObONj/CwaRktDDth+/P4IlxAu9s=;
 b=PikM4uHZkY3v++Se+jZuIgQHGJvBE7Kwa0UClxjyzFm81jKU6c0ucu8pcXuXbJdjbwreuDtXYarzbbXhtp2nQ+N6RTMLN4qEbd/y6e+/0Ty2hTDkgTaK4o0MBN+X5CWoY0D5myzx23SHjPiy73RITgITe7z62gj4VcU4EhfNLbV9Xzs0cNCw0/l9ZeaZsSWXyt2YcHTSLX2HDQO3D/n9+PX/CLDdjpGIvytCIe1Cgmb+q4AmKEHaq93sJWtVvdD/gI5BBjUNK/N8VIv2+pgUPCNxWwpIEAS9c5v1wDxBWxwy6bu5rVE3QhKBl2la4gH0/BAa5WxJ6PQiFlqTvmYzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmWBLHlcLANIBiJ1ObONj/CwaRktDDth+/P4IlxAu9s=;
 b=tXzwdrLjI3M7sYGt1HtjEEgrxcCBMl5jn0YUXn0cvNKPpKQFrSbYcPU22MR2YnXQJpk3fzLRHEubE8wCiL94avlilu5pUoKQvfHvcfmjc2yooIws4OF9HNATN17OJijyJT8hVFryec/VzOE+NVkcYwbVoQsdHU9auz3UH0GK8dA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAXPR03MB7998.eurprd03.prod.outlook.com (2603:10a6:102:21d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.31; Sun, 10 Dec
 2023 13:48:12 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.030; Sun, 10 Dec 2023
 13:48:12 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Luiz Angelo Daros
 de Luca <luizluca@gmail.com>, Madhuri Sripada
	<madhuri.sripada@microchip.com>, Marcin Wojtas <mw@semihalf.com>, Linus
 Walleij <linus.walleij@linaro.org>, Tobias Waldekranz
	<tobias@waldekranz.com>, Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Thread-Topic: [PATCH net 3/4] docs: net: dsa: update user MDIO bus
 documentation
Thread-Index: AQHaKg3ogPI6p95uxkmpUe5eZ1ijl7CiiuuA
Date: Sun, 10 Dec 2023 13:48:12 +0000
Message-ID: <r247bmekxv2de7owpoam6kkscel25ugnneebzwsrv3j7u3lud7@ppuwdzwl4zi5>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-4-vladimir.oltean@nxp.com>
In-Reply-To: <20231208193518.2018114-4-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAXPR03MB7998:EE_
x-ms-office365-filtering-correlation-id: e716eb26-aa36-4666-308b-08dbf986a6b3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V0QrQJekRgDQ8FSLM6kCJNf7QZ0Dj+FtUoSTkUGQmNO8llEE0+iB6C8t/2z+/9JyIxm5mR4ihN3Xxk3a4O6VGuNL0gEXfqy+633flyMCyGUgacQWin+krJZEgz0D3h6v/Mo3LXsaMp+Kzd5rE305KyLtPu+CtajEL+vxt3YgN5W5UFusdy3DrZ3OhMrKGRqOgIOhsl6WtZJpUTsBx/LzCZPm57t7Lg92li6JfJH3IhYnvu56hBe2tdTKC8EPy2jPgjKro/KgjrxShTZxBtVv6AtC290pB3x/8t/nNVZlCob4IYhq0Nv3TYNfCLS+d9w6HdH8AwV6mBfUh8ZmKShvuG1RVVUeV2NkWlnOmgpUOOv8Cdal34C0dDPESYVZjfaWObO2Q4+058ERyFXk1kJ3rfo+xHIFvkxXzp7L2RyzEurPrNV7WlaJYo9s1xVZC4uanoPiVutQhRini+EmPu1ndmw7IoyVuuDWjJeJVBLcKrOu0dPzp0YY6BBV2VJLo+1q2a7nK+EKX+WWLta09QoEc5XbjPOtwcld1TDClx63AwYi8WM1IsoBh1s+i6p0VLpzSwPsrJBLTm2ceSJ3TyTGQYdk0WAmvuNn9LySuWfXWy5W9DbjX6GIqXy8zQCef6byHn1Y1kgYr+JCX4i3jZJV6D86GMFmVShKhY+kvIV09rI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(39840400004)(346002)(376002)(230273577357003)(230173577357003)(64100799003)(1800799012)(186009)(451199024)(6506007)(6512007)(2906002)(7416002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(9686003)(71200400001)(122000001)(38100700002)(86362001)(85182001)(85202003)(316002)(8676002)(8936002)(4326008)(5660300002)(91956017)(76116006)(6486002)(478600001)(41300700001)(33716001)(66574015)(38070700009)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckZGRGxDM3Vkd3dyckVrS2V1M0liRDlBRXZzdTNLTzgweEppU0o4STJQbExo?=
 =?utf-8?B?bXI5TE01RW9ET09sS3VhTE9RWFpGY1J0TU1wVFROQ3o5d2NwT0Y3K1ZZM3dL?=
 =?utf-8?B?dFpXYWtrUGxCV1J6NHZ1NHZtYXJTdnBoU3hLb2U4SmxDaVN5bEcyQVVmMitX?=
 =?utf-8?B?RXR0YWRoaFoxMjM3c0VKQVNPUEQweG10R3FVVit0aFNubmRHMVdBMEVleWJJ?=
 =?utf-8?B?bmx5UllESGxTTVU3aktXV2pHL1AwbFRxVjR2dDJPWlBTR2VrT0lWL05YMmFY?=
 =?utf-8?B?cDBJVTZ1anRYSk5QTXBBRm5FcVBXOVlMRG9DSFEyWFlYYis2NEV1M29rTmNE?=
 =?utf-8?B?OTZ1bmM4d0hBR0Fjc1d5QUJtaUUwQUE0clVkUEViTVRJdS9VYXRWTTRzYWl2?=
 =?utf-8?B?S0pacUxGdWhITzY4TTNZdXYxTFBORDJMdTFmYitmL0h4UnlLem5rbmEvOWlM?=
 =?utf-8?B?ajM5WWN6WmhBMlhGQnRzK3g5VXdvd3pCOWdWdWhML1J3WWNyNkEybHduY2p4?=
 =?utf-8?B?aWQyNWNZMW5oeFIreVVheFRhMVBhRXNHQ2tnNUFDL0pEQ0t1aEUzd3pzbTI1?=
 =?utf-8?B?dmgzanRzNDRNaFNGQkpwWG9hV2hKUmtvbFFOYkJCbTQ1RnRCTUJLaW11MnFH?=
 =?utf-8?B?UjVQdG9jMkFtK1YzZFRnK29DVGM2ZjFkTUJTVkZmUm1jMGpPQnpORHc5aTdS?=
 =?utf-8?B?U2t1OFd0bHByc2tPTWRWTVl2Z1FlUWJZTWpRcE1FMWNnNldrcUwzbmxFM2Ju?=
 =?utf-8?B?UkZRL1pqSzFpdU02aDhuY2ZaWkcrcmd1SjFMa1JLb2ZPb041Ymp2QU54Zk9R?=
 =?utf-8?B?enY1M1lnaW16N0JTb280QWtkRjg3TjhSKzNEdTB3U3FqbVFxRzROcWF3cml0?=
 =?utf-8?B?SUxSNmF3M3NBZCs5U0FjeVpIcEJYMm0wT054RzU2azZoamZZb2VmL250TzQ4?=
 =?utf-8?B?OERFVFZNbHJRSG5OUmpMTWhBbmhnZWNERnhNcVpBby9RcUJveGRKd1J4MDR5?=
 =?utf-8?B?UVBqRTFEeE9uUVB1ekc5dkxyNG51YThTL0JGb2JXejZHZC9OUzF4MHVQanpx?=
 =?utf-8?B?cFNBMVF5Nk56Vk54WGhrSEdPVmJuSktBNGNUZzI5NFdKSFZvbGZERGVmQnYw?=
 =?utf-8?B?SVVtWS9lb3ZUTVVudnlDWEUxRDdpVjlIZnFHbVZYQnRUa0U4VFdiMG5iS0ZV?=
 =?utf-8?B?TlVtd1FwQzBsYk5yMUdhVGU4a2JOWVdmdUs2ZU9ESS9LWGRrMUFPRCt5T3FL?=
 =?utf-8?B?NHJiNWN4T0x0NFZCWXRKdXNJMkNmYW5oWnpzSFQ3N3Z0K2p1UXhybmVDeGdt?=
 =?utf-8?B?RkRVYngxY1hhWUJVd2hKUUdUSHROZ0I5ZUhNVm80VWMzV1ZFUlRXYk4yelBh?=
 =?utf-8?B?MjRWemliYjExcllpR2FoTWlJV2pnT2lMd1A4MW4zVnVaQVZ4UVBZaGRLZ0t0?=
 =?utf-8?B?NzZVMTJJRkRYakJKSi8yTmRSaE5SRFhsa0VoeDZYRzdGWVJtUVFRZDBZSFJL?=
 =?utf-8?B?MzR6YzdGNHF3c3NJTGVUYitmZXhPcFRIQStmTnNBQU8vUmwxL2hQaWVGRTVB?=
 =?utf-8?B?NktsWDNCVTJSSjkxUVBiSE9KcmwzQWo3anB6VGtPK29HV3Z2YlJrVnJES3h5?=
 =?utf-8?B?TUx0cGxaSS81Rk9Fd2JyUUhYSG8xWFNkcHgwSkRBbnRrRkF3cmVVYURaejJ1?=
 =?utf-8?B?WHgyb2s4aDE4dzQvWFRjeVFpeHgwNGg4b0dOUE14MWdYdTF5eGZoUEJ3Wk5j?=
 =?utf-8?B?alpWSXN6YytyTzlQN1VzaDhsclBhcUVSOG9vaXc4WE9xbWtDMEJocHROMnov?=
 =?utf-8?B?ZEcyWkFtNllTc3l4OTFvRVhBMFhsSkxiVDFPYzBvWnJ3bWZQTEtzOElBcVpC?=
 =?utf-8?B?VVRjampuVWU3bk5OZlpnNE9EQzJrWWFZdTFQNjN1eVhIQTlxRGpmVE1GMlc5?=
 =?utf-8?B?S213OVZRM00xb3dNcVRDYWhIRUVyQ0RaMTRndEc4Y0p1WSt6Mkwyalk0cDQ5?=
 =?utf-8?B?RDRNaWN3MXprcVFRK0NOeVZDZ3ZlblBWNE1INUo1Z0NJSWVjcklUdG10TUJ2?=
 =?utf-8?B?QmJYWk44aUNJaUpwM3pJT2I5MHBwMVdhc09iZWxwOFoyV2ZFMkxUa2FxVUNV?=
 =?utf-8?Q?37PjPQQ9yK8zUznPahkWa/C+n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14FD40BF924B2441A35C1693DAEC79BC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e716eb26-aa36-4666-308b-08dbf986a6b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2023 13:48:12.0287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJ6gVI6DJlAoJEV3z6kyI/NdXVTqtR67zpsOKkH2O0YD8WfciPwIWzCH4AuvWrANTaKtSAJUkc4kHABffGfTuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7998

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDk6MzU6MTdQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBUaGVyZSBhcmUgcGVvcGxlIHdobyBhcmUgdHJ5aW5nIHRvIHB1c2ggdGhlIGRz
LT51c2VyX21paV9idXMgZmVhdHVyZQ0KPiBwYXN0IGl0cyBzZWxsLWJ5IGRhdGUuIEkgdGhpbmsg
cGFydCBvZiB0aGUgcHJvYmxlbSBpcyB0aGUgZmFjdCB0aGF0IHRoZQ0KPiBkb2N1bWVudGF0aW9u
IHByZXNlbnRzIGl0IGFzIHRoaXMgZ3JlYXQgZnVuY3Rpb25hbGl0eS4NCj4gDQo+IEFkYXB0IGl0
IHRvIDIwMjMsIHdoZXJlIHdlIGhhdmUgcGh5LWhhbmRsZSB0byByZW5kZXIgaXQgdXNlbGVzcywg
YXQNCj4gbGVhc3Qgd2l0aCBPRi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVh
biA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9uZXR3
b3JraW5nL2RzYS9kc2EucnN0IHwgMzYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2EucnN0IGIvRG9jdW1l
bnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2EucnN0DQo+IGluZGV4IDY3NmM5MjEzNmEwZS4uMmNk
OTEzNTg0MjFlIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvZHNhL2Rz
YS5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2RzYS9kc2EucnN0DQo+IEBA
IC0zOTcsMTkgKzM5Nyw0MSBAQCBwZXJzcGVjdGl2ZTo6DQo+ICBVc2VyIE1ESU8gYnVzDQo+ICAt
LS0tLS0tLS0tLS0tDQo+ICANCj4gLUluIG9yZGVyIHRvIGJlIGFibGUgdG8gcmVhZCB0by9mcm9t
IGEgc3dpdGNoIFBIWSBidWlsdCBpbnRvIGl0LCBEU0EgY3JlYXRlcyBhbg0KPiAtdXNlciBNRElP
IGJ1cyB3aGljaCBhbGxvd3MgYSBzcGVjaWZpYyBzd2l0Y2ggZHJpdmVyIHRvIGRpdmVydCBhbmQg
aW50ZXJjZXB0DQo+IC1NRElPIHJlYWRzL3dyaXRlcyB0b3dhcmRzIHNwZWNpZmljIFBIWSBhZGRy
ZXNzZXMuIEluIG1vc3QgTURJTy1jb25uZWN0ZWQNCj4gLXN3aXRjaGVzLCB0aGVzZSBmdW5jdGlv
bnMgd291bGQgdXRpbGl6ZSBkaXJlY3Qgb3IgaW5kaXJlY3QgUEhZIGFkZHJlc3NpbmcgbW9kZQ0K
PiAtdG8gcmV0dXJuIHN0YW5kYXJkIE1JSSByZWdpc3RlcnMgZnJvbSB0aGUgc3dpdGNoIGJ1aWx0
aW4gUEhZcywgYWxsb3dpbmcgdGhlIFBIWQ0KPiAtbGlicmFyeSBhbmQvb3IgdG8gcmV0dXJuIGxp
bmsgc3RhdHVzLCBsaW5rIHBhcnRuZXIgcGFnZXMsIGF1dG8tbmVnb3RpYXRpb24NCj4gLXJlc3Vs
dHMsIGV0Yy4NCj4gK1RoZSBmcmFtZXdvcmsgY3JlYXRlcyBhbiBNRElPIGJ1cyBmb3IgdXNlciBw
b3J0cyAoYGBkcy0+dXNlcl9taWlfYnVzYGApIHdoZW4NCj4gK2JvdGggbWV0aG9kcyBgYGRzLT5v
cHMtPnBoeV9yZWFkKClgYCBhbmQgYGBkcy0+b3BzLT5waHlfd3JpdGUoKWBgIGFyZSBwcmVzZW50
Lg0KPiArSG93ZXZlciwgdGhpcyBwb2ludGVyIG1heSBhbHNvIGJlIHBvcHVsYXRlZCBieSB0aGUg
c3dpdGNoIGRyaXZlciBkdXJpbmcgdGhlDQo+ICtgYGRzLT5vcHMtPnNldHVwKClgYCBtZXRob2Qs
IHdpdGggYW4gTURJTyBidXMgbWFuYWdlZCBieSB0aGUgZHJpdmVyLg0KPiArDQo+ICtJdHMgcm9s
ZSBpcyB0byBwZXJtaXQgdXNlciBwb3J0cyB0byBjb25uZWN0IHRvIGEgUEhZICh1c3VhbGx5IGlu
dGVybmFsKSB3aGVuDQo+ICt0aGUgbW9yZSBnZW5lcmFsIGBgcGh5LWhhbmRsZWBgIHByb3BlcnR5
IGlzIHVuYXZhaWxhYmxlIChlaXRoZXIgYmVjYXVzZSB0aGUNCj4gK01ESU8gYnVzIGlzIG1pc3Np
bmcgZnJvbSB0aGUgT0YgZGVzY3JpcHRpb24sIG9yIGJlY2F1c2UgcHJvYmluZyB1c2VzDQo+ICtg
YHBsYXRmb3JtX2RhdGFgYCkuDQo+ICsNCj4gK0luIG1vc3QgTURJTy1jb25uZWN0ZWQgc3dpdGNo
ZXMsIHRoZXNlIGZ1bmN0aW9ucyB3b3VsZCB1dGlsaXplIGRpcmVjdCBvcg0KPiAraW5kaXJlY3Qg
UEhZIGFkZHJlc3NpbmcgbW9kZSB0byByZXR1cm4gc3RhbmRhcmQgTUlJIHJlZ2lzdGVycyBmcm9t
IHRoZSBzd2l0Y2gNCj4gK2J1aWx0aW4gUEhZcywgYWxsb3dpbmcgdGhlIFBIWSBsaWJyYXJ5IGFu
ZC9vciB0byByZXR1cm4gbGluayBzdGF0dXMsIGxpbmsNCj4gK3BhcnRuZXIgcGFnZXMsIGF1dG8t
bmVnb3RpYXRpb24gcmVzdWx0cywgZXRjLg0KPiAgDQo+ICBGb3IgRXRoZXJuZXQgc3dpdGNoZXMg
d2hpY2ggaGF2ZSBib3RoIGV4dGVybmFsIGFuZCBpbnRlcm5hbCBNRElPIGJ1c2VzLCB0aGUNCj4g
IHVzZXIgTUlJIGJ1cyBjYW4gYmUgdXRpbGl6ZWQgdG8gbXV4L2RlbXV4IE1ESU8gcmVhZHMgYW5k
IHdyaXRlcyB0b3dhcmRzIGVpdGhlcg0KPiAgaW50ZXJuYWwgb3IgZXh0ZXJuYWwgTURJTyBkZXZp
Y2VzIHRoaXMgc3dpdGNoIG1pZ2h0IGJlIGNvbm5lY3RlZCB0bzogaW50ZXJuYWwNCj4gIFBIWXMs
IGV4dGVybmFsIFBIWXMsIG9yIGV2ZW4gZXh0ZXJuYWwgc3dpdGNoZXMuDQo+ICANCj4gK1doZW4g
dXNpbmcgT0YsIHRoZSBgYGRzLT51c2VyX21paV9idXNgYCBjYW4gYmUgc2VlbiBhcyBhIGxlZ2Fj
eSBmZWF0dXJlLCByYXRoZXINCj4gK3RoYW4gY29yZSBmdW5jdGlvbmFsaXR5LiBTaW5jZSAyMDE0
LCB0aGUgRFNBIE9GIGJpbmRpbmdzIHN1cHBvcnQgdGhlDQo+ICtgYHBoeS1oYW5kbGVgYCBwcm9w
ZXJ0eSwgd2hpY2ggaXMgYSB1bml2ZXJzYWwgbWVjaGFuaXNtIHRvIHJlZmVyZW5jZSBhIFBIWSwN
Cj4gK2JlIGl0IGludGVybmFsIG9yIGV4dGVybmFsLg0KPiArDQo+ICtOZXcgc3dpdGNoIGRyaXZl
cnMgYXJlIGVuY291cmFnZWQgdG8gcmVxdWlyZSB0aGUgbW9yZSB1bml2ZXJzYWwgYGBwaHktaGFu
ZGxlYGANCj4gK3Byb3BlcnR5IGV2ZW4gZm9yIHVzZXIgcG9ydHMgd2l0aCBpbnRlcm5hbCBQSFlz
LiBUaGlzIGFsbG93cyBkZXZpY2UgdHJlZXMgdG8NCj4gK2ludGVyb3BlcmF0ZSB3aXRoIHNpbXBs
ZXIgdmFyaWFudHMgb2YgdGhlIGRyaXZlcnMgc3VjaCBhcyB0aG9zZSBmcm9tIFUtQm9vdCwNCj4g
K3doaWNoIGRvIG5vdCBoYXZlIHRoZSAocmVkdW5kYW50KSBmYWxsYmFjayBsb2dpYyBmb3IgYGBk
cy0+dXNlcl9taWlfYnVzYGAuDQoNCkNvbnNpZGVyaW5nIHRoaXMgcG9saWN5LCBzaG91bGQgd2Ug
bm90IGVtcGhhc2l6ZSB0aGF0IGRzLT51c2VyX21paV9idXMNCmFuZCBkcy0+b3BzLT5waHlfe3Jl
YWQsd3JpdGV9KCkgb3VnaHQgdG8gYmUgbGVmdCB1bnBvcHVsYXRlZCBieSBuZXcNCmRyaXZlcnMs
IHdpdGggdGhlIHJlbWFyayB0aGF0IGlmIGEgZHJpdmVyIHdhbnRzIHRvIHNldCB1cCBhbiBNRElP
IGJ1cywNCml0IHNob3VsZCBzdG9yZSB0aGUgY29ycmVzcG9uZGluZyBzdHJ1Y3QgbWlpX2J1cyBw
b2ludGVyIGluIGl0cyBvd24NCmRyaXZlciBwcml2YXRlIGRhdGE/IEp1c3QgdG8gbWFrZSB0aGlu
Z3MgY3J5c3RhbCBjbGVhci4NCg0KUmVnYXJkbGVzcyBJIHRoaW5rIHRoaXMgaXMgZ29vZCENCg0K
UmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4NCg0KPiAr
DQo+ICtUaGUgb25seSB1c2UgY2FzZSBmb3IgYGBkcy0+dXNlcl9taWlfYnVzYGAgaW4gbmV3IGRy
aXZlcnMgd291bGQgYmUgZm9yIHByb2JpbmcNCj4gK29uIG5vbi1PRiB0aHJvdWdoIGBgcGxhdGZv
cm1fZGF0YWBgLiBJbiB0aGUgZGlzdGFudCBmdXR1cmUgd2hlcmUgdGhpcyB3aWxsIGJlDQo+ICtw
b3NzaWJsZSB0aHJvdWdoIHNvZnR3YXJlIG5vZGVzLCB0aGVyZSB3aWxsIGJlIG5vIG5lZWQgZm9y
IGBgZHMtPnVzZXJfbWlpX2J1c2BgDQo+ICtpbiBuZXcgZHJpdmVycyBhdCBhbGwuDQo+ICsNCj4g
IERhdGEgc3RydWN0dXJlcw0KPiAgLS0tLS0tLS0tLS0tLS0tDQo+ICANCj4gLS0gDQo+IDIuMzQu
MQ0KPg==

