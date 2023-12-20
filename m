Return-Path: <netdev+bounces-59272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582E81A316
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 16:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9A9282092
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4FF405D3;
	Wed, 20 Dec 2023 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="Bl1wvc+v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2092.outbound.protection.outlook.com [40.107.6.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CB4120B
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/wTvgVQ7ZKHFlFpuTLnkbB/zQtgmh5MVuNsaQA0Q0B8Ql3zdcSnTOGItyG71gM7tw6b+QFgP/geMuZVIF3Rxl971Mbmp3vJEevBNhI1QiXOehEaX/sOaTrNhIoWTmih/DEs85trpF21muq473GSSCe/C5M+67tq2JuqmEAS3eTEUTWeuN0ZNd4DGptU44OQl6MTYogCwTjQUj0LgDC9Hf+mMriSSsfVg4rYELKmOrqXnhtaAlHQENUgnE1DGXmiuAsoaXynUyae2t1fBMoELsaffQ3wnmCyxKk7pGL0PNd+vPy9D+8xECOK1PxFYidwceLzKD9djsWG5hzbOvzVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68ISc/8Mex2rx525/kcqtLbMPViZWw+TTnUDHpn4PfM=;
 b=DNNpVEVI8NwGn0CX30qy/T7wSvl19n6Y+HvBi/IVPOjcF3Bg8Es61aeRGJ1k/8p7BiSnobTUi6PZktnbmS0ZUPsMtIAgYBRev8edMxj7F612amkpedWo/OJwItwa1cTyZuPXs6oMdJPZdOXkUmAXiVjq1BtzCY0R2h8t/2nXoWGAj1SXrhYCszH73kpj/VUuD72FV0B8vbjEFgGP/cxrwduy5ZepILtin2veyvuHYygA+JtrinF67tAf0J+DQmswbPQvaBkys6hFUVfptkKL7IfnKPc4Eml5BEriVu1ahnLM5G28v27Ou0tpRhs/Bd6TlUErjHPsTdZ4cnd5UZcY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68ISc/8Mex2rx525/kcqtLbMPViZWw+TTnUDHpn4PfM=;
 b=Bl1wvc+v3VpkeJ4vCjvOIgrPkIR0SR6XvMFJSGRWBF3N/QfY2zFsDGC9YROFgHEhDRE+ZSZmDX0sBRNli4xmmn0MWcLb7uYVkbX11Lu7ed6Wsm/Ilc2usQWVRM6zEKk+sDqV1Y/AKzXUI572ooEr+pIJK2JV3KYz2aP5s/d1X14=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by DB5PR03MB10076.eurprd03.prod.outlook.com (2603:10a6:10:4a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 15:50:56 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::192c:39ce:80b8:fc2a%3]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 15:50:56 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 3/7] net: dsa: realtek: common realtek-dsa
 module
Thread-Topic: [PATCH net-next v2 3/7] net: dsa: realtek: common realtek-dsa
 module
Thread-Index: AQHaMvzLl/BlJx2Z/0WJa0wAvUQNV7Cx++qAgABWywA=
Date: Wed, 20 Dec 2023 15:50:55 +0000
Message-ID: <o3c4fxt5xtabsgdg6oz4qyy6rvc7l5qojl65hvd2x2zxyz34bn@7vjv6obs6rgk>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-4-luizluca@gmail.com>
 <m7aqhrk5zydicvxdrl225tcgwe5g3esu27mafoee7pqjitjnzs@5ldkbzqmmpte>
In-Reply-To: <m7aqhrk5zydicvxdrl225tcgwe5g3esu27mafoee7pqjitjnzs@5ldkbzqmmpte>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3950:EE_|DB5PR03MB10076:EE_
x-ms-office365-filtering-correlation-id: 3b0eda3a-7aba-4eb0-04a2-08dc01737405
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G3f7C5VZx1c+G4b+ZhiLXL/ctEdB2Sag0/pnzuFPWp0fxMYZpVj1tzYn1IqnOvFAAZGWxkh1vZgJeyMj2pPWWz241vBx1P5HlTJ5gL+XsTYn/nQHhCGY5dmL6q3i7oRK/wY+OFBpiVk19Yw8TlgOwnE7d9aAp137eCBdFCtnP0P4tHMil1A4MwZO8Y2PJNPKZV99ozt0LMGyhoj28DK9trKbxHPKhZfKlCn7EtjDQIwtAKNN0zDTnj+/Mv4fk6JYkF2JNiiTrRpiN7HSvonYZLpOXiegMsjjWe3AwvXejLM7uJY6BpLhasDg+zm1Gj9e9X54k22dMPrbuhAZ0qXymCQ23rKW+pXb9kKciWKcseUJXWTEqcu7YPT+SpAHH4D/0ZQHGNVJUxTiCO1PueOvyi+LCQXwSI26y8duOPtKSKb7fEnqSIWLELcKw878FNkryMdDFtARhSITOFPx2DGruIiwkpzblB9PYSYMEcEsikTKKFGX3i1b+yVI+O3DeHr0dCmGTnJFGXHEzmTuNnub8Zv1Iapu3GIS1idT88nV52feTnN1egy8VtlWmfpE2BGPVW3b1pCjrOCVv1TabjXRsoRlw3qicG3J2xoldSuCGDecpk1yOfdxVkLUA1FmYci9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39850400004)(136003)(376002)(346002)(186009)(64100799003)(1800799012)(451199024)(8676002)(6916009)(8936002)(4326008)(26005)(478600001)(2906002)(316002)(6486002)(66946007)(64756008)(66476007)(66446008)(66556008)(71200400001)(54906003)(91956017)(76116006)(6506007)(5660300002)(9686003)(6512007)(86362001)(33716001)(122000001)(83380400001)(38100700002)(85182001)(7416002)(38070700009)(85202003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1lhWGtjam1ucStNd2xIenAwN0ltRzNLYkNESnA5MUJpdHZneWt6dytBamRl?=
 =?utf-8?B?azhWL3J1TEVrZW9paUVuWWs3MUJWWUtOTHhwanM0U3hOcWVFVlFXVkVCSUR6?=
 =?utf-8?B?WXlYNUk3MTRuT3g1T0NXeU0wY0QwREJNTGw2cy9MVCt6UTJ3SXBaY3grdVNo?=
 =?utf-8?B?dFZ2cVM1RHJ6NTN4d3ltSFMyZmZYQ2ROMXBIeitCekc4MmVqUGN3ODVpQmpP?=
 =?utf-8?B?NGQyRjR5M09RTzNMWVhSd0czQktDZkUrcVVMdzQ1NlkxbG05Ymdad2ZnN1hh?=
 =?utf-8?B?SHplU3hhc0prSG5adWgzS1JaUWlBbHFjS1gxdDVpZ3pnRHV0Q1ZNYkFVcUZp?=
 =?utf-8?B?cVFJZVpoUEc2a2RMVWl6T2xrQzNmTXZPcUVaSzRycXVGYU5ZNk9icXRxeFJi?=
 =?utf-8?B?VTFKOXZ6SVRtYzdrTWM2THR1SlFLVmwwUloyWkg2V3pReU9abGhvTVNNa3RO?=
 =?utf-8?B?QnJzRnROVkxCdGFyLzQ0QmZsNVlNRXliMHR6TVJoRmxZQW5aUDhLMjJXWktk?=
 =?utf-8?B?TVlsTFpXRWNkbU91cHNIbk9mNkRpREZZZVg2N1hjOTEwcysxUzBzVldjQzNk?=
 =?utf-8?B?RHkzVmdWNDNQYkVuZ0QzamdTTUlYcHZlSlRlQm9LRk1CSnF5bE9ucGY2dlVk?=
 =?utf-8?B?eExLcTQxdGpVdXFLb21JTk4xSW9xM25XR1MwSmJ1VFF0clVKZ1NjbDB5OVl2?=
 =?utf-8?B?Mm1ydnhTcm5BanpwRzNkbzRnT1hMOGhpZGszUnZhTWxxK2lKN2NBYlF3Q0RM?=
 =?utf-8?B?N1YreHRpbjR3andVbjFBUVNGUG1RK2RYRFRzMmhVRkxSc1FSc2pYOUc1ZVpm?=
 =?utf-8?B?a1cwY0tKMTEvYWN6N1V3MFdlcHNvNGo5TVZBcXFmeUtuMkpjbmR4OGxYbW55?=
 =?utf-8?B?Qmh5RFZCL0FiRFBHZjBUdTVadlBMZitaK2lrbmZHems0WTdCQ0FrUU8wRFFx?=
 =?utf-8?B?bk9HM3k5OTJyWGI2blEzay9pSkt1RjFoeDBtdnkwVEZvV0FJSTZKY2xDNHA5?=
 =?utf-8?B?SVN5MWgrRHkrck9sUUVLV25xd2hZa2IxRmNaSzFjcUMvVythSmo2eFFIcTFp?=
 =?utf-8?B?czhSQ3dTR3M3a0xEendMT2lvS2x6SnRXQ09yTTRqUWtDMHFOMy8wUGl5aWRN?=
 =?utf-8?B?bHYwWElQSDBPcVZtc2NWREtrUC92ejYzUnJockx4Wmh5b1ZWWEZuNnVZUGFt?=
 =?utf-8?B?NFRycEtHRGRiNnhZaFdDREJ1MTRGZDJZcWFnd0Y3Uk5VU3Y1NjYycHFUYlV1?=
 =?utf-8?B?QitjTmZpOThBaERQL2lueFU0cldTSGxFMkM1VDIvTktMYmJZenlUcy9PbWJH?=
 =?utf-8?B?dzhjOEJHNnlJMWVVY21DYnMrb3JEOUJKYlVHWjdUMHRBei9nalZrQjRJbjR6?=
 =?utf-8?B?M1BGYTdWU1lzU0pXakgrS01JNlJlMHN6N3dzWnNrd2M1N0VnWjgzS1R5SUFB?=
 =?utf-8?B?SVpFR1lieS9abGNQRzJJc2RYYVBXUmI3T1RtZDkxV1BIRW1IRjQrVDRPZk9m?=
 =?utf-8?B?NThZQVVxYlQxNFpzcXNhR05WZWxKYkUycTM0RDcwY3lOUzBFaElkMjNaNUxo?=
 =?utf-8?B?ZjQzSGY1M015aTRiTGFiQUNHR01YYkpSTndvV2lmRXlnMVBsSWdHaGpWaGJ4?=
 =?utf-8?B?V2pTY1VoTlFFc2kwR1hEck9VeHBIKzRmZ0hzdEVIanlvVFFGT3dPeWtXZEZD?=
 =?utf-8?B?SktMRkpVRFBqbWxVeDdFb2tLeU9SSEFHcWRzYjZtUU5GOUdYZUhteW10b2Y0?=
 =?utf-8?B?ajkzZVBsbVRqT3RROHY0S3U0VzRWRDVGYndseHljTVNLNDZYaGRaamxnYW82?=
 =?utf-8?B?d0ZySUNtVHY3TkNHWGVNTVR4eFlUYU1BU1I1emFzVUlwdndIWXRoTVNiU0NQ?=
 =?utf-8?B?T0Fnc2RQbDRuUGZKT2QweDZ0dWdnYzJoTjRlTE5EZzJUcGdrZE9FVU90dklD?=
 =?utf-8?B?VXNOUmlnQWkvMjZTaVBMWkhpRWsvR2FjUnd0dk0wY2NOelNlYTN3OWVlVVgy?=
 =?utf-8?B?bUxBczJEblJvMVlHd0JWYlc3N3Z1Qzg3bzN1ZkVrUHJXeEpFOFNzcmxQc3JK?=
 =?utf-8?B?NTdiZDB3RGhqekwwa0tvQ1dZMnQxOU1vS0xsYndoMmswTGMyakxLNDV6Tnps?=
 =?utf-8?B?TXN1U0RtNXVjdWc3K3E0SzhFWEd5WlZoN1Uzc0xiK1d6Tks2OXB2ek5zUGpx?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0B016DC5F820248926DEF8690B0BA30@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0eda3a-7aba-4eb0-04a2-08dc01737405
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 15:50:55.8940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYBnsota64VHPEQBXsIIASmagirO4Ko7ofyucPdm7P6HNwCt44fU6SVRCp6S4Zem5mgeEzvBjks+Lgi8+lJ1ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR03MB10076

T24gV2VkLCBEZWMgMjAsIDIwMjMgYXQgMTA6NDA6MjVBTSArMDAwMCwgQWx2aW4gxaBpcHJhZ2Eg
d3JvdGU6DQo+IE9uIFdlZCwgRGVjIDIwLCAyMDIzIGF0IDAxOjI0OjI2QU0gLTAzMDAsIEx1aXog
QW5nZWxvIERhcm9zIGRlIEx1Y2Egd3JvdGU6DQo+ID4gKwkvKiBUT0RPOiBpZiBwb3dlciBpcyBz
b2Z0d2FyZSBjb250cm9sbGVkLCBzZXQgdXAgYW55IHJlZ3VsYXRvcnMgaGVyZSAqLw0KPiA+ICsN
Cj4gPiArCXByaXYtPnJlc2V0ID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQi
LCBHUElPRF9PVVRfTE9XKTsNCj4gPiArCWlmIChJU19FUlIocHJpdi0+cmVzZXQpKSB7DQo+ID4g
KwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZ2V0IFJFU0VUIEdQSU9cbiIpOw0KPiA+ICsJCXJl
dHVybiBFUlJfQ0FTVChwcml2LT5yZXNldCk7DQo+ID4gKwl9DQo+ID4gKwlpZiAocHJpdi0+cmVz
ZXQpIHsNCj4gPiArCQlncGlvZF9zZXRfdmFsdWUocHJpdi0+cmVzZXQsIDEpOw0KPiA+ICsJCWRl
dl9kYmcoZGV2LCAiYXNzZXJ0ZWQgUkVTRVRcbiIpOw0KPiA+ICsJCW1zbGVlcChSRUFMVEVLX0hX
X1NUT1BfREVMQVkpOw0KPiA+ICsJCWdwaW9kX3NldF92YWx1ZShwcml2LT5yZXNldCwgMCk7DQo+
ID4gKwkJbXNsZWVwKFJFQUxURUtfSFdfU1RBUlRfREVMQVkpOw0KPiA+ICsJCWRldl9kYmcoZGV2
LCAiZGVhc3NlcnRlZCBSRVNFVFxuIik7DQo+ID4gKwl9DQo+IA0KPiBJIHNpbXBseSBjYW5ub3Qg
dW5kZXJzdGFuZCB3aHkgeW91IGluc2lzdCBvbiBtb3ZpbmcgdGhpcyBwYXJ0IGRlc3BpdGUNCj4g
b3VyIGVhcmxpZXIgZGlzY3Vzc2lvbiBvbiBpdCB3aGVyZSBJIHBvaW50ZWQgb3V0IHRoYXQgaXQg
bWFrZXMgbm8NCj4gc2Vuc2UgdG8gbW92ZSBpdC4gSXMgY2hpcCBoYXJkd2FyZSByZXNldCBub3Qg
dGhlIGRpc2NpcGxpbmUgb2YgdGhlIGNoaXANCj4gdmFyaWFudCBkcml2ZXI/DQo+IA0KPiBXaHkg
ZG9uJ3QgeW91IGp1c3Qga2VlcCBpdCBpbiBpdHMgb3JpZ2luYWwgcGxhY2U/IEl0IHdpbGwgbWFr
ZSB5b3VyDQo+IHBhdGNoIHNtYWxsZXIsIHdoaWNoIGlzIHdoYXQgeW91IHNlZW1lZCB0byBjYXJl
IGFib3V0IHRoZSBsYXN0IHRpbWUgSQ0KPiByYWlzZWQgdGhpcy4NCj4gDQo+IFNvcnJ5LCBidXQg
SSBjYW5ub3QgZ2l2ZSBteSBSZXZpZXdlZC1ieSBvbiB0aGlzIHBhdGNoIHdpdGggdGhpcyBwYXJ0
DQo+IG1vdmVkIGFyb3VuZC4NCg0KV2VsbCwgdG8gYmUgZmFpciwgeW91ciBvcmlnaW5hbCBnb2Fs
IHdhcyB0byBhZGQgc3VwcG9ydCBmb3IgcmVzZXQNCmNvbnRyb2xsZXJzLiBBbmQgVmxhZGltaXIg
cG9pbnRlZCBvdXQgdGhhdCB5b3UgZW5kIHVwIHdpdGggYSBsb3Qgb2YNCmR1cGxpY2F0ZWQgY29k
ZSB3aGVuIGRvaW5nIHRoYXQuIEFuZCBoZSBoYXMgYSBwb2ludC4NCg0KU28gb24gcmVmbGVjdGlv
biwgSSB0aGluayB0aGlzIHBhcnQgaXMgT0sgZm9yIG5vdy4gVGhlbiB5b3UgY2FuIHRoZW4gZ2V0
DQp1bmJsb2NrZWQgYW5kIHB1dCB5b3VyIHJlc2V0IGNvbnRyb2xsZXIgcGF0Y2ggb24gdG9wIHdo
ZW4geW91IGdldCBhcm91bmQNCnRvIGl0LCB3aXRob3V0IHRoZSBjb2RlIGR1cGxpY2F0aW9uLiBJ
IHRoaW5rIGNvZGUgY2FuIGJlIGFkYXB0ZWQgdG8NCnN1cHBvcnQgcmVndWxhdG9ycyB3aXRob3V0
IHRvbyBtdWNoIGNodXJuLiBJJ20gc29ycnkgZm9yIHRoZSBvdmVybHkNCm5lZ2F0aXZlIGZlZWRi
YWNrLg0KDQpCdXQgcGxlYXNlIGhhdmUgYSBsb29rIGF0IG15IGNvbW1lbnRzIGluIHBhdGNoIDUs
IHNpbmNlIHRoZXkgYXBwbHkgbW9yZQ0KYnJvYWRseSB0byB5b3VyIHNlcmllcy4NCg0KS2luZCBy
ZWdhcmRzLA0KQWx2aW4=

