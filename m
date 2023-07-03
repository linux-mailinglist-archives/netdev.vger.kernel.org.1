Return-Path: <netdev+bounces-15179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EDA7460FA
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9C1C209EF
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273FE100D6;
	Mon,  3 Jul 2023 16:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10998100B9
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 16:52:23 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813B4E58
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688403142; x=1719939142;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dNfQe0//y2e3ZkkaYgshOQMsLdeZo7FVxYF8proiVbo=;
  b=AgRwLvXR7GPakyuGyO8Seg3DfKoHBOTlG3wVIar1HK+fSc1G4OdoJVUS
   yXD2LtUuIETvBVvNTIVqQY2rMTJBu90GrR6AuPVSFxsCRyk76x7IcyZ7g
   o9RgdyNUJ/F3GGiMXNToWWtO42kTiFAkasBqSfAIKh1AQ9XCn4OyjhuzN
   qFk8AKcaBx8qR49D5nYjfCJJUABRlF5gosQetL1v2JWeUXTr5w+Y54U5C
   R1DHL0i8X85dy/c9unoymkrlmbZs0KKbPEefVGZc2VuIR2s1/VuG5r0CB
   zXSS2uSzYThr/01YICxr635qn9mQiKfcQ/ihrVdfFYNTTXx5zpNWESVP9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="366410760"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="366410760"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 09:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831887540"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831887540"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 09:52:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 09:52:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 09:52:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 09:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpS/SbgylqJj2/MANL8xOG/4O5gziuDeWYOn9GLWctluqRFVRDOPQhf8qwJcDKcX36eg+mt2nvC2DMI5TjIc7h94injIvCIuOFv2n0fH5Pls1lCSMOYzoj1a/LxcmIQHmxtAqONmsK2PKC+2+70366PTavlHMKU0xeGgc4gceiLUrHFHaReOI5KG9/2DrRPvKBAu+Brvamuv8mODmmwhkrjQOzkvgZzHjQTnhZDhSAhqlkWsxcMgKGiK/qsdrDErQQ5B8v80PBf/7MGi6rCsXjii0fd5A7smrUQ5+jZaXMycsExBPM9aALphhvFzqrau52kzMNXCvMyIQZJ+sAT9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq85KTBdPljurDoAeDcUuTYvn/jf3g6EucIgJuLjEeM=;
 b=JhEcxGcrLgSl4SMhMT7LVBQJIYAnxOqQe8gnJXfIRjBRif3b3MFFC7c6kqsBw1IZpz0XxNoD8Ddg5qwwcVccI8zU0i07IXJUF642J4ukOEvigCHWbqxWpjYJoehUHG94uS61ZHXpW/tY4OR9ZqJBozk1IMi9R4hcwZxlwrgS/z2fRRqtX77/WOHI13Xl2hZ0FrJEu1SIokFOeyfUY2f7OaHL1FNrlI40Sme/YvXDYknQtFzj4NJJegaZggLaljzwWlfeVm289IGM9sv8DxsVQRFsf07f6L49yAHWXZkVhMsthSCtX0Zc5qMnca+3CAU271G4AEZ0lxdps7V5XxsCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 16:52:17 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::82b6:7b9d:96ce:9325%7]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 16:52:17 +0000
Message-ID: <f25406bd-71b5-79e4-80f7-66c345341504@intel.com>
Date: Mon, 3 Jul 2023 18:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] tcp: Make GRO completion function inline
Content-Language: en-US
To: Michael Chan <michael.chan@broadcom.com>, Parav Pandit <parav@nvidia.com>
CC: <aelior@marvell.com>, <skalluru@marvell.com>, <manishc@marvell.com>,
	<netdev@vger.kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>
References: <20230611140756.1203607-1-parav@nvidia.com>
 <CACKFLi=nD76sHPFALg8dzR6Oj2CDGsZqbjY1gS_9ZKdo-KJrHQ@mail.gmail.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CACKFLi=nD76sHPFALg8dzR6Oj2CDGsZqbjY1gS_9ZKdo-KJrHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: fa54d706-4a47-47ab-f326-08db7be5dbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9C12MkeXZl4tovdgdVrQzIxpOZrPlIKnOAYaTTaY9+mevZVQtBYAhvvwQ1b6hF6x0QDa2YWYtEaacQ63fOCZ7zlceCDXselTW7NtoolQL5zkExrPFFzuXqaRImoFZClDCUZms4OyAAKZQ1Ejce/uwVlDOgtbwVMAhzyo1LGRw0bTEwq3ZAMJmgsCHD22Sjt5C3Sfe6geipnC6/0hhbM/AtextbcX9x89cf/RZCYIXlrunDu+QFtyUG6vRPTk850mbHe8GR3v55v72JqWCLkWB6aKQteQpyw5hbkpL9ZvVj0lr8hBfnQYICLzPLlFHuIBrRGVEl4vJQ506xJpM9UPbjDdXAxmex4t3lSOgIycszxAi7t2aozWi/1n71+OsGB1h7Ucq1AUbLj4kuiTPXH+pq3OwvMHi0vzYJJdKbqT5b89BQeKFs68AWiDA2pgD1CsuE3TvCL4p13dRdSm1cz3ENtwecCbTLrOhV+dMWchs80YcTB0B8grgbYGiBGRMWi7JbfpRi2a9vzSAZDSO26xPOXFAF2V2Afw2x7sXuIefZOzpNYj0r9lmzqnbSvXeehQaQ/D1p1izRKlh0VHvUZHFe0/OZdxyapOceWMiAHGWgfgW51aKGLHncdcxz8rMgI6FOzG37jWLb/DeUlkJlKPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(110136005)(2906002)(478600001)(26005)(41300700001)(6666004)(6486002)(86362001)(36756003)(8936002)(8676002)(31686004)(31696002)(5660300002)(7416002)(316002)(6512007)(66946007)(66556008)(66476007)(38100700002)(4326008)(82960400001)(53546011)(6506007)(2616005)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9KNCtHNU1kaHZqWmFLY1ZKVGxoNDhDc21nS09ZdVBRNUJrZVBNdXNodHgx?=
 =?utf-8?B?L2wzb2Z3dzJKMHhIOFRGQjZ4eHBzdjNJbWxlQVVhY3FlOUtGMTRGUG93dFNZ?=
 =?utf-8?B?Sk81T2czMml2QU1OUDdPczYxemJMc3N5R3pwTFd1UkVDanFnekJHSUtJOVdM?=
 =?utf-8?B?L2xEL2VFUzdDS1hQeHhhdjlPUlVtY0dxTUx0eTUwdGxXeXJQUW9ncUJCMUNI?=
 =?utf-8?B?blNNMHRzcXdLNkpzdWIwc2xHSW5aaXNSRUtxMlZSU0xyNFVybWRNRG1vbE9s?=
 =?utf-8?B?MVk4MWtJc1E3YTAveXlGbWtsNmV2dFdVYWdLejdJT3ZoM0g2dUtReWlRajhB?=
 =?utf-8?B?MTRWMW02YXNRZVVjVlNKWEg4ek1WL0d1emdINFB3ZTJSczcvTmQwaUFjWVpy?=
 =?utf-8?B?VmZQY2JLa3F3MXJNZHJnMW96SGYrUERqUTA1RzhOM1MvQjNaNTl4K3lhQUhm?=
 =?utf-8?B?ODZrdWVhL3ZKbG4wNE42M09RSmxHTW5hWWZzaStSZkZ1L20zV0xhZjdnYVZ1?=
 =?utf-8?B?cXRVQXI4MXYzR09zS2hNSlRRUFZNaFVsVlZVL0JiVnRNem5JSjd4K3IrTEky?=
 =?utf-8?B?SnZreUVYamtXSnVYcENxQWY5WVhuTG1UZkMrbWNBUWFnWENUL1MyRlFsRjNW?=
 =?utf-8?B?OFNob29JMTVya04yTHcrUWVFQTJXMXFVbldJc1piSWwrV2JCdldoazNVRXhK?=
 =?utf-8?B?QndaK2g3aW51Vkc2TjlpNlI1UmtpS2JFcm1sNkkxd0E3cGFneG9lR093Q3h2?=
 =?utf-8?B?Ny9aNHJuclVpZDlFbnJ2WEhuWGszQThqNmpaZ24xWlN6bk1XQmJjZVlocngw?=
 =?utf-8?B?ME9hUVBQdDV3eUxldXNiWjE3aURrQXVneVB3OExUNmo5bkoxMEY5SEd5VmFD?=
 =?utf-8?B?MTFVUlYwTDNqOHROS1g1NmhlUHk5Y3hrb3I3Wk1adjBoRk1BeC9aMlpydUxl?=
 =?utf-8?B?K3pPSG1ZMGFJSlJqZnZoMytnblV4SFNCRlorQVVRbHdISkxhWWRzU0ZmVzRF?=
 =?utf-8?B?V3g5ZHdjY2xPZGhWd0RFL2tsODFRMEpIRzR4bE1Bbi93K3krMWhZT2JCRlpy?=
 =?utf-8?B?SUttMHFZbEVXS0hPM0FaeG1vUlN0RGtzV1JWU3dNNVRSRjRiVGE3a0lvR1ZL?=
 =?utf-8?B?M3pwaU5Iczd1VVpUUStKRHBOMGRnMGtvU2cvaUhNYnM2RXN0ZStWbWJyZDl1?=
 =?utf-8?B?Lyt6WmVSMTk2Wmh3SUhRRkdlVllONTU5amhnaU5pQVk3eXo1cEdOSDlHdnYr?=
 =?utf-8?B?TmlHWWtlZjI4b3ZjNGNBa2NOOTh3emhjVG5oVytzUklsM0xNUFJFL2xTWkQv?=
 =?utf-8?B?Sk9la0NyMVNmVmdKU1B1YlVWVFdmNlhBVmVvQVc3akN4bDQ1OVU5RXoxYTYw?=
 =?utf-8?B?SVQ1VW01Ykk0bFNwc1lLdUs0OTVwOWpGNUhyUHNnTjZoNjkrUFdZN3dQNk9F?=
 =?utf-8?B?dXM0QlViM0I5cS9aSEN1eXIxcXptZlBXWEpNaEJrWVRzc0hTR2RMejVucHNk?=
 =?utf-8?B?Z0V6Kzkzd01MNFppZjNQVkhuNDVmY2pESE5rWjVrMnJ0ZDI1ODFhSjFsbDJF?=
 =?utf-8?B?T2Z3WGdUdmE3ZC8zcEx0dVJNbzE1WjJqSGZ3UkhhN2dVUzQzV1plZDFEZWJ5?=
 =?utf-8?B?UzlzTjJFNzBGNTNhN2FwMWMzMnVGZm51TGpCOXJSamFWcDlDUXdMUmducmNm?=
 =?utf-8?B?SEhVaSt5b2FxMGQxQWNXb3ZRL0FJejVtQlJlcDl0M1cyVGk1cFFFRFRISGFO?=
 =?utf-8?B?SDYzTDE4NEVhclV3cjhrUms4aHdIMmpxd0s3QjloWGdNbUhxdWc4VnFrWVV5?=
 =?utf-8?B?R2lhYjJzNjlJYjFTNW1qTU5QVVRJdW5FQmoyeHVqNGV1V2w1bldZUWdPVExB?=
 =?utf-8?B?UWVGZFZzVTNaMC9MQlJ3U0M2bk5vUmlPeTdjL0IvZXVoL05YOGIyV0dONGZM?=
 =?utf-8?B?UkMwdERjV1Z1N241OHhvancweTNkdHBtZlJ5Y3lTWGlLMmY4VjkvY2VVdDhh?=
 =?utf-8?B?QUUrTVpzUmNaMm1Rc0YxWjdhR1Y0Zm1WYnFMZGxLYU9HZEVNMmFpRnppbDJY?=
 =?utf-8?B?MGUzSUp1YjVjVk9FYWFSbUlJNzBibXpBMHlTd0MxMzI2TUJHWXVwRTJlTkxG?=
 =?utf-8?B?RlljcGp2TldnZ1ZMYUJnT3hoc09kVG5ZTDhDOTVKTlpxYUpZY0wvcDNhbm5Z?=
 =?utf-8?Q?19NL1CWxEsax5uGka9tV1pQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa54d706-4a47-47ab-f326-08db7be5dbe3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 16:52:17.2325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG7WeytSTNE8v0m4fr2OJatE3ao7RxGYGli2J9U11zHw+9exC+ZZ7UitVMlZ9MdSOHVUXcEw5iqf00Gw6RRA2RwsnXlaA9ylC/RRjWWShHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michael Chan <michael.chan@broadcom.com>
Date: Sat, 1 Jul 2023 16:09:53 -0700

> On Sun, Jun 11, 2023 at 7:08 AM Parav Pandit <parav@nvidia.com> wrote:
>>
>> At 100G link speed, with 1500 MTU, at 8.2 mpps, if device does GRO for
>> 64K message size, currently it results in ~190k calls to
>> tcp_gro_complete() in data path.
>>
>> Inline this small routine to avoid above number of function calls.
>>
>> Suggested-by: David Ahern <dsahern@kernel.org>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
>>
>> ---
>> This patch is untested as I do not have the any of the 3 hw devices
>> calling this routine.
>>
>> qede, bnxt and bnx2x maintainers,
>>
>> Can you please verify it with your devices if it reduces cpu
>> utilization marginally or it stays same or has some side effects?
>>
>> ---
> 
> Sorry for the delay.  It works fine on bnxt NICs running hardware GRO.
> No noticeable changes in throughput or CPU utilization running simple
> netperf.  Thanks.
> 
> Tested-by: Michael Chan <michael.chan@broadcom.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Why is this needed then if it gives nothing? :D

Thanks,
Olek

