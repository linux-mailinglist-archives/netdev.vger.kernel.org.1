Return-Path: <netdev+bounces-61581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE80D824545
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642F71F22275
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4A3249E9;
	Thu,  4 Jan 2024 15:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="gq2Xvom8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2112.outbound.protection.outlook.com [40.107.7.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932FB24210
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kdr3HjUqRm0pjJg/BV6aRhV9jMs6XeLYwYmz8mX7xFpcrRPRqck6S9NnoX9ffJrrCpMJBjbz8aqJ8c9yDBDhMFP7bQAHKeXd6OrMiDvn8a8s0ydn5vnxg6Is+hXZwZLxsq9kKED9sMnq6mbD2tcLZIQeWfDgAtDPAcVDruAZtRdWf7+mKGsz+nk2Tn9E0tiY8fP+2XrYm9H7fUdhoYgiGgljJHwl/m37OTcTsguB6UGdfoeVYscQydRf4+o9eeYEg5voNHY8xTE9+ZXQP/kL2URhCRQYM5rCdY1UBINY17RhYPhXkmfGZU858YoW8Xj1nCD0l2Z3K7QbSQPjd0vv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhMo/2f5qRLU4clJXI/JC8v0xa0xSOBxj0Edwwf1Wsk=;
 b=eNlAZHOPFrVv/NdJhWbMny+XNd4HeGkFj5ccdokmdCTsOulnHduUSnt3r2UoWPBvfUbzObZhDDxA+CCgo6wzPSseyIHQeOGf0bfP2NmGyNlcrjKekTHvYaTdnNsRWc2Su4t+W+BtxrDzNWEq8wFXCdjyW0HIJkviNAIGMGKTk7nMk6KdHUK5pjeAt6Ls0iuxRUa0+6hqgVcuZcu8ztJIUXMLArc7nWKnBsCFDcXVp+4JwtCwTyhxSOUuR9edFV3VYgciGHEczoq/7VxDYRGH8DVhlBGiD0msWNc0Cpy7GpV81KPDLZgA6XkalQcHSvStLqu4PnUWNOOglnRBT/BaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhMo/2f5qRLU4clJXI/JC8v0xa0xSOBxj0Edwwf1Wsk=;
 b=gq2Xvom8u1TLOR/bwsGqDcnGVmysCRtFTDA0jCTorSmN+KPXMuUsihV6N49CHITE5bNDB2+3BDiz0Sahcg+kWC7YTNlagNa3z6ATn71Nonw55pJu6K1xo7IpYFKz8hOHhNLnqXHl+/HnZqk5Do8ADXZCSGW4+tB9Z7oU825ZXQA=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB7516.eurprd03.prod.outlook.com (2603:10a6:10:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 15:44:48 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:44:48 +0000
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
Subject: Re: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation if
 its OF node has status = "disabled"
Thread-Topic: [PATCH net-next 05/10] net: dsa: qca8k: skip MDIO bus creation
 if its OF node has status = "disabled"
Thread-Index: AQHaPxZ+Wr/T9RNNP0Kzcp2ZFGcdbLDJy7cA
Date: Thu, 4 Jan 2024 15:44:48 +0000
Message-ID: <ajlbpd63vpgkyvzflimq7qbzrdvgqizbg6qwj32qudd4ibgywm@ckdcvnsrm23u>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-6-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-6-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB7516:EE_
x-ms-office365-filtering-correlation-id: c3992ae3-44ae-437e-973c-08dc0d3c1541
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T6jljfgIhxRJ7loXW+IMkK3L/PwWxFQCM6UvuCk6gp+VNAf21Vs5lVgCNKyYSzCyzMMmPAbwGMq6/SeHwgC+Yc0EeiRxFSd3r5H5RyvxL4JcPB0/SXkf+a+T7nfk1JcCLHVIZtZZ+TfRrtues+yY3RNi1BRnSDTfUhiTwXvNDCUfb8Qd9lSka3NUi2jbGIAo5x2CWxbuxP43Z3AYHZMhCVZ/VIrQjy14J7Y3TI2RN8NGg+PQI6uqkSpDHaHenQzA1wEDllIy832eUzbXwK7olIHGERmjf4lPEbolHZVSEF5w2acj6R3pe8TDPAZqkf/0y9KJES1nC9ObpEeaBjYNEd2jE+cYcyOUQ9COsGCr0o6p1pCFlRBsv/El1TTM4SzDVFdz6WVYDq80HTP+N+Pv2jON3fkLQdAhlACCcxG6FuqTFZU71y+3FnVt3R/RfmDFc3FQ3nxbE9gWDrtKfNd1kUqB+DGHhQ3ceszpRaBrHUn7yZ4e1s3wLRiZO6m58dAtjYYdtbh3oJeW9BzMUgZ9B3WOhORtrrs7XqbuChZtg7SrZSlVklQbRR5vvi52lju5byXcbRj+o0a6OF9rySA1fF8rlXb4P9fBU1K2BwCmi28okbkiJ3B0LSVQYBt9F6IavR972QziEwx7clotK6Z1uw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39850400004)(346002)(136003)(366004)(396003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(2906002)(85202003)(33716001)(38070700009)(41300700001)(6506007)(6512007)(71200400001)(9686003)(478600001)(6486002)(83380400001)(38100700002)(8676002)(26005)(122000001)(8936002)(4326008)(54906003)(86362001)(85182001)(316002)(66556008)(66446008)(64756008)(66476007)(6916009)(91956017)(76116006)(66946007)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alo5YjZuczEyMzVFYzFkeHRMbU8rSWVGY1RqVDBnRG9JcHRnVGIxUFNaV0dq?=
 =?utf-8?B?M0p5OHQ3cmxSL2UxdmhzZktsR015aCtMYkFOOTJDQUducGt6SkNLWTZuODM2?=
 =?utf-8?B?MTk0NUd5UWtkUmF3VTl1aFZqL2NuZWxRMFhkMFlJc203Z0kvbTRGZHhpQ3pL?=
 =?utf-8?B?ZkNmQmVXSEhIdGltM01jNUtiRTlaa05iT05DUmZ3RlJETTdxUEUxNGZoRmVR?=
 =?utf-8?B?a0IyUk9LK0RhM3ViSlZsWHAwL1J1VndnT2pWYkZDOFdyMXRnemt2cXVwM0Ju?=
 =?utf-8?B?eHlpcjVGUVZhVS9rc2ZUN3BNWkhaNk1JUVdNeGt2K1Y0MmM3WWRJSkk5TDBp?=
 =?utf-8?B?RGpYL0I2c0k1UnREeWR6TUtRSUZVMUdhRmo5aEh0MnBLWnl6cnNRdHh0TVlC?=
 =?utf-8?B?aXhOUFhPQmxMK1JxS1BheS8wcWNhdUxBM3Z1MU1HSURSNnZwL2J2a1BjSmlv?=
 =?utf-8?B?UmZDdG9WMnl6TnoxUFRPK1A1enZsQXFGckxYemY0R3VWY0hyRDNBRzllNVRu?=
 =?utf-8?B?ZWRYUzA1MVhDYlBVejNlSmZPK015M2tMNXJ3M0I1NWdSSlFmcytxVFVHYWpy?=
 =?utf-8?B?Um16dU82NnptdVhKZURWNmUrcDNUbGpaVUFHaXpBRElBS29lWUZzRGRKVDQr?=
 =?utf-8?B?QVFIN2hxVzdpbUNnMWFoeVUzSENjbHc4MlNTcjNLWXBZb1BkRmlHRW9TSENo?=
 =?utf-8?B?aUZTWGxlMmJRQWF2QlFMOXlNRXRTSlNKTThoR0JQb2tPR2pocXZnNjM4ZWFE?=
 =?utf-8?B?cHNzUDRwUVlRbml6OVpIejlZYm1ubU9IVXlmZ21YNUV6K1RXakVJY0tEV1F4?=
 =?utf-8?B?Q3piRjZxc2wrWFpzQ25wanhVZWNGZ1pyTXlISzFnMWZjcXJyK01mbnB1N2xV?=
 =?utf-8?B?SVhVS1p2YTF2dEdEWjk1TFJjT1ZoSjJ4YVZYY0lWcFQrOEVEbFhwaXNsaHFV?=
 =?utf-8?B?S04vRVRnQjgrY1VkZFdQelQrcmJEdGcwRmRINUFCdGI0bHlIbGVNWk4yVFZu?=
 =?utf-8?B?QVF1UlRiaEdRSDV2T3R1R0ZRL1U4OWFkTFhSQ1loZS9JanJZWXZsQjN2eEsz?=
 =?utf-8?B?NThKSEZxY3Uvejk4VnR5YWNMY0puYmUxTXNteGpGcktDTlZTb014TGRUd0Rw?=
 =?utf-8?B?bUNaT2thbXpDdG1Vc0hENFBnTXpIS2dVRSs2VVpLUG1aZHdPTDhYeGRjZE5q?=
 =?utf-8?B?anhvOE5iQjR3WG1rRU1iNG81T0lBckRBVlVjZ0lIMklMV2loTGRLd1lHSTZ6?=
 =?utf-8?B?dlhjWForWWhlbVhoU3ZQSU1TaVF5SWhlOXFXSUlSL25JRVYxU1lNRTlsRWtC?=
 =?utf-8?B?M0k1ckxqZnlONW5ySjNPY3BzNHh1ZjA0cjM5TFZnRGFJSW4weFcyazZ4d0NF?=
 =?utf-8?B?LytWMjBDUTQya2Ria2FzODhmaHE0dDJsT1pQZ1JZaGNwaGljMHpsMm1FcVV4?=
 =?utf-8?B?VkdRZmJjRWFMOGx1WHZBWHFiNGo1VzRYZEV2ZzNwWks0cmNFWUFLY0cweHhY?=
 =?utf-8?B?M2ZKd08waFNNd0pDM25HVXNmNW5OTTUrRkltQ1JPMU5wbktaZ0IrL3M0S3l5?=
 =?utf-8?B?YjlERGx3UHFZYkxrRmh3UjhtYlg3Y3FKTk9qUzZEazRUV0RjOWdHa1Faa0hM?=
 =?utf-8?B?NzNrNS9EbHFwMGxyTHZrS3l3eDlndlcvQ3RwZUhyUXdVYTVIbkJ3SjBBYzBm?=
 =?utf-8?B?MHhRTGQ5V2podlMwYWlyQkhVL1hoZ0FWNGVSdVUrSmNFdENiS09DUUxBa1VD?=
 =?utf-8?B?WUM5NzdUb0dYdnFjTlhISXZZcmJIR2t1WTFNN2VuVEZEOUw0a2hEbEg3aVli?=
 =?utf-8?B?L1hDc1dCQmF1Tk82U2VHakpBcjVoWkxvY2E3NXZtZFFJWFBNTlM3UFN4cDF4?=
 =?utf-8?B?bTVXL1dmaGRHZ0I0dnRFbFhlMWQzdEpqSWVRNFIzcGFRYUE1M3RjZ0VTR3lp?=
 =?utf-8?B?MXdJdFJDMkhkMWFnaHo4T3oySXE1WWhObGpjd3A5ZjdVOG9pdVgvUHV2bTcw?=
 =?utf-8?B?aWdPdTVqMXdUcGZjMytINmU4azJrTERIcituaTVtamVEbGZLRUJjb1ptNEQ1?=
 =?utf-8?B?N1FxY3JBdElMNEM5UDFQaFF3Qms4NDhBaldYRWVkaTRvWWhjYVdnQXk1TUJG?=
 =?utf-8?B?R2t3YXN2Q29ZZHB2RjRYN3BKVnVXa1hKcDY3ck1tdVU5UmpxUFlyZjlyNEdY?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2070645B9D3CBD4FB7270517448DE329@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3992ae3-44ae-437e-973c-08dc0d3c1541
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:44:48.5009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKD3SMvKHx6EXSh5/kg+LaVBUrdtInBiRwAP5VieCxny0snP1ZnrS6fLDUqzhX8ujkG+pmEmtvcBL9HKi4Elwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7516

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MzJQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBDdXJyZW50bHkgdGhlIGRyaXZlciBjYWxscyB0aGUgbm9uLU9GIGRldm1fbWRp
b2J1c19yZWdpc3RlcigpIHJhdGhlcg0KPiB0aGFuIGRldm1fb2ZfbWRpb2J1c19yZWdpc3Rlcigp
IGZvciB0aGlzIGNhc2UsIGJ1dCBpdCBzZWVtcyB0byByYXRoZXINCj4gYmUgYSBjb25mdXNpbmcg
Y29pbmNpZGVuY2UsIGFuZCBub3QgYSByZWFsIHVzZSBjYXNlIHRoYXQgbmVlZHMgdG8gYmUNCj4g
c3VwcG9ydGVkLg0KDQpJIGFtIG5vdCByZWFsbHkgc3VyZSBhYm91dCB0aGUgdXNlIGNhc2UsIGJ1
dCBJIGFsd2F5cyB0aG91Z2h0IHRoYXQNCnN0YXR1cyA9ICJkaXNhYmxlZCIgc29ydCBvZiBmdW5j
dGlvbnMgdGhlIHNhbWUgYXMgaWYgdGhlIG5vZGUgd2VyZQ0Kc2ltcGx5IG5ldmVyIHNwZWNpZmll
ZC4gQnV0IHdpdGggeW91ciBjaGFuZ2UsIHRoZXJlIGlzIGEgYmVoYXZpb3VyYWwNCmRpZmZlcmVu
Y2UgYmV0d2VlbiB0aGVzZSB0d28gY2FzZXM6DQoNCiAgKGEpIG1kaW8gdW5zcGVjaWZpZWQgPT4g
cmVnaXN0ZXIgInFjYThrLWxlZ2FjeSB1c2VyIG1paSINCiAgKGIpIG1kaW8gc3BlY2lmaWVkLCBi
dXQgc3RhdHVzID0gImRpc2FibGVkIiA9PiBkb24ndCByZWdpc3RlciBhbnl0aGluZw0KDQpXYXMg
dGhpcyB5b3VyIGludGVudGlvbj8NCg0KPiANCj4gSWYgdGhlIGRldmljZSB0cmVlIHNheXMgc3Rh
dHVzID0gImRpc2FibGVkIiBmb3IgdGhlIE1ESU8gYnVzLCB3ZQ0KPiBzaG91bGRuJ3QgbmVlZCBh
biBNRElPIGJ1cyBhdCBhbGwuIEluc3RlYWQsIGp1c3QgZXhpdCBhcyBlYXJseSBhcw0KPiBwb3Nz
aWJsZSBhbmQgZG8gbm90IGNhbGwgYW55IE1ESU8gQVBJLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VmxhZGltaXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL25ldC9kc2EvcWNhL3FjYThrLTh4eHguYyB8IDggKysrKystLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay04eHh4LmMgYi9kcml2ZXJzL25ldC9kc2EvcWNhL3Fj
YThrLTh4eHguYw0KPiBpbmRleCA1ZjQ3YTI5MGJkNmUuLjIxZTM2YmMzYzAxNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvZHNhL3FjYS9xY2E4ay04eHh4LmMNCj4gKysrIGIvZHJpdmVycy9u
ZXQvZHNhL3FjYS9xY2E4ay04eHh4LmMNCj4gQEAgLTk0OSw5ICs5NDksMTEgQEAgcWNhOGtfbWRp
b19yZWdpc3RlcihzdHJ1Y3QgcWNhOGtfcHJpdiAqcHJpdikNCj4gIAlzdHJ1Y3QgZHNhX3N3aXRj
aCAqZHMgPSBwcml2LT5kczsNCj4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm1kaW87DQo+ICAJc3Ry
dWN0IG1paV9idXMgKmJ1czsNCj4gLQlpbnQgZXJyOw0KPiArCWludCBlcnIgPSAwOw0KPiAgDQo+
ICAJbWRpbyA9IG9mX2dldF9jaGlsZF9ieV9uYW1lKHByaXYtPmRldi0+b2Zfbm9kZSwgIm1kaW8i
KTsNCj4gKwlpZiAobWRpbyAmJiAhb2ZfZGV2aWNlX2lzX2F2YWlsYWJsZShtZGlvKSkNCj4gKwkJ
Z290byBvdXQ7DQo+ICANCj4gIAlidXMgPSBkZXZtX21kaW9idXNfYWxsb2MoZHMtPmRldik7DQo+
ICAJaWYgKCFidXMpIHsNCj4gQEAgLTk2Nyw3ICs5NjksNyBAQCBxY2E4a19tZGlvX3JlZ2lzdGVy
KHN0cnVjdCBxY2E4a19wcml2ICpwcml2KQ0KPiAgCWRzLT51c2VyX21paV9idXMgPSBidXM7DQo+
ICANCj4gIAkvKiBDaGVjayBpZiB0aGUgZGV2aWNldHJlZSBkZWNsYXJlIHRoZSBwb3J0OnBoeSBt
YXBwaW5nICovDQo+IC0JaWYgKG9mX2RldmljZV9pc19hdmFpbGFibGUobWRpbykpIHsNCj4gKwlp
ZiAobWRpbykgew0KPiAgCQlidXMtPm5hbWUgPSAicWNhOGsgdXNlciBtaWkiOw0KPiAgCQlidXMt
PnJlYWQgPSBxY2E4a19pbnRlcm5hbF9tZGlvX3JlYWQ7DQo+ICAJCWJ1cy0+d3JpdGUgPSBxY2E4
a19pbnRlcm5hbF9tZGlvX3dyaXRlOw0KPiBAQCAtOTg2LDcgKzk4OCw3IEBAIHFjYThrX21kaW9f
cmVnaXN0ZXIoc3RydWN0IHFjYThrX3ByaXYgKnByaXYpDQo+ICANCj4gIG91dF9wdXRfbm9kZToN
Cj4gIAlvZl9ub2RlX3B1dChtZGlvKTsNCj4gLQ0KPiArb3V0Og0KPiAgCXJldHVybiBlcnI7DQo+
ICB9DQo+ICANCj4gLS0gDQo+IDIuMzQuMQ0KPg==

