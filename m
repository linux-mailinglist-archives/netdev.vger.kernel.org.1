Return-Path: <netdev+bounces-37008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943117B30D6
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A6C6C1C20878
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91315AF2;
	Fri, 29 Sep 2023 10:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDB156CA
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 10:46:49 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998751A8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 03:46:48 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SNNvCW003175
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 03:46:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yAP3advP8O5ag1JuXoQVGA/A/WTvtZbLH4xPht+pwHQ=;
 b=iSUDCMKXMAmX8w/yufWKmxqOaEkqklQz7jvnuhu3K1Ny3ZwVdWUfgCqicIjD8p2107SU
 chpkUcziVz2PRxp0kUtLUiUwifRQgMIY1PrVuAFASLuWQB2DvsV9Q4/bJnQWCH1s22Tc
 xEgLuKVav3CKPcDxx53b64Uhyorp/Fv8JpWxGOxyQy7KoxR25pfZeltEHuu7NF4Pi/Rd
 V7C97AyMSSR25/wvk5hJCJjI9JxmCHwCv01w+IQG0Tpjiku9US8VYZ5WKKPqMJOhKpXp
 VtmR1X9PmGKy/+HdPAqMznpVCI127/m89M1WUjrugK45toGdfF1Ej02GLNOnV9949wYf yw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tdk4gdt9g-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 03:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOqzByI/eOuQWtjSAMakpq6JTAcvpHAfDmnA27AnVkJR2HIpG9DV5XGZ3pLgRJzqco9rT3IpFXU5OpBbdAYKyaMnvHaPkHGAynEH4Y6e5GGUzJlE4YcCr4v4TphRu1Rh4dUVJeFiEVx1T/IX4UX7T0NXoexuol2A5C2yjUCvZK+gWDpZYAVR7qkh5hooM/Oxeaz3Jpqayb/HtvxzfweOaeR72J8z5NehD7s5e24xV9jA91jOtiqDvtzunbmJT2hRzmd31W7Q+eV2bvKcbXdW9cn54XVzSM9iAVDp1XlhbV3onV2R/IllgsjqaC4CGCAk3luaCLNlQpLgZoFIDyKQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAP3advP8O5ag1JuXoQVGA/A/WTvtZbLH4xPht+pwHQ=;
 b=CvLMQRh5C1y/XZkv7dAaA3W056gn9jwEeub+So5/vJ0u/YO2cQH8p5A0JCsxq4DnNYnh+AejjxyGMmGvayFdqVpXg/uyJP9Qtenzp3iVHuhG9gaFtIiB6ihHnQPtVUSkfqGBgCqRF0XTCA3UmvGfyZ19aOrdcj+XlpaFnndDXXDv4SJIoTNfo1rIlv4obZB4kV8QiHzPQs/EDKdXPdsQmwWGJIyG8g70nV+BT51gPkzsooGVRsYGJFTMz+yZf+IF+ze6jwWgA4jb3qJAWR7ZiEstBfrxafIQtmCxiWbhinKJDxPHIEu14X7LdGHrBDwSNWkYrTxCijc7eX0KxiDLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4638.namprd15.prod.outlook.com (2603:10b6:510:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 10:46:45 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::729a:d6cd:8a66:8983]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::729a:d6cd:8a66:8983%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 10:46:44 +0000
From: Chris Mason <clm@meta.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
CC: "dw@davidwei.uk" <dw@davidwei.uk>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Chris Mason <clm@meta.com>, Saeed Mahameed
	<saeedm@nvidia.com>,
        "kuba@kernel.org" <kuba@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: Re: [PATCH RFC] net/mlx5e: avoid page pool frag counter underflow
Thread-Topic: [PATCH RFC] net/mlx5e: avoid page pool frag counter underflow
Thread-Index: AQHZ8mZDZqPLa0LYF0eSNzLSHwhPfrAxg5YAgAAcCAA=
Date: Fri, 29 Sep 2023 10:46:44 +0000
Message-ID: <117FF31A-7BE0-4050-B2BB-E41F224FF72F@meta.com>
References: <20230928234735.3026489-1-clm@fb.com>
 <a0dacf7c3a869ef94db8e42e22d71edea6cbd8d8.camel@nvidia.com>
In-Reply-To: <a0dacf7c3a869ef94db8e42e22d71edea6cbd8d8.camel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB4287:EE_|PH0PR15MB4638:EE_
x-ms-office365-filtering-correlation-id: 5c27b332-a1a0-4688-667e-08dbc0d95f85
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8DfU4dK3oycKQY04BFEnV2M3mSxKhkB3b+pnPl9TQLm3D//cFAkqx+zWqmLf2J7cuN6EXowXqrqXG1jRQHZAvTfjXVuPVvexnZfGLZWkJ0DjtGPj/1KII4TuU/n5ONo5q9d8GLMPF6UPcAMJgYYUZ2+/qqH9nsXehuPRleM4B6sP+MTwyKdoHBy6Z6prMICAi743TQpCW10WsRvo5INiq4l0r5GdlKOmvWfpgsW5ZW0+teU62+EsJ1Uw7ff3MKykYEoFqpyyB7tC8z7ao6IeYoELv7kobNZrG25I9HZsKRqqGRsMoj3lpY367KpfcTWTE5e6mL0jVQm0M+iajSOfU458m//+4pFlxoe81OFPDqqpaky6b4gbSt8XOjkPjNK6gvc5ENBlfDmYwbjyPVHP552VqHd78SAu6WJF8BGTRIgjvhgeOQNmK+kGfohHuR9icAf6ioYkAknIaLb41sM6QBlZTEgjXUBhGxXmnnbo8aNiNbbgK0kmWnYn09bCbRtf7Rit+zb2l/uyvRv0Gbicz1cDk75sfAedkPjoCL+VjwzKCFrYVATWglJxwAzX8yHWhZQ/YS1h7yEEVttrVoho36eb2e0VYolMrfG7QTnbZN4OmxJ1GkkiTu6XLMCM9ya+2N5vJcl40h5DjIXAOG9bFw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6916009)(54906003)(66446008)(66476007)(64756008)(76116006)(66556008)(66946007)(41300700001)(316002)(71200400001)(6512007)(2906002)(53546011)(6506007)(6486002)(478600001)(5660300002)(2616005)(4326008)(8676002)(8936002)(122000001)(38070700005)(38100700002)(66899024)(86362001)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?V1Roc0VaM3ZhMGFNT1NhZld3YlZOZ1EzS0tNblFRUFdCdmJjTTVMRzA4WGR6?=
 =?utf-8?B?Z1RBNjNnTkMrNVNHRTVKK3JuV1pjU3gwbGRvajcveVhuKzdaSndmNEZLaUNz?=
 =?utf-8?B?ZzIvMkQwbzFOOGlKQVBWVlo3UnN5N0pKeVNieTkvczl3SFRWTVlIdXFiQXRK?=
 =?utf-8?B?eVgwK2NPVWw3aFEydGd1S0ROdWZXR0l5TTZlaU9Mc3FLRk1NTHEyVmdiMDhh?=
 =?utf-8?B?cGlhaXhBNm1nMGltclVvcWVLZ0xrdWhEckdBTE90ZmdmaXZuU3hDSFBUVlBW?=
 =?utf-8?B?TVVGcHpqZVVncE8rRjBiTDZLSnIxb0JDUTBaRUpBKytWUTlrYi9aeDJXVVh0?=
 =?utf-8?B?bEJJZ1BwWU9UV3J3UUU3MzNCd0IxV0dsSC9QY3Z5YXBzTG5KNTJUNDJ0MUs4?=
 =?utf-8?B?RCtWNklRUEdoWmNrODZSN20ydFdsZUVrNXJaeldyNTVDQ0Y3YlZzNS9nZXNK?=
 =?utf-8?B?bVlTV2EwWGNGRzVKdGZBdVBGamxDbk5YZlVCc2hWTE4vTWQ0OWwwOG5qeDRR?=
 =?utf-8?B?a1QwcUczUEdHdm5tV0o2ZFozVGtFUjc1THJTQWFUS2ZCbEgvWTYzcXR5c2F6?=
 =?utf-8?B?OGZnNnhWV2RjUVgrM1MzOGVpbmhZL3pFc3RJa1lJTnAyT01KcVliUkxubVc5?=
 =?utf-8?B?R1hLMHpZQktqSHBNSDY4K1ZvMzlENTNFYUpRcklGUnZIZG01dzNiV3ZyelZx?=
 =?utf-8?B?VTVUMEVveGM5R2NrK0xDTjVvLzBRbit0eDBuQjBDMExqcklTcDBNQkZ1VVUv?=
 =?utf-8?B?K3ZhL3UwQk9sT0tKUG5wQXlVUERnbFFQK0pwVGJRUG53TENYU0k4WHUyclZy?=
 =?utf-8?B?blo2Rk5NSXhpSlFxYVM4MXpJODQrWGxCcGx2b2IxZXZDSFBXOE9POWthR2xo?=
 =?utf-8?B?N2o1WXNRTmFvZVlzSEdua3gxNEJXYWRTakFrRHIzTkFVMlRXdi9KNGY5WFdY?=
 =?utf-8?B?UFZCb2NxMWhMdjU1QTRqbDFSWmhycUxtWjQ1VlVvWGlNSFI3a1d4RWEzOWl4?=
 =?utf-8?B?S2QybWhZOUZiYUtwN01TNGxNa29WOUVKeDFkaEVyNkxpOEljNlNaeER5NGNX?=
 =?utf-8?B?VnAvblhpVDU4M3FPclFobytyWTVlZkVrc2x1bE1kTG91WEM5c1F6bzRjajlU?=
 =?utf-8?B?SlU3M3ZoaHM1MWI4SG1Nd1NVNVA2Sm9FV0hxTDBoTSt3VEMxYngrc1YrNGdw?=
 =?utf-8?B?a0hjak9JZkhkSm9FakRoQlJJYzVpbjN6M25iSXlrMHQ0dUgyWEZSbWE1T3Ni?=
 =?utf-8?B?VCtKVDc3ZUZRODFkbjQ5MTR5Sys0KzlLaG0rNzlNNnVqOWhHL1ZBUU1aUnJn?=
 =?utf-8?B?Nk8zNDExdlNzUVhTL0FOaWtyby93YkdDR3RGVVY5dGl0dzRoV28wYkdRbHFz?=
 =?utf-8?B?R3QzMDk1R3IyVS80eCtMNFZIRUx0Sm5zUWJrOUJMQzBNNWVZRUlRUlpIbkJz?=
 =?utf-8?B?L2ZWVlFtYTJZUkE5dmFjU0tZZ1BObm96Y3NaOFQ5OEtPaklkSWVPUUZzMGtD?=
 =?utf-8?B?NEoxRkxjanV6RmhON1g4Ujl0THFqTXpIK2NlL2p2aGw4Y2lwcGQyeUZvbEUx?=
 =?utf-8?B?NE5vWHpvV0FjOW5WMm5JWnkwdU94TFdLUnR2WDdKRVFTRHNkRnpuWEg4WXVR?=
 =?utf-8?B?QjAzdGRhQ3ZRTzUxUHl3WnRna1NYU0JoOTkvWW1Ebkw5engzSHRZV1dPUmNM?=
 =?utf-8?B?U09WOVhxUTNDdDRlZldHaGRMcGFpNWZhRHNsSUlhRzQ0QmNLUG5MOGhycy9a?=
 =?utf-8?B?Z1VBc2o3WUNDTEZXZjlqWnBTRzRxcGZubG83N0J3R1pLL0tWaDJjeWd1N09T?=
 =?utf-8?B?c09tVVF1RlZDNUZjVVg2KzUveDVYTWludlJleVRaVmM4bmpUR0FYQ21Gbjcv?=
 =?utf-8?B?cm1Jbys4V1BvYUE0aVB0cFdXazhVd1RYUnFQa25nOGZzZjdJSXJZbHh0a2Rh?=
 =?utf-8?B?ZkdITnBQbUVxYW4zc3BJWmNMNkxtNUt2YXMyS0ZRaGRyY25CSDBJazVKelR6?=
 =?utf-8?B?L0RxT1o4aHBnd0N4VHVzTU5BdStGMjlaL2RxQTZKbzVCNmdKVW1aYTNIYzZ6?=
 =?utf-8?B?V0FUNFdRMjNoQm1kRDYrYlU2Q2JnMUhPUmxXOEZsZEw4ZmVOT2E4U2dkeis2?=
 =?utf-8?B?R1Rwb1lFUEt1Q2pjZWdYTVA4eHlzbGl3bVdWcEtoQjYycExvU3dxS1M5Ukt5?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59E1C4DC61FB9B4180A31CCE7D36C911@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c27b332-a1a0-4688-667e-08dbc0d95f85
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2023 10:46:44.5575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kj21vy/vR8q212G56CnCfUJHCnjYX1NtGCwRADrl45pH4NzY8gBkNeQ6LB3CT8ZK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4638
X-Proofpoint-GUID: kdk7v9imb_LOMtFS6C2zL-0YtPlicTUk
X-Proofpoint-ORIG-GUID: kdk7v9imb_LOMtFS6C2zL-0YtPlicTUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_09,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQo+IE9uIFNlcCAyOSwgMjAyMywgYXQgNTowNiBBTSwgRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOg0KDQpbIOKApiBdDQoNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPj4gYi9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPj4gaW5kZXggM2ZkMTFiMDc2
MWUwLi45YTdiMTBmMGJiYTkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9t
ZWxsYW5veC9tbHg1L2NvcmUvZW5fcnguYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWVsbGFub3gvbWx4NS9jb3JlL2VuX3J4LmMNCj4+IEBAIC0yOTgsNiArMjk4LDE2IEBAIHN0YXRp
YyB2b2lkIG1seDVlX3BhZ2VfcmVsZWFzZV9mcmFnbWVudGVkKHN0cnVjdCBtbHg1ZV9ycQ0KPj4g
KnJxLA0KPj4gICAgICAgIHUxNiBkcmFpbl9jb3VudCA9IE1MWDVFX1BBR0VDTlRfQklBU19NQVgg
LSBmcmFnX3BhZ2UtPmZyYWdzOw0KPj4gICAgICAgIHN0cnVjdCBwYWdlICpwYWdlID0gZnJhZ19w
YWdlLT5wYWdlOw0KPj4gDQo+PiArICAgICAgIGlmICghcGFnZSkNCj4+ICsgICAgICAgICAgICAg
ICByZXR1cm47DQo+PiArDQo+IElkZWFsbHkgd2UnZCBsaWtlIHRvIGF2b2lkIHRoaXMga2luZCBv
ZiBicm9hZCBjaGVjayBhcyBpdCBjYW4gaGlkZSBvdGhlciBpc3N1ZXMuDQo+IA0KPj4gKyAgICAg
ICAvKg0KPj4gKyAgICAgICAgKiB3ZSdyZSBkcm9wcGluZyBhbGwgb2Ygb3VyIGNvdW50cyBvbiB0
aGlzIHBhZ2UsIG1ha2Ugc3VyZSB3ZQ0KPj4gKyAgICAgICAgKiBkb24ndCBkbyBpdCBhZ2FpbiB0
aGUgbmV4dCB0aW1lIHdlIHByb2Nlc3MgdGhpcyBmcmFnDQo+PiArICAgICAgICAqLw0KPj4gKyAg
ICAgICBmcmFnX3BhZ2UtPmZyYWdzID0gMDsNCj4+ICsgICAgICAgZnJhZ19wYWdlLT5wYWdlID0g
TlVMTDsNCj4+ICsNCj4+ICAgICAgICBpZiAocGFnZV9wb29sX2RlZnJhZ19wYWdlKHBhZ2UsIGRy
YWluX2NvdW50KSA9PSAwKQ0KPj4gICAgICAgICAgICAgICAgcGFnZV9wb29sX3B1dF9kZWZyYWdn
ZWRfcGFnZShycS0+cGFnZV9wb29sLCBwYWdlLCAtMSwgdHJ1ZSk7DQo+PiB9DQo+IA0KPiBXZSBh
bHJlYWR5IGhhdmUgYSBtZWNoYW5pc20gdG8gYXZvaWQgZG91YmxlIHJlbGVhc2VzOiBzZXR0aW5n
IHRoZQ0KPiBNTFg1RV9XUUVfRlJBR19TS0lQX1JFTEVBU0UgYml0IG9uIHRoZSBtbHg1ZV93cWVf
ZnJhZ19pbmZvIGZsYWdzIHBhcmFtZXRlci4gV2hlbg0KPiBtbHg1ZV9hbGxvY19yeF93cWVzIGZh
aWxzIHdlIHNob3VsZCBzZXQgdGhhdCBiaXQgb24gdGhlIHJlbWFpbmluZyBmcmFnX3BhZ2VzLg0K
PiBUaGlzIGlzIGZvciBsZWdhY3kgcnEgbW9kZSwgbXVsdGktcGFja2V0IHdxZSBycSBtb2RlIGhh
cyB0byBiZSBoYW5kbGVkIGFzIHdlbGwNCj4gaW4gYSBzaW1pbGFyIHdheS4NCj4gDQo+IElmIEkg
c2VuZCBhIHBhdGNoIGxhdGVyLCB3b3VsZCB5b3UgYmUgYWJsZSB0byB0ZXN0IGl0Pw0KDQpJIHdh
c27igJl0IGFzIGNvbmZpZGVudCBpbiB1c2luZyB0aGUgU0tJUF9SRUxFQVNFIGJpdCBzaW5jZSB0
aGF0IHNlZW1zIHRvIGJlDQpzZXQgb25jZSBlYXJseSBvbiBhbmQgbmV2ZXIgY2hhbmdlZCBhZ2Fp
bi4gIEJ1dCwgSSBkZWZpbml0ZWx5IGRpZG7igJl0IGV4cGVjdCBteSBwYXRjaCB0bw0KYmUgdGhl
IGZpbmFsIGFuc3dlciwgYW5kIEnigJltIGhhcHB5IHRvIHRlc3QgdGhlIHJlYWwgZml4Lg0KDQpU
aGFua3MhDQoNCi1jaHJpcw==

