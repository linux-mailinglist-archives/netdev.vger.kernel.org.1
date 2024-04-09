Return-Path: <netdev+bounces-86314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C057489E60E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AACCB2186E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C88158DBE;
	Tue,  9 Apr 2024 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="culHpbtS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34081EA6F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712705194; cv=fail; b=Vf03Lf01KatGIVCH4xHdGA7TatyrftRoC6+AtTupVlq6a810uhmTh6jyyY5DPqqp8qLH6O0WL3xxU3WhdWEwTSQMQdKbQbg8RP/62yabo4JfbiQ1sYzNpnkd+oD0/UunttA7enxmfP/zWN8vPG9vfqpCs5FutTqrjI8AjooyYzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712705194; c=relaxed/simple;
	bh=JmIPXKe4ZFWDGi0qUlMPEfEVO0rE1p9Cmwj1kM6Yq7g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hsSaqT2+kYXOhzcl/VfoZKeUyubOQz+O4PulX8sgljz8uB+khJxr01qSXcWsnHjpLoHyYIKivAiy/e3clDgyIOGozHBi/5XgxKg0r/+ZRVw7d62NoELb7IQbpXv4BHDkZSbRFTn788Mvysz9uBBZFpnBxCFJTvu0XmODXZYd0EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=culHpbtS; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712705192; x=1744241192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JmIPXKe4ZFWDGi0qUlMPEfEVO0rE1p9Cmwj1kM6Yq7g=;
  b=culHpbtS7JyvSCIfMl/XfV6F9gTnfTuGqaN+59EiYK5l1uLleDzDvZWD
   OG96/h+gjWgrPkvLWGj4RknhMttdWR3z4AucUPxI1KQWv7/6vY3XostE/
   zfWb/HTR2yuGsbg7G1sL08/o+FuLvlb6U3k3zMESLrW/8bnLDpSuXr571
   L6NaSXt883eZB7cCkbqaNuLARoDF9GvQvpf/CNMhO1LIGl5I+Z2sSn0aT
   bHAmMlUonlqqb6CcEzA+BBWVrnsK1THfopFAnnDOZ1308Szwd0HTTfuK+
   L/Mc/f7NFKFzA7RlUVZpamOOltDN+bF9FWsS8E78Rlu53/wT+WNC7ff0M
   w==;
X-CSE-ConnectionGUID: jS/Bguz/Rqauyfn9kU2fFA==
X-CSE-MsgGUID: z3dsYV03RH629kuAOHc3Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7901929"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7901929"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 16:26:31 -0700
X-CSE-ConnectionGUID: MiP2VM78QWGjaXvfQjJ6lg==
X-CSE-MsgGUID: H8nhLKLLQrmOcx75xfC1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20350695"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 16:26:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:26:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 16:26:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 16:26:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 16:26:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PsOzeDaEgIzk3HFH/iwMR7P3qyhJ+dQR9JD51PhcAoEqf33ZR18Xe9Oq721GUYzH4yuCTK1dAxRsfj2yMd14xy4gcDpkpptsPHz+LWH4hA0GZJVXrdMTGcGChqti5uvH7BH6vC8EaUrJxBVL6aDtGF51qNngQFY5iMFzjbcQR8xBI2QvIJQvEOy3WPr6TIN2B/Qw9uqQJDtRw1V9r2yaFNDyEMtJCqbBYp+R+TY/c07Ge8Q4KMsAEIPP4wbsg42bYvPuCTNRwkQW53fTCHKI3jiIIssqsNCNkPZNJ04t8l8vsUlexjUx9EC3YBeyYlgSpzvjSU6fsmIEJdCSWB3Bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I5cEG9KNxuNCc4Vy9hTKczVO+WuPgLShweFSQOs5Io=;
 b=Jfbj1BiKjERYTiUgjScKYSmWonOorv82GYfBy3xbuPCTe0vTl/fOFkyUISN8Ixrq185e0OeQGcgoolYQHbPWm0xDiIraFbY3uN2wUCq4bzrZ8X6OHSIeIQAXXKmfP9IHTqj36h/wMWfV2ixFka9yzCdMq43QF5pjToNSHyeYQSvhNB33/J7CGDE2CZ//0jB0dYNUtojrDDmVQatxZvWNRMkhQEPwdZzQe1eKN8UrRGKIPHl/+IKHVQOwPzCV7ix5NvGwwZaBQgw8GVisBsJkZOPqQGWOUYGOaK36BIGJnAEQsWu7DWPXg01XbAll8ShbdUAerg360LCcPzR7z7UEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5905.namprd11.prod.outlook.com (2603:10b6:303:19f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 23:26:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 23:26:27 +0000
Message-ID: <721f07ab-4dc1-4802-957d-1e71524ac31a@intel.com>
Date: Tue, 9 Apr 2024 16:26:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] bnxt_en: Skip ethtool RSS context
 configuration in ifdown state
To: Michael Chan <michael.chan@broadcom.com>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <pavan.chebbi@broadcom.com>,
	<andrew.gospodarek@broadcom.com>, Kalesh AP
	<kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
	<somnath.kotur@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
 <20240409215431.41424-2-michael.chan@broadcom.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240409215431.41424-2-michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5905:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 44vYV4fDCKVxqqfgeGqfJopQRcLIFwpFhIrltoSydEtfPu+9ervhheN6FzExNdRVqv0nly/1qyTzRWO2Q9uDWiD46T3wvSDDQ8dmPXzXSkY6pNcGoXIx3kzb0x7ZjGI0tDSLpFVWC2lSBRLQSYS8nWsFgkF+2HsRkl9eztky0K15TvWG4dnFhONAJO9vNR/FsvSbFzrEc4v8FSC767Bwtncr5zMJ2XivVH/gFwh1YvOWA8t9ZzsvR5n2p+IqYxGHTYDY4MuohaWpuf9w0n2sRHJRvkQOU+xLQDg7OrGPxDVFo6U4XJLQcrbE77sR3cPtgsLYjj/Au6EN3R+OftVrrsBRCQiSxvb81BLMjsizaZpPOkqZLIv3LGprfg0jREZDrEeI7m+7r8L4P0kFBRFCEHELyxFDY9QShaKz7BbLMPXPEjCGbPCKvudZuT314xVGF395NcL3Xk4lPwyf8BVue4TAuXTDYZtopbEiIEAQI6CNEqPTnNethYmp6YGlHmp+aJalvSzXXpmUZrURs9Q/d2Ywu4llYSYCPQ3tgDHb/cmYpluv+qlN3QTZjRq1MzAvEGWE7W2Xg/imMh18JoejuebGTdHoVveoffEFyismLhWPLQDK678wXr11qqM2jlsq+zSGHx9zml9UR4qTSMmk6yzQ6TImZ2hect925P+fmTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlUdVNxTTRLZXhrRU1MUmc2OE9IV29uOGdjWVViazJkRHU0MFV6akErcThJ?=
 =?utf-8?B?UHB3Vm5NUTdiNjlseHZYRE1PbXFUQ2liZzlhc2RLNDA1akszK2hvSjhxRStH?=
 =?utf-8?B?M3hXUnphUjdvVXBhczBkQ0RDNURwOTBBR2RZQWR6K0xGOG9sLy85TDRJaGZ1?=
 =?utf-8?B?U05VcWxvNEROdFpSOHNNdmdBUkMrV3FSZ09xbDdaRlYzY21vVWpmUys0R3hG?=
 =?utf-8?B?T004aWJtdVVHUEloclBKNnhCNU8zZWhUWlhwZDRaUlVFU05LQUxjczdvcnYx?=
 =?utf-8?B?THEyRnBIMmllQXVOL0w2cTZNZmJtNkFDbExxNU9oNkx3UVhyQXFiVEdPSVR5?=
 =?utf-8?B?ckVTZlg4cGZzNjBzR3ZvZ1diTlo4dDNtMklmbm1BN3RhSTlUWW5wdVNZL3V5?=
 =?utf-8?B?cHB6M3Q0VXVSSlljRGloSUJ1bWd1enVTUHZMVEEvb3RIdDF2aUI3N0VxYTRM?=
 =?utf-8?B?WGJKdTkvb3Y1eTh3WEhYbjFLQXQ2eWY3dENseWtCdGczQVFuMTZqQ3FZQ3l0?=
 =?utf-8?B?VUNVWCtxQjd2Y1YvRytrR0lyMElZd0E0MnRJcmNvcFdkR053amVlV0h6Q3pQ?=
 =?utf-8?B?YmlTTDFKcjBMTTV0Y2Y3TmFzWGh5Sk5kaEZkU2VLYjIxMk8zbU1ZRVljTTg3?=
 =?utf-8?B?ZXIrWVlXM1hmd1BCNWY1MXIwdm1VdjN1ZlRoWExHbUVMM20vTkt6Qk9qeDYx?=
 =?utf-8?B?aHF6c1pMbm15dXljTjBUeDlpV0prb1VQOTBMWk9QRXp0QnRwajlXM2tOZlJ2?=
 =?utf-8?B?UkVYZVgySHA4UU1sZE12aWtWTTVyVTJsaGVCQmpacktwRzZOSFpnMHJ1N3Nl?=
 =?utf-8?B?UDdzcUl4bDZId2RLdktIakRBSTFBL0ZhK3Q4ZGFwVmoxcmVGVHUwcVdxZ3VI?=
 =?utf-8?B?akR3bGswanhJeGUxN1FTeWhQbHhiOVJLVVNhK3NzcG4ra0VubW9rc25QTlpu?=
 =?utf-8?B?WlBpSHFHakNBbkFUMXprUS9QWmg2d252ZUhqc0ltR2Q1UW5YRW1NU3ZxRmQ3?=
 =?utf-8?B?NFZjSFdoZ1NlYTRsUkFVWm55ZzMrcW8xMTJZYjBqRzhKc0xvd0tuVGd1ZFVI?=
 =?utf-8?B?bGlpUyt5VWxJUVFRWlFMbk5YWlVrQUJMVHhXUlNJQnk0MDFCVm8wWjlnc2pB?=
 =?utf-8?B?ZTN5dmVIL2MzWm9HTkpSTmdnZFd2Y0hWVEtBaEo3NVNkWmhhNlJBS01MSVNl?=
 =?utf-8?B?UWVVci9WK2RSTWtCUXVoNi9TY0pQR3hxM0JJb2VxWUN2NWxwSkY2NURSa25Y?=
 =?utf-8?B?UHVPK0p4SlZwZmNYemlwYnNwaUZBeUVtMnFUdnhZTGUxYmtpRnA2TkZpbDdF?=
 =?utf-8?B?UEVXSjFTUWdpSU9rMi9QWldQUkZVcVJxRnpMWEpMZHFMSDRVeGl1WVFsS2hv?=
 =?utf-8?B?RTd5UXA1VFhRNXdIVSt6UmI3eUl3VmthT3RpaEo4ZElWamFkYXBaS1NpNlpp?=
 =?utf-8?B?QXI2clg5Q2dqYm91TG1oeldwMGdjVnA3OVpQcjdBUmNZeHRLK2poZzFZTVpB?=
 =?utf-8?B?ZXVpeDNpb2gybEdjNTd5K3Q3bFA1OHorUGpaRHZrdFZDYVJ4a21xYnVkVEhS?=
 =?utf-8?B?OSswMGduU09JamErbVlrRzdoZVRSbVEzSkFHeFUxajdxYzBpVEdlV1ZaWjlF?=
 =?utf-8?B?REJqLzN0VUF5dGRqVEpqaWlQMnc4N2lneDI1dDJpUE1XazlMaUY0UWVpdXpI?=
 =?utf-8?B?a3FxSXdkc1VDWXZmcU8zMkQ4azNjTUhZZzM2VTZ4emZ0MmlTSkxNZzVkOXVj?=
 =?utf-8?B?czJheEJ2UnJNR3N3ZHUzVFQxeXIwbDh1OHhDd1oxQ3B0TTVpazJhalQreG5i?=
 =?utf-8?B?R2lLaUNQZTRvOWh4YWdubXVGaEdnTWxOaHpqekp2NUpLWU5EVW5QZGxsRG82?=
 =?utf-8?B?MENrK2ZSOHlRaDZLYUJWVUpUMmZUd1NUdllqYXR1MGxEUitrLzFsSlVPZVYx?=
 =?utf-8?B?eGJzd3dhQ2k1WXZBbmxhZlRYZTdmdkZIYTd2c3I5OVdrY3g0cXprYnEwdWh2?=
 =?utf-8?B?RjNvVFIxNlRlWVNac3lkM2wzQ0xZTjdUTlhQandFN1dDYURVSzJLYk8rM3o5?=
 =?utf-8?B?UHdsK3c3TlFmVnlxaUFlVGdZam5zdVBQOUNpRXN3SFYydGg2OUFDWDFuU0JG?=
 =?utf-8?B?VkNIU01Yb3owNWIzckJ6OWM3alBwOWFrVFg5MzVWV0JqY0NHR1JvdmMrWWJQ?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f364a66c-1f8e-4bf0-d4b8-08dc58ec7a51
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:26:27.0587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adrZxPkT7IbwmRs5z+ysCLTJWRSkZFI9Y5P9aEyDoI11aqOTc4cj2T8127OlGPyct8PZK4PLcuTq8gyajk7Q+ONRGqGNQMaFIOmuyVDt1gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5905
X-OriginatorOrg: intel.com



On 4/9/2024 2:54 PM, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> The current implementation requires the ifstate to be up when
> configuring the RSS contexts.  It will try to fetch the RX ring
> IDs and will crash if it is in ifdown state.  Return error if
> !netif_running() to prevent the crash.
> 
> An improved implementation is in the works to allow RSS contexts
> to be changed while in ifdown state.
> 
> Fixes: b3d0083caf9a ("bnxt_en: Support RSS contexts in ethtool .{get|set}_rxfh()")
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---

Makes sense, though I think you could send this fix directly to net as
its clearly a bug fix and preventing a crash is good.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake

>  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index 9c49f629d565..68444234b268 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -1876,6 +1876,11 @@ static int bnxt_set_rxfh_context(struct bnxt *bp,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (!netif_running(bp->dev)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to set RSS contexts when interface is down");
> +		return -EAGAIN;
> +	}
> +
>  	if (*rss_context != ETH_RXFH_CONTEXT_ALLOC) {
>  		rss_ctx = bnxt_get_rss_ctx_from_index(bp, *rss_context);
>  		if (!rss_ctx) {

