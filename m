Return-Path: <netdev+bounces-87251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85A8A246D
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 05:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C6B21150
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077D7175AE;
	Fri, 12 Apr 2024 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZTJPK88A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902B2F4A
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 03:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892735; cv=fail; b=kOvUPcNx/B8bh9kHUkXEPbrOJElgFwUFKuK/vfdX3pnDQwn94PCrYzxkp37NBTUOt4X3QWr4D8Z6zTO8O4kioPYK1iJOAsmp41IMh01lBugVMHDH25CTYbvfNJKtCtFppTpPnBRveMVCHWquwgHbeDVyE/zUU60DRhspQ5x6eoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892735; c=relaxed/simple;
	bh=6m7b2jgYQrtpyu4HaeFR0lPU/9+dgu4d2YByoBirVCM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=muklKJumst5oofvaoBP6fm9MfWKFlfkeR2t4uXhit4sVkRoYiAeVvx6/7TMYem37HrlywFXLeMFq1Z16GqWSiNbggDXk3DzZuet9i48ZkbkVlsjgbIySSkTtz3TU+3tmn8jdPrHZrLeer+gpJm28CsY4GsQXkkPdLyQ1qzXENi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZTJPK88A; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj6w/oW3Y2uGuIyAbskoa5jwOP17sQUwWLjPYcRaZ9JzT92/v+lzLUlGuUT/hHH3jN8kIGzNggDMpn7OWXMDYiBINfe9hD45Lt5EFdqJgdOQE/xzGrIRS/RIIznIjYuJsNF/kF6jSHO2UTwfxkasvm7IxILuJBNKiO52ioKxaayQWOhnbjpYMXCMMXZyyLgeBes3StwNNFORsBKgWCNmLzyJqENx0Nd6+3KeOdzMrIzRjVuKQRkkgSnWRTb4zEyoziSDkWk7kmjB3bn5uYCkB6gygnLCcmg0SHrhCX9nkV3IcqrOGPw5Alc5QlkEyn/1PjDgdhjsFgs0g1Hvs4LQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6m7b2jgYQrtpyu4HaeFR0lPU/9+dgu4d2YByoBirVCM=;
 b=f4khcf+wZ0OrAiZHU93kAAB+tTwXK5cmkBEf2C+WCJ9OoIPvNrF9JuppcUr2BovVGWMfS5IBIxzIEURmecEaCU3nggUcA593ARifZhc3USXMV/RqtAD7Pgdh0LGhJWVN6+bhm5sVcBXPHInjXETNQjgh/LqmPQocNsam84vu6U+xLlSSgo/mPznBzatU5MGkOjBIIxMtO7VIAL6iMJcLeseDSXrGKUn7BxrqaBKGF7QKX1pxVc3j1kGTFKXzsaqJWOvY4SohHpmGSUF3UNOPLVP156KFzbpMCDYq6K16Y+WhQLb4bojisNlk/4Fj6+6W4ZCDxOLGBTU3uASX/wg7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6m7b2jgYQrtpyu4HaeFR0lPU/9+dgu4d2YByoBirVCM=;
 b=ZTJPK88ARsaLmbtFCnbU6V9GNCYBhMNPJSWdK1cnZIaUyvYPu8yTWHtUgKDvX4DeSmetwTa5E6FtfAkE8LNVeu0deudAoRdaOxWpBBmNfSbJvLPpD0e7dNShy0MAYVR9BZVziXCWiNt1iUeg8NZh/+pClLH3guYABHQ6sz2A9LdAeP1n5lCRUwALPNeNyHjSbMEYKH7aJz0KZ2ecR9jhZK5mzighYqYAjpv/z3CvMiTPg3LDrvnypJg3mTRI/qqIx8JQ3mqkmNsb+ExyAUUCXSopZpVkfbHh2loTeBNtGBmkIlYF2oalOh/e9i3RfNwTGxMmFwIHMJZ0eqRKbG/AhA==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 03:31:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::65d2:19a0:95b8:9490%5]) with mapi id 15.20.7409.046; Fri, 12 Apr 2024
 03:31:53 +0000
From: Parav Pandit <parav@nvidia.com>
To: David Ahern <dsahern@kernel.org>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: RE: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Topic: [PATCH v2 0/2] devlink: Support setting max_io_eqs
Thread-Index: AQHaiz6PozPVAHS/rUiy5XxYWBlFb7FiJW0AgAAz45CAAVlCAIAAMvKAgAAT/9A=
Date: Fri, 12 Apr 2024 03:31:53 +0000
Message-ID:
 <PH0PR12MB5481F29AC423C4723F57318BDC042@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
 <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
 <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
In-Reply-To: <68b0f6e2-6890-46f9-b824-2af5ba5f9fd4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6436:EE_
x-ms-office365-filtering-correlation-id: 5bb6aed3-dd9d-4f32-5cd9-08dc5aa11939
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vITFpW+nkQYHp952a6m0Y7ScPo1izpJWYtSY0mDbOUxwBFP5qNHyESD8Lg6z6A9v6Px2iRvMulZszxkQzjmIFYcNgZYF1y7bKwZjHemWDKYMIa7Q4VHKnAkfOWWHtfPrzUX09vY/j4FGgpoa05zxGndWGbL8NWyQuZ3N6wLLrqSqx1I2DoQdN66W6nuZQT7YrmafwA2fbsmlnegXH3+LahK18LXE24DfMiE3HVX5ad0pri4q9r7923ZbpIyGHg3+oQ/nngSwcpx52hAbxugmA9uUcfbCSZmA6Qk48pT1kgBSKxHYKMLW25NDel8aTRni40fQdDBj6k5ZSJmD1ulc/2KfLbxz0lIKzzmeNRUXZIYvfPLc+GXFeux4dGlQY0gACt1xaFXyuNbusmqEMnLi7iyYk0HWG2B6VxmfmBD9IuRdrlipCgVmQixmH+ralHZknXnEzxBNCJDLItZD3k5jq3kQE9uPjAA1DWLr0JkhhFQqMmOQ3mEFBbI0TrDSZ9YGP9urg02RZ/do0FA7zA+K70EM9bNeKdbxTUEL9YFD/zoLUb+Uot3/iAGFe9EnxBBFv9VlY6XsLPrzvNUDyBngmg1/Vd8Z9DDBnsDBuA7cVt39n4x7bQ2uZDE4c2KsWctPrFih3FsL7EI1FaW0Vbix4+TJjM76UEKZ6O9GQ5fx9D7950UJowSfZ3+A2Bd+Vv0UcRTF0ED2ekTNFSF17tI8Hw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDlhZkw3a2tSNU9ReGdmMDQwUEZSem1yRm5tZ3k2RE9IRWRQQjByRFM2TXUx?=
 =?utf-8?B?aVJEYmlQenExSXNJam42SG1HRHJTS0JSK1pMdTIzcCs0ZmFJeHlwY05odU5n?=
 =?utf-8?B?a0h6WGJRZ3VuMEUvblU2QUkxVnpndHRsam4xeGdvbzBha3YyTkRvRklZT2JE?=
 =?utf-8?B?VjRKRGU2YU14SXJqWUlMQTBWU2M0dUcrRU9pVmNoVERPc21STUcwTjRQSGhi?=
 =?utf-8?B?YmFmd0JzQjdXZ1Q4MjdZaG5Bd0hqa0FXaEY4UXZWb3Y5VDF3Z0Z4eDFCdXFD?=
 =?utf-8?B?RDhqU1B6L09yc2VrOFZVMUFVcWptVmlQaDk4cmtqQXl6SHU4SU11UmdQTWl4?=
 =?utf-8?B?QXdNS3V6M3BsdVhqd3NoMCt5UmRCQ0orRlhNd0hKOEtaekloU1VxVGZjNUdG?=
 =?utf-8?B?VWF3SnNaZnB0bnZoY2I0SkFaRHl6QzFSZWtDcURlMHRTbnBQaU1rVHR6eFIv?=
 =?utf-8?B?SUhlaWV3aHFjQXhpMHVhUlBYazRRTHhmUmpQMDI4Zkd0enpHSmtCb1hUZ0JN?=
 =?utf-8?B?UjNXemZMb3AxbXYzeXV1QXZjZnlUM2dmZU5WNmpFazVxRjZweWJUTUo0MlVs?=
 =?utf-8?B?a1Q4VFBONlN6Y1pML1NEcU9YMllGMXErcGg0cWdrTm9rZm45SndhZFZ2RE1Q?=
 =?utf-8?B?a1lQTjg5MEdMWUVCck9KV0JpRC8ySFloYUtVeUNMajRvSi82T053RHYzaGF1?=
 =?utf-8?B?dG9RcXd0NmUrYlYxd0s5NitFZnEyaGE1UThpZ0hoaDFLSzFSU2VkNXJ2Q2lu?=
 =?utf-8?B?S09Ba1NTT2psWEphUExvTG9QQzJqeE5rQ1orMEVyTlRqMi9zVzZEMUdjNDBD?=
 =?utf-8?B?YmdldWNMdWRkUjNsN0llZ2xtd21tTk1jVzdRVXdaYXZmWGV4R2Zva0JUZUNu?=
 =?utf-8?B?Qm9YVGdIVzI1N1pvT0JFbkg5YTRYVE1hbDk3QU9mSDRiVnhKSFZTWHJEVXBi?=
 =?utf-8?B?NnU1U3BpZG9rUHR4VU42YjNpN1RkeWFIOHRnWHp1RUhGVzA3Z25sMnVDTTFO?=
 =?utf-8?B?SHErNFk3Y1BqQzRNSXlkNElDMDFuR1dMemtBUEEvdGZZUGZucjlkNmZUOERV?=
 =?utf-8?B?MnhHbVVSS0xBaDdpYXFQR0xKVVZla2VGckNnZlNtWFFXdlhxcVp0ckx3bXow?=
 =?utf-8?B?Z0k2dnB1Q0VGQW1QRGd3YXB6TENiTVp3bTZkQ29zRkdrOVdhVXFLSWdQQjVG?=
 =?utf-8?B?V0F5ZzhqMHlQajJtSExnMmNXVis3aktQcXhKU2tyL0NlK1NnZmVrTG1YZi96?=
 =?utf-8?B?RWhYNzdnMXdJU3VaTFluRUNITUN0L0NKcS94M2xOK3Q2NS9rREJJb2RLREhi?=
 =?utf-8?B?dW90bURUbUNFSVBvMGZrbjhLczVPcjg2UWVZME1aSmZlbEY5aitVN3hIUWx1?=
 =?utf-8?B?SVFBc0hZZDJUbnlwUklhYlJEcmhmMmJ3YmN6djB6ZCtaazZBQ0lGZlhMNURQ?=
 =?utf-8?B?d1hJYmpoR2RBYURmbFJmN0x6QVJ3QjdJV1Q4N2pqWUVRNmNIVEhQS0ZNRUZt?=
 =?utf-8?B?WWJkMW9aaE1LR08wL2JNaDVyRzRTeEVGRnNXeFRiQ3lwQnVGREtOUVYxRXJq?=
 =?utf-8?B?QUFkOHRKM2xMK0wvV3E4VWl4UmxyUTZMMVFRbWFUSmFrRW1CVU5DZnp2Y2Rk?=
 =?utf-8?B?a2VXNGlVbFVKQzJUTUNwNm9MWU5CajJCazBGZUg3WFVnNS9DQW0rWjFlcmhE?=
 =?utf-8?B?VVl2ZG1kQnJOaE1mdDdaSXZ1Qmx0ZVhuV09KWFdUTmdGSXJVOFlYUXhLMGFn?=
 =?utf-8?B?QlE1dDJoYjRON3N4eVVDNEVjUCtwZjM1akdxOXAvdDhLRm1uOTM3b3hCbE5x?=
 =?utf-8?B?MHZxclBUQVdreWFjQWROY1dnWGVZMWZyVTVnWmxzQTE0bDZNeXVsaUZRWm1Q?=
 =?utf-8?B?azB2MlpyR29GMDZNaTlEc1RwaHN0RkdKRzNZdm5jaHpyZDFiYXRwUU9NYmhx?=
 =?utf-8?B?YmVVRXRQWFFxLzBrMUd5VENwb0NWSDMzY04xRkw4VTdwQmJmNU4yeWhJZmp0?=
 =?utf-8?B?L0JWcTJhR0lPK2xBYU9PUmw5UWVJYXVqL3d2b084L3FBT1dDV1pIdjlIVUs2?=
 =?utf-8?B?MVg4ZU5GQmRoN2xTSHpZc20wU0pyalY0cWJuaUc2dWM5TUZqakRlQlMxY3F3?=
 =?utf-8?Q?GBiE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb6aed3-dd9d-4f32-5cd9-08dc5aa11939
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 03:31:53.9145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DowTLvhOIxoPxLVY2qlVe62/ZX1GHJMquJAQzYxknG4w9ftKDxFUIVabgolWEFcLvDnsNJiUYLngW4bBRaIvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436

SGkgRGF2aWQsIFNyaWRoYXIsDQoNCj4gRnJvbTogRGF2aWQgQWhlcm4gPGRzYWhlcm5Aa2VybmVs
Lm9yZz4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMiwgMjAyNCA3OjM2IEFNDQo+IA0KPiBPbiA0
LzExLzI0IDU6MDMgUE0sIFNhbXVkcmFsYSwgU3JpZGhhciB3cm90ZToNCj4gPg0KPiA+DQo+ID4g
T24gNC8xMC8yMDI0IDk6MzIgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gSGkgU3JpZGhh
ciwNCj4gPj4NCj4gPj4+IEZyb206IFNhbXVkcmFsYSwgU3JpZGhhciA8c3JpZGhhci5zYW11ZHJh
bGFAaW50ZWwuY29tPg0KPiA+Pj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDQ6NTMg
QU0NCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gT24gNC8xMC8yMDI0IDY6NTggQU0sIFBhcmF2IFBhbmRp
dCB3cm90ZToNCj4gPj4+PiBEZXZpY2VzIHNlbmQgZXZlbnQgbm90aWZpY2F0aW9ucyBmb3IgdGhl
IElPIHF1ZXVlcywgc3VjaCBhcyB0eCBhbmQNCj4gPj4+PiByeCBxdWV1ZXMsIHRocm91Z2ggZXZl
bnQgcXVldWVzLg0KPiA+Pj4+DQo+ID4+Pj4gRW5hYmxlIGEgcHJpdmlsZWdlZCBvd25lciwgc3Vj
aCBhcyBhIGh5cGVydmlzb3IgUEYsIHRvIHNldCB0aGUNCj4gPj4+PiBudW1iZXIgb2YgSU8gZXZl
bnQgcXVldWVzIGZvciB0aGUgVkYgYW5kIFNGIGR1cmluZyB0aGUgcHJvdmlzaW9uaW5nDQo+IHN0
YWdlLg0KPiA+Pj4NCj4gPj4+IEhvdyBkbyB5b3UgcHJvdmlzaW9uIHR4L3J4IHF1ZXVlcyBmb3Ig
VkZzICYgU0ZzPw0KPiA+Pj4gRG9uJ3QgeW91IG5lZWQgc2ltaWxhciBtZWNoYW5pc20gdG8gc2V0
dXAgbWF4IHR4L3J4IHF1ZXVlcyB0b28/DQo+ID4+DQo+ID4+IEN1cnJlbnRseSB3ZSBkb27igJl0
LiBUaGV5IGFyZSBkZXJpdmVkIGZyb20gdGhlIElPIGV2ZW50IHF1ZXVlcy4NCj4gPj4gQXMgeW91
IGtub3csIHNvbWV0aW1lcyBtb3JlIHR4cXMgdGhhbiBJTyBldmVudCBxdWV1ZXMgbmVlZGVkIGZv
ciBYRFAsDQo+ID4+IHRpbWVzdGFtcCwgbXVsdGlwbGUgVENzLg0KPiA+PiBJZiBuZWVkZWQsIHBy
b2JhYmx5IGFkZGl0aW9uYWwga25vYiBmb3IgdHhxLCByeHEgY2FuIGJlIGFkZGVkIHRvDQo+ID4+
IHJlc3RyaWN0IGRldmljZSByZXNvdXJjZXMuDQo+ID4NCj4gPiBSYXRoZXIgdGhhbiBkZXJpdmlu
ZyB0eCBhbmQgcnggcXVldWVzIGZyb20gSU8gZXZlbnQgcXVldWVzLCBpc24ndCBpdA0KPiA+IG1v
cmUgdXNlciBmcmllbmRseSB0byBkbyB0aGUgb3RoZXIgd2F5LiBMZXQgdGhlIGhvc3QgYWRtaW4g
c2V0IHRoZSBtYXgNCj4gPiBudW1iZXIgb2YgdHggYW5kIHJ4IHF1ZXVlcyBhbGxvd2VkIGFuZCB0
aGUgZHJpdmVyIGRlcml2ZSB0aGUgbnVtYmVyIG9mDQo+ID4gaW9ldmVudCBxdWV1ZXMgYmFzZWQg
b24gdGhvc2UgdmFsdWVzLiBUaGlzIHdpbGwgYmUgY29uc2lzdGVudCB3aXRoDQo+ID4gd2hhdCBl
dGh0b29sIHJlcG9ydHMgYXMgcHJlLXNldCBtYXhpbXVtIHZhbHVlcyBmb3IgdGhlIGNvcnJlc3Bv
bmRpbmcNCj4gVkYvU0YuDQo+ID4NCj4gDQo+IEkgYWdyZWUgd2l0aCB0aGlzIHBvaW50OiBJTyBF
USBzZWVtcyB0byBiZSBhIG1seDUgdGhpbmcgKG9yIG1heWJlIEkgaGF2ZSBub3QNCj4gcmV2aWV3
ZWQgZW5vdWdoIG9mIHRoZSBvdGhlciBkcml2ZXJzKS4NCg0KSU8gRVFzIGFyZSB1c2VkIGJ5IGhu
czMsIG1hbmEsIG1seDUsIG1seHN3LCBiZTJuZXQuIFRoZXkgbWlnaHQgbm90IHlldCBoYXZlIHRo
ZSBuZWVkIHRvIHByb3Zpc2lvbiB0aGVtLg0KDQo+IFJ4IGFuZCBUeCBxdWV1ZXMgYXJlIGFscmVh
ZHkgcGFydCBvZg0KPiB0aGUgZXRodG9vbCBBUEkuIFRoaXMgZGV2bGluayBmZWF0dXJlIGlzIGFs
bG93aW5nIHJlc291cmNlIGxpbWl0cyB0byBiZQ0KPiBjb25maWd1cmVkLCBhbmQgYSBjb25zaXN0
ZW50IEFQSSBhY3Jvc3MgdG9vbHMgd291bGQgYmUgYmV0dGVyIGZvciB1c2Vycy4NCg0KSU8gRXFz
IG9mIGEgZnVuY3Rpb24gYXJlIHV0aWxpemVkIGJ5IHRoZSBub24gbmV0ZGV2IHN0YWNrIGFzIHdl
bGwgZm9yIGEgbXVsdGktZnVuY3Rpb25hbGl0eSBmdW5jdGlvbiBsaWtlIHJkbWEgY29tcGxldGlv
biB2ZWN0b3JzLg0KVHhxIGFuZCByeHEgYXJlIHlldCBhbm90aGVyIHNlcGFyYXRlIHJlc291cmNl
LCBzbyBpdCBpcyBub3QgbXV0dWFsbHkgZXhjbHVzaXZlIHdpdGggSU8gRVFzLg0KDQpJIGNhbiBh
ZGRpdGlvbmFsbHkgYWRkIHR4cSBhbmQgcnhxIHByb3Zpc2lvbmluZyBrbm9iIHRvbyBpZiB0aGlz
IGlzIHVzZWZ1bCwgeWVzPw0KDQpTcmlkaGFyLA0KSSBkaWRu4oCZdCBsYXRlbHkgY2hlY2sgb3Ro
ZXIgZHJpdmVycyBob3cgdXNhYmxlIGlzIGl0LCB3aWxsIHlvdSBhbHNvIGltcGxlbWVudCB0aGUg
dHhxLCByeHEgY2FsbGJhY2tzPw0KUGxlYXNlIGxldCBtZSBrbm93IEkgY2FuIHN0YXJ0IHRoZSB3
b3JrIGxhdGVyIG5leHQgd2VlayBmb3IgdGhvc2UgYWRkaXRpb25hbCBrbm9icy4NCg0KIA0K

