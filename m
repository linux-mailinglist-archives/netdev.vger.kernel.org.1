Return-Path: <netdev+bounces-87258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18D8A25AC
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91C81284D9B
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F292BDDA9;
	Fri, 12 Apr 2024 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nur27OUs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C41BDCE
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 05:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899336; cv=fail; b=mgXL/aaCQBNjh1hEUEeQ3BgQ7LAOOq6vxsD5Ebo3CoPsAvM6A2BU3DIq2w+rw3n/NipbxBaXYiQqQAOguwI5jfZ/Ly+CBfj75+skMsfrZ626W+cO2ya4ftDD992nf7KduE/G69kD0HE/ITkJ4N9uxEI+vTSSy/mdYI3JPZxCcBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899336; c=relaxed/simple;
	bh=3Q8DY89XcR/tjtNBkrdxtGIZ76K6YFOcb++olZ0EnUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hk2aL7xqdNnJfPiion4rjBuRz2iugMd0KjT43ZM1J8RY0PTD6nGffnnZkgFF1KW9Gcjd179k617bboIVTXc4P3RxV0zQ1m+Q9418eZuxsTn/960GEdxVsaVKM7gDLn3hgS2gLzdVSkekWSyEEl3zlC1iTSb6LVYrGbGKZVIEVvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nur27OUs; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT1B+Vbi6b14a+hjf6QhreCPsSsTfvnQvQvWYHc1Ega6rc6jvxRvlMQuYIFyKiongbYZoXwrwC2+irKjBuDkeC/LtbXJbT5/7tnqRcCb1pzUwwChxaO57TWU62bCal/rZN63NqYljHtzRhJD+2VzhtkeIpL/QXZoIwbRF0lEtWLcx+tP/D5CN5kBP7H6AVmkSV7opMWfTsIQzdJ5ipybzgOXcbbACIGQ1Zp/KpW7CCKJXiOtLvJTYPkLJhDMQiY6sja0TnfIwRkNT40Dx5M6wttyw7PJ0DWO1QudYRkmLRQ/Uc/bUzus5CQAjfkYl7rBNWwzfoTzSkGehj5/ZOHcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q8DY89XcR/tjtNBkrdxtGIZ76K6YFOcb++olZ0EnUE=;
 b=QEu9g/6A3FMVOqkIt1HRC2dXUzeAqR3Ikr0wmXc6xnuE4oyXPs+Hf+P43kZY5nBlNpero+C4h7cEx5N88cN/40yTm6vSIcZs08xJN14058BFcTopu64GiF4G+KM1hXL/5QGLsfzg7Z7Wiqr9Ix7NZ3h5G3mhMZDK2KyiuPkoCKkujkkxdbEb8D2J31x4QhsVcdIdNLxSJTN/MbZj/nOv+qYbcFpgD4CSzFmCLwGoSCcyzA882G7AgwVdvMVnAW8qbDzPf4oVn3BeMGm3TBU/qCAsee+osNTuOmryIRIVPty64TsBG8Q87sQKyfZH4v05jAGxgWHzVqgwn+DEhmOjZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q8DY89XcR/tjtNBkrdxtGIZ76K6YFOcb++olZ0EnUE=;
 b=nur27OUsLcgfRG4KvpIW76wcAX5werJ5sIF7gDxBfA8N9th6SpGclUWnT843aVJl1S7ETzrcZMRlSvcVN76WhcBZjF/l5ClGPEsy9dk15p0yjT2b6qJDKRlZXHuFei8Ahd77d/HkSByviKrV2PSClyxyKCdLQeJ33YhiJ9WFQH+w7KMOdwLGBalYrZKAk4fnCdPpe6Tj2q29Dxq/BLBIOET7KZje/VTG6JfT2IbvxG11dQ10r3++2gTlh11404X527qMZdnjtDsksEIVt4ydw+/+4LM32CX46iO7pHE7VfZRMBM0gN02hLwOElV883sE8pEjRksOhjz+iUSrLjsoFw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 05:22:11 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Fri, 12 Apr 2024
 05:22:10 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@kernel.org>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: RE: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Topic: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Index:
 AQHaiz6PozPVAHS/rUiy5XxYWBlFb7FiJW0AgAAz45CAAVlCAIAAMvKAgAAT/9CAACHC8A==
Date: Fri, 12 Apr 2024 05:22:10 +0000
Message-ID:
 <PH0PR12MB5481B04C5E22E7DECE8879B0DC042@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
 <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
 <PH0PR12MB5481F29AC423C4723F57318BDC042@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB5481F29AC423C4723F57318BDC042@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB8081:EE_
x-ms-office365-filtering-correlation-id: 88d66f68-1356-47f2-fbfd-08dc5ab08147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n9ng555kzBFSeTjMHMSHulY0RbZqh0Pe7juFGkz24NMQBTR2/giXg+hjcFKdi5cCiVvJ3prQ9bbWvwZZa5up4VaEtMp/iQ0B5uQ1eNoxj/rzHmFedWgG8II96UYuj2tfPk69HdNaNiftrGXoB15d2VM7Fo9fdriiNYNLVYzhLM+JTjv+3DYFKpHGfjYx/OU02+te49O7A91wovEiJIdRWOEUIWIk609dKHPxU1g9mQt3pOUF3clTnedyZ2OrEBG7+J+mKuLoVfhDPVpqs+Mr/C64UdsbbcenAI1OYeDwoqX3UuTYTVzXERfn7Gg+MH6D2hwZRTd4bTgGl6okyqz4zMw5fhVwzslEOP6YrtPB0WKhB0Rp7rp7oh1hwYSEdLKUHvrYjGRhy4CGMfHiWDyDRsfClr54TIdSQe4qJ9wsUbV/ddCApqrISymLdqb1JPvumegfW6MJQAsLVnk+RmlIfrbYC8WQggIpsTjhcOPoxMMIN9vKbdLWDwyBZG/0ha85ZTgTQ3t2F0I3SnayOcN+ttFRMRmsE8XKt7U5PcRj/YwyUiGq1F6+6vEqPoAbSHfFH5g4r0Ik+58P6/5gfhxrOjbM89GDhfjfCB0WSxv6BpjH6xM16s0yk81iVXX+LHa4l9iKdsqU6kqzfb/KM0v5Wg0Wray6F+shSh8TnuMODy/pB9xVeqbrlScOpgf8iQLAKPJGCfK1cUjD0mMHrGoGsQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzUzUGd5eHZ5OXZNNEhHTXh4SGs5WE9Uamp6SkcrUVhQVVV3UEYycWJYZWhQ?=
 =?utf-8?B?djI0OFh4K0pGQkJTamU0UUxXNTRBcU5kS3J5YmVxSGFpM05TSzlOTmE4TzIv?=
 =?utf-8?B?TlZ6YUZRWlo0d1RvL3J4RUZPaFZjMVovOCs5RWMyUEY3RVBROUw0WnY0QlIy?=
 =?utf-8?B?Z084eW1tc3FMaDVYd1NQUlFPS3A5RjhkVjhjcVBWUzhYNXFvV3MrVStTTmZN?=
 =?utf-8?B?ckhVN1RjNE40Uk9BU0F4Mm5MNTB0T3pENW43bVBvK29ndWhtUHlaNXU5aThJ?=
 =?utf-8?B?V0FYVGErUC9PSlVxK2pmbEZJbVpGSTZjMXVsN01MOStXeWZkZ0xrMm9WQWN6?=
 =?utf-8?B?cS8vY0hLbEtCQm4vaWJpVmQwdFhpS2dlMEVlbFZUeDNlL1d4RlVKb0Y2R3ov?=
 =?utf-8?B?MFZaNUJHVmhxSlpjRmk1YUhkak91TmVpSkZRR0pwcW5uejFJcU1scE41cnlL?=
 =?utf-8?B?T1NxMmJCNmpjTURheFFvdUtMQTA0Ky9UczUwTFVmSWFjbWpReUdIYUR4OHdG?=
 =?utf-8?B?ck9GaWxHNHcyN25vOEtKNjRVRU5vU1F2QW9rYnIxZDZNMGEwZjJQOXlsL3lk?=
 =?utf-8?B?bE9tUWRLc2pra29GS3lZcC9XaEc5OHVqUW1yUVNpUHk5R0xPV21VZnhKd2hV?=
 =?utf-8?B?TjBmc2RYZHlvQU5RejhtZEY0dWp0VXE2V0NtdnNRZ0JKN2dBSFVySDZYRjRl?=
 =?utf-8?B?WTFXVGJjNDRBQ01Ra1NzenBMT2l0QWt1UE1LclBOV3dsai9ycCtaaDUyOUlP?=
 =?utf-8?B?bnhxMGtvTFpwdlpXK1VRTUlwS2g1Zm9BNGcvQllSK2JZN2NlNTdvQXhaSTFr?=
 =?utf-8?B?SzdFcFZ0SVJPdGdBSUszMGg2eUxvWXlGQ3ZnTU00ak83bmx6ZENMU0ZScWhQ?=
 =?utf-8?B?cE1LcE1WRU9JU3piZEw2OU5tenlZTk9NQVJTTzdjeTR2SFNPcFFqNVZzM28v?=
 =?utf-8?B?MW4vSU94dzdUMTU2WjIxQ3p0SU81YkhidUk1SVd6V0kxci9Sb3dBditCSmhI?=
 =?utf-8?B?ZERNbWwwTVhVa2dMbGR5T1lhRjNVUU8yRWdHR2xSeFZxREFCV2x2VlZ0VUYx?=
 =?utf-8?B?UzE1eDVHZjBINjdLZ3A5TDNmd05rdGVBd0lRMEpCVXUwbit6NTNxVVkvOUNU?=
 =?utf-8?B?K0xTaWZUNk9sQ2JRUElxMTlwTGpxekxZazN2QkNoK3VpQ0xEbVY0QWFDYUJV?=
 =?utf-8?B?dlMzMUZGamVQQVNnL1hOK044aUpDMThtNERsWGk3NTRsK2JZT2pVN3BFbUF0?=
 =?utf-8?B?MVlrQ2doeW1VRHpVM2Ftc3FiTXFIRzlmbmpIdm9OaFpyRGhOSXhJc1ZWTE45?=
 =?utf-8?B?SFd2dGp1VDRUOG5vbi83NittOXFuYXpQV2ovREp1NFZPTVZDUUMxOWRsMFpZ?=
 =?utf-8?B?Tlo1cnRXZExVMlZpbE1ZQ3hKTTl2anRLQmkwNzFlT0tRemtvdjRYRVdGZjBH?=
 =?utf-8?B?Tkg0ai9DMmxVcVliQUpyS25QeUNXWDZMWXZjOFpGK0ZzemQvNFROQVBIZFpq?=
 =?utf-8?B?emxpMTlpWi9UU1BvVGdnczVsTFZKNjhra0ZYYmFOeFhaOUZVSkVhajBNalZG?=
 =?utf-8?B?MU1uS25xVy9tMUlBVFR3Z3orNFJUMURRL2UzQzNRTDhrajM4ZDFmbExSV0Mv?=
 =?utf-8?B?c3ZTYWYwMW0rdE1zQ1VmM2tqUmlHcWkxc0xWK2FQT1JhSUJsMW0rdHFWR1N0?=
 =?utf-8?B?aG5SODJGUk5PL1ZYcHpnRzFSNDhaMThaOVhJajl6UDJmVms5ZjQwamhIWklS?=
 =?utf-8?B?OUovS2M4UUlXQTRGYlBKL0dLVjZtSlFYL2ZzQkpaQzhsbmRvN1hZT290aGpn?=
 =?utf-8?B?R2t4VkZyTnRmN2hTWUdiOWZmQnRvNDBWSXBKT3o3L2lMN0M3MUJQL1BjSC9B?=
 =?utf-8?B?QkVwTjkzU3RUKzFhTjJNaUoreGIzcmxUblRndGxpeEVnT3NUNmhtRm50ZjR4?=
 =?utf-8?B?blo0RklFUWZldDhzT2ttU0YwREcwaUpCaGRseURoZXpOVE1qSUVSMVYxb21Z?=
 =?utf-8?B?eGZlWWxsR01oVXFRZWN4c1Q0SE5QSWZmM2tvdkd4RVpYRkNLSVA0T08rRVow?=
 =?utf-8?B?cHAzd0svV2g0WnluOCtUR3NJTkQyNzNZUndBRVJhM1hlUGhuRDQyNTBUZzh4?=
 =?utf-8?Q?HcLc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d66f68-1356-47f2-fbfd-08dc5ab08147
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 05:22:10.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ir75CiQd4To9fYedzkejgmo1N/qYi5G9jdyFA5AEEo9FPJairgKvLYd04sOmZ6AOBn8fnyzkSSRcsGSp8Bf7Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081

DQo+IEZyb206IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBBcHJpbCAxMiwgMjAyNCA5OjAyIEFNDQo+IA0KPiBIaSBEYXZpZCwgU3JpZGhhciwNCj4gDQo+
ID4gRnJvbTogRGF2aWQgQWhlcm4gPGRzYWhlcm5Aa2VybmVsLm9yZz4NCj4gPiBTZW50OiBGcmlk
YXksIEFwcmlsIDEyLCAyMDI0IDc6MzYgQU0NCj4gPg0KPiA+IE9uIDQvMTEvMjQgNTowMyBQTSwg
U2FtdWRyYWxhLCBTcmlkaGFyIHdyb3RlOg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiA0LzEwLzIw
MjQgOTozMiBQTSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+ID4+IEhpIFNyaWRoYXIsDQo+ID4g
Pj4NCj4gPiA+Pj4gRnJvbTogU2FtdWRyYWxhLCBTcmlkaGFyIDxzcmlkaGFyLnNhbXVkcmFsYUBp
bnRlbC5jb20+DQo+ID4gPj4+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCA0OjUzIEFN
DQo+ID4gPj4+DQo+ID4gPj4+DQo+ID4gPj4+IE9uIDQvMTAvMjAyNCA2OjU4IEFNLCBQYXJhdiBQ
YW5kaXQgd3JvdGU6DQo+ID4gPj4+PiBEZXZpY2VzIHNlbmQgZXZlbnQgbm90aWZpY2F0aW9ucyBm
b3IgdGhlIElPIHF1ZXVlcywgc3VjaCBhcyB0eA0KPiA+ID4+Pj4gYW5kIHJ4IHF1ZXVlcywgdGhy
b3VnaCBldmVudCBxdWV1ZXMuDQo+ID4gPj4+Pg0KPiA+ID4+Pj4gRW5hYmxlIGEgcHJpdmlsZWdl
ZCBvd25lciwgc3VjaCBhcyBhIGh5cGVydmlzb3IgUEYsIHRvIHNldCB0aGUNCj4gPiA+Pj4+IG51
bWJlciBvZiBJTyBldmVudCBxdWV1ZXMgZm9yIHRoZSBWRiBhbmQgU0YgZHVyaW5nIHRoZQ0KPiA+
ID4+Pj4gcHJvdmlzaW9uaW5nDQo+ID4gc3RhZ2UuDQo+ID4gPj4+DQo+ID4gPj4+IEhvdyBkbyB5
b3UgcHJvdmlzaW9uIHR4L3J4IHF1ZXVlcyBmb3IgVkZzICYgU0ZzPw0KPiA+ID4+PiBEb24ndCB5
b3UgbmVlZCBzaW1pbGFyIG1lY2hhbmlzbSB0byBzZXR1cCBtYXggdHgvcnggcXVldWVzIHRvbz8N
Cj4gPiA+Pg0KPiA+ID4+IEN1cnJlbnRseSB3ZSBkb27igJl0LiBUaGV5IGFyZSBkZXJpdmVkIGZy
b20gdGhlIElPIGV2ZW50IHF1ZXVlcy4NCj4gPiA+PiBBcyB5b3Uga25vdywgc29tZXRpbWVzIG1v
cmUgdHhxcyB0aGFuIElPIGV2ZW50IHF1ZXVlcyBuZWVkZWQgZm9yDQo+ID4gPj4gWERQLCB0aW1l
c3RhbXAsIG11bHRpcGxlIFRDcy4NCj4gPiA+PiBJZiBuZWVkZWQsIHByb2JhYmx5IGFkZGl0aW9u
YWwga25vYiBmb3IgdHhxLCByeHEgY2FuIGJlIGFkZGVkIHRvDQo+ID4gPj4gcmVzdHJpY3QgZGV2
aWNlIHJlc291cmNlcy4NCj4gPiA+DQo+ID4gPiBSYXRoZXIgdGhhbiBkZXJpdmluZyB0eCBhbmQg
cnggcXVldWVzIGZyb20gSU8gZXZlbnQgcXVldWVzLCBpc24ndCBpdA0KPiA+ID4gbW9yZSB1c2Vy
IGZyaWVuZGx5IHRvIGRvIHRoZSBvdGhlciB3YXkuIExldCB0aGUgaG9zdCBhZG1pbiBzZXQgdGhl
DQo+ID4gPiBtYXggbnVtYmVyIG9mIHR4IGFuZCByeCBxdWV1ZXMgYWxsb3dlZCBhbmQgdGhlIGRy
aXZlciBkZXJpdmUgdGhlDQo+ID4gPiBudW1iZXIgb2YgaW9ldmVudCBxdWV1ZXMgYmFzZWQgb24g
dGhvc2UgdmFsdWVzLiBUaGlzIHdpbGwgYmUNCj4gPiA+IGNvbnNpc3RlbnQgd2l0aCB3aGF0IGV0
aHRvb2wgcmVwb3J0cyBhcyBwcmUtc2V0IG1heGltdW0gdmFsdWVzIGZvcg0KPiA+ID4gdGhlIGNv
cnJlc3BvbmRpbmcNCj4gPiBWRi9TRi4NCj4gPiA+DQo+ID4NCj4gPiBJIGFncmVlIHdpdGggdGhp
cyBwb2ludDogSU8gRVEgc2VlbXMgdG8gYmUgYSBtbHg1IHRoaW5nIChvciBtYXliZSBJDQo+ID4g
aGF2ZSBub3QgcmV2aWV3ZWQgZW5vdWdoIG9mIHRoZSBvdGhlciBkcml2ZXJzKS4NCj4gDQo+IElP
IEVRcyBhcmUgdXNlZCBieSBobnMzLCBtYW5hLCBtbHg1LCBtbHhzdywgYmUybmV0LiBUaGV5IG1p
Z2h0IG5vdCB5ZXQgaGF2ZQ0KPiB0aGUgbmVlZCB0byBwcm92aXNpb24gdGhlbS4NCj4gDQo+ID4g
UnggYW5kIFR4IHF1ZXVlcyBhcmUgYWxyZWFkeSBwYXJ0IG9mDQo+ID4gdGhlIGV0aHRvb2wgQVBJ
LiBUaGlzIGRldmxpbmsgZmVhdHVyZSBpcyBhbGxvd2luZyByZXNvdXJjZSBsaW1pdHMgdG8NCj4g
PiBiZSBjb25maWd1cmVkLCBhbmQgYSBjb25zaXN0ZW50IEFQSSBhY3Jvc3MgdG9vbHMgd291bGQg
YmUgYmV0dGVyIGZvciB1c2Vycy4NCj4gDQo+IElPIEVxcyBvZiBhIGZ1bmN0aW9uIGFyZSB1dGls
aXplZCBieSB0aGUgbm9uIG5ldGRldiBzdGFjayBhcyB3ZWxsIGZvciBhIG11bHRpLQ0KPiBmdW5j
dGlvbmFsaXR5IGZ1bmN0aW9uIGxpa2UgcmRtYSBjb21wbGV0aW9uIHZlY3RvcnMuDQo+IFR4cSBh
bmQgcnhxIGFyZSB5ZXQgYW5vdGhlciBzZXBhcmF0ZSByZXNvdXJjZSwgc28gaXQgaXMgbm90IG11
dHVhbGx5IGV4Y2x1c2l2ZQ0KPiB3aXRoIElPIEVRcy4NCj4gDQo+IEkgY2FuIGFkZGl0aW9uYWxs
eSBhZGQgdHhxIGFuZCByeHEgcHJvdmlzaW9uaW5nIGtub2IgdG9vIGlmIHRoaXMgaXMgdXNlZnVs
LCB5ZXM/DQo+IA0KPiBTcmlkaGFyLA0KPiBJIGRpZG7igJl0IGxhdGVseSBjaGVjayBvdGhlciBk
cml2ZXJzIGhvdyB1c2FibGUgaXMgaXQsIHdpbGwgeW91IGFsc28gaW1wbGVtZW50DQo+IHRoZSB0
eHEsIHJ4cSBjYWxsYmFja3M/DQo+IFBsZWFzZSBsZXQgbWUga25vdyBJIGNhbiBzdGFydCB0aGUg
d29yayBsYXRlciBuZXh0IHdlZWsgZm9yIHRob3NlIGFkZGl0aW9uYWwNCj4ga25vYnMuDQoNCkkg
YWxzbyBmb3Jnb3QgdG8gZGVzY3JpYmUgaW4gYWJvdmUgcmVwbHkgdGhhdCBzb21lIGRyaXZlciBs
aWtlIG1seDUgY3JlYXRlcyBpbnRlcm5hbCB0eCBhbmQgcnhxcyBub3QgZGlyZWN0bHkgdmlzaWJs
ZSBpbiBjaGFubmVscywgZm9yIHhkcCwgdGltZXN0YW1wLCBmb3IgdHJhZmZpYyBjbGFzc2VzLCBk
cm9wcGluZyBjZXJ0YWluIHBhY2tldHMgb24gcngsIGV0Yy4NClNvIGV4YWN0IGRlcml2YXRpb24g
b2YgaW8gcXVldWVzIGlzIGFsc28gaGFyZCB0aGVyZS4NCg0KUmVnYXJkbGVzcyB0byBtZSwgYm90
aCBrbm9icyBhcmUgdXNlZnVsLCBhbmQgZHJpdmVyIHdpbGwgY3JlYXRlIG1pbigpIHJlc291cmNl
IGJhc2VkIG9uIGJvdGggdGhlIGRldmljZSBsaW1pdHMuDQoNCg==

