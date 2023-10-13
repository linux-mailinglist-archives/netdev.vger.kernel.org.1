Return-Path: <netdev+bounces-40727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F58A7C8831
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2C6B1C20F14
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C9415E86;
	Fri, 13 Oct 2023 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iIXsxN9h"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D1134DC
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:00:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E36F5
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 08:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3jRetmxNkf0c4SG9rPram1/3UauqpNpOP7L4o2p2TDvnFjt4VXugfRi3pb6xAl8+CFBd4tZY4l4t5cwWDd5o/hqtd8bgeSopAqcJCRl1+9yjZDQwrwRzz28E4Bqmia5TRgLqT1qwDQdBGXPu+FQ90v8D2wtP2IgIsrbGOndiCryXX+C93UBhquBEYetZFytnkWlQ+8QCaOcYmP3w0fC3O1psxIf3+XQaL+mZxxYWeAua3Rr8Pz4L2/VQRsrf2oW+txHXOJvMlLAPzIpnZPLDWNFd7791oYy3nQMAGtfqJWUUsqtXeZ20NSIwXoNMvKYod2FJqtiKYD/OPnEAjnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGiRKf5n7MPCVq7KlS2soW+5khJ2KXxWi3z6EyGYSKY=;
 b=THMB0dKhf5lDsFLGSm5IjmyyrJAya0X18UYMC+6iCZOTXU3NstwydCgiB+YvNNu58dOMlfmA2J8Xb7F5W1Wq0KwbayAEOGWN7RGdR6rBZbw1kSsJ/7bDeCzhiRQKEwSUdwZrtU5LIuzjML5x8AxEkLUPe+HSFrLOdxwl6Jn/pBuVSIJAL6bwyIvFY11LlnmHjV4rgFOCFUP4Buyn+o0d6FhOeWkgnLxV8NVvghgwdy0pL3PBPMQQz3bAIokPPCqF9lVVq8DzRsEO7mSvrN6OT4DUFIQpYH6R/Mv0dRWZbABiFfLwGeva6Jr678w/iEHcctIj2ngT6kFt4jPcgztuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGiRKf5n7MPCVq7KlS2soW+5khJ2KXxWi3z6EyGYSKY=;
 b=iIXsxN9hnl124G0+PD0lxDlL4JhcOUxK8YtHb4G7lxBN7Ug+VVcRBdLWcL4Is6QkUyb//DWKgg+r5dF8mffUSXtVOOnXUl2mm7dlI44OdHTzEMeQ9BPoxwLn9MEfqw4TseHR+Ii6DX1Ez/b7V3GGZWEn5gsABQyeqOFJF4vJdBpwyBQNixqZMQJ6Kb1+59Bl88rf3t/d1N8f8Y4gyCJXoKOsXI3t4LMoODGftxxwQVQ3sMkb4C1qKQCT1UanQ1WP9etyQU2wYZO6KZj+nja9tjFgsrNn1AawL/47M4akcH96mg8IJE+j3w5rTW3l3Rsq62w5V2mQmJgnZywoBgkcyQ==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 15:00:08 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::a50a:75e9:b7c1:167b%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:00:07 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"olteanv@gmail.com" <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: RE: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Thread-Topic: [PATCH v3 2/3] mlxbf_gige: Fix intermittent no ip issue
Thread-Index: AQHZ7Xtc1mUUBAgSDUusiYUH4tCd1rAnHs2AgCDRy1A=
Date: Fri, 13 Oct 2023 15:00:07 +0000
Message-ID:
 <CH2PR12MB389581114D62133AA36F1997D7D2A@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20230922173626.23790-1-asmaa@nvidia.com>
 <20230922173626.23790-3-asmaa@nvidia.com>
 <763a584b-ead6-46fe-a50c-147ce5846768@gmail.com>
In-Reply-To: <763a584b-ead6-46fe-a50c-147ce5846768@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|MW3PR12MB4491:EE_
x-ms-office365-filtering-correlation-id: 6b55a734-274e-4c4e-746c-08dbcbfd1720
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wVxGw2DH7lvV7mCzsCkO80XHt6n5WIhXZMCnxAHPg+gnpkVLJSj4O1DKg61+Ax7cW+bHH9rE/u1LYtOS44UNKm8QpZcMOXYLAhPTnTsGlyuWvBWUK0GJMhuoDcsPqJdGxcbJmULcc6E5LoONRqP+soTQdsk1b2LScnLrfwZYXgoiN6Osfqc4d5r0witX8NNQqUHB6J6+oMOQTuaEU5EHimnjowoU5noEQQ6l+eCW3Qw1ARHsn62quleFtUaX0k4dyRBwdkscNNrIYnZlCWIXKBvpnWIYTy3+z/juPryx/Mz/LrGXxhzei3eyTtvZtCsyZjpwJnS16hgtZCHVyFgAhJZSxB+Jy16SDMzoDz0pbGjgVkDq9sz52oFlHJENqFDp6Mzp9vUyOnx8vW2pCL91QjYNtp/vsSpsIN0nEyjh9tK9AqPv3o0BoGuSk8FIpab4Al7MynNXiqbSNExopPfLU86HK0PnxV4RCVysopy236SejXq4h2f64rTmjBDHS8jhGCfUC6dEAcwttEzJZqI7cBiu7gdwEYRiE8WxPMahdf+tx1VbewgivhFRDne3Tas4mhdkPTsa+PFIEv2Pjux/+eqb9Hq/7aV6ArwOo0zgoWgE5ONNR1HGaonNBC6VHhEY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(9686003)(7696005)(6506007)(71200400001)(478600001)(83380400001)(26005)(107886003)(64756008)(2906002)(316002)(41300700001)(54906003)(66556008)(66946007)(76116006)(66476007)(52536014)(5660300002)(4326008)(8936002)(8676002)(66446008)(110136005)(33656002)(122000001)(38070700005)(38100700002)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUZFMWEzRzRmYm93MGRBUTg0NWRCaDc0UmRoai91NUVxaHphZ2RtamxNVnQ2?=
 =?utf-8?B?cEczd2d6ZWpmN0ROcDhpclZKbnVKSitZTzk5UUFxbVN6U0ZhL204dmxSUmp6?=
 =?utf-8?B?N0dXWkcrRmY0RjY4bnQwc2xMM0Rmb1RldjZCcjRZeFJ2RmZ0TENKaWUyVU1i?=
 =?utf-8?B?eWtZdDJOU2dCMGVidVhQQk56djVENU1pMVJ2STZQaXdtaFJwajdoM0Y4dUw0?=
 =?utf-8?B?TGVINHpUWWV1T3Fsc0t0enJ3VXBYNmg3NER0SG55WUpRdzl5VHkweStkanRQ?=
 =?utf-8?B?MUdSUlJkRncyU2Q4WTJXcWlFanpXMDNnaWRvQmhkd3prOTY0NitqMTJrc2py?=
 =?utf-8?B?b2V1cGRNVTRHZVdNMTF2bzlDeHBTT3RCemVsQncxU1phNVNGd3Ezb3FTKzlZ?=
 =?utf-8?B?VVNMUHl0N0J5MDZ0aUJyRTlPUnk3RjZYcWhGajR6clpLdGNPZGZwcWUwOHNT?=
 =?utf-8?B?SDU4am9IbFhTOGc1dzNtaEF4RFBJOHYwMjhEUFJzNjdQZTUrZ1MvbTV6WWhy?=
 =?utf-8?B?OEhZNGI4TU1ieWxlQU5mQ2p1K3dnQzE4T3NBYmxwSWJNWnJ5UTRUanRTUWRB?=
 =?utf-8?B?NnRlVmVtR1NZQ28vcFUzRkxiVDJRNGJjY2pXVy9tNTd5d1JBRHBvV0N0ZEdw?=
 =?utf-8?B?WExna0pYY3BvdGRKSENibzNhT0hFSEJsSlQyVmpkdjV5RHdkR3NaZUhkNHFs?=
 =?utf-8?B?SGpnQjFvOW53UWErOGU3dVhHVHZ4Z3pSTHRUNzhjMUdGVlh5L2trOU1ma0RL?=
 =?utf-8?B?V1JxVklOdS9neEZqMFNvOXFFR25VaVVwWDBFYndoV3Y3bXZYN0hnMjNGRHhB?=
 =?utf-8?B?YjJtMStkcmJXQ3MwMjQ4b1NlaEhycWVCY0RkSDRpbHVaWFY3YWJHMnhNZmZR?=
 =?utf-8?B?cW5uQk9DaThIRGM3VlgrMXZVNlpMUS9SektBcnZ3Nnh2RHpPVnRlRUp1T1VR?=
 =?utf-8?B?Mys5WW1iMnVxUU85L21UbUwzUVJrdVZwQjlQa2o3YjdRNWVpUksweVBiY2pT?=
 =?utf-8?B?SWV6NjZ5MklvdjliTXppZDBJNkFYZG5oNmY1VTlLK2h2TXhuMUxxak5wV1Yv?=
 =?utf-8?B?NEF2Ty9xY0h3c3FEVzVaMUhsUjF0MFdKVGpBdmxWSXI1dTBRZDBGcFdCVHAy?=
 =?utf-8?B?UWFRTS9iYkZpZWpDTVIraGVzTFJmTGVLVlpPUFdhQ3Z2WjMyT1V0dEhyeG9w?=
 =?utf-8?B?dlhUeUQ5ZlNkRG05Nm5rdDg5c05zMzFMRmNtUm9SUDR4WEdyS05rM0tjZ256?=
 =?utf-8?B?K0FGbGczNFB6SVY1ZzBIOURvL3J1Q1FWVkVlVGNmK3RISk1tTURuSmloTzRK?=
 =?utf-8?B?eEV4RVR1cnJKNkF5SUR6SjhUMEhXZ0NueVAzYXNWUklRRmpwSGMvTnJZY3Fk?=
 =?utf-8?B?VTkxaE9jbThFY2luL3gxWDRicGkyaVZQd20yUHJHaUp6Ump1cEpaeFYzQWZY?=
 =?utf-8?B?bjBCWlVwZ3h2SFhvTzE5RWNJWm9MY3pmNGJvUUFTUGpEOVhvaGFrdFFLaHNJ?=
 =?utf-8?B?SzBxKzZpTGZuemMrWGZQeVBNYVExbVZ4QXNDdXJyclppaFJZVXFuVkNaR3pu?=
 =?utf-8?B?d09ueGJ2Y3E3Z0xCeCsyTmlGRUgvL1hEVlA4RSt1aFNxSnpmSE5aWm1kWitV?=
 =?utf-8?B?LzZ5c2E1Q2dGUzUwbnRxbU5UcWJLQnRaUXRtL1VJbzBWOThWTEdrN1Ridkhi?=
 =?utf-8?B?TytOTTdVSmRCQk9GcFBER0U0MVRNR0g5bm1DTEdiNnBPWU9iKzhpZGlUUlRq?=
 =?utf-8?B?cTZBK0hldWF6bWFzbkhkK1BuNG9hMzZ6Q3hhc2xCaitaZEhKejVJaFZxWUVh?=
 =?utf-8?B?aU9MajdFbXU5RmFLdksrL01kRTZsSXFLY2VITDcycUNDSVRtZUk1a1ZjVm52?=
 =?utf-8?B?eno0cFBCOXNKbzFrT21kbzByV05JUFBTd29wK003eUNsMmhwemtPTEFoaDNx?=
 =?utf-8?B?Q1lBRGdrNE92ejRXZHYyM25HM2owMTYrZUxyRW05cysxQ0NVSEIxc0liUUg3?=
 =?utf-8?B?Y3lKc1JFb1ptMGQ2ckdlaFFYbndKU0RCSGVkb3A5Q1dSaThsdjZHVU95SXdD?=
 =?utf-8?B?V2NLVlFyWjlsMjU2dDVmN2hoL1dKZ3Rnc3RXL1J6KzdiSWpEVkJlY3FUbjVH?=
 =?utf-8?Q?65D8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b55a734-274e-4c4e-746c-08dbcbfd1720
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 15:00:07.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwojRoJCz0P3wounryZ1fM16VSKrrkbCzdua5Y0+tHuGbpvvfHtLD9eKSAroEqye9g1tbGqUmt/uB/YtjWbGZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

DQoNCj4gPiBBbHRob3VnaCB0aGUgbGluayBpcyB1cCwgdGhlcmUgaXMgbm8gaXAgYXNzaWduZWQg
b24gYSBzZXR1cCB3aXRoIGhpZ2gNCj4gPiBiYWNrZ3JvdW5kIHRyYWZmaWMuIE5vdGhpbmcgaXMg
dHJhbnNtaXR0ZWQgbm9yIHJlY2VpdmVkLg0KPiA+IFRoZSBSWCBlcnJvciBjb3VudCBrZWVwcyBv
biBpbmNyZWFzaW5nLiBBZnRlciBzZXZlcmFsIG1pbnV0ZXMsIHRoZSBSWA0KPiA+IGVycm9yIGNv
dW50IHN0YWduYXRlcyBhbmQgdGhlIEdpZ0UgaW50ZXJmYWNlIGZpbmFsbHkgZ2V0cyBhbiBpcC4N
Cj4gPg0KPiA+IFRoZSBpc3N1ZSBpcyBpbiB0aGUgbWx4YmZfZ2lnZV9yeF9pbml0IGZ1bmN0aW9u
LiBBcyBzb29uIGFzIHRoZSBSWCBETUENCj4gPiBpcyBlbmFibGVkLCB0aGUgUlggQ0kgcmVhY2hl
cyB0aGUgbWF4IG9mIDEyOCwgYW5kIGl0IGJlY29tZXMgZXF1YWwgdG8NCj4gPiBSWCBQSS4gUlgg
Q0kgZG9lc24ndCBkZWNyZWFzZSBzaW5jZSB0aGUgY29kZSBoYXNuJ3QgcmFuIHBoeV9zdGFydCB5
ZXQuDQo+ID4NCj4gPiBUaGUgc29sdXRpb24gaXMgdG8gbW92ZSB0aGUgcnggaW5pdCBhZnRlciBw
aHlfc3RhcnQuDQo+ID4NCj4gPiBGaXhlczogZjkyZTE4NjlkNzRlICgiQWRkIE1lbGxhbm94IEJs
dWVGaWVsZCBHaWdhYml0IEV0aGVybmV0IGRyaXZlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogQXNt
YWEgTW5lYmhpIDxhc21hYUBudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBUaG9t
cHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT4NCj4gDQo+IFRoaXMgc2VlbXMgZmluZSwgYnV0
IHlvdXIgZGVzY3JpcHRpb24gb2YgdGhlIHByb2JsZW0gc3RpbGwgbG9va3MgbGlrZSB0aGVyZSBt
YXkNCj4gYmUgYSBtb3JlIGZ1bmRhbWVudGFsIG9yZGVyaW5nIGlzc3VlIHdoZW4geW91IGVuYWJs
ZSB5b3VyIFJYIHBpcGUgaGVyZS4NCj4gDQo+IEl0IHNlZW1zIHRvIG1lIGxpa2UgeW91IHNob3Vs
ZCBlbmFibGUgaXQgZnJvbSAiaW5uZXIiIGFzIGluIGNsb3Nlc3QgdG8gdGhlDQo+IENQVS9ETUEg
c3Vic3lzdGVtIHRvd2FyZHMgIm91dGVyIiB3aGljaCBpcyB0aGUgTUFDIGFuZCBmaW5hbGx5IHRo
ZSBQSFkuDQo+IA0KPiBJdCBzaG91bGQgYmUgZmluZSB0byBlbmFibGUgeW91ciBSWCBETUEgYXMg
bG9uZyBhcyB5b3Uga2VlcCB0aGUgTUFDJ3MgUlgNCj4gZGlzYWJsZWQsIGFuZCB0aGVuIHlvdSBj
YW4gZW5hYmxlIHlvdXIgTUFDJ3MgUlggZW5hYmxlIGFuZCBsYXRlciBzdGFydCB0aGUNCj4gUEhZ
Lg0KDQpUaGFua3MgZm9yIHlvdXIgZmVlZGJhY2sgRmxvcmlhbi4gSSB3aWxsIHRha2UgYSBsb29r
IGFuZCBhZGRyZXNzIHlvdXIgY29tbWVudHMgc2hvcnRseS4gU29ycnkgZm9yIHRoZSBkZWxheWVk
IHJlc3BvbnNlLCBJIHdhcyBPT08uDQo=

