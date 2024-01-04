Return-Path: <netdev+bounces-61589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A29E824574
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1E12820EB
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499D249EB;
	Thu,  4 Jan 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="CDv1Hcfo"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2123.outbound.protection.outlook.com [40.107.6.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A6249E8
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb7PDjpo5heWYEBH8whhSl1DEbS6lmiuO//uMTitRugoVODZLVtVDNgqUy2LzCCNr70DiSJAz33IKRmXACkTr6H0ztwBbv3gHDY/p3zOeuTTdOLfxeNYEm2tkJvG74xuc2zR0HRknriw2byLVZb9fL7ffXAcZQCDVTA5Qs1DX3Ha0CsSwYMxQx03tZEtv9UZ+K4zBkDqaJBnks/asn6RzMUK3uc+lBILiCJIj2bq/EKUtmPBBA9MjKkUumB1APMZb9RqL+t0JPWvFMcqY/xClkDRoVDJkgIFWtxneujuX4RjbVvsFjGG5bEnx3yvJFFJkg7oWmv/1sEQ+gPuxPuIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ObKwqHQ3V8/GUtCdON7alfagMEbfOBPMMykSGmrAbI=;
 b=R84otul+krwwdPeN0+axi1kIs2hDHLQUgmn/9yEY9+NlWM4e6Jsq/xbmcrS9htnmIBZC+2GqMSok0PDDJet7pP/BFtsD9YONPyG6JmRvM3WdrmdQa5Kewvw+LcvWD9RJ49Fif8T6E3TYy7YSRG1f2ZE36kAnigTse+p+NRqbfLwdedk1r54x3QMEl4wULZwPKYDTq8I92rw5gNNBDQN4IhOysaZUdvBn3dNL7PvjyHdh8ZoZwPN/xJd3FKsnQmFHvJ6Yq0qepirXD6iWGF0US3CvAzMy+ymGq6h0VqzsfS+WtDiirSJzZdfOe/tDcPWS8c1dqmQqqhDt7Yb8ds2u5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ObKwqHQ3V8/GUtCdON7alfagMEbfOBPMMykSGmrAbI=;
 b=CDv1HcfoowmUe07NLThQ3uVC+zVvyy9cTuLAz9ZhlFhqrWsE+YfHCgoJ3ekdJsMAayEuV6bhZD4jgXl7MLNHJsS2xgAmYlzGfsTHXswUBXB+ab1E0dPE3aJPnA5ZB9n7LuPcGtT4PFoXEYGwycGZQ2TaF1VuM1JiVoPh6l0aZu0=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by DB9PR03MB8422.eurprd03.prod.outlook.com (2603:10a6:10:399::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 15:53:31 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::2293:b813:aa1a:a894%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 15:53:31 +0000
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
Subject: Re: [PATCH net-next 02/10] net: dsa: lantiq_gswip: use devres for
 internal MDIO bus, not ds->user_mii_bus
Thread-Topic: [PATCH net-next 02/10] net: dsa: lantiq_gswip: use devres for
 internal MDIO bus, not ds->user_mii_bus
Thread-Index: AQHaPxZ+B+axrluqDUWhJ2uJzKL9F7DJzieA
Date: Thu, 4 Jan 2024 15:53:31 +0000
Message-ID: <aarg4za7litq5wte75kjruhptiml6c6ecti43oicbeho7efoud@6to3rvxjs4rx>
References: <20240104140037.374166-1-vladimir.oltean@nxp.com>
 <20240104140037.374166-3-vladimir.oltean@nxp.com>
In-Reply-To: <20240104140037.374166-3-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|DB9PR03MB8422:EE_
x-ms-office365-filtering-correlation-id: cf3f3ede-36ff-4dc0-2685-08dc0d3d4cf0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fTFowgbB1ml6iPphZU6nAHfLSWF+jfxlvHW73qSDSbjUqjgbNl5lkqr3ksAZ3L43uyL64MDM54INB4gmgLnAzv8d5aNPCcXRTxACiedau6shAyWzram6x946P7Se/zBorqn9XvRWNPIiAirOFoYIs9IMTLga83bEM/aRyXRDUvwPkQPkGCgmW44YXt9DI2SA7DZ68F/wyuxZDHVUYjGw+JpQ+qv8tmHh7uiSn2OUvEuwT94fj5Q0GpPgvrlqb2gqwLLjO3AINGPn7PR4X1cWEbw6pyWYQIl3Ov0wGcT4dw1FqK1BNJUVoHShDHvf6mdLWfqGbPnBboZEVrn7XKbjvkdR7t8IJLlpEAZiHmv5YyW8HpMXcZxnCz5PSpZrsS8b8IFjneHAMMfnF7wDbvca/yYAGn8EXBvmqGngwHTq3OdXVX/nNsKkfAYmRKQowmDJvRzkwey/LAPJTLPrbC1EsKNaB1jJXHCmn6Zp8wjoErTnzQp+unPN7jgRebziwboCbWnN8mZ2gVuAp5qzm+DPIS27q6B8Y60qi22x2+5fZ3Pj6R7LinhNHL8BbDVaCFcEBeo/dsMry3n1QH9zbJDbkDLa8hxSrhJFCDrCU5SksUM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(136003)(376002)(396003)(366004)(346002)(64100799003)(451199024)(1800799012)(186009)(85182001)(85202003)(6486002)(66476007)(91956017)(66946007)(66556008)(6506007)(64756008)(66446008)(76116006)(38070700009)(86362001)(9686003)(6916009)(6512007)(66574015)(38100700002)(83380400001)(26005)(122000001)(41300700001)(2906002)(966005)(71200400001)(4326008)(478600001)(8936002)(54906003)(8676002)(5660300002)(316002)(33716001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alJXcThiUEFTZGVWUUlhUlN3cEo5c3FJQzNGRlV5K0NkYXJ2YmZ1L1BpZ2kx?=
 =?utf-8?B?aDB3NmF6c2N6Z2xoRUxIcWwrM001WEZETnkvWFd5cVAxZEhZT0JDL1QrYnYz?=
 =?utf-8?B?cUpmRjdPMnVWZnAvUHdsZS82NFVnb2FHNUkvYldkT1NLSkMxM3dtZEtYUEN3?=
 =?utf-8?B?VE51NEl2dTYrMmhMOUVSMWdDN3RpNW1oWFhEaHJWckZ5RFphd2ZCeXdxTUk5?=
 =?utf-8?B?UjBiWHJmL2poL2tyTDlZdW02elIyM0Z6cTFlcUl1ZkIzQ2hlMXVUbWRNVWpF?=
 =?utf-8?B?Mm1DZHlyWFQ3bzMwV2hqekNSSDQ0bXdkZElxMzRIZm45YS9KYTVyNW1rM0lH?=
 =?utf-8?B?cUtFdzdwaFk3bTJ0TG5lcEtHeE90S3JJdkVXL1FjNS8yU3NzeEFYeDU3a2NP?=
 =?utf-8?B?bVRoMm1QV1Rwc3p1c0J0TWZyZEt3UFUwZFoxSTJYQWVQRTdDam0zV3QwM3lO?=
 =?utf-8?B?ajNETzd2WEpoSXdsV0ppbk5XSmNKZVYzb1gxK0dUaGFNejZVNlFrTVpIZnFP?=
 =?utf-8?B?TWk1aUNJWHp6SkxJTGI1cFpPNUxPd2RiRXNzWGwrRlVXSld4T1lycVZ2ZHRq?=
 =?utf-8?B?REcyTTBWWStLQ2lYL043VjYyRGdJYXJaRG9oeVZzNG15WDNPUGpMWlRrVmls?=
 =?utf-8?B?N1VMYzlCMlNlTkl4WXBValN3S0dEU092RGZYK3J3MFZhMGpQNDB5Z1ZvTXBV?=
 =?utf-8?B?b0tOMlR0RytGbEI3Ry9LY0wreDk5ciszL2FXMmlMVDdlNW00cFdGT0hEN2ll?=
 =?utf-8?B?dHA2WkNWRUZxRHBhOUd5TGR0TkJibDd3VUszSjRLbVRDR0gxZzZIeDZ3TDNK?=
 =?utf-8?B?NFRkcWpaWTRaNXk4bHRuM0djamMxRXcyQXBCZkU3K2NnSkprcVdmaEU3aSt3?=
 =?utf-8?B?c2dSZGlzTVhvVDJsaFBUbXJUNlk4bGVwUWgxOGw4YllmWFpuaDA2bGpzY2hy?=
 =?utf-8?B?QnVJZDFLRStHSzVTdXN3SFdLY2NhOUNPVnh2UGlHZ0wrZ1kxVHZUdWh4WTJP?=
 =?utf-8?B?T2FqcG00VUhNakplUEM3Qmt0VjJuSEo4ZEIzYW9FQXhOLzEyQ3pnQlBQMDg1?=
 =?utf-8?B?Y21PWjVMQVU1aHhkcmZnRUJ0bEg2ZmhUTEcxa1RYQzdncS93TS8xYmgza3J4?=
 =?utf-8?B?c1ZGM0VndWRuYjNVUWtQNk9pQ2NmYTlUbEV0aStRTExJMWtYUlVNd3VnQ3hm?=
 =?utf-8?B?R1lIZWM5SHYrR3AwKzZHaStUcUppMFU2cUJrMkhveW5reUFOYTJTWVhKbHdV?=
 =?utf-8?B?Q1V6WS9aMGFmSFJSZUVLYzFKeVBNaFFSUkxVRnIzK0FLaStydUd6emQwS3o0?=
 =?utf-8?B?dTVMc1UwVVRtMldxTDZYTkIxUVBHSG9rTUx2alVHQW4vVllhSlhqYjNkOXYz?=
 =?utf-8?B?T1pLcUU1YXZKY2dBVjI0NXp4b001TzFIRHl2c1NVM3NCbktKeDRrOXEwOExr?=
 =?utf-8?B?ZWI5OHU4UmpLU2NzM0hPNmpnOGxGS2YyTys2NTlkMU1SckIxTE5vZkJFdFQ5?=
 =?utf-8?B?TDc2KzZzT1RRUm9MelNzNlBrdHVxWHRwcGx6dUNJQjBobTQ5UFNKWFlzSkpw?=
 =?utf-8?B?T013QllBRnJMbVhIOVNxT05wZmFleXZydFRweWdxNTFrbk5lS2lLWFdzQ0pz?=
 =?utf-8?B?UlA0QVNxSStXcm1YWC90WDh0UnFMUnZGWlBlQm5qQ3VUVkpQWmN3M3dzUXNv?=
 =?utf-8?B?QlpUVWhWU1pjaUpDVENGanpqazlROVErc2Uvc1l1aU9oUFpDSVV2SElyeTFM?=
 =?utf-8?B?MllWZTNSbEJLZWIwVUJBZTh3L21kZ2h0eWoxNkVYcmtOclBSdmcwZ24rRzVX?=
 =?utf-8?B?dml2dDNjc21KdjdabTUvQ05XR2Uwc0tQUTRXS0xQQWFpaWpCMWlaT1lKVnRy?=
 =?utf-8?B?NXUwY1NXMGFhSEIzWnczUUMvd215OVlobXUyVVFtdXVjUllMTHdkejFKekZH?=
 =?utf-8?B?UCsvQVoxeWlocTBJZWZEdS81L0hSSWxSQVE2YlpZV3pENzNYUE9ZNUEwVGpX?=
 =?utf-8?B?VVZZMjlGQmpZclowWDhyQ3VUd3AzUUZ6b2dubkVMWHF5ek5MSHo1eVpOZ281?=
 =?utf-8?B?UkdFemFsMCtmVUN6TWlsLzhnbFdSZVRBSWF5SVZ3RDBrUmJzNnRHeUVheGhm?=
 =?utf-8?B?VEg0aG45QkRTQ1hkZGlGZlhXSFlteEtxWXM3blI0bC90VUprRmdKV2wwb0VN?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDE7BE5E9E95034699550A081FC298BC@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3f3ede-36ff-4dc0-2685-08dc0d3d4cf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 15:53:31.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDbt7waKFaizVhdtHnOCtK71PwATSRCp8lmz2qu/CwHWN751LA28aXHS8tyjFvi27/oKGdxMbmX6wFYSPOZcXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8422

T24gVGh1LCBKYW4gMDQsIDIwMjQgYXQgMDQ6MDA6MjlQTSArMDIwMCwgVmxhZGltaXIgT2x0ZWFu
IHdyb3RlOg0KPiBUaGlzIGRyaXZlciBkb2VzIG5vdCBuZWVkIGFueSBvZiB0aGUgZnVuY3Rpb25h
bGl0aWVzIHRoYXQgbWFrZQ0KPiBkcy0+dXNlcl9taWlfYnVzIHNwZWNpYWwuIFRob3NlIHVzZSBj
YXNlcyBhcmUgbGlzdGVkIGhlcmU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8y
MDIzMTIyMTE3NDc0Ni5oeWxzbXIzZjdnNWJ5cnNpQHNrYnVmLw0KPiANCj4gSXQganVzdCBtYWtl
cyB1c2Ugb2YgZHMtPnVzZXJfbWlpX2J1cyBvbmx5IGFzIHN0b3JhZ2UgZm9yIGl0cyBvd24gTURJ
Tw0KPiBidXMsIHdoaWNoIG90aGVyd2lzZSBoYXMgbm8gY29ubmVjdGlvbiB0byB0aGUgZnJhbWV3
b3JrLiBUaGlzIGlzIGJlY2F1c2U6DQo+IA0KPiAtIHRoZSBnc3dpcCBkcml2ZXIgb25seSBwcm9i
ZXMgb24gT0Y6IGl0IGZhaWxzIGlmIG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgpDQo+ICAgcmV0
dXJucyBOVUxMDQo+IA0KPiAtIHdoZW4gdGhlIGNoaWxkIE9GIG5vZGUgb2YgdGhlIE1ESU8gYnVz
IGlzIGFic2VudCwgbm8gTURJTyBidXMgaXMNCj4gICByZWdpc3RlcmVkIGF0IGFsbCwgbm90IGV2
ZW4gYnkgdGhlIERTQSBmcmFtZXdvcmsuIEluIG9yZGVyIGZvciB0aGF0IHRvDQo+ICAgaGF2ZSBo
YXBwZW5lZCwgdGhlIGdzd2lwIGRyaXZlciB3b3VsZCBoYXZlIG5lZWRlZCB0byBwcm92aWRlDQo+
ICAgLT5waHlfcmVhZCgpIGFuZCAtPnBoeV93cml0ZSgpIGluIHN0cnVjdCBkc2Ffc3dpdGNoX29w
cywgd2hpY2ggaXQgZG9lcw0KPiAgIG5vdC4NCj4gDQo+IFdlIGNhbiBicmVhayB0aGUgY29ubmVj
dGlvbiBiZXR3ZWVuIHRoZSBnc3dpcCBkcml2ZXIgYW5kIHRoZSBEU0ENCj4gZnJhbWV3b3JrIGFu
ZCBzdGlsbCBwcmVzZXJ2ZSB0aGUgc2FtZSBmdW5jdGlvbmFsaXR5Lg0KPiANCj4gU2luY2UgY29t
bWl0IDNiNzNhN2I4ZWMzOCAoIm5ldDogbWRpb19idXM6IGFkZCByZWZjb3VudGluZyBmb3IgZndu
b2Rlcw0KPiB0byBtZGlvYnVzIiksIE1ESU8gYnVzZXMgdGFrZSBvd25lcnNoaXAgb2YgdGhlIE9G
IG5vZGUgaGFuZGxlZCB0byB0aGVtLA0KPiBhbmQgcmVsZWFzZSBpdCBvbiB0aGVpciBvd24uIFRo
ZSBnc3dpcCBkcml2ZXIgbm8gbG9uZ2VyIG5lZWRzIHRvIGRvDQo+IHRoaXMuDQo+IA0KPiBDb21i
aW5lIHRoYXQgd2l0aCBkZXZyZXMsIGFuZCB3ZSBubyBsb25nZXIgbmVlZCB0byBrZWVwIHRyYWNr
IG9mDQo+IGFueXRoaW5nIGZvciB0ZWFyZG93biBwdXJwb3Nlcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFZsYWRpbWlyIE9sdGVhbiA8dmxhZGltaXIub2x0ZWFuQG54cC5jb20+DQoNClJldmlld2Vk
LWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4gLS0tDQo+ICBk
cml2ZXJzL25ldC9kc2EvbGFudGlxX2dzd2lwLmMgfCA2OSArKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMzggZGVs
ZXRpb25zKC0p

