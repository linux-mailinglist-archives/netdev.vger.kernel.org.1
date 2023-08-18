Return-Path: <netdev+bounces-28906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C09D781211
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD98F1C20CD0
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 17:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEE919BA1;
	Fri, 18 Aug 2023 17:37:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4194430
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 17:37:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8986421D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 10:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692380221; x=1723916221;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iVQk8SYQzczluMt6zr0BJId1ZjPULawGCjCSh5a5cPw=;
  b=P0nChQoVB1Ph7sxBRJJtS38vRGC9PBct4byjvmWDyUoHScpGThLWbneg
   K3HRa9SvneqWXBGCNoA23h35LhIwrxJgZVjTFKZh+2QcApdlM+1eqOb5U
   RD48blcxncTVDOE857lgkxog1NYWJu8itKnHIY1E7W3BYa85FGGclNuEt
   s4FsczMXOZJXTBd+/sWCxMOxDwBMfSfTNC7hWQqfhdhmjiaHSIzZq4phE
   sy8wtdUAoMQOS/YeJ3ONXp18WnIC3KVcjJt7ELi5n4uep9cvkg0ZMHSu7
   uAJlj3VVS6Ns7Kbd1DC0CLsQUB+aC1a2xwEGr3sjOhdr9Jpa8FdhSTbWk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373136600"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="373136600"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 10:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="728682907"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728682907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 10:36:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 10:36:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 10:36:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 10:36:56 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 10:36:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbTg3k6+DNOlj9b4Uo+kXSswsRZV+BL7+vgSAr3uPeHJX4CA/K9nroy6cq9pXgX2ZLrvatIIoCP9HRMBkgxoakkIKLlnuyDt0z0n+P4VEts/t/IUqvqJ35BWdqXZjyivOVzn0EU0bAsncfgkeFbVf+tzaYbrnsdd6vpdi3uAtqSop6UzGq/GB117Z/FQRXxF5SX3ANCCGBvzcDP/mI91wZHUSHZ/GnceoxAxiILgR28GII9iUySzycuE/kZMXv1vVRWab9nCkPQYz8QPDx3mnxT+G8BhbQkfmsQPD/X14YX+Rd96Z6uxyla8bZFW+tYORDaaUp9q5qA3WDgIhi4VBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JhPIDMTdf15xTt5qhto4PkrP9iPpqsMdOMZjY9qXNc=;
 b=DJLHoFSkESl7/tb06Nj1wsLLA9cA48cst5HLLVYPCWQB1dWUSMXzw8AaH0IneDrNbi56PbKx80FFmU3S208UOpInCni2sTjiKND9Kj8PwqudcFac9fjncLi1YpU1zN72+lcexARVz+jDqMKvYPRIoQGEu3r14RW9oc9WD8FwV76pWpJ/Sf75rukRq2wJIND9rfu/Azvxzv4rE1tfTCfarX65NitRelqxn1A+phVNgat/rDI7rvN3TmShO5OloozI56UzKx8qaAelMJFu6/OHjFuwTYG4eMHm+bDuOtIlL/dj2i4TnfxoF+pOgrj72SuFLlEjo6p6tT54RsdKTnX5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2599.namprd11.prod.outlook.com (2603:10b6:a02:c6::20)
 by SN7PR11MB6850.namprd11.prod.outlook.com (2603:10b6:806:2a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 17:36:53 +0000
Received: from BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f]) by BYAPR11MB2599.namprd11.prod.outlook.com
 ([fe80::7167:18b4:ee0:8f0f%6]) with mapi id 15.20.6678.025; Fri, 18 Aug 2023
 17:36:52 +0000
Message-ID: <566d4192-d486-bfc2-59ef-e9f87f290c4b@intel.com>
Date: Fri, 18 Aug 2023 10:36:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v5 08/15] idpf: configure resources for RX queues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Alan Brady <alan.brady@intel.com>,
	<emil.s.tantilov@intel.com>, <jesse.brandeburg@intel.com>,
	<sridhar.samudrala@intel.com>, <shiraz.saleem@intel.com>,
	<sindhu.devale@intel.com>, <willemb@google.com>, <decot@google.com>,
	<andrew@lunn.ch>, <leon@kernel.org>, <mst@redhat.com>,
	<simon.horman@corigine.com>, <shannon.nelson@amd.com>,
	<stephen@networkplumber.org>, Alice Michael <alice.michael@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, Phani
 Burra <phani.r.burra@intel.com>
References: <20230816004305.216136-1-anthony.l.nguyen@intel.com>
 <20230816004305.216136-9-anthony.l.nguyen@intel.com>
 <20230817195815.4bf4f2b4@kernel.org>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <20230817195815.4bf4f2b4@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::20) To BYAPR11MB2599.namprd11.prod.outlook.com
 (2603:10b6:a02:c6::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2599:EE_|SN7PR11MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: a83f1f8b-03d9-4ca3-d19d-08dba011b5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEsohobPAX4l1se14zxzO3spMKzxOuxHPP0l6Ws5hW9s284+/qgUyznNLi5SJnYbM2UBt7Bka1kTecCApT+z/ZPcbZnFFGUpG1fza9mlNgHiRIs23Ve0IZVpf/U3F6oCBoNwawFuIa9p8z8UB9nl84TH+/oKk99yscmcDi9O9/G9NPv6Vtlfr+TK8LHRtpDoU0JUrAEFZUAiTQ794g5DEOHpkqsNBbMneHLbboprJI7cvyHE5I6Ec3cnmWKExSYLe5bzYeeCtObUj9h7wySkbzggbstyKT5lE8d6H9tWD6gBnEFmd4U5ig/QqrjD9lfdjAPgnct8c+ZG/PZPf/Mzt0cXyXmlYVHk2IvnNxXVVAZoCOcoQOHU6jrD2npkG8BBySShRhUGjMhCE0DX8NXllS4CxoKgHTFW1iW9+nSrNGhs38R9fLhSnEJ2XVOC0rIJ/QJLZttMuxp/xavFq9MJWOsRLNrOI5PYsbfs1O/DFJsfyGyGgYmUrs+yO7OhRzTaT+xC8jXu9LM+FlFkRlQMhofq24XityxuIUAd/ILykpIkCvdAvZ/k6eLl0sQkxqhQfBhZi+QbEeOzUzQs8M3rDl2KC3CjkwQSli4gUVE0GANcrZ3MBXQiSXYZLHoRP/fXu/3MxF/w+CXHiA6Sh314Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(1800799009)(451199024)(186009)(5660300002)(66476007)(38100700002)(316002)(6636002)(54906003)(82960400001)(66556008)(966005)(478600001)(110136005)(7416002)(2906002)(4744005)(41300700001)(8936002)(8676002)(4326008)(53546011)(2616005)(6512007)(6506007)(6666004)(26005)(6486002)(107886003)(66946007)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFZLUkZqUHBKYkluMTBuS3YwNVZFZzA3Yk91ODM0ZEZZWS95TlBMc3B5L2ox?=
 =?utf-8?B?VGJJM3AyQ0FaRE1pbU5qMG9HWmlPQVJJK0ZSbUJMa2cwQXBBYlNkbUlzRkVv?=
 =?utf-8?B?dTNTZFF6MFpHeUJkRjZ0eVdidGhUR3gxOXZyNHZxc0lXNzh3THRuVnY4WTUx?=
 =?utf-8?B?Tm5saG9kYVRwTUJGa3lUM29NKzdnRFV0SFVSM1VqM1IxUDNYbE1SdlRDVkhG?=
 =?utf-8?B?d2VMY2lZK3VRM3BtUmsxclhTZ1RHNUoyY1hiU01Yd1FmU3V1Yk83RVBzN3Bl?=
 =?utf-8?B?NkFxdWtEUGdCblJkT2NOaHIvZ2NMZWQwZGRZNjNGZTRvMW9jMWZtTWtjS2ZH?=
 =?utf-8?B?WnZ3eHROSGtWbUpjVW5CTGdXc2JqL2RYVENSa1RYZzJYWXFKUVN3eXVRc2Rs?=
 =?utf-8?B?ZlJ1OGVkMU1WSS9KVjRPekg3cW13d0F3ejM2TmVFc1Z6UlFyUnZnaklZQXRa?=
 =?utf-8?B?NnhacTAxRlFFRDBoRDIrdGh1ajVNODZPSzVscitnRXlLeWptSlVDWU5aRXhr?=
 =?utf-8?B?c01pQm9IdVVOVzlMSmt6UHpmNzJpTVNKa3FCcDZnQzBUUWJBQXo5dVpIclRa?=
 =?utf-8?B?cTAyZWZBV3hqUEtTNGxCaFlEQ296RVN0TTFtRWNkSVNBUHVBT0o2UzZVaHBr?=
 =?utf-8?B?S0xDemszWE5hR3owWWFRUVplWGtmckMwaW8xSHkwQjhwMXVJQ25vNGF4M0Fm?=
 =?utf-8?B?TXVZOTdCWUtubnZSL1dyZUlRSkhkS2JJbEhSajdsV0ozb0tIU0JUam8rcktP?=
 =?utf-8?B?b1A5aHhJOW45MWdQSmtSRCtZNnVzc2JFcTdmcDVWRWZwNVNHcG9QcDJHYmx1?=
 =?utf-8?B?Smx0ZlJiSHdZU3VXUmRhNFE1NERMQVpuYTdGSEkwakRkdW9LcE1sWHBsc1Q3?=
 =?utf-8?B?UENRZDBDMy94OW1zV1JTWlMyeTFodUFuYXA5NmVrWWNWa1RjYXhxeTBUWUQ0?=
 =?utf-8?B?SHk4dTVoaHd1N2t3LzhrVnR0TVBDT2pUQjJPejlZQ09jWDQrUDh3aEFoUE9N?=
 =?utf-8?B?eUZuN3paSVEzdW9WZnVGekQ1QkdXOXA1eFY3UmhvMVpYaXczRkw0dzNpUmZ6?=
 =?utf-8?B?VldobXBCYjA3YzJTZUlIR1pYcERlMVNZVnl6ZUdWZUl4RS9ESEVrSThQQUQ4?=
 =?utf-8?B?U2x2d3NYM1l5eFc2eHIzWVlRZGhqT0g0WGdUNVVGbjd3VDFVYkhJbnlXQ3Na?=
 =?utf-8?B?WFlGY2s2K1VIaG1VRENxU09EU3E3ZGo0am1LQU01OHNJYUp2dDM1Y1JzYlF6?=
 =?utf-8?B?V21aT0pGSUlnU2NPWSs0N2dBVWMzVytDekc0NjZWVGdCUXMrc3ZEa0E1ZEpU?=
 =?utf-8?B?cXVTbUFsRHhMRURmaks3RHk1NDZUZkRMOEphV0ZkbUhSc1FqVVcvcEw5UFIw?=
 =?utf-8?B?OXMxUDdoVjdKQXRnbmlYNVNSYjk4UGtvSkk2bkNuazBEMDBwM3piV1I2aXBF?=
 =?utf-8?B?cUxwUDAvT3Fja0pnYk1NZ3RXWVZFbHAwUnVtaXYvaU5aSW03ZHVITWFoOHE1?=
 =?utf-8?B?ZGh4R3JqakVnYlBPMndNZjQrWERCM2NtWFk5dzRIR28xLzhLQ3k5Zklhb3hB?=
 =?utf-8?B?UWFLWmdRblZxNDdpK08zSVhwczZ6Y0ZpZmNORFJza1owVGx5dWM0ay8xYTE3?=
 =?utf-8?B?ZzQxZ2gyQWhabzc1MnpYd2tJNzJKZzBxR1dLbXNuWk9CRzNPek9YOU16eElm?=
 =?utf-8?B?Y2ZYd2MrNFpidVAzZTB5Wm00MDI4VjBQUno2dnFRc2RrQjZENzkxR0FWRzF1?=
 =?utf-8?B?Yzk3bFJXZi8xK2U5Z0JLZjV1cGUzMGxFSnBleDdOY0VOYjFsSWdxUEtWajNQ?=
 =?utf-8?B?YU5NK09YN2lkdGNuckNUOHpDME9lY2YxZEIyL05Oei9zOU5hS3hkSGxqZW02?=
 =?utf-8?B?T3IwQkI0di93YlpQRlczUVE4S1NOaTBHQ0MySmFuV0tWektUSGJsQ0RjaWU4?=
 =?utf-8?B?WCtnNERxbHJaWjlUUkJlRHU3aUx4ZkcyL3QwNE14WXFhVFpFaGRnRDBEY3cw?=
 =?utf-8?B?YkdqSnV6NXFMOUw0L01lQ0IyUDkzT2tGNFk2bjc4SFhLZy9ldDlxNkFrRTV6?=
 =?utf-8?B?SkU1c1Z2aEdGSTNaQlRmc2MxZG1NcDhOMkFhRHBKZUl5d0hXQ3hqMVhNYUIr?=
 =?utf-8?B?dDkvU0R2dU1PeVhPZnZUSy81d0Qzb2svT3Q5c0toellMencwemxkN3JvZGZ6?=
 =?utf-8?B?ZlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a83f1f8b-03d9-4ca3-d19d-08dba011b5aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 17:36:52.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHD4hrxvGnOMzLli1a2idOUk6C/gSaY69Num7pSfEoiB5tswvOtYrGq2qyW1J6kPY/eMSyjWDISbCF6UuA4hInbtcaBGHhF9SU7ih3EPCX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/2023 7:58 PM, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 17:42:58 -0700 Tony Nguyen wrote:
>> +	page_pool_put_page(rxq->pp, rx_buf->page, rx_buf->truesize, false);
> 
> I think the truesize here is incorrect, there's new documentation
> for this very case:
> 
> https://docs.kernel.org/next/networking/page_pool.html#dma-sync

Thanks for the review. Will fix in the next revision.

Regards,
Pavan

