Return-Path: <netdev+bounces-31441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269C78D7EF
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 20:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A4F1C2085F
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 18:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881217483;
	Wed, 30 Aug 2023 18:11:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AA57465
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 18:11:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371A7132
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693419090; x=1724955090;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xuSlF77LT1u79FuPygR4g0fmv4q3hItBsRYa7V5z2Lk=;
  b=QPUWqtZv9VBlt2bd3i9ZeTD24LBUa4sJYL0qCu5ga+zNgAi83wPS7XUX
   3PFaHJTKayzC2U+a13SZ6s6DtOkWb78y8W7Q7nX/8c07fKTMJzJRpG3+h
   EwwoEnvf5nsXQG/+kRiVhOS2g545PcEr8F3nE7iBQrKCVSpsw2utOJ3cM
   4ph6RbryAMLoCqy+ZwFuHcSVy3cVk8gwnAipnZuGvSQpmjusW3ZFHRXCb
   wah0I4JJA+CuifwQ/qm7rZGeo+jj0UdvGf3Li8gVXaLLLKmoE9rFNW7L4
   EtWFyuQrVAdAlxeHd9iEgcfjbnyxz3tNKbeOjQJwQ9TpHyJH6XViNJ9yt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355218822"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="355218822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 11:11:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="862729284"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="862729284"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2023 11:11:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 11:11:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 11:11:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 11:11:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sly95aSvGNuAcHjoGQfNU/tvYQC43d7slVdp7zlEaSaKE2QvMpx/A/9q7so/frtoHf4TFxJFIK7cs7am/bei5ZnidjSxGuHmzqSglzVT60Xt/kOXMqTRVPLGSy35yUoNDzN2nEDMRSEeylNRlTd+hnVcwIDI6OhGW+Ps5tdfDyCzxP34vEmEvpGhjyvbBcqEMEDRJDbKbUK4BWqhlBeNS0lY++p56aNWH6gcps8ZPlb99w9cVWLoOg2GmylgBNNPKS6tRKODmtK0hrMRf7GQK9rqlLUpaKk3rZng2KoIRLmkb47vJvIubfKtvvEuSRPDbxZjBkx8L7SDwOfWkj/hMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x49NRpF23ECC+7GvVN9zfsFuOoYk/LlVich4VHPp1xU=;
 b=I5QK1YGnSWZHbfA1f/u2uCWslkXE2KN5z/PB+LWzQ4GckLMVh8IBJZ1fAQiHHrb7cDC/WqNCBDm28xKxl5Oc1TpbbW4bR20ufF1hNS4XAU+tf7fgtOYoPg3OtXT7+dD+cjoM7SkO2Q6GLOypvk5zaVsiOf30XuqzZYhLZF4GIA8LC+S7VNPuYsy2mCSdOwoNlTs8d3J3t8OUwRyBNfsYUALKHWDHccMKdFT4D8FbBQpfIw++K4TdAD6Lxzc8K+CwMZG2kVxlOFpCkBfKlG4pMmcLyQxXtflIJ7SWDJFsrw+IlEJijWSL3oCEdYLf5mPmCH+5+oEhK1xCHRw+QB+PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM6PR11MB4596.namprd11.prod.outlook.com (2603:10b6:5:2a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 18:11:20 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 18:11:20 +0000
Message-ID: <0fa6ea96-8c1e-4f32-2a6a-38b5ab4fb2e7@intel.com>
Date: Wed, 30 Aug 2023 12:11:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/3] net: ethtool: add symmetric Toeplitz RSS
 hash function
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
 <20230823164831.3284341-2-ahmed.zaki@intel.com>
 <20230824111455.686e98b4@kernel.org>
 <849341ef-b0f4-d93f-1420-19c75ebf82b2@intel.com>
 <20230824174336.6fb801d5@kernel.org>
 <eed1f254-3ba1-6157-fe51-f9d230a770a9@intel.com>
 <20230825174925.45ea6ee5@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20230825174925.45ea6ee5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM6PR11MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac41d2a-2b46-43fe-2614-08dba98482ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0c5MtJMLldxcZYmVp4jGWjCvB5PMen3arFPzEhf0Q0O4oMyycCtH55Wni2tup8Y6ujNLgWRRrp48o0UVC0hOKiPclcVfG/uJfOGr9i3td9DwiIea/SzL+RcAznNK9SoDmDz9UQ03LiJu2djK4Uvwu1H/tC7LJ8bX7ZmvGD3Y2BMiV2arxKiUgMg9wmNZTcttHpWRU8h9e/qZdCQ1+72Ue+R3ajL+DsxaZgTZ9NgKkZYCCjlOoQd7hEYZB2bNP3sJtV9567zfaRlKcYWYD/7li5LQbSXd6KohTew8nPlQg/SdedARvv7oVGpRgUnnIoVMMgj6a6JDh6QOkDfNBaZNi6qyIhDw6mGcWkCeWEN1n7Xfn+k8NTvuCtc4lZYqqHDF6XUiiORJPjnYA95wP4pAd5jS2XUd9hpPmgtPzVUarPPRQ5gN5d6iCAwZdLnCUbolf6GLYXGRJf/Njq1Pzu3EriXmCMMhh4qp8QSe1ecPK7YZIH4iOZ0s9rvXYCS+ZGSz22gG4hB3cf+0ptL325N4iXTY2dsOxMgru+Asp81hLoHRsGelT/RQVAF3l6hdX316VzF3HNMFG+bZspPY7GJAvy4aIySJAfWITQA7ajThof/OHFmlkaQ+jHp7+X6p1/qWBGiIoqoNF0q/xwII4PvmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(38100700002)(316002)(41300700001)(6916009)(82960400001)(4326008)(2906002)(2616005)(31696002)(86362001)(5660300002)(36756003)(44832011)(8676002)(83380400001)(26005)(8936002)(6666004)(6486002)(66476007)(66946007)(6506007)(66556008)(53546011)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTRsbXUvd0QvcWpNdnpwWnEwRStIdTh6NTZ1aUF2WkQxVFJ2cG00UEc4N2Q5?=
 =?utf-8?B?WkVQM0Q3SHVDN0VPR243SUdLY1lRNjVhSHBPV1RrV1Q2ekpZdWJlUWsrVnZH?=
 =?utf-8?B?Z1dJYWNwOXZMMUxrRDQ5SDJ1amg1ZFIrU3hHV1pyb1p2MGxHdnUyK3MybTJz?=
 =?utf-8?B?RmRNSW5RY25WU3pjY0NSc2NyRWZybDhWMm5nR053b3pnMTNSa3VWTnFkUE13?=
 =?utf-8?B?aFlQUHN2QjRycU95N09tL1ZGQ3IvSE94akQ1TjltaWFFdVI3cGtiN0FOTkl0?=
 =?utf-8?B?MCtZdTJHcE9IUHZ6ZFRZS1ZMV1VNMjJOY0tJOUFZMXJqNnlMWGxPZEd4Ykc4?=
 =?utf-8?B?ellUNGR2cXpTTXhuaDhpY3AwUjh5S0Fqb2tla0Z5YkFLWFN5V0FLUTlwQlp4?=
 =?utf-8?B?Tlg0YTdEVjhGTnJvSUM2ck9CL25hNVRRQWxtNlBGMVRGTC8zdTVBYWRMb1c0?=
 =?utf-8?B?Kzg5bDVweHkyVEt4V0RSbzgvYi9QdmkrZkdPZUFxN0xhcEhySHBRT0lDb3Zx?=
 =?utf-8?B?VTFObkJqdmphSEhVSzUxVmpiZEVWYmR2b3RyWEdFOERlT2lCYS9KZmU2RXlz?=
 =?utf-8?B?c0F1RzA3TG4vTWExalo1eVhUdXVSbjJlZXo3Z20zOTJaMFdzK2ZObFRlYkVt?=
 =?utf-8?B?bzhRMkY0MjBFZytJSEhWVEo1MjNDK2cwYVIxdTAxbytMQzZWeTNyTFdwWWpP?=
 =?utf-8?B?TGdIWEgxM05LaS9NdXdlajRHbXFhdXBhdTAvSzZpTFBSVC9hc2JJOGM2eUtr?=
 =?utf-8?B?YkxPUlI0a2twQ1kyUHVxa2VnQ21Pak1SRWFxaSswWm90NGtEUExZVU5rYjFY?=
 =?utf-8?B?TWhIc1NTTDV5RUJ3RDR4QTBDYUJDVGlPc0NheW0wVnBON2ZtM2hxL0p2VVRv?=
 =?utf-8?B?WXZEM1lZeTFXY1NyVGQ4bEwva3RpSzFQRmlZQXB6M2kvUTlOeDBvOWVZVEg2?=
 =?utf-8?B?SFNmSjY1Szc4NDRjcldmbU8vRGhiWFJjdHdhbHJhUTdqcVNJMFloU3JBTjVu?=
 =?utf-8?B?S09ZNHJpSEkwYTRpb2JrVTVDVmkvSUp5dkpkUVh0Z3Q5RkJRQnB6Q0ZjWVp6?=
 =?utf-8?B?c0VNN3N3d2xtZmRLZnFqR3BEMmxHMURncDkzdURFcE5wUGQ0ME9oOXJyaWJG?=
 =?utf-8?B?eFBIcVduMjd4MHR3UXcvOUYrNDNyUnl2T0RWaW5KeEJxL05wWkJxbUM0c2dN?=
 =?utf-8?B?LytYSkRZMDV4WnhnbUJwSjZLSncrQS8vUE9qRFRqZTF2MXIzR2kzTWZ5aHB1?=
 =?utf-8?B?UE9ua3A2dVk2QjNseE9EMXZqdS9EblNOWndFRzZXR0tLQkNzL3ZoT0VkOUYz?=
 =?utf-8?B?ZWNnU2x4cDVnUGdwTkFxamdPcDQ3dGlyZ3hVSGdxVEJIVmh4dUVjQ0JwL01i?=
 =?utf-8?B?SVJ2TndwM1VRS2lxSXZ6UnFMMjNIdEtVNFhRV085eW9BZ1pHNU13bWE5MEtK?=
 =?utf-8?B?ZDhGK3VHVWkwNFcwNUJQZWdmeDBza0lidjRYWWNPdHZlb0craHlGVGorWmxY?=
 =?utf-8?B?L3A0YmxHQ0xwdzlNNUgxcGVaKzdXTTBVd1FUdEt3S0JlRnpCdGEwRHVGYnNj?=
 =?utf-8?B?bGJvaTBzdDFXM2FORVZ1NkQrcDBhZVd6ZmgxYW1XZ0pIcFFJSUhSSlBTbGF6?=
 =?utf-8?B?Z0dzeHRJS0p4eGdiL3kreDNOTFUzZFFBam5USCtCYnpiMG1ZRWNoNFc5S1RC?=
 =?utf-8?B?ZDRVL3RrQVp5UEdhc3RUbWJzMGo3eG9WM3BsZ1RUdmt0ajJGNS9NRWl3RGY4?=
 =?utf-8?B?ZGFzUk50blNadVFLbkpkT2FGcjFibDJUL2VXeTZ6elQ2YUptaDRNdUNLNWY0?=
 =?utf-8?B?Z1FvOFRpNm1zQW45dWxUb0tXMEhaME90aFV3VXpZSGt6NjJUL3NFTjUxTnNr?=
 =?utf-8?B?WnB6Q2VZb0ZxV0t0Q211N0d5MEUxL1A2RktiNWRyTWJiODkyV3NTSlcwWFRv?=
 =?utf-8?B?R3ZtcC9IcVM2QVNkQkV0b0NxYzF2MmI2dnlNK0F0VHgrSGluK0J6REh2YWN3?=
 =?utf-8?B?ZGtyU0h3ODlqSnFLS3IwV0hiS2ZhdWpudHljTzNzcndRaUdLSXF1R3dFVkMx?=
 =?utf-8?B?VWFacStiMDJHYWdIREpFV3VZU2ZVZFJReTduSENSWUJuNVNTc0JlQ3VvMXJr?=
 =?utf-8?Q?9d42IOL0+11yezgAUZVRY/S1G?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac41d2a-2b46-43fe-2614-08dba98482ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:11:20.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4pWIjaiJxjcNpPOj4U3UcVDIS0M2zHQDLBwjLuTYYcrVtgjBP6sO710OxkyJLW9Z1PXjk2hFKhGUmm3xWsjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023-08-25 18:49, Jakub Kicinski wrote:
> On Fri, 25 Aug 2023 14:46:42 -0600 Ahmed Zaki wrote:
>>> I'm just trying to help, if you want a single knob you'd need to add
>>> new fields to the API and the RXFH API is not netlink-ified.
>>>
>>> Using hashing algo for configuring fields feels like a dirty hack.
>> Ok. Another way to add a single knob is to a flag in "struct
>> ethtool_rxfh" (there are still some reserved bytes) and then:
> Sorry we do have ETHTOOL_MSG_RSS_GET. It just doesn't cover the flow
> config now. But you can add the new field there without a problem.
>
>> ethtool -X eth0 --symmetric hfunc toeplitz
>>
>> This will also allow drivers/NICs to implement this as they wish (XOR,
>> sorted, ..etc). Better ?
> We should specify the fields, I reckon, something like:
>
> ethtool -X eth0 --symmetric sdfn hfunc toeplitz
>
> So that the driver can make sure the user expects symmetry on fields
> the device supports.

Seems fair. I will prepare this and the per-flow based config code 
("-U|-N") and re-send.


>
>>>> I agree that we will need to take care of some cases like if the user
>>>> removes only "source IP" or "destination port" from the hash fields,
>>>> without that field's counterpart (we can prevent this, or show a
>>>> warning, ..etc). I was planning to address that in a follow-up
>>>> series; ie. handling the "ethtool -U rx-flow-hash". Do you want that
>>>> to be included in the same series as well?
>>> Yes, the validation needs to be part of the same series. But the
>>> semantics of selecting only src or dst need to be established, too.
>>> You said you feed dst ^ src into the hashing twice - why?
>> To maintain the same input length (same as the regular Toeplitz input)
>> to the hash H/W block
> But that's a choice, right? We're configuring the input we could as
> well choose to make it shorter? v4 and v6 use the same key with
> different input lengths, right?

Correct. All RSS fields' offsets and lengths are configurable. The 
example I gave before was from the datasheet, but it seems we can feed 
the Xored values once.

Thanks,


