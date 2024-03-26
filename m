Return-Path: <netdev+bounces-81897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECD588B949
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 05:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294F12E7ED5
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 04:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33162129A9E;
	Tue, 26 Mar 2024 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mbq0voV6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C341292FD
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 04:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711426272; cv=fail; b=QQYmB9GdtCItuBy8j1gb1EphpNmg68LmgDNOvsYf0L7iriK9+dEnfT2HMPratKNSD3hxHDvmZ1C0CAggUd+O2uXzN3EVq8jLlt0cPPxl7FFF9vq6Esh+uibcNkMSRn7DKqHpd62QkNOHgaZiozuCCak6EqTJ8Xrq1Vtp5LCjCwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711426272; c=relaxed/simple;
	bh=e4nKPwHLBnC+5crY1JBblnkUTTmT49WFF9GS6aiho7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aO10OIa1vTySvQHLzwONS2izC0nAnRkZmGF97BYuBnno6J4RAGBAYzZiG8aJSHOtB92SXjX68jom49MWEuXKN0lmXX7ivWzVRJfNgWNhZPSBDmKn0UEdiHWFNCks0kUW/hDJMKGsGsS06PY+ESDtZa4kj5hlFMfMVvg6RdtiAuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mbq0voV6; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc7SWfxCxbx96/0IqjQ1dFh7W5pvFpc+nha4d3hiEakDe89BufA5bHsI5z9hUGT9CuZNlgZPs7mvMUN1ou78dpoTEhl6d8AszC4BQGvCaLPQ9n+e0mLcjN4GrTZUqrbxQ1alsNp0cEGgF7+QtFnKmKKsNBbNBYzxd98WVk5bx4fhK75hNRpRiAT1VF207xpOhwAS6eWhqXC39XhCCh+guVAaiRg6asycWormoC0LWiDqdrmIKaI5FtIMA60UAS+Z35MAD/k5/YkpOljmZsHV2m2lhALut6RqLoJ9O0yuMbdDWoLV2540Nd4E3Y8gnMxQMIw/aTk7wh6AZU+udNcv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4nKPwHLBnC+5crY1JBblnkUTTmT49WFF9GS6aiho7M=;
 b=eigxFyuXnrK4KTVYUts6FYfSHlNflAKfamHBmgEOwqGAcmzDYWviveOtY3rRPFWPRf/grS81+fPwSY54LkYc0T2y5ggJVwIq7Z5ahGX4DZGaGxJzCwlZpoyFVVpcfGoY+2pKdQBPBNB5r4WZKWEIAPyUsEVFiHKIpnstqBtuvLMeAh5mTfv39mhd8rJb17Cc1KzvUpWkV54WNbUkspszjUobdITA5l4z2EzQri5Ruj/C+oQ21nBebEarHJZ9m+p8eyAwjYasNouIfjFanMwZ/VvyJqwXCkrYfNjRlcMcl3qWJx0fIsh4rJ1rOrF7whDNjWd58xUSkK9NMm/DFwjqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4nKPwHLBnC+5crY1JBblnkUTTmT49WFF9GS6aiho7M=;
 b=mbq0voV6iyhKmwbIY4mYD3Rhe7ME98r34gFuRRnxuvAO+wcJ1+DYYgPjhO+iTVJB7EeNCJAioZQoq8hk0RX/2+GKELxp0ifYSfG9sLHIk6iiwJ2uWsIYmJSpFVeb84Ehm/TzgOcC7V3zsSyxmU1HcYn9JP92XhF3yDqBS57ThoXaHh7JMn30zo+Fze1NiIhoWdDd1LHo/BGUHcHVDGf+mC0sBKtAZCtU2SlJb9d1TLVwgaE2q9kqrOnRNtYB7pwMypXGr8YL02Rau8HQwZxE6lXF6g6EyvU5Tj9kbslcPGmbnly16j2t0M60/G1cyztnTjCGEl0MuJYklP0TOKTcZg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 04:11:06 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::1393:fbb3:2410:ca37%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 04:11:05 +0000
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
Subject: RE: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
Thread-Topic: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
Thread-Index: AQHafv5TsEIZHnmSlEe6eVqLMOFa9rFJU88AgAASTpA=
Date: Tue, 26 Mar 2024 04:11:05 +0000
Message-ID:
 <CH0PR12MB8580BA6DB62352F6378E8EBFC9352@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <23e442f0-a18b-4da0-9321-f543b028cd7e@linux.alibaba.com>
In-Reply-To: <23e442f0-a18b-4da0-9321-f543b028cd7e@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|LV8PR12MB9081:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 weFd0EOfvPCvfbrzGxZgu+ofb8x8khp2GE17Z3DREiRju8M5zXryrei/ypM0P3HyM5J35+2xEyJDid9jQCaF+KpQvZ40OPNnQXJmhscUYS0AIlZz92Su68nq7xvNE1uu2/YCtAo9J6VuJQf3q3fca9Eu/T3Qs6GdgvIf38rY+4KXDWHhlhz/MptI0uOP66KpJd1QsZLN0pGqkBhghw2cQDEY7K/WwFNkjlxXVpMuwJ6YXhzb3cp1Tkt09KMS47WbBMbaq15XBMafnSyNWyYpESdWm0F8VZhIQkIP9xZevIZZJHtKDEWCUeI9YPNciwG+Bh8OwOvkD3yh1uGC+G+y0FlY853aQwtalkroqY4eZB3Tlgi4iFgdvNjUaZnPnPSj1e4z72Jv43hULB9oZudJ7pfZlNn/3MeZyneBvJUndLIsk6murSQRx+VETIBlnv47FvNcoR/oaYZXQSSEdGm4Ykyvfqisj26oPnGHyoV+0ZQzFXAEP38pyq7XpSQVhcm1ZlnBy6B9vEqWT/+DMAQKPGK/DcjVhHpr0W2/D01H8IkHIxGkdidC0PfVI/LBMHtd5RnCJqvUKeo09Bqc4gHcUxnA1isArTfR6+x4Bztd7wMhq3DoVqTfTWixbZ5eI+5kRyzL+SsV1RMCNrytuB0iI//FTy46yu2O2tnbECxG+YU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXkvSHlKRG45a2ROWC9HdnZza2hNV2x6MkFVbEUrTHBtdU1LaTlyM1hZT3pV?=
 =?utf-8?B?YTZ4Q3NBS00yenIrT2FVUjlWeE1BQXhoVzJ6Y0QwdjE2Y3d5UCtJTmQ0UE9r?=
 =?utf-8?B?Ni9nSnhlUmoxTDdTbnFrYXEyZHNueFVvT0ZpUFRqbXYxc2tuUXMyWHZaYll2?=
 =?utf-8?B?cktzZFhNVHdzQU1LcjdFT0lBdU80T25QczlOcnJQVGtWSnZrZStNQWlJSU5p?=
 =?utf-8?B?empJZndUbDVlaGR1cEUra3ZKN2xaeEFYRU9YdlJrdXRLRVRCV3FiZFRvUU1F?=
 =?utf-8?B?cGkxU1d0eGVHeURDczVJa3dJUlp5dUZ2VmFCYXd3TUlwdlo2MStZSGFucGJK?=
 =?utf-8?B?ZGZzT1JjTHhZb1ZjRWhGWkNGdTNOWVhtdWVicGo5dDRRMXBGcTdQVlFsQjYx?=
 =?utf-8?B?TFRBcXRGZXR1OVp2Y3JqMCtBdWV5UDBESVBQdW1JYmY4eW94dUpHWW9WYkx2?=
 =?utf-8?B?Wi8yaUZsWlhpUUtUQ3hYTW5Qb1UzWGNsTUVUZXAyaWlRZ2VPY2Nxd2FxN3Ji?=
 =?utf-8?B?bjl1VU5hRCtRSnltZTBuQk0wTnRXc2hlVkE3QVNLVjBTWEMrcVdPZFdBSHpt?=
 =?utf-8?B?ZXQ4WUlUNTUvcVdMRFpnMmZpb2djSVFtVEpUMnJGK1I2cHZLTGlKWTNlRTds?=
 =?utf-8?B?TkRwc0dRWHRRUTJLa0JrYzJmWkU2bUsrQlhFYkhTMEJrZmxJOFhkYTVSaGpZ?=
 =?utf-8?B?NHhFVlF0ODZIbm44aU1CNWlVVUFJcW1aWExGdnZtUm5zSjdlMXQxbE5SeDhO?=
 =?utf-8?B?VmpMT0hKZUF2V2oyMEM5Vk5veStJRk9KTnpqYUcwMGlPYjF2SlI4Z3I4Tk9j?=
 =?utf-8?B?aW81bEZZVDV4T2RRWjVOTmxMM1JIclhHbWxnTDc4dkFFN2IxMUN4Nk9pWGtn?=
 =?utf-8?B?N0Jld0ttaFBpSU9CNmt6dGNzaklkYmlXRmVXZDB1Ym1rd1pJK1hXSmdzaGlB?=
 =?utf-8?B?Q3Q4Ylp2bks1VFZMcDNmYVkybElGT0R5c05MWU1SaUVDcEZuamFCNWpLY1Ir?=
 =?utf-8?B?NXZKMkNCU0NvNVJOWVhEM0dFVTcvNTlPS2tpQUd4eldVZkZjSDEwV01KVURJ?=
 =?utf-8?B?aG9SY3FQaXoyNllLYjhvNEl1OTViU0FGU2FUR0Z6MUxMNEpuN21mRklzRDBq?=
 =?utf-8?B?bHpRcXFQVUQ1Y2krQlFNcythZ1ZGNTFobXJ4S2Z4dXRtYXFZTGhnam0wNk1h?=
 =?utf-8?B?dFd5S1NpNlptemlLcklIWGR5UWJVbzF6MnVkWGJxK3J2Ymw5NnVPU0pybnl5?=
 =?utf-8?B?N3AxUUZscjB4WkVBMkV3c21QSlZ6WWZ6MjBWc1VmQ1YrNG9XZlBNMnlVNnMy?=
 =?utf-8?B?SGx0WmZUOVVNYXJCQWNiampNYmZ1aFFFZUM1czlkeU41R1RVUUU4eFlkT0hu?=
 =?utf-8?B?VDF4clVwdEFhOVJvdnNrL0RJb1NJdnU3S2FkMlR3VmZCcWZCMnlkVWlhbnVy?=
 =?utf-8?B?MWp0cTI5WjAraVV6c2dleGV4RkxTdy9ocjR5ZXdSeTRkMllaaURvdWpNdGpo?=
 =?utf-8?B?STZpdE5FNEprSjUxYXZEMVhiU21pR0pvNzhXNGNkNEMrUnJpdlo3dWdBY0dk?=
 =?utf-8?B?Q3NHTXl0VUdvTmZPUWlVMkF6QjlZM1gvdWZodWYzME9wNUFxVVlLbVdtbmpJ?=
 =?utf-8?B?L09QZmp2d1FtK0U4cmMvVVZaWlVleVFBZThaa05uOWNmQVNVZXVTeDJXY250?=
 =?utf-8?B?emNQaUgrT1hULzZ2WEtVZW5lQk1PT2R6bmJaeElDS2c5RXZ2VTN0ckxPTVdw?=
 =?utf-8?B?WWs2VTFaUEIrY0pHUTZZL2grRHFtWThsMjRqb0hic3Y3SmtqQjE1VnVIdkxw?=
 =?utf-8?B?Z2ZoTXlBMDNGVVFJSlc3c1AwR3ZsbnBRdHpyYW8zRDd2cUpod3FGNVBwSjIy?=
 =?utf-8?B?dnVMTDh5Yk9RNURuYWFLdC9kYi9yWVpkWFk1QVY5TFJnUE5kS0pNTS8yblhy?=
 =?utf-8?B?VkpDaWtBRWJqT3EyTnFKWmo2dGY3UUlhNS9Wc2xqOFE2c2h3ekVoMmZLMS9R?=
 =?utf-8?B?WityeDBRWFdsdXFkVi84MUhuQ3R3ZWJNUGdXa2laTXN2WnZIMUpNWUtGZmNH?=
 =?utf-8?B?SndieUY1QVdrd3dBaGFpVXdlV2tXK3VvcEZnZk5Gc3ZRKzFlUVU3SHNyMHVK?=
 =?utf-8?Q?ofdg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d63bbc-9065-4440-ea79-08dc4d4ac1e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 04:11:05.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPsJmkUhPS2hSccXL4M0krq58F1xwvgcg9DzK/tuZE57S2wPP+P1YgXnLx81AdAGtoYyNLMLiXL3KRmKj0hXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgTWFyY2ggMjUsIDIwMjQgOTo1NCBQTQ0KPiBUbzogRGFuIEp1cmdlbnMgPGRhbmllbGpAbnZp
ZGlhLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IG1zdEByZWRoYXQuY29tOyBq
YXNvd2FuZ0ByZWRoYXQuY29tOyB4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbTsNCj4gdmlydHVh
bGl6YXRpb25AbGlzdHMubGludXguZGV2OyBkYXZlbUBkYXZlbWxvZnQubmV0Ow0KPiBlZHVtYXpl
dEBnb29nbGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBKaXJpIFBp
cmtvDQo+IDxqaXJpQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQg
MC80XSBSZW1vdmUgUlROTCBsb2NrIHByb3RlY3Rpb24gb2YgQ1ZRDQo+IA0KPiANCj4gDQo+IOWc
qCAyMDI0LzMvMjYg5LiK5Y2INTo0OSwgRGFuaWVsIEp1cmdlbnMg5YaZ6YGTOg0KPiA+IEN1cnJl
bnRseSB0aGUgYnVmZmVyIHVzZWQgZm9yIGNvbnRyb2wgVlEgY29tbWFuZHMgaXMgcHJvdGVjdGVk
IGJ5IHRoZQ0KPiA+IFJUTkwgbG9jay4gUHJldmlvdXNseSB0aGlzIHdhc24ndCBhIG1ham9yIGNv
bmNlcm4gYmVjYXVzZSB0aGUgY29udHJvbA0KPiA+IFZRIHdhcyBvbmx5IHVzZWQgZHVyaW5nIGRl
dmljZSBzZXR1cCBhbmQgdXNlciBpbnRlcmFjdGlvbi4gV2l0aCB0aGUNCj4gPiByZWNlbnQgYWRk
aXRpb24gb2YgZHluYW1pYyBpbnRlcnJ1cHQgbW9kZXJhdGlvbiB0aGUgY29udHJvbCBWUSBtYXkg
YmUNCj4gPiB1c2VkIGZyZXF1ZW50bHkgZHVyaW5nIG5vcm1hbCBvcGVyYXRpb24uDQo+ID4NCj4g
PiBUaGlzIHNlcmllcyByZW1vdmVzIHRoZSBSTlRMIGxvY2sgZGVwZW5kYW5jeSBieSBpbnRyb2R1
Y2luZyBhIHNwaW4NCj4gPiBsb2NrIHRvIHByb3RlY3QgdGhlIGNvbnRyb2wgYnVmZmVyIGFuZCB3
cml0aW5nIFNHcyB0byB0aGUgY29udHJvbCBWUS4NCj4gDQo+IEhpIERhbmllbC4NCj4gDQo+IEl0
J3MgYSBuaWNlIHBpZWNlIG9mIHdvcmssIGJ1dCBub3cgdGhhdCB3ZSdyZSB0YWxraW5nIGFib3V0
IGN0cmxxIGFkZGluZw0KPiBpbnRlcnJ1cHRzLCBzcGluIGxvY2sgaGFzIHNvbWUgY29uZmxpY3Rz
IHdpdGggaXRzIGdvYWxzLiBGb3IgZXhhbXBsZSwgd2UgZXhwZWN0DQo+IHRoZSBldGh0b29sIGNv
bW1hbmQgdG8gYmUgYmxvY2tlZC4NCj4gVGhlcmVmb3JlLCBhIG11dGV4IGxvY2sgbWF5IGJlIG1v
cmUgc3VpdGFibGUuDQo+IA0KPiBBbnkgaG93LCB0aGUgZmluYWwgY29uY2x1c2lvbiBtYXkgcmVx
dWlyZSBzb21lIHdhaXRpbmcuDQoNClRoYW5rcywgSGVuZw0KDQpJIHRvb2sgdGhpcyBhIHN0ZXAg
ZnVydGhlciBhbmQgbWFkZSB0aGUgY3RybHEgaW50ZXJydXB0IGRyaXZlbiwgYnV0IGFuIGludGVy
bmFsIHJldmlld2VyIHBvaW50ZWQgbWUgdG8gdGhpczoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMzA0MTMwNjQwMjcuMTMyNjctMS1qYXNvd2FuZ0ByZWRoYXQuY29tLyAoc29ycnkg
aWYgaXQgZ2V0cyBzYWZlbGlua2VkKQ0KDQpJdCBzZWVtZWQgdGhlcmUgd2FzIGxpdHRsZSBhcHBl
dGl0ZSB0byBnbyB0aGF0IHJvdXRlIGxhc3QgeWVhciwgYmVjYXVzZSBvZiBzZXQgUlggbW9kZSBi
ZWhhdmlvciBjaGFuZ2UsIGFuZCBjb25zdW1wdGlvbiBvZiBhbiBhZGRpdGlvbmFsIElSUS4NCg0K
RWl0aGVyIHdheSwgSSB0aGluayB0aGUgc3BpbiBsb2NrIGlzIHN0aWxsIG5lZWRlZC4gSW4gbXkg
aW50ZXJydXB0IGRyaXZlbiBpbXBsYW50YXRpb24gSSB3YXMgYWxsb2NhdGluZyBhIG5ldyBjb250
cm9sIGJ1ZmZlciBpbnN0ZWFkIG9mIGp1c3QgdGhlIGRhdGEgZmllbGRzLiBUaGUgc3BpbiBsb2Nr
IHdhcyB0aWdodGVyIGFyb3VuZCB2aXJ0cXVldWVfYWRkX3NncywgYWZ0ZXIgdGhlIGtpY2sgaXQg
d291bGQgdW5sb2NrIGFuZCB3YWl0IGZvciBhIGNvbXBsZXRpb24gdGhhdCB3b3VsZCBiZSB0cmln
Z2VyZWQgZnJvbSB0aGUgY3ZxIGNhbGxiYWNrLiANCg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBIZW5n
DQo+IA0KPiA+DQo+ID4gRGFuaWVsIEp1cmdlbnMgKDQpOg0KPiA+ICAgIHZpcnRpb19uZXQ6IFN0
b3JlIFJTUyBzZXR0aW5nIGluIHZpcnRuZXRfaW5mbw0KPiA+ICAgIHZpcnRpb19uZXQ6IFJlbW92
ZSBjb21tYW5kIGRhdGEgZnJvbSBjb250cm9sX2J1Zg0KPiA+ICAgIHZpcnRpb19uZXQ6IEFkZCBh
IGxvY2sgZm9yIHRoZSBjb21tYW5kIFZRLg0KPiA+ICAgIHZpcnRpb19uZXQ6IFJlbW92ZSBydG5s
IGxvY2sgcHJvdGVjdGlvbiBvZiBjb21tYW5kIGJ1ZmZlcnMNCj4gPg0KPiA+ICAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgMTg1ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspLCA4MSBkZWxldGlv
bnMoLSkNCj4gPg0KDQo=

