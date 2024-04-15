Return-Path: <netdev+bounces-88108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995E8A5C28
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AC8284DF9
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA7E15687D;
	Mon, 15 Apr 2024 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AQzmLMA1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D2139563
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212688; cv=fail; b=TrsGWQAepW1hOnShUQ/WfpKgt1hIhxQJh+Q7BBPTIU+HIvDH2YvbiDeejPlXJTpMssH4tJeYRzv2h95+dbOw/33rKsE1JwsVOXBj+xUWxIkcphadJcGzD4m0HHtvDBFzcMA6p4O5SqBMF/1CHDSCmy5yb4wdYmJaSQcFdzSh8KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212688; c=relaxed/simple;
	bh=ChKtktHuX+2BaEQNWHdeTBvCT74kg6cQJZTz6TZGx0w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ldAf81EC4xaX6EEf863m2qjipEPTcaSsiUTnoabZ35HGndNTvIKl9d4pE5TWZT3Wj7BJ01dVnx/+XG2CR79UWipkMIBUkoBSbq63J+uVDxms5hXYpRjcUbjK7IBwS6/p8XOY+hKNhHCkDcdtMXAbFWoTL6Gz70RXIGqZdqqtIQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AQzmLMA1; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIt6q8LM1j1Y+tp5GniENSmWIrKtN7apKRLhykXRQc+pXYAy+g2+GHjuHOvM4T82TjSKo3SpdJkhkZ5nfhIZjRT9hnNkts7TUbv38g8P/c+kuEJ+V8Ynz2YyjGibumH4qJfqs/KfvEj4i/v93FW4BwUmkvfcbeEyQTaLiICv794+3t4qpcBn5Bcnak89UTnN+jD21LF2+78oN63Tc6BuflV3GcCBA+aDuatNI/vCc26ZZNGEnzzoW84yoCir8aBoUCC4Jm2rVI/eAQ3XPR9+gXEExkXfeO4aNaE8IZZFblpNMFOp3KV+ttOiGrVBmi1fP4bWQQW7m5IMBWqu5EJP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChKtktHuX+2BaEQNWHdeTBvCT74kg6cQJZTz6TZGx0w=;
 b=Iooaz1a7EaHkUmYDZV2NWCNElX11l51NKgnTd7SnFgGY+MQP2ZBAbeUyMgbdX+7e/Rgw9KcPD+7UsXe31BNyhf3Gse1oQUIHWbXTebo8diAILlx2c6u9r7Zo4DIXXAhqGfjYf2toVr2KRDRhnD7gp/LZu+JL9WVqyhP5EXH+ypoQCWTwXiokg/OUKCk3KtRC04XfL83Le/ycmTK+TsuWp1wZyScnzIzYB0+0wBMxEXGXFgmV7NRY7iRuQ6yPzY2jRSdPs2kkm6prlglIcea9TE1bi+Js+EjWvU7uaUN5zqGvGOTpQjV2V2bRAmDAEZ/jVjaujd5tjz0CrUVztGrq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChKtktHuX+2BaEQNWHdeTBvCT74kg6cQJZTz6TZGx0w=;
 b=AQzmLMA1Q7sYY7AY+yP5rf4u0I8uwo7deE6bHMFF0rv0Gjs4Zq1IPjWujDEdCIBIsICo4YodY62p7T3p7EV+i08PVIHs2FX6Jo/kS7OaPwwoCiaAyxpF3iA4G/+RCJbSJUC2amoqzUGZdOZ1no3BGZYmgRPwCgwcQJ4y1QAO6+foCMvrXScRnY3/5EVDkbeSgdJxVXYxZ1uXy8ycf657o7tyn0gjFAdGkJhMfAA3lGgpkXsjPuS25dY0wXRhacQkXKmvQEzxwfoHtcVQ2Dth3sKo8bIVn2BIblgoYiascw2DwzPltXOR/1wKfR5Pd1krvuXwqnqvpK+FFTs+SwvnGA==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CH3PR12MB8546.namprd12.prod.outlook.com (2603:10b6:610:15f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 20:24:42 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 20:24:42 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Topic: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
Thread-Index: AQHajRMmdbHwvvoxokersDJY/cIzq7FpWygAgABwUNA=
Date: Mon, 15 Apr 2024 20:24:42 +0000
Message-ID:
 <CH0PR12MB8580CC83AEEE0DD58D4B1828C9092@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240412195309.737781-1-danielj@nvidia.com>
 <20240412195309.737781-6-danielj@nvidia.com>
 <80934787-ea3c-4b6d-a236-5185430ac92b@linux.alibaba.com>
In-Reply-To: <80934787-ea3c-4b6d-a236-5185430ac92b@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CH3PR12MB8546:EE_
x-ms-office365-filtering-correlation-id: 35a25498-1580-4c86-0b6a-08dc5d8a1580
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qdw0AlOO6wvwWSVwS/Mev5jmjc64n8CzwxG9epUxbzDTbKmyRd3ZkGbUgbd4XYslTckaPKAxttE33Gi5SqItSOu/g5VjwtGsPEOsLjB6ky1BXRwlBInX8ENK6Vil1OWKSUhZ8H70lJGphZjXaUeFsWiF7KREz8EDB8xlAdTXz29PWSm9tfx8oNsR4xA8TdMCJd2Yo/XlnOQJjU56SjSLZyJ/ta4dXmLE/ATU1G90HMx57ndXzf3VfwfMLSjr6rDdFj3gOvLgr2UMoAhxGCVqj6gOzrsT41wDTJRCwfHgkuM16XrNRChjlwJMUTkp1oVSdPY2RSNzojUQiXoS+0ZFmaFyr7nzlF6jXjPncjuGXiwpOTiolaO9Lv6PzTRlr3lADA7gKv2WRe9J2z+0weFE0L56b/RfzisX4b7Nmu+SdS28rfL1Xoj5fF+FuGbWAw4MY5Pyh7Mf4LEEjyecR7p67ucxa43iZ70R5K3duv1HhxwMADt7/ICXjSax66lhuGSHldpZd0fW7dd76XwHm4JF/jwnBOxiYvWkhWhldBcVYJwELoAh87/kqpnCNrk4L6ZxD0wcpgjHem2mAbAV8GGFAgAc8rs3zVNfOURTrGGdspmOymxyST6OFKFmDEvoUcMn4HC9hEIyY/QY0orv4LHQKRk57Kukc2S4s85n4UJwT3/gZxZd4OIB/0KO1R+QHFF+nICN4q7GPt2TblwAoCx1GOo+vc1vXJybGBBB0PWQ1S4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzRKK1o0azNDVDJldzh1aUhZQ2JLTERvR0ZKNVNzeUJDMnhsNXI3ci8rU0Uw?=
 =?utf-8?B?YXFaK2xMV0EvMHhwVThLVlI2VDM0WG1McVVoYzByS2ZsVklsYXBsV3ZqRFVk?=
 =?utf-8?B?NEk3QkZ4NWY1S2l3cVdpZ2ppcWhsbzlrd3JsNFJKVkRPZTY0N3AxNFkyUGFK?=
 =?utf-8?B?RjZScm9OTGtIWjNaZ2tEdWdMTVZ0MzQwUnRJbzNCak9QRW1UOUUxa0dwaHV2?=
 =?utf-8?B?c3N5Z3VOR0RXN1FrNGVsU2FkNE0rV2VjWTQ5S1BYUFhoUjEvL1pGcVU2L1Fy?=
 =?utf-8?B?SVlNYmNPNlNQVTlDT2dVNkRzWlJuU2llNGFLRTBjZ0wxWHpMTVRuMHpEN2VO?=
 =?utf-8?B?ZE8rLzlnRHRnckN6NjlTeTlLRVNaQmFiN3lVSnNvU2VEMkdVVVFERkxRbW1p?=
 =?utf-8?B?bVVOcWZFR2N0NGRKS21ieVJpMnQxeDV6L3gyNEQ5MzkxS0VDUXFOTm1oU1kr?=
 =?utf-8?B?MVRFZVl3QTMxTWpmMkNxYmRqWnFLWXV2eDZFYVJ6STZyMXpJVEFUT2E5czN2?=
 =?utf-8?B?K3BrWGNPQTBKZXZ0Z05oL25nN2VETmFNVXZ6eXVqWnNFSFM5VjFtdlpkck1v?=
 =?utf-8?B?bXU0UDZWSDVCdGxMK3RWeGJhWjNNVFhONGlZRGQ0SEdteUl1WHd0WDBaV3JH?=
 =?utf-8?B?d1VLVzQ1RVhMOHI3dGpPdjBRWUZ1eWxlVEErWG1CRWlVVTJ5TE44Z25ZL2tu?=
 =?utf-8?B?ZldtWC9Jb09jL21sWHVWVnpXYnVlTzFtMDZPM1NaVmtQWisvbUNJVmFUL1dy?=
 =?utf-8?B?SWpvV2NsTDFlL2xmNERCaFRlYjRacDlZbkZRMVFtQnVoNE40TGZiSXIreDZi?=
 =?utf-8?B?RGtNQytoODRRbExQVE1pWXNSVWZkeENsSGM2ZWg0UkYrRno0d29xMVk1ejBm?=
 =?utf-8?B?d0VOc25zM25KK0p4d2V0L21Xc3RkY3RYUU0yQ3ZjWThSdXUwSFIxWXZ6VFVE?=
 =?utf-8?B?TGJreVN2SHphTHBvdjJ5T2NsTFROWnlBN1RrbjRlK1VzajZsN1NXSllNTGJy?=
 =?utf-8?B?dmlwVDVUQTJxOG1LMm9aMkw2T0dMbHArL1ZtN3RpZ3lISjRnUmJkdXR3emRP?=
 =?utf-8?B?SmRlaWpiSzN5VFNSdXAyeUg5QkljSHk3Zy8wa1daVlZUUzI5N00rMnhxWWpZ?=
 =?utf-8?B?RU92eUE4cUNZOFNZNWNoQlRDWjhPc0UyaEZJTFFoZ2RVYi94RS9hTlhtcDBX?=
 =?utf-8?B?aWhzV2NxZ05mT09wU3ZLSmI5SStLSjR5anM1NEQzV2xGZEF5OEVVbUhlSkVp?=
 =?utf-8?B?b3M3cFc4RGM0VnpYOHRORFJtYmpUN1JvL2FkN1czU2s1N2ovT0NUcFZUYVZq?=
 =?utf-8?B?UkFFc092bnc2TlB0b1kvajFtOEp5VCtNa1prcEp2U3p2blNuTkJISnppZk93?=
 =?utf-8?B?WXhEdzRIcDJ3bDg0NVd0VHIrZ1gwZ0paWmd1ZHZiSkdLSDcwRi84NHROcXJN?=
 =?utf-8?B?Vk93MXVKQ0lPNlZWYTd0YzlwVmM2VXZyaHJqLzB1NnJwTFBrSVNPNWY1NDl1?=
 =?utf-8?B?V2Y4VGdjTXd3T1ZjWDBGOVJwNXNwZlFQcVRWUzJ1Mm05Z1N3K1B3ZS9wNjli?=
 =?utf-8?B?OFJkNUcrWWFzSUppZ2tBRU1GK0lTZmFjbDlHdys4aHp3NkVxcEZyTi9sOVdF?=
 =?utf-8?B?MU1rQTJMZEZVVk84SHMrSHBib1U1aTZJVnUrdmx6WW1OeTVIL0J1T3ErQ3Fy?=
 =?utf-8?B?RGZKM1djS21JTXpDdGpQL3Jia1k4REdLY2lSbklGLzMrZ0VGNEdoNHdXSnN2?=
 =?utf-8?B?STVsTE5jVWE3blhFS1JDdHB3OFVteE5HSTg4QmYrREpsWXo4Z3ZDUVBqVlVR?=
 =?utf-8?B?aVJvcWhjVWlQTjQ4a3hSMWlhRGJmMXFKQlFFUlhSOGpBSU5nY3dLZnNQdkJQ?=
 =?utf-8?B?MG5IU3NsTkdNQk1tVWN3SVMwN1k0V1VQeGloaTU5eVMzNnU3N1M4aVM2L0dP?=
 =?utf-8?B?RkpmVnBnVG1UTHd0d0pWOTkyM2R2YTdkMk85VTJudW1USlVtVFJVRlhPeHpG?=
 =?utf-8?B?VVhEUFlHVnMwSDJzUTNhNzk4SmgrR2hkMHdXVFZZeThsQjFJejZhUXpsUUJ1?=
 =?utf-8?B?dTBmeFp2NHZHRXJuTHNMSzk0dTY4Y1VacWxlWjhHWmE5aW1nR0lXSFdZRUxt?=
 =?utf-8?Q?mvPJknwcflrP8YwOWoxfhE07Y?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a25498-1580-4c86-0b6a-08dc5d8a1580
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 20:24:42.6836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5fhmGLcJSzwItUCGDqJTnZsrcQsmwbEAa5ZH2F5qKQxewI6W94+6cOMSLKBhLLLY0QYA3k+DuMvVi8FDsh7nFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8546

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgQXByaWwgMTUsIDIwMjQgODo0MiBBTQ0KPiBUbzogRGFuIEp1cmdlbnMgPGRhbmllbGpAbnZp
ZGlhLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBq
YXNvd2FuZ0ByZWRoYXQuY29tOyB4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXguZGV2OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpl
dEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBKaXJpIFBp
cmtvDQo+IDxqaXJpQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQg
djMgNS82XSB2aXJ0aW9fbmV0OiBBZGQgYSBsb2NrIGZvciBwZXIgcXVldWUgUlgNCj4gY29hbGVz
Y2UNCj4gDQo+IA0KPiANCj4g5ZyoIDIwMjQvNC8xMyDkuIrljYgzOjUzLCBEYW5pZWwgSnVyZ2Vu
cyDlhpnpgZM6DQo+ID4gT25jZSB0aGUgUlROTCBsb2NraW5nIGFyb3VuZCB0aGUgY29udHJvbCBi
dWZmZXIgaXMgcmVtb3ZlZCB0aGVyZSBjYW4NCj4gPiBiZSBjb250ZW50aW9uIG9uIHRoZSBwZXIg
cXVldWUgUlggaW50ZXJydXB0IGNvYWxlc2NpbmcgZGF0YS4gVXNlIGENCj4gPiBzcGluIGxvY2sg
cGVyIHF1ZXVlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEp1cmdlbnMgPGRhbmll
bGpAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8
IDIzICsrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgaW5kZXgNCj4gPiBi
M2FhNGQyYTE1ZTkuLjg3MjRjYWE3YzJlZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMNCj4gPiBAQCAt
MTkwLDYgKzE5MCw3IEBAIHN0cnVjdCByZWNlaXZlX3F1ZXVlIHsNCj4gPiAgIAl1MzIgcGFja2V0
c19pbl9uYXBpOw0KPiA+DQo+ID4gICAJc3RydWN0IHZpcnRuZXRfaW50ZXJydXB0X2NvYWxlc2Nl
IGludHJfY29hbDsNCj4gPiArCXNwaW5sb2NrX3QgaW50cl9jb2FsX2xvY2s7DQo+ID4NCj4gPiAg
IAkvKiBDaGFpbiBwYWdlcyBieSB0aGUgcHJpdmF0ZSBwdHIuICovDQo+ID4gICAJc3RydWN0IHBh
Z2UgKnBhZ2VzOw0KPiA+IEBAIC0zMDg3LDExICszMDg4LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5l
dF9zZXRfcmluZ3BhcmFtKHN0cnVjdA0KPiBuZXRfZGV2aWNlICpkZXYsDQo+ID4gICAJCQkJcmV0
dXJuIGVycjsNCj4gPg0KPiA+ICAgCQkJLyogVGhlIHJlYXNvbiBpcyBzYW1lIGFzIHRoZSB0cmFu
c21pdCB2aXJ0cXVldWUgcmVzZXQNCj4gKi8NCj4gPiAtCQkJZXJyID0gdmlydG5ldF9zZW5kX3J4
X2N0cmxfY29hbF92cV9jbWQodmksIGksDQo+ID4gLQkJCQkJCQkgICAgICAgdmktDQo+ID5pbnRy
X2NvYWxfcngubWF4X3VzZWNzLA0KPiA+IC0JCQkJCQkJICAgICAgIHZpLQ0KPiA+aW50cl9jb2Fs
X3J4Lm1heF9wYWNrZXRzKTsNCj4gPiAtCQkJaWYgKGVycikNCj4gPiAtCQkJCXJldHVybiBlcnI7
DQo+ID4gKwkJCXNjb3BlZF9ndWFyZChzcGlubG9jaywgJnZpLT5ycVtpXS5pbnRyX2NvYWxfbG9j
aykgew0KPiA+ICsJCQkJZXJyID0gdmlydG5ldF9zZW5kX3J4X2N0cmxfY29hbF92cV9jbWQodmks
IGksDQo+ID4gKwkJCQkJCQkJICAgICAgIHZpLQ0KPiA+aW50cl9jb2FsX3J4Lm1heF91c2VjcywN
Cj4gPiArCQkJCQkJCQkgICAgICAgdmktDQo+ID5pbnRyX2NvYWxfcngubWF4X3BhY2tldHMpOw0K
PiA+ICsJCQkJaWYgKGVycikNCj4gPiArCQkJCQlyZXR1cm4gZXJyOw0KPiA+ICsJCQl9DQo+ID4g
ICAJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiBAQCAtMzUxMCw4ICszNTEzLDEwIEBAIHN0YXRpYyBp
bnQNCj4gdmlydG5ldF9zZW5kX3J4X25vdGZfY29hbF9jbWRzKHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpLA0KPiA+ICAgCXZpLT5pbnRyX2NvYWxfcngubWF4X3VzZWNzID0gZWMtPnJ4X2NvYWxlc2Nl
X3VzZWNzOw0KPiA+ICAgCXZpLT5pbnRyX2NvYWxfcngubWF4X3BhY2tldHMgPSBlYy0+cnhfbWF4
X2NvYWxlc2NlZF9mcmFtZXM7DQo+ID4gICAJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVf
cGFpcnM7IGkrKykgew0KPiA+IC0JCXZpLT5ycVtpXS5pbnRyX2NvYWwubWF4X3VzZWNzID0gZWMt
PnJ4X2NvYWxlc2NlX3VzZWNzOw0KPiA+IC0JCXZpLT5ycVtpXS5pbnRyX2NvYWwubWF4X3BhY2tl
dHMgPSBlYy0NCj4gPnJ4X21heF9jb2FsZXNjZWRfZnJhbWVzOw0KPiA+ICsJCXNjb3BlZF9ndWFy
ZChzcGlubG9jaywgJnZpLT5ycVtpXS5pbnRyX2NvYWxfbG9jaykgew0KPiA+ICsJCQl2aS0+cnFb
aV0uaW50cl9jb2FsLm1heF91c2VjcyA9IGVjLQ0KPiA+cnhfY29hbGVzY2VfdXNlY3M7DQo+ID4g
KwkJCXZpLT5ycVtpXS5pbnRyX2NvYWwubWF4X3BhY2tldHMgPSBlYy0NCj4gPnJ4X21heF9jb2Fs
ZXNjZWRfZnJhbWVzOw0KPiA+ICsJCX0NCj4gPiAgIAl9DQo+ID4NCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiBAQCAtMzU0Miw2ICszNTQ3LDcgQEAgc3RhdGljIGludA0KPiB2aXJ0bmV0X3NlbmRfcnhf
bm90Zl9jb2FsX3ZxX2NtZHMoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksDQo+ID4gICAJdTMyIG1h
eF91c2VjcywgbWF4X3BhY2tldHM7DQo+ID4gICAJaW50IGVycjsNCj4gPg0KPiA+ICsJZ3VhcmQo
c3BpbmxvY2spKCZ2aS0+cnFbcXVldWVdLmludHJfY29hbF9sb2NrKTsNCj4gPiAgIAltYXhfdXNl
Y3MgPSB2aS0+cnFbcXVldWVdLmludHJfY29hbC5tYXhfdXNlY3M7DQo+ID4gICAJbWF4X3BhY2tl
dHMgPSB2aS0+cnFbcXVldWVdLmludHJfY29hbC5tYXhfcGFja2V0czsNCj4gPg0KPiA+IEBAIC0z
NjA2LDYgKzM2MTIsNyBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3J4X2RpbV93b3JrKHN0cnVjdA0K
PiB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiAgIAlpZiAoIXJxLT5kaW1fZW5hYmxlZCkNCj4gPiAg
IAkJZ290byBvdXQ7DQo+IA0KPiBXZSBzaG91bGQgYWxzbyBwcm90ZWN0IHJxLT5kaW1fZW5hYmxl
ZCBhY2Nlc3MsIGluY29ycmVjdCB2YWx1ZXMgbWF5IGJlDQo+IHJlYWQgaW4gcnhfZGltX3dvcmtl
ciBiZWNhdXNlIGl0IGlzIG1vZGlmaWVkIGluDQo+IHNldF9jb2FsZXNjZS9zZXRfcGVyX3F1ZXVl
X2NvYWxlc2NlLg0KDQpHb29kIHBvaW50LiBUaGFua3MNCg0KPiANCj4gVGhhbmtzLg0KPiANCj4g
Pg0KPiA+ICsJZ3VhcmQoc3BpbmxvY2spKCZycS0+aW50cl9jb2FsX2xvY2spOw0KPiA+ICAgCXVw
ZGF0ZV9tb2RlciA9IG5ldF9kaW1fZ2V0X3J4X21vZGVyYXRpb24oZGltLT5tb2RlLCBkaW0tDQo+
ID5wcm9maWxlX2l4KTsNCj4gPiAgIAlpZiAodXBkYXRlX21vZGVyLnVzZWMgIT0gcnEtPmludHJf
Y29hbC5tYXhfdXNlY3MgfHwNCj4gPiAgIAkgICAgdXBkYXRlX21vZGVyLnBrdHMgIT0gcnEtPmlu
dHJfY29hbC5tYXhfcGFja2V0cykgeyBAQCAtMzc1Niw2DQo+ID4gKzM3NjMsNyBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfZ2V0X3Blcl9xdWV1ZV9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZQ0KPiAq
ZGV2LA0KPiA+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gPg0KPiA+ICAgCWlmICh2aXJ0aW9faGFz
X2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9WUV9OT1RGX0NPQUwpKSB7DQo+ID4gKwkJ
Z3VhcmQoc3BpbmxvY2spKCZ2aS0+cnFbcXVldWVdLmludHJfY29hbF9sb2NrKTsNCj4gPiAgIAkJ
ZWMtPnJ4X2NvYWxlc2NlX3VzZWNzID0gdmktPnJxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3VzZWNz
Ow0KPiA+ICAgCQllYy0+dHhfY29hbGVzY2VfdXNlY3MgPSB2aS0NCj4gPnNxW3F1ZXVlXS5pbnRy
X2NvYWwubWF4X3VzZWNzOw0KPiA+ICAgCQllYy0+dHhfbWF4X2NvYWxlc2NlZF9mcmFtZXMgPSB2
aS0NCj4gPnNxW3F1ZXVlXS5pbnRyX2NvYWwubWF4X3BhY2tldHM7DQo+ID4gQEAgLTQ1MDEsNiAr
NDUwOSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9hbGxvY19xdWV1ZXMoc3RydWN0DQo+ID4gdmly
dG5ldF9pbmZvICp2aSkNCj4gPg0KPiA+ICAgCQl1NjRfc3RhdHNfaW5pdCgmdmktPnJxW2ldLnN0
YXRzLnN5bmNwKTsNCj4gPiAgIAkJdTY0X3N0YXRzX2luaXQoJnZpLT5zcVtpXS5zdGF0cy5zeW5j
cCk7DQo+ID4gKwkJc3Bpbl9sb2NrX2luaXQoJnZpLT5ycVtpXS5pbnRyX2NvYWxfbG9jayk7DQo+
ID4gICAJfQ0KPiA+DQo+ID4gICAJcmV0dXJuIDA7DQoNCg==

