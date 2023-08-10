Return-Path: <netdev+bounces-26587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C66778442
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65784281DCB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0A134B2;
	Thu, 10 Aug 2023 23:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D91877
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:45:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00086271E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691711103; x=1723247103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4Ig6Ef1IGmas+e9Rg2Cwi3lbhNE1EbhQXodoUpiRZU=;
  b=lC46043gOIlIJfILxvqOTlAJItBsfJvbrJg/wVibc7LAoPWmp+UuQKhx
   Sg/MbxJ6X+iuBYfIeXdrmOPsW19PBIXXTCxaOvqZ9JJZihutLlwj4gtEr
   +oIM6WRRB9h7cKBGV8AwDRYmqhd2B89F7zY7nu8eBVBMmMtLpc/6RP9iR
   d30/ZFOxnp/+zj0F2W7GEslWpyXkjaPrrOhUNrfmKWMLuTxaZ7hMlsTAa
   UOQgugokT1B961jkjBX1BrzIwaxaAVX6trX/+GPaq3dlFYOX4y0ZYwUcL
   G7kPnFzj4ZlIjUo1WytTVVkW9pRMC/DgNmgpvOSgKhl8Zd1VNzdk6CJkf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369023231"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="369023231"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682318974"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="682318974"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Aug 2023 16:45:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:45:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:45:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 16:45:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 16:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6mRhggXsMtRuA8BHZfdeIzHmR7+9RsYx0FQVPtNk4W+zN1ghBekdMNCh8WAZVdhhOckx/DOZmHvKqatwoWV5wdy16Xh42WlCF2p0R4TStmpsvTDJAuDVDZY8s1UCMNxnAy5pDcakXRfm6xoqokdtOn2XSe0kUZANXwjk3sZd2+QsZ3WUlkAl8VpFqje1fFWI8TRl+nB5mb0K7yPQNlTqIE/iiLa4TGxfvQDZldBOI+Os8q/civSV6Tf/xu5fpvh3pMwQhOC+baqOsa1geP1Fufcm4P90s0eZvAJJRy73JJQ9/KkmrYCXlLAhB4mt1F27ifDq4KJ0Q5n6oGESQZZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yd2L2hflcvET+j9l1RtzEI5g+PQiddAvnmbzSK+TPYE=;
 b=jotyXUTume7siyPcO2fIBZZTZqGt2LnkMXlPIqinjAZkezz63g21X6Dq5k5c88kOBBMIE63VLMoITcUU1p4NdbNR92+fVKtOWA7jmGU/7reVXZ3CTCdT5Nr26QNz7emcWjE431zjqD5JVnLw7qyjjN0PCM+AxZq/zrDQPhScya1ENRdwNwuhM1iAZj6UbjvWksDfN/NBCw71IHmNWNtuRsXWT+noSOYHIJgV8jlQF4XzDq36sbem7GkLc/ASgVmpxulblQ/TTaKfsUh9sGdQJwrorww+SjccS/zH6bPv1Y+GQw7PNe37yO2/8zWpCNQven/rMyKjPUHrq4zXcJ16Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 23:45:00 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:45:00 +0000
Message-ID: <e09cddf6-3207-b913-ad51-e283b3ebefa7@intel.com>
Date: Thu, 10 Aug 2023 16:44:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH iwl-net v1] ice: fix receive buffer size miscalculation
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>
References: <20230810002313.421684-1-jesse.brandeburg@intel.com>
 <16c05f6d-e971-b487-6eb8-ba5e2bcd658e@intel.com>
Content-Language: en-US
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <16c05f6d-e971-b487-6eb8-ba5e2bcd658e@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:303:b7::23) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|CH0PR11MB5426:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a46568b-725d-4420-efb1-08db99fbcfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTohO7WORemV9hXMmE5yo8GZX8k5ELbSEixMXj2/NoIUF8BTXAiWZahPJ5iEKT25ObiFPijhbjdgubAx3riN5F/qvYRGNOh8cromJ0rQ/rFSSrxL6lGfzeJdv1YtO1m436aS14+egsgZnxvdhafCY3SV75s5oAOSun4XETnku7vT/ZLVvRD0qmqnIUNTtLFrtRPfLB5Z85qOH5OTzZrQK6hvmc88aXRFhF+xIjjU5BWstBbT1eGcLmeaOg2cnPlRYvSt1hGrZTbssAjfQCipvgzsS6Y2lfari2q2peUMwz2wSLk/ZdcKE+mnUm6LXlrdBIzO1eDZNO1la9IKuXgyMA40GB88Iv0g2b4brQ8zIFVFOpoaREat1VwbidyNwiRqx60xh76/t3y4nAzds/HBWfPDeo8YtVpB3Pb63YDU46PEZ/NugqvmTLo3UypJU/j5f8NX2FVFCyGUSgqodzF/HFjRI7a5zwbw/C2Y3/kNiz4uujbxE4DePcu1rBC2pedOCxpcIRQLAOi/LtqwhDNaUUoAwLUe9NgNN/Hnle+TJpC44HqIpEemZP4FiEXZqyyi42xTyCULKF8YBMAn3TA7svLjPqPLxQqMnQox1i/IngZPXd1yrs6iB5Wsk9vmcUzoyedrIwsv+m9F6jB480u+ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(186006)(1800799006)(4744005)(2906002)(41300700001)(5660300002)(316002)(44832011)(8676002)(8936002)(36756003)(86362001)(31696002)(82960400001)(31686004)(38100700002)(2616005)(26005)(53546011)(6506007)(478600001)(6512007)(4326008)(6486002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUwycFJ1TnNOOWVIdEJaUklib0xzc0ZWNnpVZTU5MDcwelBJbzJvRTU2WS8r?=
 =?utf-8?B?S0tOTnFSY0pSVzltVnVITktoSTZMMDZnRmwrYVlDZkRyWS9weWM0WkxZQ1Zy?=
 =?utf-8?B?VWpjYlR2VzhvSHp4K0ZlL2NteUR5SHV4bzBEdHV2OXVnZWh6bWk1a2dzYy9r?=
 =?utf-8?B?bDBFSUxleTE5aVQ0Z0RkQ21Ka2ZDa0FYR1QyRWVNUUZOTmZtMjZIeFVVRkl3?=
 =?utf-8?B?bUEwTXZjQWZENlUvOCtkS212Yjl2eGVua2toUGNMeGEyUnY5c3paTUZEd0RD?=
 =?utf-8?B?WTE2RHFaOCtmODRsNVkrWHI2cmhKSGRORnJjYnpvK2ZaZE0yMVoxeUFVem02?=
 =?utf-8?B?NThjdDM5UHVJOHF6TXBHSVU0RFc4eVBieCtEOW0ydW4rSGtpaGVFYlA4Nmdn?=
 =?utf-8?B?dDhSR3QzKzdqMnJ5eXI5UTBmdkJDMnBrUkhQcmpoaFRaQ2kyaDhkNHA0cjd5?=
 =?utf-8?B?MW5GWDJKNWNuUXh3aysvZFNScFFTUS9mMUFSTnhDM0RpQllNajFhN0NBMzIx?=
 =?utf-8?B?WTNJWUZJcXJnVWNESG5KRG1ZVXREY2lFUUF5M21nUHZGSVBwRjJZZDRrOGJR?=
 =?utf-8?B?ZDlKbmE1NTFKeXNvV2RaUkpxazUxbUpmdk5rYlgxVWF4dVQ4N3UxSHVKZjJH?=
 =?utf-8?B?S1pya2plTC9kdzFGNVJvZTR1YjVGUHZ0QTdEemdsenVmRnJKazlnejdnTFZ5?=
 =?utf-8?B?dWxObTVhdU1wNm5reXhTTnN6bFB1aTBQcTJNT3llSzdtZHhMOEhQMEo2ZTIx?=
 =?utf-8?B?MGh5YXNMeWpkSndrc0ZXTHlGM0g1TEFucEt1VFVKR0EvbDdBOUtyelczTVJJ?=
 =?utf-8?B?b2dueHZCcGNhTlBvN2xKSmNYOTZwRzBjNUI5T0F3NkM2MEQxUFhGTXN0dmZC?=
 =?utf-8?B?OGRpUjZVa1V2ZFJOMllqaXBWa1JIMURtM2JvQTJaNXJjcWQraHY1TDMzenRh?=
 =?utf-8?B?RCtLUGpjcEErZEJQMzBubk1UR0cwTW5MTVErSy9SOTI1czAxdjlQQXVpU0hz?=
 =?utf-8?B?VmVETmJVQ3BtZkRCUlJQMmlXNHNvbGJUS1cwQnNqMTV4R1oxMk5yODBCQldt?=
 =?utf-8?B?Ykx1N0NhT0pEZ0tONjJ3N2QwMjZXYVNxQnR1QmpTWjZDNDZzdEdveW9TSUNv?=
 =?utf-8?B?ZjNlWVhncU1TOG9wcDl2RHpSK2cydXFrWGxNSXlLRzN0MFlETHJFYmkwK0oy?=
 =?utf-8?B?eEN2TXdzVExwc0Z0NGxsMHdGeDlZU1dadGJYWjRIczk1Ty8wZGZqV3Ywa3VB?=
 =?utf-8?B?dURvb1BpWkZhVllMK3ZOSU8vTUpUWk93bG9aTVZnWEpHOFkxMWNUZE9sOGpM?=
 =?utf-8?B?cVNDeWI4bUx0OWk0VkMyQ1dZRi91SkVZMUdrZWt4R2RSTjAvYTZDTkxqS2JB?=
 =?utf-8?B?UUFieExrVWJNZVF2dkV4czQ1T0hySkVReEUrRDkwMGRsK0poaHk3NXlCRHZa?=
 =?utf-8?B?ZlZjR0hSSjl2cmZCWEJtUnIvUVJVNFhWN0lPb0dZczJ2ZFhCeVl1d3ZMOGpT?=
 =?utf-8?B?VjlRbUNMa1RpYWtHN3ZuZWlGWEltUXhHcVU2YVNxbDhCWGlXRXBiQnpLUWVN?=
 =?utf-8?B?Ukt1VlQ4MTFSenl3MEFsajJ3YlpkR0xlR1lLQTJuUDIxank2K2w1U3AvRnho?=
 =?utf-8?B?b2ZIS2lDSVJwQU1pZDB2QVRCMEk5SnRhYTlGRGd6ZE9UU1JycWZxa2ZPY1A0?=
 =?utf-8?B?RzRIT2J6UGtLWWVueVRXcE14YUVacUNBWFFhVkwvKzVpMGRXYTJiNEVIWVQ0?=
 =?utf-8?B?VG9rc1QxZEFkWVBoQkNKdzZJOVRpQjNoRHdBcjNJdlMxaC9VYnhiY2VhQkdp?=
 =?utf-8?B?TURSVDdnb3piVTRDWEV0YVZYSC9RRnBNRHh1SkhldTNLVUM5T25KVkV1aUZu?=
 =?utf-8?B?ajVPSHV1TEV1QmxScnBzUFhiM0lhUXp3UERUOThQM0pNT1ZQWnB1YlQ1K1Zw?=
 =?utf-8?B?NlJvYjRpNGswSkN5b1Z2bVJTcmsveWhIUmg2RnhsbUs1MVRlSWZXRm15TWww?=
 =?utf-8?B?K1dDNTNkcy9sKzZqaHhHalNPaE85cGhtL0g1ZzZ5NkRhN0J4UklKOEZteGRW?=
 =?utf-8?B?Z0lHTGs2blNQZ29LUktrK1RLR24wTU8xazNCVkVFL2VhcUhlUGxEeU53Z3pW?=
 =?utf-8?B?dEZLY016d2dBajFlbWw2clIrOGtCS0hJRElCY0V3T3NxT1ppQkFGNlB2UGpF?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a46568b-725d-4420-efb1-08db99fbcfb0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:45:00.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOfJwYwinVYuIFUm9rtgbzLyfjo7tyo9MSRTllJFf7AC4RqOrLNsopRVDd1z/UTHD/TrneHKWLctkrDYQYm3NMjGnk+l0te57r9e7mqrn9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/2023 2:33 PM, Tony Nguyen wrote:
> 
> 
> On 8/9/2023 5:23 PM, Jesse Brandeburg wrote:
>> The driver is misconfiguring the hardware for some values of MTU such
>> that
>> it could use multiple descriptors to receive a packet when it could have
>> simply used one.
>>
>> Change the driver to use a round-up instead of the result of a shift, as
>> the shift can truncate the lower bits of the size, and result in the
>> problem noted above. It also aligns this driver with similar code in
>> i40e.
>>
>> The insidiousness of this problem is that everything works with the wrong
>> size, it's just not working as well as it could, as some MTU sizes end up
>> using two or more descriptors, and there is no way to tell that is
>> happening without looking at ice_trace or a bus analyzer.
> 
> This should have a Fixes: ?

Dang, you're correct. I'll send a v2.

Thanks,
Jesse


