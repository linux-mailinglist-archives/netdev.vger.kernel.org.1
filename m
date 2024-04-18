Return-Path: <netdev+bounces-89056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9146D8A94FC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51CD1C20D0C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F1C145B15;
	Thu, 18 Apr 2024 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RD6VuJ65"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37771839EB
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428973; cv=fail; b=mLL38cKTSZkfvCWt21ldUSvX8RoJGHAKiiLMID0tvW+xhnCnXrNAbvvHsb1JnqiD2dyNSPM/m7HaXqSsGIQ3y5I9UwfkiRRtKtKxrwtzNamINIV7HD9w29UKWd923sP4xXVSQko5XJ9fDVuu2ux/lxYyDwl8fa1Lgu25N+GSu4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428973; c=relaxed/simple;
	bh=WgbzMdVAQHPl3HMXwm1DwIK8tueNigb19nLnC2+dIas=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcm6IDUmL+4iiNmg59aLw6QweAwj4FIMrddwZt0r8faBCLOOyaTHIxFP1Wh51+/UKZjirXaMreX1qerXCzot5S0aJWokY1qejAQevHRFG6nnzzlJuV2eGpr2Wv7NQqsPlOPREDJQsgHEnL4cgsfy9xw01AhLPwwdCXfBDIRp7uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RD6VuJ65; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB8vvxplq//x96lt5d3blgrMhFtTU7UZ5V3S/gXm5/9jvqY8J48AEuLeqUbqQzx5fyOmlAoFliiJJw2LkowJMu7za1YCzJetcLxAMQt9/ZK7mGhiI+YOSATdT/ooqkr/RpVZ7Qay+zXeGDZSXTSRWuV4iojkU6f+LN4meCYovFX4RBGv8U69aD8hRJCS+iSHrCFssSDv0bKTlp49N0saf1E9rYq9FFAkGc6Loub5q21EotSNmyw2f5702EpfrQcvkvxpsS04ZPxRT1A1UzaiNAQJAJY+bdjZUM/wGhBy3lCXy7lRLYYCjL4j9PTxE8uXR1mw0quWd1YfBu/8LeAyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgbzMdVAQHPl3HMXwm1DwIK8tueNigb19nLnC2+dIas=;
 b=gFfkYOTUmCvAqn96kGTJntn61VLfIXvdg+SY8ZqrFLG8mkIeYpMd5hmRITO+yhCi0DpmDP+60Di84Z/E0TrfUiGID2VoreG36IWDnJUHKHq7zPBMZqZ5l09DLgkCY/EC/kUlm8Q6xn0rj9q6AwGe+6j9LfS7inAuyQBr+4nEtCduFjDItrSb4zbRerNisrunbsvWMYZhMxtlxQZf0QO9i/sXP6yxDnce9mV+zKvQjRo9XF39zQ1ziszI6wK3z8LteTFV1ULjdZ7MiGOT/20xB1eNCWJiS2q5mCq9yB71Wi2Lm4s5MD/unNJtNOiPtd66bcy2J926ZBLyucxP7qv2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgbzMdVAQHPl3HMXwm1DwIK8tueNigb19nLnC2+dIas=;
 b=RD6VuJ65ZtsJhisqnYX8sq+Mx1zqNbGbHjY/M/BxNFukhmwMfq6RU6eeLEH0JnW2EaCuZ35gCCzJ6C3oTfnNazEIPgkgaQzeL9Qk4tI+MUBnSZQAKuYmNO7CwQ7A5Y1U/hbMhPPRrQm7XKsJhCeB82qhWmAVyJd+oqzXtYkfqgDZv8Tcx1v1xZ16qCXpWOTWlZ17RHLZ8RhSORUh3majmvLWiKdN7FpOBfDNLzosU+dC0XjwIDnw/wLzM+XSC6aymDk3i5S0KZhKqaHbimTK8l3jZlDATuE+yE5RtoL2eQXzoLkfu8yLs/YXT0NuJLm4I6fM0U/QoQ6H9mI4FamESg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 08:29:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 08:29:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Aurelien Aptel <aaptel@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "aurelien.aptel@gmail.com"
	<aurelien.aptel@gmail.com>, Shai Malin <smalin@nvidia.com>,
	"malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [PATCH v24 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v24 00/20] nvme-tcp receive offloads
Thread-Index: AQHahozcRysz+cWAHU2c3JO56kkidrFavgsAgAKovYCAAyitgIAABn6AgA0yAIA=
Date: Thu, 18 Apr 2024 08:29:27 +0000
Message-ID: <27e21214-7523-43e2-a3a4-0b6327190fec@nvidia.com>
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240405224504.4cb620de@kernel.org>
 <1efd49da-5f4a-4602-85c0-fa957aa95565@grimberg.me>
 <838605ca-3071-4158-b271-1073500cbbd7@nvidia.com>
 <20240409155907.2726de60@kernel.org>
In-Reply-To: <20240409155907.2726de60@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB9070:EE_
x-ms-office365-filtering-correlation-id: d4f60b61-fc96-4740-0d49-08dc5f81a962
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EIvh5sJwutxQbwL/b1c/ArO2sJNDqXkjsU53/xFEE+3iPjoEXqvkBKcnPx/BURVomTc/aH1Ojs+XvNDL8lqxxJz+v1cJLZfdRDkGwEFQCdbVNyIjOQ0+kgBFwrZIua/FKohvcAZpO6oZ8hDcOhydDEMequ9fQ/TjvZDy5QSuQEb6hfHR4KawJ9sxaPAKZ+H1Om6iWCcozW5TmIKp4fMn3BvXsPE5mWlr4hxwtEOZrywsAhDIzBlFAa5TkilVjS6mhaLFb2HizNmAZ2LpFZ89KxOKqt9kmGrzSm5Uecb+BIza5zExLUsZEoZ0+YFvD5L2visfy4o+/6xsVvOPrG0YsTdjd9jkC63gp4OWxrFmxvQl2NYwn6N2JW+7ypp+FyjeCdHObxgEFi2nmUZSnSBKEWFBga+BImfzTkrpgZXHfmG1HqrEs3hsbZsBojcfZQjPr6CI+Gpgnrtp7rRUU+T0IRrHDR95PgHja55aRoUePf000WnhojR+mmuaaH1w8SDP56KTq2DShttvIs1rt9pfs6ULbnP7RWyk2ckC+BYiaIcdCD0HYN6YcMXMnwNZwnUpX7ypFbysZo6grFq2tv0+4F3JemjJv18wnStnWLn9kgY5MTSIzkegNF52KNsGHKSyHeMvXzPPXJY4HxkyHHYcyQrHKiHd0ePV8oO0QBaxvsmz5q0a9Kx2lsWVgeHmlU6/RX0OwnorNDNpQp0NSCkSR1qDbqbim6piwUKCmwtGTuU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWo0UVRmZ2Foc29nM3lpUkMvVUtxOUNGTEFPQ1RJakMwSkNZcTRmSnJ2anNC?=
 =?utf-8?B?LzRaak1oenU3b2ZBNFJMKzdUczNhcFEzVWFiWU5zelFyREc4UG1USXVzT2g5?=
 =?utf-8?B?dEI3VmE5Tnh3cUh1MFdwRXdRaktZeVNWYXlmYzFveHFXUmVnSlBPS0xUbisx?=
 =?utf-8?B?T0ViOTBVeDFpWlMvYnpGTmhkbzRha1A2d3VIUHlaQmdSQVJERW9ieGoyZUUy?=
 =?utf-8?B?dHVlYzZWa1Jwd21tRGIzTWt1ZUhGYWNESFhPd01GUk9yM0ZQZTg2cVFPak1F?=
 =?utf-8?B?S01DckVvbHBwM051TXZmMSt3aDJjWmRENFJMbG5jUTQvS29lZGo1K3BtWlNK?=
 =?utf-8?B?aHNITHVVUkpGSFJKU0RNaVBDU252RFAzbG5ndHJIMjdvbkhtOURBOS8vd1Bk?=
 =?utf-8?B?TEo0WWk0ZWZBOXlzNmpTMlVlWmxZd1RRVmkyTk9hYU04SmJQM0F0TUVnTlBj?=
 =?utf-8?B?V2VsNWVTbHVtZVRid3JncklLalNBbmJsTWJudUJaVi9yUlp3Y3ppb2RRaHpp?=
 =?utf-8?B?STdpUGk1M2g4dUZwTTBjcndIM0VhNmRBdGNVTmE0V1cveVdtK3VUV3lQdW93?=
 =?utf-8?B?cGc1RkhEbFVHenZIc3F5cG5JZmpOTy83NGJvUGNYZ1Zod3FuRUNLQ1cwdDRk?=
 =?utf-8?B?SlJYTHplVnNBOEVBTnRoaVJ6OGE0Y2cxUG9BU09Dbi9GaVdZd0lLd0g4RkJF?=
 =?utf-8?B?YVNtTmhmTTFiQUtka1hWQXVSbmp2cUxGUHl0V3VlRTFHQzMvTDJES1NkMGtp?=
 =?utf-8?B?V3ZQdlhpT1JTT0R4YXZLOEN4U1dpUUI3UWFRaDVTdTF2cmEyRm5oVXg5VGhU?=
 =?utf-8?B?cUlXNHNsSzYvTzkveTI0Ty9JUTB5TG9ldktCNm9EaThoY2Q0bm5hOG5LWVp0?=
 =?utf-8?B?bm5YSW1Ga2ZLcmhXdUlQS0xwbTY0RmRFUWR3eHpNbUhxVHhjWlMwQUNvR3o2?=
 =?utf-8?B?WW55U3cwL2dxZSt4dUhBYVpmSmZVUXNBVmFHaHpwQjM3bk1Gdnl1WVdQL2o4?=
 =?utf-8?B?Ky9sWVFrZjF3QlZITjNUWkZYMlNiUkNqQ0lhcmFyVERhajZqOGpWSVlmSlpS?=
 =?utf-8?B?SW1iT0lFbnVqQ3czTnVGa0tTUFVGU1VnU3pZNlA1ZWFqbVhWbEhqVHR1VExP?=
 =?utf-8?B?VVNSdmY5K2pFejlTTXFFUnJXWWMvY1Q5U2lmMWJHL3QrYWg0RVdPVi9QUlcy?=
 =?utf-8?B?UC9pWGRKWUFGaEdSM1BLU3hEM21WcTZVZWdkNDRGQWJSaHZ3bmI4dkVucXVM?=
 =?utf-8?B?Y21MV0N6VUhtVHhaSGhGWE5kb3R3SG9xY3RPcHppQlQzUUJZU1BoajB5blVu?=
 =?utf-8?B?YW9jajl4eFg5Q0Eyek1XQWJIcmZKVFdiU1dBWEh5K3gySUxSTzRJQzg1K1pQ?=
 =?utf-8?B?NDErVTVLSmxYK1BDbjNPRmxTQzJmaHBWOU5VbFpQTkN3eFRFcW9QTEN2MzNS?=
 =?utf-8?B?WW0wdDJVdzloMVZTMWhtYWZZcWN2bi92Z0EvbGxya1MzSWxoMHRURDJKaS9s?=
 =?utf-8?B?R2pPdEtiY3dHY1QvbnJVUkFaa0xTNS9pNzk5OXZZaG93ZDBaTTZFc1ZGU2lO?=
 =?utf-8?B?V2VlNkxaNmpKdTFmbGE2VlYxd0VIdHhCNmRLNnF2NjNqWHcwRmVmUzh5dTMw?=
 =?utf-8?B?QzY1ZU1NcnJ6czdJaFYzTEhub21adG0wN3JBNkFlVnlUSmZNR2xkMkhTNmFz?=
 =?utf-8?B?NFVKYWRxbXZ2S0FXWGJ5Wjlac3dMeVdCeGtOR2ZzL3NxZkd4dEF3dE55clJz?=
 =?utf-8?B?Y3g0SnlUQ1o0czVvcG94bGZIR1k4NnZGcFNmOEtmelBZNXUvNnNmUjlIdDlQ?=
 =?utf-8?B?UmI3Tk5VeDcrNkw4QVdNNWUydjBWUEtOa2VQODFQY0Z5UWk5YjNDK21BbjE0?=
 =?utf-8?B?QW5LSDdBL2ljNElKVDE1V1JiZGVoVExqU3pESFJMYjlTRHkrWU01a2hWdnl5?=
 =?utf-8?B?NjlCYUJsWHJMUW85MG4vYVRoRTBZekIzUTBtVzdLZWpQZkZCcUo3M1d5QzZC?=
 =?utf-8?B?TUE5ZXF0YmFoUUJrUVNOK0ZhVkN0NzRJNlVPMEk4M1Rvbm9Tem9sZU5nc0Y3?=
 =?utf-8?B?Y2NNYnNEaERmb0FOdDZySE0vekV6VnBUTGIrUUpXZXBqWmZuZWRqeHVaTjQz?=
 =?utf-8?B?ZHpmSVUxaTFxRHRiaHR3dDRPTUNpNHVKaXgvcUR3SFhxZW10VCtWZHdwSGFi?=
 =?utf-8?Q?++xu6yU2bhwORJMY3V1h5iMToTR88SWIZMdYlemVGHiX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB6FF88F6B826D4EBA4605B4A7E3E78E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f60b61-fc96-4740-0d49-08dc5f81a962
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 08:29:27.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XC8RK33wrQn/QnuDCDXaZ57o+JO3CLvxEJqOPCn+z4ClXy2JUmvZN0pXGwRgmkDZt20dNnmcouqp7PkxzdQ3hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070

T24gNC85LzIwMjQgMzo1OSBQTSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IE9uIFR1ZSwgOSBB
cHIgMjAyNCAyMjozNTo1MSArMDAwMCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBibGt0
ZXN0cyBzZWVtcyB0byBiZSB0aGUgcmlnaHQgZnJhbWV3b3JrIHRvIGFkZCBhbGwgdGhlIHRlc3Rj
YXNlcyB0bw0KPj4gY292ZXIgdGhlIHRhcmdldGVkIHN1YnN5c3RlbShzKSBmb3IgdGhpcyBwYXRj
aHNldC4gRGFuaWVsIGZyb20gU3VzZSBoYXMNCj4+IGFscmVhZHkgcG9zdGVkIGFuIFJGQyAoc2Vl
IFsxXSkgdG8gYWRkIHN1cHBvcnQgZm9yIGJsa3Rlc3RzIHNvIHdlIGNhbg0KPj4gdXNlIHJlYWwg
Y29udHJvbGxlcnMgZm9yIGJldHRlciB0ZXN0IGNvdmVyYWdlLiBXZSB3aWxsIGJlIGRpc2N1c3Np
bmcNCj4+IHRoYXQgYXQgTFNGTU0gc2Vzc2lvbiB0aGlzIHllYXIgaW4gZGV0YWlsLg0KPiANCj4g
Tm8gcHJlZmVyZW5jZSBvbiB0aGUgZnJhbWV3b3JrIG9yIHdoZXJlIHRoZSB0ZXN0cyBsaXZlLCBG
V0lXLg0KPiANCj4+IFdpdGggdGhpcyBzdXBwb3J0IGluIHRoZSBibGt0ZXN0IGZyYW1ld29yaywg
d2UgY2FuIGRlZmluaXRlbHkgZ2VuZXJhdGUNCj4+IHJpZ2h0IHRlc3QtY292ZXJhZ2UgZm9yIHRo
ZSB0Y3Atb2ZmbG9hZCB0aGF0IGNhbiBiZSBydW4gYnkgYW55b25lIHdobw0KPj4gaGFzIHRoaXMg
SC9XLiBKdXN0IGxpa2UgSSBydW4gTlZNZSB0ZXN0cyBvbiB0aGUgY29kZSBnb2luZyBmcm9tIE5W
TWUNCj4+IHRyZWUgdG8gYmxvY2sgdHJlZSBmb3IgZXZlcnkgcHVsbCByZXF1ZXN0LCB3ZSBhcmUg
cGxhbm5pbmcgdG8gcnVuIG5ldw0KPj4gbnZtZSB0Y3Agb2ZmbG9hZCBzcGVjaWZpYyB0ZXN0cyBy
ZWd1bGFybHkgb24gTlZNZSB0cmVlLiBXZSB3aWxsIGJlIGhhcHB5DQo+PiB0byBwcm92aWRlIHRo
ZSBIL1cgdG8gZGlzdHJvc8Kgd2hvIGFyZSBzdXBwb3J0aW5nIHRoaXMgZmVhdHVyZSBpbiBvcmRl
cg0KPj4gdG8gbWFrZSB0ZXN0aW5nIGVhc2llciBmb3LCoG90aGVycyBhcyB3ZWxsLg0KPiANCj4g
WW91J3JlIG5vdCBzZW5kaW5nIHRoZXNlIHBhdGNoZXMgdG8gdGhlIGRpc3Ryb3MsIHlvdSdyZSBz
ZW5kaW5nIHRoZW0NCj4gdG8gdGhlIHVwc3RyZWFtIExpbnV4IGtlcm5lbC4gQW5kIHVuZm9ydHVu
YXRlbHkgd2UgZG9uJ3QgaGF2ZSBhIHRlc3QNCj4gbGFiIHdoZXJlIHdlIGNvdWxkIHB1dCB5b3Vy
IEhXLCBzbyBpdCdzIG9uIHlvdS4gVG8gYmUgY2xlYXIgYWxsIHlvdQ0KPiBuZWVkIHRvIGRvIGlz
IHBlcmlvZGljYWxseSBidWlsZCBhbmQgdGVzdCBjZXJ0YWluIHVwc3RyZWFtIGJyYW5jaGVzDQo+
IGFuZCByZXBvcnQgcmVzdWx0cy4gQnkgInJlcG9ydCIgYWxsIEkgbWVhbiBpcyBwdXQgYSBKU09O
IGZpbGUgd2l0aCB0aGUNCj4gcmVzdWx0IHNvbWV3aGVyZSB3ZSBjYW4gSFRUUCBHRVQuIEtlcm5l
bENJIGhhcyBiZWVuIGFyb3VuZCBmb3IgYSB3aGlsZSwNCj4gSSBkb24ndCB0aGluayB0aGlzIGlz
IGEgY3JhenkgYXNrLg0KDQpUaGF0IHNob3VsZCBiZSBkb2FibGUsIHdlIGNhbiBydW4gdGhlIHRl
c3RzIGFuZCBtYWtlIHRoZSByZXN1bHRzDQphdmFpbGFibGUgZm9yIG90aGVycyB0byBhY2Nlc3Mg
aW4gSkFTT04gZm9ybWF0LiBKdXN0IHRvDQpjbGFyaWZ5IHdoYXQgeW91IG1lYW4gYnkgdGhlIEtl
cm5lbCBDSSA/IHdoYXQgSSB1bmRlcnN0b29kIHlvdSB3YW50DQpvdXIgdGVzdHMgdG8gcnVuIGFu
ZCBwcm92aWRlIHRoZSByZXN1bHRzLCBzdGlsbCBub3QgY2xlYXIgYWJvdXQgdGhlDQpLZXJuZWwg
Q0kgaW52b2x2ZW1lbnQgaW4gdGhpcyBwcm9jZXNzLCBjYW4geW91IHBsZWFzZSBlbGFib3JhdGUg
Pw0KDQotY2sNCg0KDQo=

