Return-Path: <netdev+bounces-87198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C758A220C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF7A1C21ECB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CA46558;
	Thu, 11 Apr 2024 23:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTm7YVY8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0C5224FA
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876648; cv=fail; b=U3YvZ8aJkszeaqTobR7Uwo+8FRa34PmIR+/P6VHIZiPW4E2xq5E69HLL7YHlUo82gLo/EtalaNXjh0USbZ/mkeLp89Pz8skXl82rnuS1dqH44WjNAcRbqAjP8nYE+J4VJKhGyL3S1/IFffPXDPXdHP1/ylCQwziiRqUtkslstMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876648; c=relaxed/simple;
	bh=egizfwkUC2tiSN6lx4HBW88EzGvFwLc0OuzC3OjwjQM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CeINTpKpDlddqcUicJEv1YwOZSuB7H8AwiVNAc8NYvwbJhS6C5zf4bknpZIXG+EgcamrglkJmm0RvS7J9m2nykq72jkLz7l4Yxo1A3UMFYU8+9Lj2BXnWNVC6MzbA+BckHde29HI4bzc4QXkLyKv1Jgsxpi0I//ED/c0ORIVcvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lTm7YVY8; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712876647; x=1744412647;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=egizfwkUC2tiSN6lx4HBW88EzGvFwLc0OuzC3OjwjQM=;
  b=lTm7YVY8f4jMHBKmmw7wqO8l7txEQDhJ5fyIDyrLfQ44aXxnjyuMM/yB
   p7y6FtpT7LV37vI7D+Ewhsxh0xxkcjAIuEUv2TVeu5ZvRBOa6smAsCMVj
   HQNSYLPpuAbFXGBdo5r/3m039z45TvCPbM/7dmoDndGW7+GP3lCnIRAtg
   +LGUDO0JRteP8mNIoiK51g++BpDMR5FU7t0EFNZJfnCF42nSxZOOLK0/R
   3jG+DB2AJ5tMwm5flBUoSBHlbl3E/5oaxmb2jjgcppz8DRaVJiDrJedY9
   U4k1W8cPUQIazqGXvkaE6YX++blahaZuy+lmbE5Pk5hBn4asTtuvlIJub
   g==;
X-CSE-ConnectionGUID: k8dEfUdfT0WmIMtpdI1LWA==
X-CSE-MsgGUID: JEIy35ckQHetxCaww8KnsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19738429"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="19738429"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:04:06 -0700
X-CSE-ConnectionGUID: x8Ra78BmT+aGNXz80IQBLA==
X-CSE-MsgGUID: nup+OIcFRoaRCwBQBnIjgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="58479781"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 16:04:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 16:04:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 16:04:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 16:04:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnUlQkO3NtWDNQufPxVQ3NAQ8hFtzpVCyWwVQhvktCSH7ruCqRM2RrnMKjrk+1J0zMpBtfDyn1xjwY8AlMQQPWZf5CYIG76PMvUa9p5K3pp+snMEcgieZxENRsrGl0y1D2CgP+fWpBuA4HgyvG13ZJRzrSHxnnd8FTyzLxZBDqTKPkbG/WoyM+PMjfQDs/M4mTMy1n6rbMah9PZm+rShS8kTmumR6P0QQ7gNLnK7hcny4otAT/Zl5OwSKnF9s3oBrVOIubVWukATJ4uJyFywjaTaIW0H3fjPbXbW6CLhfnqBi1a51xIe9HZTVccH2L2Sq6+lepLnCyOPFTbe0PELRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5KUq3vrGotZKoB68Wp7wzxR3ZagE/rvCNyLMs4FgFg=;
 b=C4+B0N4U1JJcSPFkPkMT8FWUqWdE5U4K33J9vVleFVx2w2Aenn1BuKhTftNLttaDLrk0IUi+r4/r7w9F8xgoPEPkaoslPVHOjKVzn4lGq6gAKlCBoM0AWI9XDnP+TI1uUExiR0JArCgpu9WMxlttivYScMqrpFZb0C/eSHPp9kj6BZOifaQp2U60/oeKfpjXiij0TkK734UfLTkawo016IAgYvZlbHyDrsZug6frzXjWokqMimW6tBuNwDXHjVU3XXt39Y00RdpfhvOTxw761fMdATYPAs2NxJOQ0Ew9VraNISvLGsW7z7KJtZN86NECkKwMn1ONjGFLA9t07+I61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7430.46; Thu, 11 Apr 2024 23:04:03 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::4a3a:732f:a096:1333%6]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 23:04:02 +0000
Message-ID: <dc7eb252-5223-4475-9607-9cf1fc81b486@intel.com>
Date: Thu, 11 Apr 2024 18:03:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] devlink: Support setting max_io_eqs
To: Parav Pandit <parav@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>
CC: Jiri Pirko <jiri@nvidia.com>, Shay Drori <shayd@nvidia.com>
References: <20240410115808.12896-1-parav@nvidia.com>
 <a0c707e8-5075-43a2-9c29-00bc044b07b4@intel.com>
 <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <PH0PR12MB5481898C4B58CF660B1603DDDC052@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|DM3PR11MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 42693255-66df-4c6c-ba02-08dc5a7badea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2JQxXK6PeEhJlajJ8q2uKB0rQKhrC7iRC0xowD6uojxNZG2cPx7sTx4fgE1aaYZ4HX4Hn9nLw0TbqD4jIy+wsVWlixZQhr2W1p4VxALf7lha0Yj6qaLxUwgM84N+5cm6MyBCnrfrOdpgZkWIpapMCZJ7bQkmt4kfIFh3ZOE6WqE04bcD2YCmHOA99LG39SYzc1QIFYpsV57paXX/QVlhhnI4BjrTL9txUXh0nyNxb8dv7YGW+Vq37QZtzQVHhwlKrkwzZThDw5b4jKcMDcXCRAPgvQo7tWEu//PWVymU5Aw3hOaFyys1j7MWi09Un5tKax7af1tBgX2gvziY6ngioBSIKRKrrT0o3WmTkwjaAROuI2BeHF7UpDN7ikS/mtwcuFKTMKE+97FYA5IMhn+vsyrc0UM2ZPp05ZjQujYHeayMA7KjlcDt7GHl94cxfYhNG0I73/0hZiVvM4Oj9SjlPuTHHg4ukPrAeXrcX+Cw0WVMn/XQtupBrSwu6kwUD6N9JD538gsrHgiaKBvDTq9X2O22gx2VX36pKQLMEQ1yt1sku94XNRWXVeHB4NOubyqsGOkOGzDnepYLb2yu1V38mRjlQqSru0aIpwEtRplYwZfBH3IRxiD86g88eJda5ZDgeeA70c1PLA+KTBK5CFMYakJbiU7t1aOoPSshNg7bxWg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJDelRmYmE2ZllQY0lTdzlQLzIvdFhVNjFDTlhVU2ZJbzJmT29hSkJBUWR5?=
 =?utf-8?B?aEpESis4Zk5pajliM1VGTTM5Z1pxSG9hcGV1MklnZnE0UG1rRGh2L05XeUVZ?=
 =?utf-8?B?RSt3MjZXZ0hEWEg4ZlVkMFd0TlM4RHlsRktjcWlMK2RRN0NWWTZWTUJTejcy?=
 =?utf-8?B?MFFVM0Y1TEJPZnFxanRkNkRRL2hhNk9va3lCUndSU3I3YWlVUE1JMi9Vc0lP?=
 =?utf-8?B?ZmNOb0RrVytsZjlLTTJ0QnU4QW9EaTZjdG9ZWlZMSEx4TnF3TURxMlYyOGgy?=
 =?utf-8?B?TklKNGdFU0g2cGpGeWdLYm5QMTdQVkhoSi9qd05oa0tzMldXNk1WMXFhbG50?=
 =?utf-8?B?anFSdEtnU3VsaWptQkNVZmh1QXFPNTI4VWNpbUtVNkRhejI3S0VWT3ZNVVJD?=
 =?utf-8?B?a0tUSEZFWHlQb2I1VlMwenhPMk9jc0dPazllL1U0UFkxVGJQTnJrdHlhVVMx?=
 =?utf-8?B?NVMxVGsweU1RcUFZVUppZkVPUUd6R1dGNkdLdXJHZzVmTy9ZVkNMbGxBcDR1?=
 =?utf-8?B?cUVSMWNKajF0WnoyZEFYMmxzR0g0Wk4zaS9GL0hoaTlEM21lRmZxQTd3cU43?=
 =?utf-8?B?TktOTVBoUTFuRnJrSXNidmdwdXhKUzl1andRMElKa3NwQmtPZzFqU1kyR3J3?=
 =?utf-8?B?ZjJQemRhRG41aUttajNFek5WOGRXZ005VHdVYWlDZTFGK1Zlc0dzSXlKeHdR?=
 =?utf-8?B?UUJsSHI5M0trVmZwSTVwYklxQk9EdEN1VDJjZHJQeEFFNDVvTFVKZTVMbkpx?=
 =?utf-8?B?aW9sdTVNbWxDS2ZrUjdTNklUUW4xODRzSDhwbUloMUNuTzUwakN5MjJ1MDhs?=
 =?utf-8?B?c1JybDB3YnNTek1nQjlheUJLTTdhNHIrWHJ0WThKL3k0U0Jlb3ZxY2U1S1FV?=
 =?utf-8?B?RHFuT2pmMlVaaFBEK1UzbjhMbVkyV3VWUXZHOWwxTmY4VGNCTnZNSUpyZzVy?=
 =?utf-8?B?Ri9yTVl3YVptb2ZIR01QUWltUE9XRVFzM0hEV1Qzd1h2dHJDS3QyS09wMjJ0?=
 =?utf-8?B?Zll3NUJjRGtsNVhxTVFBRitxM0dKRlI3MEVBTWFiZ2hEUmJXM3NSTVpQcEwv?=
 =?utf-8?B?SkFUbzBlVStMV29DM0FFdTUwTnU3RTZEYlNReWF4ZDJiUXRHaVBHNm1Qcm5D?=
 =?utf-8?B?NGtKRkJqdGUxWWRFL2kyODV6NzczQldySVU2SVlVQ1Vha1lhT0FXbWZQYzV4?=
 =?utf-8?B?YVFGbXdEaWZsaFI3dWZpT0tCUUpweWdvYTFWdzlGUHdXWVFXOVdHQkZJNHN1?=
 =?utf-8?B?S2poQ2RJb2RScnYzVjJUZldoNkVCTVRJOVhuWUU3UXd1SG5HeE9pQVQ5MGhz?=
 =?utf-8?B?MzAxRU9YaVJYdU5RWWJ0b1BWdlBVK3lvNy9KWXVINUJxS2dKNzI4NzlwVnV2?=
 =?utf-8?B?MkhWUHMzREx3UFFFUVJVSStRbUVFcU1kVGxyRkJja1M2aWozbmNOeHBJanRN?=
 =?utf-8?B?Y0Q1N2F1UVBGbVZyL3ArdHNrOWhXcC9jQ295ZGtJOEhkbTFuKzN3dWdFUmc0?=
 =?utf-8?B?NFpaeDlRSlc0WEM3RzFFdmhjMzA4WGNzZ3FNN1MvcmIrYmViTVlxWm9UU2dZ?=
 =?utf-8?B?ei84d2V1dXBMOGNWRzhzSzRiRi9yK3FwMkpNN1NMSHN1M0VGVXhteGlYTllp?=
 =?utf-8?B?ZktRU0FiWlhpNWgxdUdQQU4rWklhdmwyODNabmtZSHFRTmp1UExKbWxNMUpi?=
 =?utf-8?B?SXQ2ZzRiek12Z3hsQlZodUREK1BVNW43OGdXTWJrSWZTYjV0NGxBdTNIejY4?=
 =?utf-8?B?SEwySUZ0K1c0bWJmc3pTdGxjWE1VSVFOWEhOTktNN3g4aGxqWWh2NnZuMzBu?=
 =?utf-8?B?c21NR3YzRXNMTjVRVDAwRmtDYnhOTlNOYVZwRExEUWVIRUVZcEdrcU5RVGxn?=
 =?utf-8?B?SzAyc2xEa0IwS3FWQXUrbEd1aVRpWTl5T25QRG9pTGM1c3pzNmxqMi9vWHJQ?=
 =?utf-8?B?bjlUaFZKUEEybi9qVy9Wem9LWnpKQzRndHFmeFNUVzk4Q1lkWFdsQ2tMdXA4?=
 =?utf-8?B?aHVRV1A5THYwQ2V4aVdFVkh6bktvbmplS1U5Uk9YWFdodERkYXhPRnJEc1Za?=
 =?utf-8?B?dUkyc1g0S0xsOFpOWHpyRXpMQVBiS2F6blBKT013cGZiN28xRDFjS2VyUXBR?=
 =?utf-8?B?Qnc1cXlQSWhkL0dKYk5iOCszYkdjRFFqS0dCVzVSbGY4V2daQkI0UW85cVEz?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 42693255-66df-4c6c-ba02-08dc5a7badea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 23:04:02.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHDZAditHX97b2i674O9/acoQS9Z04HLEHK297ie1DRPRVV6gDjBMZg17iWtSisqhxLnWHg3xkHUPeMuPzGgewebTJYIOtHlrm/aO9pm/XQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8736
X-OriginatorOrg: intel.com



On 4/10/2024 9:32 PM, Parav Pandit wrote:
> Hi Sridhar,
> 
>> From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
>> Sent: Thursday, April 11, 2024 4:53 AM
>>
>>
>> On 4/10/2024 6:58 AM, Parav Pandit wrote:
>>> Devices send event notifications for the IO queues, such as tx and rx
>>> queues, through event queues.
>>>
>>> Enable a privileged owner, such as a hypervisor PF, to set the number
>>> of IO event queues for the VF and SF during the provisioning stage.
>>
>> How do you provision tx/rx queues for VFs & SFs?
>> Don't you need similar mechanism to setup max tx/rx queues too?
> 
> Currently we don’t. They are derived from the IO event queues.
> As you know, sometimes more txqs than IO event queues needed for XDP, timestamp, multiple TCs.
> If needed, probably additional knob for txq, rxq can be added to restrict device resources.

Rather than deriving tx and rx queues from IO event queues, isn't it 
more user friendly to do the other way. Let the host admin set the max 
number of tx and rx queues allowed and the driver derive the number of 
ioevent queues based on those values. This will be consistent with what 
ethtool reports as pre-set maximum values for the corresponding VF/SF.


> 
>>
>>
>>>
>>> example:
>>> Get maximum IO event queues of the VF device::
>>>
>>>     $ devlink port show pci/0000:06:00.0/2
>>>     pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0
>> vfnum 1
>>>         function:
>>>             hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs
>>> 10
>>>
>>> Set maximum IO event queues of the VF device::
>>>
>>>     $ devlink port function set pci/0000:06:00.0/2 max_io_eqs 32
>>>
>>>     $ devlink port show pci/0000:06:00.0/2
>>>     pci/0000:06:00.0/2: type eth netdev enp6s0pf0vf1 flavour pcivf pfnum 0
>> vfnum 1
>>>         function:
>>>             hw_addr 00:00:00:00:00:00 ipsec_packet disabled max_io_eqs
>>> 32
>>>
>>> patch summary:
>>> patch-1 updates devlink uapi
>>> patch-2 adds print, get and set routines for max_io_eqs field
>>>
>>> changelog:
>>> v1->v2:
>>> - addressed comments from Jiri
>>> - updated man page for the new parameter
>>> - corrected print to not have EQs value as optional
>>> - replaced 'value' with 'EQs'
>>>
>>> Parav Pandit (2):
>>>     uapi: Update devlink kernel headers
>>>     devlink: Support setting max_io_eqs
>>>
>>>    devlink/devlink.c            | 29 ++++++++++++++++++++++++++++-
>>>    include/uapi/linux/devlink.h |  1 +
>>>    man/man8/devlink-port.8      | 12 ++++++++++++
>>>    3 files changed, 41 insertions(+), 1 deletion(-)
>>>

