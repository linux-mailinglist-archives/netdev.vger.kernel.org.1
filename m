Return-Path: <netdev+bounces-100767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3C48FBE80
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609A41C23E12
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A771422C2;
	Tue,  4 Jun 2024 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtaOjgn3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0C313A41A
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717538904; cv=fail; b=akMMAQmi9VcL21yjsGqF1/gx6jT/XlBv/gWUwZt+eQwX/x78dlF4Xl1Kc8GXg7OyJfC+K0qRjAopOvAXNx5BjNFTca+Frj/GRFJGCq2JoavB5CqAlPoUWW9+zxKTwhzCbyA4iLa8lV8fyriI5vlASUfoyILuHS7+DbypxCgmnAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717538904; c=relaxed/simple;
	bh=vQ8iD7/Gj5pVesMpsrSLmquERgfcPSxncbx1/DfT2KY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QKc8TodYkID0KXCyaxpUtJmgV6i74nQg4h7HuRmccBPmN3oEHQMoZ3JHwAlMJRZZ8E1p//27rqdtnZQCtP3uGAdqcCqyEAT3B2fhkKzCbQDBaxpoADNKiSFhYJtYNcoOmkd6FADSbQAPbs4aIxkKX/XFM5e4QiBFWIiv5naLMTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtaOjgn3; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717538904; x=1749074904;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vQ8iD7/Gj5pVesMpsrSLmquERgfcPSxncbx1/DfT2KY=;
  b=RtaOjgn32yhX9QGFY/2xOedUfOKQgCHTbrawWrjJ/T9GET2hVZnfidrC
   HFfxFbwZwRmF2Ews/Wt/ejkZY7zjmeLYNxcUaoI6UnH8u8M1OF3mYAzpq
   3d+SzaIY7Px95todHcs8o0Vcpd0T8c0NN7jFB2vL4PxFwLWwKqYbXJho3
   w5Zp+gWMkcii1WNSN7sx15vY0ojunc5mqoooV5LWAsncciiPhvIlJQH8N
   oCFF6Nd3LScztBH4Er/FFCRiM5HBSqryd47LB82An12dH3O0Tixpz2b1Y
   q41ekUUqc4y9YaD79ad/h6pdHGGZTSqbJ5tXzAgnXSOk5m/MUfI2Fksya
   w==;
X-CSE-ConnectionGUID: zctesVi9TNCR5C6YMn6DTQ==
X-CSE-MsgGUID: X3JtbQLfRD6TMewj+9Cd5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14000453"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="14000453"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 15:08:23 -0700
X-CSE-ConnectionGUID: yxPFpEMNQeC6fY4xC87TnQ==
X-CSE-MsgGUID: 6Ft+80m2Q/+tuSr78+uOrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="41923737"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 15:08:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 15:08:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 15:08:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 15:08:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvpAY3Zim8vuZZgKRCDET2OU5jruroPzZ+YnS0/HsaAmR/h1z7sqwRmyACHUF29ZupWGEiBklp6dMEGm0/RtTYE2kxBaRfOiXWAMfnu1TrSiq1b5kCgOXfVMikfLy5OrL39mkcO/R2CXna1SYwppgMFIQaz0s6tp9Hlwzngy1VAwg2AH0G9wLiW3R1PuP58S1eSvBCdCvEWjrJq0r3CRP9qQ/h/LvazNN+e/t77axpG8PF6PDpGrZ5ebzFdzpGdZ5LbjsPAb9tArhZsM9sWs26wI/JpGut3Bh52qY8eMwcaFdyldZKOtQrSyOvzmWXMNA70ofJpzs47HA0vqnAzHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuRCg3kuFa+eDzfokr3sSLcBZ6znpX79kBEde1hHAic=;
 b=P98B4lp6IpDnTb3/rGIkWLHguBCprz80glPREUCBBtW2biYanHYhHd2kRNIg2PnMUdoWS9MnHd0W3Jmmtn3VqxMh5vzU7eQZCgY1VAlU4sPhyaZvnyvA/NEloicUFRHx204MweRpRlUo75GWMjXMXucw2U55Eqx0T/GjJ3hmX7lPBgvH7lJHbKp7S2popWd51S30gVIkPeBgZ3FQByVzagKyyLrI/E9TTaUatZuvJ9V24erokwI6ve7Z6aDhBlUqhv7quitlMfUotIhuiNgYwSTxI+iAUM2FcmddYxLXEz2hzQtL1uay4BAi87xNppTzIFWEnUcDoC6UobpQyqZD7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 22:08:20 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 22:08:20 +0000
Message-ID: <c65d1754-7a41-4860-84fb-438295b3526a@intel.com>
Date: Tue, 4 Jun 2024 15:08:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 07/11] ice: Introduce ETH56G PHY model for E825C
 products
To: Simon Horman <horms@kernel.org>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev <netdev@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Sergey
 Temerkhanov" <sergey.temerkhanov@intel.com>, Michal Michalik
	<michal.michalik@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Karol Kolacinski
	<karol.kolacinski@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20240528-next-2024-05-28-ptp-refactors-v1-0-c082739bb6f6@intel.com>
 <20240528-next-2024-05-28-ptp-refactors-v1-7-c082739bb6f6@intel.com>
 <20240601103519.GC491852@kernel.org>
 <10ffa7ab-0121-48b7-9605-c45364d5d9d4@intel.com>
 <20240604092847.GO491852@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240604092847.GO491852@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 02805def-f81e-4442-591e-08dc84e2d816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0NHcGQwZmZPR0FVQytIa29VU2lreXpNcEl0Z0cxYkhoZVFKdkVZK1UwRExZ?=
 =?utf-8?B?N0VJbUMzQ0tNNDREVjh4UUZHSWRHQzJ5TkREWnlwcUFsd1VxS1hNQlFoQTAx?=
 =?utf-8?B?aE5YVk9RQ1ZUazB1OXhtTGpsNG10VWRoTkdSMkpMTmF3Uk1pb1plRzN4cG1R?=
 =?utf-8?B?eStjOC9OeFBtRW5LeTdLVk1OaHk4V1lVQVhGY3pCVVZ4dGlVNmlBTFFyRmw1?=
 =?utf-8?B?bXBvRHVFZnVDZGsrTXQxdFRnQUt4R3h5UnpBMkNKMWx6czRQWWVCbVRpOGkz?=
 =?utf-8?B?VGNtemd6cEdSb3dUSGxadlBXdzZqaWEvUlRCMXNVOUtYeHhkeklSczA1TDBm?=
 =?utf-8?B?RkFwNDd5ZzRtbGpRdndKOW8zMXYxL2hZc05qTDJSTi94R2RYV3A0RDVpM2dH?=
 =?utf-8?B?STZua1pvNGlKWVZBS3dIN1QwWnFNdFJ0cHYwUnN2WWkzYXNKRzNQWUZmRVBh?=
 =?utf-8?B?RGRReFNXRU1sQWlueWpEUUs2SG1YMFB1ajFYYitZVDBQdzdyblV3a3h6UFE1?=
 =?utf-8?B?TE1ZMUZUcjNLK1lJUFNBN2Jld3JCYjJjLzVmT3BPTUQydnIrcVhxeUw3Vm1Q?=
 =?utf-8?B?cEIyc0RhKy9qYlZyNmg3QlhUYjlrYm9DV0xQSzBxK2xUR09ZdWhRT25VeEp1?=
 =?utf-8?B?REJ0ZG5VVkJhTmkrQUp3MmFJNDdxWDFoaEdmbzZWZUJsSEduZTJwbDlPWHZa?=
 =?utf-8?B?bnFPdGJ1bHRMWUMxa3FCbnFOd1pJQWRwWTJicENmSnprWGRQaDErVEU3NW5Y?=
 =?utf-8?B?Y3RmUVZRTDdyaUJreENqaUlTS2V1bU1UUTluQmlmSS9yenhLa3VERGtpcEJn?=
 =?utf-8?B?K2xOcW00ZEVSYW5Sa2FrdWYweE9rU0h5THdNWHd4WTBWOVhrZWVzdVJzSlox?=
 =?utf-8?B?MFpnUjVUTUR2eWI3dEdMbHovZUQva01sMlEwdzNJb3EzZGNVSGRFN01jK3FB?=
 =?utf-8?B?MWt3Y3Y0Q0c4YzRjdVpIcTRQTFh3YTNhcnpIclM3L2xzOHYzUXVQRFZnYTQ1?=
 =?utf-8?B?UEN6M0gyMFVYeWNmUTBLa3h1SnF2MEJkWnlXSmVCUTh1cnBYczNxZWpQVXYx?=
 =?utf-8?B?M3BKTFN0c213NXRKVHE0REwrMDRKNXRvVlJwTXBWcnNOTE5kbmdyTy9VRUNS?=
 =?utf-8?B?ZVkvUll1c04wQm1nODZrUVRYZ2IwR2JCbGY3VkhaVXhVQm9IdFE4MWh5S1Zl?=
 =?utf-8?B?cWYvSzN3REgwVm90VVZIRU1yUFIwdk50Z0dXTTRrN214UGFaQ1p4ZmJORVJz?=
 =?utf-8?B?aktoS1pGVXZPU0ZVMmNOL2R4dmdIK0tSTEpKcFZvWlFCQS81NGsxS2NiQ3hj?=
 =?utf-8?B?UWN2Q2w1dTRXdjVMTUZWVkhjbFpQWFRBYitoUE5mRHBhbHl3QkxPcWw3T2xl?=
 =?utf-8?B?NzBHZ0hoYUJpaGJ5aklPYm9ydjdNREc2N08wMzdVNW12RVZiL1duelR2VTlH?=
 =?utf-8?B?SkdTVSt2WlMvUTRPN2tTRnMxMUg2RDFlMGFNQWgzdTlhcXlhUjg5alM4Zk1F?=
 =?utf-8?B?Y1JLTnl1R056TmhhM1JadUJMZkJEQ0RTZVBydFhtdGhQZjNCTTFPR3VMR3BD?=
 =?utf-8?B?TjhkS1pOTWRaa2N6Q3lSUktYamZ4QTdBUkdEMFlQZTd2elUzK0wvZlRIYVVK?=
 =?utf-8?B?ZUJ6RWF5bm05SlM3ZHp1N3p3YThETmtnMi93NjVxdXd4MjhvUlIzQ3FCdThS?=
 =?utf-8?B?b0ZHOUoyV3l5aEpiTHd5Wkc3MkU1Q2E5SCtzU0RPVWM1TW4zalNJMVNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlVtVWQyRUUxRnZGbjRGTkR0U0phSlk0NVN4Y0dabGpMMmFkVWRWYnBjQ0E0?=
 =?utf-8?B?K2c1bm9uMlpDWTBnS0VXMUNEeHU4UFdrQjVNSUFwTWJFMWxtZG01TmhyNURh?=
 =?utf-8?B?MHBjVDhhcGFKUWRVMzJpZmw1NkRaWnhnei93Vks3REphQUIvTUR6Qmg5a3d6?=
 =?utf-8?B?eU1VTzZSMjBFbmY1VldnWS96MlBiUUs4dytFTjdBVWZ1SThtNjZlZytCQmov?=
 =?utf-8?B?UGc2NmNqOFpRZHRuemtxQXJ2WXFadlg2Ui93aU9wdzc1b2NHTm5KWHNzRys4?=
 =?utf-8?B?RVpSN2JLNHpaODI4RmNteFJPYVQ1M29vZ0ZkcS9HVUFNUmMvZ29TTGNPWmFB?=
 =?utf-8?B?QlBRN0xwNHVjRzVmcXlBenBUa05Sa0ZkTlpFNnUzOWpjUjVpM2c4S0hXZWRk?=
 =?utf-8?B?eDlXOVBzVmJ2aHRwYjdwbkxETGpBWXpmenIzaGtQQ0RnV1YycFpuSVFHNHBm?=
 =?utf-8?B?eDMvSkN4a09Vc25EdWhRcG5ITktKbVBWWm5yZW9ReDJVa2lpeE1XcFJwTExa?=
 =?utf-8?B?dWp5MHVjMGU5UlhXRU9HTURvUHhzTC9zU01mNGRpamJuYUVQeXQvMzIyZmVm?=
 =?utf-8?B?NVZEYkRPZEl3ZldUNjFLenExUmVackVHR1ovL2VuMVdYNy9JYUVRNEhVSVVs?=
 =?utf-8?B?OVBScFRMTVYxMWpldVRGYlZrRlIzTndRaDFRU0VFb1dkK0dNTmR3d2hYQUVi?=
 =?utf-8?B?ZU1QaFBkKy9tYVBSS0ZLRGlJYkJnZklmNEVNVk5QZzB0T29EanVuQmNRVlc3?=
 =?utf-8?B?V1o0ME5STFpjbWtLcjhoVDk2azhyVHBXeWl0dnRsdkRjcEY2Y2d3QkhiSjlL?=
 =?utf-8?B?SWNPNlRkcHN0WFk4eFdXSWF2RUF3WmhjcERVT2FEVnZOYkFiRHJjVlBwaU5u?=
 =?utf-8?B?eTJHY1VZbG5tVXZ6MThCVXkyZmYvTGRFY3hINU1ZSkk1RHFpeGtvV0FIU3ln?=
 =?utf-8?B?VGV4U3NRQmNJWXhNRTBzQXBiSitjeXBtNE1kRStoNUVZZzZtcVdpK3dGYVcw?=
 =?utf-8?B?dnk3MXgzTEgwWVV2QWxVM3g3ekVpRVFvQ004OGFOQ0FoUnViS1lFSGIzYzRP?=
 =?utf-8?B?SkZLb0VHYnlydEU3YUN3aFBKVUQrODUyNzlPc2kzRFAxYXJEbjc1VFo1QU9L?=
 =?utf-8?B?VzRRcnZ1bmF5b0F3ZklMZThmZHM0V1FCblMxeWJPdFV4WVBFMFMyL3ZzQXZS?=
 =?utf-8?B?NTNnaDdXUHc4c01xVnNDRU1EK0dFSk5iaWJXV2pOV2I5ZXFESk85WlpaTjFp?=
 =?utf-8?B?TUdoVmYzUkVTVGI0WkNhTVJGVHVLbEw2d3pEemwwcXh4dlFDN1pjdEsyV1NU?=
 =?utf-8?B?TGRXd1lVVFR6eG5jK0VtMkZVOXFBaFB4cG8xd0duL3pqRlNseTZSUmIvQ0hS?=
 =?utf-8?B?V2QyNCtnSmVBczFiU0JzQXRPWlA5UitMVFBnVFd5R1lpNFFCeU41Z1IzMTRv?=
 =?utf-8?B?NGFDSTBKV1p2SWxJek1qaXV6MlBkSWhkdGVVWmFUejZjOUxpclVQM24vcGRx?=
 =?utf-8?B?TGFDN0xLVzBhMld6b3NMRmZXWXc4aE9qbzRnbHpMd3ppczRIekNRZ3NzOCtp?=
 =?utf-8?B?b1F4UXdhbFR3V2VQbjl6S3Z4WXQxK1ZDYm5hNHhJTkM1YXhxUm5XOHBMQlRU?=
 =?utf-8?B?TGZYYUpyU0ZnU0lSUDU1TmpkajZ4NlNHejg2dDlqRmgzb2t3UVNYR0Q4Yzht?=
 =?utf-8?B?bEFyUVd5eE5yRGRuZEJ4V1RTakp2cGNZQXNVRGdwdmF1ZDE0MnpHM2NlYWZR?=
 =?utf-8?B?THF3dmt4RS9SYW90NDg2RktlZC9DalJrMEs3Z0ZHU1M4MVkyK29UaUIzaFBJ?=
 =?utf-8?B?UndxVWFiZEhFMWNjdUoyaUhYVUxnTWczclBaY2V5QmZYMnVGeEFiN3ZET3ox?=
 =?utf-8?B?aHhCQlErbElENEZkUm9IS05nR0g0WUcxMEpGWWgwVzJVQUdNa3B6UHNQVmo4?=
 =?utf-8?B?eXRKZmczOGkrWVZiUFJlZmltVHNBbytDSUxRb2RRVzEwSWN6eTFkZVp4TGdO?=
 =?utf-8?B?UWRpM2o0TFhyVm1keW5jald1TkdsWHBNL1NseHQyLy9wTFVxanU3U05XUEVw?=
 =?utf-8?B?M0U0TUJGTmFoNHBxVjRpMFJyTC93RWVYbWMxSCtMYi8vclN1aDh5ajA2SEZI?=
 =?utf-8?B?RkpMWmtVTmJNSmoyd3pTV29VdDIxa040OEtFWGpPL2Y0em00aS84ZDA0K25i?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02805def-f81e-4442-591e-08dc84e2d816
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 22:08:20.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqJfeNO2NQngIgZhVjfHe/sKm1+1WSAobE41lG7I2kdBdvxlbjtXDJzI/IYpYlgtI3SIBIGny4jB0iNysG7XoZz/AlyTzmHuzlP9z7hSXm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com



On 6/4/2024 2:28 AM, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 12:47:42PM -0700, Jacob Keller wrote:
>> On 6/1/2024 3:35 AM, Simon Horman wrote:
>>> Hi Jacob,
>>>
>>> This isn't a proper review, but I noticed that your signed-off
>>> appears twice above.
>>>
>>
>> Yes it does. I developed some of the original code which Sergey used
>> here (hence my Co-developed-by and Signed-off-by). But I am also
>> covering for Tony and submitting the patch so I added my sign-off-by to
>> the end of the sequence since I'm the one who submitted the full series
>> to netdev.
>>
>> I'm not entirely sure how to handle this, since its a bit awkward. I
>> guess there are a couple of other ways we could have done this, from
>> dropping my co-developed-by tag, to moving it to the end..
> 
> Thanks Jacob,
> 
> I understand the problem you face.
> 
> Perhaps you could move yourself to the bottom of the list of Co-developers,
> below Tested-by.  But perhaps that is worse.
> 
> No big deal on my side if you stick with what you have,
> although possibly it will be flagged again (by someone else).

Yea, I'll try to keep this in mind in the future. I kinda had forgotten
that my Co-developed-by tag was here as-is when sending, because these
patches have been going through internal development for some time, and
responsibility and ownership has moved around a little. We also had a
lot of squashing and combining internal patches in order to generate a
suitable set for the list, vs sending a bunch of intermittent code.

Its definitely a bit confusing from outside perspective though, thats
for sure.

