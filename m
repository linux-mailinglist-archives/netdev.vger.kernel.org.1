Return-Path: <netdev+bounces-59748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D1381BF61
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629B71F25A1D
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 20:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E1697A6;
	Thu, 21 Dec 2023 20:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="DD92yRjp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2115.outbound.protection.outlook.com [40.107.20.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1735651B3
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0eFwBzcoSu3nQ3e3ewRO8+jQ/hPW/bZklbW/gZH5z4/CM1G55L/vWrYYFJJ0whJjHI6XsRPaK3R9bMYoVS1Dm5lluOi9i46KFvGJb2Vk/tJWZlhQV8kCLRK4OefosUzfHnaC0XEBjkdD02+81yYRiCczfjWcSpeSYdA7qb50MfUT60fwwjPNCRQ6tRpLiC1akK9ntjSkc+No9j5aqbOr/oqfcEXqD4iW7q5/S6glan5KMEBEem3605GbFIATMDMrlCLa4adS7ji5yy5DMC0buRPbyen0N3Sl4OG7Zq8YL85ij9ugrn+MKf14ed6DGTEuMDGz2F8ninaBxV0sxOdWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5as8lbVXY5LWhAc2tiBioorYFBlziOmofiHmFbvhKmg=;
 b=U+Nkm3Z1z/4i54bij1tHZpJJnsMFKA0isWSgCXCX6PHXEm/0QJTeezoiQn5gP4VopE7QHkuQgwX16ne+UdhAifcTcfcaMMNWciomqJr8YLqNfh+67pexT/oYDvmlQL+4b8Qp5/WpGc9pN0qGeL5T+aRwikfJ9ni8xrG94PjncVAe57Rw7SlZiOTWb2U2JuIy5KEqYGY16g8O3B6CgbOkTkhfqVjkK2j8fqjsE47vqir83JwO3mWU+wTMZOkJgtBV/4d1H09+gO+WHAqrsvCm+3QCTvlTWdHB6uhCG6hb531yO8hifrRRsng0ju5tWlUoTnMvJAZWE1iWH76QJGm/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5as8lbVXY5LWhAc2tiBioorYFBlziOmofiHmFbvhKmg=;
 b=DD92yRjpT90kmmCfGAtOXsCLbAXne45deSP4sfPrTJGuJOVgW/6m45RBgCjLwNwJCRLdFFQU50gae1mmPLjiTLYT0pMHOQ2q680kHcs3tut7iAiUS6+dXQAwdhaw7ixHnmkn/E8JNu1oZLm6jZZU40EdahxMG6eIW82BMGiAsQY=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB9244.eurprd03.prod.outlook.com (2603:10a6:20b:5c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 20:05:45 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::99e4:a3b2:357f:b073%3]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 20:05:45 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Luiz Angelo Daros de Luca <luizluca@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from
 realtek_ops
Thread-Topic: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from
 realtek_ops
Thread-Index: AQHaMvzGDp0XeS+svECBFEZw+tb/bLCyMw0AgAHGcQCAADKxAA==
Date: Thu, 21 Dec 2023 20:05:45 +0000
Message-ID: <ll6hlbujrzq6djjzfcoxp3powgrwxa6moplhrzpdy5fo5qwlxt@civqgrrqu727>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-2-luizluca@gmail.com>
 <w2xqtfeafqxkbocemv3u7p6gfwib2kad2tjbfzlf7d22uvopnq@4a2zktggci3o>
 <20231221170418.6jiaydos3cc7qkyp@skbuf>
In-Reply-To: <20231221170418.6jiaydos3cc7qkyp@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB9244:EE_
x-ms-office365-filtering-correlation-id: 146b1a40-8caa-4024-6f5e-08dc02603789
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ManGp26mkqVtmEg1Y8ehIMTFy22syr676V146TgYidW6RZk4vyNRjaYy1LVs/Ej+TLlMBG8/CPMZgRBZ2mNY+xo6AHVF9uLmN6oxgfH4eIVQHf4aSXdrlGB8vx9IxIF4JkpHhUH4Rv5MX6wUM8+J4MPYkjI6VXB0qC9IByLM1O8Oconij0+AvhXN1aefL8zsOFH2OhGBssLjRLLSn+b9V+UuTbIo2vn8Cc54u4DU1L+3AHmdfoKPhi+XBUqgvwNErymd7NXq/rxiWhq4wHHu9lQ8obaoDVN+IVLFPH4PoWA+U/Qt/aopY35Jz1of4qg8YIQVASqA+FgTuIDWJBKZLqo5yiinaBEGSvACy9Ag9QeMlBMBxCX5XeMB3NU6DrNpnIPiYHmOi0sN8qA8sMansGszIyseNVCpjWAgxXFQ9QcAbLQAIJW+eISMdHjLiVo0P9NpfNlUmPtx00tirQLK62b2rfWi7oSzrE8liAIf06SYZeexnv38M8WIcFSZQlNic9sD7ZYiLcFu8qk0E7nn7Sjqtm2wdHWFHHGaFm04jPbYXyUURjUPuS1HLCyXvESmIGK8vFFiEQm3+b9ScWeqMS1ygM2c4myt+LLv3gaY544=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(366004)(396003)(136003)(1800799012)(64100799003)(186009)(451199024)(66899024)(26005)(9686003)(6512007)(6506007)(71200400001)(85182001)(86362001)(38070700009)(85202003)(38100700002)(5660300002)(7416002)(83380400001)(8936002)(8676002)(4326008)(41300700001)(122000001)(66476007)(66446008)(64756008)(54906003)(66946007)(66556008)(6916009)(91956017)(76116006)(6486002)(966005)(2906002)(316002)(478600001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzgyRGtERE5yQURzclp3RU1qZklPWTBWanRwa3paekNIRjhaUStaZlkrbHJ0?=
 =?utf-8?B?cU9oRnVtUzhrN2xFMWhDRDh0NXowWjl0NHN6U2t5Yk1OTXpOWnRmTWxhOEVR?=
 =?utf-8?B?V2loczdzb1d3Tk9iYldrbEV5UUt5akN3TTVMUVMya1doa0k2UjVTL2JqY3dp?=
 =?utf-8?B?NjRPYnVQSzNRVUJvSmZGV3d5M3FjdWgvc3lWYkxFbjJiZ3ViemRPY1BKUHlR?=
 =?utf-8?B?anF2VEU0S1QrajJieFJUMEhqN21ET2NMdVhRZW1CVnlHbzdGV1RMUURyL3VP?=
 =?utf-8?B?QWZ4YjQ0d24wVUdMYXBVNlk0K2V6RmpVV3pQYVFocTJQUFBxaUgwbCtKZHhz?=
 =?utf-8?B?VXUvdDNSYkFsQW4vVkFDYWpFQ1htbGVTbXBENlNUQmNJRlhLNm9TenZ3QTNQ?=
 =?utf-8?B?V05VVHZxRGplYW1zNmV4OXYxT3NkMCtYRXF2T2I0dDBQZG9oRjk3NUx1REpL?=
 =?utf-8?B?aWFLdDVaQWo3c2JrRzlDUkxyMFY5STJZWG5hSlN6SG02K1pscHduSFRwdkR0?=
 =?utf-8?B?RktXaW9SZERpVFpHUDJTTEhVcTR5L1Qra0p0SUtWMUpYQlNtN1djVXlwS0Zv?=
 =?utf-8?B?ZUlZc25oV1F6R1pZUUdOQ1FhVVhwZ0xxc08yRTJzdjRGbXJqeTl4UFhZR29C?=
 =?utf-8?B?OFpTdEZHa1dPc1luaFJZMExFQzRObDNnMkE4NG1sMTBSUkVEamlWQm5JVGxt?=
 =?utf-8?B?R2pRMnpZSDFTSDlITW1DbURzNmlRQjJvMjhOV3lTdzY4VXE1QU5zTEJKTUJu?=
 =?utf-8?B?UCtxWkpLc1NPd0xnTTMvYURtdGNOQ0c0Z2lXbkQydll5SE82ZTlTK0NnZTRU?=
 =?utf-8?B?ZWJRb3pCcWp1aGFGUHV5SEdPb0svTG55YWJkT0VuYVJBK3p2TXNCSTlYS2hQ?=
 =?utf-8?B?aXlTNG1nVEExd01VNUkzZ3ZxRmllZDBUcGNOTjQ2QTJoOWVjNHZsNUpVdlpq?=
 =?utf-8?B?Z3l2Sy9JL2EzLzg1cHVBbnJ1ZFl1ZlB1TXJraDIzbEtqdENSUGFkd3BSUXhY?=
 =?utf-8?B?MWhReklSb3NMVTdzSVByM0xabkQ3Vk9rNmFVWWZyOG5sRmxRamFPbmlIZXVr?=
 =?utf-8?B?dVFrdFNtWXoyUnFyZ0JrRnNvcElySVRYUGsxY1VHTTN4OWlsTFB5R1VGeklm?=
 =?utf-8?B?L0VadXllTWJUQytlcHBiMHBtYkVIYU9QQlNsU0lrSDB1RTgwQ3llNmVQaXEy?=
 =?utf-8?B?cC9MQzcyZzdWNDZhNFNyNWJUREwxNElLTzkwLzFFWWIzSUVDN1VhMXJnTmhL?=
 =?utf-8?B?cUJweTIyc1lFUmlja3k4TndEQnlFdGlsYTBUZ1NGaGRwZUZvOHRmVVlkZU4v?=
 =?utf-8?B?eEJVK2tHQWV2STNBUFhrTTJHUXlDcDU4bTN3aEw0cU9vNERXcWg5djJ4QVlF?=
 =?utf-8?B?U0FqOE1lZUxTOWY3VkpQTTRtQklLUmdpK0tsbWVVM0FaYS9JWTFnZTZ4c3p0?=
 =?utf-8?B?VlpmK1NCRjdYendLaEI0M2hPdC9vcHEvMFdvSDVicTF2UnFrdEhRaXduMmNN?=
 =?utf-8?B?RXUwc1B1czJoWmtpd1dMaHg1Sm5kbTdlWUNWQWUwbG1xUEFCMDZCRFZqZytR?=
 =?utf-8?B?a2tzazAwRUJWYjdUelFpM01aWFI3YWxtQW82bXBGeFR4MW55b09wQzRGV2Qx?=
 =?utf-8?B?S2pqMTExalFZVTJjRmJYb05lcktLY0VsVGU5eHVoN0J2NytvaWJFZlJEU1Nh?=
 =?utf-8?B?bnd0ck5uZWoyMFNYaXB5YmU3U2NhY2NFR0RkcjZoY2lmYnZhMnNvY1krTE9h?=
 =?utf-8?B?N0pGY2JzeHRLVUR3VStyM3V0OWpuOUNQRTNOK3Q3NmFUdkVxeGkrZGxYWVFJ?=
 =?utf-8?B?akRITFpSTXNOcm9TOVczRE1WR3QyNGdteUR4ZEFlcDlxMCtlamMrN2JLclFl?=
 =?utf-8?B?YWUvdGt4UzVnZmlEQnRlMUExY2JCazd6dkpTdE9Vdi9heGkwOGJWRHR2Q2Nm?=
 =?utf-8?B?ODdFVEY5OFBCWk5meXlnV25IMmtHWjVnSkJHZ2pzQ25YcUM5MUtXdy9tRTdJ?=
 =?utf-8?B?NjRBT01Eb1MxQ21MWlpoQnNSTm9LWko5ZlpIb2dZVTZDMzlRVDFxc0I2UGlO?=
 =?utf-8?B?Y2NjSUE3Mk1IWWtWU1Z5ZFFwNGF2M1dNK2VXTTMxRjlsRFloYVdpUjQ5Qzd1?=
 =?utf-8?Q?dOLlOo8hA5ttoYkAe2BPFOb3U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A4C5F076503274092157BA162AB80CC@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 146b1a40-8caa-4024-6f5e-08dc02603789
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 20:05:45.1276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWgbCCHOtngeKt5Oz06GYieVpEL7q2zi6nAB2xsikGfASkaIauiADr0Ch2rIeGkUotKntjUuaGKWuSVNjK0Hag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9244

T24gVGh1LCBEZWMgMjEsIDIwMjMgYXQgMDc6MDQ6MThQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBPbiBXZWQsIERlYyAyMCwgMjAyMyBhdCAwMTo1Nzo0MVBNICswMDAwLCBBbHZp
biDFoGlwcmFnYSB3cm90ZToNCj4gPiBPbiBXZWQsIERlYyAyMCwgMjAyMyBhdCAwMToyNDoyNEFN
IC0wMzAwLCBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIHdyb3RlOg0KPiA+ID4gSXQgd2FzIG5l
dmVyIHVzZWQgYW5kIG5ldmVyIHJlZmVyZW5jZWQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEx1aXogQW5nZWxvIERhcm9zIGRlIEx1Y2EgPGx1aXpsdWNhQGdtYWlsLmNvbT4NCj4gPiA+
IFJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQo+ID4g
DQo+ID4gWW91IHNob3VsZCBhbHdheXMgcHV0IHlvdXIgU2lnbmVkLW9mZi1ieSBsYXN0IHdoZW4g
c2VuZGluZyBwYXRjaGVzLg0KPiANCj4gSSdtIG5vdCBzbyBzdXJlIGFib3V0IHRoYXQuDQo+IA0K
PiBXaGVuIHlvdSBzZW5kIGEgcGF0Y2gsIGl0IGdldHMgcmV2aWV3ZWQgYW5kIHRoZW4gYWNjZXB0
ZWQgYWxsIGluIHRoZQ0KPiBzYW1lIHZlcnNpb24sIHRoZSBSZXZpZXdlZC1ieSB0YWcgd2lsbCBi
ZSBhZnRlciB5b3VyIHNpZ24gb2ZmLiBJdCBtYWtlcw0KPiBtb3JlIHNlbnNlIHRvIG1lIHRoYXQg
aWYgeW91IHNlbmQgYSBwYXRjaCB3aXRoIGEgcmV2aWV3IHRhZyBjYXJyaWVkDQo+IG92ZXIsIHlv
dSBwdXQgaXQgaW4gdGhlIHNhbWUgcGxhY2Ugd2hlcmUgaXQgd291bGQgc2l0IGlmIGl0IHdhcyBy
ZWNlaXZlZA0KPiBvbiB0aGUgZmluYWwgcGF0Y2ggdmVyc2lvbi4gSWRrLCBub3QgdG9vIGJpZyBv
ZiBhIGRlYWwuDQoNCkl0J3Mgd2hhdCBJIHNlZSBtb3N0IG9mIHRoZSB0aW1lLCBhbmQgQW5kcmV3
IHJlY2VudGx5IHBvaW50ZWQgb3V0IHRoZQ0Kc2FtZSBbMV0uIFN0aWxsIHRoZXJlIGRvZXMgbm90
IHNlZW0gdG8gYmUgYSBjb25zZW5zdXMuLi4gWzJdIFszXSBbNF0NCg0KQnV0IHllYSwgbm90IGEg
YmlnIGRlYWwhDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvOGQyZGQ5NWItMTNm
Ny00MWQ4LTk5N2YtZDVjMjk1M2RjYjA2QGx1bm4uY2gvDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjAwNDA4MDczNjAzLkdBOTQ4QGdlcmhvbGQubmV0Lw0KWzNdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDE5MDYyNzA4MzQ0My40ZjQ5MThhN0Bsd24ubmV0Lw0KWzRd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC84N2E3enpkNDdxLmZzZkBpbnRlbC5jb20v

