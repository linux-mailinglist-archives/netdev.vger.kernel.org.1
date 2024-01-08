Return-Path: <netdev+bounces-62460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAB827716
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAC31F23011
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 18:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E154BE8;
	Mon,  8 Jan 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3bRdGiu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C554BE9
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704737501; x=1736273501;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VdU+eEuJoZxLPtwTpB0+gX/kTV8IF3Yg0t9eU2uNqLM=;
  b=m3bRdGiumhGc2C78drmzuz5AGnMjwKgXQYSmksYWuwEK/NS51cqjjyW/
   z+ZdzgEX2+y8NAguBVFvNrCDkZfnpz1gf4JC6nB/rICwJBcodwXYqpBX5
   p3qWbzeAFz62P7nFgtOkuVL/Du/fAbcIMPU4i7KH5P6CURzxPtMiV2RUX
   Fs7n80EJJLpBq9GFvJaWJkZ4RDypSd4NriPwWMdlOKtYeMl/5MYYOUMDN
   f5+UeZM4/iCGyfvc0QloXX8TtXu2fUa0uMRDqIlga7UojR0FSukwtHPJb
   BcYv7wz3mgui6Wi+nW720VhtGzbxqyZeGJ3/Rj08ynYMAnvUHBvQahvp9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388409067"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="388409067"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 10:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="23609922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 10:11:39 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 10:11:38 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 10:11:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 10:11:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZhmkRfFQx51E5+upEZMjO0vQZJ3pc+ZAt/5ohWYa5iCHWbsF/n1Yp/c/OQDcHYa0iLX4VlHVSVMPi3vjUr1RQ849F3Lrdgq8G1pW7N5bo5zW4qJbLIQwtpw7TsVgTxtlc0M1hmzc3cOI19P5xtXCHue/ZQfJNITiTr2Tz8bGCBYXDGV+ROfSAysDjx+AZ/g6NUkKsN/zkz/1VaRK3Ljc96zJrjYbocp5pKFVDXT8Ta6YZg0Ok/soqTtndsob94oiiGsB0QD6IR4kwBuTdG8TE3wOlfHJ+RO9hTzzGqtyD4CjgxXpedWMmuTkf2pYw//YEFLYboyBN9lAhSod2sTPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Rb1CSwF/jGKOm3J6O1/LjXTEGk5JWlJxGUhlOqL6o=;
 b=QGeAoAKuj2XRJA6uDQqzoPmmXY3YvOFoQIGnGWg8IbI6OIBcq27XeKpGz/pZYDU9pbtiJ/heKRAXDZPLzsWRKItXO5WA5rQtd6PvnE/m8lzetCR43fIsuvjCZP7bkuOpqpqgh5CmU7PBBsnILSR9GUhtGGItpbUWG+m1oV2sQYbWHqio/rev2CIbwZS+YI/MPlmeF/eeKEl+FOBkbijV19zZBb4BJiSxD8yDqRmABi6kn/kHBrLN4BkIV6pseuNyckZZ+71bRDh9MPMhY+5NSr62tPfKoBpOAefqaAWiUoFR/xJlUBxRUVYhU/YdddY4eDk8/ObJB2l63a+zFflaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM8PR11MB5623.namprd11.prod.outlook.com (2603:10b6:8:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 18:11:37 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 18:11:37 +0000
Message-ID: <fbcc4c92-b4a2-27ad-ed6e-4064ee1020ba@intel.com>
Date: Mon, 8 Jan 2024 10:11:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Kernel 6.7.0 intel i40e driver not build
To: Martin Zaharinov <micron10@gmail.com>, netdev <netdev@vger.kernel.org>,
	<karen.ostrowska@intel.com>, <mateusz.palczewski@intel.com>,
	<wojciech.drewek@intel.com>, <przemyslaw.kitszel@intel.com>,
	<rafal.romanowski@intel.com>
References: <21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com>
 <9AADF399-55BA-4717-8AC0-154014A3E492@gmail.com>
 <FF3A15EF-B4F5-4BF7-81DD-33138BDF4441@gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <FF3A15EF-B4F5-4BF7-81DD-33138BDF4441@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM8PR11MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aad2e7c-5400-4f1a-956e-08dc1075406c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WNg0W6ituXNbsyGv2kHkPChoeKLo165lD3nRD+sRLjc9eHdEFuRswlKMiZG8W9G3At2FGsrCr76C9uydzHVKNfPc4CJ35MgZFd/xQ87kuGhEJkUGgsFB4NS+nTzUy+tA2Rc1lRN8UN017CJtknG5mRFZJ8maSkTsUj/AQCUukH05Ck489/ZQhaiAhcsCdKZbtGSqdNOTrCJMFVGniOQ3Nh+hyTTr70OeoOxyWkiDK6NENgLR/AcpF+HqcQeLr16HNMPVxuQs/i3S9u93fOyFNkHZ9fG6GnSuaMOVrJbBr+y2sN2dy9j+QBPU3o09LdlprrYfRXOCvasNzkfzBuV91QSr6Uk1TKvG/d13xqJn81ckvJORbwpDleF0M/4YLv2El71URti96Z5OSk7L79lqZbni9nSFeLjg4FpRZOhMNvypOZnJURljDatVvOCcjwqW/gCrEhmrbC+GV7pbFQ668RL6OrsYAg1uCa9FAy/HYksaonr/VO1mI98aYyW6zb+S9gZwBxyntZGHGEhqvdThr7UJqdlyodY1ukXlY2/nOGaKHF7gY+pucuuXm8Jf5YGKYjr9d5CmGJ8E03YWqrM8SK/h6hzvBT8Glpkd+PNjaVD08kMS9rnpZX0MWBKDITT/+1ZJQEhzcwWX3Rmw58BHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(66899024)(8936002)(8676002)(26005)(6506007)(6512007)(83380400001)(53546011)(41300700001)(6486002)(31696002)(86362001)(36756003)(316002)(110136005)(2906002)(5660300002)(66946007)(66556008)(66476007)(6636002)(6666004)(478600001)(31686004)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRidW5td3FwWWR5QmxIY1g0UGtoT2NMenFsOHZsTXV3WUxRbW0wTVlyQnE0?=
 =?utf-8?B?MnlOMVJxTG1XamY5d2M2SHdadldQU0lmM1NFcmJvUTZyY1VFRnNXZXpGUytm?=
 =?utf-8?B?MTlEUitlWGhLMTZnNzVmaWlhdDYxS2JBN08xK0R1b0grdGswbjJDRDIzSGxn?=
 =?utf-8?B?Y1E1MGFlVUNoQlZDd2w0YnZtSTRwZmlQYXVaUXJvbnFDUUtzQlJxMHpwenIy?=
 =?utf-8?B?QUVTNlltaHpXMEVuUlRmUFN6VmVzbkhGTUhDNExjS2tMNCtlUmc5SkkvVkhO?=
 =?utf-8?B?WnhCVjA4MmRFMFdyNGYvWmtFMExscSs5K2VCeEo5QjBJeHBVSGhWYkRIbWVv?=
 =?utf-8?B?dS9RSG15bGV5Z2lPZFBVL25JTE1ISTYvR1g1TTlWdnk5ZVB2RTk4NXFoaS9E?=
 =?utf-8?B?RVhCNDNScmpVK3VCK3p4OUVmc2ZpQk80bXlDUFpsaU1pek9ZKzg3M2xUaENI?=
 =?utf-8?B?ekFDNGo3ZDYySytYeXlkaStLMU1iVFBpVGN1UFY5Z2s5T29JSi9Wc2s1WnUv?=
 =?utf-8?B?Nk0yVk9HelVrNkkxdHMzM1hlUGtuOWZ6eGljYUQvM1c0cnZZekphM0gzeUtQ?=
 =?utf-8?B?VjNNVjNMUEZTTE02QUZrMGE5VXIvcnJOb1R3NThpWW93SlE3dUFKVm9rTmJR?=
 =?utf-8?B?dVR4bWsrOWlOUkJBVURrSnc1ZWw1MkovT0ZMTms5aG1kQmthTDRqNkgwSlBR?=
 =?utf-8?B?cG9rSHZ2WTJiSWFMbmhZR2g3QVNVSUFZQi95U1U0ZWpka0VzUTVtNXdkcnVT?=
 =?utf-8?B?RDloVnh1bGtmWFE2bWdmOWtpbU52MCtadFdMamQ5WGFmektNZXFsc3lZTGEv?=
 =?utf-8?B?eVZyNkxlMGRTQldzQmdtck1vbHZNeXQ4NjNyY1B3dEVWTjdtN3h5bzUyeVha?=
 =?utf-8?B?WkQwTFM5UVQrR0YxdmpoYytJV3NFT2t2UXQyelhCb1VVWnBtcjJIMUlMZm5N?=
 =?utf-8?B?Y2Zsb0lpUzJ3bmxVYXV6clp5TUpNN0ZWL3NNaVByK0VrNnFOdSs1dnJyYkEz?=
 =?utf-8?B?dWFUQkxNd29PTWZJemJaTmZaQXloSzR4bHRUS3NUVjdzd0lDUHVSZm9mTG1K?=
 =?utf-8?B?NmtLSlEwVmUyd0tndkQ5ME9BSGxnbG95c3ZRUWZrdGRMM0ZCZkZCNzZnZUli?=
 =?utf-8?B?eHZMQXBhTUIrTHoxOWUzS0tsbmZBSUxXcXVuYkNMY3AwRXFLU3JjdndUbUtF?=
 =?utf-8?B?dlZvN2Fvck9qTGhDbTloRkc1SEJzSHVyREFwVnVhWk82SS9DNXlTbUlQZmh5?=
 =?utf-8?B?b3ZETFhsYUppdGVNTDZqaENNMUJVSzRES3F0dERnZTFqaWpOWWxWeGV3WEFY?=
 =?utf-8?B?Y3hFZWpsYUF3RW01L2xlUDVMdTF5YVBPZ0p6U0F2eVY4aVZobURUZnd2dlBj?=
 =?utf-8?B?cnhlRGNqdG93OWZydTQ1ckMrOHovY09jVWtzMXRKMkdMcGp4ZDZySWU0ZEVC?=
 =?utf-8?B?VmtxaTFjMEIvaWtJWHlOWUl6eEZ3UFFEVll2UG5hVmM0WWprQ2pVSzg5QkNk?=
 =?utf-8?B?STlrWlZ1bFFFZUhsaGRMT2ZXVGJDMzdmUDZpdi9ZSWE2WGhicGlGU3A0Y2pT?=
 =?utf-8?B?RjdwZEcrUTVVS2ZBUDNRLzBLME1sTEZDV05vTXQxMjk0ZG9hUmF4WVl0d1hI?=
 =?utf-8?B?TnBzTXMwbFRDbDdRZFNJaVZWbzJQVld0TlZBRUVZbEVGVEV0RmNqaVNkOGdP?=
 =?utf-8?B?ckhqUFRPdGgrUk1SOUg2RlA2V2FvTE5teEhLYWFkWDY0SlFNWDhFZWZJMWxW?=
 =?utf-8?B?K0VxdHloeHprMlVzK1JnR3RFQTI1YVpyOGt1cVZpOTRTTUVMcFBrd05PVWJt?=
 =?utf-8?B?UUVvZTB0citZNlkrRUdvN3o2My9HaDNWUU05Umw3WXEzRG9YUjVuU0ttVGJa?=
 =?utf-8?B?T2NDRFVTcWRhRUp6dVkyZ0R1UTdLN2l0RkprVGQwK29Hc2o3c0dNWDNtUUFS?=
 =?utf-8?B?VmlhQ3p6VDBqMmwvYURpWFZVUWNlQVQ3cEVmRCs3emo3SHRMTXhWN0ZJaTY4?=
 =?utf-8?B?R3ZaMVphNzQ5QThjTVpvTTQ0ZEUyK2p3MGVpQk1vbFhnR3hZazVZRDMwcVlO?=
 =?utf-8?B?bjVsd2VLNU4wc3lDaWxLOTR4SGttRTFxOWhYTEh1UHZ1eW9iemo5cXJOd2Jn?=
 =?utf-8?B?ejlsYjZFeHNzWjUycnUvZkxiQ3d3Z2tDWHRVMVNYckJJRWg2RzFmdzBTYW0r?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aad2e7c-5400-4f1a-956e-08dc1075406c
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 18:11:36.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPelibuop9juL2VGMRb11ET8YfBkHX01sf5xoZohF9TyaUWPeDdAf3o/nT2aqP259naaRMhFPW2GipIVYQPPgHg58upmCLjq39yIfa38zEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5623
X-OriginatorOrg: intel.com



On 1/8/2024 7:10 AM, Martin Zaharinov wrote:
> Hi all
> 
> this is fix for problem in one of commit is remove i40e_type.h from i40e_diag.h please commit fix:
> 
> --- linux-6.7.0/drivers/net/ethernet/intel/i40e/i40e_diag.h.orig	2024-01-08 15:08:35.903036237 +0000
> +++ linux-6.7.0/drivers/net/ethernet/intel/i40e/i40e_diag.h	2024-01-08 15:08:50.107313186 +0000
> @@ -4,6 +4,7 @@
>   #ifndef _I40E_DIAG_H_
>   #define _I40E_DIAG_H_
> 
> +#include "i40e_type.h"
>   #include "i40e_adminq_cmd.h"
> 
>   /* forward-declare the HW struct for the compiler */

Hi Martin,

Thanks for the report and proposed fix. I haven't come across this in 
any of our testing or a report from any of the build bots. I suspect the 
proper include is implicitly included or excluded somewhere outside the 
driver. Could you provide more info on your setup? arch and config file 
ideally. I'm guessing the config would be too big for the list so a link 
or direct email with it would be great.

Thanks,
Tony

>> On 8 Jan 2024, at 15:32, Martin Zaharinov <micron10@gmail.com> wrote:
>>
>> Add more people from Intel .
>>
>> best regards,
>> m.
>>
>>> On 8 Jan 2024, at 15:30, Martin Zaharinov <micron10@gmail.com> wrote:
>>>
>>> Hi Tony Nguyen ,
>>>
>>>
>>> Please check make error .
>>> This is build of latest kernel 6.7.0 :
>>>
>>>
>>>
>>> CALL    scripts/checksyscalls.sh
>>> CC [M]  drivers/net/ethernet/intel/i40e/i40e_ethtool.o
>>> CC [M]  drivers/net/ethernet/intel/i40e/i40e_diag.o
>>> In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
>>>                 from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
>>> drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown type name '__le16'
>>>   33 |         __le16 flags;
>>>      |         ^~~~~~


