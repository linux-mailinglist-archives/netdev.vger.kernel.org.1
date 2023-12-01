Return-Path: <netdev+bounces-52760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF9800173
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 03:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D66F2814E9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 02:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085EC187F;
	Fri,  1 Dec 2023 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="Xxn6n4eQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2124.outbound.protection.outlook.com [40.107.243.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42713E
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 18:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEUxTQcpFAMT8ebeIaX3qkZf5sUanLx3d4BB/UBPOZIQNr4Nbwmtcaf3DqSnplceqMggXi6YLpCLpo6zrnuxexkvxPZ/LoDPvKn0oaneY/LCOO14pflqrPc88Mp8IR2d2cBvCnLSc6NoMF0LZUpLDrYu9rFNfaEhSrzXXSOqdY0KMpRGWExPO5SvveqBFi39tDhJs1F1CVY5v6SZpyKUQJuGy5vEu1CGJiEUvUdeG5hmsO1hZs8GlyphzQoNXq6JlhQt7GkLVgcl+Q32letuWyEuzrGHcYnB27P3c/l6bKDXszyCNaObYxYpLRoCY19z2l+6FtOCCxHaIcSp8kvBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsKdI9sJKkHx3gvMUjfYVaO6mYOt6ODd+zqv8DVgqP8=;
 b=WN6sL9X1rSnitMu/jKJuIpnJDrGhGEnN0fF/QYtm/kaBLjo35l3LHDvePWkwuRKvkyCC78udPWK6PMmQMLzGnJqg3LMGGkl3nS0prWdtRPtCXE1Uj5yuJ009BQ3KL0oBodooLshSD0E/bGxrQmRnBrrzeDu0MVHaEG0xWPy35MCIbgpqw08yvgjAn16cmKHvxfUkhhYFpjeMnFLhbLvLO2VAS5U8NkZ1SWohex07zKA70t/VyYts5APo5j4pK80Mn4VBAc6TltnbknXDLyUQHxahmLfNNFAjrchjJe1ckEGcKO0m9cBEO6R5QQKMUAwRae+bNE79loi1sGnaDV2rOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsKdI9sJKkHx3gvMUjfYVaO6mYOt6ODd+zqv8DVgqP8=;
 b=Xxn6n4eQS99Cid6ox+jQvulTMOPx80Ybr8ZLibPD+uyQGVtbIt+Wc/qyTp3oPxLiqsZQNPIDd7lLc434lvULv7ORD44dit1BRtSz0nQrTKFuruAty7erQekp7I22SiAJDLXiW42pNdBh1BzgWEZ0f1fJAlemEevO/ZepB1IvVJU=
Received: from CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20)
 by MN2PR13MB3759.namprd13.prod.outlook.com (2603:10b6:208:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Fri, 1 Dec
 2023 02:11:09 +0000
Received: from CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::7fc4:6ff7:e8ef:ac41]) by CH2PR13MB3702.namprd13.prod.outlook.com
 ([fe80::7fc4:6ff7:e8ef:ac41%7]) with mapi id 15.20.7046.023; Fri, 1 Dec 2023
 02:11:08 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Heng Qi <hengqi@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
	<mst@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"hawk@kernel.org" <hawk@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>
Subject: RE: [PATCH net-next v5 4/4] virtio-net: support rx netdim
Thread-Topic: [PATCH net-next v5 4/4] virtio-net: support rx netdim
Thread-Index: AQHaIN0+BAadrdO1YU2B1u3z93vvGLCSntWAgAArngCAAAP5gIAABTKAgADcSxA=
Date: Fri, 1 Dec 2023 02:11:08 +0000
Message-ID:
 <CH2PR13MB3702FCD8EF0BDF8F08EB9689FC81A@CH2PR13MB3702.namprd13.prod.outlook.com>
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
 <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
 <6f78d5e0-a8a8-463e-938c-9a9b49cf106f@linux.alibaba.com>
 <4608e204307b1fb16e1f98e0a9c52e6ce2d0a3db.camel@redhat.com>
 <dd8d0c1f-f1ef-42e3-b6a9-24fb5c82f881@linux.alibaba.com>
In-Reply-To: <dd8d0c1f-f1ef-42e3-b6a9-24fb5c82f881@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR13MB3702:EE_|MN2PR13MB3759:EE_
x-ms-office365-filtering-correlation-id: a1899c72-f47d-417c-baac-08dbf212c84d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0JibX4f3a4yMxzEhPJIVtrKYyKm+ivq+fgife043o/HPLpVxjI8Pl27b/qJYLM4XCMhYUJET2x6FxHVMxfbyhwwdogDAduf9VRAowEZA6Vx4eXyx1peN50O83Y+3vYnOFrmdMjlTb519Qz1PfDrFXbWCtV1qIlExJ2paAE8787X6uWyDRPvWYr0bbU/whpfFolu3HEoFztLtWO5gvd6n/0jFBh2pyWPdWMIXpMXJBC2putQdmOpiGMNOK3ew9AVe0gw4W86DUnjw9amGUUrrGvLdE107h1qwYe/iUKqczKuaX4yS3dFB/X8wQghKcOcYhCWMyPxw90B7EVZM7/O5SpRCWHQhAA5+S1DTormKn4e/tPCEXwfNIAYnNgzXv3Jt6pjj+yICwoZ8C32acqbeeGRwqfz33Ys7qNNwNJIm4LrVcSt4ot30snqu0rkjc6s5YI5Sj8PljpQX2WhgVRDUlzPD12mZZ143luPzTWUJ7BjCHPLjeBphCFRzW8hJD5Q1/ww6MShO1qLnqxJbv1KiGC7hYuuHyk8hocszINkl3Y/UQnNBzuzHsn/sLv2j88SAE8Z7OPvXKC0OeYHLKgUB74q+rYzNY7qUuzX3jEduH7gF/sCRH0TcQ5J2esxBc4rGqrVersjwUmV8x59IJ3RNmMtIDbv/nFBfadG1nuvJyNE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3702.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(7416002)(5660300002)(55016003)(44832011)(52536014)(4326008)(8936002)(8676002)(2906002)(41300700001)(316002)(66556008)(64756008)(54906003)(66476007)(76116006)(66946007)(66446008)(110136005)(6506007)(478600001)(86362001)(71200400001)(53546011)(38070700009)(83380400001)(122000001)(9686003)(33656002)(7696005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MDBlbitpd2t6WHNVYUtxWi9IZElTa0NueXhKU1VGWERBb2RjNlpZamxncUdP?=
 =?utf-8?B?REdNT2cxMVBsRmordlk0M28wWHZRTkt0YlZtZDBtQnl5MzdISXVGbWp4ZzUy?=
 =?utf-8?B?Ulk3bE9NSWdHNkdPdEZGclBlWGhYcXJZZW1jbWdCNnEyWm5BQWIxekJzWExu?=
 =?utf-8?B?N2ZydERtUFdmRjZXYncyc2N0K053K0NXaDdGL3d5WFJnQmRUY0xJS0daMUxB?=
 =?utf-8?B?UWc5TStrUnNZRTczNG5BMVhtUTNZc2tOZzZncEpOdDBCQnFOYVkzOU0vMHBX?=
 =?utf-8?B?cStBd0lVNUFUeE8xSFUwRmo2QWdKMVVVOUY2UGlhTGdYYkt0RUhGNzRlSGFM?=
 =?utf-8?B?WTRKb3MxYURJd21nTzBTOHNsQk8vMGNpUzFoUEg0NXllSEMwUlBrK0NJemdv?=
 =?utf-8?B?RXVjRGdoTWF2K1ZoM3JsNnVXVnY5ZkRCajhVRW1sTWNxaVJaZ2NJNE5mMXNZ?=
 =?utf-8?B?QXFYdUV4REZPWTRNdHVkc3VCWmpUTmFmMDRuajZJUWI3aDYvRHN4elVNUEgy?=
 =?utf-8?B?MHlNRHhZK2kxRDZGUUNwVk1mL3pBczhpbmFMR0VONXg4YlRDZTU1dGhQVUgx?=
 =?utf-8?B?b1RzU3ZYWitxQWFmTVEzUXpYa3lzKytINFFGTkFESDFCTUlaR05DVnNHNTBC?=
 =?utf-8?B?ZE1YMDFJQytKZE9pWjRqdmFjU0t1bFJHNldUSEg1VVp4UGFWeDBhMHFEV2FS?=
 =?utf-8?B?MllLbjJXeCtHdHBzZk9TTjg3MEQzQUczR0c3bXBHcy85dktKYXREVVRHb3px?=
 =?utf-8?B?VFpYNVh0VkhsTUppdkFhS0tEbFE3dWRRMGVVWXE3RVVpQktlS1dlZEFVdDRk?=
 =?utf-8?B?Q0FNcGdCQmlCRGpxWkJlQ2ZaYVZaa2tpbEM2RElRNDMrQmI1YmNlSnpDMGJ6?=
 =?utf-8?B?bjhjQ0VGSHM2OHlzMkJWOHZ4N1A1bXZMdDVLMWwxbmF1Tko4QjNmMjY1OG5G?=
 =?utf-8?B?TmZGK3VacFdtdHp0SzU5cVN2c1RaUExZa1FXS08yZEtEbjNrT3pYMFhiMkpo?=
 =?utf-8?B?VWYzVVoySmpPUjdRVG9YVjhTclJQdUltemNYSW9ZSHJNREJ3bVVMT0Jjdk90?=
 =?utf-8?B?Y3VLbVpsSTRpWVpGMW5JYzRMTjd4OXZXK0JlM3JxbHY2Y2hyc0RPZ3NiOFFS?=
 =?utf-8?B?aFJ2NjcydVprZTlHcjF2NzdGZzRkRGJaaTI2RTRUVjh4NGNjTExuNGdsbG9J?=
 =?utf-8?B?ZmhERWJuM25zT1MwMThZQ1c4Mi83bDNZcCtmTG1MZU4wSkwzdHRBakN2cmpj?=
 =?utf-8?B?VkJuaEZ4NG5tdkZmR3Fvc0NKM2w0YmhjNFJ5UmxkUFRYaWQzRXlpVmY2dUFv?=
 =?utf-8?B?S291T3doTG9pZnViMzdBMWVOYWNvaVpHL0xjNzloVU5HVU1wMnhrU0RacENY?=
 =?utf-8?B?WDRzS3hKb3FaL1EzbTcxMi9ZMXdpSzFzTlhqQVp3MFFmZE5ZanlhaGQ1Y05K?=
 =?utf-8?B?TEtrUmZIQUlpY0ZwM29OOEx1SnlWQi9DaTBLVnV6L2xjNGVLSzc3TG90L2Nw?=
 =?utf-8?B?eVVNVHFldWtzUlAxS1ZDUHhYeE5lK3ZkQXVmS2RzVmwveGdmTmhsS3d6M0tN?=
 =?utf-8?B?Rm42bnZtYitmRmFBVk9uWElvMlBnQ0g0THlZSEJYNXdKVFpwMTFicWtFOG9Z?=
 =?utf-8?B?L1MvYlhRaVVJd0s4ZUhPY25ZOE1zcW5vVUtUeFhGM1NKL2lveFRRbjRYWmJp?=
 =?utf-8?B?MnlZcWdvR1BCUmRDaG1mbkFnMzl1aEkzeWdwOFpPTGNKWWE1aG5RbmRWY2VP?=
 =?utf-8?B?SHc1cXR2bStBaThYR20rWktwMXNSLzhjMEVFcU9Gb1RyM1B0V3NZcWlaVndt?=
 =?utf-8?B?Ti9GNDI3Sjk0NDliWVZ1czg3blhzdWl4Q0VVWldlTnJGUTJBTzY5ZXM2MHNt?=
 =?utf-8?B?VTB2RWwyNXFDbEdVelkyS3JWdXQ4SHlJYnhrUjZXR290amFEL2UyL3pibEwz?=
 =?utf-8?B?WjdYQ0prY3c2dXNIZlM2eTA0ZWRqc1hOaWFpMlo4YllnVDRPaG9QVGY1NmdF?=
 =?utf-8?B?WThBeGFhUnFmN0xsS3pvdjJOcTdHNXBFbitXQWJYeW1xR0ZRRUFkYU9rdWpD?=
 =?utf-8?B?bGRFcUdpa1RvSjFtTmZlM3E3elpLd1JSU0tWbnE1UXljZ0dRS3FNV2ZXVXhL?=
 =?utf-8?Q?08rc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3702.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1899c72-f47d-417c-baac-08dbf212c84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 02:11:08.6471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvI0sehGnmEW2TrSbbhZUOgVxnYndsP0PqPfOQyHVYtQhzjcBaMh43ZfCYYMDlBoLqGMqoOLBHRo32bhqQHfLMn8EKkJKX3Qo2E5f1bXDWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3759

T24gVGh1cnNkYXksIE5vdmVtYmVyIDMwLCAyMDIzIDg6NDIgUE0sIEhlbmcgUWkgd3JvdGU6DQo8
Li4uPg0KPiA+Pj4+ICAgIHN0YXRpYyB2b2lkIHZpcnRuZXRfcmVtb3ZlKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KQ0KPiA+Pj4+ICAgIHsNCj4gPj4+PiAgICAgICAgICAgIHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpID0gdmRldi0+cHJpdjsNCj4gPj4+PiArICBpbnQgaTsNCj4gPj4+Pg0KPiA+
Pj4+ICAgICAgICAgICAgdmlydG5ldF9jcHVfbm90aWZfcmVtb3ZlKHZpKTsNCj4gPj4+Pg0KPiA+
Pj4+ICAgICAgICAgICAgLyogTWFrZSBzdXJlIG5vIHdvcmsgaGFuZGxlciBpcyBhY2Nlc3Npbmcg
dGhlIGRldmljZS4gKi8NCj4gPj4+PiAgICAgICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdf
d29yayk7DQo+ID4+Pj4gKyAgZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkr
KykNCj4gPj4+PiArICAgICAgICAgIGNhbmNlbF93b3JrKCZ2aS0+cnFbaV0uZGltLndvcmspOw0K
PC4uLj4gDQo+IFRoZXJlJ3MgY2FuY2VsX3dvcmtfc3luYygpIGluIHY0IGFuZCBJIGRpZCByZXBy
b2R1Y2UgdGhlIGRlYWRsb2NrLg0KPiANCj4gcnRubF9sb2NrIGhlbGQgLT4gLm5kb19zdG9wKCkg
LT4gY2FuY2VsX3dvcmtfc3luYygpIC0+DQo+IHZpcnRuZXRfcnhfZGltX3dvcmsoKSwNCj4gdGhl
IHdvcmsgYWNxdWlyZXMgdGhlIHJ0bmxfbG9jayBhZ2FpbiwgdGhlbiBhIGRlYWRsb2NrIG9jY3Vy
cy4NCj4gDQo+IEkgdGVzdGVkIHRoZSBzY2VuYXJpbyBvZiBjdHJsIGNtZC8ucmVtb3ZlLy5uZG9f
c3RvcCgpL2RpbV93b3JrIHdoZW4gdGhlcmUNCj4gaXMNCj4gYSBiaWcgY29uY3VycmVuY3ksIGFu
ZCBjYW5jZWxfd29yaygpIHdvcmtzIHdlbGwuDQoNCkkgdGhpbmsgdGhlIHF1ZXN0aW9uIGhlcmUg
aXMgd2h5IGRvIHlvdSBuZWVkIGNhbGwgYGNhbmNlbF93b3JrKClgIGluIGByZW1vdmUoKWA/DQpZ
b3UgYWxyZWFkeSBjYWxsIGl0IGluIGBjbG9zZSgpYCwgYW5kIHRoZSBjYWxsc3RhY2sgaXM6DQpy
ZW1vdmUoKSAtPiAgdW5yZWdpc3Rlcl9uZXRkZXYoKSAtPiBydG5sX2xvY2soKSAtPiBuZG9fc3Rv
cCgpIC0+IGNsb3NlKCkNCg0KQW5kIHNpbWlsYXJseSwgeW91IGRvbid0IG5lZWQgaXQgaW4gdGhl
IHVud2luZCBwYXRoIGluIGBwcm9iZSgpYCBlaXRoZXIuDQoNCj4gDQo8Li4uPg0K

