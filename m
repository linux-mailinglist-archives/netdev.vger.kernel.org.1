Return-Path: <netdev+bounces-67707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AD5844A54
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 22:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C4528F3CB
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14238FA4;
	Wed, 31 Jan 2024 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTzO3/ka"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9876239ACC
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737602; cv=fail; b=CBzClVGBJsiR/+KDPIKmGIQeSDd27V3fG+SBNu2YtsblmwAd72HiteIgD890sySi/dCEjzWQAo3Kr/s1d5G06tHMgco/x9jNZ1XvR8gqOF+9wVwomItGK1pc+pL/Gc0GwQx9nWdrd4Kji1XHhXPX2+0Bax8miWjygKvCAcwwikc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737602; c=relaxed/simple;
	bh=fbyaw+dHteb34xn048pQaxbzRX7suZjTwNlueeFRgIw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DyC/JdkY93VxmImaLPOV3aCZw9MoRLn8uHgPr3cQEZhWpIkpEkek+/WiTlNtXNMrtCh05XN65KVyp+XFvuDgliWBvstMiXIDaoZT0/iKLENxv0Dg5PgttYCCybiFMjVQ7rvr8AkVnwKGOHn5TuCPUMOYhGLIHJ8UiavVCUB9x4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTzO3/ka; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706737600; x=1738273600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fbyaw+dHteb34xn048pQaxbzRX7suZjTwNlueeFRgIw=;
  b=GTzO3/kak/RlUx08v2MNPGyB4sduXR0R4oAVJZdcwesNo0oMBGZvCgsI
   t46yTeDN4tXebK225azaafTfvZbjTP9kDlc0s0jf4qtDzT/nPQVUyw8v9
   A478owD+5nqNlhZXZXjErRnQgImhq8y+F8mwO1wZ1pzb0WnFoR91ZZm8J
   vmCKH/c4omTt5mq3DOzONnHZnbi3+4AMuD2LV5WmBOPqBUhkwnfpOAkBO
   3sC6hS0b+4LR339TmpyM28xevmcySMl+SjjX8dlcYFLdl4dePrdEQK3Yb
   luBAkqJaTVFGZLMlzYcGbCqDdhCcE/MDv34TjlQks33/LFPFIP5iLYniu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="467969648"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="467969648"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4180997"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 13:46:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 13:46:38 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 13:46:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 13:46:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 13:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNkOuqrMUQ4elFMirIBvi7ZsP23vaNunGWcSFadCKSv0SeVAK6kllTjBB9vPrUnzSkTas4Mh6KyeZldPwO8FZyrMGVOxFD/cINExO2JZEGHRJ2BmwFonCbWhbnHFSYwN5KVopp2BnQOec03VdDjlOBa65sIlQ2fcSYtUOxP5Evb+ov9lwwGar1YxdGG0/vYzq/zgVPh7AQKFAywcdFdV0uqIwasrJ5BOmB7XpVI5cHpmq6+0DokkC+t7ngKXsS06RZlUlijnx8D8+tkkEeUB5xjSgEaFzqWyBMNeZpP26h0+sCaEwQfNN9ncW0qLvi5OSxfVquyJRWqqAMkcNNPYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlr8VKaiFaduKnxFvA19f2YS4lxwd1dHui+iMow9KSY=;
 b=JsU23m+ZzDgcyzd6ZdonFt+2tA4LCPSVDxRp9zEvaIVCMAnuAMRb9Qh2BmBld5hntq1lp/2H/9KBroWDDYr49cQvcnv/nm3mxRbdvfOJIT12NC24gXynwOo7Q2aOs+oz1hWm1T3ztU/sMHp8VTspXV9YtIuFqFA4YASCVePs+auWw//L7839gjqTfKn3ludyNF86HZBcCqXElH+K4IJTbLkJBw/H2BzQcTDjCI/apyeJI5643frBpS+yEJInc5VIWysoGGxxxiEAvvFQHBKuPo5VcI1nX9/pLAWQZDKX3t1FUb/6nyD5hTwlZ2xEy0ym+tiyCwh5r+kVdK/XWckQoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 21:46:28 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::c164:13f3:4e42:5c83%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 21:46:28 +0000
Message-ID: <8b8953e6-a19f-5cd7-2a90-bdfeaf270513@intel.com>
Date: Wed, 31 Jan 2024 13:46:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net v2] idpf: avoid compiler padding in virtchnl2_ptype
 struct
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	<willemb@google.com>, <David.Laight@ACULAB.COM>, kernel test robot
	<lkp@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Paul Menzel
	<pmenzel@molgen.mpg.de>, Simon Horman <horms@kernel.org>
References: <20240129184116.627648-1-anthony.l.nguyen@intel.com>
 <20240130183454.5c6f4bea@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240130183454.5c6f4bea@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:303:8c::22) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CO1PR11MB4834:EE_
X-MS-Office365-Filtering-Correlation-Id: a2272d05-3476-4ba8-5de5-08dc22a61449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDJggUfYIsD5HOsLpnxHExRw/rFlrnSX9wztu7Mlf8OUyxLqvpqCbwDM65RCyQTQtb7wiAp9ZBJvdfJtkSgJ/HAFi5tBipwGfyqp5CdJLSRQSZ8T8FexA/7DsAZQRsYQ1iKwIQXucv1UAHVM10M7fLwYV18p1H2KPL1cVtujQk++3Se/qnpg+23Uh8hCCxu+5WWnIz63H1TF7aV4qwRd6QmLSjvkvvjQ0FeE93Cs4XdQNaL3kCn32siKIhLZyp2MslBbq/P0PItpOf0JOQ7yYpblYSvZkziGXd6XbKr7I5F7d1wRt3+k99NGhRO36VdVc8VPSO3atNbTVRtCur716TcxlxFkZHhxEZjIcwlqQa3wUQAmPAxeg8j/tX8WaQTIaRL6feH4O2Myvm00olpj58JCBcKTG4OxLyL9MeKF17euPnnsrI92giNjVBOJ9GUXYOM7rWa/dIPlYBFsHCGGGELkZ47EPOV3yJAT5UULd8BFVYUOMri5Tvh9nu4iPATBoRiTj1NZaj2V3CDwo7jv19ErKnI2yE12Ipq9OhcjoZ/aClbbSKU/8CgYVJRH/UwENwTZ8jeAfRwFnPircBZZRPcmeejmCMVIW3iLd7gh9kRBjKjtEjD4nSygK2e2Ml8mDm4QVIonhf9+D0vLy7wTew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(478600001)(66946007)(8676002)(4326008)(2906002)(8936002)(5660300002)(4744005)(86362001)(31696002)(6916009)(66556008)(316002)(36756003)(54906003)(82960400001)(38100700002)(66476007)(53546011)(6512007)(6506007)(6666004)(6486002)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUYwdEMzK2g4Rm9ybHlrZTZKZFVhaXNhajhxNXQwNGFUOWlLZ0F0RGZ4bE1X?=
 =?utf-8?B?RFZGSjlENHI1NlZQL2VtaE82Tzd4S1RJSGtEMUdvSWR3S294VkJPQUxyenhQ?=
 =?utf-8?B?RXM0c0ZnYzVocGFDZGFhbW9mYkZJZ2R6YWJEWjJLd09ramFUMmR4N3Z1YW5F?=
 =?utf-8?B?KzB4eHVsL1Q0MUdGaDJiY0MvWS9hMFpxaVIvbEdvQWRUSjNibDdiYWdiU1FT?=
 =?utf-8?B?R2w5MGg3UDVKQmJYRUxTcHBwb2IvNzZVSUFEQXpNeFF2UWFTMko4dmVSS2JW?=
 =?utf-8?B?STBnOVVQOEhKZHVUM25ORVJOOGNsajFZWGo3YlVXNEZqV0pTN1ozc1RteGox?=
 =?utf-8?B?SktQZlQxc0xiL09SS1hhSXQzWkExUUNFOWNvdTJ3TFN1MVM5U2ZodXlLZ1ZR?=
 =?utf-8?B?b3pXSnZNYkpnc0w2NGFjVUczMzlpU3BHV1pSQ0FYL2RpSEZrcDhTd0RwVGtq?=
 =?utf-8?B?QWRWRzR1TGptQ2tIVzQ1bUdieUNabW1KTVBxUi84K1hLMVZ6WjBvYXczeG90?=
 =?utf-8?B?Q0Y2TllDZGJlTHJFa09XRUNKYXpaWDVsNDAwL3ZEK0FKelFPcnFlNGk5VnA1?=
 =?utf-8?B?MEtJaHptYkp3OHV4QzI5L1JPS29vanQzdTExRUZySG9kUkRLY25QeXhEL2dj?=
 =?utf-8?B?YXlhY2l6YjFmNk5TSHhaRHdNN053Wm53NGIzcTV4aEtUR1RFSWo3Rm9rcHVW?=
 =?utf-8?B?RlFSOUVLTFV4ZE9lVmNXL0VhZHBrczNjenA1MVZqb2RSblRSL1RVQVI4RVpU?=
 =?utf-8?B?Y1BGdGRKUGpzUVRHYnM1Z2tzbmRabHJoKzB2RGdtb0xmVmg0SXNXWmY3cFhh?=
 =?utf-8?B?aGVHdHN6eW1TNHpEY2NDODdXOHVuTjJYcWZkT3ErZlFDOVo3M0NEMXNDVFFQ?=
 =?utf-8?B?U0FOcXZNNkNzeWQ3enk4b3hMMVhHN0F2T2tUYWlnb3VWQjFjZEFQeXNzc3h4?=
 =?utf-8?B?VjV1WHMzVWtXbTd4MGZKa2NqY1Fucnl4ZzZ3RVcvUzdHc20zbmhMMzFQV0Vj?=
 =?utf-8?B?c1g4aXpBdXU0N0VPS3lLdUVvMkxBY2RJeTNZSGZKd2YyNkNaZ3F0OTBoRmtt?=
 =?utf-8?B?QjVUOXpkNjVDNzB0UFRSQ0xTd3VITFdTR3Q2WngvK0tFeUtmRW8weGtsK0cz?=
 =?utf-8?B?blgzcnpWbjdqWEVqYjFNbDQvejNsTWRTZWpFL1E2dXpJMkxPU0JRRkZ5SWVL?=
 =?utf-8?B?UzF2TzFKNlNIL25KKzFQaEZzUkRHVWE2NTl5NWxma2R1clB1UlViK2ZBZXh0?=
 =?utf-8?B?UlRVbGJpZER5YXY0eXFmMHpKUTM4dXhvbnFyVFBoaFhuQWdDS3VrbEswODBH?=
 =?utf-8?B?SVd4Qmw0NEVlRFJoQUNqcmw3d29Wa3VhdW5BeFViUERjT2lsRXp5dlVEOHdU?=
 =?utf-8?B?QzdMWTFJOHJWenA0d2FVWnJld0w1d0V0T09rclRMcmNLMTNsbWhoUTkwU1oy?=
 =?utf-8?B?TzRPQm0wMzRaamtPL1BrTTNqeStMSkx3RjBNUWg4U1pWczlPblUrTVE2YTNH?=
 =?utf-8?B?aGJnU1d2M0Z0ZGNBUTRKclFvS05YcXQwZHB6em01ZEhaekp5RWxrVXhEcXls?=
 =?utf-8?B?T1hBOWxRVThZaWlwSnN2ZGtjS09HUmtCRVJuQXRxMDlMWlc5UjJyZ2pHb1Zn?=
 =?utf-8?B?YS9IdVhPZ1Y4L255NUFveUxLKzFER0dwOWZNdi9TTWlxVVMvVktLWlJyaUxr?=
 =?utf-8?B?SzE2eHdhUW9UdDJ6bUFTRkY1Q3RuN1RGYVpJNHJxdEZjcHNxTzh1WWdjUXVJ?=
 =?utf-8?B?c05lWThpMjRSTDJOZnk5WTdZcUZRTE9QUjJEWURtNFJ2UUNSeUFKWnpadUY0?=
 =?utf-8?B?SVZua0hQTk0wL21qbzFQNWdCZTVNcS9KaUJOaHZBa3g4THBlRHp3Ni9oYkNS?=
 =?utf-8?B?SUJqV0lZZ09oMGNVT0FVQmx2UzRXZ1BveHNJb0E5TE5XcStYRWhGL0pKcktJ?=
 =?utf-8?B?N0N4ZHVHQzFya2RXbDc5SC9jbnExSlY5VWhVWFV0bGFlSU1ta21LazhPck44?=
 =?utf-8?B?b3N1cm4wcjE0MXFieGV0bUFqL3ZDWFlLNGtzS3VNOHNSM3d3akhLOEluSWx1?=
 =?utf-8?B?cTZGSmVoalRZS0ZtVFJYWGs0am5FM2x1VXNSZHRkV1IydHJVUzE4KzRwVURu?=
 =?utf-8?B?NHBYN2gweThHeWJrTEV3eDI3elZnZVo3VlFrdm0rOEU3S0pJRVIwTVJlODZO?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2272d05-3476-4ba8-5de5-08dc22a61449
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:46:28.2274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnWaZa9OArfkGDXIKHQ8du4/Bzn3K8OuD2mgF0iIjYqRJ7mCQCwDjNaLw/9On34tZg7UtrrltaSKih+L/ELbzOY2jCq27NU+wbjVg1Bh9Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com

On 1/30/2024 6:34 PM, Jakub Kicinski wrote:
> On Mon, 29 Jan 2024 10:41:14 -0800 Tony Nguyen wrote:
>> While at it, swap the static_assert conditional statement
>> variables.
> 
> Sorry but there should be no "while at it"s in a fix.
> There's hardly any relation between the two changes.

Will split these out and send the swap via net-next.

Thanks,
Tony

