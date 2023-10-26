Return-Path: <netdev+bounces-44373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBE7D7AA0
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 04:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B708281E0E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA1749F;
	Thu, 26 Oct 2023 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="sceXqBEA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EED4439
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 02:04:39 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2108.outbound.protection.outlook.com [40.107.212.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA71AC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 19:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4Jd7ULO/V3MoYrjcdH6gJZbMm9EwPFTZxSf0HYv+zqgNqcBE45H1t7BXxhv5TgA3lFlYdsHooqo8AC2X7SAz3+ojT+CGdH+hHdXArt9TCAEDLW+Q8mCn9JcUWRll++suMmTi3IKJ76TNfqgAdewxe66wW9qcWLmz7Cq7r9wgg8EqWRpjVT7ehqRR+aud8dERDNkYJhpwj6YyMWBjJ+04Y8aHoYNdi2bkAYwPzjI3tAT4RuxbDfcdaLcOCOVXZK5wRo2OkuYefSSY88CmgW0gEmrCO7MHryFn1DbVB8Z4ng0NJlAQlu8XFOGG3Z1i/0NSxD2aHj3M8EvI6X4AxUyUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcbYxKEz0nPnCNCBWm8cwhHfBt2JUguhQi+EZMT49A8=;
 b=lCTMMoDKrBusV1Q8/NgldN1NJo55TMYw+2Cp54uS2CJC0gqifTnMIlH37ltWudQFxGlkefdqE55Q0RFxifOek+8rGngANc4wYNYNTiWcW6hEnzviI5hSY8VF/hxBTMCYrpUWekjieGiT8x4q9tMzxcFAgsDaMfxVNWg+hGrMZG2cZ8NU3P91EWTQ+acnT9ECBebNwhXpDXQDYS/WL9DhI5RN3saADnpxHlHIdkZbaPdsow93xf1rQZIHakUrH80XGN6b1fXKvVeV6ZXA0DXafAxsLg9qEH9csBOFqknsPWB2zkU8w3dvxBEzgM2Wmjx18ZI0TgPcOd5Dd9SYgLc6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcbYxKEz0nPnCNCBWm8cwhHfBt2JUguhQi+EZMT49A8=;
 b=sceXqBEASOlP3nqGYsaPOJMdV/oxklIrYwMpmtp3YdkqFFu/75YP4h3+fvnLpkQleEBPTUcL8fA+yaau7DGdbq3hek5GNQApF4zAbAQ9WgOWAXI38oXmNoooqp5ntZbvqVPPsvdCd9uIR+hDyh+gxoK5aGqGiHPrRRXErn9wj3I=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by PH0PR13MB4859.namprd13.prod.outlook.com (2603:10b6:510:a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:04:33 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::ca0b:89ad:414f:aedf]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::ca0b:89ad:414f:aedf%6]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 02:04:33 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Wojciech Drewek <wojciech.drewek@intel.com>, Louis Peens
	<louis.peens@corigine.com>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Fei Qin <fei.qin@nephogine.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, oss-drivers <oss-drivers@corigine.com>
Subject: RE: [PATCH net-next] nfp: using napi_build_skb() to replace
 build_skb()
Thread-Topic: [PATCH net-next] nfp: using napi_build_skb() to replace
 build_skb()
Thread-Index: AQHaBxbCVr82Q26prkSZKQn28atzZrBaMXuAgAEemsA=
Date: Thu, 26 Oct 2023 02:04:33 +0000
Message-ID:
 <DM6PR13MB370503098CEFC598094BB764FCDDA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20231025074146.10692-1-louis.peens@corigine.com>
 <d8de399a-c063-4078-b0f9-068747f27183@intel.com>
In-Reply-To: <d8de399a-c063-4078-b0f9-068747f27183@intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|PH0PR13MB4859:EE_
x-ms-office365-filtering-correlation-id: 719ee97c-191c-4a9f-08bb-08dbd5c7e5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ygc0J9jSFf41hP21+//HGI9ew0XX/Ek9ervNblth6ioLwVT0aJZc9GxoB5x47hTKmX7tTOmV7ENGiYkPFRtrGH25RcSSYTP7tEHVC3ASwRJknzq/U9e6P6bAsz7XHTFm/VOZrZoIF4fTy2CECPK4WmMkmTsQLLbeRGGHp8x4j6F1npMX6gvgh7EYdti33o8w2Egm4EVhBkRbrkFKiwOyESC6pVqQbH8UsqcMT/aGOhyidKqT3feDLOb6S98dBuqERs0XdPtIfXcMSSL5OClYLNw6L5W/WmCUjvWgPY/6UQWNcOxKrlEI8rRrLQjhKems6UrjRf4kSgf08O/hrbHou3g91kc5W6VXDYR19fM38cvwy9Y4ziEI2sDVnm2Yinfz79OpC75yY3ooGB/rI3Cry4g39tJNqnZbgcNf0UuZhnpLZx9tHGrxxTpNC3UYyuz+IAI3QvIUlLI3T9KYI8yjzBPIW35t1k6lHUSeq4OjgKUuiN7a+My+rcRjqdK2pYmLnn5R55oUNuJnai3RZecMgHS0XeVfmWoiSmPIF7zkhUdpBAFndK9vIqg/xHxlFhaOowGzruaH0GnMACT+TPFLJqrNws4b23SKuraR4GKSULt9vhbtSg0u7ElMgLTuJvvvPGIkYxlVUsYZh29PUn6hBouZODxgCppPNbBLRkX4x9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(396003)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(54906003)(76116006)(38070700009)(66946007)(66446008)(107886003)(66476007)(66556008)(7696005)(316002)(38100700002)(26005)(64756008)(110136005)(33656002)(86362001)(6506007)(9686003)(71200400001)(53546011)(5660300002)(122000001)(4326008)(8936002)(52536014)(44832011)(41300700001)(8676002)(4744005)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjBmb0ZMK2syQVgyR25hUGNrRVMzZ3lpa20zMmZKb1J6ektXb0VnZzhPbTNm?=
 =?utf-8?B?LzhoRm5zZzR6UGxtSGcvYWUyWElaK0JIeWRYWXRUenZUZFFoRHdQL3ZLNHdv?=
 =?utf-8?B?NGJqcU1KYmdCYjlRNVBVeFZiek5EQlJTM2t3cXJlOEUvbXk5ek5KVkhCS3g5?=
 =?utf-8?B?bVRHK3BOQnZSTnRUSjlpdFNmZmFWcWZGOWJydTF5enZLQUdjNXIrdVBKQVU4?=
 =?utf-8?B?dHVlenpFUFVTa1N4eVhBbDhPSnlUYlR5Sk5vd0E5RFNud3lLbmVWdGNNMnpq?=
 =?utf-8?B?elZ6REZHanZFVjErc1FQRUpyaUpsL0xvMGt6clVrWXZ1cnhqcmZTRUt3eUlh?=
 =?utf-8?B?MnJ1ZVhRV1FrdTgzOGZqWGZ6NmhzK3llWEJIMXNPc05yVFhXZ211dGswVDdh?=
 =?utf-8?B?SkVPY1ZET2d0a01ITTliWllLSDhYN0JUVzgwY1lqTUQ2Rlp2UzhSVTJDY3NB?=
 =?utf-8?B?U3VXWllOUFlPbFhoeHo1enJxM1l2L0pJSnRUVkVqMWlmN25FTzFNSWZUYThj?=
 =?utf-8?B?SG85eWFja0ZrS1l5YTBQK293YVpXQnNvVVBkYThOWm83ODYvMlhQZHhZWWUw?=
 =?utf-8?B?d1dLczZBRUcvbytxcUozZ0MzWXEveGhlb3FwTlFJcytCRzNvV0hQdkk4aStv?=
 =?utf-8?B?RmNseFU1YzlibmNvSEtlTThOdENhMWlrSjFNMkRHSFFVSGkrYkV5RGFXZnJY?=
 =?utf-8?B?OS85WXpCT3NXQnFUb3pjdGFoS2dZMy95NU1ndGx6N1JTTzhFdGpNUTBjbVRs?=
 =?utf-8?B?K0svR0Joem1vVTVubDUzTyttVnJLMVFGSTZUOVhldzg3M2V6S1ZNRTFoeFo0?=
 =?utf-8?B?MmtWQ1o1cUpVd2R3SXFVa2tRd3dSd0JWRFdlY20vckNnall4R2pZbFU5ZzYw?=
 =?utf-8?B?QVhmcEpoNnNtVmhoOG03bjluSjRaKzJUNEJLRHVEbjZZL2dKbUd0Z3U1NFpt?=
 =?utf-8?B?Mk9WY3Z0NmFtcEtFSnhsbnNTOEkzQkdNTlBKc2FVdzk4aHZCaTdNTFRlOEdt?=
 =?utf-8?B?KzVYS09pR0pINEtsTENndXdjSHcydUFOdjA0N29nR2VCNm0zWldid3ZuRkxu?=
 =?utf-8?B?UzhrQVZvUGtNZmhhaGxVc3lWWHZGams3U1VrZ3B2M25vcVhmZlBUcFMyKzM1?=
 =?utf-8?B?QlAvRktKNnRIU2g5NkR2VnFCd2szd1pwZkMzU1dOZFk1U0QrZDNLK3hvQjNP?=
 =?utf-8?B?VkhhS1hXUlZpbFhKRmNUMndqYUk1UHh3NytkM2JJSWdHcXRIdTlMbk0xUEsz?=
 =?utf-8?B?bVV2OWp0M3d2NkJlS2JQbXk0ZkxoZTlab001WmJmZnZod2JjUTdyN1NkWkkz?=
 =?utf-8?B?dGwzWTdCLzNlKzN1RjhZMlp3WGZpNzI2MFcvL1dyMXRYSWtNZ0swbCtUc3FI?=
 =?utf-8?B?THc1STBRQlZDQVhjeVhzUkVKcWMxU2hpSFpJZEFObU12OUtxSlBIcGVra3JD?=
 =?utf-8?B?SmV5ckxBb3ZIOENQa0NLZlBWdGV4bm9NaWlWSmYvSWI0b1NRL25hM2ZNUVdN?=
 =?utf-8?B?a2wvaEd4c0thbFNjbnNIZ0UwQlRsZ3g1M2s1WjYyQ1RxMGZIcmVWYXNSN09R?=
 =?utf-8?B?dFJoalZTc2g1Y0tYaVdvVGQwcEhvMzJqa0xuVmlNeFFUcGMyMXRoVllWT1h3?=
 =?utf-8?B?ejk1NE9XZzQvZUNjbW5BUGpka0NQT090aFlGU09JbE5QSlVER2FYb0MrSG01?=
 =?utf-8?B?c1pyNFJuSXpseWxtTzRwTnZoK3lkOWdCUXloS0hTRW9PSmtRTTB3bnF0MzB4?=
 =?utf-8?B?b0FnQmgwZFc2YUhwaGVwSm5KWUE5MVJJc0xtb0k2ZmFuQjBBRGswdldUcW1y?=
 =?utf-8?B?am9UTXlXb2hJeFNQcGFWT3ZBQnRmZDVqVjBWeTYzY3M0NWRFMk5UaDQ1SVJW?=
 =?utf-8?B?RVFZV01CaXVaNEs1czRHV2lBUGc1VU52UXh1d2h0WllzUHRLRHh2ZU5QRmpi?=
 =?utf-8?B?TEw0UHBGU2dCR1kyMjdPNlRCK3FzZTJ2TXd1Y1FwK3AyNmdMcmx5N2lTd1JJ?=
 =?utf-8?B?S21VRnFybHVSQ0hEZXVJUDgrUW42WkhnMHlOTXFGdzZaUnYrTWhaTTlDZXRC?=
 =?utf-8?B?ZFc4RjltMld2SGpPclZuS3Z5czVDWksrQzdQL1BpTW9DVjZ3T083SHFvc0dR?=
 =?utf-8?Q?NmKnP4p6oqzm4tKdKj2Mg7rfo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719ee97c-191c-4a9f-08bb-08dbd5c7e5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 02:04:33.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNlh0W9QRS9Cov3hbOuUGI1fxk/wLC9QnNjjKOji9jE69fEc6WKDeWW44SRw090eBD1C2cSkOUnSoxg+YZuPO0k8pUD6Ratr2AfoAdpTLOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB4859

DQpPbiBXZWRuZXNkYXksIE9jdG9iZXIgMjUsIDIwMjMgNDo0NyBQTSwgV29qY2llY2ggRHJld2Vr
IHdyb3RlOg0KPiBPbiAyNS4xMC4yMDIzIDA5OjQxLCBMb3VpcyBQZWVucyB3cm90ZToNCj4gPiBA
QCAtMTM2Myw3ICsxMzYzLDcgQEAgbmZwX2N0cmxfcnhfb25lKHN0cnVjdCBuZnBfbmV0ICpubiwg
c3RydWN0DQo+IG5mcF9uZXRfZHAgKmRwLA0KPiANCj4gSGkgTG91aXMsDQo+IEknbSBub3QgYW4g
ZXhwZXJ0IHJlZ2FyZGluZyBOQVBJIGJ1dCBJIHRoaW5rIG5hcGlfYnVpbGRfc2tiIHNob3VsZCBi
ZSB1c2VkIGluDQo+IG5hcGkgY29udGV4dC4NCj4gRnJvbSB3aGF0IEkgc2VlIG5mcF9jdHJsX3J4
X29uZSBpcyB1c2VkIGFmdGVyIGNhbGxpbmcgbmZwX25mZGtfY3RybF9wb2xsIHdoaWNoDQo+IGlz
IHNjaGVkdWxlZA0KPiB1c2luZyB0YXNrbGV0X3NldHVwLCBub3QgdXNpbmcgbmFwaV9zY2hlZHVs
ZS4NCj4gQW0gSSByaWdodD8NCj4gDQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIEkg
dGhpbmsgaXQgd29uJ3QgY2F1c2UgYW55IHRlY2huaWNhbCBwcm9ibGVtIHNpbmNlDQp0YXNrbGV0
IGlzIGFsc28gaW4gc29mdF9pcnEgY29udGV4dChjb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBoZXJl
KS4gQnV0IEkgYWdyZWUgdGhhdA0KbGV0J3MgZm9sbG93IHRoZSBjb252ZW50aW9uIG9mIG5vdCB1
c2luZyBpdCBvdXRzaWRlIG5hcGkgY29udGV4dC4gV2lsbCBzZW5kIHYyIHRvDQpkcm9wIHRoZSBj
aGFuZ2UuDQo=

