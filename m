Return-Path: <netdev+bounces-55310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26280A4FB
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 15:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3782F1F2110C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2A01DA56;
	Fri,  8 Dec 2023 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="tlZ5k35v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2115.outbound.protection.outlook.com [40.107.105.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E34173B
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 06:02:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anfXKhjeEE9LJs9/93Jy6mj8asYBzOpdY4QzkgDja1kKquBMUehza3R3/3hqsA8S777olLzA3kWA/tMMm66M6KVxuzA9CD8A9iy303Q8pobC1XHMaXorixUB22yBvO8NDxKVvf9d/KTkBof0LlNGJHY/bFi1jGoC51sAafWOnKFV+IqWLg8B//o8RW5dO0EgJsco6n2pDGqxgTij07fItYIMxn8b/7XR5xnouTCSmPuxEcbcZCoGIsqut2GPI+POCH9D0SF0Ejx6CkkFd5nzMcnQVgy1HQjmS8Ikz06vTBpvHyTITj1nv3ufuze8LmoQ6lAZQjmwYgWn3tq9FtUb+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLXsqJoZoFrpPPsXXqrvU3t4jvZ9Rcjc52JYxU1jYpc=;
 b=BPd2nTu4p1LmJrVA9bNv7udscx2gir7cbXuQEnDsUu7ul+KbfnzQy15wBvjC8+64Ye9Itei4nLMxLn2SLA3HUnivHqDqYLSCONV46ZYJojnJPbQ6y0GtzYWkrh5N5jKOsRzT7zsbDf2oOa6YNJ6wtfKJvJ8zB7G1eg8ViEYjS7vA7i4yJP3TPQz9hMthoSJExbk+DcnauoZSOefgc+KJVRv5k3OwRbakAAKfsPeqcJNAmlCpf1EboXyKEPoYNXE8EIIrcnvj3xZLnxzERSz+9byeU86lFeZP4pUEvaclgvi0i1FZqSWgJNQtjZMDZXBm6qkRlItuFXTwCQcMy/Dg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLXsqJoZoFrpPPsXXqrvU3t4jvZ9Rcjc52JYxU1jYpc=;
 b=tlZ5k35vHeB/OmG7UAGHVMECvugoyDBa0Hoo2kQnv2XwYbd6EGtcSBEP/eKXL/yus+84W1RYWEo0Ah08hMp4kAHjseNwpB603p6kJhoaamt+G3O5RvFVMs4wamHpyUv/w9aQ7AmUK1F9Mu+J5qJO0C9DT/3fQgny0x1X7qq3Jro=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DB4PR03MB9339.eurprd03.prod.outlook.com (2603:10a6:10:3fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 14:02:19 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 14:02:19 +0000
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
Thread-Index: AQHaKZJHIXpg0PnQGkqm01IheWLMnbCfayuA
Date: Fri, 8 Dec 2023 14:02:19 +0000
Message-ID: <4ltsthrk2oli6ickjiy6uy3pc3kpdddse7lab34qefbadjafhy@oaxoemtrhw3k>
References: <20231208045054.27966-1-luizluca@gmail.com>
 <20231208045054.27966-5-luizluca@gmail.com>
In-Reply-To: <20231208045054.27966-5-luizluca@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DB4PR03MB9339:EE_
x-ms-office365-filtering-correlation-id: 3ec8e9f3-28f7-4c48-5902-08dbf7f64b10
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LgOCpI66ecbNgZjdK/AGjgvqNeQNejsGiIcWbAM2+gwKWAFaiII1vm6Hy8Df2I7PuLVX0HoKKZOpAIqWBJ6wH27kcXiPmUT62U+sVAxziDnfNFrClYBBh2yly7if4gapyMg4Trhap0oaLQPed2t3gq1remQ9WJR/KDVQ/DbPg2ZtXZb9u3AOwfqRP3NMzwwyFRTGA6bHrhkE4hmFwGJ2GdOYv0IeMwcRhUFi3jrAKzucbgl3h+wWUFfWxqBp5HdwJxDeBbEGOfxjjCwdTEiTn1aWzmHxJv00QmjzpmGdTF/XMRHazX+BIdyo819e0GqcuHYQ4ccrIVkWo5taryBwkzzOGpaZ5uUtLY+goSMb3IhiM9FAn7q8cRhf1QK9ebnKIUNdl1A53M6OmAcQ1ObPzyWnjJsYWkBZXLsqi+CA3gw9YqbQGU1y5xyb6XrlJSy3SDnCU87j9U6Rjj7+3j340I5fuEJdMKyFUjk5QQbMW7BMoRjwHQ7cqDjJ/FhVrKWLsSu5RQ7S70hgCoM+kcmlEGizZM+lv3MuSNC7tFOzh1hiDHlAHK7hF+fDAd4AK1R1ukPeve1RT+i7SOGb1PoDKDJGj2i2G99h/ZCUHoXQga8sy9SxIOqTz6gY/Qd8B+VA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39850400004)(366004)(396003)(186009)(64100799003)(451199024)(1800799012)(2906002)(26005)(54906003)(6916009)(6486002)(478600001)(64756008)(71200400001)(122000001)(7416002)(8676002)(5660300002)(83380400001)(8936002)(86362001)(4326008)(9686003)(6512007)(85202003)(85182001)(41300700001)(33716001)(38070700009)(66946007)(76116006)(91956017)(66446008)(316002)(38100700002)(66556008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjlaNTFSL0IrVllKbVZLSEgrYnRjN2xSelVPMUdyVVVPT3ZpcmdHYnpSMVVE?=
 =?utf-8?B?NzBuZ1ZTOFZBa0g1K0l3SHhTQUxrUDlRNXdpeEFFYXpObktmc1JRM3pqNEVM?=
 =?utf-8?B?QTVmdUZrYk9EUlFZYk42aE1CVkdaZWhLTzRWZk1KaTRnWGV2dzNsNzMwc1g3?=
 =?utf-8?B?eHVpMDAxKzk4SEtaVXQ1Y2t4b0hOQ2xwM2JCMitxa3Jsa1RGKzB3cW9Lcy9S?=
 =?utf-8?B?UVlDRjZHQ3Nrcm51V1JTcS9Yc2tUbnlvTG1XTUFjcnplOVFQdXNvZTNkUFZU?=
 =?utf-8?B?Z1h6aXlLZlAwUHFwYWRGdzhUZG1CQlpBTmhyMzV6dzZXWm4xWHY3WEZPK09K?=
 =?utf-8?B?YjJYUlZHMVRBakx5Z29lSHc1U3U2RmpDQitvTkUwUHhpdDJGMjZ0WnBNOHVL?=
 =?utf-8?B?TVhhS0YvYUhJNTFhK0hKbDVrSkphalpvN2hQM1l0Q1JDUHZJR3dTNnhCN29O?=
 =?utf-8?B?WGdCZGpOek9jT1dwcU5XZGtJTDJIeHBIeG5KdUx0bG1RcE5qM0l0TjdPaExN?=
 =?utf-8?B?Rm9iLytpS1pWUnNpMFlNdnVDWjNId1QycGJNTXlabnB4NmErVlhnZlYxY3BP?=
 =?utf-8?B?MUwxN3ovVDhKNlJnaXNZRTJiODZBellqNWduSmk4K1hpMzZiRncreSttVmNF?=
 =?utf-8?B?ajRNR2FWaXJTOW9qYWg0c0ZrdkVzVzR3aXhKcFJCczNYRCtXbm5JajQ5aEFQ?=
 =?utf-8?B?U2p3MnZQNTNuY21ObDBKSXE0TnUxZGZOMEIwbHl6Q1p2emxPR1hCdGxvck9V?=
 =?utf-8?B?aVdpZzhmZ1daTG13b1QzNmRrZG1KWURXcVFkdkhDUzJZQ20zUm9RUXpyYlVB?=
 =?utf-8?B?THFNbDg1YVRoR2RVWWlUdWpsVW1LeVZ4eFFMQnRCNXB2dmtzOGRFUERka3Yw?=
 =?utf-8?B?QWNQNEFPaTJFVzBLNitkU3VYRWhNTzZ0MWxVSnRrSjBla2Y1SFFoSzB0bWxv?=
 =?utf-8?B?NWk0T1RZVlJwMmpaUE1raGlYeElKMGwyamVwZXB4MkYrdmxCZ2N5ZFo4U04r?=
 =?utf-8?B?Q3lqNlNQbXdjcUgraXM1NmRaMzNBbzN2ZFNjVHBJR0NscDc0MmpoanFCbFZj?=
 =?utf-8?B?TVVNVmtsZzFUMmpzeU1SSWtoZ3FSbzgxSXF2UGxjSmhHWTVaeHRyeHFOSnBL?=
 =?utf-8?B?Y1lrREpZV1VQMTFSVUlFMlBPTTRzNUplSkFJNEduc0NJUVhuV3RDMnlwSURj?=
 =?utf-8?B?SnpQb0ZSaHpYc2xqaUpRem9rWmNGNFhzUkE1S3BFTCttVjVxTGhXZnFPZFJG?=
 =?utf-8?B?bmYrcGtiUGZwS09KVUk5aFVEREFOS21mNGh1dFZNTkUvazc4Uzd6bW9VTjZQ?=
 =?utf-8?B?b3A1eGx2Q2pFM0Q5ZDQyVHJXbWRFM1ZuMWRqd0lnZVJYaTRlelVnd1BWN3VQ?=
 =?utf-8?B?M0ErMWlkajZOWjZVajZCQXFQMUxXU0VReU04bHdjMzlPWHhUM1BIdUdPbmdj?=
 =?utf-8?B?YUwyOEFqbnUrOEdGdW5EdS8wNmdHZS9Ka002YVZuQzhaNHloS3Vpc0JKc2hC?=
 =?utf-8?B?NlBnZjcwc2xNUm5GRWIrNG1odlNtMHgxRW5qNGNLdVRpMGp1bjhoMEo0a29t?=
 =?utf-8?B?T1lwVDdBZDdTNzJad3JlaXY3dXRvb095MXJaY0dsSTh1d2NObU9SdndGaHF2?=
 =?utf-8?B?eGUxMXk5QjRPbzd1SU1iR2UzbUpkNCtPSE9vOG4rNExaU25uWkRLcXlHUGUy?=
 =?utf-8?B?WUc2Zm9wVE9uVlRneWo5NmdWUkZGa2EyeWNTODhWbUMzM1h4emljTjU0THRx?=
 =?utf-8?B?Si96TFVaV1BFODEvSENSQ1hJMDZheCtlWmpqREltMDU5d1l1aU4wUVYxUERD?=
 =?utf-8?B?UUN4bTdwQ1NZQ0MwOU04K2huLzJ2OGdrTDlWQmF0Y25xRlREZmo5eE10VTBF?=
 =?utf-8?B?djJzd0pQR04xQU8xcm1lVnpzK1NoTmYzenpVMENKT3BNUy9UZFM3d3htbzNz?=
 =?utf-8?B?RzM0ZXhic0l1czY1WEZnSTV5dXB2cFJHVDZnOFRZQWhzN2o2SkYwakR0MC9j?=
 =?utf-8?B?N2FUa3NRRXh6RU1NbDZNRGM1VGtyM0p6aVZNQ2cwL1Jab045aXZkT3QyMnFS?=
 =?utf-8?B?L3JGSzZCTllTUUtrV0J3V05OczFpNzBwd1pqN01vcU9UcUtpWFZ2ajdhVDVW?=
 =?utf-8?B?TytHVzQzNzRZM3BvZVFFT2ZwWWFYR2NzajRSOUNRQkE0SitBcEdVM2hTbVM5?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2150F5D62EE65A40B2DA58994C00B9DE@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec8e9f3-28f7-4c48-5902-08dbf7f64b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 14:02:19.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 49WZqHZIA4/Q3UbbC/0SzZreSQeMGAzlPqwlr9ByNrqsDwHJ52c/95hPV2PSXavi6vH+nOmS3ied/GLcMLbw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9339

T24gRnJpLCBEZWMgMDgsIDIwMjMgYXQgMDE6NDE6NDBBTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gK3N0cnVjdCByZWFsdGVrX3ByaXYgKg0KPiArcmVhbHRla19j
b21tb25fcHJvYmVfcHJlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHJlZ21hcF9jb25maWcg
cmMsDQo+ICsJCQkgc3RydWN0IHJlZ21hcF9jb25maWcgcmNfbm9sb2NrKQ0KPiArew0KDQo8c25p
cD4NCg0KPiArDQo+ICsJLyogVE9ETzogaWYgcG93ZXIgaXMgc29mdHdhcmUgY29udHJvbGxlZCwg
c2V0IHVwIGFueSByZWd1bGF0b3JzIGhlcmUgKi8NCj4gKw0KPiArCXByaXYtPnJlc2V0ID0gZGV2
bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLCBHUElPRF9PVVRfTE9XKTsNCj4gKwlp
ZiAoSVNfRVJSKHByaXYtPnJlc2V0KSkgew0KPiArCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBn
ZXQgUkVTRVQgR1BJT1xuIik7DQo+ICsJCXJldHVybiBFUlJfQ0FTVChwcml2LT5yZXNldCk7DQo+
ICsJfQ0KPiArCWlmIChwcml2LT5yZXNldCkgew0KPiArCQlncGlvZF9zZXRfdmFsdWUocHJpdi0+
cmVzZXQsIDEpOw0KPiArCQlkZXZfZGJnKGRldiwgImFzc2VydGVkIFJFU0VUXG4iKTsNCj4gKwkJ
bXNsZWVwKFJFQUxURUtfSFdfU1RPUF9ERUxBWSk7DQo+ICsJCWdwaW9kX3NldF92YWx1ZShwcml2
LT5yZXNldCwgMCk7DQo+ICsJCW1zbGVlcChSRUFMVEVLX0hXX1NUQVJUX0RFTEFZKTsNCj4gKwkJ
ZGV2X2RiZyhkZXYsICJkZWFzc2VydGVkIFJFU0VUXG4iKTsNCj4gKwl9DQoNCkFub3RoZXIgdGhp
bmcgSSB3b3VsZCBsaWtlIHRvIHN1Z2dlc3QgaXMgdGhhdCB5b3UgZG8gbm90IG1vdmUgdGhlDQpo
YXJkd2FyZSByZXNldCBhbmQgdGhlIC8qIFRPRE86IHJlZ3VsYXRvcnMgKi8gaW50byB0aGUgY29t
bW9uIGNvZGUuIEkNCmFjdHVhbGx5IHdhbnRlZCB0byBhZGQgcmVndWxhdG9yIHN1cHBvcnQgZm9y
IHJ0bDgzNjVtYiBhZnRlciB5b3UgYXJlDQpmaW5pc2hlZCB3aXRoIHlvdXIgc2VyaWVzLCBhbmQg
SSBub3RpY2VkIHRoYXQgaXQgd2lsbCBub3QgZml0IHdlbGwgaGVyZSwNCmJlY2F1c2UgdGhlIHN1
cHBsaWVzIGFyZSBkaWZmZXJlbnQgZm9yIHRoZSB0d28gc3dpdGNoIHZhcmlhbnRzLg0KDQpJZiB3
ZSB3ZXJlIHRvIGRvIHRoZSBoYXJkd2FyZSByZXNldCBoZXJlIGluIGNvbW1vbl9wcm9iZV9wcmUo
KSwgd2hlcmUNCnNob3VsZCBJIHB1dCBteSB2YXJpYW50LXNwZWNpZmljIHJlZ3VsYXRvcl9idWxr
X2VuYWJsZSgpPyBJIGNhbid0IHB1dCBpdA0KYmVmb3JlIF9wcmUoKSBiZWNhdXNlIEkgZG8gbm90
IGhhdmUgdGhlIHByaXZhdGUgZGF0YSBhbGxvY2F0ZWQgeWV0LiBJZiBJDQpwdXQgaXQgYWZ0ZXJ3
YXJkcywgdGhlbiB0aGUgYWJvdmUgaGFyZHdhcmUgcmVzZXQgdG9nZ2xlIHdpbGwgaGF2ZSBoYWQg
bm8NCmVmZmVjdC4NCg0KU28gd2h5IG5vdDoNCg0KcmVhbHRla192YXJpYW50X3Byb2JlKCkgew0K
ICByZWFsdGVrX2NvbW1vbl9wcm9iZV9wcmUoKTsNCg0KICAvKiBlbmFibGUgcmVndWxhdG9ycyAq
Lw0KICAvKiBoYXJkd2FyZSByZXNldCAqLw0KICAvKiBvdGhlciBjaGlwIHNwZWNpZmljIHN0dWZm
IGhlcmUgKi8NCg0KICByZWFsdGVrX2NvbW1vbl9wcm9iZV9wb3N0KCk7DQp9DQoNCj4gKw0KPiAr
CXJldHVybiBwcml2Ow0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChyZWFsdGVrX2NvbW1vbl9wcm9i
ZV9wcmUpOw0KPiArDQo+ICtpbnQgcmVhbHRla19jb21tb25fcHJvYmVfcG9zdChzdHJ1Y3QgcmVh
bHRla19wcml2ICpwcml2KQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwlyZXQgPSBwcml2
LT5vcHMtPmRldGVjdChwcml2KTsNCj4gKwlpZiAocmV0KSB7DQo+ICsJCWRldl9lcnIocHJpdi0+
ZGV2LCAidW5hYmxlIHRvIGRldGVjdCBzd2l0Y2hcbiIpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiAr
CX0NCg0KVGhpcyBkZXRlY3QoKSBsb2dpYyBjYW4gYWxzbyB0aGVuIGJlIGZvbGRlZCBpbnRvIHRo
ZSB2YXJpYW50J3MgcHJvYmUNCmZ1bmN0aW9uIGJldHdlZW4gX3ByZSgpIGFuZCBfcG9zdCgpLg0K
DQo+ICsNCj4gKwlwcml2LT5kcyA9IGRldm1fa3phbGxvYyhwcml2LT5kZXYsIHNpemVvZigqcHJp
di0+ZHMpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXByaXYtPmRzKQ0KPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gKw0KPiArCXByaXYtPmRzLT5wcml2ID0gcHJpdjsNCj4gKwlwcml2LT5kcy0+ZGV2
ID0gcHJpdi0+ZGV2Ow0KPiArCXByaXYtPmRzLT5vcHMgPSBwcml2LT5kc19vcHM7DQo+ICsJcHJp
di0+ZHMtPm51bV9wb3J0cyA9IHByaXYtPm51bV9wb3J0czsNCj4gKw0KPiArCXJldCA9IGRzYV9y
ZWdpc3Rlcl9zd2l0Y2gocHJpdi0+ZHMpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2Vycl9w
cm9iZShwcml2LT5kZXYsIHJldCwgInVuYWJsZSB0byByZWdpc3RlciBzd2l0Y2hcbiIpOw0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArRVhQT1JU
X1NZTUJPTChyZWFsdGVrX2NvbW1vbl9wcm9iZV9wb3N0KTs=

