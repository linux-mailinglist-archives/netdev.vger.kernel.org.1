Return-Path: <netdev+bounces-61594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A782459A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A301F2331C
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BF624A01;
	Thu,  4 Jan 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="onnLbSZN"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2099.outbound.protection.outlook.com [40.107.8.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE002374B
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnTwxYga6lklup6KVX19eH1sgwsT8E3He0gOlZip3Am+CA7/PYqGBbwqUsfZgz3itFo2m96en3l0nJ1gw3jptMJPVIYiEAVAV3Uo92z0154Bw5ZTqLhT1UrPrHBBE94L0o25sbl6Csd/DhYDvrcEcHNfgYVCOK2p0NHyg1t+HAIYjpi6lc+X75yIGyv90/Ng01DU9I4kWZAPGO/kbbHIrvnsbKtOQu5zsqkNhFeEiDiTSbOyS484OojQxq/JM4b868Wj362VBpOWz45RaPzvTE4074u2EH/gzKGp+MRsP1cFcfqR/VOolB4h54MS6sFJyKCntERj+PfITEYMycll5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6LsUNyBrwflxeLNrzI7kIT8Kt25hOKPm8h3WM5X5Y0=;
 b=FVSqob/Ft+iwh0OcfD85l4MhwwWfuZnpHn3/H/o6+lK3lay9GQ6s8oN+Fpjf7dMPdslQbw3flG799fgSTV6xh8IJVPT37OxH64QU7ywvl4a426dhIkiHT1jLjQQI7LpHt8E/2eb7y3rpHbcQ4aa89DqmC3WKzQZQ8+IOz2bOLsmVNpKTsLt5zm6eWSXb0Vn0yumnb1zQWhxNnX5x/ZT7ya6inIKm9DGjZuQ99V3ogL4PSonX6Qc5ocIWBBnMQ1E4ioFABQpOncAHwAMeyYcKyvlHsqKFhRKJ42rrlOqylOfiT6PcDxUrh/A3bE5QKrZvQKJEE6Na4vr8hJ4MsjEgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6LsUNyBrwflxeLNrzI7kIT8Kt25hOKPm8h3WM5X5Y0=;
 b=onnLbSZNZZ6LvDfqo5nMbGRB5NKf9uwoEIvIz/u6rV1f4CdMdvcBvwA6sDrLclWai1qrgmC9ntH4VUEFvzEnpv2S0p5cq6nxgZSyohTqvXyjcTtGvzNxy+5/+NYuFbiw6uaY8tfJbdlS32uqAWy4pi/IvGdE7zCLzm86DKdPTVA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS8PR03MB6757.eurprd03.prod.outlook.com (2603:10a6:20b:292::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:59:52 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:59:52 +0000
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
Subject: Re: [PATCH net-next 10/10] net: dsa: bcm_sf2: drop
 priv->master_mii_dn
Thread-Topic: [PATCH net-next 10/10] net: dsa: bcm_sf2: drop
 priv->master_mii_dn
Thread-Index: AQHaPxaBDKf/+ptYPEeDGK93/PTpS7DJz+0A
Date: Thu, 4 Jan 2024 15:59:52 +0000
Message-ID: <xq3ittuw6mqwfi65nj6envt3y43k5zb4mqo43jqdy5v5zf5smm@k6j2s45v35pf>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-11-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-11-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS8PR03MB6757:EE_
x-ms-office365-filtering-correlation-id: 0392c91b-2681-4acd-5ca7-08dc0d3e302f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MbPYOYMxdJMXAkdlcNkEhEBbnD3sFPnRYq1m/NrtYOVlQtVkpfuovLhPm7Umk2M90mB9YXm4r92UODQBb8BTdjHEdDThceEwKf1FjFhMw5LnCKko1/tc9zxxGo3gU6Qk0crzSBocgGe4LU7xES7YrasYsG96/mOxAT77q1hccFwAo635cysOFozUyJIKElBavmP8LcZ/ZZ1Xw2tFGrSp5Jbg3AwsSmX/pJ3h1sI3+vsVsvLXwp6X022779ABIHzXMAfaiaQE2ibr/tesbhiTKNY1dVDUMU2kt/a+wCWppRxlRijaP3wgWRIzEbhTvu3nZRs0NpeOJS3NnjbBT+zmnvoUgBv38T990I8jXgxtJ5P5JTUzf9112pvna21K2ouQ7QXBFSRruiaMvxfcYjeV3jz1VXe4/jOlZWObSyIdFnqk9sL4jKgfAkU9kstwJwAiBbLg8zZIiKmFfXxyOlz1e5KesFldncNX0oZmXEs4eZHhsCLGUlRHpuA/3dE76tzFij5tuUn0xqR6Xxf+CPflww0XBuVTcjfcImJb94aZtEEdvG9LR5USqW+JLuKlo92tV1fyZYWLZGJGiH7jYH3GseCL0OEC4RQdTux5XsvXH5O91aG4qU549oBk853KXuzB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(346002)(376002)(39850400004)(186009)(64100799003)(451199024)(1800799012)(5660300002)(2906002)(4744005)(7416002)(8936002)(4326008)(316002)(8676002)(9686003)(91956017)(66476007)(64756008)(66556008)(76116006)(6916009)(66946007)(54906003)(6512007)(26005)(83380400001)(41300700001)(38100700002)(66446008)(33716001)(122000001)(86362001)(85182001)(85202003)(6506007)(478600001)(71200400001)(6486002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXdSdWdkMjFrb05lV0NSNlVNRkMwT2ZabEZ2aVI5U0gxM0g3ZDRBZk5NM2ZT?=
 =?utf-8?B?NWYveTF2VWIydjdISnpYQUVMQS9JSUFMeXlIU29VOVpwZnZkT2RxWjFVQlAw?=
 =?utf-8?B?aTdPSFJCOHZNNWlSSnFnUWl6cGRUWDExQkN5OE9ta25HblE1MGFOaHNIYW9Z?=
 =?utf-8?B?SXRIQW8yVUVPaDFPbTRzWGNyTVdTb1I2SkczcTdYQ2lxZVdUb3kyVUtYczlp?=
 =?utf-8?B?TWIxbkNsRkhycFk5dDEzQzRkMmhTVWl1dWdLYjFOZWd0ZSttTC90MGF3SWxB?=
 =?utf-8?B?aUdrMjFBdWpxRlJSemVpMVl4dFV4OTd2Tm1BbllOMUV4VUg0K3ROeW1uME00?=
 =?utf-8?B?ZWpxSDR1cUx0MHhobEhmTUpBZ3RJUFd4cXNnMUlRL29qQXJYdHRNbzRpV0g4?=
 =?utf-8?B?cVdqYjNGZ3RrQzB3YWw2RnZxOUdCeGNYZU5aME1aT1FNRmNiT05tY0ZhQlJB?=
 =?utf-8?B?RWRlaVdMMTVKcjc5TlFJZWVEYnN1RFVOSXo0VURmZnpYQUQ3czljUi8yc3FT?=
 =?utf-8?B?S3l3Y1ZySjRWeloxaENYSXlqQWVWOTFuL0x4Y2E3Q0hWcmpoVllXSm5WMGpZ?=
 =?utf-8?B?c0dsU1pMTTFYVnB2alRnQ2pJeVQ5ZmJJQkI5bk1sNVhxSEljS1QxTURkSmNi?=
 =?utf-8?B?d1RNQWwySG1KdDVGa2llTkhqTGpIdDFBS3BKUk9QVjR2SW5jbS9ndm54RkJB?=
 =?utf-8?B?aDZOdEt2U3VKbWgwczZLc0RWWG04SUVGMUl3QW1HM212UVRXdncwNVp3ME12?=
 =?utf-8?B?NU01eUd4YzVyZnh0MzRsaVBSZXVNQkMwMUk3dHl1R2FBWU95K1RzdUtRUDY0?=
 =?utf-8?B?N1NKYTVpYTFYQlpUYVQ2NUlaK2pJdlJCaXpFa2NrSjViQkdjaVM2cUxSd3la?=
 =?utf-8?B?ZDhZdVgrMFNNNEYrM1FLVVFtWWxaWFQrY2lXcHY0ZE5MT2U2aGxiZzJ6TVdx?=
 =?utf-8?B?c0cwQkE1VUZ0S1hGcTR5VHQ2OHVMOGFUSEMzNkZ4NDAvR2VRYlFFZ3dScjF3?=
 =?utf-8?B?NUwvTUU1T2MzZlRQUWZ2R2s5RG1YZjM0UkNhK3dBbm83dkVlT2hQN1dubHNK?=
 =?utf-8?B?UHNCTUpydVhrV1NmVi9tYVV3N2g2K2Z1UTMvSjVjNENwelZEcE56ZGtoS0NU?=
 =?utf-8?B?a1F2WmVWL05CVXRhdVg5RldXMUhHSk9XbjMvQ2J6aFVIbFBuanhoekdmRG5K?=
 =?utf-8?B?eGNxcnAwa284a0VLdE5WcVZDWi9yV1RtNUdDSFFOU3dVTHQ4MGdlRTVUU2xI?=
 =?utf-8?B?c2pxam12dWE0MTVEbGN1RUtucHIwNTZXenN5RXVRRHYvKzBvazJUVnlBRXlz?=
 =?utf-8?B?YzZ4cjlpTWFoSnRjS3podU5zcHVXQzluMmZhdWlTeFNwSGJVZERzS2wrQVQw?=
 =?utf-8?B?NERMNDZOVFJ1RXNIWEVtdk1NNWJWSnlaZ3orSVlUTmtUMk5ESW1pR1JNTnp0?=
 =?utf-8?B?SDQwSmExN1VQR2dLZ1B0MTdxdWhSd05LZVUxbjEzYmJzQXNGZXNVSGJmd0V4?=
 =?utf-8?B?Q0JRUWc1Z1p2SW9zYVRkOG9sTDJRaW9kY0JLcUtrNjNRVGNacmhXZjkxY0Rs?=
 =?utf-8?B?RGhhU3V2Z2x4UnArWXJTRUQ0NDZsdzlwUXY4eldLOVFTQVBmakZDelg5dWVq?=
 =?utf-8?B?aDJMdjdFOHZrSlJaOStMSlcxN0ZhdEFuZ1hoM0Rxb0VDSmNueS9zYWY5OXlh?=
 =?utf-8?B?L1V0dTI1bEl6ZDA2ZitwZ2g4VElUdHNkWHlpOHlwS1RzSEVPY2k3aHg3OHJL?=
 =?utf-8?B?NHJYNnl4ZVRZK2tjZjM3Z0hKUnNPdXAvVUpkVzlUQWdMNG9VcDlKN0lqY3J4?=
 =?utf-8?B?RktpblVwVzdocE5xaXAyaytkbzNpMUN5YzkwLzhVNzE4U2JITm9JT2E4TFk4?=
 =?utf-8?B?Yzc2b20yTnV3Q01Sb3lUVmJrem1qcTVnRVpoOW45R2VIaE1xSUVUaXQyT251?=
 =?utf-8?B?N01wSDcwQk5XYkhqcXdSem5mVnoySFN1TVNXYlRuOVVkTGVUaENlVVhwbk1Q?=
 =?utf-8?B?eW45U09EL21VdEVnN0l1V29nUVFraUpSRCtGTFJWUzdhOTdRd2V0cG8xYzJv?=
 =?utf-8?B?YXluTlYvOUZQVDJIUzZ4WnU4MU1xdm1QdzlJTEd2UC91UkpwYXNlUFFWZlhQ?=
 =?utf-8?B?YVFUZm5wWmY4SXpVc2V0ZjB4UmNKdkFKU3IxNlRIdjIxL2Z5N1JFTHRNME5u?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A7636D5D9642748B473AEAFCF6E5683@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0392c91b-2681-4acd-5ca7-08dc0d3e302f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:59:52.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PnXkxVyBV6HMHgzlrLDNb5jb8i3JUa6i54ZWgI12kdPFhiYYKBE8SMGtDPwcDWuIdcxVkzoW95Va3Cd2pQCBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6757

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzdQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBUaGVyZSB1c2VkIHRvIGJlIGEgb2Zfbm9kZV9wdXQocHJpdi0+bWFzdGVyX21p
aV9kbikgY2FsbCBpbg0KPiBiY21fc2YyX21kaW9fdW5yZWdpc3RlcigpLCB3aGljaCB3YXMgYWNj
aWRlbnRhbGx5IGRlbGV0ZWQgaW4gY29tbWl0DQo+IDZjYTgwNjM4YjkwYyAoIm5ldDogZHNhOiBV
c2UgY29uZHVpdCBhbmQgdXNlciB0ZXJtcyIpLg0KPiANCj4gQnV0IGl0J3Mgbm90IG5lZWRlZCAt
IHdlIGRvbid0IG5lZWQgdG8gaG9sZCBhIHJlZmVyZW5jZSBvbiB0aGUNCj4gImJyY20sdW5pbWFj
LW1kaW8iIE9GIG5vZGUgZm9yIHRoYXQgbG9uZywgc2luY2Ugd2UgZG9uJ3QgZG8gYW55dGhpbmcN
Cj4gd2l0aCBpdC4gV2UgY2FuIHJlbGVhc2UgaXQgYXMgc29vbiBhcyB3ZSBmaW5pc2ggYmNtX3Nm
Ml9tZGlvX3JlZ2lzdGVyKCkuDQo+IA0KPiBBbHNvIHJlZHVjZSAiaWYgKGVyciAmJiBkbikiIHRv
IGp1c3QgImlmIChlcnIpIi4gV2Uga25vdyAiZG4iLCBha2EgdGhlDQo+IGZvcm1lciBwcml2LT5t
YXN0ZXJfbWlpX2RuLCBpcyBub24tTlVMTC4gT3RoZXJ3aXNlLCBvZl9tZGlvX2ZpbmRfYnVzKGRu
KQ0KPiB3b3VsZCBub3QgaGF2ZSBiZWVuIGFibGUgdG8gZmluZCB0aGUgYnVzIGJlaGluZCAiYnJj
bSx1bmltYWMtbWRpbyIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4gPHZs
YWRpbWlyLm9sdGVhbkBueHAuY29tPg0KDQpSZXZpZXdlZC1ieTogQWx2aW4gxaBpcHJhZ2EgPGFs
c2lAYmFuZy1vbHVmc2VuLmRrPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL2JjbV9zZjIu
YyB8IDYgKysrLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvYmNtX3NmMi5oIHwgMSAtDQo+ICAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSk=

