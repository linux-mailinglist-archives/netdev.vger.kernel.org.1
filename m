Return-Path: <netdev+bounces-47694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DB7EAFC4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2293B281163
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3215B3FB01;
	Tue, 14 Nov 2023 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="Su+06ohn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C483FB00;
	Tue, 14 Nov 2023 12:23:07 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2115.outbound.protection.outlook.com [40.107.7.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B94F0;
	Tue, 14 Nov 2023 04:23:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+Zt7VabX5dLUzT3K4wKBnBQk6pEqBVMzR2YzDnj/CsaDlzLRF9CS3ENcD6n4ZIxG/qmMFYUUTy+InJewX2dk+r5pHzN66x8FoDZChFHxGDIEKzm139pCiGZ5vzOJZxKjTtLtiEqoDua9LJEx0aqTj98NUkkN+P775E89AioFcTaHjYTebkqIsz2zbgQ+wT5G44cO+b6Qfl0sRENZ6ISVTia9dtfKwBtxe8zCtXgOHa4Lq48M0e6pvVWWQsSY6CJPubDOp7iRU+JWKCVwqCzRHp7/d5OUG0EnJ7pN9kWxcYwRlaE8SJWQLctLyJLT5gCFnaaqgNup/vuMbQRv7sfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=084P5TCrfriA559dxobDpcFEy2sCup5lDG1QUb2LZAI=;
 b=IEN2c8D2sgLlsMXoN1Kefc6CMDOGxoZLH5pGVYYpIKMZREnTAjlAwwgnjZXXMxak7aUhl4crLb4Z5oT3Qow5GsRPLaAb4Pmz2bYxYQ2zs1Cfxolesi9qYwu5msIcfvEqMCpTs23xOhs9qtggHZLUbhiCruav18MubC27NGO84hdM8dM6C1zj2qWcQH1niBj88cup6ykKczf4MHT4Pz/eSkvQI/t2FXaFVf4eL1cHcu6/fV9ZplJb5tdPBSjkt/Q8lEv3OegPefMfWPLVwlpnK3GL8vXe2crxIjuUMg/p5QPu1t45BjsB4IRkixds6Y/emT2Zp8x3j6dMjexyX1uGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=084P5TCrfriA559dxobDpcFEy2sCup5lDG1QUb2LZAI=;
 b=Su+06ohndhNXVJ6NJV2nXZMakjM0q40MdT32j2Phf7UWt4a1In8q2T5G/mplQzswlWcYDEjXKazm2PfC4pk1JUOdkPHjEKb+P4G+a/+nF+7VM1lDUvgDdjNafHbNZJqRhO+LNSBgOPjDtnrKZ3bQd1+2H89cU9VL1I/Xaj60QBk=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB8PR03MB6170.eurprd03.prod.outlook.com (2603:10a6:10:141::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Tue, 14 Nov
 2023 12:23:02 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:23:02 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring
	<robh@kernel.org>
Subject: Re: [RFC net-next 1/5] dt-bindings: net: dsa: realtek: reset-gpios is
 not required
Thread-Topic: [RFC net-next 1/5] dt-bindings: net: dsa: realtek: reset-gpios
 is not required
Thread-Index: AQHaFOoHFxdASMBB+0KGJ90WdhgJ6bB5wNAA
Date: Tue, 14 Nov 2023 12:23:02 +0000
Message-ID: <5zxa73cgtgxyiqgcpcl6s33srrazr5htpzluoxptu3qsupoxgt@qcwpzmmwymbf>
References: <20231111215647.4966-1-luizluca@gmail.com>
 <20231111215647.4966-2-luizluca@gmail.com>
In-Reply-To: <20231111215647.4966-2-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB8PR03MB6170:EE_
x-ms-office365-filtering-correlation-id: d5a76613-0097-47b8-d4aa-08dbe50c727a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CPv2uyMsCwFg24RTkGzJJhw/bxb9uiQiwoZaUgf+vn9CUK/bwMwzxv4cMKub3Y/KCYzyyZmpXN27Kcfhem5qhzThp0Vh6s58eDfpfC7CC3bFFnHTNQFeqKIkT/qXX9fDI5UzQH9bjEEhofyS34cZsfKnAOAArrWgngWXcXDwezP63VPr+kjIrNhVWFeYNfu7kgkKAXNMf97xILURoUn93Zu98JFc4T4cXcFKFR30+Ny/YeF+ox4uBzAJnrocRpC9tnRttCGuDxzKf4C6S5tsYE91KCd06YD17da7+NfavSfbYjbCZx8mYDvE2k/koIlHXcyrvpNfP70T7+ymf6ntDOmm4FMgR9McG0ATIOLg6K5ju/yintRQTJ1EEO5awBF8NVZrm+XrNFO8JvCenZL9GtcdaA37rrUUnkg9WuLuVLEqs7uqOwmoyWyTKlmQvfZJyLoJCgerim6C37MToiSHw0uIyVw3ZBT/mpCJlLDybWtf59A5NPCkMfMbUIHO/jvdh0p6oU1TZ7DedJWLJE2Ss3LAxqOLvMHoZJxTclW/XY5tVs/1tsqBJQFD4LzQpHbmhNIyKs/Zrv6C5lxtYG1doXJ8iL/8AqXwgW/lgfyEapVqsbbp0Yz8exZJThLhwTJenORTDilDRM/+KQiTd9lLsw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(54906003)(66556008)(66946007)(64756008)(66446008)(6916009)(66476007)(91956017)(76116006)(38100700002)(316002)(85202003)(38070700009)(86362001)(122000001)(85182001)(26005)(9686003)(83380400001)(6512007)(33716001)(6506007)(66574015)(2906002)(6486002)(8676002)(4744005)(478600001)(5660300002)(7416002)(4326008)(8936002)(71200400001)(41300700001)(27246005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjN5V2dIalQ2UTlRLy9qNnM4WHE5K2JHTG1ZdWlWYTJ4bGxPNDZ1S3IwUXJp?=
 =?utf-8?B?aHJQSVZUdGpUQlkyaWNmNnZDY2NYaE13YjYvT1lRWWVEUDJQcmw2NGV6c29C?=
 =?utf-8?B?aW96NU4wa2lWV2FMSWluUFl5aVBIOW5pWnNlWGgyN0VPZWpEZmtlWWZkNDJ2?=
 =?utf-8?B?WnZiRGRoNzlWQ3B5dzd2NitGd1lIMGhBZU9uNFVBRmFpSXkrc1RFOHZsY1NC?=
 =?utf-8?B?RzIyWitMSzd4QkFyYlpkanpBWE0yRnJRMkt5LytUNXpLaXhhVGdIQ3kvTko3?=
 =?utf-8?B?Z0E1SURhUnh3N3VWVjZRWWNPNGVYWXFiQlBQczVibEdkNWRDc04ydUVKMlF4?=
 =?utf-8?B?TTlXVlZlNXVnTllBWXc3dHZFWlpGbUpOYnlraVJoT3Z4S3dDai9xRlYreHA4?=
 =?utf-8?B?azQxZllMWXhPY1IvNDVxY1JnaFNKa2xUekFIakRTMSttaXo1Z05XakxBOHAr?=
 =?utf-8?B?d3lkMWNqd0ROUFZ2ZGRlYnVHN0FnOWE5WmRjUk01WXdoQ1hCb1BNSnRLMGV4?=
 =?utf-8?B?aW1SMHUwQ0dtNkt4WVdRcGh5MnE2eWl2K2k3WnhCc3l5TE1wcmdMYW5pck1G?=
 =?utf-8?B?RDU5S0grUlVZblRzcHhVbExKOHhObWkwMm5nMXBkSS9nczl5T09HRmRwa1RZ?=
 =?utf-8?B?Q2l6TlNRNXhHVDFLaFNXc1BTaDZ1NmFTdDFyVXAxSFRVVE5PSktGcnVNOUQ4?=
 =?utf-8?B?RXNVdlIwUVQvRHZZdStFNTlPMlMyNFNjNEgwQlliVHRvYnVPeUxuS2RkUzJm?=
 =?utf-8?B?cFZQaXNJd3lldUdKbHdQTmtKRi9TbTZZMkNFMXVJUzRJc2FYNWtUWVBJOTg1?=
 =?utf-8?B?Tlh5c0t5TnZJdkRQNEhiV0pWSExETzJqUTllTXJYMjhXMW9DZVJyOXhUWHk3?=
 =?utf-8?B?L3NlMEMxczc1enl6Yk92QlVTRE8rTHVFQzZrWnF4OWt2K29sbE4xMndOeVdB?=
 =?utf-8?B?QmVEUlFUK3VKT2IyVWR1RGZzKzFPd3hzbGRDamwrRlZqaTZVd0JKUmx3c3B6?=
 =?utf-8?B?WDFtcEkzVkNDR3hUMk5jNG9BeE5lZ1NUdUNyamMvY0JpMk5KUlpzQU9tMkFD?=
 =?utf-8?B?YjJoV1kweXpOdHFEWDlpUXhnaEhZcUZmZ3hXZFNlQmVJNityb0UveFdLNTNL?=
 =?utf-8?B?cWJsclpJdHAycXhSeFhOY0Vab0hCWHVHWkEwYjJSZjRtbnNjVGV1ZTJINjQz?=
 =?utf-8?B?L3lXZEhKSjFZQWwxVTA1NDFTcGx2L2xiSjVGYmlmdGVBZWU4cWUreE80ME5K?=
 =?utf-8?B?WUdWbE45Vm9XbDh4Tk1zVUxpQVh1bEJXNGN0dnFyVG5tWU50S0tONlQrSmlB?=
 =?utf-8?B?VEw5MWJGVEo1Nkx5UFVxMnRJY2FjWXI3UGhIOEhHbU8wNUpndkgza3MrUkFN?=
 =?utf-8?B?eVprZ2V4Q2kyTnQ2U3pxbHIya3N0UFRJMXp3SXJkVU9hQVJGcTRtTjAzTlFH?=
 =?utf-8?B?WDF0RXRCNUNLRitVU3gvelUwVG0zSHRzYmNQQnZHdjFLTXVaYVB4MzRaUFFW?=
 =?utf-8?B?WHRpRFQvT1VjazlrcFoxbjNRQW52SXFYdjhMMnozNDNWQmwySlg2NE9USUFu?=
 =?utf-8?B?eTV5MS9WSml1SVQxODU3ZGt4VWxSYjhIMElocVhEbnJDMTk3WlBpRWNJakRP?=
 =?utf-8?B?Qmp0MU83Q1VvZEJ6c015b1J5ZVYxZmg4Qk5pY2UzSWVaWlh3K016dkdBZW1W?=
 =?utf-8?B?TTlTMFA3NmRuUnJnU2ZaTElDNEtWQktRenE1anZNUEREUDUwMkJXTGc1WDJp?=
 =?utf-8?B?dkpmem9iSWVIdTNhRVFMUFhScVR0ekxDOXdFNHBjMEJ5bytWRHN5bTRaSTUv?=
 =?utf-8?B?anNjKzIvUTNDYTRoYWlFeDMxSGxSUHFIK0RCcnRLZlk1WG9BVm90UEZUMGs2?=
 =?utf-8?B?R0Z0TGlIcnN6TkIzRGhJRGVhN1F6WWJPQ0JYRTgzZGV5VERVT01RcnlnMjNG?=
 =?utf-8?B?eXVlb2ZxelBpcEp1VnBudHhHbnd1ajVWbEJ3UFN5VU50TCtMZTZualdpUEgy?=
 =?utf-8?B?aGkzNzVvSVFxS0lGai9tMUQ2c2VDYVdtcXRQMkdQV3NuNVdkbHc2MDlYdmtk?=
 =?utf-8?B?OHFEb0VBSTY3L1JXQ0U0bXYyMTcrb2xYbG1oN0VzTGJRU1BYRW12RHJFa0JY?=
 =?utf-8?B?RkhIYi9sbmFucnJDQXlUUTlielN3RDQxRDFzNUYxaTk4RERXdmR2YXUrWGlh?=
 =?utf-8?B?Umc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB368322A3778840B69638FCCFA4CBD7@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a76613-0097-47b8-d4aa-08dbe50c727a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 12:23:02.5562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D+ENWiGFAerDBNIOcH1UQsYMA4QcwQY1DiNFWVuKFs8IMX54PPlLJP8stZEX9qTgoN7UfjaCOOnrHW7vR9fAqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6170

T24gU2F0LCBOb3YgMTEsIDIwMjMgYXQgMDY6NTE6MDRQTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gVGhlICdyZXNldC1ncGlvcycgc2hvdWxkIG5vdCBiZSBtYW5k
YXRvcnkuIGFsdGhvdWdoIHRoZXkgbWlnaHQgYmUNCj4gcmVxdWlyZWQgZm9yIHNvbWUgZGV2aWNl
cyBpZiB0aGUgc3dpdGNoIHJlc2V0IHdhcyBsZWZ0IGFzc2VydGVkIGJ5IGENCj4gcHJldmlvdXMg
ZHJpdmVyLCBzdWNoIGFzIHRoZSBib290bG9hZGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTHVp
eiBBbmdlbG8gRGFyb3MgZGUgTHVjYSA8bHVpemx1Y2FAZ21haWwuY29tPg0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQWNrZWQtYnk6IEFyxLFuw6cgw5xOQUwgPGFyaW5jLnVu
YWxAYXJpbmM5LmNvbT4NCj4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoN
Cj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9yZWFs
dGVrLnlhbWwgfCAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvcmVh
bHRlay55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvcmVh
bHRlay55YW1sDQo+IGluZGV4IGNjZTY5MmY1N2IwOC4uNDZlMTEzZGY3N2M4IDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2RzYS9yZWFsdGVrLnlh
bWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9kc2EvcmVh
bHRlay55YW1sDQo+IEBAIC0xMjcsNyArMTI3LDYgQEAgZWxzZToNCj4gICAgICAtIG1kYy1ncGlv
cw0KPiAgICAgIC0gbWRpby1ncGlvcw0KPiAgICAgIC0gbWRpbw0KPiAtICAgIC0gcmVzZXQtZ3Bp
b3MNCj4gIA0KPiAgcmVxdWlyZWQ6DQo+ICAgIC0gY29tcGF0aWJsZQ0KPiAtLSANCj4gMi40Mi4x
DQo+

