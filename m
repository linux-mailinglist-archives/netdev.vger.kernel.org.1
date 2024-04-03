Return-Path: <netdev+bounces-84654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8753A897C03
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 01:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA0928B375
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B92156663;
	Wed,  3 Apr 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfgYZ1Nh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F53156227
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186718; cv=fail; b=FvI97Kb8QZZUl+ciPjptweDcj3jFahqICt5scJ2gg9rwIdN9HoSfDxFXEKGWMZJ6+8ZO8m9iHYTiuSGkirwZl0odkUxKsBNzgkhyyLc+OgUfG3Nw0SKt469ZiH4+WjYJNJd90uBq50Stb6VQYnJHNkZ0rg7VFoYoCqPTvz/7xeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186718; c=relaxed/simple;
	bh=2e/QWVTxY3sdI6lNZp/2yO+YqjCmDSmbegiE8S+eiy4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uCmiX9X0NWj9NdMzONLYpSJ/YHRAMttkZaXVdMgyamMIGqIbMm0Awm1Y+DcAO4vHghm7/EfkgwAu6l9JpRg+BSIcu5qPOGGnq1xpgTSfseXaPztLWCbPTp/7i/3hI9fXIYfwzcCLv0Nh3SjawmEYdBbMtwG9agfQ29qrHjPIGnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfgYZ1Nh; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712186717; x=1743722717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2e/QWVTxY3sdI6lNZp/2yO+YqjCmDSmbegiE8S+eiy4=;
  b=hfgYZ1NhNZXLQZprgSd3ll9YFuU6UvmLER+6FcP1ihz+YW6S7ooOfzuj
   YFTBrguzgIJnVabNKQVS3xlDMFj0/AWlOPR7O1PXC0VMpnvSlk9zMi5Lp
   2oKcPwziCTAzZsvhPfwrWfj4h5PauyLglPJGmi9S85VIQW2FNvzeWG5eo
   nwlv6rPlQj1BnUDV0r4Dwlb9QTwZeVsYQEicHa3hikXoZyNsTw8FnZIbw
   RxIdJzWNlzl+4gzbfU8lYOJ7ofw34cWtfGwUjssrIrH6jf7Mp8RgGKWrv
   IbtAI78N9g1efDxDe2z0YYZVxuTnIc2okgnjpO0daR5kuuQg1bTXRW/YT
   Q==;
X-CSE-ConnectionGUID: Zdo9qaY2TB2yPaXymBQ6pQ==
X-CSE-MsgGUID: Gp39gIW0TFqFtlAR9lqRDw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="24958191"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="24958191"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:25:16 -0700
X-CSE-ConnectionGUID: XC/xIKXOQpqsrXKxoAhMfw==
X-CSE-MsgGUID: OMUJdOfiTOOg8AtRXPD0Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="18627195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 16:25:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 16:25:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 16:25:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 16:25:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQq6MbUa9Ys4zyH6b8UQPxHZBZfyW/et2CYT/3uhFKbr13+YDJH48YLmnugvyhVy50jJhtIOCBuPJhCRAFM0tKunId6nUyvjvS3w+hApJM9SH42UCWQme4dvvwAv2VAykZNVu2Wx0iQ/MoFzOMl56u9WAayKKP44jqkFo8v2kIOrH0OIUDsbDhiGPTAs43GqfWIPsiX6ARv6uomfo7ooI/X7ap8L4k137LuEKb6Nz/iMy4YeNNI5w/G+tOholXmA16HDA9yjDzugLlP4RU9aXHKXdSp6+lAD1c0VzSeZSmNz2oMIaoC2HwjsAhbWwHRYLDoH+LJebVHLTafTeEB/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHp0g+i/liIUDKlLn6B3zkQ5Ckl6jaweqUkQ7RHVyFQ=;
 b=D1iOUGj1kgcypsveZbkA3PP09J//6hMlX+UhIsC6P5h3oRMk4aVRsTwS7SDPQUM7KvdmGXH9k+O/SkGBn+0ACQ2smAyVKhRWhBhzIQgDchfPQ0D4bgI8O3hhaAICkuUDunuS1FjxkwfM5jotbTTaMwrL1K+VNA1f4T+VQeegVBXW5sUS95Dy/YPXbmINm4VwnaEyoyYe0Fp0taDFn5sWwTk1wgPugoI8UvgMwRi1KoqnwXy5J9kx08ZcPYq9kP3LzPRP0vbIBzn4hRTrjh93ikW95Eooc489pGMeV3xPR+X638TssvOMqFHW2CmgZFoQ3NcAWA7tUfLPtMAbC/pe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Wed, 3 Apr
 2024 23:25:11 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 23:25:11 +0000
Message-ID: <8b263ecc-7959-f470-253e-c676af36f406@intel.com>
Date: Wed, 3 Apr 2024 16:25:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 iwl-next 01/12] ice: Introduce ice_ptp_hw struct
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>
References: <20240329161730.47777-14-karol.kolacinski@intel.com>
 <20240329161730.47777-15-karol.kolacinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240329161730.47777-15-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:303:dc::11) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA1PR11MB7272:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rS/OyI1q2uYlTThNQrfKWb3YRq9h7pRTfb0YQw28DhDD0gvKso1fjAMJ+a53+5eBOCcyeKVFE9Uxum5L832znBTsY+lbTs/tMBl840O9rHfEI4Ec9voc/9rrHsp5d5hjJRRgrvyOaN88QttmH/RCi/dB5xnzJufvwj4bCwATzEyZpZY4mTeKI82QNVNTc3q5d703LqPAYiMWmk+c6XoQePUp54j1LIC1wrnjo/5B5VYp8xQ+i2gTReqb/nUxehKlrdGskD/MG2SdG9P7kKcDliCIWjQLzRC2YNls9XmPiLo/aZ1uWwFwNt0q1oHMpI7Ekuz0EVOru2f5qmnjdkGAXuNJ7SvhEnL3HNPuIlDu6l27ZrqIVxoXw7yEruW4cXqWyUudNGl2rvGUJ7hDvBfn27USFuoLWrW7E9NysGqPUpn6Znfe1b22c0eRDkEtnKUMK1mTINh5RgFsgKC+Wrjar3kl/feNHUet/aTwHv4d4ZvP0ZSiImNYAgKV903bTdLFN6PpjJSqP7VWQr763ONHNoX3OvVabAu0MeZVaI7ZRc+djp1e3+U54JNw3nqtAzbMeHEd/Ui6rTLfKFA05gcpIyEqqnkzSVaLOCjeKZyFYkMzKooA16K3PiuHw7VZBIY6vH63BqfYWsn/8xCi/XsA6viUy5R6UJM1P57eXIWvsUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUR6QTB1V3NVMjdmVFhFaXNHRzI0TFVGeXJOYU5LU0xDb0JEL0pmMjFHbkpz?=
 =?utf-8?B?c2ZOazIxN2ZXRVZxN0RIYTkwaWdJeGVOZVpnRmttS0I1blpQTlVSRWljMDc2?=
 =?utf-8?B?ZVlOTmJ0NTNrRU1wdmQvc2YyOVEyNW10dEdhSGFnUkRBeDNpc29zNW04Qk5q?=
 =?utf-8?B?YzBZMXpNMG5NSE9IRGI5SnhWVVp1TjVHaXhybHFtejBIVkVJdmtkK25SQ1Nv?=
 =?utf-8?B?LzliNFVObnVsQmFYUVRla3FMN3F4ZXoyMFJ1UkVkblZvTitoR09QWDhOa1NI?=
 =?utf-8?B?YUdJU0JPSFBCam5mRzhvUGFmUDV2VnRsSjlhZXNuQjVYTys4dzdqTDU1RUx1?=
 =?utf-8?B?dEpRTmFid1hGVVVJRWs4WVlpUXhSdW5CWlV1Rk5vQndKSm12NStPVTNLTXEz?=
 =?utf-8?B?SmdnMjNwd1lBYVl6Z0ZmUWg2VUhnNVRIS0tCdU9MeWJBM3hXc3YzTG11Vlpl?=
 =?utf-8?B?bWxkVERZYmJMckQ3dG5IZHdjK2RTdlVKcE0vR05WaEcwYmZFMWsxUnUzS2tE?=
 =?utf-8?B?VU80Qm1rTVNZUmZiOW1TN3BrSGEzblZOTHcwaU4rdllrd1FqOGw3dXFyVWFV?=
 =?utf-8?B?eVhWb0dGTzcvbWhDN2R6ZVpvZUt6dGxxMVNBL213WVhwTktaZ3NaL2wzbVRF?=
 =?utf-8?B?eWMzT0VSNHFuTitrZ3MxSUN4N3dPZ3RWV0E0TzVpYkk1YmZWV0c3WWFpMkF1?=
 =?utf-8?B?QVB1cnd3anpsckZ1dlF1R3hwWjIvMTZSck43eHN6YkNLY2xvTXEwWHJhUzJK?=
 =?utf-8?B?YWRsMFMrWDRkK0lhR1NrdXFmeStGWGJEWE1vdUl0NGNCL1k3bXlzMldicjNW?=
 =?utf-8?B?YkNKcWV1SEpxRWlKd0tlbFBoR21OVm5mWktoNXpvMHVaVU1wcnZVcDF4K2Rt?=
 =?utf-8?B?SFJ4dnAxYU91WS95S05yRmxtakJEaWdyQWJVTUFzVld5NWJaTzhMZmUrZWwv?=
 =?utf-8?B?K0orcHh4OStTRUtJOW1QRStQZXlhZmFQMXRvSEZjdWVSMGxyb1dtUDE5SU80?=
 =?utf-8?B?aThlNDQrWGl0THJZZkdyWEhQYUR2L0lJRGZwRExzTDNUMFQ5N1VqWlBJdnZ0?=
 =?utf-8?B?Uy9yK1RGTEVPNlRwUi9TZnpYSWxBWng3Yy9qVmFLYjBDOU5yRWlyQzJPd0pK?=
 =?utf-8?B?Z0hLTGd4K2YvSlVlL1pLczArdUcwNW1LaXJDUUhCa0VMUlphT3hVOE9kTSsv?=
 =?utf-8?B?VG52Z2pmZHNWOWtlb0kwUlVObGV0WGlpeFJsejJOL2Q5WGdRcDBOWjEwWXVV?=
 =?utf-8?B?a0JzaVdNSE92WXlJL2ZCd2k2M2JOVW14NW12SEdpbVVJUzJHQ2NRVVJ3U0pM?=
 =?utf-8?B?eTdwdjZTUGc1dE5QZnE3VVg0T3Z3N1oremZ2WndkK2tGWFdyZjhRVUkxOWp5?=
 =?utf-8?B?N09ETDQzODZWSTkzZytzNU9xd2lRMHY4WVliYXRSa0pRVWFLSFB4ZnJ6WDJG?=
 =?utf-8?B?M0huZ21QaVN0WEh2NTVZQTBVd1dMNXZMUFlGQkNjMkd0YnREak1SUkdkNkFu?=
 =?utf-8?B?T29TVzFveTRpTDFxcWh1a2RaTVBBYXB1QVpjdXBDa1U0QW9CbjFwVXN5UmI5?=
 =?utf-8?B?TzBvZFJNMUkwdzhwYnl0RG5oR0RGaTB1RHFnc1dHYzFybzJnWTJiSDBoUk01?=
 =?utf-8?B?Z01nRzI5YiszQjJ2cXdyMEtNNjcrSWFESy9uNzJKT2prQXRESzdUWkNwbENk?=
 =?utf-8?B?aVdybmdEaDFITGw0cXVCalpCUEpnMVQ3ZkxrSFVJL1pkQjZFQ0FHdjZOaElI?=
 =?utf-8?B?MFZJRVcvRG03TlVMVFRDZEFBMnZwRW5Ta1BTbkIydVI0bUVXQURuRXE4T3Bv?=
 =?utf-8?B?bTdyeU95aC8vcVd3SHNHWmU3a1ZvT1FRSUEvS0IxNVBVaWp3THFVenVQWjJw?=
 =?utf-8?B?akwrN3VLS3JsYzk5MEdNTUlxVUk2MTFpd1pDWkoxbU9TUEpKMnlaN2d5WDdj?=
 =?utf-8?B?YmNVazhteEFNRVBTNHhCbGdHd0ZzVk9ScDBOZFNGSmJCOXBLa3RhRHE0Q1pG?=
 =?utf-8?B?SHJvamd4cWhNQUpWNG01NGxDdDVCZEg5dnUxUHdQbnhNY25oTUcrMlBKd1gv?=
 =?utf-8?B?U2JNa2w3dEN1WXNidG1iY3NsV0RQVnA0YjlqbTFWZEF4Mi9RSDRIbllhLzdF?=
 =?utf-8?B?SlhJUGQra0lPbG9YSkZ3K0lxUkhwQ3U1czBGWXlKVTFWUzBiMGtJUWhvands?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5506a206-efcd-4ee3-8282-08dc54354eea
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 23:25:11.5713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9IiAJ2QYvN4aEkjDVf39cOKdYMVFwLIhxnjMrtJxXNvk5eLNqm74hg9uTfg/7HAfcGeaQ9+XLTk5KyKQWDLiM1ZOq1aBrxrh7RZWLDsmOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7272
X-OriginatorOrg: intel.com



On 3/29/2024 9:09 AM, Karol Kolacinski wrote:

...

> @@ -1229,7 +1229,7 @@ static u64 ice_base_incval(struct ice_pf *pf)
>    */
>   static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
>   {
> -	int quad = port->port_num / ICE_PORTS_PER_QUAD;
> +	int quad = ICE_GET_QUAD_NUM(port->port_num);

Need to readjust for RCT

>   	int offs = port->port_num % ICE_PORTS_PER_QUAD;
>   	struct ice_pf *pf;
>   	struct ice_hw *hw;

