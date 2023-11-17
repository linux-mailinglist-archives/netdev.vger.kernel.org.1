Return-Path: <netdev+bounces-48542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A55A7EEC14
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 06:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64C8280EF7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD7D2E4;
	Fri, 17 Nov 2023 05:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpwUx0JO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D33196
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 21:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700200376; x=1731736376;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mSlgATPvLf/69kwfBGk20vR5draP5kCxUKIFVcSYaVY=;
  b=gpwUx0JOgK2KWRf02mkkHpMIjUCnwtdNcVgUweYe2Hk3zX2S4RdD3SLj
   Tib0RCwrUvEBYBtYsJwxPcRd8PJi4GOscasHuO9LkYRt6QI/K9p5Iwh/2
   DgiShRXSOy/EFEYXwr8YoENUwp6iC2VJkRMuTSl9uhp8EnwKWOp8A6omo
   W8FUXNzJd+1n+WBFaYDzaDoV3TXiv26JPjfvfo5PqnX+HFah/bWPqqVff
   fu1k4ka8LuU9eSn+QuWNFaoavXZChJkchX6tCAeBLaIVWimCPo/v7C5Ij
   LULzcUgC4YGd7sce58MSFNPti0SNCmPnZnmUZMIs1pjGRawa65tOFlI0k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4375972"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4375972"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 21:52:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="715435648"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="715435648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 21:52:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 21:52:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 21:52:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 21:52:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYvn7kBto5E+bZmepIEy6Olh11yp6CZQ3WuJUhgX4RUYPnYfsF236X+CvR9SrX3Ko5hrdU3FbCHTHH89kwxcv/FgTBdSqJ2BhqXwNgxJvpCvRj/hnDDXgWUVNNYAlErSoVz0PlSvE4U7y8erS2HlDSfl3QtZYDiWZJKIcTxGmpX7z7oJON30QiavrPgj8GiNWbkeY19B1ryw/gZcG44N21nY7z5s+8H/1QRlJg3Pqc7Ih7ymwtg/E0lcEtt+hHSjPI9/FSh0B7hXeS61jJ6KIvAnj4juG6tEkVPsGepR5TXiKW3+HBUAOR/Q6d9KjFTCOdtBEeGpAVLtn7yYRH6fIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSA5/srXzS2dqmkzyXXBwXE328CQy28vDATTknk7z8k=;
 b=dJ305qOvvUxZVuPXtIgxfsWC+fM+51UK2rLxy9c5S8KB9f188cngjAqxMxDIDlb9u4ElIFBUfgW8/HukmpCkwc0XQD8oovJtIZ7BNcyV22PlNFAOvLroV0DbIK3Xw9vUV6TYR1fTsNncizp4TyBd6w5u9e661WYFTfV7P4527pyWaJh2NU6IK1paiTePrknD6hw6nlGlLs6/q/C+IUd8ctQuMUgzDPIw1dP4y/LIj9kfuLcbILfd3adrIzzEBHFXz2MFe11lWTIRCnEo4R+/ZSkz2BwPbf3FL4G62TyqjTqe9laXxpmoVca2Ih0DI4l6AIL7j/MB0D1w0wgw1gf2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3175.namprd11.prod.outlook.com (2603:10b6:a03:7c::23)
 by LV8PR11MB8534.namprd11.prod.outlook.com (2603:10b6:408:1f7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 05:52:52 +0000
Received: from BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::124:ae3c:93d1:981b]) by BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::124:ae3c:93d1:981b%7]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 05:52:52 +0000
Message-ID: <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
Date: Thu, 16 Nov 2023 21:52:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Content-Language: en-US
From: "Zhang, Xuejun" <xuejun.zhang@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <anthony.l.nguyen@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <qi.z.zhang@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>, <maxtram95@gmail.com>,
	"Chittim, Madhu" <madhu.chittim@intel.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>, <pabeni@redhat.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com> <ZORRzEBcUDEjMniz@nanopsycho>
 <20230822081255.7a36fa4d@kernel.org> <ZOTVkXWCLY88YfjV@nanopsycho>
 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
 <ZOcBEt59zHW9qHhT@nanopsycho>
 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
In-Reply-To: <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0128.namprd04.prod.outlook.com
 (2603:10b6:303:84::13) To BYAPR11MB3175.namprd11.prod.outlook.com
 (2603:10b6:a03:7c::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3175:EE_|LV8PR11MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4b7b05-e914-4927-c36c-08dbe7317015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iuiv1DhxM18PExaTBcajZdO/lHbCRykDN8gQZg6EK0PsZ5yKYtJ44QE/cpi9h4d/3lryoKbMViOFperJER9SAxdG4SZ5lsC3Zff0iPJh4tv34dF92uZ1/o3SJh8MwdB6UR2C401MeBcqqiazgHyyoBvaoma+peAU5WsKR4lIdBSDzPv3lns8JbQ8XZ+n436MddscgopCGnzHxmF9syxJClwLbZAULVuyDhdzSFv1a8MgOBwveN+RjXizIIUalsqZHx5Aeb2/eLKCpt6y6nxjVpEdDMQJreFtDhgAnypnzxbNSBOHp77vHCi/yJWFbVQ35Fw4OZIM3bOZiCngdYcGl5ZQ+iICmDIWo5DokT7hy4Cb8BDWKyhDvSn9XJF5fl6hJ7rfSwyM2k3DmiHvDFiLhxRz40bCEG7tGkcWy7QlJr5fA26eKvzL+2/+uznuUaB5Q0RYM0FhySrcM8eRNziVZc/Q46v4vfJG/YYvKMCyLB6x1eRsjR785fGxLG7J2FbnPmK7Qu/cIQCeUTtHcNNQNnnKcv07Fn53ljhoFH8daWtHgbUm2HnS1yHqNO9dTDBv/6ykHchi/T5kSCFuxGYV2+mBoG8iS0MnPyCTb+nrzZVsp0Dr50EtO3lSm/XvuIlW7s99jEaYyVgObzsCMjzi7uhOnYMz6Iq0qrtIUNnVL9OoqbKv4GuaK1Pmtaqx6Bti
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(26005)(6666004)(6512007)(53546011)(2616005)(83380400001)(5660300002)(8936002)(8676002)(478600001)(4326008)(41300700001)(966005)(2906002)(6486002)(316002)(31696002)(66476007)(66556008)(54906003)(6916009)(82960400001)(66946007)(86362001)(38100700002)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU05bk9UOEpLRFlPSmFxMzlVZHlQTEo3MmZwdHkwSk1PUDJ6MkdoMnArb2Fz?=
 =?utf-8?B?YU9oRzkvMldYSlNvdmw5c29RQ3NLOFZrZGo5b1F0UWRxRnBuc1dMblFQUlo3?=
 =?utf-8?B?bXVUWWZ4K1JkbzRmYk9pRVlkeXlrMlkvS2pIZlZIVXRZNHkwN25COU53T2c2?=
 =?utf-8?B?UXBhSUVodmlEbURUVVFkaEFBR1RqbWlIUFJ0Z3doVlo2T1NDVldXbDE1bW55?=
 =?utf-8?B?b0h2VGZGZ3dxSFQyOHlXaXdOR2FwY0IzQithMHl4YnJSS2o0MnVmQVgzS0dJ?=
 =?utf-8?B?bWpKRzNOTFNkMWEvcmxTWUFVeUdMaUtua3kzWmF2MGhYZThHVzV6czNrMTU2?=
 =?utf-8?B?SWx5dG9GNTRXRlUzdlZGem45WmlNRThUUjJQYjNQeTFIWDVBV0t3YWVvVFFY?=
 =?utf-8?B?OEhSenF3T3lDU2c5MmRvU21QbGM4aEJLZ3BlcDByVlRoem1VdjdxVmJ2TWNl?=
 =?utf-8?B?OXdGNFdVNS80OHBPcjRqYmx0NEJ0cnFmYU4wZExBU2xWV2FWSkdES09oTzFa?=
 =?utf-8?B?OG42NG5KOXlaMndWSWxKc1NFek1Ba2xYRkZYb28xQk1JWEZ5MVgxaVN4RVEv?=
 =?utf-8?B?VzUvenFqdElrNUxZbXdaRkh2OWFrWWRnayt0aW4rZDd3MHZtblk3UFA0UWRK?=
 =?utf-8?B?WDl6cEJVT0YwWVdJeWVlYzlZYVJ1L2JrNGZlbHArTFFBQVM3WXFHc3Q0S05u?=
 =?utf-8?B?d1ZtUTIzYnpmV3NxRHViL21kM3M1K1pyK2hNVmJnaGF1SWdMSVlmMXd2ZjE1?=
 =?utf-8?B?T05sTHNZMlkzWERMbnNEalJjZEg1SUxScElEVVBac1pOdHF4MHRacFFpUkQv?=
 =?utf-8?B?ZEtqNVZIalpBMjY3cnhxajROYXl6SHRFcmw0NktXaWVSMTcwZ2NKU0JDdFhh?=
 =?utf-8?B?Y1RJOVhHRFpxbEF3bFNSTHdsOWFVWFJQTFRJSnhwcVV5ZDMrekhEUE0zU1Ja?=
 =?utf-8?B?Yk9UQVRaVVJCTmI4Tlh6TmhiWlFxMDRTNXZsaUVHb0dLTS9IQmtFVCtna3Y3?=
 =?utf-8?B?b0libmd2T2cyYkF5amt2b0ErN2loOW1WTlRNVldGMXNGbTRvUXhGTHBhTldN?=
 =?utf-8?B?WWsyMW5MUXFPMHBBQk5oTytvOGlEeURWQTBQVjZHWE9iNXczTWZZQzhnTWlP?=
 =?utf-8?B?VnVSQ1BEdmxOaDBjQXRML1hBTFlueitrdkNGWHVPeGlYWW44SGxvVnpMbkR6?=
 =?utf-8?B?eE1PMnBsZG8zUU5OdkN3SUN4WU1XUUY5NFk5N3BvdEFMbkVwT01DQTk2dURF?=
 =?utf-8?B?VWh1MHRRQlNZdVZtcVAxVFhnMFFuRWxyTnNyU2J2WmZFQkZhcHFtbHZlK2pS?=
 =?utf-8?B?cGw4cWQ3TkFjSXlJQnVRV3E4d1NUMG1aVExIUVBqOW1lTmlBOWxXNXBMRGFZ?=
 =?utf-8?B?NVRFbjVFSko5TjFTNUl3OXpFbzZnb29UcjZ3dElneFpaVmE0a3VzWTZPb3BG?=
 =?utf-8?B?NDdWMTZPak5KeXRwYVNvQTEzYjl0V25YeXVQNndQWDdMV1g4NWNEZVc0a1hL?=
 =?utf-8?B?bDlBSnZVNGk5OC9YOUpLQkEraUQvT3p2TVZpdkNPL0tOc0syWEJRYzlxTzVy?=
 =?utf-8?B?RVlER0JGMllRMmthNGN3LzlMd0dhN3kxSkFuUmljOHQ4MVJIMVp3L3hmOHZh?=
 =?utf-8?B?dGpvWlZjZEJtckdRN2VCYlNpSkMrN3dKWllLNmVmTzV2VnpwbXg3ZXFicExW?=
 =?utf-8?B?UGRiOFFObzBmdFovUmRDcXhtNGpESU1CRUpNdmdudXprcW1QeElQUnhNU3lr?=
 =?utf-8?B?L210L2RJQkZaMlh5TmNTK016bjMxb3R3T3ZGYXVhZFowL3J0aWdTYVJjRFFG?=
 =?utf-8?B?UDJ3U1Z5UG9jcERnQS9JOWZMWFlwVFh1cTM1Y3RWTmZnbm0xdCtRdDZhMkpF?=
 =?utf-8?B?ZndzSmpBYlBYV1poM3dZN3dsWkJBajJwc1ZOSU9BKzM5THdNc2FUdVBYUlR6?=
 =?utf-8?B?ejhGNURCUFQzUlR4TXVaM2lLcWpDeHR3V0VPNUJiTWdmTnJEMW9KY0hUNHdo?=
 =?utf-8?B?UTFGYmlUZFY5SThLUFVvazc3bGRKQm9zaS9FeUtYMnVORVNTZjI4Wm45VUVL?=
 =?utf-8?B?OWRodDhjL0xydXl3ZGpKS3JQeFhMZXUyQzNVMXEvbjlVWWs5S0VtNWY2UGtC?=
 =?utf-8?Q?jtI1sgUeCa0gyD9OYL1TikCBi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4b7b05-e914-4927-c36c-08dbe7317015
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 05:52:52.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVI8fLZw+fyXh7E6WR5S/hHyG01DmclkDhMOY8PADvCEwBr9PI5bbVvLeRuTu0ebtNzKIBYa0opyboiQeTWlKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8534
X-OriginatorOrg: intel.com

Hello Jiri & Jakub,

Thanks for looking into our last patch with devlink API. Really 
appreciate your candid review.

Following your suggestion, we have looked into 3 tc offload options to 
support queue rate limiting

#1 mq + matchall + police

#2 mq + tbf

#3 htb

all 3 tc offload options require some level of tc extensions to support 
VF tx queue rate limiting (tx_maxrate & tx_minrate)

htb offload requires minimal tc changes or no change with similar change 
done @ driver (we can share patch for review).

After discussing with Maxim Mikityanskiy( 
https://lore.kernel.org/netdev/54a7dd27-a612-46f1-80dd-b43e28f8e4ce@intel.com/ 
), looks like sysfs interface with tx_minrate extension could be the 
option we can take.

Look forward your opinion & guidance. Thanks for your time!

Regards,

Jun

On 8/28/2023 3:46 PM, Zhang, Xuejun wrote:
>
> On 8/24/2023 12:04 AM, Jiri Pirko wrote:
>> Wed, Aug 23, 2023 at 09:13:34PM CEST, xuejun.zhang@intel.com wrote:
>>> On 8/22/2023 8:34 AM, Jiri Pirko wrote:
>>>> Tue, Aug 22, 2023 at 05:12:55PM CEST,kuba@kernel.org  wrote:
>>>>> On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
>>>>>> NACK! Port function is there to configure the VF/SF from the eswitch
>>>>>> side. Yet you use it for the configureation of the actual VF, 
>>>>>> which is
>>>>>> clear misuse. Please don't
>>>>> Stating where they are supposed to configure the rate would be 
>>>>> helpful.
>>>> TC?
>>> Our implementation is an extension to this commit 42c2eb6b1f43 ice: 
>>> Implement
>>> devlink-rate API).
>>>
>>> We are setting the Tx max & share rates of individual queues in a VF 
>>> using
>>> the devlink rate API.
>>>
>>> Here we are using DEVLINK_PORT_FLAVOUR_VIRTUAL as the attribute for 
>>> the port
>>> to distinguish it from being eswitch.
>> I understand, that is a wrong object. So again, you should use
>> "function" subobject of devlink port to configure "the other side of the
>> wire", that means the function related to a eswitch port. Here, you are
>> doing it for the VF directly, which is wrong. If you need some rate
>> limiting to be configured on an actual VF, use what you use for any
>> other nic. Offload TC.
> Thanks for detailed explanation and suggestions. Sorry for late reply 
> as it took a bit longer to understand options.
>
> As sysfs has similar rate configuration on per queue basis with 
> tx_maxrate, is it a viable option for our use case (i.e allow user to 
> configure tx rate for each allocated queue in a VF).
>
> Pls aslo see If adding tx_minrate to sysfs tx queue entry is feasible 
> on the current framework.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

