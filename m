Return-Path: <netdev+bounces-46943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57687E740D
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 22:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E98C28139F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02C38F8F;
	Thu,  9 Nov 2023 21:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfJ9h2Gq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6C938F8C
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 21:54:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF981FE5
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 13:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699566872; x=1731102872;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8lRFtCseJTKxdnFvecxWLwJJ0OuNB14Poc/4Q66rpM=;
  b=DfJ9h2GqEXjyfDrcfw471QU3M0+hp8hVVUKlpCDyekpGcNbZjPMBXrXu
   0/t2qzqYaZsieQWmMdGTENTbt4ZKmAhZoxgSjQm3WqMiK0jdg4ibzY1pb
   iAjj0YzaKAX7BV4mOpm+xjyEJhYzf7SBs7l7a0tq4dkZhevqRBNYZk0je
   TMPCIa6FUZC6egm+SmTPpECQoqbeQma1eo3XlsMUTzwWGqQzjZJaAH38P
   9msO5AF46FcefXHU/i7o80DKT+cWwjLjOw/O4imof799CUdLWU235AiIn
   DqrhMExbIuvFTfThbmoW7c6rbXqe8J+nYP14x+3YSjCIWp3pilQRfibeR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11630074"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="11630074"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 13:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829452693"
X-IronPort-AV: E=Sophos;i="6.03,290,1694761200"; 
   d="scan'208";a="829452693"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 13:54:24 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 13:54:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 13:54:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 13:54:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 13:54:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnuRU0GMgG7musqYChFgjPRxUOMU2s4opCtvS8ji9q3h6hNl9F34aXYj1X85pZzM9M2MPiLo3j7Es8ePQiss5OFov2UhmXUGfi/GvI/IxiN043dKSkAqqK8XUL5GUisoQYgjyaQknn2WNRw9hwCf1s3ch+ezlIRaBX8ZD5afFf3OAU2qgUeeW+igSTRR5U5+FbQQYxh8rQPp3WmSl88ZzThctWF2EoH5VHxr6H0mhTxTDSG82ckZnr7miox80X6aYBibX0jEUq0uU6gFNdjywvCmq9BKDW3YS/fBve+5V80/xbFWfjJVFhKywtNZsoDmq1aGsI7xMRsZhvLd2o2ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr5oiCjWTMP2367dX7QUlxRK15mRiZmjnQhAG3OdQYc=;
 b=SP0lU4yJEtUC8omTuRDHzbxYlh34Y93QfCjkxqx1Egy5ZF3vX09MaX9f9aAwIYobH+6smjs2QCdRBAj6L27eKnBq/zI0rByMslCUbgaxLDxaOw8iNvnsftCi3WCLaF5+UrAbZGgVnZ5j/32ZP0uLTF9NXqjDiJucwXHDEnPVBntKdd4q5bhZdB56zXgxL+nfVrOp/bQx99YjZ/YKCFTPIBZOpEojjtn70LT1mxZfuV9HCqfp02HyCLFFLBK4adCJeqG89CtI4K0YMmjauqVN62S6p+kS7qKUBS4dUgZHrVleZmBPRpzQJEz30F1gRCw9ZNZyraGeKTTy6ydTKIAKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14)
 by IA1PR11MB6323.namprd11.prod.outlook.com (2603:10b6:208:389::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 21:54:20 +0000
Received: from CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::dc90:ba:fcb1:4198]) by CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::dc90:ba:fcb1:4198%6]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 21:54:20 +0000
Message-ID: <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
Date: Thu, 9 Nov 2023 13:54:17 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
To: Maxim Mikityanskiy <maxtram95@gmail.com>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<xuejun.zhang@intel.com>, <sridhar.samudrala@intel.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
Content-Language: en-US
From: "Chittim, Madhu" <madhu.chittim@intel.com>
In-Reply-To: <ZUEQzsKiIlgtbN-S@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::33) To CO1PR11MB5042.namprd11.prod.outlook.com
 (2603:10b6:303:99::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5042:EE_|IA1PR11MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 1178ea13-6988-433d-c8f8-08dbe16e6d40
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baj0fEbZ/bBejxGGiq+LqcGpriii3OidQiNQ670wDfgYapUN/1FL5NL5/ex2kdmJSgwDe2GOVrLz4e3t7IgOWZoXN19s/f/8FLrwtidxXBH+i20g9LX8X/imdtwriBVManTZ8mOj99Gngj06AlPSAoS1sktynPlhJlF9JKncTtnizZA3X0VOMsw4hk9mO0nzAdHjPcAY1UViR7k3PwtJaeuaH5Cr051xFWteg/2hH7CNe/47xlxPSYiGSjzNb0GiisaYCMK7qrc3QY6AeMCAeqm2GJMAftuPgA5zNhBs7iOAg5Cicyr4AlAW8qEahjuSPmhBoKkEDHMuAfLyKuA5dm6XHGJirgiysG6w9PM22fpabiJYsEG7k7+XggjFfEFkaontd+TJVLwUV559MaqQIFsfMip1oM85twGhAf3xnRnK44Qv1UGOJB7l45Dxw8+P9oJLNc+aw7fBTLbi5bD7SSwv/nyV7z+0+POLLZX3gUzLsMA9cDQ3s7He2dAXOWQo2zvEGUxIhxDytHjyYMc/wo4r7JZaanJls/Eq79p07E83sOCl4souh/6WeNzROoHQpWwttw7mfPeasjZHlMpB6LauUmtKjK/aH+rbbufZWl6aLEOzXn/T5eVAnmVLDfAZ9MIXF3lSUe9KWII8ALE0EAVhsgtevDHUHePDY/GPCKTzBRg7UJCxInBBYo72HxFl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5042.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(1800799009)(64100799003)(478600001)(6512007)(2616005)(41300700001)(7416002)(6486002)(53546011)(6506007)(966005)(66476007)(8936002)(8676002)(26005)(83380400001)(5660300002)(54906003)(4326008)(6666004)(110136005)(316002)(66556008)(66946007)(4001150100001)(2906002)(82960400001)(31686004)(107886003)(86362001)(31696002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STFsbW1zZ0ZhZzhuQzcvU2hybzBkc204SzF2VWdEbW1VdkVJeXBhT0p3WXdy?=
 =?utf-8?B?M2ZsUW5VdGUvbUtTdjJOQmVTT3QreGlyNW5rTDZ0QVp3OGx0WDhDUCs1QkV2?=
 =?utf-8?B?dExEUUc5QXlLVWJPRDNweUFCVGdRVm55cE5QMmpSOGlhOEFJNUNHdVB3WFNx?=
 =?utf-8?B?cW1KaVpNZURqaENaQVRCN2MybUJ3bDRQWTlZbjhpaE4wQ1JGajFlM1ZhWlVk?=
 =?utf-8?B?VG1XTjlUalpQRzZqd0xpVG1EakFTRW5rV3krVUdwSHdHbUdZQ0UyVjdaai92?=
 =?utf-8?B?Y1Y1M1BGaDEvMklWc2huMG1pVksvMHV1TFVPd3JCUWNNd2pma2Q3UDFiOFNw?=
 =?utf-8?B?eHhWV0d3UVVFSXdJdlpSbG9hR01KdmFVck1pTXNzd056cEhWRmtxblFSOW9i?=
 =?utf-8?B?MGMvZ3VjY2JaNmwwZVRUVno2Z1lWdXd6SU93YW1zQzlOdTA3S21SeW05L2Np?=
 =?utf-8?B?NUp2ZjQ2NDBicDRPb0VwTEIrb05WOW9ieGpFenBheHpKSGpTT1hhcitEZE9k?=
 =?utf-8?B?ZnBKQVJYQmxqVTNZODE2dCsySVlRWEpUcHpvdUdsbndBWE5CdGdsU1BNa05r?=
 =?utf-8?B?ZGYvR0NQOFhSY3JEb0JOWk1aYWRVSVRMZ2V3c3lka2UycHhtY2lJcUZucitj?=
 =?utf-8?B?UmNCZG9BWFp3ZUF1SG9GRFl3a3Vaa24ydXNmcEM4cm8ycUFYVFh1RGg5THc1?=
 =?utf-8?B?Vlc0YlZpSVZEZUwwVk84OEk2QS9qalFzYVJ1NUkxenhkN3NDZ2Q4U3IyZWFr?=
 =?utf-8?B?bFdxRlNNZU4vZGJCSG0rQUNMbU1WWGtaQkJNM0RuL2ZTa0FRT2tCcjQ5ZnpK?=
 =?utf-8?B?RThNeW5XV0hjSjRTTUJZKzduNFJNUFpsb1BkUTdSdndDY3hCMkRvVGFYdXpI?=
 =?utf-8?B?ZkhSZ1B6SkcrZ045MXdIQ3JDTDhPaXNZdGZkRFFyMUtFRDQxSWtIYmVyTWgx?=
 =?utf-8?B?WGVveGpCWGdENEp3Z1UzcWlmbDdjZDVZU3NVM3hrRHZNeEpueW1wZEdHay9w?=
 =?utf-8?B?U3Q1N2pqR0V6RU5ncHVUdTViVWRxc2JPR29qaGtMS3NsUVN1VFEwbjlLWW1B?=
 =?utf-8?B?cUxzUFVLMVJrZlNyTlpCbXppZy95T3NiMFl2MjdnemhIbGVsUkN2enduMy9C?=
 =?utf-8?B?WTdQRzhUZWI2eFdmYzFDN1dqajZrQ1pDYkkxMjZVM0NSMEtJYzU0c1Fib0NJ?=
 =?utf-8?B?SUMyN1h3RUpzUFcrVU4xMkhLcGFNOG9Mb3FzMWNYVHhoM1FyYXA2WW5iWVdF?=
 =?utf-8?B?TWZma1pQRU1IM0w3Y3lMMnBwS3MzQitHQW0zcGtoRWFxM1UzSnNJQ096a25v?=
 =?utf-8?B?YjlqN0ZCWWswVHdRY0djVmxaVmlUVWhiOVh1bzhWQW8vaWlVdy9vTjZFL1Zv?=
 =?utf-8?B?T2l0WFVGTzlyUVc4OUtnS3JnVkxQdjFkRERPS3NYN0RsZmtoZXphWlZtbXJY?=
 =?utf-8?B?SVQ1MXY5RThmaTBPNEFpeVkybTdWdnRiUEh1UWNkWmJWK3dORWlBMTdiY0Ft?=
 =?utf-8?B?alliUmNsR0g2YXZUUEJmS0k2Um5HREJ3cFJDSDVueGdTV2NudmNEUFFLdnlO?=
 =?utf-8?B?b2toUDhuekpYV1NzWW5pTzcvcUNPV05MYng3ZE1kYjBtRnZIYzEwZkc0Y0Jx?=
 =?utf-8?B?OHdCZVE4RHJrekk4cW5tN2MzZzNHK1hxTnBiWTc0K24zTG52dU1yK2hlMktu?=
 =?utf-8?B?eFB5endaNWV0N2RQRmFFT3F1SWFUaUdnU09WYjFjOG92SFdGZTBPZTBFZHJI?=
 =?utf-8?B?ZXREZmtTaVFyYXFXYUxDKzAyRHF1VEMvMUxGR3h2aU5wQnVURWg0OWdTYTNI?=
 =?utf-8?B?Ty90L3FSTHNOWi80TGFBZjRUbUV4WkFPaVBQOXNIalN0K3FKY3pIUFdFK0Zx?=
 =?utf-8?B?NkMydG50RXZmbXI2TlNWeG44aVhLUzVCVWNwQnQyeE05N1J1Q0hXUlVXc1Fy?=
 =?utf-8?B?UlhUUDBoc2tmeVhvWUt2V3BMNmI0cnZFdSswOTFzU3ZacFZIcnBweWR4TVhU?=
 =?utf-8?B?Ui81dzc1MmxpSzYyU3B6bW8xaWJTalllSjMwM0cvc244Snk0N1ZOM0NpWFZm?=
 =?utf-8?B?VmdIMWozWExpd1pjZmhhdGZ6aUQ2bGV4K2dJZ3k1eU9HRVFndnYxK1pqTG9W?=
 =?utf-8?B?N3JEZ0RQMEdMR29wOHlLa2VIT0NaU2tJODRod1pNUDBuQXZ3N0pLMjJBL0RQ?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1178ea13-6988-433d-c8f8-08dbe16e6d40
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5042.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 21:54:20.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRLvLM3JI0jSujNslepPCnJNUzDViUdt5AXI+Sd6YQ6PEE8sAbR0+Rzm8h/R9LUaxWF+u2+mLlU0qWgm3BnQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6323
X-OriginatorOrg: intel.com



On 10/31/2023 7:40 AM, Maxim Mikityanskiy wrote:
> On Tue, 31 Oct 2023 at 10:11:14 +0100, Paolo Abeni wrote:
>> Hi,
>>
>> I'm sorry for the late reply.
>>
>> On Fri, 2023-10-27 at 16:57 +0300, Maxim Mikityanskiy wrote:
>>> I believe this is not the right fix.
>>>
>>> On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
>>>> The following commands:
>>>>
>>>> tc qdisc add dev eth1 handle 2: root htb offload
>>>> tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
>>>>
>>>> yeld to a WARN in the HTB qdisc:
>>>
>>> Something is off here. These are literally the most basic commands one
>>> could invoke with HTB offload, I'm sure they worked. Is it something
>>> that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
>>> NIC?
>>>
>>>>
>>>>   WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
>>>>   CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ #59
>>>>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
>>>>   RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
>>>>   Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 02 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
>>>>   RSP: 0018:ffffc900015df240 EFLAGS: 00010246
>>>>   RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
>>>>   RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
>>>>   RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
>>>>   R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
>>>>   R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
>>>>   FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000000000
>>>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>   CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
>>>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>   Call Trace:
>>>>   <TASK>
>>>>    tc_ctl_tclass+0x394/0xeb0
>>>>    rtnetlink_rcv_msg+0x2f5/0xaa0
>>>>    netlink_rcv_skb+0x12e/0x3a0
>>>>    netlink_unicast+0x421/0x730
>>>>    netlink_sendmsg+0x79e/0xc60
>>>>    ____sys_sendmsg+0x95a/0xc20
>>>>    ___sys_sendmsg+0xee/0x170
>>>>    __sys_sendmsg+0xc6/0x170
>>>>   do_syscall_64+0x58/0x80
>>>>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>>>
>>>> The first command creates per TX queue pfifo qdiscs in
>>>> tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
>>>> via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().
>>>
>>> Not exactly; it grafts pfifo to direct queues only. htb_attach_offload
>>> explicitly grafts noop to all the remaining queues.
>>
>> num_direct_qdiscs == real_num_tx_queues:
>>
>> https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L1101
>>
>> pfifo will be configured on all the TX queues available at TC creation
>> time, right?
> 
> Yes, all real TX queues will be used as direct queues (for unclassified
> traffic). num_tx_queues should be somewhat bigger than
> real_num_tx_queues - it should reserve a queue per potential leaf class.
> 
> pfifo is configured on direct queues, and the reserved queues have noop.
> Then, when a new leaf class is added (TC_HTB_LEAF_ALLOC_QUEUE), the
> driver allocates a new queue and increases real_num_tx_queues. HTB
> assigns a pfifo qdisc to the newly allocated queue.
> 
> Changing the hierarchy (deleting a node or converting an inner node to a
> leaf) may reorder the classful queues (with indexes >= the initial
> real_num_tx_queues), so that there are no gaps.
> 
>> Lacking a mlx card with offload support I hack basic htb support in
>> netdevsim and I observe the splat on top of such device. I can as well
>> share the netdevsim patch - it will need some clean-up.
> 
> I will be happy to review the netdevsim patch, but I don't promise
> prompt responsiveness.
> 
>>>
>>>> When the command completes, the qdisc_sleeping for each dev_queue is a
>>>> pfifo one. The next class creation will trigger the reported splat.
>>>>
>>>> Address the issue taking care of old non-builtin qdisc in
>>>> htb_change_class().
>>>>
>>>> Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>>   net/sched/sch_htb.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
>>>> index 0d947414e616..dc682bd542b4 100644
>>>> --- a/net/sched/sch_htb.c
>>>> +++ b/net/sched/sch_htb.c
>>>> @@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
>>>>   				qdisc_refcount_inc(new_q);
>>>>   			}
>>>>   			old_q = htb_graft_helper(dev_queue, new_q);
>>>> -			/* No qdisc_put needed. */
>>>> -			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
>>>> +			qdisc_put(old_q);
>>>
>>> We can get here after one of two cases above:
>>>
>>> 1. A new queue is allocated with TC_HTB_LEAF_ALLOC_QUEUE. It's supposed
>>> to have a noop qdisc by default (after htb_attach_offload).
>>
>> So most likely the trivial netdevsim implementation I used was not good
>> enough.
>>
>> Which constrains should respect TC_HTB_LEAF_ALLOC_QUEUE WRT the
>> returned qid value? should it in the (real_num_tx_queues,
>> num_tx_queues] range?
> 
> Let's say N is real_num_tx_queues as it was at the moment of attaching.
> HTB queues should be allocated from [N, num_tx_queues), and
> real_num_tx_queues should be increased accordingly. It should not return
> queues number [0, N).
> 
> Deletions should fill the gaps: if queue X is being deleted, N <= X <
> real_num_tx_queues - 1, then the gap should be filled with queue number
> real_num_tx_queues - 1 by swapping the queues (real_num_tx_queues will
> be decreased by 1 accordingly). Some care also needs to be taken when
> converting inner-to-leaf (TC_HTB_LEAF_DEL_LAST) and leaf-to-inner (it's
> better to get insights from [1], there are also some comments).
> 
>> Can HTB actually configure H/W shaping on
>> real_num_tx_queues?
> 
> It will be on real_num_tx_queues, but after it's increased to add new
> HTB queues. The original queues [0, N) are used for direct traffic, same
> as the non-offloaded HTB's direct_queue (it's not shaped).
> 
>> I find no clear documentation WRT the above.
> 
> I'm sorry for the lack of documentation. All I have is the commit
> message [2] and a netdev talk [3]. Maybe the slides could be of some
> use...
> 
> I hope the above explanation clarifies something, and feel free to ask
> further questions, I'll be glad to explain what hasn't been documented
> properly.

We would like to enable Tx rate limiting using htb offload on all the 
existing queues. We are able to do with the following set of commands 
with Paolo's patch

tc qdisc add dev enp175s0v0 handle 1: root htb offload
tc class add dev enp175s0v0 parent 1: classid 1:1 htb rate 1000mbit ceil 
2000mbit burst 100k

where
   classid 1:1 is tx queue0
   tx_minrate is rate 1000mbps
   tx_maxrate is ceil 2000mbps


In order to not break your implementation could bring in if condition 
instead WARN_ON, something like below
	if (!(old_q->flags & TCQ_F_BUILTIN))
		qdisc_put(old_q);

Would this work for you, please advise.

