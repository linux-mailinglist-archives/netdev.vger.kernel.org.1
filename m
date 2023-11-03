Return-Path: <netdev+bounces-45980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0A7E0A85
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A552FB2154E
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 20:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D6F22EFF;
	Fri,  3 Nov 2023 20:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMYqZt6l"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353722EFE
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 20:52:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F1D5A
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699044762; x=1730580762;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IunoGXZUG5KPprR2+IC8h6+OvjaU3vKJ3hRadx1hLDY=;
  b=OMYqZt6ljgCFMDJmgUWRygsqhNdnxoOBCpk+Cg+t1efofRQJWyVXmIku
   JxuuReNuHEa5F0bjX32GzSmEOb5uWAF5wpBcXf2f2Gw87Tl+HYK0SiZPw
   lvXNw51yvh9dOgBz8iGmy91Vy36REKrMPfaEeoCsaz8mD9BP5ltWdro9A
   l56RY1znBC3ZRjC3V4mGEJ/kygN5g38YA3TcchVqFmoaMKJnEh3HJKqZF
   3nxtzZNniT4YQuZ/ecKRgCMfwvSp4SsvwMtO3FNASLDdDm9TZP3eq5JWL
   qnQ0aGtcrzeduN1FcSErDxlAJV3eZLIMYfrUhygebt28/OiHzkLyqrVf7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="374054408"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="374054408"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 13:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="738194092"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="738194092"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 13:52:38 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 13:52:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 13:52:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 13:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyib4aXHmAE9sNCMdLEMmrYTw0ZvM2qpWPSlQbrFzQ9uko9u+Foxvul06Re/xd/jxIWgLFRumFHxFmoG22Mlg3zkIIxa+jLdFbg39UU5571VT5QIviKR3g1wpBNQRwZDJW5vLzZyMWIjmv2EEwY7lA16sDpBRI/F35OSkkyth10wAhLNABjN9Lb6aEEh4tO4tl2LHw6Qzhdx1ouhMTloisIoXRx5A63eBbPQ045OxH4GbWnULTFFGRbnt6pBsEi2fXFes8N0g8IqtYhrCakkt56x0Bx6ldEniyIzpVM2q4PnvYLEFJyd3rHVEATqiUtWdAARpEgAAyQRsZBoC61Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6/VGdOE7cYC7zmxS801lpmoGVRhvxwQHh+xVCyrKD8=;
 b=EFOp9xyEg6jiw58epk0mKFDZIixP6KP/cmY+stEpnX9si6nFajFV/Yrqz6KCYyMgXhODG12vFF2ZUwf54GeBIrbdC69E5orcvSowy/C3Vxr1Rx/ZPlepv3j57szKzDdcgYkHKqd1p0Co9y1LfwLzaZm/fTSILyvoBTJQheY1sM/kV/JWMIv7D4O/jPufVu6K1IZFoPnhKRda4W2Ty2mm4F2wavZiRjFeWISYD9daw11ekiBcTcrBYQ/5dyy34w3h18bKBi4sxheuyMKHN08UaVwRGLgYWRY8Dp6GEA251/T6jQ1V2BQYckcifbwXRaufGECSsX7ArqHxw6MYn5LjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7642.namprd11.prod.outlook.com (2603:10b6:510:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 20:52:35 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.6954.024; Fri, 3 Nov 2023
 20:52:35 +0000
Message-ID: <ee6eb20a-fd68-46dc-8985-fc0531cd2eb0@intel.com>
Date: Fri, 3 Nov 2023 13:52:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] ice: Add support for E830 DDP package
 segment
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Dan Nowlin <dan.nowlin@intel.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Paul Greenwalt
	<paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>, Tony Brelinski
	<tony.brelinski@intel.com>
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
 <20231025214157.1222758-5-jacob.e.keller@intel.com> <ZUT50a94kk2pMGKb@boxer>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZUT50a94kk2pMGKb@boxer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 44840f6f-4e37-4f3d-e3e7-08dbdcaece99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E6PgDqn9fjF6oGPDCiprOmlNpLzwcJ6NXGwpWfSSwKLX0jS/XIYTgnjx1wGdHF1Wi1+Hcn6FQmLTAWG8YD74LNw0kKnfil6bA5fHhwUSUjr/ZrzqK730QfgESh5jEOHWE5fgCA+92kTlQWo3FhtK/gajl9ncAMITMjbirffRzs3F+PaxDpVSkNy1BCMILh1UZkTJL3MFbI3ORYuZe66oS9QPyCtoB3Db+iFtSWkB0qEFDyhhRVzAEpWDPAfOacatk6FiMnI7UBv5Wb5izQb62t71yE2kE7zcC6/glPRSi1trLKIyY+sYIvEanZd4CN4es3QxWzeSsU/z9dsIa1AEF5GxOeZqe9GpZGoNNIApDggUQz0OQT1jx3c37KB1wWsnwdHuaqJwtTG4z0w2EJmYsdA9sNb6IxJKKy5FseewL8uhxJZsSnYRg+g9YNeZvMz/k4+COAzgIceG4rYKJcPFPJBEA/00uf9e1vkQcZGB/NTOSRAcesliNA6RlpGAjWioA/TE+Goo5rHpkKYuSuCiHxZ8nIzDPIM9Hnkrk/G5y48hSTQ7Lz328aEXYXRPDCdizYi05xhl8eOEqCti2KR47xnmDcxLaPa2ycWOWYh/mkUlLiQAILmoeX+aJ3h0xCBjdZonQhgix95/WnOcIKkFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(107886003)(2616005)(26005)(6862004)(8936002)(8676002)(41300700001)(4744005)(31696002)(5660300002)(86362001)(82960400001)(6486002)(4326008)(6666004)(54906003)(316002)(66476007)(36756003)(66946007)(6636002)(6506007)(66556008)(478600001)(37006003)(6512007)(53546011)(31686004)(38100700002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJHOVlBVXZlQXdvcXYvYm9ENlYrclRIVVpWa0hsc1JlMkdONUNjQU05TCs2?=
 =?utf-8?B?TTFORTBLVHhQZXRLSmNmdjRTRTF2QzhtNnBCbmdpVi9ZUzJGcnBRN0FmbW1B?=
 =?utf-8?B?TTRSek5vMkR4cWs5L1dieE1BYzZWdnFkTE1nQjVxcUdUcU0vZi9md2h3QXFq?=
 =?utf-8?B?YThlaHo4eVZwN3lRVlJLN084Wng4UEN1UUVMd0dGN1BnUVh0NkdBZFpzR0Zo?=
 =?utf-8?B?QXBrdXBkTGp6aks2dWg5dVZjQTFENTlyNDZ6NEZQQUNSZ3lLSnNzU1o5aTBW?=
 =?utf-8?B?dzU3MHUremk4WHprRjNMU0VIZ2Y0MWxLdUw4YVRHcENWU2dWMVZBOTExR041?=
 =?utf-8?B?OHd2QWxoTkNpK2U5TVF2YitWenBoc1J6SmFJM3IybkJsL1JZaTBEbU83ajZM?=
 =?utf-8?B?dW9YUTN1azlsVXJFTDFSUnJUTmFjYzhDK1V5cm9aNkxFclZacVJqYk9uQ0d4?=
 =?utf-8?B?UWc1N2JIclZROWo1OHV0UXVmK2NSejhRZnIvNVlKY25GUTN6cmNDd3doNDRv?=
 =?utf-8?B?RG8yY0lGNi9yWEgyVjRjelhjcTlkUjhoMmZkNWNKdzNXN0Ezd2p6dEZEbEtW?=
 =?utf-8?B?YlBUUWk3aTlDc0IzWGoyTytBM0V3SWFkUHg3bVpUdy9CM0RYaXMzY1kveHlG?=
 =?utf-8?B?RmxRZEhuZkZaUmFXTzROdU1KTFVHeWJYblJ1bDJpSTViMEl6ckZQb1AwSC9a?=
 =?utf-8?B?Vnh1WDlyS0cwOHE1MkJETWdLMXRFS0N5QVhBK2FHQitCNXR0UXlvTVRXWUR6?=
 =?utf-8?B?dGdOYkhDMnkyK0kxaU05Q3IrTFExSkR2VTl6WTFTeDlPSGFYMUhWdHphYkNV?=
 =?utf-8?B?NWhlV3lwUldOZXMxb2laaXY5ZzVSaFJUTHJEQTRZdlFiZXZsVVhZQjQ3RllV?=
 =?utf-8?B?SnN1MmsrWW9MUm9VQkxSOTM1QWNaOVovNUtLbWRRZ0NjUnpMQld6QkplYWdK?=
 =?utf-8?B?RlFFTnFDYlpWWnFiV0tFSzFHMVQzdnVCT3NnN3dBMlcyVmVOdEt5by8rVGxm?=
 =?utf-8?B?bXpMdzVDNVRtdFBGb0dXRUhQMEhibEJxQStXdGc0RVFWaXBpd3FCUXRKblpH?=
 =?utf-8?B?dVQxcGlyek41QlZ6NHdtSlk2NjFuQkNLTW0yY2VxNDNoTGlqTFg1c20zOWlU?=
 =?utf-8?B?YmxWKzg3RnRGamFwcVVuR0YyOVVkWkpNci9iTzF0RVljeGVPTklYZVpIYzV0?=
 =?utf-8?B?dEtXeTVXYWc0MGF1Y29pdFlsQlA3MDg2a2NSaWJsL0c1dzlETU1zNHhVUXdM?=
 =?utf-8?B?RndpdVBsVk1sN09OS1JIclNFK3FxZ05KeGRqcEIvVStiS2FoOWgyRng1Q0V6?=
 =?utf-8?B?SDZNNzlQMm00dzlFbDVGdlQwbHhHelRJSlJJZGE4ZnBVRjVoK2Yzcy8xZkdq?=
 =?utf-8?B?ZUZDUnVLWExkbmttYzMrSkFNOVNEWGV2RThtQzlsUDJVTSt1MnZUK29VenlG?=
 =?utf-8?B?M0x1enRhTXlvbXJOVUEzUWdhVnYwZG9wZFlZcXQ3dXpEdnNyVzZ0NjlMRkxm?=
 =?utf-8?B?Q28yY3hOSUZVMmYvU21jRGhQamN2REc3Z3ZmZHBmZmFPbVB2OUpSMXlFblNS?=
 =?utf-8?B?bFJ2TldrM2dsZkMzNjJpbkQyVGtoQ2lGalNUK2ZJOUJwR1l1WjZ5TkdGRENp?=
 =?utf-8?B?N3lPSHV3ZVRRc2FqN1NMZ2R3Y3RnSG5XM3JCZEVJSDI0aHBlOVNiUEtRNnRy?=
 =?utf-8?B?OFVFeFp5Wm1tSFhxL2J4N3FkejFDY3hSdC9XU05vMVFpWmQ5VXhiSHF2cjNC?=
 =?utf-8?B?LzJITzBGL0ZHS3o2TlRZV01wOWtqWjZKazR3Um90MXY2Y2hKaTA3ejV0TzF2?=
 =?utf-8?B?QjMyKzlZdVo1d3JMR2prWTdEV3l1bk9zZjNhZmRzVXZmeU85aFFyUmJPUzlU?=
 =?utf-8?B?Mzd4Q3lUUnFKTW9IOXpTNHZHOEtOeWJ2b3lTT1J4bzE3WU9xck1MUDd0S3dq?=
 =?utf-8?B?a2FpOXpKOG5SLytlOFBxVytxTklTRHc3MDMwLzYxWlg1MjNLbk9xZjlvQ3d2?=
 =?utf-8?B?QzZCd25lMjhLaG5CNUJmVko4dWxieVQydTA5SGVrUzFiRXY5SHo3V1NDZSt0?=
 =?utf-8?B?Q0tEVWtIZUtucHd5ajRHTk8xOGVrcTBuNXU2N0VnaU5VbzFESk43L1FLelh3?=
 =?utf-8?B?QVNMMkE4eFBuVERDZVFwNCthOHFqZXMwT2Q2UzF5NjhPMlFNaUR3U2oxbHc0?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44840f6f-4e37-4f3d-e3e7-08dbdcaece99
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 20:52:35.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eU5aOSlSqeOfj5j5pzvkzHEYZj6/ophw/cvEyYoi0uZ0kGikUqLHZVX0aT2QDx/mZ7ls6E3Q6ZRmag+dGRmxTbvrOdibDp9ijPsvssm25bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7642
X-OriginatorOrg: intel.com



On 11/3/2023 6:46 AM, Maciej Fijalkowski wrote:
> On Wed, Oct 25, 2023 at 02:41:55PM -0700, Jacob Keller wrote:
>> From: Dan Nowlin <dan.nowlin@intel.com>
>>
>> Add support for E830 DDP package segment. For the E830 package,
>> signature buffers will not be included inline in the configuration
>> buffers. Instead, the signature buffers will be located in a
>> signature segment.
> 
> This breaks E810 usage, they go into safe mode. I'll be sending a revert
> to this commit or if you have any other idea how to address that I'm all
> ears.
> 

Do we have any idea why it breaks? A fix might be preferable to a full
revert if its simple.

Thanks,
Jake

