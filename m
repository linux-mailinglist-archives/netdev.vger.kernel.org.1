Return-Path: <netdev+bounces-51388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C67FA7DC
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E9E2809D6
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3A6374EA;
	Mon, 27 Nov 2023 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2pWfr4c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF4189
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701105682; x=1732641682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FTBqpqLpI+Ngif9twlpep/YLu6kVy1ORMAkH/u2KBIg=;
  b=b2pWfr4cwHeR/7lO2C17e8RpLesys8P0j8Eh9lLTUlwOe5sAjP3bnCp8
   Y+lGckcSzz32JEcokoTV/2vYE3XIHKdBnTmuC9R34rg/dIHZigGTRZ3ZT
   5oAthvs73EjwDqPDvCmp7F6zyI7YCP0xocehH7/Ww0SwYH6oZCAHAcp/y
   Ip5mFSUVf+W52uohTwGXghMsrzw+ELis+E9PPlPqfkfN99ppDex+jJp2T
   3L97IU2sUePvgSuOdaKom1TUEpbnifW+uaonXMcafJzQjH0NfRMSEkgE2
   S0PDBs/pS8+H8MVZD4XsuIV3svBBikIwseSmaoYhOzUcwqZaNX0B71ssI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457080553"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="457080553"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="802713072"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="802713072"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:21:21 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:21:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:21:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:21:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPhcGxLUcVn2hRad+mrouo+vuMcSVz/KjzQfx8DxYKWSkxHDhk1FEUV9HmFsL+NR+Prc6vZWO13x88COspkQYgWQTboDXcGOX9TKYZgEEQ5WPHpdKa1sSAMsYaWikYjD6Yr3bqS1DqOzodpN0119gqAUdfriihmyFWQ2uGQm9YPwFJmQ97J3DRqZoridq97RF2H4CXSXw2AgF/1ueiRrueFG6+DD/ASz3qnH7807NSC12qGL0Y0qBVZdWGo9MVuSDB6dpec+zBgP2TT/C0cNLfy8poYZqFdrYlL3HulIpEE6rNvlvfYC4HcF3TB21HGqN1gT7ICJOAdDBVceXZjkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SA/q9zMvZndu0EMqEpawt8F3OeyuMW5DmxrduLuT5I=;
 b=JKsZWdZDbfvPe7n0IJd+VUgnty8qHYtbeT2BSQuh/H+nsBxtjcfZzVWwbs+OQRk1fexZEjY1Df6hiTdgFUJXAkWxOaz+4qckMMaVEK6YnpL/JlWAxNPCwTWPFN3ZzY+Wks8WWRTGmNrDgtbYtGSnYtq2vGDvjWEfFejSfHorw3CZvBvgPZ8GiLJmRo+jSQp+/DcxQ5bNu4WHi0cMwZYl8M7JTNu0kYeltjIX6jrlqKw5sTDF6wpUOmYGsV2Z2uq0b3nRfXCsoaZNw9e+Fk6mKtX7wcUnwumDwE+0FCvTOv/kAYaDqPMpyNe87DJocLsSIIzETaO27GNsaxeplsp0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 17:21:19 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::11e1:7392:86a5:59e3%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:21:18 +0000
Message-ID: <e77ba51d-2bd9-ed70-ec9c-60799fa21053@intel.com>
Date: Mon, 27 Nov 2023 09:21:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [linux-firmware v1 0/3][pull request] Intel Wired LAN Firmware
 Updates 2023-11-22
To: Josh Boyer <jwboyer@kernel.org>
CC: Mario Limonciello <superm1@gmail.com>, <linux-firmware@kernel.org>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>
References: <20231122173041.3835620-1-anthony.l.nguyen@intel.com>
 <CA+5PVA5ULYE=b-_O6JjhtPM2zASCzEbcK95eQBfhs=tQSkPhWQ@mail.gmail.com>
 <CA+5PVA6FrzEy1RSMnHA_xixdOZDF19VZcuC1O9bMhdH39OXLRA@mail.gmail.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <CA+5PVA6FrzEy1RSMnHA_xixdOZDF19VZcuC1O9bMhdH39OXLRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: e8155e78-222b-424e-4eda-08dbef6d445e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rcsMM8ORxK1HCrQiIzXvd4h9Afb3XXHwqFCcm8ebZV6ew+PWcze8lla4F3SQ/HX7LH3UuGtg+GLjAOX+DccaGKT0A+co9XrNnyW7vUXTnxnJ2rxIPk0HKNwoXvZH1IeJH9nuzY4FtYXimkI7oexMgn3NVnbb0f6ZjCWxfTTjxU3m/6MxpNlgKmTVoAjRvY4NUOd+7cla4aB/7ksmMpo+vNyewoqIVnRQZKr3arnsRjepxJwPGRtbYuVZaq85GB9unI+7lFNospDNyWzDtUW8FLwMY2aG00BKn5pTRuP9rRvP/tttPzu3Ty5SkGy9p6NFmLQS7SABnq132fFxH0b0oq0rPcLxUh75knMfnUJNPRukhpcgugeMybDi6qVaSAAUZYgtGORVxQkMw0uxGOrsBXjGnBuyc9X3JDgRQdtKFVnMgWzSm/x+8ms4bgem6d9mdGg0mSs0MN48X9yzDwsfl7IoH8kd2Nr2nOthnuMkBHJ2V+7QK2mg39fE1iYEVMaRAyFUQ9WY8spCaloE6svcSbSzvWv1Zfo65Hn5NRJgRHMDZSiyHCb4H5JYmA3BiYYFrtuIwWEXH+Ig8i7M0VD5AE2P/UOaDGys5kvKvNEIzOSuAfKlnK/rX7yHCBzQqrsKphl8OrF/tDwnsTK0GWTk0BcQxpPNbgyDh2dZRsSHQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(107886003)(2616005)(26005)(6506007)(6666004)(6512007)(53546011)(82960400001)(4326008)(8936002)(8676002)(15650500001)(31696002)(5660300002)(86362001)(478600001)(966005)(6486002)(66946007)(66556008)(316002)(6916009)(66476007)(38100700002)(83380400001)(31686004)(41300700001)(2906002)(4001150100001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0ZTbytkYXdRYm4xZGxkSlQ1eVBWT0lFYkdpWGVzWUF5bG5uR2g1SWR0Zm9H?=
 =?utf-8?B?L2Nxbmt4ODg1ZWZaUk5LemZPdjJxWnd4bFdhTnVubWEvWTl3TzkzbWs1V1cw?=
 =?utf-8?B?TEs1bWF1UUtvMWtLODNHOVN5VzRDWlFSRGNOWDREUVVYeEJ1OFdDVXVONnRv?=
 =?utf-8?B?ZEw3ZGMyT0l6S25kcG5Ea2JJeVNqU0piZFRLYUtPQldrVWYvZTdhWmc4UWtZ?=
 =?utf-8?B?cG9sdWVYOWJNK1lOVW9QSGt0TkM5R1R3Z0UvMWViaFlySVJrYTNQL2ZLLzJj?=
 =?utf-8?B?OUFaUk1GQ0hnV2JwTk5uN0hlYnVhcENEZ0pUWjQxZXhuRk5majc5U2ZibXhw?=
 =?utf-8?B?eGVxT1JpQ054VFhhREtoZk9nRjNDZ1hpUEJLY3VuQTljejBmRGw3TUxUTnVV?=
 =?utf-8?B?bUc5UW9sU3dyUzhuMlBSZWRSYks4S3E0RTBvYlRvYmtwWGRkMFRBaXBPYjVE?=
 =?utf-8?B?MHJsT3dmd0NWTm1Md3dKdkZMcFdRT0NvZTY5YUt1V1hiYTR4cDdOcXlwYWZk?=
 =?utf-8?B?Wkp3MytVcnFKa2gwSFVOSFhyQlViSnM3TVgyYXpoTWdTTmF2R1VhbTJQVHBs?=
 =?utf-8?B?VE5MTGZET2IvS2R5aFlqRmVzWTlna2tFcG4yWk9OTys1L0VCc1ByV3N2bnhw?=
 =?utf-8?B?Z25kL1ZMR1lGNExMTEUwV0U4aTNTZFlTTFNzWWF4bFpFaG8wbklIeGRZOXUz?=
 =?utf-8?B?aWZLL1JpTnRkREhQOWtBTlp0VGh4WGhheFJRUHYyM2lKSEVOSEtVS3BYMVdB?=
 =?utf-8?B?azg5cEpvQkkzbXA4MjlJa01JbnkvenVTcStxS3gySzBFbWdRVDJKTUpyRkNV?=
 =?utf-8?B?MFhzSVV3SFRPY3g3ZVEwcjVIclVxZE1FT3ArUTF5Z2REU2tGUkdWSTZlZ2Ey?=
 =?utf-8?B?QW9UUytmMWlYOSttMjhidUlMeWFvdlVWU1JoS3ZybFNhcXl4VFFDR2szUUtv?=
 =?utf-8?B?eS9CUEFLcm44akY1V2V5L0ZxTzR5NFdmdzh4TUNSMDNzTTU0bXdFSkhtaDZG?=
 =?utf-8?B?bkVmVnROejdGYjhCQkNkT0pqZEg4cXMvdGdySGlDUG5aZWliaWljUUxHc0xW?=
 =?utf-8?B?OTJKdUFleTh4UkpJcVQ0RDQwdDZDTU41R0dtSmw1aFBUaXVQQ3Q5UnlGVG9v?=
 =?utf-8?B?OWc1OGRYZlNiVFhtMjNXVjhPQWtiL2pJaElEL2E4S3RXaVlxbjFBMHliM1pN?=
 =?utf-8?B?MS96bDA2RkRwQ1AycEcvVERuVjRPL1AwVnpyMWk1MTZlb3VicXBOanpHd3A5?=
 =?utf-8?B?V1M5aTBvSkNRQ3lqNzNaNkxkR1MzU2ZUWkJWZ2xyVEN4L1J3dWNqd0ZaSDVM?=
 =?utf-8?B?aHdDK3hSMGZUVkdoaUE3eW5vNEV4Q1hBUGxhZzB4c1NFQUkvcnZWUFZtZzVz?=
 =?utf-8?B?cStUQ2VBUGVsWVRleWZnQmV2WDhQMUwydnVlcWFSWkZtVUxjU1N0VlJzZ21w?=
 =?utf-8?B?WFVHbGNFamVEZjliYzdWZ3dRckJBWEV5M0lOUUZ1N2g0UEJ2a21qZ1Zjelpu?=
 =?utf-8?B?aEJ4bUhtaHROYWEvR3VXdXJoazFDUU13RHRySE1TR0VnRG1nNXYxcTZzdWg4?=
 =?utf-8?B?M3BNQlI1dW5PRTJNcktzc1NxOUo1SG9KQkt6U1VRaWtuMC9ZOHNaTDNQZlY4?=
 =?utf-8?B?dVJCM29DZklyV0dTaTBkWXRpU0p2NG8wRHAwWGs0NU1SaFBQOVQwVGFaeEVQ?=
 =?utf-8?B?MjI5ZDhKZ05oTUdmd2xzVEtUVnMyMnVBTjNNYlYzS0NnUUdBWUJuM0lPRCtL?=
 =?utf-8?B?Z0tKdGhxSVh6bGkwODNqSU5HV0l3U1Nud0gwcDVNS2ZqRUk5RGtJRDVhOFFI?=
 =?utf-8?B?YzZmTHhNd2RvejVHRG1WdXpKSmQ1ME1GU3FFS2NHVmhaSnBucU85bWZkQlN3?=
 =?utf-8?B?cEUvTnNOZ0ljZnNlbkpCWWhhd1RqZG8rWWRVNS9YSWFYcFVubkZHd2toc0V0?=
 =?utf-8?B?YTY1bDNGMWdpQ0FZbHZQcjFqTnBaUjR2c2J1UkErMG8wMUhySDFaUWxVaEdv?=
 =?utf-8?B?bkZBZStwY0lZdTkvbjFwN2V6UklHN1FXVi9KL3cxRWllaW5aTkpnajhxSjVv?=
 =?utf-8?B?ZnhFR0ZEemY0Mm5IdG5IRW9CYUpKVnptb203RDU5OVFITXUxc2pCQml4anl4?=
 =?utf-8?B?VmZQRWtnYnZxK0svQjd2aTk2UjRySU12YmJURnM5YkhUUUFySXdvZHZWQzZv?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8155e78-222b-424e-4eda-08dbef6d445e
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 17:21:18.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWcVHoHT2cr3pmpXImnrhldBMcDOMpuA93dMB4RDaGaNwnqu4106SP7F5AN6e3X8tCTYPNBtNttekbZ7BK20mGOjOre6lmx92e5L4xMvBzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-OriginatorOrg: intel.com

On 11/27/2023 6:06 AM, Josh Boyer wrote:
> On Wed, Nov 22, 2023 at 7:10 PM Josh Boyer <jwboyer@kernel.org> wrote:
>>
>> On Wed, Nov 22, 2023 at 12:30 PM Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>>>
>>> Update the various ice DDP packages to the latest versions.
>>>
>>> Thanks,
>>> Tony
>>>
>>> The following changes since commit 9552083a783e5e48b90de674d4e3bf23bb855ab0:
>>>
>>>    Merge branch 'robot/pr-0-1700470117' into 'main' (2023-11-20 13:09:23 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware.git dev-queue
>>>
>>> for you to fetch changes up to c71fdbc575b79eff31db4ea243f98d5f648f7f0f:
>>>
>>>    ice: update ice DDP wireless_edge package to 1.3.13.0 (2023-11-22 09:14:39 -0800)
>>>
>>> ----------------------------------------------------------------
>>> Przemek Kitszel (3):
>>>        ice: update ice DDP package to 1.3.35.0
>>>        ice: update ice DDP comms package to 1.3.45.0
>>>        ice: update ice DDP wireless_edge package to 1.3.13.0
>>
>> Sending a pull request and all of the patches to the list individually
>> seems to have confused the automation we have to grab stuff from the
>> list.  The first two patches are merged and pushed out:
>>
>> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/75
>> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/76
>>
>> but we never got an auto-MR for patch #3, and the pull request MR now
>> conflicts because we applied the first two patches in the series from
>> the individual patches.
>>
>> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/74
>>
>> Mario or I can fix this up, but in the future it'll just be easier if
>> you send either a pull request or individual patches, not both.
> 
> The third patch is now merged and pushed out.
> 
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/85

Thanks Josh. I was out for the Thanksgiving holiday. Will send one or 
the other on future sends.

- Tony

