Return-Path: <netdev+bounces-71034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD30851BDB
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E3B1F23523
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4480E3EA93;
	Mon, 12 Feb 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h17Ludle"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5145B3E49C
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759806; cv=fail; b=E97hmy7IqyjEqmUBoJu4oS4mTdrEVNOaXh6Say9jQFEvECvn7KcxVgHuJANMYvnsegWIuHXZy3vAdNQh/swEqMrtkrAlV9ipwpr9QiIWgwp4/RBA62kGDibagWpwIi01J5Lf0aVuYbUm6Mx8d7L0/MOMtrTeCE285V1uJRHof90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759806; c=relaxed/simple;
	bh=Wm1enbgXDEzGh4RCmGgrw6XiqjQ8YwU7ImGHH6hGdX4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZUYqBhuJeTG/r/LKN5Jm/ykutzgTZLoQlTkS/B0b5Ivgxhy5LPz6GXNMLPQBPrKOPq+AWRlIZUzhjyAw0jeg4Xv10c1Pfp2bNk1cJdLbgUipiEiA3gumaPg+89HXhC41wGyA1MDUGCLLvJlAAg7QT5Qbmhuwhw2cHQuz4/ljeBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h17Ludle; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707759805; x=1739295805;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wm1enbgXDEzGh4RCmGgrw6XiqjQ8YwU7ImGHH6hGdX4=;
  b=h17LudleOj5ljT/pmTCTn9GIhEwM7uYV/BEKa+KzB1bWpWB9vZvalHd6
   8uCQdkajzAV+xJTSqQq+1azGkQTkIOXfNgYt9gxlKyfAvNfVYtquqost3
   Hng1UXt0V/ETz/sXjIQqcnt0q7mgJZ9kNl4Ans911Dh+AXWk6DVOZigky
   iv3UBj63NGpBlQ+NaZrDBp3I/YH1rLGzorI0hcDqwu3K67Lg70CAFB48o
   Adoj5+rirBmMUIjJO/z6d7PYNBn20kYsjFOO6NduQHw6envNprhOjbH0N
   mSRUikS4Qe6cbn99thoPjybAqDPYWQQK3+kBZtKVMNPNeOXZoEt9VCPxr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1624915"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1624915"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2991376"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 09:43:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 09:43:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 09:43:23 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 09:43:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCpEu97lAOmKV6Cyzw+yb3/RavMFo4zZfD9Dz8KdjSnnUN9Q4Q4CQ7mpZJgGmYkl0kix48JSiqqKTZ73JYGfxC/JhJcUhOV/TuRAhl0ETVd0qoaQ2mcZVeKgtyQG7G1IQ5otW3OF2fb+REGXwzwCKGINkdLf7j0wluJP6gobYCaITltcKMy5n+ItLhFGy16ASRWbxugF4hzPBVJwP9wkoWaHaqOtUljAkUYX2n4omUzPsl/hJBOwkX7cxwIcy0gXb5OXNq9Y6cjKho9F0lqpM+Y6Eri/a9PSs0542Tc/7lteZiFerqdzNQTR+cWBnwiVZAhemOAwIDb4lRZyzrxxIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2E0rBkqPXXldoVQZgci7CQ700aj2UsJsBWbRjR+VV4=;
 b=JVXPasr9062lq7HjDbQePhmFTV5xB7gqRAhF92EhMY8a+ma1NF59MaNWvsenylj0LjFKe2z+LEKxbWj/Yeh42vnKLHnWsHCgxE0+6Sd/HgAL5ONcdiehYk5Fj0OCWqQyqALgLmYeHRRZJPOTdYRZgKOqO07WocLmfs8OjVacRCs1V5nwXjsQQZdwoAxc4j/D4Q2IxgWrZl1Fr/JzllcCASQt42V/wpQL9A8EWkqAasDaCBLNQLfOHH2Rwc596NG9eykvdEsg9fsowHs3rvtouRiDYMphXLrqZcmrupvbjHFIXsCOvGFOLp+Gfmfj8VyF2Ot1GS7CzVcaMzQptfJpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 by DS0PR11MB8069.namprd11.prod.outlook.com (2603:10b6:8:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Mon, 12 Feb
 2024 17:43:20 +0000
Received: from MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::d019:7cb9:3045:5082]) by MW3PR11MB4538.namprd11.prod.outlook.com
 ([fe80::d019:7cb9:3045:5082%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 17:43:20 +0000
Message-ID: <0a7aa105-0b90-447d-5373-bf37b1a2cba4@intel.com>
Date: Mon, 12 Feb 2024 09:43:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [Intel-wired-lan] [PATCH 1/1 iwl-net] idpf: disable local BH when
 scheduling napi for marker packets
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alan Brady
	<alan.brady@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, <netdev@vger.kernel.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
References: <20240208004243.1762223-1-alan.brady@intel.com>
 <da0fff05-e9fc-46f6-96a4-5cc37556e7cd@intel.com>
Content-Language: en-US
From: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
In-Reply-To: <da0fff05-e9fc-46f6-96a4-5cc37556e7cd@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To MW3PR11MB4538.namprd11.prod.outlook.com
 (2603:10b6:303:57::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4538:EE_|DS0PR11MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3739c38c-fa2c-4481-62e8-08dc2bf21a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXU1y1Es8+ubgKLMiZsO2yiTZRUbM8Uv9BeM7W1tOj8UPa64DZQvEM7ggl+KO3jSP/cB6nbi1vNnyXO0dm1iUMS8n6Qr4gCkcv+eYTFFpTp+D6Oz5iJ0Axiba9mXcT9wL+vYASRyI2ZipnEzW9Hpu1q+IxfVxN0DKnX7JnKHvIdnvKbXCfz30P0bY3C1PNaTxmZWyn5npEEqd51SzrLC6TTsi1Qxbl75dTkQY5/ESWnpf4qEFTJs+Oj/EMrth8YRJf7HC87If5ipCv2kQzZinwnYfP4Dkih4szfq++8eF1P47MAbmvKrWFMKc2AquvUXmujvzjxiloWvHotnK8UWrTgPDaO9eFedBI2gOO9zi1ohqPS07kAK9pbSXZi2Z28BA/kNttq/XOXfDjxKSIyNHJOcjdqZrFWnkYs+RGhOVqq4eDzr+Lt4LUdPQoo1DVSJrP/ILDEhdIFG6VUm9YsTMhw3+ZrXP7zyxjh+XHrtDXBbCo6rdXUEIlvhoViAV4nYzsScxdl5yjYKPaOoKFCIlWaQ58ua34oZWNiZL8h5UL2RvlQOd3kI2Pw4zIMqqolf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4538.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(31696002)(82960400001)(83380400001)(66556008)(6636002)(6506007)(2616005)(26005)(53546011)(6486002)(478600001)(66476007)(66946007)(38100700002)(6512007)(110136005)(107886003)(36756003)(316002)(54906003)(8936002)(8676002)(2906002)(4326008)(41300700001)(31686004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWY1RjFtMUZVT2c0UmlMZTdnRUtONjByVkVtSnZaeUljWE9sUG5OM3RHUnZl?=
 =?utf-8?B?b3BwQVlrOFRiYXpRVHVGS2ZsZDFjYVp6YlZuRzNrYlNraS85VjlTcmxjZFhm?=
 =?utf-8?B?WXR0NVVDUkNrbEU2NVhxRnJibHZtWGNSeGgvdU1kY0p0cFEySWU4UzVPYW45?=
 =?utf-8?B?cU41akJBR1FYU0hsSWZ0Y0IvT0JFUE9TTjd6cUJuVzRZZzNtaHJTUERLNktP?=
 =?utf-8?B?WEdzWFlPZFFTa3VXb3NLM1FYRCtCOUJSVFdhTUgxVzMxZ21jVTltK0RQcGs4?=
 =?utf-8?B?ZUljeWtJK0NBV0JYVm1nNnpHNVBFaDE0c2JHSHZpdEU0RUNTTDJlT2VyNng4?=
 =?utf-8?B?ZjA4aWhpQ09qZ0FSeE1WVHRvV3pJbWpOM2V6blJtZEdoNlc3UlRBek16UjRh?=
 =?utf-8?B?VExOSGJXa0VoQzd1ai9STjAwN3BFYmQrcUpGczFsaTVjcFdHLzVpcWdsSWxq?=
 =?utf-8?B?endlZHhtdTJvZENOOE1JdFhhZUVzM1FMU3Z5d1hIa1JiTWRJTWFpTkcrdzdL?=
 =?utf-8?B?WVhRVDJHNGRIcWs5OTR6ZWJPdU95R09Sd3FONW50NE94QkdSZVZ2bGFWSml6?=
 =?utf-8?B?TWg5QVk4NTY1QTZvTW1sZDVlRnJQRG1IR0F1VzVUWlVhN1lBYlpCakVSeGFs?=
 =?utf-8?B?Y3RXRU42L0h5ekwwTnliTUszZWU3R3o3V09JVG95dWlrbm9xaGRQSWVYYUlI?=
 =?utf-8?B?TktxT3IzWnlJVEpLVnBoNjY3TGdiMlZlaHVweDBuTUtlVEltQy9DaVpFczFS?=
 =?utf-8?B?SThPY0YxMUpMWm1nbWVsZU1uWmRIUDZudWtSN3RidS9WMVZZNEhtNXUwNzhD?=
 =?utf-8?B?RyszamFGTDdUWC9MemdrcTM2NTcyYWl5VmJIZWptT0RGNm1ESHplc285RzEy?=
 =?utf-8?B?WmpLOTQzbVg4Y09WRFhSc1p4RjZzRDAyOGNiYkM4RFYzOUhVRHFWQWF4c2FQ?=
 =?utf-8?B?OTI4UElVUmRGQ09KU2J5dXNsL2tzdHZzMk5NOFI4WFY5TlMydGFSTVFvTUdi?=
 =?utf-8?B?T3Vjek43SWhOTWN0cUhSSEJqYjhiaThVOEVHZTdRNTRrM0RNUi8vREcrS3VE?=
 =?utf-8?B?T0tyVGtPWXI2ejBiUUlBT3F6MUpYTHlKdElvNkd2MlNBN1hHZDhOcVhrUisv?=
 =?utf-8?B?UHU2OWIyVTRFVE91QWN2NERUSUlQUVJselR2dEhhWGk5OGtXZFRjQ2wyOS9K?=
 =?utf-8?B?RnpqaThUbTBUMndQV1N3ckJma3pJeTdXMEszaWd6SHhEY1EzU1VLMDdzL3hC?=
 =?utf-8?B?OFIwQ0NoZHRmODJuRm5FVy80ZVhQdzBjTGluRU9FWThyeFo2R1Jjd0dJRVJ3?=
 =?utf-8?B?VXJNUGpPVjNzaXJ6WmFsa21WRDNub0Qyd25CaXVuOFJaMGxQOXZXVklkZFd4?=
 =?utf-8?B?T1Eyc1ZGemk1cEM3NUNsMGJ2d3NZVDR1cHptZXRsTVNrQ1YyUHp0cStBM2Vj?=
 =?utf-8?B?UTBQNVBpV1c0K01JL3dpYWdXUkY5N0xkMmpHYWtqN1VDOENuaGhSdXo3aFl4?=
 =?utf-8?B?dHdYLzV1ZnUwekFGWE9NSGd4SmlPUVpGRnNwaUt4elE0SU1xUS8zUEpUWkNI?=
 =?utf-8?B?aC9pbVJwSUdSd2RYSFNCQnJPVnVUazJqRnJSVDFtclB5bGJBb2xFWkx6VGdv?=
 =?utf-8?B?ejZGQnlER05QdkNDSW43R08waUdLYWt4UzhDZzl2alFYd0lmZjcybVZXSUwx?=
 =?utf-8?B?REtITDVXWTNRR1hraER3cnVOcDFzZUs5THBTUDhpVWhudURlYWlabW44VDFm?=
 =?utf-8?B?enhZV1VQSDU5NzdBUWs2UkdZd0RzaFBWSyt2R1dMdHdNLzB6RXFTWTJVZ1lH?=
 =?utf-8?B?SERaME5lblZNa3ZGT2s4dWEzYUd4b2JQRS9LYWUwQXVKK3BDYkluOWp2ZlBu?=
 =?utf-8?B?aiswOVRyZkV0a0h6cTBwZzJBYVZmbHJVdDdJUC9OUXpzOGtmNkxFcXVqVlFQ?=
 =?utf-8?B?OUZjQnkwY1Y3bkJnNloxTTlFTkhHQ1piRDI3Lzl5YUNDM3pIV0hrZDFoNm1n?=
 =?utf-8?B?NEhZUmdkTm5uaXNBbk4wc3dRZkVaWW5HUjhNa3JRejJmYmdkTURKMEpNaEVW?=
 =?utf-8?B?V01jL0M2WlpmdjBZYXdVMEFUUHY1N2lYdGtWZ0NrbzNxNHI1Skl3Y2tTTVY5?=
 =?utf-8?B?d0lMVU8wWVRuYWJDdC9XdFgzM0JxQUEzSXF6VGVKbVd6SmIxK2l0Y3E1QTEv?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3739c38c-fa2c-4481-62e8-08dc2bf21a94
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4538.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:43:20.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/NM5kccX1XEGFY8NUZYLUPfbztKPJ9oSkRD4PUe9NtHVbj3fxjX3xDKvION3QM7zir+tOXxAZc40rikTYZT3RSmA6avlqLJHvZpu2ou8i8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8069
X-OriginatorOrg: intel.com



On 2/12/2024 6:41 AM, Alexander Lobakin wrote:
> From: Alan Brady <alan.brady@intel.com>
> Date: Wed,  7 Feb 2024 16:42:43 -0800
> 
>> From: Emil Tantilov <emil.s.tantilov@intel.com>
>>
>> Fix softirq's not being handled during napi_schedule() call when
>> receiving marker packets for queue disable by disabling local bottom
>> half.
>>
>> The issue can be seen on ifdown:
>> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
>>
>> Using ftrace to catch the failing scenario:
>> ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
>> <idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]
>>
>> No interrupt and CPU is idle.
>>
>> After the patch, with BH locks:
> 
> Minor: local_bh_{en,dis}able() are not "BH locks", it's BH
> enabling/disabling. It doesn't lock/unlock anything.

Good catch, we can change it to:
"After the patch when disabling local BH before calling napi_schedule:"

> 
>> ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
>> ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]
>>
>> Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
>> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
>> Signed-off-by: Alan Brady <alan.brady@intel.com>
> 
> Thanks,
> Olek

Thanks,
Emil

