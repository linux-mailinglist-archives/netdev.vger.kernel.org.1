Return-Path: <netdev+bounces-55774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAA80C47B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8D1C208E1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A421356;
	Mon, 11 Dec 2023 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="KTcJ4/JW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2094.outbound.protection.outlook.com [40.107.241.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845FFF
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQRMp3NUSDb0BVMj9uoHQ+lPYKirbyWbrljXRCSy+KaUiv/YyUHcemzJG9VcUcDvWwZCmsutbznRuGNxDix24il5gyXJwlhse9jdXMbHvtBbXOJf7xFnblZQy0aZ8kkV1y4bV2lfkTWtzDnheUZk/BzQAdMFicDRFab+0PAILhMYQic+JklAeRk5O7H+hai/Jjd+7suINlokN1P8UmvpMeII1jmiS3m0B682Nv8KKYbA3mPqSkssKN4rszHQsmzmcWPxu59LkZCNo8xSHerBKXq/6NzgaJE3T5ZWQFFBEiKg3PGyWlo97b6PZAD0m3NGzLY0PBag/wWtP3BSNTeyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGq9kg7vRk3KF+K/SerwayZNTnV6/kiatYUEKkJZoSk=;
 b=HvVvGEb/yC3Iq6jw+utLFPMeJwhvLkAQaoufbaFHy3yAIco3D6eqAek65DidDxtExVn0CXOFMTCq4ytTFLyNoDOnpok5QY0BkV4juH8ONOJH5cFSAtmAvcHFXClG6oJAN996ohT8BzRHPCTdUQk6b1tq5eOIDR3gxg8ZY+XxY8me95GnJbVSvOJ4ludOYeouTjEWN9n/9M4iFW4jJZvtoFjBTFAkvseD8fXyQIht/OpwEseZzSNWcbVW4j0ZQ9M2snOzmWRlyoBzOkQIv9ufYNG4IYV/IgbVcA4OFfciKHz/nZpex1Ip8A1ACqrPeRMuZQtAhjGn4RDt/jAogNWFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGq9kg7vRk3KF+K/SerwayZNTnV6/kiatYUEKkJZoSk=;
 b=KTcJ4/JWo4YcKB8hllAsuxQlBOftDOpWE98xDOFf9v6HxCSNURnlbdP1uDmn3G7T5lZ4hNhmdjui48SwETCkGVYlxNI3N9FMAMCgHgf6u0E4AhKPQ9CoWcPvBwAY3bCZQrvsAjoz67QCbllHZCRQ34JyxaXnCg/CxY4DUE1B1lI=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAWPR03MB9714.eurprd03.prod.outlook.com (2603:10a6:102:2ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:24:35 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:24:35 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
Thread-Topic: [PATCH net-next 4/7] net: dsa: realtek: create realtek-common
Thread-Index: AQHaKZJHIXpg0PnQGkqm01IheWLMnbCfayuAgAQgLACAAEk5AA==
Date: Mon, 11 Dec 2023 09:24:35 +0000
Message-ID: <255k4l2u45si3k2o7ulcjaej7k56cgacut6lacumobywzvycm5@vvpswdlqt2gs>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-5-luizluca@gmail.com>
 <4ltsthrk2oli6ickjiy6uy3pc3kpdddse7lab34qefbadjafhy@oaxoemtrhw3k>
 <CAJq09z4YtJPnpLb3OqYaGdiPU3zPO636tu=jG08a=ROD0A=dRQ@mail.gmail.com>
In-Reply-To:
 <CAJq09z4YtJPnpLb3OqYaGdiPU3zPO636tu=jG08a=ROD0A=dRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAWPR03MB9714:EE_
x-ms-office365-filtering-correlation-id: e4dc0239-1906-4b4d-7df2-08dbfa2afd90
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HR4i4ldS7AeEQsuv/5PHuHNV4adlx2+xGWYCUDbYJ22VBDbxjWYxnOyRRxi3tDiz/RSkpbOlc0HWJhwLB913uNPZgJq+fel+ombYgDwGxhVVbRfK59YBf0HD4WCsix3Z/a0gnmzrRqPwEhXHc/u+xBEbmr37ounXkYhd5MAc9vY0f9zY/0nifPuk5DNgiH1ujNz4Ij12N4sXWCunJAz1IF33582zSOTwY6FNUcQh3GuZ0qavXEZ/J/si0HthIz4h5Yuk1B//8rwFt9JckWGn/objBmh87ck9n83meo3oJAp8ItVk+vywzuTqNS8MKwMKzDh86cmvF+/eyi14YDP+kITwvOw1GTDw4dx/StDrIwa740Z9Rcfjq13G1snD4WqDl1Q1BPzDerrD9jQ3AfKJEOgxVMPSuQnHv7UWdAHZu/W/Nr5InpRPtqsRh36sQ1f/Kxoqv/ILepmrXF2xQKMXr16G6ww/qZ+VojbgYJuLOerDii8odz0S4+kY1DwFKBsXy7wldEqArLgvIBS87KTWmSLC3TlcXrSireSh3FmV3ry/semm9UlLLywBxr0PXRDPrrH4ddeFoOp1antkWpHdj28YQn2DYY5v+YOfXjaP4uHOaTz51sZR8G1H/hlwIbYH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(366004)(136003)(396003)(39850400004)(186009)(1800799012)(451199024)(64100799003)(6486002)(478600001)(26005)(71200400001)(6506007)(6512007)(9686003)(38070700009)(38100700002)(122000001)(86362001)(85182001)(85202003)(41300700001)(33716001)(5660300002)(91956017)(76116006)(66946007)(6916009)(66476007)(64756008)(66446008)(54906003)(2906002)(7416002)(83380400001)(4326008)(316002)(8676002)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0VKV3RDMnBYdktVK05DeEhQOStNMEtqRW9mL2xXbFIyczdEelVwSzdoL2Ni?=
 =?utf-8?B?STlYOEJzYW5ZQ2plZ2d6WVFIblQ5TllHMVg1ZjZScWdpYzhNUEI3OGFGNGlE?=
 =?utf-8?B?TUEzOVNKZGwzMTkxOVNxeElKV3FlMklDZDZ5VEY3MWlwTEh2YytNT3JHUEJs?=
 =?utf-8?B?TzdySWhuaG8vbnhiSTJXVmV0VVgyekRjSXMrNjEzekhPamxkVjVvZjlLaTVz?=
 =?utf-8?B?OWhKaGdPd2kwYUFseXdtT0h0aU0yNFY0T0pOdDhzdngrcEgydkR5eGlqMDFu?=
 =?utf-8?B?d0RLL1ZHYzRLNVhlSm41SGZuOHR3RVpkOE9HQ252bU9iaDU1Y1krQ2ZLdXh6?=
 =?utf-8?B?VUZhMWFCWFVEQVBPYWJnaWlIZzVZT2hpVXBXNUZhTWp4QUI5Yi9WNVdjSG5p?=
 =?utf-8?B?d0hDSzJGcTg0UUZuTEFWTG5BYnEyRUFFdk1qQVhnR3JWeUpCUVJGU0hTTnJU?=
 =?utf-8?B?MktQTDRKVE9XWUxFbVhxMVo0aHl4UFZlOFpsN0k1RVJQRjVYdklsdlV5K0Fk?=
 =?utf-8?B?K2xiaXN4NHB0RnMyY2xtVDQ0Q3BpdGhSWnRTaEtXam4vYUJucGF5VlpOeTlj?=
 =?utf-8?B?eFZUYndPUHorWGxnWlBTbVQvc3k2Y3RSVGFPUklWdmpuL0pnRG43cVh6ZDFS?=
 =?utf-8?B?T201dDhkelZwaUlNR2tVZ2FPQ09LOEVQRzZ5cExHK2tvZDh2ZjQyZEo4Rjdm?=
 =?utf-8?B?ZlRwR2FKZXZUQXVDVEVrbjE4RmRVdyt6Znk4UTJKcWwrTUsvYnVQeEJvYzJL?=
 =?utf-8?B?ZWhpRFZrT1l1SnZWY1ZCUW1CRWRtSGN4K3Z4M0xkMXJWTlFXWFZQOUIvcGhM?=
 =?utf-8?B?cS9pRFR6WUEvSjZnM01YdVlTVTZJNGJ0djVhVTl2aTczb1Q1MzVEdTRMblRk?=
 =?utf-8?B?bUZONzBRMS9CSEpsTFpyNENUVW9UdUtUVWZsY2QvQklMZzdFVG1vVzVoUnd1?=
 =?utf-8?B?ay9xaEEwbUN1RTFESTdLbUJuM1QyNkVZcStZM3dLV2ozU2t0NmVNUEVSSXpo?=
 =?utf-8?B?R295MysxekV2Y3o5WWtYajROU3JwYkJrTzZBZS9EUTcvWlJLbUVSNHBWUXg3?=
 =?utf-8?B?N1FFN3VKWURPZ2c3WDc1WXlTZjRSTDVqWXUzbDk0dUFHaDR0ZkFSeG9xSkNS?=
 =?utf-8?B?SWlCeTZ3cUQ2WlV2aEtlZnZoQWxlcFFOam9YbUczdjkrTEJ1R1hFSWhjUzFh?=
 =?utf-8?B?SXJhNUJ3dm9HeFNBU3RQNmlNMEs3RUNtYk1BYkZ3VmVDdFVCUHk0d0E5eWZ0?=
 =?utf-8?B?V2M4dGhlOGFFTU9tTHJBQlhQMklHS05kcldUR05BZVB2RlhKaTdlNGhZMTJk?=
 =?utf-8?B?ZVVlZFNZREtHbnRNcGg2K04yZ01uYWk0L28rOEE0U0NSdmc5a28yaDVZNlhk?=
 =?utf-8?B?ak9qbnloU2hudkRTcUt6TDdXK3hoNi9aMENpTllTa3VxZWZKcXJiNFNFMFdq?=
 =?utf-8?B?Z25HbjVGVjNvR3FUQi9YWXh5a2tnc0lHbGFobEc2NUN5VFo1RmUvcCtNYTRx?=
 =?utf-8?B?d1RMSSthNWU0K2JtTFd3eTY2Nmt0WVJPbFdoK2dOSVllUzlqc1ZEMUY3a3d2?=
 =?utf-8?B?cmRCWVhHek5zdGtoMHVYWTM1bjJmVGh5a2NaZVdWN21ZRzUzSUZmd3pjYVRM?=
 =?utf-8?B?SXJnQU5DdlJDN3NsV0plZEpjeldPTkpSMUpKMXNiL2REODF2dFRpWTJFdlZK?=
 =?utf-8?B?U0ZjNTIwUTlqdzVuTG1FdnFnTWNpeE9CRGtvMng5WWh1ZitQL0ZEWGZkZThj?=
 =?utf-8?B?eWl4ZEs4SnlFa3lIbTg2d1ZUNGxlNktMNk5EWThGa3h6cjdySlBhVS82UmhP?=
 =?utf-8?B?aVRaT1p4c0Q5bmpqQ3piR3Y5MWd4MDFuYTNJWmkzQS9DQWxVeitBdEVmTDJx?=
 =?utf-8?B?Z1dpTkxyTE8xVjBORlF2TzhvekhldnJNbzdMaitqU1JaVHg2eHF4dUZXQnlh?=
 =?utf-8?B?aVJXYkhob3BjVnlnVnBNSHZRRk9XRG9jbmFVbWdJaGVRVUVYZFA4L3NWSlZ1?=
 =?utf-8?B?UWxPRStWcytKcnpNMXFyS0J1V2RZOTV6THFwbDg2ajFLR1ZoV3pFQXg3Tzg4?=
 =?utf-8?B?VXpFNGs4RDZEbDROVWFDd1NmekZYTC9ueFJPdXp0dGxOSktUSTBoUmhieDRh?=
 =?utf-8?B?VVlXQWlRTk9QemxpZGkwRHlWS3Q3K21UQ01QMkJDTG14a244dzIyU04zREpj?=
 =?utf-8?B?K0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ACC266B819BE8428FAE83294A645801@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dc0239-1906-4b4d-7df2-08dbfa2afd90
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 09:24:35.2706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jH04Bwe4CyU+A8aCvB8u5T3c+7n195OmIWWdDv4EEGDR2N2yzlLFNwEy4PtKRTVm6UcGkQX9dFRP5WaJ6o7/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9714

T24gTW9uLCBEZWMgMTEsIDIwMjMgYXQgMDI6MDI6MzBBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gPiA+ICtzdHJ1Y3QgcmVhbHRla19wcml2ICoNCj4gPiA+ICty
ZWFsdGVrX2NvbW1vbl9wcm9iZV9wcmUoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcmVnbWFw
X2NvbmZpZyByYywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJlZ21hcF9j
b25maWcgcmNfbm9sb2NrKQ0KPiA+ID4gK3sNCj4gPg0KPiA+IDxzbmlwPg0KPiA+DQo+ID4gPiAr
DQo+ID4gPiArICAgICAvKiBUT0RPOiBpZiBwb3dlciBpcyBzb2Z0d2FyZSBjb250cm9sbGVkLCBz
ZXQgdXAgYW55IHJlZ3VsYXRvcnMgaGVyZSAqLw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcHJpdi0+
cmVzZXQgPSBkZXZtX2dwaW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9M
T1cpOw0KPiA+ID4gKyAgICAgaWYgKElTX0VSUihwcml2LT5yZXNldCkpIHsNCj4gPiA+ICsgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IFJFU0VUIEdQSU9cbiIpOw0KPiA+
ID4gKyAgICAgICAgICAgICByZXR1cm4gRVJSX0NBU1QocHJpdi0+cmVzZXQpOw0KPiA+ID4gKyAg
ICAgfQ0KPiA+ID4gKyAgICAgaWYgKHByaXYtPnJlc2V0KSB7DQo+ID4gPiArICAgICAgICAgICAg
IGdwaW9kX3NldF92YWx1ZShwcml2LT5yZXNldCwgMSk7DQo+ID4gPiArICAgICAgICAgICAgIGRl
dl9kYmcoZGV2LCAiYXNzZXJ0ZWQgUkVTRVRcbiIpOw0KPiA+ID4gKyAgICAgICAgICAgICBtc2xl
ZXAoUkVBTFRFS19IV19TVE9QX0RFTEFZKTsNCj4gPiA+ICsgICAgICAgICAgICAgZ3Bpb2Rfc2V0
X3ZhbHVlKHByaXYtPnJlc2V0LCAwKTsNCj4gPiA+ICsgICAgICAgICAgICAgbXNsZWVwKFJFQUxU
RUtfSFdfU1RBUlRfREVMQVkpOw0KPiA+ID4gKyAgICAgICAgICAgICBkZXZfZGJnKGRldiwgImRl
YXNzZXJ0ZWQgUkVTRVRcbiIpOw0KPiA+ID4gKyAgICAgfQ0KPiA+DQo+ID4gQW5vdGhlciB0aGlu
ZyBJIHdvdWxkIGxpa2UgdG8gc3VnZ2VzdCBpcyB0aGF0IHlvdSBkbyBub3QgbW92ZSB0aGUNCj4g
PiBoYXJkd2FyZSByZXNldCBhbmQgdGhlIC8qIFRPRE86IHJlZ3VsYXRvcnMgKi8gaW50byB0aGUg
Y29tbW9uIGNvZGUuIEkNCj4gPiBhY3R1YWxseSB3YW50ZWQgdG8gYWRkIHJlZ3VsYXRvciBzdXBw
b3J0IGZvciBydGw4MzY1bWIgYWZ0ZXIgeW91IGFyZQ0KPiA+IGZpbmlzaGVkIHdpdGggeW91ciBz
ZXJpZXMsIGFuZCBJIG5vdGljZWQgdGhhdCBpdCB3aWxsIG5vdCBmaXQgd2VsbCBoZXJlLA0KPiA+
IGJlY2F1c2UgdGhlIHN1cHBsaWVzIGFyZSBkaWZmZXJlbnQgZm9yIHRoZSB0d28gc3dpdGNoIHZh
cmlhbnRzLg0KPiA+DQo+ID4gSWYgd2Ugd2VyZSB0byBkbyB0aGUgaGFyZHdhcmUgcmVzZXQgaGVy
ZSBpbiBjb21tb25fcHJvYmVfcHJlKCksIHdoZXJlDQo+ID4gc2hvdWxkIEkgcHV0IG15IHZhcmlh
bnQtc3BlY2lmaWMgcmVndWxhdG9yX2J1bGtfZW5hYmxlKCk/IEkgY2FuJ3QgcHV0IGl0DQo+ID4g
YmVmb3JlIF9wcmUoKSBiZWNhdXNlIEkgZG8gbm90IGhhdmUgdGhlIHByaXZhdGUgZGF0YSBhbGxv
Y2F0ZWQgeWV0LiBJZiBJDQo+ID4gcHV0IGl0IGFmdGVyd2FyZHMsIHRoZW4gdGhlIGFib3ZlIGhh
cmR3YXJlIHJlc2V0IHRvZ2dsZSB3aWxsIGhhdmUgaGFkIG5vDQo+ID4gZWZmZWN0Lg0KPiANCj4g
V2Ugd291bGQgbmVlZCB0byBtb3ZlIHRoZSBIVyByZXNldCBvdXQgb2YgY29tbW9uX3Byb2JlX3By
ZSgpLiBQdXR0aW5nDQo+IGl0IGluIF9wb3N0KCkgb3IgYmV0d2VlbiBfcHJlKCkgYW5kIF9wb3N0
KCkgd291bGQgbm90IHNvbHZlIHlvdXIgY2FzZQ0KPiBhcyB0aGF0IGhhcHBlbnMgaW4gaW50ZXJm
YWNlIGNvbnRleHQuIFRoZSBwcm9iZSBpcyBjdXJyZW50bHkNCj4gaW50ZXJmYWNlLXNwZWNpZmlj
LCBub3QgdmFyaWFudC1zcGVjaWZpYy4gTWF5YmUgdGhlIGVhc2llc3Qgc29sdXRpb24NCj4gd291
bGQgYmUgdG8gbW92ZSB0aGUgcmVzZXQgaW50byB0aGUgZGV0ZWN0KCksIGp1c3QgYmVmb3JlIGdl
dHRpbmcgdGhlDQo+IGNoaXAgaWQsIGNyZWF0aW5nIGEgbmV3IHJlYWx0ZWtfY29tbW9uX2h3cmVz
ZXQoKS4gVGhhdCB3YXksIHlvdSBjb3VsZA0KPiBzZXQgdXAgdGhlIHJlZ3VsYXRvcnMgYSBsaXR0
bGUgYml0IGJlZm9yZSB0aGUgcmVzZXQgaW4gdGhlIHZhcmlhbnQNCj4gY29udGV4dC4NCj4gDQo+
IFdlIGNvdWxkIGFsc28gY2hhbmdlIHRoZSBpbnRlcmZhY2Utc3BlY2lmaWMgdG8gYSB2YXJpYW50
LXNwZWNpZmljDQo+IHByb2JlIGxpa2UgdGhpczoNCj4gDQo+IHJ0bDgzNjVtYl9wcm9iZV9zbWko
KXsNCj4gICAgICAgIHByaXYgPSByZWFsdGVrX2NvbW1vbl9wcm9iZSgpIC8qIHByZXZpb3VzbHkg
dGhlIF9wcmUgZnVuYyAqLw0KPiAgICAgICAgcmVhbHRla19zbWlfcHJvYmUocHJpdikgLyogZXZl
cnl0aGluZyBidXQgdGhlIGNvbW1vbiBjYWxscyAqLw0KPiAgICAgICAgcnRsODM2NW1iX3NldHVw
X3JlZ3VsYXRvcnMocHJpdikNCj4gICAgICAgIHJlYWx0ZWtfY29tbW9uX2h3cmVzZXQocHJpdikg
LyogdGhlIHJlc2V0IGNvZGUgZnJvbSBjb21tb25fcHJvYmVfcHJlICovDQo+ICAgICAgICBydGw4
MzY1bWJfZGV0ZWN0KHByaXYpDQo+ICAgICAgICByZWFsdGVrX2NvbW1vbl9yZWdpc3Rlcihwcml2
KSAvKiBwcmV2aW91c2x5IHRoZQ0KPiBjb21tb25fcHJvYmVfcG9zdCB3aXRob3V0IHRoZSBkZXRl
Y3QgKi8NCj4gfQ0KPiANCj4gcnRsODM2NW1iX3Byb2JlX21kaW8oKXsNCj4gICAgIDxyZXBlYXQg
cnRsODM2NXJiX3Byb2JlX3NtaSBidXQgcmVwbGFjZSByZWFsdGVrX3NtaV9wcm9iZSB3aXRoDQo+
IHJlYWx0ZWtfbWRpb19wcm9iZT4NCj4gfQ0KPiANCj4gcnRsODM2NnJiX3Byb2JlX3NtaSgpIHsg
Li4uIH0NCj4gcnRsODM2NnJiX3Byb2JlX21kaW8oKSB7IC4uLiB9DQo+IA0KPiBCdXQgaXQgd291
bGQgYmUgbW9zdGx5IDQgdGltZXMgdGhlIHNhbWUgY29kZSBhYm92ZSwgd2l0aCBsb3RzIG9mIGV4
dHJhIGNoZWNrcy4NCj4gDQo+IEZvciB0aGUgc2FrZSBvZiBrZWVwaW5nIHRoaXMgcGF0Y2ggYXMg
c21hbGwgYXMgcG9zc2libGUsIEkgd291bGQNCj4gcHJlZmVyIHRvIG1haW50YWluIHRoZSByZXNl
dCBpbiBpdHMgY3VycmVudCBsb2NhdGlvbiB1bmxlc3MgaXQgaXMgYQ0KPiBtZXJnaW5nIHJlcXVp
cmVtZW50LiBZb3UgY2FuIGVhc2lseSBtb3ZlIGl0IG91dCB3aGVuIG5lY2Vzc2FyeS4gSQ0KPiBk
b24ndCBiZWxpZXZlIHByZXBhcmluZyBmb3IgYSBwb3RlbnRpYWwgZnV0dXJlIGNoYW5nZSBmaXRz
IGluIHRoaXMNCj4gc2VyaWVzLCBhcyB3ZSBtYXkgbWlzanVkZ2Ugd2hhdCB3aWxsIGJlIG5lZWRl
ZCB0byBzZXQgdXAgdGhlDQo+IHJlZ3VsYXRvcnMuDQoNClllcywgaXQgaXMgZXhoYXVzdGluZyB3
aXRoIHRoaXMgYmFjayBhbmQgZm9ydGguIFBsZWFzZSBqdXN0IGFkZHJlc3Mgd2hhdA0KeW91IGFy
ZSB3aWxsaW5nIHRvIGFkZHJlc3MgYW5kIEkgd2lsbCByZXZpZXcgYWdhaW4uIFRoYW5rcy4NCg0K
PiANCj4gUmVnYXJkcywNCj4gDQo+IEx1aXo=

