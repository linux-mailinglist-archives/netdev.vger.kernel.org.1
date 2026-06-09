Return-Path: <netdev+bounces-296903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MglHKgOeJ2rgzgIAu9opvQ
	(envelope-from <netdev+bounces-296903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B75C65C567
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 07:00:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HMEO2HKa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296903-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6384B3007C98
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 04:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306F37C934;
	Tue,  9 Jun 2026 04:59:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD507261B71
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 04:59:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981192; cv=fail; b=bgK8RnWyK/dVH5WWwv51nQjTWAFhLOMYEfF2e6KYHjxNvscbkIRRsW6+Xnhfjyu8mgxgew5Q76pf2IMry7jHCxAJu2osaC3XZzCnDw/qS99YfPRql5kQU9ibBnfPURSaRHOufAoVlFVyB+l4sjWD3H7IT8EdLl7z95AWqks2b+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981192; c=relaxed/simple;
	bh=+sIRSeeFmIMmuH3rle1fpRX8SCbLLiz+VVga2++TUzo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RLBjJHYtI+ERuLZB329V78hDhoMojSwOFZ2CaMg+T1GlWtLuJ4y+ncBa2xWyTZU2lcnMUAoScTAQQSFDrcK/G2IFlnwCaP1GdLjF1Lf9NMVOx5kkKtB8x4/UskPEcMFb+tOmNsBrr1/WLN7gCR/UFM+vau0QWmRDouLkQb5WTL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HMEO2HKa; arc=fail smtp.client-ip=192.198.163.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981191; x=1812517191;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+sIRSeeFmIMmuH3rle1fpRX8SCbLLiz+VVga2++TUzo=;
  b=HMEO2HKaunVZuV7kdh6oLMye2x0TOWaPlzinHDbTFQXqC3x38QqX3L/T
   BtJFqE8+9u5Sej4TjfqPCvknrjWVFJrZVUcHFilDB6jK/B96uCSCEnNsO
   0VlylvtBT/GnxYiWrNoU/7WWf8moBgaWxyYlo3XimMsNfAGumTNZ+OXQC
   vGgXikG5r3x0Ip/K3+TcRNnZvzN2u3bvu//HySC9W430QZaTuMVfHfmsS
   mhiGm9odPHqwXDuDe6U1TJnnbTADOB1gSx3LnmosCWOA+E7jVvEAYfGgn
   n51wgHvvu60sKi2XczgxLK86HExZCRkDze/rmsaZTKTesP3pZtRqfEXfv
   g==;
X-CSE-ConnectionGUID: 1mlif254SZWM0waDZ0QHRg==
X-CSE-MsgGUID: Xxo/e+7nQbGYHt2HE1764g==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81585413"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81585413"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 21:59:50 -0700
X-CSE-ConnectionGUID: yxionmCoQcWez0lucvMBpg==
X-CSE-MsgGUID: xQv4FsD2RaWyUgbqs/R70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="275937020"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 21:59:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 21:59:49 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 8 Jun 2026 21:59:49 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 8 Jun 2026 21:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaZK4ccvzuqs3wDjW8nIlH9hom5vG1IE8SNJ83+AuhT6ba+yJghKit3LxS7XCyvq9Zu2scGCayFITA0usb0h4nrFMe6VlG5j5+VTb/RSSRmrEi/g4/yoBgVEWi57tF7MYnSuyZUoPPu4I6TCj2UmfMIII/FrNDqwNqW+s5oEw94pDa+xfx8C8YL1umpjsviYd5iDMvOKukWGolVeRj8wUaPBcOsG1sxleYnQgicLvb0ZOsg2AVahKAgDNH+mzzeu9BipPg1dLwmdFupqpeCClntD0cjTIbuoX3B7/L18e6l7srRKRlwEFPQ1tKoo/MnqopFIcC40O9zJNWyZms7ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+uYICsRKIIjrxjql52EWKcbP6Q9LjDY5WZvvrDF+Bw=;
 b=nmDfJ5GXk1UHuWEGn2dWLGZaQgeBbCpkM9KdxN/g7lSFEe6RrSHZMQBXhv0t7mRsGYXP0WV+z1/hjOGElzZ0yhm7WYGcdrUKvcyh/J/B9iHCsQL8dU1EC2Vy70+gW8/LFftf6zrJvdaMTssvS7QWtjhxN6MD+JqEkaAjUn35dHSYAXEaYoBFxrjTornXNLBr02rMUEfd+y0X6ysKNFJsVpNdiBftSrMeyVZjzI9qJC2U/NB+Hud+g0bY+YmKmlwJMQ4dtaTuLGQ407R23VOsqgQQGVlIRZSJX9gJXq57nxtYOi9dkljZiat2ZgI2DKOVA6tpnwN7Q7yuSGvCzIsfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.13; Tue, 9 Jun 2026 04:59:46 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 04:59:46 +0000
Message-ID: <f800e4be-05b5-4659-b869-be5690e72bbe@intel.com>
Date: Tue, 9 Jun 2026 10:29:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/xe/drm_ras: Add per node cleanup action
To: Raag Jadav <raag.jadav@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>
CC: <rodrigo.vivi@intel.com>, <dev@lankhorst.se>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <kuba@kernel.org>
References: <20260602044919.702209-1-raag.jadav@intel.com>
 <20260602044919.702209-4-raag.jadav@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <20260602044919.702209-4-raag.jadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::9) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|SA2PR11MB5002:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e28d20-14a9-4ec2-8664-08dec5e3ed2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O47DTy89JYXPKYlj58d0/qlLyozoQd2VOY112pJYvPP82NYDCWdHqmA0G4LKeQXEa2eDW9zbCivyhGot8EUGyPzf+VzRAtlKfSE9BhAdnYDJXXTVN6Rz5yMXfhQYQYEua0GMbc6mp+8hjCHNWdJVnOzJ2UR5/ygauLhx9xHIezNOtLsCNW2uIjOynCmym1NtbxNzhzlFgsmEEfwNZ9xzxHTT+0BjpDjc/S2B1r/deq6aw+OjJn5DY1SUNrEK3KJJmZyRiqgIlbVsrs2ezGjjQU5PAvJuVljmiDoB+N6IsdkHEkGRkJ+mEoKgAbtPdMSTFX74KUKMrM2ofiWUwcfOfQD5EjPFsAgypIgumRVXKFzkf/Kq0y+zuxZCkOfJie5c1CaeB6A2vbomjX/MVtbCRM/yegyLcmTg94dBvqjiQ8L6CsI/mbuvP0E1tuUWJEcx5zpZiIDteID/9sbElGWms0LQo5wPJCyFGpXiOK/YGzxveLIq94wFChUSJ50s8DN3BZJM4c/Itdfb5IEw6muNcJJSC5Gxr0VVfQ/TCPr+LQNz9osBh1sOp814ZPoagTIR5nau2dnLd+WkTPYzfjqP0CAK9xKSnjOFw77jgnvkasPJQ/g8vGVDoug4ZCH6viBgo1FfR9ozU9DxJZWIa/f1SYaJrsHoElnFrwzf9h7tqMpCxsdBOXVFVtDYUkx9zN7H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7958.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9TYXJaUjlyOThmSW1TRHBtdStCVVVhQnBiYzBMN25mS051OUl3UTdGdVFQ?=
 =?utf-8?B?QitKMG1TZEVtRzFhQnVIU1hoeWpFc2RqSnhET1orQlg4YWZtMm41KzVvZHRB?=
 =?utf-8?B?K3JZNk1BMzEySU5xaWhyN1BTVml6Qy85WDlCTTZtd0lINkw5b1JCYkx2enUz?=
 =?utf-8?B?bzhoZkxpMVUyOHpqVlVUbnQ0RmlWT0dqNTRINW5IZmNteXRTZE5odUpjbW84?=
 =?utf-8?B?VXFXRkJ3TW80a0psUlZreHVEa1ZzM002V0h0bXExcVQxREFvL0pRajdzZHdT?=
 =?utf-8?B?bHBNc0ttc2taMmg1RDZxbVpsTk9xbGMyK3JhQzBHbk1SZFl0MGZ2VFdhZXNy?=
 =?utf-8?B?SXR6NXFGNVpMTTJtTEdHSXJnVGNhcXd6Yk8vTVUrVGt3YVNSL3NFVnRsclJW?=
 =?utf-8?B?U3FnU3g3S1BaeENqQW13WVlDSyt0NW5xenppdHkzMDFmQ01ZUCtXVmF6Z2FP?=
 =?utf-8?B?QVFxaHNrRjJJUDNVOEpab1NDa0dpdVVIanJWQ3YzUG00RWgxcTdUdEVQcG02?=
 =?utf-8?B?VGFBczBkbWlNV1RXS2JwVElueUVPNXh3OGFwT29aYkwvbEZyV2djcTFTMENT?=
 =?utf-8?B?WUwwRkxuaW9iOW93SXAxTDU4bTZ3NEY5bndxb2RveVcyamVwcFNJT2pKYlJl?=
 =?utf-8?B?dnRtNWpPMERjUDEwbFp5L0hLS0pZMEJxYkZSek5ZMnhqN2tLS3hBMkU4RVlu?=
 =?utf-8?B?NE1LQnNZWHNOYnlJWW1aRmE3SmFZQmdodS9BWTFIcmowMTM2WnRuN3JZTnJ2?=
 =?utf-8?B?MzZmTEQxT2ZHRDNTT3BlKy9lN0xaclU5a2VFK3dkbWJtZ29ZbE1zZjlwVUNG?=
 =?utf-8?B?THYzUkVuWVBWRzhuNUJseXk0OHhhdjNra2tPb2lkaytUWEVXaGMzTm1xNDVR?=
 =?utf-8?B?TXRJdllIWXlSa2krMHNJWTdEcGk0Z3dmZGx3ODU0ci9USXBVUS8rTFJKY3Ew?=
 =?utf-8?B?Zmo3YktGK2pCYTZBUy9lamt1WEhHOXdFMEFDVTV1RWsrUVpQUzljeFFpY25m?=
 =?utf-8?B?NGFHZkRkY0wvdzEzRjhPV2g2c1VMRXAxV2JQamlCL3lKY3kvRzZCcWlZUEFM?=
 =?utf-8?B?NWpPc2tRaTFHcDhxWW1EZGhKQkhkcmxKWWVPWHcxdjlKQlVoT2lOSVd1eW5a?=
 =?utf-8?B?bVBEZmt6Smp0aUdwUE5GdllQQ2c4MDlLeFhHMWVIY21LZjVtKzlUS3JIa05D?=
 =?utf-8?B?Zk1SODNKZVE1bUFmSHRHb1ROS01WeW0zM1pNNGNlZ2NFakR1SU9IZndDdFFy?=
 =?utf-8?B?RjZsOGlnekE2TDdyS1Q4aFhhOU5VR1Q5LzFpNFV1RzZiYjc2YkQ4QWRvSnlo?=
 =?utf-8?B?VnhYa1M4M3J3ZDRZNmRrR3FSMW9Tc1BkWFU0NmtuWEZTbmJMQlFBemR0MXoz?=
 =?utf-8?B?YlhuVTllYi84OGpJdkN5TEVFYTRzWFgvdE93bjhEcHpQeGlGUWNYYXRPUC83?=
 =?utf-8?B?cFlzbDh0clRGWHd3blhqU1dHVGQwcThBRmR2QWg3QzN5OERHYUJydUY4UUU5?=
 =?utf-8?B?OXdsck14WVIzOGQzVnVNdFdDbTdIM2lxS29xRTFsUDJXTEtZdlBSaG1JK3J5?=
 =?utf-8?B?ZnN6MHVucGRzR3JjcGRPc0xtdlhiZk9DOHpmbUNFajNTNmZiTEszampZTE5U?=
 =?utf-8?B?Nk5iNndXdG1YOWlHTWd2azNtK29CU2l0aTRmWThKbHQ5bVBvL000SldLdmJa?=
 =?utf-8?B?Ukd6VlF6NGlkNzBla1M2ektQVGI2a0ZJQ1pYcVh4OTZkVTY4QmVvZW1pVFc4?=
 =?utf-8?B?Y1orQzd1RXllRjR3aTdKU3ovamVaaFFhbzAwTzJ5Q1FTaHV3WjkzK0d3a3ls?=
 =?utf-8?B?R0tDcFpSS0RoWkJyMFYvbVowK2k3blNuYUdTYSsvY09FR1AwV2Z2N2h3K3ZX?=
 =?utf-8?B?Vm96V1BuUkJGM0V1UHRpbGdhSEJzMlNldVdrc0RkWGFuWlN4RlZTU3lYZUx5?=
 =?utf-8?B?UFJJYXc1bjA5WlBUNk9QN1R2dGxWUVdKWkhJcG9RRkFXTTlsYUYrbVpUdXF2?=
 =?utf-8?B?MlVHOEFaa01WSGkvSTBuY2FFTGNVeFBSZWoxcmkvZHdkRzVIVmJBOUlyRHVv?=
 =?utf-8?B?Tzg1akdqMkpGNC9taVBHUE9aN1l2UjNvZkJzNDh6ZlZNaHBlWUFxQVZnOGVz?=
 =?utf-8?B?RXhlbEJOT25hYjZUenNwT2d1TUsxOXBUMXk3dDYyTVlrK1J1VFRpcThoVE5a?=
 =?utf-8?B?cmpXdkVKWEJxTm0wbENza3NsZ0s5T20xbkloQ01jQlJSeDA1RmFIQjg0OVJF?=
 =?utf-8?B?cUpKVXhjTjU2MWlTaTdWZ0Z5YURqMGgxTm5hRDI1Q251SGNBUHYyZW5INDFw?=
 =?utf-8?B?U3ZpTjYyZVEwUVgwenE5ZjFIZ2hRS2hJNmZHWVNnNWRZaWp2ZFgrZz09?=
X-Exchange-RoutingPolicyChecked: WbxM1g5NRC9Jf4DDG7qY6WKduDPoP/+uv3jKsyYkQa9lK+IQ0X30Z/8dhAv0c5odlWc+0f6SKdAh/QIjaXJ2nRFRa3klYwCQA1CmB9b/hXUXzv5nY5GyDIciwLYucdXoNtrVKEQ6GumQe+28wT8D1kYcklBmfdwoJkkvdNGzJGYwGq9qTIygiFLRUU80YqTeUp9N2voJ2CDFjjHY+RGygulVN7VHspfyg1thpGZDq9HGkM1sSqLWuyQAg1wWFXqTiyJS08GLIvOMcofXFcfcR1TEP8w2bLQfLdBjpvKlZSaGBf37mSLeXgy+Zds5H+j9aawBRk9WLUZYltHYj4A7IA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e28d20-14a9-4ec2-8664-08dec5e3ed2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 04:59:46.4047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2qf6WOXf2SwHypaDf6TvJznWPwWkew7t6SfsnNbsShBrcjejPQ9ieiCFy57Yc7cenX88T6ETppDddgJt6+PVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296903-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:raag.jadav@intel.com,m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:rodrigo.vivi@intel.com,m:dev@lankhorst.se,m:airlied@gmail.com,m:simona@ffwll.ch,m:kuba@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B75C65C567


On 6/2/2026 10:18 AM, Raag Jadav wrote:
> cleanup_node_param() is not registered for previous node in case of counter
> allocation failure, which results in stale memory of previous node that
> isn't cleaned up on unwind. Add per node cleanup action which guarantees
> cleanup on unwind and also simplifies the cleanup logic.
>
> Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

LGTM

Reviewed-by: Riana Tauro <riana.tauro@intel.com>


> ---
> v3: Prevent double free on drmm_add_action_or_reset() failure (Riana)
> ---
>   drivers/gpu/drm/xe/xe_drm_ras.c | 58 +++++++++++++--------------------
>   1 file changed, 23 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
> index c1d5ac198a7c..cd236f53699e 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -131,53 +131,47 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
>   	return 0;
>   }
>   
> -static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
> +static void cleanup_node_param(struct drm_ras_node *node)
>   {
> -	struct drm_ras_node *node = &ras->node[severity];
> -
> -	ras->info[severity] = NULL;
> -
>   	kfree(node->device_name);
>   	node->device_name = NULL;
>   }
>   
> +static void cleanup_node(struct drm_device *drm, void *node)
> +{
> +	drm_ras_node_unregister(node);
> +	cleanup_node_param(node);
> +}
> +
>   static int register_nodes(struct xe_device *xe)
>   {
>   	struct xe_drm_ras *ras = &xe->ras;
> -	int i;
> +	struct drm_ras_node *node;
> +	int i, ret;
>   
>   	for_each_error_severity(i) {
> -		struct drm_ras_node *node = &ras->node[i];
> -		int ret;
> +		node = &ras->node[i];
>   
>   		ret = assign_node_params(xe, node, i);
> -		if (ret) {
> -			cleanup_node_param(ras, i);
> -			return ret;
> -		}
> +		if (ret)
> +			goto free_param;
>   
>   		ret = drm_ras_node_register(node);
> -		if (ret) {
> -			cleanup_node_param(ras, i);
> -			return ret;
> -		}
> +		if (ret)
> +			goto free_param;
> +
> +		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
> +		if (ret)
> +			goto null_info;
>   	}
>   
>   	return 0;
> -}
>   
> -static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
> -{
> -	struct xe_device *xe = arg;
> -	struct xe_drm_ras *ras = &xe->ras;
> -	int i;
> -
> -	for_each_error_severity(i) {
> -		struct drm_ras_node *node = &ras->node[i];
> -
> -		drm_ras_node_unregister(node);
> -		cleanup_node_param(ras, i);
> -	}
> +free_param:
> +	cleanup_node_param(node);
> +null_info:
> +	ras->info[i] = NULL;
> +	return ret;
>   }
>   
>   /**
> @@ -206,11 +200,5 @@ int xe_drm_ras_init(struct xe_device *xe)
>   		return err;
>   	}
>   
> -	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
> -	if (err) {
> -		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
> -		return err;
> -	}
> -
>   	return 0;
>   }

