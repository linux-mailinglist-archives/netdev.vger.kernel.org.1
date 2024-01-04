Return-Path: <netdev+bounces-61583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E839824553
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7BED1F21A6B
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B024211;
	Thu,  4 Jan 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="rAAkw25w"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2094.outbound.protection.outlook.com [40.107.241.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9972421A
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is4JE+jzqG4fIcjBij9RC1MZVm+VZBCMBvQjCqXna9HYY0IuhdLLgT9l2167NE0osqepKCqdbjsjS9di7U4pDmoSezSkWBT/BBrAPpog4q5P41hWFIbvursaInR9fIeRR1dU354GTL9603Ml0NnrvKhKTTF/tXk/KfHbxdRnHq4S4fN/mXfRJOmTz+B9URJ4tibnbFg++Kzk7MKlhFWllwrGT+GcVGVWSdDqxrWLbxXwtL8ewyUaKonBJCe5RGS4pJ/0AbSRBpINwtaGM35rPeTA0wYQXtpoOm6JdLE21wVxljhM+6+PuAxQquzoXktWbjUIdnNlShE637ZLXAPy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K13MfjCSUKYLeMguozeGm4s8JDd7EnwvCcHGr3H41lg=;
 b=h0YsJTrb0jxaibCq+kBO/haIkLg4dxy1WdP5n4uZv1TshAvEmFo3UAkbGSy47NvGCuBnKTamqflnrLDmNoYMvmnIpKahJwQudPGwTLtZyVVH9VMw8wsjIGDACAUyJ6e6Bb7jrLPjltBiva1rwBqbqzUGYV40c9NNI+LjzPeU9xO24/sxYqUdWmDM0UFEmpgy1xkZxq8whpNv+SWZ6e3RFTWQ3xvu9SA75yd6tVlHutWrDGQkfNedTRKcRs/AG/TEjsApGo+F7LNWHBZJFEFfr0tpDLkgKWCA+QTFKPR/YaKV9ljZqUv1Xp2QXvm2Ib9+VISI3X/RTbLB1A26Alac+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K13MfjCSUKYLeMguozeGm4s8JDd7EnwvCcHGr3H41lg=;
 b=rAAkw25w+Z1gnFZogZcCdgIPtrBLRp5x54+kDSTCNHPaci9KhezgTcbspqtwCAxJEOd4gLQbXlsMkDPS3fVML8Hc2YqVi5rUigbj6AJ8O/izhLodVmh9Ft5zE+6/V80pkv+AggQsow3XYpa96psnAmu8RTkRGgisAfc4kO3TJl0=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by GV1PR03MB8709.eurprd03.prod.outlook.com (2603:10a6:150:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:48:20 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:48:19 +0000
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
Subject: Re: [PATCH net-next 06/10] net: dsa: qca8k: assign ds->user_mii_bus
 only for the non-OF case
Thread-Topic: [PATCH net-next 06/10] net: dsa: qca8k: assign ds->user_mii_bus
 only for the non-OF case
Thread-Index: AQHaPxaAaJgtJjgWi0qg5VWKUIku27DJzLOA
Date: Thu, 4 Jan 2024 15:48:19 +0000
Message-ID: <s3bkcacl254cqktufnkiynesjbgakvn7abnn426spn6miccrju@5gfkghgchtzy>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-7-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-7-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|GV1PR03MB8709:EE_
x-ms-office365-filtering-correlation-id: 3a2fc0e4-2f31-444b-2f80-08dc0d3c9344
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CFFZkebZ8Lf0V5F7V04LQISudTONEy5DMkubRRN083jlN1gbUaLUPVihCovfm12MrtCh80kpptTGheYNLD1MeXqezf81H82r2QSczDNOFanjZ0Wu9KM+Vt65I96I07nTU76ZmqYQ4cgwkY5hl71VuLY3fPlmpIFxeWTdxAwPiTNJIG+fOwrgKbXua2VkoCcjFz0CYhUZhqQvFE5MRy2PC7dBafFcrWC8EO+UTDY4fSMfm3xxwxRYktqYuC3CsHP8jaBlrt6KAYmw9r/+gUHhPUFkv5weD+xWUEE5U0MUP5mSiuF0VpPCj4us+8b+HcNrDGPtRHsS/1JYSxO4qQG+sIsMh7aWAbOgr/BFGR38TV2BTCizBZ5y7dUlr4OW/bRyxSbbDQN8rGwa6Pyc0JZMn6oqWHR3lhIeSt0CORMkFnyB2SP0I7JPBuW7KeicybG16yX2Y0pCYONPExyTUgv0uIBIBJ1TqFL1Sj73+MyGXDd0f6H3Vh2KvyHbdAO3wPU9ZM94VgOLwZSSayDMzdHHkWDq62FJiwKWqLv1q86ViHMtJe4d1Bw6Djpxfn7Uil7UYW3LfRM65uPyYGYCdi7nbK5R9FUMIApXyF0V9Pv/lVz4dUDcYX3cnfMQxv5xeK22bWH6RYVC75Ctf2FHanaulg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(39850400004)(396003)(376002)(136003)(64100799003)(186009)(451199024)(1800799012)(316002)(9686003)(54906003)(8936002)(66574015)(8676002)(6512007)(6506007)(83380400001)(85182001)(7416002)(2906002)(26005)(5660300002)(4326008)(38100700002)(41300700001)(33716001)(85202003)(38070700009)(478600001)(66946007)(71200400001)(66476007)(6486002)(66446008)(91956017)(64756008)(76116006)(66556008)(6916009)(86362001)(122000001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGR3VkE5VjREcE5EOTh1TllBNFErekplZGw4c3M1cVozVEpmY0dJNEIzc20y?=
 =?utf-8?B?cVlJTHhjb2YxL2ZTQWxhQmQvY3paUHlIRGNHNUhZQ3NhbkZybUlJaUoydzBT?=
 =?utf-8?B?aDdtakVNRnVPMmtxUHFsSVlObTA5UlVQUFhuWFVseXhIc1FVTnVVRDM4QVpy?=
 =?utf-8?B?NFNVd3Zoakcza1dOS3lOT0hNUDcwd3NRRllUUWozQldvMU1xbElzU1UwREkr?=
 =?utf-8?B?UHpHTWVBbHkyeFlKaXpUOTV2ajgxeHlmQ3Y3VEQzNk9ZRHIwVy9iK0FvNTlS?=
 =?utf-8?B?dTBmZmxycU5lRzQvNHN0WjNWbGRYRHhiNlgyUDJTODZ5Y2t3aGR4NXdkQ0g3?=
 =?utf-8?B?WkVZMnkwd3VxSkxzMjFqQm50dHFNMk9tdjlPYWJIS2dxV1E3bDlnU2JBMTFS?=
 =?utf-8?B?WTdOVnNqT3Bud3lYdHhnbndTNzFjODRVYzFsb0E4ekxtbmRja3pWTG0vRko3?=
 =?utf-8?B?N0l6YmNEbTVsZkthOTRRQUtvNmNFV0JrTTJSUWt0OGZaMXZzMFNvb2Jub0dN?=
 =?utf-8?B?OU9mWEpGSmtvdFV6aFlkbjBicW15MkFEVzkyZ2JzTm1GNXVaNy9EVUpLMDkz?=
 =?utf-8?B?OWZxcmdsYXN6Q0JhbytiYWpOWlB2NjlhbXI0cGlKeklHTUFjVW1JWDBSSExw?=
 =?utf-8?B?WmdGVGs3OXFjMWE2Yld5UGJLYUlCRkV1NnpIV3I5Ly82dGRTQlIvRFNtSGpB?=
 =?utf-8?B?dUIrMTFpVGhXM2QzbitFZjFYRjFtWEZkSDJjM1k1VWI3elR0dnZ6Ny9maUJa?=
 =?utf-8?B?WWlrVmpqeWt5NU4rL1BsRGV1QnBuRU5Ld0duak56YlhHSjBKRXVzNTJJVEwy?=
 =?utf-8?B?N0hpTUR6dVhKQklRbVNNNitDOHQ2WlhqcjFsemh0M1d5K3JJTG1HRW5HK0pL?=
 =?utf-8?B?Q1dDNzcxU0FpUlgxN0NtOFJVcm9SSjdiY0QzeE5VdS9YN3NCOUtTbDZFcCtq?=
 =?utf-8?B?Wi8vYjNPUGFkMWZlSnByRE5lM2Njek94REtvU3Y2bXVJdWFicVBSYXdBcGkx?=
 =?utf-8?B?TEl1N1R2WDFrdlFucnRscFNxYUhwQ1dhdjZRV2d6Nys5SjNNK1dLVWxVNlZt?=
 =?utf-8?B?Nzc2WnVKMmtORHRtK0IxdjZrbVA0U3lUSHYrK0o0TUxKUk93NFFyTUlkV0tu?=
 =?utf-8?B?dmFpSnBIMkFza2w3bkkzeEF2YXZCYzIxMUhPZ1JManZMcm1FVTdtcnpDTVF3?=
 =?utf-8?B?NjBiUFRVQ0tCUUd4Nks5T1E2VEtVZENOeEtWeDZQbkptWXZPOUkwaVdMM3FQ?=
 =?utf-8?B?WHlXTFBpcUM4bWhKeGRqd0I5OUYwbXZZWXJyQ2lSV1ZiSW9jMlJEdEcvZzFz?=
 =?utf-8?B?NDZHTGVHdHI3ZTBxcWhQYlN3V3Z0TFBjSnlQTWRCenBWajIrdEhkeWsvY0JW?=
 =?utf-8?B?VXFmR1h5K1pBODJIUmkzMmlyUHJzRkhqNnJlaTJ2ZDh4Wk1nNWphQ2VyZFNT?=
 =?utf-8?B?MldlWExrOFB0WldFcTBScXpSY085d09OV2hhYnRSSGhSOHo0QjVvR1piZ0JK?=
 =?utf-8?B?bldHZGdrdXhsNmVHWERCVGloKzkzaE5oWE5nOHZGd2htUlZkalNtY2NnK0FU?=
 =?utf-8?B?RSs1NnlhU2dzdU5TU2JmY3BJaXE4YUdGSkFmZ2NIaWVrdjBwQUlqRncyL3dD?=
 =?utf-8?B?aWZ5K0RsM0s5b2ZDVERqeU94YVdsNCtyb2NNdDNWcUYrajZUdFdqZk1RRHZz?=
 =?utf-8?B?NVJFWjlmeGg2YlBhZzBZaC90cGxSS3NzMWozM1lvalIybVZtbUs2MnFXTVpp?=
 =?utf-8?B?SWsxMXJWRTJ5blgvU2hvcnp5TTZjSVREM2hjQ0FmNFQxVlh5bDlybDBjQVhR?=
 =?utf-8?B?a3N4d2RUQzMwWDU0ajBHRnhrTm9FOE9KUGdZZ3RYSVNRNU0vOFpXL0xRU0hw?=
 =?utf-8?B?akhIQmxsekc2cCtTT2VjUVVFQWFlNFF2Ym1sbmhSZjZPY0Y5dGJFL1JnVlI0?=
 =?utf-8?B?eXNtZkozK3ZmTEJTdmE3UmhKcjB4Qjh3dEkrY2ZtUjFBWlZKVW5ia2RwLzk1?=
 =?utf-8?B?dXVvTzBpeHFXVmJMM3djWmNnWWNMTUozMEkvK1pkdzFiVmhXRnFDZno5ejVq?=
 =?utf-8?B?RHljQi9McEZ4a1RiN3MzV0Zab0RRYndzb3prUTVPRzVtQ0w2cVdxNUlWaUtP?=
 =?utf-8?B?MnByV1QwOVgzTmpqTmlvemZnbWpheHFiMlpEN2dRNmw4VUlGZGJUaWhEM2RQ?=
 =?utf-8?B?K2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1362E5040FB23C4B98F24AFA939EB4F5@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2fc0e4-2f31-444b-2f80-08dc0d3c9344
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:48:19.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PevMC537ZtRGnO4A6gpsMEm32t6TXS2E09l4eJAAEPX7zaPk+ilrD+e3ICemqy2GckLjk/XkcME0LwJs8Uy//w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8709

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzNQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBUbyBzaW1wbGlmeSByZWFzb25pbmcgYWJvdXQgd2h5IHRoZSBEU0EgZnJhbWV3
b3JrIHByb3ZpZGVzIHRoZQ0KPiBkcy0+dXNlcl9taWlfYnVzIGZ1bmN0aW9uYWxpdHksIGRyaXZl
cnMgc2hvdWxkIG9ubHkgdXNlIGl0IGlmIHRoZXkNCj4gbmVlZCB0by4gVGhlIHFjYThrIGRyaXZl
ciBhcHBlYXJzIHRvIGFsc28gdXNlIGl0IHNpbXBseSBhcyBzdG9yYWdlDQo+IGZvciBhIHBvaW50
ZXIsIHdoaWNoIGlzIG5vdCBhIGdvb2QgZW5vdWdoIHJlYXNvbiB0byBtYWtlIHRoZSBjb3JlDQo+
IG11Y2ggbW9yZSBkaWZmaWN1bHQgdG8gZm9sbG93Lg0KPiANCj4gZHMtPnVzZXJfbWlpX2J1cyBp
cyB1c2VmdWwgZm9yIG9ubHkgMiBjYXNlczoNCj4gDQo+IDEuIFRoZSBkcml2ZXIgcHJvYmVzIG9u
IHBsYXRmb3JtX2RhdGEgKG5vIE9GKQ0KPiAyLiBUaGUgZHJpdmVyIHByb2JlcyBvbiBPRiwgYnV0
IHRoZXJlIGlzIG5vIE9GIG5vZGUgZm9yIHRoZSBNRElPIGJ1cy4NCj4gDQo+IEl0IGlzIHVuY2xl
YXIgaWYgY2FzZSAoMSkgaXMgc3VwcG9ydGVkIHdpdGggcWNhOGsuIEl0IG1pZ2h0IG5vdCBiZToN
Cj4gdGhlIGRyaXZlciBtaWdodCBjcmFzaCB3aGVuIG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgp
IHJldHVybnMgTlVMTA0KPiBhbmQgdGhlbiBpdCBkZXJlZmVyZW5jZXMgcHJpdi0+aW5mbyB3aXRo
b3V0IE5VTEwgY2hlY2tpbmcuDQo+IA0KPiBBbnl3YXksIGxldCB1cyBsaW1pdCB0aGUgZHMtPnVz
ZXJfbWlpX2J1cyB1c2FnZSBvbmx5IHRvIHRoZSBhYm92ZSBjYXNlcywNCj4gYW5kIG5vdCBhc3Np
Z24gaXQgd2hlbiBhbiBPRiBub2RlIGlzIHByZXNlbnQuDQo+IA0KPiBUaGUgYnVzLT5waHlfbWFz
ayBhc3NpZ25tZW50IGZvbGxvd3MgYWxvbmcgd2l0aCB0aGUgbW92ZW1lbnQsIGJlY2F1c2UNCj4g
X19vZl9tZGlvYnVzX3JlZ2lzdGVyKCkgb3ZlcndyaXRlcyB0aGlzIGJ1cyBmaWVsZCBhbnl3YXku
IFRoZSB2YWx1ZSBzZXQNCj4gYnkgdGhlIGRyaXZlciBvbmx5IG1hdHRlcnMgZm9yIHRoZSBub24t
T0YgY29kZSBwYXRoLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgT2x0ZWFuIDx2bGFk
aW1pci5vbHRlYW5AbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNp
QGJhbmctb2x1ZnNlbi5kaz4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9xY2EvcWNhOGst
OHh4eC5jIHwgNSArKystLQ0KPiAgZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay1sZWRzLmMgfCA0
ICsrLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9xY2EvcWNhOGsuaCAgICAgIHwgMSArDQo+ICAzIGZp
bGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSk=

