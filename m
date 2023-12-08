Return-Path: <netdev+bounces-55282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5725380A19E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF8E7B20A77
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEF313FFB;
	Fri,  8 Dec 2023 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="DJgq2keV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2102.outbound.protection.outlook.com [40.107.7.102])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426BAC
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:57:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3N7PBEaWQSUn4Rt/RxX6gw720ezD8AmZIAdi27YlbaR2TxgVFSO5K70DwT4J+rJMOWRmVxCYzBrdDLeBYantOwPc0yVk3i+qaLr8fdIQ1LeMWrKEuCvEbVCUXgtqm3Wc1aEOHelzkd7aUIsJs4aJBPxb3xE4P8rODjjy1fQKa5erm1mWrYJ+Vb1G7oa1AMHZs3vgWdgTCpNv0DKJr9zQ1Gekn5RGAuRbFMx0WkdUhtH8JfCeJBtG+n4fSCElKqHvgadxBtLax94Hczo69dQ5HQR80qUhfMisBXTxma0IpAqLmJ1aXoQQSFdIQxnhjSkYgzszUju8T3by1HGds+7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5DQfTtsDq7eo1+E1IR0auKyMlrXasHPmQak4xu6F5Y=;
 b=K2RvHXJC4bA4CM0Q4naFco8xx7nSTv7OhT1Af/WUBkes+OThNKREM0hQ7TPd00TNU/qmvK4+89qNAjuo7fszXnv53/YCRdo5bE7J8fpZMIUUkt7ZK0Mbw+YmSKdVMGMqNpOMKWMv8Y1hMZj6SiPH/0+VTB0/BumTrGOKo9petP0HwrrPeMiSzw44YFoUDx581POvDd/Fxk3lJoU0iVZGZDgqZyaGLCldYOxpc+OoFKQQNbiI/GOBVQmezVBS6hErPtrXV9GD0ssA1CXTGLkIJutns8y1HjzEuuYqr89TMADPl/TI0JYzKwE0Q7unmd6bC8FSbTS/EJp3okGhwUs7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5DQfTtsDq7eo1+E1IR0auKyMlrXasHPmQak4xu6F5Y=;
 b=DJgq2keVd8vYmCH/vK+VlmJHSn5K/ISvgOsFI7J91msMC5hZQtL37VOLINMY2RhaGjGDL5fHPC3CF2MEwdw/M6Gz1/fp3qBUeu3JYRLjPo4+Ib7FOlRBfbwy999doNBL6KTL1jj25z/gqj6uRpupFI1Rssaakc5Zl5t+i4Q/lPA=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by VI1PR0301MB6688.eurprd03.prod.outlook.com (2603:10a6:800:195::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 10:57:46 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 10:57:46 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules
 into common
Thread-Topic: [PATCH net-next 5/7] net: dsa: realtek: merge interface modules
 into common
Thread-Index: AQHaKZJJVjrF4RIqR06ULJRkQds+DbCfN5sA
Date: Fri, 8 Dec 2023 10:57:46 +0000
Message-ID: <foqrrb6oox3z4ptmm3n4bon457jyr25blk2f57itipdf4rppt3@5vpukw2pnucj>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-6-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-6-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|VI1PR0301MB6688:EE_
x-ms-office365-filtering-correlation-id: 2a81d092-fa6c-4508-dc20-08dbf7dc8318
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 So1EQ9f9ErUK/vjnMXzt+Kgadvs/xWiwFnAU+T5mBP/ou3ISQN5dPCSNmL8dsBUDKUMeJSFw79wRywybNjCoXwmW9ko37ozPpHui/Tlam5z2Uj3XAebyMxIbDYwZthZXCkw0/PU1VeSL5VCH3bKSunY/S9Oj7X9BW354fzUbH+9k+SGT02jYrTCbGoZiKt5tXTuun5h58pH8v3mQLbrzAZzZJOUJoBJ8oFb4kLenMxb68q/vDipflBbQIrVF1qpYXJzVFptFkVoGSFuG8cXlc8qsHVmIdc3oHzr//gxsz+x74vyQjmEydeQHutE5rKUrf7WK7+r/inhClEdFFC++Q7YT5OcQrkGrxuQQgLP/7C4N0VbWH+v9QViPUAniDeqn5PZXS9ly6KHSzXrR8WkkgSF8se/P4hLWX7NLiDRvpmBsayMSV4BX6aAtUJMzRWDRSKSn03Thw97ZjP+mBdiEjCAUp/xX7xtSNmB46Q3RFMGGV47xN231NOUSkLSSZ5gAXF5n/ldW56DGxUEVRVhvfO9utA3Kcs+OJK6Cs1kz0p0bSJzK8u49b+QQUE1KJoXuatHrQ9m7Ps/GHzJjDZf3bwBWzfoDOZewDl60VRuQoq2l+oPygI+R7UMtiwayIStw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(39850400004)(136003)(186009)(64100799003)(1800799012)(451199024)(66899024)(91956017)(64756008)(66556008)(54906003)(76116006)(6916009)(66946007)(8676002)(4326008)(66446008)(66476007)(316002)(33716001)(8936002)(6486002)(478600001)(71200400001)(7416002)(5660300002)(41300700001)(38070700009)(85202003)(2906002)(86362001)(122000001)(85182001)(83380400001)(9686003)(38100700002)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akVGcmQrNCsybktQdUtJQVpvaEowb0hFSTY2a0VpZzV4N1hTN25IVlU1MGhX?=
 =?utf-8?B?VlYxNlNqcG5SU2pGZThyVVdzdDdZcFE5c21yd1lyYkIzMVNPc3hmWXkwOHQ2?=
 =?utf-8?B?MGJKbTFoY3MveVl2M2RkNVdpSXBYU1JkdW9wVVZWRlU0RzlFVzlpK1BWU0Zv?=
 =?utf-8?B?MmRza25GL1ZMbVlDbjQxREVUdmpFRWltT0FhV0orTmlTRXhZcm01VTVTdVFK?=
 =?utf-8?B?RktyUlVJOUhBQktaK0VyclN1SUw2TjJVYXQybXRvTk12SEJxVVlHYVFLUmh0?=
 =?utf-8?B?Ui9EaS9kUGNZREtjQVIyNU8xUFRDQ3VBUm8wdEtVdHR4bjBtNWhUVGNtcUcr?=
 =?utf-8?B?RDlDOHY4TmIvZTYxRGFZbGJWVXRNOHc3NFg2VUFMeWNLT0c3cWIxdEg1QU15?=
 =?utf-8?B?U1M4aXI2clN1NnJJNVpDSUVIOGZkZ2FOTW1oK28wZDhNZllaMUZNTjdDbXcw?=
 =?utf-8?B?dUlqOElkMFIwcXhFS2lRK3hIMXRydE1nRm02K2xXWmZKVHh6aENvWFNNVVor?=
 =?utf-8?B?VWxoc0ZQdEcyaUp0NGhQTkNhUXlJOEtFZlhUWUtieFJ1aHkvNHFTS2hkREJu?=
 =?utf-8?B?NWIvSHFVd2piRW1hRGxWU2NINDRxZE5KUlBlbnJmKzVZR2syam9CV1BHRi9s?=
 =?utf-8?B?Smc2WnhwU0hCYnVYUjMzSXdBQitzNVJWNUp1RTVsNnRpczVjcjlFNEVCL1dq?=
 =?utf-8?B?b3ladTBBNFhLeTFzejFEMnUrdUpCZnlJSXNtSnY3ZVBFMnJzWVBERXgxWXJh?=
 =?utf-8?B?bGhadmJORG1mSlI2MDdiWHg5M0o0RlN3bmM1U3dIY3MraStmeVRieUF2dGdJ?=
 =?utf-8?B?Y0tJNlNNaFFzRXNSbFVESFl6VGVocm5hOXp5RmhUWGREWXdKMjRVNk5IeGtM?=
 =?utf-8?B?WTBUMFE1N2VZUzNBSmU4Vk54dHpYajJjc1J1NEt1Smx3YkdIQW9Ea3g5YTgw?=
 =?utf-8?B?M09XbE9WSi9wUDNnWDZYRzdKWVZVc0ttV0R1VFN2TW1pcHF0REpyTEJwYk5B?=
 =?utf-8?B?bFJBODdUVlR1MkprdVZhT2FSbGQvR1JLS1FjRG5xcTQ0YXpsdGc5c0ZoS0xy?=
 =?utf-8?B?NFUzQWFiQWtTNTFJSkRVRTBGRXlWaGp3bW1pWGN3UThjNGs2V0pCVlJDYkZP?=
 =?utf-8?B?Z29DYUtvZ0RWN1FNZE5tRXNBMmVFcTlySXYwL1l4UGR1TEVZdEFPaTZaeU5G?=
 =?utf-8?B?RUNsaDJ6bnpYMjVJMThNOHZpbWlWMjczcng4MmN6bjA0MFRZWEtNWXdqekVD?=
 =?utf-8?B?cGZYNVJ0ME1VbjJVclpMUU1SQ1BVdUlJSVI0RFo0bVJOaktaQVBUQW9EN20z?=
 =?utf-8?B?NXVncmRQYTlpN2xleEc5N3UyVHczS3ZSRWdOTUwrWHMyemdnTjhRVmJGQWdz?=
 =?utf-8?B?NHIwY1lCWnZGclU5Y1l0RlBpNUpreFp0MzRGTkhsUys2elZsY1QxVG01OFJC?=
 =?utf-8?B?N3E4a3o4ZEpUeWk3QnJLWFErQ09hTU52bzVzWnRpNVN2bTlSRGx5eFVJMVBF?=
 =?utf-8?B?T0g5TlNXTnNtSURjK1lEVEx6NVFHcU1rUXJ5dUcwNUlGYUhDY0EzR0xnc2Q0?=
 =?utf-8?B?QTgvbU5EeTM2TW5jaElsdDdXeEVpSlhtd2pJNnhId2h5bFFIL292TTlPV09G?=
 =?utf-8?B?VmtDejMrWTNlZm1UZFJjeTRHcWhtZ2hKYXlQOGtpOVFnRXprUmRmbmZiNUZt?=
 =?utf-8?B?eHpNa3lwdk4wejJYbFdaa3hlOE1GcTlPdUVnTiswWEl0dnd2TzlUN0JZUXg2?=
 =?utf-8?B?RnVKeDVhYjI0Y2Zoby92cm9pOTJTUjBOV3VhZmtrTE1WeExuN2V1RUJmTHpP?=
 =?utf-8?B?TmFWczY2OCtQWjM5WktXaFMrNjdEMkJPQ2xPWEZQQUFBRmoxaHo3MnlwN3hX?=
 =?utf-8?B?MTBsbHZJZk1PYTJDRElBVGptKzVULzFBU0tWN1hpOXQyeDd2V3d4aWtxK2VB?=
 =?utf-8?B?Q3V1dmJqaTNROHdRd1hvRFVZM0JkWVpiNmQ4cGZrb2NSalE5VFFhSXhacy91?=
 =?utf-8?B?RXRacE41Z1c3Z0lPbkRJNFNKMTNrYlAwL2FNN24vSzM5UjhMKzQvd2lCR3hZ?=
 =?utf-8?B?cVRXUkZML3dQL1YyQlg2U0RoMm5HVitwM3NwZHVsdnRBM3F0eHZDNTB6RHdw?=
 =?utf-8?B?QTNYVHRkUjQ0R1RNQUI3WG5remdvck1vQUZJTytaQXF5aDJhUSs5WXM0QW5k?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DA34C065B731E4299516381996E60F4@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a81d092-fa6c-4508-dc20-08dbf7dc8318
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 10:57:46.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X0kwRa2nEXBtec62N8WYDWyVNLePkNOnnMozxgx8fzrozg6ZB39CrgtVpGcMooo49Fb0iw+TjFUYljjRCCK42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB6688

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDE6NDE6NDFBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gQXMgYm90aCByZWFsdGVrLWNvbW1vbiBhbmQgcmVhbHRlay17
c21pLG1kaW99IG11c3QgYWx3YXlzIGJlIGxvYWRlZA0KPiB0b2dldGhlciwgd2UgY2FuIHNhdmUg
c29tZSByZXNvdXJjZXMgbWVyZ2luZyB0aGVtIGludG8gYSBzaW5nbGUgbW9kdWxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTHVpeiBBbmdlbG8gRGFyb3MgZGUgTHVjYSA8bHVpemx1Y2FAZ21haWwu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL0tjb25maWcgICAgICAgICAg
fCA0ICsrLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxlICAgICAgICAgfCA4
ICsrKysrLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLWNvbW1vbi5jIHwg
MSArDQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLW1kaW8uYyAgIHwgNCAtLS0t
DQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLXNtaS5jICAgIHwgNCAtLS0tDQo+
ICA1IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvS2NvbmZpZyBiL2RyaXZlcnMv
bmV0L2RzYS9yZWFsdGVrL0tjb25maWcNCj4gaW5kZXggOWQxODJmZGUxMWI0Li42OTg5OTcyZWVi
YzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL0tjb25maWcNCj4gKysr
IGIvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvS2NvbmZpZw0KPiBAQCAtMTYsMTQgKzE2LDE0IEBA
IG1lbnVjb25maWcgTkVUX0RTQV9SRUFMVEVLDQo+ICBpZiBORVRfRFNBX1JFQUxURUsNCj4gIA0K
PiAgY29uZmlnIE5FVF9EU0FfUkVBTFRFS19NRElPDQo+IC0JdHJpc3RhdGUgIlJlYWx0ZWsgTURJ
TyBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gKwlib29sICJSZWFsdGVrIE1ESU8gaW50ZXJmYWNlIHN1
cHBvcnQiDQo+ICAJZGVwZW5kcyBvbiBPRg0KPiAgCWhlbHANCj4gIAkgIFNlbGVjdCB0byBlbmFi
bGUgc3VwcG9ydCBmb3IgcmVnaXN0ZXJpbmcgc3dpdGNoZXMgY29uZmlndXJlZA0KPiAgCSAgdGhy
b3VnaCBNRElPLg0KPiAgDQo+ICBjb25maWcgTkVUX0RTQV9SRUFMVEVLX1NNSQ0KPiAtCXRyaXN0
YXRlICJSZWFsdGVrIFNNSSBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gKwlib29sICJSZWFsdGVrIFNN
SSBpbnRlcmZhY2Ugc3VwcG9ydCINCj4gIAlkZXBlbmRzIG9uIE9GDQo+ICAJaGVscA0KPiAgCSAg
U2VsZWN0IHRvIGVuYWJsZSBzdXBwb3J0IGZvciByZWdpc3RlcmluZyBzd2l0Y2hlcyBjb25uZWN0
ZWQNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxlIGIvZHJp
dmVycy9uZXQvZHNhL3JlYWx0ZWsvTWFrZWZpbGUNCj4gaW5kZXggNWUwYzFlZjIwMGEzLi44OGY2
NjUyZjk4NTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxl
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL01ha2VmaWxlDQo+IEBAIC0xLDcgKzEs
OSBAQA0KPiAgIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAtb2JqLSQoQ09O
RklHX05FVF9EU0FfUkVBTFRFSykJCSs9IHJlYWx0ZWstY29tbW9uLm8NCj4gLW9iai0kKENPTkZJ
R19ORVRfRFNBX1JFQUxURUtfTURJTykgCSs9IHJlYWx0ZWstbWRpby5vDQo+IC1vYmotJChDT05G
SUdfTkVUX0RTQV9SRUFMVEVLX1NNSSkgCSs9IHJlYWx0ZWstc21pLm8NCj4gK29iai0kKENPTkZJ
R19ORVRfRFNBX1JFQUxURUspCQkrPSByZWFsdGVrX2NvbW1vbi5vDQo+ICtyZWFsdGVrX2NvbW1v
bi1vYmpzLXkJCQk6PSByZWFsdGVrLWNvbW1vbi5vDQoNClRoaXMgaXMgd2VpcmQgd2l0aCB0aGUg
LSBhbmQgXy4gQWxzbyByZWFsdGVrLWNvbW1vbiBpcyBub3QgYSB2ZXJ5DQpkZXNjcmlwdGl2ZSBt
b2R1bGUgbmFtZS4gTWF5YmUgcmVhbHRlay1kc2E/DQoNCm9iai0kKENPTkZJR19ORVRfRFNBX1JF
QUxURUspICs9IHJlYWx0ZWstZHNhLm8NCnJlYWx0ZWstZHNhLW9ianMteSAgICAgICAgICAgICs9
IHJlYWx0ZWstY29tbW9uLm8NCnJlYWx0ZWstZHNhLW9ianMtJCguLi5fTURJTykgICs9IHJlYWx0
ZWstbWRpby5vDQpyZWFsdGVrLWRzYS1vYmpzLSQoLi4uX1NNSSkgICArPSByZWFsdGVrLXNtaS5v
DQoNCkFsc28gd2hhdCBoYXBwZW5zIGlmIEkganVzdCBlbmFibGUgQ09ORklHX05FVF9EU0FfUkVB
TFRFSyBhbmQgbm90aGluZw0KZWxzZS4gRG8gSSBnZXQgYSBtb2R1bGUgdGhhdCBkb2Vzbid0IGRv
IGFueXRoaW5nPyBOb3Qgc3VyZSBpZiBpdCdzIGEgYmlnDQpkZWFsLg0KDQo+ICtyZWFsdGVrX2Nv
bW1vbi1vYmpzLSQoQ09ORklHX05FVF9EU0FfUkVBTFRFS19NRElPKSArPSByZWFsdGVrLW1kaW8u
bw0KPiArcmVhbHRla19jb21tb24tb2Jqcy0kKENPTkZJR19ORVRfRFNBX1JFQUxURUtfU01JKSAr
PSByZWFsdGVrLXNtaS5vDQo+ICtyZWFsdGVrX2NvbW1vbi1vYmpzCQkJOj0gJChyZWFsdGVrX2Nv
bW1vbi1vYmpzLXkpDQo+ICBvYmotJChDT05GSUdfTkVUX0RTQV9SRUFMVEVLX1JUTDgzNjZSQikg
Kz0gcnRsODM2Ni5vDQo+ICBydGw4MzY2LW9ianMgCQkJCTo9IHJ0bDgzNjYtY29yZS5vIHJ0bDgz
NjZyYi5vDQo+ICBvYmotJChDT05GSUdfTkVUX0RTQV9SRUFMVEVLX1JUTDgzNjVNQikgKz0gcnRs
ODM2NW1iLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWst
Y29tbW9uLmMgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLWNvbW1vbi5jDQo+IGlu
ZGV4IDc1YjZhYTA3MTk5MC4uNzNjMjVkMTE0ZGQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC9kc2EvcmVhbHRlay9yZWFsdGVrLWNvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9y
ZWFsdGVrL3JlYWx0ZWstY29tbW9uLmMNCj4gQEAgLTEzMiw1ICsxMzIsNiBAQCB2b2lkIHJlYWx0
ZWtfY29tbW9uX3JlbW92ZShzdHJ1Y3QgcmVhbHRla19wcml2ICpwcml2KQ0KPiAgRVhQT1JUX1NZ
TUJPTChyZWFsdGVrX2NvbW1vbl9yZW1vdmUpOw0KPiAgDQo+ICBNT0RVTEVfQVVUSE9SKCJMdWl6
IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6bHVjYUBnbWFpbC5jb20+Iik7DQo+ICtNT0RVTEVf
QVVUSE9SKCJMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Iik7DQo+ICBN
T0RVTEVfREVTQ1JJUFRJT04oIlJlYWx0ZWsgRFNBIHN3aXRjaGVzIGNvbW1vbiBtb2R1bGUiKTsN
Cj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Rz
YS9yZWFsdGVrL3JlYWx0ZWstbWRpby5jIGIvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRl
ay1tZGlvLmMNCj4gaW5kZXggNGM5YTc0NGI3MmY4Li5iYjViZmY3MTlhZTkgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstbWRpby5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstbWRpby5jDQo+IEBAIC0xNjgsNyArMTY4LDMgQEAg
dm9pZCByZWFsdGVrX21kaW9fc2h1dGRvd24oc3RydWN0IG1kaW9fZGV2aWNlICptZGlvZGV2KQ0K
PiAgCWRldl9zZXRfZHJ2ZGF0YSgmbWRpb2Rldi0+ZGV2LCBOVUxMKTsNCj4gIH0NCj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHJlYWx0ZWtfbWRpb19zaHV0ZG93bik7DQo+IC0NCj4gLU1PRFVMRV9BVVRI
T1IoIkx1aXogQW5nZWxvIERhcm9zIGRlIEx1Y2EgPGx1aXpsdWNhQGdtYWlsLmNvbT4iKTsNCj4g
LU1PRFVMRV9ERVNDUklQVElPTigiRHJpdmVyIGZvciBSZWFsdGVrIGV0aGVybmV0IHN3aXRjaCBj
b25uZWN0ZWQgdmlhIE1ESU8gaW50ZXJmYWNlIik7DQo+IC1NT0RVTEVfTElDRU5TRSgiR1BMIik7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLXNtaS5jIGIv
ZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay1zbWkuYw0KPiBpbmRleCAyNDYwMjRlZWMz
YmQuLjFjYTJhYTc4NGQyNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsv
cmVhbHRlay1zbWkuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLXNt
aS5jDQo+IEBAIC00NDMsNyArNDQzLDMgQEAgdm9pZCByZWFsdGVrX3NtaV9zaHV0ZG93bihzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IE5VTEwpOw0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwocmVhbHRla19zbWlfc2h1dGRvd24p
Ow0KPiAtDQo+IC1NT0RVTEVfQVVUSE9SKCJMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxp
bmFyby5vcmc+Iik7DQo+IC1NT0RVTEVfREVTQ1JJUFRJT04oIkRyaXZlciBmb3IgUmVhbHRlayBl
dGhlcm5ldCBzd2l0Y2ggY29ubmVjdGVkIHZpYSBTTUkgaW50ZXJmYWNlIik7DQo+IC1NT0RVTEVf
TElDRU5TRSgiR1BMIik7DQo+IC0tIA0KPiAyLjQzLjANCj4=

