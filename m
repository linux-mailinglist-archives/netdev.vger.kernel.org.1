Return-Path: <netdev+bounces-68710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B0847A3C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BD41C257F9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55C80605;
	Fri,  2 Feb 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi4Tgmtv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B6647779
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904292; cv=fail; b=AHLCd2DV8GD4W0ZrddC5C+j+TbgWUcAa1GX7R8h39Mt6bp7PHMvZV6q/QZ50+zrHkg6Z2tOVCbA0q29OIp6oPebVz4Gv6GTtJiR5jGzXfJ7YWTFEctkuBx48Ss4DCus10OcuKdXDpB+DM2Mfj7bkDjLfChWV6TOmuamJadUpSvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904292; c=relaxed/simple;
	bh=vESZiOZpJqpsqzs2cExSKkExtTeFZrxF/K+2lWBgNWI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JBwtFXv2JEJXSDgoaUbnaLKXSD6vEIj9QpH6STwHrCncM2VslYOkFWh8CLfHgzsJGQQFp6AxKahbUUKLnreuj6Y56BigMcJP7LvTjRxBXOcJ6JkzhlRofvQUsW7rEXaOKdB538+DoYMrDXgCUA/3wU2IRWidb7d58REVkvWCiTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi4Tgmtv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706904291; x=1738440291;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vESZiOZpJqpsqzs2cExSKkExtTeFZrxF/K+2lWBgNWI=;
  b=bi4TgmtvhnUO6kiIJ98LBpeu9vvM+T1nXQM2iDZ5imFn2zh+mUHksGpv
   BvCqq1YEd28mt+XXbNffZ74iuzoYU7IK88mc9Ev2m5OlXLkeqpMzE5F17
   /AiE5xgwkYNlUrh/SDafRasQrN33Lo+XI99nSmTVxGxOH0e1V+oeFfunQ
   35J/RYsVaKiZJ7OHx+1sXO57y3YVIOLHnmep4sNta60HrRp5x+9f5AEfs
   W/CNVoIz0YSD6KG4oWLzJvbwelnHIGPpO2eZ1AaXyL9YxPyU2Px9HyGUR
   2ZfeYA8lg7c/718iJ5SC47dgJUGiteMvvXN23upMkouLKwonXXAH0Afvt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17644706"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="17644706"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="150077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 12:04:49 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 12:04:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 12:04:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 12:04:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUycSXZhG3BLyFCYDNGBgTRZfDZKgZMmK5srjy/QhPVuJhfkhI8F/hpsfWNLiu823znvO5l2tYo1gAnN0SJOhkxBUHA6L0TjL+xyAtbi9Vj4JjVsn16DXYchc8cWM8jHVai7jvVIgYVSnBUxOMfVxM6GZoZ0kHhaMyZKWeENdRNpAHZX1vPPpSYIdhwyHqMJUPCEgYzTl4709OBdoWJ5EnmXdH+ThElRHv0CVCKx/Ndf4owCAN5pYMGgWfua2QT37eU+elVqiF9qPfadAeSH9dfP/Oh08eoQtU0tvFmslsS7eG4NEhvgyParb/WE+ljUhda/zaGSwNTO3QiXlj4p6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S08zVMqiixaioXVnfAPx7S1uwWauMj/EajVXAOmWZR4=;
 b=hzGAY/vo6/9hKgwUu/7NKwKV3tKJz80aif4EM3IbvcMtIbwU1ViTeBbj2kzearC3XBSGtDXuXNNXJUIMaGtiF2E02GeR3KxSB0mWNPVYWyy5Iy6rCldro4ruSQQ2N6770movBVy5COyRfntGeWefrb4p0ffHg/C9qNyOR0/RoE4nSkusOAB/99naybXDnYkGMlvVqNtiCbiJGDmaBlc+/v6I1kCtiCOvn1WHvUF/+hG1tJkgm4Fy9wcd0pfnI2mMoYUavObOa35LZ3ZEUPIDPa9WiIG3qQlMl77nWheXya6BMeRFnWyzxcot+oi2ecb4gstr4xDn0xeFOmdoRbLi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 20:04:28 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7228.035; Fri, 2 Feb 2024
 20:04:28 +0000
Message-ID: <ecff19d3-02f9-45c2-ac24-0fa7d23b1c6e@intel.com>
Date: Fri, 2 Feb 2024 13:04:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool] ethtool: add support for RSS input transformation
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <mkubecek@suse.cz>, <alexander.duyck@gmail.com>,
	<willemdebruijn.kernel@gmail.com>, <gal@nvidia.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20240201204104.40931-1-ahmed.zaki@intel.com>
 <20240202110614.18a0770e@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240202110614.18a0770e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0028.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::33) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|PH7PR11MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1ba0ec-a07c-496c-098a-08dc242a297f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJnoa9K5eCPPpDZMCUleGpE9K+QcZByD1UFNGXJgG82pVWa3LLyevZR25D1ydMVn7xiJV7JogrMh4HbdQ0u1bAlc48Xv2fFIbcEavULJP70JVhkGIIOgmC9WcmdNA/SWY5BGRBXAaJdSUkI0gQ6hKXxfGNL6MHFb2sC7Ppk6rKsZx8NqKNez49S/iFR7O6yeZxhh/Jqk2INolUPuX4WbHyFelgac/XJoCXN8fCdDAXEai7CSfvJMehsmSECiCWVL28YRa4lnKJKTmX9HKa5EJT/HX9r8qYfQpuMzR2pgxyE1KG3Yl9MxOFgpCZzTWtcxbAgiGqPBuYrr3ACbdfzANt7gDP5jYqAEqh/SBGzWhPPXnN9a/LIiLdPYe0mUATnj2ZGpc+ZyJw/oC/59zOxK7d9Au8k3OQpZL4eJIsi4MvOicx+4Z9cCk7ZvCo1lr9+ToVoBCsu1JNRBZ/8ogCNDQBIXlq5NZ1ugMWWtoVXuFHGeHxYYFjrsUnnsquXuxjcPYAG8zLiDXvJRI67jAMSNnf2nV9Qxbxg/MJLA0W+kURVqftQywGv0h81ugZR0C4mtIXUSeG0HijVoPBVZFfmfp3FcVXErCcf3P2EULqMGcrAzSUAAQaX7a5qIGc5m143cC8A+3vJ70VtC5b4icXzL+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(4744005)(478600001)(7416002)(5660300002)(44832011)(82960400001)(83380400001)(8936002)(66476007)(66556008)(36756003)(66946007)(316002)(54906003)(31696002)(6486002)(6666004)(8676002)(53546011)(6512007)(4326008)(86362001)(6506007)(6916009)(26005)(41300700001)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk90QVZLNVJPVCtQSHNUNzRTQnNiRmRmTFRtQ1U0Y1RqR3dFNkxVZ2ovbmdj?=
 =?utf-8?B?NWxvN250SlJWS3VVZlA3REh1eFd1U1RxUS9odkNBZDhRSHpycFFrWmJLc3Nt?=
 =?utf-8?B?NWdtNi9jRjVCdFBSandObHgxcG0xTWVSYlpxUmV6aHhkQkRLMTQyQ2Z0Z1du?=
 =?utf-8?B?NHFWNEhUdE8zS2J3S2J2N3V4WVNGTndrMTE2dmhYck1wWmZoaWFWL1U1VWFr?=
 =?utf-8?B?THNvS3c2bElZSVVPRmlRV2xuUmZHcEVvRk1ZTWhVS3d3RXJtS0tMOFBwdWhT?=
 =?utf-8?B?OERteW1TNVQ3VXdjVk5HVVc3WFZEaE5GWHUzZDUwamdVb3VicFFQdzFma2Jp?=
 =?utf-8?B?Q2NVbUI5enA4M04xaG1yeDNhNlZLQnRCMVJHRXJ3UStJZFBFU2R5T3UvZktV?=
 =?utf-8?B?cEFnelNhSEEraWpnQ1ZZOXg5VFhFUGc3MGE4WmhtRjlMNUw3cmRaY0JSQ3Jk?=
 =?utf-8?B?WkFUd1BFMWpiVG5RS2p6WnFiRVhBcUo5dDZSYnJzdmhFMWQ0K0wraUVCSVAx?=
 =?utf-8?B?c0x6S1JQZ2xZUU9DUks5aFVRd0h3RndnUTE5bW5yUWFLWFN5U0hmb3VWN2ph?=
 =?utf-8?B?QlRXUER0Y1phbHJwWGFnUk5xT09sbFJXbWN3TEFwYk0rY25wTDBKZktTNDBH?=
 =?utf-8?B?ZGVOVXBBN05CMHNhRGZPTTdNbi80TlBwWFBmNk9NSVI0anhzT25sOXRTS09L?=
 =?utf-8?B?QjR0ME9OalU5WCt0NTZzRC9BeitiZ3Nvc1VqcVcyMFVXOXR1NWd3STE5aGtj?=
 =?utf-8?B?VURMT0phYXhva250NnVOKys0S29hYldqV3NHdnF6T1RDdERock84cHpsSFBN?=
 =?utf-8?B?YkJMemcrME9TQ1BlbzdZcmZJQnJKYS9uaGJtc2lYQmx1MVE2bXp1VXJOb0Zz?=
 =?utf-8?B?aE11QUxReTlHVkJOZW1JYWZuTG9SN3RJRi9wOWYxcmFCMFVxcnowc0VmMno0?=
 =?utf-8?B?Qk9FVytKZDIyVnp2Mjg0S2Z6VnBRMk9vWUwwZEVjZVhIcnNmanFSRFFtdVBi?=
 =?utf-8?B?dnJRRHBBdmp6RDdBQWxFc3FlODZEaDZndll0ZFRJQnV1YndJd3pRcjQ0b1FV?=
 =?utf-8?B?SXJIL3cwdGZiYm5hUjcrSlNtdCtUOVU3TndpNnlFR1FQaDJSQ3RmcjgvU21T?=
 =?utf-8?B?a2daUE05RUYxKzNlMGxtM015U3g3dUpJWlJlOEdGVSt5TGh2SGZQZ0ZqcWRR?=
 =?utf-8?B?OHZaNTlLQWViaGRqWFliaVllbnZzWCsyVlJmaXJ0Mi85cW5tZjBRQksyK0w0?=
 =?utf-8?B?RHhXOGs3TE5LMjZOYlRWWFBXRCtmKzVSV2U5VFZZSXZZdlpiTWszWjNldVJB?=
 =?utf-8?B?NzhlT1NyNS9pZUFLUG9rY2h6RTdiY25UL2FrRUpxeE8wMFV2b1pGT2syYkMw?=
 =?utf-8?B?dVk2NFVpd3NZYnliTmtaTGtYYlRrZTZKTGZKNE0zRFA4Tmg5ZkxXVkhreHZh?=
 =?utf-8?B?K2hGSjllenFMM1JZYTVXcHA2NHVBZFhwajZUSXZTeVczZDZST1ZhOG1FeVFp?=
 =?utf-8?B?NjU1UTNDcmIxTExuQyt0blE3aGlWL3ozNFpKZTgvbVB4T3NUVEtUcHlTNi9V?=
 =?utf-8?B?SVlpY1dDdmlhdGtVSDVGcFQyeWVuVFpWMXorOTlRY1cyYThLZ1hSV05rV0FG?=
 =?utf-8?B?c1RBam9WMXJKc3pHVW44bGt0TXFVZmF1dVI0VXB1d1djNExvc1hOOWU4bHo1?=
 =?utf-8?B?WFpEK1pqSEtJTURlNHNaWEJLamdYeVhRZHEyeExKb0NVMzBVVVJ2c0JpZWVq?=
 =?utf-8?B?Q1h1b2FhWmtnRUxpVUNSTTVjbnJxaklqZFNwK2pxblBDQURGRE1BR2VKNzhw?=
 =?utf-8?B?Y05BVkJxTmpZbEZyWE51a1JjNkV5eUR0Q3ZoTnFON2JuaG9BaTk4U1ptY3NI?=
 =?utf-8?B?TzA0dEpVZWZEaXhlOW1vL3dUclY2SGtpc1hROWhpeTBLM0hTUkhtUGo5K0RD?=
 =?utf-8?B?dkVUdGt0cFdEaUJPekZKNUxyd1E0djlaaEVYWWh6cjdtVHozN3NIOGpKRHY2?=
 =?utf-8?B?NmZSdFNaOTEyL21Tb1dBbTgvVldCbnpUdXp6YW1Pb283Tll5VlJ5RnN5QlVS?=
 =?utf-8?B?SEU5am5FNDdudkxPbHQ5OU1CS080WnRVU3Q1cHFLWXltUkF4dk1YbGt1ZEhl?=
 =?utf-8?Q?2zTY/fI/jy2mV4m/R3dheonNw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1ba0ec-a07c-496c-098a-08dc242a297f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 20:04:28.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2m0aUL2QlLStXsFu4oXhhGbfUqKRk5kzPwT+JEv+ln0RFCGdTyfxWwHwoCeMquElwrHyRbWdJwiYyqMRur15w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
X-OriginatorOrg: intel.com



On 2024-02-02 12:06 p.m., Jakub Kicinski wrote:
> On Thu,  1 Feb 2024 13:41:04 -0700 Ahmed Zaki wrote:
>> +Sets the RSS input transformation. Currently, only the
>> +.B symmetric-xor
>> +transformation is supported where the NIC XORs the L3 and/or L4 source and
>> +destination fields (as selected by
>> +.B --config-nfc rx-flow-hash
>> +) before passing them to the hash algorithm. The RSS hash function will
>> +then yield the same hash for the other flow direction where the source and
>> +destination fields are swapped (i.e. Symmetric RSS). Switch off (default) by
>> +.B xfrm none.
> 
> Wasn't there supposed to be a warning somewhere saying that it loses
> entropy?


yes, you are right. I added that to the Kernel Docs, will add here too.

