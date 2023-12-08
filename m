Return-Path: <netdev+bounces-55254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA96C809FE9
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AFE1F216BE
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7275B12B72;
	Fri,  8 Dec 2023 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="NU+Ns4pl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555630EF
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 01:49:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMDIIPVWtUEnKZgb5Up5Ur0BdEiqITL6B1oPr+8dDYjX8XtIZtuQlnaGK1MuOeRMnMW2SYorev80NHQdesvrIBR7gKJ6VfGkeNKNmoQyGUZJcT2pbazCBJXQYUnZabBLFzG4PQ48kUzMM6UudxcNSYOpZLe844kP2VLmkNOeT16Z4asBcsMp8aDwdZCE67j6wm5UAS0teM505nCmguMUct2Kb6L2XB7jJvuplyuxMwHfkCaLOQt4XUJiqx3cYvS12QhWqMiI7pTXxYLCvfxQp+2vjPZt9HWjovK3168t3FcnWA+lYltKSfrjg2zAEKWVn3jO854oStDSfFhLqHw27Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK5VcWhIPrbwIFWmoewJ3zy3cD25k6QWPm0RuPh++/U=;
 b=eBdTWZEeRjrNEI9jkvnAbOvFnv9BsmOFVy9+qtwv6L0xDMmg0oI3M1AuIPQf2T/ByTsbGc+lGoTm8EO0jxRtVyzegh74qJRdodKBAeqjBfhfhOI1ztWeZ0Soa7vmufCrhYGikFQPPLPNM6XGW2aJbPWojF+5PT2jBasYWyaSfTFyiOipwzwldrG4P/+jh6W2z3eXeFuwDgqnGGZP8yUKGUzS6fGb9Bjhw0YvmgJoLiYBKRX1qrN2UOLpChmQ8Yx84MOzC1cZZMShGZHXRWnmLNl5i6JKjt6X6J2koz1Y9rGEKYy6+CaVW054IVUXklAJ9VMk5OpdmRNdVlveA2ahQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK5VcWhIPrbwIFWmoewJ3zy3cD25k6QWPm0RuPh++/U=;
 b=NU+Ns4plM/EiJuPgEBoz5H5AQGC4keDlRpgb3eDHg1a4ZaUAn/sF9aLgTJ9VPiFu1XdYqARDGWzeLFB4HqMCUBLyG8gYt7Z7hN6zcNZyJaFZBIlKd0rviC2D1HAR5xioKXqpeZY5+SzagMd38ZzFw/SDI3TdMaLgPWtgf9YMPuE=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by PAXPR03MB7870.eurprd03.prod.outlook.com (2603:10a6:102:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 09:49:25 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 09:49:25 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO
 registration
Thread-Topic: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO
 registration
Thread-Index: AQHaKZJCSDGghDTEx0mLLZCOuOIJnrCe12aAgABNGwA=
Date: Fri, 8 Dec 2023 09:49:25 +0000
Message-ID: <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
In-Reply-To:
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|PAXPR03MB7870:EE_
x-ms-office365-filtering-correlation-id: 5b562a83-67d9-46b0-7d7c-08dbf7d2f65f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5k/pphTQTyxoG7FFouNisuUylxDbRQ9TZgvIUB230vvQEaovfs888LX98lw1zAXLPBfVwbt9S17V5apX9zomN5Jdr+BRNiXdcz9U9g9UJQ4aU73B8bV7R8X/FQtYYbFLIXwjFu5rWL5YZAXB5CCZ1uJgyjWGjC2TZb5fLUrzuAk6LmwY7Avj8iyXDbuhA9a8PvsiKo1Ajm4T00ibbMbzyoMrg+xHh0SS+fLIHsBkA9nNEZ7v7sGZM2HO8L311xTZDvgPp1ZQWApbZTMTOviIJR42CPkU40CVGkg7uE6eNyLKsImuTZrdEp//4bEzfyMOsiQcNUw2Sd6mf/GRdBn7Pq6o94FmCjqSIa1VlN7jg59wQtr6/2npdNMg8ZJnpqfelzKy6VrfmkTHiMIBzNKBlF6+KGr8I9AJNghtTxJ8qeoHiavkhElFNhcR6CDd+hN4u5v+yeAReXK5jI/muHgZgfTkEo5yg10PtjcQQLBr5GZjD4xBx2I2N1PG0n8jGC048CxRrD2v/HsRmzKwqhCIrKFs7Ks0CLDbTQ4iShXwQPDp5EpWZd0gs1eyPKcoC1wr72zscwmVZS83uerT/Q/ij4yUl6sCrtDF1CDZIIH+nMs1PwqRhajl6ZDQ7IuSOLvt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(346002)(366004)(136003)(376002)(396003)(186009)(451199024)(64100799003)(1800799012)(6506007)(26005)(6512007)(9686003)(41300700001)(5660300002)(4326008)(2906002)(33716001)(316002)(71200400001)(6486002)(478600001)(7416002)(8936002)(8676002)(91956017)(76116006)(66446008)(64756008)(66556008)(66476007)(6916009)(66946007)(86362001)(85182001)(85202003)(122000001)(38100700002)(54906003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c0xaSXdjZEZzNUpWV0xCcENxUUF3VWNrN3VPVkNiUC96Y1hYeDZoQzh3NzZz?=
 =?utf-8?B?UE5UaFVmUTM4cEltNFdKRVF1NDJvRm5rTWJYSndnRlB2VHBLZjNHUWtIeExx?=
 =?utf-8?B?NmJlSVBnUk92UGtTVFFLZTFTaU9tOXN3L1BoeFpnZFJmMEFqMzJwck44SzVS?=
 =?utf-8?B?ZFk3NUhwcFJxMTRZdkkyRjZ2VDloMXNWRk9LUExxUnVIcXJjT1B6MGM1dW0y?=
 =?utf-8?B?VHlVbmc0d2x3Ty93Y1lrbGNlQUNYZitQcUlSZDZVSmFOY29jdk5JZVA1cW5J?=
 =?utf-8?B?dm1ZK1ZuQW5FYnAxQW8xTmh2NmRPK0xPRm91cmo4K2V2RlFhdFFoOG1ncWFl?=
 =?utf-8?B?WHlmcWtJcGN1a2lIZ0JHMG5Zd29IT3RiaVhlZGhyZ1RXbGtMdmhtSW9ua1VK?=
 =?utf-8?B?QTNtSHRjZnhwcWpBRU9NUEVpU2lZdVpIRE5oclpSMUFnVVFEUStEUWphTmR0?=
 =?utf-8?B?Mk4zMVM0dHMxZGFxZ3pmSWRla0kvbEFCY2UxTVJYakJUNUpidi83bG5YL3Qy?=
 =?utf-8?B?aDNrbkFXSnFHR0VHTExSQ3VLUGtiM25aUkJiRDdmbDlQSXgwMmdhL2h1S1VZ?=
 =?utf-8?B?RXJNREhudzN2R2lyWnI0bkdrODVlZmhKa01RSUYyaWxTZ2pSdFVlQWFMejVL?=
 =?utf-8?B?d2o2UjlHSzczNm5IaG50V3hzZ01FMkhOdTNSQndCd2JxUWRQRWt3ck5sR1lx?=
 =?utf-8?B?bm5jYzZCRlpjYjZLb3E1bVAzeUNDUlloSVNjWTZ2TEp6ZDR5ck9HSFF5dTdw?=
 =?utf-8?B?TCtSR0xHaEQ4ZnFrK0FOQmVIWFI5WUtXVXZINGJHckNqaTVETXJnTUY3cTVF?=
 =?utf-8?B?aUFSTVBOaFlIaWhFY0xSRlkwNVExNDNqcmdIR3BuWjRNaVlWRzFXZGZETTZT?=
 =?utf-8?B?UzVZTE1GYW8vSFRwTkJCQUhVZWZVOGUzQVJsTzd1bTFDaEl4Rmk1N0VNVmha?=
 =?utf-8?B?ZTlieEEreEk3WjhTUms5NmtVQ1c3UWJHb0djbXUwRVIvVHpsOWh5bE0vVjZ2?=
 =?utf-8?B?UFN1V0pqanVjSU1tcFcxVXRyRVFSOHErU0Z6bUpyRm1GY3k0KzNHa3FzT3Iw?=
 =?utf-8?B?NkxOSnBYc255c2p3bkExSjg3dHpyN21TQWZuMURnNWszRzBnR1JpMEhsYVky?=
 =?utf-8?B?dlhJcDdaek1EQlhhbTlkQ3IxUisxamcvQngwQUtJQWorYVQxeUd1b1JWd1Z3?=
 =?utf-8?B?dFM1R1NLOVZKcjNVOFJPK0hNaFhDSGZtc2phd1dYanVVUysxamIvLzF5MWpT?=
 =?utf-8?B?ZWxnd0xnY0RMRDRXUE56SWlPWVNPVHpCRHJtNHh2eGl2WlVqcElWV1RyWjdC?=
 =?utf-8?B?Mm5ZdlZ4TnRCQzFTbEZTMlIwTkpZNjhaZXlGZEcxWG5yaGc5SkhQRFQ3T0pK?=
 =?utf-8?B?dzJzWXVpWFpIbXBkYU5nbjlHanI2RTJCejdNVzU2aGUwbGtybzlZNHA4RVR2?=
 =?utf-8?B?UVZlSDc4ZW5Wa2Z6UFJpRUVEZG10bUZoS2NVSkRBS2VwTWxmWjIrQWQ2aGg0?=
 =?utf-8?B?MGt1Y2RWMHVTN1liR3A2c0txQmlhQTZCRis2RjNCN3pMZGg0UzNtdjBmRnFM?=
 =?utf-8?B?VFNjYmRBUjhSRjllSTV5L25yY0RCUGhKbXVHT2ZabEpMY0hJNkM5RXJQUXJy?=
 =?utf-8?B?NzYxQ1IwNyt4bXozVHNaUmVSTFpKZk1zTE5YZU5Yc2E4eGFkOWxTWi9HeVlI?=
 =?utf-8?B?OTFGbVlhTzVxQXg4YTlleXVMMGlLaXRZUnlSdWgyNy9wUXRFMGU1ekVFZVg3?=
 =?utf-8?B?cXFweDRsWStLcWpPM0hnTVZ0cnVtbEhzUkU0d0JCSFAvK0IxbCtZRFUxQ3JQ?=
 =?utf-8?B?VUNsV1dIZ1ZBUjdoenlpZFhoOGVMa3hrRmR6anh4K3h3NjhLOHBsdDBFRTdo?=
 =?utf-8?B?cTc0OFVOWGlINGVSeWhQMktRdHUyR2pVQ2MzZTdWKzBmMmJ4TEpSZWFlVzly?=
 =?utf-8?B?VnlaT1lkdUtNVTRUak5uTlpxQmhSWC9TTmlQMlRGRGkzbzFrNWJGdkg3MWgz?=
 =?utf-8?B?MHk0cVdlNTFkcGRvTi9VWHdaQzcrTytrMlB1UXdZaTYvak54bmJRYlBYWXcx?=
 =?utf-8?B?eXhHRHJ6NGZCc3RMcDA1Zzl0cnVWWHA4Sm4yR1Jua1h3Ni92KytiVk40MFp1?=
 =?utf-8?B?c3M5UTFwTWdmQkF0bzgvSHN5Z2RMUmFFcElyZWsySXBMdnhNek1yUGxURXcz?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4C2A74A38B3B645831CC65D8CAF65ED@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b562a83-67d9-46b0-7d7c-08dbf7d2f65f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 09:49:25.1524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EiIIzkSBUkyktoauQcDA+BLOLHC11npQhFWSJEHXf2S70IwB5ylMKpoq7aCNk00NxB4rCA9N0/HQ7Jgmt/1VdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7870

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDI6MTM6MjVBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0
ZWsvcmVhbHRlay1zbWkuYyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstc21pLmMN
Cj4gPiBpbmRleCA3NTU1NDZlZDhkYjYuLmRkY2FlNTQ2YWZiYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL25ldC9kc2EvcmVhbHRlay9yZWFsdGVrLXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9u
ZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay1zbWkuYw0KPiA+IEBAIC0zODksMTUgKzM4OSwxNSBAQCBz
dGF0aWMgaW50IHJlYWx0ZWtfc21pX3NldHVwX21kaW8oc3RydWN0IGRzYV9zd2l0Y2ggKmRzKQ0K
PiA+ICAgICAgICAgcHJpdi0+dXNlcl9taWlfYnVzLT53cml0ZSA9IHJlYWx0ZWtfc21pX21kaW9f
d3JpdGU7DQo+ID4gICAgICAgICBzbnByaW50Zihwcml2LT51c2VyX21paV9idXMtPmlkLCBNSUlf
QlVTX0lEX1NJWkUsICJTTUktJWQiLA0KPiA+ICAgICAgICAgICAgICAgICAgZHMtPmluZGV4KTsN
Cj4gPiAtICAgICAgIHByaXYtPnVzZXJfbWlpX2J1cy0+ZGV2Lm9mX25vZGUgPSBtZGlvX25wOw0K
DQpZb3UgZG8gbm90IHJlYWxseSBqdXN0aWZ5IHJlbW92aW5nIHRoaXMgaW4geW91ciBwYXRjaC4g
VGhpcyBpcyBub3QgYQ0KcHVyZWx5IGNvc21ldGljIGNoYW5nZSBiZWNhdXNlIG5vdyB0aGUgYXNz
b2NpYXRlZCBtZGlvZGV2IHdpbGwgbm90IGJlDQphc3NvY2lhdGVkIHdpdGggdGhlIE9GIG5vZGUu
IEkgZG9uJ3Qga25vdyBpZiB0aGVyZSBpcyBhbnkgY29uc2VxdWVuY2UgdG8NCnRoYXQgYnV0IGl0
IGlzIHVzdWFsbHkgbmljZSB0byBwb3B1bGF0ZSB0aGlzIGluZm8gaW4gdGhlIGRldmljZSBzdHJ1
Y3QNCndoZW4gaXQgaXMgYWN0dWFsbHkgYXZhaWxhYmxlLg0KDQo+ID4gICAgICAgICBwcml2LT51
c2VyX21paV9idXMtPnBhcmVudCA9IHByaXYtPmRldjsNCj4gPiAgICAgICAgIGRzLT51c2VyX21p
aV9idXMgPSBwcml2LT51c2VyX21paV9idXM7DQo+ID4NCj4gPiAgICAgICAgIHJldCA9IGRldm1f
b2ZfbWRpb2J1c19yZWdpc3Rlcihwcml2LT5kZXYsIHByaXYtPnVzZXJfbWlpX2J1cywgbWRpb19u
cCk7DQo+ID4gKyAgICAgICBvZl9ub2RlX3B1dChtZGlvX25wKTsNCj4gDQo+IEkgd291bGQgbGlr
ZSBzb21lIGFkdmljZSBvbiB0aGlzIGxpbmUuIEkgaGF2ZSBzZWVuIHNpbWlsYXIgY29kZSBsaWtl
DQo+IHRoaXMgYnV0IEknbSBub3Qgc3VyZSBpZiBhIGZ1bmN0aW9uIHRoYXQgcmVjZWl2ZXMgdGhh
dCBub2RlIGFzIGFuDQo+IGFyZ3VtZW50IHNob3VsZCBiZSByZXNwb25zaWJsZSB0byBjYWxsIGtv
YmplY3RfZ2V0KCkgKG9yIGFsaWtlKSBpZiBpdA0KPiBrZWVwcyBhIHJlZmVyZW5jZSBmb3IgdGhh
dCBub2RlLiBUaGUgb2ZfbWRpb2J1c19yZWdpc3RlciBkb2VzIG5vdCBrZWVwDQo+IHRoYXQgbm9k
ZSBidXQgaXQgZG9lcyBnZXQgc29tZSBjaGlsZCBub2Rlcy4gSSBkb24ndCBrbm93IGlmIGl0IGlz
IG9rDQo+IHRvIGZyZWUgdGhlIHBhcmVudCBub2RlIChpZiB0aGF0IGV2ZXIgaGFwcGVucyB3aGVu
IGEgY2hpbGQgaXMgc3RpbGwgaW4NCj4gdXNlKS4NCg0KWWVzLCBpdCdzIE9LIHRvIGRvIHRoYXQu
DQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBMdWl6

