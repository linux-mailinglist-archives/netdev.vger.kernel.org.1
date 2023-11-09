Return-Path: <netdev+bounces-46895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E6A7E6FD1
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E9DB20C02
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D91DFC7;
	Thu,  9 Nov 2023 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HJVGRe4T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA6DDDE
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:05:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6792715
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 09:05:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi7EFbJuZ15zGpigtIU/TEt5nyK/n0nALTlEZiTI4f9hUXGne3oKdjcM1QdfqtoFajaoYBNh8gjnuFzXqcOlwqVRHnuMUySsJDY19sbd6xXfaKJN5/tp0Yma2I5b2r6RWnH4xgrp3HmtAaESlda2OhO1d0wriFAlfKZSkpP9/kkHMU+bTarcKIxlmdVb27jw297qokeQpCTXflQwbEqc7wR2PK+gqIlzVv3Sfi+zhJl/4LqKsZbnANWG2tNPpkvRvjCYUALD0CuzsRuGDQ8x9nugu4iazyI4XKZUnw2Skp8GfYgAHV73XYPBXAj45UfvURr6l3WpZeWa4+63+oBrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1iWWXvbkk6JkFcxCowKwRbbC58vR0lqnLFqyNuNI5k=;
 b=UV+Fkwne6b0lIeKHxw4c5p3BqeQRQEfmBet+kr7at4R8oecBeEsy1sObaXXGeU6YYtvSaP+0+UcnLeZzXNcg1bAG+wHkdR45gUM8PyVyHXlMDeCCsJHilVxUHeXt4gpQApZb5htMsRjRUu6TiF42m89FfcOt6E9oJ1Zz0Q+6fxgUoyB52MfoQZIXcYh7MZ96myQ43nZI0+lYr4lbCDujltXjD8xV2hAdz2P53VqTynH1AkGir2nFgeFgiuq44EXbgLUOMb3FP7r58b3Y83R5HC8+feH6L/hg47RSDPw2U7SKTevTy9mbbgnwVyyBfXMnUWJULO9LBJpznlzw2A79FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1iWWXvbkk6JkFcxCowKwRbbC58vR0lqnLFqyNuNI5k=;
 b=HJVGRe4TW13dkW0kIiI/plqid5qzwqdZOuPVn4BW+f92gC6cR3vgXTD/lO5ZkPVGvW63Ki0OH+o4sfGqnw28qMCmJ961/lZh6wNjPY3XufpcdEp50yu00LK9nFXC1VCn6//eGIZArFm9o2UEtqmdqlV2KXE+UHOe0IQ7v0nxdCH5OIITMhF94bhCQTSR0yddVbcLAf+W/SLow2tTF+baVlrtr0GLKHFa2oGynurMEg5KKk3Fwo09/hv/h2qh8HDI0XH8rNpRGHUPQCbqnpk7MSnbfp1QSW72mMJbK+E7QZVX7xN+RVn/504e0F9dQbX54dBfu6J+5+kI96Lr51YzaQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:05:32 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::5e8f:8354:6b4a:d99d]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::5e8f:8354:6b4a:d99d%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 17:05:31 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "almasrymina@google.com"
	<almasrymina@google.com>
Subject: Re: [PATCH net-next 12/15] net: page_pool: report when page pool was
 destroyed
Thread-Topic: [PATCH net-next 12/15] net: page_pool: report when page pool was
 destroyed
Thread-Index: AQHaBpOl7W4CTu35q0mSlu/Jl/stMrByULsA
Date: Thu, 9 Nov 2023 17:05:31 +0000
Message-ID: <3ab771d9f1332d44e7931eb8f8fe9d8d4be10a9b.camel@nvidia.com>
References: <20231024160220.3973311-1-kuba@kernel.org>
	 <20231024160220.3973311-13-kuba@kernel.org>
In-Reply-To: <20231024160220.3973311-13-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|IA0PR12MB8225:EE_
x-ms-office365-filtering-correlation-id: 6ed46c2d-752c-4713-4260-08dbe14614b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QfdLjmfnIta1k5z8OwSWihZWq1sMcXwMHH/AVRkhqWgu1QMQ3j0twzqmC6Zd8Zrcwa9421JpTQQ5qzeNKoIW3sI6+zeoKxsrxcLXi3tOhWWulM5wDPbHYrqv9Z9oXg36oNU4wPvuYGlN1AJRzi6LF7/JOmoIXbLpoLViznnYDmNii1SCC3yhupG0NcuTuK4DR6qTpsIhSPMPg3LyNLbHVaukw+IX5O5QZ4DOspxjMIaxGv7wc+9qSHpPi+Hy5bEW0amK/GtD8KrSlG9svPNTAfn/pT3wezuVmO85EWQDoN48YhKUi+8/tg9929dh9kLTzRnNOaEvwHvzgNPBw1pR0uLc+9g+Rt4YD3os2pgcxjR3eHao4tQeYbqqGLciyXrWM/u8OTGdNTJSqH40OQ4hEEMAy7qbiqRBDmHUBgH+iBrAvoqqSnfE/BA9ooFjz2tKFg80xCAqSLF5X4gi03sqV3g7j6DWLAjvbeTaXovtEwvpW/90StEMk75/E2/b6z5kBGfP7/VhN0cJQTc0//MHaYBd2Y6IBkGH0X4Fau3MdmgRLeY34TOLrjD3FUtfH9HEGIyAKc9tbHtvnXeJrpuIpqAnWPNDiQhrYH602GTkmRQfAODXloXrmUgKLjz52UAIAWa2XZY9OpxtfxFW+KYJcjgNNzq8oX8aysqPb22hHMo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(86362001)(38100700002)(41300700001)(4001150100001)(2906002)(38070700009)(36756003)(122000001)(5660300002)(478600001)(2616005)(83380400001)(76116006)(4326008)(66946007)(110136005)(91956017)(6512007)(316002)(64756008)(66476007)(54906003)(66446008)(66556008)(6486002)(71200400001)(6506007)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZG1YTG9nTUFDakVqcmkvOG55ZlIvSTB4bmJFT1hvWXFMT1JJUFhFODlQMnAw?=
 =?utf-8?B?T1VtSFhhQ1lBR0JQS2QwbjY5eEhVMGtPWjFVbk9YK3lmNXZaVndreDNWY3ZG?=
 =?utf-8?B?Skl0RTJuR1dzcXZQNnh2cHFrZlF1cENkcDhiSVFJdGc3Uk82SkNGdHVBU1hU?=
 =?utf-8?B?TWxwbHNkdHRZbkZUTFptSk5GWlA3em85VXN1R1pNcms4MG1UbDhqSkV6N1lQ?=
 =?utf-8?B?QUFjUHVURHBtWTBMTTk0QUtnbVBONUJBVzJwNFlFaTNCS3FEbVlGSFhCSEta?=
 =?utf-8?B?bUh5bFVYRlIxb2tJK3p4ZlJGMTEzaFhLZ2pCTjE4UU9jNVQ4ZWlYK3hURXh4?=
 =?utf-8?B?VFV4M2RHOC9iQzN5V3JFTkV6N2FISDFwekZxWkk3Mk1KM05tZXNBRXlWWFU3?=
 =?utf-8?B?YmhOTm1QSGt6RWd4SjM4MitBWnRROVpmdVJkZHQvQndpRVVralVOcEFLa1l1?=
 =?utf-8?B?aWRtM2dJeGhMQ083eVUycmFrb3h2WUNjVFlWenlPOHAzbTBxQjdPVytsUDZq?=
 =?utf-8?B?VE15RkFqRTA1M2JPbmhyeGZ0aXM4UjZFUVI0emdER09FbVkzSnZrUlJCc3Bo?=
 =?utf-8?B?RXNUd2s3STA4WjJmVWhGaG4xaDltZTVYbU5sc2R2NkJiTCtvTStCbXdiVzZh?=
 =?utf-8?B?ZzgzNjY5NithMTNwNFJMTUt3bEd0WmtjTE16VnhNN01SOHFCekFLZysrRFpq?=
 =?utf-8?B?UHc0cTFEZk1jRjdRenlKSm1XWit2TFkxSHVVY1U3SE8zSzg5MlVvWVdIcmxB?=
 =?utf-8?B?MzhGbnA0UEFMYXdMQk5mcUwwaHF0UFI5TkJOTUhrdUFlTTBhOGxTT3ErcXJI?=
 =?utf-8?B?SW5rZW9UQ01xSnA1VGc2S0pnc0ZrZmdKZUs1eVpETHMyRmZwR042NlRoUWY3?=
 =?utf-8?B?bGFlZDgzQlFYakR3Q21aQ3I0TlBjZ1lsd1k1KzhqWDFlN2VqM1FNK1RQQ3dj?=
 =?utf-8?B?YUZZbjNiQzFCV0F1QjY0WlpiQWxtRmtYeVUvUUF3RGpyZmlNYzdMT2VkYnpL?=
 =?utf-8?B?eVprVmlTRUNnYlQxWWhHTm5WZnFzNm9RT0xESFN1YzI3OW51cDZseWNrYjBB?=
 =?utf-8?B?TWM1TW9OVXJRZkg1SmZ1NnVZOXA4TjJnZmRsNWFNaGE1OFhHMXpEVGtLQklj?=
 =?utf-8?B?M0VrRnJnVWtBMVhVR3k5ckV3elVzVXRjK2Nuay9TUzVmTFFqMTRyNUEybC9L?=
 =?utf-8?B?RXJ4TDB5UzZ5emM1bUF4R0NxSUZMaXgrL3hDZjM5VmpFTXlMQVBTSS9tVUR4?=
 =?utf-8?B?MlNLN09GYVVuQ3dKUWFiTHorWkt1NWFYUWE0Z2grSURSRXRIWmphSmU0eFVB?=
 =?utf-8?B?Y3VVN1htbm5IK2loOEJQSTRiSGRYbHhTRGtzVitWKzJsU3Z5a091a2FmUkgy?=
 =?utf-8?B?bVd1Y3RMUmFMUDRwMVFqc2w2U3ZscGpDL0dxUjh4UDFSRTYyYVpKTjVNTWxL?=
 =?utf-8?B?MlhXRmFtQnNDeG41Q0p5QWdIcEsrVE8zWnBEYzlZT3FUQU4yVTNVODNxeDhx?=
 =?utf-8?B?Z2NrUndJaE0vREY0RnBzOUYrOVFvbVBDT1NlZG14ZURnelNLZlV2azRzTUVJ?=
 =?utf-8?B?QzVYMmFFbUNNdGNlanRMbWxidFF0OUtmckdMVERJeTFsaXZaTHZLekF4SEIr?=
 =?utf-8?B?M1o4QmUvSlJwY3I4TGlYdjNMbWFlMjdBK3gwaUM4MFhvZlc4UlFmWU5WNlRH?=
 =?utf-8?B?bXIwM0EyUERVUUhsQnVsZDQzc1VucG95YWk1b2V5ZDVqbkJqZkoyTm9iRGlm?=
 =?utf-8?B?SHpmZWg1M0ozOFNmdUVWbHZRVTVtaWlIS21CY01hMkYvNE5nNGFEN216bkJj?=
 =?utf-8?B?MHd2L1F2d2h1SEozcVJhaUtqSWxZQ2pjbTNON1NhdzRkWlNpTHhuRVB5LzY3?=
 =?utf-8?B?S0NMaXErTXZ2eTdSUFJkVkFHUkQ2VS9YUnBEaU02eTdFbWdpdXY4dUZZdW1Q?=
 =?utf-8?B?RjlhZUk3UGxRWTA2NFN6U3hUcFMwWnN5N3NKaDJtTTZGTVFvdkNTS3pCTjVS?=
 =?utf-8?B?Q3RLdmdOSkx1M0RkMVVjRzdzbzlvQWZFSWVuZ2s3b1lsdXpkTDFnb2NJUzho?=
 =?utf-8?B?eGxDcnJkMUFvemJVYS8zTjJnZFU0amRsVUZpU2huYUMrZVFBVWdsQjNvTUZZ?=
 =?utf-8?B?UytJMUo5NlFUamZjZmp5MUZVcVp0cVZsMUp6cTl1M3dTelJ3KzhiMERZZTlG?=
 =?utf-8?Q?+RE3DnxEeaowsiDfG80J2bAySuwjtZNWcJ5lvYx0atRw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6ED2F9C465A87E4680841CA0DFD02810@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed46c2d-752c-4713-4260-08dbe14614b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 17:05:31.3712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxcXBqeXVog7aOgVjCaaPDFud+2xwWAOXgUKea+FxddoUuhCwf4AIFjRL6qVG0mWAB0IDQ4M4xejckgC5Tdziw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225

T24gVHVlLCAyMDIzLTEwLTI0IGF0IDA5OjAyIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToK
PiBSZXBvcnQgd2hlbiBwYWdlIHBvb2wgd2FzIGRlc3Ryb3llZC4gVG9nZXRoZXIgd2l0aCB0aGUg
aW5mbGlnaHQKPiAvIG1lbW9yeSB1c2UgcmVwb3J0aW5nIHRoaXMgY2FuIHNlcnZlIGFzIGEgcmVw
bGFjZW1lbnQgZm9yIHRoZQo+IHdhcm5pbmcgYWJvdXQgbGVha2VkIHBhZ2UgcG9vbHMgd2UgY3Vy
cmVudGx5IHByaW50IHRvIGRtZXNnLgo+IAo+IEV4YW1wbGUgb3V0cHV0IGZvciBhIGZha2UgbGVh
a2VkIHBhZ2UgcG9vbCB1c2luZyBzb21lIGhhY2tzCj4gaW4gbmV0ZGV2c2ltIChvbmUgImxpdmUi
IHBvb2wsIGFuZCBvbmUgImxlYWtlZCIgb24gdGhlIHNhbWUgZGV2KToKPiAKPiAkIC4vY2xpLnB5
IC0tbm8tc2NoZW1hIC0tc3BlYyBuZXRsaW5rL3NwZWNzL25ldGRldi55YW1sIFwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAtLWR1bXAgcGFnZS1wb29sLWdldAo+IFt7J2lkJzogMiwgJ2lmaW5kZXgn
OiAzfSwKPiDCoHsnaWQnOiAxLCAnaWZpbmRleCc6IDMsICdkZXN0cm95ZWQnOiAxMzMsICdpbmZs
aWdodCc6IDF9XQo+IApUaGUgZGVzdHJveWVkIHRzIHJlYWxseSBoZWxwcyB0byBuYXJyb3cgZG93
biB3aGljaCB0ZXN0cy90ZXN0IHJhbmdlcyBhcmUKdHJpZ2dlcmluZyB0aGUgbGVha3MuIFRoYW5r
cyEKCkkgd2FzIHBsYW5uaW5nIHRvIGFkZCBhIHBlciBwYWdlX3Bvb2wgIm5hbWUiIHdoZXJlIHRo
ZSBkcml2ZXIgd291bGQgZW5jb2RlIHRoZQpycSBpbmRleCArIGNyZWF0aW9uIHRpbWVzdGFtcCBh
bmQgdGhlIHByaW50b3V0IHdvdWxkIHNob3cgdGhpcyBuYW1lLiBUaGlzCmFwcHJvYWNoIGlzIG11
Y2ggY2xlYW5lciB0aG91Z2guCgpGb3Igd2hhdCBpdCdzIHdvcnRoOgoKVGVzdGVkLWJ5OiBEcmFn
b3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KCj4gU2lnbmVkLW9mZi1ieTogSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4KPiAtLS0KPiDCoERvY3VtZW50YXRpb24vbmV0bGlu
ay9zcGVjcy9uZXRkZXYueWFtbCB8wqAgOSArKysrKysrKysKPiDCoGluY2x1ZGUvbmV0L3BhZ2Vf
cG9vbC90eXBlcy5owqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKwo+IMKgaW5jbHVkZS91YXBp
L2xpbnV4L25ldGRldi5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoG5ldC9j
b3JlL3BhZ2VfcG9vbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDEgKwo+IMKgbmV0L2NvcmUvcGFnZV9wb29sX3ByaXYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKwo+IMKgbmV0L2NvcmUvcGFnZV9wb29sX3VzZXIuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCAxMiArKysrKysrKysrKysKPiDCoDYgZmlsZXMgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL25ldGxpbmsvc3Bl
Y3MvbmV0ZGV2LnlhbWwKPiBiL0RvY3VtZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFt
bAo+IGluZGV4IDhkOTk1NzYwYTE0YS4uOGJlOGYyNDliZWQzIDEwMDY0NAo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vbmV0bGluay9zcGVjcy9uZXRkZXYueWFtbAo+ICsrKyBiL0RvY3VtZW50YXRpb24v
bmV0bGluay9zcGVjcy9uZXRkZXYueWFtbAo+IEBAIC0xMjUsNiArMTI1LDE0IEBAIG5hbWU6IG5l
dGRldgo+IMKgwqDCoMKgwqDCoMKgwqAgdHlwZTogdWludAo+IMKgwqDCoMKgwqDCoMKgwqAgZG9j
OiB8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgQW1vdW50IG9mIG1lbW9yeSBoZWxkIGJ5IGluZmxp
Z2h0IHBhZ2VzLgo+ICvCoMKgwqDCoMKgIC0KPiArwqDCoMKgwqDCoMKgwqAgbmFtZTogZGVzdHJv
eWVkCj4gK8KgwqDCoMKgwqDCoMKgIHR5cGU6IHVpbnQKPiArwqDCoMKgwqDCoMKgwqAgZG9jOiB8
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBTZWNvbmRzIGluIENMT0NLX0JPT1RUSU1FIG9mIHdoZW4g
UGFnZSBQb29sIHdhcyBkZXN0cm95ZWQuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoCBQYWdlIFBvb2xz
IHdhaXQgZm9yIGFsbCB0aGUgbWVtb3J5IGFsbG9jYXRlZCBmcm9tIHRoZW0gdG8gYmUgZnJlZWQK
PiArwqDCoMKgwqDCoMKgwqDCoMKgIGJlZm9yZSB0cnVseSBkaXNhcHBlYXJpbmcuCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoCBBYnNlbnQgaWYgUGFnZSBQb29sIGhhc24ndCBiZWVuIGRlc3Ryb3llZC4K
PiDCoAo+IMKgb3BlcmF0aW9uczoKPiDCoMKgIGxpc3Q6Cj4gQEAgLTE3Niw2ICsxODQsNyBAQCBu
YW1lOiBuZXRkZXYKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBuYXBpLWlkCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC0gaW5mbGlnaHQKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LSBpbmZsaWdodC1tZW0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGRlc3Ryb3llZAo+IMKg
wqDCoMKgwqDCoCBkdW1wOgo+IMKgwqDCoMKgwqDCoMKgwqAgcmVwbHk6ICpwcC1yZXBseQo+IMKg
wqDCoMKgIC0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvcGFnZV9wb29sL3R5cGVzLmggYi9p
bmNsdWRlL25ldC9wYWdlX3Bvb2wvdHlwZXMuaAo+IGluZGV4IDdlNDdkN2JiMmMxZS4uZjBjNTFl
ZjVlMzQ1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbmV0L3BhZ2VfcG9vbC90eXBlcy5oCj4gKysr
IGIvaW5jbHVkZS9uZXQvcGFnZV9wb29sL3R5cGVzLmgKPiBAQCAtMTkzLDYgKzE5Myw3IEBAIHN0
cnVjdCBwYWdlX3Bvb2wgewo+IMKgwqDCoMKgwqDCoMKgwqAvKiBVc2VyLWZhY2luZyBmaWVsZHMs
IHByb3RlY3RlZCBieSBwYWdlX3Bvb2xzX2xvY2sgKi8KPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0
IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBobGlzdF9ub2RlIGxp
c3Q7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHU2NCBkZXN0cm95ZWQ7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1MzIgbmFwaV9pZDsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHUzMiBpZDsKPiDCoMKgwqDCoMKgwqDCoMKgfSB1c2VyOwo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZGV2LmggYi9pbmNsdWRlL3VhcGkvbGlu
dXgvbmV0ZGV2LmgKPiBpbmRleCAyNmFlNWJkZDMxODcuLmU1YmY2NmQyYWEzMSAxMDA2NDQKPiAt
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvbmV0ZGV2LmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGlu
dXgvbmV0ZGV2LmgKPiBAQCAtNzAsNiArNzAsNyBAQCBlbnVtIHsKPiDCoMKgwqDCoMKgwqDCoMKg
TkVUREVWX0FfUEFHRV9QT09MX05BUElfSUQsCj4gwqDCoMKgwqDCoMKgwqDCoE5FVERFVl9BX1BB
R0VfUE9PTF9JTkZMSUdIVCwKPiDCoMKgwqDCoMKgwqDCoMKgTkVUREVWX0FfUEFHRV9QT09MX0lO
RkxJR0hUX01FTSwKPiArwqDCoMKgwqDCoMKgwqBORVRERVZfQV9QQUdFX1BPT0xfREVTVFJPWUVE
LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoF9fTkVUREVWX0FfUEFHRV9QT09MX01BWCwKPiDCoMKg
wqDCoMKgwqDCoMKgTkVUREVWX0FfUEFHRV9QT09MX01BWCA9IChfX05FVERFVl9BX1BBR0VfUE9P
TF9NQVggLSAxKQo+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9wYWdlX3Bvb2wuYyBiL25ldC9jb3Jl
L3BhZ2VfcG9vbC5jCj4gaW5kZXggMzBjOGZjOTFmYTY2Li41Nzg0N2ZiYjc2YTAgMTAwNjQ0Cj4g
LS0tIGEvbmV0L2NvcmUvcGFnZV9wb29sLmMKPiArKysgYi9uZXQvY29yZS9wYWdlX3Bvb2wuYwo+
IEBAIC05NDksNiArOTQ5LDcgQEAgdm9pZCBwYWdlX3Bvb2xfZGVzdHJveShzdHJ1Y3QgcGFnZV9w
b29sICpwb29sKQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXBhZ2VfcG9vbF9yZWxlYXNlKHBvb2wp
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+IMKgCj4gK8KgwqDC
oMKgwqDCoMKgcGFnZV9wb29sX2Rlc3Ryb3llZChwb29sKTsKPiDCoMKgwqDCoMKgwqDCoMKgcG9v
bC0+ZGVmZXJfc3RhcnQgPSBqaWZmaWVzOwo+IMKgwqDCoMKgwqDCoMKgwqBwb29sLT5kZWZlcl93
YXJuwqAgPSBqaWZmaWVzICsgREVGRVJfV0FSTl9JTlRFUlZBTDsKPiDCoAo+IGRpZmYgLS1naXQg
YS9uZXQvY29yZS9wYWdlX3Bvb2xfcHJpdi5oIGIvbmV0L2NvcmUvcGFnZV9wb29sX3ByaXYuaAo+
IGluZGV4IDcyZmIyMWVhMWRkYy4uN2ZlNmY4NDJhMjcwIDEwMDY0NAo+IC0tLSBhL25ldC9jb3Jl
L3BhZ2VfcG9vbF9wcml2LmgKPiArKysgYi9uZXQvY29yZS9wYWdlX3Bvb2xfcHJpdi5oCj4gQEAg
LTYsNiArNiw3IEBACj4gwqBzMzIgcGFnZV9wb29sX2luZmxpZ2h0KGNvbnN0IHN0cnVjdCBwYWdl
X3Bvb2wgKnBvb2wsIGJvb2wgc3RyaWN0KTsKPiDCoAo+IMKgaW50IHBhZ2VfcG9vbF9saXN0KHN0
cnVjdCBwYWdlX3Bvb2wgKnBvb2wpOwo+ICt2b2lkIHBhZ2VfcG9vbF9kZXN0cm95ZWQoc3RydWN0
IHBhZ2VfcG9vbCAqcG9vbCk7Cj4gwqB2b2lkIHBhZ2VfcG9vbF91bmxpc3Qoc3RydWN0IHBhZ2Vf
cG9vbCAqcG9vbCk7Cj4gwqAKPiDCoCNlbmRpZgo+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9wYWdl
X3Bvb2xfdXNlci5jIGIvbmV0L2NvcmUvcGFnZV9wb29sX3VzZXIuYwo+IGluZGV4IGM5NzFmZTll
ZWIwMS4uMWZiNWMzY2JlNDEyIDEwMDY0NAo+IC0tLSBhL25ldC9jb3JlL3BhZ2VfcG9vbF91c2Vy
LmMKPiArKysgYi9uZXQvY29yZS9wYWdlX3Bvb2xfdXNlci5jCj4gQEAgLTEzNCw2ICsxMzQsMTAg
QEAgcGFnZV9wb29sX25sX2ZpbGwoc3RydWN0IHNrX2J1ZmYgKnJzcCwgY29uc3Qgc3RydWN0Cj4g
cGFnZV9wb29sICpwb29sLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmxhX3B1dF91aW50KHJz
cCwgTkVUREVWX0FfUEFHRV9QT09MX0lORkxJR0hUX01FTSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5mbGlnaHQgKiByZWZzeikpCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9jYW5jZWw7Cj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHBvb2wtPnVzZXIuZGVzdHJveWVkICYmCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIG5s
YV9wdXRfdWludChyc3AsIE5FVERFVl9BX1BBR0VfUE9PTF9ERVNUUk9ZRUQsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcG9vbC0+dXNlci5kZXN0cm95
ZWQpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIGVycl9jYW5jZWw7Cj4g
wqAKPiDCoMKgwqDCoMKgwqDCoMKgZ2VubG1zZ19lbmQocnNwLCBoZHIpOwo+IMKgCj4gQEAgLTIx
OSw2ICsyMjMsMTQgQEAgaW50IHBhZ2VfcG9vbF9saXN0KHN0cnVjdCBwYWdlX3Bvb2wgKnBvb2wp
Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4gwqB9Cj4gwqAKPiArdm9pZCBwYWdlX3Bv
b2xfZGVzdHJveWVkKHN0cnVjdCBwYWdlX3Bvb2wgKnBvb2wpCj4gK3sKPiArwqDCoMKgwqDCoMKg
wqBtdXRleF9sb2NrKCZwYWdlX3Bvb2xzX2xvY2spOwo+ICvCoMKgwqDCoMKgwqDCoHBvb2wtPnVz
ZXIuZGVzdHJveWVkID0ga3RpbWVfZ2V0X2Jvb3R0aW1lX3NlY29uZHMoKTsKPiArwqDCoMKgwqDC
oMKgwqBuZXRkZXZfbmxfcGFnZV9wb29sX2V2ZW50KHBvb2wsIE5FVERFVl9DTURfUEFHRV9QT09M
X0NIQU5HRV9OVEYpOwo+ICvCoMKgwqDCoMKgwqDCoG11dGV4X3VubG9jaygmcGFnZV9wb29sc19s
b2NrKTsKPiArfQo+ICsKPiDCoHZvaWQgcGFnZV9wb29sX3VubGlzdChzdHJ1Y3QgcGFnZV9wb29s
ICpwb29sKQo+IMKgewo+IMKgwqDCoMKgwqDCoMKgwqBtdXRleF9sb2NrKCZwYWdlX3Bvb2xzX2xv
Y2spOwoK

