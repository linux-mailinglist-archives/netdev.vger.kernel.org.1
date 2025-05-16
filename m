Return-Path: <netdev+bounces-191094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90145ABA0C3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812423B91F6
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF621C3BEE;
	Fri, 16 May 2025 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="V+IWWTqO";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="gGd2yl5Q"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4D618C937;
	Fri, 16 May 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412758; cv=fail; b=JHfj53SDvzwydTHI/UmZeg2LT10HgVXpOelj4Tmrs7skC6B2l8xtAI7dGXuRrlz7Aaq4hSmji7/OK5IvC9YklXjPFNrR4H7IxnMip1BUH+zT1S1rA6Xg6bf7u5SI0GeUEVf9PYRbfE3sEoab7kPOUEp8ETSbUBB8cEBGLgDC6Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412758; c=relaxed/simple;
	bh=M8DH0/3UE3jVHzZSVjeYW0B9jf3+WKW7p8Vksd6KkXY=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=Gj3aoSdvVp8cUPO64q8sG5xCeH3pIR1iFY+pZCbXNx+JnJlyDvvb7wjSy2cOmSSf0j6bTAdOoiqb9ojis3UAAFgdGjMqn5XyjBYu06JW+YqvS8Aw+VbPTjLA7cTUtB3Kj5y1dV6ctaYPgBbA8RNVBmMaAGBMu7RtbpVN+QX2M7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=V+IWWTqO; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=gGd2yl5Q; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GDwJbr004254;
	Fri, 16 May 2025 11:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=oq2cJkmBl2erMItwHzjss1UbQikvY96/Ul2hU7h5i0U=; b=V+IWWTqOu2M6
	WoMBQQAbNmCzG4DMC401MKXNHsZYmvwflwJS5FSlhBvRSGJZLkE5c2/pqfrANLsL
	ejqYPpD1CGtd+aBVl2MubPDHZW0l3lI3O/kZ+yUvTPNb7q1CC96qOSe/4Una90yu
	P9m/iHiiy/RZjt17XIQozpu6lAkVs28rQHDi7rAXUQoX/CqzOkA2cKfcj8XXO8nq
	Qfjpi75FRTGq0d/U+Sk5aQEVZqJt9PlPvIy5rLCZCIOk2GyXFcfscOURYjPQ9NwA
	+kWkZ+sutrHrSFW4z9bHp4pIGymiusqbENNlaRNN/T6O/t35YyTcQzLTuSHvjQ2K
	88L0z4VxdA==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 46mbcjh70r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 May 2025 11:25:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpsyyIQgcMM0BSGuBIFSBrGfPktvpXP2QehZlMuTtE3w6HhN8pXGLm7rWsoNzfZLYWN4LdWPxaXXFA6lfrvwxQCcxwW+hHby/O5MQ+Am3S0BsNPuew5CNj8fba0Jdet0eD3PxFGwdFveSgWJ3BN4QqP3AQgT47LTL/VgWeHcmgjqht6HkxvVnmx4wAsItwB/hev7OyYRLEIK7oucQO6kwUk+u+32bJcFY702CvQxXDmiDobbekKvQD1Ux2Xlo7ueN3xGzc5fUy1zQXHb4VPa3EZlIyeiz4uni8lPKHza6xL8bkg0IGAZWnqVVi60GV8Dc4qlyxzEiZU3Nz+3b3Ot8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oq2cJkmBl2erMItwHzjss1UbQikvY96/Ul2hU7h5i0U=;
 b=LIa3bwmwYxdQLcEy7GpayDuoGxXy9dQQCS7hl1mj8THTjEM2NEaw2FG5UdpDr3w/w2lR940mGgVbU4YMZlsbOyLg5mLiMXmChfnCU4Fuhg1OZjoeQxaaRfh21a9HkOY+MNrCs0L9V5P0NFRDu5ry9XltDKzn6orxu+s2plqE8lQUh4AiWRsu4eRZKwilb6F2/LBfP+wGKFdECgKrAcr7tED1WWTYNRLkTQPPZWP+F4hHu7Ru3Am3IbnjleXZ3V7Cwry8FfOqLv2sYVBseXWMnXpoz2FJMpWKX6c6tbvB5vWVGPSNxUF80OQxsgvM2tPaZ1V8eXqJ+WLQZmfJ6AqNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oq2cJkmBl2erMItwHzjss1UbQikvY96/Ul2hU7h5i0U=;
 b=gGd2yl5Q32oGEEW3kNm8Yw8O3s8NFUHZHIvsQHE7lZmHGzZgkpdWkesh+SLt9cLlHA0gPFPMYoa+RG4YIBegM1CFRT+2LN4h3C+z+KAgrTFpFw/GMbWoYh4l1U7FUHMfjIxkGP0rUm6U85+kO+dcWAhJl2gN901tHHWOQXAwzQk=
Received: from DS0PR11MB8205.namprd11.prod.outlook.com (2603:10b6:8:162::17)
 by CO1PR11MB5091.namprd11.prod.outlook.com (2603:10b6:303:6c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 16:25:24 +0000
Received: from DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a]) by DS0PR11MB8205.namprd11.prod.outlook.com
 ([fe80::c508:9b04:3351:524a%4]) with mapi id 15.20.8699.026; Fri, 16 May 2025
 16:25:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 12:25:21 -0400
Message-Id: <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet"
 <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>,
        "Rob Herring" <robh@kernel.org>,
        "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Silicon Labs
 Kernel Team" <linux-devel@silabs.com>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Johan
 Hovold" <johan@kernel.org>,
        "Alex Elder" <elder@kernel.org>, <greybus-dev@lists.linaro.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: =?utf-8?q?Damien_Ri=C3=A9gel?= <damien.riegel@silabs.com>
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
X-Mailer: aerc 0.20.1
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
In-Reply-To: <2025051612-stained-wasting-26d3@gregkh>
X-ClientProxiedBy: YQZPR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::20) To DS0PR11MB8205.namprd11.prod.outlook.com
 (2603:10b6:8:162::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8205:EE_|CO1PR11MB5091:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd71dc1-2d2d-402e-5d84-08dd94964296
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm43bjRXV0NBcTRXbUM0eXNUZmFoUDIyU3VVY0lMNlhIUlBaZUlUSVoxdnVE?=
 =?utf-8?B?L01zVVF1Z2sxditDM01wbU56R2F2eks5RTFpWXREU0YxWVFWbXZiNVRWM29q?=
 =?utf-8?B?U2pRZWYxSDlFVGpKNW9pNEE1NlFnandzRS95T2ZjV0xFT1hhZng0VFdHL0Vh?=
 =?utf-8?B?TjhrMmJJM2ZGVktzRndJWGlCVWhFMXlqU0QyL2hIKzlCK21oMkVqcjdlTCtC?=
 =?utf-8?B?SzhlTnQrK1JxYThUTjVacnZvcEJmM1ZWaFVpSjRoMTlYZ3ZuY294M3ZmdStS?=
 =?utf-8?B?RmFHY0laK2tqbkwwdDVaa0pIeTNaa3l3dWpxNFpmc2ZwanJXZ1p2clYxOWhD?=
 =?utf-8?B?Rkx4L1I3a2RHUmw0WkczU2wrY2UvTXpKRDFUZjNoZXYyS2dTTFFOUWdCNWFH?=
 =?utf-8?B?UFAvY2o3Y0J2Y0tqNjdvT3FpZllONzhDMHJSK2o5b1ZBVlo2ZHJsNVhzN0dG?=
 =?utf-8?B?NnlTSlZGUG9rSklqMVlxY2QxemV2V0hTWUsxdlY0bnRIeHBEUjJiM0xuaUFG?=
 =?utf-8?B?djlQT3NrazhVSVVDckNJamV6RU9DYmU3eUkwODgyazFpYVMxWDFLaERyOC9j?=
 =?utf-8?B?SUNlME9Ea2EwbUVwV2RJaUtLNVdtV1FqU3llS2F4dFlXMmNTQWhTQWRIby9J?=
 =?utf-8?B?ZnZWbHVZMkRpOHpFbitrM25JREtXT2FzS29VVUI0eHpPQXN6dU1BN2dwKzRI?=
 =?utf-8?B?RXpRNG41TVdxL2tSbHVQYVd0Y0NBSTNRK3FhZnlncURDVmplc2plRncvSFRl?=
 =?utf-8?B?LzVvUXBzRXRtQkxSSWlnei9zR3RUQk1UeVYzNkhKU0MvN0ZGNmU2SG9ZYmhw?=
 =?utf-8?B?RndGY2ttVEU2d1JMNmZPdkwwN0FpdGk4S0FCdU91OGc3ZFBYTnlOcnRXek15?=
 =?utf-8?B?TytQMFRVV2NTMFJsUG9mWnF6N2szT2dJM0NYUFhHQlNLejFyUzhrU25BMHo1?=
 =?utf-8?B?RDBkaFlBTFd5UFJTRUdaUzcxWHMwR0JLc3EyWGkwV25wbHI0RFJaMWpFdnN2?=
 =?utf-8?B?Ky9FR0NkUExoUEhnNlppRENidERFdkxSM3QyOHdLd2VMR0VXLy9lb3UvOGNN?=
 =?utf-8?B?cWt5WXh4OE42cUhPV2V5bDNHSUNCaGtqUHZwZEZ1ckdwZGtEVjBYMHArcHM3?=
 =?utf-8?B?dEFzMHJwazJyak11U0tlc0syZlF3UkR1c0gzS0tTVmM1OC9QeE9mNWFjRko2?=
 =?utf-8?B?RTIwakZLRWRaa2I4RC9Cc3hvYXBOUXB6bFRvK1hlRHRUMTd5c1pqOUwvV0sw?=
 =?utf-8?B?WW5JeDZYRjlYL2d4U2EyVk1VZ1hKa1REODk4MTArY0xQY0d4OUVaSm1iTFBS?=
 =?utf-8?B?VWN0aE9ISWR6VCs2dzV4ZFVyeGE2emFBV3JwZ0hmeWdIcEFEMFVoTndCUVNp?=
 =?utf-8?B?UWpucEE4MkdFWE5mN0ZwMTJCL2ZWVmRzT2VtWlBkUEJKajFlSUNKaVYxYlFl?=
 =?utf-8?B?UjMrdmtFWEFPOWl6UWdyVGxnYTBEZnlTSGhXVkxJai9nb0Vka0gvUmhBSURB?=
 =?utf-8?B?V3pDS1BGalE0WDNudjBWOVFzbTZpUXNkUFF6ZGJWaEcwKzhia0NTRGdaRGFk?=
 =?utf-8?B?bFNCOXAwZ3R0ZjNIN0JSejNjR2xnQXlSeDNmenJqQk9PUkxOVjdZeDBiOXRO?=
 =?utf-8?B?NWE5SnMwMjlUVURwTkdTZk5weVRRanBNWFlTdFczeWszTWxoaTRkQlpJMzVN?=
 =?utf-8?B?TkQwVkhmMHdySTByR0ZoUVVKejhMT0xOY2MxSUhiRGx3YXhZSThXdGxJNFNp?=
 =?utf-8?B?d0FMNllGc2MzYUhkYnB1VU03dWQvNFl6eElmSTVkSll1a0J3WnNybFV1UlVM?=
 =?utf-8?Q?yC7s12qiaOBWfZMQKdsIUbfPlnV7iTXYzvngE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3IxcmFXd2JXTDRXbHdEcUFOM25FUjJkWlNsT3JKZGlMWUZFSVNucE1XMk12?=
 =?utf-8?B?b2Nab1p1MmlycEpWYlF2Z04yRXZqc2dXS2FMNzFKUEpDS0ZoaUk1bjA5SEZz?=
 =?utf-8?B?OE54Ull2L1JGcGJQNEcwOEhSZEpDTGRWbWxFNGszNEU0OXRCc3R1ajZBQUVa?=
 =?utf-8?B?dVpHeFV4V0hlWnJIUHdKa0lpOU45SjJrRFRUT3JYTlc5UVpkRzlWUlEvejN0?=
 =?utf-8?B?ZnRwZEVuYUN6cm5NRUpTTk1Dbm02VVNQUU15aURrakh2SFdZdURoOGMxaHVG?=
 =?utf-8?B?RlBVYlh1TnJzMlhGOHZqNjJCRlJPSXdPZWhuRUd1dC9SZWFVL1NNR3RtQXBJ?=
 =?utf-8?B?Rlp4Z1FjSDhHK1Y2NGpjM0pHdHdjMkUxZVRTZ1BTKy9GYmpRa0NoWjhBSmNL?=
 =?utf-8?B?YU5FYjFQa3VhTXZGelIxQWRNV0pZdW5sUldwdGY4czJmQlBjcHJJUmt0dC9V?=
 =?utf-8?B?V0tObW80czVKV0FtMmlxL1UrQWJmSnA5anVOWlJiNjRiWkpMZkN6WTVWMWRm?=
 =?utf-8?B?T1dTODNHQ3ZjRVNBTDU0elovQ1ZxZ2tBZ2lkd3Nnd2dTSHZJQ3cxMGRzdU5G?=
 =?utf-8?B?cG9waHYvZzVxTTBpYUpUSmpDQXJGN3VjbFBoUHF0QUNjL2w5Q2piK1JHTDFM?=
 =?utf-8?B?RHJOQk12aG1DNVpZRUMvSGxCbnd1Qmo2TW0wbXRtdlF1UmtRZWxvaTFNa2VY?=
 =?utf-8?B?VDNvckQ0SEFoeHdYbzZmQThlVDk4dXlOcTZETXNpaGNXLyszQlBucEI5NGp2?=
 =?utf-8?B?U09IZ29GaXhrdUpZdlI3MWoyVDcrdG44Mmd2c1pSc1Q2OGR4NzErQnlrWHJC?=
 =?utf-8?B?QmlXTzYvRkpwR1ZTZlQreGNzWmE1QXFjbEsvMnFNcXhvUWs3cUpmMWs1aGR5?=
 =?utf-8?B?YlZNQWtEVTVxeTc4WC9uV2RkMmpZVWZiVUFZT0RYTUdKTGZ4dzZrMHlybzRD?=
 =?utf-8?B?U0JVL2loYzcxWlJqcW1UTkNEYkFsblV2ZkVKQWE5RFJETWljTDdZTGFqRVBO?=
 =?utf-8?B?TmRaUEFpM0REaW56ZmZLNkZkTG1ramtFOHVaTmR2c3FpNnliTzVNRXV0NjJE?=
 =?utf-8?B?TnBmeC9kdWhSY3FheDRSVHVoSnlSR0pFZnI0eEFGaHBLemNudFRvdkM2Z1dI?=
 =?utf-8?B?VnNlN3M0c2ZQZ05BbEg2TEZMQlNlblI2QStxNEs5eTR0MklOZkVWemkxNVk5?=
 =?utf-8?B?K285MUFRWmdGOWdpWTd2UjNMTVZadlRxaUxQZU81clNXYmRab1RKQzdFMURr?=
 =?utf-8?B?eXlSVlV3dUJTM0VRTFM5YUh2akM0SitkZG1HdFJiS3NiVmh2ajhNb2pCNmFp?=
 =?utf-8?B?RVFEc09SKzUzR0JnTTlxVHhXRjE3cjBPa05QTVhlQzVCdEREcDNNOEtFVlpB?=
 =?utf-8?B?dUNOaVFLN3YvTUpJM2VwWjZkYWdQR2VOSzJCUkU5N2MrQTJNUG83LytOeGdR?=
 =?utf-8?B?dGpHVFBEbWVBdlNRck0xQzZFeEtGdy9BN1NDSXpuc1pnbG56emx3MlJCeERi?=
 =?utf-8?B?d3g4QnNRUCtpWUgwdXE0RERScDJOOXdTOGFyRkZzc0hZTGkwYXhsTG9MUGJY?=
 =?utf-8?B?d0FYSndQMy9sMndOa1dLWUh2cWZXbnpSWlcwOGpFeFE4K2FJbmwwWFU3RjBQ?=
 =?utf-8?B?L2ZMd1FmNkJpRXRhVWtFVXZnbFl4Zll0akQ1V0FsYmpBakdZamg5bXBGMzdJ?=
 =?utf-8?B?cnZ2TEcrSUJjYStEVUJZeGRGcDF1eHo4UitxRS95dzQvMElnN3BwY0VKU05L?=
 =?utf-8?B?eU9GWHRkZW1zRzZFN2U4VDRDRGMrbnlPY2RoaDFaOXE0c3Z0eG51MXlWMW5X?=
 =?utf-8?B?MElRMTJNUythUWRYbjczOFQ5SThSWUxJUjRYQ3NybFNoRFhsdGJaUllncDhy?=
 =?utf-8?B?YjFDbmlONFlHRlhGL3ZIQ25ieDVhK3psLzIwaWljZ1J0NFVaem56S3hMcndG?=
 =?utf-8?B?aGFzcXcwTWVpeVNHTCtsdU5udzhER1U1a1lJcTh3emNrak50M0RMaGNoaVFm?=
 =?utf-8?B?ZnFZdDh0Y1dIM01KZ0ZLQzVYdXVrbngyZHRBd1FLeEtvN000djBnSlN0dkhI?=
 =?utf-8?B?WkUxVXpEajN3NTNHc0l2QUtPVTV5eFc0NGl3WWFKNWtDVit6aExKUEJDbkNV?=
 =?utf-8?Q?2Il2yNfu44tMFJ1KkLS1qhxNm?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd71dc1-2d2d-402e-5d84-08dd94964296
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8205.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 16:25:24.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYYrnx/1qD3X6Cfh5ZQzPcA7YLeGnWESVDYOD+Ht9nJW9okWIR2Myf6YLzN6r+hy2whVsSNoZ/dpjqfinEb4ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5091
X-Authority-Analysis: v=2.4 cv=ItQecK/g c=1 sm=1 tr=0 ts=682766f9 cx=c_pps a=o99l/OlIsmxthp48M8gYaQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=M51BFTxLslgA:10 a=i1IsUcr2s-wA:10 a=2Fbpa9VpAAAA:8 a=XYAwZIGsAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=2AEO0YjSAAAA:8 a=UZifkUOPARptdXYptkgA:9 a=QEXdDO2ut3YA:10 a=AsRvB5IyE59LPD4syVNT:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE2MCBTYWx0ZWRfX1Dn5qMgHDm08 Hl+Uc7MgKxWJjsVjdZ2hPrmNd7vvSuGkvEDXtaiRn4uC3ARLPYJWwJ7N5x0e6urI9IT1v/v/8QY C/7Yb6fDra0S6JkAOZ2tkNnaS5HJ4t7jPpcaFMhu/TobuINA6HjuJTfxSkboosJXgMDCUMQOCSp
 PcKhkUIU2AWYfHpa8oSVWipVKWj6q3c0jqT8JBDnspQbEL+gcGDdTNqehVxqPX1+hnksdAgEnZg 2tydAizI4eM4G6DyStZYwH+8TfkbloQ2kL0cDkFBx+O2sYP8CO2jfrlOLtcYvZlCGSC8sBCaAA0 9dVDobYq2hrpI2WNLkbUVKT9SwMuuSabqV2fuasc6kNiU/3MFEUMIiN+t+Y3Hqv18YAE+7cqZ5l
 tixw+j4UGiKQ9BXv5eNcCHntjScB9WO6M6Ob/eIKoyfLI/JxzeiDkKYeBK9EKMQtLJJft+hW
X-Proofpoint-ORIG-GUID: DCkQc5Ljto0OF18XMcdZFWYsm6ux-IsU
X-Proofpoint-GUID: DCkQc5Ljto0OF18XMcdZFWYsm6ux-IsU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505160160

On Fri May 16, 2025 at 3:51 AM EDT, Greg Kroah-Hartman wrote:
> On Thu, May 15, 2025 at 11:00:39AM -0400, Damien Ri=C3=A9gel wrote:
>> On Thu May 15, 2025 at 3:49 AM EDT, Greg Kroah-Hartman wrote:
>> > On Wed, May 14, 2025 at 06:52:27PM -0400, Damien Ri=C3=A9gel wrote:
>> >> On Tue May 13, 2025 at 5:53 PM EDT, Andrew Lunn wrote:
>> >> > On Tue, May 13, 2025 at 05:15:20PM -0400, Damien Ri=C3=A9gel wrote:
>> >> >> On Mon May 12, 2025 at 1:07 PM EDT, Andrew Lunn wrote:
>> >> >> > On Sun, May 11, 2025 at 09:27:33PM -0400, Damien Ri=C3=A9gel wro=
te:
>> >> >> >> Hi,
>> >> >> >>
>> >> >> >>
>> >> >> >> This patchset brings initial support for Silicon Labs CPC proto=
col,
>> >> >> >> standing for Co-Processor Communication. This protocol is used =
by the
>> >> >> >> EFR32 Series [1]. These devices offer a variety for radio proto=
cols,
>> >> >> >> such as Bluetooth, Z-Wave, Zigbee [2].
>> >> >> >
>> >> >> > Before we get too deep into the details of the patches, please c=
ould
>> >> >> > you do a compare/contrast to Greybus.
>> >> >>
>> >> >> Thank you for the prompt feedback on the RFC. We took a look at Gr=
eybus
>> >> >> in the past and it didn't seem to fit our needs. One of the main u=
se
>> >> >> case that drove the development of CPC was to support WiFi (in
>> >> >> coexistence with other radio stacks) over SDIO, and get the maximu=
m
>> >> >> throughput possible. We concluded that to achieve this we would ne=
ed
>> >> >> packet aggregation, as sending one frame at a time over SDIO is
>> >> >> wasteful, and managing Radio Co-Processor available buffers, as se=
nding
>> >> >> frames that the RCP is not able to process would degrade performan=
ce.
>> >> >>
>> >> >> Greybus don't seem to offer these capabilities. It seems to be mor=
e
>> >> >> geared towards implementing RPC, where the host would send a comma=
nd,
>> >> >> and then wait for the device to execute it and to respond. For Gre=
ybus'
>> >> >> protocols that implement some "streaming" features like audio or v=
ideo
>> >> >> capture, the data streams go to an I2S or CSI interface, but it do=
esn't
>> >> >> seem to go through a CPort. So it seems to act as a backbone to co=
nnect
>> >> >> CPorts together, but high-throughput transfers happen on other typ=
es of
>> >> >> links. CPC is more about moving data over a physical link, guarant=
eeing
>> >> >> ordered delivery and avoiding unnecessary transmissions if remote
>> >> >> doesn't have the resources, it's much lower level than Greybus.
>> >> >
>> >> > As is said, i don't know Greybus too well. I hope its Maintainers c=
an
>> >> > comment on this.
>> >> >
>> >> >> > Also, this patch adds Bluetooth, you talk about Z-Wave and Zigbe=
e. But
>> >> >> > the EFR32 is a general purpose SoC, with I2C, SPI, PWM, UART. Gr=
eybus
>> >> >> > has support for these, although the code is current in staging. =
But
>> >> >> > for staging code, it is actually pretty good.
>> >> >>
>> >> >> I agree with you that the EFR32 is a general purpose SoC and expos=
ing
>> >> >> all available peripherals would be great, but most customers buy i=
t as
>> >> >> an RCP module with one or more radio stacks enabled, and that's th=
e
>> >> >> situation we're trying to address. Maybe I introduced a framework =
with
>> >> >> custom bus, drivers and endpoints where it was unnecessary, the go=
al is
>> >> >> not to be super generic but only to support coexistence of our rad=
io
>> >> >> stacks.
>> >> >
>> >> > This leads to my next problem.
>> >> >
>> >> > https://www.nordicsemi.com/-/media/Software-and-other-downloads/Pro=
duct-Briefs/nRF5340-SoC-PB.pdf
>> >> > Nordic Semiconductor has what appears to be a similar device.
>> >> >
>> >> > https://www.microchip.com/en-us/products/wireless-connectivity/blue=
tooth-low-energy/microcontrollers
>> >> > Microchip has a similar device as well.
>> >> >
>> >> > https://www.ti.com/product/CC2674R10
>> >> > TI has a similar device.
>> >> >
>> >> > And maybe there are others?
>> >> >
>> >> > Are we going to get a Silabs CPC, a Nordic CPC, a Microchip CPC, a =
TI
>> >> > CPC, and an ACME CPC?
>> >> >
>> >> > How do we end up with one implementation?
>> >> >
>> >> > Maybe Greybus does not currently support your streaming use case to=
o
>> >> > well, but it is at least vendor neutral. Can it be extended for
>> >> > streaming?
>> >>
>> >> I get the sentiment that we don't want every single vendor to push th=
eir
>> >> own protocols that are ever so slightly different. To be honest, I do=
n't
>> >> know if Greybus can be extended for that use case, or if it's somethi=
ng
>> >> they are interested in supporting. I've subscribed to greybus-dev so
>> >> hopefully my email will get through this time (previous one is pendin=
g
>> >> approval).
>> >>
>> >> Unfortunately, we're deep down the CPC road, especially on the firmwa=
re
>> >> side. Blame on me for not sending the RFC sooner and getting feedback
>> >> earlier, but if we have to massively change our course of action we n=
eed
>> >> some degree of confidence that this is a viable alternative for
>> >> achieving high-throughput for WiFi over SDIO. I would really value an=
y
>> >> input from the Greybus folks on this.
>> >
>> > So what you are looking for is a standard way to "tunnel" SDIO over so=
me
>> > other physical transport, right?  If so, then yes, please use Greybus =
as
>> > that is exactly what it was designed for.
>>
>> No, we want to use SDIO as physical transport. To use the Greybus
>> terminology, our MCUs would act as modules with a single interface, and
>> that interface would have "radio" bundles for each of the supported
>> stack.
>>
>> So we want to expose our radio stacks in Linux and Greybus doesn't
>> define protocols for that, so that's kind of uncharted territories and
>> we were wondering if Greybus would be the right tool for that. I hope
>> the situation is a bit clearer now.
>
> Yes, greybus does not expose a "wifi" protocol as that is way too device
> specific, sorry.
>
> So this just would be like any other normal SDIO wifi device then,
> shouldn't be anything special, right?

Wifi is just one of the radio stacks that can be present but there can
be other radio stacks running on the same device and sharing the same
physical transport, like Bluetooth, Zigbee, or OpenThread. The goal of
CPC (our custom protocol) is to multiplex all these protocols over the
same physical bus.

I think Andrew pulled Greybus in the discussion because there is some
overlap between Greybus and CPC:
  - Greybus has bundles and CPorts, CPC only has "endpoints", which
    would be the equivalent of a bundle with a single cport
  - discoverability of Greybus bundles/CPC endpoints by the host
  - multiple bundles/endpoints might coexist in the same
    module/CPC-enabled device
  - bundles/endpoints are independent from each other and each has its
    own dedicated driver

Greybus goes a step further and specs some protocols like GPIO or UART.
CPC doesn't spec what goes over endpoints because it's geared towards
radio applications and as you said, it's very device/stack specific.
Once an endpoint is connected, CPC just passes a bidirectionnal stream
of data between the two ends, which are free to do whatever they want
with it. A good example of that is the bluetooth driver that's part of
this RFC [1]. I hope my explanations make sense.

[1] https://lore.kernel.org/netdev/20250512012748.79749-16-damien.riegel@si=
labs.com/T/#u

