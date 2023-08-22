Return-Path: <netdev+bounces-29714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5D784662
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AC11C20B2B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A441DA55;
	Tue, 22 Aug 2023 15:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230B1D2E0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:56:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654DECDD
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692719801; x=1724255801;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5B5bb/Jwfh2WdWpGAB4+v2I1Ym+a5AWdi1ZIAdNKTbM=;
  b=HiurfE+3b97zz6cNIm+smp++UVOWMIwkPTfyc6/NQVqWtuNoEYSZwgD5
   m+bOqiVsXLRF3sxLDNA9hw7QiF6sWBFoZRsmCJsVDxLGXkxQx9K4Y+jrY
   qT86j8F4vrGjsJ0z/HgBbgS0aq/CDaE+4wM0imZ48/s5gCJjVLXpF6Q91
   cPHDA1+1cFzhug7dXFgGQHlQ4bxYDkG8S9SueyLqZmA46DWo16fSsBWV8
   themVoHqCCdtLc17f/wUfIE6knVQSmov29oVGDuDbH9jQMnproQII/ORh
   LMBjV9U34U5awkdLWw31nx0uAEJLUT6EGujq+I+3VCt8fRh9cNa1C30KK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460283433"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="460283433"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 08:56:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739369932"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="739369932"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2023 08:56:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 08:56:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 08:56:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 08:56:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 08:56:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as6+x6Z61eS5C6tLJE6v7Ao/Zs8Oqh0Zt+U/R1S++utQapO1T4vdf1DiaZm/E6PIqSiRDn3MI8c0eaFf2eXMmzCeBjEOkx5lzW55M/SiD/SQQKM8C/JT9BGznVZpfBKQdkHGHqTgl3Mn6SjyirfTXmv2xgr0FY6zq4Rem7ckaoQ9ZkylYlSWiexGyhuJvMQNp5aqwF9fsr2reBzk9LJObEq3cn+qwuhdXGVEgzE6p+40AUekIYu0iZqH6G3hZp2Bp7kRgcL3OfuGIxqtluTOjf6LHPiCOcR3L8AyeIqOdlQg0oSzY9pTYG0RzAxINEbHvdBlsmu/enHNnv+/uUAgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6igrI5Q/RAkVG/f6hiX1SzWteCTuK3XsCeNXOm5GWo=;
 b=WtYpzNSW6UvekWNJWF7IEQjq7IwlNJLCBFo+HIupYNvmc5s+xJmMLPq5GzSaQKz6dHpqn4zNzWZlG7bR816TvdSG5K5o+pFR22hATOXNj2gc000Z3zz5GWKAGsSTzdVWDxcLaOthZd01Wl2PwefAb43uAVjEmiyY6W8AKbQsXomU1gEC9uq2uNsoSq3EjfTZZM/XxO8XbVjtqZQXPRTGlVWFYu8Gq4CBNNYS0nhFLD3C3Q2w6jxU9Mgyif1n/eQKIdigYi0em+iGDCgvHQL1qly/b09MC/2/6DKnEEITweEsHckvRpSMkgMbCCGeze+829jH1RfvYeI5Fr1PRKuPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY5PR11MB6308.namprd11.prod.outlook.com (2603:10b6:930:20::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:56:33 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::c45d:d61e:8d13:cb29%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:56:33 +0000
Message-ID: <8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>
Date: Tue, 22 Aug 2023 17:56:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<jesse.brandeburg@intel.com>, Karol Kolacinski <karol.kolacinski@intel.com>,
	<anthony.l.nguyen@intel.com>, <intel-wired-lan@lists.osuosl.org>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal> <20230822070211.GH2711035@kernel.org>
 <20230822141348.GH6029@unreal>
 <f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
 <20230822154810.GM6029@unreal>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230822154810.GM6029@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY5PR11MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 410f2241-c4a6-4830-6ad1-08dba3285b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAYfvVNZrVFFULmr3IrGpDr9opP8mslsqxzSgnBzQTvxV/p3Vbdt2JvubD1SaKSb8+wSzT4sMtL/c5bnHBb5EgkHdWcEZsNJSC//ya+VXbAH/3ZbRYQe0nttLdMWtFVYc31SMttCz47UCY1REk3ykYYP7iPsUlCgC2ceJ9SVgp0ZjrDv3t0PcqrioZaxFZAkwKDqJB03NF8mO+lIjoPBvE/GYPF/1Lx3QRrDDX8bgmDLlvCmb2GnBP/7w+5zyZ96UZMZzKoYVKdJbA5Fuj/SP5pW1Q5phey/UWOITunlsW46T8L6q+1L7DcFMBGZ8r3XzEBk0SZwb3U7HC9XuQ4g9ki2k3KSsoTzYl9K7PbKhBKTD8xpBNJCHmrT2XEGUkcl15Q1kz9DBV8fsK8DvZzLWu5t97dLuW91Xo0Tk6P8xseI5kRDUA5SiGg51Gg30Vi++4Ie15YyaKp/qyyjnbmpIbmtFjR6Nbg3+0lCDYPmroAXFPtVP7Hcc3V2ouywE/EuXnspOJ/WCHpCNsS0DlC2xJiHrVkkkbz9Mi41BuC/wh+rDQgOnKb7B07YnOX4D1Kjg8OmgfKW6en91u25ZsgTj/GPM4snIl/q/Q+d9fbIqLvNAbRZlWrnaDKHa1ZQIQqp6acg7FZUPsjtuvuuM7tCdVaDNI8WP9K17khjm7gmreczH2J3giFKw4AbMe6wZQJo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(6512007)(316002)(66946007)(66899024)(82960400001)(966005)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6486002)(53546011)(6506007)(83380400001)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZCd1ZqTmx5dnRONjdHQlNVZmdSUnVmbWdJclJTSDlhNktPd3IwYUpabDIv?=
 =?utf-8?B?Zmg3dTJPUnlJL3ZVQkU5RUFOVUFRZFBNaGhKVzJJelpkMkVTb3VhbFZ4SGI4?=
 =?utf-8?B?TUo0L0hSKzQ0TGhVM01hb0NGUGo4b2svK2ZnZDZ2M3dRZk1HSzVTcnNuV2lS?=
 =?utf-8?B?MFZjaEVUYWlMRDBjRFFZaW4vZ2R1WlZxcFExL1ZKREdVdUpZeWYzNmhjQmJL?=
 =?utf-8?B?ZGpTSTRLcHZZNmJlV1dyQTN0WkZrV0Q3T3RkdUJsNElvdUlvakhlUlhvZks5?=
 =?utf-8?B?OUlkSUtVclFMU3JDRXFHRlZsa3pVOG1ZREtQaDRXV0RmNUUzYTdHOSsyUHRU?=
 =?utf-8?B?Q25ZeUErK2tRODJUSHFXKzJHR2VBVHpxbmtNcUpIL3RQT2FFMVliVnNOL045?=
 =?utf-8?B?VlNBbEl4dXBUQ3V2NzQ2bFNwcVA1Q2tXSWQ5Rkc4cGtZS3QxZVdTbUl2UzNh?=
 =?utf-8?B?aTJ6OUkydkkwSWpNVEJpMzlIRFBCeU5mNENHNUwxQ25HTlBxRWVaNzhLVUlH?=
 =?utf-8?B?eGtSS3FQbFc4OGNRNXJrcFVrTERjcm5Celk2dStlN1ViaStLV0FVQVdkVktU?=
 =?utf-8?B?cEZqdTZKYzN5V3ZNNmxibTdha2ZxL1JaRHl2T3l1WnQ0T0h0aG5QTGlXb1BK?=
 =?utf-8?B?Z0ptYXJDUG03dkZuMjMvUzFCbW0rUmk4TkRXc2NQMkp0Tk9WYUh5d2lmcng2?=
 =?utf-8?B?aUozKytleUo0bVVsN3o3V09CVG9TTy9JY2xCa0s3K2Y1V3cxZmNwUUN1eDBJ?=
 =?utf-8?B?MkN3czF6YWtBTFl1b3hlM3ZONkRkcmhIdmhza2dOckxuTHNNTHlEVGNvWGNS?=
 =?utf-8?B?bnA1T2grWnovS2V0aEwwOTlKSHVEbjU2Nm9LcVJJcUJxejBpdzZDSHp0TU1M?=
 =?utf-8?B?SEhsYWFnVXFhaTlOdExqOExaTEdkTkVRLzNXVGFsbjArV0xPeUZKakJZWGhB?=
 =?utf-8?B?SDBRNUVLODlDdzNET05wbmNqVTlablNnRWJTZUY5R2FrTks0NVhzb2ZLWmZO?=
 =?utf-8?B?ZlowL29kb2taaWxBQkVEU0FGZzNDNmhDZGs3MHpiQmxSVGlxMVpVczl3TE9q?=
 =?utf-8?B?N3FmbW9oM1F5OVl3aCtKQ1RHWVAyMU0yTHF2cndTREg4SmFqTEMwL2p0WDdG?=
 =?utf-8?B?aWRwMWJKMHRpaDBwMHBwa1lYODZ0QXJlZmQrM1FTUFhPUFpRdGZiQnJNREY5?=
 =?utf-8?B?cHN4NkZJWXI0bEE1Tzhzblc4TkNXWXBnOXVLWWsvTUlQaXZrQVcwenZ4bFpW?=
 =?utf-8?B?enFjUnFCVlBwT0FNTnZ4Vm5WWFlFUjBEOUcyYzEwZmdvSk5rUjlqbjVJU0E5?=
 =?utf-8?B?SzJvSGJvZHhOZzUzdWoxY1JxTE5xREhCVTZheHpLSHdkMlhlc0wyNlZUalRB?=
 =?utf-8?B?UXVCcDI5emR4ci9sUUp0aXIwUU9tWHRKZERYSXFqbjhXWWdnb1oybjJTUXoy?=
 =?utf-8?B?VGhBenRjTzE5ZnBzbHpBeS8vQmh3aWg3S0VZRG5RcjUzMko1ZDZ5OHpCcjFH?=
 =?utf-8?B?V3VVRENSV1BYNGF2K3MyV283ZGFtbDJkMnBnTjBMaGRIdzQzQWZVRXNTY1Bq?=
 =?utf-8?B?azNwL0JyVTl5djBaSlJuTDlZNDl5STF2RytkbXpnMmtlcTRmQVF4UFNqcjNx?=
 =?utf-8?B?ZHhCWERoVjlSZkIrM01TWUMxaTVQdHpKM01MenhUckUvWG1PVzhEcmpSU05R?=
 =?utf-8?B?YzYrWHFCWGxwY01yRUJsTXhJb3FLOGpRNzlmOE5tcFN4bERVeHUrcUkrRTIr?=
 =?utf-8?B?aWxJdC9USW44UEIxanN5cWhHaVdaa01TbFRLY1lFdkZFZ1JCTmtaR0hzOVZT?=
 =?utf-8?B?cG5jQkpZMGltdjFkYmVUOTQ3eU5pWkZibXNtbVMrYUdoRWU3WW1CbEpZbTJz?=
 =?utf-8?B?b2hHZXhTQ0ZlT0ZtdnBTMEVpRnFyZ3Jaa3BVYi81bTVObVhnZzRIQ1hQeWpn?=
 =?utf-8?B?SkpUdVdVRXJkYlZNa1poTUxCbmNMbDJiOXF2cndEaVIrUXYxN21Xci80VnNC?=
 =?utf-8?B?SlFKS2VZNG44MjZVNEJzVkxOR0ZOdkN2M09UOXE5bEQ0MWlxZmdMWllKK3Ev?=
 =?utf-8?B?UFp0c2lhRGZHR0Zyd2FxUmdvcFRJUjJyOGdTME1lWERsUC95SjJDNEpabVY0?=
 =?utf-8?B?eW41aWNRb0YxSmhneU1xLzBrNnJLVE5pb1hpRnN6ZG44bHQ3WjBDMTB0YVpM?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 410f2241-c4a6-4830-6ad1-08dba3285b7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:56:33.3216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIhuyqgGdbc02o5vdDSG24QYnQjinaNTgkYkQMdUXDM33+xM4+MXHLre28ySAgBYoSLTVlIxkZvc5vGlznXznVc/8d4R5RuoOClHI1/j4Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/23 17:48, Leon Romanovsky wrote:
> On Tue, Aug 22, 2023 at 04:44:29PM +0200, Przemek Kitszel wrote:
>> On 8/22/23 16:13, Leon Romanovsky wrote:
>>> On Tue, Aug 22, 2023 at 09:02:11AM +0200, Simon Horman wrote:
>>>> On Sat, Aug 19, 2023 at 02:52:49PM +0300, Leon Romanovsky wrote:
>>>>> On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
>>>>>> The ice_pf_src_tmr_owned() macro exists to check the function capability
>>>>>> bit indicating if the current function owns the PTP hardware clock.
>>>>>
>>>>> This is first patch in the series, but I can't find mentioned macro.
>>>>> My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
>>>>> ➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
>>>>> shows nothing.
>>>>>
>>>>> On which branch is it based?
>>>>
>>>> Hi Leon,
>>>>
>>>> My assumption is that it is based on the dev-queue branch of
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
>>>
>>> So should netdev readers review it or wait till Intel folks perform
>>> first pass on it?
>>
>> Most of the time Intel folks would be first to review, if only because of
>> our pre-IWL processes or pure familiarity/interest in given piece.
>>
>> For this particular series, it is about right "codewise" since v1, so you
>> are welcome for an insightful look at v3
>> (I didn't provided my RBs so far because of "metadata" issues :),
>> will take a fresh look, but you don't need to wait).
>>
>>
>> General idea for CC'ing netdev for IWL-targeted patches is to have open
>> develompent process.
>> Quality should be already as for netdev posting.
>> Our VAL picks up patches for testing from here when Tony marks them so.
>>
>> That's what I could say for review process.
>>
>> "Maintainers stuff", I *guess*, is:
>> after review&test Tony Requests netdev Maintainers to Pull
>> (and throttles outgoing stuff by doing so to pace agreed upon).
>> At that stage is a last moment for (late?) review, welcomed as always.
> 
> It means that we (netdev@... ) will see "same" patches twice, am I right?

That's true.

> 
> Thanks
> 
>>
>>
>>
>>>
>>> Thanks
>>> _______________________________________________
>>> Intel-wired-lan mailing list
>>> Intel-wired-lan@osuosl.org
>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>>
>>


