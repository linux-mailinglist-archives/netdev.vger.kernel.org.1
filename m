Return-Path: <netdev+bounces-61582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7545682454B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6710D1C21558
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4EA24A0A;
	Thu,  4 Jan 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="V9kukX0b"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2100.outbound.protection.outlook.com [40.107.20.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2551C249E7
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azZOgh/ogssOZQ60XtzbTFdispZqbIySXakv/QnIeVN+oN5a3lUdT4hR/N8wChQb0akoWL8nNLgdyHdEes/fVagesy2mddVlgWrJDP8DUP3vdMaTplCJOhBV0fYBpEfVBmIju/+DUe4kr0+Xsblbyp83QGt4auCtljXD4vMnv8Ua2lrqeZvs8FExkDKEEwiZMXx9chwuLgZarJW2CflcfS9v1DYOpwZAFkA2qEkwBcIud9V9/L7X+PFPyjJbVFl/VR8Eo/TLKD4sOwerLMMdT+B6IqjyE+Nw/ToUU373+WU+sjUB1XcYGWPoycH8nou1xHS54OMCZK8xyTSAXuFNrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYuawh3S1j6pUPx++q/QeLiPOguBkydfyY+Rx2R2Fqc=;
 b=EDQOZjw/V+31S+OKMD9RC7SkDtVVDFPE2kVzkrXCvPtyvZk6/k2iotp3w9A1bRV2PIhyiuFV80q8kezhXhMIM9E1NqOu+BYo3oiX5uacQu0XlUhzdH9EgN3/znKg0nofGyGrMpreZftPE5X2Fmoc9v04mIhqrfmtlSCtZvCSeClzT1EuvzYoSS4XP8D5tMcGlHAdO2uG9RoiiZPVJRQ1MKmaFgNeoZBBHyEGZD9RjDNbsb7jit0wCabXaZwm824KwLt9mBBel+xc2N3nLPeDoIbFsumltu4JHriioR7/ziDWrXoutmC7cwC19XBLTMn8nO4373kNWsGPjZh4JAnjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYuawh3S1j6pUPx++q/QeLiPOguBkydfyY+Rx2R2Fqc=;
 b=V9kukX0b1qC+p5Di9c+KIu7ZYMwIcb0aULkIxZrg1Q6uVYleSnoopaC7AvRbu+h0r7U/fjJjeptfYDhILgWvLAwGQHw/D/jMSittXk8Bhi0KMVTsS/2Y4PvfYZSM77JB3EhSPPUmjNXLGZoYr4BlB6M2WuOo+nxOrc23getMO90=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by GV2PR03MB8725.eurprd03.prod.outlook.com (2603:10a6:150:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 15:46:03 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:46:03 +0000
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
Subject: Re: [PATCH net-next 04/10] net: dsa: qca8k: put MDIO bus OF node on
 qca8k_mdio_register() failure
Thread-Topic: [PATCH net-next 04/10] net: dsa: qca8k: put MDIO bus OF node on
 qca8k_mdio_register() failure
Thread-Index: AQHaPxZ+jLskporBGk2k0urom4TbZbDJzBGA
Date: Thu, 4 Jan 2024 15:46:03 +0000
Message-ID: <qyl2w3ownx5q7363kqxib52j5htar4y6pkn7gen27rj45xr4on@pvy5agi6o2te>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-5-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-5-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|GV2PR03MB8725:EE_
x-ms-office365-filtering-correlation-id: e0e9e580-bf7e-41d3-3d03-08dc0d3c4223
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 i/7vdAdxU8cfwS/0J8Kqqd9/3BLwy5Pl5j0qncdQAdEKD4+/87hBLRwrDGxGogG0o6uwDVfRE5zfL6c2w/+IVI0EXwc0wygh7gjjSoikvTqge6JxeEkMcdviT/YFpOZzBgVbZ2FlcztPvD8fw6avQQfKOFYbqLauyB/FgmO/R7M6QBh1SqXglAnHLk6CbSxu1jmgaaqOGmPaOpzmTzqRG1VgeoyHY3s20t+6rWEDFJtUE9vQ69jlmLMcCCRcsIQhey6awaGoLCu0hXEIkeXk4lQ1QicFMoU9a0A82c9mMfC3ZMTiZ8X+9MNJ64ckQ4enmDKyWNHNioCIUQ3hMxwgz2jxM9J4uvrAhae4VDXRlzxeIRUuZgfzP2UnFWAr7GlrTA550nKVMzeHB/f6iKqTLuByPFMaIJEu4dGABrOK/loNUeowBC3ndKVKabmsm3IGv3W9Ysvumk0p4qF3z0Yo6ptGIl9S/wdDQJ6b8CMx223weyIEDTyXs/hakKJsuUzfTlguJOGefz2q6Xb46MM0KqqzsMGHmxQMAq67FdBhpUiKANuxhYZAhItJqQZ17kZ/97X1cGX8Q/MOqLVZtRcsvEGJhzsT+qLcd6B6wdVTaidRUk5nGRPJQXNiVcaNAmDCh93S5FInsOEPMHDokj85gA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(396003)(346002)(376002)(136003)(366004)(1800799012)(451199024)(64100799003)(186009)(66574015)(83380400001)(26005)(71200400001)(76116006)(41300700001)(478600001)(4326008)(91956017)(8676002)(6486002)(8936002)(38070700009)(85202003)(7416002)(2906002)(5660300002)(6916009)(64756008)(66946007)(54906003)(66446008)(66476007)(66556008)(316002)(9686003)(6506007)(6512007)(33716001)(38100700002)(85182001)(122000001)(86362001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2RWWm9YVW1ESW5qT284WFlsSFdsaDNaNjBTVk80NHRpL3dtQ05kN2Zwc3pk?=
 =?utf-8?B?Wi9Uc3ZTSlNHODB4d3dtMWlnNFFlQndDQmp0TXNxWjhOOE1FTzIyZXJGQ055?=
 =?utf-8?B?SmE1aXRtUjNhM1cyRlVBb2kzaENsWWR0M05tZUdkZzRJS2llcUd0azBGeENl?=
 =?utf-8?B?cGw0VzF3eXNKVzIxQ2RsY2VFNUZPVzdaS2RRdGNUQ0RkelB5UjE4eG5GN3Jk?=
 =?utf-8?B?VnE2UFdBYnovN2tjSG02alJLNnhVY3llbVpVeVZCZDZNQk9NVkNnM09TZkUy?=
 =?utf-8?B?Rzh4L2lFMWE4RkU3UW9FTThxTU9zN1R6Q0tmTWpYblR0ZlIxcVJ0NFJhZW5X?=
 =?utf-8?B?VzgwUXZQRVBkdHkvWWc1eUJsaktsd2JyN2dCZVJQdW9nNU5oMzE3SEpIZTYw?=
 =?utf-8?B?WUtBQ3JpelJaMHU0b0JBQXBjZnlLZjdNMUFOekJ6NFRPVWlPSFg0Nm1OZ0k0?=
 =?utf-8?B?L1RZclhlbWlYRXpLQjhFM3cwMTRFV2gwV3c2THpxaTloS0s2S1BGK3dqN3Yx?=
 =?utf-8?B?aHNtUnJoVXY2dGptYUNuOUZpT2xEV1dUMHd6cWNOempMazQwQ09iOSt3UStQ?=
 =?utf-8?B?bWthTTlJOVhXU1k3Z0RON2c0cWdqREozMGRLeFpjaUU1Smg2WVdOZXcyYS95?=
 =?utf-8?B?K0xCbWNKZkQzeXdhUG8vcVFwUGs1d0dHNWMyK1hkS1pQckJrZlQxRW92L3M2?=
 =?utf-8?B?RmJ1VjJoTi90b1ZlZjRObHR2Y1Qvem5vV2k3VUp5amhKcXRUa0hrR3orL3FS?=
 =?utf-8?B?bTF4aGxETjhsbGo2K3FpOHlVa0V2T2FEclM5MFl4bjN0czVEcVhtOGkvREZp?=
 =?utf-8?B?RFVmdms2c21GQS8rdGl6NytudGs2VktmOXRZeG0rUFZOaFEvQmRWc3B5Ni9o?=
 =?utf-8?B?S1dTR0VCMUZHY05UejN1YnVHUDRDREZUTjZNOXJNWFpSQktHQWdjc3c5Tytt?=
 =?utf-8?B?UE83dDh5VWo2ZVpISVdYaW9EV0M3V0Z2cjZkczNlSVhwY1FoMjJDM1NSTk5G?=
 =?utf-8?B?UnA3YWtQMEk4ZmZvTUpTREpJUXlGNlhwNUdRMTVEZG5FM2J2US9hdHJBbGhy?=
 =?utf-8?B?VWMxb3J2dHduUDZWVndocVBlbk9qQkhiTkZSRzZNK3dZZFAyQ09UcjJBTjhW?=
 =?utf-8?B?TS9BT21sWHdPYXNVUWVnVTZobnFPS1RBSFNEamEyRHBOOThvK3JaamdDNllK?=
 =?utf-8?B?M2VUdXRVVVkvWFhpdWV6d21EaWtaZTQvbUlBM0J4VUlOMmV2NWMyaUhKejdO?=
 =?utf-8?B?SVZZOXhSUmRWdmpjUk16bnlNUnNRbFFOYzRUTGpONlM1YU8vQmd5UFdTT1BM?=
 =?utf-8?B?a1FEV0ppdjY2YmQ3VXQ4Snl1RzhDeGg4dWVlRnhWc3NGeEZ1MDZtQmo0cGlH?=
 =?utf-8?B?S205UllmY1dBeGRYaXNocmZVemtIcjdDaElmVTJJUFlienZJaVRGMmV3YVVY?=
 =?utf-8?B?eTJyRTRZVHZtQ25qNFFOZ3VoZFBFeG5hcTltdGI2Wm1wNWpHS2R0OU9KdFpk?=
 =?utf-8?B?TTcwQUVwY1cyVm5CT0M3YkFYYWxyOG1Na2xHdjI0M3hNRnBrNmd2c2ZTeEQw?=
 =?utf-8?B?QkhvdzdkYUZ3dEU4Y0Fpc3JXOFNNdm5tTm94OGhJNjJ5UXk4enlDeWduNlI3?=
 =?utf-8?B?dTVWeWNvdE1Xc2h0UHRSbjZHZ1JYN3NscXpSYjRIZlR6dnowSzZvMWxhajZt?=
 =?utf-8?B?dDlKUXhvd1BxNlllSlF4ZXBROUIwNnZHSjYzeHJIREFnOEVqRGhzWC9KYzRh?=
 =?utf-8?B?bXhaSEVSZXVOazg0WkFrQWJXcFFOenpVR3U0NFVnYnVZQjhEMjF6cmJtS3lJ?=
 =?utf-8?B?bWxrMHhvL3pnUkEycGdrQ05oWVgwTVRETXNyUFVqMzZHeHFsQlVaRStaQjlq?=
 =?utf-8?B?VWpwQjUrYU9NWm52YmVlelRKT2FQbVpGbFpza045YzBJWm1nUU9Rd09VUzFp?=
 =?utf-8?B?b2lRcGU4WnBNZlI2RlluYjBUZzlqRzZ4d3NhTFArdDBrZEF3anhPNkRjR25u?=
 =?utf-8?B?N1lxcGVDT0NMT3hmU1Ywd2l1Z25CMFZ0NFZSQnBzM0hQMVdIdDJNK2JEU0FK?=
 =?utf-8?B?a3BiVStlZmNta25VbWw1R2MzM05pckUwVlNXZzZXbEhRVEJySE41OWZ1NmRo?=
 =?utf-8?B?bEt1ZmZUbGMyNC9KRmlNb2pycitZd1Y4dWZ3NHlRdFNmRkVCOGhEaEkvWlc2?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3010F220E527ED45BA28E6C0B802BD38@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e9e580-bf7e-41d3-3d03-08dc0d3c4223
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:46:03.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwv6/8p0a/ARrAob6ftChsVjvkBnf/iQByj3KAwNbme07jj5qpkQqImqgnj/G6dJbmVWRpvYUdJuLDXQoMPqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8725

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzFQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBvZl9nZXRfY2hpbGRfYnlfbmFtZSgpIGdpdmVzIHVzIGFuIE9GIG5vZGUgd2l0
aCBhbiBlbGV2YXRlZCByZWZjb3VudCwNCj4gd2hpY2ggc2hvdWxkIGJlIGRyb3BwZWQgd2hlbiB3
ZSdyZSBkb25lIHdpdGggaXQuIFRoaXMgaXMgc28gdGhhdCwNCj4gaWYgKG9mX25vZGVfY2hlY2tf
ZmxhZyhub2RlLCBPRl9EWU5BTUlDKSkgaXMgdHJ1ZSwgdGhlIG5vZGUncyBtZW1vcnkgY2FuDQo+
IGV2ZW50dWFsbHkgYmUgZnJlZWQuDQo+IA0KPiBUaGVyZSBhcmUgMiBkaXN0aW5jdCBwYXRocyB0
byBiZSBjb25zaWRlcmVkIGluIHFjYThrX21kaW9fcmVnaXN0ZXIoKToNCj4gDQo+IC0gZGV2bV9v
Zl9tZGlvYnVzX3JlZ2lzdGVyKCkgc3VjY2VlZHM6IHNpbmNlIGNvbW1pdCAzYjczYTdiOGVjMzgg
KCJuZXQ6DQo+ICAgbWRpb19idXM6IGFkZCByZWZjb3VudGluZyBmb3IgZndub2RlcyB0byBtZGlv
YnVzIiksIHRoZSBNRElPIGNvcmUNCj4gICB0cmVhdHMgdGhpcyB3ZWxsLg0KPiANCj4gLSBkZXZt
X29mX21kaW9idXNfcmVnaXN0ZXIoKSBvciBhbnl0aGluZyB1cCB0byB0aGF0IHBvaW50IGZhaWxz
OiBpdCBpcw0KPiAgIHRoZSBkdXR5IG9mIHRoZSBxY2E4ayBkcml2ZXIgdG8gcmVsZWFzZSB0aGUg
T0Ygbm9kZS4NCj4gDQo+IFRoaXMgY2hhbmdlIGFkZHJlc3NlcyB0aGUgc2Vjb25kIGNhc2UgYnkg
bWFraW5nIHN1cmUgdGhhdCB0aGUgT0Ygbm9kZQ0KPiByZWZlcmVuY2UgaXMgbm90IGxlYWtlZC4N
Cj4gDQo+IFRoZSAibWRpbyIgbm9kZSBtYXkgYmUgTlVMTCwgYnV0IG9mX25vZGVfcHV0KE5VTEwp
IGlzIHNhZmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZsYWRpbWly
Lm9sdGVhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFsc2lAYmFu
Zy1vbHVmc2VuLmRrPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay04eHh4
LmMgfCAyMSArKysrKysrKysrKysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2RzYS9xY2EvcWNhOGstOHh4eC5jIGIvZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay04eHh4LmMN
Cj4gaW5kZXggZWM1N2Q5ZDUyMDcyLi41ZjQ3YTI5MGJkNmUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbmV0L2RzYS9xY2EvcWNhOGstOHh4eC5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9xY2Ev
cWNhOGstOHh4eC5jDQo+IEBAIC05NDksMTAgKzk0OSwxNSBAQCBxY2E4a19tZGlvX3JlZ2lzdGVy
KHN0cnVjdCBxY2E4a19wcml2ICpwcml2KQ0KPiAgCXN0cnVjdCBkc2Ffc3dpdGNoICpkcyA9IHBy
aXYtPmRzOw0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbWRpbzsNCj4gIAlzdHJ1Y3QgbWlpX2J1
cyAqYnVzOw0KPiArCWludCBlcnI7DQoNCm5pdDogYmVzaWRlcyBxY2E4a19zZXR1cF9tZGlvX2J1
cygpLCB0aGUgcmVzdCBvZiB0aGUgZHJpdmVyIHVzZXMgJ2ludCByZXQn

