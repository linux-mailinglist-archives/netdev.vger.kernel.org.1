Return-Path: <netdev+bounces-50155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7B7F4BBF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B061C2095B
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109827468;
	Wed, 22 Nov 2023 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=esdhannover.onmicrosoft.com header.i=@esdhannover.onmicrosoft.com header.b="bNFJ/vVm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2133.outbound.protection.outlook.com [40.107.21.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3AD109;
	Wed, 22 Nov 2023 07:57:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL7G69dX6MOEZ22lB/gmMsKGgfGiyDbQBkiCI1YBq99HrBGf0s6u+54Td9McmrZWoapeun4F1Z/DkOT6EdDmGk8BaOJdB2tMjFy/yyCzVEwcLkZeLOoPobIpGIqT346O2VG6q5nGuER9VUYNv1bJVOwKAVwmGbr1PJ5HYhLu0BspsNDFaBdWLBDfMFUI48sxaBdKqCzt80t1QkY77n5J+Eofc8c4Ehs1hdun7FbbXq/UboDyEM3XLvvT46JwNEktdTv+cZcult6o7fTYk9E6U5o+7GUnvGxwn/1SgIfjr1+12zbt9NeUcLIeNfCREjRe5Wfb0cPm3thhH++42f7wwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H5Du1adJsDoququfbD0ymwMsWw0MT+iFvc1/KrUOes=;
 b=OQxq+hJQcBpnHnw+JS6x6qoGeiMOTLVrNMf0h0NpccAGXTOW2XrePLO64dUaGm4Vpi3Nw/+ftYAgQim7RHfodVYjiyVSdSMtktC++Pneeu2hj94jmb621D05CH44uWTAubfjlh45aLrhjeH8aiJ/joFZF59BcHDZPB9nV/ZbTCnv2H1F53DN2Ax78iARiWTgEWhnOstcbdK0HGBD5LCRdsWLO+9t7I+wMbLFN+7FRxNPcZqfZTOkXDBlqxKm5v+arcGrUdy2SLLZQEdW3hiEnI980YI+TycYWjgdBMxlQdyazgB9WVYS/2l3DwnNg8CEcO6fYnDGIuu68hp37tsDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esd.eu; dmarc=pass action=none header.from=esd.eu; dkim=pass
 header.d=esd.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=esdhannover.onmicrosoft.com; s=selector1-esdhannover-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H5Du1adJsDoququfbD0ymwMsWw0MT+iFvc1/KrUOes=;
 b=bNFJ/vVm+K22Etg1eiFq0kd+PqitMnxbwEECZNhGvZrKUBNmtStwfnu8iKeDnb/Ezcc2aJeZilhPd3Zsp5RMPr93yL/zAXCDHWukGkCEp2WwSIBhxYO+pOlTQbUxpNRvPHRWb+TjuRuO1MSJe7eAKKgZqVgjeMUB1PLBDhEdC94=
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com (2603:10a6:20b:3::16)
 by DBBPR03MB7065.eurprd03.prod.outlook.com (2603:10a6:10:1f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 15:57:27 +0000
Received: from AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::e4c5:63b9:dfd2:c12e]) by AM6PR03MB4296.eurprd03.prod.outlook.com
 ([fe80::e4c5:63b9:dfd2:c12e%6]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 15:57:27 +0000
From: =?utf-8?B?U3RlZmFuIE3DpHRqZQ==?= <Stefan.Maetje@esd.eu>
To: "vincent.mailhol@gmail.com" <vincent.mailhol@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com"
	<wg@grandegger.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject:
 =?utf-8?B?UmU6IFtQQVRDSCB2MTAgMS8yXSBNQUlOVEFJTkVSUzogYWRkIFN0ZWZhbiBN?=
 =?utf-8?B?w6R0amUgYXMgbWFpbnRhaW5lciBmb3IgdGhlIGVzZCBlbGVjdHJvbmljcyBH?=
 =?utf-8?Q?mbH_PCIe/402_CAN_drivers?=
Thread-Topic:
 =?utf-8?B?W1BBVENIIHYxMCAxLzJdIE1BSU5UQUlORVJTOiBhZGQgU3RlZmFuIE3DpHRq?=
 =?utf-8?B?ZSBhcyBtYWludGFpbmVyIGZvciB0aGUgZXNkIGVsZWN0cm9uaWNzIEdtYkgg?=
 =?utf-8?Q?PCIe/402_CAN_drivers?=
Thread-Index: AQHaG9sCMXhCEU847kOWn02IQavG47CE380AgAGhq4A=
Date: Wed, 22 Nov 2023 15:57:27 +0000
Message-ID: <3148df93275530977d74a51aeda0c3bf59b71625.camel@esd.eu>
References: <20231120175657.4070921-1-stefan.maetje@esd.eu>
	 <20231120175657.4070921-2-stefan.maetje@esd.eu>
	 <CAMZ6RqKBDfX3qnJ8pMnQ55JFDFgGCQEQhNVGPXJKiGNvvBWXdQ@mail.gmail.com>
In-Reply-To:
 <CAMZ6RqKBDfX3qnJ8pMnQ55JFDFgGCQEQhNVGPXJKiGNvvBWXdQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esd.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB4296:EE_|DBBPR03MB7065:EE_
x-ms-office365-filtering-correlation-id: 957319fa-fda8-4f3c-47d0-08dbeb73b9fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3kebE3NVWFz1BVKQmUSrhc4k/Tv69OBvEgCeh5iw4YHTZpv+WSwkR6wVtMtEakuGcOwoWN1ryUjk5npgDtC3C49gaIKYrb7lGLCjs8lMpeHgUhWn9bcB3X7ygR8L4M+9DQHuwfkSf+NKqsY/sgbOMqgTGCfrjieeKEAucVVL7ZRHkDMRczdkiJXmkU8tQXPTYzIVG14z1LVuWR4re+gc/ggzjX/x4Is88IFsiozgjReXgzvQD3nuWZWuADLiI+z5EQS0N3DspncPC5aA0nIQ8lW0bGYvSjVb4aypn9AMfMMI3hMe0ZOI0BCrzDN5CR2IeDNtq8gMaD6hJMSpzpOaxIriAIo4BqOKKgrmeMxoHaffmDp93p2PLf8qiXC+sf+JH3aNHAqqiq0VeDG9rhJ6vHz55z40jxsBanmMRJveVpX+ZptitBCbIK/omF6VBlvLlbADeLcO/uRIfceb+ik3cPQH9uKCDDEkK881ff61Y4dViQemsbYbBIMtEiCrtwPi0bxwgPW4adUjqY/XJALyqVMNUj5EpWbnr9w9fUrICoPWl6Vb46kpVO0YGUuJ78MPDRWvwTxTZ0zVBaGPVzNSwdxntSYqPwQoY7PV8scchq7pCuISiBAbIicEdzXlk32cxJb8UuzFytNIa2yTeUEMcQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB4296.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4326008)(71200400001)(6512007)(6506007)(26005)(6916009)(316002)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(54906003)(91956017)(86362001)(6486002)(478600001)(36756003)(85182001)(66574015)(83380400001)(38100700002)(122000001)(85202003)(2616005)(8936002)(38070700009)(224303003)(2906002)(41300700001)(7416002)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWdDQ0dtMHkyK2ZEb0l3cytPKzk1V0xReDBoNG44eTBMOG9kc3VHeW4vV1h0?=
 =?utf-8?B?T0NRanRsZlpjQ2pTbmV6WXFTTGN3b29EeVQ3NzJJOHlRY3cxWWo3OUwraDBJ?=
 =?utf-8?B?MGphWVI2aWZIRm11bjIzNkpFeGVMQmRiN1F1bTJGSlcrbzRIZGw1QldsU3FD?=
 =?utf-8?B?ZlFHTncrVW1DUGVnNzMxenFYdDBvMElUUnd6S0ozajJicVJEdER6RXd3bkg2?=
 =?utf-8?B?YnJ6Tmc5d0o4cTk5NENGazNwRVBOa0t4eVluZEtwdGNDTi8yTFlpR3ZyTzll?=
 =?utf-8?B?YXRGRXFnVzR1RnpvTitIMzMrZ1RsbU1Ec25LalgzVGIwVDJKNVhod2szTzh1?=
 =?utf-8?B?bDhYQVg5by82S2h1OUdCZzlBK0t3Y0lmaEo5ZWYwTTBPYnE5VGVJc1R4akpr?=
 =?utf-8?B?NHJjNDZDR0NHSWNnK1hrZmcxTDFsblhRcXZ1SmFoMzhwVERwYUlMU0xNR1dq?=
 =?utf-8?B?akxtb1ljazZyNWlYcHNjUDhjTlVwZk4yOExKZG1vUzhLU21kaGlHL0J3OXlE?=
 =?utf-8?B?cVNJM3R6ZjY2aEdLUlRMZyt0OUZzOTAvZi9DQ1ppZEI3UTdjNTcvYjBLa09a?=
 =?utf-8?B?MlljMHRxcnBNR3dMSmdFSVZ6VEhnbDkzQUVlT1JRdUEyaS9uVnNuUVo4dWN5?=
 =?utf-8?B?a0RZcVRyalZaSFM0cmZFdWFva1lDdE84bE44UXJma2k5Y3ExYXYxSloxalJE?=
 =?utf-8?B?d2p0WGdGemhvV0NWbWZBUGlJNHk4WTB4ZUI4bXlhTjhHbk9qdGpicEVSVHRY?=
 =?utf-8?B?MFk3Y2hILzZBYUdqSjc1R0VpT2doM2RUQ3VEMW1MdFE1b2IycVhlaGQ3akYw?=
 =?utf-8?B?TWw2MEpaRjMzVGVUSDNyREYxUWx6bGpETEhoaWFYNWdvV3h4OTdkSk9ianpX?=
 =?utf-8?B?RXRaZXlPcVJvZUcxQ0hrQ3FKdlJaVEsyUWRGN0Fyd1cwaXJoclBJajhqUzFo?=
 =?utf-8?B?a1VHRWtUVnJ0TC9Fck5XMXdPT0h5WUkyemduVFlKL1hhd1ZkUE5xdjVlUlBq?=
 =?utf-8?B?MVVETi9KaE10MDRwSlppVjlKMExIcFdFRENkRDEzRWxKL1lvSTE0WTZPdm84?=
 =?utf-8?B?WFBLVTM3UWc2T1VlOTVlWldYNHp3MUh1WXhpNFlHc0lBckZocEF6KzlKcHJq?=
 =?utf-8?B?SWVYQmk2YzRFL3lwMmNLc2hYeHBITllUUTYwQkVCZnJGMDJNNkdpS1MwcVgw?=
 =?utf-8?B?M0FTcVBXb0FIL2NDbXAyVGw1aEJKcGZwUm4yeDZzMVppMkhSazJsSFh6UjVX?=
 =?utf-8?B?RDl2UU1nakI2ckNVMm5GQTFqS1FzeW0vN0RaMmVFbmdZVTBMMUFYemx3QmN0?=
 =?utf-8?B?N2pSSWV3VGFCYmRBZTcxMk1VKzYyZTJMSldTR0EyNUozY3ZvUXZNTGhkQXkx?=
 =?utf-8?B?V1lSL293VENNV2ZEV2ZsTzR0WDlRWGFBS2ZpNklTbmhJSE40SzY1blB2OVpN?=
 =?utf-8?B?ZlY0aEhGbnY1UXJ4UWc5RER2NFdFRlFvOFBkUDBkVU5yRE96aUpsTVFuSjdU?=
 =?utf-8?B?di94eFphRnhTTS9YK1VEdUw4c1BLUXBLVUZ3V2JkSzNuS0RYVk9uUEtWYmxN?=
 =?utf-8?B?VXV1blFCSDRPdUlVa0l6UTJYM1lDR0lZSVo2M0QvTkpSS05xRUZOR0g2ZWky?=
 =?utf-8?B?VDF6ZHVFM0dCcyt1VUtKYUxrN0FjYkhKL3FSR21qaUk3bk9PeFpWNEV3aXpz?=
 =?utf-8?B?OHVZRkhSTzBFN21McnF3QkZjMHVWc0U1YndSKzNqdW5QOTJoS1YxYWtVL2RT?=
 =?utf-8?B?YlpqT05FajI2ODR3TU1HMDdDYW1IZSttRThIM3E0ejBTNUlIWkxyUGNibDQ1?=
 =?utf-8?B?SDdxNVQvRDFYTTltQnQvdHNUaTE3MGJBWW5RRkxFMWhyQitWMVNuRkY2YWto?=
 =?utf-8?B?MnkvalJtMUoyYVZiS2h4RFErWG1mMnR0NEhTbEQ5TjQ2R2tTRmE1WlZKekF1?=
 =?utf-8?B?b3d4R2dzTW9KVGQ1Vzd2MGloWU5HUFFkMGlGZkxWNnd4VFhmcE5PN0dmTUY1?=
 =?utf-8?B?aVVxcnlZY2FhdE1PbkpwRGx4aktGUkNTTGFVTm9MWlJZYndPeDM4MXVHaXA4?=
 =?utf-8?B?U3dpKzNUbEovcHRIQmxkTnFOL3VMeXpOUlJSS2VHZHZDTzllSHJsbENsbFYz?=
 =?utf-8?B?SFc0TUVkc1ZuVDVHaGFIYWFJZzMweTBrbFNqUFlnS2gyTk9RdWtva2pocURX?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16864E9C9155B34FB2DCEFF9A6B4FFED@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esd.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB4296.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957319fa-fda8-4f3c-47d0-08dbeb73b9fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 15:57:27.6679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a9c3a1d-52db-4235-b74c-9fd851db2e6b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3MJtb2XufttRwiQNJBl90qeU7bbgiewVCIUYsHiIMt/DvfTdo0h0ifgpGPCpEGurRFccqpWQxvRsCzq9TFEDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7065

QW0gTWl0dHdvY2gsIGRlbiAyMi4xMS4yMDIzLCAwMDowMiArMDkwMCBzY2hyaWViIFZpbmNlbnQg
TWFpbGhvbDoNCj4gT24gVHVlLiAyMSBOb3YuIDIwMjMgYXQgMDI6NTcsIFN0ZWZhbiBNw6R0amUg
PHN0ZWZhbi5tYWV0amVAZXNkLmV1PiB3cm90ZToNCj4gPiBBZGRpbmcgbXlzZWxmIChTdGVmYW4g
TcOkdGplKSBhcyBhIG1haW50YWluZXIgZm9yIHRoZSB1cGNvbWluZyBkcml2ZXIgb2YNCj4gPiB0
aGUgUENJZS80MDIgaW50ZXJmYWNlIGNhcmQgZmFtaWx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbiBNw6R0amUgPHN0ZWZhbi5tYWV0amVAZXNkLmV1Pg0KPiA+IC0tLQ0KPiA+ICBN
QUlOVEFJTkVSUyB8IDcgKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4g
PiBpbmRleCAwMzAxMWQ3ZWUwODcuLjdkYjFiZDM5OTgyMiAxMDA2NDQNCj4gPiAtLS0gYS9NQUlO
VEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTc3NTMsNiArNzc1MywxMyBA
QCBMOiAgICAgICBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+ID4gIFM6ICAgICBNYWludGFp
bmVkDQo+ID4gIEY6ICAgICBkcml2ZXJzL25ldC9jYW4vdXNiL2VzZF91c2IuYw0KPiA+IA0KPiA+
ICtFU0QgQ0FOIE5FVFdPUksgRFJJVkVSUw0KPiA+ICtNOiAgICAgU3RlZmFuIE3DpHRqZSA8c3Rl
ZmFuLm1hZXRqZUBlc2QuZXU+DQo+ID4gK1I6ICAgICBzb2NrZXRjYW5AZXNkLmV1DQo+ID4gK0w6
ICAgICBsaW51eC1jYW5Admdlci5rZXJuZWwub3JnDQo+ID4gK1M6ICAgICBNYWludGFpbmVkDQo+
ID4gK0Y6ICAgICBkcml2ZXJzL25ldC9jYW4vZXNkLw0KPiANCj4gVGhlIE1BSU5UQUlORVJTIGZp
bGUgc2hvdWxkIGJlIGtlcHQgaW4gYWxwaGFiZXRpY2FsIG9yZGVyLg0KPiANCj4gU28sIG1heWJl
DQo+IA0KPiAgIEVTRCBDQU4gTkVUV09SSyBEUklWRVJTDQo+IA0KPiBnb2VzIGJlZm9yZQ0KPiAN
Cj4gICBFU0QgQ0FOL1VTQiBEUklWRVJTDQo+IA0KPiA/DQoNCkknbGwgY2hhbmdlIHRoZSBvcmRl
ci4NCg0KPiANCj4gDQo+IEF0IGxlYXN0LCBsb29raW5nIGF0IHRoZSBleGlzdGluZywNCj4gDQo+
ICAgQVJNIFNVQi1BUkNISVRFQ1RVUkVTDQo+IA0KPiBpcyBiZWZvcmU6DQo+IA0KPiAgIEFSTS9B
Q1RJT05TIFNFTUkgQVJDSElURUNUVVJFDQo+IA0KPiANCj4gPiAgRVQxMzFYIE5FVFdPUksgRFJJ
VkVSDQo+ID4gIE06ICAgICBNYXJrIEVpbm9uIDxtYXJrLmVpbm9uQGdtYWlsLmNvbT4NCj4gPiAg
UzogICAgIE9kZCBGaXhlcw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4gDQo+ID4gDQo=

