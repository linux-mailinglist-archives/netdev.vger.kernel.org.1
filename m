Return-Path: <netdev+bounces-47470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3284B7EA5AB
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6A1B280E46
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD12D627;
	Mon, 13 Nov 2023 22:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="fMossyaB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4792D622
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 22:01:19 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2093.outbound.protection.outlook.com [40.107.241.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD90D50
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 14:01:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzQvixMuwjJh8icfTLVxwYIGG4V/3ufkDVWmipIEnuSM+RQB04LyK/8GYsnk6nHn8IYOXCqcA0nwj1hpPIX0f4wwI+Z47hpDhzMhiEgko/2THUOR1S+Bq8TsOLmH1Vm7044k2yBXPv78QS+0oKHUNCtZJ5Z0zb9E1Y7ueQyV2fAK7FkJiNar3Zc89K/JMMkI2oFmsW/ITr8JJtCbQpbxAuJQdq482kQVw76ocIDsodcKbR0UWam9mJbRpXMeXocF7cXq96ZTXTjzGucRTdlFAdtoDPAWbFmVTmuSijEIRSpOeu6sp/q7iQRu7NMT+qRfi22yOV8jO/CyM3ZTNacUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2sPPtBVnQ4PdwD8Q4FcA8yIP5VwMI4I7TSsoPISCdU=;
 b=Y29f1mdyVbxmXMDYgiy+Ts/pVTv8+kowGB3BVCS6Jn+59gA7uzeZzy0R58kRLpYYQyXUSo15NcWVOonNRCoB+WC9pxQ1G9Q126rhDDGiAJK5qQpuChXm4qZROEPKCKkKbaf5mRvNfq42PrTFE/JEc1qE/egpqNoxupsDH+kYrGNh6V5W7vl71TTi2mbfzx/438Xk1bT7OZ/hfNQ/mjkD4kMgrctTI00qxdXEJeqZjGILT9mKlUx3SlWm/EArr9rWjfng6ETbhIhT0h5GWmQXC01F0TKdp4PLNvKchoxsXDPB4TSRccx6q9VGzFBacmwfi/cHUr0OX0qZ+olmiovTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2sPPtBVnQ4PdwD8Q4FcA8yIP5VwMI4I7TSsoPISCdU=;
 b=fMossyaBZA+C3lbpMcRc017ZzW299XoRuuDJiyWJAiI4TRtPpgD0TeuVbxZNTeVi4BuuYKlj4p9JJPRAtAcI3U/NQ9KJ8zCcDl5ciMZCe5mTans10vYB3ZesYfqzJdEodRW8gVQJXDh/B1cmXIIFRmT+Inf6pMftUzEbcbwb1ys=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DU2PR03MB9999.eurprd03.prod.outlook.com (2603:10a6:10:490::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 22:01:14 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 22:01:14 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
Thread-Topic: [RFC net-next 3/5] net: dsa: realtek: create realtek-common
Thread-Index: AQHaFOoNI547PA9VREqsu69hcxAfsrB37tuAgADK94CAABYvgA==
Date: Mon, 13 Nov 2023 22:01:14 +0000
Message-ID: <gy4k3p2b7n4urwpdvl2x6dwmyyb6rcjvzxhi5gggn3hn7n66ab@2g5hwu732644>
References: <20231111215647.4966-1-luizluca@gmail.com>
 <20231111215647.4966-4-luizluca@gmail.com>
 <CACRpkdZShX2d8EJheuNEVpC=Tf3oP53Khs071XFccTskfY1b1A@mail.gmail.com>
 <CAJq09z6NOLkury=kEa9SjiGPX=X7Pc3kAi4L88LOb=_DoD4ZzQ@mail.gmail.com>
In-Reply-To:
 <CAJq09z6NOLkury=kEa9SjiGPX=X7Pc3kAi4L88LOb=_DoD4ZzQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DU2PR03MB9999:EE_
x-ms-office365-filtering-correlation-id: 9f0c94ee-3758-4574-5ff6-08dbe4940ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WUHHB8kxnQKElKTQ3FoFxvicCpPKcb99CVIPqtDz5t5PE+DqDGz+a/zfIwuv2i+bhnfQ28uQdw3CHmlPZimvg1npdmxB5Sfw6TSI0JHyL6J2IzN/dhdH6HtS16vtZbedNy7EWCwAoThoVaCd1CIajjH2jXAtwrfrScOwz7mbEyGDDHlVzcMS0fyR6f6DZvAIEIAs7FIDG7s9vHHwNtEo8HaXJZzYwk3h1vWIFTGHl/Iu0eoAwa9I4crHtl51A49BzGazBu30T9kYjBGW98XiZpoixuXeTAN5VWEoSiScm8wQKWir3lQCSVVzNLEFChFxPAgx7naPQa0mS/F5pT76AgYVBIVYJmJ8UEoZrpSKTOAKIDmGzil5BreKo4LCJ9U57mnZGQhW/2vsJrXvybA2Oru8a6X9w05nms4JRO247RIcdZPP0u4y/uubOLqf1RcFvC3ybH/zEhKZQg2Ez+pWFN07prssT3K5P+e+63x1yl/kD5/3hNvHkhfGv1Mxh4Y9ugA3M9o47g22v71aYNq7PfEGGQGQkQdQG5Az70LL0++XClb6yM2OVgkto1GpI4fU32CBWH056uJQ0tjJma7x/62o6+Srp+TQuDgS/1UnOoeq+raC+fArsM1yIC6NlnnN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(346002)(396003)(39850400004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(71200400001)(6506007)(33716001)(9686003)(6512007)(83380400001)(4326008)(8936002)(5660300002)(8676002)(2906002)(41300700001)(7416002)(6486002)(316002)(478600001)(91956017)(64756008)(66946007)(76116006)(66446008)(66556008)(6916009)(54906003)(66476007)(86362001)(85182001)(38070700009)(38100700002)(122000001)(85202003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW9LaFVUK2I1Smg3dlQ5UkRFSDNkVHR3YUJCSkNlSnJyVHNkdmdsOWRsYTNp?=
 =?utf-8?B?M0xYclVFY0ZFcWFMU0pkL3ZUTUFFNlNLVHV1azFibGVvSEFHalRVZHc5YmFj?=
 =?utf-8?B?Njgwdkl5Vk1pTHU2QU1kMldhNHVhT09tVkpoTmVNWWRKbUl4eE12NEt4OTF0?=
 =?utf-8?B?ZU9JYmtMeVZMdlp2aTJwY09QQlBMUnJ2K2RsTDhSN2xJNU9TZDFiM0NIVzdk?=
 =?utf-8?B?ellLbThxMDY0ZUhYT0pVNmd6aGNUU2lsNHJ3WVk2VmdkVW1tT0Y5Q3RPTlcw?=
 =?utf-8?B?NDV1aWoxSEM3WkJXRGd3c2RHN0VJODVuSXlVakVYZG5KYmEvcXJjME1VTEF2?=
 =?utf-8?B?NStON3NoZG9XQVZONGozZkpqNHFYSXVOTFc2SkcxQlJzNnoyUkZlYXVwS2RB?=
 =?utf-8?B?SjR0OTF2TEpMTzU2aXV5MDdkdGVFY2NWbDZGZXBlc0RQa3FOZzRTYzdnaENK?=
 =?utf-8?B?cmlXVGwzVlFCS2VCYkh1UE9rWG9pUjFzeGhnS2MyWjNrdTlrdWdTWDNTUnRC?=
 =?utf-8?B?Tjl0dzFaTkNERG43L3hGWDdFNlBNU2Z2amNSbTYyUHJUdFVCSUE4Y3FlK0dT?=
 =?utf-8?B?TjZqR2NTOWNYS2NBQys3MGhZVUlRb2pzRXMyUFhGVDgrdEdHSnhSQ1g0dk1a?=
 =?utf-8?B?Z2s5L0VDU2IrdWxDK2p3R2JwRGJJakVwajFxNTBXNFUySlRQbDlmYkNuUE5P?=
 =?utf-8?B?M1NsU2RQVTVUSkl1RGFwTTZzaDlXMEhIRjVtVktJMHVYdGlyWEo5c0RNSlZU?=
 =?utf-8?B?enhiNHBXeDRyMGI3OStsL3JKbzRnQzdiY3lIVFlkVUc1WEdwdFFUOHRQYW04?=
 =?utf-8?B?aFN1aTZsWGhJMVhJYVNTM3l0ZkR6RjZIVjcvVkRKdmpQLzVhWExWZk5kNTVq?=
 =?utf-8?B?MkxZTmw2R3R2dlpMUGRGU0x6dGs4djJHbEt4dS9GblJyS0x3YlRTeHg2Yk1y?=
 =?utf-8?B?amJNbHdBNTNOdjAzaHp1YURoYVgzSGM0T05JNzRZUWFXeEc2c1VPQTFyM09k?=
 =?utf-8?B?UEpvcUcxK2FpSFJucFpXRk1UVm44azdYdTIwcVpRRVRqcmJLNXdxQmk5V2F3?=
 =?utf-8?B?OHRNSTNIRUgxNmlrWHVVU1J2ZjBvRGdpeWlWclkrb0F2TURGVU8vVXA4bTVE?=
 =?utf-8?B?bmhMWWtwRGo1U3YwajR6V1RqT3JLTzUvK0NGcyt3Y2FRUlBHUnFBdmo4dTk0?=
 =?utf-8?B?S1VLRkEwMkVKekZFV0xkOEMxMG12VnNveXJhR3pRTlJMd2lIQmt6UG5qcEY2?=
 =?utf-8?B?T3RKRzZMdWQwZXZzS1k2SjBDQ2p6YVJiWHU2SVV1Y0Nnemw3cjRUWHp0ZVpD?=
 =?utf-8?B?clY4U1pQQjdMTStMTmNMU0sraUljQ0FheUVnYkZncE0yRlI4Ni91SlYvUVJF?=
 =?utf-8?B?Qk1rTTJZclU4eVhUZmNTWGVnK0FTd21oekNlVGhYM2lyNXIyeU53QUJIWjR3?=
 =?utf-8?B?dm0ybGlXelVRN3NRQVdOTkNDWHozdTQ2em5GdElaRnRaRGU4eFFYRXRWSEVY?=
 =?utf-8?B?a2Z1ZEZGMHN2NWdUb29vZ2lMVU1DVmkyaXllL3NCOUx6SHUwSEN6V2RwbTBN?=
 =?utf-8?B?WU0xcEVibFVqYk5pZ2VSb3lXellSN2swRUhBa1JzUy9sMFpUbDgxT1lTVndT?=
 =?utf-8?B?RmJjK1lTSWFMSVRjMk04M05IWnROMmZGUzN3MDhpTTVKU0Q4NTBpRnpYUm5r?=
 =?utf-8?B?MlFtNTNKYjVuSVR3NkJDUTcrWnpLQ1QxQUFDaFJ5Wml2SytBUENWZEQ3cE1D?=
 =?utf-8?B?L1BCeGJWY2xYRVZlVHhVenlDT3BxMFZSemtLSXMzR0JnRzRsYy9ycVBLZGdq?=
 =?utf-8?B?cnB2ZExTcTFGWVhSN1VnMkk1Z3dZY2hneEFtWEgzdTJ5VkVGOTlQSjhsV3Uz?=
 =?utf-8?B?dmdSNnRiMWFMN0FBNUVaRzFvRmRqN2JoOUVoMDErcCtidkVlTzE0d1pDcUVT?=
 =?utf-8?B?NHNXWTZudU1kWWwzaUF0aFJ3eE9LVC9CYlFHTVRuajVNdk16N01JTDUzL0Jx?=
 =?utf-8?B?ZFFjeVErUitFbGVNNjZrWlpZVkRUUm94SlNHenQ1Vm1BeVNjdnJSeWhjVWhC?=
 =?utf-8?B?aHBuQmRKNUMzNVNyTGRuT0VDdU9OZEZQRElEYng2WGhzTkdvWGJqd2w3SXRs?=
 =?utf-8?Q?ePP/v+wCpBE9Em3UDY9ze8VgV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09C2DF863776354A8C0BA70BE5563034@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0c94ee-3758-4574-5ff6-08dbe4940ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 22:01:14.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gom7dRAGnBmoNwn4WMxlLr3RcEfefVfXJDgdCbg0gjQzRacLueXLHC09yRy4FkUm56PkuynmdBehxBXQy3zs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB9999

SGkgTHVpeiwNCg0KT24gTW9uLCBOb3YgMTMsIDIwMjMgYXQgMDU6NDE6NDlQTSAtMDMwMCwgTHVp
eiBBbmdlbG8gRGFyb3MgZGUgTHVjYSB3cm90ZToNCj4gPiA+IFNvbWUgY29kZSBjYW4gYmUgc2hh
cmVkIGJldHdlZW4gYm90aCBpbnRlcmZhY2UgbW9kdWxlcyAoTURJTyBhbmQgU01JKQ0KPiA+ID4g
YW5kIGFtb25nc3QgdmFyaWFudHMuIEZvciBub3csIHRoZXNlIGludGVyZmFjZSBmdW5jdGlvbnMg
YXJlIHNoYXJlZDoNCj4gPiA+DQo+ID4gPiAtIHJlYWx0ZWtfY29tbW9uX2xvY2sNCj4gPiA+IC0g
cmVhbHRla19jb21tb25fdW5sb2NrDQo+ID4gPiAtIHJlYWx0ZWtfY29tbW9uX3Byb2JlDQo+ID4g
PiAtIHJlYWx0ZWtfY29tbW9uX3JlbW92ZQ0KPiA+ID4NCj4gPiA+IFRoZSByZXNldCBkdXJpbmcg
cHJvYmUgd2FzIG1vdmVkIHRvIHRoZSBsYXN0IG1vbWVudCBiZWZvcmUgYSB2YXJpYW50DQo+ID4g
PiBkZXRlY3RzIHRoZSBzd2l0Y2guIFRoaXMgd2F5LCB3ZSBhdm9pZCBhIHJlc2V0IGlmIGFueXRo
aW5nIGVsc2UgZmFpbHMuDQo+ID4gPg0KPiA+ID4gVGhlIHN5bWJvbHMgZnJvbSB2YXJpYW50cyB1
c2VkIGluIG9mX21hdGNoX3RhYmxlIGFyZSBub3cgaW4gYSBzaW5nbGUNCj4gPiA+IG1hdGNoIHRh
YmxlIGluIHJlYWx0ZWstY29tbW9uLCB1c2VkIGJ5IGJvdGggaW50ZXJmYWNlcy4NCj4gPiA+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6bHVjYUBn
bWFpbC5jb20+DQo+ID4NCj4gPiBBcyBLcnp5c3p0b2YgZXhwbGFpbmVkIHRoZSBkZXZfZXJyX3By
b2JlKCkgY2FsbCBhbHJlYWR5IHByaW50cw0KPiA+IHJldC4gV2l0aCB0aGF0IGZpeGVkOg0KPiA+
IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+
IA0KPiBUaGFua3MgS3J6eXN6dG9mIGFuZCBMaW51cy4gSSdsbCBiZSBmaXhlZC4NCj4gDQo+IElz
IGl0IG9rIHRvIGtlZXAgdGhlIHNlcmllcyBhcyBhIHdob2xlIG9yIHNob3VsZCBJIHNwbGl0IGl0
Pw0KDQpJIHdvdWxkIHByZWZlciB0aGF0IHlvdSBzcGxpdCBpdCBhbmQgc2VuZCB0aGUgcmVhbHRl
ay1jb21tb24gc2VyaWVzIGZpcnN0Lg0KTXkgMmMuDQoNClNvcnJ5IGZvciBub3QgcmV2aWV3aW5n
IHlldCBidXQgSSdsbCB0YWtlIGEgbG9vayB0b21vcnJvdy4gQ2hlZXJzIQ0KDQpLaW5kIHJlZ2Fy
ZHMsDQpBbHZpbg==

