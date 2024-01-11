Return-Path: <netdev+bounces-63006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B57382AB9F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06910284B0B
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7000E12E4D;
	Thu, 11 Jan 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="E5zvBiwo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2132.outbound.protection.outlook.com [40.107.22.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38D112E47
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk7VrDOh+Ik3x+tkcSp8GSVhkek7TeL4ManktbLsBz5p/1DR2XF9LZuueoGaTac0ooKpzVefoUEchswVoLkFehzTc9VSn5FiApCaCewQUmU9rGrlfquDQil36aYK0K/h2SO65cAVYqVUmfaj8AxCMMugng6x5t4za+vbLlvBx/Nt8z49Ugwwe4f2Wot/avZmTONMMQIu8LCNSxbt2qPbNllEEcfYCtFgxFT9SzvWfTVPht+IWiGVl7fB0JdK3EGcgJazSro8gmuchyE/eCBFLalWX+w+BRLz3CuUvdek/FxZRAx0i8WiPHlscr2eSvjVS3YVn1iDjVHHaTNZJgB2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIZeL6w27PpD475dhRiPo+Jj8A9aQl2ptNuEtiCPKqE=;
 b=aQ/LdCsUBYoV8szehOeaFO8CqatgvuwmJWI8VfGe72vkBvLuQOPtScoNyJuSRimBBOKglcctgSGX3u82UxR6/dwdYmlz514xUqVdjUdqxRbISPlnzjnwivY4998SaxA4Qa+QqxxfrEEy28ALrJ0xbzdi54ijGupEX4/CA8fkBDFYqHSCYY3h8/FVwjuct/Uk/7Jsp5Dj5nZQDSbyPx7hhI4RJtZEyCKhtozuAHtREOiIZ5rO0ZH7IyCq+Yb2I4GIfeNYfh6RrMDrn9hsEMB4+XFOEvnx0VnPWGSUyJolagtiUZ3x5TazWeYe1GC2ahGwS9aZfvmP/4SO7Mb/mVrWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIZeL6w27PpD475dhRiPo+Jj8A9aQl2ptNuEtiCPKqE=;
 b=E5zvBiwoghUtPZFaeSdD4YVKa9gd1kmS6vcvckRszjE0ooEutzgYf610TeEUYoD1eLA6iUJYMD1Ib5jayflCkYEp3Vb3hp41sk+T8nySeABa0nNq8/TWpE4Fpp/46fXP3153h2XgI8wn+UfyQceyNl7lYx2mRqcJsWrT/cL4zHU=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by PAWPR03MB8938.eurprd03.prod.outlook.com (2603:10a6:102:332::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 10:10:02 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 10:10:02 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Luiz Angelo Daros de Luca <luizluca@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Thread-Topic: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Thread-Index:
 AQHaNTqA0Se1IIgegU2kXD4cSV+b/LDQC4iXgAD88ICAAH4lAIACu2IAgAA4VgCAAAfjgA==
Date: Thu, 11 Jan 2024 10:10:01 +0000
Message-ID: <6yrgcvazqnv64zamxglr2wlok2hdjavea6qzlwh4ccx3ip5n4z@shj3kh7c67bk>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20240108140002.wpf6zj7qv2ftx476@skbuf>
 <CAJq09z6g+qTbzzaFAy94aV6HuESAeb4aLOUHWdUkOB4+xR_vDg@mail.gmail.com>
 <20240109123658.vqftnqsxyd64ik52@skbuf>
 <CAJq09z6JF0K==fO53RcimoRgujHjEkvmDKWGK3pYQAig58j__g@mail.gmail.com>
 <20240111094148.jltccq4r6b42wbgq@skbuf>
In-Reply-To: <20240111094148.jltccq4r6b42wbgq@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|PAWPR03MB8938:EE_
x-ms-office365-filtering-correlation-id: e582cac0-c805-4609-5dc4-08dc128d79a1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U9t0si8vBSedmyILeAuaikH/MMG3fe+xATAe8XQmSmIoSnjRH6/S0owPV6XALhuwM1H807B0dYgIMJI+/7XMBreY9/9C16l8By0o/hlCDMh3guOPUAGswJTO//JesgjhU6JSeOR3a4Gi29LlMS1L9LITSjn9u69itHewhQPQGuiYhmXAcF7qxhL/p0yDpUJzv+tDtnj8h8ckZWLjACAF5VW5WXvldVFRQgYtSywMhLS+noR/UES9QwjnKkwsUY+A25DLn4bBfp/VmM3qdJjIS5d0erb/drA+Vcm/4BS5QW+kdpLeknmMtFf1DLYzcEKUsLbXUXiLMRtYypTeqITt80CQ03TR9Kz+xCWfEODDAPTpO2XKMnuuXCwy0ihoIGcA3JOeHhQw5afkikdHkof8wNUEvxVIcAhSsW4Ay9aocEYFG4SYemj8SMpdNAYAN6yqYYqPBtVPlLlx2Sn25fenO6aVdCGJHKkcJlFTNdpskONinIubj0RNyOpBXXaGd0ium3aD225rEdO844x12FrmMOiizw5vQjgyIsz1QuUZy7qt3zJBlCkYXFPDguAZ832oXEAbUjIWO2egQgYPsP/I8W115cl81ToKyHVXGID6Nh93/2ZPjNG6ZlDsWchGBEO3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39850400004)(346002)(396003)(376002)(1800799012)(64100799003)(186009)(451199024)(86362001)(38070700009)(85182001)(85202003)(33716001)(8676002)(4326008)(71200400001)(83380400001)(122000001)(26005)(38100700002)(9686003)(6506007)(6512007)(64756008)(6486002)(6916009)(478600001)(76116006)(66946007)(91956017)(66556008)(316002)(54906003)(66446008)(66476007)(5660300002)(8936002)(4744005)(2906002)(41300700001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmpuNkdrdzFhOWpnOGRzVkpkTUF3NURmVDJqSFJ3TEYyUFhIZE9aQktNMDR2?=
 =?utf-8?B?NFZlNDZwaEJ5QVNSVGo1eWpjcUF6aU4xZmEvc3NleGk4R2swV2hoRm5ybEZM?=
 =?utf-8?B?VmNNN0ZGUHEvUmw5bzZNanA4ejI2azE1RWI5Z2dnNS9WWnNReEJTZ0REUjcx?=
 =?utf-8?B?b2VuZHhSMmZEVTMxK094SldNWGRlVFpRdnJNT2hMV3RnQWQrVHg3WVA2UGFG?=
 =?utf-8?B?OXhid1R3RWw4VnJ3eGRsS2thQndNc1pwTDY5dDFTUEh6SDByalBaOTZ3b1Ru?=
 =?utf-8?B?dENNTCswWVk1ajBBYjZTcEJYczNnZzJrQ1ZHN0Qvd0JZcHAzUTEyM0xkeXUy?=
 =?utf-8?B?UDZxT3c3VGJzUFZQZHFvV05wNXRRMTJWMStvNWRGVFl0VC8vTmpsVGd6dURs?=
 =?utf-8?B?ajdlY1lyYlZtSmNOaGlURnFDblgyVXZMb1Q2cDFBdW1nQ2lMUmpXK2x4djUr?=
 =?utf-8?B?c3M0ZGI2WVFCdTRWSlQzVlp6OXFPT1JsS0YzK2RrTEJ3a0IySUFKd2IxUUdq?=
 =?utf-8?B?TXJCKzdHTExDTXd3cDhuQ2NyK0Q2TTRSSWFzcFk2WnRSVVZHYUVHYUVFa2lF?=
 =?utf-8?B?cUNPenJQcktYL3dCWnk3dm83ZS9qbTFXRG5iNDd1elVTOGg3VDQ4MUQ2WVd1?=
 =?utf-8?B?YTRyNGdXZDRyYUk0WGVBUFNVSXlxNnJFVkJ3MFlDbVlTWnZkRVVzY0o1MFow?=
 =?utf-8?B?RFAwTFRqRDNubU9pa241TEt1ZUM5UGJnVXpWK0U0SDlSNU9ZcDJ6STB6Vjk0?=
 =?utf-8?B?Rms5NDNoUWNPK3R0L24yVUVGNTYzNzhEb3k2TG8wQXZvak80bW9LRisrS2o3?=
 =?utf-8?B?OWNITVFRa21uVXVseUlOaDRLVHZGbHlNOGltOFU1TGtjMnd0NmJmeVVQWDF0?=
 =?utf-8?B?cjFqUzRIRTRLVXlhcTk3Z3RYanZMY29KWEJ4M29ibWVpWmZkOUYwT2FEQWRY?=
 =?utf-8?B?Y2t5c3NNSW81SXZFT3NSTVhQUERxaHRyRmZmemhqM0xkRE0wbWZUTjZsakJm?=
 =?utf-8?B?WkQ3S0NZekNyVDUxUjdEU21wTmhBcFhCUzk2RE5KUGhZNEgxRHNCeFB3OTZZ?=
 =?utf-8?B?eWorcGFWSjVIejd4cGZRaGFvMEdnNjNkaEYxeHNTYS9mRS9jeFdER0h3TE11?=
 =?utf-8?B?Wk1FYWtKUC9JNklpVG9sd2lkN054VWd5RGhKRy9JSzlLQWZQNHR0QTdjUkVY?=
 =?utf-8?B?VERNcndXV0l6MGpsRkpxc1ZFUG5BdXBNNWNybm5LOGVMa2ZoaExac05uelpO?=
 =?utf-8?B?MDFQNDhsbFNmT3V3UFVoTFBzOGwrUTB2OE0zQ1hvS1Z2ek9ESWYvNG9NUjFt?=
 =?utf-8?B?dXJwSU02NU9DQmJKWGhhWFF2TU1ielZMV3JuTUsxTUxqZEYvYVliM2hiSXAr?=
 =?utf-8?B?RG5ZM0sycENKa1VHQWU5S3RnNzIrSWtZZW4zYXdyTnhub213THB5bk8yM3Vh?=
 =?utf-8?B?M2pSd1pOMHNkQmphZ2F0MGJEUjlzT3I4eFQ0QktLSTc0YWFFc3A2cjF2YkJz?=
 =?utf-8?B?dkg4Slo4UHB0N1N0eTRsRmJDTi9GM1lHbTdXUWRGNFBRRW14SktHdTRNZUdP?=
 =?utf-8?B?NnpoMzFWREdTbjIySnpuNkw2UCtkc0JaZTRhSEZOME5xd1pmNG5rZFNONmxG?=
 =?utf-8?B?K0daZDVkVTdXM3p3SHdTbDJaRStYSDBPMEQ0UVI1U1Z3OEpOLzNZUlBoeEtT?=
 =?utf-8?B?cE1UV0lUZjlFRDBXc2tJdG1WTGZNV3hvNUljNzBjMjdNeTZXODljZGR5Wkta?=
 =?utf-8?B?ekp4Zy8wRHA2MUZ3cDdySkhGMVFhMkQzWkdmelM5SUc5R3Z6MHBhWGNnZ3lW?=
 =?utf-8?B?c3lNd3I4R3FzRWpVZklTdEJrL0UvRXU3Y1prQ2loci8zajVJSmNTMjlmMWZD?=
 =?utf-8?B?U0t4L01CVUNIQUZEK3BvKzhCaEJBajlacDVMSndTNGFSWUhoUG9vM3RpNW1z?=
 =?utf-8?B?cEhIRG5RWkR4Q2JuWlpqc1dPdXZUSDB5TU5Rb2d3cFl3eGNPSDZaMHRHV0tW?=
 =?utf-8?B?UW9YYUJMV0lOSmlMek5XSndYR3htZXE5V09OWlVnZ212cHVaMjV2TlR4S0Fp?=
 =?utf-8?B?MXEwWWsvSGp4Y2daRzNybUo4OWllcnRXTHk5R3FjeHNwUVJ3WS9yZGI2WFFR?=
 =?utf-8?Q?i64qJrmlrFAbILpcwXzLynBSk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6F47F1037B7849A140F2F56294C14A@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e582cac0-c805-4609-5dc4-08dc128d79a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 10:10:01.9989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QxdigfStyLFjrRLV0Ghmmg9jTMzQnSRm3tCHVtyJ4/Z4KCWMfp7sTSolkPHJsdGIhF0TbM34LFKvoz3WPdPiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB8938

T24gVGh1LCBKYW4gMTEsIDIwMjQgYXQgMTE6NDE6NDhBTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcmVhbHRlay1j
b21tb24uaCBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3JlYWx0ZWstY29tbW9uLmgNCj4gaW5k
ZXggNTE4ZDA5MWZmNDk2Li43MWZjNDNkOGQ5MGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2RzYS9yZWFsdGVrL3JlYWx0ZWstY29tbW9uLmgNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL3Jl
YWx0ZWsvcmVhbHRlay1jb21tb24uaA0KPiBAQCAtNSwxMSArNSwxNiBAQA0KPiAgDQo+ICAjaW5j
bHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ICANCj4gK3N0cnVjdCByZWFsdGVrX2NvbW1vbl9pbmZv
IHsNCj4gKwlpbnQgKCpyZWdfcmVhZCkodm9pZCAqY3R4LCB1MzIgcmVnLCB1MzIgKnZhbCk7DQo+
ICsJaW50ICgqcmVnX3dyaXRlKSh2b2lkICpjdHgsIHUzMiByZWcsIHUzMiB2YWwpOw0KPiArfTsN
Cj4gKw0KDQpZZXMsIHRoaXMgaXMgZ29vZC4gTWFrZXMgaXQgZWFzaWVyIHRvIGV4cGFuZCBsYXRl
ciBpZiBuZWNlc3NhcnksIHRvby4NCg0KPiAgdm9pZCByZWFsdGVrX2NvbW1vbl9sb2NrKHZvaWQg
KmN0eCk7DQo+ICB2b2lkIHJlYWx0ZWtfY29tbW9uX3VubG9jayh2b2lkICpjdHgpOw0KPiAgc3Ry
dWN0IHJlYWx0ZWtfcHJpdiAqDQo+IC1yZWFsdGVrX2NvbW1vbl9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHN0cnVjdCByZWdtYXBfY29uZmlnIHJjLA0KPiAtCQkgICAgIHN0cnVjdCByZWdtYXBf
Y29uZmlnIHJjX25vbG9jayk7DQo+ICtyZWFsdGVrX2NvbW1vbl9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkZXYsDQo+ICsJCSAgICAgY29uc3Qgc3RydWN0IHJlYWx0ZWtfY29tbW9uX2luZm8gKmluZm8p
Ow0KPiAgaW50IHJlYWx0ZWtfY29tbW9uX3JlZ2lzdGVyX3N3aXRjaChzdHJ1Y3QgcmVhbHRla19w
cml2ICpwcml2KTsNCj4gIHZvaWQgcmVhbHRla19jb21tb25fcmVtb3ZlKHN0cnVjdCByZWFsdGVr
X3ByaXYgKnByaXYpOw==

