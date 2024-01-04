Return-Path: <netdev+bounces-61590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DE5824575
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1267281E3A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6DC249F0;
	Thu,  4 Jan 2024 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="HYoxy2NX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2117.outbound.protection.outlook.com [40.107.104.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85C249E4
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7BUEL2yNZewNm7ae94tIlPZlDwpVmdf2SpFNcTfWLiAlTfj+T5xx8Ps4pxjGksSJ8fHwVltf55LbYks4XYceDLXTjhXngOoPRSKxerQdKjx6VIUkzTdF2T6iWbe8HWMbgrib9evykpW2NuAyp6o19adk7kfCMcoNoETf13hDGsQ3Ztei8lZXh7zpzd5pxOBVPvG9pLALimY6YUFn8e2lbLeUSTia3K3GjMeyNAKGV2Tr4IahbE8W1pF07wHP5YL36+TneEbT9yOPB8TEO3/waBlRenVpf9SDhRSNg6TbVwdI8fDzwojHVhQRQGopSWv84M+o2posZBVL0q6VrmxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC+mYYeoYVONaK4Ywwv2kgB+cAszLoWo8/Rq8iRgnHQ=;
 b=jCk7X5ArzKGQo35UQVuj0/O/8VZ4s696zcz3bG/QmvjcZsdUjZAbPHTDKGaDyQOvZDjV900FHTCM/flEOjJnjCjHThXFp20JKLlAiTUILBllmO2tfMwNuxazNAIuLygRuVfS7mP02nDDMIM18KtDKe9f1ljdeBF7o5IrPEOjRAFc1vI37ElCpbTH+mr4LvIjNzrQ47+pMNkFfeWhdBdeFF1Aj2sxzPZQQGiKqdphMN++IeqkUet+2QuHNym6JxEnBVCQFhDDy5xyimj8KMf+/13lrBFJEztJEe9CAXiO5L48YRkdxkRDkYLU5wDC1iqATAzfIA+qtWsgisWJ6blj5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC+mYYeoYVONaK4Ywwv2kgB+cAszLoWo8/Rq8iRgnHQ=;
 b=HYoxy2NXtyjfztRkVBd2Gf59tWdpMfhh1dpouztLCyXkqPoHIGXoyazylG0H/ON3G8m6xws12l80THPTQ852DxJ4JVpYwEezGrsiwMPszuTlE+WHyGAnlXQwr2EHjhObeoxsNFCb5OJ8vZqY29FpIExeyirv6EH9sVYLFZbytec=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB8422.eurprd03.prod.outlook.com (2603:10a6:10:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 15:53:46 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:53:45 +0000
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
Subject: Re: [PATCH net-next 03/10] net: dsa: lantiq_gswip: ignore MDIO buses
 disabled in OF
Thread-Topic: [PATCH net-next 03/10] net: dsa: lantiq_gswip: ignore MDIO buses
 disabled in OF
Thread-Index: AQHaPxZ/laGpTIHq3E6nNlarYMtDa7DJzjiA
Date: Thu, 4 Jan 2024 15:53:45 +0000
Message-ID: <kp4dewbtnnzxxxletk26v5tfxuupkr3atjx3xul4q53nyl3h35@cr76dd4ld5nc>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-4-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-4-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB8422:EE_
x-ms-office365-filtering-correlation-id: 7d636543-ed8a-455c-4ec6-08dc0d3d5592
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MxU8dsjTK3nDD1OOc8H3yyINZ0NCIPUkyMorkOz97c2wMozhez/DVTzN2io+90BEmMMBuJ5c+K1TuUkrYq0AEz89KWeOJenLjlX9FZDtEXxm5ADEdjF7vc2vyn/J1pPniz0iSS2YbAUZIKyn1SLYWdwzydp8SXKVRogyJw0r6mg61NJgI4GVmQxJx3gKwDASSIp0c01Lb7YSCSYTYWh0eqe19rleLyn5ire3gzbgaHYnn4BQ4In+lzCNr6+OszDBvvoXI3a+xh+EbqzsdGixnEklZIDnbcTV+ON9+tr4V4DV5mJ2tkG5vXRT4FfxthC7yGx2NMyR495LwSMAmllY7tJWOs/FnDKcmA4QFjQX+Bk1laUrDGXS9eM6t8FwDUBljVyz6onx9P6vbas0omSGlX2RlDB4/KjNHalwB49hhanJVl5sRcWbBKtzNAF8ZyaVwT+YBqi2Z86LoFSzOm+kpzxx48986Mx5PvnzIseA0Y5LiQVhYKf6YIyT6EeEdvHdwXNN2N1Oxb2O8b8ausqPCtIEi6bnzeHattfPgofGlLugRsg43dN2nJMYpcf2f1bqA+54uN+nAHkSjcVT80JnKrbsPWqQEP39Sc1OUTON53W0C12QoVqXzB8/NSSkkCQO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(376002)(396003)(366004)(346002)(64100799003)(451199024)(1800799012)(186009)(85182001)(85202003)(6486002)(66476007)(91956017)(66946007)(66556008)(6506007)(64756008)(66446008)(76116006)(38070700009)(86362001)(9686003)(6916009)(6512007)(66574015)(38100700002)(83380400001)(26005)(122000001)(41300700001)(2906002)(4744005)(71200400001)(4326008)(478600001)(8936002)(54906003)(8676002)(5660300002)(316002)(33716001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFRSS2J6SWpyQldOWHZ5WkRwWHdUc0RlVEowZCs4b2hCSGZBbzdPanIxRG5k?=
 =?utf-8?B?YU4yZ1RtaHFHd2I4akk5VDJOSW5SNGtVdkNRVEhhZUNRNG1XTE9NV2gyczlK?=
 =?utf-8?B?dE0rVVZIMDBxVW8vN01XRSt5RHg5N3M4aEtRMWp1Z3V1M2JPSE9ocjU0bm9l?=
 =?utf-8?B?K1BQVXYzWklzeXNTWEU5Yk52NjV5YU9xNzBxNUZsUGxkbEpSakliOGxxbUxJ?=
 =?utf-8?B?eFpXa2JtYW5RVVZhK3RpSHgvc0J0UlgwblFHTlBabTB6QlphRXROY1NaUmgr?=
 =?utf-8?B?WTAzeFpPOVM0b3VHL3Y3STJsQUtsNERmcVBsZGM0WTBDZXJFVytQUE9LdlNT?=
 =?utf-8?B?ZzgzSUkxbEJsSEZtSHc4U1VibnliNzRIMzNzNVZDYnlQZkVlUHRqWTNQcE9L?=
 =?utf-8?B?OWJkZUptQjBTVFE0QXlmYUhXdjZlNFh6elpsbXdKNi94cHJyZEhMV25oKzRj?=
 =?utf-8?B?TDByS25IbXQwMXFrdWV6b3ZFVFlub1EzVGVQMk1Vejk1ZGVXYUpCMzZzcG00?=
 =?utf-8?B?eUpjNjBqOW5SMDFhYld6WXJQdlF5bCsrRG8rYlJxdnBZUXB6YklKQUpOOE1x?=
 =?utf-8?B?amZ4ejg1MUtoSG1oNmxudU5LOGJlaStQMHdiNjRCQXp3WHY3WGNPeWgvNGNQ?=
 =?utf-8?B?OUJFMHVURSsyRHgxdDlKN2U5YUhza2poMkZtdWVNOUs0S1RQTk5McmpYR3ha?=
 =?utf-8?B?b2NsOUN3Y1pNOUZQWXVXSGM3QVZkR1ZIVWh1Rks5TmNtWGJWS0NOUFg1TkN4?=
 =?utf-8?B?Mmd3V2ZSWWtlZDl2SEVCUFoxUVZYZ25wdUZabEJHQjlGZDdUMmFkN1pZQmV2?=
 =?utf-8?B?emR0UnFHb1lOc1E3ZDlqdCt0T2cybHhwSzRUbm91dTgrQ2plWElWbWh3bURC?=
 =?utf-8?B?Z2ZjMnZkSk52VlhiWENoQnNFZFJvR1N6QlEwdk9Iak1PQlRUbE9kWVpMeXM5?=
 =?utf-8?B?a0RYYXNDcHNIYmp5MjU5T0gyeHYxSkdaR2ZWK2V3eVdreXU4UmcvT1QzWm5G?=
 =?utf-8?B?V1l3SHhHZ0tDRXJLWDRIZlp3aVp2MVQ5UVBVYjdJd1FaTkxqMjNCWjlVWWJJ?=
 =?utf-8?B?OU5OUkE0QW4vOFBiWTJLNk9NQ1BvSkphUHZPVG9EZDRVclFNdjVBamdwL25a?=
 =?utf-8?B?ei9uYkcyZGFLZHRJTjExWm9pUldESGl0d0xCaU52QVMyUU96YmZOV3hKaG9t?=
 =?utf-8?B?anY0NnR2Y0dBUUt1dVVYRlovYlZwb3NJQ292Q2NXWUhQSklma2xzOVBQbWtY?=
 =?utf-8?B?VkJsNDFwdkxPa1NPZE9RZndGWUZLdUtOcHdyNUZaYzZvWHBXVEFlRDcyYjJF?=
 =?utf-8?B?TmtaTWUzNFNmVFdzVGcyTStWQ3dVSjcrYVg4dm52WDFQQjQzSVVuOGZYRmNV?=
 =?utf-8?B?ZW1LVVFseUxQNXQ1S2d6dFdYMXArME5xdGt2blg0T2xGMUZjd0p2N1FxMzVU?=
 =?utf-8?B?cEtpYzRUTjdsTll6UWpQZDlpaEU0NGZnTG5QZ2xjalJnM1lzZ3hUWktuSGd0?=
 =?utf-8?B?Q04xWjl6Njh2V3BSa252YWdwTDNMb2JUNHdxMkwrU1pWcE9XRXlzSEh2N0w5?=
 =?utf-8?B?K25VVUs1cWYzR0w2eGp2cUdkV0ZjTko4cFVTSXNPb2srSXZQTEZPWC9oc21q?=
 =?utf-8?B?MXFXQ050eUl0bDVCbDhxWFdkVFlkbTZLOVVtU0xocnBRVEZZSUtNMjZyci9Y?=
 =?utf-8?B?UnB5QlovdDF6bEhIMERuK2JkcTJVTnVQUFdLbU1DZjV6cUcwS2IyNkYvZjVF?=
 =?utf-8?B?WStKQ0QvV0ZneUI2by9DVGFSVVNEQ1l1aHJQUWpOc3krWnN5UUFMWW0zTW02?=
 =?utf-8?B?OGt0RVJsNktzRkR0aW1qQTV1ZTBnMEdyM2NXWDEyOWo5ajVmanVLdmh6WFpN?=
 =?utf-8?B?cWsxUENsYUkyU2NLYWkyM2FkWTJWVGNCdEpEc0dyeGM1MGJYT3JuaFRCcVVR?=
 =?utf-8?B?ak9JQ1p1Wlg2RWdPT2hrcGFCcHg0TTkrcmMwaURTdmZodTJtcVlYL0ROLzA1?=
 =?utf-8?B?R3RhTWl1SGwxMXhURFFGY0VZV21kdTNobS9Yd1FHdzN3WEh1TjNIak9wNmd3?=
 =?utf-8?B?MWZjZjNmMmhVNFNXbjJOYjFrT3hMTnFsRlZRc2hMemtJQTFCNGxWMWNMbURS?=
 =?utf-8?B?MS8wcW0vVXNrVy9aclh6M1NBT1RIZXZoMVBnTlJGeVFZd3BWb3VhVzJsUnNh?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9BAFB20F796D64CA0F5581F33895179@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d636543-ed8a-455c-4ec6-08dc0d3d5592
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:53:45.9142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMmtnm+c3l9zRwUeEPJ2EPbGKE9MhVFh32uooTl6zZY/Pj2C+CwtlHP3GuM9+MJikIjhy0oG09Vw+meV2cx4tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8422

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzBQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBJZiB0aGUgImxhbnRpcSx4cngyMDAtbWRpbyIgY2hpbGQgaGFzIHN0YXR1cyA9
ICJkaXNhYmxlZCIsIHRoZSBNRElPIGJ1cw0KPiBjcmVhdGlvbiBzaG91bGQgYmUgYXZvaWRlZC4g
VXNlIG9mX2RldmljZV9pc19hdmFpbGFibGUoKSB0byBjaGVjayBmb3INCj4gdGhhdCwgYW5kIHRh
a2UgYWR2YW50YWdlIG9mIDIgZmFjdHM6DQo+IA0KPiAtIG9mX2RldmljZV9pc19hdmFpbGFibGUo
TlVMTCkgcmV0dXJucyBmYWxzZQ0KPiAtIG9mX25vZGVfcHV0KE5VTEwpIGlzIGEgbm8tb3ANCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5j
b20+DQoNClJldmlld2VkLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+
DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC9kc2EvbGFudGlxX2dzd2lwLmMgfCA2ICsrKy0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSk=

