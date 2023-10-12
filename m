Return-Path: <netdev+bounces-40211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C57C61E4
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00FE1C209CC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E363D;
	Thu, 12 Oct 2023 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hrc/ZGs6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9A62A
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:40:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FF990
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697071212; x=1728607212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iX/x5X1DNoLAh5s8jyXjfRsg38m39ThLtfWjvH50kXA=;
  b=Hrc/ZGs6t7A1ltd82s+jUXJGdNxFE71Dws1bt/NI7ztHkPxw8tMRS+Dk
   gVcnsS8Qb4V2PzeX+lj2tIHxUncebXbJGW74Jis+cMUJhoOud/XXwNKr7
   YuCjkfwcUCv7dGn8jJxJGDpryqFuiw3mVFL4q3QsqhdBHbIUuNcdJPmo0
   U+RHKuMw9zOWyvV9YoH0nQGgYnoPFwaWUgXBZfO3Yodu0tk+nd6VaIZcC
   AzIqn3eUOed7v9tcJHSORcrKoJG6wuQ9sdiECrj8ld/wghd2s21cBETCf
   ocuI3gaA0KXQiskXTyaj6T531GbYKMDYHZLpYKMAY3xrq797BiFYdBRYj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369872176"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="369872176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730698947"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="730698947"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 17:40:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 17:40:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 17:40:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 17:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxbUwSmVvzvBMnHgVPG4MKqygi3kWWLS0jIyHHWE7a4Dz80DqSPIjMIyyhqP1bpi3mlsl14bYA41iURnOpG7K72GnR+Q3VpUf/AyTDFJttK305RNNQ1OuUiFkaUjJochW7KJPpeWQu66dzkcyYApUbmvLyNLrS+cQdEvO0kbAhYb98REi29S3K2AQoHg3t8rIcLegmFX2MVnmaplC93AwNLfFkqGWNfsulfBzTzWq/W2VnTf/ph17aIR7LWm3lSnboi84jIiWsGX0keVnotyt7udYPliZoLOhxjjRdC7OdZ/9PpGUDfc1PZVFrcuVMCV32lBc52viMFPCGrz1ZLRFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mykNC6nPHAiMdIwOoPn550CJQRVR3C1oYeiDijEI4Do=;
 b=E7HVjysoG+lpbw2Ky9n0BJ65vTdhVzkQyR3nbrdv7Ktx62SMwRlq1O/PJnZJ99bmZo4HINOCJHGAxlgDDCZGNE8oeAYSFLzpMcfljZHVKjPewZZF5mZAP7teDFQYO/bD73J4gjvo+icwUvN8vf9T+11LCAfyLYku0Y3izH9e++4EnfABT36bAlu2FOcpWkXVhrtLxCrA/JTJIcu/PX/iP0gUhcjLfRqW2mAj85RKKYiRHlUTwHk+jMGIxdfWvIe3IsoP0ZWTlAPmsZft2P+hM50VXG7ko/jUxxHuU8H9Ox1a6sgTLgm387arZJO8ByRNBm2ynqe4sGGZ7hHYIBL3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 00:40:08 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::f6a3:b59a:1d7a:2937]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::f6a3:b59a:1d7a:2937%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 00:40:06 +0000
Message-ID: <a810ade6-b847-28fa-6225-5f551a561940@intel.com>
Date: Wed, 11 Oct 2023 17:40:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
	<horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
 <20231005170110.3221306-3-anthony.l.nguyen@intel.com>
 <20231006170206.297687e2@kernel.org>
 <835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
 <20231010190110.4181ce87@kernel.org>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231010190110.4181ce87@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH8PR11MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf9f866-3f8c-4d78-d656-08dbcabbc7e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FARPJ4rKYCFdA+lwTHUBxR/6i1Bnkj9Y+L0hUs5wYARYF6xmmR8TGO6F+o/15ZiOh9BndfrMrmeIAoDlZj2jyEYnNYS+YyCJi8B80lKBJV9H7wiOByIakC80VtKP5s14buUnbzG1Wh08IdW6JRNqsH3OF76Tlm1dYMwHqQnbXHY8tUi76N4yAYabVDPwsjjVhOyX3E6RrihO3d2uX0zyo6ArQE0J1k4TT7jZmM7eBo1hrKShWym3RwPFryJ6oRTrE+A25v4s/GI62Kqtujf75YTxoumDi/Fn/Nr+Yrle1SJgL2dCIoumrSlJ70uKKt3ZXPdstu1fqv//Gpb1IcCEAxrp3vQ2fq1cqIg7kYVN5VlYJMXI2fvDhh0g7BvSMQHXaE9NKAYCXFQZ0JYxxlFRNMbaxq1vlqPF+yOMo14oXK9eZmBYqqA7jK0bijYIuSmCFs1+AyLnDkhUvb+MjdhZwBvUS0/3XeAzCob7yeIShPC5tg1Y8LuavxUOtEMDgMOIibFXyd8/tz5P9yW7CkjAYyh7bANTflzBjPZ+pWLVvClROfIJWFiOEnwPgvKzyJ0mnDlUCBVqciwRjhXc0zKyEGSGO02zxbo/zGU6gSH9OhzPAHXVuDNKWz3bJGSjGJLjrua3Y+0xAvrQ9CInLiQdxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(107886003)(6512007)(53546011)(6486002)(478600001)(82960400001)(2616005)(66556008)(8936002)(2906002)(5660300002)(54906003)(316002)(66946007)(66476007)(8676002)(6916009)(4326008)(41300700001)(31696002)(26005)(6506007)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkhDakZkSDBrcTIxdC9uK1NVVUREL2c1alIxMUh0Y3k3WUhXVG0zNy95U0pl?=
 =?utf-8?B?NWxURUMwd1QrRWtSMEtSQjJtcW1za0U5ak9UWHJLamVTT2pvckxjMExMQmdC?=
 =?utf-8?B?N2NkV0RnWTgzeHVPcnhFQzN4MVB6SmpNdVJKS0kwcmducW1GZ0lmT2VhQTRa?=
 =?utf-8?B?TlVST1pYQm5Nb2FBREhxTTFWbnEwTXkwdEp0bVVDV3dVNnd5NUsvR0FsUExP?=
 =?utf-8?B?ZCttRkVhSE82UlhEV3dMYVNhMlZpMXhER0l4bkJYRVBHTjNsYS92Z0syL1du?=
 =?utf-8?B?VS9YVXdCNjc5R2NsVGxwbFdGQWpQWjVmOUV1MHBDVWVkQnJVRXdwSndnVVls?=
 =?utf-8?B?YVdXVHhwY2ljTzhCR1o0bGV0N3ZkcUNQYXB2WXMwVnhaNzJJYTNpYkk0V3ZP?=
 =?utf-8?B?Rk5sVE00bUt1NENucUpvckdObmF0TDRVQVNienM1aTYwV3ZQNFhIMHc1OWpZ?=
 =?utf-8?B?WndLSjZna0dkS2tMYk03WGNNcnBTdUg2ZTRFeUtHd3FWVFpmVk94bDZyTld2?=
 =?utf-8?B?TDRDaWlsVEZROHVEZ1dxT1JEaGM3ckRxT1MrZ1IyZGlGT0tSQVBxWFVTeGRG?=
 =?utf-8?B?TzVkRFBhbUNnNGRmVkJPOTFmbi9FWmRuSkNPVkpvb2h4czlkQkd3cXhmZU4y?=
 =?utf-8?B?RTR6STBTSlQwQ2xmelp0WnduM0tBUS80RGE4WWZ4L2NOTmhlYk9aNHByTzBH?=
 =?utf-8?B?Y0tpdXN3c3R1bmxMaGNhYzYrTlRjUFdXdHMzLzVJRFhpQ2xoRnNFM2haSTZl?=
 =?utf-8?B?cjRrV0VOTEJCejRUUm1vM1BUaUZDZUpQcTBhdG84KzczcnhFQnk1ZGZpQVk5?=
 =?utf-8?B?aTRYdWNQbHhWUDlYQUZYSkJxbllpQUl0b3Zlbm1xcWpyaTdOalpSelhib1JO?=
 =?utf-8?B?a0lIeUxkZTl2Q3lmdGhnMzZXVUNrelhwaSswczRZalRjKzlRQVBhS3BQdisv?=
 =?utf-8?B?UFY3bjd4K3FPMHZWdmpIaXdvUENWbHk1QTlTY25PeVpEc0JTZ2FaeUI0QTZm?=
 =?utf-8?B?VFI5WEcrSEYvSWFYWVpUVG5xTG03bjY3a1lHT29SUW51NEtmM0IvMnBXQlJk?=
 =?utf-8?B?c2U4QzhWUkRZSVpkV3hCQWJsUXBGY1NGaWpxZXUyTFh4ODlqeU1Uc1phbHVD?=
 =?utf-8?B?N0VNWUREWUZWK2loUjlHc3lTN2FlczVFL0hTRElQZE92WXVob0hLbUpydnhZ?=
 =?utf-8?B?S1Buc2syQjArQXd4UmplUlRXQmdEVk03bU5zTzJuOENRZytNcUxiRnVBUXRW?=
 =?utf-8?B?WEJFVFdFeXV0aWpvb0krTVVzQUx2dWxWUXNkUTNMRE51NWtSdEJ2aVNVV0pX?=
 =?utf-8?B?a2s2dFo1N3lXZ0J0N3dmMWdPUnl2Kzgzamh5aWVvSXNjK0x0SlM2ekkwQVUw?=
 =?utf-8?B?WUJNbGJvTGU5cUtHS2NhbFIwWFBtbG04TXVTanNJZnFxTmY0UGNZSU51QVor?=
 =?utf-8?B?dUYvUnhLb0lWTTFteHVhajlVN3F5bTZyT3ZPUGs1THhsdlkxSFJITGQ4cjhU?=
 =?utf-8?B?L2NZVUpGNXp3UXV6R3JzazFYYkdnbThJa3IzM3dmcGZxZzlIQXlwUVo1TDZC?=
 =?utf-8?B?Vkl6VVlLSkRrajdqb0U0WWFFOENtOUU2a1MyTVo0SXpXamFjVFIyVndzQlR0?=
 =?utf-8?B?Yi91TG5XbjNvQUNuTmI3OW84bEo5VVZGOE8xV0pMaHpKWENMdGdPK2xqd0pi?=
 =?utf-8?B?RjJEMTFnTmZDeWdNaVlTeFh5VkFkTFBscGlVdFA5ZE9xcnQ0VmsxaUc3THda?=
 =?utf-8?B?bkNQNy9KVS9JQkM3VDlzaS84VmU3TGp3amlVRE5iaUhPOVNjTDRoS2RFUlhW?=
 =?utf-8?B?N28rRDNCd3h6ODRWckdBSk9HTW9RNkxEeEh2K0xKZmdMQlZydjBFYndZY0Qx?=
 =?utf-8?B?QjhnbHBMa240aG1mK28rQXhKdjJaZ0tMQk80YUs5cTNabFBKQzc3aVcySlEv?=
 =?utf-8?B?cG8wRWcxYjNPWnZMK3dHZ0FIUUt1aDNQeTBYbGRubkpjY2phME5LaGhSNXJE?=
 =?utf-8?B?aG9iM2xTSEVqVmNzV0dxWXhYRUxoa1BsVzhJWGNDMTdSbDV0a3BPZGF3aEtl?=
 =?utf-8?B?VW9iZDZlcmR5em16Nnc0RVhHYWdoOUcrUlFZbERzbkRmcC8vdThjYmpaTTRk?=
 =?utf-8?B?ZzhjeTVOZXpJYS9sWW9TNDg0andIUm1CU3VDSFduV1ozdGNGYjd4dUo1M3Ew?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf9f866-3f8c-4d78-d656-08dbcabbc7e5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 00:40:06.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XLXaWmotQP1dL0VX56zg7HpUK4AnvESZ3FiTb0V+QEr4Bb7SyakZvc2wF1vqmXLc7eX3UMqN+fg0t9Aslt6DVF6ekinjmPta+J3Boz5mB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 7:01 PM, Jakub Kicinski wrote:
> On Tue, 10 Oct 2023 16:26:15 -0700 Paul M Stillwell Jr wrote:
>> I'm probably missing something here, but I don't know if this will do
>> what I need or not. What I have is a user passing a module name and a
>> log level and I'm trying to match those strings and create integer
>> values from them so I can configure the FW log for that module. I'm not
>> seeing how the above gets me there...
>>
>> I was trying to not use strncmp and instead use the built in kernel
>> string matching functions so that's how I ended up with the code I have
> 
> You're supposed to do very simple and targeted matching here.
> The cmdline parsing makes the code harder to follow.

OK, so what if we changed the code to create a new debugfs file entry 
for each module and used the dentry for ther file to know what file is 
being written to. Then we would only need to parse the log level. Would 
that be acceptable?

My confusion is around what makes the cmdline parsing harder to follow. 
Obviously for me it's easy :) so I am trying to understand your point of 
view.

